#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace vehicle_heavy_destruction;

// Namespace vehicle_heavy_destruction / scripts\sp\vehicle_heavy_destruction
// Params 0
// Checksum 0x0, Offset: 0xb7
// Size: 0x2
function init_vehicle_heavy_destruction()
{
    
}

// Namespace vehicle_heavy_destruction / scripts\sp\vehicle_heavy_destruction
// Params 0
// Checksum 0x0, Offset: 0xc1
// Size: 0x144
function reverse_impact_think()
{
    self endon( "stop_heavy_damage" );
    self setcandamage( 1 );
    back_checks = 1;
    var_10307d8953138b5a = 12;
    contents = scripts\engine\trace::create_all_contents();
    
    while ( true )
    {
        self waittill( "damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon );
        start_point = point;
        end_point = point;
        
        for ( i = 0; i < back_checks ; i++ )
        {
            end_point = start_point + direction_vec * 0.5;
            start_point = end_point + direction_vec * var_10307d8953138b5a;
            color = ( randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ) );
            jku_arrow( start_point, end_point, color, 1, 1, 200, direction_vec );
            magicbullet( "veh_exit_hack", start_point, end_point );
            waitframe();
        }
    }
}

// Namespace vehicle_heavy_destruction / scripts\sp\vehicle_heavy_destruction
// Params 7
// Checksum 0x0, Offset: 0x20d
// Size: 0xa2
function jku_arrow( start, end, color, alpha, depthtest, duration, direction_vec )
{
    setdvarifuninitialized( @"hash_c57da70cd16526c7", 0 );
    
    /#
        if ( getdvarint( @"hash_c57da70cd16526c7" ) == 1 )
        {
            if ( !isdefined( color ) )
            {
                color = ( randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ) );
            }
            
            line( start, end, color, alpha, depthtest, duration );
            line( end, end + anglestoright( direction_vec ) * -2, color, alpha, depthtest, duration );
        }
    #/
}

// Namespace vehicle_heavy_destruction / scripts\sp\vehicle_heavy_destruction
// Params 4
// Checksum 0x0, Offset: 0x2b7
// Size: 0xdc
function jku_point( position, size, color, duration )
{
    setdvarifuninitialized( @"hash_c57da70cd16526c7", 0 );
    
    /#
        if ( getdvarint( @"hash_c57da70cd16526c7" ) == 1 )
        {
            if ( !isdefined( position ) )
            {
                assertmsg( "<dev string:x1c>" );
                return;
            }
            else
            {
                point = position;
            }
            
            if ( !isdefined( size ) )
            {
                size = 6;
            }
            
            if ( !isdefined( color ) )
            {
                color = ( 1, 1, 1 );
            }
            
            if ( !isdefined( duration ) )
            {
                duration = 400;
            }
            
            line( point + ( size, 0, 0 ), point - ( size, 0, 0 ), color, 1, 1, duration );
            line( point + ( 0, size, 0 ), point - ( 0, size, 0 ), color, 1, 1, duration );
            line( point + ( 0, 0, size ), point - ( 0, 0, size ), color, 1, 1, duration );
        }
    #/
}

