#using script_16ea1b94f0f381b3;
#using script_24e4405cf93f20ed;
#using script_279d83e79f5bb757;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_build;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\customization\battle_tracks;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_collision;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\flags;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;

#namespace vehicle;

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0xdaa
// Size: 0x2b2
function vehicle_init()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle ) )
    {
        level.vehicle = spawnstruct();
    }
    
    level.vehicle.vehicledata = [];
    level.vehicle.onvehiclespawned = &onvehiclespawned;
    
    /#
        scripts\engine\utility::issharedfuncdefined( "<dev string:x1c>", "<dev string:x24>", 1 );
    #/
    
    [[ scripts\engine\utility::getsharedfunc( "vehicle", "init" ) ]]();
    
    if ( getdvarint( @"t10" ) > 0 )
    {
        level.shouldinitvehicles = 1;
    }
    
    if ( getdvarint( @"hash_50e5feed8f9f6f56", 0 ) == 1 )
    {
        level.var_1b4da6b781c9dfbd = 1;
    }
    
    bundlenames = getscriptbundlenames( "vehiclebundle" );
    
    if ( bundlenames.size > 0 )
    {
        level.shouldinitvehicles = 1;
    }
    
    scripts\common\vehicle_code::vehicle_setuplevelvariables();
    
    if ( istrue( level.shouldinitvehicles ) )
    {
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_init();
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_init();
        scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_init();
        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_init();
        scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_init();
        scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_init();
        scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_init();
        scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_init();
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_init();
        scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_init();
        scripts\cp_mp\vehicles\customization\battle_tracks::function_620aa345ac2f9963();
        level thread function_466cdec791b7edfe();
        level thread function_5ff2c834ca229322();
        scripts\common\callbacks::add( "player_connect", &vehicle_onplayerconnect );
        
        if ( isdefined( level.var_54ce42fa004dde04 ) )
        {
            foreach ( func in level.var_54ce42fa004dde04 )
            {
                [[ func ]]();
            }
        }
        
        foreach ( bundlename in bundlenames )
        {
            bundle = getscriptbundle( bundlename );
            
            if ( isdefined( bundle.ref ) && istrue( bundle.autoregister ) )
            {
                function_8497e7e46b5e397( bundle.ref );
            }
        }
        
        level.var_54c8acfd634a416c = 1;
    }
    else
    {
        scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_init();
        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_init();
        scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_init();
        scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_init();
        scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_init();
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_init();
    }
    
    flag_set( "vehicle_init_complete" );
    flag_set( "vehicle_init_done" );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x1064
