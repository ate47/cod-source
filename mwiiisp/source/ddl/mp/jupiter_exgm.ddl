// file .... ddl\mp\jupiter_exgm.ddl

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 3 (0x3)
    // bit size .. 5624 (0x15f8)
    // byte size . 703 (0x2bf)
    // archive ... hash_fe6deec9fca85ad

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x30, members: 2
    struct LostItem {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short quantity;
        // offset: 0x10, bitSize: 0x20(0x4 Byte(s))
        int lootID;
    };

    // idx 0x0 members: 0x5 type: 0
    enum ValidationHint {
        StatsReset, // 0x0
        PrestigeReset, // 0x1
        FirstUpload, // 0x2
        FailedUpload, // 0x3
        DoubleXPUsed // 0x4
    };

    // root: bitSize: 0x1548, members: 5

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    int lootedCash;
    // offset: 0x20, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
    float lostGearOrigin[3];
    // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
    int dollars;
    // offset: 0xa0, bitSize: 0x14a0(0x294 Byte(s)), array:0x6e(hti:0xffff)
    LostItem lostGear[110];
    // offset: 0x1540, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 3 (0x3)
    // bit size .. 5624 (0x15f8)
    // byte size . 703 (0x2bf)
    // archive ... hash_fe6deec9fca85ad

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x30, members: 2
    struct LostItem {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short quantity;
        // offset: 0x10, bitSize: 0x20(0x4 Byte(s))
        int lootID;
    };

    // idx 0x0 members: 0x5 type: 0
    enum ValidationHint {
        StatsReset, // 0x0
        PrestigeReset, // 0x1
        FirstUpload, // 0x2
        FailedUpload, // 0x3
        DoubleXPUsed // 0x4
    };

    // root: bitSize: 0x1548, members: 5

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    int lootedCash;
    // offset: 0x20, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
    float lostGearOrigin[3];
    // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
    int dollars;
    // offset: 0xa0, bitSize: 0x14a0(0x294 Byte(s)), array:0x6e(hti:0xffff)
    LostItem lostGear[110];
    // offset: 0x1540, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

