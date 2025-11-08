// file .... ddl\mp\helmet.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 16728 (0x4158)
    // byte size . 2091 (0x82b)
    // archive ... hash_d8502d9d1cbf8c35

    // bitSize: 0x100, members: 26
    struct EmblemLayer {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:8 red;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:8 blue;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        uint:16 icon;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        uint:10 posX;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        uint:10 posY;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        uint:8 red1;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:8 alpha;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        uint:9 angle;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        uint:8 blue1;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        uint:8 green;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        uint:7 gradientFill;
        // offset: 0x78, bitSize: 0x10(0x2 Byte(s))
        uint:16 groupIndex;
        // offset: 0x88, bitSize: 0x10(0x2 Byte(s))
        uint:9 gradientAngle;
        // offset: 0x98, bitSize: 0x8(0x1 Byte(s))
        uint:8 materialScaleX;
        // offset: 0xa0, bitSize: 0x8(0x1 Byte(s))
        uint:8 materialScaleY;
        // offset: 0xa8, bitSize: 0x8(0x1 Byte(s))
        uint:8 alpha1;
        // offset: 0xb0, bitSize: 0x8(0x1 Byte(s))
        uint:8 green1;
        // offset: 0xb8, bitSize: 0x10(0x2 Byte(s))
        uint:9 materialAngle;
        // offset: 0xc8, bitSize: 0x10(0x2 Byte(s))
        uint:10 scaleX;
        // offset: 0xd8, bitSize: 0x10(0x2 Byte(s))
        uint:10 scaleY;
        // offset: 0xe8, bitSize: 0x10(0x2 Byte(s))
        uint:16 materialID;
        // offset: 0xf8, bitSize: 0x1
        bool flip;
        // offset: 0xf9, bitSize: 0x1
        bool blend;
        // offset: 0xfa, bitSize: 0x1
        bool gradientType;
        // offset: 0xfb, bitSize: 0x1
        bool outline;
    };

    // bitSize: 0x40a8, members: 6
    struct CompositeEmblem {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:7 id;
        // offset: 0x8, bitSize: 0x80(0x10 Byte(s))
        string(16) name;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        uint:2 type;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        uint:16 background;
        // offset: 0xa0, bitSize: 0x4000(0x800 Byte(s)), array:0x40(hti:0xffff)
        EmblemLayer layers[64];
        // offset: 0x40a0, bitSize: 0x8(0x1 Byte(s))
        uint:7 layerCount;
    };

    // root: bitSize: 0x40a8, members: 1

    // offset: 0x0, bitSize: 0x40a8(0x815 Byte(s))
    CompositeEmblem emblem;
};

