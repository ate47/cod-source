#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\hud_util;
#using scripts\common\notetrack;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\values;
#using scripts\engine\utility;

#namespace scene;

// Namespace scene / scripts\common\scene
// Params 4
// Checksum 0x0, Offset: 0x234
// Size: 0x3b
function play( existingentities, shotnames, scriptbundlename, fromtimefrac )
{
    sceneroot = self;
    sceneroot function_7e5354b44c829c9e( existingentities, shotnames, scriptbundlename, fromtimefrac );
}

// Namespace scene / scripts\common\scene
// Params 5
// Checksum 0x0, Offset: 0x277
// Size: 0x5b
function function_24e44cdb807b87ba( prestreamtime, existingentities, shotnames, scriptbundlename, fromtimefrac )
{
    if ( !isdefined( prestreamtime ) )
    {
        prestreamtime = 1;
    }
    
    sceneroot = self;
    sceneroot pre_stream( existingentities, shotnames, prestreamtime, scriptbundlename );
    wait prestreamtime;
    sceneroot play( existingentities, shotnames, scriptbundlename, fromtimefrac );
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x2da
// Size: 0x36
function init( existingentities, shotnames, scriptbundlename )
{
    sceneroot = self;
    return sceneroot function_a9fc7e7dfd78e15e( existingentities, shotnames, scriptbundlename, "scene_init_user" );
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x319
// Size: 0x162
function skip( shotnames, timefromend, fadeinouttime )
{
    if ( !isdefined( timefromend ) )
    {
        timefromend = 0.5;
    }
    
    if ( !isdefined( fadeinouttime ) )
    {
        fadeinouttime = 0.5;
    }
    
    sceneroot = self;
    state = sceneroot get_state();
    
    if ( state != "Playing" )
    {
        return;
    }
    
    sceneplay = sceneroot function_e6197350552df14b( shotnames, 0 );
    
    if ( !isdefined( sceneplay ) )
    {
        return;
    }
    
    if ( fadeinouttime > 0 )
    {
        hud_util::fade_out( fadeinouttime );
        waitframe();
    }
    
    totalseconds = 0;
    
    foreach ( shotindex in sceneplay.var_df5db7bd235f2729 )
    {
        totalseconds += sceneroot function_30140edcf9e36027( sceneplay, shotindex );
    }
    
    if ( fadeinouttime > 0 )
    {
        thread hud_util::fade_in( fadeinouttime );
    }
    
    if ( totalseconds <= 0 || timefromend >= totalseconds )
    {
        return;
    }
    
    timefrac = ( totalseconds - timefromend ) / totalseconds;
    sceneplay function_5a438716f043fddc( timefrac, sceneplay.var_df5db7bd235f2729 );
    sceneroot function_7e5354b44c829c9e( undefined, shotnames, undefined, timefrac, sceneplay.currentshot );
    sceneroot function_bb980ac4246f5baa( "callback_skipped" );
}

// Namespace scene / scripts\common\scene
// Params 0
// Checksum 0x0, Offset: 0x483
// Size: 0x9b
function stop()
{
    sceneroot = self;
    sceneroot function_bd09568f76dd40ca();
    
    if ( sceneroot get_state() == "Playing" )
    {
        foreach ( sceneplay in sceneroot.scenedata.sceneplay )
        {
            sceneplay thread function_28f230671b0b9a1f( 1 );
        }
        
        waittillframeend();
        
        while ( sceneroot get_state() == "Playing" )
        {
            waitframe();
        }
    }
}

// Namespace scene / scripts\common\scene
// Params 1
// Checksum 0x0, Offset: 0x526
// Size: 0x215
function cleanup( forcedeleteall )
{
    sceneroot = self;
    sceneroot.scenestatic = undefined;
    
    if ( istrue( forcedeleteall ) && isdefined( sceneroot.var_cf24d127aa3920a0 ) )
    {
        foreach ( entity in sceneroot.var_cf24d127aa3920a0 )
        {
            if ( !isdefined( entity ) )
            {
                continue;
            }
            
            if ( isagent( entity ) )
            {
                entity.nocorpse = 1;
                entity val::reset_all( "scene_shot" );
                entity kill();
                continue;
            }
            
            entity delete();
        }
        
        sceneroot.var_cf24d127aa3920a0 = undefined;
    }
    
    if ( sceneroot get_state() != "NotSetup" )
    {
        sceneroot scene_reset();
    }
    
    if ( sceneroot get_state() == "NotInit" )
    {
        return;
    }
    
    if ( isdefined( sceneroot ) && !isdefined( sceneroot.var_cf24d127aa3920a0 ) )
    {
        sceneroot.var_cf24d127aa3920a0 = [];
    }
    
    for ( sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = sceneroot.scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isdefined( sceneobjectdata ) && isdefined( sceneobjectdata.entity ) && !istrue( sceneobjectdata.existingentity ) )
        {
            if ( istrue( forcedeleteall ) )
            {
                sceneobjectdata object_delete();
                continue;
            }
            
            if ( !isplayer( sceneobjectdata.entity ) )
            {
                sceneroot.var_cf24d127aa3920a0[ sceneobjectdata.entity getentitynumber() ] = sceneobjectdata.entity;
            }
        }
    }
    
    if ( isdefined( sceneroot ) && isdefined( sceneroot.var_cf24d127aa3920a0 ) && sceneroot.var_cf24d127aa3920a0.size == 0 )
    {
        sceneroot.var_cf24d127aa3920a0 = undefined;
    }
    
    sceneroot function_c643b2c6b794481e( "NotInit" );
}

// Namespace scene / scripts\common\scene
// Params 5
// Checksum 0x0, Offset: 0x743
// Size: 0x65d
function pre_stream( existingentities, shotnames, duration, scriptbundlename, predicttime )
{
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    if ( !isdefined( scriptbundlename ) )
    {
        scriptbundlename = undefined;
    }
    
    if ( !isdefined( predicttime ) )
    {
        predicttime = 0;
    }
    
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    
    if ( isdefined( existingentities ) && !isarray( existingentities ) )
    {
        existingentities = [ existingentities ];
    }
    
    state = sceneroot get_state();
    sceneplay = undefined;
    scenescriptbundle = sceneroot scene_scriptbundle();
    shotindexes = [];
    
    if ( !isdefined( shotnames ) )
    {
        shotnames = sceneroot function_8a37fe423de2b9db();
    }
    
    if ( !isarray( shotnames ) )
    {
        shotnames = [ shotnames ];
    }
    
    foreach ( shotname in shotnames )
    {
        shotindex = scenescriptbundle function_e1e718bbc3eb9fd2( shotname );
        shotindexes[ shotindex ] = shotindex;
    }
    
    foreach ( sceneplayiter in scenedata.sceneplay )
    {
        if ( utility::is_equal( sceneplayiter.state, "Playing" ) )
        {
            var_a1709fdb12562ef0 = utility::array_intersection( sceneplayiter.var_df5db7bd235f2729, shotindexes );
            
            if ( var_a1709fdb12562ef0.size == shotindexes.size )
            {
                sceneplay = sceneplayiter;
                break;
            }
        }
    }
    
    if ( !isdefined( sceneplay ) )
    {
        sceneplay = sceneroot function_a9fc7e7dfd78e15e( existingentities, shotnames, undefined, "scene_init_prestream" );
    }
    
    if ( isdefined( sceneplay ) && sceneplay.var_df5db7bd235f2729.size > 0 )
    {
        sceneplay.prestream = spawnstruct();
        sceneplay.prestream.players = [];
        sceneplay.prestream.objects = [];
        
        /#
            debugdisplayindexes = [];
        #/
        
        foreach ( shotindex in shotindexes )
        {
            sceneplay function_218d0124f21f73b1( shotindex );
            
            foreach ( var_19a1a40cf0ff83b9 in sceneplay.objectorder )
            {
                if ( isdefined( var_19a1a40cf0ff83b9[ shotindex ] ) )
                {
                    sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
                    sceneobjectdata thread function_b62972e8f5541b26( sceneplay, shotindex );
                }
            }
            
            /#
                debugdisplayindexes[ debugdisplayindexes.size ] = shotindex;
            #/
            
            predicttime -= sceneplay.sceneroot function_d9be975d8d1c9db3( shotindex );
            
            if ( predicttime <= 0 )
            {
                break;
            }
        }
        
        /#
            if ( sceneplay.prestream.players.size == 0 )
            {
                iprintlnbold( "<dev string:x1c>" );
            }
        #/
        
        foreach ( playerinfo in sceneplay.prestream.players )
        {
            entities = [];
            distances = [];
            player = playerinfo.player;
            
            foreach ( cameraorigin in playerinfo.cameraorigins )
            {
                closestobjects = sortbydistance( sceneplay.prestream.objects, cameraorigin );
                
                foreach ( objectinfo in closestobjects )
                {
                    entnum = objectinfo.entity getentitynumber();
                    dist = distance( cameraorigin, objectinfo.origin );
                    
                    if ( !isdefined( entities[ entnum ] ) )
                    {
                        entities[ entnum ] = objectinfo.entity;
                        distances[ entnum ] = dist;
                        continue;
                    }
                    
                    distances[ entnum ] = min( distances[ entnum ], dist );
                }
            }
            
            /#
                if ( playerinfo.cameraorigins.size > 2 )
                {
                    iprintlnbold( "<dev string:x41>" );
                }
            #/
            
            streamentities = [];
            streamdistances = [];
            
            foreach ( entnum, entity in entities )
            {
                if ( streamentities.size >= 16 )
                {
                    /#
                        iprintlnbold( "<dev string:x64>" + 16 );
                    #/
                    
                    break;
                }
                
                streamentities[ streamentities.size ] = entity;
                streamdistances[ streamdistances.size ] = distances[ entnum ];
            }
            
            if ( isdefined( player ) )
            {
                /#
                    sceneplay function_ffae6ec92028ce08( debugdisplayindexes, duration, playerinfo.cameraorigins );
                #/
                
                player utility::player_prestream_camera( playerinfo.cameraorigins[ 0 ], duration, playerinfo.cameraorigins[ 1 ] );
                player utility::player_prestream_entities( streamentities, streamdistances, duration );
            }
        }
        
        sceneplay.prestreamuntil = undefined;
        
        if ( duration > 0 )
        {
            sceneplay.prestreamuntil = gettime() + duration * 1000;
        }
        else if ( duration < 0 )
        {
            sceneplay.prestreamuntil = -1;
        }
        
        sceneplay.prestream = undefined;
    }
}

// Namespace scene / scripts\common\scene
// Params 0
// Checksum 0x0, Offset: 0xda8
// Size: 0x75
function function_8a37fe423de2b9db()
{
    sceneroot = self;
    scenescriptbundle = sceneroot scene_scriptbundle();
    shotnames = [];
    shotcount = scenescriptbundle function_d1338e27a26ecaeb();
    
    for ( shotindex = 0; shotindex < shotcount ; shotindex++ )
    {
        shot = scenescriptbundle function_2218afa82a590ea3( shotindex );
        shotnames[ shotindex ] = shot function_55042076624e1180();
    }
    
    return shotnames;
}

// Namespace scene / scripts\common\scene
// Params 2
// Checksum 0x0, Offset: 0xe26
// Size: 0x10c
function get_entities( var_2a29e57c1c105d52, filter )
{
    if ( !isdefined( filter ) )
    {
        filter = "all";
    }
    
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    entities = [];
    
    if ( !isdefined( scenedata ) )
    {
        return entities;
    }
    
    shotindexes = sceneroot function_14d02a749939e837( var_2a29e57c1c105d52 );
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isdefined( shotindexes ) && !sceneobjectdata function_225d78e3c485a7ae( shotindexes ) )
        {
            continue;
        }
        
        switch ( filter )
        {
            case #"hash_d71fd9ff6b033b7a":
                if ( istrue( sceneobjectdata.existingentity ) || sceneobjectdata.sceneobject function_d5f4474a16f90132() != "None" )
                {
                    continue;
                }
                
                break;
        }
        
        entities[ entities.size ] = sceneobjectdata.entity;
    }
    
    return entities;
}

