// file .... ddl\mp\favoritesettings.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 1 (0x1)
    // bit size .. 10984 (0x2ae8)
    // byte size . 1373 (0x55d)
    // archive ... hash_ce41a0dca19ce616

    // root: bitSize: 0x2a38, members: 4

    // offset: 0x0, bitSize: 0x1518(0x2a3 Byte(s)), array:0xf(hti:0xffff)
    string(45) favoritesConsole[15];
    // offset: 0x1518, bitSize: 0x1518(0x2a3 Byte(s)), array:0xf(hti:0xffff)
    string(45) favoritesPC[15];
    // offset: 0x2a30, bitSize: 0x1
    bool favorites_hasbeenread;
};

