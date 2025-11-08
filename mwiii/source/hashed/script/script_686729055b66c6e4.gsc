#using scripts\asm\asm;
#using scripts\engine\utility;

#namespace zombie_stun;

// Namespace zombie_stun / namespace_ed7c38f3847343dc
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xce
// Size: 0x2e
function private autoexec init()
{
    registersharedfunc( "zombie", "stunZombie", &stun_ai );
    registersharedfunc( "zombie", "clearStunZombie", &clear_stun );
}

// Namespace zombie_stun / namespace_ed7c38f3847343dc
// Params 2
// Checksum 0x0, Offset: 0x104
// Size: 0x36
function processstun( taskid, params )
{
    if ( !is_stunned() )
    {
        return anim.failure;
    }
    
    self clearpath();
    return anim.running;
}

// Namespace zombie_stun / namespace_ed7c38f3847343dc
// Params 1
// Checksum 0x0, Offset: 0x143
// Size: 0xe0
function stun_ai( duration )
{
    if ( isdefined( self.aisettings ) && !istrue( self.aisettings.var_836834377fb9b633 ) )
    {
        return;
    }
    
    if ( istrue( self.disallow_stun ) )
    {
        return;
    }
    
    assert( isdefined( duration ) );
    
    if ( !isdefined( self.asmname ) )
    {
        return;
    }
    
    if ( !self asmhasstate( self.asmname, "stun_in" ) )
    {
        return;
    }
    
    end_time = gettime() + int( duration * 1000 );
    
    if ( isdefined( self.var_b40984b29c45936d ) && self.var_b40984b29c45936d > end_time )
    {
        return;
    }
    
    self._blackboard.zombiestunendtime = end_time;
    self._blackboard.zombieinstun = 1;
    function_ac90fa5cc0a80298( "stun_in" );
}

// Namespace zombie_stun / namespace_ed7c38f3847343dc
// Params 0
// Checksum 0x0, Offset: 0x22b
// Size: 0x33, Type: bool
function is_stunned()
{
    return isdefined( self._blackboard.zombiestunendtime ) && gettime() < self._blackboard.zombiestunendtime;
}

// Namespace zombie_stun / namespace_ed7c38f3847343dc
// Params 0
// Checksum 0x0, Offset: 0x267
// Size: 0x39
function clear_stun()
{
    if ( isdefined( self._blackboard ) )
    {
        self._blackboard.zombiestunendtime = 0;
        self._blackboard.zombieinstun = 0;
    }
}