// Namespace scene / scripts\common\scene
// Params 1
// Checksum 0x0, Offset: 0xf3b
// Size: 0x3c
function get_entity( var_9f7e823a4cdab21d )
{
    sceneroot = self;
    sceneobjectdata = sceneroot get_object( var_9f7e823a4cdab21d );
    
    if ( isdefined( sceneobjectdata ) )
    {
        return sceneobjectdata.entity;
    }
    
    return undefined;
}

// Namespace scene / scripts\common\scene
// Params 1
// Checksum 0x0, Offset: 0xf80
// Size: 0xda
function get_object( var_8a2a5f9c6428c06c )
{
    sceneroot = self;
    
    if ( !isdefined( sceneroot.scenedata ) )
    {
        return undefined;
    }
    
    if ( !isdefined( var_8a2a5f9c6428c06c ) )
    {
        return undefined;
    }
    
    scenedata = sceneroot.scenedata;
    scenescriptbundle = sceneroot scene_scriptbundle();
    
    if ( isint( var_8a2a5f9c6428c06c ) )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ var_8a2a5f9c6428c06c ];
        
        if ( isdefined( sceneobjectdata ) )
        {
            return sceneobjectdata;
        }
    }
    else
    {
        for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            sceneobject = scenescriptbundle function_bfc4196d3da11705( sceneobjectindex );
            
            if ( sceneobject function_aeb2b46911a5811d() == var_8a2a5f9c6428c06c )
            {
                sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
                return sceneobjectdata;
            }
        }
    }
    
    return undefined;
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x1063
// Size: 0x106
function function_6cb938788c210309( var_8a2a5f9c6428c06c, var_7c76f3de91f4cf3d, scriptbundlename )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return sceneroot;
    }
    
    if ( !isdefined( var_8a2a5f9c6428c06c ) )
    {
        return sceneroot;
    }
    
    scenedata = sceneroot.scenedata;
    sceneobjectdata = sceneroot get_object( var_8a2a5f9c6428c06c );
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return sceneroot;
    }
    
    shotindex = var_7c76f3de91f4cf3d;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return sceneroot;
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return sceneroot;
    }
    
    alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2( sceneroot, shotindex, sceneobjectdata.index );
    function_e4fc30ccdca08b9d( alignmentinfo );
    return alignmentinfo;
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x1172
// Size: 0xe5
function function_10a1cbb13da3a4fe( var_8a2a5f9c6428c06c, var_7c76f3de91f4cf3d, scriptbundlename )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return [];
    }
    
    if ( !isdefined( var_8a2a5f9c6428c06c ) )
    {
        return [];
    }
    
    scenedata = sceneroot.scenedata;
    sceneobjectdata = sceneroot get_object( var_8a2a5f9c6428c06c );
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return [];
    }
    
    shotindex = var_7c76f3de91f4cf3d;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return [];
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return [];
    }
    
    return sceneobjectdata.sceneobject function_79edcc9987330a2a( shotindex );
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x1260
// Size: 0xf3
function function_77751080050d2cb1( objecttype, var_2a29e57c1c105d52, scriptbundlename )
{
    sceneroot = self;
    assert( isstring( objecttype ) );
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return [];
    }
    
    scenedata = sceneroot.scenedata;
    objects = [];
    shotindexes = sceneroot function_14d02a749939e837( var_2a29e57c1c105d52 );
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata.sceneobject function_c77857d663e8cfbe() != objecttype )
        {
            continue;
        }
        
        if ( isdefined( shotindexes ) && !sceneobjectdata function_225d78e3c485a7ae( shotindexes ) )
        {
            continue;
        }
        
        objects[ objects.size ] = sceneobjectdata;
    }
    
    return objects;
}

