#using scripts\asm\asm;

#namespace zombie_traverse;

// Namespace zombie_traverse / namespace_49a23839f1dcc76a
// Params 2
// Checksum 0x0, Offset: 0x9b
// Size: 0x32
function processtraverse( taskid, params )
{
    if ( !self.var_20a0e88052918576 )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace zombie_traverse / namespace_49a23839f1dcc76a
// Params 0
// Checksum 0x0, Offset: 0xd6
// Size: 0x11, Type: bool
function is_traversing()
{
    return self.var_32a34987ee1b3095 != "not_set";
}

