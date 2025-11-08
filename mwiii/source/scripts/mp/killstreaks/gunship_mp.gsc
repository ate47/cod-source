#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\gunship;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\missilelauncher;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace gunship_mp;

// Namespace gunship_mp / scripts\mp\killstreaks\gunship_mp
// Params 0
// Checksum 0x0, Offset: 0x30f
// Size: 0x147
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "gunship", &scripts\cp_mp\killstreaks\gunship::tryusegunshipfromstruct );
    scripts\engine\utility::registersharedfunc( "gunship", "findBoxCenter", &gunship_findboxcenter );
    scripts\engine\utility::registersharedfunc( "gunship", "getBombingPoint", &gunship_getbombingpoint );
    scripts\engine\utility::registersharedfunc( "gunship", "assignTargetMarkers", &gunship_assigntargetmarkers );
    scripts\engine\utility::registersharedfunc( "gunship", "attachXRays", &function_719b6cb36fd371a2 );
    scripts\engine\utility::registersharedfunc( "gunship", "lockOnLaunchers_getTargetArray", &scripts\mp\weapons::lockonlaunchers_gettargetarray );
    scripts\engine\utility::registersharedfunc( "gunship", "ResetMissileLauncherLocking", &scripts\mp\missilelauncher::resetmissilelauncherlocking );
    scripts\engine\utility::registersharedfunc( "gunship", "missileLauncher_finalizeLock", &scripts\mp\missilelauncher::missilelauncher_finalizelock );
    scripts\engine\utility::registersharedfunc( "gunship", "stingTargStruct_create", &scripts\mp\missilelauncher::stingtargstruct_create );
    scripts\engine\utility::registersharedfunc( "gunship", "stingTargStruct_getOffsets", &scripts\mp\missilelauncher::stingtargstruct_getoffsets );
    scripts\engine\utility::registersharedfunc( "gunship", "stingTargStruct_getOrigins", &scripts\mp\missilelauncher::stingtargstruct_getorigins );
    scripts\engine\utility::registersharedfunc( "gunship", "stingTargStruct_getInReticle", &scripts\mp\missilelauncher::stingtargstruct_getinreticle );
    scripts\engine\utility::registersharedfunc( "gunship", "stingTargStruct_isInReticle", &scripts\mp\missilelauncher::stingtargstruct_isinreticle );
    scripts\engine\utility::registersharedfunc( "gunship", "stingTargStruct_getInLOS", &scripts\mp\missilelauncher::stingtargstruct_getinlos );
    scripts\engine\utility::registersharedfunc( "gunship", "SoftSightTest", &scripts\mp\missilelauncher::softsighttest );
}

// Namespace gunship_mp / scripts\mp\killstreaks\gunship_mp
// Params 2
// Checksum 0x0, Offset: 0x45e
// Size: 0x1b
function gunship_findboxcenter( mins, maxs )
{
    return scripts\mp\spawnlogic::findboxcenter( mins, maxs );
}

// Namespace gunship_mp / scripts\mp\killstreaks\gunship_mp
// Params 2
// Checksum 0x0, Offset: 0x482
// Size: 0x32
function gunship_getbombingpoint( centerpoint, bombingradius )
{
    var_bf366eb7073782af = scripts\cp_mp\killstreaks\toma_strike::tomastrike_getrandombombingpoint( centerpoint, bombingradius );
    return var_bf366eb7073782af.point;
}

// Namespace gunship_mp / scripts\mp\killstreaks\gunship_mp
// Params 1
// Checksum 0x0, Offset: 0x4bd
// Size: 0x119
function gunship_assigntargetmarkers( gunner )
{
    var_f73788b68546b5e7 = [];
    var_5408012d0aed529a = [];
    
    foreach ( player in level.players )
    {
        if ( level.teambased && player.team == self.team || player == self.owner )
        {
            var_5408012d0aed529a[ var_5408012d0aed529a.size ] = player;
            continue;
        }
        
        if ( player scripts\mp\utility\perk::_hasperk( "specialty_noscopeoutline" ) )
        {
            continue;
        }
        
        var_f73788b68546b5e7[ var_f73788b68546b5e7.size ] = player;
    }
    
    self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "overlaytargetmarkerenemy", self.owner, var_f73788b68546b5e7, self.owner, 0, 1, 1 );
    self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "overlaytargetmarkerfriendly", self.owner, var_5408012d0aed529a, self.owner, 1, 1 );
}

// Namespace gunship_mp / scripts\mp\killstreaks\gunship_mp
// Params 1
// Checksum 0x0, Offset: 0x5de
// Size: 0x20
function function_719b6cb36fd371a2( gunship )
{
    gunship setentityhudoutlinedata( 3, gunship.team );
    return gunship;
}

