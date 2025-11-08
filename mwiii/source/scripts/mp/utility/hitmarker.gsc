#using scripts\engine\utility;

#namespace hitmarker;

// Namespace hitmarker / scripts\mp\utility\hitmarker
// Params 4
// Checksum 0x0, Offset: 0x161
// Size: 0xa6
function frontend_hitmarker( var_f182d284b07a828e, isdeath, iscivilian, isbody )
{
    if ( !isdefined( isdeath ) )
    {
        isdeath = 0;
    }
    
    if ( !isdefined( iscivilian ) )
    {
        iscivilian = 0;
    }
    
    if ( !isdefined( isbody ) )
    {
        isbody = 0;
    }
    
    alias = getdvar( @"hash_d6875627fd8914de" );
    
    if ( isbody && isdeath )
    {
        level.player playlocalsound( "mp_kill_alert" );
    }
    else if ( isdefined( var_f182d284b07a828e ) )
    {
        playsoundatpos( var_f182d284b07a828e.origin, alias );
    }
    else
    {
        self playsound( alias );
    }
    
    function_2a968ddf3c277ce( "standard", isdeath, 0, iscivilian );
}

// Namespace hitmarker / scripts\mp\utility\hitmarker
// Params 5
// Checksum 0x0, Offset: 0x20f
// Size: 0x156
function function_2a968ddf3c277ce( markertype, killingblow, headshot, nonplayer, icontype )
{
    if ( !isdefined( markertype ) )
    {
        return;
    }
    
    if ( !isdefined( killingblow ) )
    {
        killingblow = 0;
    }
    
    if ( !isdefined( headshot ) )
    {
        headshot = 0;
    }
    
    if ( !isdefined( nonplayer ) )
    {
        nonplayer = 0;
    }
    
    priority = function_e133bfd0c1ab18c9( markertype );
    
    if ( isdefined( self.lasthitmarkertime ) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow )
    {
        return;
    }
    
    self.lasthitmarkertime = gettime();
    self.lasthitmarkerpriority = priority;
    
    if ( isdefined( icontype ) && !istrue( killingblow ) )
    {
        self setclientomnvar( "damage_feedback_icon", icontype );
        self setclientomnvar( "damage_feedback_icon_notify", gettime() );
    }
    
    self setclientomnvar( "damage_feedback", markertype );
    self setclientomnvar( "damage_feedback_notify", gettime() );
    
    if ( killingblow )
    {
        self setclientomnvar( "damage_feedback_kill", 1 );
    }
    else
    {
        self setclientomnvar( "damage_feedback_kill", 0 );
    }
    
    if ( headshot )
    {
        self setclientomnvar( "damage_feedback_headshot", 1 );
    }
    else
    {
        self setclientomnvar( "damage_feedback_headshot", 0 );
    }
    
    if ( nonplayer )
    {
        self setclientomnvar( "damage_feedback_nonplayer", 1 );
        return;
    }
    
    self setclientomnvar( "damage_feedback_nonplayer", 0 );
}

// Namespace hitmarker / scripts\mp\utility\hitmarker
// Params 1
// Checksum 0x0, Offset: 0x36d
// Size: 0x27
function function_e133bfd0c1ab18c9( hitmarkertype )
{
    if ( !isdefined( level.hitmarkerpriorities[ hitmarkertype ] ) )
    {
        return 0;
    }
    
    return level.hitmarkerpriorities[ hitmarkertype ];
}

