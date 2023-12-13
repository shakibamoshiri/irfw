#!/bin/bash

set -e
set -x 

if ! [[ -f ${0%.sh}.env ]]; then
    echo ${0%.sh}.env not found
    exit 1
fi

source $PWD/${0%.sh}.env

tcpdump -i $inet_name -w ${dump_file_name}.pcap. -W $file_count -C $file_size -K -n >> $PWD/${dump_file_name}.log 2>&1 &
echo ${1} > ${dump_file_name}.pid
disown %1
