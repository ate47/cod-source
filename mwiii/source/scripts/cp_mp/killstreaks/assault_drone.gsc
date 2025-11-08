#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\render_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;

#namespace assault_drone;

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0x8f8
// Size: 0x38
function init()
{
    function_308ec7da3cb5926a();
    function_d91e42f2a9d746a8();
    function_3a2d3d065646c104();
    function_13c1d2376167d45e();
    function_2a27f30882f6a886();
    
    /#
        setdevdvarifuninitialized( @"hash_268779ee67d4a45a", 0 );
    #/
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0x938
// Size: 0x4e2
function function_308ec7da3cb5926a()
{
    level.helperdronesettings[ "assault_drone" ] = spawnstruct();
    level.helperdronesettings[ "assault_drone" ].timeout = 30;
    level.helperdronesettings[ "assault_drone" ].maxhealth = 150;
    level.helperdronesettings[ "assault_drone" ].hitstokill = 1;
    level.helperdronesettings[ "assault_drone" ].speed = 100;
    level.helperdronesettings[ "assault_drone" ].accel = 20;
    level.helperdronesettings[ "assault_drone" ].halfsize = 27;
    level.helperdronesettings[ "assault_drone" ].spawndist = 30;
    level.helperdronesettings[ "assault_drone" ].streakname = "assault_drone";
    level.helperdronesettings[ "assault_drone" ].vehicleinfo = "veh_assault_drone_mp";
    
    if ( utility::iscp() )
    {
        level.helperdronesettings[ "assault_drone" ].modelbase = "veh9_mil_air_bomb_drone_c4_attached_cp";
    }
    else
    {
        level.helperdronesettings[ "assault_drone" ].modelbase = "veh9_mil_air_bomb_drone_c4_attached_mp";
    }
    
    level.helperdronesettings[ "assault_drone" ].teamsplash = "used_" + "assault_drone";
    level.helperdronesettings[ "assault_drone" ].destroyedsplash = "callout_destroyed_" + "assault_drone";
    level.helperdronesettings[ "assault_drone" ].scorepopup = "destroyed_" + "assault_drone";
    level.helperdronesettings[ "assault_drone" ].primarymode = "MANUAL";
    level.helperdronesettings[ "assault_drone" ].primarymodestring = "test string";
    level.helperdronesettings[ "assault_drone" ].primarymodefunc = &function_fb7ed8dfabeaed9a;
    level.helperdronesettings[ "assault_drone" ].premoddamagefunc = undefined;
    level.helperdronesettings[ "assault_drone" ].postmoddamagefunc = &scripts\cp_mp\killstreaks\helper_drone::function_caf721cb23374e2b;
    level.helperdronesettings[ "assault_drone" ].deathfunc = &scripts\cp_mp\killstreaks\helper_drone::function_ba1c5496f8fc5f67;
    level.helperdronesettings[ "assault_drone" ].var_1c606430b81b28ff = &function_2445adf5d64eef6f;
    level.helperdronesettings[ "assault_drone" ].exitfunc = &function_91ae4f6ece59691f;
    level.helperdronesettings[ "assault_drone" ].leavefunc = &function_87ad014181a233aa;
    level.helperdronesettings[ "assault_drone" ].explodefunc = &function_f09621755c154350;
    level.helperdronesettings[ "assault_drone" ].var_9c6efc85b74204cc = &function_a4cfbe3f567af798;
    level.helperdronesettings[ "assault_drone" ].playfxcallback = &scripts\cp_mp\killstreaks\helper_drone::function_56966b077270a18e;
    level.helperdronesettings[ "assault_drone" ].var_c25a8137257a96d = &function_29a52fe5c2a8eb57;
    level.helperdronesettings[ "assault_drone" ].var_191284e2e2837328 = &function_8648618e4fac5041;
    level.helperdronesettings[ "assault_drone" ].var_6a390682c21bc49e = 0;
    level.helperdronesettings[ "assault_drone" ].var_1947a47c2174d02c = 0;
    level.helperdronesettings[ "assault_drone" ].var_cb2c3fe0819193eb = 272 * 272;
    level.helperdronesettings[ "assault_drone" ].var_d5ea718abfc8ff5b = 10000;
    level.helperdronesettings[ "assault_drone" ].colorvision = "assault_drone_color_mp";
    level.helperdronesettings[ "assault_drone" ].var_2215fa459d8250c0 = "assault_drone_color_dark_mp";
    level.helperdronesettings[ "assault_drone" ].var_52c3b4bc88132aee = 1;
    level.helperdronesettings[ "assault_drone" ].var_5c59bdb4308ee080 = 0;
    level.helperdronesettings[ "assault_drone" ].var_dd47aede4ad7e18a = 1;
    level.helperdronesettings[ "assault_drone" ].detonateontimeout = 1;
    level.helperdronesettings[ "assault_drone" ].voontimeout = 0;
    
    if ( isbrstylegametype() )
    {
        level.helperdronesettings[ "assault_drone" ].diewithowner = 1;
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0xe22
// Size: 0xf2
function function_d91e42f2a9d746a8()
{
    val::group_register( "assaultDrone_switch", [ "allow_movement", "allow_jump", "supers", "killstreaks", "vehicle_use" ] );
    val::group_register( "assaultDrone_deploy", [ "usability", "melee", "offhand_weapons", "weapon_switch" ] );
    
    if ( issharedfuncdefined( "equipment", "areNVGTogglableForPlayer" ) && ![[ getsharedfunc( "equipment", "areNVGTogglableForPlayer" ) ]]() )
    {
        val::group_register( "assaultDrone_use", [ "fire", "shellshock", "melee" ] );
        return;
    }
    
    val::group_register( "assaultDrone_use", [ "fire", "shellshock", "melee", "nvg" ] );
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0xf1c
// Size: 0x9d
function function_3a2d3d065646c104()
{
    game[ "dialog" ][ "assault_drone" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "assault_drone" + "_timeout" ] = "killstreak_remote_operator" + "_timeout";
    game[ "dialog" ][ "assault_drone" + "_destroyed" ] = "killstreak_remote_operator" + "_crash";
    game[ "dialog" ][ "assault_drone" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "assault_drone" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0xfc1
// Size: 0x2
function function_13c1d2376167d45e()
{
    
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0xfcb
// Size: 0x54
function function_2a27f30882f6a886()
{
    if ( isdefined( level.var_6d129920246627ba ) )
    {
        function_c0b0a582ff9e4d57( level.var_6d129920246627ba );
    }
    
    if ( isdefined( level.var_61b254009a0951a6 ) )
    {
        function_c0b0a582ff9e4d57( level.var_61b254009a0951a6 );
    }
    
    function_c0b0a582ff9e4d57( "assault_drone_color_mp" );
    function_c0b0a582ff9e4d57( "assault_drone_color_dark_mp" );
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0x1027
// Size: 0x21
function function_e24ef5600f59548e()
{
    streakinfo = createstreakinfo( "assault_drone", self );
    return function_2445adf5d64eef6f( streakinfo );
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x1051
// Size: 0x4d8, Type: bool
function function_2445adf5d64eef6f( streakinfo )
{
    if ( !scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle() )
    {
        return false;
    }
    
    self notify( "using_remote" );
    helperdronetype = streakinfo.streakname;
    startpos = scripts\cp_mp\killstreaks\helper_drone::function_34280b807c23a453( helperdronetype );
    
    if ( !isdefined( startpos ) )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        return false;
    }
    
    val::group_set( "assaultDrone_switch", 0 );
    
    if ( utility::iscp() )
    {
        deployweaponobj = makeweapon( "ks_assault_drone_cp" );
    }
    else
    {
        deployweaponobj = makeweapon( "ks_assault_drone_mp" );
    }
    
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &scripts\cp_mp\killstreaks\helper_drone::weapongivenhelperdrone );
    
    if ( !istrue( deployresult ) )
    {
        val::group_reset( "assaultDrone_switch" );
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
        streakinfo notify( "killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            val::group_reset( "assaultDrone_switch" );
            scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
            streakinfo notify( "killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    self notify( "assaultDroneCalled" );
    var_e5c7ffb094dc9eec = 2;
    var_52a5be2e2f91d710 = 0.5;
    val::group_set( "assaultDrone_deploy", 0 );
    _freezecontrols( 1, undefined, "heliEndRide" );
    
    if ( issharedfuncdefined( "sound", "playKillstreakDeployDialog" ) )
    {
        [[ getsharedfunc( "sound", "playKillstreakDeployDialog" ) ]]( self, streakinfo.streakname );
    }
    
    result = waittill_any_timeout_1( var_e5c7ffb094dc9eec, "death" );
    
    if ( !isdefined( result ) || result != "timeout" )
    {
        _freezecontrols( 0, 1, "assaultDrone" );
        val::group_reset( "assaultDrone_switch" );
        val::group_reset( "assaultDrone_deploy" );
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
        streakinfo notify( "killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    startpos = scripts\cp_mp\killstreaks\helper_drone::function_34280b807c23a453( helperdronetype );
    startangles = self.angles;
    assaultdrone = function_37873a0b82dad887( startpos, startangles, helperdronetype, streakinfo );
    
    if ( !isdefined( assaultdrone ) )
    {
        _freezecontrols( 0, 1, "assaultDrone" );
        val::group_reset( "assaultDrone_switch" );
        val::group_reset( "assaultDrone_deploy" );
        return false;
    }
    
    if ( issharedfuncdefined( "weapons", "_launchGrenade" ) )
    {
        if ( isbrstylegametype() )
        {
            dangericonent = self [[ getsharedfunc( "weapons", "_launchGrenade" ) ]]( "assault_drone_danger_br", assaultdrone.origin, ( 0, 0, 0 ), 100, 1 );
        }
        else
        {
            dangericonent = self [[ getsharedfunc( "weapons", "_launchGrenade" ) ]]( "assault_drone_danger_mp", assaultdrone.origin, ( 0, 0, 0 ), 100, 1 );
        }
        
        dangericonent.streakinfo = streakinfo;
        dangericonent linkto( assaultdrone );
        assaultdrone.dangericonent = dangericonent;
    }
    
    thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote( streakinfo );
    
    if ( issharedfuncdefined( "killstreak", "killstreakUse" ) )
    {
        self [[ getsharedfunc( "killstreak", "killstreakUse" ) ]]( "assault_drone" );
    }
    
    if ( issharedfuncdefined( "game", "isBRStyleGameType" ) )
    {
        if ( [[ getsharedfunc( "game", "isBRStyleGameType" ) ]]() )
        {
            assaultdrone vehicleshowonminimap( 0 );
        }
    }
    
    scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog( streakinfo.streakname );
    assaultdrone scripts\cp_mp\killstreaks\helper_drone::helperdrone_notifyenemyplayersinrange( streakinfo.streakname );
    _freezecontrols( 0, 1, "assaultDrone" );
    scripts\cp_mp\killstreaks\helper_drone::function_c3786c4fba09c2f2( streakinfo );
    var_4c4c52e5183669b3 = getdvarint( @"hash_fdc42aba096a2344", 3 );
    thread scripts\cp_mp\killstreaks\helper_drone::starthelperdrone( assaultdrone, var_4c4c52e5183669b3 );
    bundle = level.streakglobals.streakbundles[ "assault_drone" ];
    
    if ( isdefined( bundle ) && isdefined( bundle.dangerzoneheight ) && !istrue( bundle.var_9a08562cf535296a ) )
    {
        origin = assaultdrone.origin - ( 0, 0, bundle.dangerzoneheight / 2 );
        assaultdrone function_a5a593f3ab4f7077( bundle, self, self.team, level.helperdronesettings[ "assault_drone" ].timeout, origin );
    }
    
    self notify( "assault_drone_deployed" );
    thread playkillstreakoperatordialog( streakinfo.streakname, streakinfo.streakname + "_use", 1, var_52a5be2e2f91d710 );
    
    if ( issharedfuncdefined( "killstreak", "enableDroneTracking" ) )
    {
        self thread [[ getsharedfunc( "killstreak", "enableDroneTracking" ) ]]( assaultdrone );
    }
    
    return true;
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 4
// Checksum 0x0, Offset: 0x1532
// Size: 0xe1
function function_37873a0b82dad887( startpos, startang, helperdronetype, streakinfo )
{
    assaultdrone = scripts\cp_mp\killstreaks\helper_drone::createhelperdrone( startpos, startang, helperdronetype, streakinfo, 0, 1 );
    
    if ( !isdefined( assaultdrone ) )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx( helperdronetype, startpos );
        streakinfo notify( "killstreak_finished_with_deploy_weapon" );
        
        if ( issharedfuncdefined( "vehicle", "decrementFauxVehicleCount" ) )
        {
            [[ getsharedfunc( "vehicle", "decrementFauxVehicleCount" ) ]]();
        }
        
        scripts\cp_mp\killstreaks\helper_drone::function_c3786c4fba09c2f2( streakinfo );
        return undefined;
    }
    
    assaultdrone.owner.var_3efdaabc0f66846d = 0;
    
    if ( isdefined( level.var_b67b5f9dfe488c2f ) )
    {
        thread [[ level.var_b67b5f9dfe488c2f ]]( streakinfo );
    }
    
    return assaultdrone;
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x161c
// Size: 0x54
function function_29a52fe5c2a8eb57( streakname )
{
    hitstokill = level.helperdronesettings[ streakname ].hitstokill;
    
    if ( issharedfuncdefined( "vehicle_damage", "setVehicleHitDamageData" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setVehicleHitDamageData" ) ]]( streakname, hitstokill );
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x1678
// Size: 0x7b
function function_8648618e4fac5041( streakname )
{
    hitstokill = level.helperdronesettings[ streakname ].hitstokill;
    weaponname = "emp_grenade_mp";
    weaponhitsperattack = hitstokill;
    weaponhitstokill = hitstokill;
    
    if ( issharedfuncdefined( "vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon" ) ]]( weaponname, weaponhitsperattack, weaponhitstokill, streakname );
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x16fb
// Size: 0x2b
function function_fb7ed8dfabeaed9a( config )
{
    if ( !isdefined( self.usedcount ) )
    {
        self.usedcount = 0;
    }
    
    thread function_74247ac518a2df62( config );
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x172e
// Size: 0x30e, Type: bool
function function_74247ac518a2df62( config )
{
    self.owner thread watchthermalinputchange( 1 );
    self.playersfx = spawn( "script_origin", self.origin );
    self.playersfx showonlytoplayer( self.owner );
    self.playersfx linkto( self );
    self.playersfx playloopsound( "recon_drone_overlay" );
    self.owner setsoundsubmix( "mp_recon_drone", 1 );
    self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "overlaytargetmarkerenemy", self.owner, undefined, self.owner, 0, 0, 0 );
    self.ispiloted = 1;
    self.owner val::group_set( "assaultDrone_use", 0 );
    self.owner.restoreangles = self.owner.angles;
    self.owner setplayerangles( self.angles );
    self.owner cameralinkto( self, "tag_origin", 0, 1 );
    
    if ( !isdefined( self.empcount ) || isdefined( self.empcount ) && self.empcount == 0 )
    {
        self.owner remotecontrolvehicle( self );
        self.owner scripts\cp_mp\utility\render_utility::function_4f2c4138dacca16a( 1, 0, 0.015, 0.15 );
    }
    
    self.owner painvisionoff();
    self setscriptablepartstate( "ddos", "neutral", 0 );
    scripts\cp_mp\emp_debuff::set_start_emp_callback( &function_7d0712e71e309e60 );
    scripts\cp_mp\emp_debuff::set_apply_emp_callback( &function_35de57c9587f7f44 );
    scripts\cp_mp\emp_debuff::set_clear_emp_callback( &function_c58f1c9f5ff4f9c5 );
    scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_c3fac7e77ebbb27b );
    
    if ( issharedfuncdefined( "emp", "setEMP_Started_Callback" ) )
    {
        self [[ getsharedfunc( "emp", "setEMP_Started_Callback" ) ]]( &function_7d0712e71e309e60 );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        self [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &function_35de57c9587f7f44 );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Cleared_Callback" ) )
    {
        self [[ getsharedfunc( "emp", "setEMP_Cleared_Callback" ) ]]( &function_c58f1c9f5ff4f9c5 );
    }
    
    scripts\cp_mp\utility\killstreak_utility::movingplatform_playerlink( self.owner );
    self.owner scripts\cp_mp\killstreaks\helper_drone::function_89af506d89aad6ed( 1, self );
    self.owner setclientomnvar( "ui_rcd_outer_ring", 0 );
    
    if ( issharedfuncdefined( "game", "registerEntForOOB" ) )
    {
        [[ getsharedfunc( "game", "registerEntForOOB" ) ]]( self, "killstreak" );
    }
    
    thread scripts\cp_mp\killstreaks\recon_drone::function_86e1c4f92c53ccfb( config );
    thread function_ee8fd2b2321035c0( config );
    thread function_da8b343109516850( config );
    self setscriptablepartstate( "warning_beep", "on", 0 );
    self.owner killstreak_savenvgstate();
    thread function_518a6887376e8b13( config );
    return true;
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x1a45
// Size: 0xa4
function function_ee8fd2b2321035c0( config )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "switch_modes" );
    self.owner endon( "disconnect" );
    reticlestate = 0;
    
    while ( true )
    {
        if ( istrue( self.var_12dce598075360d8 ) && reticlestate == 0 )
        {
            self.owner setclientomnvar( "ui_rcd_outer_ring", 1 );
            reticlestate = 1;
        }
        else if ( !istrue( self.var_12dce598075360d8 ) && reticlestate == 1 )
        {
            self.owner setclientomnvar( "ui_rcd_outer_ring", 0 );
            reticlestate = 0;
        }
        
        waitframe();
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x1af1
// Size: 0x184
function function_da8b343109516850( config )
{
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "switch_modes" );
    var_820e590cb5620371 = 0;
    
    while ( true )
    {
        targets = self.targetsinouterradius;
        var_12dce598075360d8 = 0;
        
        foreach ( player in targets )
        {
            if ( var_820e590cb5620371 >= 3 )
            {
                var_820e590cb5620371 = 0;
                waitframe();
            }
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isplayer( player ) && issharedfuncdefined( "player", "isReallyAlive" ) )
            {
                if ( ![[ getsharedfunc( "player", "isReallyAlive" ) ]]( player ) )
                {
                    continue;
                }
            }
            
            var_820e590cb5620371++;
            scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6( self.targetmarkergroup, player, 1 );
            isvisible = scripts\cp_mp\killstreaks\helper_drone::function_f9c33df98457a9a2( player );
            isinrange = scripts\cp_mp\killstreaks\recon_drone::function_26d9d0c6ca7a5a8c( player );
            
            if ( !istrue( isvisible ) )
            {
                scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6( self.targetmarkergroup, player, 0 );
                continue;
            }
            else if ( !istrue( isinrange ) )
            {
                continue;
            }
            
            var_12dce598075360d8 = 1;
            scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6( self.targetmarkergroup, player, 2 );
        }
        
        self.var_12dce598075360d8 = var_12dce598075360d8;
        var_820e590cb5620371 = 0;
        waitframe();
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0x1c7d
// Size: 0xa
function function_91ae4f6ece59691f()
{
    thread function_87ad014181a233aa();
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x1c8f
// Size: 0x17
function function_87ad014181a233aa( timeout )
{
    thread scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3( 0, 1, timeout );
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 6
// Checksum 0x0, Offset: 0x1cae
// Size: 0x1cd
function function_f09621755c154350( config, wasdestroyed, wasexited, wastimedout, wasdetonated, thirdperson )
{
    if ( isdefined( self.empcount ) && self.empcount > 0 )
    {
        self.owner _freezelookcontrols( 0, 1 );
    }
    
    if ( issharedfuncdefined( "game", "clearOOB" ) )
    {
        [[ getsharedfunc( "game", "clearOOB" ) ]]( self, 1 );
    }
    
    if ( isdefined( self.dangericonent ) )
    {
        self.dangericonent delete();
    }
    
    self setscriptablepartstate( "warning_beep", "off", 0 );
    
    if ( !istrue( wasdestroyed ) )
    {
        self clearscriptabledamageowner();
    }
    
    if ( istrue( wasdetonated ) || istrue( wasexited ) && istrue( config.var_5c59bdb4308ee080 ) || istrue( wastimedout ) && istrue( config.detonateontimeout ) || istrue( wasdestroyed ) && istrue( config.var_dd47aede4ad7e18a ) )
    {
        if ( issharedfuncdefined( "killstreak", "makePlayerVulnerableOnAssaultDroneDetonate" ) )
        {
            self.owner thread [[ getsharedfunc( "killstreak", "makePlayerVulnerableOnAssaultDroneDetonate" ) ]]( self );
        }
        
        scripts\cp_mp\killstreaks\helper_drone::function_9fe87b841a44448f();
        thread function_1e7e724aa1c163ab();
    }
    else
    {
        scripts\cp_mp\killstreaks\helper_drone::function_24085a0230958938();
    }
    
    if ( isdefined( level.var_ca1a76fbc0ba0bef ) )
    {
        thread [[ level.var_ca1a76fbc0ba0bef ]]( self.streakinfo, self.origin, 0 );
    }
    
    delayreturn = undefined;
    
    if ( function_ccf98e6391dd38b9() && isdefined( thirdperson ) && istrue( thirdperson ) )
    {
        delayreturn = 2.5;
    }
    else if ( function_ccf98e6391dd38b9() )
    {
        delayreturn = 0;
    }
    
    thread function_a4cfbe3f567af798( self.owner, delayreturn );
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 2
// Checksum 0x0, Offset: 0x1e83
// Size: 0x27f
function function_a4cfbe3f567af798( player, delayreturn )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    self setentityowner( player );
    self clearscriptabledamageowner();
    dronetype = self.helperdronetype;
    config = level.helperdronesettings[ dronetype ];
    self.ispiloted = 0;
    
    if ( isdefined( player.super ) )
    {
        player.super.isactive = 0;
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx delete();
    }
    
    if ( isdefined( self.enemiesmarked ) )
    {
        foreach ( markdata in self.enemiesmarked )
        {
            scripts\cp_mp\killstreaks\recon_drone::function_f1d272b5fc3a575c( markdata, player );
        }
    }
    
    tabletweapon = "ks_remote_drone_mp";
    
    if ( istrue( self.var_eee5ddaafc619fa3 ) )
    {
        tabletweapon = "ks_remote_device_mp";
    }
    
    player thread scripts\cp_mp\killstreaks\recon_drone::recondrone_takedeployweapon( 1, tabletweapon );
    player scripts\cp_mp\killstreaks\helper_drone::helperdrone_takeplayerfauxremote( self.streakinfo );
    player painvisionon();
    
    if ( isdefined( level.var_f56a88761038798b ) )
    {
        thread [[ level.var_f56a88761038798b ]]( self.streakinfo );
    }
    
    player killstreak_setmainvision( "" );
    
    if ( istrue( self.isthermalenabled ) )
    {
        player setthermalvision( 0 );
    }
    
    player _freezecontrols( 0, 1, "assaultDrone" );
    player _freezelookcontrols( 0, 1 );
    player val::group_reset( "assaultDrone_switch" );
    player val::group_reset( "assaultDrone_deploy" );
    player val::group_reset( "assaultDrone_use" );
    player thread scripts\cp_mp\killstreaks\helper_drone::function_f23d90f7483d67e4();
    
    if ( istrue( self.isempd ) )
    {
        self.isempd = undefined;
        self.owner thread scripts\cp_mp\emp_debuff::stop_emp_scramble( 5 );
    }
    
    if ( !istrue( self.var_d31453e33d3e34ca ) )
    {
        player remotecontrolvehicleoff();
    }
    
    player scripts\cp_mp\utility\render_utility::function_e2eae50826e12247();
    scripts\cp_mp\utility\killstreak_utility::movingplatform_playerunlink( player );
    player killstreak_restorenvgstate();
    
    if ( isdefined( delayreturn ) )
    {
        wait delayreturn;
    }
    
    player cameraunlink();
    player setplayerangles( ( player.restoreangles[ 0 ], player.restoreangles[ 1 ], 0 ) );
    player.restoreangles = undefined;
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x210a
// Size: 0x10b
function function_413df2de080e3cc1( config )
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self.owner notifyonplayercommand( "drone_camera_switch", "+melee_zoom" );
    
    while ( true )
    {
        self.owner waittill( "drone_camera_switch" );
        var_1c3e9c203ea72971 = 0;
        
        /#
            var_1c3e9c203ea72971 = getdvarint( @"hash_268779ee67d4a45a", 0 );
        #/
        
        if ( !istrue( var_1c3e9c203ea72971 ) )
        {
            continue;
        }
        
        if ( self.camerastate == "default" )
        {
            self.owner _freezelookcontrols( 1 );
            function_521e734765a10ca9( 2, "under", "tag_undercam" );
            thread function_80269a0d716399f( config );
            
            /#
                thread function_b596c64f2795cdc1( "<dev string:x1c>" );
            #/
            
            continue;
        }
        
        self.owner _freezelookcontrols( 0, 1 );
        function_521e734765a10ca9( 1, "default", "tag_origin" );
        thread function_518a6887376e8b13( config );
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x221d
// Size: 0x6f
function function_80269a0d716399f( config )
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "leaving" );
    self endon( "detonate_bomb" );
    self.owner endon( "disconnect" );
    self notify( "release_bomb" );
    self.owner notifyonplayercommand( "drone_release_bomb", "+attack" );
    self.owner waittill( "drone_release_bomb" );
    childthread function_6756b4a82c91ce02();
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0x2294
// Size: 0xf6
function function_1e7e724aa1c163ab()
{
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 1 );
    
    if ( !isdefined( droneowner.var_5431d89a36b0936 ) )
    {
        droneowner.var_5431d89a36b0936 = 0;
    }
    
    if ( !isdefined( droneowner.recentkillcount ) )
    {
        droneowner.recentkillcount = 0;
    }
    
    if ( !isdefined( droneowner.var_3efdaabc0f66846d ) )
    {
        droneowner.var_3efdaabc0f66846d = 0;
    }
    
    if ( droneowner.recentkillcount >= 1 || droneowner.var_5431d89a36b0936 >= 1 || droneowner.var_3efdaabc0f66846d >= 1 )
    {
        droneowner playkillstreakoperatordialog( "assault_drone", "assault_drone" + "_hit_target", 1 );
    }
    else
    {
        droneowner playkillstreakoperatordialog( "assault_drone", "assault_drone" + "_miss_target", 1, 0.6 );
    }
    
    self.var_3efdaabc0f66846d = undefined;
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x2392
// Size: 0xa7
function function_518a6887376e8b13( config )
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "leaving" );
    self endon( "release_bomb" );
    self.owner endon( "disconnect" );
    self notify( "detonate_bomb" );
    self.owner notifyonplayercommand( "drone_detonate", "+attack" );
    
    while ( true )
    {
        self.owner waittill( "drone_detonate" );
        
        if ( istrue( self.owner.ksempd ) || scripts\cp_mp\emp_debuff::is_empd() )
        {
            continue;
        }
        else
        {
            thread scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3( 0, 0, 0, 1 );
            break;
        }
        
        waitframe();
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 3
// Checksum 0x0, Offset: 0x2441
// Size: 0x90
function function_521e734765a10ca9( controlstate, camerastate, cameratag )
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "leaving" );
    self.owner endon( "disconnect" );
    self.owner cameraunlink();
    self.owner scripts\cp_mp\killstreaks\helper_drone::function_89af506d89aad6ed( 0 );
    waitframe();
    self.owner cameralinkto( self, cameratag, 0, 1 );
    self.owner scripts\cp_mp\killstreaks\helper_drone::function_89af506d89aad6ed( controlstate, self );
    self.camerastate = camerastate;
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 0
// Checksum 0x0, Offset: 0x24d9
// Size: 0xaa
function function_6756b4a82c91ce02()
{
    launchdir = vectornormalize( self.origin - ( 0, 0, 5 ) - self.origin );
    launchoffset = self.origin + launchdir * 10;
    launchgoal = launchoffset + launchdir * 100;
    launchvelocity = launchgoal - launchoffset;
    projectile = magicgrenademanual( "assault_drone_mp", launchoffset, launchvelocity, 99, self.owner );
    projectile.streakinfo = self.streakinfo;
    wait 2;
    thread function_87ad014181a233aa();
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x258b
// Size: 0x76
function function_c3fac7e77ebbb27b( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) && isdefined( data.inflictor ) && self.currenthealth > 0 )
    {
        self dodamage( self.maxhealth, self.origin, data.attacker, data.inflictor );
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x2609
// Size: 0xe5
function function_7d0712e71e309e60( data )
{
    self setscriptablepartstate( "ddos", "disabled", 0 );
    self setscriptablepartstate( "warning_beep", "off", 0 );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "player", "doScoreEvent" ) )
        {
            data.attacker thread [[ scripts\engine\utility::getsharedfunc( "player", "doScoreEvent" ) ]]( "disabled_bomb_drone" );
        }
    }
    
    if ( istrue( self.ispiloted ) )
    {
        self.owner _freezecontrols( 1, undefined, "assaultDrone" );
        self.owner _freezelookcontrols( 1 );
        
        if ( !istrue( self.isempd ) )
        {
            self.isempd = 1;
            self.owner thread scripts\cp_mp\emp_debuff::play_emp_scramble( 5 );
        }
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x26f6
// Size: 0x69
function function_35de57c9587f7f44( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "player", "doScoreEvent" ) )
        {
            data.attacker thread [[ scripts\engine\utility::getsharedfunc( "player", "doScoreEvent" ) ]]( "disabled_bomb_drone", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        }
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 1
// Checksum 0x0, Offset: 0x2767
// Size: 0x9f
function function_c58f1c9f5ff4f9c5( isdeath )
{
    self setscriptablepartstate( "ddos", "neutral", 0 );
    self setscriptablepartstate( "warning_beep", "on", 0 );
    
    if ( istrue( self.isempd ) )
    {
        self.isempd = undefined;
        self.owner thread scripts\cp_mp\emp_debuff::stop_emp_scramble( 5 );
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( istrue( self.ispiloted ) )
    {
        self.owner _freezecontrols( 0, 1, "assaultDrone" );
        self.owner _freezelookcontrols( 0, 1 );
    }
}

// Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
// Params 3
// Checksum 0x0, Offset: 0x280e
// Size: 0x14e
function function_571f1e65c43fb585( inflictor, victim, scaleddamage )
{
    if ( !isdefined( inflictor ) || !isdefined( victim ) )
    {
        return scaleddamage;
    }
    
    var_59f806a0ab5d37fc = victim scripts\cp_mp\armor::function_9bca5c1d23a3e0b3();
    
    if ( istrue( var_59f806a0ab5d37fc ) )
    {
        var_5a76b167b0298c0d = utility::playersnear( inflictor.origin, 100 );
        var_72601fe316a42077 = 0;
        
        foreach ( potentialtarget in var_5a76b167b0298c0d )
        {
            if ( potentialtarget != victim )
            {
                continue;
            }
            
            var_72601fe316a42077 = 1;
            break;
        }
        
        if ( !istrue( var_72601fe316a42077 ) )
        {
            scaleddamage = victim scripts\cp_mp\armor::function_ac266fc218266d08() + victim.health - 1;
            
            if ( isdefined( inflictor.owner ) )
            {
                if ( scripts\engine\utility::issharedfuncdefined( "player", "doScoreEvent" ) )
                {
                    if ( isdefined( victim.var_4045f099f3da4bd ) && victim.var_4045f099f3da4bd == "brloot_plate_carrier_tempered" )
                    {
                        inflictor.owner thread [[ scripts\engine\utility::getsharedfunc( "player", "doScoreEvent" ) ]]( #"hash_4caa4f3c52eaa383" );
                    }
                }
            }
        }
    }
    
    return scaleddamage;
}

/#

    // Namespace assault_drone / scripts\cp_mp\killstreaks\assault_drone
    // Params 1
    // Checksum 0x0, Offset: 0x2965
    // Size: 0x73, Type: dev
    function function_b596c64f2795cdc1( cameratag )
    {
        self endon( "<dev string:x2c>" );
        self endon( "<dev string:x35>" );
        self endon( "<dev string:x40>" );
        self.owner endon( "<dev string:x4b>" );
        self.owner endon( "<dev string:x59>" );
        
        while ( true )
        {
            level thread scripts\cp_mp\utility\debug_utility::drawsphere( self gettagorigin( cameratag ), 10, 0.05, ( 1, 1, 1 ) );
            wait 0.05;
        }
    }

#/
