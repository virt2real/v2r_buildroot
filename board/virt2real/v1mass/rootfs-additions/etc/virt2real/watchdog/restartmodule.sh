#!/bin/sh

rmmod libertas_sdio
rmmod libertas
	
modprobe libertas
modprobe libertas_sdio
