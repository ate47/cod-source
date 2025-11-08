#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\utility;

#namespace vehicle_damage;

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0xfa3
// Size: 0xb3
function vehicle_damage_setcandamage( bool )
{
    linkedents = self getlinkedchildren( 1 );
    
    if ( isdefined( linkedents ) )
    {
        foreach ( linkedent in linkedents )
        {
            if ( isdefined( linkedent.code_classname ) && linkedent.code_classname == "misc_turret" )
            {
                if ( bool )
                {
                    linkedent thread vehicle_damage_keepturretalive( self );
                    continue;
                }
                
                linkedent vehicle_damage_keepturretaliveend();
            }
        }
    }
    
    self setcandamage( bool );
    vehicle_damage_cleareventlog( self );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x105e
// Size: 0x14c
function vehicle_damage_getleveldataforvehicle( vehicleref, create, var_6ecb77fd1f27c667 )
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
        
        data.damage.damagestatedata = [];
        data.damage.class = "none";
        data.damage.visualpercents = [];
        data.damage.visualcallbacks = [];
        data.damage.visualclearcallbacks = [];
        level.var_a0b2c978ca57ffc5[ vehicleref ] = data;
    }
    
    if ( function_89dc39dc11f3988c( vehicleref ) )
    {
        return function_29b4292c92443328( vehicleref ).damage;
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x11b2
// Size: 0xbf
function vehicle_damage_getinstancedataforvehicle( vehicle, create, var_6ecb77fd1f27c667 )
{
    instancedataforvehicle = vehicle.damagedata;
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        if ( istrue( create ) )
        {
            instancedataforvehicle = spawnstruct();
            vehicle.damagedata = instancedataforvehicle;
            instancedataforvehicle.destroyscoreevent = undefined;
            instancedataforvehicle.destroyscorelaunchonly = undefined;
            instancedataforvehicle.destroyaward = undefined;
            instancedataforvehicle.destroyawardlaunchonly = undefined;
            instancedataforvehicle.heavydamagescoreevent = undefined;
            instancedataforvehicle.heavydamagescorelaunchonly = undefined;
            instancedataforvehicle.heavydamageaward = undefined;
            instancedataforvehicle.heavydamageawardlaunchonly = undefined;
        }
        else if ( !istrue( var_6ecb77fd1f27c667 ) )
        {
            assertmsg( "<dev string:x1c>" );
        }
    }
    
    return instancedataforvehicle;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x127a
// Size: 0x16
function vehicle_damage_deregisterinstance( vehicle )
{
    vehicle.damagedata = undefined;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x1298
// Size: 0xa7
function vehicle_damage_getleveldatafordamagestate( vehicleref, stateref, create, var_6ecb77fd1f27c667 )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref, create, var_6ecb77fd1f27c667 );
    leveldatafordamagestate = leveldataforvehicle.damagestatedata[ stateref ];
    
    if ( !isdefined( leveldatafordamagestate ) )
    {
        if ( istrue( create ) )
        {
            leveldatafordamagestate = spawnstruct();
            leveldataforvehicle.damagestatedata[ stateref ] = leveldatafordamagestate;
            leveldatafordamagestate.maxhealth = undefined;
            leveldatafordamagestate.onentercallback = undefined;
            leveldatafordamagestate.onexitcallback = undefined;
        }
        else if ( !istrue( var_6ecb77fd1f27c667 ) )
        {
            assertmsg( "<dev string:x7a>" );
        }
    }
    
    return leveldatafordamagestate;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x1348
// Size: 0x91
function vehicle_damage_clearvisuals( data, changed, fromdeath )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( function_d93ec4635290febd(), 0, 1 );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        foreach ( callback in leveldataforvehicle.visualclearcallbacks )
        {
            self thread [[ callback ]]( data, changed, fromdeath );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x13e1
// Size: 0x12
function function_b0662e99fcc0b8e0()
{
    function_653b96ce8310763e( self.maxhealth );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x13fb
// Size: 0x66
function function_653b96ce8310763e( var_ca12ff65fd9d113e )
{
    self.health = int( min( self.health + var_ca12ff65fd9d113e, self.maxhealth ) );
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( function_d93ec4635290febd(), undefined, 1 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    function_e1d544cb065687f0( undefined, 0, 1 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage( self );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 8
// Checksum 0x0, Offset: 0x1469
// Size: 0x16a
function function_9cac3af67ee6b40a( vehicle, player, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon )
{
    seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat( vehicle, player );
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicle function_d93ec4635290febd() );
    
    if ( isdefined( seatid ) )
    {
        seatdata = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( vehicle function_d93ec4635290febd(), seatid );
        
        if ( isdefined( leveldataforvehicle.occupantdamagescale ) && isdefined( leveldataforvehicle.occupantdamagescale[ seatid ] ) )
        {
            idamage *= leveldataforvehicle.occupantdamagescale[ seatid ];
        }
        
        if ( isdefined( leveldataforvehicle.occupantdamageclamp ) && isdefined( leveldataforvehicle.occupantdamageclamp[ seatid ] ) )
        {
            idamage = clamp( idamage, 0, leveldataforvehicle.occupantdamageclamp[ seatid ] );
        }
        
        if ( isdefined( seatdata ) && isdefined( seatdata.var_dcfc487f4ef1103c ) && isdefined( idflags ) && idflags & 8 && !( idflags & 16384 ) && !player isinvehicleleanout() && !( isheadshot( shitloc, smeansofdeath, eattacker ) && isdefined( objweapon ) && weaponclass( objweapon ) == "sniper" ) )
        {
            idamage *= seatdata.var_dcfc487f4ef1103c;
        }
    }
    
    return idamage;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x15dc
// Size: 0x4d5
function function_f7123f6d38d50909()
{
    self endon( "death" );
    function_a913d098054d5bce();
    castcontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item" ] );
    
    while ( true )
    {
        if ( !isdefined( self.reactivearmor ) || self.reactivearmor.size == 0 || !isdefined( self.origin ) )
        {
            break;
        }
        
        if ( istrue( self.reactivearmordisabled ) )
        {
            waitframe();
            continue;
        }
        
        friendlyteam = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto( self );
        scripts\cp_mp\utility\game_utility::createprojectilepartition();
        
        foreach ( projectilearray in level.projectilepartition function_df633f460888a47( self.origin ) )
        {
            foreach ( projectile in projectilearray )
            {
                if ( !isdefined( projectile ) || !isdefined( projectile.origin ) )
                {
                    continue;
                }
                
                if ( distancesquared( projectile.origin, self.origin ) > 160000 )
                {
                    continue;
                }
                
                owner = projectile.owner;
                
                if ( !isdefined( owner ) && isdefined( projectile.weapon_name ) && weaponclass( projectile.weapon_name ) == "grenade" )
                {
                    owner = getmissileowner( projectile );
                }
                
                var_f31940d93afc41db = 1;
                
                /#
                    if ( getdvarint( @"hash_3c6c485214ca7673", 0 ) == 1 )
                    {
                        var_f31940d93afc41db = 0;
                    }
                #/
                
                if ( var_f31940d93afc41db && isdefined( owner ) && is_equal( friendlyteam, owner.team ) )
                {
                    continue;
                }
                
                /#
                    if ( getdvarint( @"hash_b16f847dc3049239" ) )
                    {
                        sphere( projectile.origin, 15, ( 1, 0, 0 ) );
                    }
                #/
                
                projectileorigin = projectile.origin;
                
                foreach ( tagname, data in self.reactivearmor )
                {
                    tagorigin = self gettagorigin( tagname );
                    totag = projectileorigin - tagorigin;
                    angle = math::anglebetweenvectors( totag, anglestoforward( self gettagangles( tagname ) ) );
                    
                    if ( angle > 30 )
                    {
                        continue;
                    }
                    
                    castresults = physics_raycast( tagorigin, projectileorigin, castcontents, [ self, projectile ], 0, "physicsquery_closest" );
                    
                    if ( isdefined( castresults ) && castresults.size > 0 )
                    {
                        continue;
                    }
                    
                    isleft = issubstr( tagname, "left" );
                    var_eaba477d71b264e6 = undefined;
                    
                    foreach ( othertag, data in array_randomize_objects( self.reactivearmor ) )
                    {
                        if ( othertag == tagname || issubstr( othertag, "left" ) != isleft )
                        {
                            continue;
                        }
                        
                        var_eaba477d71b264e6 = othertag;
                        break;
                    }
                    
                    self.damageableparts[ tagname ].healthvalue = 0;
                    function_77db32aa48a42a76( self, tagname, undefined, 1 );
                    
                    if ( isdefined( var_eaba477d71b264e6 ) )
                    {
                        self.damageableparts[ var_eaba477d71b264e6 ].healthvalue = 0;
                        function_77db32aa48a42a76( self, var_eaba477d71b264e6, undefined, 1 );
                    }
                    
                    function_577bb0f5a3fcc2bc( projectile );
                    break;
                }
            }
        }
        
        /#
            if ( getdvarint( @"hash_b16f847dc3049239" ) )
            {
                sphere( self.origin, 400, ( 0, 0, 1 ) );
                
                foreach ( tagname, data in self.reactivearmor )
                {
                    start = self gettagorigin( tagname );
                    end = start + anglestoforward( self gettagangles( tagname ) ) * 250;
                    line( start, end, ( 0, 0, 1 ) );
                }
            }
        #/
        
        waitframe();
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x1ab9
// Size: 0x18f
function function_577bb0f5a3fcc2bc( target )
{
    target setcandamage( 0 );
    target.exploding = 1;
    target stopsounds();
    
    if ( !isdefined( target.owner ) )
    {
        return;
    }
    
    if ( isplayer( target.owner ) )
    {
        target.owner scripts\cp_mp\damagefeedback::updatedamagefeedback( "reactivearmorexplosion" );
    }
    
    self.reactivearmorexplosion dontinterpolate();
    self.reactivearmorexplosion.origin = target.origin;
    up = target.origin - self.origin;
    right = up + ( 1, 0, 0 );
    forward = vectorcross( up, right );
    right = vectorcross( forward, up );
    self.reactivearmorexplosion.angles = axistoangles( forward, right, up );
    
    if ( istrue( self.explode1available ) )
    {
        self.reactivearmorexplosion setscriptablepartstate( "explode1", "activeDirectional", 0 );
        self.explode1available = 0;
    }
    else
    {
        self.reactivearmorexplosion setscriptablepartstate( "explode2", "activeDirectional", 0 );
        self.explode1available = 1;
    }
    
    if ( isdefined( target.streakname ) && target.streakname == "cruise_predator" )
    {
        target notify( "trophy_blocked" );
        return;
    }
    
    target delete();
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x1c50
// Size: 0x42
function function_a913d098054d5bce()
{
    explosion = spawn( "script_model", self.origin );
    explosion setmodel( "trophy_system_mp_explode" );
    self.explode1available = 1;
    self.reactivearmorexplosion = explosion;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x1c9a
// Size: 0x1c
function function_870cbf6ca47076b6( vehicleref )
{
    return vehicle_damage_getleveldataforvehicle( vehicleref ).var_9d70f02394c136da;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x1cbf
// Size: 0x1c
function function_32b9b5d07bb56c31( vehicleref )
{
    return vehicle_damage_getleveldataforvehicle( vehicleref ).var_ccfde1208ef2964b;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x1ce4
// Size: 0x72
function function_bc320cf9a1b27cb5( vehicleref, tagname, var_b4fccc158c681073, var_1c60586652067d4c )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    
    if ( isdefined( var_b4fccc158c681073 ) )
    {
        leveldataforvehicle.damageableparts[ tagname ].var_b4fccc158c681073 = var_b4fccc158c681073;
    }
    
    if ( isdefined( var_1c60586652067d4c ) )
    {
        leveldataforvehicle.damageableparts[ tagname ].var_1c60586652067d4c = var_1c60586652067d4c;
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x1d5e
// Size: 0x33
function function_1f39191797c711b6( vehicleref, expdamageradiussq )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    leveldataforvehicle.expdamageradiussq = expdamageradiussq;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x1d99
// Size: 0x197
function function_268e0e5863858dcf( vehicle, spawndata )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicle function_d93ec4635290febd(), 0, 1 );
    ishusk = vehicle isvehiclehusk();
    tags = undefined;
    
    if ( isdefined( spawndata.damageableparts ) )
    {
        tags = spawndata.damageableparts;
    }
    else if ( ishusk )
    {
        tags = leveldataforvehicle.var_ccfde1208ef2964b;
    }
    else
    {
        tags = leveldataforvehicle.var_9d70f02394c136da;
    }
    
    if ( isdefined( tags ) )
    {
        vehicle.damageableparts = [];
        
        foreach ( tagname, damageablepartdata in tags )
        {
            if ( istrue( damageablepartdata.inactive ) )
            {
                continue;
            }
            
            var_1c09c3e40955f379 = spawnstruct();
            var_1c09c3e40955f379.healthvalue = damageablepartdata.healthvalue;
            var_1c09c3e40955f379.explosivedamagehealthvalue = damageablepartdata.explosivedamagehealthvalue;
            vehicle.damageableparts[ tagname ] = var_1c09c3e40955f379;
            
            if ( istrue( damageablepartdata.isreactivearmor ) && !ishusk )
            {
                if ( !isdefined( vehicle.reactivearmor ) )
                {
                    vehicle.reactivearmor = [];
                }
                
                vehicle.reactivearmor[ tagname ] = var_1c09c3e40955f379;
            }
        }
    }
    
    if ( isdefined( vehicle.reactivearmor ) )
    {
        vehicle thread function_f7123f6d38d50909();
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x1f38
// Size: 0x200
function function_9b27177ad97bb8d8( vehicle )
{
    if ( !isdefined( vehicle ) || !vehicle isvehicle() || vehicle isvehiclehusk() )
    {
        return;
    }
    
    data = function_29b4292c92443328( vehicle function_d93ec4635290febd() );
    tags = data.damage.var_9d70f02394c136da;
    
    if ( !isdefined( data ) || !isdefined( data.interact ) || !isdefined( data.interact.lights ) || !isdefined( vehicle.damageableparts ) || !isdefined( tags ) )
    {
        return;
    }
    
    foreach ( tag, light in data.interact.lights )
    {
        if ( !isdefined( vehicle.damageableparts[ tag ] ) || !function_853c0063f08b55e1( vehicle.damageableparts[ tag ] ) )
        {
            continue;
        }
        
        if ( !isdefined( tags[ tag ] ) )
        {
            return;
        }
        
        vehicle.damageableparts[ tag ] = spawnstruct();
        vehicle.damageableparts[ tag ].healthvalue = tags[ tag ].healthvalue;
        vehicle.damageableparts[ tag ].explosivedamagehealthvalue = tags[ tag ].explosivedamagehealthvalue;
        state = "off";
        
        if ( istrue( vehicle.enginelightson ) )
        {
            if ( light.type == "engine_is_on_day_and_night" )
            {
                state = "on";
            }
            else if ( scripts\cp_mp\vehicles\vehicle_interact::function_5519f4e75a7e2d2b() && light.type == "engine_is_on_at_night" )
            {
                state = "on";
            }
        }
        
        vehicle setscriptablepartstate( tag, state );
        break;
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2140
// Size: 0xee
function function_963f1cb109b9c186( vehicle, tag )
{
    if ( !isdefined( vehicle ) || !isdefined( tag ) )
    {
        return 0;
    }
    
    data = vehicle_damage_getleveldataforvehicle( vehicle function_d93ec4635290febd() );
    tags = undefined;
    
    if ( vehicle isvehiclehusk() )
    {
        tags = data.var_ccfde1208ef2964b;
    }
    else
    {
        tags = data.var_9d70f02394c136da;
    }
    
    if ( !isdefined( tags[ tag ] ) )
    {
        return 0;
    }
    
    damageablepartdata = spawnstruct();
    damageablepartdata.healthvalue = tags[ tag ].healthvalue;
    damageablepartdata.explosivedamagehealthvalue = tags[ tag ].explosivedamagehealthvalue;
    
    if ( !isdefined( vehicle.damageableparts ) )
    {
        vehicle.damageableparts = [];
    }
    
    vehicle.damageableparts[ tag ] = damageablepartdata;
    vehicle setscriptablepartstate( tag, "default" );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x2236
// Size: 0x308
function function_152437480e61a8a2( vehicle, damagedata, unmodifieddamage )
{
    damagemultiplier = 1;
    tagnames = function_786c7ec25aad5005( vehicle, damagedata );
    ref = vehicle function_d93ec4635290febd();
    vehicledata = vehicle_damage_getleveldataforvehicle( ref );
    
    /#
        if ( getdvarint( @"hash_d6a84652bcb25596", 0 ) == 1 && tagnames.size > 0 )
        {
            string = "<dev string:xc8>";
            
            foreach ( tag in tagnames )
            {
                string += tag + "<dev string:xd1>";
            }
            
            string += "<dev string:xd7>" + unmodifieddamage;
            iprintlnbold( string );
        }
    #/
    
    foreach ( tagname in tagnames )
    {
        if ( !function_6e87d9e8601d9029( vehicle, tagname, damagedata ) )
        {
            continue;
        }
        
        var_fc00c9efa9cebdbc = vehicle.damageableparts[ tagname ].healthvalue;
        damage = max( 0, unmodifieddamage - function_c9f618f05861c2c5( ref, tagname ) );
        var_f943483e687a2247 = max( 0, var_fc00c9efa9cebdbc - damage );
        vehicle.damageableparts[ tagname ].healthvalue = var_f943483e687a2247;
        
        if ( isdefined( damagedata ) && isdefined( damagedata.objweapon ) && iscrossbowdamage( damagedata.objweapon ) )
        {
            if ( function_ee1ff9eed64d1e5d( vehicle, tagname ) )
            {
                vehicle.damageableparts[ tagname ].healthvalue = 0;
            }
        }
        
        if ( isexplosivedamagemod( damagedata.meansofdeath ) )
        {
            var_858e06144ffaaf87 = vehicle.damageableparts[ tagname ].explosivedamagehealthvalue;
            var_9824258c4e398daa = var_858e06144ffaaf87 - unmodifieddamage;
            vehicle.damageableparts[ tagname ].explosivedamagehealthvalue = max( 0, var_9824258c4e398daa );
            
            if ( istrue( vehicledata.damageableparts[ tagname ].blockexplosivedamage ) )
            {
                damagemultiplier *= 0.33;
            }
        }
        else if ( istrue( vehicledata.damageableparts[ tagname ].blockbulletdamage ) )
        {
            damagemultiplier = 0.0001;
        }
        
        if ( function_853c0063f08b55e1( vehicle.damageableparts[ tagname ] ) )
        {
            function_77db32aa48a42a76( vehicle, tagname, damagedata );
            continue;
        }
        
        var_cf8eaf8bc98090a6 = function_dde06c2157ec8895( ref, tagname );
        
        if ( isdefined( var_cf8eaf8bc98090a6 ) )
        {
            vehicle thread [[ var_cf8eaf8bc98090a6 ]]( vehicle, damagedata );
        }
    }
    
    return damagemultiplier;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2547
// Size: 0x289
function function_9b1b715feb24f29f( vehicle, damagedata )
{
    ref = vehicle function_d93ec4635290febd();
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    vehicledata = vehicle_damage_getleveldataforvehicle( ref );
    
    if ( !isdefined( vehicledata ) )
    {
        return;
    }
    
    partdata = vehicledata.damageableparts;
    
    if ( !isdefined( partdata ) )
    {
        return;
    }
    
    tagnames = function_786c7ec25aad5005( vehicle, damagedata );
    
    /#
        if ( getdvarint( @"hash_d6a84652bcb25596", 0 ) == 1 && tagnames.size > 0 )
        {
            string = "<dev string:xc8>";
            
            foreach ( tag in tagnames )
            {
                string += tag + "<dev string:xd1>";
            }
            
            iprintlnbold( string );
        }
    #/
    
    foreach ( tagname in tagnames )
    {
        if ( function_6e87d9e8601d9029( vehicle, tagname, damagedata ) )
        {
            if ( !isdefined( partdata[ tagname ] ) || !isdefined( partdata[ tagname ].windowref ) )
            {
                continue;
            }
            
            if ( isexplosivedamagemod( damagedata.meansofdeath ) )
            {
                var_9824258c4e398daa = vehicle.damageableparts[ tagname ].explosivedamagehealthvalue - damagedata.damage;
                vehicle.damageableparts[ tagname ].explosivedamagehealthvalue = max( 0, var_9824258c4e398daa );
            }
            else
            {
                damage = max( 0, damagedata.damage - function_c9f618f05861c2c5( ref, tagname ) );
                var_f943483e687a2247 = max( 0, vehicle.damageableparts[ tagname ].healthvalue - damage );
                vehicle.damageableparts[ tagname ].healthvalue = var_f943483e687a2247;
            }
            
            if ( function_853c0063f08b55e1( vehicle.damageableparts[ tagname ] ) )
            {
                function_77db32aa48a42a76( vehicle, tagname, damagedata );
                continue;
            }
            
            var_cf8eaf8bc98090a6 = function_dde06c2157ec8895( ref, tagname );
            
            if ( isdefined( var_cf8eaf8bc98090a6 ) )
            {
                vehicle thread [[ var_cf8eaf8bc98090a6 ]]( vehicle, damagedata );
            }
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x27d8
// Size: 0x28f
function function_77db32aa48a42a76( vehicle, tagname, damagedata, reactivearmorexplosion )
{
    deathstatename = function_82cad97b4499e421( vehicle, tagname, reactivearmorexplosion );
    vehicle setscriptablepartstate( tagname, deathstatename );
    var_b4fccc158c681073 = function_bad6c0e32ff1e092( vehicle function_d93ec4635290febd(), tagname );
    damageablepartdata = function_29b4292c92443328( vehicle function_d93ec4635290febd() ).damage.damageableparts[ tagname ];
    
    if ( isdefined( damageablepartdata ) && isdefined( damageablepartdata.wheelref ) )
    {
        if ( !isdefined( vehicle.deadwheels ) )
        {
            vehicle.deadwheels = [];
        }
        
        vehicle.deadwheels[ tagname ] = damageablepartdata;
    }
    
    if ( isdefined( damageablepartdata ) && isdefined( damageablepartdata.windowref ) )
    {
        vehicle callsharedfunc( "pmc_missions", "onShatterWindow", damagedata );
    }
    
    if ( isdefined( damageablepartdata ) && isdefined( damageablepartdata.doorref ) )
    {
        if ( !isdefined( vehicle.var_41e6777f1fa66044 ) )
        {
            vehicle.var_41e6777f1fa66044 = [];
        }
        
        vehicle.var_41e6777f1fa66044[ damageablepartdata.doorref ] = 1;
        
        if ( vehicle function_452936099dcd1b94( damageablepartdata.doorref ) )
        {
            vehicle function_14219d4c7d83499f( damageablepartdata.doorref );
        }
        
        occupant = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant( vehicle, damageablepartdata.doorref );
        
        if ( isdefined( occupant ) )
        {
            occupant val::set( "vehicle_occupant", "vehicle_lean_out", 0 );
            scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setcurrentseat( vehicle, damageablepartdata.doorref, occupant );
        }
    }
    
    if ( isdefined( damageablepartdata ) && istrue( damageablepartdata.isreactivearmor ) && isdefined( vehicle.reactivearmor ) )
    {
        vehicle.reactivearmor[ tagname ] = undefined;
    }
    
    if ( isdefined( vehicle.damageableparts[ tagname ].var_673c6895d1418e1c ) )
    {
        foreach ( bolt in vehicle.damageableparts[ tagname ].var_673c6895d1418e1c )
        {
            if ( isdefined( bolt ) && istrue( bolt.iscrossbowbolt ) )
            {
                bolt scripts\cp_mp\crossbow::boltunlink();
            }
        }
    }
    
    if ( isdefined( var_b4fccc158c681073 ) )
    {
        vehicle thread [[ var_b4fccc158c681073 ]]( vehicle, damagedata );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x2a6f
// Size: 0x2b, Type: bool
function function_6c49fb45260b8c4c( seatref )
{
    return isdefined( self ) && isdefined( self.var_41e6777f1fa66044 ) && istrue( self.var_41e6777f1fa66044[ seatref ] );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2aa3
// Size: 0x84
function function_ec4b6f058d183338( vehicle, damagedata )
{
    if ( isdefined( vehicle.damageableparts ) )
    {
        foreach ( tagname, data in vehicle.damageableparts )
        {
            if ( !function_853c0063f08b55e1( data ) )
            {
                function_77db32aa48a42a76( vehicle, tagname, damagedata );
            }
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x2b2f
// Size: 0x99
function function_19953ff235374847( vehicle )
{
    data = vehicle_damage_getleveldataforvehicle( vehicle function_d93ec4635290febd() );
    tags = undefined;
    
    if ( vehicle isvehiclehusk() )
    {
        tags = data.var_ccfde1208ef2964b;
    }
    else
    {
        tags = data.var_9d70f02394c136da;
    }
    
    foreach ( tag, data in tags )
    {
        function_963f1cb109b9c186( vehicle, tag );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x2bd0
// Size: 0x161
function function_9542eac6997b9060( vehicle )
{
    if ( isdefined( vehicle.damageableparts ) )
    {
        damageablepartdata = function_2265b277a0dad0f1( vehicle function_d93ec4635290febd() );
        
        if ( !isdefined( vehicle.randomwindows ) )
        {
            windows = [];
            
            foreach ( tagname, data in vehicle.damageableparts )
            {
                if ( isdefined( damageablepartdata[ tagname ].windowref ) )
                {
                    windows[ tagname ] = data;
                }
            }
            
            vehicle.randomwindows = array_randomize_objects( windows );
        }
        
        foreach ( tagname, data in vehicle.randomwindows )
        {
            if ( !function_853c0063f08b55e1( data ) )
            {
                data.healthvalue = max( 0, data.healthvalue - randomintrange( 50, 125 ) );
                
                if ( function_853c0063f08b55e1( data ) )
                {
                    function_77db32aa48a42a76( vehicle, tagname );
                    vehicle.randomwindows[ tagname ] = undefined;
                }
                
                break;
            }
            
            vehicle.randomwindows[ tagname ] = undefined;
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x2d39
// Size: 0x67
function function_66ac97eba6b35b4a( vehicle, tagname, damagedata )
{
    scriptablepartname = function_f7df41d3ad15dca8( vehicle function_d93ec4635290febd(), tagname );
    vehicle setscriptablepartstate( scriptablepartname, "hide" );
    var_b4fccc158c681073 = function_bad6c0e32ff1e092( vehicle function_d93ec4635290febd(), tagname );
    
    if ( isdefined( var_b4fccc158c681073 ) )
    {
        vehicle thread [[ var_b4fccc158c681073 ]]( vehicle, damagedata );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2da8
// Size: 0x1d
function function_4b3ef3d76f7e39b6( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 0, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2dcd
// Size: 0x1e
function function_d4c899afe6cbf533( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 1, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2df3
// Size: 0x1e
function function_1c35d2bee2c14d7b( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 2, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2e19
// Size: 0x1e
function function_2e20b5a5d4f70228( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 3, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2e3f
// Size: 0x1e
function function_79b9f63570444468( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 4, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2e65
// Size: 0x1e
function function_4c7a8d0b6c6c16cd( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 5, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2e8b
// Size: 0x1e
function function_1cbe55c0515820b5( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 6, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x2eb1
// Size: 0x1e
function function_6469ea91038491e2( vehicle, damagedata )
{
    function_7143b00f866ef1ec( vehicle, 7, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2ed7
// Size: 0x2ff
function private function_7143b00f866ef1ec( vehicle, tireindex, damagedata )
{
    if ( vehicle vehicle_isphysveh() && vehicle vehphys_isgroundvehicle() )
    {
        vehicle blowuptire( tireindex );
    }
    
    if ( !isdefined( vehicle.flattiremask ) )
    {
        vehicle.flattiremask = 0;
    }
    
    vehicle.flattiremask |= 1 << tireindex;
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
    
    if ( isdefined( occupants ) )
    {
        foreach ( occupant in occupants )
        {
            function_eae2223216b7712c( vehicle, occupant );
        }
    }
    
    tagname = undefined;
    
    if ( isdefined( damagedata ) && isdefined( damagedata.partname ) && isstring( damagedata.partname ) && damagedata.partname != "" )
    {
        tagname = damagedata.partname;
    }
    else if ( isdefined( damagedata ) && isdefined( damagedata.attachtagname ) && isstring( damagedata.attachtagname ) && damagedata.attachtagname != "" )
    {
        tagname = damagedata.attachtagname;
    }
    
    if ( isdefined( vehicle ) && isdefined( vehicle.origin ) && isdefined( tagname ) && vehicle vehicle_isphysveh() )
    {
        data = function_29b4292c92443328( vehicle function_d93ec4635290febd() );
        speed = vehicle vehicle_getspeed();
        maxspeed = vehicle vehicle_gettopspeedforward();
        force = math::normalize_value( 0, maxspeed / 2, speed );
        force = force * 0.8 + 0.2;
        force *= data.damage.var_96f121d1edfdb0cb;
        self vehphys_impulse( vehicle.origin - vehicle gettagorigin( tagname ) + ( 0, 0, 300 ), int( 255 * force ), 1 );
    }
    
    if ( !vehicle isvehiclehusk() && isdefined( damagedata ) && isdefined( damagedata.attacker ) && isplayer( damagedata.attacker ) )
    {
        isenemy = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer( vehicle, damagedata.attacker );
        damagedata.givepointsandxp = isenemy;
        damagedata.attacker vehicle_damage_givescoreandxpatframeend( #"destroyed_vehicle_tire", undefined, damagedata, vehicle );
        vehicle callsharedfunc( "pmc_missions", "onPopTire", damagedata.attacker, isenemy );
    }
    
    scripts\cp_mp\challenges::function_bd4827ad81a943a( vehicle, damagedata );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x31de
// Size: 0xe
function private function_79a4d42ef833438a()
{
    scripts\engine\scriptable::scriptable_addusedcallback( &function_4b8d35d7af7fd960 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 6
// Checksum 0x0, Offset: 0x31f4
// Size: 0xd3
function function_4b8d35d7af7fd960( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( usestring ) || !isdefined( instance ) || !isdefined( instance.entity ) || !instance.entity isvehicle() )
    {
        return;
    }
    
    if ( usestring == "row1_left" || usestring == "row1_right" || usestring == "row2_left" || usestring == "row2_right" || usestring == "row3_left" || usestring == "row3_right" || usestring == "row4_left" || usestring == "row4_right" )
    {
        function_770f9f7300665( instance.entity, instance, part, usestring, player, 0 );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x32cf
// Size: 0x8a
function function_e6f68a61bffc259a( vehicle, var_c0d0511fe3faf573 )
{
    if ( isdefined( vehicle.deadwheels ) )
    {
        foreach ( part, data in vehicle.deadwheels )
        {
            function_770f9f7300665( vehicle, vehicle, part, data.wheelref, undefined, var_c0d0511fe3faf573 );
            break;
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x3361
// Size: 0x82
function function_9ae605ed3dc3bd1( vehicle )
{
    if ( isdefined( vehicle.deadwheels ) )
    {
        foreach ( part, data in vehicle.deadwheels )
        {
            vehicle thread function_770f9f7300665( vehicle, vehicle, part, data.wheelref, undefined, 1 );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x33eb
// Size: 0x1fe
function private function_770f9f7300665( vehicle, scriptable, part, tirename, player, var_c0d0511fe3faf573 )
{
    vehicle endon( "death" );
    
    if ( isdefined( player ) )
    {
        player thread function_3bde2944d834b090();
        player callback::callback( "on_vehicle_tire_repaired" );
    }
    
    scriptable setscriptablepartstate( part, "repaired" );
    wait 0.1;
    tireindex = function_948c6c379e1a9b52( tirename );
    vehicle pristinetire( tireindex );
    
    if ( isdefined( vehicle.deadwheels ) && isdefined( vehicle.deadwheels[ part ] ) )
    {
        vehicle.damageableparts[ part ].healthvalue = vehicle.deadwheels[ part ].healthvalue;
        vehicle.damageableparts[ part ].explosivedamagehealthvalue = vehicle.deadwheels[ part ].explosivedamagehealthvalue;
    }
    
    if ( !isdefined( vehicle.flattiremask ) )
    {
        vehicle.flattiremask = 0;
    }
    
    vehicle.flattiremask &= ~( 1 << tireindex );
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( vehicle, 0 );
    
    if ( isdefined( occupants ) )
    {
        foreach ( occupant in occupants )
        {
            function_eae2223216b7712c( vehicle, occupant );
            occupant callback::callback( "on_vehicle_tire_repaired" );
        }
    }
    
    if ( isdefined( vehicle.deadwheels ) )
    {
        vehicle.deadwheels[ part ] = undefined;
        
        if ( vehicle.deadwheels.size == 0 )
        {
            vehicle.deadwheels = undefined;
        }
    }
    
    function_c3da7bb5f5499152( vehicle, part, var_c0d0511fe3faf573 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x35f1
// Size: 0x3f
function private function_3bde2944d834b090()
{
    self endon( "death_or_disconnect" );
    weapobj = makeweapon( "iw8_ges_plyr_loot_pickup" );
    self giveandfireoffhand( weapobj );
    wait 1.17;
    
    if ( self hasweapon( weapobj ) )
    {
        self takeweapon( weapobj );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3638
// Size: 0x50
function private function_c3da7bb5f5499152( vehicle, part, var_c0d0511fe3faf573 )
{
    repairsoundlocation = vehicle gettagorigin( part );
    repairsound = "veh_repair_tire";
    
    if ( var_c0d0511fe3faf573 )
    {
        repairsound = "veh_repair_tire_at_station";
    }
    
    playsoundatpos( repairsoundlocation, repairsound );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3690
// Size: 0xa5
function private function_948c6c379e1a9b52( tirename )
{
    switch ( tirename )
    {
        case #"hash_19baa7ca5b52f06a":
            return 0;
        case #"hash_60b26be014fd7337":
            return 1;
        case #"hash_67ed6be3637f19ed":
            return 2;
        case #"hash_227fe4df4167aa26":
            return 3;
        case #"hash_f0704f57a0dd2250":
            return 4;
        case #"hash_cbd67f63f80e6245":
            return 5;
        case #"hash_711797dce2a722a3":
            return 6;
        case #"hash_6ade103971ce6e2c":
            return 7;
        default:
            assert( "<dev string:xe4>" );
            break;
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x373d
// Size: 0x46
function function_eae2223216b7712c( vehicle, player )
{
    if ( !isdefined( vehicle.flattiremask ) )
    {
        vehicle.flattiremask = 0;
    }
    
    player setclientomnvar( "ui_veh_flat_tire_mask", vehicle.flattiremask );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x378b
// Size: 0x184
function function_b9d933a7b78a67ad( data )
{
    modifieddamage = data.damage;
    modifieddamage = function_1faeb1a037b3b515( data.inflictor, modifieddamage );
    
    if ( issharedfuncdefined( "vehicle_damage", "modifyVehicleDamage" ) )
    {
        modifieddamage = self [[ getsharedfunc( "vehicle_damage", "modifyVehicleDamage" ) ]]( data.inflictor, data.objweapon, modifieddamage );
    }
    
    if ( isdefined( self.streakname ) )
    {
        bundle = level.streakglobals.streakbundles[ self.streakname ];
        var_cc8913d1b2828045 = 0;
        
        switch ( self.streakname )
        {
            case #"hash_349713b5ad494dda":
                var_cc8913d1b2828045 = isdefined( bundle ) && istrue( bundle.var_afd5757c4e4fa4cc );
                break;
            case #"hash_bf2f9adbd2b41d5":
                var_cc8913d1b2828045 = isdefined( bundle ) && istrue( bundle.var_280b2a9ef1f95ac1 );
                break;
            case #"hash_887ad77192b9c4fb":
                var_cc8913d1b2828045 = isdefined( bundle ) && istrue( bundle.var_8f5f5a121030bb97 );
                break;
        }
        
        if ( var_cc8913d1b2828045 && isdefined( bundle ) )
        {
            modifieddamage = self [[ getsharedfunc( "killstreak", "getModifiedDamageUsingDamageTuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d );
        }
    }
    
    return modifieddamage;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x3918
// Size: 0xa4
function function_1faeb1a037b3b515( inflictor, damage )
{
    if ( !isdefined( inflictor ) || !isagent( inflictor ) )
    {
        return damage;
    }
    
    ref = function_d93ec4635290febd();
    
    if ( !isdefined( ref ) || !function_89dc39dc11f3988c( ref ) )
    {
        return damage;
    }
    
    vehicledata = function_29b4292c92443328( ref );
    
    if ( !isdefined( vehicledata ) || !isdefined( vehicledata.damage ) || !isdefined( vehicledata.damage.agentdamagemultiplier ) )
    {
        return damage;
    }
    
    return damage * vehicledata.damage.agentdamagemultiplier;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x39c5
// Size: 0x1a3, Type: bool
function function_c5a55810ed63c87d( data )
{
    if ( !isdefined( data.point ) || !isdefined( data.objweapon ) || !isdefined( data.objweapon.damageradius ) )
    {
        return true;
    }
    
    ref = function_d93ec4635290febd();
    
    if ( !isdefined( ref ) || !function_89dc39dc11f3988c( ref ) )
    {
        return true;
    }
    
    vehicledata = function_29b4292c92443328( ref );
    
    if ( !isdefined( vehicledata ) || !isdefined( vehicledata.damage ) || !isdefined( vehicledata.damage.explosionextents ) )
    {
        return true;
    }
    
    radius = data.objweapon.damageradius;
    bounds = vehicledata.damage.explosionextents;
    localorigin = coordtransformtranspose( data.point, self.origin, self.angles );
    return localorigin[ 0 ] > ( bounds.back + radius ) * -1 && localorigin[ 0 ] < bounds.front + radius && localorigin[ 1 ] > ( bounds.left + radius ) * -1 && localorigin[ 1 ] < bounds.right + radius && localorigin[ 2 ] > ( bounds.bottom + radius ) * -1 && localorigin[ 2 ] < bounds.top + radius;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x3b71
// Size: 0x225
function vehicle_damage_init()
{
    assertex( isdefined( level.vehicle ), "<dev string:x122>" );
    assertex( !isdefined( level.vehicle.damage ), "<dev string:x159>" );
    leveldata = spawnstruct();
    level.vehicle.damage = leveldata;
    level.var_ec75ca2494d74dab = getdvarint( @"hash_4421544b585f6be5", utility::ismp() ) == 1;
    level.deathanimsenabled = getdvarint( @"hash_6fc86a5e3cedbd94", 0 ) == 1;
    leveldata.vehicledata = [];
    leveldata.heavystatehealthadd = getdvarint( @"hash_a3b9b8945213c089", 350 );
    leveldata.mediumstatehealthratio = getdvarfloat( @"hash_4217d1e671e33953", 0.5 );
    leveldata.burndowntime = getdvarfloat( @"hash_1021d59d6f0d99a0", 8 );
    vehicle_damage_loadtable();
    vehicle_damage_initdebug();
    
    if ( issharedfuncdefined( "vehicle_damage", "init" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "init" ) ]]();
    }
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x1a0>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x1c5>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x1d9>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x1f3>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x217>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x232>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x256>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x271>", 1 );
    #/
    
    /#
        issharedfuncdefined( "<dev string:x18e>", "<dev string:x28d>", 1 );
    #/
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        vehicle_damage_inithitdamage_br();
    }
    else
    {
        vehicle_damage_inithitdamage();
    }
    
    vehicle_damage_initmoddamage();
    function_79a4d42ef833438a();
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x3d9e
// Size: 0x344
function vehicle_damage_loadtable()
{
    leveldata = vehicle_damage_getleveldata();
    table = spawnstruct();
    leveldata.table = table;
    table.modsforclass = [];
    table.modsforvehicle = [];
    table.hitsperattackforclass = [];
    table.hitsperattackforvehicle = [];
    table.skipburndownforclass = [];
    table.skipburndownforvehicle = [];
    var_b271a3d0c941cd5c = [];
    var_b271a3d0c941cd5c[ "class" ] = [];
    var_b271a3d0c941cd5c[ "vehicle" ] = [];
    var_870d49f076632bf2 = [];
    var_870d49f076632bf2[ "weaponMod" ] = [];
    var_870d49f076632bf2[ "weaponHPA" ] = [];
    var_870d49f076632bf2[ "weaponSkipBurnDown" ] = [];
    
    if ( getdvar( @"scr_vehicle_damage_table", "" ) != "" )
    {
        table = getdvar( @"scr_vehicle_damage_table", "" );
    }
    else
    {
        table = "mp_cp/vehicleDamageTable.csv";
    }
    
    colcategory = undefined;
    numcols = tablelookupgetnumcols( table );
    
    for ( numcol = 1; numcol < numcols ; numcol++ )
    {
        colstr = tablelookupbyrow( table, 0, numcol );
        
        if ( isdefined( colstr ) && colstr != "" )
        {
            if ( getsubstr( colstr, 0, 1 ) == "*" )
            {
                colcategory = getsubstr( colstr, 1, colstr.size );
                continue;
            }
            
            if ( isdefined( var_b271a3d0c941cd5c[ colcategory ] ) )
            {
                var_b271a3d0c941cd5c[ colcategory ][ colstr ] = numcol;
            }
        }
    }
    
    rowcategory = undefined;
    numrow = 0;
    numrows = tablelookupgetnumrows( table );
    
    for ( numrow = 0; numrow < numrows ; numrow++ )
    {
        rowstr = tablelookupbyrow( table, numrow, 1 );
        
        if ( isdefined( rowstr ) && rowstr != "" )
        {
            if ( getsubstr( rowstr, 0, 1 ) == "*" )
            {
                rowcategory = getsubstr( rowstr, 1, rowstr.size );
                continue;
            }
            
            if ( isdefined( var_870d49f076632bf2[ rowcategory ] ) )
            {
                var_870d49f076632bf2[ rowcategory ][ rowstr ] = numrow;
            }
        }
    }
    
    foreach ( rowcategory, var_247c537da346ffde in var_870d49f076632bf2 )
    {
        foreach ( rowstr, rownum in var_247c537da346ffde )
        {
            foreach ( colcategory, var_2e078af567792360 in var_b271a3d0c941cd5c )
            {
                foreach ( colstr, colnum in var_2e078af567792360 )
                {
                    cellstr = tablelookup( table, 0, rownum, colnum );
                    
                    if ( isdefined( cellstr ) && cellstr != "" )
                    {
                        vehicle_damage_loadtablecell( cellstr, rowstr, rowcategory, colstr, colcategory );
                    }
                }
            }
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 5
// Checksum 0x0, Offset: 0x40ea
// Size: 0x206
function vehicle_damage_loadtablecell( cellstr, rowstr, rowcategory, colstr, colcategory )
{
    leveldata = vehicle_damage_getleveldata();
    table = leveldata.table;
    
    if ( rowcategory == "weaponMod" )
    {
        cellvalue = float( cellstr );
        
        if ( colcategory == "class" )
        {
            if ( !isdefined( table.modsforclass[ colstr ] ) )
            {
                table.modsforclass[ colstr ] = [];
            }
            
            table.modsforclass[ colstr ][ rowstr ] = cellvalue;
        }
        else if ( colcategory == "vehicle" )
        {
            if ( !isdefined( table.modsforvehicle[ colstr ] ) )
            {
                table.modsforvehicle[ colstr ] = [];
            }
            
            table.modsforvehicle[ colstr ][ rowstr ] = cellvalue;
        }
    }
    
    if ( rowcategory == "weaponHPA" )
    {
        cellvalue = int( cellstr );
        
        if ( colcategory == "class" )
        {
            if ( !isdefined( table.hitsperattackforclass[ colstr ] ) )
            {
                table.hitsperattackforclass[ colstr ] = [];
            }
            
            table.hitsperattackforclass[ colstr ][ rowstr ] = cellvalue;
        }
        else if ( colcategory == "vehicle" )
        {
            if ( !isdefined( table.hitsperattackforvehicle[ colstr ] ) )
            {
                table.hitsperattackforvehicle[ colstr ] = [];
            }
            
            table.hitsperattackforvehicle[ colstr ][ rowstr ] = cellvalue;
        }
    }
    
    if ( rowcategory == "weaponSkipBurnDown" )
    {
        cellvalue = int( cellstr ) != 0;
        
        if ( colcategory == "class" )
        {
            if ( !isdefined( table.skipburndownforclass[ colstr ] ) )
            {
                table.skipburndownforclass[ colstr ] = [];
            }
            
            table.skipburndownforclass[ colstr ][ rowstr ] = cellvalue;
            return;
        }
        
        if ( colcategory == "vehicle" )
        {
            if ( !isdefined( table.skipburndownforvehicle[ colstr ] ) )
            {
                table.skipburndownforvehicle[ colstr ] = [];
            }
            
            table.skipburndownforvehicle[ colstr ][ rowstr ] = cellvalue;
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x42f8
// Size: 0x219
function vehicle_damage_applytabletovehicle( vehicleref, var_6ecb77fd1f27c667 )
{
    leveldata = vehicle_damage_getleveldata();
    table = leveldata.table;
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref, undefined, var_6ecb77fd1f27c667 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    class = leveldataforvehicle.class;
    
    if ( isdefined( table.modsforclass[ class ] ) )
    {
        foreach ( weaponclass, mod in table.modsforclass[ class ] )
        {
            vehicle_damage_setweaponclassmoddamageforvehicle( weaponclass, mod, 0, vehicleref );
        }
    }
    
    if ( isdefined( table.modsforvehicle[ vehicleref ] ) )
    {
        foreach ( weaponclass, mod in table.modsforvehicle[ vehicleref ] )
        {
            vehicle_damage_setweaponclassmoddamageforvehicle( weaponclass, mod, 0, vehicleref );
        }
    }
    
    if ( isdefined( table.hitsperattackforclass[ class ] ) )
    {
        foreach ( weaponref, hitsperattack in table.hitsperattackforclass[ class ] )
        {
            vehicle_damage_setweaponhitdamagedataforvehicle( weaponref, hitsperattack, vehicleref );
            vehicle_damage_setvehiclehitdamagedataforweapon( vehicleref, 100, weaponref );
        }
    }
    
    if ( isdefined( table.hitsperattackforvehicle[ vehicleref ] ) )
    {
        foreach ( weaponref, hitsperattack in table.hitsperattackforvehicle[ vehicleref ] )
        {
            vehicle_damage_setweaponhitdamagedataforvehicle( weaponref, hitsperattack, vehicleref );
            vehicle_damage_setvehiclehitdamagedataforweapon( vehicleref, 100, weaponref );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x4519
// Size: 0x26d
function vehicle_damage_inithitdamage()
{
    vehicle_damage_setweaponhitdamagedata( "iw8_la_gromeo_mp", 5 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_kgolf_mp", 5 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_rpapa7_mp", 5 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_juliet_mp", 6 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_gromeoks_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_mike32_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "iw8_ar_mike4_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "iw8_ar_akilo47_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "iw9_la_gromeo_mp", 5 );
    vehicle_damage_setweaponhitdamagedata( "iw9_la_juliet_mp", 6 );
    vehicle_damage_setweaponhitdamagedata( "jup_jp22_la_dromeo_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "frag_grenade_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "t10_frag_grenade_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "jup_frag_grenade_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "semtex_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "c4_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "at_mine_ap_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "at_mine_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "claymore_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "jup_claymore_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "jup_claymore_cp", 3 );
    vehicle_damage_setweaponhitdamagedata( "molotov_mp", 2 );
    vehicle_damage_setweaponhitdamagedata( "thermite_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "thermite_av_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "thermite_bolt_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "semtex_bolt_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "thermite_xmike109_mp", 0.5 );
    vehicle_damage_setweaponhitdamagedata( "semtex_xmike109_mp", 2 );
    vehicle_damage_setweaponhitdamagedata( "chopper_gunner_proj_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "missile_turret_proj_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "missile_turret_proj_jup_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "toma_proj_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "cruise_proj_mp", 15 );
    vehicle_damage_setweaponhitdamagedata( "artillery_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "nuke_mp", 15 );
    vehicle_damage_setweaponhitdamagedata( "gunship_hellfire_mp", 15 );
    vehicle_damage_setweaponhitdamagedata( "gunship_105mm_mp", 15 );
    vehicle_damage_setweaponhitdamagedata( "gunship_40mm_mp", 5 );
    vehicle_damage_setweaponhitdamagedata( "gunship_25mm_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "hover_jet_proj_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "chopper_gunner_turret_dmz", 40 );
    vehicle_damage_setweaponhitdamagedata( "loitering_munition_proj_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "emp_drone_non_player_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "emp_drone_non_player_direct_mp", 5 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x478e
// Size: 0x243
function vehicle_damage_inithitdamage_br()
{
    vehicle_damage_setweaponhitdamagedata( "iw8_la_gromeo_mp", 10 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_kgolf_mp", 10 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_rpapa7_mp", 10 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_juliet_mp", 20 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_gromeoks_mp", 10 );
    vehicle_damage_setweaponhitdamagedata( "iw8_la_mike32_mp", 6 );
    vehicle_damage_setweaponhitdamagedata( "iw8_ar_mike4_mp", 6 );
    vehicle_damage_setweaponhitdamagedata( "iw8_ar_akilo47_mp", 6 );
    vehicle_damage_setweaponhitdamagedata( "iw9_la_gromeo_mp", 10 );
    vehicle_damage_setweaponhitdamagedata( "iw9_la_juliet_mp", 20 );
    vehicle_damage_setweaponhitdamagedata( "c4_mp", 13 );
    vehicle_damage_setweaponhitdamagedata( "semtex_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "frag_grenade_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "t10_frag_grenade_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "jup_frag_grenade_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "pop_rocket_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "molotov_mp", 2 );
    vehicle_damage_setweaponhitdamagedata( "at_mine_ap_mp", 5 );
    vehicle_damage_setweaponhitdamagedata( "at_mine_mp", 13 );
    vehicle_damage_setweaponhitdamagedata( "thermite_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "thermite_av_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "emp_grenade_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "claymore_mp", 13 );
    vehicle_damage_setweaponhitdamagedata( "jup_claymore_mp", 13 );
    vehicle_damage_setweaponhitdamagedata( "jup_claymore_cp", 13 );
    vehicle_damage_setweaponhitdamagedata( "thermite_bolt_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "semtex_bolt_mp", 4 );
    vehicle_damage_setweaponhitdamagedata( "thermite_xmike109_mp", 0.5 );
    vehicle_damage_setweaponhitdamagedata( "semtex_xmike109_mp", 2 );
    vehicle_damage_setweaponhitdamagedata( "toma_proj_mp", 12 );
    vehicle_damage_setweaponhitdamagedata( "cruise_proj_mp", 15 );
    vehicle_damage_setweaponhitdamagedata( "artillery_mp", 10 );
    vehicle_damage_setweaponhitdamagedata( "nuke_mp", 20 );
    vehicle_damage_setweaponhitdamagedata( "gunship_hellfire_mp", 15 );
    vehicle_damage_setweaponhitdamagedata( "gunship_105mm_mp", 15 );
    vehicle_damage_setweaponhitdamagedata( "gunship_40mm_mp", 5 );
    vehicle_damage_setweaponhitdamagedata( "gunship_25mm_mp", 1 );
    vehicle_damage_setweaponhitdamagedata( "hover_jet_proj_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "loitering_munition_proj_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "emp_drone_non_player_mp", 3 );
    vehicle_damage_setweaponhitdamagedata( "emp_drone_non_player_direct_mp", 5 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x49d9
// Size: 0x4a
function vehicle_damage_initmoddamage()
{
    vehicle_damage_setperkmoddamage( "specialty_armorpiercing", 0.25, 0 );
    vehicle_damage_setperkmoddamage( "specialty_armorpiercingks", 0.75, 0 );
    vehicle_damage_setperkmoddamage( "specialty_incendiary", 0.55, 0 );
    vehicle_damage_setperkmoddamage( "specialty_explosivebullet", 0.75, 0 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x4a2b
// Size: 0x37
function vehicle_damage_getleveldata()
{
    assertex( isdefined( level.vehicle.damage ), "<dev string:x2a1>" );
    return level.vehicle.damage;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x4a6b
// Size: 0xf4, Type: bool
function vehicle_damage_isselfdamage( vehicle, data )
{
    if ( isdefined( data.inflictor ) )
    {
        if ( data.inflictor == vehicle )
        {
            return true;
        }
        
        turrets = vehicle_getturrets( vehicle );
        
        foreach ( turret in turrets )
        {
            if ( data.inflictor == turret )
            {
                return true;
            }
        }
        
        if ( data.inflictor.classname == "rocket" && isdefined( data.inflictor.vehicle ) && data.inflictor.vehicle == vehicle )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x4b68
// Size: 0x19
function vehicle_damage_enableownerdamage( vehicle )
{
    vehicle.ownerdamageenabled = 1;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x4b89
// Size: 0x17, Type: bool
function vehicle_damage_isownerdamageenabled( vehicle )
{
    return istrue( vehicle.ownerdamageenabled );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x4ba9
// Size: 0x11c
function vehicle_damage_logevent( vehicle, data )
{
    if ( !isdefined( vehicle.damageevents ) )
    {
        vehicle.damageevents = [];
    }
    
    vehicle.damageevents[ vehicle.damageevents.size ] = data;
    
    if ( isdefined( data.attacker ) && isdefined( data.attacker.overridefieldupgrade1 ) && isdefined( data.attacker.super ) && data.attacker.overridefieldupgrade1 == "super_suppression_rounds" )
    {
        if ( isdefined( data.attacker.super.vehiclehitcount ) )
        {
            data.attacker.super.vehiclehitcount++;
        }
        else
        {
            data.attacker.super.vehiclehitcount = 1;
        }
    }
    
    thread vehicle_damage_cleareventlogatframeend( vehicle );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x4ccd
// Size: 0x1e
function vehicle_damage_cleareventlog( vehicle )
{
    vehicle notify( "vehicle_damage_clearEventLog" );
    vehicle.damageevents = undefined;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x4cf3
// Size: 0x32
function vehicle_damage_cleareventlogatframeend( vehicle )
{
    vehicle endon( "death" );
    vehicle endon( "vehicle_damage_clearEventLog" );
    vehicle notify( "vehicle_damage_clearEventLogAtFrameEnd" );
    vehicle endon( "vehicle_damage_clearEventLogAtFrameEnd" );
    waittillframeend();
    thread vehicle_damage_cleareventlog( vehicle );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x4d2d
// Size: 0x150
function vehicle_damage_referevent( vehicle, turret, data )
{
    if ( !isdefined( data.meansofdeath ) )
    {
        return 0;
    }
    
    if ( !isexplosivedamagemod( data.meansofdeath ) )
    {
        return 0;
    }
    
    if ( !isdefined( data.eventid ) )
    {
        return 0;
    }
    
    if ( isdefined( vehicle.damageevents ) )
    {
        foreach ( _data in vehicle.damageevents )
        {
            if ( _data.eventid == data.eventid )
            {
                return 0;
            }
        }
    }
    
    if ( !isdefined( data.inflictor ) )
    {
        data.inflictor = undefined;
    }
    
    vehicle endon( "death" );
    vehicle endon( "vehicle_damage_clearEventLog" );
    vehicle dodamage( data.damage, data.point, data.attacker, data.inflictor, data.meansofdeath, data.objweapon, data.hitlocation );
    vehicle_damage_logevent( vehicle, data );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x4e85
// Size: 0x110
function vehicle_damage_keepturretalive( vehicle )
{
    self endon( "death" );
    self endon( "vehicle_damage_keepTurretAliveEnd" );
    self setcandamage( 1 );
    self.health = 2147483647;
    self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, eventid );
    data = packdamagedata( attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags, eventid );
    vehicle_damage_referevent( vehicle, self, data );
    self.health = 2147483647;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x4f9d
// Size: 0x1b
function vehicle_damage_keepturretaliveend( turret )
{
    self notify( "vehicle_damage_keepTurretAliveEnd" );
    self setcandamage( 0 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x4fc0
// Size: 0xe2
function vehicle_damage_visualwatchspeedchange( stateref, data )
{
    self notify( "vehicle_damage_visualStopWatchingSpeedChange" );
    self endon( "vehicle_damage_visualStopWatchingSpeedChange" );
    oldspeedstate = undefined;
    
    while ( isdefined( self ) )
    {
        speedstate = undefined;
        speed = int( self vehicle_getspeed() );
        canfly = istrue( scripts\cp_mp\vehicles\vehicle::vehiclecanfly() );
        
        if ( canfly && self vehicle_isonground() )
        {
            speedstate = 0;
        }
        else if ( !canfly && speed <= 3 )
        {
            speedstate = 0;
        }
        else if ( speed <= 25 )
        {
            speedstate = 1;
        }
        else
        {
            speedstate = 2;
        }
        
        if ( isdefined( oldspeedstate ) && speedstate != oldspeedstate )
        {
            leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate( function_d93ec4635290febd(), stateref );
            self thread [[ leveldatafordamagestate.onentercallback ]]( stateref, data );
            return;
        }
        
        oldspeedstate = speedstate;
        wait 0.1;
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x50aa
// Size: 0xa
function vehicle_damage_visualstopwatchingspeedchange()
{
    self notify( "vehicle_damage_visualStopWatchingSpeedChange" );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x50bc
// Size: 0xc0
function vehicle_damage_lightvisualcallback( data, changed )
{
    speed = int( self vehicle_getspeed() );
    canfly = istrue( scripts\cp_mp\vehicles\vehicle::vehiclecanfly() );
    
    if ( canfly && self vehicle_isonground() )
    {
        self setscriptablepartstate( "damageLight", "stopped", 1 );
    }
    else if ( !canfly && speed <= 3 )
    {
        self setscriptablepartstate( "damageLight", "stopped", 1 );
    }
    else if ( speed <= 25 )
    {
        self setscriptablepartstate( "damageLight", "lowSpeed", 1 );
    }
    else
    {
        self setscriptablepartstate( "damageLight", "highSpeed", 1 );
    }
    
    thread vehicle_damage_visualwatchspeedchange( "light", data );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x5184
// Size: 0x181
function vehicle_damage_lightvisualclearcallback( data, changed, fromdeath )
{
    vehicle_damage_visualstopwatchingspeedchange();
    
    if ( !self isscriptable() )
    {
        if ( isdefined( self.vehiclename ) )
        {
            ref = self.vehiclename;
        }
        else
        {
            ref = "undefined";
        }
        
        if ( isdefined( self.vehicletype ) )
        {
            type = self.vehicletype;
        }
        else
        {
            type = "undefined";
        }
        
        forcesre = "Vehicle is not a scriptable: ref: " + ref + " type: " + type == undefined;
        return;
    }
    
    if ( !self getscriptablehaspart( "damageLight" ) )
    {
        if ( isdefined( self.vehiclename ) )
        {
            ref = self.vehiclename;
        }
        else
        {
            ref = "undefined";
        }
        
        if ( isdefined( self.vehicletype ) )
        {
            type = self.vehicletype;
        }
        else
        {
            type = "undefined";
        }
        
        forcesre = "Vehicle does not have damageLight part: ref: " + ref + " type: " + type == undefined;
        return;
    }
    
    if ( !self getscriptableparthasstate( "damageLight", "off" ) )
    {
        if ( isdefined( self.vehiclename ) )
        {
            ref = self.vehiclename;
        }
        else
        {
            ref = "undefined";
        }
        
        if ( isdefined( self.vehicletype ) )
        {
            type = self.vehicletype;
        }
        else
        {
            type = "undefined";
        }
        
        forcesre = "Vehicle does not have part damageLight with state off: ref: " + ref + " type: " + type == undefined;
        return;
    }
    
    self setscriptablepartstate( "damageLight", "off", 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x530d
// Size: 0xc0
function vehicle_damage_mediumvisualcallback( data, changed )
{
    speed = int( self vehicle_getspeed() );
    canfly = istrue( scripts\cp_mp\vehicles\vehicle::vehiclecanfly() );
    
    if ( canfly && self vehicle_isonground() )
    {
        self setscriptablepartstate( "damageMedium", "stopped", 1 );
    }
    else if ( !canfly && speed <= 3 )
    {
        self setscriptablepartstate( "damageMedium", "stopped", 1 );
    }
    else if ( speed <= 25 )
    {
        self setscriptablepartstate( "damageMedium", "lowSpeed", 1 );
    }
    else
    {
        self setscriptablepartstate( "damageMedium", "highSpeed", 1 );
    }
    
    thread vehicle_damage_visualwatchspeedchange( "medium", data );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x53d5
// Size: 0x35
function vehicle_damage_mediumvisualclearcallback( data, changed, fromdeath )
{
    vehicle_damage_visualstopwatchingspeedchange();
    self setscriptablepartstate( "damageMedium", "off", 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x5412
// Size: 0xc0
function vehicle_damage_heavyvisualcallback( data, changed )
{
    speed = int( self vehicle_getspeed() );
    canfly = istrue( scripts\cp_mp\vehicles\vehicle::vehiclecanfly() );
    
    if ( canfly && self vehicle_isonground() )
    {
        self setscriptablepartstate( "damageHeavy", "stopped", 1 );
    }
    else if ( !canfly && speed <= 3 )
    {
        self setscriptablepartstate( "damageHeavy", "stopped", 1 );
    }
    else if ( speed <= 25 )
    {
        self setscriptablepartstate( "damageHeavy", "lowSpeed", 1 );
    }
    else
    {
        self setscriptablepartstate( "damageHeavy", "highSpeed", 1 );
    }
    
    thread vehicle_damage_visualwatchspeedchange( "heavy", data );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x54da
// Size: 0x35
function vehicle_damage_heavyvisualclearcallback( data, changed, fromdeath )
{
    vehicle_damage_visualstopwatchingspeedchange();
    self setscriptablepartstate( "damageHeavy", "off", 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x5517
// Size: 0x37
function vehicle_damage_enginevisualcallback( data, changed )
{
    self setscriptablepartstate( "damageEngine", "explode", 1 );
    
    if ( !istrue( scripts\cp_mp\vehicles\vehicle::vehiclecanfly() ) )
    {
        scripts\cp_mp\vehicles\vehicle_occupancy::function_d0092c44c5588870();
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x5556
// Size: 0x2e
function vehicle_damage_enginevisualclearcallback( data, changed, fromdeath )
{
    self setscriptablepartstate( "damageEngine", "off", 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x558c
// Size: 0x1e
function vehicle_damage_getstate()
{
    if ( !isdefined( self.damagestateref ) )
    {
        return "pristine";
    }
    
    return self.damagestateref;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x55b3
// Size: 0xc9
function vehicle_damage_setstate( stateref, oldstateref, data )
{
    assert( isdefined( stateref ) && isdefined( oldstateref ) && stateref != oldstateref );
    self notify( "damage_state_change" );
    ref = function_d93ec4635290febd();
    
    if ( oldstateref != "pristine" )
    {
        var_1f1b237868b2b611 = vehicle_damage_getleveldatafordamagestate( ref, oldstateref );
        
        if ( isdefined( var_1f1b237868b2b611.onexitcallback ) )
        {
            self thread [[ var_1f1b237868b2b611.onexitcallback ]]( stateref, data );
        }
    }
    
    if ( stateref != "pristine" )
    {
        var_1f1b237868b2b611 = vehicle_damage_getleveldatafordamagestate( ref, stateref );
        
        if ( isdefined( var_1f1b237868b2b611.onentercallback ) )
        {
            self thread [[ var_1f1b237868b2b611.onentercallback ]]( oldstateref, data );
        }
    }
    
    self.damagestateref = stateref;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x5684
// Size: 0x53
function vehicle_damage_updatestate( data, var_fa10797979c24226, var_6ecb77fd1f27c667 )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( function_d93ec4635290febd(), undefined, var_6ecb77fd1f27c667 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    self.lasttimedamaged = gettime();
    function_e1d544cb065687f0( data, var_fa10797979c24226, var_6ecb77fd1f27c667 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x56df
// Size: 0x252
function function_e1d544cb065687f0( data, var_fa10797979c24226, var_6ecb77fd1f27c667 )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( function_d93ec4635290febd(), undefined, var_6ecb77fd1f27c667 );
    vehiclehealth = self.health;
    
    if ( isdefined( data ) && isdefined( data.damage ) )
    {
        vehiclehealth -= int( data.damage );
    }
    
    beststateref = "pristine";
    var_47073cf5d0921b2c = undefined;
    var_ad8ec7e8a1d06338 = undefined;
    
    foreach ( stateref, statedata in leveldataforvehicle.damagestatedata )
    {
        assertex( istrue( var_6ecb77fd1f27c667 ) || stateref != "<dev string:x2e7>", "<dev string:x2f3>" + "<dev string:x2e7>" + "<dev string:x321>" );
        assertex( istrue( var_6ecb77fd1f27c667 ) || isdefined( statedata.maxhealth ), "<dev string:x326>" + stateref + "<dev string:x33e>" );
        
        if ( ( !isdefined( var_ad8ec7e8a1d06338 ) || statedata.maxhealth < var_ad8ec7e8a1d06338 ) && vehiclehealth <= statedata.maxhealth && ( !isvehiclehusk() || stateref != "light" && stateref != "medium" ) )
        {
            beststateref = stateref;
            var_47073cf5d0921b2c = statedata;
            var_ad8ec7e8a1d06338 = statedata.maxhealth;
        }
    }
    
    oldstateref = vehicle_damage_getstate();
    
    if ( beststateref != oldstateref )
    {
        if ( !istrue( var_fa10797979c24226 ) )
        {
            if ( beststateref == "heavy" && ( !isdefined( oldstateref ) || oldstateref != "heavy" ) )
            {
                if ( !istrue( self.disableheavystatedamagefloor ) )
                {
                    heavystatemaxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getheavystatemaxhealth( undefined, function_d93ec4635290febd() );
                    
                    if ( isdefined( heavystatemaxhealth ) )
                    {
                        if ( isdefined( data ) && isdefined( data.damage ) && data.damage != 0 )
                        {
                            self.health = int( max( self.health, heavystatemaxhealth + data.damage ) );
                        }
                    }
                }
            }
        }
        
        vehicle_damage_setstate( beststateref, oldstateref, data );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x5939
// Size: 0x27
function vehicle_damage_disablestatedamagefloor( bool )
{
    if ( bool )
    {
        self.disableheavystatedamagefloor = 1;
        return;
    }
    
    self.disableheavystatedamagefloor = undefined;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x5968
// Size: 0x1d
function vehicle_damage_onenterstatelight( oldstateref, data )
{
    vehicle_damage_lightvisualcallback( data, 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x598d
// Size: 0x1d
function vehicle_damage_onexitstatelight( newstateref, data )
{
    vehicle_damage_lightvisualclearcallback( data, 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x59b2
// Size: 0x1d
function vehicle_damage_onenterstatemedium( oldstateref, data )
{
    vehicle_damage_mediumvisualcallback( data, 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x59d7
// Size: 0x1d
function vehicle_damage_onexitstatemedium( newstateref, data )
{
    vehicle_damage_mediumvisualclearcallback( data, 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x59fc
// Size: 0x7a
function vehicle_damage_onenterstateheavy( oldstateref, data )
{
    if ( scripts\cp_mp\vehicles\vehicle::isvehiclehusk() )
    {
        function_d06474f0bc53709d( data );
    }
    else
    {
        vehicle_damage_heavyvisualcallback( data, 1 );
        vehicle_damage_enginevisualcallback( data, 1 );
    }
    
    if ( !isdefined( oldstateref ) || oldstateref != "heavy" )
    {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 0 );
        
        if ( function_734926fcdbad1fd4() )
        {
            vehicle_damage_onenterstateheavyscore( oldstateref, data );
        }
        
        if ( !vehicle_damage_shouldskipburndown( data ) )
        {
            thread vehicle_damage_beginburndown( data );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x5a7e
// Size: 0x66
function vehicle_damage_onexitstateheavy( newstateref, data )
{
    if ( isvehiclehusk() )
    {
        function_27ec7be8325efa3c( data );
    }
    else
    {
        vehicle_damage_heavyvisualclearcallback( data, 1 );
        vehicle_damage_enginevisualclearcallback( data, 1 );
    }
    
    if ( !isdefined( newstateref ) || newstateref != "heavy" )
    {
        if ( !isvehiclehusk() )
        {
            scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 1 );
        }
        
        vehicle_damage_endburndown();
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x5aec
// Size: 0xc6
function vehicle_damage_registerdefaultstates( vehicleref )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref, 1 );
    leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate( vehicleref, "light", 1 );
    leveldatafordamagestate.onentercallback = &vehicle_damage_onenterstatelight;
    leveldatafordamagestate.onexitcallback = &vehicle_damage_onexitstatelight;
    leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate( vehicleref, "medium", 1 );
    leveldatafordamagestate.onentercallback = &vehicle_damage_onenterstatemedium;
    leveldatafordamagestate.onexitcallback = &vehicle_damage_onexitstatemedium;
    leveldatafordamagestate = vehicle_damage_getleveldatafordamagestate( vehicleref, "heavy", 1 );
    leveldatafordamagestate.onentercallback = &vehicle_damage_onenterstateheavy;
    leveldatafordamagestate.onexitcallback = &vehicle_damage_onexitstateheavy;
    vehicle_damage_updatestatemaxhealthvalues( vehicleref );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x5bba
// Size: 0x1e
function function_d06474f0bc53709d( data )
{
    self setscriptablepartstate( "damageHeavy", "on", 1 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x5be0
// Size: 0x99
function function_27ec7be8325efa3c( data )
{
    self setscriptablepartstate( "damageHeavy", "off", 1 );
    transitionscriptableparts = scripts\cp_mp\vehicles\vehicle_spawn::function_89cda5ba9bfc8d56( self.pristineref );
    
    if ( isdefined( transitionscriptableparts ) )
    {
        foreach ( struct in transitionscriptableparts )
        {
            self setscriptablepartstate( struct.var_1fb6b56a662df98, "off", 1 );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x5c81
// Size: 0xb6
function vehicle_damage_getmaxhealth( vehicle, vehicleref )
{
    if ( !isdefined( vehicleref ) )
    {
        vehicleref = vehicle function_d93ec4635290febd();
    }
    
    leveldata = vehicle_damage_getleveldata();
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref, 1 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        if ( isdefined( vehicle ) )
        {
            return vehicle.maxhealth;
        }
        
        return undefined;
    }
    
    if ( !isdefined( leveldataforvehicle.health ) )
    {
        if ( isdefined( vehicle ) )
        {
            return vehicle.maxhealth;
        }
        
        return undefined;
    }
    
    maxhealth = leveldataforvehicle.health;
    heavystatehealthadd = vehicle_damage_getheavystatehealthadd( vehicleref );
    
    if ( isdefined( heavystatehealthadd ) )
    {
        maxhealth += heavystatehealthadd;
    }
    
    return int( maxhealth );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x5d40
// Size: 0xa9
function vehicle_damage_getpristinestateminhealth( vehicle, vehicleref )
{
    if ( !isdefined( vehicleref ) )
    {
        vehicleref = vehicle function_d93ec4635290febd();
    }
    
    leveldata = vehicle_damage_getleveldata();
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref, 1 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return undefined;
    }
    
    if ( !isdefined( leveldataforvehicle.health ) )
    {
        return undefined;
    }
    
    pristinestateminhealth = leveldataforvehicle.health * 0.9;
    heavystatehealthadd = vehicle_damage_getheavystatehealthadd( vehicleref );
    
    if ( isdefined( heavystatehealthadd ) )
    {
        pristinestateminhealth += heavystatehealthadd;
    }
    
    if ( !isdefined( pristinestateminhealth ) || pristinestateminhealth <= 0 )
    {
        return undefined;
    }
    
    return int( pristinestateminhealth );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x5df2
// Size: 0x82
function vehicle_damage_getheavystatemaxhealth( vehicle, vehicleref )
{
    if ( !isdefined( vehicleref ) )
    {
        vehicleref = vehicle function_d93ec4635290febd();
    }
    
    leveldata = vehicle_damage_getleveldata();
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return undefined;
    }
    
    if ( !isdefined( leveldataforvehicle.health ) )
    {
        return undefined;
    }
    
    heavystatehealthadd = vehicle_damage_getheavystatehealthadd( vehicleref );
    
    if ( !isdefined( heavystatehealthadd ) || heavystatehealthadd <= 0 )
    {
        return undefined;
    }
    
    return int( heavystatehealthadd );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x5e7d
// Size: 0x14a
function vehicle_damage_updatestatemaxhealthvalues( vehicleref )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    assertex( isdefined( leveldataforvehicle.health ), "<dev string:x359>" );
    minhealth = undefined;
    maxhealth = undefined;
    
    foreach ( stateref, statedata in leveldataforvehicle.damagestatedata )
    {
        if ( stateref == "light" )
        {
            statedata.maxhealth = vehicle_damage_getpristinestateminhealth( undefined, vehicleref );
            maxhealth = statedata.maxhealth;
            continue;
        }
        
        if ( stateref == "heavy" )
        {
            statedata.maxhealth = vehicle_damage_getheavystatemaxhealth( undefined, vehicleref );
            minhealth = statedata.maxhealth;
        }
    }
    
    statedata = leveldataforvehicle.damagestatedata[ "medium" ];
    
    if ( isdefined( statedata ) )
    {
        if ( isdefined( minhealth ) && isdefined( maxhealth ) )
        {
            ratio = vehicle_damage_getmediumstatehealthratio( vehicleref );
            
            if ( isdefined( ratio ) )
            {
                statedata.maxhealth = int( math::lerp( minhealth, maxhealth, ratio ) );
            }
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x5fcf
// Size: 0x6a
function vehicle_damage_getheavystatehealthadd( vehicleref )
{
    leveldata = vehicle_damage_getleveldata();
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    heavystatehealthadd = leveldataforvehicle.heavystatehealthadd;
    
    if ( !isdefined( heavystatehealthadd ) )
    {
        heavystatehealthadd = leveldata.heavystatehealthadd;
    }
    
    if ( !isdefined( heavystatehealthadd ) || heavystatehealthadd <= 0 )
    {
        return undefined;
    }
    
    return int( heavystatehealthadd );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x6042
// Size: 0x6d
function vehicle_damage_getmediumstatehealthratio( vehicleref )
{
    leveldata = vehicle_damage_getleveldata();
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    mediumstatehealthratio = leveldataforvehicle.mediumstatehealthratio;
    
    if ( !isdefined( mediumstatehealthratio ) )
    {
        mediumstatehealthratio = leveldata.mediumstatehealthratio;
    }
    
    if ( !isdefined( mediumstatehealthratio ) || mediumstatehealthratio <= 0 || mediumstatehealthratio > 1 )
    {
        return undefined;
    }
    
    return mediumstatehealthratio;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x60b8
// Size: 0x1dd, Type: bool
function function_1989bd346c21b68a( data )
{
    if ( isdefined( data.inflictor ) && isdefined( data.inflictor.weapon_name ) && data.inflictor.weapon_name == "gl" )
    {
        return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_GRENADE" );
    }
    
    if ( isdefined( data.objweapon ) && isdefined( data.objweapon.basename ) )
    {
        switch ( data.objweapon.basename )
        {
            case #"hash_708fb6e22f87a3a4":
            case #"hash_a622e958420b92a0":
                return ( isdefined( data.meansofdeath ) && ( data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_RIFLE_BULLET" ) );
            case #"hash_13a265ac820ea0df":
            case #"hash_1717a0115ff7a1c4":
            case #"hash_3e782fd775b72022":
            case #"hash_5c272c0617caebf0":
            case #"hash_8c12df11df01f306":
            case #"hash_a86d4075406d2de4":
            case #"hash_fd9c279f85990dad":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_PROJECTILE" );
            case #"hash_c500a77b6bb7c5d0":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_GRENADE" );
            case #"hash_56ee829cc162271a":
                return ( isdefined( data.meansofdeath ) && data.meansofdeath == "MOD_EXPLOSIVE" );
        }
    }
    
    return false;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x629e
// Size: 0x24b
function function_6e87d9e8601d9029( vehicle, tagname, damagedata )
{
    if ( !isdefined( vehicle.damageableparts ) )
    {
        return 0;
    }
    
    if ( !isdefined( tagname ) )
    {
        return 0;
    }
    
    if ( !isdefined( vehicle.damageableparts[ tagname ] ) )
    {
        return 0;
    }
    
    if ( function_853c0063f08b55e1( vehicle.damageableparts[ tagname ] ) )
    {
        return 0;
    }
    
    if ( isdefined( damagedata ) && isdefined( damagedata.objweapon ) && ( istrue( callsharedfunc( "weapons", "isThrowingKnife", damagedata.objweapon ) ) || istrue( callsharedfunc( "weapons", "isThrowStar", damagedata.objweapon ) ) ) )
    {
        damageablepartdata = function_2265b277a0dad0f1( vehicle function_d93ec4635290febd() );
        
        if ( !isdefined( damageablepartdata[ tagname ].wheelref ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( damagedata ) && isdefined( damagedata.objweapon ) && isdefined( damagedata.meansofdeath ) && damagedata.meansofdeath == "MOD_MELEE" )
    {
        damageablepartdata = function_2265b277a0dad0f1( vehicle function_d93ec4635290febd() );
        issharp = scripts\cp_mp\utility\weapon_utility::isSharpMeleeWeapon( damagedata.objweapon );
        iswindow = isdefined( damageablepartdata[ tagname ].windowref );
        istire = isdefined( damageablepartdata[ tagname ].wheelref );
        
        if ( issharp && !iswindow && !istire )
        {
            return 0;
        }
        else if ( !issharp && !iswindow )
        {
            return 0;
        }
    }
    
    if ( isdefined( damagedata ) && isdefined( damagedata.objweapon ) && iscrossbowdamage( damagedata.objweapon ) )
    {
        if ( function_6065fce6cdcad( damagedata.objweapon ) || function_d49206e61ac4f6de( damagedata.objweapon ) )
        {
            return 0;
        }
        
        return function_ee1ff9eed64d1e5d( vehicle, tagname );
    }
    
    state = vehicle getscriptablepartstate( tagname, 1 );
    
    if ( isdefined( state ) && state == "start_hidden" )
    {
        return 0;
    }
    
    damagefilterfunc = function_14cc373f72a021a8( vehicle function_d93ec4635290febd(), tagname );
    
    if ( isdefined( damagefilterfunc ) )
    {
        return [[ damagefilterfunc ]]( damagedata );
    }
    
    return 1;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x64f2
// Size: 0xac, Type: bool
function function_452936099dcd1b94( seatid )
{
    data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( function_d93ec4635290febd() );
    return isdefined( data.seatdata[ seatid ] ) && isdefined( data.seatdata[ seatid ].doorwindowref ) && isdefined( self.damageableparts ) && isdefined( self.damageableparts[ data.seatdata[ seatid ].doorwindowref ] ) && !function_853c0063f08b55e1( self.damageableparts[ data.seatdata[ seatid ].doorwindowref ] );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x65a7
// Size: 0x9c
function function_14219d4c7d83499f( seatid )
{
    data = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( function_d93ec4635290febd() );
    
    if ( isdefined( data.seatdata[ seatid ] ) && isdefined( data.seatdata[ seatid ].doorwindowref ) )
    {
        self.damageableparts[ data.seatdata[ seatid ].doorwindowref ].healthvalue = 0;
        function_77db32aa48a42a76( self, data.seatdata[ seatid ].doorwindowref );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x664b
// Size: 0x46
function function_e6ec777562579771( vehicle, seatid )
{
    self endon( "death_or_disconnect" );
    self endon( "vehicle_seat_exit" );
    waittill_any_2( "vehicle_leanout_begin", "roof_exit" );
    
    if ( vehicle function_452936099dcd1b94( seatid ) )
    {
        vehicle function_14219d4c7d83499f( seatid );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x6699
// Size: 0x68
function function_14cc373f72a021a8( vehicleref, tagname )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    damagefilter = leveldataforvehicle.damageableparts[ tagname ].damagefilter;
    
    if ( isdefined( damagefilter ) )
    {
        switch ( damagefilter )
        {
            case #"hash_519952040ad478cb":
                return &function_43c057baaca777a5;
        }
    }
    
    return undefined;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x670a
// Size: 0x29
function function_2265b277a0dad0f1( vehicleref )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    return leveldataforvehicle.damageableparts;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x673c
// Size: 0x3d
function function_f7df41d3ad15dca8( vehicleref, tagname )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    return leveldataforvehicle.damageableparts[ tagname ].scriptablepartname;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x6782
// Size: 0x3d
function function_bad6c0e32ff1e092( vehicleref, tagname )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    return leveldataforvehicle.damageableparts[ tagname ].var_b4fccc158c681073;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x67c8
// Size: 0x3d
function function_dde06c2157ec8895( vehicleref, tagname )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    return leveldataforvehicle.damageableparts[ tagname ].var_1c60586652067d4c;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x680e
// Size: 0x45
function function_8a0e1b95abc01e56( vehicleref, tagname )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    return default_to( leveldataforvehicle.damageableparts[ tagname ].var_f0b290e6673ef286, 30 );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x685c
// Size: 0x3e, Type: bool
function function_3df56ded0597eb6e( vehicleref, tagname )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    return istrue( leveldataforvehicle.damageableparts[ tagname ].var_9983055e997835be );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x68a3
// Size: 0x50
function function_c9f618f05861c2c5( vehicleref, tagname )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    reduction = leveldataforvehicle.damageableparts[ tagname ].damagereduction;
    
    if ( !isdefined( reduction ) )
    {
        reduction = 0;
    }
    
    return reduction;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x68fc
// Size: 0xbc, Type: bool
function function_ee1ff9eed64d1e5d( vehicle, tagname, var_e691c80ba12c3da1 )
{
    if ( !isdefined( var_e691c80ba12c3da1 ) )
    {
        var_e691c80ba12c3da1 = 1;
    }
    
    if ( !isdefined( tagname ) )
    {
        return false;
    }
    
    if ( !isdefined( vehicle.damageableparts ) )
    {
        return false;
    }
    
    if ( !isdefined( vehicle.damageableparts[ tagname ] ) )
    {
        return false;
    }
    
    damageablepartdata = function_2265b277a0dad0f1( vehicle function_d93ec4635290febd() );
    iswindow = isdefined( damageablepartdata[ tagname ].windowref );
    istire = isdefined( damageablepartdata[ tagname ].wheelref );
    
    if ( istire )
    {
        return true;
    }
    
    if ( var_e691c80ba12c3da1 )
    {
        if ( iswindow )
        {
            return true;
        }
        
        if ( issubstr( tagname, "tag_light" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x69c1
// Size: 0xb0
function function_82cad97b4499e421( vehicle, tagname, reactivearmorexplosion )
{
    data = function_29b4292c92443328( vehicle function_d93ec4635290febd() );
    damageablepartdata = data.damage.damageableparts[ tagname ];
    
    if ( istrue( reactivearmorexplosion ) )
    {
        return "reactive_armor_explosion";
    }
    
    if ( !vehicle isvehiclehusk() && isdefined( damageablepartdata.wheelref ) && damageablepartdata.wheelref != "not_a_wheel" && istrue( level.var_ec75ca2494d74dab ) )
    {
        return "death_usable";
    }
    
    return "death";
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x6a79
// Size: 0x1a3
function function_9c23735bf7534afa( vehicle, damage, point, radius )
{
    if ( !isdefined( vehicle ) || !isdefined( vehicle.damageableparts ) || vehicle.damageableparts.size == 0 )
    {
        return;
    }
    
    ref = vehicle function_d93ec4635290febd();
    expdamageradiussq = function_90b374d856d14373( ref );
    damageablepartdata = function_2265b277a0dad0f1( ref );
    radiussquared = radius * radius;
    var_1763b6cd86ff52f2 = undefined;
    var_6aaeea4a5b05a723 = undefined;
    var_21528cf722158315 = undefined;
    
    foreach ( tagname, healthdata in vehicle.damageableparts )
    {
        if ( vehicle tagexists( tagname ) && istrue( damageablepartdata[ tagname ].var_30beabb585e60744 ) )
        {
            var_c88d34bee5a69c56 = distancesquared( point, vehicle gettagorigin( tagname ) );
            
            if ( var_c88d34bee5a69c56 <= radiussquared && function_6e87d9e8601d9029( vehicle, tagname ) && ( !isdefined( var_1763b6cd86ff52f2 ) || var_c88d34bee5a69c56 < var_1763b6cd86ff52f2 ) )
            {
                var_1763b6cd86ff52f2 = var_c88d34bee5a69c56;
                var_6aaeea4a5b05a723 = tagname;
                var_21528cf722158315 = healthdata;
            }
        }
    }
    
    if ( isdefined( var_6aaeea4a5b05a723 ) && isdefined( var_21528cf722158315 ) )
    {
        var_21528cf722158315.healthvalue = max( 0, var_21528cf722158315.healthvalue - damage );
        
        if ( function_853c0063f08b55e1( var_21528cf722158315 ) )
        {
            function_77db32aa48a42a76( vehicle, var_6aaeea4a5b05a723 );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x6c24
// Size: 0x224
function function_ecdf1217e332c7d7( vehicle, damage, point, wheelstodamage )
{
    if ( !isdefined( vehicle ) || !isdefined( vehicle.damageableparts ) || vehicle.damageableparts.size == 0 || wheelstodamage == 0 )
    {
        return;
    }
    
    ref = vehicle function_d93ec4635290febd();
    damageablepartdata = function_2265b277a0dad0f1( ref );
    wheels = [];
    
    foreach ( tagname, healthdata in vehicle.damageableparts )
    {
        if ( !vehicle tagexists( tagname ) || !isdefined( damageablepartdata[ tagname ].wheelref ) || !isdefined( vehicle.damageableparts[ tagname ] ) || function_853c0063f08b55e1( vehicle.damageableparts[ tagname ] ) )
        {
            continue;
        }
        
        wheeldata = spawnstruct();
        wheeldata.origin = vehicle gettagorigin( tagname );
        wheeldata.tag = tagname;
        wheeldata.data = healthdata;
        wheels[ wheels.size ] = wheeldata;
    }
    
    if ( wheels.size == 0 )
    {
        return;
    }
    
    foreach ( wheel in sortbydistance( wheels, point ) )
    {
        wheel.data.healthvalue = max( 0, wheel.data.healthvalue - damage );
        
        if ( function_853c0063f08b55e1( wheel.data ) )
        {
            function_77db32aa48a42a76( vehicle, wheel.tag );
        }
        
        wheelstodamage -= 1;
        
        if ( wheelstodamage <= 0 )
        {
            return;
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x6e50
// Size: 0x326
function function_786c7ec25aad5005( vehicle, damagedata )
{
    tagnames = [];
    tagdistances = [];
    
    if ( isdefined( damagedata.partname ) && isstring( damagedata.partname ) && damagedata.partname != "" && vehicle tagexists( damagedata.partname ) )
    {
        tagnames[ damagedata.partname ] = damagedata.partname;
    }
    
    if ( isdefined( damagedata.attachtagname ) && isstring( damagedata.attachtagname ) && damagedata.attachtagname != "" && vehicle tagexists( damagedata.attachtagname ) )
    {
        tagnames[ damagedata.attachtagname ] = damagedata.attachtagname;
    }
    
    foreach ( tag in tagnames )
    {
        tagdistances[ tag ] = distancesquared( damagedata.point, vehicle gettagorigin( tag ) );
    }
    
    if ( isdefined( vehicle.damageableparts ) && vehicle.damageableparts.size > 0 && isexplosivedamagemod( damagedata.meansofdeath ) )
    {
        data = vehicle_damage_getleveldataforvehicle( vehicle function_d93ec4635290febd() );
        expdamageradiussq = data.expdamageradiussq;
        var_2f51e76299064178 = data.var_3259f2f4faf8eaa8;
        
        foreach ( tagname, healthvalue in vehicle.damageableparts )
        {
            if ( vehicle tagexists( tagname ) && !function_853c0063f08b55e1( healthvalue ) && !isdefined( tagnames[ tagname ] ) )
            {
                distancesq = distancesquared( damagedata.point, vehicle gettagorigin( tagname ) );
                
                if ( distancesq <= expdamageradiussq )
                {
                    tagnames[ tagname ] = tagname;
                    tagdistances[ tagname ] = distancesq;
                }
            }
        }
        
        if ( isdefined( var_2f51e76299064178 ) && tagdistances.size > var_2f51e76299064178 )
        {
            closesttagnames = [];
            
            for ( i = 0; i < var_2f51e76299064178 ; i++ )
            {
                closest = undefined;
                closestdistance = undefined;
                
                foreach ( tagname, tagdistance in tagdistances )
                {
                    if ( !isdefined( closestdistance ) || tagdistance < closestdistance )
                    {
                        closestdistance = tagdistance;
                        closest = tagname;
                    }
                }
                
                if ( isdefined( closest ) )
                {
                    closesttagnames[ i ] = closest;
                    tagdistances[ closest ] = undefined;
                    continue;
                }
                
                return closesttagnames;
            }
            
            return closesttagnames;
        }
    }
    
    return tagnames;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x717f
// Size: 0xda
function function_7a5070220fc8ce9e( vehicleref, damageableparts )
{
    huskdamageableparts = function_32b9b5d07bb56c31( vehicleref );
    var_dfdbcc779477d31c = [];
    
    foreach ( tag, part in huskdamageableparts )
    {
        if ( istrue( part.inactive ) )
        {
            continue;
        }
        
        if ( isdefined( damageableparts[ tag ] ) )
        {
            var_dfdbcc779477d31c[ tag ] = damageableparts[ tag ];
            continue;
        }
        
        var_1c09c3e40955f379 = spawnstruct();
        var_1c09c3e40955f379.healthvalue = part.healthvalue;
        var_1c09c3e40955f379.explosivedamagehealthvalue = part.explosivedamagehealthvalue;
        var_dfdbcc779477d31c[ tag ] = var_1c09c3e40955f379;
    }
    
    return var_dfdbcc779477d31c;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x7262
// Size: 0xa6
function function_cf63db12f07abf78( vehicleref, damageableparts )
{
    if ( !isdefined( damageableparts ) )
    {
        return;
    }
    
    foreach ( tagname, var_1c09c3e40955f379 in damageableparts )
    {
        if ( function_600ff5df9dbf294( vehicleref, tagname, var_1c09c3e40955f379 ) )
        {
            var_1c09c3e40955f379.healthvalue = 0;
            function_66ac97eba6b35b4a( self, tagname, undefined );
            continue;
        }
        
        if ( function_e531ad775dcbca22( vehicleref, tagname, var_1c09c3e40955f379 ) )
        {
            var_1c09c3e40955f379.healthvalue = 0;
            function_77db32aa48a42a76( self, tagname, undefined );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x7310
// Size: 0x38, Type: bool
function function_e531ad775dcbca22( vehicleref, parttag, healthvalues )
{
    destructionchance = function_8a0e1b95abc01e56( vehicleref, parttag );
    return randomint( 100 ) < destructionchance;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x7351
// Size: 0x2e, Type: bool
function function_600ff5df9dbf294( vehicleref, parttag, healthvalues )
{
    return function_3df56ded0597eb6e( vehicleref, parttag ) || function_853c0063f08b55e1( healthvalues );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x7388
// Size: 0x29, Type: bool
function function_853c0063f08b55e1( var_1c09c3e40955f379 )
{
    return var_1c09c3e40955f379.healthvalue == 0 || var_1c09c3e40955f379.explosivedamagehealthvalue == 0;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x73ba
// Size: 0x29
function function_90b374d856d14373( vehicleref )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    return leveldataforvehicle.expdamageradiussq;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x73ec
// Size: 0x1b
function function_43c057baaca777a5( damagedata )
{
    return isexplosivedamagemod( damagedata.meansofdeath );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x7410
// Size: 0x19a
function vehicle_damage_beginburndown( data )
{
    self endon( "death" );
    self endon( "end_burn_down" );
    ref = function_d93ec4635290febd();
    
    if ( !istrue( self.burningdown ) )
    {
        leveldataforvehicle = vehicle_getleveldataforvehicle( ref );
        burndowntime = vehicle_damage_getburndowntime( ref );
        
        if ( isdefined( burndowntime ) )
        {
            self.burningdown = 1;
            
            if ( isdefined( data ) )
            {
                if ( isdefined( data.attacker ) )
                {
                    self.burndownattacker = data.attacker;
                }
                else
                {
                    self.burndownattacker = undefined;
                }
                
                if ( isdefined( data.objweapon ) )
                {
                    self.burndownweapon = data.objweapon;
                }
                else
                {
                    self.burndownweapon = undefined;
                }
                
                /#
                    if ( isdefined( data.attacker ) )
                    {
                        assertex( isdefined( data.objweapon ), "<dev string:x3c5>" );
                        assertex( isdefined( data.objweapon ) && isdefined( data.objweapon.basename ), "<dev string:x420>" );
                    }
                #/
            }
            
            occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
            
            if ( isdefined( occupants ) )
            {
                scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "burningDown", occupants, ref );
            }
            
            if ( issharedfuncdefined( ref, "beginBurnDown" ) )
            {
                [[ getsharedfunc( ref, "beginBurnDown" ) ]]();
            }
            
            childthread function_43536e2e28cc20c0( data, burndowntime );
            wait burndowntime;
            self.burningdown = undefined;
            scripts\cp_mp\pet_watch::checkcarpuncherprogressgeneric();
            thread vehicle_explode( data, 0 );
            return;
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x75b2
// Size: 0xbc
function function_43536e2e28cc20c0( data, burndowntime )
{
    remaininghealth = self.health;
    
    if ( isdefined( data ) && isdefined( data.damage ) )
    {
        remaininghealth = self.health - data.damage;
    }
    
    var_ec2b154791158e97 = int( ceil( burndowntime / 1 ) );
    var_76e563db5d11a0ea = int( ceil( remaininghealth / var_ec2b154791158e97 / 0.25 ) );
    
    for ( i = 0; i < var_ec2b154791158e97 ; i++ )
    {
        wait 1;
        self dodamage( var_76e563db5d11a0ea, self.origin );
        function_9542eac6997b9060( self );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x7676
// Size: 0x63
function vehicle_damage_endburndown( fromdeath )
{
    if ( !istrue( self.burningdown ) )
    {
        return;
    }
    
    self notify( "end_burn_down" );
    scripts\cp_mp\pet_watch::checkcarpuncherprogressgeneric();
    
    if ( !istrue( fromdeath ) )
    {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self, 0 );
        
        if ( isdefined( occupants ) )
        {
            scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "burningDown", occupants, function_d93ec4635290febd() );
        }
    }
    
    self.burningdown = undefined;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x76e1
// Size: 0xc, Type: bool
function vehicle_damage_isburningdown()
{
    return istrue( self.burningdown );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x76f6
// Size: 0x7c
function vehicle_damage_getburndowntime( vehicleref )
{
    if ( isdefined( self.burndowntime ) )
    {
        return self.burndowntime;
    }
    
    leveldata = vehicle_damage_getleveldata();
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref );
    burndowntime = leveldataforvehicle.burndowntime;
    
    if ( !isdefined( burndowntime ) )
    {
        burndowntime = leveldata.burndowntime;
    }
    
    if ( !isdefined( burndowntime ) || burndowntime <= 0 )
    {
        return undefined;
    }
    
    return burndowntime;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x777b
// Size: 0x1e1
function vehicle_damage_shouldskipburndown( data )
{
    vehiclename = function_d93ec4635290febd();
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehiclename, undefined, 1 );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        if ( !isvehiclehusk() && istrue( leveldataforvehicle.skipburndown ) )
        {
            return 1;
        }
    }
    
    if ( !isdefined( data ) )
    {
        return 0;
    }
    
    if ( isdefined( data.meansofdeath ) )
    {
        if ( !isexplosivedamagemod( data.meansofdeath ) && data.meansofdeath != "MOD_FIRE" )
        {
            return 0;
        }
        
        if ( data.meansofdeath == "MOD_CRUSH" )
        {
            return 1;
        }
    }
    
    if ( isdefined( data.objweapon ) && !isnullweapon( data.objweapon ) && isdefined( function_d93ec4635290febd() ) )
    {
        shouldskipburndown = undefined;
        weaponname = data.objweapon.basename;
        leveldata = vehicle_damage_getleveldata();
        table = leveldata.table;
        
        if ( isdefined( leveldata.table.skipburndownforvehicle[ vehiclename ] ) )
        {
            shouldskipburndown = leveldata.table.skipburndownforvehicle[ vehiclename ][ weaponname ];
        }
        
        if ( isdefined( shouldskipburndown ) )
        {
            return shouldskipburndown;
        }
        
        if ( isdefined( leveldataforvehicle ) )
        {
            classname = leveldataforvehicle.class;
            
            if ( !isdefined( classname ) || classname == "none" )
            {
                return 1;
            }
            
            if ( isdefined( leveldata.table.skipburndownforclass[ classname ] ) )
            {
                shouldskipburndown = leveldata.table.skipburndownforclass[ classname ][ weaponname ];
            }
            
            if ( isdefined( shouldskipburndown ) )
            {
                return shouldskipburndown;
            }
        }
        else
        {
            return 1;
        }
    }
    else
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x7965
// Size: 0x1c
function function_7aaa7ae503292f43( vehicleref )
{
    return vehicle_getleveldataforvehicle( vehicleref ).weapon;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x798a
// Size: 0x5a
function function_6c17abf5c5d88ca( vehicleref )
{
    data = vehicle_getleveldataforvehicle( vehicleref );
    return ter_op( isdefined( data.husk.weapon ), data.husk.weapon, data.weapon );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x79ed
// Size: 0x368
function function_d0df49de517ded03()
{
    ref = function_d93ec4635290febd();
    data = function_29b4292c92443328( ref );
    ishusk = isvehiclehusk();
    explosiondata = ter_op( ishusk || istrue( self.dontspawnhusk ) && isdefined( data.huskexplosion ), data.huskexplosion, data.pristineexplosion );
    weaponstring = ter_op( ishusk, function_6c17abf5c5d88ca( ref ), function_7aaa7ae503292f43( ref ) );
    mtx = self.mtx;
    waittillframeend();
    assertex( isdefined( explosiondata ), "<dev string:x499>" );
    explosionposition = self gettagorigin( explosiondata.tag );
    damageposition = explosionposition;
    
    if ( isdefined( explosiondata.damageoffset ) )
    {
        damageposition += rotatevector( ( default_to( explosiondata.damageoffset.x, 0 ), default_to( explosiondata.damageoffset.y, 0 ), default_to( explosiondata.damageoffset.z, 0 ) ), self.angles );
    }
    
    attacker = ter_op( isdefined( self.burndownattacker ), self.burndownattacker, self );
    self radiusdamage( damageposition, explosiondata.radius, explosiondata.maxdamage, explosiondata.mindamage, attacker, "MOD_EXPLOSIVE", weaponstring );
    fxname = self.vehiclename + "_explosion";
    
    if ( fxexists( fxname ) )
    {
        playfx( getfx( fxname ), explosionposition, anglestoforward( self.angles ), anglestoup( self.angles ) );
    }
    
    if ( isdefined( explosiondata.sfx ) )
    {
        playsoundatpos( explosionposition, explosiondata.sfx );
    }
    
    self stopsounds();
    
    if ( isdefined( explosiondata.scriptable ) )
    {
        explosionscriptable = spawn( "script_model", explosionposition );
        explosionscriptable setmodel( explosiondata.scriptable );
        
        if ( isdefined( mtx ) && isdefined( mtx.var_c3606975ab404c5c ) && mtx.var_c3606975ab404c5c != "" && explosionscriptable getscriptableparthasstate( "explosion", mtx.var_c3606975ab404c5c ) )
        {
            explosionscriptable setscriptablepartstate( "explosion", mtx.var_c3606975ab404c5c );
        }
        else
        {
            explosionscriptable setscriptablepartstate( "explosion", "on" );
        }
        
        explosionscriptable.angles = self.angles;
        explosionscriptable thread function_7d040e8b44f42b5f();
    }
    
    if ( isdefined( explosiondata.earthquakescale ) && explosiondata.earthquakescale > 0 )
    {
        earthquake( explosiondata.earthquakescale, explosiondata.earthquakeduration, explosionposition, explosiondata.earthquakeradius );
    }
    
    playrumbleonposition( "grenade_rumble", explosionposition );
    physicsexplosionsphere( explosionposition, explosiondata.physicsouterradius, explosiondata.physicsinnerradius, explosiondata.physicsscale );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x7d5d
// Size: 0xc
function function_7d040e8b44f42b5f()
{
    wait 7;
    self delete();
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x7d71
// Size: 0x13
function function_734926fcdbad1fd4()
{
    if ( scripts\cp_mp\vehicles\vehicle::isvehiclehusk() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x7d8c
// Size: 0x249
function vehicle_damage_onenterstateheavyscore( oldstateref, data )
{
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        leveldataforvehicle = vehicle_damage_getleveldataforvehicle( function_d93ec4635290febd(), undefined, 1 );
        
        if ( isdefined( leveldataforvehicle ) )
        {
            instancedataforvehicle = vehicle_damage_getinstancedataforvehicle( self, undefined, 1 );
            scoreevent = undefined;
            var_8d930baa3b013616 = undefined;
            award = undefined;
            awardlaunchonly = undefined;
            
            if ( isdefined( instancedataforvehicle ) )
            {
                scoreevent = instancedataforvehicle.heavydamagescoreevent;
                var_8d930baa3b013616 = instancedataforvehicle.heavydamagescorelaunchonly;
                award = instancedataforvehicle.heavydamageaward;
                awardlaunchonly = instancedataforvehicle.heavydamageawardlaunchonly;
            }
            
            if ( isdefined( leveldataforvehicle.class ) )
            {
                if ( !isdefined( scoreevent ) )
                {
                    switch ( leveldataforvehicle.class )
                    {
                        case #"hash_d2a55c7ac538641b":
                        case #"hash_d582c3286e5c390f":
                            scoreevent = #"disabled_vehicle_light";
                            break;
                        case #"hash_21622ca3ad06efb5":
                        case #"hash_53e0b558455f04c6":
                        case #"hash_c71b112fe04823d6":
                            scoreevent = #"disabled_vehicle_medium";
                            break;
                        case #"hash_2453c9ffec9f5c20":
                        case #"hash_e8ec392f4f2724e4":
                            scoreevent = #"disabled_vehicle_heavy";
                            break;
                    }
                }
                
                if ( isdefined( award ) )
                {
                }
            }
            
            if ( isdefined( scoreevent ) && scoreevent == #"none" )
            {
                scoreevent = undefined;
            }
            
            if ( isdefined( award ) && award == "none" )
            {
                award = undefined;
            }
            
            if ( !istrue( data.givepointsandxp ) && isplayer( data.attacker ) )
            {
                data.givepointsandxp = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer( self, data.attacker );
            }
            
            if ( isdefined( data.objweapon ) && weaponclass( data.objweapon.basename ) != "rocketlauncher" )
            {
                if ( istrue( var_8d930baa3b013616 ) )
                {
                    data.scoreeventnoweaponxp = 1;
                }
                
                if ( istrue( awardlaunchonly ) )
                {
                    data.awardnoweaponxp = 1;
                }
            }
            
            data.attacker thread vehicle_damage_givescoreandxpatframeend( scoreevent, award, data, self );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 1
// Checksum 0x0, Offset: 0x7fdd
// Size: 0x32b
function vehicle_damage_ondeathscore( data )
{
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        leveldataforvehicle = vehicle_damage_getleveldataforvehicle( function_d93ec4635290febd(), undefined, 1 );
        
        if ( isdefined( leveldataforvehicle ) )
        {
            instancedataforvehicle = vehicle_damage_getinstancedataforvehicle( self, undefined, 1 );
            scoreevent = undefined;
            var_8d930baa3b013616 = undefined;
            award = undefined;
            awardlaunchonly = undefined;
            
            if ( isdefined( instancedataforvehicle ) )
            {
                scoreevent = instancedataforvehicle.destroyscoreevent;
                var_8d930baa3b013616 = instancedataforvehicle.destroyscorelaunchonly;
                award = instancedataforvehicle.destroyaward;
                awardlaunchonly = instancedataforvehicle.destroyawardlaunchonly;
            }
            
            if ( isdefined( leveldataforvehicle.class ) )
            {
                if ( !isdefined( scoreevent ) )
                {
                    switch ( leveldataforvehicle.class )
                    {
                        case #"hash_d2a55c7ac538641b":
                        case #"hash_d582c3286e5c390f":
                            scoreevent = #"destroyed_vehicle_light";
                            break;
                        case #"hash_21622ca3ad06efb5":
                        case #"hash_53e0b558455f04c6":
                        case #"hash_c71b112fe04823d6":
                            scoreevent = #"destroyed_vehicle_medium";
                            break;
                        case #"hash_2453c9ffec9f5c20":
                        case #"hash_e8ec392f4f2724e4":
                            scoreevent = #"destroyed_vehicle_heavy";
                            break;
                        default:
                            scoreevent = #"none";
                            break;
                    }
                }
                
                if ( isdefined( award ) )
                {
                }
            }
            
            if ( isdefined( scoreevent ) && scoreevent == #"none" )
            {
                scoreevent = undefined;
            }
            
            if ( isdefined( award ) && award == "none" )
            {
                award = undefined;
            }
            
            if ( isplayer( data.attacker ) )
            {
                if ( !isdefined( data.givepointsandxp ) )
                {
                    data.givepointsandxp = scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer( self, data.attacker );
                }
                else if ( data.givepointsandxp && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer( self, data.attacker ) )
                {
                    data.givepointsandxp = 0;
                }
                else if ( !data.givepointsandxp && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer( self, data.attacker ) )
                {
                    data.givepointsandxp = 1;
                }
            }
            else
            {
                data.givepointsandxp = 0;
            }
            
            if ( isdefined( data.objweapon ) && weaponclass( data.objweapon.basename ) != "rocketlauncher" )
            {
                if ( istrue( var_8d930baa3b013616 ) )
                {
                    data.scoreeventnoweaponxp = 1;
                }
                
                if ( istrue( awardlaunchonly ) )
                {
                    data.awardnoweaponxp = 1;
                }
            }
            
            if ( issharedfuncdefined( "challenges", "onVehicleKilled" ) )
            {
                data.attacker thread [[ getsharedfunc( "challenges", "onVehicleKilled" ) ]]( self, data.attacker, data.damage, data.objweapon );
            }
            
            data.attacker vehicle_damage_givescoreandxp( scoreevent, award, data, self getentitynumber() );
        }
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x8310
// Size: 0x52
function vehicle_damage_givescoreandxpatframeend( scoreevent, award, data, vehicle )
{
    vehentnum = vehicle getentitynumber();
    self endon( "disconnect" );
    self endon( "vehicle_damage_giveScoreAndXP" + vehentnum );
    waittillframeend();
    thread vehicle_damage_givescoreandxp( scoreevent, award, data, vehentnum );
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x836a
// Size: 0xef
function vehicle_damage_givescoreandxp( scoreevent, award, data, vehentnum )
{
    self notify( "vehicle_damage_giveScoreAndXP" + vehentnum );
    
    if ( isdefined( scoreevent ) && issharedfuncdefined( "vehicle_damage", "giveScore" ) )
    {
        objweapon = ter_op( istrue( data.scoreeventnoweaponxp ), undefined, data.objweapon );
        self [[ getsharedfunc( "vehicle_damage", "giveScore" ) ]]( scoreevent, objweapon, !istrue( data.givepointsandxp ) );
    }
    
    if ( isdefined( award ) && issharedfuncdefined( "vehicle_damage", "giveAward" ) )
    {
        objweapon = ter_op( istrue( data.awardnoweaponxp ), undefined, data.objweapon );
        self [[ getsharedfunc( "vehicle_damage", "giveAward" ) ]]( award, objweapon, !istrue( data.givepointsandxp ) );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 4
// Checksum 0x0, Offset: 0x8461
// Size: 0x4d
function vehicle_damage_setweaponclassmoddamageforvehicle( weaponclass, mod, var_21e99fcec7e19345, vehicleref )
{
    if ( issharedfuncdefined( "vehicle_damage", "setWeaponClassModDamageForVehicle" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setWeaponClassModDamageForVehicle" ) ]]( weaponclass, mod, var_21e99fcec7e19345, vehicleref );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x84b6
// Size: 0x44
function vehicle_damage_setperkmoddamage( ref, mod, var_21e99fcec7e19345 )
{
    if ( issharedfuncdefined( "vehicle_damage", "setPerkModDamage" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setPerkModDamage" ) ]]( ref, mod, var_21e99fcec7e19345 );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x8502
// Size: 0x3b
function vehicle_damage_setweaponhitdamagedata( weaponref, hitsperattack )
{
    if ( issharedfuncdefined( "vehicle_damage", "setWeaponHitDamageData" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setWeaponHitDamageData" ) ]]( weaponref, hitsperattack );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x8545
// Size: 0x3b
function vehicle_damage_setvehiclehitdamagedata( vehicleref, hitstokill )
{
    if ( issharedfuncdefined( "vehicle_damage", "setVehicleHitDamageData" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setVehicleHitDamageData" ) ]]( vehicleref, hitstokill );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x8588
// Size: 0x44
function vehicle_damage_setvehiclehitdamagedataforweapon( vehicleref, hitstokill, weaponref )
{
    if ( issharedfuncdefined( "vehicle_damage", "setVehicleHitDamageDataForWeapon" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setVehicleHitDamageDataForWeapon" ) ]]( vehicleref, hitstokill, weaponref );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x85d4
// Size: 0x44
function vehicle_damage_setweaponhitdamagedataforvehicle( weaponref, hitsperattack, vehicleref )
{
    if ( issharedfuncdefined( "vehicle_damage", "setWeaponHitDamageDataForVehicle" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setWeaponHitDamageDataForVehicle" ) ]]( weaponref, hitsperattack, vehicleref );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x8620
// Size: 0x3b
function vehicle_damage_setpremoddamagecallback( vehicleref, callback )
{
    if ( issharedfuncdefined( "vehicle_damage", "setPreModDamageCallback" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setPreModDamageCallback" ) ]]( vehicleref, callback );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x8663
// Size: 0x3b
function vehicle_damage_setpostmoddamagecallback( vehicleref, callback )
{
    if ( issharedfuncdefined( "vehicle_damage", "setPostModDamageCallback" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setPostModDamageCallback" ) ]]( vehicleref, callback );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 2
// Checksum 0x0, Offset: 0x86a6
// Size: 0x3b
function vehicle_damage_setdeathcallback( vehicleref, callback )
{
    if ( issharedfuncdefined( "vehicle_damage", "setDeathCallback" ) )
    {
        [[ getsharedfunc( "vehicle_damage", "setDeathCallback" ) ]]( vehicleref, callback );
    }
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x86e9
// Size: 0x5b
function function_e5cde837844c6112( vehicleref, seatid, damagescale )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref, 1 );
    
    if ( !isdefined( leveldataforvehicle.occupantdamagescale ) )
    {
        leveldataforvehicle.occupantdamagescale = [];
    }
    
    leveldataforvehicle.occupantdamagescale[ seatid ] = damagescale;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 3
// Checksum 0x0, Offset: 0x874c
// Size: 0x5b
function function_42b7542e79da627f( vehicleref, seatid, damageclamp )
{
    leveldataforvehicle = vehicle_damage_getleveldataforvehicle( vehicleref, 1 );
    
    if ( !isdefined( leveldataforvehicle.occupantdamageclamp ) )
    {
        leveldataforvehicle.occupantdamageclamp = [];
    }
    
    leveldataforvehicle.occupantdamageclamp[ seatid ] = damageclamp;
}

// Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
// Params 0
// Checksum 0x0, Offset: 0x87af
// Size: 0x2d
function vehicle_damage_initdebug()
{
    setdvarifuninitialized( @"scr_vehiclegod", 0 );
    setdvarifuninitialized( @"hash_4827ebae75561872", 0 );
    
    /#
        thread function_cc07937f89e8a007();
    #/
}

/#

    // Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
    // Params 0
    // Checksum 0x0, Offset: 0x87e4
    // Size: 0x12e, Type: dev
    function function_cc07937f89e8a007()
    {
        level.vehiclegod = getdvarint( @"scr_vehiclegod", 0 ) > 0;
        
        while ( true )
        {
            simulatedamagepercent = getdvarint( @"hash_4827ebae75561872", 0 );
            
            if ( simulatedamagepercent > 0 )
            {
                vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
                
                if ( vehicles.size > 0 )
                {
                    iprintln( "<dev string:x53c>" + simulatedamagepercent + "<dev string:x541>" );
                }
                
                foreach ( vehicle in vehicles )
                {
                    if ( isdefined( vehicle ) && !vehicle scripts\cp_mp\vehicles\vehicle::isvehicledestroyed() )
                    {
                        function_a4e5dc47d7128f1d( vehicle, simulatedamagepercent );
                    }
                }
                
                setdevdvar( @"hash_4827ebae75561872", 0 );
            }
            
            vehiclegod = getdvarint( @"scr_vehiclegod", 0 ) > 0;
            
            if ( level.vehiclegod != vehiclegod )
            {
                if ( vehiclegod )
                {
                    iprintln( "<dev string:x55b>" );
                }
                else
                {
                    iprintln( "<dev string:x56d>" );
                }
                
                level.vehiclegod = vehiclegod;
            }
            
            waitframe();
        }
    }

    // Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
    // Params 2
    // Checksum 0x0, Offset: 0x891a
    // Size: 0xa4, Type: dev
    function function_a4e5dc47d7128f1d( vehicle, percent )
    {
        damagedata = spawnstruct();
        attacker = level.players[ 0 ];
        percent = min( percent, 100 ) / 100;
        damage = int( min( vehicle.health, ceil( vehicle.maxhealth * percent ) ) );
        thread function_28c5e9f1993854aa();
        vehicle dodamage( damage, vehicle.origin, attacker, undefined, "<dev string:x580>" );
        thread function_a6106f4cf6a1233();
    }

    // Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
    // Params 0
    // Checksum 0x0, Offset: 0x89c6
    // Size: 0x48, Type: dev
    function function_28c5e9f1993854aa()
    {
        level notify( "<dev string:x591>" );
        level endon( "<dev string:x591>" );
        
        if ( !isdefined( level.vehiclefriendlydamageold ) )
        {
            level.vehiclefriendlydamageold = istrue( level.vehiclefriendlydamage );
            level.vehiclefriendlydamage = 1;
        }
        
        waittillframeend();
        thread function_a6106f4cf6a1233();
    }

    // Namespace vehicle_damage / scripts\cp_mp\vehicles\vehicle_damage
    // Params 0
    // Checksum 0x0, Offset: 0x8a16
    // Size: 0x36, Type: dev
    function function_a6106f4cf6a1233()
    {
        level notify( "<dev string:x591>" );
        
        if ( isdefined( level.vehiclefriendlydamageold ) )
        {
            level.vehiclefriendlydamage = level.vehiclefriendlydamageold;
            level.vehiclefriendlydamageold = undefined;
        }
    }

#/
