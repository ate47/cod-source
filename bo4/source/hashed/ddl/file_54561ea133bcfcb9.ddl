// hash_54561ea133bcfcb9
// metatable "hash_b0f88f08fad4d2fd"

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

    // idx 3 members 3 size 0x48
    struct hash_614dd0ece0bfbd27 {
        // offset 0x0, size 0x20
        uint ms_to_nat_trav_resolve;
        // offset 0x20, size 0x8
        byte result;
        // offset 0x28, size 0x20
        uint duration_ms;
    };

    // idx 4 members 11 size 0x118
    struct hash_4110ed2df03bbae {
        // offset 0x0, size 0x20
        uint num_replies;
        // offset 0x20, size 0x20
        uint real_addr;
        // offset 0x40, size 0x10
        uint:16 real_port;
        // offset 0x50, size 0x20
        uint reply_latency_count;
        // offset 0x70, size 0x20
        float min_latency;
        // offset 0x90, size 0x20
        uint data_size;
        // offset 0xb0, size 0x20
        uint bandwidth_up;
        // offset 0xd0, size 0x20
        uint bandwidth_down;
        // offset 0xf0, size 0x20
        float latency;
        // offset 0x110, size 0x1
        bool remote_disabled;
        // offset 0x111, size 0x7
        uint:1 __pad[7];
    };

    // idx 5 members 1 size 0x20
    struct hash_fb47795e5d8f8d {
        // offset 0x0, size 0x20
        float reply_latency;
    };

    // idx 6 members 4 size 0x58
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

    // idx 7 members 2 size 0x30
    struct hash_c5a2a1d52b4736a {
        // offset 0x0, size 0x20
        uint local_addr;
        // offset 0x20, size 0x10
        uint:16 local_port;
    };

    // idx 8 members 5 size 0x120
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

    // idx 0 members 8 size 0x910
    // offset 0x0, size 0x1f8
    telemetry_header telemetry;
    // offset 0x1f8, size 0x48
    hash_614dd0ece0bfbd27 qos_result;
    // offset 0x240, size 0x58
    hash_e34a94c0792bab1 qos_remote_common_addr;
    // offset 0x298, size 0x118
    hash_4110ed2df03bbae qos_info;
    // offset 0x3b0, size 0xc0
    client_header client;
    // offset 0x470, size 0x180
    hash_c5a2a1d52b4736a qos_remote_common_addrs_array[8];
    // offset 0x5f0, size 0x120
    hash_6a65101a136eab93 header;
    // offset 0x710, size 0x200
    hash_fb47795e5d8f8d reply_latency_array[16];
}

