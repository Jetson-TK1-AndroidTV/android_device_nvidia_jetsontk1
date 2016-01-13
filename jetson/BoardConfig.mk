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
include vendor/nvidia/shieldtablet/BoardConfigVendor.mk

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

# AUDIO LIBAUDIO
# BOARD_USES_ALSA_AUDIO := true
# BOARD_USES_TINY_ALSA_AUDIO := true

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true

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

USE_E2FSPROGS := true
USE_OPENGL_RENDERER := true

# UBOOT/XLOADER
TARGET_USE_XLOADER := false
TARGET_USE_UBOOT := false
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_TYPE := fastboot

# KERNEL (LINARO TASK SETTINGS)
#TARGET_NO_KERNEL := false
TARGET_KERNEL_SOURCE := kernel/tegra
TARGET_KERNEL_APPEND_DTB := true
KERNEL_CONFIG :=  tegra12_android_hdmi-primary_defconfig
BUILD_KERNEL_MODULES := true
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := androidboot.hardware=jetson vmalloc=384M androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x01000000 --ramdisk_offset 0x02100000 --tags_offset 0x02000000

# powerhal
BOARD_USES_POWERHAL := true

# NVDPS can be enabled when display is set to continuous mode.
BOARD_HAS_NVDPS := true

# Don't use Nvidia HDCP libs
BOARD_ENABLE_SECURE_HDCP := false

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
BOARD_SEPOLICY_DIRS := device/nvidia/jetson/sepolicy

BOARD_SEPOLICY_UNION := \
	bluetooth.te \
	device.te \
	drmserver.te \
	file.te \
	file_contexts \
	genfs_contexts \
	gpsd.te \
	kernel.te \
	kickstart.te \
	mediaserver.te \
	netd.te \
	netmgrd.te \
	qmuxd.te \
	radio.te \
	rild.te \
	surfaceflinger.te \
	system_server.te \
	tee.te \
	te_macros \
	touch_fusion.te

# Recovery
TARGET_RECOVERY_FSTAB = device/nvidia/jetson/fstab.jetson

BOARD_HAL_STATIC_LIBRARIES := libdumpstate.jetson libhealthd.jetson

ART_USE_HSPACE_COMPACT=true

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

MALLOC_IMPL := dlmalloc

BOARD_USES_GENERIC_INVENSENSE := false
