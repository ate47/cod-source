// hash_1673548869c6e873
// metatable "hash_56f94926fc21f03c"

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

    // idx 3 members 20 size 0x1b8
    struct hash_75410917f1349195 {
        // offset 0x0, size 0x20
        uint conf_port_pool_size;
        // offset 0x20, size 0x20
        uint conf_discovery_retries;
        // offset 0x40, size 0x8
        byte conf_run_mode;
        // offset 0x48, size 0x20
        uint conf_mapping_retries;
        // offset 0x68, size 0x20
        float conf_connect_timeout;
        // offset 0x88, size 0x10
        uint:16 game_port;
        // offset 0x98, size 0x8
        byte device_port_status;
        // offset 0xa0, size 0x20
        float conf_response_timeout;
        // offset 0xc0, size 0x20
        float conf_discovery_timeout;
        // offset 0xe0, size 0x8
        byte conf_port_selection_mode;
        // offset 0xe8, size 0x20
        uint device_addr;
        // offset 0x108, size 0x10
        uint:16 device_port;
        // offset 0x118, size 0x20
        uint discovery_attempts;
        // offset 0x138, size 0x8
        byte result;
        // offset 0x140, size 0x20
        uint device_external_addr;
        // offset 0x160, size 0x10
        uint:16 device_external_port;
        // offset 0x170, size 0x20
        uint duration_ms;
        // offset 0x190, size 0x20
        uint conf_gateway_addr;
        // offset 0x1b0, size 0x1
        bool conf_only_use_gateway;
        // offset 0x1b1, size 0x7
        uint:1 __pad[7];
    };

    // idx 4 members 4 size 0x450
    struct hash_3463e9551f90555 {
        // offset 0x0, size 0x20
        uint addr;
        // offset 0x20, size 0x10
        uint:16 port;
        // offset 0x30, size 0x400
        string(128) notify_server_field;
        // offset 0x430, size 0x20
        uint ms_since_start;
    };

    // idx 5 members 5 size 0x120
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

    // idx 0 members 5 size 0x16d0
    // offset 0x0, size 0x1140
    hash_3463e9551f90555 upnp_discovered_device[4];
    // offset 0x1140, size 0x1f8
    telemetry_header telemetry;
    // offset 0x1338, size 0x1b8
    hash_75410917f1349195 upnp_result;
    // offset 0x14f0, size 0xc0
    client_header client;
    // offset 0x15b0, size 0x120
    hash_6a65101a136eab93 header;
}

