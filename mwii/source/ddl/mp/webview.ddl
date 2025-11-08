// file .... ddl\mp\webview.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 7 (0x7)
    // bit size .. 288 (0x120)
    // byte size . 36 (0x24)
    // archive ... hash_5fe33385620524f2

    // bitSize: 0x1, members: 1
    struct MotDInfo {
        // offset: 0x0, bitSize: 0x1
        bool seen;
    };

    // bitSize: 0x20, members: 1
    struct ToSInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int accept;
    };

    // bitSize: 0x28, members: 4
    struct EventInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int currentEventIndex;
        // offset: 0x20, bitSize: 0x1
        bool ftueSeen;
        // offset: 0x21, bitSize: 0x1
        bool launchFTUESeen;
    };

    // bitSize: 0x1, members: 1
    struct PushNotifications {
        // offset: 0x0, bitSize: 0x1
        bool seenSoftPrompt;
    };

    // bitSize: 0x20, members: 1
    struct AppReview {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int timesShown;
    };

    // bitSize: 0x70, members: 6
    struct LiveInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        ToSInfo tos;
        // offset: 0x20, bitSize: 0x28(0x5 Byte(s))
        EventInfo event;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        AppReview appReview;
        // offset: 0x68, bitSize: 0x1
        MotDInfo motd;
        // offset: 0x69, bitSize: 0x1
        PushNotifications pushNotifications;
    };

    // root: bitSize: 0x70, members: 1

    // offset: 0x0, bitSize: 0x70(0xe Byte(s))
    LiveInfo live;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 240 (0xf0)
    // byte size . 30 (0x1e)
    // archive ... hash_8879b1c36dbee103

    // bitSize: 0x20, members: 1
    struct MotdInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int lastSeenMessage;
    };

    // bitSize: 0x20, members: 1
    struct TosInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int acceptedTosData;
    };

    // root: bitSize: 0x40, members: 2

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    TosInfo TosInfo;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    MotdInfo MotdInfo;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 4 (0x4)
    // bit size .. 216 (0xd8)
    // byte size . 27 (0x1b)
    // archive ... hash_e173b0035e989aa4

    // bitSize: 0x1, members: 1
    struct MotDInfo {
        // offset: 0x0, bitSize: 0x1
        bool seen;
    };

    // bitSize: 0x20, members: 1
    struct ToSInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int accept;
    };

    // bitSize: 0x28, members: 3
    struct LiveInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        ToSInfo tos;
        // offset: 0x20, bitSize: 0x1
        MotDInfo motd;
    };

    // root: bitSize: 0x28, members: 1

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    LiveInfo live;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 5 (0x5)
    // bit size .. 224 (0xe0)
    // byte size . 28 (0x1c)
    // archive ... hash_4237d6b1f428cd9c

    // bitSize: 0x1, members: 1
    struct MotDInfo {
        // offset: 0x0, bitSize: 0x1
        bool seen;
    };

    // bitSize: 0x20, members: 1
    struct ToSInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int accept;
    };

    // bitSize: 0x28, members: 3
    struct LiveInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        ToSInfo tos;
        // offset: 0x20, bitSize: 0x1
        MotDInfo motd;
    };

    // bitSize: 0x1, members: 1
    struct PurchaseInfo {
        // offset: 0x0, bitSize: 0x1
        bool pending;
    };

    // root: bitSize: 0x30, members: 3

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    LiveInfo live;
    // offset: 0x28, bitSize: 0x1
    PurchaseInfo purchase;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 6 (0x6)
    // bit size .. 216 (0xd8)
    // byte size . 27 (0x1b)
    // archive ... hash_f27ea0a987ae9701

    // bitSize: 0x1, members: 1
    struct MotDInfo {
        // offset: 0x0, bitSize: 0x1
        bool seen;
    };

    // bitSize: 0x20, members: 1
    struct ToSInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int accept;
    };

    // bitSize: 0x1, members: 1
    struct EventInfo {
        // offset: 0x0, bitSize: 0x1
        bool ftueSeen;
    };

    // bitSize: 0x1, members: 1
    struct PushNotifications {
        // offset: 0x0, bitSize: 0x1
        bool seenSoftPrompt;
    };

    // bitSize: 0x28, members: 5
    struct LiveInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        ToSInfo tos;
        // offset: 0x20, bitSize: 0x1
        MotDInfo motd;
        // offset: 0x21, bitSize: 0x1
        EventInfo event;
        // offset: 0x22, bitSize: 0x1
        PushNotifications pushNotifications;
    };

    // root: bitSize: 0x28, members: 1

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    LiveInfo live;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 7 (0x7)
    // bit size .. 248 (0xf8)
    // byte size . 31 (0x1f)
    // archive ... hash_5880892d07d2bc0d

    // bitSize: 0x1, members: 1
    struct MotDInfo {
        // offset: 0x0, bitSize: 0x1
        bool seen;
    };

    // bitSize: 0x20, members: 1
    struct ToSInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int accept;
    };

    // bitSize: 0x1, members: 1
    struct EventInfo {
        // offset: 0x0, bitSize: 0x1
        bool ftueSeen;
    };

    // bitSize: 0x1, members: 1
    struct PushNotifications {
        // offset: 0x0, bitSize: 0x1
        bool seenSoftPrompt;
    };

    // bitSize: 0x20, members: 1
    struct AppReview {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int timesShown;
    };

    // bitSize: 0x48, members: 6
    struct LiveInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        ToSInfo tos;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        AppReview appReview;
        // offset: 0x40, bitSize: 0x1
        MotDInfo motd;
        // offset: 0x41, bitSize: 0x1
        EventInfo event;
        // offset: 0x42, bitSize: 0x1
        PushNotifications pushNotifications;
    };

    // root: bitSize: 0x48, members: 1

    // offset: 0x0, bitSize: 0x48(0x9 Byte(s))
    LiveInfo live;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 5 (0x5)
    // bit size .. 216 (0xd8)
    // byte size . 27 (0x1b)
    // archive ... hash_171c34a4507b16

    // bitSize: 0x1, members: 1
    struct MotDInfo {
        // offset: 0x0, bitSize: 0x1
        bool seen;
    };

    // bitSize: 0x20, members: 1
    struct ToSInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int accept;
    };

    // bitSize: 0x1, members: 1
    struct EventInfo {
        // offset: 0x0, bitSize: 0x1
        bool ftueSeen;
    };

    // bitSize: 0x28, members: 4
    struct LiveInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        ToSInfo tos;
        // offset: 0x20, bitSize: 0x1
        MotDInfo motd;
        // offset: 0x21, bitSize: 0x1
        EventInfo event;
    };

    // root: bitSize: 0x28, members: 1

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    LiveInfo live;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 7 (0x7)
    // bit size .. 288 (0x120)
    // byte size . 36 (0x24)
    // archive ... hash_10d5bc8a5c603df7

    // bitSize: 0x1, members: 1
    struct MotDInfo {
        // offset: 0x0, bitSize: 0x1
        bool seen;
    };

    // bitSize: 0x20, members: 1
    struct ToSInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int accept;
    };

    // bitSize: 0x28, members: 3
    struct EventInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int currentEventIndex;
        // offset: 0x20, bitSize: 0x1
        bool ftueSeen;
    };

    // bitSize: 0x1, members: 1
    struct PushNotifications {
        // offset: 0x0, bitSize: 0x1
        bool seenSoftPrompt;
    };

    // bitSize: 0x20, members: 1
    struct AppReview {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int timesShown;
    };

    // bitSize: 0x70, members: 6
    struct LiveInfo {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        ToSInfo tos;
        // offset: 0x20, bitSize: 0x28(0x5 Byte(s))
        EventInfo event;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        AppReview appReview;
        // offset: 0x68, bitSize: 0x1
        MotDInfo motd;
        // offset: 0x69, bitSize: 0x1
        PushNotifications pushNotifications;
    };

    // root: bitSize: 0x70, members: 1

    // offset: 0x0, bitSize: 0x70(0xe Byte(s))
    LiveInfo live;
};

