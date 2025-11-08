NAME scripts\zm_common\zm_power.gsc
VERSION 0
CHECKSUM 0x4106114d
######################################################
####################  DEV STRINGS  ###################
######################################################
# zm_power::door_power_on@1c
STRING "<dev string:x111>" 0x24ec
# zm_power::door_power_off@1c
STRING "<dev string:x129>" 0x2554
# zm_power::door_local_power_on@1c
STRING "<dev string:x142>" 0x25bc
# zm_power::door_local_power_off@1c
STRING "<dev string:x162>" 0x2624
# zm_power::zombie_power_off@24
STRING "<dev string:x183>" 0x27bc
# zm_power::stun_zombie@4c
STRING "<dev string:x19f>" 0x2874
# zm_power::perk_power_on@1c zm_power::perk_power_off@3c
STRING "<dev string:x1bf>" 0x29d4 0x2a9c
# zm_power::perk_power_on@3c
STRING "<dev string:x1d4>" 0x29f4
# zm_power::perk_power_off@5c
STRING "<dev string:x1dc>" 0x2abc
# zm_power::revert_power@40
STRING "<dev string:x38>" 0x19b8
# zm_power::revert_power@d4 zm_power::global_power@a0
STRING "<dev string:x5d>" 0x1a4c 0x22c8
# zm_power::add_local_power@34
STRING "<dev string:x82>" 0x1ae4
# zm_power::add_local_power@40 zm_power::end_local_power@24
STRING "<dev string:xa2>" 0x1af0 0x1d54
# zm_power::add_local_power@50 zm_power::end_local_power@38
STRING "<dev string:xae>" 0x1b00 0x1d68
# zm_power::end_local_power@14
STRING "<dev string:xb3>" 0x1d44
# zm_power::global_power@1c
STRING "<dev string:xd4>" 0x2244
# zm_power::global_power@74
STRING "<dev string:xf2>" 0x229c
######################################################
####################  DEV BLOCKS  ####################
######################################################
# zm_power::postinit@2a
DEVBLOCK 0x2fa
# zm_power::debug_powered_items@2a
DEVBLOCK 0x34a
# zm_power::revert_power@36
DEVBLOCK 0x19ae
# zm_power::revert_power@ca
DEVBLOCK 0x1a42
# zm_power::add_local_power@2c
DEVBLOCK 0x1adc
# zm_power::end_local_power@a
DEVBLOCK 0x1d3a
# zm_power::global_power@12
DEVBLOCK 0x223a
# zm_power::global_power@6a
DEVBLOCK 0x2292
# zm_power::global_power@96
DEVBLOCK 0x22be
# zm_power::door_power_on@12
DEVBLOCK 0x24e2
# zm_power::door_power_off@12
DEVBLOCK 0x254a
# zm_power::door_local_power_on@12
DEVBLOCK 0x25b2
# zm_power::door_local_power_off@12
DEVBLOCK 0x261a
# zm_power::zombie_power_off@1a
DEVBLOCK 0x27b2
# zm_power::stun_zombie@44
DEVBLOCK 0x286c
# zm_power::perk_power_on@12
DEVBLOCK 0x29ca
# zm_power::perk_power_off@34
DEVBLOCK 0x2a94
