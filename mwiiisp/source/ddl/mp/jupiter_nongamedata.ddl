// file .... ddl\mp\jupiter_nongamedata.ddl

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 21 (0x15)
    // bit size .. 38576 (0x96b0)
    // byte size . 4822 (0x12d6)
    // archive ... hash_5b891345513737fb

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x70c0, members: 30
    struct UnlockTable {
        // offset: 0x0, bitSize: 0x880(0x110 Byte(s)), array:0x44(hti:0xffff)
        int camo[68];
        // offset: 0x880, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int perk[6];
        // offset: 0x940, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int temp[1];
        // offset: 0x960, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int super[2];
        // offset: 0x9a0, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int firstpartylicense[5];
        // offset: 0xa40, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int gun_screen[5];
        // offset: 0xae0, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int executions[6];
        // offset: 0xba0, bitSize: 0xa40(0x148 Byte(s)), array:0x52(hti:0xffff)
        int playercards[82];
        // offset: 0x15e0, bitSize: 0x440(0x88 Byte(s)), array:0x22(hti:0xffff)
        int weapon_charm[34];
        // offset: 0x1a20, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int currencypack[1];
        // offset: 0x1a40, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int equipment[3];
        // offset: 0x1aa0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int reticle[3];
        // offset: 0x1b00, bitSize: 0x280(0x50 Byte(s)), array:0x14(hti:0xffff)
        int operator_skin[20];
        // offset: 0x1d80, bitSize: 0x2a0(0x54 Byte(s)), array:0x15(hti:0xffff)
        int loadingscreen[21];
        // offset: 0x2020, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int vehicle_track[3];
        // offset: 0x2080, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int parachute[1];
        // offset: 0x20a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int battlepass[1];
        // offset: 0x20c0, bitSize: 0xe0(0x1c Byte(s)), array:0x7(hti:0xffff)
        int vehicle_camo[7];
        // offset: 0x21a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_horn[1];
        // offset: 0x21c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special[1];
        // offset: 0x21e0, bitSize: 0x3320(0x664 Byte(s)), array:0x199(hti:0xffff)
        int attachment[409];
        // offset: 0x5500, bitSize: 0x4a0(0x94 Byte(s)), array:0x25(hti:0xffff)
        int sticker[37];
        // offset: 0x59a0, bitSize: 0x9c0(0x138 Byte(s)), array:0x4e(hti:0xffff)
        int emblems[78];
        // offset: 0x6360, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int calloutmarkerpingitem[2];
        // offset: 0x63a0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int feature[2];
        // offset: 0x63e0, bitSize: 0x640(0xc8 Byte(s)), array:0x32(hti:0xffff)
        int weapon[50];
        // offset: 0x6a20, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int killstreak[2];
        // offset: 0x6a60, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int contrail[1];
        // offset: 0x6a80, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int operator[4];
        // offset: 0x6b00, bitSize: 0x5c0(0xb8 Byte(s)), array:0x2e(hti:0xffff)
        int consumable[46];
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

    // bitSize: 0x8, members: 8
    struct AttachmentStatsPreferences {
        // offset: 0x0, bitSize: 0x1
        bool handling;
        // offset: 0x1, bitSize: 0x1
        bool range;
        // offset: 0x2, bitSize: 0x1
        bool accuracy;
        // offset: 0x3, bitSize: 0x1
        bool damage;
        // offset: 0x4, bitSize: 0x1
        bool recoil;
        // offset: 0x5, bitSize: 0x1
        bool mobility;
        // offset: 0x6, bitSize: 0x1
        bool fire_rate;
    };

    // bitSize: 0x8, members: 3
    struct UnlockPreferences {
        // offset: 0x0, bitSize: 0x1
        bool locked;
        // offset: 0x1, bitSize: 0x1
        bool unlocked;
    };

    // bitSize: 0x18, members: 4
    struct AttachmentSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        AttachmentStatsPreferences attachmentStatsPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        UnlockPreferences unlockPreference;
        // offset: 0x10, bitSize: 0x1
        bool aftermarketParts;
    };

    // bitSize: 0x10, members: 2
    struct VehicleSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        CamoActiveFilter camoActiveFilter;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        TrackActiveFilter trackActiveFilter;
    };

    // bitSize: 0x80, members: 7
    struct PlayerSortPreferences {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        GesturesSortPreferences gesturesSortPreference;
        // offset: 0x10, bitSize: 0x18(0x3 Byte(s))
        EmblemSortPreferences emblemSortPreference;
        // offset: 0x28, bitSize: 0x10(0x2 Byte(s))
        StickersSortPreferences stickerSortPreference;
        // offset: 0x38, bitSize: 0x10(0x2 Byte(s))
        CharmsSortPreferences charmsSortPreference;
        // offset: 0x48, bitSize: 0x18(0x3 Byte(s))
        AttachmentSortPreferences attachmentSortPreference;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        VehicleSortPreferences vehicleSortPreference;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
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

    // bitSize: 0x170, members: 6
    struct SeasonalEventData {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) eventName;
        // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
        int preMatchChallengeProgress;
        // offset: 0x120, bitSize: 0x8(0x1 Byte(s))
        byte communityMilestonesUnlocksSeen;
        // offset: 0x128, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool seasonalChallengesUnlocksSeen[64];
        // offset: 0x168, bitSize: 0x1
        bool hasSeenOnboarding;
    };

    // bitSize: 0x95f8, members: 63
    struct NonGameData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkLow[4];
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        uint lastSeenSurveyVersion;
        // offset: 0xa0, bitSize: 0x70c0(0xe18 Byte(s))
        UnlockTable isNew;
        // offset: 0x7160, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_background[2];
        // offset: 0x7180, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveWhispers;
        // offset: 0x7188, bitSize: 0x40(0x8 Byte(s))
        uint64 toastNotificationUnpauseTimestamp;
        // offset: 0x71c8, bitSize: 0xb80(0x170 Byte(s)), array:0x8(hti:0xffff)
        SeasonalEventData seasonalEvents[8];
        // offset: 0x7d48, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkHigh[4];
        // offset: 0x7dc8, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedCategoryID;
        // offset: 0x7de8, bitSize: 0x8(0x1 Byte(s))
        byte quickplayFilter;
        // offset: 0x7df0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidLow[4];
        // offset: 0x7e70, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int tournamentQuits[4];
        // offset: 0x7ef0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveFriendRequests;
        // offset: 0x7ef8, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0xffff)
        uint:6 battlePassBreadCrumbs[23];
        // offset: 0x7fb0, bitSize: 0x8(0x1 Byte(s))
        PartyPrivacySetting partyPrivacySettings;
        // offset: 0x7fb8, bitSize: 0x20(0x4 Byte(s))
        int bigTournamentBanStart;
        // offset: 0x7fd8, bitSize: 0x20(0x4 Byte(s))
        uint mpMotdChecksum;
        // offset: 0x7ff8, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedPlaylistID;
        // offset: 0x8018, bitSize: 0x40(0x8 Byte(s))
        uint64 influencerCodeTime;
        // offset: 0x8058, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesLastSeenTime;
        // offset: 0x8078, bitSize: 0x20(0x4 Byte(s))
        uint brMotdChecksum;
        // offset: 0x8098, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesPopupChecksum;
        // offset: 0x80b8, bitSize: 0x258(0x4b Byte(s)), array:0x5(hti:0xffff)
        SocialPartySettings socialPartySettings[5];
        // offset: 0x8310, bitSize: 0x20(0x4 Byte(s))
        uint cpMotdChecksum;
        // offset: 0x8330, bitSize: 0x20(0x4 Byte(s))
        int tokensEarnedSinceLastBattlePassUpsell;
        // offset: 0x8350, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkHigh[4];
        // offset: 0x83d0, bitSize: 0x20(0x4 Byte(s))
        uint spUninstallPromptLastSeenTimestamp;
        // offset: 0x83f0, bitSize: 0x20(0x4 Byte(s))
        uint lastBattlePassMenuXp;
        // offset: 0x8410, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveChannelInvites;
        // offset: 0x8418, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkLow[4];
        // offset: 0x8498, bitSize: 0x20(0x4 Byte(s))
        uint lastRank;
        // offset: 0x84b8, bitSize: 0x10(0x2 Byte(s))
        DefaultPartySettings defaultPartySettings;
        // offset: 0x84c8, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveActivityInvites;
        // offset: 0x84d0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidHigh[4];
        // offset: 0x8550, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int maxPrivatePartySize[2];
        // offset: 0x8590, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_patch[2];
        // offset: 0x85b0, bitSize: 0x20(0x4 Byte(s))
        int lastSeenActiveArmoryIndex;
        // offset: 0x85d0, bitSize: 0xa80(0x150 Byte(s)), array:0x3(hti:0xffff)
        DeviceConnectionHistory deviceConnectionHistory[3];
        // offset: 0x9050, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveGroupInvites;
        // offset: 0x9058, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_frame[2];
        // offset: 0x9078, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_title[2];
        // offset: 0x9098, bitSize: 0x80(0x10 Byte(s))
        PlayerSortPreferences sortPreferences;
        // offset: 0x9118, bitSize: 0x200(0x40 Byte(s))
        string(64) savedUsername;
        // offset: 0x9318, bitSize: 0x200(0x40 Byte(s))
        string(64) influencerCode;
        // offset: 0x9518, bitSize: 0x8(0x1 Byte(s))
        byte lastBattlePassFreeTierSeen;
        // offset: 0x9520, bitSize: 0x20(0x4 Byte(s))
        uint storeLastSeenTime;
        // offset: 0x9540, bitSize: 0x8(0x1 Byte(s))
        byte battlePassPurchasePendingSeason;
        // offset: 0x9548, bitSize: 0x20(0x4 Byte(s))
        int currentTournament;
        // offset: 0x9568, bitSize: 0x60(0xc Byte(s))
        PlayerConnectionHistory playerConnectionHistory;
        // offset: 0x95c8, bitSize: 0x1
        bool toggleOfflineFriends;
        // offset: 0x95c9, bitSize: 0x1
        bool alreadySeenSettingsMenu;
        // offset: 0x95ca, bitSize: 0x1
        bool isBPOnboardingCleared;
        // offset: 0x95cb, bitSize: 0x1
        bool wereOperatorExecutionsValidated;
        // offset: 0x95cc, bitSize: 0x1
        bool cross_play_enabled;
        // offset: 0x95cd, bitSize: 0x1
        bool isShowProsAndConsEnabled;
        // offset: 0x95ce, bitSize: 0x1
        bool hasAnyTempBanActive;
        // offset: 0x95cf, bitSize: 0x1
        bool mobileShaderDlogStarted;
        // offset: 0x95d0, bitSize: 0x1
        bool muteOnJoinParty;
        // offset: 0x95d1, bitSize: 0x1
        bool party_autofill_lock;
        // offset: 0x95d2, bitSize: 0x1
        bool disableProximityVoice;
        // offset: 0x95d3, bitSize: 0x1
        bool wasProtuningPlayerDataConverted;
        // offset: 0x95d4, bitSize: 0x20(0x4 Byte(s)), array:0x20(hti:0xffff)
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

    // idx 0x2 members: 0x4 type: 0
    enum SocialPrivacySetting {
        everyone, // 0x0
        socially_connected, // 0x1
        friends_only, // 0x2
        no_one // 0x3
    };

    // idx 0x3 members: 0x3 type: 0
    enum RaritySortOptions {
        rarity_high_first, // 0x0
        rarity_low_first, // 0x1
        rarity_none // 0x2
    };

    // idx 0x4 members: 0x3 type: 0
    enum SeasonSortOptions {
        season_recent_first, // 0x0
        season_old_first, // 0x1
        season_none // 0x2
    };

    // idx 0x5 members: 0x2 type: 0
    enum OfficerProgressionSortOptions {
        officer_none, // 0x0
        officer_first // 0x1
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

    // root: bitSize: 0x9600, members: 2

    // offset: 0x0, bitSize: 0x95f8(0x12bf Byte(s))
    NonGameData nonGameData;
    // offset: 0x95f8, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 23 (0x17)
    // bit size .. 40496 (0x9e30)
    // byte size . 5062 (0x13c6)
    // archive ... hash_cff5b26e6bb660b5

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x7240, members: 31
    struct UnlockTable {
        // offset: 0x0, bitSize: 0x7a0(0xf4 Byte(s)), array:0x3d(hti:0xffff)
        int camo[61];
        // offset: 0x7a0, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int perk[6];
        // offset: 0x860, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int temp[1];
        // offset: 0x880, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int super[2];
        // offset: 0x8c0, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int firstpartylicense[5];
        // offset: 0x960, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int gun_screen[5];
        // offset: 0xa00, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int executions[6];
        // offset: 0xac0, bitSize: 0xa40(0x148 Byte(s)), array:0x52(hti:0xffff)
        int playercards[82];
        // offset: 0x1500, bitSize: 0x460(0x8c Byte(s)), array:0x23(hti:0xffff)
        int weapon_charm[35];
        // offset: 0x1960, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int currencypack[1];
        // offset: 0x1980, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int mission[1];
        // offset: 0x19a0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int equipment[3];
        // offset: 0x1a00, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int reticle[3];
        // offset: 0x1a60, bitSize: 0x2a0(0x54 Byte(s)), array:0x15(hti:0xffff)
        int operator_skin[21];
        // offset: 0x1d00, bitSize: 0x2a0(0x54 Byte(s)), array:0x15(hti:0xffff)
        int loadingscreen[21];
        // offset: 0x1fa0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int vehicle_track[3];
        // offset: 0x2000, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int parachute[1];
        // offset: 0x2020, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int battlepass[1];
        // offset: 0x2040, bitSize: 0x100(0x20 Byte(s)), array:0x8(hti:0xffff)
        int vehicle_camo[8];
        // offset: 0x2140, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_horn[1];
        // offset: 0x2160, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special[1];
        // offset: 0x2180, bitSize: 0x34c0(0x698 Byte(s)), array:0x1a6(hti:0xffff)
        int attachment[422];
        // offset: 0x5640, bitSize: 0x4c0(0x98 Byte(s)), array:0x26(hti:0xffff)
        int sticker[38];
        // offset: 0x5b00, bitSize: 0x9c0(0x138 Byte(s)), array:0x4e(hti:0xffff)
        int emblems[78];
        // offset: 0x64c0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int calloutmarkerpingitem[2];
        // offset: 0x6500, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int feature[2];
        // offset: 0x6540, bitSize: 0x660(0xcc Byte(s)), array:0x33(hti:0xffff)
        int weapon[51];
        // offset: 0x6ba0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int killstreak[2];
        // offset: 0x6be0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int contrail[1];
        // offset: 0x6c00, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int operator[4];
        // offset: 0x6c80, bitSize: 0x5c0(0xb8 Byte(s)), array:0x2e(hti:0xffff)
        int consumable[46];
    };

    // bitSize: 0x18, members: 4
    struct FTUEVideo {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short version;
        // offset: 0x10, bitSize: 0x1
        bool isComplete;
        // offset: 0x11, bitSize: 0x1
        bool isViewed;
    };

    // bitSize: 0x600, members: 1
    struct TelescopeData {
        // offset: 0x0, bitSize: 0x600(0xc0 Byte(s)), array:0x40(hti:0xffff)
        FTUEVideo ftueVideo[64];
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

    // bitSize: 0x8, members: 8
    struct AttachmentStatsPreferences {
        // offset: 0x0, bitSize: 0x1
        bool handling;
        // offset: 0x1, bitSize: 0x1
        bool range;
        // offset: 0x2, bitSize: 0x1
        bool accuracy;
        // offset: 0x3, bitSize: 0x1
        bool damage;
        // offset: 0x4, bitSize: 0x1
        bool recoil;
        // offset: 0x5, bitSize: 0x1
        bool mobility;
        // offset: 0x6, bitSize: 0x1
        bool fire_rate;
    };

    // bitSize: 0x8, members: 3
    struct UnlockPreferences {
        // offset: 0x0, bitSize: 0x1
        bool locked;
        // offset: 0x1, bitSize: 0x1
        bool unlocked;
    };

    // bitSize: 0x18, members: 4
    struct AttachmentSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        AttachmentStatsPreferences attachmentStatsPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        UnlockPreferences unlockPreference;
        // offset: 0x10, bitSize: 0x1
        bool aftermarketParts;
    };

    // bitSize: 0x10, members: 2
    struct VehicleSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        CamoActiveFilter camoActiveFilter;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        TrackActiveFilter trackActiveFilter;
    };

    // bitSize: 0x80, members: 7
    struct PlayerSortPreferences {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        GesturesSortPreferences gesturesSortPreference;
        // offset: 0x10, bitSize: 0x18(0x3 Byte(s))
        EmblemSortPreferences emblemSortPreference;
        // offset: 0x28, bitSize: 0x10(0x2 Byte(s))
        StickersSortPreferences stickerSortPreference;
        // offset: 0x38, bitSize: 0x10(0x2 Byte(s))
        CharmsSortPreferences charmsSortPreference;
        // offset: 0x48, bitSize: 0x18(0x3 Byte(s))
        AttachmentSortPreferences attachmentSortPreference;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        VehicleSortPreferences vehicleSortPreference;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
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

    // bitSize: 0x170, members: 6
    struct SeasonalEventData {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) eventName;
        // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
        int preMatchChallengeProgress;
        // offset: 0x120, bitSize: 0x8(0x1 Byte(s))
        byte communityMilestonesUnlocksSeen;
        // offset: 0x128, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool seasonalChallengesUnlocksSeen[64];
        // offset: 0x168, bitSize: 0x1
        bool hasSeenOnboarding;
    };

    // bitSize: 0x9d78, members: 64
    struct NonGameData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkLow[4];
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        uint lastSeenSurveyVersion;
        // offset: 0xa0, bitSize: 0x7240(0xe48 Byte(s))
        UnlockTable isNew;
        // offset: 0x72e0, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_background[2];
        // offset: 0x7300, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveWhispers;
        // offset: 0x7308, bitSize: 0x40(0x8 Byte(s))
        uint64 toastNotificationUnpauseTimestamp;
        // offset: 0x7348, bitSize: 0xb80(0x170 Byte(s)), array:0x8(hti:0xffff)
        SeasonalEventData seasonalEvents[8];
        // offset: 0x7ec8, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkHigh[4];
        // offset: 0x7f48, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedCategoryID;
        // offset: 0x7f68, bitSize: 0x8(0x1 Byte(s))
        byte quickplayFilter;
        // offset: 0x7f70, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidLow[4];
        // offset: 0x7ff0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int tournamentQuits[4];
        // offset: 0x8070, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveFriendRequests;
        // offset: 0x8078, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0xffff)
        uint:6 battlePassBreadCrumbs[23];
        // offset: 0x8130, bitSize: 0x8(0x1 Byte(s))
        PartyPrivacySetting partyPrivacySettings;
        // offset: 0x8138, bitSize: 0x20(0x4 Byte(s))
        int bigTournamentBanStart;
        // offset: 0x8158, bitSize: 0x20(0x4 Byte(s))
        uint mpMotdChecksum;
        // offset: 0x8178, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedPlaylistID;
        // offset: 0x8198, bitSize: 0x40(0x8 Byte(s))
        uint64 influencerCodeTime;
        // offset: 0x81d8, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesLastSeenTime;
        // offset: 0x81f8, bitSize: 0x20(0x4 Byte(s))
        uint brMotdChecksum;
        // offset: 0x8218, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesPopupChecksum;
        // offset: 0x8238, bitSize: 0x258(0x4b Byte(s)), array:0x5(hti:0xffff)
        SocialPartySettings socialPartySettings[5];
        // offset: 0x8490, bitSize: 0x20(0x4 Byte(s))
        uint cpMotdChecksum;
        // offset: 0x84b0, bitSize: 0x20(0x4 Byte(s))
        int tokensEarnedSinceLastBattlePassUpsell;
        // offset: 0x84d0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkHigh[4];
        // offset: 0x8550, bitSize: 0x20(0x4 Byte(s))
        uint spUninstallPromptLastSeenTimestamp;
        // offset: 0x8570, bitSize: 0x20(0x4 Byte(s))
        uint lastBattlePassMenuXp;
        // offset: 0x8590, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveChannelInvites;
        // offset: 0x8598, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkLow[4];
        // offset: 0x8618, bitSize: 0x20(0x4 Byte(s))
        uint lastRank;
        // offset: 0x8638, bitSize: 0x10(0x2 Byte(s))
        DefaultPartySettings defaultPartySettings;
        // offset: 0x8648, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveActivityInvites;
        // offset: 0x8650, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidHigh[4];
        // offset: 0x86d0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int maxPrivatePartySize[2];
        // offset: 0x8710, bitSize: 0x600(0xc0 Byte(s))
        TelescopeData telescopeData;
        // offset: 0x8d10, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_patch[2];
        // offset: 0x8d30, bitSize: 0x20(0x4 Byte(s))
        int lastSeenActiveArmoryIndex;
        // offset: 0x8d50, bitSize: 0xa80(0x150 Byte(s)), array:0x3(hti:0xffff)
        DeviceConnectionHistory deviceConnectionHistory[3];
        // offset: 0x97d0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveGroupInvites;
        // offset: 0x97d8, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_frame[2];
        // offset: 0x97f8, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_title[2];
        // offset: 0x9818, bitSize: 0x80(0x10 Byte(s))
        PlayerSortPreferences sortPreferences;
        // offset: 0x9898, bitSize: 0x200(0x40 Byte(s))
        string(64) savedUsername;
        // offset: 0x9a98, bitSize: 0x200(0x40 Byte(s))
        string(64) influencerCode;
        // offset: 0x9c98, bitSize: 0x8(0x1 Byte(s))
        byte lastBattlePassFreeTierSeen;
        // offset: 0x9ca0, bitSize: 0x20(0x4 Byte(s))
        uint storeLastSeenTime;
        // offset: 0x9cc0, bitSize: 0x8(0x1 Byte(s))
        byte battlePassPurchasePendingSeason;
        // offset: 0x9cc8, bitSize: 0x20(0x4 Byte(s))
        int currentTournament;
        // offset: 0x9ce8, bitSize: 0x60(0xc Byte(s))
        PlayerConnectionHistory playerConnectionHistory;
        // offset: 0x9d48, bitSize: 0x1
        bool toggleOfflineFriends;
        // offset: 0x9d49, bitSize: 0x1
        bool alreadySeenSettingsMenu;
        // offset: 0x9d4a, bitSize: 0x1
        bool isBPOnboardingCleared;
        // offset: 0x9d4b, bitSize: 0x1
        bool wereOperatorExecutionsValidated;
        // offset: 0x9d4c, bitSize: 0x1
        bool cross_play_enabled;
        // offset: 0x9d4d, bitSize: 0x1
        bool isShowProsAndConsEnabled;
        // offset: 0x9d4e, bitSize: 0x1
        bool hasAnyTempBanActive;
        // offset: 0x9d4f, bitSize: 0x1
        bool mobileShaderDlogStarted;
        // offset: 0x9d50, bitSize: 0x1
        bool muteOnJoinParty;
        // offset: 0x9d51, bitSize: 0x1
        bool party_autofill_lock;
        // offset: 0x9d52, bitSize: 0x1
        bool disableProximityVoice;
        // offset: 0x9d53, bitSize: 0x1
        bool wasProtuningPlayerDataConverted;
        // offset: 0x9d54, bitSize: 0x20(0x4 Byte(s)), array:0x20(hti:0xffff)
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

    // idx 0x2 members: 0x4 type: 0
    enum SocialPrivacySetting {
        everyone, // 0x0
        socially_connected, // 0x1
        friends_only, // 0x2
        no_one // 0x3
    };

    // idx 0x3 members: 0x3 type: 0
    enum RaritySortOptions {
        rarity_high_first, // 0x0
        rarity_low_first, // 0x1
        rarity_none // 0x2
    };

    // idx 0x4 members: 0x3 type: 0
    enum SeasonSortOptions {
        season_recent_first, // 0x0
        season_old_first, // 0x1
        season_none // 0x2
    };

    // idx 0x5 members: 0x2 type: 0
    enum OfficerProgressionSortOptions {
        officer_none, // 0x0
        officer_first // 0x1
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

    // root: bitSize: 0x9d80, members: 2

    // offset: 0x0, bitSize: 0x9d78(0x13af Byte(s))
    NonGameData nonGameData;
    // offset: 0x9d78, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 23 (0x17)
    // bit size .. 40560 (0x9e70)
    // byte size . 5070 (0x13ce)
    // archive ... hash_23393eec8e444dc8

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x7280, members: 31
    struct UnlockTable {
        // offset: 0x0, bitSize: 0x7a0(0xf4 Byte(s)), array:0x3d(hti:0xffff)
        int camo[61];
        // offset: 0x7a0, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int perk[6];
        // offset: 0x860, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int temp[1];
        // offset: 0x880, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int super[2];
        // offset: 0x8c0, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int firstpartylicense[5];
        // offset: 0x960, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int gun_screen[5];
        // offset: 0xa00, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int executions[6];
        // offset: 0xac0, bitSize: 0xa40(0x148 Byte(s)), array:0x52(hti:0xffff)
        int playercards[82];
        // offset: 0x1500, bitSize: 0x460(0x8c Byte(s)), array:0x23(hti:0xffff)
        int weapon_charm[35];
        // offset: 0x1960, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int currencypack[1];
        // offset: 0x1980, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int mission[1];
        // offset: 0x19a0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int equipment[3];
        // offset: 0x1a00, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int reticle[3];
        // offset: 0x1a60, bitSize: 0x2a0(0x54 Byte(s)), array:0x15(hti:0xffff)
        int operator_skin[21];
        // offset: 0x1d00, bitSize: 0x2a0(0x54 Byte(s)), array:0x15(hti:0xffff)
        int loadingscreen[21];
        // offset: 0x1fa0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int vehicle_track[3];
        // offset: 0x2000, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int parachute[1];
        // offset: 0x2020, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int battlepass[1];
        // offset: 0x2040, bitSize: 0x100(0x20 Byte(s)), array:0x8(hti:0xffff)
        int vehicle_camo[8];
        // offset: 0x2140, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_horn[1];
        // offset: 0x2160, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special[1];
        // offset: 0x2180, bitSize: 0x3500(0x6a0 Byte(s)), array:0x1a8(hti:0xffff)
        int attachment[424];
        // offset: 0x5680, bitSize: 0x4c0(0x98 Byte(s)), array:0x26(hti:0xffff)
        int sticker[38];
        // offset: 0x5b40, bitSize: 0x9c0(0x138 Byte(s)), array:0x4e(hti:0xffff)
        int emblems[78];
        // offset: 0x6500, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int calloutmarkerpingitem[2];
        // offset: 0x6540, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int feature[2];
        // offset: 0x6580, bitSize: 0x660(0xcc Byte(s)), array:0x33(hti:0xffff)
        int weapon[51];
        // offset: 0x6be0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int killstreak[2];
        // offset: 0x6c20, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int contrail[1];
        // offset: 0x6c40, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int operator[4];
        // offset: 0x6cc0, bitSize: 0x5c0(0xb8 Byte(s)), array:0x2e(hti:0xffff)
        int consumable[46];
    };

    // bitSize: 0x18, members: 4
    struct FTUEVideo {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short version;
        // offset: 0x10, bitSize: 0x1
        bool isComplete;
        // offset: 0x11, bitSize: 0x1
        bool isViewed;
    };

    // bitSize: 0x600, members: 1
    struct TelescopeData {
        // offset: 0x0, bitSize: 0x600(0xc0 Byte(s)), array:0x40(hti:0xffff)
        FTUEVideo ftueVideo[64];
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

    // bitSize: 0x8, members: 8
    struct AttachmentStatsPreferences {
        // offset: 0x0, bitSize: 0x1
        bool handling;
        // offset: 0x1, bitSize: 0x1
        bool range;
        // offset: 0x2, bitSize: 0x1
        bool accuracy;
        // offset: 0x3, bitSize: 0x1
        bool damage;
        // offset: 0x4, bitSize: 0x1
        bool recoil;
        // offset: 0x5, bitSize: 0x1
        bool mobility;
        // offset: 0x6, bitSize: 0x1
        bool fire_rate;
    };

    // bitSize: 0x8, members: 3
    struct UnlockPreferences {
        // offset: 0x0, bitSize: 0x1
        bool locked;
        // offset: 0x1, bitSize: 0x1
        bool unlocked;
    };

    // bitSize: 0x18, members: 4
    struct AttachmentSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        AttachmentStatsPreferences attachmentStatsPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        UnlockPreferences unlockPreference;
        // offset: 0x10, bitSize: 0x1
        bool aftermarketParts;
    };

    // bitSize: 0x10, members: 2
    struct VehicleSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        CamoActiveFilter camoActiveFilter;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        TrackActiveFilter trackActiveFilter;
    };

    // bitSize: 0x80, members: 7
    struct PlayerSortPreferences {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        GesturesSortPreferences gesturesSortPreference;
        // offset: 0x10, bitSize: 0x18(0x3 Byte(s))
        EmblemSortPreferences emblemSortPreference;
        // offset: 0x28, bitSize: 0x10(0x2 Byte(s))
        StickersSortPreferences stickerSortPreference;
        // offset: 0x38, bitSize: 0x10(0x2 Byte(s))
        CharmsSortPreferences charmsSortPreference;
        // offset: 0x48, bitSize: 0x18(0x3 Byte(s))
        AttachmentSortPreferences attachmentSortPreference;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        VehicleSortPreferences vehicleSortPreference;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
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

    // bitSize: 0x170, members: 6
    struct SeasonalEventData {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) eventName;
        // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
        int preMatchChallengeProgress;
        // offset: 0x120, bitSize: 0x8(0x1 Byte(s))
        byte communityMilestonesUnlocksSeen;
        // offset: 0x128, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool seasonalChallengesUnlocksSeen[64];
        // offset: 0x168, bitSize: 0x1
        bool hasSeenOnboarding;
    };

    // bitSize: 0x9db8, members: 64
    struct NonGameData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkLow[4];
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        uint lastSeenSurveyVersion;
        // offset: 0xa0, bitSize: 0x7280(0xe50 Byte(s))
        UnlockTable isNew;
        // offset: 0x7320, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_background[2];
        // offset: 0x7340, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveWhispers;
        // offset: 0x7348, bitSize: 0x40(0x8 Byte(s))
        uint64 toastNotificationUnpauseTimestamp;
        // offset: 0x7388, bitSize: 0xb80(0x170 Byte(s)), array:0x8(hti:0xffff)
        SeasonalEventData seasonalEvents[8];
        // offset: 0x7f08, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkHigh[4];
        // offset: 0x7f88, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedCategoryID;
        // offset: 0x7fa8, bitSize: 0x8(0x1 Byte(s))
        byte quickplayFilter;
        // offset: 0x7fb0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidLow[4];
        // offset: 0x8030, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int tournamentQuits[4];
        // offset: 0x80b0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveFriendRequests;
        // offset: 0x80b8, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0xffff)
        uint:6 battlePassBreadCrumbs[23];
        // offset: 0x8170, bitSize: 0x8(0x1 Byte(s))
        PartyPrivacySetting partyPrivacySettings;
        // offset: 0x8178, bitSize: 0x20(0x4 Byte(s))
        int bigTournamentBanStart;
        // offset: 0x8198, bitSize: 0x20(0x4 Byte(s))
        uint mpMotdChecksum;
        // offset: 0x81b8, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedPlaylistID;
        // offset: 0x81d8, bitSize: 0x40(0x8 Byte(s))
        uint64 influencerCodeTime;
        // offset: 0x8218, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesLastSeenTime;
        // offset: 0x8238, bitSize: 0x20(0x4 Byte(s))
        uint brMotdChecksum;
        // offset: 0x8258, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesPopupChecksum;
        // offset: 0x8278, bitSize: 0x258(0x4b Byte(s)), array:0x5(hti:0xffff)
        SocialPartySettings socialPartySettings[5];
        // offset: 0x84d0, bitSize: 0x20(0x4 Byte(s))
        uint cpMotdChecksum;
        // offset: 0x84f0, bitSize: 0x20(0x4 Byte(s))
        int tokensEarnedSinceLastBattlePassUpsell;
        // offset: 0x8510, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkHigh[4];
        // offset: 0x8590, bitSize: 0x20(0x4 Byte(s))
        uint spUninstallPromptLastSeenTimestamp;
        // offset: 0x85b0, bitSize: 0x20(0x4 Byte(s))
        uint lastBattlePassMenuXp;
        // offset: 0x85d0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveChannelInvites;
        // offset: 0x85d8, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkLow[4];
        // offset: 0x8658, bitSize: 0x20(0x4 Byte(s))
        uint lastRank;
        // offset: 0x8678, bitSize: 0x10(0x2 Byte(s))
        DefaultPartySettings defaultPartySettings;
        // offset: 0x8688, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveActivityInvites;
        // offset: 0x8690, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidHigh[4];
        // offset: 0x8710, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int maxPrivatePartySize[2];
        // offset: 0x8750, bitSize: 0x600(0xc0 Byte(s))
        TelescopeData telescopeData;
        // offset: 0x8d50, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_patch[2];
        // offset: 0x8d70, bitSize: 0x20(0x4 Byte(s))
        int lastSeenActiveArmoryIndex;
        // offset: 0x8d90, bitSize: 0xa80(0x150 Byte(s)), array:0x3(hti:0xffff)
        DeviceConnectionHistory deviceConnectionHistory[3];
        // offset: 0x9810, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveGroupInvites;
        // offset: 0x9818, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_frame[2];
        // offset: 0x9838, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_title[2];
        // offset: 0x9858, bitSize: 0x80(0x10 Byte(s))
        PlayerSortPreferences sortPreferences;
        // offset: 0x98d8, bitSize: 0x200(0x40 Byte(s))
        string(64) savedUsername;
        // offset: 0x9ad8, bitSize: 0x200(0x40 Byte(s))
        string(64) influencerCode;
        // offset: 0x9cd8, bitSize: 0x8(0x1 Byte(s))
        byte lastBattlePassFreeTierSeen;
        // offset: 0x9ce0, bitSize: 0x20(0x4 Byte(s))
        uint storeLastSeenTime;
        // offset: 0x9d00, bitSize: 0x8(0x1 Byte(s))
        byte battlePassPurchasePendingSeason;
        // offset: 0x9d08, bitSize: 0x20(0x4 Byte(s))
        int currentTournament;
        // offset: 0x9d28, bitSize: 0x60(0xc Byte(s))
        PlayerConnectionHistory playerConnectionHistory;
        // offset: 0x9d88, bitSize: 0x1
        bool toggleOfflineFriends;
        // offset: 0x9d89, bitSize: 0x1
        bool alreadySeenSettingsMenu;
        // offset: 0x9d8a, bitSize: 0x1
        bool isBPOnboardingCleared;
        // offset: 0x9d8b, bitSize: 0x1
        bool wereOperatorExecutionsValidated;
        // offset: 0x9d8c, bitSize: 0x1
        bool cross_play_enabled;
        // offset: 0x9d8d, bitSize: 0x1
        bool isShowProsAndConsEnabled;
        // offset: 0x9d8e, bitSize: 0x1
        bool hasAnyTempBanActive;
        // offset: 0x9d8f, bitSize: 0x1
        bool mobileShaderDlogStarted;
        // offset: 0x9d90, bitSize: 0x1
        bool muteOnJoinParty;
        // offset: 0x9d91, bitSize: 0x1
        bool party_autofill_lock;
        // offset: 0x9d92, bitSize: 0x1
        bool disableProximityVoice;
        // offset: 0x9d93, bitSize: 0x1
        bool wasProtuningPlayerDataConverted;
        // offset: 0x9d94, bitSize: 0x20(0x4 Byte(s)), array:0x20(hti:0xffff)
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

    // idx 0x2 members: 0x4 type: 0
    enum SocialPrivacySetting {
        everyone, // 0x0
        socially_connected, // 0x1
        friends_only, // 0x2
        no_one // 0x3
    };

    // idx 0x3 members: 0x3 type: 0
    enum RaritySortOptions {
        rarity_high_first, // 0x0
        rarity_low_first, // 0x1
        rarity_none // 0x2
    };

    // idx 0x4 members: 0x3 type: 0
    enum SeasonSortOptions {
        season_recent_first, // 0x0
        season_old_first, // 0x1
        season_none // 0x2
    };

    // idx 0x5 members: 0x2 type: 0
    enum OfficerProgressionSortOptions {
        officer_none, // 0x0
        officer_first // 0x1
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

    // root: bitSize: 0x9dc0, members: 2

    // offset: 0x0, bitSize: 0x9db8(0x13b7 Byte(s))
    NonGameData nonGameData;
    // offset: 0x9db8, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 23 (0x17)
    // bit size .. 40592 (0x9e90)
    // byte size . 5074 (0x13d2)
    // archive ... hash_a15457c2ff7f10c

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x72a0, members: 31
    struct UnlockTable {
        // offset: 0x0, bitSize: 0x7a0(0xf4 Byte(s)), array:0x3d(hti:0xffff)
        int camo[61];
        // offset: 0x7a0, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int perk[6];
        // offset: 0x860, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int temp[1];
        // offset: 0x880, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int super[2];
        // offset: 0x8c0, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int firstpartylicense[5];
        // offset: 0x960, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int gun_screen[5];
        // offset: 0xa00, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int executions[6];
        // offset: 0xac0, bitSize: 0xa60(0x14c Byte(s)), array:0x53(hti:0xffff)
        int playercards[83];
        // offset: 0x1520, bitSize: 0x460(0x8c Byte(s)), array:0x23(hti:0xffff)
        int weapon_charm[35];
        // offset: 0x1980, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int currencypack[1];
        // offset: 0x19a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int mission[1];
        // offset: 0x19c0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int equipment[3];
        // offset: 0x1a20, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int reticle[3];
        // offset: 0x1a80, bitSize: 0x2a0(0x54 Byte(s)), array:0x15(hti:0xffff)
        int operator_skin[21];
        // offset: 0x1d20, bitSize: 0x2a0(0x54 Byte(s)), array:0x15(hti:0xffff)
        int loadingscreen[21];
        // offset: 0x1fc0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int vehicle_track[3];
        // offset: 0x2020, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int parachute[1];
        // offset: 0x2040, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int battlepass[1];
        // offset: 0x2060, bitSize: 0x100(0x20 Byte(s)), array:0x8(hti:0xffff)
        int vehicle_camo[8];
        // offset: 0x2160, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_horn[1];
        // offset: 0x2180, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special[1];
        // offset: 0x21a0, bitSize: 0x3500(0x6a0 Byte(s)), array:0x1a8(hti:0xffff)
        int attachment[424];
        // offset: 0x56a0, bitSize: 0x4c0(0x98 Byte(s)), array:0x26(hti:0xffff)
        int sticker[38];
        // offset: 0x5b60, bitSize: 0x9c0(0x138 Byte(s)), array:0x4e(hti:0xffff)
        int emblems[78];
        // offset: 0x6520, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int calloutmarkerpingitem[2];
        // offset: 0x6560, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int feature[2];
        // offset: 0x65a0, bitSize: 0x660(0xcc Byte(s)), array:0x33(hti:0xffff)
        int weapon[51];
        // offset: 0x6c00, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int killstreak[2];
        // offset: 0x6c40, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int contrail[1];
        // offset: 0x6c60, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int operator[4];
        // offset: 0x6ce0, bitSize: 0x5c0(0xb8 Byte(s)), array:0x2e(hti:0xffff)
        int consumable[46];
    };

    // bitSize: 0x18, members: 4
    struct FTUEVideo {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short version;
        // offset: 0x10, bitSize: 0x1
        bool isComplete;
        // offset: 0x11, bitSize: 0x1
        bool isViewed;
    };

    // bitSize: 0x600, members: 1
    struct TelescopeData {
        // offset: 0x0, bitSize: 0x600(0xc0 Byte(s)), array:0x40(hti:0xffff)
        FTUEVideo ftueVideo[64];
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

    // bitSize: 0x8, members: 8
    struct AttachmentStatsPreferences {
        // offset: 0x0, bitSize: 0x1
        bool handling;
        // offset: 0x1, bitSize: 0x1
        bool range;
        // offset: 0x2, bitSize: 0x1
        bool accuracy;
        // offset: 0x3, bitSize: 0x1
        bool damage;
        // offset: 0x4, bitSize: 0x1
        bool recoil;
        // offset: 0x5, bitSize: 0x1
        bool mobility;
        // offset: 0x6, bitSize: 0x1
        bool fire_rate;
    };

    // bitSize: 0x8, members: 3
    struct UnlockPreferences {
        // offset: 0x0, bitSize: 0x1
        bool locked;
        // offset: 0x1, bitSize: 0x1
        bool unlocked;
    };

    // bitSize: 0x18, members: 4
    struct AttachmentSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        AttachmentStatsPreferences attachmentStatsPreference;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        UnlockPreferences unlockPreference;
        // offset: 0x10, bitSize: 0x1
        bool aftermarketParts;
    };

    // bitSize: 0x10, members: 2
    struct VehicleSortPreferences {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        CamoActiveFilter camoActiveFilter;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        TrackActiveFilter trackActiveFilter;
    };

    // bitSize: 0x80, members: 7
    struct PlayerSortPreferences {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        GesturesSortPreferences gesturesSortPreference;
        // offset: 0x10, bitSize: 0x18(0x3 Byte(s))
        EmblemSortPreferences emblemSortPreference;
        // offset: 0x28, bitSize: 0x10(0x2 Byte(s))
        StickersSortPreferences stickerSortPreference;
        // offset: 0x38, bitSize: 0x10(0x2 Byte(s))
        CharmsSortPreferences charmsSortPreference;
        // offset: 0x48, bitSize: 0x18(0x3 Byte(s))
        AttachmentSortPreferences attachmentSortPreference;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        VehicleSortPreferences vehicleSortPreference;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
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

    // bitSize: 0x170, members: 6
    struct SeasonalEventData {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) eventName;
        // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
        int preMatchChallengeProgress;
        // offset: 0x120, bitSize: 0x8(0x1 Byte(s))
        byte communityMilestonesUnlocksSeen;
        // offset: 0x128, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool seasonalChallengesUnlocksSeen[64];
        // offset: 0x168, bitSize: 0x1
        bool hasSeenOnboarding;
    };

    // bitSize: 0x9dd8, members: 64
    struct NonGameData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkLow[4];
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        uint lastSeenSurveyVersion;
        // offset: 0xa0, bitSize: 0x72a0(0xe54 Byte(s))
        UnlockTable isNew;
        // offset: 0x7340, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_background[2];
        // offset: 0x7360, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveWhispers;
        // offset: 0x7368, bitSize: 0x40(0x8 Byte(s))
        uint64 toastNotificationUnpauseTimestamp;
        // offset: 0x73a8, bitSize: 0xb80(0x170 Byte(s)), array:0x8(hti:0xffff)
        SeasonalEventData seasonalEvents[8];
        // offset: 0x7f28, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkHigh[4];
        // offset: 0x7fa8, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedCategoryID;
        // offset: 0x7fc8, bitSize: 0x8(0x1 Byte(s))
        byte quickplayFilter;
        // offset: 0x7fd0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidLow[4];
        // offset: 0x8050, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int tournamentQuits[4];
        // offset: 0x80d0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveFriendRequests;
        // offset: 0x80d8, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0xffff)
        uint:6 battlePassBreadCrumbs[23];
        // offset: 0x8190, bitSize: 0x8(0x1 Byte(s))
        PartyPrivacySetting partyPrivacySettings;
        // offset: 0x8198, bitSize: 0x20(0x4 Byte(s))
        int bigTournamentBanStart;
        // offset: 0x81b8, bitSize: 0x20(0x4 Byte(s))
        uint mpMotdChecksum;
        // offset: 0x81d8, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedPlaylistID;
        // offset: 0x81f8, bitSize: 0x40(0x8 Byte(s))
        uint64 influencerCodeTime;
        // offset: 0x8238, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesLastSeenTime;
        // offset: 0x8258, bitSize: 0x20(0x4 Byte(s))
        uint brMotdChecksum;
        // offset: 0x8278, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesPopupChecksum;
        // offset: 0x8298, bitSize: 0x258(0x4b Byte(s)), array:0x5(hti:0xffff)
        SocialPartySettings socialPartySettings[5];
        // offset: 0x84f0, bitSize: 0x20(0x4 Byte(s))
        uint cpMotdChecksum;
        // offset: 0x8510, bitSize: 0x20(0x4 Byte(s))
        int tokensEarnedSinceLastBattlePassUpsell;
        // offset: 0x8530, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkHigh[4];
        // offset: 0x85b0, bitSize: 0x20(0x4 Byte(s))
        uint spUninstallPromptLastSeenTimestamp;
        // offset: 0x85d0, bitSize: 0x20(0x4 Byte(s))
        uint lastBattlePassMenuXp;
        // offset: 0x85f0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveChannelInvites;
        // offset: 0x85f8, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkLow[4];
        // offset: 0x8678, bitSize: 0x20(0x4 Byte(s))
        uint lastRank;
        // offset: 0x8698, bitSize: 0x10(0x2 Byte(s))
        DefaultPartySettings defaultPartySettings;
        // offset: 0x86a8, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveActivityInvites;
        // offset: 0x86b0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidHigh[4];
        // offset: 0x8730, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int maxPrivatePartySize[2];
        // offset: 0x8770, bitSize: 0x600(0xc0 Byte(s))
        TelescopeData telescopeData;
        // offset: 0x8d70, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_patch[2];
        // offset: 0x8d90, bitSize: 0x20(0x4 Byte(s))
        int lastSeenActiveArmoryIndex;
        // offset: 0x8db0, bitSize: 0xa80(0x150 Byte(s)), array:0x3(hti:0xffff)
        DeviceConnectionHistory deviceConnectionHistory[3];
        // offset: 0x9830, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveGroupInvites;
        // offset: 0x9838, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_frame[2];
        // offset: 0x9858, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_title[2];
        // offset: 0x9878, bitSize: 0x80(0x10 Byte(s))
        PlayerSortPreferences sortPreferences;
        // offset: 0x98f8, bitSize: 0x200(0x40 Byte(s))
        string(64) savedUsername;
        // offset: 0x9af8, bitSize: 0x200(0x40 Byte(s))
        string(64) influencerCode;
        // offset: 0x9cf8, bitSize: 0x8(0x1 Byte(s))
        byte lastBattlePassFreeTierSeen;
        // offset: 0x9d00, bitSize: 0x20(0x4 Byte(s))
        uint storeLastSeenTime;
        // offset: 0x9d20, bitSize: 0x8(0x1 Byte(s))
        byte battlePassPurchasePendingSeason;
        // offset: 0x9d28, bitSize: 0x20(0x4 Byte(s))
        int currentTournament;
        // offset: 0x9d48, bitSize: 0x60(0xc Byte(s))
        PlayerConnectionHistory playerConnectionHistory;
        // offset: 0x9da8, bitSize: 0x1
        bool toggleOfflineFriends;
        // offset: 0x9da9, bitSize: 0x1
        bool alreadySeenSettingsMenu;
        // offset: 0x9daa, bitSize: 0x1
        bool isBPOnboardingCleared;
        // offset: 0x9dab, bitSize: 0x1
        bool wereOperatorExecutionsValidated;
        // offset: 0x9dac, bitSize: 0x1
        bool cross_play_enabled;
        // offset: 0x9dad, bitSize: 0x1
        bool isShowProsAndConsEnabled;
        // offset: 0x9dae, bitSize: 0x1
        bool hasAnyTempBanActive;
        // offset: 0x9daf, bitSize: 0x1
        bool mobileShaderDlogStarted;
        // offset: 0x9db0, bitSize: 0x1
        bool muteOnJoinParty;
        // offset: 0x9db1, bitSize: 0x1
        bool party_autofill_lock;
        // offset: 0x9db2, bitSize: 0x1
        bool disableProximityVoice;
        // offset: 0x9db3, bitSize: 0x1
        bool wasProtuningPlayerDataConverted;
        // offset: 0x9db4, bitSize: 0x20(0x4 Byte(s)), array:0x20(hti:0xffff)
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

    // idx 0x2 members: 0x4 type: 0
    enum SocialPrivacySetting {
        everyone, // 0x0
        socially_connected, // 0x1
        friends_only, // 0x2
        no_one // 0x3
    };

    // idx 0x3 members: 0x3 type: 0
    enum RaritySortOptions {
        rarity_high_first, // 0x0
        rarity_low_first, // 0x1
        rarity_none // 0x2
    };

    // idx 0x4 members: 0x3 type: 0
    enum SeasonSortOptions {
        season_recent_first, // 0x0
        season_old_first, // 0x1
        season_none // 0x2
    };

    // idx 0x5 members: 0x2 type: 0
    enum OfficerProgressionSortOptions {
        officer_none, // 0x0
        officer_first // 0x1
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

    // root: bitSize: 0x9de0, members: 2

    // offset: 0x0, bitSize: 0x9dd8(0x13bb Byte(s))
    NonGameData nonGameData;
    // offset: 0x9dd8, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

