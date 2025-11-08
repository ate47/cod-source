NAME scripts\core_common\vehicle_shared.gsc
VERSION 0
CHECKSUM 0x753817c9
######################################################
####################  DEV STRINGS  ###################
######################################################
# vehicle::get_on_path@e0
STRING "<dev string:x127>" 0x3820
# vehicle::go_path@b8
STRING "<dev string:x14d>" 0x3c60
# vehicle::init@960
STRING "<dev string:x187>" 0x4f20
# vehicle::debug_set_speed@94 vehicle::debug_resume@54 vehicle::setup_dvars@3c vehicle::setup_dvars@94
STRING "<dev string:x1ba>" 0x567c 0x58ac 0x689c 0x68f4
# vehicle::debug_set_speed@b0
STRING "<dev string:x1c1>" 0x5698
# vehicle::script_resume_speed@138
STRING "<dev string:x1d7>" 0x5828
# vehicle::print_resume_speed@d8
STRING "<dev string:x1dd>" 0x5a68
# vehicle::setup_dynamic_detour@38
STRING "<dev string:x1f1>" 0x5bf8
# vehicle::node_trigger_process@17c
STRING "<dev string:x212>" 0x5e3c
# vehicle::setup_dvars@2c vehicle::setup_dvars@84 vehicle::debug_vehicle@3c vehicle::devgui_vehicle_spawn_think@74 vehicle::function_d53cf714@b0 vehicle::function_8b412f99@180
STRING "<dev string:x252>" 0x688c 0x68e4 0x90fc 0xbb64 0xc158 0xc410
# vehicle::get_vehiclenode_any_dynamic@80
STRING "<dev string:x256>" 0x6fb8
# vehicle::get_vehiclenode_any_dynamic@a8
STRING "<dev string:x276>" 0x6fe0
# vehicle::get_vehiclenode_any_dynamic@d4
STRING "<dev string:x287>" 0x700c
# vehicle::simple_spawn@a4
STRING "<dev string:x2bd>" 0x7924
# vehicle::simple_spawn@b0
STRING "<dev string:x2dd>" 0x7930
# vehicle::simple_spawn_single@84 vehicle::simple_spawn_single_and_drive@34
STRING "<dev string:x2e8>" 0x7aec 0x7b84
# vehicle::simple_spawn_single@90 vehicle::simple_spawn_single_and_drive@40
STRING "<dev string:x315>" 0x7af8 0x7b90
# vehicle::simple_spawn_single@a0 vehicle::simple_spawn_single_and_drive@50
STRING "<dev string:x32a>" 0x7b08 0x7ba0
# vehicle::debug_vehicle@a8
STRING "<dev string:x345>" 0x9168
# vehicle::debug_vehicle_paths@8c vehicle::debug_vehicle_paths@c0 vehicle::debug_vehicle_paths@f0
STRING "<dev string:x351>" 0x922c 0x9260 0x9290
# vehicle::add_main_callback@4c
STRING "<dev string:x35b>" 0x93ac
# vehicle::trigger_process@3dc
STRING "<dev string:x38>" 0x1db4
# vehicle::add_main_callback@58
STRING "<dev string:x38b>" 0x93b8
# vehicle::function_2798ed66@ec
STRING "<dev string:x3b8>" 0xa354
# vehicle::function_2798ed66@fc
STRING "<dev string:x3d7>" 0xa364
# vehicle::function_ea0f8324@160
STRING "<dev string:x3fa>" 0xa598
# vehicle::function_ea0f8324@1f8
STRING "<dev string:x412>" 0xa630
# vehicle::function_ea0f8324@288
STRING "<dev string:x432>" 0xa6c0
# vehicle::add_to_target_group@14 vehicle::remove_from_target_group@14 vehicle::monitor_missiles_locked_on_to_me@58 vehicle::get_closest_attacker_with_missile_locked_on_to_me@94
STRING "<dev string:x450>" 0xa8ec 0xa994 0xaa30 0xb044
# vehicle::function_3624d1c8@140 vehicle::function_3624d1c8@190
STRING "<dev string:x473>" 0xb640 0xb690
# vehicle::function_3624d1c8@264
STRING "<dev string:x479>" 0xb764
# vehicle::function_3624d1c8@270
STRING "<dev string:x48e>" 0xb770
# vehicle::devgui_vehicle_spawn_think@7c vehicle::devgui_vehicle_spawn_think@3fc vehicle::function_9db84b1b@58
STRING "<dev string:x49a>" 0xbb6c 0xbeec 0xc068
# vehicle::devgui_vehicle_spawn_think@b4
STRING "<dev string:x4ae>" 0xbba4
# vehicle::devgui_vehicle_spawn_think@d4
STRING "<dev string:x4c5>" 0xbbc4
# vehicle::devgui_vehicle_spawn_think@330
STRING "<dev string:x4fb>" 0xbe20
# vehicle::devgui_vehicle_spawn_think@354 vehicle::devgui_vehicle_spawn_think@388 vehicle::devgui_vehicle_spawn_think@3b8
STRING "<dev string:x52d>" 0xbe44 0xbe78 0xbea8
# vehicle::devgui_vehicle_spawn_think@348
STRING "<dev string:x534>" 0xbe38
# vehicle::devgui_vehicle_spawn_think@37c
STRING "<dev string:x53c>" 0xbe6c
# vehicle::devgui_vehicle_spawn_think@3ac
STRING "<dev string:x543>" 0xbe9c
# vehicle::function_f4c8a8ec@80
STRING "<dev string:x54a>" 0xbf98
# vehicle::function_9db84b1b@50
STRING "<dev string:x54f>" 0xc060
# vehicle::function_9db84b1b@60
STRING "<dev string:x55a>" 0xc070
# vehicle::function_9db84b1b@70
STRING "<dev string:x55f>" 0xc080
# vehicle::function_d53cf714@fc
STRING "<dev string:x566>" 0xc1a4
# vehicle::function_d53cf714@174
STRING "<dev string:x56e>" 0xc21c
# vehicle::function_8b412f99@f8
STRING "<dev string:x57e>" 0xc388
# vehicle::function_8b412f99@160
STRING "<dev string:x595>" 0xc3f0
# vehicle::function_8b412f99@1c0
STRING "<dev string:x5a1>" 0xc450
# vehicle::function_8b412f99@1cc
STRING "<dev string:x5c3>" 0xc45c
# vehicle::spline_debug@4c vehicle::_spline_debug@3c
STRING "<dev string:x5e2>" 0xc56c 0xc5d4
# vehicle::show_node_debug_info@28
STRING "<dev string:x5fb>" 0xc690
# vehicle::show_node_debug_info@38 vehicle::show_node_debug_info@74
STRING "<dev string:x608>" 0xc6a0 0xc6dc
# vehicle::show_node_debug_info@64
STRING "<dev string:x60d>" 0xc6cc
# vehicle::show_node_debug_info@a8
STRING "<dev string:x61a>" 0xc710
# vehicle::function_280e8883@1c
STRING "<dev string:x624>" 0xc7b4
# vehicle::function_280e8883@48
STRING "<dev string:x648>" 0xc7e0
# vehicle::function_fa8ced6e@68
STRING "<dev string:x6b1>" 0xe378
# vehicle::trigger_process@4f8
STRING "<dev string:x8b>" 0x1ed0
# vehicle::paths@4c
STRING "<dev string:xab>" 0x29a4
# vehicle::get_on_path@4c
STRING "<dev string:xd3>" 0x378c
# vehicle::get_on_path@b4
STRING "<dev string:xff>" 0x37f4
######################################################
####################  DEV BLOCKS  ####################
######################################################
# vehicle::postinit@32
DEVBLOCK 0x184a
# vehicle::trigger_process@3c8
DEVBLOCK 0x1da0
# vehicle::trigger_process@4e4
DEVBLOCK 0x1ebc
# vehicle::paths@42
DEVBLOCK 0x299a
# vehicle::paths@10a
DEVBLOCK 0x2a62
# vehicle::get_on_path@42
DEVBLOCK 0x3782
# vehicle::get_on_path@aa
DEVBLOCK 0x37ea
# vehicle::get_on_path@d6
DEVBLOCK 0x3816
# vehicle::function_af0fc980@a
DEVBLOCK 0x39ba
# vehicle::go_path@ae
DEVBLOCK 0x3c56
# vehicle::init@732
DEVBLOCK 0x4cf2
# vehicle::init@76a
DEVBLOCK 0x4d2a
# vehicle::init@95a
DEVBLOCK 0x4f1a
# vehicle::set_speed@48
DEVBLOCK 0x55a0
# vehicle::debug_set_speed@1a
DEVBLOCK 0x5602
# vehicle::script_resume_speed@12c
DEVBLOCK 0x581c
# vehicle::debug_resume@2a
DEVBLOCK 0x5882
# vehicle::print_resume_speed@c4
DEVBLOCK 0x5a54
# vehicle::setup_dynamic_detour@30
DEVBLOCK 0x5bf0
# vehicle::node_trigger_process@152
DEVBLOCK 0x5e12
# vehicle::setup_dvars@2
DEVBLOCK 0x6862
# vehicle::get_vehiclenode_any_dynamic@76
DEVBLOCK 0x6fae
# vehicle::get_vehiclenode_any_dynamic@ca
DEVBLOCK 0x7002
# vehicle::simple_spawn@9c
DEVBLOCK 0x791c
# vehicle::simple_spawn_single@7c
DEVBLOCK 0x7ae4
# vehicle::simple_spawn_single_and_drive@2c
DEVBLOCK 0x7b7c
# vehicle::spawn@2a
DEVBLOCK 0x7c8a
# vehicle::spawn@42
DEVBLOCK 0x7ca2
# vehicle::spawn@5a
DEVBLOCK 0x7cba
# vehicle::spawn@72
DEVBLOCK 0x7cd2
# vehicle::do_death_dynents@1a
DEVBLOCK 0x8512
# vehicle::debug_vehicle@2
DEVBLOCK 0x90c2
# vehicle::debug_vehicle_paths@a
DEVBLOCK 0x91aa
# vehicle::add_main_callback@2e
DEVBLOCK 0x938e
# vehicle::function_2798ed66@e4
DEVBLOCK 0xa34c
# vehicle::function_ea0f8324@11a
DEVBLOCK 0xa552
# vehicle::function_ea0f8324@1b4
DEVBLOCK 0xa5ec
# vehicle::function_ea0f8324@244
DEVBLOCK 0xa67c
# vehicle::add_to_target_group@a
DEVBLOCK 0xa8e2
# vehicle::remove_from_target_group@a
DEVBLOCK 0xa98a
# vehicle::monitor_missiles_locked_on_to_me@50
DEVBLOCK 0xaa28
# vehicle::get_closest_attacker_with_missile_locked_on_to_me@8a
DEVBLOCK 0xb03a
# vehicle::function_3624d1c8@5a
DEVBLOCK 0xb55a
# vehicle::function_ef1192d@12
DEVBLOCK 0xb7b2
# vehicle::function_40fc185b@3a
DEVBLOCK 0xb872
# vehicle::function_1f05ebe8@82
DEVBLOCK 0xb982
# vehicle::devgui_vehicle_spawn_think@5a
DEVBLOCK 0xbb4a
# vehicle::devgui_vehicle_spawn_think@ca
DEVBLOCK 0xbbba
# vehicle::function_f4c8a8ec@4a
DEVBLOCK 0xbf62
# vehicle::function_9db84b1b@2a
DEVBLOCK 0xc03a
# vehicle::function_d53cf714@12
DEVBLOCK 0xc0ba
# vehicle::function_8b412f99@22
DEVBLOCK 0xc2b2
# vehicle::spline_debug@2
DEVBLOCK 0xc522
# vehicle::_spline_debug@2a
DEVBLOCK 0xc5c2
# vehicle::show_node_debug_info@2
DEVBLOCK 0xc66a
# vehicle::print_debug_info@a
DEVBLOCK 0xc73a
# vehicle::function_280e8883@2
DEVBLOCK 0xc79a
# vehicle::function_cccd25de@3a
DEVBLOCK 0xc83a
# vehicle::function_60178221@cc
DEVBLOCK 0xd6bc
# vehicle::function_fa8ced6e@5a
DEVBLOCK 0xe36a
# vehicle::function_fa8ced6e@5e
DEVBLOCK 0xe36e
# vehicle::update_flare_ability@1a0
DEVBLOCK 0xe708
