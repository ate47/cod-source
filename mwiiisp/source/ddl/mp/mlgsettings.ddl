// file .... ddl\mp\mlgsettings.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 22328 (0x5738)
    // byte size . 2791 (0xae7)
    // archive ... hash_375a88f15f1ac02e

    // bitSize: 0x70, members: 6
    struct codcaster_camera_pose {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:8 fov;
        // offset: 0x8, bitSize: 0x10(0x2 Byte(s))
        int:12 angles_yaw;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        int:12 angles_pitch;
        // offset: 0x28, bitSize: 0x18(0x3 Byte(s))
        int:24 origin_x;
        // offset: 0x40, bitSize: 0x18(0x3 Byte(s))
        int:24 origin_y;
        // offset: 0x58, bitSize: 0x18(0x3 Byte(s))
        int:24 origin_z;
    };

    // bitSize: 0x568, members: 3
    struct codcaster_map_data {
        // offset: 0x0, bitSize: 0x460(0x8c Byte(s)), array:0xa(hti:0xffff)
        codcaster_camera_pose poses[10];
        // offset: 0x460, bitSize: 0x8(0x1 Byte(s))
        uint:8 mapIndex;
        // offset: 0x468, bitSize: 0x100(0x20 Byte(s))
        string(32) map_name;
    };

    // root: bitSize: 0x5688, members: 3

    // offset: 0x0, bitSize: 0x5680(0xad0 Byte(s)), array:0x10(hti:0xffff)
    codcaster_map_data codcaster_maps[16];
    // offset: 0x5680, bitSize: 0x1
    bool shoutcaster_hasbeenread;
};

