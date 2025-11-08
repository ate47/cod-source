#using script_32d93a194074fa6a;
#using scripts\common\progression_utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;

#namespace ftue_player;

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x2d7
// Size: 0x33
function function_67d00e6b876c5ee2( position, angles )
{
    assert( isdefined( position ) );
    self setorigin( position );
    
    if ( isdefined( angles ) )
    {
        self setplayerangles( angles );
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x312
// Size: 0x47
function function_a074c3f0d66ba8e0()
{
    self endon( "game_ended" );
    self endon( "clip_limited" );
    
    while ( true )
    {
        equippedweapon = self getcurrentweapon();
        
        if ( self getweaponammoclip( equippedweapon ) <= 10 )
        {
            self setweaponammoclip( equippedweapon, 20 );
        }
        
        wait 0.3;
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x361
// Size: 0x4b
function function_f83c33a014ee22fe()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        equippedweapon = self getcurrentweapon();
        
        if ( self getweaponammostock( equippedweapon ) <= 30 )
        {
            self setweaponammostock( equippedweapon, 60 );
        }
        
        wait 1;
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x3b4
// Size: 0x46, Type: bool
function function_bbd25202175d7f6f( player, ally )
{
    return isdefined( player ) && isdefined( ally ) && isalliedsentient( player, ally ) && ( istrue( ally.jailed ) || istrue( ally.gulagarena ) );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x403
// Size: 0x3b, Type: bool
function function_78d176299d2e0714( player, var_e8f714bab38b613c )
{
    ascenders = getentitylessscriptablearray( undefined, undefined, player.origin, var_e8f714bab38b613c, "ascender" );
    return ascenders.size > 0;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x447
// Size: 0x4a, Type: bool
function function_42f2ff6e724030d0( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_71e5a20019ec7f70 ) );
    dist = params.var_71e5a20019ec7f70;
    return function_78d176299d2e0714( self, dist );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x49a
// Size: 0x2b
function function_866b54331a9baec7( player, var_e8f714bab38b613c )
{
    return getentitylessscriptablearray( undefined, undefined, player.origin, var_e8f714bab38b613c, "ascender" );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x4ce
// Size: 0xa0
function function_e09fe43dabd5e4cf( player, ascenders )
{
    if ( ascenders.size > 0 )
    {
        mindistance = distancesquared( ascenders[ 0 ].origin, player.origin );
        nearestzipline = ascenders[ 0 ];
        
        for ( i = 0; i < ascenders.size ; i++ )
        {
            ziplinedistance = distancesquared( ascenders[ i ].origin, player.origin );
            
            if ( ziplinedistance < mindistance )
            {
                mindistance = ziplinedistance;
                nearestzipline = ascenders[ i ];
            }
        }
        
        return nearestzipline;
    }
    
    return undefined;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x577
// Size: 0x16
function function_bf0a1f8b03ea5c18( player )
{
    return player.usingascender;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x596
// Size: 0x1d
function function_d97f26cd24750946()
{
    usezipline = function_bf0a1f8b03ea5c18( self );
    
    if ( isdefined( usezipline ) )
    {
        return usezipline;
    }
    
    return 0;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x5bc
// Size: 0x5b
function function_331e465c203522e0( positivecallback )
{
    self endon( "disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( "luinotifyserver", message, value );
        
        if ( isdefined( message ) && message == "ftue_minimap_opened" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x61f
// Size: 0x20
function function_152b922c52a79e9e( player )
{
    player.var_6ab0fd4589f5aea5 = 1;
    function_7fd621b8ba80e652();
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x647
// Size: 0x13
function function_506621f96f8313a5( positivecallback )
{
    function_c6c53ea9225f6fc2( positivecallback );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x662
// Size: 0x5b
function function_c6c53ea9225f6fc2( positivecallback )
{
    self endon( "disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( "luinotifyserver", message, value );
        
        if ( isdefined( message ) && message == "ftue_minimap_closed" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x6c5
// Size: 0x26
function function_f3fdf43101042f63( tipref )
{
    if ( isdefined( tipref ) && tipref == "gasMiniMapCloseTip" )
    {
        self.var_64a66c71d00e6f50 = 1;
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x6f3
// Size: 0x5b
function function_b804651ee5f4e495( positivecallback )
{
    self endon( "disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( "luinotifyserver", message, value );
        
        if ( isdefined( message ) && message == "scoreboard_open" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x756
// Size: 0x5b
function function_2c280502c93dcdf4( positivecallback )
{
    self endon( "disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( "luinotifyserver", message, value );
        
        if ( isdefined( message ) && message == "scoreboard_close" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x7b9
// Size: 0x2e, Type: bool
function function_6fc17f2a58009875()
{
    return isdefined( self.br_infil_type ) && self.br_infil_type == "c130" && scripts\mp\flags::gameflag( "br_ready_to_jump" );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x7f0
// Size: 0x3d, Type: bool
function function_d1518ce894dd64e7( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_be502a4377111804 ) );
    return function_6fc17f2a58009875() == params.var_be502a4377111804;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x836
// Size: 0x15
function function_18fcd72dfea6cac1()
{
    if ( !self.var_ca031fd3734a1c62 )
    {
        function_52974897ad9887a8();
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x853
// Size: 0x24
function function_52974897ad9887a8()
{
    self endon( "disconnect" );
    assert( isdefined( self ) );
    
    while ( !self.var_ca031fd3734a1c62 )
    {
        waitframe();
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x880
// Size: 0x16
function function_5c6c946f52be9a50( tipref )
{
    self.var_ca031fd3734a1c62 = 1;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x89e
// Size: 0x24
function function_914e9d5e71cc6efb()
{
    self endon( "disconnect" );
    self endon( "currentContextualTipCompleted" );
    self endon( "currentContextualTipAborted" );
    
    while ( !self function_3c6bb30ae7106b7a() )
    {
        waitframe();
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x8cb
// Size: 0x11
function function_8584a8a9b5fa0463()
{
    return scripts\mp\gametypes\br_circle_util::function_a465e3c1371d7dab( self.origin );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x8e5
// Size: 0x11
function function_2f3ee72261187d51()
{
    return scripts\mp\gametypes\br_circle_util::ispointindangercircle( self.origin );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x8ff
// Size: 0x1c
function function_671c7049215ebc9c()
{
    var_6cb069d7b1dfaae0 = function_8584a8a9b5fa0463();
    
    if ( !isdefined( var_6cb069d7b1dfaae0 ) )
    {
        return 0;
    }
    
    return var_6cb069d7b1dfaae0;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x924
// Size: 0x41
function function_256eaa0074efa7c2( params )
{
    returnvalue = function_2f3ee72261187d51();
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( returnvalue == params.expectedvalue );
    }
    
    return returnvalue;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x96e
// Size: 0x33, Type: bool
function function_4c16f440b2c0b804( minheight, maxheight )
{
    return self.origin[ 2 ] < minheight || self.origin[ 2 ] > maxheight;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x9aa
// Size: 0x9c, Type: bool
function function_2fde996b20d64205( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_71dd2a61430c603f ) );
    assert( isdefined( params.minheight ) );
    assert( isdefined( params.maxheight ) );
    
    if ( function_4c16f440b2c0b804( params.minheight, params.maxheight ) )
    {
        return false;
    }
    
    var_71dd2a61430c603f = function_8eb62efbab104b05();
    
    if ( isdefined( var_71dd2a61430c603f ) )
    {
        return ( var_71dd2a61430c603f < params.var_71dd2a61430c603f );
    }
    
    return false;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0xa4f
// Size: 0x36, Type: bool
function function_725b52f601c21a7a( maxdistance, mindistance )
{
    var_71dd2a61430c603f = function_8eb62efbab104b05();
    
    if ( isdefined( var_71dd2a61430c603f ) )
    {
        return ( var_71dd2a61430c603f < maxdistance && var_71dd2a61430c603f > mindistance );
    }
    
    return false;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0xa8e
// Size: 0x8e
function function_8eb62efbab104b05()
{
    dangercircleent = level.br_circle.dangercircleent;
    
    if ( isdefined( dangercircleent ) )
    {
        dangercircleorigin = ( dangercircleent.origin[ 0 ], dangercircleent.origin[ 1 ], 0 );
        dangercircleradius = dangercircleent.origin[ 2 ];
        
        if ( isdefined( dangercircleorigin ) && isdefined( dangercircleradius ) )
        {
            var_e28b0fbabce791f1 = distance2d( self.origin, dangercircleorigin );
            return ( dangercircleradius - var_e28b0fbabce791f1 );
        }
    }
    
    return undefined;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0xb25
// Size: 0x26
function function_92a5f74f5acc64d9( callback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "last_stand_start" );
    self [[ callback ]]();
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0xb53
// Size: 0x9a
function function_af7551bf62570371( callback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    downed = undefined;
    
    while ( downed == undefined )
    {
        foreach ( player in level.players )
        {
            if ( isalliedsentient( self, player ) && !scripts\mp\utility\player::isreallyalive( player ) )
            {
                downed = player;
                break;
            }
        }
        
        waitframe();
    }
    
    [[ callback ]]( downed );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0xbf5
// Size: 0x1d
function function_ba481c5cd3c4f5b4( var_8cdf4ff04b7775ec, initcallback )
{
    thread function_c6cc9d3a7adfda0f( var_8cdf4ff04b7775ec, initcallback );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0xc1a
// Size: 0x61
function function_c6cc9d3a7adfda0f( var_8cdf4ff04b7775ec, initcallback )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "currentContextualTipCompleted" );
    self endon( "currentContextualTipAborted" );
    assert( isdefined( self ) );
    assert( isdefined( var_8cdf4ff04b7775ec ) );
    
    if ( isdefined( initcallback ) )
    {
        self [[ initcallback ]]();
    }
    
    while ( !self isskydiving() )
    {
        waitframe();
    }
    
    self [[ var_8cdf4ff04b7775ec ]]();
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 4
// Checksum 0x0, Offset: 0xc84
// Size: 0x2f
function function_8c217f41a2b69bfe( var_a7bc06075641900e, anglediffgoal, var_8cdf4ff04b7775ec, initcallback )
{
    thread function_632855e1721d2685( var_a7bc06075641900e, anglediffgoal, var_8cdf4ff04b7775ec, initcallback );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 4
// Checksum 0x0, Offset: 0xcbb
// Size: 0x103
function function_632855e1721d2685( var_a7bc06075641900e, anglediffgoal, var_8cdf4ff04b7775ec, initcallback )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    assert( isdefined( self ) );
    assert( isdefined( var_8cdf4ff04b7775ec ) );
    var_d49294f78a5bd8b0 = 0;
    init_pos = self.origin;
    init_angles = self getplayerangles();
    
    while ( !self function_3c6bb30ae7106b7a() )
    {
        waitframe();
    }
    
    if ( isdefined( initcallback ) )
    {
        self [[ initcallback ]]();
    }
    
    while ( self isparachuting() )
    {
        diff_pos = distance( ( self.origin[ 0 ], self.origin[ 1 ], 0 ), ( init_pos[ 0 ], init_pos[ 1 ], 0 ) );
        diff_angles = distance( self getplayerangles(), init_angles );
        
        if ( diff_angles >= anglediffgoal && diff_pos * 10 > var_a7bc06075641900e )
        {
            var_d49294f78a5bd8b0 = 1;
            break;
        }
        
        waitframe();
    }
    
    self [[ var_8cdf4ff04b7775ec ]]( var_d49294f78a5bd8b0 );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0xdc7
// Size: 0x9
function function_6c19fa9b1a676fe5()
{
    function_2ab50ae603bc51cc();
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0xdd8
// Size: 0x28
function function_2ab50ae603bc51cc()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    assert( isdefined( self ) );
    
    while ( self function_3c6bb30ae7106b7a() )
    {
        waitframe();
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0xe09
// Size: 0xb3
function function_ff62c3aabf4c0ba8( var_7ea2637582571067, initcallback )
{
    self endon( "entitydeleted" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon );
        
        if ( attacker != self && isdefined( var_7ea2637582571067 ) )
        {
            self [[ var_7ea2637582571067 ]]();
            return;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0xec4
// Size: 0x2f
function function_217fab64becd170a()
{
    xp = self getplayerdata( "common", "mpProgression", "playerLevel", "xp" );
    return getrankforxp( xp );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0xefc
// Size: 0xf, Type: bool
function function_1e7a02ef17d58a96()
{
    if ( self function_e69d7896fa6e5d23() )
    {
        return true;
    }
    
    return false;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0xf14
// Size: 0x14
function function_c3ff6825172b7e02( positivecallback )
{
    thread function_dc30e2f1a162d751( positivecallback );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0xf30
// Size: 0x5b
function function_dc30e2f1a162d751( positivecallback )
{
    self endon( "disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( "luinotifyserver", message, value );
        
        if ( isdefined( message ) && message == "ftue_redeploy_button_clicked" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0xf93
// Size: 0x13
function function_f0027ce50e5ef437( callback )
{
    function_f47edda71b7a6492( callback );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0xfae
// Size: 0x4f
function function_f47edda71b7a6492( callback )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, class );
        
        if ( channel == "ftue_show_revive_ally_button" )
        {
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x1005
// Size: 0x1c
function function_79ff3ea7e538a94a( teammate, callback )
{
    function_952f091badfcdd5d( teammate, callback );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 2
// Checksum 0x0, Offset: 0x1029
// Size: 0x88
function function_952f091badfcdd5d( teammate, callback )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( !isdefined( teammate.inlaststand ) )
    {
        waitframe();
    }
    
    originalstate = teammate.inlaststand;
    
    while ( true )
    {
        if ( !isreallyalive( teammate ) )
        {
            self [[ callback ]]( 0 );
            return;
        }
        
        currentvalue = teammate.inlaststand;
        
        if ( originalstate != currentvalue )
        {
            self [[ callback ]]( 1 );
            return;
        }
        
        waitframe();
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x10b9
// Size: 0x14
function function_9b8f4317c9bee442( positivecallback )
{
    thread function_cbf5df364d883f3d( positivecallback );
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x10d5
// Size: 0x65
function function_cbf5df364d883f3d( positivecallback )
{
    assert( isdefined( self ) );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "calloutmarkerping_notifyhandled", message, value, optionalvalue );
        
        if ( isdefined( message ) && message == "calloutmarkerping_added" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x1142
// Size: 0xd, Type: bool
function function_ebaaac95a9dd6()
{
    return self.health > 0;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x1158
// Size: 0x9, Type: bool
function function_c104680edea6cf97()
{
    return !function_ebaaac95a9dd6();
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 1
// Checksum 0x0, Offset: 0x116a
// Size: 0x2b
function function_a44b57cf475cf6c1( value )
{
    if ( istrue( value ) )
    {
        level.modifyplayerdamage = &function_210da883891acd05;
        return;
    }
    
    level.modifyplayerdamage = undefined;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x119d
// Size: 0x8
function function_fafeefcc0da64ee2()
{
    return self isonground();
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x11ae
// Size: 0x8
function function_f07edbf622eeb7d9()
{
    return scripts\mp\gametypes\br_public::hasselfrevivetoken();
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 11
// Checksum 0x0, Offset: 0x11bf
// Size: 0xff
function function_210da883891acd05( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1 )
{
    if ( !isbot( victim ) || victim.team == level.player.team )
    {
        idamage *= victim.health / 200;
        
        if ( victim.health - idamage <= 0 )
        {
            idamage = 0;
        }
    }
    else if ( isbot( einflictor ) && einflictor.team == level.player.team && smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_MELEE_TAKEDOWN" )
    {
        idamage = 0;
    }
    
    return idamage;
}

// Namespace ftue_player / namespace_196a3629befb677e
// Params 0
// Checksum 0x0, Offset: 0x12c7
// Size: 0x16
function function_bb62ba82affdd5c7()
{
    self endon( "disconnect" );
    
    while ( !self ismantling() )
    {
        waitframe();
    }
}

