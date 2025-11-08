// file .... ddl\mp\telemetry_endmatchdata.ddl

version 1 {
    // enums ..... 26 (0x1a)
    // structs ... 24 (0x18)
    // bit size .. 6672 (0x1a10)
    // byte size . 834 (0x342)
    // archive ... hash_984db6f659672a91

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x40, members: 3
    struct AttachmentSetup {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        Attachment attachment;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        uint:6 customTune[2];
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int variantID;
    };

    // bitSize: 0x338, members: 10
    struct WeaponSetup {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Camouflage camo;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        uint paintJobID;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        Reticle reticle;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        CosmeticAttachment cosmeticAttachment;
        // offset: 0x40, bitSize: 0x50(0xa Byte(s)), array:0x5(hti:0xffff)
        Sticker sticker[5];
        // offset: 0x90, bitSize: 0xa0(0x14 Byte(s))
        string(20) blueprintName;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        LoadoutWeapon weapon;
        // offset: 0x138, bitSize: 0x1c0(0x38 Byte(s)), array:0x7(hti:0xffff)
        AttachmentSetup attachmentSetup[7];
        // offset: 0x2f8, bitSize: 0x20(0x4 Byte(s))
        int lootItemID;
        // offset: 0x318, bitSize: 0x20(0x4 Byte(s))
        int variantID;
    };

    // bitSize: 0x68, members: 3
    struct VehicleCustomization {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        uint:10 camo;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte horn;
        // offset: 0x18, bitSize: 0x50(0xa Byte(s)), array:0xa(hti:0xffff)
        byte tracks[10];
    };

    // bitSize: 0x60, members: 4
    struct OperatorCustomization {
        // offset: 0x0, bitSize: 0x18(0x3 Byte(s))
        uint:19 skin;
        // offset: 0x18, bitSize: 0x18(0x3 Byte(s))
        uint:19 intro;
        // offset: 0x30, bitSize: 0x18(0x3 Byte(s))
        uint:19 taunt;
        // offset: 0x48, bitSize: 0x18(0x3 Byte(s))
        uint:19 execution;
    };

    // bitSize: 0x1e08, members: 8
    struct CustomizationSetup {
        // offset: 0x0, bitSize: 0x330(0x66 Byte(s)), array:0x33(hti:0x17)
        short operatorSkins[Operator];
        // offset: 0x330, bitSize: 0x20(0x4 Byte(s))
        int operatorWatch;
        // offset: 0x350, bitSize: 0x1320(0x264 Byte(s)), array:0x33(hti:0x17)
        OperatorCustomization operatorCustomization[Operator];
        // offset: 0x1670, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        Operator operators[2];
        // offset: 0x1680, bitSize: 0x680(0xd0 Byte(s)), array:0x10(hti:0x18)
        VehicleCustomization vehicleCustomization[Vehicle];
        // offset: 0x1d00, bitSize: 0x100(0x20 Byte(s)), array:0x8(hti:0xffff)
        int radial[8];
        // offset: 0x1e00, bitSize: 0x1
        bool selectedOperatorIndex;
    };

    // bitSize: 0xa70, members: 12
    struct CustomizationFavorites {
        // offset: 0x0, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteReticles[10];
        // offset: 0xf0, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteVehicleCamos[10];
        // offset: 0x1e0, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteEmblems[10];
        // offset: 0x2d0, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteCharms[10];
        // offset: 0x3c0, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteStickers[10];
        // offset: 0x4b0, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteSprays[10];
        // offset: 0x5a0, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteGestures[10];
        // offset: 0x690, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteVoices[10];
        // offset: 0x780, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteCallingCards[10];
        // offset: 0x870, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteCamos[10];
        // offset: 0x960, bitSize: 0x20(0x4 Byte(s))
        int favoriteLoadoutIndex;
        // offset: 0x980, bitSize: 0xf0(0x1e Byte(s)), array:0xa(hti:0xffff)
        uint:22 favoriteWatches[10];
    };

    // bitSize: 0x30, members: 4
    struct PowerSetup {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Power power;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int lootItemID;
        // offset: 0x28, bitSize: 0x1
        bool extraCharge;
    };

    // bitSize: 0x10, members: 3
    struct EquipmentSetup {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Equipment equipment;
        // offset: 0x8, bitSize: 0x1
        bool extraCharge;
    };

    // bitSize: 0x8, members: 1
    struct KillstreakSetup {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Killstreak killstreak;
    };

    // bitSize: 0x8, members: 1
    struct MunitionSetup {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Munition munition;
    };

    // bitSize: 0x70, members: 10
    struct ArchetypeSetup {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        BodyCustomization body;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        HeadCustomization head;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        TauntCustomization taunt;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        Accessory accessory;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        Super archetypeSuper;
        // offset: 0x38, bitSize: 0x20(0x4 Byte(s)), array:0x4(hti:0xffff)
        TauntCustomization taunts[4];
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        Perk archetypePerk;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        Gesture gesture;
        // offset: 0x68, bitSize: 0x1
        CharacterArchetype archetype;
    };

    // bitSize: 0xc0, members: 2
    struct PerkPackage {
        // offset: 0x0, bitSize: 0xa0(0x14 Byte(s))
        string(20) name;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s)), array:0x4(hti:0xffff)
        Perk perks[4];
    };

    // bitSize: 0x68, members: 2
    struct PMCMission {
        // offset: 0x0, bitSize: 0x48(0x9 Byte(s)), array:0x3(hti:0xffff)
        uint:17 challengeProgress[3];
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        int challengeID;
    };

    // bitSize: 0xab8, members: 11
    struct Loadout {
        // offset: 0x0, bitSize: 0xa0(0x14 Byte(s))
        string(20) name;
        // offset: 0xa0, bitSize: 0x8(0x1 Byte(s))
        uint:4 equippedPerkPackageIndex;
        // offset: 0xa8, bitSize: 0x9a8(0x135 Byte(s)), array:0x3(hti:0xffff)
        WeaponSetup weaponSetups[3];
        // offset: 0xa50, bitSize: 0x20(0x4 Byte(s)), array:0x2(hti:0xffff)
        EquipmentSetup equipmentSetups[2];
        // offset: 0xa70, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
        Perk extraPerks[3];
        // offset: 0xa88, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        Super fieldUpgrades[2];
        // offset: 0xa98, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
        Perk loadoutPerks[3];
        // offset: 0xab0, bitSize: 0x1
        bool inUse;
        // offset: 0xab1, bitSize: 0x1
        bool overkill;
        // offset: 0xab2, bitSize: 0x1
        bool usingSpecialist;
    };

    // bitSize: 0x9fc8, members: 37
    struct SquadMember {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short body;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short head;
        // offset: 0x20, bitSize: 0xa0(0x14 Byte(s))
        string(20) name;
        // offset: 0xc0, bitSize: 0x8(0x1 Byte(s))
        byte ai_loadout;
        // offset: 0xc8, bitSize: 0x4c0(0x98 Byte(s)), array:0x26(hti:0x4)
        int streakPreferences[Killstreak];
        // offset: 0x588, bitSize: 0x10(0x2 Byte(s))
        short patch;
        // offset: 0x598, bitSize: 0x8(0x1 Byte(s))
        TauntCustomization taunt;
        // offset: 0x5a0, bitSize: 0x20(0x4 Byte(s))
        int highVisibilityMode;
        // offset: 0x5c0, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
        KillstreakSetup killstreakSetups[3];
        // offset: 0x5d8, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
        MunitionSetup munitionSetups[3];
        // offset: 0x5f0, bitSize: 0x80a0(0x1014 Byte(s)), array:0xc(hti:0xffff)
        Loadout loadouts[12];
        // offset: 0x8690, bitSize: 0x8(0x1 Byte(s))
        Accessory accessory;
        // offset: 0x8698, bitSize: 0x20(0x4 Byte(s))
        int player_xp;
        // offset: 0x86b8, bitSize: 0x20(0x4 Byte(s))
        int commendationsEarned;
        // offset: 0x86d8, bitSize: 0x138(0x27 Byte(s)), array:0x3(hti:0xffff)
        PMCMission activePMCMissions[3];
        // offset: 0x8810, bitSize: 0x20(0x4 Byte(s))
        int activePMCMissionProgress;
        // offset: 0x8830, bitSize: 0x10(0x2 Byte(s))
        short background;
        // offset: 0x8840, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
        MunitionSetup munitionWaveModeSetups[3];
        // offset: 0x8858, bitSize: 0x8(0x1 Byte(s))
        CPSuper cpFieldUpgrade;
        // offset: 0x8860, bitSize: 0x10(0x2 Byte(s))
        short helmet;
        // offset: 0x8870, bitSize: 0x20(0x4 Byte(s))
        int cpLoadoutSel;
        // offset: 0x8890, bitSize: 0x8c0(0x118 Byte(s)), array:0x46(hti:0xb)
        int weapon_xp[LoadoutWeapon];
        // offset: 0x9150, bitSize: 0x8(0x1 Byte(s))
        Super archetypeSuper;
        // offset: 0x9158, bitSize: 0xab8(0x157 Byte(s))
        Loadout loadoutWaveMode;
        // offset: 0x9c10, bitSize: 0x20(0x4 Byte(s)), array:0x4(hti:0xffff)
        TauntCustomization taunts[4];
        // offset: 0x9c30, bitSize: 0x20(0x4 Byte(s))
        int season_rank;
        // offset: 0x9c50, bitSize: 0x20(0x4 Byte(s))
        int currencyWaveMode;
        // offset: 0x9c70, bitSize: 0x20(0x4 Byte(s))
        int activePMCMissionID;
        // offset: 0x9c90, bitSize: 0x310(0x62 Byte(s)), array:0x7(hti:0xffff)
        ArchetypeSetup archetypePreferences[7];
        // offset: 0x9fa0, bitSize: 0x10(0x2 Byte(s))
        short patchbacking;
        // offset: 0x9fb0, bitSize: 0x8(0x1 Byte(s))
        Perk archetypePerk;
        // offset: 0x9fb8, bitSize: 0x8(0x1 Byte(s))
        Gesture gesture;
        // offset: 0x9fc0, bitSize: 0x1
        bool inUse;
        // offset: 0x9fc1, bitSize: 0x1
        bool defaultSet;
        // offset: 0x9fc2, bitSize: 0x1
        bool scoreStreak;
        // offset: 0x9fc3, bitSize: 0x1
        CharacterArchetype archetype;
    };

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

    // bitSize: 0xc0, members: 3
    struct PlayerID {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s))
        string(16) xuid;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int ucdIDHigh;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int ucdIDLow;
    };

    // bitSize: 0x588, members: 29
    struct Player {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte rank;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int endXp;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int kills;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int skill;
        // offset: 0x88, bitSize: 0x20(0x4 Byte(s))
        uint utcConnectTimeSeconds;
        // offset: 0xa8, bitSize: 0xd0(0x1a Byte(s))
        string(26) disconnectReason;
        // offset: 0x178, bitSize: 0x20(0x4 Byte(s))
        float boostingScore;
        // offset: 0x198, bitSize: 0x20(0x4 Byte(s))
        int matchXp;
        // offset: 0x1b8, bitSize: 0x20(0x4 Byte(s))
        int endDeaths;
        // offset: 0x1d8, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
        Killstreak killstreaks[3];
        // offset: 0x1f0, bitSize: 0x20(0x4 Byte(s))
        int endKills;
        // offset: 0x210, bitSize: 0xc0(0x18 Byte(s))
        PlayerID playerID;
        // offset: 0x2d0, bitSize: 0x20(0x4 Byte(s))
        int scoreXp;
        // offset: 0x2f0, bitSize: 0x20(0x4 Byte(s))
        int teamIdHigh;
        // offset: 0x310, bitSize: 0x170(0x2e Byte(s))
        string(46) gamertag;
        // offset: 0x480, bitSize: 0x8(0x1 Byte(s))
        byte voteType;
        // offset: 0x488, bitSize: 0x20(0x4 Byte(s))
        int endWins;
        // offset: 0x4a8, bitSize: 0x20(0x4 Byte(s))
        int deaths;
        // offset: 0x4c8, bitSize: 0x8(0x1 Byte(s))
        byte Prestige;
        // offset: 0x4d0, bitSize: 0x20(0x4 Byte(s))
        int totalXp;
        // offset: 0x4f0, bitSize: 0x20(0x4 Byte(s))
        int miscXp;
        // offset: 0x510, bitSize: 0x8(0x1 Byte(s))
        byte partyID;
        // offset: 0x518, bitSize: 0x20(0x4 Byte(s))
        int challengeXp;
        // offset: 0x538, bitSize: 0x20(0x4 Byte(s))
        uint utcDisconnectTimeSeconds;
        // offset: 0x558, bitSize: 0x8(0x1 Byte(s))
        byte longestStreak;
        // offset: 0x560, bitSize: 0x20(0x4 Byte(s))
        int teamIdLow;
        // offset: 0x580, bitSize: 0x1
        bool isTrialVersion;
    };

    // bitSize: 0x370, members: 7
    struct Match {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
        string(32) map;
        // offset: 0x100, bitSize: 0x128(0x25 Byte(s))
        string(37) matchGUID;
        // offset: 0x228, bitSize: 0x20(0x4 Byte(s))
        uint utcEndTimeSeconds;
        // offset: 0x248, bitSize: 0x20(0x4 Byte(s))
        uint utcStartTimeSeconds;
        // offset: 0x268, bitSize: 0x100(0x20 Byte(s))
        string(32) gametype;
        // offset: 0x368, bitSize: 0x1
        bool isPrivateMatch;
    };

    // idx 0x0 members: 0x4d type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        gwai, // 0x43
        bounty, // 0x44
        zm_rb, // 0x45
        gwtdm, // 0x46
        ob, // 0x47
        war_mgl, // 0x48
        dom_mgl, // 0x49
        br_resurgence, // 0x4a
        benchmark, // 0x4b
        boostball // 0x4c
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xd3 type: 0
    enum Camouflage {
        none, // 0x0
        camo_a_01, // 0x1
        camo_a_02, // 0x2
        camo_a_03, // 0x3
        camo_a_04, // 0x4
        camo_a_05, // 0x5
        camo_a_06, // 0x6
        camo_a_07, // 0x7
        camo_a_08, // 0x8
        camo_a_09, // 0x9
        camo_a_10, // 0xa
        camo_a_11, // 0xb
        camo_a_12, // 0xc
        camo_a_13, // 0xd
        camo_a_14, // 0xe
        camo_a_15, // 0xf
        camo_b_01, // 0x10
        camo_b_02, // 0x11
        camo_b_03, // 0x12
        camo_b_04, // 0x13
        camo_b_05, // 0x14
        camo_b_06, // 0x15
        camo_b_07, // 0x16
        camo_b_08, // 0x17
        camo_b_09, // 0x18
        camo_b_10, // 0x19
        camo_b_11, // 0x1a
        camo_b_12, // 0x1b
        camo_b_13, // 0x1c
        camo_b_14, // 0x1d
        camo_b_15, // 0x1e
        camo_c_01, // 0x1f
        camo_c_02, // 0x20
        camo_c_03, // 0x21
        camo_c_04, // 0x22
        camo_c_05, // 0x23
        camo_c_06, // 0x24
        camo_c_07, // 0x25
        camo_c_08, // 0x26
        camo_c_09, // 0x27
        camo_c_10, // 0x28
        camo_c_11, // 0x29
        camo_c_12, // 0x2a
        camo_c_13, // 0x2b
        camo_c_14, // 0x2c
        camo_c_15, // 0x2d
        camo_d_01, // 0x2e
        camo_d_02, // 0x2f
        camo_d_03, // 0x30
        camo_d_04, // 0x31
        camo_d_05, // 0x32
        camo_d_06, // 0x33
        camo_d_07, // 0x34
        camo_d_08, // 0x35
        camo_d_09, // 0x36
        camo_d_10, // 0x37
        camo_d_11, // 0x38
        camo_d_12, // 0x39
        camo_d_13, // 0x3a
        camo_d_14, // 0x3b
        camo_d_15, // 0x3c
        camo_e_01, // 0x3d
        camo_e_02, // 0x3e
        camo_e_03, // 0x3f
        camo_e_04, // 0x40
        camo_e_05, // 0x41
        camo_e_06, // 0x42
        camo_e_07, // 0x43
        camo_e_08, // 0x44
        camo_e_09, // 0x45
        camo_e_10, // 0x46
        camo_e_11, // 0x47
        camo_e_12, // 0x48
        camo_e_13, // 0x49
        camo_e_14, // 0x4a
        camo_e_15, // 0x4b
        camo_f_01, // 0x4c
        camo_f_02, // 0x4d
        camo_f_03, // 0x4e
        camo_f_04, // 0x4f
        camo_f_05, // 0x50
        camo_f_06, // 0x51
        camo_f_07, // 0x52
        camo_f_08, // 0x53
        camo_f_09, // 0x54
        camo_f_10, // 0x55
        camo_f_11, // 0x56
        camo_f_12, // 0x57
        camo_f_13, // 0x58
        camo_f_14, // 0x59
        camo_f_15, // 0x5a
        camo_g_01, // 0x5b
        camo_g_02, // 0x5c
        camo_g_03, // 0x5d
        camo_g_04, // 0x5e
        camo_g_05, // 0x5f
        camo_g_06, // 0x60
        camo_g_07, // 0x61
        camo_g_08, // 0x62
        camo_g_09, // 0x63
        camo_g_10, // 0x64
        camo_g_11, // 0x65
        camo_g_12, // 0x66
        camo_g_13, // 0x67
        camo_g_14, // 0x68
        camo_g_15, // 0x69
        camo_h_01, // 0x6a
        camo_h_02, // 0x6b
        camo_h_03, // 0x6c
        camo_h_04, // 0x6d
        camo_h_05, // 0x6e
        camo_h_06, // 0x6f
        camo_h_07, // 0x70
        camo_h_08, // 0x71
        camo_h_09, // 0x72
        camo_h_10, // 0x73
        camo_h_11, // 0x74
        camo_h_12, // 0x75
        camo_h_13, // 0x76
        camo_h_14, // 0x77
        camo_h_15, // 0x78
        camo_i_01, // 0x79
        camo_i_02, // 0x7a
        camo_i_03, // 0x7b
        camo_i_04, // 0x7c
        camo_i_05, // 0x7d
        camo_i_06, // 0x7e
        camo_i_07, // 0x7f
        camo_i_08, // 0x80
        camo_i_09, // 0x81
        camo_i_10, // 0x82
        camo_i_11, // 0x83
        camo_i_12, // 0x84
        camo_i_13, // 0x85
        camo_i_14, // 0x86
        camo_i_15, // 0x87
        camo_j_01, // 0x88
        camo_j_02, // 0x89
        camo_j_03, // 0x8a
        camo_j_04, // 0x8b
        camo_j_05, // 0x8c
        camo_j_06, // 0x8d
        camo_j_07, // 0x8e
        camo_j_08, // 0x8f
        camo_j_09, // 0x90
        camo_j_10, // 0x91
        camo_j_11, // 0x92
        camo_j_12, // 0x93
        camo_j_13, // 0x94
        camo_j_14, // 0x95
        camo_j_15, // 0x96
        camo_k_01, // 0x97
        camo_k_02, // 0x98
        camo_k_03, // 0x99
        camo_k_04, // 0x9a
        camo_k_05, // 0x9b
        camo_k_06, // 0x9c
        camo_k_07, // 0x9d
        camo_k_08, // 0x9e
        camo_k_09, // 0x9f
        camo_k_10, // 0xa0
        camo_k_11, // 0xa1
        camo_k_12, // 0xa2
        camo_k_13, // 0xa3
        camo_k_14, // 0xa4
        camo_k_15, // 0xa5
        camo_l_01, // 0xa6
        camo_l_02, // 0xa7
        camo_l_03, // 0xa8
        camo_l_04, // 0xa9
        camo_l_05, // 0xaa
        camo_l_06, // 0xab
        camo_l_07, // 0xac
        camo_l_08, // 0xad
        camo_l_09, // 0xae
        camo_l_10, // 0xaf
        camo_l_11, // 0xb0
        camo_l_12, // 0xb1
        camo_l_13, // 0xb2
        camo_l_14, // 0xb3
        camo_l_15, // 0xb4
        camo_m_01, // 0xb5
        camo_m_02, // 0xb6
        camo_m_03, // 0xb7
        camo_m_04, // 0xb8
        camo_m_05, // 0xb9
        camo_m_06, // 0xba
        camo_m_07, // 0xbb
        camo_m_08, // 0xbc
        camo_m_09, // 0xbd
        camo_m_10, // 0xbe
        camo_m_11, // 0xbf
        camo_m_12, // 0xc0
        camo_m_13, // 0xc1
        camo_m_14, // 0xc2
        camo_m_15, // 0xc3
        camo_n_01, // 0xc4
        camo_n_02, // 0xc5
        camo_n_03, // 0xc6
        camo_n_04, // 0xc7
        camo_n_05, // 0xc8
        camo_n_06, // 0xc9
        camo_n_07, // 0xca
        camo_n_08, // 0xcb
        camo_n_09, // 0xcc
        camo_n_10, // 0xcd
        camo_n_11, // 0xce
        camo_n_12, // 0xcf
        camo_n_13, // 0xd0
        camo_n_14, // 0xd1
        camo_n_15 // 0xd2
    };

    // idx 0xa members: 0x5b type: 0
    enum Reticle {
        none, // 0x0
        ret01, // 0x1
        ret02, // 0x2
        ret03, // 0x3
        ret04, // 0x4
        ret05, // 0x5
        ret06, // 0x6
        ret07, // 0x7
        ret08, // 0x8
        ret09, // 0x9
        ret10, // 0xa
        ret11, // 0xb
        ret12, // 0xc
        ret13, // 0xd
        ret14, // 0xe
        ret15, // 0xf
        ret16, // 0x10
        ret17, // 0x11
        ret18, // 0x12
        ret19, // 0x13
        ret20, // 0x14
        ret21, // 0x15
        ret22, // 0x16
        ret23, // 0x17
        ret24, // 0x18
        ret25, // 0x19
        ret26, // 0x1a
        ret27, // 0x1b
        ret28, // 0x1c
        ret29, // 0x1d
        ret30, // 0x1e
        ret31, // 0x1f
        ret32, // 0x20
        ret33, // 0x21
        ret34, // 0x22
        ret35, // 0x23
        ret36, // 0x24
        ret37, // 0x25
        ret38, // 0x26
        ret39, // 0x27
        ret40, // 0x28
        ret41, // 0x29
        ret42, // 0x2a
        ret43, // 0x2b
        ret44, // 0x2c
        ret45, // 0x2d
        ret46, // 0x2e
        ret47, // 0x2f
        ret48, // 0x30
        ret49, // 0x31
        ret50, // 0x32
        retsnpr01, // 0x33
        retsnpr02, // 0x34
        retsnpr03, // 0x35
        retsnpr04, // 0x36
        retsnpr05, // 0x37
        retsnpr06, // 0x38
        retsnpr07, // 0x39
        retsnpr08, // 0x3a
        retsnpr09, // 0x3b
        retsnpr10, // 0x3c
        retsnpr11, // 0x3d
        retsnpr12, // 0x3e
        retsnpr13, // 0x3f
        retsnpr14, // 0x40
        retsnpr15, // 0x41
        retsnpr16, // 0x42
        retsnpr17, // 0x43
        retsnpr18, // 0x44
        retsnpr19, // 0x45
        retsnpr20, // 0x46
        retsnpr21, // 0x47
        retsnpr22, // 0x48
        retsnpr23, // 0x49
        retsnpr24, // 0x4a
        retsnpr25, // 0x4b
        retsnpr26, // 0x4c
        retsnpr27, // 0x4d
        retsnpr28, // 0x4e
        retsnpr29, // 0x4f
        retsnpr30, // 0x50
        retsnpr31, // 0x51
        retsnpr32, // 0x52
        retsnpr33, // 0x53
        retsnpr34, // 0x54
        retsnpr35, // 0x55
        retsnpr36, // 0x56
        retsnpr37, // 0x57
        retsnpr38, // 0x58
        retsnpr39, // 0x59
        retsnpr40 // 0x5a
    };

    // idx 0xb members: 0x46 type: 0
    enum LoadoutWeapon {
        none, // 0x0
        iw9_ar_mike4test1, // 0x1
        iw9_ar_mike4test2, // 0x2
        iw9_ar_mike4test3, // 0x3
        iw8_ar_mike4test, // 0x4
        iw8_lm_mkilo3test, // 0x5
        iw9_me_fists, // 0x6
        iw9_me_riotshield, // 0x7
        iw9_ar_golf3, // 0x8
        iw9_ar_kilo53, // 0x9
        iw9_ar_mike4, // 0xa
        iw9_ar_mike16, // 0xb
        iw9_ar_akilo, // 0xc
        iw9_ar_akilo105, // 0xd
        iw9_ar_akilo74, // 0xe
        iw9_ar_augolf, // 0xf
        iw9_ar_schotel, // 0x10
        iw9_ar_mcharlie, // 0x11
        iw9_ar_mcbravo, // 0x12
        iw9_ar_scharlie, // 0x13
        iw9_ar_scsierra, // 0x14
        iw9_br_msecho, // 0x15
        iw9_br_soscar14, // 0x16
        iw9_sm_aviktor, // 0x17
        iw9_sm_alpha57, // 0x18
        iw9_sm_mpapa5, // 0x19
        iw9_sm_mpapa7, // 0x1a
        iw9_sm_beta, // 0x1b
        iw9_sm_victor, // 0x1c
        iw9_sm_apapa, // 0x1d
        iw9_sm_mpapax, // 0x1e
        iw9_sm_papa90, // 0x1f
        iw9_pi_decho, // 0x20
        iw9_pi_papa220, // 0x21
        iw9_pi_golf17, // 0x22
        iw9_pi_golf18, // 0x23
        iw9_pi_swhiskey, // 0x24
        iw9_sn_alpha50, // 0x25
        iw9_sn_mromeo, // 0x26
        iw9_sn_limax, // 0x27
        iw9_lm_kilo21, // 0x28
        iw9_lm_slima, // 0x29
        iw9_lm_foxtrot, // 0x2a
        iw9_lm_mkilo3, // 0x2b
        iw9_lm_rkilo, // 0x2c
        iw9_lm_ahotel, // 0x2d
        iw9_lm_ngolf7, // 0x2e
        iw9_sh_mbravo, // 0x2f
        iw9_sh_mike1014, // 0x30
        iw9_sh_mviktor, // 0x31
        iw9_sh_charlie725, // 0x32
        iw9_dm_mike24, // 0x33
        iw9_dm_xmike2010, // 0x34
        iw9_dm_pgolf1, // 0x35
        iw9_dm_sa700, // 0x36
        iw9_dm_la700, // 0x37
        iw9_dm_sbeta, // 0x38
        iw9_dm_mike14, // 0x39
        iw9_dm_scromeo, // 0x3a
        iw9_dm_crossbow, // 0x3b
        iw9_dm_recondartcrossbow, // 0x3c
        iw9_la_rpapa7, // 0x3d
        iw9_la_juliet, // 0x3e
        iw9_la_mike32, // 0x3f
        iw9_la_gromeo, // 0x40
        iw9_la_kgolf, // 0x41
        iw9_me_knife, // 0x42
        iw8_lm_dblmg, // 0x43
        iw9_lm_dblmg, // 0x44
        iw8_knife // 0x45
    };

    // idx 0xc members: 0x67c type: 0
    enum Attachment {
        none, // 0x0
        comp02, // 0x1
        iw9_brake01, // 0x2
        iw9_flashhider, // 0x3
        iw9_silencer01, // 0x4
        iw9_silencer02, // 0x5
        iw9_silencer03, // 0x6
        bar_ar_long_p04, // 0x7
        bar_ar_heavy_p04, // 0x8
        stock_ar_tactical_p04, // 0x9
        stock_sm_tactical_p04, // 0xa
        stock_sm_p04, // 0xb
        stock_ar_light_p04, // 0xc
        iw9_minireddot01, // 0xd
        iw9_minireddot02, // 0xe
        iw9_minireddot03, // 0xf
        iw9_minireddot04, // 0x10
        fourx01, // 0x11
        fourx02, // 0x12
        hybrid01, // 0x13
        hybrid02, // 0x14
        hybrid03, // 0x15
        thermal01, // 0x16
        thermal02, // 0x17
        holo01, // 0x18
        holo02, // 0x19
        holo03, // 0x1a
        reflex01, // 0x1b
        reflex02, // 0x1c
        reflex03, // 0x1d
        reflex04, // 0x1e
        grip_angled02, // 0x1f
        grip_vert01, // 0x20
        grip_vert02, // 0x21
        grip_vert03, // 0x22
        grip_vertshort01, // 0x23
        grip_vertshort02, // 0x24
        pgrip_aim_p04, // 0x25
        pgrip_ass_p04, // 0x26
        pgrip_tac_p04, // 0x27
        bar_ar_hvyshort_p04, // 0x28
        stock_ar_heavy_p04, // 0x29
        ub_glmini01, // 0x2a
        comp01, // 0x2b
        bar_ar_light_p04, // 0x2c
        bar_ar_hvyshort2_p04, // 0x2d
        bar_ar_lgtshort_p04, // 0x2e
        stock_ar_p04, // 0x2f
        stock_sm_light_p04, // 0x30
        stockno_sm_p04, // 0x31
        bargrip_ar_long_p03, // 0x32
        bar_ar_long_p03, // 0x33
        bar_ar_p03, // 0x34
        bar_ar_light_p03, // 0x35
        bar_sm_short_p03, // 0x36
        stock_sm_p03, // 0x37
        stock_lm_p03, // 0x38
        mag_sn_p03, // 0x39
        mag_ar_large_p03, // 0x3a
        pgrip_aim_p03, // 0x3b
        pgrip_ass_p03, // 0x3c
        pgrip_tac_p03, // 0x3d
        comb_heavy_p03, // 0x3e
        comb_ammo_p03, // 0x3f
        bar_ar_short_p02, // 0x40
        bar_lm_p02, // 0x41
        bar_lm_long_p02, // 0x42
        bar_br_light_p02, // 0x43
        bar_lm_short_p02, // 0x44
        bar_ar_light_p02, // 0x45
        stock_lm_p02, // 0x46
        stock_ar_tactical_p02, // 0x47
        stock_ar_assault_p02, // 0x48
        stock_sm_p02, // 0x49
        mag_ar_small_p02, // 0x4a
        mag_ar_large_p02, // 0x4b
        drum_ar_p02, // 0x4c
        bar_ar_longhvy_p01, // 0x4d
        bar_ar_heavy_p01, // 0x4e
        bar_ar_shorthvy_p01, // 0x4f
        bar_ar_light_p01, // 0x50
        bar_ar_short_p01, // 0x51
        bar_ar_long_p01, // 0x52
        stock_ar_tactical_p01, // 0x53
        stock_ar_light_p01, // 0x54
        stock_sm_p01, // 0x55
        stock_ar_assault_p01, // 0x56
        stock_sn_p01, // 0x57
        stockno_ar_p01, // 0x58
        mag_ar_large_p01, // 0x59
        mag_ar_xlarge_p01, // 0x5a
        ub_gl01, // 0x5b
        ub_sh01, // 0x5c
        pgrip_aim_p01, // 0x5d
        pgrip_ass_p01, // 0x5e
        pgrip_tac_p01, // 0x5f
        pgrip_ske_p01, // 0x60
        pgrip_snp_p01, // 0x61
        stock_sn_p02, // 0x62
        kilo21_sidegrip, // 0x63
        bar_br_short_p05, // 0x64
        bar_br_long_p05, // 0x65
        stock_sn_p05, // 0x66
        stock_ar_heavy_p05, // 0x67
        stock_ar_tactical_p05, // 0x68
        stock_sm_p05, // 0x69
        mag_br_p05, // 0x6a
        drum_br_p05, // 0x6b
        ironsdefault_schotel, // 0x6c
        pgrip_aim_p05, // 0x6d
        pgrip_ass_p05, // 0x6e
        pgrip_tac_p05, // 0x6f
        stockr_dm_heavy_p20, // 0x70
        stockr_dm_tactical_p20, // 0x71
        stock_dm_p20, // 0x72
        mag_dm_large_p20, // 0x73
        mag_dm_xlarge_p20, // 0x74
        mike24_scope, // 0x75
        chas_sa700, // 0x76
        pgrip_ass_p20, // 0x77
        pgrip_aim_p20, // 0x78
        bolt_hvy_p20, // 0x79
        bolt_lgt_p20, // 0x7a
        bar_dm_short_p19, // 0x7b
        bar_dm_light_p19, // 0x7c
        bar_dm_long_p19, // 0x7d
        bar_dm_hvylong_p19, // 0x7e
        stockr_dm_light_p19, // 0x7f
        stockr_dm_tactical_p19, // 0x80
        stockno_dm_p19, // 0x81
        tube_4_45gvt, // 0x82
        tube_8_45gvt, // 0x83
        iw9_ironsdefault_sbeta, // 0x84
        comb_ammo_p19, // 0x85
        comb_tactical_p19, // 0x86
        lever_heavy_p19, // 0x87
        lever_light_p19, // 0x88
        stock_sn_heavy_p20, // 0x89
        stock_sn_tactical_p20, // 0x8a
        pgrip_tac_p20, // 0x8b
        comb_hvy_p20, // 0x8c
        comb_tac_p20, // 0x8d
        bar_br_p02, // 0x8e
        stock_ar_p02, // 0x8f
        bar_sm_long_p04, // 0x90
        bar_sm_light_p04, // 0x91
        bar_sm_short_p04, // 0x92
        iw9_ironsdefault_beta, // 0x93
        bar_sm_long_p02, // 0x94
        bar_sm_short_p02, // 0x95
        bar_sm_light_p02, // 0x96
        stockno_sm_p02, // 0x97
        bar_sm_hvyxlong_p09, // 0x98
        bar_sm_xlong_p09, // 0x99
        bar_sm_long_p09, // 0x9a
        bar_sm_hvylong_p09, // 0x9b
        bar_sm_heavy_p09, // 0x9c
        bar_sm_short_p09, // 0x9d
        bar_sm_hvyshort_p09, // 0x9e
        stock_sm_heavy_p09, // 0x9f
        stock_sm_p09, // 0xa0
        stock_sm_tactical_p09, // 0xa1
        stockno_sm_p09, // 0xa2
        mag_sm_small_p09, // 0xa3
        mag_sm_large_p09, // 0xa4
        mag_sm_xlarge_p09, // 0xa5
        pgrip_aim_p09, // 0xa6
        pgrip_ass_p09, // 0xa7
        pgrip_tac_p09, // 0xa8
        bar_lm_heavy_p15, // 0xa9
        bar_lm_long_p15, // 0xaa
        bar_lm_short_p15, // 0xab
        stock_lm_lgttactical_p15, // 0xac
        stockno_lm_p15, // 0xad
        stock_lm_p15, // 0xae
        stock_lm_tactical_p15, // 0xaf
        stock_lm_heavy_p15, // 0xb0
        belt_lm_large_p15, // 0xb1
        mag_lm_small_p15, // 0xb2
        pgrip_ass_p15, // 0xb3
        pgrip_tac_p15, // 0xb4
        pgrip_p15, // 0xb5
        bar_lm_long_p04, // 0xb6
        bar_lm_light_p04, // 0xb7
        bar_ar_hvylong_p04, // 0xb8
        stock_lmg_heavy_p04, // 0xb9
        bar_lm_short_p16, // 0xba
        bar_lm_hvy_p16, // 0xbb
        bar_lm_long_p16, // 0xbc
        stock_lm_assault_p16, // 0xbd
        stock_lm_light_p16, // 0xbe
        stock_lm_tactical_p16, // 0xbf
        belt_lm_large_p16, // 0xc0
        belt_lm_small_p16, // 0xc1
        pgrip_aim_p16, // 0xc2
        pgrip_ass_p16, // 0xc3
        pgrip_tac_p16, // 0xc4
        stockr_sn_heavy_p20, // 0xc5
        stockr_sn_tactical_p20, // 0xc6
        mag_sn_p20, // 0xc7
        iw9_snprscope_alpha50, // 0xc8
        bar_sn_long_p21, // 0xc9
        bar_sn_short_p21, // 0xca
        barsil_sn_long_p21, // 0xcb
        stock_sn_heavy_p21, // 0xcc
        stock_sn_light_p21, // 0xcd
        stock_sn_tactical_p21, // 0xce
        mag_sn_small_p21, // 0xcf
        mag_sn_large_p21, // 0xd0
        snprscope_mromeo, // 0xd1
        pgrip_aim_p21, // 0xd2
        pgrip_ass_p21, // 0xd3
        pgrip_tac_p21, // 0xd4
        bolt_hvy_p21, // 0xd5
        bolt_lgt_p21, // 0xd6
        bar_sn_long_p22, // 0xd7
        bar_sn_light_p22, // 0xd8
        stock_sn_heavy_p22, // 0xd9
        stock_sn_tactical_p22, // 0xda
        stock_sn_light_p22, // 0xdb
        mag_sn_large_p22, // 0xdc
        limax_snprscope, // 0xdd
        br_rangeext_snpr, // 0xde
        pgrip_aim_p22, // 0xdf
        pgrip_ass_p22, // 0xe0
        pgrip_tac_p22, // 0xe1
        bar_pi_heavy_p24, // 0xe2
        bar_pi_light_p24, // 0xe3
        stockp_sm_tactical_p24, // 0xe4
        stockp_sm_light_p24, // 0xe5
        stockp_pi_p24, // 0xe6
        stockno_pi_p24, // 0xe7
        mag_pi_large_p24, // 0xe8
        mag_pi_xlarge_p24, // 0xe9
        drum_pi_p24, // 0xea
        pgrip_aim_p24, // 0xeb
        pgrip_ass_p24, // 0xec
        pgrip_tac_p24, // 0xed
        bar_sm_lngheavy_p24, // 0xee
        bar_sm_p24, // 0xef
        stockp_sm_heavy_p24, // 0xf0
        bar_pi_long_p27, // 0xf1
        bar_pi_light_p27, // 0xf2
        bar_pi_short_p27, // 0xf3
        mag_pi_large_p27, // 0xf4
        mag_pi_xlarge_p27, // 0xf5
        hammer_sa_p27, // 0xf6
        akimbo_papa220, // 0xf7
        pgrip_aim_p27, // 0xf8
        pgrip_ass_p27, // 0xf9
        pgrip_tac_p27, // 0xfa
        trigger_heavy_p27, // 0xfb
        trigger_hair_p27, // 0xfc
        ironsdefault, // 0xfd
        calsil, // 0xfe
        ironsdefault_mpapa5, // 0xff
        ironsdefault_mpapa7, // 0x100
        ironsdefault_decho, // 0x101
        rec_akilo, // 0x102
        ironsdefault_akilo, // 0x103
        selectsemi_akilo, // 0x104
        ammo_762s, // 0x105
        grip_angled01, // 0x106
        pgrip_p04, // 0x107
        rec_akilo105, // 0x108
        bar_ar_p04, // 0x109
        ironsdefault_akilo105, // 0x10a
        ammo_545s, // 0x10b
        rec_akilo74, // 0x10c
        bar_ar_short_p04, // 0x10d
        ironsdefault_akilo74, // 0x10e
        iw9_rec_augolf, // 0x10f
        bar_ar_heavy_p03, // 0x110
        stock_ar_p03, // 0x111
        mag_ar_p03, // 0x112
        iw9_ironsdefault_augolf, // 0x113
        ammo_556n, // 0x114
        pgrip_p03, // 0x115
        comb_tactical_p03, // 0x116
        rec_kilo53, // 0x117
        bar_ar_p02, // 0x118
        mag_ar_p02, // 0x119
        ironsdefault_kilo53, // 0x11a
        iw9_rec_mcharlie, // 0x11b
        bar_ar_p08, // 0x11c
        bar_ar_long_p08, // 0x11d
        bar_ar_short_p08, // 0x11e
        stock_ar_p08, // 0x11f
        stock_ar_tactical_p08, // 0x120
        stock_sm_p08, // 0x121
        stock_sm_light_p08, // 0x122
        mag_ar_p08, // 0x123
        mag_ar_xlarge_p08, // 0x124
        mag_ar_large_p08, // 0x125
        iw9_ironsdefault_mcharlie, // 0x126
        rec_mike16, // 0x127
        bar_ar_p01, // 0x128
        stock_ar_p01, // 0x129
        mag_ar_p01, // 0x12a
        ironsdefault_mike16, // 0x12b
        pgrip_p01, // 0x12c
        iw9_rec_mike4, // 0x12d
        iw9_ironsdefault_mike4, // 0x12e
        flashlight_box01, // 0x12f
        flashlight_cyl01, // 0x130
        rec_golf3, // 0x131
        ironsdefault_golf3, // 0x132
        selectauto_golf3, // 0x133
        ammo_762n, // 0x134
        rec_schotel, // 0x135
        bar_br_p05, // 0x136
        stock_ar_p05, // 0x137
        pgrip_p05, // 0x138
        rec_msecho, // 0x139
        bar_br_heavy_p01, // 0x13a
        ironsdefault_msecho, // 0x13b
        ammo_458s, // 0x13c
        rec_sa700, // 0x13d
        stockr_dm_p20, // 0x13e
        mag_dm_p20, // 0x13f
        ironsdefault_sa700, // 0x140
        bolt_p20, // 0x141
        iw9_rec_sbeta, // 0x142
        bar_dm_p19, // 0x143
        stockr_dm_p19, // 0x144
        tube_6_45gvt, // 0x145
        ammo_45gvt, // 0x146
        comb_p19, // 0x147
        lever_p19, // 0x148
        rec_xmike2010, // 0x149
        stock_sn_p20, // 0x14a
        ironsdefault_xmike2010, // 0x14b
        ammo_300wm, // 0x14c
        chas_xmike2010, // 0x14d
        iw9_rec_mike14, // 0x14e
        stock_dm_light_p18, // 0x14f
        stock_dm_heavy_p18, // 0x150
        stock_dm_tac_p18, // 0x151
        stockr_dm_p18, // 0x152
        mag_sn_p18, // 0x153
        mag_sn_large_p18, // 0x154
        iw9_ironsdefault_mike14, // 0x155
        pgrip_dm_p18, // 0x156
        pgrip_aim_p18, // 0x157
        pgrip_ass_p18, // 0x158
        pgrip_tac_p18, // 0x159
        comb_tactical_p18, // 0x15a
        comb_ammo_p18, // 0x15b
        comb_ergo_p18, // 0x15c
        rec_mike24, // 0x15d
        ironsdefault_mike24, // 0x15e
        rec_pgolf1, // 0x15f
        bar_sn_p02, // 0x160
        ironsdefault_pgolf1, // 0x161
        rec_alpha57, // 0x162
        bar_sm_p01, // 0x163
        bar_sm_long_p01, // 0x164
        barsil_sm_p01, // 0x165
        stock_sm_light_p01, // 0x166
        stockno_sm_p01, // 0x167
        mag_sm_p01, // 0x168
        ironsdefault_alpha57, // 0x169
        ammo_5x28, // 0x16a
        rec_aviktor, // 0x16b
        bar_sm_p04, // 0x16c
        ironsdefault_aviktor, // 0x16d
        ammo_9p, // 0x16e
        iw9_rec_beta, // 0x16f
        bar_sm_lgtshort_p04, // 0x170
        rec_mpapa5_mp, // 0x171
        bar_sm_p02, // 0x172
        rec_mpapa7, // 0x173
        bar_sm_p09, // 0x174
        stock_sm_light_p09, // 0x175
        mag_sm_p09, // 0x176
        ammo_4x30, // 0x177
        pgrip_p09, // 0x178
        iw9_rec_victor, // 0x179
        bar_sm_short_p10, // 0x17a
        barsil_sm_hvylong_p10, // 0x17b
        bar_sm_p10, // 0x17c
        barsil_sm_long_p10, // 0x17d
        bar_sm_long_p10, // 0x17e
        bar_sm_lgtshort_p10, // 0x17f
        stock_sm_light_p10, // 0x180
        stock_sm_heavy_p10, // 0x181
        stock_sm_p10, // 0x182
        stock_sm_tactical_p10, // 0x183
        stock_sm_lgttactical_p10, // 0x184
        stockno_sm_p10, // 0x185
        mag_p10, // 0x186
        mag_small_p10, // 0x187
        drum_p10, // 0x188
        iw9_ironsdefault_victor, // 0x189
        ammo_45acp, // 0x18a
        pgrip_p10, // 0x18b
        pgrip_ass_p10, // 0x18c
        pgrip_aim_p10, // 0x18d
        pgrip_tac_p10, // 0x18e
        rec_foxtrot, // 0x18f
        bar_lm_p01, // 0x190
        bar_lm_long_p01, // 0x191
        bar_lm_short_p01, // 0x192
        belt_lm_p01, // 0x193
        belt_lm_large_p01, // 0x194
        ironsdefault_foxtrot, // 0x195
        rec_kilo21, // 0x196
        ironsdefault_kilo21, // 0x197
        iw9_rec_mkilo3, // 0x198
        bar_sm_p15, // 0x199
        stock_lm_light_p15, // 0x19a
        belt_lm_p15, // 0x19b
        iw9_ironsdefault_mkilo3, // 0x19c
        pgrip_aim_p15, // 0x19d
        firerate_adverse_p15, // 0x19e
        rec_rkilo, // 0x19f
        bar_lm_p04, // 0x1a0
        stock_lmg_p04, // 0x1a1
        ironsdefault_rkilo, // 0x1a2
        rec_slima, // 0x1a3
        bar_lm_p16, // 0x1a4
        stock_lm_p16, // 0x1a5
        belt_lm_p16, // 0x1a6
        ironsdefault_slima, // 0x1a7
        ammo_338nm, // 0x1a8
        pgrip_p16, // 0x1a9
        rec_la700, // 0x1aa
        stockr_sn_p20, // 0x1ab
        ironsdefault_la700, // 0x1ac
        rec_alpha50, // 0x1ad
        ammo_50b, // 0x1ae
        rec_mromeo, // 0x1af
        bar_sn_p21, // 0x1b0
        stock_sn_p21, // 0x1b1
        mag_sn_p21, // 0x1b2
        pgrip_p21, // 0x1b3
        bolt_p21, // 0x1b4
        rec_limax, // 0x1b5
        bar_sn_heavy_p22, // 0x1b6
        stock_sn_p22, // 0x1b7
        mag_sn_p22, // 0x1b8
        pgrip_p22, // 0x1b9
        rec_decho, // 0x1ba
        bar_pi_p25, // 0x1bb
        barbrake_pi_p25, // 0x1bc
        barcomp_pi_p25, // 0x1bd
        bar_pi_long_p25, // 0x1be
        bar_pi_hvylong_p25, // 0x1bf
        stockno_pi_p25, // 0x1c0
        mag_pi_p25, // 0x1c1
        mag_pi_large_p25, // 0x1c2
        mag_pi_xlarge_p25, // 0x1c3
        ammo_50p, // 0x1c4
        iw9_akimbo_decho, // 0x1c5
        silencer_decho, // 0x1c6
        pgrip_p25, // 0x1c7
        pgrip_aim_p25, // 0x1c8
        pgrip_ass_p25, // 0x1c9
        pgrip_tac_p25, // 0x1ca
        trigger_p25, // 0x1cb
        trigger_light_p25, // 0x1cc
        trigger_heavy_p25, // 0x1cd
        trigger_hair_p25, // 0x1ce
        rec_golf17, // 0x1cf
        rec_auto_golf17, // 0x1d0
        bar_pi_p24, // 0x1d1
        mag_pi_p24, // 0x1d2
        ironsdefault_golf17, // 0x1d3
        pgrip_p24, // 0x1d4
        bar_sm_heavy_p24, // 0x1d5
        ironsdefault_romeo18_pdw, // 0x1d6
        trigger_p24, // 0x1d7
        rec_papa220, // 0x1d8
        bar_pi_p27, // 0x1d9
        mag_pi_p27, // 0x1da
        ironsdefault_papa220, // 0x1db
        hammer_da_p27, // 0x1dc
        pgrip_p27, // 0x1dd
        trigger_light_p27, // 0x1de
        rec_gromeo, // 0x1df
        rec_juliet, // 0x1e0
        rec_kgolf, // 0x1e1
        rec_mike32, // 0x1e2
        rec_rpapa7, // 0x1e3
        hybrid05, // 0x1e4
        hybrid06, // 0x1e5
        ub_glmini01_xmags, // 0x1e6
        ub_gl01_xmags, // 0x1e7
        mag_br_large_p05, // 0x1e8
        ironsdefault_soscar14, // 0x1e9
        iw9_selectsemi, // 0x1ea
        iw9_rec_falpha, // 0x1eb
        bar_ar_p06, // 0x1ec
        bar_ar_long_p06, // 0x1ed
        bar_ar_short_p06, // 0x1ee
        bar_ar_short2_p06, // 0x1ef
        stock_ar_heavy_p06, // 0x1f0
        stock_ar_p06, // 0x1f1
        stock_ar_tactical_p06, // 0x1f2
        mag_ar_p06, // 0x1f3
        mag_ar_large_p06, // 0x1f4
        mag_ar_xlarge_p06, // 0x1f5
        pgrip_p06, // 0x1f6
        pgrip_ass_p06, // 0x1f7
        pgrip_aim_p06, // 0x1f8
        pgrip_tac_p06, // 0x1f9
        comb_p06, // 0x1fa
        comb_tactical_p06, // 0x1fb
        comb_heavy_p06, // 0x1fc
        comb_ergo_p06, // 0x1fd
        rec_fecho, // 0x1fe
        pgrip_ar_ass_p02, // 0x1ff
        pgrip_ar_snp_p02, // 0x200
        pgrip_ar_p02, // 0x201
        pgrip_ar_aim_p02, // 0x202
        pgrip_ar_tac_p02, // 0x203
        iw9_rec_scharlie, // 0x204
        bar_ar_p05, // 0x205
        mag_ar_p05, // 0x206
        mag_ar_large_p05, // 0x207
        mag_ar_xlarge_p05, // 0x208
        iw9_ironsdefault_scharlie, // 0x209
        ub_gl_scharlie, // 0x20a
        rec_scsierra, // 0x20b
        bar_ar_light_p05, // 0x20c
        bar_ar_lgtshort_p05, // 0x20d
        bar_ar_lgtlong_p05, // 0x20e
        stock_sm_light_p05, // 0x20f
        ironsdefault_scsierra, // 0x210
        pgrip_br_ass_p02, // 0x211
        pgrip_br_snp_p02, // 0x212
        pgrip_br_p02, // 0x213
        pgrip_br_aim_p02, // 0x214
        pgrip_br_tac_p02, // 0x215
        selectauto_msecho, // 0x216
        rec_soscar14, // 0x217
        pgrip_dm_ass_p02, // 0x218
        pgrip_dm_aim_p02, // 0x219
        pgrip_dm_p02, // 0x21a
        pgrip_dm_snp_p02, // 0x21b
        pgrip_dm_tac_p02, // 0x21c
        rec_scromeo, // 0x21d
        bar_sn_p05, // 0x21e
        bar_sn_short_p05, // 0x21f
        bar_sn_long_p05, // 0x220
        stock_sn_light_p05, // 0x221
        mag_sn_p05, // 0x222
        mag_sn_large_p05, // 0x223
        mag_sn_xlarge_p05, // 0x224
        ironsdefault_scromeo, // 0x225
        ammo_65cm, // 0x226
        pgrip_sm_ass_p02, // 0x227
        pgrip_sm_p02, // 0x228
        pgrip_sm_aim_p02, // 0x229
        pgrip_sm_tac_p02, // 0x22a
        ammo_762n_db, // 0x22b
        pgrip_lm_ass_p02, // 0x22c
        pgrip_lm_aim_p02, // 0x22d
        pgrip_lm_p02, // 0x22e
        pgrip_lm_tac_p02, // 0x22f
        iw9_rec_charlie725, // 0x230
        bar_sh_p14, // 0x231
        bar_sh_xlong_p14, // 0x232
        bar_sh_long_p14, // 0x233
        bar_sh_short_p14, // 0x234
        stockr_sh_p14, // 0x235
        stockr_sh_tactical_p14, // 0x236
        stockr_sh_assault_p14, // 0x237
        stockr_sh_heavy_p14, // 0x238
        stockno_sh_p14, // 0x239
        ammo_12g_db, // 0x23a
        iw9_ironsdefault_charlie725, // 0x23b
        br_rangeext_shtgn, // 0x23c
        wounded_shotgun, // 0x23d
        rec_mbravo, // 0x23e
        bar_sh_p13, // 0x23f
        bar_sh_heavy_p13, // 0x240
        bar_sh_light_p13, // 0x241
        bar_sh_short_p13, // 0x242
        bar_sh_hvylong_p13, // 0x243
        bar_sh_hvyshort_p13, // 0x244
        stockr_sh_p13, // 0x245
        stockr_sh_heavy_p13, // 0x246
        stock_sh_heavy_p13, // 0x247
        stock_sh_tactical_p13, // 0x248
        stock_sh_light_p13, // 0x249
        stockno_sh_p13, // 0x24a
        stockno_sh_light_p13, // 0x24b
        ironsdefault_mbravo, // 0x24c
        guard_p13, // 0x24d
        guard_chainsaw_p13, // 0x24e
        guard_vert_p13, // 0x24f
        guard_tactical_p13, // 0x250
        guard_angled_p13, // 0x251
        guard_heavy_p13, // 0x252
        guard_light_p13, // 0x253
        iw9_minireddot01_tall, // 0x254
        iw9_minireddot02_tall, // 0x255
        iw9_minireddot03_tall, // 0x256
        iw9_minireddot04_tall, // 0x257
        iw9_minireddot05_tall, // 0x258
        iw9_minireddot06_tall, // 0x259
        iw9_minireddot07_tall, // 0x25a
        reflex01_tall, // 0x25b
        reflex02_tall, // 0x25c
        reflex03_tall, // 0x25d
        reflex04_tall, // 0x25e
        reflex05_tall, // 0x25f
        reflex06_tall, // 0x260
        reflex07_tall, // 0x261
        reflex08_tall, // 0x262
        reflex09_tall, // 0x263
        holo04, // 0x264
        holo05, // 0x265
        holo06, // 0x266
        holotherm01, // 0x267
        holorange01, // 0x268
        fourx04, // 0x269
        fourx05, // 0x26a
        fourxtherm01, // 0x26b
        fourxtherm02, // 0x26c
        fourxtherm03, // 0x26d
        fourxtherm04, // 0x26e
        hybrid07, // 0x26f
        hybridrange01, // 0x270
        hybridtherm01, // 0x271
        arscope01, // 0x272
        arscope02, // 0x273
        arscope_vz01, // 0x274
        arscope_vz02, // 0x275
        arscope_nvgvz01, // 0x276
        arscope_nvg01, // 0x277
        arscope_nvg02, // 0x278
        arscope_therm01, // 0x279
        hybridscope_ar01, // 0x27a
        barsil_ar_p08, // 0x27b
        bar_ar_hvy_short_p08, // 0x27c
        mag_ar_heavy_p08, // 0x27d
        mag_ar_hvysmall_p08, // 0x27e
        mag_ar_hvylarge_p08, // 0x27f
        ironsdefault_mcbravo, // 0x280
        ammo_blk, // 0x281
        pgrip_ar2_p08, // 0x282
        pgrip_ar2_aim_p08, // 0x283
        pgrip_ar2_ass_p08, // 0x284
        pgrip_ar2_tac_p08, // 0x285
        rec_mcbravo, // 0x286
        pgrip_ar_p08, // 0x287
        pgrip_ar_aim_p08, // 0x288
        pgrip_ar_ass_p08, // 0x289
        pgrip_ar_tac_p08, // 0x28a
        bar_ar_lgtshort_p01, // 0x28b
        dmscope01, // 0x28c
        dmscope_vz01, // 0x28d
        dmscope_vz02, // 0x28e
        dmscope_therm01, // 0x28f
        vzscope_dm_01_2x, // 0x290
        dynamic_null_equipment, // 0x291
        iw9_me_knife, // 0x292
        iw9_minireddot05, // 0x293
        iw9_minireddot06, // 0x294
        reflex05, // 0x295
        reflex06, // 0x296
        reflex07, // 0x297
        reflex08, // 0x298
        reflex09, // 0x299
        shscope01, // 0x29a
        shscope02, // 0x29b
        snscope01, // 0x29c
        snscope_vz01, // 0x29d
        snscope_therm01, // 0x29e
        snscope_rf01, // 0x29f
        snscope_drop01, // 0x2a0
        selectauto_soscar, // 0x2a1
        ballistics_nogravity_mike14, // 0x2a2
        me_hatchet02, // 0x2a3
        bar_lm_p03, // 0x2a4
        barsil_lm_p03, // 0x2a5
        bar_lm_heavy_p03, // 0x2a6
        ironsdefault_ahotel, // 0x2a7
        rec_ahotel, // 0x2a8
        dynamic_null_dblmg, // 0x2a9
        bar_lm_short_p17, // 0x2aa
        bar_lm_p17, // 0x2ab
        bar_lm_long_p17, // 0x2ac
        stock_lm_p17, // 0x2ad
        stock_lm_heavy_p17, // 0x2ae
        stock_lm_assault_p17, // 0x2af
        stock_lm_light_p17, // 0x2b0
        belt_lm_p17, // 0x2b1
        belt_lm_large_p17, // 0x2b2
        belt_lm_xlarge_p17, // 0x2b3
        ironsdefault_ngolf7, // 0x2b4
        pgrip_p17, // 0x2b5
        pgrip_ass_p17, // 0x2b6
        pgrip_aim_p17, // 0x2b7
        pgrip_tac_p17, // 0x2b8
        rec_ngolf7, // 0x2b9
        ammo_45acp_notracer, // 0x2ba
        ammo_12g, // 0x2bb
        bar_sh_light_p12, // 0x2bc
        bar_sh_short_p12, // 0x2bd
        bartube_sh_short_p12, // 0x2be
        bartube_sh_p12, // 0x2bf
        bar_sh_heavy_p12, // 0x2c0
        stock_sh_light_p12, // 0x2c1
        stockno_sh_p12, // 0x2c2
        stockr_sh_heavy_p12, // 0x2c3
        stock_sh_p12, // 0x2c4
        ironsdefault_mike1014, // 0x2c5
        pgrip_p12, // 0x2c6
        pgrip_aim_p12, // 0x2c7
        pgrip_ass_p12, // 0x2c8
        pgrip_tac_p12, // 0x2c9
        bolt_p12, // 0x2ca
        rec_mike1014, // 0x2cb
        mag_sh_p13, // 0x2cc
        mag_sh_small_p13, // 0x2cd
        mag_sh_large_p13, // 0x2ce
        ironsdefault_mviktor, // 0x2cf
        rec_mviktor, // 0x2d0
        ironsdefault_apapa, // 0x2d1
        rec_apapa, // 0x2d2
        bar_sm_p08, // 0x2d3
        bar_sm_long_p08, // 0x2d4
        barsil_sm_p08, // 0x2d5
        bar_sm_short_p08, // 0x2d6
        bar_sm_lgtshort_p08, // 0x2d7
        stockno_sm_p08, // 0x2d8
        mag_sm_p08, // 0x2d9
        mag_sm_small_p08, // 0x2da
        drum_sm_p08, // 0x2db
        ironsdefault_mpapax, // 0x2dc
        pgrip_sm_p08, // 0x2dd
        pgrip_sm_aim_p08, // 0x2de
        pgrip_sm_ass_p08, // 0x2df
        pgrip_sm_tac_p08, // 0x2e0
        rec_mpapax, // 0x2e1
        bar_sm_short_p07, // 0x2e2
        bar_sm_p07, // 0x2e3
        bar_sm_long_p07, // 0x2e4
        bar_sm_heavy_p07, // 0x2e5
        bar_sm_hvylong_p07, // 0x2e6
        barsil_sm_p07, // 0x2e7
        barsil_sm_long_p07, // 0x2e8
        stock_sm_light_p07, // 0x2e9
        mag_sm_p07, // 0x2ea
        iw9_ironsdefault_papa90, // 0x2eb
        pgrip_p07, // 0x2ec
        pgrip_aim_p07, // 0x2ed
        pgrip_ass_p07, // 0x2ee
        pgrip_tac_p07, // 0x2ef
        comb_tactical_p07, // 0x2f0
        comb_ergo_p07, // 0x2f1
        comb_heavy_p07, // 0x2f2
        iw9_rec_papa90, // 0x2f3
        bar_sm_p11, // 0x2f4
        bar_sm_short_p11, // 0x2f5
        bar_sm_heavy_p11, // 0x2f6
        bar_sm_hvylong_p11, // 0x2f7
        bar_sm_long_p11, // 0x2f8
        bar_sm_long2_p11, // 0x2f9
        stock_sm_light_p11, // 0x2fa
        stock_sm_assault_p11, // 0x2fb
        stock_sm_heavy_p11, // 0x2fc
        stock_sm_lgttactical_p11, // 0x2fd
        stock_sm_tactical_p11, // 0x2fe
        stockno_sm_p11, // 0x2ff
        mag_sm_p11, // 0x300
        mag_sm_xlarge_p11, // 0x301
        mag_sm_large_p11, // 0x302
        pgrip_p11, // 0x303
        pgrip_aim_p11, // 0x304
        pgrip_ass_p11, // 0x305
        pgrip_tac_p11, // 0x306
        iw9_rec_uzulu, // 0x307
        bar_sn_p23, // 0x308
        bar_sn_long_p23, // 0x309
        bar_sn_short_p23, // 0x30a
        bar_sn_heavy_p23, // 0x30b
        bar_sn_hvyshort_p23, // 0x30c
        stock_sn_p23, // 0x30d
        stock_sn_heavy_p23, // 0x30e
        stock_sn_tac_p23, // 0x30f
        stock_sn_assault_p23, // 0x310
        mag_sn_p23, // 0x311
        mag_sn_large_p23, // 0x312
        mag_sn_xlarge_p23, // 0x313
        pgrip_aim_p23, // 0x314
        pgrip_ass_p23, // 0x315
        pgrip_tac_p23, // 0x316
        pgrip_aim_stockass_p23, // 0x317
        pgrip_aim_stockhvyass_p23, // 0x318
        pgrip_aim_stocksn_p23, // 0x319
        pgrip_aim_stocktac_p23, // 0x31a
        pgrip_ass_stockass_p23, // 0x31b
        pgrip_ass_stockhvyass_p23, // 0x31c
        pgrip_ass_stocksn_p23, // 0x31d
        pgrip_ass_stocktac_p23, // 0x31e
        pgrip_tac_stockass_p23, // 0x31f
        pgrip_tac_stockhvy_p23, // 0x320
        pgrip_tac_stocksn_p23, // 0x321
        pgrip_tac_stocktac_p23, // 0x322
        bgrip_sn_p23, // 0x323
        bgrip_sn_hvy_p23, // 0x324
        dynamic_null_spotterscope, // 0x325
        dynamic_null_launcher, // 0x326
        dynamic_null_gromeo, // 0x327
        dynamic_null_juliette, // 0x328
        xmags_cp_juliet, // 0x329
        dynamic_null_kgolf, // 0x32a
        dynamic_null_mike32, // 0x32b
        dynamic_null_rpapa7, // 0x32c
        laserbox_ads01, // 0x32d
        laserbox_ads02, // 0x32e
        laserbox_ads03, // 0x32f
        laserbox_ads04, // 0x330
        laserbox_ads05, // 0x331
        laserbox_hip01, // 0x332
        laserbox_hip02, // 0x333
        laserbox_hip03, // 0x334
        laserbox_hip04, // 0x335
        flashlight_box02, // 0x336
        lasercyl_ads01, // 0x337
        lasercyl_ads02, // 0x338
        lasercyl_ads03, // 0x339
        lasercyl_ads04, // 0x33a
        lasercyl_ads05, // 0x33b
        lasercyl_hip01, // 0x33c
        lasercyl_hip02, // 0x33d
        lasercyl_hip03, // 0x33e
        lasercyl_hip04, // 0x33f
        flashlight_cyl02, // 0x340
        laserpstl_ads01, // 0x341
        laserpstl_ads02, // 0x342
        laserpstl_hip01, // 0x343
        laserpstl_hip02, // 0x344
        flashlight_pstl01, // 0x345
        flashlight_pstl02, // 0x346
        ammo_762s_fr, // 0x347
        ammo_762s_hp, // 0x348
        ammo_762s_tr, // 0x349
        ammo_762s_ap, // 0x34a
        ammo_762s_op, // 0x34b
        ammo_762s_hv, // 0x34c
        ammo_762s_db, // 0x34d
        ammo_545s_fr, // 0x34e
        ammo_545s_hp, // 0x34f
        ammo_545s_tr, // 0x350
        ammo_545s_ap, // 0x351
        ammo_545s_op, // 0x352
        ammo_545s_hv, // 0x353
        ammo_556n_fr, // 0x354
        ammo_556n_hp, // 0x355
        ammo_556n_tr, // 0x356
        ammo_556n_ap, // 0x357
        ammo_556n_op, // 0x358
        ammo_556n_hv, // 0x359
        ammo_556n_db, // 0x35a
        ammo_762n_fr, // 0x35b
        ammo_762n_hp, // 0x35c
        ammo_762n_tr, // 0x35d
        ammo_762n_ap, // 0x35e
        ammo_762n_op, // 0x35f
        ammo_762n_hv, // 0x360
        stock_ar_light_p08, // 0x361
        ammo_blk_fr, // 0x362
        ammo_blk_hp, // 0x363
        ammo_blk_ap, // 0x364
        ammo_blk_op, // 0x365
        ammo_12g_sl, // 0x366
        ammo_12g_he, // 0x367
        ammo_458s_fr, // 0x368
        ammo_458s_hp, // 0x369
        ammo_458s_tr, // 0x36a
        ammo_458s_ap, // 0x36b
        ammo_458s_op, // 0x36c
        ammo_458s_hv, // 0x36d
        ammo_300wm_fr, // 0x36e
        ammo_300wm_hp, // 0x36f
        ammo_300wm_ap, // 0x370
        ammo_300wm_op, // 0x371
        ammo_300wm_hv, // 0x372
        ammo_300wm_db, // 0x373
        ammo_45gvt_fr, // 0x374
        ammo_45gvt_hp, // 0x375
        ammo_45gvt_ap, // 0x376
        ammo_45gvt_op, // 0x377
        ammo_45gvt_hv, // 0x378
        ammo_45gvt_db, // 0x379
        ammo_65c_hp, // 0x37a
        ammo_65c_ap, // 0x37b
        ammo_65c_fr, // 0x37c
        ammo_65c_op, // 0x37d
        ammo_65c_hv, // 0x37e
        ammo_65c_db, // 0x37f
        ammo_338nm_fr, // 0x380
        ammo_338nm_hp, // 0x381
        ammo_338nm_ap, // 0x382
        ammo_338nm_op, // 0x383
        ammo_338nm_hv, // 0x384
        ammo_338nm_db, // 0x385
        ammo_50p_fr, // 0x386
        ammo_50p_hp, // 0x387
        ammo_50p_tr, // 0x388
        ammo_50p_ap, // 0x389
        ammo_50p_op, // 0x38a
        ammo_9p_fr, // 0x38b
        ammo_9p_hp, // 0x38c
        ammo_9p_tr, // 0x38d
        ammo_9p_ap, // 0x38e
        ammo_9p_op, // 0x38f
        trigger_heavy_p24, // 0x390
        trigger_light_p24, // 0x391
        trigger_hair_p24, // 0x392
        ammo_45acp_fr, // 0x393
        ammo_45acp_hp, // 0x394
        ammo_45acp_ap, // 0x395
        ammo_45acp_op, // 0x396
        ammo_5x28_fr, // 0x397
        ammo_5x28_hp, // 0x398
        ammo_5x28_tr, // 0x399
        ammo_5x28_ap, // 0x39a
        ammo_5x28_op, // 0x39b
        ammo_4x30_fr, // 0x39c
        ammo_4x30_hp, // 0x39d
        ammo_4x30_tr, // 0x39e
        ammo_4x30_ap, // 0x39f
        ammo_4x30_op, // 0x3a0
        ammo_50b_fr, // 0x3a1
        ammo_50b_ap, // 0x3a2
        ammo_50b_hv, // 0x3a3
        ammo_50b_db, // 0x3a4
        ammo_50b_he, // 0x3a5
        laserir_box, // 0x3a6
        laserir_cyl, // 0x3a7
        laserir_pstl, // 0x3a8
        bar_dm_p38, // 0x3a9
        bar_dm_heavy_p38, // 0x3aa
        bar_dm_light_p38, // 0x3ab
        bar_dm_hvyass_p38, // 0x3ac
        bar_dm_tac_p38, // 0x3ad
        stock_dm_p38, // 0x3ae
        stock_dm_heavy_p38, // 0x3af
        stock_dm_light_p38, // 0x3b0
        stock_dm_hvyass_p38, // 0x3b1
        stock_dm_tac_p38, // 0x3b2
        mag_dm_p38, // 0x3b3
        iw9_ironsdefault_crossbow, // 0x3b4
        ammo_bolt_std, // 0x3b5
        ammo_bolt_fr, // 0x3b6
        ammo_bolt_he, // 0x3b7
        ammo_bolt_stun, // 0x3b8
        bgrip_p38, // 0x3b9
        wire_dm_p38, // 0x3ba
        wire_hvy_p38, // 0x3bb
        wire_lgt_p38, // 0x3bc
        iw9_rec_crossbow, // 0x3bd
        bar_pi_xshort_p26, // 0x3be
        bar_pi_short_p26, // 0x3bf
        bar_pi_p26, // 0x3c0
        bar_pi_light_p26, // 0x3c1
        bar_pi_long_p26, // 0x3c2
        cylinder_pi_p26, // 0x3c3
        ironsdefault_swhiskey, // 0x3c4
        piscope01, // 0x3c5
        speedloader_hvy_p26, // 0x3c6
        speedloader_lgt_p26, // 0x3c7
        ammo_500sw, // 0x3c8
        ammo_500sw_ap, // 0x3c9
        ammo_500sw_fr, // 0x3ca
        ammo_500sw_hp, // 0x3cb
        ammo_500sw_op, // 0x3cc
        ammo_500sw_ss, // 0x3cd
        pgrip_p26, // 0x3ce
        pgrip_ass_p26, // 0x3cf
        pgrip_aim_p26, // 0x3d0
        pgrip_tac_p26, // 0x3d1
        trigger_p26, // 0x3d2
        trigger_hair_p26, // 0x3d3
        trigger_heavy_p26, // 0x3d4
        trigger_light_p26, // 0x3d5
        laserhip_dim_p26, // 0x3d6
        laserhip_bright_p26, // 0x3d7
        laserads_bright_p26, // 0x3d8
        rec_swhiskey, // 0x3d9
        ub_gl_akilo, // 0x3da
        grip_angled03, // 0x3db
        grip_angled04, // 0x3dc
        grip_angled05, // 0x3dd
        grip_angled06, // 0x3de
        grip_angled07, // 0x3df
        grip_angled08, // 0x3e0
        grip_angled09, // 0x3e1
        grip_angled10, // 0x3e2
        grip_angled11, // 0x3e3
        grip_angled12, // 0x3e4
        grip_angled13, // 0x3e5
        grip_angled14, // 0x3e6
        grip_vert04, // 0x3e7
        grip_vert05, // 0x3e8
        grip_vertshort03, // 0x3e9
        grip_vertshort04, // 0x3ea
        grip_vertshort05, // 0x3eb
        bipod01, // 0x3ec
        bipod02, // 0x3ed
        bipod03, // 0x3ee
        bipodgrip_small, // 0x3ef
        grip_vertshort06, // 0x3f0
        grip_vertshort07, // 0x3f1
        bgrip_hvy_p03, // 0x3f2
        bgrip_lgt_p03, // 0x3f3
        rail_ar_large_p06, // 0x3f4
        wounded_ar, // 0x3f5
        selectsemi_schotel, // 0x3f6
        wounded_dmr, // 0x3f7
        wounded_pistol, // 0x3f8
        onehand, // 0x3f9
        wounded_sniper, // 0x3fa
        guard_p19, // 0x3fb
        guard_heavy_p19, // 0x3fc
        guard_light_p19, // 0x3fd
        guard_tactical_p19, // 0x3fe
        bipod_ahotel, // 0x3ff
        laserads_bright_dblmg, // 0x400
        bipod_mkilo3, // 0x401
        gripside_large_p17, // 0x402
        gripside_med_p17, // 0x403
        gripside_small_p17, // 0x404
        bipod_ngolf7, // 0x405
        bipod_rkilo, // 0x406
        gripside_small_p16, // 0x407
        gripside_med_p16, // 0x408
        gripside_large_p16, // 0x409
        bipod_slima, // 0x40a
        iw9_me_hammer, // 0x40b
        onehand_decho, // 0x40c
        akimbo_golf17, // 0x40d
        onehand_mike1911, // 0x40e
        guard_p14, // 0x40f
        guard_heavy_p14, // 0x410
        guard_light_p14, // 0x411
        guard_tactical_p14, // 0x412
        guard_p12, // 0x413
        guard_light_p12, // 0x414
        guard_tactical_p12, // 0x415
        guard_heavy_p12, // 0x416
        rail_sm_p07, // 0x417
        railreflex_sm_p07, // 0x418
        rail_sm_small_p07, // 0x419
        grip_vert_uzulu, // 0x41a
        ammo_50b_intercept, // 0x41b
        mod_infil_alpha50, // 0x41c
        ammo_50b_shipaf, // 0x41d
        ub_gl_akilo_xmags, // 0x41e
        flash_br_01, // 0x41f
        flash_br_02, // 0x420
        flash_br_03, // 0x421
        silencer01_br, // 0x422
        silencer02_br, // 0x423
        silencer03_br, // 0x424
        silencer04_br, // 0x425
        silencer05_br, // 0x426
        silencer06_br, // 0x427
        silencer07_br, // 0x428
        comp_br_01, // 0x429
        comp_br_02, // 0x42a
        comp_br_03, // 0x42b
        comp_br_04, // 0x42c
        comp_br_05, // 0x42d
        comp_br_06, // 0x42e
        breacher_br_01, // 0x42f
        breacher_br_02, // 0x430
        flash_ar_01, // 0x431
        flash_ar_02, // 0x432
        flash_ar_03, // 0x433
        flash_ar_04, // 0x434
        silencer01_ar, // 0x435
        silencer02_ar, // 0x436
        silencer03_ar, // 0x437
        silencer04_ar, // 0x438
        silencer05_ar, // 0x439
        silencer06_ar, // 0x43a
        silencer07_ar, // 0x43b
        silencer08_ar, // 0x43c
        comp_ar_01, // 0x43d
        comp_ar_02, // 0x43e
        comp_ar_03, // 0x43f
        comp_ar_04, // 0x440
        comp_ar_05, // 0x441
        comp_ar_06, // 0x442
        comp_ar_07, // 0x443
        comp_ar_08, // 0x444
        breacher_ar_01, // 0x445
        breacher_ar_02, // 0x446
        silencer01_pi, // 0x447
        silencer02_pi, // 0x448
        silencer03_pi, // 0x449
        silencer04_pi, // 0x44a
        comp_pi_01, // 0x44b
        comp_pi_02, // 0x44c
        comp_pi_03, // 0x44d
        comp_pi_04, // 0x44e
        comp_pi_05, // 0x44f
        comp_pi_06, // 0x450
        flash_pi_01, // 0x451
        flash_pi_02, // 0x452
        breacher_pi_01, // 0x453
        silencer01_sh, // 0x454
        silencer02_sh, // 0x455
        silencer03_sh, // 0x456
        silencer04_sh, // 0x457
        comp_sh_01, // 0x458
        comp_sh_02, // 0x459
        comp_sh_03, // 0x45a
        flash_sh_01, // 0x45b
        flash_sh_02, // 0x45c
        breacher_sh_01, // 0x45d
        breacher_sh_02, // 0x45e
        choke_sh01, // 0x45f
        choke_sh02, // 0x460
        choke_sh03, // 0x461
        choke_sh04, // 0x462
        silencer01_sm, // 0x463
        silencer02_sm, // 0x464
        silencer03_sm, // 0x465
        silencer04_sm, // 0x466
        silencer05_sm, // 0x467
        silencer06_sm, // 0x468
        silencer07_sm, // 0x469
        comp_sm_01, // 0x46a
        comp_sm_02, // 0x46b
        comp_sm_03, // 0x46c
        comp_sm_04, // 0x46d
        comp_sm_05, // 0x46e
        comp_sm_06, // 0x46f
        comp_sm_07, // 0x470
        comp_sm_08, // 0x471
        flash_sm_01, // 0x472
        flash_sm_02, // 0x473
        breacher_sm_01, // 0x474
        flash_dm_01, // 0x475
        flash_dm_02, // 0x476
        flash_dm_03, // 0x477
        flash_dm_04, // 0x478
        silencer01_dm, // 0x479
        silencer02_dm, // 0x47a
        silencer03_dm, // 0x47b
        silencer04_dm, // 0x47c
        silencer05_dm, // 0x47d
        silencer06_dm, // 0x47e
        comp_dm_01, // 0x47f
        comp_dm_02, // 0x480
        comp_dm_03, // 0x481
        comp_dm_04, // 0x482
        comp_dm_05, // 0x483
        comp_decho_01, // 0x484
        comp_decho_02, // 0x485
        comp_decho_03, // 0x486
        comp_decho_04, // 0x487
        flash_decho_01, // 0x488
        comp_swhiskey_01, // 0x489
        comp_swhiskey_02, // 0x48a
        comp_swhiskey_03, // 0x48b
        flash_swhiskey_01, // 0x48c
        silencer1_charlie725, // 0x48d
        silencer2_charlie725, // 0x48e
        silencer3_charlie725, // 0x48f
        comp_charlie725_01, // 0x490
        comp_charlie725_02, // 0x491
        breacher_charlie725_01, // 0x492
        charlie725_choke01, // 0x493
        charlie725_choke02, // 0x494
        charlie725_choke03, // 0x495
        charlie725_choke04, // 0x496
        comb_heavy_p12, // 0x497
        comb_ammo_p12, // 0x498
        silencer1_uzulu, // 0x499
        silencer2_uzulu, // 0x49a
        silencer1_victor, // 0x49b
        silencer01_sn, // 0x49c
        silencer02_sn, // 0x49d
        silencer03_sn, // 0x49e
        silencer04_sn, // 0x49f
        silencer05_sn, // 0x4a0
        comp_sn_01, // 0x4a1
        comp_sn_02, // 0x4a2
        comp_sn_03, // 0x4a3
        flash_sn_01, // 0x4a4
        flash_sn_02, // 0x4a5
        bar_sn_hvylong_p22, // 0x4a6
        vzscope_mromeo, // 0x4a7
        selectburst_mpapa5, // 0x4a8
        bar_lm_light_p04_akilo, // 0x4a9
        bar_ar_hvylong_p04_akilo, // 0x4aa
        bar_ar_long_p04_akilo, // 0x4ab
        bar_ar_heavy_p04_akilo, // 0x4ac
        bar_ar_p04_akilo, // 0x4ad
        bar_ar_hvyshort_p04_akilo, // 0x4ae
        stock_lmg_p04_akilo, // 0x4af
        stock_ar_p04_akilo, // 0x4b0
        stock_ar_tactical_p04_akilo, // 0x4b1
        stock_sm_p04_akilo, // 0x4b2
        stock_ar_light_p04_akilo, // 0x4b3
        bar_ar_hvylong_p04_akilo105, // 0x4b4
        bar_ar_long_p04_akilo105, // 0x4b5
        bar_ar_heavy_p04_akilo105, // 0x4b6
        bar_ar_p04_akilo105, // 0x4b7
        bar_ar_hvyshort_p04_akilo105, // 0x4b8
        stock_lmg_p04_akilo105, // 0x4b9
        stock_ar_heavy_p04_akilo105, // 0x4ba
        stock_ar_p04_akilo105, // 0x4bb
        stock_ar_tactical_p04_akilo105, // 0x4bc
        stock_sm_p04_akilo105, // 0x4bd
        stock_ar_light_p04_akilo105, // 0x4be
        stock_lmg_p04_akilo74, // 0x4bf
        stock_ar_heavy_p04_akilo74, // 0x4c0
        stock_ar_p04_akilo74, // 0x4c1
        stock_ar_tactical_p04_akilo74, // 0x4c2
        stock_sm_p04_akilo74, // 0x4c3
        stock_sm_light_p04_akilo74, // 0x4c4
        stockno_sm_p04_akilo74, // 0x4c5
        barsil_lm_p03_augolf, // 0x4c6
        bar_lm_heavy_p03_augolf, // 0x4c7
        bar_ar_heavy_p03_augolf, // 0x4c8
        bargrip_ar_long_p03_augolf, // 0x4c9
        bar_ar_long_p03_augolf, // 0x4ca
        bar_ar_p03_augolf, // 0x4cb
        bar_ar_light_p03_augolf, // 0x4cc
        stock_ar_p03_augolf, // 0x4cd
        stock_sm_p03_augolf, // 0x4ce
        stock_lm_p03_augolf, // 0x4cf
        bar_lm_long_p02_golf3, // 0x4d0
        bar_br_p02_golf3, // 0x4d1
        bar_ar_p02_golf3, // 0x4d2
        bar_br_light_p02_golf3, // 0x4d3
        bar_lm_short_p02_golf3, // 0x4d4
        bar_ar_short_p02_golf3, // 0x4d5
        bar_lm_p02_golf3, // 0x4d6
        stock_sn_p02_golf3, // 0x4d7
        stock_lm_p02_golf3, // 0x4d8
        stock_ar_p02_golf3, // 0x4d9
        stock_ar_assault_p02_golf3, // 0x4da
        stock_ar_tactical_p02_golf3, // 0x4db
        stock_sm_p02_golf3, // 0x4dc
        bar_ar_p02_kilo53, // 0x4dd
        bar_br_light_p02_kilo53, // 0x4de
        bar_lm_short_p02_kilo53, // 0x4df
        bar_ar_short_p02_kilo53, // 0x4e0
        bar_lm_p02_kilo53, // 0x4e1
        stock_sn_p02_kilo53, // 0x4e2
        stock_lm_p02_kilo53, // 0x4e3
        stock_ar_p02_kilo53, // 0x4e4
        stock_ar_assault_p02_kilo53, // 0x4e5
        stock_ar_tactical_p02_kilo53, // 0x4e6
        stock_sm_p02_kilo53, // 0x4e7
        bar_ar_longhvy_p01_mike16, // 0x4e8
        bar_ar_heavy_p01_mike16, // 0x4e9
        bar_ar_p01_mike16, // 0x4ea
        bar_ar_shorthvy_p01_mike16, // 0x4eb
        bar_ar_short_p01_mike16, // 0x4ec
        stock_ar_p01_mike16, // 0x4ed
        stock_ar_tactical_p01_mike16, // 0x4ee
        stock_ar_light_p01_mike16, // 0x4ef
        stock_ar_assault_p01_mike16, // 0x4f0
        stock_sn_p01_mike16, // 0x4f1
        bar_ar_heavy_p01_mike4, // 0x4f2
        bar_ar_lgtshort_p01_mike4, // 0x4f3
        bar_ar_light_p01_mike4, // 0x4f4
        bar_ar_long_p01_mike4, // 0x4f5
        bar_ar_longhvy_p01_mike4, // 0x4f6
        bar_ar_p01_mike4, // 0x4f7
        bar_ar_short_p01_mike4, // 0x4f8
        bar_ar_shorthvy_p01_mike4, // 0x4f9
        stock_ar_p01_mike4, // 0x4fa
        stock_ar_tactical_p01_mike4, // 0x4fb
        stock_ar_light_p01_mike4, // 0x4fc
        stock_sm_p01_mike4, // 0x4fd
        stock_ar_assault_p01_mike4, // 0x4fe
        stock_sn_p01_mike4, // 0x4ff
        bar_ar_light_p01_msecho, // 0x500
        bar_ar_p01_msecho, // 0x501
        bar_ar_long_p01_msecho, // 0x502
        bar_ar_lgtshort_p01_msecho, // 0x503
        stock_ar_p01_msecho, // 0x504
        stock_ar_tactical_p01_msecho, // 0x505
        stock_ar_light_p01_msecho, // 0x506
        bar_sn_heavy_p20_la700, // 0x507
        bar_sn_p20_la700, // 0x508
        bar_sn_light_p20_la700, // 0x509
        bar_dm_p20_la700, // 0x50a
        comb_ammo_p20, // 0x50b
        fourxtherm04_highzoom, // 0x50c
        bar_sn_p20_mike24, // 0x50d
        bar_sn_light_p20_mike24, // 0x50e
        barsil_dm_p20_mike24, // 0x50f
        bar_dm_p20_mike24, // 0x510
        bar_dm_short_p20_mike24, // 0x511
        bar_dm_light_p20_mike24, // 0x512
        bar_br_p02_pgolf1, // 0x513
        bar_ar_p02_pgolf1, // 0x514
        stock_sn_p02_pgolf1, // 0x515
        stock_lm_p02_pgolf1, // 0x516
        stock_ar_p02_pgolf1, // 0x517
        stock_ar_assault_p02_pgolf1, // 0x518
        stock_ar_tactical_p02_pgolf1, // 0x519
        barsil_dm_p20_sa700, // 0x51a
        bar_dm_p20_sa700, // 0x51b
        bar_dm_short_p20_sa700, // 0x51c
        bar_dm_light_p20_sa700, // 0x51d
        fourxtherm02_highzoom, // 0x51e
        bar_sn_heavy_p20_xmike2010, // 0x51f
        bar_sn_p20_xmike2010, // 0x520
        bar_sn_light_p20_xmike2010, // 0x521
        bar_dm_p20_xmike2010, // 0x522
        barsil_lm_p03_ahotel, // 0x523
        bar_lm_heavy_p03_ahotel, // 0x524
        bar_ar_heavy_p03_ahotel, // 0x525
        bargrip_ar_long_p03_ahotel, // 0x526
        stock_ar_p03_ahotel, // 0x527
        stock_sm_p03_ahotel, // 0x528
        stock_lm_p03_ahotel, // 0x529
        stock_ar_p01_foxtrot, // 0x52a
        stock_ar_tactical_p01_foxtrot, // 0x52b
        stock_ar_light_p01_foxtrot, // 0x52c
        stock_ar_assault_p01_foxtrot, // 0x52d
        stock_sn_p01_foxtrot, // 0x52e
        bar_lm_long_p02_kilo21, // 0x52f
        bar_br_p02_kilo21, // 0x530
        bar_ar_p02_kilo21, // 0x531
        bar_lm_short_p02_kilo21, // 0x532
        bar_lm_p02_kilo21, // 0x533
        stock_lm_p02_kilo21, // 0x534
        stock_ar_p02_kilo21, // 0x535
        stock_ar_assault_p02_kilo21, // 0x536
        stock_ar_tactical_p02_kilo21, // 0x537
        bar_lm_light_p04_rkilo, // 0x538
        bar_ar_hvylong_p04_rkilo, // 0x539
        stock_lmg_p04_rkilo, // 0x53a
        stock_ar_heavy_p04_rkilo, // 0x53b
        stock_ar_light_p04_rkilo, // 0x53c
        rec_golf18, // 0x53d
        akimbo_swhiskey, // 0x53e
        comp_charlie725_03, // 0x53f
        bartube_sh_heavy_p13, // 0x540
        bartube_sh_hvylong_p13, // 0x541
        bartube_sh_hvyshort_p13, // 0x542
        bartube_sh_lgtshort_p13, // 0x543
        bartube_sh_light_p13, // 0x544
        bartube_sh_p13, // 0x545
        bartube_sh_short_p13, // 0x546
        bolt_lgt_p12, // 0x547
        bolt_hvy_p12, // 0x548
        stock_ar_p01_alpha57, // 0x549
        stock_ar_tactical_p01_alpha57, // 0x54a
        stock_ar_light_p01_alpha57, // 0x54b
        stock_sm_p01_alpha57, // 0x54c
        bar_ar_long_p03_apapa, // 0x54d
        bar_ar_p03_apapa, // 0x54e
        bar_ar_light_p03_apapa, // 0x54f
        stock_ar_p03_apapa, // 0x550
        stock_sm_p03_apapa, // 0x551
        stock_lm_p03_apapa, // 0x552
        ammo_9s, // 0x553
        ammo_9s_fr, // 0x554
        ammo_9s_hp, // 0x555
        ammo_9s_ap, // 0x556
        ammo_9s_op, // 0x557
        stock_ar_p04_aviktor, // 0x558
        stock_ar_tactical_p04_aviktor, // 0x559
        stock_sm_p04_aviktor, // 0x55a
        stock_sm_light_p04_aviktor, // 0x55b
        stockno_sm_p04_aviktor, // 0x55c
        stock_ar_p04_beta, // 0x55d
        stock_ar_tactical_p04_beta, // 0x55e
        stock_sm_p04_beta, // 0x55f
        stock_sm_light_p04_beta, // 0x560
        stockno_sm_p04_beta, // 0x561
        ammo_9m, // 0x562
        ammo_9m_fr, // 0x563
        ammo_9m_hp, // 0x564
        ammo_9m_ap, // 0x565
        ammo_9m_op, // 0x566
        stock_ar_p02_mpapa5, // 0x567
        stock_ar_assault_p02_mpapa5, // 0x568
        stock_ar_tactical_p02_mpapa5, // 0x569
        stock_sm_p02_mpapa5, // 0x56a
        mag_ar_p04, // 0x56b
        mag_ar_small_p04, // 0x56c
        mag_ar_large_p04, // 0x56d
        mag_ar_p04_akilo, // 0x56e
        mag_ar_large_p04_akilo, // 0x56f
        mag_ar_light_p04, // 0x570
        mag_ar_lgtsmall_p04, // 0x571
        mag_ar_lgtlarge_p04, // 0x572
        mag_ar_lgtxlarge_p04, // 0x573
        mag_ar_lgtsmall_p04_akilo105, // 0x574
        mag_ar_light_p04_akilo105, // 0x575
        mag_ar_lgtlarge_p04_akilo105, // 0x576
        mag_ar_lgtsmall_p04_akilo74, // 0x577
        mag_ar_light_p04_akilo74, // 0x578
        mag_ar_lgtlarge_p04_akilo74, // 0x579
        mag_ar_p03_augolf, // 0x57a
        mag_ar_large_p03_augolf, // 0x57b
        mag_br_p02, // 0x57c
        drum_br_p02, // 0x57d
        mag_br_large_p02, // 0x57e
        mag_br_large_p02_golf3, // 0x57f
        mag_br_p02_golf3, // 0x580
        mag_sn_large_p02, // 0x581
        mag_sn_large_p02_golf3, // 0x582
        mag_sn_p02_golf3, // 0x583
        mag_sn_p02, // 0x584
        mag_ar_small_p01, // 0x585
        mag_br_p01, // 0x586
        mag_br_small_p01, // 0x587
        mag_br_large_p01, // 0x588
        mag_sn_p02_pgolf1, // 0x589
        mag_sn_large_p02_pgolf1, // 0x58a
        mag_br_p02_pgolf1, // 0x58b
        drum_lm_p03, // 0x58c
        mag_lm_large_p03, // 0x58d
        mag_ar_p03_ahotel, // 0x58e
        mag_ar_large_p03_ahotel, // 0x58f
        belt_lm_p02, // 0x590
        belt_lm_large_p02, // 0x591
        drum_lm_p04, // 0x592
        drum_lm_large_p04, // 0x593
        mag_ar_p04_rkilo, // 0x594
        mag_ar_large_p04_rkilo, // 0x595
        mag_sm_p03, // 0x596
        mag_sm_large_p03, // 0x597
        mag_sm_p04, // 0x598
        mag_sm_large_p04, // 0x599
        magheli_sm_p04, // 0x59a
        magheligrip_sm_p04, // 0x59b
        mag_sm_p02, // 0x59c
        mag_sm_small_p02, // 0x59d
        mag_sm_large_p02, // 0x59e
        drum_sm_p02, // 0x59f
        stock_sm_tactical_p04_akilo, // 0x5a0
        hybridtherm02, // 0x5a1
        stock_sm_tactical_p04_akilo105, // 0x5a2
        stock_sm_tactical_p04_akilo74, // 0x5a3
        stock_ar_p08_mcbravo, // 0x5a4
        stock_ar_tactical_p08_mcbravo, // 0x5a5
        stock_ar_p08_mcharlie, // 0x5a6
        stock_ar_tactical_p08_mcharlie, // 0x5a7
        stock_sm_light_p08_mcharlie, // 0x5a8
        stock_sm_p08_mcharlie, // 0x5a9
        stock_ar_heavy_p05_scharlie, // 0x5aa
        stock_ar_p05_scharlie, // 0x5ab
        stock_ar_tactical_p05_scharlie, // 0x5ac
        stock_sn_p05_scharlie, // 0x5ad
        stock_ar_p05_schotel, // 0x5ae
        stock_ar_tactical_p05_schotel, // 0x5af
        stock_sn_p05_schotel, // 0x5b0
        stock_ar_heavy_p05_schotel, // 0x5b1
        stock_ar_tactical_p05_scsierra, // 0x5b2
        stock_ar_p05_scsierra, // 0x5b3
        dmscope02, // 0x5b4
        hybrid05_le, // 0x5b5
        hybridtherm02_le, // 0x5b6
        hybridscope_sn01_le, // 0x5b7
        stock_ar_assault_p01_msecho, // 0x5b8
        stock_sn_p01_msecho, // 0x5b9
        stock_dm_light_p18_soscar14, // 0x5ba
        stock_dm_tac_p18_soscar14, // 0x5bb
        stockr_dm_p18_soscar14, // 0x5bc
        xmag_sn_p20, // 0x5bd
        stock_dm_light_p18_mike14, // 0x5be
        stock_dm_tac_p18_mike14, // 0x5bf
        stockr_dm_p18_mike14, // 0x5c0
        mag_dm_p20_mike24, // 0x5c1
        mag_dm_large_p20_mike24, // 0x5c2
        mag_dm_xlarge_p20_mike24, // 0x5c3
        mag_dm_p20_sa700, // 0x5c4
        mag_dm_large_p20_sa700, // 0x5c5
        mag_dm_xlarge_p20_sa700, // 0x5c6
        stock_ar_p05_scromeo, // 0x5c7
        stock_ar_heavy_p05_scromeo, // 0x5c8
        stock_sn_p05_scromeo, // 0x5c9
        fourx_aug, // 0x5ca
        stock_ar_tactical_p04_rkilo, // 0x5cb
        stock_ar_p04_rkilo, // 0x5cc
        ironsdefault_golf17_stockp, // 0x5cd
        tacknife, // 0x5ce
        stockpno_sm_p24, // 0x5cf
        ammo_12g_sl_charlie725, // 0x5d0
        ammo_12g_he_charlie725, // 0x5d1
        stockr_sh_p13_mbravo, // 0x5d2
        stockr_sh_heavy_p13_mbravo, // 0x5d3
        stock_sh_heavy_p13_mbravo, // 0x5d4
        stock_sh_tactical_p13_mbravo, // 0x5d5
        stock_sh_light_p13_mbravo, // 0x5d6
        stockno_sh_p13_mbravo, // 0x5d7
        stockno_sh_light_p13_mbravo, // 0x5d8
        tube_8_12g_mbravo, // 0x5d9
        ammo_12g_he_mbravo, // 0x5da
        ammo_12g_sl_mbravo, // 0x5db
        ammo_12g_db_mbravo, // 0x5dc
        ammo_12g_he_mike1014, // 0x5dd
        ammo_12g_sl_mike1014, // 0x5de
        ammo_12g_db_mike1014, // 0x5df
        stockr_sh_p13_mviktor, // 0x5e0
        stockr_sh_heavy_p13_mviktor, // 0x5e1
        stock_sh_heavy_p13_mviktor, // 0x5e2
        stock_sh_tactical_p13_mviktor, // 0x5e3
        stock_sh_light_p13_mviktor, // 0x5e4
        stockno_sh_p13_mviktor, // 0x5e5
        stockno_sh_light_p13_mviktor, // 0x5e6
        ammo_12g_he_mviktor, // 0x5e7
        ammo_12g_sl_mviktor, // 0x5e8
        ammo_12g_db_mviktor, // 0x5e9
        stock_sm_tactical_p04_aviktor, // 0x5ea
        stock_sm_tactical_p04_beta, // 0x5eb
        stock_sm_p08_mpapax, // 0x5ec
        stock_sm_light_p08_mpapax, // 0x5ed
        stock_ar_tactical_p08_mpapax, // 0x5ee
        stock_sm_p07, // 0x5ef
        stock_sm_tactical_p07, // 0x5f0
        stock_sm_assault_p07, // 0x5f1
        stock_sm_heavy_p07, // 0x5f2
        railreflex_sm_reflex_p07, // 0x5f3
        rail_lgt_irons_p07, // 0x5f4
        bar_ar_light_p08, // 0x5f5
        bar_ar_lgt_short_p08, // 0x5f6
        bar_ar_short_p05, // 0x5f7
        bar_ar_long_p05, // 0x5f8
        bar_dm_p18_soscar14, // 0x5f9
        bar_dm_heavy_p18_soscar14, // 0x5fa
        bar_br_p18_soscar14, // 0x5fb
        bar_br_heavy_p18_soscar14, // 0x5fc
        bar_br_short_p18_soscar14, // 0x5fd
        drum_br_p18, // 0x5fe
        mag_br_large_p18, // 0x5ff
        mag_br_p18_soscar14, // 0x600
        bar_dm_short_p20_la700, // 0x601
        bar_dm_p18_mike14, // 0x602
        bar_dm_heavy_p18_mike14, // 0x603
        bar_br_heavy_p18_mike14, // 0x604
        bar_br_p18_mike14, // 0x605
        bar_br_short_p18_mike14, // 0x606
        mag_br_p18_mike14, // 0x607
        bar_dm_lgtshort_p20, // 0x608
        barsil_dm_p19, // 0x609
        bar_dm_short_p20_xmike2010, // 0x60a
        barcomp_pi_p27, // 0x60b
        bar_pi_heavy_p26, // 0x60c
        tube_2_12g_charlie725, // 0x60d
        bartube_sh_long_p13, // 0x60e
        tube_3_12g_mbravo, // 0x60f
        tube_5_12g_mbravo, // 0x610
        tube_6_12g_mbravo, // 0x611
        bar_sh_p12, // 0x612
        tube_5_12g_mike1014, // 0x613
        tube_7_12g_mike1014, // 0x614
        tube_10_12g_mike1014, // 0x615
        bar_sn_p22, // 0x616
        stock_sm_p05_scharlie, // 0x617
        stock_ar_tactical_p05_scromeo, // 0x618
        pgrip_p01_foxtrot, // 0x619
        fourx06, // 0x61a
        bar_lm_light_p15, // 0x61b
        bar_lm_hvylong_p17, // 0x61c
        bar_sh_hvylong_p14, // 0x61d
        stock_sh_tactical_p12, // 0x61e
        stockr_br_heavy_p18, // 0x61f
        stock_dm_heavy_p20, // 0x620
        stock_dm_tactical_p20, // 0x621
        stockno_dm_p20, // 0x622
        ammo_308w, // 0x623
        ammo_308w_fr, // 0x624
        ammo_308w_hp, // 0x625
        ammo_308w_ap, // 0x626
        ammo_308w_op, // 0x627
        ammo_308w_hv, // 0x628
        ammo_308w_db, // 0x629
        stockno_lm_p16, // 0x62a
        stock_sn_hvy2_p23, // 0x62b
        pgrip_snp_p05, // 0x62c
        selectsemi_kilo53, // 0x62d
        kilo21_sidegrip02, // 0x62e
        kilo21_sidegrip03, // 0x62f
        ironsbarshort_papa220, // 0x630
        ironsbarlong_papa220, // 0x631
        ironsbarheavy_swhiskey, // 0x632
        pgrip_p20_sa700, // 0x633
        pgrip_p20_xmike2010, // 0x634
        iw9_minireddot03_tall_p01, // 0x635
        reflex07_tall_p01, // 0x636
        holo02_p01, // 0x637
        fourx04_p01, // 0x638
        arscope_therm01_p01, // 0x639
        ub_gl01_p01, // 0x63a
        silencer03_ar_p01, // 0x63b
        comp_ar_06_p01, // 0x63c
        breacher_ar_01_p01, // 0x63d
        grip_angled09_p01, // 0x63e
        grip_vert05_p01, // 0x63f
        laserbox_hip01_p01, // 0x640
        flash_dm_04_p01, // 0x641
        silencer02_dm_p01, // 0x642
        comp_dm_03_p01, // 0x643
        comp_sm_05_p01, // 0x644
        breacher_sm_01_p01, // 0x645
        pgrip_p04_akilo105, // 0x646
        pgolf1_scope, // 0x647
        akimbo_golf18, // 0x648
        ammo_12g_db_charlie725, // 0x649
        beadiron_short_mbravo, // 0x64a
        beadiron_mbravo, // 0x64b
        laserbox_ads05_mromeo, // 0x64c
        selectsemi_mike4, // 0x64d
        test_roll_0, // 0x64e
        test_roll_25, // 0x64f
        test_roll_50, // 0x650
        test_roll_75, // 0x651
        test_roll_100, // 0x652
        pgrip_snp_p27, // 0x653
        ammo_300nm, // 0x654
        ammo_300nm_ap, // 0x655
        ammo_300nm_db, // 0x656
        ammo_300nm_fr, // 0x657
        ammo_300nm_hp, // 0x658
        ammo_300nm_hv, // 0x659
        ammo_300nm_op, // 0x65a
        comb_default_heavy_p12, // 0x65b
        comb_default_ammo_p12, // 0x65c
        snscope03, // 0x65d
        snscope02, // 0x65e
        ironsdefault_mike4_mike16, // 0x65f
        ironsdefault_mike16_mike4, // 0x660
        breacher_sm_02, // 0x661
        iw9_minireddot01_pstl, // 0x662
        iw9_minireddot02_pstl, // 0x663
        iw9_minireddot03_pstl, // 0x664
        iw9_minireddot04_pstl, // 0x665
        iw9_minireddot05_pstl, // 0x666
        iw9_minireddot06_pstl, // 0x667
        bar_sm_light_p24, // 0x668
        guard_light_p13_mbravo, // 0x669
        guard_tactical_p13_mviktor, // 0x66a
        guard_heavy_p13_mviktor, // 0x66b
        iron_mromeo, // 0x66c
        iron_mromeo_laser, // 0x66d
        bar_br_heavy_p18, // 0x66e
        bar_br_short_p18, // 0x66f
        bar_dm_heavy_p18, // 0x670
        bar_dm_light_p20, // 0x671
        bar_dm_short_p20, // 0x672
        bar_sn_heavy_p20, // 0x673
        bar_sn_light_p20, // 0x674
        bar_sn_p20, // 0x675
        barsil_dm_p20, // 0x676
        mag_br_p18, // 0x677
        pgrip_aim_p02, // 0x678
        pgrip_ass_p02, // 0x679
        pgrip_snp_p02, // 0x67a
        pgrip_tac_p02 // 0x67b
    };

    // idx 0xd members: 0x3e8 type: 0
    enum CosmeticAttachment {
        none, // 0x0
        cos_iw9_001, // 0x1
        cos_iw9_002, // 0x2
        cos_iw9_003, // 0x3
        cos_iw9_004, // 0x4
        cos_iw9_005, // 0x5
        cos_iw9_006, // 0x6
        cos_iw9_007, // 0x7
        cos_iw9_008, // 0x8
        cos_iw9_009, // 0x9
        cos_iw9_010, // 0xa
        cos_iw9_011, // 0xb
        cos_iw9_012, // 0xc
        cos_iw9_013, // 0xd
        cos_iw9_014, // 0xe
        cos_iw9_015, // 0xf
        cos_iw9_016, // 0x10
        cos_iw9_017, // 0x11
        cos_iw9_018, // 0x12
        cos_iw9_019, // 0x13
        cos_iw9_020, // 0x14
        cos_iw9_021, // 0x15
        cos_iw9_022, // 0x16
        cos_iw9_023, // 0x17
        cos_iw9_024, // 0x18
        cos_iw9_025, // 0x19
        cos_iw9_026, // 0x1a
        cos_iw9_027, // 0x1b
        cos_iw9_028, // 0x1c
        cos_iw9_029, // 0x1d
        cos_iw9_030, // 0x1e
        cos_iw9_031, // 0x1f
        cos_iw9_032, // 0x20
        cos_iw9_033, // 0x21
        cos_iw9_034, // 0x22
        cos_iw9_035, // 0x23
        cos_iw9_036, // 0x24
        cos_iw9_037, // 0x25
        cos_iw9_038, // 0x26
        cos_iw9_039, // 0x27
        cos_iw9_040, // 0x28
        cos_iw9_041, // 0x29
        cos_iw9_042, // 0x2a
        cos_iw9_043, // 0x2b
        cos_iw9_044, // 0x2c
        cos_iw9_045, // 0x2d
        cos_iw9_046, // 0x2e
        cos_iw9_047, // 0x2f
        cos_iw9_048, // 0x30
        cos_iw9_049, // 0x31
        cos_iw9_050, // 0x32
        cos_iw9_051, // 0x33
        cos_iw9_052, // 0x34
        cos_iw9_053, // 0x35
        cos_iw9_054, // 0x36
        cos_iw9_055, // 0x37
        cos_iw9_056, // 0x38
        cos_iw9_057, // 0x39
        cos_iw9_058, // 0x3a
        cos_iw9_059, // 0x3b
        cos_iw9_060, // 0x3c
        cos_iw9_061, // 0x3d
        cos_iw9_062, // 0x3e
        cos_iw9_063, // 0x3f
        cos_iw9_064, // 0x40
        cos_iw9_065, // 0x41
        cos_iw9_066, // 0x42
        cos_iw9_067, // 0x43
        cos_iw9_068, // 0x44
        cos_iw9_069, // 0x45
        cos_iw9_070, // 0x46
        cos_iw9_071, // 0x47
        cos_iw9_072, // 0x48
        cos_iw9_073, // 0x49
        cos_iw9_074, // 0x4a
        cos_iw9_075, // 0x4b
        cos_iw9_076, // 0x4c
        cos_iw9_077, // 0x4d
        cos_iw9_078, // 0x4e
        cos_iw9_079, // 0x4f
        cos_iw9_080, // 0x50
        cos_iw9_081, // 0x51
        cos_iw9_082, // 0x52
        cos_iw9_083, // 0x53
        cos_iw9_084, // 0x54
        cos_iw9_085, // 0x55
        cos_iw9_086, // 0x56
        cos_iw9_087, // 0x57
        cos_iw9_088, // 0x58
        cos_iw9_089, // 0x59
        cos_iw9_090, // 0x5a
        cos_iw9_091, // 0x5b
        cos_iw9_092, // 0x5c
        cos_iw9_093, // 0x5d
        cos_iw9_094, // 0x5e
        cos_iw9_095, // 0x5f
        cos_iw9_096, // 0x60
        cos_iw9_097, // 0x61
        cos_iw9_098, // 0x62
        cos_iw9_099, // 0x63
        cos_iw9_100, // 0x64
        cos_iw9_101, // 0x65
        cos_iw9_102, // 0x66
        cos_iw9_103, // 0x67
        cos_iw9_104, // 0x68
        cos_iw9_105, // 0x69
        cos_iw9_106, // 0x6a
        cos_iw9_107, // 0x6b
        cos_iw9_108, // 0x6c
        cos_iw9_109, // 0x6d
        cos_iw9_110, // 0x6e
        cos_iw9_111, // 0x6f
        cos_iw9_112, // 0x70
        cos_iw9_113, // 0x71
        cos_iw9_114, // 0x72
        cos_iw9_115, // 0x73
        cos_iw9_116, // 0x74
        cos_iw9_117, // 0x75
        cos_iw9_118, // 0x76
        cos_iw9_119, // 0x77
        cos_iw9_120, // 0x78
        cos_iw9_121, // 0x79
        cos_iw9_122, // 0x7a
        cos_iw9_123, // 0x7b
        cos_iw9_124, // 0x7c
        cos_iw9_125, // 0x7d
        cos_iw9_126, // 0x7e
        cos_iw9_127, // 0x7f
        cos_iw9_128, // 0x80
        cos_iw9_129, // 0x81
        cos_iw9_130, // 0x82
        cos_iw9_131, // 0x83
        cos_iw9_132, // 0x84
        cos_iw9_133, // 0x85
        cos_iw9_134, // 0x86
        cos_iw9_135, // 0x87
        cos_iw9_136, // 0x88
        cos_iw9_137, // 0x89
        cos_iw9_138, // 0x8a
        cos_iw9_139, // 0x8b
        cos_iw9_140, // 0x8c
        cos_iw9_141, // 0x8d
        cos_iw9_142, // 0x8e
        cos_iw9_143, // 0x8f
        cos_iw9_144, // 0x90
        cos_iw9_145, // 0x91
        cos_iw9_146, // 0x92
        cos_iw9_147, // 0x93
        cos_iw9_148, // 0x94
        cos_iw9_149, // 0x95
        cos_iw9_150, // 0x96
        cos_iw9_151, // 0x97
        cos_iw9_152, // 0x98
        cos_iw9_153, // 0x99
        cos_iw9_154, // 0x9a
        cos_iw9_155, // 0x9b
        cos_iw9_156, // 0x9c
        cos_iw9_157, // 0x9d
        cos_iw9_158, // 0x9e
        cos_iw9_159, // 0x9f
        cos_iw9_160, // 0xa0
        cos_iw9_161, // 0xa1
        cos_iw9_162, // 0xa2
        cos_iw9_163, // 0xa3
        cos_iw9_164, // 0xa4
        cos_iw9_165, // 0xa5
        cos_iw9_166, // 0xa6
        cos_iw9_167, // 0xa7
        cos_iw9_168, // 0xa8
        cos_iw9_169, // 0xa9
        cos_iw9_170, // 0xaa
        cos_iw9_171, // 0xab
        cos_iw9_172, // 0xac
        cos_iw9_173, // 0xad
        cos_iw9_174, // 0xae
        cos_iw9_175, // 0xaf
        cos_iw9_176, // 0xb0
        cos_iw9_177, // 0xb1
        cos_iw9_178, // 0xb2
        cos_iw9_179, // 0xb3
        cos_iw9_180, // 0xb4
        cos_iw9_181, // 0xb5
        cos_iw9_182, // 0xb6
        cos_iw9_183, // 0xb7
        cos_iw9_184, // 0xb8
        cos_iw9_185, // 0xb9
        cos_iw9_186, // 0xba
        cos_iw9_187, // 0xbb
        cos_iw9_188, // 0xbc
        cos_iw9_189, // 0xbd
        cos_iw9_190, // 0xbe
        cos_iw9_191, // 0xbf
        cos_iw9_192, // 0xc0
        cos_iw9_193, // 0xc1
        cos_iw9_194, // 0xc2
        cos_iw9_195, // 0xc3
        cos_iw9_196, // 0xc4
        cos_iw9_197, // 0xc5
        cos_iw9_198, // 0xc6
        cos_iw9_199, // 0xc7
        cos_iw9_200, // 0xc8
        cos_iw9_201, // 0xc9
        cos_iw9_202, // 0xca
        cos_iw9_203, // 0xcb
        cos_iw9_204, // 0xcc
        cos_iw9_205, // 0xcd
        cos_iw9_206, // 0xce
        cos_iw9_207, // 0xcf
        cos_iw9_208, // 0xd0
        cos_iw9_209, // 0xd1
        cos_iw9_210, // 0xd2
        cos_iw9_211, // 0xd3
        cos_iw9_212, // 0xd4
        cos_iw9_213, // 0xd5
        cos_iw9_214, // 0xd6
        cos_iw9_215, // 0xd7
        cos_iw9_216, // 0xd8
        cos_iw9_217, // 0xd9
        cos_iw9_218, // 0xda
        cos_iw9_219, // 0xdb
        cos_iw9_220, // 0xdc
        cos_iw9_221, // 0xdd
        cos_iw9_222, // 0xde
        cos_iw9_223, // 0xdf
        cos_iw9_224, // 0xe0
        cos_iw9_225, // 0xe1
        cos_iw9_226, // 0xe2
        cos_iw9_227, // 0xe3
        cos_iw9_228, // 0xe4
        cos_iw9_229, // 0xe5
        cos_iw9_230, // 0xe6
        cos_iw9_231, // 0xe7
        cos_iw9_232, // 0xe8
        cos_iw9_233, // 0xe9
        cos_iw9_234, // 0xea
        cos_iw9_235, // 0xeb
        cos_iw9_236, // 0xec
        cos_iw9_237, // 0xed
        cos_iw9_238, // 0xee
        cos_iw9_239, // 0xef
        cos_iw9_240, // 0xf0
        cos_iw9_241, // 0xf1
        cos_iw9_242, // 0xf2
        cos_iw9_243, // 0xf3
        cos_iw9_244, // 0xf4
        cos_iw9_245, // 0xf5
        cos_iw9_246, // 0xf6
        cos_iw9_247, // 0xf7
        cos_iw9_248, // 0xf8
        cos_iw9_249, // 0xf9
        cos_iw9_250, // 0xfa
        cos_iw9_251, // 0xfb
        cos_iw9_252, // 0xfc
        cos_iw9_253, // 0xfd
        cos_iw9_254, // 0xfe
        cos_iw9_255, // 0xff
        cos_iw9_256, // 0x100
        cos_iw9_257, // 0x101
        cos_iw9_258, // 0x102
        cos_iw9_259, // 0x103
        cos_iw9_260, // 0x104
        cos_iw9_261, // 0x105
        cos_iw9_262, // 0x106
        cos_iw9_263, // 0x107
        cos_iw9_264, // 0x108
        cos_iw9_265, // 0x109
        cos_iw9_266, // 0x10a
        cos_iw9_267, // 0x10b
        cos_iw9_268, // 0x10c
        cos_iw9_269, // 0x10d
        cos_iw9_270, // 0x10e
        cos_iw9_271, // 0x10f
        cos_iw9_272, // 0x110
        cos_iw9_273, // 0x111
        cos_iw9_274, // 0x112
        cos_iw9_275, // 0x113
        cos_iw9_276, // 0x114
        cos_iw9_277, // 0x115
        cos_iw9_278, // 0x116
        cos_iw9_279, // 0x117
        cos_iw9_280, // 0x118
        cos_iw9_281, // 0x119
        cos_iw9_282, // 0x11a
        cos_iw9_283, // 0x11b
        cos_iw9_284, // 0x11c
        cos_iw9_285, // 0x11d
        cos_iw9_286, // 0x11e
        cos_iw9_287, // 0x11f
        cos_iw9_288, // 0x120
        cos_iw9_289, // 0x121
        cos_iw9_290, // 0x122
        cos_iw9_291, // 0x123
        cos_iw9_292, // 0x124
        cos_iw9_293, // 0x125
        cos_iw9_294, // 0x126
        cos_iw9_295, // 0x127
        cos_iw9_296, // 0x128
        cos_iw9_297, // 0x129
        cos_iw9_298, // 0x12a
        cos_iw9_299, // 0x12b
        cos_iw9_300, // 0x12c
        cos_iw9_301, // 0x12d
        cos_iw9_302, // 0x12e
        cos_iw9_303, // 0x12f
        cos_iw9_304, // 0x130
        cos_iw9_305, // 0x131
        cos_iw9_306, // 0x132
        cos_iw9_307, // 0x133
        cos_iw9_308, // 0x134
        cos_iw9_309, // 0x135
        cos_iw9_310, // 0x136
        cos_iw9_311, // 0x137
        cos_iw9_312, // 0x138
        cos_iw9_313, // 0x139
        cos_iw9_314, // 0x13a
        cos_iw9_315, // 0x13b
        cos_iw9_316, // 0x13c
        cos_iw9_317, // 0x13d
        cos_iw9_318, // 0x13e
        cos_iw9_319, // 0x13f
        cos_iw9_320, // 0x140
        cos_iw9_321, // 0x141
        cos_iw9_322, // 0x142
        cos_iw9_323, // 0x143
        cos_iw9_324, // 0x144
        cos_iw9_325, // 0x145
        cos_iw9_326, // 0x146
        cos_iw9_327, // 0x147
        cos_iw9_328, // 0x148
        cos_iw9_329, // 0x149
        cos_iw9_330, // 0x14a
        cos_iw9_331, // 0x14b
        cos_iw9_332, // 0x14c
        cos_iw9_333, // 0x14d
        cos_iw9_334, // 0x14e
        cos_iw9_335, // 0x14f
        cos_iw9_336, // 0x150
        cos_iw9_337, // 0x151
        cos_iw9_338, // 0x152
        cos_iw9_339, // 0x153
        cos_iw9_340, // 0x154
        cos_iw9_341, // 0x155
        cos_iw9_342, // 0x156
        cos_iw9_343, // 0x157
        cos_iw9_344, // 0x158
        cos_iw9_345, // 0x159
        cos_iw9_346, // 0x15a
        cos_iw9_347, // 0x15b
        cos_iw9_348, // 0x15c
        cos_iw9_349, // 0x15d
        cos_iw9_350, // 0x15e
        cos_iw9_351, // 0x15f
        cos_iw9_352, // 0x160
        cos_iw9_353, // 0x161
        cos_iw9_354, // 0x162
        cos_iw9_355, // 0x163
        cos_iw9_356, // 0x164
        cos_iw9_357, // 0x165
        cos_iw9_358, // 0x166
        cos_iw9_359, // 0x167
        cos_iw9_360, // 0x168
        cos_iw9_361, // 0x169
        cos_iw9_362, // 0x16a
        cos_iw9_363, // 0x16b
        cos_iw9_364, // 0x16c
        cos_iw9_365, // 0x16d
        cos_iw9_366, // 0x16e
        cos_iw9_367, // 0x16f
        cos_iw9_368, // 0x170
        cos_iw9_369, // 0x171
        cos_iw9_370, // 0x172
        cos_iw9_371, // 0x173
        cos_iw9_372, // 0x174
        cos_iw9_373, // 0x175
        cos_iw9_374, // 0x176
        cos_iw9_375, // 0x177
        cos_iw9_376, // 0x178
        cos_iw9_377, // 0x179
        cos_iw9_378, // 0x17a
        cos_iw9_379, // 0x17b
        cos_iw9_380, // 0x17c
        cos_iw9_381, // 0x17d
        cos_iw9_382, // 0x17e
        cos_iw9_383, // 0x17f
        cos_iw9_384, // 0x180
        cos_iw9_385, // 0x181
        cos_iw9_386, // 0x182
        cos_iw9_387, // 0x183
        cos_iw9_388, // 0x184
        cos_iw9_389, // 0x185
        cos_iw9_390, // 0x186
        cos_iw9_391, // 0x187
        cos_iw9_392, // 0x188
        cos_iw9_393, // 0x189
        cos_iw9_394, // 0x18a
        cos_iw9_395, // 0x18b
        cos_iw9_396, // 0x18c
        cos_iw9_397, // 0x18d
        cos_iw9_398, // 0x18e
        cos_iw9_399, // 0x18f
        cos_iw9_400, // 0x190
        cos_iw9_401, // 0x191
        cos_iw9_402, // 0x192
        cos_iw9_403, // 0x193
        cos_iw9_404, // 0x194
        cos_iw9_405, // 0x195
        cos_iw9_406, // 0x196
        cos_iw9_407, // 0x197
        cos_iw9_408, // 0x198
        cos_iw9_409, // 0x199
        cos_iw9_410, // 0x19a
        cos_iw9_411, // 0x19b
        cos_iw9_412, // 0x19c
        cos_iw9_413, // 0x19d
        cos_iw9_414, // 0x19e
        cos_iw9_415, // 0x19f
        cos_iw9_416, // 0x1a0
        cos_iw9_417, // 0x1a1
        cos_iw9_418, // 0x1a2
        cos_iw9_419, // 0x1a3
        cos_iw9_420, // 0x1a4
        cos_iw9_421, // 0x1a5
        cos_iw9_422, // 0x1a6
        cos_iw9_423, // 0x1a7
        cos_iw9_424, // 0x1a8
        cos_iw9_425, // 0x1a9
        cos_iw9_426, // 0x1aa
        cos_iw9_427, // 0x1ab
        cos_iw9_428, // 0x1ac
        cos_iw9_429, // 0x1ad
        cos_iw9_430, // 0x1ae
        cos_iw9_431, // 0x1af
        cos_iw9_432, // 0x1b0
        cos_iw9_433, // 0x1b1
        cos_iw9_434, // 0x1b2
        cos_iw9_435, // 0x1b3
        cos_iw9_436, // 0x1b4
        cos_iw9_437, // 0x1b5
        cos_iw9_438, // 0x1b6
        cos_iw9_439, // 0x1b7
        cos_iw9_440, // 0x1b8
        cos_iw9_441, // 0x1b9
        cos_iw9_442, // 0x1ba
        cos_iw9_443, // 0x1bb
        cos_iw9_444, // 0x1bc
        cos_iw9_445, // 0x1bd
        cos_iw9_446, // 0x1be
        cos_iw9_447, // 0x1bf
        cos_iw9_448, // 0x1c0
        cos_iw9_449, // 0x1c1
        cos_iw9_450, // 0x1c2
        cos_iw9_451, // 0x1c3
        cos_iw9_452, // 0x1c4
        cos_iw9_453, // 0x1c5
        cos_iw9_454, // 0x1c6
        cos_iw9_455, // 0x1c7
        cos_iw9_456, // 0x1c8
        cos_iw9_457, // 0x1c9
        cos_iw9_458, // 0x1ca
        cos_iw9_459, // 0x1cb
        cos_iw9_460, // 0x1cc
        cos_iw9_461, // 0x1cd
        cos_iw9_462, // 0x1ce
        cos_iw9_463, // 0x1cf
        cos_iw9_464, // 0x1d0
        cos_iw9_465, // 0x1d1
        cos_iw9_466, // 0x1d2
        cos_iw9_467, // 0x1d3
        cos_iw9_468, // 0x1d4
        cos_iw9_469, // 0x1d5
        cos_iw9_470, // 0x1d6
        cos_iw9_471, // 0x1d7
        cos_iw9_472, // 0x1d8
        cos_iw9_473, // 0x1d9
        cos_iw9_474, // 0x1da
        cos_iw9_475, // 0x1db
        cos_iw9_476, // 0x1dc
        cos_iw9_477, // 0x1dd
        cos_iw9_478, // 0x1de
        cos_iw9_479, // 0x1df
        cos_iw9_480, // 0x1e0
        cos_iw9_481, // 0x1e1
        cos_iw9_482, // 0x1e2
        cos_iw9_483, // 0x1e3
        cos_iw9_484, // 0x1e4
        cos_iw9_485, // 0x1e5
        cos_iw9_486, // 0x1e6
        cos_iw9_487, // 0x1e7
        cos_iw9_488, // 0x1e8
        cos_iw9_489, // 0x1e9
        cos_iw9_490, // 0x1ea
        cos_iw9_491, // 0x1eb
        cos_iw9_492, // 0x1ec
        cos_iw9_493, // 0x1ed
        cos_iw9_494, // 0x1ee
        cos_iw9_495, // 0x1ef
        cos_iw9_496, // 0x1f0
        cos_iw9_497, // 0x1f1
        cos_iw9_498, // 0x1f2
        cos_iw9_499, // 0x1f3
        cos_iw9_500, // 0x1f4
        cos_iw9_501, // 0x1f5
        cos_iw9_502, // 0x1f6
        cos_iw9_503, // 0x1f7
        cos_iw9_504, // 0x1f8
        cos_iw9_505, // 0x1f9
        cos_iw9_506, // 0x1fa
        cos_iw9_507, // 0x1fb
        cos_iw9_508, // 0x1fc
        cos_iw9_509, // 0x1fd
        cos_iw9_510, // 0x1fe
        cos_iw9_511, // 0x1ff
        cos_iw9_512, // 0x200
        cos_iw9_513, // 0x201
        cos_iw9_514, // 0x202
        cos_iw9_515, // 0x203
        cos_iw9_516, // 0x204
        cos_iw9_517, // 0x205
        cos_iw9_518, // 0x206
        cos_iw9_519, // 0x207
        cos_iw9_520, // 0x208
        cos_iw9_521, // 0x209
        cos_iw9_522, // 0x20a
        cos_iw9_523, // 0x20b
        cos_iw9_524, // 0x20c
        cos_iw9_525, // 0x20d
        cos_iw9_526, // 0x20e
        cos_iw9_527, // 0x20f
        cos_iw9_528, // 0x210
        cos_iw9_529, // 0x211
        cos_iw9_530, // 0x212
        cos_iw9_531, // 0x213
        cos_iw9_532, // 0x214
        cos_iw9_533, // 0x215
        cos_iw9_534, // 0x216
        cos_iw9_535, // 0x217
        cos_iw9_536, // 0x218
        cos_iw9_537, // 0x219
        cos_iw9_538, // 0x21a
        cos_iw9_539, // 0x21b
        cos_iw9_540, // 0x21c
        cos_iw9_541, // 0x21d
        cos_iw9_542, // 0x21e
        cos_iw9_543, // 0x21f
        cos_iw9_544, // 0x220
        cos_iw9_545, // 0x221
        cos_iw9_546, // 0x222
        cos_iw9_547, // 0x223
        cos_iw9_548, // 0x224
        cos_iw9_549, // 0x225
        cos_iw9_550, // 0x226
        cos_iw9_551, // 0x227
        cos_iw9_552, // 0x228
        cos_iw9_553, // 0x229
        cos_iw9_554, // 0x22a
        cos_iw9_555, // 0x22b
        cos_iw9_556, // 0x22c
        cos_iw9_557, // 0x22d
        cos_iw9_558, // 0x22e
        cos_iw9_559, // 0x22f
        cos_iw9_560, // 0x230
        cos_iw9_561, // 0x231
        cos_iw9_562, // 0x232
        cos_iw9_563, // 0x233
        cos_iw9_564, // 0x234
        cos_iw9_565, // 0x235
        cos_iw9_566, // 0x236
        cos_iw9_567, // 0x237
        cos_iw9_568, // 0x238
        cos_iw9_569, // 0x239
        cos_iw9_570, // 0x23a
        cos_iw9_571, // 0x23b
        cos_iw9_572, // 0x23c
        cos_iw9_573, // 0x23d
        cos_iw9_574, // 0x23e
        cos_iw9_575, // 0x23f
        cos_iw9_576, // 0x240
        cos_iw9_577, // 0x241
        cos_iw9_578, // 0x242
        cos_iw9_579, // 0x243
        cos_iw9_580, // 0x244
        cos_iw9_581, // 0x245
        cos_iw9_582, // 0x246
        cos_iw9_583, // 0x247
        cos_iw9_584, // 0x248
        cos_iw9_585, // 0x249
        cos_iw9_586, // 0x24a
        cos_iw9_587, // 0x24b
        cos_iw9_588, // 0x24c
        cos_iw9_589, // 0x24d
        cos_iw9_590, // 0x24e
        cos_iw9_591, // 0x24f
        cos_iw9_592, // 0x250
        cos_iw9_593, // 0x251
        cos_iw9_594, // 0x252
        cos_iw9_595, // 0x253
        cos_iw9_596, // 0x254
        cos_iw9_597, // 0x255
        cos_iw9_598, // 0x256
        cos_iw9_599, // 0x257
        cos_iw9_600, // 0x258
        cos_iw9_601, // 0x259
        cos_iw9_602, // 0x25a
        cos_iw9_603, // 0x25b
        cos_iw9_604, // 0x25c
        cos_iw9_605, // 0x25d
        cos_iw9_606, // 0x25e
        cos_iw9_607, // 0x25f
        cos_iw9_608, // 0x260
        cos_iw9_609, // 0x261
        cos_iw9_610, // 0x262
        cos_iw9_611, // 0x263
        cos_iw9_612, // 0x264
        cos_iw9_613, // 0x265
        cos_iw9_614, // 0x266
        cos_iw9_615, // 0x267
        cos_iw9_616, // 0x268
        cos_iw9_617, // 0x269
        cos_iw9_618, // 0x26a
        cos_iw9_619, // 0x26b
        cos_iw9_620, // 0x26c
        cos_iw9_621, // 0x26d
        cos_iw9_622, // 0x26e
        cos_iw9_623, // 0x26f
        cos_iw9_624, // 0x270
        cos_iw9_625, // 0x271
        cos_iw9_626, // 0x272
        cos_iw9_627, // 0x273
        cos_iw9_628, // 0x274
        cos_iw9_629, // 0x275
        cos_iw9_630, // 0x276
        cos_iw9_631, // 0x277
        cos_iw9_632, // 0x278
        cos_iw9_633, // 0x279
        cos_iw9_634, // 0x27a
        cos_iw9_635, // 0x27b
        cos_iw9_636, // 0x27c
        cos_iw9_637, // 0x27d
        cos_iw9_638, // 0x27e
        cos_iw9_639, // 0x27f
        cos_iw9_640, // 0x280
        cos_iw9_641, // 0x281
        cos_iw9_642, // 0x282
        cos_iw9_643, // 0x283
        cos_iw9_644, // 0x284
        cos_iw9_645, // 0x285
        cos_iw9_646, // 0x286
        cos_iw9_647, // 0x287
        cos_iw9_648, // 0x288
        cos_iw9_649, // 0x289
        cos_iw9_650, // 0x28a
        cos_iw9_651, // 0x28b
        cos_iw9_652, // 0x28c
        cos_iw9_653, // 0x28d
        cos_iw9_654, // 0x28e
        cos_iw9_655, // 0x28f
        cos_iw9_656, // 0x290
        cos_iw9_657, // 0x291
        cos_iw9_658, // 0x292
        cos_iw9_659, // 0x293
        cos_iw9_660, // 0x294
        cos_iw9_661, // 0x295
        cos_iw9_662, // 0x296
        cos_iw9_663, // 0x297
        cos_iw9_664, // 0x298
        cos_iw9_665, // 0x299
        cos_iw9_666, // 0x29a
        cos_iw9_667, // 0x29b
        cos_iw9_668, // 0x29c
        cos_iw9_669, // 0x29d
        cos_iw9_670, // 0x29e
        cos_iw9_671, // 0x29f
        cos_iw9_672, // 0x2a0
        cos_iw9_673, // 0x2a1
        cos_iw9_674, // 0x2a2
        cos_iw9_675, // 0x2a3
        cos_iw9_676, // 0x2a4
        cos_iw9_677, // 0x2a5
        cos_iw9_678, // 0x2a6
        cos_iw9_679, // 0x2a7
        cos_iw9_680, // 0x2a8
        cos_iw9_681, // 0x2a9
        cos_iw9_682, // 0x2aa
        cos_iw9_683, // 0x2ab
        cos_iw9_684, // 0x2ac
        cos_iw9_685, // 0x2ad
        cos_iw9_686, // 0x2ae
        cos_iw9_687, // 0x2af
        cos_iw9_688, // 0x2b0
        cos_iw9_689, // 0x2b1
        cos_iw9_690, // 0x2b2
        cos_iw9_691, // 0x2b3
        cos_iw9_692, // 0x2b4
        cos_iw9_693, // 0x2b5
        cos_iw9_694, // 0x2b6
        cos_iw9_695, // 0x2b7
        cos_iw9_696, // 0x2b8
        cos_iw9_697, // 0x2b9
        cos_iw9_698, // 0x2ba
        cos_iw9_699, // 0x2bb
        cos_iw9_700, // 0x2bc
        cos_iw9_701, // 0x2bd
        cos_iw9_702, // 0x2be
        cos_iw9_703, // 0x2bf
        cos_iw9_704, // 0x2c0
        cos_iw9_705, // 0x2c1
        cos_iw9_706, // 0x2c2
        cos_iw9_707, // 0x2c3
        cos_iw9_708, // 0x2c4
        cos_iw9_709, // 0x2c5
        cos_iw9_710, // 0x2c6
        cos_iw9_711, // 0x2c7
        cos_iw9_712, // 0x2c8
        cos_iw9_713, // 0x2c9
        cos_iw9_714, // 0x2ca
        cos_iw9_715, // 0x2cb
        cos_iw9_716, // 0x2cc
        cos_iw9_717, // 0x2cd
        cos_iw9_718, // 0x2ce
        cos_iw9_719, // 0x2cf
        cos_iw9_720, // 0x2d0
        cos_iw9_721, // 0x2d1
        cos_iw9_722, // 0x2d2
        cos_iw9_723, // 0x2d3
        cos_iw9_724, // 0x2d4
        cos_iw9_725, // 0x2d5
        cos_iw9_726, // 0x2d6
        cos_iw9_727, // 0x2d7
        cos_iw9_728, // 0x2d8
        cos_iw9_729, // 0x2d9
        cos_iw9_730, // 0x2da
        cos_iw9_731, // 0x2db
        cos_iw9_732, // 0x2dc
        cos_iw9_733, // 0x2dd
        cos_iw9_734, // 0x2de
        cos_iw9_735, // 0x2df
        cos_iw9_736, // 0x2e0
        cos_iw9_737, // 0x2e1
        cos_iw9_738, // 0x2e2
        cos_iw9_739, // 0x2e3
        cos_iw9_740, // 0x2e4
        cos_iw9_741, // 0x2e5
        cos_iw9_742, // 0x2e6
        cos_iw9_743, // 0x2e7
        cos_iw9_744, // 0x2e8
        cos_iw9_745, // 0x2e9
        cos_iw9_746, // 0x2ea
        cos_iw9_747, // 0x2eb
        cos_iw9_748, // 0x2ec
        cos_iw9_749, // 0x2ed
        cos_iw9_750, // 0x2ee
        cos_iw9_751, // 0x2ef
        cos_iw9_752, // 0x2f0
        cos_iw9_753, // 0x2f1
        cos_iw9_754, // 0x2f2
        cos_iw9_755, // 0x2f3
        cos_iw9_756, // 0x2f4
        cos_iw9_757, // 0x2f5
        cos_iw9_758, // 0x2f6
        cos_iw9_759, // 0x2f7
        cos_iw9_760, // 0x2f8
        cos_iw9_761, // 0x2f9
        cos_iw9_762, // 0x2fa
        cos_iw9_763, // 0x2fb
        cos_iw9_764, // 0x2fc
        cos_iw9_765, // 0x2fd
        cos_iw9_766, // 0x2fe
        cos_iw9_767, // 0x2ff
        cos_iw9_768, // 0x300
        cos_iw9_769, // 0x301
        cos_iw9_770, // 0x302
        cos_iw9_771, // 0x303
        cos_iw9_772, // 0x304
        cos_iw9_773, // 0x305
        cos_iw9_774, // 0x306
        cos_iw9_775, // 0x307
        cos_iw9_776, // 0x308
        cos_iw9_777, // 0x309
        cos_iw9_778, // 0x30a
        cos_iw9_779, // 0x30b
        cos_iw9_780, // 0x30c
        cos_iw9_781, // 0x30d
        cos_iw9_782, // 0x30e
        cos_iw9_783, // 0x30f
        cos_iw9_784, // 0x310
        cos_iw9_785, // 0x311
        cos_iw9_786, // 0x312
        cos_iw9_787, // 0x313
        cos_iw9_788, // 0x314
        cos_iw9_789, // 0x315
        cos_iw9_790, // 0x316
        cos_iw9_791, // 0x317
        cos_iw9_792, // 0x318
        cos_iw9_793, // 0x319
        cos_iw9_794, // 0x31a
        cos_iw9_795, // 0x31b
        cos_iw9_796, // 0x31c
        cos_iw9_797, // 0x31d
        cos_iw9_798, // 0x31e
        cos_iw9_799, // 0x31f
        cos_iw9_800, // 0x320
        cos_iw9_801, // 0x321
        cos_iw9_802, // 0x322
        cos_iw9_803, // 0x323
        cos_iw9_804, // 0x324
        cos_iw9_805, // 0x325
        cos_iw9_806, // 0x326
        cos_iw9_807, // 0x327
        cos_iw9_808, // 0x328
        cos_iw9_809, // 0x329
        cos_iw9_810, // 0x32a
        cos_iw9_811, // 0x32b
        cos_iw9_812, // 0x32c
        cos_iw9_813, // 0x32d
        cos_iw9_814, // 0x32e
        cos_iw9_815, // 0x32f
        cos_iw9_816, // 0x330
        cos_iw9_817, // 0x331
        cos_iw9_818, // 0x332
        cos_iw9_819, // 0x333
        cos_iw9_820, // 0x334
        cos_iw9_821, // 0x335
        cos_iw9_822, // 0x336
        cos_iw9_823, // 0x337
        cos_iw9_824, // 0x338
        cos_iw9_825, // 0x339
        cos_iw9_826, // 0x33a
        cos_iw9_827, // 0x33b
        cos_iw9_828, // 0x33c
        cos_iw9_829, // 0x33d
        cos_iw9_830, // 0x33e
        cos_iw9_831, // 0x33f
        cos_iw9_832, // 0x340
        cos_iw9_833, // 0x341
        cos_iw9_834, // 0x342
        cos_iw9_835, // 0x343
        cos_iw9_836, // 0x344
        cos_iw9_837, // 0x345
        cos_iw9_838, // 0x346
        cos_iw9_839, // 0x347
        cos_iw9_840, // 0x348
        cos_iw9_841, // 0x349
        cos_iw9_842, // 0x34a
        cos_iw9_843, // 0x34b
        cos_iw9_844, // 0x34c
        cos_iw9_845, // 0x34d
        cos_iw9_846, // 0x34e
        cos_iw9_847, // 0x34f
        cos_iw9_848, // 0x350
        cos_iw9_849, // 0x351
        cos_iw9_850, // 0x352
        cos_iw9_851, // 0x353
        cos_iw9_852, // 0x354
        cos_iw9_853, // 0x355
        cos_iw9_854, // 0x356
        cos_iw9_855, // 0x357
        cos_iw9_856, // 0x358
        cos_iw9_857, // 0x359
        cos_iw9_858, // 0x35a
        cos_iw9_859, // 0x35b
        cos_iw9_860, // 0x35c
        cos_iw9_861, // 0x35d
        cos_iw9_862, // 0x35e
        cos_iw9_863, // 0x35f
        cos_iw9_864, // 0x360
        cos_iw9_865, // 0x361
        cos_iw9_866, // 0x362
        cos_iw9_867, // 0x363
        cos_iw9_868, // 0x364
        cos_iw9_869, // 0x365
        cos_iw9_870, // 0x366
        cos_iw9_871, // 0x367
        cos_iw9_872, // 0x368
        cos_iw9_873, // 0x369
        cos_iw9_874, // 0x36a
        cos_iw9_875, // 0x36b
        cos_iw9_876, // 0x36c
        cos_iw9_877, // 0x36d
        cos_iw9_878, // 0x36e
        cos_iw9_879, // 0x36f
        cos_iw9_880, // 0x370
        cos_iw9_881, // 0x371
        cos_iw9_882, // 0x372
        cos_iw9_883, // 0x373
        cos_iw9_884, // 0x374
        cos_iw9_885, // 0x375
        cos_iw9_886, // 0x376
        cos_iw9_887, // 0x377
        cos_iw9_888, // 0x378
        cos_iw9_889, // 0x379
        cos_iw9_890, // 0x37a
        cos_iw9_891, // 0x37b
        cos_iw9_892, // 0x37c
        cos_iw9_893, // 0x37d
        cos_iw9_894, // 0x37e
        cos_iw9_895, // 0x37f
        cos_iw9_896, // 0x380
        cos_iw9_897, // 0x381
        cos_iw9_898, // 0x382
        cos_iw9_899, // 0x383
        cos_iw9_900, // 0x384
        cos_iw9_901, // 0x385
        cos_iw9_902, // 0x386
        cos_iw9_903, // 0x387
        cos_iw9_904, // 0x388
        cos_iw9_905, // 0x389
        cos_iw9_906, // 0x38a
        cos_iw9_907, // 0x38b
        cos_iw9_908, // 0x38c
        cos_iw9_909, // 0x38d
        cos_iw9_910, // 0x38e
        cos_iw9_911, // 0x38f
        cos_iw9_912, // 0x390
        cos_iw9_913, // 0x391
        cos_iw9_914, // 0x392
        cos_iw9_915, // 0x393
        cos_iw9_916, // 0x394
        cos_iw9_917, // 0x395
        cos_iw9_918, // 0x396
        cos_iw9_919, // 0x397
        cos_iw9_920, // 0x398
        cos_iw9_921, // 0x399
        cos_iw9_922, // 0x39a
        cos_iw9_923, // 0x39b
        cos_iw9_924, // 0x39c
        cos_iw9_925, // 0x39d
        cos_iw9_926, // 0x39e
        cos_iw9_927, // 0x39f
        cos_iw9_928, // 0x3a0
        cos_iw9_929, // 0x3a1
        cos_iw9_930, // 0x3a2
        cos_iw9_931, // 0x3a3
        cos_iw9_932, // 0x3a4
        cos_iw9_933, // 0x3a5
        cos_iw9_934, // 0x3a6
        cos_iw9_935, // 0x3a7
        cos_iw9_936, // 0x3a8
        cos_iw9_937, // 0x3a9
        cos_iw9_938, // 0x3aa
        cos_iw9_939, // 0x3ab
        cos_iw9_940, // 0x3ac
        cos_iw9_941, // 0x3ad
        cos_iw9_942, // 0x3ae
        cos_iw9_943, // 0x3af
        cos_iw9_944, // 0x3b0
        cos_iw9_945, // 0x3b1
        cos_iw9_946, // 0x3b2
        cos_iw9_947, // 0x3b3
        cos_iw9_948, // 0x3b4
        cos_iw9_949, // 0x3b5
        cos_iw9_950, // 0x3b6
        cos_iw9_951, // 0x3b7
        cos_iw9_952, // 0x3b8
        cos_iw9_953, // 0x3b9
        cos_iw9_954, // 0x3ba
        cos_iw9_955, // 0x3bb
        cos_iw9_956, // 0x3bc
        cos_iw9_957, // 0x3bd
        cos_iw9_958, // 0x3be
        cos_iw9_959, // 0x3bf
        cos_iw9_960, // 0x3c0
        cos_iw9_961, // 0x3c1
        cos_iw9_962, // 0x3c2
        cos_iw9_963, // 0x3c3
        cos_iw9_964, // 0x3c4
        cos_iw9_965, // 0x3c5
        cos_iw9_966, // 0x3c6
        cos_iw9_967, // 0x3c7
        cos_iw9_968, // 0x3c8
        cos_iw9_969, // 0x3c9
        cos_iw9_970, // 0x3ca
        cos_iw9_971, // 0x3cb
        cos_iw9_972, // 0x3cc
        cos_iw9_973, // 0x3cd
        cos_iw9_974, // 0x3ce
        cos_iw9_975, // 0x3cf
        cos_iw9_976, // 0x3d0
        cos_iw9_977, // 0x3d1
        cos_iw9_978, // 0x3d2
        cos_iw9_979, // 0x3d3
        cos_iw9_980, // 0x3d4
        cos_iw9_981, // 0x3d5
        cos_iw9_982, // 0x3d6
        cos_iw9_983, // 0x3d7
        cos_iw9_984, // 0x3d8
        cos_iw9_985, // 0x3d9
        cos_iw9_986, // 0x3da
        cos_iw9_987, // 0x3db
        cos_iw9_988, // 0x3dc
        cos_iw9_989, // 0x3dd
        cos_iw9_990, // 0x3de
        cos_iw9_991, // 0x3df
        cos_iw9_992, // 0x3e0
        cos_iw9_993, // 0x3e1
        cos_iw9_994, // 0x3e2
        cos_iw9_995, // 0x3e3
        cos_iw9_996, // 0x3e4
        cos_iw9_997, // 0x3e5
        cos_iw9_998, // 0x3e6
        cos_iw9_999 // 0x3e7
    };

    // idx 0xe members: 0x259 type: 0
    enum Sticker {
        none, // 0x0
        sticker_iw9_001, // 0x1
        sticker_iw9_002, // 0x2
        sticker_iw9_003, // 0x3
        sticker_iw9_004, // 0x4
        sticker_iw9_005, // 0x5
        sticker_iw9_006, // 0x6
        sticker_iw9_007, // 0x7
        sticker_iw9_008, // 0x8
        sticker_iw9_009, // 0x9
        sticker_iw9_010, // 0xa
        sticker_iw9_011, // 0xb
        sticker_iw9_012, // 0xc
        sticker_iw9_013, // 0xd
        sticker_iw9_014, // 0xe
        sticker_iw9_015, // 0xf
        sticker_iw9_016, // 0x10
        sticker_iw9_017, // 0x11
        sticker_iw9_018, // 0x12
        sticker_iw9_019, // 0x13
        sticker_iw9_020, // 0x14
        sticker_iw9_021, // 0x15
        sticker_iw9_022, // 0x16
        sticker_iw9_023, // 0x17
        sticker_iw9_024, // 0x18
        sticker_iw9_025, // 0x19
        sticker_iw9_026, // 0x1a
        sticker_iw9_027, // 0x1b
        sticker_iw9_028, // 0x1c
        sticker_iw9_029, // 0x1d
        sticker_iw9_030, // 0x1e
        sticker_iw9_031, // 0x1f
        sticker_iw9_032, // 0x20
        sticker_iw9_033, // 0x21
        sticker_iw9_034, // 0x22
        sticker_iw9_035, // 0x23
        sticker_iw9_036, // 0x24
        sticker_iw9_037, // 0x25
        sticker_iw9_038, // 0x26
        sticker_iw9_039, // 0x27
        sticker_iw9_040, // 0x28
        sticker_iw9_041, // 0x29
        sticker_iw9_042, // 0x2a
        sticker_iw9_043, // 0x2b
        sticker_iw9_044, // 0x2c
        sticker_iw9_045, // 0x2d
        sticker_iw9_046, // 0x2e
        sticker_iw9_047, // 0x2f
        sticker_iw9_048, // 0x30
        sticker_iw9_049, // 0x31
        sticker_iw9_050, // 0x32
        sticker_iw9_051, // 0x33
        sticker_iw9_052, // 0x34
        sticker_iw9_053, // 0x35
        sticker_iw9_054, // 0x36
        sticker_iw9_055, // 0x37
        sticker_iw9_056, // 0x38
        sticker_iw9_057, // 0x39
        sticker_iw9_058, // 0x3a
        sticker_iw9_059, // 0x3b
        sticker_iw9_060, // 0x3c
        sticker_iw9_061, // 0x3d
        sticker_iw9_062, // 0x3e
        sticker_iw9_063, // 0x3f
        sticker_iw9_064, // 0x40
        sticker_iw9_065, // 0x41
        sticker_iw9_066, // 0x42
        sticker_iw9_067, // 0x43
        sticker_iw9_068, // 0x44
        sticker_iw9_069, // 0x45
        sticker_iw9_070, // 0x46
        sticker_iw9_071, // 0x47
        sticker_iw9_072, // 0x48
        sticker_iw9_073, // 0x49
        sticker_iw9_074, // 0x4a
        sticker_iw9_075, // 0x4b
        sticker_iw9_076, // 0x4c
        sticker_iw9_077, // 0x4d
        sticker_iw9_078, // 0x4e
        sticker_iw9_079, // 0x4f
        sticker_iw9_080, // 0x50
        sticker_iw9_081, // 0x51
        sticker_iw9_082, // 0x52
        sticker_iw9_083, // 0x53
        sticker_iw9_084, // 0x54
        sticker_iw9_085, // 0x55
        sticker_iw9_086, // 0x56
        sticker_iw9_087, // 0x57
        sticker_iw9_088, // 0x58
        sticker_iw9_089, // 0x59
        sticker_iw9_090, // 0x5a
        sticker_iw9_091, // 0x5b
        sticker_iw9_092, // 0x5c
        sticker_iw9_093, // 0x5d
        sticker_iw9_094, // 0x5e
        sticker_iw9_095, // 0x5f
        sticker_iw9_096, // 0x60
        sticker_iw9_097, // 0x61
        sticker_iw9_098, // 0x62
        sticker_iw9_099, // 0x63
        sticker_iw9_100, // 0x64
        sticker_iw9_101, // 0x65
        sticker_iw9_102, // 0x66
        sticker_iw9_103, // 0x67
        sticker_iw9_104, // 0x68
        sticker_iw9_105, // 0x69
        sticker_iw9_106, // 0x6a
        sticker_iw9_107, // 0x6b
        sticker_iw9_108, // 0x6c
        sticker_iw9_109, // 0x6d
        sticker_iw9_110, // 0x6e
        sticker_iw9_111, // 0x6f
        sticker_iw9_112, // 0x70
        sticker_iw9_113, // 0x71
        sticker_iw9_114, // 0x72
        sticker_iw9_115, // 0x73
        sticker_iw9_116, // 0x74
        sticker_iw9_117, // 0x75
        sticker_iw9_118, // 0x76
        sticker_iw9_119, // 0x77
        sticker_iw9_120, // 0x78
        sticker_iw9_121, // 0x79
        sticker_iw9_122, // 0x7a
        sticker_iw9_123, // 0x7b
        sticker_iw9_124, // 0x7c
        sticker_iw9_125, // 0x7d
        sticker_iw9_126, // 0x7e
        sticker_iw9_127, // 0x7f
        sticker_iw9_128, // 0x80
        sticker_iw9_129, // 0x81
        sticker_iw9_130, // 0x82
        sticker_iw9_131, // 0x83
        sticker_iw9_132, // 0x84
        sticker_iw9_133, // 0x85
        sticker_iw9_134, // 0x86
        sticker_iw9_135, // 0x87
        sticker_iw9_136, // 0x88
        sticker_iw9_137, // 0x89
        sticker_iw9_138, // 0x8a
        sticker_iw9_139, // 0x8b
        sticker_iw9_140, // 0x8c
        sticker_iw9_141, // 0x8d
        sticker_iw9_142, // 0x8e
        sticker_iw9_143, // 0x8f
        sticker_iw9_144, // 0x90
        sticker_iw9_145, // 0x91
        sticker_iw9_146, // 0x92
        sticker_iw9_147, // 0x93
        sticker_iw9_148, // 0x94
        sticker_iw9_149, // 0x95
        sticker_iw9_150, // 0x96
        sticker_iw9_151, // 0x97
        sticker_iw9_152, // 0x98
        sticker_iw9_153, // 0x99
        sticker_iw9_154, // 0x9a
        sticker_iw9_155, // 0x9b
        sticker_iw9_156, // 0x9c
        sticker_iw9_157, // 0x9d
        sticker_iw9_158, // 0x9e
        sticker_iw9_159, // 0x9f
        sticker_iw9_160, // 0xa0
        sticker_iw9_161, // 0xa1
        sticker_iw9_162, // 0xa2
        sticker_iw9_163, // 0xa3
        sticker_iw9_164, // 0xa4
        sticker_iw9_165, // 0xa5
        sticker_iw9_166, // 0xa6
        sticker_iw9_167, // 0xa7
        sticker_iw9_168, // 0xa8
        sticker_iw9_169, // 0xa9
        sticker_iw9_170, // 0xaa
        sticker_iw9_171, // 0xab
        sticker_iw9_172, // 0xac
        sticker_iw9_173, // 0xad
        sticker_iw9_174, // 0xae
        sticker_iw9_175, // 0xaf
        sticker_iw9_176, // 0xb0
        sticker_iw9_177, // 0xb1
        sticker_iw9_178, // 0xb2
        sticker_iw9_179, // 0xb3
        sticker_iw9_180, // 0xb4
        sticker_iw9_181, // 0xb5
        sticker_iw9_182, // 0xb6
        sticker_iw9_183, // 0xb7
        sticker_iw9_184, // 0xb8
        sticker_iw9_185, // 0xb9
        sticker_iw9_186, // 0xba
        sticker_iw9_187, // 0xbb
        sticker_iw9_188, // 0xbc
        sticker_iw9_189, // 0xbd
        sticker_iw9_190, // 0xbe
        sticker_iw9_191, // 0xbf
        sticker_iw9_192, // 0xc0
        sticker_iw9_193, // 0xc1
        sticker_iw9_194, // 0xc2
        sticker_iw9_195, // 0xc3
        sticker_iw9_196, // 0xc4
        sticker_iw9_197, // 0xc5
        sticker_iw9_198, // 0xc6
        sticker_iw9_199, // 0xc7
        sticker_iw9_200, // 0xc8
        sticker_iw9_201, // 0xc9
        sticker_iw9_202, // 0xca
        sticker_iw9_203, // 0xcb
        sticker_iw9_204, // 0xcc
        sticker_iw9_205, // 0xcd
        sticker_iw9_206, // 0xce
        sticker_iw9_207, // 0xcf
        sticker_iw9_208, // 0xd0
        sticker_iw9_209, // 0xd1
        sticker_iw9_210, // 0xd2
        sticker_iw9_211, // 0xd3
        sticker_iw9_212, // 0xd4
        sticker_iw9_213, // 0xd5
        sticker_iw9_214, // 0xd6
        sticker_iw9_215, // 0xd7
        sticker_iw9_216, // 0xd8
        sticker_iw9_217, // 0xd9
        sticker_iw9_218, // 0xda
        sticker_iw9_219, // 0xdb
        sticker_iw9_220, // 0xdc
        sticker_iw9_221, // 0xdd
        sticker_iw9_222, // 0xde
        sticker_iw9_223, // 0xdf
        sticker_iw9_224, // 0xe0
        sticker_iw9_225, // 0xe1
        sticker_iw9_226, // 0xe2
        sticker_iw9_227, // 0xe3
        sticker_iw9_228, // 0xe4
        sticker_iw9_229, // 0xe5
        sticker_iw9_230, // 0xe6
        sticker_iw9_231, // 0xe7
        sticker_iw9_232, // 0xe8
        sticker_iw9_233, // 0xe9
        sticker_iw9_234, // 0xea
        sticker_iw9_235, // 0xeb
        sticker_iw9_236, // 0xec
        sticker_iw9_237, // 0xed
        sticker_iw9_238, // 0xee
        sticker_iw9_239, // 0xef
        sticker_iw9_240, // 0xf0
        sticker_iw9_241, // 0xf1
        sticker_iw9_242, // 0xf2
        sticker_iw9_243, // 0xf3
        sticker_iw9_244, // 0xf4
        sticker_iw9_245, // 0xf5
        sticker_iw9_246, // 0xf6
        sticker_iw9_247, // 0xf7
        sticker_iw9_248, // 0xf8
        sticker_iw9_249, // 0xf9
        sticker_iw9_250, // 0xfa
        sticker_iw9_251, // 0xfb
        sticker_iw9_252, // 0xfc
        sticker_iw9_253, // 0xfd
        sticker_iw9_254, // 0xfe
        sticker_iw9_255, // 0xff
        sticker_iw9_256, // 0x100
        sticker_iw9_257, // 0x101
        sticker_iw9_258, // 0x102
        sticker_iw9_259, // 0x103
        sticker_iw9_260, // 0x104
        sticker_iw9_261, // 0x105
        sticker_iw9_262, // 0x106
        sticker_iw9_263, // 0x107
        sticker_iw9_264, // 0x108
        sticker_iw9_265, // 0x109
        sticker_iw9_266, // 0x10a
        sticker_iw9_267, // 0x10b
        sticker_iw9_268, // 0x10c
        sticker_iw9_269, // 0x10d
        sticker_iw9_270, // 0x10e
        sticker_iw9_271, // 0x10f
        sticker_iw9_272, // 0x110
        sticker_iw9_273, // 0x111
        sticker_iw9_274, // 0x112
        sticker_iw9_275, // 0x113
        sticker_iw9_276, // 0x114
        sticker_iw9_277, // 0x115
        sticker_iw9_278, // 0x116
        sticker_iw9_279, // 0x117
        sticker_iw9_280, // 0x118
        sticker_iw9_281, // 0x119
        sticker_iw9_282, // 0x11a
        sticker_iw9_283, // 0x11b
        sticker_iw9_284, // 0x11c
        sticker_iw9_285, // 0x11d
        sticker_iw9_286, // 0x11e
        sticker_iw9_287, // 0x11f
        sticker_iw9_288, // 0x120
        sticker_iw9_289, // 0x121
        sticker_iw9_290, // 0x122
        sticker_iw9_291, // 0x123
        sticker_iw9_292, // 0x124
        sticker_iw9_293, // 0x125
        sticker_iw9_294, // 0x126
        sticker_iw9_295, // 0x127
        sticker_iw9_296, // 0x128
        sticker_iw9_297, // 0x129
        sticker_iw9_298, // 0x12a
        sticker_iw9_299, // 0x12b
        sticker_iw9_300, // 0x12c
        sticker_iw9_301, // 0x12d
        sticker_iw9_302, // 0x12e
        sticker_iw9_303, // 0x12f
        sticker_iw9_304, // 0x130
        sticker_iw9_305, // 0x131
        sticker_iw9_306, // 0x132
        sticker_iw9_307, // 0x133
        sticker_iw9_308, // 0x134
        sticker_iw9_309, // 0x135
        sticker_iw9_310, // 0x136
        sticker_iw9_311, // 0x137
        sticker_iw9_312, // 0x138
        sticker_iw9_313, // 0x139
        sticker_iw9_314, // 0x13a
        sticker_iw9_315, // 0x13b
        sticker_iw9_316, // 0x13c
        sticker_iw9_317, // 0x13d
        sticker_iw9_318, // 0x13e
        sticker_iw9_319, // 0x13f
        sticker_iw9_320, // 0x140
        sticker_iw9_321, // 0x141
        sticker_iw9_322, // 0x142
        sticker_iw9_323, // 0x143
        sticker_iw9_324, // 0x144
        sticker_iw9_325, // 0x145
        sticker_iw9_326, // 0x146
        sticker_iw9_327, // 0x147
        sticker_iw9_328, // 0x148
        sticker_iw9_329, // 0x149
        sticker_iw9_330, // 0x14a
        sticker_iw9_331, // 0x14b
        sticker_iw9_332, // 0x14c
        sticker_iw9_333, // 0x14d
        sticker_iw9_334, // 0x14e
        sticker_iw9_335, // 0x14f
        sticker_iw9_336, // 0x150
        sticker_iw9_337, // 0x151
        sticker_iw9_338, // 0x152
        sticker_iw9_339, // 0x153
        sticker_iw9_340, // 0x154
        sticker_iw9_341, // 0x155
        sticker_iw9_342, // 0x156
        sticker_iw9_343, // 0x157
        sticker_iw9_344, // 0x158
        sticker_iw9_345, // 0x159
        sticker_iw9_346, // 0x15a
        sticker_iw9_347, // 0x15b
        sticker_iw9_348, // 0x15c
        sticker_iw9_349, // 0x15d
        sticker_iw9_350, // 0x15e
        sticker_iw9_351, // 0x15f
        sticker_iw9_352, // 0x160
        sticker_iw9_353, // 0x161
        sticker_iw9_354, // 0x162
        sticker_iw9_355, // 0x163
        sticker_iw9_356, // 0x164
        sticker_iw9_357, // 0x165
        sticker_iw9_358, // 0x166
        sticker_iw9_359, // 0x167
        sticker_iw9_360, // 0x168
        sticker_iw9_361, // 0x169
        sticker_iw9_362, // 0x16a
        sticker_iw9_363, // 0x16b
        sticker_iw9_364, // 0x16c
        sticker_iw9_365, // 0x16d
        sticker_iw9_366, // 0x16e
        sticker_iw9_367, // 0x16f
        sticker_iw9_368, // 0x170
        sticker_iw9_369, // 0x171
        sticker_iw9_370, // 0x172
        sticker_iw9_371, // 0x173
        sticker_iw9_372, // 0x174
        sticker_iw9_373, // 0x175
        sticker_iw9_374, // 0x176
        sticker_iw9_375, // 0x177
        sticker_iw9_376, // 0x178
        sticker_iw9_377, // 0x179
        sticker_iw9_378, // 0x17a
        sticker_iw9_379, // 0x17b
        sticker_iw9_380, // 0x17c
        sticker_iw9_381, // 0x17d
        sticker_iw9_382, // 0x17e
        sticker_iw9_383, // 0x17f
        sticker_iw9_384, // 0x180
        sticker_iw9_385, // 0x181
        sticker_iw9_386, // 0x182
        sticker_iw9_387, // 0x183
        sticker_iw9_388, // 0x184
        sticker_iw9_389, // 0x185
        sticker_iw9_390, // 0x186
        sticker_iw9_391, // 0x187
        sticker_iw9_392, // 0x188
        sticker_iw9_393, // 0x189
        sticker_iw9_394, // 0x18a
        sticker_iw9_395, // 0x18b
        sticker_iw9_396, // 0x18c
        sticker_iw9_397, // 0x18d
        sticker_iw9_398, // 0x18e
        sticker_iw9_399, // 0x18f
        sticker_iw9_400, // 0x190
        sticker_iw9_401, // 0x191
        sticker_iw9_402, // 0x192
        sticker_iw9_403, // 0x193
        sticker_iw9_404, // 0x194
        sticker_iw9_405, // 0x195
        sticker_iw9_406, // 0x196
        sticker_iw9_407, // 0x197
        sticker_iw9_408, // 0x198
        sticker_iw9_409, // 0x199
        sticker_iw9_410, // 0x19a
        sticker_iw9_411, // 0x19b
        sticker_iw9_412, // 0x19c
        sticker_iw9_413, // 0x19d
        sticker_iw9_414, // 0x19e
        sticker_iw9_415, // 0x19f
        sticker_iw9_416, // 0x1a0
        sticker_iw9_417, // 0x1a1
        sticker_iw9_418, // 0x1a2
        sticker_iw9_419, // 0x1a3
        sticker_iw9_420, // 0x1a4
        sticker_iw9_421, // 0x1a5
        sticker_iw9_422, // 0x1a6
        sticker_iw9_423, // 0x1a7
        sticker_iw9_424, // 0x1a8
        sticker_iw9_425, // 0x1a9
        sticker_iw9_426, // 0x1aa
        sticker_iw9_427, // 0x1ab
        sticker_iw9_428, // 0x1ac
        sticker_iw9_429, // 0x1ad
        sticker_iw9_430, // 0x1ae
        sticker_iw9_431, // 0x1af
        sticker_iw9_432, // 0x1b0
        sticker_iw9_433, // 0x1b1
        sticker_iw9_434, // 0x1b2
        sticker_iw9_435, // 0x1b3
        sticker_iw9_436, // 0x1b4
        sticker_iw9_437, // 0x1b5
        sticker_iw9_438, // 0x1b6
        sticker_iw9_439, // 0x1b7
        sticker_iw9_440, // 0x1b8
        sticker_iw9_441, // 0x1b9
        sticker_iw9_442, // 0x1ba
        sticker_iw9_443, // 0x1bb
        sticker_iw9_444, // 0x1bc
        sticker_iw9_445, // 0x1bd
        sticker_iw9_446, // 0x1be
        sticker_iw9_447, // 0x1bf
        sticker_iw9_448, // 0x1c0
        sticker_iw9_449, // 0x1c1
        sticker_iw9_450, // 0x1c2
        sticker_iw9_451, // 0x1c3
        sticker_iw9_452, // 0x1c4
        sticker_iw9_453, // 0x1c5
        sticker_iw9_454, // 0x1c6
        sticker_iw9_455, // 0x1c7
        sticker_iw9_456, // 0x1c8
        sticker_iw9_457, // 0x1c9
        sticker_iw9_458, // 0x1ca
        sticker_iw9_459, // 0x1cb
        sticker_iw9_460, // 0x1cc
        sticker_iw9_461, // 0x1cd
        sticker_iw9_462, // 0x1ce
        sticker_iw9_463, // 0x1cf
        sticker_iw9_464, // 0x1d0
        sticker_iw9_465, // 0x1d1
        sticker_iw9_466, // 0x1d2
        sticker_iw9_467, // 0x1d3
        sticker_iw9_468, // 0x1d4
        sticker_iw9_469, // 0x1d5
        sticker_iw9_470, // 0x1d6
        sticker_iw9_471, // 0x1d7
        sticker_iw9_472, // 0x1d8
        sticker_iw9_473, // 0x1d9
        sticker_iw9_474, // 0x1da
        sticker_iw9_475, // 0x1db
        sticker_iw9_476, // 0x1dc
        sticker_iw9_477, // 0x1dd
        sticker_iw9_478, // 0x1de
        sticker_iw9_479, // 0x1df
        sticker_iw9_480, // 0x1e0
        sticker_iw9_481, // 0x1e1
        sticker_iw9_482, // 0x1e2
        sticker_iw9_483, // 0x1e3
        sticker_iw9_484, // 0x1e4
        sticker_iw9_485, // 0x1e5
        sticker_iw9_486, // 0x1e6
        sticker_iw9_487, // 0x1e7
        sticker_iw9_488, // 0x1e8
        sticker_iw9_489, // 0x1e9
        sticker_iw9_490, // 0x1ea
        sticker_iw9_491, // 0x1eb
        sticker_iw9_492, // 0x1ec
        sticker_iw9_493, // 0x1ed
        sticker_iw9_494, // 0x1ee
        sticker_iw9_495, // 0x1ef
        sticker_iw9_496, // 0x1f0
        sticker_iw9_497, // 0x1f1
        sticker_iw9_498, // 0x1f2
        sticker_iw9_499, // 0x1f3
        sticker_iw9_500, // 0x1f4
        vinyl_iw9_001, // 0x1f5
        vinyl_iw9_002, // 0x1f6
        vinyl_iw9_003, // 0x1f7
        vinyl_iw9_004, // 0x1f8
        vinyl_iw9_005, // 0x1f9
        vinyl_iw9_006, // 0x1fa
        vinyl_iw9_007, // 0x1fb
        vinyl_iw9_008, // 0x1fc
        vinyl_iw9_009, // 0x1fd
        vinyl_iw9_010, // 0x1fe
        vinyl_iw9_011, // 0x1ff
        vinyl_iw9_012, // 0x200
        vinyl_iw9_013, // 0x201
        vinyl_iw9_014, // 0x202
        vinyl_iw9_015, // 0x203
        vinyl_iw9_016, // 0x204
        vinyl_iw9_017, // 0x205
        vinyl_iw9_018, // 0x206
        vinyl_iw9_019, // 0x207
        vinyl_iw9_020, // 0x208
        vinyl_iw9_021, // 0x209
        vinyl_iw9_022, // 0x20a
        vinyl_iw9_023, // 0x20b
        vinyl_iw9_024, // 0x20c
        vinyl_iw9_025, // 0x20d
        vinyl_iw9_026, // 0x20e
        vinyl_iw9_027, // 0x20f
        vinyl_iw9_028, // 0x210
        vinyl_iw9_029, // 0x211
        vinyl_iw9_030, // 0x212
        vinyl_iw9_031, // 0x213
        vinyl_iw9_032, // 0x214
        vinyl_iw9_033, // 0x215
        vinyl_iw9_034, // 0x216
        vinyl_iw9_035, // 0x217
        vinyl_iw9_036, // 0x218
        vinyl_iw9_037, // 0x219
        vinyl_iw9_038, // 0x21a
        vinyl_iw9_039, // 0x21b
        vinyl_iw9_040, // 0x21c
        vinyl_iw9_041, // 0x21d
        vinyl_iw9_042, // 0x21e
        vinyl_iw9_043, // 0x21f
        vinyl_iw9_044, // 0x220
        vinyl_iw9_045, // 0x221
        vinyl_iw9_046, // 0x222
        vinyl_iw9_047, // 0x223
        vinyl_iw9_048, // 0x224
        vinyl_iw9_049, // 0x225
        vinyl_iw9_050, // 0x226
        vinyl_iw9_051, // 0x227
        vinyl_iw9_052, // 0x228
        vinyl_iw9_053, // 0x229
        vinyl_iw9_054, // 0x22a
        vinyl_iw9_055, // 0x22b
        vinyl_iw9_056, // 0x22c
        vinyl_iw9_057, // 0x22d
        vinyl_iw9_058, // 0x22e
        vinyl_iw9_059, // 0x22f
        vinyl_iw9_060, // 0x230
        vinyl_iw9_061, // 0x231
        vinyl_iw9_062, // 0x232
        vinyl_iw9_063, // 0x233
        vinyl_iw9_064, // 0x234
        vinyl_iw9_065, // 0x235
        vinyl_iw9_066, // 0x236
        vinyl_iw9_067, // 0x237
        vinyl_iw9_068, // 0x238
        vinyl_iw9_069, // 0x239
        vinyl_iw9_070, // 0x23a
        vinyl_iw9_071, // 0x23b
        vinyl_iw9_072, // 0x23c
        vinyl_iw9_073, // 0x23d
        vinyl_iw9_074, // 0x23e
        vinyl_iw9_075, // 0x23f
        vinyl_iw9_076, // 0x240
        vinyl_iw9_077, // 0x241
        vinyl_iw9_078, // 0x242
        vinyl_iw9_079, // 0x243
        vinyl_iw9_080, // 0x244
        vinyl_iw9_081, // 0x245
        vinyl_iw9_082, // 0x246
        vinyl_iw9_083, // 0x247
        vinyl_iw9_084, // 0x248
        vinyl_iw9_085, // 0x249
        vinyl_iw9_086, // 0x24a
        vinyl_iw9_087, // 0x24b
        vinyl_iw9_088, // 0x24c
        vinyl_iw9_089, // 0x24d
        vinyl_iw9_090, // 0x24e
        vinyl_iw9_091, // 0x24f
        vinyl_iw9_092, // 0x250
        vinyl_iw9_093, // 0x251
        vinyl_iw9_094, // 0x252
        vinyl_iw9_095, // 0x253
        vinyl_iw9_096, // 0x254
        vinyl_iw9_097, // 0x255
        vinyl_iw9_098, // 0x256
        vinyl_iw9_099, // 0x257
        vinyl_iw9_100 // 0x258
    };

    // idx 0xf members: 0x19 type: 0
    enum Super {
        none, // 0x0
        super_tac_cover, // 0x1
        super_recon_drone, // 0x2
        super_emp_drone, // 0x3
        super_support_box, // 0x4
        super_laststand_heal, // 0x5
        super_trophy, // 0x6
        super_deadsilence, // 0x7
        super_tac_insert, // 0x8
        super_ammo_drop, // 0x9
        super_weapon_drop, // 0xa
        super_tac_camera, // 0xb
        super_suppression_rounds, // 0xc
        super_sonar_pulse, // 0xd
        super_emp_pulse, // 0xe
        super_battlerage, // 0xf
        super_armor_drop, // 0x10
        super_stimpistol, // 0x11
        super_sound_veil, // 0x12
        super_blastshield_drop, // 0x13
        super_smoke_airdrop, // 0x14
        super_blinding_turret, // 0x15
        super_deployed_decoy, // 0x16
        super_loadout_drop, // 0x17
        super_leader_drop // 0x18
    };

    // idx 0x10 members: 0x7 type: 0
    enum CPSuper {
        none, // 0x0
        role_tank, // 0x1
        role_hunter, // 0x2
        role_engineer, // 0x3
        role_demolition, // 0x4
        role_medic, // 0x5
        role_assault // 0x6
    };

    // idx 0x11 members: 0x1e type: 0
    enum Munition {
        none, // 0x0
        empty1, // 0x1
        empty2, // 0x2
        empty3, // 0x3
        ammo_crate, // 0x4
        armor, // 0x5
        grenade_crate, // 0x6
        trophysystem, // 0x7
        sentry, // 0x8
        drone_strike, // 0x9
        ac130, // 0xa
        scout_drone, // 0xb
        riot_shield, // 0xc
        adrenaline, // 0xd
        deployable_cover, // 0xe
        manual_turret, // 0xf
        grenade_launcher, // 0x10
        recon_drone, // 0x11
        nvg, // 0x12
        molotov, // 0x13
        apache, // 0x14
        precision_airstrike, // 0x15
        respawn, // 0x16
        auav, // 0x17
        cluster_strike, // 0x18
        uav, // 0x19
        white_phos, // 0x1a
        hover_jet, // 0x1b
        juggernaut, // 0x1c
        cruise_missile // 0x1d
    };

    // idx 0x12 members: 0x190 type: 0
    enum HeadCustomization {
        head_none, // 0x0
        head_1, // 0x1
        head_2, // 0x2
        head_3, // 0x3
        head_4, // 0x4
        head_5, // 0x5
        head_6, // 0x6
        head_7, // 0x7
        head_8, // 0x8
        head_9, // 0x9
        head_10, // 0xa
        head_11, // 0xb
        head_12, // 0xc
        head_13, // 0xd
        head_14, // 0xe
        head_15, // 0xf
        head_16, // 0x10
        head_17, // 0x11
        head_18, // 0x12
        head_19, // 0x13
        head_20, // 0x14
        head_21, // 0x15
        head_22, // 0x16
        head_23, // 0x17
        head_24, // 0x18
        head_25, // 0x19
        head_26, // 0x1a
        head_27, // 0x1b
        head_28, // 0x1c
        head_29, // 0x1d
        head_30, // 0x1e
        head_31, // 0x1f
        head_32, // 0x20
        head_33, // 0x21
        head_34, // 0x22
        head_35, // 0x23
        head_36, // 0x24
        head_37, // 0x25
        head_38, // 0x26
        head_39, // 0x27
        head_40, // 0x28
        head_41, // 0x29
        head_42, // 0x2a
        head_43, // 0x2b
        head_44, // 0x2c
        head_45, // 0x2d
        head_46, // 0x2e
        head_47, // 0x2f
        head_48, // 0x30
        head_49, // 0x31
        head_50, // 0x32
        head_51, // 0x33
        head_52, // 0x34
        head_53, // 0x35
        head_54, // 0x36
        head_55, // 0x37
        head_56, // 0x38
        head_57, // 0x39
        head_58, // 0x3a
        head_59, // 0x3b
        head_60, // 0x3c
        head_61, // 0x3d
        head_62, // 0x3e
        head_63, // 0x3f
        head_64, // 0x40
        head_65, // 0x41
        head_66, // 0x42
        head_67, // 0x43
        head_68, // 0x44
        head_69, // 0x45
        head_70, // 0x46
        head_71, // 0x47
        head_72, // 0x48
        head_73, // 0x49
        head_74, // 0x4a
        head_75, // 0x4b
        head_76, // 0x4c
        head_77, // 0x4d
        head_78, // 0x4e
        head_79, // 0x4f
        head_80, // 0x50
        head_81, // 0x51
        head_82, // 0x52
        head_83, // 0x53
        head_84, // 0x54
        head_85, // 0x55
        head_86, // 0x56
        head_87, // 0x57
        head_88, // 0x58
        head_89, // 0x59
        head_90, // 0x5a
        head_91, // 0x5b
        head_92, // 0x5c
        head_93, // 0x5d
        head_94, // 0x5e
        head_95, // 0x5f
        head_96, // 0x60
        head_97, // 0x61
        head_98, // 0x62
        head_99, // 0x63
        head_100, // 0x64
        head_101, // 0x65
        head_102, // 0x66
        head_103, // 0x67
        head_104, // 0x68
        head_105, // 0x69
        head_106, // 0x6a
        head_107, // 0x6b
        head_108, // 0x6c
        head_109, // 0x6d
        head_110, // 0x6e
        head_111, // 0x6f
        head_112, // 0x70
        head_113, // 0x71
        head_114, // 0x72
        head_115, // 0x73
        head_116, // 0x74
        head_117, // 0x75
        head_118, // 0x76
        head_119, // 0x77
        head_120, // 0x78
        head_121, // 0x79
        head_122, // 0x7a
        head_123, // 0x7b
        head_124, // 0x7c
        head_125, // 0x7d
        head_126, // 0x7e
        head_127, // 0x7f
        head_128, // 0x80
        head_129, // 0x81
        head_130, // 0x82
        head_131, // 0x83
        head_132, // 0x84
        head_133, // 0x85
        head_134, // 0x86
        head_135, // 0x87
        head_136, // 0x88
        head_137, // 0x89
        head_138, // 0x8a
        head_139, // 0x8b
        head_140, // 0x8c
        head_141, // 0x8d
        head_142, // 0x8e
        head_143, // 0x8f
        head_144, // 0x90
        head_145, // 0x91
        head_146, // 0x92
        head_147, // 0x93
        head_148, // 0x94
        head_149, // 0x95
        head_150, // 0x96
        head_151, // 0x97
        head_152, // 0x98
        head_153, // 0x99
        head_154, // 0x9a
        head_155, // 0x9b
        head_156, // 0x9c
        head_157, // 0x9d
        head_158, // 0x9e
        head_159, // 0x9f
        head_160, // 0xa0
        head_161, // 0xa1
        head_162, // 0xa2
        head_163, // 0xa3
        head_164, // 0xa4
        head_165, // 0xa5
        head_166, // 0xa6
        head_167, // 0xa7
        head_168, // 0xa8
        head_169, // 0xa9
        head_170, // 0xaa
        head_171, // 0xab
        head_172, // 0xac
        head_173, // 0xad
        head_174, // 0xae
        head_175, // 0xaf
        head_176, // 0xb0
        head_177, // 0xb1
        head_178, // 0xb2
        head_179, // 0xb3
        head_180, // 0xb4
        head_181, // 0xb5
        head_182, // 0xb6
        head_183, // 0xb7
        head_184, // 0xb8
        head_185, // 0xb9
        head_186, // 0xba
        head_187, // 0xbb
        head_188, // 0xbc
        head_189, // 0xbd
        head_190, // 0xbe
        head_191, // 0xbf
        head_192, // 0xc0
        head_193, // 0xc1
        head_194, // 0xc2
        head_195, // 0xc3
        head_196, // 0xc4
        head_197, // 0xc5
        head_198, // 0xc6
        head_199, // 0xc7
        head_200, // 0xc8
        head_201, // 0xc9
        head_202, // 0xca
        head_203, // 0xcb
        head_204, // 0xcc
        head_205, // 0xcd
        head_206, // 0xce
        head_207, // 0xcf
        head_208, // 0xd0
        head_209, // 0xd1
        head_210, // 0xd2
        head_211, // 0xd3
        head_212, // 0xd4
        head_213, // 0xd5
        head_214, // 0xd6
        head_215, // 0xd7
        head_216, // 0xd8
        head_217, // 0xd9
        head_218, // 0xda
        head_219, // 0xdb
        head_220, // 0xdc
        head_221, // 0xdd
        head_222, // 0xde
        head_223, // 0xdf
        head_224, // 0xe0
        head_225, // 0xe1
        head_226, // 0xe2
        head_227, // 0xe3
        head_228, // 0xe4
        head_229, // 0xe5
        head_230, // 0xe6
        head_231, // 0xe7
        head_232, // 0xe8
        head_233, // 0xe9
        head_234, // 0xea
        head_235, // 0xeb
        head_236, // 0xec
        head_237, // 0xed
        head_238, // 0xee
        head_239, // 0xef
        head_240, // 0xf0
        head_241, // 0xf1
        head_242, // 0xf2
        head_243, // 0xf3
        head_244, // 0xf4
        head_245, // 0xf5
        head_246, // 0xf6
        head_247, // 0xf7
        head_248, // 0xf8
        head_249, // 0xf9
        head_250, // 0xfa
        head_251, // 0xfb
        head_252, // 0xfc
        head_253, // 0xfd
        head_254, // 0xfe
        head_255, // 0xff
        head_256, // 0x100
        head_257, // 0x101
        head_258, // 0x102
        head_259, // 0x103
        head_260, // 0x104
        head_261, // 0x105
        head_262, // 0x106
        head_263, // 0x107
        head_264, // 0x108
        head_265, // 0x109
        head_266, // 0x10a
        head_267, // 0x10b
        head_268, // 0x10c
        head_269, // 0x10d
        head_270, // 0x10e
        head_271, // 0x10f
        head_272, // 0x110
        head_273, // 0x111
        head_274, // 0x112
        head_275, // 0x113
        head_276, // 0x114
        head_277, // 0x115
        head_278, // 0x116
        head_279, // 0x117
        head_280, // 0x118
        head_281, // 0x119
        head_282, // 0x11a
        head_283, // 0x11b
        head_284, // 0x11c
        head_285, // 0x11d
        head_286, // 0x11e
        head_287, // 0x11f
        head_288, // 0x120
        head_289, // 0x121
        head_290, // 0x122
        head_291, // 0x123
        head_292, // 0x124
        head_293, // 0x125
        head_294, // 0x126
        head_295, // 0x127
        head_296, // 0x128
        head_297, // 0x129
        head_298, // 0x12a
        head_299, // 0x12b
        head_300, // 0x12c
        head_301, // 0x12d
        head_302, // 0x12e
        head_303, // 0x12f
        head_304, // 0x130
        head_305, // 0x131
        head_306, // 0x132
        head_307, // 0x133
        head_308, // 0x134
        head_309, // 0x135
        head_310, // 0x136
        head_311, // 0x137
        head_312, // 0x138
        head_313, // 0x139
        head_314, // 0x13a
        head_315, // 0x13b
        head_316, // 0x13c
        head_317, // 0x13d
        head_318, // 0x13e
        head_319, // 0x13f
        head_320, // 0x140
        head_321, // 0x141
        head_322, // 0x142
        head_323, // 0x143
        head_324, // 0x144
        head_325, // 0x145
        head_326, // 0x146
        head_327, // 0x147
        head_328, // 0x148
        head_329, // 0x149
        head_330, // 0x14a
        head_331, // 0x14b
        head_332, // 0x14c
        head_333, // 0x14d
        head_334, // 0x14e
        head_335, // 0x14f
        head_336, // 0x150
        head_337, // 0x151
        head_338, // 0x152
        head_339, // 0x153
        head_340, // 0x154
        head_341, // 0x155
        head_342, // 0x156
        head_343, // 0x157
        head_344, // 0x158
        head_345, // 0x159
        head_346, // 0x15a
        head_347, // 0x15b
        head_348, // 0x15c
        head_349, // 0x15d
        head_350, // 0x15e
        head_351, // 0x15f
        head_352, // 0x160
        head_353, // 0x161
        head_354, // 0x162
        head_355, // 0x163
        head_356, // 0x164
        head_357, // 0x165
        head_358, // 0x166
        head_359, // 0x167
        head_360, // 0x168
        head_361, // 0x169
        head_362, // 0x16a
        head_363, // 0x16b
        head_364, // 0x16c
        head_365, // 0x16d
        head_366, // 0x16e
        head_367, // 0x16f
        head_368, // 0x170
        head_369, // 0x171
        head_370, // 0x172
        head_371, // 0x173
        head_372, // 0x174
        head_373, // 0x175
        head_374, // 0x176
        head_375, // 0x177
        head_376, // 0x178
        head_377, // 0x179
        head_378, // 0x17a
        head_379, // 0x17b
        head_380, // 0x17c
        head_381, // 0x17d
        head_382, // 0x17e
        head_383, // 0x17f
        head_384, // 0x180
        head_385, // 0x181
        head_386, // 0x182
        head_387, // 0x183
        head_388, // 0x184
        head_389, // 0x185
        head_390, // 0x186
        head_391, // 0x187
        head_392, // 0x188
        head_393, // 0x189
        head_394, // 0x18a
        head_395, // 0x18b
        head_396, // 0x18c
        head_397, // 0x18d
        head_398, // 0x18e
        head_399 // 0x18f
    };

    // idx 0x13 members: 0x12c type: 0
    enum BodyCustomization {
        body_0, // 0x0
        body_1, // 0x1
        body_2, // 0x2
        body_3, // 0x3
        body_4, // 0x4
        body_5, // 0x5
        body_6, // 0x6
        body_7, // 0x7
        body_8, // 0x8
        body_9, // 0x9
        body_10, // 0xa
        body_11, // 0xb
        body_12, // 0xc
        body_13, // 0xd
        body_14, // 0xe
        body_15, // 0xf
        body_16, // 0x10
        body_17, // 0x11
        body_18, // 0x12
        body_19, // 0x13
        body_20, // 0x14
        body_21, // 0x15
        body_22, // 0x16
        body_23, // 0x17
        body_24, // 0x18
        body_25, // 0x19
        body_26, // 0x1a
        body_27, // 0x1b
        body_28, // 0x1c
        body_29, // 0x1d
        body_30, // 0x1e
        body_31, // 0x1f
        body_32, // 0x20
        body_33, // 0x21
        body_34, // 0x22
        body_35, // 0x23
        body_36, // 0x24
        body_37, // 0x25
        body_38, // 0x26
        body_39, // 0x27
        body_40, // 0x28
        body_41, // 0x29
        body_42, // 0x2a
        body_43, // 0x2b
        body_44, // 0x2c
        body_45, // 0x2d
        body_46, // 0x2e
        body_47, // 0x2f
        body_48, // 0x30
        body_49, // 0x31
        body_50, // 0x32
        body_51, // 0x33
        body_52, // 0x34
        body_53, // 0x35
        body_54, // 0x36
        body_55, // 0x37
        body_56, // 0x38
        body_57, // 0x39
        body_58, // 0x3a
        body_59, // 0x3b
        body_60, // 0x3c
        body_61, // 0x3d
        body_62, // 0x3e
        body_63, // 0x3f
        body_64, // 0x40
        body_65, // 0x41
        body_66, // 0x42
        body_67, // 0x43
        body_68, // 0x44
        body_69, // 0x45
        body_70, // 0x46
        body_71, // 0x47
        body_72, // 0x48
        body_73, // 0x49
        body_74, // 0x4a
        body_75, // 0x4b
        body_76, // 0x4c
        body_77, // 0x4d
        body_78, // 0x4e
        body_79, // 0x4f
        body_80, // 0x50
        body_81, // 0x51
        body_82, // 0x52
        body_83, // 0x53
        body_84, // 0x54
        body_85, // 0x55
        body_86, // 0x56
        body_87, // 0x57
        body_88, // 0x58
        body_89, // 0x59
        body_90, // 0x5a
        body_91, // 0x5b
        body_92, // 0x5c
        body_93, // 0x5d
        body_94, // 0x5e
        body_95, // 0x5f
        body_96, // 0x60
        body_97, // 0x61
        body_98, // 0x62
        body_99, // 0x63
        body_100, // 0x64
        body_101, // 0x65
        body_102, // 0x66
        body_103, // 0x67
        body_104, // 0x68
        body_105, // 0x69
        body_106, // 0x6a
        body_107, // 0x6b
        body_108, // 0x6c
        body_109, // 0x6d
        body_110, // 0x6e
        body_111, // 0x6f
        body_112, // 0x70
        body_113, // 0x71
        body_114, // 0x72
        body_115, // 0x73
        body_116, // 0x74
        body_117, // 0x75
        body_118, // 0x76
        body_119, // 0x77
        body_120, // 0x78
        body_121, // 0x79
        body_122, // 0x7a
        body_123, // 0x7b
        body_124, // 0x7c
        body_125, // 0x7d
        body_126, // 0x7e
        body_127, // 0x7f
        body_128, // 0x80
        body_129, // 0x81
        body_130, // 0x82
        body_131, // 0x83
        body_132, // 0x84
        body_133, // 0x85
        body_134, // 0x86
        body_135, // 0x87
        body_136, // 0x88
        body_137, // 0x89
        body_138, // 0x8a
        body_139, // 0x8b
        body_140, // 0x8c
        body_141, // 0x8d
        body_142, // 0x8e
        body_143, // 0x8f
        body_144, // 0x90
        body_145, // 0x91
        body_146, // 0x92
        body_147, // 0x93
        body_148, // 0x94
        body_149, // 0x95
        body_150, // 0x96
        body_151, // 0x97
        body_152, // 0x98
        body_153, // 0x99
        body_154, // 0x9a
        body_155, // 0x9b
        body_156, // 0x9c
        body_157, // 0x9d
        body_158, // 0x9e
        body_159, // 0x9f
        body_160, // 0xa0
        body_161, // 0xa1
        body_162, // 0xa2
        body_163, // 0xa3
        body_164, // 0xa4
        body_165, // 0xa5
        body_166, // 0xa6
        body_167, // 0xa7
        body_168, // 0xa8
        body_169, // 0xa9
        body_170, // 0xaa
        body_171, // 0xab
        body_172, // 0xac
        body_173, // 0xad
        body_174, // 0xae
        body_175, // 0xaf
        body_176, // 0xb0
        body_177, // 0xb1
        body_178, // 0xb2
        body_179, // 0xb3
        body_180, // 0xb4
        body_181, // 0xb5
        body_182, // 0xb6
        body_183, // 0xb7
        body_184, // 0xb8
        body_185, // 0xb9
        body_186, // 0xba
        body_187, // 0xbb
        body_188, // 0xbc
        body_189, // 0xbd
        body_190, // 0xbe
        body_191, // 0xbf
        body_192, // 0xc0
        body_193, // 0xc1
        body_194, // 0xc2
        body_195, // 0xc3
        body_196, // 0xc4
        body_197, // 0xc5
        body_198, // 0xc6
        body_199, // 0xc7
        body_200, // 0xc8
        body_201, // 0xc9
        body_202, // 0xca
        body_203, // 0xcb
        body_204, // 0xcc
        body_205, // 0xcd
        body_206, // 0xce
        body_207, // 0xcf
        body_208, // 0xd0
        body_209, // 0xd1
        body_210, // 0xd2
        body_211, // 0xd3
        body_212, // 0xd4
        body_213, // 0xd5
        body_214, // 0xd6
        body_215, // 0xd7
        body_216, // 0xd8
        body_217, // 0xd9
        body_218, // 0xda
        body_219, // 0xdb
        body_220, // 0xdc
        body_221, // 0xdd
        body_222, // 0xde
        body_223, // 0xdf
        body_224, // 0xe0
        body_225, // 0xe1
        body_226, // 0xe2
        body_227, // 0xe3
        body_228, // 0xe4
        body_229, // 0xe5
        body_230, // 0xe6
        body_231, // 0xe7
        body_232, // 0xe8
        body_233, // 0xe9
        body_234, // 0xea
        body_235, // 0xeb
        body_236, // 0xec
        body_237, // 0xed
        body_238, // 0xee
        body_239, // 0xef
        body_240, // 0xf0
        body_241, // 0xf1
        body_242, // 0xf2
        body_243, // 0xf3
        body_244, // 0xf4
        body_245, // 0xf5
        body_246, // 0xf6
        body_247, // 0xf7
        body_248, // 0xf8
        body_249, // 0xf9
        body_250, // 0xfa
        body_251, // 0xfb
        body_252, // 0xfc
        body_253, // 0xfd
        body_254, // 0xfe
        body_255, // 0xff
        body_256, // 0x100
        body_257, // 0x101
        body_258, // 0x102
        body_259, // 0x103
        body_260, // 0x104
        body_261, // 0x105
        body_262, // 0x106
        body_263, // 0x107
        body_264, // 0x108
        body_265, // 0x109
        body_266, // 0x10a
        body_267, // 0x10b
        body_268, // 0x10c
        body_269, // 0x10d
        body_270, // 0x10e
        body_271, // 0x10f
        body_272, // 0x110
        body_273, // 0x111
        body_274, // 0x112
        body_275, // 0x113
        body_276, // 0x114
        body_277, // 0x115
        body_278, // 0x116
        body_279, // 0x117
        body_280, // 0x118
        body_281, // 0x119
        body_282, // 0x11a
        body_283, // 0x11b
        body_284, // 0x11c
        body_285, // 0x11d
        body_286, // 0x11e
        body_287, // 0x11f
        body_288, // 0x120
        body_289, // 0x121
        body_290, // 0x122
        body_291, // 0x123
        body_292, // 0x124
        body_293, // 0x125
        body_294, // 0x126
        body_295, // 0x127
        body_296, // 0x128
        body_297, // 0x129
        body_298, // 0x12a
        body_299 // 0x12b
    };

    // idx 0x14 members: 0x53 type: 0
    enum TauntCustomization {
        iw7_taunt_rare_1, // 0x0
        iw7_taunt_rare_2, // 0x1
        iw7_taunt_rare_3, // 0x2
        iw7_taunt_rare_4, // 0x3
        iw7_taunt_rare_5, // 0x4
        iw7_taunt_rare_6, // 0x5
        iw7_taunt_rare_7, // 0x6
        iw7_taunt_rare_8, // 0x7
        iw7_taunt_rare_9, // 0x8
        iw7_taunt_rare_10, // 0x9
        iw7_taunt_rare_11, // 0xa
        iw7_taunt_rare_12, // 0xb
        iw7_taunt_rare_13, // 0xc
        iw7_taunt_rare_14, // 0xd
        iw7_taunt_rare_15, // 0xe
        iw7_taunt_rare_16, // 0xf
        iw7_taunt_rare_17, // 0x10
        iw7_taunt_rare_18, // 0x11
        iw7_taunt_rare_19, // 0x12
        iw7_taunt_rare_20, // 0x13
        iw7_taunt_rare_21, // 0x14
        iw7_taunt_rare_22, // 0x15
        iw7_taunt_rare_23, // 0x16
        iw7_taunt_rare_24, // 0x17
        iw7_taunt_rare_25, // 0x18
        iw7_taunt_rare_26, // 0x19
        iw7_taunt_rare_27, // 0x1a
        iw7_taunt_rare_28, // 0x1b
        iw7_taunt_rare_29, // 0x1c
        iw7_taunt_rare_30, // 0x1d
        iw7_taunt_legendary_1, // 0x1e
        iw7_taunt_legendary_2, // 0x1f
        iw7_taunt_legendary_3, // 0x20
        iw7_taunt_legendary_4, // 0x21
        iw7_taunt_legendary_5, // 0x22
        iw7_taunt_legendary_6, // 0x23
        iw7_taunt_legendary_7, // 0x24
        iw7_taunt_legendary_8, // 0x25
        iw7_taunt_legendary_9, // 0x26
        iw7_taunt_legendary_10, // 0x27
        iw7_taunt_legendary_11, // 0x28
        iw7_taunt_legendary_12, // 0x29
        iw7_taunt_legendary_13, // 0x2a
        iw7_taunt_legendary_14, // 0x2b
        iw7_taunt_legendary_15, // 0x2c
        iw7_taunt_legendary_16, // 0x2d
        iw7_taunt_legendary_17, // 0x2e
        iw7_taunt_legendary_18, // 0x2f
        iw7_taunt_legendary_19, // 0x30
        iw7_taunt_legendary_20, // 0x31
        iw7_taunt_epic_1, // 0x32
        iw7_taunt_epic_2, // 0x33
        iw7_taunt_epic_3, // 0x34
        iw7_taunt_epic_4, // 0x35
        iw7_taunt_epic_5, // 0x36
        iw7_taunt_epic_6, // 0x37
        iw7_taunt_epic_7, // 0x38
        iw7_taunt_epic_8, // 0x39
        iw7_taunt_epic_9, // 0x3a
        iw7_taunt_epic_10, // 0x3b
        iw7_taunt_epic_11, // 0x3c
        iw7_taunt_epic_12, // 0x3d
        iw7_taunt_epic_13, // 0x3e
        iw7_taunt_epic_14, // 0x3f
        iw7_taunt_team1_rare_1, // 0x40
        iw7_taunt_team1_rare_2, // 0x41
        iw7_taunt_team1_legendary_1, // 0x42
        iw7_taunt_team2_rare_1, // 0x43
        iw7_taunt_team2_rare_2, // 0x44
        iw7_taunt_team2_legendary_1, // 0x45
        iw7_taunt_team3_rare_1, // 0x46
        iw7_taunt_team3_rare_2, // 0x47
        iw7_taunt_team3_legendary_1, // 0x48
        iw7_taunt_team4_rare_1, // 0x49
        iw7_taunt_team4_rare_2, // 0x4a
        iw7_taunt_team4_legendary_1, // 0x4b
        iw7_taunt_team5_rare_1, // 0x4c
        iw7_taunt_team5_rare_2, // 0x4d
        iw7_taunt_team5_legendary_1, // 0x4e
        iw7_taunt_cod_champs, // 0x4f
        iw7_taunt_epic_15, // 0x50
        iw7_taunt_epic_16, // 0x51
        iw7_taunt_epic_17 // 0x52
    };

    // idx 0x15 members: 0x43 type: 0
    enum Gesture {
        devilhorns_mp, // 0x0
        fallback_mp, // 0x1
        hold_mp, // 0x2
        moveup_mp, // 0x3
        point_mp, // 0x4
        gesture000, // 0x5
        gesture001, // 0x6
        gesture002, // 0x7
        gesture003, // 0x8
        gesture004, // 0x9
        gesture005, // 0xa
        gesture006, // 0xb
        gesture007, // 0xc
        gesture008, // 0xd
        gesture009, // 0xe
        gesture010, // 0xf
        gesture011, // 0x10
        gesture012, // 0x11
        gesture013, // 0x12
        gesture014, // 0x13
        gesture015, // 0x14
        gesture016, // 0x15
        gesture017, // 0x16
        gesture018, // 0x17
        gesture019, // 0x18
        gesture020, // 0x19
        gesture021, // 0x1a
        gesture022, // 0x1b
        gesture023, // 0x1c
        gesture024, // 0x1d
        gesture025, // 0x1e
        gesture026, // 0x1f
        gesture027, // 0x20
        gesture028, // 0x21
        gesture029, // 0x22
        gesture030, // 0x23
        gesture031, // 0x24
        gesture032, // 0x25
        gesture033, // 0x26
        gesture034, // 0x27
        gesture035, // 0x28
        gesture036, // 0x29
        gesture037, // 0x2a
        gesture038, // 0x2b
        gesture039, // 0x2c
        gesture040, // 0x2d
        gesture041, // 0x2e
        gesture042, // 0x2f
        gesture043, // 0x30
        gesture044, // 0x31
        gesture045, // 0x32
        gesture046, // 0x33
        gesture047, // 0x34
        gesture048, // 0x35
        gesture049, // 0x36
        gesture050, // 0x37
        gesture051, // 0x38
        gesture052, // 0x39
        gesture053, // 0x3a
        gesture054, // 0x3b
        gesture055, // 0x3c
        gesture056, // 0x3d
        gesture057, // 0x3e
        gesture058, // 0x3f
        gesture059, // 0x40
        gesture114, // 0x41
        gesture115 // 0x42
    };

    // idx 0x16 members: 0x3b type: 0
    enum Accessory {
        accessory000, // 0x0
        accessory001, // 0x1
        accessory002, // 0x2
        accessory003, // 0x3
        accessory004, // 0x4
        accessory005, // 0x5
        accessory006, // 0x6
        accessory007, // 0x7
        accessory008, // 0x8
        accessory009, // 0x9
        accessory010, // 0xa
        accessory011, // 0xb
        accessory012, // 0xc
        accessory013, // 0xd
        accessory014, // 0xe
        accessory015, // 0xf
        accessory016, // 0x10
        accessory017, // 0x11
        accessory018, // 0x12
        accessory019, // 0x13
        accessory020, // 0x14
        accessory021, // 0x15
        accessory022, // 0x16
        accessory023, // 0x17
        accessory024, // 0x18
        accessory025, // 0x19
        accessory026, // 0x1a
        accessory027, // 0x1b
        accessory028, // 0x1c
        accessory029, // 0x1d
        accessory030, // 0x1e
        accessory031, // 0x1f
        accessory032, // 0x20
        accessory033, // 0x21
        accessory034, // 0x22
        accessory035, // 0x23
        accessory036, // 0x24
        accessory037, // 0x25
        accessory038, // 0x26
        accessory039, // 0x27
        accessory040, // 0x28
        accessory041, // 0x29
        accessory042, // 0x2a
        accessory043, // 0x2b
        accessory044, // 0x2c
        accessory045, // 0x2d
        accessory046, // 0x2e
        accessory047, // 0x2f
        accessory048, // 0x30
        accessory049, // 0x31
        accessory050, // 0x32
        accessory051, // 0x33
        accessory052, // 0x34
        accessory053, // 0x35
        accessory054, // 0x36
        accessory055, // 0x37
        accessory056, // 0x38
        accessory057, // 0x39
        accessory058 // 0x3a
    };

    // idx 0x17 members: 0x33 type: 0
    enum Operator {
        shadow_ar_western, // 0x0
        shadow_smg_western, // 0x1
        shadow_sg_western, // 0x2
        shadow_lg_western, // 0x3
        shadow_dmr_western, // 0x4
        bravos_sas_a_western, // 0x5
        bravos_sas_b_western, // 0x6
        bravos_sas_c_western, // 0x7
        bravos_sas_d_western, // 0x8
        default_male_t10, // 0x9
        default_female_t10, // 0xa
        fender_western, // 0xb
        kilgore_eastern, // 0xc
        gunnar_western, // 0xd
        calisto_eastern, // 0xe
        chili_western, // 0xf
        stiletto_eastern, // 0x10
        hutch_western, // 0x11
        kpop_eastern, // 0x12
        ronin_western, // 0x13
        t10_usa_mogadishu, // 0x14
        t10_usa_alpha_infiltration, // 0x15
        t10_usa_bravo_infiltration, // 0x16
        t10_usa_ziva_default, // 0x17
        t10_usa_ziva_rt, // 0x18
        t10_uk_stone_security, // 0x19
        gus_western, // 0x1a
        zimo_western, // 0x1b
        kleo_western, // 0x1c
        nova_eastern, // 0x1d
        price_western, // 0x1e
        farah_western, // 0x1f
        ghost_western, // 0x20
        beta_western, // 0x21
        milsim_western_1, // 0x22
        milsim_western_2, // 0x23
        milsim_western_3, // 0x24
        milsim_western_4, // 0x25
        milsim_eastern_1, // 0x26
        milsim_eastern_2, // 0x27
        milsim_eastern_3, // 0x28
        milsim_eastern_4, // 0x29
        soap_western, // 0x2a
        oni_eastern, // 0x2b
        gromsko_western, // 0x2c
        reyes_western, // 0x2d
        luna_western, // 0x2e
        roze_eastern, // 0x2f
        zero_eastern, // 0x30
        conor_eastern, // 0x31
        aksel_eastern // 0x32
    };

    // idx 0x18 members: 0x10 type: 0
    enum Vehicle {
        atv, // 0x0
        light_tank, // 0x1
        little_bird, // 0x2
        veh9_apc_8x8, // 0x3
        veh9_cougar, // 0x4
        veh9_hummer, // 0x5
        veh9_jltv_mg, // 0x6
        veh9_mil_cargo_truck, // 0x7
        veh9_overland_2016, // 0x8
        veh9_palfa, // 0x9
        veh9_patrol_boat, // 0xa
        veh9_rhib, // 0xb
        veh9_sedan_hatchback_1985, // 0xc
        veh9_suv_1996, // 0xd
        veh9_utv, // 0xe
        veh9_acv // 0xf
    };

    // idx 0x19 members: 0xd type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_0, // 0x4
        team_1, // 0x5
        team_2, // 0x6
        team_3, // 0x7
        team_4, // 0x8
        team_5, // 0x9
        team_6, // 0xa
        team_7, // 0xb
        team_8 // 0xc
    };

    // root: bitSize: 0x1960, members: 29

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    uint hits;
    // offset: 0x20, bitSize: 0x370(0x6e Byte(s))
    Match match;
    // offset: 0x390, bitSize: 0x20(0x4 Byte(s))
    uint shots;
    // offset: 0x3b0, bitSize: 0x20(0x4 Byte(s))
    uint longshots;
    // offset: 0x3d0, bitSize: 0x200(0x40 Byte(s))
    string(64) player_body;
    // offset: 0x5d0, bitSize: 0x200(0x40 Byte(s))
    string(64) player_head;
    // offset: 0x7d0, bitSize: 0x100(0x20 Byte(s))
    string(32) playlistName;
    // offset: 0x8d0, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
    Perk loadout_extra_perks[3];
    // offset: 0x8e8, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xffff)
    Perk loadout_perks[3];
    // offset: 0x900, bitSize: 0x80(0x10 Byte(s))
    string(16) match_result;
    // offset: 0x980, bitSize: 0x8(0x1 Byte(s))
    Super archetype_super;
    // offset: 0x988, bitSize: 0x8(0x1 Byte(s))
    Perk archetype_trait;
    // offset: 0x990, bitSize: 0x60(0xc Byte(s)), array:0x6(hti:0xffff)
    Attachment loadout_primary_attachments[6];
    // offset: 0x9f0, bitSize: 0x20(0x4 Byte(s))
    int playlistID;
    // offset: 0xa10, bitSize: 0x20(0x4 Byte(s))
    uint superKills;
    // offset: 0xa30, bitSize: 0x20(0x4 Byte(s))
    uint doubleKills;
    // offset: 0xa50, bitSize: 0x8(0x1 Byte(s))
    LoadoutWeapon loadout_primary_weapon;
    // offset: 0xa58, bitSize: 0x20(0x4 Byte(s))
    int playlistVersion;
    // offset: 0xa78, bitSize: 0x588(0xb1 Byte(s))
    Player player;
    // offset: 0x1000, bitSize: 0x8(0x1 Byte(s))
    Power loadout_tactical;
    // offset: 0x1008, bitSize: 0x6c0(0xd8 Byte(s))
    TelemetryInteractionHeader metadata;
    // offset: 0x16c8, bitSize: 0x200(0x40 Byte(s))
    string(64) loadoutGesture;
    // offset: 0x18c8, bitSize: 0x8(0x1 Byte(s))
    Power loadout_lethal;
    // offset: 0x18d0, bitSize: 0x60(0xc Byte(s)), array:0x6(hti:0xffff)
    Attachment loadout_secondary_attachments[6];
    // offset: 0x1930, bitSize: 0x20(0x4 Byte(s))
    uint headshots;
    // offset: 0x1950, bitSize: 0x8(0x1 Byte(s))
    LoadoutWeapon loadout_secondary_weapon;
    // offset: 0x1958, bitSize: 0x1
    bool codESportsRules;
    // offset: 0x1959, bitSize: 0x1
    CharacterArchetype archetype;
};

