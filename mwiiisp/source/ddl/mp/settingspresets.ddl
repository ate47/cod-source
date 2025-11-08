// file .... ddl\mp\settingspresets.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 4 (0x4)
    // bit size .. 464 (0x1d0)
    // byte size . 58 (0x3a)
    // archive ... hash_bc20f054d4069c61

    // bitSize: 0x28, members: 6
    struct Subtitles {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte subtitles_cp;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte subtitles_mp;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte subtitles_ob;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte subtitles_sp;
        // offset: 0x20, bitSize: 0x1
        bool initialized;
    };

    // bitSize: 0xa0, members: 22
    struct Quality {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte ssr;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte reflection_probes_quality;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte weather_grid_volume_quality;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte screen_space_shadows;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        byte water_quality;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte texture_res;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte particle_quality;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte shader_quality;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte depth_of_field_pc;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        byte tessellation;
        // offset: 0x50, bitSize: 0x8(0x1 Byte(s))
        byte bullet_impact;
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        byte tex_filter_aniso;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        byte resolution;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        byte model_quality;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        byte anti_aliasing;
        // offset: 0x78, bitSize: 0x8(0x1 Byte(s))
        byte ambient_occlusion;
        // offset: 0x80, bitSize: 0x8(0x1 Byte(s))
        byte volumetrics_quality;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        byte deferred_physics_quality;
        // offset: 0x90, bitSize: 0x8(0x1 Byte(s))
        byte shadow_quality;
        // offset: 0x98, bitSize: 0x1
        bool initialized;
        // offset: 0x99, bitSize: 0x1
        bool isCustom;
    };

    // bitSize: 0x58, members: 12
    struct Telemetry {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_vram_counter;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_cpu_time;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_fps_counter;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_server_latency;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_gpu_clock;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_laptop_battery;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_system_clock;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_packet_loss;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_gpu_temp;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        byte telemetry_gpu_time;
        // offset: 0x50, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0x120, members: 3

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    Subtitles subtitles;
    // offset: 0x28, bitSize: 0x58(0xb Byte(s))
    Telemetry telemetryPreset;
    // offset: 0x80, bitSize: 0xa0(0x14 Byte(s))
    Quality qualityPreset;
};

