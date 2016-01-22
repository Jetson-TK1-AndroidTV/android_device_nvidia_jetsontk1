# Inherit device configuration for jetson.
$(call inherit-product, device/nvidia/jetson/full_jetson.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tv.mk)

TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920
PRODUCT_RELEASE_NAME := jetson

PRODUCT_NAME := cm_jetson
PRODUCT_DEVICE := jetson
PRODUCT_MODEL := SHIELD Android TV
PRODUCT_BRAND := NVIDIA
PRODUCT_MANUFACTURER := NVIDIA

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=jetson \
    TARGET_DEVICE=jetson \
    BUILD_FINGERPRINT="nvidia/jetson/jetson:5.0.2/LRX22G/1649326:user/release-keys" \
    PRIVATE_BUILD_DESC="jetson-user 5.0.2 LRX22G 1649326 release-keys"
