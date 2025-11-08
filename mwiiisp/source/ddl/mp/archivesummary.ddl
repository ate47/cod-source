// file .... ddl\mp\archivesummary.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 2634616 (0x283378)
    // byte size . 329327 (0x5066f)
    // archive ... hash_2df6258b37397e43

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

    // bitSize: 0x3280, members: 4
    struct PlayerBestPlay {
        // offset: 0x0, bitSize: 0x40(0x8 Byte(s))
        uint64 xuid;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        uint endFrameByteOffset;
        // offset: 0x60, bitSize: 0x3200(0x640 Byte(s)), array:0xc8(hti:0xffff)
        uint64 clientIndexToUnoMap[200];
        // offset: 0x3260, bitSize: 0x20(0x4 Byte(s))
        uint startFrameByteOffset;
    };

    // root: bitSize: 0x2832c8, members: 13

    // offset: 0x0, bitSize: 0xbb80(0x1770 Byte(s)), array:0xc8(hti:0xffff)
    PlayerStats playerStats[200];
    // offset: 0xbb80, bitSize: 0x100(0x20 Byte(s))
    string(32) mapname;
    // offset: 0xbc80, bitSize: 0x40(0x8 Byte(s))
    uint64 matchID;
    // offset: 0xbcc0, bitSize: 0x277400(0x4ee80 Byte(s)), array:0xc8(hti:0xffff)
    PlayerBestPlay bestPlays[200];
    // offset: 0x2830c0, bitSize: 0x20(0x4 Byte(s))
    uint matchLength;
    // offset: 0x2830e0, bitSize: 0x20(0x4 Byte(s))
    int compassBuildID;
    // offset: 0x283100, bitSize: 0x20(0x4 Byte(s))
    int dataBuildNumber;
    // offset: 0x283120, bitSize: 0x40(0x8 Byte(s))
    uint64 serverGUID;
    // offset: 0x283160, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype;
    // offset: 0x283260, bitSize: 0x20(0x4 Byte(s))
    int codeBuildNumber;
    // offset: 0x283280, bitSize: 0x40(0x8 Byte(s))
    uint64 hostXUID;
    // offset: 0x2832c0, bitSize: 0x1
    bool isHostDedi;
};

