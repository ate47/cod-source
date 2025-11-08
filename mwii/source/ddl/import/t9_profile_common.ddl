// file .... ddl\import\t9_profile_common.ddl

version 1 {
    // enums ..... 52 (0x34)
    // structs ... 18 (0x12)
    // bit size .. 17696 (0x4520)
    // byte size . 2212 (0x8a4)
    // archive ... hash_c42f2b6d17ba86b1

    // bitSize: 0x10, members: 1
    struct OutfitItemListBreadcrumb {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool outfit_item_marked_old[16];
    };

    // bitSize: 0xc0, members: 2
    struct OutfitPartsListBreadcrumb {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x8(hti:0x0)
        OutfitItemListBreadcrumb parts[outfitParts_e];
        // offset: 0x80, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool preset_item_marked_old[64];
    };

    // bitSize: 0x100, members: 1
    struct JumpkitComponentBreadcrumb {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s)), array:0x100(hti:0xffff)
        bool jumpkit_part_marked_old[256];
    };

    // bitSize: 0xd0, members: 3
    struct WristAccessory {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        WristAccessories selectedWristAccessory;
        // offset: 0x8, bitSize: 0xc6, array:0xc6(hti:0x2)
        bool marked_old[WristAccessories];
    };

    // bitSize: 0xa0, members: 3
    struct Execution {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Executions selectedExecution;
        // offset: 0x8, bitSize: 0x92, array:0x92(hti:0x3)
        bool marked_old[Executions];
    };

    // bitSize: 0x40, members: 1
    struct CharacterOutfit {
        // offset: 0x0, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0x0)
        uint:5 selectedComponent[outfitParts_e];
    };

    // bitSize: 0x2818, members: 6
    struct Character {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedOutfit;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedWarPaintOutfit;
        // offset: 0x10, bitSize: 0x1e00(0x3c0 Byte(s)), array:0x28(hti:0xffff)
        OutfitPartsListBreadcrumb outfit_breadcrumbs[40];
        // offset: 0x1e10, bitSize: 0xa00(0x140 Byte(s)), array:0x28(hti:0xffff)
        CharacterOutfit selectedOutfitItems[40];
        // offset: 0x2810, bitSize: 0x1
        bool isRandomSelectedOutfit;
    };

    // bitSize: 0x48, members: 4
    struct CharacterContext {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        uint characterIndex;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        uint characterMode;
        // offset: 0x40, bitSize: 0x1
        bool isRandomCharacter;
    };

    // bitSize: 0x58, members: 5
    struct SelectedCharacter {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:6 outfitIndex;
        // offset: 0x8, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0x0)
        uint:5 outfitItems[outfitParts_e];
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:6 warPaintOutfitIndex;
        // offset: 0x50, bitSize: 0x1
        bool locked;
    };

    // bitSize: 0x50, members: 3
    struct InGameCharacter {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedOutfit;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedWarPaintOutfit;
        // offset: 0x10, bitSize: 0x40(0x8 Byte(s))
        CharacterOutfit selectedOutfitItems;
    };

    // bitSize: 0x188, members: 10
    struct WeaponVariant {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        uint:11 charmIndex;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        uint:7 blueprint;
        // offset: 0x18, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0xffff)
        uint:7 attachment[8];
        // offset: 0x58, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0xffff)
        uint:7 blueprintattachment[8];
        // offset: 0x98, bitSize: 0x50(0xa Byte(s)), array:0x5(hti:0xffff)
        uint:10 sticker[5];
        // offset: 0xe8, bitSize: 0x80(0x10 Byte(s))
        string(16) variantName;
        // offset: 0x168, bitSize: 0x8(0x1 Byte(s))
        uint:8 reticleIndex;
        // offset: 0x170, bitSize: 0x10(0x2 Byte(s))
        uint:9 camoIndex;
        // offset: 0x180, bitSize: 0x1
        bool variantValid;
    };

    // bitSize: 0xf50, members: 1
    struct WeaponCustomization {
        // offset: 0x0, bitSize: 0xf50(0x1ea Byte(s)), array:0xa(hti:0xffff)
        WeaponVariant variant[10];
    };

    // bitSize: 0xc0, members: 3
    struct VehicleCustomization {
        // offset: 0x0, bitSize: 0x40(0x8 Byte(s))
        hash horn;
        // offset: 0x40, bitSize: 0x40(0x8 Byte(s))
        hash skin;
        // offset: 0x80, bitSize: 0x40(0x8 Byte(s))
        hash battleTrack;
    };

    // bitSize: 0x13b0, members: 39
    struct mp_character_outfit_preset_breadcrumbs {
        // offset: 0x0, bitSize: 0x138(0x27 Byte(s)), array:0x27(hti:0x10)
        uint:2 prt_mp_gen_pl_esports_male[prt_mp_gen_pl_esports_male_outfit_presets];
        // offset: 0x138, bitSize: 0x80(0x10 Byte(s)), array:0x10(hti:0x1f)
        uint:2 prt_mp_rus_stitch[prt_mp_rus_stitch_outfit_presets];
        // offset: 0x1b8, bitSize: 0x38(0x7 Byte(s)), array:0x7(hti:0x1e)
        uint:2 prt_mp_rus_spetsnaz[prt_mp_rus_spetsnaz_outfit_presets];
        // offset: 0x1f0, bitSize: 0x50(0xa Byte(s)), array:0xa(hti:0x27)
        uint:2 prt_mp_usa_deltaforce[prt_mp_usa_deltaforce_outfit_presets];
        // offset: 0x240, bitSize: 0x58(0xb Byte(s)), array:0xb(hti:0x20)
        uint:2 prt_mp_sa_deathstalker[prt_mp_sa_deathstalker_outfit_presets];
        // offset: 0x298, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0x26)
        uint:2 prt_mp_usa_cia[prt_mp_usa_cia_outfit_presets];
        // offset: 0x3a8, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x28)
        uint:2 prt_mp_usa_ghostface[prt_mp_usa_ghostface_outfit_presets];
        // offset: 0x3b8, bitSize: 0x20(0x4 Byte(s)), array:0x4(hti:0xc)
        uint:2 prt_mp_eg_quicksand[prt_mp_eg_quicksand_outfit_presets];
        // offset: 0x3d8, bitSize: 0x130(0x26 Byte(s)), array:0x26(hti:0x29)
        uint:2 prt_mp_usa_hero_adler[prt_mp_usa_hero_adler_outfit_presets];
        // offset: 0x508, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x19)
        uint:2 prt_mp_isr_lazar[prt_mp_isr_lazar_outfit_presets];
        // offset: 0x518, bitSize: 0x138(0x27 Byte(s)), array:0x27(hti:0x11)
        uint:2 prt_mp_gen_pl_esports_male_warsaw[prt_mp_gen_pl_esports_male_warsaw_outfit_presets];
        // offset: 0x650, bitSize: 0x60(0xc Byte(s)), array:0xc(hti:0x1b)
        uint:2 prt_mp_lao[prt_mp_lao_outfit_presets];
        // offset: 0x6b0, bitSize: 0x38(0x7 Byte(s)), array:0x7(hti:0x1c)
        uint:2 prt_mp_nic[prt_mp_nic_outfit_presets];
        // offset: 0x6e8, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x23)
        uint:2 prt_mp_uk_price[prt_mp_uk_price_outfit_presets];
        // offset: 0x6f8, bitSize: 0x58(0xb Byte(s)), array:0xb(hti:0x1a)
        uint:2 prt_mp_jps_kitsune[prt_mp_jps_kitsune_outfit_presets];
        // offset: 0x750, bitSize: 0x28(0x5 Byte(s)), array:0x5(hti:0x2a)
        uint:2 prt_mp_usa_hudson[prt_mp_usa_hudson_outfit_presets];
        // offset: 0x778, bitSize: 0x38(0x7 Byte(s)), array:0x7(hti:0x17)
        uint:2 prt_mp_ger_pl_maxis[prt_mp_ger_pl_maxis_outfit_presets];
        // offset: 0x7b0, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0xb)
        uint:2 prt_mp_cub_dgi[prt_mp_cub_dgi_outfit_presets];
        // offset: 0x8c0, bitSize: 0x88(0x11 Byte(s)), array:0x11(hti:0x12)
        uint:2 prt_mp_gen_starter1[prt_mp_gen_starter1_outfit_presets];
        // offset: 0x948, bitSize: 0xa0(0x14 Byte(s)), array:0x14(hti:0x13)
        uint:2 prt_mp_gen_starter2[prt_mp_gen_starter2_outfit_presets];
        // offset: 0x9e8, bitSize: 0xc0(0x18 Byte(s)), array:0x18(hti:0x14)
        uint:2 prt_mp_gen_starter3[prt_mp_gen_starter3_outfit_presets];
        // offset: 0xaa8, bitSize: 0xc0(0x18 Byte(s)), array:0x18(hti:0x15)
        uint:2 prt_mp_gen_starter4[prt_mp_gen_starter4_outfit_presets];
        // offset: 0xb68, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0x16)
        uint:2 prt_mp_gen_starter5[prt_mp_gen_starter5_outfit_presets];
        // offset: 0xc20, bitSize: 0x28(0x5 Byte(s)), array:0x5(hti:0x30)
        uint:2 prt_mp_usa_weaver[prt_mp_usa_weaver_outfit_presets];
        // offset: 0xc48, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0x1d)
        uint:2 prt_mp_rus_kgb[prt_mp_rus_kgb_outfit_presets];
        // offset: 0xd58, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0x18)
        uint:2 prt_mp_ger_west[prt_mp_ger_west_outfit_presets];
        // offset: 0xe68, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x2c)
        uint:2 prt_mp_usa_mcclane[prt_mp_usa_mcclane_outfit_presets];
        // offset: 0xe78, bitSize: 0x60(0xc Byte(s)), array:0xc(hti:0xe)
        uint:2 prt_mp_fin_wraith[prt_mp_fin_wraith_outfit_presets];
        // offset: 0xed8, bitSize: 0x50(0xa Byte(s)), array:0xa(hti:0xf)
        uint:2 prt_mp_fra_dgse[prt_mp_fra_dgse_outfit_presets];
        // offset: 0xf28, bitSize: 0x58(0xb Byte(s)), array:0xb(hti:0x2b)
        uint:2 prt_mp_usa_mason[prt_mp_usa_mason_outfit_presets];
        // offset: 0xf80, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x2e)
        uint:2 prt_mp_usa_rambo[prt_mp_usa_rambo_outfit_presets];
        // offset: 0xf90, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x2f)
        uint:2 prt_mp_usa_surge[prt_mp_usa_surge_outfit_presets];
        // offset: 0xfa0, bitSize: 0xe8(0x1d Byte(s)), array:0x1d(hti:0x31)
        uint:2 prt_mp_usa_woods[prt_mp_usa_woods_outfit_presets];
        // offset: 0x1088, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x21)
        uint:2 prt_mp_uk_kingsley[prt_mp_uk_kingsley_outfit_presets];
        // offset: 0x1098, bitSize: 0x160(0x2c Byte(s)), array:0x2c(hti:0x22)
        uint:2 prt_mp_uk_mi6[prt_mp_uk_mi6_outfit_presets];
        // offset: 0x11f8, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x24)
        uint:2 prt_mp_uk_sas[prt_mp_uk_sas_outfit_presets];
        // offset: 0x1208, bitSize: 0x150(0x2a Byte(s)), array:0x2a(hti:0x2d)
        uint:2 prt_mp_usa_navy_seal[prt_mp_usa_navy_seal_outfit_presets];
        // offset: 0x1358, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xd)
        uint:2 prt_mp_esp_goe_bomber[prt_mp_esp_goe_bomber_outfit_presets];
        // offset: 0x1370, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0x25)
        uint:2 prt_mp_usa_bulldozer[prt_mp_usa_bulldozer_outfit_presets];
    };

    // bitSize: 0x278, members: 40
    struct CharacterOutfitPresetRandomFilters {
        // offset: 0x0, bitSize: 0x27, array:0x27(hti:0x10)
        bool prt_mp_gen_pl_esports_male[prt_mp_gen_pl_esports_male_outfit_presets];
        // offset: 0x27, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0x1f)
        bool prt_mp_rus_stitch[prt_mp_rus_stitch_outfit_presets];
        // offset: 0x37, bitSize: 0x7, array:0x7(hti:0x1e)
        bool prt_mp_rus_spetsnaz[prt_mp_rus_spetsnaz_outfit_presets];
        // offset: 0x3e, bitSize: 0xa, array:0xa(hti:0x27)
        bool prt_mp_usa_deltaforce[prt_mp_usa_deltaforce_outfit_presets];
        // offset: 0x48, bitSize: 0xb, array:0xb(hti:0x20)
        bool prt_mp_sa_deathstalker[prt_mp_sa_deathstalker_outfit_presets];
        // offset: 0x53, bitSize: 0x22, array:0x22(hti:0x26)
        bool prt_mp_usa_cia[prt_mp_usa_cia_outfit_presets];
        // offset: 0x75, bitSize: 0x2, array:0x2(hti:0x28)
        bool prt_mp_usa_ghostface[prt_mp_usa_ghostface_outfit_presets];
        // offset: 0x77, bitSize: 0x4, array:0x4(hti:0xc)
        bool prt_mp_eg_quicksand[prt_mp_eg_quicksand_outfit_presets];
        // offset: 0x7b, bitSize: 0x26, array:0x26(hti:0x29)
        bool prt_mp_usa_hero_adler[prt_mp_usa_hero_adler_outfit_presets];
        // offset: 0xa1, bitSize: 0x2, array:0x2(hti:0x19)
        bool prt_mp_isr_lazar[prt_mp_isr_lazar_outfit_presets];
        // offset: 0xa3, bitSize: 0x27, array:0x27(hti:0x11)
        bool prt_mp_gen_pl_esports_male_warsaw[prt_mp_gen_pl_esports_male_warsaw_outfit_presets];
        // offset: 0xca, bitSize: 0xc, array:0xc(hti:0x1b)
        bool prt_mp_lao[prt_mp_lao_outfit_presets];
        // offset: 0xd6, bitSize: 0x7, array:0x7(hti:0x1c)
        bool prt_mp_nic[prt_mp_nic_outfit_presets];
        // offset: 0xdd, bitSize: 0x2, array:0x2(hti:0x23)
        bool prt_mp_uk_price[prt_mp_uk_price_outfit_presets];
        // offset: 0xdf, bitSize: 0xb, array:0xb(hti:0x1a)
        bool prt_mp_jps_kitsune[prt_mp_jps_kitsune_outfit_presets];
        // offset: 0xea, bitSize: 0x5, array:0x5(hti:0x2a)
        bool prt_mp_usa_hudson[prt_mp_usa_hudson_outfit_presets];
        // offset: 0xef, bitSize: 0x7, array:0x7(hti:0x17)
        bool prt_mp_ger_pl_maxis[prt_mp_ger_pl_maxis_outfit_presets];
        // offset: 0xf6, bitSize: 0x22, array:0x22(hti:0xb)
        bool prt_mp_cub_dgi[prt_mp_cub_dgi_outfit_presets];
        // offset: 0x118, bitSize: 0x11, array:0x11(hti:0x12)
        bool prt_mp_gen_starter1[prt_mp_gen_starter1_outfit_presets];
        // offset: 0x129, bitSize: 0x14, array:0x14(hti:0x13)
        bool prt_mp_gen_starter2[prt_mp_gen_starter2_outfit_presets];
        // offset: 0x13d, bitSize: 0x18(0x3 Byte(s)), array:0x18(hti:0x14)
        bool prt_mp_gen_starter3[prt_mp_gen_starter3_outfit_presets];
        // offset: 0x155, bitSize: 0x18(0x3 Byte(s)), array:0x18(hti:0x15)
        bool prt_mp_gen_starter4[prt_mp_gen_starter4_outfit_presets];
        // offset: 0x16d, bitSize: 0x17, array:0x17(hti:0x16)
        bool prt_mp_gen_starter5[prt_mp_gen_starter5_outfit_presets];
        // offset: 0x184, bitSize: 0x5, array:0x5(hti:0x30)
        bool prt_mp_usa_weaver[prt_mp_usa_weaver_outfit_presets];
        // offset: 0x189, bitSize: 0x22, array:0x22(hti:0x1d)
        bool prt_mp_rus_kgb[prt_mp_rus_kgb_outfit_presets];
        // offset: 0x1ab, bitSize: 0x22, array:0x22(hti:0x18)
        bool prt_mp_ger_west[prt_mp_ger_west_outfit_presets];
        // offset: 0x1cd, bitSize: 0x2, array:0x2(hti:0x2c)
        bool prt_mp_usa_mcclane[prt_mp_usa_mcclane_outfit_presets];
        // offset: 0x1cf, bitSize: 0xc, array:0xc(hti:0xe)
        bool prt_mp_fin_wraith[prt_mp_fin_wraith_outfit_presets];
        // offset: 0x1db, bitSize: 0xa, array:0xa(hti:0xf)
        bool prt_mp_fra_dgse[prt_mp_fra_dgse_outfit_presets];
        // offset: 0x1e5, bitSize: 0xb, array:0xb(hti:0x2b)
        bool prt_mp_usa_mason[prt_mp_usa_mason_outfit_presets];
        // offset: 0x1f0, bitSize: 0x2, array:0x2(hti:0x2e)
        bool prt_mp_usa_rambo[prt_mp_usa_rambo_outfit_presets];
        // offset: 0x1f2, bitSize: 0x2, array:0x2(hti:0x2f)
        bool prt_mp_usa_surge[prt_mp_usa_surge_outfit_presets];
        // offset: 0x1f4, bitSize: 0x1d, array:0x1d(hti:0x31)
        bool prt_mp_usa_woods[prt_mp_usa_woods_outfit_presets];
        // offset: 0x211, bitSize: 0x2, array:0x2(hti:0x21)
        bool prt_mp_uk_kingsley[prt_mp_uk_kingsley_outfit_presets];
        // offset: 0x213, bitSize: 0x2c, array:0x2c(hti:0x22)
        bool prt_mp_uk_mi6[prt_mp_uk_mi6_outfit_presets];
        // offset: 0x23f, bitSize: 0x2, array:0x2(hti:0x24)
        bool prt_mp_uk_sas[prt_mp_uk_sas_outfit_presets];
        // offset: 0x241, bitSize: 0x2a, array:0x2a(hti:0x2d)
        bool prt_mp_usa_navy_seal[prt_mp_usa_navy_seal_outfit_presets];
        // offset: 0x26b, bitSize: 0x3, array:0x3(hti:0xd)
        bool prt_mp_esp_goe_bomber[prt_mp_esp_goe_bomber_outfit_presets];
        // offset: 0x26e, bitSize: 0x8(0x1 Byte(s)), array:0x8(hti:0x25)
        bool prt_mp_usa_bulldozer[prt_mp_usa_bulldozer_outfit_presets];
    };

    // bitSize: 0xde0, members: 231
    struct GameplaySettings {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        float fov;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideDistanceToCircle;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivity;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:2 gpad_sticksConfig;
        // offset: 0x50, bitSize: 0x400(0x80 Byte(s))
        string(128) voice_output_device;
        // offset: 0x450, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideAltimeter;
        // offset: 0x458, bitSize: 0x20(0x4 Byte(s))
        float gpad_button_rstick_deflect_max;
        // offset: 0x478, bitSize: 0x8(0x1 Byte(s))
        uint:2 tap_to_slide_gpad;
        // offset: 0x480, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_cinematic;
        // offset: 0x4a0, bitSize: 0x20(0x4 Byte(s))
        float location_rotation_sensitivity_kbm;
        // offset: 0x4c0, bitSize: 0x8(0x1 Byte(s))
        uint:2 prone_behavior;
        // offset: 0x4c8, bitSize: 0x8(0x1 Byte(s))
        uint:2 tap_to_slide_kbm;
        // offset: 0x4d0, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_teamchat_volume;
        // offset: 0x4f0, bitSize: 0x20(0x4 Byte(s))
        float r_sceneBrightness;
        // offset: 0x510, bitSize: 0x20(0x4 Byte(s))
        float mouse_ads_monitor_distance_coefficient;
        // offset: 0x530, bitSize: 0x20(0x4 Byte(s))
        float gpad_right_stick_deadzone_max;
        // offset: 0x550, bitSize: 0x20(0x4 Byte(s))
        float gpad_right_stick_deadzone_min;
        // offset: 0x570, bitSize: 0x8(0x1 Byte(s))
        uint:2 mantle_behaviour_ground_kbm;
        // offset: 0x578, bitSize: 0x8(0x1 Byte(s))
        uint:2 toggle_sprint_gpad;
        // offset: 0x580, bitSize: 0x8(0x1 Byte(s))
        uint:2 voice_favored_channel;
        // offset: 0x588, bitSize: 0x20(0x4 Byte(s))
        float voice_output_volume;
        // offset: 0x5a8, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideMinimizedQuickEquip;
        // offset: 0x5b0, bitSize: 0x8(0x1 Byte(s))
        uint:2 com_show_ping;
        // offset: 0x5b8, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_music;
        // offset: 0x5d8, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_voice;
        // offset: 0x5f8, bitSize: 0x20(0x4 Byte(s))
        float speaker_left;
        // offset: 0x618, bitSize: 0x8(0x1 Byte(s))
        uint:2 team_indicator;
        // offset: 0x620, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideCompass;
        // offset: 0x628, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideConsole;
        // offset: 0x630, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideWeaponEquipment;
        // offset: 0x638, bitSize: 0x20(0x4 Byte(s))
        float location_selection_sensitivity_kbm;
        // offset: 0x658, bitSize: 0x20(0x4 Byte(s))
        uint party_privacyStatus;
        // offset: 0x678, bitSize: 0x20(0x4 Byte(s))
        float HUDBoundsTweakable_vertical;
        // offset: 0x698, bitSize: 0x10(0x2 Byte(s))
        uint:10 demo_autoDollyKeyframeInterval;
        // offset: 0x6a8, bitSize: 0x8(0x1 Byte(s))
        uint:7 subtitles_background_opacity;
        // offset: 0x6b0, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideMinimap;
        // offset: 0x6b8, bitSize: 0x8(0x1 Byte(s))
        uint:2 invert_vertical_look_mouse;
        // offset: 0x6c0, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_ads_multiplier_high_zoom;
        // offset: 0x6e0, bitSize: 0x8(0x1 Byte(s))
        uint:2 ads_sensitivity_timing_kbm;
        // offset: 0x6e8, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityADSScalarHighZoom;
        // offset: 0x708, bitSize: 0x8(0x1 Byte(s))
        uint:2 mantle_behaviour_air_kbm;
        // offset: 0x710, bitSize: 0x20(0x4 Byte(s))
        float speaker_right_surround;
        // offset: 0x730, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_ads_multiplier;
        // offset: 0x750, bitSize: 0x8(0x1 Byte(s))
        uint:2 invert_vertical_look_gamepad;
        // offset: 0x758, bitSize: 0x8(0x1 Byte(s))
        uint:3 colorblindMode;
        // offset: 0x760, bitSize: 0x20(0x4 Byte(s))
        float speaker_left_front;
        // offset: 0x780, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideTeamList;
        // offset: 0x788, bitSize: 0x20(0x4 Byte(s))
        float speaker_right_front;
        // offset: 0x7a8, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_party_color_key;
        // offset: 0x7e8, bitSize: 0x20(0x4 Byte(s))
        float orbis_menu_mouse_sensitivity_multiplier;
        // offset: 0x808, bitSize: 0x20(0x4 Byte(s))
        float speaker_lfe;
        // offset: 0x828, bitSize: 0x20(0x4 Byte(s))
        float speaker_center;
        // offset: 0x848, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHidePlayerHealth;
        // offset: 0x850, bitSize: 0x20(0x4 Byte(s))
        float gpad_button_lstick_deflect_max;
        // offset: 0x870, bitSize: 0x8(0x1 Byte(s))
        uint:2 crouch_behavior;
        // offset: 0x878, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideKillIdentity;
        // offset: 0x880, bitSize: 0x20(0x4 Byte(s))
        float location_rotation_sensitivity_gpad;
        // offset: 0x8a0, bitSize: 0x20(0x4 Byte(s))
        float speaker_left_surround;
        // offset: 0x8c0, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_ally_color_key;
        // offset: 0x900, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideInsertionCount;
        // offset: 0x908, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideKills;
        // offset: 0x910, bitSize: 0x8(0x1 Byte(s))
        uint:3 textchat_filter;
        // offset: 0x918, bitSize: 0x20(0x4 Byte(s))
        uint mouse_wheel_delay;
        // offset: 0x938, bitSize: 0x8(0x1 Byte(s))
        uint:2 input_autoAimInputGraphIw;
        // offset: 0x940, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_you_color_key;
        // offset: 0x980, bitSize: 0x20(0x4 Byte(s))
        float HUDBoundsTweakable_horizontal;
        // offset: 0x9a0, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideActivePerks;
        // offset: 0x9a8, bitSize: 0x20(0x4 Byte(s))
        float speaker_right_surround_back;
        // offset: 0x9c8, bitSize: 0x8(0x1 Byte(s))
        uint:2 toggle_sprint_kbm;
        // offset: 0x9d0, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityHorizontal;
        // offset: 0x9f0, bitSize: 0x20(0x4 Byte(s))
        float snd_scale_when_speaking;
        // offset: 0xa10, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideSpectators;
        // offset: 0xa18, bitSize: 0x20(0x4 Byte(s))
        float gpad_trigger_deadzone;
        // offset: 0xa38, bitSize: 0x8(0x1 Byte(s))
        uint:2 musicplayer_enable;
        // offset: 0xa40, bitSize: 0x20(0x4 Byte(s))
        float voice_input_threshold;
        // offset: 0xa60, bitSize: 0x8(0x1 Byte(s))
        uint:2 motion_blur_mode;
        // offset: 0xa68, bitSize: 0x20(0x4 Byte(s))
        uint snd_menu_hearing_impaired;
        // offset: 0xa88, bitSize: 0x20(0x4 Byte(s))
        float mouse_acceleration;
        // offset: 0xaa8, bitSize: 0x20(0x4 Byte(s))
        float gpad_hapticsIntensity;
        // offset: 0xac8, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_enemy_color_key;
        // offset: 0xb08, bitSize: 0x8(0x1 Byte(s))
        uint:2 gpad_aim_assist_iw_algorithm;
        // offset: 0xb10, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHidePlayersAlive;
        // offset: 0xb18, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_sfx;
        // offset: 0xb38, bitSize: 0x8(0x1 Byte(s))
        uint:6 subtitles_size;
        // offset: 0xb40, bitSize: 0x20(0x4 Byte(s))
        float voice_input_volume;
        // offset: 0xb60, bitSize: 0x8(0x1 Byte(s))
        uint:7 matchmakingDelay;
        // offset: 0xb68, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity;
        // offset: 0xb88, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_master;
        // offset: 0xba8, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_vehicle;
        // offset: 0xbc8, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityADSScalar;
        // offset: 0xbe8, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideObituary;
        // offset: 0xbf0, bitSize: 0x8(0x1 Byte(s))
        uint:2 chase_cam_free_look_mode;
        // offset: 0xbf8, bitSize: 0x8(0x1 Byte(s))
        uint:2 interact_reload_behavior;
        // offset: 0xc00, bitSize: 0x10(0x2 Byte(s))
        uint:9 musicplayer_playlist;
        // offset: 0xc10, bitSize: 0x20(0x4 Byte(s))
        float mouse_filtering;
        // offset: 0xc30, bitSize: 0x8(0x1 Byte(s))
        uint:2 gpad_swap_sticks_on_ads;
        // offset: 0xc38, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_vertical_multiplier;
        // offset: 0xc58, bitSize: 0x8(0x1 Byte(s))
        uint:3 snd_menu_presets;
        // offset: 0xc60, bitSize: 0x8(0x1 Byte(s))
        uint:5 gpad_buttonsConfig;
        // offset: 0xc68, bitSize: 0x8(0x1 Byte(s))
        uint:2 variable_zoom_shared_input;
        // offset: 0xc70, bitSize: 0x8(0x1 Byte(s))
        uint:2 zm_names_health_bars;
        // offset: 0xc78, bitSize: 0x20(0x4 Byte(s))
        float gpad_left_stick_deadzone_max;
        // offset: 0xc98, bitSize: 0x20(0x4 Byte(s))
        float gpad_left_stick_deadzone_min;
        // offset: 0xcb8, bitSize: 0x20(0x4 Byte(s))
        float speaker_left_surround_back;
        // offset: 0xcd8, bitSize: 0x8(0x1 Byte(s))
        uint:2 snd_menu_speaker_setup;
        // offset: 0xce0, bitSize: 0x10(0x2 Byte(s))
        uint:13 vehicle_camera_recenter_delay;
        // offset: 0xcf0, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityVertical;
        // offset: 0xd10, bitSize: 0x20(0x4 Byte(s))
        uint demo_controllerConfig;
        // offset: 0xd30, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideCleanups;
        // offset: 0xd38, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideOnScreenButtons;
        // offset: 0xd40, bitSize: 0x20(0x4 Byte(s))
        float speaker_right;
        // offset: 0xd60, bitSize: 0x8(0x1 Byte(s))
        uint:2 com_show_packet_loss;
        // offset: 0xd68, bitSize: 0x1
        bool display_ingame_alert_icons;
        // offset: 0xd69, bitSize: 0x1
        bool com_show_cpu_client_time;
        // offset: 0xd6a, bitSize: 0x1
        bool showConnectionMeter;
        // offset: 0xd6b, bitSize: 0x1
        bool armor_plate_behavior_kbm;
        // offset: 0xd6c, bitSize: 0x1
        bool snd_controller_sounds;
        // offset: 0xd6d, bitSize: 0x1
        bool healthbar_show_ally;
        // offset: 0xd6e, bitSize: 0x1
        bool parachute_auto_deploy_gpad;
        // offset: 0xd6f, bitSize: 0x1
        bool equipment_auto_hold_gpad;
        // offset: 0xd70, bitSize: 0x1
        bool auto_sprint_gpad;
        // offset: 0xd71, bitSize: 0x1
        bool com_show_system_clock;
        // offset: 0xd72, bitSize: 0x1
        bool musicplayer_shuffle;
        // offset: 0xd73, bitSize: 0x1
        bool decrease_zoom_shared_input;
        // offset: 0xd74, bitSize: 0x1
        bool auto_sprint_enabled;
        // offset: 0xd75, bitSize: 0x1
        bool display_crosshair;
        // offset: 0xd76, bitSize: 0x1
        bool minimapMode;
        // offset: 0xd77, bitSize: 0x1
        bool demo_autoDollyRecord;
        // offset: 0xd78, bitSize: 0x1
        bool warzoneReloadOnPress;
        // offset: 0xd79, bitSize: 0x1
        bool cg_blood;
        // offset: 0xd7a, bitSize: 0x1
        bool hitmarkers_sfx;
        // offset: 0xd7b, bitSize: 0x1
        bool splitscreenOrientation;
        // offset: 0xd7c, bitSize: 0x1
        bool auto_mount_ladder_enabled;
        // offset: 0xd7d, bitSize: 0x1
        bool toggle_steady_aim_kbm;
        // offset: 0xd7e, bitSize: 0x1
        bool input_device;
        // offset: 0xd7f, bitSize: 0x1
        bool sprint_cancel_reload_toggle_gpad;
        // offset: 0xd80, bitSize: 0x1
        bool cg_gibs;
        // offset: 0xd81, bitSize: 0x1
        bool com_show_vram;
        // offset: 0xd82, bitSize: 0x1
        bool tooltip_enable;
        // offset: 0xd83, bitSize: 0x1
        bool cursor_immediate_lock_inventory;
        // offset: 0xd84, bitSize: 0x1
        bool warzonePriorityPickups;
        // offset: 0xd85, bitSize: 0x1
        bool com_show_gpu_time;
        // offset: 0xd86, bitSize: 0x1
        bool healthbar_show_enemy;
        // offset: 0xd87, bitSize: 0x1
        bool hitmarkers_damage_type;
        // offset: 0xd88, bitSize: 0x1
        bool toggle_score_binding_kbm;
        // offset: 0xd89, bitSize: 0x1
        bool auto_sprint_kbm;
        // offset: 0xd8a, bitSize: 0x1
        bool disable_settings_clouding;
        // offset: 0xd8b, bitSize: 0x1
        bool chat_profanity_filter;
        // offset: 0xd8c, bitSize: 0x1
        bool warzoneCycleItems;
        // offset: 0xd8d, bitSize: 0x1
        bool rgb_disable;
        // offset: 0xd8e, bitSize: 0x1
        bool parachute_auto_deploy_kbm;
        // offset: 0xd8f, bitSize: 0x1
        bool transport_vehicle_alternate_control;
        // offset: 0xd90, bitSize: 0x1
        bool doa_text_hints;
        // offset: 0xd91, bitSize: 0x1
        bool toggle_ads_persistent_gpad;
        // offset: 0xd92, bitSize: 0x1
        bool relative_vehicle_hipfire_fov;
        // offset: 0xd93, bitSize: 0x1
        bool mantle_behaviour_air_gpad;
        // offset: 0xd94, bitSize: 0x1
        bool mute_voice;
        // offset: 0xd95, bitSize: 0x1
        bool cg_enableUGC;
        // offset: 0xd96, bitSize: 0x1
        bool incognitoSelf;
        // offset: 0xd97, bitSize: 0x1
        bool gpad_haptics;
        // offset: 0xd98, bitSize: 0x1
        bool doa_persistent_round;
        // offset: 0xd99, bitSize: 0x1
        bool demo_recordWithAutoPlay;
        // offset: 0xd9a, bitSize: 0x1
        bool attack_vehicle_alternate_control_kbm;
        // offset: 0xd9b, bitSize: 0x1
        bool cursor_immediate_lock_map;
        // offset: 0xd9c, bitSize: 0x1
        bool hitmarkers_sfx_enable;
        // offset: 0xd9d, bitSize: 0x1
        bool mute_voice_input;
        // offset: 0xd9e, bitSize: 0x1
        bool com_show_fps;
        // offset: 0xd9f, bitSize: 0x1
        bool relative_ads_fov;
        // offset: 0xda0, bitSize: 0x1
        bool input_autoAim;
        // offset: 0xda1, bitSize: 0x1
        bool cg_mature;
        // offset: 0xda2, bitSize: 0x1
        bool textchat_enable;
        // offset: 0xda3, bitSize: 0x1
        bool mantle_behaviour_ground_gpad;
        // offset: 0xda4, bitSize: 0x1
        bool com_show_gpu_temperature;
        // offset: 0xda5, bitSize: 0x1
        bool show_friends_notifications;
        // offset: 0xda6, bitSize: 0x1
        bool toggle_map_binding;
        // offset: 0xda7, bitSize: 0x1
        bool equipment_auto_hold_kbm;
        // offset: 0xda8, bitSize: 0x1
        bool show_compass;
        // offset: 0xda9, bitSize: 0x1
        bool toggle_ads_persistent_kbm;
        // offset: 0xdaa, bitSize: 0x1
        bool show_input_method;
        // offset: 0xdab, bitSize: 0x1
        bool windows_key_disable;
        // offset: 0xdac, bitSize: 0x1
        bool crossplay_enable;
        // offset: 0xdad, bitSize: 0x1
        bool mouse_smoothing;
        // offset: 0xdae, bitSize: 0x1
        bool auto_forward_sequence_enabled;
        // offset: 0xdaf, bitSize: 0x1
        bool colorblind_assist;
        // offset: 0xdb0, bitSize: 0x1
        bool hitmarkers_enable;
        // offset: 0xdb1, bitSize: 0x1
        bool toggle_ads_kbm;
        // offset: 0xdb2, bitSize: 0x1
        bool toggle_score_binding_gamepad;
        // offset: 0xdb3, bitSize: 0x1
        bool attack_vehicle_alternate_control_gpad;
        // offset: 0xdb4, bitSize: 0x1
        bool ping_double_tap_danger;
        // offset: 0xdb5, bitSize: 0x1
        bool warzoneInstantPickups;
        // offset: 0xdb6, bitSize: 0x1
        bool input_targetAssist;
        // offset: 0xdb7, bitSize: 0x1
        bool cg_subtitles;
        // offset: 0xdb8, bitSize: 0x1
        bool show_party_notifications;
        // offset: 0xdb9, bitSize: 0x1
        bool com_show_cpu_render_time;
        // offset: 0xdba, bitSize: 0x1
        bool doa_text_bubbles;
        // offset: 0xdbb, bitSize: 0x1
        bool incognitoOthers;
        // offset: 0xdbc, bitSize: 0x1
        bool snd_multiplayer_character_voice;
        // offset: 0xdbd, bitSize: 0x1
        bool rtx_console_feature_any;
        // offset: 0xdbe, bitSize: 0x1
        bool toggle_ads_gpad;
        // offset: 0xdbf, bitSize: 0x1
        bool show_advanced_options;
        // offset: 0xdc0, bitSize: 0x1
        bool doa_floating_damage;
        // offset: 0xdc1, bitSize: 0x1
        bool increase_zoom_shared_input;
        // offset: 0xdc2, bitSize: 0x1
        bool mute_voice_output;
        // offset: 0xdc3, bitSize: 0x1
        bool armor_plate_behavior_gpad;
        // offset: 0xdc4, bitSize: 0x1
        bool textchat_show_channel;
        // offset: 0xdc5, bitSize: 0x1
        bool toggle_inventory_binding;
        // offset: 0xdc6, bitSize: 0x1
        bool weapon_cycle_disable_wrap;
        // offset: 0xdc7, bitSize: 0x1
        bool out_of_ammo_auto_weapon_change;
        // offset: 0xdc8, bitSize: 0x1
        bool doa_crab_tutorial;
        // offset: 0xdc9, bitSize: 0x1
        bool toggle_walk;
        // offset: 0xdca, bitSize: 0x1
        bool textchat_show_timestamps;
        // offset: 0xdcb, bitSize: 0x1
        bool com_show_gpu_clock;
        // offset: 0xdcc, bitSize: 0x1
        bool helicopter_uses_chase_cam;
        // offset: 0xdcd, bitSize: 0x1
        bool interact_requires_hold;
        // offset: 0xdce, bitSize: 0x1
        bool mouse_ads_use_monitor_distance;
        // offset: 0xdcf, bitSize: 0x1
        bool sprint_cancel_reload_toggle_kbm;
        // offset: 0xdd0, bitSize: 0x1
        bool demo_toggleGameHud;
        // offset: 0xdd1, bitSize: 0x1
        bool english_vo;
        // offset: 0xdd2, bitSize: 0x1
        bool flipped_control_config;
        // offset: 0xdd3, bitSize: 0x1
        bool snd_mute_master_volume;
        // offset: 0xdd4, bitSize: 0x1
        bool snd_scale_when_speaking_enabled;
        // offset: 0xdd5, bitSize: 0x1
        bool gpad_rumble;
        // offset: 0xdd6, bitSize: 0x1
        bool launch_settings;
        // offset: 0xdd7, bitSize: 0x1
        bool snd_voicechat_open_mic;
        // offset: 0xdd8, bitSize: 0x1
        bool show_real_names;
        // offset: 0xdd9, bitSize: 0x1
        bool zm_cartoonMode;
        // offset: 0xdda, bitSize: 0x1
        bool zm_damage_numbers;
        // offset: 0xddb, bitSize: 0x1
        bool mute_all_but_party;
        // offset: 0xddc, bitSize: 0x1
        bool cg_drawCrosshair3D;
        // offset: 0xddd, bitSize: 0x1
        bool toggle_steady_aim_gpad;
    };

    // bitSize: 0x10, members: 1
    struct KeyBind {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        uint:8 keys[2];
    };

    // idx 0x0 members: 0x8 type: 0
    enum outfitParts_e {
        arms, // 0x0
        decals, // 0x1
        head, // 0x2
        headgear, // 0x3
        legs, // 0x4
        palette, // 0x5
        torso, // 0x6
        war_paint // 0x7
    };

    // idx 0x1 members: 0x3 type: 0
    enum jumpKitParts_e {
        parachute, // 0x0
        trail, // 0x1
        wingsuit // 0x2
    };

    // idx 0x2 members: 0xc6 type: 0
    enum WristAccessories {
        wristaccessory_default, // 0x0
        wristaccessory_t9_esports_empire_ms, // 0x1
        wristaccessory_t9_esports_empire_pc, // 0x2
        wristaccessory_t9_esports_empire_sy, // 0x3
        wristaccessory_t9_esports_faze_ms, // 0x4
        wristaccessory_t9_esports_faze_pc, // 0x5
        wristaccessory_t9_esports_faze_sy, // 0x6
        wristaccessory_t9_esports_guerillas_ms, // 0x7
        wristaccessory_t9_esports_guerillas_pc, // 0x8
        wristaccessory_t9_esports_guerillas_sy, // 0x9
        wristaccessory_t9_esports_legion_ms, // 0xa
        wristaccessory_t9_esports_legion_pc, // 0xb
        wristaccessory_t9_esports_legion_sy, // 0xc
        wristaccessory_t9_esports_mutineers_ms, // 0xd
        wristaccessory_t9_esports_mutineers_pc, // 0xe
        wristaccessory_t9_esports_mutineers_sy, // 0xf
        wristaccessory_t9_esports_optic_ms, // 0x10
        wristaccessory_t9_esports_optic_pc, // 0x11
        wristaccessory_t9_esports_optic_sy, // 0x12
        wristaccessory_t9_esports_rokkr_ms, // 0x13
        wristaccessory_t9_esports_rokkr_pc, // 0x14
        wristaccessory_t9_esports_rokkr_sy, // 0x15
        wristaccessory_t9_esports_royalravens_ms, // 0x16
        wristaccessory_t9_esports_royalravens_pc, // 0x17
        wristaccessory_t9_esports_royalravens_sy, // 0x18
        wristaccessory_t9_esports_subliners_ms, // 0x19
        wristaccessory_t9_esports_subliners_pc, // 0x1a
        wristaccessory_t9_esports_subliners_sy, // 0x1b
        wristaccessory_t9_esports_surge_ms, // 0x1c
        wristaccessory_t9_esports_surge_pc, // 0x1d
        wristaccessory_t9_esports_surge_sy, // 0x1e
        wristaccessory_t9_esports_thieves_ms, // 0x1f
        wristaccessory_t9_esports_thieves_pc, // 0x20
        wristaccessory_t9_esports_thieves_sy, // 0x21
        wristaccessory_t9_esports_ultra_ms, // 0x22
        wristaccessory_t9_esports_ultra_pc, // 0x23
        wristaccessory_t9_esports_ultra_sy, // 0x24
        wristaccessory_t9_s1_analog_aviator_02, // 0x25
        wristaccessory_t9_s1_analog_aviator_x2, // 0x26
        wristaccessory_t9_s1_analog_bope_01, // 0x27
        wristaccessory_t9_s1_analog_brawler_01, // 0x28
        wristaccessory_t9_s1_analog_fancy, // 0x29
        wristaccessory_t9_s1_analog_fancy_debt_collector, // 0x2a
        wristaccessory_t9_s1_analog_fancy_gold, // 0x2b
        wristaccessory_t9_s1_analog_horex_01, // 0x2c
        wristaccessory_t9_s1_analog_kremlin, // 0x2d
        wristaccessory_t9_s1_analog_origin_01, // 0x2e
        wristaccessory_t9_s1_analog_private_eye_01, // 0x2f
        wristaccessory_t9_s1_analog_private_eye_02, // 0x30
        wristaccessory_t9_s1_analog_private_eye_03, // 0x31
        wristaccessory_t9_s1_analog_retroren_01, // 0x32
        wristaccessory_t9_s1_analog_retroren_02, // 0x33
        wristaccessory_t9_s1_analog_retroren_03, // 0x34
        wristaccessory_t9_s1_bracelet_01, // 0x35
        wristaccessory_t9_s1_bracelet_braided_02, // 0x36
        wristaccessory_t9_s1_bracelet_gold_chain_01, // 0x37
        wristaccessory_t9_s1_bracelet_skull_01, // 0x38
        wristaccessory_t9_s1_digital_compass_01, // 0x39
        wristaccessory_t9_s1_digital_diver, // 0x3a
        wristaccessory_t9_s1_digital_dutybot_01, // 0x3b
        wristaccessory_t9_s1_digital_first_spy_01, // 0x3c
        wristaccessory_t9_s1_digital_gambit_01, // 0x3d
        wristaccessory_t9_s1_digital_gaudy_01, // 0x3e
        wristaccessory_t9_s1_digital_inteculo_01, // 0x3f
        wristaccessory_t9_s1_digital_kazuya_01, // 0x40
        wristaccessory_t9_s1_digital_rank_01, // 0x41
        wristaccessory_t9_s1_digital_rank_penumbra_sy, // 0x42
        wristaccessory_t9_s1_digital_trak_pro_01, // 0x43
        wristaccessory_t9_s1_digital_zm_heart_rate_01, // 0x44
        wristaccessory_t9_s1_digital_zm_heart_rate_black_02, // 0x45
        wristaccessory_t9_s1_digital_zm_heart_rate_gold_01, // 0x46
        wristaccessory_t9_s2_analog_420, // 0x47
        wristaccessory_t9_s2_analog_black_gold, // 0x48
        wristaccessory_t9_s2_analog_black_silver, // 0x49
        wristaccessory_t9_s2_analog_black_tiger, // 0x4a
        wristaccessory_t9_s2_analog_broken_fancy, // 0x4b
        wristaccessory_t9_s2_analog_caiman, // 0x4c
        wristaccessory_t9_s2_analog_cold_hearted, // 0x4d
        wristaccessory_t9_s2_analog_dark_aether, // 0x4e
        wristaccessory_t9_s2_analog_jungle_aviator, // 0x4f
        wristaccessory_t9_s2_analog_mayan, // 0x50
        wristaccessory_t9_s2_analog_mortal, // 0x51
        wristaccessory_t9_s2_analog_naval_warfare, // 0x52
        wristaccessory_t9_s2_analog_necro_king, // 0x53
        wristaccessory_t9_s2_analog_paratroop, // 0x54
        wristaccessory_t9_s2_analog_rebel, // 0x55
        wristaccessory_t9_s2_analog_white_tiger, // 0x56
        wristaccessory_t9_s2_bracelet_lure, // 0x57
        wristaccessory_t9_s2_bracelet_mardi_gras, // 0x58
        wristaccessory_t9_s2_digital_jade, // 0x59
        wristaccessory_t9_s2_digital_mayan, // 0x5a
        wristaccessory_t9_s2_digital_mini_map, // 0x5b
        wristaccessory_t9_s2_digital_mini_map_hot_rod, // 0x5c
        wristaccessory_t9_s2_digital_river_slasher, // 0x5d
        wristaccessory_t9_s2_digital_sforce, // 0x5e
        wristaccessory_t9_s3_analog_chrono_sea, // 0x5f
        wristaccessory_t9_s3_analog_mctag, // 0x60
        wristaccessory_t9_s3_analog_nuclear_fallout, // 0x61
        wristaccessory_t9_s3_analog_rebel_fighter_sy, // 0x62
        wristaccessory_t9_s3_analog_winter_ash, // 0x63
        wristaccessory_t9_s3_analog_zombie_naga, // 0x64
        wristaccessory_t9_s3_bracelet_01, // 0x65
        wristaccessory_t9_s3_digital_big_joke, // 0x66
        wristaccessory_t9_s3_digital_death_touch, // 0x67
        wristaccessory_t9_s3_digital_diver_wargames, // 0x68
        wristaccessory_t9_s3_digital_heart_rate_alien, // 0x69
        wristaccessory_t9_s3_digital_inteculo_spycraft, // 0x6a
        wristaccessory_t9_s3_digital_inteculo_w_fallout, // 0x6b
        wristaccessory_t9_s3_digital_magic8, // 0x6c
        wristaccessory_t9_s3_digital_nuclear_fallout, // 0x6d
        wristaccessory_t9_s3_digital_radiation, // 0x6e
        wristaccessory_t9_s3_digital_rank_winter_fallout, // 0x6f
        wristaccessory_t9_s3_digital_ultrafunk, // 0x70
        wristaccessory_t9_s4_analog_assassin, // 0x71
        wristaccessory_t9_s4_analog_fire_storm, // 0x72
        wristaccessory_t9_s4_analog_future_soldier, // 0x73
        wristaccessory_t9_s4_analog_horror, // 0x74
        wristaccessory_t9_s4_analog_jefe, // 0x75
        wristaccessory_t9_s4_analog_rbear, // 0x76
        wristaccessory_t9_s4_analog_roadwar, // 0x77
        wristaccessory_t9_s4_analog_sleek_assassin, // 0x78
        wristaccessory_t9_s4_analog_sleek_assassin_endgame, // 0x79
        wristaccessory_t9_s4_analog_spaceship, // 0x7a
        wristaccessory_t9_s4_analog_wasteland, // 0x7b
        wristaccessory_t9_s4_bracelet_leather_studd, // 0x7c
        wristaccessory_t9_s4_bracelet_weathered, // 0x7d
        wristaccessory_t9_s4_digital_big_joke, // 0x7e
        wristaccessory_t9_s4_digital_blade, // 0x7f
        wristaccessory_t9_s4_digital_evil, // 0x80
        wristaccessory_t9_s4_digital_holographic, // 0x81
        wristaccessory_t9_s4_digital_roadwarrior, // 0x82
        wristaccessory_t9_s4_digital_royal_decree, // 0x83
        wristaccessory_t9_s4_holographic_rank, // 0x84
        wristaccessory_t9_s4_holographic_rank_cyber, // 0x85
        wristaccessory_t9_s5_analog_beer_o_clock, // 0x86
        wristaccessory_t9_s5_analog_blood_fancy, // 0x87
        wristaccessory_t9_s5_analog_classic, // 0x88
        wristaccessory_t9_s5_analog_demon, // 0x89
        wristaccessory_t9_s5_analog_dis_assassin, // 0x8a
        wristaccessory_t9_s5_analog_egy_burial, // 0x8b
        wristaccessory_t9_s5_analog_hacking_code, // 0x8c
        wristaccessory_t9_s5_analog_holographic, // 0x8d
        wristaccessory_t9_s5_analog_no_numbers, // 0x8e
        wristaccessory_t9_s5_analog_onyx_sy, // 0x8f
        wristaccessory_t9_s5_analog_rainbow_jewel, // 0x90
        wristaccessory_t9_s5_analog_retrotac, // 0x91
        wristaccessory_t9_s5_analog_riptide, // 0x92
        wristaccessory_t9_s5_bracelet_sliver_chain, // 0x93
        wristaccessory_t9_s5_digital_arabian, // 0x94
        wristaccessory_t9_s5_digital_checkmate, // 0x95
        wristaccessory_t9_s5_digital_critical_kill, // 0x96
        wristaccessory_t9_s5_digital_dark_weaver, // 0x97
        wristaccessory_t9_s5_digital_ghosted, // 0x98
        wristaccessory_t9_s5_digital_judge_d, // 0x99
        wristaccessory_t9_s5_digital_mummy_cat, // 0x9a
        wristaccessory_t9_s5_digital_rank_countdwn, // 0x9b
        wristaccessory_t9_s5_digital_tagger, // 0x9c
        wristaccessory_t9_s5_digital_wonderland, // 0x9d
        wristaccessory_t9_s6_analog_agony, // 0x9e
        wristaccessory_t9_s6_analog_big_joke4_ms, // 0x9f
        wristaccessory_t9_s6_analog_big_joke4_pc, // 0xa0
        wristaccessory_t9_s6_analog_big_joke4_solo, // 0xa1
        wristaccessory_t9_s6_analog_big_joke4_sy, // 0xa2
        wristaccessory_t9_s6_analog_bite_me, // 0xa3
        wristaccessory_t9_s6_analog_blue_chroma, // 0xa4
        wristaccessory_t9_s6_analog_bog_ops, // 0xa5
        wristaccessory_t9_s6_analog_camo, // 0xa6
        wristaccessory_t9_s6_analog_cyber_venom, // 0xa7
        wristaccessory_t9_s6_analog_donnie, // 0xa8
        wristaccessory_t9_s6_analog_edutain, // 0xa9
        wristaccessory_t9_s6_analog_gilded, // 0xaa
        wristaccessory_t9_s6_analog_halloween, // 0xab
        wristaccessory_t9_s6_analog_hypnosis, // 0xac
        wristaccessory_t9_s6_analog_krieger, // 0xad
        wristaccessory_t9_s6_analog_scrapyard, // 0xae
        wristaccessory_t9_s6_analog_scream, // 0xaf
        wristaccessory_t9_s6_analog_street_mech_sy, // 0xb0
        wristaccessory_t9_s6_digital_atomic_ash, // 0xb1
        wristaccessory_t9_s6_digital_compass_stitch, // 0xb2
        wristaccessory_t9_s6_digital_egyptian_fire, // 0xb3
        wristaccessory_t9_s6_digital_endgame, // 0xb4
        wristaccessory_t9_s6_digital_frost, // 0xb5
        wristaccessory_t9_s6_digital_gov1, // 0xb6
        wristaccessory_t9_s6_digital_gov2, // 0xb7
        wristaccessory_t9_s6_digital_nightmare_fuel, // 0xb8
        wristaccessory_t9_s6_digital_rank_carnival, // 0xb9
        wristaccessory_t9_s6_digital_reaper_bunny, // 0xba
        wristaccessory_t9_s6_digital_sultan, // 0xbb
        wristaccessory_t9_s6_digital_tagger_ms, // 0xbc
        wristaccessory_t9_s6_digital_tagger_pc, // 0xbd
        wristaccessory_t9_s6_digital_tagger_solo, // 0xbe
        wristaccessory_t9_s6_digital_tagger_sy, // 0xbf
        wristaccessory_t9_s6_digital_undead_magic, // 0xc0
        wristaccessory_t9_s6_digital_undead_warrior, // 0xc1
        wristaccessory_t9_s6_digital_ww, // 0xc2
        wristaccessory_t9_s6_digital_zm_critical_kill, // 0xc3
        wristaccessory_test1, // 0xc4
        wristaccessory_test2 // 0xc5
    };

    // idx 0x3 members: 0x92 type: 0
    enum Executions {
        execution_004, // 0x0
        execution_001, // 0x1
        execution_002, // 0x2
        execution_003, // 0x3
        execution_005, // 0x4
        execution_007, // 0x5
        execution_008, // 0x6
        execution_009, // 0x7
        execution_010, // 0x8
        execution_013, // 0x9
        execution_014, // 0xa
        execution_015, // 0xb
        execution_016, // 0xc
        execution_017, // 0xd
        execution_018, // 0xe
        execution_020, // 0xf
        execution_021, // 0x10
        execution_022, // 0x11
        execution_023, // 0x12
        execution_024, // 0x13
        execution_025, // 0x14
        execution_026, // 0x15
        execution_027, // 0x16
        execution_028, // 0x17
        execution_029, // 0x18
        execution_030, // 0x19
        execution_031, // 0x1a
        execution_032, // 0x1b
        execution_033, // 0x1c
        execution_034, // 0x1d
        execution_036, // 0x1e
        execution_037, // 0x1f
        execution_037r, // 0x20
        execution_038, // 0x21
        execution_038r, // 0x22
        execution_039bc, // 0x23
        execution_040, // 0x24
        execution_040bc, // 0x25
        execution_042, // 0x26
        execution_043, // 0x27
        execution_045, // 0x28
        execution_046, // 0x29
        execution_048, // 0x2a
        execution_049, // 0x2b
        execution_051, // 0x2c
        execution_052, // 0x2d
        execution_058, // 0x2e
        execution_059, // 0x2f
        execution_061, // 0x30
        execution_062, // 0x31
        execution_063, // 0x32
        execution_064, // 0x33
        execution_065, // 0x34
        execution_066, // 0x35
        execution_067, // 0x36
        execution_068, // 0x37
        execution_069, // 0x38
        execution_070, // 0x39
        execution_074, // 0x3a
        execution_075, // 0x3b
        execution_078, // 0x3c
        execution_080, // 0x3d
        execution_081, // 0x3e
        execution_082, // 0x3f
        execution_083, // 0x40
        execution_084, // 0x41
        execution_086, // 0x42
        execution_087, // 0x43
        execution_088, // 0x44
        execution_089, // 0x45
        execution_096, // 0x46
        execution_097, // 0x47
        execution_098, // 0x48
        execution_099, // 0x49
        execution_100, // 0x4a
        execution_101, // 0x4b
        execution_108, // 0x4c
        execution_110, // 0x4d
        execution_111, // 0x4e
        execution_112, // 0x4f
        execution_113, // 0x50
        execution_117, // 0x51
        execution_118, // 0x52
        execution_119, // 0x53
        execution_120, // 0x54
        execution_121, // 0x55
        execution_123, // 0x56
        execution_124, // 0x57
        execution_125, // 0x58
        execution_126, // 0x59
        execution_127, // 0x5a
        execution_128, // 0x5b
        execution_129, // 0x5c
        execution_130, // 0x5d
        execution_131, // 0x5e
        execution_132, // 0x5f
        execution_133, // 0x60
        execution_134, // 0x61
        execution_135, // 0x62
        execution_136, // 0x63
        execution_137, // 0x64
        execution_138, // 0x65
        execution_139, // 0x66
        execution_140, // 0x67
        execution_141, // 0x68
        execution_142, // 0x69
        execution_143, // 0x6a
        execution_144, // 0x6b
        execution_145, // 0x6c
        execution_146, // 0x6d
        execution_147, // 0x6e
        execution_148, // 0x6f
        execution_149, // 0x70
        execution_150, // 0x71
        execution_152, // 0x72
        execution_154, // 0x73
        execution_157, // 0x74
        execution_158, // 0x75
        execution_159, // 0x76
        execution_160, // 0x77
        execution_161, // 0x78
        execution_162, // 0x79
        execution_163, // 0x7a
        execution_166, // 0x7b
        execution_171, // 0x7c
        execution_172, // 0x7d
        execution_173, // 0x7e
        execution_174, // 0x7f
        execution_176, // 0x80
        execution_181, // 0x81
        execution_182, // 0x82
        execution_194, // 0x83
        execution_196, // 0x84
        execution_198, // 0x85
        execution_199, // 0x86
        execution_201, // 0x87
        execution_202, // 0x88
        execution_203, // 0x89
        execution_204, // 0x8a
        execution_205, // 0x8b
        execution_206, // 0x8c
        execution_207, // 0x8d
        execution_208, // 0x8e
        execution_209, // 0x8f
        execution_210, // 0x90
        execution_211 // 0x91
    };

    // idx 0x4 members: 0xf2 type: 0
    enum Action {
        attack, // 0x0
        melee, // 0x1
        frag, // 0x2
        smoke, // 0x3
        breath_sprint, // 0x4
        usereload, // 0x5
        speed_throw, // 0x6
        actionslot1, // 0x7
        actionslot2, // 0x8
        actionslot3, // 0x9
        actionslot4, // 0xa
        actionslot5, // 0xb
        actionslot6, // 0xc
        actionslot7, // 0xd
        stance, // 0xe
        gostand, // 0xf
        adsstand, // 0x10
        specnext, // 0x11
        specprev, // 0x12
        togglespec, // 0x13
        melee_zoom, // 0x14
        changezoom, // 0x15
        weapnextinventory, // 0x16
        vehicleads, // 0x17
        gas, // 0x18
        reverse, // 0x19
        vehiclemoveleft, // 0x1a
        vehiclemoveright, // 0x1b
        handbrake, // 0x1c
        vehicleattack, // 0x1d
        vehiclesecondattack, // 0x1e
        vehicleboost, // 0x1f
        vehiclejump, // 0x20
        vehiclemoveup, // 0x21
        vehiclemovedown, // 0x22
        vehicleswitchseat, // 0x23
        vehicleseat1, // 0x24
        vehicleseat2, // 0x25
        vehicleseat3, // 0x26
        vehicleseat4, // 0x27
        vehicleseat5, // 0x28
        vehiclehorn, // 0x29
        vehicleability, // 0x2a
        vehiclelookforward, // 0x2b
        vehiclelookback, // 0x2c
        vehiclealtcontrol, // 0x2d
        vehiclefreelook, // 0x2e
        walk, // 0x2f
        forward, // 0x30
        back, // 0x31
        moveleft, // 0x32
        moveright, // 0x33
        movedown, // 0x34
        left, // 0x35
        right, // 0x36
        lookup, // 0x37
        lookdown, // 0x38
        strafe, // 0x39
        holdbreath, // 0x3a
        activate, // 0x3b
        reload, // 0x3c
        prone, // 0x3d
        mlook, // 0x3e
        sprint, // 0x3f
        scores, // 0x40
        map, // 0x41
        inventory, // 0x42
        inventoryzm, // 0x43
        scoreswz, // 0x44
        spraygesturewheel, // 0x45
        leanleft, // 0x46
        leanright, // 0x47
        weapoffhandspecial, // 0x48
        weapswitchhero, // 0x49
        raisestance, // 0x4a
        raisestancejump, // 0x4b
        lowerstance, // 0x4c
        mantle, // 0x4d
        armorrepair, // 0x4e
        centerview, // 0x4f
        zoomin, // 0x50
        zoomout, // 0x51
        battletrack_toggle, // 0x52
        battletrack_next, // 0x53
        cameraup, // 0x54
        cameradown, // 0x55
        freecampresetshift, // 0x56
        freecamfovincrease, // 0x57
        freecamfovdecrease, // 0x58
        cameraslowdown, // 0x59
        cameraspeedup, // 0x5a
        codcastercombokey, // 0x5b
        ping, // 0x5c
        callforhelp, // 0x5d
        equip_toggle_actionslot3, // 0x5e
        equip_toggle_throw, // 0x5f
        bind_drop_item_wz, // 0x60
        talk, // 0x61
        talk_in_private_channel, // 0x62
        donate_life, // 0x63
        flashlight, // 0x64
        camera_side, // 0x65
        codcasterZoomIn, // 0x66
        codcasterZoomOut, // 0x67
        codcasterForward, // 0x68
        codcasterBack, // 0x69
        codcasterMoveLeft, // 0x6a
        codcasterMoveRight, // 0x6b
        togglemenu, // 0x6c
        screenshotjpeg, // 0x6d
        screenshotpng, // 0x6e
        ui_opensocial, // 0x6f
        ui_opensettings, // 0x70
        ui_openstore, // 0x71
        ui_openfriends, // 0x72
        ui_openplayeraccount, // 0x73
        ui_muteall, // 0x74
        ui_mutevoice, // 0x75
        ui_mutevoiceinput, // 0x76
        ui_mutevoiceoutput, // 0x77
        ui_navup, // 0x78
        ui_navdown, // 0x79
        ui_navleft, // 0x7a
        ui_navright, // 0x7b
        ui_prevtab, // 0x7c
        ui_nexttab, // 0x7d
        ui_remove, // 0x7e
        ui_confirm, // 0x7f
        ui_acceptinvite, // 0x80
        ui_declineinvite, // 0x81
        ui_contextual1, // 0x82
        ui_contextual2, // 0x83
        ui_contextual3, // 0x84
        ui_contextual4, // 0x85
        ui_contextual5, // 0x86
        ui_contextual6, // 0x87
        ui_contextual7, // 0x88
        ui_contextual8, // 0x89
        chatmodelast, // 0x8a
        chatmodeparty, // 0x8b
        chatmodepublic, // 0x8c
        chatmodeteam, // 0x8d
        chatmodenext, // 0x8e
        chooseclass, // 0x8f
        chooseclass1, // 0x90
        chooseclass2, // 0x91
        chooseclass3, // 0x92
        chooseclass4, // 0x93
        chooseclass5, // 0x94
        chooseclass6, // 0x95
        chooseclass7, // 0x96
        chooseclass8, // 0x97
        chooseclass9, // 0x98
        chooseclass10, // 0x99
        chooseclass11, // 0x9a
        chooseclass12, // 0x9b
        toggleaerialcam, // 0x9c
        toggleaerialtether, // 0x9d
        toggleaerialrecenter, // 0x9e
        toggleaerialcentral, // 0x9f
        toggleaerialnearestplayerfocus, // 0xa0
        freecampreset1, // 0xa1
        freecampreset2, // 0xa2
        freecampreset3, // 0xa3
        freecampreset4, // 0xa4
        freecampreset5, // 0xa5
        freecampreset6, // 0xa6
        freecampreset7, // 0xa7
        freecampreset8, // 0xa8
        freecampreset9, // 0xa9
        freecampreset10, // 0xaa
        togglefreecam, // 0xab
        freecamfovreset, // 0xac
        toggleorbitalcamera, // 0xad
        togglefreecamhorizontalplane, // 0xae
        togglefreecamcollisions, // 0xaf
        codcaster_switchteamlisttype, // 0xb0
        codcaster_highlightprev, // 0xb1
        codcaster_highlightnext, // 0xb2
        codcaster_spectatehighlighted, // 0xb3
        codcaster_spectateplayer1, // 0xb4
        codcaster_spectateplayer2, // 0xb5
        codcaster_spectateplayer3, // 0xb6
        codcaster_spectateplayer4, // 0xb7
        codcaster_spectateplayer5, // 0xb8
        codcaster_spectateplayer6, // 0xb9
        codcaster_spectateplayer7, // 0xba
        codcaster_spectateplayer8, // 0xbb
        codcaster_spectateplayer9, // 0xbc
        codcaster_spectateplayer10, // 0xbd
        codcaster_togglescorestreakview, // 0xbe
        codcaster_togglefieldupgradeview, // 0xbf
        codcaster_togglexrays, // 0xc0
        codcaster_toggleminimap, // 0xc1
        codcaster_togglefullscreenmap, // 0xc2
        codcaster_toggledataview, // 0xc3
        codcaster_togglehud, // 0xc4
        codcaster_toggle_pauseresume, // 0xc5
        codcaster_opencodcasteroptions, // 0xc6
        autorun, // 0xc7
        weapnext, // 0xc8
        pause, // 0xc9
        inventory_weapon, // 0xca
        weapprev, // 0xcb
        togglebreath, // 0xcc
        slide, // 0xcd
        toggleads, // 0xce
        leaveads, // 0xcf
        voteyes, // 0xd0
        voteno, // 0xd1
        quickspray, // 0xd2
        dangerpingcallout, // 0xd3
        quickcycle_health, // 0xd4
        quickcycle_equipment, // 0xd5
        skip, // 0xd6
        scorestreak1, // 0xd7
        scorestreak2, // 0xd8
        scorestreak3, // 0xd9
        scorestreak4, // 0xda
        scorestreak_current, // 0xdb
        flourish, // 0xdc
        usebgb1, // 0xdd
        usebgb2, // 0xde
        usebgb3, // 0xdf
        usebgb4, // 0xe0
        quickconsume0, // 0xe1
        quickconsume1, // 0xe2
        fullloadout, // 0xe3
        weapswitchprimary, // 0xe4
        weapswitchsecondary, // 0xe5
        scorestreak_zm, // 0xe6
        scorestreak_wz, // 0xe7
        zm_vote_accept, // 0xe8
        zm_vote_decline, // 0xe9
        callout1, // 0xea
        callout2, // 0xeb
        callout3, // 0xec
        callout4, // 0xed
        callout5, // 0xee
        callout6, // 0xef
        callout7, // 0xf0
        switch_weap_mode // 0xf1
    };

    // idx 0x5 members: 0x98 type: 0
    enum MusicTracks {
        battletrack_bo1_115, // 0x0
        battletrack_bo1_damned, // 0x1
        battletrack_bo1_pentagon, // 0x2
        battletrack_bo1_rooftops, // 0x3
        battletrack_bo2_adrenaline, // 0x4
        battletrack_bo2_damned100ae, // 0x5
        battletrack_bo2_maintheme, // 0x6
        battletrack_bo2_shadows, // 0x7
        battletrack_bo3_damned3, // 0x8
        battletrack_bo3_filter, // 0x9
        battletrack_bo3_ignition, // 0xa
        battletrack_bo3_ilive, // 0xb
        battletrack_bo4_alistair, // 0xc
        battletrack_bo4_damned4, // 0xd
        battletrack_bo4_inferno, // 0xe
        battletrack_bo4_reflections, // 0xf
        battletrack_cdl_theme, // 0x10
        battletrack_season1_80shiphop_1, // 0x11
        battletrack_season1_80shiphop_2, // 0x12
        battletrack_season1_80shiphop_3, // 0x13
        battletrack_season1_80shits_1, // 0x14
        battletrack_season1_80shits_2, // 0x15
        battletrack_season1_80shits_3, // 0x16
        battletrack_season1_80srock_1, // 0x17
        battletrack_season1_80srock_2, // 0x18
        battletrack_season1_80srock_3, // 0x19
        battletrack_season2_80spop2_1, // 0x1a
        battletrack_season2_80spop2_2, // 0x1b
        battletrack_season2_80spop2_3, // 0x1c
        battletrack_season2_80spop3_1, // 0x1d
        battletrack_season2_80spop3_2, // 0x1e
        battletrack_season2_80spop3_3, // 0x1f
        battletrack_season2_80spop_1, // 0x20
        battletrack_season2_80spop_2, // 0x21
        battletrack_season2_80spop_3, // 0x22
        battletrack_season2_80srock2_1, // 0x23
        battletrack_season2_80srock2_2, // 0x24
        battletrack_season2_80srock2_3, // 0x25
        battletrack_season4_80shits2_1, // 0x26
        battletrack_season4_80shits2_2, // 0x27
        battletrack_season4_80shits2_3, // 0x28
        battletrack_season5_80shits3_1, // 0x29
        battletrack_season5_80shits3_2, // 0x2a
        battletrack_season5_80shits3_3, // 0x2b
        battletrack_trey_classified, // 0x2c
        battletrack_trey_farid, // 0x2d
        battletrack_trey_revenge, // 0x2e
        battletrack_trey_sandcastle, // 0x2f
        battletrack_waw_blackcats, // 0x30
        battletrack_waw_dogfire, // 0x31
        battletrack_waw_hellsgate, // 0x32
        battletrack_waw_wildcard, // 0x33
        musictrack_cp_amerika_1, // 0x34
        musictrack_cp_amerika_2, // 0x35
        musictrack_cp_amerika_3, // 0x36
        musictrack_cp_amerika_4, // 0x37
        musictrack_cp_amerika_5, // 0x38
        musictrack_cp_armada_1, // 0x39
        musictrack_cp_armada_2, // 0x3a
        musictrack_cp_armada_3, // 0x3b
        musictrack_cp_armada_4, // 0x3c
        musictrack_cp_armada_5, // 0x3d
        musictrack_cp_cuba_1, // 0x3e
        musictrack_cp_cuba_2, // 0x3f
        musictrack_cp_cuba_3, // 0x40
        musictrack_cp_cuba_4, // 0x41
        musictrack_cp_cuba_5, // 0x42
        musictrack_cp_duga_1, // 0x43
        musictrack_cp_duga_2, // 0x44
        musictrack_cp_kgb_1, // 0x45
        musictrack_cp_kgb_2, // 0x46
        musictrack_cp_kgb_3, // 0x47
        musictrack_cp_kgb_4, // 0x48
        musictrack_cp_kgb_5, // 0x49
        musictrack_cp_kgb_6, // 0x4a
        musictrack_cp_prisoner_1, // 0x4b
        musictrack_cp_prisoner_2, // 0x4c
        musictrack_cp_prisoner_3, // 0x4d
        musictrack_cp_prisoner_4, // 0x4e
        musictrack_cp_prisoner_5, // 0x4f
        musictrack_cp_prisoner_6, // 0x50
        musictrack_cp_siege_1, // 0x51
        musictrack_cp_siege_2, // 0x52
        musictrack_cp_stakeout_1, // 0x53
        musictrack_cp_stakeout_2, // 0x54
        musictrack_cp_stakeout_3, // 0x55
        musictrack_cp_stakeout_4, // 0x56
        musictrack_cp_takedown_1, // 0x57
        musictrack_cp_takedown_2, // 0x58
        musictrack_cp_takedown_3, // 0x59
        musictrack_cp_takedown_4, // 0x5a
        musictrack_cp_takedown_5, // 0x5b
        musictrack_cp_takedown_6, // 0x5c
        musictrack_cp_takedown_7, // 0x5d
        musictrack_cp_yamantau_1, // 0x5e
        musictrack_cp_yamantau_2, // 0x5f
        musictrack_cp_yamantau_3, // 0x60
        musictrack_cp_yamantau_4, // 0x61
        musictrack_cp_yamantau_5, // 0x62
        musictrack_doa_1, // 0x63
        musictrack_doa_10, // 0x64
        musictrack_doa_11, // 0x65
        musictrack_doa_12, // 0x66
        musictrack_doa_13, // 0x67
        musictrack_doa_14, // 0x68
        musictrack_doa_15, // 0x69
        musictrack_doa_16, // 0x6a
        musictrack_doa_17, // 0x6b
        musictrack_doa_18, // 0x6c
        musictrack_doa_19, // 0x6d
        musictrack_doa_2, // 0x6e
        musictrack_doa_3, // 0x6f
        musictrack_doa_4, // 0x70
        musictrack_doa_5, // 0x71
        musictrack_doa_6, // 0x72
        musictrack_doa_7, // 0x73
        musictrack_doa_8, // 0x74
        musictrack_doa_9, // 0x75
        musictrack_mp_nuketown_ee, // 0x76
        musictrack_mp_underscore_1, // 0x77
        musictrack_mp_underscore_2, // 0x78
        musictrack_mp_underscore_3, // 0x79
        musictrack_mp_underscore_4, // 0x7a
        musictrack_sr_abra, // 0x7b
        musictrack_sr_aminfil, // 0x7c
        musictrack_sr_avogadro, // 0x7d
        musictrack_sr_boa, // 0x7e
        musictrack_sr_brave, // 0x7f
        musictrack_sr_frequency, // 0x80
        musictrack_sr_generation, // 0x81
        musictrack_sr_lullaby, // 0x82
        musictrack_sr_pareidolia, // 0x83
        musictrack_sr_theone, // 0x84
        musictrack_sr_tribes, // 0x85
        musictrack_theme_campaign, // 0x86
        musictrack_theme_multiplayer, // 0x87
        musictrack_theme_multiplayer_blops1, // 0x88
        musictrack_theme_multiplayer_blops2, // 0x89
        musictrack_theme_multiplayer_blops3, // 0x8a
        musictrack_theme_multiplayer_blops4, // 0x8b
        musictrack_theme_titlescreen, // 0x8c
        musictrack_theme_titlescreen2, // 0x8d
        musictrack_theme_zombies, // 0x8e
        musictrack_zm_gold_ee, // 0x8f
        musictrack_zm_platinum_acidbunny, // 0x90
        musictrack_zm_platinum_berlin, // 0x91
        musictrack_zm_platinum_ee, // 0x92
        musictrack_zm_platinum_whatawaits, // 0x93
        musictrack_zm_platinum_wrath, // 0x94
        musictrack_zm_silver_ee, // 0x95
        musictrack_zm_tungsten_dystopia, // 0x96
        musictrack_zm_tungsten_ee // 0x97
    };

    // idx 0x6 members: 0x4 type: 0
    enum ProgressionMusicTracks {
        musictrack_theme_multiplayer_blops1, // 0x0
        musictrack_theme_multiplayer_blops2, // 0x1
        musictrack_theme_multiplayer_blops3, // 0x2
        musictrack_theme_multiplayer_blops4 // 0x3
    };

    // idx 0x7 members: 0x2 type: 0
    enum SuperFactions {
        superfaction_nato, // 0x0
        superfaction_warsaw_pact // 0x1
    };

    // idx 0x8 members: 0x15 type: 0
    enum cp_character_customization {
        prt_t9_cp_female_player, // 0x0
        prt_t9_cp_female_player_amerikatown, // 0x1
        prt_t9_cp_female_player_armada, // 0x2
        prt_t9_cp_female_player_duga, // 0x3
        prt_t9_cp_female_player_kgb, // 0x4
        prt_t9_cp_female_player_prisoner, // 0x5
        prt_t9_cp_female_player_revolucion, // 0x6
        prt_t9_cp_female_player_safehouse, // 0x7
        prt_t9_cp_female_player_siege, // 0x8
        prt_t9_cp_female_player_stakeout, // 0x9
        prt_t9_cp_male_player, // 0xa
        prt_t9_cp_male_player_amerikatown, // 0xb
        prt_t9_cp_male_player_armada, // 0xc
        prt_t9_cp_male_player_duga, // 0xd
        prt_t9_cp_male_player_kgb, // 0xe
        prt_t9_cp_male_player_prisoner, // 0xf
        prt_t9_cp_male_player_revolucion, // 0x10
        prt_t9_cp_male_player_safehouse, // 0x11
        prt_t9_cp_male_player_siege, // 0x12
        prt_t9_cp_male_player_stakeout, // 0x13
        prt_t9_cp_player // 0x14
    };

    // idx 0x9 members: 0x1 type: 0
    enum cp_cpzm_character_customization {
        prt_cp_female // 0x0
    };

    // idx 0xa members: 0x4 type: 0
    enum doa_character_customization {
        prt_doa_blue, // 0x0
        prt_doa_green, // 0x1
        prt_doa_red, // 0x2
        prt_doa_yellow // 0x3
    };

    // idx 0xb members: 0x22 type: 0
    enum prt_mp_cub_dgi_outfit_presets {
        mtx_outfit_mp_cub_dgi_infiltration, // 0x0
        c_t9_cub_pl_sicario, // 0x1
        c_t9_cub_pl_dgi_sicario_santeria, // 0x2
        c_t9_cub_pl_dgi_sicario_eldoctor, // 0x3
        c_t9_cub_pl_sicario_miami, // 0x4
        c_t9_cub_pl_sicario_urbano, // 0x5
        c_t9_cub_pl_dgi_havana, // 0x6
        c_t9_cub_pl_dgi_brawler, // 0x7
        c_t9_cub_pl_dgi_mechanic, // 0x8
        c_t9_cub_pl_dgi_hitman, // 0x9
        po_c_t9_cub_pl_dgi_barrio, // 0xa
        c_t9_cub_pl_dgi_commando, // 0xb
        c_t9_cub_pl_dgi_el_jefe, // 0xc
        c_t9_cub_pl_dgi_bongo, // 0xd
        c_t9_cub_pl_dgi_warlord, // 0xe
        c_t9_cub_pl_dgi_slasher, // 0xf
        po_c_t9_cub_pl_dgi_slasher_winter, // 0x10
        po_c_t9_cub_pl_dgi_slasher_brown, // 0x11
        c_t9_cub_pl_dgi_general, // 0x12
        c_t9_cub_pl_dgi_flick, // 0x13
        po_c_t9_cub_pl_dgi_flick_variant01, // 0x14
        po_c_t9_cub_pl_dgi_flick_variant02, // 0x15
        c_t9_cub_pl_dgi_tropas_pc, // 0x16
        c_t9_cub_pl_dgi_tropas_sy, // 0x17
        c_t9_cub_pl_dgi_tropas_ms, // 0x18
        c_t9_cub_pl_dgi_rebel_leader, // 0x19
        po_c_t9_cub_pl_dgi_rebel_leader_v1, // 0x1a
        po_c_t9_cub_pl_dgi_rebel_leader_v2, // 0x1b
        c_t9_cub_pl_dgi_lucha, // 0x1c
        c_t9_cub_pl_dgi_lucha_v2, // 0x1d
        c_t9_cub_pl_dgi_jack_base, // 0x1e
        c_t9_cub_pl_dgi_jack_pc, // 0x1f
        c_t9_cub_pl_dgi_jack_sy, // 0x20
        c_t9_cub_pl_dgi_jack_ms // 0x21
    };

    // idx 0xc members: 0x4 type: 0
    enum prt_mp_eg_quicksand_outfit_presets {
        c_t9_eg_pl_quicksand, // 0x0
        c_t9_eg_pl_quicksand_khopesh, // 0x1
        c_t9_eg_pl_quicksand_slither, // 0x2
        c_t9_eg_pl_quicksand_slither_1 // 0x3
    };

    // idx 0xd members: 0x3 type: 0
    enum prt_mp_esp_goe_bomber_outfit_presets {
        c_t9_esp_pl_goe_bomber, // 0x0
        c_t9_esp_pl_goe_bomber_dusty, // 0x1
        po_c_t9_esp_pl_goe_bomber_scrapmetal // 0x2
    };

    // idx 0xe members: 0xc type: 0
    enum prt_mp_fin_wraith_outfit_presets {
        c_t9_fin_pl_wraith, // 0x0
        po_c_t9_fin_pl_wraith_variant01, // 0x1
        po_c_t9_fin_pl_wraith_variant02, // 0x2
        po_c_t9_fin_pl_wraith_variant03, // 0x3
        po_c_t9_fin_pl_wraith_variant04, // 0x4
        c_t9_fin_pl_wraith_white_queen, // 0x5
        po_c_t9_fin_pl_wraith_white_queen_furious, // 0x6
        po_c_t9_fin_pl_wraith_white_queen_sandstorm, // 0x7
        c_t9_fin_pl_wraith_havoc, // 0x8
        c_t9_fin_pl_wraith_burnout, // 0x9
        c_t9_fin_pl_wraith_freya, // 0xa
        po_c_t9_fin_pl_wraith_automaton // 0xb
    };

    // idx 0xf members: 0xa type: 0
    enum prt_mp_fra_dgse_outfit_presets {
        c_t9_fra_pl_dgse_gign, // 0x0
        c_t9_fra_pl_dgse_infiltration, // 0x1
        c_t9_fra_pl_dgse_mademoiselle, // 0x2
        po_c_t9_fra_pl_dgse_mademoiselle_variant01, // 0x3
        po_c_t9_fra_pl_dgse_mademoiselle_variant02, // 0x4
        c_t9_fra_pl_dgse_amped, // 0x5
        c_t9_fra_pl_dgse_dakar, // 0x6
        c_t9_fra_pl_dgse_dakar_bandlands, // 0x7
        c_t9_fra_pl_dgse_dakar_proven, // 0x8
        c_t9_fra_pl_dgse_arc // 0x9
    };

    // idx 0x10 members: 0x27 type: 0
    enum prt_mp_gen_pl_esports_male_outfit_presets {
        po_c_t9_gen_pl_esports_male_cdl_home_pc, // 0x0
        po_c_t9_gen_pl_esports_male_cdl_home_ms, // 0x1
        po_c_t9_gen_pl_esports_male_cdl_home_sy, // 0x2
        po_c_t9_gen_pl_esports_male_faze_home_pc, // 0x3
        po_c_t9_gen_pl_esports_male_faze_home_ms, // 0x4
        po_c_t9_gen_pl_esports_male_faze_home_sy, // 0x5
        po_c_t9_gen_pl_esports_male_empire_home_pc, // 0x6
        po_c_t9_gen_pl_esports_male_empire_home_ms, // 0x7
        po_c_t9_gen_pl_esports_male_empire_home_sy, // 0x8
        po_c_t9_gen_pl_esports_male_mutineers_home_pc, // 0x9
        po_c_t9_gen_pl_esports_male_mutineers_home_ms, // 0xa
        po_c_t9_gen_pl_esports_male_mutineers_home_sy, // 0xb
        po_c_t9_gen_pl_esports_male_royalravens_home_pc, // 0xc
        po_c_t9_gen_pl_esports_male_royalravens_home_ms, // 0xd
        po_c_t9_gen_pl_esports_male_royalravens_home_sy, // 0xe
        po_c_t9_gen_pl_esports_male_guerillas_home_pc, // 0xf
        po_c_t9_gen_pl_esports_male_guerillas_home_ms, // 0x10
        po_c_t9_gen_pl_esports_male_guerillas_home_sy, // 0x11
        po_c_t9_gen_pl_esports_male_thieves_home_pc, // 0x12
        po_c_t9_gen_pl_esports_male_thieves_home_ms, // 0x13
        po_c_t9_gen_pl_esports_male_thieves_home_sy, // 0x14
        po_c_t9_gen_pl_esports_male_rokkr_home_pc, // 0x15
        po_c_t9_gen_pl_esports_male_rokkr_home_ms, // 0x16
        po_c_t9_gen_pl_esports_male_rokkr_home_sy, // 0x17
        po_c_t9_gen_pl_esports_male_subliners_home_pc, // 0x18
        po_c_t9_gen_pl_esports_male_subliners_home_ms, // 0x19
        po_c_t9_gen_pl_esports_male_subliners_home_sy, // 0x1a
        po_c_t9_gen_pl_esports_male_optic_home_pc, // 0x1b
        po_c_t9_gen_pl_esports_male_optic_home_ms, // 0x1c
        po_c_t9_gen_pl_esports_male_optic_home_sy, // 0x1d
        po_c_t9_gen_pl_esports_male_legion_home_pc, // 0x1e
        po_c_t9_gen_pl_esports_male_legion_home_ms, // 0x1f
        po_c_t9_gen_pl_esports_male_legion_home_sy, // 0x20
        po_c_t9_gen_pl_esports_male_surge_home_pc, // 0x21
        po_c_t9_gen_pl_esports_male_surge_home_ms, // 0x22
        po_c_t9_gen_pl_esports_male_surge_home_sy, // 0x23
        po_c_t9_gen_pl_esports_male_ultra_home_pc, // 0x24
        po_c_t9_gen_pl_esports_male_ultra_home_ms, // 0x25
        po_c_t9_gen_pl_esports_male_ultra_home_sy // 0x26
    };

    // idx 0x11 members: 0x27 type: 0
    enum prt_mp_gen_pl_esports_male_warsaw_outfit_presets {
        po_c_t9_gen_pl_esports_male_cdl_away_pc, // 0x0
        po_c_t9_gen_pl_esports_male_cdl_away_ms, // 0x1
        po_c_t9_gen_pl_esports_male_cdl_away_sy, // 0x2
        po_c_t9_gen_pl_esports_male_faze_away_pc, // 0x3
        po_c_t9_gen_pl_esports_male_faze_away_ms, // 0x4
        po_c_t9_gen_pl_esports_male_faze_away_sy, // 0x5
        po_c_t9_gen_pl_esports_male_empire_away_pc, // 0x6
        po_c_t9_gen_pl_esports_male_empire_away_ms, // 0x7
        po_c_t9_gen_pl_esports_male_empire_away_sy, // 0x8
        po_c_t9_gen_pl_esports_male_mutineers_away_pc, // 0x9
        po_c_t9_gen_pl_esports_male_mutineers_away_ms, // 0xa
        po_c_t9_gen_pl_esports_male_mutineers_away_sy, // 0xb
        po_c_t9_gen_pl_esports_male_royalravens_away_pc, // 0xc
        po_c_t9_gen_pl_esports_male_royalravens_away_ms, // 0xd
        po_c_t9_gen_pl_esports_male_royalravens_away_sy, // 0xe
        po_c_t9_gen_pl_esports_male_guerillas_away_pc, // 0xf
        po_c_t9_gen_pl_esports_male_guerillas_away_ms, // 0x10
        po_c_t9_gen_pl_esports_male_guerillas_away_sy, // 0x11
        po_c_t9_gen_pl_esports_male_thieves_away_pc, // 0x12
        po_c_t9_gen_pl_esports_male_thieves_away_ms, // 0x13
        po_c_t9_gen_pl_esports_male_thieves_away_sy, // 0x14
        po_c_t9_gen_pl_esports_male_rokkr_away_pc, // 0x15
        po_c_t9_gen_pl_esports_male_rokkr_away_ms, // 0x16
        po_c_t9_gen_pl_esports_male_rokkr_away_sy, // 0x17
        po_c_t9_gen_pl_esports_male_subliners_away_pc, // 0x18
        po_c_t9_gen_pl_esports_male_subliners_away_ms, // 0x19
        po_c_t9_gen_pl_esports_male_subliners_away_sy, // 0x1a
        po_c_t9_gen_pl_esports_male_optic_away_pc, // 0x1b
        po_c_t9_gen_pl_esports_male_optic_away_ms, // 0x1c
        po_c_t9_gen_pl_esports_male_optic_away_sy, // 0x1d
        po_c_t9_gen_pl_esports_male_legion_away_pc, // 0x1e
        po_c_t9_gen_pl_esports_male_legion_away_ms, // 0x1f
        po_c_t9_gen_pl_esports_male_legion_away_sy, // 0x20
        po_c_t9_gen_pl_esports_male_surge_away_pc, // 0x21
        po_c_t9_gen_pl_esports_male_surge_away_ms, // 0x22
        po_c_t9_gen_pl_esports_male_surge_away_sy, // 0x23
        po_c_t9_gen_pl_esports_male_ultra_away_pc, // 0x24
        po_c_t9_gen_pl_esports_male_ultra_away_ms, // 0x25
        po_c_t9_gen_pl_esports_male_ultra_away_sy // 0x26
    };

    // idx 0x12 members: 0x11 type: 0
    enum prt_mp_gen_starter1_outfit_presets {
        mtx_outfit_prt_mp_gen_starter1_default, // 0x0
        c_t9_gen_pl_starter1_hunter_rescue, // 0x1
        c_t9_gen_pl_starter1_hunter_rescue_lethal, // 0x2
        c_t9_gen_pl_starter1_hunter_rescue_charge, // 0x3
        c_t9_gen_pl_starter1_hunter_frontline, // 0x4
        c_t9_gen_pl_starter1_hunter_frontline_fall, // 0x5
        c_t9_gen_pl_starter1_hunter_frontline_winter, // 0x6
        c_t9_gen_pl_starter1_hunter_inferno, // 0x7
        c_t9_gen_pl_starter1_hunter_dash, // 0x8
        po_c_t9_gen_pl_starter1_hunter_dash_variant01, // 0x9
        po_c_t9_gen_pl_starter1_hunter_dash_variant02, // 0xa
        c_t9_gen_pl_starter1_hunter_eagle_eye, // 0xb
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_autumn, // 0xc
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_pitch, // 0xd
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_riptide, // 0xe
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_arid, // 0xf
        c_t9_gen_pl_starter1_hunter_killer // 0x10
    };

    // idx 0x13 members: 0x14 type: 0
    enum prt_mp_gen_starter2_outfit_presets {
        mtx_outfit_prt_mp_gen_starter2_default, // 0x0
        c_t9_gen_pl_starter2_vargas_steel, // 0x1
        po_c_t9_gen_pl_starter2_vargas_steel_bunker, // 0x2
        c_t9_gen_pl_starter2_vargas_steel_tourist, // 0x3
        c_t9_gen_pl_starter2_vargas_bunker, // 0x4
        po_c_t9_gen_pl_starter2_vargas_bunker_alt1, // 0x5
        po_c_t9_gen_pl_starter2_vargas_bunker_alt2, // 0x6
        c_t9_gen_pl_starter2_vargas_finishline, // 0x7
        c_t9_gen_pl_starter2_vargas_stovepipe, // 0x8
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant01, // 0x9
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant02, // 0xa
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant03, // 0xb
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant04, // 0xc
        c_t9_gen_pl_starter2_vargas_major, // 0xd
        po_c_t9_gen_pl_starter2_vargas_major_variant01, // 0xe
        po_c_t9_gen_pl_starter2_vargas_major_variant02, // 0xf
        c_t9_gen_pl_starter2_vargas_bacano, // 0x10
        c_t9_gen_pl_starter2_vargas_bull_pc, // 0x11
        c_t9_gen_pl_starter2_vargas_bull_sy, // 0x12
        c_t9_gen_pl_starter2_vargas_bull_ms // 0x13
    };

    // idx 0x14 members: 0x18 type: 0
    enum prt_mp_gen_starter3_outfit_presets {
        mtx_outfit_prt_mp_gen_starter3_default, // 0x0
        po_c_t9_gen_pl_starter3_stone_seige, // 0x1
        c_t9_gen_pl_starter3_stone_seige_breach, // 0x2
        c_t9_gen_pl_starter3_stone_seige_clear, // 0x3
        c_t9_usa_pl_navyseal_knucklehead, // 0x4
        c_t9_usa_pl_navyseal_wolf, // 0x5
        c_t9_ger_pl_west_stealth, // 0x6
        c_t9_gen_pl_starter3_stone_ash, // 0x7
        c_t9_gen_pl_starter3_stone_storefront, // 0x8
        c_t9_gen_pl_starter3_stone_squelch, // 0x9
        c_t9_gen_pl_starter3_stone_stoned, // 0xa
        c_t9_gen_pl_starter3_stone_bugscreen, // 0xb
        c_t9_gen_pl_starter3_stone_carver, // 0xc
        c_t9_gen_pl_starter3_stone_jammy, // 0xd
        c_t9_gen_pl_starter3_stone_insurgent, // 0xe
        po_c_t9_gen_pl_starter3_stone_insurgent_variant01, // 0xf
        po_c_t9_gen_pl_starter3_stone_insurgent_variant02, // 0x10
        po_c_t9_gen_pl_starter3_stone_insurgent_variant03, // 0x11
        po_c_t9_gen_pl_starter3_stone_insurgent_vampire, // 0x12
        c_t9_gen_pl_starter3_stone_bollocks_pc, // 0x13
        c_t9_gen_pl_starter3_stone_bollocks_sy, // 0x14
        c_t9_gen_pl_starter3_stone_bollocks_ms, // 0x15
        po_c_t9_gen_pl_starter3_stone_ripper, // 0x16
        po_c_t9_gen_pl_starter3_stone_infestation // 0x17
    };

    // idx 0x15 members: 0x18 type: 0
    enum prt_mp_gen_starter4_outfit_presets {
        mtx_outfit_prt_mp_gen_starter4_default, // 0x0
        c_t9_gen_pl_starter4_song_counter, // 0x1
        c_t9_gen_pl_starter4_song_counter_skirmish, // 0x2
        c_t9_gen_pl_starter4_song_counter_jinx, // 0x3
        c_t9_gen_pl_starter4_song_tiger, // 0x4
        po_c_t9_gen_pl_starter4_song_tiger_blue, // 0x5
        po_c_t9_gen_pl_starter4_song_tiger_tan, // 0x6
        c_t9_gen_pl_starter4_song_bloom, // 0x7
        po_c_t9_gen_pl_starter4_song_busted, // 0x8
        po_c_t9_gen_pl_starter4_song_busted_variant01, // 0x9
        po_c_t9_gen_pl_starter4_song_busted_variant02, // 0xa
        po_c_t9_gen_pl_starter4_song_busted_variant03, // 0xb
        po_c_t9_gen_pl_starter4_song_busted_variant04, // 0xc
        c_t9_gen_pl_starter4_song_backflip, // 0xd
        c_t9_gen_pl_starter4_song_flare, // 0xe
        c_t9_gen_pl_starter4_song_observer, // 0xf
        c_t9_gen_pl_starter4_song_observer_variant01, // 0x10
        c_t9_gen_pl_starter4_song_observer_variant02, // 0x11
        c_t9_gen_pl_starter4_song_dagger, // 0x12
        po_c_t9_gen_pl_starter4_dagger_v1, // 0x13
        po_c_t9_gen_pl_starter4_dagger_v2, // 0x14
        c_t9_gen_pl_starter4_song_mechanic_pc, // 0x15
        c_t9_gen_pl_starter4_song_mechanic_sy, // 0x16
        c_t9_gen_pl_starter4_song_mechanic_ms // 0x17
    };

    // idx 0x16 members: 0x17 type: 0
    enum prt_mp_gen_starter5_outfit_presets {
        mtx_outfit_prt_mp_gen_starter5_default, // 0x0
        c_t9_gen_pl_starter5_powers_dust, // 0x1
        po_c_t9_gen_pl_starter5_powers_dust_military, // 0x2
        c_t9_gen_pl_starter5_powers_dust_urban, // 0x3
        c_t9_gen_pl_starter5_powers_gun, // 0x4
        c_t9_gen_pl_starter5_powers_gun_v1, // 0x5
        c_t9_gen_pl_starter5_powers_gun_v2, // 0x6
        c_t9_gen_pl_starter5_powers_ffl, // 0x7
        c_t9_gen_pl_starter5_powers_cameroon, // 0x8
        c_t9_gen_pl_starter5_powers_cameroon_variant01, // 0x9
        c_t9_gen_pl_starter5_powers_cameroon_variant02, // 0xa
        c_t9_gen_pl_starter5_powers_cameroon_variant03, // 0xb
        c_t9_gen_pl_starter5_powers_cameroon_variant04, // 0xc
        c_t9_gen_pl_starter5_powers_desert, // 0xd
        c_t9_gen_starter5_powers_swift, // 0xe
        c_t9_gen_pl_starter5_powers_driver, // 0xf
        po_c_t9_gen_pl_starter5_powers_driver_variant01, // 0x10
        po_c_t9_gen_pl_starter5_powers_driver_variant02, // 0x11
        po_c_t9_gen_pl_starter5_powers_driver_variant03, // 0x12
        po_c_t9_gen_pl_starter5_powers_driver_variant04, // 0x13
        c_t9_gen_pl_starter5_powers_stealth, // 0x14
        po_c_t9_gen_pl_starter5_powers_stealth_variant01, // 0x15
        po_c_t9_gen_pl_starter5_powers_stealth_variant02 // 0x16
    };

    // idx 0x17 members: 0x7 type: 0
    enum prt_mp_ger_pl_maxis_outfit_presets {
        c_t9_ger_pl_maxis_dark, // 0x0
        c_t9_ger_pl_maxis_bride, // 0x1
        c_t9_ger_pl_maxis_traveler, // 0x2
        c_t9_ger_pl_maxis_scythe, // 0x3
        c_t9_ger_pl_maxis_lumens, // 0x4
        c_t9_ger_pl_maxis_berlin, // 0x5
        po_c_t9_ger_pl_maxis_phantom // 0x6
    };

    // idx 0x18 members: 0x22 type: 0
    enum prt_mp_ger_west_outfit_presets {
        mtx_outfit_mp_ger_west_infiltration, // 0x0
        c_t9_ger_pl_west_gsg9_3, // 0x1
        c_t9_ger_pl_west_gsg9_3_munchen, // 0x2
        po_c_t9_ger_pl_west_gsg9_3_wachter, // 0x3
        c_t9_ger_pl_west_raider, // 0x4
        c_t9_ger_pl_west_raider_bruiser, // 0x5
        c_t9_ger_pl_west_raider_wildcat, // 0x6
        c_t9_ger_pl_west_police, // 0x7
        c_t9_ger_pl_west_winter, // 0x8
        c_t9_ger_pl_west_swat, // 0x9
        c_t9_ger_pl_west_bomber, // 0xa
        c_t9_ger_pl_west_racer_xfinity_incentive, // 0xb
        c_t9_ger_pl_west_racer_sky_incentive, // 0xc
        po_c_t9_ger_pl_west_racer_ufo, // 0xd
        c_t9_ger_pl_west_nightops, // 0xe
        c_t9_ger_pl_west_paratrooper, // 0xf
        c_t9_ger_pl_west_carnage, // 0x10
        c_t9_ger_pl_west_gsg9_hardhat, // 0x11
        po_c_t9_ger_pl_west_gsg9_hardhat_v1, // 0x12
        c_t9_ger_pl_west_gsg9_hardhat_v2, // 0x13
        c_t9_ger_pl_west_gothic, // 0x14
        c_t9_ger_pl_west_klown, // 0x15
        c_t9_ger_pl_west_patrol, // 0x16
        c_t9_ger_pl_west_tagger_ii, // 0x17
        c_t9_ger_pl_west_professor, // 0x18
        c_t9_ger_pl_west_professor_v2, // 0x19
        c_t9_ger_pl_west_stalker, // 0x1a
        po_c_t9_ger_pl_west_stalker_tan, // 0x1b
        po_c_t9_ger_pl_west_stalker_blue, // 0x1c
        c_t9_ger_pl_west_judge_dredd, // 0x1d
        c_t9_ger_pl_west_judge_dredd_variant01, // 0x1e
        c_t9_ger_pl_west_stronghold, // 0x1f
        po_c_t9_ger_pl_west_stronghold_variant01, // 0x20
        po_c_t9_ger_pl_west_stronghold_variant02 // 0x21
    };

    // idx 0x19 members: 0x2 type: 0
    enum prt_mp_isr_lazar_outfit_presets {
        c_t9_isr_pl_lazar_idf, // 0x0
        prt_mp_isr_lazar_outfit_presets_dummy // 0x1
    };

    // idx 0x1a members: 0xb type: 0
    enum prt_mp_jps_kitsune_outfit_presets {
        c_t9_jpn_pl_kitsune, // 0x0
        po_c_t9_jpn_pl_kitsune_bosozoku, // 0x1
        po_c_t9_jpn_pl_kitsune_code, // 0x2
        po_c_t9_jpn_pl_kitsune_kunoichi, // 0x3
        po_c_t9_jpn_pl_kitsune_gothic, // 0x4
        c_t9_jpn_pl_kitsune_boss, // 0x5
        c_t9_jpn_pl_kitsune_ultra, // 0x6
        po_c_t9_jpn_pl_kitsune_ultra_shinrei, // 0x7
        po_c_t9_jpn_pl_kitsune_ultra_kogane, // 0x8
        c_t9_jpn_pl_kitsune_biteme, // 0x9
        po_c_t9_jpn_pl_kitsune_yokai // 0xa
    };

    // idx 0x1b members: 0xc type: 0
    enum prt_mp_lao_outfit_presets {
        c_t9_lao_pl_serpent, // 0x0
        c_t9_lao_pl_serpent_cobalt, // 0x1
        c_t9_lao_pl_serpent_ashen_scale, // 0x2
        c_t9_lao_pl_serpent_crimson_code, // 0x3
        c_t9_lao_pl_serpent_rattlesnake, // 0x4
        c_t9_lao_pl_serpent_warlord, // 0x5
        c_t9_lao_pl_serpent_warlord_tiger, // 0x6
        c_t9_lao_pl_serpent_warlord_infiltrator, // 0x7
        c_t9_lao_pl_serpent_overgrowth, // 0x8
        c_t9_lao_pl_serpent_haggler, // 0x9
        c_t9_lao_pl_serpent_shadow, // 0xa
        c_t9_lao_pl_serpent_hollow // 0xb
    };

    // idx 0x1c members: 0x7 type: 0
    enum prt_mp_nic_outfit_presets {
        c_t9_nic_pl_smuggler, // 0x0
        c_t9_nic_pl_smuggler_stinger, // 0x1
        c_t9_nic_pl_smuggler_whiskey, // 0x2
        po_c_t9_gen_pl_female_esports_pc, // 0x3
        po_c_t9_gen_pl_female_esports_sy, // 0x4
        po_c_t9_gen_pl_female_esports_ms, // 0x5
        c_t9_nic_pl_smuggler_mural // 0x6
    };

    // idx 0x1d members: 0x22 type: 0
    enum prt_mp_rus_kgb_outfit_presets {
        mtx_outfit_mp_rus_kgb_infiltration, // 0x0
        c_t9_rus_pl_kgb_assassin, // 0x1
        c_t9_rus_pl_kgb_burglar, // 0x2
        c_t9_rus_pl_kgb_burglar_blizzard, // 0x3
        c_t9_rus_pl_kgb_burglar_duck, // 0x4
        c_t9_rus_pl_kgb_tacticalgoth, // 0x5
        c_t9_rus_pl_kgb_shadow, // 0x6
        po_c_t9_rus_pl_kgb_urban, // 0x7
        c_t9_rus_pl_kgb_winter, // 0x8
        c_t9_rus_pl_kgb_thekid, // 0x9
        c_t9_rus_pl_kgb_thekid_militia, // 0xa
        c_t9_rus_pl_kgb_thekid_treehugger, // 0xb
        c_t9_rus_pl_kgb_gunshow, // 0xc
        c_t9_rus_pl_kgb_ghost, // 0xd
        c_t9_rus_pl_kgb_valentines, // 0xe
        c_t9_rus_pl_kgb_punk, // 0xf
        c_t9_rus_pl_kgb_bunny, // 0x10
        c_t9_rus_pl_kgb_funnybone, // 0x11
        c_t9_rus_pl_kgb_smoker, // 0x12
        c_t9_rus_pl_kgb_smoker_blitz, // 0x13
        c_t9_rus_pl_kgb_smoker_ridge, // 0x14
        c_t9_rus_pl_kgb_spyglass, // 0x15
        c_t9_rus_pl_kgb_poison, // 0x16
        c_t9_rus_pl_kgb_mach1_pc, // 0x17
        c_t9_rus_pl_kgb_mach1_sy, // 0x18
        c_t9_rus_pl_kgb_mach1_ms, // 0x19
        c_t9_rus_pl_kgb_hash, // 0x1a
        c_t9_rus_pl_kgb_infantry, // 0x1b
        po_c_t9_rus_pl_kgb_infantry_variant01, // 0x1c
        po_c_t9_rus_pl_kgb_infantry_variant02, // 0x1d
        po_c_t9_rus_pl_kgb_infantry_variant03, // 0x1e
        po_c_t9_rus_pl_kgb_infantry_variant04, // 0x1f
        c_t9_rus_pl_kgb_breakout, // 0x20
        c_t9_rus_pl_kgb_lab // 0x21
    };

    // idx 0x1e members: 0x7 type: 0
    enum prt_mp_rus_spetsnaz_outfit_presets {
        c_t9_rus_pl_spetsnaz_chernobyl, // 0x0
        c_t9_rus_pl_spetsnaz_grudge, // 0x1
        c_t9_rus_pl_spetsnaz_melted, // 0x2
        c_t9_rus_pl_spetsnaz_infiltration, // 0x3
        c_t9_rus_pl_spetsnaz_afghan_sniper, // 0x4
        po_c_t9_rus_pl_spetsnaz_afghan_sniper_variant01, // 0x5
        po_c_t9_rus_pl_spetsnaz_afghan_sniper_variant02 // 0x6
    };

    // idx 0x1f members: 0x10 type: 0
    enum prt_mp_rus_stitch_outfit_presets {
        c_t9_rus_pl_stitch, // 0x0
        c_t9_rus_pl_stitch_marine, // 0x1
        c_t9_rus_pl_stitch_spectre, // 0x2
        c_t9_rus_pl_stitch_urban, // 0x3
        c_t9_rus_pl_stitch_undercover, // 0x4
        c_t9_rus_pl_stitch_prisoner, // 0x5
        c_t9_rus_pl_stitch_prisoner_punk, // 0x6
        c_t9_rus_pl_stitch_prisoner_stripes, // 0x7
        c_t9_rus_pl_stitch_cultist_ghoul, // 0x8
        po_c_t9_rus_pl_stitch_cultist_black_gold_pc, // 0x9
        po_c_t9_rus_pl_stitch_cultist_black_gold_sy, // 0xa
        po_c_t9_rus_pl_stitch_cultist_black_gold_ms, // 0xb
        c_t9_rus_pl_stitch_brute, // 0xc
        c_t9_rus_pl_stitch_torn, // 0xd
        c_t9_rus_pl_stitch_echo, // 0xe
        po_c_t9_rus_pl_stitch_manga // 0xf
    };

    // idx 0x20 members: 0xb type: 0
    enum prt_mp_sa_deathstalker_outfit_presets {
        c_t9_sa_pl_deathstalker, // 0x0
        c_t9_sa_pl_deathstalker_urban, // 0x1
        c_t9_sa_pl_deathstalker_scorpion, // 0x2
        c_t9_sa_pl_deathstalker_hyena, // 0x3
        c_t9_sa_pl_deathstalker_shaman, // 0x4
        c_t9_sa_pl_deathstalker_snake, // 0x5
        c_t9_sa_pl_deathstalker_snake_water, // 0x6
        c_t9_sa_pl_deathstalker_snake_copper, // 0x7
        c_t9_sa_pl_deathstalker_bearclaw_pc, // 0x8
        c_t9_sa_pl_deathstalker_bearclaw_sy, // 0x9
        c_t9_sa_pl_deathstalker_bearclaw_ms // 0xa
    };

    // idx 0x21 members: 0x2 type: 0
    enum prt_mp_uk_kingsley_outfit_presets {
        c_t9_uk_pl_kingsley, // 0x0
        prt_mp_uk_kingsley_outfit_presets_dummy // 0x1
    };

    // idx 0x22 members: 0x2c type: 0
    enum prt_mp_uk_mi6_outfit_presets {
        mtx_outfit_mp_uk_mi6_infiltration, // 0x0
        e0po_c_t9_uk_pl_mi6_handler, // 0x1
        c_t9_uk_pl_mi6_heist, // 0x2
        c_t9_uk_pl_mi6_clandestine, // 0x3
        c_t9_uk_pl_mi6_doubleagent, // 0x4
        c_t9_uk_pl_mi6_tagger, // 0x5
        po_c_t9_uk_pl_mi6_snapshot, // 0x6
        c_t9_uk_pl_mi6_scorch, // 0x7
        c_t9_uk_pl_mi6_badblood, // 0x8
        c_t9_uk_pl_mi6_badblood_commando, // 0x9
        c_t9_uk_pl_mi6_badblood_glamour, // 0xa
        c_t9_uk_pl_mi6_survivor, // 0xb
        c_t9_uk_pl_mi6_survivor_autumn, // 0xc
        c_t9_uk_pl_mi6_survivor_solstice, // 0xd
        c_t9_uk_pl_mi6_glam, // 0xe
        c_t9_uk_pl_mi6_napalm, // 0xf
        c_t9_uk_pl_mi6_racer, // 0x10
        c_t9_uk_pl_mi6_fob, // 0x11
        po_c_t9_uk_pl_mi6_fob_v1, // 0x12
        po_c_t9_uk_pl_mi6_fob_v2, // 0x13
        c_t9_uk_pl_mi6_coal, // 0x14
        c_t9_uk_pl_mi6_coal_variant01, // 0x15
        c_t9_uk_pl_mi6_coal_variant02, // 0x16
        c_t9_uk_pl_mi6_coal_variant03, // 0x17
        c_t9_uk_pl_mi6_coal_variant04, // 0x18
        c_t9_uk_pl_mi6_dystopia, // 0x19
        c_t9_uk_pl_mi6_xray, // 0x1a
        c_t9_uk_pl_mi6_sis, // 0x1b
        c_t9_uk_pl_mi6_derby, // 0x1c
        c_t9_uk_pl_mi6_uncharted, // 0x1d
        c_t9_uk_pl_mi6_football, // 0x1e
        po_c_t9_uk_pl_mi6_football_uk, // 0x1f
        po_c_t9_uk_pl_mi6_football_french, // 0x20
        po_c_t9_uk_pl_mi6_football_germany, // 0x21
        c_t9_uk_pl_mi6_guard, // 0x22
        c_t9_uk_pl_mi6_skyhook_pc, // 0x23
        c_t9_uk_pl_mi6_skyhook_sy, // 0x24
        c_t9_uk_pl_mi6_skyhook_ms, // 0x25
        c_t9_uk_pl_mi6_ignite, // 0x26
        c_t9_uk_pl_mi6_checker, // 0x27
        po_c_t9_uk_pl_mi6_checker_variant01, // 0x28
        po_c_t9_uk_pl_mi6_checker_variant02, // 0x29
        c_t9_uk_pl_mi6_standoff, // 0x2a
        po_c_t9_uk_pl_mi6_aftermath // 0x2b
    };

    // idx 0x23 members: 0x2 type: 0
    enum prt_mp_uk_price_outfit_presets {
        c_t9_uk_pl_price, // 0x0
        prt_mp_uk_price_outfit_presets_dummy // 0x1
    };

    // idx 0x24 members: 0x2 type: 0
    enum prt_mp_uk_sas_outfit_presets {
        c_t9_uk_pl_sas_blackknight, // 0x0
        c_t9_uk_pl_sas_gridlock // 0x1
    };

    // idx 0x25 members: 0x8 type: 0
    enum prt_mp_usa_bulldozer_outfit_presets {
        c_t9_usa_pl_bulldozer_01, // 0x0
        c_t9_usa_pl_bulldozer_toxin, // 0x1
        c_t9_usa_pl_bulldozer_hawk, // 0x2
        c_t9_usa_pl_bulldozer_boom, // 0x3
        c_t9_usa_pl_bulldozer_forged, // 0x4
        c_t9_usa_pl_bulldozer_panda, // 0x5
        po_c_t9_usa_pl_bulldozer_panda_variant01, // 0x6
        po_c_t9_usa_pl_bulldozer_panda_variant02 // 0x7
    };

    // idx 0x26 members: 0x22 type: 0
    enum prt_mp_usa_cia_outfit_presets {
        mtx_outfit_mp_usa_cia_infiltration, // 0x0
        c_t9_usa_pl_cia_frostbite, // 0x1
        c_t9_usa_pl_cia_regulator, // 0x2
        c_t9_usa_pl_cia_logger, // 0x3
        c_t9_usa_pl_cia_grit, // 0x4
        c_t9_usa_pl_cia_grit_street, // 0x5
        c_t9_usa_pl_cia_grit_blockparty, // 0x6
        c_t9_usa_pl_cia_boss, // 0x7
        c_t9_usa_pl_cia_covert, // 0x8
        c_t9_usa_pl_cia_macv, // 0x9
        c_t9_usa_pl_cia_sogman, // 0xa
        c_t9_usa_pl_cia_sog_tee, // 0xb
        c_t9_usa_pl_cia_commando, // 0xc
        po_c_t9_usa_pl_cia_penumbra_ms, // 0xd
        po_c_t9_usa_pl_cia_penumbra_pc, // 0xe
        po_c_t9_usa_pl_cia_penumbra_sy, // 0xf
        c_t9_usa_pl_deltaforce_urgentfury, // 0x10
        po_c_t9_usa_pl_deltaforce_urgentfury_ranger_scout, // 0x11
        po_c_t9_usa_pl_deltaforce_urgentfury_airborne, // 0x12
        c_t9_usa_pl_cia_advisor, // 0x13
        c_t9_usa_pl_cia_advisor_variant01, // 0x14
        c_t9_usa_pl_cia_advisor_variant02, // 0x15
        c_t9_usa_pl_cia_snatch, // 0x16
        c_t9_usa_pl_cia_big_joke3, // 0x17
        c_t9_usa_pl_cia_captain, // 0x18
        po_c_t9_usa_pl_cia_captain_variant01, // 0x19
        po_c_t9_usa_pl_cia_captain_variant02, // 0x1a
        po_c_t9_usa_pl_cia_captain_variant03, // 0x1b
        po_c_t9_usa_pl_cia_captain_variant04, // 0x1c
        po_c_t9_usa_pl_cia_macv_code_pc, // 0x1d
        po_c_t9_usa_pl_cia_macv_code_sy, // 0x1e
        po_c_t9_usa_pl_cia_macv_code_ms, // 0x1f
        c_t9_usa_pl_cia_agent, // 0x20
        c_t9_usa_pl_cia_kick // 0x21
    };

    // idx 0x27 members: 0xa type: 0
    enum prt_mp_usa_deltaforce_outfit_presets {
        c_t9_usa_pl_deltaforce_jungle_warfare, // 0x0
        c_t9_usa_pl_deltaforce_dynamite, // 0x1
        c_t9_usa_pl_deltaforce_cyclone, // 0x2
        c_t9_usa_pl_deltaforce_halo, // 0x3
        po_c_t9_usa_pl_deltaforce_halo_variant01, // 0x4
        po_c_t9_usa_pl_deltaforce_halo_variant02, // 0x5
        c_t9_usa_pl_deltaforce_brutalist_base, // 0x6
        c_t9_usa_pl_deltaforce_brutalist_pc, // 0x7
        c_t9_usa_pl_deltaforce_brutalist_sy, // 0x8
        c_t9_usa_pl_deltaforce_brutalist_ms // 0x9
    };

    // idx 0x28 members: 0x2 type: 0
    enum prt_mp_usa_ghostface_outfit_presets {
        c_t9_usa_pl_ghostface, // 0x0
        prt_mp_usa_ghostface_outfit_presets_dummy // 0x1
    };

    // idx 0x29 members: 0x26 type: 0
    enum prt_mp_usa_hero_adler_outfit_presets {
        mtx_outfit_mp_usa_hero_adler_infiltration, // 0x0
        c_t9_usa_pl_adler_bloodhound, // 0x1
        c_t9_usa_pl_adler_bloodhound_dusk, // 0x2
        c_t9_usa_pl_adler_bloodhound_glitz, // 0x3
        c_t9_usa_pl_adler_traveler, // 0x4
        c_t9_usa_pl_adler_traveler_summit, // 0x5
        c_t9_usa_pl_adler_traveler_windbreaker, // 0x6
        c_t9_usa_pl_adler_ranger, // 0x7
        c_t9_usa_pl_adler_detective, // 0x8
        po_c_t9_usa_pl_adler_detective_juice_pc, // 0x9
        po_c_t9_usa_pl_adler_detective_juice_ms, // 0xa
        po_c_t9_usa_pl_adler_detective_juice_sy, // 0xb
        c_t9_usa_pl_adler_gunslinger, // 0xc
        c_t9_usa_pl_adler_gunslinger_whiskey, // 0xd
        c_t9_usa_pl_adler_gunslinger_smokey, // 0xe
        po_c_t9_usa_pl_adler_miami, // 0xf
        c_t9_usa_pl_adler_game_fuel, // 0x10
        c_t9_usa_pl_adler_wire, // 0x11
        c_t9_usa_pl_adler_renegade, // 0x12
        c_t9_usa_pl_adler_renegade_gonefishin, // 0x13
        c_t9_usa_pl_adler_renegade_asphalt, // 0x14
        c_t9_usa_pl_adler_renegade_goblin, // 0x15
        c_t9_usa_pl_adler_renegade_redshirt, // 0x16
        c_t9_usa_pl_adler_gator, // 0x17
        c_t9_usa_pl_adler_tropic, // 0x18
        c_t9_usa_pl_adler_red, // 0x19
        c_t9_usa_pl_adler_hostage, // 0x1a
        c_t9_usa_pl_adler_buoy, // 0x1b
        c_t9_usa_pl_adler_vbss, // 0x1c
        po_c_t9_usa_pl_adler_vbss_variant_01, // 0x1d
        po_c_t9_usa_pl_adler_vbss_variant_02, // 0x1e
        c_t9_usa_pl_adler_pressed, // 0x1f
        c_t9_usa_pl_adler_lancer, // 0x20
        c_t9_usa_pl_adler_slayer, // 0x21
        c_t9_usa_pl_adler_airborne, // 0x22
        c_t9_usa_pl_adler_control, // 0x23
        po_c_t9_usa_pl_adler_control_variant01, // 0x24
        po_c_t9_usa_pl_adler_control_variant02 // 0x25
    };

    // idx 0x2a members: 0x5 type: 0
    enum prt_mp_usa_hudson_outfit_presets {
        c_t9_usa_pl_hudson, // 0x0
        c_t9_usa_pl_hudson_hazmat_pc, // 0x1
        c_t9_usa_pl_hudson_hazmat_sy, // 0x2
        c_t9_usa_pl_hudson_hazmat_ms, // 0x3
        c_t9_usa_pl_hudson_rock // 0x4
    };

    // idx 0x2b members: 0xb type: 0
    enum prt_mp_usa_mason_outfit_presets {
        c_t9_usa_pl_mason, // 0x0
        po_c_t9_usa_pl_mason_variant01, // 0x1
        po_c_t9_usa_pl_mason_variant02, // 0x2
        po_c_t9_usa_pl_mason_variant03, // 0x3
        po_c_t9_usa_pl_mason_variant04, // 0x4
        c_t9_usa_pl_mason_ultra, // 0x5
        po_c_t9_usa_pl_mason_ultra_variant01, // 0x6
        po_c_t9_usa_pl_mason_ultra_variant02, // 0x7
        po_c_t9_usa_pl_mason_ultra_variant03, // 0x8
        po_c_t9_usa_pl_mason_ultra_variant04, // 0x9
        po_c_t9_usa_pl_mason_headgame // 0xa
    };

    // idx 0x2c members: 0x2 type: 0
    enum prt_mp_usa_mcclane_outfit_presets {
        po_c_t9_usa_pl_mcclane_preset_1, // 0x0
        prt_mp_usa_mcclane_outfit_presets_dummy // 0x1
    };

    // idx 0x2d members: 0x2a type: 0
    enum prt_mp_usa_navy_seal_outfit_presets {
        mtx_outfit_mp_usa_navy_seal_infiltration, // 0x0
        c_t9_usa_pl_navyseal_slugger, // 0x1
        po_c_t9_usa_pl_navyseal_dissident, // 0x2
        c_t9_usa_pl_navyseal_maverick, // 0x3
        c_t9_usa_pl_navyseal_maverick_jackal, // 0x4
        c_t9_usa_pl_navyseal_maverick_pitcher, // 0x5
        c_t9_usa_pl_navyseal_clown, // 0x6
        c_t9_usa_pl_navyseal_solitude, // 0x7
        c_t9_usa_pl_navyseal_gigawatt, // 0x8
        c_t9_usa_pl_navyseal_gigawho, // 0x9
        c_t9_usa_pl_navyseal_gigawhen, // 0xa
        c_t9_usa_pl_navyseal_hunter, // 0xb
        c_t9_usa_pl_navyseal_sniper, // 0xc
        c_t9_usa_pl_navyseal_ringleader, // 0xd
        po_c_t9_usa_pl_navyseal_land_pc, // 0xe
        po_c_t9_usa_pl_navyseal_land_ms, // 0xf
        po_c_t9_usa_pl_navyseal_land_sy, // 0x10
        po_c_t9_usa_pl_navyseal_air_pc, // 0x11
        po_c_t9_usa_pl_navyseal_air_ms, // 0x12
        po_c_t9_usa_pl_navyseal_air_sy, // 0x13
        po_c_t9_usa_pl_navyseal_sea_pc, // 0x14
        po_c_t9_usa_pl_navyseal_sea_ms, // 0x15
        po_c_t9_usa_pl_navyseal_sea_sy, // 0x16
        c_t9_usa_pl_navyseal_breaker, // 0x17
        c_t9_usa_pl_navyseal_strike, // 0x18
        po_c_t9_usa_pl_navyseal_endurance_sy, // 0x19
        po_c_t9_usa_pl_navyseal_endurance_ms, // 0x1a
        po_c_t9_usa_pl_navyseal_endurance_pc, // 0x1b
        c_t9_usa_pl_navyseal_bluedevil, // 0x1c
        po_c_t9_usa_pl_navyseal_bluedevil_variant01, // 0x1d
        po_c_t9_usa_pl_navyseal_bluedevil_variant02, // 0x1e
        c_t9_usa_pl_navyseal_business, // 0x1f
        c_t9_usa_pl_navyseal_grunge, // 0x20
        c_t9_usa_pl_navyseal_frogman, // 0x21
        c_t9_usa_pl_navyseal_frogman_variant01, // 0x22
        c_t9_usa_pl_navyseal_frogman_variant02, // 0x23
        c_t9_usa_pl_navyseal_hopper, // 0x24
        c_t9_usa_pl_navyseal_hopper_v2, // 0x25
        c_t9_usa_pl_navyseal_grip, // 0x26
        po_c_t9_usa_pl_navyseal_grip_variant01, // 0x27
        po_c_t9_usa_pl_navyseal_grip_variant02, // 0x28
        c_t9_usa_pl_navyseal_frank // 0x29
    };

    // idx 0x2e members: 0x2 type: 0
    enum prt_mp_usa_rambo_outfit_presets {
        c_t9_usa_pl_rambo, // 0x0
        prt_mp_usa_rambo_outfit_presets_dummy // 0x1
    };

    // idx 0x2f members: 0x2 type: 0
    enum prt_mp_usa_surge_outfit_presets {
        c_t9_usa_pl_surge, // 0x0
        po_c_t9_usa_pl_surge_meta // 0x1
    };

    // idx 0x30 members: 0x5 type: 0
    enum prt_mp_usa_weaver_outfit_presets {
        c_t9_usa_pl_weaver_cosmodrome, // 0x0
        c_t9_usa_pl_weaver_rebirth, // 0x1
        c_t9_usa_pl_weaver_sons_of_orda, // 0x2
        c_t9_usa_pl_weaver_sons_of_orda_pulsar, // 0x3
        po_c_t9_usa_pl_weaver_aftermath // 0x4
    };

    // idx 0x31 members: 0x1d type: 0
    enum prt_mp_usa_woods_outfit_presets {
        mtx_outfit_mp_usa_woods_infiltration, // 0x0
        c_t9_usa_woods_pl_eliminator, // 0x1
        c_t9_usa_pl_woods_biker, // 0x2
        c_t9_usa_pl_woods_fisherman, // 0x3
        c_t9_usa_pl_woods_eagleclaw, // 0x4
        c_t9_usa_pl_woods_eagleclaw_metro, // 0x5
        c_t9_usa_pl_woods_eagleclaw_undergrowth, // 0x6
        c_t9_usa_pl_woods_sandstorm, // 0x7
        c_t9_usa_pl_woods_holidaywoods, // 0x8
        c_t9_usa_pl_woods_trucker, // 0x9
        c_t9_usa_pl_woods_rogue, // 0xa
        c_t9_usa_pl_cia_pow, // 0xb
        c_t9_usa_pl_woods_swamp, // 0xc
        c_t9_usa_pl_woods_slaughter, // 0xd
        c_t9_usa_pl_woods_mellow, // 0xe
        c_t9_usa_pl_woods_whirlwind, // 0xf
        c_t9_usa_pl_woods_whirlwind_fire, // 0x10
        c_t9_usa_pl_woods_whirlwind_air, // 0x11
        c_t9_usa_pl_woods_conquer, // 0x12
        c_t9_usa_pl_woods_payback, // 0x13
        po_c_t9_usa_pl_woods_payback_variant01, // 0x14
        po_c_t9_usa_pl_woods_payback_variant02, // 0x15
        c_t9_usa_pl_woods_dope, // 0x16
        c_t9_usa_pl_woods_dapper, // 0x17
        c_t9_usa_pl_woods_haha, // 0x18
        po_c_t9_usa_pl_woods_haha_variant01, // 0x19
        po_c_t9_usa_pl_woods_haha_variant02, // 0x1a
        po_c_t9_usa_pl_woods_haha_variant03, // 0x1b
        po_c_t9_usa_pl_woods_haha_variant04 // 0x1c
    };

    // idx 0x32 members: 0x27 type: 0
    enum mp_character_customization {
        prt_mp_cub_dgi, // 0x0
        prt_mp_eg_quicksand, // 0x1
        prt_mp_esp_goe_bomber, // 0x2
        prt_mp_fin_wraith, // 0x3
        prt_mp_fra_dgse, // 0x4
        prt_mp_gen_pl_esports_male, // 0x5
        prt_mp_gen_pl_esports_male_warsaw, // 0x6
        prt_mp_gen_starter1, // 0x7
        prt_mp_gen_starter2, // 0x8
        prt_mp_gen_starter3, // 0x9
        prt_mp_gen_starter4, // 0xa
        prt_mp_gen_starter5, // 0xb
        prt_mp_ger_pl_maxis, // 0xc
        prt_mp_ger_west, // 0xd
        prt_mp_isr_lazar, // 0xe
        prt_mp_jps_kitsune, // 0xf
        prt_mp_lao, // 0x10
        prt_mp_nic, // 0x11
        prt_mp_rus_kgb, // 0x12
        prt_mp_rus_spetsnaz, // 0x13
        prt_mp_rus_stitch, // 0x14
        prt_mp_sa_deathstalker, // 0x15
        prt_mp_uk_kingsley, // 0x16
        prt_mp_uk_mi6, // 0x17
        prt_mp_uk_price, // 0x18
        prt_mp_uk_sas, // 0x19
        prt_mp_usa_bulldozer, // 0x1a
        prt_mp_usa_cia, // 0x1b
        prt_mp_usa_deltaforce, // 0x1c
        prt_mp_usa_ghostface, // 0x1d
        prt_mp_usa_hero_adler, // 0x1e
        prt_mp_usa_hudson, // 0x1f
        prt_mp_usa_mason, // 0x20
        prt_mp_usa_mcclane, // 0x21
        prt_mp_usa_navy_seal, // 0x22
        prt_mp_usa_rambo, // 0x23
        prt_mp_usa_surge, // 0x24
        prt_mp_usa_weaver, // 0x25
        prt_mp_usa_woods // 0x26
    };

    // idx 0x33 members: 0x8 type: 0
    enum zm_character_customization {
        prt_zm_dempsey, // 0x0
        prt_zm_dempsey_ofc, // 0x1
        prt_zm_nikolai, // 0x2
        prt_zm_nikolai_ofc, // 0x3
        prt_zm_richtofen, // 0x4
        prt_zm_richtofen_ofc, // 0x5
        prt_zm_takeo, // 0x6
        prt_zm_takeo_ofc // 0x7
    };

    // root: bitSize: 0x4470, members: 80

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x800(0x100 Byte(s))
    string(256) motd;
    // offset: 0x900, bitSize: 0x8(0x1 Byte(s))
    int:8 default_emblem_index;
    // offset: 0x908, bitSize: 0x20(0x4 Byte(s))
    uint party_maxplayers;
    // offset: 0x928, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutZMOnline;
    // offset: 0x930, bitSize: 0x90(0x12 Byte(s)), array:0x2(hti:0x7)
    CharacterContext characterContext[SuperFactions];
    // offset: 0x9c0, bitSize: 0xf20(0x1e4 Byte(s)), array:0xf2(hti:0x4)
    KeyBind keybinds[Action];
    // offset: 0x18e0, bitSize: 0x20(0x4 Byte(s))
    float safeAreaTweakable_vertical;
    // offset: 0x1900, bitSize: 0x10(0x2 Byte(s))
    int:11 default_background_index;
    // offset: 0x1910, bitSize: 0x8(0x1 Byte(s))
    uint:3 selectedCharacterMode;
    // offset: 0x1918, bitSize: 0xde0(0x1bc Byte(s))
    GameplaySettings gameplaySettings;
    // offset: 0x26f8, bitSize: 0x20(0x4 Byte(s))
    uint com_first_time;
    // offset: 0x2718, bitSize: 0x8(0x1 Byte(s))
    uint:3 online_vs_bots_difficulty;
    // offset: 0x2720, bitSize: 0x1130(0x226 Byte(s)), array:0x32(hti:0xffff)
    SelectedCharacter characters[50];
    // offset: 0x3850, bitSize: 0x20(0x4 Byte(s))
    uint cg_playerState;
    // offset: 0x3870, bitSize: 0x8(0x1 Byte(s))
    uint:4 freerunHighestTrack;
    // offset: 0x3878, bitSize: 0x40(0x8 Byte(s))
    uint64 modified_timestamp;
    // offset: 0x38b8, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOffline;
    // offset: 0x38c0, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOnlineArena;
    // offset: 0x38c8, bitSize: 0x8(0x1 Byte(s))
    uint:5 season_movie_seen_mp;
    // offset: 0x38d0, bitSize: 0x8(0x1 Byte(s))
    uint:5 season_movie_seen_zm;
    // offset: 0x38d8, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_cp;
    // offset: 0x39d8, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_wz;
    // offset: 0x3ad8, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_zm;
    // offset: 0x3bd8, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_solomatch;
    // offset: 0x3be8, bitSize: 0x8(0x1 Byte(s))
    uint:2 quick_launch_mode;
    // offset: 0x3bf0, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_offline_cpzm;
    // offset: 0x3bf8, bitSize: 0x20(0x4 Byte(s))
    float safeAreaTweakable_horizontal;
    // offset: 0x3c18, bitSize: 0x20(0x4 Byte(s))
    uint eliteRegistrationPopupTimesShown;
    // offset: 0x3c38, bitSize: 0x8(0x1 Byte(s))
    uint:5 lastLoadoutLeague;
    // offset: 0x3c40, bitSize: 0x8(0x1 Byte(s))
    uint:5 lastLoadoutOnline;
    // offset: 0x3c48, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_offline_cp;
    // offset: 0x3c50, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_mp;
    // offset: 0x3c60, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_wz;
    // offset: 0x3c70, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_zm;
    // offset: 0x3c80, bitSize: 0x8(0x1 Byte(s))
    uint:4 character_class;
    // offset: 0x3c88, bitSize: 0x8(0x1 Byte(s))
    uint:5 lastLoadoutSystemlink;
    // offset: 0x3c90, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype;
    // offset: 0x3d90, bitSize: 0x20(0x4 Byte(s))
    uint takeCoverWarnings;
    // offset: 0x3db0, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutZMOffline;
    // offset: 0x3db8, bitSize: 0x100(0x20 Byte(s))
    string(32) scoreboardSortKey;
    // offset: 0x3eb8, bitSize: 0x8(0x1 Byte(s))
    uint:5 emblem;
    // offset: 0x3ec0, bitSize: 0x8(0x1 Byte(s))
    uint:7 emblem_grid_size;
    // offset: 0x3ec8, bitSize: 0x100(0x20 Byte(s))
    string(32) map_cp;
    // offset: 0x3fc8, bitSize: 0x100(0x20 Byte(s))
    string(32) map_wz;
    // offset: 0x40c8, bitSize: 0x100(0x20 Byte(s))
    string(32) map_zm;
    // offset: 0x41c8, bitSize: 0x8(0x1 Byte(s))
    uint:5 selectedCharacterIndex;
    // offset: 0x41d0, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_bots;
    // offset: 0x42d0, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill;
    // offset: 0x42d8, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
    int padding[3];
    // offset: 0x4338, bitSize: 0x8(0x1 Byte(s))
    uint:3 intro_movie_seen_mp;
    // offset: 0x4340, bitSize: 0x8(0x1 Byte(s))
    uint:3 intro_movie_seen_zm;
    // offset: 0x4348, bitSize: 0x8(0x1 Byte(s))
    uint:2 identity_initialized;
    // offset: 0x4350, bitSize: 0x8(0x1 Byte(s))
    int:8 settings_version;
    // offset: 0x4358, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_online_cp;
    // offset: 0x4360, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOnlineCustom;
    // offset: 0x4368, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_arena;
    // offset: 0x4378, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOnlinePublic;
    // offset: 0x4380, bitSize: 0x8(0x1 Byte(s))
    uint:7 paintshop_grid_size;
    // offset: 0x4388, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_online_cpzm;
    // offset: 0x4390, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutZMCustom;
    // offset: 0x4398, bitSize: 0x1
    bool com_first_time_mission_select;
    // offset: 0x4399, bitSize: 0x1
    bool music_player_initialized;
    // offset: 0x439a, bitSize: 0x1
    bool eula_third_time;
    // offset: 0x439b, bitSize: 0x1
    SuperFactions superFaction;
    // offset: 0x439c, bitSize: 0x1
    bool cg_spectateThirdPerson;
    // offset: 0x439d, bitSize: 0x1
    bool com_first_time_account_linked;
    // offset: 0x439e, bitSize: 0x1
    bool com_firsttime_freerun;
    // offset: 0x439f, bitSize: 0x1
    bool com_privategame_ranked_zm;
    // offset: 0x43a0, bitSize: 0x1
    bool offline_identity_initialized;
    // offset: 0x43a1, bitSize: 0x1
    bool eula_second_time;
    // offset: 0x43a2, bitSize: 0x1
    bool start_in_3d;
    // offset: 0x43a3, bitSize: 0x27, array:0x27(hti:0x32)
    bool playedCharacterIntro[mp_character_customization];
    // offset: 0x43ca, bitSize: 0x1
    bool FTUE_prestige_played;
    // offset: 0x43cb, bitSize: 0x1
    bool isSuperFactionInitialized;
    // offset: 0x43cc, bitSize: 0x1
    bool com_first_time_privategame_host_zm;
    // offset: 0x43cd, bitSize: 0x1
    bool commonInitialized;
    // offset: 0x43ce, bitSize: 0x98(0x13 Byte(s)), array:0x98(hti:0x5)
    bool musicplayer_trackenable[MusicTracks];
    // offset: 0x4466, bitSize: 0x4, array:0x4(hti:0x6)
    bool musicplayer_trackunlock[ProgressionMusicTracks];
};

