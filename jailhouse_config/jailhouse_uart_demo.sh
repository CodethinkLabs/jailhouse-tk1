#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
then echo "Please run as root"
    exit 1
fi
JAILHOUSE_DIRS=/usr/src/jailhouse

modprobe jailhouse
jailhouse enable $JAILHOUSE_DIRS/configs/jetson-tk1.cell
jailhouse cell create $JAILHOUSE_DIRS/configs/jetson-tk1-demo.cell 
jailhouse cell load jetson-tk1-demo $JAILHOUSE_DIRS/inmates/demos/arm/uart-demo.bin -a 0
jailhouse cell start jetson-tk1-demo

echo "Jailhouse UART demo started. See UART to confirm that cell is executing correctly!"
echo "Type: jailhouse cell destroy jetson-tk1-demo to finish demo"
