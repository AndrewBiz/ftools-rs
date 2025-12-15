#!/usr/bin/env bash

# usage:
#    tests/cucu.sh
#    tests/cucu.sh -t @ftrename

PATH="${PWD}/target/debug:${PWD}/features:$PATH"
# echo $PATH
# echo "****** CARGO TEST ********************************"
# cargo test
echo "******* CUCUMBER TEST ****************************"
# cucumber -f progress summary -msi $@
cucumber -f progress $@
echo "**************************************************"
# cucumber $@
