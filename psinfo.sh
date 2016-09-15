#!/bin/bash

# Shows ps info based of its pid

set -eo pipefail

pid=$1
cmdline="$(strings -1 -s ' ' /proc/$pid/cmdline)"
cwd="$(readlink -e /proc/$pid/cwd)"
exe="$(readlink -e /proc/$pid/exe)"
no_of_fds="$(ls -l /proc/$pid/fd | wc -l)"
root="$(readlink -e /proc/$pid/root)"
env="$(strings -1 -s ' ' /proc/$pid/environ)"

# TODO need to parse ls -l /proc/$pid/fd for file types
# TODO need to parse /proc/$pid/status for memory, process status etc

echo "CMDLINE: $cmdline"
echo "CWD: $cwd"
echo "EXE: $exe"
echo "OPEN FILES: $no_of_fds"
echo "ROOT: $root"
echo "ENVIRONMENT:"
for i in $env; do
    echo "    " $i
done
