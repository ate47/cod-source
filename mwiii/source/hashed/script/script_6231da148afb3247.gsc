#using scripts\common\values;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;

#namespace warrior_beatupthecar;

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 0
// Checksum 0x0, Offset: 0x1ef
// Size: 0x53
function function_1622b20751666c1d()
{
    level.var_6298f362ec23d83.var_840ddb112ace54f3 = [];
    level.modeallowmeleevehicledamage = &modeallowmeleevehicledamage;
    level.var_67d87fafb9aebc8e = getstructarray( "warrior_car", "targetname" );
    thread onplayerspawned();
    thread function_492b4dec632917ec( "warrior_beatupthecar" );
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 0
// Checksum 0x0, Offset: 0x24a
// Size: 0x65
function function_8c0bfe15c3fac89()
{
    level.modeallowmeleevehicledamage = undefined;
    
    foreach ( player in level.players )
    {
        player val::group_reset( "beatupthecar" );
    }
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 0
// Checksum 0x0, Offset: 0x2b7
// Size: 0x73
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player takeallweapons();
        var_2c7733b0cc742f21 = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( "jup_jp23_me_shotel_mp" );
        player giveweapon( var_2c7733b0cc742f21 );
        player setspawnweapon( var_2c7733b0cc742f21 );
        player val::set( "beatupthecar", "vehicle_use", 0 );
        player function_f560b74b0bdcaed6();
    }
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 0
// Checksum 0x0, Offset: 0x332
// Size: 0x11f
function function_f560b74b0bdcaed6()
{
    if ( !istrue( level.var_6298f362ec23d83.var_840ddb112ace54f3[ self.team ] ) )
    {
        spawndata = spawnstruct();
        
        if ( level.var_67d87fafb9aebc8e.size == 3 )
        {
            if ( isdefined( self ) && isalive( self ) )
            {
                cars = sortbydistance( level.var_67d87fafb9aebc8e, self.origin );
                spawndata.origin = cars[ 0 ].origin + ( 0, 0, 16 );
                spawndata.angles = cars[ 0 ].angles;
            }
        }
        else
        {
            assertmsg( "<dev string:x1c>" );
        }
        
        vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh_jup_suv_1996", spawndata );
        vehicle thread function_f644d0ca00a39fac( self.team );
        vehicle thread function_790fe4a541aaf2e9( self.team );
        level.var_6298f362ec23d83.var_840ddb112ace54f3[ self.team ] = 1;
    }
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 1
// Checksum 0x0, Offset: 0x459
// Size: 0xc8
function function_f644d0ca00a39fac( team )
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    var_c217f255028505d5 = 3.5;
    
    while ( true )
    {
        self waittill( "damage", damage, attacker );
        
        if ( isdefined( attacker ) && isdefined( team ) && isplayer( attacker ) && attacker.team == team )
        {
            time = gettime();
            
            if ( !isdefined( attacker.var_fed459309698115d ) || ( time - attacker.var_fed459309698115d ) / 1000 >= var_c217f255028505d5 )
            {
                attacker.var_fed459309698115d = time;
                attacker thread scripts\mp\utility\points::doscoreevent( #"hash_9dc9fc0c7f353a" );
            }
        }
    }
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 1
// Checksum 0x0, Offset: 0x529
// Size: 0x38
function function_790fe4a541aaf2e9( team )
{
    level endon( "warrior_beatupthecar_complete" );
    self waittill( "death" );
    thread scripts\mp\gamelogic::endgame( team, game[ "end_reason" ][ "objective_completed" ] );
    level notify( "warrior_beatupthecar_complete" );
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 3
// Checksum 0x0, Offset: 0x569
// Size: 0x43
function function_1d85758902f3471( winner, endreasontext, nukedetonated )
{
    setscore = 0;
    
    if ( winner != "tie" )
    {
        scripts\mp\gamescore::giveteamscoreforobjective( winner, 1, 1 );
        setscore = 1;
    }
    
    return setscore;
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5b5
// Size: 0xd, Type: bool
function private modeallowmeleevehicledamage( data )
{
    return true;
}

// Namespace warrior_beatupthecar / namespace_dc52e0a4898a4de7
// Params 0
// Checksum 0x0, Offset: 0x5cb
// Size: 0x115
function function_aa09fe28d9f1adc0()
{
    if ( self.origin[ 0 ] == 128 && self.origin[ 1 ] == -576 || self.origin[ 0 ] == 60 && self.origin[ 1 ] == -576 )
    {
        return ( 0, 200, 0 );
    }
    
    if ( self.origin[ 0 ] == -980 && self.origin[ 1 ] == 196 || self.origin[ 0 ] == -980 && self.origin[ 1 ] == 264 )
    {
        return ( 200, 0, 0 );
    }
    
    if ( self.origin[ 0 ] == 996 && self.origin[ 1 ] == 300 || self.origin[ 0 ] == 996 && self.origin[ 1 ] == 232 )
    {
        return ( -200, 0, 0 );
    }
}

