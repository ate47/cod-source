// file .... ddl\mp\colorpreset.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 808 (0x328)
    // byte size . 101 (0x65)
    // archive ... hash_aac6b9747ee4d745

    // bitSize: 0x1f0, members: 27
    struct ColorCustomizationFullscreenPreset {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte Palette;
        // offset: 0x8, bitSize: 0x20(0x4 Byte(s))
        int AdvancedNeutralColor;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte enemy_color_selection_widget;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte neutral_color_selection_widget;
        // offset: 0x38, bitSize: 0x20(0x4 Byte(s))
        int AdvancedContestedColor;
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        byte party_color_selection_widget;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        byte contested_color_selection_widget;
        // offset: 0x68, bitSize: 0x20(0x4 Byte(s))
        int AdvancedPartyColor;
        // offset: 0x88, bitSize: 0x20(0x4 Byte(s))
        int AdvancedTeamColor;
        // offset: 0xa8, bitSize: 0x8(0x1 Byte(s))
        byte team_color_selection_widget;
        // offset: 0xb0, bitSize: 0x20(0x4 Byte(s))
        int AdvancedEnemyColor;
        // offset: 0xd0, bitSize: 0x8(0x1 Byte(s))
        byte squad_6_color_selection_widget;
        // offset: 0xd8, bitSize: 0x8(0x1 Byte(s))
        byte squad_5_color_selection_widget;
        // offset: 0xe0, bitSize: 0x8(0x1 Byte(s))
        byte squad_4_color_selection_widget;
        // offset: 0xe8, bitSize: 0x8(0x1 Byte(s))
        byte squad_3_color_selection_widget;
        // offset: 0xf0, bitSize: 0x8(0x1 Byte(s))
        byte squad_2_color_selection_widget;
        // offset: 0xf8, bitSize: 0x20(0x4 Byte(s))
        int AdvancedYouColor;
        // offset: 0x118, bitSize: 0x8(0x1 Byte(s))
        byte squad_1_color_selection_widget;
        // offset: 0x120, bitSize: 0x8(0x1 Byte(s))
        byte you_color_selection_widget;
        // offset: 0x128, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSquad1Color;
        // offset: 0x148, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSquad2Color;
        // offset: 0x168, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSquad3Color;
        // offset: 0x188, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSquad4Color;
        // offset: 0x1a8, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSquad5Color;
        // offset: 0x1c8, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSquad6Color;
        // offset: 0x1e8, bitSize: 0x1
        bool initialized;
    };

    // bitSize: 0x88, members: 9
    struct CodCasterTeamColorPreset {
        // offset: 0x0, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSecondaryColor;
        // offset: 0x20, bitSize: 0x20(0x4 Byte(s))
        int AdvancedPrimaryColor;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte Palette;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        byte codcaster_option_team_setting_secondary_color;
        // offset: 0x50, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSubstituteColor;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        byte codcaster_option_team_setting_substitute_color;
        // offset: 0x78, bitSize: 0x8(0x1 Byte(s))
        byte codcaster_option_team_setting_primary_color;
        // offset: 0x80, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0x278, members: 2

    // offset: 0x0, bitSize: 0x1f0(0x3e Byte(s))
    ColorCustomizationFullscreenPreset colorCustomizationPalette;
    // offset: 0x1f0, bitSize: 0x88(0x11 Byte(s))
    CodCasterTeamColorPreset codCasterTeamColorPreset;
};

