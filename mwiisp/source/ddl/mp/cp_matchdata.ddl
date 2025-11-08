// file .... ddl\mp\cp_matchdata.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 2 (0x2)
    // bit size .. 3576 (0xdf8)
    // byte size . 447 (0x1bf)
    // archive ... hash_e526bb58305d4af8

    // bitSize: 0xd40, members: 36
    struct CommonMatchData {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) map;
        // offset: 0x100, bitSize: 0x100(0x20 Byte(s))
        string(32) mapB;
        // offset: 0x200, bitSize: 0x8(0x1 Byte(s))
        byte player_count;
        // offset: 0x208, bitSize: 0x208(0x41 Byte(s))
        string(65) dmlRegion;
        // offset: 0x410, bitSize: 0x10(0x2 Byte(s))
        uint:16 weapon_map_watermark;
        // offset: 0x420, bitSize: 0x40(0x8 Byte(s))
        uint64 match_id;
        // offset: 0x460, bitSize: 0x18(0x3 Byte(s))
        string(3) dmlCountryCode;
        // offset: 0x478, bitSize: 0x20(0x4 Byte(s))
        uint dataCenterId;
        // offset: 0x498, bitSize: 0x88(0x11 Byte(s))
        string(17) dw_lobby_id;
        // offset: 0x520, bitSize: 0x8(0x1 Byte(s))
        byte player_count_end;
        // offset: 0x528, bitSize: 0x20(0x4 Byte(s))
        int serverTimeCount;
        // offset: 0x548, bitSize: 0x20(0x4 Byte(s))
        int serverTimeTotal;
        // offset: 0x568, bitSize: 0x48(0x9 Byte(s))
        string(9) dmlTimezone;
        // offset: 0x5b0, bitSize: 0x20(0x4 Byte(s))
        uint patchManifestVersion;
        // offset: 0x5d0, bitSize: 0x20(0x4 Byte(s))
        int serverTimeTotalExceed;
        // offset: 0x5f0, bitSize: 0x20(0x4 Byte(s))
        float dmlLatitude;
        // offset: 0x610, bitSize: 0x20(0x4 Byte(s))
        uint protocolVersion;
        // offset: 0x630, bitSize: 0x408(0x81 Byte(s))
        string(129) dmlCity;
        // offset: 0xa38, bitSize: 0x80(0x10 Byte(s))
        string(16) build_version;
        // offset: 0xab8, bitSize: 0x40(0x8 Byte(s))
        uint64 boot_guid;
        // offset: 0xaf8, bitSize: 0x100(0x20 Byte(s))
        string(32) gametype;
        // offset: 0xbf8, bitSize: 0x20(0x4 Byte(s))
        int matchMakingSettingsVersion;
        // offset: 0xc18, bitSize: 0x20(0x4 Byte(s))
        uint utc_end_time_s;
        // offset: 0xc38, bitSize: 0x20(0x4 Byte(s))
        uint utc_start_time_s;
        // offset: 0xc58, bitSize: 0x8(0x1 Byte(s))
        byte player_count_start;
        // offset: 0xc60, bitSize: 0x20(0x4 Byte(s))
        uint dmlASN;
        // offset: 0xc80, bitSize: 0x20(0x4 Byte(s))
        uint titleID;
        // offset: 0xca0, bitSize: 0x20(0x4 Byte(s))
        int build_number;
        // offset: 0xcc0, bitSize: 0x10(0x2 Byte(s))
        uint:16 srcDDLVersion;
        // offset: 0xcd0, bitSize: 0x20(0x4 Byte(s))
        int serverTimeExceedCount;
        // offset: 0xcf0, bitSize: 0x8(0x1 Byte(s))
        byte player_count_left;
        // offset: 0xcf8, bitSize: 0x20(0x4 Byte(s))
        int serverTimeMax;
        // offset: 0xd18, bitSize: 0x20(0x4 Byte(s))
        float dmlLongitude;
        // offset: 0xd38, bitSize: 0x1
        bool is_ranked_match;
        // offset: 0xd39, bitSize: 0x1
        bool is_private_match;
    };

    // root: bitSize: 0xd48, members: 2

    // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
    byte playerCountMaxConcurrent;
    // offset: 0x8, bitSize: 0xd40(0x1a8 Byte(s))
    CommonMatchData commonMatchData;
};

