/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <android-base/logging.h>
#include <android-base/properties.h>
#include <libinit_utils.h>

#include <libinit_variant.h>

using android::base::GetProperty;

#define HWC_PROP "ro.boot.hwc"
#define HWNAME_PROP "ro.boot.hwname"
#define HWVERSION_PROP "ro.boot.hwversion"
#define SKU_PROP "ro.boot.product.hardware.sku"

void search_variant(const std::vector<variant_info_t> variants) {
    std::string hwc_value = GetProperty(HWC_PROP, "");
    std::string hwrevision_value = GetProperty(HWVERSION_PROP, "");
    std::string hwname_value = GetProperty(HWNAME_PROP, "");

    for (const auto& variant : variants) {
        if ((variant.hwc_value == "" || variant.hwc_value == hwc_value) &&
            (variant.device == hwname_value || variant.device == hwrevision_value)) {
            set_variant_props(variant);
            break;
        }
    }
}

void set_variant_props(const variant_info_t variant) {
    set_ro_build_prop("brand", variant.brand, true);
    set_ro_build_prop("device", variant.device, true);
    set_ro_build_prop("model", variant.model, true);
    property_override("ro.boot.hardware.revision", variant.device, true);
    property_override("vendor.usb.product_string", variant.model, true);

    if (access("/system/bin/recovery", F_OK) != 0) {
        property_override("bluetooth.device.default_name", variant.model, true);
        set_ro_build_prop("fingerprint", variant.build_fingerprint);
        property_override("ro.bootimage.build.fingerprint", variant.build_fingerprint);

        property_override("ro.build.description", fingerprint_to_description(variant.build_fingerprint));
    }

    if (variant.nfc)
        property_override(SKU_PROP, "nfc");
}