// Size: 0x5e
function function_c0b3ddc9a6bdcc46( vehicleref, func )
{
    level.shouldinitvehicles = 1;
    
    if ( function_38f50decb5603d7( vehicleref ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_54ce42fa004dde04 ) )
    {
        level.var_54ce42fa004dde04 = [];
    }
    
    level.var_54ce42fa004dde04[ vehicleref ] = func;
    
    if ( istrue( level.var_54c8acfd634a416c ) )
    {
        [[ func ]]();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x10ca
// Size: 0x25, Type: bool
function function_38f50decb5603d7( vehicleref )
{
    return isdefined( level.var_54ce42fa004dde04 ) && isdefined( level.var_54ce42fa004dde04[ vehicleref ] );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x10f8
// Size: 0x61
function vehicle_forceinit( vehicleref )
{
    if ( !isdefined( level.forceinitvehiclerefs ) )
    {
        level.forceinitvehiclerefs = [];
    }
    
    level.forceinitvehiclerefs[ vehicleref ] = 1;
    
    if ( function_38f50decb5603d7( vehicleref ) && istrue( level.var_54c8acfd634a416c ) && !function_fa537f1ab52a76d1( vehicleref ) )
    {
        [[ level.var_54ce42fa004dde04[ vehicleref ] ]]();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x1161
// Size: 0x41, Type: bool
function function_9697379150687859( vehicleref )
{
    return istrue( level.var_1b4da6b781c9dfbd ) || isdefined( level.forceinitvehiclerefs ) && istrue( level.forceinitvehiclerefs[ vehicleref ] ) || function_b08e7e3a0b14f76f( vehicleref ).size > 0;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x11ab
// Size: 0xf0
function onvehiclespawned()
{
    params = spawnstruct();
    params.vehicle = self;
    scripts\common\callbacks::callback( "on_vehicle_spawned", params );
    vehiclebundle = self.veh_scriptbundlesettings;
    
    if ( !isdefined( vehiclebundle ) )
    {
        return;
    }
    
    vehicleref = vehiclebundle.ref;
    
    if ( !isdefined( vehicleref ) || !function_fa537f1ab52a76d1( vehicleref ) )
    {
        return;
    }
    
    if ( issharedfuncdefined( vehicleref, "spawn" ) )
    {
        return;
    }
    
    level callback::callback( "onVehicleSpawned", params );
    spawndata = spawnstruct();
    spawndata.origin = self.origin;
    spawndata.angles = self.angles;
    spawndata.spawntype = "LEVEL";
    spawndata.initai = 1;
    function_bba34cf920370ff4( vehicleref, spawndata, undefined, self );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x12a3
// Size: 0x81
function function_466cdec791b7edfe()
{
    while ( !isnavmeshloaded() )
    {
        waitframe();
    }
    
    waitframe();
    
    foreach ( layer in [ "vehicle_large", "vehicle_med", "soldier" ] )
    {
        if ( isnavmeshloaded( layer ) )
        {
            level.vehiclenavmeshlayer = layer;
            break;
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x132c
// Size: 0x175
function function_5ff2c834ca229322()
{
    while ( true )
    {
        level waittill( "vehicle_integrity_failure", unstablevehiclelist );
        
        foreach ( unstablevehiclenotification in unstablevehiclelist )
        {
            unstablevehicle = unstablevehiclenotification[ 0 ];
            reason = unstablevehiclenotification[ 1 ];
            
            /#
                entitynum = unstablevehicle getentitynumber();
                iprintln( "<dev string:x29>" + entitynum + "<dev string:x55>" + default_to( unstablevehicle.vehiclename, "<dev string:x5e>" ) + "<dev string:x68>" + reason );
            #/
            
            if ( unstablevehicle isvehiclekillstreak() )
            {
                /#
                    iprintln( "<dev string:x73>" + unstablevehicle.streakinfo.streakname + "<dev string:xa3>" + unstablevehicle.vehiclename );
                #/
                
                killstreakintegrity = unstablevehicle.var_3098bbcd22d0e052;
                
                if ( isdefined( killstreakintegrity ) )
                {
                    unstablevehicle thread [[ killstreakintegrity.failurefunc ]]( reason );
                }
                
                continue;
            }
            
            if ( unstablevehicle isvehicle() )
            {
                unstablevehicle.dontspawnhusk = 1;
                
                if ( istrue( unstablevehicle.var_1693991455559c14 ) )
                {
                    vehicle_death( unstablevehicle );
                }
                else
                {
                    unstablevehicle vehicle_explode();
                }
                
                continue;
            }
            
            unstablevehicle delete();
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x14a9
// Size: 0x13
function vehicle_onplayerconnect( params )
{
    thread function_973cff70a385b03();
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x14c4
// Size: 0x2c
function function_973cff70a385b03()
{
    self endon( "disconnect" );
    
    while ( true )
    {
        waittill_any_2( "ascender_attached", "ascender_detached" );
        thread vehicle_preventplayercollisiondamagefortimeafterexit( undefined, self );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x14f8
// Size: 0xc, Type: bool
function isvehicle()
{
    return isdefined( self.vehiclename );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x150d
// Size: 0x20, Type: bool
function function_a164fb69837475d5()
{
    return isdefined( self ) && isdefined( self.externalvehicle ) && isdefined( self.externalvehicleturret );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 3
// Checksum 0x0, Offset: 0x1536
// Size: 0x39
function function_160ef1c877c69ab1( vehicle, turret, tag )
{
    self.externalvehicle = vehicle;
    self.externalvehicleturret = turret;
    self.externalvehicletag = tag;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1577
// Size: 0x20
function function_4d2324450a951b2b()
{
    self.externalvehicle = undefined;
    self.externalvehicleturret = undefined;
    self.externalvehicletag = undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x159f
// Size: 0x4c
function exitexternalturret()
{
    if ( !function_a164fb69837475d5() )
    {
        return;
    }
    
    ref = self.externalvehicle function_d93ec4635290febd();
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    self.externalvehicleturret callsharedfunc( ref, "exitExternalTurret", self, self.externalvehicle );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x15f3
// Size: 0x20, Type: bool
function isvehicledestroyed()
{
    assertex( isvehicle(), "isVehicleDestroyed() called on a non-vehicle entity." );
    return istrue( self.isdestroyed );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x161c
// Size: 0x24, Type: bool
function isbossvehicle()
{
    return isvehicle() && !isdefined( self.owner ) && isdefined( self.bossinstance );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1649
// Size: 0x2f
function vehiclecanfly()
{
    leveldataforvehicle = vehicle_getleveldataforvehicle( self.vehiclename );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        return istrue( leveldataforvehicle.canfly );
    }
    
    return undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1681
// Size: 0xae, Type: bool
function isfloating()
{
    if ( self vehicle_isphysveh() && self function_784f000d59e38105() )
    {
        return !self vehphys_isgroundvehicle();
    }
    
    if ( !self vehphys_isgroundvehicle() )
    {
        return false;
    }
    
    data = vehicle_getleveldataforvehicle( function_d93ec4635290febd() );
    
    if ( isdefined( data ) && isdefined( data.interact ) && self vehicle_isphysveh() )
    {
        testdepth = default_to( data.interact.depththreshold, 20 );
        
        if ( isdefined( self.deadwheels ) )
        {
            testdepth -= 2 * self.deadwheels.size;
        }
        
        return ( self function_100d3bf35fca6a7f() > testdepth );
    }
    
    return false;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1738
// Size: 0xc, Type: bool
function isvehiclehusk()
{
    return istrue( self.isvehiclehusk );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x174d
// Size: 0x2c, Type: bool
function isvehicleboat()
{
    leveldataforvehicle = vehicle_getleveldataforvehicle( function_d93ec4635290febd() );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        return istrue( leveldataforvehicle.isboat );
    }
    
    return false;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1782
// Size: 0x22, Type: bool
function isvehiclekillstreak()
{
    if ( isdefined( self ) && scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        if ( isdefined( self.streakinfo ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x17ad
// Size: 0x13, Type: bool
function isgroundvehicle()
{
    return !vehiclecanfly() && !isvehicleboat();
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x17c9
// Size: 0x6b
function vehicle_getleveldataforvehicle( vehicleref, create )
{
    if ( istrue( create ) && !function_89dc39dc11f3988c( vehicleref ) )
    {
        level.var_a0b2c978ca57ffc5[ vehicleref ] = spawnstruct();
    }
    else if ( !function_89dc39dc11f3988c( vehicleref ) )
    {
        assertex( isdefined( level.vehicle ), "vehicle_getLevelDataForVehicle called before vehicle_init." );
    }
    
    if ( function_89dc39dc11f3988c( vehicleref ) )
    {
        return function_29b4292c92443328( vehicleref );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x183c
// Size: 0xaf
function function_8497e7e46b5e397( vehicleref, callbacks )
{
    if ( isdefined( callbacks ) )
    {
        foreach ( func in callbacks )
        {
            registersharedfunc( vehicleref, key, func );
        }
    }
    
    function_35a03f008736204d( vehicleref );
    function_2ae5eae26e26efe9( vehicleref );
    
    if ( issharedfuncdefined( vehicleref, "init" ) )
    {
        [[ getsharedfunc( vehicleref, "init" ) ]]();
    }
    
    if ( issharedfuncdefined( vehicleref, "initLate" ) )
    {
        [[ getsharedfunc( vehicleref, "initLate" ) ]]();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18f3
// Size: 0xca
function private function_35a03f008736204d( vehicleref )
{
    if ( !isdefined( level.var_a0b2c978ca57ffc5 ) )
    {
        level.var_a0b2c978ca57ffc5 = [];
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        bundlename = vehicleref + "_br";
        scriptbundle = getscriptbundle( "vehiclebundle:" + bundlename );
        
        if ( !isdefined( scriptbundle ) )
        {
            bundlename = vehicleref + "_mp";
            scriptbundle = getscriptbundle( "vehiclebundle:" + bundlename );
        }
        
        level.var_a0b2c978ca57ffc5[ vehicleref ] = scriptbundle;
    }
    else
    {
        bundlename = vehicleref + ter_op( !iscp(), "_mp", "_cp" );
        level.var_a0b2c978ca57ffc5[ vehicleref ] = getscriptbundle( "vehiclebundle:" + bundlename );
    }
    
    assert( function_89dc39dc11f3988c( vehicleref ), "vehicle_registerData: Didn't find any loaded script bundles with the name: " + bundlename );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x19c5
// Size: 0x2474
function private function_2ae5eae26e26efe9( vehicleref )
{
    data = function_29b4292c92443328( vehicleref );
    
    if ( isdefined( data.pristineexplosion ) && isdefined( data.pristineexplosion.vfx ) )
    {
        level._effect[ vehicleref + "_explosion" ] = loadfx( data.pristineexplosion.vfx );
    }
    
    if ( isdefined( data.pristineexplosion ) && isdefined( data.pristineexplosion.scriptable ) && data.pristineexplosion.scriptable == "" )
    {
        data.pristineexplosion.scriptable = undefined;
    }
    
    if ( isdefined( data.huskexplosion ) && isdefined( data.huskexplosion.scriptable ) && data.huskexplosion.scriptable == "" )
    {
        data.huskexplosion.scriptable = undefined;
    }
    
    if ( istrue( data.husk.hashusk ) && isdefined( data.husk.ref ) && isdefined( data.huskexplosion ) && isdefined( data.huskexplosion.vfx ) )
    {
        level._effect[ data.husk.ref + "_explosion" ] = loadfx( data.huskexplosion.vfx );
    }
    
    if ( isdefined( data.compositemodel ) && data.compositemodel != "" )
    {
        data.model = data.compositemodel;
    }
    
    data.compositemodel = undefined;
    
    if ( isdefined( data.husk.compositemodel ) && data.husk.compositemodel != "" )
    {
        data.husk.model = data.husk.compositemodel;
    }
    
    data.husk.compositemodel = undefined;
    
    if ( isdefined( data.ai.compositemodel ) && data.ai.compositemodel != "" )
    {
        data.ai.model = data.ai.compositemodel;
    }
    
    data.ai.compositemodel = undefined;
    data.occupancy.exitoffsets = [];
    data.occupancy.exitdirections = [];
    
    foreach ( exit in data.extraexits )
    {
        data.occupancy.exitoffsets[ exit.ref ] = ( default_to( exit.offset.x, 0 ), default_to( exit.offset.y, 0 ), default_to( exit.offset.z, 0 ) );
        data.occupancy.exitdirections[ exit.ref ] = exit.direction;
    }
    
    data.extraexits = undefined;
    data.occupancy.seatdata = [];
    
    foreach ( seatdata in data.seats )
    {
        data.occupancy.seatdata[ seatdata.ref ] = seatdata;
    }
    
    data.seatswitcharray = [];
    
    foreach ( index, var_e634bc0732415d0c in data.seats )
    {
        data.seatswitcharray[ index ] = var_e634bc0732415d0c.ref;
    }
    
    data.occupancy.seatids = [];
    data.occupancy.id = data.id;
    data.id = undefined;
    
    foreach ( seatid, seatdata in data.occupancy.seatdata )
    {
        if ( seatdata.restrictions == "driver_can_fire" || seatdata.restrictions == "turret_passenger" )
        {
            seatdata.hasvehicleweapon = 1;
        }
        
        switch ( seatdata.restrictions )
        {
            case #"hash_b19724c2fdfb9d3f":
                seatdata.restrictions = vehicle_occupancy_getdriverrestrictions();
                break;
            case #"hash_bc3a9fa5d9ee1d33":
                seatdata.restrictions = function_b9cc4ad5c15d3cee();
                break;
            case #"hash_f7f9964a5172a48a":
                seatdata.restrictions = vehicle_occupancy_getcombatpassengerrestrictions();
                break;
            case #"hash_5890abf34002e520":
                seatdata.restrictions = vehicle_occupancy_getturretpassengerrestrictions();
                break;
            case #"hash_1c8b46d9f8c121d1":
                seatdata.restrictions = vehicle_occupancy_getpassivepassengerrestrictions();
                break;
        }
        
        if ( seatdata.animtag == "tag_turret" )
        {
            seatdata.animtag = undefined;
        }
        
        seatdata.seatswitcharray = vehicle_occupancy_generateseatswitcharray( seatid, data.seatswitcharray );
        seatdata.damagemodifier = default_to( seatdata.damagemodifier, 0 );
        seatdata.var_dcfc487f4ef1103c = default_to( seatdata.var_dcfc487f4ef1103c, 0 );
        
        if ( seatdata.var_dcfc487f4ef1103c < 0 )
        {
            seatdata.var_dcfc487f4ef1103c = undefined;
        }
        
        if ( isdefined( seatdata.turretweapon ) && seatdata.turretweapon != "" )
        {
            seatdata.turretobjweapon = makeweapon( seatdata.turretweapon );
        }
        
        data.occupancy.seatids[ seatid ] = default_to( seatdata.omnvarid, 0 );
    }
    
    if ( data.occupancy.roofexittype == "no_roof_exit" )
    {
        data.occupancy.roofexittype = undefined;
    }
    
    data.seats = undefined;
    data.spawn.abandonedtimeoutcallback = &vehicle_spawn_abandonedtimeoutcallback;
    
    if ( isdefined( data.mtxvehicleref ) && data.mtxvehicleref == "" )
    {
        data.mtxvehicleref = undefined;
    }
    
    foreach ( mtx in data.mtx )
    {
        if ( isdefined( mtx.var_9c6d62e1c42be80a ) && mtx.var_9c6d62e1c42be80a.size > 0 )
        {
            map = [];
            
            foreach ( camodata in mtx.var_9c6d62e1c42be80a )
            {
                map[ camodata.weapon ] = camodata.turretcamo;
            }
            
            mtx.var_9c6d62e1c42be80a = map;
            continue;
        }
        
        mtx.var_9c6d62e1c42be80a = undefined;
    }
    
    data.damage.weapon = data.weapon;
    data.damage.visualpercents = [];
    data.damage.visualcallbacks = [];
    data.damage.visualclearcallbacks = [];
    data.damage.damagestatedata = [];
    data.damage.damageableparts = [];
    vehicle_damage_registerdefaultstates( vehicleref );
    vehicle_damage_applytabletovehicle( vehicleref );
    vehicle_damage_setvehiclehitdamagedata( vehicleref, data.damage.maxhits );
    vehicle_damage_setdeathcallback( vehicleref, &vehicle_explode );
    vehicle_damage_setweaponhitdamagedata( data.damage.weapon, data.damage.explosivehitsperattack );
    function_1f39191797c711b6( vehicleref, data.damage.var_10175926aeb1591e );
    
    if ( istrue( data.husk.hashusk ) )
    {
        vehicle_damage_setvehiclehitdamagedata( data.husk.ref, data.damage.maxhits );
        
        if ( isdefined( data.husk.weapon ) )
        {
            vehicle_damage_setweaponhitdamagedata( data.husk.weapon, data.damage.explosivehitsperattack );
        }
        
        if ( !iscp() )
        {
            vehicle_damage_setdeathcallback( data.husk.ref, &vehicle_explode );
        }
    }
    else
    {
        data.huskexplosion = undefined;
    }
    
    data.interact.lights = [];
    
    foreach ( light in data.lights )
    {
        data.interact.lights[ light.tag ] = light;
    }
    
    data.lights = undefined;
    data.damage.var_9d70f02394c136da = [];
    data.damage.var_ccfde1208ef2964b = [];
    
    foreach ( damageablepartdata in data.damageableparts )
    {
        if ( !istrue( damageablepartdata.enabled ) )
        {
            continue;
        }
        
        if ( istrue( damageablepartdata.isonpristine ) )
        {
            data.damage.var_9d70f02394c136da[ damageablepartdata.scriptablepartname ] = damageablepartdata;
        }
        
        if ( istrue( damageablepartdata.isonhusk ) )
        {
            data.damage.var_ccfde1208ef2964b[ damageablepartdata.scriptablepartname ] = damageablepartdata;
        }
        
        switch ( damageablepartdata.ref )
        {
            case #"hash_30ccbada37699a25":
            case #"hash_42b5a3e3285842cd":
            case #"hash_504ea34262e6d686":
            case #"hash_5a0d6719dbc731d7":
            case #"hash_b1f7d5cd648c98d8":
            case #"hash_c0bd12509f7ca46a":
            case #"hash_e1eacaf3ea9bdac4":
            case #"hash_ef7c0c9fb26d257b":
                damageablepartdata.wheelref = function_e84a5f30606d3a09( damageablepartdata.ref, "_wheel" );
                break;
            case #"hash_299ca2ec66573f5f":
            case #"hash_3ad9dee1b2383dd0":
            case #"hash_429f675878e8e042":
            case #"hash_93cd8ed9ef8f8301":
            case #"hash_976b632eaa0990c2":
            case #"hash_aa711d7fc645b3e3":
            case #"hash_c366ad8b46c80b09":
            case #"hash_dbc0e96da272c41c":
            case #"hash_fcd5dc0af3e2a581":
                data.occupancy.hasdoors = 1;
                damageablepartdata.doorref = function_e84a5f30606d3a09( damageablepartdata.ref, "_door" );
                break;
            case #"hash_1c7226690cdd4ebb":
            case #"hash_7759f2094c4eae28":
            case #"hash_7fa614aa388c793c":
            case #"hash_84b307d5d860ef65":
            case #"hash_ccec2206c85cd572":
            case #"hash_e6e515a681eb15e5":
            case #"hash_ebde6181acd770f2":
            case #"hash_f8f7e8f9ac33a0d7":
            case #"hash_fa41893bbe9474bd":
                seatref = function_e84a5f30606d3a09( damageablepartdata.ref, "_window" );
                
                if ( isdefined( data.occupancy.seatdata[ seatref ] ) )
                {
                    data.occupancy.seatdata[ seatref ].doorwindowref = damageablepartdata.scriptablepartname;
                }
            case #"hash_a8e647d4b09dea3f":
                damageablepartdata.windowref = damageablepartdata.ref;
                break;
            case #"hash_d582c3286e5c390f":
                assert( isdefined( data.interact.lights[ damageablepartdata.scriptablepartname ] ), "vehicle_processData: Didn't find light data for the light " + damageablepartdata.ref + " on vehicle " + vehicleref );
                break;
        }
        
        damageablepartdata.ref = undefined;
        
        if ( isdefined( damageablepartdata.wheelref ) )
        {
            switch ( damageablepartdata.wheelref )
            {
                case #"hash_19baa7ca5b52f06a":
                    damageablepartdata.var_b4fccc158c681073 = &function_4b3ef3d76f7e39b6;
                    break;
                case #"hash_60b26be014fd7337":
                    damageablepartdata.var_b4fccc158c681073 = &function_d4c899afe6cbf533;
                    break;
                case #"hash_67ed6be3637f19ed":
                    damageablepartdata.var_b4fccc158c681073 = &function_1c35d2bee2c14d7b;
                    break;
                case #"hash_227fe4df4167aa26":
                    damageablepartdata.var_b4fccc158c681073 = &function_2e20b5a5d4f70228;
                    break;
                case #"hash_f0704f57a0dd2250":
                    damageablepartdata.var_b4fccc158c681073 = &function_79b9f63570444468;
                    break;
                case #"hash_cbd67f63f80e6245":
                    damageablepartdata.var_b4fccc158c681073 = &function_4c7a8d0b6c6c16cd;
                    break;
                case #"hash_711797dce2a722a3":
                    damageablepartdata.var_b4fccc158c681073 = &function_1cbe55c0515820b5;
                    break;
                case #"hash_6ade103971ce6e2c":
                    damageablepartdata.var_b4fccc158c681073 = &function_6469ea91038491e2;
                    break;
            }
        }
        
        data.damage.damageableparts[ damageablepartdata.scriptablepartname ] = damageablepartdata;
        scripts\common\vehicle::function_9039b650ffb212c8( damageablepartdata.scriptablepartname );
    }
    
    data.damageableparts = undefined;
    data.damage.frontextents = default_to( data.damage.mineextents.front, 0 );
    data.damage.backextents = default_to( data.damage.mineextents.back, 0 );
    data.damage.leftextents = default_to( data.damage.mineextents.left, 0 );
    data.damage.rightextents = default_to( data.damage.mineextents.right, 0 );
    data.damage.bottomextents = default_to( data.damage.mineextents.bottom, 0 );
    data.damage.loscheckoffset = ( default_to( data.damage.var_8e266d8413972567.x, 0 ), default_to( data.damage.var_8e266d8413972567.y, 0 ), default_to( data.damage.var_8e266d8413972567.z, 0 ) );
    data.damage.var_8e266d8413972567 = undefined;
    data.damage.mineextents = undefined;
    
    if ( istrue( data.damage.var_98277a386e38941f ) )
    {
        data.damage.explosionextents.front = default_to( data.damage.explosionextents.front, 0 );
        data.damage.explosionextents.back = default_to( data.damage.explosionextents.back, 0 );
        data.damage.explosionextents.left = default_to( data.damage.explosionextents.left, 0 );
        data.damage.explosionextents.right = default_to( data.damage.explosionextents.right, 0 );
        data.damage.explosionextents.top = default_to( data.damage.explosionextents.top, 0 );
        data.damage.explosionextents.bottom = default_to( data.damage.explosionextents.bottom, 0 );
    }
    else
    {
        data.damage.explosionextents = undefined;
    }
    
    data.occupancy.exitextents[ "front" ] = default_to( data.exitextents.front, 0 );
    data.occupancy.exitextents[ "back" ] = default_to( data.exitextents.back, 0 );
    data.occupancy.exitextents[ "left" ] = default_to( data.exitextents.left, 0 );
    data.occupancy.exitextents[ "right" ] = default_to( data.exitextents.right, 0 );
    data.occupancy.exitextents[ "top" ] = default_to( data.exitextents.top, 0 );
    data.occupancy.exitextents[ "bottom" ] = default_to( data.exitextents.bottom, 0 );
    data.exitextents = undefined;
    data.interact.interactiontypes = [];
    data.interact.pointdata = [];
    function_3e11a192d07b42ea( vehicleref, "single", data.seatswitcharray );
    level.vehicle.oob.outoftimecallbacks[ vehicleref ] = &vehicle_explode;
    data.occupancy.data = [];
    data.occupancy.rotationids = [];
    data.occupancy.warningbits = [];
    data.occupancy.warningstartcallbacks = [];
    data.occupancy.warningendcallbacks = [];
    data.occupancy.warningclearcallbacks = [];
    data.occupancy.rotationrefsbyseatandweapon = [];
    data.occupancy.warningbits[ "burningDown" ] = 1;
    data.occupancy.warningbits[ "missileLocking" ] = 2;
    data.occupancy.warningbits[ "missileIncoming" ] = 4;
    data.occupancy.warningbits[ "movementDisabled" ] = 3;
    data.occupancy.warningbits[ "outOfFuel" ] = 6;
    data.occupancy.warningbits[ "lowFuel" ] = 5;
    data.occupancy.warningbits[ "BunkerBusterAttached" ] = 7;
    data.occupancy.warningbits[ "shockStickAttached" ] = 8;
    data.occupancy.warningbits[ "DDoSed" ] = 9;
    data.occupancy.warningbits[ "locked" ] = 10;
    
    if ( utility::function_a10967d736dc56e5() && istrue( data.ai.supportsai ) )
    {
        assert( isdefined( data.ai.classname ) && data.ai.classname != "", "You must specify a classname if this vehicle supports AI: " + vehicleref );
        assert( isdefined( data.ai.vehicleanimalias ) && data.ai.vehicleanimalias != "", "You must specify a vehicleAnimAlias if this vehicle supports AI: " + vehicleref );
        unload_groups = [];
        unload_groups[ "default" ] = [];
        unload_groups[ "all" ] = [];
        
        foreach ( index, seatdata in data.aiseats )
        {
            if ( isdefined( seatdata.vehicle_getinanim ) && isdefined( seatdata.vehicle_getinanim.id ) )
            {
                seatdata.vehicle_getinanim = seatdata.vehicle_getinanim.id;
            }
            else
            {
                seatdata.vehicle_getinanim = undefined;
            }
            
            if ( isdefined( seatdata.vehicle_getoutanim ) && isdefined( seatdata.vehicle_getoutanim.id ) )
            {
                seatdata.vehicle_getoutanim = seatdata.vehicle_getoutanim.id;
            }
            else
            {
                seatdata.vehicle_getoutanim = undefined;
            }
            
            if ( isdefined( seatdata.vehicle_getoutanim_combat ) && isdefined( seatdata.vehicle_getoutanim_combat.id ) )
            {
                seatdata.vehicle_getoutanim_combat = seatdata.vehicle_getoutanim_combat.id;
            }
            else
            {
                seatdata.vehicle_getoutanim_combat = undefined;
            }
            
            if ( isdefined( seatdata.vehicle_getoutanim_combat_run ) && isdefined( seatdata.vehicle_getoutanim_combat_run.id ) )
            {
                seatdata.vehicle_getoutanim_combat_run = seatdata.vehicle_getoutanim_combat_run.id;
            }
            else
            {
                seatdata.vehicle_getoutanim_combat_run = undefined;
            }
            
            if ( isdefined( seatdata.linkoffset ) )
            {
                x = default_to( seatdata.linkoffset.x, 0 );
                y = default_to( seatdata.linkoffset.y, 0 );
                z = default_to( seatdata.linkoffset.z, 0 );
                
                if ( x != 0 || y != 0 || z != 0 )
                {
                    seatdata.linkoffset = ( x, y, z );
                }
                else
                {
                    seatdata.linkoffset = undefined;
                }
            }
            
            if ( isdefined( seatdata.linkangle ) )
            {
                pitch = default_to( seatdata.linkangle.x, 0 );
                yaw = default_to( seatdata.linkangle.y, 0 );
                roll = default_to( seatdata.linkangle.z, 0 );
                
                if ( pitch != 0 || yaw != 0 || roll != 0 )
                {
                    seatdata.linkangle = ( pitch, yaw, roll );
                }
                else
                {
                    seatdata.linkangle = undefined;
                }
            }
            
            if ( isdefined( seatdata.linkoffset ) && !isdefined( seatdata.linkangle ) )
            {
                seatdata.linkangle = ( 0, 0, 0 );
            }
            
            if ( isdefined( data.aianimations ) && isdefined( data.aianimations[ index ] ) )
            {
                animationdata = data.aianimations[ index ];
                
                if ( isdefined( animationdata.idle ) && isdefined( animationdata.idle.id ) )
                {
                    seatdata.idle = animationdata.idle.id;
                }
                
                if ( isdefined( animationdata.getin ) && isdefined( animationdata.getin.id ) )
                {
                    seatdata.getin = animationdata.getin.id;
                }
                
                if ( isdefined( animationdata.getout ) && isdefined( animationdata.getout.id ) )
                {
                    seatdata.getout = animationdata.getout.id;
                }
                
                if ( isdefined( animationdata.death ) && isdefined( animationdata.death.id ) )
                {
                    seatdata.death = animationdata.death.id;
                }
                
                if ( isdefined( animationdata.ragdoll_fall_anim ) && isdefined( animationdata.ragdoll_fall_anim.id ) )
                {
                    seatdata.ragdoll_fall_anim = animationdata.ragdoll_fall_anim.id;
                }
                
                if ( isdefined( animationdata.idle_anim ) && animationdata.idle_anim != "" )
                {
                    seatdata.idle_anim = animationdata.idle_anim;
                }
            }
            
            if ( !istrue( seatdata.do_not_unload ) )
            {
                unload_groups[ "default" ][ unload_groups[ "default" ].size ] = index;
                unload_groups[ "all" ][ unload_groups[ "all" ].size ] = index;
            }
        }
        
        foreach ( extraunloadgroup in data.unloadgroups )
        {
            unload_groups[ extraunloadgroup.name ] = [];
            
            foreach ( index, seatdata in extraunloadgroup.seats )
            {
                unload_groups[ extraunloadgroup.name ][ unload_groups[ extraunloadgroup.name ].size ] = seatdata.seatindex;
            }
        }
        
        data.unloadgroups = undefined;
        data.aianimations = undefined;
        var_5dec33f9548f94d6 = [];
        
        if ( isdefined( data.aifastrope ) )
        {
            foreach ( ropedata in data.aifastrope )
            {
                var_5dec33f9548f94d6[ ropedata.fastroperigindex ] = spawnstruct();
                
                if ( isdefined( ropedata.model ) )
                {
                    var_5dec33f9548f94d6[ ropedata.fastroperigindex ].model = ropedata.model;
                }
                
                if ( isdefined( ropedata.tag ) )
                {
                    var_5dec33f9548f94d6[ ropedata.fastroperigindex ].tag = ropedata.tag;
                }
                
                if ( isdefined( ropedata.idleanim ) && isdefined( ropedata.idleanim.id ) )
                {
                    var_5dec33f9548f94d6[ ropedata.fastroperigindex ].idleanim = ropedata.idleanim.id;
                }
                
                if ( isdefined( ropedata.dropanim ) && isdefined( ropedata.dropanim.id ) )
                {
                    var_5dec33f9548f94d6[ ropedata.fastroperigindex ].dropanim = ropedata.dropanim.id;
                }
                
                if ( isdefined( ropedata.dropusestraceorigin ) )
                {
                    var_5dec33f9548f94d6[ ropedata.fastroperigindex ].dropusestraceorigin = ropedata.dropusestraceorigin;
                }
            }
        }
        
        data.aifastrope = undefined;
        scripts\common\vehicle_build::build_template( data.ai.templateclass, data.model, data.vehicle, data.ai.classname );
        scripts\common\vehicle_build::assign_aianims( data.aiseats, data.ai.vehicleanimalias );
        scripts\common\vehicle_build::function_ab7252da140c8fe7( unload_groups );
        
        if ( var_5dec33f9548f94d6.size > 0 )
        {
            scripts\common\vehicle_build::function_423e10816a23372f( var_5dec33f9548f94d6 );
        }
    }
    
    if ( istrue( data.airdrop.var_e01db00d1ccb42ea ) )
    {
        effect = loadfx( data.airdrop.vfx );
        level._effect[ vehicleref + "_land" ] = effect;
        data.airdrop.effect = effect;
        data.airdrop.scenename = vehicleref + "_drop";
        level.scr_animtree[ "ac130" ] = data.airdrop.planeanim.animtree.id;
        level.scr_anim[ "ac130" ][ data.airdrop.scenename ] = data.airdrop.planeanim.animname.id;
        level.scr_animtree[ "parachute" ] = data.airdrop.parachuteanim.animtree.id;
        level.scr_anim[ "parachute" ][ data.airdrop.scenename ] = data.airdrop.parachuteanim.animname.id;
        level.scr_animtree[ vehicleref ] = data.airdrop.vehiclemodelanim.animtree.id;
        level.scr_anim[ vehicleref ][ data.airdrop.scenename ] = data.airdrop.vehiclemodelanim.animname.id;
        
        if ( isdefined( data.airdrop.realvehicleanim ) && isdefined( data.airdrop.realvehicleanim.animname ) && isdefined( data.airdrop.realvehicleanim.animname.id ) )
        {
            data.airdrop.var_150b11a4da8461bc = vehicleref + "_follow_up";
            level.scr_anim[ vehicleref ][ data.airdrop.var_150b11a4da8461bc ] = data.airdrop.realvehicleanim.animname.id;
        }
        
        data.airdrop.planeanim = undefined;
        data.airdrop.parachuteanim = undefined;
        data.airdrop.vehiclemodelanim = undefined;
        data.airdrop.realvehicleanim = undefined;
        return;
    }
    
    data.airdrop = undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x3e41
// Size: 0x32
function function_29b4292c92443328( vehicleref )
{
    if ( function_89dc39dc11f3988c( vehicleref ) )
    {
        return level.var_a0b2c978ca57ffc5[ vehicleref ];
    }
    
    assertmsg( "vehicle_getData: Attempted to get script bundle data for a vehicle that doesn't have it registered" );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x3e7b
// Size: 0x25, Type: bool
function function_89dc39dc11f3988c( vehicleref )
{
    return isdefined( level.var_a0b2c978ca57ffc5 ) && isdefined( level.var_a0b2c978ca57ffc5[ vehicleref ] );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x3ea9
// Size: 0x12, Type: bool
function function_fa537f1ab52a76d1( vehicleref )
{
    return function_89dc39dc11f3988c( vehicleref );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 4
// Checksum 0x0, Offset: 0x3ec4
// Size: 0x51
function vehicle_spawn( vehicleref, spawndata, faildata, vehicle )
{
    if ( issharedfuncdefined( vehicleref, "spawn" ) )
    {
        return [[ getsharedfunc( vehicleref, "spawn" ) ]]( spawndata, faildata );
    }
    
    return function_bba34cf920370ff4( vehicleref, spawndata, faildata, vehicle );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 4
// Checksum 0x0, Offset: 0x3f1d
// Size: 0x22e
function function_bba34cf920370ff4( vehicleref, spawndata, faildata, vehicle )
{
    if ( !function_fa537f1ab52a76d1( vehicleref ) )
    {
        /#
            if ( istrue( level.debugvehiclespawns ) )
            {
                println( "<dev string:xaf>" + vehicleref );
            }
        #/
        
        return undefined;
    }
    else
    {
        /#
            if ( istrue( level.debugvehiclespawns ) )
            {
                println( "<dev string:xdc>" + vehicleref );
            }
        #/
    }
    
    vehicledata = function_29b4292c92443328( vehicleref );
    spawndata = function_37480e9c9c701cf2( vehicleref, spawndata );
    
    if ( isdefined( vehicle ) )
    {
        vehicle.targetname = spawndata.targetname;
        spawndata.vehicletype = vehicle.vehicletype;
        vehicle.spawndata = spawndata;
    }
    else
    {
        vehicle = _spawnvehicle( spawndata, faildata );
        
        if ( !isdefined( vehicle ) )
        {
            return undefined;
        }
    }
    
    vehicle_create( vehicle, vehicleref, spawndata );
    vehicle.objweapon = makeweapon( function_7aaa7ae503292f43( vehicleref ) );
    vehicle_compass_registerinstance( vehicle );
    vehicle_createlate( vehicle, spawndata );
    vehicle thread function_4a387c035eb677d0( istrue( vehicledata.isboat ) );
    
    if ( !istrue( vehicledata.interact.var_c57febc7e53e3276 ) )
    {
        vehicle thread vehicle_watchflipped();
    }
    
    vehicle thread scripts\common\vehicle_code::function_c2b5282b537a56bc();
    
    if ( istrue( vehicledata.isboat ) )
    {
        vehicle function_481c2a63f2ba3332( -1, default_to( level.var_df44f8cc05382071, 100 ) );
    }
    else if ( !vehicle function_784f000d59e38105() )
    {
        vehicle thread function_1b69321ff9937fc5();
    }
    
    if ( issharedfuncdefined( vehicleref, "create" ) )
    {
        [[ getsharedfunc( vehicleref, "create" ) ]]( vehicle );
    }
    
    if ( utility::function_a10967d736dc56e5() && istrue( vehicledata.ai.supportsai ) && istrue( spawndata.initai ) )
    {
        vehicle function_810dfd134e9a7a04( vehicledata );
    }
    
    /#
        if ( istrue( level.debugvehiclespawns ) )
        {
            println( "<dev string:x107>" + vehicleref );
        }
    #/
    
    if ( issharedfuncdefined( vehicleref, "onStartRiding" ) && issharedfuncdefined( vehicleref, "onEndRiding" ) )
    {
        vehicle thread function_34d70aa8129b0d74();
    }
    
    return vehicle;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 6
// Checksum 0x0, Offset: 0x4154
// Size: 0x2f2
function function_fffe750fce66784( vehicleref, spawndata, faildata, fallbackvehicletype, donotwatchabandoned, mtx )
{
    if ( !function_fa537f1ab52a76d1( vehicleref ) || !istrue( function_29b4292c92443328( vehicleref ).husk.hashusk ) )
    {
        return undefined;
    }
    
    data = function_29b4292c92443328( vehicleref );
    huskref = data.husk.ref;
    spawndata = function_1cc780d5cac1e7cd( vehicleref, spawndata, fallbackvehicletype );
    husk = _spawnvehicle( spawndata, faildata );
    
    if ( !isdefined( husk ) )
    {
        return undefined;
    }
    
    husk.isvehiclehusk = 1;
    husk.pristineref = vehicleref;
    vehicle_create( husk, huskref, spawndata );
    husk.objweapon = makeweapon( function_6c17abf5c5d88ca( vehicleref ) );
    husk.basevehiclespawndata = spawndata.basevehiclespawndata;
    vehicle_createlate( husk, spawndata );
    
    if ( issharedfuncdefined( huskref, "create" ) )
    {
        [[ getsharedfunc( huskref, "create" ) ]]( husk );
    }
    
    husk thread vehicle_spawn_watchabandoned();
    transitionscriptableparts = function_89cda5ba9bfc8d56( vehicleref );
    mtxtransitionstate = undefined;
    
    if ( isdefined( mtx ) )
    {
        husk.mtx = mtx;
        
        if ( isdefined( mtx.var_c3606975ab404c5c ) && mtx.var_c3606975ab404c5c != "" )
        {
            mtxtransitionstate = mtx.var_c3606975ab404c5c;
        }
    }
    
    if ( isdefined( transitionscriptableparts ) )
    {
        foreach ( struct in transitionscriptableparts )
        {
            if ( isdefined( mtxtransitionstate ) && husk getscriptableparthasstate( struct.var_1fb6b56a662df98, mtxtransitionstate ) )
            {
                husk setscriptablepartstate( struct.var_1fb6b56a662df98, mtxtransitionstate );
                continue;
            }
            
            husk setscriptablepartstate( struct.var_1fb6b56a662df98, "on" );
        }
    }
    
    vdef = function_aade62c6cf163888( vehicleref );
    
    if ( isdefined( vdef ) )
    {
        husk setdeffile( vdef );
    }
    
    husk function_cf63db12f07abf78( vehicleref, husk.damageableparts );
    husk scripts\common\vehicle_code::vehicle_husklaunch( undefined, vehicleref, spawndata, data.damage.huskforcemultiplier );
    husk VehicleUnpingable( 1 );
    husk vehicleshowonminimap( 0 );
    
    if ( husk vehicle_isphysveh() )
    {
        husk vehphys_crash();
        
        if ( !husk scripts\cp_mp\vehicles\vehicle::isvehicleboat() && husk vehphys_isgroundvehicle() )
        {
            husk function_b0af0dd0f9b4fddf( 0 );
        }
    }
    else
    {
        husk scripts\cp_mp\vehicles\vehicle_occupancy::function_887b4e2cbe3ab92c();
    }
    
    return husk;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x444f
// Size: 0x2d
function function_d93ec4635290febd()
{
    assert( isvehicle() );
    
    if ( isvehiclehusk() )
    {
        return self.pristineref;
    }
    
    return self.vehiclename;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x4485
// Size: 0x1e
function function_9005b7fc076293f8()
{
    if ( isdefined( level.var_a0b2c978ca57ffc5 ) )
    {
        return getarraykeys( level.var_a0b2c978ca57ffc5 );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 3
// Checksum 0x0, Offset: 0x44ab
// Size: 0x3af
function vehicle_create( vehicle, vehicleref, spawndata )
{
    vehicle.vehiclename = vehicleref;
    vehicle.maxhealth = default_to( scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle, vehicleref ), 2147483647 );
    vehicle.health = vehicle.maxhealth;
    vehicle.preventrespawn = spawndata.preventrespawn;
    vehicle setnodeploy( 1 );
    vehicle makeunusable();
    vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_887b4e2cbe3ab92c();
    
    if ( !vehicle isvehiclehusk() )
    {
        vehicledata = function_29b4292c92443328( vehicleref );
        
        if ( istrue( vehicledata.canfly ) )
        {
            vehicle.isheli = 1;
        }
        
        vehicle scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_78fa8a2ff553f7c8 );
        vehicle scripts\cp_mp\equipment\haywire::function_aa823a31304ed981( &function_b92c4e2d8733661 );
        vehicle scripts\cp_mp\emp_debuff::set_start_emp_callback( &vehicle_empstartcallback );
        vehicle scripts\cp_mp\emp_debuff::set_clear_emp_callback( &vehicle_empclearcallback );
    }
    
    if ( vehicle vehicle_isphysveh() )
    {
        vehicle function_9a5e0e2d6d715bb1( !vehicle isvehiclehusk() && istrue( vehicledata.interact.var_18f075aaf63a3da ) );
    }
    
    if ( !istrue( spawndata.initai ) && vehicle vehicle_isphysveh() && vehicle vehphys_isgroundvehicle() )
    {
        vehicle vehphys_parkingbrake( 1 );
    }
    
    if ( isdefined( spawndata.owner ) )
    {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setoriginalowner( vehicle, spawndata.owner );
    }
    
    if ( isdefined( spawndata.team ) )
    {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( vehicle, spawndata.team );
    }
    else
    {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( vehicle, "neutral" );
    }
    
    if ( isdefined( spawndata.mtx ) )
    {
        scripts\cp_mp\vehicles\vehicle::function_4201160d49c885a7( vehicle, function_19d89390ee87e7c2( vehicleref, spawndata.mtx ) );
    }
    
    scripts\cp_mp\utility\weapon_utility::setlockedoncallback( vehicle, &vehicle_lockedoncallback );
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback( vehicle, &vehicle_lockedonremovedcallback );
    scripts\cp_mp\utility\weapon_utility::setincomingcallback( vehicle, &vehicle_incomingcallback );
    scripts\cp_mp\utility\weapon_utility::setincomingremovedcallback( vehicle, &vehicle_incomingremovedcallback );
    scripts\cp_mp\utility\weapon_utility::function_53fd22613ea65204( vehicle, &function_a2d1400bcf46869a );
    scripts\cp_mp\utility\weapon_utility::function_b55a664e824540d2( vehicle, &function_a2d1400bcf46869a );
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance( vehicle );
    scripts\cp_mp\vehicles\vehicle_interact::function_a203f8033eeb57f1( vehicleref, vehicle );
    vehicle scripts\engine\flags::assign_unique_id();
    var_620e3a366fb95fcf = isdefined( level.var_620e3a366fb95fcf ) && level.var_620e3a366fb95fcf;
    var_b6ffe24870282af2 = isdefined( vehicle.spawndata.var_b6ffe24870282af2 ) && vehicle.spawndata.var_b6ffe24870282af2;
    
    if ( ( function_a10967d736dc56e5() || isnavmeshloaded() ) && !var_620e3a366fb95fcf && !var_b6ffe24870282af2 )
    {
        if ( istrue( vehicle.isheli ) && !istrue( spawndata.initai ) )
        {
            vehicle thread scripts\common\vehicle_code::vehicle_ai_avoidance_heli();
        }
        else if ( !istrue( vehicle.isheli ) )
        {
            vehicle thread scripts\common\vehicle_code::vehicle_ai_avoidance_logic();
        }
    }
    
    if ( ( !iscp() || !istrue( spawndata.disableusabilityatspawn ) ) && !vehicle isvehiclehusk() )
    {
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance( vehicle );
    }
    
    callsharedfunc( "vehicle", "create", vehicle, spawndata );
    
    /#
        callsharedfunc( "<dev string:x133>", "<dev string:x13b>", spawndata.vehicletype, vehicleref, undefined, spawndata.modelname, spawndata.targetname, undefined, undefined, spawndata.origin );
    #/
    
    thread vehicle_update( vehicle );
    thread scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_updateinstance( vehicle );
    
    /#
        if ( getdvarint( @"hash_9824088677b15053", 0 ) == 1 )
        {
            vehicle thread function_b4896044b6e0d565();
        }
    #/
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x4862
// Size: 0x7f
function vehicle_createlate( vehicle, spawndata )
{
    vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 1 );
    scripts\cp_mp\vehicles\vehicle_damage::function_268e0e5863858dcf( vehicle, spawndata );
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance( vehicle, spawndata.owner, spawndata.team );
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent( vehicle, spawndata.spawntype );
    
    if ( issharedfuncdefined( "vehicle", "createLate" ) )
    {
        [[ getsharedfunc( "vehicle", "createLate" ) ]]( vehicle, spawndata );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x48e9
// Size: 0x64
function vehicle_explode( data, immediate )
{
    if ( issharedfuncdefined( self.vehiclename, "explode" ) )
    {
        [[ getsharedfunc( self.vehiclename, "explode" ) ]]( data, immediate );
        return;
    }
    
    if ( isvehiclehusk() )
    {
        function_e3ff0a92ad2bf58d( data, immediate );
        return;
    }
    
    function_9672da471530b44a( data, immediate );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x4955
// Size: 0x5c
function function_f7af4d1c91ca6e2f()
{
    self removecomponent( "p2p" );
    self vehicle_cleardrivingstate();
    self function_247ad6a91f6a4ffe( 0 );
    
    while ( true )
    {
        self waittill( "damage", amount, attacker );
        
        if ( isplayer( attacker ) )
        {
            continue;
        }
        
        break;
    }
    
    vehicle_explode( undefined, 1 );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x49b9
// Size: 0x41
function function_e3ff0a92ad2bf58d( data, immediate )
{
    vehicle_damage_clearvisuals( undefined, undefined, 1 );
    self setscriptablepartstate( "visibility", "hide", 0 );
    thread vehicle_death( self );
    thread function_d0df49de517ded03();
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x4a02
// Size: 0x10d
function function_9672da471530b44a( data, immediate )
{
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
        data.inflictor = self;
        data.objweapon = function_7aaa7ae503292f43( self.vehiclename );
        data.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    vehicle_damage_ondeathscore( data );
    function_afe012d734bd72c7( data );
    vehicle_occupancy_killoccupants( self, data );
    thread vehicle_death( self, data );
    thread function_d0df49de517ded03();
    
    if ( isdefined( data.attacker ) )
    {
        bctypename = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( function_d93ec4635290febd() ).bctypename;
        
        if ( !isdefined( bctypename ) || bctypename == "" )
        {
            bctypename = "generic";
        }
        
        if ( issharedfuncdefined( "sound", "trySayLocalSound" ) )
        {
            level thread [[ getsharedfunc( "sound", "trySayLocalSound" ) ]]( data.attacker, hashcat( #"hash_748c50aa6182ec4b", bctypename ) );
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x4b17
// Size: 0x327
function vehicle_death( vehicle, damagedata )
{
    vehicleref = vehicle function_d93ec4635290febd();
    hashusk = istrue( function_29b4292c92443328( vehicleref ).husk.hashusk );
    
    if ( vehicle isvehiclehusk() )
    {
        scripts\cp_mp\vehicles\vehicle_damage::function_ec4b6f058d183338( vehicle );
    }
    
    fallbackvehicletype = vehicle.vehicletype;
    mtx = vehicle.mtx;
    killer = undefined;
    
    if ( isdefined( damagedata ) )
    {
        killer = damagedata.attacker;
    }
    
    vehicle vehicle_deletenextframe( vehicle, killer );
    
    if ( issharedfuncdefined( vehicleref, "delete" ) )
    {
        vehicle [[ getsharedfunc( vehicleref, "delete" ) ]]( vehicle );
    }
    
    if ( issharedfuncdefined( vehicleref, "onEndRiding" ) && isdefined( vehicle.ridingplayers ) )
    {
        onendriding = getsharedfunc( vehicleref, "onEndRiding" );
        
        foreach ( player in vehicle.ridingplayers )
        {
            if ( isdefined( player ) )
            {
                vehicle [[ onendriding ]]( player );
            }
        }
    }
    
    oldspawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( vehicle );
    
    if ( isdefined( oldspawndata ) && istrue( oldspawndata.initai ) )
    {
        if ( isdefined( self.riders ) )
        {
            foreach ( g in self.riders )
            {
                if ( isdefined( damagedata ) && isdefined( damagedata.attacker ) && isplayer( damagedata.attacker ) )
                {
                    scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata( g, "vehicleKiller", damagedata.attacker );
                    damagedata.attacker thread namespace_53fc9ddbb516e6e1::doscoreeventsharedfunc( #"kill", damagedata.objweapon, undefined, undefined, g, undefined, undefined, 1, undefined, 1 );
                }
            }
        }
        
        vehicle scripts\common\vehicle_paths::delete_riders();
    }
    
    waitframe();
    spawndata = undefined;
    
    if ( hashusk && !istrue( vehicle.dontspawnhusk ) )
    {
        spawndata = vehicle function_75ce57f81b582b38( vehicle, vehicleref );
    }
    
    vehicle vehicle_deletenextframelate( vehicle );
    husk = undefined;
    
    if ( !vehicle isvehiclehusk() && hashusk && !istrue( vehicle.dontspawnhusk ) )
    {
        husk = function_fffe750fce66784( vehicleref, spawndata, undefined, fallbackvehicletype, vehicle.donotwatchabandoned, mtx );
    }
    
    if ( isdefined( husk ) )
    {
        oldspawndata notify( "husk_spawn", husk );
    }
    else
    {
        oldspawndata notify( "husk_failed" );
    }
    
    if ( isdefined( vehicle.reactivearmorexplosion ) )
    {
        vehicle.reactivearmorexplosion delete();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x4e46
// Size: 0x46
function function_12f5a0e2344c10c5()
{
    assert( isdefined( self ) && isdefined( self.spawndata ) );
    self.spawndata endon( "husk_failed" );
    self.spawndata waittill( "husk_spawn", husk );
    return husk;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x4e95
// Size: 0x21f
function vehicle_deletenextframe( vehicle, killer )
{
    if ( istrue( vehicle.isdestroyed ) )
    {
        return;
    }
    
    vehicle notify( "death", killer );
    vehicle.isdestroyed = 1;
    deploystatus = getdvarint( @"hash_6f41bda368c6075f", 0 );
    
    if ( deploystatus )
    {
        if ( isdefined( vehicle.linkedturrets ) )
        {
            foreach ( turret in vehicle.linkedturrets )
            {
                if ( isdefined( turret ) )
                {
                    turret unlink();
                    turret notify( "kill_turret" );
                }
            }
            
            vehicle.linkedturrets = undefined;
        }
    }
    
    if ( vehicle_spawn_gamemodesupportsrespawn() && !istrue( vehicle.preventrespawn ) )
    {
        ref = vehicle function_d93ec4635290febd();
        hashusk = istrue( function_29b4292c92443328( ref ).husk.hashusk );
        
        if ( ( vehicle isvehiclehusk() || !hashusk || istrue( vehicle.dontspawnhusk ) ) && issharedfuncdefined( ref, "onDeathRespawn" ) )
        {
            vehicle thread [[ getsharedfunc( ref, "onDeathRespawn" ) ]]();
        }
        else if ( vehicle isvehiclehusk() )
        {
            vehicle thread function_fa044e2304e9e1a4();
        }
        else if ( !hashusk || istrue( vehicle.dontspawnhusk ) )
        {
            vehicle thread function_284795e4a9e3762c();
        }
    }
    
    vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
    vehicle setnonstick( 1 );
    scripts\cp_mp\utility\weapon_utility::clearlockedon( vehicle );
    vehicle scripts\cp_mp\emp_debuff::clear_emp( 1 );
    scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_hide( vehicle );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_deregisterinstance( vehicle );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance( vehicle );
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance( vehicle );
    scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_stopbattletrackstoalloccupants( vehicle );
    
    if ( issharedfuncdefined( "vehicle", "deleteNextFrame" ) )
    {
        [[ getsharedfunc( "vehicle", "deleteNextFrame" ) ]]( vehicle );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x50bc
// Size: 0xa7
function vehicle_deletenextframelate( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance( vehicle );
    
    if ( issharedfuncdefined( "vehicle", "deleteNextFrameLate" ) )
    {
        [[ getsharedfunc( "vehicle", "deleteNextFrameLate" ) ]]( vehicle );
    }
    
    turrets = vehicle_getturrets( vehicle );
    
    if ( isdefined( turrets ) )
    {
        foreach ( turret in turrets )
        {
            turret delete();
        }
    }
    
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle( vehicle );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x516b
// Size: 0x92
function function_afe012d734bd72c7( data )
{
    vehicleref = function_d93ec4635290febd();
    
    if ( isdefined( vehicleref ) && isdefined( data ) )
    {
        vehicledata = vehicle_damage_getleveldataforvehicle( vehicleref );
        
        if ( isdefined( vehicledata ) && isdefined( vehicledata.scrapassist ) && istrue( vehicledata.scrapassist ) && issharedfuncdefined( "killstreak", "processScrapAssist" ) )
        {
            self thread [[ getsharedfunc( "killstreak", "processScrapAssist" ) ]]( data.attacker );
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x5205
// Size: 0x187
function vehicle_update( vehicle )
{
    vehicle notify( "vehicle_update" );
    vehicle endon( "vehicle_update" );
    level endon( "game_ended" );
    
    /#
        namespace_7f5956e577370452::function_82b422f2ec92a2b7( vehicle.vehiclename, vehicle );
    #/
    
    if ( vehicle isvehiclehusk() )
    {
        return;
    }
    
    var_bd169af9b46727ef = istrue( scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle( vehicle function_d93ec4635290febd() ).var_bd169af9b46727ef );
    hastrailvfx = isdefined( vehicle.mtx ) && isdefined( vehicle.mtx.vehicletrail ) && vehicle.mtx.vehicletrail != "";
    canfly = vehicle scripts\cp_mp\vehicles\vehicle::vehiclecanfly();
    hasupdatefunc = issharedfuncdefined( vehicle.vehiclename, "update" );
    updatefunc = undefined;
    
    if ( hasupdatefunc )
    {
        updatefunc = getsharedfunc( vehicle.vehiclename, "update" );
    }
    
    if ( !var_bd169af9b46727ef && !hastrailvfx && !hasupdatefunc )
    {
        return;
    }
    
    while ( isdefined( vehicle ) && !istrue( vehicle.isdestroyed ) )
    {
        if ( var_bd169af9b46727ef )
        {
            scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsperframe( vehicle );
        }
        
        if ( hastrailvfx )
        {
            hastrailvfx = vehicle_checktrailvfx( vehicle, canfly );
            
            if ( !hastrailvfx && !var_bd169af9b46727ef && !hasupdatefunc )
            {
                return;
            }
        }
        
        if ( hasupdatefunc )
        {
            data = spawnstruct();
            vehicle [[ updatefunc ]]( data );
        }
        
        waitframe();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x5394
// Size: 0x1a4, Type: bool
function vehicle_checktrailvfx( vehicle, canfly )
{
    assert( isdefined( vehicle.mtx ) && isdefined( vehicle.mtx.vehicletrail ) );
    trail = vehicle.mtx.vehicletrail;
    
    if ( isdefined( vehicle.mtx.var_87cc39e9260d5bcf ) )
    {
        var_3dacbf7b6cb2caf5 = vehicle.mtx.var_87cc39e9260d5bcf;
    }
    else
    {
        var_3dacbf7b6cb2caf5 = 1;
    }
    
    if ( isdefined( vehicle.velocity ) )
    {
        velocity = vehicle.velocity;
        speed = length( vehicle.velocity );
    }
    else
    {
        velocity = vehicle vehicle_getvelocity();
        speed = vehicle vehicle_getspeed();
    }
    
    forward = anglestoforward( vehicle.angles );
    state = vehicle getscriptablepartstate( "trail" );
    
    if ( state == "disabled" )
    {
        return false;
    }
    
    if ( canfly && isdefined( vehicle_occupancy_getdriver( vehicle ) ) )
    {
        newstate = trail;
    }
    else if ( speed > var_3dacbf7b6cb2caf5 && vectordot( velocity, forward ) >= 0 )
    {
        newstate = trail;
    }
    else
    {
        newstate = trail + "_idle";
    }
    
    if ( state == newstate )
    {
        return true;
    }
    
    if ( vehicle getscriptableparthasstate( "trail", newstate ) )
    {
        vehicle setscriptablepartstate( "trail", newstate );
    }
    
    return true;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 4
// Checksum 0x0, Offset: 0x5541
// Size: 0xe6
function vehicle_registerturret( vehicle, entity, objweapon, isprojectile )
{
    if ( !isdefined( entity.objweapon ) )
    {
        entity.objweapon = objweapon;
    }
    
    if ( !isdefined( vehicle.turrets ) )
    {
        vehicle.turrets = [];
    }
    
    weaponname = undefined;
    
    if ( isstring( objweapon ) )
    {
        weaponname = objweapon;
    }
    else
    {
        weaponname = objweapon.basename;
    }
    
    vehicle.turrets[ weaponname ] = entity;
    childoutlineents = vehicle.childoutlineents;
    
    if ( !isdefined( childoutlineents ) )
    {
        childoutlineents = [ vehicle ];
    }
    
    if ( !array_contains( childoutlineents, entity ) )
    {
        childoutlineents = array_add( childoutlineents, entity );
    }
    
    vehicle.childoutlineents = childoutlineents;
    
    if ( istrue( isprojectile ) )
    {
        thread vehicle_trackturretprojectile( vehicle, entity );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x562f
// Size: 0xaf
function vehicle_deregisterturret( vehicle, objweapon )
{
    if ( !isdefined( vehicle.turrets ) )
    {
        return;
    }
    
    weaponname = undefined;
    
    if ( isstring( objweapon ) )
    {
        weaponname = objweapon;
    }
    else
    {
        weaponname = objweapon.basename;
    }
    
    entity = vehicle.turrets[ weaponname ];
    vehicle.turrets[ weaponname ] = undefined;
    
    if ( isdefined( entity ) )
    {
        childoutlineents = vehicle.childoutlineents;
        
        if ( isdefined( childoutlineents ) )
        {
            childoutlineents = array_remove( childoutlineents, entity );
            vehicle.childoutlineents = childoutlineents;
        }
        
        entity notify( "vehicle_trackTurretProjectile" );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x56e6
// Size: 0x59
function vehicle_getturretbyweapon( vehicle, objweapon )
{
    if ( !isdefined( vehicle.turrets ) )
    {
        return undefined;
    }
    
    weaponname = undefined;
    
    if ( isstring( objweapon ) )
    {
        weaponname = objweapon;
    }
    else
    {
        weaponname = objweapon.basename;
    }
    
    return vehicle.turrets[ weaponname ];
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x5748
// Size: 0x34
function vehicle_getturrets( vehicle )
{
    turrets = [];
    
    if ( isdefined( vehicle.turrets ) )
    {
        turrets = vehicle.turrets;
    }
    
    return turrets;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x5785
// Size: 0x56
function vehicle_trackturretprojectile( vehicle, entity )
{
    entity endon( "death" );
    entity notify( "vehicle_trackTurretProjectile" );
    entity endon( "vehicle_trackTurretProjectile" );
    
    while ( true )
    {
        entity waittill( "missile_fire", missile );
        
        if ( isdefined( missile ) )
        {
            missile.vehicle = vehicle;
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x57e3
// Size: 0xcc
function vehicle_isfriendlytoplayer( vehicle, player )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( vehicle ) )
    {
        return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isfriendlytoplayer( vehicle, player );
    }
    
    if ( level.teambased )
    {
        team = vehicle.team;
        
        if ( !isdefined( team ) || team == "neutral" )
        {
            if ( isdefined( vehicle.owner ) )
            {
                vehicle.team = vehicle.owner.team;
            }
        }
        
        if ( !isdefined( team ) )
        {
            return 0;
        }
        
        return ( vehicle.team == player.team );
    }
    
    return isdefined( vehicle.owner ) && vehicle.owner == player;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x58b7
// Size: 0xcc
function vehicle_isenemytoplayer( vehicle, player )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( vehicle ) )
    {
        return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isenemytoplayer( vehicle, player );
    }
    
    if ( level.teambased )
    {
        team = vehicle.team;
        
        if ( !isdefined( team ) || team == "neutral" )
        {
            if ( isdefined( vehicle.owner ) )
            {
                vehicle.team = vehicle.owner.team;
            }
        }
        
        if ( !isdefined( team ) )
        {
            return 0;
        }
        
        return ( vehicle.team != player.team );
    }
    
    return isdefined( vehicle.owner ) && vehicle.owner != player;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x598b
// Size: 0x79
function vehicle_isneutraltoplayer( vehicle, player )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( vehicle ) )
    {
        return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isneutraltoplayer( vehicle, player );
    }
    
    if ( level.teambased )
    {
        return ( ( !isdefined( vehicle.team ) || vehicle.team == "neutral" ) && !isdefined( vehicle.owner ) );
    }
    
    return !isdefined( vehicle.owner );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x5a0c
// Size: 0x55
function vehicle_isfriendlytoteam( vehicle, team )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( vehicle ) )
    {
        return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isfriendlytoteam( vehicle, team );
    }
    
    if ( level.teambased )
    {
        return ( isdefined( vehicle.team ) && vehicle.team == team );
    }
    
    return undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x5a69
// Size: 0x55
function vehicle_isenemytoteam( vehicle, team )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( vehicle ) )
    {
        return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isenemytoteam( vehicle, team );
    }
    
    if ( level.teambased )
    {
        return ( isdefined( vehicle.team ) && vehicle.team != team );
    }
    
    return undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x5ac6
// Size: 0x5a
function vehicle_isneutraltoteam( vehicle, team )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( vehicle ) )
    {
        return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isneutraltoteam( vehicle, team );
    }
    
    if ( level.teambased )
    {
        return ( !isdefined( vehicle.team ) || vehicle.team == "neutral" );
    }
    
    return undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x5b28
// Size: 0x52
function vehicle_getteamfriendlyto( vehicle )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( vehicle ) )
    {
        return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto( vehicle );
    }
    
    if ( isdefined( vehicle.team ) && vehicle.team != "neutral" )
    {
        return vehicle.team;
    }
    
    return undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 3
// Checksum 0x0, Offset: 0x5b82
// Size: 0x13a, Type: bool
function vehicle_docollisiondamagetoplayer( vehicle, player, force )
{
    isenemy = vehicle_occupancy_isenemytoplayer( vehicle, player );
    
    if ( istrue( force ) || isenemy )
    {
        playerwasinlaststand = istrue( player.inlaststand );
        var_fcdf19e3cdd29669 = player.health;
        
        if ( isdefined( vehicle.objweapon ) )
        {
            level.overrideobituarymod = "MOD_EXPLOSIVE";
        }
        
        attacker = undefined;
        
        if ( !isenemy )
        {
            attacker = player;
        }
        else if ( isdefined( vehicle.streakinfo ) )
        {
            attacker = default_to( vehicle.owner, player );
        }
        else
        {
            attacker = default_to( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( vehicle ), player );
        }
        
        player dodamage( 1000, vehicle.origin, attacker, vehicle, "MOD_CRUSH", vehicle.objweapon );
        level.overrideobituarymod = undefined;
        
        if ( !isalive( player ) )
        {
            return true;
        }
        
        if ( !playerwasinlaststand && istrue( player.inlaststand ) )
        {
            return true;
        }
        
        if ( var_fcdf19e3cdd29669 > player.health )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x5cc5
// Size: 0x71
function vehicle_preventplayercollisiondamagefortimeafterexit( vehicle, player )
{
    player endon( "disconnect" );
    player notify( "vehicle_preventPlayerCollisionDamageForTimeAfterExit" );
    player endon( "vehicle_preventPlayerCollisionDamageForTimeAfterExit" );
    player.vehiclecollisionignorearray = [];
    player.vehiclecollisionignorearray[ "inflictor" ] = vehicle;
    player.vehiclecollisionignorearray[ "meansOfDeath" ] = "MOD_CRUSH";
    vehicle_preventplayercollisiondamagefortimeafterexitinternal( player );
    thread vehicle_clearpreventplayercollisiondamagefortimeafterexit( player );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x5d3e
// Size: 0x7d
function vehicle_preventplayercollisiondamagefortimeafterexitinternal( player )
{
    player endon( "death" );
    
    if ( isdefined( level.vehicle ) && isdefined( level.vehicle.occupancy ) && isdefined( level.vehicle.occupancy.var_772978c4701134fc ) )
    {
        wait level.vehicle.occupancy.var_772978c4701134fc;
        return;
    }
    
    wait 4;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x5dc3
// Size: 0x1e
function vehicle_clearpreventplayercollisiondamagefortimeafterexit( player )
{
    player notify( "vehicle_preventPlayerCollisionDamageForTimeAfterExit" );
    player.vehiclecollisionignorearray = undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 4
// Checksum 0x0, Offset: 0x5de9
// Size: 0x83, Type: bool
function vehicle_playershouldignorecollisiondamage( inflictor, victim, meansofdeath, objweapon )
{
    if ( !isdefined( victim.vehiclecollisionignorearray ) )
    {
        return false;
    }
    
    if ( !isdefined( inflictor ) )
    {
        return false;
    }
    
    if ( isdefined( victim.vehiclecollisionignorearray[ "inflictor" ] ) && inflictor != victim.vehiclecollisionignorearray[ "inflictor" ] )
    {
        return false;
    }
    
    if ( meansofdeath != victim.vehiclecollisionignorearray[ "meansOfDeath" ] )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 3
// Checksum 0x0, Offset: 0x5e75
// Size: 0x246, Type: bool
function vehicle_isrubbingagainstvehicle( inflictor, victim, smeansofdeath )
{
    if ( !isdefined( smeansofdeath ) || smeansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( !isdefined( victim ) || !isdefined( victim.origin ) )
    {
        return false;
    }
    
    if ( !isdefined( inflictor ) || !isdefined( inflictor.origin ) || !isdefined( inflictor.angles ) )
    {
        return false;
    }
    
    if ( !inflictor isvehicle() || inflictor.vehiclename == "cargo_train" || !isent( inflictor ) )
    {
        return false;
    }
    
    vehicleref = inflictor function_d93ec4635290febd();
    
    if ( !function_89dc39dc11f3988c( vehicleref ) )
    {
        return false;
    }
    
    data = function_29b4292c92443328( vehicleref );
    
    if ( istrue( data.canfly ) || istrue( data.isboat ) )
    {
        return false;
    }
    
    if ( !isdefined( data.occupancy ) || !isdefined( data.occupancy.exitextents ) )
    {
        return false;
    }
    
    if ( !inflictor vehicle_isonground() )
    {
        return false;
    }
    
    if ( inflictor vehicle_getspeed() < 1 )
    {
        return false;
    }
    
    extents = data.occupancy.exitextents;
    
    if ( !isdefined( extents[ "front" ] ) || !isdefined( extents[ "back" ] ) )
    {
        return false;
    }
    
    forward = anglestoforward( inflictor.angles );
    moving = inflictor vehicle_getvelocity();
    between = math::anglebetweenvectors( forward, moving );
    movingforward = undefined;
    
    if ( between < 45 )
    {
        movingforward = 1;
    }
    else if ( between > 135 )
    {
        movingforward = 0;
    }
    else
    {
        return false;
    }
    
    localorigin = coordtransformtranspose( victim.origin, inflictor.origin, inflictor.angles );
    
    if ( movingforward && localorigin[ 0 ] < extents[ "front" ] - 30 )
    {
        return true;
    }
    
    if ( !movingforward && localorigin[ 0 ] > -1 * ( extents[ "back" ] - 30 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x60c4
// Size: 0x5b, Type: bool
function function_4687f4da72911323( deathdata )
{
    if ( !isdefined( deathdata.meansofdeath ) || deathdata.meansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( !isdefined( deathdata.inflictor ) || !deathdata.inflictor isvehicle() )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x6128
// Size: 0x59, Type: bool
function function_107efd42d596b2d3( deathdata )
{
    return isdismembermentenabled() && !istrue( deathdata.victim.liveragdoll ) && istrue( deathdata.inflictor.isheli ) && deathdata.damage == 999999;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x618a
// Size: 0x64
function vehicle_playerkilledbycollision( deathdata )
{
    if ( !function_4687f4da72911323( deathdata ) )
    {
        return;
    }
    
    if ( function_107efd42d596b2d3( deathdata ) )
    {
        thread vehicle_playerkilledfx( deathdata.victim );
        return;
    }
    
    playsoundatpos( deathdata.victim.origin + ( 0, 0, 18 ), "vehicle_body_hit" );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x61f6
// Size: 0x10e
function vehicle_playerkilledfx( victim )
{
    var_13f57e11d55f32d4 = 35;
    victim.nocorpse = 1;
    playsoundatpos( victim.origin + ( 0, 0, 18 ), "vehicle_body_hit" );
    players = getdismembermentlist();
    
    if ( players.size < var_13f57e11d55f32d4 )
    {
        fxent = spawn( "script_model", victim gettagorigin( "j_mainroot" ) );
        fxent.angles = victim.angles;
        fxent setmodel( "iw9_player_death_fx" );
        fxent setscriptablepartstate( "effects", "gib", 0 );
        
        foreach ( player in players )
        {
            fxent hidefromplayer( player );
        }
        
        wait 0.5;
        fxent delete();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x630c
// Size: 0x12b
function function_1b69321ff9937fc5()
{
    level endon( "game_ended" );
    self endon( "death" );
    ref = function_d93ec4635290febd();
    istank = ref == "light_tank" || ref == "veh9_cougar";
    interactdata = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( ref );
    floattime = interactdata.floattime;
    
    while ( true )
    {
        self waittill( "floating" );
        
        while ( self function_100d3bf35fca6a7f() > 0.01 )
        {
            endtime = gettime() + 1000 * floattime;
            
            while ( true )
            {
                waitframe();
                
                if ( !isfloating() )
                {
                    break;
                }
                
                if ( gettime() >= endtime )
                {
                    break;
                }
            }
            
            if ( isfloating() )
            {
                self.flipped = 1;
                
                if ( self vehicle_isphysveh() )
                {
                    self function_b0af0dd0f9b4fddf( 0 );
                }
                
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto( self, 0 );
                scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse( self, 0 );
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 0 );
                
                if ( !istank )
                {
                    wait 5;
                }
                
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( self );
                scripts\cp_mp\vehicles\vehicle_occupancy::function_d0092c44c5588870();
                wait ter_op( istank, 10, 25 );
                thread function_357783d7c1d96273();
                return;
            }
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x643f
// Size: 0x6c
function function_4a387c035eb677d0( isboat )
{
    level endon( "game_ended" );
    self endon( "death" );
    self waittill( "veh_submerged" );
    self.flipped = 1;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto( self, 0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse( self, 0 );
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 0 );
    
    if ( !isboat )
    {
        wait 1;
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( self );
    scripts\cp_mp\vehicles\vehicle_occupancy::function_d0092c44c5588870();
    
    if ( !isboat )
    {
        wait 15;
    }
    
    thread function_357783d7c1d96273();
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x64b3
// Size: 0x23c
function vehicle_watchflipped()
{
    self endon( "death" );
    self endon( "flipped_end" );
    level endon( "game_ended" );
    ref = function_d93ec4635290febd();
    flipstart = undefined;
    
    if ( issharedfuncdefined( ref, "flippedStart" ) )
    {
        flipstart = getsharedfunc( ref, "flippedStart" );
    }
    
    flipend = &vehicle_flippedendcallback;
    
    if ( issharedfuncdefined( ref, "flippedEnd" ) )
    {
        flipend = getsharedfunc( ref, "flippedEnd" );
    }
    
    data = vehicle_interact_getleveldataforvehicle( ref );
    burndowntimerangle = data.burndowntimerangle;
    var_b1fc50342f9a99dd = data.var_b1fc50342f9a99dd;
    usedisabled = 0;
    starttime = undefined;
    endtime = undefined;
    
    while ( true )
    {
        wait 1;
        shouldeject = 0;
        angle = scripts\engine\math::anglebetweenvectorsunit( ( 0, 0, 1 ), anglestoup( self.angles ) );
        
        if ( angle > var_b1fc50342f9a99dd )
        {
            shouldeject = 1;
            starttime = undefined;
        }
        else if ( angle > burndowntimerangle )
        {
            if ( !isdefined( starttime ) )
            {
                starttime = gettime() + 3000;
            }
            
            if ( gettime() > starttime )
            {
                shouldeject = 1;
                starttime = undefined;
            }
        }
        else
        {
            if ( usedisabled )
            {
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto( self, 1 );
                scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse( self, 1 );
                usedisabled = 0;
            }
            
            shouldeject = 0;
            starttime = undefined;
        }
        
        if ( shouldeject )
        {
            if ( isdefined( flipstart ) )
            {
                thread [[ flipstart ]]( self );
            }
            
            if ( !usedisabled )
            {
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowspawninto( self, 0 );
                scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse( self, 0 );
                usedisabled = 1;
            }
            
            if ( getdvarint( @"hash_ce3ffd0926397091", 0 ) == 1 )
            {
                scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( self );
            }
            
            timedout = 0;
            endtime = gettime() + 3000;
            
            while ( true )
            {
                waitframe();
                angle = scripts\engine\math::anglebetweenvectorsunit( ( 0, 0, 1 ), anglestoup( self.angles ) );
                
                if ( angle <= burndowntimerangle )
                {
                    break;
                }
                
                if ( gettime() >= endtime )
                {
                    timedout = 1;
                    break;
                }
            }
            
            endtime = undefined;
            
            if ( isdefined( flipend ) )
            {
                thread [[ flipend ]]( self, timedout );
            }
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x66f7
// Size: 0x3e
function vehicle_flippedendcallback( vehicle, timedout )
{
    if ( timedout && !istrue( vehicle.flipped ) )
    {
        vehicle.flipped = 1;
        vehicle thread function_357783d7c1d96273();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x673d
// Size: 0x60
function vehicle_deletecollmapvehicles()
{
    level notify( "vehicle_deleteCollmapVehicles" );
    level endon( "vehicle_deleteCollmapVehicles" );
    wait 1;
    vehicles = getentarray( "delete_me", "targetname" );
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        for ( i = vehicles.size - 1; i >= 0 ; i-- )
        {
            vehicles[ i ] delete();
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x67a5
// Size: 0xc8
function function_78fa8a2ff553f7c8( data )
{
    vehicle = data.victim;
    
    if ( istrue( vehicle.ishaywire ) || istrue( vehicle.var_4970cb0edef7623b ) )
    {
        return;
    }
    
    vehicle.ishaywire = 1;
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( vehicle, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "shockStickAttached", occupants, vehicle.vehiclename );
    vehicle.originalmaxspeedforward = vehicle vehicle_gettopspeedforward();
    vehicle.originalmaxspeedreverse = vehicle vehicle_gettopspeedreverse();
    vehicle vehicle_settopspeedforward( 10 );
    vehicle vehicle_settopspeedreverse( 10 );
    vehicle utility::function_3677f2be30fdd581( "haywire", "on" );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x6875
// Size: 0xab
function function_b92c4e2d8733661( data )
{
    vehicle = data.victim;
    
    if ( !isdefined( vehicle ) || istrue( vehicle.var_4970cb0edef7623b ) )
    {
        return;
    }
    
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( vehicle, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "shockStickAttached", occupants, vehicle.vehiclename );
    maxspeedforward = vehicle vehicle_gettopspeedforward( 1 );
    maxspeedreverse = vehicle vehicle_gettopspeedreverse( 1 );
    vehicle vehicle_settopspeedforward( maxspeedforward );
    vehicle vehicle_settopspeedreverse( maxspeedreverse );
    vehicle utility::function_3677f2be30fdd581( "haywire", "off" );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x6928
// Size: 0x84
function vehicle_lockedoncallback()
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "missileLocking", occupants, self.vehiclename );
    
    foreach ( occupant in occupants )
    {
        occupant stoplocalsound( "veh_warning_missile_locking" );
        occupant playlocalsound( "veh_warning_missile_locking" );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x69b4
// Size: 0x78
function vehicle_lockedonremovedcallback()
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "missileLocking", occupants, self.vehiclename );
    
    foreach ( occupant in occupants )
    {
        occupant stoplocalsound( "veh_warning_missile_locking" );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x6a34
// Size: 0xe2
function function_a2d1400bcf46869a()
{
    hadwarning = istrue( self.var_15c05fe1c0f6de03 );
    var_ac7254614112a03c = 0;
    
    if ( isdefined( self.bunkerbustersattached ) )
    {
        foreach ( team in self.bunkerbustersattached )
        {
            if ( !scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoteam( self, team ) )
            {
                var_ac7254614112a03c = 1;
                break;
            }
        }
    }
    
    if ( hadwarning == var_ac7254614112a03c )
    {
        return;
    }
    
    self.var_15c05fe1c0f6de03 = var_ac7254614112a03c;
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
    
    if ( var_ac7254614112a03c )
    {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "BunkerBusterAttached", occupants, self.vehiclename );
        return;
    }
    
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "BunkerBusterAttached", occupants, self.vehiclename );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x6b1e
// Size: 0x84
function vehicle_incomingcallback()
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "missileIncoming", occupants, self.vehiclename );
    
    foreach ( occupant in occupants )
    {
        occupant stoplocalsound( "veh_warning_missile_incoming" );
        occupant playlocalsound( "veh_warning_missile_incoming" );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x6baa
// Size: 0x78
function vehicle_incomingremovedcallback()
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "missileIncoming", occupants, self.vehiclename );
    
    foreach ( occupant in occupants )
    {
        occupant stoplocalsound( "veh_warning_missile_incoming" );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x6c2a
// Size: 0xb4
function vehicle_empstartcallback( data )
{
    if ( issharedfuncdefined( "emp", "onVehicleEMPed" ) )
    {
        self [[ getsharedfunc( "emp", "onVehicleEMPed" ) ]]( data );
    }
    
    if ( isdefined( self.reactivearmor ) )
    {
        self.reactivearmordisabled = 1;
    }
    
    utility::function_3677f2be30fdd581( "ddos", "disabled" );
    
    if ( getdvarint( @"hash_10320e52e3e9ab5c", 0 ) == 0 )
    {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "DDoSed", occupants, self.vehiclename );
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 0, 0, self.var_64c5a4a6f78c0674 );
    scripts\cp_mp\vehicles\vehicle_occupancy::function_a1a583c3cc871645( 0 );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x6ce6
// Size: 0x87
function vehicle_empclearcallback( fromdeath )
{
    if ( !fromdeath )
    {
        utility::function_3677f2be30fdd581( "ddos", "neutral" );
    }
    
    if ( isdefined( self.reactivearmor ) )
    {
        self.reactivearmordisabled = undefined;
    }
    
    if ( getdvarint( @"hash_10320e52e3e9ab5c", 0 ) == 0 )
    {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "DDoSed", occupants, self.vehiclename );
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 1 );
    scripts\cp_mp\vehicles\vehicle_occupancy::function_a1a583c3cc871645( 1 );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x6d75
// Size: 0xc5
function function_810dfd134e9a7a04( vehicledata )
{
    if ( ent_flag( "ai_initted" ) )
    {
        return;
    }
    
    self.script_badplace = 1;
    ent_flag_init( "unloaded" );
    ent_flag_init( "loaded" );
    ent_flag_init( "landed" );
    self.riders = [];
    self.unloadque = [];
    self.unload_group = "default";
    self.fastroperig = [];
    self.vehicleanimalias = vehicledata.ai.vehicleanimalias;
    self.classname_mp = vehicledata.ai.classname;
    thread scripts\common\vehicle_aianim::handle_attached_guys();
    ent_flag_set( "ai_initted" );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1
// Checksum 0x0, Offset: 0x6e42
// Size: 0x61
function function_95022424d8b0dc1c( vehicleref )
{
    if ( !function_89dc39dc11f3988c( vehicleref ) )
    {
        return 0;
    }
    
    data = function_29b4292c92443328( vehicleref );
    
    if ( !isdefined( data.ai ) || !istrue( data.ai.supportsai ) )
    {
        return 0;
    }
    
    return data.aiseats.size;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 3
// Checksum 0x0, Offset: 0x6eac
// Size: 0xaa
function function_f92faaaf5c5077c6( riders, spawninvehicle, var_420ba29d9efc4756 )
{
    vehicleref = function_d93ec4635290febd();
    assert( utility::function_a10967d736dc56e5() && istrue( function_29b4292c92443328( vehicleref ).ai.supportsai ), "vehicle_loadAI: You can't load AI into a vehicle that doesn't support it" );
    
    if ( !ent_flag( "ai_initted" ) )
    {
        function_810dfd134e9a7a04( function_29b4292c92443328( vehicleref ) );
    }
    
    if ( issharedfuncdefined( vehicleref, "loadAI" ) )
    {
        [[ getsharedfunc( vehicleref, "loadAI" ) ]]( riders, spawninvehicle, var_420ba29d9efc4756 );
        return;
    }
    
    function_19e0f5686d59b76f( riders, spawninvehicle, var_420ba29d9efc4756 );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 3
// Checksum 0x0, Offset: 0x6f5e
// Size: 0x379
function function_19e0f5686d59b76f( riders, spawninvehicle, var_420ba29d9efc4756 )
{
    if ( !isdefined( spawninvehicle ) )
    {
        spawninvehicle = 0;
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::function_9e710c9f3a15ffda();
    thread function_f77e18d192719ac();
    vehicledata = function_29b4292c92443328( function_d93ec4635290febd() );
    turrets = [];
    
    foreach ( turret in vehicle_getturrets( self ) )
    {
        turrets[ turrets.size ] = turret;
    }
    
    foreach ( index, rider in riders )
    {
        if ( !isdefined( rider ) || !isdefined( rider._blackboard ) )
        {
            function_ed7bbd7e1327b7fb( rider );
            continue;
        }
        
        availablepositionsstruct = scripts\common\vehicle_aianim::get_availablepositions();
        
        if ( isdefined( rider.spawner ) && isdefined( rider.spawner.script_startingposition ) )
        {
            rider.script_startingposition = int( rider.spawner.script_startingposition );
        }
        else if ( !isdefined( rider.script_startingposition ) )
        {
            rider.script_startingposition = index;
            
            if ( isdefined( rider.spawner ) )
            {
                rider.spawner.script_startingposition = index;
            }
        }
        
        pos = scripts\common\vehicle_aianim::choose_vehicle_position( rider, availablepositionsstruct, 0 );
        rider.vehicle_position = pos.vehicle_position;
        anim_pos = scripts\common\vehicle_aianim::anim_pos( self, pos.vehicle_position );
        rider thread scripts\vehicle\vehicle_common::entervehicle( self, spawninvehicle, pos, anim_pos );
        thread function_36581eab345137d4( rider );
        self.riders[ self.riders.size ] = rider;
        rider.ridingvehicle = self;
        rider.vehicle = self;
        
        if ( isdefined( anim_pos.bhasgunwhileriding ) && !anim_pos.bhasgunwhileriding )
        {
            rider scripts\common\ai::gun_remove();
        }
        
        if ( isdefined( rider.team ) && pos.vehicle_position == 0 )
        {
            self.aidriver = rider;
            scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( self, rider.team );
            
            if ( !istrue( var_420ba29d9efc4756 ) )
            {
                rider thread function_35f4a61ce36d99bb( self );
            }
            
            continue;
        }
        
        if ( isdefined( vehicledata.aiseats[ pos.vehicle_position ] ) && istrue( vehicledata.aiseats[ pos.vehicle_position ].mgturret ) && turrets.size > 0 )
        {
            if ( !isdefined( self.mgturret ) )
            {
                self.mgturret = [];
            }
            
            turret = turrets[ self.mgturret.size ];
            
            if ( !isdefined( turret ) )
            {
                assert( "AI " + rider getentitynumber() + " is trying to get into a turret but all turrets are full. This is likely caused by an incorrect setup, or calling get_in on the same vehicle multiple times." );
                continue;
            }
            
            self.mgturret[ self.mgturret.size ] = turret;
            turret setturretteam( rider.team );
            rider scripts\asm\asm_bb::bb_requestturret( turret );
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x72df
// Size: 0xc5
function private function_ed7bbd7e1327b7fb( rider )
{
    /#
        if ( !isdefined( rider ) )
        {
            println( "<dev string:x144>" );
        }
        else if ( !isdefined( rider._blackboard ) )
        {
            println( "<dev string:x197>" );
        }
        
        if ( isdefined( rider ) && isdefined( rider.origin ) )
        {
            println( "<dev string:x1fd>" + rider.origin );
        }
        
        if ( isdefined( rider ) )
        {
            category = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata( rider, "<dev string:x22b>" );
            subcategory = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata( rider, "<dev string:x234>" );
            println( "<dev string:x240>" + default_to( category, "<dev string:x5e>" ) + "<dev string:x26f>" + default_to( subcategory, "<dev string:x5e>" ) );
        }
    #/
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x73ac
// Size: 0x40
function private function_36581eab345137d4( rider )
{
    self endon( "death" );
    self endon( "unloaded" );
    rider waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.riders = array_remove( self.riders, rider );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x73f4
// Size: 0x12
function private function_f77e18d192719ac()
{
    self waittill( "death" );
    thread scripts\common\vehicle_code::vehicle_killriders();
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x740e
// Size: 0xb7
function private function_35f4a61ce36d99bb( vehicle )
{
    vehicle endon( "unloaded" );
    vehicle endon( "death" );
    vehicle endon( "vehicle_OnDriverDeath_early" );
    self waittill( "death" );
    vehicle notify( "driverdeath" );
    
    if ( isdefined( vehicle ) && isalive( vehicle ) && isdefined( vehicle.var_3816d927b2610b20 ) )
    {
        vehicle thread [[ vehicle.var_3816d927b2610b20 ]]();
        return;
    }
    
    if ( istrue( vehicle.isheli ) )
    {
        if ( istrue( vehicle.var_e6036cc5fe1c5c9e ) )
        {
            vehicle thread scripts\cp_mp\vehicles\vehicle::function_f7af4d1c91ca6e2f();
        }
        else
        {
            wait 1.5;
            vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_explode( undefined, 1 );
        }
        
        return;
    }
    
    if ( istrue( vehicle.unloadondriverdeath ) )
    {
        vehicle thread namespace_cbe993018617a21d::unloadvehicle();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x74cd
// Size: 0xe8
function function_1cd6d75165ecbc48()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return undefined;
    }
    
    if ( isagent( self ) )
    {
        return undefined;
    }
    
    vehiclecustomization = spawnstruct();
    vehiclecustomization.horns = [];
    vehiclecustomization.skins = [];
    projectname = getprojectname();
    
    foreach ( ref, data in level.var_a0b2c978ca57ffc5 )
    {
        mtxdata = scripts\cp_mp\vehicles\vehicle::function_86f6f784630b11fb( ref );
        
        if ( !isdefined( mtxdata ) )
        {
            continue;
        }
        
        vehiclecustomization.skins[ ref ] = function_4d5b0a0260555dcd( mtxdata );
        vehiclecustomization.horns[ ref ] = getvehicleplayerhorn( mtxdata );
    }
    
    return vehiclecustomization;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x75be
// Size: 0x83
function private function_4d5b0a0260555dcd( data )
{
    if ( !isdefined( data ) || !isdefined( data.mtx ) || data.mtx.size == 0 )
    {
        return undefined;
    }
    
    id = self getplayerdata( level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "camo" );
    id -= 1;
    
    if ( isdefined( id ) )
    {
        return data.mtx[ id ];
    }
    
    return undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x764a
// Size: 0x9f
function private getvehicleplayerhorn( data )
{
    if ( !isdefined( data ) || !isdefined( data.horns ) || data.horns.size == 0 )
    {
        return undefined;
    }
    
    id = self getplayerdata( level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "horn" );
    id -= 1;
    
    if ( isdefined( id ) && isdefined( data.horns[ id ] ) )
    {
        return data.horns[ id ].alias;
    }
    
    return undefined;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x76f2
// Size: 0x171
function function_471cde1983a05f66( player, vehicleref )
{
    mtx = undefined;
    
    if ( isdefined( player.vehiclecustomization ) && isdefined( player.vehiclecustomization.skins ) && isdefined( player.vehiclecustomization.skins[ vehicleref ] ) )
    {
        mtx = player.vehiclecustomization.skins[ vehicleref ];
    }
    else if ( getdvarint( @"hash_42c1e6eb518bf4fc", 0 ) == 1 && cointoss() )
    {
        data = function_29b4292c92443328( vehicleref );
        
        if ( isdefined( data ) && isdefined( data.mtx ) && data.mtx.size > 0 )
        {
            mtx = random( data.mtx );
        }
    }
    else if ( getdvarint( @"hash_d0405b9fee9d9869", -1 ) > -1 )
    {
        selectedmtx = getdvarint( @"hash_d0405b9fee9d9869", -1 );
        data = function_29b4292c92443328( vehicleref );
        
        if ( isdefined( data ) && isdefined( data.mtx ) && data.mtx.size > 0 && selectedmtx < data.mtx.size )
        {
            mtx = data.mtx[ selectedmtx ];
        }
    }
    
    return mtx;
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x786c
// Size: 0x192
function function_4201160d49c885a7( vehicle, mtx )
{
    if ( !isdefined( mtx ) )
    {
        return;
    }
    
    vehicle.mtx = mtx;
    vehicle function_788d3c14d6b4ba6b( mtx.ref );
    
    if ( isdefined( mtx.turretcamo ) || isdefined( mtx.var_9c6d62e1c42be80a ) )
    {
        foreach ( weapon, turret in vehicle_getturrets( vehicle ) )
        {
            if ( isdefined( mtx.var_9c6d62e1c42be80a ) && isdefined( mtx.var_9c6d62e1c42be80a[ weapon ] ) )
            {
                turret setvehicleturretcamo( mtx.var_9c6d62e1c42be80a[ weapon ] );
                continue;
            }
            
            if ( isdefined( mtx.turretcamo ) )
            {
                turret setvehicleturretcamo( mtx.turretcamo );
            }
        }
    }
    
    if ( isdefined( mtx.vehicletrail ) && mtx.vehicletrail != "" )
    {
        vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_update( vehicle );
    }
    
    if ( isdefined( mtx.idlestate ) )
    {
        vehicle function_3677f2be30fdd581( "mtx", mtx.idlestate );
    }
    
    if ( isdefined( mtx.hornstate ) )
    {
        vehicle thread function_e9c362d34ccc190b( mtx.hornstate );
    }
    
    if ( isdefined( mtx.var_c1af5f3094ddb62d ) )
    {
        vehicle thread function_4327f95b5d3f8fb3( mtx.var_c1af5f3094ddb62d );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x7a06
// Size: 0x45
function private function_e9c362d34ccc190b( hornstate )
{
    self notify( "watch_horn" );
    self endon( "watch_horn" );
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "vehicle_horn" );
        function_3677f2be30fdd581( "mtx", hornstate );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x7a53
// Size: 0x4e
function private function_4327f95b5d3f8fb3( var_c1af5f3094ddb62d )
{
    self notify( "watch_hitAndRun" );
    self endon( "watch_hitAndRun" );
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        waittill_any_2( "vehicle_killed_player", "vehicle_downed_player" );
        function_3677f2be30fdd581( "mtx", var_c1af5f3094ddb62d );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x7aa9
// Size: 0xb9
function private function_19d89390ee87e7c2( vehicleref, vehcamo )
{
    if ( !isdefined( vehcamo ) || !isdefined( vehicleref ) )
    {
        return;
    }
    
    data = scripts\cp_mp\vehicles\vehicle::function_86f6f784630b11fb( vehicleref );
    
    if ( !isdefined( data ) || !isdefined( data.mtx ) )
    {
        return;
    }
    
    skinindex = undefined;
    
    foreach ( struct in data.mtx )
    {
        if ( is_equal( vehcamo, struct.ref ) )
        {
            return struct;
        }
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2
// Checksum 0x0, Offset: 0x7b6a
// Size: 0x1c7
function function_86f6f784630b11fb( vehicleref, options )
{
    data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328( vehicleref );
    
    if ( isdefined( data ) && isdefined( data.mtxvehicleref ) )
    {
        vehicleref = data.mtxvehicleref;
        
        if ( !scripts\cp_mp\vehicles\vehicle::function_89dc39dc11f3988c( vehicleref ) )
        {
            if ( !isdefined( level.var_c7fee21d5d5e1a1c ) )
            {
                level.var_c7fee21d5d5e1a1c = [];
            }
            
            if ( isdefined( level.var_c7fee21d5d5e1a1c[ vehicleref ] ) )
            {
                data = level.var_c7fee21d5d5e1a1c[ vehicleref ];
            }
            else
            {
                bundlename = vehicleref + ter_op( !iscp(), "_mp", "_cp" );
                data = getscriptbundlefieldvalues( hashcat( %"vehiclebundle:", bundlename ), [ #"ref", #"vehicle", #"interact", #"horns", #"mtx" ] );
                level.var_c7fee21d5d5e1a1c[ vehicleref ] = data;
            }
        }
        else
        {
            data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328( vehicleref );
        }
    }
    
    if ( !isdefined( data ) || !isdefined( data.vehicle ) || !isdefined( data.interact ) )
    {
        return undefined;
    }
    
    if ( istrue( data.interact.var_6be1425a9ea8586d ) && !istrue( data.var_b01f9533413e14ec ) )
    {
        return undefined;
    }
    
    if ( ( !isdefined( data.horns ) || data.horns.size == 0 ) && ( !isdefined( data.mtx ) || data.mtx.size == 0 ) && !istrue( data.haswartracks ) )
    {
        return undefined;
    }
    
    return data;
}

/#

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 3
    // Checksum 0x0, Offset: 0x7d3a
    // Size: 0x189, Type: dev
    function function_fdf45700cfcd0c05( vehcamo, hornindex, trailindex )
    {
        vehiclecustomization = spawnstruct();
        vehiclecustomization.horns = [];
        vehiclecustomization.skins = [];
        skinindex = undefined;
        
        if ( isdefined( vehcamo ) && isint( vehcamo ) )
        {
            skinindex = vehcamo;
        }
        
        foreach ( ref, data in level.var_a0b2c978ca57ffc5 )
        {
            data = scripts\cp_mp\vehicles\vehicle::function_86f6f784630b11fb( ref );
            
            if ( isdefined( vehcamo ) && isstring( vehcamo ) && isdefined( data ) && isdefined( data.mtx ) )
            {
                skinindex = undefined;
                
                foreach ( struct in data.mtx )
                {
                    if ( is_equal( vehcamo, struct.ref ) )
                    {
                        skinindex = index;
                        break;
                    }
                }
            }
            
            if ( isdefined( skinindex ) )
            {
                vehiclecustomization.skins[ ref ] = function_82a41d4c091810a6( data, skinindex );
            }
            
            if ( isdefined( hornindex ) )
            {
                vehiclecustomization.horns[ ref ] = function_cdb95758906af97e( data, hornindex );
            }
        }
        
        return vehiclecustomization;
    }

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 2
    // Checksum 0x0, Offset: 0x7ecb
    // Size: 0x58, Type: dev
    function function_82a41d4c091810a6( data, skinindex )
    {
        if ( isagent( self ) )
        {
            return undefined;
        }
        
        if ( isdefined( data ) && isdefined( data.mtx ) && isdefined( data.mtx[ skinindex ] ) )
        {
            return data.mtx[ skinindex ];
        }
        
        return undefined;
    }

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 2
    // Checksum 0x0, Offset: 0x7f2b
    // Size: 0x57, Type: dev
    function function_cdb95758906af97e( data, hornindex )
    {
        if ( isdefined( data ) && isdefined( data.horns ) && isdefined( data.horns[ hornindex ] ) )
        {
            return data.horns[ hornindex ].alias;
        }
        
        return undefined;
    }

#/

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0
// Checksum 0x0, Offset: 0x7f8a
// Size: 0x115
function function_1e24abef827f0807()
{
    if ( getdvarint( @"hash_b1e5a269c62e79c7", 1 ) == 0 )
    {
        return;
    }
    
    ref = function_d93ec4635290febd();
    
    if ( !isdefined( ref ) || !function_89dc39dc11f3988c( ref ) )
    {
        return;
    }
    
    data = function_29b4292c92443328( ref );
    
    if ( !isdefined( data ) || !isdefined( data.tricks ) )
    {
        return;
    }
    
    self endon( "death" );
    childthread function_45585d05c17c31aa();
    
    while ( true )
    {
        self waittill( "trick_in", trickname );
        
        if ( !isdefined( vehicle_occupancy_getdriver( self ) ) )
        {
            continue;
        }
        
        if ( isdefined( self.var_1fb1c203624107a7[ trickname ] ) && self.var_1fb1c203624107a7[ trickname ] == gettime() )
        {
            continue;
        }
        
        if ( !isdefined( data.tricks[ trickname ] ) )
        {
            assertmsg( "Trick: \"" + trickname + "\" has no scoring data in the vehicle bundle!" );
            continue;
        }
        
        hash = getxhash( trickname );
        childthread function_436b3366f1d5b495( trickname, data.tricks[ trickname ], hash );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x80a7
// Size: 0x28c
function private function_436b3366f1d5b495( trickname, trickdata, hash )
{
    self notify( trickname + "_rewarding" );
    self endon( trickname + "_rewarding" );
    self endon( trickname + "_ended" );
    trickxp = callsharedfunc( "rank", "getScoreInfoXP", hash );
    wait trickdata.delay;
    player = vehicle_occupancy_getdriver( self );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player scripts\cp_mp\challenges::reportVehicleEvent( self, trickname );
    
    if ( trickname == "frontflip" || trickname == "backflip" || trickname == "nacnac_left" || trickname == "nacnac_right" || trickname == "superman" )
    {
        player scripts\cp_mp\challenges::reportVehicleEvent( self, "any_air_trick" );
    }
    
    if ( !isdefined( self.var_ddfbc5f492fb65c6 ) )
    {
        self.var_ddfbc5f492fb65c6 = [];
    }
    
    index = array_find( self.var_ddfbc5f492fb65c6, trickname );
    var_e101b88d6655f13b = 1;
    
    if ( isdefined( index ) )
    {
        switch ( index )
        {
            case 0:
                var_e101b88d6655f13b = 0.2;
                break;
            case 1:
                var_e101b88d6655f13b = 0.4;
                break;
            case 2:
                var_e101b88d6655f13b = 0.6;
                break;
            case 3:
                var_e101b88d6655f13b = 0.8;
                break;
        }
    }
    
    trickxp *= var_e101b88d6655f13b;
    self.var_ddfbc5f492fb65c6 = array_remove( self.var_ddfbc5f492fb65c6, trickname );
    self.var_ddfbc5f492fb65c6 = array_insert( self.var_ddfbc5f492fb65c6, trickname, 0 );
    
    if ( isdefined( self.combo ) && self.combo != trickname )
    {
        player givexp( #"combo", callsharedfunc( "rank", "getScoreInfoXP", #"combo" ) );
    }
    
    thread watchcombo( trickname );
    
    if ( trickdata.type == "reward_points_once" )
    {
        player givexp( hash, int( trickxp ) );
        return;
    }
    
    decay = 1;
    
    while ( isdefined( player ) )
    {
        xp = int( max( 1, round( trickxp * decay ) ) );
        player givexp( hash, xp );
        decay -= 0.2;
        
        if ( decay < 0.1 )
        {
            return;
        }
        
        wait 0.5;
        player = vehicle_occupancy_getdriver( self );
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x833b
// Size: 0x53
function private givexp( event, xp )
{
    callsharedfunc( "rank", "displayScoreEventPoints", xp, event );
    callsharedfunc( "rank", "killEventTextPopup", event, 1 );
    callsharedfunc( "rank", "giveRankXP", event, xp, undefined, 1, undefined, 1 );
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8396
// Size: 0x42
function private function_45585d05c17c31aa()
{
    self.var_1fb1c203624107a7 = [];
    
    while ( true )
    {
        self waittill( "trick_out", trickname );
        self notify( trickname + "_ended" );
        self.var_1fb1c203624107a7[ trickname ] = gettime();
    }
}

// Namespace vehicle / scripts\cp_mp\vehicles\vehicle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x83e0
// Size: 0xaf
function private watchcombo( trickname )
{
    if ( self getwheelsurface( 0 ) != "none" && self getwheelsurface( 1 ) != "none" )
    {
        return;
    }
    
    self.combo = trickname;
    self notify( "watchCombo" );
    self endon( "watchCombo" );
    self endon( "death" );
    timeonground = 0;
    
    while ( true )
    {
        if ( self getwheelsurface( 0 ) != "none" && self getwheelsurface( 1 ) != "none" )
        {
            timeonground += level.framedurationseconds;
        }
        else
        {
            timeonground = 0;
        }
        
        if ( timeonground >= 0.25 )
        {
            break;
        }
        
        waitframe();
    }
    
    self.combo = undefined;
}

/#

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 0
    // Checksum 0x0, Offset: 0x8497
    // Size: 0x51, Type: dev
    function function_84134697aff9fc9a()
    {
        if ( istrue( self.inlaststand ) )
        {
            return 0;
        }
        
        if ( isdefined( self.vehicle ) )
        {
            return 0;
        }
        
        if ( self isinexecutionattack() || self isinexecutionvictim() )
        {
            return 0;
        }
        
        if ( !scripts\cp_mp\utility\player_utility::_isalive() )
        {
            return 0;
        }
        
        if ( scripts\common\utility::isusingremote() )
        {
            return 0;
        }
        
        return 1;
    }

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 2
    // Checksum 0x0, Offset: 0x84f0
    // Size: 0x61, Type: dev
    function function_84033ce50b8afce2( vehicleref, spawndata )
    {
        if ( vehicleref == "<dev string:x282>" )
        {
            spawndata.spawnmethod = "<dev string:x28d>";
            spawndata.cantimeout = 0;
        }
        
        vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( vehicleref, spawndata );
        return [ vehicle, "<dev string:x2a6>" ];
    }

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 1
    // Checksum 0x0, Offset: 0x8559
    // Size: 0x16e, Type: dev
    function function_276beb60c7f60d1e( vehicleref )
    {
        if ( !function_84134697aff9fc9a() )
        {
            return;
        }
        
        spawnposition = self.origin + ( 0, 0, 100 );
        spawnangles = self.angles * ( 0, 1, 0 );
        vehicle = undefined;
        seatid = undefined;
        spawndata = spawnstruct();
        spawndata.origin = spawnposition;
        spawndata.angles = spawnangles;
        spawndata.spawntype = "<dev string:x2ad>";
        [ vehicle, seatid ] = function_84033ce50b8afce2( vehicleref, spawndata );
        
        if ( isdefined( vehicle ) && vehicleref != "<dev string:x2b4>" && vehicleref != "<dev string:x2c0>" && vehicleref != "<dev string:x2cb>" && vehicleref != "<dev string:x2d9>" && vehicleref != "<dev string:x2f2>" )
        {
            assertex( isdefined( seatid ), "<dev string:x30d>" );
            thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, seatid, self, undefined, 1 );
        }
        else if ( !isdefined( vehicle ) )
        {
            iprintln( "<dev string:x353>" );
        }
        
        if ( vehicleref == "<dev string:x2c0>" || vehicleref == "<dev string:x2cb>" || vehicleref == "<dev string:x2d9>" )
        {
            vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_a91927df280e94e4();
        }
        
        return vehicle;
    }

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 1
    // Checksum 0x0, Offset: 0x86cf
    // Size: 0x76, Type: dev
    function destroyvehicles( vehicleref )
    {
        instances = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances( vehicleref );
        
        if ( isdefined( instances ) && instances.size > 0 )
        {
            foreach ( instance in instances )
            {
                instance scripts\cp_mp\vehicles\vehicle::vehicle_explode();
            }
        }
    }

    // Namespace vehicle / scripts\cp_mp\vehicles\vehicle
    // Params 0
    // Checksum 0x0, Offset: 0x874d
    // Size: 0x19, Type: dev
    function function_b4896044b6e0d565()
    {
        wait 1;
        self setscriptablepartstate( "<dev string:x36b>", "<dev string:x372>" );
    }

#/
