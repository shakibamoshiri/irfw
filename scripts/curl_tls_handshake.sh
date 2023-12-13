#!/bin/bash

# set -e
set -u
set -T
set -C
set -o pipefail

if [[ ${debug:-false} == true ]]; then
    set -x
fi

if ! [[ -f ${0%.sh}.env ]]; then
    echo ${0%.sh}.env not found
    exit 1
fi

source $PWD/${0%.sh}.env

declare -r remote_address=https://${remote_server_host}:${remote_server_port}

declare info_msg warnning_msg

if curl --connect-timeout 10 --max-time 10 -o /dev/null -ksLw "%{http_code}\n" $remote_address > /dev/null 2>&1; then
    info_msg="$(date +%F-%A-%H-%M-%S) winfo: checking $remote_address ... [succeeded]"
    echo "$info_msg" | tee -a ${0%.sh}.log
else
    warnning_msg="❌ $(date +%F-%A-%H-%M-%S) warning: checking $remote_address ... [failed]"
    echo "$warnning_msg" | tee -a ${0%.sh}.log
    echo "$warnning_msg" | ./telefy

    ### remove "echo" in real case tests
    echo ssh $remote_server_ssh '{ echo SSH to host: $HOSTNAME; pkill tcpdump; }'
fi
