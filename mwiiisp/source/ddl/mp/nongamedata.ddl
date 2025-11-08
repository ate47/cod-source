// file .... ddl\mp\nongamedata.ddl

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 21 (0x15)
    // bit size .. 27680 (0x6c20)
    // byte size . 3460 (0xd84)
    // archive ... hash_3162b2acb6fdbb5e

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x50c0, members: 41
    struct UnlockTable {
        // offset: 0x0, bitSize: 0x280(0x50 Byte(s)), array:0x14(hti:0xffff)
        int camo[20];
        // offset: 0x280, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int perk[2];
        // offset: 0x2c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int role[1];
        // offset: 0x2e0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int temp[1];
        // offset: 0x300, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int intro[1];
        // offset: 0x320, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int super[2];
        // offset: 0x360, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special_weapon[1];
        // offset: 0x380, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int firstpartylicense[5];
        // offset: 0x420, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int gun_screen[5];
        // offset: 0x4c0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int executions[4];
        // offset: 0x540, bitSize: 0x660(0xcc Byte(s)), array:0x33(hti:0xffff)
        int playercards[51];
        // offset: 0xba0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int munition[1];
        // offset: 0xbc0, bitSize: 0x3a0(0x74 Byte(s)), array:0x1d(hti:0xffff)
        int weapon_charm[29];
        // offset: 0xf60, bitSize: 0x120(0x24 Byte(s)), array:0x9(hti:0xffff)
        int faction_progression[9];
        // offset: 0x1080, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int currencypack[1];
        // offset: 0x10a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int mission[1];
        // offset: 0x10c0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int equipment[3];
        // offset: 0x1120, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int reticle[3];
        // offset: 0x1180, bitSize: 0x1c0(0x38 Byte(s)), array:0xe(hti:0xffff)
        int operator_quip[14];
        // offset: 0x1340, bitSize: 0x160(0x2c Byte(s)), array:0xb(hti:0xffff)
        int operator_skin[11];
        // offset: 0x14a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int blackcell[1];
        // offset: 0x14c0, bitSize: 0x280(0x50 Byte(s)), array:0x14(hti:0xffff)
        int loadingscreen[20];
        // offset: 0x1740, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int vehicle_track[3];
        // offset: 0x17a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int parachute[1];
        // offset: 0x17c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int gestures[1];
        // offset: 0x17e0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int sp_reward[1];
        // offset: 0x1800, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int battlepass[1];
        // offset: 0x1820, bitSize: 0x100(0x20 Byte(s)), array:0x8(hti:0xffff)
        int vehicle_camo[8];
        // offset: 0x1920, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_horn[1];
        // offset: 0x1940, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special[1];
        // offset: 0x1960, bitSize: 0x20c0(0x418 Byte(s)), array:0x106(hti:0xffff)
        int attachment[262];
        // offset: 0x3a20, bitSize: 0x480(0x90 Byte(s)), array:0x24(hti:0xffff)
        int sticker[36];
        // offset: 0x3ea0, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int accolades[6];
        // offset: 0x3f60, bitSize: 0x6e0(0xdc Byte(s)), array:0x37(hti:0xffff)
        int emblems[55];
        // offset: 0x4640, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int calloutmarkerpingitem[1];
        // offset: 0x4660, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int feature[1];
        // offset: 0x4680, bitSize: 0x400(0x80 Byte(s)), array:0x20(hti:0xffff)
        int weapon[32];
        // offset: 0x4a80, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int killstreak[2];
        // offset: 0x4ac0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int contrail[1];
        // offset: 0x4ae0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int operator[2];
        // offset: 0x4b20, bitSize: 0x5a0(0xb4 Byte(s)), array:0x2d(hti:0xffff)
        int consumable[45];
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

    // bitSize: 0xd0, members: 5
    struct SeasonalEventData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s))
        string(16) eventName;
        // offset: 0x80, bitSize: 0x8(0x1 Byte(s))
        byte communityMilestonesUnlocksSeen;
        // offset: 0x88, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool seasonalChallengesUnlocksSeen[64];
        // offset: 0xc8, bitSize: 0x1
        bool hasSeenOnboarding;
    };

    // bitSize: 0x6b68, members: 63
    struct NonGameData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkLow[4];
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        uint lastSeenSurveyVersion;
        // offset: 0xa0, bitSize: 0x50c0(0xa18 Byte(s))
        UnlockTable isNew;
        // offset: 0x5160, bitSize: 0xd0(0x1a Byte(s))
        SeasonalEventData seasonalEvent;
        // offset: 0x5230, bitSize: 0x30(0x6 Byte(s)), array:0x2(hti:0xffff)
        uint:19 customization_background[2];
        // offset: 0x5260, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveWhispers;
        // offset: 0x5268, bitSize: 0x40(0x8 Byte(s))
        uint64 toastNotificationUnpauseTimestamp;
        // offset: 0x52a8, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkHigh[4];
        // offset: 0x5328, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedCategoryID;
        // offset: 0x5348, bitSize: 0x8(0x1 Byte(s))
        byte quickplayFilter;
        // offset: 0x5350, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidLow[4];
        // offset: 0x53d0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int tournamentQuits[4];
        // offset: 0x5450, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveFriendRequests;
        // offset: 0x5458, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0xffff)
        uint:6 battlePassBreadCrumbs[23];
        // offset: 0x5510, bitSize: 0x8(0x1 Byte(s))
        PartyPrivacySetting partyPrivacySettings;
        // offset: 0x5518, bitSize: 0x20(0x4 Byte(s))
        int bigTournamentBanStart;
        // offset: 0x5538, bitSize: 0x20(0x4 Byte(s))
        uint mpMotdChecksum;
        // offset: 0x5558, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedPlaylistID;
        // offset: 0x5578, bitSize: 0x40(0x8 Byte(s))
        uint64 influencerCodeTime;
        // offset: 0x55b8, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesLastSeenTime;
        // offset: 0x55d8, bitSize: 0x20(0x4 Byte(s))
        uint brMotdChecksum;
        // offset: 0x55f8, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesPopupChecksum;
        // offset: 0x5618, bitSize: 0x258(0x4b Byte(s)), array:0x5(hti:0xffff)
        SocialPartySettings socialPartySettings[5];
        // offset: 0x5870, bitSize: 0x20(0x4 Byte(s))
        uint cpMotdChecksum;
        // offset: 0x5890, bitSize: 0x20(0x4 Byte(s))
        int tokensEarnedSinceLastBattlePassUpsell;
        // offset: 0x58b0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkHigh[4];
        // offset: 0x5930, bitSize: 0x20(0x4 Byte(s))
        uint spUninstallPromptLastSeenTimestamp;
        // offset: 0x5950, bitSize: 0x20(0x4 Byte(s))
        uint lastBattlePassMenuXp;
        // offset: 0x5970, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveChannelInvites;
        // offset: 0x5978, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkLow[4];
        // offset: 0x59f8, bitSize: 0x20(0x4 Byte(s))
        uint lastRank;
        // offset: 0x5a18, bitSize: 0x10(0x2 Byte(s))
        DefaultPartySettings defaultPartySettings;
        // offset: 0x5a28, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveActivityInvites;
        // offset: 0x5a30, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidHigh[4];
        // offset: 0x5ab0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int maxPrivatePartySize[2];
        // offset: 0x5af0, bitSize: 0x30(0x6 Byte(s)), array:0x2(hti:0xffff)
        uint:19 customization_patch[2];
        // offset: 0x5b20, bitSize: 0x20(0x4 Byte(s))
        int lastSeenActiveArmoryIndex;
        // offset: 0x5b40, bitSize: 0xa80(0x150 Byte(s)), array:0x3(hti:0xffff)
        DeviceConnectionHistory deviceConnectionHistory[3];
        // offset: 0x65c0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveGroupInvites;
        // offset: 0x65c8, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_frame[2];
        // offset: 0x65e8, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_title[2];
        // offset: 0x6608, bitSize: 0x80(0x10 Byte(s))
        PlayerSortPreferences sortPreferences;
        // offset: 0x6688, bitSize: 0x200(0x40 Byte(s))
        string(64) savedUsername;
        // offset: 0x6888, bitSize: 0x200(0x40 Byte(s))
        string(64) influencerCode;
        // offset: 0x6a88, bitSize: 0x8(0x1 Byte(s))
        byte lastBattlePassFreeTierSeen;
        // offset: 0x6a90, bitSize: 0x20(0x4 Byte(s))
        uint storeLastSeenTime;
        // offset: 0x6ab0, bitSize: 0x8(0x1 Byte(s))
        byte battlePassPurchasePendingSeason;
        // offset: 0x6ab8, bitSize: 0x20(0x4 Byte(s))
        int currentTournament;
        // offset: 0x6ad8, bitSize: 0x60(0xc Byte(s))
        PlayerConnectionHistory playerConnectionHistory;
        // offset: 0x6b38, bitSize: 0x1
        bool toggleOfflineFriends;
        // offset: 0x6b39, bitSize: 0x1
        bool isBPOnboardingCleared;
        // offset: 0x6b3a, bitSize: 0x1
        bool wereOperatorExecutionsValidated;
        // offset: 0x6b3b, bitSize: 0x1
        bool cross_play_enabled;
        // offset: 0x6b3c, bitSize: 0x1
        bool isShowProsAndConsEnabled;
        // offset: 0x6b3d, bitSize: 0x1
        bool hasAnyTempBanActive;
        // offset: 0x6b3e, bitSize: 0x1
        bool mobileShaderDlogStarted;
        // offset: 0x6b3f, bitSize: 0x1
        bool muteOnJoinParty;
        // offset: 0x6b40, bitSize: 0x1
        bool party_autofill_lock;
        // offset: 0x6b41, bitSize: 0x1
        bool disableProximityVoice;
        // offset: 0x6b42, bitSize: 0x1
        bool wasProtuningPlayerDataConverted;
        // offset: 0x6b43, bitSize: 0x1
        bool didFixRoyalKnifeVariantIndexMixUp;
        // offset: 0x6b44, bitSize: 0x20(0x4 Byte(s)), array:0x20(hti:0xffff)
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

    // root: bitSize: 0x6b70, members: 2

    // offset: 0x0, bitSize: 0x6b68(0xd6d Byte(s))
    NonGameData nonGameData;
    // offset: 0x6b68, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

