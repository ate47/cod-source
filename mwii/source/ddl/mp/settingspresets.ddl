// file .... ddl\mp\settingspresets.ddl

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 4 (0x4)
    // bit size .. 424 (0x1a8)
    // byte size . 53 (0x35)
    // archive ... hash_8844e738efe5e115

    // bitSize: 0x28, members: 6
    struct Subtitles {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesCP;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesMP;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesSP;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesDMZ;
        // offset: 0x20, bitSize: 0x1
        bool initialized;
    };

    // bitSize: 0x80, members: 18
    struct Quality {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte SSR;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte ShadowMapResolution;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte Resolution;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte BulletImpact;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        byte TextureRes;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte DepthOfFieldPC;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte CachedSpotShadows;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte ShaderQuality;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte Tessellation;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        byte AmbientOcclusion;
        // offset: 0x50, bitSize: 0x8(0x1 Byte(s))
        byte ParticleLighting;
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        byte AntiAliasing;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        byte ParticleQuality;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        byte CachedSunShadows;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        byte TexFilterAniso;
        // offset: 0x78, bitSize: 0x1
        bool initialized;
        // offset: 0x79, bitSize: 0x1
        bool isCustom;
    };

    // bitSize: 0x50, members: 11
    struct Telemetry {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryCPUTime;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryGPUClock;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryVRAMCounter;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte TelemetrySystemClock;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryFPSCounter;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryPacketLoss;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryServerLatency;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryGPUTemp;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryGPUTime;
        // offset: 0x48, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0xf8, members: 3

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    Subtitles subtitles;
    // offset: 0x28, bitSize: 0x50(0xa Byte(s))
    Telemetry telemetryPreset;
    // offset: 0x78, bitSize: 0x80(0x10 Byte(s))
    Quality qualityPreset;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 2 (0x2)
    // bit size .. 216 (0xd8)
    // byte size . 27 (0x1b)
    // archive ... hash_6e2c728eb3724fa8

    // bitSize: 0x28, members: 6
    struct Subtitles {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesCP;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesMP;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesSP;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesDMZ;
        // offset: 0x20, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0x28, members: 1

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    Subtitles subtitles;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 3 (0x3)
    // bit size .. 344 (0x158)
    // byte size . 43 (0x2b)
    // archive ... hash_88f0fa48701eb592

    // bitSize: 0x28, members: 6
    struct Subtitles {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesCP;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesMP;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesSP;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesDMZ;
        // offset: 0x20, bitSize: 0x1
        bool initialized;
    };

    // bitSize: 0x80, members: 17
    struct Quality {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte SSR;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte ParticleQualityLevel;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte ShadowMapResolution;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte Resolution;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        byte BulletImpact;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte TextureRes;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte DepthOfFieldPC;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte CachedSpotShadows;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte ShaderQuality;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        byte Tessellation;
        // offset: 0x50, bitSize: 0x8(0x1 Byte(s))
        byte AmbientOcclusion;
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        byte ParticleLighting;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        byte AntiAliasing;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        byte CachedSunShadows;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        byte TexFilterAniso;
        // offset: 0x78, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0xa8, members: 2

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    Subtitles subtitles;
    // offset: 0x28, bitSize: 0x80(0x10 Byte(s))
    Quality qualityPreset;
};

version 1 {
    // enums ..... 0 (0x0)
    // structs ... 4 (0x4)
    // bit size .. 424 (0x1a8)
    // byte size . 53 (0x35)
    // archive ... hash_876615da65af794d

    // bitSize: 0x28, members: 6
    struct Subtitles {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesCP;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesMP;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesSP;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte SubtitlesDMZ;
        // offset: 0x20, bitSize: 0x1
        bool initialized;
    };

    // bitSize: 0x80, members: 17
    struct Quality {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte SSR;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte ParticleQualityLevel;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte ShadowMapResolution;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte Resolution;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        byte BulletImpact;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte TextureRes;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte DepthOfFieldPC;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte CachedSpotShadows;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte ShaderQuality;
        // offset: 0x48, bitSize: 0x8(0x1 Byte(s))
        byte Tessellation;
        // offset: 0x50, bitSize: 0x8(0x1 Byte(s))
        byte AmbientOcclusion;
        // offset: 0x58, bitSize: 0x8(0x1 Byte(s))
        byte ParticleLighting;
        // offset: 0x60, bitSize: 0x8(0x1 Byte(s))
        byte AntiAliasing;
        // offset: 0x68, bitSize: 0x8(0x1 Byte(s))
        byte CachedSunShadows;
        // offset: 0x70, bitSize: 0x8(0x1 Byte(s))
        byte TexFilterAniso;
        // offset: 0x78, bitSize: 0x1
        bool initialized;
    };

    // bitSize: 0x50, members: 11
    struct Telemetry {
        // offset: 0x0, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryCPUTime;
        // offset: 0x8, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryGPUClock;
        // offset: 0x10, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryVRAMCounter;
        // offset: 0x18, bitSize: 0x8(0x1 Byte(s))
        byte TelemetrySystemClock;
        // offset: 0x20, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryFPSCounter;
        // offset: 0x28, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryPacketLoss;
        // offset: 0x30, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryServerLatency;
        // offset: 0x38, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryGPUTemp;
        // offset: 0x40, bitSize: 0x8(0x1 Byte(s))
        byte TelemetryGPUTime;
        // offset: 0x48, bitSize: 0x1
        bool initialized;
    };

    // root: bitSize: 0xf8, members: 3

    // offset: 0x0, bitSize: 0x28(0x5 Byte(s))
    Subtitles subtitles;
    // offset: 0x28, bitSize: 0x50(0xa Byte(s))
    Telemetry telemetryPreset;
    // offset: 0x78, bitSize: 0x80(0x10 Byte(s))
    Quality qualityPreset;
};

