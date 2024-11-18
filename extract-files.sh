#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=fog
VENDOR=xiaomi

export DEVICE_BRINGUP_YEAR=2022

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

export TARGET_ENABLE_CHECKELF=true

# If XML files don't have comments before the XML header, use this flag
# Can still be used with broken XML files by using blob_fixup
export TARGET_DISABLE_XML_FIXING=true

# Define the default patchelf version used to patch blobs
# This will also be used for utility functions like FIX_SONAME
# Older versions break some camera blobs for us
export PATCHELF_VERSION=0_17_2

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

SECTION=
KANG=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-common)
            ONLY_COMMON=true
            ;;
        --only-firmware)
            ONLY_FIRMWARE=true
            ;;
        --only-target)
            ONLY_TARGET=true
            ;;
        -n | --no-cleanup)
            CLEAN_VENDOR=false
            ;;
        -k | --kang)
            KANG="--kang"
            ;;
        -s | --section)
            SECTION="${2}"
            shift
            CLEAN_VENDOR=false
            ;;
        *)
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so)
            [ "$2" = "" ] && return 0
            "${SIGSCAN}" -p "13 0A 00 94" -P "1F 20 03 D5" -f "${2}"
            ;;
        vendor/lib64/camera/components/com.qti.node.mialgocontrol.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --add-needed "libpiex_shim.so" "${2}"
            ;;
        vendor/lib64/vendor.silead.hardware.fingerprintext@1.0.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libhidlbase.so" "${2}"
            sed -i "s/libhidltransport.so/libhidlbase-v32.so\x00/" "${2}"
            ;;
        vendor/lib64/com.fingerprints.extension@1.0.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --remove-needed "libhidlbase.so" "${2}"
            sed -i "s/libhidltransport.so/libhidlbase-v32.so\x00/" "${2}"
            ;;
        vendor/lib64/libwvhidl.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --add-needed "libcrypto_shim.so" "${2}"
            ;;
        vendor/lib64/mediadrm/libwvdrmengine.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --add-needed "libcrypto_shim.so" "${2}"
            ;;
        vendor/etc/init/vendor.sensors.sscrpcd.rc)
            [ "$2" = "" ] && return 0
            sed -i 's|class early_hal|class core|g' "${2}"
            ;;
        vendor/etc/seccomp_policy/atfwd@2.0.policy)
            [ "$2" = "" ] && return 0
            echo 'gettid: 1' >> ${2}
            ;; 
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# Initialize the helper for common device
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" \
        "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
