NAME scripts\engine\trace.gsc
VERSION 0
CHECKSUM 0xc9e939cf
######################################################
####################  DEV STRINGS  ###################
######################################################
# trace::player_trace_passed@4a
STRING "<dev string:x12c>" 0x1345
# trace::player_get_closest_point@52
STRING "<dev string:x163>" 0x142c
# trace::ai_trace@5a trace::ai_trace_passed@4a trace::ai_get_closest_point@52
STRING "<dev string:x19f>" 0x1534 0x173c 0x17de
# trace::ai_trace_get_all_results@72
STRING "<dev string:x1c8>" 0x1640
# trace::ray_trace@9b trace::ray_trace_ents@b1 trace::ray_trace_detail@db trace::ray_trace_get_all_results@c3 trace::draw_trace_type@be
STRING "<dev string:x1c>" 0x497 0x55f 0x838 0x912 0x2577
# trace::draw_trace@5b trace::draw_trace@69 trace::draw_trace@9a trace::draw_trace@c2 trace::internal_create_debug_data@55 trace::internal_create_debug_data@65 trace::internal_create_debug_data@74 trace::internal_create_debug_data@83 trace::internal_create_debug_data@92 trace::internal_create_debug_data@a1 trace::internal_create_debug_data@b0 trace::internal_create_debug_data@bf
STRING "<dev string:x201>" 0x2067 0x2075 0x20a6 0x20ce 0x2946 0x2956 0x2965 0x2974 0x2983 0x2992 0x29a1 0x29b0
# trace::draw_trace_hit@7a trace::draw_trace_hit@ca trace::draw_trace_hit@e2 trace::draw_trace_hit@f4 trace::draw_trace_hit@149 trace::draw_trace_hit@174
STRING "<dev string:x20e>" 0x2160 0x21b0 0x21c8 0x21da 0x222f 0x225a
# trace::draw_trace_hit@e9 trace::draw_trace_hit@150 trace::draw_trace_hit@1fa
STRING "<dev string:x21a>" 0x21cf 0x2236 0x22e0
# trace::draw_trace_hit@135 trace::draw_trace_hit@140 trace::draw_trace_hit@24a trace::draw_trace_hit@26d
STRING "<dev string:x224>" 0x221b 0x2226 0x2330 0x2353
# trace::draw_trace_hit@16f
STRING "<dev string:x230>" 0x2255
# trace::can_see_origin@17
STRING "<dev string:x23>" 0x9ef
# trace::draw_trace_hit@182 trace::draw_trace_hit@1a5
STRING "<dev string:x23f>" 0x2268 0x228b
# trace::draw_trace_hit@1a0
STRING "<dev string:x251>" 0x2286
# trace::draw_trace_hit@1d0
STRING "<dev string:x260>" 0x22b6
# trace::draw_trace_hit@1f5
STRING "<dev string:x275>" 0x22db
# trace::draw_trace_hit@20f trace::draw_trace_hit@232
STRING "<dev string:x281>" 0x22f5 0x2318
# trace::draw_trace_hit@22d
STRING "<dev string:x28d>" 0x2313
# trace::draw_trace_hit@268
STRING "<dev string:x29b>" 0x234e
# trace::draw_trace_hit@298
STRING "<dev string:x2a9>" 0x237e
# trace::draw_trace_hit@2aa trace::draw_trace_hit@2cd
STRING "<dev string:x2b3>" 0x2390 0x23b3
# trace::draw_trace_hit@2c8
STRING "<dev string:x2c2>" 0x23ae
# trace::draw_trace_hit@2f8
STRING "<dev string:x2d4>" 0x23de
# trace::draw_trace_hit@30a trace::draw_trace_hit@353 trace::draw_trace_hit@384
STRING "<dev string:x2f6>" 0x23f0 0x2439 0x246a
# trace::draw_trace_hit@328
STRING "<dev string:x300>" 0x240e
# trace::draw_trace_hit@34d
STRING "<dev string:x315>" 0x2433
# trace::draw_trace_hit@37f
STRING "<dev string:x328>" 0x2465
# trace::draw_trace_hit@3b9
STRING "<dev string:x33a>" 0x249f
# trace::draw_trace_type@ae trace::draw_trace_type@d8 trace::draw_trace_type@16c trace::draw_trace_type@2c2 trace::internal_create_debug_data@60
STRING "<dev string:x350>" 0x2567 0x2591 0x2625 0x277b 0x2951
# trace::draw_trace_type@b7 trace::draw_trace_type@137 trace::draw_trace_type@222 trace::draw_trace_type@232 trace::draw_trace_type@243 trace::internal_create_debug_data@50
STRING "<dev string:x359>" 0x2570 0x25f0 0x26db 0x26eb 0x26fc 0x2941
# trace::draw_trace_type@c7 trace::draw_trace_type@d1 trace::draw_trace_type@150 trace::draw_trace_type@15b trace::draw_trace_type@165 trace::draw_trace_type@2a6 trace::draw_trace_type@2b1 trace::draw_trace_type@2bb trace::internal_create_debug_data@6f
STRING "<dev string:x361>" 0x2580 0x258a 0x2609 0x2614 0x261e 0x275f 0x276a 0x2774 0x2960
# trace::draw_trace_type@147 trace::draw_trace_type@273 trace::draw_trace_type@28b trace::internal_create_debug_data@7e
STRING "<dev string:x368>" 0x2600 0x272c 0x2744 0x296f
# trace::draw_trace_type@25c trace::draw_trace_type@294 trace::internal_create_debug_data@9c
STRING "<dev string:x372>" 0x2715 0x274d 0x298d
# trace::draw_trace_type@27c
STRING "<dev string:x37c>" 0x2735
# trace::draw_trace_type@29d trace::internal_create_debug_data@8d
STRING "<dev string:x38b>" 0x2756 0x297e
# trace::internal_create_debug_data@ab
STRING "<dev string:x395>" 0x299c
# trace::can_see_origin@27
STRING "<dev string:x60>" 0x9ff
# trace::sphere_trace@a8 trace::sphere_trace_get_all_results@ae trace::sphere_get_closest_point@9f trace::draw_trace_type@13e
STRING "<dev string:x9a>" 0xafc 0xbc1 0xcd6 0x25f7
# trace::capsule_trace@f4 trace::capsule_trace_get_all_results@124 trace::capsule_get_closest_point@ef trace::draw_trace_type@229
STRING "<dev string:xa4>" 0xde1 0xf1c 0x10d2 0x26e2
# trace::player_trace@5a
STRING "<dev string:xaf>" 0x1143
# trace::player_trace@da trace::player_trace_get_all_results@10a trace::player_get_closest_point@e9 trace::ai_trace@dd trace::ai_trace_get_all_results@10d trace::ai_get_closest_point@d3 trace::draw_trace_type@239 trace::draw_trace_type@24a trace::draw_trace_type@250 trace::draw_trace_type@266 trace::internal_create_debug_data@ba
STRING "<dev string:xdf>" 0x11c3 0x12e4 0x14c3 0x15b7 0x16db 0x185f 0x26f2 0x2703 0x2709 0x271f 0x29ab
# trace::player_trace_get_all_results@72
STRING "<dev string:xec>" 0x124c
######################################################
####################  DEV BLOCKS  ####################
######################################################
# trace::ray_trace@92
DEVBLOCK 0x48e
# trace::ray_trace_ents@a8
DEVBLOCK 0x556
# trace::player_viewangles@4e
DEVBLOCK 0x5c4
# trace::ray_trace_detail@d2
DEVBLOCK 0x82f
# trace::ray_trace_get_all_results@ba
DEVBLOCK 0x909
# trace::can_see_origin@12
DEVBLOCK 0x9ea
# trace::can_see_origin@22
DEVBLOCK 0x9fa
# trace::sphere_trace@9d
DEVBLOCK 0xaf1
# trace::sphere_trace_get_all_results@a3
DEVBLOCK 0xbb6
# trace::sphere_get_closest_point@92
DEVBLOCK 0xcc9
# trace::capsule_trace@e5
DEVBLOCK 0xdd2
# trace::capsule_trace_get_all_results@115
DEVBLOCK 0xf0d
# trace::capsule_get_closest_point@df
DEVBLOCK 0x10c2
# trace::player_trace@55
DEVBLOCK 0x113e
# trace::player_trace@cb
DEVBLOCK 0x11b4
# trace::player_trace_get_all_results@6d
DEVBLOCK 0x1247
# trace::player_trace_get_all_results@fb
DEVBLOCK 0x12d5
# trace::player_trace_passed@45
DEVBLOCK 0x1340
# trace::player_get_closest_point@4d
DEVBLOCK 0x1427
# trace::player_get_closest_point@db
DEVBLOCK 0x14b5
# trace::ai_trace@55
DEVBLOCK 0x152f
# trace::ai_trace@ce
DEVBLOCK 0x15a8
# trace::ai_trace_get_all_results@6d
DEVBLOCK 0x163b
# trace::ai_trace_get_all_results@fe
DEVBLOCK 0x16cc
# trace::ai_trace_passed@45
DEVBLOCK 0x1737
# trace::ai_get_closest_point@4d
DEVBLOCK 0x17d9
# trace::ai_get_closest_point@c5
DEVBLOCK 0x1851
# trace::draw_trace@3c
DEVBLOCK 0x2048
# trace::draw_trace_hit@6c
DEVBLOCK 0x2152
# trace::draw_trace_type@8c
DEVBLOCK 0x2545
# trace::internal_create_debug_data@4a
DEVBLOCK 0x293b
