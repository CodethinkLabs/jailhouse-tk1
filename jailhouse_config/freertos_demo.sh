#!/bin/bash
#Creates a non-root cell and executes a binary of freeRTOS
#Assumes a root cell has already been created
set -e

if [ "$EUID" -ne 0 ]
then echo "Please run as root"
    exit 1
fi
JAILHOUSE_DIRS=/usr/src/jailhouse

jailhouse cell create $JAILHOUSE_DIRS/configs/jetson-tk1-freertos.cell 
jailhouse cell load freeRTOS $JAILHOUSE_DIRS/inmates/demos/arm/freertos-demo.bin -a 0
jailhouse cell start freeRTOS

echo "Jailhouse freeRTOS demo started. See UART to confirm that cell is executing correctly!"
echo "Type: jailhouse cell destroy freeRTOS to finish demo"
