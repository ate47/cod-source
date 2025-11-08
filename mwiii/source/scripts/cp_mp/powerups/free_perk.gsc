#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\cp_mp\powerups\powerups;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;

#namespace free_perk;

// Namespace free_perk / scripts\cp_mp\powerups\free_perk
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xbd
// Size: 0x9
function autoexec main()
{
    function_bf3da8298127a63b();
}

// Namespace free_perk / scripts\cp_mp\powerups\free_perk
// Params 0
// Checksum 0x0, Offset: 0xce
// Size: 0x55
function function_bf3da8298127a63b()
{
    register_powerup( "free_perk", &grab_free_perk );
    
    /#
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        function_b23a59dfb4ca49a1( "<dev string:x2f>", "<dev string:x4e>", &function_e2b8eeccc951133f );
        function_b23a59dfb4ca49a1( "<dev string:x71>", "<dev string:x90>", &function_e2b8eeccc951133f );
        function_fe953f000498048f();
    #/
}

// Namespace free_perk / scripts\cp_mp\powerups\free_perk
// Params 2
// Checksum 0x0, Offset: 0x12b
// Size: 0x7a
function grab_free_perk( str_powerup, ent_powerup )
{
    a_players = function_a56a8b17eae57b09( str_powerup );
    
    foreach ( player in a_players )
    {
        player give_player_perk();
        player thread function_676437737684783f( str_powerup );
    }
}

// Namespace free_perk / scripts\cp_mp\powerups\free_perk
// Params 0
// Checksum 0x0, Offset: 0x1ad
// Size: 0x37
function give_player_perk()
{
    perk_str = zombie_perks::function_cdb669c56d86f5c4();
    
    /#
        if ( isdefined( perk_str ) )
        {
            iprintlnbold( "<dev string:xb3>" + perk_str );
            return;
        }
        
        iprintlnbold( "<dev string:xcd>" );
    #/
}

