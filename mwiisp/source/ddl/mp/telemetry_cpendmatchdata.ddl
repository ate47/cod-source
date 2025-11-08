// file .... ddl\mp\telemetry_cpendmatchdata.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 3120 (0xc30)
    // byte size . 390 (0x186)
    // archive ... hash_2274cf83db40d683

    // bitSize: 0x6c0, members: 14
    struct TelemetryInteractionHeader {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s))
        string(64) ip;
        // offset: 0x200, bitSize: 0x18(0x3 Byte(s))
        string(3) country;
        // offset: 0x218, bitSize: 0x100(0x20 Byte(s))
        string(32) action_type;
        // offset: 0x318, bitSize: 0x100(0x20 Byte(s))
        string(32) session_id;
        // offset: 0x418, bitSize: 0x20(0x4 Byte(s))
        string(4) platform;
        // offset: 0x438, bitSize: 0x20(0x4 Byte(s))
        uint nat_type;
        // offset: 0x458, bitSize: 0x20(0x4 Byte(s))
        uint title_id;
        // offset: 0x478, bitSize: 0xa0(0x14 Byte(s))
        string(20) language;
        // offset: 0x518, bitSize: 0x100(0x20 Byte(s))
        string(32) game_version;
        // offset: 0x618, bitSize: 0x20(0x4 Byte(s))
        uint utc_timestamp;
        // offset: 0x638, bitSize: 0x40(0x8 Byte(s))
        uint64 uno_id;
        // offset: 0x678, bitSize: 0x40(0x8 Byte(s))
        uint64 user_id;
        // offset: 0x6b8, bitSize: 0x1
        bool is_splitscreen;
    };

    // bitSize: 0x388, members: 11
    struct Match {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) map;
        // offset: 0x100, bitSize: 0x8(0x1 Byte(s))
        byte playerCountEnd;
        // offset: 0x108, bitSize: 0x128(0x25 Byte(s))
        string(37) matchGUID;
        // offset: 0x230, bitSize: 0x20(0x4 Byte(s))
        uint utcEndTimeSeconds;
        // offset: 0x250, bitSize: 0x20(0x4 Byte(s))
        uint utcStartTimeSeconds;
        // offset: 0x270, bitSize: 0x8(0x1 Byte(s))
        byte playerCountStart;
        // offset: 0x278, bitSize: 0x100(0x20 Byte(s))
        string(32) gametype;
        // offset: 0x378, bitSize: 0x8(0x1 Byte(s))
        byte playerCountLeft;
        // offset: 0x380, bitSize: 0x1
        bool isPrivateMatch;
        // offset: 0x381, bitSize: 0x1
        bool isRankedMatch;
    };

    // root: bitSize: 0xb80, members: 19

    // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
    uint:16 hits;
    // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
    byte rank;
    // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
    uint:16 downs;
    // offset: 0x28, bitSize: 0x10(0x2 Byte(s))
    uint:16 kills;
    // offset: 0x38, bitSize: 0x388(0x71 Byte(s))
    Match match;
    // offset: 0x3c0, bitSize: 0x10(0x2 Byte(s))
    uint:16 shots;
    // offset: 0x3d0, bitSize: 0x10(0x2 Byte(s))
    uint:16 revives;
    // offset: 0x3e0, bitSize: 0x8(0x1 Byte(s))
    byte waveEnd;
    // offset: 0x3e8, bitSize: 0x8(0x1 Byte(s))
    byte waveStart;
    // offset: 0x3f0, bitSize: 0x20(0x4 Byte(s))
    int moneyEarned;
    // offset: 0x410, bitSize: 0x8(0x1 Byte(s))
    byte prestige;
    // offset: 0x418, bitSize: 0x20(0x4 Byte(s))
    int totalGameplayTime;
    // offset: 0x438, bitSize: 0x6c0(0xd8 Byte(s))
    TelemetryInteractionHeader metadata;
    // offset: 0xaf8, bitSize: 0x20(0x4 Byte(s))
    int gamesPlayed;
    // offset: 0xb18, bitSize: 0x40(0x8 Byte(s))
    uint64 hostXuid;
    // offset: 0xb58, bitSize: 0x10(0x2 Byte(s))
    uint:16 doorsOpened;
    // offset: 0xb68, bitSize: 0x10(0x2 Byte(s))
    uint:16 headShots;
    // offset: 0xb78, bitSize: 0x1
    bool quit;
};

