/*
 * Copyright (C) 2014 The Android Open Source Project
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

#define LOG_TAG "healthd-jetson"
#include <healthd.h>
#include <cutils/klog.h>
#include <sys/types.h>
#include <sys/sysinfo.h>

using namespace android;

int healthd_board_battery_update(struct BatteryProperties *props)
{
    props->batteryStatus = BATTERY_STATUS_UNKNOWN;
    props->batteryHealth = BATTERY_HEALTH_GOOD;
    props->batteryTechnology = "Li-ion";
    props->batteryPresent = false;
    props->chargerAcOnline = true;

    // return 0 to log periodic polled battery status to kernel log
    return 0;
}

void healthd_board_init(struct healthd_config *config)
{
    KLOG_INFO(LOG_TAG, "Missing battery, using fake battery data\n");
}
