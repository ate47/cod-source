#using scripts\common\utility;
#using scripts\engine\flags;
#using scripts\engine\utility;

#namespace flags;

// Namespace flags / scripts\sp\flags
// Params 0
// Checksum 0x0, Offset: 0xae
// Size: 0x90
function init_sp_flags()
{
    if ( !isdefined( level.flag ) )
    {
        scripts\engine\flags::init_flags();
    }
    
    flags = [ "missionfailed", "load_finished", "scriptables_ready" ];
    
    foreach ( flag in flags )
    {
        if ( !flag_exist( flag ) )
        {
            flag_init( flag );
        }
    }
}

