#using script_7edf952f8921aa6b;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#using scripts\mp\utility\perk;

#namespace ob_grenade_bandolier;

// Namespace ob_grenade_bandolier / namespace_593e9276deb68376
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x164
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_grenade_bandolier", undefined, undefined, &function_c781372c4c11366d );
}

// Namespace ob_grenade_bandolier / namespace_593e9276deb68376
// Params 0
// Checksum 0x0, Offset: 0x185
// Size: 0x24
function function_c781372c4c11366d()
{
    /#
        level thread function_cb20a7fcb97fd9c3();
    #/
    
    registersharedfunc( "ob_grenade_bandolier", "grenade_bandolier_give", &function_2cbcbfe35fda7eed );
}

// Namespace ob_grenade_bandolier / namespace_593e9276deb68376
// Params 0
// Checksum 0x0, Offset: 0x1b1
// Size: 0x33
function function_2cbcbfe35fda7eed()
{
    self.var_194cdb94551bc049 = 1;
    giveperk( "specialty_grenade_bandolier" );
    self playsound( "evt_ob_rr_grenade_bandolier_activate" );
    self setclientomnvar( "ui_ob_grenade_bandolier", 1 );
}

/#

    // Namespace ob_grenade_bandolier / namespace_593e9276deb68376
    // Params 0
    // Checksum 0x0, Offset: 0x1ec
    // Size: 0x2e, Type: dev
    function function_cb20a7fcb97fd9c3()
    {
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x36>", "<dev string:x50>", &scripts\cp_mp\loot\common_item::function_f8162124bbb6ece3 );
        function_fe953f000498048f();
    }

#/
