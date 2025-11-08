#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\death;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\melee;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;

#namespace vehicle;

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4f7
// Size: 0x3c
function setvehiclearchetype( asmname, statename, params )
{
    self setoverridearchetype( "vehicle", self._blackboard.currentvehicleanimalias, 1 );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x53b
// Size: 0x2a
function clearvehiclearchetype( asmname, statename, params )
{
    self clearoverridearchetype( "vehicle", 0, 1 );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x56d
// Size: 0x7f, Type: bool
function function_35baeb62e712b6b4( asmname, statename, tostatename, params )
{
    if ( !isdefined( self._blackboard.currentvehicle ) )
    {
        return true;
    }
    
    var_a7f05f87335b6c63 = distancesquared( self.origin, self._blackboard.currentvehicle.origin );
    
    if ( var_a7f05f87335b6c63 > 50000 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 2
// Checksum 0x0, Offset: 0x5f5
// Size: 0x39, Type: bool
function function_b3bb4d116f5a79cb( currentvehicle, position )
{
    if ( isdefined( currentvehicle ) )
    {
        aianims = anim_pos( currentvehicle, position );
        return istrue( aianims.var_8af43e63a663dbd6 );
    }
    
    return false;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x637
// Size: 0xcd
function function_ef715d817b10b063()
{
    alias = "";
    
    if ( istrue( self.vehicleseatonleft ) )
    {
        alias += "_4";
    }
    else
    {
        alias += "_6";
    }
    
    if ( isdefined( self.enemy ) )
    {
        toenemy = self.enemy.origin - self.origin;
        toenemyyaw = angleclamp180( vectortoyaw( toenemy ) - self.angles[ 1 ] );
        
        if ( toenemyyaw < 0 )
        {
            alias += "_turn6";
        }
        else
        {
            alias += "_turn4";
        }
    }
    else if ( istrue( self.vehicleseatonleft ) )
    {
        alias += "_turn4";
    }
    else
    {
        alias += "_turn6";
    }
    
    return alias;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 1
// Checksum 0x0, Offset: 0x70d
// Size: 0x11b
function getpainalias( aianims )
{
    alias = "";
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    
    flashed = isflashed();
    
    if ( isdefined( self.damageyaw ) && !flashed )
    {
        if ( self.damageyaw > 135 )
        {
            alias += "_2";
        }
        else if ( self.damageyaw > 45 )
        {
            alias += "_4";
        }
        else if ( self.damageyaw > -45 )
        {
            alias += "_8";
        }
        else if ( self.damageyaw > -135 )
        {
            alias += "_6";
        }
        else
        {
            alias += "_2";
        }
    }
    
    if ( istrue( self.var_58e8388f04abb64e ) )
    {
        alias += "_lean";
    }
    
    return alias;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 1
// Checksum 0x0, Offset: 0x831
// Size: 0x83
function function_37da44a7cf24fdad( aianims )
{
    alias = "";
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    
    if ( istrue( self.var_58e8388f04abb64e ) )
    {
        alias += "_lean";
    }
    
    return alias;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x8bd
// Size: 0x3b
function chooseanim_vehicle( asmname, statename, params )
{
    return asm_lookupanimfromalias( statename, string( self._blackboard.var_9176cae5619d7fba ) );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x901
// Size: 0x11c
function function_93584fe710642bd2( asmname, statename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        alias += getpainalias( aianims );
    }
    
    animresult = archetypegetrandomalias( arcname, statename, alias, asm_isfrantic() );
    
    if ( isdefined( animresult ) )
    {
        return asm_lookupanimfromalias( statename, alias );
    }
    
    return asm_lookupanimfromalias( statename, string( self._blackboard.var_9176cae5619d7fba ) );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0xa25
// Size: 0xd7
function function_47a713aa81f9ae9e( asmname, statename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        alias += function_37da44a7cf24fdad( aianims );
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 1
// Checksum 0x0, Offset: 0xb05
// Size: 0xac
function function_179d01a77dc31f73( alias )
{
    toenemy = self.enemy.origin - self.origin;
    toenemyyaw = angleclamp180( vectortoyaw( toenemy ) - self.angles[ 1 ] );
    
    if ( toenemyyaw > 135 )
    {
        alias += "_2";
    }
    else if ( toenemyyaw > 45 )
    {
        alias += "_4";
    }
    else if ( toenemyyaw > -45 )
    {
        alias += "_8";
    }
    else if ( toenemyyaw > -135 )
    {
        alias += "_6";
    }
    else
    {
        alias += "_2";
    }
    
    return alias;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0xbba
// Size: 0xf0
function function_5b4b5fffac712ed5( asmname, statename, params )
{
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    
    alias = function_179d01a77dc31f73( alias );
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0xcb3
// Size: 0xe7
function function_9cc47d66814e0219( asmname, statename, params )
{
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0xda3
// Size: 0x24
function function_71542e68d0fa0478( asmname, statename, params )
{
    return chooseanim_vehicle( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0xdd0
// Size: 0x7d
function function_b2e6831f01246042( asmname, statename, params )
{
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( isdefined( self.vehicleseatonleft ) )
    {
        switchsidesalias = function_ef715d817b10b063();
        alias += switchsidesalias;
        self.vehicleseatonleft = !self.vehicleseatonleft;
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0xe56
// Size: 0x185
function function_7f09702cf0b2e4b5( asmname, statename, params )
{
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        if ( isdefined( self.enemy ) )
        {
            vehicle = self._blackboard.currentvehicle;
            position = self._blackboard.var_9176cae5619d7fba;
            aianims = anim_pos( vehicle, position );
            tovehicle = self.enemy.origin - vehicle.origin;
            var_b948350ee67e31fb = angleclamp180( vectortoyaw( tovehicle ) - vehicle.angles[ 1 ] );
            
            if ( var_b948350ee67e31fb < 0 )
            {
                alias += "_6";
            }
            else
            {
                alias += "_4";
            }
            
            if ( isdefined( self.vehicleseatonleft ) && ( var_b948350ee67e31fb < 0 && self.vehicleseatonleft || var_b948350ee67e31fb > 0 && !self.vehicleseatonleft ) )
            {
                self.vehicleseatonleft = !self.vehicleseatonleft;
            }
        }
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0xfe4
// Size: 0xba
function function_f96dcce7d9cc58a5( asmname, statename, params )
{
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        vehicle = self._blackboard.currentvehicle;
        
        if ( isdefined( vehicle.var_c4ec8708d1cba967 ) && isdefined( vehicle.var_c50f7508d1f1c989 ) )
        {
            self.var_5c7a1cd1128675f5 = gettime() + randomintrange( vehicle.var_c4ec8708d1cba967, vehicle.var_c50f7508d1f1c989 );
        }
    }
    
    return function_9cc47d66814e0219( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x10a7
// Size: 0x1a0, Type: bool
function function_6fd8668b4581ef1c( asmname, statename, tostatename, params )
{
    if ( !isdefined( self._blackboard.currentvehicle ) )
    {
        return false;
    }
    
    if ( !function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        return false;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    if ( !isdefined( self._blackboard.var_9176cae5619d7fba ) || !isdefined( self._blackboard.currentvehicle ) )
    {
        return false;
    }
    
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_9176cae5619d7fba;
    aianims = anim_pos( vehicle, position );
    tovehicle = self.enemy.origin - vehicle.origin;
    var_b948350ee67e31fb = angleclamp180( vectortoyaw( tovehicle ) - vehicle.angles[ 1 ] );
    
    if ( abs( var_b948350ee67e31fb ) > 179 || abs( var_b948350ee67e31fb ) < 1 )
    {
        return false;
    }
    
    if ( isdefined( self.vehicleseatonleft ) && ( var_b948350ee67e31fb < 0 && self.vehicleseatonleft || var_b948350ee67e31fb > 0 && !self.vehicleseatonleft ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x1250
// Size: 0x3d, Type: bool
function function_e692591195808b8a( asmname, statename, tostatename, param )
{
    return vehiclehasalias( asmname, statename, tostatename, param ) && self [[ self.fnisinstealthidle ]]();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x1296
// Size: 0x2f
function function_6bc1a54175023072( asmname, statename, tostatename, param )
{
    return self [[ self.fnisinstealthidle ]]();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x12ce
// Size: 0x3d, Type: bool
function function_5cfc1f1b9c10e164( asmname, statename, tostatename, param )
{
    return vehiclehasalias( asmname, statename, tostatename, param ) && self [[ self.fnisinstealthcombat ]]();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x1314
// Size: 0x66, Type: bool
function vehicleincombat( asmname, statename, tostatename, params )
{
    if ( weaponclass( self.weapon ) == "rocketlauncher" && !istrue( self.vehiclerpg ) )
    {
        return false;
    }
    
    return asm_getdemeanor() == "combat" && !self [[ self.fnisinstealthhunt ]]();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x1383
// Size: 0x124, Type: bool
function function_222ef5b005c37d77( asmname, statename, tostatename, param )
{
    if ( !isdefined( self._blackboard.currentvehicle ) )
    {
        return false;
    }
    
    if ( !function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        return false;
    }
    
    vehicle = self._blackboard.currentvehicle;
    
    if ( !isdefined( vehicle.var_c4ec8708d1cba967 ) || !isdefined( vehicle.var_c50f7508d1f1c989 ) )
    {
        return false;
    }
    
    if ( !isdefined( self.var_5c7a1cd1128675f5 ) )
    {
        self.var_5c7a1cd1128675f5 = gettime() + randomintrange( vehicle.var_c4ec8708d1cba967, vehicle.var_c50f7508d1f1c989 );
    }
    
    if ( gettime() > self.var_5c7a1cd1128675f5 )
    {
        self.var_5c7a1cd1128675f5 = gettime() + randomintrange( vehicle.var_c4ec8708d1cba967, vehicle.var_c50f7508d1f1c989 );
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x14b0
// Size: 0x13a, Type: bool
function function_925c10bfb5db43d0( asmname, statename, tostatename, param )
{
    if ( !isdefined( self._blackboard.currentvehicle ) || !isdefined( self._blackboard.currentvehicle.var_df380f11aba27f75 ) )
    {
        return false;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    aianims = anim_pos( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba );
    var_5345a5d80b9177ed = gettime() > self._blackboard.currentvehicle.var_df380f11aba27f75 || istrue( aianims.var_b6cfb5b21c28c002 );
    
    if ( function_1746ad7c74ead3e8( asmname, statename, tostatename, param ) && var_5345a5d80b9177ed )
    {
        self._blackboard.currentvehicle.var_df380f11aba27f75 = gettime() + self._blackboard.currentvehicle.var_13b94e70465e220d;
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x15f3
// Size: 0x37, Type: bool
function function_1ef6637ea6bf8c1f( asmname, statename, tostatename, param )
{
    return vehiclehasalias( asmname, statename, tostatename, param ) && scripts\asm\asm_bb::bb_iswhizbyrequested();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x1633
// Size: 0x2b9
function function_d4533dcc81147462( asmname, statename, param )
{
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( isdefined( archetypegetrandomalias( self._blackboard.currentvehicleanimalias, statename, alias, asm_isfrantic() ) ) )
    {
        return asm_lookupanimfromalias( statename, alias );
    }
    
    alias = alias + "_" + self._blackboard.vehicledir;
    assertex( isdefined( self.collision_data ), "Vehicle Impulse Response requires collision data to exists. This data should be initialized when a collision is detected by VehicleCollisionWatcher" );
    vehicle = self._blackboard.currentvehicle;
    forward = anglestoforward( vehicle.angles );
    normal = self.collision_data.normal;
    function_535f605646d65a4d();
    
    /#
        setdvarifuninitialized( @"hash_e4eece17e1ee5b59", 0 );
    #/
    
    ccos45 = 0.70711;
    forwarddotimpact = vectordot( forward, normal );
    
    if ( forwarddotimpact > ccos45 )
    {
        alias += "_2";
        
        /#
            if ( getdvarint( @"hash_e4eece17e1ee5b59" ) != 0 )
            {
                print3d( self.origin, alias, ( 0, 1, 0 ), 1, 0.5, 100, 1 );
            }
        #/
        
        return asm_lookupanimfromalias( statename, alias );
    }
    else if ( forwarddotimpact < -1 * ccos45 )
    {
        alias += "_8";
        
        /#
            if ( getdvarint( @"hash_e4eece17e1ee5b59" ) != 0 )
            {
                print3d( self.origin, alias, ( 0, 1, 0 ), 1, 0.5, 100, 1 );
            }
        #/
        
        return asm_lookupanimfromalias( statename, alias );
    }
    
    var_82623b1112d975b4 = vectorcross( forward, normal );
    
    if ( var_82623b1112d975b4[ 2 ] > 0 )
    {
        alias += "_6";
        
        /#
            if ( getdvarint( @"hash_e4eece17e1ee5b59" ) != 0 )
            {
                print3d( self.origin, alias, ( 0, 1, 0 ), 1, 0.5, 100, 1 );
            }
        #/
        
        return asm_lookupanimfromalias( statename, alias );
    }
    
    alias += "_4";
    
    /#
        if ( getdvarint( @"hash_e4eece17e1ee5b59" ) != 0 )
        {
            print3d( self.origin, alias, ( 0, 1, 0 ), 1, 0.5, 100, 1 );
        }
    #/
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x18f5
// Size: 0x24c
function function_3a547f046d6592a( asmname, statename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    else if ( isdefined( self._blackboard.vehicledir ) && self._blackboard.vehicledir != 8 )
    {
        alias = alias + "_" + self._blackboard.vehicledir;
    }
    
    weaponclassalias = "_" + weaponclass( self.weapon );
    var_fdc520e439ffb47c = archetypegetrandomalias( arcname, statename, alias + weaponclassalias, asm_isfrantic() );
    
    if ( isdefined( var_fdc520e439ffb47c ) )
    {
        return asm_lookupanimfromalias( statename, alias + weaponclassalias );
    }
    
    animresult = archetypegetrandomalias( arcname, statename, alias, asm_isfrantic() );
    
    if ( isdefined( animresult ) )
    {
        return asm_lookupanimfromalias( statename, alias );
    }
    
    var_fdc520e439ffb47c = archetypegetrandomalias( arcname, statename, string( self._blackboard.var_9176cae5619d7fba ) + weaponclassalias, asm_isfrantic() );
    
    if ( isdefined( var_fdc520e439ffb47c ) )
    {
        return asm_lookupanimfromalias( statename, string( self._blackboard.var_9176cae5619d7fba ) + weaponclassalias );
    }
    
    return asm_lookupanimfromalias( statename, string( self._blackboard.var_9176cae5619d7fba ) );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x1b49
// Size: 0x27
function chooseanim_vehicleturret( asmname, statename, params )
{
    return asm_lookupanimfromalias( statename, "blank" );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x1b79
// Size: 0x27
function chooseanim_vehicleturretdeath( asmname, statename, params )
{
    return asm_lookupanimfromalias( statename, "vehicle_turret_death" );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 6
// Checksum 0x0, Offset: 0x1ba9
// Size: 0x157
function getvehicleanimtargetoriginandangles( vehicle, vehicleanim, vehicletag, vehiclelocation, vehicleangles, animendfrac )
{
    result = [];
    
    if ( !isdefined( animendfrac ) )
    {
        animendfrac = 1;
    }
    
    if ( isdefined( vehicle ) && isdefined( vehicletag ) )
    {
        tagorigin = vehicle gettagorigin( vehicletag );
        tagangles = vehicle gettagangles( vehicletag );
        startorigin = getstartorigin( tagorigin, tagangles, vehicleanim );
        startangles = getstartangles( tagorigin, tagangles, vehicleanim );
        movedelta = getmovedelta( vehicleanim, 0, animendfrac );
        anglesdelta = getangledelta3d( vehicleanim, 0, animendfrac )[ 1 ];
        result[ "startOrigin" ] = startorigin;
        result[ "startAngles" ] = startangles;
        result[ "targetOrigin" ] = rotatevector( movedelta, startangles ) + startorigin;
        result[ "targetAngles" ] = ( startangles[ 0 ], angleclamp( startangles[ 1 ] + anglesdelta ), startangles[ 2 ] );
    }
    else
    {
        result[ "startOrigin" ] = self.origin;
        result[ "startAngles" ] = self.angles;
        result[ "targetOrigin" ] = vehiclelocation;
        result[ "targetAngles" ] = vehicleangles;
    }
    
    return result;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x1d09
// Size: 0x1f8
function linktovehicle( org, ang, linktoblend, sittag )
{
    self forceteleport( org, ang );
    
    if ( istrue( linktoblend ) )
    {
        self linktoblendtotag( self._blackboard.currentvehicle, sittag, 0 );
    }
    else
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        
        if ( isdefined( aianims.linkoffset ) && isdefined( aianims.linkangle ) )
        {
            self linktomoveoffset( self._blackboard.currentvehicle, sittag, aianims.linkoffset, aianims.linkangle );
        }
        else if ( istrue( self._blackboard.currentvehicle.var_9e0ade9f6d9a6b3 ) )
        {
            self linktomoveoffset( self._blackboard.currentvehicle, sittag );
        }
        else
        {
            self linktomoveoffset( self._blackboard.currentvehicle, sittag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
    }
    
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_9176cae5619d7fba;
    
    if ( isdefined( vehicle ) && isdefined( position ) )
    {
        aianims = anim_pos( vehicle, position );
        
        if ( isdefined( aianims.onleft ) )
        {
            self.vehicleseatonleft = aianims.onleft;
        }
    }
    
    if ( isagent( self ) )
    {
        self playerlinkedoffsetenable();
        self fixlinktointerpolationbug( 1 );
    }
    
    self._blackboard.linkedtovehicle = 1;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 2
// Checksum 0x0, Offset: 0x1f09
// Size: 0x298
function faceenemyincombat( asmname, statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        canshootinvehicle = istrue( self._blackboard.var_6a69fa6b0b354c93 ) && istrue( self.canshootinvehicle );
        canrotate = isdefined( self._blackboard.currentvehicle ) && !istrue( self._blackboard.currentvehicle.vehicledisableturningwhileshooting );
        enemyisalive = isdefined( self.enemy ) && ( !( isplayer( self.enemy ) || isai( self.enemy ) ) || isalive( self.enemy ) );
        incombat = vehicleincombat( asmname, statename, statename );
        
        if ( incombat && enemyisalive && canshootinvehicle && canrotate )
        {
            axis = anglestoaxis( self._blackboard.currentvehicle.angles );
            forward = axis[ "forward" ];
            up = axis[ "up" ];
            yaw = getyaw( self.enemy.origin ) - self._blackboard.currentvehicle.angles[ 1 ];
            yaw = angleclamp180( yaw );
            facing = rotatepointaroundvector( up, forward, yaw );
            faceangles = axistoangles( facing, vectorcross( facing, up ), up );
            self orientmode( "face angle 3d", faceangles );
        }
        else
        {
            self orientmode( "face current angles" );
        }
        
        /#
            if ( getdvarint( @"hash_e8e7feb9b789f1d7" ) && incombat )
            {
                sphere( self.origin + ( 0, 0, 40 ), 2.5, ( 0, 1, 0 ), 0, 1 );
                line( self.origin + ( 0, 0, 40 ), self.origin + ( 0, 0, 40 ) + anglestoforward( self.angles ) * 10, ( 0, 1, 0 ), 1, 0, 1 );
            }
        #/
        
        waitframe();
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x21a9
// Size: 0x1d7
function playanim_vehicleidle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    setvehiclearchetype();
    
    if ( isdefined( self.vehicleaimyawspeed ) )
    {
        self.aimyawspeed = self.vehicleaimyawspeed;
    }
    else
    {
        self.aimyawspeed = 108;
    }
    
    if ( !istrue( self._blackboard.linkedtovehicle ) && isdefined( self._blackboard.currentvehicle ) )
    {
        self.leftaimlimit = 180;
        self.rightaimlimit = -180;
        animindexidle = asm_getanim( asmname, "vehicle_idle" );
        xanimidle = asm_getxanim( "vehicle_idle", animindexidle );
        self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanimidle, self._blackboard.chosenvehicleanimpos_sittag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles );
        linktovehicle( self.asm.targetvalues[ "targetOrigin" ], self.asm.targetvalues[ "targetAngles" ], self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag );
    }
    
    self animmode( "nogravity" );
    self orientmode( "face current angles" );
    animindex = asm_getanim( asmname, statename );
    self aisetanim( statename, animindex );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x2388
// Size: 0x58
function function_7d994706653f02b4( asmname, statename, params )
{
    self endon( "death" );
    self endon( statename + "_finished" );
    var_767a8707bdc87a4e = randomfloatrange( 0, 1.25 );
    wait var_767a8707bdc87a4e;
    setvehiclearchetype();
    asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x23e8
// Size: 0x2c
function function_e985e877247d21e9( asmname, statename, params )
{
    setvehiclearchetype();
    playpainanim( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x241c
// Size: 0x2c
function function_3cb7671ef707bc14( asmname, statename, params )
{
    setvehiclearchetype();
    playanim_flashed( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 1
// Checksum 0x0, Offset: 0x2450
// Size: 0x18c
function vehicleturretshootthread( turret )
{
    self endon( "death" );
    self endon( "stop_shooting" );
    turret startfiring();
    turret self_func( "SetAISpread", 2 );
    turret setmode( "manual" );
    self linktoblendtotag( turret, "tag_gunner", 0 );
    mercy = 0;
    maxmercy = 2;
    
    while ( true )
    {
        if ( isdefined( self.enemy ) )
        {
            turret settargetentity( self.enemy );
            turret waittill( "turret_on_target" );
            burst = randomintrange( 12, 18 );
            shots = 0;
            minshots = randomintrange( 7, 12 );
            
            for ( i = 0; i < burst ; i++ )
            {
                shots++;
                turret shootturret();
                wait 0.05;
                
                if ( randomint( 100 ) < 25 )
                {
                    wait randomfloatrange( 0.1, 0.2 );
                }
                
                target = turret getturrettarget( 0 );
                
                if ( isdefined( target ) && isplayer( target ) && mercy < maxmercy && target.health < 60 )
                {
                    mercy++;
                    wait 3;
                }
                
                if ( shots > minshots )
                {
                    if ( isdefined( target ) && issentient( target ) && !isalive( target ) )
                    {
                        break;
                    }
                }
            }
        }
        else
        {
            turret cleartargetentity();
        }
        
        wait 0.8 + randomfloat( 1 );
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x25e4
// Size: 0x1b9
function playanim_vehicleturret( asmname, statename, params )
{
    self endon( statename + "_finished" );
    utility::use_turret( self._blackboard.currentvehicle.mgturret[ 0 ], undefined );
    
    if ( isdefined( self._blackboard.currentvehicle.mgturret[ 0 ] ) && !istrue( self._blackboard.currentvehicle.mgturret[ 0 ].var_9a120b82cc83c49e ) )
    {
        self useturret( self._blackboard.currentvehicle.mgturret[ 0 ] );
        
        if ( isdefined( self._blackboard.currentvehicle.customattackfunc ) )
        {
            self._blackboard.currentvehicle thread [[ self._blackboard.currentvehicle.customattackfunc ]]();
        }
        else
        {
            thread vehicleturretshootthread( self._blackboard.currentvehicle.mgturret[ 0 ] );
        }
        
        self._blackboard.currentvehicle.mgturret[ 0 ].var_9a120b82cc83c49e = 1;
    }
    
    setvehiclearchetype();
    self animmode( "nogravity" );
    self orientmode( "face current angles" );
    animindex = asm_getanim( asmname, statename );
    self aisetanim( statename, animindex );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x27a5
// Size: 0xd4
function playanim_vehicleturret_terminate( asmname, statename, params )
{
    clearvehiclearchetype();
    self stopuseturret();
    
    if ( isdefined( self._blackboard.currentvehicle ) && isdefined( self._blackboard.currentvehicle.mgturret ) )
    {
        if ( isdefined( self._blackboard.currentvehicle.mgturret[ 0 ] ) )
        {
            self._blackboard.currentvehicle.mgturret[ 0 ] cleartargetentity();
            self._blackboard.currentvehicle.mgturret[ 0 ] setmode( "manual" );
        }
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x2881
// Size: 0x35
function rotatetocurrentangles()
{
    self endon( "death" );
    self endon( "EndVehicleMotionWarp" );
    self endon( "EndRotateToCurrentAngles" );
    
    while ( true )
    {
        self orientmode( "face angle 3d", self.angles );
        waitframe();
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 6
// Checksum 0x0, Offset: 0x28be
// Size: 0xdd4
function enterexitvehiclemotionwarp( asmname, statename, xanim, vehicletag, exiting, xanimtargetoverride )
{
    if ( isplayer( self ) )
    {
        self endon( "death_or_disconnect" );
    }
    else
    {
        self endon( "death" );
    }
    
    self endon( "EndVehicleMotionWarp" );
    animlength = getanimlength( xanim );
    animstartfrac = 0;
    startnote = undefined;
    
    if ( animhasnotetrack( xanim, "motion_warp_begin" ) )
    {
        animstartfrac = getnotetracktimes( xanim, "motion_warp_begin" )[ 0 ];
        startnote = "motion_warp_begin";
    }
    
    animendfrac = 1;
    endnote = undefined;
    
    if ( animhasnotetrack( xanim, "motion_warp_end" ) )
    {
        animendfrac = getnotetracktimes( xanim, "motion_warp_end" )[ 0 ];
        endnote = "motion_warp_end";
    }
    
    if ( animhasnotetrack( xanim, "vehicle_cab_transition" ) )
    {
        var_82a7fde5e8ac4a68 = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
        
        if ( exiting )
        {
            self.var_f39c6b01b1d95542 = gettime();
            self.var_d9134148f9bb887 = gettime() + 1000 * animlength * var_82a7fde5e8ac4a68;
        }
        else
        {
            self.var_f39c6b01b1d95542 = gettime() + 1000 * animlength * var_82a7fde5e8ac4a68;
            self.var_d9134148f9bb887 = gettime() + 1000 * animlength;
        }
    }
    
    animindex = asm_getanim( asmname, statename );
    waittime = animlength * animstartfrac;
    
    /#
        if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
        {
            sphere( self.origin, 2, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    if ( exiting )
    {
        if ( isdefined( self._blackboard.chosenvehicleanimpos_fastroperig ) )
        {
            thread rotatetocurrentangles();
        }
        else
        {
            if ( isdefined( xanimtargetoverride ) )
            {
                self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanimtargetoverride, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
            }
            else
            {
                self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanim, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
            }
            
            self orientmode( "face angle 3d", self.asm.targetvalues[ "startAngles" ] );
            
            /#
                if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
                {
                    sphere( self.asm.targetvalues[ "<dev string:x1c>" ], 3, ( 0, 0, 1 ), 0, 300 );
                }
            #/
        }
    }
    else
    {
        self aisetanim( statename, animindex );
        linkpos = self._blackboard.currentvehicle gettagorigin( vehicletag );
        linkang = self._blackboard.currentvehicle gettagangles( vehicletag );
        var_7b1c8fcebb9c392d = self.origin - linkpos;
        invlinkang = invertangles( linkang );
        localtargetpos = rotatevector( var_7b1c8fcebb9c392d, invlinkang );
        var_b6c5de4898b7f63b = combineanglesinverted( linkang, self.angles );
        self linktomoveoffset( self._blackboard.currentvehicle, vehicletag, localtargetpos, var_b6c5de4898b7f63b );
        
        /#
            if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
            {
                sphere( self._blackboard.chosenvehiclelocation, 3, ( 0, 1, 0 ), 0, 300 );
            }
        #/
        
        motionwarpwithnotetracks( xanim, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, undefined, startnote, int( waittime * 1000 ) );
    }
    
    wait waittime;
    
    /#
        if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
        {
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x29>", ( 1, 1, 1 ), 1, 0.3, 300 );
            sphere( self.origin, 2, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    self motionwarpcancel();
    
    if ( !isdefined( self.asm ) )
    {
        return;
    }
    
    self notify( "EndRotateToCurrentAngles" );
    
    if ( isdefined( xanimtargetoverride ) )
    {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanimtargetoverride, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
    }
    else
    {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanim, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
    }
    
    targetpoint = self.asm.targetvalues[ "targetOrigin" ];
    
    if ( exiting )
    {
        self.asm.targetvalues[ "targetAngles" ] = ( 0, self.asm.targetvalues[ "targetAngles" ][ 1 ], 0 );
        targetpoint = getclosestpointonnavmesh( self.asm.targetvalues[ "targetOrigin" ] );
        
        if ( distance2dsquared( targetpoint, self.asm.targetvalues[ "targetOrigin" ] ) > 16384 )
        {
            /#
                if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
                {
                    print3d( self.origin, "<dev string:x3b>", ( 1, 1, 1 ), 1, 0.3, 2000, 0 );
                    line( self.origin, targetpoint, ( 255, 165, 0 ), 1, 0, 2000 );
                    sphere( targetpoint, 5, ( 255, 165, 0 ), 0, 2000 );
                }
            #/
            
            targetpoint = self.asm.targetvalues[ "targetOrigin" ];
        }
        
        contents = scripts\engine\trace::create_solid_ai_contents( 1 );
        ignorelist = [];
        
        if ( isdefined( self ) )
        {
            ignorelist = array_add( ignorelist, self );
        }
        
        if ( isdefined( self._blackboard.currentvehicle ) )
        {
            ignorelist = array_add( ignorelist, self._blackboard.currentvehicle );
        }
        
        spherecaststart = targetpoint + ( 0, 0, 72 );
        spherecastend = targetpoint + ( 0, 0, -1000 );
        collisionresults = physics_spherecast( spherecaststart, spherecastend, 12, contents, ignorelist, "physicsquery_closest" );
        
        if ( isdefined( collisionresults ) && collisionresults.size > 0 )
        {
            targetpoint = collisionresults[ 0 ][ "position" ];
        }
        
        self orientmode( "face angle 3d", self.asm.targetvalues[ "targetAngles" ] );
        
        /#
            if ( getdvarint( @"hash_516c8a0d29dad543", 0 ) == 1 )
            {
                startpoint = self.asm.targetvalues[ "<dev string:x5a>" ];
                startangles = self.asm.targetvalues[ "<dev string:x66>" ];
                startendpoint = startpoint + anglestoforward( startangles ) * 5;
                line( startpoint, startendpoint, ( 0, 1, 0 ), 1, 0, 2000 );
                sphere( startpoint, 1, ( 0, 1, 0 ), 0, 2000 );
                line( targetpoint, self.origin, ( 0, 0, 1 ), 1, 0, 2000 );
                sphere( targetpoint, 5, ( 0, 0, 1 ), 0, 2000 );
                line( self.asm.targetvalues[ "<dev string:x1c>" ], self.origin, ( 1, 0, 0 ), 1, 0, 2000 );
                sphere( self.asm.targetvalues[ "<dev string:x1c>" ], 5, ( 1, 0, 0 ), 0, 2000 );
            }
        #/
    }
    
    /#
        if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
        {
            sphere( targetpoint, 3, ( 0, 1, 0 ), 0, 300 );
        }
    #/
    
    warpduration = ( animendfrac - animstartfrac ) * animlength;
    self animmode( "noclip" );
    motionwarpwithnotetracks( xanim, targetpoint, self.asm.targetvalues[ "targetAngles" ], startnote, endnote, int( warpduration * 1000 ) );
    wait warpduration;
    
    /#
        if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
        {
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x72>", ( 1, 1, 1 ), 1, 0.3, 300 );
            sphere( self.origin, 2, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    if ( exiting )
    {
        if ( !isdefined( self._blackboard ) )
        {
            return;
        }
        
        if ( istrue( self._blackboard.linkedtovehicle ) )
        {
            self unlink();
            self._blackboard.linkedtovehicle = 0;
            self orientmode( "face angle", self.asm.targetvalues[ "targetAngles" ][ 1 ] );
            self animmode( "gravity" );
        }
        
        return;
    }
    
    self motionwarpcancel();
    self aiclearanim( statename, animindex, 0 );
    self animmode( "noclip" );
    self orientmode( "face current" );
    self aisetanim( statename, animindex );
    self aisetanimtime( xanim, animendfrac );
    tagorigin = self._blackboard.currentvehicle gettagorigin( vehicletag );
    tagangles = self._blackboard.currentvehicle gettagangles( vehicletag );
    var_88e63d3aa1307c00 = distance2dsquared( self.origin, targetpoint ) < 4 && abs( self.angles[ 0 ], self.asm.targetvalues[ "targetAngles" ][ 0 ] ) < 1 && abs( self.angles[ 1 ], self.asm.targetvalues[ "targetAngles" ][ 1 ] ) < 1 && abs( self.angles[ 2 ], self.asm.targetvalues[ "targetAngles" ][ 2 ] ) < 1;
    self.asm.targetvalues = undefined;
    
    if ( !var_88e63d3aa1307c00 && animendfrac < 1 )
    {
        var_33db3a06c680bc05 = int( 1000 * animlength * ( 1 - animendfrac ) );
        motionwarpwithtimes( xanim, tagorigin, tagangles, animendfrac, 1, var_33db3a06c680bc05 );
        
        /#
            if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
            {
                print3d( self.origin + ( 0, 0, 60 ), "<dev string:x82>", ( 1, 1, 1 ), 1, 0.3, 300 );
                sphere( tagorigin, 3, ( 0, 1, 0 ), 0, 300 );
            }
        #/
        
        watcherwaitduration = var_33db3a06c680bc05 * 0.5 / 1000;
        var_6ad3f3636dbbebed = var_33db3a06c680bc05 * 0.5 / 1000;
        movedelta = getmovedelta( xanim, 1 - ( 1 - animendfrac ) * 0.5, 1 );
        angledelta = getangledelta3d( xanim, 1 - ( 1 - animendfrac ) * 0.5, 1 );
        var_1858a5a3adf74ae6 = tagorigin - movedelta;
        var_2b59495b388d8170 = tagangles - angledelta;
        thread function_710d997ba5906931( watcherwaitduration, var_1858a5a3adf74ae6, var_2b59495b388d8170, tagorigin, tagangles, var_6ad3f3636dbbebed );
    }
    
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    
    if ( !isdefined( self._blackboard ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( !istrue( self._blackboard.linkedtovehicle ) )
    {
        linktovehicle( self.origin, self.angles, self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag );
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 6
// Checksum 0x0, Offset: 0x369a
// Size: 0x16b
function function_710d997ba5906931( waitduration, targetpoint, targetangles, tagorigin, tagangles, warpduration )
{
    self endon( "death" );
    self endon( "EndVehicleMotionWarp" );
    
    /#
        if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
        {
            sphere( targetpoint, 3, ( 0, 1, 0 ), 0, 300 );
        }
    #/
    
    wait waitduration;
    var_539a5cf0803a5cfe = distance2dsquared( self.origin, targetpoint ) < 40 && abs( self.angles[ 0 ], targetangles[ 0 ] ) < 5 && abs( self.angles[ 1 ], targetangles[ 1 ] ) < 5 && abs( self.angles[ 2 ], targetangles[ 2 ] ) < 5;
    
    if ( !var_539a5cf0803a5cfe )
    {
        /#
            if ( scripts\vehicle\vehicle_common::function_745ac044fcee731b( 3 ) )
            {
                print3d( self.origin + ( 0, 0, 60 ), "<dev string:xa9>", ( 1, 1, 1 ), 1, 0.3, 300 );
                sphere( self.origin, 3, ( 1, 0, 0 ), 0, 300 );
            }
        #/
        
        self motionwarpcancel();
        self motionwarp( tagorigin, tagangles, int( warpduration * 1000 ) );
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x380d
// Size: 0x1a2
function playanim_entervehicle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    setvehiclearchetype();
    self.customarrivalangles = undefined;
    self._blackboard.startedenteringvehicle = 1;
    animindex = asm_getanim( asmname, statename );
    xanim = asm_getxanim( statename, animindex );
    assertex( isdefined( xanim ), "Cannot find alias " + self._blackboard.var_9176cae5619d7fba + " in archetype " + self._blackboard.currentvehicleanimalias + " for state " + statename + " for " + self.classname + ". The state may not be added in the arc" );
    self animmode( "noclip" );
    self orientmode( "face current angles" );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        animindexidle = asm_getanim( asmname, "vehicle_idle" );
        xanimidle = asm_getxanim( "vehicle_idle", animindexidle );
        thread enterexitvehiclemotionwarp( asmname, statename, xanim, self._blackboard.chosenvehicleanimpos_sittag, 0, undefined );
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x39b7
// Size: 0x1ff
function entervehicle_terminate( asmname, statename, params )
{
    clearvehiclearchetype();
    
    if ( isalive( self ) )
    {
        if ( !istrue( self._blackboard.linkedtovehicle ) && isalive( self._blackboard.currentvehicle ) )
        {
            linktovehicle( self.asm.targetvalues[ "targetOrigin" ], self.asm.targetvalues[ "targetAngles" ], self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag );
            self.asm.targetvalues = undefined;
        }
        
        if ( isalive( self._blackboard.currentvehicle ) )
        {
            self._blackboard.enteredvehicle = 1;
        }
    }
    else
    {
        setvehiclearchetype();
        xanim = asm_getxanim( statename, self._blackboard.var_9176cae5619d7fba );
        animtime = self aigetanimtime( statename, self._blackboard.var_9176cae5619d7fba );
        animlength = getanimlength( xanim );
        transitiontime = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
        
        if ( isdefined( transitiontime ) )
        {
            if ( animtime < transitiontime )
            {
                self.diedintransition = 1;
            }
            else
            {
                self._blackboard.vehicledeathwait = ( 1 - animtime ) * animlength;
                self._blackboard.var_c191edddbacadd2a = animtime;
                self._blackboard.var_dd5dd40921b4615c = statename;
                self.var_442eeeabc15edd0a = 1;
            }
        }
        else
        {
            self.diedintransition = 1;
        }
    }
    
    self motionwarpcancel();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 1
// Checksum 0x0, Offset: 0x3bbe
// Size: 0x43
function exitvehiclewatchpath( statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        if ( isdefined( self.pathgoalpos ) )
        {
            self animmode( "gravity" );
            self orientmode( "face motion" );
            return;
        }
        
        waitframe();
    }
}

/#

    // Namespace vehicle / scripts\asm\soldier\vehicle
    // Params 1
    // Checksum 0x0, Offset: 0x3c09
    // Size: 0xc5, Type: dev
    function drawdeathnotetracks( xanim )
    {
        waittime = getnotetracktimes( xanim, "<dev string:xc9>" )[ 0 ];
        ragdolltime = getnotetracktimes( xanim, "<dev string:xdc>" )[ 0 ];
        
        if ( isdefined( waittime ) && isdefined( ragdolltime ) )
        {
            animlength = getanimlength( xanim );
            wait waittime * animlength;
            endtime = gettime() + ( ragdolltime - waittime ) * animlength * 1000;
            
            while ( isdefined( self ) && isalive( self ) && gettime() < endtime )
            {
                sphere( self.origin + ( 0, 0, 60 ), 4, ( 1, 0, 0 ), 0, 1 );
                waitframe();
            }
        }
    }

#/

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x3cd6
// Size: 0x248
function playanim_exitvehicle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self setdefaultaimlimits();
    self.requestopendoor = 1;
    self.requestopendoorparams = params;
    self.allowpain = 1;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( isdefined( self._blackboard.chosenvehicleanimpos_getoutanim ) )
        {
            anim_name = self._blackboard.chosenvehicleanimpos_getoutanim;
            self._blackboard.currentvehicle function_eb2255b847e6681c( anim_name );
        }
    }
    
    set_movement_speed( 60 );
    self aisettargetspeed( 60 );
    self.exitvehicle_oldturnrate = self.turnrate;
    self.turnrate = 0.3;
    setvehiclearchetype();
    animindex = asm_getanim( asmname, statename );
    xanim = asm_getxanim( statename, animindex );
    assertex( isdefined( xanim ), "Cannot find alias " + self._blackboard.var_9176cae5619d7fba + " in archetype " + self._blackboard.currentvehicleanimalias + " for state " + statename + " for " + self.classname + ". The state may not be added in the arc" );
    self._blackboard.exitvehicleanimindex = animindex;
    
    /#
        if ( getdvarint( @"hash_89424474a6dbe389", 0 ) == 1 )
        {
            thread drawdeathnotetracks( xanim );
        }
    #/
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        thread enterexitvehiclemotionwarp( asmname, statename, xanim, self._blackboard.chosenvehicleanimpos_sittag, 1, undefined );
    }
    
    self animmode( "nogravity" );
    self aisetanim( statename, animindex );
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), undefined, undefined, 0 );
    
    if ( endnote == "code_move" )
    {
        thread exitvehiclewatchpath( statename );
        asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), undefined, undefined, 0 );
    }
    
    asm_fireevent( asmname, "end" );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x3f26
// Size: 0x24
function endvehiclemotionwarp()
{
    self notify( "EndVehicleMotionWarp" );
    self.asm.targetvalues = undefined;
    self motionwarpcancel();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x3f52
// Size: 0x434
function exitvehicle_terminate( asmname, statename, params )
{
    self._blackboard.invehicle = 0;
    utility::clear_movement_speed();
    
    if ( isdefined( self.exitvehicle_oldturnrate ) )
    {
        self.turnrate = self.exitvehicle_oldturnrate;
        self.exitvehicle_oldturnrate = undefined;
    }
    
    if ( !isalive( self ) && !istrue( self._blackboard.chosenvehicleanimpos_deathragdoll ) )
    {
        if ( !isdefined( self._blackboard.exitvehicleanimindex ) )
        {
            self._blackboard.exitvehicleanimindex = asm_getanim( asmname, statename );
        }
        
        xanim = asm_getxanim( statename, self._blackboard.exitvehicleanimindex );
        animtime = self aigetanimtime( statename, self._blackboard.exitvehicleanimindex );
        animlength = getanimlength( xanim );
        waittime = getnotetracktimes( xanim, "vehicle_death_wait" )[ 0 ];
        ragdolltime = getnotetracktimes( xanim, "vehicle_death_ragdoll" )[ 0 ];
        crashinghelicopter = isdefined( self._blackboard.currentvehicle ) && self._blackboard.currentvehicle scripts\common\vehicle::ishelicopter() && self._blackboard.currentvehicle scripts\common\vehicle::vehicle_is_crashing();
        
        if ( isdefined( waittime ) && isdefined( ragdolltime ) )
        {
            if ( animtime < waittime )
            {
                self._blackboard.invehicle = 1;
            }
            else if ( animtime < ragdolltime )
            {
                if ( crashinghelicopter )
                {
                    self._blackboard.invehicle = 1;
                }
                else
                {
                    self._blackboard.vehicledeathwait = ( ragdolltime - animtime ) * animlength;
                    self._blackboard.var_c191edddbacadd2a = animtime;
                    self._blackboard.var_dd5dd40921b4615c = statename;
                }
            }
        }
        else
        {
            self.diedintransition = 1;
            transitiontime = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
            
            if ( isdefined( transitiontime ) )
            {
                if ( animtime < transitiontime )
                {
                    self._blackboard.vehicledeathwait = ( transitiontime - animtime ) * animlength;
                    self._blackboard.var_c191edddbacadd2a = animtime;
                    self._blackboard.var_dd5dd40921b4615c = statename;
                }
            }
        }
    }
    else if ( !isalive( self ) )
    {
        self.diedintransition = 1;
        
        if ( !isdefined( self._blackboard.exitvehicleanimindex ) )
        {
            self._blackboard.exitvehicleanimindex = asm_getanim( asmname, statename );
        }
        
        xanim = asm_getxanim( statename, self._blackboard.exitvehicleanimindex );
        animtime = self aigetanimtime( statename, self._blackboard.exitvehicleanimindex );
        animlength = getanimlength( xanim );
        transitiontime = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
        
        if ( isdefined( transitiontime ) )
        {
            if ( animtime < transitiontime )
            {
                self._blackboard.vehicledeathwait = ( transitiontime - animtime ) * animlength;
                self._blackboard.var_c191edddbacadd2a = animtime;
                self._blackboard.var_dd5dd40921b4615c = statename;
            }
        }
    }
    else if ( istrue( self._blackboard.linkedtovehicle ) )
    {
        self unlink();
        self._blackboard.linkedtovehicle = 0;
    }
    
    if ( !isdefined( self._blackboard.vehicledeathwait ) )
    {
        endvehiclemotionwarp();
        self._blackboard.exitvehicleanimindex = undefined;
    }
    
    self notify( "jumpedout" );
    self._blackboard.exitingvehicle = 0;
    self.requestopendoor = undefined;
    self.requestopendoorparams = undefined;
    clearvehiclearchetype();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x438e
// Size: 0x36
function vehicletransition_terminate( asmname, statename, params )
{
    if ( !isalive( self ) )
    {
        self.diedintransition = 1;
    }
    
    clearvehiclearchetype();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x43cc
// Size: 0xa7
function watchvehicledeath()
{
    self endon( "entitydeleted" );
    
    if ( self isragdoll() )
    {
        return;
    }
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( !isdefined( vehicle ) || vehicle scripts\common\vehicle_code::vehicle_iscorpse() )
            {
                if ( istrue( self.deleteonvehicledeath ) )
                {
                    self delete();
                    return;
                }
                
                endvehiclemotionwarp();
                self startragdoll();
                self.skipdeathcleanup = 0;
                self.vehicle_idling = 0;
                deathcleanup();
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x447b
// Size: 0x423
function playanim_vehicledeath( asmname, statename, params )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( "entitydeleted" );
    setvehiclearchetype();
    
    if ( !isagent( self ) )
    {
        if ( istrue( self.diedintransition ) || isdefined( self.damagemod ) && ( self.damagemod == "MOD_FIRE" || self.damagemod == "MOD_IMPACT" ) )
        {
            self.var_1447d8fee27482b0 = ( 0, 0, 0 );
        }
        
        scripts\asm\soldier\death::handleburningtodeath();
        self.burningtodeath = 0;
        vehicleisdead = !isdefined( self._blackboard.currentvehicle ) || self._blackboard.currentvehicle scripts\common\vehicle_code::vehicle_iscorpse();
        
        if ( isdefined( self._blackboard.vehicledeathwait ) )
        {
            if ( !vehicleisdead )
            {
                xanim = animsetgetanimfromindex( self._blackboard.currentvehicleanimalias, self._blackboard.var_dd5dd40921b4615c, self._blackboard.var_9176cae5619d7fba );
                self aisetanim( self._blackboard.var_dd5dd40921b4615c, self._blackboard.var_9176cae5619d7fba, 1 );
                self aisetanimtime( xanim, self._blackboard.var_c191edddbacadd2a );
                self animmode( "noclip" );
                
                if ( istrue( self.var_442eeeabc15edd0a ) && isdefined( self._blackboard.currentvehicle ) )
                {
                    function_df956d52bae0b61d( xanim, self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos_sittag, ( 0, 0, 0 ), ( 0, 0, 0 ), self._blackboard.var_c191edddbacadd2a, 1 );
                }
                
                thread watchvehicledeath();
                wait self._blackboard.vehicledeathwait;
                
                if ( !isdefined( self ) )
                {
                    return;
                }
                
                self.var_1447d8fee27482b0 = ( 0, 0, 0 );
                self._blackboard.exitvehicleanimindex = undefined;
                self._blackboard.vehicledeathwait = undefined;
            }
            
            endvehiclemotionwarp();
        }
        
        self orientmode( "face current angles" );
        var_5d6e6d808c153d03 = undefined;
        self.noragdoll = 0;
        deathanimdata = getdeathanimdata( asmname, statename, params );
        assert( isdefined( deathanimdata ) && deathanimdata.size == 2 );
        notetracks = getnotetracks( deathanimdata[ 1 ], "start_ragdoll" );
        
        if ( notetracks.size != 0 )
        {
            var_5d6e6d808c153d03 = 1;
        }
        
        shouldragdoll = vehicleisdead || istrue( self._blackboard.chosenvehicleanimpos_deathragdoll ) || istrue( var_5d6e6d808c153d03 ) || istrue( self.diedintransition );
        var_7dfbf656d13d1a6c = !vehicleisdead && istrue( var_5d6e6d808c153d03 );
        
        if ( shouldragdoll )
        {
            self.skipdeathcleanup = 0;
            self.vehicle_idling = 0;
            
            if ( istrue( self.diedintransition ) )
            {
                self.nogravityragdoll = 1;
                self.ragdoll_immediate = 1;
                self.deathstate = "vehicle_transition_death";
                self.deathalias = "death";
            }
            else if ( var_7dfbf656d13d1a6c )
            {
                self.nogravityragdoll = 1;
                self.ragdolltime = getanimlength( deathanimdata[ 1 ] ) * notetracks[ 0 ][ "time" ];
            }
            else
            {
                self.ragdoll_immediate = 1;
            }
        }
        else
        {
            self animmode( "nogravity" );
            self.noragdoll = 1;
            self.skipdeathcleanup = 1;
            thread watchvehicledeath();
        }
    }
    else
    {
        self motionwarpcancel();
        self orientmode( "face current angles" );
    }
    
    scripts\asm\soldier\death::playdeathanim( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x48a6
// Size: 0x2c
function playanim_vehicle( asmname, statename, params )
{
    setvehiclearchetype();
    asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x48da
// Size: 0x37
function function_863eaacfe47cedee( asmname, statename, params )
{
    setvehiclearchetype();
    self.useanimgoalweight = 1;
    asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4919
// Size: 0x9c
function playanim_vehiclereload( asmname, statename, params )
{
    self endon( "reload_terminate" );
    self endon( statename + "_finished" );
    setvehiclearchetype();
    animid = asm_getanim( asmname, statename );
    self aisetanim( statename, animid );
    xanim = asm_getxanim( statename, animid );
    assert( animhasnotetrack( xanim, "refill clip" ) || animhasnotetrack( xanim, "reload done" ) );
    asm_playfacialanim( asmname, statename, xanim );
    asm_donotetracks( asmname, statename, undefined, undefined, undefined, 1 );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x49bd
// Size: 0x4d
function function_59af18a4aee683ff( asmname, statename, params )
{
    setvehiclearchetype();
    self.var_58e8388f04abb64e = 1;
    self._blackboard.var_6a69fa6b0b354c93 = 1;
    asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4a12
// Size: 0x4b
function function_97519548bded06bd( asmname, statename, params )
{
    setvehiclearchetype();
    self.var_58e8388f04abb64e = 0;
    self._blackboard.var_6a69fa6b0b354c93 = 0;
    asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4a65
// Size: 0x124
function function_e2cdb897d2f82507( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self endon( "death" );
    setvehiclearchetype();
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_9176cae5619d7fba;
    aianims = anim_pos( vehicle, position );
    scripts\asm\soldier\melee::playmeleeattacksound();
    target = scripts\asm\asm_bb::bb_getmeleetarget();
    
    if ( !isdefined( target ) )
    {
        self orientmode( "face current" );
    }
    else if ( target == self.enemy )
    {
        self orientmode( "face enemy" );
    }
    else
    {
        self orientmode( "face point", target.origin );
    }
    
    asm_fireephemeralevent( "melee_attack", "begin" );
    self aisetanim( statename, asm_getanim( asmname, statename ) );
    scripts\asm\soldier\melee::donotetracks_vsplayer( asmname, statename, asm_getnotehandler( asmname, statename ) );
    asm_fireevent( asmname, "end" );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4b91
// Size: 0x2c
function vehiclereload_terminate( asmname, statename, params )
{
    scripts\asm\soldier\script_funcs::reload_cleanup( asmname, statename, params );
    clearvehiclearchetype();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x4bc5
// Size: 0x3c, Type: bool
function isvehicledead( asmname, statename, tostatename, params )
{
    return !isalive( self._blackboard.currentvehicle );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x4c0a
// Size: 0x16, Type: bool
function isnotinvehicle()
{
    return !self._blackboard.invehicle;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x4c29
// Size: 0xc8, Type: bool
function function_99cabda949b9375a( asmname, statename, tostatename, params )
{
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_9176cae5619d7fba;
    aianims = anim_pos( vehicle, position );
    
    if ( !isdefined( aianims ) || !istrue( aianims.var_bcd0a0afd54c6491 ) )
    {
        return false;
    }
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        return false;
    }
    
    if ( self function_5b5d9b0857469a76() )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x4cfa
// Size: 0x6c, Type: bool
function function_29fed6f5a8b07e74( asmname, statename, tostatename, params )
{
    if ( isdefined( self._blackboard.vehicledir ) )
    {
        return ( self._blackboard.vehicledir == 0 || self._blackboard.vehicledir == 8 );
    }
    
    return true;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4d6f
// Size: 0x10a
function function_3e064916882c7b95( asmname, statename, params )
{
    alias = string( self._blackboard.var_9176cae5619d7fba );
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_9176cae5619d7fba;
    aianims = anim_pos( vehicle, position );
    currentdir = self._blackboard.vehicledir;
    alias += "_" + string( self._blackboard.vehicledir );
    
    if ( currentdir == 2 )
    {
        alias += "_turn_2";
    }
    else if ( currentdir == 4 )
    {
        alias += "_turn_6";
    }
    else
    {
        alias += "_turn_4";
    }
    
    return asm_lookupanimfromalias( "vehicle_idle_combat_shoot_turn", alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4e82
// Size: 0xaa
function function_b6fb6cffe3f92b36( asmname, statename, params )
{
    self endon( statename + "_finished" );
    setvehiclearchetype();
    self.useanimgoalweight = 1;
    animid = asm_getanim( asmname, statename );
    turnanimstatename = "vehicle_idle_combat_shoot_turn";
    self aisetanim( turnanimstatename, animid );
    asm_playfacialanim( asmname, turnanimstatename, asm_getxanim( turnanimstatename, animid ) );
    endnote = asm_donotetracks( asmname, turnanimstatename, asm_getnotehandler( asmname, turnanimstatename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm_donotetracks( asmname, turnanimstatename, asm_getnotehandler( asmname, turnanimstatename ) );
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x4f34
// Size: 0x68
function vehicleshouldstophide( asmname, statename, tostatename, params )
{
    if ( !self issuppressed() && isdefined( self.vehicleusesuppression ) && self.vehicleusesuppression )
    {
        return 1;
    }
    
    return gettime() > self._blackboard.vehiclehidetime;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4fa4
// Size: 0x3b
function function_fda43da6e52af4b5( asmname, statename, params )
{
    self._blackboard.var_3769628964ac89c1 = 1;
    playanim_vehicle( asmname, statename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x4fe7
// Size: 0xf8
function function_b8f7a5c394a25131()
{
    if ( !isdefined( self._blackboard.var_e38c46be257216d3 ) )
    {
        return "";
    }
    
    alias = self._blackboard.var_9176cae5619d7fba + "_" + self._blackboard.var_e38c46be257216d3;
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    
    return alias;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x50e8
// Size: 0x7a, Type: bool
function function_9bf47724e18bbbee( asmname, statename, tostatename, params )
{
    if ( !isdefined( self._blackboard.var_e38c46be257216d3 ) )
    {
        return false;
    }
    
    alias = function_b8f7a5c394a25131();
    animresult = archetypegetrandomalias( self._blackboard.currentvehicleanimalias, tostatename, alias, asm_isfrantic() );
    return isdefined( animresult );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x516b
// Size: 0x34
function function_7150ef4bc326b7f4( asmname, statename, params )
{
    alias = function_b8f7a5c394a25131();
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x51a8
// Size: 0xf2, Type: bool
function function_b4b7ff53be58de23( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        alias += function_37da44a7cf24fdad( aianims );
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, alias, asm_isfrantic() );
    return isdefined( animresult );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x52a3
// Size: 0x121, Type: bool
function vehiclehasalias( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, alias, asm_isfrantic() );
    return isdefined( animresult );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x53cd
// Size: 0x127
function function_b0734010e3a7e4b3( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        alias += getpainalias( aianims );
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, alias, asm_isfrantic() );
    
    if ( isdefined( animresult ) )
    {
        return 1;
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, string( self._blackboard.var_9176cae5619d7fba ), asm_isfrantic() );
    return isdefined( animresult );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x54fc
// Size: 0xa3, Type: bool
function function_b373bc69137d18d1( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( isdefined( self.vehicleseatonleft ) )
    {
        switchsidesalias = function_ef715d817b10b063();
        alias += switchsidesalias;
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, alias, asm_isfrantic() );
    return isdefined( animresult );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x55a8
// Size: 0x12a, Type: bool
function function_1746ad7c74ead3e8( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = string( self._blackboard.var_9176cae5619d7fba );
    
    if ( function_b3bb4d116f5a79cb( self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_9176cae5619d7fba;
        aianims = anim_pos( vehicle, position );
        
        if ( istrue( self.vehicleseatonleft ) )
        {
            alias += "_4";
        }
        else
        {
            alias += "_6";
        }
    }
    
    alias = function_179d01a77dc31f73( alias );
    animresult = archetypegetrandomalias( arcname, tostatename, alias, asm_isfrantic() );
    return isdefined( animresult );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x56db
// Size: 0x2d, Type: bool
function vehicleshouldrunexit( asmname, statename, tostatename, params )
{
    return istrue( self.vehiclerunexit );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x5711
// Size: 0x49, Type: bool
function function_a1f0771e220c6c30( asmname, statename, tostatename, params )
{
    return istrue( self.var_58e8388f04abb64e ) && !vehicleincombat( asmname, statename, tostatename, params ) && vehiclehasalias( asmname, statename, tostatename, params );
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x5763
// Size: 0x44, Type: bool
function vehiclegetoutcodemove( asmname, statename, tostatename, params )
{
    if ( asm_eventfired( asmname, "code_move" ) && isdefined( self.pathgoalpos ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x57b0
// Size: 0x193
function vehiclecollisionwatcher()
{
    self endon( "EndVehicleCollisionThread" );
    self endon( "death" );
    
    if ( !isdefined( self._blackboard.currentvehicle ) )
    {
        return;
    }
    
    self._blackboard.currentvehicle waittill( "collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
    self.collision_data = spawnstruct();
    self.collision_data.position = position;
    self.collision_data.normal = normal;
    self.collision_data.impulse = impulse;
    forward = anglestoforward( self.angles );
    
    /#
        setdvarifuninitialized( @"hash_e4eece17e1ee5b59", 0 );
        displayinfo = getdvarint( @"hash_e4eece17e1ee5b59" );
        
        if ( displayinfo )
        {
            line( position, position + normal * impulse * 1000, ( 0, 1, 0 ), 1, 0, 100 );
            line( position, position + forward * 100, ( 1, 0, 0 ), 1, 0, 100 );
            sphere( position, 20, ( 0, 1, 0 ), 0, 100 );
        }
    #/
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x594b
// Size: 0x23
function function_c9c1b653ecdcaffd( asmname, statename, params )
{
    thread vehiclecollisionwatcher();
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 0
// Checksum 0x0, Offset: 0x5976
// Size: 0x19
function function_535f605646d65a4d()
{
    if ( isdefined( self.collision_data ) )
    {
        self.collision_data = undefined;
    }
}

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 3
// Checksum 0x0, Offset: 0x5997
// Size: 0x23
function function_ea6fcddde1c07c00( asmname, statename, params )
{
    self notify( "EndVehicleCollisionThread" );
}

/#

    // Namespace vehicle / scripts\asm\soldier\vehicle
    // Params 0
    // Checksum 0x0, Offset: 0x59c2
    // Size: 0x1b, Type: dev
    function function_ef6a628ea4adc090()
    {
        wait 0.5;
        setdvar( @"hash_cb545ecc4d88b530", 0 );
    }

#/

// Namespace vehicle / scripts\asm\soldier\vehicle
// Params 4
// Checksum 0x0, Offset: 0x59e5
// Size: 0x17c, Type: bool
function function_9e3ca0a0abcf9cf0( asmname, statename, tostatename, params )
{
    if ( !isdefined( self._blackboard.currentvehicle ) || !isdefined( self._blackboard.var_9176cae5619d7fba ) )
    {
        return false;
    }
    
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_9176cae5619d7fba;
    aianims = anim_pos( vehicle, position );
    
    /#
        setdvarifuninitialized( @"hash_cb545ecc4d88b530", 0 );
        triggerimpulse = getdvarint( @"hash_cb545ecc4d88b530", 0 );
        
        if ( triggerimpulse )
        {
            self.collision_data = spawnstruct();
            self.collision_data.position = self.origin;
            self.collision_data.normal = ( 1, 0, 0 );
            self.collision_data.impulse = 0.5;
            thread function_ef6a628ea4adc090();
        }
    #/
    
    if ( !isdefined( aianims ) || !istrue( aianims.var_bcd0a0afd54c6491 ) )
    {
        return false;
    }
    
    if ( !isdefined( self.collision_data ) || !istrue( aianims.var_70aa9eaf339ddb20 ) )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace vehicle / scripts\asm\soldier\vehicle
    // Params 6
    // Checksum 0x0, Offset: 0x5b6a
    // Size: 0x80, Type: dev
    function function_b8fad26db245639d( asmname, statename, arc, alias, xanim, message )
    {
        println( "<dev string:xf2>" + asmname + "<dev string:x140>" + statename + "<dev string:x14a>" + arc + "<dev string:x158>" );
        level.var_e941151b3a81c996 = 0;
        println( "<dev string:x15b>" + alias + "<dev string:x166>" + xanim + "<dev string:x166>" + message );
    }

    // Namespace vehicle / scripts\asm\soldier\vehicle
    // Params 3
    // Checksum 0x0, Offset: 0x5bf2
    // Size: 0x3aa, Type: dev
    function function_f3e1b78b6e0b6b0( asmname, statename, arc )
    {
        if ( !archetypeassetloaded( arc ) )
        {
            return;
        }
        
        aliases = archetypegetaliases( arc, statename );
        
        if ( !isdefined( aliases ) )
        {
            return;
        }
        
        foreach ( alias in aliases )
        {
            organims = archetypegetalias( arc, statename, alias, 0 );
            
            if ( isarray( organims.anims ) )
            {
                anims = organims.anims;
            }
            else
            {
                anims = [ organims.anims ];
            }
            
            foreach ( xanim in anims )
            {
                waittime = getnotetracktimes( xanim, "<dev string:xc9>" )[ 0 ];
                ragdolltime = getnotetracktimes( xanim, "<dev string:xdc>" )[ 0 ];
                var_7d4694abb95101bc = getnotetracktimes( xanim, "<dev string:x29>" );
                motionwarpendtimes = getnotetracktimes( xanim, "<dev string:x72>" );
                codemovetimes = getnotetracktimes( xanim, "<dev string:x168>" );
                finishtimes = getnotetracktimes( xanim, "<dev string:x172>" );
                
                if ( isdefined( var_7d4694abb95101bc ) && var_7d4694abb95101bc.size > 1 )
                {
                    function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x179>" );
                }
                
                if ( isdefined( motionwarpendtimes ) && motionwarpendtimes.size > 1 )
                {
                    function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x1b0>" );
                }
                
                if ( isdefined( var_7d4694abb95101bc ) && var_7d4694abb95101bc.size > 0 && isdefined( motionwarpendtimes ) && motionwarpendtimes.size > 0 )
                {
                    if ( var_7d4694abb95101bc[ 0 ] >= motionwarpendtimes[ 0 ] )
                    {
                        function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x1e5>" );
                    }
                    
                    if ( isdefined( finishtimes ) )
                    {
                        if ( finishtimes.size > 0 && var_7d4694abb95101bc[ 0 ] > finishtimes[ 0 ] )
                        {
                            function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x21b>" );
                        }
                        
                        if ( finishtimes.size > 0 && motionwarpendtimes[ 0 ] > finishtimes[ 0 ] )
                        {
                            function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x248>" );
                        }
                    }
                    
                    if ( isdefined( codemovetimes ) )
                    {
                        if ( codemovetimes.size > 0 && var_7d4694abb95101bc[ 0 ] > codemovetimes[ 0 ] )
                        {
                            function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x28a>" );
                        }
                        
                        if ( codemovetimes.size > 0 && motionwarpendtimes[ 0 ] > codemovetimes[ 0 ] )
                        {
                            function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x2ba>" );
                        }
                    }
                    
                    totalmovedelta = getmovedelta( xanim, 0, 1 );
                    motionwarpmovedelta = getmovedelta( xanim, var_7d4694abb95101bc[ 0 ], motionwarpendtimes[ 0 ] );
                    
                    if ( abs( motionwarpmovedelta[ 2 ] ) < abs( totalmovedelta[ 2 ] ) * 0.5 )
                    {
                        function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x2e8>" );
                    }
                }
                
                if ( isdefined( waittime ) && !isdefined( ragdolltime ) )
                {
                    function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x328>" );
                }
                
                if ( !isdefined( waittime ) && isdefined( ragdolltime ) )
                {
                    function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x36a>" );
                }
                
                if ( isdefined( waittime ) && isdefined( ragdolltime ) && waittime >= ragdolltime )
                {
                    function_b8fad26db245639d( asmname, statename, arc, alias, xanim, "<dev string:x3ac>" );
                }
            }
        }
    }

    // Namespace vehicle / scripts\asm\soldier\vehicle
    // Params 3
    // Checksum 0x0, Offset: 0x5fa4
    // Size: 0x134, Type: dev
    function function_839aa14eda8a2d82( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        archetypes = [ "<dev string:x3e5>", "<dev string:x3e9>", "<dev string:x3f1>", "<dev string:x3f7>", "<dev string:x404>", "<dev string:x40a>", "<dev string:x414>", "<dev string:x425>", "<dev string:x42c>", "<dev string:x436>", "<dev string:x446>", "<dev string:x44e>", "<dev string:x454>", "<dev string:x464>", "<dev string:x473>", "<dev string:x479>", "<dev string:x480>", "<dev string:x486>", "<dev string:x48d>", "<dev string:x493>" ];
        
        foreach ( arc in archetypes )
        {
            function_f3e1b78b6e0b6b0( asmname, statename, arc );
        }
    }

#/
