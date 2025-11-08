#using scripts\common\utility;
#using scripts\common\whizby;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\gamescore;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;

#namespace whizby;

// Namespace whizby / scripts\mp\whizby
// Params 0
// Checksum 0x0, Offset: 0x155
// Size: 0x25
function init()
{
    setdvarifuninitialized( @"scr_suppression", 0 );
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    scripts\common\whizby::init();
}

// Namespace whizby / scripts\mp\whizby
// Params 0
// Checksum 0x0, Offset: 0x182
// Size: 0xa
function onplayerspawned()
{
    thread whizbythink();
}

// Namespace whizby / scripts\mp\whizby
// Params 0
// Checksum 0x0, Offset: 0x194
// Size: 0x70
function whizbythink()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    effecttime = gettime();
    scripts\common\whizby::initplayer();
    
    for ( ;; )
    {
        self waittill( "bulletwhizby", attacker, distance, position, forward );
        effecttime = dowhizby( attacker, distance, position, forward, effecttime );
        dosuppression( attacker );
    }
}

// Namespace whizby / scripts\mp\whizby
// Params 5
// Checksum 0x0, Offset: 0x20c
// Size: 0x9b
function dowhizby( attacker, distance, position, forward, effecttime )
{
    currenttime = gettime();
    
    if ( !isusingremote() )
    {
        thread scripts\common\whizby::whizbyeffect( attacker, distance, position, forward );
    }
    
    weapon = attacker getcurrentweapon();
    
    if ( isdefined( weapon ) && weaponclass( weapon ) == "sniper" )
    {
        thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_surprise", undefined, 0.2 );
    }
    
    thread scripts\mp\battlechatter_mp::addrecentattacker( attacker );
    return effecttime;
}

// Namespace whizby / scripts\mp\whizby
// Params 1
// Checksum 0x0, Offset: 0x2b0
// Size: 0x7c
function dosuppression( attacker )
{
    if ( getdvarint( @"scr_suppression", 1 ) == 1 )
    {
        weapon = attacker getcurrentweapon();
        
        if ( weapon hasattachment( "linearbrake" ) && !scripts\cp_mp\weapon::iskillstreakweapon( weapon ) && !scripts\mp\utility\perk::_hasperk( "specialty_blastshield" ) )
        {
            attacker hudicontype( "suppression" );
            scripts\mp\gamescore::trackdebuffassist( attacker, self, weapon.basename );
        }
    }
}

