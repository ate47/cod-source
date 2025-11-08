#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_utility;
#using scripts\engine\utility;

#namespace vehicle_collision;

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 0
// Checksum 0x0, Offset: 0x225
// Size: 0x9c
function vehicle_collision_init()
{
    assertex( isdefined( level.vehicle ), "<dev string:x1c>" );
    
    if ( issharedfuncdefined( "vehicle_collision", "init" ) )
    {
        [[ getsharedfunc( "vehicle_collision", "init" ) ]]();
    }
    
    level.var_f2a4f97f05f255f1 = getdvarint( @"hash_72990c24f27d9759", 1 ) == 1;
    level.var_1a644e62fd06f9fb = getdvarint( @"hash_51781d75e2ddda6a", 1 ) == 1;
    level.var_9d53e72e2ab97f5 = getdvarfloat( @"hash_ba56da9845f4904f", 1 );
    thread vehicle_collision_update();
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 0
// Checksum 0x0, Offset: 0x2c9
// Size: 0x1c
function vehicle_collision_update()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level.var_29fa8b0c83a6cc5f = [];
        waitframe();
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1
// Checksum 0x0, Offset: 0x2ed
// Size: 0x3da
function vehicle_collision_updateinstance( vehicle )
{
    level endon( "game_ended" );
    assertex( vehicle isvehicle(), "<dev string:x56>" );
    data = vehicle_collision_getleveldataforvehicle( vehicle.vehiclename, 0, 1 );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    handleworldcollision = undefined;
    
    if ( issharedfuncdefined( vehicle function_d93ec4635290febd(), "handleWorldCollision" ) )
    {
        handleworldcollision = getsharedfunc( vehicle function_d93ec4635290febd(), "handleWorldCollision" );
    }
    
    vehicle notify( "vehicle_collision_updateInstance" );
    vehicle endon( "vehicle_collision_updateInstance" );
    vehicle endon( "death" );
    vehiclenum = vehicle getentitynumber();
    var_26170c216671748f = gettime() + 5000;
    vehicle vehphys_enablecollisioncallback( 1 );
    
    while ( isdefined( vehicle ) )
    {
        vehicle waittill( "collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
        
        if ( isdefined( ent ) && istrue( ent.iscrossbowbolt ) )
        {
            continue;
        }
        
        function_593a829032a8c193( vehicle, ent );
        
        if ( isdefined( vehicle.var_4b75a4ee07200d3b ) && !ent isvehicle() && isdefined( ent.classname ) && ent.classname != "worldspawn" )
        {
            [[ vehicle.var_4b75a4ee07200d3b ]]( vehicle, ent );
        }
        
        if ( isdefined( handleworldcollision ) && ( !isdefined( ent ) || !isdefined( ent.classname ) || ent.classname == "worldspawn" || ent == vehicle ) )
        {
            vehicle thread [[ handleworldcollision ]]( position );
        }
        
        if ( istrue( vehicle.var_9882cd795c6bfaa ) )
        {
            continue;
        }
        
        if ( gettime() < var_26170c216671748f )
        {
            continue;
        }
        
        if ( isdefined( level.var_29fa8b0c83a6cc5f[ vehiclenum ] ) || isdefined( ent ) && isdefined( ent getentitynumber() ) && ent isvehicle() && isdefined( level.var_29fa8b0c83a6cc5f[ ent getentitynumber() ] ) )
        {
            continue;
        }
        
        var_42a333103449127c = isdefined( ent ) && isent( ent ) && isdefined( ent getentitynumber() ) && ent isvehicle() && ent != vehicle;
        level.var_29fa8b0c83a6cc5f[ vehiclenum ] = 1;
        
        if ( var_42a333103449127c )
        {
            level.var_29fa8b0c83a6cc5f[ ent getentitynumber() ] = 1;
        }
        
        if ( level.var_f2a4f97f05f255f1 )
        {
            if ( !var_42a333103449127c && isdefined( partenum ) && partenum == 5 )
            {
                level thread function_74ce9dc0a18ac393( vehicle, position, normal, normalspeed );
            }
            else
            {
                level thread function_10d733624bfda604( vehicle, ent, body0, body1, flag0, flag1, position, normal, normalspeed, partenum );
            }
        }
        
        if ( var_42a333103449127c )
        {
            foreach ( tempvehicle in [ vehicle, ent ] )
            {
                if ( isdefined( tempvehicle.handleeventcallback ) )
                {
                    tempvehicle [[ tempvehicle.handleeventcallback ]]( array_remove( [ vehicle, ent ], tempvehicle )[ 0 ] );
                }
                
                leveldataforvehicle = vehicle_collision_getleveldataforvehicle( tempvehicle function_d93ec4635290febd(), 0, 1 );
                
                if ( !isdefined( leveldataforvehicle ) )
                {
                    continue;
                }
                
                if ( isdefined( leveldataforvehicle.handleeventcallback ) )
                {
                    [[ leveldataforvehicle.handleeventcallback ]]( vehicle, ent, position, normal, normalspeed );
                }
            }
        }
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0x6cf
// Size: 0x726
function private function_10d733624bfda604( vehicle, otherent, body0, body1, flag0, flag1, position, normal, normalspeed, partenum )
{
    var_8d948973eddceb98 = function_67d6d7481d8ac827( vehicle );
    var_dfc13ccee5420527 = function_67d6d7481d8ac827( otherent );
    waitframe();
    var_ef174a6cfa1abcdd = function_3066f0dd7be2478c( vehicle );
    var_fdd958d93299102c = function_3066f0dd7be2478c( otherent );
    var_7b2c3e974fa33cf2 = isdefined( otherent ) && otherent isvehicle() && function_89dc39dc11f3988c( otherent function_d93ec4635290febd() ) && isdefined( function_29b4292c92443328( otherent function_d93ec4635290febd() ).damage ) && isdefined( vehicle );
    impulse = length( var_ef174a6cfa1abcdd - var_8d948973eddceb98 ) + length( var_dfc13ccee5420527 - var_fdd958d93299102c );
    var_2b2c1e04df704f3 = undefined;
    var_556fb0d021203d03 = undefined;
    
    if ( !var_7b2c3e974fa33cf2 )
    {
        if ( isdefined( otherent ) && otherent isvehicle() && isdefined( otherent.maxhealth ) )
        {
            var_2b2c1e04df704f3 = otherent;
        }
        else if ( isdefined( vehicle ) && isdefined( vehicle.maxhealth ) )
        {
            var_2b2c1e04df704f3 = vehicle;
        }
        else
        {
            return;
        }
        
        ref = var_2b2c1e04df704f3 function_d93ec4635290febd();
        
        if ( !isdefined( ref ) )
        {
            return;
        }
        
        if ( !function_89dc39dc11f3988c( ref ) )
        {
            return;
        }
        
        if ( !level.var_1a644e62fd06f9fb && isdefined( var_2b2c1e04df704f3.riders ) && var_2b2c1e04df704f3.riders.size > 0 )
        {
            return;
        }
        
        alldata = function_29b4292c92443328( ref );
        
        if ( !isdefined( alldata ) || !isdefined( alldata.damage ) )
        {
            return;
        }
        
        var_556fb0d021203d03 = alldata.damage;
        multiplier = 1;
        
        if ( var_2b2c1e04df704f3 isfloating() )
        {
            multiplier = default_to( var_556fb0d021203d03.var_6c10b5dc07fd6459, 1 );
        }
        else
        {
            multiplier = default_to( var_556fb0d021203d03.var_5c7f497b7ee6ee55, 1 );
        }
        
        if ( multiplier <= 0 )
        {
            return;
        }
        
        impulse *= multiplier;
    }
    
    /#
        if ( false )
        {
            debugaxis( position, vectortoangles( normal ), impulse / 5, 1, 0, 400 );
        }
    #/
    
    if ( isdefined( otherent.var_96419179a661cf96 ) )
    {
        vehicle [[ otherent.var_96419179a661cf96 ]]( otherent, impulse );
        return;
    }
    
    damagepercentage = 1;
    radius = 35;
    
    if ( impulse > 650 )
    {
        damagepercentage = 1;
        radius = 110;
        
        /#
            if ( false )
            {
                level thread scripts\cp_mp\utility\debug_utility::drawsphere( position, radius, 20, ( 1, 0, 0 ) );
            }
        #/
    }
    else if ( impulse > 450 )
    {
        damagepercentage = 0.75;
        radius = 90;
        
        /#
            if ( false )
            {
                level thread scripts\cp_mp\utility\debug_utility::drawsphere( position, radius, 20, ( 1, 0, 1 ) );
            }
        #/
    }
    else if ( impulse > 275 )
    {
        damagepercentage = 0.5;
        radius = 75;
        
        /#
            if ( false )
            {
                level thread scripts\cp_mp\utility\debug_utility::drawsphere( position, radius, 20, ( 0, 1, 0 ) );
            }
        #/
    }
    else
    {
        return;
    }
    
    if ( var_7b2c3e974fa33cf2 )
    {
        basedata = function_29b4292c92443328( vehicle function_d93ec4635290febd() ).damage;
        otherdata = function_29b4292c92443328( otherent function_d93ec4635290febd() ).damage;
        baseclass = default_to( basedata.class, "medium" );
        otherclass = default_to( otherdata.class, "medium" );
        [ baseweightratio, otherweightratio ] = function_1ab37f5b6734e44d( baseclass, otherclass );
        [ basespeedratio, otherspeedratio ] = function_dcbd541c875c2d66( length( var_8d948973eddceb98 ), length( var_dfc13ccee5420527 ) );
        basedamage = ter_op( isdefined( vehicle.maxhealth ), vehicle.maxhealth, 1 ) * 2 * damagepercentage * basespeedratio * baseweightratio * function_53c04cefb8acf030( baseclass ) * level.var_9d53e72e2ab97f5;
        otherdamage = ter_op( isdefined( otherent.maxhealth ), otherent.maxhealth, 1 ) * 2 * damagepercentage * otherspeedratio * otherweightratio * function_53c04cefb8acf030( otherclass ) * level.var_9d53e72e2ab97f5;
        vehicledriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( vehicle );
        otherdriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( otherent );
        
        if ( istrue( basedata.skipburndown ) )
        {
            vehicle vehicle_damage_disablestatedamagefloor( 1 );
        }
        
        if ( istrue( otherdata.skipburndown ) )
        {
            otherent vehicle_damage_disablestatedamagefloor( 1 );
        }
        
        vehicle dodamage( int( basedamage ), position, otherdriver, otherent, "MOD_CRUSH", otherent.objweapon );
        otherent dodamage( int( otherdamage ), position, vehicledriver, vehicle, "MOD_CRUSH", vehicle.objweapon );
        vehicle vehicle_damage_disablestatedamagefloor( 0 );
        otherent vehicle_damage_disablestatedamagefloor( 0 );
        function_9c23735bf7534afa( vehicle, basedamage * 0.75, position, radius );
        function_9c23735bf7534afa( otherent, otherdamage * 0.75, position, radius );
        
        if ( otherspeedratio > 0.9 && isdefined( vehicle.owner ) && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer( otherent, vehicle.owner ) )
        {
            vehicle.owner scripts\cp_mp\challenges::reportVehicleEvent( vehicle, "high_speed_ram" );
        }
        else if ( basespeedratio > 0.9 && isdefined( otherent.owner ) && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer( vehicle, otherent.owner ) )
        {
            otherent.owner scripts\cp_mp\challenges::reportVehicleEvent( otherent, "high_speed_ram" );
        }
        
        return;
    }
    
    damage = var_2b2c1e04df704f3.maxhealth * function_278754969816f33a( default_to( var_556fb0d021203d03.class, "medium" ) );
    
    if ( istrue( var_2b2c1e04df704f3.var_6df468049c1f41dc ) )
    {
        damage = var_2b2c1e04df704f3.maxhealth;
    }
    
    function_9c23735bf7534afa( var_2b2c1e04df704f3, damage * 0.75, position, radius );
    
    if ( damage <= 0 || damagepercentage <= 0.5 )
    {
        return;
    }
    
    if ( istrue( var_556fb0d021203d03.skipburndown ) )
    {
        var_2b2c1e04df704f3 vehicle_damage_disablestatedamagefloor( 1 );
    }
    
    var_2b2c1e04df704f3 dodamage( int( damage ), position, undefined, undefined, "MOD_CRUSH" );
    var_2b2c1e04df704f3 vehicle_damage_disablestatedamagefloor( 0 );
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0xdfd
// Size: 0x3f9
function private function_74ce9dc0a18ac393( vehicle, position, normal, timeinair )
{
    var_a291b7ea9e74500f = -1 * ips_to_mph( vehicle vehicle_getvelocity()[ 2 ] );
    
    if ( var_a291b7ea9e74500f < 15 )
    {
        return;
    }
    
    data = function_29b4292c92443328( vehicle function_d93ec4635290febd() ).damage;
    multiplier = default_to( data.falldamagemultiplier, 1 );
    
    if ( multiplier <= 0 )
    {
        return;
    }
    
    timeinair *= multiplier;
    var_89134acb0056de26 = [ 2, 2.75, 3.5, 4.5, 10 ];
    
    if ( getdvarint( @"hash_12ca000dd2976ebc", 0 ) )
    {
        var_89134acb0056de26 = [ 4.5, 6, 7.5, 9.5, 15 ];
    }
    
    damagetier = 0;
    
    for ( tier = var_89134acb0056de26.size; tier > 0 ; tier-- )
    {
        var_7c462121dd5c5ae0 = var_89134acb0056de26[ tier - 1 ];
        
        if ( timeinair > var_7c462121dd5c5ae0 )
        {
            damagetier = tier;
            break;
        }
    }
    
    if ( !damagetier )
    {
        return;
    }
    
    /#
        if ( false )
        {
            color = ( 1, 0, 0 );
            
            switch ( damagetier )
            {
                case 5:
                    color = ( 1, 0, 0 );
                    break;
                case 4:
                    color = ( 1, 1, 0 );
                    break;
                case 3:
                    color = ( 0, 0, 1 );
                    break;
                case 2:
                    color = ( 0, 1, 1 );
                    break;
                case 1:
                    color = ( 0, 1, 0 );
                    break;
                default:
                    break;
            }
            
            print3d( position, "<dev string:x9e>" + timeinair + "<dev string:xa8>" + damagetier, color, 1, 1, 4000 );
            debugaxis( position, vectortoangles( normal ), 16, 1, 0, 4000 );
        }
    #/
    
    damagepercentage = 1;
    wheeldamage = 50;
    wheelstodamage = 0;
    
    switch ( damagetier )
    {
        case 5:
            damagepercentage = 1;
            wheeldamage = 250;
            wheelstodamage = 4;
            break;
        case 4:
            damagepercentage = 0.8;
            wheeldamage = 250;
            wheelstodamage = 4;
            break;
        case 3:
            damagepercentage = 0.6;
            wheeldamage = 150;
            wheelstodamage = 2;
            break;
        case 2:
            damagepercentage = 0.4;
            wheeldamage = 100;
            wheelstodamage = 1;
            break;
        case 1:
            damagepercentage = 0.2;
            wheeldamage = 40;
            wheelstodamage = 1;
            break;
        default:
            break;
    }
    
    function_ecdf1217e332c7d7( vehicle, wheeldamage, position, wheelstodamage );
    class = default_to( data.class, "medium" );
    damage = function_a991a29602381df7( class ) * damagepercentage * vehicle.maxhealth;
    
    if ( istrue( data.skipburndown ) )
    {
        vehicle vehicle_damage_disablestatedamagefloor( 1 );
    }
    
    vehicle dodamage( int( damage ), position, undefined, undefined, "MOD_CRUSH" );
    vehicle vehicle_damage_disablestatedamagefloor( 0 );
    
    if ( timeinair > 5 && isdefined( vehicle.owner ) )
    {
        vehicle.owner scripts\cp_mp\challenges::reportVehicleEvent( vehicle, "vehicle_hang_time" );
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x11fe
// Size: 0x204
function private function_593a829032a8c193( vehicle, ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    ent = default_to( ent.cover, ent );
    
    if ( isdefined( ent.equipmentref ) && ent.equipmentref == "equip_tac_cover" && isdefined( ent.deletefunc ) && !istrue( ent.ishitbyvehicle ) )
    {
        ent.ishitbyvehicle = 1;
        ent thread [[ ent.deletefunc ]]( undefined, 0, 0 );
        return;
    }
    
    if ( isdefined( ent.weapon_name ) && ent.weapon_name == "deployed_decoy_mp" )
    {
        ent thread [[ ent.entdeletefunc ]]();
        return;
    }
    
    if ( is_equal( ent.classname, "misc_turret" ) || isdefined( ent.turretowner ) && is_equal( ent.turretowner.classname, "misc_turret" ) )
    {
        if ( ent.classname == "misc_turret" )
        {
            turret = ent;
        }
        else if ( isdefined( ent.turretowner ) && is_equal( ent.turretowner.classname, "misc_turret" ) )
        {
            turret = ent.turretowner;
        }
        
        turret_parent = turret getlinkedparent();
        
        if ( is_equal( turret_parent, vehicle ) )
        {
            return;
        }
        
        if ( isdefined( turret.hitbyvehiclefunc ) && !istrue( turret.ishitbyvehicle ) )
        {
            turret.ishitbyvehicle = 1;
            turret thread [[ turret.hitbyvehiclefunc ]]( vehicle );
        }
        
        return;
    }
    
    if ( vehicle function_bbdfa26a1db6eb7b() && isdefined( ent.escortcollisioncallback ) )
    {
        ent [[ ent.escortcollisioncallback ]]( vehicle );
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1
// Checksum 0x0, Offset: 0x140a
// Size: 0x5c
function function_3066f0dd7be2478c( vehicle )
{
    if ( !isdefined( vehicle ) || !isent( vehicle ) || !vehicle isvehicle() )
    {
        return ( 0, 0, 0 );
    }
    
    if ( isdefined( vehicle.velocity ) )
    {
        return vehicle.velocity;
    }
    
    return vehicle vehicle_getvelocity();
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1
// Checksum 0x0, Offset: 0x146e
// Size: 0x1d
function function_6eb1fba746b72f46( vehicle )
{
    return ips_to_mph( length( function_3066f0dd7be2478c( vehicle ) ) );
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1494
// Size: 0x5c
function private function_67d6d7481d8ac827( vehicle )
{
    if ( !isdefined( vehicle ) || !isent( vehicle ) || !vehicle isvehicle() )
    {
        return ( 0, 0, 0 );
    }
    
    if ( isdefined( vehicle.velocity ) )
    {
        return vehicle.velocity;
    }
    
    return vehicle function_c33dba6864d01d35();
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x14f8
// Size: 0x53
function private function_1ab37f5b6734e44d( damageclass1, damageclass2 )
{
    weight1 = function_a46de67ab094e684( damageclass1 );
    weight2 = function_a46de67ab094e684( damageclass2 );
    sum = weight1 + weight2;
    return [ weight2 / sum, weight1 / sum ];
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1554
// Size: 0x4b
function private function_dcbd541c875c2d66( speed1, speed2 )
{
    sum = speed1 + speed2;
    
    if ( sum <= 0 )
    {
        return [ 0.5, 0.5 ];
    }
    
    return [ speed2 / sum, speed1 / sum ];
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x15a8
// Size: 0xa5
function private function_a46de67ab094e684( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.1;
        case #"hash_d582c3286e5c390f":
            return 0.2;
        case #"hash_21622ca3ad06efb5":
            return 0.6;
        case #"hash_c71b112fe04823d6":
            return 1;
        case #"hash_53e0b558455f04c6":
            return 3;
        case #"hash_2453c9ffec9f5c20":
            return 5;
        case #"hash_e8ec392f4f2724e4":
            return 10;
        case #"hash_ee4a12a81f84ff3f":
            return 1000;
        default:
            return 1;
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1655
// Size: 0xaa
function private function_278754969816f33a( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.2;
        case #"hash_d582c3286e5c390f":
            return 0.15;
        case #"hash_21622ca3ad06efb5":
            return 0.1;
        case #"hash_c71b112fe04823d6":
            return 0.08;
        case #"hash_53e0b558455f04c6":
            return 0.05;
        case #"hash_2453c9ffec9f5c20":
            return 0.02;
        case #"hash_e8ec392f4f2724e4":
            return 0;
        case #"hash_ee4a12a81f84ff3f":
            return 0;
        default:
            return 0;
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1707
// Size: 0xb2
function private function_a991a29602381df7( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.6;
        case #"hash_d582c3286e5c390f":
            return 0.6;
        case #"hash_21622ca3ad06efb5":
            return 0.6;
        case #"hash_c71b112fe04823d6":
            return 0.6;
        case #"hash_53e0b558455f04c6":
            return 0.6;
        case #"hash_2453c9ffec9f5c20":
            return 0.5;
        case #"hash_e8ec392f4f2724e4":
            return 0.5;
        case #"hash_ee4a12a81f84ff3f":
            return 0;
        default:
            return 0.6;
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x17c1
// Size: 0xb2
function private function_53c04cefb8acf030( damageclass )
{
    switch ( damageclass )
    {
        case #"hash_d2a55c7ac538641b":
            return 0.6;
        case #"hash_d582c3286e5c390f":
            return 0.5;
        case #"hash_21622ca3ad06efb5":
            return 0.4;
        case #"hash_c71b112fe04823d6":
            return 0.3;
        case #"hash_53e0b558455f04c6":
            return 0.2;
        case #"hash_2453c9ffec9f5c20":
            return 0.15;
        case #"hash_e8ec392f4f2724e4":
            return 0.1;
        case #"hash_ee4a12a81f84ff3f":
            return 0;
        default:
            return 0.4;
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 3
// Checksum 0x0, Offset: 0x187b
// Size: 0x107
function vehicle_collision_getleveldataforvehicle( vehicleref, create, var_6ecb77fd1f27c667 )
{
    if ( istrue( create ) && ( !function_89dc39dc11f3988c( vehicleref ) || !isdefined( function_29b4292c92443328( vehicleref ).damage ) || !isdefined( function_29b4292c92443328( vehicleref ).damage.class ) ) )
    {
        data = undefined;
        
        if ( !function_89dc39dc11f3988c( vehicleref ) )
        {
            data = spawnstruct();
        }
        else
        {
            data = function_29b4292c92443328( vehicleref );
        }
        
        if ( !isdefined( data.damage ) )
        {
            data.damage = spawnstruct();
        }
        
        data.damage.ref = vehicleref;
        data.damage.class = "medium";
        level.var_a0b2c978ca57ffc5[ vehicleref ] = data;
    }
    
    if ( function_89dc39dc11f3988c( vehicleref ) )
    {
        return function_29b4292c92443328( vehicleref ).damage;
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 3
// Checksum 0x0, Offset: 0x198a
// Size: 0xb5
function vehicle_collision_ignorefutureevent( vehicle, othervehicle, duration )
{
    vehicle endon( "death" );
    
    if ( !isdefined( vehicle.vehcolignorelist ) )
    {
        vehicle.vehcolignorelist = [];
    }
    
    othervehicleid = othervehicle getentitynumber();
    vehicle.vehcolignorelist[ othervehicleid ] = othervehicle;
    wait duration;
    
    if ( isdefined( vehicle ) && isdefined( vehicle.vehcolignorelist ) )
    {
        vehicle.vehcolignorelist[ othervehicleid ] = undefined;
    }
    
    if ( isdefined( vehicle ) && isdefined( vehicle.vehcolignorelist ) && vehicle.vehcolignorelist.size == 0 )
    {
        vehicle.vehcolignorelist = undefined;
    }
}

// Namespace vehicle_collision / scripts\cp_mp\vehicles\vehicle_collision
// Params 2
// Checksum 0x0, Offset: 0x1a47
// Size: 0x6c, Type: bool
function function_d88aed99025a81e4( vehicle, vehicletarget )
{
    vehicletargetid = vehicletarget getentitynumber();
    
    if ( isdefined( vehicle.vehcolignorelist ) && isdefined( vehicle.vehcolignorelist.size ) && vehicle.vehcolignorelist.size > 0 )
    {
        if ( isdefined( vehicle.vehcolignorelist[ vehicletargetid ] ) )
        {
            return true;
        }
    }
    
    return false;
}

