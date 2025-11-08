// file .... ddl\mp\zombiematchdata.ddl

version 1 {
    // enums ..... 2 (0x2)
    // structs ... 6 (0x6)
    // bit size .. 74344 (0x12268)
    // byte size . 9293 (0x244d)
    // archive ... hash_a51ba748568c8eeb

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

    // bitSize: 0x8, members: 3
    struct Challenge {
        // offset: 0x0, bitSize: 0x1
        bool success;
        // offset: 0x1, bitSize: 0x1
        ChallengeName challengeId;
    };

    // bitSize: 0x0, members: 0
    struct Life {
    };

    // bitSize: 0x8a0, members: 48
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        uint:16 hits;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte rank;
        // offset: 0x18, bitSize: 0x20(0x4 Byte(s))
        int exiting_afterlife_arcade;
        // offset: 0x38, bitSize: 0xc8(0x19 Byte(s)), array:0x19(hti:0xffff)
        byte timesDowned[25];
        // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
        int death;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        uint:16 downs;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        uint:16 kills;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        uint:16 shots;
        // offset: 0x150, bitSize: 0x20(0x4 Byte(s))
        int atm_used;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int currency_earned;
        // offset: 0x190, bitSize: 0xc8(0x19 Byte(s)), array:0x19(hti:0xffff)
        byte timesBledOut[25];
        // offset: 0x258, bitSize: 0x20(0x4 Byte(s))
        int zombie_death;
        // offset: 0x278, bitSize: 0x20(0x4 Byte(s))
        int revived_another_player;
        // offset: 0x298, bitSize: 0xd0(0x1a Byte(s))
        string(26) disconnectReason;
        // offset: 0x368, bitSize: 0x20(0x4 Byte(s))
        int cashSpentOnAbility;
        // offset: 0x388, bitSize: 0x20(0x4 Byte(s))
        int crafted_item_placed;
        // offset: 0x3a8, bitSize: 0x10(0x2 Byte(s))
        uint:16 revives;
        // offset: 0x3b8, bitSize: 0x8(0x1 Byte(s))
        byte waveEnd;
        // offset: 0x3c0, bitSize: 0x20(0x4 Byte(s))
        int xp_earned;
        // offset: 0x3e0, bitSize: 0x20(0x4 Byte(s))
        int xpEarned;
        // offset: 0x400, bitSize: 0x20(0x4 Byte(s))
        int isSplitscreen;
        // offset: 0x420, bitSize: 0x8(0x1 Byte(s))
        byte waveStart;
        // offset: 0x428, bitSize: 0xc8(0x19 Byte(s)), array:0x19(hti:0xffff)
        byte timesRevived[25];
        // offset: 0x4f0, bitSize: 0x20(0x4 Byte(s))
        int cashSpentOnTrap;
        // offset: 0x510, bitSize: 0x20(0x4 Byte(s))
        int purchasing_for_a_team_door;
        // offset: 0x530, bitSize: 0x20(0x4 Byte(s))
        int faf_card_refill;
        // offset: 0x550, bitSize: 0x20(0x4 Byte(s))
        int moneyEarned;
        // offset: 0x570, bitSize: 0x10(0x2 Byte(s))
        short validationInfractions;
        // offset: 0x580, bitSize: 0x20(0x4 Byte(s))
        int finalScore;
        // offset: 0x5a0, bitSize: 0x20(0x4 Byte(s))
        int finished_mini_game;
        // offset: 0x5c0, bitSize: 0x20(0x4 Byte(s))
        int purchasing_weapon;
        // offset: 0x5e0, bitSize: 0x170(0x2e Byte(s))
        string(46) gamertag;
        // offset: 0x750, bitSize: 0x20(0x4 Byte(s))
        int dropped_to_last_stand;
        // offset: 0x770, bitSize: 0x20(0x4 Byte(s))
        int entering_afterlife_arcade;
        // offset: 0x790, bitSize: 0x8(0x1 Byte(s))
        byte prestige;
        // offset: 0x798, bitSize: 0x20(0x4 Byte(s))
        int cashSpentOnWeapon;
        // offset: 0x7b8, bitSize: 0x20(0x4 Byte(s))
        int opening_the_doors;
        // offset: 0x7d8, bitSize: 0x20(0x4 Byte(s))
        int totalGameplayTime;
        // offset: 0x7f8, bitSize: 0x20(0x4 Byte(s))
        int faf_card_used;
        // offset: 0x818, bitSize: 0x20(0x4 Byte(s))
        int pillage_event;
        // offset: 0x838, bitSize: 0x20(0x4 Byte(s))
        int gamesPlayed;
        // offset: 0x858, bitSize: 0x20(0x4 Byte(s))
        int shots_on_target;
        // offset: 0x878, bitSize: 0x10(0x2 Byte(s))
        uint:16 doorsOpened;
        // offset: 0x888, bitSize: 0x10(0x2 Byte(s))
        uint:16 headShots;
        // offset: 0x898, bitSize: 0x1
        bool JIP;
        // offset: 0x899, bitSize: 0x1
        bool quit;
        // offset: 0x89a, bitSize: 0x1
        bool joinInProgress;
    };

    // bitSize: 0x20, members: 1
    struct Weapon {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int death;
    };

    // idx 0x0 members: 0x2 type: 0
    enum ChallengeName {
        spend_10k, // 0x0
        spend_20k // 0x1
    };

    // idx 0x1 members: 0x7 type: 0
    enum EndGameCondition {
        all_escape, // 0x0
        drill_destroyed, // 0x1
        died, // 0x2
        some_escape, // 0x3
        fail_escape, // 0x4
        host_quit, // 0x5
        gas_fail // 0x6
    };

    // root: bitSize: 0x121b8, members: 42

    // offset: 0x0, bitSize: 0x0(0x0 Byte(s)), array:0x11d(hti:0xffff)
    Life lives[285];
    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    int pack_a_punch_used;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    int shot_icemonster;
    // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
    int suicide_bomber_sequence_activated;
    // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
    int balloons_popped;
    // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
    int neil_head;
    // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
    int challenge_activated;
    // offset: 0xc0, bitSize: 0x20(0x4 Byte(s))
    int activate_enter_ghostskulls_game;
    // offset: 0xe0, bitSize: 0x8(0x1 Byte(s))
    EndGameCondition gameOverCondition;
    // offset: 0xe8, bitSize: 0x20(0x4 Byte(s))
    int neil_battery;
    // offset: 0x108, bitSize: 0xc80(0x190 Byte(s)), array:0x64(hti:0xffff)
    Weapon weapons[100];
    // offset: 0xd88, bitSize: 0x20(0x4 Byte(s))
    int totalTimeElapsed;
    // offset: 0xda8, bitSize: 0x20(0x4 Byte(s))
    int grey_sequence_activated;
    // offset: 0xdc8, bitSize: 0x20(0x4 Byte(s))
    int neil_floppy;
    // offset: 0xde8, bitSize: 0x20(0x4 Byte(s))
    int souvenir_coin_used;
    // offset: 0xe08, bitSize: 0x20(0x4 Byte(s))
    int beating_arcade_games;
    // offset: 0xe28, bitSize: 0xc8(0x19 Byte(s)), array:0x19(hti:0xffff)
    Challenge challengesCompleted[25];
    // offset: 0xef0, bitSize: 0x20(0x4 Byte(s))
    int escapeTimeRemaining;
    // offset: 0xf10, bitSize: 0x20(0x4 Byte(s))
    int lost_and_found;
    // offset: 0xf30, bitSize: 0x20(0x4 Byte(s))
    int frequency_device_collected;
    // offset: 0xf50, bitSize: 0x8(0x1 Byte(s))
    byte playerCountMaxConcurrent;
    // offset: 0xf58, bitSize: 0x20(0x4 Byte(s))
    int turning_on_the_power;
    // offset: 0xf78, bitSize: 0x20(0x4 Byte(s))
    int item_purchase_with_tickets;
    // offset: 0xf98, bitSize: 0x20(0x4 Byte(s))
    int perk_machine_used;
    // offset: 0xfb8, bitSize: 0xd40(0x1a8 Byte(s))
    CommonMatchData commonMatchData;
    // offset: 0x1cf8, bitSize: 0x20(0x4 Byte(s))
    int ghost_spelled;
    // offset: 0x1d18, bitSize: 0x20(0x4 Byte(s))
    int speaker_defence_sequence_ends;
    // offset: 0x1d38, bitSize: 0x20(0x4 Byte(s))
    int wave_complete;
    // offset: 0x1d58, bitSize: 0x20(0x4 Byte(s))
    int player_exits_ghostskulls_games;
    // offset: 0x1d78, bitSize: 0x20(0x4 Byte(s))
    int magic_box_used;
    // offset: 0x1d98, bitSize: 0x20(0x4 Byte(s))
    int perk_returned;
    // offset: 0x1db8, bitSize: 0x20(0x4 Byte(s))
    int ufo_destroyed;
    // offset: 0x1dd8, bitSize: 0x20(0x4 Byte(s))
    int brute_hits_cabinet;
    // offset: 0x1df8, bitSize: 0x20(0x4 Byte(s))
    int challenge_completed;
    // offset: 0x1e18, bitSize: 0x20(0x4 Byte(s))
    int souvenir_coin_dropped;
    // offset: 0x1e38, bitSize: 0x20(0x4 Byte(s))
    int tone_sequence_activated;
    // offset: 0x1e58, bitSize: 0x20(0x4 Byte(s))
    int challenge_failed;
    // offset: 0x1e78, bitSize: 0x102c0(0x2058 Byte(s)), array:0x1e(hti:0xffff)
    Player players[30];
    // offset: 0x12138, bitSize: 0x20(0x4 Byte(s))
    int interaction_status;
    // offset: 0x12158, bitSize: 0x20(0x4 Byte(s))
    int portal_used;
    // offset: 0x12178, bitSize: 0x20(0x4 Byte(s))
    int item_replaced;
    // offset: 0x12198, bitSize: 0x20(0x4 Byte(s))
    int frequency_device_crafted_dj;
};

