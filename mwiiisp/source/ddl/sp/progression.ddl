// file .... ddl\sp\progression.ddl

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 16 (0x10)
    // bit size .. 73696 (0x11fe0)
    // byte size . 9212 (0x23fc)
    // archive ... hash_264ed61738b9ebc2

    // bitSize: 0x18, members: 4
    struct sboxItemData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        uint:16 itemID;
        // offset: 0x10, bitSize: 0x1
        bool isNewUnlock;
        // offset: 0x11, bitSize: 0x1
        bool unlockState;
    };

    // bitSize: 0x3c0, members: 1
    struct sboxInventoryData {
        // offset: 0x0, bitSize: 0x3c0(0x78 Byte(s)), array:0x28(hti:0xffff)
        sboxItemData SboxItems[40];
    };

    // bitSize: 0x10, members: 16
    struct sboxMissionObjectiveData {
        // offset: 0x0, bitSize: 0x1
        bool objective_0;
        // offset: 0x1, bitSize: 0x1
        bool objective_1;
        // offset: 0x2, bitSize: 0x1
        bool objective_2;
        // offset: 0x3, bitSize: 0x1
        bool objective_3;
        // offset: 0x4, bitSize: 0x1
        bool objective_4;
        // offset: 0x5, bitSize: 0x1
        bool objective_5;
        // offset: 0x6, bitSize: 0x1
        bool objective_6;
        // offset: 0x7, bitSize: 0x1
        bool objective_7;
        // offset: 0x8, bitSize: 0x1
        bool objective_8;
        // offset: 0x9, bitSize: 0x1
        bool objective_9;
        // offset: 0xa, bitSize: 0x1
        bool objective_10;
        // offset: 0xb, bitSize: 0x1
        bool objective_11;
        // offset: 0xc, bitSize: 0x1
        bool objective_12;
        // offset: 0xd, bitSize: 0x1
        bool objective_13;
        // offset: 0xe, bitSize: 0x1
        bool objective_14;
        // offset: 0xf, bitSize: 0x1
        bool objective_15;
    };

    // bitSize: 0x548, members: 11
    struct sboxLastCheckpointData {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) last_checkpoint_angles;
        // offset: 0x100, bitSize: 0x200(0x40 Byte(s))
        string(64) last_checkpoint;
        // offset: 0x300, bitSize: 0x100(0x20 Byte(s))
        string(32) last_checkpoint_map;
        // offset: 0x400, bitSize: 0x8(0x1 Byte(s))
        int:4 last_checkpoint_difficulty;
        // offset: 0x408, bitSize: 0x10(0x2 Byte(s))
        uint:16 last_checkpoint_armor_health;
        // offset: 0x418, bitSize: 0x8(0x1 Byte(s))
        int:4 last_checkpoint_armor_plates;
        // offset: 0x420, bitSize: 0x20(0x4 Byte(s))
        uint sandboxCheckpointTimestamp;
        // offset: 0x440, bitSize: 0x100(0x20 Byte(s))
        string(32) last_checkpoint_position;
        // offset: 0x540, bitSize: 0x1
        bool last_checkpoint_nvg_state;
        // offset: 0x541, bitSize: 0x1
        bool last_checkpoint_self_revive;
    };

    // bitSize: 0x50, members: 10
    struct sboxLoadoutData {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:8 tacticalGrenade;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:8 boots;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        uint:8 molle;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        uint:8 plate;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        uint:8 secondaryWeapon;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        uint:8 gloves;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        uint:8 helmet;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        uint:8 fieldEquipment;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        uint:8 lethalGrenade;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:8 primaryWeapon;
    };

    // bitSize: 0x80, members: 16
    struct gameplaytutorialData {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_9_displays;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_8_displays;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_7_displays;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_15_displays;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_6_displays;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_14_displays;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_5_displays;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_13_displays;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_4_displays;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_12_displays;
        // offset: 0x50, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_3_displays;
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_11_displays;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_2_displays;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_10_displays;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_1_displays;
        // offset: 0x78, bitSize: 0x8(0x1 Byte(s))
        uint:4 tutorial_0_displays;
    };

    // bitSize: 0x48, members: 11
    struct MissionData {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:5 majorStoryChoiceIndex;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:5 numObtainedSpyKitPuzzleResource1;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        uint:5 numObtainedSpyKitPuzzleResource2;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        uint:5 numObtainedSpyKitPuzzleResource3;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        uint:5 numObtainedSpyKitPuzzleResource4;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        uint:5 numEvidenceObtained;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        uint:5 numOperatorsObtained;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        uint:5 numResourceKeyObtained;
        // offset: 0x40, bitSize: 0x1
        bool completedResourceMission;
        // offset: 0x41, bitSize: 0x1
        bool completedAllyLoyalty;
    };

    // bitSize: 0x5c8, members: 68
    struct SBProgressionData {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:5 cp_jup_resort_checkpoint_id;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_ranch_attempts;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        uint:3 cp_jup_chemical_plate_level;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_apt_attempts;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        uint:3 cp_jup_resort_plate_level;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        uint:3 cp_jup_port_plate_level;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_apt_successes;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_resort_attempts;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        uint:3 cp_jup_apt_plate_level;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:5 cp_jup_apt_checkpoint_id;
        // offset: 0x50, bitSize: 0x8(0x1 Byte(s))
        uint:5 cp_jup_chemical_checkpoint_id;
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_dam_successes;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_chemical_successes;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        uint:5 cp_jup_dam_checkpoint_id;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        uint:3 cp_jup_dam_plate_level;
        // offset: 0x78, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_resort_successes;
        // offset: 0x80, bitSize: 0x8(0x1 Byte(s))
        uint:5 cp_jup_port_checkpoint_id;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        uint:5 cp_jup_ranch_checkpoint_id;
        // offset: 0x90, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_chemical_attempts;
        // offset: 0x98, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_port_successes;
        // offset: 0xa0, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_dam_attempts;
        // offset: 0xa8, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_ranch_successes;
        // offset: 0xb0, bitSize: 0x8(0x1 Byte(s))
        uint:3 cp_jup_ranch_plate_level;
        // offset: 0xb8, bitSize: 0x8(0x1 Byte(s))
        uint:8 cp_jup_port_attempts;
        // offset: 0xc0, bitSize: 0x1
        bool cp_jup_parachute_activated;
        // offset: 0xc1, bitSize: 0x1
        bool cp_jup_resort_nvg;
        // offset: 0xc2, bitSize: 0x1
        bool cp_jup_apt_nvg;
        // offset: 0xc3, bitSize: 0x1
        bool cp_jup_resort_ascender_tool;
        // offset: 0xc4, bitSize: 0x1
        bool cp_jup_resort_should_show_loadout;
        // offset: 0xc5, bitSize: 0x80(0x10 Byte(s)), array:0x80(hti:0xffff)
        bool cp_jup_apt_discoverables[128];
        // offset: 0x145, bitSize: 0x4, array:0x4(hti:0xffff)
        bool cp_jup_dam_ks_unlocks[4];
        // offset: 0x149, bitSize: 0x15e, array:0x15e(hti:0xffff)
        bool cp_jup_chemical_discoverables[350];
        // offset: 0x2a7, bitSize: 0x4, array:0x4(hti:0xffff)
        bool cp_jup_resort_ks_unlocks[4];
        // offset: 0x2ab, bitSize: 0x1
        bool cp_jup_ranch_nvg;
        // offset: 0x2ac, bitSize: 0x19, array:0x19(hti:0xffff)
        bool cp_jup_chemical_plate_carriers[25];
        // offset: 0x2c5, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool cp_jup_ranch_map_unlocks[16];
        // offset: 0x2d5, bitSize: 0x4, array:0x4(hti:0xffff)
        bool cp_jup_chemical_ks_unlocks[4];
        // offset: 0x2d9, bitSize: 0x1
        bool cp_jup_dam_should_show_loadout;
        // offset: 0x2da, bitSize: 0x1
        bool cp_jup_apt_ascender_tool;
        // offset: 0x2db, bitSize: 0x1
        bool cp_jup_port_nvg;
        // offset: 0x2dc, bitSize: 0x80(0x10 Byte(s)), array:0x80(hti:0xffff)
        bool cp_jup_dam_discoverables[128];
        // offset: 0x35c, bitSize: 0x1
        bool cp_jup_chemical_ascender_tool;
        // offset: 0x35d, bitSize: 0x4, array:0x4(hti:0xffff)
        bool cp_jup_ranch_ks_unlocks[4];
        // offset: 0x361, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool cp_jup_chemical_map_unlocks[16];
        // offset: 0x371, bitSize: 0xc8(0x19 Byte(s)), array:0xc8(hti:0xffff)
        bool cp_jup_port_discoverables[200];
        // offset: 0x439, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool cp_jup_resort_map_unlocks[16];
        // offset: 0x449, bitSize: 0x19, array:0x19(hti:0xffff)
        bool cp_jup_resort_plate_carriers[25];
        // offset: 0x462, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool cp_jup_ranch_discoverables[64];
        // offset: 0x4a2, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool cp_jup_port_map_unlocks[16];
        // offset: 0x4b2, bitSize: 0x19, array:0x19(hti:0xffff)
        bool cp_jup_apt_plate_carriers[25];
        // offset: 0x4cb, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool cp_jup_apt_map_unlocks[16];
        // offset: 0x4db, bitSize: 0x1
        bool cp_jup_dam_nvg;
        // offset: 0x4dc, bitSize: 0x1
        bool cp_jup_dam_ascender_tool;
        // offset: 0x4dd, bitSize: 0x1
        bool cp_jup_apt_should_show_loadout;
        // offset: 0x4de, bitSize: 0x19, array:0x19(hti:0xffff)
        bool cp_jup_port_plate_carriers[25];
        // offset: 0x4f7, bitSize: 0x4, array:0x4(hti:0xffff)
        bool cp_jup_apt_ks_unlocks[4];
        // offset: 0x4fb, bitSize: 0x1
        bool cp_jup_ranch_should_show_loadout;
        // offset: 0x4fc, bitSize: 0x1
        bool cp_jup_port_ascender_tool;
        // offset: 0x4fd, bitSize: 0x1
        bool cp_jup_ranch_ascender_tool;
        // offset: 0x4fe, bitSize: 0x19, array:0x19(hti:0xffff)
        bool cp_jup_ranch_plate_carriers[25];
        // offset: 0x517, bitSize: 0x1
        bool cp_jup_port_should_show_loadout;
        // offset: 0x518, bitSize: 0x80(0x10 Byte(s)), array:0x80(hti:0xffff)
        bool cp_jup_resort_discoverables[128];
        // offset: 0x598, bitSize: 0x4, array:0x4(hti:0xffff)
        bool cp_jup_port_ks_unlocks[4];
        // offset: 0x59c, bitSize: 0x1
        bool cp_jup_chemical_should_show_loadout;
        // offset: 0x59d, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool cp_jup_dam_map_unlocks[16];
        // offset: 0x5ad, bitSize: 0x1
        bool cp_jup_chemical_nvg;
        // offset: 0x5ae, bitSize: 0x19, array:0x19(hti:0xffff)
        bool cp_jup_dam_plate_carriers[25];
    };

    // bitSize: 0x1a20, members: 39
    struct SPProgression {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:3 achievementSuitUp;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int achievementHangtime;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int focusCounter;
        // offset: 0x48, bitSize: 0x100(0x20 Byte(s))
        string(32) achievementBoom;
        // offset: 0x148, bitSize: 0x20(0x4 Byte(s))
        int kleenexSessionGameplayTime;
        // offset: 0x168, bitSize: 0xc00(0x180 Byte(s)), array:0xc(hti:0xffff)
        string(32) usedMunitions[12];
        // offset: 0xd68, bitSize: 0x78(0xf Byte(s)), array:0xf(hti:0x0)
        MissionState missionStateData[Missions];
        // offset: 0xde0, bitSize: 0x20(0x4 Byte(s))
        int playerMountCounter;
        // offset: 0xe00, bitSize: 0x20(0x4 Byte(s))
        uint cheatPoints;
        // offset: 0xe20, bitSize: 0x20(0x4 Byte(s))
        int sessionGameplayTime;
        // offset: 0xe40, bitSize: 0x438(0x87 Byte(s)), array:0xf(hti:0x0)
        MissionData playerMissionData[Missions];
        // offset: 0x1278, bitSize: 0x100(0x20 Byte(s)), array:0x20(hti:0xffff)
        byte missionHighestDifficulty[32];
        // offset: 0x1378, bitSize: 0x8(0x1 Byte(s))
        uint:4 currentGameskill;
        // offset: 0x1380, bitSize: 0x8(0x1 Byte(s))
        uint:6 achievementILikeToPretendIHaveAPlan;
        // offset: 0x1388, bitSize: 0x20(0x4 Byte(s))
        uint spTutorialLevel2;
        // offset: 0x13a8, bitSize: 0x8(0x1 Byte(s))
        uint:4 takeCoverWarnings;
        // offset: 0x13b0, bitSize: 0x20(0x4 Byte(s))
        uint cheat_items_set1;
        // offset: 0x13d0, bitSize: 0x20(0x4 Byte(s))
        uint cheat_items_set2;
        // offset: 0x13f0, bitSize: 0x20(0x4 Byte(s))
        int achievementDriveBy;
        // offset: 0x1410, bitSize: 0x20(0x4 Byte(s))
        int startPointDeaths;
        // offset: 0x1430, bitSize: 0x20(0x4 Byte(s))
        int achievementWallOfDuty;
        // offset: 0x1450, bitSize: 0x1e0(0x3c Byte(s)), array:0xf(hti:0x0)
        int civiliansKilledGradeBest[Missions];
        // offset: 0x1630, bitSize: 0x20(0x4 Byte(s))
        int startPointFails;
        // offset: 0x1650, bitSize: 0x20(0x4 Byte(s))
        uint spTutorialLevel;
        // offset: 0x1670, bitSize: 0x20(0x4 Byte(s))
        int totalGameplayTime;
        // offset: 0x1690, bitSize: 0x20(0x4 Byte(s))
        int percentCompleteSP;
        // offset: 0x16b0, bitSize: 0x8(0x1 Byte(s))
        Missions currentMission;
        // offset: 0x16b8, bitSize: 0x20(0x4 Byte(s))
        int numMunitions;
        // offset: 0x16d8, bitSize: 0x1e0(0x3c Byte(s)), array:0xf(hti:0x0)
        int civiliansKilledGrade[Missions];
        // offset: 0x18b8, bitSize: 0x20(0x4 Byte(s))
        int kleenexSectionTime;
        // offset: 0x18d8, bitSize: 0x20(0x4 Byte(s))
        int curDifficulty;
        // offset: 0x18f8, bitSize: 0x20(0x4 Byte(s))
        int achievementEngineeringDegree;
        // offset: 0x1918, bitSize: 0x100(0x20 Byte(s))
        string(32) achievementGentlemanThief;
        // offset: 0x1a18, bitSize: 0x1
        bool achievementDoorPeekKick;
        // offset: 0x1a19, bitSize: 0x1
        bool achievementDoorPeekOpen;
        // offset: 0x1a1a, bitSize: 0x1
        bool beatRealism;
        // offset: 0x1a1b, bitSize: 0x1
        bool unlockedRealism;
        // offset: 0x1a1c, bitSize: 0x1
        bool achievementDoorPeekGrenade;
    };

    // bitSize: 0x70, members: 1
    struct JupMissionProgression {
        // offset: 0x0, bitSize: 0x70(0xe Byte(s)), array:0xe(hti:0xffff)
        uint:4 JupMissionDifficulty[14];
    };

    // bitSize: 0x20, members: 1
    struct DDLVersionInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int version;
    };

    // bitSize: 0x2000, members: 4
    struct FogOfWarMapData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int rows;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int version;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int columns;
        // offset: 0x60, bitSize: 0x1fa0(0x3f4 Byte(s)), array:0x1fa0(hti:0xffff)
        bool tilesDiscovered[8096];
    };

    // bitSize: 0xe000, members: 2
    struct FogOfWarData {
        // offset: 0x0, bitSize: 0xc000(0x1800 Byte(s)), array:0x6(hti:0x7)
        FogOfWarMapData fogOfWarMapData[FogOfWarMap];
        // offset: 0xc000, bitSize: 0x2000(0x400 Byte(s))
        FogOfWarMapData fogOfWarTemporalMapData;
    };

    // bitSize: 0x10, members: 13
    struct SboxAchievements {
        // offset: 0x0, bitSize: 0x1
        bool cp_jup_ranch_allitemscollected;
        // offset: 0x1, bitSize: 0x1
        bool cp_jup_ranch_changedloadout;
        // offset: 0x2, bitSize: 0x1
        bool cp_jup_resort_allitemscollected;
        // offset: 0x3, bitSize: 0x1
        bool cp_jup_port_allitemscollected;
        // offset: 0x4, bitSize: 0x1
        bool cp_jup_dam_changedloadout;
        // offset: 0x5, bitSize: 0x1
        bool cp_jup_dam_allitemscollected;
        // offset: 0x6, bitSize: 0x1
        bool cp_jup_apt_allitemscollected;
        // offset: 0x7, bitSize: 0x1
        bool cp_jup_chemical_changedloadout;
        // offset: 0x8, bitSize: 0x1
        bool cp_jup_chemical_allitemscollected;
        // offset: 0x9, bitSize: 0x1
        bool cp_jup_resort_changedloadout;
        // offset: 0xa, bitSize: 0x1
        bool cp_jup_apt_changedloadout;
        // offset: 0xb, bitSize: 0x1
        bool cp_jup_port_changedloadout;
    };

    // bitSize: 0x20, members: 1
    struct Features {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int highVisibilityMode;
    };

    // idx 0x0 members: 0xf type: 0
    enum Missions {
        none, // 0x0
        sp_jup_vip, // 0x1
        cp_jup_port, // 0x2
        cp_jup_chemical, // 0x3
        sp_jup_silo, // 0x4
        sp_jup_milbase, // 0x5
        sp_jup_hijack, // 0x6
        cp_jup_ranch, // 0x7
        sp_jup_flashback, // 0x8
        cp_jup_resort, // 0x9
        cp_jup_apt, // 0xa
        sp_jup_tundra, // 0xb
        cp_jup_dam, // 0xc
        sp_jup_gunship, // 0xd
        sp_jup_surge // 0xe
    };

    // idx 0x1 members: 0x3 type: 0
    enum MissionState {
        locked, // 0x0
        incomplete, // 0x1
        complete // 0x2
    };

    // idx 0x2 members: 0x16 type: 0
    enum PerkSlots {
        playerGear, // 0x0
        playerHealth, // 0x1
        playerHealthRegen, // 0x2
        playerHealthGain, // 0x3
        playerPain, // 0x4
        meleePowerup, // 0x5
        weaponReload, // 0x6
        weaponADS, // 0x7
        weaponRecoil, // 0x8
        weaponSMG, // 0x9
        weaponAR, // 0xa
        weaponSG, // 0xb
        equipmentShockCluster, // 0xc
        equipmentKnife, // 0xd
        equipmentAdrenaline, // 0xe
        equipmentDart, // 0xf
        resourceOne, // 0x10
        resourceTwo, // 0x11
        resourceThree, // 0x12
        resourceFour, // 0x13
        resourceFive, // 0x14
        resourceSix // 0x15
    };

    // idx 0x3 members: 0x4 type: 0
    enum Stations {
        stationWeapon, // 0x0
        stationPlayer, // 0x1
        stationGear, // 0x2
        stationResource // 0x3
    };

    // idx 0x4 members: 0x2 type: 0
    enum Resources {
        intel, // 0x0
        money // 0x1
    };

    // idx 0x5 members: 0x6 type: 0
    enum sboxMissions {
        cp_jup_apt, // 0x0
        cp_jup_chemical, // 0x1
        cp_jup_dam, // 0x2
        cp_jup_port, // 0x3
        cp_jup_ranch, // 0x4
        cp_jup_resort // 0x5
    };

    // idx 0x6 members: 0x3 type: 0
    enum EvidenceData {
        tempEvidence1, // 0x0
        tempEvidence2, // 0x1
        tempEvidence3 // 0x2
    };

    // idx 0x7 members: 0x6 type: 0
    enum FogOfWarMap {
        cp_jup_apt, // 0x0
        cp_jup_chemical, // 0x1
        cp_jup_dam, // 0x2
        cp_jup_port, // 0x3
        cp_jup_ranch, // 0x4
        cp_jup_resort // 0x5
    };

    // root: bitSize: 0x11f30, members: 12

    // offset: 0x0, bitSize: 0x1e0(0x3c Byte(s)), array:0x6(hti:0x5)
    sboxLoadoutData sandboxLoadoutData[sboxMissions];
    // offset: 0x1e0, bitSize: 0x548(0xa9 Byte(s))
    sboxLastCheckpointData sandboxLastCheckpointData;
    // offset: 0x728, bitSize: 0x80(0x10 Byte(s))
    gameplaytutorialData gameplaytutorials;
    // offset: 0x7a8, bitSize: 0x20(0x4 Byte(s))
    DDLVersionInfo sandboxddlversion;
    // offset: 0x7c8, bitSize: 0x5c8(0xb9 Byte(s))
    SBProgressionData spProgData;
    // offset: 0xd90, bitSize: 0x10(0x2 Byte(s))
    SboxAchievements SandBoxAchievementData;
    // offset: 0xda0, bitSize: 0x70(0xe Byte(s))
    JupMissionProgression JupMissionDifficulties;
    // offset: 0xe10, bitSize: 0xe000(0x1c00 Byte(s))
    FogOfWarData fogOfWarData;
    // offset: 0xee10, bitSize: 0x1a20(0x344 Byte(s))
    SPProgression spData;
    // offset: 0x10830, bitSize: 0x60(0xc Byte(s)), array:0x6(hti:0x5)
    sboxMissionObjectiveData sandboxMissionObjectiveData[sboxMissions];
    // offset: 0x10890, bitSize: 0x20(0x4 Byte(s))
    Features features;
    // offset: 0x108b0, bitSize: 0x1680(0x2d0 Byte(s)), array:0x6(hti:0x5)
    sboxInventoryData sandboxInventoryData[sboxMissions];
};

