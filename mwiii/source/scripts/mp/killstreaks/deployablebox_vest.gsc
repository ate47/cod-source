#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\deployablebox;
#using scripts\mp\lightarmor;
#using scripts\mp\perks\perkfunctions;

#namespace deployablebox_vest;

// Namespace deployablebox_vest / scripts\mp\killstreaks\deployablebox_vest
// Params 0
// Checksum 0x0, Offset: 0x264
// Size: 0x1fa
function init()
{
    var_86280fefb94b6b28 = spawnstruct();
    var_86280fefb94b6b28.id = "deployable_vest";
    var_86280fefb94b6b28.weaponinfo = "deployable_vest_marker_mp";
    var_86280fefb94b6b28.modelbase = "prop_ballistic_vest_iw6";
    var_86280fefb94b6b28.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
    var_86280fefb94b6b28.hintstring = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
    var_86280fefb94b6b28.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
    var_86280fefb94b6b28.event = "deployable_vest_taken";
    var_86280fefb94b6b28.streakname = "deployable_vest";
    var_86280fefb94b6b28.splashname = "used_deployable_vest";
    var_86280fefb94b6b28.shadername = "compass_objpoint_deploy_friendly";
    var_86280fefb94b6b28.headiconoffset = 20;
    var_86280fefb94b6b28.lifespan = 90;
    var_86280fefb94b6b28.usexp = 50;
    var_86280fefb94b6b28.scorepopup = "destroyed_vest";
    var_86280fefb94b6b28.vodestroyed = "ballistic_vest_destroyed";
    var_86280fefb94b6b28.deployedsfx = "mp_vest_deployed_ui";
    var_86280fefb94b6b28.onusesfx = "ammo_crate_use";
    var_86280fefb94b6b28.onusecallback = &onusedeployable;
    var_86280fefb94b6b28.canusecallback = &canusedeployable;
    var_86280fefb94b6b28.usetime = 1000;
    var_86280fefb94b6b28.maxhealth = 220;
    var_86280fefb94b6b28.damagefeedback = "deployable_bag";
    var_86280fefb94b6b28.deathvfx = loadfx( "vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx" );
    var_86280fefb94b6b28.allowmeleedamage = 1;
    var_86280fefb94b6b28.allowgrenadedamage = 0;
    var_86280fefb94b6b28.maxuses = 4;
    var_86280fefb94b6b28.canuseotherboxes = 0;
    level.boxsettings[ "deployable_vest" ] = var_86280fefb94b6b28;
    assertmsg( "<dev string:x1c>" );
    level.deployable_box[ "deployable_vest" ] = [];
}

// Namespace deployablebox_vest / scripts\mp\killstreaks\deployablebox_vest
// Params 2
// Checksum 0x0, Offset: 0x466
// Size: 0x58, Type: bool
function tryusedeployablevest( lifeid, streakname )
{
    result = scripts\mp\killstreaks\deployablebox::begindeployableviamarker( lifeid, "deployable_vest" );
    
    if ( !isdefined( result ) || !result )
    {
        return false;
    }
    
    utility::trycall( level.matchdata_logkillstreakevent, "deployable_vest", self.origin );
    return true;
}

// Namespace deployablebox_vest / scripts\mp\killstreaks\deployablebox_vest
// Params 1
// Checksum 0x0, Offset: 0x4c7
// Size: 0x13, Type: bool
function canusedeployable( boxent )
{
    return !scripts\mp\lightarmor::haslightarmor( self );
}

// Namespace deployablebox_vest / scripts\mp\killstreaks\deployablebox_vest
// Params 1
// Checksum 0x0, Offset: 0x4e3
// Size: 0x12
function onusedeployable( boxent )
{
    scripts\mp\perks\perkfunctions::setlightarmor();
}

// Namespace deployablebox_vest / scripts\mp\killstreaks\deployablebox_vest
// Params 2
// Checksum 0x0, Offset: 0x4fd
// Size: 0x44
function get_adjusted_armor( existing_armor, rank )
{
    if ( existing_armor + level.deployablebox_vest_rank[ rank ] > level.deployablebox_vest_max )
    {
        return level.deployablebox_vest_max;
    }
    
    return existing_armor + level.deployablebox_vest_rank[ rank ];
}

