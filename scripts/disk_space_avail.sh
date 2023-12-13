#!/bin/bash
#
set -e
set -u
set -T
set -C
set -o pipefail

if [[ ${debug:-false} == true ]]; then
    set -x
fi


declare -i disk_space_avail=0
declare disk_space_avail_value=''

declare -r warning_msg="❌ warning: less than 1000M (1G) disk space is available on mci test server"
declare info_msg=""

while true; do
    disk_space_avail_value=$(df -H -BM  --output=avail $disk_partition | tail -n +2)
    disk_space_avail=${disk_space_avail_value%M}

    info_msg="info: there is ${disk_space_avail}M disk available"
    
    if (( $disk_space_avail <= 1000 )); then
        echo "$warning_msg"
        echo "$warning_msg" | tee | telefy
    else
        echo "$info_msg"
    fi
    sleep 10
done

