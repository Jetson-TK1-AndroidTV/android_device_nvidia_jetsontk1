# NVIDIA Tegra5 "Jetson" development system
#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.

## Common product locale
PRODUCT_LOCALES += en_US

# where the kernel is.
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/nvidia/jetson-kernel/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES := \
        $(LOCAL_KERNEL):kernel

## Common packages
$(call inherit-product-if-exists, vendor/nvidia/tegra/core/nvidia-tegra-vendor.mk)

# Need AppWidget permission to prevent from Launcher's crash.
# TODO(pattjin): Remove this when the TV Launcher is used, which does not support AppWidget.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayouts/ADT-1_Remote.kl:system/usr/keylayout/ADT-1_Remote.kl \
    $(LOCAL_PATH)/keylayouts/gpio-keypad.kl:system/usr/keylayout/gpio-keypad.kl \
    $(LOCAL_PATH)/keylayouts/Spike.kl:system/usr/keylayout/Spike.kl \
    $(LOCAL_PATH)/keylayouts/virtual-remote.kl:system/usr/keylayout/virtual-remote.kl \
    $(LOCAL_PATH)/keylayouts/gpio-keypad.idc:system/usr/idc/gpio-keypad.idc \
    $(LOCAL_PATH)/keylayouts/virtual-remote.idc:system/usr/idc/virtual-remote.idc \
    $(LOCAL_PATH)/keylayouts/gpio-keypad.kcm:system/usr/keychars/gpio-keypad.kcm \
    $(LOCAL_PATH)/keylayouts/virtual-remote.kcm:system/usr/keychars/virtual-remote.kcm \
    $(LOCAL_PATH)/keylayouts/Nexus_Remote.kl:system/usr/keylayout/Nexus_Remote.kl \
    $(LOCAL_PATH)/keylayouts/Vendor_20a0_Product_0001.kl:system/usr/keylayout/Vendor_20a0_Product_0001.kl \
    $(LOCAL_PATH)/keylayouts/Vendor_18d1_Product_2c40.kl:system/usr/keylayout/Vendor_18d1_Product_2c40.kl

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    $(LOCAL_PATH)/permissions/com.nvidia.nvsi.xml:system/etc/permissions/com.nvidia.nvsi.xml \
    $(LOCAL_PATH)/permissions/jetson_hardware.xml:system/etc/permissions/jetson_hardware.xml
	
# NVIDIA
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/com.nvidia.blakemanager.xml:system/etc/permissions/com.nvidia.blakemanager.xml \
    $(LOCAL_PATH)/permissions/com.nvidia.feature.xml:system/etc/permissions/com.nvidia.feature.xml	

# HDMI
PRODUCT_PROPERTY_OVERRIDES += ro.hdmi.device_type=4

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/audio_policy.conf:system/etc/audio_policy.conf

# Bluetooth
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bdaddr:system/etc/bdaddr

LOCAL_FSTAB := $(LOCAL_PATH)/fstab.jetson
TARGET_RECOVERY_FSTAB = $(LOCAL_FSTAB)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.jetson.rc:root/init.jetson.rc \
    $(LOCAL_PATH)/init.jetson.usb.rc:root/init.jetson.usb.rc \
    $(LOCAL_PATH)/init.recovery.jetson.rc:root/init.recovery.jetson.rc \
    $(LOCAL_FSTAB):root/fstab.jetson \
    $(LOCAL_PATH)/ueventd.jetson.rc:root/ueventd.jetson.rc

## REFERENCE_DEVICE
REFERENCE_DEVICE := ardbeg


# TV-specific Apps/Packages
PRODUCT_PACKAGES += \
    TvProvider \
    TvSettings \
    tv_input.default

PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    com.android.location.provider

# Filesystem management tools
PRODUCT_PACKAGES += \
    setup_fs \
    e2fsck

# basic lights HAL
PRODUCT_PACKAGES += \
    lights.jetson

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audioConfig_qvoice_icera_pc400.xml:system/etc/audioConfig_qvoice_icera_pc400.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/nvaudio_conf.xml:system/etc/nvaudio_conf.xml \
    $(LOCAL_PATH)/audio/nvaudio_fx.xml:system/etc/nvaudio_fx.xml

PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler \
    libaudiospdif \
    libtinyalsa \
    libtinycompress \
    tinycap \
    tinymix \
    tinyplay \
    xaplay

PRODUCT_PROPERTY_OVERRIDES += wifi.interface=wlan0

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072 \
    ro.sf.lcd_density=320

#ENABLE_WIDEVINE_DRM := true
ifeq ($(ENABLE_WIDEVINE_DRM),true)
#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libwvdrmengine \
    libwvm \
    libWVStreamControlAPI_L3 \
    libwvdrm_L3
endif

# NVIDIA hardware support
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.ussrd.rc:root/init.ussrd.rc \
    $(LOCAL_PATH)/ussr_setup.sh:system/bin/ussr_setup.sh \
    $(LOCAL_PATH)/ussrd.conf:system/etc/ussrd.conf \
    $(LOCAL_PATH)/set_hwui_params.sh:system/bin/set_hwui_params.sh \
    $(LOCAL_PATH)/power.ardbeg.rc:system/etc/power.ardbeg.rc \
    $(LOCAL_PATH)/nvcms/device.cfg:system/lib/nvcms/device.cfg \
    $(LOCAL_PATH)/graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml \
    $(LOCAL_PATH)/graphics/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml

# vendor HALs
PRODUCT_PACKAGES += \
    gralloc.tegra \
    hwcomposer.tegra \
    power.tegra

PRODUCT_PACKAGES += \
    lbh_images

# HDCP SRM Support
PRODUCT_PACKAGES += \
    hdcp1x.srm \
    hdcp2x.srm \
    hdcp2xtest.srm

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tv

# Set up device overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_AAPT_CONFIG := normal large xlarge hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# set default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp \
    ro.adb.secure=0

$(call inherit-product-if-exists, hardware/nvidia/tegra124/tegra124.mk)
$(call inherit-product-if-exists, vendor/nvidia/proprietary-tegra124/tegra124-vendor.mk)
$(call inherit-product-if-exists, vendor/nvidia/shieldtablet/shieldtablet-vendor.mk)
$(call inherit-product-if-exists, vendor/nvidia/shield_common/blake-blobs.mk)

