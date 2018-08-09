# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Pop Kernel for the Nexbit Robin by @linckandrea
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=ether
} # end properties

# shell variables
block=/dev/block/platform/soc.0/f9824900.sdhci/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel permissions
# set permissions for included files
chmod -R 755 $ramdisk
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.pop.rc
insert_line init.nbq.target.rc "init.pop.rc" after "import /vendor/etc/init/hw/init.nbq.usb.rc" "import init.pop.rc";

# end ramdisk changes

write_boot;

## end install

