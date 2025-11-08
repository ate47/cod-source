// file .... ddl\mp\brmatchdata.ddl

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 2 (0x2)
    // bit size .. 7720 (0x1e28)
    // byte size . 965 (0x3c5)
    // archive ... hash_a50a8fdfc6243ac6

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

    // idx 0x0 members: 0x36 type: 0
    enum Team {
        none, // 0x0
        free, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        spectator, // 0x34
        codcaster // 0x35
    };

    // root: bitSize: 0x1d78, members: 38

    // offset: 0x0, bitSize: 0x170(0x2e Byte(s))
    string(46) host;
    // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
    int party_maxplayers;
    // offset: 0x190, bitSize: 0x8(0x1 Byte(s))
    byte firstOvertimeRoundIndex;
    // offset: 0x198, bitSize: 0x20(0x4 Byte(s))
    uint dataCenterId;
    // offset: 0x1b8, bitSize: 0x20(0x4 Byte(s))
    uint breadcrumb_count;
    // offset: 0x1d8, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    uint utcRoundEndTimeSeconds[24];
    // offset: 0x4d8, bitSize: 0x40(0x8 Byte(s))
    uint64 tournamentId;
    // offset: 0x518, bitSize: 0x8(0x1 Byte(s))
    byte globalWeaponXpModifier;
    // offset: 0x520, bitSize: 0x10(0x2 Byte(s))
    uint:16 tournamentMatch;
    // offset: 0x530, bitSize: 0x10(0x2 Byte(s))
    uint:16 tournamentRound;
    // offset: 0x540, bitSize: 0x20(0x4 Byte(s))
    int serverScriptTimeExceedTotal;
    // offset: 0x560, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x580, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x5a0, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    uint utcRoundStartTimeSeconds[24];
    // offset: 0x8a0, bitSize: 0x10(0x2 Byte(s))
    short killstreakCount;
    // offset: 0x8b0, bitSize: 0x20(0x4 Byte(s))
    int playlistID;
    // offset: 0x8d0, bitSize: 0x20(0x4 Byte(s))
    int isDedicated;
    // offset: 0x8f0, bitSize: 0x20(0x4 Byte(s))
    int cmdQueuedHistogramRange;
    // offset: 0x910, bitSize: 0x20(0x4 Byte(s))
    int cmdBurstHistogramRange;
    // offset: 0x930, bitSize: 0xd40(0x1a8 Byte(s))
    CommonMatchData commonMatchData;
    // offset: 0x1670, bitSize: 0x20(0x4 Byte(s))
    int serverScriptTimeTotal;
    // offset: 0x1690, bitSize: 0x20(0x4 Byte(s))
    int serverScriptTimeMax;
    // offset: 0x16b0, bitSize: 0x10(0x2 Byte(s))
    short killstreakAvailableCount;
    // offset: 0x16c0, bitSize: 0x20(0x4 Byte(s))
    int playlistVersion;
    // offset: 0x16e0, bitSize: 0x20(0x4 Byte(s))
    int scoreProgressLimit;
    // offset: 0x1700, bitSize: 0x8(0x1 Byte(s))
    Team victor;
    // offset: 0x1708, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    int alliesRoundScore[24];
    // offset: 0x1a08, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    int axisRoundScore[24];
    // offset: 0x1d08, bitSize: 0x20(0x4 Byte(s))
    int serverScriptCalcTimeTotal;
    // offset: 0x1d28, bitSize: 0x8(0x1 Byte(s))
    byte globalPlayerXpModifier;
    // offset: 0x1d30, bitSize: 0x10(0x2 Byte(s))
    short lifeCount;
    // offset: 0x1d40, bitSize: 0x10(0x2 Byte(s))
    short gameEventCount;
    // offset: 0x1d50, bitSize: 0x20(0x4 Byte(s))
    int cmdReceivedHistogramRange;
    // offset: 0x1d70, bitSize: 0x1
    bool cmdBufferingEnabled;
    // offset: 0x1d71, bitSize: 0x1
    bool hasBots;
    // offset: 0x1d72, bitSize: 0x1
    bool hostMigrationOccurred;
    // offset: 0x1d73, bitSize: 0x1
    bool codESportsRules;
};

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 2 (0x2)
    // bit size .. 7688 (0x1e08)
    // byte size . 961 (0x3c1)
    // archive ... hash_a4793268e8c64c5c

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

    // idx 0x0 members: 0x36 type: 0
    enum Team {
        none, // 0x0
        free, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        spectator, // 0x34
        codcaster // 0x35
    };

    // root: bitSize: 0x1d58, members: 37

    // offset: 0x0, bitSize: 0x170(0x2e Byte(s))
    string(46) host;
    // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
    int party_maxplayers;
    // offset: 0x190, bitSize: 0x8(0x1 Byte(s))
    byte firstOvertimeRoundIndex;
    // offset: 0x198, bitSize: 0x20(0x4 Byte(s))
    uint dataCenterId;
    // offset: 0x1b8, bitSize: 0x20(0x4 Byte(s))
    uint breadcrumb_count;
    // offset: 0x1d8, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    uint utcRoundEndTimeSeconds[24];
    // offset: 0x4d8, bitSize: 0x40(0x8 Byte(s))
    uint64 tournamentId;
    // offset: 0x518, bitSize: 0x8(0x1 Byte(s))
    byte globalWeaponXpModifier;
    // offset: 0x520, bitSize: 0x10(0x2 Byte(s))
    uint:16 tournamentMatch;
    // offset: 0x530, bitSize: 0x10(0x2 Byte(s))
    uint:16 tournamentRound;
    // offset: 0x540, bitSize: 0x20(0x4 Byte(s))
    int serverScriptTimeExceedTotal;
    // offset: 0x560, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x580, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x5a0, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    uint utcRoundStartTimeSeconds[24];
    // offset: 0x8a0, bitSize: 0x10(0x2 Byte(s))
    short killstreakCount;
    // offset: 0x8b0, bitSize: 0x20(0x4 Byte(s))
    int playlistID;
    // offset: 0x8d0, bitSize: 0x20(0x4 Byte(s))
    int isDedicated;
    // offset: 0x8f0, bitSize: 0x20(0x4 Byte(s))
    int cmdQueuedHistogramRange;
    // offset: 0x910, bitSize: 0x20(0x4 Byte(s))
    int cmdBurstHistogramRange;
    // offset: 0x930, bitSize: 0xd40(0x1a8 Byte(s))
    CommonMatchData commonMatchData;
    // offset: 0x1670, bitSize: 0x20(0x4 Byte(s))
    int serverScriptTimeTotal;
    // offset: 0x1690, bitSize: 0x20(0x4 Byte(s))
    int serverScriptTimeMax;
    // offset: 0x16b0, bitSize: 0x10(0x2 Byte(s))
    short killstreakAvailableCount;
    // offset: 0x16c0, bitSize: 0x20(0x4 Byte(s))
    int playlistVersion;
    // offset: 0x16e0, bitSize: 0x8(0x1 Byte(s))
    Team victor;
    // offset: 0x16e8, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    int alliesRoundScore[24];
    // offset: 0x19e8, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
    int axisRoundScore[24];
    // offset: 0x1ce8, bitSize: 0x20(0x4 Byte(s))
    int serverScriptCalcTimeTotal;
    // offset: 0x1d08, bitSize: 0x8(0x1 Byte(s))
    byte globalPlayerXpModifier;
    // offset: 0x1d10, bitSize: 0x10(0x2 Byte(s))
    short lifeCount;
    // offset: 0x1d20, bitSize: 0x10(0x2 Byte(s))
    short gameEventCount;
    // offset: 0x1d30, bitSize: 0x20(0x4 Byte(s))
    int cmdReceivedHistogramRange;
    // offset: 0x1d50, bitSize: 0x1
    bool cmdBufferingEnabled;
    // offset: 0x1d51, bitSize: 0x1
    bool hasBots;
    // offset: 0x1d52, bitSize: 0x1
    bool hostMigrationOccurred;
    // offset: 0x1d53, bitSize: 0x1
    bool codESportsRules;
};

