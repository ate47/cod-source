#using scripts\common\utility;
#using scripts\common\whizby;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\utility;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace whizby;

// Namespace whizby / scripts\cp\whizby
// Params 0
// Checksum 0x0, Offset: 0xdb
// Size: 0x15
function init()
{
    scripts\common\whizby::init();
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
}

// Namespace whizby / scripts\cp\whizby
// Params 0
// Checksum 0x0, Offset: 0xf8
// Size: 0x14
function onplayerspawned()
{
    self._whizbyfxent = [];
    thread whizbythink();
}

// Namespace whizby / scripts\cp\whizby
// Params 0
// Checksum 0x0, Offset: 0x114
// Size: 0x59
function whizbythink()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    scripts\common\whizby::initplayer();
    
    for ( ;; )
    {
        self waittill( "bulletwhizby", attacker, distance, position, forward );
        dowhizby( attacker, distance, position, forward );
    }
}

// Namespace whizby / scripts\cp\whizby
// Params 4
// Checksum 0x0, Offset: 0x175
// Size: 0x61
function dowhizby( attacker, distance, position, forward )
{
    if ( !isusingremote() )
    {
        thread scripts\common\whizby::whizbyeffect( attacker, distance, position, forward );
    }
    
    weapon = attacker getcurrentweapon();
    
    if ( weaponclass( weapon ) == "sniper" )
    {
    }
    
    thread scripts\cp\cp_player_battlechatter::addrecentattacker( attacker );
}

