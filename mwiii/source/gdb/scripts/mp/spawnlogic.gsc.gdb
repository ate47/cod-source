NAME scripts\mp\spawnlogic.gsc
VERSION 0
CHECKSUM 0x2e291a2c
######################################################
####################  DEV STRINGS  ###################
######################################################
# spawnlogic::getspawnpoint@166 spawnlogic::getspawnpoint@256
STRING "<dev string:x14c>" 0x1564 0x1654
# spawnlogic::getspawnpoint@175 spawnlogic::getspawnpoint@265
STRING "<dev string:x152>" 0x1573 0x1663
# spawnlogic::getspawnpoint@185 spawnlogic::getspawnpoint@275
STRING "<dev string:x15a>" 0x1583 0x1673
# spawnlogic::getspawnpoint@195 spawnlogic::getspawnpoint@285
STRING "<dev string:x166>" 0x1593 0x1683
# spawnlogic::getspawnpoint@1a5
STRING "<dev string:x16e>" 0x15a3
# spawnlogic::getspawnpoint@34a spawnlogic::getspawnpoint@35e spawnlogic::getspawnpoint@370 spawnlogic::getspawnpoint@380
STRING "<dev string:x174>" 0x1748 0x175c 0x176e 0x177e
# spawnlogic::getspawnpoint@4e1 spawnlogic::getspawnpoint@4f5 spawnlogic::getspawnpoint@507 spawnlogic::getspawnpoint@517
STRING "<dev string:x188>" 0x18df 0x18f3 0x1905 0x1915
# spawnlogic::getspawnpoint@61b spawnlogic::getspawnpoint@62f spawnlogic::getspawnpoint@63f
STRING "<dev string:x19e>" 0x1a19 0x1a2d 0x1a3d
# spawnlogic::setactivespawnlogic@11c
STRING "<dev string:x1b9>" 0x1fbd
# spawnlogic::codecallbackhandler_spawnpointscore@66
STRING "<dev string:x1c>" 0x12b6
# spawnlogic::setactivespawnlogic@124 spawnlogic::setactivespawnlogic@24e
STRING "<dev string:x1d1>" 0x1fc5 0x20ef
# spawnlogic::setactivespawnlogic@16b
STRING "<dev string:x1d6>" 0x200c
# spawnlogic::setactivespawnlogic@181
STRING "<dev string:x1dc>" 0x2022
# spawnlogic::setactivespawnlogic@189 spawnlogic::setactivespawnlogic@1ab spawnlogic::setactivespawnlogic@204 spawnlogic::setactivespawnlogic@218
STRING "<dev string:x1ef>" 0x202a 0x204c 0x20a5 0x20b9
# spawnlogic::setactivespawnlogic@1a3
STRING "<dev string:x1fc>" 0x2044
# spawnlogic::setactivespawnlogic@1c5 spawnlogic::setactivespawnlogic@225
STRING "<dev string:x214>" 0x2066 0x20c6
# spawnlogic::setactivespawnlogic@1f0
STRING "<dev string:x21a>" 0x2091
# spawnlogic::setactivespawnlogic@1fd
STRING "<dev string:x232>" 0x209e
# spawnlogic::setactivespawnlogic@211
STRING "<dev string:x24c>" 0x20b2
# spawnlogic::setactivespawnlogic@23e
STRING "<dev string:x261>" 0x20df
# spawnlogic::setactivespawnlogic@2bb
STRING "<dev string:x271>" 0x215c
# spawnlogic::setactivespawnlogic@3a4
STRING "<dev string:x2da>" 0x2245
# spawnlogic::setactivespawnlogic@3ac
STRING "<dev string:x313>" 0x224d
# spawnlogic::loadspawnlogicweights@88
STRING "<dev string:x348>" 0x2552
# spawnlogic::loadspawnlogicweights@15d
STRING "<dev string:x37c>" 0x2627
# spawnlogic::loadspawnlogicweights@1c2
STRING "<dev string:x3b9>" 0x268c
# spawnlogic::loadspawnlogicweights@220
STRING "<dev string:x3f6>" 0x26ea
# spawnlogic::loadspawnlogicweights@316
STRING "<dev string:x434>" 0x27e0
# spawnlogic::loadspawnlogicweights@330
STRING "<dev string:x477>" 0x27fa
# spawnlogic::loadspawnlogicweights@34a
STRING "<dev string:x4d6>" 0x2814
# spawnlogic::loadspawnlogicweights@3f2
STRING "<dev string:x53d>" 0x28bc
# spawnlogic::loadspawnlogicweights@46e
STRING "<dev string:x574>" 0x2938
# spawnlogic::loadspawnlogicweights@5e0 spawnlogic::loadspawnlogicweights@60f spawnlogic::loadspawnlogicweights@6e7
STRING "<dev string:x5ae>" 0x2aaa 0x2ad9 0x2bb1
# spawnlogic::loadspawnlogicweights@5cd
STRING "<dev string:x5b2>" 0x2a97
# spawnlogic::loadspawnlogicweights@5d4 spawnlogic::loadspawnlogicweights@603 spawnlogic::loadspawnlogicweights@636 spawnlogic::loadspawnlogicweights@6a0 spawnlogic::loadspawnlogicweights@6db spawnlogic::loadspawnlogicweights@75a
STRING "<dev string:x5e2>" 0x2a9e 0x2acd 0x2b00 0x2b6a 0x2ba5 0x2c24
# spawnlogic::loadspawnlogicweights@5fc
STRING "<dev string:x5e7>" 0x2ac6
# spawnlogic::loadspawnlogicweights@63d
STRING "<dev string:x61b>" 0x2b07
# spawnlogic::loadspawnlogicweights@647
STRING "<dev string:x625>" 0x2b11
# spawnlogic::loadspawnlogicweights@61f
STRING "<dev string:x631>" 0x2ae9
# spawnlogic::loadspawnlogicweights@626
STRING "<dev string:x64a>" 0x2af0
# spawnlogic::loadspawnlogicweights@62e
STRING "<dev string:x65c>" 0x2af8
# spawnlogic::loadspawnlogicweights@691 spawnlogic::loadspawnlogicweights@74b
STRING "<dev string:x66b>" 0x2b5b 0x2c15
# spawnlogic::loadspawnlogicweights@698 spawnlogic::loadspawnlogicweights@752
STRING "<dev string:x68c>" 0x2b62 0x2c1c
# spawnlogic::loadspawnlogicweights@6d4
STRING "<dev string:x6a5>" 0x2b9e
# spawnlogic::scorespawnpoint@39
STRING "<dev string:x6d5>" 0x2ca6
# spawnlogic::function_386623fc65375fa8@c8 spawnlogic::addspawnpoints@51 spawnlogic::function_9328a9c1fc8d2043@5f
STRING "<dev string:x728>" 0x2fdd 0x3263 0x32e8
# spawnlogic::function_386623fc65375fa8@d0 spawnlogic::addspawnpoints@58 spawnlogic::function_9328a9c1fc8d2043@72
STRING "<dev string:x738>" 0x2fe5 0x326a 0x32fb
# spawnlogic::function_9328a9c1fc8d2043@67
STRING "<dev string:x758>" 0x32f0
# spawnlogic::spawnpointinit@239
STRING "<dev string:x76a>" 0x368d
# spawnlogic::spawnpointinit@24a
STRING "<dev string:x77e>" 0x369e
# spawnlogic::getspawnpointfromcode@7d
STRING "<dev string:x7c7>" 0x3a51
# spawnlogic::spawnpointupdate@6a
STRING "<dev string:x7ec>" 0x4248
# spawnlogic::influencepoint_add@ca
STRING "<dev string:x7f1>" 0x46c0
# spawnlogic::influencepoint_remove@19
STRING "<dev string:x831>" 0x4725
# spawnlogic::codecallbackhandler_spawnpointscore@b4
STRING "<dev string:x85>" 0x1304
# spawnlogic::influencepoint_cleanupthink@52
STRING "<dev string:x87f>" 0x4939
# spawnlogic::logspawnpointsightupdate@d3
STRING "<dev string:x8c2>" 0x4c39
# spawnlogic::logspawnpointsightupdate@14c
STRING "<dev string:x8cc>" 0x4cb2
# spawnlogic::logspawnpointsightupdate@1e7
STRING "<dev string:x8d4>" 0x4d4d
# spawnlogic::spawnpointdistanceupdate@1a1
STRING "<dev string:x8db>" 0x507d
# spawnlogic::checkttlosdeverrors@4e
STRING "<dev string:x913>" 0x5e60
# spawnlogic::checkttlosdeverrors@6b
STRING "<dev string:x928>" 0x5e7d
# spawnlogic::checkttlosdeverrors@72
STRING "<dev string:x939>" 0x5e84
# spawnlogic::checkttlosdeverrors@9f
STRING "<dev string:x955>" 0x5eb1
# spawnlogic::checkttlosloaded@4e
STRING "<dev string:x98e>" 0x62d1
# spawnlogic::getspawnbucketfromstring@71
STRING "<dev string:x9e3>" 0x6e6c
# spawnlogic::registerspawnset@2c spawnlogic::activatespawnset@34
STRING "<dev string:xa00>" 0x6fa6 0x7084
# spawnlogic::registerspawnset@3c
STRING "<dev string:xa55>" 0x6fb6
# spawnlogic::activatespawnset@99
STRING "<dev string:xa98>" 0x70e9
# spawnlogic::deactivatespawnset@4c
STRING "<dev string:xacb>" 0x7185
# spawnlogic::updatedebughud@63
STRING "<dev string:xb22>" 0x73c1
# spawnlogic::updatedebughud@8c
STRING "<dev string:xb3a>" 0x73ea
# spawnlogic::updatedebughud@af
STRING "<dev string:xb4a>" 0x740d
# spawnlogic::updatedebughud@131
STRING "<dev string:xb5d>" 0x748f
# spawnlogic::updatedebughud@15b
STRING "<dev string:xb87>" 0x74b9
# spawnlogic::function_4c2c5ecea9fd1e73@29
STRING "<dev string:xba0>" 0x7510
# spawnlogic::function_4c2c5ecea9fd1e73@3a
STRING "<dev string:xbca>" 0x7521
# spawnlogic::function_4c2c5ecea9fd1e73@46
STRING "<dev string:xbe7>" 0x752d
# spawnlogic::function_4c2c5ecea9fd1e73@5d
STRING "<dev string:xbf4>" 0x7544
# spawnlogic::function_4c2c5ecea9fd1e73@96
STRING "<dev string:xc01>" 0x757d
# spawnlogic::function_4c2c5ecea9fd1e73@9d
STRING "<dev string:xc06>" 0x7584
# spawnlogic::function_4c2c5ecea9fd1e73@a5
STRING "<dev string:xc0d>" 0x758c
# spawnlogic::function_4c2c5ecea9fd1e73@b9
STRING "<dev string:xc13>" 0x75a0
# spawnlogic::function_d344bbcacf5e4d96@6b spawnlogic::function_d344bbcacf5e4d96@ee
STRING "<dev string:xc18>" 0x7698 0x771b
# spawnlogic::function_d344bbcacf5e4d96@78
STRING "<dev string:xc2a>" 0x76a5
# spawnlogic::function_d344bbcacf5e4d96@f6
STRING "<dev string:xc74>" 0x7723
# spawnlogic::function_d344bbcacf5e4d96@103
STRING "<dev string:xc95>" 0x7730
# spawnlogic::codecallbackhandler_spawnpointcritscore@33
STRING "<dev string:xe3>" 0x13e5
# spawnlogic::getspawnpoint@13e
STRING "<dev string:xea>" 0x153c
######################################################
####################  DEV BLOCKS  ####################
######################################################
# spawnlogic::init@2f0
DEVBLOCK 0xf92
# spawnlogic::codecallbackhandler_spawnpointscore@61
DEVBLOCK 0x12b1
# spawnlogic::codecallbackhandler_spawnpointscore@af
DEVBLOCK 0x12ff
# spawnlogic::codecallbackhandler_spawnpointscore@101
DEVBLOCK 0x1351
# spawnlogic::codecallbackhandler_spawnpointscore@120
DEVBLOCK 0x1370
# spawnlogic::codecallbackhandler_spawnpointcritscore@1c
DEVBLOCK 0x13ce
# spawnlogic::getspawnpoint@d5
DEVBLOCK 0x14d3
# spawnlogic::getspawnpoint@103
DEVBLOCK 0x1501
# spawnlogic::getspawnpoint@139
DEVBLOCK 0x1537
# spawnlogic::getspawnpoint@15c
DEVBLOCK 0x155a
# spawnlogic::getspawnpoint@24c
DEVBLOCK 0x164a
# spawnlogic::getspawnpoint@332
DEVBLOCK 0x1730
# spawnlogic::getspawnpoint@4c9
DEVBLOCK 0x18c7
# spawnlogic::getspawnpoint@603
DEVBLOCK 0x1a01
# spawnlogic::getspawnpoint@650
DEVBLOCK 0x1a4e
# spawnlogic::setactivespawnlogic@110
DEVBLOCK 0x1fb1
# spawnlogic::setactivespawnlogic@2b6
DEVBLOCK 0x2157
# spawnlogic::setactivespawnlogic@39f
DEVBLOCK 0x2240
# spawnlogic::loadspawnlogicweights@83
DEVBLOCK 0x254d
# spawnlogic::loadspawnlogicweights@e5
DEVBLOCK 0x25af
# spawnlogic::loadspawnlogicweights@158
DEVBLOCK 0x2622
# spawnlogic::loadspawnlogicweights@1bd
DEVBLOCK 0x2687
# spawnlogic::loadspawnlogicweights@21b
DEVBLOCK 0x26e5
# spawnlogic::loadspawnlogicweights@250
DEVBLOCK 0x271a
# spawnlogic::loadspawnlogicweights@311
DEVBLOCK 0x27db
# spawnlogic::loadspawnlogicweights@32b
DEVBLOCK 0x27f5
# spawnlogic::loadspawnlogicweights@345
DEVBLOCK 0x280f
# spawnlogic::loadspawnlogicweights@3ed
DEVBLOCK 0x28b7
# spawnlogic::loadspawnlogicweights@469
DEVBLOCK 0x2933
# spawnlogic::loadspawnlogicweights@483
DEVBLOCK 0x294d
# spawnlogic::loadspawnlogicweights@5c8
DEVBLOCK 0x2a92
# spawnlogic::loadspawnlogicweights@5f7
DEVBLOCK 0x2ac1
# spawnlogic::loadspawnlogicweights@61a
DEVBLOCK 0x2ae4
# spawnlogic::loadspawnlogicweights@68c
DEVBLOCK 0x2b56
# spawnlogic::loadspawnlogicweights@6cf
DEVBLOCK 0x2b99
# spawnlogic::loadspawnlogicweights@746
DEVBLOCK 0x2c10
# spawnlogic::scorespawnpoint@34
DEVBLOCK 0x2ca1
# spawnlogic::scorespawnpoint@12a
DEVBLOCK 0x2d97
# spawnlogic::function_386623fc65375fa8@c3
DEVBLOCK 0x2fd8
# spawnlogic::addspawnpoints@4c
DEVBLOCK 0x325e
# spawnlogic::function_9328a9c1fc8d2043@5a
DEVBLOCK 0x32e3
# spawnlogic::spawnpointinit@223
DEVBLOCK 0x3677
# spawnlogic::getspawnpointfromcode@78
DEVBLOCK 0x3a4c
# spawnlogic::spawnpointupdate@65
DEVBLOCK 0x4243
# spawnlogic::spawnpointupdate@1b6
DEVBLOCK 0x4394
# spawnlogic::influencepoint_add@c5
DEVBLOCK 0x46bb
# spawnlogic::influencepoint_add@e4
DEVBLOCK 0x46da
# spawnlogic::influencepoint_remove@14
DEVBLOCK 0x4720
# spawnlogic::influencepoint_getnewscripthandle@2f
DEVBLOCK 0x4785
# spawnlogic::influencepoint_cleanupthink@4d
DEVBLOCK 0x4934
# spawnlogic::updatespawnviewers@5a
DEVBLOCK 0x49eb
# spawnlogic::function_9ab26c0d48173ab1@1
DEVBLOCK 0x4b4f
# spawnlogic::logspawnpointsightupdate@ce
DEVBLOCK 0x4c34
# spawnlogic::logspawnpointsightupdate@147
DEVBLOCK 0x4cad
# spawnlogic::logspawnpointsightupdate@1e2
DEVBLOCK 0x4d48
# spawnlogic::spawnpointdistanceupdate@2c
DEVBLOCK 0x4f08
# spawnlogic::spawnpointdistanceupdate@19c
DEVBLOCK 0x5078
# spawnlogic::evaluateprecomputedlos@a5
DEVBLOCK 0x5a56
# spawnlogic::evaluateprecomputedlos@ee
DEVBLOCK 0x5a9f
# spawnlogic::evaluateprecomputedlos@1a4
DEVBLOCK 0x5b55
# spawnlogic::checkttlosdeverrors@24
DEVBLOCK 0x5e36
# spawnlogic::directlineofsighttest@6e
DEVBLOCK 0x61ef
# spawnlogic::checkttlosloaded@49
DEVBLOCK 0x62cc
# spawnlogic::getspawnbucketfromstring@6c
DEVBLOCK 0x6e67
# spawnlogic::registerspawnset@27
DEVBLOCK 0x6fa1
# spawnlogic::registerspawnset@37
DEVBLOCK 0x6fb1
# spawnlogic::function_8390bf8c3b74466a@14
DEVBLOCK 0x702c
# spawnlogic::activatespawnset@2f
DEVBLOCK 0x707f
# spawnlogic::activatespawnset@94
DEVBLOCK 0x70e4
# spawnlogic::activatespawnset@ba
DEVBLOCK 0x710a
# spawnlogic::deactivatespawnset@47
DEVBLOCK 0x7180
# spawnlogic::deactivatespawnset@b0
DEVBLOCK 0x71e9
# spawnlogic::updatedebughud@33
DEVBLOCK 0x7391
# spawnlogic::function_4c2c5ecea9fd1e73@24
DEVBLOCK 0x750b
# spawnlogic::function_50a59d95bac1964e@1b
DEVBLOCK 0x75e0
# spawnlogic::function_d344bbcacf5e4d96@54
DEVBLOCK 0x7681
# spawnlogic::function_d344bbcacf5e4d96@66
DEVBLOCK 0x7693
# spawnlogic::function_d344bbcacf5e4d96@e9
DEVBLOCK 0x7716
# spawnlogic::scriptedspawnpointsonmigration@5a
DEVBLOCK 0x7a1e
# spawnlogic::initspawnlist@45
DEVBLOCK 0x7ef5
# spawnlogic::function_8be1c339876506b9@22
DEVBLOCK 0x82a3
# spawnlogic::function_8be1c339876506b9@3f
DEVBLOCK 0x82c0
# spawnlogic::function_8be1c339876506b9@5e
DEVBLOCK 0x82df
# spawnlogic::function_b17bf43316b9fb08@29
DEVBLOCK 0x840f
