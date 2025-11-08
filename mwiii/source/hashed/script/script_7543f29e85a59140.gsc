#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace namespace_c423e7ace4707941;

// Namespace namespace_c423e7ace4707941 / namespace_85544694a2e84ce8
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x145
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace namespace_c423e7ace4707941 / namespace_85544694a2e84ce8
// Params 1
// Checksum 0x0, Offset: 0x165
// Size: 0x63
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_tac_sprint_boots" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_65863a18b3d1ad87 ) )
    {
        level [[ params.var_65863a18b3d1ad87 ]]( "specialty_tac_sprint_boots", &perk_set, &perk_unset, [ "specialty_sprintmelee" ] );
    }
}

// Namespace namespace_c423e7ace4707941 / namespace_85544694a2e84ce8
// Params 0
// Checksum 0x0, Offset: 0x1d0
// Size: 0x18
function perk_set()
{
    thread function_c6668bb917e966b2();
    self setclientomnvar( "ui_tac_sprint_boots_equipped", 1 );
}

// Namespace namespace_c423e7ace4707941 / namespace_85544694a2e84ce8
// Params 0
// Checksum 0x0, Offset: 0x1f0
// Size: 0x1e
function perk_unset()
{
    self notify( "tac_sprint_boots_unset" );
    self setclientomnvar( "ui_tac_sprint_boots_equipped", 0 );
    function_b87b3a7ec17c52ba();
}

// Namespace namespace_c423e7ace4707941 / namespace_85544694a2e84ce8
// Params 0
// Checksum 0x0, Offset: 0x216
// Size: 0x3c
function function_c6668bb917e966b2()
{
    self endon( "death_or_disconnect" );
    self endon( "tac_sprint_boots_unset" );
    self refreshsprinttime();
    function_74ef4a883340b273();
    
    while ( true )
    {
        if ( self issupersprinting() )
        {
            self refreshsprinttime();
        }
        
        wait 0.1;
    }
}

// Namespace namespace_c423e7ace4707941 / namespace_85544694a2e84ce8
// Params 0
// Checksum 0x0, Offset: 0x25a
// Size: 0x68
function function_74ef4a883340b273()
{
    bundle = level.perkbundles[ "specialty_tac_sprint_boots" ];
    speedmod = getdvarint( @"hash_281481ccb17dbf14", 0.1 );
    self.perkzombielegsspeedmod = speedmod;
    
    if ( utility::issharedfuncdefined( "player", "updateMoveSpeed" ) )
    {
        utility::callsharedfunc( "player", "updateMoveSpeed" );
    }
}

// Namespace namespace_c423e7ace4707941 / namespace_85544694a2e84ce8
// Params 0
// Checksum 0x0, Offset: 0x2ca
// Size: 0x30
function function_b87b3a7ec17c52ba()
{
    self.perkzombielegsspeedmod = undefined;
    
    if ( utility::issharedfuncdefined( "player", "updateMoveSpeed" ) )
    {
        utility::callsharedfunc( "player", "updateMoveSpeed" );
    }
}

