#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\armor;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_relics;
#using scripts\cp\kits;
#using scripts\cp\laststand;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\objective_trigger;
#using scripts\cp\perks;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\sonar_pulse;
#using scripts\cp_mp\killstreaks\emp_drone;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace super;

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0xaa2
// Size: 0x2c2
function init_super()
{
    if ( !isdefined( level.supertable ) )
    {
        if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.super_list ) )
        {
            level.supertable = "superlist:" + level.gametypebundle.super_list;
        }
        else if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.super_list ) )
        {
            level.supertable = "superlist:" + level.gamemodebundle.super_list;
        }
        
        assertex( isdefined( level.supertable ), "Define Super List asset for the gamemodebundle asset for this mode or override level.superTable in script" );
    }
    
    globals = spawnstruct();
    level.superglobals = globals;
    globals.staticsuperdata = [];
    globals.superweapons = [];
    globals.supersbyid = [];
    globals.supersbyoffhand = [];
    scripts\cp_mp\supers\supers::function_f0327aead8f016e2( globals );
    scripts\cp_mp\supers\supers::function_e3234be372f6209d( level.supertable );
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_recon_drone" ] ) )
    {
        level.superglobals.staticsuperdata[ "super_recon_drone" ] = spawnstruct();
        level.superglobals.staticsuperdata[ "super_recon_drone" ].id = 11;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_tac_cover" ] ) )
    {
        level.superglobals.staticsuperdata[ "super_tac_cover" ] = spawnstruct();
        level.superglobals.staticsuperdata[ "super_tac_cover" ].id = 10;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_emp_drone" ] ) )
    {
        level.superglobals.staticsuperdata[ "super_emp_drone" ] = spawnstruct();
        level.superglobals.staticsuperdata[ "super_emp_drone" ].id = 12;
    }
    
    level.superglobals.staticsuperdata[ "" ] = spawnstruct();
    level.superglobals.staticsuperdata[ "" ].id = 666;
    
    if ( issharedfuncdefined( "super_suppression_rounds", "init" ) )
    {
        [[ getsharedfunc( "super_suppression_rounds", "init" ) ]]();
    }
    
    registersupers();
    
    /#
        thread function_fc293489e21293c4();
    #/
}

/#

    // Namespace super / scripts\cp\super
    // Params 0
    // Checksum 0x0, Offset: 0xd6c
    // Size: 0x2c, Type: dev
    function function_fc293489e21293c4()
    {
        cmd = "<dev string:x1c>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x7d>";
        addentrytodevgui( cmd );
    }

#/

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0xda0
// Size: 0x2
function registersupers()
{
    
}

// Namespace super / scripts\cp\super
// Params 2
// Checksum 0x0, Offset: 0xdaa
// Size: 0x126
function give_player_super( super_choice, var_2cbc4002b1724081 )
{
    if ( !isdefined( super_choice ) )
    {
        super_choice = "role_tank";
    }
    
    if ( isdefined( self.super ) && isdefined( self.super.supername ) && super_choice == self.super.supername && !istrue( var_2cbc4002b1724081 ) )
    {
        return;
    }
    
    clear_player_class_and_super();
    function_1f8539b231e93107( super_choice );
    thread update_super_icon( super_choice );
    
    switch ( self.super.supername )
    {
        case #"hash_508fbdd5b269310c":
            thread give_team_auto_revive();
            break;
        case #"hash_875b1dd917623c0a":
            thread give_team_armor_buff();
            break;
        case #"hash_65b382df72f6ae4d":
            break;
        case #"hash_643b7aa347db7fe8":
            thread give_thermite_launcher();
            break;
        case #"hash_f3ed47e335da1748":
            thread give_scout_drone();
            break;
        case #"hash_611bc3cc30ec563f":
            thread giv_emp_drone();
            break;
    }
    
    thread init_super_for_player( "super_default_zm" );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0xed8
// Size: 0x2
function clear_player_class_and_super()
{
    
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0xee2
// Size: 0x9
function give_player_class_abilities()
{
    clear_player_class_and_super();
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0xef3
// Size: 0x3f
function update_super_icon( super )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    set_omnvar_for_icon( super );
    self setclientomnvar( "cp_loadout_changed", 0 );
    wait 2;
    self setclientomnvar( "cp_loadout_changed", 1 );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0xf3a
// Size: 0x36
function set_omnvar_for_icon( super )
{
    omnvar = int( tablelookup( "cp/cp_fieldupgrades.csv", 1, super, 0 ) );
    self setclientomnvar( "ui_field_upgrade_icon", omnvar );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0xf78
// Size: 0x25
function init_super_for_player( super )
{
    give_super_weapon( super );
    thread give_super_ammo_after_loadout_given( super );
    thread watch_for_super_button( super );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0xfa5
// Size: 0x50
function watch_for_super_ammo_depleted( super )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "end_super_watcher" );
    
    while ( true )
    {
        amt = self getammocount( super );
        
        if ( amt == 0 )
        {
            self setweaponammoclip( super, 1 );
        }
        
        wait 0.1;
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0xffd
// Size: 0x29
function function_c5ea07dac9d83685()
{
    setomnvar( "ui_class_power_ready", -1 );
    setomnvar( "ui_class_power_inuse", -1 );
    setomnvar( "ui_class_power_reloading", -1 );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x102e
// Size: 0x36
function give_super_weapon( super )
{
    self giveweapon( super );
    self assignweaponoffhandspecial( super );
    self.specialoffhandgrenade = super;
    self setweaponammoclip( super, 1 );
    function_c5ea07dac9d83685();
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x106c
// Size: 0x28
function give_super_ammo_after_loadout_given( super )
{
    self endon( "disconnect" );
    flag_wait( "player_spawned_with_loadout" );
    self setweaponammoclip( super, 1 );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x109c
// Size: 0x1ce
function watch_for_super_button( super )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "end_super_watcher" );
    self endon( "end_super_watcher" );
    self.super_ready = 0;
    thread recharge_super( super );
    thread watch_for_super_ammo_depleted( super );
    self setclientomnvar( "ui_super_progress", 0 );
    self setclientomnvar( "cp_super_ready", 0 );
    flag_wait( "player_spawned_with_loadout" );
    
    while ( true )
    {
        self waittill( "special_weapon_fired", objweapon );
        
        if ( isdefined( level.nuclear_core_carrier ) && level.nuclear_core_carrier == self )
        {
            scripts\cp\utility::hint_prompt( "super_disabled", 1, 2 );
            self setweaponammoclip( super, 1 );
            continue;
        }
        
        firedweapon = objweapon;
        
        if ( isweapon( objweapon ) )
        {
            firedweapon = getcompleteweaponname( objweapon );
        }
        
        if ( firedweapon == super )
        {
            fail = 0;
            
            if ( !self.super_ready )
            {
                fail = 1;
            }
            else if ( istrue( self.inlaststand ) )
            {
                fail = 1;
            }
            else if ( istrue( self.disable_super ) )
            {
                fail = 1;
            }
            else if ( istrue( level.regroup_process_started ) )
            {
                fail = 1;
            }
            else if ( istrue( self.interrogating ) )
            {
                fail = 1;
            }
            else if ( scripts\cp\weapon::player_has_minigun( self ) )
            {
                fail = 1;
            }
            else if ( !istrue( self isonground() ) )
            {
                fail = 1;
            }
            else if ( istrue( self.var_23a6763562820c70 ) )
            {
                fail = 1;
            }
            
            if ( isdefined( level.can_use_super_func ) && ![[ level.can_use_super_func ]]( self ) )
            {
                fail = 1;
            }
            
            if ( !fail )
            {
                thread fire_super( super );
            }
            else
            {
                scripts\cp\utility::hint_prompt( "super_disabled", 1, 2 );
            }
        }
        
        self setweaponammoclip( super, 1 );
    }
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x1272
// Size: 0xd9
function fire_super( super )
{
    self.super_ready = 0;
    self setclientomnvar( "cp_super_ready", 0 );
    self setclientomnvar( "ui_super_state", 3 );
    setsuperisinuse( 1 );
    super_ref = scripts\cp\super::getcurrentsuperref();
    
    if ( isdefined( super_ref ) )
    {
        scripts\cp\cp_analytics::logevent_superused( self, super_ref );
    }
    
    thread display_super_fired_splash();
    run_super_loop( super );
    self setclientomnvar( "ui_super_state", 4 );
    self.super_progress = 0;
    self setclientomnvar( "ui_super_progress", self.super_progress );
    setsuperisinuse( 0 );
    self setclientomnvar( "cp_super_fired", 0 );
    self.super_ready = 0;
    
    if ( istrue( level.var_5ebda93137c97b1c ) )
    {
        self.disable_super = 1;
        thread update_super_icon( "none" );
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1353
// Size: 0x1d, Type: bool
function issuperinuse()
{
    return isdefined( getcurrentsuper() ) && getcurrentsuper().isinuse;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1379
// Size: 0x2f
function getcurrentsuperref()
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return undefined;
    }
    
    return superinfo.staticdata.ref;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x13b1
// Size: 0xb
function getcurrentsuper()
{
    return self.super;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x13c5
// Size: 0x36
function setsuperisinuse( isinuse )
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    superinfo.isinuse = isinuse;
    updatesuperuistate();
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1403
// Size: 0xb5
function updatesuperuistate()
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( !isdefined( superinfo.isactive ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        superinfo.state = undefined;
        return;
    }
    
    oldstate = superinfo.state;
    state = 1;
    
    if ( issuperexpended() )
    {
        state = 4;
    }
    else if ( issuperready() )
    {
        state = 2;
    }
    else if ( issuperinuse() )
    {
        state = 3;
    }
    
    if ( !isdefined( oldstate ) || state != oldstate )
    {
        self setclientomnvar( "ui_super_state", state );
    }
    
    superinfo.state = state;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x14c0
// Size: 0x12, Type: bool
function issuperexpended()
{
    return istrue( self.pers[ "superExpended" ] );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x14db
// Size: 0x37, Type: bool
function issuperready()
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) || superinfo.isinuse )
    {
        return false;
    }
    
    return getcurrentsuperpoints() >= getsuperpointsneeded();
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x151b
// Size: 0x2a
function getcurrentsuperpoints()
{
    superinfo = getcurrentsuper();
    return superinfo.basepoints + superinfo.extrapoints;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x154e
// Size: 0x58
function getsuperpointsneeded()
{
    superinfo = getcurrentsuper();
    pointsneeded = superinfo.staticdata.pointsneeded;
    
    if ( !isdefined( pointsneeded ) )
    {
        pointsneeded = 0;
    }
    
    if ( isdefined( superinfo.overridepointsneeded ) )
    {
        pointsneeded = superinfo.overridepointsneeded;
    }
    
    return pointsneeded;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x15af
// Size: 0x51
function function_32d75c33471450d3()
{
    kitname = scripts\cp\kits::function_cab56589fd214c7e();
    
    if ( !isdefined( kitname ) )
    {
        return undefined;
    }
    
    switch ( kitname )
    {
        case #"hash_36cdfbfaeba9a21a":
            return 180;
        case #"hash_f7803221ec64d903":
            return 90;
        case #"hash_2b0e6b98c99852f2":
            return 60;
    }
    
    return undefined;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x1609
// Size: 0x260
function recharge_super( super )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "end_super_watcher" );
    self setclientomnvar( "ui_super_state", 1 );
    meter_time = function_32d75c33471450d3();
    dvar_check = getdvarint( @"hash_b0c572ab1605350a", 0 );
    
    if ( dvar_check )
    {
        meter_time = dvar_check;
    }
    
    if ( istrue( self.role_edit ) )
    {
        if ( !isdefined( self.super_progress ) )
        {
            self.super_progress = 890;
        }
        else if ( self.super_progress > 996 )
        {
            self.super_progress = 997;
        }
        
        self.role_edit = undefined;
    }
    else
    {
        self.super_progress = 890;
    }
    
    starttime = gettime();
    lasttime = starttime;
    
    while ( true )
    {
        dvar_check = getdvarint( @"hash_b0c572ab1605350a", 0 );
        
        if ( dvar_check )
        {
            meter_time = dvar_check;
        }
        else
        {
            meter_time = function_32d75c33471450d3();
        }
        
        paused = 0;
        curtime = gettime();
        
        if ( istrue( self.super_activated ) )
        {
            paused = 1;
        }
        else if ( istrue( self.inlaststand ) )
        {
            paused = 1;
        }
        else if ( istrue( self.super_ready ) )
        {
            paused = 1;
        }
        else if ( istrue( self.disable_super ) )
        {
            paused = 1;
        }
        
        if ( flag_exist( "infil_complete" ) && !flag( "infil_complete" ) )
        {
            paused = 1;
        }
        
        if ( paused )
        {
            lasttime = curtime;
            waitframe();
            continue;
        }
        
        timediff = curtime - lasttime;
        
        if ( isdefined( meter_time ) )
        {
            amount = timediff / meter_time * 1000 * 1000;
            amount *= scripts\cp\perks::get_perk( "super_fill_scalar" );
            increase_super_progress( amount );
        }
        
        progress = self.super_progress / 1000;
        
        if ( progress > 0.998 )
        {
            progress = 1;
        }
        
        self setclientomnvar( "ui_super_progress", progress );
        lasttime = curtime;
        
        if ( progress >= 1 )
        {
            self.super_ready = 1;
            self setclientomnvar( "cp_super_ready", 1 );
            self setclientomnvar( "ui_super_state", 2 );
            
            if ( self getclientomnvar( "ui_cp_bink_overlay_state" ) == 0 )
            {
                display_super_ready_splash();
            }
        }
        
        waitframe();
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1871
// Size: 0x12f
function display_super_ready_splash()
{
    if ( istrue( self.var_76fdc69357652407 ) )
    {
        return;
    }
    
    if ( !istrue( self.super_displayed ) )
    {
        self.super_displayed = 1;
        return;
    }
    
    if ( self usinggamepad() )
    {
        splash = "super_revive";
        
        switch ( self.kit_data.kit )
        {
            case #"hash_f7803221ec64d903":
                splash = "cp_super_revive";
                break;
            case #"hash_36cdfbfaeba9a21a":
                splash = "cp_super_armor";
                break;
            case #"hash_2b0e6b98c99852f2":
                splash = "cp_super_snapshot_pulse";
                break;
        }
    }
    else
    {
        splash = "cp_super_revive_kbm";
        
        switch ( self.kit_data.kit )
        {
            case #"hash_f7803221ec64d903":
                splash = "cp_super_revive_kbm";
                break;
            case #"hash_36cdfbfaeba9a21a":
                splash = "cp_super_armor_kbm";
                break;
            case #"hash_2b0e6b98c99852f2":
                splash = "cp_super_snapshot_pulse_kbm";
                break;
        }
    }
    
    function_c5ea07dac9d83685();
    clientnum = self getentitynumber();
    setomnvar( "ui_class_power_ready", clientnum );
    thread scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x19a8
// Size: 0x5b
function display_super_fired_splash()
{
    self endon( "disconnect" );
    splash = "super_revive_used";
    function_c5ea07dac9d83685();
    clientnum = self getentitynumber();
    setomnvar( "ui_class_power_inuse", clientnum );
    self setclientomnvar( "cp_super_fired", 1 );
    wait 6;
    self setclientomnvar( "cp_super_fired", 0 );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x1a0b
// Size: 0x6e
function increase_super_progress( amount )
{
    if ( !istrue( self.super_activated ) )
    {
        if ( !self.super_ready )
        {
            if ( isdefined( self.super_progress_scalar ) )
            {
                amount *= self.super_progress_scalar;
            }
            
            self.super_progress += amount;
            
            if ( self.super_progress > 1000 )
            {
                self.super_progress = 1000;
            }
        }
    }
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x1a81
// Size: 0x143
function drain_super_meter( time )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "end_super_meter_early" );
    thread set_progress_to_zero_on_death();
    self.super_meter_draining = 1;
    clientnum = self getentitynumber();
    starttime = gettime();
    lasttime = starttime;
    var_b28845cfb5a6978b = 1;
    
    while ( true )
    {
        curtime = gettime();
        timediff = curtime - lasttime;
        amount = timediff / time * 1000;
        var_b28845cfb5a6978b -= amount;
        
        if ( var_b28845cfb5a6978b < 0 )
        {
            var_b28845cfb5a6978b = 0;
        }
        
        self setclientomnvar( "ui_super_progress", var_b28845cfb5a6978b );
        lasttime = curtime;
        waitframe();
        
        if ( var_b28845cfb5a6978b <= 0 )
        {
            self.super_progress = 0;
            self notify( "meter_drained" );
            break;
        }
    }
    
    kit_name = scripts\cp\kits::function_cab56589fd214c7e();
    function_c5ea07dac9d83685();
    
    switch ( kit_name )
    {
        case #"hash_2b0e6b98c99852f2":
        case #"hash_36cdfbfaeba9a21a":
        case #"hash_f7803221ec64d903":
            setomnvar( "ui_class_power_reloading", clientnum );
            break;
    }
    
    self.super_meter_draining = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1bcc
// Size: 0x3d
function set_progress_to_zero_on_death()
{
    self endon( "meter_drained" );
    self waittill( "death" );
    self.super_progress = 0;
    self setclientomnvar( "ui_super_progress", self.super_progress );
    self setclientomnvar( "cp_super_fired", 0 );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1c11
// Size: 0x33
function end_super_meter_progress_early()
{
    self notify( "end_super_meter_early" );
    self.super_progress = 0;
    self setclientomnvar( "ui_super_progress", self.super_progress );
    self.super_meter_draining = 0;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x1c4c
// Size: 0x3b
function run_super_loop( super )
{
    if ( isdefined( self.super_activate_func ) )
    {
        self [[ self.super_activate_func ]]();
    }
    
    while ( istrue( self.super_activated ) )
    {
        wait 0.1;
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1c8f
// Size: 0xe
function give_scout_drone()
{
    function_674934b4db05639a( &activate_scout_drone );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1ca5
// Size: 0x1c
function give_team_armor_buff()
{
    function_674934b4db05639a( &activate_team_armor_buff );
    self.super_progress_scalar = 0.25;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1cc9
// Size: 0x1c
function give_thermite_launcher()
{
    function_674934b4db05639a( &activate_thermite_launcher );
    self.super_progress_scalar = 0.5;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1ced
// Size: 0x1c
function give_team_auto_revive()
{
    function_674934b4db05639a( &activate_team_auto_revive );
    self.super_progress_scalar = 0.25;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1d11
// Size: 0xe
function give_team_stopping_power()
{
    function_674934b4db05639a( &activate_team_stopping_power );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1d27
// Size: 0x2e
function giv_emp_drone()
{
    if ( isdefined( level.activate_emp_drone_func ) )
    {
        function_674934b4db05639a( level.activate_emp_drone_func );
        return;
    }
    
    function_674934b4db05639a( &activate_emp_drone );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1d5d
// Size: 0x141
function activate_thermite_launcher()
{
    self.super_activated = 1;
    self.gl_proj_override = "thermite";
    
    if ( scripts\cp\weapon::player_has_minigun( self ) )
    {
        scripts\cp\weapon::drop_minigun( self );
        self waittill( "weapon_change" );
        
        if ( istrue( self.inlaststand ) )
        {
            self.super_activated = 0;
            return;
        }
    }
    
    scripts\cp\munitions::givegrenadelauncher();
    thread drain_super_meter( 1 );
    scripts\cp\cp_analytics::logevent_superused( self, "thermite_launcher" );
    self setclientomnvar( "ui_thermite_class_power_on", gettime() );
    clientnum = self getentitynumber();
    splash = "cp_super_cluster_used";
    
    foreach ( player in level.players )
    {
        player scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
    }
    
    while ( istrue( self.has_gl ) )
    {
        self waittill( "weapon_removed" );
    }
    
    function_c5ea07dac9d83685();
    setomnvar( "ui_class_power_reloading", clientnum );
    self setclientomnvar( "ui_thermite_class_power_off", gettime() );
    self.gl_proj_override = undefined;
    self.super_activated = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1ea6
// Size: 0x74
function team_unlimited_ammo()
{
    foreach ( player in level.players )
    {
        player.has_infinite_ammo = 1;
        ammo = ammo_round_up();
        player thread unlimited_ammo( ammo );
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x1f22
// Size: 0x11d
function activate_scout_drone()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.super_activated = 1;
    self.var_2332678633fe1728 = 1;
    thread listen_for_drone_ent();
    success = scripts\cp_mp\killstreaks\recon_drone::recondrone_beginsuper();
    
    if ( success )
    {
        msg = waittill_any_return_3( "super_use_succeeded", "super_use_failed", "laststand" );
        
        if ( msg == "super_use_succeeded" )
        {
            splash = "cp_super_mark_used";
            
            foreach ( player in level.players )
            {
                player scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
            }
            
            scripts\cp\cp_analytics::logevent_superused( self, "scout drone" );
            thread drain_super_meter( 1 );
            wait_until_done();
        }
        else
        {
            self.super_activated = 0;
            self.var_2332678633fe1728 = 0;
        }
        
        return;
    }
    
    self.super_activated = 0;
    self.var_2332678633fe1728 = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2047
// Size: 0x3b
function listen_for_drone_ent()
{
    self endon( "death_or_disconnect" );
    self waittill( "killstreak_vehicle_made", drone );
    scripts\cp\objective_trigger::function_b0637efa07ab9df9( drone, "killstreak" );
    self.scout_drone = drone;
    self setplayerusingdrone( drone );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x208a
// Size: 0x5c
function wait_until_done()
{
    clientnum = self getentitynumber();
    thread waittill_drone_timeout( 5 );
    waittill_drone_defined();
    
    while ( isdefined( self.scout_drone ) )
    {
        waitframe();
    }
    
    function_c5ea07dac9d83685();
    setomnvar( "ui_class_power_reloading", clientnum );
    self.super_activated = 0;
    self.var_2332678633fe1728 = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x20ee
// Size: 0x27
function waittill_drone_defined()
{
    self endon( "scout_drone_timeout" );
    
    while ( !isdefined( self.scout_drone ) )
    {
        wait 0.1;
    }
    
    self notify( "scout_drone_timeout" );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x211d
// Size: 0x1c
function waittill_drone_timeout( timer )
{
    self endon( "scout_drone_timeout" );
    wait timer;
    self notify( "scout_drone_timeout" );
}

// Namespace super / scripts\cp\super
// Params 4
// Checksum 0x0, Offset: 0x2141
// Size: 0x4b
function superusefinished( var_3179afaa208defa2, fromdeath, var_e68637fb8c1c346b, var_e743a22765d93795 )
{
    self notify( "super_use_finished_lb" );
    
    if ( istrue( var_3179afaa208defa2 ) )
    {
        self notify( "super_use_failed" );
    }
    else
    {
        self notify( "super_use_succeeded" );
    }
    
    self notify( "super_use_finished" );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2194
// Size: 0x76
function ammo_round_up()
{
    self endon( "death" );
    self endon( "disconnect" );
    ammo = [];
    
    foreach ( weapon in self.weaponlist )
    {
        ammo[ getcompleteweaponname( weapon ) ] = self getammocount( weapon );
    }
    
    return ammo;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x2213
// Size: 0x157
function unlimited_ammo( ammo )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "stop_unlimited_ammo" );
    
    if ( !isdefined( self.weaponlist ) )
    {
        self.weaponlist = self getweaponslistprimaries();
    }
    
    scripts\cp\utility::enable_infinite_ammo( 1 );
    
    while ( istrue( self.has_infinite_ammo ) )
    {
        var_76d0240ac996ca7b = 0;
        
        foreach ( index in self.weaponlist )
        {
            clip_size = weaponclipsize( index );
            
            if ( index == self getcurrentweapon() && weapon_no_unlimited_check( index ) )
            {
                var_76d0240ac996ca7b = 1;
                
                if ( clip_size == 1 )
                {
                    new_stock = self getweaponammostock( index );
                    new_stock++;
                    self setweaponammostock( index, new_stock );
                }
                else
                {
                    self setweaponammoclip( index, weaponclipsize( index ), "left" );
                }
            }
            
            if ( index == self getcurrentweapon() && weapon_no_unlimited_check( index ) )
            {
                var_76d0240ac996ca7b = 1;
                self setweaponammoclip( index, weaponclipsize( index ), "right" );
            }
            
            if ( var_76d0240ac996ca7b == 0 )
            {
                ammo_round_up();
            }
        }
        
        wait 0.05;
    }
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x2372
// Size: 0x91
function weapon_no_unlimited_check( weapon )
{
    assert( isweapon( weapon ) );
    var_76d0240ac996ca7b = 1;
    
    if ( isdefined( level.opweaponsarray ) )
    {
        foreach ( opweapon in level.opweaponsarray )
        {
            if ( weapon.basename == opweapon )
            {
                var_76d0240ac996ca7b = 0;
            }
        }
    }
    
    return var_76d0240ac996ca7b;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x240c
// Size: 0x112
function activate_team_auto_revive( amount )
{
    level endon( "disconnect" );
    level endon( "game_ended" );
    self.super_activated = 1;
    splash = "cp_super_revive_used";
    var_c98f63203dea02cf = 0;
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( scripts\cp\laststand::player_in_laststand( player ) )
        {
            if ( isdefined( player.last_stand_state ) && player.last_stand_state == "bleed_out" )
            {
                continue;
            }
            
            player thread team_instant_revive();
            player scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
            scripts\cp\laststand::record_revive_success( self, player );
            var_c98f63203dea02cf = 1;
        }
    }
    
    if ( var_c98f63203dea02cf )
    {
        scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
        scripts\cp\cp_analytics::logevent_superused( self, "team auto-revive" );
        drain_super_meter( 1 );
    }
    
    self.super_activated = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2526
// Size: 0x71
function team_instant_revive()
{
    if ( scripts\cp\laststand::player_in_laststand( self ) )
    {
        if ( !isdefined( self.dogtag ) )
        {
            self.using_self_revive = 1;
            self giveandfireoffhand( "adrenaline_mp" );
            
            if ( isdefined( self.reviveiconent ) )
            {
                scripts\cp\laststand::set_revive_icon_color( self.reviveiconent );
                self.reviveent makeunusable();
            }
            
            wait 3;
            scripts\cp\laststand::instant_revive( self );
            self.using_self_revive = undefined;
        }
    }
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x259f
// Size: 0x5b
function deactivate_instant_revive( amount )
{
    level endon( "disconnect" );
    level endon( "game_ended" );
    result = waittill_any_timeout_1( amount, "force_end_super" );
    self notify( "stop_instant_revive" );
    self.has_instant_revive = undefined;
    self.perk_data[ "revive_time_scalar" ] = self.old_revive_time_scalar;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x2602
// Size: 0xf8
function aoe_instant_revive( timer )
{
    self endon( "stop_instant_revive" );
    self endon( "death" );
    dist = 100;
    dist_sq = dist * dist;
    end_time = gettime() + timer * 1000;
    
    while ( gettime() < end_time )
    {
        foreach ( player in level.players )
        {
            if ( scripts\cp\laststand::player_in_laststand( player ) )
            {
                if ( distancesquared( self.origin, player.origin ) < dist_sq )
                {
                    player scripts\cp\laststand::instant_revive( player );
                    
                    if ( isdefined( player.dogtag ) )
                    {
                        player.dogtag delete();
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2702
// Size: 0x4c
function activate_team_armor_buff()
{
    level endon( "disconnect" );
    level endon( "game_ended" );
    self.super_activated = 1;
    turn_on_team_armor_buff();
    scripts\cp\cp_analytics::logevent_superused( self, "team armor" );
    thread deactivate_team_armor_buff( 20 );
    drain_super_meter( 1 );
    self.super_activated = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2756
// Size: 0x106
function turn_on_team_armor_buff()
{
    full_armor = 100;
    armor_dvar = getdvarint( @"hash_e6924e7c0a5aad1f", 0 );
    
    if ( armor_dvar )
    {
        full_armor = armor_dvar;
    }
    
    splash = "cp_super_armor_used";
    
    foreach ( player in level.players )
    {
        if ( on_the_same_team( self, player ) && isalive( player ) )
        {
            player.has_team_armor = 1;
            scripts\cp\armor::givearmor( player, full_armor, 1 );
            player.old_armor_scalar = player scripts\cp\perks::get_perk( "enemy_damage_to_player_armor_scalar" );
            player scripts\cp\perks::set_perk( "enemy_damage_to_player_armor_scalar", player.old_armor_scalar * 1.5 );
            player scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
        }
        
        player setclientomnvar( "ui_armor_class_power_used", 1 );
    }
}

// Namespace super / scripts\cp\super
// Params 2
// Checksum 0x0, Offset: 0x2864
// Size: 0x50
function on_the_same_team( player_one, player_two )
{
    if ( isdefined( player_one.team_number ) && isdefined( player_two.team_number ) )
    {
        return ( player_one.team_number == player_two.team_number );
    }
    
    return 1;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x28bc
// Size: 0x79
function remove_team_armor_buff()
{
    foreach ( player in level.players )
    {
        if ( on_the_same_team( self, player ) )
        {
            player.has_team_armor = undefined;
            player scripts\cp\perks::set_perk( "enemy_damage_to_player_armor_scalar", player.old_armor_scalar );
        }
    }
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x293d
// Size: 0xb1
function deactivate_team_armor_buff( amount )
{
    level endon( "disconnect" );
    level endon( "game_ended" );
    clientnum = self getentitynumber();
    result = waittill_any_timeout_1( amount, "force_end_super" );
    function_c5ea07dac9d83685();
    setomnvar( "ui_class_power_reloading", clientnum );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_armor_class_power_used", 0 );
    }
    
    remove_team_armor_buff();
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x29f6
// Size: 0xf8
function activate_team_stopping_power()
{
    level endon( "disconnect" );
    level endon( "game_ended" );
    self.super_activated = 1;
    scripts\cp\cp_analytics::logevent_superused( self, "team stopping_power" );
    splash = "cp_super_ammo_used";
    
    foreach ( player in level.players )
    {
        player give_full_stoppingpower_clip();
        player scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
    }
    
    drain_super_meter( 1 );
    
    foreach ( player in level.players )
    {
        self setclientomnvar( "ui_ammo_class_power_on", gettime() );
    }
    
    self.super_activated = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2af6
// Size: 0x37
function give_full_stoppingpower_clip()
{
    weapon = scripts\cp\utility::getvalidtakeweapon();
    maxclipammo = weaponclipsize( weapon );
    self setweaponammoclip( weapon, maxclipammo );
    thread watch_bullet_count( weapon, maxclipammo );
}

// Namespace super / scripts\cp\super
// Params 2
// Checksum 0x0, Offset: 0x2b35
// Size: 0x49
function watch_bullet_count( weapon, maxclipammo )
{
    self endon( "disconnect" );
    thread remove_on_death();
    thread stoppingpower_watchhcrweaponchange( weapon );
    thread stoppingpower_watchhcrweaponfire( weapon, maxclipammo );
    self waittill( "stoppingPower_removeHCR" );
    takeperk( "specialty_bulletdamage" );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2b86
// Size: 0x16
function remove_on_death()
{
    self waittill( "death" );
    takeperk( "specialty_bulletdamage" );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x2ba4
// Size: 0xf4
function stoppingpower_watchhcrweaponchange( weapon )
{
    self endon( "stoppingPower_removeHCR" );
    self endon( "disconnect" );
    self endon( "stoppingPower_clearHCR" );
    self.gavehcr = 0;
    
    while ( self hasweapon( weapon ) )
    {
        if ( self getcurrentweapon() == weapon )
        {
            if ( !self.gavehcr )
            {
                giveperk( "specialty_bulletdamage" );
                self.gavehcr = 1;
            }
        }
        else if ( self.gavehcr )
        {
            takeperk( "specialty_bulletdamage" );
            self.gavehcr = 0;
        }
        
        self waittill( "weapon_change" );
    }
    
    foreach ( player in level.players )
    {
        self setclientomnvar( "ui_ammo_class_power_off", gettime() );
    }
    
    self notify( "stoppingPower_removeHCR" );
}

// Namespace super / scripts\cp\super
// Params 2
// Checksum 0x0, Offset: 0x2ca0
// Size: 0xdf
function stoppingpower_watchhcrweaponfire( weapon, amount )
{
    self endon( "stoppingPower_removeHCR" );
    self endon( "disconnect" );
    self endon( "stoppingPower_clearHCR" );
    self.rounds = amount;
    thread stoppingpower_watchhcrammodrain( weapon, amount );
    
    while ( self hasweapon( weapon ) )
    {
        self waittill( "weapon_fired", objweapon );
        
        if ( objweapon == weapon )
        {
            self.rounds--;
            
            if ( self.rounds <= 0 )
            {
                break;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        self setclientomnvar( "ui_ammo_class_power_off", gettime() );
    }
    
    self notify( "stoppingPower_removeHCR" );
}

// Namespace super / scripts\cp\super
// Params 2
// Checksum 0x0, Offset: 0x2d87
// Size: 0xc4
function stoppingpower_watchhcrammodrain( weapon, amount )
{
    self endon( "stoppingPower_removeHCR" );
    self endon( "disconnect" );
    self endon( "stoppingPower_clearHCR" );
    self.rounds = amount;
    
    while ( self hasweapon( weapon ) )
    {
        self waittill( "ammo_drained" );
        self.rounds--;
        
        if ( self.rounds <= 0 )
        {
            break;
        }
    }
    
    foreach ( player in level.players )
    {
        self setclientomnvar( "ui_ammo_class_power_off", gettime() );
    }
    
    self notify( "stoppingPower_removeHCR" );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2e53
// Size: 0x37
function allowsuperweaponstow()
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) || !superinfo.isinuse )
    {
        return;
    }
    
    superinfo.canstow = 1;
}

// Namespace super / scripts\cp\super
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e92
// Size: 0x78
function private function_9105217782a39139( superinfo )
{
    maxclipammo = weaponmaxammo( superinfo.staticdata.useweapon );
    ammopool = 0;
    ammopool += superinfo.staticdata.useweaponclipammo;
    ammopool += min( maxclipammo, superinfo.staticdata.useweaponstockammo );
    return 1 / ammopool;
}

// Namespace super / scripts\cp\super
// Params 3
// Checksum 0x0, Offset: 0x2f13
// Size: 0x8e
function reducesuperusepercent( percentoff, var_1e71e1f458960b93, var_80bd4dd71b59356b )
{
    superinfo = getcurrentsuper();
    assertex( superinfo.isinuse, "reduceSuperUsePercent() called while the super is not in use." );
    superinfo.usepercent = max( superinfo.usepercent - percentoff, 0 );
    
    if ( istrue( var_1e71e1f458960b93 ) )
    {
        superinfo.allowrefund = 0;
    }
    
    if ( !isdefined( var_80bd4dd71b59356b ) || var_80bd4dd71b59356b == 0 )
    {
        superusedurationupdated();
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2fa9
// Size: 0x2e
function superusedurationupdated()
{
    superinfo = getcurrentsuper();
    
    if ( superinfo.usepercent <= 0 )
    {
        superusefinished();
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2fdf
// Size: 0x12
function getcurrentsuperbasepoints()
{
    return getcurrentsuper().basepoints;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x2ffa
// Size: 0xce
function updatesuperuiprogress()
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( scripts\cp\utility\player::isinkillcam() || !isalive( self ) )
    {
        superinfo.oldprogress = undefined;
        return;
    }
    
    progress = 0;
    
    if ( superinfo.isinuse )
    {
        progress = getsuperuseuiprogress();
    }
    else
    {
        pointsneeded = getsuperpointsneeded();
        progress = clamp( getcurrentsuperbasepoints() / pointsneeded, 0, 1 );
    }
    
    if ( !isdefined( superinfo.oldprogress ) || progress != superinfo.oldprogress )
    {
        self setclientomnvar( "ui_super_progress", progress );
    }
    
    self setplayersupermeterprogress( progress );
    superinfo.oldprogress = progress;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x30d0
// Size: 0x51
function getsuperuseuiprogress()
{
    superinfo = getcurrentsuper();
    assertex( superinfo.isinuse, "getSuperUseProgress() called when super is not in use." );
    
    /#
        print( superinfo.usepercent + "<dev string:xe2>" );
    #/
    
    return superinfo.usepercent;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x312a
// Size: 0xfc
function function_c4c44e009d4f4c6b()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "super_use_finished" );
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo.staticdata.useweapon ) || superinfo.staticdata.useweaponclipammo < 1 )
    {
        return;
    }
    
    if ( istrue( superinfo.staticdata.var_ff2e3a3658646a3f ) )
    {
        allowsuperweaponstow();
    }
    
    var_569d925e5a25df1 = function_9105217782a39139( superinfo );
    reducesuperusepercent( 0.001 );
    updatesuperuiprogress();
    updatesuperuistate();
    
    while ( true )
    {
        self waittill( "weapon_fired", objweapon );
        
        if ( issameweapon( objweapon, superinfo.staticdata.useweapon, 1 ) )
        {
            reducesuperusepercent( var_569d925e5a25df1 );
            updatesuperuiprogress();
            updatesuperuistate();
        }
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x322e
// Size: 0x10d
function function_15fe9c03174d698d()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "super_use_finished" );
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo.staticdata.usetime ) )
    {
        return;
    }
    
    while ( true )
    {
        waitframe();
        success = 0;
        
        if ( !function_c3479770ffec05e2() && issuperinuse() && !isbot( self ) )
        {
            if ( is_player_gamepad_enabled() )
            {
                self notifyonplayercommand( "tacButtonPress", "+smoke" );
                self notifyonplayercommand( "fragButtonPress", "+frag" );
                thread function_8d6d95114b2c9b0d( [ "tacButtonPress", "fragButtonPress" ], [], 0.75 );
                self waittill( "controllerSuperPress", msg );
                
                if ( msg == "success" )
                {
                    success = 1;
                }
            }
            else
            {
                self notifyonplayercommand( "specialRepeat", "+special" );
                self waittill( "specialRepeat" );
                success = 1;
            }
            
            if ( success )
            {
                function_ada5045140ee0fdf();
            }
        }
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3343
// Size: 0x6a
function function_ada5045140ee0fdf()
{
    if ( !isalive( self ) )
    {
        return 0;
    }
    
    if ( !val::get( "supers" ) )
    {
        return 0;
    }
    
    if ( isusingremote() )
    {
        return 0;
    }
    
    superinfo = getcurrentsuper();
    
    if ( isdefined( superinfo.staticdata.var_e0af69536a727f03 ) )
    {
        [[ superinfo.staticdata.var_e0af69536a727f03 ]]();
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x33b5
// Size: 0x63
function switchandtakesuperuseweapon()
{
    self endon( "death" );
    superinfo = getcurrentsuper();
    useweapon = superinfo.staticdata.useweapon;
    
    if ( !isdefined( useweapon ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( useweapon ) )
    {
        scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( useweapon );
        return;
    }
    
    self notify( "super_switched" );
    scripts\cp_mp\utility\inventory_utility::getridofweapon( useweapon );
}

// Namespace super / scripts\cp\super
// Params 3
// Checksum 0x0, Offset: 0x3420
// Size: 0x6d, Type: bool
function trygiveuseweapon( useweapon, clipammo, stockammo )
{
    self endon( "death_or_disconnect" );
    _giveweapon( useweapon );
    self setweaponammoclip( useweapon, clipammo );
    self setweaponammostock( useweapon, stockammo );
    switchresult = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( useweapon, isbot( self ) );
    
    if ( switchresult )
    {
        thread function_573f49bb5d5a86ea( useweapon );
        return true;
    }
    
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( useweapon );
    return false;
}

// Namespace super / scripts\cp\super
// Params 2
// Checksum 0x0, Offset: 0x3496
// Size: 0x52
function function_ff3b77706565dacf( useweapon, newweapon )
{
    if ( !issameweapon( useweapon, newweapon, 1 ) && newweapon.basename != "iw9_knifestab_mp" && newweapon.basename != "iw9_lm_dblmg_execution_mp" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x34f0
// Size: 0x160
function function_573f49bb5d5a86ea( useweapon )
{
    self endon( "death_or_disconnect" );
    self endon( "super_use_finished" );
    self waittill( "weapon_change", useweapon );
    
    while ( true )
    {
        self waittill( "weapon_change", newweapon );
        weapon = self getcurrentweapon();
        
        if ( function_ff3b77706565dacf( useweapon, newweapon ) )
        {
            clipammo = self getweaponammoclip( useweapon );
            stockammo = self getweaponammostock( useweapon );
            scripts\cp_mp\utility\inventory_utility::_takeweapon( useweapon );
            setsuperisactive( 0 );
            
            if ( is_player_gamepad_enabled() )
            {
                self notifyonplayercommand( "tacButtonPress", "+smoke" );
                self notifyonplayercommand( "fragButtonPress", "+frag" );
                thread function_8d6d95114b2c9b0d( [ "tacButtonPress" ], [ "fragButtonPress" ], 0.75 );
                self waittill( "controllerSuperPress", msg );
                
                if ( msg == "success" )
                {
                    success = 1;
                }
            }
            else
            {
                self notifyonplayercommand( "useWeaponActivated", "+special" );
                self waittill( "useWeaponActivated" );
            }
            
            setsuperisactive( 1 );
            _giveweapon( useweapon );
            self setweaponammoclip( useweapon, clipammo );
            self setweaponammostock( useweapon, stockammo );
            
            if ( !istrue( self.var_4b6e638cb12a3e90 ) )
            {
                scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( useweapon );
            }
        }
    }
}

// Namespace super / scripts\cp\super
// Params 3
// Checksum 0x0, Offset: 0x3658
// Size: 0x185
function function_8d6d95114b2c9b0d( var_cf95e74ffd3666c0, var_ad02f85b88a0b345, time )
{
    level endon( "game_ended" );
    ent = spawnstruct();
    ent.threads = 0;
    
    foreach ( endonnotify in var_ad02f85b88a0b345 )
    {
        self endon( endonnotify );
    }
    
    foreach ( stringnotify in var_cf95e74ffd3666c0 )
    {
        childthread waittill_string_no_endon_death( stringnotify, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        if ( ent.threads == 1 )
        {
            if ( isdefined( time ) )
            {
                ent childthread timeout_struct( time );
                ent waittill( "returned", msg );
                
                if ( msg == "timeout" )
                {
                    self notify( "controllerSuperPress", "timeout" );
                }
                else
                {
                    self notify( "controllerSuperPress", "success" );
                }
                
                ent.threads--;
            }
            
            continue;
        }
        
        ent waittill( "returned", message );
        ent.threads--;
    }
    
    ent notify( "die" );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x37e5
// Size: 0x1d, Type: bool
function function_c3479770ffec05e2()
{
    return isdefined( getcurrentsuper() ) && getcurrentsuper().isactive;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x380b
// Size: 0x2f
function setsuperisactive( isactive )
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    superinfo.isactive = isactive;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3842
// Size: 0x143
function function_832d0277ebcade25()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "last_stand" );
    self.super_activated = 1;
    thread scripts\cp_mp\equipment\sonar_pulse::function_12248061aabb5b60();
    objweapon = makeweapon( "sonar_pulse_mp" );
    
    if ( !istrue( scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable( objweapon ) ) )
    {
        self.super_activated = 0;
        scripts\cp\super::function_c5ea07dac9d83685();
        clientnum = self getentitynumber();
        setomnvar( "ui_class_power_reloading", clientnum );
        delay_amount = 0.2;
        thread scripts\cp\munitions::function_8f741e1e8e870100( delay_amount, 915 );
        scripts\cp\super::superusefinished();
        scripts\cp\super::setsuperisinuse( 0 );
        return undefined;
    }
    
    msg = waittill_any_return_4( "portable_radar_thrown", "offhand_end", "weapon_change", "offhand_pullback" );
    self.super_activated = 0;
    function_c5ea07dac9d83685();
    clientnum = self getentitynumber();
    setomnvar( "ui_class_power_reloading", clientnum );
    
    if ( msg == "offhand_pullback" || msg == "weapon_change" )
    {
        delay_amount = 0.2;
        thread scripts\cp\munitions::function_8f741e1e8e870100( delay_amount, 915 );
        superusefinished();
        return undefined;
    }
    
    scripts\cp\super::end_super_meter_progress_early();
    scripts\cp\super::setsuperisinuse( 0 );
    scripts\cp_mp\talking_gun::function_55b08d6d71b41402( self, "equipment_deployed" );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x398d
// Size: 0x53
function activate_emp_drone()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.super_activated = 1;
    thread listen_for_emp_drone_ent();
    success = scripts\cp_mp\killstreaks\emp_drone::empdrone_beginsuper();
    
    if ( success )
    {
        emp_drone_success_use();
        wait_until_emp_drone_done();
        return;
    }
    
    self.super_activated = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x39e8
// Size: 0x7d
function emp_drone_success_use()
{
    splash = "cp_super_sentry_used";
    
    foreach ( player in level.players )
    {
        player scripts\cp\cp_hud_message::showsplash( splash, undefined, self );
    }
    
    scripts\cp\cp_analytics::logevent_superused( self, "emp drone" );
    thread drain_super_meter( 1 );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3a6d
// Size: 0x40
function listen_for_emp_drone_ent()
{
    self endon( "death_or_disconnect" );
    self waittill( "killstreak_vehicle_made", drone );
    self.emp_drone = drone;
    self setplayerusingdrone( drone );
    drone thread emp_drone_proximity_explode();
    drone thread check_for_vehicle_in_front();
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3ab5
// Size: 0x33
function wait_until_emp_drone_done()
{
    thread waittill_scout_drone_timeout( 5 );
    waittill_scout_drone_defined();
    
    while ( isdefined( self.emp_drone ) )
    {
        wait 0.1;
    }
    
    self.super_activated = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3af0
// Size: 0x27
function waittill_scout_drone_defined()
{
    self endon( "emp_drone_timeout" );
    
    while ( !isdefined( self.emp_drone ) )
    {
        wait 0.1;
    }
    
    self notify( "emp_drone_timeout" );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x3b1f
// Size: 0x1c
function waittill_scout_drone_timeout( timer )
{
    self endon( "emp_drone_timeout" );
    wait timer;
    self notify( "emp_drone_timeout" );
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3b43
// Size: 0xea
function emp_drone_proximity_explode()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "emp_drone_exited" );
    self.owner endon( "disconnect" );
    
    while ( true )
    {
        vehicles = get_axis_vehicles();
        
        foreach ( vehicle in vehicles )
        {
            if ( isdefined( vehicle ) )
            {
                if ( vehicle == self )
                {
                    continue;
                }
                
                if ( isdefined( vehicle.chopper ) )
                {
                    continue;
                }
                
                if ( isdefined( vehicle ) && vehicle scripts\cp_mp\emp_debuff::can_be_empd() )
                {
                    distsqr = distancesquared( self.origin, vehicle.origin );
                    
                    if ( distsqr > 250000 )
                    {
                        continue;
                    }
                    
                    proximity_explode();
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3c35
// Size: 0x18b
function get_axis_vehicles()
{
    vehicles = getvehiclearray();
    new_list = [];
    
    foreach ( vehicle in vehicles )
    {
        if ( isdefined( vehicle.team ) && vehicle.team == "axis" )
        {
            new_list[ new_list.size ] = vehicle;
        }
    }
    
    turrets = getentarray( "misc_turret", "classname" );
    
    foreach ( turret in turrets )
    {
        if ( isdefined( turret.team ) && turret.team == "axis" )
        {
            new_list[ new_list.size ] = turret;
        }
    }
    
    foreach ( guy in level.spawned_enemies )
    {
        if ( istrue( isdefined( guy.unittype ) && guy.unittype == "suicidebomber" ) )
        {
            new_list[ new_list.size ] = guy;
        }
    }
    
    return new_list;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3dc9
// Size: 0x123
function proximity_explode()
{
    self.owner notify( "emp_drone_detonate" );
    weapon = "emp_drone_player_mp";
    vehicles = get_axis_vehicles();
    
    foreach ( vehicle in vehicles )
    {
        if ( !isdefined( vehicle ) )
        {
            continue;
        }
        
        if ( isdefined( vehicle.vehiclename ) && isdefined( level.vehicle.instances[ vehicle.vehiclename ] ) )
        {
            if ( isdefined( level.vehicle.instances[ vehicle.vehiclename ][ vehicle getentitynumber() ] ) )
            {
            }
            else
            {
                vehicle dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon );
            }
            
            continue;
        }
        
        vehicle dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon );
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x3ef4
// Size: 0x12b
function check_for_vehicle_in_front()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "emp_drone_exited" );
    self.owner endon( "disconnect" );
    dist = 500;
    
    while ( true )
    {
        start = self.origin;
        fwd = anglestoforward( self.angles );
        fwd = vectornormalize( fwd );
        offset_left = rotatevector( ( 0, 30, 0 ), self.angles );
        start_left = start + offset_left;
        offset_right = rotatevector( ( 0, -30, 0 ), self.angles );
        start_right = start + offset_right;
        vehicles = get_axis_vehicles();
        check_for_vehicle_trace( start, start + fwd * dist, vehicles, "fwd" );
        check_for_vehicle_trace( start_left, start_left + fwd * dist, vehicles, "left" );
        check_for_vehicle_trace( start_right, start_right + fwd * dist, vehicles, "right" );
        waitframe();
    }
}

// Namespace super / scripts\cp\super
// Params 4
// Checksum 0x0, Offset: 0x4027
// Size: 0x98
function check_for_vehicle_trace( start, end, vehicles, type )
{
    trace = scripts\engine\trace::ray_trace( start, end, self );
    
    if ( isdefined( trace ) )
    {
        if ( trace[ "fraction" ] == 1 )
        {
            return;
        }
        
        if ( isdefined( trace[ "entity" ] ) )
        {
            if ( array_contains( vehicles, trace[ "entity" ] ) )
            {
                proximity_explode();
                return;
            }
        }
        
        if ( trace[ "fraction" ] < 0.2 )
        {
            if ( type != "fwd" )
            {
                wait 0.25;
            }
            
            proximity_explode();
            return;
        }
    }
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x40c7
// Size: 0x132
function function_1f8539b231e93107( superref )
{
    staticdata = spawnstruct();
    staticdata.ref = superref;
    staticdata.superref = superref;
    superinfo = spawnstruct();
    superinfo.isinuse = 0;
    superinfo.staticdata = staticdata;
    superinfo.isactive = 0;
    superinfo.staticdata.graceperiod = 0;
    superinfo.allowrefund = 1;
    superinfo.numkills = 0;
    superinfo.wasrefunded = 0;
    superinfo.canstow = 0;
    superinfo.basepoints = 0;
    superinfo.extrapoints = 0;
    superinfo.usestarttime = undefined;
    superinfo.staticdata.usetime = undefined;
    superinfo.usepercent = 0;
    superinfo.overridepointsneeded = undefined;
    superinfo.supername = superref;
    self.super = superinfo;
    self setclientomnvar( "ui_super_ref", superref );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x4201
// Size: 0x6e
function function_7c67c8e12db38300( seconds )
{
    superinfo = getcurrentsuper();
    maxseconds = superinfo.staticdata.usetime;
    
    if ( !isdefined( seconds ) )
    {
        return 0;
    }
    
    if ( seconds <= 0 )
    {
        return 0;
    }
    
    if ( seconds > maxseconds )
    {
        seconds = maxseconds;
    }
    
    percentage = seconds / maxseconds;
    function_a2a1403d5924109( percentage );
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x4277
// Size: 0x51
function function_a2a1403d5924109( percentage )
{
    superinfo = getcurrentsuper();
    var_b4588f310900dba5 = superinfo.usepercent + percentage;
    superinfo.usepercent = clamp( var_b4588f310900dba5, 0, 1 );
    return var_b4588f310900dba5;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x42d1
// Size: 0x15
function function_674934b4db05639a( func )
{
    self.super_activate_func = func;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x42ee
// Size: 0x89
function unstowsuperweapon()
{
    superinfo = getcurrentsuper();
    
    if ( !isdefined( superinfo ) || !superinfo.canstow )
    {
        return;
    }
    
    if ( !superinfo.isinuse || !isdefined( superinfo.staticdata.useweapon ) )
    {
        superinfo.canstow = 0;
        return;
    }
    
    scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( superinfo.staticdata.useweapon );
    superinfo.canstow = 0;
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x437f
// Size: 0xa1
function function_6b384ba557a25934()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( istrue( self.var_f6fe24c104c96355 ) )
    {
        return;
    }
    
    self.var_f6fe24c104c96355 = 1;
    delay = 45;
    
    while ( true )
    {
        wait 0.25;
        
        if ( scripts\cp\laststand::player_in_laststand( self ) || !scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        empty_slot = scripts\cp\loot_system::get_empty_munition_slot( self );
        
        if ( !isdefined( empty_slot ) )
        {
            continue;
        }
        
        scripts\cp\loot_system::give_munition( "brloot_munition_grenade_launcher", self );
        function_ea6d72b04228d21();
        
        if ( delay >= 10 )
        {
            thread scripts\cp\cp_hud_message::showsplash( "cp_recharge", delay, self );
        }
        
        wait delay;
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x4428
// Size: 0x30
function function_ea6d72b04228d21()
{
    while ( true )
    {
        self waittill( "weapon_removed", type );
        
        if ( isdefined( type ) && type == "grenade_launcher" )
        {
            break;
        }
    }
}

// Namespace super / scripts\cp\super
// Params 0
// Checksum 0x0, Offset: 0x4460
// Size: 0x76
function function_50eb338949884fca()
{
    enabled = getdvarint( @"hash_13453d792d353e5f", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    if ( scripts\cp\cp_relics::function_7915e88a08f28705() )
    {
        return;
    }
    
    totalintel = self getplayerdata( "cp", "totalIntel" );
    var_9966b1468b120387 = 150;
    
    /#
        var_9966b1468b120387 = getdvarint( @"hash_e82bf0e129d236fa", var_9966b1468b120387 );
    #/
    
    if ( totalintel >= var_9966b1468b120387 )
    {
        thread function_6b384ba557a25934();
    }
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x44de
// Size: 0x82
function getsuperrefforsuperuseweapon( weapon )
{
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    if ( !isdefined( level.superglobals ) || !isdefined( level.superglobals.superweapons ) || !isdefined( level.superglobals.superweapons[ weapon ] ) )
    {
        return undefined;
    }
    
    return level.superglobals.superweapons[ weapon ].ref;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x4569
// Size: 0x5b
function getsuperrefforsuperoffhand( weapon )
{
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    if ( !isdefined( level.superglobals.supersbyoffhand[ weapon ] ) )
    {
        return undefined;
    }
    
    return level.superglobals.supersbyoffhand[ weapon ].ref;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x45cd
// Size: 0x5b
function getsuperrefforsuperextraweapon( weapon )
{
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    if ( !isdefined( level.superglobals.supersbyextraweapon[ weapon ] ) )
    {
        return undefined;
    }
    
    return level.superglobals.supersbyextraweapon[ weapon ].ref;
}

// Namespace super / scripts\cp\super
// Params 1
// Checksum 0x0, Offset: 0x4631
// Size: 0xa0
function getsuperrefforsuperweapon( weapon )
{
    if ( !isdefined( level.superglobals ) )
    {
        return undefined;
    }
    
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    superuseweapon = getsuperrefforsuperuseweapon( weapon );
    
    if ( isdefined( superuseweapon ) )
    {
        return superuseweapon;
    }
    
    superoffhand = getsuperrefforsuperoffhand( weapon );
    
    if ( isdefined( superoffhand ) )
    {
        return superoffhand;
    }
    
    superoffhand = getsuperrefforsuperextraweapon( weapon );
    
    if ( isdefined( superoffhand ) )
    {
        return superoffhand;
    }
    
    switch ( weapon )
    {
        case #"hash_1a30d3a1753a5b6":
            return "super_tac_insert";
        case #"hash_e2c74e289201361":
            return "super_loadout_drop";
    }
    
    return undefined;
}

