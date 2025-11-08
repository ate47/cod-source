#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_build;
#using scripts\engine\utility;

#namespace veh9_mil_air_heli_hind;

// Namespace veh9_mil_air_heli_hind / scripts\vehicle\veh9_mil_air_heli_hind
// Params 3
// Checksum 0x0, Offset: 0x1bc
// Size: 0x135
function main( model, type, classname )
{
    build_template( "hind", model, type, classname );
    build_localinit( &init_local );
    build_deathmodel( "veh9_mil_air_heli_hind_vehphys_sp" );
    build_deathfx( "vfx/core/expl/grenadeexp_default.vfx", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined );
    build_deathfx( "vfx/core/expl/grenadeexp_default.vfx", "tail_rotor_jnt", undefined, undefined, undefined, undefined, 0.5, 1, undefined );
    build_deathfx( "vfx/core/expl/fire_smoke_trail_l.vfx", "tag_engine_left", undefined, undefined, undefined, 1, 0.5, 1, undefined );
    build_radiusdamage( ( 0, 0, 0 ), 500, 120, 20 );
    build_treadfx();
    build_treadfx( classname, "default", "vfx/code/tread/heli_dust_default.vfx", 1 );
    build_life( 3000, 2800, 3100 );
    build_team( "allies" );
    build_aianims( &setanims, &set_vehicle_anims, "blima" );
    randomstartdelay = randomfloatrange( 0, 1 );
    build_unload_groups( &unload_groups );
    build_bulletshield( 1 );
    build_is_helicopter();
}

// Namespace veh9_mil_air_heli_hind / scripts\vehicle\veh9_mil_air_heli_hind
// Params 0
// Checksum 0x0, Offset: 0x2f9
// Size: 0x67
function init_local()
{
    self.unload_hover_offset = 570;
    self.unload_land_offset = 165;
    self.script_badplace = 0;
    
    if ( !scripts\engine\utility::is_equal( self.script_vehicle_lights_off, "running" ) )
    {
        scripts\common\vehicle::vehicle_lights_on( "running" );
    }
    
    self.vehicleanimalias = "blima";
    self.vehiclesetuprope = 1;
    thread handle_scriptable_vfx();
}

// Namespace veh9_mil_air_heli_hind / scripts\vehicle\veh9_mil_air_heli_hind
// Params 0
// Checksum 0x0, Offset: 0x368
// Size: 0x4a
function handle_scriptable_vfx()
{
    self endon( "death" );
    
    if ( utility::issp() || utility::iscp() )
    {
        scripts\engine\utility::flag_wait( "scriptables_ready" );
        self setscriptablepartstate( "engine", "on" );
        self setscriptablepartstate( "vector_field", "on" );
    }
}

// Namespace veh9_mil_air_heli_hind / scripts\vehicle\veh9_mil_air_heli_hind
// Params 0
// Checksum 0x0, Offset: 0x3ba
// Size: 0x31
function setanims()
{
    positions = [];
    
    for ( i = 0; i < 10 ; i++ )
    {
        positions[ i ] = spawnstruct();
    }
    
    return positions;
}

// Namespace veh9_mil_air_heli_hind / scripts\vehicle\veh9_mil_air_heli_hind
// Params 1
// Checksum 0x0, Offset: 0x3f4
// Size: 0xb
function set_vehicle_anims( positions )
{
    
}

// Namespace veh9_mil_air_heli_hind / scripts\vehicle\veh9_mil_air_heli_hind
// Params 0
// Checksum 0x0, Offset: 0x407
// Size: 0xf
function unload_groups()
{
    unload_groups = [];
    return unload_groups;
}

