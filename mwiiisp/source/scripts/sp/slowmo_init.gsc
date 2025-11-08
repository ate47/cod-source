#using scripts\common\utility;
#using scripts\engine\utility;

#namespace slowmo_init;

// Namespace slowmo_init / scripts\sp\slowmo_init
// Params 0
// Checksum 0x0, Offset: 0xbb
// Size: 0x5b
function slowmo_system_init()
{
    if ( !add_init_script( "slowmo", &slowmo_system_init ) )
    {
        return;
    }
    
    level.slowmo = spawnstruct();
    slowmo_system_defaults();
    notifyoncommand( "_cheat_player_press_slowmo", "+melee" );
    notifyoncommand( "_cheat_player_press_slowmo", "+melee_breath" );
    notifyoncommand( "_cheat_player_press_slowmo", "+melee_zoom" );
}

// Namespace slowmo_init / scripts\sp\slowmo_init
// Params 0
// Checksum 0x0, Offset: 0x11e
// Size: 0x66
function slowmo_system_defaults()
{
    level.slowmo.lerp_time_in = 0;
    level.slowmo.lerp_time_out = 0.25;
    level.slowmo.speed_slow = 0.4;
    level.slowmo.speed_norm = 1;
}

