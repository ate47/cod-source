#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\player;

#namespace entity;

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x3d6
// Size: 0xcb
function getaverageorigin( ent_array )
{
    avg_origin = ( 0, 0, 0 );
    
    if ( !ent_array.size )
    {
        return undefined;
    }
    
    foreach ( ent in ent_array )
    {
        avg_origin += ent.origin;
    }
    
    avg_x = int( avg_origin[ 0 ] / ent_array.size );
    avg_y = int( avg_origin[ 1 ] / ent_array.size );
    avg_z = int( avg_origin[ 2 ] / ent_array.size );
    avg_origin = ( avg_x, avg_y, avg_z );
    return avg_origin;
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x4aa
// Size: 0xce, Type: bool
function touchingbadtrigger()
{
    killtriggers = getentarray( "trigger_hurt", "classname" );
    
    foreach ( trigger in killtriggers )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    radtriggers = getentarray( "radiation", "targetname" );
    
    foreach ( trigger in radtriggers )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x581
// Size: 0x7a, Type: bool
function touchingoobtrigger()
{
    if ( istrue( self.allowedintrigger ) )
    {
        return false;
    }
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return false;
    }
    
    foreach ( trigger in level.outofboundstriggers )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x604
// Size: 0x81, Type: bool
function touchingballallowedtrigger()
{
    if ( !istrue( level.ballallowedtriggers.size ) )
    {
        return false;
    }
    
    self.allowedintrigger = 0;
    
    foreach ( trigger in level.ballallowedtriggers )
    {
        if ( self istouching( trigger ) )
        {
            self.allowedintrigger = 1;
            return true;
        }
    }
    
    return false;
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x68e
// Size: 0x81, Type: bool
function touchingplayerallowedtrigger()
{
    if ( !istrue( level.playerallowedtriggers.size ) )
    {
        return false;
    }
    
    self.allowedintrigger = 0;
    
    foreach ( trigger in level.playerallowedtriggers )
    {
        if ( self istouching( trigger ) )
        {
            self.allowedintrigger = 1;
            return true;
        }
    }
    
    return false;
}

// Namespace entity / scripts\mp\utility\entity
// Params 3
// Checksum 0x0, Offset: 0x718
// Size: 0xb9
function findisfacing( ent1, ent2, tolerance )
{
    facingcosine = cos( tolerance );
    ent1forwardvector = anglestoforward( ent1.angles );
    var_39166b57b87f75d = ent2.origin - ent1.origin;
    ent1forwardvector *= ( 1, 1, 0 );
    var_39166b57b87f75d *= ( 1, 1, 0 );
    var_39166b57b87f75d = vectornormalize( var_39166b57b87f75d );
    ent1forwardvector = vectornormalize( ent1forwardvector );
    targetcosine = vectordot( var_39166b57b87f75d, ent1forwardvector );
    
    if ( targetcosine >= facingcosine )
    {
        return 1;
    }
    
    return 0;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x7d9
// Size: 0x36, Type: bool
function isaiteamparticipant( ent )
{
    if ( isagent( ent ) && ent.agent_teamparticipant == 1 )
    {
        return true;
    }
    
    if ( isbot( ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x818
// Size: 0x25, Type: bool
function isteamparticipant( ent )
{
    if ( isaiteamparticipant( ent ) )
    {
        return true;
    }
    
    if ( isplayer( ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace entity / scripts\mp\utility\entity
// Params 3
// Checksum 0x0, Offset: 0x846
// Size: 0x38, Type: bool
function isvalidteamtarget( attacker, victimteam, target )
{
    return isdefined( target.team ) && target.team == victimteam;
}

// Namespace entity / scripts\mp\utility\entity
// Params 3
// Checksum 0x0, Offset: 0x887
// Size: 0x1d, Type: bool
function isvalidffatarget( attacker, victimteam, target )
{
    return true;
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x8ad
// Size: 0x74
function getlinknamenodes()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = strtok( self.script_linkto, " " );
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            ent = getnode( linknames[ i ], "script_linkname" );
            
            if ( isdefined( ent ) )
            {
                array[ array.size ] = ent;
            }
        }
    }
    
    return array;
}

// Namespace entity / scripts\mp\utility\entity
// Params 4
// Checksum 0x0, Offset: 0x92a
// Size: 0x33
function function_d9ce8fb00f0e5fa1( origin, radius, desiredteam, excludeent )
{
    return getentitiesinradius( origin, radius, desiredteam, excludeent, scripts\engine\trace::create_character_contents() );
}

// Namespace entity / scripts\mp\utility\entity
// Params 5
// Checksum 0x0, Offset: 0x966
// Size: 0x20b
function getentitiesinradius( origin, radius, desiredteam, excludeent, physicscontents )
{
    if ( radius <= 0 )
    {
        return [];
    }
    
    excludearray = undefined;
    
    if ( isdefined( excludeent ) )
    {
        if ( isarray( excludeent ) )
        {
            excludearray = excludeent;
        }
        else
        {
            excludearray = [ excludeent ];
        }
    }
    
    results = physics_querypoint( origin, radius, physicscontents, excludearray, "physicsquery_all" );
    filteredresults = [];
    
    if ( !isdefined( desiredteam ) )
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            
            if ( isdefined( e ) )
            {
                filteredresults[ filteredresults.size ] = e;
            }
        }
    }
    else
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            
            if ( isdefined( e ) && isdefined( e.team ) && e.team == desiredteam )
            {
                filteredresults[ filteredresults.size ] = e;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_9bb67ce9f0ab24e0", 0 ) > 0 )
        {
            debugduration = 60;
            sphere( origin, radius, ( 1, 1, 1 ), 0, debugduration );
            
            foreach ( entity in filteredresults )
            {
                sphere( entity.origin, 10, ( 1, 0, 0 ), 1, debugduration );
            }
        }
    #/
    
    return filteredresults;
}

// Namespace entity / scripts\mp\utility\entity
// Params 5
// Checksum 0x0, Offset: 0xb7a
// Size: 0x17f
function watchentitiesinradius( radiusrange, triggernotify, var_ecea6cda97e5f7ae, checkvisibility, playersonly )
{
    self endon( "disconnect" );
    self endon( "end_entities_in_radius" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        entitiesfound = undefined;
        
        if ( playersonly )
        {
            entitiesfound = getplayersinradius( self.origin, radiusrange );
        }
        else
        {
            entitiesfound = getentitiesinradius( self.origin, radiusrange );
        }
        
        if ( entitiesfound.size > 0 )
        {
            if ( !checkvisibility )
            {
                self notify( triggernotify, entitiesfound );
            }
            else
            {
                entities = [];
                
                foreach ( entityfound in entitiesfound )
                {
                    sourceposition = self getorigin();
                    targetposition = ter_op( playersonly, entityfound geteye(), entityfound.origin );
                    var_68e6f05a4ee24dee = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot" ] );
                    var_97db5d48f2509e02 = physics_raycast( sourceposition, targetposition, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest" );
                    
                    if ( var_97db5d48f2509e02.size <= 0 )
                    {
                        entities[ entities.size ] = entityfound;
                    }
                }
                
                self notify( triggernotify, entities );
            }
        }
        
        wait var_ecea6cda97e5f7ae;
    }
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0xd01
// Size: 0xa
function cancelentitiesinradius()
{
    self notify( "end_entities_in_radius" );
}

// Namespace entity / scripts\mp\utility\entity
// Params 4
// Checksum 0x0, Offset: 0xd13
// Size: 0x10f
function placeequipmentfailed( weapon, showfx, position, angles )
{
    assert( isdefined( showfx ) && isdefined( position ) || !isdefined( showfx ) && !isdefined( position ) );
    self playlocalsound( "scavenger_pack_pickup" );
    
    if ( istrue( showfx ) )
    {
        fxent = undefined;
        
        if ( isdefined( angles ) )
        {
            fxent = spawnfxforclient( getfx( "placeEquipmentFailed" ), position, self, anglestoforward( angles ), anglestoup( angles ) );
        }
        else
        {
            fxent = spawnfxforclient( getfx( "placeEquipmentFailed" ), position, self );
        }
        
        triggerfx( fxent );
        thread placeequipmentfailedcleanup( fxent );
    }
    
    switch ( weapon )
    {
        case #"hash_36d0be2b0f1c99e":
        case #"hash_523f0c8fe1ead306":
        case #"hash_5e3fa526a48eaaa5":
        case #"hash_d059dcc3a7f1308a":
        case #"hash_eec4a41906598dfc":
            if ( isplayer( self ) && scripts\cp_mp\utility\player_utility::_isalive() )
            {
                self iprintlnbold( "Placement Failed" );
            }
            
            break;
    }
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0xe2a
// Size: 0x1c
function placeequipmentfailedinit()
{
    level._effect[ "placeEquipmentFailed" ] = loadfx( "vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx" );
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0xe4e
// Size: 0x15
function placeequipmentfailedcleanup( fxent )
{
    wait 2;
    fxent delete();
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0xe6b
// Size: 0x17, Type: bool
function isspidergrenade( ent )
{
    return istrue( ent.isspidergrenade );
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0xe8b
// Size: 0x77, Type: bool
function issupertrophy( ent )
{
    entnum = ent getentitynumber();
    
    if ( !isdefined( level.supertrophy ) )
    {
        return false;
    }
    
    if ( !isdefined( level.supertrophy.trophies ) )
    {
        return false;
    }
    
    if ( !isdefined( level.supertrophy.trophies[ entnum ] ) )
    {
        return false;
    }
    
    return level.supertrophy.trophies[ entnum ] == ent;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0xf0b
// Size: 0x4a, Type: bool
function ismicroturret( ent )
{
    entnum = ent getentitynumber();
    
    if ( !isdefined( level.microturrets ) )
    {
        return false;
    }
    
    if ( !isdefined( level.microturrets[ entnum ] ) )
    {
        return false;
    }
    
    return level.microturrets[ entnum ] == ent;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0xf5e
// Size: 0x5f
function ischoppergunner( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    ischopper = ent.streakinfo.streakname == "chopper_gunner";
    return ischopper;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0xfc6
// Size: 0x5f
function issupporthelo( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    ischopper = ent.streakinfo.streakname == "chopper_support";
    return ischopper;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x102e
// Size: 0x5f
function isclusterstrike( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    var_30c3ced8e8637755 = ent.streakinfo.streakname == "toma_strike";
    return var_30c3ced8e8637755;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x1096
// Size: 0x97, Type: bool
function isuav( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return false;
    }
    
    if ( ent.streakinfo.streakname == "uav" || ent.streakinfo.streakname == "counter_uav" || ent.streakinfo.streakname == "directional_uav" )
    {
        return true;
    }
    
    return false;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x1136
// Size: 0x5f
function isgunship( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    var_f930e97582eaea73 = ent.streakinfo.streakname == "gunship";
    return var_f930e97582eaea73;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x119e
// Size: 0x7e
function isradardrone( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isradar = ent.streakinfo.streakname == "radar_drone_escort" || ent.streakinfo.streakname == "radar_drone_recon";
    return isradar;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x1225
// Size: 0x7e
function isscramblerdrone( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isscrambler = ent.streakinfo.streakname == "scrambler_drone_guard" || ent.streakinfo.streakname == "counter_uav";
    return isscrambler;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x12ac
// Size: 0x5f
function isradarhelicopter( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isradar = ent.streakinfo.streakname == "radar_drone_overwatch";
    return isradar;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x1314
// Size: 0x5f
function isassaultdrone( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isradar = ent.streakinfo.streakname == "assault_drone";
    return isradar;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x137c
// Size: 0x2c, Type: bool
function isturret( ent )
{
    return isdefined( ent.classname ) && ent.classname == "misc_turret";
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x13b1
// Size: 0x17, Type: bool
function isdronepackage( ent )
{
    return isdefined( ent.cratetype );
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x13d1
// Size: 0x3a
function _enableequipdeployvfx()
{
    if ( !isdefined( self.enabledequipdeployvfx ) )
    {
        self.enabledequipdeployvfx = 0;
    }
    
    if ( self.enabledequipdeployvfx == 0 )
    {
        self enableequipdeployvfx( 1 );
    }
    
    self.enabledequipdeployvfx++;
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x1413
// Size: 0x4a
function _disableequipdeployvfx()
{
    assert( isdefined( self.enabledequipdeployvfx ) && self.enabledequipdeployvfx > 0, "<dev string:x1c>" );
    
    if ( self.enabledequipdeployvfx == 1 )
    {
        self enableequipdeployvfx( 0 );
    }
    
    self.enabledequipdeployvfx--;
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x1465
// Size: 0x85
function register_physics_collisions()
{
    self endon( "death" );
    self endon( "stop_phys_sounds" );
    
    while ( true )
    {
        self waittill( "collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        level notify( "physSnd", self, body0, body1, flag0, flag1, position, normal, impulse, ent );
    }
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x14f2
// Size: 0xaf
function global_physics_sound_monitor()
{
    level notify( "physics_monitor" );
    level endon( "physics_monitor" );
    
    while ( true )
    {
        level waittill( "physSnd", var_c92ef281c1d335fc, body0, body1, flag0, flag1, position, normal, impulse, var_b941baeebca428d );
        
        if ( isdefined( var_c92ef281c1d335fc ) && isdefined( var_c92ef281c1d335fc.phys_sound_func ) )
        {
            level thread [[ var_c92ef281c1d335fc.phys_sound_func ]]( var_c92ef281c1d335fc, body0, body1, flag0, flag1, position, normal, impulse, var_b941baeebca428d );
        }
    }
}

// Namespace entity / scripts\mp\utility\entity
// Params 2
// Checksum 0x0, Offset: 0x15a9
// Size: 0x20
function register_physics_collision_func( entity, function_name )
{
    entity.phys_sound_func = function_name;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x15d1
// Size: 0x17, Type: bool
function istouchingboundstrigger( ent )
{
    return istrue( ent.alreadytouchingtrigger );
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x15f1
// Size: 0x91
function istouchingboundsnullify( ent )
{
    var_5c40098b82789b9 = 0;
    
    if ( isdefined( level.outofboundstriggerpatches ) && level.outofboundstriggerpatches.size > 0 )
    {
        foreach ( patch in level.outofboundstriggerpatches )
        {
            if ( ent istouching( patch ) )
            {
                var_5c40098b82789b9 = 1;
                break;
            }
        }
    }
    
    return var_5c40098b82789b9;
}

// Namespace entity / scripts\mp\utility\entity
// Params 1
// Checksum 0x0, Offset: 0x168b
// Size: 0x21
function deleteonplayerdeathdisconnect( player )
{
    self endon( "death" );
    player waittill( "death_or_disconnect" );
    self delete();
}

// Namespace entity / scripts\mp\utility\entity
// Params 0
// Checksum 0x0, Offset: 0x16b4
// Size: 0x11
function deleteatframeend()
{
    self endon( "death" );
    waittillframeend();
    self delete();
}

