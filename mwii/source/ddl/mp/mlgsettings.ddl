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

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 2344 (0x928)
    // byte size . 293 (0x125)
    // archive ... hash_8475a86ef8cf9d5e

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

    // root: bitSize: 0x878, members: 91

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_yaw;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_min_duration;
    // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_smooth_modifier;
    // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_smooth_factor;
    // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_bottom;
    // offset: 0x90, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_sensitivity;
    // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_top;
    // offset: 0xc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_bestoflimit;
    // offset: 0xc8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_smooth_modifier;
    // offset: 0xe8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_sensitivity;
    // offset: 0x108, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_acronym;
    // offset: 0x208, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_speed;
    // offset: 0x228, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_allies_icon;
    // offset: 0x230, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_name;
    // offset: 0x330, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_rotation_smooth_modifier;
    // offset: 0x350, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_speed;
    // offset: 0x370, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_smooth_factor;
    // offset: 0x390, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_base_distance;
    // offset: 0x3b0, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_smooth_factor;
    // offset: 0x3d0, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_smooth_modifier;
    // offset: 0x3f0, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_acronym;
    // offset: 0x4f0, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_smooth_factor;
    // offset: 0x510, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team1;
    // offset: 0x518, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team2;
    // offset: 0x520, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color1;
    // offset: 0x538, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color2;
    // offset: 0x550, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color3;
    // offset: 0x568, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_starting_camera;
    // offset: 0x570, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_speed;
    // offset: 0x590, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_axis_icon;
    // offset: 0x598, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_name;
    // offset: 0x698, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_vertical_offset;
    // offset: 0x6b8, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_speed;
    // offset: 0x6d8, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_smooth_modifier;
    // offset: 0x6f8, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_xray_type;
    // offset: 0x700, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color1;
    // offset: 0x718, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color2;
    // offset: 0x730, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color3;
    // offset: 0x748, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_slow_factor;
    // offset: 0x768, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_fast_factor;
    // offset: 0x788, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_sensitivity;
    // offset: 0x7a8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_sensitivity;
    // offset: 0x7c8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_player_movement_smooth_factor;
    // offset: 0x7e8, bitSize: 0x20(0x4 Byte(s))
    float freecam_default_fov;
    // offset: 0x808, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_max_duration;
    // offset: 0x828, bitSize: 0x20(0x4 Byte(s))
    float camera_smooth_factor;
    // offset: 0x848, bitSize: 0x1
    bool codcaster_seriesscore;
    // offset: 0x849, bitSize: 0x1
    bool codcaster_killstreak_view;
    // offset: 0x84a, bitSize: 0x1
    bool codcaster_dataview;
    // offset: 0x84b, bitSize: 0x1
    bool codcaster_fieldupgrades_notification;
    // offset: 0x84c, bitSize: 0x1
    bool codcaster_playernumbers_minimap;
    // offset: 0x84d, bitSize: 0x1
    bool codcaster_jerseynumbers;
    // offset: 0x84e, bitSize: 0x1
    bool codcaster_xray_loadout;
    // offset: 0x84f, bitSize: 0x1
    bool codcaster_playercard;
    // offset: 0x850, bitSize: 0x1
    bool codcaster_playerlist;
    // offset: 0x851, bitSize: 0x1
    bool codcaster_playercard_weapon;
    // offset: 0x852, bitSize: 0x1
    bool codcaster_teamlist;
    // offset: 0x853, bitSize: 0x1
    bool codcaster_xray;
    // offset: 0x854, bitSize: 0x1
    bool codcaster_playercard_portrait;
    // offset: 0x855, bitSize: 0x1
    bool codcaster_team_allies_color3_unlocked;
    // offset: 0x856, bitSize: 0x1
    bool codcaster_announcements;
    // offset: 0x857, bitSize: 0x1
    bool codcaster_hidelayer;
    // offset: 0x858, bitSize: 0x1
    bool shoutcaster_hasbeenread;
    // offset: 0x859, bitSize: 0x1
    bool codcaster_playercard_equipments;
    // offset: 0x85a, bitSize: 0x1
    bool freecam_translation_ignore_pitch;
    // offset: 0x85b, bitSize: 0x1
    bool codcaster_killfeed;
    // offset: 0x85c, bitSize: 0x1
    bool codcaster_fieldupgrade_view;
    // offset: 0x85d, bitSize: 0x1
    bool codcaster_nameplates_name;
    // offset: 0x85e, bitSize: 0x1
    bool codcaster_killstreaks_notification;
    // offset: 0x85f, bitSize: 0x1
    bool codcaster_playernumbers_teamlist;
    // offset: 0x860, bitSize: 0x1
    bool codcaster_playercard_streaks;
    // offset: 0x861, bitSize: 0x1
    bool codcaster_statuseffect;
    // offset: 0x862, bitSize: 0x1
    bool aerialcam_default_tethered;
    // offset: 0x863, bitSize: 0x1
    bool codcaster_playernumbers_playercard;
    // offset: 0x864, bitSize: 0x1
    bool codcaster_team_identity;
    // offset: 0x865, bitSize: 0x1
    bool codcaster_waypoint_markers;
    // offset: 0x866, bitSize: 0x1
    bool freecam_speed_toggle;
    // offset: 0x867, bitSize: 0x1
    bool codcaster_nameplates;
    // offset: 0x868, bitSize: 0x1
    bool aerialcam_pucks_enabled;
    // offset: 0x869, bitSize: 0x1
    bool orbitalcam_angle_is_fixed;
    // offset: 0x86a, bitSize: 0x1
    bool codcaster_countdown_series_text;
    // offset: 0x86b, bitSize: 0x1
    bool codcaster_xray_objectives;
    // offset: 0x86c, bitSize: 0x1
    bool codcaster_fullscreen_map;
    // offset: 0x86d, bitSize: 0x1
    bool codcaster_playernumbers;
    // offset: 0x86e, bitSize: 0x1
    bool freecam_pucks_enabled;
    // offset: 0x86f, bitSize: 0x1
    bool codcaster_scoreheader;
    // offset: 0x870, bitSize: 0x1
    bool codcaster_minimap;
    // offset: 0x871, bitSize: 0x1
    bool codcaster_team_axis_color3_unlocked;
    // offset: 0x872, bitSize: 0x1
    bool codcaster_nameplates_number;
    // offset: 0x873, bitSize: 0x1
    bool freecam_clipping_enabled;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 2344 (0x928)
    // byte size . 293 (0x125)
    // archive ... hash_c29ff679a2bea672

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

    // root: bitSize: 0x878, members: 90

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_yaw;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_min_duration;
    // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_smooth_modifier;
    // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_smooth_factor;
    // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_bottom;
    // offset: 0x90, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_sensitivity;
    // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_top;
    // offset: 0xc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_bestoflimit;
    // offset: 0xc8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_smooth_modifier;
    // offset: 0xe8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_sensitivity;
    // offset: 0x108, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_acronym;
    // offset: 0x208, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_speed;
    // offset: 0x228, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_allies_icon;
    // offset: 0x230, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_name;
    // offset: 0x330, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_rotation_smooth_modifier;
    // offset: 0x350, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_speed;
    // offset: 0x370, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_smooth_factor;
    // offset: 0x390, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_base_distance;
    // offset: 0x3b0, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_smooth_factor;
    // offset: 0x3d0, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_smooth_modifier;
    // offset: 0x3f0, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_acronym;
    // offset: 0x4f0, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_smooth_factor;
    // offset: 0x510, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team1;
    // offset: 0x518, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team2;
    // offset: 0x520, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color1;
    // offset: 0x538, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color2;
    // offset: 0x550, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color3;
    // offset: 0x568, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_starting_camera;
    // offset: 0x570, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_speed;
    // offset: 0x590, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_axis_icon;
    // offset: 0x598, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_name;
    // offset: 0x698, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_vertical_offset;
    // offset: 0x6b8, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_speed;
    // offset: 0x6d8, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_smooth_modifier;
    // offset: 0x6f8, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_xray_type;
    // offset: 0x700, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color1;
    // offset: 0x718, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color2;
    // offset: 0x730, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color3;
    // offset: 0x748, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_slow_factor;
    // offset: 0x768, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_fast_factor;
    // offset: 0x788, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_sensitivity;
    // offset: 0x7a8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_sensitivity;
    // offset: 0x7c8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_player_movement_smooth_factor;
    // offset: 0x7e8, bitSize: 0x20(0x4 Byte(s))
    float freecam_default_fov;
    // offset: 0x808, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_max_duration;
    // offset: 0x828, bitSize: 0x20(0x4 Byte(s))
    float camera_smooth_factor;
    // offset: 0x848, bitSize: 0x1
    bool codcaster_seriesscore;
    // offset: 0x849, bitSize: 0x1
    bool codcaster_killstreak_view;
    // offset: 0x84a, bitSize: 0x1
    bool codcaster_dataview;
    // offset: 0x84b, bitSize: 0x1
    bool codcaster_fieldupgrades_notification;
    // offset: 0x84c, bitSize: 0x1
    bool codcaster_playernumbers_minimap;
    // offset: 0x84d, bitSize: 0x1
    bool codcaster_jerseynumbers;
    // offset: 0x84e, bitSize: 0x1
    bool codcaster_xray_loadout;
    // offset: 0x84f, bitSize: 0x1
    bool codcaster_playercard;
    // offset: 0x850, bitSize: 0x1
    bool codcaster_playerlist;
    // offset: 0x851, bitSize: 0x1
    bool codcaster_playercard_weapon;
    // offset: 0x852, bitSize: 0x1
    bool codcaster_teamlist;
    // offset: 0x853, bitSize: 0x1
    bool codcaster_xray;
    // offset: 0x854, bitSize: 0x1
    bool codcaster_playercard_portrait;
    // offset: 0x855, bitSize: 0x1
    bool codcaster_team_allies_color3_unlocked;
    // offset: 0x856, bitSize: 0x1
    bool codcaster_announcements;
    // offset: 0x857, bitSize: 0x1
    bool codcaster_hidelayer;
    // offset: 0x858, bitSize: 0x1
    bool shoutcaster_hasbeenread;
    // offset: 0x859, bitSize: 0x1
    bool codcaster_playercard_equipments;
    // offset: 0x85a, bitSize: 0x1
    bool freecam_translation_ignore_pitch;
    // offset: 0x85b, bitSize: 0x1
    bool codcaster_killfeed;
    // offset: 0x85c, bitSize: 0x1
    bool codcaster_fieldupgrade_view;
    // offset: 0x85d, bitSize: 0x1
    bool codcaster_nameplates_name;
    // offset: 0x85e, bitSize: 0x1
    bool codcaster_killstreaks_notification;
    // offset: 0x85f, bitSize: 0x1
    bool codcaster_playernumbers_teamlist;
    // offset: 0x860, bitSize: 0x1
    bool codcaster_playercard_streaks;
    // offset: 0x861, bitSize: 0x1
    bool codcaster_statuseffect;
    // offset: 0x862, bitSize: 0x1
    bool aerialcam_default_tethered;
    // offset: 0x863, bitSize: 0x1
    bool codcaster_playernumbers_playercard;
    // offset: 0x864, bitSize: 0x1
    bool codcaster_team_identity;
    // offset: 0x865, bitSize: 0x1
    bool codcaster_waypoint_markers;
    // offset: 0x866, bitSize: 0x1
    bool freecam_speed_toggle;
    // offset: 0x867, bitSize: 0x1
    bool codcaster_nameplates;
    // offset: 0x868, bitSize: 0x1
    bool aerialcam_pucks_enabled;
    // offset: 0x869, bitSize: 0x1
    bool orbitalcam_angle_is_fixed;
    // offset: 0x86a, bitSize: 0x1
    bool codcaster_xray_objectives;
    // offset: 0x86b, bitSize: 0x1
    bool codcaster_fullscreen_map;
    // offset: 0x86c, bitSize: 0x1
    bool codcaster_playernumbers;
    // offset: 0x86d, bitSize: 0x1
    bool freecam_pucks_enabled;
    // offset: 0x86e, bitSize: 0x1
    bool codcaster_scoreheader;
    // offset: 0x86f, bitSize: 0x1
    bool codcaster_minimap;
    // offset: 0x870, bitSize: 0x1
    bool codcaster_team_axis_color3_unlocked;
    // offset: 0x871, bitSize: 0x1
    bool codcaster_nameplates_number;
    // offset: 0x872, bitSize: 0x1
    bool freecam_clipping_enabled;
};

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 3 (0x3)
    // bit size .. 12496 (0x30d0)
    // byte size . 1562 (0x61a)
    // archive ... hash_967b0476b200d721

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

    // root: bitSize: 0x3020, members: 91

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_yaw;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_min_duration;
    // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_smooth_modifier;
    // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_smooth_factor;
    // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_bottom;
    // offset: 0x90, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_sensitivity;
    // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_top;
    // offset: 0xc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_bestoflimit;
    // offset: 0xc8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_smooth_modifier;
    // offset: 0xe8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_sensitivity;
    // offset: 0x108, bitSize: 0x27a8(0x4f5 Byte(s)), array:0x9(hti:0x0)
    codcaster_map_data codcaster_maps[mp_maps];
    // offset: 0x28b0, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_acronym;
    // offset: 0x29b0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_speed;
    // offset: 0x29d0, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_allies_icon;
    // offset: 0x29d8, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_name;
    // offset: 0x2ad8, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_rotation_smooth_modifier;
    // offset: 0x2af8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_speed;
    // offset: 0x2b18, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_smooth_factor;
    // offset: 0x2b38, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_base_distance;
    // offset: 0x2b58, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_smooth_factor;
    // offset: 0x2b78, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_smooth_modifier;
    // offset: 0x2b98, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_acronym;
    // offset: 0x2c98, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_smooth_factor;
    // offset: 0x2cb8, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team1;
    // offset: 0x2cc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team2;
    // offset: 0x2cc8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color1;
    // offset: 0x2ce0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color2;
    // offset: 0x2cf8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color3;
    // offset: 0x2d10, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_starting_camera;
    // offset: 0x2d18, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_speed;
    // offset: 0x2d38, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_axis_icon;
    // offset: 0x2d40, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_name;
    // offset: 0x2e40, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_vertical_offset;
    // offset: 0x2e60, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_speed;
    // offset: 0x2e80, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_smooth_modifier;
    // offset: 0x2ea0, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_xray_type;
    // offset: 0x2ea8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color1;
    // offset: 0x2ec0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color2;
    // offset: 0x2ed8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color3;
    // offset: 0x2ef0, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_slow_factor;
    // offset: 0x2f10, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_fast_factor;
    // offset: 0x2f30, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_sensitivity;
    // offset: 0x2f50, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_sensitivity;
    // offset: 0x2f70, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_player_movement_smooth_factor;
    // offset: 0x2f90, bitSize: 0x20(0x4 Byte(s))
    float freecam_default_fov;
    // offset: 0x2fb0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_max_duration;
    // offset: 0x2fd0, bitSize: 0x20(0x4 Byte(s))
    float camera_smooth_factor;
    // offset: 0x2ff0, bitSize: 0x1
    bool codcaster_seriesscore;
    // offset: 0x2ff1, bitSize: 0x1
    bool codcaster_killstreak_view;
    // offset: 0x2ff2, bitSize: 0x1
    bool codcaster_dataview;
    // offset: 0x2ff3, bitSize: 0x1
    bool codcaster_fieldupgrades_notification;
    // offset: 0x2ff4, bitSize: 0x1
    bool codcaster_playernumbers_minimap;
    // offset: 0x2ff5, bitSize: 0x1
    bool codcaster_jerseynumbers;
    // offset: 0x2ff6, bitSize: 0x1
    bool codcaster_xray_loadout;
    // offset: 0x2ff7, bitSize: 0x1
    bool codcaster_playercard;
    // offset: 0x2ff8, bitSize: 0x1
    bool codcaster_playerlist;
    // offset: 0x2ff9, bitSize: 0x1
    bool codcaster_playercard_weapon;
    // offset: 0x2ffa, bitSize: 0x1
    bool codcaster_teamlist;
    // offset: 0x2ffb, bitSize: 0x1
    bool codcaster_xray;
    // offset: 0x2ffc, bitSize: 0x1
    bool codcaster_playercard_portrait;
    // offset: 0x2ffd, bitSize: 0x1
    bool codcaster_team_allies_color3_unlocked;
    // offset: 0x2ffe, bitSize: 0x1
    bool codcaster_announcements;
    // offset: 0x2fff, bitSize: 0x1
    bool codcaster_hidelayer;
    // offset: 0x3000, bitSize: 0x1
    bool shoutcaster_hasbeenread;
    // offset: 0x3001, bitSize: 0x1
    bool codcaster_playercard_equipments;
    // offset: 0x3002, bitSize: 0x1
    bool freecam_translation_ignore_pitch;
    // offset: 0x3003, bitSize: 0x1
    bool codcaster_killfeed;
    // offset: 0x3004, bitSize: 0x1
    bool codcaster_fieldupgrade_view;
    // offset: 0x3005, bitSize: 0x1
    bool codcaster_nameplates_name;
    // offset: 0x3006, bitSize: 0x1
    bool codcaster_killstreaks_notification;
    // offset: 0x3007, bitSize: 0x1
    bool codcaster_playernumbers_teamlist;
    // offset: 0x3008, bitSize: 0x1
    bool codcaster_playercard_streaks;
    // offset: 0x3009, bitSize: 0x1
    bool codcaster_statuseffect;
    // offset: 0x300a, bitSize: 0x1
    bool aerialcam_default_tethered;
    // offset: 0x300b, bitSize: 0x1
    bool codcaster_playernumbers_playercard;
    // offset: 0x300c, bitSize: 0x1
    bool codcaster_team_identity;
    // offset: 0x300d, bitSize: 0x1
    bool codcaster_waypoint_markers;
    // offset: 0x300e, bitSize: 0x1
    bool freecam_speed_toggle;
    // offset: 0x300f, bitSize: 0x1
    bool codcaster_nameplates;
    // offset: 0x3010, bitSize: 0x1
    bool aerialcam_pucks_enabled;
    // offset: 0x3011, bitSize: 0x1
    bool orbitalcam_angle_is_fixed;
    // offset: 0x3012, bitSize: 0x1
    bool codcaster_xray_objectives;
    // offset: 0x3013, bitSize: 0x1
    bool codcaster_fullscreen_map;
    // offset: 0x3014, bitSize: 0x1
    bool codcaster_playernumbers;
    // offset: 0x3015, bitSize: 0x1
    bool freecam_pucks_enabled;
    // offset: 0x3016, bitSize: 0x1
    bool codcaster_scoreheader;
    // offset: 0x3017, bitSize: 0x1
    bool codcaster_minimap;
    // offset: 0x3018, bitSize: 0x1
    bool codcaster_team_axis_color3_unlocked;
    // offset: 0x3019, bitSize: 0x1
    bool codcaster_nameplates_number;
    // offset: 0x301a, bitSize: 0x1
    bool freecam_clipping_enabled;
};

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 3 (0x3)
    // bit size .. 12496 (0x30d0)
    // byte size . 1562 (0x61a)
    // archive ... hash_f6453eb36593dc42

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

    // root: bitSize: 0x3020, members: 92

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_yaw;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_min_duration;
    // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_smooth_modifier;
    // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_smooth_factor;
    // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_bottom;
    // offset: 0x90, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_sensitivity;
    // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_top;
    // offset: 0xc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_bestoflimit;
    // offset: 0xc8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_smooth_modifier;
    // offset: 0xe8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_sensitivity;
    // offset: 0x108, bitSize: 0x27a8(0x4f5 Byte(s)), array:0x9(hti:0x0)
    codcaster_map_data codcaster_maps[mp_maps];
    // offset: 0x28b0, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_acronym;
    // offset: 0x29b0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_speed;
    // offset: 0x29d0, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_allies_icon;
    // offset: 0x29d8, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_name;
    // offset: 0x2ad8, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_rotation_smooth_modifier;
    // offset: 0x2af8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_speed;
    // offset: 0x2b18, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_smooth_factor;
    // offset: 0x2b38, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_base_distance;
    // offset: 0x2b58, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_smooth_factor;
    // offset: 0x2b78, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_smooth_modifier;
    // offset: 0x2b98, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_acronym;
    // offset: 0x2c98, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_smooth_factor;
    // offset: 0x2cb8, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team1;
    // offset: 0x2cc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team2;
    // offset: 0x2cc8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color1;
    // offset: 0x2ce0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color2;
    // offset: 0x2cf8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color3;
    // offset: 0x2d10, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_starting_camera;
    // offset: 0x2d18, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_speed;
    // offset: 0x2d38, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_axis_icon;
    // offset: 0x2d40, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_name;
    // offset: 0x2e40, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_vertical_offset;
    // offset: 0x2e60, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_speed;
    // offset: 0x2e80, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_smooth_modifier;
    // offset: 0x2ea0, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_xray_type;
    // offset: 0x2ea8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color1;
    // offset: 0x2ec0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color2;
    // offset: 0x2ed8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color3;
    // offset: 0x2ef0, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_slow_factor;
    // offset: 0x2f10, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_fast_factor;
    // offset: 0x2f30, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_sensitivity;
    // offset: 0x2f50, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_sensitivity;
    // offset: 0x2f70, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_player_movement_smooth_factor;
    // offset: 0x2f90, bitSize: 0x20(0x4 Byte(s))
    float freecam_default_fov;
    // offset: 0x2fb0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_max_duration;
    // offset: 0x2fd0, bitSize: 0x20(0x4 Byte(s))
    float camera_smooth_factor;
    // offset: 0x2ff0, bitSize: 0x1
    bool codcaster_seriesscore;
    // offset: 0x2ff1, bitSize: 0x1
    bool codcaster_killstreak_view;
    // offset: 0x2ff2, bitSize: 0x1
    bool codcaster_dataview;
    // offset: 0x2ff3, bitSize: 0x1
    bool codcaster_fieldupgrades_notification;
    // offset: 0x2ff4, bitSize: 0x1
    bool codcaster_playernumbers_minimap;
    // offset: 0x2ff5, bitSize: 0x1
    bool codcaster_jerseynumbers;
    // offset: 0x2ff6, bitSize: 0x1
    bool codcaster_xray_loadout;
    // offset: 0x2ff7, bitSize: 0x1
    bool codcaster_playercard;
    // offset: 0x2ff8, bitSize: 0x1
    bool codcaster_playerlist;
    // offset: 0x2ff9, bitSize: 0x1
    bool codcaster_playercard_weapon;
    // offset: 0x2ffa, bitSize: 0x1
    bool codcaster_teamlist;
    // offset: 0x2ffb, bitSize: 0x1
    bool codcaster_xray;
    // offset: 0x2ffc, bitSize: 0x1
    bool codcaster_playercard_portrait;
    // offset: 0x2ffd, bitSize: 0x1
    bool codcaster_team_allies_color3_unlocked;
    // offset: 0x2ffe, bitSize: 0x1
    bool codcaster_announcements;
    // offset: 0x2fff, bitSize: 0x1
    bool codcaster_hidelayer;
    // offset: 0x3000, bitSize: 0x1
    bool shoutcaster_hasbeenread;
    // offset: 0x3001, bitSize: 0x1
    bool codcaster_playercard_equipments;
    // offset: 0x3002, bitSize: 0x1
    bool freecam_translation_ignore_pitch;
    // offset: 0x3003, bitSize: 0x1
    bool codcaster_objectivestatus;
    // offset: 0x3004, bitSize: 0x1
    bool codcaster_killfeed;
    // offset: 0x3005, bitSize: 0x1
    bool codcaster_fieldupgrade_view;
    // offset: 0x3006, bitSize: 0x1
    bool codcaster_nameplates_name;
    // offset: 0x3007, bitSize: 0x1
    bool codcaster_killstreaks_notification;
    // offset: 0x3008, bitSize: 0x1
    bool codcaster_playernumbers_teamlist;
    // offset: 0x3009, bitSize: 0x1
    bool codcaster_playercard_streaks;
    // offset: 0x300a, bitSize: 0x1
    bool codcaster_statuseffect;
    // offset: 0x300b, bitSize: 0x1
    bool aerialcam_default_tethered;
    // offset: 0x300c, bitSize: 0x1
    bool codcaster_playernumbers_playercard;
    // offset: 0x300d, bitSize: 0x1
    bool codcaster_team_identity;
    // offset: 0x300e, bitSize: 0x1
    bool codcaster_waypoint_markers;
    // offset: 0x300f, bitSize: 0x1
    bool freecam_speed_toggle;
    // offset: 0x3010, bitSize: 0x1
    bool codcaster_nameplates;
    // offset: 0x3011, bitSize: 0x1
    bool aerialcam_pucks_enabled;
    // offset: 0x3012, bitSize: 0x1
    bool orbitalcam_angle_is_fixed;
    // offset: 0x3013, bitSize: 0x1
    bool codcaster_xray_objectives;
    // offset: 0x3014, bitSize: 0x1
    bool codcaster_fullscreen_map;
    // offset: 0x3015, bitSize: 0x1
    bool codcaster_playernumbers;
    // offset: 0x3016, bitSize: 0x1
    bool freecam_pucks_enabled;
    // offset: 0x3017, bitSize: 0x1
    bool codcaster_scoreheader;
    // offset: 0x3018, bitSize: 0x1
    bool codcaster_minimap;
    // offset: 0x3019, bitSize: 0x1
    bool codcaster_team_axis_color3_unlocked;
    // offset: 0x301a, bitSize: 0x1
    bool codcaster_nameplates_number;
    // offset: 0x301b, bitSize: 0x1
    bool freecam_clipping_enabled;
};

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 3 (0x3)
    // bit size .. 12496 (0x30d0)
    // byte size . 1562 (0x61a)
    // archive ... hash_2774f60fd827955b

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

    // root: bitSize: 0x3020, members: 93

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_yaw;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_min_duration;
    // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_smooth_modifier;
    // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_smooth_factor;
    // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_bottom;
    // offset: 0x90, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_sensitivity;
    // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_top;
    // offset: 0xc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_bestoflimit;
    // offset: 0xc8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_smooth_modifier;
    // offset: 0xe8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_sensitivity;
    // offset: 0x108, bitSize: 0x27a8(0x4f5 Byte(s)), array:0x9(hti:0x0)
    codcaster_map_data codcaster_maps[mp_maps];
    // offset: 0x28b0, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_acronym;
    // offset: 0x29b0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_speed;
    // offset: 0x29d0, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_allies_icon;
    // offset: 0x29d8, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_name;
    // offset: 0x2ad8, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_rotation_smooth_modifier;
    // offset: 0x2af8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_speed;
    // offset: 0x2b18, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_smooth_factor;
    // offset: 0x2b38, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_base_distance;
    // offset: 0x2b58, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_smooth_factor;
    // offset: 0x2b78, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_smooth_modifier;
    // offset: 0x2b98, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_acronym;
    // offset: 0x2c98, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_smooth_factor;
    // offset: 0x2cb8, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team1;
    // offset: 0x2cc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team2;
    // offset: 0x2cc8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color1;
    // offset: 0x2ce0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color2;
    // offset: 0x2cf8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color3;
    // offset: 0x2d10, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_starting_camera;
    // offset: 0x2d18, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_speed;
    // offset: 0x2d38, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_axis_icon;
    // offset: 0x2d40, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_name;
    // offset: 0x2e40, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_vertical_offset;
    // offset: 0x2e60, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_speed;
    // offset: 0x2e80, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_smooth_modifier;
    // offset: 0x2ea0, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_xray_type;
    // offset: 0x2ea8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color1;
    // offset: 0x2ec0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color2;
    // offset: 0x2ed8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color3;
    // offset: 0x2ef0, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_slow_factor;
    // offset: 0x2f10, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_fast_factor;
    // offset: 0x2f30, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_sensitivity;
    // offset: 0x2f50, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_sensitivity;
    // offset: 0x2f70, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_player_movement_smooth_factor;
    // offset: 0x2f90, bitSize: 0x20(0x4 Byte(s))
    float freecam_default_fov;
    // offset: 0x2fb0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_max_duration;
    // offset: 0x2fd0, bitSize: 0x20(0x4 Byte(s))
    float camera_smooth_factor;
    // offset: 0x2ff0, bitSize: 0x1
    bool codcaster_seriesscore;
    // offset: 0x2ff1, bitSize: 0x1
    bool codcaster_killstreak_view;
    // offset: 0x2ff2, bitSize: 0x1
    bool codcaster_dataview;
    // offset: 0x2ff3, bitSize: 0x1
    bool codcaster_fieldupgrades_notification;
    // offset: 0x2ff4, bitSize: 0x1
    bool codcaster_playernumbers_minimap;
    // offset: 0x2ff5, bitSize: 0x1
    bool codcaster_jerseynumbers;
    // offset: 0x2ff6, bitSize: 0x1
    bool codcaster_xray_loadout;
    // offset: 0x2ff7, bitSize: 0x1
    bool codcaster_playercard;
    // offset: 0x2ff8, bitSize: 0x1
    bool codcaster_playerlist;
    // offset: 0x2ff9, bitSize: 0x1
    bool codcaster_sponsors;
    // offset: 0x2ffa, bitSize: 0x1
    bool codcaster_playercard_weapon;
    // offset: 0x2ffb, bitSize: 0x1
    bool codcaster_teamlist;
    // offset: 0x2ffc, bitSize: 0x1
    bool codcaster_xray;
    // offset: 0x2ffd, bitSize: 0x1
    bool codcaster_playercard_portrait;
    // offset: 0x2ffe, bitSize: 0x1
    bool codcaster_team_allies_color3_unlocked;
    // offset: 0x2fff, bitSize: 0x1
    bool codcaster_announcements;
    // offset: 0x3000, bitSize: 0x1
    bool codcaster_hidelayer;
    // offset: 0x3001, bitSize: 0x1
    bool shoutcaster_hasbeenread;
    // offset: 0x3002, bitSize: 0x1
    bool codcaster_playercard_equipments;
    // offset: 0x3003, bitSize: 0x1
    bool freecam_translation_ignore_pitch;
    // offset: 0x3004, bitSize: 0x1
    bool codcaster_objectivestatus;
    // offset: 0x3005, bitSize: 0x1
    bool codcaster_killfeed;
    // offset: 0x3006, bitSize: 0x1
    bool codcaster_fieldupgrade_view;
    // offset: 0x3007, bitSize: 0x1
    bool codcaster_nameplates_name;
    // offset: 0x3008, bitSize: 0x1
    bool codcaster_killstreaks_notification;
    // offset: 0x3009, bitSize: 0x1
    bool codcaster_playernumbers_teamlist;
    // offset: 0x300a, bitSize: 0x1
    bool codcaster_playercard_streaks;
    // offset: 0x300b, bitSize: 0x1
    bool codcaster_statuseffect;
    // offset: 0x300c, bitSize: 0x1
    bool aerialcam_default_tethered;
    // offset: 0x300d, bitSize: 0x1
    bool codcaster_playernumbers_playercard;
    // offset: 0x300e, bitSize: 0x1
    bool codcaster_team_identity;
    // offset: 0x300f, bitSize: 0x1
    bool codcaster_waypoint_markers;
    // offset: 0x3010, bitSize: 0x1
    bool freecam_speed_toggle;
    // offset: 0x3011, bitSize: 0x1
    bool codcaster_nameplates;
    // offset: 0x3012, bitSize: 0x1
    bool aerialcam_pucks_enabled;
    // offset: 0x3013, bitSize: 0x1
    bool orbitalcam_angle_is_fixed;
    // offset: 0x3014, bitSize: 0x1
    bool codcaster_xray_objectives;
    // offset: 0x3015, bitSize: 0x1
    bool codcaster_fullscreen_map;
    // offset: 0x3016, bitSize: 0x1
    bool codcaster_playernumbers;
    // offset: 0x3017, bitSize: 0x1
    bool freecam_pucks_enabled;
    // offset: 0x3018, bitSize: 0x1
    bool codcaster_scoreheader;
    // offset: 0x3019, bitSize: 0x1
    bool codcaster_minimap;
    // offset: 0x301a, bitSize: 0x1
    bool codcaster_team_axis_color3_unlocked;
    // offset: 0x301b, bitSize: 0x1
    bool codcaster_nameplates_number;
    // offset: 0x301c, bitSize: 0x1
    bool freecam_clipping_enabled;
};

