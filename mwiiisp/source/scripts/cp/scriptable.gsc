#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;

#namespace scriptable;

// Namespace scriptable / scripts\cp\scriptable
// Params 0
// Checksum 0x0, Offset: 0x92
// Size: 0xe
function scriptable_cpglobalcallback()
{
    scripts\engine\scriptable::scriptable_setinitcallback( &scriptable_cpcallback );
}

// Namespace scriptable / scripts\cp\scriptable
// Params 0
// Checksum 0x0, Offset: 0xa8
// Size: 0x28
function scriptable_cpcallback()
{
    if ( !flag_exist( "scriptables_ready" ) )
    {
        flag_init( "scriptables_ready" );
    }
    
    flag_set( "scriptables_ready" );
}

