#using scripts\engine\utility;

#namespace quickprompt;

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xe4
// Size: 0x4b
function private waitfornotify( waitobject, promptid )
{
    waitobject endon( "end_wait" );
    result = undefined;
    
    while ( !isdefined( result ) || result != promptid )
    {
        self waittill( "ok", result );
    }
    
    waitobject notify( "end_wait", 1 );
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x137
// Size: 0x25
function private waitfortimeout( waitobject, timeout )
{
    waitobject endon( "end_wait" );
    wait timeout;
    waitobject notify( "end_wait", 0 );
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x164
// Size: 0x4b
function private waitforconfirmation( promptid, timeout )
{
    waitobject = spawnstruct();
    childthread waitfornotify( waitobject, promptid );
    childthread waitfortimeout( waitobject, timeout );
    waitobject waittill( "end_wait", var_63f39f46151661f8 );
    return var_63f39f46151661f8;
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1b8
// Size: 0x4a
function private function_cf06da592218629( soundtype )
{
    assert( isdefined( self ) && isplayer( self ) );
    
    if ( issharedfuncdefined( "sound", "trySayLocalSound" ) )
    {
        level thread [[ getsharedfunc( "sound", "trySayLocalSound" ) ]]( self, soundtype );
    }
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x20a
// Size: 0x44
function private function_3fc6bd204b38a2f5()
{
    if ( !isdefined( level.var_a7073b092595736e ) )
    {
        level.var_a7073b092595736e = 0;
    }
    
    promptid = level.var_a7073b092595736e;
    level.var_a7073b092595736e += 1;
    return promptid;
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x257
// Size: 0x13
function private function_b8da10afdee4ecb6()
{
    return getdvarint( @"hash_923b34c4661bf18d", 500 );
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x273
// Size: 0x35
function private getservertimeout( clienttimeout )
{
    var_bd28f5a584bf2110 = 1000;
    var_1048e24f7ecfd108 = function_b8da10afdee4ecb6();
    return ( clienttimeout + var_bd28f5a584bf2110 + var_1048e24f7ecfd108 ) / 1000;
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2b1
// Size: 0x36
function private function_81e08a62a6b5c2fc( timeout )
{
    defaulttimeout = 5000;
    
    if ( isdefined( timeout ) )
    {
        return ( timeout * 1000 );
    }
    
    return getdvarint( @"hash_9feed7a9d0b00557", defaulttimeout );
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2f0
// Size: 0x22
function private function_48c352e46a0677d1( prompttype )
{
    if ( prompttype == 5 || prompttype == 6 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x31a
// Size: 0x16, Type: bool
function private function_5fe394c76f3bb67e( prompttype )
{
    if ( prompttype == 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 0
// Checksum 0x0, Offset: 0x339
// Size: 0x13, Type: bool
function function_7ba31cb6b21c346f()
{
    return istrue( getdvarint( @"hash_7023569777f7f76d", 1 ) );
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 0
// Checksum 0x0, Offset: 0x355
// Size: 0x21, Type: bool
function function_9e4834f9ae737884()
{
    assert( isdefined( self ) && isplayer( self ) );
    return isdefined( self.quickprompt );
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 1
// Checksum 0x0, Offset: 0x37f
// Size: 0x44, Type: bool
function function_74c8eb2aaf9f5d14( prompttype )
{
    assert( isdefined( self ) && isplayer( self ) );
    
    if ( isdefined( self.quickprompt ) )
    {
        return ( self.quickprompt.type == prompttype );
    }
    
    return false;
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 3
// Checksum 0x0, Offset: 0x3cc
// Size: 0x20c
function function_36edf91561322753( prompttype, timeout, callback )
{
    assert( isdefined( self ) && isplayer( self ) );
    
    if ( !function_7ba31cb6b21c346f() )
    {
        return;
    }
    
    if ( isdefined( self.quickprompt ) && isdefined( self.quickprompt.allowoverride ) && !self.quickprompt.allowoverride )
    {
        return;
    }
    
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    promptid = function_3fc6bd204b38a2f5();
    prompttimeout = function_81e08a62a6b5c2fc( timeout );
    allowoverride = function_48c352e46a0677d1( prompttype );
    var_5fe394c76f3bb67e = function_5fe394c76f3bb67e( prompttype );
    quickpromptshowlocal( self, prompttype, promptid, int( prompttimeout ), var_5fe394c76f3bb67e );
    self.quickprompt = spawnstruct();
    self.quickprompt.allowoverride = allowoverride;
    self.quickprompt.callback = callback;
    self.quickprompt.type = prompttype;
    self.quickprompt.promptid = promptid;
    servertimeout = getservertimeout( prompttimeout );
    var_63f39f46151661f8 = waitforconfirmation( promptid, servertimeout );
    
    if ( var_63f39f46151661f8 )
    {
        switch ( prompttype )
        {
            case 1:
            case 2:
            case 3:
            case 4:
                function_cf06da592218629( #"ping_social_thanks" );
                break;
            default:
                break;
        }
    }
    
    if ( isdefined( self.quickprompt ) && isdefined( self.quickprompt.callback ) )
    {
        self [[ self.quickprompt.callback ]]( var_63f39f46151661f8 );
    }
    
    self.quickprompt = undefined;
}

// Namespace quickprompt / scripts\cp_mp\quickprompt
// Params 1
// Checksum 0x0, Offset: 0x5e0
// Size: 0x63
function function_24a08f8a03be8244( var_8f23c9dc9608a79f )
{
    if ( isdefined( self.quickprompt ) )
    {
        if ( isdefined( var_8f23c9dc9608a79f ) && var_8f23c9dc9608a79f && isdefined( self.quickprompt.callback ) )
        {
            self [[ self.quickprompt.callback ]]( 0 );
        }
        
        self.quickprompt = undefined;
        function_aa1b7c7a8261efef( self );
    }
}