// Namespace scene / scripts\common\scene
// Params 1
// Checksum 0x0, Offset: 0x135c
// Size: 0x3d
function function_bc521bee52fde214( rate )
{
    sceneroot = self;
    sceneroot function_6a66a98742866fed();
    sceneroot.scenestatic.animrate = rate;
    function_d225e757dea4eca6();
}

// Namespace scene / scripts\common\scene
// Params 5
// Checksum 0x0, Offset: 0x13a1
// Size: 0xeb
function function_ddebd5f650117455( var_8a2a5f9c6428c06c, var_7c76f3de91f4cf3d, overridetype, overridevalue, scriptbundlename )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return;
    }
    
    if ( !isdefined( var_8a2a5f9c6428c06c ) )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    sceneobjectdata = sceneroot get_object( var_8a2a5f9c6428c06c );
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return;
    }
    
    shotindex = var_7c76f3de91f4cf3d;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return;
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return;
    }
    
    sceneobjectdata function_5a65e42126f29a4f( shotindex, overridetype, overridevalue );
}

// Namespace scene / scripts\common\scene
// Params 1
// Checksum 0x0, Offset: 0x1494
// Size: 0x53
function set_scriptbundle( scriptbundlename )
{
    sceneroot = self;
    
    if ( isdefined( scriptbundlename ) )
    {
        if ( isdefined( sceneroot.script_scenescriptbundle ) && sceneroot.script_scenescriptbundle != scriptbundlename )
        {
            sceneroot cleanup( 1 );
        }
        
        sceneroot.script_scenescriptbundle = scriptbundlename;
    }
}