version 1 {
    // enums ..... 1 (0x1)
    // structs ... 3 (0x3)
    // bit size .. 12496 (0x30d0)
    // byte size . 1562 (0x61a)
    // archive ... hash_73db23e34129b9

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

    // root: bitSize: 0x3020, members: 94

    // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_yaw;
    // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_min_duration;
    // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_smooth_modifier;
    // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_smooth_factor;
    // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_bottom;
    // offset: 0x90, bitSize: 0x20(0x4 Byte(s))
    float freecam_mouse_sensitivity;
    // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
    uint:16 codcaster_ticker_top;
    // offset: 0xc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_bestoflimit;
    // offset: 0xc8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_smooth_modifier;
    // offset: 0xe8, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_sensitivity;
    // offset: 0x108, bitSize: 0x27a8(0x4f5 Byte(s)), array:0x9(hti:0x0)
    codcaster_map_data codcaster_maps[mp_maps];
    // offset: 0x28b0, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_acronym;
    // offset: 0x29b0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_vertical_speed;
    // offset: 0x29d0, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_allies_icon;
    // offset: 0x29d8, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_name;
    // offset: 0x2ad8, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_rotation_smooth_modifier;
    // offset: 0x2af8, bitSize: 0x20(0x4 Byte(s))
    float freecam_horizontal_speed;
    // offset: 0x2b18, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_smooth_factor;
    // offset: 0x2b38, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_base_distance;
    // offset: 0x2b58, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_smooth_factor;
    // offset: 0x2b78, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_smooth_modifier;
    // offset: 0x2b98, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_allies_acronym;
    // offset: 0x2c98, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_gamepad_smooth_factor;
    // offset: 0x2cb8, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team1;
    // offset: 0x2cc0, bitSize: 0x8(0x1 Byte(s))
    uint:4 codcaster_seriesscore_override_team2;
    // offset: 0x2cc8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color1;
    // offset: 0x2ce0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color2;
    // offset: 0x2cf8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_allies_color3;
    // offset: 0x2d10, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_starting_camera;
    // offset: 0x2d18, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_speed;
    // offset: 0x2d38, bitSize: 0x8(0x1 Byte(s))
    uint:6 codcaster_team_axis_icon;
    // offset: 0x2d40, bitSize: 0x100(0x20 Byte(s))
    string(32) codcaster_team_axis_name;
    // offset: 0x2e40, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_fixed_vertical_offset;
    // offset: 0x2e60, bitSize: 0x20(0x4 Byte(s))
    float freecam_vertical_speed;
    // offset: 0x2e80, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_horizontal_smooth_modifier;
    // offset: 0x2ea0, bitSize: 0x8(0x1 Byte(s))
    uint:2 codcaster_xray_type;
    // offset: 0x2ea8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color1;
    // offset: 0x2ec0, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color2;
    // offset: 0x2ed8, bitSize: 0x18(0x3 Byte(s))
    uint:24 codcaster_team_axis_color3;
    // offset: 0x2ef0, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_slow_factor;
    // offset: 0x2f10, bitSize: 0x20(0x4 Byte(s))
    float freecam_speed_fast_factor;
    // offset: 0x2f30, bitSize: 0x20(0x4 Byte(s))
    float freecam_gamepad_sensitivity;
    // offset: 0x2f50, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_mouse_sensitivity;
    // offset: 0x2f70, bitSize: 0x20(0x4 Byte(s))
    float orbitalcam_player_movement_smooth_factor;
    // offset: 0x2f90, bitSize: 0x20(0x4 Byte(s))
    float freecam_default_fov;
    // offset: 0x2fb0, bitSize: 0x20(0x4 Byte(s))
    float aerialcam_animation_max_duration;
    // offset: 0x2fd0, bitSize: 0x20(0x4 Byte(s))
    float camera_smooth_factor;
    // offset: 0x2ff0, bitSize: 0x1
    bool codcaster_seriesscore;
    // offset: 0x2ff1, bitSize: 0x1
    bool codcaster_killstreak_view;
    // offset: 0x2ff2, bitSize: 0x1
    bool codcaster_dataview;
    // offset: 0x2ff3, bitSize: 0x1
    bool codcaster_fieldupgrades_notification;
    // offset: 0x2ff4, bitSize: 0x1
    bool codcaster_playernumbers_minimap;
    // offset: 0x2ff5, bitSize: 0x1
    bool codcaster_jerseynumbers;
    // offset: 0x2ff6, bitSize: 0x1
    bool codcaster_xray_loadout;
    // offset: 0x2ff7, bitSize: 0x1
    bool codcaster_playercard;
    // offset: 0x2ff8, bitSize: 0x1
    bool codcaster_playerlist;
    // offset: 0x2ff9, bitSize: 0x1
    bool codcaster_sponsors;
    // offset: 0x2ffa, bitSize: 0x1
    bool codcaster_playercard_weapon;
    // offset: 0x2ffb, bitSize: 0x1
    bool codcaster_teamlist;
    // offset: 0x2ffc, bitSize: 0x1
    bool codcaster_xray;
    // offset: 0x2ffd, bitSize: 0x1
    bool codcaster_playercard_portrait;
    // offset: 0x2ffe, bitSize: 0x1
    bool codcaster_team_allies_color3_unlocked;
    // offset: 0x2fff, bitSize: 0x1
    bool codcaster_announcements;
    // offset: 0x3000, bitSize: 0x1
    bool codcaster_hidelayer;
    // offset: 0x3001, bitSize: 0x1
    bool shoutcaster_hasbeenread;
    // offset: 0x3002, bitSize: 0x1
    bool codcaster_playercard_equipments;
    // offset: 0x3003, bitSize: 0x1
    bool freecam_translation_ignore_pitch;
    // offset: 0x3004, bitSize: 0x1
    bool codcaster_objectivestatus;
    // offset: 0x3005, bitSize: 0x1
    bool codcaster_killfeed;
    // offset: 0x3006, bitSize: 0x1
    bool codcaster_fieldupgrade_view;
    // offset: 0x3007, bitSize: 0x1
    bool codcaster_nameplates_name;
    // offset: 0x3008, bitSize: 0x1
    bool codcaster_killstreaks_notification;
    // offset: 0x3009, bitSize: 0x1
    bool codcaster_playernumbers_teamlist;
    // offset: 0x300a, bitSize: 0x1
    bool codcaster_playercard_streaks;
    // offset: 0x300b, bitSize: 0x1
    bool codcaster_statuseffect;
    // offset: 0x300c, bitSize: 0x1
    bool aerialcam_default_tethered;
    // offset: 0x300d, bitSize: 0x1
    bool codcaster_playernumbers_playercard;
    // offset: 0x300e, bitSize: 0x1
    bool codcaster_team_identity;
    // offset: 0x300f, bitSize: 0x1
    bool codcaster_waypoint_markers;
    // offset: 0x3010, bitSize: 0x1
    bool freecam_speed_toggle;
    // offset: 0x3011, bitSize: 0x1
    bool codcaster_nameplates;
    // offset: 0x3012, bitSize: 0x1
    bool aerialcam_pucks_enabled;
    // offset: 0x3013, bitSize: 0x1
    bool orbitalcam_angle_is_fixed;
    // offset: 0x3014, bitSize: 0x1
    bool codcaster_xray_objectives;
    // offset: 0x3015, bitSize: 0x1
    bool codcaster_socialshortcut;
    // offset: 0x3016, bitSize: 0x1
    bool codcaster_fullscreen_map;
    // offset: 0x3017, bitSize: 0x1
    bool codcaster_playernumbers;
    // offset: 0x3018, bitSize: 0x1
    bool freecam_pucks_enabled;
    // offset: 0x3019, bitSize: 0x1
    bool codcaster_scoreheader;
    // offset: 0x301a, bitSize: 0x1
    bool codcaster_minimap;
    // offset: 0x301b, bitSize: 0x1
    bool codcaster_team_axis_color3_unlocked;
    // offset: 0x301c, bitSize: 0x1
    bool codcaster_nameplates_number;
    // offset: 0x301d, bitSize: 0x1
    bool freecam_clipping_enabled;
};

