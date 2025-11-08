#using script_f603f40349f99c8;
#using scripts\common\utility;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace namespace_c970f31a41969fea;

// Namespace namespace_c970f31a41969fea / namespace_100d6938f74f57c8
// Params 4
// Checksum 0x0, Offset: 0x137
// Size: 0x202
function function_b5e04289b0ad9ca3( spawn_point_targetname, var_1f0c7a48c4b213eb, var_abba655c1e3dbe89, var_b83f7102d5f03809 )
{
    level endon( "game_ended" );
    
    if ( !isdefined( spawn_point_targetname ) )
    {
        /#
            iprintln( "<dev string:x1c>" );
        #/
        
        return;
    }
    
    spawn_point = getstruct( spawn_point_targetname, "targetname" );
    
    if ( !isdefined( spawn_point ) )
    {
        /#
            iprintln( "<dev string:x46>" );
        #/
        
        return;
    }
    
    spawn_point.var_a4d76f90d6916d81 = 1;
    
    if ( !isdefined( var_1f0c7a48c4b213eb ) )
    {
        /#
            iprintln( "<dev string:x6f>" );
        #/
        
        return;
    }
    
    var_b83f7102d5f03809 = default_to( var_b83f7102d5f03809, "off" );
    var_9600f1c60368f3c4 = getstruct( var_1f0c7a48c4b213eb, "targetname" );
    
    if ( !isdefined( var_9600f1c60368f3c4 ) )
    {
        /#
            iprintln( "<dev string:x98>" );
        #/
        
        return;
    }
    
    heli = namespace_548a10c405703106::function_15cc3579cdac3cfb( spawn_point, -1, undefined, "allies", 0 );
    level.attackheli = heli;
    flag_set( "flag_ally_attack_heli_spawned" );
    
    if ( !isdefined( heli ) )
    {
        /#
            iprintln( "<dev string:xc0>" );
        #/
        
        return;
    }
    
    heli.target_ent = spawn_tag_origin();
    heli setmaxpitchroll( 25, 25 );
    heli vehicle_setspeed( 300, 200 );
    heli sethoverparams( 60, 300, 300 );
    heli setyawspeed( 100, 100, 100, 0.1 );
    heli setturningability( 1 );
    heli setneargoalnotifydist( 50 );
    heli setscriptablepartstate( "blinking_lights", var_b83f7102d5f03809 );
    function_c1150d781d01adc8( heli );
    function_4f0e1fcf2e24ebe8( heli, "allies", 24000, 12000, undefined, 1 );
    heli.patrolstruct = var_9600f1c60368f3c4;
    
    if ( !isdefined( heli.patrolstruct.angles ) )
    {
        heli.patrolstruct.angles = ( 0, 0, 0 );
    }
    
    heli thread function_5ce1d591b960f54e( var_1f0c7a48c4b213eb );
    flag_wait( "flag_ally_attack_heli_reached_patrol_area" );
    wait 4;
    thread function_b2c754e9a9fa71a2( heli, var_abba655c1e3dbe89, 5, 20 );
}

// Namespace namespace_c970f31a41969fea / namespace_100d6938f74f57c8
// Params 1
// Checksum 0x0, Offset: 0x341
// Size: 0x12a
function function_5ce1d591b960f54e( var_1f0c7a48c4b213eb )
{
    heli = self;
    heli endon( "game_ended" );
    heli endon( "end_heli_patrol" );
    heli endon( "death" );
    heli.attack_struct = getstruct( var_1f0c7a48c4b213eb, "targetname" );
    heli setvehgoalpos( heli.attack_struct.origin, 0 );
    heli sethoverparams( 60, 30, 30 );
    heli vehicle_setspeed( 60, 30 );
    current_struct = heli.attack_struct;
    heli.var_5142c6d949df9a4e = 1;
    
    while ( heli.var_5142c6d949df9a4e )
    {
        if ( isdefined( current_struct ) )
        {
            heli setvehgoalpos( current_struct.origin, 0 );
        }
        else
        {
            return;
        }
        
        heli waittill( "goal" );
        
        if ( !flag( "flag_ally_attack_heli_reached_patrol_area" ) )
        {
            flag_set( "flag_ally_attack_heli_reached_patrol_area" );
        }
        
        if ( heli.var_5142c6d949df9a4e )
        {
            current_struct = getstruct( current_struct.target, "targetname" );
            heli sethoverparams( 60, 10, 10 );
            heli vehicle_setspeed( 30, 15 );
        }
    }
}

// Namespace namespace_c970f31a41969fea / namespace_100d6938f74f57c8
// Params 1
// Checksum 0x0, Offset: 0x473
// Size: 0x107
function function_ee9dc585f1b57c21( var_1f0c7a48c4b213eb )
{
    heli = self;
    heli.var_5142c6d949df9a4e = 0;
    heli notify( "end_heli_targeting" );
    heli notify( "end_heli_patrol" );
    heli endon( "game_ended" );
    heli endon( "death" );
    heli.attack_struct = getstruct( var_1f0c7a48c4b213eb, "targetname" );
    heli setvehgoalpos( heli.attack_struct.origin, 0 );
    heli sethoverparams( 60, 30, 30 );
    heli vehicle_setspeed( 60, 30 );
    current_struct = heli.attack_struct;
    
    while ( isdefined( current_struct ) )
    {
        heli setvehgoalpos( current_struct.origin, 0 );
        heli waittill( "goal" );
        
        if ( isdefined( current_struct.target ) )
        {
            current_struct = getstruct( current_struct.target, "targetname" );
            heli sethoverparams( 60, 30, 30 );
            heli vehicle_setspeed( 60, 30 );
        }
    }
}