// Namespace scene / scripts\common\scene
// Params 2
// Checksum 0x0, Offset: 0x14ef
// Size: 0xa4
function add_spawn_function( spawnfunc, var_6bff09752f736d14 )
{
    if ( !isdefined( var_6bff09752f736d14 ) )
    {
        var_6bff09752f736d14 = "_object_all_";
    }
    
    sceneroot = self;
    sceneroot function_6a66a98742866fed();
    scenestatic = sceneroot.scenestatic;
    
    if ( !isdefined( scenestatic.spawnfunctions ) )
    {
        scenestatic.spawnfunctions = [];
    }
    
    if ( !isdefined( scenestatic.spawnfunctions[ var_6bff09752f736d14 ] ) )
    {
        scenestatic.spawnfunctions[ var_6bff09752f736d14 ] = [];
    }
    
    scenestatic.spawnfunctions[ var_6bff09752f736d14 ][ scenestatic.spawnfunctions[ var_6bff09752f736d14 ].size ] = spawnfunc;
}

// Namespace scene / scripts\common\scene
// Params 0
// Checksum 0x0, Offset: 0x159b
// Size: 0xd7
function get_state()
{
    sceneroot = self;
    
    if ( !isdefined( sceneroot.scenedata ) )
    {
        return "NotInit";
    }
    
    sceneroot function_bd09568f76dd40ca();
    
    if ( sceneroot.scenedata.state == "Setup" )
    {
        foreach ( sceneplay in sceneroot.scenedata.sceneplay )
        {
            if ( sceneplay.state == "Playing" )
            {
                return "Playing";
            }
        }
        
        return "Stopped";
    }
    
    return sceneroot.scenedata.state;
}

// Namespace scene / scripts\common\scene
// Params 1
// Checksum 0x0, Offset: 0x167a
// Size: 0x54
function function_263e37fc44b91d4f( exclude_players )
{
    sceneroot = self;
    sceneroot function_6a66a98742866fed();
    
    if ( !istrue( exclude_players ) )
    {
        sceneroot.scenestatic.excludeplayers = undefined;
        return;
    }
    
    sceneroot.scenestatic.excludeplayers = 1;
}

