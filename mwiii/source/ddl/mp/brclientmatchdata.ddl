// file .... ddl\mp\brclientmatchdata.ddl

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_670768e165119f92

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x6a type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high, // 0x67
        warrior, // 0x68
        slam // 0x69
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3f type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        missile_drone, // 0x35
        juggernaut_mutant, // 0x36
        napalm_strike, // 0x37
        missile_turret, // 0x38
        rcxd, // 0x39
        radar_ping, // 0x3a
        gas_strike, // 0x3b
        hellstorm_missile, // 0x3c
        valkyrie_rocket, // 0x3d
        air_patrol // 0x3e
    };

    // idx 0x5 members: 0xfa type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_infantry_vest_ranked, // 0xd2
        specialty_grenadier_vest, // 0xd3
        specialty_scout_vest, // 0xd4
        specialty_overkill_vest, // 0xd5
        specialty_tac_vest, // 0xd6
        specialty_gunner_vest, // 0xd7
        specialty_fast_reload, // 0xd8
        specialty_marksman_vest, // 0xd9
        specialty_ninja_vest, // 0xda
        specialty_dauntless_boots, // 0xdb
        specialty_pistol_vest, // 0xdc
        specialty_ninja_gloves, // 0xdd
        specialty_combined_arms_vest, // 0xde
        specialty_super_strength, // 0xdf
        specialty_super_speed, // 0xe0
        specialty_durability, // 0xe1
        specialty_adrenaline, // 0xe2
        specialty_outlander, // 0xe3
        specialty_shroud, // 0xe4
        specialty_combat_scout, // 0xe5
        specialty_mechanic, // 0xe6
        specialty_contract_payout, // 0xe7
        specialty_lightweight_br, // 0xe8
        specialty_restock_br, // 0xe9
        specialty_shrapnel_br, // 0xea
        specialty_treadless_boots_br, // 0xeb
        specialty_tac_pads_br, // 0xec
        specialty_tac_resist_br, // 0xed
        specialty_silicon_gloves_br, // 0xee
        specialty_scavenger_br, // 0xef
        specialty_survivor_br, // 0xf0
        specialty_tempered_br, // 0xf1
        specialty_mutation_gas_cloud, // 0xf2
        specialty_self_tracked, // 0xf3
        specialty_specialist_bonus, // 0xf4
        specialty_mutation_mode_bonus_01, // 0xf5
        specialty_mutation_mode_bonus_02, // 0xf6
        specialty_mutation_mode_bonus_03, // 0xf7
        specialty_mutation_mode_bonus_04, // 0xf8
        specialty_mutation_mode_bonus_05 // 0xf9
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x4e type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32, // 0x43
        equip_redeploy_drone_beacon, // 0x44
        equip_mutant_emp_ball, // 0x45
        equip_mutant_ability_4, // 0x46
        equip_mutant_ability_5, // 0x47
        equip_mutant_ability_6, // 0x48
        equip_mutant_ability_7, // 0x49
        equip_mutant_sludge_ball, // 0x4a
        equip_emp_grenade, // 0x4b
        equip_mutant_ability_1, // 0x4c
        equip_mutant_ability_10 // 0x4d
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0xf type: 0
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

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_19fcf9f51a8c675f

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x65 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun // 0x64
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3a type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        napalm_strike, // 0x32
        missile_turret, // 0x33
        rcxd, // 0x34
        radar_ping, // 0x35
        gas_strike, // 0x36
        hellstorm_missile, // 0x37
        valkyrie_rocket, // 0x38
        air_patrol // 0x39
    };

    // idx 0x5 members: 0xe6 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_adrenaline, // 0xd7
        specialty_outlander, // 0xd8
        specialty_shroud, // 0xd9
        specialty_combat_scout, // 0xda
        specialty_mechanic, // 0xdb
        specialty_contract_payout, // 0xdc
        specialty_lightweight_br, // 0xdd
        specialty_restock_br, // 0xde
        specialty_shrapnel_br, // 0xdf
        specialty_treadless_boots_br, // 0xe0
        specialty_tac_pads_br, // 0xe1
        specialty_tac_resist_br, // 0xe2
        specialty_silicon_gloves_br, // 0xe3
        specialty_scavenger_br, // 0xe4
        specialty_survivor_br // 0xe5
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3c type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball // 0x3b
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
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
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_d963aa5578acdce4

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x65 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun // 0x64
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3a type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        napalm_strike, // 0x32
        missile_turret, // 0x33
        rcxd, // 0x34
        radar_ping, // 0x35
        gas_strike, // 0x36
        hellstorm_missile, // 0x37
        valkyrie_rocket, // 0x38
        air_patrol // 0x39
    };

    // idx 0x5 members: 0xea type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_super_strength, // 0xd7
        specialty_super_speed, // 0xd8
        specialty_durability, // 0xd9
        specialty_adrenaline, // 0xda
        specialty_outlander, // 0xdb
        specialty_shroud, // 0xdc
        specialty_combat_scout, // 0xdd
        specialty_mechanic, // 0xde
        specialty_contract_payout, // 0xdf
        specialty_lightweight_br, // 0xe0
        specialty_restock_br, // 0xe1
        specialty_shrapnel_br, // 0xe2
        specialty_treadless_boots_br, // 0xe3
        specialty_tac_pads_br, // 0xe4
        specialty_tac_resist_br, // 0xe5
        specialty_silicon_gloves_br, // 0xe6
        specialty_scavenger_br, // 0xe7
        specialty_survivor_br, // 0xe8
        specialty_tempered_br // 0xe9
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3d type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage // 0x3c
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
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
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_c24d3ce4926da724

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x65 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun // 0x64
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3c type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        napalm_strike, // 0x34
        missile_turret, // 0x35
        rcxd, // 0x36
        radar_ping, // 0x37
        gas_strike, // 0x38
        hellstorm_missile, // 0x39
        valkyrie_rocket, // 0x3a
        air_patrol // 0x3b
    };

    // idx 0x5 members: 0xeb type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_ninja_vest, // 0xd7
        specialty_super_strength, // 0xd8
        specialty_super_speed, // 0xd9
        specialty_durability, // 0xda
        specialty_adrenaline, // 0xdb
        specialty_outlander, // 0xdc
        specialty_shroud, // 0xdd
        specialty_combat_scout, // 0xde
        specialty_mechanic, // 0xdf
        specialty_contract_payout, // 0xe0
        specialty_lightweight_br, // 0xe1
        specialty_restock_br, // 0xe2
        specialty_shrapnel_br, // 0xe3
        specialty_treadless_boots_br, // 0xe4
        specialty_tac_pads_br, // 0xe5
        specialty_tac_resist_br, // 0xe6
        specialty_silicon_gloves_br, // 0xe7
        specialty_scavenger_br, // 0xe8
        specialty_survivor_br, // 0xe9
        specialty_tempered_br // 0xea
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3d type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage // 0x3c
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
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
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_ede80f14fd88410b

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x65 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun // 0x64
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3c type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        napalm_strike, // 0x34
        missile_turret, // 0x35
        rcxd, // 0x36
        radar_ping, // 0x37
        gas_strike, // 0x38
        hellstorm_missile, // 0x39
        valkyrie_rocket, // 0x3a
        air_patrol // 0x3b
    };

    // idx 0x5 members: 0xeb type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_ninja_vest, // 0xd7
        specialty_super_strength, // 0xd8
        specialty_super_speed, // 0xd9
        specialty_durability, // 0xda
        specialty_adrenaline, // 0xdb
        specialty_outlander, // 0xdc
        specialty_shroud, // 0xdd
        specialty_combat_scout, // 0xde
        specialty_mechanic, // 0xdf
        specialty_contract_payout, // 0xe0
        specialty_lightweight_br, // 0xe1
        specialty_restock_br, // 0xe2
        specialty_shrapnel_br, // 0xe3
        specialty_treadless_boots_br, // 0xe4
        specialty_tac_pads_br, // 0xe5
        specialty_tac_resist_br, // 0xe6
        specialty_silicon_gloves_br, // 0xe7
        specialty_scavenger_br, // 0xe8
        specialty_survivor_br, // 0xe9
        specialty_tempered_br // 0xea
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3d type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage // 0x3c
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_ba1f615acd2b4bb1

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x66 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v // 0x65
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3c type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        napalm_strike, // 0x34
        missile_turret, // 0x35
        rcxd, // 0x36
        radar_ping, // 0x37
        gas_strike, // 0x38
        hellstorm_missile, // 0x39
        valkyrie_rocket, // 0x3a
        air_patrol // 0x3b
    };

    // idx 0x5 members: 0xec type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_ninja_vest, // 0xd7
        specialty_dauntless_boots, // 0xd8
        specialty_super_strength, // 0xd9
        specialty_super_speed, // 0xda
        specialty_durability, // 0xdb
        specialty_adrenaline, // 0xdc
        specialty_outlander, // 0xdd
        specialty_shroud, // 0xde
        specialty_combat_scout, // 0xdf
        specialty_mechanic, // 0xe0
        specialty_contract_payout, // 0xe1
        specialty_lightweight_br, // 0xe2
        specialty_restock_br, // 0xe3
        specialty_shrapnel_br, // 0xe4
        specialty_treadless_boots_br, // 0xe5
        specialty_tac_pads_br, // 0xe6
        specialty_tac_resist_br, // 0xe7
        specialty_silicon_gloves_br, // 0xe8
        specialty_scavenger_br, // 0xe9
        specialty_survivor_br, // 0xea
        specialty_tempered_br // 0xeb
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3d type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage // 0x3c
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_28de3c2533099328

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x66 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v // 0x65
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3c type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        napalm_strike, // 0x34
        missile_turret, // 0x35
        rcxd, // 0x36
        radar_ping, // 0x37
        gas_strike, // 0x38
        hellstorm_missile, // 0x39
        valkyrie_rocket, // 0x3a
        air_patrol // 0x3b
    };

    // idx 0x5 members: 0xf0 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br // 0xef
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3e type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine // 0x3d
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_374fe1f6d7ce9714

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x67 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines // 0x66
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3c type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        napalm_strike, // 0x34
        missile_turret, // 0x35
        rcxd, // 0x36
        radar_ping, // 0x37
        gas_strike, // 0x38
        hellstorm_missile, // 0x39
        valkyrie_rocket, // 0x3a
        air_patrol // 0x3b
    };

    // idx 0x5 members: 0xf0 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br // 0xef
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3e type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine // 0x3d
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_bc90b6883bb0a411

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3c type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        napalm_strike, // 0x34
        missile_turret, // 0x35
        rcxd, // 0x36
        radar_ping, // 0x37
        gas_strike, // 0x38
        hellstorm_missile, // 0x39
        valkyrie_rocket, // 0x3a
        air_patrol // 0x3b
    };

    // idx 0x5 members: 0xf2 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br, // 0xef
        specialty_mutation_gas_cloud, // 0xf0
        specialty_self_tracked // 0xf1
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x40 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling // 0x3f
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_6e52dc6768c7353c

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3d type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        napalm_strike, // 0x35
        missile_turret, // 0x36
        rcxd, // 0x37
        radar_ping, // 0x38
        gas_strike, // 0x39
        hellstorm_missile, // 0x3a
        valkyrie_rocket, // 0x3b
        air_patrol // 0x3c
    };

    // idx 0x5 members: 0xf2 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br, // 0xef
        specialty_mutation_gas_cloud, // 0xf0
        specialty_self_tracked // 0xf1
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x41 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield // 0x40
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_8550dcc51517ea47

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3d type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        napalm_strike, // 0x35
        missile_turret, // 0x36
        rcxd, // 0x37
        radar_ping, // 0x38
        gas_strike, // 0x39
        hellstorm_missile, // 0x3a
        valkyrie_rocket, // 0x3b
        air_patrol // 0x3c
    };

    // idx 0x5 members: 0xf2 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br, // 0xef
        specialty_mutation_gas_cloud, // 0xf0
        specialty_self_tracked // 0xf1
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x44 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32 // 0x43
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_f004533e8cb11488

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3d type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        napalm_strike, // 0x35
        missile_turret, // 0x36
        rcxd, // 0x37
        radar_ping, // 0x38
        gas_strike, // 0x39
        hellstorm_missile, // 0x3a
        valkyrie_rocket, // 0x3b
        air_patrol // 0x3c
    };

    // idx 0x5 members: 0xf2 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br, // 0xef
        specialty_mutation_gas_cloud, // 0xf0
        specialty_self_tracked // 0xf1
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x42 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud // 0x41
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_9d8c809db4156428

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3e type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        reaper_drone, // 0x35
        napalm_strike, // 0x36
        missile_turret, // 0x37
        rcxd, // 0x38
        radar_ping, // 0x39
        gas_strike, // 0x3a
        hellstorm_missile, // 0x3b
        valkyrie_rocket, // 0x3c
        air_patrol // 0x3d
    };

    // idx 0x5 members: 0xf2 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br, // 0xef
        specialty_mutation_gas_cloud, // 0xf0
        specialty_self_tracked // 0xf1
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x42 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud // 0x41
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_d48900da2a3fd978

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3e type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        reaper_drone, // 0x35
        napalm_strike, // 0x36
        missile_turret, // 0x37
        rcxd, // 0x38
        radar_ping, // 0x39
        gas_strike, // 0x3a
        hellstorm_missile, // 0x3b
        valkyrie_rocket, // 0x3c
        air_patrol // 0x3d
    };

    // idx 0x5 members: 0xf2 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br, // 0xef
        specialty_mutation_gas_cloud, // 0xf0
        specialty_self_tracked // 0xf1
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x44 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32 // 0x43
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_16df3fcbe4e81818

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3e type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        reaper_drone, // 0x35
        napalm_strike, // 0x36
        missile_turret, // 0x37
        rcxd, // 0x38
        radar_ping, // 0x39
        gas_strike, // 0x3a
        hellstorm_missile, // 0x3b
        valkyrie_rocket, // 0x3c
        air_patrol // 0x3d
    };

    // idx 0x5 members: 0xf3 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_super_strength, // 0xdd
        specialty_super_speed, // 0xde
        specialty_durability, // 0xdf
        specialty_adrenaline, // 0xe0
        specialty_outlander, // 0xe1
        specialty_shroud, // 0xe2
        specialty_combat_scout, // 0xe3
        specialty_mechanic, // 0xe4
        specialty_contract_payout, // 0xe5
        specialty_lightweight_br, // 0xe6
        specialty_restock_br, // 0xe7
        specialty_shrapnel_br, // 0xe8
        specialty_treadless_boots_br, // 0xe9
        specialty_tac_pads_br, // 0xea
        specialty_tac_resist_br, // 0xeb
        specialty_silicon_gloves_br, // 0xec
        specialty_scavenger_br, // 0xed
        specialty_survivor_br, // 0xee
        specialty_tempered_br, // 0xef
        specialty_mutation_gas_cloud, // 0xf0
        specialty_self_tracked, // 0xf1
        specialty_specialist_bonus // 0xf2
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x44 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32 // 0x43
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_7f6d3b99635f8cae

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x68 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high // 0x67
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3f type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        missile_drone, // 0x35
        juggernaut_mutant, // 0x36
        napalm_strike, // 0x37
        missile_turret, // 0x38
        rcxd, // 0x39
        radar_ping, // 0x3a
        gas_strike, // 0x3b
        hellstorm_missile, // 0x3c
        valkyrie_rocket, // 0x3d
        air_patrol // 0x3e
    };

    // idx 0x5 members: 0xf4 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_combined_arms_vest, // 0xdd
        specialty_super_strength, // 0xde
        specialty_super_speed, // 0xdf
        specialty_durability, // 0xe0
        specialty_adrenaline, // 0xe1
        specialty_outlander, // 0xe2
        specialty_shroud, // 0xe3
        specialty_combat_scout, // 0xe4
        specialty_mechanic, // 0xe5
        specialty_contract_payout, // 0xe6
        specialty_lightweight_br, // 0xe7
        specialty_restock_br, // 0xe8
        specialty_shrapnel_br, // 0xe9
        specialty_treadless_boots_br, // 0xea
        specialty_tac_pads_br, // 0xeb
        specialty_tac_resist_br, // 0xec
        specialty_silicon_gloves_br, // 0xed
        specialty_scavenger_br, // 0xee
        specialty_survivor_br, // 0xef
        specialty_tempered_br, // 0xf0
        specialty_mutation_gas_cloud, // 0xf1
        specialty_self_tracked, // 0xf2
        specialty_specialist_bonus // 0xf3
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x49 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32, // 0x43
        equip_redeploy_drone_beacon, // 0x44
        equip_mutant_emp_ball, // 0x45
        equip_mutant_ability_5, // 0x46
        equip_mutant_ability_6, // 0x47
        equip_mutant_sludge_ball // 0x48
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_ba14c4b73b9b1b7a

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x69 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high, // 0x67
        warrior // 0x68
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3f type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        missile_drone, // 0x35
        juggernaut_mutant, // 0x36
        napalm_strike, // 0x37
        missile_turret, // 0x38
        rcxd, // 0x39
        radar_ping, // 0x3a
        gas_strike, // 0x3b
        hellstorm_missile, // 0x3c
        valkyrie_rocket, // 0x3d
        air_patrol // 0x3e
    };

    // idx 0x5 members: 0xf4 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_combined_arms_vest, // 0xdd
        specialty_super_strength, // 0xde
        specialty_super_speed, // 0xdf
        specialty_durability, // 0xe0
        specialty_adrenaline, // 0xe1
        specialty_outlander, // 0xe2
        specialty_shroud, // 0xe3
        specialty_combat_scout, // 0xe4
        specialty_mechanic, // 0xe5
        specialty_contract_payout, // 0xe6
        specialty_lightweight_br, // 0xe7
        specialty_restock_br, // 0xe8
        specialty_shrapnel_br, // 0xe9
        specialty_treadless_boots_br, // 0xea
        specialty_tac_pads_br, // 0xeb
        specialty_tac_resist_br, // 0xec
        specialty_silicon_gloves_br, // 0xed
        specialty_scavenger_br, // 0xee
        specialty_survivor_br, // 0xef
        specialty_tempered_br, // 0xf0
        specialty_mutation_gas_cloud, // 0xf1
        specialty_self_tracked, // 0xf2
        specialty_specialist_bonus // 0xf3
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x49 type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32, // 0x43
        equip_redeploy_drone_beacon, // 0x44
        equip_mutant_emp_ball, // 0x45
        equip_mutant_ability_5, // 0x46
        equip_mutant_ability_6, // 0x47
        equip_mutant_sludge_ball // 0x48
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_1739b4364f097cc3

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x69 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high, // 0x67
        warrior // 0x68
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3f type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        missile_drone, // 0x35
        juggernaut_mutant, // 0x36
        napalm_strike, // 0x37
        missile_turret, // 0x38
        rcxd, // 0x39
        radar_ping, // 0x3a
        gas_strike, // 0x3b
        hellstorm_missile, // 0x3c
        valkyrie_rocket, // 0x3d
        air_patrol // 0x3e
    };

    // idx 0x5 members: 0xf9 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_combined_arms_vest, // 0xdd
        specialty_super_strength, // 0xde
        specialty_super_speed, // 0xdf
        specialty_durability, // 0xe0
        specialty_adrenaline, // 0xe1
        specialty_outlander, // 0xe2
        specialty_shroud, // 0xe3
        specialty_combat_scout, // 0xe4
        specialty_mechanic, // 0xe5
        specialty_contract_payout, // 0xe6
        specialty_lightweight_br, // 0xe7
        specialty_restock_br, // 0xe8
        specialty_shrapnel_br, // 0xe9
        specialty_treadless_boots_br, // 0xea
        specialty_tac_pads_br, // 0xeb
        specialty_tac_resist_br, // 0xec
        specialty_silicon_gloves_br, // 0xed
        specialty_scavenger_br, // 0xee
        specialty_survivor_br, // 0xef
        specialty_tempered_br, // 0xf0
        specialty_mutation_gas_cloud, // 0xf1
        specialty_self_tracked, // 0xf2
        specialty_specialist_bonus, // 0xf3
        specialty_mutation_mode_bonus_01, // 0xf4
        specialty_mutation_mode_bonus_02, // 0xf5
        specialty_mutation_mode_bonus_03, // 0xf6
        specialty_mutation_mode_bonus_04, // 0xf7
        specialty_mutation_mode_bonus_05 // 0xf8
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x4e type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32, // 0x43
        equip_redeploy_drone_beacon, // 0x44
        equip_mutant_emp_ball, // 0x45
        equip_mutant_ability_4, // 0x46
        equip_mutant_ability_5, // 0x47
        equip_mutant_ability_6, // 0x48
        equip_mutant_ability_7, // 0x49
        equip_mutant_sludge_ball, // 0x4a
        equip_emp_grenade, // 0x4b
        equip_mutant_ability_1, // 0x4c
        equip_mutant_ability_10 // 0x4d
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_7f42c11f06db865c

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x6a type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high, // 0x67
        warrior, // 0x68
        slam // 0x69
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3f type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        missile_drone, // 0x35
        juggernaut_mutant, // 0x36
        napalm_strike, // 0x37
        missile_turret, // 0x38
        rcxd, // 0x39
        radar_ping, // 0x3a
        gas_strike, // 0x3b
        hellstorm_missile, // 0x3c
        valkyrie_rocket, // 0x3d
        air_patrol // 0x3e
    };

    // idx 0x5 members: 0xf9 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_combined_arms_vest, // 0xdd
        specialty_super_strength, // 0xde
        specialty_super_speed, // 0xdf
        specialty_durability, // 0xe0
        specialty_adrenaline, // 0xe1
        specialty_outlander, // 0xe2
        specialty_shroud, // 0xe3
        specialty_combat_scout, // 0xe4
        specialty_mechanic, // 0xe5
        specialty_contract_payout, // 0xe6
        specialty_lightweight_br, // 0xe7
        specialty_restock_br, // 0xe8
        specialty_shrapnel_br, // 0xe9
        specialty_treadless_boots_br, // 0xea
        specialty_tac_pads_br, // 0xeb
        specialty_tac_resist_br, // 0xec
        specialty_silicon_gloves_br, // 0xed
        specialty_scavenger_br, // 0xee
        specialty_survivor_br, // 0xef
        specialty_tempered_br, // 0xf0
        specialty_mutation_gas_cloud, // 0xf1
        specialty_self_tracked, // 0xf2
        specialty_specialist_bonus, // 0xf3
        specialty_mutation_mode_bonus_01, // 0xf4
        specialty_mutation_mode_bonus_02, // 0xf5
        specialty_mutation_mode_bonus_03, // 0xf6
        specialty_mutation_mode_bonus_04, // 0xf7
        specialty_mutation_mode_bonus_05 // 0xf8
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x4e type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32, // 0x43
        equip_redeploy_drone_beacon, // 0x44
        equip_mutant_emp_ball, // 0x45
        equip_mutant_ability_4, // 0x46
        equip_mutant_ability_5, // 0x47
        equip_mutant_ability_6, // 0x48
        equip_mutant_ability_7, // 0x49
        equip_mutant_sludge_ball, // 0x4a
        equip_emp_grenade, // 0x4b
        equip_mutant_ability_1, // 0x4c
        equip_mutant_ability_10 // 0x4d
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
    enum ClientPlatform {
        none, // 0x0
        steam, // 0x1
        bnet, // 0x2
        xb3, // 0x3
        ps4, // 0x4
        wegame // 0x5
    };

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171760 (0x29ef0)
    // byte size . 21470 (0x53de)
    // archive ... hash_8fb2b6f0f48480e0

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x6a type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v, // 0x65
        mines, // 0x66
        high, // 0x67
        warrior, // 0x68
        slam // 0x69
    };

    // idx 0x1 members: 0xc3 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_kill_dna_nuke, // 0x50
        ss_use_airdrop, // 0x51
        ss_use_enemy_airdrop, // 0x52
        kill_ss_radar_drone_escort, // 0x53
        kill_ss_radar_drone_recon, // 0x54
        kill_ss_radar_drone_overwatch, // 0x55
        kill_ss_scrambler_drone_escort, // 0x56
        kill_ss_scrambler_drone_guard, // 0x57
        kill_ss_support_box, // 0x58
        kill_ss_manual_turret, // 0x59
        kill_ss_toma_strike, // 0x5a
        kill_ss_multi_airstrike, // 0x5b
        kill_ss_cruise_predator, // 0x5c
        kill_ss_pac_sentry, // 0x5d
        kill_ss_chopper_gunner, // 0x5e
        kill_ss_gunship, // 0x5f
        kill_ss_sentry_gun, // 0x60
        kill_ss_jackal, // 0x61
        kill_ss_airdrop, // 0x62
        kill_ss_uav, // 0x63
        kill_ss_counter_uav, // 0x64
        kill_ss_directional_uav, // 0x65
        kill_ss_drone_hive, // 0x66
        kill_ss_fuel_airstrike, // 0x67
        kill_ss_chopper_support, // 0x68
        kill_ss_hover_jet, // 0x69
        kill_ss_emp_drone, // 0x6a
        kill_ss_bradley, // 0x6b
        kill_ss_assault_drone, // 0x6c
        kill_ss_auto_drone, // 0x6d
        kill_ss_airdrop_escort, // 0x6e
        kill_ss_switchblade_drone, // 0x6f
        kill_ss_lrad, // 0x70
        kill_ss_loitering_munition, // 0x71
        kill_ss_drone_swarm, // 0x72
        kill_ss_missile_turret, // 0x73
        super_kill_steeldragon, // 0x74
        super_kill_amplify, // 0x75
        super_kill_overdrive, // 0x76
        super_kill_claw, // 0x77
        super_kill_armorup, // 0x78
        super_kill_bull_charge, // 0x79
        super_kill_armmgs, // 0x7a
        super_kill_reaper, // 0x7b
        super_kill_rewind, // 0x7c
        super_kill_atomizer, // 0x7d
        super_kill_phaseshift, // 0x7e
        super_kill_teleport, // 0x7f
        super_kill_blackholegun, // 0x80
        super_kill_supertrophy, // 0x81
        super_kill_microturret, // 0x82
        super_kill_penetrationrailgun, // 0x83
        super_kill_visionpulse, // 0x84
        super_kill_invisible, // 0x85
        super_shutdown_steeldragon, // 0x86
        super_shutdown_amplify, // 0x87
        super_shutdown_overdrive, // 0x88
        super_shutdown_claw, // 0x89
        super_shutdown_armorup, // 0x8a
        super_shutdown_bull_charge, // 0x8b
        super_shutdown_armmgs, // 0x8c
        super_shutdown_reaper, // 0x8d
        super_shutdown_rewind, // 0x8e
        super_shutdown_atomizer, // 0x8f
        super_shutdown_phaseshift, // 0x90
        super_shutdown_teleport, // 0x91
        super_shutdown_blackholegun, // 0x92
        super_shutdown_supertrophy, // 0x93
        super_shutdown_microturret, // 0x94
        super_shutdown_penetrationrailgun, // 0x95
        super_shutdown_visionpulse, // 0x96
        super_shutdown_invisible, // 0x97
        mode_ctf_cap, // 0x98
        mode_ctf_kill_carrier, // 0x99
        mode_ctf_kill_with_flag, // 0x9a
        mode_ctf_close_return, // 0x9b
        mode_ctf_nope, // 0x9c
        mode_x_last_alive, // 0x9d
        mode_x_eliminate, // 0x9e
        mode_sd_last_defuse, // 0x9f
        mode_sd_defuse, // 0xa0
        mode_sd_detonate, // 0xa1
        mode_sd_plant_save, // 0xa2
        mode_sd_defuse_save, // 0xa3
        mode_x_clear, // 0xa4
        mode_hp_secure, // 0xa5
        mode_hp_secure_reduced, // 0xa6
        mode_hp_secure_tiny, // 0xa7
        mode_hp_assault, // 0xa8
        mode_hp_quick_cap, // 0xa9
        mode_kc_own_tags, // 0xaa
        mode_kc_3_tags, // 0xab
        mode_dom_secure_b, // 0xac
        mode_dom_secure_neutral, // 0xad
        mode_dom_assault, // 0xae
        mode_dom_secure_assist, // 0xaf
        mode_dom_secure, // 0xb0
        mode_dom_neutralized, // 0xb1
        mode_dom_neutralized_cap, // 0xb2
        mode_arm_secure_mid, // 0xb3
        mode_arm_secure_outer_mid, // 0xb4
        mode_arm_secure_outer, // 0xb5
        mode_cyber_kill_with_emp, // 0xb6
        mode_cyber_kill_carrier, // 0xb7
        mode_x_assault, // 0xb8
        mode_x_defend, // 0xb9
        mode_x_wipeout, // 0xba
        mode_siege_secure, // 0xbb
        mode_gun_quick_kill, // 0xbc
        mode_gun_melee_1st_place, // 0xbd
        mode_gun_melee, // 0xbe
        match_complete, // 0xbf
        match_complete_win, // 0xc0
        rock_paper_scissors_win, // 0xc1
        simultaneous_kill // 0xc2
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

    // idx 0x4 members: 0x3f type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        dna_nuke, // 0x34
        missile_drone, // 0x35
        juggernaut_mutant, // 0x36
        napalm_strike, // 0x37
        missile_turret, // 0x38
        rcxd, // 0x39
        radar_ping, // 0x3a
        gas_strike, // 0x3b
        hellstorm_missile, // 0x3c
        valkyrie_rocket, // 0x3d
        air_patrol // 0x3e
    };

    // idx 0x5 members: 0xf9 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier_vest, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_compression_carrier, // 0xc4
        specialty_compression_plate, // 0xc5
        specialty_rhino_rig, // 0xc6
        specialty_lightweight_vest, // 0xc7
        specialty_shielded_electronics, // 0xc8
        specialty_thermal_insulation, // 0xc9
        specialty_extra_plate, // 0xca
        specialty_fast_armor, // 0xcb
        specialty_armor_regen, // 0xcc
        specialty_aegis_vest, // 0xcd
        specialty_cct_vest, // 0xce
        specialty_marksman_gloves, // 0xcf
        specialty_stalker_boots, // 0xd0
        specialty_infantry_vest, // 0xd1
        specialty_grenadier_vest, // 0xd2
        specialty_scout_vest, // 0xd3
        specialty_overkill_vest, // 0xd4
        specialty_tac_vest, // 0xd5
        specialty_gunner_vest, // 0xd6
        specialty_fast_reload, // 0xd7
        specialty_marksman_vest, // 0xd8
        specialty_ninja_vest, // 0xd9
        specialty_dauntless_boots, // 0xda
        specialty_pistol_vest, // 0xdb
        specialty_ninja_gloves, // 0xdc
        specialty_combined_arms_vest, // 0xdd
        specialty_super_strength, // 0xde
        specialty_super_speed, // 0xdf
        specialty_durability, // 0xe0
        specialty_adrenaline, // 0xe1
        specialty_outlander, // 0xe2
        specialty_shroud, // 0xe3
        specialty_combat_scout, // 0xe4
        specialty_mechanic, // 0xe5
        specialty_contract_payout, // 0xe6
        specialty_lightweight_br, // 0xe7
        specialty_restock_br, // 0xe8
        specialty_shrapnel_br, // 0xe9
        specialty_treadless_boots_br, // 0xea
        specialty_tac_pads_br, // 0xeb
        specialty_tac_resist_br, // 0xec
        specialty_silicon_gloves_br, // 0xed
        specialty_scavenger_br, // 0xee
        specialty_survivor_br, // 0xef
        specialty_tempered_br, // 0xf0
        specialty_mutation_gas_cloud, // 0xf1
        specialty_self_tracked, // 0xf2
        specialty_specialist_bonus, // 0xf3
        specialty_mutation_mode_bonus_01, // 0xf4
        specialty_mutation_mode_bonus_02, // 0xf5
        specialty_mutation_mode_bonus_03, // 0xf6
        specialty_mutation_mode_bonus_04, // 0xf7
        specialty_mutation_mode_bonus_05 // 0xf8
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x4e type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage, // 0x3c
        equip_tracker_mine, // 0x3d
        equip_mutation_mutant_vision, // 0x3e
        equip_mutation_sludge_sling, // 0x3f
        equip_mutation_shield, // 0x40
        equip_mutation_gas_cloud, // 0x41
        equip_bunkerbuster_mike32, // 0x42
        equip_semtex_mike32, // 0x43
        equip_redeploy_drone_beacon, // 0x44
        equip_mutant_emp_ball, // 0x45
        equip_mutant_ability_4, // 0x46
        equip_mutant_ability_5, // 0x47
        equip_mutant_ability_6, // 0x48
        equip_mutant_ability_7, // 0x49
        equip_mutant_sludge_ball, // 0x4a
        equip_emp_grenade, // 0x4b
        equip_mutant_ability_1, // 0x4c
        equip_mutant_ability_10 // 0x4d
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0xf type: 0
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

    // root: bitSize: 0x29ee0, members: 16

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
    int scoreProgressLimit;
    // offset: 0x5948, bitSize: 0x20(0x4 Byte(s))
    int alliesDeaths;
    // offset: 0x5968, bitSize: 0x20(0x4 Byte(s))
    float axisTTB;
    // offset: 0x5988, bitSize: 0x24540(0x48a8 Byte(s)), array:0xc8(hti:0xffff)
    Player players[200];
    // offset: 0x29ec8, bitSize: 0x10(0x2 Byte(s))
    short deathCount;
    // offset: 0x29ed8, bitSize: 0x1
    bool isPublicMatch;
};

