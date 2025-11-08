// file .... ddl\mp\nongamedata.ddl

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 17 (0x11)
    // bit size .. 17552 (0x4490)
    // byte size . 2194 (0x892)
    // archive ... hash_a50c891215ee10fd

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x2e00, members: 48
    struct UnlockTable {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int fx[1];
        // offset: 0x20, bitSize: 0x160(0x2c Byte(s)), array:0xb(hti:0xffff)
        int camo[11];
        // offset: 0x180, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int perk[2];
        // offset: 0x1c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int role[1];
        // offset: 0x1e0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int temp[1];
        // offset: 0x200, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int playofmatchintro[1];
        // offset: 0x220, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int loot_crate[1];
        // offset: 0x240, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int intro[1];
        // offset: 0x260, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int super[2];
        // offset: 0x2a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special_weapon[1];
        // offset: 0x2c0, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int firstpartylicence[5];
        // offset: 0x360, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int executions[4];
        // offset: 0x3e0, bitSize: 0x400(0x80 Byte(s)), array:0x20(hti:0xffff)
        int playercards[32];
        // offset: 0x7e0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int munition[1];
        // offset: 0x800, bitSize: 0x1a0(0x34 Byte(s)), array:0xd(hti:0xffff)
        int weapon_charm[13];
        // offset: 0x9a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int currencypack[1];
        // offset: 0x9c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int mission[1];
        // offset: 0x9e0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int equipment[2];
        // offset: 0xa20, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int reticle[3];
        // offset: 0xa80, bitSize: 0x1c0(0x38 Byte(s)), array:0xe(hti:0xffff)
        int operator_quip[14];
        // offset: 0xc40, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int operator_skin[2];
        // offset: 0xc80, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_track[1];
        // offset: 0xca0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int parachute[1];
        // offset: 0xcc0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int gestures[1];
        // offset: 0xce0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int battlepass[1];
        // offset: 0xd00, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int accessory[4];
        // offset: 0xd80, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int other_titles_battlepass[1];
        // offset: 0xda0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_camo[1];
        // offset: 0xdc0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_horn[1];
        // offset: 0xde0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int playercardframes[1];
        // offset: 0xe00, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special[1];
        // offset: 0xe20, bitSize: 0xf80(0x1f0 Byte(s)), array:0x7c(hti:0xffff)
        int attachment[124];
        // offset: 0x1da0, bitSize: 0x440(0x88 Byte(s)), array:0x22(hti:0xffff)
        int sticker[34];
        // offset: 0x21e0, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int accolades[5];
        // offset: 0x2280, bitSize: 0x400(0x80 Byte(s)), array:0x20(hti:0xffff)
        int emblems[32];
        // offset: 0x2680, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int playercardtitles[1];
        // offset: 0x26a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int mvphighlight[1];
        // offset: 0x26c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int bundle[1];
        // offset: 0x26e0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int flares[1];
        // offset: 0x2700, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int tracker[1];
        // offset: 0x2720, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int feature[1];
        // offset: 0x2740, bitSize: 0x300(0x60 Byte(s)), array:0x18(hti:0xffff)
        int sprays[24];
        // offset: 0x2a40, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int taunts[1];
        // offset: 0x2a60, bitSize: 0xe0(0x1c Byte(s)), array:0x7(hti:0xffff)
        int weapon[7];
        // offset: 0x2b40, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int killstreak[2];
        // offset: 0x2b80, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int operator[2];
        // offset: 0x2bc0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int loadingscreens[1];
        // offset: 0x2be0, bitSize: 0x220(0x44 Byte(s)), array:0x11(hti:0xffff)
        int consumable[17];
    };

    // bitSize: 0x380, members: 10
    struct DeviceConnectionHistory {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short suckedAsHost;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte deviceUseFrequency;
        // offset: 0x18, bitSize: 0x80(0x10 Byte(s)), array:0x10(hti:0xffff)
        byte bandwidthUp[16];
        // offset: 0x98, bitSize: 0x200(0x40 Byte(s))
        string(64) deviceDescriptor;
        // offset: 0x298, bitSize: 0x20(0x4 Byte(s))
        int bandwidthTestCount;
        // offset: 0x2b8, bitSize: 0x80(0x10 Byte(s)), array:0x10(hti:0xffff)
        byte bandwidthDown[16];
        // offset: 0x338, bitSize: 0x20(0x4 Byte(s))
        int device_id_low;
        // offset: 0x358, bitSize: 0x20(0x4 Byte(s))
        int device_id_high;
        // offset: 0x378, bitSize: 0x1
        bool onWifi;
    };

    // bitSize: 0x60, members: 3
    struct PlayerConnectionHistory {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int gameCount;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int migrateableQuits;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int nonMigrateableQuits;
    };

    // bitSize: 0x10, members: 2
    struct CallingCardSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        RaritySortOptions raritySortPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        SeasonSortOptions seasonSortPreference;
    };

    // bitSize: 0x18, members: 4
    struct EmblemSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        RaritySortOptions raritySortPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        SeasonSortOptions seasonSortPreference;
        // offset: 0x10, bitSize: 0x1
        OfficerProgressionSortOptions officerSortPreference;
    };

    // bitSize: 0x10, members: 2
    struct GesturesSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        RaritySortOptions raritySortPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        SeasonSortOptions seasonSortPreference;
    };

    // bitSize: 0x10, members: 2
    struct CharmsSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        RaritySortOptions raritySortPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        SeasonSortOptions seasonSortPreference;
    };

    // bitSize: 0x10, members: 2
    struct StickersSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        RaritySortOptions raritySortPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        SeasonSortOptions seasonSortPreference;
    };

    // bitSize: 0x10, members: 2
    struct VehicleSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        CamoActiveFilter camoActiveFilter;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        TrackActiveFilter trackActiveFilter;
    };

    // bitSize: 0x68, members: 6
    struct PlayerSortPreferences {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        GesturesSortPreferences gesturesSortPreference;
        // offset: 0x10, bitSize: 0x18(0x3 Byte(s))
        EmblemSortPreferences emblemSortPreference;
        // offset: 0x28, bitSize: 0x10(0x2 Byte(s))
        StickersSortPreferences stickerSortPreference;
        // offset: 0x38, bitSize: 0x10(0x2 Byte(s))
        CharmsSortPreferences charmsSortPreference;
        // offset: 0x48, bitSize: 0x10(0x2 Byte(s))
        VehicleSortPreferences vehicleSortPreference;
        // offset: 0x58, bitSize: 0x10(0x2 Byte(s))
        CallingCardSortPreferences callingcardSortPreference;
    };

    // bitSize: 0x8, members: 8
    struct NotificationSettings {
        // offset: 0x0, bitSize: 0x1
        bool broadcastChannelInvite;
        // offset: 0x1, bitSize: 0x1
        bool broadcastClanInvite;
        // offset: 0x2, bitSize: 0x1
        bool broadcastGroupInvite;
        // offset: 0x3, bitSize: 0x1
        bool voiceShareStarted;
        // offset: 0x4, bitSize: 0x1
        bool newMember;
        // offset: 0x5, bitSize: 0x1
        bool broadcastPartyInvite;
        // offset: 0x6, bitSize: 0x1
        bool newTextChatMessages;
    };

    // bitSize: 0x8, members: 6
    struct FeedFilterSettings {
        // offset: 0x0, bitSize: 0x1
        bool broadcastChannelInvite;
        // offset: 0x1, bitSize: 0x1
        bool memberTextMessages;
        // offset: 0x2, bitSize: 0x1
        bool broadcastClanInvite;
        // offset: 0x3, bitSize: 0x1
        bool broadcastGroupInvite;
        // offset: 0x4, bitSize: 0x1
        bool broadcastPartyInvite;
    };

    // bitSize: 0x78, members: 6
    struct SocialPartySettings {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        uint color;
        // offset: 0x20, bitSize: 0x40(0x8 Byte(s))
        uint64 partyId;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        NotificationSettings notificationSettings;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        FeedFilterSettings feedFilters;
        // offset: 0x70, bitSize: 0x1
        bool useDefault;
    };

    // bitSize: 0x10, members: 2
    struct DefaultPartySettings {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        NotificationSettings notificationSettings;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        FeedFilterSettings feedFilters;
    };

    // bitSize: 0x43d8, members: 40
    struct NonGameData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkLow[4];
        // offset: 0x80, bitSize: 0x2e00(0x5c0 Byte(s))
        UnlockTable isNew;
        // offset: 0x2e80, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_background[2];
        // offset: 0x2ea0, bitSize: 0x40(0x8 Byte(s))
        uint64 toastNotificationUnpauseTimestamp;
        // offset: 0x2ee0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkHigh[4];
        // offset: 0x2f60, bitSize: 0x8(0x1 Byte(s))
        byte quickplayFilter;
        // offset: 0x2f68, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidLow[4];
        // offset: 0x2fe8, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int tournamentQuits[4];
        // offset: 0x3068, bitSize: 0x20(0x4 Byte(s))
        uint snoozedToastTypes;
        // offset: 0x3088, bitSize: 0x8(0x1 Byte(s))
        PartyPrivacySetting partyPrivacySettings;
        // offset: 0x3090, bitSize: 0x20(0x4 Byte(s))
        int bigTournamentBanStart;
        // offset: 0x30b0, bitSize: 0x20(0x4 Byte(s))
        uint mpMotdChecksum;
        // offset: 0x30d0, bitSize: 0x40(0x8 Byte(s))
        uint64 influencerCodeTime;
        // offset: 0x3110, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesLastSeenTime;
        // offset: 0x3130, bitSize: 0x20(0x4 Byte(s))
        uint brMotdChecksum;
        // offset: 0x3150, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesPopupChecksum;
        // offset: 0x3170, bitSize: 0x258(0x4b Byte(s)), array:0x5(hti:0xffff)
        SocialPartySettings socialPartySettings[5];
        // offset: 0x33c8, bitSize: 0x20(0x4 Byte(s))
        uint cpMotdChecksum;
        // offset: 0x33e8, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkHigh[4];
        // offset: 0x3468, bitSize: 0x20(0x4 Byte(s))
        uint lastBattlePassMenuXp;
        // offset: 0x3488, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkLow[4];
        // offset: 0x3508, bitSize: 0x10(0x2 Byte(s))
        DefaultPartySettings defaultPartySettings;
        // offset: 0x3518, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidHigh[4];
        // offset: 0x3598, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int maxPrivatePartySize[2];
        // offset: 0x35d8, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_patch[2];
        // offset: 0x35f8, bitSize: 0xa80(0x150 Byte(s)), array:0x3(hti:0xffff)
        DeviceConnectionHistory deviceConnectionHistory[3];
        // offset: 0x4078, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_frame[2];
        // offset: 0x4098, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_title[2];
        // offset: 0x40b8, bitSize: 0x68(0xd Byte(s))
        PlayerSortPreferences sortPreferences;
        // offset: 0x4120, bitSize: 0x200(0x40 Byte(s))
        string(64) influencerCode;
        // offset: 0x4320, bitSize: 0x8(0x1 Byte(s))
        byte lastBattlePassFreeTierSeen;
        // offset: 0x4328, bitSize: 0x8(0x1 Byte(s))
        VoicePartyType joinOnMatchmaking;
        // offset: 0x4330, bitSize: 0x20(0x4 Byte(s))
        int currentTournament;
        // offset: 0x4350, bitSize: 0x60(0xc Byte(s))
        PlayerConnectionHistory playerConnectionHistory;
        // offset: 0x43b0, bitSize: 0x1
        bool toggleOfflineFriends;
        // offset: 0x43b1, bitSize: 0x1
        bool cross_play_enabled;
        // offset: 0x43b2, bitSize: 0x1
        bool muteOnJoinParty;
        // offset: 0x43b3, bitSize: 0x1
        bool party_autofill_lock;
        // offset: 0x43b4, bitSize: 0x20(0x4 Byte(s)), array:0x20(hti:0xffff)
        bool postShipFlags[32];
    };

    // idx 0x0 members: 0x5 type: 0
    enum ValidationHint {
        StatsReset, // 0x0
        PrestigeReset, // 0x1
        FirstUpload, // 0x2
        FailedUpload, // 0x3
        DoubleXPUsed // 0x4
    };

    // idx 0x1 members: 0x4 type: 0
    enum PartyPrivacySetting {
        public, // 0x0
        joinable_by_friends, // 0x1
        invite_only, // 0x2
        closed // 0x3
    };

    // idx 0x2 members: 0x3 type: 0
    enum RaritySortOptions {
        rarity_high_first, // 0x0
        rarity_low_first, // 0x1
        rarity_none // 0x2
    };

    // idx 0x3 members: 0x3 type: 0
    enum SeasonSortOptions {
        season_recent_first, // 0x0
        season_old_first, // 0x1
        season_none // 0x2
    };

    // idx 0x4 members: 0x2 type: 0
    enum OfficerProgressionSortOptions {
        officer_none, // 0x0
        officer_first // 0x1
    };

    // idx 0x5 members: 0x4 type: 0
    enum VoicePartyType {
        lobby, // 0x0
        activity, // 0x1
        social, // 0x2
        none // 0x3
    };

    // idx 0x6 members: 0x5 type: 0
    enum CamoActiveFilter {
        all, // 0x0
        favorites, // 0x1
        collected, // 0x2
        fromBattlePass, // 0x3
        fromStoreBundle // 0x4
    };

    // idx 0x7 members: 0x4 type: 0
    enum TrackActiveFilter {
        all, // 0x0
        favorites, // 0x1
        unlocked, // 0x2
        fromBattlePass // 0x3
    };

    // root: bitSize: 0x43e0, members: 2

    // offset: 0x0, bitSize: 0x43d8(0x87b Byte(s))
    NonGameData nonGameData;
    // offset: 0x43d8, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