// Namespace scene / scripts\common\scene
// Params 1
// Checksum 0x0, Offset: 0x16d6
// Size: 0x54
function function_595670eb4c1bdf59( var_8d59d732cf917fb2 )
{
    sceneroot = self;
    sceneroot function_6a66a98742866fed();
    
    if ( !istrue( var_8d59d732cf917fb2 ) )
    {
        sceneroot.scenestatic.var_8f28f8f196c70a58 = undefined;
        return;
    }
    
    sceneroot.scenestatic.var_8f28f8f196c70a58 = 1;
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x1732
// Size: 0x10e
function add_scene_func( scene_ref, func, var_8338711a0d65673b )
{
    structdest = undefined;
    
    if ( isstring( scene_ref ) )
    {
        structdest = level.scene;
    }
    else if ( isstruct( scene_ref ) )
    {
        sceneroot = scene_ref;
        sceneroot function_6a66a98742866fed();
        structdest = sceneroot.scenestatic;
        scene_ref = sceneroot function_6c0e3626ebce826f();
    }
    else
    {
        assertmsg( "must be called on the level where scene_ref is either a scene bundle name or a scene root object" );
    }
    
    structdest.funcs = utility::default_to( structdest.funcs, [] );
    structdest.funcs[ scene_ref ] = utility::default_to( structdest.funcs[ scene_ref ], [] );
    structdest.funcs[ scene_ref ][ var_8338711a0d65673b ] = utility::default_to( structdest.funcs[ scene_ref ][ var_8338711a0d65673b ], [] );
    structdest.funcs[ scene_ref ][ var_8338711a0d65673b ] = utility::function_6d6af8144a5131f1( structdest.funcs[ scene_ref ][ var_8338711a0d65673b ], func );
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x1848
// Size: 0xfe, Type: bool
function remove_scene_func( scene_ref, func, var_8338711a0d65673b )
{
    structdest = undefined;
    
    if ( isstring( scene_ref ) )
    {
        structdest = level.scene;
    }
    else if ( isstruct( scene_ref ) )
    {
        sceneroot = scene_ref;
        sceneroot function_bd09568f76dd40ca();
        scene_ref = sceneroot function_6c0e3626ebce826f();
        structdest = sceneroot.scenedata;
    }
    else
    {
        assertmsg( "must be called on the level where scene_ref is either a scene bundle name or a scene root object" );
    }
    
    if ( !isdefined( structdest.funcs ) )
    {
        return false;
    }
    
    if ( !isdefined( structdest.funcs[ scene_ref ] ) )
    {
        return false;
    }
    
    if ( !isdefined( structdest.funcs[ scene_ref ][ var_8338711a0d65673b ] ) )
    {
        return false;
    }
    
    if ( utility::array_contains( structdest.funcs[ scene_ref ][ var_8338711a0d65673b ], func ) )
    {
        structdest.funcs[ scene_ref ][ var_8338711a0d65673b ] = utility::array_remove( structdest.funcs[ scene_ref ][ var_8338711a0d65673b ], func );
        return true;
    }
    
    return false;
}

// Namespace scene / scripts\common\scene
// Params 3
// Checksum 0x0, Offset: 0x194f
// Size: 0xa6
function function_a07af33558d3050f( notifytarget, eventmessage, statematch )
{
    sceneroot = self;
    sceneroot function_6a66a98742866fed();
    
    if ( !isdefined( statematch ) )
    {
        statematch = "Stopped";
    }
    
    /#
        if ( statematch != "<dev string:x87>" && statematch != "<dev string:x8f>" )
        {
            assertmsg( "<dev string:x97>" );
        }
    #/
    
    sceneroot.scenestatic.notifyobject = notifytarget;
    sceneroot.scenestatic.notifyevent = eventmessage;
    sceneroot.scenestatic.notifymatch = statematch;
}

// Namespace scene / scripts\common\scene
// Params 4
// Checksum 0x0, Offset: 0x19fd
// Size: 0x1cc
function function_8207074e79f22926( notifytarget, note, var_6bff09752f736d14, repeat )
{
    sceneroot = self;
    sceneroot function_6a66a98742866fed();
    scenestatic = sceneroot.scenestatic;
    notifyinfo = spawnstruct();
    notifyinfo.notifyobject = notifytarget;
    notifyinfo.notifynote = note;
    notifyinfo.notifyrepeat = repeat;
    var_6bff09752f736d14 = default_to( var_6bff09752f736d14, "_object_all_" );
    
    if ( !isdefined( scenestatic.notifies ) )
    {
        scenestatic.notifies = [];
    }
    
    if ( !isdefined( scenestatic.notifies[ var_6bff09752f736d14 ] ) )
    {
        scenestatic.notifies[ var_6bff09752f736d14 ] = [];
    }
    
    if ( function_85b2629a7bbafad9( scenestatic.notifies[ "_object_all_" ], notifyinfo ) )
    {
        return;
    }
    
    if ( function_85b2629a7bbafad9( scenestatic.notifies[ var_6bff09752f736d14 ], notifyinfo ) )
    {
        return;
    }
    
    scenestatic.notifies[ var_6bff09752f736d14 ][ scenestatic.notifies[ var_6bff09752f736d14 ].size ] = notifyinfo;
    
    if ( sceneroot get_state() == "Playing" )
    {
        for ( sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            sceneobjectdata = sceneroot.scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( isdefined( sceneobjectdata ) && isdefined( sceneobjectdata.var_36831a04af11576f ) && isdefined( sceneobjectdata.var_36831a04af11576f[ "DeltaAnimation" ] ) )
            {
                sceneobjectdata thread function_924dc6425bd2b70d( sceneobjectdata.var_36831a04af11576f[ "DeltaAnimation" ] );
            }
        }
    }
}

// Namespace scene / scripts\common\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1bd1
// Size: 0xc8, Type: bool
function private function_85b2629a7bbafad9( notifies, newnotify )
{
    if ( !isdefined( notifies ) )
    {
        return false;
    }
    
    foreach ( registerednotify in notifies )
    {
        if ( registerednotify.notifyobject == newnotify.notifyobject && registerednotify.notifynote == newnotify.notifynote && utility::default_to( registerednotify.notifyrepeat, 0 ) == utility::default_to( newnotify.notifyrepeat, 0 ) )
        {
            registerednotify.notifytriggered = undefined;
            return true;
        }
    }
    
    return false;
}

// Namespace scene / scripts\common\scene
// Params 2
// Checksum 0x0, Offset: 0x1ca2
// Size: 0x20f
function function_d9be975d8d1c9db3( var_7c76f3de91f4cf3d, var_c5b4f177c96bcce1 )
{
    sceneroot = self;
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return 0;
    }
    
    scenedata = sceneroot.scenedata;
    shotindex = var_7c76f3de91f4cf3d;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_924e47d1f90e6366( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return 0;
    }
    
    if ( shotindex < 0 )
    {
        return 0;
    }
    
    var_c5b4f177c96bcce1 = utility::default_to( var_c5b4f177c96bcce1, 1 );
    var_ba7c51f4385e6b48 = 0;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( shotindex < sceneobjectdata.sceneobject.variant_object.shots.size )
        {
            cameraanimation = sceneobjectdata function_6c3d100538f590b3( shotindex );
            
            if ( isdefined( cameraanimation ) )
            {
                var_4aade63686d9cdf2 = sceneobjectdata function_9c0d01ef917ee30( cameraanimation, "CameraAnimation" );
                
                if ( var_4aade63686d9cdf2 > var_ba7c51f4385e6b48 )
                {
                    var_ba7c51f4385e6b48 = var_4aade63686d9cdf2;
                }
            }
            
            var_755a82d10fefd14 = 0;
            animtype = sceneobjectdata.sceneobject function_92192185fc7c5500();
            shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a( shotindex );
            
            for ( animationindex = 0; animationindex < shotanimations.size ; animationindex++ )
            {
                var_755a82d10fefd14 += sceneobjectdata function_9c0d01ef917ee30( shotanimations[ animationindex ], animtype );
            }
            
            if ( var_755a82d10fefd14 > var_ba7c51f4385e6b48 )
            {
                var_ba7c51f4385e6b48 = var_755a82d10fefd14;
            }
        }
    }
    
    if ( isdefined( sceneroot.scenestatic ) && isdefined( sceneroot.scenestatic.animrate ) && var_c5b4f177c96bcce1 )
    {
        var_ba7c51f4385e6b48 *= sceneroot.scenestatic.animrate;
    }
    
    return var_ba7c51f4385e6b48;
}