version 1 {
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_25c29f9767d6c3a8

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x66 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun, // 0x64
        conf_v // 0x65
    };

    // idx 0x1 members: 0xc2 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        kill_ss_missile_turret, // 0x72
        super_kill_steeldragon, // 0x73
        super_kill_amplify, // 0x74
        super_kill_overdrive, // 0x75
        super_kill_claw, // 0x76
        super_kill_armorup, // 0x77
        super_kill_bull_charge, // 0x78
        super_kill_armmgs, // 0x79
        super_kill_reaper, // 0x7a
        super_kill_rewind, // 0x7b
        super_kill_atomizer, // 0x7c
        super_kill_phaseshift, // 0x7d
        super_kill_teleport, // 0x7e
        super_kill_blackholegun, // 0x7f
        super_kill_supertrophy, // 0x80
        super_kill_microturret, // 0x81
        super_kill_penetrationrailgun, // 0x82
        super_kill_visionpulse, // 0x83
        super_kill_invisible, // 0x84
        super_shutdown_steeldragon, // 0x85
        super_shutdown_amplify, // 0x86
        super_shutdown_overdrive, // 0x87
        super_shutdown_claw, // 0x88
        super_shutdown_armorup, // 0x89
        super_shutdown_bull_charge, // 0x8a
        super_shutdown_armmgs, // 0x8b
        super_shutdown_reaper, // 0x8c
        super_shutdown_rewind, // 0x8d
        super_shutdown_atomizer, // 0x8e
        super_shutdown_phaseshift, // 0x8f
        super_shutdown_teleport, // 0x90
        super_shutdown_blackholegun, // 0x91
        super_shutdown_supertrophy, // 0x92
        super_shutdown_microturret, // 0x93
        super_shutdown_penetrationrailgun, // 0x94
        super_shutdown_visionpulse, // 0x95
        super_shutdown_invisible, // 0x96
        mode_ctf_cap, // 0x97
        mode_ctf_kill_carrier, // 0x98
        mode_ctf_kill_with_flag, // 0x99
        mode_ctf_close_return, // 0x9a
        mode_ctf_nope, // 0x9b
        mode_x_last_alive, // 0x9c
        mode_x_eliminate, // 0x9d
        mode_sd_last_defuse, // 0x9e
        mode_sd_defuse, // 0x9f
        mode_sd_detonate, // 0xa0
        mode_sd_plant_save, // 0xa1
        mode_sd_defuse_save, // 0xa2
        mode_x_clear, // 0xa3
        mode_hp_secure, // 0xa4
        mode_hp_secure_reduced, // 0xa5
        mode_hp_secure_tiny, // 0xa6
        mode_hp_assault, // 0xa7
        mode_hp_quick_cap, // 0xa8
        mode_kc_own_tags, // 0xa9
        mode_kc_3_tags, // 0xaa
        mode_dom_secure_b, // 0xab
        mode_dom_secure_neutral, // 0xac
        mode_dom_assault, // 0xad
        mode_dom_secure_assist, // 0xae
        mode_dom_secure, // 0xaf
        mode_dom_neutralized, // 0xb0
        mode_dom_neutralized_cap, // 0xb1
        mode_arm_secure_mid, // 0xb2
        mode_arm_secure_outer_mid, // 0xb3
        mode_arm_secure_outer, // 0xb4
        mode_cyber_kill_with_emp, // 0xb5
        mode_cyber_kill_carrier, // 0xb6
        mode_x_assault, // 0xb7
        mode_x_defend, // 0xb8
        mode_x_wipeout, // 0xb9
        mode_siege_secure, // 0xba
        mode_gun_quick_kill, // 0xbb
        mode_gun_melee_1st_place, // 0xbc
        mode_gun_melee, // 0xbd
        match_complete, // 0xbe
        match_complete_win, // 0xbf
        rock_paper_scissors_win, // 0xc0
        simultaneous_kill // 0xc1
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

    // idx 0x4 members: 0x3c type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        electric_discharge, // 0x32
        laser_charge, // 0x33
        napalm_strike, // 0x34
        missile_turret, // 0x35
        rcxd, // 0x36
        radar_ping, // 0x37
        gas_strike, // 0x38
        hellstorm_missile, // 0x39
        valkyrie_rocket, // 0x3a
        air_patrol // 0x3b
    };

    // idx 0x5 members: 0xeb type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_ninja_vest, // 0xd7
        specialty_super_strength, // 0xd8
        specialty_super_speed, // 0xd9
        specialty_durability, // 0xda
        specialty_adrenaline, // 0xdb
        specialty_outlander, // 0xdc
        specialty_shroud, // 0xdd
        specialty_combat_scout, // 0xde
        specialty_mechanic, // 0xdf
        specialty_contract_payout, // 0xe0
        specialty_lightweight_br, // 0xe1
        specialty_restock_br, // 0xe2
        specialty_shrapnel_br, // 0xe3
        specialty_treadless_boots_br, // 0xe4
        specialty_tac_pads_br, // 0xe5
        specialty_tac_resist_br, // 0xe6
        specialty_silicon_gloves_br, // 0xe7
        specialty_scavenger_br, // 0xe8
        specialty_survivor_br, // 0xe9
        specialty_tempered_br // 0xea
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3d type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball, // 0x3b
        equip_squadrage // 0x3c
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
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
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_84d7923b7a38fea3

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x65 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun // 0x64
    };

    // idx 0x1 members: 0xc0 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        super_kill_steeldragon, // 0x72
        super_kill_amplify, // 0x73
        super_kill_overdrive, // 0x74
        super_kill_claw, // 0x75
        super_kill_armorup, // 0x76
        super_kill_bull_charge, // 0x77
        super_kill_armmgs, // 0x78
        super_kill_reaper, // 0x79
        super_kill_rewind, // 0x7a
        super_kill_atomizer, // 0x7b
        super_kill_phaseshift, // 0x7c
        super_kill_teleport, // 0x7d
        super_kill_blackholegun, // 0x7e
        super_kill_supertrophy, // 0x7f
        super_kill_microturret, // 0x80
        super_kill_penetrationrailgun, // 0x81
        super_kill_visionpulse, // 0x82
        super_kill_invisible, // 0x83
        super_shutdown_steeldragon, // 0x84
        super_shutdown_amplify, // 0x85
        super_shutdown_overdrive, // 0x86
        super_shutdown_claw, // 0x87
        super_shutdown_armorup, // 0x88
        super_shutdown_bull_charge, // 0x89
        super_shutdown_armmgs, // 0x8a
        super_shutdown_reaper, // 0x8b
        super_shutdown_rewind, // 0x8c
        super_shutdown_atomizer, // 0x8d
        super_shutdown_phaseshift, // 0x8e
        super_shutdown_teleport, // 0x8f
        super_shutdown_blackholegun, // 0x90
        super_shutdown_supertrophy, // 0x91
        super_shutdown_microturret, // 0x92
        super_shutdown_penetrationrailgun, // 0x93
        super_shutdown_visionpulse, // 0x94
        super_shutdown_invisible, // 0x95
        mode_ctf_cap, // 0x96
        mode_ctf_kill_carrier, // 0x97
        mode_ctf_kill_with_flag, // 0x98
        mode_ctf_close_return, // 0x99
        mode_ctf_nope, // 0x9a
        mode_x_last_alive, // 0x9b
        mode_x_eliminate, // 0x9c
        mode_sd_last_defuse, // 0x9d
        mode_sd_defuse, // 0x9e
        mode_sd_detonate, // 0x9f
        mode_sd_plant_save, // 0xa0
        mode_sd_defuse_save, // 0xa1
        mode_x_clear, // 0xa2
        mode_hp_secure, // 0xa3
        mode_hp_secure_reduced, // 0xa4
        mode_hp_assault, // 0xa5
        mode_hp_quick_cap, // 0xa6
        mode_kc_own_tags, // 0xa7
        mode_kc_3_tags, // 0xa8
        mode_dom_secure_b, // 0xa9
        mode_dom_secure_neutral, // 0xaa
        mode_dom_assault, // 0xab
        mode_dom_secure_assist, // 0xac
        mode_dom_secure, // 0xad
        mode_dom_neutralized, // 0xae
        mode_dom_neutralized_cap, // 0xaf
        mode_arm_secure_mid, // 0xb0
        mode_arm_secure_outer_mid, // 0xb1
        mode_arm_secure_outer, // 0xb2
        mode_cyber_kill_with_emp, // 0xb3
        mode_cyber_kill_carrier, // 0xb4
        mode_x_assault, // 0xb5
        mode_x_defend, // 0xb6
        mode_x_wipeout, // 0xb7
        mode_siege_secure, // 0xb8
        mode_gun_quick_kill, // 0xb9
        mode_gun_melee_1st_place, // 0xba
        mode_gun_melee, // 0xbb
        match_complete, // 0xbc
        match_complete_win, // 0xbd
        rock_paper_scissors_win, // 0xbe
        simultaneous_kill // 0xbf
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

    // idx 0x4 members: 0x3a type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        napalm_strike, // 0x32
        missile_turret, // 0x33
        rcxd, // 0x34
        radar_ping, // 0x35
        gas_strike, // 0x36
        hellstorm_missile, // 0x37
        valkyrie_rocket, // 0x38
        air_patrol // 0x39
    };

    // idx 0x5 members: 0xe4 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_adrenaline, // 0xd7
        specialty_outlander, // 0xd8
        specialty_shroud, // 0xd9
        specialty_combat_scout, // 0xda
        specialty_mechanic, // 0xdb
        specialty_contract_payout, // 0xdc
        specialty_lightweight_br, // 0xdd
        specialty_restock_br, // 0xde
        specialty_shrapnel_br, // 0xdf
        specialty_treadless_boots_br, // 0xe0
        specialty_tac_pads_br, // 0xe1
        specialty_tac_resist_br, // 0xe2
        specialty_silicon_gloves_br // 0xe3
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3c type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball // 0x3b
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0xf type: 0
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
    // enums ..... 14 (0xe)
    // structs ... 8 (0x8)
    // bit size .. 171728 (0x29ed0)
    // byte size . 21466 (0x53da)
    // archive ... hash_7eeb08a32c434f2a

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

    // bitSize: 0xc0, members: 6
    struct AARData {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int use_featured_operator_skin_xp;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int logistics_xp;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int combat_xp;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int strategy_xp;
        // offset: 0x80, bitSize: 0x20(0x4 Byte(s))
        int recon_xp;
        // offset: 0xa0, bitSize: 0x20(0x4 Byte(s))
        int support_xp;
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

    // idx 0x0 members: 0x65 type: 0
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
        dmz, // 0x28
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
        plunder, // 0x3d
        ko, // 0x3e
        risk, // 0x3f
        hstg, // 0x40
        fr, // 0x41
        gwbomb, // 0x42
        rescue, // 0x43
        landgrab, // 0x44
        elim, // 0x45
        gwai, // 0x46
        bounty, // 0x47
        zm_rb, // 0x48
        gwtdm, // 0x49
        ob, // 0x4a
        dungeons, // 0x4b
        resurgence, // 0x4c
        exgm, // 0x4d
        kingslayer, // 0x4e
        mini, // 0x4f
        mini_mgl, // 0x50
        resurgence_mgl, // 0x51
        rsurge, // 0x52
        truckwar, // 0x53
        vanilla, // 0x54
        zxp, // 0x55
        benchmark, // 0x56
        ballmode, // 0x57
        brtdm_mgl, // 0x58
        conflict, // 0x59
        havoc, // 0x5a
        bigctf, // 0x5b
        xfire, // 0x5c
        robj, // 0x5d
        zm_turned, // 0x5e
        wm, // 0x5f
        escort, // 0x60
        training_course, // 0x61
        br_auto, // 0x62
        gold_gun, // 0x63
        team_gun // 0x64
    };

    // idx 0x1 members: 0xc0 type: 0
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
        ss_kill_switchblade_drone, // 0x4c
        ss_kill_loitering_munition, // 0x4d
        ss_kill_juggernaut_recon, // 0x4e
        ss_kill_drone_swarm, // 0x4f
        ss_use_airdrop, // 0x50
        ss_use_enemy_airdrop, // 0x51
        kill_ss_radar_drone_escort, // 0x52
        kill_ss_radar_drone_recon, // 0x53
        kill_ss_radar_drone_overwatch, // 0x54
        kill_ss_scrambler_drone_escort, // 0x55
        kill_ss_scrambler_drone_guard, // 0x56
        kill_ss_support_box, // 0x57
        kill_ss_manual_turret, // 0x58
        kill_ss_toma_strike, // 0x59
        kill_ss_multi_airstrike, // 0x5a
        kill_ss_cruise_predator, // 0x5b
        kill_ss_pac_sentry, // 0x5c
        kill_ss_chopper_gunner, // 0x5d
        kill_ss_gunship, // 0x5e
        kill_ss_sentry_gun, // 0x5f
        kill_ss_jackal, // 0x60
        kill_ss_airdrop, // 0x61
        kill_ss_uav, // 0x62
        kill_ss_counter_uav, // 0x63
        kill_ss_directional_uav, // 0x64
        kill_ss_drone_hive, // 0x65
        kill_ss_fuel_airstrike, // 0x66
        kill_ss_chopper_support, // 0x67
        kill_ss_hover_jet, // 0x68
        kill_ss_emp_drone, // 0x69
        kill_ss_bradley, // 0x6a
        kill_ss_assault_drone, // 0x6b
        kill_ss_auto_drone, // 0x6c
        kill_ss_airdrop_escort, // 0x6d
        kill_ss_switchblade_drone, // 0x6e
        kill_ss_lrad, // 0x6f
        kill_ss_loitering_munition, // 0x70
        kill_ss_drone_swarm, // 0x71
        super_kill_steeldragon, // 0x72
        super_kill_amplify, // 0x73
        super_kill_overdrive, // 0x74
        super_kill_claw, // 0x75
        super_kill_armorup, // 0x76
        super_kill_bull_charge, // 0x77
        super_kill_armmgs, // 0x78
        super_kill_reaper, // 0x79
        super_kill_rewind, // 0x7a
        super_kill_atomizer, // 0x7b
        super_kill_phaseshift, // 0x7c
        super_kill_teleport, // 0x7d
        super_kill_blackholegun, // 0x7e
        super_kill_supertrophy, // 0x7f
        super_kill_microturret, // 0x80
        super_kill_penetrationrailgun, // 0x81
        super_kill_visionpulse, // 0x82
        super_kill_invisible, // 0x83
        super_shutdown_steeldragon, // 0x84
        super_shutdown_amplify, // 0x85
        super_shutdown_overdrive, // 0x86
        super_shutdown_claw, // 0x87
        super_shutdown_armorup, // 0x88
        super_shutdown_bull_charge, // 0x89
        super_shutdown_armmgs, // 0x8a
        super_shutdown_reaper, // 0x8b
        super_shutdown_rewind, // 0x8c
        super_shutdown_atomizer, // 0x8d
        super_shutdown_phaseshift, // 0x8e
        super_shutdown_teleport, // 0x8f
        super_shutdown_blackholegun, // 0x90
        super_shutdown_supertrophy, // 0x91
        super_shutdown_microturret, // 0x92
        super_shutdown_penetrationrailgun, // 0x93
        super_shutdown_visionpulse, // 0x94
        super_shutdown_invisible, // 0x95
        mode_ctf_cap, // 0x96
        mode_ctf_kill_carrier, // 0x97
        mode_ctf_kill_with_flag, // 0x98
        mode_ctf_close_return, // 0x99
        mode_ctf_nope, // 0x9a
        mode_x_last_alive, // 0x9b
        mode_x_eliminate, // 0x9c
        mode_sd_last_defuse, // 0x9d
        mode_sd_defuse, // 0x9e
        mode_sd_detonate, // 0x9f
        mode_sd_plant_save, // 0xa0
        mode_sd_defuse_save, // 0xa1
        mode_x_clear, // 0xa2
        mode_hp_secure, // 0xa3
        mode_hp_secure_reduced, // 0xa4
        mode_hp_assault, // 0xa5
        mode_hp_quick_cap, // 0xa6
        mode_kc_own_tags, // 0xa7
        mode_kc_3_tags, // 0xa8
        mode_dom_secure_b, // 0xa9
        mode_dom_secure_neutral, // 0xaa
        mode_dom_assault, // 0xab
        mode_dom_secure_assist, // 0xac
        mode_dom_secure, // 0xad
        mode_dom_neutralized, // 0xae
        mode_dom_neutralized_cap, // 0xaf
        mode_arm_secure_mid, // 0xb0
        mode_arm_secure_outer_mid, // 0xb1
        mode_arm_secure_outer, // 0xb2
        mode_cyber_kill_with_emp, // 0xb3
        mode_cyber_kill_carrier, // 0xb4
        mode_x_assault, // 0xb5
        mode_x_defend, // 0xb6
        mode_x_wipeout, // 0xb7
        mode_siege_secure, // 0xb8
        mode_gun_quick_kill, // 0xb9
        mode_gun_melee_1st_place, // 0xba
        mode_gun_melee, // 0xbb
        match_complete, // 0xbc
        match_complete_win, // 0xbd
        rock_paper_scissors_win, // 0xbe
        simultaneous_kill // 0xbf
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

    // idx 0x4 members: 0x3a type: 0
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
        nuke_multi, // 0x25
        counter_uav, // 0x26
        switchblade_drone, // 0x27
        lrad, // 0x28
        remote_turret, // 0x29
        loitering_munition, // 0x2a
        juggernaut_recon, // 0x2b
        drone_swarm, // 0x2c
        ims, // 0x2d
        emp, // 0x2e
        nova_gas_bomb, // 0x2f
        static_discharge, // 0x30
        bunker_buster, // 0x31
        napalm_strike, // 0x32
        missile_turret, // 0x33
        rcxd, // 0x34
        radar_ping, // 0x35
        gas_strike, // 0x36
        hellstorm_missile, // 0x37
        valkyrie_rocket, // 0x38
        air_patrol // 0x39
    };

    // idx 0x5 members: 0xe4 type: 0
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
        specialty_scavenger_ammo_and_equipment, // 0x10
        specialty_sprintfire, // 0x11
        specialty_bullet_outline, // 0x12
        specialty_selectivehearing, // 0x13
        specialty_improvedmelee, // 0x14
        specialty_hard_shell, // 0x15
        specialty_engineer, // 0x16
        specialty_quieter, // 0x17
        specialty_bulletdamage, // 0x18
        specialty_armorvest, // 0x19
        specialty_twoprimaries, // 0x1a
        specialty_solobuddyboost, // 0x1b
        specialty_bling, // 0x1c
        specialty_underkill, // 0x1d
        specialty_third_person, // 0x1e
        specialty_bulletsuppress, // 0x1f
        specialty_ante_up, // 0x20
        specialty_flak_jacket, // 0x21
        specialty_gungho, // 0x22
        specialty_quartermaster, // 0x23
        specialty_slayer, // 0x24
        specialty_operative, // 0x25
        specialty_tactician, // 0x26
        specialty_engineer_minimap, // 0x27
        specialty_support_streaker, // 0x28
        specialty_perceptive, // 0x29
        specialty_coldblooded_and_hidden, // 0x2a
        specialty_assassin, // 0x2b
        specialty_gearhead, // 0x2c
        specialty_extraammo, // 0x2d
        specialty_fastsprintrecovery, // 0x2e
        specialty_fastreload, // 0x2f
        specialty_incog, // 0x30
        specialty_detectexplosive, // 0x31
        specialty_stun_resistance, // 0x32
        specialty_chain_reaction, // 0x33
        specialty_cloak_aerial, // 0x34
        specialty_spawn_radar, // 0x35
        specialty_thief, // 0x36
        specialty_extendedmelee, // 0x37
        specialty_meleekill, // 0x38
        specialty_afterburner, // 0x39
        specialty_paint, // 0x3a
        specialty_viewkickoverride, // 0x3b
        specialty_undying, // 0x3c
        specialty_teleport, // 0x3d
        specialty_activereload, // 0x3e
        specialty_thruster, // 0x3f
        specialty_sixth_sense, // 0x40
        specialty_ai_stealth_sixth_sense, // 0x41
        specialty_mark_targets, // 0x42
        specialty_rush, // 0x43
        specialty_superpack, // 0x44
        specialty_enhanced_sixth_sense, // 0x45
        specialty_dodge, // 0x46
        specialty_ground_pound, // 0x47
        specialty_personal_trophy, // 0x48
        specialty_regenfaster, // 0x49
        specialty_equipment_ping, // 0x4a
        specialty_rugged_eqp, // 0x4b
        specialty_gung_ho, // 0x4c
        specialty_man_at_arms, // 0x4d
        specialty_cloak, // 0x4e
        specialty_wall_lock, // 0x4f
        specialty_comexp, // 0x50
        specialty_scavenger_eqp, // 0x51
        specialty_ftlslide, // 0x52
        specialty_support_killstreaks, // 0x53
        specialty_marksman, // 0x54
        specialty_ads_awareness, // 0x55
        specialty_rearguard, // 0x56
        specialty_ballcarrier, // 0x57
        specialty_powercell, // 0x58
        specialty_improved_prone, // 0x59
        specialty_spawnview, // 0x5a
        specialty_phaseslash, // 0x5b
        specialty_phase_fall, // 0x5c
        specialty_headgear, // 0x5d
        specialty_disruptor_punch, // 0x5e
        specialty_dodge_defense, // 0x5f
        specialty_dodge_wave, // 0x60
        specialty_extra_dodge, // 0x61
        specialty_extend_dodge, // 0x62
        specialty_blast_suppressor, // 0x63
        specialty_hover, // 0x64
        specialty_spawncloak, // 0x65
        specialty_phaseslash_rephase, // 0x66
        specialty_battleslide_offense, // 0x67
        specialty_ground_pound_shield, // 0x68
        specialty_ground_pound_shock, // 0x69
        specialty_phase_slide, // 0x6a
        specialty_tele_slide, // 0x6b
        specialty_battleslide, // 0x6c
        specialty_camo_elite, // 0x6d
        specialty_batterypack, // 0x6e
        specialty_scorestreakpack, // 0x6f
        specialty_medic, // 0x70
        specialty_can_be_revived, // 0x71
        specialty_kill_report, // 0x72
        specialty_ads_mark_target, // 0x73
        specialty_healer, // 0x74
        specialty_hunter, // 0x75
        specialty_helmet, // 0x76
        specialty_breacher, // 0x77
        specialty_ladder, // 0x78
        specialty_revive_use_weapon, // 0x79
        specialty_regen_delay_reduced, // 0x7a
        specialty_classic_laststand, // 0x7b
        specialty_location_marking, // 0x7c
        specialty_remote_defuse, // 0x7d
        specialty_faster_field_upgrade, // 0x7e
        specialty_improved_target_mark, // 0x7f
        specialty_door_breach, // 0x80
        specialty_door_sense, // 0x81
        specialty_strategist, // 0x82
        specialty_munitions_2, // 0x83
        specialty_surveillance, // 0x84
        specialty_guerrilla, // 0x85
        specialty_tune_up, // 0x86
        specialty_restock, // 0x87
        specialty_hustle, // 0x88
        specialty_tactical_recon, // 0x89
        specialty_tac_resist, // 0x8a
        specialty_heavy_metal, // 0x8b
        specialty_scavenger_plus, // 0x8c
        specialty_extra_shrapnel, // 0x8d
        specialty_covert_ops, // 0x8e
        specialty_eod, // 0x8f
        specialty_huntmaster, // 0x90
        specialty_graverobber, // 0x91
        specialty_mercenary, // 0x92
        specialty_warhead, // 0x93
        specialty_sonar, // 0x94
        specialty_quick_fix, // 0x95
        specialty_headhunter, // 0x96
        specialty_armored, // 0x97
        specialty_overcharge_field_upgrade, // 0x98
        specialty_survivor, // 0x99
        specialty_overwatch, // 0x9a
        specialty_grenade_expert, // 0x9b
        specialty_focus, // 0x9c
        specialty_extra_tactical, // 0x9d
        specialty_pc_medic, // 0x9e
        specialty_pc_comms, // 0x9f
        specialty_pc_stealth, // 0xa0
        specialty_pc_tempered, // 0xa1
        specialty_hijacked_iff_strobe, // 0xa2
        specialty_acoustic_sensor, // 0xa3
        specialty_tac_mask, // 0xa4
        specialty_fast_hands, // 0xa5
        specialty_lr_detector, // 0xa6
        specialty_signal_jammer, // 0xa7
        specialty_monomer_plate, // 0xa8
        specialty_thermal_camo, // 0xa9
        specialty_elasomer_pads, // 0xaa
        specialty_dex_gloves, // 0xab
        specialty_tac_gloves, // 0xac
        specialty_canvas_sneakers, // 0xad
        specialty_maritime_boots, // 0xae
        specialty_blacklight_flashlight, // 0xaf
        specialty_ultra_light_boots, // 0xb0
        specialty_high_gain_antenna, // 0xb1
        specialty_silicon_gloves, // 0xb2
        specialty_impact_res_gloves, // 0xb3
        specialty_custom_gloves, // 0xb4
        specialty_nods, // 0xb5
        specialty_taccom_system, // 0xb6
        specialty_bone_conduction, // 0xb7
        specialty_intel_jacker, // 0xb8
        specialty_radio_intercept, // 0xb9
        specialty_flame_res_insulation, // 0xba
        specialty_shielded_carrier, // 0xbb
        specialty_suspension_pads, // 0xbc
        specialty_assault_gloves, // 0xbd
        specialty_tac_pads, // 0xbe
        specialty_running_sneakers, // 0xbf
        specialty_treadless_boots, // 0xc0
        specialty_eod_vest, // 0xc1
        specialty_compression_carrier, // 0xc2
        specialty_ghost_camo, // 0xc3
        specialty_rhino_rig, // 0xc4
        specialty_lightweight_vest, // 0xc5
        specialty_shielded_electronics, // 0xc6
        specialty_thermal_insulation, // 0xc7
        specialty_extra_plate, // 0xc8
        specialty_fast_armor, // 0xc9
        specialty_armor_regen, // 0xca
        specialty_aegis_vest, // 0xcb
        specialty_cct_vest, // 0xcc
        specialty_marksman_gloves, // 0xcd
        specialty_stalker_boots, // 0xce
        specialty_infantry_vest, // 0xcf
        specialty_grenadier_vest, // 0xd0
        specialty_scout_vest, // 0xd1
        specialty_overkill_vest, // 0xd2
        specialty_tac_vest, // 0xd3
        specialty_gunner_vest, // 0xd4
        specialty_fast_reload, // 0xd5
        specialty_marksman_vest, // 0xd6
        specialty_adrenaline, // 0xd7
        specialty_outlander, // 0xd8
        specialty_shroud, // 0xd9
        specialty_combat_scout, // 0xda
        specialty_mechanic, // 0xdb
        specialty_contract_payout, // 0xdc
        specialty_lightweight_br, // 0xdd
        specialty_restock_br, // 0xde
        specialty_shrapnel_br, // 0xdf
        specialty_treadless_boots_br, // 0xe0
        specialty_tac_pads_br, // 0xe1
        specialty_tac_resist_br, // 0xe2
        specialty_silicon_gloves_br // 0xe3
    };

    // idx 0x6 members: 0x4 type: 0
    enum LoadoutPerkBonusType {
        specialty_null, // 0x0
        specialty_slayer, // 0x1
        specialty_operative, // 0x2
        specialty_tactician // 0x3
    };

    // idx 0x7 members: 0x52 type: 0
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

    // idx 0x8 members: 0x3c type: 0
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
        equip_thermal_phone, // 0x22
        equip_impact_grenade, // 0x23
        equip_tracker_grenade, // 0x24
        equip_ied, // 0x25
        equip_spycam, // 0x26
        equip_proximity_alarm, // 0x27
        equip_combataxe, // 0x28
        equip_butterfly_mine, // 0x29
        equip_monkey_bomb, // 0x2a
        equip_capture_bot, // 0x2b
        equip_breacher_drone, // 0x2c
        equip_blackhole_bomb, // 0x2d
        equip_med_box, // 0x2e
        equip_thermobaric_grenade, // 0x2f
        equip_battlerage, // 0x30
        equip_comm_scrambler, // 0x31
        equip_armor_onehanded, // 0x32
        equip_recondrone, // 0x33
        equip_gas_trap_plantable, // 0x34
        equip_landmine, // 0x35
        equip_assault_pack, // 0x36
        equip_jammer, // 0x37
        equip_armory, // 0x38
        equip_evg, // 0x39
        equip_snowball, // 0x3a
        equip_pball // 0x3b
    };

    // idx 0x9 members: 0x3 type: 0
    enum Wildcard {
        wildcard_none, // 0x0
        wildcard_dangerclose, // 0x1
        wildcard_overkill // 0x2
    };

    // idx 0xa members: 0x5 type: 0
    enum ScoreboardType {
        none, // 0x0
        neutral, // 0x1
        allies, // 0x2
        axis, // 0x3
        multiteam // 0x4
    };

    // idx 0xb members: 0xa type: 0
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

    // idx 0xc members: 0xcb type: 0
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

    // idx 0xd members: 0x6 type: 0
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

