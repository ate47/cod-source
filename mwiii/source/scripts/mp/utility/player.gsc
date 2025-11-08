#using script_cbb0697de4c5728;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\nvg;
#using scripts\mp\gametypes\bigctf;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk_shared;

#namespace player;

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x7a2
// Size: 0x8e
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x839
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
        top = self.origin + ( 0, 0, 48 );
    }
    else if ( curstance == "prone" )
    {
        top = self.origin + ( 0, 0, 20 );
    }
    else
    {
        top = self.origin + ( 0, 0, 64 );
    }
    
    return top;
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x8d5
// Size: 0x41, Type: bool
function isreallyalive( player )
{
    return isalive( player ) && !isdefined( player.fauxdead ) && !istrue( player.delayedspawnedplayernotify ) && !istrue( player.liveragdoll );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x91f
// Size: 0x17, Type: bool
function isinlaststand( player )
{
    return istrue( player.inlaststand );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x93f
// Size: 0x37, Type: bool
function function_d7afe062ef51bd77( player )
{
    return isdefined( player ) && isdefined( player.var_2fb534abd9eb93ca ) && !player.var_2fb534abd9eb93ca && isinlaststand( player );
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x97f
// Size: 0x11d
function function_311066dfee085643( player, damagetype )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_fd29493b5da45e74 ) )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_fd29493b5da45e74.var_311066dfee085643 ) )
    {
        return 0;
    }
    
    var_1d80fb7b86315948 = player.var_fd29493b5da45e74.var_311066dfee085643;
    
    if ( isdefined( damagetype ) )
    {
        switch ( damagetype )
        {
            case #"hash_145e286717e1f4c3":
                return ( var_1d80fb7b86315948 && level.var_409e54f81172d6d8.headshotprotection );
            case #"hash_1cb749d9b456c694":
                return ( var_1d80fb7b86315948 && level.var_409e54f81172d6d8.explosiveprotection );
            case #"hash_e0788d0d9af05c73":
                return ( var_1d80fb7b86315948 && level.var_409e54f81172d6d8.worldprotection );
            case #"hash_40a94c5d9e4e265b":
                return ( var_1d80fb7b86315948 && level.var_409e54f81172d6d8.meleeprotection );
            default:
                return var_1d80fb7b86315948;
        }
    }
    else
    {
        return var_1d80fb7b86315948;
    }
    
    return 0;
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xaa5
// Size: 0x23, Type: bool
function isaliveandnotinlaststand( player )
{
    return isdefined( player ) && isreallyalive( player ) && !isinlaststand( player );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xad1
// Size: 0x24, Type: bool
function isarchetype( type )
{
    return isdefined( self.loadoutarchetype ) && type == self.loadoutarchetype;
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0xafe
// Size: 0xe, Type: bool
function isplayerads()
{
    return self playerads() > 0.5;
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xb15
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

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0xb3d
// Size: 0x1c
function updatesessionstate( sessionstate, statusicon )
{
    scripts\cp_mp\utility\player_utility::updatesessionstate( sessionstate, statusicon );
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0xb61
// Size: 0x10b
function getteamarray( team, var_dcc07fcc8a9beb59 )
{
    teamarray = [];
    
    if ( !isdefined( var_dcc07fcc8a9beb59 ) || var_dcc07fcc8a9beb59 )
    {
        foreach ( player in level.characters )
        {
            if ( isdefined( player.team ) && player.team == team )
            {
                teamarray[ teamarray.size ] = player;
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.team ) && player.team == team )
            {
                teamarray[ teamarray.size ] = player;
            }
        }
    }
    
    return teamarray;
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0xc75
// Size: 0x14d
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
            if ( isdefined( player.team ) && ( player.team == "spectator" || player.team == "codcaster" || player.sessionstate == "spectator" ) )
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

// Namespace player / scripts\mp\utility\player
// Params 6
// Checksum 0x0, Offset: 0xdcb
// Size: 0xf4
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0xec7
// Size: 0x22
function reset_visionset_on_spawn()
{
    self endon( "disconnect" );
    self waittill( "spawned" );
    self visionsetnakedforplayer( "", 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0xef1
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xf87
// Size: 0x2b
function reset_visionset_on_disconnect( entity_watching )
{
    self endon( "changing_watching_visionset" );
    entity_watching waittill( "disconnect" );
    self visionsetnakedforplayer( "", 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0xfba
// Size: 0x26
function restorebasevisionset( fadetime )
{
    if ( istrue( level.wpinprogress ) )
    {
        return;
    }
    
    self visionsetnakedforplayer( "", fadetime );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0xfe8
// Size: 0x3a
function init_visionsetnight()
{
    if ( isusingmatchrulesdata() )
    {
        nvgvisionset = getmatchrulesdata( "commonOption", "nvgVisionSet" );
        visionsetnight( nvgvisionset );
        return;
    }
    
    visionsetnight( "iw9_mp_nvg_base_color" );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x102a
// Size: 0x22
function overridevisionsetnightforlevel( newvisionset )
{
    assertex( isdefined( newvisionset ), "<dev string:x1c>" );
    visionsetnight( newvisionset );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1054
// Size: 0xae
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

// Namespace player / scripts\mp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x110b
// Size: 0x2d
function getplayersinradius( origin, radius, desiredteam, excludeent )
{
    return scripts\cp_mp\utility\player_utility::getplayersinradius( origin, radius, desiredteam, excludeent );
}

// Namespace player / scripts\mp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x1141
// Size: 0x178
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x12c2
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x1349
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

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x13e9
// Size: 0x63
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

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x1455
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x149e
// Size: 0xc, Type: bool
function isragdollzerog()
{
    return istrue( level.ragdollzerog );
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x14b3
// Size: 0x7c
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

// Namespace player / scripts\mp\utility\player
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1538
// Size: 0x29b
function private function_d93211a15c000cd( victim, attacker, var_d198b30dc157c5cd, contentoverride )
{
    assert( isdefined( victim ) && isent( victim ) );
    deathpos = undefined;
    
    if ( isdefined( victim.origin ) )
    {
        deathpos = victim.origin;
    }
    else if ( isdefined( victim.lastdeathpos ) )
    {
        deathpos = victim.lastdeathpos;
    }
    
    if ( !isdefined( deathpos ) )
    {
        logstring( "Undefined deathPos for death ragdoll 3rd person camera." );
        return undefined;
    }
    
    var_9f18d28ad3fbb53d = undefined;
    
    if ( !isdefined( attacker ) || victim == attacker )
    {
        forwardvector = anglestoforward( victim.angles );
        forwardvector = vectornormalize2( forwardvector );
        var_9f18d28ad3fbb53d = [ victim ];
    }
    else
    {
        forwardvector = vectornormalize( deathpos - attacker.origin );
        var_9f18d28ad3fbb53d = [ victim, attacker ];
    }
    
    baseangles = generateaxisanglesfromforwardvector( forwardvector, ( 0, 0, 1 ) );
    cameradistance = 200;
    stepangle = 30;
    maxsteps = 360 / stepangle;
    validpositions = [];
    
    for ( i = 0; i < maxsteps ; i++ )
    {
        stepvector = anglestoforward( baseangles + ( 0, stepangle * i, 0 ) );
        startposition = deathpos + ( 0, 0, 12 );
        endposition = deathpos + stepvector * cameradistance + ( 0, 0, 150 );
        trace = scripts\engine\trace::sphere_trace( startposition, endposition, 2, var_9f18d28ad3fbb53d, contentoverride );
        
        if ( isdefined( trace ) && trace[ "fraction" ] > 0.99 )
        {
            validpositions[ validpositions.size ] = trace[ "position" ];
            
            if ( !istrue( var_d198b30dc157c5cd ) )
            {
                break;
            }
        }
    }
    
    cameraposition = undefined;
    
    if ( validpositions.size > 0 )
    {
        cameraposition = validpositions[ 0 ];
    }
    else
    {
        cameraposition = deathpos + anglestoforward( baseangles ) * 50 + ( 0, 0, 80 );
    }
    
    victimdirection = vectornormalize( deathpos - cameraposition );
    cameradata = spawnstruct();
    cameradata.origin = cameraposition;
    cameradata.angles = vectortoangles( victimdirection );
    cameradata.distance = cameradistance;
    cameradata.validpositions = validpositions;
    return cameradata;
}

// Namespace player / scripts\mp\utility\player
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x17dc
// Size: 0x9
function private function_fdff38028c016239()
{
    scripts\cp_mp\utility\player_utility::function_fdff38028c016239();
}

// Namespace player / scripts\mp\utility\player
// Params 3
// Checksum 0x0, Offset: 0x17ed
// Size: 0x23
function function_6d606d81ea9ab50b( var_81aa39b3e585cd66, var_d198b30dc157c5cd, contentoverride )
{
    return scripts\cp_mp\utility\player_utility::function_6d606d81ea9ab50b( var_81aa39b3e585cd66, var_d198b30dc157c5cd );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1819
// Size: 0x19
function hidehudclear()
{
    self.hidehudenabled = undefined;
    self setclientomnvar( "ui_hide_hud", 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x183a
// Size: 0xa9
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x18eb
// Size: 0x63
function showminimap()
{
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1956
// Size: 0xc, Type: bool
function alwaysshowminimap()
{
    return istrue( level.minimaponbydefault );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x196b
// Size: 0x41, Type: bool
function isfemale()
{
    return isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female";
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x19b5
// Size: 0xc7
function getlowestclientnum( players, var_e1fea15ff7126a10 )
{
    lowestclientnum = undefined;
    assertex( isdefined( players ), "<dev string:x48>" );
    
    foreach ( player in players )
    {
        if ( player.team != "spectator" && player.team != "codcaster" && ( !var_e1fea15ff7126a10 || player scripts\cp_mp\utility\player_utility::_isalive() ) )
        {
            if ( !isdefined( lowestclientnum ) || player getentitynumber() < lowestclientnum )
            {
                lowestclientnum = player getentitynumber();
            }
        }
    }
    
    return lowestclientnum;
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x1a85
// Size: 0xd9
function setusingremote( remotename )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
    
    assert( !isusingremote() );
    self.usingremote = remotename;
    
    if ( scripts\mp\equipment\nvg::function_258c5e445c8b7f80() )
    {
        val::set( "usingRemote", "nvg", 0 );
    }
    
    val::set( "usingRemote", "vehicle_use", 0 );
    val::set( "usingRemote", "crate_use", 0 );
    val::set( "usingRemote", "offhand_weapons", 0 );
    val::set( "usingRemote", "ads", 0 );
    val::set( "usingRemote", "ascender_use", 0 );
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
    self setclientomnvar( "ui_using_killstreak_remote", 1 );
    self notify( "using_remote" );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1b66
// Size: 0x1a
function getremotename()
{
    assert( isusingremote() );
    return self.usingremote;
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x1b89
// Size: 0x73
function clearusingremote( bypassweaponswitch )
{
    val::reset_all( "usingRemote" );
    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 1;
    }
    
    self.usingremote = undefined;
    
    if ( !isdefined( bypassweaponswitch ) )
    {
        _freezecontrols( 0, undefined, "usingRemote" );
    }
    
    self setclientomnvar( "ui_using_killstreak_remote", 0 );
    self notify( "stopped_using_remote" );
}

// Namespace player / scripts\mp\utility\player
// Params 3
// Checksum 0x0, Offset: 0x1c04
// Size: 0x21c
function _freezecontrols( frozen, force, debug )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self.pers[ "controllerFreezeDebug" ] = [];
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
    
    if ( isdefined( debug ) )
    {
        if ( getdvarint( @"hash_fc8a67f104cc90a6", 0 ) )
        {
            logstring( "IW9-676465: Player " + self.name + " called _freezeControls( " + frozen + ", " + istrue( force ) + ", \"" + debug + "\" )" );
        }
        
        if ( frozen )
        {
            if ( !isdefined( self.pers[ "controllerFreezeDebug" ][ debug ] ) )
            {
                self.pers[ "controllerFreezeDebug" ][ debug ] = 0;
            }
            
            self.pers[ "controllerFreezeDebug" ][ debug ]++;
        }
        else if ( istrue( force ) )
        {
            self.pers[ "controllerFreezeDebug" ] = [];
        }
        else if ( !isdefined( self.pers[ "controllerFreezeDebug" ][ debug ] ) || self.pers[ "controllerFreezeDebug" ][ debug ] == 0 )
        {
            println( "<dev string:x7b>" + debug + "<dev string:xab>" );
        }
        else
        {
            self.pers[ "controllerFreezeDebug" ][ debug ]--;
            
            if ( self.pers[ "controllerFreezeDebug" ][ debug ] == 0 )
            {
                self.pers[ "controllerFreezeDebug" ][ debug ] = undefined;
            }
        }
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1e28
// Size: 0x149
function function_5471a04faad16a00()
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self.pers[ "controllerFreezeDebug" ] = [];
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
    
    if ( getdvarint( @"hash_fc8a67f104cc90a6", 0 ) )
    {
        var_d1d0a8a55841e44c = "";
        
        if ( isdefined( self.pers[ "controllerFreezeDebug" ] ) )
        {
            foreach ( context, contextcount in self.pers[ "controllerFreezeDebug" ] )
            {
                var_d1d0a8a55841e44c += context + "=" + contextcount + " | ";
            }
        }
        
        logstring( "IW9-676465: Player " + self.name + " was frozen after a _refreshFreezeControls(). Freeze Debug Stack: " + var_d1d0a8a55841e44c );
    }
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x1f79
// Size: 0xd7
function function_8213d31f7a3c32e2()
{
    stacksize = 0;
    
    if ( isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        stacksize = self.pers[ "controllerFreezeStack" ];
    }
    
    if ( stacksize <= 0 )
    {
        return;
    }
    
    var_d1d0a8a55841e44c = "";
    
    if ( isdefined( self.pers[ "controllerFreezeDebug" ] ) )
    {
        foreach ( context, contextcount in self.pers[ "controllerFreezeDebug" ] )
        {
            var_d1d0a8a55841e44c += context + "=" + contextcount + " | ";
        }
    }
    
    println( "<dev string:xb1>" + stacksize + "<dev string:xdb>" + var_d1d0a8a55841e44c );
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x2058
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x213f
// Size: 0x6a
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

// Namespace player / scripts\mp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x21b2
// Size: 0xb3
function set_temp_energy_restore_rate( energygroup, temprate, time, untilfull )
{
    var_4c1e617deaa58718 = self energy_getrestorerate( energygroup );
    self.temprateset = 1;
    assertex( var_4c1e617deaa58718 != temprate, "<dev string:xec>" );
    self energy_setrestorerate( energygroup, temprate );
    
    if ( !isdefined( untilfull ) || !untilfull )
    {
        wait time;
    }
    else
    {
        assertex( temprate > 0, "<dev string:x12a>" );
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

// Namespace player / scripts\mp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x226d
// Size: 0xb3
function set_temp_energy_rest_time( energygroup, tempresttime, time, untilfull )
{
    var_25c4d960831fd0a1 = self energy_getresttimems( energygroup );
    self.tempresttime = 1;
    assertex( var_25c4d960831fd0a1 != tempresttime, "<dev string:x15d>" );
    self energy_setresttimems( energygroup, tempresttime );
    
    if ( !isdefined( untilfull ) || !untilfull )
    {
        wait time;
    }
    else
    {
        assertex( tempresttime > 0, "<dev string:x192>" );
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2328
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x236c
// Size: 0x4c
function _disableignoreme()
{
    assert( isdefined( self.enabledignoreme ) && self.enabledignoreme > 0, "<dev string:x1c2>" );
    
    if ( self.enabledignoreme == 1 )
    {
        self.ignoreme = 0;
    }
    
    self.enabledignoreme--;
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x23c0
// Size: 0x16
function _resetenableignoreme()
{
    self.enabledignoreme = undefined;
    self.ignoreme = 0;
}

// Namespace player / scripts\mp\utility\player
// Params 4
// Checksum 0x0, Offset: 0x23de
// Size: 0xd8
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x24be
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x2507
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x255b
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x25f8
// Size: 0x51
function watchbuttondown()
{
    self endon( "end_race" );
    self.player notifyonplayercommand( self.notifydown, self.commanddown );
    self.player waittill( self.notifydown );
    self.down = 1;
    self notify( "start_race" );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2651
// Size: 0x51
function watchbuttonup()
{
    self endon( "end_race" );
    self.player notifyonplayercommand( self.notifyup, self.commandup );
    self.player waittill( self.notifyup );
    self.up = 1;
    self notify( "start_race" );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x26aa
// Size: 0x21
function watchbuttonpressendondisconnect()
{
    self endon( "watchButtonPressedEnd" );
    self.player waittill( "disconnect" );
    self notify( "watchButtonPressedEnd" );
}

// Namespace player / scripts\mp\utility\player
// Params 6
// Checksum 0x0, Offset: 0x26d3
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x276c
// Size: 0x619
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2d8d
// Size: 0x22
function setdof_killer()
{
    self endon( "disconnect" );
    self.usingcustomdof = 1;
    setdof_killer_update();
    setdof_default();
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2db7
// Size: 0x1b2
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

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2f71
// Size: 0x1e
function setdof_default()
{
    self.usingcustomdof = 0;
    _setdof_internal( 0, 0, 512, 512, 4, 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2f97
// Size: 0x1f
function setdof_spectator()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 0, 512, 512, 4, 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2fbe
// Size: 0x24
function setdof_infil()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 128, 512, 4000, 6, 1.8 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x2fea
// Size: 0x25
function setdof_apache()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 7, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3017
// Size: 0x25
function setdof_cruisethird()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 7, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3044
// Size: 0x21
function setdof_cruisefirst()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 1000, 7, 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x306d
// Size: 0x25
function setdof_tank()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 120, 1000, 6500, 7, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x309a
// Size: 0x24
function setdof_thirdperson()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 110, 512, 4096, 6, 1.8 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x30c6
// Size: 0x21
function setdof_gunship()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 1000, 7, 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x30ef
// Size: 0x22
function setdof_gunship_zoom()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 10, 5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3119
// Size: 0x25
function setdof_scrambler_strength_1()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 5000, 4, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3146
// Size: 0x28
function setdof_scrambler_strength_2()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 800, 4000, 4.5, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3176
// Size: 0x25
function setdof_scrambler_strength_3()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 600, 3000, 5, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x31a3
// Size: 0x28
function setdof_scrambler_strength_4()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 500, 2000, 5.5, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x31d3
// Size: 0x25
function setdof_scrambler_strength_5()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 400, 1000, 6, 3.5 );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3200
// Size: 0x9
function clearkillcamstate()
{
    scripts\cp_mp\utility\player_utility::clearkillcamstate();
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3211
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

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x325d
// Size: 0x86
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

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x32ec
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

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x3335
// Size: 0x50
function setwind( value, manualoverride )
{
    if ( !self isscriptable() || !self getscriptablehaspart( "wind" ) || !isreallyalive( self ) )
    {
        return;
    }
    
    self.manualoverridewindmaterial = manualoverride;
    self setscriptablepartstate( "wind", value, 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x338d
// Size: 0x13
function printspawnmessage( message )
{
    scripts\cp_mp\utility\player_utility::printspawnmessage( message );
}

// Namespace player / scripts\mp\utility\player
// Params 2
// Checksum 0x0, Offset: 0x33a8
// Size: 0xfc
function codcastersetplayerstatuseffect( category, duration )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    effecttype = undefined;
    
    switch ( category )
    {
        case #"hash_a68c414683465b09":
            effecttype = 0;
            break;
        case #"hash_23f2c68a2fc41281":
            effecttype = 2;
            break;
        case #"hash_fb36696c0708bf42":
            effecttype = 3;
            break;
        case #"hash_ceb098150f024a39":
            effecttype = 1;
            break;
        case #"hash_ff0da8f68d7b83f3":
            effecttype = 4;
            break;
        case #"hash_1f1d7b3efcb82111":
            effecttype = 5;
            break;
    }
    
    if ( isdefined( effecttype ) )
    {
        var_c8e256020171797a = 0;
        
        if ( effecttype != 1 && effecttype != 4 && effecttype != 5 )
        {
            var_c8e256020171797a = scripts\mp\utility\perk_shared::function_56ad1b98a0613f8a( "specialty_tac_resist" );
        }
        
        if ( duration != -1 )
        {
            duration = int( duration * 1000 );
        }
        
        self setcodcasterstatuseffect( effecttype, duration, gettime() + duration, var_c8e256020171797a );
    }
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x34ac
// Size: 0xbc, Type: bool
function isincombat()
{
    isshooting = 0;
    
    if ( isdefined( self.lastshotfiredtime ) )
    {
        var_32d023e8d6030ee3 = 0;
        
        if ( !weaponisauto( self.currentprimaryweapon ) )
        {
            var_c34a63b63e5e6854 = self function_c26a2350f081dc6( self.currentprimaryweapon );
            var_32d023e8d6030ee3 = var_c34a63b63e5e6854 + max( getdvarint( @"hash_f6ed71d9c8bdb8c9", 0 ), 150 );
        }
        else
        {
            var_32d023e8d6030ee3 = getdvarint( @"hash_f6ed71d9c8bdb8c9", 0 );
        }
        
        currenttime = gettime();
        isshooting = self.lastshotfiredtime + var_32d023e8d6030ee3 >= currenttime;
    }
    
    return isshooting || self ismeleeing() || self isthrowinggrenade() || function_9612d351d714efb1();
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3571
// Size: 0xc9
function function_9612d351d714efb1()
{
    var_9612d351d714efb1 = 0;
    
    if ( isdefined( self.attackers ) )
    {
        currenttime = gettime();
        var_fba4e93698c9c865 = 0;
        var_9c1c82123f62e38c = getdvarint( @"hash_20e694002fcd35cc", 2000 );
        
        foreach ( guid, attacker in self.attackers )
        {
            var_fba4e93698c9c865 = currenttime - self.attackerdata[ guid ].lasttimedamaged;
            var_9612d351d714efb1 = isdefined( attacker ) && var_fba4e93698c9c865 < var_9c1c82123f62e38c;
            
            if ( var_9612d351d714efb1 )
            {
                break;
            }
        }
    }
    
    return var_9612d351d714efb1;
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x3643
// Size: 0x1d
function setbeingrevivedinternal( isbeingrevived )
{
    self.beingrevived = isbeingrevived;
    self setbeingrevived( isbeingrevived );
}

// Namespace player / scripts\mp\utility\player
// Params 0
// Checksum 0x0, Offset: 0x3668
// Size: 0x1a, Type: bool
function getbeingrevivedinternal()
{
    return istrue( self.beingrevived ) || istrue( self.isselfreviving );
}

// Namespace player / scripts\mp\utility\player
// Params 7
// Checksum 0x0, Offset: 0x368b
// Size: 0x4f
function function_d80ebbf694920c5f( notifyname, commandname, actioncallback, var_3fd755a4695815a9, endons, inputtype, var_a5b5522433ca23bc )
{
    thread function_bce0309beb222741( notifyname, commandname, actioncallback, var_3fd755a4695815a9, endons, 0, undefined, inputtype, 0, undefined, var_a5b5522433ca23bc );
}

// Namespace player / scripts\mp\utility\player
// Params 9
// Checksum 0x0, Offset: 0x36e2
// Size: 0x61
function function_bbf44d52ca2820cd( notifyname, commandname, actioncallback, var_3fd755a4695815a9, endons, holdduration, var_52273a4095c18970, inputtype, var_a5b5522433ca23bc )
{
    thread function_bce0309beb222741( notifyname, commandname, actioncallback, var_3fd755a4695815a9, endons, holdduration, var_52273a4095c18970, inputtype, 0, undefined, var_a5b5522433ca23bc );
}

// Namespace player / scripts\mp\utility\player
// Params 8
// Checksum 0x0, Offset: 0x374b
// Size: 0x59
function function_4b6858706980b154( notifyname, commandname, actioncallback, var_3fd755a4695815a9, endons, inputtype, var_5bbf4defc70826d0, var_a5b5522433ca23bc )
{
    thread function_bce0309beb222741( notifyname, commandname, actioncallback, var_3fd755a4695815a9, endons, 0, undefined, inputtype, 1, var_5bbf4defc70826d0, var_a5b5522433ca23bc );
}

// Namespace player / scripts\mp\utility\player
// Params 11
// Checksum 0x0, Offset: 0x37ac
// Size: 0x1be
function function_bce0309beb222741( notifyname, commandname, actioncallback, var_3fd755a4695815a9, endons, holdduration, var_52273a4095c18970, inputtype, isrepeat, var_5bbf4defc70826d0, var_a5b5522433ca23bc )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    thread function_ea10736811b65b12( notifyname, endons );
    var_3fd755a4695815a9 = ter_op( isdefined( var_3fd755a4695815a9 ), var_3fd755a4695815a9, self );
    holdduration = ter_op( isdefined( holdduration ), holdduration, 0 );
    inputtype = ter_op( isdefined( inputtype ), inputtype, "any" );
    isrepeat = ter_op( isdefined( isrepeat ), isrepeat, 0 );
    var_5bbf4defc70826d0 = ter_op( isdefined( var_5bbf4defc70826d0 ), var_5bbf4defc70826d0, 0 );
    var_a5b5522433ca23bc = ter_op( isdefined( var_a5b5522433ca23bc ), var_a5b5522433ca23bc, 0 );
    
    if ( isbot( self ) && !var_a5b5522433ca23bc )
    {
        return;
    }
    
    assertex( isdefined( notifyname ) && isdefined( commandname ) && isdefined( actioncallback ), "<dev string:x1f9>" );
    presscommand = "+" + commandname;
    releasecommand = "-" + commandname;
    pressnotify = notifyname + "_press";
    releasenotify = notifyname + "_release";
    var_93c853099fdfbb57 = isrepeat || holdduration > 0;
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( pressnotify, presscommand );
        
        if ( var_93c853099fdfbb57 )
        {
            self notifyonplayercommand( releasenotify, releasecommand );
        }
    }
    
    function_22e92f7d1f36f97b( notifyname, actioncallback, var_3fd755a4695815a9, holdduration, var_52273a4095c18970, inputtype, isrepeat, var_5bbf4defc70826d0, var_a5b5522433ca23bc );
    
    if ( isdefined( var_52273a4095c18970 ) )
    {
        self thread [[ var_52273a4095c18970 ]]( var_3fd755a4695815a9, 0, 0 );
    }
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( pressnotify, presscommand );
        
        if ( var_93c853099fdfbb57 )
        {
            self notifyonplayercommandremove( releasenotify, releasecommand );
        }
    }
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x3972
// Size: 0x14f
function function_efc7b5130b976314( player )
{
    if ( isdefined( level.lootleaders ) && array_contains( level.lootleaders, player ) )
    {
        if ( isdefined( player.attached_bag ) )
        {
            stopfxontag( level._effect[ "vfx_br_cashLeaderBag" ], player, "j_bag_left" );
            modeltype = getmatchrulesdata( "brData", "plunderModelType" );
            modelname = "accessory_money_bag_large_closed_player";
            
            switch ( modeltype )
            {
                case #"hash_59b8e9d05b31ff9":
                    modelname = "accessory_money_bag_large_closed_player_plunder";
                    break;
            }
            
            player hidepart( "j_bag_left", modelname );
        }
    }
    
    if ( ( scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" ) && isdefined( player.attached_bag ) )
    {
        player.disabledbag = player.attached_bag;
        player scripts\mp\gametypes\br_gametype_dmz::detachbag();
    }
    
    if ( scripts\mp\utility\game::getsubgametype() == "bigctf" )
    {
        player.disabledflag = player.carryflag;
        player scripts\mp\gametypes\bigctf::detachflag();
    }
    
    player scripts\common\values::set( "hideAttachedModels", "hide_operator_backpack", 1 );
    player scripts\common\values::set( "hideAttachedModels", "show_operator_pet", 0 );
}

// Namespace player / scripts\mp\utility\player
// Params 1
// Checksum 0x0, Offset: 0x3ac9
// Size: 0x192
function function_affaefa6ea1b971d( player )
{
    if ( isdefined( level.lootleaders ) && array_contains( level.lootleaders, player ) )
    {
        if ( isdefined( player.attached_bag ) )
        {
            modeltype = getmatchrulesdata( "brData", "plunderModelType" );
            modelname = "accessory_money_bag_large_closed_player";
            
            switch ( modeltype )
            {
                case #"hash_59b8e9d05b31ff9":
                    modelname = "accessory_money_bag_large_closed_player_plunder";
                    break;
            }
            
            player showpart( "j_bag_left", modelname );
            playfxontag( level._effect[ "vfx_br_cashLeaderBag" ], player, "j_bag_left" );
        }
    }
    
    if ( ( scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" ) && !isdefined( player.attached_bag ) )
    {
        player scripts\mp\gametypes\br_gametype_dmz::attachbag( default_to( player.disabledbag, "parts_backpack_inventory_small" ) );
    }
    
    if ( scripts\mp\utility\game::getsubgametype() == "bigctf" )
    {
        if ( isdefined( player.disabledflag ) && isdefined( player.carryobject ) )
        {
            otherteam = scripts\mp\utility\game::getotherteam( player.pers[ "team" ] )[ 0 ];
            player attach( player.disabledflag, "tag_stowed_back3", 1 );
            player.carryflag = level.carryflag[ otherteam ];
            player.disabledflag = undefined;
        }
    }
    
    player scripts\common\values::reset_all( "hideAttachedModels" );
}

// Namespace player / scripts\mp\utility\player
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3c63
// Size: 0x33
function private function_ea10736811b65b12( notifyname, endons )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    waittill_any_in_array_return_no_endon_death( endons );
    self notify( notifyname + "_endon" );
}

// Namespace player / scripts\mp\utility\player
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x3c9e
// Size: 0x7e
function private function_22e92f7d1f36f97b( notifyname, actioncallback, var_3fd755a4695815a9, holdduration, var_52273a4095c18970, inputtype, isrepeat, var_5bbf4defc70826d0, var_a5b5522433ca23bc )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( notifyname + "_endon" );
    
    while ( true )
    {
        function_147c3508c4ff17a0( notifyname, actioncallback, var_3fd755a4695815a9, holdduration, var_52273a4095c18970, inputtype, isrepeat, var_5bbf4defc70826d0, var_a5b5522433ca23bc );
    }
}

// Namespace player / scripts\mp\utility\player
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x3d24
// Size: 0xa0
function private function_147c3508c4ff17a0( notifyname, actioncallback, var_3fd755a4695815a9, holdduration, var_52273a4095c18970, inputtype, isrepeat, var_5bbf4defc70826d0, var_a5b5522433ca23bc )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( notifyname + "_endon" );
    
    if ( holdduration == 0 )
    {
        self endon( notifyname + "_release" );
    }
    
    function_f4e88a8caf5d63ff( notifyname, var_3fd755a4695815a9, holdduration, var_52273a4095c18970, inputtype, var_a5b5522433ca23bc );
    
    if ( isrepeat )
    {
        function_f295850252d7414a( notifyname, actioncallback, var_3fd755a4695815a9, var_5bbf4defc70826d0 );
        return;
    }
    
    self thread [[ actioncallback ]]( var_3fd755a4695815a9 );
}

// Namespace player / scripts\mp\utility\player
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x3dcc
// Size: 0x139
function private function_f4e88a8caf5d63ff( notifyname, var_3fd755a4695815a9, holdduration, var_52273a4095c18970, inputtype, var_a5b5522433ca23bc )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( notifyname + "_endon" );
    var_563c6b7baaf043fa = holdduration == 0;
    var_3f6fd9c606674a97 = isbot( self ) && var_a5b5522433ca23bc;
    isvalidinput = 0;
    
    while ( !isvalidinput )
    {
        if ( var_563c6b7baaf043fa )
        {
            if ( !var_3f6fd9c606674a97 )
            {
                self waittill( notifyname + "_press" );
            }
            else
            {
                waitframe();
            }
            
            isvalidinput = 1;
        }
        else
        {
            if ( !var_3f6fd9c606674a97 )
            {
                self waittill( notifyname + "_press" );
            }
            else
            {
                waitframe();
            }
            
            thread function_53979f2ab653d2dd( notifyname, var_3fd755a4695815a9, holdduration, var_52273a4095c18970 );
            msg = waittill_notify_or_timeout_return( notifyname + "_release", holdduration );
            isvalidinput = msg == "timeout";
        }
        
        if ( isvalidinput && inputtype != "any" && !var_3f6fd9c606674a97 )
        {
            if ( inputtype == "gamepad_only" )
            {
                isvalidinput = self usinggamepad();
            }
            else if ( inputtype == "kbm_only" )
            {
                isvalidinput = !self usinggamepad();
            }
        }
        
        if ( !isvalidinput && isdefined( var_52273a4095c18970 ) )
        {
            self thread [[ var_52273a4095c18970 ]]( var_3fd755a4695815a9, 0, 0 );
        }
    }
}

// Namespace player / scripts\mp\utility\player
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3f0d
// Size: 0x95
function private function_53979f2ab653d2dd( notifyname, var_3fd755a4695815a9, holdduration, var_52273a4095c18970 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( notifyname + "_endon" );
    self endon( notifyname + "_release" );
    
    if ( !isdefined( var_52273a4095c18970 ) )
    {
        return;
    }
    
    progress = 0;
    holddurationms = holdduration * 1000;
    
    while ( progress < holddurationms )
    {
        waitframe();
        progress += level.frameduration;
        
        if ( progress < holddurationms )
        {
            self thread [[ var_52273a4095c18970 ]]( var_3fd755a4695815a9, progress, 0 );
        }
    }
    
    self thread [[ var_52273a4095c18970 ]]( var_3fd755a4695815a9, progress, 1 );
}

// Namespace player / scripts\mp\utility\player
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3faa
// Size: 0x5e
function private function_f295850252d7414a( notifyname, actioncallback, var_3fd755a4695815a9, var_5bbf4defc70826d0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( notifyname + "_release" );
    self endon( notifyname + "_endon" );
    
    while ( true )
    {
        self thread [[ actioncallback ]]( var_3fd755a4695815a9 );
        
        if ( var_5bbf4defc70826d0 > 0 )
        {
            wait var_5bbf4defc70826d0;
            continue;
        }
        
        waitframe();
    }
}