version 1 {
    // enums ..... 52 (0x34)
    // structs ... 18 (0x12)
    // bit size .. 17696 (0x4520)
    // byte size . 2212 (0x8a4)
    // archive ... hash_8ccbc1f874c7c160

    // bitSize: 0x10, members: 1
    struct OutfitItemListBreadcrumb {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x10(hti:0xffff)
        bool outfit_item_marked_old[16];
    };

    // bitSize: 0xc0, members: 2
    struct OutfitPartsListBreadcrumb {
        // offset: 0x0, bitSize: 0x80(0x10 Byte(s)), array:0x8(hti:0x0)
        OutfitItemListBreadcrumb parts[outfitParts_e];
        // offset: 0x80, bitSize: 0x40(0x8 Byte(s)), array:0x40(hti:0xffff)
        bool preset_item_marked_old[64];
    };

    // bitSize: 0x100, members: 1
    struct JumpkitComponentBreadcrumb {
        // offset: 0x0, bitSize: 0x100(0x20 Byte(s)), array:0x100(hti:0xffff)
        bool jumpkit_part_marked_old[256];
    };

    // bitSize: 0xc8, members: 2
    struct WristAccessory {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        WristAccessories selectedWristAccessory;
        // offset: 0x8, bitSize: 0xc0(0x18 Byte(s)), array:0xc0(hti:0x2)
        bool marked_old[WristAccessories];
    };

    // bitSize: 0x98, members: 3
    struct Execution {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        Executions selectedExecution;
        // offset: 0x8, bitSize: 0x8c, array:0x8c(hti:0x3)
        bool marked_old[Executions];
    };

    // bitSize: 0x40, members: 1
    struct CharacterOutfit {
        // offset: 0x0, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0x0)
        uint:5 selectedComponent[outfitParts_e];
    };

    // bitSize: 0x2818, members: 6
    struct Character {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedOutfit;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedWarPaintOutfit;
        // offset: 0x10, bitSize: 0x1e00(0x3c0 Byte(s)), array:0x28(hti:0xffff)
        OutfitPartsListBreadcrumb outfit_breadcrumbs[40];
        // offset: 0x1e10, bitSize: 0xa00(0x140 Byte(s)), array:0x28(hti:0xffff)
        CharacterOutfit selectedOutfitItems[40];
        // offset: 0x2810, bitSize: 0x1
        bool isRandomSelectedOutfit;
    };

    // bitSize: 0x48, members: 4
    struct CharacterContext {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        uint characterIndex;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        uint characterMode;
        // offset: 0x40, bitSize: 0x1
        bool isRandomCharacter;
    };

    // bitSize: 0x58, members: 5
    struct SelectedCharacter {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:6 outfitIndex;
        // offset: 0x8, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0x0)
        uint:5 outfitItems[outfitParts_e];
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:6 warPaintOutfitIndex;
        // offset: 0x50, bitSize: 0x1
        bool locked;
    };

    // bitSize: 0x50, members: 3
    struct InGameCharacter {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedOutfit;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        uint:6 selectedWarPaintOutfit;
        // offset: 0x10, bitSize: 0x40(0x8 Byte(s))
        CharacterOutfit selectedOutfitItems;
    };

    // bitSize: 0x178, members: 10
    struct WeaponVariant {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s))
        uint:11 charmIndex;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        uint:7 blueprint;
        // offset: 0x18, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0xffff)
        uint:7 attachment[8];
        // offset: 0x58, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0xffff)
        uint:7 blueprintattachment[8];
        // offset: 0x98, bitSize: 0x40(0x8 Byte(s)), array:0x4(hti:0xffff)
        uint:10 sticker[4];
        // offset: 0xd8, bitSize: 0x80(0x10 Byte(s))
        string(16) variantName;
        // offset: 0x158, bitSize: 0x8(0x1 Byte(s))
        uint:8 reticleIndex;
        // offset: 0x160, bitSize: 0x10(0x2 Byte(s))
        uint:9 camoIndex;
        // offset: 0x170, bitSize: 0x1
        bool variantValid;
    };

    // bitSize: 0xeb0, members: 1
    struct WeaponCustomization {
        // offset: 0x0, bitSize: 0xeb0(0x1d6 Byte(s)), array:0xa(hti:0xffff)
        WeaponVariant variant[10];
    };

    // bitSize: 0xc0, members: 3
    struct VehicleCustomization {
        // offset: 0x0, bitSize: 0x40(0x8 Byte(s))
        hash horn;
        // offset: 0x40, bitSize: 0x40(0x8 Byte(s))
        hash skin;
        // offset: 0x80, bitSize: 0x40(0x8 Byte(s))
        hash battleTrack;
    };

    // bitSize: 0x1380, members: 39
    struct mp_character_outfit_preset_breadcrumbs {
        // offset: 0x0, bitSize: 0x138(0x27 Byte(s)), array:0x27(hti:0x10)
        uint:2 prt_mp_gen_pl_esports_male[prt_mp_gen_pl_esports_male_outfit_presets];
        // offset: 0x138, bitSize: 0x78(0xf Byte(s)), array:0xf(hti:0x1f)
        uint:2 prt_mp_rus_stitch[prt_mp_rus_stitch_outfit_presets];
        // offset: 0x1b0, bitSize: 0x38(0x7 Byte(s)), array:0x7(hti:0x1e)
        uint:2 prt_mp_rus_spetsnaz[prt_mp_rus_spetsnaz_outfit_presets];
        // offset: 0x1e8, bitSize: 0x50(0xa Byte(s)), array:0xa(hti:0x27)
        uint:2 prt_mp_usa_deltaforce[prt_mp_usa_deltaforce_outfit_presets];
        // offset: 0x238, bitSize: 0x58(0xb Byte(s)), array:0xb(hti:0x20)
        uint:2 prt_mp_sa_deathstalker[prt_mp_sa_deathstalker_outfit_presets];
        // offset: 0x290, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0x26)
        uint:2 prt_mp_usa_cia[prt_mp_usa_cia_outfit_presets];
        // offset: 0x3a0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x28)
        uint:2 prt_mp_usa_ghostface[prt_mp_usa_ghostface_outfit_presets];
        // offset: 0x3b0, bitSize: 0x20(0x4 Byte(s)), array:0x4(hti:0xc)
        uint:2 prt_mp_eg_quicksand[prt_mp_eg_quicksand_outfit_presets];
        // offset: 0x3d0, bitSize: 0x130(0x26 Byte(s)), array:0x26(hti:0x29)
        uint:2 prt_mp_usa_hero_adler[prt_mp_usa_hero_adler_outfit_presets];
        // offset: 0x500, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x19)
        uint:2 prt_mp_isr_lazar[prt_mp_isr_lazar_outfit_presets];
        // offset: 0x510, bitSize: 0x138(0x27 Byte(s)), array:0x27(hti:0x11)
        uint:2 prt_mp_gen_pl_esports_male_warsaw[prt_mp_gen_pl_esports_male_warsaw_outfit_presets];
        // offset: 0x648, bitSize: 0x60(0xc Byte(s)), array:0xc(hti:0x1b)
        uint:2 prt_mp_lao[prt_mp_lao_outfit_presets];
        // offset: 0x6a8, bitSize: 0x38(0x7 Byte(s)), array:0x7(hti:0x1c)
        uint:2 prt_mp_nic[prt_mp_nic_outfit_presets];
        // offset: 0x6e0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x23)
        uint:2 prt_mp_uk_price[prt_mp_uk_price_outfit_presets];
        // offset: 0x6f0, bitSize: 0x58(0xb Byte(s)), array:0xb(hti:0x1a)
        uint:2 prt_mp_jps_kitsune[prt_mp_jps_kitsune_outfit_presets];
        // offset: 0x748, bitSize: 0x28(0x5 Byte(s)), array:0x5(hti:0x2a)
        uint:2 prt_mp_usa_hudson[prt_mp_usa_hudson_outfit_presets];
        // offset: 0x770, bitSize: 0x30(0x6 Byte(s)), array:0x6(hti:0x17)
        uint:2 prt_mp_ger_pl_maxis[prt_mp_ger_pl_maxis_outfit_presets];
        // offset: 0x7a0, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0xb)
        uint:2 prt_mp_cub_dgi[prt_mp_cub_dgi_outfit_presets];
        // offset: 0x8b0, bitSize: 0x88(0x11 Byte(s)), array:0x11(hti:0x12)
        uint:2 prt_mp_gen_starter1[prt_mp_gen_starter1_outfit_presets];
        // offset: 0x938, bitSize: 0xa0(0x14 Byte(s)), array:0x14(hti:0x13)
        uint:2 prt_mp_gen_starter2[prt_mp_gen_starter2_outfit_presets];
        // offset: 0x9d8, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0x14)
        uint:2 prt_mp_gen_starter3[prt_mp_gen_starter3_outfit_presets];
        // offset: 0xa90, bitSize: 0xc0(0x18 Byte(s)), array:0x18(hti:0x15)
        uint:2 prt_mp_gen_starter4[prt_mp_gen_starter4_outfit_presets];
        // offset: 0xb50, bitSize: 0xb8(0x17 Byte(s)), array:0x17(hti:0x16)
        uint:2 prt_mp_gen_starter5[prt_mp_gen_starter5_outfit_presets];
        // offset: 0xc08, bitSize: 0x20(0x4 Byte(s)), array:0x4(hti:0x30)
        uint:2 prt_mp_usa_weaver[prt_mp_usa_weaver_outfit_presets];
        // offset: 0xc28, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0x1d)
        uint:2 prt_mp_rus_kgb[prt_mp_rus_kgb_outfit_presets];
        // offset: 0xd38, bitSize: 0x110(0x22 Byte(s)), array:0x22(hti:0x18)
        uint:2 prt_mp_ger_west[prt_mp_ger_west_outfit_presets];
        // offset: 0xe48, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x2c)
        uint:2 prt_mp_usa_mcclane[prt_mp_usa_mcclane_outfit_presets];
        // offset: 0xe58, bitSize: 0x58(0xb Byte(s)), array:0xb(hti:0xe)
        uint:2 prt_mp_fin_wraith[prt_mp_fin_wraith_outfit_presets];
        // offset: 0xeb0, bitSize: 0x50(0xa Byte(s)), array:0xa(hti:0xf)
        uint:2 prt_mp_fra_dgse[prt_mp_fra_dgse_outfit_presets];
        // offset: 0xf00, bitSize: 0x58(0xb Byte(s)), array:0xb(hti:0x2b)
        uint:2 prt_mp_usa_mason[prt_mp_usa_mason_outfit_presets];
        // offset: 0xf58, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x2e)
        uint:2 prt_mp_usa_rambo[prt_mp_usa_rambo_outfit_presets];
        // offset: 0xf68, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x2f)
        uint:2 prt_mp_usa_surge[prt_mp_usa_surge_outfit_presets];
        // offset: 0xf78, bitSize: 0xe8(0x1d Byte(s)), array:0x1d(hti:0x31)
        uint:2 prt_mp_usa_woods[prt_mp_usa_woods_outfit_presets];
        // offset: 0x1060, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x21)
        uint:2 prt_mp_uk_kingsley[prt_mp_uk_kingsley_outfit_presets];
        // offset: 0x1070, bitSize: 0x158(0x2b Byte(s)), array:0x2b(hti:0x22)
        uint:2 prt_mp_uk_mi6[prt_mp_uk_mi6_outfit_presets];
        // offset: 0x11c8, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0x24)
        uint:2 prt_mp_uk_sas[prt_mp_uk_sas_outfit_presets];
        // offset: 0x11d8, bitSize: 0x150(0x2a Byte(s)), array:0x2a(hti:0x2d)
        uint:2 prt_mp_usa_navy_seal[prt_mp_usa_navy_seal_outfit_presets];
        // offset: 0x1328, bitSize: 0x18(0x3 Byte(s)), array:0x3(hti:0xd)
        uint:2 prt_mp_esp_goe_bomber[prt_mp_esp_goe_bomber_outfit_presets];
        // offset: 0x1340, bitSize: 0x40(0x8 Byte(s)), array:0x8(hti:0x25)
        uint:2 prt_mp_usa_bulldozer[prt_mp_usa_bulldozer_outfit_presets];
    };

    // bitSize: 0x270, members: 39
    struct CharacterOutfitPresetRandomFilters {
        // offset: 0x0, bitSize: 0x27, array:0x27(hti:0x10)
        bool prt_mp_gen_pl_esports_male[prt_mp_gen_pl_esports_male_outfit_presets];
        // offset: 0x27, bitSize: 0xf, array:0xf(hti:0x1f)
        bool prt_mp_rus_stitch[prt_mp_rus_stitch_outfit_presets];
        // offset: 0x36, bitSize: 0x7, array:0x7(hti:0x1e)
        bool prt_mp_rus_spetsnaz[prt_mp_rus_spetsnaz_outfit_presets];
        // offset: 0x3d, bitSize: 0xa, array:0xa(hti:0x27)
        bool prt_mp_usa_deltaforce[prt_mp_usa_deltaforce_outfit_presets];
        // offset: 0x47, bitSize: 0xb, array:0xb(hti:0x20)
        bool prt_mp_sa_deathstalker[prt_mp_sa_deathstalker_outfit_presets];
        // offset: 0x52, bitSize: 0x22, array:0x22(hti:0x26)
        bool prt_mp_usa_cia[prt_mp_usa_cia_outfit_presets];
        // offset: 0x74, bitSize: 0x2, array:0x2(hti:0x28)
        bool prt_mp_usa_ghostface[prt_mp_usa_ghostface_outfit_presets];
        // offset: 0x76, bitSize: 0x4, array:0x4(hti:0xc)
        bool prt_mp_eg_quicksand[prt_mp_eg_quicksand_outfit_presets];
        // offset: 0x7a, bitSize: 0x26, array:0x26(hti:0x29)
        bool prt_mp_usa_hero_adler[prt_mp_usa_hero_adler_outfit_presets];
        // offset: 0xa0, bitSize: 0x2, array:0x2(hti:0x19)
        bool prt_mp_isr_lazar[prt_mp_isr_lazar_outfit_presets];
        // offset: 0xa2, bitSize: 0x27, array:0x27(hti:0x11)
        bool prt_mp_gen_pl_esports_male_warsaw[prt_mp_gen_pl_esports_male_warsaw_outfit_presets];
        // offset: 0xc9, bitSize: 0xc, array:0xc(hti:0x1b)
        bool prt_mp_lao[prt_mp_lao_outfit_presets];
        // offset: 0xd5, bitSize: 0x7, array:0x7(hti:0x1c)
        bool prt_mp_nic[prt_mp_nic_outfit_presets];
        // offset: 0xdc, bitSize: 0x2, array:0x2(hti:0x23)
        bool prt_mp_uk_price[prt_mp_uk_price_outfit_presets];
        // offset: 0xde, bitSize: 0xb, array:0xb(hti:0x1a)
        bool prt_mp_jps_kitsune[prt_mp_jps_kitsune_outfit_presets];
        // offset: 0xe9, bitSize: 0x5, array:0x5(hti:0x2a)
        bool prt_mp_usa_hudson[prt_mp_usa_hudson_outfit_presets];
        // offset: 0xee, bitSize: 0x6, array:0x6(hti:0x17)
        bool prt_mp_ger_pl_maxis[prt_mp_ger_pl_maxis_outfit_presets];
        // offset: 0xf4, bitSize: 0x22, array:0x22(hti:0xb)
        bool prt_mp_cub_dgi[prt_mp_cub_dgi_outfit_presets];
        // offset: 0x116, bitSize: 0x11, array:0x11(hti:0x12)
        bool prt_mp_gen_starter1[prt_mp_gen_starter1_outfit_presets];
        // offset: 0x127, bitSize: 0x14, array:0x14(hti:0x13)
        bool prt_mp_gen_starter2[prt_mp_gen_starter2_outfit_presets];
        // offset: 0x13b, bitSize: 0x17, array:0x17(hti:0x14)
        bool prt_mp_gen_starter3[prt_mp_gen_starter3_outfit_presets];
        // offset: 0x152, bitSize: 0x18(0x3 Byte(s)), array:0x18(hti:0x15)
        bool prt_mp_gen_starter4[prt_mp_gen_starter4_outfit_presets];
        // offset: 0x16a, bitSize: 0x17, array:0x17(hti:0x16)
        bool prt_mp_gen_starter5[prt_mp_gen_starter5_outfit_presets];
        // offset: 0x181, bitSize: 0x4, array:0x4(hti:0x30)
        bool prt_mp_usa_weaver[prt_mp_usa_weaver_outfit_presets];
        // offset: 0x185, bitSize: 0x22, array:0x22(hti:0x1d)
        bool prt_mp_rus_kgb[prt_mp_rus_kgb_outfit_presets];
        // offset: 0x1a7, bitSize: 0x22, array:0x22(hti:0x18)
        bool prt_mp_ger_west[prt_mp_ger_west_outfit_presets];
        // offset: 0x1c9, bitSize: 0x2, array:0x2(hti:0x2c)
        bool prt_mp_usa_mcclane[prt_mp_usa_mcclane_outfit_presets];
        // offset: 0x1cb, bitSize: 0xb, array:0xb(hti:0xe)
        bool prt_mp_fin_wraith[prt_mp_fin_wraith_outfit_presets];
        // offset: 0x1d6, bitSize: 0xa, array:0xa(hti:0xf)
        bool prt_mp_fra_dgse[prt_mp_fra_dgse_outfit_presets];
        // offset: 0x1e0, bitSize: 0xb, array:0xb(hti:0x2b)
        bool prt_mp_usa_mason[prt_mp_usa_mason_outfit_presets];
        // offset: 0x1eb, bitSize: 0x2, array:0x2(hti:0x2e)
        bool prt_mp_usa_rambo[prt_mp_usa_rambo_outfit_presets];
        // offset: 0x1ed, bitSize: 0x2, array:0x2(hti:0x2f)
        bool prt_mp_usa_surge[prt_mp_usa_surge_outfit_presets];
        // offset: 0x1ef, bitSize: 0x1d, array:0x1d(hti:0x31)
        bool prt_mp_usa_woods[prt_mp_usa_woods_outfit_presets];
        // offset: 0x20c, bitSize: 0x2, array:0x2(hti:0x21)
        bool prt_mp_uk_kingsley[prt_mp_uk_kingsley_outfit_presets];
        // offset: 0x20e, bitSize: 0x2b, array:0x2b(hti:0x22)
        bool prt_mp_uk_mi6[prt_mp_uk_mi6_outfit_presets];
        // offset: 0x239, bitSize: 0x2, array:0x2(hti:0x24)
        bool prt_mp_uk_sas[prt_mp_uk_sas_outfit_presets];
        // offset: 0x23b, bitSize: 0x2a, array:0x2a(hti:0x2d)
        bool prt_mp_usa_navy_seal[prt_mp_usa_navy_seal_outfit_presets];
        // offset: 0x265, bitSize: 0x3, array:0x3(hti:0xd)
        bool prt_mp_esp_goe_bomber[prt_mp_esp_goe_bomber_outfit_presets];
        // offset: 0x268, bitSize: 0x8(0x1 Byte(s)), array:0x8(hti:0x25)
        bool prt_mp_usa_bulldozer[prt_mp_usa_bulldozer_outfit_presets];
    };

    // bitSize: 0xde0, members: 231
    struct GameplaySettings {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        float fov;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideDistanceToCircle;
        // offset: 0x28, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivity;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        uint:2 gpad_sticksConfig;
        // offset: 0x50, bitSize: 0x400(0x80 Byte(s))
        string(128) voice_output_device;
        // offset: 0x450, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideAltimeter;
        // offset: 0x458, bitSize: 0x20(0x4 Byte(s))
        float gpad_button_rstick_deflect_max;
        // offset: 0x478, bitSize: 0x8(0x1 Byte(s))
        uint:2 tap_to_slide_gpad;
        // offset: 0x480, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_cinematic;
        // offset: 0x4a0, bitSize: 0x20(0x4 Byte(s))
        float location_rotation_sensitivity_kbm;
        // offset: 0x4c0, bitSize: 0x8(0x1 Byte(s))
        uint:2 prone_behavior;
        // offset: 0x4c8, bitSize: 0x8(0x1 Byte(s))
        uint:2 tap_to_slide_kbm;
        // offset: 0x4d0, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_teamchat_volume;
        // offset: 0x4f0, bitSize: 0x20(0x4 Byte(s))
        float r_sceneBrightness;
        // offset: 0x510, bitSize: 0x20(0x4 Byte(s))
        float mouse_ads_monitor_distance_coefficient;
        // offset: 0x530, bitSize: 0x20(0x4 Byte(s))
        float gpad_right_stick_deadzone_max;
        // offset: 0x550, bitSize: 0x20(0x4 Byte(s))
        float gpad_right_stick_deadzone_min;
        // offset: 0x570, bitSize: 0x8(0x1 Byte(s))
        uint:2 mantle_behaviour_ground_kbm;
        // offset: 0x578, bitSize: 0x8(0x1 Byte(s))
        uint:2 toggle_sprint_gpad;
        // offset: 0x580, bitSize: 0x8(0x1 Byte(s))
        uint:2 voice_favored_channel;
        // offset: 0x588, bitSize: 0x20(0x4 Byte(s))
        float voice_output_volume;
        // offset: 0x5a8, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideMinimizedQuickEquip;
        // offset: 0x5b0, bitSize: 0x8(0x1 Byte(s))
        uint:2 com_show_ping;
        // offset: 0x5b8, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_music;
        // offset: 0x5d8, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_voice;
        // offset: 0x5f8, bitSize: 0x20(0x4 Byte(s))
        float speaker_left;
        // offset: 0x618, bitSize: 0x8(0x1 Byte(s))
        uint:2 team_indicator;
        // offset: 0x620, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideCompass;
        // offset: 0x628, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideConsole;
        // offset: 0x630, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideWeaponEquipment;
        // offset: 0x638, bitSize: 0x20(0x4 Byte(s))
        float location_selection_sensitivity_kbm;
        // offset: 0x658, bitSize: 0x20(0x4 Byte(s))
        uint party_privacyStatus;
        // offset: 0x678, bitSize: 0x20(0x4 Byte(s))
        float HUDBoundsTweakable_vertical;
        // offset: 0x698, bitSize: 0x10(0x2 Byte(s))
        uint:10 demo_autoDollyKeyframeInterval;
        // offset: 0x6a8, bitSize: 0x8(0x1 Byte(s))
        uint:7 subtitles_background_opacity;
        // offset: 0x6b0, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideMinimap;
        // offset: 0x6b8, bitSize: 0x8(0x1 Byte(s))
        uint:2 invert_vertical_look_mouse;
        // offset: 0x6c0, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_ads_multiplier_high_zoom;
        // offset: 0x6e0, bitSize: 0x8(0x1 Byte(s))
        uint:2 ads_sensitivity_timing_kbm;
        // offset: 0x6e8, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityADSScalarHighZoom;
        // offset: 0x708, bitSize: 0x8(0x1 Byte(s))
        uint:2 mantle_behaviour_air_kbm;
        // offset: 0x710, bitSize: 0x20(0x4 Byte(s))
        float speaker_right_surround;
        // offset: 0x730, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_ads_multiplier;
        // offset: 0x750, bitSize: 0x8(0x1 Byte(s))
        uint:2 invert_vertical_look_gamepad;
        // offset: 0x758, bitSize: 0x8(0x1 Byte(s))
        uint:3 colorblindMode;
        // offset: 0x760, bitSize: 0x20(0x4 Byte(s))
        float speaker_left_front;
        // offset: 0x780, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideTeamList;
        // offset: 0x788, bitSize: 0x20(0x4 Byte(s))
        float speaker_right_front;
        // offset: 0x7a8, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_party_color_key;
        // offset: 0x7e8, bitSize: 0x20(0x4 Byte(s))
        float orbis_menu_mouse_sensitivity_multiplier;
        // offset: 0x808, bitSize: 0x20(0x4 Byte(s))
        float speaker_lfe;
        // offset: 0x828, bitSize: 0x20(0x4 Byte(s))
        float speaker_center;
        // offset: 0x848, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHidePlayerHealth;
        // offset: 0x850, bitSize: 0x20(0x4 Byte(s))
        float gpad_button_lstick_deflect_max;
        // offset: 0x870, bitSize: 0x8(0x1 Byte(s))
        uint:2 crouch_behavior;
        // offset: 0x878, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideKillIdentity;
        // offset: 0x880, bitSize: 0x20(0x4 Byte(s))
        float location_rotation_sensitivity_gpad;
        // offset: 0x8a0, bitSize: 0x20(0x4 Byte(s))
        float speaker_left_surround;
        // offset: 0x8c0, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_ally_color_key;
        // offset: 0x900, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideInsertionCount;
        // offset: 0x908, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideKills;
        // offset: 0x910, bitSize: 0x8(0x1 Byte(s))
        uint:3 textchat_filter;
        // offset: 0x918, bitSize: 0x20(0x4 Byte(s))
        uint mouse_wheel_delay;
        // offset: 0x938, bitSize: 0x8(0x1 Byte(s))
        uint:2 input_autoAimInputGraphIw;
        // offset: 0x940, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_you_color_key;
        // offset: 0x980, bitSize: 0x20(0x4 Byte(s))
        float HUDBoundsTweakable_horizontal;
        // offset: 0x9a0, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideActivePerks;
        // offset: 0x9a8, bitSize: 0x20(0x4 Byte(s))
        float speaker_right_surround_back;
        // offset: 0x9c8, bitSize: 0x8(0x1 Byte(s))
        uint:2 toggle_sprint_kbm;
        // offset: 0x9d0, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityHorizontal;
        // offset: 0x9f0, bitSize: 0x20(0x4 Byte(s))
        float snd_scale_when_speaking;
        // offset: 0xa10, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideSpectators;
        // offset: 0xa18, bitSize: 0x20(0x4 Byte(s))
        float gpad_trigger_deadzone;
        // offset: 0xa38, bitSize: 0x8(0x1 Byte(s))
        uint:2 musicplayer_enable;
        // offset: 0xa40, bitSize: 0x20(0x4 Byte(s))
        float voice_input_threshold;
        // offset: 0xa60, bitSize: 0x8(0x1 Byte(s))
        uint:2 motion_blur_mode;
        // offset: 0xa68, bitSize: 0x20(0x4 Byte(s))
        uint snd_menu_hearing_impaired;
        // offset: 0xa88, bitSize: 0x20(0x4 Byte(s))
        float mouse_acceleration;
        // offset: 0xaa8, bitSize: 0x20(0x4 Byte(s))
        float gpad_hapticsIntensity;
        // offset: 0xac8, bitSize: 0x40(0x8 Byte(s))
        hash custom_colorblind_enemy_color_key;
        // offset: 0xb08, bitSize: 0x8(0x1 Byte(s))
        uint:2 gpad_aim_assist_iw_algorithm;
        // offset: 0xb10, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHidePlayersAlive;
        // offset: 0xb18, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_sfx;
        // offset: 0xb38, bitSize: 0x8(0x1 Byte(s))
        uint:6 subtitles_size;
        // offset: 0xb40, bitSize: 0x20(0x4 Byte(s))
        float voice_input_volume;
        // offset: 0xb60, bitSize: 0x8(0x1 Byte(s))
        uint:7 matchmakingDelay;
        // offset: 0xb68, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity;
        // offset: 0xb88, bitSize: 0x20(0x4 Byte(s))
        float snd_menu_master;
        // offset: 0xba8, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_vehicle;
        // offset: 0xbc8, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityADSScalar;
        // offset: 0xbe8, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideObituary;
        // offset: 0xbf0, bitSize: 0x8(0x1 Byte(s))
        uint:2 chase_cam_free_look_mode;
        // offset: 0xbf8, bitSize: 0x8(0x1 Byte(s))
        uint:2 interact_reload_behavior;
        // offset: 0xc00, bitSize: 0x10(0x2 Byte(s))
        uint:9 musicplayer_playlist;
        // offset: 0xc10, bitSize: 0x20(0x4 Byte(s))
        float mouse_filtering;
        // offset: 0xc30, bitSize: 0x8(0x1 Byte(s))
        uint:2 gpad_swap_sticks_on_ads;
        // offset: 0xc38, bitSize: 0x20(0x4 Byte(s))
        float mouse_sensitivity_vertical_multiplier;
        // offset: 0xc58, bitSize: 0x8(0x1 Byte(s))
        uint:3 snd_menu_presets;
        // offset: 0xc60, bitSize: 0x8(0x1 Byte(s))
        uint:5 gpad_buttonsConfig;
        // offset: 0xc68, bitSize: 0x8(0x1 Byte(s))
        uint:2 variable_zoom_shared_input;
        // offset: 0xc70, bitSize: 0x8(0x1 Byte(s))
        uint:2 zm_names_health_bars;
        // offset: 0xc78, bitSize: 0x20(0x4 Byte(s))
        float gpad_left_stick_deadzone_max;
        // offset: 0xc98, bitSize: 0x20(0x4 Byte(s))
        float gpad_left_stick_deadzone_min;
        // offset: 0xcb8, bitSize: 0x20(0x4 Byte(s))
        float speaker_left_surround_back;
        // offset: 0xcd8, bitSize: 0x8(0x1 Byte(s))
        uint:2 snd_menu_speaker_setup;
        // offset: 0xce0, bitSize: 0x10(0x2 Byte(s))
        uint:13 vehicle_camera_recenter_delay;
        // offset: 0xcf0, bitSize: 0x20(0x4 Byte(s))
        float input_viewSensitivityVertical;
        // offset: 0xd10, bitSize: 0x20(0x4 Byte(s))
        uint demo_controllerConfig;
        // offset: 0xd30, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideCleanups;
        // offset: 0xd38, bitSize: 0x8(0x1 Byte(s))
        uint:2 warzoneHideOnScreenButtons;
        // offset: 0xd40, bitSize: 0x20(0x4 Byte(s))
        float speaker_right;
        // offset: 0xd60, bitSize: 0x8(0x1 Byte(s))
        uint:2 com_show_packet_loss;
        // offset: 0xd68, bitSize: 0x1
        bool display_ingame_alert_icons;
        // offset: 0xd69, bitSize: 0x1
        bool com_show_cpu_client_time;
        // offset: 0xd6a, bitSize: 0x1
        bool showConnectionMeter;
        // offset: 0xd6b, bitSize: 0x1
        bool armor_plate_behavior_kbm;
        // offset: 0xd6c, bitSize: 0x1
        bool snd_controller_sounds;
        // offset: 0xd6d, bitSize: 0x1
        bool healthbar_show_ally;
        // offset: 0xd6e, bitSize: 0x1
        bool parachute_auto_deploy_gpad;
        // offset: 0xd6f, bitSize: 0x1
        bool equipment_auto_hold_gpad;
        // offset: 0xd70, bitSize: 0x1
        bool auto_sprint_gpad;
        // offset: 0xd71, bitSize: 0x1
        bool com_show_system_clock;
        // offset: 0xd72, bitSize: 0x1
        bool musicplayer_shuffle;
        // offset: 0xd73, bitSize: 0x1
        bool decrease_zoom_shared_input;
        // offset: 0xd74, bitSize: 0x1
        bool auto_sprint_enabled;
        // offset: 0xd75, bitSize: 0x1
        bool display_crosshair;
        // offset: 0xd76, bitSize: 0x1
        bool minimapMode;
        // offset: 0xd77, bitSize: 0x1
        bool demo_autoDollyRecord;
        // offset: 0xd78, bitSize: 0x1
        bool warzoneReloadOnPress;
        // offset: 0xd79, bitSize: 0x1
        bool cg_blood;
        // offset: 0xd7a, bitSize: 0x1
        bool hitmarkers_sfx;
        // offset: 0xd7b, bitSize: 0x1
        bool splitscreenOrientation;
        // offset: 0xd7c, bitSize: 0x1
        bool auto_mount_ladder_enabled;
        // offset: 0xd7d, bitSize: 0x1
        bool toggle_steady_aim_kbm;
        // offset: 0xd7e, bitSize: 0x1
        bool input_device;
        // offset: 0xd7f, bitSize: 0x1
        bool sprint_cancel_reload_toggle_gpad;
        // offset: 0xd80, bitSize: 0x1
        bool cg_gibs;
        // offset: 0xd81, bitSize: 0x1
        bool com_show_vram;
        // offset: 0xd82, bitSize: 0x1
        bool tooltip_enable;
        // offset: 0xd83, bitSize: 0x1
        bool cursor_immediate_lock_inventory;
        // offset: 0xd84, bitSize: 0x1
        bool warzonePriorityPickups;
        // offset: 0xd85, bitSize: 0x1
        bool com_show_gpu_time;
        // offset: 0xd86, bitSize: 0x1
        bool healthbar_show_enemy;
        // offset: 0xd87, bitSize: 0x1
        bool hitmarkers_damage_type;
        // offset: 0xd88, bitSize: 0x1
        bool toggle_score_binding_kbm;
        // offset: 0xd89, bitSize: 0x1
        bool auto_sprint_kbm;
        // offset: 0xd8a, bitSize: 0x1
        bool disable_settings_clouding;
        // offset: 0xd8b, bitSize: 0x1
        bool chat_profanity_filter;
        // offset: 0xd8c, bitSize: 0x1
        bool warzoneCycleItems;
        // offset: 0xd8d, bitSize: 0x1
        bool rgb_disable;
        // offset: 0xd8e, bitSize: 0x1
        bool parachute_auto_deploy_kbm;
        // offset: 0xd8f, bitSize: 0x1
        bool transport_vehicle_alternate_control;
        // offset: 0xd90, bitSize: 0x1
        bool doa_text_hints;
        // offset: 0xd91, bitSize: 0x1
        bool toggle_ads_persistent_gpad;
        // offset: 0xd92, bitSize: 0x1
        bool relative_vehicle_hipfire_fov;
        // offset: 0xd93, bitSize: 0x1
        bool mantle_behaviour_air_gpad;
        // offset: 0xd94, bitSize: 0x1
        bool mute_voice;
        // offset: 0xd95, bitSize: 0x1
        bool cg_enableUGC;
        // offset: 0xd96, bitSize: 0x1
        bool incognitoSelf;
        // offset: 0xd97, bitSize: 0x1
        bool gpad_haptics;
        // offset: 0xd98, bitSize: 0x1
        bool doa_persistent_round;
        // offset: 0xd99, bitSize: 0x1
        bool demo_recordWithAutoPlay;
        // offset: 0xd9a, bitSize: 0x1
        bool attack_vehicle_alternate_control_kbm;
        // offset: 0xd9b, bitSize: 0x1
        bool cursor_immediate_lock_map;
        // offset: 0xd9c, bitSize: 0x1
        bool hitmarkers_sfx_enable;
        // offset: 0xd9d, bitSize: 0x1
        bool mute_voice_input;
        // offset: 0xd9e, bitSize: 0x1
        bool com_show_fps;
        // offset: 0xd9f, bitSize: 0x1
        bool relative_ads_fov;
        // offset: 0xda0, bitSize: 0x1
        bool input_autoAim;
        // offset: 0xda1, bitSize: 0x1
        bool cg_mature;
        // offset: 0xda2, bitSize: 0x1
        bool textchat_enable;
        // offset: 0xda3, bitSize: 0x1
        bool mantle_behaviour_ground_gpad;
        // offset: 0xda4, bitSize: 0x1
        bool com_show_gpu_temperature;
        // offset: 0xda5, bitSize: 0x1
        bool show_friends_notifications;
        // offset: 0xda6, bitSize: 0x1
        bool toggle_map_binding;
        // offset: 0xda7, bitSize: 0x1
        bool equipment_auto_hold_kbm;
        // offset: 0xda8, bitSize: 0x1
        bool show_compass;
        // offset: 0xda9, bitSize: 0x1
        bool toggle_ads_persistent_kbm;
        // offset: 0xdaa, bitSize: 0x1
        bool show_input_method;
        // offset: 0xdab, bitSize: 0x1
        bool windows_key_disable;
        // offset: 0xdac, bitSize: 0x1
        bool crossplay_enable;
        // offset: 0xdad, bitSize: 0x1
        bool mouse_smoothing;
        // offset: 0xdae, bitSize: 0x1
        bool auto_forward_sequence_enabled;
        // offset: 0xdaf, bitSize: 0x1
        bool colorblind_assist;
        // offset: 0xdb0, bitSize: 0x1
        bool hitmarkers_enable;
        // offset: 0xdb1, bitSize: 0x1
        bool toggle_ads_kbm;
        // offset: 0xdb2, bitSize: 0x1
        bool toggle_score_binding_gamepad;
        // offset: 0xdb3, bitSize: 0x1
        bool attack_vehicle_alternate_control_gpad;
        // offset: 0xdb4, bitSize: 0x1
        bool ping_double_tap_danger;
        // offset: 0xdb5, bitSize: 0x1
        bool warzoneInstantPickups;
        // offset: 0xdb6, bitSize: 0x1
        bool input_targetAssist;
        // offset: 0xdb7, bitSize: 0x1
        bool cg_subtitles;
        // offset: 0xdb8, bitSize: 0x1
        bool show_party_notifications;
        // offset: 0xdb9, bitSize: 0x1
        bool com_show_cpu_render_time;
        // offset: 0xdba, bitSize: 0x1
        bool doa_text_bubbles;
        // offset: 0xdbb, bitSize: 0x1
        bool incognitoOthers;
        // offset: 0xdbc, bitSize: 0x1
        bool snd_multiplayer_character_voice;
        // offset: 0xdbd, bitSize: 0x1
        bool rtx_console_feature_any;
        // offset: 0xdbe, bitSize: 0x1
        bool toggle_ads_gpad;
        // offset: 0xdbf, bitSize: 0x1
        bool show_advanced_options;
        // offset: 0xdc0, bitSize: 0x1
        bool doa_floating_damage;
        // offset: 0xdc1, bitSize: 0x1
        bool increase_zoom_shared_input;
        // offset: 0xdc2, bitSize: 0x1
        bool mute_voice_output;
        // offset: 0xdc3, bitSize: 0x1
        bool armor_plate_behavior_gpad;
        // offset: 0xdc4, bitSize: 0x1
        bool textchat_show_channel;
        // offset: 0xdc5, bitSize: 0x1
        bool toggle_inventory_binding;
        // offset: 0xdc6, bitSize: 0x1
        bool weapon_cycle_disable_wrap;
        // offset: 0xdc7, bitSize: 0x1
        bool out_of_ammo_auto_weapon_change;
        // offset: 0xdc8, bitSize: 0x1
        bool doa_crab_tutorial;
        // offset: 0xdc9, bitSize: 0x1
        bool toggle_walk;
        // offset: 0xdca, bitSize: 0x1
        bool textchat_show_timestamps;
        // offset: 0xdcb, bitSize: 0x1
        bool com_show_gpu_clock;
        // offset: 0xdcc, bitSize: 0x1
        bool helicopter_uses_chase_cam;
        // offset: 0xdcd, bitSize: 0x1
        bool interact_requires_hold;
        // offset: 0xdce, bitSize: 0x1
        bool mouse_ads_use_monitor_distance;
        // offset: 0xdcf, bitSize: 0x1
        bool sprint_cancel_reload_toggle_kbm;
        // offset: 0xdd0, bitSize: 0x1
        bool demo_toggleGameHud;
        // offset: 0xdd1, bitSize: 0x1
        bool english_vo;
        // offset: 0xdd2, bitSize: 0x1
        bool flipped_control_config;
        // offset: 0xdd3, bitSize: 0x1
        bool snd_mute_master_volume;
        // offset: 0xdd4, bitSize: 0x1
        bool snd_scale_when_speaking_enabled;
        // offset: 0xdd5, bitSize: 0x1
        bool gpad_rumble;
        // offset: 0xdd6, bitSize: 0x1
        bool launch_settings;
        // offset: 0xdd7, bitSize: 0x1
        bool snd_voicechat_open_mic;
        // offset: 0xdd8, bitSize: 0x1
        bool show_real_names;
        // offset: 0xdd9, bitSize: 0x1
        bool zm_cartoonMode;
        // offset: 0xdda, bitSize: 0x1
        bool zm_damage_numbers;
        // offset: 0xddb, bitSize: 0x1
        bool mute_all_but_party;
        // offset: 0xddc, bitSize: 0x1
        bool cg_drawCrosshair3D;
        // offset: 0xddd, bitSize: 0x1
        bool toggle_steady_aim_gpad;
    };

    // bitSize: 0x10, members: 1
    struct KeyBind {
        // offset: 0x0, bitSize: 0x10(0x2 Byte(s)), array:0x2(hti:0xffff)
        uint:8 keys[2];
    };

    // idx 0x0 members: 0x8 type: 0
    enum outfitParts_e {
        arms, // 0x0
        decals, // 0x1
        head, // 0x2
        headgear, // 0x3
        legs, // 0x4
        palette, // 0x5
        torso, // 0x6
        war_paint // 0x7
    };

    // idx 0x1 members: 0x3 type: 0
    enum jumpKitParts_e {
        parachute, // 0x0
        trail, // 0x1
        wingsuit // 0x2
    };

    // idx 0x2 members: 0xc0 type: 0
    enum WristAccessories {
        wristaccessory_default, // 0x0
        wristaccessory_t9_esports_empire_ms, // 0x1
        wristaccessory_t9_esports_empire_pc, // 0x2
        wristaccessory_t9_esports_empire_sy, // 0x3
        wristaccessory_t9_esports_faze_ms, // 0x4
        wristaccessory_t9_esports_faze_pc, // 0x5
        wristaccessory_t9_esports_faze_sy, // 0x6
        wristaccessory_t9_esports_guerillas_ms, // 0x7
        wristaccessory_t9_esports_guerillas_pc, // 0x8
        wristaccessory_t9_esports_guerillas_sy, // 0x9
        wristaccessory_t9_esports_legion_ms, // 0xa
        wristaccessory_t9_esports_legion_pc, // 0xb
        wristaccessory_t9_esports_legion_sy, // 0xc
        wristaccessory_t9_esports_mutineers_ms, // 0xd
        wristaccessory_t9_esports_mutineers_pc, // 0xe
        wristaccessory_t9_esports_mutineers_sy, // 0xf
        wristaccessory_t9_esports_optic_ms, // 0x10
        wristaccessory_t9_esports_optic_pc, // 0x11
        wristaccessory_t9_esports_optic_sy, // 0x12
        wristaccessory_t9_esports_rokkr_ms, // 0x13
        wristaccessory_t9_esports_rokkr_pc, // 0x14
        wristaccessory_t9_esports_rokkr_sy, // 0x15
        wristaccessory_t9_esports_royalravens_ms, // 0x16
        wristaccessory_t9_esports_royalravens_pc, // 0x17
        wristaccessory_t9_esports_royalravens_sy, // 0x18
        wristaccessory_t9_esports_subliners_ms, // 0x19
        wristaccessory_t9_esports_subliners_pc, // 0x1a
        wristaccessory_t9_esports_subliners_sy, // 0x1b
        wristaccessory_t9_esports_surge_ms, // 0x1c
        wristaccessory_t9_esports_surge_pc, // 0x1d
        wristaccessory_t9_esports_surge_sy, // 0x1e
        wristaccessory_t9_esports_thieves_ms, // 0x1f
        wristaccessory_t9_esports_thieves_pc, // 0x20
        wristaccessory_t9_esports_thieves_sy, // 0x21
        wristaccessory_t9_esports_ultra_ms, // 0x22
        wristaccessory_t9_esports_ultra_pc, // 0x23
        wristaccessory_t9_esports_ultra_sy, // 0x24
        wristaccessory_t9_s1_analog_aviator_02, // 0x25
        wristaccessory_t9_s1_analog_aviator_x2, // 0x26
        wristaccessory_t9_s1_analog_bope_01, // 0x27
        wristaccessory_t9_s1_analog_brawler_01, // 0x28
        wristaccessory_t9_s1_analog_fancy, // 0x29
        wristaccessory_t9_s1_analog_fancy_debt_collector, // 0x2a
        wristaccessory_t9_s1_analog_fancy_gold, // 0x2b
        wristaccessory_t9_s1_analog_horex_01, // 0x2c
        wristaccessory_t9_s1_analog_kremlin, // 0x2d
        wristaccessory_t9_s1_analog_origin_01, // 0x2e
        wristaccessory_t9_s1_analog_private_eye_01, // 0x2f
        wristaccessory_t9_s1_analog_private_eye_02, // 0x30
        wristaccessory_t9_s1_analog_private_eye_03, // 0x31
        wristaccessory_t9_s1_analog_retroren_01, // 0x32
        wristaccessory_t9_s1_analog_retroren_02, // 0x33
        wristaccessory_t9_s1_analog_retroren_03, // 0x34
        wristaccessory_t9_s1_bracelet_01, // 0x35
        wristaccessory_t9_s1_bracelet_braided_02, // 0x36
        wristaccessory_t9_s1_bracelet_gold_chain_01, // 0x37
        wristaccessory_t9_s1_bracelet_skull_01, // 0x38
        wristaccessory_t9_s1_digital_compass_01, // 0x39
        wristaccessory_t9_s1_digital_diver, // 0x3a
        wristaccessory_t9_s1_digital_dutybot_01, // 0x3b
        wristaccessory_t9_s1_digital_first_spy_01, // 0x3c
        wristaccessory_t9_s1_digital_gambit_01, // 0x3d
        wristaccessory_t9_s1_digital_gaudy_01, // 0x3e
        wristaccessory_t9_s1_digital_inteculo_01, // 0x3f
        wristaccessory_t9_s1_digital_kazuya_01, // 0x40
        wristaccessory_t9_s1_digital_rank_01, // 0x41
        wristaccessory_t9_s1_digital_rank_penumbra_sy, // 0x42
        wristaccessory_t9_s1_digital_trak_pro_01, // 0x43
        wristaccessory_t9_s1_digital_zm_heart_rate_01, // 0x44
        wristaccessory_t9_s1_digital_zm_heart_rate_black_02, // 0x45
        wristaccessory_t9_s1_digital_zm_heart_rate_gold_01, // 0x46
        wristaccessory_t9_s2_analog_420, // 0x47
        wristaccessory_t9_s2_analog_black_gold, // 0x48
        wristaccessory_t9_s2_analog_black_silver, // 0x49
        wristaccessory_t9_s2_analog_black_tiger, // 0x4a
        wristaccessory_t9_s2_analog_broken_fancy, // 0x4b
        wristaccessory_t9_s2_analog_caiman, // 0x4c
        wristaccessory_t9_s2_analog_cold_hearted, // 0x4d
        wristaccessory_t9_s2_analog_dark_aether, // 0x4e
        wristaccessory_t9_s2_analog_jungle_aviator, // 0x4f
        wristaccessory_t9_s2_analog_mayan, // 0x50
        wristaccessory_t9_s2_analog_mortal, // 0x51
        wristaccessory_t9_s2_analog_naval_warfare, // 0x52
        wristaccessory_t9_s2_analog_necro_king, // 0x53
        wristaccessory_t9_s2_analog_paratroop, // 0x54
        wristaccessory_t9_s2_analog_rebel, // 0x55
        wristaccessory_t9_s2_analog_white_tiger, // 0x56
        wristaccessory_t9_s2_bracelet_lure, // 0x57
        wristaccessory_t9_s2_bracelet_mardi_gras, // 0x58
        wristaccessory_t9_s2_digital_jade, // 0x59
        wristaccessory_t9_s2_digital_mayan, // 0x5a
        wristaccessory_t9_s2_digital_mini_map, // 0x5b
        wristaccessory_t9_s2_digital_mini_map_hot_rod, // 0x5c
        wristaccessory_t9_s2_digital_river_slasher, // 0x5d
        wristaccessory_t9_s2_digital_sforce, // 0x5e
        wristaccessory_t9_s3_analog_chrono_sea, // 0x5f
        wristaccessory_t9_s3_analog_mctag, // 0x60
        wristaccessory_t9_s3_analog_nuclear_fallout, // 0x61
        wristaccessory_t9_s3_analog_rebel_fighter_sy, // 0x62
        wristaccessory_t9_s3_analog_winter_ash, // 0x63
        wristaccessory_t9_s3_analog_zombie_naga, // 0x64
        wristaccessory_t9_s3_bracelet_01, // 0x65
        wristaccessory_t9_s3_digital_big_joke, // 0x66
        wristaccessory_t9_s3_digital_death_touch, // 0x67
        wristaccessory_t9_s3_digital_diver_wargames, // 0x68
        wristaccessory_t9_s3_digital_heart_rate_alien, // 0x69
        wristaccessory_t9_s3_digital_inteculo_spycraft, // 0x6a
        wristaccessory_t9_s3_digital_inteculo_w_fallout, // 0x6b
        wristaccessory_t9_s3_digital_magic8, // 0x6c
        wristaccessory_t9_s3_digital_nuclear_fallout, // 0x6d
        wristaccessory_t9_s3_digital_radiation, // 0x6e
        wristaccessory_t9_s3_digital_rank_winter_fallout, // 0x6f
        wristaccessory_t9_s3_digital_ultrafunk, // 0x70
        wristaccessory_t9_s4_analog_assassin, // 0x71
        wristaccessory_t9_s4_analog_fire_storm, // 0x72
        wristaccessory_t9_s4_analog_future_soldier, // 0x73
        wristaccessory_t9_s4_analog_horror, // 0x74
        wristaccessory_t9_s4_analog_jefe, // 0x75
        wristaccessory_t9_s4_analog_rbear, // 0x76
        wristaccessory_t9_s4_analog_roadwar, // 0x77
        wristaccessory_t9_s4_analog_sleek_assassin, // 0x78
        wristaccessory_t9_s4_analog_spaceship, // 0x79
        wristaccessory_t9_s4_analog_wasteland, // 0x7a
        wristaccessory_t9_s4_bracelet_leather_studd, // 0x7b
        wristaccessory_t9_s4_bracelet_weathered, // 0x7c
        wristaccessory_t9_s4_digital_big_joke, // 0x7d
        wristaccessory_t9_s4_digital_blade, // 0x7e
        wristaccessory_t9_s4_digital_evil, // 0x7f
        wristaccessory_t9_s4_digital_holographic, // 0x80
        wristaccessory_t9_s4_digital_roadwarrior, // 0x81
        wristaccessory_t9_s4_digital_royal_decree, // 0x82
        wristaccessory_t9_s4_holographic_rank, // 0x83
        wristaccessory_t9_s5_analog_beer_o_clock, // 0x84
        wristaccessory_t9_s5_analog_blood_fancy, // 0x85
        wristaccessory_t9_s5_analog_classic, // 0x86
        wristaccessory_t9_s5_analog_demon, // 0x87
        wristaccessory_t9_s5_analog_dis_assassin, // 0x88
        wristaccessory_t9_s5_analog_egy_burial, // 0x89
        wristaccessory_t9_s5_analog_hacking_code, // 0x8a
        wristaccessory_t9_s5_analog_holographic, // 0x8b
        wristaccessory_t9_s5_analog_no_numbers, // 0x8c
        wristaccessory_t9_s5_analog_onyx_sy, // 0x8d
        wristaccessory_t9_s5_analog_rainbow_jewel, // 0x8e
        wristaccessory_t9_s5_analog_retrotac, // 0x8f
        wristaccessory_t9_s5_analog_riptide, // 0x90
        wristaccessory_t9_s5_bracelet_sliver_chain, // 0x91
        wristaccessory_t9_s5_digital_arabian, // 0x92
        wristaccessory_t9_s5_digital_checkmate, // 0x93
        wristaccessory_t9_s5_digital_critical_kill, // 0x94
        wristaccessory_t9_s5_digital_dark_weaver, // 0x95
        wristaccessory_t9_s5_digital_ghosted, // 0x96
        wristaccessory_t9_s5_digital_judge_d, // 0x97
        wristaccessory_t9_s5_digital_mummy_cat, // 0x98
        wristaccessory_t9_s5_digital_rank_countdwn, // 0x99
        wristaccessory_t9_s5_digital_tagger, // 0x9a
        wristaccessory_t9_s5_digital_wonderland, // 0x9b
        wristaccessory_t9_s6_analog_agony, // 0x9c
        wristaccessory_t9_s6_analog_big_joke4_ms, // 0x9d
        wristaccessory_t9_s6_analog_big_joke4_pc, // 0x9e
        wristaccessory_t9_s6_analog_big_joke4_solo, // 0x9f
        wristaccessory_t9_s6_analog_big_joke4_sy, // 0xa0
        wristaccessory_t9_s6_analog_bite_me, // 0xa1
        wristaccessory_t9_s6_analog_blue_chroma, // 0xa2
        wristaccessory_t9_s6_analog_bog_ops, // 0xa3
        wristaccessory_t9_s6_analog_camo, // 0xa4
        wristaccessory_t9_s6_analog_cyber_venom, // 0xa5
        wristaccessory_t9_s6_analog_donnie, // 0xa6
        wristaccessory_t9_s6_analog_edutain, // 0xa7
        wristaccessory_t9_s6_analog_gilded, // 0xa8
        wristaccessory_t9_s6_analog_halloween, // 0xa9
        wristaccessory_t9_s6_analog_hypnosis, // 0xaa
        wristaccessory_t9_s6_analog_krieger, // 0xab
        wristaccessory_t9_s6_analog_scrapyard, // 0xac
        wristaccessory_t9_s6_analog_scream, // 0xad
        wristaccessory_t9_s6_analog_street_mech_sy, // 0xae
        wristaccessory_t9_s6_digital_atomic_ash, // 0xaf
        wristaccessory_t9_s6_digital_egyptian_fire, // 0xb0
        wristaccessory_t9_s6_digital_frost, // 0xb1
        wristaccessory_t9_s6_digital_gov1, // 0xb2
        wristaccessory_t9_s6_digital_gov2, // 0xb3
        wristaccessory_t9_s6_digital_rank_carnival, // 0xb4
        wristaccessory_t9_s6_digital_reaper_bunny, // 0xb5
        wristaccessory_t9_s6_digital_sultan, // 0xb6
        wristaccessory_t9_s6_digital_tagger_ms, // 0xb7
        wristaccessory_t9_s6_digital_tagger_pc, // 0xb8
        wristaccessory_t9_s6_digital_tagger_solo, // 0xb9
        wristaccessory_t9_s6_digital_tagger_sy, // 0xba
        wristaccessory_t9_s6_digital_undead_warrior, // 0xbb
        wristaccessory_t9_s6_digital_ww, // 0xbc
        wristaccessory_t9_s6_digital_zm_critical_kill, // 0xbd
        wristaccessory_test1, // 0xbe
        wristaccessory_test2 // 0xbf
    };

    // idx 0x3 members: 0x8c type: 0
    enum Executions {
        execution_004, // 0x0
        execution_001, // 0x1
        execution_002, // 0x2
        execution_003, // 0x3
        execution_005, // 0x4
        execution_007, // 0x5
        execution_009, // 0x6
        execution_010, // 0x7
        execution_013, // 0x8
        execution_014, // 0x9
        execution_015, // 0xa
        execution_016, // 0xb
        execution_017, // 0xc
        execution_018, // 0xd
        execution_020, // 0xe
        execution_021, // 0xf
        execution_022, // 0x10
        execution_023, // 0x11
        execution_024, // 0x12
        execution_025, // 0x13
        execution_026, // 0x14
        execution_027, // 0x15
        execution_028, // 0x16
        execution_029, // 0x17
        execution_030, // 0x18
        execution_031, // 0x19
        execution_032, // 0x1a
        execution_033, // 0x1b
        execution_034, // 0x1c
        execution_036, // 0x1d
        execution_037, // 0x1e
        execution_037r, // 0x1f
        execution_038, // 0x20
        execution_038r, // 0x21
        execution_039bc, // 0x22
        execution_040, // 0x23
        execution_040bc, // 0x24
        execution_042, // 0x25
        execution_043, // 0x26
        execution_045, // 0x27
        execution_048, // 0x28
        execution_049, // 0x29
        execution_051, // 0x2a
        execution_052, // 0x2b
        execution_058, // 0x2c
        execution_059, // 0x2d
        execution_061, // 0x2e
        execution_062, // 0x2f
        execution_063, // 0x30
        execution_064, // 0x31
        execution_065, // 0x32
        execution_066, // 0x33
        execution_067, // 0x34
        execution_069, // 0x35
        execution_070, // 0x36
        execution_074, // 0x37
        execution_078, // 0x38
        execution_080, // 0x39
        execution_081, // 0x3a
        execution_082, // 0x3b
        execution_083, // 0x3c
        execution_084, // 0x3d
        execution_086, // 0x3e
        execution_087, // 0x3f
        execution_088, // 0x40
        execution_089, // 0x41
        execution_096, // 0x42
        execution_097, // 0x43
        execution_098, // 0x44
        execution_099, // 0x45
        execution_100, // 0x46
        execution_101, // 0x47
        execution_108, // 0x48
        execution_110, // 0x49
        execution_111, // 0x4a
        execution_112, // 0x4b
        execution_113, // 0x4c
        execution_117, // 0x4d
        execution_118, // 0x4e
        execution_119, // 0x4f
        execution_120, // 0x50
        execution_121, // 0x51
        execution_123, // 0x52
        execution_124, // 0x53
        execution_125, // 0x54
        execution_126, // 0x55
        execution_127, // 0x56
        execution_128, // 0x57
        execution_129, // 0x58
        execution_130, // 0x59
        execution_132, // 0x5a
        execution_133, // 0x5b
        execution_134, // 0x5c
        execution_135, // 0x5d
        execution_136, // 0x5e
        execution_137, // 0x5f
        execution_138, // 0x60
        execution_139, // 0x61
        execution_140, // 0x62
        execution_141, // 0x63
        execution_142, // 0x64
        execution_143, // 0x65
        execution_144, // 0x66
        execution_145, // 0x67
        execution_146, // 0x68
        execution_147, // 0x69
        execution_148, // 0x6a
        execution_149, // 0x6b
        execution_150, // 0x6c
        execution_154, // 0x6d
        execution_157, // 0x6e
        execution_158, // 0x6f
        execution_159, // 0x70
        execution_160, // 0x71
        execution_161, // 0x72
        execution_162, // 0x73
        execution_163, // 0x74
        execution_166, // 0x75
        execution_171, // 0x76
        execution_172, // 0x77
        execution_173, // 0x78
        execution_174, // 0x79
        execution_176, // 0x7a
        execution_181, // 0x7b
        execution_182, // 0x7c
        execution_194, // 0x7d
        execution_196, // 0x7e
        execution_198, // 0x7f
        execution_199, // 0x80
        execution_201, // 0x81
        execution_202, // 0x82
        execution_203, // 0x83
        execution_204, // 0x84
        execution_205, // 0x85
        execution_206, // 0x86
        execution_207, // 0x87
        execution_208, // 0x88
        execution_209, // 0x89
        execution_210, // 0x8a
        execution_211 // 0x8b
    };

    // idx 0x4 members: 0xf2 type: 0
    enum Action {
        attack, // 0x0
        melee, // 0x1
        frag, // 0x2
        smoke, // 0x3
        breath_sprint, // 0x4
        usereload, // 0x5
        speed_throw, // 0x6
        actionslot1, // 0x7
        actionslot2, // 0x8
        actionslot3, // 0x9
        actionslot4, // 0xa
        actionslot5, // 0xb
        actionslot6, // 0xc
        actionslot7, // 0xd
        stance, // 0xe
        gostand, // 0xf
        adsstand, // 0x10
        specnext, // 0x11
        specprev, // 0x12
        togglespec, // 0x13
        melee_zoom, // 0x14
        changezoom, // 0x15
        weapnextinventory, // 0x16
        vehicleads, // 0x17
        gas, // 0x18
        reverse, // 0x19
        vehiclemoveleft, // 0x1a
        vehiclemoveright, // 0x1b
        handbrake, // 0x1c
        vehicleattack, // 0x1d
        vehiclesecondattack, // 0x1e
        vehicleboost, // 0x1f
        vehiclejump, // 0x20
        vehiclemoveup, // 0x21
        vehiclemovedown, // 0x22
        vehicleswitchseat, // 0x23
        vehicleseat1, // 0x24
        vehicleseat2, // 0x25
        vehicleseat3, // 0x26
        vehicleseat4, // 0x27
        vehicleseat5, // 0x28
        vehiclehorn, // 0x29
        vehicleability, // 0x2a
        vehiclelookforward, // 0x2b
        vehiclelookback, // 0x2c
        vehiclealtcontrol, // 0x2d
        vehiclefreelook, // 0x2e
        walk, // 0x2f
        forward, // 0x30
        back, // 0x31
        moveleft, // 0x32
        moveright, // 0x33
        movedown, // 0x34
        left, // 0x35
        right, // 0x36
        lookup, // 0x37
        lookdown, // 0x38
        strafe, // 0x39
        holdbreath, // 0x3a
        activate, // 0x3b
        reload, // 0x3c
        prone, // 0x3d
        mlook, // 0x3e
        sprint, // 0x3f
        scores, // 0x40
        map, // 0x41
        inventory, // 0x42
        inventoryzm, // 0x43
        scoreswz, // 0x44
        spraygesturewheel, // 0x45
        leanleft, // 0x46
        leanright, // 0x47
        weapoffhandspecial, // 0x48
        weapswitchhero, // 0x49
        raisestance, // 0x4a
        raisestancejump, // 0x4b
        lowerstance, // 0x4c
        mantle, // 0x4d
        armorrepair, // 0x4e
        centerview, // 0x4f
        zoomin, // 0x50
        zoomout, // 0x51
        battletrack_toggle, // 0x52
        battletrack_next, // 0x53
        cameraup, // 0x54
        cameradown, // 0x55
        freecampresetshift, // 0x56
        freecamfovincrease, // 0x57
        freecamfovdecrease, // 0x58
        cameraslowdown, // 0x59
        cameraspeedup, // 0x5a
        codcastercombokey, // 0x5b
        ping, // 0x5c
        callforhelp, // 0x5d
        equip_toggle_actionslot3, // 0x5e
        equip_toggle_throw, // 0x5f
        bind_drop_item_wz, // 0x60
        talk, // 0x61
        talk_in_private_channel, // 0x62
        donate_life, // 0x63
        flashlight, // 0x64
        camera_side, // 0x65
        codcasterZoomIn, // 0x66
        codcasterZoomOut, // 0x67
        codcasterForward, // 0x68
        codcasterBack, // 0x69
        codcasterMoveLeft, // 0x6a
        codcasterMoveRight, // 0x6b
        togglemenu, // 0x6c
        screenshotjpeg, // 0x6d
        screenshotpng, // 0x6e
        ui_opensocial, // 0x6f
        ui_opensettings, // 0x70
        ui_openstore, // 0x71
        ui_openfriends, // 0x72
        ui_openplayeraccount, // 0x73
        ui_muteall, // 0x74
        ui_mutevoice, // 0x75
        ui_mutevoiceinput, // 0x76
        ui_mutevoiceoutput, // 0x77
        ui_navup, // 0x78
        ui_navdown, // 0x79
        ui_navleft, // 0x7a
        ui_navright, // 0x7b
        ui_prevtab, // 0x7c
        ui_nexttab, // 0x7d
        ui_remove, // 0x7e
        ui_confirm, // 0x7f
        ui_acceptinvite, // 0x80
        ui_declineinvite, // 0x81
        ui_contextual1, // 0x82
        ui_contextual2, // 0x83
        ui_contextual3, // 0x84
        ui_contextual4, // 0x85
        ui_contextual5, // 0x86
        ui_contextual6, // 0x87
        ui_contextual7, // 0x88
        ui_contextual8, // 0x89
        chatmodelast, // 0x8a
        chatmodeparty, // 0x8b
        chatmodepublic, // 0x8c
        chatmodeteam, // 0x8d
        chatmodenext, // 0x8e
        chooseclass, // 0x8f
        chooseclass1, // 0x90
        chooseclass2, // 0x91
        chooseclass3, // 0x92
        chooseclass4, // 0x93
        chooseclass5, // 0x94
        chooseclass6, // 0x95
        chooseclass7, // 0x96
        chooseclass8, // 0x97
        chooseclass9, // 0x98
        chooseclass10, // 0x99
        chooseclass11, // 0x9a
        chooseclass12, // 0x9b
        toggleaerialcam, // 0x9c
        toggleaerialtether, // 0x9d
        toggleaerialrecenter, // 0x9e
        toggleaerialcentral, // 0x9f
        toggleaerialnearestplayerfocus, // 0xa0
        freecampreset1, // 0xa1
        freecampreset2, // 0xa2
        freecampreset3, // 0xa3
        freecampreset4, // 0xa4
        freecampreset5, // 0xa5
        freecampreset6, // 0xa6
        freecampreset7, // 0xa7
        freecampreset8, // 0xa8
        freecampreset9, // 0xa9
        freecampreset10, // 0xaa
        togglefreecam, // 0xab
        freecamfovreset, // 0xac
        toggleorbitalcamera, // 0xad
        togglefreecamhorizontalplane, // 0xae
        togglefreecamcollisions, // 0xaf
        codcaster_switchteamlisttype, // 0xb0
        codcaster_highlightprev, // 0xb1
        codcaster_highlightnext, // 0xb2
        codcaster_spectatehighlighted, // 0xb3
        codcaster_spectateplayer1, // 0xb4
        codcaster_spectateplayer2, // 0xb5
        codcaster_spectateplayer3, // 0xb6
        codcaster_spectateplayer4, // 0xb7
        codcaster_spectateplayer5, // 0xb8
        codcaster_spectateplayer6, // 0xb9
        codcaster_spectateplayer7, // 0xba
        codcaster_spectateplayer8, // 0xbb
        codcaster_spectateplayer9, // 0xbc
        codcaster_spectateplayer10, // 0xbd
        codcaster_togglescorestreakview, // 0xbe
        codcaster_togglefieldupgradeview, // 0xbf
        codcaster_togglexrays, // 0xc0
        codcaster_toggleminimap, // 0xc1
        codcaster_togglefullscreenmap, // 0xc2
        codcaster_toggledataview, // 0xc3
        codcaster_togglehud, // 0xc4
        codcaster_toggle_pauseresume, // 0xc5
        codcaster_opencodcasteroptions, // 0xc6
        autorun, // 0xc7
        weapnext, // 0xc8
        pause, // 0xc9
        inventory_weapon, // 0xca
        weapprev, // 0xcb
        togglebreath, // 0xcc
        slide, // 0xcd
        toggleads, // 0xce
        leaveads, // 0xcf
        voteyes, // 0xd0
        voteno, // 0xd1
        quickspray, // 0xd2
        dangerpingcallout, // 0xd3
        quickcycle_health, // 0xd4
        quickcycle_equipment, // 0xd5
        skip, // 0xd6
        scorestreak1, // 0xd7
        scorestreak2, // 0xd8
        scorestreak3, // 0xd9
        scorestreak4, // 0xda
        scorestreak_current, // 0xdb
        flourish, // 0xdc
        usebgb1, // 0xdd
        usebgb2, // 0xde
        usebgb3, // 0xdf
        usebgb4, // 0xe0
        quickconsume0, // 0xe1
        quickconsume1, // 0xe2
        fullloadout, // 0xe3
        weapswitchprimary, // 0xe4
        weapswitchsecondary, // 0xe5
        scorestreak_zm, // 0xe6
        scorestreak_wz, // 0xe7
        zm_vote_accept, // 0xe8
        zm_vote_decline, // 0xe9
        callout1, // 0xea
        callout2, // 0xeb
        callout3, // 0xec
        callout4, // 0xed
        callout5, // 0xee
        callout6, // 0xef
        callout7, // 0xf0
        switch_weap_mode // 0xf1
    };

    // idx 0x5 members: 0x98 type: 0
    enum MusicTracks {
        battletrack_bo1_115, // 0x0
        battletrack_bo1_damned, // 0x1
        battletrack_bo1_pentagon, // 0x2
        battletrack_bo1_rooftops, // 0x3
        battletrack_bo2_adrenaline, // 0x4
        battletrack_bo2_damned100ae, // 0x5
        battletrack_bo2_maintheme, // 0x6
        battletrack_bo2_shadows, // 0x7
        battletrack_bo3_damned3, // 0x8
        battletrack_bo3_filter, // 0x9
        battletrack_bo3_ignition, // 0xa
        battletrack_bo3_ilive, // 0xb
        battletrack_bo4_alistair, // 0xc
        battletrack_bo4_damned4, // 0xd
        battletrack_bo4_inferno, // 0xe
        battletrack_bo4_reflections, // 0xf
        battletrack_cdl_theme, // 0x10
        battletrack_season1_80shiphop_1, // 0x11
        battletrack_season1_80shiphop_2, // 0x12
        battletrack_season1_80shiphop_3, // 0x13
        battletrack_season1_80shits_1, // 0x14
        battletrack_season1_80shits_2, // 0x15
        battletrack_season1_80shits_3, // 0x16
        battletrack_season1_80srock_1, // 0x17
        battletrack_season1_80srock_2, // 0x18
        battletrack_season1_80srock_3, // 0x19
        battletrack_season2_80spop2_1, // 0x1a
        battletrack_season2_80spop2_2, // 0x1b
        battletrack_season2_80spop2_3, // 0x1c
        battletrack_season2_80spop3_1, // 0x1d
        battletrack_season2_80spop3_2, // 0x1e
        battletrack_season2_80spop3_3, // 0x1f
        battletrack_season2_80spop_1, // 0x20
        battletrack_season2_80spop_2, // 0x21
        battletrack_season2_80spop_3, // 0x22
        battletrack_season2_80srock2_1, // 0x23
        battletrack_season2_80srock2_2, // 0x24
        battletrack_season2_80srock2_3, // 0x25
        battletrack_season4_80shits2_1, // 0x26
        battletrack_season4_80shits2_2, // 0x27
        battletrack_season4_80shits2_3, // 0x28
        battletrack_season5_80shits3_1, // 0x29
        battletrack_season5_80shits3_2, // 0x2a
        battletrack_season5_80shits3_3, // 0x2b
        battletrack_trey_classified, // 0x2c
        battletrack_trey_farid, // 0x2d
        battletrack_trey_revenge, // 0x2e
        battletrack_trey_sandcastle, // 0x2f
        battletrack_waw_blackcats, // 0x30
        battletrack_waw_dogfire, // 0x31
        battletrack_waw_hellsgate, // 0x32
        battletrack_waw_wildcard, // 0x33
        musictrack_cp_amerika_1, // 0x34
        musictrack_cp_amerika_2, // 0x35
        musictrack_cp_amerika_3, // 0x36
        musictrack_cp_amerika_4, // 0x37
        musictrack_cp_amerika_5, // 0x38
        musictrack_cp_armada_1, // 0x39
        musictrack_cp_armada_2, // 0x3a
        musictrack_cp_armada_3, // 0x3b
        musictrack_cp_armada_4, // 0x3c
        musictrack_cp_armada_5, // 0x3d
        musictrack_cp_cuba_1, // 0x3e
        musictrack_cp_cuba_2, // 0x3f
        musictrack_cp_cuba_3, // 0x40
        musictrack_cp_cuba_4, // 0x41
        musictrack_cp_cuba_5, // 0x42
        musictrack_cp_duga_1, // 0x43
        musictrack_cp_duga_2, // 0x44
        musictrack_cp_kgb_1, // 0x45
        musictrack_cp_kgb_2, // 0x46
        musictrack_cp_kgb_3, // 0x47
        musictrack_cp_kgb_4, // 0x48
        musictrack_cp_kgb_5, // 0x49
        musictrack_cp_kgb_6, // 0x4a
        musictrack_cp_prisoner_1, // 0x4b
        musictrack_cp_prisoner_2, // 0x4c
        musictrack_cp_prisoner_3, // 0x4d
        musictrack_cp_prisoner_4, // 0x4e
        musictrack_cp_prisoner_5, // 0x4f
        musictrack_cp_prisoner_6, // 0x50
        musictrack_cp_siege_1, // 0x51
        musictrack_cp_siege_2, // 0x52
        musictrack_cp_stakeout_1, // 0x53
        musictrack_cp_stakeout_2, // 0x54
        musictrack_cp_stakeout_3, // 0x55
        musictrack_cp_stakeout_4, // 0x56
        musictrack_cp_takedown_1, // 0x57
        musictrack_cp_takedown_2, // 0x58
        musictrack_cp_takedown_3, // 0x59
        musictrack_cp_takedown_4, // 0x5a
        musictrack_cp_takedown_5, // 0x5b
        musictrack_cp_takedown_6, // 0x5c
        musictrack_cp_takedown_7, // 0x5d
        musictrack_cp_yamantau_1, // 0x5e
        musictrack_cp_yamantau_2, // 0x5f
        musictrack_cp_yamantau_3, // 0x60
        musictrack_cp_yamantau_4, // 0x61
        musictrack_cp_yamantau_5, // 0x62
        musictrack_doa_1, // 0x63
        musictrack_doa_10, // 0x64
        musictrack_doa_11, // 0x65
        musictrack_doa_12, // 0x66
        musictrack_doa_13, // 0x67
        musictrack_doa_14, // 0x68
        musictrack_doa_15, // 0x69
        musictrack_doa_16, // 0x6a
        musictrack_doa_17, // 0x6b
        musictrack_doa_18, // 0x6c
        musictrack_doa_19, // 0x6d
        musictrack_doa_2, // 0x6e
        musictrack_doa_3, // 0x6f
        musictrack_doa_4, // 0x70
        musictrack_doa_5, // 0x71
        musictrack_doa_6, // 0x72
        musictrack_doa_7, // 0x73
        musictrack_doa_8, // 0x74
        musictrack_doa_9, // 0x75
        musictrack_mp_nuketown_ee, // 0x76
        musictrack_mp_underscore_1, // 0x77
        musictrack_mp_underscore_2, // 0x78
        musictrack_mp_underscore_3, // 0x79
        musictrack_mp_underscore_4, // 0x7a
        musictrack_sr_abra, // 0x7b
        musictrack_sr_aminfil, // 0x7c
        musictrack_sr_avogadro, // 0x7d
        musictrack_sr_boa, // 0x7e
        musictrack_sr_brave, // 0x7f
        musictrack_sr_frequency, // 0x80
        musictrack_sr_generation, // 0x81
        musictrack_sr_lullaby, // 0x82
        musictrack_sr_pareidolia, // 0x83
        musictrack_sr_theone, // 0x84
        musictrack_sr_tribes, // 0x85
        musictrack_theme_campaign, // 0x86
        musictrack_theme_multiplayer, // 0x87
        musictrack_theme_multiplayer_blops1, // 0x88
        musictrack_theme_multiplayer_blops2, // 0x89
        musictrack_theme_multiplayer_blops3, // 0x8a
        musictrack_theme_multiplayer_blops4, // 0x8b
        musictrack_theme_titlescreen, // 0x8c
        musictrack_theme_titlescreen2, // 0x8d
        musictrack_theme_zombies, // 0x8e
        musictrack_zm_gold_ee, // 0x8f
        musictrack_zm_platinum_acidbunny, // 0x90
        musictrack_zm_platinum_berlin, // 0x91
        musictrack_zm_platinum_ee, // 0x92
        musictrack_zm_platinum_whatawaits, // 0x93
        musictrack_zm_platinum_wrath, // 0x94
        musictrack_zm_silver_ee, // 0x95
        musictrack_zm_tungsten_dystopia, // 0x96
        musictrack_zm_tungsten_ee // 0x97
    };

    // idx 0x6 members: 0x4 type: 0
    enum ProgressionMusicTracks {
        musictrack_theme_multiplayer_blops1, // 0x0
        musictrack_theme_multiplayer_blops2, // 0x1
        musictrack_theme_multiplayer_blops3, // 0x2
        musictrack_theme_multiplayer_blops4 // 0x3
    };

    // idx 0x7 members: 0x2 type: 0
    enum SuperFactions {
        superfaction_nato, // 0x0
        superfaction_warsaw_pact // 0x1
    };

    // idx 0x8 members: 0x15 type: 0
    enum cp_character_customization {
        prt_t9_cp_female_player, // 0x0
        prt_t9_cp_female_player_amerikatown, // 0x1
        prt_t9_cp_female_player_armada, // 0x2
        prt_t9_cp_female_player_duga, // 0x3
        prt_t9_cp_female_player_kgb, // 0x4
        prt_t9_cp_female_player_prisoner, // 0x5
        prt_t9_cp_female_player_revolucion, // 0x6
        prt_t9_cp_female_player_safehouse, // 0x7
        prt_t9_cp_female_player_siege, // 0x8
        prt_t9_cp_female_player_stakeout, // 0x9
        prt_t9_cp_male_player, // 0xa
        prt_t9_cp_male_player_amerikatown, // 0xb
        prt_t9_cp_male_player_armada, // 0xc
        prt_t9_cp_male_player_duga, // 0xd
        prt_t9_cp_male_player_kgb, // 0xe
        prt_t9_cp_male_player_prisoner, // 0xf
        prt_t9_cp_male_player_revolucion, // 0x10
        prt_t9_cp_male_player_safehouse, // 0x11
        prt_t9_cp_male_player_siege, // 0x12
        prt_t9_cp_male_player_stakeout, // 0x13
        prt_t9_cp_player // 0x14
    };

    // idx 0x9 members: 0x1 type: 0
    enum cp_cpzm_character_customization {
        prt_cp_female // 0x0
    };

    // idx 0xa members: 0x4 type: 0
    enum doa_character_customization {
        prt_doa_blue, // 0x0
        prt_doa_green, // 0x1
        prt_doa_red, // 0x2
        prt_doa_yellow // 0x3
    };

    // idx 0xb members: 0x22 type: 0
    enum prt_mp_cub_dgi_outfit_presets {
        mtx_outfit_mp_cub_dgi_infiltration, // 0x0
        c_t9_cub_pl_sicario, // 0x1
        c_t9_cub_pl_dgi_sicario_santeria, // 0x2
        c_t9_cub_pl_dgi_sicario_eldoctor, // 0x3
        c_t9_cub_pl_sicario_miami, // 0x4
        c_t9_cub_pl_sicario_urbano, // 0x5
        c_t9_cub_pl_dgi_havana, // 0x6
        c_t9_cub_pl_dgi_brawler, // 0x7
        c_t9_cub_pl_dgi_mechanic, // 0x8
        c_t9_cub_pl_dgi_hitman, // 0x9
        po_c_t9_cub_pl_dgi_barrio, // 0xa
        c_t9_cub_pl_dgi_commando, // 0xb
        c_t9_cub_pl_dgi_el_jefe, // 0xc
        c_t9_cub_pl_dgi_bongo, // 0xd
        c_t9_cub_pl_dgi_warlord, // 0xe
        c_t9_cub_pl_dgi_slasher, // 0xf
        po_c_t9_cub_pl_dgi_slasher_winter, // 0x10
        po_c_t9_cub_pl_dgi_slasher_brown, // 0x11
        c_t9_cub_pl_dgi_general, // 0x12
        c_t9_cub_pl_dgi_flick, // 0x13
        po_c_t9_cub_pl_dgi_flick_variant01, // 0x14
        po_c_t9_cub_pl_dgi_flick_variant02, // 0x15
        c_t9_cub_pl_dgi_tropas_pc, // 0x16
        c_t9_cub_pl_dgi_tropas_sy, // 0x17
        c_t9_cub_pl_dgi_tropas_ms, // 0x18
        c_t9_cub_pl_dgi_rebel_leader, // 0x19
        po_c_t9_cub_pl_dgi_rebel_leader_v1, // 0x1a
        po_c_t9_cub_pl_dgi_rebel_leader_v2, // 0x1b
        c_t9_cub_pl_dgi_lucha, // 0x1c
        c_t9_cub_pl_dgi_lucha_v2, // 0x1d
        c_t9_cub_pl_dgi_jack_base, // 0x1e
        c_t9_cub_pl_dgi_jack_pc, // 0x1f
        c_t9_cub_pl_dgi_jack_sy, // 0x20
        c_t9_cub_pl_dgi_jack_ms // 0x21
    };

    // idx 0xc members: 0x4 type: 0
    enum prt_mp_eg_quicksand_outfit_presets {
        c_t9_eg_pl_quicksand, // 0x0
        c_t9_eg_pl_quicksand_khopesh, // 0x1
        c_t9_eg_pl_quicksand_slither, // 0x2
        c_t9_eg_pl_quicksand_slither_1 // 0x3
    };

    // idx 0xd members: 0x3 type: 0
    enum prt_mp_esp_goe_bomber_outfit_presets {
        c_t9_esp_pl_goe_bomber, // 0x0
        c_t9_esp_pl_goe_bomber_dusty, // 0x1
        po_c_t9_esp_pl_goe_bomber_scrapmetal // 0x2
    };

    // idx 0xe members: 0xb type: 0
    enum prt_mp_fin_wraith_outfit_presets {
        c_t9_fin_pl_wraith, // 0x0
        po_c_t9_fin_pl_wraith_variant01, // 0x1
        po_c_t9_fin_pl_wraith_variant02, // 0x2
        po_c_t9_fin_pl_wraith_variant03, // 0x3
        po_c_t9_fin_pl_wraith_variant04, // 0x4
        c_t9_fin_pl_wraith_white_queen, // 0x5
        po_c_t9_fin_pl_wraith_white_queen_furious, // 0x6
        po_c_t9_fin_pl_wraith_white_queen_sandstorm, // 0x7
        c_t9_fin_pl_wraith_havoc, // 0x8
        c_t9_fin_pl_wraith_burnout, // 0x9
        c_t9_fin_pl_wraith_freya // 0xa
    };

    // idx 0xf members: 0xa type: 0
    enum prt_mp_fra_dgse_outfit_presets {
        c_t9_fra_pl_dgse_gign, // 0x0
        c_t9_fra_pl_dgse_infiltration, // 0x1
        c_t9_fra_pl_dgse_mademoiselle, // 0x2
        po_c_t9_fra_pl_dgse_mademoiselle_variant01, // 0x3
        po_c_t9_fra_pl_dgse_mademoiselle_variant02, // 0x4
        c_t9_fra_pl_dgse_amped, // 0x5
        c_t9_fra_pl_dgse_dakar, // 0x6
        c_t9_fra_pl_dgse_dakar_bandlands, // 0x7
        c_t9_fra_pl_dgse_dakar_proven, // 0x8
        c_t9_fra_pl_dgse_arc // 0x9
    };

    // idx 0x10 members: 0x27 type: 0
    enum prt_mp_gen_pl_esports_male_outfit_presets {
        po_c_t9_gen_pl_esports_male_cdl_home_pc, // 0x0
        po_c_t9_gen_pl_esports_male_cdl_home_ms, // 0x1
        po_c_t9_gen_pl_esports_male_cdl_home_sy, // 0x2
        po_c_t9_gen_pl_esports_male_faze_home_pc, // 0x3
        po_c_t9_gen_pl_esports_male_faze_home_ms, // 0x4
        po_c_t9_gen_pl_esports_male_faze_home_sy, // 0x5
        po_c_t9_gen_pl_esports_male_empire_home_pc, // 0x6
        po_c_t9_gen_pl_esports_male_empire_home_ms, // 0x7
        po_c_t9_gen_pl_esports_male_empire_home_sy, // 0x8
        po_c_t9_gen_pl_esports_male_mutineers_home_pc, // 0x9
        po_c_t9_gen_pl_esports_male_mutineers_home_ms, // 0xa
        po_c_t9_gen_pl_esports_male_mutineers_home_sy, // 0xb
        po_c_t9_gen_pl_esports_male_royalravens_home_pc, // 0xc
        po_c_t9_gen_pl_esports_male_royalravens_home_ms, // 0xd
        po_c_t9_gen_pl_esports_male_royalravens_home_sy, // 0xe
        po_c_t9_gen_pl_esports_male_guerillas_home_pc, // 0xf
        po_c_t9_gen_pl_esports_male_guerillas_home_ms, // 0x10
        po_c_t9_gen_pl_esports_male_guerillas_home_sy, // 0x11
        po_c_t9_gen_pl_esports_male_thieves_home_pc, // 0x12
        po_c_t9_gen_pl_esports_male_thieves_home_ms, // 0x13
        po_c_t9_gen_pl_esports_male_thieves_home_sy, // 0x14
        po_c_t9_gen_pl_esports_male_rokkr_home_pc, // 0x15
        po_c_t9_gen_pl_esports_male_rokkr_home_ms, // 0x16
        po_c_t9_gen_pl_esports_male_rokkr_home_sy, // 0x17
        po_c_t9_gen_pl_esports_male_subliners_home_pc, // 0x18
        po_c_t9_gen_pl_esports_male_subliners_home_ms, // 0x19
        po_c_t9_gen_pl_esports_male_subliners_home_sy, // 0x1a
        po_c_t9_gen_pl_esports_male_optic_home_pc, // 0x1b
        po_c_t9_gen_pl_esports_male_optic_home_ms, // 0x1c
        po_c_t9_gen_pl_esports_male_optic_home_sy, // 0x1d
        po_c_t9_gen_pl_esports_male_legion_home_pc, // 0x1e
        po_c_t9_gen_pl_esports_male_legion_home_ms, // 0x1f
        po_c_t9_gen_pl_esports_male_legion_home_sy, // 0x20
        po_c_t9_gen_pl_esports_male_surge_home_pc, // 0x21
        po_c_t9_gen_pl_esports_male_surge_home_ms, // 0x22
        po_c_t9_gen_pl_esports_male_surge_home_sy, // 0x23
        po_c_t9_gen_pl_esports_male_ultra_home_pc, // 0x24
        po_c_t9_gen_pl_esports_male_ultra_home_ms, // 0x25
        po_c_t9_gen_pl_esports_male_ultra_home_sy // 0x26
    };

    // idx 0x11 members: 0x27 type: 0
    enum prt_mp_gen_pl_esports_male_warsaw_outfit_presets {
        po_c_t9_gen_pl_esports_male_cdl_away_pc, // 0x0
        po_c_t9_gen_pl_esports_male_cdl_away_ms, // 0x1
        po_c_t9_gen_pl_esports_male_cdl_away_sy, // 0x2
        po_c_t9_gen_pl_esports_male_faze_away_pc, // 0x3
        po_c_t9_gen_pl_esports_male_faze_away_ms, // 0x4
        po_c_t9_gen_pl_esports_male_faze_away_sy, // 0x5
        po_c_t9_gen_pl_esports_male_empire_away_pc, // 0x6
        po_c_t9_gen_pl_esports_male_empire_away_ms, // 0x7
        po_c_t9_gen_pl_esports_male_empire_away_sy, // 0x8
        po_c_t9_gen_pl_esports_male_mutineers_away_pc, // 0x9
        po_c_t9_gen_pl_esports_male_mutineers_away_ms, // 0xa
        po_c_t9_gen_pl_esports_male_mutineers_away_sy, // 0xb
        po_c_t9_gen_pl_esports_male_royalravens_away_pc, // 0xc
        po_c_t9_gen_pl_esports_male_royalravens_away_ms, // 0xd
        po_c_t9_gen_pl_esports_male_royalravens_away_sy, // 0xe
        po_c_t9_gen_pl_esports_male_guerillas_away_pc, // 0xf
        po_c_t9_gen_pl_esports_male_guerillas_away_ms, // 0x10
        po_c_t9_gen_pl_esports_male_guerillas_away_sy, // 0x11
        po_c_t9_gen_pl_esports_male_thieves_away_pc, // 0x12
        po_c_t9_gen_pl_esports_male_thieves_away_ms, // 0x13
        po_c_t9_gen_pl_esports_male_thieves_away_sy, // 0x14
        po_c_t9_gen_pl_esports_male_rokkr_away_pc, // 0x15
        po_c_t9_gen_pl_esports_male_rokkr_away_ms, // 0x16
        po_c_t9_gen_pl_esports_male_rokkr_away_sy, // 0x17
        po_c_t9_gen_pl_esports_male_subliners_away_pc, // 0x18
        po_c_t9_gen_pl_esports_male_subliners_away_ms, // 0x19
        po_c_t9_gen_pl_esports_male_subliners_away_sy, // 0x1a
        po_c_t9_gen_pl_esports_male_optic_away_pc, // 0x1b
        po_c_t9_gen_pl_esports_male_optic_away_ms, // 0x1c
        po_c_t9_gen_pl_esports_male_optic_away_sy, // 0x1d
        po_c_t9_gen_pl_esports_male_legion_away_pc, // 0x1e
        po_c_t9_gen_pl_esports_male_legion_away_ms, // 0x1f
        po_c_t9_gen_pl_esports_male_legion_away_sy, // 0x20
        po_c_t9_gen_pl_esports_male_surge_away_pc, // 0x21
        po_c_t9_gen_pl_esports_male_surge_away_ms, // 0x22
        po_c_t9_gen_pl_esports_male_surge_away_sy, // 0x23
        po_c_t9_gen_pl_esports_male_ultra_away_pc, // 0x24
        po_c_t9_gen_pl_esports_male_ultra_away_ms, // 0x25
        po_c_t9_gen_pl_esports_male_ultra_away_sy // 0x26
    };

    // idx 0x12 members: 0x11 type: 0
    enum prt_mp_gen_starter1_outfit_presets {
        mtx_outfit_prt_mp_gen_starter1_default, // 0x0
        c_t9_gen_pl_starter1_hunter_rescue, // 0x1
        c_t9_gen_pl_starter1_hunter_rescue_lethal, // 0x2
        c_t9_gen_pl_starter1_hunter_rescue_charge, // 0x3
        c_t9_gen_pl_starter1_hunter_frontline, // 0x4
        c_t9_gen_pl_starter1_hunter_frontline_fall, // 0x5
        c_t9_gen_pl_starter1_hunter_frontline_winter, // 0x6
        c_t9_gen_pl_starter1_hunter_inferno, // 0x7
        c_t9_gen_pl_starter1_hunter_dash, // 0x8
        po_c_t9_gen_pl_starter1_hunter_dash_variant01, // 0x9
        po_c_t9_gen_pl_starter1_hunter_dash_variant02, // 0xa
        c_t9_gen_pl_starter1_hunter_eagle_eye, // 0xb
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_autumn, // 0xc
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_pitch, // 0xd
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_riptide, // 0xe
        po_c_t9_gen_pl_starter1_hunger_eagle_eye_arid, // 0xf
        c_t9_gen_pl_starter1_hunter_killer // 0x10
    };

    // idx 0x13 members: 0x14 type: 0
    enum prt_mp_gen_starter2_outfit_presets {
        mtx_outfit_prt_mp_gen_starter2_default, // 0x0
        c_t9_gen_pl_starter2_vargas_steel, // 0x1
        po_c_t9_gen_pl_starter2_vargas_steel_bunker, // 0x2
        c_t9_gen_pl_starter2_vargas_steel_tourist, // 0x3
        c_t9_gen_pl_starter2_vargas_bunker, // 0x4
        po_c_t9_gen_pl_starter2_vargas_bunker_alt1, // 0x5
        po_c_t9_gen_pl_starter2_vargas_bunker_alt2, // 0x6
        c_t9_gen_pl_starter2_vargas_finishline, // 0x7
        c_t9_gen_pl_starter2_vargas_stovepipe, // 0x8
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant01, // 0x9
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant02, // 0xa
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant03, // 0xb
        po_c_t9_gen_pl_starter2_vargas_stovepipe_variant04, // 0xc
        c_t9_gen_pl_starter2_vargas_major, // 0xd
        po_c_t9_gen_pl_starter2_vargas_major_variant01, // 0xe
        po_c_t9_gen_pl_starter2_vargas_major_variant02, // 0xf
        c_t9_gen_pl_starter2_vargas_bacano, // 0x10
        c_t9_gen_pl_starter2_vargas_bull_pc, // 0x11
        c_t9_gen_pl_starter2_vargas_bull_sy, // 0x12
        c_t9_gen_pl_starter2_vargas_bull_ms // 0x13
    };

    // idx 0x14 members: 0x17 type: 0
    enum prt_mp_gen_starter3_outfit_presets {
        mtx_outfit_prt_mp_gen_starter3_default, // 0x0
        po_c_t9_gen_pl_starter3_stone_seige, // 0x1
        c_t9_gen_pl_starter3_stone_seige_breach, // 0x2
        c_t9_gen_pl_starter3_stone_seige_clear, // 0x3
        c_t9_usa_pl_navyseal_knucklehead, // 0x4
        c_t9_usa_pl_navyseal_wolf, // 0x5
        c_t9_ger_pl_west_stealth, // 0x6
        c_t9_gen_pl_starter3_stone_ash, // 0x7
        c_t9_gen_pl_starter3_stone_storefront, // 0x8
        c_t9_gen_pl_starter3_stone_squelch, // 0x9
        c_t9_gen_pl_starter3_stone_stoned, // 0xa
        c_t9_gen_pl_starter3_stone_bugscreen, // 0xb
        c_t9_gen_pl_starter3_stone_carver, // 0xc
        c_t9_gen_pl_starter3_stone_jammy, // 0xd
        c_t9_gen_pl_starter3_stone_insurgent, // 0xe
        po_c_t9_gen_pl_starter3_stone_insurgent_variant01, // 0xf
        po_c_t9_gen_pl_starter3_stone_insurgent_variant02, // 0x10
        po_c_t9_gen_pl_starter3_stone_insurgent_variant03, // 0x11
        po_c_t9_gen_pl_starter3_stone_insurgent_vampire, // 0x12
        c_t9_gen_pl_starter3_stone_bollocks_pc, // 0x13
        c_t9_gen_pl_starter3_stone_bollocks_sy, // 0x14
        c_t9_gen_pl_starter3_stone_bollocks_ms, // 0x15
        po_c_t9_gen_pl_starter3_stone_ripper // 0x16
    };

    // idx 0x15 members: 0x18 type: 0
    enum prt_mp_gen_starter4_outfit_presets {
        mtx_outfit_prt_mp_gen_starter4_default, // 0x0
        c_t9_gen_pl_starter4_song_counter, // 0x1
        c_t9_gen_pl_starter4_song_counter_skirmish, // 0x2
        c_t9_gen_pl_starter4_song_counter_jinx, // 0x3
        c_t9_gen_pl_starter4_song_tiger, // 0x4
        po_c_t9_gen_pl_starter4_song_tiger_blue, // 0x5
        po_c_t9_gen_pl_starter4_song_tiger_tan, // 0x6
        c_t9_gen_pl_starter4_song_bloom, // 0x7
        po_c_t9_gen_pl_starter4_song_busted, // 0x8
        po_c_t9_gen_pl_starter4_song_busted_variant01, // 0x9
        po_c_t9_gen_pl_starter4_song_busted_variant02, // 0xa
        po_c_t9_gen_pl_starter4_song_busted_variant03, // 0xb
        po_c_t9_gen_pl_starter4_song_busted_variant04, // 0xc
        c_t9_gen_pl_starter4_song_backflip, // 0xd
        c_t9_gen_pl_starter4_song_flare, // 0xe
        c_t9_gen_pl_starter4_song_observer, // 0xf
        c_t9_gen_pl_starter4_song_observer_variant01, // 0x10
        c_t9_gen_pl_starter4_song_observer_variant02, // 0x11
        c_t9_gen_pl_starter4_song_dagger, // 0x12
        po_c_t9_gen_pl_starter4_dagger_v1, // 0x13
        po_c_t9_gen_pl_starter4_dagger_v2, // 0x14
        c_t9_gen_pl_starter4_song_mechanic_pc, // 0x15
        c_t9_gen_pl_starter4_song_mechanic_sy, // 0x16
        c_t9_gen_pl_starter4_song_mechanic_ms // 0x17
    };

    // idx 0x16 members: 0x17 type: 0
    enum prt_mp_gen_starter5_outfit_presets {
        mtx_outfit_prt_mp_gen_starter5_default, // 0x0
        c_t9_gen_pl_starter5_powers_dust, // 0x1
        po_c_t9_gen_pl_starter5_powers_dust_military, // 0x2
        c_t9_gen_pl_starter5_powers_dust_urban, // 0x3
        c_t9_gen_pl_starter5_powers_gun, // 0x4
        c_t9_gen_pl_starter5_powers_gun_v1, // 0x5
        c_t9_gen_pl_starter5_powers_gun_v2, // 0x6
        c_t9_gen_pl_starter5_powers_ffl, // 0x7
        c_t9_gen_pl_starter5_powers_cameroon, // 0x8
        c_t9_gen_pl_starter5_powers_cameroon_variant01, // 0x9
        c_t9_gen_pl_starter5_powers_cameroon_variant02, // 0xa
        c_t9_gen_pl_starter5_powers_cameroon_variant03, // 0xb
        c_t9_gen_pl_starter5_powers_cameroon_variant04, // 0xc
        c_t9_gen_pl_starter5_powers_desert, // 0xd
        c_t9_gen_starter5_powers_swift, // 0xe
        c_t9_gen_pl_starter5_powers_driver, // 0xf
        po_c_t9_gen_pl_starter5_powers_driver_variant01, // 0x10
        po_c_t9_gen_pl_starter5_powers_driver_variant02, // 0x11
        po_c_t9_gen_pl_starter5_powers_driver_variant03, // 0x12
        po_c_t9_gen_pl_starter5_powers_driver_variant04, // 0x13
        c_t9_gen_pl_starter5_powers_stealth, // 0x14
        po_c_t9_gen_pl_starter5_powers_stealth_variant01, // 0x15
        po_c_t9_gen_pl_starter5_powers_stealth_variant02 // 0x16
    };

    // idx 0x17 members: 0x6 type: 0
    enum prt_mp_ger_pl_maxis_outfit_presets {
        c_t9_ger_pl_maxis_dark, // 0x0
        c_t9_ger_pl_maxis_bride, // 0x1
        c_t9_ger_pl_maxis_traveler, // 0x2
        c_t9_ger_pl_maxis_scythe, // 0x3
        c_t9_ger_pl_maxis_lumens, // 0x4
        c_t9_ger_pl_maxis_berlin // 0x5
    };

    // idx 0x18 members: 0x22 type: 0
    enum prt_mp_ger_west_outfit_presets {
        mtx_outfit_mp_ger_west_infiltration, // 0x0
        c_t9_ger_pl_west_gsg9_3, // 0x1
        c_t9_ger_pl_west_gsg9_3_munchen, // 0x2
        po_c_t9_ger_pl_west_gsg9_3_wachter, // 0x3
        c_t9_ger_pl_west_raider, // 0x4
        c_t9_ger_pl_west_raider_bruiser, // 0x5
        c_t9_ger_pl_west_raider_wildcat, // 0x6
        c_t9_ger_pl_west_police, // 0x7
        c_t9_ger_pl_west_winter, // 0x8
        c_t9_ger_pl_west_swat, // 0x9
        c_t9_ger_pl_west_bomber, // 0xa
        c_t9_ger_pl_west_racer_xfinity_incentive, // 0xb
        c_t9_ger_pl_west_racer_sky_incentive, // 0xc
        po_c_t9_ger_pl_west_racer_ufo, // 0xd
        c_t9_ger_pl_west_nightops, // 0xe
        c_t9_ger_pl_west_paratrooper, // 0xf
        c_t9_ger_pl_west_carnage, // 0x10
        c_t9_ger_pl_west_gsg9_hardhat, // 0x11
        po_c_t9_ger_pl_west_gsg9_hardhat_v1, // 0x12
        c_t9_ger_pl_west_gsg9_hardhat_v2, // 0x13
        c_t9_ger_pl_west_gothic, // 0x14
        c_t9_ger_pl_west_klown, // 0x15
        c_t9_ger_pl_west_patrol, // 0x16
        c_t9_ger_pl_west_tagger_ii, // 0x17
        c_t9_ger_pl_west_professor, // 0x18
        c_t9_ger_pl_west_professor_v2, // 0x19
        c_t9_ger_pl_west_stalker, // 0x1a
        po_c_t9_ger_pl_west_stalker_tan, // 0x1b
        po_c_t9_ger_pl_west_stalker_blue, // 0x1c
        c_t9_ger_pl_west_judge_dredd, // 0x1d
        c_t9_ger_pl_west_judge_dredd_variant01, // 0x1e
        c_t9_ger_pl_west_stronghold, // 0x1f
        po_c_t9_ger_pl_west_stronghold_variant01, // 0x20
        po_c_t9_ger_pl_west_stronghold_variant02 // 0x21
    };

    // idx 0x19 members: 0x2 type: 0
    enum prt_mp_isr_lazar_outfit_presets {
        c_t9_isr_pl_lazar_idf, // 0x0
        prt_mp_isr_lazar_outfit_presets_dummy // 0x1
    };

    // idx 0x1a members: 0xb type: 0
    enum prt_mp_jps_kitsune_outfit_presets {
        c_t9_jpn_pl_kitsune, // 0x0
        po_c_t9_jpn_pl_kitsune_bosozoku, // 0x1
        po_c_t9_jpn_pl_kitsune_code, // 0x2
        po_c_t9_jpn_pl_kitsune_kunoichi, // 0x3
        po_c_t9_jpn_pl_kitsune_gothic, // 0x4
        c_t9_jpn_pl_kitsune_boss, // 0x5
        c_t9_jpn_pl_kitsune_ultra, // 0x6
        po_c_t9_jpn_pl_kitsune_ultra_shinrei, // 0x7
        po_c_t9_jpn_pl_kitsune_ultra_kogane, // 0x8
        c_t9_jpn_pl_kitsune_biteme, // 0x9
        po_c_t9_jpn_pl_kitsune_yokai // 0xa
    };

    // idx 0x1b members: 0xc type: 0
    enum prt_mp_lao_outfit_presets {
        c_t9_lao_pl_serpent, // 0x0
        c_t9_lao_pl_serpent_cobalt, // 0x1
        c_t9_lao_pl_serpent_ashen_scale, // 0x2
        c_t9_lao_pl_serpent_crimson_code, // 0x3
        c_t9_lao_pl_serpent_rattlesnake, // 0x4
        c_t9_lao_pl_serpent_warlord, // 0x5
        c_t9_lao_pl_serpent_warlord_tiger, // 0x6
        c_t9_lao_pl_serpent_warlord_infiltrator, // 0x7
        c_t9_lao_pl_serpent_overgrowth, // 0x8
        c_t9_lao_pl_serpent_haggler, // 0x9
        c_t9_lao_pl_serpent_shadow, // 0xa
        c_t9_lao_pl_serpent_hollow // 0xb
    };

    // idx 0x1c members: 0x7 type: 0
    enum prt_mp_nic_outfit_presets {
        c_t9_nic_pl_smuggler, // 0x0
        c_t9_nic_pl_smuggler_stinger, // 0x1
        c_t9_nic_pl_smuggler_whiskey, // 0x2
        po_c_t9_gen_pl_female_esports_pc, // 0x3
        po_c_t9_gen_pl_female_esports_sy, // 0x4
        po_c_t9_gen_pl_female_esports_ms, // 0x5
        c_t9_nic_pl_smuggler_mural // 0x6
    };

    // idx 0x1d members: 0x22 type: 0
    enum prt_mp_rus_kgb_outfit_presets {
        mtx_outfit_mp_rus_kgb_infiltration, // 0x0
        c_t9_rus_pl_kgb_assassin, // 0x1
        c_t9_rus_pl_kgb_burglar, // 0x2
        c_t9_rus_pl_kgb_burglar_blizzard, // 0x3
        c_t9_rus_pl_kgb_burglar_duck, // 0x4
        c_t9_rus_pl_kgb_tacticalgoth, // 0x5
        c_t9_rus_pl_kgb_shadow, // 0x6
        po_c_t9_rus_pl_kgb_urban, // 0x7
        c_t9_rus_pl_kgb_winter, // 0x8
        c_t9_rus_pl_kgb_thekid, // 0x9
        c_t9_rus_pl_kgb_thekid_militia, // 0xa
        c_t9_rus_pl_kgb_thekid_treehugger, // 0xb
        c_t9_rus_pl_kgb_gunshow, // 0xc
        c_t9_rus_pl_kgb_ghost, // 0xd
        c_t9_rus_pl_kgb_valentines, // 0xe
        c_t9_rus_pl_kgb_punk, // 0xf
        c_t9_rus_pl_kgb_bunny, // 0x10
        c_t9_rus_pl_kgb_funnybone, // 0x11
        c_t9_rus_pl_kgb_smoker, // 0x12
        c_t9_rus_pl_kgb_smoker_blitz, // 0x13
        c_t9_rus_pl_kgb_smoker_ridge, // 0x14
        c_t9_rus_pl_kgb_spyglass, // 0x15
        c_t9_rus_pl_kgb_poison, // 0x16
        c_t9_rus_pl_kgb_mach1_pc, // 0x17
        c_t9_rus_pl_kgb_mach1_sy, // 0x18
        c_t9_rus_pl_kgb_mach1_ms, // 0x19
        c_t9_rus_pl_kgb_hash, // 0x1a
        c_t9_rus_pl_kgb_infantry, // 0x1b
        po_c_t9_rus_pl_kgb_infantry_variant01, // 0x1c
        po_c_t9_rus_pl_kgb_infantry_variant02, // 0x1d
        po_c_t9_rus_pl_kgb_infantry_variant03, // 0x1e
        po_c_t9_rus_pl_kgb_infantry_variant04, // 0x1f
        c_t9_rus_pl_kgb_breakout, // 0x20
        c_t9_rus_pl_kgb_lab // 0x21
    };

    // idx 0x1e members: 0x7 type: 0
    enum prt_mp_rus_spetsnaz_outfit_presets {
        c_t9_rus_pl_spetsnaz_chernobyl, // 0x0
        c_t9_rus_pl_spetsnaz_grudge, // 0x1
        c_t9_rus_pl_spetsnaz_melted, // 0x2
        c_t9_rus_pl_spetsnaz_infiltration, // 0x3
        c_t9_rus_pl_spetsnaz_afghan_sniper, // 0x4
        po_c_t9_rus_pl_spetsnaz_afghan_sniper_variant01, // 0x5
        po_c_t9_rus_pl_spetsnaz_afghan_sniper_variant02 // 0x6
    };

    // idx 0x1f members: 0xf type: 0
    enum prt_mp_rus_stitch_outfit_presets {
        c_t9_rus_pl_stitch, // 0x0
        c_t9_rus_pl_stitch_marine, // 0x1
        c_t9_rus_pl_stitch_spectre, // 0x2
        c_t9_rus_pl_stitch_urban, // 0x3
        c_t9_rus_pl_stitch_undercover, // 0x4
        c_t9_rus_pl_stitch_prisoner, // 0x5
        c_t9_rus_pl_stitch_prisoner_punk, // 0x6
        c_t9_rus_pl_stitch_prisoner_stripes, // 0x7
        c_t9_rus_pl_stitch_cultist_ghoul, // 0x8
        po_c_t9_rus_pl_stitch_cultist_black_gold_pc, // 0x9
        po_c_t9_rus_pl_stitch_cultist_black_gold_sy, // 0xa
        po_c_t9_rus_pl_stitch_cultist_black_gold_ms, // 0xb
        c_t9_rus_pl_stitch_brute, // 0xc
        c_t9_rus_pl_stitch_torn, // 0xd
        c_t9_rus_pl_stitch_echo // 0xe
    };

    // idx 0x20 members: 0xb type: 0
    enum prt_mp_sa_deathstalker_outfit_presets {
        c_t9_sa_pl_deathstalker, // 0x0
        c_t9_sa_pl_deathstalker_urban, // 0x1
        c_t9_sa_pl_deathstalker_scorpion, // 0x2
        c_t9_sa_pl_deathstalker_hyena, // 0x3
        c_t9_sa_pl_deathstalker_shaman, // 0x4
        c_t9_sa_pl_deathstalker_snake, // 0x5
        c_t9_sa_pl_deathstalker_snake_water, // 0x6
        c_t9_sa_pl_deathstalker_snake_copper, // 0x7
        c_t9_sa_pl_deathstalker_bearclaw_pc, // 0x8
        c_t9_sa_pl_deathstalker_bearclaw_sy, // 0x9
        c_t9_sa_pl_deathstalker_bearclaw_ms // 0xa
    };

    // idx 0x21 members: 0x2 type: 0
    enum prt_mp_uk_kingsley_outfit_presets {
        c_t9_uk_pl_kingsley, // 0x0
        prt_mp_uk_kingsley_outfit_presets_dummy // 0x1
    };

    // idx 0x22 members: 0x2b type: 0
    enum prt_mp_uk_mi6_outfit_presets {
        mtx_outfit_mp_uk_mi6_infiltration, // 0x0
        e0po_c_t9_uk_pl_mi6_handler, // 0x1
        c_t9_uk_pl_mi6_heist, // 0x2
        c_t9_uk_pl_mi6_clandestine, // 0x3
        c_t9_uk_pl_mi6_doubleagent, // 0x4
        c_t9_uk_pl_mi6_tagger, // 0x5
        po_c_t9_uk_pl_mi6_snapshot, // 0x6
        c_t9_uk_pl_mi6_scorch, // 0x7
        c_t9_uk_pl_mi6_badblood, // 0x8
        c_t9_uk_pl_mi6_badblood_commando, // 0x9
        c_t9_uk_pl_mi6_badblood_glamour, // 0xa
        c_t9_uk_pl_mi6_survivor, // 0xb
        c_t9_uk_pl_mi6_survivor_autumn, // 0xc
        c_t9_uk_pl_mi6_survivor_solstice, // 0xd
        c_t9_uk_pl_mi6_glam, // 0xe
        c_t9_uk_pl_mi6_napalm, // 0xf
        c_t9_uk_pl_mi6_racer, // 0x10
        c_t9_uk_pl_mi6_fob, // 0x11
        po_c_t9_uk_pl_mi6_fob_v1, // 0x12
        po_c_t9_uk_pl_mi6_fob_v2, // 0x13
        c_t9_uk_pl_mi6_coal, // 0x14
        c_t9_uk_pl_mi6_coal_variant01, // 0x15
        c_t9_uk_pl_mi6_coal_variant02, // 0x16
        c_t9_uk_pl_mi6_coal_variant03, // 0x17
        c_t9_uk_pl_mi6_coal_variant04, // 0x18
        c_t9_uk_pl_mi6_dystopia, // 0x19
        c_t9_uk_pl_mi6_xray, // 0x1a
        c_t9_uk_pl_mi6_sis, // 0x1b
        c_t9_uk_pl_mi6_derby, // 0x1c
        c_t9_uk_pl_mi6_uncharted, // 0x1d
        c_t9_uk_pl_mi6_football, // 0x1e
        po_c_t9_uk_pl_mi6_football_uk, // 0x1f
        po_c_t9_uk_pl_mi6_football_french, // 0x20
        po_c_t9_uk_pl_mi6_football_germany, // 0x21
        c_t9_uk_pl_mi6_guard, // 0x22
        c_t9_uk_pl_mi6_skyhook_pc, // 0x23
        c_t9_uk_pl_mi6_skyhook_sy, // 0x24
        c_t9_uk_pl_mi6_skyhook_ms, // 0x25
        c_t9_uk_pl_mi6_ignite, // 0x26
        c_t9_uk_pl_mi6_checker, // 0x27
        po_c_t9_uk_pl_mi6_checker_variant01, // 0x28
        po_c_t9_uk_pl_mi6_checker_variant02, // 0x29
        c_t9_uk_pl_mi6_standoff // 0x2a
    };

    // idx 0x23 members: 0x2 type: 0
    enum prt_mp_uk_price_outfit_presets {
        c_t9_uk_pl_price, // 0x0
        prt_mp_uk_price_outfit_presets_dummy // 0x1
    };

    // idx 0x24 members: 0x2 type: 0
    enum prt_mp_uk_sas_outfit_presets {
        c_t9_uk_pl_sas_blackknight, // 0x0
        c_t9_uk_pl_sas_gridlock // 0x1
    };

    // idx 0x25 members: 0x8 type: 0
    enum prt_mp_usa_bulldozer_outfit_presets {
        c_t9_usa_pl_bulldozer_01, // 0x0
        c_t9_usa_pl_bulldozer_toxin, // 0x1
        c_t9_usa_pl_bulldozer_hawk, // 0x2
        c_t9_usa_pl_bulldozer_boom, // 0x3
        c_t9_usa_pl_bulldozer_forged, // 0x4
        c_t9_usa_pl_bulldozer_panda, // 0x5
        po_c_t9_usa_pl_bulldozer_panda_variant01, // 0x6
        po_c_t9_usa_pl_bulldozer_panda_variant02 // 0x7
    };

    // idx 0x26 members: 0x22 type: 0
    enum prt_mp_usa_cia_outfit_presets {
        mtx_outfit_mp_usa_cia_infiltration, // 0x0
        c_t9_usa_pl_cia_frostbite, // 0x1
        c_t9_usa_pl_cia_regulator, // 0x2
        c_t9_usa_pl_cia_logger, // 0x3
        c_t9_usa_pl_cia_grit, // 0x4
        c_t9_usa_pl_cia_grit_street, // 0x5
        c_t9_usa_pl_cia_grit_blockparty, // 0x6
        c_t9_usa_pl_cia_boss, // 0x7
        c_t9_usa_pl_cia_covert, // 0x8
        c_t9_usa_pl_cia_macv, // 0x9
        c_t9_usa_pl_cia_sogman, // 0xa
        c_t9_usa_pl_cia_sog_tee, // 0xb
        c_t9_usa_pl_cia_commando, // 0xc
        po_c_t9_usa_pl_cia_penumbra_ms, // 0xd
        po_c_t9_usa_pl_cia_penumbra_pc, // 0xe
        po_c_t9_usa_pl_cia_penumbra_sy, // 0xf
        c_t9_usa_pl_deltaforce_urgentfury, // 0x10
        po_c_t9_usa_pl_deltaforce_urgentfury_ranger_scout, // 0x11
        po_c_t9_usa_pl_deltaforce_urgentfury_airborne, // 0x12
        c_t9_usa_pl_cia_advisor, // 0x13
        c_t9_usa_pl_cia_advisor_variant01, // 0x14
        c_t9_usa_pl_cia_advisor_variant02, // 0x15
        c_t9_usa_pl_cia_snatch, // 0x16
        c_t9_usa_pl_cia_big_joke3, // 0x17
        c_t9_usa_pl_cia_captain, // 0x18
        po_c_t9_usa_pl_cia_captain_variant01, // 0x19
        po_c_t9_usa_pl_cia_captain_variant02, // 0x1a
        po_c_t9_usa_pl_cia_captain_variant03, // 0x1b
        po_c_t9_usa_pl_cia_captain_variant04, // 0x1c
        po_c_t9_usa_pl_cia_macv_code_pc, // 0x1d
        po_c_t9_usa_pl_cia_macv_code_sy, // 0x1e
        po_c_t9_usa_pl_cia_macv_code_ms, // 0x1f
        c_t9_usa_pl_cia_agent, // 0x20
        c_t9_usa_pl_cia_kick // 0x21
    };

    // idx 0x27 members: 0xa type: 0
    enum prt_mp_usa_deltaforce_outfit_presets {
        c_t9_usa_pl_deltaforce_jungle_warfare, // 0x0
        c_t9_usa_pl_deltaforce_dynamite, // 0x1
        c_t9_usa_pl_deltaforce_cyclone, // 0x2
        c_t9_usa_pl_deltaforce_halo, // 0x3
        po_c_t9_usa_pl_deltaforce_halo_variant01, // 0x4
        po_c_t9_usa_pl_deltaforce_halo_variant02, // 0x5
        c_t9_usa_pl_deltaforce_brutalist_base, // 0x6
        c_t9_usa_pl_deltaforce_brutalist_pc, // 0x7
        c_t9_usa_pl_deltaforce_brutalist_sy, // 0x8
        c_t9_usa_pl_deltaforce_brutalist_ms // 0x9
    };

    // idx 0x28 members: 0x2 type: 0
    enum prt_mp_usa_ghostface_outfit_presets {
        c_t9_usa_pl_ghostface, // 0x0
        prt_mp_usa_ghostface_outfit_presets_dummy // 0x1
    };

    // idx 0x29 members: 0x26 type: 0
    enum prt_mp_usa_hero_adler_outfit_presets {
        mtx_outfit_mp_usa_hero_adler_infiltration, // 0x0
        c_t9_usa_pl_adler_bloodhound, // 0x1
        c_t9_usa_pl_adler_bloodhound_dusk, // 0x2
        c_t9_usa_pl_adler_bloodhound_glitz, // 0x3
        c_t9_usa_pl_adler_traveler, // 0x4
        c_t9_usa_pl_adler_traveler_summit, // 0x5
        c_t9_usa_pl_adler_traveler_windbreaker, // 0x6
        c_t9_usa_pl_adler_ranger, // 0x7
        c_t9_usa_pl_adler_detective, // 0x8
        po_c_t9_usa_pl_adler_detective_juice_pc, // 0x9
        po_c_t9_usa_pl_adler_detective_juice_ms, // 0xa
        po_c_t9_usa_pl_adler_detective_juice_sy, // 0xb
        c_t9_usa_pl_adler_gunslinger, // 0xc
        c_t9_usa_pl_adler_gunslinger_whiskey, // 0xd
        c_t9_usa_pl_adler_gunslinger_smokey, // 0xe
        po_c_t9_usa_pl_adler_miami, // 0xf
        c_t9_usa_pl_adler_game_fuel, // 0x10
        c_t9_usa_pl_adler_wire, // 0x11
        c_t9_usa_pl_adler_renegade, // 0x12
        c_t9_usa_pl_adler_renegade_gonefishin, // 0x13
        c_t9_usa_pl_adler_renegade_asphalt, // 0x14
        c_t9_usa_pl_adler_renegade_goblin, // 0x15
        c_t9_usa_pl_adler_renegade_redshirt, // 0x16
        c_t9_usa_pl_adler_gator, // 0x17
        c_t9_usa_pl_adler_tropic, // 0x18
        c_t9_usa_pl_adler_red, // 0x19
        c_t9_usa_pl_adler_hostage, // 0x1a
        c_t9_usa_pl_adler_buoy, // 0x1b
        c_t9_usa_pl_adler_vbss, // 0x1c
        po_c_t9_usa_pl_adler_vbss_variant_01, // 0x1d
        po_c_t9_usa_pl_adler_vbss_variant_02, // 0x1e
        c_t9_usa_pl_adler_pressed, // 0x1f
        c_t9_usa_pl_adler_lancer, // 0x20
        c_t9_usa_pl_adler_slayer, // 0x21
        c_t9_usa_pl_adler_airborne, // 0x22
        c_t9_usa_pl_adler_control, // 0x23
        po_c_t9_usa_pl_adler_control_variant01, // 0x24
        po_c_t9_usa_pl_adler_control_variant02 // 0x25
    };

    // idx 0x2a members: 0x5 type: 0
    enum prt_mp_usa_hudson_outfit_presets {
        c_t9_usa_pl_hudson, // 0x0
        c_t9_usa_pl_hudson_hazmat_pc, // 0x1
        c_t9_usa_pl_hudson_hazmat_sy, // 0x2
        c_t9_usa_pl_hudson_hazmat_ms, // 0x3
        c_t9_usa_pl_hudson_rock // 0x4
    };

    // idx 0x2b members: 0xb type: 0
    enum prt_mp_usa_mason_outfit_presets {
        c_t9_usa_pl_mason, // 0x0
        po_c_t9_usa_pl_mason_variant01, // 0x1
        po_c_t9_usa_pl_mason_variant02, // 0x2
        po_c_t9_usa_pl_mason_variant03, // 0x3
        po_c_t9_usa_pl_mason_variant04, // 0x4
        c_t9_usa_pl_mason_ultra, // 0x5
        po_c_t9_usa_pl_mason_ultra_variant01, // 0x6
        po_c_t9_usa_pl_mason_ultra_variant02, // 0x7
        po_c_t9_usa_pl_mason_ultra_variant03, // 0x8
        po_c_t9_usa_pl_mason_ultra_variant04, // 0x9
        po_c_t9_usa_pl_mason_headgame // 0xa
    };

    // idx 0x2c members: 0x2 type: 0
    enum prt_mp_usa_mcclane_outfit_presets {
        po_c_t9_usa_pl_mcclane_preset_1, // 0x0
        prt_mp_usa_mcclane_outfit_presets_dummy // 0x1
    };

    // idx 0x2d members: 0x2a type: 0
    enum prt_mp_usa_navy_seal_outfit_presets {
        mtx_outfit_mp_usa_navy_seal_infiltration, // 0x0
        c_t9_usa_pl_navyseal_slugger, // 0x1
        po_c_t9_usa_pl_navyseal_dissident, // 0x2
        c_t9_usa_pl_navyseal_maverick, // 0x3
        c_t9_usa_pl_navyseal_maverick_jackal, // 0x4
        c_t9_usa_pl_navyseal_maverick_pitcher, // 0x5
        c_t9_usa_pl_navyseal_clown, // 0x6
        c_t9_usa_pl_navyseal_solitude, // 0x7
        c_t9_usa_pl_navyseal_gigawatt, // 0x8
        c_t9_usa_pl_navyseal_gigawho, // 0x9
        c_t9_usa_pl_navyseal_gigawhen, // 0xa
        c_t9_usa_pl_navyseal_hunter, // 0xb
        c_t9_usa_pl_navyseal_sniper, // 0xc
        c_t9_usa_pl_navyseal_ringleader, // 0xd
        po_c_t9_usa_pl_navyseal_land_pc, // 0xe
        po_c_t9_usa_pl_navyseal_land_ms, // 0xf
        po_c_t9_usa_pl_navyseal_land_sy, // 0x10
        po_c_t9_usa_pl_navyseal_air_pc, // 0x11
        po_c_t9_usa_pl_navyseal_air_ms, // 0x12
        po_c_t9_usa_pl_navyseal_air_sy, // 0x13
        po_c_t9_usa_pl_navyseal_sea_pc, // 0x14
        po_c_t9_usa_pl_navyseal_sea_ms, // 0x15
        po_c_t9_usa_pl_navyseal_sea_sy, // 0x16
        c_t9_usa_pl_navyseal_breaker, // 0x17
        c_t9_usa_pl_navyseal_strike, // 0x18
        po_c_t9_usa_pl_navyseal_endurance_sy, // 0x19
        po_c_t9_usa_pl_navyseal_endurance_ms, // 0x1a
        po_c_t9_usa_pl_navyseal_endurance_pc, // 0x1b
        c_t9_usa_pl_navyseal_bluedevil, // 0x1c
        po_c_t9_usa_pl_navyseal_bluedevil_variant01, // 0x1d
        po_c_t9_usa_pl_navyseal_bluedevil_variant02, // 0x1e
        c_t9_usa_pl_navyseal_business, // 0x1f
        c_t9_usa_pl_navyseal_grunge, // 0x20
        c_t9_usa_pl_navyseal_frogman, // 0x21
        c_t9_usa_pl_navyseal_frogman_variant01, // 0x22
        c_t9_usa_pl_navyseal_frogman_variant02, // 0x23
        c_t9_usa_pl_navyseal_hopper, // 0x24
        c_t9_usa_pl_navyseal_hopper_v2, // 0x25
        c_t9_usa_pl_navyseal_grip, // 0x26
        po_c_t9_usa_pl_navyseal_grip_variant01, // 0x27
        po_c_t9_usa_pl_navyseal_grip_variant02, // 0x28
        c_t9_usa_pl_navyseal_frank // 0x29
    };

    // idx 0x2e members: 0x2 type: 0
    enum prt_mp_usa_rambo_outfit_presets {
        c_t9_usa_pl_rambo, // 0x0
        prt_mp_usa_rambo_outfit_presets_dummy // 0x1
    };

    // idx 0x2f members: 0x2 type: 0
    enum prt_mp_usa_surge_outfit_presets {
        c_t9_usa_pl_surge, // 0x0
        po_c_t9_usa_pl_surge_meta // 0x1
    };

    // idx 0x30 members: 0x4 type: 0
    enum prt_mp_usa_weaver_outfit_presets {
        c_t9_usa_pl_weaver_cosmodrome, // 0x0
        c_t9_usa_pl_weaver_rebirth, // 0x1
        c_t9_usa_pl_weaver_sons_of_orda, // 0x2
        c_t9_usa_pl_weaver_sons_of_orda_pulsar // 0x3
    };

    // idx 0x31 members: 0x1d type: 0
    enum prt_mp_usa_woods_outfit_presets {
        mtx_outfit_mp_usa_woods_infiltration, // 0x0
        c_t9_usa_woods_pl_eliminator, // 0x1
        c_t9_usa_pl_woods_biker, // 0x2
        c_t9_usa_pl_woods_fisherman, // 0x3
        c_t9_usa_pl_woods_eagleclaw, // 0x4
        c_t9_usa_pl_woods_eagleclaw_metro, // 0x5
        c_t9_usa_pl_woods_eagleclaw_undergrowth, // 0x6
        c_t9_usa_pl_woods_sandstorm, // 0x7
        c_t9_usa_pl_woods_holidaywoods, // 0x8
        c_t9_usa_pl_woods_trucker, // 0x9
        c_t9_usa_pl_woods_rogue, // 0xa
        c_t9_usa_pl_cia_pow, // 0xb
        c_t9_usa_pl_woods_swamp, // 0xc
        c_t9_usa_pl_woods_slaughter, // 0xd
        c_t9_usa_pl_woods_mellow, // 0xe
        c_t9_usa_pl_woods_whirlwind, // 0xf
        c_t9_usa_pl_woods_whirlwind_fire, // 0x10
        c_t9_usa_pl_woods_whirlwind_air, // 0x11
        c_t9_usa_pl_woods_conquer, // 0x12
        c_t9_usa_pl_woods_payback, // 0x13
        po_c_t9_usa_pl_woods_payback_variant01, // 0x14
        po_c_t9_usa_pl_woods_payback_variant02, // 0x15
        c_t9_usa_pl_woods_dope, // 0x16
        c_t9_usa_pl_woods_dapper, // 0x17
        c_t9_usa_pl_woods_haha, // 0x18
        po_c_t9_usa_pl_woods_haha_variant01, // 0x19
        po_c_t9_usa_pl_woods_haha_variant02, // 0x1a
        po_c_t9_usa_pl_woods_haha_variant03, // 0x1b
        po_c_t9_usa_pl_woods_haha_variant04 // 0x1c
    };

    // idx 0x32 members: 0x27 type: 0
    enum mp_character_customization {
        prt_mp_cub_dgi, // 0x0
        prt_mp_eg_quicksand, // 0x1
        prt_mp_esp_goe_bomber, // 0x2
        prt_mp_fin_wraith, // 0x3
        prt_mp_fra_dgse, // 0x4
        prt_mp_gen_pl_esports_male, // 0x5
        prt_mp_gen_pl_esports_male_warsaw, // 0x6
        prt_mp_gen_starter1, // 0x7
        prt_mp_gen_starter2, // 0x8
        prt_mp_gen_starter3, // 0x9
        prt_mp_gen_starter4, // 0xa
        prt_mp_gen_starter5, // 0xb
        prt_mp_ger_pl_maxis, // 0xc
        prt_mp_ger_west, // 0xd
        prt_mp_isr_lazar, // 0xe
        prt_mp_jps_kitsune, // 0xf
        prt_mp_lao, // 0x10
        prt_mp_nic, // 0x11
        prt_mp_rus_kgb, // 0x12
        prt_mp_rus_spetsnaz, // 0x13
        prt_mp_rus_stitch, // 0x14
        prt_mp_sa_deathstalker, // 0x15
        prt_mp_uk_kingsley, // 0x16
        prt_mp_uk_mi6, // 0x17
        prt_mp_uk_price, // 0x18
        prt_mp_uk_sas, // 0x19
        prt_mp_usa_bulldozer, // 0x1a
        prt_mp_usa_cia, // 0x1b
        prt_mp_usa_deltaforce, // 0x1c
        prt_mp_usa_ghostface, // 0x1d
        prt_mp_usa_hero_adler, // 0x1e
        prt_mp_usa_hudson, // 0x1f
        prt_mp_usa_mason, // 0x20
        prt_mp_usa_mcclane, // 0x21
        prt_mp_usa_navy_seal, // 0x22
        prt_mp_usa_rambo, // 0x23
        prt_mp_usa_surge, // 0x24
        prt_mp_usa_weaver, // 0x25
        prt_mp_usa_woods // 0x26
    };

    // idx 0x33 members: 0x8 type: 0
    enum zm_character_customization {
        prt_zm_dempsey, // 0x0
        prt_zm_dempsey_ofc, // 0x1
        prt_zm_nikolai, // 0x2
        prt_zm_nikolai_ofc, // 0x3
        prt_zm_richtofen, // 0x4
        prt_zm_richtofen_ofc, // 0x5
        prt_zm_takeo, // 0x6
        prt_zm_takeo_ofc // 0x7
    };

    // root: bitSize: 0x4470, members: 80

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    string(32) map;
    // offset: 0x100, bitSize: 0x800(0x100 Byte(s))
    string(256) motd;
    // offset: 0x900, bitSize: 0x8(0x1 Byte(s))
    int:8 default_emblem_index;
    // offset: 0x908, bitSize: 0x20(0x4 Byte(s))
    uint party_maxplayers;
    // offset: 0x928, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutZMOnline;
    // offset: 0x930, bitSize: 0x90(0x12 Byte(s)), array:0x2(hti:0x7)
    CharacterContext characterContext[SuperFactions];
    // offset: 0x9c0, bitSize: 0xf20(0x1e4 Byte(s)), array:0xf2(hti:0x4)
    KeyBind keybinds[Action];
    // offset: 0x18e0, bitSize: 0x20(0x4 Byte(s))
    float safeAreaTweakable_vertical;
    // offset: 0x1900, bitSize: 0x10(0x2 Byte(s))
    int:11 default_background_index;
    // offset: 0x1910, bitSize: 0x8(0x1 Byte(s))
    uint:3 selectedCharacterMode;
    // offset: 0x1918, bitSize: 0xde0(0x1bc Byte(s))
    GameplaySettings gameplaySettings;
    // offset: 0x26f8, bitSize: 0x20(0x4 Byte(s))
    uint com_first_time;
    // offset: 0x2718, bitSize: 0x8(0x1 Byte(s))
    uint:3 online_vs_bots_difficulty;
    // offset: 0x2720, bitSize: 0x1130(0x226 Byte(s)), array:0x32(hti:0xffff)
    SelectedCharacter characters[50];
    // offset: 0x3850, bitSize: 0x20(0x4 Byte(s))
    uint cg_playerState;
    // offset: 0x3870, bitSize: 0x8(0x1 Byte(s))
    uint:4 freerunHighestTrack;
    // offset: 0x3878, bitSize: 0x40(0x8 Byte(s))
    uint64 modified_timestamp;
    // offset: 0x38b8, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOffline;
    // offset: 0x38c0, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOnlineArena;
    // offset: 0x38c8, bitSize: 0x8(0x1 Byte(s))
    uint:5 season_movie_seen_mp;
    // offset: 0x38d0, bitSize: 0x8(0x1 Byte(s))
    uint:5 season_movie_seen_zm;
    // offset: 0x38d8, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_cp;
    // offset: 0x39d8, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_wz;
    // offset: 0x3ad8, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_zm;
    // offset: 0x3bd8, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_solomatch;
    // offset: 0x3be8, bitSize: 0x8(0x1 Byte(s))
    uint:2 quick_launch_mode;
    // offset: 0x3bf0, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_offline_cpzm;
    // offset: 0x3bf8, bitSize: 0x20(0x4 Byte(s))
    float safeAreaTweakable_horizontal;
    // offset: 0x3c18, bitSize: 0x20(0x4 Byte(s))
    uint eliteRegistrationPopupTimesShown;
    // offset: 0x3c38, bitSize: 0x8(0x1 Byte(s))
    uint:5 lastLoadoutLeague;
    // offset: 0x3c40, bitSize: 0x8(0x1 Byte(s))
    uint:5 lastLoadoutOnline;
    // offset: 0x3c48, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_offline_cp;
    // offset: 0x3c50, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_mp;
    // offset: 0x3c60, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_wz;
    // offset: 0x3c70, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_zm;
    // offset: 0x3c80, bitSize: 0x8(0x1 Byte(s))
    uint:4 character_class;
    // offset: 0x3c88, bitSize: 0x8(0x1 Byte(s))
    uint:5 lastLoadoutSystemlink;
    // offset: 0x3c90, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype;
    // offset: 0x3d90, bitSize: 0x20(0x4 Byte(s))
    uint takeCoverWarnings;
    // offset: 0x3db0, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutZMOffline;
    // offset: 0x3db8, bitSize: 0x100(0x20 Byte(s))
    string(32) scoreboardSortKey;
    // offset: 0x3eb8, bitSize: 0x8(0x1 Byte(s))
    uint:5 emblem;
    // offset: 0x3ec0, bitSize: 0x8(0x1 Byte(s))
    uint:7 emblem_grid_size;
    // offset: 0x3ec8, bitSize: 0x100(0x20 Byte(s))
    string(32) map_cp;
    // offset: 0x3fc8, bitSize: 0x100(0x20 Byte(s))
    string(32) map_wz;
    // offset: 0x40c8, bitSize: 0x100(0x20 Byte(s))
    string(32) map_zm;
    // offset: 0x41c8, bitSize: 0x8(0x1 Byte(s))
    uint:5 selectedCharacterIndex;
    // offset: 0x41d0, bitSize: 0x100(0x20 Byte(s))
    string(32) gametype_bots;
    // offset: 0x42d0, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill;
    // offset: 0x42d8, bitSize: 0x60(0xc Byte(s)), array:0x3(hti:0xffff)
    int padding[3];
    // offset: 0x4338, bitSize: 0x8(0x1 Byte(s))
    uint:3 intro_movie_seen_mp;
    // offset: 0x4340, bitSize: 0x8(0x1 Byte(s))
    uint:3 intro_movie_seen_zm;
    // offset: 0x4348, bitSize: 0x8(0x1 Byte(s))
    uint:2 identity_initialized;
    // offset: 0x4350, bitSize: 0x8(0x1 Byte(s))
    int:8 settings_version;
    // offset: 0x4358, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_online_cp;
    // offset: 0x4360, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOnlineCustom;
    // offset: 0x4368, bitSize: 0x10(0x2 Byte(s))
    uint:11 playlist_arena;
    // offset: 0x4378, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutMPOnlinePublic;
    // offset: 0x4380, bitSize: 0x8(0x1 Byte(s))
    uint:7 paintshop_grid_size;
    // offset: 0x4388, bitSize: 0x8(0x1 Byte(s))
    uint:3 g_gameskill_online_cpzm;
    // offset: 0x4390, bitSize: 0x8(0x1 Byte(s))
    uint:8 lastLoadoutZMCustom;
    // offset: 0x4398, bitSize: 0x1
    bool com_first_time_mission_select;
    // offset: 0x4399, bitSize: 0x1
    bool music_player_initialized;
    // offset: 0x439a, bitSize: 0x1
    bool eula_third_time;
    // offset: 0x439b, bitSize: 0x1
    SuperFactions superFaction;
    // offset: 0x439c, bitSize: 0x1
    bool cg_spectateThirdPerson;
    // offset: 0x439d, bitSize: 0x1
    bool com_first_time_account_linked;
    // offset: 0x439e, bitSize: 0x1
    bool com_firsttime_freerun;
    // offset: 0x439f, bitSize: 0x1
    bool com_privategame_ranked_zm;
    // offset: 0x43a0, bitSize: 0x1
    bool offline_identity_initialized;
    // offset: 0x43a1, bitSize: 0x1
    bool eula_second_time;
    // offset: 0x43a2, bitSize: 0x1
    bool start_in_3d;
    // offset: 0x43a3, bitSize: 0x27, array:0x27(hti:0x32)
    bool playedCharacterIntro[mp_character_customization];
    // offset: 0x43ca, bitSize: 0x1
    bool FTUE_prestige_played;
    // offset: 0x43cb, bitSize: 0x1
    bool isSuperFactionInitialized;
    // offset: 0x43cc, bitSize: 0x1
    bool com_first_time_privategame_host_zm;
    // offset: 0x43cd, bitSize: 0x1
    bool commonInitialized;
    // offset: 0x43ce, bitSize: 0x98(0x13 Byte(s)), array:0x98(hti:0x5)
    bool musicplayer_trackenable[MusicTracks];
    // offset: 0x4466, bitSize: 0x4, array:0x4(hti:0x6)
    bool musicplayer_trackunlock[ProgressionMusicTracks];
};

