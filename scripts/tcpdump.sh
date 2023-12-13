#!/bin/bash

set -e
set -x 

declare -ir file_count=${1:? error ... file_count: <NUMBER>} 
declare -ir file_size=${2:? error ... file_size: <NUMBER>}

declare -r dump_file_name=tcpdump-$(date +%s)
declare -r inet_name=$(ip route show default | cut -f5 -d ' ')

tcpdump -i $inet_name -w ${dump_file_name}.pcap. -W $file_count -C $file_size -K -n >> $PWD/${dump_file_name}.log 2>&1 &
echo ${1} > ${dump_file_name}.pid
disown %1
