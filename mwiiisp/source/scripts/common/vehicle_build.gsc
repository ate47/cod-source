#using scripts\common\utility;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_treadfx;
#using scripts\engine\utility;

#namespace vehicle_build;

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 4
// Checksum 0x0, Offset: 0x467
// Size: 0xa4
function build_radiusdamage( offset, range, maxdamage, mindamage )
{
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    struct = spawnstruct();
    struct.offset = offset;
    struct.range = range;
    struct.maxdamage = maxdamage;
    struct.mindamage = mindamage;
    level.vehicle.templates.death_radiusdamage[ level.vtclassname ] = struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 6
// Checksum 0x0, Offset: 0x513
// Size: 0xd4
function build_rumble( rumble, scale, duration, radius, basetime, randomaditionaltime )
{
    if ( !isdefined( level.vehicle.templates.rumble ) )
    {
        level.vehicle.templates.rumble = [];
    }
    
    struct = build_quake( scale, duration, radius, basetime, randomaditionaltime );
    assert( isdefined( rumble ) );
    precacherumble( rumble );
    struct.rumble = rumble;
    level.vehicle.templates.rumble[ level.vtclassname ] = struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 3
// Checksum 0x0, Offset: 0x5ef
// Size: 0x98
function build_deathquake( scale, duration, radius )
{
    classname = level.vtclassname;
    
    if ( !isdefined( level.vehicle.templates.death_earthquake ) )
    {
        level.vehicle.templates.death_earthquake = [];
    }
    
    level.vehicle.templates.death_earthquake[ classname ] = build_quake( scale, duration, radius );
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 5
// Checksum 0x0, Offset: 0x68f
// Size: 0x87
function build_quake( scale, duration, radius, basetime, randomaditionaltime )
{
    struct = spawnstruct();
    struct.scale = scale;
    struct.duration = duration;
    struct.radius = radius;
    
    if ( isdefined( basetime ) )
    {
        struct.basetime = basetime;
    }
    
    if ( isdefined( randomaditionaltime ) )
    {
        struct.randomaditionaltime = randomaditionaltime;
    }
    
    return struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 12
// Checksum 0x0, Offset: 0x71f
// Size: 0x138
function build_fx( effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, selfdeletedelay, remove_deathfx_entity_delay, attacker_velocity_lerp )
{
    if ( !isdefined( bsoundlooping ) )
    {
        bsoundlooping = 0;
    }
    
    if ( !isdefined( beffectlooping ) )
    {
        beffectlooping = 0;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 1;
    }
    
    struct = spawnstruct();
    struct.effect = loadfx( effect );
    struct.tag = tag;
    struct.sound = sound;
    struct.bsoundlooping = bsoundlooping;
    struct.delay = delay;
    struct.waitdelay = waitdelay;
    struct.stayontag = stayontag;
    struct.notifystring = notifystring;
    struct.beffectlooping = beffectlooping;
    struct.selfdeletedelay = selfdeletedelay;
    struct.remove_deathfx_entity_delay = remove_deathfx_entity_delay;
    struct.attacker_velocity_lerp = attacker_velocity_lerp;
    return struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 12
// Checksum 0x0, Offset: 0x860
// Size: 0x126
function build_deathfx( effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, var_5b457edcff6fa295, remove_deathfx_entity_delay, attacker_velocity_lerp )
{
    assertex( isdefined( effect ), "Failed to build death effect because there is no effect specified for the model used for that vehicle." );
    classname = level.vtclassname;
    
    if ( !isdefined( level.vehicle.templates.vehicle_death_fx[ classname ] ) )
    {
        level.vehicle.templates.vehicle_death_fx[ classname ] = [];
    }
    
    level.vehicle.templates.vehicle_death_fx[ classname ][ level.vehicle.templates.vehicle_death_fx[ classname ].size ] = build_fx( effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, var_5b457edcff6fa295, remove_deathfx_entity_delay, attacker_velocity_lerp );
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 11
// Checksum 0x0, Offset: 0x98e
// Size: 0x11c
function build_rocket_deathfx( effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, var_5b457edcff6fa295, remove_deathfx_entity_delay )
{
    assertex( isdefined( effect ), "Failed to build death effect because there is no effect specified for the model used for that vehicle." );
    classname = level.vtclassname;
    
    if ( !isdefined( level.vehicle.templates.vehicle_death_fx[ classname ] ) )
    {
        level.vehicle.templates.vehicle_death_fx[ classname ] = [];
    }
    
    level.vehicle.templates.vehicle_rocket_death_fx[ classname ][ level.vehicle.templates.vehicle_death_fx[ classname ].size ] = build_fx( effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, var_5b457edcff6fa295, remove_deathfx_entity_delay );
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 4
// Checksum 0x0, Offset: 0xab2
// Size: 0x17f
function build_deathanimations( forwardanimation, rightanimation, backwardanimation, leftanimation )
{
    assertex( isdefined( forwardanimation ), "No forwardAnimation for build_deathanim: " + level.vtclassname );
    assertex( isdefined( rightanimation ), "No rightAnimation for build_deathanim: " + level.vtclassname );
    assertex( isdefined( backwardanimation ), "No backwardAnimation for build_deathanim: " + level.vtclassname );
    assertex( isdefined( leftanimation ), "No leftAnimation for build_deathanim: " + level.vtclassname );
    classname = level.vtclassname;
    
    if ( !isdefined( level.vehicle.templates.deathanimations[ classname ] ) )
    {
        level.vehicle.templates.deathanimations[ classname ] = [];
    }
    
    level.vehicle.templates.deathanimations[ classname ][ "forward" ] = forwardanimation;
    level.vehicle.templates.deathanimations[ classname ][ "right" ] = rightanimation;
    level.vehicle.templates.deathanimations[ classname ][ "backward" ] = backwardanimation;
    level.vehicle.templates.deathanimations[ classname ][ "left" ] = leftanimation;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0xc39
// Size: 0x4d
function build_landanims( landthread )
{
    assert( isdefined( landthread ) );
    classname = level.vtclassname;
    level.vehicle.templates.landanims[ classname ] = [[ landthread ]]();
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 9
// Checksum 0x0, Offset: 0xc8e
// Size: 0x104
function build_turret( info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild )
{
    classname = level.vtclassname;
    
    if ( !isdefined( level.vehicle.templates.mgturret[ classname ] ) )
    {
        level.vehicle.templates.mgturret[ classname ] = [];
    }
    
    struct = build_turret_struct( info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild );
    level.vehicle.templates.mgturret[ classname ][ level.vehicle.templates.mgturret[ classname ].size ] = struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 8
// Checksum 0x0, Offset: 0xd9a
// Size: 0xc6
function build_mainturret( info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename )
{
    classname = level.vtclassname;
    
    if ( isdefined( level.vehicle.templates.mainturret[ classname ] ) )
    {
        assertmsg( "only 1 mainturret allowed per vehicle" );
    }
    
    struct = build_turret_struct( info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename );
    level.vehicle.templates.mainturret[ classname ] = struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 9
// Checksum 0x0, Offset: 0xe68
// Size: 0xf9
function build_turret_struct( info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild )
{
    precachemodel( model );
    precacheturret( info );
    struct = spawnstruct();
    struct.info = info;
    struct.tag = tag;
    struct.model = model;
    struct.defaultonmode = defaultonmode;
    struct.defaultdroppitch = defaultdroppitch;
    struct.defaultdropyaw = defaultdropyaw;
    
    if ( isdefined( offset_tag ) )
    {
        struct.offset_tag = offset_tag;
    }
    
    if ( isdefined( referencename ) )
    {
        struct.referencename = referencename;
    }
    
    if ( isdefined( mainturretchild ) && mainturretchild )
    {
        struct.mainturretchild = mainturretchild;
    }
    
    return struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 6
// Checksum 0x0, Offset: 0xf6a
// Size: 0x170
function build_light( classname, name, tag, effect, group, delay )
{
    if ( !isdefined( level.vehicle.templates.vehicle_lights ) )
    {
        level.vehicle.templates.vehicle_lights = [];
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group_override ) )
    {
        level.vehicle.templates.vehicle_lights_group_override = [];
    }
    
    if ( isdefined( level.vehicle.templates.vehicle_lights_group_override[ group ] ) && !level.vtoverride )
    {
        return;
    }
    
    struct = spawnstruct();
    struct.name = name;
    struct.tag = tag;
    struct.delay = delay;
    struct.effect = loadfx( effect );
    level.vehicle.templates.vehicle_lights[ classname ][ name ] = struct;
    group_light( classname, name, "all" );
    
    if ( isdefined( group ) )
    {
        group_light( classname, name, group );
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 6
// Checksum 0x0, Offset: 0x10e2
// Size: 0x179
function function_2cf37d073c6bde84( classname, name, part, group, delay, var_22ed434f33b345af )
{
    if ( !isdefined( level.vehicle.templates.vehicle_lights ) )
    {
        level.vehicle.templates.vehicle_lights = [];
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group_override ) )
    {
        level.vehicle.templates.vehicle_lights_group_override = [];
    }
    
    if ( isdefined( level.vehicle.templates.vehicle_lights_group_override[ group ] ) && !level.vtoverride )
    {
        return;
    }
    
    struct = spawnstruct();
    struct.name = name;
    struct.part = part;
    struct.delay = delay;
    struct.isscriptable = 1;
    level.vehicle.templates.vehicle_lights[ classname ][ name ] = struct;
    
    if ( !isdefined( var_22ed434f33b345af ) || var_22ed434f33b345af == 0 )
    {
        group_light( classname, name, "all" );
    }
    
    if ( isdefined( group ) )
    {
        group_light( classname, name, group );
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x1263
// Size: 0x8a
function build_hideparts( classname, parts_array )
{
    assert( isdefined( classname ) );
    assert( isdefined( parts_array ) );
    
    if ( !isdefined( level.vehicle.templates.hide_part_list ) )
    {
        level.vehicle.templates.hide_part_list = [];
    }
    
    level.vehicle.templates.hide_part_list[ classname ] = parts_array;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x12f5
// Size: 0x59
function build_deathmodel( model, deathmodel )
{
    if ( model != level.vtmodel )
    {
        return;
    }
    
    if ( !isdefined( deathmodel ) )
    {
        deathmodel = model;
    }
    
    precachemodel( model );
    precachemodel( deathmodel );
    level.vehicle.templates.deathmodel[ model ] = deathmodel;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 4
// Checksum 0x0, Offset: 0x1356
// Size: 0xcc
function build_husk( model, huskmodel, type, var_cb3cc2d75d941670 )
{
    if ( model != level.vtmodel )
    {
        return;
    }
    
    assertex( isdefined( huskmodel ), "need to define a scriptable husk" );
    assertex( isdefined( type ), "need to define a vehicle type" );
    precachemodel( model );
    precachemodel( huskmodel );
    level.vehicle.templates.husk[ model ] = huskmodel;
    level.vehicle.templates.husktype[ model ] = type;
    
    if ( !isdefined( var_cb3cc2d75d941670 ) )
    {
        var_cb3cc2d75d941670 = 1;
    }
    
    level.vehicle.templates.var_893da51cf12b2c8b[ model ] = var_cb3cc2d75d941670;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x142a
// Size: 0xf1
function build_idle( animation )
{
    if ( !isdefined( level.vehicle.templates.idle_anim ) )
    {
        level.vehicle.templates.idle_anim = [];
    }
    
    if ( !isdefined( level.vehicle.templates.idle_anim[ level.vtmodel ] ) )
    {
        level.vehicle.templates.idle_anim[ level.vtmodel ] = [];
    }
    
    level.vehicle.templates.idle_anim[ level.vtmodel ][ level.vehicle.templates.idle_anim[ level.vtmodel ].size ] = animation;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 4
// Checksum 0x0, Offset: 0x1523
// Size: 0xda
function build_drive( forward, reverse, normalspeed, rate )
{
    if ( !isdefined( normalspeed ) )
    {
        normalspeed = 10;
    }
    
    level.vehicle.templates.driveidle[ level.vtmodel ] = forward;
    
    if ( isdefined( reverse ) )
    {
        level.vehicle.templates.driveidle_r[ level.vtmodel ] = reverse;
    }
    
    level.vehicle.templates.driveidle_normal_speed[ level.vtmodel ] = normalspeed;
    
    if ( isdefined( rate ) )
    {
        level.vehicle.templates.driveidle_animrate[ level.vtmodel ] = rate;
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 4
// Checksum 0x0, Offset: 0x1605
// Size: 0x498
function build_template( class, model, type, classname )
{
    vehicle_setuplevelvariables();
    
    if ( !isdefined( type ) )
    {
        type = class;
    }
    
    assertex( isdefined( classname ), "templated without classname" );
    precachevehicle( type );
    level.vehicle.templates.team[ classname ] = "neutral";
    level.vehicle.templates.has_main_turret[ model ] = 0;
    level.vehicle.templates.main_turrets[ model ] = [];
    level.vtmodel = model;
    level.vttype = type;
    level.vtclassname = classname;
    level.vehicle.templates.model[ classname ] = model;
    
    switch ( class )
    {
        case #"hash_37e412543c51c9ec":
            build_life( 10000, 9500, 10500 );
            build_deathquake( 1, 1.6, 500 );
            level.vehicle.templates.explosivehits[ classname ] = 2;
            break;
        case #"hash_b626ccb5ac25b9c":
        case #"hash_68cb10ac5667e070":
            build_life( 9000, 8750, 9250 );
            build_deathquake( 1, 1.6, 500 );
            build_radiusdamage( ( 0, 0, 0 ), 500, 120, 20 );
            level.vehicle.templates.explosivehits[ classname ] = 2;
            break;
        case #"hash_e88686bc1d16bcea":
            build_life( 12000, 11750, 12250 );
            build_deathquake( 1, 1.6, 500 );
            build_radiusdamage( ( 0, 0, 0 ), 500, 120, 20 );
            level.vehicle.templates.explosivehits[ classname ] = 2;
            break;
        case #"hash_178f2685991a7482":
            build_life( 20000, 19000, 21000 );
            build_deathquake( 1, 1.6, 500 );
            build_radiusdamage( ( 0, 0, 0 ), 500, 120, 20 );
            level.vehicle.templates.explosivehits[ classname ] = 5;
            break;
        case #"hash_290903a1af40c196":
            build_life( 4000, 3750, 4250 );
            build_deathquake( 1, 1.6, 500 );
            build_radiusdamage( ( 0, 0, 0 ), 400, 120, 20 );
            level.vehicle.templates.explosivehits[ classname ] = 1;
            break;
        case #"hash_479ffef06a7cc84e":
            build_life( 10000, 9500, 10500 );
            build_deathquake( 1, 1.6, 500 );
            build_radiusdamage( ( 0, 0, 0 ), 400, 120, 20 );
            level.vehicle.templates.explosivehits[ classname ] = 2;
            break;
        case #"hash_c93466c10cc10ba":
        case #"hash_619324ebc667112c":
        case #"hash_79dd32c8d8093d05":
        case #"hash_895a2c6c51da0091":
            build_life( 2500, 2300, 2700 );
            build_deathquake( 1, 1.6, 500 );
            build_radiusdamage( ( 0, 0, 0 ), 400, 120, 20 );
            level.vehicle.templates.explosivehits[ classname ] = 0;
            break;
        case #"hash_1a86166c17e05dc1":
        case #"hash_7ec20b2ed0c1c55b":
        case #"hash_bd2b14a6c78f31a8":
        default:
            build_life( 2500, 2300, 2700 );
            build_deathquake( 1, 1.6, 500 );
            build_radiusdamage( ( 0, 0, 0 ), 400, 120, 20 );
            level.vehicle.templates.explosivehits[ classname ] = 1;
            break;
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x1aa5
// Size: 0x744, Type: bool
function function_40778829123b7952( vehicleref, vehicleclass )
{
    classname = vehicleref;
    bundlename = classname + "_sp";
    bundle = getscriptbundle( "vehiclebundle:" + bundlename );
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    if ( isdefined( bundle.compositemodel ) )
    {
        model = bundle.compositemodel;
    }
    else
    {
        model = bundle.model;
    }
    
    type = bundle.vehicle;
    
    if ( !isdefined( model ) || !isdefined( type ) )
    {
        return false;
    }
    
    build_template( vehicleclass, model, type, classname );
    
    if ( istrue( bundle.husk.hashusk ) )
    {
        if ( isdefined( bundle.husk.compositemodel ) )
        {
            huskmodel = bundle.husk.compositemodel;
        }
        else if ( isdefined( bundle.husk.model ) )
        {
            huskmodel = bundle.husk.model;
        }
        else
        {
            huskmodel = model;
        }
        
        if ( isdefined( bundle.husk.vehicle ) )
        {
            huskvehicle = bundle.husk.vehicle;
        }
        else
        {
            huskvehicle = type;
        }
        
        build_husk( model, huskmodel, huskvehicle, 0 );
    }
    
    if ( istrue( bundle.ai.supportsai ) )
    {
        assert( isdefined( bundle.ai.vehicleanimalias ) && bundle.ai.vehicleanimalias != "", "You must specify a vehicleAnimAlias if this vehicle supports AI: " + vehicleref );
        unload_groups = [];
        unload_groups[ "default" ] = [];
        unload_groups[ "all" ] = [];
        
        foreach ( index, seatdata in bundle.aiseats )
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
            
            if ( isdefined( seatdata.linkoffset ) )
            {
                x = ter_op( isdefined( seatdata.linkoffset.x ), seatdata.linkoffset.x, 0 );
                y = ter_op( isdefined( seatdata.linkoffset.y ), seatdata.linkoffset.y, 0 );
                z = ter_op( isdefined( seatdata.linkoffset.z ), seatdata.linkoffset.z, 0 );
                
                if ( x != 0 || y != 0 || z != 0 )
                {
                    seatdata.linkoffset = ( x, y, z );
                    seatdata.linkangle = ( 0, 0, 0 );
                }
                else
                {
                    seatdata.linkoffset = undefined;
                }
            }
            
            if ( isdefined( bundle.aianimations ) && isdefined( bundle.aianimations[ index ] ) )
            {
                animationdata = bundle.aianimations[ index ];
                
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
        
        foreach ( extraunloadgroup in bundle.unloadgroups )
        {
            unload_groups[ extraunloadgroup.name ] = [];
            
            foreach ( index, seatdata in extraunloadgroup.seats )
            {
                unload_groups[ extraunloadgroup.name ][ unload_groups[ extraunloadgroup.name ].size ] = seatdata.seatindex;
            }
        }
        
        bundle.unloadgroups = undefined;
        bundle.aianimations = undefined;
        assign_aianims( bundle.aiseats, bundle.ai.vehicleanimalias );
        function_ab7252da140c8fe7( unload_groups );
    }
    
    return true;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x21f2
// Size: 0x39
function build_exhaust( effect )
{
    level.vehicle.templates.exhaust_fx[ level.vtmodel ] = loadfx( effect );
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 8
// Checksum 0x0, Offset: 0x2233
// Size: 0x14a
function build_enginefx( effect, effect_tag, max_effect, max_effort, med_effect, med_effort, min_effect, min_effort )
{
    assertex( isdefined( effect ), "Failed to build engine effect because there is no effect specified." );
    
    if ( !isdefined( effect_tag ) )
    {
        effect_tag = "tag_engine_fx";
    }
    
    struct = spawnstruct();
    struct.effect = loadfx( effect );
    struct.effect_tag = effect_tag;
    
    if ( isdefined( max_effect ) )
    {
        assert( isdefined( max_effort ) );
        struct.max_effort_effect = loadfx( max_effect );
        struct.max_effort_ratio = max_effort;
    }
    
    if ( isdefined( med_effect ) )
    {
        assert( isdefined( med_effort ) );
        struct.med_effort_effect = loadfx( med_effect );
        struct.med_effort_ratio = med_effort;
    }
    
    if ( isdefined( min_effect ) )
    {
        assert( isdefined( min_effort ) );
        struct.min_effort_effect = loadfx( min_effect );
        struct.min_effort_ratio = min_effort;
    }
    
    level.vehicle.templates.engine_fx[ level.vtclassname ] = struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 4
// Checksum 0x0, Offset: 0x2385
// Size: 0x79
function build_treadfx( classname, type, fx, do_wash )
{
    if ( !issp() )
    {
        return;
    }
    
    if ( isdefined( classname ) )
    {
        set_vehicle_effect( classname, type, fx );
        
        if ( isdefined( do_wash ) && do_wash )
        {
            set_vehicle_effect( classname, type, fx, "_bank" );
            set_vehicle_effect( classname, type, fx, "_bank_lg" );
        }
        
        return;
    }
    
    classname = level.vtclassname;
    scripts\common\vehicle_treadfx::main();
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x2406
// Size: 0x6e
function build_all_treadfx( classname, fx )
{
    types = get_surface_types();
    
    foreach ( type in types )
    {
        set_vehicle_effect( classname, type );
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 4
// Checksum 0x0, Offset: 0x247c
// Size: 0x10c
function set_vehicle_effect( classname, material, fx, suffix )
{
    if ( !isdefined( level.vehicle.templates.surface_effects ) )
    {
        level.vehicle.templates.surface_effects = [];
    }
    
    if ( isdefined( suffix ) )
    {
        material += suffix;
        fx += suffix;
    }
    
    if ( isdefined( fx ) )
    {
        level.vehicle.templates.surface_effects[ classname ][ material ] = loadfx( fx );
        return;
    }
    
    if ( isdefined( level.vehicle.templates.surface_effects[ classname ] ) && isdefined( level.vehicle.templates.surface_effects[ classname ][ material ] ) )
    {
        level.vehicle.templates.surface_effects[ classname ][ material ] = undefined;
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 0
// Checksum 0x0, Offset: 0x2590
// Size: 0x11a
function get_surface_types()
{
    return [ "brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default" ];
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x26b3
// Size: 0x34
function build_team( team )
{
    level.vehicle.templates.team[ level.vtclassname ] = team;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x26ef
// Size: 0x3f
function build_bulletshield( bshield )
{
    assert( isdefined( bshield ) );
    level.vehicle.templates.bullet_shield[ level.vtclassname ] = bshield;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2736
// Size: 0x3f
function build_grenadeshield( bshield )
{
    assert( isdefined( bshield ) );
    level.vehicle.templates.grenade_shield[ level.vtclassname ] = bshield;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x277d
// Size: 0x3f
function function_d82e00bef8433948( weaponarray )
{
    assert( isdefined( weaponarray ) );
    level.vehicle.templates.var_7412ca7553957e74[ level.vtclassname ] = weaponarray;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x27c4
// Size: 0x3f
function function_ceeb72985b41bfb1( bshield )
{
    assert( isdefined( bshield ) );
    level.vehicle.templates.collision_shield[ level.vtclassname ] = bshield;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 3
// Checksum 0x0, Offset: 0x280b
// Size: 0x117
function build_aianims( aithread, vehiclethread, vehicleanimalias )
{
    classname = level.vtclassname;
    level.vehicle.templates.aianims[ classname ] = [[ aithread ]]();
    
    if ( isdefined( vehicleanimalias ) && isdefined( level.func ) && isdefined( level.func[ "set_vehicle_anims_" + vehicleanimalias ] ) )
    {
        level.vehicle.templates.aianims[ classname ] = [[ level.func[ "set_vehicle_anims_" + vehicleanimalias ] ]]( level.vehicle.templates.aianims[ classname ] );
        return;
    }
    
    if ( isdefined( vehiclethread ) )
    {
        level.vehicle.templates.aianims[ classname ] = [[ vehiclethread ]]( level.vehicle.templates.aianims[ classname ] );
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x292a
// Size: 0xc3
function assign_aianims( aithreadresult, vehicleanimalias )
{
    classname = level.vtclassname;
    level.vehicle.templates.aianims[ classname ] = aithreadresult;
    
    if ( isdefined( vehicleanimalias ) && isdefined( level.func ) && isdefined( level.func[ "set_vehicle_anims_" + vehicleanimalias ] ) )
    {
        level.vehicle.templates.aianims[ classname ] = [[ level.func[ "set_vehicle_anims_" + vehicleanimalias ] ]]( level.vehicle.templates.aianims[ classname ] );
    }
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x29f5
// Size: 0x36
function build_attach_models( modelsthread )
{
    level.vehicle.templates.attachedmodels[ level.vtclassname ] = [[ modelsthread ]]();
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2a33
// Size: 0x34
function function_423e10816a23372f( attachmodels )
{
    level.vehicle.templates.attachedmodels[ level.vtclassname ] = attachmodels;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2a6f
// Size: 0x36
function build_unload_groups( unloadgroupsthread )
{
    level.vehicle.templates.unloadgroups[ level.vtclassname ] = [[ unloadgroupsthread ]]();
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2aad
// Size: 0x34
function function_ab7252da140c8fe7( unloadgroups )
{
    level.vehicle.templates.unloadgroups[ level.vtclassname ] = unloadgroups;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 3
// Checksum 0x0, Offset: 0x2ae9
// Size: 0x92
function build_life( health, minhealth, maxhealth )
{
    classname = level.vtclassname;
    level.vehicle.templates.life[ classname ] = health;
    level.vehicle.templates.life_range_low[ classname ] = minhealth;
    level.vehicle.templates.life_range_high[ classname ] = maxhealth;
}

/#

    // Namespace vehicle_build / scripts\common\vehicle_build
    // Params 2
    // Checksum 0x0, Offset: 0x2b83
    // Size: 0x21, Type: dev
    function build_destructible( model, destructible )
    {
        assertmsg( "this is disabled for now! " );
    }

#/

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2bac
// Size: 0x2f
function build_localinit( init_thread )
{
    level.vehicleinitthread[ getxhashasset( level.vttype ) ][ level.vtclassname ] = init_thread;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x2be3
// Size: 0x71
function build_atmo_types( atmo_type, space_type )
{
    level.vehicle.templates.atmotypes[ level.vtclassname ][ "atmo" ] = atmo_type;
    level.vehicle.templates.atmotypes[ level.vtclassname ][ "space" ] = space_type;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2c5c
// Size: 0x34
function build_ace( is_ace )
{
    level.vehicle.templates.aces[ level.vtclassname ] = is_ace;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2c98
// Size: 0x34
function build_semiace( is_semiace )
{
    level.vehicle.templates.semiaces[ level.vtclassname ] = is_semiace;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x2cd4
// Size: 0x6d
function build_playercontrolled_model( playercontrolledmodel, worldmodel )
{
    struct = spawnstruct();
    struct.playercontrolledmodel = playercontrolledmodel;
    struct.worldmodel = worldmodel;
    precachemodel( playercontrolledmodel );
    level.vehicle.templates.vehicleplayermodel[ level.vtclassname ] = struct;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2d49
// Size: 0x82
function build_is_helicopter( vehicle_type )
{
    if ( !isdefined( level.vehicle.templates.helicopter_list ) )
    {
        level.vehicle.templates.helicopter_list = [];
    }
    
    if ( !isdefined( vehicle_type ) )
    {
        vehicle_type = level.vttype;
    }
    
    level.vehicle.templates.helicopter_list[ getxhashasset( vehicle_type ) ] = 1;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2dd3
// Size: 0x82
function function_3a186b889337bd1b( vehicle_type )
{
    if ( !isdefined( level.vehicle.templates.boat_list ) )
    {
        level.vehicle.templates.boat_list = [];
    }
    
    if ( !isdefined( vehicle_type ) )
    {
        vehicle_type = level.vttype;
    }
    
    level.vehicle.templates.boat_list[ getxhashasset( vehicle_type ) ] = 1;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2e5d
// Size: 0x82
function build_is_airplane( vehicle_type )
{
    if ( !isdefined( level.vehicle.templates.airplane_list ) )
    {
        level.vehicle.templates.airplane_list = [];
    }
    
    if ( !isdefined( vehicle_type ) )
    {
        vehicle_type = level.vttype;
    }
    
    level.vehicle.templates.airplane_list[ getxhashasset( vehicle_type ) ] = 1;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2ee7
// Size: 0x82
function function_5a73d7723fce9849( vehicle_type )
{
    if ( !isdefined( level.vehicle.templates.tank_list ) )
    {
        level.vehicle.templates.tank_list = [];
    }
    
    if ( !isdefined( vehicle_type ) )
    {
        vehicle_type = level.vttype;
    }
    
    level.vehicle.templates.tank_list[ getxhashasset( vehicle_type ) ] = 1;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2f71
// Size: 0x82
function build_single_tread( vehicle_type )
{
    if ( !isdefined( level.vehicle.templates.single_tread_list ) )
    {
        level.vehicle.templates.single_tread_list = [];
    }
    
    if ( !isdefined( vehicle_type ) )
    {
        vehicle_type = level.vttype;
    }
    
    level.vehicle.templates.single_tread_list[ getxhashasset( vehicle_type ) ] = 1;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 1
// Checksum 0x0, Offset: 0x2ffb
// Size: 0x74
function build_rider_death_func( func )
{
    if ( !isdefined( level.vehicle.templates.rider_death_func ) )
    {
        level.vehicle.templates.rider_death_func = [];
    }
    
    level.vehicle.templates.rider_death_func[ level.vtclassname ] = func;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 3
// Checksum 0x0, Offset: 0x3077
// Size: 0x50
function build_iw9physics( classname, vehicletype, init_thread )
{
    level.vehicle.templates.iw9physics[ classname ] = vehicletype;
    level.vehicleinitthread[ getxhashasset( vehicletype ) ][ classname ] = init_thread;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 2
// Checksum 0x0, Offset: 0x30cf
// Size: 0x34
function build_hud( classname, index )
{
    level.vehicle.templates.hudindex[ classname ] = index;
}

// Namespace vehicle_build / scripts\common\vehicle_build
// Params 3
// Checksum 0x0, Offset: 0x310b
// Size: 0x8f
function build_dependentparts( classname, parentbone, childbones )
{
    if ( !isdefined( level.vehicle.templates.dependentparts ) )
    {
        level.vehicle.templates.dependentparts = [];
    }
    
    if ( !isarray( childbones ) )
    {
        childbones = [ childbones ];
    }
    
    level.vehicle.templates.dependentparts[ classname ][ parentbone ] = childbones;
}

