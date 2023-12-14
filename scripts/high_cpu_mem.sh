#!/bin/bash

set -u
set -T
# set -C
set -o pipefail

if [[ ${debug:-false} == true ]]; then
    set -x
fi

declare -r ps_output_file=ps.txt

ps -Ao user,uid,comm,pid,pcpu,pmem --sort=-pcpu > $ps_output_file

perl -ane 'if($F[4] >= 90 || $F[5] >= 90){$r .= "WARNING: cmd: $F[2] cpu: $F[4] mem: $F[5]\n"}; END{if($r){qx(echo "$r" | telefy)}}' $ps_output_file
