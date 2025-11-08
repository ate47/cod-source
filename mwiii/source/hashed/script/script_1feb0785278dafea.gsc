#using script_38db8bccc9eb301f;
#using script_3b78d23dad7ec5be;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\supers;
#using scripts\mp\utility\player;

#namespace namespace_80be1a420d9464c2;

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0x29f
// Size: 0xf6
function init()
{
    scripts\mp\supers::function_53110a12409d01da( "super_healing_aura", undefined, undefined, &function_100df54dff03edbb, &function_732c446e8109dfdf, undefined );
    
    /#
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        add_devgui_command( "<dev string:x35>", "<dev string:x4a>" );
        add_devgui_command( "<dev string:x7b>", "<dev string:x93>" );
        function_fe953f000498048f();
    #/
    
    supertable = getscriptbundle( level.supertable );
    
    foreach ( super in supertable.super_list )
    {
        if ( super.ref == "super_healing_aura" )
        {
            level.var_f04301db8ca5ecfa[ "super_healing_aura" ] = getscriptbundle( "super:" + super.bundle );
            break;
        }
    }
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0x39d
// Size: 0x6d, Type: bool
function function_100df54dff03edbb()
{
    if ( isdefined( level.var_f04301db8ca5ecfa[ "super_healing_aura" ] ) )
    {
        var_518800153d623ef2 = level.var_f04301db8ca5ecfa[ "super_healing_aura" ].offhandweapon;
        deploysuccess = namespace_e23f629a8349dfaf::function_75abcff430ed00b7( var_518800153d623ef2 );
        
        if ( deploysuccess )
        {
            self setscriptablepartstate( "wand_fx", "wand_on_healing_aura", 0 );
            thread function_e5fda42c3da4e793();
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 2
// Checksum 0x0, Offset: 0x413
// Size: 0x14, Type: bool
function function_732c446e8109dfdf( fromdeath, attacker )
{
    return false;
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0x430
// Size: 0xa
function function_e5fda42c3da4e793()
{
    thread function_117332a41d3ff196();
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0x442
// Size: 0x9f
function function_117332a41d3ff196()
{
    players = function_3451fc6440a9b8db();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        player heal_player( self );
        
        if ( isdefined( level.var_9dd45392c2bffc71 ) && isdefined( level.var_9dd45392c2bffc71[ "id_healing_aura_heal" ] ) )
        {
            self [[ level.var_9dd45392c2bffc71[ "id_healing_aura_heal" ] ]]();
        }
    }
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 1
// Checksum 0x0, Offset: 0x4e9
// Size: 0x51
function heal_player( reviver )
{
    thread function_4add5a3d6212791( 1 );
    var_d551990ed29466a0 = 1;
    
    if ( istrue( var_d551990ed29466a0 ) && istrue( self.inlaststand ) )
    {
        thread function_c750ffefbb8e1dab();
        thread revive_player( reviver );
        return;
    }
    
    function_4eb285a61cf68dc6();
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 1
// Checksum 0x0, Offset: 0x542
// Size: 0x45
function function_4add5a3d6212791( duration )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "healing_aura_fx", "super_fx_on", 0 );
    wait duration;
    self setscriptablepartstate( "healing_aura_fx", "super_fx_off", 0 );
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 1
// Checksum 0x0, Offset: 0x58f
// Size: 0xf0
function revive_player( reviver )
{
    self notify( "healing_aura_revive_player" );
    self endon( "healing_aura_revive_player" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    n_timeout = 8;
    
    while ( scripts\mp\utility\player::isinlaststand( self ) && !istrue( self.var_2fb534abd9eb93ca ) )
    {
        if ( n_timeout <= 0 )
        {
            break;
        }
        
        waitframe();
        n_timeout -= level.framedurationseconds;
    }
    
    if ( istrue( self.beingrevived ) )
    {
        scripts\mp\utility\player::setbeingrevivedinternal( 0 );
        reviver = utility::default_to( reviver, self );
        
        if ( isdefined( self.reviver ) )
        {
            reviver = self.reviver;
        }
        
        scripts\cp_mp\laststand::finishreviveplayer( "use_hold_revive_success", reviver );
    }
    else
    {
        self notify( "last_stand_heal_success" );
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue( level.var_6d63cbd43e47315e ) )
    {
        scripts\mp\gametypes\br_public::setplayerbeingrevivedextrainfo( 0 );
    }
    
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_securing_progress", 0 );
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 1
// Checksum 0x0, Offset: 0x687
// Size: 0x3c
function function_c750ffefbb8e1dab( var_976d79abcce342da )
{
    self notify( "heal_player_from_revive" );
    self endon( "heal_player_from_revive" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self waittill( "last_stand_finished" );
    function_4eb285a61cf68dc6();
    
    if ( istrue( var_976d79abcce342da ) )
    {
    }
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0x6cb
// Size: 0xbd
function function_3451fc6440a9b8db()
{
    bundle = namespace_e23f629a8349dfaf::function_ed72d0f08d00c1c0();
    affected_radius = bundle.var_d1ac061f0c3c0eeb;
    players = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( isdefined( affected_radius ) && distancesquared( player.origin, self.origin ) > squared( affected_radius ) )
        {
            continue;
        }
        
        players[ players.size ] = player;
    }
    
    return players;
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0x791
// Size: 0x32
function function_4eb285a61cf68dc6()
{
    self.health = self.maxhealth;
    scripts\common\damage_effects::onexitdeathsdoor( 1 );
    
    if ( istrue( self.revivingteammate ) )
    {
        self notify( "finish_buddy_reviving" );
    }
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0x7cb
// Size: 0xee
function function_b581a4659c1ed2fc()
{
    level endon( "game_ended" );
    players = function_3451fc6440a9b8db();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        beampos = utility::groundpos( player.origin );
        beamentity = spawn( "script_model", beampos );
        beamentity setmodel( "tag_origin" );
        beamentity linkto( player );
        otherfxent = spawn( "script_model", beampos );
        otherfxent setmodel( "tag_origin" );
        otherfxent linkto( beamentity );
        beamentity.otherfxent = otherfxent;
        beamentity thread function_69b2e6f4e33c0784( self );
    }
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 1
// Checksum 0x0, Offset: 0x8c1
// Size: 0x2d
function function_2f3c8bf61931b1d8( fx_label )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    waitframe();
    playfxontag( getfx( fx_label ), self, "tag_origin" );
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 1
// Checksum 0x0, Offset: 0x8f6
// Size: 0x119
function function_69b2e6f4e33c0784( user_player )
{
    self endon( "death" );
    time = 0;
    settings = user_player namespace_e23f629a8349dfaf::function_ed72d0f08d00c1c0();
    duration = settings.var_624f2456097d6c99;
    tick = settings.var_18033fb4a757efbc;
    beam_radius = settings.beam_radius;
    
    while ( time <= duration )
    {
        players = user_player function_3451fc6440a9b8db();
        
        foreach ( player in players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( distance2dsquared( self.origin, player.origin ) <= squared( beam_radius ) )
            {
                player heal_player( user_player );
            }
        }
        
        time += tick;
        wait tick;
    }
    
    wait tick;
    self delete();
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0xa17
// Size: 0x73
function set_regen()
{
    level endon( "game_ended" );
    players = function_3451fc6440a9b8db();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        player thread function_a8e441b6bb8e5b3c( self );
    }
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 1
// Checksum 0x0, Offset: 0xa92
// Size: 0xfb
function function_a8e441b6bb8e5b3c( user_player )
{
    id = self getentitynumber();
    self notify( "do_player_regen" + id );
    self endon( "do_player_regen" + id );
    self endon( "death_or_disconnect" );
    time = 0;
    settings = user_player namespace_e23f629a8349dfaf::function_ed72d0f08d00c1c0();
    duration = settings.var_b059843c0ec240fc;
    tick = settings.var_bd46bbf416f7d28d;
    var_e69b85ec21afb78b = settings.var_ccedea33ed4a75c2;
    
    while ( time <= duration )
    {
        if ( !istrue( self.inlaststand ) )
        {
            if ( isnumber( self.health ) && isnumber( self.maxhealth ) )
            {
                self.health = int( min( self.health + var_e69b85ec21afb78b, self.maxhealth ) );
            }
        }
        
        time += tick;
        wait tick;
    }
    
    waitframe();
}

// Namespace namespace_80be1a420d9464c2 / namespace_f585f5e438cbdbc8
// Params 0
// Checksum 0x0, Offset: 0xb95
// Size: 0x132
function function_182ed32c1dbe94ed()
{
    settings = namespace_e23f629a8349dfaf::function_ed72d0f08d00c1c0();
    knockdown_radius = settings.var_2e0d868cadea7953;
    players = function_3451fc6440a9b8db();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        nearby_zombies = getaiarrayinradius( player.origin, knockdown_radius );
        
        foreach ( zombie in nearby_zombies )
        {
            if ( isdefined( zombie.team ) && zombie.team == self.team )
            {
                continue;
            }
            
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            zombie namespace_db1ce2c035564e2c::knockdown_ai( player.origin );
        }
        
        waitframe();
    }
}

