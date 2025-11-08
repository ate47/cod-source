#using script_4a8c20678bd6a83e;
#using scripts\asm\asm;
#using scripts\engine\utility;

#namespace zombie_liveragdoll;

// Namespace zombie_liveragdoll / namespace_7d24de258f16ea69
// Params 2
// Checksum 0x0, Offset: 0xcb
// Size: 0x34
function processliveragdoll( taskid, params )
{
    if ( !ent_flag( "in_liveragdoll" ) )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace zombie_liveragdoll / namespace_7d24de258f16ea69
// Params 2
// Checksum 0x0, Offset: 0x108
// Size: 0x95
function liveragdoll_ai( source_pos, intensity )
{
    if ( !isdefined( source_pos ) )
    {
        return;
    }
    
    if ( is_liveragdoll() )
    {
        return;
    }
    
    if ( !self asmhasstate( self.asmname, "liveragdoll_in" ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_dee78f8c41d19b65", 0 ) > 0 )
    {
        var_4f3eec7aecbb41bf = vectornormalize( self.origin - source_pos );
        self function_babd8af3054d8abe( "head", var_4f3eec7aecbb41bf * intensity, 1, 0 );
    }
    else
    {
        self startliveragdoll();
    }
    
    function_ac90fa5cc0a80298( "liveragdoll_in" );
    return 1;
}

// Namespace zombie_liveragdoll / namespace_7d24de258f16ea69
// Params 0
// Checksum 0x0, Offset: 0x1a6
// Size: 0xd
function is_liveragdoll()
{
    return ent_flag( "in_liveragdoll" );
}

