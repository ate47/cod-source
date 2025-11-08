#using script_261e315c49e5e4ef;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;

#namespace br_publicevent_loadoutdrop;

// Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xb8
// Size: 0x21
function autoexec main()
{
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"loadoutdrop", &init );
    
    /#
        debug_init();
    #/
}

// Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
// Params 1
// Checksum 0x0, Offset: 0xe1
// Size: 0x3e
function init( eventinfo )
{
    eventinfo.validatefunc = &validatefunc;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
// Params 0
// Checksum 0x0, Offset: 0x127
// Size: 0x3a
function activatefunc()
{
    level thread function_ad91760f4f41c169( 0 );
    level thread function_ab8c6a785614ca99( 0 );
    var_70bcbf0ad5028219 = [ 1, 1 ];
    namespace_f51c41a139e03299::function_607167c18661377b( var_70bcbf0ad5028219, undefined, 1 );
}

// Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
// Params 0
// Checksum 0x0, Offset: 0x169
// Size: 0x4, Type: bool
function validatefunc()
{
    return true;
}

// Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
// Params 0
// Checksum 0x0, Offset: 0x176
// Size: 0x2
function postinitfunc()
{
    
}

/#

    // Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
    // Params 0
    // Checksum 0x0, Offset: 0x180
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
    // Params 0
    // Checksum 0x0, Offset: 0x18d
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x1c>" );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x34>", "<dev string:x44>", &function_db70bae7732f5204 );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace br_publicevent_loadoutdrop / scripts\mp\gametypes\br_publicevent_loadoutdrop
    // Params 0
    // Checksum 0x0, Offset: 0x1c3
    // Size: 0x17, Type: dev
    function function_db70bae7732f5204()
    {
        level thread scripts\mp\gametypes\br_publicevents::function_e37ee072d95a7c98( %"loadoutdrop" );
    }

#/
