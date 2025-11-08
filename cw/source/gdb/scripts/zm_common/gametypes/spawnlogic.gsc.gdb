NAME scripts\zm_common\gametypes\spawnlogic.gsc
VERSION 0
CHECKSUM 0xa04a97de
######################################################
####################  DEV STRINGS  ###################
######################################################
# spawnlogic::storespawndata@560
STRING "<dev string:x105>" 0x1a50
# spawnlogic::storespawndata@5c8
STRING "<dev string:x114>" 0x1ab8
# spawnlogic::storespawndata@674
STRING "<dev string:x11c>" 0x1b64
# spawnlogic::readspawndata@b4
STRING "<dev string:x125>" 0x1d24
# spawnlogic::readspawndata@7ec
STRING "<dev string:x12d>" 0x245c
# spawnlogic::readspawndata@82c
STRING "<dev string:x13f>" 0x249c
# spawnlogic::readspawndata@86c
STRING "<dev string:x147>" 0x24dc
# spawnlogic::readspawndata@8c0
STRING "<dev string:x159>" 0x2530
# spawnlogic::drawspawndata@d8
STRING "<dev string:x161>" 0x26d8
# spawnlogic::drawspawndata@14c
STRING "<dev string:x167>" 0x274c
# spawnlogic::drawspawndata@29c
STRING "<dev string:x16d>" 0x289c
# spawnlogic::drawspawndata@324
STRING "<dev string:x17e>" 0x2924
# spawnlogic::drawspawndata@3d4
STRING "<dev string:x18a>" 0x29d4
# spawnlogic::vectostr@2c spawnlogic::vectostr@4c spawnlogic::strtovec@1c
STRING "<dev string:x19c>" 0x2a5c 0x2a7c 0x2ac4
# spawnlogic::getspawnpoint_nearteam@264
STRING "<dev string:x1a1>" 0x33cc
# spawnlogic::getspawnpoint_nearteam@284
STRING "<dev string:x1b2>" 0x33ec
# spawnlogic::getspawnpoint_nearteam@294 spawnlogic::getspawnpoint_nearteam@2c4
STRING "<dev string:x1ba>" 0x33fc 0x342c
# spawnlogic::getspawnpoint_nearteam@2b4
STRING "<dev string:x1bf>" 0x341c
# spawnlogic::getspawnpoint_nearteam@2e4
STRING "<dev string:x1c6>" 0x344c
# spawnlogic::getspawnpoint_nearteam@33c
STRING "<dev string:x1ce>" 0x34a4
# spawnlogic::spawngraph@b4
STRING "<dev string:x1e0>" 0x3ea4
# spawnlogic::spawngraph@ac
STRING "<dev string:x1f2>" 0x3e9c
# spawnlogic::spawngraph@e0
STRING "<dev string:x200>" 0x3ed0
# spawnlogic::spawngraph@398 spawnlogic::spawngraph@49c
STRING "<dev string:x22c>" 0x4188 0x428c
# spawnlogic::loopbotspawns@f4
STRING "<dev string:x239>" 0x467c
# spawnlogic::loopbotspawns@1d8 spawnlogic::loopbotspawns@2cc
STRING "<dev string:x240>" 0x4760 0x4854
# spawnlogic::loopbotspawns@1c0 spawnlogic::loopbotspawns@2b4
STRING "<dev string:x254>" 0x4748 0x483c
# spawnlogic::allowspawndatareading@1a0
STRING "<dev string:x25c>" 0x4a98
# spawnlogic::allowspawndatareading@1bc
STRING "<dev string:x276>" 0x4ab4
# spawnlogic::showdeathsdebug@31c
STRING "<dev string:x28b>" 0x4e14
# spawnlogic::showdeathsdebug@3cc
STRING "<dev string:x29b>" 0x4ec4
# spawnlogic::spawnweightdebug@244
STRING "<dev string:x2a9>" 0x51e4
# spawnlogic::avoidweapondamage@140
STRING "<dev string:x2be>" 0x5830
# spawnlogic::avoidvisibleenemies@42c
STRING "<dev string:x2d5>" 0x67cc
# spawnlogic::avoidvisibleenemies@454
STRING "<dev string:x2ea>" 0x67f4
# spawnlogic::avoidspawnreuse@1e0
STRING "<dev string:x2f7>" 0x6a28
# spawnlogic::avoidsamespawn@a8
STRING "<dev string:x30f>" 0x6b28
# spawnlogic::main@34 spawnlogic::main@ac spawnlogic::main@fc spawnlogic::storespawndata@3e0 spawnlogic::loopbotspawns@324 spawnlogic::allowspawndatareading@34 spawnlogic::allowspawndatareading@11c spawnlogic::allowspawndatareading@12c
STRING "<dev string:x38>" 0x19c 0x214 0x264 0x18d0 0x48ac 0x492c 0x4a14 0x4a24
# spawnlogic::addspawnpointsinternal@1c4
STRING "<dev string:x3c>" 0x7ec
# spawnlogic::addspawnpointsinternal@1d0 spawnlogic::placespawnpoints@88 spawnlogic::dropspawnpoints@54
STRING "<dev string:x4c>" 0x7f8 0xa48 0xb3c
# spawnlogic::placespawnpoints@7c spawnlogic::dropspawnpoints@48
STRING "<dev string:x6c>" 0xa3c 0xb30
# spawnlogic::getbestweightedspawnpoint@1f4
STRING "<dev string:x75>" 0x125c
# spawnlogic::checkbad@7c spawnlogic::loopbotspawns@e4
STRING "<dev string:x93>" 0x1334 0x466c
# spawnlogic::badspawnline@88
STRING "<dev string:x9e>" 0x1490
# spawnlogic::badspawnline@94
STRING "<dev string:xad>" 0x149c
# spawnlogic::storespawndata@114
STRING "<dev string:xba>" 0x1604
# spawnlogic::storespawndata@138 spawnlogic::readspawndata@bc
STRING "<dev string:xd4>" 0x1628 0x1d2c
# spawnlogic::storespawndata@130
STRING "<dev string:xe5>" 0x1620
# spawnlogic::storespawndata@15c spawnlogic::storespawndata@740
STRING "<dev string:xef>" 0x164c 0x1c30
# spawnlogic::storespawndata@170 spawnlogic::storespawndata@180 spawnlogic::storespawndata@1d4 spawnlogic::storespawndata@240 spawnlogic::storespawndata@2a8 spawnlogic::storespawndata@2e4 spawnlogic::storespawndata@30c spawnlogic::storespawndata@350 spawnlogic::storespawndata@374 spawnlogic::storespawndata@444 spawnlogic::storespawndata@49c spawnlogic::storespawndata@4b8 spawnlogic::storespawndata@4c8 spawnlogic::storespawndata@698 spawnlogic::storespawndata@6d4 spawnlogic::storespawndata@6ec
STRING "<dev string:xf4>" 0x1660 0x1670 0x16c4 0x1730 0x1798 0x17d4 0x17fc 0x1840 0x1864 0x1934 0x198c 0x19a8 0x19b8 0x1b88 0x1bc4 0x1bdc
# spawnlogic::storespawndata@1f4
STRING "<dev string:xf9>" 0x16e4
# spawnlogic::storespawndata@208 spawnlogic::storespawndata@220
STRING "<dev string:xff>" 0x16f8 0x1710
######################################################
####################  DEV BLOCKS  ####################
######################################################
# spawnlogic::main@a
DEVBLOCK 0x172
# spawnlogic::main@1fa
DEVBLOCK 0x362
# spawnlogic::addspawnpointsinternal@1bc
DEVBLOCK 0x7e4
# spawnlogic::placespawnpoints@4c
DEVBLOCK 0xa0c
# spawnlogic::placespawnpoints@74
DEVBLOCK 0xa34
# spawnlogic::placespawnpoints@e2
DEVBLOCK 0xaa2
# spawnlogic::dropspawnpoints@3e
DEVBLOCK 0xb26
# spawnlogic::getspawnpoint_final@1c2
DEVBLOCK 0xfe2
# spawnlogic::getbestweightedspawnpoint@1d4
DEVBLOCK 0x123c
# spawnlogic::checkbad@22
DEVBLOCK 0x12da
# spawnlogic::badspawnline@32
DEVBLOCK 0x143a
# spawnlogic::storespawndata@6a
DEVBLOCK 0x155a
# spawnlogic::readspawndata@aa
DEVBLOCK 0x1d1a
# spawnlogic::drawspawndata@32
DEVBLOCK 0x2632
# spawnlogic::vectostr@a
DEVBLOCK 0x2a3a
# spawnlogic::strtovec@12
DEVBLOCK 0x2aba
# spawnlogic::getallalliedandenemyplayers@28
DEVBLOCK 0x2cf8
# spawnlogic::initweights@3c
DEVBLOCK 0x2e94
# spawnlogic::getspawnpoint_nearteam@86
DEVBLOCK 0x31ee
# spawnlogic::getspawnpoint_nearteam@244
DEVBLOCK 0x33ac
# spawnlogic::getspawnpoint_nearteam@31c
DEVBLOCK 0x3484
# spawnlogic::getspawnpoint_nearteam@43c
DEVBLOCK 0x35a4
# spawnlogic::spawnlogic_begin@2
DEVBLOCK 0x3b32
# spawnlogic::watchspawnprofile@2
DEVBLOCK 0x3b9a
# spawnlogic::spawnprofile@1a
DEVBLOCK 0x3c7a
# spawnlogic::spawngraphcheck@2
DEVBLOCK 0x3d8a
# spawnlogic::spawngraph@82
DEVBLOCK 0x3e72
# spawnlogic::drawspawngraph@4a
DEVBLOCK 0x43a2
# spawnlogic::setupspawngraphpoint@12
DEVBLOCK 0x447a
# spawnlogic::spawngraphline@2a
DEVBLOCK 0x44e2
# spawnlogic::loopbotspawns@3a
DEVBLOCK 0x45c2
# spawnlogic::allowspawndatareading@2a
DEVBLOCK 0x4922
# spawnlogic::showdeathsdebug@32
DEVBLOCK 0x4b2a
# spawnlogic::spawnweightdebug@58
DEVBLOCK 0x4ff8
# spawnlogic::debugnearbyplayers@22
DEVBLOCK 0x535a
# spawnlogic::avoidweapondamage@120
DEVBLOCK 0x5810
# spawnlogic::spawnpointupdate@15e
DEVBLOCK 0x5bf6
# spawnlogic::spawnpointupdate@43a
DEVBLOCK 0x5ed2
# spawnlogic::avoidvisibleenemies@12c
DEVBLOCK 0x64cc
# spawnlogic::avoidvisibleenemies@208
DEVBLOCK 0x65a8
# spawnlogic::avoidvisibleenemies@40c
DEVBLOCK 0x67ac
# spawnlogic::avoidspawnreuse@1c0
DEVBLOCK 0x6a08
# spawnlogic::avoidsamespawn@88
DEVBLOCK 0x6b08
# spawnlogic::getrandomintermissionpoint@64
DEVBLOCK 0x6bc4
