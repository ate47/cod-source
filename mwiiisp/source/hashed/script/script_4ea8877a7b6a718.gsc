#using script_53651341190c5aab;
#using scripts\asm\asm_bb;

#namespace namespace_5a3b74f5fb73d362;

// Namespace namespace_5a3b74f5fb73d362 / namespace_3d70e7b6ee67a642
// Params 2
// Checksum 0x0, Offset: 0x89
// Size: 0x3d
function startcap( statename, params )
{
    walkspeed = 50;
    scripts\asm\asm_bb::bb_setcivilianstate( "casual" );
    scripts\asm\asm_bb::bb_civilianrequestspeed( walkspeed );
    namespace_f901a4f9d899be59::startcap( statename, params );
}

// Namespace namespace_5a3b74f5fb73d362 / namespace_3d70e7b6ee67a642
// Params 1
// Checksum 0x0, Offset: 0xce
// Size: 0x22
function getfunction( funcid )
{
    if ( funcid == "start_cap" )
    {
        return &startcap;
    }
    
    return namespace_f901a4f9d899be59::function_efcea5d26798e5b6( funcid );
}

