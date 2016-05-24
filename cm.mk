# Inherit device configuration for jetson.
$(call inherit-product, device/nvidia/foster/full_foster.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tv.mk)

TARGET_SCREEN_HEIGHT := 1080
TARGET_SCREEN_WIDTH := 1920
PRODUCT_RELEASE_NAME := foster_e

PRODUCT_NAME := cm_foster
PRODUCT_DEVICE := foster
PRODUCT_MODEL := SHIELD Android TV
PRODUCT_BRAND := NVIDIA
PRODUCT_MANUFACTURER := NVIDIA
