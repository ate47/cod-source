#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;

#namespace cruise_predator_cp;

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 0
// Checksum 0x0, Offset: 0x303
// Size: 0x8d
function init()
{
    cruisepredator_createbackupheight();
    scripts\engine\utility::registersharedfunc( "cruise_predator", "directionOverride", &cruisepredator_directionoverride );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "aICharacterChecks", &cruisepredator_aicharacterchecks );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "CPMarkEnemies", &cruisepredator_cpmarkenemies );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "CPUnMarkEnemies", &cruisepredator_cpunmarkenemies );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "removeItemFromSlot", &cruisepredator_removeitemfromslot );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "assignTargetMarkers", &cruisepredator_assigntargetmarkers );
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 1
// Checksum 0x0, Offset: 0x398
// Size: 0x92
function cruisepredator_directionoverride( forwardvector )
{
    assertex( isplayer( self ), "self that's passed into the function isn't a player. Recheck Script" );
    assertex( isdefined( forwardvector ), "Param: forwardVector isn't defined. Recheck Script" );
    
    if ( isdefined( self.drone_strike_dir_override ) )
    {
        assertex( isdefined( self.drone_strike_dir_override.angles ), ".drone_strike_dir_override.angles should be defined. Recheck Script" );
        forwardvector = anglestoforward( self.drone_strike_dir_override.angles );
        forwardvector = vectornormalize( forwardvector );
        forwardvector *= ( 1, 1, 0 );
    }
    
    return forwardvector;
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 1
// Checksum 0x0, Offset: 0x433
// Size: 0x26
function cruisepredator_aicharacterchecks( ai )
{
    if ( isai( ai ) || isplayer( ai ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 0
// Checksum 0x0, Offset: 0x461
// Size: 0x62
function cruisepredator_createbackupheight()
{
    vdronestrikeheight = spawn( "script_origin", level.mapcenter + ( 0, 0, 2576 ) );
    vdronestrikeheight.angles = ( 0, 0, 0 );
    vdronestrikeheight.targetname = "drone_strike_height";
    level.vdronestrikeheight = vdronestrikeheight;
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 1
// Checksum 0x0, Offset: 0x4cb
// Size: 0x287
function cruisepredator_assigntargetmarkers( user )
{
    var_2cd52bbc2a67b7cf = [];
    var_ff93381949523976 = [];
    var_22ccb4186bd27179 = level.characters;
    var_eba1c5743194000d = [];
    all_players = level.players;
    groupsstruct = spawnstruct();
    
    if ( isdefined( level.remote_tanks ) )
    {
        foreach ( tank in level.remote_tanks )
        {
            if ( isdefined( tank ) )
            {
                var_eba1c5743194000d = array_add( var_eba1c5743194000d, tank );
            }
        }
    }
    
    if ( isdefined( level.mark_heli ) && isdefined( level.heli ) )
    {
        var_eba1c5743194000d = array_add( var_eba1c5743194000d, level.heli );
    }
    
    if ( isdefined( level.killstreak_additional_targets ) )
    {
        foreach ( target in level.killstreak_additional_targets )
        {
            var_eba1c5743194000d = array_add( var_eba1c5743194000d, target );
        }
    }
    
    foreach ( player in var_22ccb4186bd27179 )
    {
        if ( level.teambased && player.team == user.team || player == user )
        {
            var_ff93381949523976[ var_ff93381949523976.size ] = player;
            continue;
        }
        
        if ( cruisepredator_aicharacterchecks( player ) )
        {
            var_2cd52bbc2a67b7cf[ var_2cd52bbc2a67b7cf.size ] = player;
        }
    }
    
    var_4496855dec276732 = array_combine( var_eba1c5743194000d, var_2cd52bbc2a67b7cf );
    
    foreach ( player in all_players )
    {
        if ( level.teambased && player.team != user.team )
        {
            continue;
        }
        
        var_ff93381949523976[ var_ff93381949523976.size ] = player;
    }
    
    groupsstruct.enemytargetmarkergroup = var_4496855dec276732;
    groupsstruct.friendlytargetmarkergroup = var_ff93381949523976;
    return groupsstruct;
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 1
// Checksum 0x0, Offset: 0x75b
// Size: 0x174
function cruisepredator_cpmarkenemies( player )
{
    assertex( isplayer( player ), "player variable that's passed into the function isn't of player type. Recheck Script" );
    player.enemy_list = [];
    
    if ( isdefined( level.spawned_enemies ) )
    {
        for ( i = 0; i < level.spawned_enemies.size ; i++ )
        {
            level.spawned_enemies[ i ] hudoutlineenableforclient( player, "outlinefill_depth_red" );
            player.enemy_list[ player.enemy_list.size ] = level.spawned_enemies[ i ];
        }
    }
    
    if ( isdefined( level.remote_tanks ) )
    {
        foreach ( tank in level.remote_tanks )
        {
            if ( isdefined( tank ) )
            {
                tank hudoutlineenableforclient( player, "outlinefill_depth_red" );
                player.enemy_list[ player.enemy_list.size ] = tank;
            }
        }
    }
    
    if ( isdefined( level.mark_heli ) && isdefined( level.heli ) )
    {
        level.heli hudoutlineenableforclient( player, "outlinefill_depth_red" );
        player.enemy_list[ player.enemy_list.size ] = level.heli;
    }
    
    return player.enemy_list;
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 1
// Checksum 0x0, Offset: 0x8d8
// Size: 0x86
function cruisepredator_cpunmarkenemies( player )
{
    assertex( isplayer( player ), "player variable that's passed into the function isn't of player type. Recheck Script" );
    
    if ( isdefined( player.enemy_list ) )
    {
        foreach ( enemy in player.enemy_list )
        {
            if ( isdefined( enemy ) )
            {
                enemy hudoutlinedisableforclient( player );
            }
        }
    }
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 1
// Checksum 0x0, Offset: 0x966
// Size: 0x1f
function cruisepredator_removeitemfromslot( rider )
{
    assertex( isplayer( rider ), "rider variable that's passed into the function isn't of player type. Recheck Script" );
}

// Namespace cruise_predator_cp / scripts\cp\killstreaks\cruise_predator_cp
// Params 1
// Checksum 0x0, Offset: 0x98d
// Size: 0x4b
function function_8a023375b0197bdc( missile )
{
    self endon( "death" );
    missile endon( "cruise_missile_force_eject" );
    missile scripts\killstreaks\killstreak_shared::killstreak_waittillexplode( "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked" );
    flag_clear( "player_demigod" );
}

