#!/bin/sh
# Launch zenoh-bridge-ros2dds, automatically picking up a user-provided config
# if present.
#
# Config discovery:
#   1. $SNAP_USER_COMMON/config.{json5,yaml,yml}  (user app; unset for daemon)
#   2. $SNAP_COMMON/config.{json5,yaml,yml}        (shared; fallback)
#
# $SNAP_USER_COMMON takes precedence over $SNAP_COMMON when both contain a
# config file. Having more than one config.* extension in the same directory
# is an error.
#
# If -c / --config is already in the arguments, auto-discovery is skipped.

# Resolve a single config file in DIR, or "" if none found.
# Exits with an error message if more than one extension matches.
find_config() {
    local _dir="$1"
    local _found=""
    local _ext _candidate
    for _ext in json5 yaml yml; do
        _candidate="${_dir}/config.${_ext}"
        if [ -f "${_candidate}" ]; then
            if [ -n "${_found}" ]; then
                echo "zenoh-bridge-ros2dds: ambiguous config in ${_dir}: ${_found} and ${_candidate} both exist." >&2
                exit 1
            fi
            _found="${_candidate}"
        fi
    done
    printf '%s' "${_found}"
}

# Check if the user already passed -c or --config
has_config=0
for arg in "$@"; do
    case "${arg}" in
        -c|--config|--config=*) has_config=1; break ;;
    esac
done

if [ "${has_config}" -eq 0 ]; then
    config_file=$(find_config "${SNAP_USER_COMMON}") || exit 1
    if [ -z "${config_file}" ]; then
        config_file=$(find_config "${SNAP_COMMON}") || exit 1
    fi
    if [ -n "${config_file}" ]; then
        set -- -c "${config_file}" "$@"
    fi
fi

exec "${SNAP}/zenoh-bridge-ros2dds" "$@"
