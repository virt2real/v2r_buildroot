#!/bin/sh

#########################################################
#
#  Kernel and filesystem to NAND writer for Virt2real
#
#  (c) 2014 Gol, special for Virt2real
#
#########################################################

KERNEL_DST=/mnt/nand1
ROOTFS_DST=/mnt/nand2

# destination NAND partition for kernel
KERNEL_NAND_ID=1

# destination NAND partition for fs
ROOTFS_NAND_ID=2


case "$1" in
jffs)
	DUMPNAME=jffs
	;;
ubi)
	DUMPNAME=ubi
	;;
*)
	echo "Usage: nand_write.sh ubi | jffs"
	echo "    ubi - format as UBI"
	echo "    jffs - format as JFFS"	
	exit 1
	;;
esac


# turn on led blink
led_on () {

	# get current LED state
	LED1=`cat /proc/v2r_gpio/73`
	LED2=`cat /proc/v2r_gpio/74`
	LED3=`cat /proc/v2r_gpio/pwctr3`

	# turn off all LEDs (but not led triggers)
	echo 0 > /proc/v2r_gpio/73
	echo 0 > /proc/v2r_gpio/74
	echo 0 > /proc/v2r_gpio/pwctr3

	# turn on blinking red LED
	echo "heartbeat" > "/sys/class/leds/v2r:red:user/trigger"
	
}


led_off () {
	# turn off blinking red LED
	echo "none" > "/sys/class/leds/v2r:red:user/trigger"

	# restore LED state
	echo $LED1 > /proc/v2r_gpio/73
	echo $LED2 > /proc/v2r_gpio/74
	echo $LED3 > /proc/v2r_gpio/pwctr3
}


bootloader_write () {
	echo "Writing bootloader"

	# unzip bootloader image
	gzip -cd $DUMPNAME.gz> ./dump

	# clear bootloader partition
	flash_erase /dev/mtd0 0 0

	# write UBL and U-boot image to bootloader NAND partition
	nandwrite -no /dev/mtd0 ./dump

	sync

	# remove dump
	rm ./dump
}


kernel_write () {

	echo "Clear kernel NAND partition"

	# clear kernel NAND partition
	flash_erase /dev/mtd$KERNEL_NAND_ID 0 0

	# mount MMC kernel partition
	mkdir -p /mnt/mmc
	mount /dev/mmcblk0p1 /mnt/mmc

	# write kernel to NAND
	echo "Write kernel to NAND"
	nandwrite -p /dev/mtd$KERNEL_NAND_ID /mnt/mmc/uImage

	# unmount and delete kernel MMC partition
	umount /mnt/mmc
	rm -Rf /mnt/mmc

	# syncing all
	sync
}


fs_format_jffs () {

	echo "Clear rootfs NAND partition"

	# clear rootfs NAND partition
	flash_erase /dev/mtd$ROOTFS_NAND_ID 0 0

	# make directory for mounting
	mkdir -p $ROOTFS_DST

	# mount rootfs NAND partition
	mount -t jffs2 /dev/mtdblock$ROOTFS_NAND_ID $ROOTFS_DST

	echo "JFFS partition mounted"
}


fs_format_ubi () {

	echo "Clear rootfs NAND partition"

	# clear rootfs NAND partition
	flash_erase /dev/mtd$ROOTFS_NAND_ID 0 0

	# make directory for mounting
	mkdir -p $ROOTFS_DST

	echo "Formatting UBI NAND partition"

	ubiformat /dev/mtd$ROOTFS_NAND_ID -s 512 -O 2048
	ubiattach /dev/ubi_ctrl -m 2 -O 2048
	ubimkvol /dev/ubi0 -N fs -s 230MiB

	mount -t ubifs ubi0:fs $ROOTFS_DST
}


fs_write () {

	echo "Writing rootfs to NAND"

	# make not regular directories
	mkdir -p $ROOTFS_DST/dev
	mkdir -p $ROOTFS_DST/mnt
	mkdir -p $ROOTFS_DST/proc
	mkdir -p $ROOTFS_DST/run
	mkdir -p $ROOTFS_DST/sys
	mkdir -p $ROOTFS_DST/tmp

	for mntName in `ls /mnt`; do
    	mkdir -p $ROOTFS_DST/mnt/$mntName
	done

	# make symlink
	ln -s $ROOTFS_DST/bin/busybox $ROOTFS_DST/linuxrc

	# copy all regular directories and files to rootfs NAND partition
	for dirName in `ls /`; do
    	if [ "$dirName" == "dev" ] ; then echo "skip $dirName" ; continue ; fi
	    if [ "$dirName" == "mnt" ] ; then echo "skip $dirName" ; continue ; fi
    	if [ "$dirName" == "proc" ] ; then echo "skip $dirName" ; continue ; fi
	    if [ "$dirName" == "run" ] ; then echo "skip $dirName" ; continue ; fi
    	if [ "$dirName" == "sys" ] ; then echo "skip $dirName" ; continue ; fi
	    if [ "$dirName" == "tmp" ] ; then echo "skip $dirName" ; continue ; fi

    	echo "copying $dirName"
	    cp -R /$dirName $ROOTFS_DST/
	done

	# syncing (may be a long time)
	sync
}

fs_unmount () {
	# unmount fs dir
	echo "unmounting $ROOTFS_DST"
	umount $ROOTFS_DST
	echo "removing $ROOTFS_DST"
	rmdir  $ROOTFS_DST
}



led_on
bootloader_write
kernel_write

case "$1" in
jffs)
	fs_format_jffs
	;;
ubi)
	fs_format_ubi
	;;
*)
	exit 1
	;;
esac

fs_write
fs_unmount

# deattach UBI device
if [ "$1" == "ubi" ] ; then
    ubidetach -d 0
fi

led_off

/etc/virt2real/log "NAND write done"
