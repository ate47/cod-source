// file .... ddl\mp\codcasterclientmatchdata.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 2 (0x2)
    // bit size .. 12176 (0x2f90)
    // byte size . 1522 (0x5f2)
    // archive ... hash_a3dde0ac69a53a5f

    // bitSize: 0x1f0, members: 5
    struct Player {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int damageDone;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int longestKillstreak;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int shutdowns;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int gametypePoints;
        // offset: 0x80, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
    };

    // root: bitSize: 0x2f80, members: 2

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x2e80(0x5d0 Byte(s)), array:0x18(hti:0xffff)
    Player players[24];
};

