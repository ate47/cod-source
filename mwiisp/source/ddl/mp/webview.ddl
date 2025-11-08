// file .... ddl\mp\webview.ddl

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

