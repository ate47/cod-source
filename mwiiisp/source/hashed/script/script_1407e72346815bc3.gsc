#using script_1407e72346815bc3;
#using scripts\cp_mp\stealth\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\perk;

#namespace manager_mp;

// Namespace manager_mp / namespace_583fd9066a09cd33
// Params 0
// Checksum 0x0, Offset: 0xfb
// Size: 0x8d
function init()
{
    if ( getdvar( @"scr_br_gametype", "" ) == "dmz" || getdvar( @"scr_br_gametype", "" ) == "exgm" )
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
// Checksum 0x0, Offset: 0x190
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
// Checksum 0x0, Offset: 0x1cf
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
// Checksum 0x0, Offset: 0x223
// Size: 0x30
function dropaiaccuracy()
{
    if ( !istrue( level.supportsai ) )
    {
        return;
    }
    
    assertex( isplayer( self ), " This function needs to be called on a Player entity " );
    scripts\cp_mp\stealth\utility::setattackeraccuracy( 0.1 );
}

// Namespace manager_mp / namespace_583fd9066a09cd33
// Params 0
// Checksum 0x0, Offset: 0x25b
// Size: 0x2d
function revertaiaccuracy()
{
    if ( !istrue( level.supportsai ) )
    {
        return;
    }
    
    assertex( isplayer( self ), " This function needs to be called on a Player entity " );
    scripts\cp_mp\stealth\utility::setattackeraccuracy( 1 );
}

