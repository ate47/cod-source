// file .... ddl\sp\telemetry_leveldata.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 2 (0x2)
    // bit size .. 2224 (0x8b0)
    // byte size . 278 (0x116)
    // archive ... hash_f919ce6dce882f19

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

    // root: bitSize: 0x800, members: 6

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x8(0x1 Byte(s))
    byte lowestDifficulty;
    // offset: 0x108, bitSize: 0x8(0x1 Byte(s))
    byte highestDifficulty;
    // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
    uint:16 duration;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int totalGameplayTime;
    // offset: 0x140, bitSize: 0x6c0(0xd8 Byte(s))
    TelemetryInteractionHeader metadata;
};

