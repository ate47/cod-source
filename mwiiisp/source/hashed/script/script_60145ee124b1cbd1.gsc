#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\art;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\player_death;
#using scripts\sp\utility;

#namespace namespace_fd9c6daa1372e62b;

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x21ec
// Size: 0x485
function function_7368a9e3c4ab6a56()
{
    setdvarifuninitialized( @"hash_18e8b5375bc3a359", 0 );
    setdvarifuninitialized( @"hash_f213fc40b2f63070", 0 );
    setdvar( @"hash_7a03222b5456284d", 1 );
    setdvarifuninitialized( @"hash_ef7a4f0ffc468e7b", 1 );
    setdvarifuninitialized( @"hash_6e0c4af8a30676b6", 1 );
    setdvarifuninitialized( @"hash_679a4527014d4498", 0 );
    setdvarifuninitialized( @"hash_9c267ccc7e1e2388", randomint( 360 ) );
    setdvarifuninitialized( @"hash_277f4c8bbc3d8083", 6000 );
    setdvarifuninitialized( @"hash_86db6dd1d3fd9982", 2000 );
    setdvarifuninitialized( @"hash_c16983c2b0821bd4", 0 );
    setdvarifuninitialized( @"hash_3c74a0a5b381bbb3", 0 );
    setdvarifuninitialized( @"hash_c9238ac4cc17e116", 1 );
    init_gunship_intro_anims();
    
    /#
        setdvarifuninitialized( @"hash_8f3a1c1ab47f5c04", 0 );
        setdevdvarifuninitialized( @"hash_fa402c92e4148a39", 45 );
        setdevdvarifuninitialized( @"hash_f49f4fd233809e37", 0 );
        setdevdvarifuninitialized( @"hash_a59a7da9fa17c00", 0 );
        setdevdvarifuninitialized( @"hash_302d41b2b6f9d002", 0 );
        setdevdvarifuninitialized( @"hash_9a9f1499825922aa", 0 );
        setdevdvarifuninitialized( @"hash_73471de3f4780421", 0 );
        setdevdvarifuninitialized( @"hash_f2f36ad676e3835b", 0 );
        setdvarifuninitialized( @"hash_64bdd497427343e9", 0 );
    #/
    
    setdvarifuninitialized( @"hash_80478c6f0f12492a", 0 );
    setdvarifuninitialized( @"hash_cca85e49b724df8b", 1 );
    setdvarifuninitialized( @"hash_9adf55d0d617dfdd", 0 );
    setdvarifuninitialized( @"hash_84df9019aa255434", 1 );
    precachemodel( "tag_player" );
    precachemodel( "veh9_mil_air_gunship_sp" );
    precachemodel( "ks_gunship_mp_mesh" );
    precachemodel( "ks_gunship_mp" );
    precachemodel( "veh9_mil_air_gunship_sp" );
    precachemodel( "veh9_mil_air_gunship_gun_big" );
    precachemodel( "veh9_mil_air_gunship_gun_small" );
    level.var_6abb43def697b42a = 800;
    level.var_6ade4ddef6be11e0 = 5000;
    level.gunship_speed[ "move" ] = 10;
    level.gunship_speed[ "rotate" ] = 120;
    
    if ( !isdefined( level.var_c944986665da028e ) )
    {
        level.var_c944986665da028e = 0;
    }
    
    if ( !isdefined( level.var_67f5d508f1c46e99 ) )
    {
        level.var_67f5d508f1c46e99 = 1;
    }
    
    level.var_5a1b956578d01d46 = 2000;
    level.var_5a3ea76578f68c94 = 30000;
    level.var_6fd6cb49e3a44538 = 2000;
    level.var_1250917a0280ae9 = [];
    level.stinger_missiles = [];
    level.var_388aee5d184a98d1 = 0;
    
    if ( !flag_exist( "allow_context_sensative_dialog" ) )
    {
        flag_init( "allow_context_sensative_dialog" );
    }
    
    if ( !flag( "allow_context_sensative_dialog" ) )
    {
        flag_set( "allow_context_sensative_dialog" );
    }
    
    if ( !flag_exist( "pause_rotatePlane_thread" ) )
    {
        flag_init( "pause_rotatePlane_thread" );
    }
    
    if ( !flag_exist( "thermal_mode" ) )
    {
        flag_init( "thermal_mode" );
    }
    
    if ( !flag_exist( "should_max_ads" ) )
    {
        flag_init( "should_max_ads" );
    }
    
    flag_init( "missile_pairedWithFlare" );
    flag_init( "missile_pairedWithBadFlare" );
    flag_init( "missile_FlareToSoon" );
    flag_init( "flare_system_busy" );
    flag_init( "hellfire_system_busy" );
    flag_init( "hellfire_missile_alive" );
    flag_init( "flares_enabled" );
    level.gunshipqueue = [];
    function_fabfbc51d4f4143e();
    flag_init( "gunship_ads_pressed" );
    utility::add_hint_string( "weapon_swap", &"GUNSHIP/GUNSHIP_WEAPON_SWAP", &function_f7d0edc8744d2075 );
    utility::add_hint_string( "weapon_ads", &"GUNSHIP/GUNSHIP_ZOOM_WEAPON", &function_f8eebce9cd61abc7 );
    utility::add_hint_string( "weapon_ads_hold", &"GUNSHIP/GUNSHIP_ZOOM_WEAPON_HOLD", &function_f8eebce9cd61abc7 );
    utility::add_hint_string( "vision_thermal", &"GUNSHIP/CHANGE_VISION_MODE", &function_fbb07165762913c );
    utility::add_hint_string( "vision_color", &"GUNSHIP/CHANGE_VISION_MODE", &function_524a98c87390fffc );
    utility::add_hint_string( "use_flares", &"GUNSHIP/USE_FLARES", &function_1ac07c6943264343 );
    utility::add_hint_string( "vehicle_ammo", &"GUNSHIP/VEHICLE_AMMO_HINT_1" );
    utility::add_hint_string( "player_missile_hint_1", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_1" );
    utility::add_hint_string( "player_missile_hint_2", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_2" );
    utility::add_hint_string( "player_missile_hint_moving", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_MOVING" );
    utility::add_hint_string( "player_missile_hint_boost", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_BOOST" );
    level.var_2cb45ce35a881047 = 0;
    gunship_vfx();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x2679
// Size: 0x41
function function_f8eebce9cd61abc7()
{
    if ( flag( "igc_start" ) )
    {
        return 1;
    }
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) != 0 )
    {
        return flag( "gunship_ads_pressed" );
    }
    
    return level.player isads();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x26c3
// Size: 0x1e
function function_fbb07165762913c()
{
    if ( flag( "igc_start" ) )
    {
        return 1;
    }
    
    return flag( "thermal_mode" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x26ea
// Size: 0x1f, Type: bool
function function_524a98c87390fffc()
{
    if ( flag( "igc_start" ) )
    {
        return true;
    }
    
    return !flag( "thermal_mode" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x2712
// Size: 0x16, Type: bool
function function_f7d0edc8744d2075()
{
    return function_f0d33fba32bd4dc2() || isdefined( level.var_d6d3568761e946c5 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x2731
// Size: 0x72, Type: bool
function function_f0d33fba32bd4dc2()
{
    current_weapon_name = function_878e144349832994( level.player );
    
    if ( getdvarint( @"hash_80478c6f0f12492a" ) )
    {
        weapon_name = level.gunship.var_d6604e5e3d0ba3b7;
    }
    else
    {
        weapon_name = level.gunship.var_d6604f5e3d0ba5ea;
    }
    
    if ( is_equal( current_weapon_name, weapon_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x27ac
// Size: 0x33, Type: bool
function function_58e9065779e30185()
{
    if ( level.player isads() && level.player sprintbuttonpressed() )
    {
        flag_set( "should_max_ads" );
    }
    
    return false;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x27e8
// Size: 0x39
function function_1ac07c6943264343()
{
    if ( utility::flag( "igc_start" ) )
    {
        return 1;
    }
    
    if ( utility::flag( "skip_flare_hint" ) && !function_f0d33fba32bd4dc2() )
    {
        return 1;
    }
    
    return flag( "missile_pairedWithFlare" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x282a
// Size: 0x1e
function gunship_hellfire_used()
{
    if ( utility::flag( "igc_start" ) )
    {
        return 1;
    }
    
    return utility::flag( "gunship_hellfire_used" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x2851
// Size: 0x84
function gunship_vfx()
{
    level._effect[ "clouds" ] = loadfx( "vfx/iw9/level/gunship/vfx_gs_ac130_view_clouds.vfx" );
    level._effect[ "gunship_flares" ] = loadfx( "vfx/iw9/level/gunship/vfx_gs_ac130_flares_01_v.vfx" );
    level._effect[ "camera_spotlight" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_ac130_ir_spotlight.vfx" );
    level._effect[ "vfx_thermal_beacon_ai" ] = loadfx( "vfx/iw9/level/gunship/vfx_thermal_beacon_ai.vfx" );
    level._effect[ "vfx_thermal_beacon_vehicle" ] = loadfx( "vfx/iw9/level/gunship/vfx_thermal_beacon_vehicle.vfx" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x28dd
// Size: 0x80c
function function_6be6c5dc66f4a52c()
{
    flag_wait( "scriptables_ready" );
    
    if ( isdefined( level.gunship ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    if ( !isdefined( level.var_c9432be18d145ed5 ) && isdefined( self.radius ) )
    {
        level.var_c9432be18d145ed5 = self.radius;
    }
    
    if ( !isdefined( level.var_c9432be18d145ed5 ) )
    {
        level.var_c9432be18d145ed5 = 26000;
    }
    
    origin = self.origin;
    angles = self.angles;
    
    if ( isdefined( level.var_b54d8a552ae8cf8a ) && isvector( level.var_b54d8a552ae8cf8a ) )
    {
        origin = level.var_b54d8a552ae8cf8a;
    }
    
    if ( isdefined( level.var_b9c6c415d92919c8 ) && isvector( level.var_b9c6c415d92919c8 ) )
    {
        angles = level.var_b9c6c415d92919c8;
    }
    
    level.gunship = spawn( "script_model", origin );
    level.gunship setmodel( "tag_origin" );
    link = function_c39defa1b1c06412();
    
    if ( isdefined( link ) && !isarray( link ) )
    {
        level.gunship.link = link;
    }
    
    level.gunship.var_10a90f7f2ccc7f03 = "gunship_scope_jup_sp";
    level.gunship.var_d6604e5e3d0ba3b7 = "gunship_105mm_sp";
    level.gunship.var_d6604d5e3d0ba184 = "gunship_40mm_jup_sp";
    level.gunship.var_d660505e3d0ba81d = "gunship_25mm_jup_sp";
    
    if ( getdvarint( @"hash_cca85e49b724df8b" ) )
    {
        level.gunship.var_d6604f5e3d0ba5ea = "gunship_hellfire_jup_sp";
    }
    else
    {
        level.gunship.var_d6604f5e3d0ba5ea = "gunship_hellfire_jup_sp";
    }
    
    if ( isdefined( level.var_10a90f7f2ccc7f03 ) )
    {
        level.gunship.var_10a90f7f2ccc7f03 = level.var_10a90f7f2ccc7f03;
    }
    
    if ( isdefined( level.var_d6604e5e3d0ba3b7 ) )
    {
        level.gunship.var_d6604e5e3d0ba3b7 = level.var_d6604e5e3d0ba3b7;
    }
    
    if ( isdefined( level.var_d6604d5e3d0ba184 ) )
    {
        level.gunship.var_d6604d5e3d0ba184 = level.var_d6604d5e3d0ba184;
    }
    
    if ( isdefined( level.var_d660505e3d0ba81d ) )
    {
        level.gunship.var_d660505e3d0ba81d = level.var_d660505e3d0ba81d;
    }
    
    if ( isdefined( level.var_d6604f5e3d0ba5ea ) )
    {
        level.gunship.var_d6604f5e3d0ba5ea = level.var_d6604f5e3d0ba5ea;
    }
    
    level.physicssphereradius[ level.gunship.var_d660505e3d0ba81d ] = 60;
    level.physicssphereradius[ level.gunship.var_d6604d5e3d0ba184 ] = 600;
    level.physicssphereradius[ level.gunship.var_d6604e5e3d0ba3b7 ] = 1000;
    level.weaponreloadtime[ level.gunship.var_d660505e3d0ba81d ] = 2;
    level.weaponreloadtime[ level.gunship.var_d6604d5e3d0ba184 ] = 4;
    level.weaponreloadtime[ level.gunship.var_d6604e5e3d0ba3b7 ] = 6;
    level.weaponreloadtime[ level.gunship.var_d6604f5e3d0ba5ea ] = 15;
    level.weaponreloadtime[ "gunship_25mm_jup_sp_gunless" ] = 2;
    level.gunship.var_f81a604f04ca7c67 = 30;
    level.gunship.var_3878f8cac277eba = 50;
    level.gunship.var_fe8115e13e88cccd = 100;
    level.gunship.speed = self.speed;
    level.gunship.target = self.target;
    level.gunship.script_flag_wait = self.script_flag_wait;
    level.gunship.team = self.team;
    level.gunship.targetname = self.targetname;
    
    if ( isdefined( level.player ) && isdefined( level.player.team ) )
    {
        level.gunship.team = level.player.team;
    }
    
    level.gunship.name = "AC-130";
    
    if ( isdefined( angles ) )
    {
        level.gunship.angles = angles;
    }
    else
    {
        level.gunship.angles = ( 0, 115, 0 );
    }
    
    level.gunship.owner = undefined;
    level.gunship.thermal_vision = default_to( level.var_5e05d3c963b2a5c4, "gunship_thermal_jup_sp" );
    level.gunship.color_vision = default_to( level.var_7906ef78eb97fbd4, "gunship_color_jup_sp" );
    level.gunship.var_b16fecb954d8b304 = [];
    
    if ( !isdefined( level.var_f1acd9be11d8efe5 ) )
    {
        level.var_f1acd9be11d8efe5 = 1;
    }
    
    level.gunship.targetname = "ac130rig_script_model";
    level.gunship hide();
    level.gunshipinuse = 0;
    
    if ( !isdefined( level.var_fb13600ef005ed60 ) )
    {
        level.var_fb13600ef005ed60 = 20;
    }
    
    if ( !isdefined( level.var_285ce926ff345ee3 ) )
    {
        level.var_285ce926ff345ee3 = 3;
    }
    
    if ( !isdefined( level.var_10a026b50d5be68f ) )
    {
        level.var_10a026b50d5be68f = 3;
    }
    
    if ( !isdefined( level.var_abebd3ab98699051 ) && isdefined( level.gunship_speed[ "rotate" ] ) )
    {
        level.var_abebd3ab98699051 = level.gunship_speed[ "rotate" ] * 2;
    }
    else if ( !isdefined( level.var_abebd3ab98699051 ) && !isdefined( level.gunship_speed[ "rotate" ] ) )
    {
        level.var_abebd3ab98699051 = 400;
    }
    
    if ( !isdefined( level.var_ac0ee5ab988fff9f ) && isdefined( level.gunship_speed[ "rotate" ] ) )
    {
        level.var_ac0ee5ab988fff9f = level.gunship_speed[ "rotate" ];
    }
    else if ( !isdefined( level.var_ac0ee5ab988fff9f ) && !isdefined( level.gunship_speed[ "rotate" ] ) )
    {
        level.var_ac0ee5ab988fff9f = 200;
    }
    
    level.gunship.deployweaponobj = makeweapon( "ks_remote_gunship_mp" );
    streakinfo = spawnstruct();
    streakinfo.streakname = "gunship";
    streakinfo.owner = level.player;
    streakinfo.id = 1;
    streakinfo.lifeid = 0;
    streakinfo.score = 0;
    streakinfo.shots_fired = 0;
    streakinfo.hits = 0;
    streakinfo.damage = 0;
    streakinfo.kills = 0;
    
    if ( isent( self ) )
    {
        self hide();
    }
    
    level.player tryusegunship( streakinfo );
    level.gunship_ents = getentarrayinradius( undefined, undefined, level.player.origin, 1000 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x30f1
// Size: 0xd, Type: bool
function weapongivengunship( streakinfo )
{
    return true;
}

#using_animtree( "script_model" );

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x3107
// Size: 0xff
function init_gunship_intro_anims()
{
    level.scr_animtree[ "gunship" ] = #animtree;
    level.scr_anim[ "gunship" ][ "gunship_intro" ] = %mp_acharlie130_intro;
    level.scr_animtree[ "gunship" ] = #animtree;
    level.scr_anim[ "gunship" ][ "gshp_acharlie130_intro_gl" ] = %gshp_acharlie130_intro_gl;
    scripts\common\anim::addnotetrack_customfunction( "gunship", "transition_audio", &function_b3ab43977eb50a88, "gshp_acharlie130_intro_gl" );
    level.scr_anim[ "gunship" ][ "gunship_intro_alt" ] = %mp_acharlie130_intro_alt;
    level.scr_anim[ "gunship" ][ "gunship_intro_long" ] = %mp_acharlie130_intro_old;
    level.scr_anim[ "gunship" ][ "gunship_death" ] = %mp_acharlie130_death;
    level.gunship_crashanimlength = getanimlength( level.scr_anim[ "gunship" ][ "gunship_death" ] );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x320e
// Size: 0x185
function rotateplane( toggle )
{
    level notify( "stop_rotatePlane_thread" );
    level endon( "stop_rotatePlane_thread" );
    
    if ( toggle == "on" )
    {
        for ( ;; )
        {
            level.gunship rotateyaw( 360, level.gunship_speed[ "rotate" ] );
            level.gunship waittill( "rotatedone" );
            flag_waitopen( "pause_rotatePlane_thread" );
        }
        
        return;
    }
    
    if ( toggle == "off" )
    {
        var_208b39878dfef221 = level.gunship_speed[ "move" ];
        rotatetime = level.gunship_speed[ "rotate" ] / 360 * var_208b39878dfef221;
        level.gunship rotateyaw( level.gunship.angles[ 2 ] + var_208b39878dfef221, rotatetime, 0, rotatetime );
        return;
    }
    
    if ( toggle == "off_instant" )
    {
        var_208b39878dfef221 = 0.001;
        rotatetime = level.gunship_speed[ "rotate" ] / 360 * var_208b39878dfef221;
        level.gunship rotateyaw( level.gunship.angles[ 2 ] + var_208b39878dfef221, rotatetime, 0, rotatetime );
        return;
    }
    
    if ( toggle == "crash" )
    {
        var_25bb708a7d591131 = 50;
        rotatetime = level.gunship_speed[ "rotate" ] / 360 * var_25bb708a7d591131;
        level.gunship rotateyaw( level.gunship.angles[ 2 ] + var_25bb708a7d591131, rotatetime, rotatetime, 0 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x339b
// Size: 0xb2
function function_170b254a68763ffe()
{
    level.gunship endon( "death" );
    
    /#
        if ( getdvarint( @"hash_8f3a1c1ab47f5c04", 0 ) == 1 )
        {
            thread function_702095380cde1053();
        }
    #/
    
    if ( !isdefined( level.var_1ced22cd06ca90ed ) )
    {
        level.var_1ced22cd06ca90ed = level.gunship_speed[ "rotate" ];
    }
    
    for ( ;; )
    {
        if ( !is_equal( level.var_1ced22cd06ca90ed, level.gunship_speed[ "rotate" ] ) )
        {
            rotateplane( "off_instant" );
            level.gunship_speed[ "rotate" ] = level.var_1ced22cd06ca90ed;
            childthread rotateplane( "on" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 5
// Checksum 0x0, Offset: 0x3455
// Size: 0x5d
function moveplane( endingpos, movetime, accel, decel, var_cddbb6f644306be6 )
{
    level notify( "stop_movePlane_thread" );
    level endon( "stop_movePlane_thread" );
    level.gunship moveto( endingpos, movetime, accel, decel );
    level.gunship waittill( "movedone" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x34ba
// Size: 0x8b
function function_9bb3d37f271d5d15( move_time, delay, ender )
{
    self endon( "death" );
    
    if ( isdefined( ender ) )
    {
        self endon( ender );
    }
    
    while ( isdefined( self ) )
    {
        if ( isint( delay ) )
        {
            wait delay;
        }
        
        if ( isstring( delay ) )
        {
            level waittill( delay );
        }
        
        childthread moveplane( ( self.origin[ 0 ], self.origin[ 1 ], level.gunship.origin[ 2 ] ), move_time, move_time / 3, move_time / 3, 0 );
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x354d
// Size: 0x48
function gunship_updateoverlaycoords( plane )
{
    plane endon( "death" );
    plane endon( "crashing" );
    plane endon( "leaving" );
    self endon( "disconnect" );
    wait 0.05;
    thread gunship_updateplanemodelcoords( plane );
    thread gunship_updateplayerpositioncoords( plane );
    thread gunship_updateaimingcoords( plane );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x359d
// Size: 0x91
function gunship_updateplanemodelcoords( plane )
{
    plane endon( "death" );
    plane endon( "crashing" );
    plane endon( "leaving" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self setclientomnvar( "ui_gunship_coord1_posx", int( plane.origin[ 0 ] ) );
        self setclientomnvar( "ui_gunship_coord1_posy", int( plane.origin[ 1 ] ) );
        self setclientomnvar( "ui_gunship_coord1_posz", int( plane.origin[ 2 ] ) );
        wait 0.5;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x3636
// Size: 0x7e
function gunship_updateplayerpositioncoords( plane )
{
    plane endon( "death" );
    plane endon( "crashing" );
    plane endon( "leaving" );
    self endon( "disconnect" );
    waitframe();
    self setclientomnvar( "ui_gunship_coord2_posx", int( self.origin[ 0 ] ) );
    self setclientomnvar( "ui_gunship_coord2_posy", int( self.origin[ 1 ] ) );
    self setclientomnvar( "ui_gunship_coord2_posz", int( self.origin[ 2 ] ) );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x36bc
// Size: 0xb2
function gunship_updateaimingcoords( plane )
{
    plane endon( "death" );
    plane endon( "crashing" );
    plane endon( "leaving" );
    self endon( "disconnect" );
    
    while ( true )
    {
        starttrace = self getvieworigin();
        endtrace = starttrace + anglestoforward( self getplayerangles() ) * 15000;
        endpos = physicstrace( starttrace, endtrace );
        self setclientomnvar( "ui_gunship_coord3_posx", int( endpos[ 0 ] ) );
        self setclientomnvar( "ui_gunship_coord3_posy", int( endpos[ 1 ] ) );
        self setclientomnvar( "ui_gunship_coord3_posz", int( endpos[ 2 ] ) );
        wait 0.1;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x3776
// Size: 0x12
function tryusegunship( streakinfo )
{
    return tryusegunshipfromstruct( streakinfo );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x3791
// Size: 0x91
function tryusegunshipfromstruct( streakinfo )
{
    self endon( "disconnect" );
    level endon( "stop_gunship" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( "killstreak_finished_with_deploy_weapon" );
            return 0;
        }
    }
    
    if ( istrue( level.gunshipinuse ) )
    {
        streakinfo notify( "killstreak_finished_with_deploy_weapon" );
        return 0;
    }
    
    result = gunship_startuse( self, streakinfo );
    
    if ( !istrue( result ) )
    {
        return 0;
    }
    
    return result;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x382b
// Size: 0x236, Type: bool
function gunship_startuse( player, streakinfo )
{
    level endon( "missionfailed" );
    function_cb0b6f2e8c19e1d3();
    
    if ( isdefined( level.var_8349b3cc90ef4fa5 ) )
    {
        setdvar( @"hash_9c267ccc7e1e2388", level.var_8349b3cc90ef4fa5 );
    }
    
    level.gunshipinuse = 1;
    var_8945c22a67231e20 = 260;
    var_78ac3c5ef5263d4f = function_f411816d02e792ca( var_8945c22a67231e20, 1, 1 );
    var_be20a4f36808f54c = undefined;
    
    if ( !istrue( level.gunship_only ) && !istrue( level.var_259a7e2e6fa2cbe6 ) )
    {
        setsaveddvar( @"cg_drawcrosshair", 0 );
        var_be20a4f36808f54c = gunship_playintro( player, streakinfo, var_8945c22a67231e20, var_78ac3c5ef5263d4f );
        
        if ( !flag( "userskipped" ) && ( !isdefined( var_be20a4f36808f54c ) || !var_be20a4f36808f54c ) )
        {
            player val::reset_all( "gunship" );
            level.gunshipinuse = 0;
            
            /#
                iprintlnbold( "<dev string:x47>" );
            #/
            
            player setclientomnvar( "ui_hide_hud", 0 );
            setsaveddvar( @"cg_drawcrosshair", 1 );
            level.player scripts\sp\player::focusenable();
            return false;
        }
    }
    
    var_8945c22a67231e20 = getdvarint( @"hash_9c267ccc7e1e2388", 90 );
    var_78ac3c5ef5263d4f = function_f411816d02e792ca( var_8945c22a67231e20, 1, 0 );
    
    if ( flag( "userskipped" ) || istrue( var_be20a4f36808f54c ) )
    {
        player val::reset_all( "gunship" );
    }
    
    gunship = function_a26f1c542c8d41c1( player, streakinfo );
    
    if ( !isdefined( gunship ) )
    {
        level.gunshipinuse = 0;
        
        /#
            iprintlnbold( "<dev string:x5d>" );
        #/
        
        player setclientomnvar( "ui_hide_hud", 0 );
        player modifybasefov( 65, 0.05 );
        player lerpfovscalefactor( 1, 0 );
        setsaveddvar( @"cg_drawcrosshair", 1 );
        level.player scripts\sp\player::focusenable();
        return false;
    }
    
    /#
        gunship childthread function_a8317762afcda0d();
    #/
    
    gunship endon( "stop_gunship" );
    
    if ( !istrue( level.gunship_only ) )
    {
        gunship childthread gunship_attachgunner( player );
        gunship childthread gunship_watchthermaltoggle( player );
        gunship childthread function_8d0818a7fc70736a( player );
        gunship childthread function_2ce36c0585d34622( player );
    }
    
    gunship function_43d2fdf9d42cdafb( player, streakinfo, var_8945c22a67231e20, var_78ac3c5ef5263d4f );
    return true;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x3a6a
// Size: 0x165
function function_2ce36c0585d34622( player )
{
    var_5d4fc67421fdd83e = 0;
    var_44a957ab0b727747 = undefined;
    
    while ( true )
    {
        level.stinger_missiles = array_removeundefined( level.stinger_missiles );
        
        if ( level.stinger_missiles.size > 0 )
        {
            danger_dist = level.var_5a3ea76578f68c94 / 1.5;
            
            if ( isdefined( level.var_e2dedfef1129cd21 ) )
            {
                danger_dist = level.var_e2dedfef1129cd21;
            }
            
            foreach ( missile in level.stinger_missiles )
            {
                if ( distance( missile.origin, self.origin ) < danger_dist )
                {
                    var_5d4fc67421fdd83e = 1;
                    var_44a957ab0b727747 = missile;
                    break;
                }
                
                if ( distance( missile.origin, self.origin ) < level.var_5a3ea76578f68c94 )
                {
                    var_44a957ab0b727747 = missile;
                    break;
                }
            }
            
            if ( isdefined( var_44a957ab0b727747 ) )
            {
                function_aa7a73e00c80e767( var_44a957ab0b727747, var_5d4fc67421fdd83e, danger_dist, player );
            }
            
            var_44a957ab0b727747 = undefined;
            var_5d4fc67421fdd83e = 0;
        }
        else
        {
            function_ebd96e53d0f157ec();
            
            if ( getomnvar( "ui_veh_warning" ) != 0 )
            {
                player setclientomnvarbit( "ui_veh_warning", 2, 0 );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0x3bd7
// Size: 0xcc
function function_aa7a73e00c80e767( missile, var_5d4fc67421fdd83e, danger_dist, player )
{
    function_ebd96e53d0f157ec();
    missile endon( "death" );
    missile endon( "detonate" );
    missile endon( "entitydeleted" );
    
    if ( !missile ent_flag( "missile_pairedWithFlare" ) && isdefined( missile ) )
    {
        if ( var_5d4fc67421fdd83e )
        {
            function_ebd96e53d0f157ec();
            self playloopsound( "maaws_incoming_lp" );
        }
        else
        {
            childthread function_146db8f437f79c50( self, missile, danger_dist );
        }
        
        if ( getomnvar( "ui_veh_warning" ) == 0 )
        {
            player setclientomnvarbit( "ui_veh_warning", 2, 1 );
        }
        
        missile ent_flag_wait( "missile_pairedWithFlare" );
        missile waittill( "missile_is_detonating" );
        
        if ( getomnvar( "ui_veh_warning" ) != 0 )
        {
            player setclientomnvarbit( "ui_veh_warning", 2, 0 );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x3cab
// Size: 0x1a
function function_ebd96e53d0f157ec()
{
    self stoploopsound( "maaws_incoming_lp" );
    self stoploopsound( "incoming_alarm" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x3ccd
// Size: 0xb0
function function_146db8f437f79c50( target, missile, danger_dist )
{
    target playloopsound( "maaws_incoming_lp" );
    start = gettime();
    
    while ( isdefined( missile ) && !utility::time_has_passed( start, 15 ) )
    {
        if ( distance( missile.origin, target.origin ) < danger_dist )
        {
            break;
        }
        
        waitframe();
    }
    
    target stoploopsound( "maaws_incoming_lp" );
    
    if ( !missile ent_flag( "missile_pairedWithFlare" ) )
    {
        sound = "incoming_alarm";
        target playloopsound( sound );
        target childthread function_ad1aabb09778c266( sound, target, missile, danger_dist );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0x3d85
// Size: 0x9f
function function_ad1aabb09778c266( sound, target, missile, danger_dist )
{
    start = gettime();
    
    while ( isdefined( missile ) && !utility::time_has_passed( start, 10 ) )
    {
        if ( distance( missile.origin, target.origin ) > danger_dist )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( target ) )
    {
        target stoploopsound( sound );
    }
    
    if ( getomnvar( "ui_veh_warning" ) != 0 )
    {
        level.player setclientomnvarbit( "ui_veh_warning", 2, 0 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x3e2c
// Size: 0x16a
function function_8d0818a7fc70736a( player )
{
    while ( !isdefined( self.camera ) )
    {
        waitframe();
    }
    
    enable_flares( flag( "flares_enabled" ) );
    self.flaresreservecount = 1;
    player notifyonplayercommand( "flare_pressed", "+actionslot 2" );
    player notifyonplayercommand( "flare_pressed", "+smoke" );
    
    while ( true )
    {
        flag_wait( "flares_enabled" );
        player waittill( "flare_pressed" );
        
        /#
            if ( istrue( level.debug.debug_start ) )
            {
                continue;
            }
        #/
        
        if ( !flag( "flares_enabled" ) )
        {
            continue;
        }
        
        if ( !flag( "flare_system_busy" ) )
        {
            flag_set( "flare_system_busy" );
            setomnvar( "ui_gunship_flares_indicators_disponibility", 0 );
            self playsound( "ks_ac130_flares" );
            self playsound( "scn_gshp_flares_lr" );
            playfxontag( getfx( "gunship_flares" ), self, "tag_origin" );
            wait 0.4;
            level.stinger_missiles = array_removeundefined( level.stinger_missiles );
            
            if ( isdefined( level.stinger_missiles ) && level.stinger_missiles.size > 0 )
            {
                level.stinger_missiles childthread function_b0e2b0d4b4fa2b17( self );
            }
            
            scripts\engine\sp\utility::delaychildthread( 5, &function_625f6b35419df61b );
            continue;
        }
        
        player playlocalsound( "use_denial" );
        wait 0.1;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x3f9e
// Size: 0x44
function enable_flares( enable )
{
    if ( istrue( enable ) )
    {
        setomnvar( "ui_gunship_flares_indicators_enable", 1 );
        flag_set( "flares_enabled" );
        return;
    }
    
    setomnvar( "ui_gunship_flares_indicators_enable", 0 );
    flag_clear( "flares_enabled" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x3fea
// Size: 0x3f
function function_625f6b35419df61b()
{
    flag_clear( "missile_pairedWithFlare" );
    flag_clear( "missile_pairedWithBadFlare" );
    flag_clear( "missile_FlareToSoon" );
    flag_clear( "flare_system_busy" );
    setomnvar( "ui_gunship_flares_indicators_disponibility", 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x4031
// Size: 0x1c
function function_4f3060d359eafff3()
{
    setomnvar( "ui_gunship_show_flares_indicators", 1 );
    setomnvar( "ui_gunship_flares_indicators_disponibility", 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x4055
// Size: 0x7d
function function_b0e2b0d4b4fa2b17( missiletarget )
{
    missiletarget.flareslive = [];
    newtarget = missiletarget flares_deploy();
    newtarget endon( "death" );
    
    foreach ( missile in self )
    {
        missile childthread function_5b7b8790f98037fe( missiletarget, newtarget );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x40da
// Size: 0x183
function function_5b7b8790f98037fe( missiletarget, newtarget )
{
    self endon( "death" );
    buffer = 200;
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) || missiletarget.flaresreservecount < 1 )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < level.var_5a1b956578d01d46 )
        {
            missiletarget thread gunship_playfakebodyexplosion();
            
            if ( isdefined( self.owner ) && isdefined( self.weapon_name ) )
            {
                missiledamage = weapongetdamagemax( self.weapon_name );
                missiletarget dodamage( missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name );
            }
            
            flag_set( "missile_pairedWithBadFlare" );
            ent_flag_set( "missile_pairedWithBadFlare" );
            return;
        }
        else if ( curdist <= level.var_5a3ea76578f68c94 + buffer )
        {
            var_5252c7e4b69528e6 = 0.8;
            self missile_settargetent( newtarget );
            thread function_697e013714c47e57( var_5252c7e4b69528e6, newtarget );
            flag_set( "missile_pairedWithFlare" );
            ent_flag_set( "missile_pairedWithFlare" );
            return;
        }
        else
        {
            flag_set( "missile_FlareToSoon" );
            ent_flag_set( "missile_FlareToSoon" );
            wait 0.2;
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x4265
// Size: 0x146
function function_697e013714c47e57( time, newtarget )
{
    wait time;
    
    if ( isdefined( self ) && isdefined( newtarget ) )
    {
        explosiondist = undefined;
        
        while ( isdefined( self ) && isdefined( self.origin ) && isdefined( newtarget ) )
        {
            var_282c4d28cfadaf78 = distance( self.origin, newtarget.origin );
            
            if ( var_282c4d28cfadaf78 <= level.var_6fd6cb49e3a44538 )
            {
                break;
            }
            
            waitframe();
        }
        
        level.stinger_missiles = array_remove( level.stinger_missiles, self );
        
        if ( isdefined( self ) && isvalidmissile( self ) )
        {
            explosiondist = distance( self.origin, level.player.origin );
            self notify( "missile_is_detonating" );
            thread play_sound_in_space( "sp_stinger_missile_explode", self.origin );
            
            if ( isvalidmissile( self ) )
            {
                self detonate();
            }
            
            flak_delay = explosiondist / 7000 + 0.2;
            level.player delaycall( flak_delay, &playsound, "gunship_success_flare_debris_flak" );
        }
        
        wait 0.4;
    }
    
    level.gunship.model_ent function_ebd96e53d0f157ec();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x43b3
// Size: 0xba
function flares_deploy()
{
    flare_life = 1.5;
    flare = spawn( "script_origin", self.origin + ( 0, 0, -256 ) );
    flare.angles = self.angles;
    flare movegravity( ( 0, -1, -1 ), flare_life );
    self.flareslive[ self.flareslive.size ] = flare;
    flare thread flares_deleteaftertime( flare_life, flare_life / 2, self );
    
    if ( self == level.gunship.model_ent )
    {
        level.player playsound( "ks_ac130_flares" );
    }
    
    return flare;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x4476
// Size: 0x71
function flares_deleteaftertime( delaydelete, var_66f0721fc5bc2eb5, vehicle )
{
    assertex( !isdefined( var_66f0721fc5bc2eb5 ) || var_66f0721fc5bc2eb5 < delaydelete, "flares_deleteAfterTime() delayDelete should never be greater than delayStopTracking." );
    
    if ( isdefined( var_66f0721fc5bc2eb5 ) && isdefined( vehicle ) )
    {
        delaydelete -= var_66f0721fc5bc2eb5;
        wait var_66f0721fc5bc2eb5;
        
        if ( isdefined( vehicle ) )
        {
            vehicle.flareslive = array_remove( vehicle.flareslive, self );
        }
    }
    
    wait delaydelete;
    self delete();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0x44ef
// Size: 0x1cf
function function_43d2fdf9d42cdafb( owner, streakinfo, angle, anglevector )
{
    gunship = self;
    
    if ( isdefined( level.var_ad9a00890a627c58 ) )
    {
        if ( isvector( level.var_ad9a00890a627c58 ) )
        {
            level.gunship.origin = level.var_ad9a00890a627c58;
        }
        else
        {
            origin = level.gunship.origin;
            level.gunship.origin = ( origin[ 0 ], origin[ 1 ], level.var_ad9a00890a627c58 );
        }
    }
    
    vector = ( anglevector[ 0 ], anglevector[ 1 ], 0 );
    height = level.gunship.origin[ 2 ];
    var_4bdaaa51f67cb776 = ( height + level.var_c9432be18d145ed5 ) / 2000;
    tilt = 2 - clamp( var_4bdaaa51f67cb776, 2, 12 );
    tilt_angle = ( 0, angle + 90, default_to( level.gunship_tilt, tilt ) );
    gunship linkto( level.gunship, "tag_origin", vector, tilt_angle );
    level notify( "matchrecording_plane", gunship );
    childthread rotateplane( "on" );
    childthread function_170b254a68763ffe();
    
    /#
        gunship childthread function_1481e54cdacc113c();
    #/
    
    gunship childthread gunship_playpilotfx( owner );
    
    if ( istrue( level.gunship_only ) )
    {
        if ( !istrue( level.gunship_nolights ) )
        {
            gunship childthread gunship_linklightfxent();
        }
        
        gunship childthread gunship_linkwingfxents();
    }
    
    gunship childthread gunship_trackvelocity( owner );
    gunship childthread gunship_watchdamage( owner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x46c6
// Size: 0x5e
function function_1481e54cdacc113c()
{
    while ( true )
    {
        if ( getdvarint( @"hash_18e8b5375bc3a359" ) == 1 )
        {
            visionsetnaked( "", 0.1 );
            visionsetthermal( "", 0.1 );
            visionsetfadetoblack( "", 0.1 );
            level.player thermalvisionoff();
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x472c
// Size: 0x14e
function function_a8317762afcda0d()
{
    oldvalue = getdvarint( @"hash_9c267ccc7e1e2388" );
    
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"hash_c16983c2b0821bd4", 90 ) == 0 )
        {
            continue;
        }
        
        newvalue = getdvarint( @"hash_9c267ccc7e1e2388" );
        
        if ( newvalue != oldvalue )
        {
            oldvalue = getdvarint( @"hash_9c267ccc7e1e2388" );
            childthread rotateplane( "off_instant" );
            var_78ac3c5ef5263d4f = function_f411816d02e792ca( newvalue, 1 );
            vector = ( var_78ac3c5ef5263d4f[ 0 ], var_78ac3c5ef5263d4f[ 1 ], 0 );
            height = level.gunship.origin[ 2 ];
            var_4bdaaa51f67cb776 = ( height + level.var_c9432be18d145ed5 ) / 2000;
            tilt = 2 - clamp( var_4bdaaa51f67cb776, 8, 28 );
            tilt_angle = ( 0, newvalue + 90, default_to( level.gunship_tilt, tilt ) );
            level.gunship.model_ent linkto( level.gunship, "tag_origin", vector, tilt_angle );
            childthread rotateplane( "on" );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x4882
// Size: 0xee
function function_f411816d02e792ca( var_8945c22a67231e20, useradius, isintro )
{
    if ( istrue( isintro ) )
    {
        radiusoffset = 10000;
    }
    else
    {
        radiusoffset = level.var_c9432be18d145ed5;
    }
    
    radius = radiusoffset * 5;
    xoffset = cos( var_8945c22a67231e20 ) * radius;
    yoffset = sin( var_8945c22a67231e20 ) * radius;
    
    if ( isdefined( level.gunship_zoffset ) )
    {
        zoffset = level.gunship_zoffset;
    }
    else
    {
        zoffset = radiusoffset;
    }
    
    var_78ac3c5ef5263d4f = vectornormalize( ( xoffset, yoffset, zoffset ) );
    var_78ac3c5ef5263d4f *= zoffset;
    
    if ( !istrue( useradius ) )
    {
        var_78ac3c5ef5263d4f = ( var_78ac3c5ef5263d4f[ 0 ], var_78ac3c5ef5263d4f[ 1 ], level.gunship.origin[ 2 ] );
    }
    
    if ( istrue( isintro ) )
    {
        var_78ac3c5ef5263d4f = ( var_78ac3c5ef5263d4f[ 0 ], var_78ac3c5ef5263d4f[ 1 ], 12000 );
    }
    
    return var_78ac3c5ef5263d4f;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x4979
// Size: 0xd4
function function_335c2c8510dbe11f()
{
    if ( !isdefined( level.sniper_overlay ) )
    {
        overlay = newhudelem();
        overlay.x = 0;
        overlay.y = 0;
        overlay setshader( "iw9_proto_drone", 640, 400 );
        overlay.alignx = "center";
        overlay.aligny = "middle";
        overlay.sort = 1;
        overlay.horzalign = "center";
        overlay.vertalign = "middle";
        overlay.foreground = 1;
        overlay.lowresbackground = 0;
        overlay fadeovertime( 0.01 );
        overlay.alpha = 1;
        return overlay;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x4a55
// Size: 0x2
function gunship_lockedoncallback()
{
    
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x4a5f
// Size: 0x2
function gunship_lockedonremovedcallback()
{
    
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0x4a69
// Size: 0x64e, Type: bool
function gunship_playintro( player, streakinfo, angle, anglevector )
{
    player endon( "disconnect" );
    level endon( "userskipped_sky" );
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            streakinfo notify( "<dev string:x73>" );
        }
    #/
    
    var_e4739db3b860ef4 = "gshp_acharlie130_intro_gl";
    
    /#
        animtype = getdvarint( @"hash_a59a7da9fa17c00", 0 );
        
        if ( isdefined( animtype ) )
        {
            if ( animtype == 1 )
            {
                var_e4739db3b860ef4 = "<dev string:x9a>";
            }
            else if ( animtype == 2 )
            {
                var_e4739db3b860ef4 = "<dev string:xac>";
            }
        }
    #/
    
    animname = level.scr_anim[ streakinfo.streakname ][ var_e4739db3b860ef4 ];
    var_258b660f7db9aba6 = getanimlength( animname );
    intromodel = "veh9_mil_air_gunship_sp";
    level.gunship_intromodel = spawn( "script_model", anglevector );
    level.gunship_intromodel setmodel( intromodel );
    level.gunship_intromodel dontinterpolate();
    level.gunship_intromodel.angles = level.gunship.angles;
    level.gunship_intromodel setotherent( player );
    level.gunship_intromodel.animname = streakinfo.streakname;
    level.gunship_intromodel.owner = player;
    
    if ( !thirdpersoncam )
    {
        foreach ( var_6c3d15091efa3c48 in level.players )
        {
            if ( var_6c3d15091efa3c48 != player )
            {
                level.gunship_intromodel hide();
            }
        }
    }
    
    level.gunship.origin = ( level.gunship.origin[ 0 ], level.gunship.origin[ 1 ], anglevector[ 2 ] );
    level.gunship_intromodel linkto( level.gunship, "tag_origin", ( anglevector[ 0 ], anglevector[ 1 ], 0 ), ( 0, angle + 125, 0 ) );
    
    if ( !isdefined( level.gunship_intromodel ) )
    {
        return false;
    }
    
    waitframe();
    level.gunship_intromodel scripts\common\anim::setanimtree();
    level.gunship_intromodel.scenenode = spawn( "script_model", level.gunship_intromodel.origin );
    level.gunship_intromodel.scenenode dontinterpolate();
    level.gunship_intromodel.scenenode.angles = level.gunship_intromodel.angles;
    level.gunship_intromodel.scenenode setmodel( "tag_origin" );
    level.gunship_intromodel.scenenode linkto( level.gunship_intromodel );
    flag_waitopen( "pause_gunship_intro" );
    player thread function_6d92cdefdf500a8b( thirdpersoncam );
    player function_b88c89bb7cd1ab8e( level.gunship_intromodel.origin );
    player lerpfovscalefactor( 0, 0 );
    player modifybasefov( 49, 3 );
    player val::set_array( "gunship", level.gunship.allows, 0 );
    setomnvar( "ui_hide_hud", 0 );
    player::disable_player_weapon_info();
    player disablephysicaldepthoffieldscripting();
    player gunship_allowstances( 0 );
    player scripts\sp\player::focusdisable();
    
    if ( !thirdpersoncam )
    {
        player gunship_stopshellshock();
        player cameralinkto( level.gunship_intromodel, "tag_player", 0, 1 );
        player playerlinktoabsolute( level.gunship_intromodel, "tag_player" );
        player painvisionoff();
        level.gunship_intromodel setscriptablepartstate( "bodyFX_intro", "on", 0 );
        level.gunship_intromodel childthread gunship_queuecamerazoom( var_258b660f7db9aba6, player );
        
        if ( scripts\engine\utility::issharedfuncdefined( "gunship_sp", "introDofStart" ) )
        {
            level.gunship_intromodel thread scripts\engine\utility::callsharedfunc( "gunship_sp", "introDofStart" );
        }
        else
        {
            level.gunship_intromodel childthread gunship_playdofintroeffects();
        }
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "gunship_sp", "introStartLighting" ) )
    {
        level.gunship_intromodel thread scripts\engine\utility::callsharedfunc( "gunship_sp", "introStartLighting" );
    }
    
    level.gunship_intromodel.scenenode scripts\common\anim::anim_single_solo( level.gunship_intromodel, var_e4739db3b860ef4 );
    
    if ( !thirdpersoncam )
    {
        player disablephysicaldepthoffieldscripting();
        gunship_stopshellshock();
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "gunship_sp", "introDofEnd" ) )
    {
        level.gunship_intromodel thread scripts\engine\utility::callsharedfunc( "gunship_sp", "introDofEnd" );
    }
    
    if ( !isdefined( level.gunship_intromodel ) )
    {
        return false;
    }
    
    level.gunship_intromodel notify( "gunship_end_intro" );
    
    if ( !thirdpersoncam )
    {
        player unlink();
        player cameraunlink();
    }
    
    level.gunship_intromodel delete();
    
    if ( isdefined( level.var_fb13600ef005ed60 ) )
    {
        if ( level.var_fb13600ef005ed60 < getdvarint( @"hash_345d2095c9589e91" ) )
        {
            setsaveddvar( @"hash_345d2095c9589e91", level.var_fb13600ef005ed60 );
        }
        
        player lerpfovscalefactor( 0, 0 );
        player modifybasefov( level.var_fb13600ef005ed60, 0 );
        player lerpfov( level.var_fb13600ef005ed60, 0 );
    }
    else
    {
        if ( getdvarint( @"hash_345d2095c9589e91" ) < 30 )
        {
            setsaveddvar( @"hash_345d2095c9589e91", 30 );
        }
        
        player lerpfovscalefactor( 1, 0 );
        player modifybasefov( 65, 0 );
        player lerpfov( 65, 0 );
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "gunship_sp", "introEndLighting" ) )
    {
        thread scripts\engine\utility::callsharedfunc( "gunship_sp", "introEndLighting" );
    }
    
    return true;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x50c0
// Size: 0x1c5
function function_6d92cdefdf500a8b( thirdpersoncam )
{
    level endon( "stop_userskip" );
    flag_wait( "userskipped" );
    level notify( "userskipped_sky" );
    level.gunship_intromodel notify( "gunship_end_intro" );
    
    if ( !thirdpersoncam )
    {
        self disablephysicaldepthoffieldscripting();
        gunship_stopshellshock();
        self unlink();
        self cameraunlink();
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "gunship_sp", "introDofEnd" ) )
    {
        level.gunship_intromodel thread scripts\engine\utility::callsharedfunc( "gunship_sp", "introDofEnd" );
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "gunship_sp", "introEndLighting" ) )
    {
        thread scripts\engine\utility::callsharedfunc( "gunship_sp", "introEndLighting" );
    }
    
    self lerpfovscalefactor( 0, 0 );
    
    if ( isdefined( level.var_fb13600ef005ed60 ) )
    {
        if ( level.var_fb13600ef005ed60 < getdvarint( @"hash_345d2095c9589e91" ) )
        {
            setsaveddvar( @"hash_345d2095c9589e91", level.var_fb13600ef005ed60 );
        }
        
        self modifybasefov( level.var_fb13600ef005ed60, 0 );
        self lerpfov( level.var_fb13600ef005ed60, 0 );
    }
    else
    {
        if ( getdvarint( @"hash_345d2095c9589e91" ) < 30 )
        {
            setsaveddvar( @"hash_345d2095c9589e91", 30 );
        }
        
        self modifybasefov( 65, 0 );
        self lerpfov( 65, 0 );
    }
    
    scripts\sp\utility::function_d4697f18fc3ff634();
    scripts\sp\hud_util::fade_out( 0 );
    thread intro_fade_in();
    thread scripts\sp\anim::letterbox_enable( 0, 0 );
    level notify( "gunship_intro_over" );
    level.player scripts\sp\player::focusenable();
    setomnvar( "ui_hide_hud", 0 );
    level.player utility::dof_disable_autofocus();
    level.player utility::dof_disable();
    level.player freezecontrols( 0 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x528d
// Size: 0x13
function function_1b320b4d404d17e9( alias )
{
    self playsound( alias );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x52a8
// Size: 0x3a
function gunship_hideintromodelonplayerconnect()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    
    while ( true )
    {
        level waittill( "connected", player );
        self hide();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x52ea
// Size: 0x60
function gunship_watchintrodisown( action, streakinfo )
{
    self endon( "death" );
    self endon( "gunship_end_intro" );
    gunshipowner = level.gunship_intromodel.owner;
    gunshipowner waittill( action );
    
    if ( action == "disconnect" )
    {
        level.gunshipinuse = 0;
    }
    
    gunship_detachplayerfromintro( gunshipowner, streakinfo );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x5352
// Size: 0x8d
function gunship_detachplayerfromintro( gunshipowner, streakinfo )
{
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
    #/
    
    if ( isdefined( gunshipowner ) && !thirdpersoncam )
    {
        gunshipowner cameraunlink();
        gunshipowner gunship_stopshellshock();
        gunshipowner disablephysicaldepthoffieldscripting();
        gunshipowner painvisionon();
    }
    
    streakinfo notify( "killstreak_finished_with_deploy_weapon" );
    self setscriptablepartstate( "clouds_intro", "off", 0 );
    self setscriptablepartstate( "bodyFX_intro", "off", 0 );
    self delete();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x53e7
// Size: 0x8c
function gunship_startintroshake( var_e4739db3b860ef4, animlength, owner )
{
    self endon( "death" );
    animtime = animlength;
    eqscale = 0.45;
    shaketime = 0.05;
    
    while ( animtime > 0 )
    {
        earthquake( eqscale, shaketime, self.origin, 5000 );
        eqscale -= 0.01;
        
        if ( eqscale <= 0.12 )
        {
            eqscale = 0.12;
        }
        
        animtime -= shaketime;
        wait shaketime;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x547b
// Size: 0xfc
function gunship_queuecamerazoom( animlength, player )
{
    self endon( "death" );
    player endon( "disconnect" );
    level.var_e76baaf9a076d84 = getdvarfloat( @"hash_fc7ccbeacbe663d6" );
    setsaveddvar( @"hash_fc7ccbeacbe663d6", 2.35 );
    showcinematicletterboxing( 0, 0 );
    visionsetnaked( "gunship_intro_jup_sp", 0 );
    setsaveddvar( @"sm_sunsamplesizenear", 0.85 );
    setsaveddvar( @"hash_63b517de4ccc57cd", 1 );
    setsaveddvar( @"hash_4c14e16355aa5cb0", 3 );
    level.lighting = spawnstruct();
    level.lighting.var_18f0b319c1713acb = getmapsunangles();
    setsundirection( anglestoforward( ( -30, -140, 0 ) ) );
    wait animlength - 0.3;
    scripts\sp\utility::userskip_stop();
    scripts\sp\hud_util::fade_out( 0.1 );
    thread intro_fade_in();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x557f
// Size: 0xb0
function intro_fade_in()
{
    wait 0.1;
    level.player painvisionoff();
    visionsetfadetoblack( "" );
    visionsetthermal( "" );
    wait 0.2;
    
    if ( isdefined( level.lighting ) && isdefined( level.lighting.var_18f0b319c1713acb ) )
    {
        setsundirection( anglestoforward( level.lighting.var_18f0b319c1713acb ) );
    }
    
    if ( isdefined( level.var_e76baaf9a076d84 ) )
    {
        setsaveddvar( @"hash_fc7ccbeacbe663d6", level.var_e76baaf9a076d84 );
    }
    
    hidecinematicletterboxing( 0, 0 );
    thread scripts\sp\hud_util::fade_in( 0.1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x5637
// Size: 0x53
function gunship_playdofintroeffects()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    
    while ( !isdefined( level.gunship_intromodel ) )
    {
        waitframe();
    }
    
    level.player utility::dof_enable_autofocus( 0.75, level.gunship_intromodel, 100, undefined, undefined, "tag_origin", undefined, 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x5692
// Size: 0x18a
function function_a26f1c542c8d41c1( owner, streakinfo )
{
    var_bc737640dd23dd18 = "veh9_mil_air_gunship_sp";
    gunship = spawn( "script_model", level.gunship.origin );
    gunship.health = 9999;
    level.gunship.model_ent = gunship;
    gunship dontinterpolate();
    gunship setmodel( var_bc737640dd23dd18 );
    
    if ( is_equal( var_bc737640dd23dd18, "veh9_mil_air_gunship_sp" ) )
    {
        gunship function_2f0abf268b260f94();
    }
    
    gunship notsolid();
    gunship.currenthealth = 1000;
    gunship.maxhealth = gunship.currenthealth;
    gunship.health = 99999;
    gunship.owner = owner;
    gunship.team = owner.team;
    gunship.timeout = 45;
    gunship.currentdamagestate = 0;
    gunship dontcastshadows();
    gunship dontcastdistantshadows();
    
    /#
        timeoutoverride = getdvarint( @"hash_fa402c92e4148a39", 45 );
        var_2a98d1683cf44153 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_2a98d1683cf44153 )
        {
            timeoutoverride = 9999;
        }
        
        gunship.timeout = timeoutoverride;
    #/
    
    gunship.flaresreservecount = 1;
    gunship.streakinfo = streakinfo;
    return gunship;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x5825
// Size: 0x26b
function function_2f0abf268b260f94()
{
    weapon_big = spawn( "script_model", self gettagorigin( "tag_gun_big" ) );
    weapon_big.angles = self gettagangles( "tag_gun_big" );
    weapon_big setmodel( "veh9_mil_air_gunship_gun_big" );
    thread delete_on_death( weapon_big );
    weapon_big.target_ent = spawn_script_origin();
    weapon_big.target_ent dontinterpolate();
    weapon_big notsolid();
    weapon_big dontcastshadows();
    weapon_big dontcastdistantshadows();
    thread delete_on_death( weapon_big.target_ent );
    weapon_big linkto( self, "tag_gun_big", ( 4, 0, 0 ), ( 0, 0, 0 ) );
    offset = weapon_big.origin + anglestoforward( weapon_big.angles ) * 150;
    weapon_big.var_55ba759bc54f065 = spawn_tag_origin( offset, weapon_big.angles );
    weapon_big.var_55ba759bc54f065 linkto( weapon_big, "tag_origin" );
    self.weapon_big = weapon_big;
    weapon_small = spawn( "script_model", self gettagorigin( "tag_gun_small" ) );
    weapon_small.angles = self gettagangles( "tag_gun_small" );
    weapon_small setmodel( "veh9_mil_air_gunship_gun_small" );
    weapon_small.target_ent = spawn_script_origin();
    weapon_small.target_ent dontinterpolate();
    weapon_small dontcastshadows();
    weapon_small dontcastdistantshadows();
    thread delete_on_death( weapon_small );
    thread delete_on_death( weapon_small.target_ent );
    weapon_small notsolid();
    weapon_small linkto( self, "tag_gun_small", ( 0, -60, 0 ), ( 0, 0, 0 ) );
    offset = weapon_small.origin + anglestoforward( weapon_small.angles ) * 70;
    weapon_small.var_55ba759bc54f065 = spawn_tag_origin( offset, weapon_small.angles );
    weapon_small.var_55ba759bc54f065 linkto( weapon_small, "tag_origin" );
    thread delete_on_death( weapon_small.var_55ba759bc54f065 );
    self.weapon_small = weapon_small;
    childthread function_c161dfa5d7b807ee( level.player );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x5a98
// Size: 0x14b
function function_702095380cde1053( vertical_offset )
{
    level notify( "scr_gunship_flight_path" );
    level endon( "scr_gunship_flight_path" );
    
    if ( !isdefined( vertical_offset ) )
    {
        vertical_offset = 0;
    }
    
    offset_base = vertical_offset;
    iterations = 20;
    time = 1;
    
    while ( true )
    {
        childthread draw_line_for_time( level.gunship.origin, level.gunship.origin - ( 0, 0, 10000 ), 1, 1, 1, time );
        childthread draw_line_for_time( level.player.origin, level.gunship.origin - ( 0, 0, 10000 ), 1, 1, 1, time );
        
        for ( i = 0; i < iterations ; i++ )
        {
            draw_circle( level.gunship.origin + ( 0, 0, vertical_offset ), level.var_c9432be18d145ed5, ( 1, 1, 1 ), 1 - i / iterations, 1, time * 1000 );
            vertical_offset += 0.5 * level.var_c9432be18d145ed5 / 80;
        }
        
        wait time;
        vertical_offset = offset_base;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x5beb
// Size: 0x4d5
function gunship_attachgunner( gunner )
{
    self endon( "death" );
    self endon( "crashing" );
    gunner lerpfovscalefactor( 0, 0 );
    level.player scripts\sp\player::focusenable();
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            gunner cameraunlink();
            
            if ( isdefined( level.gunship_intromodel ) )
            {
                if ( isdefined( level.gunship_intromodel.scenenode ) )
                {
                    level.gunship_intromodel.scenenode delete();
                }
                
                level.gunship_intromodel setscriptablepartstate( "<dev string:xbf>", "<dev string:xcc>", 0 );
                level.gunship_intromodel setscriptablepartstate( "<dev string:xd0>", "<dev string:xcc>", 0 );
                level.gunship_intromodel delete();
            }
            
            self.streakinfo notify( "<dev string:x73>" );
            return;
        }
    #/
    
    self.currentvisionset = level.gunship.color_vision;
    waitframe();
    
    if ( !istrue( level.var_259a7e2e6fa2cbe6 ) )
    {
        gunner cameraunlink();
    }
    
    if ( isdefined( level.gunship_intromodel ) )
    {
        if ( isdefined( level.gunship_intromodel.scenenode ) )
        {
            level.gunship_intromodel.scenenode delete();
        }
        
        level.gunship_intromodel setscriptablepartstate( "clouds_intro", "off", 0 );
        level.gunship_intromodel setscriptablepartstate( "bodyFX_intro", "off", 0 );
        level.gunship_intromodel delete();
    }
    
    self.contentsoverride = create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1 );
    function_e1ad6b2ed15830a1();
    
    if ( isbot( gunner ) || isai( gunner ) )
    {
        gunner cameralinkto( self.camera, "tag_player" );
        return;
    }
    
    self hideallparts();
    self.weapon_big hideallparts();
    self.weapon_small hideallparts();
    gunner setclientomnvar( "ui_killstreak_zoom_fov", level.var_fb13600ef005ed60 );
    setsaveddvar( @"cg_drawcrosshair", 0 );
    
    if ( getdvarint( @"hash_94c408c5514d7615", 0 ) == 0 )
    {
        setomnvar( "ui_hide_hud", 1 );
    }
    
    player::disable_player_weapon_info();
    level.gunship.deployweaponobj = gunner getcurrentweapon();
    gunner takeallweapons();
    weapons = [];
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 1 )
    {
        weapons[ weapons.size ] = scripts\sp\utility::make_weapon( level.gunship.var_d660505e3d0ba81d );
        weapons[ weapons.size ] = scripts\sp\utility::make_weapon( level.gunship.var_d6604d5e3d0ba184 );
        
        if ( getdvarint( @"hash_80478c6f0f12492a" ) )
        {
            weapons[ weapons.size ] = scripts\sp\utility::make_weapon( level.gunship.var_d6604e5e3d0ba3b7 );
        }
        else
        {
            weapons[ weapons.size ] = scripts\sp\utility::make_weapon( level.gunship.var_d6604f5e3d0ba5ea );
        }
        
        self.weapon_objects = weapons;
    }
    else if ( getdvarint( @"hash_ef7a4f0ffc468e7b" ) == 1 )
    {
        weapons[ weapons.size ] = gunner function_37c13ed7196514c4( level.gunship.var_d660505e3d0ba81d, 0, [ level.gunship.var_10a90f7f2ccc7f03 ], 0, level.var_fb13600ef005ed60 );
    }
    else
    {
        weapons[ weapons.size ] = gunner function_37c13ed7196514c4( "gunship_gunless_sp", 0, [ level.gunship.var_10a90f7f2ccc7f03 ], 0, level.var_fb13600ef005ed60 );
    }
    
    foreach ( weapon in weapons )
    {
        gunner scripts\sp\utility::give_weapon( weapon, 0, 0, 0, 1 );
        
        if ( getdvarint( @"hash_f213fc40b2f63070" ) == 1 )
        {
            gunner givemaxammo( weapon );
        }
    }
    
    gunner gunship_switchtoweaponimmediate( weapons[ 0 ] );
    function_35b96115a717f40a( gunner );
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 1 )
    {
        function_b6934bb42d84da8a( gunner );
    }
    else
    {
        function_adf23ae3a7125652( gunner );
    }
    
    gunner childthread function_203be5da1a428ee4();
    gunner setviewangleresistance( 30, 30, 15, 15 );
    level notify( "gunship_intro_over" );
    gunner setclientomnvar( "ui_killstreak_controls", 9 );
    setomnvar( "ui_gunship_show_bindings", 0 );
    gunner setclientomnvar( "ui_gunship_show_bindings", 0 );
    setomnvar( "ui_gunship_show_tutorial", 0 );
    gunner setclientomnvar( "ui_gunship_show_tutorial", 0 );
    childthread function_9c33573bb832a824( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x60c8
// Size: 0xe8
function function_203be5da1a428ee4()
{
    level endon( "stop_gunship" );
    
    for ( ;; )
    {
        if ( self isvehicleactive() )
        {
            self disableslowaim();
        }
        else if ( self getlocalplayerprofiledata( "gpadEnabled" ) )
        {
            var_1b76d5208a3eb6d0 = self getlocalplayerprofiledata( "ViewHorzSensitivity" );
            var_1b76d3208a3eb26a = self getlocalplayerprofiledata( "ViewVertSensitivity" );
            var_1b76d5208a3eb6d0 = math::remap( var_1b76d5208a3eb6d0, 0.6, 4, 0.6, 0.2 );
            var_1b76d3208a3eb26a = math::remap( var_1b76d3208a3eb26a, 0.6, 4, 0.6, 0.2 );
            self enableslowaim( var_1b76d3208a3eb26a, var_1b76d5208a3eb6d0 );
        }
        else
        {
            sensitivity = self getlocalplayerprofiledata( "ViewMouseHorzSensitivity" );
            
            if ( sensitivity > 5 )
            {
                sensitivity = math::remap( sensitivity, 0.01, 99, 0.5, 0.05 );
                self enableslowaim( sensitivity, sensitivity );
            }
            else
            {
                self enableslowaim( 1, 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 5
// Checksum 0x0, Offset: 0x61b8
// Size: 0x80
function function_37c13ed7196514c4( weapon_string, switch_to, attachments, var_1e5e00df2122415d, basefov )
{
    if ( istrue( var_1e5e00df2122415d ) )
    {
        self takeallweapons();
    }
    
    weapon = scripts\sp\utility::make_weapon( weapon_string, attachments );
    
    if ( isdefined( basefov ) )
    {
        self lerpfovscalefactor( 0, 0 );
        self modifybasefov( basefov, 0.01 );
    }
    
    if ( istrue( switch_to ) )
    {
        scripts\sp\utility::give_weapon( weapon, 0, 0, 0, 1 );
        gunship_switchtoweaponimmediate( weapon );
    }
    
    return weapon;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x6241
// Size: 0x221
function function_35b96115a717f40a( gunner )
{
    gunner val::set_array( "gunship", level.gunship.allows, 0 );
    setsaveddvar( @"cg_drawcrosshair", 0 );
    gunner.ignoreme = 1;
    gunner enableinvulnerability();
    gunner playerdisabletriggers();
    gunner setclienttriggeraudiozone( "gunship_plr_constant_low" );
    gunner setsoundsubmix( "iw9_sp_ac130_no_npc_weap" );
    thread function_8f6f6e7db4c8a53e();
    gunner hideviewmodel();
    gunner hidelegsandshadow();
    thread scripts\sp\art::setdoftracerange( 40000 );
    gunner setcinematicmotionoverride( "disabled" );
    gunner.usinggunship = 1;
    view_clamp = [ 90, 90, 50, 90 ];
    
    if ( isdefined( level.var_18a73555b2329261 ) )
    {
        view_clamp = level.var_18a73555b2329261;
    }
    
    self.camera.view_clamp = view_clamp;
    waitframe();
    gunner dontinterpolate();
    gunner.origin = self.camera.origin;
    self.camera.angles = vectortoangles( level.gunship.origin - self.camera.origin );
    
    if ( isdefined( level.var_fb13600ef005ed60 ) )
    {
        if ( level.var_fb13600ef005ed60 < getdvarint( @"hash_345d2095c9589e91" ) )
        {
            setsaveddvar( @"hash_345d2095c9589e91", level.var_fb13600ef005ed60 );
        }
        
        gunner lerpfovscalefactor( 0, 0 );
        gunner modifybasefov( level.var_fb13600ef005ed60, 0 );
        gunner lerpfov( level.var_fb13600ef005ed60, 0 );
    }
    else
    {
        if ( getdvarint( @"hash_345d2095c9589e91" ) != 30 )
        {
            setsaveddvar( @"hash_345d2095c9589e91", 30 );
        }
        
        gunner lerpfovscalefactor( 1, 0 );
        gunner modifybasefov( 65, 0.01 );
        gunner lerpfov( 65, 0 );
    }
    
    gunner childthread function_cff39111d0f3d337();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x646a
// Size: 0x52
function function_cff39111d0f3d337()
{
    for ( i = 0; isalive( self ) ; i++ )
    {
        utility::flag_waitopen( "pauseCameraFocus" );
        function_b3ac309ed8d8e063();
        
        if ( i == 5 )
        {
            wait 1.5 + randomintrange( 0, 3 );
            i = 0;
            continue;
        }
        
        wait 1.5;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x64c4
// Size: 0x92
function function_b3ac309ed8d8e063()
{
    if ( getdvarint( @"hash_c9238ac4cc17e116" ) == 0 )
    {
        return;
    }
    
    if ( scripts\engine\sp\utility::isads() )
    {
        sway_pitch = 0.03;
        sway_roll = 0.05;
    }
    else
    {
        sway_pitch = 0.05;
        sway_roll = 0.07;
    }
    
    sway_pitch = randomfloatrange( 0.01, sway_pitch * 5 );
    sway_roll = randomfloatrange( 0.01, sway_roll * 2 );
    self screenshakeonentity( sway_pitch, 0, sway_roll, 2, 1, 1, 2000, randomfloatrange( 0.5, 1.2 ) );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x655e
// Size: 0xa7
function function_cb0b6f2e8c19e1d3( allows )
{
    assert( isdefined( level.gunship ) );
    
    if ( !isdefined( allows ) )
    {
        if ( isdefined( level.var_9c416c88d4621a0f ) )
        {
            allows = level.var_9c416c88d4621a0f;
        }
        else
        {
            allows = [ "crouch", "mantle", "melee", "prone", "offhand_weapons", "sprint", "allow_jump", "slide", "usability" ];
        }
    }
    
    level.gunship.allows = allows;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x660d
// Size: 0x1ba
function function_e1ad6b2ed15830a1()
{
    focus_origin = function_abe98e26c5b29af1();
    
    if ( self tagexists( "tag_player_camera" ) )
    {
        self.camera = spawn( "script_model", self gettagorigin( "tag_player_camera" ) );
        self.camera.angles = self gettagangles( "tag_player_camera" );
    }
    else
    {
        self.camera = spawn( "script_model", self gettagorigin( "tag_player" ) );
        self.camera.angles = self.angles;
    }
    
    self.camera setmodel( "tag_player" );
    self.camera notsolid();
    self.camera dontinterpolate();
    
    if ( self tagexists( "tag_player_camera" ) )
    {
        self.camera linkto( self, "tag_player_camera", ( 0, 20, -75 ), ( 0, 0, 0 ) );
    }
    else
    {
        self.camera linkto( self, "tag_player", ( 160, 35, -25 ), ( 50, 90, 0 ) );
    }
    
    self.camera.focus_ent = self.camera spawn_script_origin( focus_origin );
    self.camera.focus_ent dontinterpolate();
    self.camera.angles = vectortoangles( level.gunship.origin - self.camera.origin );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x67cf
// Size: 0x72
function function_abe98e26c5b29af1()
{
    focus_origin = level.gunship.origin;
    
    if ( isdefined( level.var_dc44706239201a43 ) )
    {
        focus_origin = level.var_dc44706239201a43;
    }
    else if ( isdefined( level.gunship.link ) )
    {
        focus_origin = level.gunship.link.origin;
    }
    
    return focus_origin;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x684a
// Size: 0xee
function function_6b7ff0cd994a7fe( player, contentsoverride, max_dist )
{
    if ( isdefined( self.turret ) )
    {
        ignorearray = [ player, self, self.turret ];
    }
    else
    {
        ignorearray = [ player, self ];
    }
    
    forward = anglestoforward( player getplayerangles() );
    start = player getvieworigin();
    
    if ( isdefined( max_dist ) )
    {
        end = start + forward * max_dist;
    }
    else
    {
        end = start + forward * 100000;
    }
    
    trace = scripts\engine\trace::ray_trace_detail( start, end, ignorearray, contentsoverride );
    
    /#
        if ( getdvarint( @"hash_3509a98e15960501" ) == 1 )
        {
            childthread draw_line_for_time( start, trace[ "<dev string:xdd>" ], 1, 0, 1, 10 );
        }
    #/
    
    return trace;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0x6941
// Size: 0x8e
function function_b05d7be29251f29f( var_52192ee62bb1f1d1, ignorearray, contentsoverride, max_dist )
{
    forward = anglestoforward( var_52192ee62bb1f1d1.angles );
    start = var_52192ee62bb1f1d1.origin;
    
    if ( isdefined( max_dist ) )
    {
        end = start + forward * max_dist;
    }
    else
    {
        end = start + forward * 100000;
    }
    
    trace = scripts\engine\trace::ray_trace_detail( start, end, ignorearray, contentsoverride );
    return trace;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x69d8
// Size: 0x64
function function_b6934bb42d84da8a( gunner )
{
    view_clamp = self.camera.view_clamp;
    gunner playerlinkweaponviewtodelta( self.camera, "tag_player", 0, view_clamp[ 0 ], view_clamp[ 1 ], view_clamp[ 2 ], view_clamp[ 3 ], 0, 1, 1 );
    gunner playerlinkedsetviewznear( 0 );
    childthread function_c477de5775b6f437( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x6a44
// Size: 0x30
function function_c39defa1b1c06412()
{
    focus_object = scripts\engine\sp\utility::get_linked_struct();
    
    if ( !isdefined( focus_object ) && isdefined( self.script_linkto ) )
    {
        focus_object = get_linked_ent();
    }
    
    return focus_object;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x6a7d
// Size: 0x58
function function_adf23ae3a7125652( gunner )
{
    view_clamp = self.camera.view_clamp;
    gunner playerlinktodelta( self.camera, "tag_player", 0, view_clamp[ 0 ], view_clamp[ 1 ], view_clamp[ 2 ], view_clamp[ 3 ], 0 );
    childthread function_c477de5775b6f437( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x6add
// Size: 0x3c
function function_f3487eda44847314( viewmodel, legmodel, shadowmodel )
{
    if ( isdefined( viewmodel ) )
    {
        self setviewmodel( viewmodel );
    }
    
    if ( isdefined( legmodel ) )
    {
        self setlegsmodel( legmodel );
    }
    
    self hideviewmodel();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x6b21
// Size: 0x148
function function_c477de5775b6f437( gunner )
{
    waittillframeend();
    var_34743d0c04f178ef = vectortoangles( self.camera.focus_ent.origin - gunner getvieworigin() );
    gunner setplayerangles( var_34743d0c04f178ef );
    self.oldangles = var_34743d0c04f178ef;
    
    while ( isalive( gunner ) )
    {
        newangles = vectortoangles( self.camera.focus_ent.origin - gunner getvieworigin() );
        var_b5b3431a0126e171 = ( self.oldangles[ 0 ] - newangles[ 0 ], self.oldangles[ 1 ] - newangles[ 1 ], 0 );
        var_47eb6724c1e4e7a4 = gunner getplayerangles() - var_b5b3431a0126e171;
        gunner setplayerangles( var_47eb6724c1e4e7a4 );
        self.camera.focus_ent.origin = function_6b7ff0cd994a7fe( gunner )[ "position" ];
        self.oldangles = vectortoangles( self.camera.focus_ent.origin - gunner getvieworigin() );
        utility::flag_waitopen( "pauseCameraFocus" );
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x6c71
// Size: 0x5f
function function_681115bb729346de( gunner )
{
    origin = gunner gettagorigin( "tag_eye" );
    angles = gunner gettagangles( "tag_eye" );
    forward = origin + anglestoforward( angles ) * 100;
    thread draw_line_for_time( origin, forward, 1, 1, 1, 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x6cd8
// Size: 0x3a
function function_ecfdc120a7cf6fe8()
{
    focus_origin = function_abe98e26c5b29af1();
    ent = spawn_tag_origin( focus_origin, ( 0, 0, 0 ) );
    ent dontinterpolate();
    return ent;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x6d1b
// Size: 0xa8
function function_ff5b3dbacd9c0cdd( player, view_clamp )
{
    if ( isdefined( self.camera ) )
    {
        if ( !isdefined( view_clamp ) )
        {
            view_clamp = [ 90, 90, 50, 90 ];
            
            if ( isdefined( level.var_18a73555b2329261 ) )
            {
                view_clamp = level.var_18a73555b2329261;
            }
        }
        
        while ( !player islinked() )
        {
            waitframe();
        }
        
        while ( player function_68d997f850b153c7() )
        {
            waitframe();
        }
        
        player lerpviewangleclamp( 0, 0, 0, 0, 0, 0, 0 );
        player lerpviewangleclamp( 0, 0, 0, view_clamp[ 0 ], view_clamp[ 1 ], view_clamp[ 2 ], view_clamp[ 3 ] );
        player setviewangleresistance( 30, 30, 15, 15 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 6
// Checksum 0x0, Offset: 0x6dcb
// Size: 0x98
function function_3b0be67066481f21( nearstart, nearend, farstart, farend, nearblur, farblur )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    nearstart = max( nearstart, 0 );
    nearend = clamp( nearend, 1, 9994 );
    farstart = clamp( farstart, 2, 9998 );
    farend = clamp( farend, 3, 9999 );
    
    if ( farstart > 9994 )
    {
        farblur = 0;
    }
    
    self setdepthoffield( nearstart, nearend, farstart, farend, nearblur, farblur );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x6e6b
// Size: 0x171
function gunship_ads( player )
{
    self endon( "death" );
    player lerpfov( level.var_fb13600ef005ed60, 0.01 );
    level.var_a6bbc14d819f5470 = level.var_fb13600ef005ed60;
    player childthread function_2b6b6e8da0f4510c();
    lerp_time = 0.2;
    
    while ( true )
    {
        should_ads = player adsbuttonpressed( 1 );
        changed = 0;
        
        if ( should_ads )
        {
            flag_set( "gunship_ads_pressed" );
            
            if ( flag( "should_max_ads" ) )
            {
                player lerpfov( level.var_10a026b50d5be68f, lerp_time );
                level.var_a6bbc14d819f5470 = level.var_10a026b50d5be68f;
            }
            else
            {
                player lerpfov( level.var_285ce926ff345ee3, lerp_time );
                level.var_a6bbc14d819f5470 = level.var_285ce926ff345ee3;
            }
            
            if ( level.var_ac0ee5ab988fff9f != level.var_abebd3ab98699051 )
            {
                childthread function_85106c8b0af97990( level.var_abebd3ab98699051 );
            }
            
            changed = 1;
        }
        else
        {
            flag_clear( "gunship_ads_pressed" );
            flag_clear( "should_max_ads" );
            player lerpfov( level.var_fb13600ef005ed60, lerp_time );
            level.var_a6bbc14d819f5470 = level.var_fb13600ef005ed60;
            
            if ( level.var_ac0ee5ab988fff9f != level.var_abebd3ab98699051 )
            {
                childthread function_85106c8b0af97990( level.var_ac0ee5ab988fff9f );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x6fe4
// Size: 0x59
function function_2b6b6e8da0f4510c()
{
    while ( true )
    {
        utility::waittill_any_2( "sprint_pressed", "melee_pressed" );
        is_ads = self adsbuttonpressed();
        
        if ( is_ads )
        {
            if ( !flag( "should_max_ads" ) )
            {
                flag_set( "should_max_ads" );
                continue;
            }
            
            flag_clear( "should_max_ads" );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x7045
// Size: 0x34
function function_85106c8b0af97990( speed )
{
    level.gunship_speed[ "rotate" ] = speed;
    rotateplane( "off_instant" );
    rotateplane( "on" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0x7081
// Size: 0x42
function gunship_giveweapon( weapon, variant, dualwieldoverride, usedbefore )
{
    if ( !isdefined( variant ) )
    {
        variant = -1;
    }
    
    if ( !isdefined( usedbefore ) )
    {
        usedbefore = 0;
    }
    
    self giveweapon( weapon, variant, istrue( dualwieldoverride ), -1, usedbefore );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x70cb
// Size: 0x13
function gunship_switchtoweaponimmediate( weapon )
{
    self switchtoweaponimmediate( weapon );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x70e6
// Size: 0x137
function function_9c33573bb832a824( gunner )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    level endon( "missionfailed" );
    level endon( "stop_gunship" );
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    gunner val::set( "gunship", "weapon_switch", 0 );
    
    if ( !istrue( level.var_f1acd9be11d8efe5 ) )
    {
        gunner setclientomnvar( "ui_killstreak_weapon", 0 );
        gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", 0 );
    }
    
    self.currentweaponindex = 1;
    gunner allowfire( 0 );
    
    while ( !istrue( level.var_f1acd9be11d8efe5 ) )
    {
        waitframe();
    }
    
    gunner setclientomnvar( "ui_killstreak_weapon", 1 );
    gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", 30 );
    childthread gunship_watchweaponfired( gunner );
    
    if ( getdvarint( @"hash_80478c6f0f12492a" ) )
    {
        childthread function_26067d6d8c85dc( gunner );
    }
    
    if ( getdvarint( @"hash_cca85e49b724df8b" ) == 0 )
    {
        gunner function_a8d38309fd6157f9();
    }
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 0 )
    {
        function_eea48efa8d43b682( gunner );
        return;
    }
    
    thread function_f897b18f3dfd04bd( gunner );
    function_fb457a2ad44e0ca5( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x7225
// Size: 0xe1
function function_f897b18f3dfd04bd( gunner )
{
    gunner.var_f4c84d68c257f5c5 = 1;
    gunner setadsphysicaldepthoffield( 1, 30000 );
    
    while ( true )
    {
        gunner utility::waittill_any_2( "ads_pressed", "ads_released" );
        
        if ( gunner adsbuttonpressed() )
        {
            if ( istrue( gunner.var_f4c84d68c257f5c5 ) && gunner sprintbuttonpressed() )
            {
                gunner lerpfov( level.var_285ce926ff345ee3, 0.2 );
                gunner.var_f4c84d68c257f5c5 = 0;
            }
            else if ( !istrue( gunner.var_f4c84d68c257f5c5 ) && gunner sprintbuttonpressed() )
            {
                gunner lerpfov( level.var_10a026b50d5be68f, 0.2 );
                gunner.var_f4c84d68c257f5c5 = 1;
            }
            
            continue;
        }
        
        gunner lerpfov( 65, 0.2 );
        gunner.var_f4c84d68c257f5c5 = 0;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x730e
// Size: 0x2b8
function function_eea48efa8d43b682( gunner )
{
    fire_rate[ 1 ] = 4;
    fire_rate[ 2 ] = 15;
    fire_rate[ 3 ] = 255;
    childthread function_c35c79990dcb7020( gunner );
    level.gunship.var_6cbd80d5c55ff987 = function_a79b46a6d3d7def();
    gunner notifyonplayercommand( "weapon_switch_next", "-weapnext" );
    gunner notifyonplayercommand( "weapon_switch_next", "selectweapon2" );
    gunner notifyonplayercommand( "weapon_switch_previous", "+weapprev" );
    gunner notifyonplayercommand( "weapon_switch_previous", "selectweapon1" );
    
    for ( ;; )
    {
        playerusinggamepad = gunner usinggamepad();
        cmd = "";
        
        if ( istrue( playerusinggamepad ) )
        {
            gunner waittill( "weapon_switch_pressed" );
        }
        else
        {
            cmd = gunner waittill_any_return_2( "weapon_switch_next", "weapon_switch_previous" );
        }
        
        if ( flag( "pauseWeaponSwap" ) )
        {
        }
        else
        {
            if ( isdefined( cmd ) && gunner isweaponsenabled() )
            {
                current_weapon_name = level.gunship.var_6cbd80d5c55ff987[ self.currentweaponindex ];
                var_593560394b8bddf6 = function_f45ebfa891515d9b( current_weapon_name );
                
                if ( current_weapon_name == level.gunship.var_d660505e3d0ba81d )
                {
                    if ( !istrue( gunner.weapon_reloading ) )
                    {
                        weapon = gunner getcurrentweapon();
                        currentammo = gunner getweaponammoclip( weapon );
                        
                        if ( currentammo < 15 )
                        {
                            gunner thread function_6c7ef99bf5ba717f( weapon, self );
                        }
                    }
                }
                else if ( var_593560394b8bddf6.currentammo < var_593560394b8bddf6.lowammo )
                {
                    function_dc20e70ce4d6b547( var_593560394b8bddf6, gunner );
                }
                
                gunner playlocalsound( "iw8_ks_ac130_weaponswitch" );
                
                if ( cmd == "weapon_switch_next" )
                {
                    self.currentweaponindex--;
                }
                else
                {
                    self.currentweaponindex++;
                }
                
                if ( self.currentweaponindex > 3 )
                {
                    self.currentweaponindex = 1;
                }
                else if ( self.currentweaponindex < 1 )
                {
                    self.currentweaponindex = 3;
                }
                
                gunner setclientomnvar( "ui_killstreak_weapon", self.currentweaponindex );
                current_weapon_name = level.gunship.var_6cbd80d5c55ff987[ self.currentweaponindex ];
                var_5753fff364d480fa = function_f45ebfa891515d9b( current_weapon_name );
                childthread function_749e3c5f99d50954( "gunship_weapon_shutter_crt", 0.025, 0.08, 0.15 );
                earthquake( 0.07, 1.5, gunner.origin, 100 );
                gunner playrumbleonentity( "ui_haptic" );
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x75ce
// Size: 0x80
function function_a79b46a6d3d7def()
{
    var_6cbd80d5c55ff987[ 1 ] = level.gunship.var_d660505e3d0ba81d;
    var_6cbd80d5c55ff987[ 2 ] = level.gunship.var_d6604d5e3d0ba184;
    
    if ( getdvarint( @"hash_80478c6f0f12492a" ) )
    {
        var_6cbd80d5c55ff987[ 3 ] = level.gunship.var_d6604e5e3d0ba3b7;
    }
    else
    {
        var_6cbd80d5c55ff987[ 3 ] = level.gunship.var_d6604f5e3d0ba5ea;
    }
    
    return var_6cbd80d5c55ff987;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x7657
// Size: 0xaf
function function_c35c79990dcb7020( gunner )
{
    level endon( "stop_gunship" );
    
    while ( true )
    {
        gunner waittill( "reload_pressed" );
        weapon_name = function_878e144349832994( gunner );
        
        if ( weapon_name == level.gunship.var_d660505e3d0ba81d )
        {
            if ( !istrue( gunner.weapon_reloading ) )
            {
                weapon = gunner getcurrentweapon();
                currentammo = gunner getweaponammoclip( weapon );
                
                if ( currentammo < 30 )
                {
                    gunner childthread function_6c7ef99bf5ba717f( weapon, self );
                }
            }
        }
        else
        {
            var_872e9fd8a2a204b0 = function_f45ebfa891515d9b( weapon_name );
            function_dc20e70ce4d6b547( var_872e9fd8a2a204b0, gunner );
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0x770e
// Size: 0x94
function function_dc20e70ce4d6b547( var_872e9fd8a2a204b0, gunner, force, reloadtime )
{
    if ( istrue( force ) || !istrue( var_872e9fd8a2a204b0.is_reloading ) && var_872e9fd8a2a204b0.currentammo < var_872e9fd8a2a204b0.weapon_object.maxammo )
    {
        var_872e9fd8a2a204b0.currentammo = 0;
        gunner setclientomnvar( var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b, var_872e9fd8a2a204b0.currentammo );
        gunner thread gunship_weaponreload( var_872e9fd8a2a204b0, self, reloadtime );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x77aa
// Size: 0x2b7
function function_fb457a2ad44e0ca5( gunner )
{
    if ( getdvarint( @"hash_80478c6f0f12492a" ) )
    {
        weaponlistorder = [ level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604e5e3d0ba3b7 ];
    }
    else
    {
        weaponlistorder = [ level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604f5e3d0ba5ea ];
    }
    
    var_d42e569e7a0ffc49[ weaponlistorder[ 0 ] ] = self.weapon_objects[ 0 ];
    var_d42e569e7a0ffc49[ weaponlistorder[ 1 ] ] = self.weapon_objects[ 1 ];
    var_d42e569e7a0ffc49[ weaponlistorder[ 2 ] ] = self.weapon_objects[ 2 ];
    self.var_fff9e9244cd692a3 = function_8d01239b5d6b7cae( level.gunship.var_d660505e3d0ba81d, self.weapon_objects[ 0 ] );
    self.var_fff100244ccca68a = function_8d01239b5d6b7cae( level.gunship.var_d6604d5e3d0ba184, self.weapon_objects[ 1 ] );
    
    if ( getdvarint( @"hash_80478c6f0f12492a" ) )
    {
        self.var_f4364bd51b414686 = function_8d01239b5d6b7cae( level.gunship.var_d6604e5e3d0ba3b7, self.weapon_objects[ 2 ] );
    }
    else
    {
        self.var_e90a9a2f31633c19 = function_8d01239b5d6b7cae( level.gunship.var_d6604f5e3d0ba5ea, self.weapon_objects[ 2 ] );
    }
    
    currentweaponindex = 1;
    
    while ( true )
    {
        gunner waittill( "weapon_switch_pressed" );
        
        if ( gunner isweaponsenabled() )
        {
            gunner playlocalsound( "iw8_ks_ac130_weaponswitch" );
            currentweapon = gunner getcurrentweapon();
            newweapon = currentweapon;
            
            foreach ( weapon in weaponlistorder )
            {
                if ( currentweapon.basename == weapon )
                {
                    newweaponindex = index + 1;
                    
                    if ( newweaponindex > weaponlistorder.size - 1 )
                    {
                        newweaponindex = 0;
                    }
                    
                    newweapon = weaponlistorder[ newweaponindex ];
                    break;
                }
            }
            
            gunner gunship_switchtoweaponimmediate( var_d42e569e7a0ffc49[ newweapon ] );
            currentweaponindex++;
            
            if ( currentweaponindex > 3 )
            {
                currentweaponindex = 1;
            }
            
            gunner setclientomnvar( "ui_killstreak_weapon", currentweaponindex );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x7a69
// Size: 0x102
function function_c0d2b532e679f3aa()
{
    i = 0;
    wait 5;
    self takeallweapons();
    weapons = [];
    weapons[ weapons.size ] = scripts\sp\utility::make_weapon( "gunship_25mm_sp_ompound", [ level.gunship.var_10a90f7f2ccc7f03 ] );
    weapons[ weapons.size ] = scripts\sp\utility::make_weapon( "gunship_40mm_sp", [ level.gunship.var_10a90f7f2ccc7f03 ] );
    weapons[ weapons.size ] = scripts\sp\utility::make_weapon( "gunship_hellfire_sp" );
    
    foreach ( weapon in weapons )
    {
        scripts\sp\utility::give_weapon( weapon, 0, 0, 0, 1 );
    }
    
    while ( true )
    {
        /#
            iprintlnbold( "<dev string:xe6>" );
        #/
        
        i++;
        
        if ( i > 2 )
        {
            i = 0;
        }
        
        gunship_switchtoweaponimmediate( weapons[ i ] );
        wait 5;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x7b73
// Size: 0x74
function input_menu( lines )
{
    huds = [];
    background = create_menu( 600, 325, 0 );
    background setshader( "black", 100, 40 );
    background.alpha = 0.3;
    huds[ huds.size ] = background;
    huds_b = background add_lines( lines );
    huds = array_combine( huds, huds_b );
    return huds;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x7bf0
// Size: 0x89
function create_menu( x, y, var_214764106ae21d43 )
{
    if ( !isdefined( var_214764106ae21d43 ) )
    {
        var_214764106ae21d43 = 1;
    }
    
    hud = newhudelem();
    hud.x = x;
    hud.y = y;
    hud.horzalign = "left";
    hud.fontscale = 1;
    hud.hidewheninmenu = 1;
    hud.sort = var_214764106ae21d43;
    return hud;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x7c82
// Size: 0x105
function add_lines( lines, x )
{
    if ( istrue( x ) )
    {
        var_bb2684c4f4c3f570 = 62;
        starting = self.x + 5;
        var_1ce8af601ec4d316 = 1;
    }
    else
    {
        var_bb2684c4f4c3f570 = 15;
        starting = self.y + 5;
        var_1ce8af601ec4d316 = 0;
    }
    
    huds = [];
    
    foreach ( index, item in lines )
    {
        if ( var_1ce8af601ec4d316 )
        {
            hud = create_menu( starting + var_bb2684c4f4c3f570 * index, self.y + 10 );
        }
        else
        {
            hud = create_menu( self.x + 10, starting + var_bb2684c4f4c3f570 * index );
        }
        
        hud settext( item );
        huds[ huds.size ] = hud;
    }
    
    return huds;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x7d90
// Size: 0xc1
function gunship_getdofinfobyweapon( weaponbasename )
{
    dofinfo = spawnstruct();
    
    if ( weaponbasename == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        dofinfo.fstop = 8;
        dofinfo.focusdistance = 600;
    }
    else if ( weaponbasename == level.gunship.var_d6604d5e3d0ba184 )
    {
        dofinfo.fstop = 8;
        dofinfo.focusdistance = 600;
    }
    else if ( weaponbasename == level.gunship.var_d660505e3d0ba81d )
    {
        dofinfo.fstop = 8;
        dofinfo.focusdistance = 3500;
    }
    
    return dofinfo;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x7e5a
// Size: 0x269
function function_26067d6d8c85dc( player )
{
    weapon_name = self.var_e90a9a2f31633c19.weapon_name;
    var_fc48fcfbaa9c1c9a = self.var_e90a9a2f31633c19;
    level.gunship.hellfire_weapon = var_fc48fcfbaa9c1c9a.weapon_object;
    var_b91008c239cf5cd4 = getdvarint( @"hash_cca85e49b724df8b" );
    
    if ( var_b91008c239cf5cd4 )
    {
        self.var_48ca513b655d8d82 = spawn_script_origin();
        self.var_48ca513b655d8d82 dontinterpolate();
        self.laser_ent = spawn( "script_model", player.origin );
        self.laser_ent.angles = player.angles;
        self.laser_ent setmodel( "tag_laser" );
        self.laser_ent setmoverlaserweapon( "iw8_laser_painter_ac130_hellfire" );
        self.laser_ent linkto( player );
        
        if ( isdefined( self.laser_ent ) )
        {
            childthread function_762f335fd954ac86( player );
        }
    }
    
    while ( true )
    {
        player waittill( "frag_pressed" );
        
        if ( flag( "hellfire_system_busy" ) )
        {
            player playlocalsound( "use_denial" );
            wait 0.1;
        }
        else
        {
            full_trace = function_6b7ff0cd994a7fe( player );
            projectile_start = player.origin;
            impact_pos = full_trace[ "position" ];
            
            if ( var_b91008c239cf5cd4 )
            {
                missile = function_52ef54bd52ac31ce( self.var_48ca513b655d8d82, var_fc48fcfbaa9c1c9a, projectile_start, impact_pos, player );
                thread utility::display_hint( "vision_thermal", 5, undefined, missile );
                level notify( "hellfire_missile_launched", missile, self.var_48ca513b655d8d82 );
            }
            else
            {
                while ( player fragbuttonpressed() )
                {
                    result = player missilelauncherusage( impact_pos );
                    
                    if ( istrue( result ) )
                    {
                        missile = function_52ef54bd52ac31ce( player.missilelaunchertarget, var_fc48fcfbaa9c1c9a, projectile_start, impact_pos, player );
                        level notify( "hellfire_missile_launched", missile, self.var_48ca513b655d8d82 );
                        break;
                    }
                    else if ( isdefined( player.var_aa1d1fe26ddb3042 ) )
                    {
                        hideheadiconfromplayersinmask( player.var_aa1d1fe26ddb3042 );
                    }
                    
                    waitframe();
                }
                
                player function_3e954d9a9a42058a();
                player function_f7e6f0d8bd63409d();
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x80cb
// Size: 0x150
function function_762f335fd954ac86( player )
{
    self.laser_ent.laser_on = 0;
    
    while ( true )
    {
        full_trace = function_6b7ff0cd994a7fe( player );
        impact_pos = full_trace[ "position" ];
        self.var_48ca513b655d8d82.origin = impact_pos;
        function_c5d11d32f3af1ac8( impact_pos, player );
        
        if ( flag( "hellfire_missile_alive" ) && !self.laser_ent.laser_on )
        {
            if ( getdvarint( @"hash_d8d71cbe1098260e", 1 ) == 0 )
            {
                self.laser_ent laserforceon();
            }
            
            self.laser_ent.laser_on = !self.laser_ent.laser_on;
            continue;
        }
        
        if ( !flag( "hellfire_missile_alive" ) && self.laser_ent.laser_on )
        {
            if ( getdvarint( @"hash_d8d71cbe1098260e", 1 ) == 0 )
            {
                self.laser_ent laserforceoff();
            }
            
            self.laser_ent.laser_on = !self.laser_ent.laser_on;
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x8223
// Size: 0x82
function function_c5d11d32f3af1ac8( targetpos, player )
{
    targetangles = vectortoangles( targetpos - player.origin );
    invangles = invertangles( player.angles );
    angles = combineangles( invangles, targetangles );
    self.laser_ent rotatetolinked( angles, 0.05 );
    self.laser_ent waittill( "rotatedone" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x82ad
// Size: 0x6d
function function_c161dfa5d7b807ee( player )
{
    while ( !isdefined( self.camera ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        full_trace = function_6b7ff0cd994a7fe( player );
        impact_pos = full_trace[ "position" ];
        childthread function_708a140c9cdedb29( impact_pos, player, self.weapon_big );
        function_708a140c9cdedb29( impact_pos, player, self.weapon_small );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x8322
// Size: 0x7a
function function_708a140c9cdedb29( targetpos, player, weapon_ent )
{
    targetangles = vectortoangles( targetpos - self gettagorigin( "tag_gun_big" ) );
    invangles = invertangles( self gettagangles( "tag_gun_big" ) );
    angles = combineangles( invangles, targetangles );
    weapon_ent rotatetolinked( angles, 0.05 );
    weapon_ent waittill( "rotatedone" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x83a4
// Size: 0x76
function function_74ea1e4753949cee( projectile_start, impact_pos, var_fc48fcfbaa9c1c9a )
{
    flag_set( "hellfire_system_busy" );
    level.var_f4d4b089abe644c1++;
    flag_set( "hellfire_missile_alive" );
    missile = runcruisepredator( 0, projectile_start, impact_pos );
    missile.var_872e9fd8a2a204b0 = var_fc48fcfbaa9c1c9a;
    thread function_e646a7a0af99030e( missile );
    scripts\engine\sp\utility::delaychildthread( 60, &function_3195e1aab4f57134 );
    return missile;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 5
// Checksum 0x0, Offset: 0x8423
// Size: 0xd9
function function_52ef54bd52ac31ce( target, var_fc48fcfbaa9c1c9a, projectile_start, impact_pos, player )
{
    flag_set( "hellfire_system_busy" );
    level.var_f4d4b089abe644c1++;
    flag_set( "hellfire_missile_alive" );
    missile = magicbullet( var_fc48fcfbaa9c1c9a.weapon_object, projectile_start, impact_pos, player );
    missile.var_872e9fd8a2a204b0 = var_fc48fcfbaa9c1c9a;
    missile missile_settargetent( target );
    missile missileoutline();
    missile missilethermal();
    missile childthread function_bb85097ab78a5b4f( player );
    player childthread function_e646a7a0af99030e( missile );
    
    if ( soundexists( "gunship_105mm_sp_reload" ) )
    {
        player playlocalsound( "gunship_105mm_sp_reload" );
    }
    else
    {
        player playlocalsound( "ac130_105mm_mp_reload" );
    }
    
    scripts\engine\sp\utility::delaychildthread( 60, &function_3195e1aab4f57134 );
    return missile;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x8505
// Size: 0x66
function function_bb85097ab78a5b4f( player )
{
    waittill_any_8( "death", "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked", "missile_lock_ended" );
    flag_clear( "hellfire_missile_alive" );
    
    if ( isdefined( player.var_aa1d1fe26ddb3042 ) )
    {
        hideheadiconfromplayersinmask( player.var_aa1d1fe26ddb3042 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x8573
// Size: 0xe
function function_3195e1aab4f57134()
{
    utility::flag_clear( "hellfire_system_busy" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x8589
// Size: 0x359
function function_e646a7a0af99030e( projectile, position, var_d0cfeb022e718777 )
{
    level endon( "missionfailed" );
    
    if ( isdefined( projectile ) )
    {
        if ( isdefined( level.var_2825cd44d4091ad3 ) )
        {
            projectile childthread [[ level.var_2825cd44d4091ad3 ]]( projectile.var_872e9fd8a2a204b0.weapon_object );
        }
        
        projectile waittill( "explode", position );
        level.var_1250917a0280ae9 = array_removeundefined( level.var_1250917a0280ae9 );
        function_7603c1bf75f42d23( projectile, position );
    }
    
    var_d0cfeb022e718777 = utility::default_to( var_d0cfeb022e718777, 1000 );
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) == 1 )
        {
            utility::draw_circle( position, 2000, ( 0, 0, 1 ), 1, 0, 150 );
            utility::draw_circle( position, 1000, ( 1, 0, 0 ), 1, 0, 150 );
        }
    #/
    
    ai_array = getaiarrayinradius( position, var_d0cfeb022e718777, "axis", "neutral" );
    ai_array = array_removedead_or_dying( ai_array );
    
    if ( isdefined( level.var_e8e0eac736110e84 ) && ai_array.size > 0 )
    {
        if ( getdvarint( @"hash_5da9c798d17a834", 0 ) == 1 )
        {
            if ( isdefined( projectile ) )
            {
                childthread draw_circle( projectile.origin, var_d0cfeb022e718777, ( 1, 1, 1 ), 1, 1, 5 );
            }
        }
        
        foreach ( ai in ai_array )
        {
            ai thread [[ level.var_e8e0eac736110e84 ]]();
        }
    }
    
    if ( isdefined( level.var_26eff2bcd81ab5ef ) && isdefined( projectile ) )
    {
        self childthread [[ level.var_26eff2bcd81ab5ef ]]( projectile );
    }
    
    ally_guys = getaiarray( "allies" );
    
    if ( ally_guys.size > 0 )
    {
        var_79df09a6d3e7f50c = getclosest( position, ally_guys );
        thread function_4385b2a9645a3367( position, var_79df09a6d3e7f50c.origin, "gunship_105mm_expl_radio" );
    }
    
    thread function_4a15f1a5c38d4f0a( position );
    
    if ( isdefined( projectile ) )
    {
        level notify( "gunship_weapon_impact", position, projectile.var_872e9fd8a2a204b0.weapon_object.basename );
    }
    else
    {
        level notify( "gunship_weapon_impact", position, level.gunship.var_d6604f5e3d0ba5ea );
    }
    
    if ( getdvarint( @"hash_cca85e49b724df8b" ) == 1 )
    {
        guys = getaiarrayinradius( position, 1200, "axis" );
        guys = array_removedead_or_dying( guys );
        
        foreach ( guy in guys )
        {
            if ( istrue( guy.magic_bullet_shield ) )
            {
                guy scripts\common\ai::stop_magic_bullet_shield();
            }
            
            guy kill( position, self, self, "MOD_PROJECTILE_SPLASH" );
        }
        
        radiusdamagestepped( position, 1200, 900, 1600, 700, 2000, 400, level.player, undefined, level.gunship.var_d6604f5e3d0ba5ea, 0, 0 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x88ea
// Size: 0x6d
function function_4a15f1a5c38d4f0a( position )
{
    explo_distance = distance( self.origin, position ) / 12;
    var_9bdbf1831334e1b5 = 0 + explo_distance / 600;
    wait var_9bdbf1831334e1b5;
    thread play_sound_in_space( "gunship_hellfire_shockwave_explo", position );
    wait 0.2;
    earthquake( 0.11, 4, self.origin, 350 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x895f
// Size: 0xc7
function function_9d412becd6680b79( impact_pos, player )
{
    target = undefined;
    vehicles = scripts\engine\sp\utility::getvehiclearray_in_radius( impact_pos, 2000, "axis" );
    vehicles = array_removedead_or_dying( vehicles );
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        vehicles = sortbydistance( vehicles, impact_pos );
        target = vehicles[ 0 ];
    }
    else
    {
        guys = getaiarrayinradius( impact_pos, 2000, "axis" );
        guys = array_removedead_or_dying( guys );
        
        if ( isdefined( guys ) && guys.size > 0 )
        {
            guys = sortbydistance( guys, impact_pos );
            target = guys[ 0 ];
        }
    }
    
    if ( isdefined( target ) )
    {
        var_b7c51f037012048d = player worldpointtoscreenpos( target.origin, 3 );
        
        if ( isdefined( var_b7c51f037012048d ) )
        {
            return target;
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x8a2e
// Size: 0x119
function function_3e5ea3db86d046fe( impact_pos, player )
{
    targets = undefined;
    vehicles = scripts\engine\sp\utility::getvehiclearray_in_radius( impact_pos, 2000, "axis" );
    vehicles = array_removedead_or_dying( vehicles );
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        foreach ( vehicle in vehicles )
        {
            if ( !isdefined( vehicle.riders ) || vehicle.riders.size <= 0 )
            {
                vehicles = array_remove( vehicles, vehicle );
            }
        }
        
        targets = vehicles;
    }
    
    if ( !isdefined( vehicles ) || vehicles.size <= 0 )
    {
        guys = getaiarrayinradius( impact_pos, 2000, "axis" );
        guys = array_removedead_or_dying( guys );
        
        if ( isdefined( guys ) && guys.size > 0 )
        {
            targets = guys;
        }
    }
    
    if ( isdefined( targets ) && targets.size > 0 )
    {
        targets = sortbydistance( targets, impact_pos );
    }
    
    return targets;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x8b50
// Size: 0x120
function function_a8d38309fd6157f9()
{
    function_f7e6f0d8bd63409d();
    self.var_ecdb884ad1740a40 = spawn( "script_model", self.origin );
    self.var_ecdb884ad1740a40 dontinterpolate();
    self.var_ecdb884ad1740a40 setmodel( "tag_origin" );
    self.var_aa1d1fe26ddb3042 = createheadicon( self.var_ecdb884ad1740a40 );
    setheadiconimage( self.var_aa1d1fe26ddb3042, "hud_icon_target_player" );
    addclienttoheadiconmask( self.var_aa1d1fe26ddb3042, self );
    function_6ddec503234ca6ff( self.var_aa1d1fe26ddb3042, "hud_icon_target_player" );
    setheadiconowner( self.var_aa1d1fe26ddb3042, self );
    setheadicondrawthroughgeo( self.var_aa1d1fe26ddb3042, 1 );
    setheadiconmaxdistance( self.var_aa1d1fe26ddb3042, 32000 );
    setheadiconnaturaldistance( self.var_aa1d1fe26ddb3042, 1000 );
    setheadiconsnaptoedges( self.var_aa1d1fe26ddb3042, 0 );
    setheadiconzoffset( self.var_aa1d1fe26ddb3042, 15 );
    hideheadiconfromplayersinmask( self.var_aa1d1fe26ddb3042 );
    self.targetmarkergroupid = createtargetmarkergroup( "lockontarget" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x8c78
// Size: 0x33
function function_6ddec503234ca6ff( icon_index, icon_name )
{
    setheadiconimage( icon_index, icon_name );
    setheadiconenemyimage( icon_index, icon_name );
    setheadiconfriendlyimage( icon_index, icon_name );
    setheadiconneutralimage( icon_index, icon_name );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x8cb3
// Size: 0x76
function function_3e954d9a9a42058a()
{
    if ( !isdefined( self.missilelauncheruseentered ) )
    {
        return;
    }
    
    self.missilelauncheruseentered = undefined;
    self notify( "stop_javelin_locking_feedback" );
    self notify( "stop_javelin_locked_feedback" );
    self notify( "missileLauncher_lock_lost" );
    self weaponlockfree();
    self stoplocalsound( "maaws_reticle_tracking" );
    self stoplocalsound( "maaws_reticle_locked" );
    
    if ( isdefined( self.missilelaunchertarget ) )
    {
        function_53199b21e1cf656b( self.missilelaunchertarget, self );
    }
    
    function_f7e6f0d8bd63409d();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x8d31
// Size: 0x34
function function_f7e6f0d8bd63409d()
{
    self.missilelauncherstage = undefined;
    self.missilelaunchertarget = undefined;
    self.missilelauncherlockstarttime = undefined;
    self.missilelauncherlostsightlinetime = undefined;
    self.var_eb8c81f358764661 = 0;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x8d6d
// Size: 0xb6
function function_53199b21e1cf656b( entity, attacker )
{
    if ( !isdefined( entity.islockedon ) )
    {
        return;
    }
    
    assert( function_6027b6de10011eee( entity ), "removeLockedOn called on an entity that is not locked onto." );
    
    if ( entity.islockedon == 1 )
    {
        if ( isdefined( entity.lockedonremovedcallback ) )
        {
            entity thread [[ entity.lockedonremovedcallback ]]();
        }
    }
    
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.entlockedonto ) && attacker.entlockedonto == entity )
        {
            attacker.entlockedonto = undefined;
        }
        
        entity.attackerslockedon[ attacker getentitynumber() ] = undefined;
    }
    
    entity.islockedon--;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x8e2b
// Size: 0x28, Type: bool
function function_6027b6de10011eee( entity )
{
    return isdefined( entity.islockedon ) && entity.islockedon > 0;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x8e5c
// Size: 0x43a
function missilelauncherusage( impact_pos )
{
    var_db87e220986304f4 = 625000000;
    var_e688b198aa9a4b3f = 0;
    self.missilelauncheruseentered = 1;
    
    if ( !isdefined( self.missilelauncherstage ) )
    {
        self.missilelauncherstage = 0;
    }
    
    if ( self.missilelauncherstage == 0 )
    {
        targets = function_3e5ea3db86d046fe( impact_pos, self );
        
        if ( !isdefined( targets ) || targets.size <= 0 )
        {
            if ( !self.var_eb8c81f358764661 )
            {
                self playlocalsound( "use_denial" );
                self.var_eb8c81f358764661 = 1;
            }
            
            return;
        }
        
        stingtargstruct = undefined;
        var_c7f50dd357b9cdcf = 0;
        
        foreach ( target in targets )
        {
            if ( !isdefined( target ) )
            {
                continue;
            }
            
            stingtargstruct = stingtargstruct_create( self, target );
            stingtargstruct stingtargstruct_getoffsets();
            stingtargstruct stingtargstruct_getorigins();
            stingtargstruct stingtargstruct_getinreticle();
            
            if ( stingtargstruct stingtargstruct_isinreticle() )
            {
                if ( distancesquared( target.origin, self.origin ) > var_db87e220986304f4 )
                {
                    break;
                }
                
                var_c7f50dd357b9cdcf = 1;
                break;
            }
        }
        
        if ( !var_c7f50dd357b9cdcf )
        {
            return;
        }
        
        stingtargstruct stingtargstruct_getinlos();
        
        if ( !stingtargstruct stingtargstruct_isinlos() )
        {
            return;
        }
        
        self.missilelaunchertarget = stingtargstruct.target;
        self.missilelauncherlockstarttime = gettime();
        self.missilelauncherstage = 1;
        self.missilelauncherlostsightlinetime = 0;
        
        if ( isdefined( self.missilelaunchertarget ) )
        {
            function_9bc63c81c00e88ec( self.missilelaunchertarget, self );
            team = "axis";
            
            if ( isdefined( self.missilelaunchertarget.team ) )
            {
                team = self.missilelaunchertarget.team;
            }
            
            addteamtotargetmarkergroupmask( self.targetmarkergroupid, team );
            targetmarkergroupaddentity( self.targetmarkergroupid, self.missilelaunchertarget );
            showtargetmarkergrouptoplayersinmask( self.targetmarkergroupid );
            function_6ddec503234ca6ff( self.var_aa1d1fe26ddb3042, "hud_icon_target_player" );
        }
        
        thread loopmissilelauncherlockingfeedback();
    }
    
    if ( self.missilelauncherstage == 1 )
    {
        if ( !isdefined( self.missilelaunchertarget ) )
        {
            function_3e954d9a9a42058a();
            return;
        }
        
        if ( !var_e688b198aa9a4b3f && is_equal( self.missilelaunchertarget.team, self.team ) )
        {
            function_3e954d9a9a42058a();
            return;
        }
        
        stingtargstruct = stingtargstruct_create( self, self.missilelaunchertarget );
        stingtargstruct stingtargstruct_getoffsets();
        stingtargstruct stingtargstruct_getorigins();
        stingtargstruct stingtargstruct_getinreticle();
        
        if ( !stingtargstruct stingtargstruct_isinreticle() )
        {
            function_3e954d9a9a42058a();
            return;
        }
        
        stingtargstruct stingtargstruct_getinlos();
        
        if ( !gunship_softsighttest( stingtargstruct ) )
        {
            return;
        }
        
        timepassed = gettime() - self.missilelauncherlockstarttime;
        
        if ( timepassed < 1500 )
        {
            return;
        }
        
        self notify( "stop_javelin_locking_feedback" );
        thread loopmissilelauncherlockedfeedback();
        offset = undefined;
        missilelauncher_finalizelock( stingtargstruct );
        self.missilelauncherstage = 2;
    }
    
    if ( self.missilelauncherstage == 2 )
    {
        if ( !isdefined( self.missilelaunchertarget ) )
        {
            function_3e954d9a9a42058a();
            return;
        }
        
        if ( !var_e688b198aa9a4b3f && is_equal( self.missilelaunchertarget.team, self.team ) )
        {
            function_3e954d9a9a42058a();
            return;
        }
        
        stingtargstruct = stingtargstruct_create( self, self.missilelaunchertarget );
        stingtargstruct stingtargstruct_getoffsets();
        stingtargstruct stingtargstruct_getorigins();
        stingtargstruct stingtargstruct_getinreticle();
        stingtargstruct stingtargstruct_getinlos();
        
        if ( !gunship_softsighttest( stingtargstruct ) )
        {
            return;
        }
        else
        {
            missilelauncher_finalizelock( stingtargstruct );
            function_6ddec503234ca6ff( self.var_aa1d1fe26ddb3042, "cp_drone_reticle_square_glow" );
            showheadicontoplayersinmask( self.var_aa1d1fe26ddb3042 );
            return 1;
        }
        
        if ( !stingtargstruct stingtargstruct_isinreticle() )
        {
            function_3e954d9a9a42058a();
            return;
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x929e
// Size: 0x8b
function stingtargstruct_create( player, target )
{
    struct = spawnstruct();
    struct.player = player;
    struct.target = target;
    struct.offsets = [];
    struct.origins = [];
    struct.inreticledistssqr = [];
    struct.inreticlesortedids = [];
    struct.inlosid = undefined;
    struct.useoldlosverification = 1;
    return struct;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x9332
// Size: 0x400
function stingtargstruct_getoffsets()
{
    self.offsets = [];
    
    if ( isdefined( self.target.vehiclename ) && self.target.vehiclename == "light_tank" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 72 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && self.target.vehiclename == "apc_russian" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 60 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && ( self.target.vehiclename == "cargo_truck" || self.target.vehiclename == "cargo_truck_mg" ) )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 60 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && self.target.vehiclename == "large_transport" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 65 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && self.target.vehiclename == "medium_transport" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 60 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && ( self.target.vehiclename == "pickup_truck" || self.target.vehiclename == "technical" ) )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 55 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && self.target.vehiclename == "atv" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 30 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && ( self.target.vehiclename == "jeep" || self.target.vehiclename == "tac_rover" ) )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 50 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( isdefined( self.target.vehiclename ) && self.target.vehiclename == "loot_chopper" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, -100 );
        self.useoldlosverification = 0;
        return;
    }
    
    self.offsets[ self.offsets.size ] = ( 0, 0, 0 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x973a
// Size: 0xca
function stingtargstruct_getorigins()
{
    origin = self.target.origin;
    angles = self.target.angles;
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    up = anglestoup( angles );
    
    for ( i = 0; i < self.offsets.size ; i++ )
    {
        offset = self.offsets[ i ];
        self.origins[ i ] = origin + right * offset[ 0 ] + forward * offset[ 1 ] + up * offset[ 2 ];
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x980c
// Size: 0x1af
function stingtargstruct_getinreticle()
{
    foreach ( origin in self.origins )
    {
        for ( i = 0; i < self.origins.size ; i++ )
        {
            screenpos = self.player worldpointtoscreenpos( self.origins[ i ], 65 );
            
            if ( isdefined( screenpos ) )
            {
                distsqr = length2dsquared( screenpos );
                
                if ( distsqr <= 900 )
                {
                    self.inreticlesortedids[ self.inreticlesortedids.size ] = i;
                    self.inreticledistssqr[ i ] = distsqr;
                }
            }
        }
    }
    
    if ( self.inreticlesortedids.size > 1 )
    {
        for ( i = 0; i < self.inreticlesortedids.size ; i++ )
        {
            for ( j = i + 1; j < self.inreticlesortedids.size ; j++ )
            {
                i_id = self.inreticlesortedids[ i ];
                j_id = self.inreticlesortedids[ j ];
                var_8eba9ec305d4a611 = self.inreticledistssqr[ i_id ];
                var_cf5f902786383f74 = self.inreticledistssqr[ j_id ];
                
                if ( var_cf5f902786383f74 < var_8eba9ec305d4a611 )
                {
                    tempid = i_id;
                    self.inreticlesortedids[ i ] = j_id;
                    self.inreticlesortedids[ j ] = tempid;
                }
            }
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x99c3
// Size: 0xe, Type: bool
function stingtargstruct_isinreticle()
{
    return self.inreticlesortedids.size > 0;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x99da
// Size: 0x3de
function stingtargstruct_getinlos()
{
    caststart = self.player getvieworigin();
    contents = physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item", "physicscontents_playernosight" ] );
    ignorearr = [ self.player, self.target ];
    var_d4a24e02d124ac38 = self.target getlinkedchildren();
    
    if ( isdefined( var_d4a24e02d124ac38 ) && var_d4a24e02d124ac38.size > 0 )
    {
        ignorearr = array_combine( ignorearr, var_d4a24e02d124ac38 );
    }
    
    if ( !self.useoldlosverification )
    {
        for ( i = 0; i < self.inreticlesortedids.size ; i++ )
        {
            id = self.inreticlesortedids[ i ];
            castend = self.origins[ id ];
            castresults = physics_raycast( caststart, castend, contents, ignorearr, 0, "physicsquery_closest", 1 );
            
            if ( !isdefined( castresults ) || castresults.size == 0 )
            {
                self.inlosid = id;
                return;
            }
        }
        
        return;
    }
    
    top = self.target getpointinbounds( 0, 0, 1 );
    trace = ray_trace( caststart, top, ignorearr, contents, 0 );
    
    /#
        if ( getdvar( @"missiledebugdraw" ) == "<dev string:xf2>" )
        {
            playerangles = self.player getplayerangles();
            forward = anglestoforward( playerangles );
            left = anglestoleft( playerangles );
            hitpos = trace[ "<dev string:xdd>" ];
            sphere( hitpos, 10, ( 1, 0, 0 ), 0, 1 );
            sphere( hitpos, 10, ( 0, 1, 0 ), 1, 1 );
            disttohit = distance( caststart, hitpos );
            print3d( hitpos + left * -20, "<dev string:xf4>" + disttohit, ( 1, 1, 1 ), 1, 1, 1 );
            wingbasepos = self.player.origin;
            var_633eaa5f21008b6f = wingbasepos + left * 50;
            line( var_633eaa5f21008b6f, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
            var_3eacd3938ccd4b6c = wingbasepos + left * -50;
            line( var_3eacd3938ccd4b6c, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
            var_633eaa5f21008b6f += ( 0, 0, 100 );
            line( var_633eaa5f21008b6f, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
            var_3eacd3938ccd4b6c += ( 0, 0, 100 );
            line( var_3eacd3938ccd4b6c, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
        }
    #/
    
    if ( trace[ "fraction" ] == 1 )
    {
        self.inlosid = 0;
        return;
    }
    
    front = self.target getpointinbounds( 1, 0, 0 );
    trace = ray_trace( caststart, front, ignorearr, contents, 0 );
    
    if ( trace[ "fraction" ] == 1 )
    {
        self.inlosid = 0;
        return;
    }
    
    back = self.target getpointinbounds( -1, 0, 0 );
    trace = ray_trace( caststart, back, ignorearr, contents, 0 );
    
    if ( trace[ "fraction" ] == 1 )
    {
        self.inlosid = 0;
        return;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x9dc0
// Size: 0xc, Type: bool
function stingtargstruct_isinlos()
{
    return isdefined( self.inlosid );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x9dd5
// Size: 0xda
function function_9bc63c81c00e88ec( entity, attacker )
{
    if ( !isdefined( entity.islockedon ) )
    {
        entity.islockedon = 0;
        entity.attackerslockedon = [];
    }
    
    if ( entity.islockedon == 0 )
    {
        if ( isdefined( entity.lockedoncallback ) )
        {
            entity thread [[ entity.lockedoncallback ]]();
        }
    }
    
    if ( isdefined( attacker ) )
    {
        assertex( !isdefined( attacker.entlockedonto ), "addLockedOn called on an attacker that is already locked on to another entity." );
        attacker.entlockedonto = entity;
        assertex( !isdefined( entity.attackerslockedon[ attacker getentitynumber() ] ), "addLockedOn called on an attacker that is already locked on to THIS entity." );
        entity.attackerslockedon[ attacker getentitynumber() ] = attacker;
    }
    
    entity.islockedon++;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x9eb7
// Size: 0x130
function loopmissilelauncherlockingfeedback()
{
    self endon( "death_or_disconnect" );
    self endon( "stop_javelin_locking_feedback" );
    self.var_ecdb884ad1740a40.origin = self.missilelaunchertarget.origin;
    self.var_ecdb884ad1740a40 linkto( self.missilelaunchertarget );
    childthread function_bea49fb639a2f08c();
    
    for ( ;; )
    {
        if ( isdefined( level.chopper ) && isdefined( level.chopper.gunner ) && isdefined( self.missilelaunchertarget ) && self.missilelaunchertarget == level.chopper.gunner )
        {
            level.gunshipplayer playsound( "maaws_incoming_lp" );
        }
        
        if ( isdefined( level.gunshipplayer ) && isdefined( self.missilelaunchertarget ) && self.missilelaunchertarget == level.gunship.planemodel )
        {
            level.gunshipplayer playsound( "maaws_incoming_lp" );
        }
        
        self playlocalsound( "maaws_reticle_tracking" );
        self playrumbleonentity( "ac130_25mm_fire" );
        wait 0.6;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x9fef
// Size: 0x34
function function_bea49fb639a2f08c()
{
    while ( true )
    {
        showheadicontoplayersinmask( self.var_aa1d1fe26ddb3042 );
        wait 0.5;
        hideheadiconfromplayersinmask( self.var_aa1d1fe26ddb3042 );
        wait 0.1;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa02b
// Size: 0x77, Type: bool
function gunship_softsighttest( stingtargstruct )
{
    lost_sight_limit = 500;
    
    if ( stingtargstruct stingtargstruct_isinlos() )
    {
        self.missilelauncherlostsightlinetime = 0;
        return true;
    }
    
    if ( self.missilelauncherlostsightlinetime == 0 )
    {
        self.missilelauncherlostsightlinetime = gettime();
    }
    
    timepassed = gettime() - self.missilelauncherlostsightlinetime;
    
    if ( timepassed >= lost_sight_limit )
    {
        function_3e954d9a9a42058a();
        return false;
    }
    
    return true;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xa0ab
// Size: 0xe9
function loopmissilelauncherlockedfeedback()
{
    self endon( "death_or_disconnect" );
    self endon( "stop_javelin_locked_feedback" );
    self playlocalsound( "maaws_reticle_locked" );
    
    for ( ;; )
    {
        if ( isdefined( level.chopper ) && isdefined( level.chopper.gunner ) && isdefined( self.missilelaunchertarget ) && self.missilelaunchertarget == level.chopper.gunner )
        {
            level.gunshipplayer playlocalsound( "maaws_incoming_lp" );
        }
        
        if ( isdefined( level.gunshipplayer ) && isdefined( self.missilelaunchertarget ) && self.missilelaunchertarget == level.gunship.planemodel )
        {
            level.gunshipplayer playlocalsound( "maaws_incoming_lp" );
        }
        
        self playrumbleonentity( "ac130_25mm_fire" );
        wait 0.25;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa19c
// Size: 0xcd
function missilelauncher_finalizelock( stingtargstruct )
{
    offset = undefined;
    
    if ( isdefined( stingtargstruct.target ) && isdefined( stingtargstruct.target.vehiclename ) && stingtargstruct.target.vehiclename == "light_tank" )
    {
        offset = ( 0, 0, 75 );
    }
    else if ( isdefined( stingtargstruct.inlosid ) )
    {
        offset = stingtargstruct.offsets[ stingtargstruct.inlosid ];
        offset = ( offset[ 1 ], -1 * offset[ 0 ], offset[ 2 ] );
    }
    else
    {
        offset = ( 0, 0, 0 );
    }
    
    self weaponlockfinalize( self.missilelaunchertarget, offset );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa271
// Size: 0x87
function gunship_watchweaponfired( gunner )
{
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", 30 );
    gunner setclientomnvar( "ui_killstreak_weapon_2_ammo", 10 );
    gunner setclientomnvar( "ui_killstreak_weapon_1_ammo", 1 );
    level.var_f4d4b089abe644c1 = 0;
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 0 )
    {
        function_8a3de080d0a85357( gunner );
        return;
    }
    
    function_e77db3847fe7a928( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa300
// Size: 0x29f
function function_8a3de080d0a85357( gunner )
{
    level.gunship.last_fired = 0;
    function_8e74c11aa6d09415();
    self.var_9acfd96babd08e79 = -6000;
    self.var_eb994a929b4e42db = -400;
    self.var_eba1d1929b57576e = -60;
    self.var_c56c107cfa9ba64 = -15000;
    
    if ( getdvarint( @"hash_cca85e49b724df8b" ) )
    {
        self.var_48ca513b655d8d82 = spawn_script_origin();
        self.var_48ca513b655d8d82 dontinterpolate();
        self.laser_ent = spawn( "script_model", gunner.origin );
        self.laser_ent.angles = gunner.angles;
        self.laser_ent setmodel( "tag_laser" );
        self.laser_ent setmoverlaserweapon( "iw8_laser_painter_ac130_hellfire" );
        self.laser_ent linkto( gunner );
        
        if ( isdefined( self.laser_ent ) )
        {
            childthread function_762f335fd954ac86( gunner );
        }
    }
    
    gunner.weapon_reloading = 0;
    self.var_8e3a3e9ee646b4fd[ level.gunship.var_d6604e5e3d0ba3b7 ] = level.weaponreloadtime[ level.gunship.var_d6604e5e3d0ba3b7 ];
    self.var_8e3a3e9ee646b4fd[ level.gunship.var_d6604d5e3d0ba184 ] = level.weaponreloadtime[ level.gunship.var_d6604d5e3d0ba184 ];
    self.var_8e3a3e9ee646b4fd[ level.gunship.var_d660505e3d0ba81d ] = level.weaponreloadtime[ level.gunship.var_d660505e3d0ba81d ];
    self.var_8e3a3e9ee646b4fd[ level.gunship.var_d6604f5e3d0ba5ea ] = level.weaponreloadtime[ level.gunship.var_d6604f5e3d0ba5ea ];
    self.var_5dd2bd1c457222e4[ level.gunship.var_d6604e5e3d0ba3b7 ] = -10000;
    self.var_5dd2bd1c457222e4[ level.gunship.var_d6604d5e3d0ba184 ] = -10000;
    self.var_5dd2bd1c457222e4[ level.gunship.var_d660505e3d0ba81d ] = -10000;
    self.var_5dd2bd1c457222e4[ level.gunship.var_d6604f5e3d0ba5ea ] = -10000;
    childthread function_9725db675db06c76( gunner );
    childthread function_107efa77e29c6982( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa5a7
// Size: 0x157
function function_107efa77e29c6982( gunner )
{
    for ( ;; )
    {
        gunner function_6479fdbe7cc682a2();
        
        if ( flag( "pauseCameraFocus" ) )
        {
        }
        else
        {
            waitframe();
            weapon_array = function_a79b46a6d3d7def();
            current_weapon_name = weapon_array[ self.currentweaponindex ];
            
            if ( current_weapon_name == level.gunship.var_d660505e3d0ba81d )
            {
            }
            else if ( !function_68083c19f479777f( current_weapon_name ) && !function_c212a027758ef4cb( current_weapon_name ) )
            {
                projectile = function_62b4daf15be3076a( gunner, current_weapon_name );
                
                if ( isdefined( projectile ) )
                {
                    level.gunship.var_5dd2bd1c457222e4[ current_weapon_name ] = -10000;
                    level.gunship.last_fired = gettime();
                    function_e532fa04b8270904( current_weapon_name, gunner, projectile.var_872e9fd8a2a204b0 );
                    gunner notify( "missile_fire", projectile, projectile.var_872e9fd8a2a204b0.weapon_object );
                    gunner notify( "gunship_fired", current_weapon_name );
                    
                    if ( projectile.var_872e9fd8a2a204b0.currentammo <= 0 )
                    {
                        gunner thread gunship_weaponreload( projectile.var_872e9fd8a2a204b0, self );
                    }
                    
                    if ( current_weapon_name != level.gunship.var_d6604f5e3d0ba5ea )
                    {
                        gunner childthread gunship_watchweaponimpact( projectile );
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa706
// Size: 0xee
function function_9725db675db06c76( gunner )
{
    childthread function_fe1296fe813dc527( gunner );
    
    for ( ;; )
    {
        gunner allowfire( 0 );
        gunner function_6479fdbe7cc682a2();
        
        if ( flag( "pauseCameraFocus" ) )
        {
        }
        else
        {
            weapon_array = function_a79b46a6d3d7def();
            current_weapon_name = weapon_array[ self.currentweaponindex ];
            
            if ( getdvarint( @"hash_ef7a4f0ffc468e7b" ) == 1 )
            {
                if ( current_weapon_name == level.gunship.var_d660505e3d0ba81d )
                {
                    weapon = gunner getcurrentweapon();
                    currentammo = gunner getweaponammoclip( weapon );
                    
                    if ( currentammo <= 1 )
                    {
                        if ( !istrue( gunner.weapon_reloading ) )
                        {
                            gunner thread function_6c7ef99bf5ba717f( weapon, self );
                        }
                        
                        goto LOC_000000e9;
                    }
                    else
                    {
                        self.var_5dd2bd1c457222e4[ current_weapon_name ] = -10000;
                        gunner allowfire( 1 );
                    LOC_000000e9:
                    }
                LOC_000000e9:
                }
            LOC_000000e9:
            }
        LOC_000000e9:
        }
        
    LOC_000000e9:
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xa7fc
// Size: 0x1a
function function_6479fdbe7cc682a2()
{
    while ( !self attackbuttonpressed() && !self attackkeybindpressed() )
    {
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa81e
// Size: 0xfd
function function_fe1296fe813dc527( gunner )
{
    while ( true )
    {
        gunner waittill( "missile_fire", projectile, weapon );
        
        if ( weapon.basename != level.gunship.var_d660505e3d0ba81d || !isdefined( projectile ) || istrue( projectile.gsc_spawned ) )
        {
            continue;
        }
        
        rockets = getentarrayinradius( "rocket", "code_classname", projectile.origin, 10 );
        
        foreach ( rocket in rockets )
        {
            if ( isdefined( rocket ) )
            {
                if ( istrue( rocket.gsc_spawned ) )
                {
                    continue;
                }
                
                rocket delete();
            }
        }
        
        thread function_ed197229b9526e7c( gunner );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa923
// Size: 0x56
function function_4741592aabb99bde( gunner )
{
    gunner endon( "end_firing" );
    gunner endon( "attack_released" );
    gunner endon( "attack_pressed" );
    gunner endon( "weapon_switch_pressed" );
    level endon( "gunshipWeaponReloading" );
    
    while ( true )
    {
        gunner waittill_any_3( "begin_firing", "missile_fire", "weapon_fired" );
        thread function_ed197229b9526e7c( gunner );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xa981
// Size: 0x111
function function_ed197229b9526e7c( gunner )
{
    projectile = function_62b4daf15be3076a( gunner, level.gunship.var_d660505e3d0ba81d );
    gunner notify( "gunship_fired", self.var_fff9e9244cd692a3.weapon_object.basename );
    gunner thread gunship_watchweaponimpact( projectile );
    projectile.var_872e9fd8a2a204b0 = self.var_fff9e9244cd692a3;
    projectile.weapon_obj = self.var_fff9e9244cd692a3.weapon_object;
    current_weapon = gunner getcurrentweapon();
    currentammo = gunner getweaponammoclip( current_weapon );
    gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", currentammo );
    level.gunship.last_fired = gettime();
    self.var_eba1d1929b57576e = gettime();
    
    if ( getdvarint( @"hash_6e0c4af8a30676b6", 1 ) == 1 )
    {
        function_9c3a0606da40389d( self.var_fff9e9244cd692a3, gunner );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xaa9a
// Size: 0x113
function function_8e74c11aa6d09415()
{
    weapon = makeweapon( level.gunship.var_d660505e3d0ba81d );
    self.var_fff9e9244cd692a3 = function_8d01239b5d6b7cae( level.gunship.var_d660505e3d0ba81d, weapon );
    weapon = makeweapon( level.gunship.var_d6604d5e3d0ba184 );
    self.var_fff100244ccca68a = function_8d01239b5d6b7cae( level.gunship.var_d6604d5e3d0ba184, weapon );
    
    if ( getdvarint( @"hash_80478c6f0f12492a" ) )
    {
        weapon = makeweapon( level.gunship.var_d6604e5e3d0ba3b7 );
        self.var_f4364bd51b414686 = function_8d01239b5d6b7cae( level.gunship.var_d6604e5e3d0ba3b7, weapon );
        return;
    }
    
    weapon = makeweapon( level.gunship.var_d6604f5e3d0ba5ea );
    self.var_e90a9a2f31633c19 = function_8d01239b5d6b7cae( level.gunship.var_d6604e5e3d0ba3b7, weapon );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xabb5
// Size: 0xee
function function_878e144349832994( gunner )
{
    if ( flag( "igc_start" ) )
    {
        return gunner getcurrentweapon().basename;
    }
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 0 )
    {
        weapon_array[ 1 ] = level.gunship.var_d660505e3d0ba81d;
        weapon_array[ 2 ] = level.gunship.var_d6604d5e3d0ba184;
        
        if ( getdvarint( @"hash_80478c6f0f12492a" ) )
        {
            weapon_array[ 3 ] = level.gunship.var_d6604e5e3d0ba3b7;
        }
        else
        {
            weapon_array[ 3 ] = level.gunship.var_d6604f5e3d0ba5ea;
        }
        
        return weapon_array[ level.gunship.model_ent.currentweaponindex ];
    }
    
    return gunner getcurrentweapon().basename;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xacab
// Size: 0x6ca
function function_8d01239b5d6b7cae( weapon_name, weapon_object )
{
    var_872e9fd8a2a204b0 = spawnstruct();
    var_872e9fd8a2a204b0.weapon_object = weapon_object;
    var_872e9fd8a2a204b0.weapon_name = weapon_name;
    var_872e9fd8a2a204b0.is_reloading = 0;
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 0 )
    {
        if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 )
        {
            var_872e9fd8a2a204b0.fire_sound = "weap_gunship_hellfire_fire_plr";
            var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
            var_872e9fd8a2a204b0.currentammo = 1;
            var_872e9fd8a2a204b0.lowammo = 0.5;
            var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
            var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
            var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
            var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
            var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
            var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
            var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
        }
        else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
        {
            var_872e9fd8a2a204b0.fire_sound = "weap_gunship_40mm_fire_plr";
            var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_2_ammo";
            var_872e9fd8a2a204b0.currentammo = 10;
            var_872e9fd8a2a204b0.lowammo = 5;
            var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.2;
            var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 1;
            var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.17;
            var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.9;
            var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.12;
            var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
            var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
        }
        else if ( weapon_name == level.gunship.var_d660505e3d0ba81d )
        {
            var_872e9fd8a2a204b0.fire_sound = "weap_gunship_25mm_fire_plr";
            var_872e9fd8a2a204b0.var_9d9213e85cfe091f = "weap_gunship_25mm_atmo_plr";
            var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_3_ammo";
            var_872e9fd8a2a204b0.currentammo = 30;
            var_872e9fd8a2a204b0.lowammo = 15;
            var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.1;
            var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 0.9;
            var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.09;
            var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.8;
            var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.07;
            var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
            var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
        }
        else if ( weapon_name == level.gunship.var_d6604f5e3d0ba5ea )
        {
            var_872e9fd8a2a204b0.fire_sound = "weap_gunship_hellfire_fire_plr";
            var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
            var_872e9fd8a2a204b0.currentammo = 1;
            var_872e9fd8a2a204b0.lowammo = 0.5;
            var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
            var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
            var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
            var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
            var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
            var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
            var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
            var_872e9fd8a2a204b0.var_55ba759bc54f065 = self.weapon_big.var_55ba759bc54f065;
        }
    }
    else if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
        var_872e9fd8a2a204b0.currentammo = 1;
        var_872e9fd8a2a204b0.lowammo = 0.5;
        var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
        var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
        var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
        var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
        var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
        var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
        var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
        var_872e9fd8a2a204b0.var_c93051491f15e796 = 1;
    }
    else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
    {
        var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_2_ammo";
        var_872e9fd8a2a204b0.currentammo = 10;
        var_872e9fd8a2a204b0.lowammo = 5;
        var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.2;
        var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 1;
        var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.17;
        var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.9;
        var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.12;
        var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
        var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
    }
    else if ( weapon_name == level.gunship.var_d660505e3d0ba81d )
    {
        var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_3_ammo";
        var_872e9fd8a2a204b0.currentammo = 30;
        var_872e9fd8a2a204b0.lowammo = 15;
        var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.1;
        var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 0.9;
        var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.09;
        var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.8;
        var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.07;
        var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
        var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
    }
    else if ( weapon_name == level.gunship.var_d6604f5e3d0ba5ea )
    {
        var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
        var_872e9fd8a2a204b0.currentammo = 1;
        var_872e9fd8a2a204b0.lowammo = 0.5;
        var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
        var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
        var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
        var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
        var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
        var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
        var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
        var_872e9fd8a2a204b0.var_55ba759bc54f065 = self.weapon_big.var_55ba759bc54f065;
    }
    
    return var_872e9fd8a2a204b0;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xb37e
// Size: 0xd5
function function_e592b315177a68ac( weapon_name )
{
    weapon_object = undefined;
    
    if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        weapon_object = self.var_f4364bd51b414686.weapon_object;
    }
    else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
    {
        weapon_object = self.var_fff100244ccca68a.weapon_object;
    }
    else if ( weapon_name == level.gunship.var_d660505e3d0ba81d )
    {
        weapon_object = self.var_fff9e9244cd692a3.weapon_object;
    }
    else if ( weapon_name == level.gunship.var_d6604f5e3d0ba5ea )
    {
        weapon_object = self.var_e90a9a2f31633c19.weapon_object;
    }
    
    return weapon_object;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xb45c
// Size: 0xad
function function_f45ebfa891515d9b( weapon_name )
{
    var_872e9fd8a2a204b0 = undefined;
    
    if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        var_872e9fd8a2a204b0 = self.var_f4364bd51b414686;
    }
    else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
    {
        var_872e9fd8a2a204b0 = self.var_fff100244ccca68a;
    }
    else if ( weapon_name == level.gunship.var_d660505e3d0ba81d )
    {
        var_872e9fd8a2a204b0 = self.var_fff9e9244cd692a3;
    }
    else if ( weapon_name == level.gunship.var_d6604f5e3d0ba5ea )
    {
        var_872e9fd8a2a204b0 = self.var_e90a9a2f31633c19;
    }
    
    return var_872e9fd8a2a204b0;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xb512
// Size: 0x31, Type: bool
function function_68083c19f479777f( weapon_name )
{
    var_872e9fd8a2a204b0 = function_f45ebfa891515d9b( weapon_name );
    
    if ( var_872e9fd8a2a204b0.currentammo <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xb54c
// Size: 0xe1, Type: bool
function function_c212a027758ef4cb( weapon_name )
{
    /#
        if ( getdvarint( @"player_sustainammo" ) == 1 && weapon_name == level.gunship.var_d6604f5e3d0ba5ea )
        {
            return false;
        }
    #/
    
    time_table[ level.gunship.var_d6604e5e3d0ba3b7 ] = self.var_9acfd96babd08e79 + 6000;
    time_table[ level.gunship.var_d6604d5e3d0ba184 ] = self.var_eb994a929b4e42db + 400;
    time_table[ level.gunship.var_d660505e3d0ba81d ] = self.var_eba1d1929b57576e + 60;
    time_table[ level.gunship.var_d6604f5e3d0ba5ea ] = self.var_c56c107cfa9ba64 + 15000;
    
    if ( gettime() < time_table[ weapon_name ] )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0xb636
// Size: 0x180
function function_e532fa04b8270904( weapon_name, gunner, var_872e9fd8a2a204b0 )
{
    gunner playrumbleonentity( "heavygun_fire" );
    
    if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        self.var_9acfd96babd08e79 = gettime();
    }
    else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
    {
        self.var_eb994a929b4e42db = gettime();
    }
    else if ( weapon_name == level.gunship.var_d660505e3d0ba81d )
    {
        self.var_eba1d1929b57576e = gettime();
    }
    else if ( weapon_name == level.gunship.var_d6604f5e3d0ba5ea )
    {
        self.var_c56c107cfa9ba64 = gettime();
    }
    
    if ( var_872e9fd8a2a204b0.currentammo >= 0 )
    {
        ammo = var_872e9fd8a2a204b0.currentammo;
    }
    else
    {
        ammo = 0;
    }
    
    gunner setclientomnvar( var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b, ammo );
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 0 )
    {
        gunner playlocalsound( var_872e9fd8a2a204b0.fire_sound );
    }
    
    if ( isdefined( var_872e9fd8a2a204b0.var_9d9213e85cfe091f ) && getdvarint( @"hash_f213fc40b2f63070" ) == 0 )
    {
        gunner playlocalsound( var_872e9fd8a2a204b0.var_9d9213e85cfe091f );
    }
    
    if ( getdvarint( @"hash_6e0c4af8a30676b6", 1 ) == 1 )
    {
        function_9c3a0606da40389d( var_872e9fd8a2a204b0, gunner );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xb7be
// Size: 0x84
function function_9c3a0606da40389d( var_872e9fd8a2a204b0, gunner )
{
    if ( gunner scripts\engine\sp\utility::isads() )
    {
        quick_scale = var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7;
        var_c93051491f15e796 = var_872e9fd8a2a204b0.var_59466ae3db1a146e;
    }
    else
    {
        quick_scale = var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa;
        var_c93051491f15e796 = var_872e9fd8a2a204b0.var_594669e3db1a123b;
    }
    
    earthquake( quick_scale, var_c93051491f15e796, gunner.origin, var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xb84a
// Size: 0x35f
function function_62b4daf15be3076a( gunner, weapon_name )
{
    var_872e9fd8a2a204b0 = function_f45ebfa891515d9b( weapon_name );
    full_trace = function_6b7ff0cd994a7fe( gunner );
    projectile_start = gunner.origin;
    impact_pos = full_trace[ "position" ];
    
    if ( weapon_name != level.gunship.var_d6604f5e3d0ba5ea )
    {
        gunship_dist = distance( projectile_start, impact_pos );
        
        if ( getdvarint( @"hash_7a03222b5456284d" ) == 1 )
        {
            if ( gunship_dist > getdvarint( @"hash_277f4c8bbc3d8083" ) )
            {
                original_start = projectile_start;
                max_range = getdvarint( @"hash_277f4c8bbc3d8083" );
                extra_dist = gunship_dist - max_range;
                offset_range = clamp( extra_dist, 0, getdvarint( @"hash_86db6dd1d3fd9982" ) );
                dist = max_range + offset_range;
                var_799f9baa8717f283 = impact_pos - projectile_start;
                direction = vectornormalize( var_799f9baa8717f283 );
                projectile_start = impact_pos - direction * dist;
                
                /#
                    if ( getdvarint( @"hash_3c74a0a5b381bbb3" ) == 1 )
                    {
                        childthread draw_line_for_time( projectile_start, impact_pos, 1, 0, 1, 1 );
                        childthread draw_line_for_time( original_start, impact_pos, 1, 1, 1, 1 );
                    }
                #/
            }
        }
        
        if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 )
        {
            impact_pos += randomvector( level.gunship.var_f81a604f04ca7c67 );
            childthread function_749e3c5f99d50954( "gunship_hellfire_crt", 0.1, 0.2, 0.5 );
        }
        else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
        {
            impact_pos += randomvector( level.gunship.var_3878f8cac277eba );
            childthread function_749e3c5f99d50954( "gunship_40mm_crt", 0.1, 0.1, 0.3 );
        }
        else if ( weapon_name == level.gunship.var_d660505e3d0ba81d )
        {
            impact_pos += randomvector( level.gunship.var_fe8115e13e88cccd );
            childthread function_749e3c5f99d50954( "gunship_25mm_crt", 0.1, 0.1, 0.2 );
        }
        
        projectile = magicbullet( weapon_name, projectile_start, impact_pos, gunner );
        projectile.gsc_spawned = 1;
    }
    else
    {
        childthread function_749e3c5f99d50954( "gunship_hellfire_crt", 0.1, 0.2, 0.5 );
        projectile = function_1e214468bc811f40( projectile_start, impact_pos, gunner );
    }
    
    if ( !isdefined( projectile ) )
    {
        return;
    }
    
    level.var_1250917a0280ae9 = array_add( level.var_1250917a0280ae9, projectile );
    projectile.var_872e9fd8a2a204b0 = var_872e9fd8a2a204b0;
    level notify( "gunship_weapon_fired", projectile, weapon_name, impact_pos );
    
    if ( projectile.var_872e9fd8a2a204b0.currentammo > 0 )
    {
        if ( getdvarint( @"player_sustainammo" ) == 0 )
        {
            projectile.var_872e9fd8a2a204b0.currentammo--;
        }
    }
    
    thread function_3c14d5bc5161b85b( projectile, impact_pos, weapon_name );
    return projectile;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0xbbb2
// Size: 0x61
function function_749e3c5f99d50954( vision, fade_in, delay, fade_out )
{
    if ( flag( "igc_start" ) )
    {
        return;
    }
    
    level notify( "kill_crt_vision" );
    level endon( "kill_crt_vision" );
    level endon( "igc_start" );
    visionsetfadetoblack( vision, fade_in );
    noself_delaycall( delay, &visionsetfadetoblack, "", fade_out );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0xbc1b
// Size: 0x319
function function_1e214468bc811f40( projectile_start, impact_pos, player )
{
    missile = undefined;
    
    if ( !flag( "hellfire_system_busy" ) || getdvarint( @"player_sustainammo" ) == 1 )
    {
        if ( getdvarint( @"hash_cca85e49b724df8b" ) == 2 )
        {
            missile = function_52ef54bd52ac31ce( self.var_48ca513b655d8d82, self.var_e90a9a2f31633c19, projectile_start, impact_pos, player );
            level notify( "hellfire_missile_launched", missile, self.var_48ca513b655d8d82 );
            
            if ( utility::getdifficulty() != "hard" && utility::getdifficulty() != "fu" )
            {
                if ( getdvarint( @"hash_d8d71cbe1098260e", 1 ) == 0 )
                {
                    thread utility::display_hint( "vision_thermal", 5, undefined, missile );
                }
            }
            
            reloadtime = level.weaponreloadtime[ missile.var_872e9fd8a2a204b0.weapon_object.basename ];
            
            if ( !isdefined( reloadtime ) || reloadtime <= 0.1 )
            {
                reloadtime = 0.1;
            }
            
            scripts\engine\sp\utility::delaychildthread( reloadtime, &function_3195e1aab4f57134 );
        }
        else if ( getdvarint( @"hash_cca85e49b724df8b" ) == 1 )
        {
            if ( getdvarint( @"hash_9adf55d0d617dfdd", 0 ) )
            {
                missile = function_52ef54bd52ac31ce( self.var_48ca513b655d8d82, self.var_e90a9a2f31633c19, projectile_start, impact_pos, player );
                level notify( "hellfire_missile_launched", missile, self.var_48ca513b655d8d82 );
                player thread function_81c81c8a63f53006( missile );
                reloadtime = level.weaponreloadtime[ missile.var_872e9fd8a2a204b0.weapon_object.basename ];
                
                if ( !isdefined( reloadtime ) || reloadtime <= 0.1 )
                {
                    reloadtime = 0.1;
                }
                
                scripts\engine\sp\utility::delaychildthread( reloadtime, &function_3195e1aab4f57134 );
            }
            else
            {
                missile = player function_74ea1e4753949cee( projectile_start, impact_pos, self.var_e90a9a2f31633c19 );
                player playlocalsound( "gunship_105mm_sp_reload" );
                reloadtime = level.weaponreloadtime[ missile.var_872e9fd8a2a204b0.weapon_object.basename ];
                
                if ( !isdefined( reloadtime ) || reloadtime <= 0.1 )
                {
                    reloadtime = 0.1;
                }
                
                scripts\engine\sp\utility::delaychildthread( reloadtime, &function_3195e1aab4f57134 );
            }
        }
        else
        {
            while ( player attackbuttonpressed() )
            {
                result = player missilelauncherusage( impact_pos );
                
                if ( istrue( result ) )
                {
                    missile = function_52ef54bd52ac31ce( player.missilelaunchertarget, self.var_e90a9a2f31633c19, projectile_start, impact_pos, player );
                    level notify( "hellfire_missile_launched", missile, self.var_48ca513b655d8d82 );
                    reloadtime = level.weaponreloadtime[ missile.var_872e9fd8a2a204b0.weapon_object.basename ];
                    scripts\engine\sp\utility::delaychildthread( reloadtime, &function_3195e1aab4f57134 );
                    break;
                }
                else if ( isdefined( player.var_aa1d1fe26ddb3042 ) )
                {
                    hideheadiconfromplayersinmask( player.var_aa1d1fe26ddb3042 );
                }
                
                waitframe();
            }
            
            player function_3e954d9a9a42058a();
            player function_f7e6f0d8bd63409d();
        }
    }
    
    return missile;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xbf3d
// Size: 0x87
function function_81c81c8a63f53006( missile )
{
    self freezelookcontrols( 1 );
    missile.type = "remote";
    missile setotherent( self );
    missile setentityowner( self );
    missile dontinterpolate();
    self cameralinkto( missile, "tag_origin" );
    self controlslinkto( missile );
    self cameraset( "killcam_car" );
    self springcamdisabled( 0 );
    missile waittill( "death" );
    self cameraunlink();
    self controlsunlink();
    self freezelookcontrols( 0 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xbfcc
// Size: 0x1d9
function function_7ed3af1650bf961f( gunner, name )
{
    current_fov = gunner playergetzoomfov();
    
    if ( name == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        if ( gunner adsbuttonpressed() )
        {
            if ( current_fov == level.var_285ce926ff345ee3 )
            {
                earthquake( 0.3, 1, gunner.origin, 100 );
            }
            else if ( current_fov == level.var_10a026b50d5be68f )
            {
                earthquake( 0.4, 1, gunner.origin, 100 );
            }
        }
        else
        {
            earthquake( 0.2, 1, gunner.origin, 1000 );
        }
        
        return;
    }
    
    if ( name == level.gunship.var_d6604d5e3d0ba184 )
    {
        if ( gunner adsbuttonpressed() )
        {
            if ( current_fov == level.var_285ce926ff345ee3 )
            {
                earthquake( 0.2, 0.35, gunner.origin, 100 );
            }
            else if ( current_fov == level.var_10a026b50d5be68f )
            {
                earthquake( 0.3, 0.35, gunner.origin, 100 );
            }
        }
        else
        {
            earthquake( 0.1, 0.35, gunner.origin, 1000 );
        }
        
        return;
    }
    
    if ( gunner adsbuttonpressed() )
    {
        if ( current_fov == level.var_285ce926ff345ee3 )
        {
            earthquake( 0.1, 0.1, gunner.origin, 100 );
        }
        else if ( current_fov == level.var_10a026b50d5be68f )
        {
            earthquake( 0.1, 0.1, gunner.origin, 100 );
        }
        
        return;
    }
    
    earthquake( 0.1, 0.1, gunner.origin, 100 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xc1ad
// Size: 0x2aa
function function_e77db3847fe7a928( gunner )
{
    streakinfo = self.streakinfo;
    self.var_9acfd96babd08e79 = -6000;
    self.var_eb994a929b4e42db = -350;
    self.var_eba1d1929b57576e = -100;
    self.var_c56c107cfa9ba64 = -6000;
    
    if ( getdvarint( @"hash_cca85e49b724df8b" ) )
    {
        self.var_48ca513b655d8d82 = spawn_script_origin();
        self.var_48ca513b655d8d82 dontinterpolate();
        self.laser_ent = spawn( "script_model", gunner.origin );
        self.laser_ent.angles = gunner.angles;
        self.laser_ent setmodel( "tag_laser" );
        self.laser_ent setmoverlaserweapon( "iw8_laser_painter_ac130_hellfire" );
        self.laser_ent linkto( gunner );
        
        if ( isdefined( self.laser_ent ) )
        {
            childthread function_762f335fd954ac86( gunner );
        }
    }
    
    while ( true )
    {
        gunner waittill( "missile_fire", projectile, weapon );
        projectile.var_872e9fd8a2a204b0 = weapon;
        function_e532fa04b8270904( weapon.basename, gunner, projectile.var_872e9fd8a2a204b0 );
        gunner childthread gunship_watchweaponimpact( projectile );
        
        if ( istrue( projectile.is_fake ) )
        {
            continue;
        }
        
        projectile.streakinfo = streakinfo;
        streakinfo.shots_fired++;
        weapon = gunner getcurrentweapon();
        currentammo = gunner getweaponammoclip( weapon );
        gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", currentammo );
        
        if ( weapon.basename == level.gunship.var_d6604e5e3d0ba3b7 )
        {
            earthquake( 0.2, 1, self.origin, 1000 );
            gunner setclientomnvar( "ui_killstreak_weapon_1_ammo", currentammo );
        }
        else if ( weapon.basename == level.gunship.var_d6604d5e3d0ba184 )
        {
            earthquake( 0.1, 0.5, self.origin, 1000 );
            gunner setclientomnvar( "ui_killstreak_weapon_2_ammo", currentammo );
        }
        else if ( weapon.basename == level.gunship.var_d660505e3d0ba81d )
        {
            earthquake( 0.01, 0.1, self.origin, 1000 );
            gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", currentammo );
        }
        
        if ( currentammo == 0 )
        {
            gunner thread function_6c7ef99bf5ba717f( weapon, self );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xc45f
// Size: 0x269
function gunship_watchweaponimpact( projectile )
{
    level endon( "missionfailed" );
    weapon_name = projectile.var_872e9fd8a2a204b0.weapon_object.basename;
    
    if ( isdefined( level.var_2825cd44d4091ad3 ) )
    {
        projectile childthread [[ level.var_2825cd44d4091ad3 ]]( projectile.var_872e9fd8a2a204b0.weapon_object );
    }
    
    projectile waittill( "explode", position );
    level.var_1250917a0280ae9 = array_removeundefined( level.var_1250917a0280ae9 );
    
    if ( isdefined( projectile ) )
    {
        function_7603c1bf75f42d23( projectile, position );
    }
    
    if ( isdefined( level.var_26eff2bcd81ab5ef ) )
    {
        self childthread [[ level.var_26eff2bcd81ab5ef ]]( projectile );
    }
    
    if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        impact_radius = 1200;
        var_84f1f2eb003fcb49 = "gunship_105mm_expl_radio";
    }
    else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
    {
        impact_radius = 1000;
        var_84f1f2eb003fcb49 = "gunship_40mm_expl_radio";
    }
    else
    {
        impact_radius = 600;
        var_84f1f2eb003fcb49 = "gunship_25mm_expl_radio";
    }
    
    ai_array = getaiarrayinradius( position, impact_radius, "axis", "neutral" );
    ai_array = array_removedead_or_dying( ai_array );
    
    if ( isdefined( level.var_e8e0eac736110e84 ) && ai_array.size > 0 )
    {
        /#
            if ( getdvarint( @"hash_5da9c798d17a834", 0 ) == 1 )
            {
                childthread draw_circle( position, impact_radius, ( 1, 1, 1 ), 1, 1, 5 );
            }
        #/
        
        foreach ( ai in ai_array )
        {
            ai childthread [[ level.var_e8e0eac736110e84 ]]();
        }
    }
    
    ally_guys = getaiarray( "allies" );
    
    if ( ally_guys.size > 0 )
    {
        var_79df09a6d3e7f50c = getclosest( position, ally_guys, 10000 );
        
        if ( isdefined( var_79df09a6d3e7f50c ) && isdefined( var_79df09a6d3e7f50c.origin ) && isdefined( var_84f1f2eb003fcb49 ) )
        {
            thread function_4385b2a9645a3367( position, var_79df09a6d3e7f50c.origin, var_84f1f2eb003fcb49 );
        }
    }
    
    level notify( "gunship_weapon_impact", position, weapon_name );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xc6d0
// Size: 0x1fe
function function_7603c1bf75f42d23( projectile, position )
{
    thread function_88486e4d549c70fd();
    function_951c157530869992();
    
    if ( isdefined( level.gunship.var_e8435f0da7909b0c ) )
    {
        struct = level [[ level.gunship.var_e8435f0da7909b0c ]]( projectile, position );
    }
    else
    {
        struct = spawnstruct();
        struct.origin = ter_op( isdefined( projectile ), projectile.origin, position );
        struct.time = gettime();
        struct.endtime = gettime() + 3000;
        name = projectile.var_872e9fd8a2a204b0.weapon_object.basename;
        
        if ( name == "gunship_40mm_jup_sp" )
        {
            struct.var_ceffcb0d6eeac4e6 = 1000;
            struct.var_cedcbd0d6ec45e64 = 600;
            struct.radius = 100;
        }
        else if ( name == "gunship_25mm_jup_sp" )
        {
            struct.var_ceffcb0d6eeac4e6 = 600;
            struct.var_cedcbd0d6ec45e64 = 300;
            struct.radius = 32;
        }
        else
        {
            struct.var_ceffcb0d6eeac4e6 = 1300;
            struct.var_cedcbd0d6ec45e64 = 900;
            struct.radius = 200;
        }
    }
    
    struct function_c2e0f7f0c4bb85d1( projectile.var_872e9fd8a2a204b0.weapon_object.basename );
    struct.var_c5f1b9c2e07616f4 = squared( struct.var_ceffcb0d6eeac4e6 );
    function_4c00902b6e16e596( struct );
    level.gunship.var_b16fecb954d8b304[ level.gunship.var_b16fecb954d8b304.size ] = struct;
    level.gunship.var_c8122d8b582aef7f = struct;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xc8d6
// Size: 0x139
function function_c2e0f7f0c4bb85d1( weaponname )
{
    if ( !isdefined( level.var_38cc5d7e5cd33606 ) )
    {
        return;
    }
    
    volumes = sortbydistancecullbyradius( level.var_38cc5d7e5cd33606, self.origin, 2000 );
    
    if ( !isdefined( volumes ) || volumes.size < 1 )
    {
        return;
    }
    
    foreach ( volume in volumes )
    {
        if ( ispointinvolume( self.origin, volume ) )
        {
            scripts\sp\player_death::clear_custom_death_quote();
            
            if ( isdefined( volume.script_noteworthy ) )
            {
                should_fail = volume function_d875862b1eb9b973( self.origin );
                
                if ( !should_fail )
                {
                    return;
                }
            }
            else
            {
                level.player thread scripts\anim\dialogue::say_global( level.var_5ed1147d2ab9e8c7 deck_draw(), 1, 3, 1 );
                index = [ 205, 206, 207 ];
                scripts\sp\player_death::set_custom_death_quote( array_randomize( index )[ 0 ] );
            }
            
            thread scripts\sp\utility::missionfailedwrapper();
            break;
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xca17
// Size: 0x18e
function function_d875862b1eb9b973( point )
{
    should_fail = 1;
    
    switch ( self.script_noteworthy )
    {
        case #"hash_31ccf4980e7b0f42":
            fail_volume = getent( self.target, "targetname" );
            
            if ( ispointinvolume( point, fail_volume ) )
            {
                if ( time_has_passed( level.var_ad5a633b8c435221, 2 ) )
                {
                    level.player thread scripts\anim\dialogue::say_global( level.var_d3fa99d1d6eebdce deck_draw(), 1, 3, 1 );
                }
                
                scripts\sp\player_death::set_custom_death_quote( 244 );
            }
            else
            {
                if ( time_has_passed( level.var_ad5a633b8c435221, 5 ) )
                {
                    level.player thread scripts\anim\dialogue::say_global( level.var_f6651053df0e9bd8 deck_draw(), 1, 3 );
                }
                
                level.var_ad5a633b8c435221 = gettime();
                should_fail = 0;
            }
            
            break;
        case #"hash_6d3a25e948c612e":
            level.player thread scripts\anim\dialogue::say_global( level.var_5ed1147d2ab9e8c7 deck_draw(), 1, 3, 1 );
            scripts\sp\player_death::set_custom_death_quote( 245 );
        default:
            level.player thread scripts\anim\dialogue::say_global( level.var_5ed1147d2ab9e8c7 deck_draw(), 1, 3, 1 );
            index = [ 205, 206, 207 ];
            scripts\sp\player_death::set_custom_death_quote( array_randomize( index )[ 0 ] );
            break;
    }
    
    return should_fail;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xcbae
// Size: 0x133
function function_4c00902b6e16e596( newstruct )
{
    level.gunship.var_b16fecb954d8b304 = utility::array_removeundefined( level.gunship.var_b16fecb954d8b304 );
    
    if ( !isdefined( newstruct ) || !isdefined( newstruct.origin ) )
    {
        return;
    }
    
    newarray = [];
    radiussqrd = squared( newstruct.radius );
    
    if ( !isdefined( radiussqrd ) )
    {
        return;
    }
    
    foreach ( struct in level.gunship.var_b16fecb954d8b304 )
    {
        if ( !isdefined( newstruct ) || !isdefined( struct ) || !isdefined( struct.origin ) || distance2dsquared( newstruct.origin, struct.origin ) < radiussqrd )
        {
            continue;
        }
        
        newarray[ newarray.size ] = struct;
    }
    
    newarray = utility::array_removeundefined( newarray );
    level.gunship.var_b16fecb954d8b304 = newarray;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xcce9
// Size: 0x93
function function_951c157530869992()
{
    newarray = [];
    
    foreach ( struct in level.gunship.var_b16fecb954d8b304 )
    {
        if ( gettime() > struct.endtime )
        {
            continue;
        }
        
        newarray[ newarray.size ] = struct;
    }
    
    level.gunship.var_b16fecb954d8b304 = newarray;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xcd84
// Size: 0xd1
function function_88486e4d549c70fd()
{
    /#
        if ( istrue( level.var_88486e4d549c70fd ) )
        {
            return;
        }
        
        if ( !getdvarint( @"hash_f2f36ad676e3835b" ) > 0 )
        {
            return;
        }
        
        level.var_88486e4d549c70fd = 1;
        
        while ( true )
        {
            foreach ( struct in level.gunship.var_b16fecb954d8b304 )
            {
                print3d( struct.origin, index );
                draw_circle( struct.origin, struct.radius, ( 1, 1, 1 ), 1, 1, 1 );
            }
            
            waitframe();
        }
    #/
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0xce5d
// Size: 0x35e
function function_3c14d5bc5161b85b( projectile, impact_pos, weapon_name )
{
    ally_guys = getaiarray( "allies" );
    ally_guys = array_removeundefined( ally_guys );
    var_37fe41e9dc3c8f22 = 0;
    var_932ed5ee822e94d1 = 0;
    var_1060354d0d90695 = "null";
    
    if ( isdefined( projectile ) && ally_guys.size > 0 )
    {
        var_1bcac4fa3002540a = getclosest( impact_pos, ally_guys, 10000 );
        
        if ( !isdefined( var_1bcac4fa3002540a ) )
        {
            return;
        }
        
        var_2bddcec8c3aac97f = distancesquared( var_1bcac4fa3002540a.origin, impact_pos );
        var_256b40591aa1085c = distancesquared( projectile.origin, impact_pos );
        var_7965f3906b55049a = 0;
        var_1060354d0d90695 = "null";
        
        if ( weapon_name == level.gunship.var_d6604e5e3d0ba3b7 || weapon_name == level.gunship.var_d6604f5e3d0ba5ea )
        {
            var_932ed5ee822e94d1 = 1;
            var_1060354d0d90695 = "gunship_105mm_incoming_radio";
            var_7c2c2a9ae1434824 = 4840000;
            close_dist = 25000000;
            far_dist = 144000000;
            
            if ( getdvar( @"g_mapname" ) == "gunship_compound" )
            {
                var_7965f3906b55049a = 81000000;
            }
            else
            {
                var_7965f3906b55049a = 125000000;
            }
        }
        else if ( weapon_name == level.gunship.var_d6604d5e3d0ba184 )
        {
            var_1060354d0d90695 = "gunship_40mm_incoming_radio";
            var_7c2c2a9ae1434824 = 1000000;
            close_dist = 12250000;
            far_dist = 49000000;
            
            if ( getdvar( @"g_mapname" ) == "gunship_compound" )
            {
                var_7965f3906b55049a = 121000000;
            }
            else
            {
                var_7965f3906b55049a = 43000000;
            }
        }
        else
        {
            var_37fe41e9dc3c8f22 = 1;
            var_1060354d0d90695 = "gunship_25mm_incoming_radio";
            var_7c2c2a9ae1434824 = 360000;
            close_dist = 3240000;
            far_dist = 10240000;
            
            if ( getdvar( @"g_mapname" ) == "gunship_compound" )
            {
                var_7965f3906b55049a = 121000000;
            }
            else
            {
                var_7965f3906b55049a = 43000000;
            }
        }
        
        if ( isdefined( close_dist ) && isdefined( far_dist ) && isdefined( var_1060354d0d90695 ) )
        {
            if ( var_2bddcec8c3aac97f <= var_7c2c2a9ae1434824 )
            {
                var_1060354d0d90695 += "_super_close";
            }
            else if ( var_7c2c2a9ae1434824 < var_2bddcec8c3aac97f && var_2bddcec8c3aac97f < far_dist )
            {
                if ( var_37fe41e9dc3c8f22 )
                {
                    return;
                }
            }
            else if ( var_2bddcec8c3aac97f >= far_dist )
            {
                if ( !var_932ed5ee822e94d1 )
                {
                    return;
                }
                
                var_1060354d0d90695 += "_dist";
            }
            
            projectile.projectile_sfx = spawn( "script_origin", projectile.origin );
            projectile.projectile_sfx linkto( projectile );
            
            if ( var_7965f3906b55049a > 0 )
            {
                while ( isdefined( projectile ) && isdefined( var_1bcac4fa3002540a ) && var_256b40591aa1085c > var_7965f3906b55049a )
                {
                    var_256b40591aa1085c = distancesquared( projectile.origin, var_1bcac4fa3002540a.origin );
                    wait 0.1;
                }
            }
            
            if ( isdefined( projectile.projectile_sfx ) )
            {
                projectile.projectile_sfx playsound( var_1060354d0d90695 );
                projectile waittill( "explode", position );
                
                if ( isdefined( projectile.projectile_sfx ) )
                {
                    projectile.projectile_sfx stopsounds();
                }
                
                waitframe();
                
                if ( isdefined( projectile.projectile_sfx ) )
                {
                    projectile.projectile_sfx delete();
                }
            }
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0xd1c3
// Size: 0x167
function function_4385b2a9645a3367( fxent_pos, speaker_origin, var_84f1f2eb003fcb49 )
{
    var_f42faa1f833d3355 = distancesquared( fxent_pos, speaker_origin );
    
    switch ( var_84f1f2eb003fcb49 )
    {
        case #"hash_805b5a79f644cfce":
            sound = "exp_gunship_hellfire_dist";
            var_7c2c2a9ae1434824 = 4840000;
            close_dist = 25000000;
            far_dist = 144000000;
            break;
        case #"hash_a24437cb194e01fe":
            sound = "exp_gunship_40mm_dist";
            var_7c2c2a9ae1434824 = 1000000;
            close_dist = 12250000;
            far_dist = 49000000;
            break;
        case #"hash_3413b6c430da1aed":
            sound = "prj_bullet_large_plr_far";
            var_7c2c2a9ae1434824 = 360000;
            close_dist = 3240000;
            far_dist = 10240000;
            break;
        default:
            sound = undefined;
            var_7c2c2a9ae1434824 = undefined;
            close_dist = undefined;
            far_dist = undefined;
            break;
    }
    
    level.player playsound( sound );
    
    if ( isdefined( close_dist ) && isdefined( far_dist ) )
    {
        if ( var_f42faa1f833d3355 < var_7c2c2a9ae1434824 )
        {
            level.player playsound( var_84f1f2eb003fcb49 + "_dist" );
            return;
        }
        
        if ( var_f42faa1f833d3355 < close_dist )
        {
            level.player playsound( var_84f1f2eb003fcb49 );
            return;
        }
        
        if ( var_f42faa1f833d3355 < far_dist )
        {
            level.player playsound( var_84f1f2eb003fcb49 + "_dist" );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xd332
// Size: 0x1c6
function function_6c7ef99bf5ba717f( weapon, gunship )
{
    gunship endon( "death" );
    gunship endon( "crashing" );
    gunship endon( "leaving" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    level notify( "gunshipWeaponReloading" );
    self.weapon_reloading = 1;
    self setweaponammoclip( weapon, 0 );
    
    if ( weapon.basename == level.gunship.var_d6604f5e3d0ba5ea )
    {
        weaponrootname = "gunship_hellfire";
    }
    else
    {
        weaponrootname = getgunshipweaponrootname( weapon );
    }
    
    if ( !isdefined( weaponrootname ) )
    {
        return;
    }
    
    if ( weaponrootname != "gunship_hellfire" )
    {
        if ( issubstr( weaponrootname, "40mm" ) )
        {
            self playlocalsound( "gunship__40mm_sp_reload" );
        }
        else if ( issubstr( weaponrootname, "25mm" ) )
        {
            self playlocalsound( "gunship_25mm_sp_reload" );
        }
        else if ( issubstr( weaponrootname, "105mm" ) )
        {
            if ( soundexists( "gunship_105mm_sp_reload" ) )
            {
                self playlocalsound( "gunship_105mm_sp_reload" );
            }
            else
            {
                self playlocalsound( "ac130_105mm_mp_reload" );
            }
        }
    }
    
    thread function_31eca0d2996fb0fe();
    var_f3fc82c371854578 = undefined;
    
    switch ( weaponrootname )
    {
        case #"hash_a595cc01d9fdb1c3":
            var_f3fc82c371854578 = "ui_killstreak_weapon_1_ammo";
            break;
        case #"hash_f7dc9df20da28f2":
            var_f3fc82c371854578 = "ui_killstreak_weapon_2_ammo";
            break;
        case #"hash_9e7bbed3c5c35ca3":
            var_f3fc82c371854578 = "ui_killstreak_weapon_3_ammo";
            break;
    }
    
    self setclientomnvar( var_f3fc82c371854578, 0 );
    gunship_waitforweaponreloadtime( weapon, weaponrootname );
    level notify( "gunshipWeaponReloaded" );
    thread function_3ce5a109653aad93();
    maxammo = weaponmaxammo( weapon );
    self setweaponammoclip( weapon, maxammo );
    self givemaxammo( weapon );
    self setclientomnvar( var_f3fc82c371854578, maxammo );
    self.weapon_reloading = 0;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xd500
// Size: 0x7f
function getmissileexplscale( weaponname )
{
    scale = 1;
    
    if ( weaponname == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        scale = 0.75;
    }
    else if ( weaponname == level.gunship.var_d6604d5e3d0ba184 )
    {
        scale = 0.5;
    }
    else if ( weaponname == level.gunship.var_d660505e3d0ba81d )
    {
        scale = 0.15;
    }
    
    return scale;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xd588
// Size: 0x79
function getmissileexplradius( weaponname )
{
    radius = 1;
    
    if ( weaponname == level.gunship.var_d6604e5e3d0ba3b7 )
    {
        radius = 2000;
    }
    else if ( weaponname == level.gunship.var_d6604d5e3d0ba184 )
    {
        radius = 1300;
    }
    else if ( weaponname == level.gunship.var_d660505e3d0ba81d )
    {
        radius = 700;
    }
    
    return radius;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xd60a
// Size: 0x19
function deleteaftertime( delay )
{
    self endon( "death" );
    self delete();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xd62b
// Size: 0x4e
function gunship_watch105mmexplosion( gunship, gunner )
{
    gunship endon( "death" );
    gunship endon( "leaving" );
    gunship endon( "crashing" );
    self waittill( "death" );
    earthquake( 0.125, 0.5, gunship.origin, 1000 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xd681
// Size: 0x26
function gunship_getvisionsetformat( currentvisionset )
{
    return ter_op( issubstr( currentvisionset, "flir" ), "flir", "color" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xd6b0
// Size: 0x66
function gunship_getvisionset( format, strength )
{
    visionset = undefined;
    
    if ( isdefined( strength ) )
    {
        if ( format == "flir" )
        {
            visionset = level.gunship.thermal_vision;
        }
        else
        {
            visionset = level.gunship.color_vision;
        }
    }
    else
    {
        visionset = "generic_glitch";
    }
    
    return visionset;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0xd71f
// Size: 0x190
function gunship_weaponreload( var_872e9fd8a2a204b0, gunship, reloadtime )
{
    gunship endon( "death" );
    gunship endon( "crashing" );
    gunship endon( "leaving" );
    level endon( "missionfailed" );
    level notify( "gunshipWeaponReloading" );
    weapon = var_872e9fd8a2a204b0.weapon_object;
    
    if ( weapon.basename == level.gunship.var_d6604f5e3d0ba5ea )
    {
        weaponrootname = "gunship_hellfire";
    }
    else
    {
        weaponrootname = getgunshipweaponrootname( weapon );
    }
    
    if ( weaponrootname != "gunship_hellfire" )
    {
        reloadsound = weaponrootname + "_sp_reload";
        var_dd020944ee631ba8 = strtok( weaponrootname, "_" );
        
        if ( var_dd020944ee631ba8[ 0 ] == "gunship" )
        {
            reloadsound = "gunship";
            
            for ( i = 1; i < var_dd020944ee631ba8.size ; i++ )
            {
                appendstring = var_dd020944ee631ba8[ i ];
                
                if ( appendstring == "hellfire" )
                {
                    appendstring = "105mm";
                }
                
                reloadsound = reloadsound + "_" + appendstring;
            }
            
            reloadsound += "_sp_reload";
        }
        
        self playlocalsound( reloadsound );
    }
    
    var_872e9fd8a2a204b0.is_reloading = 1;
    
    if ( weaponrootname != "gunship_hellfire" )
    {
        thread function_31eca0d2996fb0fe( weapon.basename );
    }
    
    gunship_waitforweaponreloadtime( weapon, weaponrootname, reloadtime );
    thread function_3ce5a109653aad93( weapon.basename );
    var_872e9fd8a2a204b0.is_reloading = 0;
    function_7bf095a48de1e9b6( var_872e9fd8a2a204b0, weaponrootname );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xd8b7
// Size: 0x12a
function function_31eca0d2996fb0fe( var_24a61f7d6e58bc2 )
{
    if ( !isdefined( level.var_b1c38a076b2f9945 ) )
    {
        aliases = [];
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_offthetrigger";
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_reloading";
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_blackonammostandby";
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_loadingrounds";
        level.var_b1c38a076b2f9945 = create_deck( aliases, 1, 1 );
    }
    
    if ( percent_chance( 50 ) || istrue( level.var_9683ea2462b2baa ) )
    {
        return;
    }
    
    if ( isdefined( level.var_1830fb97f0092f1b ) && !time_has_passed( level.var_1830fb97f0092f1b, 20 ) )
    {
        return;
    }
    
    waitframe();
    var_af8c37639cd4f153 = function_878e144349832994( level.player );
    
    if ( !is_equal( var_af8c37639cd4f153, var_24a61f7d6e58bc2 ) )
    {
        return;
    }
    
    alias = level.var_b1c38a076b2f9945 deck_draw();
    said_line = level.player scripts\anim\dialogue::say_global( alias, 0, 0 );
    
    if ( isdefined( said_line ) && !said_line )
    {
        level.var_b1c38a076b2f9945.index--;
        return;
    }
    
    level.var_1830fb97f0092f1b = gettime();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xd9e9
// Size: 0x181
function function_3ce5a109653aad93( var_24a61f7d6e58bc2 )
{
    if ( !isdefined( level.var_dc428e4d058c984e ) )
    {
        aliases = [];
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_backonthetrigger";
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_onthetrigger_01";
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_imgreen";
        aliases[ aliases.size ] = "dx_sp_jsgs_psh1_sgun_gunsready";
        level.var_dc428e4d058c984e = create_deck( aliases, 1, 1 );
        aliases = [];
        aliases[ aliases.size ] = "dx_sp_gscp_gnht_grav_copy";
        aliases[ aliases.size ] = "dx_sp_gscp_gnht_grav_youreclearedhot";
        aliases[ aliases.size ] = "dx_sp_gscp_gnht_grav_cleartoengage";
        level.var_9c66f49550bcc614 = create_deck( aliases, 1, 1 );
    }
    
    if ( percent_chance( 35 ) || istrue( level.var_9683ea2462b2baa ) )
    {
        return;
    }
    
    if ( isdefined( level.var_1830fb97f0092f1b ) && !time_has_passed( level.var_1830fb97f0092f1b, 8 ) )
    {
        return;
    }
    
    if ( isdefined( level.var_790be18164c912ac ) && !time_has_passed( level.var_790be18164c912ac, 16 ) )
    {
        return;
    }
    
    var_af8c37639cd4f153 = function_878e144349832994( level.player );
    
    if ( !is_equal( var_af8c37639cd4f153, var_24a61f7d6e58bc2 ) )
    {
        return;
    }
    
    alias = level.var_dc428e4d058c984e deck_draw();
    said_line = level.player scripts\anim\dialogue::say_global( alias, 0, 0 );
    
    if ( isdefined( said_line ) && !said_line )
    {
        level.var_dc428e4d058c984e.index--;
        return;
    }
    
    level.var_790be18164c912ac = gettime();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xdb72
// Size: 0x11a
function function_7bf095a48de1e9b6( var_872e9fd8a2a204b0, weaponrootname )
{
    var_f3fc82c371854578 = undefined;
    weapon = var_872e9fd8a2a204b0.weapon_object;
    
    switch ( weaponrootname )
    {
        case #"hash_1aa0b38da9c6a002":
            var_f3fc82c371854578 = "ui_killstreak_weapon_1_ammo";
            var_872e9fd8a2a204b0.currentammo = 1;
            break;
        case #"hash_f7dc9df20da28f2":
            var_f3fc82c371854578 = "ui_killstreak_weapon_2_ammo";
            var_872e9fd8a2a204b0.currentammo = 10;
            break;
        case #"hash_9e7bbed3c5c35ca3":
            var_f3fc82c371854578 = "ui_killstreak_weapon_3_ammo";
            var_872e9fd8a2a204b0.currentammo = 30;
            break;
        case #"hash_a595cc01d9fdb1c3":
            var_f3fc82c371854578 = "ui_killstreak_weapon_1_ammo";
            var_872e9fd8a2a204b0.currentammo = 1;
            break;
    }
    
    if ( getdvarint( @"hash_f213fc40b2f63070" ) == 0 )
    {
        self setclientomnvar( var_f3fc82c371854578, var_872e9fd8a2a204b0.currentammo );
        return;
    }
    
    maxammo = weaponmaxammo( weapon );
    self setweaponammoclip( weapon, maxammo );
    self setclientomnvar( var_f3fc82c371854578, maxammo );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xdc94
// Size: 0x66
function getgunshipweaponrootname( weapon )
{
    index = 0;
    weaponname = weapon.basename;
    tokens = strtok( weaponname, "_" );
    
    if ( isdefined( tokens[ index ] ) && isdefined( tokens[ index + 1 ] ) )
    {
        return ( tokens[ index ] + "_" + tokens[ index + 1 ] );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0xdd02
// Size: 0x12c
function gunship_waitforweaponreloadtime( weapon, weaponrootname, reloadtime )
{
    reloadtime = utility::default_to( reloadtime, level.weaponreloadtime[ weapon.basename ] );
    var_d7dac94935945aab = undefined;
    
    switch ( weaponrootname )
    {
        case #"hash_1aa0b38da9c6a002":
            self playrumbleonentity( "grenade_rumble" );
            var_d7dac94935945aab = "ui_killstreak_weapon_1_reloadtime";
            break;
        case #"hash_f7dc9df20da28f2":
            self playrumbleonentity( "damage_heavy" );
            var_d7dac94935945aab = "ui_killstreak_weapon_2_reloadtime";
            break;
        case #"hash_9e7bbed3c5c35ca3":
            self playrumbleonentity( "damage_light" );
            var_d7dac94935945aab = "ui_killstreak_weapon_3_reloadtime";
            break;
        case #"hash_a595cc01d9fdb1c3":
            self playrumbleonentity( "grenade_rumble" );
            var_d7dac94935945aab = "ui_killstreak_weapon_1_reloadtime";
            break;
        default:
            self playrumbleonentity( "damage_light" );
            var_d7dac94935945aab = "ui_killstreak_weapon_3_reloadtime";
            break;
    }
    
    self setclientomnvar( var_d7dac94935945aab, gettime() + int( reloadtime * 1000 ) );
    start = gettime();
    
    while ( !time_has_passed( start, reloadtime ) )
    {
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xde36
// Size: 0x43
function gunship_watchthermaltoggle( gunner )
{
    level endon( "stop_gunship" );
    
    if ( !isai( gunner ) )
    {
        gunner thread watchthermalinputchange();
    }
    
    gunship_watchthermaltoggleinternal( gunner );
    
    if ( isdefined( gunner ) && !isai( gunner ) )
    {
        gunner stopwatchingthermalinputchange();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xde81
// Size: 0x8b
function watchthermalinputchange()
{
    self notify( "watch_thermal_input_change" );
    self endon( "watch_thermal_input_change" );
    
    while ( true )
    {
        self notifyonplayercommand( "switch_thermal_mode", "+stance" );
        self notifyonplayercommand( "switch_thermal_mode", "nightvision" );
        returnednotif = waittill_any_return_no_endon_death( "input_type_changed", "thermal_handling_ended" );
        self notifyonplayercommandremove( "switch_thermal_mode", "+stance" );
        self notifyonplayercommandremove( "switch_thermal_mode", "nightvision" );
        
        if ( isdefined( returnednotif ) && returnednotif == "thermal_handling_ended" )
        {
            break;
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xdf14
// Size: 0xc8
function gunship_watchthermaltoggleinternal( gunner )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    togglethermal = 0;
    childthread function_7f4e781be563fb35( gunner );
    visionsetthermal( function_9f3eab80e442080c(), 0 );
    visionsetnaked( level.gunship.color_vision, 0 );
    
    if ( istrue( level.var_5a3f504f0ddbd74f ) || istrue( level.var_c944986665da028e ) )
    {
        togglethermal = function_6e2aea1ddbc2e01c( 1, gunner );
        
        if ( istrue( level.var_c944986665da028e ) )
        {
            return;
        }
    }
    else
    {
        togglethermal = function_6e2aea1ddbc2e01c( togglethermal, gunner );
    }
    
    for ( ;; )
    {
        gunner waittill( "switch_thermal_mode" );
        
        if ( !istrue( level.var_67f5d508f1c46e99 ) )
        {
        }
        else
        {
            togglethermal = function_6e2aea1ddbc2e01c( togglethermal, gunner );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xdfe4
// Size: 0xa4
function function_fe27c1e81c4cc974( gunner )
{
    while ( true )
    {
        button = gunner waittill_any_return_2( "ads_pressed" );
        zoomfov = gunner playergetzoomfov();
        
        if ( gunner playerads() > 0.1 )
        {
            if ( zoomfov > level.var_10a026b50d5be68f )
            {
                if ( button == "sprint_pressed" )
                {
                    self playsound( "ui_gunship_max_zoom_out" );
                }
                
                continue;
            }
            
            if ( button == "sprint_pressed" )
            {
                self playsound( "ui_gunship_max_zoom_in" );
            }
            
            childthread function_749e3c5f99d50954( "gunship_ads_shutter_crt", 0.025, 0.08, 0.15 );
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xe090
// Size: 0x30
function function_6e2aea1ddbc2e01c( togglethermal, gunner )
{
    if ( istrue( togglethermal ) )
    {
        thermal_on( gunner );
        return 0;
    }
    
    color_on( gunner );
    return 1;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xe0c8
// Size: 0x5c
function function_7f4e781be563fb35( gunner )
{
    childthread function_72426610ef19f267( gunner );
    
    while ( true )
    {
        zoomfov = gunner playergetzoomfov();
        
        if ( isdefined( level.var_d1743a1b355dadc9 ) )
        {
            self childthread [[ level.var_d1743a1b355dadc9 ]]( zoomfov, self.currentvisionset, level.var_10a026b50d5be68f );
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xe12c
// Size: 0xfb
function function_72426610ef19f267( gunner )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    gunner endon( "disconnect" );
    level endon( "game_ended" );
    lerptime = 0.15;
    currentfov = level.var_fb13600ef005ed60;
    var_d54d564805c29b7b = undefined;
    var_19b401437b24b05 = 0;
    
    while ( true )
    {
        if ( gunner adsbuttonpressed() )
        {
            var_19b401437b24b05 += 0.05;
            
            if ( var_19b401437b24b05 >= lerptime )
            {
                var_19b401437b24b05 = lerptime;
            }
        }
        else if ( var_19b401437b24b05 > 0 )
        {
            var_19b401437b24b05 -= 0.05;
            
            if ( var_19b401437b24b05 <= 0 )
            {
                var_19b401437b24b05 = 0;
            }
        }
        
        if ( var_19b401437b24b05 >= 0 )
        {
            var_d54d564805c29b7b = gunner playergetzoomfov();
            timeperc = var_19b401437b24b05 / lerptime * 100;
            currentfov = int( timeperc * ( var_d54d564805c29b7b - level.var_fb13600ef005ed60 ) / 100 + level.var_fb13600ef005ed60 );
        }
        
        gunner setclientomnvar( "ui_killstreak_zoom_fov", currentfov );
        wait 0.05;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xe22f
// Size: 0x32
function thermal_on( gunner )
{
    gunner setclientomnvar( "ui_apache_thermal_mode", 1 );
    self.currentvisionset = function_9f3eab80e442080c();
    gunner function_e851921f869b27e9( 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xe269
// Size: 0x15
function function_9f3eab80e442080c()
{
    return level.gunship.thermal_vision;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xe287
// Size: 0x40
function color_on( gunner )
{
    gunner setclientomnvar( "ui_apache_thermal_mode", 3 );
    self.currentvisionset = level.gunship.color_vision;
    gunner function_e851921f869b27e9( 0, 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xe2cf
// Size: 0xd9
function function_e851921f869b27e9( bool, color_mode )
{
    if ( istrue( bool ) )
    {
        flag_set( "thermal_mode" );
        visionsetthermal( level.gunship.model_ent.currentvisionset, 0 );
        self thermalvisionon();
        return;
    }
    
    if ( istrue( color_mode ) )
    {
        flag_clear( "thermal_mode" );
        visionsetnaked( level.gunship.model_ent.currentvisionset, 0 );
        self thermalvisionoff();
        return;
    }
    
    flag_clear( "thermal_mode" );
    visionsetnaked( "" );
    visionsetthermal( "" );
    visionsetfadetoblack( "" );
    visionsetalternate( 0, 0 );
    level.player thermalvisionoff();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xe3b0
// Size: 0x55
function function_1779af5d454604ba()
{
    level notify( "kill_vision_dof" );
    level endon( "kill_vision_dof" );
    
    if ( scripts\engine\sp\utility::isads() )
    {
        zoomfov = self playergetzoomfov();
        thread scripts\sp\art::setdoftracerange( 500 );
    }
    else
    {
        thread scripts\sp\art::setdoftracerange( 1000 );
    }
    
    wait 0.1;
    thread scripts\sp\art::setdoftracerange( 40000 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xe40d
// Size: 0x65
function function_859b892271f1a9f8( toggle )
{
    guys = getaiarray();
    
    foreach ( guy in guys )
    {
        guy function_33cce421690a0805( toggle );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xe47a
// Size: 0x25
function function_33cce421690a0805( toggle )
{
    if ( !isdefined( toggle ) )
    {
        toggle = flag( "thermal_mode" );
    }
    
    if ( istrue( toggle ) )
    {
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xe4a7
// Size: 0x16
function function_c6a86e1307589615()
{
    if ( istrue( level.var_f1acd9be11d8efe5 ) )
    {
        self disablephysicaldepthoffieldscripting();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xe4c5
// Size: 0x37
function function_98e24029626f03b5( fstop, focusdistance )
{
    if ( istrue( level.var_f1acd9be11d8efe5 ) )
    {
        self enablephysicaldepthoffieldscripting();
        self setphysicaldepthoffield( 12, 1000, 20, 20 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xe504
// Size: 0xa
function stopwatchingthermalinputchange()
{
    self notify( "thermal_handling_ended" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xe516
// Size: 0x42c
function gunship_watchdamage( gunner )
{
    self endon( "death" );
    self endon( "crashing" );
    level endon( "missionfailed" );
    self.damagetaken = 0;
    self.attractor = missile_createattractorent( self, 1000, 4096 );
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, nill, nill, smeansofdeath, nill, nill, nill, nill, objweapon );
        
        if ( is_equal( attacker, gunner ) )
        {
            continue;
        }
        
        /#
            iprintlnbold( "<dev string:xf5>" );
        #/
        
        thirdpersoncam = undefined;
        
        /#
            thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        #/
        
        if ( isdefined( level.teambased ) && isplayer( attacker ) && attacker.team == self.team && ( !isdefined( thirdpersoncam ) || !thirdpersoncam ) )
        {
            continue;
        }
        
        if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) && self.owner isusinggunship() )
        {
            var_2acab75717ed1290 = "light";
            
            if ( isexplosivedamagemod( smeansofdeath ) )
            {
                if ( ceil( damage / self.maxhealth ) >= 0.33 )
                {
                    self.owner earthquakeforplayer( 0.25, 0.2, self.camera.origin, 150 );
                    self.owner playrumbleonentity( "damage_heavy" );
                    var_2acab75717ed1290 = "heavy";
                }
                else
                {
                    self.owner earthquakeforplayer( 0.15, 0.15, self.camera.origin, 150 );
                    self.owner playrumbleonentity( "damage_light" );
                }
            }
            
            thread gunship_screeninterference( 0.2, var_2acab75717ed1290 );
        }
        
        self.wasdamaged = 1;
        modifieddamage = undefined;
        self.damagetaken += modifieddamage;
        self.currenthealth = self.maxhealth - self.damagetaken;
        
        if ( isdefined( self.owner ) && self.owner isusinggunship() )
        {
        }
        
        if ( self.currenthealth <= 500 && self.currentdamagestate == 0 )
        {
            self.currentdamagestate = 1;
            self setscriptablepartstate( "body_damage_light", "on" );
        }
        else if ( self.currenthealth <= 250 && self.currentdamagestate == 1 )
        {
            self.currentdamagestate = 2;
            self setscriptablepartstate( "body_damage_light", "off" );
            self setscriptablepartstate( "body_damage_medium", "on" );
            
            if ( isdefined( self.owner ) && self.owner isusinggunship() )
            {
                self.owner playlocalsound( "ks_ac130_damage_warning" );
            }
        }
        else if ( self.currenthealth <= 0 && self.currentdamagestate == 2 )
        {
            self.currentdamagestate = 3;
            self setscriptablepartstate( "body_damage_medium", "off" );
            self setscriptablepartstate( "contrails", "off" );
            thread gunship_startengineblowoutfx();
        }
        
        if ( self.damagetaken >= self.maxhealth )
        {
            streakname = self.streakinfo.streakname;
            damagetype = undefined;
            scorepopupname = "destroyed_" + streakname;
            leaderdialog = undefined;
            cardsplash = "callout_destroyed_" + streakname;
            skipdeathnotify = 1;
            thread gunship_crash( 8, gunner );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xe94a
// Size: 0xc, Type: bool
function isusinggunship()
{
    return isdefined( self.usinggunship );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xe95f
// Size: 0xe9
function gunship_screeninterference( var_33cd555bf93321ad, var_5d9f02c7508f6b6c )
{
    var_a95a67a21665324a = self.owner;
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    
    if ( isdefined( var_a95a67a21665324a ) )
    {
        var_676990f4bd19f5aa = gunship_getvisionsetformat( self.currentvisionset );
        visionset = gunship_getvisionset( var_676990f4bd19f5aa, var_5d9f02c7508f6b6c );
        
        if ( var_676990f4bd19f5aa == "flir" )
        {
            visionsetthermal( visionset, 0.1 );
            var_a95a67a21665324a thermalvisionon();
        }
        else
        {
            visionsetnaked( visionset, 0.05 );
        }
        
        if ( isdefined( var_33cd555bf93321ad ) && isdefined( self.currentvisionset ) )
        {
            if ( var_676990f4bd19f5aa == "flir" )
            {
                visionsetthermal( self.currentvisionset, 0.1 );
                var_a95a67a21665324a thermalvisionon();
                return;
            }
            
            visionsetnaked( self.currentvisionset, 0.05 );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xea50
// Size: 0x84
function gunship_startengineblowoutfx()
{
    level endon( "missionfailed" );
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.leftwingfxent setscriptablepartstate( "body_damage_heavy", "on" );
    randomwait = randomfloatrange( 0.5, 1 );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.rightwingfxent setscriptablepartstate( "body_damage_heavy", "on" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xeadc
// Size: 0x5e
function gunship_crash( var_6fcc6072244f528d, gunner )
{
    self notify( "crashing" );
    self.crashed = 1;
    
    if ( !istrue( level.gunship_only ) )
    {
        self show();
        
        if ( !istrue( level.gunship_nolights ) )
        {
            gunship_linklightfxent();
        }
        
        gunship_linkwingfxents();
    }
    
    thread gunship_movetocrashpos( var_6fcc6072244f528d );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xeb42
// Size: 0x190
function gunship_returnplayer( player )
{
    level callback::callback( "killstreak_finish_use", { #streakinfo:self.streakinfo } );
    
    if ( isdefined( player ) )
    {
        thirdpersoncam = 0;
        
        /#
            thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        #/
        
        if ( !thirdpersoncam )
        {
            player gunship_stopshellshock();
            player gunship_allowstances( 1 );
        }
        
        level notify( "stop_gunship" );
        player setclientomnvar( "ui_killstreak_weapon", 0 );
        player setclientomnvar( "ui_killstreak_thermal_mode", 0 );
        player setclientomnvar( "ui_killstreak_controls", 0 );
        player lerpfovscalefactor( 1, 0 );
        player modifybasefov( 65, 0.05 );
        player setclientomnvar( "ui_hide_hud", 0 );
        player disableslowaim();
        player function_e851921f869b27e9( 0 );
        player stoploopsound();
        player clearclienttriggeraudiozone( 0.5 );
        player clearsoundsubmix( "iw9_sp_ac130_no_npc_weap" );
        player gunship_stopshellshock();
        thread scripts\sp\art::setdoftracerange( 4096 );
        player val::reset_all( "gunship" );
        player clearcinematicmotionoverride();
        player.usinggunship = undefined;
        
        if ( getdvarint( @"camera_thirdperson" ) )
        {
        }
        
        /#
            if ( thirdpersoncam )
            {
                self.streakinfo notify( "<dev string:x73>" );
            }
        #/
        
        player unlink();
        
        if ( isdefined( player.gunship_cloudsfx ) )
        {
            player.gunship_cloudsfx delete();
        }
    }
    
    if ( isdefined( level.gunship_intromodel ) )
    {
        level.gunship_intromodel delete();
    }
    
    level.gunshipinuse = 0;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xecda
// Size: 0xb8
function gunship_allowstances( boolean )
{
    if ( !istrue( boolean ) )
    {
        self.gunship_disabledstances = [];
        currentstance = self getstance();
        
        switch ( currentstance )
        {
            case #"hash_c6775c88e38f7803":
                self.gunship_disabledstances = [ "crouch", "prone" ];
                break;
            case #"hash_3fed0cbd303639eb":
                self.gunship_disabledstances = [ "stand", "prone" ];
                break;
            case #"hash_d91940431ed7c605":
                self.gunship_disabledstances = [ "stand", "crouch" ];
                break;
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xed9a
// Size: 0x33d
function gunship_movetocrashpos( var_6fcc6072244f528d )
{
    self stoploopsound();
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "off" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "off" );
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self unlink();
    self.scenenode = spawn( "script_model", self.origin );
    self.scenenode setmodel( "tag_origin" );
    self.scenenode.angles = vectortoangles( anglestoforward( self.angles ) );
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "off" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "off" );
    self.leftwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
    self.rightwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
    crashmodel = spawn( "script_model", self.origin );
    crashmodel setmodel( "ks_gunship_mp_mesh" );
    crashmodel.angles = self.angles;
    crashmodel.animname = self.streakinfo.streakname;
    crashmodel scripts\common\anim::setanimtree();
    explosionfxent = spawn( "script_model", self.origin );
    explosionfxent setmodel( "ks_gunship_mp" );
    explosionfxent.angles = self.angles;
    explosionfxent linkto( crashmodel, "tag_body", ( 0, 0, -10 ), ( 0, 0, 0 ) );
    
    /#
    #/
    
    crashpart = "crash_air";
    explosionfxent setscriptablepartstate( crashpart, "on", 0 );
    crashmodel thread gunship_crash_audio();
    thread gunship_crashexplosionscreenshake( level.gunship_crashanimlength );
    thread gunship_crashexplosionradiostatic( level.gunship_crashanimlength );
    self linkto( crashmodel, "tag_body" );
    blendtime = 2;
    level.player playrumbleonentity( "grenade_rumble" );
    level.player playerlinktoblend( self.camera, "tag_player", blendtime, 0.5 * blendtime, 0.5 * blendtime );
    level.player.rumble_ent = get_rumble_ent();
    level.player.rumble_ent.intensity = 0;
    level.player.rumble_ent thread rumble_ramp_to( 0.4, 5 );
    wait 0.4;
    self.scenenode scripts\common\anim::anim_single_solo( crashmodel, "gunship_death", undefined );
    self.scenenode delete();
    gunship_removeplane( 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf0df
// Size: 0x9b
function gunship_restoreplayerweapon( streakinfo )
{
    self endon( "disconnect" );
    streakinfo notify( "killstreak_finished_with_deploy_weapon" );
    
    if ( isalive( self ) )
    {
        val::set( "gunship", "fire", 0 );
        self takeallweapons();
        wait 0.05;
        
        if ( isdefined( self.lastdroppableweaponobj ) )
        {
            self giveweapon( self.lastdroppableweaponobj );
            self switchtoweapon( self.lastdroppableweaponobj );
        }
        
        wait 0.767;
        self takeweapon( level.gunship.deployweaponobj );
        val::reset_all( "gunship" );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xf182
// Size: 0x3c
function gunship_crash_audio()
{
    waitframe();
    
    if ( isent( self ) )
    {
        self playsound( "iw8_ks_ac130_explo_main" );
        self playsound( "iw8_ks_ac130_explo_low_02" );
        self playsound( "iw8_ks_ac130_shake_explo" );
        self playsound( "iw8_ks_ac130_whine" );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xf1c6
// Size: 0xf
function gunship_delayhide()
{
    wait 0.05;
    self hide();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf1dd
// Size: 0x86
function gunship_crashexplosionscreenshake( delaytime )
{
    var_14b1d0692795af2f = delaytime - 2;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player earthquakeforplayer( 0.25, 2, self.origin, 30000 );
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf26b
// Size: 0x1a
function gunship_crashexplosionradiostatic( delaytime )
{
    var_849b0d6d79487d19 = delaytime - 3;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf28d
// Size: 0xbc
function gunship_removeplane( wasdestroyed )
{
    if ( isdefined( self.camera ) )
    {
        self.camera delete();
    }
    
    if ( isdefined( self.leftwingfxent ) )
    {
        self.leftwingfxent delete();
    }
    
    if ( isdefined( self.rightwingfxent ) )
    {
        self.rightwingfxent delete();
    }
    
    if ( isdefined( self.lightfxent ) )
    {
        self.lightfxent delete();
    }
    
    if ( isdefined( self.minimapid ) )
    {
        self.minimapid = undefined;
    }
    
    if ( isdefined( self.streakinfo ) )
    {
        self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    }
    
    self delete();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf351
// Size: 0x29
function gunship_watchtimeout( gunner )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    thread gunship_leave( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf382
// Size: 0x31
function gunship_watchgameend( gunner )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    level waittill( "game_ended" );
    thread gunship_leave( gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf3bb
// Size: 0x98
function gunship_leave( gunner )
{
    self endon( "death" );
    self endon( "crashing" );
    self notify( "leaving" );
    self unlink();
    self rotateroll( 30, 3 );
    currentangles = self.angles;
    currentdir = anglestoforward( currentangles );
    gunship_returnplayer( gunner );
    self moveto( self.origin + currentdir * 50000, 10, 5 );
    gunship_waittilldestination( self.origin + currentdir * 50000 );
    gunship_removeplane( 0 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf45b
// Size: 0x23
function gunship_waittilldestination( destination )
{
    while ( isdefined( self ) && self.origin != destination )
    {
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0xf486
// Size: 0x37
function gunship_watchownerexitaction( gunner, exitaction )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    gunner waittill( exitaction );
    thread gunship_crash( 8, gunner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf4c5
// Size: 0x28
function gunship_watchendgame( gunner )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    level waittill( "game_ended" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf4f5
// Size: 0xa9
function gunship_playpilotfx( pilot )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    pilot.gunship_cloudsfx = spawn( "script_model", pilot getvieworigin() );
    pilot.gunship_cloudsfx setmodel( "tag_origin" );
    pilot.gunship_cloudsfx linkto( pilot );
    waitframe();
    playfxontagforclients( getfx( "clouds" ), pilot.gunship_cloudsfx, "tag_origin", pilot );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xf5a6
// Size: 0x20
function gunship_linklightfxent()
{
    self endon( "death" );
    wait 0.05;
    self setscriptablepartstate( "lights2", "on" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xf5ce
// Size: 0x1be
function gunship_linkwingfxents()
{
    self endon( "death" );
    wait 0.05;
    var_633eaa5f21008b6f = self gettagorigin( "tag_left_outer_prop" );
    self.leftwingfxent = spawn( "script_model", var_633eaa5f21008b6f );
    self.leftwingfxent setmodel( "ks_gunship_mp" );
    self.leftwingfxent.angles = self.angles;
    self.leftwingfxent setotherent( self.owner );
    self.leftwingfxent linkto( self, "tag_left_outer_prop", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.leftwingfxent dontcastshadows();
    self.leftwingfxent dontcastdistantshadows();
    self.leftwingfxent hide();
    var_3eacd3938ccd4b6c = self gettagorigin( "tag_right_outer_prop" );
    self.rightwingfxent = spawn( "script_model", var_3eacd3938ccd4b6c );
    self.rightwingfxent setmodel( "ks_gunship_mp" );
    self.rightwingfxent.angles = self.angles;
    self.rightwingfxent setotherent( self.owner );
    self.rightwingfxent linkto( self, "tag_right_outer_prop", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.rightwingfxent dontcastshadows();
    self.rightwingfxent dontcastdistantshadows();
    self.rightwingfxent hide();
    self setscriptablepartstate( "contrails", "on" );
}

/#

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 1
    // Checksum 0x0, Offset: 0xf794
    // Size: 0x46, Type: dev
    function function_9a76988758d4b96d( wingfxent )
    {
        self endon( "<dev string:xfc>" );
        
        while ( true )
        {
            sphere( wingfxent.origin, 100, ( 1, 0, 0 ), 0, 1 );
            wait 0.05;
        }
    }

#/

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf7e2
// Size: 0x38
function gunship_monitormanualplayerexit( owner )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    owner endon( "disconnect" );
    self waittill( "killstreakExit" );
    thread gunship_leave( owner );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf822
// Size: 0x80
function gunship_trackvelocity( gunner )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        self.lastorigin = self.origin;
        wait level.framedurationseconds;
        self.velocity = ( self.origin - self.lastorigin ) / level.framedurationseconds;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf8aa
// Size: 0x105
function gunship_watchtargets( gunner )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    
    while ( true )
    {
        visibletargets = [];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || !isalive( player ) )
            {
                continue;
            }
            
            if ( self.owner worldpointinreticle_circle( player.origin, 80, 100 ) )
            {
                if ( level.teambased && player.team == self.team )
                {
                    continue;
                }
                
                if ( player == self.owner )
                {
                    continue;
                }
                
                visibletargets = gunship_getnearbytargets( player );
                break;
            }
            
            wait 0.05;
        }
        
        wait randomintrange( 5, 15 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xf9b7
// Size: 0xc7
function gunship_getnearbytargets( maintarget )
{
    var_69338ca0bf9d8d91 = utility::playersinsphere( maintarget.origin, 300 );
    nearbytargets = [];
    
    foreach ( player in var_69338ca0bf9d8d91 )
    {
        if ( level.teambased && player.team != maintarget.team )
        {
            continue;
        }
        
        if ( !level.teambased && player == self.owner )
        {
            continue;
        }
        
        nearbytargets[ nearbytargets.size ] = player;
    }
    
    return nearbytargets;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xfa87
// Size: 0x89
function gunship_watchkills( gunner )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    
    while ( true )
    {
        self.owner waittill( "update_rapid_kill_buffered", recentkills, weaponname );
        
        if ( isdefined( self.owner.recentkillcount ) )
        {
            if ( self.owner.recentkillcount >= 1 && gunship_iskillstreakweapon( weaponname ) )
            {
            }
        }
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xfb18
// Size: 0x61
function gunship_iskillstreakweapon( weaponname )
{
    return ter_op( isdefined( weaponname ) && ( weaponname == level.gunship.var_d6604e5e3d0ba3b7 || weaponname == level.gunship.var_d6604d5e3d0ba184 || weaponname == level.gunship.var_d660505e3d0ba81d ), 1, 0 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4
// Checksum 0x0, Offset: 0xfb82
// Size: 0x12e
function gunship_handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            missiletarget thread gunship_playflaresfx( fxtagoverride );
            newtarget = undefined;
            self missile_settargetent( newtarget );
            self notify( "missile_pairedWithFlare" );
            return;
        }
        else if ( curdist < 300 && missiletarget.flaresreservecount <= 0 )
        {
            missiletarget thread gunship_playfakebodyexplosion();
            missiledamage = weapongetdamagemax( self.weapon_name );
            
            if ( isdefined( self.owner ) )
            {
                missiletarget dodamage( missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name );
            }
            
            self delete();
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0xfcb8
// Size: 0x6d
function gunship_playflaresfx( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    self playsound( "ks_ac130_flares" );
    playfxontag( getfx( "gunship_flares" ), self, flarestag );
    flaresgroup = self.flaresreservecount + 1;
    self setscriptablepartstate( "fake_flares_" + flaresgroup, "on", 0 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0xfd2d
// Size: 0x83
function gunship_playfakebodyexplosion()
{
    if ( !isdefined( self.missileexplcounter ) )
    {
        self.missileexplcounter = 0;
    }
    
    self.missileexplcounter++;
    
    if ( self.missileexplcounter > 4 )
    {
        self.missileexplcounter = 0;
    }
    
    self setscriptablepartstate( "fake_missile_expl_" + self.missileexplcounter, "on", 0 );
    self playsound( "iw8_ks_ac130_dist_rkt_explo" );
    wait 2;
    self setscriptablepartstate( "fake_missile_expl_" + self.missileexplcounter, "off", 0 );
}

/#

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 0
    // Checksum 0x0, Offset: 0xfdb8
    // Size: 0xd9, Type: dev
    function gunship_watchplanedistance()
    {
        self endon( "<dev string:xfc>" );
        self.owner endon( "<dev string:x102>" );
        self.owner endon( "<dev string:x11e>" );
        
        while ( true )
        {
            trace = scripts\engine\trace::ray_trace( self.origin, self.origin - ( 0, 0, 40000 ), self );
            line( self.origin, trace[ "<dev string:xdd>" ], ( 1, 1, 1 ), 1, 0, 1 );
            sphere( level.gunship.origin, 200, ( 1, 1, 1 ), 0, 1 );
            iprintlnbold( "<dev string:x13b>" + distance( self.origin, trace[ "<dev string:xdd>" ] ) );
            waitframe();
        }
    }

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 2
    // Checksum 0x0, Offset: 0xfe99
    // Size: 0x116, Type: dev
    function watchdebuglocation( tagname, showaxis )
    {
        self endon( "<dev string:xfc>" );
        
        while ( true )
        {
            debuglocation = self.origin;
            
            if ( isdefined( tagname ) )
            {
                debuglocation = self gettagorigin( tagname );
            }
            
            sphere( debuglocation, 100, ( 1, 1, 1 ), 0, 1 );
            
            if ( istrue( showaxis ) )
            {
                testforward = anglestoforward( self.angles );
                testright = anglestoright( self.angles );
                testup = anglestoup( self.angles );
                line( debuglocation, debuglocation + testforward * 1000, ( 1, 0, 0 ), 1, 0, 1 );
                line( debuglocation, debuglocation + testright * 1000, ( 0, 1, 0 ), 1, 0, 1 );
                line( debuglocation, debuglocation + testup * 1000, ( 0, 0, 1 ), 1, 0, 1 );
            }
            
            wait 0.05;
        }
    }

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 0
    // Checksum 0x0, Offset: 0xffb7
    // Size: 0x198, Type: dev
    function function_45ad456c933cbb32()
    {
        self endon( "<dev string:xfc>" );
        self endon( "<dev string:x146>" );
        self endon( "<dev string:x14e>" );
        self.owner notifyonplayercommand( "<dev string:x102>", "<dev string:x157>" );
        self.owner notifyonplayercommand( "<dev string:x11e>", "<dev string:x161>" );
        
        if ( getdvarint( @"hash_80478c6f0f12492a" ) )
        {
            weaponstocycle = [ level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604e5e3d0ba3b7 ];
        }
        else
        {
            weaponstocycle = [ level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604f5e3d0ba5ea ];
        }
        
        currentdebugweaponindex = 0;
        currentdebugweapon = weaponstocycle[ 0 ];
        
        while ( true )
        {
            result = self.owner waittill_any_return( "<dev string:x102>", "<dev string:x11e>" );
            
            if ( !isdefined( result ) )
            {
                waitframe();
                continue;
            }
            
            if ( result == "<dev string:x102>" )
            {
                currentdebugweaponindex++;
                
                if ( currentdebugweaponindex > 2 )
                {
                    currentdebugweaponindex = 0;
                }
                
                currentdebugweapon = weaponstocycle[ currentdebugweaponindex ];
                iprintlnbold( "<dev string:x16c>" + currentdebugweapon );
                continue;
            }
            
            shotgoal = gunship_getshotgoal( self.owner );
            thread function_4f101b253c661e40( shotgoal, currentdebugweapon );
        }
    }

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 1
    // Checksum 0x0, Offset: 0x10157
    // Size: 0x15, Type: dev
    function gunship_getfiretime( weapon )
    {
        return weaponfiretime( weapon );
    }

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 1
    // Checksum 0x0, Offset: 0x10174
    // Size: 0xaf, Type: dev
    function gunship_getshotgoal( owner )
    {
        content = [ "<dev string:x187>", "<dev string:x1a0>", "<dev string:x1bc>", "<dev string:x1d2>" ];
        contentoverride = physics_createcontents( content );
        starttrace = owner getvieworigin();
        endtrace = starttrace + anglestoforward( owner getplayerangles() ) * 50000;
        trace = scripts\engine\trace::ray_trace( starttrace, endtrace, level.characters, contentoverride );
        endpos = trace[ "<dev string:xdd>" ];
        return endpos;
    }

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 2
    // Checksum 0x0, Offset: 0x1022b
    // Size: 0x126, Type: dev
    function function_4f101b253c661e40( shotgoal, currentdebugweapon )
    {
        self endon( "<dev string:xfc>" );
        self endon( "<dev string:x146>" );
        self endon( "<dev string:x14e>" );
        self.owner endon( "<dev string:x102>" );
        self.owner endon( "<dev string:x11e>" );
        
        while ( true )
        {
            sphere( shotgoal, 10, ( 1, 1, 0 ), 0, 60 );
            iprintlnbold( "<dev string:x1ea>" + currentdebugweapon + "<dev string:x1f2>" + shotgoal );
            ammoleft = weaponmaxammo( currentdebugweapon );
            
            while ( ammoleft > 0 )
            {
                var_e84b952249e4abe = undefined;
                projectile = magicbullet( makeweapon( currentdebugweapon ), self.origin, var_e84b952249e4abe, self.owner );
                self.owner thread gunship_watchweaponimpact( projectile );
                ammoleft--;
                
                if ( ammoleft == 0 )
                {
                    wait 1;
                    reloadtimer = level.weaponreloadtime[ currentdebugweapon ];
                    
                    while ( reloadtimer > 0 )
                    {
                        iprintlnbold( "<dev string:x1f7>" + currentdebugweapon );
                        reloadtimer--;
                        wait 1;
                    }
                }
                
                wait gunship_getfiretime( currentdebugweapon );
            }
        }
    }

#/

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 5
// Checksum 0x0, Offset: 0x10359
// Size: 0x1ad
function gunship_shellshock( name, category, duration, animationresponse, interruptdelayms )
{
    assertex( isdefined( level.shockpriorities ), "_shellShock called before shellshock_utility::init()" );
    assertex( array_contains( getarraykeys( level.shockpriorities ), category ), "_shellShock called with an invalid category.  Valid categories are top, flash, stun, gas, explosion, damage, and bottom." );
    
    if ( !isdefined( interruptdelayms ) )
    {
        assertex( isdefined( level.shockinterruptdelayfuncs[ category ] ), "could not find an interrupt delay func for cagetory: " + category + "." );
        interruptdelayms = [[ level.shockinterruptdelayfuncs[ category ] ]]( name, duration );
        assertex( isdefined( interruptdelayms ), "Interrupt delay func for name: " + name + " and cagetory: " + category + " returned undefined." );
    }
    
    var_e1b45ec24abdbe91 = gettime() + interruptdelayms;
    
    if ( category != "top" )
    {
        if ( !val::get( "shellshock" ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( self.shockcategory ) )
    {
        curpriority = level.shockpriorities[ self.shockcategory ];
        newpriority = level.shockpriorities[ category ];
        
        if ( newpriority > curpriority )
        {
            if ( gettime() < self.shockinterrupttime )
            {
                return 0;
            }
        }
        else if ( newpriority == curpriority )
        {
            if ( var_e1b45ec24abdbe91 < self.shockinterrupttime )
            {
                return 0;
            }
        }
    }
    
    self.shockname = name;
    self.shockcategory = category;
    self.shockinterrupttime = var_e1b45ec24abdbe91;
    
    if ( isdefined( animationresponse ) )
    {
        self shellshock( name, duration, animationresponse );
    }
    else
    {
        self shellshock( name, duration );
    }
    
    thread function_636b6dd267b3568f( duration );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x1050e
// Size: 0x39
function function_636b6dd267b3568f( duration )
{
    self endon( "disconnect" );
    self endon( "_stopShellShock" );
    wait duration;
    self.shockname = undefined;
    self.shockcategory = undefined;
    self.shockinterrupttime = undefined;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x1054f
// Size: 0x3d
function gunship_stopshellshock( fromdeath )
{
    self notify( "_stopShellShock" );
    
    if ( !istrue( fromdeath ) )
    {
        self stopshellshock();
    }
    
    self.shockname = undefined;
    self.shockcategory = undefined;
    self.shockinterrupttime = undefined;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x10594
// Size: 0x138
function function_fabfbc51d4f4143e()
{
    level.enableshellshockfunc = &function_b7f910fcce2c5395;
    level.disableshellshockfunc = &function_e873be4b11f159fe;
    level.shockpriorities = [];
    level.shockpriorities[ "top" ] = 0;
    level.shockpriorities[ "flash" ] = 1;
    level.shockpriorities[ "stun" ] = 2;
    level.shockpriorities[ "gas" ] = 3;
    level.shockpriorities[ "explosion" ] = 4;
    level.shockpriorities[ "damage" ] = 4;
    level.shockpriorities[ "bottom" ] = 5;
    level.shockinterruptdelayfuncs[ "top" ] = &function_dc1573f5b7297fd9;
    level.shockinterruptdelayfuncs[ "flash" ] = &function_c3186a5aad41bb6d;
    level.shockinterruptdelayfuncs[ "stun" ] = &function_7888d883b6281595;
    level.shockinterruptdelayfuncs[ "gas" ] = &function_e1ac663c7226f51a;
    level.shockinterruptdelayfuncs[ "explosion" ] = &function_dc1573f5b7297fd9;
    level.shockinterruptdelayfuncs[ "damage" ] = &function_6119c3083fab37c0;
    level.shockinterruptdelayfuncs[ "bottom" ] = &function_f4357f0124375502;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x106d4
// Size: 0x2
function function_b7f910fcce2c5395()
{
    
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x106de
// Size: 0xf
function function_e873be4b11f159fe()
{
    gunship_stopshellshock( isalive( self ) );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x106f5
// Size: 0x18
function function_dc1573f5b7297fd9( name, duration )
{
    return 250;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x10716
// Size: 0x52
function function_c3186a5aad41bb6d( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case #"hash_d072a0adddda0068":
            break;
        default:
            assertmsg( "shellshock_flashInterruptDelayFunc called with an invalid name." );
            break;
    }
    
    return interruptdelay;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x10771
// Size: 0x52
function function_7888d883b6281595( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case #"hash_34e7a4cd11aed6bc":
            break;
        default:
            assertmsg( "shellshock_stunInterruptDelayFunc called with an invalid name." );
            break;
    }
    
    return interruptdelay;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x107cc
// Size: 0x59
function function_e1ac663c7226f51a( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case #"hash_7cd59e9057f449d":
        case #"hash_7ef263b8ce60aa24":
            break;
        default:
            interruptdelay = function_dc1573f5b7297fd9( duration );
            break;
    }
    
    return interruptdelay;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x1082e
// Size: 0x4d
function function_6119c3083fab37c0( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case #"hash_6f7dfab682794a56":
            break;
        default:
            interruptdelay = function_dc1573f5b7297fd9( duration );
            break;
    }
    
    return interruptdelay;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2
// Checksum 0x0, Offset: 0x10884
// Size: 0x14, Type: bool
function function_f4357f0124375502( name, duration )
{
    return false;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x108a1
// Size: 0x28, Type: bool
function function_d8d75147028f4b37()
{
    if ( level.gunship.var_c5165ac34c605427.shots_fired == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x108d2
// Size: 0x2
function function_8f6f6e7db4c8a53e()
{
    
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x108dc
// Size: 0x3b
function function_4faa16948b77f38()
{
    while ( true )
    {
        waittime = 0.2 + randomfloat( 1 );
        wait waittime;
        level.player playsound( "elm_gunship_constant_rattle_soft" );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x1091f
// Size: 0x3b
function function_a84ea59fe4b6c2bc()
{
    while ( true )
    {
        waittime = 2.5 + randomfloat( 1.5 );
        wait waittime;
        level.player playsound( "elm_gunship_constant_rattle_med" );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x10962
// Size: 0x1f
function function_b3ab43977eb50a88( guy )
{
    level.player playsound( "gunship_transition_into_view_beep" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3
// Checksum 0x0, Offset: 0x10989
// Size: 0x89
function runcruisepredator( thirdperson, var_6f69fef7bf3f4efb, missile_target )
{
    flag_wait( "scriptables_ready" );
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) )
        {
            thread utility::draw_line_for_time( missile_target, var_6f69fef7bf3f4efb, 0, 1, 1, 5 );
        }
    #/
    
    missile = function_6a4f3074d5a178ab( var_6f69fef7bf3f4efb, vectortoangles( missile_target - var_6f69fef7bf3f4efb ) );
    level.cruise_missile = missile;
    level.remotemissileinprogress = 1;
    thread cruisepredator_takecontrol( thirdperson, var_6f69fef7bf3f4efb, missile_target, missile );
    return missile;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x10a1b
// Size: 0x8a
function private function_6a4f3074d5a178ab( origin, angles )
{
    origin = default_to( origin, ( 0, 1000, 1000 ) );
    angles = default_to( angles, ( 0, 0, 0 ) );
    playerusinggamepad = self usinggamepad();
    vehicletype = ter_op( playerusinggamepad, "veh_cruise_predator_sp_jup", "veh_cruise_predator_sp_jup" );
    new_missile = spawnvehicle( "wmd_vm_missile_cruise_warhead_sp_jup", "cruisePredator", vehicletype, origin, angles );
    return new_missile;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x10aae
// Size: 0x2d4
function private cruisepredator_takecontrol( thirdperson, var_6f69fef7bf3f4efb, missile_target, missile )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "kill_cruise_missile_scripts" );
    missile endon( "death" );
    missile.cannotbesuspended = 1;
    missile setcandamage( 0 );
    missile setotherent( self );
    missile setentityowner( self );
    missile.team = self.team;
    missile.owner = self;
    missile.lifetime = 10;
    missile setvehicleteam( missile.team );
    fxent = spawn( "script_model", missile gettagorigin( "tag_fx" ) );
    fxent hide();
    fxent.angles = missile gettagangles( "tag_fx" );
    fxent.team = missile.team;
    fxent.owner = missile.owner;
    fxent linkto( missile, "tag_fx" );
    fxent setotherent( self );
    fxent dontinterpolate();
    fxent thread cruisepredator_watchmissileexplosion( missile, self, thirdperson );
    
    if ( !istrue( thirdperson ) )
    {
        missile childthread function_742906810293c8be( self );
        missile thread function_fb8ee9efead0e4af( self );
        missile utility::ent_flag_set( "player_posessed_missile" );
        missile hideallparts();
        missile makeentitysentient( "allies" );
        missile utility::set_attackeraccuracy( 0.1 );
        missile utility::set_maxvisibledist( 20000 );
        threats = getaiarray( "axis" );
        threats = sortbydistance( threats, missile_target );
        
        foreach ( threat in threats )
        {
            if ( i < 5 )
            {
                threat set_favoriteenemy( missile );
            }
            
            threat getenemyinfo( missile );
        }
        
        function_c97038cc19e3b30e( missile );
        self usevehicle( missile, 0 );
        thread function_1fbff0cdadb07d52( missile );
        thread function_1611ffc25cbdfcbf( missile );
        level.player playsound( "scn_strike_missile_flight_start_01_lr" );
        level.missile_soundent = spawn( "script_origin", missile.origin );
        level.missile_soundent delaythread( 0.2, &sound_fade_in, "scn_strike_missile_flight_lp_01_lr", 1, 0.6, 1 );
        level.var_ae17e9e7a0a8e9a = spawn( "script_origin", missile.origin );
        level.var_ae17e9e7a0a8e9a playloopsound( "scn_strike_missile_flight_lp_banking_01_lr" );
        level thread function_bb25d3deb1dda179();
    }
    
    missile vehphys_enablecollisioncallback( 1 );
    missile thread cruisepredator_watchtimer( self );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x10d8a
// Size: 0x585
function function_1fbff0cdadb07d52( missile )
{
    missile endon( "death" );
    level endon( "kill_cruise_missile_scripts" );
    var_3e5265936058aaec = level.gameskill > 1;
    wait 0.2;
    
    if ( !utility::flag( "sam_site_dead" ) )
    {
        utility::display_hint( "player_missile_hint_1", 30, 2, [ level, self, missile ], [ "sam_site_dead", "weapon_switch_pressed", "death" ] );
    }
    else if ( !utility::flag( "player_boosted" ) && level.var_2cb45ce35a881047 < 2 )
    {
        level.var_2cb45ce35a881047++;
        utility::display_hint( "player_missile_hint_boost", 30, 0.5, [ level, self, missile ], [ "player_boosted", "weapon_switch_pressed", "death" ] );
    }
    
    var_4f9fe362e8f6e147 = utility::ter_op( var_3e5265936058aaec, 2, 3 );
    
    if ( level.var_388aee5d184a98d1 < var_4f9fe362e8f6e147 )
    {
        if ( !utility::flag( "jet_1_dead" ) && isdefined( level.jet ) && istrue( self.var_e632849f70a9992a ) )
        {
            utility::display_hint( "player_missile_hint_1", 10, 1, [ level, self, missile ], [ "jet_1_dead", "weapon_switch_pressed", "death" ] );
            level.var_388aee5d184a98d1++;
        }
        else if ( !utility::flag( "vehicle_a_end" ) )
        {
            vehicles = utility::getteamvehiclearray( [ "axis" ] );
            vehicles = array_remove( vehicles, missile );
            
            if ( vehicles.size > 0 )
            {
                utility::display_hint( "player_missile_hint_1", 10, 1, [ level, self, missile ], [ "vehicle_a_end", "weapon_switch_pressed", "death" ] );
                level.var_388aee5d184a98d1++;
            }
        }
    }
    
    utility::waittill_any_3( "weapon_switch_pressed", "reload_pressed", "use_pressed" );
    missile notify( "stop_missileBoundarySystem" );
    
    if ( self isvehicleactive() )
    {
        self leavevehicle( 0, 0 );
    }
    
    thread cruisepredator_returnplayer();
    start = missile.origin;
    end = start + anglestoforward( missile.angles ) * 50000;
    end = trace::ray_trace_detail( start, end, [ self, missile ], level.var_7355e8d4cd2e6b00 )[ "position" ];
    new_missile = magicbullet( "gunship_hellfire_jup_sp", start, end, level.player );
    new_missile thread function_bb9b0bc5ab2cc8ff();
    new_missile.var_872e9fd8a2a204b0 = missile.var_872e9fd8a2a204b0;
    fov = utility::ter_op( var_3e5265936058aaec, 0.999848, 0.999391 );
    range = utility::ter_op( var_3e5265936058aaec, 600, 700 );
    vehicles = utility::getvehiclearray_in_radius( end, range, "axis" );
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) && isdefined( level.gunship ) )
        {
            thread function_3bacb9c6bfe2fc50( end, range, 10 );
        }
    #/
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        vehicles = sortbydistance( vehicles, end );
        
        foreach ( vehicle in vehicles )
        {
            if ( utility::within_fov( new_missile.origin, new_missile.angles, vehicle.origin, fov ) )
            {
                new_missile missile_settargetent( vehicles[ 0 ] );
            }
        }
    }
    
    if ( isdefined( level.jet ) )
    {
        var_3e5265936058aaec = level.gameskill > 1;
        fov = utility::ter_op( var_3e5265936058aaec, 0.999848, 0.999391 );
        range = utility::ter_op( var_3e5265936058aaec, 1000, 1200 );
        dist = distance( end, level.jet.origin );
        
        if ( dist < range && utility::within_fov( new_missile.origin, new_missile.angles, level.jet.origin, fov ) )
        {
            new_missile missile_settargetent( level.jet );
        }
    }
    
    if ( !utility::flag( "sam_site_dead" ) )
    {
        origin = level.sam_site.origin + ( 0, 0, 10 );
        
        if ( utility::within_fov( new_missile.origin, new_missile.angles, origin, 0.999391 ) )
        {
            new_missile missile_settargetpos( origin );
        }
    }
    
    level.var_1250917a0280ae9 = utility::array_removeundefined( level.var_1250917a0280ae9 );
    level.var_1250917a0280ae9 = utility::array_add( level.var_1250917a0280ae9, new_missile );
    thread function_e646a7a0af99030e( new_missile );
    missile thread function_dd9dedb2a8fcfb6f();
    missile vehphys_enablecollisioncallback( 0 );
    level.var_1250917a0280ae9 = utility::array_remove( level.var_1250917a0280ae9, missile );
    missile delete();
    level.cruise_missile = new_missile;
}

/#

    // Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
    // Params 3
    // Checksum 0x0, Offset: 0x11317
    // Size: 0x5e, Type: dev
    function function_3bacb9c6bfe2fc50( origin, radius, time )
    {
        time = default_to( time, 7 );
        time = gettime() + time * 1000;
        
        while ( gettime() < time )
        {
            sphere( origin, radius, ( 1, 0, 0 ) );
            wait 0.05;
        }
    }

#/

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x1137d
// Size: 0x1d
function function_bb9b0bc5ab2cc8ff()
{
    self waittill( "explode", position );
    function_77cd90cfd24a21e7( position );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x113a2
// Size: 0xb1
function function_77cd90cfd24a21e7( start )
{
    end = start - ( 0, 0, 700 );
    endpos = trace::ray_trace_detail( start, end, [ self ], level.var_2470353b1ec44c3b )[ "position" ];
    dist = distance( start, endpos );
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) )
        {
            thread draw_line_for_time( start, endpos, 1, 0, 0, 10 );
        }
    #/
    
    if ( dist >= 700 )
    {
        playfx( utility::getfx( "vfx_player_missile_air" ), start );
        return;
    }
    
    playfx( utility::getfx( "vfx_player_missile" ), start );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x1145b
// Size: 0x4d
function function_742906810293c8be( player )
{
    self endon( "stop_missileBoundarySystem" );
    player endon( "stop_missileBoundarySystem" );
    trigger = getent( "missile_bounds", "targetname" );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    function_4a44f48694127c66( trigger );
    setomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x114b0
// Size: 0xb3
function function_4a44f48694127c66( trigger )
{
    trigger endon( "death" );
    self endon( "death" );
    ent_flag_init( "out_of_bounds" );
    
    while ( true )
    {
        while ( trigger istouching( self ) )
        {
            waitframe();
        }
        
        setomnvar( "ui_out_of_bounds_countdown", 1 );
        start_time = gettime();
        ent_flag_set( "out_of_bounds" );
        
        while ( !trigger istouching( self ) )
        {
            if ( time_has_passed( start_time, 4 ) )
            {
                setomnvar( "ui_out_of_bounds_countdown", 0 );
                scripts\sp\player_death::set_custom_death_quote( 29 );
                scripts\sp\utility::missionfailedwrapper();
                return;
            }
            
            waitframe();
        }
        
        ent_flag_clear( "out_of_bounds" );
        setomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1156b
// Size: 0x4f
function private function_fb8ee9efead0e4af( player )
{
    player endon( "weapon_switch_pressed" );
    player endon( "reload_pressed" );
    player endon( "use_pressed" );
    player endon( "death" );
    player endon( "cruise_missile_finished" );
    level endon( "kill_cruise_missile_scripts" );
    
    while ( true )
    {
        player playrumbleonentity( "viewmodel_xsmall" );
        wait 0.15;
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x115c2
// Size: 0x15d
function function_c97038cc19e3b30e( missile )
{
    thread fade_out( 0 );
    setsaveddvar( @"cg_drawcrosshair", 1 );
    setomnvar( "ui_hide_hud", 0 );
    self freezelookcontrols( 1 );
    val::set( "cruise_missile", "ads", 0 );
    val::set( "cruise_missile", "sprint", 0 );
    utility::flag_set( "pauseCameraFocus" );
    utility::flag_set( "pauseWeaponSwap" );
    self modifybasefov( 30, 0 );
    self lerpfov( 30, 0 );
    self setclientomnvar( "ui_killstreak_controls", 0 );
    waitframe();
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) && isdefined( level.gunship ) )
        {
            thread utility::draw_line_from_ent_for_time( level.gunship.model_ent.camera.focus_ent, level.gunship.origin, 1, 0, 0, 30 );
        }
    #/
    
    self setclientomnvar( "ui_predator_missile", 2 );
    self playrumbleonentity( "damage_heavy" );
    self thermalvisionoff();
    visionsetpain( "gunship_missile_jup_sp", 1 );
    self painvisionon();
    self stoprumble( "viewmodel_xsmall" );
    self stoprumble( "viewmodel_large" );
    thread fade_in( 0.3 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x11727
// Size: 0x175
function private cruisepredator_returnplayer()
{
    level endon( "kill_cruise_missile_scripts" );
    self notify( "stop_missileBoundarySystem" );
    setomnvar( "ui_out_of_bounds_countdown", 0 );
    setsaveddvar( @"cg_drawcrosshair", 0 );
    
    if ( getdvarint( @"hash_94c408c5514d7615", 0 ) == 0 )
    {
        setomnvar( "ui_hide_hud", 1 );
    }
    
    hud_util::fade_out( 0 );
    self setclientomnvar( "ui_predator_missile", 0 );
    utility::flag_clear( "pauseCameraFocus" );
    val::reset_all( "cruise_missile" );
    
    if ( isdefined( level.gunship.model_ent.camera ) )
    {
        self setclientomnvar( "ui_killstreak_controls", 9 );
        self modifybasefov( level.var_fb13600ef005ed60, 0 );
        self lerpfov( level.var_fb13600ef005ed60, 0 );
        level.gunship.model_ent function_ff5b3dbacd9c0cdd( level.player, level.var_18a73555b2329261 );
    }
    
    visionsetpain( "damage_dead" );
    self thermalvisionon();
    self painvisionoff();
    visionsetfadetoblack( "", 0 );
    visionsetnaked( level.gunship.color_vision, 0 );
    wait 0.2;
    self freezelookcontrols( 0 );
    hud_util::fade_in( 0.2 );
    utility::flag_clear( "pauseWeaponSwap" );
    self stoprumble( "viewmodel_xsmall" );
    self stoprumble( "viewmodel_large" );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x118a4
// Size: 0xeb
function function_1611ffc25cbdfcbf( cruise_missile )
{
    level endon( "cruise_missile_explode" );
    level endon( "kill_cruise_missile_scripts" );
    cruise_missile endon( "death" );
    self endon( "weapon_switch_pressed" );
    self endon( "reload_pressed" );
    self endon( "use_pressed" );
    wait 0.5;
    
    while ( function_69631676da7727d9( 1 ) )
    {
        waitframe();
    }
    
    utility::waittill_any( "sprint_pressed", "attack_pressed", "jump_pressed" );
    utility::flag_set( "player_boosted" );
    cruise_missile rcplane_setminspeed( 1000 );
    cruise_missile rcplane_settopspeed( 1000 );
    screenshake( cruise_missile.origin, 0.5, 0.6, 0.2, 1, 0.2, 0.5, 0, 15, 17, 2 );
    self stoprumble( "viewmodel_xsmall" );
    self playrumbleonentity( "viewmodel_large" );
    visionsetnaked( "gunship_missile_jup_sp", 0 );
    self painvisionoff();
    visionsetfadetoblack( "gunship_missile_boost_jup_sp", 1 );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1
// Checksum 0x0, Offset: 0x11997
// Size: 0x4a, Type: bool
function function_69631676da7727d9( timeout )
{
    if ( isdefined( timeout ) )
    {
        self endon( "boost_delay_timeout" );
        childthread notify_delay( "boost_delay_timeout", 1 );
    }
    
    return self attackbuttonpressed() || self attackkeybindpressed() || self jumpbuttonpressed() || self sprintbuttonpressed();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x119ea
// Size: 0x4a6
function private cruisepredator_watchmissileexplosion( missile, rider, thirdperson )
{
    level endon( "kill_cruise_missile_scripts" );
    missile thread function_5523cac72ce288bd();
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) && isdefined( level.gunship ) )
        {
            thread utility::draw_line_from_ent_for_time( missile, level.gunship.model_ent.camera.focus_ent.origin, 0, 0, 1, 20 );
            startingpos = missile.origin;
            starttime = gettime();
        }
    #/
    
    for ( ;; )
    {
        explodeinfo = missile cruisepredator_waittillexplode( "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked" );
        
        /#
            if ( getdvarint( @"hash_b1fa07a51b801b6b", 0 ) )
            {
                if ( explodeinfo.msg == "<dev string:x202>" )
                {
                    surface = physics_getsurfacetypefromflags( explodeinfo.param4 );
                    surfacetype = getsubstr( surface[ "<dev string:x20c>" ], 9 );
                    iprintln( "<dev string:x211>" + surfacetype );
                    goto LOC_00000196;
                }
            }
        #/
        
        break;
    }
    
    missile notify( "stop_trace_thread" );
    missile notify( "stop_missileBoundarySystem" );
    setomnvar( "ui_out_of_bounds_countdown", 0 );
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) && isdefined( level.gunship ) && isdefined( explodeinfo.param5 ) )
        {
            thread utility::draw_line_for_time( explodeinfo.param5, explodeinfo.param5 + ( 0, 0, 1000 ), 0, 1, 1, 10 );
            
            if ( isdefined( startingpos ) && isdefined( starttime ) )
            {
                dist = distance( startingpos, missile.origin );
                currenttime = gettime();
                var_76f99e513a1a6eb4 = ( currenttime - starttime ) / 1000;
                ips = dist / var_76f99e513a1a6eb4;
                mph = ips_to_mph( ips );
                iprintlnbold( "<dev string:x23c>" + dist );
                iprintlnbold( "<dev string:x24e>" + var_76f99e513a1a6eb4 );
                iprintlnbold( "<dev string:x25c>" + mph );
            }
        }
    #/
    
    self unlink();
    missile linkto( self );
    level.remotemissileinprogress = 0;
    flag_clear( "hellfire_missile_alive" );
    
    if ( isdefined( missile.lasttracepos ) )
    {
        var_4c6e175d87ad5b00 = self.origin;
        explodepos = missile.lasttracepos;
        
        /#
            if ( getdvarint( @"hash_64bdd497427343e9", 0 ) )
            {
                thread utility::draw_line_for_time( explodepos, var_4c6e175d87ad5b00, 1, 1, 0, 10 );
            }
        #/
    }
    else
    {
        explodepos = self.origin;
    }
    
    /#
        if ( getdvarint( @"hash_64bdd497427343e9", 0 ) == 1 )
        {
            utility::draw_circle( explodepos, 2000, ( 0, 0, 1 ), 1, 0, 150 );
            utility::draw_circle( explodepos, 1000, ( 1, 0, 0 ), 1, 0, 150 );
            
            if ( isdefined( level.gunship ) )
            {
                thread utility::draw_line_for_time( explodepos, explodepos + ( 0, 0, 1000 ), 1, 1, 0, 10 );
            }
        }
    #/
    
    missile thread cruisepredator_handlevfxstates( explodeinfo );
    missile function_77cd90cfd24a21e7( explodepos );
    missile notify( "cruise_missile_explode", explodepos, explodeinfo );
    level notify( "cruise_missile_explode", explodepos, explodeinfo );
    missile notify( "explode", explodepos, explodeinfo );
    
    if ( isdefined( rider ) && rider isvehicleactive() )
    {
        rider leavevehicle( 0, 0 );
        rider thread cruisepredator_returnplayer();
        
        /#
            if ( getdvarint( @"hash_64bdd497427343e9", 0 ) && isdefined( level.gunship ) )
            {
                thread utility::draw_line_for_time( explodepos, level.gunship.model_ent.camera.focus_ent.origin, 1, 0, 0, 10 );
            }
        #/
        
        if ( !istrue( thirdperson ) )
        {
            rider earthquakeforplayer( 0.3, 3, rider.origin, 100 );
            rider playrumbleonpositionforclient( "artillery_rumble", rider.origin );
        }
        
        rider notify( "cruise_missile_finished" );
    }
    
    missile thread function_dd9dedb2a8fcfb6f();
    missile vehphys_enablecollisioncallback( 0 );
    missile delete();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x11e98
// Size: 0xfe
function function_5523cac72ce288bd()
{
    self endon( "death" );
    self endon( "stop_trace_thread" );
    level endon( "kill_cruise_missile_scripts" );
    
    for ( ;; )
    {
        forward = anglestoforward( self gettagangles( "tag_player" ) );
        start = self gettagorigin( "tag_player" );
        end = start + forward * 100000;
        pos = scripts\engine\trace::ray_trace_detail( start, end, [ self ], level.var_7355e8d4cd2e6b00 )[ "position" ];
        self.lasttracepos = pos;
        dist = distance( pos, self.origin );
        
        if ( dist < 500 )
        {
            self notify( "explode", self.lasttracepos, undefined, undefined, undefined, self.lasttracepos );
        }
        
        /#
            if ( getdvarint( @"hash_64bdd497427343e9", 0 ) )
            {
                thread utility::draw_line_for_time( pos, self.origin, 1, 0, 0, 10 );
            }
        #/
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x11f9e
// Size: 0xb6
function private cruisepredator_handlevfxstates( explodeinfo )
{
    self endon( "death" );
    level endon( "kill_cruise_missile_scripts" );
    self unlink();
    
    if ( !isdefined( explodeinfo ) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_defused" || explodeinfo.msg == "trophy_blocked" )
    {
        wait 0.2;
        self delete();
    }
    
    surfacenormal = explodeinfo.param6;
    self.angles = vectortoangles( surfacenormal );
    wait 1;
    self delete();
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0
// Checksum 0x0, Offset: 0x1205c
// Size: 0x271
function function_dd9dedb2a8fcfb6f()
{
    if ( isdefined( level.missile_soundent ) )
    {
        level.missile_soundent thread sound_fade_and_delete( 0.05, 1 );
    }
    
    if ( isdefined( level.var_c35906d57c41ed60 ) )
    {
        level.var_c35906d57c41ed60 stopsounds();
    }
    
    if ( isdefined( self ) )
    {
        self stopsounds();
    }
    
    if ( isdefined( level.var_ae17e9e7a0a8e9a ) )
    {
        level.var_ae17e9e7a0a8e9a stoploopsound( "scn_strike_missile_flight_lp_banking_01_lr" );
        level.var_ae17e9e7a0a8e9a delaycall( 0.1, &delete );
    }
    
    if ( isdefined( level.var_acdee83aae8eb6ea ) )
    {
        level.var_acdee83aae8eb6ea stoploopsound( "vel_strike_flight_earth_01" );
    }
    
    if ( isdefined( level.var_acdee73aae8eb4b7 ) )
    {
        level.var_acdee73aae8eb4b7 stoploopsound( "vel_strike_flight_earth_02" );
    }
    
    if ( isdefined( level.var_acdee63aae8eb284 ) )
    {
        level.var_acdee63aae8eb284 stoploopsound( "vel_strike_flight_earth_01" );
    }
    
    if ( isdefined( level.var_acdee53aae8eb051 ) )
    {
        level.var_acdee53aae8eb051 stoploopsound( "vel_strike_flight_earth_02" );
    }
    
    if ( isdefined( level.var_acdee43aae8eae1e ) )
    {
        level.var_acdee43aae8eae1e stoploopsound( "vel_strike_flight_earth_01" );
    }
    
    if ( isdefined( level.var_acdee33aae8eabeb ) )
    {
        level.var_acdee33aae8eabeb stoploopsound( "vel_strike_flight_earth_02" );
    }
    
    if ( isdefined( level.var_acdee23aae8ea9b8 ) )
    {
        level.var_acdee23aae8ea9b8 stoploopsound( "vel_strike_flight_earth_01" );
    }
    
    wait 0.1;
    
    if ( isdefined( level.var_c35906d57c41ed60 ) )
    {
        level.var_c35906d57c41ed60 delete();
    }
    
    if ( isdefined( level.missile_soundent ) )
    {
        level.missile_soundent delete();
    }
    
    if ( isdefined( level.var_acdee83aae8eb6ea ) )
    {
        level.var_acdee83aae8eb6ea delete();
    }
    
    if ( isdefined( level.var_acdee73aae8eb4b7 ) )
    {
        level.var_acdee73aae8eb4b7 delete();
    }
    
    if ( isdefined( level.var_acdee63aae8eb284 ) )
    {
        level.var_acdee63aae8eb284 delete();
    }
    
    if ( isdefined( level.var_acdee53aae8eb051 ) )
    {
        level.var_acdee53aae8eb051 delete();
    }
    
    if ( isdefined( level.var_acdee43aae8eae1e ) )
    {
        level.var_acdee43aae8eae1e delete();
    }
    
    if ( isdefined( level.var_acdee33aae8eabeb ) )
    {
        level.var_acdee33aae8eabeb delete();
    }
    
    if ( isdefined( level.var_acdee23aae8ea9b8 ) )
    {
        level.var_acdee23aae8ea9b8 delete();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x122d5
// Size: 0x91
function private function_bb25d3deb1dda179()
{
    level endon( "cruise_missile_explode" );
    level endon( "kill_cruise_missile_scripts" );
    var_97e6ef5ab12263e3 = 0;
    
    while ( true )
    {
        var_374abb46e0e87498 = level.player getplayerangles();
        var_97e6ef5ab12263e3 = ( abs( var_374abb46e0e87498[ 2 ] ) / 27 + var_97e6ef5ab12263e3 + var_97e6ef5ab12263e3 ) / 3;
        
        if ( var_97e6ef5ab12263e3 > 1 )
        {
            var_97e6ef5ab12263e3 = 1;
        }
        
        if ( var_97e6ef5ab12263e3 < 0.02 )
        {
            var_97e6ef5ab12263e3 = 0.02;
        }
        
        if ( isdefined( level.var_ae17e9e7a0a8e9a ) )
        {
            level.var_ae17e9e7a0a8e9a scalevolume( var_97e6ef5ab12263e3, 0.05 );
        }
        
        waitframe();
    }
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1236e
// Size: 0x25
function private cruisepredator_delaymissilecollision()
{
    self endon( "death" );
    self endon( "cruise_missile_explode" );
    wait 0.75;
    self vehphys_enablecollisioncallback( 1 );
    wait 1.25;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1239b
// Size: 0x2d
function private cruisepredator_watchtimer( rider )
{
    self endon( "death" );
    level endon( "kill_cruise_missile_scripts" );
    wait 10;
    self notify( "explode", self.origin );
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x123d0
// Size: 0x1ae
function private cruisepredator_waittillexplode( var_e127af0eab592c1a, var_e127ae0eab5929e7, var_e127ad0eab5927b4, var_e127ac0eab592581, var_e127ab0eab59234e, var_e127aa0eab59211b )
{
    ent = spawnstruct();
    
    if ( isdefined( var_e127af0eab592c1a ) )
    {
        thread waittill_explodestring( var_e127af0eab592c1a, ent );
    }
    
    if ( isdefined( var_e127ae0eab5929e7 ) )
    {
        thread waittill_explodestring( var_e127ae0eab5929e7, ent );
    }
    
    if ( isdefined( var_e127ad0eab5927b4 ) )
    {
        thread waittill_explodestring( var_e127ad0eab5927b4, ent );
    }
    
    if ( isdefined( var_e127ac0eab592581 ) )
    {
        thread waittill_explodestring( var_e127ac0eab592581, ent );
    }
    
    if ( isdefined( var_e127ab0eab59234e ) )
    {
        thread waittill_explodestring( var_e127ab0eab59234e, ent );
    }
    
    if ( isdefined( var_e127aa0eab59211b ) )
    {
        thread waittill_explodestring( var_e127aa0eab59211b, ent );
    }
    
    ent waittill( "returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    ent notify( "die" );
    explodeinfo = spawnstruct();
    explodeinfo.msg = msg;
    explodeinfo.param1 = param1;
    explodeinfo.param2 = param2;
    explodeinfo.param3 = param3;
    explodeinfo.param4 = param4;
    explodeinfo.param5 = param5;
    explodeinfo.param6 = param6;
    explodeinfo.param7 = param7;
    explodeinfo.param8 = param8;
    return explodeinfo;
}

// Namespace namespace_fd9c6daa1372e62b / namespace_9aa8702eecc5eb3
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x12587
// Size: 0x7a
function private waittill_explodestring( msg, ent )
{
    self endon( "death" );
    ent endon( "die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( "returned", msg, param1, param2, param3, param4, param5, param6 );
}

