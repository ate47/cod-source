#using script_6981400abfcd765c;
#using scripts\common\telemetry_utils;
#using scripts\engine\utility;

#namespace ftue_tip;

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1
// Checksum 0x0, Offset: 0x195
// Size: 0x33
function function_a6ca80cf4f22e262( var_8dceeda8be90dd95 )
{
    if ( function_94b952789d039abb() )
    {
        var_1c32a202e5e6e499 = getscriptbundle( var_8dceeda8be90dd95 );
        
        if ( isdefined( var_1c32a202e5e6e499 ) )
        {
            function_495a84d8124ff118( var_1c32a202e5e6e499 );
        }
    }
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 0
// Checksum 0x0, Offset: 0x1d0
// Size: 0x18
function function_5135b05917b91c1b()
{
    self.var_45e9d104c0a834c7 = spawnstruct();
    function_60994558e6d2f494( 0 );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1f0
// Size: 0xe3
function private function_495a84d8124ff118( list_bundle )
{
    level.var_cf6b53e10210d950 = [];
    level.var_e88f11422f545fe2 = [];
    index = 1;
    
    foreach ( bundle in list_bundle.var_a43c3448b149524 )
    {
        var_2fb2aed4c21ba3b0 = bundle.ref;
        
        if ( isdefined( var_2fb2aed4c21ba3b0 ) )
        {
            tip = spawnstruct();
            tip.id = index;
            tip.bundle = bundle.bundle;
            level.var_cf6b53e10210d950[ var_2fb2aed4c21ba3b0 ] = tip;
            level.var_e88f11422f545fe2[ index ] = var_2fb2aed4c21ba3b0;
        }
        
        index++;
    }
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 0
// Checksum 0x0, Offset: 0x2db
// Size: 0x1b, Type: bool
function function_e4d0f9efe9c2bca1()
{
    assert( isplayer( self ) );
    return istrue( self.var_fa35b4a136b27acd );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 2
// Checksum 0x0, Offset: 0x2ff
// Size: 0xa7
function function_9e0151baa208fe9e( ref, params )
{
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( !isdefined( level.var_cf6b53e10210d950 ) )
    {
        return;
    }
    
    assert( isplayer( self ) );
    
    if ( isdefined( params.sound ) && params.sound )
    {
        self playlocalsound( "uin_tip_appearance" );
    }
    
    if ( isdefined( params.waittimeoverride ) )
    {
        self.waittimeoverride = params.waittimeoverride;
    }
    
    function_34d38a99558eb2a2( ref, params.callback, params.duration );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3ae
// Size: 0x8b
function private function_34d38a99558eb2a2( ref, callback, duration )
{
    if ( !isdefined( self ) || !isplayer( self ) )
    {
        return;
    }
    
    var_4202e8261e8725f2 = function_388a7f4b869568cc( ref );
    
    if ( !isdefined( var_4202e8261e8725f2 ) )
    {
        assertmsg( "<dev string:x1c>" + ref + "<dev string:x4c>" );
        return;
    }
    
    function_60994558e6d2f494( var_4202e8261e8725f2 );
    self setftuetipid( var_4202e8261e8725f2 );
    thread function_3a1f121991c200e3( ref, 0 );
    self notify( "newtip" );
    
    if ( isdefined( duration ) )
    {
        wait duration;
        function_7fd621b8ba80e652();
    }
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 3
// Checksum 0x0, Offset: 0x441
// Size: 0x112
function function_f339c5c73d11ea20( ref, issucceed, params )
{
    if ( !isdefined( ref ) )
    {
        assertmsg( "<dev string:x7f>" + ref + "<dev string:xaa>" + level.var_cf6b53e10210d950 );
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    if ( !function_4352a63d3925798b() )
    {
        function_9e0151baa208fe9e( ref );
        function_d9f9951c566c97e1( 1, params.duration );
    }
    
    if ( isdefined( params.sound ) && params.sound )
    {
        sound = "uin_tip_complete";
        
        if ( !issucceed )
        {
            sound = "uin_tip_failed";
        }
        
        self playlocalsound( sound );
    }
    
    function_508d3de0ee3046dd( ref, issucceed );
    result = "SUCCESS";
    
    if ( !issucceed )
    {
        result = "FAILED";
    }
    
    thread function_3a1f121991c200e3( ref, 1, result );
    function_d9f9951c566c97e1( 0.8, params.duration );
    function_7fd621b8ba80e652( params.duration );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 2
// Checksum 0x0, Offset: 0x55b
// Size: 0x52
function function_6fba31415caeee6e( issucceeded, params )
{
    tipid = function_91e510bcc622bfd0();
    
    if ( tipid == 0 )
    {
        return;
    }
    
    tipref = function_bf44b38db65d0bf9( tipid );
    assert( isdefined( tipref ) );
    function_f339c5c73d11ea20( tipref, issucceeded, params );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 2
// Checksum 0x0, Offset: 0x5b5
// Size: 0x3f
function function_508d3de0ee3046dd( ref, issucceed )
{
    if ( !isdefined( level.var_cf6b53e10210d950 ) )
    {
        return;
    }
    
    assert( isplayer( self ) );
    function_ff85bc42d440477b( ref, function_63e0c93eb50543f( issucceed ) );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5fc
// Size: 0x25
function private function_ff85bc42d440477b( ref, newstate )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self function_1807967ea2130c2d( newstate );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x629
// Size: 0x2d
function private function_63e0c93eb50543f( issucceed )
{
    newstate = 0;
    
    if ( isdefined( issucceed ) )
    {
        if ( issucceed )
        {
            newstate = 1;
        }
        else
        {
            newstate = 2;
        }
    }
    
    return newstate;
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1
// Checksum 0x0, Offset: 0x65f
// Size: 0x27
function function_7fd621b8ba80e652( overridewaittime )
{
    function_60994558e6d2f494( 0 );
    self function_4eb77980affdbefb();
    function_d9f9951c566c97e1( 0.5, overridewaittime );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x68e
// Size: 0x30
function private function_d9f9951c566c97e1( defaultwaittime, overridewaittime )
{
    waittime = defaultwaittime;
    
    if ( isdefined( overridewaittime ) )
    {
        waittime = overridewaittime;
    }
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1
// Checksum 0x0, Offset: 0x6c6
// Size: 0x19
function function_36939d27ae6df257( callback )
{
    if ( isdefined( callback ) )
    {
        thread function_ff3f2188762b9896( callback );
    }
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x6e7
// Size: 0x91
function private function_ff3f2188762b9896( callback )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( !isdefined( self.var_45e9d104c0a834c7 ) )
    {
        return;
    }
    
    if ( !isdefined( callback ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( "luinotifyserver", event, value );
        
        if ( isdefined( event ) && event == "ftuetip_completed" )
        {
            if ( isdefined( value ) && value == function_91e510bcc622bfd0() )
            {
                tipref = function_bf44b38db65d0bf9( value );
                
                if ( isdefined( tipref ) )
                {
                    self [[ callback ]]( tipref );
                    return;
                }
            }
        }
    }
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x780
// Size: 0x16
function private function_bf44b38db65d0bf9( index )
{
    return level.var_e88f11422f545fe2[ index ];
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x79f
// Size: 0x2d
function private function_388a7f4b869568cc( tip_ref )
{
    id = level.var_cf6b53e10210d950[ tip_ref ].id;
    return id;
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1
// Checksum 0x0, Offset: 0x7d5
// Size: 0x2d
function function_7052cffee37e6327( tip_ref )
{
    id = level.var_cf6b53e10210d950[ tip_ref ].bundle;
    return id;
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x80b
// Size: 0x17, Type: bool
function private function_4352a63d3925798b()
{
    return self.var_45e9d104c0a834c7.var_1624b445a428c297 != 0;
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x82b
// Size: 0x15
function private function_91e510bcc622bfd0()
{
    return self.var_45e9d104c0a834c7.var_1624b445a428c297;
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x849
// Size: 0x20
function private function_60994558e6d2f494( newid )
{
    self.var_45e9d104c0a834c7.var_1624b445a428c297 = newid;
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x871
// Size: 0x11e
function private function_3a1f121991c200e3( ref, finished, result )
{
    tipid = function_7052cffee37e6327( ref );
    var_1656b06379e3e9d8 = [ #"stepname", #"stepnumber", #"issingle", #"hash_a8be9518a2a9868", #"hash_80f6033e24a2bf4" ];
    telemetrydata = getscriptbundlefieldvalues( hashcat( %"hash_6b016976aff9ae9f", tipid ), var_1656b06379e3e9d8 );
    assertex( isdefined( telemetrydata ), "<dev string:xc9>" + tipid );
    
    if ( !function_acbac8f30b95d690( telemetrydata ) )
    {
        return;
    }
    
    telemetrydata.player = self;
    callback = "mobile_ftue_step_start";
    
    if ( istrue( telemetrydata.issingle ) )
    {
        telemetrydata.result = "SUCCESS";
        callback = "mobile_ftue_step_single";
    }
    else if ( finished )
    {
        telemetrydata.result = result;
        callback = "mobile_ftue_step_finished";
    }
    
    scripts\common\telemetry_utils::function_80820d6d364c1836( callback, telemetrydata );
}

// Namespace ftue_tip / namespace_b1d233abf1e31488
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x997
// Size: 0x2c, Type: bool
function private function_acbac8f30b95d690( telemetrydata )
{
    return isdefined( telemetrydata.stepname ) && telemetrydata.stepname != "";
}

