// file .... ddl\sp\progression.ddl

version 1 {
    // enums ..... 2 (0x2)
    // structs ... 2 (0x2)
    // bit size .. 2320 (0x910)
    // byte size . 290 (0x122)
    // archive ... hash_6809fee11f24911c

    // bitSize: 0x860, members: 22
    struct SPProgression {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int achievementHangtime;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int focusCounter;
        // offset: 0x40, bitSize: 0x100(0x20 Byte(s))
        string(32) achievementBoom;
        // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
        int kleenexSessionGameplayTime;
        // offset: 0x160, bitSize: 0x90(0x12 Byte(s)), array:0x12(hti:0x0)
        MissionState missionStateData[Missions];
        // offset: 0x1f0, bitSize: 0x20(0x4 Byte(s))
        int playerMountCounter;
        // offset: 0x210, bitSize: 0x20(0x4 Byte(s))
        int sessionGameplayTime;
        // offset: 0x230, bitSize: 0x20(0x4 Byte(s))
        int startPointDeaths;
        // offset: 0x250, bitSize: 0x20(0x4 Byte(s))
        int achievementWallOfDuty;
        // offset: 0x270, bitSize: 0x240(0x48 Byte(s)), array:0x12(hti:0x0)
        int civiliansKilledGradeBest[Missions];
        // offset: 0x4b0, bitSize: 0x20(0x4 Byte(s))
        int startPointFails;
        // offset: 0x4d0, bitSize: 0x20(0x4 Byte(s))
        int totalGameplayTime;
        // offset: 0x4f0, bitSize: 0x8(0x1 Byte(s))
        Missions currentMission;
        // offset: 0x4f8, bitSize: 0x240(0x48 Byte(s)), array:0x12(hti:0x0)
        int civiliansKilledGrade[Missions];
        // offset: 0x738, bitSize: 0x20(0x4 Byte(s))
        int kleenexSectionTime;
        // offset: 0x758, bitSize: 0x100(0x20 Byte(s))
        string(32) achievementGentlemanThief;
        // offset: 0x858, bitSize: 0x1
        bool achievementDoorPeekKick;
        // offset: 0x859, bitSize: 0x1
        bool achievementDoorPeekOpen;
        // offset: 0x85a, bitSize: 0x1
        bool beatRealism;
        // offset: 0x85b, bitSize: 0x1
        bool unlockedRealism;
        // offset: 0x85c, bitSize: 0x1
        bool achievementDoorPeekGrenade;
    };

    // idx 0x0 members: 0x12 type: 0
    enum Missions {
        none, // 0x0
        strike, // 0x1
        nightwar, // 0x2
        marina, // 0x3
        montage_canals, // 0x4
        border, // 0x5
        backstabbed, // 0x6
        gunship_compound, // 0x7
        gunship_ambush, // 0x8
        intercept, // 0x9
        convoy_chase, // 0xa
        party, // 0xb
        shipaf, // 0xc
        wounded, // 0xd
        prison, // 0xe
        stolen, // 0xf
        shadowbase, // 0x10
        tower // 0x11
    };

    // idx 0x1 members: 0x3 type: 0
    enum MissionState {
        locked, // 0x0
        incomplete, // 0x1
        complete // 0x2
    };

    // root: bitSize: 0x860, members: 1

    // offset: 0x0, bitSize: 0x860(0x10c Byte(s))
    SPProgression spData;
};

