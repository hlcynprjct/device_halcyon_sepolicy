#
# This policy configuration will be used by all products that
# inherit from Lineage
#

ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/halcyon/sepolicy/common/public

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/halcyon/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/halcyon/sepolicy/common/dynamic \
    device/halcyon/sepolicy/common/system

ifneq ($(TARGET_HAL_POWER_RW_INPUT_DEVICE), true)
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += \
    device/halcyon/sepolicy/common/dynamic_extra
endif

else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/halcyon/sepolicy/common/dynamic \
    device/halcyon/sepolicy/common/dynamic_extra \
    device/halcyon/sepolicy/common/vendor
endif

# Selectively include legacy rules defined by the products
-include device/halcyon/sepolicy/legacy-common/sepolicy.mk

# Include atv rules on atv product
ifeq ($(PRODUCT_IS_ATV), true)
include device/halcyon/sepolicy/atv/sepolicy.mk
endif
