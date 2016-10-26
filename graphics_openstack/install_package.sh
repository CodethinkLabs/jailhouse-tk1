#!/bin/bash

set -e
while getopts "h:p:s:n:" opt
do
    case "$opt" in
        h)   HOST="$OPTARG";;
        p)   PREFIX="$OPTARG";;
        s)   SETTINGS="$OPTARG";;
        n)   PROCS="$OPTARG";;
        \?)  echo >&2 \
             "usage: $0 [-h host] [-p prefix] [-s settings] [-n number of processors]"
             exit 1;;
    esac
done

echo $SETTINGS
echo $PROCS
./autogen.sh --host="$HOST" --prefix="$PREFIX" $SETTINGS

re='^[0-9]+$'
if [[ $PROCS =~ $re ]]; then
    echo "Setting multiple processors"
    make -j"$PROCS"
else
    echo "Using only single processor"
    make
fi
make install


