// file .... ddl\mp\colorpreset.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 808 (0x328)
    // byte size . 101 (0x65)
    // archive ... hash_d830449e11abec9a

    // bitSize: 0x1f0, members: 27
    struct ColorCustomizationFullscreenPreset {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte ContestedColorSelectionWidget;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte Palette;
        // offset: 0x10, bitSize: 0x20(0x4 Byte(s))
        int AdvancedNeutralColor;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte PartyColorSelectionWidget;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte YouColorSelectionWidget;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int AdvancedContestedColor;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int AdvancedPartyColor;
        // offset: 0x80, bitSize: 0x8(0x1 Byte(s))
        byte NeutralColorSelectionWidget;
        // offset: 0x88, bitSize: 0x20(0x4 Byte(s))
        int AdvancedTeamColor;
        // offset: 0xa8, bitSize: 0x8(0x1 Byte(s))
        byte Squad1ColorSelectionWidget;
        // offset: 0xb0, bitSize: 0x8(0x1 Byte(s))
        byte Squad2ColorSelectionWidget;
        // offset: 0xb8, bitSize: 0x8(0x1 Byte(s))
        byte Squad3ColorSelectionWidget;
        // offset: 0xc0, bitSize: 0x20(0x4 Byte(s))
        int AdvancedEnemyColor;
        // offset: 0xe0, bitSize: 0x8(0x1 Byte(s))
        byte TeamColorSelectionWidget;
        // offset: 0xe8, bitSize: 0x8(0x1 Byte(s))
        byte Squad4ColorSelectionWidget;
        // offset: 0xf0, bitSize: 0x20(0x4 Byte(s))
        int AdvancedYouColor;
        // offset: 0x110, bitSize: 0x8(0x1 Byte(s))
        byte Squad5ColorSelectionWidget;
        // offset: 0x118, bitSize: 0x8(0x1 Byte(s))
        byte EnemyColorSelectionWidget;
        // offset: 0x120, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSquad1Color;
        // offset: 0x140, bitSize: 0x8(0x1 Byte(s))
        byte Squad6ColorSelectionWidget;
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
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSubstituteColor;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        byte CodcasterOption_TeamSettingSubstituteColor;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        byte CodcasterOption_TeamSettingPrimaryColor;
        // offset: 0x78, bitSize: 0x8(0x1 Byte(s))
        byte CodcasterOption_TeamSettingSecondaryColor;
        // offset: 0x80, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0x278, members: 2

    // offset: 0x0, bitSize: 0x1f0(0x3e Byte(s))
    ColorCustomizationFullscreenPreset colorCustomizationPalette;
    // offset: 0x1f0, bitSize: 0x88(0x11 Byte(s))
    CodCasterTeamColorPreset codCasterTeamColorPreset;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 568 (0x238)
    // byte size . 71 (0x47)
    // archive ... hash_e59c539aaf06011c

    // bitSize: 0x100, members: 15
    struct ColorCustomizationFullscreenPreset {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte ContestedColorSelectionWidget;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte Palette;
        // offset: 0x10, bitSize: 0x20(0x4 Byte(s))
        int AdvancedNeutralColor;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte PartyColorSelectionWidget;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte YouColorSelectionWidget;
        // offset: 0x40, bitSize: 0x20(0x4 Byte(s))
        int AdvancedContestedColor;
        // offset: 0x60, bitSize: 0x20(0x4 Byte(s))
        int AdvancedPartyColor;
        // offset: 0x80, bitSize: 0x8(0x1 Byte(s))
        byte NeutralColorSelectionWidget;
        // offset: 0x88, bitSize: 0x20(0x4 Byte(s))
        int AdvancedTeamColor;
        // offset: 0xa8, bitSize: 0x20(0x4 Byte(s))
        int AdvancedEnemyColor;
        // offset: 0xc8, bitSize: 0x8(0x1 Byte(s))
        byte TeamColorSelectionWidget;
        // offset: 0xd0, bitSize: 0x20(0x4 Byte(s))
        int AdvancedYouColor;
        // offset: 0xf0, bitSize: 0x8(0x1 Byte(s))
        byte EnemyColorSelectionWidget;
        // offset: 0xf8, bitSize: 0x1
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
        // offset: 0x48, bitSize: 0x20(0x4 Byte(s))
        int AdvancedSubstituteColor;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        byte CodcasterOption_TeamSettingSubstituteColor;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        byte CodcasterOption_TeamSettingPrimaryColor;
        // offset: 0x78, bitSize: 0x8(0x1 Byte(s))
        byte CodcasterOption_TeamSettingSecondaryColor;
        // offset: 0x80, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0x188, members: 2

    // offset: 0x0, bitSize: 0x100(0x20 Byte(s))
    ColorCustomizationFullscreenPreset colorCustomizationPalette;
    // offset: 0x100, bitSize: 0x88(0x11 Byte(s))
    CodCasterTeamColorPreset codCasterTeamColorPreset;
};

