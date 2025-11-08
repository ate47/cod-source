// file .... ddl\mp\archivesummary.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 2 (0x2)
    // bit size .. 48920 (0xbf18)
    // byte size . 6115 (0x17e3)
    // archive ... hash_a3e4140d0e2dde35

    // bitSize: 0xf0, members: 8
    struct PlayerStats {
        // offset: 0x0, bitSize: 0x40(0x8 Byte(s))
        uint64 xuid;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        uint time_in_match;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        uint:16 kills;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int xpEarned;
        // offset: 0x90, bitSize: 0x20(0x4 Byte(s))
        float accuracy;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        uint:16 deaths;
        // offset: 0xc0, bitSize: 0x20(0x4 Byte(s))
        int subpartyIndex;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        uint:16 headshots;
    };

    // root: bitSize: 0xbe68, members: 9

    // offset: 0x0, bitSize: 0xbb80(0x1770 Byte(s)), array:0xc8(hti:0xffff)
    PlayerStats playerStats[200];
    // offset: 0xbb80, bitSize: 0x100(0x20 Byte(s))
    string(32) mapname;
    // offset: 0xbc80, bitSize: 0x40(0x8 Byte(s))
    uint64 matchID;
    // offset: 0xbcc0, bitSize: 0x20(0x4 Byte(s))
    uint matchLength;
    // offset: 0xbce0, bitSize: 0x40(0x8 Byte(s))
    uint64 serverGUID;
    // offset: 0xbd20, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype;
    // offset: 0xbe20, bitSize: 0x40(0x8 Byte(s))
    uint64 hostXUID;
    // offset: 0xbe60, bitSize: 0x1
    bool isHostDedi;
};

