#
# Copyright (C) 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Use the non-open-source parts, if they're present
include vendor/nvidia/jetson/BoardConfigVendor.mk

BOARD_SUPPORT_NVOICE := true

BOARD_SUPPORT_NVAUDIOFX :=true


# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif

TARGET_BOARD_PLATFORM := tegra
TARGET_TEGRA_VERSION := t124
TARGET_TEGRA_FAMILY := t12x
TARGET_BOOTLOADER_BOARD_NAME := jetson

# CPU options
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a15
TARGET_CPU_SMP := true

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BLUETOOTH_HCI_USE_USB := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/nvidia/jetson/bluetooth

BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_iwlwifi
BOARD_WLAN_DEVICE           := iwlwifi
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_HOSTAPD_PRIVATE_LIB   := lib_driver_cmd_iwlwifi

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

TARGET_BOARD_INFO_FILE := device/nvidia/jetson/board-info.txt
TARGET_BOOTLOADER_BOARD_NAME := jetson

# FS
TARGET_COPY_OUT_VENDOR := vendor
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_USERDATAIMAGE_PARTITION_SIZE  := 13090422784
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1342177280
BOARD_VENDORIMAGE_PARTITION_SIZE := 419430400
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 805306368
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

# Graphics
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 1
USE_OPENGL_RENDERER := true

# UBOOT/XLOADER
TARGET_USE_XLOADER := false
TARGET_USE_UBOOT := false
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_TYPE := fastboot

# KERNEL (LINARO TASK SETTINGS)
#TARGET_NO_KERNEL = false
TARGET_KERNEL_SOURCE := kernel/tegra
TARGET_KERNEL_APPEND_DTB := true
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
TARGET_KERNEL_CONFIG :=  cyanogenmod_jetson_defconfig
TARGET_KERNEL_HAVE_EXFAT = true
TARGET_KERNEL_HAVE_NTSF = true
BUILD_KERNEL_MODULES := true
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := androidboot.hardware=jetson vmalloc=384M androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x01000000 --ramdisk_offset 0x02100000 --tags_offset 0x02000000

# powerhal
BOARD_USES_POWERHAL := true

# Use CMU-style config with Nvcms
NVCMS_CMU_USE_CONFIG := true

# BOARD_WIDEVINE_OEMCRYPTO_LEVEL
# The security level of the content protection provided by the Widevine DRM plugin depends
# on the security capabilities of the underlying hardware platform.
# There are Level 1/2/3. To run HD contents, should be Widevine level 1 security.
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 1

# Using the NCT partition
TARGET_USE_NCT := false
# LBH related defines
# use LBH partition and resources in it
BOARD_HAVE_LBH_SUPPORT := false

# board specific sepolicy
# BOARD_SEPOLICY_DIRS := device/nvidia/jetson/sepolicy

# SELinux
# BOARD_SEPOLICY_DIRS += device/nvidia/shieldtablet/sepolicy
# BOARD_SEPOLICY_UNION += \
        te_macros \
        agpsd.te \
        app.te \
        bluetooth.te \
        bootanim.te \
        cvc.te \
        device.te \
        domain.te \
        drmserver.te \
        fild.te \
        file_contexts \
        file.te \
        genfs_contexts \
        gpload.te \
        gpsd.te \
        healthd.te\
        hostapd.te \
        icera-crashlogs.te \
        icera-feedback.te \
        icera-loader.te \
        icera-switcherd.te \
        init.te \
        installd.te \
        mediaserver.te \
        mock_modem.te \
        netd.te \
        platform_app.te \
        property_contexts \
        property.te \
        raydium.te \
        recovery.te \
        service.te \
        service_contexts \
        set_hwui.te \
        shell.te \
        surfaceflinger.te \
        system_app.te \
        system_server.te \
        tee.te \
        ueventd.te \
        untrusted_app.te \
        usb.te \
        ussrd.te \
        ussr_setup.te \
        vold.te \
        wifi_loader.te \
	wpa.te \
	zygote.te

# TWRP Recovery
DEVICE_RESOLUTION := 1920x1200
RECOVERY_VARIANT := twrp
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD -DDISABLE_ASHMEM_TRACKING
TARGET_RECOVERY_DEVICE_DIRS += device/nvidia/jetson
TARGET_RECOVERY_FSTAB := device/nvidia/jetson/fstab.jetson
TW_THEME := landscape_hdpi
RECOVERY_GRAPHICS_USE_LINELENGTH := true
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TW_NO_SCREEN_TIMEOUT := true
TW_NO_CPU_TEMP := true

BOARD_HAL_STATIC_LIBRARIES := libdumpstate.jetson libhealthd.jetson

ART_USE_HSPACE_COMPACT=true

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

MALLOC_IMPL := dlmalloc

BOARD_USES_GENERIC_INVENSENSE := false
