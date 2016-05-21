/*
 * Copyright (C) 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <dirent.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
//#define LOG_NDEBUG 0

#define LOG_TAG "JetsonPowerHAL"
#include <utils/Log.h>

#include <hardware/hardware.h>
#include <hardware/power.h>

#define BOOSTPULSE_PATH     "/sys/devices/system/cpu/cpufreq/interactive/boostpulse"
#define CPU_MAX_FREQ_PATH   "/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"
#define GPU_BOOST_PATH      "/dev/constraint_gpu_freq"
#define IO_IS_BUSY_PATH     "/sys/devices/system/cpu/cpufreq/interactive/io_is_busy"
#define LOW_POWER_MAX_FREQ  "800000"
#define NORMAL_MAX_FREQ     "2320500"
#define GPU_FREQ_CONSTRAINT "852000 852000 -1 2000"

struct jetson_power_module {
    struct power_module base;
    pthread_mutex_t lock;
    int boostpulse_fd;
    int boostpulse_warned;
};

static bool low_power_mode = false;

static void sysfs_write(const char *path, char *s)
{
    char buf[80];
    int len;
    int fd = open(path, O_WRONLY);

    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);
        return;
    }

    len = write(fd, s, strlen(s));
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);
    }

    close(fd);
}

static void power_init(struct power_module __unused *module)
{
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay", "19000");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration", "80000");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load",     "99");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq",        NORMAL_MAX_FREQ);
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/io_is_busy", "0");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/min_sample_time",     "80000");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/target_loads",        "65 228000:75 624000:85");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/timer_rate",          "20000");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/timer_slack",         "80000");

}

static void power_set_interactive(struct power_module __unused *module, int on)
{
    ALOGV("power_set_interactive: %d\n", on);

    /*
     * Lower maximum frequency when screen is off.
     */
    sysfs_write(CPU_MAX_FREQ_PATH, (!on || low_power_mode) ? LOW_POWER_MAX_FREQ : NORMAL_MAX_FREQ);
    sysfs_write(IO_IS_BUSY_PATH, on ? "1" : "0");

    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay", (on == 0)?"80000":"19000");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/target_loads", (on == 0)?"80":"65 228000:75 624000:85");
    sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/timer_rate", (on == 0)?"300000":"20000");
    sysfs_write("/sys/devices/platform/host1x/nvavp/boost_sclk", (on == 0)?"0":"1");

    ALOGV("power_set_interactive: %d done\n", on);
}

static int boostpulse_open(struct jetson_power_module *jetson)
{
    char buf[80];
    int len;
    static int gpu_boost_fd = -1;

    pthread_mutex_lock(&jetson->lock);

    if (jetson->boostpulse_fd < 0) {
        jetson->boostpulse_fd = open(BOOSTPULSE_PATH, O_WRONLY);

        if (jetson->boostpulse_fd < 0) {
            if (!jetson->boostpulse_warned) {
                strerror_r(errno, buf, sizeof(buf));
                ALOGE("Error opening %s: %s\n", BOOSTPULSE_PATH, buf);
                jetson->boostpulse_warned = 1;
            }
        }
    }
    {
        if ( gpu_boost_fd == -1 )
            gpu_boost_fd = open(GPU_BOOST_PATH, O_WRONLY);

        if (gpu_boost_fd < 0) {
            strerror_r(errno, buf, sizeof(buf));
            ALOGE("Error opening %s: %s\n", GPU_BOOST_PATH, buf);
        } else {
            len = write(gpu_boost_fd, GPU_FREQ_CONSTRAINT,
                        strlen(GPU_FREQ_CONSTRAINT));
            if (len < 0) {
                strerror_r(errno, buf, sizeof(buf));
                ALOGE("Error writing to %s: %s\n", GPU_BOOST_PATH, buf);
            }
        }
    }

    pthread_mutex_unlock(&jetson->lock);
    return jetson->boostpulse_fd;
}

static void jetson_power_hint(struct power_module *module, power_hint_t hint,
                                void *data)
{
    struct jetson_power_module *jetson =
            (struct jetson_power_module *) module;
    char buf[80];
    int len;

    switch (hint) {
     case POWER_HINT_INTERACTION:
        if (boostpulse_open(jetson) >= 0) {
            len = write(jetson->boostpulse_fd, "1", 1);

            if (len < 0) {
                strerror_r(errno, buf, sizeof(buf));
                ALOGE("Error writing to %s: %s\n", BOOSTPULSE_PATH, buf);
            }
        }

        break;

   case POWER_HINT_VSYNC:
        break;

    case POWER_HINT_LOW_POWER:
        pthread_mutex_lock(&jetson->lock);
        if (data) {
            sysfs_write(CPU_MAX_FREQ_PATH, LOW_POWER_MAX_FREQ);
        } else {
            sysfs_write(CPU_MAX_FREQ_PATH, NORMAL_MAX_FREQ);
        }
        low_power_mode = data;
        pthread_mutex_unlock(&jetson->lock);
        break;

    default:
            break;
    }
}

static struct hw_module_methods_t power_module_methods = {
    .open = NULL,
};

struct jetson_power_module HAL_MODULE_INFO_SYM = {
    base: {
        common: {
            tag: HARDWARE_MODULE_TAG,
            module_api_version: POWER_MODULE_API_VERSION_0_2,
            hal_api_version: HARDWARE_HAL_API_VERSION,
            id: POWER_HARDWARE_MODULE_ID,
            name: "Jetson Power HAL",
            author: "The Android Open Source Project",
            methods: &power_module_methods,
        },

        init: power_init,
        setInteractive: power_set_interactive,
        powerHint: jetson_power_hint,
    },

    lock: PTHREAD_MUTEX_INITIALIZER,
    boostpulse_fd: -1,
    boostpulse_warned: 0,
};
