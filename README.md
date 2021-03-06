# jailhouse-tk1: Experimental build of jailhouse on the Jetson-TK1

## Overview
The goal is to develop a complete build: linux kernel, file system and jailhouse hypervisor on the Jetson-TK1. Success in this direction will enable the development of non-root cells that are of interest (such as RTOS's)

Although there is documented support of the Jetson-TK1 for Jailhouse (also see https://blog.ramses-pyramidenbau.de/?p=342), this brings together kernel fixes and modifications to the root cell required for operation. 

Future goals include being able to deploy the complete system using Baserock. At the moment, all of the individual components are built using debian CrossToolchains within vagrant boxes.

A working demonstration of the build is shown here: https://vimeo.com/190110057

## Requirements 
- Vagrant 1.8.5 
- Virtualbox 5.1, 
- a recent version of UBoot on the Jetson TK1 (to enable CPU HYP mode). (https://github.com/cphang99/uboot-TK1) 
- An ext4 SDcard of at least 4GB in size

##Usage 
``` shell
sudo ./deploy_sdcard.sh /path/to/sdcard
```

Note that path/to/sdcard denotes the device name in /dev as opposed to a mount point.
Please note that complete builds can take more than hour to finish.

### Testing jailhouse functionality
There is a script located in /home/ubuntu that:
- Loads the jailhouse kernel module
- Creates a root cell
- Loads a non-root cell
- Executes an example binary, outputting to UART.

To execute:
``` shell
sudo ./jailhouse_uart_demo.sh
```

### Testing freeRTOS functionality
We have created a fork of the freeRTOS cell for jailhouse https://github.com/CodethinkLabs/freertos-cell that will 
enable its use on the TK1

It is built along with jailhouse and performs some test tasks. Note that at the moment, FPU calculations are not supported.

Scripts are located in /home/ubuntu. To execute:
``` shell
sudo ./freertos_demo.sh
```

### Testing nouveau open-source graphics stack
Builds now include the nouveau graphics stack (See https://github.com/NVIDIA/tegra-nouveau-rootfs.) To test this, 
kmscube is present in the system. To execute:
```shell
kmscube
```
kmscube can be run in conjunction with other non-root cells (such as a running freeRTOS binary).
