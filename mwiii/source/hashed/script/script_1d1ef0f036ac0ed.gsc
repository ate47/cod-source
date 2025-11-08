#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;

#namespace namespace_619f08f8f135db64;

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0
// Checksum 0x0, Offset: 0x56e
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "apc_russian", &apc_rus_init );
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x589
// Size: 0xd1
function private apc_rus_init()
{
    if ( !function_9697379150687859( "apc_russian" ) && getstructarray( "rallyPointAPC", "targetname" ).size == 0 )
    {
        return;
    }
    
    create_func_ref( "set_vehicle_anims_apc", &set_vehicle_anims_apc );
    create_func_ref( "set_vehicle_anims_vindia", &set_vehicle_anims_vindia );
    callbacks[ "enterEnd" ] = &apc_rus_enterend;
    callbacks[ "exitEnd" ] = &apc_rus_exitend;
    callbacks[ "update" ] = &apc_rus_update;
    callbacks[ "spawn" ] = &apc_rus_create;
    function_8497e7e46b5e397( "apc_russian", callbacks );
    apc_rus_initomnvars();
    apc_rus_initdamage();
    apc_rus_initfx();
    function_29b4292c92443328( "apc_russian" ).var_528c63bf357fb963 = getdvarint( @"hash_f73768d95dd26d25", 8 );
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x662
// Size: 0x82
function private set_vehicle_anims_apc( positions )
{
    positions[ 0 ].vehicle_getoutanim = %vh_apc_org_unload_door_l;
    positions[ 0 ].vehicle_getoutanim_clear = 0;
    positions[ 2 ].vehicle_getoutanim = %vh_apc_org_unload_door_r;
    positions[ 2 ].vehicle_getoutanim_clear = 0;
    positions[ 4 ].vehicle_getoutanim = %vh_apc_org_unload_door_back;
    positions[ 4 ].vehicle_getoutanim_clear = 0;
    return positions;
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x6ed
// Size: 0x82
function private set_vehicle_anims_vindia( positions )
{
    positions[ 0 ].vehicle_getoutanim = %vh_vindia_back_door_exit_combat_idle;
    positions[ 0 ].vehicle_getoutanim_clear = 0;
    positions[ 4 ].vehicle_getoutanim = %vh_vindia_left_door_exit_combat_idle;
    positions[ 4 ].vehicle_getoutanim_clear = 0;
    positions[ 5 ].vehicle_getoutanim = %vh_vindia_right_door_exit_combat_idle;
    positions[ 5 ].vehicle_getoutanim_clear = 0;
    return positions;
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x778
// Size: 0x1b1
function private apc_rus_initomnvars()
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( "apc_russian", 1 );
    leveldataforvehicle.ammoids[ "driverTurret" ] = 0;
    leveldataforvehicle.rotationids[ "chassis" ] = 0;
    leveldataforvehicle.rotationids[ "turret" ] = 1;
    leveldataforvehicle.rotationrefsbyseatandweapon[ "driver" ][ "apc_rus_mp" ] = "chassis";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "driver" ][ "iw9_tur_apc_russian_mp" ] = "turret";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "front_left" ][ "apc_rus_mp" ] = "chassis";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "front_left" ][ "iw9_tur_apc_russian_mp" ] = "turret";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "front_right" ][ "apc_rus_mp" ] = "chassis";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "front_right" ][ "iw9_tur_apc_russian_mp" ] = "turret";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "back_right" ][ "apc_rus_mp" ] = "chassis";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "back_right" ][ "iw9_tur_apc_russian_mp" ] = "turret";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "back_left" ][ "apc_rus_mp" ] = "chassis";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "back_left" ][ "iw9_tur_apc_russian_mp" ] = "turret";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "back" ][ "apc_rus_mp" ] = "chassis";
    leveldataforvehicle.rotationrefsbyseatandweapon[ "back" ][ "iw9_tur_apc_russian_mp" ] = "turret";
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x931
// Size: 0x32
function private apc_rus_initdamage()
{
    vehicle_damage_setpremoddamagecallback( "apc_russian", &apc_rus_premoddamagecallback );
    vehicle_damage_setpostmoddamagecallback( "apc_russian", &apc_rus_postmoddamagecallback );
    vehicle_damage_setweaponhitdamagedata( "iw9_tur_apc_russian_mp", 2 );
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x96b
// Size: 0x1c
function private apc_rus_initfx()
{
    level._effect[ "apc_rus_explode_alt" ] = loadfx( "vfx/iw8_mp/vehicle/vfx_rusapc_mp_death_west_exp.vfx" );
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x98f
// Size: 0x16a
function private apc_rus_create( spawndata, faildata )
{
    if ( !isdefined( spawndata.angles ) )
    {
        spawndata.angles = ( 0, 0, 0 );
    }
    
    /#
        validatespawndata( spawndata );
    #/
    
    if ( istrue( spawndata.usealtmodel ) )
    {
        spawndata.modelname = "veh8_mil_lnd_vindia_a1_physics_mp_composite";
    }
    else
    {
        spawndata.modelname = "veh8_mil_lnd_vindia_a1_physics_mp_composite";
    }
    
    spawndata.targetname = "apc_russian";
    spawndata.vehicletype = "vindia_physics_mp";
    vehicle = _spawnvehicle( spawndata, faildata );
    
    if ( !isdefined( vehicle ) )
    {
        return undefined;
    }
    
    vehicle_create( vehicle, "apc_russian", spawndata );
    vehicle.objweapon = makeweapon( "apc_rus_mp" );
    var_b101137988b007d7 = vehicle_damage_getinstancedataforvehicle( vehicle, 1 );
    var_b101137988b007d7.destroyscoreevent = "none";
    var_b101137988b007d7.destroyaward = "kill_apc_rus";
    var_b101137988b007d7.destroyawardlaunchonly = 1;
    vehicle_createlate( vehicle, spawndata );
    vehicle thread vehicle_watchflipped();
    vehicle thread function_1b69321ff9937fc5();
    vehicle thread apc_rus_monitordriverturretfire();
    
    if ( issharedfuncdefined( "apc_russian", "create" ) )
    {
        [[ getsharedfunc( "apc_russian", "create" ) ]]( vehicle );
    }
    
    return vehicle;
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb02
// Size: 0x108, Type: bool
function private apc_rus_premoddamagecallback( data )
{
    if ( vehicle_damage_isselfdamage( self, data ) )
    {
        return false;
    }
    
    var_6b11d3047f506fb6 = self.origin - data.point;
    normal = anglestoup( self.angles );
    dist = vectordot( var_6b11d3047f506fb6, normal );
    var_d74074ad5396e58a = data.point + normal * dist;
    var_c47f1816352556dd = vectornormalize( var_d74074ad5396e58a - self.origin );
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    var_d726822c713445c2 = getdvarfloat( @"hash_45d4631df7323c01", -0.892 );
    
    if ( vectordot( var_c47f1816352556dd, forward ) < var_d726822c713445c2 )
    {
        data.isrearcriticaldamage = apc_rus_damagecancriticalhit( data );
    }
    
    return true;
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xc13
// Size: 0x3e, Type: bool
function private apc_rus_postmoddamagecallback( data )
{
    if ( istrue( data.isrearcriticaldamage ) )
    {
        data.damage = int( data.damage * 1.6 );
    }
    
    return true;
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xc5a
// Size: 0x197, Type: bool
function private apc_rus_damagecancriticalhit( data )
{
    if ( isdefined( data.inflictor ) && isdefined( data.inflictor.weapon_name ) && data.inflictor.weapon_name == "gl" )
    {
        return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_GRENADE" );
    }
    
    if ( isdefined( data.objweapon ) && isdefined( data.objweapon.basename ) )
    {
        switch ( data.objweapon.basename )
        {
            case #"hash_a622e958420b92a0":
                return ( isdefined( data.meansofdeath ) && ( data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_RIFLE_BULLET" ) );
            case #"hash_3e782fd775b72022":
            case #"hash_6b9700922cc910a9":
            case #"hash_8c12df11df01f306":
            case #"hash_a9e31b8ffd42a67b":
            case #"hash_f55c20924061bd15":
            case #"hash_fd9c279f85990dad":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_PROJECTILE" );
            case #"hash_e704ecf8710c6f57":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_GRENADE" );
        }
    }
    
    return false;
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xdfa
// Size: 0x179
function private apc_rus_enterend( vehicle, seatid, oldseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        apc_rus_enterendinternal( vehicle, seatid, oldseatid, player, data );
    }
    
    if ( istrue( vehicle.israllypointvehicle ) )
    {
        foreach ( plr in level.players )
        {
            if ( istrue( vehicle.revealed ) || is_equal( plr.team, vehicle.team ) )
            {
                scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( vehicle.marker.objidnum, plr );
            }
        }
        
        foreach ( occupant in vehicle.occupants )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom( vehicle.marker.objidnum, occupant );
        }
        
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( vehicle.marker.objidnum, player );
    }
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xf7b
// Size: 0x71
function private apc_rus_enterendinternal( vehicle, seatid, oldseatid, player, data )
{
    if ( seatid == "driver" )
    {
        player cameradefault();
        thread vehicle_occupancy_disablefirefortime( player, 100 );
    }
    
    vehomn_updateomnvarsonseatenter( vehicle, oldseatid, seatid, player );
    apc_rus_updateomnvarsonseatenter( vehicle, oldseatid, seatid, player );
    
    if ( seatid == "driver" )
    {
        vehicle thread apc_rus_monitordriverturretreload( player );
    }
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xff4
// Size: 0x46
function private apc_rus_exitend( vehicle, seatid, newseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        apc_rus_exitendinternal( vehicle, seatid, newseatid, player, data );
    }
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x1042
// Size: 0xc0
function private apc_rus_exitendinternal( vehicle, seatid, newseatid, player, data )
{
    if ( !istrue( data.playerdisconnect ) )
    {
        success = vehicle_occupancy_moveplayertoexit( vehicle, seatid, newseatid, player, data );
        
        if ( !success )
        {
            if ( issharedfuncdefined( "vehicle_occupancy", "handleSuicideFromVehicles" ) )
            {
                [[ getsharedfunc( "vehicle_occupancy", "handleSuicideFromVehicles" ) ]]( player );
            }
            else
            {
                player suicide();
            }
        }
        else if ( istrue( vehicle.israllypointvehicle ) )
        {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( vehicle.marker.objidnum, player );
        }
    }
    
    vehomn_updateomnvarsonseatexit( vehicle, seatid, newseatid, player );
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x110a
// Size: 0x17
function private apc_rus_update( data )
{
    vehicle_occupancy_updatemovefeedback( "driver" );
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1129
// Size: 0x30
function private apc_rus_monitordriverturretfire()
{
    self endon( "death" );
    apc_rus_updatedriverturretammoui();
    
    while ( true )
    {
        waittill_any_2( "vehicle_turret_fire", "vehicle_turret_reload_end" );
        apc_rus_updatedriverturretammoui();
    }
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1161
// Size: 0xc0
function private apc_rus_driverturretreload()
{
    turret = vehicle_getturretbyweapon( self, "iw9_tur_apc_russian_mp" );
    turret turretfiredisable();
    driver = vehicle_occupancy_getseatoccupant( self, "driver" );
    
    if ( isdefined( driver ) )
    {
        driver playlocalsound( "weap_bradley_reload_plr" );
    }
    
    foreach ( entry in level.teamnamelist )
    {
        self playsoundtoteam( "weap_bradley_reload_npc", entry, driver );
    }
    
    wait 2.7;
    apc_rus_adjustdriverturretammo( function_96cda9bdf4fd4440() );
    wait 0.15;
    turret turretfireenable();
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1229
// Size: 0x16e
function private apc_rus_monitordriverturretreload( driver )
{
    self endon( "death" );
    
    if ( isdefined( driver ) )
    {
        driver endon( "vehicle_change_seat" );
        driver endon( "vehicle_seat_exit" );
        driver endon( "death_or_disconnect" );
        
        while ( driver reloadbuttonpressed() )
        {
            waitframe();
        }
        
        var_33193f537b85b6d4 = getdvarint( @"hash_9402582f8123db99", 250 ) / 1000;
        
        while ( true )
        {
            holdtime = 0;
            usereloadconfig = driver getcurrentusereloadconfig();
            var_72e25a59fcef57b5 = 0;
            
            while ( driver reloadbuttonpressed() )
            {
                if ( !driver usinggamepad() && self function_ab2bddb6cd03a29d() < weaponclipsize( "iw9_tur_apc_russian_mp" ) )
                {
                    self function_4012509dbd1cee6f();
                    var_72e25a59fcef57b5 = 1;
                    apc_rus_updatedriverturretammoui();
                    break;
                }
                
                if ( self function_ab2bddb6cd03a29d() < weaponclipsize( "iw9_tur_apc_russian_mp" ) && usereloadconfig > 0 && holdtime >= var_33193f537b85b6d4 )
                {
                    self function_4012509dbd1cee6f();
                    var_72e25a59fcef57b5 = 1;
                    apc_rus_updatedriverturretammoui();
                }
                
                holdtime += level.framedurationseconds;
                waitframe();
            }
            
            if ( !var_72e25a59fcef57b5 && driver usinggamepad() && self function_ab2bddb6cd03a29d() < weaponclipsize( "iw9_tur_apc_russian_mp" ) && ( usereloadconfig == 0 && holdtime > 0 && holdtime < 0.2 || usereloadconfig > 0 && holdtime >= var_33193f537b85b6d4 ) )
            {
                self function_4012509dbd1cee6f();
                apc_rus_updatedriverturretammoui();
            }
            
            waitframe();
        }
    }
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x139f
// Size: 0x6b
function private apc_rus_adjustdriverturretammo( amount )
{
    turret = vehicle_getturretbyweapon( self, "iw9_tur_apc_russian_mp" );
    turret.shotsleft += amount;
    turret.shotsleft = int( clamp( turret.shotsleft, 0, function_96cda9bdf4fd4440() ) );
    apc_rus_updatedriverturretammoui();
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1412
// Size: 0x4e
function private function_96cda9bdf4fd4440()
{
    if ( isdefined( level.var_468b95f3865fa8d3 ) )
    {
        count = [[ level.var_468b95f3865fa8d3 ]]( self );
        
        if ( isdefined( count ) )
        {
            return count;
        }
    }
    
    leveldataforvehicle = vehicle_getleveldataforvehicle( "apc_russian" );
    return leveldataforvehicle.var_528c63bf357fb963;
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1469
// Size: 0x35
function private apc_rus_updateomnvarsonseatenter( vehicle, oldseatid, seatid, player )
{
    if ( seatid == "driver" )
    {
        vehicle apc_rus_updatedriverturretammoui();
    }
}

// Namespace namespace_619f08f8f135db64 / namespace_360524ba57254f3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x14a6
// Size: 0x37
function private apc_rus_updatedriverturretammoui()
{
    driver = vehicle_occupancy_getseatoccupant( self, "driver" );
    
    if ( isdefined( driver ) )
    {
        vehomn_setammo( "apc_russian", "driverTurret", self function_ab2bddb6cd03a29d(), driver );
    }
}

