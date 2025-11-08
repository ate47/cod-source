#using script_3c4008d0ac301044;
#using scripts\engine\utility;

#namespace namespace_ccabef44488edcf1;

// Namespace namespace_ccabef44488edcf1 / namespace_31a4c6c3ceab6b2a
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xee
// Size: 0x18
function autoexec auto()
{
    utility::registersharedfunc( "ob_unstable_rift", "init_map", &init );
}

// Namespace namespace_ccabef44488edcf1 / namespace_31a4c6c3ceab6b2a
// Params 0
// Checksum 0x0, Offset: 0x10e
// Size: 0x42
function init()
{
    mp_jup_fort_ob_unstable_rift_cs::main();
    
    if ( getdvarint( @"hash_bc12bf20804347c5", 1 ) )
    {
        function_eb7f544259415a09( "mp_jup_fort_ob_unstable_rifts" );
    }
    
    if ( getdvarint( @"hash_af186b5cfdb2e7c0", 1 ) )
    {
        thread function_d963b1c1ea4328e6();
    }
}

// Namespace namespace_ccabef44488edcf1 / namespace_31a4c6c3ceab6b2a
// Params 0
// Checksum 0x0, Offset: 0x158
// Size: 0x10f
function function_d963b1c1ea4328e6()
{
    utility::flag_wait( "scriptables_ready" );
    var_45b5395bf31775c7 = getentitylessscriptablearray( %"ob_loot_crystal_medium_01" );
    
    foreach ( index, crystal in var_45b5395bf31775c7 )
    {
        if ( index % 10 == 0 )
        {
            waitframe();
        }
        
        crystal.var_f6f86c3af9ca88a0 = 1;
        crystal setscriptablepartstate( #"loot_crystal", #"dead" );
    }
    
    var_45b5395bf31775c7 = getentitylessscriptablearray( %"ob_loot_crystal_medium_02" );
    
    foreach ( index, crystal in var_45b5395bf31775c7 )
    {
        if ( index % 10 == 0 )
        {
            waitframe();
        }
        
        crystal.var_f6f86c3af9ca88a0 = 1;
        crystal setscriptablepartstate( #"loot_crystal", #"dead" );
        waitframe();
    }
}

