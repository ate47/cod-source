#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_build;
#using scripts\engine\utility;

#namespace veh9_mil_air_heli_medium;

#using_animtree( "vehicles" );

// Namespace veh9_mil_air_heli_medium / scripts\vehicle\veh9_mil_air_heli_medium
// Params 3
// Checksum 0x0, Offset: 0x3a1
// Size: 0x253
function main( model, type, classname )
{
    build_template( "heli_medium", model, type, classname );
    build_localinit( &init_local );
    build_deathmodel( "veh9_mil_air_heli_medium_vehphys_sp" );
    build_radiusdamage( ( 0, 0, 0 ), 500, 120, 20 );
    mapname = getdvar( @"g_mapname" );
    
    switch ( mapname )
    {
        case #"hash_bbef2fceaac6b576":
            build_treadfx( classname, "default", "vfx/iw9/level/prison/heli_prison_default_ch.vfx", 1 );
            break;
        case #"hash_2daf318af0c70342":
            build_treadfx( classname, "default", "vfx/iw9/level/tower/vfx_twr_heli_dust_snow.vfx", 1 );
            break;
        default:
            build_treadfx( classname, "default", "vfx/code/tread/heli_dust_default.vfx", 1 );
            break;
    }
    
    build_life( 3000, 2800, 3100 );
    build_team( "allies" );
    build_aianims( &setanims );
    build_unload_groups( &unload_groups );
    randomstartdelay = randomfloatrange( 0, 1 );
    build_light( classname, "blinking_body", "tag_body", "vfx/iw9/veh/scriptables/vfx_veh_medium_bird_blinking_lights", "running", 0 );
    function_2cf37d073c6bde84( classname, "cockpit_red_cargo01", "tag_light_cargo01", "interior", 0 );
    function_2cf37d073c6bde84( classname, "cockpit_red_cargo02", "tag_light_cargo02", "interior", 0 );
    function_2cf37d073c6bde84( classname, "cockpit_blue_cockpit01", "tag_light_cockpit01", "interior", 0.1 );
    function_2cf37d073c6bde84( classname, "white_blink_belly", "tag_light_belly", "running", randomstartdelay );
    function_2cf37d073c6bde84( classname, "red_blink_tail", "tag_light_tail", "running", randomstartdelay );
    function_2cf37d073c6bde84( classname, "wingtip_green", "tag_light_L_wing", "running", randomstartdelay );
    function_2cf37d073c6bde84( classname, "wingtip_red", "tag_light_R_wing", "running", randomstartdelay );
    function_2cf37d073c6bde84( classname, "spot", "tag_passenger", "spot", 0 );
    build_unload_groups( &unload_groups );
    build_bulletshield( 1 );
    build_is_helicopter();
    build_drive( %lbravo_rotors, undefined, 0, 3 );
}

// Namespace veh9_mil_air_heli_medium / scripts\vehicle\veh9_mil_air_heli_medium
// Params 0
// Checksum 0x0, Offset: 0x5fc
// Size: 0x5b
function init_local()
{
    self.unload_hover_offset = 120;
    self.unload_land_offset = 112;
    self.script_badplace = 0;
    
    if ( !scripts\engine\utility::is_equal( self.script_vehicle_lights_off, "running" ) )
    {
        scripts\common\vehicle::vehicle_lights_on( "running" );
    }
    
    self.vehicleanimalias = "veh9_heli_medium";
    thread handle_scriptable_vfx();
}

// Namespace veh9_mil_air_heli_medium / scripts\vehicle\veh9_mil_air_heli_medium
// Params 0
// Checksum 0x0, Offset: 0x65f
// Size: 0x5b
function handle_scriptable_vfx()
{
    self endon( "death" );
    
    if ( utility::issp() || utility::iscp() )
    {
        scripts\engine\utility::flag_wait( "scriptables_ready" );
        self setscriptablepartstate( "engine", "on" );
        self setscriptablepartstate( "Exhaust", "on" );
        self setscriptablepartstate( "NaviLights", "on" );
    }
}

// Namespace veh9_mil_air_heli_medium / scripts\vehicle\veh9_mil_air_heli_medium
// Params 0
// Checksum 0x0, Offset: 0x6c2
// Size: 0x242
function setanims()
{
    positions = [];
    
    for ( i = 0; i < 8 ; i++ )
    {
        positions[ i ] = spawnstruct();
    }
    
    positions[ 0 ].canshootinvehicle = 0;
    positions[ 1 ].canshootinvehicle = 0;
    positions[ 2 ].canshootinvehicle = 1;
    positions[ 3 ].canshootinvehicle = 1;
    positions[ 4 ].canshootinvehicle = 1;
    positions[ 5 ].canshootinvehicle = 1;
    positions[ 6 ].canshootinvehicle = 1;
    positions[ 7 ].canshootinvehicle = 1;
    positions[ 0 ].sittag = "tag_seat_0";
    positions[ 1 ].sittag = "tag_seat_1";
    positions[ 2 ].sittag = "tag_seat_2";
    positions[ 3 ].sittag = "tag_seat_3";
    positions[ 4 ].sittag = "tag_seat_4";
    positions[ 5 ].sittag = "tag_seat_5";
    positions[ 6 ].sittag = "tag_seat_6";
    positions[ 7 ].sittag = "tag_seat_7";
    positions[ 2 ].deathragdoll = 1;
    positions[ 3 ].deathragdoll = 1;
    positions[ 4 ].deathragdoll = 1;
    positions[ 5 ].deathragdoll = 1;
    positions[ 6 ].deathragdoll = 1;
    positions[ 7 ].deathragdoll = 1;
    positions[ 0 ].death_impulse = 1;
    positions[ 1 ].death_impulse = 1;
    positions[ 2 ].death_impulse = 1;
    positions[ 3 ].death_impulse = 1;
    positions[ 4 ].death_impulse = 1;
    positions[ 5 ].death_impulse = 1;
    positions[ 6 ].death_impulse = 1;
    positions[ 7 ].death_impulse = 1;
    return positions;
}

// Namespace veh9_mil_air_heli_medium / scripts\vehicle\veh9_mil_air_heli_medium
// Params 1
// Checksum 0x0, Offset: 0x90d
// Size: 0xb
function set_vehicle_anims( positions )
{
    
}

// Namespace veh9_mil_air_heli_medium / scripts\vehicle\veh9_mil_air_heli_medium
// Params 0
// Checksum 0x0, Offset: 0x920
// Size: 0xd4
function unload_groups()
{
    unload_groups = [];
    unload_groups[ "both" ] = [];
    unload_groups[ "left" ] = [];
    unload_groups[ "right" ] = [];
    unload_groups[ "all" ] = [ 0, 1, 2, 3, 4, 5, 6, 7 ];
    unload_groups[ "both" ] = [ 2, 3, 4, 5, 6, 7 ];
    unload_groups[ "left" ] = [ 2, 3, 4 ];
    unload_groups[ "right" ] = [ 5, 6, 7 ];
    unload_groups[ "default" ] = unload_groups[ "both" ];
    return unload_groups;
}

