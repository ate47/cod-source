#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\anim;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;

#namespace namespace_9557c6e91ec6eb3f;

// Namespace namespace_9557c6e91ec6eb3f / namespace_e843e932ce449bb8
// Params 0
// Checksum 0x0, Offset: 0x13c
// Size: 0x32
function main()
{
    thread function_9b7e8fb8eb52245f();
    thread function_ebc334c0f5f00b14();
    thread function_751d41eacd92dc23();
    thread function_e5ea7bc0ccdc51b2();
    thread function_b1b7851848cf0806();
    thread function_2b1dae6e760cb3b8();
}

// Namespace namespace_9557c6e91ec6eb3f / namespace_e843e932ce449bb8
// Params 0
// Checksum 0x0, Offset: 0x176
// Size: 0x38
function function_9b7e8fb8eb52245f()
{
    while ( true )
    {
        var_94be25a9f606e231 = randomfloatrange( 3, 8 );
        wait var_94be25a9f606e231;
        playsoundatpos( ( 4060.75, 44829.6, 1639.77 ), "emt_distant_bootcamp" );
    }
}

// Namespace namespace_9557c6e91ec6eb3f / namespace_e843e932ce449bb8
// Params 0
// Checksum 0x0, Offset: 0x1b6
// Size: 0x38
function function_ebc334c0f5f00b14()
{
    while ( true )
    {
        var_4c7b13b61c727c8e = randomfloatrange( 3, 9 );
        wait var_4c7b13b61c727c8e;
        playsoundatpos( ( 2804.07, 51337.5, 1266 ), "emt_russian_firing_range_instructions" );
    }
}

// Namespace namespace_9557c6e91ec6eb3f / namespace_e843e932ce449bb8
// Params 0
// Checksum 0x0, Offset: 0x1f6
// Size: 0x38
function function_751d41eacd92dc23()
{
    while ( true )
    {
        var_919356172963d785 = randomfloatrange( 3, 8 );
        wait var_919356172963d785;
        playsoundatpos( ( 9609.64, 48203, 1443.67 ), "emt_construction_noises" );
    }
}

// Namespace namespace_9557c6e91ec6eb3f / namespace_e843e932ce449bb8
// Params 0
// Checksum 0x0, Offset: 0x236
// Size: 0x38
function function_e5ea7bc0ccdc51b2()
{
    while ( true )
    {
        var_469d6ccd5efedfc = randomfloatrange( 2, 5 );
        wait var_469d6ccd5efedfc;
        playsoundatpos( ( 3410.21, 51617, 1343.57 ), "emt_distant_gun_a" );
    }
}

// Namespace namespace_9557c6e91ec6eb3f / namespace_e843e932ce449bb8
// Params 0
// Checksum 0x0, Offset: 0x276
// Size: 0x39
function function_b1b7851848cf0806()
{
    while ( true )
    {
        var_c4c352be9cb07c00 = randomfloat( 2 ) + 3;
        wait var_c4c352be9cb07c00;
        playsoundatpos( ( 2427.02, 51136.5, 1208.98 ), "emt_close_guns" );
    }
}

// Namespace namespace_9557c6e91ec6eb3f / namespace_e843e932ce449bb8
// Params 0
// Checksum 0x0, Offset: 0x2b7
// Size: 0x39
function function_2b1dae6e760cb3b8()
{
    while ( true )
    {
        var_120bcd332ae10162 = randomfloat( 3 ) + 2;
        wait var_120bcd332ae10162;
        playsoundatpos( ( 2427.02, 51136.5, 1208.98 ), "emt_distant_gunshot_smg" );
    }
}

