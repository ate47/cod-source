#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace warrior_shocking;

// Namespace warrior_shocking / namespace_9010222c4865bdfb
// Params 0
// Checksum 0x0, Offset: 0x183
// Size: 0x17
function function_4629defddacd1dc1()
{
    thread onplayerspawned();
    thread function_492b4dec632917ec( "warrior_shocking" );
}

// Namespace warrior_shocking / namespace_9010222c4865bdfb
// Params 0
// Checksum 0x0, Offset: 0x1a2
// Size: 0x6f
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player takeallweapons();
        pistolweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( "jup_jp36_ar_anov94_mp" );
        player giveweapon( pistolweapon );
        player setspawnweapon( pistolweapon );
        player thread scripts\mp\utility\weapon::infiniteammothread( 0.5 );
        player thread function_a84504e876b9bfdd();
    }
}

// Namespace warrior_shocking / namespace_9010222c4865bdfb
// Params 0
// Checksum 0x0, Offset: 0x219
// Size: 0xa0
function function_a84504e876b9bfdd()
{
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_done" );
    haywiredata = spawnstruct();
    haywiredata.victim = self;
    haywiredata.objweapon = self getcurrentweapon();
    
    if ( isagent( self ) )
    {
        thread scripts\mp\equipment\shock_stick::shockstick_haywireagent( haywiredata );
        return;
    }
    
    if ( isplayer( self ) )
    {
        tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo( "equip_shockstick" );
        tableinfo.bundle.gestureref = "vm_ges_shockstick_react_looping";
        thread scripts\mp\equipment\shock_stick::function_c927fd013fc6e502( haywiredata, tableinfo.bundle );
    }
}