// Namespace scene / scripts\common\scene
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1eba
// Size: 0x6a7
function private function_a9fc7e7dfd78e15e( existingentities, shotnames, scriptbundlename, inittype )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return;
    }
    
    sceneplay = sceneroot function_e6197350552df14b( shotnames, 1 );
    scenedata = sceneroot.scenedata;
    
    if ( isdefined( existingentities ) )
    {
        if ( !isarray( existingentities ) )
        {
            existingentities = [ existingentities ];
        }
        
        existingentities = utility::array_removeundefined( existingentities );
        
        foreach ( existingentity in existingentities )
        {
            if ( isdefined( existingentity.script_animname ) && !isdefined( existingentity.animname ) )
            {
                existingentity.animname = existingentity.script_animname;
            }
        }
    }
    
    scenedata.var_a416d1b334ed6b37 = undefined;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata object_get_type() == "Types_Player" )
        {
            if ( sceneobjectdata function_3e13497ed7044cbd() )
            {
                scenedata.var_a416d1b334ed6b37 = 1;
                break;
            }
        }
    }
    
    sceneplay.var_7038c2a13f1f5db8 = [];
    foundentitiesused = [];
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( !sceneobjectdata function_225d78e3c485a7ae( sceneplay.var_df5db7bd235f2729, sceneplay, sceneobjectindex ) )
        {
            continue;
        }
        
        sceneobjectname = sceneobjectdata.sceneobject function_aeb2b46911a5811d();
        existingentities = sceneobjectdata function_1ba5fc9ef8e19620( sceneroot, sceneplay, sceneobjectname, existingentities, 1, 1, inittype );
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            sceneroot.var_cf24d127aa3920a0 = sceneobjectdata function_1ba5fc9ef8e19620( sceneroot, sceneplay, sceneobjectname, sceneroot.var_cf24d127aa3920a0, 1, 0, inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_53687c7001a0784b( sceneroot, sceneplay, sceneobjectname, foundentitiesused, "targetname", inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_53687c7001a0784b( sceneroot, sceneplay, sceneobjectname, foundentitiesused, "script_noteworthy", inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_53687c7001a0784b( sceneroot, sceneplay, "_scene_global_" + sceneobjectname, foundentitiesused, "targetname", inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_53687c7001a0784b( sceneroot, sceneplay, "_scene_global_" + sceneobjectname, foundentitiesused, "script_noteworthy", inittype );
        }
    }
    
    playerindex = 0;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( !isdefined( sceneplay.var_7038c2a13f1f5db8[ sceneobjectindex ] ) )
        {
            continue;
        }
        
        sceneobjectname = sceneobjectdata.sceneobject function_aeb2b46911a5811d();
        
        if ( !isdefined( sceneobjectdata.entity ) && !sceneobjectdata.sceneobject function_d301ab09c0738edf() )
        {
            existingentities = sceneobjectdata function_1ba5fc9ef8e19620( sceneroot, sceneplay, sceneobjectname, existingentities, 0, 1, inittype );
            
            if ( !isdefined( sceneobjectdata.entity ) )
            {
                sceneroot.var_cf24d127aa3920a0 = sceneobjectdata function_1ba5fc9ef8e19620( sceneroot, sceneplay, sceneobjectname, sceneroot.var_cf24d127aa3920a0, 0, 0, inittype );
            }
        }
        
        entity = sceneobjectdata.entity;
        isplayerobject = sceneobjectdata object_get_type() == "Types_Player";
        var_fdc8fd88a88422e5 = 0;
        
        /#
            var_fdc8fd88a88422e5 = getdvarint( @"hash_3bc9bc279e3f772", 0 );
        #/
        
        if ( !isdefined( entity ) )
        {
            if ( !sceneobjectdata.sceneobject function_9be5ff9b4bc5843a( sceneplay.shotinit ) || var_fdc8fd88a88422e5 && isplayerobject )
            {
                sceneobjectdata.alignmentinfo = scenedata.scenescriptbundle function_ab3ec43370c405d2( sceneroot, sceneplay.shotinit, sceneobjectindex );
                function_e4fc30ccdca08b9d( sceneobjectdata.alignmentinfo );
                
                if ( isplayerobject )
                {
                    if ( playerindex < level.players.size )
                    {
                        playerentity = level.players[ playerindex ];
                        
                        if ( !function_ac04e049ff623301( playerentity, sceneobjectdata ) )
                        {
                            playerentity = undefined;
                        }
                        
                        entity = playerentity;
                    }
                    
                    /#
                        if ( var_fdc8fd88a88422e5 )
                        {
                            if ( function_2fbba7f29e8d78ce( sceneobjectindex ) )
                            {
                                entity = level.players[ 0 ];
                            }
                            else if ( utility::is_equal( entity, level.players[ 0 ] ) )
                            {
                                entity = undefined;
                            }
                        }
                    #/
                }
                else
                {
                    if ( isdefined( level.struct_class_names ) )
                    {
                        sceneobjectdata.spawner = function_9b40ea5276506411( sceneobjectname, 0 );
                    }
                    
                    entity = sceneobjectdata object_spawn( sceneobjectdata.alignmentinfo, sceneplay.shotinit );
                }
            }
            else
            {
                sceneplay.var_7038c2a13f1f5db8[ sceneobjectindex ] = undefined;
            }
        }
        
        if ( isdefined( entity ) )
        {
            sceneobjectdata function_6acd8ab4606e2a09( sceneroot, sceneplay, entity, undefined, inittype );
        }
        
        if ( isdefined( sceneplay.var_7038c2a13f1f5db8[ sceneobjectindex ] ) && !( istrue( sceneobjectdata.issetup ) && inittype == "scene_init_prestream" ) )
        {
            sceneobjectdata object_setup( sceneplay );
        }
        
        if ( isplayerobject )
        {
            playerindex++;
        }
    }
    
    sceneplay function_218d0124f21f73b1( sceneplay.shotinit );
    
    foreach ( sceneobjectindex, var_19a1a40cf0ff83b9 in sceneplay.objectorder )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( !isdefined( sceneplay.var_7038c2a13f1f5db8[ sceneobjectindex ] ) )
        {
            continue;
        }
        
        sceneobjectdata function_535e6f4c06c15b1d( sceneplay, 1, 1, sceneobjectdata.alignmentinfo );
        
        if ( sceneobjectdata.sceneobject function_83ba0b38ef7f3949() && inittype == "scene_init_user" )
        {
            sceneobjectdata function_9745e01cedd81c85( sceneobjectdata.alignmentinfo );
        }
    }
    
    sceneroot function_c643b2c6b794481e( "Setup" );
    sceneplay.state = "Stopped";
    sceneroot function_bb980ac4246f5baa( "callback_init" );
    return sceneplay;
}

