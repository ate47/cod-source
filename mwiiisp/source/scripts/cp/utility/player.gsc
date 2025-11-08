#using script_cbb0697de4c5728;
#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\damage;
#using scripts\cp\utility;
#using scripts\cp\utility\entity;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace player;

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x6e9
// Size: 0x8d
function getstancecenter()
{
    if ( self getstance() == "crouch" )
    {
        center = self.origin + 0.5 * ( 0, 0, 48 );
    }
    else if ( self getstance() == "prone" )
    {
        center = self.origin + 0.5 * ( 0, 0, 20 );
    }
    else
    {
        center = self.origin + 0.5 * ( 0, 0, 64 );
    }
    
    return center;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x77f
// Size: 0x93
function getstancetop( stanceoverride )
{
    curstance = self getstance();
    
    if ( isdefined( stanceoverride ) )
    {
        curstance = stanceoverride;
    }
    
    if ( curstance == "crouch" )
    {
        center = self.origin + ( 0, 0, 48 );
    }
    else if ( curstance == "prone" )
    {
        center = self.origin + ( 0, 0, 20 );
    }
    else
    {
        center = self.origin + ( 0, 0, 64 );
    }
    
    return center;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x81b
// Size: 0x2f, Type: bool
function isreallyalive( player )
{
    return isalive( player ) && !isdefined( player.fauxdead ) && !istrue( self.delayedspawnedplayernotify );
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x853
// Size: 0x24, Type: bool
function isarchetype( type )
{
    return isdefined( self.loadoutarchetype ) && type == self.loadoutarchetype;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x880
// Size: 0xe, Type: bool
function isplayerads()
{
    return self playerads() > 0.5;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x897
// Size: 0x20
function setthirdpersondof( isenabled )
{
    if ( isenabled )
    {
        setdof_thirdperson();
        return;
    }
    
    setdof_default();
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x8bf
// Size: 0x144
function updatesessionstate( sessionstate, statusicon )
{
    assert( sessionstate == "playing" || sessionstate == "dead" || sessionstate == "spectator" || sessionstate == "intermission" );
    
    switch ( sessionstate )
    {
        case #"hash_6e223a17d0eb5015":
        case #"hash_7135993aa112803d":
            statusicon = "";
            break;
        case #"hash_9430ae82e6671e2a":
        case #"hash_cf14c509efeb3c87":
            if ( istrue( level.var_286c2c7b34d03b04 ) )
            {
                statusicon = "";
            }
            else if ( istrue( level.numlifelimited ) )
            {
                if ( istrue( self.tagavailable ) )
                {
                    statusicon = "hud_status_dogtag";
                }
                else if ( istrue( self.revivetriggeravailable ) )
                {
                    if ( isdefined( self.statusicon ) && self.statusicon == "hud_status_revive_or" )
                    {
                        statusicon = "hud_status_revive_or";
                    }
                    else
                    {
                        statusicon = "hud_status_revive_wh";
                    }
                }
                else
                {
                    statusicon = "hud_status_dead";
                }
            }
            else
            {
                statusicon = "hud_status_dead";
            }
            
            break;
    }
    
    if ( !isdefined( statusicon ) )
    {
        statusicon = "";
    }
    
    self.sessionstate = sessionstate;
    self.statusicon = statusicon;
    self setclientomnvar( "ui_session_state", sessionstate );
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0xa0b
// Size: 0x139
function get_players_watching( just_spectators, just_killcam )
{
    if ( !isdefined( just_spectators ) )
    {
        just_spectators = 0;
    }
    
    if ( !isdefined( just_killcam ) )
    {
        just_killcam = 0;
    }
    
    var_ade4ed7fadba8194 = self getentitynumber();
    players_watching = [];
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        var_7bec920eea9088e7 = 0;
        
        if ( !just_killcam )
        {
            if ( isdefined( player.team ) && ( player.team == "spectator" || player.sessionstate == "spectator" ) )
            {
                spectatingplayer = player getspectatingplayer();
                
                if ( isdefined( spectatingplayer ) && spectatingplayer == self )
                {
                    var_7bec920eea9088e7 = 1;
                }
            }
            
            if ( player.forcespectatorclient == var_ade4ed7fadba8194 )
            {
                var_7bec920eea9088e7 = 1;
            }
        }
        
        if ( !just_spectators )
        {
            if ( player.killcamentity == var_ade4ed7fadba8194 )
            {
                var_7bec920eea9088e7 = 1;
            }
        }
        
        if ( var_7bec920eea9088e7 )
        {
            players_watching[ players_watching.size ] = player;
        }
    }
    
    return players_watching;
}

// Namespace player / scripts\cp\utility\player
// Params 6
// Checksum 0x0, Offset: 0xb4d
// Size: 0xf2
function set_visionset_for_watching_players( new_visionset, var_98b0a8ec6eeff568, var_e0d7f346bd955cdc, var_fc0b50f08da38b65, just_spectators, just_killcam )
{
    players_watching = get_players_watching( just_spectators, just_killcam );
    
    foreach ( player in players_watching )
    {
        player notify( "changing_watching_visionset" );
        
        if ( isdefined( var_fc0b50f08da38b65 ) && var_fc0b50f08da38b65 )
        {
            player visionsetmissilecamforplayer( new_visionset, var_98b0a8ec6eeff568 );
        }
        else
        {
            player visionsetnakedforplayer( new_visionset, var_98b0a8ec6eeff568 );
        }
        
        if ( new_visionset != "" && isdefined( var_e0d7f346bd955cdc ) )
        {
            player thread reset_visionset_on_team_change( self, var_98b0a8ec6eeff568 + var_e0d7f346bd955cdc );
            player thread reset_visionset_on_disconnect( self );
            
            if ( player isinkillcam() )
            {
                player thread reset_visionset_on_spawn();
            }
        }
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0xc47
// Size: 0x22
function reset_visionset_on_spawn()
{
    self endon( "disconnect" );
    self waittill( "spawned" );
    self visionsetnakedforplayer( "", 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0xc71
// Size: 0x8e
function reset_visionset_on_team_change( var_d6263ebe22d2bee2, var_e4b1ee6125b0d25b )
{
    self endon( "changing_watching_visionset" );
    time_started = gettime();
    team_started = self.team;
    
    while ( gettime() - time_started < var_e4b1ee6125b0d25b * 1000 )
    {
        if ( self.team != team_started || !array_contains( var_d6263ebe22d2bee2 get_players_watching(), self ) )
        {
            self visionsetnakedforplayer( "", 0 );
            self notify( "changing_visionset" );
            break;
        }
        
        waitframe();
    }
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xd07
// Size: 0x2b
function reset_visionset_on_disconnect( entity_watching )
{
    self endon( "changing_watching_visionset" );
    entity_watching waittill( "disconnect" );
    self visionsetnakedforplayer( "", 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xd3a
// Size: 0x26
function restorebasevisionset( fadetime )
{
    if ( istrue( level.wpinprogress ) )
    {
        return;
    }
    
    self visionsetnakedforplayer( "", fadetime );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0xd68
// Size: 0x3e
function init_visionsetnight()
{
    if ( isdefined( level.nvgvisionsetoverride ) && isstring( level.nvgvisionsetoverride ) )
    {
        visionsetnight( level.nvgvisionsetoverride );
        return;
    }
    
    visionsetnight( "nvg_base_mp" );
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xdae
// Size: 0x2c
function overridevisionsetnightforlevel( newvisionset )
{
    assertex( isdefined( newvisionset ), "New VisionSet must be passed to function" );
    visionsetnight( newvisionset );
    level.nvgvisionsetoverride = newvisionset;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0xde2
// Size: 0x17
function resetvisionsetnighttodefault()
{
    level.nvgvisionsetoverride = undefined;
    visionsetnight( "nvg_base_mp" );
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xe01
// Size: 0x54
function isenemy( other )
{
    if ( level.teambased )
    {
        return ( other.team != self.team );
    }
    
    if ( isdefined( other.owner ) )
    {
        return ( other.owner != self );
    }
    
    return other != self;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0xe5d
// Size: 0xad
function getuniqueid()
{
    if ( !isdefined( self.pers ) )
    {
        self.pers = [];
    }
    
    if ( isdefined( self.pers[ "guid" ] ) )
    {
        return self.pers[ "guid" ];
    }
    
    playerguid = self getguid();
    
    if ( playerguid == "0000000000000000" )
    {
        if ( isdefined( level.guidgen ) )
        {
            level.guidgen++;
        }
        else
        {
            level.guidgen = 1;
        }
        
        playerguid = "script" + level.guidgen;
    }
    
    self.pers[ "guid" ] = playerguid;
    return self.pers[ "guid" ];
}

// Namespace player / scripts\cp\utility\player
// Params 4
// Checksum 0x0, Offset: 0xf13
// Size: 0x2d
function getplayersinradius( origin, radius, desiredteam, excludeent )
{
    return scripts\cp_mp\utility\player_utility::getplayersinradius( origin, radius, desiredteam, excludeent );
}

// Namespace player / scripts\cp\utility\player
// Params 4
// Checksum 0x0, Offset: 0xf49
// Size: 0x17a
function getplayersinradiusview( origin, radius, desiredteam, excludeent )
{
    var_305f0639560a5707 = [];
    playersinradius = getplayersinradius( origin, radius, desiredteam, excludeent );
    
    foreach ( player in playersinradius )
    {
        structcreated = undefined;
        tracepoints = [ player gettagorigin( "j_head" ), player gettagorigin( "j_mainroot" ), player gettagorigin( "tag_origin" ) ];
        
        for ( i = 0; i < tracepoints.size ; i++ )
        {
            if ( !scripts\engine\trace::ray_trace_passed( origin, tracepoints[ i ], level.characters, scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1 ) ) )
            {
                continue;
            }
            
            if ( !isdefined( structcreated ) )
            {
                var_305f0639560a5707[ var_305f0639560a5707.size ] = spawnstruct();
                var_305f0639560a5707[ var_305f0639560a5707.size - 1 ].player = player;
                var_305f0639560a5707[ var_305f0639560a5707.size - 1 ].visiblelocations = [];
                structcreated = 1;
            }
            
            var_305f0639560a5707[ var_305f0639560a5707.size - 1 ].visiblelocations[ var_305f0639560a5707[ var_305f0639560a5707.size - 1 ].visiblelocations.size ] = tracepoints[ i ];
        }
    }
    
    return var_305f0639560a5707;
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x10cc
// Size: 0x61, Type: bool
function isfriendly( teamtocheck, var_c4b81997f0120a97 )
{
    assertex( isdefined( var_c4b81997f0120a97 ), "isFriendlyTeam argument 2 is not defined" );
    
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( !isplayer( var_c4b81997f0120a97 ) && !isdefined( var_c4b81997f0120a97.team ) )
    {
        return false;
    }
    
    if ( teamtocheck != var_c4b81997f0120a97.team )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x1136
// Size: 0x7f
function _enablecollisionnotifies( bool )
{
    if ( !isdefined( self.enabledcollisionnotifies ) )
    {
        self.enabledcollisionnotifies = 0;
    }
    
    if ( bool )
    {
        if ( self.enabledcollisionnotifies == 0 )
        {
            self enablecollisionnotifies( 1 );
        }
        
        self.enabledcollisionnotifies++;
    }
    else
    {
        if ( self.enabledcollisionnotifies == 1 )
        {
            self enablecollisionnotifies( 0 );
        }
        
        self.enabledcollisionnotifies--;
    }
    
    assert( self.enabledcollisionnotifies >= 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x11bd
// Size: 0x98
function allow_dodge( bool )
{
    if ( self.loadoutarchetype != "archetype_scout" )
    {
        return;
    }
    
    if ( bool )
    {
        if ( !isdefined( self.disableddodge ) )
        {
            self.disableddodge = 0;
        }
        
        self.disableddodge--;
        assert( self.disableddodge >= 0 );
        
        if ( !self.disableddodge )
        {
            self allowdodge( 1 );
        }
        
        return;
    }
    
    if ( !isdefined( self.disableddodge ) )
    {
        self.disableddodge = 0;
    }
    
    self.disableddodge++;
    self allowdodge( 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x125d
// Size: 0x3c
function allow_gesture( bool, tag )
{
    if ( !isdefined( tag ) )
    {
        tag = "allow_gesture";
    }
    
    if ( !bool )
    {
        val::set( tag, "gesture", 0 );
        return;
    }
    
    val::reset_all( tag );
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x12a1
// Size: 0x62
function isplayerproxyagent( ent, player )
{
    proxyagent = 0;
    
    if ( isagent( ent ) && isdefined( ent.agent_type ) && ent.agent_type == "playerProxy" )
    {
        if ( ent.owner == player )
        {
            proxyagent = 1;
        }
    }
    
    return proxyagent;
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x130c
// Size: 0x41
function enableragdollzerog( arg, scale )
{
    if ( arg )
    {
        physics_setgravityragdollscalar( scale );
        level.ragdollzerog = 1;
        return;
    }
    
    physics_setgravityragdollscalar( 1 );
    level.ragdollzerog = undefined;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1355
// Size: 0xc, Type: bool
function isragdollzerog()
{
    return istrue( level.ragdollzerog );
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x136a
// Size: 0x79
function _visionsetnaked( visionset, time )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isai( player ) )
        {
            continue;
        }
        
        player visionsetnakedforplayer( visionset, time );
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x13ec
// Size: 0x3f
function hidehudenable()
{
    if ( !isdefined( self.ui_hudhidden ) )
    {
        self.hidehudenabled = 0;
    }
    
    if ( self.hidehudenabled == 0 )
    {
        self setclientomnvar( "ui_hide_hud", 1 );
    }
    
    self.hidehudenabled++;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1433
// Size: 0x4f
function hidehuddisable()
{
    assert( isdefined( self.hidehudenabled ) && self.hidehudenabled > 0, "hideHudDisable called when hud is not hidden." );
    
    if ( self.hidehudenabled == 1 )
    {
        self setclientomnvar( "ui_hide_hud", 0 );
    }
    
    self.hidehudenabled--;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x148a
// Size: 0xa8
function hideminimap( forcehide )
{
    if ( alwaysshowminimap() && !istrue( forcehide ) )
    {
        return;
    }
    
    if ( !isdefined( self.minimapstatetracker ) )
    {
        self.minimapstatetracker = 0;
    }
    
    var_5546bbd6b68a186d = self.minimapstatetracker;
    self.minimapstatetracker--;
    
    if ( self.minimapstatetracker < 0 )
    {
        self.minimapstatetracker = 0;
    }
    
    if ( istrue( forcehide ) || self.minimapstatetracker == 0 && var_5546bbd6b68a186d > self.minimapstatetracker )
    {
        self setclientomnvar( "ui_hide_minimap", 1 );
        
        if ( istrue( forcehide ) )
        {
            self.minimapstatetracker = 0;
        }
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x153a
// Size: 0x7b
function showminimap()
{
    if ( scripts\cp\utility::is_minimap_forcedisabled() )
    {
        /#
            self iprintln( "<dev string:x1c>" );
        #/
        
        return;
    }
    
    if ( !isdefined( self.minimapstatetracker ) )
    {
        self.minimapstatetracker = 0;
    }
    
    var_5546bbd6b68a186d = self.minimapstatetracker;
    self.minimapstatetracker++;
    
    if ( self.minimapstatetracker == 1 && var_5546bbd6b68a186d < self.minimapstatetracker )
    {
        self setclientomnvar( "ui_hide_minimap", 0 );
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x15bd
// Size: 0x29, Type: bool
function alwaysshowminimap()
{
    return istrue( level.minimaponbydefault ) || scripts\cp_mp\utility\game_utility::isbrstylegametype() || level.gametype == "brm";
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x15ef
// Size: 0x41, Type: bool
function isfemale()
{
    return isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female";
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x1639
// Size: 0xb0
function getlowestclientnum( players, var_e1fea15ff7126a10 )
{
    lowestclientnum = undefined;
    assertex( isdefined( players ), "getLowestClientNum: Players array is undefined." );
    
    foreach ( player in players )
    {
        if ( player.team != "spectator" && ( !var_e1fea15ff7126a10 || player scripts\cp_mp\utility\player_utility::_isalive() ) )
        {
            if ( !isdefined( lowestclientnum ) || player getentitynumber() < lowestclientnum )
            {
                lowestclientnum = player getentitynumber();
            }
        }
    }
    
    return lowestclientnum;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x16f2
// Size: 0xa5
function setusingremote( remotename )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
    
    assert( !isusingremote() );
    self.usingremote = remotename;
    val::set( "using_remote", "vehicle_use", 0 );
    val::set( "using_remote", "crate_use", 0 );
    val::set( "using_remote", "offhand_weapons", 0 );
    val::set( "using_remote", "ads", 0 );
    self setclientomnvar( "ui_using_killstreak_remote", 1 );
    self notify( "using_remote" );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x179f
// Size: 0x1a
function getremotename()
{
    assert( isusingremote() );
    return self.usingremote;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x17c2
// Size: 0x66
function clearusingremote( bypassweaponswitch )
{
    val::reset_all( "using_remote" );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 1;
    }
    
    self.usingremote = undefined;
    
    if ( !isdefined( bypassweaponswitch ) )
    {
        _freezecontrols( 0 );
    }
    
    self setclientomnvar( "ui_using_killstreak_remote", 0 );
    self notify( "stopped_using_remote" );
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x1830
// Size: 0xdf
function _freezecontrols( frozen, force )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
    }
    
    if ( frozen )
    {
        assert( !isdefined( force ) );
        self.pers[ "controllerFreezeStack" ]++;
    }
    else if ( istrue( force ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
    }
    else
    {
        self.pers[ "controllerFreezeStack" ]--;
    }
    
    if ( self.pers[ "controllerFreezeStack" ] <= 0 )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self freezecontrols( 0 );
        self.controlsfrozen = 0;
        return;
    }
    
    self freezecontrols( 1 );
    self.controlsfrozen = 1;
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x1917
// Size: 0xdf
function _freezelookcontrols( frozen, force )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerLookFreezeStack" ] ) )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
    }
    
    if ( frozen )
    {
        assert( !isdefined( force ) );
        self.pers[ "controllerLookFreezeStack" ]++;
    }
    else if ( istrue( force ) )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
    }
    else
    {
        self.pers[ "controllerLookFreezeStack" ]--;
    }
    
    if ( self.pers[ "controllerLookFreezeStack" ] <= 0 )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
        self freezelookcontrols( 0 );
        self.lookcontrolsfrozen = 0;
        return;
    }
    
    self freezelookcontrols( 1 );
    self.lookcontrolsfrozen = 1;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x19fe
// Size: 0x67
function getplayerforguid( guid )
{
    foreach ( player in level.players )
    {
        if ( player.guid == guid )
        {
            return player;
        }
    }
    
    return undefined;
}

// Namespace player / scripts\cp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x1a6e
// Size: 0xb3
function set_temp_energy_restore_rate( energygroup, temprate, time, untilfull )
{
    var_4c1e617deaa58718 = self energy_getrestorerate( energygroup );
    self.temprateset = 1;
    assertex( var_4c1e617deaa58718 != temprate, "Attempting to set temp recharge rate same as default rate." );
    self energy_setrestorerate( energygroup, temprate );
    
    if ( !isdefined( untilfull ) || !untilfull )
    {
        wait time;
    }
    else
    {
        assertex( temprate > 0, "attempted to set a zero restore rate until full" );
        maxenergy = self energy_getmax( energygroup );
        
        for ( ;; )
        {
            if ( self energy_getenergy( energygroup ) >= maxenergy )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    self energy_setrestorerate( energygroup, var_4c1e617deaa58718 );
    self.temprateset = 0;
}

// Namespace player / scripts\cp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x1b29
// Size: 0xb3
function set_temp_energy_rest_time( energygroup, tempresttime, time, untilfull )
{
    var_25c4d960831fd0a1 = self energy_getresttimems( energygroup );
    self.tempresttime = 1;
    assertex( var_25c4d960831fd0a1 != tempresttime, "Attempting to set temp rest Time same as default." );
    self energy_setresttimems( energygroup, tempresttime );
    
    if ( !isdefined( untilfull ) || !untilfull )
    {
        wait time;
    }
    else
    {
        assertex( tempresttime > 0, "attempted to set a zero rest time until full" );
        maxenergy = self energy_getmax( energygroup );
        
        for ( ;; )
        {
            if ( self energy_getenergy( energygroup ) >= maxenergy )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    self energy_setresttimems( energygroup, var_25c4d960831fd0a1 );
    self.tempresttime = 0;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1be4
// Size: 0x3c
function _enableignoreme()
{
    if ( !isdefined( self.enabledignoreme ) )
    {
        self.enabledignoreme = 0;
    }
    
    if ( self.enabledignoreme == 0 )
    {
        self.ignoreme = 1;
    }
    
    self.enabledignoreme++;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1c28
// Size: 0x4c
function _disableignoreme()
{
    assert( isdefined( self.enabledignoreme ) && self.enabledignoreme > 0, "_disableIgnoreMe when ignoreme is already disabled." );
    
    if ( self.enabledignoreme == 1 )
    {
        self.ignoreme = 0;
    }
    
    self.enabledignoreme--;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1c7c
// Size: 0x16
function _resetenableignoreme()
{
    self.enabledignoreme = undefined;
    self.ignoreme = 0;
}

// Namespace player / scripts\cp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x1c9a
// Size: 0xd7
function watchbuttonpressed( key, commanddown, commandup, startpressed )
{
    if ( !isdefined( self.buttonspressed ) )
    {
        self.buttonspressed = [];
    }
    
    if ( !isdefined( self.buttonspressed[ key ] ) )
    {
        struct = spawnstruct();
        struct.player = self;
        struct.key = key;
        struct.commanddown = commanddown;
        struct.commandup = commandup;
        struct.notifydown = key + "_buttonDown";
        struct.notifyup = key + "_buttonUp";
        struct.pressed = istrue( startpressed );
        self.buttonspressed[ key ] = struct;
        struct thread watchbuttonpressedinternal();
    }
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x1d79
// Size: 0x40
function getbuttonpressed( key )
{
    if ( !isdefined( self.buttonspressed ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.buttonspressed[ key ] ) )
    {
        return 0;
    }
    
    return self.buttonspressed[ key ].pressed;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x1dc2
// Size: 0x4c
function watchbuttonpressedend( key )
{
    if ( !isdefined( self ) || !isdefined( self.buttonspressed ) || self.buttonspressed[ key ] )
    {
        return;
    }
    
    self.buttonspressed[ key ] notify( "watchButtonPressedEnd" );
    self.buttonspressed[ key ] = undefined;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1e16
// Size: 0x95
function watchbuttonpressedinternal()
{
    self.player endon( "disconnect" );
    self endon( "watchButtonPressedEnd" );
    
    while ( true )
    {
        self.down = 0;
        self.up = 0;
        childthread watchbuttondown();
        childthread watchbuttonup();
        self waittill( "start_race" );
        waittillframeend();
        self notify( "end_race" );
        
        if ( self.down && self.up )
        {
            continue;
        }
        
        if ( self.down )
        {
            self.pressed = 1;
            continue;
        }
        
        self.pressed = 0;
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1eb3
// Size: 0x51
function watchbuttondown()
{
    self endon( "end_race" );
    self.player notifyonplayercommand( self.notifydown, self.commanddown );
    self.player waittill( self.notifydown );
    self.down = 1;
    self notify( "start_race" );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1f0c
// Size: 0x51
function watchbuttonup()
{
    self endon( "end_race" );
    self.player notifyonplayercommand( self.notifyup, self.commandup );
    self.player waittill( self.notifyup );
    self.up = 1;
    self notify( "start_race" );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1f65
// Size: 0x21
function watchbuttonpressendondisconnect()
{
    self endon( "watchButtonPressedEnd" );
    self.player waittill( "disconnect" );
    self notify( "watchButtonPressedEnd" );
}

// Namespace player / scripts\cp\utility\player
// Params 6
// Checksum 0x0, Offset: 0x1f8e
// Size: 0x91
function _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur )
{
    if ( true )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    nearstart = max( nearstart, 0 );
    nearend = clamp( nearend, 1, 9994 );
    farstart = clamp( farstart, 2, 9998 );
    farend = clamp( farend, 3, 9999 );
    
    if ( farstart > 9994 )
    {
        farblur = 0;
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2027
// Size: 0x63b
function setdof_dynamic()
{
    self endon( "death_or_disconnect" );
    setdof_default();
    
    if ( isai( self ) )
    {
        return;
    }
    
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    playercontent = [ "physicscontents_characterproxy" ];
    var_30d537ea3164e799 = physics_createcontents( playercontent );
    useinterest = 1;
    tracegeo = 1;
    var_2e3c1d928388c537 = cos( 27 );
    var_a906be9cea201732 = 1;
    var_641ef3fc1ef694a5 = 0;
    dofsettings = [];
    dofsettings[ "geo" ] = spawnstruct();
    dofsettings[ "geo" ].nearstartfactor = getdvarfloat( @"hash_477d20ac52a6d418", 0.01 );
    dofsettings[ "geo" ].nearendfactor = getdvarfloat( @"hash_e3404a5a9ae5315d", 0.95 );
    dofsettings[ "geo" ].farstartfactor = getdvarfloat( @"hash_3207700a54cd601", 1.5 );
    dofsettings[ "geo" ].farendfactor = getdvarfloat( @"hash_db3504caf0e15404", 2.5 );
    dofsettings[ "geo" ].nearblur = getdvarfloat( @"hash_ae45baa306e4ae81", 3.9 );
    dofsettings[ "geo" ].farblur = getdvarfloat( @"hash_8bc87003c9fc085e", 2.25 );
    dofsettings[ "interest" ] = spawnstruct();
    dofsettings[ "interest" ].nearstartfactor = getdvarfloat( @"dof_nearstart", 0.01 );
    dofsettings[ "interest" ].nearendfactor = getdvarfloat( @"dof_nearend", 0.95 );
    dofsettings[ "interest" ].farstartfactor = getdvarfloat( @"dof_farstart", 1.5 );
    dofsettings[ "interest" ].farendfactor = getdvarfloat( @"dof_farend", 2.5 );
    dofsettings[ "interest" ].nearblur = getdvarfloat( @"dof_nearblur", 7 );
    dofsettings[ "interest" ].farblur = getdvarfloat( @"dof_farblur", 3.5 );
    
    while ( true )
    {
        waitframe();
        usesetting = "geo";
        
        if ( istrue( self.usingcustomdof ) )
        {
            continue;
        }
        
        var_a519a2a30c26b6da = self playerads() > 0.9;
        
        if ( var_a906be9cea201732 && !var_a519a2a30c26b6da )
        {
            if ( var_641ef3fc1ef694a5 )
            {
                var_641ef3fc1ef694a5 = 0;
                _setdof_internal( 0, 0, 512, 512, 4, 0 );
            }
            
            continue;
        }
        
        startpos = self geteye();
        viewangles = self getplayerangles();
        fwd = anglestoforward( viewangles );
        disttotarget = -1;
        neardist = undefined;
        fardist = undefined;
        bestenemy = undefined;
        tracedist = undefined;
        
        if ( useinterest )
        {
            bestdot = 0;
            
            foreach ( enemy in level.players )
            {
                if ( !scripts\cp_mp\utility\player_utility::playersareenemies( self, enemy ) )
                {
                    continue;
                }
                
                if ( !enemy scripts\cp_mp\utility\player_utility::_isalive() )
                {
                    continue;
                }
                
                enemypos = enemy geteye();
                headdot = vectordot( fwd, vectornormalize( enemypos - startpos ) );
                
                if ( headdot < var_2e3c1d928388c537 )
                {
                    continue;
                }
                
                dist = distance( startpos, enemypos );
                
                if ( !isdefined( neardist ) || dist < neardist )
                {
                    if ( enemy sightconetrace( startpos, self ) > 0 )
                    {
                        neardist = dist;
                    }
                }
                
                if ( !isdefined( fardist ) || dist > fardist )
                {
                    if ( enemy sightconetrace( startpos, self ) > 0 )
                    {
                        fardist = dist;
                    }
                }
            }
        }
        
        endpos = startpos + fwd * 10000;
        trace = scripts\engine\trace::sphere_trace( startpos, endpos, 0.1, self, contentoverride, 0 );
        tracedist = distance( startpos, trace[ "position" ] );
        playertrace = scripts\engine\trace::sphere_trace( startpos, endpos, 20, self, var_30d537ea3164e799, 0 );
        traceent = playertrace[ "entity" ];
        entisenemy = isdefined( traceent ) && isplayer( traceent ) && scripts\cp_mp\utility\player_utility::playersareenemies( self, traceent );
        var_59131f90f8665fae = entisenemy && traceent sightconetrace( startpos, self ) > 0;
        
        if ( !isdefined( neardist ) || tracedist < neardist )
        {
            neardist = tracedist;
        }
        
        if ( !isdefined( fardist ) || tracedist > fardist )
        {
            fardist = tracedist;
        }
        
        var_641ef3fc1ef694a5 = 1;
        middist = max( abs( neardist - fardist ) * 0.5, 300 );
        nearstart = 0;
        nearend = max( neardist - 50, 1 );
        farstart = fardist + 50;
        farend = farstart + middist;
        nearblur = ter_op( var_59131f90f8665fae, 6, 4 );
        farblur = ter_op( var_59131f90f8665fae, 2.5, 1.25 );
        _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur );
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x266a
// Size: 0x22
function setdof_killer()
{
    self endon( "disconnect" );
    self.usingcustomdof = 1;
    setdof_killer_update();
    setdof_default();
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2694
// Size: 0x1be
function setdof_killer_update()
{
    self endon( "disconnect" );
    self endon( "death_delay_finished" );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    tokiller = vectornormalize( self.origin - self.lastkilledby.origin );
    startpos = self.origin + ( 0, 0, 42 );
    endpos = startpos + tokiller * 120;
    trace = scripts\engine\trace::sphere_trace( startpos, endpos, 2, self, contentoverride, 0 );
    camposition = trace[ "position" ];
    
    while ( istrue( self.usingcustomdof ) )
    {
        if ( !isdefined( self.lastkilledby ) )
        {
            break;
        }
        
        disttotarget = distance( camposition, self.lastkilledby.origin );
        nearstart = 0;
        nearend = max( disttotarget - 12, 1 );
        farstart = disttotarget + 12;
        farend = farstart + 50;
        nearblur = 8;
        farblur = 4.5;
        _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur );
        waitframe();
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x285a
// Size: 0x1e
function setdof_default()
{
    self.usingcustomdof = 0;
    _setdof_internal( 0, 0, 512, 512, 4, 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2880
// Size: 0x1f
function setdof_spectator()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 0, 512, 512, 4, 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x28a7
// Size: 0x24
function setdof_infil()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 128, 512, 4000, 6, 1.8 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x28d3
// Size: 0x25
function setdof_apache()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 7, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2900
// Size: 0x25
function setdof_cruisethird()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 7, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x292d
// Size: 0x21
function setdof_cruisefirst()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 1000, 7, 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2956
// Size: 0x25
function setdof_tank()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 120, 1000, 6500, 7, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2983
// Size: 0x24
function setdof_thirdperson()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 110, 512, 4096, 6, 1.8 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x29af
// Size: 0x21
function setdof_gunship()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 1000, 7, 0 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x29d8
// Size: 0x22
function setdof_gunship_zoom()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 10, 5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2a02
// Size: 0x25
function setdof_scrambler_strength_1()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 5000, 4, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2a2f
// Size: 0x28
function setdof_scrambler_strength_2()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 800, 4000, 4.5, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2a5f
// Size: 0x25
function setdof_scrambler_strength_3()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 600, 3000, 5, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2a8c
// Size: 0x28
function setdof_scrambler_strength_4()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 500, 2000, 5.5, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2abc
// Size: 0x25
function setdof_scrambler_strength_5()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 400, 1000, 6, 3.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2ae9
// Size: 0x40
function clearkillcamstate()
{
    self.forcespectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.archiveusepotg = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2b31
// Size: 0x43
function isinkillcam()
{
    if ( isai( self ) )
    {
        return 0;
    }
    
    if ( self.spectatekillcam )
    {
        if ( self.forcespectatorclient == -1 && self.killcamentity == -1 )
        {
            return 0;
        }
    }
    
    return self.spectatekillcam;
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x2b7d
// Size: 0x85
function waittillrecoveredhealth( time, interval )
{
    self endon( "death_or_disconnect" );
    fullhealthtime = 0;
    
    if ( !isdefined( interval ) )
    {
        interval = 0.05;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    while ( true )
    {
        if ( self.health != self.maxhealth )
        {
            fullhealthtime = 0;
        }
        else
        {
            fullhealthtime += interval;
        }
        
        wait interval;
        
        if ( self.health == self.maxhealth && fullhealthtime >= time )
        {
            break;
        }
    }
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x2c0b
// Size: 0x41
function _setsuit( suit )
{
    if ( isdefined( self.suit ) && self.suit == suit )
    {
        return;
    }
    
    self setsuit( suit );
    self.suit = suit;
    namespace_46e942396566f2da::function_7c62c6c14aba289b();
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x2c54
// Size: 0xd8
function earthquake_for_client( var_46a291e8d3338ad9, var_cc2caa1cddc1e026 )
{
    if ( !isdefined( self.eq ) )
    {
        init_earthquake_for_client();
    }
    
    if ( !isdefined( var_cc2caa1cddc1e026 ) )
    {
        var_cc2caa1cddc1e026 = 0;
    }
    
    partname = undefined;
    
    if ( var_cc2caa1cddc1e026 )
    {
        partname = level.eqforclient.partnamesview[ var_46a291e8d3338ad9 ];
    }
    else
    {
        partname = level.eqforclient.partnames[ var_46a291e8d3338ad9 ];
    }
    
    curstate = self.eq.curstates[ partname ];
    statename = "active" + curstate;
    self setscriptablepartstate( partname, statename, 0 );
    curstate++;
    
    if ( curstate > 4 )
    {
        curstate = mod( curstate, 4 );
    }
    
    self.eq.curstates[ partname ] = curstate;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2d34
// Size: 0xe7
function clear_earthquake_for_client()
{
    if ( !isdefined( self.eq ) )
    {
        return;
    }
    
    if ( !isdefined( level.eqforclient ) )
    {
        init_earthquake();
    }
    
    foreach ( partname in level.eqforclient.partnames )
    {
        self setscriptablepartstate( partname, "neutral", 0 );
    }
    
    foreach ( partname in level.eqforclient.partnamesview )
    {
        self setscriptablepartstate( partname, "neutral", 0 );
    }
    
    self.eq = undefined;
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x2e23
// Size: 0xd8
function rumble_for_client( var_46a291e8d3338ad9, var_cc2caa1cddc1e026 )
{
    if ( !isdefined( self.rumb ) )
    {
        init_rumble_for_client();
    }
    
    if ( !isdefined( var_cc2caa1cddc1e026 ) )
    {
        var_cc2caa1cddc1e026 = 0;
    }
    
    partname = undefined;
    
    if ( var_cc2caa1cddc1e026 )
    {
        partname = level.rumbforclient.partnamesview[ var_46a291e8d3338ad9 ];
    }
    else
    {
        partname = level.rumbforclient.partnames[ var_46a291e8d3338ad9 ];
    }
    
    curstate = self.rumb.curstates[ partname ];
    statename = "active" + curstate;
    self setscriptablepartstate( partname, statename, 0 );
    curstate++;
    
    if ( curstate > 4 )
    {
        curstate = mod( curstate, 4 );
    }
    
    self.rumb.curstates[ partname ] = curstate;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2f03
// Size: 0xd3
function clear_rumble_for_client()
{
    if ( !isdefined( self.rumb ) )
    {
        return;
    }
    
    foreach ( partname in level.rumbforclient.partnames )
    {
        self setscriptablepartstate( partname, "neutral", 0 );
    }
    
    foreach ( partname in level.rumbforclient.partnamesview )
    {
        self setscriptablepartstate( partname, "neutral", 0 );
    }
    
    self.rumb = undefined;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2fde
// Size: 0xab
function init_earthquake()
{
    level.eqforclient = spawnstruct();
    partnames = [];
    var_4e578e99aed19b32 = "shake" + "eq";
    
    for ( i = 1; i <= 4 ; i++ )
    {
        partnames[ i ] = var_4e578e99aed19b32 + i;
    }
    
    level.eqforclient.partnames = partnames;
    partnames = [];
    var_4e578e99aed19b32 = "shake" + "eq" + "view";
    
    for ( i = 1; i <= 4 ; i++ )
    {
        partnames[ i ] = var_4e578e99aed19b32 + i;
    }
    
    level.eqforclient.partnamesview = partnames;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3091
// Size: 0xee
function init_earthquake_for_client()
{
    if ( !isdefined( level.eqforclient ) )
    {
        init_earthquake();
    }
    
    self.eq = spawnstruct();
    curstates = [];
    
    foreach ( partname in level.eqforclient.partnames )
    {
        curstates[ partname ] = 1;
    }
    
    foreach ( partname in level.eqforclient.partnamesview )
    {
        curstates[ partname ] = 1;
    }
    
    self.eq.curstates = curstates;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3187
// Size: 0xab
function init_rumble()
{
    level.rumbforclient = spawnstruct();
    partnames = [];
    var_4e578e99aed19b32 = "shake" + "rumb";
    
    for ( i = 1; i <= 4 ; i++ )
    {
        partnames[ i ] = var_4e578e99aed19b32 + i;
    }
    
    level.rumbforclient.partnames = partnames;
    partnames = [];
    var_4e578e99aed19b32 = "shake" + "rumb" + "view";
    
    for ( i = 1; i <= 4 ; i++ )
    {
        partnames[ i ] = var_4e578e99aed19b32 + i;
    }
    
    level.rumbforclient.partnamesview = partnames;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x323a
// Size: 0xee
function init_rumble_for_client()
{
    if ( !isdefined( level.rumbforclient ) )
    {
        init_rumble();
    }
    
    self.rumb = spawnstruct();
    curstates = [];
    
    foreach ( partname in level.rumbforclient.partnames )
    {
        curstates[ partname ] = 1;
    }
    
    foreach ( partname in level.rumbforclient.partnamesview )
    {
        curstates[ partname ] = 1;
    }
    
    self.rumb.curstates = curstates;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x3330
// Size: 0x3e
function teleport_player( object )
{
    self setorigin( object.origin );
    
    if ( isdefined( object.angles ) )
    {
        self setplayerangles( object.angles );
    }
}

// Namespace player / scripts\cp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x3376
// Size: 0xaf
function function_678eed0af59b69eb( breath, isbreathcritical, var_21c40030c467a5f6, var_247ffbb0ea77edf7 )
{
    if ( isbreathcritical )
    {
        colormax = ( 0.15, 0.7, 0.7 );
        colormin = ( 0.7, 0.4, 0.4 );
        factor = math::normalize_value( 0, var_21c40030c467a5f6, breath );
    }
    else
    {
        colormax = ( 0.1, 0.1, 0.1 );
        colormin = ( 0.1, 0.5, 0.5 );
        factor = math::normalize_value( var_21c40030c467a5f6, var_247ffbb0ea77edf7, breath );
    }
    
    color = math::factor_value( colormin, colormax, factor );
    return color;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x342e
// Size: 0x1d
function function_8196ea3bc8d5538a()
{
    if ( isdefined( level.var_fd357adea109f55 ) )
    {
        self thread [[ level.var_fd357adea109f55 ]]();
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3453
// Size: 0x15d
function function_1c0f3b6933eb1c87()
{
    level endon( "game_ended" );
    flag_wait( "player_spawned_with_loadout" );
    level.player endon( "death" );
    level.foliagecontent = scripts\engine\trace::function_416688b9ffe933c4();
    shadow_vols = array_merge( getentarray( "shadow_vol", "targetname" ), getentarray( "tall_grass_vol", "targetname" ) );
    level.var_1c0f3b6933eb1c87 = 1;
    
    while ( true )
    {
        player_touching = 0;
        
        foreach ( vol in shadow_vols )
        {
            if ( level.player istouching( vol ) )
            {
                player_touching += 1;
            }
        }
        
        if ( player_touching > 0 )
        {
            setplayerobscured( level.player, 1 );
            level.var_1c0f3b6933eb1c87 = 1;
        }
        else if ( function_ebf6c163be94738a() )
        {
            setplayerobscured( level.player, 1 );
            level.var_1c0f3b6933eb1c87 = 1;
            player_touching = 1;
        }
        else
        {
            setplayerobscured( level.player, 0 );
            level.var_1c0f3b6933eb1c87 = 0;
        }
        
        level.player function_d5ab926594e0b3f3( function_9bb204334d8c88e( player_touching ) );
        waitframe();
    }
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x35b8
// Size: 0x76, Type: bool
function function_ebf6c163be94738a()
{
    assertex( isdefined( level.foliagecontent ), "Script expects there to be a predefined value of level.foliageContent in this level." );
    
    if ( level.player getstance() == "stand" )
    {
        return false;
    }
    
    if ( !scripts\engine\trace::sphere_trace_passed( level.player geteye(), level.player geteye() - ( 0, 0, 15 ), 20, undefined, level.foliagecontent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x3637
// Size: 0x35, Type: bool
function function_9bb204334d8c88e( var_bf8b0540bf4c4150 )
{
    if ( level.player getstance() == "stand" )
    {
        return false;
    }
    
    if ( !isdefined( var_bf8b0540bf4c4150 ) )
    {
        return false;
    }
    
    if ( var_bf8b0540bf4c4150 <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x3675
// Size: 0x28
function function_d5ab926594e0b3f3( shoulddisplay )
{
    if ( self getclientomnvar( "ui_display_foliage_vignette" ) != shoulddisplay )
    {
        self setclientomnvar( "ui_display_foliage_vignette", shoulddisplay );
    }
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x36a5
// Size: 0x146
function remove_damage_effects_instantly( var_2625c6f710d4e980 )
{
    self notify( "stopPainOverlays" );
    
    if ( !isdefined( var_2625c6f710d4e980 ) )
    {
        var_2625c6f710d4e980 = 0;
    }
    
    self painvisionoff();
    
    if ( utility::damageflag( 2 ) )
    {
        scripts\cp\damage::disabledeathsdoor( 1 );
    }
    
    removefiredamageimmediate();
    removeradialdistortion( 0 );
    stopimpactsfx();
    
    if ( !var_2625c6f710d4e980 )
    {
        foreach ( overlay in self.damage.activescreeneffectoverlays )
        {
            overlay notify( "destroySreenEffectOverlay" );
        }
    }
    
    if ( isdefined( self.damage.overlay ) )
    {
        self.damage.overlay destroy();
    }
    
    if ( isdefined( self.damage.bloodoverlay ) )
    {
        self.damage.bloodoverlay destroy();
    }
    
    if ( isdefined( self.damage.deathsdooroverlaypulse ) )
    {
        self.damage.deathsdooroverlaypulse destroy();
    }
    
    scripts\cp\damage::initdamageoverlay();
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x37f3
// Size: 0x44
function removefiredamageimmediate()
{
    if ( !utility::damageflag( 32 ) )
    {
        return;
    }
    
    self notify( "damage_fire" );
    self.damage.firedamage = 0;
    
    if ( utility::damageflag( 16 ) )
    {
        setplayeroutoffire();
    }
    
    setplayerofffire();
}

// Namespace player / scripts\cp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x383f
// Size: 0x57
function removeradialdistortion( outtime )
{
    childthread scripts\common\lighting::lerp_dvar( @"hash_ed28298c207316ae", 0, outtime );
    childthread scripts\common\lighting::lerp_dvar( @"hash_979b5474be3b9b47", 0, outtime );
    childthread scripts\common\lighting::lerp_dvar( @"hash_960ef00238357bbc", 0, outtime );
    childthread scripts\common\lighting::lerp_dvar( @"hash_bc02f8e41595c9a8", 0, outtime );
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x389e
// Size: 0x1b
function stopimpactsfx()
{
    self.damage.impactsfx stopsounds();
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x38c1
// Size: 0x13
function setplayeroutoffire()
{
    utility::setdamageflag( 16, 0 );
    firedamagegesturesoff();
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x38dc
// Size: 0x1b
function setplayerofffire()
{
    self notify( "damage_fire_off" );
    utility::setdamageflag( 32, 0 );
    firedamagefxoff();
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x38ff
// Size: 0x5c
function firedamagegesturesoff()
{
    if ( !isdefined( level.player.firegesture ) )
    {
        return;
    }
    
    level.player stopgestureviewmodel( "ges_player_onfire", 0.5, 0 );
    level.player val::reset_all( "onfire" );
    level.player.firegesture = undefined;
}

// Namespace player / scripts\cp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3963
// Size: 0xd2
function firedamagefxoff()
{
    self.damage.firevfx delete();
    self.damage.firerumble delete();
    thread fadeoverlayanddestroy( self.damage.firedamageoverlay, 1 );
    thread fadeoverlayanddestroy( self.damage.firepainoverlay, 1 );
    thread fadesoundanddelete( self.damage.firesfx, 1 );
    thread fadesoundanddelete( self.damage.firedronesfx, 1 );
    thread fadesoundanddelete( self.damage.firesmolsfx, 1 );
    thread removeradialdistortion( 0.5 );
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x3a3d
// Size: 0x44
function fadeoverlayanddestroy( overlay, fadetime )
{
    self endon( "damage_fire" );
    
    if ( !isdefined( overlay ) )
    {
        return;
    }
    
    overlay fadeovertime( fadetime );
    overlay.alpha = 0;
    wait fadetime;
    
    if ( !isdefined( overlay ) )
    {
        return;
    }
    
    overlay destroy();
}

// Namespace player / scripts\cp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x3a89
// Size: 0x2f
function fadesoundanddelete( soundent, fadetime )
{
    self endon( "damage_fire" );
    
    if ( !isdefined( soundent ) )
    {
        return;
    }
    
    wait fadetime;
    
    if ( !isdefined( soundent ) )
    {
        return;
    }
    
    soundent delete();
}

