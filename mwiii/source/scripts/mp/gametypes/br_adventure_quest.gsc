#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;

#namespace br_adventure_quest;

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 0
// Checksum 0x0, Offset: 0x250
// Size: 0x7a
function init()
{
    setdvarifuninitialized( @"hash_282d9b6dbb93e17d", 0 );
    level.br_quests_enabled = getdvarint( @"hash_282d9b6dbb93e17d", 0 ) != 0;
    
    if ( !istrue( level.br_quests_enabled ) )
    {
        return;
    }
    
    level.br_queststashlocations = getstructarray( "quest_stash_location", "targetname" );
    
    if ( level.br_queststashlocations.size < 0 )
    {
        level.br_quests_enabled = 0;
        println( "<dev string:x1c>" );
    }
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x2d2
// Size: 0x24
function removestashlocation( location )
{
    level.br_queststashlocations = array_remove( level.br_queststashlocations, location );
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x2fe
// Size: 0x3f
function takequestitem( pickupent )
{
    if ( !istrue( level.br_quests_enabled ) )
    {
        self iprintlnbold( "Item is disabled" );
        return;
    }
    
    stashlocation = determinestashlocation();
    spawnstash( stashlocation );
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 0
// Checksum 0x0, Offset: 0x345
// Size: 0x37
function determinestashlocation()
{
    if ( !isdefined( level.br_queststashlocations ) )
    {
        level.br_queststashlocations = getstructarray( "quest_stash_location", "targetname" );
    }
    
    return random( level.br_queststashlocations );
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x385
// Size: 0x1be
function spawnstash( position )
{
    stashlocation = spawn( "script_model", position.origin );
    stashlocation setmodel( "com_plasticcase_beige_big_iw6" );
    stashlocation makeusable();
    stashlocation setcursorhint( "HINT_NOICON" );
    stashlocation setuseholdduration( "duration_medium" );
    stashlocation sethintrequiresholding( 1 );
    stashlocation sethintdisplayfov( 360 );
    stashlocation setusefov( 360 );
    stashlocation setuserange( 150 );
    stashlocation sethintstring( &"MP/BR_USE_PLUNDER_CACHE" );
    stashlocation setasgametypeobjective();
    stashlocation hide();
    search_position = ( position.origin[ 0 ], position.origin[ 1 ], 1000 );
    search_position += math::random_vector_2d() * randomintrange( 100, 900 );
    stashlocation.search_location = spawn( "script_model", search_position );
    stashlocation thread stashthink();
    addthinker( self, stashlocation );
    scripts\mp\utility\lower_message::setlowermessageomnvar( "quest_pickup", undefined, 5 );
    objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    stashlocation.objectiveiconid = objectiveiconid;
    
    if ( objectiveiconid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( objectiveiconid, "active", ( 0, 0, 0 ) );
        scripts\mp\objidpoolmanager::update_objective_position( objectiveiconid, stashlocation.search_location.origin );
        scripts\mp\objidpoolmanager::update_objective_state( objectiveiconid, "active" );
        scripts\mp\objidpoolmanager::update_objective_icon( objectiveiconid, "ui_mp_br_mapmenu_icon_atm" );
        scripts\mp\objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
    }
    
    stashlocation stashmakeusabletoteam( self.team );
    pickup_sfx = "ammo_crate_use";
    self playlocalsound( pickup_sfx );
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x54b
// Size: 0x9b
function stashmakeusabletoteam( team )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.team == team )
        {
            self enableplayeruse( player );
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
            self showtoplayer( player );
            continue;
        }
        
        stashmakeunusabletoplayer( player );
    }
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x5ee
// Size: 0x2c
function stashmakeunusabletoplayer( player )
{
    self disableplayeruse( player );
    self hudoutlinedisableforclient( player );
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 0
// Checksum 0x0, Offset: 0x622
// Size: 0x2e
function stashthink()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        thread usestash( player );
    }
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 0
// Checksum 0x0, Offset: 0x658
// Size: 0x140
function globalsonarthink()
{
    level endon( "game_ended" );
    level endon( "end_sonar_think" );
    pickup_sfx = "breach_warning_beep_04";
    
    for ( ;; )
    {
        wait 0.1;
        
        foreach ( playerguid, value in level.br_sonartickrates )
        {
            level.br_sonartickrates[ playerguid ]--;
            
            if ( value <= 0 )
            {
                player = level.br_playersusingsonar[ playerguid ];
                search_location = player.sonar_tracked_location.search_location;
                dist = distance2d( player.origin, search_location.origin );
                println( "<dev string:x56>" + dist );
                
                if ( dist < 1500 )
                {
                    if ( !isdefined( player.first_entered_search_area ) )
                    {
                        player scripts\mp\utility\lower_message::setlowermessageomnvar( "quest_enter_search_area", undefined, 5 );
                        player.first_entered_search_area = 1;
                    }
                    
                    player playlocalsound( pickup_sfx );
                }
                
                level.br_sonartickrates[ playerguid ] = calculatesonartickrate( player );
            }
        }
    }
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 2
// Checksum 0x0, Offset: 0x7a0
// Size: 0xb5
function addthinker( player, location )
{
    player.sonar_tracked_location = location;
    
    if ( !isdefined( level.br_sonartickrates ) )
    {
        level.br_sonartickrates = [];
        level.br_playersusingsonar = [];
        level.br_sonartickrates[ player.guid ] = calculatesonartickrate( player );
        level.br_playersusingsonar[ player.guid ] = player;
        level thread globalsonarthink();
        return;
    }
    
    level.br_playersusingsonar[ player.guid ] = player;
    level.br_sonartickrates[ player.guid ] = calculatesonartickrate( player );
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x85d
// Size: 0x67
function removethinker( player )
{
    if ( !isdefined( level.br_sonartickrates ) )
    {
        return;
    }
    
    level.br_sonartickrates = array_remove_key( level.br_sonartickrates, player.guid );
    
    if ( level.br_sonartickrates.size == 0 )
    {
        level notify( "end_sonar_think" );
        level.br_sonartickrates = undefined;
        level.br_playersusingsonar = undefined;
    }
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x8cc
// Size: 0x5c
function calculatesonartickrate( player )
{
    location = player.sonar_tracked_location;
    rate = distance2d( player.origin, location.origin );
    rate = clamp( rate / 75, 2, 15 );
    return int( rate );
}

// Namespace br_adventure_quest / scripts\mp\gametypes\br_adventure_quest
// Params 1
// Checksum 0x0, Offset: 0x931
// Size: 0x68
function usestash( player )
{
    removethinker( player );
    self hide();
    self makeunusable();
    self.origin += ( 0, 0, -500 );
    player scripts\mp\utility\lower_message::setlowermessageomnvar( "quest_stash_found", undefined, 5 );
    scripts\mp\objidpoolmanager::returnobjectiveid( self.objectiveiconid );
    self delete();
}

