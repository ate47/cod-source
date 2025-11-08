NAME scripts\core_common\ai\zombie_utility.gsc
VERSION 0
CHECKSUM 0x92f47f7a
######################################################
####################  DEV STRINGS  ###################
######################################################
# zombie_utility::dumpanimarray@c4
STRING "<dev string:x100>" 0x2f3c
# zombie_utility::dumpanimarray@f0
STRING "<dev string:x105>" 0x2f68
# zombie_utility::set_orient_mode@44 zombie_utility::set_orient_mode@84
STRING "<dev string:x10f>" 0x3284 0x32c4
# zombie_utility::debug_turn_print@140
STRING "<dev string:x12e>" 0x3528
# zombie_utility::debug_turn_print@150
STRING "<dev string:x138>" 0x3538
# zombie_utility::debug_turn_print@160
STRING "<dev string:x143>" 0x3548
# zombie_utility::set_zombie_var_player@1c
STRING "<dev string:x151>" 0x37cc
# zombie_utility::get_zombie_var_player@14
STRING "<dev string:x186>" 0x3834
# zombie_utility::spawn_zombie@3c
STRING "<dev string:x1bb>" 0x38c4
# zombie_utility::spawn_zombie@2a4
STRING "<dev string:x1e6>" 0x3b2c
# zombie_utility::spawn_zombie@2d4
STRING "<dev string:x228>" 0x3b5c
# zombie_utility::get_desired_origin@94
STRING "<dev string:x266>" 0x3c74
# zombie_utility::get_desired_origin@a4
STRING "<dev string:x295>" 0x3c84
# zombie_utility::register_ignore_player_handler@1c
STRING "<dev string:x29e>" 0x7ff4
# zombie_utility::register_ignore_player_handler@3c
STRING "<dev string:x2ca>" 0x8014
# zombie_utility::register_ignore_player_handler@48
STRING "<dev string:x2e6>" 0x8020
# zombie_utility::initanimtree@4c
STRING "<dev string:x38>" 0xacc
# zombie_utility::updateanimpose@4c
STRING "<dev string:x64>" 0xb4c
# zombie_utility::updateanimpose@68
STRING "<dev string:x6c>" 0xb68
# zombie_utility::updateanimpose@88
STRING "<dev string:x74>" 0xb88
# zombie_utility::updateanimpose@c
STRING "<dev string:x7b>" 0xb0c
# zombie_utility::updateanimpose@24 zombie_utility::set_orient_mode@50 zombie_utility::set_orient_mode@60 zombie_utility::set_orient_mode@90 zombie_utility::debug_anim_print@34 zombie_utility::debug_anim_print@90 zombie_utility::debug_turn_print@134
STRING "<dev string:x8e>" 0xb24 0x3290 0x32a0 0x32d0 0x3364 0x33c0 0x351c
# zombie_utility::debugposinternal@44 zombie_utility::debugposinternal@54
STRING "<dev string:x93>" 0x202c 0x203c
# zombie_utility::animarray@6c zombie_utility::animarrayanyexist@6c zombie_utility::animarraypickrandom@74
STRING "<dev string:xa2>" 0x2c0c 0x2ccc 0x2d9c
# zombie_utility::animarray@78 zombie_utility::animarrayanyexist@78 zombie_utility::animarraypickrandom@80
STRING "<dev string:xb5>" 0x2c18 0x2cd8 0x2da8
# zombie_utility::dumpanimarray@34
STRING "<dev string:xc9>" 0x2eac
# zombie_utility::dumpanimarray@a8 zombie_utility::dumpanimarray@e4
STRING "<dev string:xda>" 0x2f20 0x2f5c
# zombie_utility::dumpanimarray@b4
STRING "<dev string:xe7>" 0x2f2c
######################################################
####################  DEV BLOCKS  ####################
######################################################
# zombie_utility::initanimtree@44
DEVBLOCK 0xac4
# zombie_utility::updateanimpose@2
DEVBLOCK 0xb02
# zombie_utility::absyawtoenemy@a
DEVBLOCK 0x1312
# zombie_utility::absyawtoenemy2d@a
DEVBLOCK 0x13c2
# zombie_utility::quadrantanimweights@f2
DEVBLOCK 0x1b1a
# zombie_utility::drawstringtime@32
DEVBLOCK 0x1e4a
# zombie_utility::showlastenemysightpos@12
DEVBLOCK 0x1eba
# zombie_utility::debugposinternal@2a
DEVBLOCK 0x2012
# zombie_utility::showdebugproc@32
DEVBLOCK 0x21da
# zombie_utility::showlines@1a
DEVBLOCK 0x264a
# zombie_utility::anim_array@6c
DEVBLOCK 0x2714
# zombie_utility::anim_array@82
DEVBLOCK 0x272a
# zombie_utility::print3dtime@42
DEVBLOCK 0x28c2
# zombie_utility::print3drise@42
DEVBLOCK 0x2962
# zombie_utility::persistentdebugline@12
DEVBLOCK 0x2ae2
# zombie_utility::animarray@a
DEVBLOCK 0x2baa
# zombie_utility::animarray@32
DEVBLOCK 0x2bd2
# zombie_utility::animarray@62
DEVBLOCK 0x2c02
# zombie_utility::animarrayanyexist@a
DEVBLOCK 0x2c6a
# zombie_utility::animarrayanyexist@32
DEVBLOCK 0x2c92
# zombie_utility::animarrayanyexist@62
DEVBLOCK 0x2cc2
# zombie_utility::animarraypickrandom@12
DEVBLOCK 0x2d3a
# zombie_utility::animarraypickrandom@3a
DEVBLOCK 0x2d62
# zombie_utility::animarraypickrandom@6a
DEVBLOCK 0x2d92
# zombie_utility::animarraypickrandom@aa
DEVBLOCK 0x2dd2
# zombie_utility::dumpanimarray@2a
DEVBLOCK 0x2ea2
# zombie_utility::damagelocationisany@1fc
DEVBLOCK 0x3214
# zombie_utility::set_orient_mode@12
DEVBLOCK 0x3252
# zombie_utility::debug_anim_print@a
DEVBLOCK 0x333a
# zombie_utility::debug_turn_print@5a
DEVBLOCK 0x3442
# zombie_utility::set_zombie_var_player@12
DEVBLOCK 0x37c2
# zombie_utility::get_zombie_var_player@a
DEVBLOCK 0x382a
# zombie_utility::spawn_zombie@32
DEVBLOCK 0x38ba
# zombie_utility::spawn_zombie@262
DEVBLOCK 0x3aea
# zombie_utility::spawn_zombie@292
DEVBLOCK 0x3b1a
# zombie_utility::spawn_zombie@2c2
DEVBLOCK 0x3b4a
# zombie_utility::get_desired_origin@8c
DEVBLOCK 0x3c6c
# zombie_utility::default_max_zombie_func@52
DEVBLOCK 0x482a
# zombie_utility::set_zombie_run_cycle@fe
DEVBLOCK 0x4f0e
# zombie_utility::register_ignore_player_handler@12
DEVBLOCK 0x7fea
# zombie_utility::register_ignore_player_handler@32
DEVBLOCK 0x800a
# zombie_utility::updateanimationrate@1a
DEVBLOCK 0x8242
