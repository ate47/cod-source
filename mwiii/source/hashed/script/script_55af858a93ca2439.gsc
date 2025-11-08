#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\teams;

#namespace warrior_fragged;

// Namespace warrior_fragged / namespace_36f22ae5d548509b
// Params 0
// Checksum 0x0, Offset: 0x160
// Size: 0x17
function function_46e09220a05bae5f()
{
    thread onplayerspawned();
    thread function_492b4dec632917ec( "warrior_fragged" );
}

// Namespace warrior_fragged / namespace_36f22ae5d548509b
// Params 0
// Checksum 0x0, Offset: 0x17f
// Size: 0x9d
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player takeallweapons();
        riotshieldweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( "iw9_me_riotshield_mp" );
        player giveweapon( riotshieldweapon );
        player setspawnweapon( riotshieldweapon );
        player scripts\cp_mp\equipment::giveequipment( "equip_frag", "primary" );
        
        if ( player _hasperk( "specialty_eod_vest" ) )
        {
            player.var_1c4d4c562c1d1866 = 1;
            player removeperk( "specialty_eod_vest" );
        }
        
        player thread waittill_grenade_fire();
    }
}

// Namespace warrior_fragged / namespace_36f22ae5d548509b
// Params 0
// Checksum 0x0, Offset: 0x224
// Size: 0x31
function waittill_grenade_fire()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        self waittill( "grenade_fire" );
        scripts\cp_mp\equipment::giveequipment( "equip_frag", "primary" );
    }
}

// Namespace warrior_fragged / namespace_36f22ae5d548509b
// Params 0
// Checksum 0x0, Offset: 0x25d
// Size: 0x6a
function function_afa6a2ae298ee59f()
{
    foreach ( player in level.players )
    {
        if ( istrue( player.var_1c4d4c562c1d1866 ) )
        {
            player giveperk( "specialty_eod_vest" );
        }
    }
}

