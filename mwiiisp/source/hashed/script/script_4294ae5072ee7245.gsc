#using script_53651341190c5aab;
#using scripts\engine\utility;

#namespace namespace_4c7d643e2ae3dc9b;

// Namespace namespace_4c7d643e2ae3dc9b / namespace_629869afcf9b3b
// Params 2
// Checksum 0x0, Offset: 0xb7
// Size: 0x1c
function startcap( statename, params )
{
    namespace_f901a4f9d899be59::startcap( statename, params );
}

// Namespace namespace_4c7d643e2ae3dc9b / namespace_629869afcf9b3b
// Params 3
// Checksum 0x0, Offset: 0xdb
// Size: 0x38, Type: bool
function processevent( originator, eventtype, eventorigin )
{
    return eventtype == "footstep" || eventtype == "footstep_sprint" || eventtype == "footstep_walk";
}

// Namespace namespace_4c7d643e2ae3dc9b / namespace_629869afcf9b3b
// Params 1
// Checksum 0x0, Offset: 0x11c
// Size: 0x3f
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_4d7ca12cb5ce1028":
            return &startcap;
        case #"hash_b541f16499b1633d":
            return &processevent;
    }
    
    return namespace_f901a4f9d899be59::function_efcea5d26798e5b6( funcid );
}