version 1 {
    // enums ..... 8 (0x8)
    // structs ... 21 (0x15)
    // bit size .. 27680 (0x6c20)
    // byte size . 3460 (0xd84)
    // archive ... hash_38091a4051c510e5

    // bitSize: 0x8, members: 2
    struct ValidationData {
        // offset: 0x0, bitSize: 0x5, array:0x5(hti:0x0)
        bool validationHint[ValidationHint];
    };

    // bitSize: 0x50c0, members: 41
    struct UnlockTable {
        // offset: 0x0, bitSize: 0x280(0x50 Byte(s)), array:0x14(hti:0xffff)
        int camo[20];
        // offset: 0x280, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int perk[2];
        // offset: 0x2c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int role[1];
        // offset: 0x2e0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int temp[1];
        // offset: 0x300, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int intro[1];
        // offset: 0x320, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int super[2];
        // offset: 0x360, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special_weapon[1];
        // offset: 0x380, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int firstpartylicense[5];
        // offset: 0x420, bitSize: 0xa0(0x14 Byte(s)), array:0x5(hti:0xffff)
        int gun_screen[5];
        // offset: 0x4c0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int executions[4];
        // offset: 0x540, bitSize: 0x660(0xcc Byte(s)), array:0x33(hti:0xffff)
        int playercards[51];
        // offset: 0xba0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int munition[1];
        // offset: 0xbc0, bitSize: 0x3a0(0x74 Byte(s)), array:0x1d(hti:0xffff)
        int weapon_charm[29];
        // offset: 0xf60, bitSize: 0x120(0x24 Byte(s)), array:0x9(hti:0xffff)
        int faction_progression[9];
        // offset: 0x1080, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int currencypack[1];
        // offset: 0x10a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int mission[1];
        // offset: 0x10c0, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int equipment[3];
        // offset: 0x1120, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int reticle[3];
        // offset: 0x1180, bitSize: 0x1c0(0x38 Byte(s)), array:0xe(hti:0xffff)
        int operator_quip[14];
        // offset: 0x1340, bitSize: 0x160(0x2c Byte(s)), array:0xb(hti:0xffff)
        int operator_skin[11];
        // offset: 0x14a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int blackcell[1];
        // offset: 0x14c0, bitSize: 0x280(0x50 Byte(s)), array:0x14(hti:0xffff)
        int loadingscreen[20];
        // offset: 0x1740, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
        int vehicle_track[3];
        // offset: 0x17a0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int parachute[1];
        // offset: 0x17c0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int gestures[1];
        // offset: 0x17e0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int sp_reward[1];
        // offset: 0x1800, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int battlepass[1];
        // offset: 0x1820, bitSize: 0x100(0x20 Byte(s)), array:0x8(hti:0xffff)
        int vehicle_camo[8];
        // offset: 0x1920, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int vehicle_horn[1];
        // offset: 0x1940, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int special[1];
        // offset: 0x1960, bitSize: 0x20c0(0x418 Byte(s)), array:0x106(hti:0xffff)
        int attachment[262];
        // offset: 0x3a20, bitSize: 0x480(0x90 Byte(s)), array:0x24(hti:0xffff)
        int sticker[36];
        // offset: 0x3ea0, bitSize: 0xc0(0x18 Byte(s)), array:0x6(hti:0xffff)
        int accolades[6];
        // offset: 0x3f60, bitSize: 0x6e0(0xdc Byte(s)), array:0x37(hti:0xffff)
        int emblems[55];
        // offset: 0x4640, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int calloutmarkerpingitem[1];
        // offset: 0x4660, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int feature[1];
        // offset: 0x4680, bitSize: 0x400(0x80 Byte(s)), array:0x20(hti:0xffff)
        int weapon[32];
        // offset: 0x4a80, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int killstreak[2];
        // offset: 0x4ac0, bitSize: 0x20(0x4 Byte(s)), array:0x1(hti:0xffff)
        int contrail[1];
        // offset: 0x4ae0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int operator[2];
        // offset: 0x4b20, bitSize: 0x5a0(0xb4 Byte(s)), array:0x2d(hti:0xffff)
        int consumable[45];
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

    // bitSize: 0xd0, members: 5
    struct SeasonalEventData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s))
        string(16) eventName;
        // offset: 0x80, bitSize: 0x8(0x1 Byte(s))
        byte communityMilestonesUnlocksSeen;
        // offset: 0x88, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool seasonalChallengesUnlocksSeen[64];
        // offset: 0xc8, bitSize: 0x1
        bool hasSeenOnboarding;
    };

    // bitSize: 0x6b68, members: 63
    struct NonGameData {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkLow[4];
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        uint lastSeenSurveyVersion;
        // offset: 0xa0, bitSize: 0x50c0(0xa18 Byte(s))
        UnlockTable isNew;
        // offset: 0x5160, bitSize: 0xd0(0x1a Byte(s))
        SeasonalEventData seasonalEvent;
        // offset: 0x5230, bitSize: 0x30(0x6 Byte(s)), array:0x2(hti:0xffff)
        uint:19 customization_background[2];
        // offset: 0x5260, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveWhispers;
        // offset: 0x5268, bitSize: 0x40(0x8 Byte(s))
        uint64 toastNotificationUnpauseTimestamp;
        // offset: 0x52a8, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int consoleIDChunkHigh[4];
        // offset: 0x5328, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedCategoryID;
        // offset: 0x5348, bitSize: 0x8(0x1 Byte(s))
        byte quickplayFilter;
        // offset: 0x5350, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidLow[4];
        // offset: 0x53d0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int tournamentQuits[4];
        // offset: 0x5450, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveFriendRequests;
        // offset: 0x5458, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0xffff)
        uint:6 battlePassBreadCrumbs[23];
        // offset: 0x5510, bitSize: 0x8(0x1 Byte(s))
        PartyPrivacySetting partyPrivacySettings;
        // offset: 0x5518, bitSize: 0x20(0x4 Byte(s))
        int bigTournamentBanStart;
        // offset: 0x5538, bitSize: 0x20(0x4 Byte(s))
        uint mpMotdChecksum;
        // offset: 0x5558, bitSize: 0x20(0x4 Byte(s))
        int lastPlayedPlaylistID;
        // offset: 0x5578, bitSize: 0x40(0x8 Byte(s))
        uint64 influencerCodeTime;
        // offset: 0x55b8, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesLastSeenTime;
        // offset: 0x55d8, bitSize: 0x20(0x4 Byte(s))
        uint brMotdChecksum;
        // offset: 0x55f8, bitSize: 0x20(0x4 Byte(s))
        uint dailyChallengesPopupChecksum;
        // offset: 0x5618, bitSize: 0x258(0x4b Byte(s)), array:0x5(hti:0xffff)
        SocialPartySettings socialPartySettings[5];
        // offset: 0x5870, bitSize: 0x20(0x4 Byte(s))
        uint cpMotdChecksum;
        // offset: 0x5890, bitSize: 0x20(0x4 Byte(s))
        int tokensEarnedSinceLastBattlePassUpsell;
        // offset: 0x58b0, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkHigh[4];
        // offset: 0x5930, bitSize: 0x20(0x4 Byte(s))
        uint spUninstallPromptLastSeenTimestamp;
        // offset: 0x5950, bitSize: 0x20(0x4 Byte(s))
        uint lastBattlePassMenuXp;
        // offset: 0x5970, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveChannelInvites;
        // offset: 0x5978, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int connectionIDChunkLow[4];
        // offset: 0x59f8, bitSize: 0x20(0x4 Byte(s))
        uint lastRank;
        // offset: 0x5a18, bitSize: 0x10(0x2 Byte(s))
        DefaultPartySettings defaultPartySettings;
        // offset: 0x5a28, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveActivityInvites;
        // offset: 0x5a30, bitSize: 0x80(0x10 Byte(s)), array:0x4(hti:0xffff)
        int playerXuidHigh[4];
        // offset: 0x5ab0, bitSize: 0x40(0x8 Byte(s)), array:0x2(hti:0xffff)
        int maxPrivatePartySize[2];
        // offset: 0x5af0, bitSize: 0x30(0x6 Byte(s)), array:0x2(hti:0xffff)
        uint:19 customization_patch[2];
        // offset: 0x5b20, bitSize: 0x20(0x4 Byte(s))
        int lastSeenActiveArmoryIndex;
        // offset: 0x5b40, bitSize: 0xa80(0x150 Byte(s)), array:0x3(hti:0xffff)
        DeviceConnectionHistory deviceConnectionHistory[3];
        // offset: 0x65c0, bitSize: 0x8(0x1 Byte(s))
        SocialPrivacySetting receiveGroupInvites;
        // offset: 0x65c8, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_frame[2];
        // offset: 0x65e8, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        short customization_playercard_title[2];
        // offset: 0x6608, bitSize: 0x80(0x10 Byte(s))
        PlayerSortPreferences sortPreferences;
        // offset: 0x6688, bitSize: 0x200(0x40 Byte(s))
        string(64) savedUsername;
        // offset: 0x6888, bitSize: 0x200(0x40 Byte(s))
        string(64) influencerCode;
        // offset: 0x6a88, bitSize: 0x8(0x1 Byte(s))
        byte lastBattlePassFreeTierSeen;
        // offset: 0x6a90, bitSize: 0x20(0x4 Byte(s))
        uint storeLastSeenTime;
        // offset: 0x6ab0, bitSize: 0x8(0x1 Byte(s))
        byte battlePassPurchasePendingSeason;
        // offset: 0x6ab8, bitSize: 0x20(0x4 Byte(s))
        int currentTournament;
        // offset: 0x6ad8, bitSize: 0x60(0xc Byte(s))
        PlayerConnectionHistory playerConnectionHistory;
        // offset: 0x6b38, bitSize: 0x1
        bool toggleOfflineFriends;
        // offset: 0x6b39, bitSize: 0x1
        bool isBPOnboardingCleared;
        // offset: 0x6b3a, bitSize: 0x1
        bool cross_play_enabled;
        // offset: 0x6b3b, bitSize: 0x1
        bool isShowProsAndConsEnabled;
        // offset: 0x6b3c, bitSize: 0x1
        bool hasAnyTempBanActive;
        // offset: 0x6b3d, bitSize: 0x1
        bool executionValidationRequired;
        // offset: 0x6b3e, bitSize: 0x1
        bool mobileShaderDlogStarted;
        // offset: 0x6b3f, bitSize: 0x1
        bool muteOnJoinParty;
        // offset: 0x6b40, bitSize: 0x1
        bool party_autofill_lock;
        // offset: 0x6b41, bitSize: 0x1
        bool disableProximityVoice;
        // offset: 0x6b42, bitSize: 0x1
        bool wasProtuningPlayerDataConverted;
        // offset: 0x6b43, bitSize: 0x1
        bool didFixRoyalKnifeVariantIndexMixUp;
        // offset: 0x6b44, bitSize: 0x20(0x4 Byte(s)), array:0x20(hti:0xffff)
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

    // root: bitSize: 0x6b70, members: 2

    // offset: 0x0, bitSize: 0x6b68(0xd6d Byte(s))
    NonGameData nonGameData;
    // offset: 0x6b68, bitSize: 0x8(0x1 Byte(s))
    ValidationData validationData;
};

