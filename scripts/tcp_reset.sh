#!/bin/bash

set -e
set -x

declare -r action=${1:? error ... action: <I - D - A>}
declare -r dport=${2:? error ... dport: <number>}

iptables -t filter -${action} INPUT -p tcp -m tcp --dport $dport -j REJECT --reject-with tcp-reset
iptables -t filter -${action} INPUT -p udp -m udp --dport $dport -j REJECT
