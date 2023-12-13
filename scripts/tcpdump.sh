#!/bin/bash

set -e

if [[ ${debug:-false} == true ]]; then
    set -x
fi

if ! [[ -f ${0%.sh}.env ]]; then
    echo ${0%.sh}.env not found
    exit 1
fi

source ${0%.sh}.env

declare -r info_msg="tcpdump just started: $dump_file_name"
echo "$info_msg"
echo "$info_msg" | telefy

tcpdump -tttt -Z root -i $inet_name port $active_port  -w ${dump_file_name}.pcap. -W $file_count -C $file_size -K -n > $PWD/${dump_file_name}.log 2>&1

### read a dump file
### tcpdump -n -s 0  -r file

### https://serverfault.com/questions/478636/tcpdump-out-pcap-permission-denied
### disable this on Debian / Ubuntu 
### systemctl stop apparmor
### systemctl disable apparmor
### reboot 
### then try tcpdump
