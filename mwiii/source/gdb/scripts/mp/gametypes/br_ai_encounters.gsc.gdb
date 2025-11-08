NAME scripts\mp\gametypes\br_ai_encounters.gsc
VERSION 0
CHECKSUM 0xdbd96c1d
######################################################
####################  DEV STRINGS  ###################
######################################################
# br_ai_encounters::condition_anyplayerinsideradius@b3 br_ai_encounters::condition_allplayersoutsideradius@b6 br_ai_encounters::condition_maxaliveplayers@ae
STRING "<dev string:x103>" 0x1b79 0x1c45 0x1f31
# br_ai_encounters::condition_allplayersoutsideradius@9d
STRING "<dev string:x108>" 0x1c2c
# br_ai_encounters::condition_allplayersoutsideradius@ae
STRING "<dev string:x113>" 0x1c3d
# br_ai_encounters::condition_insafecircle@60 br_ai_encounters::condition_circlecount@59
STRING "<dev string:x123>" 0x1cca 0x1d75
# br_ai_encounters::condition_insafecircle@9a
STRING "<dev string:x13a>" 0x1d04
# br_ai_encounters::condition_circlecount@7c
STRING "<dev string:x15d>" 0x1d98
# br_ai_encounters::condition_circlecount@83 br_ai_encounters::condition_circlesremaining@ae
STRING "<dev string:x170>" 0x1d9f 0x1e68
# br_ai_encounters::condition_circlesremaining@61
STRING "<dev string:x178>" 0x1e1b
# br_ai_encounters::condition_circlesremaining@a7
STRING "<dev string:x19c>" 0x1e61
# br_ai_encounters::condition_maxaliveplayers@48
STRING "<dev string:x1b3>" 0x1ecb
# br_ai_encounters::init@4a br_ai_encounters::function_674facc5e1cb84c@6
STRING "<dev string:x1c>" 0xe5f 0x59f2
# br_ai_encounters::condition_maxaliveplayers@9f
STRING "<dev string:x1d5>" 0x1f22
# br_ai_encounters::condition_maxaliveplayers@a6
STRING "<dev string:x1ef>" 0x1f29
# br_ai_encounters::condition_maxactivelocations@32
STRING "<dev string:x1fb>" 0x1f7c
# br_ai_encounters::condition_maxactivelocations@39
STRING "<dev string:x203>" 0x1f83
# br_ai_encounters::condition_mintimepassed@31
STRING "<dev string:x21a>" 0x1fcd
# br_ai_encounters::condition_mintimepassed@3d br_ai_encounters::condition_lastencounterstarttime@78
STRING "<dev string:x23b>" 0x1fd9 0x206c
# br_ai_encounters::condition_lastencounterstarttime@6c
STRING "<dev string:x240>" 0x2060
# br_ai_encounters::init_encounter@75 br_ai_encounters::function_1535016662214ec5@6
STRING "<dev string:x24>" 0x1363 0x5a0b
# br_ai_encounters::condition_prematchdone@21
STRING "<dev string:x262>" 0x20a8
# br_ai_encounters::condition_prematchdone@43
STRING "<dev string:x27a>" 0x20ca
# br_ai_encounters::failcondition_noplayersinengagedradius@6f
STRING "<dev string:x28f>" 0x21cd
# br_ai_encounters::failcondition_noplayersinengagedradius@62
STRING "<dev string:x2b9>" 0x21c0
# br_ai_encounters::failcondition_noplayersinengagedradius@69
STRING "<dev string:x2cc>" 0x21c7
# br_ai_encounters::failcondition_outsidedangercircle@9e br_ai_encounters::failcondition_outsidedangercircle@cd
STRING "<dev string:x2d1>" 0x2286 0x22b5
# br_ai_encounters::failcondition_outsidedangercircle@99
STRING "<dev string:x2f6>" 0x2281
# br_ai_encounters::init_encounter@8a
STRING "<dev string:x31>" 0x1378
# br_ai_encounters::failcondition_outsidedangercircle@bf
STRING "<dev string:x329>" 0x22a7
# br_ai_encounters::rewardspawn@8f
STRING "<dev string:x33d>" 0x28bb
# br_ai_encounters::spawn_agent@19
STRING "<dev string:x356>" 0x2d40
# br_ai_encounters::spawn_agent@161
STRING "<dev string:x38e>" 0x2e88
# br_ai_encounters::spawn_agent@178
STRING "<dev string:x3b0>" 0x2e9f
# br_ai_encounters::spawn_agent@190
STRING "<dev string:x3bb>" 0x2eb7
# br_ai_encounters::truck_encounterstart@18a br_ai_encounters::truck_encounterstart@1c6
STRING "<dev string:x3c8>" 0x4025 0x4061
# br_ai_encounters::truck_encounterstart@185
STRING "<dev string:x3ec>" 0x4020
# br_ai_encounters::function_90d5fe589f383968@18
STRING "<dev string:x409>" 0x421c
# br_ai_encounters::function_90d5fe589f383968@1f br_ai_encounters::function_a7b476bcb852aa88@27
STRING "<dev string:x421>" 0x4223 0x67bd
# br_ai_encounters::crateguard_encounterstart@166 br_ai_encounters::crateguard_encounterstart@1a4
STRING "<dev string:x432>" 0x4469 0x44a7
# br_ai_encounters::init_encounter@91
STRING "<dev string:x44>" 0x137f
# br_ai_encounters::crateguard_encounterstart@161
STRING "<dev string:x45b>" 0x4464
# br_ai_encounters::extraction_encounterstart@45
STRING "<dev string:x478>" 0x5398
# br_ai_encounters::extraction_checkescortradius@f
STRING "<dev string:x48c>" 0x583b
# br_ai_encounters::extraction_attachfultonballoontoescort@f
STRING "<dev string:x49e>" 0x58de
# br_ai_encounters::function_8ff83bdd5420ae28@28
STRING "<dev string:x4b1>" 0x5a5f
# br_ai_encounters::function_8ff83bdd5420ae28@33
STRING "<dev string:x4c0>" 0x5a6a
# br_ai_encounters::function_8ff83bdd5420ae28@3a
STRING "<dev string:x4d3>" 0x5a71
# br_ai_encounters::function_8ff83bdd5420ae28@42
STRING "<dev string:x4e7>" 0x5a79
# br_ai_encounters::encounter_hud@12c
STRING "<dev string:x4ed>" 0x5ef6
# br_ai_encounters::encounter_hud@190 br_ai_encounters::encounter_hud@324
STRING "<dev string:x500>" 0x5f5a 0x60ee
# br_ai_encounters::encounter_hud@1a1
STRING "<dev string:x504>" 0x5f6b
# br_ai_encounters::encounter_hud@1b3 br_ai_encounters::encounter_hud@1e0
STRING "<dev string:x50a>" 0x5f7d 0x5faa
# br_ai_encounters::encounter_hud@20a
STRING "<dev string:x511>" 0x5fd4
# br_ai_encounters::encounter_hud@213
STRING "<dev string:x51b>" 0x5fdd
# br_ai_encounters::encounter_hud@225 br_ai_encounters::encounter_hud@256
STRING "<dev string:x52e>" 0x5fef 0x6020
# br_ai_encounters::encounter_hud@244
STRING "<dev string:x53e>" 0x600e
# br_ai_encounters::encounter_hud@283
STRING "<dev string:x550>" 0x604d
# br_ai_encounters::encounter_hud@296
STRING "<dev string:x562>" 0x6060
# br_ai_encounters::encounter_hud@33d
STRING "<dev string:x570>" 0x6107
# br_ai_encounters::function_6a540d657d267069@4d
STRING "<dev string:x575>" 0x62aa
# br_ai_encounters::init_location@41 br_ai_encounters::function_2f6185a84b023517@6
STRING "<dev string:x57>" 0x14b5 0x5a24
# br_ai_encounters::function_ecd35236fb86f2d3@1b
STRING "<dev string:x587>" 0x6328
# br_ai_encounters::function_ecd35236fb86f2d3@2c
STRING "<dev string:x58f>" 0x6339
# br_ai_encounters::function_ecd35236fb86f2d3@f7
STRING "<dev string:x59a>" 0x6404
# br_ai_encounters::function_ecd35236fb86f2d3@108
STRING "<dev string:x5a1>" 0x6415
# br_ai_encounters::function_ecd35236fb86f2d3@119 br_ai_encounters::function_ecd35236fb86f2d3@12b
STRING "<dev string:x5a9>" 0x6426 0x6438
# br_ai_encounters::function_5443af46fa933222@14
STRING "<dev string:x5b2>" 0x6461
# br_ai_encounters::function_5443af46fa933222@1a
STRING "<dev string:x5c0>" 0x6467
# br_ai_encounters::function_5443af46fa933222@20
STRING "<dev string:x5ce>" 0x646d
# br_ai_encounters::function_5443af46fa933222@26
STRING "<dev string:x5e6>" 0x6473
# br_ai_encounters::function_5443af46fa933222@2c
STRING "<dev string:x5fd>" 0x6479
# br_ai_encounters::encounter_devgui@47
STRING "<dev string:x608>" 0x650d
# br_ai_encounters::encounter_devgui@50
STRING "<dev string:x629>" 0x6516
# br_ai_encounters::encounter_devgui@5b br_ai_encounters::encounter_devgui@ae
STRING "<dev string:x639>" 0x6521 0x6574
# br_ai_encounters::init_location@56
STRING "<dev string:x63>" 0x14ca
# br_ai_encounters::encounter_devgui@70 br_ai_encounters::encounter_devgui@c3
STRING "<dev string:x648>" 0x6536 0x6589
# br_ai_encounters::encounter_devgui@80
STRING "<dev string:x650>" 0x6546
# br_ai_encounters::encounter_devgui@95 br_ai_encounters::encounter_devgui@10b
STRING "<dev string:x660>" 0x655b 0x65d1
# br_ai_encounters::encounter_devgui@a4
STRING "<dev string:x668>" 0x656a
# br_ai_encounters::encounter_devgui@d2
STRING "<dev string:x677>" 0x6598
# br_ai_encounters::encounter_devgui@e7
STRING "<dev string:x68b>" 0x65ad
# br_ai_encounters::encounter_devgui@f6
STRING "<dev string:x693>" 0x65bc
# br_ai_encounters::encounter_devgui@11a
STRING "<dev string:x6a3>" 0x65e0
# br_ai_encounters::encounter_devgui@123
STRING "<dev string:x6b4>" 0x65e9
# br_ai_encounters::encounter_devgui@162
STRING "<dev string:x6c3>" 0x6628
# br_ai_encounters::encounter_devgui@16a
STRING "<dev string:x6c8>" 0x6630
# br_ai_encounters::encounter_devgui@172 br_ai_encounters::function_8ddc84f18c877946@2be
STRING "<dev string:x6ce>" 0x6638 0x6afa
# br_ai_encounters::_addlocation@18
STRING "<dev string:x6d3>" 0x667b
# br_ai_encounters::_addlocation@2d br_ai_encounters::_addlocation@59 br_ai_encounters::_addlocation@85
STRING "<dev string:x6e5>" 0x6690 0x66bc 0x66e8
# br_ai_encounters::_addlocation@35 br_ai_encounters::_addlocation@61 br_ai_encounters::_addlocation@8d
STRING "<dev string:x6ea>" 0x6698 0x66c4 0x66f0
# br_ai_encounters::_addlocation@44
STRING "<dev string:x6f0>" 0x66a7
# br_ai_encounters::_addlocation@70
STRING "<dev string:x70a>" 0x66d3
# br_ai_encounters::function_8ddc84f18c877946@1be
STRING "<dev string:x721>" 0x69fa
# br_ai_encounters::function_8ddc84f18c877946@222
STRING "<dev string:x729>" 0x6a5e
# br_ai_encounters::function_8ddc84f18c877946@249
STRING "<dev string:x732>" 0x6a85
# br_ai_encounters::function_8ddc84f18c877946@251
STRING "<dev string:x738>" 0x6a8d
# br_ai_encounters::function_8ddc84f18c877946@2ad
STRING "<dev string:x73e>" 0x6ae9
# br_ai_encounters::function_ca0d43a35b898ad4@9b
STRING "<dev string:x744>" 0x6bbd
# br_ai_encounters::function_ca0d43a35b898ad4@b3
STRING "<dev string:x753>" 0x6bd5
# br_ai_encounters::function_ca0d43a35b898ad4@cb
STRING "<dev string:x772>" 0x6bed
# br_ai_encounters::init_location@70
STRING "<dev string:x98>" 0x14e4
# br_ai_encounters::init_location@81 br_ai_encounters::rewardspawn@96
STRING "<dev string:xc1>" 0x14f5 0x28c2
# br_ai_encounters::condition_disabled@19
STRING "<dev string:xc6>" 0x1a54
# br_ai_encounters::condition_stateis@27
STRING "<dev string:xd2>" 0x1a90
# br_ai_encounters::condition_stateis@3c
STRING "<dev string:xdc>" 0x1aa5
# br_ai_encounters::condition_anyplayerinsideradius@ac
STRING "<dev string:xea>" 0x1b72
######################################################
####################  DEV BLOCKS  ####################
######################################################
# br_ai_encounters::init@46
DEVBLOCK 0xe5b
# br_ai_encounters::init@7d
DEVBLOCK 0xe92
# br_ai_encounters::add_encounter_start_function@a
DEVBLOCK 0xf9c
# br_ai_encounters::add_encounter_start_function@14
DEVBLOCK 0xfa6
# br_ai_encounters::init_encounters@8c
DEVBLOCK 0x1059
# br_ai_encounters::init_encounter@71
DEVBLOCK 0x135f
# br_ai_encounters::init_encounter@85
DEVBLOCK 0x1373
# br_ai_encounters::init_locations@23
DEVBLOCK 0x1409
# br_ai_encounters::init_location@1c
DEVBLOCK 0x1490
# br_ai_encounters::init_location@3d
DEVBLOCK 0x14b1
# br_ai_encounters::init_location@51
DEVBLOCK 0x14c5
# br_ai_encounters::init_location@6b
DEVBLOCK 0x14df
# br_ai_encounters::init_location@f8
DEVBLOCK 0x156c
# br_ai_encounters::encounter_manager@b
DEVBLOCK 0x159d
# br_ai_encounters::check_encounter_start_conditions@1
DEVBLOCK 0x16e5
# br_ai_encounters::check_location_start_conditions@1
DEVBLOCK 0x1707
# br_ai_encounters::check_start_conditions@d8
DEVBLOCK 0x1809
# br_ai_encounters::encounter_start@3f
DEVBLOCK 0x186f
# br_ai_encounters::encounter_start_functions@a
DEVBLOCK 0x18c0
# br_ai_encounters::encounter_end@7b
DEVBLOCK 0x198d
# br_ai_encounters::condition_disabled@a
DEVBLOCK 0x1a45
# br_ai_encounters::condition_disabled@14
DEVBLOCK 0x1a4f
# br_ai_encounters::condition_stateis@a
DEVBLOCK 0x1a73
# br_ai_encounters::condition_stateis@22
DEVBLOCK 0x1a8b
# br_ai_encounters::condition_anyplayerinsideradius@34
DEVBLOCK 0x1afa
# br_ai_encounters::condition_anyplayerinsideradius@a7
DEVBLOCK 0x1b6d
# br_ai_encounters::condition_allplayersoutsideradius@34
DEVBLOCK 0x1bc3
# br_ai_encounters::condition_allplayersoutsideradius@98
DEVBLOCK 0x1c27
# br_ai_encounters::condition_insafecircle@1b
DEVBLOCK 0x1c85
# br_ai_encounters::condition_insafecircle@5b
DEVBLOCK 0x1cc5
# br_ai_encounters::condition_insafecircle@95
DEVBLOCK 0x1cff
# br_ai_encounters::condition_circlecount@14
DEVBLOCK 0x1d30
# br_ai_encounters::condition_circlecount@54
DEVBLOCK 0x1d70
# br_ai_encounters::condition_circlecount@77
DEVBLOCK 0x1d93
# br_ai_encounters::condition_circlesremaining@1c
DEVBLOCK 0x1dd6
# br_ai_encounters::condition_circlesremaining@5c
DEVBLOCK 0x1e16
# br_ai_encounters::condition_circlesremaining@a2
DEVBLOCK 0x1e5c
# br_ai_encounters::condition_maxaliveplayers@2c
DEVBLOCK 0x1eaf
# br_ai_encounters::condition_maxaliveplayers@43
DEVBLOCK 0x1ec6
# br_ai_encounters::condition_maxaliveplayers@9a
DEVBLOCK 0x1f1d
# br_ai_encounters::condition_maxactivelocations@a
DEVBLOCK 0x1f54
# br_ai_encounters::condition_maxactivelocations@2d
DEVBLOCK 0x1f77
# br_ai_encounters::condition_mintimepassed@14
DEVBLOCK 0x1fb0
# br_ai_encounters::condition_mintimepassed@2c
DEVBLOCK 0x1fc8
# br_ai_encounters::condition_lastencounterstarttime@1c
DEVBLOCK 0x2010
# br_ai_encounters::condition_lastencounterstarttime@67
DEVBLOCK 0x205b
# br_ai_encounters::condition_prematchdone@1
DEVBLOCK 0x2088
# br_ai_encounters::condition_prematchdone@1c
DEVBLOCK 0x20a3
# br_ai_encounters::condition_prematchdone@3e
DEVBLOCK 0x20c5
# br_ai_encounters::condition_debugpaused@1
DEVBLOCK 0x20e0
# br_ai_encounters::condition_debugpaused@1d
DEVBLOCK 0x20fc
# br_ai_encounters::failcondition_noplayersinengagedradius@1b
DEVBLOCK 0x2179
# br_ai_encounters::failcondition_noplayersinengagedradius@5e
DEVBLOCK 0x21bc
# br_ai_encounters::failcondition_outsidedangercircle@22
DEVBLOCK 0x220a
# br_ai_encounters::failcondition_outsidedangercircle@95
DEVBLOCK 0x227d
# br_ai_encounters::failcondition_outsidedangercircle@bb
DEVBLOCK 0x22a3
# br_ai_encounters::rewardspawn@8a
DEVBLOCK 0x28b6
# br_ai_encounters::spawn_agent@14
DEVBLOCK 0x2d3b
# br_ai_encounters::spawn_agent@152
DEVBLOCK 0x2e79
# br_ai_encounters::spawn_agent@15c
DEVBLOCK 0x2e83
# br_ai_encounters::root_ecounterstart@1
DEVBLOCK 0x2fbe
# br_ai_encounters::root_ecounterstart@23
DEVBLOCK 0x2fe0
# br_ai_encounters::root_monitorplayers@99
DEVBLOCK 0x31c6
# br_ai_encounters::bank_ecounterstart@b2
DEVBLOCK 0x354a
# br_ai_encounters::truck_encounterstart@174
DEVBLOCK 0x400f
# br_ai_encounters::truck_encounterstart@181
DEVBLOCK 0x401c
# br_ai_encounters::truck_encounterstart@1c2
DEVBLOCK 0x405d
# br_ai_encounters::function_90d5fe589f383968@14
DEVBLOCK 0x4218
# br_ai_encounters::crateguard_encounterstart@fa
DEVBLOCK 0x43fd
# br_ai_encounters::crateguard_encounterstart@15d
DEVBLOCK 0x4460
# br_ai_encounters::crateguard_encounterstart@1a0
DEVBLOCK 0x44a3
# br_ai_encounters::ai_notetrack_loop@82
DEVBLOCK 0x4c3a
# br_ai_encounters::test_ecounterstart@1
DEVBLOCK 0x4cae
# br_ai_encounters::dom_encounterstart@4b
DEVBLOCK 0x4d20
# br_ai_encounters::dom_encounterstart@b2
DEVBLOCK 0x4d87
# br_ai_encounters::dom_encounterstart@1ea
DEVBLOCK 0x4ebf
# br_ai_encounters::bombplant_encounterstart@1
DEVBLOCK 0x5340
# br_ai_encounters::extraction_encounterstart@2b
DEVBLOCK 0x537e
# br_ai_encounters::extraction_encounterstart@40
DEVBLOCK 0x5393
# br_ai_encounters::extraction_checkescortradius@a
DEVBLOCK 0x5836
# br_ai_encounters::extraction_attachfultonballoontoescort@a
DEVBLOCK 0x58d9
# br_ai_encounters::destruction_encounterstart@33
DEVBLOCK 0x5955
# br_ai_encounters::function_674facc5e1cb84c@1
DEVBLOCK 0x59ed
# br_ai_encounters::function_1535016662214ec5@1
DEVBLOCK 0x5a06
# br_ai_encounters::function_2f6185a84b023517@1
DEVBLOCK 0x5a1f
# br_ai_encounters::function_8ff83bdd5420ae28@14
DEVBLOCK 0x5a4b
# br_ai_encounters::function_8ff83bdd5420ae28@2e
DEVBLOCK 0x5a65
# br_ai_encounters::function_5bb507603ca9de76@a
DEVBLOCK 0x5a99
# br_ai_encounters::init_debug@1
DEVBLOCK 0x5ab0
# br_ai_encounters::function_e0b65595a00c4889@1b
DEVBLOCK 0x5b1f
# br_ai_encounters::function_e0b65595a00c4889@25
DEVBLOCK 0x5b29
# br_ai_encounters::function_20b9ab28a71f8361@34
DEVBLOCK 0x5c0f
# br_ai_encounters::function_20b9ab28a71f8361@3e
DEVBLOCK 0x5c19
# br_ai_encounters::function_ab390a4e188862f0@1
DEVBLOCK 0x5cb0
# br_ai_encounters::function_5ca1479bb38ceccd@1
DEVBLOCK 0x5cd2
# br_ai_encounters::compare_locations@3c
DEVBLOCK 0x5d2e
# br_ai_encounters::encounter_hud@ab
DEVBLOCK 0x5e75
# br_ai_encounters::function_6a540d657d267069@14
DEVBLOCK 0x6271
# br_ai_encounters::function_67ab032b2db3d203@14
DEVBLOCK 0x62cc
# br_ai_encounters::function_ecd35236fb86f2d3@b
DEVBLOCK 0x6318
# br_ai_encounters::function_5443af46fa933222@a
DEVBLOCK 0x6457
# br_ai_encounters::encounter_devgui@43
DEVBLOCK 0x6509
# br_ai_encounters::_addlocation@12
DEVBLOCK 0x6675
# br_ai_encounters::adddebugcommanddelayed@a
DEVBLOCK 0x670f
# br_ai_encounters::function_a7b476bcb852aa88@23
DEVBLOCK 0x67b9
# br_ai_encounters::function_8ddc84f18c877946@94
DEVBLOCK 0x68d0
# br_ai_encounters::function_ca0d43a35b898ad4@33
DEVBLOCK 0x6b55
