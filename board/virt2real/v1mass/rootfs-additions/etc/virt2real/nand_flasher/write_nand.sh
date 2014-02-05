#!/bin/sh

#########################################################
#
#  NAND writer for Virt2real
#
#  (c) 2014 Gol, special for Virt2real
#
#########################################################

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


# unzip bootloader image
gzip -cd dump.gz> ./dump

# write UBL and U-boot image to bootloader NAND partition
nandwrite -no /dev/mtd0 ./dump

# remove dump
rm ./dump

# destination NAND partition for kernel
NAND_ID=1
KERNEL_DST=/mnt/nand$NAND_ID

# clear kernel NAND partition
flash_erase /dev/mtd$NAND_ID 0 0

# mount MMC kernel partition
mount /dev/mmcblk0p1 /mnt

# write kernel to NAND
nandwrite -p /dev/mtd$NAND_ID /mnt/uImage

# unmount kernel MMC partition
umount /mnt

# syncing all
sync

# destination NAND partition for rootfs
NAND_ID=2
ROOTFS_DST=/mnt/nand$NAND_ID

# clear rootfs NAND partition
flash_erase /dev/mtd$NAND_ID 0 0

# make directory for mounting
mkdir -p $ROOTFS_DST

# mount rootfs NAND partition
mount -t jffs2 /dev/mtdblock$NAND_ID $ROOTFS_DST

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

# turn off blinking red LED
echo "none" > "/sys/class/leds/v2r:red:user/trigger"

# restore LED state
echo $LED1 > /proc/v2r_gpio/73
echo $LED2 > /proc/v2r_gpio/74
echo $LED3 > /proc/v2r_gpio/pwctr3

