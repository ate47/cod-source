// hash_1250d02916e4218d
// metatable "hash_1b96c0ef101c203a"

version 2 {
    // idx 1 members 8 size 0x1f8
    struct telemetry_header {
        // offset 0x0, size 0x20
        int changelist_number;
        // offset 0x20, size 0x10
        uint:16 source_version;
        // offset 0x30, size 0x40
        xhash action_type;
        // offset 0x70, size 0x8
        hash_54196e9e9860f0be platform;
        // offset 0x78, size 0x100
        string(32) build_version;
        // offset 0x178, size 0x20
        uint title_id;
        // offset 0x198, size 0x20
        uint utc_timestamp_sent;
        // offset 0x1b8, size 0x40
        uint64 hash_f2ad74d8edb8204;
    };

    // idx 2 members 3 size 0xc0
    struct client_header {
        // offset 0x0, size 0x40
        uint64 user_session_id;
        // offset 0x40, size 0x40
        uint64 uno_id;
        // offset 0x80, size 0x40
        uint64 user_id;
    };

    // idx 3 members 11 size 0xa8
    struct hash_35c568a786416877 {
        // offset 0x0, size 0x8
        byte stage_1_tries;
        // offset 0x8, size 0x8
        byte stage_2_tries;
        // offset 0x10, size 0x8
        byte stage_3_tries;
        // offset 0x18, size 0x20
        uint stun_addr;
        // offset 0x38, size 0x10
        uint:16 stun_port;
        // offset 0x48, size 0x8
        byte result;
        // offset 0x50, size 0x20
        uint real_addr;
        // offset 0x70, size 0x10
        uint:16 real_port;
        // offset 0x80, size 0x20
        uint duration_ms;
        // offset 0xa0, size 0x1
        bool throttled;
        // offset 0xa1, size 0x7
        uint:1 __pad[7];
    };

    // idx 4 members 4 size 0x58
    struct hash_e34a94c0792bab1 {
        // offset 0x0, size 0x8
        byte nat_type;
        // offset 0x8, size 0x20
        int local_addr_count;
        // offset 0x28, size 0x20
        uint public_addr;
        // offset 0x48, size 0x10
        uint:16 public_port;
    };

    // idx 5 members 2 size 0x30
    struct hash_c5a2a1d52b4736a {
        // offset 0x0, size 0x20
        uint local_addr;
        // offset 0x20, size 0x10
        uint:16 local_port;
    };

    // idx 6 members 8 size 0x90
    struct hash_7b68e004c189468 {
        // offset 0x0, size 0x8
        byte type;
        // offset 0x8, size 0x20
        uint dst_addr;
        // offset 0x28, size 0x10
        uint:16 dst_port;
        // offset 0x38, size 0x20
        uint ms_since_start;
        // offset 0x58, size 0x20
        uint src_addr;
        // offset 0x78, size 0x10
        uint:16 src_port;
        // offset 0x88, size 0x1
        bool send_success;
        // offset 0x89, size 0x7
        uint:1 __pad[7];
    };

    // idx 7 members 5 size 0x120
    struct hash_6a65101a136eab93 {
        // offset 0x0, size 0x40
        uint64 hash_6bdd7ebe59310aa2;
        // offset 0x40, size 0x40
        uint64 lobby_id;
        // offset 0x80, size 0x20
        uint title_id;
        // offset 0xa0, size 0x40
        uint64 hash_426fb7404d1fbf32;
        // offset 0xe0, size 0x40
        uint64 user_id;
    };

    // idx 0 members 5
    enum hash_54196e9e9860f0be {
        pc, // 0x0,
        neo, // 0x1,
        xb1, // 0x2,
        scorpio, // 0x3,
        ps4, // 0x4
    };

    // idx 0 members 9 size 0x770
    // offset 0x0, size 0x180
    hash_c5a2a1d52b4736a local_addrs_array[8];
    // offset 0x180, size 0x30
    hash_c5a2a1d52b4736a remote_addrs_array;
    // offset 0x1b0, size 0x1f8
    telemetry_header telemetry;
    // offset 0x3a8, size 0x58
    hash_e34a94c0792bab1 local_common_addr;
    // offset 0x400, size 0x58
    hash_e34a94c0792bab1 remote_common_addr;
    // offset 0x458, size 0x90
    hash_7b68e004c189468 nat_trav_attempts;
    // offset 0x4e8, size 0xc0
    client_header client;
    // offset 0x5a8, size 0x120
    hash_6a65101a136eab93 header;
    // offset 0x6c8, size 0xa8
    hash_35c568a786416877 nat_trav_result;
}

