#using script_1311c5c284dd1537;
#using script_28b5f185a9f45899;
#using script_4071f60cff3c93b6;
#using script_497512e9383077fc;
#using script_4beb45978e7f481c;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\utility\game;

#namespace mp_swap_meet;

// Namespace mp_swap_meet / namespace_52cc23964e7edcd
// Params 0
// Checksum 0x0, Offset: 0x21e
// Size: 0xd6
function main()
{
    namespace_836869a0a0aef493::main();
    namespace_3673c4f323e7cf7c::main();
    namespace_24cce3044ce791f8::main();
    namespace_b87b38a62cfa6b06::main();
    scripts\mp\load::main();
    namespace_5633828963c62e57::function_57d6a393b90824dc( 3580 );
    scripts\cp_mp\utility\game_utility::function_9cfe515677727128();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_swap_meet" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level function_3c37e8e4377aa2b3();
    level.music_style = "mexico";
    level thread disabledoors();
}

// Namespace mp_swap_meet / namespace_52cc23964e7edcd
// Params 0
// Checksum 0x0, Offset: 0x2fc
// Size: 0x40
function function_1682cf22619a5e55()
{
    level waittill( "infil_setup_complete" );
    var_6120df12544987e8 = getent( "static_infil_van", "targetname" );
    
    if ( gameflag( "infil_will_run" ) && isdefined( var_6120df12544987e8 ) )
    {
        var_6120df12544987e8 hide();
    }
}

// Namespace mp_swap_meet / namespace_52cc23964e7edcd
// Params 0
// Checksum 0x0, Offset: 0x344
// Size: 0x40
function function_3c37e8e4377aa2b3()
{
    scripts\mp\equipment\tactical_cover::function_f41f835b1ab9dbd8( ( 28667, -30820.5, 3148 ), scripts\mp\equipment\tactical_cover::function_85555e609b23b2be( 0 ), undefined, -6, 0 );
    scripts\mp\equipment\tactical_cover::function_f41f835b1ab9dbd8( ( 29059, -30733.5, 3172 ), scripts\mp\equipment\tactical_cover::function_85555e609b23b2be( 0 ), undefined, -6, 0 );
}

// Namespace mp_swap_meet / namespace_52cc23964e7edcd
// Params 0
// Checksum 0x0, Offset: 0x38c
// Size: 0x235
function disabledoors()
{
    level waittill( "scriptables_ready" );
    locations = [ ( 28254, -26908, 3221 ), ( 28079, -27004, 3221 ), ( 28517, -26773, 3221 ), ( 28837, -26540, 3221 ), ( 29827, -30964, 3180 ), ( 29704, -31334, 3180 ), ( 31500, -31632, 3200 ), ( 28297, -32380, 3200 ), ( 28561, -32880, 3200 ), ( 28458, -32676, 3333 ), ( 26719, -32967, 3200 ), ( 26858, -33103, 3200 ), ( 27489, -33903, 3300 ), ( 28024, -32957, 3200 ), ( 24902, -29787, 3200 ), ( 24688, -29914, 3200 ), ( 25194, -32217, 3300 ), ( 25055, -32000, 3300 ), ( 24952, -31772, 3300 ), ( 24717, -28102, 3200 ), ( 24719, -27904, 3200 ) ];
    radius = 256;
    
    foreach ( loc in locations )
    {
        doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius( loc, radius, 256 );
        
        foreach ( door in doors )
        {
            if ( door scriptableisdoor() )
            {
                door scriptabledoorfreeze();
            }
        }
    }
}

