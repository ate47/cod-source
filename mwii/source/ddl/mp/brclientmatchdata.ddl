// file .... ddl\mp\brclientmatchdata.ddl

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_b1900869dee63457

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2e8, members: 23
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short extrascore4;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short extrascore5;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0x110, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x150, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x158, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x168, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2d8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2e0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x50 type: 0
    enum BaseGameMode {
        aon, // 0x0
        dm, // 0x1
        war, // 0x2
        sd, // 0x3
        sab, // 0x4
        dom, // 0x5
        koth, // 0x6
        ctf, // 0x7
        dd, // 0x8
        conf, // 0x9
        control, // 0xa
        tdef, // 0xb
        siege, // 0xc
        grnd, // 0xd
        tjugg, // 0xe
        jugg, // 0xf
        gun, // 0x10
        infect, // 0x11
        oic, // 0x12
        mugger, // 0x13
        blitz, // 0x14
        sr, // 0x15
        grind, // 0x16
        sotf, // 0x17
        sotf_ffa, // 0x18
        assault, // 0x19
        aliens, // 0x1a
        cp_survival, // 0x1b
        cp_wave_sv, // 0x1c
        cp_specops, // 0x1d
        zombie, // 0x1e
        escape, // 0x1f
        cp_pvpve, // 0x20
        cp_strike, // 0x21
        cp_trials, // 0x22
        ball, // 0x23
        front, // 0x24
        arena, // 0x25
        cmd, // 0x26
        br, // 0x27
        br_dmz, // 0x28
        cyber, // 0x29
        rush, // 0x2a
        esc, // 0x2b
        vip, // 0x2c
        btm, // 0x2d
        rugby, // 0x2e
        arm, // 0x2f
        mtmc, // 0x30
        snatch, // 0x31
        hq, // 0x32
        defcon, // 0x33
        pill, // 0x34
        brm, // 0x35
        hvt, // 0x36
        trial, // 0x37
        brtdm, // 0x38
        br_risk, // 0x39
        incursion, // 0x3a
        missions, // 0x3b
        cqc, // 0x3c
        br_plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob, // 0x48
        br_resurgence, // 0x49
        benchmark, // 0x4a
        ballmode, // 0x4b
        brtdm_mgl, // 0x4c
        conflict, // 0x4d
        havoc, // 0x4e
        bigctf // 0x4f
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x93 type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical, // 0x8e
        specialty_pc_medic, // 0x8f
        specialty_pc_comms, // 0x90
        specialty_pc_stealth, // 0x91
        specialty_pc_tempered // 0x92
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x23 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_shuriken, // 0x20
        equip_throwstar, // 0x21
        equip_thermal_phone // 0x22
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0xf type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        xb4, // 0x4
        ps4, // 0x5
        ps5, // 0x6
        wegame, // 0x7
        ios, // 0x8
        android, // 0x9
        switch, // 0xa
        bot, // 0xb
        msstore, // 0xc
        ubiconnect, // 0xd
        any // 0xe
    };

    // root: bitSize: 0x29ec0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ea8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29eb8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_61b2ea425b48e161

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x41 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb // 0x40
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x89 type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored // 0x88
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x1e type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster // 0x1d
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xca type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred // 0xc9
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_c05fcbcea58c65f9

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x41 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb // 0x40
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8a type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade // 0x89
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x1e type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster // 0x1d
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xca type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred // 0xc9
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_e36b49e04866d1d1

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x42 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue // 0x41
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8b type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor // 0x8a
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x1e type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster // 0x1d
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xca type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred // 0xc9
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_1fac7c99d3f5648

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x42 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue // 0x41
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8b type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor // 0x8a
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x1f type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars // 0x1e
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xca type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred // 0xc9
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_f1fb5fe3f4f9b196

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x42 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue // 0x41
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8c type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch // 0x8b
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x1f type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars // 0x1e
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xca type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred // 0xc9
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_b8a9172d2e5e32db

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x42 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue // 0x41
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8c type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch // 0x8b
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xca type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred // 0xc9
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_c770652bd9a33b9d

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x43 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue, // 0x41
        landgrab // 0x42
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8c type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch // 0x8b
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xca type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred // 0xc9
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_ac91fc6cb14f4490

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x43 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue, // 0x41
        landgrab // 0x42
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8c type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch // 0x8b
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_65fa67ec718021d8

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x43 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue, // 0x41
        landgrab // 0x42
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x25 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort // 0x24
    };

    // idx 0x5 members: 0x8e type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus // 0x8d
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_4c67e692773810b1

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x43 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue, // 0x41
        landgrab // 0x42
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8e type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus // 0x8d
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_3426dbf28a295ce5

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x44 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue, // 0x41
        landgrab, // 0x42
        gwai // 0x43
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8e type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus // 0x8d
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_336fe10d3dc4e25d

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x45 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        tdef, // 0x9
        siege, // 0xa
        grnd, // 0xb
        tjugg, // 0xc
        jugg, // 0xd
        gun, // 0xe
        infect, // 0xf
        oic, // 0x10
        mugger, // 0x11
        blitz, // 0x12
        sr, // 0x13
        grind, // 0x14
        sotf, // 0x15
        sotf_ffa, // 0x16
        assault, // 0x17
        aliens, // 0x18
        cp_survival, // 0x19
        cp_wave_sv, // 0x1a
        cp_specops, // 0x1b
        zombie, // 0x1c
        escape, // 0x1d
        cp_pvpve, // 0x1e
        cp_strike, // 0x1f
        cp_trials, // 0x20
        ball, // 0x21
        front, // 0x22
        arena, // 0x23
        cmd, // 0x24
        br, // 0x25
        br_dmz, // 0x26
        cyber, // 0x27
        rush, // 0x28
        esc, // 0x29
        vip, // 0x2a
        btm, // 0x2b
        rugby, // 0x2c
        arm, // 0x2d
        mtmc, // 0x2e
        snatch, // 0x2f
        hq, // 0x30
        defcon, // 0x31
        pill, // 0x32
        brm, // 0x33
        hvt, // 0x34
        trial, // 0x35
        brtdm, // 0x36
        br_risk, // 0x37
        incursion, // 0x38
        missions, // 0x39
        cqc, // 0x3a
        br_plunder, // 0x3b
        ko, // 0x3c
        risk, // 0x3d
        hstg, // 0x3e
        fr, // 0x3f
        gwbomb, // 0x40
        rescue, // 0x41
        landgrab, // 0x42
        gwai, // 0x43
        bounty // 0x44
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8e type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus // 0x8d
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_d1e52ebad77dc26c

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x46 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty // 0x45
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8e type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus // 0x8d
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_69dcf705b7e74c62

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x46 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty // 0x45
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165296 (0x285b0)
    // byte size . 20662 (0x50b6)
    // archive ... hash_de72808bed2012d5

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x46 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty // 0x45
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_impact_grenade // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285a0, members: 14

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5908, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5948, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x28588, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x28598, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_49934b3f03986f7

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x46 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty // 0x45
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_impact_grenade // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_c2eba054c5596b56

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x47 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb // 0x46
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_impact_grenade // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_2eb3c89660f7355c

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x48 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm // 0x47
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_impact_grenade // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_efc70e307e0b9e67

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x49 type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob // 0x48
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_impact_grenade // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_b5f5395f666bd786

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x4a type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        landgrab, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob, // 0x48
        war_mgl // 0x49
    };

    // idx 0x1 members: 0xb7 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        super_kill_steeldragon, // 0x69
        super_kill_amplify, // 0x6a
        super_kill_overdrive, // 0x6b
        super_kill_claw, // 0x6c
        super_kill_armorup, // 0x6d
        super_kill_bull_charge, // 0x6e
        super_kill_armmgs, // 0x6f
        super_kill_reaper, // 0x70
        super_kill_rewind, // 0x71
        super_kill_atomizer, // 0x72
        super_kill_phaseshift, // 0x73
        super_kill_teleport, // 0x74
        super_kill_blackholegun, // 0x75
        super_kill_supertrophy, // 0x76
        super_kill_microturret, // 0x77
        super_kill_penetrationrailgun, // 0x78
        super_kill_visionpulse, // 0x79
        super_kill_invisible, // 0x7a
        super_shutdown_steeldragon, // 0x7b
        super_shutdown_amplify, // 0x7c
        super_shutdown_overdrive, // 0x7d
        super_shutdown_claw, // 0x7e
        super_shutdown_armorup, // 0x7f
        super_shutdown_bull_charge, // 0x80
        super_shutdown_armmgs, // 0x81
        super_shutdown_reaper, // 0x82
        super_shutdown_rewind, // 0x83
        super_shutdown_atomizer, // 0x84
        super_shutdown_phaseshift, // 0x85
        super_shutdown_teleport, // 0x86
        super_shutdown_blackholegun, // 0x87
        super_shutdown_supertrophy, // 0x88
        super_shutdown_microturret, // 0x89
        super_shutdown_penetrationrailgun, // 0x8a
        super_shutdown_visionpulse, // 0x8b
        super_shutdown_invisible, // 0x8c
        mode_ctf_cap, // 0x8d
        mode_ctf_kill_carrier, // 0x8e
        mode_ctf_kill_with_flag, // 0x8f
        mode_ctf_close_return, // 0x90
        mode_ctf_nope, // 0x91
        mode_x_last_alive, // 0x92
        mode_x_eliminate, // 0x93
        mode_sd_last_defuse, // 0x94
        mode_sd_defuse, // 0x95
        mode_sd_detonate, // 0x96
        mode_sd_plant_save, // 0x97
        mode_sd_defuse_save, // 0x98
        mode_x_clear, // 0x99
        mode_hp_secure, // 0x9a
        mode_hp_secure_reduced, // 0x9b
        mode_hp_assault, // 0x9c
        mode_hp_quick_cap, // 0x9d
        mode_kc_own_tags, // 0x9e
        mode_kc_3_tags, // 0x9f
        mode_dom_secure_b, // 0xa0
        mode_dom_secure_neutral, // 0xa1
        mode_dom_assault, // 0xa2
        mode_dom_secure_assist, // 0xa3
        mode_dom_secure, // 0xa4
        mode_dom_neutralized, // 0xa5
        mode_dom_neutralized_cap, // 0xa6
        mode_arm_secure_mid, // 0xa7
        mode_arm_secure_outer_mid, // 0xa8
        mode_arm_secure_outer, // 0xa9
        mode_cyber_kill_with_emp, // 0xaa
        mode_cyber_kill_carrier, // 0xab
        mode_x_assault, // 0xac
        mode_x_defend, // 0xad
        mode_x_wipeout, // 0xae
        mode_siege_secure, // 0xaf
        mode_gun_quick_kill, // 0xb0
        mode_gun_melee_1st_place, // 0xb1
        mode_gun_melee, // 0xb2
        match_complete, // 0xb3
        match_complete_win, // 0xb4
        rock_paper_scissors_win, // 0xb5
        simultaneous_kill // 0xb6
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x28 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        napalm_strike, // 0x25
        missile_turret, // 0x26
        rcxd // 0x27
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_impact_grenade // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0x7 type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX // 0x6
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_fa951188855abb07

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x4d type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        gwai, // 0x43
        bounty, // 0x44
        zm_rb, // 0x45
        gwtdm, // 0x46
        ob, // 0x47
        war_mgl, // 0x48
        dom_mgl, // 0x49
        br_resurgence, // 0x4a
        benchmark, // 0x4b
        boostball // 0x4c
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_1a8285ff1723233c

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x4d type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        gwai, // 0x43
        bounty, // 0x44
        zm_rb, // 0x45
        gwtdm, // 0x46
        ob, // 0x47
        war_mgl, // 0x48
        dom_mgl, // 0x49
        br_resurgence, // 0x4a
        benchmark, // 0x4b
        ballmode // 0x4c
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x20 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills // 0x1f
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_bd48ee209ad06315

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x4d type: 0
    enum BaseGameMode {
        dm, // 0x0
        war, // 0x1
        sd, // 0x2
        sab, // 0x3
        dom, // 0x4
        koth, // 0x5
        ctf, // 0x6
        dd, // 0x7
        conf, // 0x8
        control, // 0x9
        tdef, // 0xa
        siege, // 0xb
        grnd, // 0xc
        tjugg, // 0xd
        jugg, // 0xe
        gun, // 0xf
        infect, // 0x10
        oic, // 0x11
        mugger, // 0x12
        blitz, // 0x13
        sr, // 0x14
        grind, // 0x15
        sotf, // 0x16
        sotf_ffa, // 0x17
        assault, // 0x18
        aliens, // 0x19
        cp_survival, // 0x1a
        cp_wave_sv, // 0x1b
        cp_specops, // 0x1c
        zombie, // 0x1d
        escape, // 0x1e
        cp_pvpve, // 0x1f
        cp_strike, // 0x20
        cp_trials, // 0x21
        ball, // 0x22
        front, // 0x23
        arena, // 0x24
        cmd, // 0x25
        br, // 0x26
        br_dmz, // 0x27
        cyber, // 0x28
        rush, // 0x29
        esc, // 0x2a
        vip, // 0x2b
        btm, // 0x2c
        rugby, // 0x2d
        arm, // 0x2e
        mtmc, // 0x2f
        snatch, // 0x30
        hq, // 0x31
        defcon, // 0x32
        pill, // 0x33
        brm, // 0x34
        hvt, // 0x35
        trial, // 0x36
        brtdm, // 0x37
        br_risk, // 0x38
        incursion, // 0x39
        missions, // 0x3a
        cqc, // 0x3b
        br_plunder, // 0x3c
        ko, // 0x3d
        risk, // 0x3e
        hstg, // 0x3f
        fr, // 0x40
        gwbomb, // 0x41
        rescue, // 0x42
        gwai, // 0x43
        bounty, // 0x44
        zm_rb, // 0x45
        gwtdm, // 0x46
        ob, // 0x47
        war_mgl, // 0x48
        dom_mgl, // 0x49
        br_resurgence, // 0x4a
        benchmark, // 0x4b
        ballmode // 0x4c
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_shuriken // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_406a328cf021c7c2

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x4e type: 0
    enum BaseGameMode {
        aon, // 0x0
        dm, // 0x1
        war, // 0x2
        sd, // 0x3
        sab, // 0x4
        dom, // 0x5
        koth, // 0x6
        ctf, // 0x7
        dd, // 0x8
        conf, // 0x9
        control, // 0xa
        tdef, // 0xb
        siege, // 0xc
        grnd, // 0xd
        tjugg, // 0xe
        jugg, // 0xf
        gun, // 0x10
        infect, // 0x11
        oic, // 0x12
        mugger, // 0x13
        blitz, // 0x14
        sr, // 0x15
        grind, // 0x16
        sotf, // 0x17
        sotf_ffa, // 0x18
        assault, // 0x19
        aliens, // 0x1a
        cp_survival, // 0x1b
        cp_wave_sv, // 0x1c
        cp_specops, // 0x1d
        zombie, // 0x1e
        escape, // 0x1f
        cp_pvpve, // 0x20
        cp_strike, // 0x21
        cp_trials, // 0x22
        ball, // 0x23
        front, // 0x24
        arena, // 0x25
        cmd, // 0x26
        br, // 0x27
        br_dmz, // 0x28
        cyber, // 0x29
        rush, // 0x2a
        esc, // 0x2b
        vip, // 0x2c
        btm, // 0x2d
        rugby, // 0x2e
        arm, // 0x2f
        mtmc, // 0x30
        snatch, // 0x31
        hq, // 0x32
        defcon, // 0x33
        pill, // 0x34
        brm, // 0x35
        hvt, // 0x36
        trial, // 0x37
        brtdm, // 0x38
        br_risk, // 0x39
        incursion, // 0x3a
        missions, // 0x3b
        cqc, // 0x3c
        br_plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob, // 0x48
        war_mgl, // 0x49
        dom_mgl, // 0x4a
        br_resurgence, // 0x4b
        benchmark, // 0x4c
        ballmode // 0x4d
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_shuriken // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 165328 (0x285d0)
    // byte size . 20666 (0x50ba)
    // archive ... hash_c1a313f30b09cd65

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2c8, members: 21
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x130, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x138, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x148, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2b8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2c0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x4f type: 0
    enum BaseGameMode {
        aon, // 0x0
        dm, // 0x1
        war, // 0x2
        sd, // 0x3
        sab, // 0x4
        dom, // 0x5
        koth, // 0x6
        ctf, // 0x7
        dd, // 0x8
        conf, // 0x9
        control, // 0xa
        tdef, // 0xb
        siege, // 0xc
        grnd, // 0xd
        tjugg, // 0xe
        jugg, // 0xf
        gun, // 0x10
        infect, // 0x11
        oic, // 0x12
        mugger, // 0x13
        blitz, // 0x14
        sr, // 0x15
        grind, // 0x16
        sotf, // 0x17
        sotf_ffa, // 0x18
        assault, // 0x19
        aliens, // 0x1a
        cp_survival, // 0x1b
        cp_wave_sv, // 0x1c
        cp_specops, // 0x1d
        zombie, // 0x1e
        escape, // 0x1f
        cp_pvpve, // 0x20
        cp_strike, // 0x21
        cp_trials, // 0x22
        ball, // 0x23
        front, // 0x24
        arena, // 0x25
        cmd, // 0x26
        br, // 0x27
        br_dmz, // 0x28
        cyber, // 0x29
        rush, // 0x2a
        esc, // 0x2b
        vip, // 0x2c
        btm, // 0x2d
        rugby, // 0x2e
        arm, // 0x2f
        mtmc, // 0x30
        snatch, // 0x31
        hq, // 0x32
        defcon, // 0x33
        pill, // 0x34
        brm, // 0x35
        hvt, // 0x36
        trial, // 0x37
        brtdm, // 0x38
        br_risk, // 0x39
        incursion, // 0x3a
        missions, // 0x3b
        cqc, // 0x3c
        br_plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob, // 0x48
        war_mgl, // 0x49
        dom_mgl, // 0x4a
        br_resurgence, // 0x4b
        benchmark, // 0x4c
        ballmode, // 0x4d
        koth_mgl // 0x4e
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x21 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_shuriken // 0x20
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x285c0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x22c40(0x4588 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x285a8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x285b8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_2571dfa78082259e

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2e8, members: 23
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short extrascore4;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short extrascore5;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0x110, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x150, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x158, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x168, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2d8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2e0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x50 type: 0
    enum BaseGameMode {
        aon, // 0x0
        dm, // 0x1
        war, // 0x2
        sd, // 0x3
        sab, // 0x4
        dom, // 0x5
        koth, // 0x6
        ctf, // 0x7
        dd, // 0x8
        conf, // 0x9
        control, // 0xa
        tdef, // 0xb
        siege, // 0xc
        grnd, // 0xd
        tjugg, // 0xe
        jugg, // 0xf
        gun, // 0x10
        infect, // 0x11
        oic, // 0x12
        mugger, // 0x13
        blitz, // 0x14
        sr, // 0x15
        grind, // 0x16
        sotf, // 0x17
        sotf_ffa, // 0x18
        assault, // 0x19
        aliens, // 0x1a
        cp_survival, // 0x1b
        cp_wave_sv, // 0x1c
        cp_specops, // 0x1d
        zombie, // 0x1e
        escape, // 0x1f
        cp_pvpve, // 0x20
        cp_strike, // 0x21
        cp_trials, // 0x22
        ball, // 0x23
        front, // 0x24
        arena, // 0x25
        cmd, // 0x26
        br, // 0x27
        br_dmz, // 0x28
        cyber, // 0x29
        rush, // 0x2a
        esc, // 0x2b
        vip, // 0x2c
        btm, // 0x2d
        rugby, // 0x2e
        arm, // 0x2f
        mtmc, // 0x30
        snatch, // 0x31
        hq, // 0x32
        defcon, // 0x33
        pill, // 0x34
        brm, // 0x35
        hvt, // 0x36
        trial, // 0x37
        brtdm, // 0x38
        br_risk, // 0x39
        incursion, // 0x3a
        missions, // 0x3b
        cqc, // 0x3c
        br_plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob, // 0x48
        war_mgl, // 0x49
        dom_mgl, // 0x4a
        br_resurgence, // 0x4b
        benchmark, // 0x4c
        ballmode, // 0x4d
        koth_mgl, // 0x4e
        brtdm_mgl // 0x4f
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x8f type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical // 0x8e
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x22 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_shuriken, // 0x20
        equip_throwstar // 0x21
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ec0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ea8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29eb8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_58b776eae9aa6334

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2e8, members: 23
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short extrascore4;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short extrascore5;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0x110, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x150, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x158, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x168, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2d8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2e0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x52 type: 0
    enum BaseGameMode {
        aon, // 0x0
        dm, // 0x1
        war, // 0x2
        sd, // 0x3
        sab, // 0x4
        dom, // 0x5
        koth, // 0x6
        ctf, // 0x7
        dd, // 0x8
        conf, // 0x9
        control, // 0xa
        tdef, // 0xb
        siege, // 0xc
        grnd, // 0xd
        tjugg, // 0xe
        jugg, // 0xf
        gun, // 0x10
        infect, // 0x11
        oic, // 0x12
        mugger, // 0x13
        blitz, // 0x14
        sr, // 0x15
        grind, // 0x16
        sotf, // 0x17
        sotf_ffa, // 0x18
        assault, // 0x19
        aliens, // 0x1a
        cp_survival, // 0x1b
        cp_wave_sv, // 0x1c
        cp_specops, // 0x1d
        zombie, // 0x1e
        escape, // 0x1f
        cp_pvpve, // 0x20
        cp_strike, // 0x21
        cp_trials, // 0x22
        ball, // 0x23
        front, // 0x24
        arena, // 0x25
        cmd, // 0x26
        br, // 0x27
        br_dmz, // 0x28
        cyber, // 0x29
        rush, // 0x2a
        esc, // 0x2b
        vip, // 0x2c
        btm, // 0x2d
        rugby, // 0x2e
        arm, // 0x2f
        mtmc, // 0x30
        snatch, // 0x31
        hq, // 0x32
        defcon, // 0x33
        pill, // 0x34
        brm, // 0x35
        hvt, // 0x36
        trial, // 0x37
        brtdm, // 0x38
        br_risk, // 0x39
        incursion, // 0x3a
        missions, // 0x3b
        cqc, // 0x3c
        br_plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob, // 0x48
        war_mgl, // 0x49
        dom_mgl, // 0x4a
        br_resurgence, // 0x4b
        benchmark, // 0x4c
        ballmode, // 0x4d
        koth_mgl, // 0x4e
        brtdm_mgl, // 0x4f
        conflict, // 0x50
        havoc // 0x51
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x93 type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical, // 0x8e
        specialty_pc_medic, // 0x8f
        specialty_pc_comms, // 0x90
        specialty_pc_stealth, // 0x91
        specialty_pc_tempered // 0x92
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x23 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_shuriken, // 0x20
        equip_throwstar, // 0x21
        equip_thermal_phone // 0x22
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ec0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ea8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29eb8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 12 (0xc)
    // structs ... 7 (0x7)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_3b75d81d7b67b168

    // bitSize: 0x28, members: 2
    struct AwardInfo {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Awards award;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int value;
    };

    // bitSize: 0x98, members: 10
    struct PastTitleData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int nextreadGhosts;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int nextreadBO3;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        short prestigeAW;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short prestigeGhosts;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short prestigeBO3;
        // offset: 0x70, bitSize: 0x20(0x4 Byte(s))
        int nextreadAW;
        // offset: 0x90, bitSize: 0x1
        bool playedAW;
        // offset: 0x91, bitSize: 0x1
        bool playedBO3;
        // offset: 0x92, bitSize: 0x1
        bool playedGhosts;
    };

    // bitSize: 0x190, members: 24
    struct PetWatchData {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short phase;
        // offset: 0x10, bitSize: 0x10(0x2 Byte(s))
        short killsCharge;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s))
        int:16 dirtyDmg;
        // offset: 0x30, bitSize: 0x10(0x2 Byte(s))
        short reproductionStreak;
        // offset: 0x40, bitSize: 0x10(0x2 Byte(s))
        int:16 hungryDmg;
        // offset: 0x50, bitSize: 0x10(0x2 Byte(s))
        short charged;
        // offset: 0x60, bitSize: 0x10(0x2 Byte(s))
        short killstreakCharge;
        // offset: 0x70, bitSize: 0x10(0x2 Byte(s))
        short winGamesTop3;
        // offset: 0x80, bitSize: 0x10(0x2 Byte(s))
        short winGamesCharge;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short bonusTime;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short frontEndTeenPick;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        int:16 boredDmg;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short nukeCharge;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short objectiveScoreCharge;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short apachePoints;
        // offset: 0xf0, bitSize: 0x10(0x2 Byte(s))
        short damage;
        // offset: 0x100, bitSize: 0x10(0x2 Byte(s))
        short topKillstreakCharge;
        // offset: 0x110, bitSize: 0x10(0x2 Byte(s))
        short orcaPoints;
        // offset: 0x120, bitSize: 0x10(0x2 Byte(s))
        short growthTime;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short plantsCharge;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        int:16 unrulyDmg;
        // offset: 0x150, bitSize: 0x10(0x2 Byte(s))
        short executionsCharge;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        short dragonPoints;
        // offset: 0x170, bitSize: 0x20(0x4 Byte(s))
        int lastUpdateTime;
    };

    // bitSize: 0x200, members: 1
    struct PetWatchGoData {
        // offset: 0x0, bitSize: 0x200(0x40 Byte(s)), array:0x20(hti:0xffff)
        short growth[32];
    };

    // bitSize: 0x30, members: 4
    struct Death {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte deathPos[2];
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte attacker;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte player;
        // offset: 0x20, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        byte attackerPos[2];
    };

    // bitSize: 0x2e8, members: 23
    struct Player {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        short rank;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        Team team;
        // offset: 0x18, bitSize: 0x10(0x2 Byte(s))
        short kills;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        int score;
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        string(4) clanTag;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int timeplayed;
        // offset: 0x88, bitSize: 0x8(0x1 Byte(s))
        ClientPlatform platform;
        // offset: 0x90, bitSize: 0x10(0x2 Byte(s))
        short extrascore0;
        // offset: 0xa0, bitSize: 0x10(0x2 Byte(s))
        short extrascore1;
        // offset: 0xb0, bitSize: 0x10(0x2 Byte(s))
        short extrascore2;
        // offset: 0xc0, bitSize: 0x10(0x2 Byte(s))
        short extrascore3;
        // offset: 0xd0, bitSize: 0x10(0x2 Byte(s))
        short extrascore4;
        // offset: 0xe0, bitSize: 0x10(0x2 Byte(s))
        short extrascore5;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int xuidHigh;
        // offset: 0x110, bitSize: 0x20(0x4 Byte(s))
        int xuidLow;
        // offset: 0x130, bitSize: 0x10(0x2 Byte(s))
        short deaths;
        // offset: 0x140, bitSize: 0x10(0x2 Byte(s))
        short prestige;
        // offset: 0x150, bitSize: 0x8(0x1 Byte(s))
        Factions faction;
        // offset: 0x158, bitSize: 0x10(0x2 Byte(s))
        short assists;
        // offset: 0x168, bitSize: 0x170(0x2e Byte(s))
        string(46) username;
        // offset: 0x2d8, bitSize: 0x8(0x1 Byte(s))
        byte uniqueClientId;
        // offset: 0x2e0, bitSize: 0x1
        bool isBot;
    };

    // idx 0x0 members: 0x50 type: 0
    enum BaseGameMode {
        aon, // 0x0
        dm, // 0x1
        war, // 0x2
        sd, // 0x3
        sab, // 0x4
        dom, // 0x5
        koth, // 0x6
        ctf, // 0x7
        dd, // 0x8
        conf, // 0x9
        control, // 0xa
        tdef, // 0xb
        siege, // 0xc
        grnd, // 0xd
        tjugg, // 0xe
        jugg, // 0xf
        gun, // 0x10
        infect, // 0x11
        oic, // 0x12
        mugger, // 0x13
        blitz, // 0x14
        sr, // 0x15
        grind, // 0x16
        sotf, // 0x17
        sotf_ffa, // 0x18
        assault, // 0x19
        aliens, // 0x1a
        cp_survival, // 0x1b
        cp_wave_sv, // 0x1c
        cp_specops, // 0x1d
        zombie, // 0x1e
        escape, // 0x1f
        cp_pvpve, // 0x20
        cp_strike, // 0x21
        cp_trials, // 0x22
        ball, // 0x23
        front, // 0x24
        arena, // 0x25
        cmd, // 0x26
        br, // 0x27
        br_dmz, // 0x28
        cyber, // 0x29
        rush, // 0x2a
        esc, // 0x2b
        vip, // 0x2c
        btm, // 0x2d
        rugby, // 0x2e
        arm, // 0x2f
        mtmc, // 0x30
        snatch, // 0x31
        hq, // 0x32
        defcon, // 0x33
        pill, // 0x34
        brm, // 0x35
        hvt, // 0x36
        trial, // 0x37
        brtdm, // 0x38
        br_risk, // 0x39
        incursion, // 0x3a
        missions, // 0x3b
        cqc, // 0x3c
        br_plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        gwai, // 0x44
        bounty, // 0x45
        zm_rb, // 0x46
        gwtdm, // 0x47
        ob, // 0x48
        br_resurgence, // 0x49
        benchmark, // 0x4a
        ballmode, // 0x4b
        brtdm_mgl, // 0x4c
        conflict, // 0x4d
        havoc, // 0x4e
        bigctf // 0x4f
    };

    // idx 0x1 members: 0xb8 type: 0
    enum Awards {
        none, // 0x0
        firstblood, // 0x1
        headshot, // 0x2
        avenger, // 0x3
        assistedsuicide, // 0x4
        buzzkill, // 0x5
        comeback, // 0x6
        knifethrow, // 0x7
        longshot, // 0x8
        pointblank, // 0x9
        revenge, // 0xa
        double, // 0xb
        triple, // 0xc
        four, // 0xd
        five, // 0xe
        six, // 0xf
        seven, // 0x10
        eight, // 0x11
        multi, // 0x12
        defender, // 0x13
        posthumous, // 0x14
        first_place_kill, // 0x15
        one_shot_kill, // 0x16
        kill_juggernaut, // 0x17
        mo_money, // 0x18
        gun_butt, // 0x19
        grenade_double, // 0x1a
        fist_kill, // 0x1b
        mantle_kill, // 0x1c
        throwback_kill, // 0x1d
        slide_kill, // 0x1e
        stunned_kill, // 0x1f
        knife_bounce, // 0x20
        backstab, // 0x21
        backfire, // 0x22
        quad_feed, // 0x23
        save_teammate, // 0x24
        one_shot_two_kills, // 0x25
        explosive_stick, // 0x26
        launcher_direct_hit, // 0x27
        throwingknife_kill, // 0x28
        hack_package_kill, // 0x29
        kill_wallrunner, // 0x2a
        kill_jumper, // 0x2b
        wallrun_kill, // 0x2c
        air_kill, // 0x2d
        low_health_kill, // 0x2e
        air_to_air_kill, // 0x2f
        item_impact, // 0x30
        streak_5, // 0x31
        streak_10, // 0x32
        streak_15, // 0x33
        streak_20, // 0x34
        streak_25, // 0x35
        streak_30, // 0x36
        streak_max, // 0x37
        ss_kill_manual_turret, // 0x38
        ss_kill_toma_strike, // 0x39
        ss_kill_multi_airstrike, // 0x3a
        ss_kill_cruise_predator, // 0x3b
        ss_kill_pac_sentry, // 0x3c
        ss_kill_chopper_gunner, // 0x3d
        ss_kill_gunship, // 0x3e
        ss_kill_sentry_gun, // 0x3f
        ss_kill_precision_airstrike, // 0x40
        ss_kill_jackal, // 0x41
        ss_kill_trinity, // 0x42
        ss_kill_fuel_airstrike, // 0x43
        ss_kill_chopper_support, // 0x44
        ss_kill_white_phosphorus, // 0x45
        ss_kill_hover_jet, // 0x46
        ss_kill_death_switch, // 0x47
        ss_kill_bradley, // 0x48
        ss_kill_juggernaut, // 0x49
        ss_kill_assault_drone, // 0x4a
        ss_kill_auto_drone, // 0x4b
        ss_use_airdrop, // 0x4c
        ss_use_enemy_airdrop, // 0x4d
        kill_ss_radar_drone_escort, // 0x4e
        kill_ss_radar_drone_recon, // 0x4f
        kill_ss_radar_drone_overwatch, // 0x50
        kill_ss_scrambler_drone_escort, // 0x51
        kill_ss_scrambler_drone_guard, // 0x52
        kill_ss_support_box, // 0x53
        kill_ss_manual_turret, // 0x54
        kill_ss_toma_strike, // 0x55
        kill_ss_multi_airstrike, // 0x56
        kill_ss_cruise_predator, // 0x57
        kill_ss_pac_sentry, // 0x58
        kill_ss_chopper_gunner, // 0x59
        kill_ss_gunship, // 0x5a
        kill_ss_sentry_gun, // 0x5b
        kill_ss_jackal, // 0x5c
        kill_ss_airdrop, // 0x5d
        kill_ss_uav, // 0x5e
        kill_ss_counter_uav, // 0x5f
        kill_ss_directional_uav, // 0x60
        kill_ss_drone_hive, // 0x61
        kill_ss_fuel_airstrike, // 0x62
        kill_ss_chopper_support, // 0x63
        kill_ss_hover_jet, // 0x64
        kill_ss_emp_drone, // 0x65
        kill_ss_bradley, // 0x66
        kill_ss_assault_drone, // 0x67
        kill_ss_auto_drone, // 0x68
        kill_ss_airdrop_escort, // 0x69
        super_kill_steeldragon, // 0x6a
        super_kill_amplify, // 0x6b
        super_kill_overdrive, // 0x6c
        super_kill_claw, // 0x6d
        super_kill_armorup, // 0x6e
        super_kill_bull_charge, // 0x6f
        super_kill_armmgs, // 0x70
        super_kill_reaper, // 0x71
        super_kill_rewind, // 0x72
        super_kill_atomizer, // 0x73
        super_kill_phaseshift, // 0x74
        super_kill_teleport, // 0x75
        super_kill_blackholegun, // 0x76
        super_kill_supertrophy, // 0x77
        super_kill_microturret, // 0x78
        super_kill_penetrationrailgun, // 0x79
        super_kill_visionpulse, // 0x7a
        super_kill_invisible, // 0x7b
        super_shutdown_steeldragon, // 0x7c
        super_shutdown_amplify, // 0x7d
        super_shutdown_overdrive, // 0x7e
        super_shutdown_claw, // 0x7f
        super_shutdown_armorup, // 0x80
        super_shutdown_bull_charge, // 0x81
        super_shutdown_armmgs, // 0x82
        super_shutdown_reaper, // 0x83
        super_shutdown_rewind, // 0x84
        super_shutdown_atomizer, // 0x85
        super_shutdown_phaseshift, // 0x86
        super_shutdown_teleport, // 0x87
        super_shutdown_blackholegun, // 0x88
        super_shutdown_supertrophy, // 0x89
        super_shutdown_microturret, // 0x8a
        super_shutdown_penetrationrailgun, // 0x8b
        super_shutdown_visionpulse, // 0x8c
        super_shutdown_invisible, // 0x8d
        mode_ctf_cap, // 0x8e
        mode_ctf_kill_carrier, // 0x8f
        mode_ctf_kill_with_flag, // 0x90
        mode_ctf_close_return, // 0x91
        mode_ctf_nope, // 0x92
        mode_x_last_alive, // 0x93
        mode_x_eliminate, // 0x94
        mode_sd_last_defuse, // 0x95
        mode_sd_defuse, // 0x96
        mode_sd_detonate, // 0x97
        mode_sd_plant_save, // 0x98
        mode_sd_defuse_save, // 0x99
        mode_x_clear, // 0x9a
        mode_hp_secure, // 0x9b
        mode_hp_secure_reduced, // 0x9c
        mode_hp_assault, // 0x9d
        mode_hp_quick_cap, // 0x9e
        mode_kc_own_tags, // 0x9f
        mode_kc_3_tags, // 0xa0
        mode_dom_secure_b, // 0xa1
        mode_dom_secure_neutral, // 0xa2
        mode_dom_assault, // 0xa3
        mode_dom_secure_assist, // 0xa4
        mode_dom_secure, // 0xa5
        mode_dom_neutralized, // 0xa6
        mode_dom_neutralized_cap, // 0xa7
        mode_arm_secure_mid, // 0xa8
        mode_arm_secure_outer_mid, // 0xa9
        mode_arm_secure_outer, // 0xaa
        mode_cyber_kill_with_emp, // 0xab
        mode_cyber_kill_carrier, // 0xac
        mode_x_assault, // 0xad
        mode_x_defend, // 0xae
        mode_x_wipeout, // 0xaf
        mode_siege_secure, // 0xb0
        mode_gun_quick_kill, // 0xb1
        mode_gun_melee_1st_place, // 0xb2
        mode_gun_melee, // 0xb3
        match_complete, // 0xb4
        match_complete_win, // 0xb5
        rock_paper_scissors_win, // 0xb6
        simultaneous_kill // 0xb7
    };

    // idx 0x2 members: 0x1 type: 0
    enum Challenge {
        ch_none // 0x0
    };

    // idx 0x3 members: 0x2 type: 0
    enum CharacterArchetype {
        none, // 0x0
        archetype_assault // 0x1
    };

    // idx 0x4 members: 0x26 type: 0
    enum Killstreak {
        none, // 0x0
        uav, // 0x1
        airdrop, // 0x2
        precision_airstrike, // 0x3
        directional_uav, // 0x4
        nuke, // 0x5
        bradley, // 0x6
        radar_drone_recon, // 0x7
        radar_drone_overwatch, // 0x8
        scrambler_drone_guard, // 0x9
        support_box, // 0xa
        manual_turret, // 0xb
        toma_strike, // 0xc
        multi_airstrike, // 0xd
        cruise_predator, // 0xe
        pac_sentry, // 0xf
        chopper_gunner, // 0x10
        gunship, // 0x11
        tacops_beacon_mp, // 0x12
        fuel_airstrike, // 0x13
        chopper_support, // 0x14
        juggernaut, // 0x15
        sentry_gun, // 0x16
        white_phosphorus, // 0x17
        hover_jet, // 0x18
        death_switch, // 0x19
        airdrop_multiple, // 0x1a
        nuke_select_location, // 0x1b
        ammo_drop, // 0x1c
        specialist_perk_1, // 0x1d
        specialist_perk_2, // 0x1e
        specialist_perk_3, // 0x1f
        specialist_perk_bonus, // 0x20
        assault_drone, // 0x21
        auto_drone, // 0x22
        cluster_spike, // 0x23
        airdrop_escort, // 0x24
        nuke_multi // 0x25
    };

    // idx 0x5 members: 0x93 type: 0
    enum Perk {
        specialty_null, // 0x0
        specialty_expanded_minimap, // 0x1
        specialty_blindeye, // 0x2
        specialty_blastshield, // 0x3
        specialty_dexterity, // 0x4
        specialty_overclock, // 0x5
        specialty_boom, // 0x6
        specialty_gpsjammer, // 0x7
        specialty_ghost, // 0x8
        specialty_momentum, // 0x9
        specialty_hardline, // 0xa
        specialty_coldblooded, // 0xb
        specialty_empimmune, // 0xc
        specialty_tracker, // 0xd
        specialty_tracker_jammer, // 0xe
        specialty_scavenger, // 0xf
        specialty_sprintfire, // 0x10
        specialty_bullet_outline, // 0x11
        specialty_selectivehearing, // 0x12
        specialty_improvedmelee, // 0x13
        specialty_hard_shell, // 0x14
        specialty_engineer, // 0x15
        specialty_quieter, // 0x16
        specialty_bulletdamage, // 0x17
        specialty_armorvest, // 0x18
        specialty_twoprimaries, // 0x19
        specialty_solobuddyboost, // 0x1a
        specialty_bling, // 0x1b
        specialty_underkill, // 0x1c
        specialty_third_person, // 0x1d
        specialty_bulletsuppress, // 0x1e
        specialty_extraammo, // 0x1f
        specialty_fastsprintrecovery, // 0x20
        specialty_fastreload, // 0x21
        specialty_incog, // 0x22
        specialty_detectexplosive, // 0x23
        specialty_stun_resistance, // 0x24
        specialty_chain_reaction, // 0x25
        specialty_cloak_aerial, // 0x26
        specialty_spawn_radar, // 0x27
        specialty_thief, // 0x28
        specialty_extendedmelee, // 0x29
        specialty_meleekill, // 0x2a
        specialty_afterburner, // 0x2b
        specialty_paint, // 0x2c
        specialty_viewkickoverride, // 0x2d
        specialty_undying, // 0x2e
        specialty_teleport, // 0x2f
        specialty_activereload, // 0x30
        specialty_thruster, // 0x31
        specialty_sixth_sense, // 0x32
        specialty_mark_targets, // 0x33
        specialty_rush, // 0x34
        specialty_superpack, // 0x35
        specialty_enhanced_sixth_sense, // 0x36
        specialty_dodge, // 0x37
        specialty_ground_pound, // 0x38
        specialty_personal_trophy, // 0x39
        specialty_regenfaster, // 0x3a
        specialty_equipment_ping, // 0x3b
        specialty_rugged_eqp, // 0x3c
        specialty_gung_ho, // 0x3d
        specialty_man_at_arms, // 0x3e
        specialty_cloak, // 0x3f
        specialty_wall_lock, // 0x40
        specialty_comexp, // 0x41
        specialty_scavenger_eqp, // 0x42
        specialty_ftlslide, // 0x43
        specialty_support_killstreaks, // 0x44
        specialty_marksman, // 0x45
        specialty_ads_awareness, // 0x46
        specialty_rearguard, // 0x47
        specialty_ballcarrier, // 0x48
        specialty_powercell, // 0x49
        specialty_improved_prone, // 0x4a
        specialty_spawnview, // 0x4b
        specialty_phaseslash, // 0x4c
        specialty_phase_fall, // 0x4d
        specialty_headgear, // 0x4e
        specialty_disruptor_punch, // 0x4f
        specialty_dodge_defense, // 0x50
        specialty_dodge_wave, // 0x51
        specialty_extra_dodge, // 0x52
        specialty_extend_dodge, // 0x53
        specialty_blast_suppressor, // 0x54
        specialty_hover, // 0x55
        specialty_spawncloak, // 0x56
        specialty_phaseslash_rephase, // 0x57
        specialty_battleslide_offense, // 0x58
        specialty_ground_pound_shield, // 0x59
        specialty_ground_pound_shock, // 0x5a
        specialty_phase_slide, // 0x5b
        specialty_tele_slide, // 0x5c
        specialty_battleslide, // 0x5d
        specialty_camo_elite, // 0x5e
        specialty_batterypack, // 0x5f
        specialty_scorestreakpack, // 0x60
        specialty_medic, // 0x61
        specialty_can_be_revived, // 0x62
        specialty_kill_report, // 0x63
        specialty_ads_mark_target, // 0x64
        specialty_healer, // 0x65
        specialty_hunter, // 0x66
        specialty_helmet, // 0x67
        specialty_breacher, // 0x68
        specialty_ladder, // 0x69
        specialty_revive_use_weapon, // 0x6a
        specialty_regen_delay_reduced, // 0x6b
        specialty_classic_laststand, // 0x6c
        specialty_location_marking, // 0x6d
        specialty_remote_defuse, // 0x6e
        specialty_faster_field_upgrade, // 0x6f
        specialty_improved_target_mark, // 0x70
        specialty_door_breach, // 0x71
        specialty_door_sense, // 0x72
        specialty_strategist, // 0x73
        specialty_munitions_2, // 0x74
        specialty_surveillance, // 0x75
        specialty_guerrilla, // 0x76
        specialty_tune_up, // 0x77
        specialty_restock, // 0x78
        specialty_hustle, // 0x79
        specialty_tactical_recon, // 0x7a
        specialty_tac_resist, // 0x7b
        specialty_heavy_metal, // 0x7c
        specialty_scavenger_plus, // 0x7d
        specialty_extra_shrapnel, // 0x7e
        specialty_covert_ops, // 0x7f
        specialty_eod, // 0x80
        specialty_huntmaster, // 0x81
        specialty_graverobber, // 0x82
        specialty_mercenary, // 0x83
        specialty_warhead, // 0x84
        specialty_sonar, // 0x85
        specialty_quick_fix, // 0x86
        specialty_headhunter, // 0x87
        specialty_armored, // 0x88
        specialty_overcharge_field_upgrade, // 0x89
        specialty_survivor, // 0x8a
        specialty_overwatch, // 0x8b
        specialty_grenade_expert, // 0x8c
        specialty_focus, // 0x8d
        specialty_extra_tactical, // 0x8e
        specialty_pc_medic, // 0x8f
        specialty_pc_comms, // 0x90
        specialty_pc_stealth, // 0x91
        specialty_pc_tempered // 0x92
    };

    // idx 0x6 members: 0x52 type: 0
    enum Power {
        none, // 0x0
        power_mobileRadar, // 0x1
        power_sensorGrenade, // 0x2
        power_bioSpike, // 0x3
        power_gasGrenade, // 0x4
        power_blinkKnife, // 0x5
        power_clusterGrenade, // 0x6
        power_siegeMode, // 0x7
        power_playerTrophySystem, // 0x8
        power_bulletstorm, // 0x9
        power_stickyBomb, // 0xa
        power_proxyBomb, // 0xb
        power_bouncingBetty, // 0xc
        power_smokeGrenade, // 0xd
        power_blackoutGrenade, // 0xe
        power_lifeLink, // 0xf
        power_dash, // 0x10
        power_opticWave, // 0x11
        power_periphVis, // 0x12
        power_phaseSplit, // 0x13
        power_discMarker, // 0x14
        power_caseBomb, // 0x15
        power_adrenalineMist, // 0x16
        power_engineerDrone, // 0x17
        power_semtex, // 0x18
        power_overCharge, // 0x19
        power_thermobaric, // 0x1a
        power_domeshield, // 0x1b
        power_smokeWall, // 0x1c
        power_blackholeGrenade, // 0x1d
        power_speedStrip, // 0x1e
        power_comlink, // 0x1f
        power_sonicPulse, // 0x20
        power_empGrenade, // 0x21
        power_shardBall, // 0x22
        power_splashGrenade, // 0x23
        power_forcePush, // 0x24
        power_c4, // 0x25
        power_teleReap, // 0x26
        power_throwingReap, // 0x27
        power_portalGenerator, // 0x28
        power_transponder, // 0x29
        power_blackholeWarpGrenade, // 0x2a
        power_sonicSensor, // 0x2b
        power_headgear, // 0x2c
        power_barrier, // 0x2d
        power_battery, // 0x2e
        power_mortarMount, // 0x2f
        power_stickyMine, // 0x30
        power_tripMine, // 0x31
        power_adrenaline, // 0x32
        power_multiVisor, // 0x33
        power_trophy, // 0x34
        power_stealthMode, // 0x35
        power_disruptor, // 0x36
        power_pulseGrenade, // 0x37
        power_niagara, // 0x38
        power_siphonKnife, // 0x39
        power_arcGrenade, // 0x3a
        power_ammoBox, // 0x3b
        power_portalGrenade, // 0x3c
        power_virusGrenade, // 0x3d
        power_fearGrenade, // 0x3e
        power_distortionField, // 0x3f
        power_attackDrone, // 0x40
        power_frag, // 0x41
        power_cryoMine, // 0x42
        power_wristRocket, // 0x43
        power_explodingDrone, // 0x44
        power_claymore, // 0x45
        power_coneFlash, // 0x46
        power_blackhat, // 0x47
        power_deployableCover, // 0x48
        power_spiderGrenade, // 0x49
        power_hackKnife, // 0x4a
        power_concussionGrenade, // 0x4b
        power_splitGrenade, // 0x4c
        power_implosionGrenade, // 0x4d
        power_throwingKnife, // 0x4e
        power_tacInsert, // 0x4f
        power_flash, // 0x50
        power_helmet // 0x51
    };

    // idx 0x7 members: 0x23 type: 0
    enum Equipment {
        none, // 0x0
        equip_frag, // 0x1
        equip_semtex, // 0x2
        equip_c4, // 0x3
        equip_throwing_knife, // 0x4
        equip_claymore, // 0x5
        equip_molotov, // 0x6
        equip_thermite, // 0x7
        equip_at_mine, // 0x8
        equip_pop_rocket, // 0x9
        equip_helmet, // 0xa
        equip_flash, // 0xb
        equip_smoke, // 0xc
        equip_concussion, // 0xd
        equip_adrenaline, // 0xe
        equip_trophy, // 0xf
        equip_snapshot_grenade, // 0x10
        equip_decoy, // 0x11
        equip_tac_cover, // 0x12
        equip_emp, // 0x13
        equip_nvg, // 0x14
        equip_tac_insert, // 0x15
        equip_gas_grenade, // 0x16
        equip_hb_sensor, // 0x17
        equip_rock, // 0x18
        equip_throwing_knife_fire, // 0x19
        equip_geigercounter, // 0x1a
        equip_deployed_decoy, // 0x1b
        equip_shockstick, // 0x1c
        equip_bunkerbuster, // 0x1d
        equip_binoculars, // 0x1e
        equip_iodine_pills, // 0x1f
        equip_shuriken, // 0x20
        equip_throwstar, // 0x21
        equip_thermal_phone // 0x22
    };

    // idx 0x8 members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0x9 members: 0xa type: 0
    enum Factions {
        none, // 0x0
        USMC, // 0x1
        RUSF, // 0x2
        SAS, // 0x3
        SABF, // 0x4
        FIVE, // 0x5
        SIX, // 0x6
        ZVIR, // 0x7
        ICORPS, // 0x8
        GRP9 // 0x9
    };

    // idx 0xa members: 0xcb type: 0
    enum Team {
        none, // 0x0
        spectator, // 0x1
        axis, // 0x2
        allies, // 0x3
        team_three, // 0x4
        team_four, // 0x5
        team_five, // 0x6
        team_six, // 0x7
        team_seven, // 0x8
        team_eight, // 0x9
        team_nine, // 0xa
        team_ten, // 0xb
        team_eleven, // 0xc
        team_twelve, // 0xd
        team_thirteen, // 0xe
        team_fourteen, // 0xf
        team_fifteen, // 0x10
        team_sixteen, // 0x11
        team_seventeen, // 0x12
        team_eighteen, // 0x13
        team_nineteen, // 0x14
        team_twenty, // 0x15
        team_twenty_one, // 0x16
        team_twenty_two, // 0x17
        team_twenty_three, // 0x18
        team_twenty_four, // 0x19
        team_twenty_five, // 0x1a
        team_twenty_six, // 0x1b
        team_twenty_seven, // 0x1c
        team_twenty_eight, // 0x1d
        team_twenty_nine, // 0x1e
        team_thirty, // 0x1f
        team_thirty_one, // 0x20
        team_thirty_two, // 0x21
        team_thirty_three, // 0x22
        team_thirty_four, // 0x23
        team_thirty_five, // 0x24
        team_thirty_six, // 0x25
        team_thirty_seven, // 0x26
        team_thirty_eight, // 0x27
        team_thirty_nine, // 0x28
        team_forty, // 0x29
        team_forty_one, // 0x2a
        team_forty_two, // 0x2b
        team_forty_three, // 0x2c
        team_forty_four, // 0x2d
        team_forty_five, // 0x2e
        team_forty_six, // 0x2f
        team_forty_seven, // 0x30
        team_forty_eight, // 0x31
        team_forty_nine, // 0x32
        team_fifty, // 0x33
        team_fifty_one, // 0x34
        team_fifty_two, // 0x35
        team_fifty_three, // 0x36
        team_fifty_four, // 0x37
        team_fifty_five, // 0x38
        team_fifty_six, // 0x39
        team_fifty_seven, // 0x3a
        team_fifty_eight, // 0x3b
        team_fifty_nine, // 0x3c
        team_sixty, // 0x3d
        team_sixty_one, // 0x3e
        team_sixty_two, // 0x3f
        team_sixty_three, // 0x40
        team_sixty_four, // 0x41
        team_sixty_five, // 0x42
        team_sixty_six, // 0x43
        team_sixty_seven, // 0x44
        team_sixty_eight, // 0x45
        team_sixty_nine, // 0x46
        team_seventy, // 0x47
        team_seventy_one, // 0x48
        team_seventy_two, // 0x49
        team_seventy_three, // 0x4a
        team_seventy_four, // 0x4b
        team_seventy_five, // 0x4c
        team_seventy_six, // 0x4d
        team_seventy_seven, // 0x4e
        team_seventy_eight, // 0x4f
        team_seventy_nine, // 0x50
        team_eighty, // 0x51
        team_eighty_one, // 0x52
        team_eighty_two, // 0x53
        team_eighty_three, // 0x54
        team_eighty_four, // 0x55
        team_eighty_five, // 0x56
        team_eighty_six, // 0x57
        team_eighty_seven, // 0x58
        team_eighty_eight, // 0x59
        team_eighty_nine, // 0x5a
        team_ninety, // 0x5b
        team_ninety_one, // 0x5c
        team_ninety_two, // 0x5d
        team_ninety_three, // 0x5e
        team_ninety_four, // 0x5f
        team_ninety_five, // 0x60
        team_ninety_six, // 0x61
        team_ninety_seven, // 0x62
        team_ninety_eight, // 0x63
        team_ninety_nine, // 0x64
        team_hundred, // 0x65
        team_hundred_one, // 0x66
        team_hundred_two, // 0x67
        team_hundred_three, // 0x68
        team_hundred_four, // 0x69
        team_hundred_five, // 0x6a
        team_hundred_six, // 0x6b
        team_hundred_seven, // 0x6c
        team_hundred_eight, // 0x6d
        team_hundred_nine, // 0x6e
        team_hundred_ten, // 0x6f
        team_hundred_eleven, // 0x70
        team_hundred_twelve, // 0x71
        team_hundred_thirteen, // 0x72
        team_hundred_fourteen, // 0x73
        team_hundred_fifteen, // 0x74
        team_hundred_sixteen, // 0x75
        team_hundred_seventeen, // 0x76
        team_hundred_eightteen, // 0x77
        team_hundred_nineteen, // 0x78
        team_hundred_twenty, // 0x79
        team_hundred_twenty_one, // 0x7a
        team_hundred_twenty_two, // 0x7b
        team_hundred_twenty_three, // 0x7c
        team_hundred_twenty_four, // 0x7d
        team_hundred_twenty_five, // 0x7e
        team_hundred_twenty_six, // 0x7f
        team_hundred_twenty_seven, // 0x80
        team_hundred_twenty_eight, // 0x81
        team_hundred_twenty_nine, // 0x82
        team_hundred_thirty, // 0x83
        team_hundred_thirty_one, // 0x84
        team_hundred_thirty_two, // 0x85
        team_hundred_thirty_three, // 0x86
        team_hundred_thirty_four, // 0x87
        team_hundred_thirty_five, // 0x88
        team_hundred_thirty_six, // 0x89
        team_hundred_thirty_seven, // 0x8a
        team_hundred_thirty_eight, // 0x8b
        team_hundred_thirty_nine, // 0x8c
        team_hundred_forty, // 0x8d
        team_hundred_forty_one, // 0x8e
        team_hundred_forty_two, // 0x8f
        team_hundred_forty_three, // 0x90
        team_hundred_forty_four, // 0x91
        team_hundred_forty_five, // 0x92
        team_hundred_forty_six, // 0x93
        team_hundred_forty_seven, // 0x94
        team_hundred_forty_eight, // 0x95
        team_hundred_forty_nine, // 0x96
        team_hundred_fifty, // 0x97
        team_hundred_fifty_one, // 0x98
        team_hundred_fifty_two, // 0x99
        team_hundred_fifty_three, // 0x9a
        team_hundred_fifty_four, // 0x9b
        team_hundred_fifty_five, // 0x9c
        team_hundred_fifty_six, // 0x9d
        team_hundred_fifty_seven, // 0x9e
        team_hundred_fifty_eight, // 0x9f
        team_hundred_fifty_nine, // 0xa0
        team_hundred_sixty, // 0xa1
        team_hundred_sixty_one, // 0xa2
        team_hundred_sixty_two, // 0xa3
        team_hundred_sixty_three, // 0xa4
        team_hundred_sixty_four, // 0xa5
        team_hundred_sixty_five, // 0xa6
        team_hundred_sixty_six, // 0xa7
        team_hundred_sixty_seven, // 0xa8
        team_hundred_sixty_eight, // 0xa9
        team_hundred_sixty_nine, // 0xaa
        team_hundred_seventy, // 0xab
        team_hundred_seventy_one, // 0xac
        team_hundred_seventy_two, // 0xad
        team_hundred_seventy_three, // 0xae
        team_hundred_seventy_four, // 0xaf
        team_hundred_seventy_five, // 0xb0
        team_hundred_seventy_six, // 0xb1
        team_hundred_seventy_seven, // 0xb2
        team_hundred_seventy_eight, // 0xb3
        team_hundred_seventy_nine, // 0xb4
        team_hundred_eighty, // 0xb5
        team_hundred_eighty_one, // 0xb6
        team_hundred_eighty_two, // 0xb7
        team_hundred_eighty_three, // 0xb8
        team_hundred_eighty_four, // 0xb9
        team_hundred_eighty_five, // 0xba
        team_hundred_eighty_six, // 0xbb
        team_hundred_eighty_seven, // 0xbc
        team_hundred_eighty_eight, // 0xbd
        team_hundred_eighty_nine, // 0xbe
        team_hundred_ninety, // 0xbf
        team_hundred_ninety_one, // 0xc0
        team_hundred_ninety_two, // 0xc1
        team_hundred_ninety_three, // 0xc2
        team_hundred_ninety_four, // 0xc3
        team_hundred_ninety_five, // 0xc4
        team_hundred_ninety_six, // 0xc5
        team_hundred_ninety_seven, // 0xc6
        team_hundred_ninety_eight, // 0xc7
        team_hundred_ninety_nine, // 0xc8
        team_two_hundred, // 0xc9
        codcaster // 0xca
    };

    // idx 0xb members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ec0, members: 15

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x20(0x4 Byte(s))
    float alliesTTB;
    // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
    int alliesKills;
    // offset: 0x140, bitSize: 0x20(0x4 Byte(s))
    int alliesScore;
    // offset: 0x160, bitSize: 0x20(0x4 Byte(s))
    int axisScore;
    // offset: 0x180, bitSize: 0x8(0x1 Byte(s))
    byte scoreboardPlayerCount;
    // offset: 0x188, bitSize: 0x1f40(0x3e8 Byte(s)), array:0x3e8(hti:0xffff)
    byte scoreboards[1000];
    // offset: 0x20c8, bitSize: 0x20(0x4 Byte(s))
    int maxPlayerCount;
    // offset: 0x20e8, bitSize: 0x3840(0x708 Byte(s)), array:0x12c(hti:0xffff)
    Death deaths[300];
    // offset: 0x5928, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5968, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ea8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29eb8, bitSize: 0x1
    bool isPublicMatch;
};

