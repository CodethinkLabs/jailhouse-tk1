# jailhouse-tk1: Experimental build of jailhouse on the Jetson-TK1

## Overview
The goal is to develop a complete build: linux kernel, file system and jailhouse hypervisor on the Jetson-TK1. Success in this direction will enable the development of non-root cells that are of interest (such as RTOS's)

Although there is documented support of the Jetson-TK1 for Jailhouse (also see https://blog.ramses-pyramidenbau.de/?p=342), this brings together kernel fixes and modifications to the root cell required for operation. 

Future goals include being able to deploy the complete system using Baserock. At the moment, all of the individual components are built using debian CrossToolchains within vagrant boxes. 

## Requirements 
- Vagrant 1.8.5 
- Virtualbox 5.1, 
- a recent version of UBoot on the Jetson TK1 (to enable CPU HYP mode). 
- An ext4 SDcard of at least 4GB in size

##Usage 
``` shell
sudo ./deploy_sdcard.sh /path/to/sdcard
```
