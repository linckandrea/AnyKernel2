# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Pop kernel by linckandrea @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=xt1092
device.name2=xt1095
device.name3=victara
supported.versions=9
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# init.target.rc
backup_file init.target.rc;
replace_string init.target.rc "service mpdecision /system/vendor/bin/mpdecision --avg_comp --Nw=1:1.99 --Nw=2:2.99 --Nw=3:3.99 --Tw=2:140 --Tw=3:140 --Ts=2:190 --Ts=3:190" "service mpdecision /system/vendor/bin/mpdecision --avg_comp" "service mpdecision /system/vendor/bin/mpdecision --avg_comp --Nw=1:1.99 --Nw=2:2.99 --Nw=3:3.99 --Tw=2:140 --Tw=3:140 --Ts=2:190 --Ts=3:190"

# init.qcom.rc
backup_file init.qcom.rc;
# disable mpdecision
remove_line init.qcom.rc "start mpdecision";
# remove cpuboost parameters (since we use cpu_input_boost)
remove_line init.qcom.rc "write /sys/module/cpu_boost/parameters/boost_ms 20";
remove_line init.qcom.rc "write /sys/module/cpu_boost/parameters/sync_threshold 1728000";
remove_line init.qcom.rc "write /sys/module/cpu_boost/parameters/input_boost_freq 1497600";
remove_line init.qcom.rc "write /sys/module/cpu_boost/parameters/input_boost_ms 40";

# end ramdisk changes

write_boot;
## end install

