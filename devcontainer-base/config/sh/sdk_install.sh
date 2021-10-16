# Use SDKMAN to install something using a partial version match
sdk_install() {
    local install_type=$1
    local requested_version=$2
    local prefix=$3
    if [[ "$install_type" == 'java' ]]; then
        local suffix="${4:-"-tem"}"
    else
        local suffix="${4:-"\\s*"}"
    fi
    if [ "${requested_version}" = "none" ]; then return; fi
    local regex="${prefix}\\K[0-9]+\\.[0-9]+\\.[0-9]+${suffix}"
    local version_list="$(sdk list ${install_type} 2>&1 | grep -oP "${regex}" | tr -d ' ' | sort -rV)"
    set +e
    requested_version="$(echo "${version_list}" | grep -E -m 1 "^${requested_version//./\\.}([\\.\\s]|$)")"
    set -e
    if [ -z "${requested_version}" ] || ! echo "${version_list}" | grep "^${requested_version//./\\.}$" > /dev/null 2>&1; then
        echo -e "Version $2 not found. Available versions:\n${version_list}" >&2
        exit 1
    fi
    sdk install ${install_type} ${requested_version} && sdk flush archives && sdk flush temp
}
