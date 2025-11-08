#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\script;

#namespace equipment;

// Namespace equipment / scripts\mp\utility\equipment
// Params 0
// Checksum 0x0, Offset: 0x20c
// Size: 0x108
function get_mine_ignore_list()
{
    ignorelist = [ self ];
    
    if ( isdefined( level.dynamicladders ) )
    {
        foreach ( struct in level.dynamicladders )
        {
            ignorelist[ ignorelist.size ] = struct.ents[ 0 ];
        }
    }
    
    linkedents = self getlinkedchildren( 1 );
    
    if ( !isdefined( linkedents ) )
    {
        linkedents = [];
    }
    
    linkedents[ linkedents.size ] = self getlinkedparent();
    
    foreach ( linkedent in linkedents )
    {
        if ( isdefined( linkedent ) && linkedent.classname == "grenade" )
        {
            ignorelist[ ignorelist.size ] = linkedent;
        }
    }
    
    return ignorelist;
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 6
// Checksum 0x0, Offset: 0x31d
// Size: 0x435
function get_sticky_grenade_destination( grenade, gunangles, speedforward, speedup, fusetime, data )
{
    assertex( speedforward != 0 && speedup != 0, "<dev string:x1c>" );
    grenade endon( "death" );
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
    }
    
    if ( !isdefined( data.contents ) )
    {
        data.contents = get_grenade_cast_contents();
    }
    
    if ( !isdefined( data.divisions ) )
    {
        data.divisions = 5;
    }
    
    if ( !isdefined( data.amortize ) )
    {
        data.amortize = 1;
    }
    
    if ( !isdefined( data.ignorelist ) )
    {
        data.ignorelist = [ grenade, grenade.owner ];
    }
    
    if ( !isdefined( data.ignorclutter ) )
    {
        data.ignoreclutter = 1;
    }
    
    if ( !isdefined( fusetime ) )
    {
        fusetime = 10;
    }
    
    if ( !isdefined( data.maxtime ) )
    {
        data.maxtime = fusetime - fusetime * grenade.tickpercent;
    }
    
    assertex( data.maxtime > 0, "<dev string:x6e>" );
    assertex( data.divisions > 0, "<dev string:xb6>" );
    steptime = data.maxtime / data.divisions;
    times[ 0 ] = 0;
    positions[ 0 ] = grenade.origin;
    var_cbe776efc22487c7 = data.divisions;
    dirforward = anglestoforward( gunangles );
    dirup = ( 0, 0, 1 );
    vel = dirforward * speedforward + dirup * speedup;
    var_71b049ff6296dc2f = dirup * vectordot( dirup, vel );
    var_60cecc5d1218a89e = vel - var_71b049ff6296dc2f;
    
    for ( i = 1; i < data.divisions ; i++ )
    {
        prevtime = times[ i - 1 ];
        prevposition = positions[ i - 1 ];
        nexttime = i * steptime;
        var_3e6b57d717b688d8 = var_60cecc5d1218a89e * nexttime;
        var_46de56d5eb869951 = var_71b049ff6296dc2f * nexttime + 0.5 * ( 0, 0, -800 ) * nexttime * nexttime;
        nextposition = positions[ 0 ] + var_3e6b57d717b688d8 + var_46de56d5eb869951;
        times[ i ] = nexttime;
        positions[ i ] = nextposition;
        results = physics_raycast( prevposition, nextposition, data.contents, data.ignorelist, 1, "physicsquery_closest", data.ignoreclutter );
        
        if ( isdefined( results ) && results.size > 0 )
        {
            /#
                var_cbe776efc22487c7 = i;
            #/
            
            data.destination = results[ 0 ][ "position" ];
            data.destinationnormal = results[ 0 ][ "normal" ];
            data.destinationentity = results[ 0 ][ "entity" ];
            data.destinationhit = 1;
            var_ec7b20b1054d5d98 = nextposition - prevposition;
            var_5805327f64d62d38 = length( var_ec7b20b1054d5d98 );
            var_35ebf7955ec217cf = var_ec7b20b1054d5d98 / var_5805327f64d62d38;
            prevtodest = prevposition - data.destination;
            var_59d191507790c7c9 = vectordot( var_35ebf7955ec217cf, prevtodest );
            var_fb921beb20aa928d = clamp( var_59d191507790c7c9 / var_5805327f64d62d38, 0, 1 );
            data.destinationtime = prevtime + steptime * var_fb921beb20aa928d;
            break;
        }
        else if ( i == data.divisions - 1 )
        {
            data.destination = nextposition;
            break;
        }
        
        if ( data.amortize )
        {
            waitframe();
        }
    }
    
    /#
    #/
    
    return data;
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 1
// Checksum 0x0, Offset: 0x75b
// Size: 0x94
function get_grenade_cast_contents( includeplayers )
{
    contents = undefined;
    
    if ( istrue( includeplayers ) )
    {
        contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_characterproxy" ] );
    }
    else
    {
        contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water" ] );
    }
    
    return contents;
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 2
// Checksum 0x0, Offset: 0x7f8
// Size: 0x611, Type: bool
function plant( grenade, data )
{
    self endon( "death_or_disconnect" );
    grenade endon( "death" );
    assertex( isdefined( grenade ), "<dev string:x100>" );
    assertex( isdefined( data ), "<dev string:x12a>" );
    assertex( isdefined( data.throwspeedforward ), "<dev string:x151>" );
    assertex( isdefined( data.throwspeedup ), "<dev string:x18a>" );
    grenade.releasegrenadeorigin = grenade.origin;
    grenade.releaseownerorigin = self.origin;
    grenade.releaseownereye = self geteye();
    grenade.releaseownerangles = self getgunangles();
    
    if ( !isdefined( data.plantmaxtime ) )
    {
        data.plantmaxtime = 0.5;
    }
    
    if ( !isdefined( data.plantmaxroll ) )
    {
        data.plantmaxroll = 0;
    }
    
    if ( !isdefined( data.plantmindistbeloweye ) )
    {
        data.plantmindistbeloweye = 12;
    }
    
    if ( !isdefined( data.plantmaxdistbelowownerfeet ) )
    {
        data.plantmaxdistbelowownerfeet = 20;
    }
    
    if ( !isdefined( data.plantmindisteyetofeet ) )
    {
        data.plantmindisteyetofeet = 45;
    }
    
    if ( !isdefined( data.plantnormalcos ) )
    {
        data.plantnormalcos = 0.342;
    }
    
    if ( !isdefined( data.plantoffsetz ) )
    {
        data.plantoffsetz = 1;
    }
    
    plant_watch_stuck( grenade, data );
    var_6eb1ccfdf22d82b7 = 0;
    position = data.notifyorigin;
    normal = data.notifynormal;
    linkedparent = data.notifyentity;
    stuck = data.notifyhit;
    angles = undefined;
    
    if ( !istrue( stuck ) )
    {
        position = data.calcorigin;
        normal = data.calcnormal;
        linkedparent = data.calcentity;
        stuck = data.calchit;
        
        if ( istrue( stuck ) && isdefined( linkedparent ) && linkedparent getnonstick() )
        {
            stuck = undefined;
        }
        
        contents = get_grenade_cast_contents( 0 );
        ignorelist = [ grenade ];
        caststart = self geteye() - ( 0, 0, 30 );
        castend = caststart + anglestoforward( self getplayerangles( 1 ) ) * 20;
        results = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( results ) && results.size > 0 )
        {
            stuck = 0;
        }
    }
    else
    {
        angles = plant_clamp_angles( grenade.angles, data );
    }
    
    if ( istrue( stuck ) )
    {
        if ( isdefined( normal ) && vectordot( normal, ( 0, 0, 1 ) ) < data.plantnormalcos )
        {
            var_6eb1ccfdf22d82b7 = 1;
        }
        else
        {
            var_f4ef78de9cf3220a = vectordot( grenade.releaseownerorigin - position, ( 0, 0, 1 ) );
            
            if ( var_f4ef78de9cf3220a > 0 )
            {
                if ( var_f4ef78de9cf3220a > data.plantmaxdistbelowownerfeet )
                {
                    var_6eb1ccfdf22d82b7 = 1;
                }
            }
            else
            {
                var_89cc128c05b322d1 = vectordot( grenade.releaseownereye - grenade.releaseownerorigin, ( 0, 0, 1 ) );
                
                if ( var_89cc128c05b322d1 > data.plantmindisteyetofeet )
                {
                    distbeloweye = vectordot( grenade.releaseownereye - position, ( 0, 0, 1 ) );
                    
                    if ( distbeloweye >= 0 )
                    {
                        if ( distbeloweye < data.plantmindistbeloweye )
                        {
                            var_6eb1ccfdf22d82b7 = 1;
                        }
                    }
                    else
                    {
                        var_6eb1ccfdf22d82b7 = 1;
                    }
                }
            }
        }
    }
    else
    {
        var_6eb1ccfdf22d82b7 = 1;
    }
    
    if ( var_6eb1ccfdf22d82b7 )
    {
        contents = data.castcontents;
        
        if ( !isdefined( contents ) )
        {
            contents = get_grenade_cast_contents();
        }
        
        ignorelist = [ grenade ];
        caststart = grenade.releaseownerorigin + ( 0, 0, 1 );
        castend = caststart + ( 0, 0, -1 * data.plantmaxdistbelowownerfeet );
        results = physics_raycast( caststart, castend, contents, ignorelist, 1, "physicsquery_closest", 1 );
        
        if ( isdefined( results ) && results.size > 0 )
        {
            position = results[ 0 ][ "position" ];
            normal = results[ 0 ][ "normal" ];
            
            if ( isdefined( normal ) && vectordot( normal, ( 0, 0, 1 ) ) < data.plantnormalcos )
            {
                return false;
            }
            
            var_28b3f77bb0070f33 = grenade.releaseownerangles * ( 0, 1, 0 );
            
            if ( isdefined( normal ) )
            {
                angles = vectortoanglessafe( anglestoforward( var_28b3f77bb0070f33 ), normal );
                angles = plant_clamp_angles( angles, data );
            }
            else
            {
                angles = var_28b3f77bb0070f33;
            }
            
            position += anglestoup( angles ) * data.plantoffsetz;
            linkedparent = results[ 0 ][ "entity" ];
            grenade dontinterpolate();
            grenade.origin = position;
            grenade.angles = angles;
            
            /#
            #/
        }
        else
        {
            return false;
        }
    }
    else
    {
        if ( !isdefined( angles ) )
        {
            var_28b3f77bb0070f33 = grenade.releaseownerangles * ( 0, 1, 0 );
            
            if ( isdefined( normal ) )
            {
                angles = vectortoanglessafe( anglestoforward( var_28b3f77bb0070f33 ), normal );
                angles = plant_clamp_angles( angles, data );
            }
            else
            {
                angles = var_28b3f77bb0070f33;
            }
        }
        
        position += anglestoup( angles ) * data.plantoffsetz;
        grenade dontinterpolate();
        grenade.origin = position;
        grenade.angles = angles;
        
        /#
        #/
    }
    
    if ( isdefined( linkedparent ) )
    {
        grenade linkto( linkedparent );
    }
    
    return true;
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 2
// Checksum 0x0, Offset: 0xe12
// Size: 0x43
function plant_watch_stuck( grenade, data )
{
    childthread plant_watch_stuck_notify( grenade, data );
    childthread plant_watch_stuck_calculate( grenade, data );
    childthread plant_watch_stuck_timeout( grenade, data );
    data waittill( "start_race" );
    waittillframeend();
    data notify( "end_race" );
    return data;
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 2
// Checksum 0x0, Offset: 0xe5e
// Size: 0x7f
function plant_watch_stuck_notify( grenade, data )
{
    data endon( "end_race" );
    grenade waittill( "missile_stuck", stuckto );
    data.notifyorigin = grenade.origin;
    data.notifyangles = grenade.angles;
    data.notifyentity = stuckto;
    data.notifyhit = 1;
    data notify( "start_race" );
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 2
// Checksum 0x0, Offset: 0xee5
// Size: 0xac
function plant_watch_stuck_calculate( grenade, data )
{
    data endon( "end_race" );
    data = get_sticky_grenade_destination( grenade, grenade.releaseownerangles, data.throwspeedforward, data.throwspeedup, data.castmaxtime, data );
    data.calcorigin = data.destination;
    data.calcnormal = data.destinationnormal;
    data.calcentity = data.destinationentity;
    data.calchit = data.destinationhit;
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 2
// Checksum 0x0, Offset: 0xf99
// Size: 0x2e
function plant_watch_stuck_timeout( grenade, data )
{
    data endon( "end_race" );
    wait data.plantmaxtime;
    data notify( "start_race" );
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 2
// Checksum 0x0, Offset: 0xfcf
// Size: 0x94
function plant_clamp_angles( angles, data )
{
    pitch = 0;
    yaw = angles[ 1 ];
    roll = ter_op( data.plantmaxroll != 0, angles[ 2 ], 0 );
    
    if ( roll != 0 )
    {
        if ( roll > 0 )
        {
            roll = clamp( angles[ 2 ], 0, data.plantmaxroll );
        }
        else
        {
            roll = clamp( angles[ 2 ], -1 * data.plantmaxroll, 0 );
        }
    }
    
    return ( pitch, yaw, roll );
}

// Namespace equipment / scripts\mp\utility\equipment
// Params 0
// Checksum 0x0, Offset: 0x106c
// Size: 0x62
function watch_flight_collision()
{
    original_pos = self.origin;
    
    while ( true )
    {
        self waittill( "touching_platform", platform );
        
        if ( isdefined( platform ) && self istouching( platform ) && self.origin[ 2 ] - original_pos[ 2 ] > 12 )
        {
            self notify( "collision_with_platform" );
            return;
        }
    }
}

