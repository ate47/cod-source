NAME scripts\mp\damage.gsc
VERSION 0
CHECKSUM 0x249c5dd4
######################################################
####################  DEV STRINGS  ###################
######################################################
# damage::postplayerdamaged@a1f
STRING "<dev string:x11a>" 0x62d5
# damage::cac_modified_damage@3bf
STRING "<dev string:x178>" 0x6ea0
# damage::adjustbulletstokill@84
STRING "<dev string:x1bf>" 0x85f0
# damage::callback_playerdamage_internal@4b9
STRING "<dev string:x1c>" 0x42ca
# damage::function_49f3d4de0e352093@a5
STRING "<dev string:x21e>" 0x9c1f
# damage::function_49f3d4de0e352093@b0
STRING "<dev string:x22d>" 0x9c2a
# damage::function_49f3d4de0e352093@bc
STRING "<dev string:x243>" 0x9c36
# damage::function_49f3d4de0e352093@9b
STRING "<dev string:x251>" 0x9c15
# damage::function_49f3d4de0e352093@3d4
STRING "<dev string:x288>" 0x9f4e
# damage::function_49f3d4de0e352093@3ce
STRING "<dev string:x2a1>" 0x9f48
# damage::playerkilled_parameterfixup@24
STRING "<dev string:x2dc>" 0xd20a
# damage::playerkilled_sharedlogic_early@443
STRING "<dev string:x2e9>" 0xe74f
# damage::playerkilled_sharedlogic_early@457
STRING "<dev string:x2f7>" 0xe763
# damage::playerkilled_handledeathtype@144
STRING "<dev string:x307>" 0xf813
# damage::callback_playerdamage_internal@505
STRING "<dev string:x30>" 0x4316
# damage::playerkilled_handledeathtype@155
STRING "<dev string:x320>" 0xf824
# damage::function_1306e8a08ab7bbab@58
STRING "<dev string:x325>" 0x14394
# damage::function_1306e8a08ab7bbab@d1
STRING "<dev string:x354>" 0x1440d
# damage::function_1306e8a08ab7bbab@146
STRING "<dev string:x37f>" 0x14482
# damage::callback_playerdamage@b1
STRING "<dev string:x3ae>" 0x1553a
# damage::finishplayerdamagewrapper@366
STRING "<dev string:x3e8>" 0x15a9d
# damage::finishplayerdamagewrapper@548 damage::finishplayerdamagewrapper@5b5
STRING "<dev string:x42f>" 0x15c7f 0x15cec
# damage::finishplayerdamagewrapper@553 damage::finishplayerdamagewrapper@5c0
STRING "<dev string:x435>" 0x15c8a 0x15cf7
# damage::finishplayerdamagewrapper@563
STRING "<dev string:x43b>" 0x15c9a
# damage::callback_playerdamage_internal@54c
STRING "<dev string:x46>" 0x435d
# damage::finishplayerdamagewrapper@573
STRING "<dev string:x474>" 0x15caa
# damage::finishplayerdamagewrapper@57c
STRING "<dev string:x489>" 0x15cb3
# damage::finishplayerdamagewrapper@5d0
STRING "<dev string:x494>" 0x15d07
# damage::finishplayerdamagewrapper@5e0
STRING "<dev string:x4ce>" 0x15d17
# damage::updatecombatrecordkillstats@90
STRING "<dev string:x4d9>" 0x1821a
# damage::shouldrecorddamagestats@f
STRING "<dev string:x538>" 0x187ea
# damage::function_87dfbd72f4fdd76f@1a6
STRING "<dev string:x57a>" 0x19810
# damage::function_87dfbd72f4fdd76f@1ad
STRING "<dev string:x598>" 0x19817
# damage::function_f7060d6be77fc6a2@2a
STRING "<dev string:x5a5>" 0x198d3
# damage::function_3e0f845008bbd48d@f
STRING "<dev string:x5c7>" 0x19ad2
# damage::callback_playerdamage_internal@b93
STRING "<dev string:x5f>" 0x49a4
# damage::function_18c42af5777dcd9f@26 damage::function_f9249bb06eb48092@17
STRING "<dev string:x622>" 0x19b7a 0x19cea
# damage::function_18c42af5777dcd9f@43 damage::function_f9249bb06eb48092@42
STRING "<dev string:x62e>" 0x19b97 0x19d15
# damage::function_18c42af5777dcd9f@60 damage::function_f9249bb06eb48092@6d
STRING "<dev string:x638>" 0x19bb4 0x19d40
# damage::function_18c42af5777dcd9f@7d damage::function_f9249bb06eb48092@98
STRING "<dev string:x642>" 0x19bd1 0x19d6b
# damage::function_18c42af5777dcd9f@9a damage::function_f9249bb06eb48092@c3
STRING "<dev string:x64f>" 0x19bee 0x19d96
# damage::function_18c42af5777dcd9f@b7 damage::function_f9249bb06eb48092@ee
STRING "<dev string:x65f>" 0x19c0b 0x19dc1
# damage::function_18c42af5777dcd9f@d4 damage::function_f9249bb06eb48092@119
STRING "<dev string:x66c>" 0x19c28 0x19dec
# damage::function_18c42af5777dcd9f@f1 damage::function_f9249bb06eb48092@144
STRING "<dev string:x67d>" 0x19c45 0x19e17
# damage::function_18c42af5777dcd9f@10e damage::function_f9249bb06eb48092@16f
STRING "<dev string:x68c>" 0x19c62 0x19e42
# damage::function_18c42af5777dcd9f@12b damage::function_f9249bb06eb48092@19a
STRING "<dev string:x696>" 0x19c7f 0x19e6d
# damage::function_18c42af5777dcd9f@148 damage::function_f9249bb06eb48092@1c5
STRING "<dev string:x6a6>" 0x19c9c 0x19e98
# damage::function_18c42af5777dcd9f@165 damage::function_f9249bb06eb48092@1f0
STRING "<dev string:x6bb>" 0x19cb9 0x19ec3
# damage::function_f9249bb06eb48092@12
STRING "<dev string:x6ca>" 0x19ce5
# damage::function_f9249bb06eb48092@3d
STRING "<dev string:x71c>" 0x19d10
# damage::function_f9249bb06eb48092@68
STRING "<dev string:x76c>" 0x19d3b
# damage::function_f9249bb06eb48092@93
STRING "<dev string:x7bc>" 0x19d66
# damage::function_f9249bb06eb48092@be
STRING "<dev string:x80f>" 0x19d91
# damage::function_f9249bb06eb48092@e9
STRING "<dev string:x865>" 0x19dbc
# damage::function_f9249bb06eb48092@114
STRING "<dev string:x8b8>" 0x19de7
# damage::function_f9249bb06eb48092@13f
STRING "<dev string:x90f>" 0x19e12
# damage::function_f9249bb06eb48092@16a
STRING "<dev string:x964>" 0x19e3d
# damage::function_f9249bb06eb48092@195
STRING "<dev string:x9b4>" 0x19e68
# damage::function_f9249bb06eb48092@1c0
STRING "<dev string:xa0a>" 0x19e93
# damage::function_f9249bb06eb48092@1eb
STRING "<dev string:xa65>" 0x19ebe
# damage::function_af3ebb9d1ecd18e7@12
STRING "<dev string:xaba>" 0x19eff
# damage::function_1b7b7da2e72eeffe@30
STRING "<dev string:xaf8>" 0x19f52
# damage::preplayerdamaged@133
STRING "<dev string:xaf>" 0x5575
# damage::function_1b7b7da2e72eeffe@66 damage::function_1b7b7da2e72eeffe@6d
STRING "<dev string:xb06>" 0x19f88 0x19f8f
# damage::function_1b7b7da2e72eeffe@91
STRING "<dev string:xb1d>" 0x19fb3
# damage::function_1b7b7da2e72eeffe@d7
STRING "<dev string:xb26>" 0x19ff9
# damage::function_1b7b7da2e72eeffe@de
STRING "<dev string:xb38>" 0x1a000
# damage::function_1b7b7da2e72eeffe@e6
STRING "<dev string:xb4a>" 0x1a008
# damage::preplayerdamaged@3fe
STRING "<dev string:xbd>" 0x5840
######################################################
####################  DEV BLOCKS  ####################
######################################################
# damage::callback_playerdamage_internal@49f
DEVBLOCK 0x42b0
# damage::callback_playerdamage_internal@b8e
DEVBLOCK 0x499f
# damage::preplayerdamaged@121
DEVBLOCK 0x5563
# damage::preplayerdamaged@3f9
DEVBLOCK 0x583b
# damage::postplayerdamaged@46f
DEVBLOCK 0x5d25
# damage::postplayerdamaged@a1a
DEVBLOCK 0x62d0
# damage::cac_modified_damage@14c
DEVBLOCK 0x6c2d
# damage::cac_modified_damage@167
DEVBLOCK 0x6c48
# damage::cac_modified_damage@3ba
DEVBLOCK 0x6e9b
# damage::modify_juggernaut_damage@4e7
DEVBLOCK 0x790e
# damage::adjustbulletstokill@7f
DEVBLOCK 0x85eb
# damage::function_49f3d4de0e352093@96
DEVBLOCK 0x9c10
# damage::function_49f3d4de0e352093@3c9
DEVBLOCK 0x9f43
# damage::playerkilled_parameterfixup@a
DEVBLOCK 0xd1f0
# damage::playerkilled_parameterfixup@2d6
DEVBLOCK 0xd4bc
# damage::playerkilled_parameterfixup@2e1
DEVBLOCK 0xd4c7
# damage::playerkilled_precalc@28d
DEVBLOCK 0xe2ed
# damage::playerkilled_precalc@298
DEVBLOCK 0xe2f8
# damage::playerkilled_sharedlogic_early@423
DEVBLOCK 0xe72f
# damage::playerkilled_sharedlogic_early@e29
DEVBLOCK 0xf135
# damage::playerkilled_sharedlogic_early@e35
DEVBLOCK 0xf141
# damage::playerkilled_handledeathtype@13f
DEVBLOCK 0xf80e
# damage::playerkilled_handledeathtype@1cc
DEVBLOCK 0xf89b
# damage::playerkilled_handledeathtype@1d7
DEVBLOCK 0xf8a6
# damage::playerkilled_sharedlogic_late@32d
DEVBLOCK 0xfbe7
# damage::playerkilled_sharedlogic_late@338
DEVBLOCK 0xfbf2
# damage::playerkilled_handlecorpse@21f
DEVBLOCK 0xfe25
# damage::playerkilled_killcamsetup@193
DEVBLOCK 0x10a1e
# damage::playerkilled_killcamsetup@3bf
DEVBLOCK 0x10c4a
# damage::playerkilled_killcamsetup@3cb
DEVBLOCK 0x10c56
# damage::playerkilled_deathscene@10f
DEVBLOCK 0x10d7a
# damage::playerkilled_killcam@407
DEVBLOCK 0x11195
# damage::handleteamchangedeath@e
DEVBLOCK 0x114d8
# damage::handleworlddeath@9d
DEVBLOCK 0x115f1
# damage::handleinlaststanddeath@138
DEVBLOCK 0x11bbb
# damage::handleinlaststanddeath@1c3
DEVBLOCK 0x11c46
# damage::handlenormaldeath_sounds@3b4
DEVBLOCK 0x1221b
# damage::handlenormaldeath@1058
DEVBLOCK 0x1334c
# damage::function_1306e8a08ab7bbab@53
DEVBLOCK 0x1438f
# damage::function_1306e8a08ab7bbab@cc
DEVBLOCK 0x14408
# damage::function_1306e8a08ab7bbab@141
DEVBLOCK 0x1447d
# damage::callback_playerdamage@ac
DEVBLOCK 0x15535
# damage::finishplayerdamagewrapper@361
DEVBLOCK 0x15a98
# damage::finishplayerdamagewrapper@543
DEVBLOCK 0x15c7a
# damage::finishplayerdamagewrapper@5b0
DEVBLOCK 0x15ce7
# damage::isforcedlaststand@57
DEVBLOCK 0x16ac5
# damage::updatecombatrecordkillstats@8b
DEVBLOCK 0x18215
# damage::shouldrecorddamagestats@a
DEVBLOCK 0x187e5
# damage::function_87dfbd72f4fdd76f@1a1
DEVBLOCK 0x1980b
# damage::function_f7060d6be77fc6a2@25
DEVBLOCK 0x198ce
# damage::function_3e0f845008bbd48d@a
DEVBLOCK 0x19acd
# damage::function_18c42af5777dcd9f@a
DEVBLOCK 0x19b5e
# damage::function_f9249bb06eb48092@a
DEVBLOCK 0x19cdd
# damage::function_f9249bb06eb48092@d
DEVBLOCK 0x19ce0
# damage::function_f9249bb06eb48092@38
DEVBLOCK 0x19d0b
# damage::function_f9249bb06eb48092@63
DEVBLOCK 0x19d36
# damage::function_f9249bb06eb48092@8e
DEVBLOCK 0x19d61
# damage::function_f9249bb06eb48092@b9
DEVBLOCK 0x19d8c
# damage::function_f9249bb06eb48092@e4
DEVBLOCK 0x19db7
# damage::function_f9249bb06eb48092@10f
DEVBLOCK 0x19de2
# damage::function_f9249bb06eb48092@13a
DEVBLOCK 0x19e0d
# damage::function_f9249bb06eb48092@165
DEVBLOCK 0x19e38
# damage::function_f9249bb06eb48092@190
DEVBLOCK 0x19e63
# damage::function_f9249bb06eb48092@1bb
DEVBLOCK 0x19e8e
# damage::function_f9249bb06eb48092@1e6
DEVBLOCK 0x19eb9
# damage::function_af3ebb9d1ecd18e7@a
DEVBLOCK 0x19ef7
# damage::function_af3ebb9d1ecd18e7@d
DEVBLOCK 0x19efa
# damage::function_1b7b7da2e72eeffe@2c
DEVBLOCK 0x19f4e
