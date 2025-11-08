#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gamelogic;
#using scripts\mp\hostmigration;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\rank;

#namespace nuke_mp;

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 0
// Checksum 0x0, Offset: 0x281
// Size: 0x111
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "nuke", &scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct );
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "nuke_select_location", &scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct );
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "nuke_multi", &scripts\cp_mp\killstreaks\nuke::tryusenukefromstruct );
    scripts\engine\utility::registersharedfunc( "nuke", "hostmigration_waitLongDurationWithPause", &nuke_hostmigration_waitlongdurationwithpause );
    scripts\engine\utility::registersharedfunc( "nuke", "hostmigration_waitTillHostMigrationDone", &nuke_hostmigration_waittillhostmigrationdone );
    scripts\engine\utility::registersharedfunc( "nuke", "delayEndGame", &nuke_delayendgame );
    scripts\engine\utility::registersharedfunc( "nuke", "addTeamRankXPMultiplier", &nuke_addteamrankxpmultiplier );
    scripts\engine\utility::registersharedfunc( "nuke", "cankill", &nuke_cankill );
    scripts\engine\utility::registersharedfunc( "nuke", "killPlayer", &nuke_killplayer );
    scripts\engine\utility::registersharedfunc( "nuke", "killPlayerWithAttacker", &nuke_killplayerwithattacker );
    scripts\engine\utility::registersharedfunc( "nuke", "destroyActiveObjects", &nuke_destroyactiveobjects );
    scripts\engine\utility::registersharedfunc( "nuke", "isPlayerInRadZone", &nuke_isplayerinradzone );
    scripts\engine\utility::registersharedfunc( "nuke", "stopTheClock", &nuke_stoptheclock );
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 1
// Checksum 0x0, Offset: 0x39a
// Size: 0x13
function nuke_hostmigration_waitlongdurationwithpause( delay )
{
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( delay );
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 0
// Checksum 0x0, Offset: 0x3b5
// Size: 0x8
function nuke_hostmigration_waittillhostmigrationdone()
{
    return scripts\mp\hostmigration::waittillhostmigrationdone();
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 2
// Checksum 0x0, Offset: 0x3c6
// Size: 0x6d
function nuke_delayendgame( delaytime, winner )
{
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delaytime );
    
    if ( istrue( level.mercywintriggered ) )
    {
        level thread scripts\mp\gamelogic::endgame( winner, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 1, 1 );
        return;
    }
    
    level thread scripts\mp\gamelogic::endgame( winner, game[ "end_reason" ][ "nuke_end" ], undefined, 1 );
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 3
// Checksum 0x0, Offset: 0x43b
// Size: 0x25
function nuke_addteamrankxpmultiplier( multiplier, team, ref )
{
    scripts\mp\rank::addteamrankxpmultiplier( multiplier, team, ref );
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 2
// Checksum 0x0, Offset: 0x468
// Size: 0x11b, Type: bool
function nuke_cankill( character, var_cfc1a4c269cffb70 )
{
    if ( istrue( level.blocknukekills ) )
    {
        return false;
    }
    
    if ( !isdefined( level.nukeinfo ) )
    {
        return false;
    }
    
    if ( istrue( var_cfc1a4c269cffb70 ) )
    {
        return true;
    }
    
    if ( level.teambased )
    {
        if ( isdefined( level.nukeinfo.team ) && character.team == level.nukeinfo.team )
        {
            return false;
        }
    }
    else
    {
        iskillstreakplayer = isdefined( level.nukeinfo.player ) && character == level.nukeinfo.player;
        ownerisplayer = isdefined( level.nukeinfo.player ) && isdefined( character.owner ) && character.owner == level.nukeinfo.player;
        
        if ( iskillstreakplayer || ownerisplayer )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 1
// Checksum 0x0, Offset: 0x58c
// Size: 0x12c
function nuke_destroyactiveobjects( team )
{
    var_6c845d64be969ce8 = level.activekillstreaks;
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    activeobjects = undefined;
    
    if ( isdefined( var_6c845d64be969ce8 ) && isdefined( equipmentarray ) )
    {
        activeobjects = array_combine_unique( var_6c845d64be969ce8, equipmentarray );
    }
    else if ( isdefined( var_6c845d64be969ce8 ) )
    {
        activeobjects = var_6c845d64be969ce8;
    }
    else if ( isdefined( equipmentarray ) )
    {
        activeobjects = equipmentarray;
    }
    
    if ( isdefined( activeobjects ) )
    {
        foreach ( object in activeobjects )
        {
            if ( isdefined( object ) )
            {
                if ( issharedfuncdefined( "killstreak", "doDamageToKillstreak" ) )
                {
                    object [[ getsharedfunc( "killstreak", "doDamageToKillstreak" ) ]]( 10000, level.nukeinfo.player, level.nukeinfo.player, team, object.origin, "MOD_EXPLOSIVE", level.nukeinfo.weapon );
                }
            }
        }
    }
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 3
// Checksum 0x0, Offset: 0x6c0
// Size: 0x51, Type: bool
function nuke_isplayerinradzone( player, zoneorigin, zonesize )
{
    if ( getdvarint( @"hash_d5fd9067cafb06b9" ) == 1 )
    {
        return false;
    }
    
    var_5a3a7553b49c43f9 = distance2dsquared( zoneorigin, player.origin );
    return var_5a3a7553b49c43f9 < zonesize;
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 1
// Checksum 0x0, Offset: 0x71a
// Size: 0xf1
function nuke_killplayer( character )
{
    if ( isplayer( character ) )
    {
        objweapon = makeweapon( level.nukeinfo.weapon );
        scripts\mp\damage::addattacker( character, level.nukeinfo.player, undefined, objweapon, 0, undefined, undefined, undefined, undefined, undefined );
        damagedirection = vectornormalize( character.origin + ( 0, 0, 1000 ) - level.nukeinfo.inflictor.origin );
        character thread scripts\mp\damage::finishplayerdamagewrapper( level.nukeinfo.inflictor, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", objweapon, character.origin, damagedirection, "none", 0, 0, undefined, undefined );
    }
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 1
// Checksum 0x0, Offset: 0x813
// Size: 0xbe
function nuke_killplayerwithattacker( character )
{
    var_705cc2040029edb7 = level.nukeinfo.player;
    
    if ( level.teambased && character.team == var_705cc2040029edb7.team )
    {
        var_705cc2040029edb7 = character;
    }
    
    objweapon = makeweapon( level.nukeinfo.weapon );
    character dodamage( 999999, level.nukeinfo.inflictor.origin, var_705cc2040029edb7, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", objweapon, "none" );
}

// Namespace nuke_mp / scripts\mp\killstreaks\nuke_mp
// Params 1
// Checksum 0x0, Offset: 0x8d9
// Size: 0x5a
function nuke_stoptheclock( gametype )
{
    timelimit = hashcat( @"scr_", gametype, "_timelimit" );
    level.watchdvars[ timelimit ].value = 0;
    level.overridewatchdvars[ timelimit ] = 0;
    level.extratime = 0;
    return timelimit;
}

