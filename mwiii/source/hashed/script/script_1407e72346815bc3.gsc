#using script_1407e72346815bc3;
#using scripts\common\utility;
#using scripts\cp_mp\stealth\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\perk;

#namespace manager_mp;

// Namespace manager_mp / namespace_583fd9066a09cd33
// Params 0
// Checksum 0x0, Offset: 0xf4
// Size: 0x5d
function init()
{
    if ( scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b() )
    {
        level.var_6ccee8e6c00f06e6 = &namespace_583fd9066a09cd33::init_player;
        setdvarifuninitialized( @"scr_sixthsense_enabled", 1 );
        
        if ( getdvarint( @"scr_sixthsense_enabled" ) )
        {
            level.stealth.fnsixthsense = &sixthsense_init;
            level thread scripts\cp_mp\stealth\utility::function_a5ff5e1965faf40e();
        }
    }
}

// Namespace manager_mp / namespace_583fd9066a09cd33
// Params 0
// Checksum 0x0, Offset: 0x159
// Size: 0x37
function init_player()
{
    self waittill( "giveLoadout" );
    
    if ( isdefined( level.stealth.fnsixthsense ) )
    {
        [[ level.stealth.fnsixthsense ]]();
    }
}

// Namespace manager_mp / namespace_583fd9066a09cd33
// Params 0
// Checksum 0x0, Offset: 0x198
// Size: 0x4c
function sixthsense_init()
{
    self endon( "death" );
    self.sixthsense = spawnstruct();
    self.sixthsense.active = 1;
    
    /#
        setdvarifuninitialized( @"hash_3a87475a75de0350", 0 );
    #/
    
    scripts\mp\utility\perk::giveperk( "specialty_ai_stealth_sixth_sense" );
}

// Namespace manager_mp / namespace_583fd9066a09cd33
// Params 0
// Checksum 0x0, Offset: 0x1ec
// Size: 0x2c
function dropaiaccuracy()
{
    if ( !scripts\common\utility::function_a10967d736dc56e5() )
    {
        return;
    }
    
    assertex( isplayer( self ), "<dev string:x1c>" );
    scripts\cp_mp\stealth\utility::setattackeraccuracy( 0.1 );
}

// Namespace manager_mp / namespace_583fd9066a09cd33
// Params 0
// Checksum 0x0, Offset: 0x220
// Size: 0x29
function revertaiaccuracy()
{
    if ( !scripts\common\utility::function_a10967d736dc56e5() )
    {
        return;
    }
    
    assertex( isplayer( self ), "<dev string:x1c>" );
    scripts\cp_mp\stealth\utility::setattackeraccuracy( 1 );
}