// Namespace scene / scripts\common\scene
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x256a
// Size: 0x560
function private function_7e5354b44c829c9e( existingentities, shotnames, scriptbundlename, fromtimefrac, startshotindex )
{
    sceneroot = self;
    
    /#
        if ( getdvarint( @"hash_1aa832f211c5245e" ) )
        {
            level waittill( "<dev string:xd8>" );
            return;
        }
        
        if ( !utility::array_contains( level.var_a0b4eb1703be349a, sceneroot ) )
        {
            sceneroot.var_4d8e093da0426022 = 1;
            level.var_a0b4eb1703be349a = utility::function_6d6af8144a5131f1( level.var_a0b4eb1703be349a, sceneroot );
        }
    #/
    
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_bd09568f76dd40ca() )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    
    if ( isdefined( existingentities ) && !isarray( existingentities ) )
    {
        existingentities = [ existingentities ];
    }
    
    state = sceneroot get_state();
    sceneplay = undefined;
    
    if ( state != "NotSetup" )
    {
        sceneplay = sceneroot function_e6197350552df14b( shotnames, 0 );
        
        if ( isdefined( sceneplay ) && sceneplay.state == "Playing" )
        {
            sceneplay function_28f230671b0b9a1f( 0 );
        }
        
        if ( isdefined( sceneplay ) && isdefined( sceneplay.prestreamuntil ) )
        {
            if ( sceneplay.prestreamuntil < 0 || gettime() > sceneplay.prestreamuntil )
            {
                sceneroot pre_stream( existingentities, shotnames, level.framedurationseconds * 2 );
            }
            
            sceneplay.prestreamuntil = undefined;
        }
    }
    
    sceneplay = sceneroot function_a9fc7e7dfd78e15e( existingentities, shotnames, undefined, "scene_init_play" );
    
    if ( sceneplay.var_df5db7bd235f2729.size == 0 )
    {
        /#
            shotsstr = "<dev string:xe0>";
            
            if ( isdefined( shotnames ) )
            {
                shotsstr = "<dev string:xe1>";
                
                if ( !isarray( shotnames ) )
                {
                    shotnames = [ shotnames ];
                }
                
                foreach ( shot in shotnames )
                {
                    shotsstr = shotsstr + "<dev string:xe3>" + shot;
                }
            }
            
            iprintlnbold( "<dev string:xe5>" + sceneroot.script_scenescriptbundle + "<dev string:xee>" + shotsstr );
        #/
        
        return;
    }
    
    sceneplay function_da660bb71d6eb080( 1 );
    sceneplay function_e5b5e877417bc710( isdefined( startshotindex ) );
    sceneplay function_5a438716f043fddc( fromtimefrac, sceneplay.var_df5db7bd235f2729 );
    sceneplay function_950e5107399d1111();
    sceneroot function_bb980ac4246f5baa( "callback_play" );
    sceneroot.var_708c03f822068263 = undefined;
    
    while ( isdefined( sceneroot.scenedata ) && !istrue( sceneplay.stoprequested ) )
    {
        scenestarttime = gettime();
        sceneplay.shotindicesindex = utility::default_to( startshotindex, 0 );
        
        while ( sceneplay.shotindicesindex < sceneplay.var_df5db7bd235f2729.size )
        {
            sceneplay.currentshot = sceneplay.var_df5db7bd235f2729[ sceneplay.shotindicesindex ];
            sceneplay.nextshot = undefined;
            
            if ( sceneplay.shotindicesindex + 1 < sceneplay.var_df5db7bd235f2729.size )
            {
                sceneplay.nextshot = sceneplay.var_df5db7bd235f2729[ sceneplay.shotindicesindex + 1 ];
            }
            
            if ( sceneplay.var_df5db7bd235f2729.size > sceneplay.shotindicesindex + 1 )
            {
                doprestream = scenedata.scenescriptbundle function_e65f46a710591a5();
                streamtime = 2;
                predicttime = streamtime;
                nextshotnames = [];
                
                for ( var_7d3411523e9ab92c = sceneplay.shotindicesindex + 1; var_7d3411523e9ab92c < sceneplay.var_df5db7bd235f2729.size ; var_7d3411523e9ab92c++ )
                {
                    nextshotindex = sceneplay.var_df5db7bd235f2729[ var_7d3411523e9ab92c ];
                    nextshot = scenedata.scenescriptbundle function_2218afa82a590ea3( nextshotindex );
                    nextshotnames[ nextshotnames.size ] = nextshot function_55042076624e1180();
                    doprestream = doprestream || nextshot function_dd4368cda4b91e7d();
                    predicttime -= sceneroot function_d9be975d8d1c9db3( nextshotindex );
                    
                    if ( predicttime <= 0 )
                    {
                        break;
                    }
                }
                
                if ( doprestream )
                {
                    currentshotlength = sceneroot function_d9be975d8d1c9db3( sceneplay.currentshot, 1 );
                    streamstarttime = max( currentshotlength - streamtime, level.framedurationseconds );
                    sceneroot utility::delaythreadendon( streamstarttime, "scene_stop", &pre_stream, existingentities, nextshotnames, streamtime + 0.1, undefined, streamtime );
                }
            }
            
            success = sceneroot function_afea5de3a99c09ab( sceneplay, sceneplay.currentshot );
            
            if ( !success )
            {
                break;
            }
            
            sceneplay.shotindicesindex++;
        }
        
        if ( !isdefined( sceneroot.scenedata ) || !sceneroot.scenedata.scenescriptbundle function_4f93a0dfb8fd6a47() )
        {
            break;
        }
        
        if ( gettime() == scenestarttime )
        {
            break;
        }
    }
    
    sceneplay function_8accfbca6fff9e0();
}

// Namespace scene / scripts\common\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2ad2
// Size: 0xbb
function private function_8accfbca6fff9e0()
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    
    /#
        if ( istrue( sceneroot.var_4d8e093da0426022 ) )
        {
            level.var_a0b4eb1703be349a = utility::array_remove( level.var_a0b4eb1703be349a, sceneroot );
        }
    #/
    
    sceneplay function_da660bb71d6eb080( 0 );
    sceneplay.state = "Stopped";
    sceneplay notify( "Stopped" );
    sceneplay function_bc27ed6c295108d7();
    
    if ( sceneroot get_state() == "Stopped" )
    {
        sceneroot function_2549c341bf1ae3e7( "Stopped" );
    }
    
    if ( !istrue( sceneplay.stoprequested ) )
    {
        sceneroot function_bb980ac4246f5baa( "callback_done" );
    }
    
    sceneroot thread function_798498fd6521b8f0();
}

