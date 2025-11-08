#using scripts\cp_mp\equipment;
#using scripts\mp\equipment\concussion_grenade;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace warrior_stunning;

// Namespace warrior_stunning / namespace_df2ddeb4fdbbdcb7
// Params 0
// Checksum 0x0, Offset: 0x14f
// Size: 0x17
function function_a081e7290fcbe2c5()
{
    thread onplayerspawned();
    thread function_492b4dec632917ec( "warrior_stunning" );
}

// Namespace warrior_stunning / namespace_df2ddeb4fdbbdcb7
// Params 0
// Checksum 0x0, Offset: 0x16e
// Size: 0x90
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player scripts\mp\gamescore::initassisttrackers();
        tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo( "equip_concussion" );
        einflictor = spawnstruct();
        einflictor.origin = player.origin;
        einflictor.bundle = tableinfo.bundle;
        player thread function_550ae6d214fc09e6( einflictor );
    }
}

// Namespace warrior_stunning / namespace_df2ddeb4fdbbdcb7
// Params 1
// Checksum 0x0, Offset: 0x206
// Size: 0x44
function function_550ae6d214fc09e6( einflictor )
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_done" );
    wait 1.5;
    
    while ( true )
    {
        scripts\mp\equipment\concussion_grenade::applyconcussion( einflictor, self );
        self waittill( "concussion_unstunned" );
    }
}

