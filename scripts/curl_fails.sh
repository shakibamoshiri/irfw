#!/bin/bash

set -euTCo pipefail

### add a blocked address
declare -r remote_address=https://ADDRESS:PORT

if curl --connect-timeout 10 --max-time 10 -o /dev/null -ksLw '%{http_code}\n' $remote_address > /dev/null 2>&1; then
    echo "remote_address: $remote_address succeeded"
else
    echo "remote_address: $remote_address failed"
fi
