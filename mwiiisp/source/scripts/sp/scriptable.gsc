#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\sp\door_scriptable;
#using scripts\sp\interactables\dynolight;

#namespace scriptable;

// Namespace scriptable / scripts\sp\scriptable
// Params 0
// Checksum 0x0, Offset: 0x123
// Size: 0xe
function scriptable_spglobalcallback()
{
    scripts\engine\scriptable::scriptable_setinitcallback( &scriptable_spcallback );
}

// Namespace scriptable / scripts\sp\scriptable
// Params 0
// Checksum 0x0, Offset: 0x139
// Size: 0x129
function scriptable_spcallback()
{
    starttime = gettime();
    scriptables = getscriptablearray( "scriptable", "code_classname" );
    
    foreach ( scriptable in scriptables )
    {
        if ( isdefined( scriptable.initialized ) )
        {
            thread scriptable_print_warning();
            continue;
        }
        
        if ( isdefined( scriptable.script_noteworthy ) )
        {
            if ( scriptable.script_noteworthy == "interactive_door" )
            {
                scriptable scripts\sp\door_scriptable::scriptable_init();
            }
            else if ( issubstr( scriptable.script_noteworthy, "dynolight" ) )
            {
                scripts\sp\interactables\dynolight::add_dynolight( scriptable );
            }
        }
        
        scriptable.initialized = 1;
    }
    
    scripts\sp\interactables\dynolight::init();
    assertex( gettime() == starttime, "<dev string:x1c>" );
    waitframe();
    
    if ( !flag_exist( "scriptables_ready" ) )
    {
        flag_init( "scriptables_ready" );
    }
    
    flag_set( "scriptables_ready" );
}

// Namespace scriptable / scripts\sp\scriptable
// Params 0
// Checksum 0x0, Offset: 0x26a
// Size: 0x2c
function scriptable_print_warning()
{
    if ( isdefined( level.scriptable_warning ) )
    {
        return;
    }
    
    level.scriptable_warning = 1;
    wait 0.1;
    iprintln( "^3Scriptables tried re-initializing, you may want to map_restart for safety" );
}

