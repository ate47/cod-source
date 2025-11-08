#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\supers;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;

#namespace laststand_heal;

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x1e3
// Size: 0x141
function laststandheal_onset()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "lastStandHeal_unset" );
    waittillframeend();
    thread laststandheal_watchrespawn();
    self.laststandheal_hassuperweapon = 1;
    
    while ( true )
    {
        if ( self.laststandheal_hassuperweapon && ( !istrue( self.inlaststand ) || istrue( self.stuckinlaststand ) || istrue( getbeingrevivedinternal() ) ) )
        {
            superweapon = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
            self clearoffhandspecial();
            
            if ( isdefined( superweapon ) )
            {
                scripts\cp_mp\utility\inventory_utility::_takeweapon( superweapon );
            }
            
            self.laststandheal_hassuperweapon = 0;
        }
        else if ( !self.laststandheal_hassuperweapon && istrue( self.inlaststand ) && !istrue( self.stuckinlaststand ) && !istrue( getbeingrevivedinternal() ) )
        {
            superweapon = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
            scripts\cp_mp\utility\inventory_utility::_giveweapon( superweapon );
            ammo = ter_op( scripts\mp\supers::issuperready(), 1, 0 );
            self setweaponammoclip( superweapon, ammo );
            self assignweaponoffhandspecial( superweapon );
            self.laststandheal_hassuperweapon = 1;
        }
        
        wait 0.05;
    }
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x32c
// Size: 0xa
function laststandheal_unset()
{
    self notify( "lastStandHeal_unset" );
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x33e
// Size: 0x2f
function laststandheal_watchrespawn()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "lastStandHeal_unset" );
    
    while ( true )
    {
        self waittill( "spawned_player" );
        waittillframeend();
        laststandheal_onrespawn();
    }
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x375
// Size: 0x46
function laststandheal_onrespawn()
{
    superweapon = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
    self clearoffhandspecial();
    
    if ( isdefined( superweapon ) )
    {
        scripts\cp_mp\utility\inventory_utility::_takeweapon( superweapon );
    }
    
    self.laststandheal_hassuperweapon = 0;
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x3c3
// Size: 0x14, Type: bool
function laststandheal_beginuse()
{
    thread laststandheal_think();
    thread laststandheal_setinactivewhendone();
    return true;
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x3e0
// Size: 0xc8
function laststandheal_think()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "last_stand_finished" );
    delaythread( 0.05, &laststandheal_drainsupermeter );
    self.laststandhealisactive = 1;
    self notify( "last_stand_heal_active" );
    self notify( "handle_revive_message" );
    val::set( "lastStandHeal", "allow_movement", 0 );
    wait 0.45;
    self playlocalsound( "laststand_heal_start" );
    self notify( "force_regeneration" );
    
    while ( self.health < self.maxhealth )
    {
        waitframe();
    }
    
    val::reset_all( "lastStandHeal" );
    scripts\mp\supers::superusefinished( undefined, undefined, undefined, 1 );
    self playlocalsound( "laststand_heal_done" );
    self notify( "last_stand_heal_success" );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_status_player_revived" );
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x4b0
// Size: 0x4e
function laststandheal_drainsupermeter()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "last_stand_heal_success" );
    
    while ( true )
    {
        scripts\mp\supers::reducesuperusepercent( 5, 0, 1 );
        superinfo = scripts\mp\supers::getcurrentsuper();
        
        if ( superinfo.usepercent <= 0 )
        {
            return;
        }
    }
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x506
// Size: 0x2b
function laststandheal_setinactivewhendone()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    waittill_any_return_no_endon_death_2( "death", "last_stand_finished" );
    self.laststandhealisactive = 0;
}

// Namespace laststand_heal / scripts\mp\supers\laststand_heal
// Params 0
// Checksum 0x0, Offset: 0x539
// Size: 0x4
function laststandheal_gethealthperframe()
{
    return 2;
}

