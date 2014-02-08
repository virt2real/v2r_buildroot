#!/bin/sh

case "$1" in
jffs)
	DUMPNAME=jffs
	;;
ubi)
	DUMPNAME=ubi
	;;
*)
	echo "Usage: nand_read.sh ubi | jffs"
	echo "    ubi - make ubi.gz dump file"
	echo "    jffs - make jffs.gz dump file"	
	exit 1
	;;
esac

# get current LED state
LED1=`cat /proc/v2r_gpio/73`
LED2=`cat /proc/v2r_gpio/74`
LED3=`cat /proc/v2r_gpio/pwctr3`

# turn off all LEDs (but not led triggers)
echo 0 > /proc/v2r_gpio/73
echo 0 > /proc/v2r_gpio/74
echo 0 > /proc/v2r_gpio/pwctr3

# turn on blinking green LED
echo "heartbeat" > "/sys/class/leds/v2r:green:user/trigger"

# read UBL and U-boot image (bootloader NAND partition)
nanddump -nof ./dump /dev/mtd0
gzip -c ./dump > ./$DUMPNAME.gz
rm ./dump

# turn off blinking green LED
echo "none" > "/sys/class/leds/v2r:green:user/trigger"

# restore LED state
echo $LED1 > /proc/v2r_gpio/73
echo $LED2 > /proc/v2r_gpio/74
echo $LED3 > /proc/v2r_gpio/pwctr3
