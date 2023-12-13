#!/bin/bash

set -e

if [[ ${debug:-false} == true ]]; then
    set -x
fi

declare -r filename=${1:? error ... filename: <filename>}

tcpdump -tttt -n -s 0 -r ${}
