#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_ai;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace playerchatter;

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x147
// Size: 0x62
function init_playerchatter()
{
    anim.player.battlechatter = spawnstruct();
    anim.player.battlechatter.countryid = getplayernameid();
    anim.player.battlechatter.enemyclass = "soldier";
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1b1
// Size: 0x2
function getplayernameid()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1bb
// Size: 0x2
function player_battlechatter_on_thread()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1c5
// Size: 0x2
function player_update_allowed_callouts()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1cf
// Size: 0x2
function player_battlechatter_off_thread()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1d9
// Size: 0x2
function playerthreadthreader()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1e3
// Size: 0x2
function playerdamagewaiter()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1ed
// Size: 0x2
function playerdogfightwaiter()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x1f7
// Size: 0x2
function playervehiclewaiter()
{
    
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x201
// Size: 0xae
function playeranimnameswitch()
{
    human_player = getentarray( "player", "classname" )[ 0 ];
    player_update_allowed_callouts();
    anim.player = human_player;
    
    if ( !isdefined( anim.player.team ) )
    {
        anim.player.team = "allies";
    }
    
    player_update_allowed_callouts();
    level.bcs_maxthreatdistsqrdfromplayer = squared( 5000 );
    level.bcs_maxtalkingdistsqrdfromplayer = squared( 3000 );
    level.bcs_maxstealthdistsqrdfromplayer = squared( 1500 );
    anim.teamthreatcalloutlimittimeout = 120000;
    init_playerchatter();
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x2b7
// Size: 0x147
function player_battlechatter_cooldown_control()
{
    anim.player.bcscooldown = 1;
    
    while ( isalive( anim.player ) && bcsenabled() && isdefined( anim.player.battlechatterallowed ) && anim.player.battlechatterallowed )
    {
        if ( anim.player.bcscooldown == 0 )
        {
            cooldown_time = 10;
        }
        else
        {
            cooldown_time = anim.player.bcscooldown;
        }
        
        anim.player.battlechatter.isspeaking = 1;
        
        for ( i = cooldown_time; i >= 0 ; i-- )
        {
            anim.player.bcscooldown = i;
            wait 1;
        }
        
        anim.player.battlechatter.isspeaking = 0;
        level waittill( "player_battlechatter_refresh" );
        
        while ( anim.player.battlechatter.isspeaking != 0 )
        {
            wait 0.5;
        }
    }
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x406
// Size: 0xae
function player_battlechatter_generic_event_check()
{
    anim.player endon( "death" );
    level endon( "player_battlechatter_off" );
    last_event = "none";
    event_list = [ "pc_ammocrate_pickup", "pc_equipcrate_pickup", "pc_weapon_scanned", "pc_armory_door", "pc_clear_last_event" ];
    
    while ( true )
    {
        event = waittill_any_in_array_return( event_list );
        
        if ( event != last_event && event != "pc_clear_last_event" )
        {
            last_event = event;
            thread player_battlechatter_event_clear();
        }
        else if ( event == "pc_clear_last_event" )
        {
            last_event = "none";
        }
        
        wait 1;
    }
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x4bc
// Size: 0xd
function player_battlechatter_event_clear()
{
    wait 10;
    level notify( "pc_clear_last_event" );
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 0
// Checksum 0x0, Offset: 0x4d1
// Size: 0x18
function player_battlechatter_check_for_crate_pickups()
{
    anim.player endon( "death" );
    level endon( "player_battlechatter_off" );
}

// Namespace playerchatter / scripts\sp\player\playerchatter
// Params 1
// Checksum 0x0, Offset: 0x4f1
// Size: 0x78, Type: bool
function isvalidplayerevent( straction )
{
    if ( !isdefined( self.squad.ismembersaying[ straction ] ) || !isdefined( anim.isteamsaying[ self.team ][ straction ] ) )
    {
        return true;
    }
    
    if ( !self.squad.ismembersaying[ straction ] && !anim.isteamsaying[ self.team ][ straction ] )
    {
        return true;
    }
    
    return false;
}

