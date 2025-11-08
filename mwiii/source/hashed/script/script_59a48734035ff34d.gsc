#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace namespace_d0fc9ba845d3f014;

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 2
// Checksum 0x0, Offset: 0x1d0
// Size: 0x13c
function init( var_c8fe12c76b06111e, activityinstance )
{
    if ( !isdefined( var_c8fe12c76b06111e ) )
    {
        return;
    }
    
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "entless_trap_defuse_object", &function_836cdac4b1d38941 );
    scripts\engine\scriptable::scriptable_adddamagedcallback( &function_2a19c46ce6857095 );
    
    foreach ( trap in var_c8fe12c76b06111e )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( trap.angles ) )
        {
            angles = trap.angles;
        }
        
        trap.var_33e966146e01b39a = trap.origin + anglestoforward( angles ) * 0.5 + anglestoup( angles ) * 3.5;
        trap.var_bb7aa8ce4dd0428f = trap.var_33e966146e01b39a + anglestoleft( angles ) * 200;
        
        if ( isdefined( activityinstance ) )
        {
            trap.activityref = activityinstance;
        }
        
        trap setscriptablepartstate( "entless_trap_defuse_object", "active" );
        trap setscriptablepartstate( "explosive_base", "healthy" );
        trap thread detectplayer();
    }
}

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 0
// Checksum 0x0, Offset: 0x314
// Size: 0x63
function create_laser_trap()
{
    struct = self;
    angles = ( 0, 0, 0 );
    
    if ( isdefined( struct.angles ) )
    {
        angles = struct.angles;
    }
    
    trap = spawnscriptable( "entless_lasertrap", struct.origin, angles );
    return trap;
}

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 6
// Checksum 0x0, Offset: 0x380
// Size: 0x45
function function_836cdac4b1d38941( instance, part, state, player, bautouse, usestring )
{
    if ( part == "entless_trap_defuse_object" )
    {
        function_de1ff0b717ef1a19( instance );
    }
}

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 2
// Checksum 0x0, Offset: 0x3cd
// Size: 0xa3
function function_de1ff0b717ef1a19( var_8b429ec000467dcb, var_130c845ace729a7e )
{
    assert( isdefined( var_8b429ec000467dcb ), "<dev string:x1c>" );
    assert( var_8b429ec000467dcb getscriptablehaspart( "<dev string:x65>" ) );
    current_state = var_8b429ec000467dcb getscriptablepartstate( "entless_trap_defuse_object" );
    
    if ( isdefined( current_state ) && current_state != "disabled" )
    {
        if ( !istrue( var_130c845ace729a7e ) )
        {
            playsoundatpos( var_8b429ec000467dcb.origin, "cp_laser_disable" );
        }
        
        var_8b429ec000467dcb notify( "destroyed" );
        var_8b429ec000467dcb setscriptablepartstate( "entless_trap_defuse_object", "disabled" );
        var_8b429ec000467dcb setscriptablepartstate( "explosive_base", "off" );
    }
}

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 2
// Checksum 0x0, Offset: 0x478
// Size: 0x155
function function_1de2b98e5b1f0590( einflictor, rangeoverride )
{
    instance = self;
    instance notify( "destroyed" );
    instance.destroyed = 1;
    instance setscriptablepartstate( "entless_trap_defuse_object", "disabled" );
    mindamage = getdvarint( @"hash_ea6e58c378d245e5", 133 );
    maxdamage = getdvarint( @"hash_d5ff13fe4588f203", 666 );
    traprange = ter_op( isdefined( rangeoverride ), rangeoverride, getdvarint( @"hash_db8f6fd15e9a7db6", 256 ) );
    waittillframeend();
    attacker = einflictor;
    
    if ( isdefined( instance.activityref ) && isdefined( instance.activityref.agents ) )
    {
        foreach ( agent in instance.activityref.agents )
        {
            if ( isdefined( agent ) )
            {
                attacker = agent;
                break;
            }
        }
    }
    
    radiusdamage( instance.origin, traprange, maxdamage, mindamage, attacker, "MOD_EXPLOSIVE" );
}

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 11
// Checksum 0x0, Offset: 0x5d5
// Size: 0xaf
function function_2a19c46ce6857095( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( !is_equal( instance.type, "entless_lasertrap" ) || istrue( instance.destroyed ) )
    {
        return;
    }
    
    var_a1acf2297da3341f = getdvarint( @"hash_38407fe4a9acdba9", 50 );
    instance thread function_1de2b98e5b1f0590( einflictor, var_a1acf2297da3341f );
}

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 1
// Checksum 0x0, Offset: 0x68c
// Size: 0x69
function trigger_trap( player )
{
    trap = self;
    
    if ( isdefined( player ) && isplayer( player ) )
    {
        if ( player isufo() )
        {
            return 0;
        }
        
        player.var_230a3287f9ad2965 = 1;
        player.shouldskipdeathsshield = 1;
    }
    
    trap setscriptablepartstate( "explosive_base", "explode" );
    trap thread function_1de2b98e5b1f0590( player );
}

// Namespace namespace_d0fc9ba845d3f014 / namespace_c7c8e97cfcdfb1e1
// Params 0
// Checksum 0x0, Offset: 0x6fd
// Size: 0x1b8
function detectplayer()
{
    self notify( "entless_laser_traps_detectPlayer" );
    self endon( "entless_laser_traps_detectPlayer" );
    level endon( "game_ended" );
    self endon( "destroyed" );
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_done" );
    var_4a5d9d7667048bf3 = scripts\engine\trace::create_character_contents();
    var_71fcc381ba289efb = scripts\engine\trace::create_contents( 0, 1, 1, 0, 1, 1 );
    
    while ( true )
    {
        start = self.var_33e966146e01b39a;
        nearby_players = sortbydistancecullbyradius( level.players, start, 1024 );
        
        if ( nearby_players.size == 0 )
        {
            waitframe();
            continue;
        }
        
        trace = scripts\engine\trace::ray_trace( start, self.var_bb7aa8ce4dd0428f, [], var_71fcc381ba289efb );
        
        if ( isdefined( trace[ "entity" ] ) && trace[ "hittype" ] == "hittype_entity" )
        {
            if ( isplayer( trace[ "entity" ] ) )
            {
                player = trace[ "entity" ];
                detonated = trigger_trap( player );
                return;
            }
        }
        
        end = trace[ "position" ];
        
        /#
            if ( getdvarint( @"hash_388b2c9297bbe819", 0 ) != 0 )
            {
                line( start, end, ( 1, 0, 0 ), 1, 0, 1 );
            }
        #/
        
        trace = scripts\engine\trace::ray_trace( start, end, [], var_4a5d9d7667048bf3 );
        
        if ( isdefined( trace[ "entity" ] ) && trace[ "hittype" ] == "hittype_entity" )
        {
            if ( isplayer( trace[ "entity" ] ) )
            {
                player = trace[ "entity" ];
                eyepos = player geteye();
                
                if ( trace[ "position" ][ 2 ] <= eyepos[ 2 ] )
                {
                    detonated = trigger_trap( player );
                    return;
                }
            }
        }
        
        waitframe();
    }
}

