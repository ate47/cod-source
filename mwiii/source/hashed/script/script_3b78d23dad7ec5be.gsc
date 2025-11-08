#using script_4a8c20678bd6a83e;
#using scripts\asm\asm;
#using scripts\engine\utility;

#namespace zombie_knockdown;

// Namespace zombie_knockdown / namespace_db1ce2c035564e2c
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xe3
// Size: 0x2e
function private autoexec init()
{
    registersharedfunc( "zombie", "knockdownZombie", &knockdown_ai );
    registersharedfunc( "zombie", "isZombieInKnockdown", &function_e67a89537ae7d4b7 );
}

// Namespace zombie_knockdown / namespace_db1ce2c035564e2c
// Params 1
// Checksum 0x0, Offset: 0x119
// Size: 0x78
function knockdown_ai( source_pos )
{
    if ( istrue( self.disallow_knockdown ) )
    {
        return;
    }
    
    if ( !isdefined( source_pos ) )
    {
        return;
    }
    
    if ( is_traversing() )
    {
        return;
    }
    
    if ( !self asmhasstate( self.asmname, "knockdown_in" ) )
    {
        return;
    }
    
    self._blackboard.var_a2f67f5b76db39ca = source_pos;
    self._blackboard.zombieinknockdown = 1;
    function_ac90fa5cc0a80298( "knockdown_in" );
}

// Namespace zombie_knockdown / namespace_db1ce2c035564e2c
// Params 0
// Checksum 0x0, Offset: 0x199
// Size: 0x16, Type: bool
function function_e67a89537ae7d4b7()
{
    return istrue( self._blackboard.zombieinknockdown );
}

