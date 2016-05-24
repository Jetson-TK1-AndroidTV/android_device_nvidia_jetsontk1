# Inherit device configuration for jetson.
$(call inherit-product, device/nvidia/foster/foster_e.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tv.mk)

PRODUCT_NAME := foster_e
PRODUCT_DEVICE := foster
PRODUCT_MODEL := SHIELD Android TV
PRODUCT_BRAND := NVIDIA
PRODUCT_MANUFACTURER := NVIDIA
