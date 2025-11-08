#using script_2a30ac7aa0ee8988;
#using scripts\core_common\item_world_fixup;

#namespace namespace_fa1b683c;

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0, eflags: 0x1
// Checksum 0x41f00dbe, Offset: 0x160
// Size: 0x1a4
function autoexec __init__()
{
    gametype = function_be90acca( getdvarstring( #"g_gametype" ) );
    
    switch ( gametype )
    {
        case #"fireteam_dirty_bomb":
            function_cbbf16a4();
            break;
        case #"hash_6463dea5fa2dbea5":
            function_e5d1b704();
            break;
        case #"fireteam_elimination":
            function_574dc51f();
            break;
        case #"fireteam_koth":
            function_1ed4cf79();
            break;
        case #"fireteam_satlink":
            function_11109d50();
            break;
        case #"zsurvival":
            function_bcd11f83();
            break;
        default:
            break;
    }
    
    namespace_1c7b37c6::item_replacer( &item_world_fixup::function_6991057, #"downhill_parent_list", #"t9_empty_global" );
    function_f05c9e0a();
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0x2292473, Offset: 0x310
// Size: 0x14
function function_cbbf16a4()
{
    function_c379f040();
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0xa3e120ac, Offset: 0x330
// Size: 0x54
function function_e5d1b704()
{
    namespace_1c7b37c6::item_replacer( &item_world_fixup::function_6991057, #"t9_dirty_bomb_stash_parent", #"t9_intercept_stash_parent" );
    function_c379f040();
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0x293a13a2, Offset: 0x390
// Size: 0x54
function function_574dc51f()
{
    namespace_1c7b37c6::item_replacer( &item_world_fixup::function_6991057, #"t9_dirty_bomb_stash_parent", #"t9_elimination_stash_parent" );
    function_c379f040();
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0xb867ddc0, Offset: 0x3f0
// Size: 0xa4
function function_1ed4cf79()
{
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"t9_dirty_bomb_stash_parent", #"t9_koth_stash_parent" );
    function_c379f040();
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0x721728ec, Offset: 0x4a0
// Size: 0xa4
function function_11109d50()
{
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"t9_dirty_bomb_stash_parent", #"t9_satlink_stash_parent" );
    function_c379f040();
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0x29b5e101, Offset: 0x550
// Size: 0x104
function function_bcd11f83()
{
    namespace_1c7b37c6::item_replacer( &item_world_fixup::function_6991057, #"t9_dirty_bomb_stash_parent", #"t9_empty_global" );
    namespace_1c7b37c6::item_replacer( &item_world_fixup::function_6991057, #"wz_russia_snowmobile_ski_slopes_mp", #"t9_empty_global" );
    namespace_1c7b37c6::item_replacer( &item_world_fixup::function_6991057, #"wz_russia_sedan_ski_slope_mp", #"t9_empty_global" );
    namespace_1c7b37c6::item_replacer( &item_world_fixup::function_6991057, #"wz_russia_uaz_ski_slope_mp", #"t9_empty_global" );
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0xea95cc6c, Offset: 0x660
// Size: 0x17c
function function_f05c9e0a()
{
    function_8341771e( function_91b29d2a( "location_items_lodge" ), 10000, #"dirty_bomb_stash_lodge" );
    function_8341771e( function_91b29d2a( "location_items_medevac" ), 9000, #"dirty_bomb_stash_medevac" );
    function_8341771e( function_91b29d2a( "location_items_maintenance" ), 8000, #"dirty_bomb_stash_maintenance" );
    function_8341771e( function_91b29d2a( "location_items_hilltop" ), 10000, #"dirty_bomb_stash_hilltop" );
    function_8341771e( function_91b29d2a( "location_items_bathhouse" ), 8000, #"dirty_bomb_stash_bathhouse" );
    function_8341771e( function_91b29d2a( "location_items_ski_slopes" ), 8000, #"dirty_bomb_stash_ski_slopes", array( ( -4880, -2985.5, 3625 ) ) );
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 4
// Checksum 0x2e5c3c55, Offset: 0x7e8
// Size: 0x27c
function function_8341771e( locations, radius, name, var_1c36d5ca = [] )
{
    var_32948f8f = function_91b29d2a( "dirty_bomb_stash" );
    
    foreach ( location in locations )
    {
        foreach ( var_64b8ecb8 in var_32948f8f )
        {
            if ( distance2dsquared( location.origin, var_64b8ecb8.origin ) <= radius * radius )
            {
                remove = 0;
                var_d196e508 = var_64b8ecb8.origin;
                item_world_fixup::function_a997e342( var_d196e508, 16 );
                
                foreach ( remove_item in var_1c36d5ca )
                {
                    if ( distance2dsquared( remove_item, var_64b8ecb8.origin ) <= 1024 )
                    {
                        remove = 1;
                    }
                }
                
                if ( isdefined( name ) && !is_true( remove ) )
                {
                    item_world_fixup::add_spawn_point( var_d196e508, name, var_64b8ecb8.angles );
                }
            }
        }
    }
}

// Namespace namespace_fa1b683c/namespace_fa1b683c
// Params 0
// Checksum 0xf52b190b, Offset: 0xa70
// Size: 0x1c
function function_c379f040()
{
    hidemiscmodels( "magicbox_zbarrier" );
}

