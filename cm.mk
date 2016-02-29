# Inherit device configuration for jetson.
$(call inherit-product, device/nvidia/jetson/jetson.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tv.mk)

TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920
PRODUCT_RELEASE_NAME := foster_e

PRODUCT_NAME := cm_jetson
PRODUCT_DEVICE := jetson
PRODUCT_MODEL := SHIELD Android TV
PRODUCT_BRAND := NVIDIA
PRODUCT_MANUFACTURER := NVIDIA
