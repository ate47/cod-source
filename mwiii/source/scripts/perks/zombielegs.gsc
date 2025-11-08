#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace zombielegs;

// Namespace zombielegs / scripts\perks\zombielegs
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x159
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace zombielegs / scripts\perks\zombielegs
// Params 1
// Checksum 0x0, Offset: 0x179
// Size: 0x6c
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_zombie_legs" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_65863a18b3d1ad87 ) )
    {
        level [[ params.var_65863a18b3d1ad87 ]]( "specialty_zombie_legs", &perk_set, &perk_unset, [ "specialty_sprintreload", "specialty_sprintmelee" ] );
    }
}

// Namespace zombielegs / scripts\perks\zombielegs
// Params 0
// Checksum 0x0, Offset: 0x1ed
// Size: 0xa
function perk_set()
{
    thread function_c6668bb917e966b2();
}

// Namespace zombielegs / scripts\perks\zombielegs
// Params 0
// Checksum 0x0, Offset: 0x1ff
// Size: 0x27
function perk_unset()
{
    self lerpfovbypreset( "default_2seconds" );
    self notify( "zombie_legs_unset" );
    self.falldamageprotection = 0;
    function_b87b3a7ec17c52ba();
}

// Namespace zombielegs / scripts\perks\zombielegs
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x53
function function_c6668bb917e966b2()
{
    self endon( "death_or_disconnect" );
    self endon( "zombie_legs_unset" );
    self refreshsprinttime();
    self lerpfovbypreset( "zombiedefault" );
    self.falldamageprotection = 1;
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

// Namespace zombielegs / scripts\perks\zombielegs
// Params 0
// Checksum 0x0, Offset: 0x289
// Size: 0x77
function function_74ef4a883340b273()
{
    bundle = level.perkbundles[ "specialty_zombie_legs" ];
    speedmod = isdefined( bundle.var_ac707f58a9f3b733 ) ? bundle.var_ac707f58a9f3b733 : 0.1;
    self.perkzombielegsspeedmod = speedmod;
    
    if ( utility::issharedfuncdefined( "player", "updateMoveSpeed" ) )
    {
        utility::callsharedfunc( "player", "updateMoveSpeed" );
    }
}

// Namespace zombielegs / scripts\perks\zombielegs
// Params 0
// Checksum 0x0, Offset: 0x308
// Size: 0x30
function function_b87b3a7ec17c52ba()
{
    self.perkzombielegsspeedmod = undefined;
    
    if ( utility::issharedfuncdefined( "player", "updateMoveSpeed" ) )
    {
        utility::callsharedfunc( "player", "updateMoveSpeed" );
    }
}

