#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    "device/xiaomi/fog",
    "hardware/google/interfaces",
    "hardware/google/pixel",
    "hardware/lineage/interfaces/power-libperfmgr",
    "hardware/qcom-caf/bootctrl",
    "hardware/qcom-caf/common/libqti-perfd-client",
    "hardware/qcom-caf/sm8250",
    "hardware/qcom-caf/wlan",
    "hardware/xiaomi",
    "vendor/qcom/opensource/commonsys/display",
    "vendor/qcom/opensource/commonsys-intf/display",
    "vendor/qcom/opensource/data-ipa-cfg-mgr-legacy-um",
    "vendor/qcom/opensource/dataservices",
    "vendor/qcom/opensource/display",
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f"{lib}_{partition}" if partition == "vendor" else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        "com.qualcomm.qti.dpm.api@1.0",
        "libmmosal",
        "vendor.qti.hardware.fm@1.0",
        "vendor.qti.imsrtpservice@3.0",
    ): lib_fixup_vendor_suffix,
    (
        "libgrallocutils",
        "libOmxCore",
        "libwpa_client",
    ): lib_fixup_remove,
}

blob_fixups: blob_fixups_user_type = {
    'vendor/etc/init/vendor.sensors.sscrpcd.rc': blob_fixup()
        .regex_replace(r'class early_hal', 'class core'),
    'vendor/etc/seccomp_policy/atfwd@2.0.policy': blob_fixup()
        .add_line_if_missing('gettid: 1'),
    'vendor/lib64/camera/components/com.qti.node.mialgocontrol.so': blob_fixup()
        .strip_debug_sections()
        .add_needed('libpiex_shim.so'),
    'vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so': blob_fixup()
        .sig_replace('13 0A 00 94', '1F 20 03 D5'),
    ('vendor/lib64/libwvhidl.so', 'vendor/lib64/mediadrm/libwvdrmengine.so'): blob_fixup()
        .add_needed('libcrypto_shim.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    "fog",
    "xiaomi",
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == "__main__":
    utils = ExtractUtils.device(module)
    utils.run()
