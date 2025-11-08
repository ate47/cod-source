#using scripts\engine\utility;

#namespace zombie_pain;

// Namespace zombie_pain / namespace_78c973ae34c2db64
// Params 2
// Checksum 0x0, Offset: 0x9a
// Size: 0x34
function isinpain( taskid, params )
{
    if ( !ent_flag( "in_pain" ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

