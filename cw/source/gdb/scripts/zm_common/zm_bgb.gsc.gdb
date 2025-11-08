NAME scripts\zm_common\zm_bgb.gsc
VERSION 0
CHECKSUM 0xd9e6431a
######################################################
####################  DEV STRINGS  ###################
######################################################
# bgb::setup_devgui@1f8
STRING "<dev string:x10c>" 0x1360
# bgb::bgb_debug_text_display_init@24
STRING "<dev string:x117>" 0x15cc
# bgb::bgb_debug_text_display_init@3c
STRING "<dev string:x11f>" 0x15e4
# bgb::bgb_debug_text_display_init@6c bgb::bgb_debug_text_display_init@9c
STRING "<dev string:x12c>" 0x1614 0x1644
# bgb::bgb_debug_text_display_init@84 bgb::bgb_debug_text_display_init@b4
STRING "<dev string:x134>" 0x162c 0x165c
# bgb::bgb_set_debug_text@b0
STRING "<dev string:x13b>" 0x17a8
# bgb::bgb_set_debug_text@108 bgb::bgb_set_debug_text@14c
STRING "<dev string:x146>" 0x1800 0x1844
# bgb::bgb_set_debug_text@114
STRING "<dev string:x14f>" 0x180c
# bgb::bgb_set_debug_text@124
STRING "<dev string:x174>" 0x181c
# bgb::bgb_print_stats@34
STRING "<dev string:x17e>" 0x18f4
# bgb::bgb_print_stats@7c
STRING "<dev string:x19b>" 0x193c
# bgb::bgb_print_stats@f4
STRING "<dev string:x1b3>" 0x19b4
# bgb::bgb_limit_monitor@518
STRING "<dev string:x1c3>" 0x2bb8
# bgb::bgb_limit_monitor@528 bgb::register@39c
STRING "<dev string:x1e6>" 0x2bc8 0x3c54
# bgb::bgb_limit_monitor@548 bgb::register@3ac
STRING "<dev string:x1f9>" 0x2be8 0x3c64
# bgb::register@44
STRING "<dev string:x20f>" 0x38fc
# bgb::register@64
STRING "<dev string:x238>" 0x391c
# bgb::register@7c
STRING "<dev string:x25d>" 0x3934
# bgb::register@b4 bgb::register@f4 bgb::register@124 bgb::register@154 bgb::register@19c bgb::register@1ec bgb::register@244 bgb::register@284 bgb::register@2d4 bgb::register@338 bgb::register@390
STRING "<dev string:x297>" 0x396c 0x39ac 0x39dc 0x3a0c 0x3a54 0x3aa4 0x3afc 0x3b3c 0x3b8c 0x3bf0 0x3c48
# bgb::register@c0
STRING "<dev string:x2b1>" 0x3978
# bgb::register@100
STRING "<dev string:x2d2>" 0x39b8
# bgb::register@130
STRING "<dev string:x2f3>" 0x39e8
# bgb::register@160
STRING "<dev string:x30f>" 0x3a18
# bgb::register@1a8
STRING "<dev string:x349>" 0x3a60
# bgb::register@1f8
STRING "<dev string:x384>" 0x3ab0
# bgb::bgb_finalize@12c
STRING "<dev string:x38>" 0xfbc
# bgb::register@208 bgb::register@260 bgb::register@2a0 bgb::register@300 bgb::register@354
STRING "<dev string:x3d3>" 0x3ac0 0x3b18 0x3b58 0x3bb8 0x3c0c
# bgb::register@250
STRING "<dev string:x3d8>" 0x3b08
# bgb::register@290
STRING "<dev string:x40f>" 0x3b48
# bgb::register@2e0
STRING "<dev string:x451>" 0x3b98
# bgb::register@2f0
STRING "<dev string:x45f>" 0x3ba8
# bgb::register@344
STRING "<dev string:x484>" 0x3bfc
# bgb::bgb_finalize@13c
STRING "<dev string:x4a>" 0xfcc
# bgb::register_actor_damage_override@1c
STRING "<dev string:x4bc>" 0x3e0c
# bgb::register_actor_damage_override@28 bgb::register_vehicle_damage_override@28 bgb::register_actor_death_override@28 bgb::register_lost_perk_override@30 bgb::function_c2721e81@30 bgb::function_72469efe@28 bgb::function_8a5d8cfb@28 bgb::function_be42abb0@28 bgb::function_afe7b8e7@20 bgb::function_e1f37ce7@20 bgb::function_1fee6b3@28 bgb::give@50
STRING "<dev string:x4ec>" 0x3e18 0x3e90 0x3f08 0x3f88 0x4020 0x40b0 0x4128 0x41a0 0x4210 0x4288 0x4308 0x43d8
# bgb::register_vehicle_damage_override@1c
STRING "<dev string:x506>" 0x3e84
# bgb::register_actor_death_override@1c
STRING "<dev string:x538>" 0x3efc
# bgb::register_lost_perk_override@24
STRING "<dev string:x567>" 0x3f7c
# bgb::function_c2721e81@24
STRING "<dev string:x594>" 0x4014
# bgb::function_72469efe@1c
STRING "<dev string:x5cb>" 0x40a4
# bgb::function_8a5d8cfb@1c
STRING "<dev string:x604>" 0x411c
# bgb::function_be42abb0@1c
STRING "<dev string:x637>" 0x4194
# bgb::function_afe7b8e7@14
STRING "<dev string:x666>" 0x4204
# bgb::function_e1f37ce7@14 bgb::function_1fee6b3@1c
STRING "<dev string:x68c>" 0x427c 0x42fc
# bgb::function_1fee6b3@5c
STRING "<dev string:x6bf>" 0x433c
# bgb::function_1fee6b3@68
STRING "<dev string:x6e5>" 0x4348
# bgb::give@44
STRING "<dev string:x708>" 0x43cc
# bgb::is_enabled@30
STRING "<dev string:x71e>" 0x4780
# bgb::setup_devgui@5c bgb::bgb_devgui_think@3c bgb::bgb_devgui_think@60
STRING "<dev string:x7b>" 0x11c4 0x1404 0x1428
# bgb::setup_devgui@ac
STRING "<dev string:x7f>" 0x1214
# bgb::setup_devgui@140
STRING "<dev string:x96>" 0x12a8
# bgb::setup_devgui@148
STRING "<dev string:xa7>" 0x12b0
# bgb::setup_devgui@150 bgb::setup_devgui@19c bgb::setup_devgui@208
STRING "<dev string:xbd>" 0x12b8 0x1304 0x1370
# bgb::setup_devgui@160 bgb::setup_devgui@1ac bgb::setup_devgui@218
STRING "<dev string:xc2>" 0x12c8 0x1314 0x1380
# bgb::setup_devgui@18c
STRING "<dev string:xc9>" 0x12f4
# bgb::setup_devgui@194 bgb::setup_devgui@200
STRING "<dev string:xdf>" 0x12fc 0x1368
# bgb::setup_devgui@1a4
STRING "<dev string:xf4>" 0x130c
# bgb::setup_devgui@1e8
STRING "<dev string:xfa>" 0x1350
######################################################
####################  DEV BLOCKS  ####################
######################################################
# bgb::postinit@32
DEVBLOCK 0x652
# bgb::bgb_player_init@280
DEVBLOCK 0x980
# bgb::bgb_finalize@122
DEVBLOCK 0xfb2
# bgb::setup_devgui@52
DEVBLOCK 0x11ba
# bgb::bgb_devgui_think@a
DEVBLOCK 0x13d2
# bgb::bgb_devgui_acquire@22
DEVBLOCK 0x1482
# bgb::bgb_debug_text_display_init@2
DEVBLOCK 0x15aa
# bgb::bgb_set_debug_text@22
DEVBLOCK 0x171a
# bgb::bgb_print_stats@12
DEVBLOCK 0x18d2
# bgb::sub_consumable_bgb@ba
DEVBLOCK 0x1afa
# bgb::bgb_limit_monitor@1ca
DEVBLOCK 0x286a
# bgb::bgb_limit_monitor@31a
DEVBLOCK 0x29ba
# bgb::bgb_limit_monitor@3a6
DEVBLOCK 0x2a46
# bgb::bgb_limit_monitor@48e
DEVBLOCK 0x2b2e
# bgb::bgb_limit_monitor@50e
DEVBLOCK 0x2bae
# bgb::register@3a
DEVBLOCK 0x38f2
# bgb::register@5a
DEVBLOCK 0x3912
# bgb::register@aa
DEVBLOCK 0x3962
# bgb::register@ea
DEVBLOCK 0x39a2
# bgb::register@11a
DEVBLOCK 0x39d2
# bgb::register@14a
DEVBLOCK 0x3a02
# bgb::register@192
DEVBLOCK 0x3a4a
# bgb::register@1e4
DEVBLOCK 0x3a9c
# bgb::register@23a
DEVBLOCK 0x3af2
# bgb::register@27a
DEVBLOCK 0x3b32
# bgb::register@2ca
DEVBLOCK 0x3b82
# bgb::register@32e
DEVBLOCK 0x3be6
# bgb::register@386
DEVBLOCK 0x3c3e
# bgb::register_actor_damage_override@12
DEVBLOCK 0x3e02
# bgb::register_vehicle_damage_override@12
DEVBLOCK 0x3e7a
# bgb::register_actor_death_override@12
DEVBLOCK 0x3ef2
# bgb::register_lost_perk_override@1a
DEVBLOCK 0x3f72
# bgb::function_c2721e81@1a
DEVBLOCK 0x400a
# bgb::function_72469efe@12
DEVBLOCK 0x409a
# bgb::function_8a5d8cfb@12
DEVBLOCK 0x4112
# bgb::function_be42abb0@12
DEVBLOCK 0x418a
# bgb::function_afe7b8e7@a
DEVBLOCK 0x41fa
# bgb::function_e1f37ce7@a
DEVBLOCK 0x4272
# bgb::function_1fee6b3@12
DEVBLOCK 0x42f2
# bgb::function_1fee6b3@52
DEVBLOCK 0x4332
# bgb::give@3c
DEVBLOCK 0x43c4
# bgb::take@42
DEVBLOCK 0x45fa
# bgb::is_enabled@28
DEVBLOCK 0x4778
# bgb::any_enabled@2
DEVBLOCK 0x47da
# bgb::is_team_enabled@74
DEVBLOCK 0x4894
