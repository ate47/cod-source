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

version 1 {
    // enums ..... 2 (0x2)
    // structs ... 2 (0x2)
    // bit size .. 1816 (0x718)
    // byte size . 227 (0xe3)
    // archive ... hash_5ceb39d67d768509

    // bitSize: 0x668, members: 20
    struct SPProgression {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int achievementHangtime;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int focusCounter;
        // offset: 0x40, bitSize: 0x100(0x20 Byte(s))
        string(32) achievementBoom;
        // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
        int kleenexSessionGameplayTime;
        // offset: 0x160, bitSize: 0x78(0xf Byte(s)), array:0xf(hti:0x0)
        MissionState missionStateData[Missions];
        // offset: 0x1d8, bitSize: 0x20(0x4 Byte(s))
        int playerMountCounter;
        // offset: 0x1f8, bitSize: 0x20(0x4 Byte(s))
        int sessionGameplayTime;
        // offset: 0x218, bitSize: 0x20(0x4 Byte(s))
        int startPointDeaths;
        // offset: 0x238, bitSize: 0x1e0(0x3c Byte(s)), array:0xf(hti:0x0)
        int civiliansKilledGradeBest[Missions];
        // offset: 0x418, bitSize: 0x20(0x4 Byte(s))
        int startPointFails;
        // offset: 0x438, bitSize: 0x20(0x4 Byte(s))
        int totalGameplayTime;
        // offset: 0x458, bitSize: 0x8(0x1 Byte(s))
        Missions currentMission;
        // offset: 0x460, bitSize: 0x1e0(0x3c Byte(s)), array:0xf(hti:0x0)
        int civiliansKilledGrade[Missions];
        // offset: 0x640, bitSize: 0x20(0x4 Byte(s))
        int kleenexSectionTime;
        // offset: 0x660, bitSize: 0x1
        bool achievementDoorPeekKick;
        // offset: 0x661, bitSize: 0x1
        bool achievementDoorPeekOpen;
        // offset: 0x662, bitSize: 0x1
        bool beatRealism;
        // offset: 0x663, bitSize: 0x1
        bool unlockedRealism;
        // offset: 0x664, bitSize: 0x1
        bool achievementDoorPeekGrenade;
    };

    // idx 0x0 members: 0xf type: 0
    enum Missions {
        none, // 0x0
        nightwar, // 0x1
        marina, // 0x2
        montage_canals, // 0x3
        border, // 0x4
        backstabbed, // 0x5
        gunship_compound, // 0x6
        gunship_ambush, // 0x7
        intercept, // 0x8
        convoy_chase, // 0x9
        party, // 0xa
        shipaf, // 0xb
        wounded, // 0xc
        shadowbase, // 0xd
        tower // 0xe
    };

    // idx 0x1 members: 0x3 type: 0
    enum MissionState {
        locked, // 0x0
        incomplete, // 0x1
        complete // 0x2
    };

    // root: bitSize: 0x668, members: 1

    // offset: 0x0, bitSize: 0x668(0xcd Byte(s))
    SPProgression spData;
};

version 1 {
    // enums ..... 2 (0x2)
    // structs ... 2 (0x2)
    // bit size .. 1888 (0x760)
    // byte size . 236 (0xec)
    // archive ... hash_4a84186db109b4c2

    // bitSize: 0x6b0, members: 20
    struct SPProgression {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int achievementHangtime;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int focusCounter;
        // offset: 0x40, bitSize: 0x100(0x20 Byte(s))
        string(32) achievementBoom;
        // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
        int kleenexSessionGameplayTime;
        // offset: 0x160, bitSize: 0x80(0x10 Byte(s)), array:0x10(hti:0x0)
        MissionState missionStateData[Missions];
        // offset: 0x1e0, bitSize: 0x20(0x4 Byte(s))
        int playerMountCounter;
        // offset: 0x200, bitSize: 0x20(0x4 Byte(s))
        int sessionGameplayTime;
        // offset: 0x220, bitSize: 0x20(0x4 Byte(s))
        int startPointDeaths;
        // offset: 0x240, bitSize: 0x200(0x40 Byte(s)), array:0x10(hti:0x0)
        int civiliansKilledGradeBest[Missions];
        // offset: 0x440, bitSize: 0x20(0x4 Byte(s))
        int startPointFails;
        // offset: 0x460, bitSize: 0x20(0x4 Byte(s))
        int totalGameplayTime;
        // offset: 0x480, bitSize: 0x8(0x1 Byte(s))
        Missions currentMission;
        // offset: 0x488, bitSize: 0x200(0x40 Byte(s)), array:0x10(hti:0x0)
        int civiliansKilledGrade[Missions];
        // offset: 0x688, bitSize: 0x20(0x4 Byte(s))
        int kleenexSectionTime;
        // offset: 0x6a8, bitSize: 0x1
        bool achievementDoorPeekKick;
        // offset: 0x6a9, bitSize: 0x1
        bool achievementDoorPeekOpen;
        // offset: 0x6aa, bitSize: 0x1
        bool beatRealism;
        // offset: 0x6ab, bitSize: 0x1
        bool unlockedRealism;
        // offset: 0x6ac, bitSize: 0x1
        bool achievementDoorPeekGrenade;
    };

    // idx 0x0 members: 0x10 type: 0
    enum Missions {
        none, // 0x0
        nightwar, // 0x1
        marina, // 0x2
        montage_canals, // 0x3
        border, // 0x4
        backstabbed, // 0x5
        gunship_compound, // 0x6
        gunship_ambush, // 0x7
        intercept, // 0x8
        convoy_chase, // 0x9
        party, // 0xa
        shipaf, // 0xb
        wounded, // 0xc
        prison, // 0xd
        shadowbase, // 0xe
        tower // 0xf
    };

    // idx 0x1 members: 0x3 type: 0
    enum MissionState {
        locked, // 0x0
        incomplete, // 0x1
        complete // 0x2
    };

    // root: bitSize: 0x6b0, members: 1

    // offset: 0x0, bitSize: 0x6b0(0xd6 Byte(s))
    SPProgression spData;
};

version 1 {
    // enums ..... 2 (0x2)
    // structs ... 2 (0x2)
    // bit size .. 2032 (0x7f0)
    // byte size . 254 (0xfe)
    // archive ... hash_6cbddc06a85b3358

    // bitSize: 0x740, members: 20
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
        // offset: 0x250, bitSize: 0x240(0x48 Byte(s)), array:0x12(hti:0x0)
        int civiliansKilledGradeBest[Missions];
        // offset: 0x490, bitSize: 0x20(0x4 Byte(s))
        int startPointFails;
        // offset: 0x4b0, bitSize: 0x20(0x4 Byte(s))
        int totalGameplayTime;
        // offset: 0x4d0, bitSize: 0x8(0x1 Byte(s))
        Missions currentMission;
        // offset: 0x4d8, bitSize: 0x240(0x48 Byte(s)), array:0x12(hti:0x0)
        int civiliansKilledGrade[Missions];
        // offset: 0x718, bitSize: 0x20(0x4 Byte(s))
        int kleenexSectionTime;
        // offset: 0x738, bitSize: 0x1
        bool achievementDoorPeekKick;
        // offset: 0x739, bitSize: 0x1
        bool achievementDoorPeekOpen;
        // offset: 0x73a, bitSize: 0x1
        bool beatRealism;
        // offset: 0x73b, bitSize: 0x1
        bool unlockedRealism;
        // offset: 0x73c, bitSize: 0x1
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

    // root: bitSize: 0x740, members: 1

    // offset: 0x0, bitSize: 0x740(0xe8 Byte(s))
    SPProgression spData;
};

