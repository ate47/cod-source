#using script_13865ca76df87ea;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\auto_ascender;
#using scripts\cp_mp\auto_ascender_solo;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\movers;
#using scripts\mp\perks\perk_equipmentping;
#using scripts\mp\supers;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace tactical_cover;

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x879
// Size: 0x1bd
function tac_cover_init()
{
    if ( !isdefined( level.taccovercollision ) )
    {
        collisionarr = getentarray( "tactical_cover_col", "targetname" );
        
        if ( isdefined( collisionarr ) )
        {
            level.taccovercollision = collisionarr[ 0 ];
        }
    }
    
    if ( false )
    {
        level.taccovertriggerblockers = getentarray( "dcover_blocker", "targetname" );
    }
    
    if ( true )
    {
        if ( !isdefined( level.var_f73654528e070ab4 ) )
        {
            level.var_f73654528e070ab4 = getstructarray( "dcover_blocker_struct", "targetname" );
            
            foreach ( var_445b9ac77407a627 in level.var_f73654528e070ab4 )
            {
                level function_b8ffeacf84a9d34e( var_445b9ac77407a627 );
            }
        }
        else
        {
            foreach ( var_445b9ac77407a627 in level.var_f73654528e070ab4 )
            {
                level function_b8ffeacf84a9d34e( var_445b9ac77407a627 );
            }
            
            level.var_f73654528e070ab4 = array_combine( level.var_f73654528e070ab4, getentarray( "dcover_blocker_struct", "targetname" ) );
        }
    }
    
    level.taccover_timeout = getdvarfloat( @"hash_fdeb104ec6908df8", 150 );
    level.var_29bd6759d7f2ed45 = getdvarint( @"hash_b2324a0894ed035f", 1 );
    level.var_f3be3f9bad33bf87 = getdvarint( hashcat( @"hash_2798c84281925605", scripts\mp\utility\game::getsubgametype(), "_damagedScoreLimit" ), 0 ) == 1;
    
    /#
        setdevdvarifuninitialized( @"hash_a5a0ca488a1da730", 0 );
    #/
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 3
// Checksum 0x0, Offset: 0xa3e
// Size: 0x3f
function tac_cover_on_give( ref, slot, variantid )
{
    self notify( "tac_cover_given" );
    
    /#
        if ( !isdefined( level.taccovercollision ) )
        {
            self iprintlnbold( "<dev string:x1c>" );
        }
    #/
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 3
// Checksum 0x0, Offset: 0xa85
// Size: 0x2d
function tac_cover_on_take( ref, slot, issuper )
{
    self notify( "tac_cover_taken" );
    self.taccoverrefund = undefined;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0xaba
// Size: 0x24
function tac_cover_used( grenade )
{
    if ( isdefined( grenade ) )
    {
        grenade hide();
    }
    
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 4
// Checksum 0x0, Offset: 0xae6
// Size: 0xd18, Type: bool
function tac_cover_on_fired( ref, slot, objweapon, issuper )
{
    if ( self isswimming() || !self isonground() || istrue( self.var_c74e2a2f7c14d917 ) )
    {
        tac_cover_fire_failed( 0 );
        return false;
    }
    
    self.taccoverrefund = 1;
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle" ] );
    ignorelist = tac_cover_ignore_list( self );
    
    if ( ignorelist.size > 128 )
    {
        logstring( "count,entNum,birthtime,origin,classname,code_classname,model,targetname,script_noteworthy,ownerNum" );
        allents = getentarray();
        
        foreach ( i, ent in ignorelist )
        {
            str = "" + i;
            
            if ( isent( ent ) )
            {
                fields = [ ent getentitynumber(), ent.birthtime, ent.origin, ent.classname, ent.code_classname, ent.model, ent.targetname, ent.script_noteworthy ];
                
                if ( isdefined( ent.owner ) )
                {
                    fields[ fields.size ] = ent.owner getentitynumber();
                }
                else
                {
                    fields[ fields.size ] = -1;
                }
                
                foreach ( value in fields )
                {
                    if ( !isdefined( value ) )
                    {
                        value = "<undefined>";
                    }
                    
                    str += "," + value;
                }
            }
            else
            {
                str += ",not an ent";
            }
            
            logstring( str );
        }
    }
    
    playerforward = anglestoforward( self.angles );
    targetpos = self.origin + playerforward * 32;
    nearbydoors = scriptable_door_get_in_radius( targetpos, 140, 20 );
    closestdoor = undefined;
    closestdistsqrd = 0;
    
    if ( tac_cover_blocked_by_turret( targetpos ) )
    {
        tac_cover_fire_failed( 0 );
        return false;
    }
    
    if ( scripts\cp_mp\auto_ascender::function_ff57f9acf27bbc3c( targetpos ) )
    {
        return false;
    }
    
    if ( scripts\cp_mp\auto_ascender_solo::ispointnearsoloascenderline( targetpos ) )
    {
        return false;
    }
    
    if ( function_6cc8838979f47b9f( targetpos ) || function_ac29e794c919fe03( targetpos ) || function_9461775d71e495cf( targetpos ) )
    {
        tac_cover_fire_failed( 0 );
        return false;
    }
    
    traceresults = undefined;
    contents = undefined;
    radius = getdvarfloat( @"hash_9fa5c4d28ec05069", 40 );
    
    if ( istrue( level.var_29bd6759d7f2ed45 ) )
    {
        contents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_glass" ] );
        traceresults = scripts\engine\trace::sphere_trace_get_all_results( targetpos, targetpos + ( 0, 0, 10 ), radius, undefined, contents, 1 );
    }
    else
    {
        contents = scripts\engine\trace::function_2d88cb1f022d0989();
        traceresults = scripts\engine\trace::sphere_trace_get_all_results( targetpos, targetpos + ( 0, 0, 10 ), radius, level.players, contents, 1 );
    }
    
    foreach ( trace in traceresults )
    {
        if ( isdefined( trace[ "surfaceflags" ] ) )
        {
            var_8a9f2060af8afa5f = 19;
            invalidsurface = 0;
            invalidsurface |= trace[ "surfaceflags" ] == 8;
            invalidsurface |= trace[ "surfaceflags" ] == 2048;
            invalidsurface |= trace[ "surfaceflags" ] == 9 << var_8a9f2060af8afa5f;
            invalidsurface |= trace[ "surfaceflags" ] == 39 << var_8a9f2060af8afa5f;
            
            if ( invalidsurface )
            {
                tac_cover_fire_failed( 0 );
                return false;
            }
        }
    }
    
    foreach ( door in nearbydoors )
    {
        distsqrd = distancesquared( door.origin, targetpos );
        
        if ( isdefined( closestdoor ) && closestdistsqrd <= distsqrd )
        {
            continue;
        }
        
        closestdoor = door;
        closestdistsqrd = distsqrd;
    }
    
    if ( isdefined( closestdoor ) )
    {
        doordegrees = closestdoor scriptabledoorangle();
        isdooropen = abs( doordegrees ) > 65;
        doubledoor = undefined;
        
        foreach ( otherdoor in nearbydoors )
        {
            if ( closestdoor scriptable_door_is_double_door_pair( otherdoor ) )
            {
                doubledoor = otherdoor;
                break;
            }
        }
        
        var_560b069f3a9b36e4 = 1;
        
        if ( isdefined( doubledoor ) )
        {
            var_f5867c54c41d2a4d = doubledoor scriptabledoorangle();
            var_560b069f3a9b36e4 = abs( var_f5867c54c41d2a4d ) > 65;
        }
        
        if ( closestdistsqrd < 1600 && isdooropen && var_560b069f3a9b36e4 )
        {
            startpos = self gettagorigin( "j_spinelower" );
            endpos = closestdoor function_d90515f5e17dbc6f() + ( 0, 0, 24 );
            castresult = physics_raycast( startpos, endpos, contents, ignorelist, 0, "physicsquery_any", 1 );
            
            if ( isdefined( castresult ) && castresult > 0 )
            {
                errormessage = 1;
                
                if ( isdefined( closestdoor.origin ) )
                {
                    data = function_1d1bf10a8da86b91( closestdoor.origin );
                    errormessage = data[ 1 ];
                }
                
                tac_cover_fire_failed( errormessage );
                return false;
            }
            
            closestdoor.isblocked = 1;
            self.taccoverrefund = undefined;
            thread tac_cover_spawn_with_door( closestdoor, doubledoor, issuper, contents );
            scripts\mp\utility\stats::incpersstat( "deployableCoverUsed", 1 );
            return true;
        }
        else if ( closestdistsqrd < 6400 )
        {
            errormessage = 1;
            
            if ( isdefined( closestdoor.origin ) )
            {
                data = function_1d1bf10a8da86b91( closestdoor.origin );
                errormessage = data[ 1 ];
            }
            
            tac_cover_fire_failed( errormessage );
            return false;
        }
    }
    
    var_ac01a11a5f883c59 = self getplayerangles() * ( 0, 1, 0 );
    caststart = self.origin + ( 0, 0, 24 );
    castdir = anglestoforward( var_ac01a11a5f883c59 );
    castdist = 32 - 2.5;
    frontcastend = caststart + castdir * castdist;
    castresult = physics_raycast( caststart, frontcastend, contents, ignorelist, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( castresult ) && castresult.size > 0 )
    {
        tac_cover_fire_failed();
        return false;
    }
    
    rightfraction = undefined;
    leftfraction = undefined;
    caststart = frontcastend;
    castdir = anglestoright( var_ac01a11a5f883c59 );
    castdist = 58 - 2.5;
    castend = caststart + castdir * castdist;
    castresult = physics_spherecast( caststart, castend, 2.5, contents, ignorelist, "physicsquery_closest" );
    
    if ( isdefined( castresult ) && castresult.size > 0 )
    {
        foreach ( trace in castresult )
        {
            if ( isdefined( trace[ "surfaceflags" ] ) )
            {
                invalidsurface = 0;
                invalidsurface |= trace[ "surfaceflags" ] == 8;
                
                if ( invalidsurface )
                {
                    tac_cover_fire_failed( 0 );
                    return false;
                }
            }
        }
        
        hitpos = castresult[ 0 ][ "shape_position" ];
        rightfraction = castresult[ 0 ][ "fraction" ];
    }
    else
    {
        rightfraction = 1;
    }
    
    caststart = frontcastend;
    castdir = -1 * anglestoright( var_ac01a11a5f883c59 );
    castdist = 58 - 2.5;
    castend = caststart + castdir * castdist;
    castresult = physics_spherecast( caststart, castend, 2.5, contents, ignorelist, "physicsquery_closest" );
    
    if ( isdefined( castresult ) && castresult.size > 0 )
    {
        foreach ( trace in castresult )
        {
            if ( isdefined( trace[ "surfaceflags" ] ) )
            {
                invalidsurface = 0;
                invalidsurface |= ( trace[ "surfaceflags" ] & 8 ) > 0;
                
                if ( invalidsurface )
                {
                    tac_cover_fire_failed( 0 );
                    return false;
                }
            }
        }
        
        hitpos = castresult[ 0 ][ "shape_position" ];
        leftfraction = castresult[ 0 ][ "fraction" ];
    }
    else
    {
        leftfraction = 1;
    }
    
    if ( leftfraction + rightfraction < 1 )
    {
        tac_cover_fire_failed();
        return false;
    }
    else if ( rightfraction < 0.5 )
    {
        frontcastend += castdir * castdist * ( 0.5 - rightfraction );
    }
    else if ( leftfraction < 0.5 )
    {
        frontcastend += castdir * castdist * ( 0.5 - leftfraction ) * -1;
    }
    
    castangles = var_ac01a11a5f883c59;
    caststart = frontcastend;
    castdir = ( 0, 0, -1 );
    castdist = 60;
    castend = caststart + castdir * castdist;
    var_188ecaff115cacb7 = combineangles( castangles, ( 0, 0, 90 ) );
    castresult = physics_capsulecast( caststart, castend, 2.5, 16.8, var_188ecaff115cacb7, contents, ignorelist, "physicsquery_closest" );
    
    if ( !isdefined( castresult ) || castresult.size <= 0 )
    {
        tac_cover_fire_failed();
        return false;
    }
    
    hitent = castresult[ 0 ][ "entity" ];
    
    if ( isdefined( hitent ) && !tac_cover_can_place_on( hitent ) )
    {
        tac_cover_fire_failed();
        return false;
    }
    
    var_c72145d539d8d1a1 = castresult[ 0 ][ "shape_position" ];
    hitpos = castresult[ 0 ][ "position" ];
    spawnpos = var_c72145d539d8d1a1 - ( 0, 0, 2.5 );
    var_7a2d144a06a00b97 = tac_cover_get_stuck_to_ent( hitent );
    var_786439b54d66d5f9 = ( 16.8 - 2.5 ) * 1.75;
    var_d017352bffc438f8 = pow( var_786439b54d66d5f9 * 0.14, 2 );
    caststartcenter = var_c72145d539d8d1a1;
    var_30f5ea3b5bc36327 = distance2dsquared( caststartcenter, hitpos );
    caststartright = var_c72145d539d8d1a1 + anglestoright( var_ac01a11a5f883c59 ) * ( 16.8 - 2.5 ) * 1.75;
    var_a104b4b86ea439f6 = distance2dsquared( caststartright, hitpos );
    caststartleft = var_c72145d539d8d1a1 + anglestoright( var_ac01a11a5f883c59 ) * ( 16.8 - 2.5 ) * 1.75 * -1;
    var_265e28da43deed4f = distance2dsquared( caststartleft, hitpos );
    
    if ( self edgequeryispointnearladder( caststartleft, 32 ) || self edgequeryispointnearladder( caststartright, 32 ) )
    {
        tac_cover_fire_failed();
        return false;
    }
    
    caststarts = [];
    var_558aadd2c4f2af41 = 0;
    
    if ( var_a104b4b86ea439f6 <= var_d017352bffc438f8 && var_a104b4b86ea439f6 < var_30f5ea3b5bc36327 && var_a104b4b86ea439f6 < var_265e28da43deed4f )
    {
        var_558aadd2c4f2af41++;
        caststarts = [ caststartcenter, caststartleft ];
    }
    else if ( var_265e28da43deed4f <= var_d017352bffc438f8 && var_265e28da43deed4f < var_30f5ea3b5bc36327 && var_265e28da43deed4f < var_a104b4b86ea439f6 )
    {
        var_558aadd2c4f2af41++;
        caststarts = [ caststartcenter, caststartright ];
    }
    else if ( var_30f5ea3b5bc36327 <= var_d017352bffc438f8 )
    {
        var_558aadd2c4f2af41++;
        caststarts = [ caststartleft, caststartright ];
    }
    else
    {
        caststarts = [ caststartcenter, caststartleft, caststartright ];
    }
    
    castdir = ( 0, 0, -1 );
    castdist = 6 + 2.5;
    
    foreach ( caststart in caststarts )
    {
        castend = caststart + castdir * castdist;
        castresult = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_all", 1 );
        
        if ( !isdefined( castresult ) || castresult.size <= 0 )
        {
            /#
                if ( false )
                {
                    thread scripts\mp\utility\debug::drawline( caststart, castend, 10, ( 1, 0, 0 ) );
                }
            #/
            
            continue;
        }
        
        hitent = castresult[ 0 ][ "entity" ];
        
        if ( isdefined( hitent ) && !tac_cover_can_place_on( hitent ) )
        {
            tac_cover_fire_failed();
            return false;
        }
        
        var_558aadd2c4f2af41++;
        
        if ( var_558aadd2c4f2af41 >= 2 )
        {
            break;
        }
    }
    
    if ( var_558aadd2c4f2af41 < 2 )
    {
        tac_cover_fire_failed();
        return false;
    }
    
    self.taccoverrefund = undefined;
    thread tac_cover_spawn( spawnpos, castangles, var_7a2d144a06a00b97, issuper, contents );
    scripts\mp\utility\stats::incpersstat( "deployableCoverUsed", 1 );
    return true;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x1807
// Size: 0x1d
function tac_cover_get_stuck_to_ent( hitent )
{
    if ( isdefined( hitent ) )
    {
        if ( scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e( hitent ) )
        {
            return hitent;
        }
    }
    
    return undefined;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x182d
// Size: 0x78, Type: bool
function is_train_ent( hitent )
{
    if ( isdefined( level.wztrain_info ) )
    {
        foreach ( ent in level.wztrain_info.train_array )
        {
            if ( ent == hitent )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x18ae
// Size: 0x293
function function_1d1bf10a8da86b91( spawnpos )
{
    newspawnpos = spawnpos;
    var_140b9fa52f1f56c = 1;
    var_69a8940023827f01 = 6;
    var_db2f3eee59030225 = 0;
    
    foreach ( blockerstruct in level.var_f73654528e070ab4 )
    {
        /#
            if ( true )
            {
                duration = level.framedurationseconds * 60 * 10;
                colorred = ( 1, 0, 0 );
                colorblue = ( 0, 0, 1 );
                colorgreen = ( 0, 1, 0 );
                
                if ( istrue( blockerstruct.var_36be730ee498727c ) )
                {
                    level thread scripts\cp_mp\utility\debug_utility::drawcylinder( blockerstruct.origin - var_69a8940023827f01, blockerstruct.radius, blockerstruct.height + var_69a8940023827f01, duration, colorred );
                }
                else
                {
                    level thread scripts\cp_mp\utility\debug_utility::drawcylinder( blockerstruct.origin - var_69a8940023827f01, blockerstruct.radius, blockerstruct.height + var_69a8940023827f01, duration, colorblue );
                }
                
                level thread scripts\cp_mp\utility\debug_utility::drawsphere( newspawnpos, 5, duration, colorgreen );
            }
        #/
        
        if ( istrue( var_db2f3eee59030225 ) )
        {
            continue;
        }
        
        var_1dce2d1958040081 = distance_2d_squared( blockerstruct.origin, newspawnpos );
        rad_sq = squared( blockerstruct.radius );
        z_min = blockerstruct.origin[ 2 ] - var_69a8940023827f01;
        z_max = z_min + var_69a8940023827f01 + ter_op( isdefined( blockerstruct.height ), blockerstruct.height, 96 );
        var_f66aff855fc46c7d = newspawnpos[ 2 ] >= z_min && newspawnpos[ 2 ] <= z_max;
        
        if ( var_1dce2d1958040081 < rad_sq && var_f66aff855fc46c7d )
        {
            if ( isdefined( blockerstruct.offset ) && isvector( blockerstruct.offset ) )
            {
                newspawnpos += blockerstruct.offset;
                var_db2f3eee59030225 = 1;
            }
            else
            {
                newspawnpos += ( 0, 0, -6 );
                var_db2f3eee59030225 = 1;
            }
            
            if ( istrue( blockerstruct.var_36be730ee498727c ) )
            {
                var_140b9fa52f1f56c = 0;
            }
        }
    }
    
    return [ newspawnpos, var_140b9fa52f1f56c ];
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 4
// Checksum 0x0, Offset: 0x1b4a
// Size: 0x17d
function tac_cover_adjust_for_player_space( spawnpos, spawnangles, contents, var_140b9fa52f1f56c )
{
    newspawnpos = spawnpos;
    var_140b9fa52f1f56c = 1;
    var_db2f3eee59030225 = 0;
    
    if ( false )
    {
        foreach ( trigger in level.taccovertriggerblockers )
        {
            if ( istrue( var_db2f3eee59030225 ) )
            {
                continue;
            }
            
            if ( ispointinvolume( newspawnpos + ( 0, 0, 20 ), trigger ) )
            {
                newspawnpos += ( 0, 0, -6 );
                var_db2f3eee59030225 = 1;
                break;
            }
        }
    }
    
    if ( true )
    {
        var_e62b2bee781878ab = function_1d1bf10a8da86b91( newspawnpos );
        newspawnpos = var_e62b2bee781878ab[ 0 ];
        var_140b9fa52f1f56c = var_e62b2bee781878ab[ 1 ];
    }
    
    frontspace = tac_cover_get_free_space( 1, newspawnpos, spawnangles, contents, 32 );
    
    if ( !isdefined( frontspace ) )
    {
        return [ newspawnpos, var_140b9fa52f1f56c ];
    }
    
    backspace = tac_cover_get_free_space( 0, newspawnpos, spawnangles, contents, 32 );
    
    if ( !isdefined( backspace ) )
    {
        return [ newspawnpos, var_140b9fa52f1f56c ];
    }
    
    var_9b7c59cbac03bd88 = min( frontspace, 15 );
    forwarddir = anglestoforward( spawnangles );
    newspawnpos += forwarddir * var_9b7c59cbac03bd88;
    return [ newspawnpos, var_140b9fa52f1f56c ];
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 5
// Checksum 0x0, Offset: 0x1cd0
// Size: 0x257
function tac_cover_get_free_space( isfrontcheck, spawnpos, spawnangles, contents, maxcheckdist )
{
    leftdir = anglestoleft( spawnangles );
    forwarddir = anglestoforward( spawnangles );
    backwarddir = -1 * forwarddir;
    endoffset = undefined;
    
    if ( isfrontcheck )
    {
        endoffset = forwarddir * maxcheckdist;
    }
    else
    {
        endoffset = backwarddir * maxcheckdist;
    }
    
    topcenterpos = spawnpos + ( 0, 0, 48 );
    start = topcenterpos;
    end = topcenterpos + endoffset;
    radius = 2.5;
    halfheight = 29 + maxcheckdist;
    angles = combineangles( spawnangles, ( 0, 0, 90 ) );
    contents = contents;
    ignorelist = [ self ];
    collectiontype = "physicsquery_closest";
    results = physics_capsulecast( start, end, radius, halfheight, angles, contents, ignorelist, collectiontype );
    isclear = results.size == 0;
    
    /#
        if ( getdvarint( @"hash_a5a0ca488a1da730", 0 ) )
        {
            hasanyspace = isclear || results[ 0 ][ "<dev string:x3e>" ] > 0;
            colorstart = ter_op( hasanyspace, ( 0, 1, 0 ), ( 1, 0, 0 ) );
            colorend = ter_op( isclear, ( 0, 1, 0 ), ( 1, 0, 0 ) );
            topleftpos = topcenterpos + leftdir * ( 29 + maxcheckdist );
            drawstart = topleftpos;
            drawend = topleftpos + endoffset;
            draw_capsule( drawstart, radius, halfheight * 2, angles, colorstart, 0, 500 );
            draw_capsule( drawend, radius, halfheight * 2, angles, colorend, 0, 500 );
        }
    #/
    
    if ( isclear )
    {
        return undefined;
    }
    
    shapepos = results[ 0 ][ "shape_position" ];
    dist = distance( shapepos, topcenterpos );
    return dist;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x1f30
// Size: 0x93, Type: bool
function tac_cover_blocked_by_turret( targetpos )
{
    if ( isdefined( level.turrets ) )
    {
        foreach ( turret in level.turrets )
        {
            if ( !isdefined( turret ) )
            {
                continue;
            }
            
            distsqrd = distancesquared( turret.origin, targetpos );
            
            if ( 6400 >= distsqrd )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x1fcc
// Size: 0x65
function tac_cover_fire_failed( isdoorblocked )
{
    errormessage = ter_op( istrue( isdoorblocked ), "MP/TAC_COVER_PLACE_IN_DOORWAY", "MP/TAC_COVER_CANNOT_PLACE" );
    
    if ( scripts\engine\utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
    {
        self [[ scripts\engine\utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( errormessage );
    }
    
    self playsoundtoplayer( "iw9_deployable_cover_plant_fail", self );
    function_dba0e6107f51d41e();
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x2039
// Size: 0x26
function function_dba0e6107f51d41e()
{
    if ( scripts\mp\equipment::hasequipment( "equip_tac_cover" ) )
    {
        scripts\mp\equipment::incrementequipmentammo( "equip_tac_cover", 1 );
        thread function_cd0c066b3516bcb0();
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x2067
// Size: 0x43
function function_cd0c066b3516bcb0()
{
    self endon( "death_or_disconnect" );
    self notify( "refreshed_tac_cover_ammo" );
    self endon( "refreshed_tac_cover_ammo" );
    level endon( "game_ended" );
    self waittill( "tac_cover_finalized_spawn" );
    
    if ( scripts\mp\equipment::hasequipment( "equip_tac_cover" ) )
    {
        scripts\mp\equipment::decrementequipmentammo( "equip_tac_cover", 1 );
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x20b2
// Size: 0xb
function tac_cover_entmanagerdelete()
{
    thread tac_cover_delete( 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 4
// Checksum 0x0, Offset: 0x20c5
// Size: 0x17f
function tac_cover_spawn_with_door( door, doubledoor, issuper, contents )
{
    self endon( "death_or_disconnect" );
    self endon( "tac_cover_taken" );
    level endon( "game_ended" );
    assert( isdefined( door ), "<dev string:x4a>" );
    playerforward = anglestoforward( self.angles );
    var_71ed5ba14eaae576 = door function_bacd2d0acdf8559e() + ( 0, 90, 0 );
    doorforward = anglestoforward( var_71ed5ba14eaae576 );
    var_5ac08dec36d1218b = vectordot( playerforward, doorforward );
    issamedirection = var_5ac08dec36d1218b > 0;
    doordegrees = door scriptabledoorangle();
    door val::set( "tac_cover_door", "door_frozen", 1 );
    
    if ( isdefined( doubledoor ) )
    {
        doubledoor val::set( "tac_cover_door", "door_frozen", 1 );
    }
    
    offsetangles = ter_op( issamedirection, ( 0, 90, 0 ), ( 0, -90, 0 ) );
    offsetpos = ( 0, 0, -1 );
    doorpos = door function_d90515f5e17dbc6f() + offsetpos;
    doorangles = combineangles( door function_bacd2d0acdf8559e(), offsetangles );
    var_7422d61f3592ac6e = undefined;
    tac_cover_spawn( doorpos, doorangles, var_7422d61f3592ac6e, issuper, contents, door, doubledoor );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x224c
// Size: 0x15
function function_49197cd063a740ea( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 7
// Checksum 0x0, Offset: 0x2269
// Size: 0x4e0
function tac_cover_spawn( position, angles, stuckto, issuper, contents, door, doubledoor )
{
    self endon( "death_or_disconnect" );
    self endon( "tac_cover_taken" );
    level endon( "game_ended" );
    wait 0.05;
    adjustreturn = tac_cover_adjust_for_player_space( position, angles, contents );
    issuper = istrue( issuper );
    
    if ( !istrue( adjustreturn[ 1 ] ) )
    {
        tac_cover_fire_failed( 0 );
        
        if ( issuper )
        {
            scripts\mp\supers::refundsuper();
        }
        
        return 0;
    }
    
    position = adjustreturn[ 0 ];
    self notify( "tac_cover_spawned" );
    cover = spawn( "script_model", position );
    cover.angles = angles;
    cover.owner = self;
    cover.team = self.team;
    cover.slot = scripts\mp\equipment::findequipmentslot( "equip_tac_cover" );
    cover.exploding = 1;
    cover.issuper = ter_op( issuper, 1, undefined );
    cover.superid = level.superglobals.staticsuperdata[ "super_tac_cover" ].id;
    
    if ( isdefined( level.var_ca4e08767cbdae12 ) )
    {
        canplant = cover [[ level.var_ca4e08767cbdae12 ]]();
        
        if ( !canplant )
        {
            tac_cover_fire_failed();
            cover delete();
            
            if ( issuper )
            {
                scripts\mp\supers::refundsuper();
            }
            
            return 0;
        }
    }
    
    cover scripts\cp_mp\ent_manager::registerspawn( 2, &tac_cover_entmanagerdelete );
    superinfo = undefined;
    superbundle = undefined;
    model_name = undefined;
    
    if ( utility::issharedfuncdefined( "player", "getCurrentSuper" ) )
    {
        superinfo = self [[ utility::getsharedfunc( "player", "getCurrentSuper" ) ]]();
        superbundle = superinfo.staticdata.bundle;
    }
    
    if ( isdefined( superbundle ) && level.allowsupers )
    {
        model_name = function_9bd2d235e27d5068( superbundle, superinfo.blueprintindex );
    }
    
    if ( !isdefined( model_name ) )
    {
        model_name = "projectile_deployable_cover_opened_v0";
    }
    
    cover setentityowner( self );
    cover setotherent( self );
    cover setmodel( model_name );
    cover setscriptablepartstate( "allowPing", "on", 0 );
    
    if ( isdefined( stuckto ) )
    {
        cover.moving_platform = stuckto;
        stuckto.var_62cb9a984b1adf71 = function_6d6af8144a5131f1( stuckto.var_62cb9a984b1adf71, cover );
        data = spawnstruct();
        data.linkparent = cover.moving_platform;
        data.deathoverridecallback = &tac_cover_on_destroyed_by_mover;
        data.validateaccuratetouching = 1;
        cover thread scripts\mp\movers::handle_moving_platforms( data );
        cover thread tac_cover_destroy_on_unstuck();
    }
    else if ( isdefined( level.wztrain_info ) )
    {
        data = spawnstruct();
        data.deathoverridecallback = &tac_cover_on_destroyed_by_mover;
        cover thread scripts\mp\movers::handle_moving_platforms( data );
    }
    
    collision = tac_cover_spawn_collision( cover );
    cover validatecollision( collision, level.taccovercollision );
    cover.collision = collision;
    collision.cover = cover;
    collision.moverdoesnotkill = 1;
    
    if ( isdefined( door ) )
    {
        if ( isdefined( door.blockingcover ) )
        {
            door.blockingcover tac_cover_destroy();
        }
        
        cover.blockeddoor = door;
        door.blockingcover = cover;
    }
    
    if ( isdefined( doubledoor ) )
    {
        cover.blockeddoubledoor = doubledoor;
        doubledoor.blockingcover = cover;
    }
    
    scripts\mp\weapons::onequipmentplanted( cover, "equip_tac_cover", &tac_cover_destroy );
    thread scripts\mp\weapons::monitordisownedequipment( self, cover );
    
    if ( issuper )
    {
        cover thread tac_cover_destroy_on_disowned( self );
        cover thread tac_cover_destroy_on_timeout();
        cover thread function_f6464070871bdd33( self );
    }
    
    cover function_49197cd063a740ea( &tac_cover_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread scripts\common\elevators::deployablecover_isentitytouchingdoortrigger( cover );
        }
    }
    
    cover thread tac_cover_destroy_on_game_end();
    thread tac_cover_spawn_internal( cover );
    thread outlineequipmentforowner( cover );
    cover thread scripts\mp\perks\perk_equipmentping::runequipmentping();
    scripts\cp_mp\challenges::function_d997435895422ecc( "super_deployed_decoy", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
    self notify( "tac_cover_finalized_spawn" );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x2751
// Size: 0xa2
function tac_cover_spawn_internal( cover )
{
    cover endon( "death" );
    
    if ( false )
    {
        cover tac_cover_set_can_damage( 1 );
    }
    
    if ( isdefined( cover.blockeddoor ) )
    {
        cover setscriptablepartstate( "effects", "plantStartDoor", 0 );
    }
    else
    {
        cover setscriptablepartstate( "effects", "plantStart", 0 );
    }
    
    wait tac_cover_get_deploy_anim_dur();
    
    if ( true )
    {
        cover tac_cover_set_can_damage( 1 );
    }
    
    if ( isdefined( cover.blockeddoor ) )
    {
        cover setscriptablepartstate( "effects", "plantEndDoor", 0 );
        return;
    }
    
    cover setscriptablepartstate( "effects", "plantEnd", 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x27fb
// Size: 0xf8
function tac_cover_spawn_collision( cover )
{
    if ( !isdefined( level.taccovercollision ) )
    {
        return;
    }
    
    collision = spawn( "script_model", cover.origin );
    collision dontinterpolate();
    collision.angles = cover.angles;
    collision clonebrushmodeltoscriptmodel( level.taccovercollision );
    collision linkto( cover );
    collision setentityowner( cover );
    collision disconnectpaths();
    coverdir = anglestoforward( cover.angles );
    var_25e38c6ed49771e3 = cover.origin + coverdir * 25;
    var_25e38d6ed4977416 = cover.origin + coverdir * -25;
    createnavlink( "tacCover1", var_25e38c6ed49771e3, var_25e38d6ed4977416, "traverse_warp_across", 1920 );
    createnavlink( "tacCover2", var_25e38d6ed4977416, var_25e38c6ed49771e3, "traverse_warp_across", 1920 );
    return collision;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 3
// Checksum 0x0, Offset: 0x28fc
// Size: 0x186
function tac_cover_destroy( immediate, wasdestroyed, killedbyexplosive )
{
    if ( !isdefined( killedbyexplosive ) )
    {
        killedbyexplosive = 0;
    }
    
    deletiondelay = 0;
    
    if ( !istrue( immediate ) )
    {
        deletiondelay = 0.2 + tac_cover_get_destroy_anim_dur();
    }
    
    dmg = self.maxhealth;
    
    if ( isdefined( self.damagetaken ) && self.damagetaken < self.maxhealth )
    {
        dmg = self.damagetaken;
    }
    
    if ( !isdefined( dmg ) )
    {
        dmg = 1250;
    }
    
    self.owner scripts\cp_mp\challenges::function_d997435895422ecc( "super_deployed_decoy", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"end" ), int( dmg ) );
    scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, int( dmg ), istrue( wasdestroyed ) );
    
    if ( isdefined( self.moving_platform ) )
    {
        index = array_find( self.moving_platform.var_62cb9a984b1adf71, self );
        
        if ( isdefined( index ) )
        {
            self.moving_platform.var_62cb9a984b1adf71 = array_remove( self.moving_platform.var_62cb9a984b1adf71, self );
            
            if ( self.moving_platform.var_62cb9a984b1adf71.size == 0 )
            {
                self.moving_platform.var_62cb9a984b1adf71 = undefined;
            }
        }
    }
    
    thread tac_cover_destroy_internal( deletiondelay, killedbyexplosive );
    thread tac_cover_delete( deletiondelay );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 2
// Checksum 0x0, Offset: 0x2a8a
// Size: 0x12c
function tac_cover_destroy_internal( deletiondelay, killedbyexplosive )
{
    if ( !isdefined( killedbyexplosive ) )
    {
        killedbyexplosive = 0;
    }
    
    if ( isdefined( self.blockeddoor ) )
    {
        self.blockeddoor val::reset_all( "tac_cover_door" );
        self.blockeddoor.blockingcover = undefined;
    }
    
    if ( isdefined( self.blockeddoubledoor ) )
    {
        self.blockeddoubledoor val::reset_all( "tac_cover_door" );
        self.blockeddoubledoor.blockingcover = undefined;
    }
    
    if ( deletiondelay > 0 )
    {
        if ( istrue( killedbyexplosive >= 1 ) )
        {
            if ( killedbyexplosive == 1 )
            {
                self setscriptablepartstate( "effects", "destroyStartExplosive" );
            }
            else
            {
                self setscriptablepartstate( "effects", "destroyStartExplosiveBehind" );
            }
        }
        else
        {
            self setscriptablepartstate( "effects", "destroyStart" );
        }
        
        wait tac_cover_get_destroy_anim_dur();
        self setscriptablepartstate( "effects", "destroyEnd" );
    }
    
    if ( isdefined( self.collision ) )
    {
        self.collision connectpaths();
        self.collision delete();
    }
    
    destroynavlink( "tacCover1" );
    destroynavlink( "tacCover2" );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x2bbe
// Size: 0xa6
function tac_cover_delete( deletiondelay )
{
    if ( istrue( self.isdestroyed ) )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self notify( "death" );
    level.mines[ self getentitynumber() ] = undefined;
    owner = self.owner;
    
    if ( isdefined( owner ) )
    {
        owner scripts\mp\weapons::removeequip( self );
    }
    
    if ( true )
    {
        scripts\mp\damage::monitordamageend();
        self thermaldrawdisable();
    }
    
    if ( isdefined( self.collision ) )
    {
        self.collision connectpaths();
        self.collision delete();
    }
    
    wait deletiondelay;
    self delete();
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x2c6c
// Size: 0x1d
function tac_cover_destroy_on_timeout()
{
    self endon( "death" );
    wait level.taccover_timeout;
    tac_cover_destroy( undefined, 0, 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x2c91
// Size: 0x1b
function tac_cover_destroy_on_game_end()
{
    self endon( "death" );
    level waittill( "game_ended" );
    tac_cover_destroy( undefined, 0, 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x2cb4
// Size: 0x21
function tac_cover_destroy_on_unstuck()
{
    self endon( "death" );
    
    while ( isdefined( self getlinkedparent() ) )
    {
        waitframe();
    }
    
    tac_cover_destroy( undefined, 0, 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x2cdd
// Size: 0x7e
function tac_cover_set_can_damage( bool )
{
    if ( true )
    {
        if ( bool )
        {
            var_307667d0142f2035 = _hasperk( "specialty_rugged_eqp" );
            maxhealth = ter_op( var_307667d0142f2035, 1250, 1000 );
            damagefeedback = "hitequip";
            thread scripts\mp\damage::monitordamage( maxhealth, damagefeedback, &tac_cover_handle_fatal_damage, &tac_cover_handle_damage, 0 );
            self thermaldrawenable();
            return;
        }
        
        scripts\mp\damage::monitordamageend();
        self thermaldrawdisable();
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x2d63
// Size: 0x109
function tac_cover_handle_damage( data )
{
    damage = tac_cover_adjust_damage( data );
    
    if ( isdefined( self.owner ) )
    {
        remaininghealth = max( self.maxhealth - self.damagetaken, 0 );
        var_c738e38fa087114b = int( min( remaininghealth, damage ) );
        self.owner scripts\mp\supers::combatrecordsupermisc( "super_tac_cover", var_c738e38fa087114b );
        blockscoreevent = istrue( level.var_f3be3f9bad33bf87 ) && istrue( self.var_135e1c9614ac0dd0 );
        
        if ( data.attacker != self.owner && data.attacker.team != self.owner.team && !blockscoreevent )
        {
            self.var_135e1c9614ac0dd0 = 1;
            self.owner namespace_a850435086c88de3::doonactionscoreevent( 1, "tacCoverShot" );
        }
    }
    
    return damage;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x2e75
// Size: 0x218
function tac_cover_adjust_damage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    damage = data.damage;
    pos = data.point;
    
    if ( objweapon.basename == "thermite_av_mp" )
    {
        return 200;
    }
    
    if ( scripts\mp\damage::issmallsplashdamage( data.objweapon ) )
    {
        return 0;
    }
    
    if ( objweapon.basename == "thermite_bolt_mp" )
    {
        return 83.3333;
    }
    
    if ( objweapon.basename == "thermite_xmike109_mp" )
    {
        return 62.5;
    }
    
    if ( isthrowingknife( objweapon.basename ) || isthrowingstar( objweapon.basename ) )
    {
        return 0;
    }
    
    if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_IMPACT" )
    {
        if ( meansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade" )
        {
            return damage;
        }
        
        return 333.333;
    }
    
    if ( objweapon.basename == "iw9_dm_crossbow_mp" && meansofdeath != "MOD_MELEE" )
    {
        return 0;
    }
    
    if ( meansofdeath == "MOD_CRUSH" && isdefined( data.inflictor ) && data.inflictor.classname == "script_vehicle" )
    {
        if ( isdefined( attacker ) && !scripts\mp\weapons::friendlyfirecheck( self.owner, attacker ) )
        {
            return damage;
        }
    }
    
    if ( isexplosivedamagemod( data.meansofdeath ) )
    {
        if ( objweapon.basename == "semtex_xmike109_mp" )
        {
            return 333.333;
        }
        
        if ( objweapon.basename == "emp_grenade_mp" )
        {
            return 1;
        }
        
        return 700;
    }
    
    damage = scripts\mp\damage::handleapdamage( objweapon, meansofdeath, damage, attacker );
    damage = scripts\mp\damage::handleshotgundamage( objweapon, meansofdeath, damage );
    return damage;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x3096
// Size: 0x101
function tac_cover_handle_fatal_damage( data )
{
    attacker = data.attacker;
    killedbyexplosive = 0;
    
    if ( istrue( data.meansofdeath == "MOD_EXPLOSIVE" ) )
    {
        killedbyexplosive = 1;
        var_7c5c3c06d620979 = anglestoforward( self.angles );
        var_7c5c3c06d620979 = vectornormalize( var_7c5c3c06d620979 );
        var_6e86a25a741e3a50 = vectortoangles( self.origin - data.point );
        var_6e86a25a741e3a50 = anglestoforward( var_6e86a25a741e3a50 );
        var_6e86a25a741e3a50 = vectornormalize( var_6e86a25a741e3a50 );
        var_eb513a01b5c89a61 = vectordot( var_7c5c3c06d620979, var_6e86a25a741e3a50 );
        
        if ( var_eb513a01b5c89a61 >= 0 )
        {
            killedbyexplosive = 2;
        }
    }
    
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread scripts\mp\utility\points::doscoreevent( #"destroyed_equipment" );
        attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy( #"bc_fieldupgrade_killfirm_deployablecover" );
    }
    
    thread tac_cover_destroy( undefined, 1, killedbyexplosive );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x319f
// Size: 0x85
function tac_cover_deploy_freeze_controls()
{
    if ( !isdefined( self.taccoverfrozecontrols ) )
    {
        slot = scripts\mp\equipment::findequipmentslot( "equip_tac_cover" );
        
        if ( slot == "primary" )
        {
            val::set( "tac_cover_deploy", "equipment_primary", 0 );
        }
        else
        {
            val::set( "tac_cover_deploy", "equipment_secondary", 0 );
        }
        
        val::set( "tac_cover_deploy", "usability", 0 );
        val::set( "tac_cover_deploy", "gesture", 0 );
        self.taccoverfrozecontrols = slot;
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x322c
// Size: 0x3a
function tac_cover_deploy_unfreeze_controls()
{
    if ( isdefined( self.taccoverfrozecontrols ) )
    {
        slot = self.taccoverfrozecontrols;
        val::reset_all( "tac_cover_deploy" );
        self.taccoverfrozecontrols = undefined;
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x326e
// Size: 0x164
function tac_cover_ignore_list( player )
{
    ignorelist = [ player ];
    scripts\cp_mp\utility\game_utility::function_9ed62e98a39d59eb();
    
    foreach ( array in level.smallprojectilepartition function_df633f460888a47( player.origin ) )
    {
        foreach ( projectile in array )
        {
            if ( !isdefined( projectile ) )
            {
                continue;
            }
            
            isowner = isdefined( projectile.owner ) && projectile.owner == player;
            istaccover = isdefined( projectile.equipmentref ) && projectile.equipmentref == "equip_tac_cover";
            isweapondrop = isdefined( projectile.equipmentref ) && projectile.equipmentref == "equip_ammo_box";
            
            if ( !isowner && ( istaccover || isweapondrop ) )
            {
                continue;
            }
            
            ignorelist[ ignorelist.size ] = projectile;
        }
    }
    
    return ignorelist;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x33db
// Size: 0xaa, Type: bool
function tac_cover_can_place_on( ent )
{
    if ( isplayer( ent ) )
    {
        return false;
    }
    
    if ( ent getnonstick() )
    {
        return false;
    }
    
    if ( istrue( ent.mountmantlemodel ) )
    {
        return false;
    }
    
    if ( isdefined( ent.cover ) && isdefined( ent.cover.equipmentref ) && ent.cover.equipmentref == "equip_tac_cover" )
    {
        return false;
    }
    
    if ( ent.classname == "misc_turret" )
    {
        return false;
    }
    
    if ( ent.classname == "script_vehicle" )
    {
        return false;
    }
    
    return true;
}

#using_animtree( "scriptables" );

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x348e
// Size: 0x10
function tac_cover_get_deploy_anim_dur()
{
    return getanimlength( %wm_spawn_2h_deployable_cover_fire );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x34a7
// Size: 0x3, Type: bool
function tac_cover_get_destroy_anim_dur()
{
    return false;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x34b3
// Size: 0xd, Type: bool
function tac_cover_on_fired_super()
{
    return tac_cover_on_fired( undefined, undefined, undefined, 1 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 0
// Checksum 0x0, Offset: 0x34c9
// Size: 0xd
function tac_cover_on_take_super()
{
    tac_cover_on_take( undefined, undefined, 1 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x34de
// Size: 0x36
function tac_cover_destroy_on_disowned( owner )
{
    self endon( "death" );
    owner endon( "tac_cover_taken" );
    owner waittill_any_2( "joined_team", "disconnect" );
    thread tac_cover_destroy( undefined, 0, 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x351c
// Size: 0x3a
function function_f6464070871bdd33( owner )
{
    self endon( "death" );
    owner endon( "tac_cover_taken" );
    owner endon( "joined_team" );
    owner endon( "disconnect" );
    owner waittill( "tac_cover_spawned" );
    thread tac_cover_destroy( undefined, 0, 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x355e
// Size: 0x15
function tac_cover_on_destroyed_by_mover( data )
{
    tac_cover_destroy( undefined, 0, 0 );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x357b
// Size: 0xbf
function private function_f6491690fe2fa94e( blockerorigin, blockerrad, blockerheight, blockeroffset, var_36be730ee498727c )
{
    if ( !isdefined( level.var_f73654528e070ab4 ) )
    {
        level.var_f73654528e070ab4 = [];
    }
    
    outblocker = spawnstruct();
    outblocker.targetname = "dcover_blocker_struct";
    outblocker.origin = blockerorigin;
    outblocker.radius = blockerrad;
    outblocker.height = blockerheight;
    outblocker.offset = ( 0, 0, blockeroffset );
    outblocker.var_36be730ee498727c = var_36be730ee498727c;
    level.var_f73654528e070ab4[ level.var_f73654528e070ab4.size ] = outblocker;
    return outblocker;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3643
// Size: 0x26
function private function_8126f259bbf1a7ed( blockerorigin )
{
    outblocker = function_f6491690fe2fa94e( blockerorigin, 80, 96, -6, undefined );
    return outblocker;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3672
// Size: 0x26
function private function_65fde24ce2bc91e9( blockerorigin )
{
    outblocker = function_f6491690fe2fa94e( blockerorigin, 140, 96, -6, undefined );
    return outblocker;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x36a1
// Size: 0xe1
function private function_b8ffeacf84a9d34e( var_5c4e2a948c4617a4 )
{
    assertex( isdefined( var_5c4e2a948c4617a4.targetname ) && var_5c4e2a948c4617a4.targetname == "<dev string:x68>", "<dev string:x81>" );
    assertex( isdefined( var_5c4e2a948c4617a4.origin ) && isvector( var_5c4e2a948c4617a4.origin ), "<dev string:xc6>" );
    assertex( isdefined( var_5c4e2a948c4617a4.radius ) && isnumber( var_5c4e2a948c4617a4.radius ), "<dev string:x11d>" );
    assertex( isdefined( var_5c4e2a948c4617a4.height ) && isnumber( var_5c4e2a948c4617a4.height ), "<dev string:x174>" );
    
    if ( !isdefined( var_5c4e2a948c4617a4.offset ) )
    {
        var_5c4e2a948c4617a4.offset = -6;
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 2
// Checksum 0x0, Offset: 0x378a
// Size: 0x67
function function_c5d3d6e10bd8c8ab( fixuporigin, var_cae297d0690cc359 )
{
    switch ( var_cae297d0690cc359 )
    {
        case 0:
            function_8126f259bbf1a7ed( fixuporigin );
            break;
        case 1:
            function_65fde24ce2bc91e9( fixuporigin );
            break;
        default:
            assertmsg( "<dev string:x1cb>" );
            break;
    }
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x37f9
// Size: 0x57
function function_85555e609b23b2be( var_cae297d0690cc359 )
{
    outrad = undefined;
    
    switch ( var_cae297d0690cc359 )
    {
        case 0:
            outrad = 80;
            break;
        case 1:
            outrad = 140;
            break;
        default:
            break;
    }
    
    return outrad;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 5
// Checksum 0x0, Offset: 0x3859
// Size: 0x69
function function_f41f835b1ab9dbd8( blockerorigin, blockerrad, blockerheight, blockeroffset, var_36be730ee498727c )
{
    assertex( isdefined( blockerorigin ), "<dev string:x217>" );
    assertex( isdefined( blockerrad ), "<dev string:x264>" );
    
    if ( !isdefined( blockerheight ) )
    {
        blockerheight = 96;
    }
    
    if ( !isdefined( blockeroffset ) )
    {
        blockeroffset = -6;
    }
    
    scripts\mp\equipment\tactical_cover::function_f6491690fe2fa94e( blockerorigin, blockerrad, blockerheight, blockeroffset, var_36be730ee498727c );
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x38ca
// Size: 0x87, Type: bool
function function_9461775d71e495cf( targetpos )
{
    if ( 0 || !isdefined( level.var_b6a3186c09d2dd34 ) )
    {
        return false;
    }
    
    foreach ( invalidtrigger in level.var_b6a3186c09d2dd34 )
    {
        if ( ispointinvolume( targetpos + ( 0, 0, 8 ), invalidtrigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x395a
// Size: 0x87, Type: bool
function function_ac29e794c919fe03( targetpos )
{
    if ( 0 || !isdefined( level.var_57b13482577dd10 ) )
    {
        return false;
    }
    
    foreach ( invalidvolume in level.var_57b13482577dd10 )
    {
        if ( ispointinvolume( targetpos + ( 0, 0, 8 ), invalidvolume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 1
// Checksum 0x0, Offset: 0x39ea
// Size: 0x11e, Type: bool
function function_6cc8838979f47b9f( targetpos )
{
    if ( 0 || !isdefined( level.var_ca0420748e3190ed ) )
    {
        return false;
    }
    
    foreach ( invalidstruct in level.var_ca0420748e3190ed )
    {
        var_c114ecfa39e69379 = squared( 32 );
        
        if ( isdefined( invalidstruct.radius ) )
        {
            var_c114ecfa39e69379 = squared( invalidstruct.radius );
        }
        
        zmin = invalidstruct.origin[ 2 ] - 8;
        zmax = zmin + ter_op( isdefined( invalidstruct.height ), invalidstruct.height, 96 );
        var_f66aff855fc46c7d = targetpos[ 2 ] >= zmin && targetpos[ 2 ] <= zmax;
        
        if ( distance_2d_squared( invalidstruct.origin, targetpos ) < var_c114ecfa39e69379 && var_f66aff855fc46c7d )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 3
// Checksum 0x0, Offset: 0x3b11
// Size: 0x98
function function_d147e0986e29dd8d( org, rad, height )
{
    if ( false )
    {
        return 0;
    }
    
    if ( !isdefined( level.var_ca0420748e3190ed ) )
    {
        level.var_ca0420748e3190ed = [];
    }
    
    invalidstruct = spawnstruct();
    invalidstruct.targetname = "dcover_invalid_struct";
    invalidstruct.origin = org;
    invalidstruct.radius = rad;
    invalidstruct.height = height;
    level.var_ca0420748e3190ed[ level.var_ca0420748e3190ed.size ] = invalidstruct;
    return invalidstruct;
}

// Namespace tactical_cover / scripts\mp\equipment\tactical_cover
// Params 2
// Checksum 0x0, Offset: 0x3bb2
// Size: 0xfd
function function_9bd2d235e27d5068( bundle, blueprintindex )
{
    genericblueprintname = undefined;
    model_name = undefined;
    
    if ( isdefined( bundle.genericblueprintlist.blueprints ) && bundle.genericblueprintlist.blueprints.size > 0 && isdefined( blueprintindex ) && blueprintindex > 0 )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprints[ blueprintindex - 1 ].genericblueprint;
        model_name = function_29e16a88682086b2( genericblueprintname, #"xmodel", #"worldmodel" );
    }
    else if ( isdefined( bundle.genericblueprintlist.blueprint_default ) )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprint_default;
        model_name = function_29e16a88682086b2( genericblueprintname, #"xmodel", #"worldmodel" );
    }
    
    return model_name;
}

