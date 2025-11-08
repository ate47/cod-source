#using scripts\common\anim;
#using scripts\common\rockable_vehicles;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\gameobjects;
#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace destructible;

// Namespace destructible / scripts\mp\destructible
// Params 0
// Checksum 0x0, Offset: 0x5b5
// Size: 0x2
function init()
{
    
}

// Namespace destructible / scripts\mp\destructible
// Params 0
// Checksum 0x0, Offset: 0x5bf
// Size: 0x2
function script_model_anims()
{
    
}

#using_animtree( "script_model" );

// Namespace destructible / scripts\mp\destructible
// Params 3
// Checksum 0x0, Offset: 0x5c9
// Size: 0xe8
function create_player_rig( player, animname, rig_model )
{
    if ( !isdefined( player ) || isdefined( player.player_rig ) )
    {
        return;
    }
    
    player.animname = animname;
    
    if ( !isdefined( rig_model ) )
    {
        rig_model = "viewhands_base_iw8";
    }
    
    player.player_rig = spawn( "script_model", player.origin );
    player.player_rig setmodel( rig_model );
    player.player_rig hide();
    player.player_rig.animname = animname;
    player.player_rig useanimtree( #animtree );
    player playerlinktodelta( player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0 );
    player watch_remove_rig();
    remove_player_rig( player );
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x6b9
// Size: 0x92
function remove_player_rig( player )
{
    if ( !isdefined( player ) || !isdefined( player.player_rig ) )
    {
        return;
    }
    
    player unlink();
    droppos = player getdroptofloorposition( player.origin );
    
    if ( isdefined( droppos ) )
    {
        player setorigin( droppos );
    }
    else
    {
        player setorigin( player.origin + ( 0, 0, 100 ) );
    }
    
    player.player_rig delete();
    player.player_rig = undefined;
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x753
// Size: 0x1c
function watch_remove_rig( struct )
{
    waittill_any_2( "remove_rig", "death_or_disconnect" );
}

// Namespace destructible / scripts\mp\destructible
// Params 2
// Checksum 0x0, Offset: 0x777
// Size: 0xd9
function add_destructible_array( value, type )
{
    array = getentarray( value, type );
    
    foreach ( ent in array )
    {
        destructible = spawnstruct();
        add_destructible( destructible, ent );
        destructible assigninteractteam( level.teamnamelist );
        
        if ( !isdefined( level.destructibles[ value ] ) )
        {
            level.destructibles[ value ] = [];
        }
        
        level.destructibles[ value ][ level.destructibles[ value ].size ] = destructible;
        destructible process_action( "init" );
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 2
// Checksum 0x0, Offset: 0x858
// Size: 0xf0
function add_destructible( struct, ent )
{
    if ( !isdefined( struct.ents ) )
    {
        struct.ents = [];
    }
    
    struct read_properties( ent );
    struct read_actions( ent );
    struct.ents[ struct.ents.size ] = ent;
    ent.parent = struct;
    
    if ( isdefined( ent.target ) )
    {
        targets = getentarray( ent.target, "targetname" );
        
        if ( isdefined( targets ) && targets.size > 0 )
        {
            foreach ( target in targets )
            {
                add_destructible( struct, target );
            }
        }
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x950
// Size: 0x1c4
function read_properties( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    switch ( ent.classname )
    {
        case #"hash_5e80cefd309127e7":
            self.use_trigger = ent;
            break;
        case #"hash_34386070076b3ec1":
            label = ent.script_label;
            
            if ( isdefined( label ) )
            {
                switch ( label )
                {
                    case #"hash_bab519a8c9a664ee":
                        if ( !isdefined( self.useobjects ) )
                        {
                            self.useobjects = [];
                        }
                        
                        self.useobjects[ "front" ] = setup_bomb_object( ent.origin );
                        self.useobjects[ "front" ].scenenodekey = "front";
                        break;
                    case #"hash_e1339489d1059713":
                        if ( !isdefined( self.scenenodes ) )
                        {
                            self.scenenodes = [];
                        }
                        
                        self.scenenodes[ "front" ] = ent;
                        break;
                    case #"hash_5ca8db6dafc678d0":
                        if ( !isdefined( self.useobjects ) )
                        {
                            self.useobjects = [];
                        }
                        
                        self.useobjects[ "back" ] = setup_bomb_object( ent.origin );
                        self.useobjects[ "back" ].scenenodekey = "back";
                        break;
                    case #"hash_383a7c211337491f":
                        if ( !isdefined( self.scenenodes ) )
                        {
                            self.scenenodes = [];
                        }
                        
                        self.scenenodes[ "back" ] = ent;
                        break;
                }
            }
            
            break;
        case #"hash_efad986c2d96044e":
            self.scriptable = ent;
            break;
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0xb1c
// Size: 0x11c
function read_actions( ent )
{
    if ( !isdefined( ent.script_noteworthy ) )
    {
        return;
    }
    
    types = strtok( ent.script_noteworthy, "," );
    
    foreach ( type in types )
    {
        actions = strtok( type, "|" );
        
        if ( !isdefined( actions ) )
        {
            return;
        }
        
        if ( actions.size < 2 )
        {
            return;
        }
        
        type = actions[ 0 ];
        
        if ( !isdefined( ent.actions ) )
        {
            ent.actions = [];
        }
        
        if ( !isdefined( ent.actions[ type ] ) )
        {
            ent.actions[ type ] = [];
        }
        
        for ( index = 1; index < actions.size ; index++ )
        {
            ent.actions[ type ][ ent.actions[ type ].size ] = actions[ index ];
        }
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 2
// Checksum 0x0, Offset: 0xc40
// Size: 0x24
function waittime_process_action( type, time )
{
    level endon( "game_ended" );
    wait time;
    process_action( type );
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0xc6c
// Size: 0x1e
function waitmsg_process_action( waitmsg )
{
    level endon( "game_ended" );
    self waittill( waitmsg );
    process_action( waitmsg );
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0xc92
// Size: 0xea
function process_action( type )
{
    if ( !isdefined( self.ents ) )
    {
        return;
    }
    
    foreach ( ent in self.ents )
    {
        if ( isdefined( ent.actions ) && isdefined( ent.actions[ type ] ) )
        {
            foreach ( action in ent.actions[ type ] )
            {
                ent actionmap( action );
            }
        }
    }
    
    self.state = type;
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0xd84
// Size: 0x15e
function actionmap( action )
{
    switch ( action )
    {
        case #"hash_ca51c18a00a0a89c":
            self show();
            break;
        case #"hash_7ebb454a971d80d":
            self hide();
            break;
        case #"hash_b669df4fb84dddd4":
            self solid();
            break;
        case #"hash_814a3d48452ddccd":
            self notsolid();
            break;
        case #"hash_47ef848af9047e3d":
            self disconnectpaths();
            break;
        case #"hash_491ccd849f5f0b23":
            self connectpaths();
            break;
        case #"hash_9fc8c71433fa319d":
            explosionorigin = self.origin;
            rot = self.angles;
            explosioneffect = spawnfx( level._effect[ "breach_explode" ], explosionorigin, anglestoforward( rot ) * -1, ( 0, 0, 1 ) );
            triggerfx( explosioneffect );
            physicsexplosionsphere( explosionorigin, 200, 100, 3 );
            playrumbleonposition( "grenade_rumble", explosionorigin );
            earthquake( 0.5, 1, explosionorigin, 1500 );
            self.parent.plantedbomb setscriptablepartstate( "bomb", "destroy" );
            break;
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0xeea
// Size: 0x7a
function setup_bomb_object( position )
{
    useobject = scripts\mp\gameobjects::createhintobject( position, "HINT_BUTTON", "hud_icon_c4_plant", &"MP/BREACH", undefined, undefined, undefined, 800, 120, 72, 120 );
    
    if ( !isdefined( level.breachusetriggers ) )
    {
        level.breachusetriggers = [];
    }
    
    level.breachusetriggers[ level.breachusetriggers.size ] = useobject;
    self.defused = 0;
    thread usetriggerthink( useobject );
    return useobject;
}

// Namespace destructible / scripts\mp\destructible
// Params 2
// Checksum 0x0, Offset: 0xf6d
// Size: 0x381
function bomb_planted_think( scenenodekey, player )
{
    plantedteam = player.team;
    self.defused = 0;
    
    if ( !isdefined( self.breachindex ) )
    {
        if ( !isdefined( level.breachindex ) )
        {
            level.breachindex = 0;
        }
        else
        {
            level.breachindex++;
        }
        
        self.breachindex = level.breachindex;
    }
    
    bomb_fuse_think( plantedteam );
    
    if ( !self.defused )
    {
        process_action( "destroyed" );
        explosionorigin = self.useobjects[ scenenodekey ].origin;
        
        if ( isdefined( self.scriptable ) )
        {
            if ( scenenodekey == "front" )
            {
                self.scriptable setscriptablepartstate( "base", "destroyFront" );
            }
            else
            {
                self.scriptable setscriptablepartstate( "base", "destroyBack" );
            }
        }
        else
        {
            rot = self.useobjects[ scenenodekey ].angles;
            explosioneffect = spawnfx( level._effect[ "breach_explode" ], explosionorigin, anglestoforward( rot ) * -1, ( 0, 0, 1 ) );
            triggerfx( explosioneffect );
            self.plantedbomb setscriptablepartstate( "bomb", "destroy" );
        }
        
        physicsexplosionsphere( explosionorigin, 200, 100, 3 );
        playrumbleonposition( "grenade_rumble", explosionorigin );
        earthquake( 0.5, 1, explosionorigin, 1500 );
        
        foreach ( entry in self.useobjects )
        {
            entry delete();
            level.breachusetriggers = array_remove( level.breachusetriggers, entry );
        }
        
        wait 0.1;
        
        if ( isdefined( player ) )
        {
            self.plantedbomb radiusdamage( self.plantedbomb.origin, 300, 120, 10, player, "MOD_EXPLOSIVE", "bomb_site_mp" );
        }
        else
        {
            self.plantedbomb radiusdamage( self.plantedbomb.origin, 300, 120, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp" );
        }
        
        if ( isdefined( level.hostages ) )
        {
            thread playhostagehelp( self.plantedbomb.origin );
        }
    }
    
    self.plantedbomb delete();
    self.plantedbomb = undefined;
    self.plantedkey = undefined;
    setomnvar( "ui_ingame_timer_" + self.breachindex, 0 );
    setomnvar( "ui_ingame_timer_ent_" + self.breachindex, undefined );
    
    if ( self.defused )
    {
        foreach ( entry in self.useobjects )
        {
            entry sethintstring( &"MP/BREACH" );
        }
        
        assigninteractteam( level.teamnamelist );
        process_action( "init" );
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x12f6
// Size: 0x46
function playhostagehelp( origin )
{
    wait 1;
    
    if ( distance2d( level.hostages[ 0 ].origin, origin ) < 500 )
    {
        level.hostages[ 0 ] playsound( "dx_mpb_us3_hvt_up" );
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1344
// Size: 0x1fe
function bomb_fuse_think( team )
{
    self endon( "defused" );
    
    foreach ( entry in self.useobjects )
    {
        entry sethintstring( &"MP/BREACH_DEFUSE" );
    }
    
    self.timerobject = spawn( "script_model", self.plantedbomb.origin );
    self.timerobject makeusable();
    assigninteractteam( getenemyteams( team ) );
    currenttime = gettime();
    bombendtime = int( currenttime + 5000 );
    setomnvar( "ui_ingame_timer_" + self.breachindex, bombendtime );
    setomnvar( "ui_ingame_timer_ent_" + self.breachindex, self.timerobject );
    var_c301d652d9a73075 = bombendtime - currenttime;
    
    while ( !self.defused && var_c301d652d9a73075 > 0 )
    {
        currenttime = gettime();
        var_c301d652d9a73075 = bombendtime - currenttime;
        
        if ( var_c301d652d9a73075 < 1500 )
        {
            if ( var_c301d652d9a73075 <= 250 )
            {
                self.plantedbomb playsound( "breach_warning_beep_05" );
            }
            else if ( var_c301d652d9a73075 < 500 )
            {
                self.plantedbomb playsound( "breach_warning_beep_04" );
            }
            else if ( var_c301d652d9a73075 < 1500 )
            {
                self.plantedbomb playsound( "breach_warning_beep_03" );
            }
            else
            {
                self.plantedbomb playsound( "breach_warning_beep_02" );
            }
            
            wait 0.25;
        }
        else if ( var_c301d652d9a73075 < 3500 )
        {
            self.plantedbomb playsound( "breach_warning_beep_02" );
            wait 0.5;
        }
        else
        {
            self.plantedbomb playsound( "breach_warning_beep_01" );
            wait 1;
        }
        
        if ( var_c301d652d9a73075 < 0 )
        {
            break;
        }
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x154a
// Size: 0x8c
function usetriggerthink( trigger )
{
    while ( true )
    {
        trigger waittill( "trigger", player );
        
        if ( !array_contains( self.interactteams, player.team ) )
        {
            continue;
        }
        
        if ( player scripts\mp\utility\weapon::grenadeinpullback() )
        {
            return 0;
        }
        
        if ( player meleebuttonpressed() )
        {
            return 0;
        }
        
        if ( player isusingremote() )
        {
            continue;
        }
        
        if ( !isdefined( self.plantedbomb ) )
        {
            plantbreachc4( trigger, player );
            continue;
        }
        
        defusec4( player );
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 2
// Checksum 0x0, Offset: 0x15de
// Size: 0x3b7, Type: bool
function plantbreachc4( trigger, player )
{
    thread watchplayerdeath( player );
    player.linktoent = player spawn_tag_origin();
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0 );
    player.linktoent moveto( self.scenenodes[ trigger.scenenodekey ].origin, 0.25, 0.1, 0.1 );
    player.linktoent rotateto( self.scenenodes[ trigger.scenenodekey ].angles, 0.25, 0.1, 0.1 );
    player setstance( "stand" );
    
    if ( !player givegunless() )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
        return false;
    }
    
    if ( istrue( self.cancelplant ) )
    {
        return false;
    }
    
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( self.scenenodes[ trigger.scenenodekey ].origin );
    player setplayerangles( self.scenenodes[ trigger.scenenodekey ].angles );
    
    foreach ( entry in self.useobjects )
    {
        entry hide();
    }
    
    faction = ter_op( player.team == "allies", "usp1", "afp1" );
    
    if ( level.mapname == "mp_hackney_yard" )
    {
        faction = ter_op( player.team == "allies", "ukp1", "abp1" );
    }
    
    player queuedialogforplayer( "dx_mpp_" + faction + "_breach_plant", "cop_breach_plant", 2 );
    thread create_player_rig( player, "planter" );
    player thread scripts\mp\anim::anim_player_solo( player, player.player_rig, "plant" );
    wm_c4 = spawn( "script_model", self.scenenodes[ trigger.scenenodekey ].origin );
    wm_c4 setmodel( "offhand_wm_c4" );
    wm_c4.animname = "c4";
    wm_c4 useanimtree( #animtree );
    self.plantedbomb = wm_c4;
    self.plantedkey = trigger.scenenodekey;
    self.scenenodes[ trigger.scenenodekey ] thread anim_single_solo( wm_c4, "plant" );
    animlength = getanimlength( level.scr_anim[ "planter" ][ "plant" ] );
    armedtimeoffset = 0.5;
    wait animlength - armedtimeoffset;
    
    if ( istrue( self.cancelplant ) )
    {
        return false;
    }
    
    thread bomb_planted_think( trigger.scenenodekey, player );
    givebreachscore( player );
    wait armedtimeoffset - 0.1;
    player thread takegunless();
    remove_player_rig( player );
    process_action( "onuse" );
    self notify( "breach_complete" );
    return true;
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x199e
// Size: 0xc7
function watchplayerdeath( player )
{
    self endon( "breach_complete" );
    self.cancelplant = 0;
    
    while ( true )
    {
        if ( !isdefined( player ) || !isreallyalive( player ) )
        {
            foreach ( entry in self.useobjects )
            {
                entry show();
            }
            
            if ( isdefined( self.plantedbomb ) )
            {
                self.plantedbomb delete();
                self.plantedbomb = undefined;
                self.plantedkey = undefined;
            }
            
            self.cancelplant = 1;
            break;
        }
        
        waitframe();
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1a6d
// Size: 0x6c
function allowplayertobreach( player )
{
    if ( isdefined( level.breachusetriggers ) )
    {
        foreach ( trigger in level.breachusetriggers )
        {
            trigger enableplayeruse( player );
        }
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1ae1
// Size: 0x6c
function disallowplayertobreach( player )
{
    if ( isdefined( level.breachusetriggers ) )
    {
        foreach ( trigger in level.breachusetriggers )
        {
            trigger disableplayeruse( player );
        }
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1b55
// Size: 0x26
function defusec4( player )
{
    self.defused = 1;
    self notify( "defused" );
    givedefusescore( player );
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1b83
// Size: 0xa3
function onplayerjoinedteam( player )
{
    foreach ( array in level.destructibles )
    {
        foreach ( d in array )
        {
            d applyinteractteam( player );
        }
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1c2e
// Size: 0x69
function assigninteractteam( teams )
{
    self.interactteams = teams;
    
    foreach ( player in level.players )
    {
        applyinteractteam( player );
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1c9f
// Size: 0x1c4
function applyinteractteam( player )
{
    if ( self.state == "destroyed" )
    {
        return;
    }
    
    if ( !isdefined( self.useobjects ) )
    {
        return;
    }
    
    if ( array_contains( self.interactteams, player.team ) )
    {
        if ( isdefined( self.plantedbomb ) )
        {
            self.timerobject hidefromplayer( player );
            
            foreach ( key, entry in self.useobjects )
            {
                if ( key == self.plantedkey )
                {
                    entry setuseholdduration( "duration_medium" );
                    entry enableplayeruse( player );
                    entry showtoplayer( player );
                    continue;
                }
                
                entry disableplayeruse( player );
                entry hidefromplayer( player );
            }
        }
        else
        {
            foreach ( key, entry in self.useobjects )
            {
                entry setuseholdduration( "duration_short" );
                entry enableplayeruse( player );
                entry showtoplayer( player );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.plantedbomb ) )
    {
        self.timerobject showtoplayer( player );
    }
    
    foreach ( entry in self.useobjects )
    {
        entry disableplayeruse( player );
        entry hidefromplayer( player );
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1e6b
// Size: 0x46
function givebreachscore( player )
{
    event = #"breach";
    points = scripts\mp\rank::getscoreinfovalue( event );
    player thread scripts\mp\rank::giverankxp( event, points );
    player thread scripts\mp\rank::scoreeventpopup( event );
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x1eb9
// Size: 0x46
function givedefusescore( player )
{
    event = #"breach_defuse";
    points = scripts\mp\rank::getscoreinfovalue( event );
    player thread scripts\mp\rank::giverankxp( event, points );
    player thread scripts\mp\rank::scoreeventpopup( event );
}

// Namespace destructible / scripts\mp\destructible
// Params 0
// Checksum 0x0, Offset: 0x1f07
// Size: 0x94
function givegunless()
{
    self endon( "death_or_disconnect" );
    gunless = makeweapon( "iw8_gunless" );
    _giveweapon( gunless, undefined, undefined, 1 );
    success = domonitoredweaponswitch( gunless, 0 );
    
    if ( success )
    {
        self.gunnlessweapon = gunless;
        val::set( "gunless", "weapon_switch", 0 );
        val::set( "gunless", "offhand_weapons", 0 );
        val::set( "gunless", "melee", 0 );
    }
    else
    {
        _takeweapon( gunless );
        forcevalidweapon();
    }
    
    return success;
}

// Namespace destructible / scripts\mp\destructible
// Params 0
// Checksum 0x0, Offset: 0x1fa4
// Size: 0xa8
function takegunless()
{
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( self.gunnlessweapon ) || !self hasweapon( self.gunnlessweapon ) )
    {
        return;
    }
    
    self.takinggunless = 1;
    
    while ( self hasweapon( self.gunnlessweapon ) )
    {
        if ( !iscurrentweapon( self.gunnlessweapon ) )
        {
            abortmonitoredweaponswitch( self.gunnlessweapon );
        }
        else
        {
            _takeweapon( self.gunnlessweapon );
            forcevalidweapon();
        }
        
        waitframe();
    }
    
    self.takinggunless = 0;
    self.gunnlessweapon = undefined;
    val::reset_all( "gunless" );
}

// Namespace destructible / scripts\mp\destructible
// Params 0
// Checksum 0x0, Offset: 0x2054
// Size: 0x13
function rockable_cars_init()
{
    waitframe();
    scripts\common\rockable_vehicles::rockable_cars_init();
    level thread rockable_cars_watch_players();
}

// Namespace destructible / scripts\mp\destructible
// Params 0
// Checksum 0x0, Offset: 0x206f
// Size: 0x48f
function rockable_cars_watch_players()
{
    if ( !isdefined( level.rockablecars ) || !isdefined( level.rockablecars.cars ) || level.rockablecars.cars.size == 0 )
    {
        return;
    }
    
    level endon( "game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isreallyalive( player ) )
            {
                continue;
            }
            
            if ( player ismantling() || !player isonground() )
            {
                continue;
            }
            
            car = player getmovingplatformparent();
            
            if ( !isdefined( car ) || !istrue( car.var_743ebab8013b6cde ) )
            {
                continue;
            }
            
            btwn = player.origin - car.toppoint;
            
            if ( vectordot( btwn, car.up ) < 0 )
            {
                continue;
            }
            
            forwarddot = vectordot( btwn, car.forward );
            var_4261b9974dee3bdb = abs( forwarddot );
            var_60bc4ce4bc1694b7 = var_4261b9974dee3bdb / car.halflength;
            
            if ( var_60bc4ce4bc1694b7 > 1 )
            {
                continue;
            }
            
            rightdot = vectordot( btwn, car.right );
            var_92bfbb64d47dfeec = abs( rightdot );
            halfwidthratio = var_92bfbb64d47dfeec / car.halfwidth;
            
            if ( halfwidthratio > 1 )
            {
                continue;
            }
            
            lengthstr = ter_op( forwarddot >= 0, "front", "back" );
            widthstr = ter_op( rightdot >= 0, "right", "left" );
            rockstr = lengthstr + "_" + widthstr;
            
            if ( isdefined( player.lastrock ) && player.lastrock == rockstr )
            {
                continue;
            }
            
            id = player getentitynumber();
            
            if ( !isdefined( car.players[ id ] ) )
            {
                car rockable_car_add_player( player );
            }
            
            car rockable_car_rock( player, var_60bc4ce4bc1694b7, halfwidthratio, forwarddot, rightdot, rockstr );
        }
        
        foreach ( car in level.rockablecars.cars )
        {
            if ( !isdefined( car ) )
            {
                continue;
            }
            
            foreach ( id, player in car.players )
            {
                touchdelay = gettime() - car.touchtimes[ id ];
                
                if ( !isdefined( player ) || !isreallyalive( player ) )
                {
                    car rockable_car_remove_player( player, id, undefined, 0 );
                    continue;
                }
                
                if ( player ismantling() || !player isonground() )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                movingplatformparent = player getmovingplatformparent();
                
                if ( !isdefined( movingplatformparent ) || movingplatformparent != car )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                btwn = player.origin - car.toppoint;
                
                if ( vectordot( btwn, car.up ) < 0 )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                forwarddot = vectordot( btwn, car.forward );
                var_4261b9974dee3bdb = abs( forwarddot );
                var_60bc4ce4bc1694b7 = var_4261b9974dee3bdb / car.halflength;
                
                if ( var_60bc4ce4bc1694b7 > 1 )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                rightdot = vectordot( btwn, car.right );
                var_92bfbb64d47dfeec = abs( rightdot );
                halfwidthratio = var_92bfbb64d47dfeec / car.halfwidth;
                
                if ( halfwidthratio > 1 )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                car.touchtimes[ id ] = gettime();
            }
        }
        
        waitframe();
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1
// Checksum 0x0, Offset: 0x2506
// Size: 0x3b
function rockable_car_add_player( player )
{
    id = player getentitynumber();
    self.players[ id ] = player;
    self.touchtimes[ id ] = gettime();
}

// Namespace destructible / scripts\mp\destructible
// Params 4
// Checksum 0x0, Offset: 0x2549
// Size: 0x99
function rockable_car_remove_player( player, id, touchdelay, var_bd8dbaf4dd9ca95d )
{
    if ( var_bd8dbaf4dd9ca95d )
    {
        if ( isdefined( touchdelay ) && touchdelay >= 200 )
        {
            self.players[ id ] = undefined;
            self.touchtimes[ id ] = undefined;
            self.rocktimes[ id ] = undefined;
            
            if ( isdefined( player ) )
            {
                player.lastrock = undefined;
            }
        }
        
        return;
    }
    
    self.players[ id ] = undefined;
    self.touchtimes[ id ] = undefined;
    self.rocktimes[ id ] = undefined;
    
    if ( isdefined( player ) )
    {
        player.lastrock = undefined;
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 6
// Checksum 0x0, Offset: 0x25ea
// Size: 0x83
function rockable_car_rock( player, var_60bc4ce4bc1694b7, halfwidthratio, forwarddot, rightdot, rockstr )
{
    if ( var_60bc4ce4bc1694b7 > 0.4 && halfwidthratio > 0 )
    {
        self setscriptablepartstate( "Anim_PlayerStandRock", rockstr, 0 );
        id = player getentitynumber();
        self.rocktimes[ id ] = gettime();
        player.lastrock = rockstr;
    }
}

// Namespace destructible / scripts\mp\destructible
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2675
// Size: 0x41
function private function_d9d163cad6ada2d2( scriptable )
{
    root = scriptable function_ec5f4851431f3382();
    
    if ( scriptable getscriptableparthasstate( root, "indestructible" ) )
    {
        scriptable setscriptablepartstate( root, "indestructible" );
    }
    
    scriptable setcandamage( 0 );
}

// Namespace destructible / scripts\mp\destructible
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x26be
// Size: 0x8a
function private function_3e24dd3358e863c7( scriptable )
{
    root = scriptable function_ec5f4851431f3382();
    
    if ( scriptable getscriptableparthasstate( root, "hidden" ) )
    {
        scriptable setscriptablepartstate( root, "hidden" );
        return;
    }
    
    assertmsg( "<dev string:x1c>" + scriptable.classname + "<dev string:x2b>" );
    scriptable.origin = ( scriptable.origin[ 0 ], scriptable.origin[ 1 ], -10000 );
}

// Namespace destructible / scripts\mp\destructible
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2750
// Size: 0x17
function private function_a06f32bc36f6c177( scriptable )
{
    scriptable scriptabledodamage( 1000000 );
}

// Namespace destructible / scripts\mp\destructible
// Params 0
// Checksum 0x0, Offset: 0x276f
// Size: 0x1a5
function function_aaab78a3cf337331()
{
    flag_wait( "scriptables_ready" );
    
    if ( getdvarint( @"hash_36c5173f77f2e050", 0 ) == 1 )
    {
        return;
    }
    
    gamemode = getgametype();
    var_693a38259797f9da = getdvarint( @"hash_f8f16985f63b083f", 0 ) == 1;
    
    if ( !isdefined( gamemode ) || !( isstartstr( gamemode, "cdl_" ) || var_693a38259797f9da ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_8aa11cb20211ed31 ) )
    {
        return;
    }
    
    foreach ( var_869d699197f920a2, mode in level.var_8aa11cb20211ed31 )
    {
        function = undefined;
        
        switch ( mode )
        {
            case #"hash_c91405ed9f2a6844":
                function = &function_d9d163cad6ada2d2;
                break;
            case #"hash_7ebb454a971d80d":
                function = &function_3e24dd3358e863c7;
                break;
            case #"hash_145971eb70575f25":
                function = &function_a06f32bc36f6c177;
                break;
            default:
                assertmsg( "<dev string:x73>" + mode + "<dev string:x95>" + var_869d699197f920a2 );
                continue;
        }
        
        scriptables = getscriptablearray( var_869d699197f920a2, "classname" );
        
        foreach ( scriptable in scriptables )
        {
            [[ function ]]( scriptable );
        }
    }
}

