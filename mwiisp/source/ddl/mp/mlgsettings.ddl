// file .... ddl\mp\mlgsettings.ddl

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 3 (0x3)
    // bit size .. 10336 (0x2860)
    // byte size . 1292 (0x50c)
    // archive ... hash_d6aa5b740e9001b7

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

    // bitSize: 0x468, members: 2
    struct codcaster_map_data {
        // offset: 0x0, bitSize: 0x460(0x8c Byte(s)), array:0xa(hti:0xffff)
        codcaster_camera_pose poses[10];
        // offset: 0x460, bitSize: 0x8(0x1 Byte(s))
        uint:8 mapIndex;
    };

    // idx 0x0 members: 0x9 type: 0
    enum mp_maps {
        mp_museum, // 0x0
        mp_grandprix, // 0x1
        mp_catedral, // 0x2
        mp_embassy, // 0x3
        mp_farm_18, // 0x4
        mp_hydro, // 0x5
        mp_luxury, // 0x6
        mp_narcos, // 0x7
        mp_swap_meet // 0x8
    };

    // root: bitSize: 0x27b0, members: 3

    // offset: 0x0, bitSize: 0x27a8(0x4f5 Byte(s)), array:0x9(hti:0x0)
    codcaster_map_data codcaster_maps[mp_maps];
    // offset: 0x27a8, bitSize: 0x1
    bool shoutcaster_hasbeenread;
};

