#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\notetrack;
#using scripts\common\scene;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace scene;

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x70d
// Size: 0x332
function private autoexec function_683aefb412af1596()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
        {
            return;
        }
    #/
    
    function_ace39e84230f386();
    function_9d3850b024ab89b1( "modeStartMonitoringPlayers", &function_22f6fca8362a92b );
    function_9d3850b024ab89b1( "modeStopMonitoringPlayers", &function_276d3342cddac11a );
    function_9d3850b024ab89b1( "modeXCamRespectsStartingTimeOnClients", &function_720d21706a7ff164 );
    function_9d3850b024ab89b1( "modeLetterbox", &function_f66b22351778fe49 );
    function_9d3850b024ab89b1( "modePlayerMatchingObjectForFemale", &function_d18c2d3d2819c322 );
    function_7855ec4caf5901f9( "Types_Player", "objectSetup", &function_c14ed0fc1a6ccf72 );
    function_7855ec4caf5901f9( "Types_Player", "shotObjectPlayAnim", &function_5fd2b7d3c29f131b );
    function_7855ec4caf5901f9( "Types_Player", "shotObjectStopAnim", &function_e3f3a0837cae6779 );
    function_7855ec4caf5901f9( "Types_Player", "objectSetAnimName", &function_24b6b2bfc5bdab36 );
    function_7855ec4caf5901f9( "Types_Player", "objectDelete", &player_delete );
    function_7855ec4caf5901f9( "Types_Player", "shotObjectPrepare", &function_43972bd744497667 );
    function_7855ec4caf5901f9( "Types_Player", "shotObjectCleanup", &function_8b3b351a42e84dc2 );
    function_7855ec4caf5901f9( "Types_Player", "objectMatchEntity", &function_70e05db9c7c6c130 );
    function_7855ec4caf5901f9( "Types_Player", "objectGetLinkEnts", &function_ca4527bcd586d366 );
    function_7855ec4caf5901f9( "Types_Player", "objectCleanup", &function_f5c1014e1cfdf615 );
    function_7855ec4caf5901f9( "Types_Player", "objectStoreAnimRequest", &function_8cd22f505439309f );
    function_7855ec4caf5901f9( "Types_Player", "objectClearAnimRequest", &function_3e4cf61872dc003b );
    function_7855ec4caf5901f9( "Types_Actor", "objectSpawn", &agent_spawn );
    function_7855ec4caf5901f9( "Types_Actor", "shotObjectPrepare", &function_61be92922a464251 );
    function_7855ec4caf5901f9( "Types_Actor", "objectMatchEntity", &function_12f50a9b21b4dd9a );
    function_7855ec4caf5901f9( "Types_Actor", "shotObjectPlayAnim", &function_43a42c8097aac565 );
    function_7855ec4caf5901f9( "Types_Actor", "shotObjectStopAnim", &function_2d573d9c69823343 );
    function_7855ec4caf5901f9( "Types_Actor", "objectDelete", &agent_delete );
    function_7855ec4caf5901f9( "Types_Actor", "shotObjectCleanup", &function_642077a65edc7954 );
    function_7855ec4caf5901f9( "Types_Actor", "shotObjectFirstFrame", &function_6dad63edc3390487 );
    function_7855ec4caf5901f9( "Types_Vehicle", "objectSpawn", &vehicle_spawn_mp );
    function_7855ec4caf5901f9( "Types_Vehicle", "shotObjectPlayAnim", &function_5552728c9588fd02 );
    function_7855ec4caf5901f9( "Types_Vehicle", "shotObjectStopAnim", &function_b8c3ea8ca94cea0c );
    function_7855ec4caf5901f9( "Types_Vehicle", "objectDelete", &vehicle_delete );
    function_7855ec4caf5901f9( "Types_Vehicle", "objectMatchEntity", &function_684629695ffebbdb );
    function_7855ec4caf5901f9( "Types_Vehicle", "objectSetAnimName", &function_2e11be8a4ef151b5 );
    function_7855ec4caf5901f9( "Types_Object", "shotObjectPlayAnim", &function_70bd06355933aec9 );
    function_7855ec4caf5901f9( "Types_Object", "shotObjectStopAnim", &function_cc538c3233d741af );
    function_7855ec4caf5901f9( "Types_Object", "shotObjectFirstFrame", &function_8bac7edf73a29d6b );
    function_7855ec4caf5901f9( "Types_Object", "objectTeleport", &function_e8800b55f7cbd5a4 );
    function_7855ec4caf5901f9( "Types_Object", "objectMatchEntity", &function_83f1be5a5eb5f706 );
    function_5a197e7b54a9091e();
    level thread function_e16b1ab0a35605d3( "onStartGameTypeFinished" );
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa47
// Size: 0x7d
function private function_70e05db9c7c6c130( entity )
{
    /#
        if ( function_2fbba7f29e8d78ce( self.index, entity ) )
        {
            entity.animname = self.sceneobject.variant_object.name;
            return 1;
        }
    #/
    
    sceneobjectdata = self;
    isplayerentity = isplayer( entity );
    
    if ( isdefined( isplayerentity ) )
    {
        if ( !function_ac04e049ff623301( entity, sceneobjectdata ) )
        {
            return 0;
        }
    }
    
    return isplayerentity;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xacd
// Size: 0x2f, Type: bool
function private function_72777e12c4307f96()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.var_59f9757349c241a1 );
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xb05
// Size: 0x2e
function private function_be5a45fff59957b()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_d192b38b7ad90242;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xb3c
// Size: 0x2e
function private function_306026c41bd7abbd()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_a6da0bee0f0e8948;
}

// Namespace scene / scripts\cp_mp\scene
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xb73
// Size: 0x87
function private set_character_models( bodymodelname, headmodelname, viewmodelname )
{
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
    }
    
    if ( !isagent( self ) )
    {
        bodymodelname = self getcustomizationbody();
        headmodelname = self getcustomizationhead();
        viewmodelname = self getcustomizationviewmodel();
    }
    
    self setmodel( bodymodelname );
    self setviewmodel( viewmodelname );
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xc02
// Size: 0x5b
function private function_ec6039191e7c076a( player, var_36a19240d8d46bc2, newheadmodel )
{
    assert( isdefined( player ) );
    assert( isplayer( player ) );
    player setcustomization( var_36a19240d8d46bc2, newheadmodel );
    var_e243ecbc215e7e07 = player getcustomizationviewmodel();
    player set_character_models( var_36a19240d8d46bc2, newheadmodel, var_e243ecbc215e7e07 );
}

// Namespace scene / scripts\cp_mp\scene
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xc65
// Size: 0x2d6
function private function_43972bd744497667( sceneplay, shotindex, objectindex )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    assert( isplayer( player ) );
    profilebeginevent( #"hash_d54b289d498be977" );
    
    if ( sceneobjectdata function_b4d836fe99f480e( shotindex ) )
    {
        player val::set( "scene_shot", "take_weapons", 1 );
    }
    
    scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
    
    if ( scenescriptbundle function_cf67ad1bae22e908() )
    {
        player function_e7257014ebaeeaa8( 1 );
    }
    
    player val::set( "scene_scene", "cinematic_motion", 0 );
    var_7fba0dfc25328161 = [ "offhand_weapons", "melee", "sprint", "allow_jump", "mantle", "tacmap_scoreboard", "backpack_inventory" ];
    
    if ( !istrue( sceneobjectdata.sceneobject.variant_object.allowusability ) )
    {
        var_7fba0dfc25328161 = array_add( var_7fba0dfc25328161, "usability" );
    }
    
    if ( sceneobjectdata.sceneobject function_d1dd52dc1f43215d( shotindex ) != "Keep" )
    {
        var_7fba0dfc25328161 = array_add( var_7fba0dfc25328161, "weapon" );
    }
    
    if ( !sceneobjectdata.sceneobject function_fcc766f42b75a322( shotindex ) )
    {
        var_7fba0dfc25328161 = array_add( var_7fba0dfc25328161, "weapon_switch" );
    }
    
    sceneobjectdata.entity val::set( "scene_shot", "freezecontrols", 1 );
    sceneobjectdata.entity val::set( "scene_shot", "swimming_underwater", 0 );
    profileendevent();
    profilebeginevent( #"hash_559bfd7b0925399d" );
    sceneobjectdata.entity val::set_array( "scene_shot", var_7fba0dfc25328161, 0 );
    profileendevent();
    
    if ( shotindex == sceneobjectdata.sceneplay.var_df5db7bd235f2729[ 0 ] )
    {
        if ( sceneobjectdata function_72777e12c4307f96() )
        {
            var_36a19240d8d46bc2 = player getcustomizationbody();
            newheadmodel = player getcustomizationhead();
            
            if ( !isdefined( sceneobjectdata.var_d5d84848169bf792 ) )
            {
                sceneobjectdata.var_d5d84848169bf792 = var_36a19240d8d46bc2;
            }
            
            if ( !isdefined( sceneobjectdata.var_79825563576bccb8 ) )
            {
                sceneobjectdata.var_79825563576bccb8 = newheadmodel;
            }
            
            var_9a843b7e2ec0ad7c = sceneobjectdata function_be5a45fff59957b();
            
            if ( isdefined( var_9a843b7e2ec0ad7c ) && var_9a843b7e2ec0ad7c.size > 0 )
            {
                var_36a19240d8d46bc2 = var_9a843b7e2ec0ad7c;
            }
            
            requestedheadmodel = sceneobjectdata function_306026c41bd7abbd();
            
            if ( isdefined( requestedheadmodel ) && requestedheadmodel.size > 0 )
            {
                newheadmodel = requestedheadmodel;
            }
            
            function_ec6039191e7c076a( player, var_36a19240d8d46bc2, newheadmodel );
        }
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf43
// Size: 0x10a
function private function_8b3b351a42e84dc2( shotindex )
{
    sceneobjectdata = self;
    
    if ( !isplayer( sceneobjectdata.entity ) )
    {
        return;
    }
    
    assert( isplayer( sceneobjectdata.entity ) );
    
    if ( shotindex == sceneobjectdata.sceneplay.var_df5db7bd235f2729[ sceneobjectdata.sceneplay.var_df5db7bd235f2729.size - 1 ] )
    {
        if ( sceneobjectdata function_72777e12c4307f96() )
        {
            if ( isdefined( sceneobjectdata.var_d5d84848169bf792 ) && isdefined( sceneobjectdata.var_79825563576bccb8 ) )
            {
                function_ec6039191e7c076a( sceneobjectdata.entity, sceneobjectdata.var_d5d84848169bf792, sceneobjectdata.var_79825563576bccb8 );
                sceneobjectdata.var_d5d84848169bf792 = undefined;
                sceneobjectdata.var_79825563576bccb8 = undefined;
            }
        }
        
        function_2d5d63169291228e( sceneobjectdata.entity, shotindex );
    }
    
    sceneobjectdata.entity val::reset_all( "scene_shot" );
}

// Namespace scene / scripts\cp_mp\scene
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x1055
// Size: 0x37e
function private function_5fd2b7d3c29f131b( shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    sceneobjectdata endon( "scene_stop" );
    sceneobjectdata endon( "scene_play_anim" );
    
    if ( !isplayer( player ) )
    {
        if ( is_equal( player, sceneobjectdata.replacemententity ) )
        {
            if ( isagent( player ) )
            {
                var_7c6075e90a7b0fa = sceneobjectdata function_23cc62938b72190b();
                var_e5b70543a43b4c89 = player function_d28a53b100cbdda7( sceneobjectdata, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, var_7c6075e90a7b0fa );
                return var_e5b70543a43b4c89;
            }
            else
            {
                var_e5b70543a43b4c89 = sceneobjectdata function_70bd06355933aec9( shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime );
                return var_e5b70543a43b4c89;
            }
        }
        else
        {
            sceneobjectdata function_bf0d14daf3e53248( animasset, sceneobjectdata.activeanimationtype, notifystring );
            sceneobjectdata function_68056529c69f4097( sceneobjectdata.activeanimationtype, shotindex, animindex );
            return 0;
        }
    }
    
    var_409dc6bbf1421f94 = sceneobjectdata function_5fe020a6db35fab3( shotindex );
    player val::set_array( "scene_shot", var_409dc6bbf1421f94, 0 );
    
    if ( sceneobjectdata.activeanimationtype == "CameraAnimation" )
    {
        sceneobjectdata thread object_play_anim_waittill_end( animasset, [ player ], "death_or_disconnect", "CameraAnimation", notifystring );
        sceneobjectdata.xcamplaying = 1;
        return sceneobjectdata function_bae0f68830d519ad( "scene_shot", player, animasset, var_866b3a3066122e39, notifystring, alignmentinfo, shotindex );
    }
    
    player val::set( "scene_shot", "cinematics_participant", 1 );
    var_2e2a2f75fd49152a = getanimname( animasset );
    n_anim_length = getanimlength( animasset );
    player setorigin( alignmentinfo.origin );
    player setplayerangles( alignmentinfo.angles );
    var_d0cbd253b25b43f5 = istrue( sceneobjectdata.xcamplaying ) && sceneobjectdata.sceneobject.variant_object.shots[ shotindex ].deltaanimations.size == 1;
    var_9ebbc3376d9ce8f2 = sceneobjectdata function_d776460a61b689bf( shotindex );
    var_d8ab3f21c6db562e = !var_9ebbc3376d9ce8f2;
    
    if ( var_9ebbc3376d9ce8f2 )
    {
        function_639a0acd683457ec( player, shotindex );
    }
    else
    {
        function_2d5d63169291228e( player, shotindex );
    }
    
    sceneobjectdata childthread function_8e9f8e1fbe2b7ab4( notifystring, animasset );
    profilebeginevent( #"hash_e45c00238da3528c" );
    player playanimscriptsceneevent( "scripted_scene", var_2e2a2f75fd49152a, var_d8ab3f21c6db562e );
    profileendevent();
    sceneobjectdata function_bdfc45b799d27532( animasset );
    
    if ( var_9ebbc3376d9ce8f2 )
    {
        n_anim_length = function_a7bfaa03b4d58c00( player, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, n_anim_length );
    }
    else if ( var_d0cbd253b25b43f5 )
    {
        n_start_time = gettime();
        player waittill_any_timeout_2( n_anim_length, "stop_animmode", "death_or_disconnect" );
        var_ef8433621bf198f1 = function_c89ed1840c8d0f0f( gettime() - n_start_time );
        println( "<dev string:x1c>" + var_ef8433621bf198f1 + "<dev string:x41>" + getxhashsourcename( var_2e2a2f75fd49152a ) + "<dev string:x58>" + n_anim_length + "<dev string:x67>" + n_anim_length - var_ef8433621bf198f1 + "<dev string:x7c>" );
        n_anim_length = var_ef8433621bf198f1;
    }
    else
    {
        wait n_anim_length;
    }
    
    return n_anim_length;
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x13dc
// Size: 0x145
function private function_639a0acd683457ec( player, shotindex )
{
    sceneobjectdata = self;
    var_9ebbc3376d9ce8f2 = sceneobjectdata function_d776460a61b689bf( shotindex );
    
    if ( var_9ebbc3376d9ce8f2 && !isdefined( player.var_7c6c008ca46286b0 ) )
    {
        player.var_7c6c008ca46286b0 = spawn( "script_arms", player.origin, 0, 0, player );
        player.var_7c6c008ca46286b0.animname = sceneobjectdata.sceneobject.variant_object.name;
        player.var_7c6c008ca46286b0 useanimtree( sceneobjectdata.sceneobject function_c106523f3836b90b() );
        player.var_7c6c008ca46286b0 hide();
        player.var_7c6c008ca46286b0.entity = player;
        player.var_7c6c008ca46286b0 showonlytoplayer( player );
        player.var_7c6c008ca46286b0.noragdoll = 1;
        player.var_7c6c008ca46286b0 val::set( "scene_scene", "cinematics_participant", 1 );
        thread function_382ab03066aa1207( player, player.var_7c6c008ca46286b0 );
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1529
// Size: 0x74
function private function_382ab03066aa1207( player, rig )
{
    rig endon( "death_or_disconnect" );
    var_d1259a4ca338a8bd = 1;
    
    while ( isdefined( player ) )
    {
        var_8c9a37d8546a9e51 = player getcamerathirdperson();
        
        if ( var_8c9a37d8546a9e51 && var_d1259a4ca338a8bd )
        {
            rig hide();
            var_d1259a4ca338a8bd = 0;
        }
        else if ( !var_8c9a37d8546a9e51 && !var_d1259a4ca338a8bd )
        {
            rig showonlytoplayer( player );
            var_d1259a4ca338a8bd = 1;
        }
        
        waitframe();
    }
    
    rig delete();
}

// Namespace scene / scripts\cp_mp\scene
// Params 11, eflags: 0x4
// Checksum 0x0, Offset: 0x15a5
// Size: 0x2b7
function private function_a7bfaa03b4d58c00( player, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, n_anim_length )
{
    sceneobjectdata = self;
    function_639a0acd683457ec( player, shotindex );
    arcright = sceneobjectdata.sceneobject function_918dc2e0c83784b6( shotindex );
    arcleft = sceneobjectdata.sceneobject function_16b4cb7e4c5af0fd( shotindex );
    arctop = sceneobjectdata.sceneobject function_b06da1547120edef( shotindex );
    arcbottom = sceneobjectdata.sceneobject function_be3310ec58dd9807( shotindex );
    usetagangles = sceneobjectdata.sceneobject function_8851aea907b47f88( shotindex );
    viewfraction = sceneobjectdata.sceneobject function_b083c5862877c8e3( shotindex );
    var_e854c1a35488c7d6 = function_a89f1262c5148bdf();
    player playerlinktoblend( player.var_7c6c008ca46286b0, var_e854c1a35488c7d6, lerptime );
    player playerlinktodelta( player.var_7c6c008ca46286b0, var_e854c1a35488c7d6, viewfraction, arcright, arcleft, arctop, arcbottom, usetagangles, 1, 1 );
    player lerpviewangleclamp( blendtime, blendtime * 0.5, blendtime * 0.25, arcright, arcleft, arctop, arcbottom, 1 );
    player.var_7c6c008ca46286b0 showonlytoplayer( player );
    var_6325cb53ec163839 = "none";
    
    if ( blendtime > 0 && blendtime < 1 )
    {
        var_6325cb53ec163839 = "normal";
    }
    else if ( blendtime >= 1 )
    {
        var_6325cb53ec163839 = "slow";
    }
    
    var_2e2a2f75fd49152a = getanimname( animasset );
    var_4fdfa3b181211e22 = var_866b3a3066122e39 * n_anim_length;
    
    if ( sceneobjectdata function_7f90ebd0aa7ad958( shotindex ) )
    {
        player.var_7c6c008ca46286b0 animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
        player.var_7c6c008ca46286b0 scriptmodelplayanim( var_2e2a2f75fd49152a, undefined, var_4fdfa3b181211e22, undefined, var_6325cb53ec163839 );
        player.var_7c6c008ca46286b0 function_ee012c2dd711a8ce( notifystring, "end", "stop_animmode" );
    }
    else
    {
        player.var_7c6c008ca46286b0 scriptmodelplayanim( var_2e2a2f75fd49152a, undefined, var_4fdfa3b181211e22, undefined, var_6325cb53ec163839 );
        player.var_7c6c008ca46286b0 waittill_any_timeout_1( getanimlength( animasset ), "stop_animmode" );
        player.var_7c6c008ca46286b0 notify( notifystring, "end" );
    }
    
    return n_anim_length - var_4fdfa3b181211e22;
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1865
// Size: 0x7b
function private function_2d5d63169291228e( player, shotindex )
{
    sceneobjectdata = self;
    
    if ( isdefined( player.var_7c6c008ca46286b0 ) )
    {
        if ( isdefined( shotindex ) )
        {
            tweenout = sceneobjectdata.sceneobject function_be64404b86d48153( shotindex );
            player playerunlinkblend( tweenout );
        }
        else
        {
            player playerunlinkblend( 0 );
        }
        
        player stopanimscriptsceneevent();
        player.var_7c6c008ca46286b0 delete();
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18e8
// Size: 0x52
function private function_c14ed0fc1a6ccf72( sceneplay )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    shotindex = sceneplay.var_df5db7bd235f2729[ 0 ];
    
    if ( isdefined( player ) )
    {
        function_639a0acd683457ec( player, shotindex );
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1942
// Size: 0x51
function private function_ca4527bcd586d366()
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    
    if ( !isdefined( player ) )
    {
        return [];
    }
    
    if ( isdefined( player.var_7c6c008ca46286b0 ) )
    {
        return [ player.var_7c6c008ca46286b0 ];
    }
    
    return [ player ];
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x199c
// Size: 0x68
function private function_f5c1014e1cfdf615( newsceneroot )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    sceneobjectdata function_2f2327d535ed0bb();
    
    if ( isdefined( player ) )
    {
        scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
        
        if ( scenescriptbundle function_cf67ad1bae22e908() )
        {
            player function_e7257014ebaeeaa8( 0 );
        }
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1a0c
// Size: 0x80
function private function_e3f3a0837cae6779()
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    sceneobjectdata function_2f2327d535ed0bb();
    
    if ( isdefined( player ) )
    {
        player notify( "stop_loop" );
        player notify( "single anim", "end" );
        player notify( "looping anim", "end" );
        player notify( "stop_animmode" );
        
        if ( isplayer( player ) )
        {
            player stopanimscriptsceneevent();
        }
        
        function_2d5d63169291228e( player );
        player val::reset_all( "scene_shot" );
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1a94
// Size: 0x20
function private function_24b6b2bfc5bdab36( animname, animtree )
{
    sceneobjectdata = self;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1abc
// Size: 0x2
function private player_delete()
{
    
}

// Namespace scene / scripts\cp_mp\scene
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0x1ac6
// Size: 0x1e8
function private function_8cd22f505439309f( shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, animationtype )
{
    if ( animationtype != "DeltaAnimation" )
    {
        return;
    }
    
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.var_b2de9e740fef7506 ) )
    {
        sceneobjectdata.var_b2de9e740fef7506 = spawnstruct();
    }
    
    sceneobjectdata.var_b2de9e740fef7506.newrequest = 1;
    sceneobjectdata.var_b2de9e740fef7506.shotindex = shotindex;
    sceneobjectdata.var_b2de9e740fef7506.animindex = animindex;
    sceneobjectdata.var_b2de9e740fef7506.notifystring = notifystring;
    sceneobjectdata.var_b2de9e740fef7506.alignmentinfo = alignmentinfo;
    sceneobjectdata.var_b2de9e740fef7506.alignmentinfo.origin = alignmentinfo.origin;
    sceneobjectdata.var_b2de9e740fef7506.alignmentinfo.angles = alignmentinfo.angles;
    sceneobjectdata.var_b2de9e740fef7506.animasset = animasset;
    sceneobjectdata.var_b2de9e740fef7506.var_866b3a3066122e39 = var_866b3a3066122e39;
    sceneobjectdata.var_b2de9e740fef7506.blendtime = blendtime;
    sceneobjectdata.var_b2de9e740fef7506.blendcurve = blendcurve;
    sceneobjectdata.var_b2de9e740fef7506.lerptime = lerptime;
    sceneobjectdata.var_b2de9e740fef7506.var_fe62dc1bdc14feca = gettime();
}

// Namespace scene / scripts\cp_mp\scene
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1cb6
// Size: 0x8a
function private function_3e4cf61872dc003b( animationtype, shotindex, animindex )
{
    if ( !isdefined( animationtype ) || animationtype != "DeltaAnimation" )
    {
        return;
    }
    
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.var_b2de9e740fef7506 ) )
    {
        return;
    }
    
    if ( shotindex == sceneobjectdata.var_b2de9e740fef7506.shotindex && animindex == sceneobjectdata.var_b2de9e740fef7506.animindex )
    {
        sceneobjectdata.var_b2de9e740fef7506 = undefined;
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1d48
// Size: 0x24b
function private agent_spawn( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.sceneobject.variant_object.aitypename ) )
    {
        sceneobjectassettype = "aitype";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.aitypename;
    }
    else if ( isdefined( sceneobjectdata.sceneobject.variant_object.charactername ) )
    {
        sceneobjectassettype = "character";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.charactername;
    }
    else
    {
        sceneobjectassettype = "xmodel";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.xmodelname;
    }
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        if ( isagent( sceneobjectdata.entity ) )
        {
            sceneobjectdata.entity scripts\cp_mp\agents\agent_utils::despawnagent();
        }
        else
        {
            sceneobjectdata.entity delete();
        }
    }
    
    entity = undefined;
    var_e94f24c42205140 = "team_eighty";
    
    if ( sceneobjectassettype == "aitype" )
    {
        if ( isdefined( sceneobjectdata.sceneobject.variant_object.aisubclass ) )
        {
            var_e51bc72666444e2d = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc( sceneobjectdata.sceneobject.variant_object.aisubclass );
            var_3a7ad9d5e8329009 = random( var_e51bc72666444e2d );
            sceneobjectassetname = default_to( var_3a7ad9d5e8329009, sceneobjectassetname );
        }
        
        if ( scripts\engine\utility::issharedfuncdefined( "ai", "get_aitype_default_spawn_team_SharedFunc" ) )
        {
            var_e94f24c42205140 = namespace_53fc9ddbb516e6e1::get_aitype_default_spawn_team_sharedfunc();
        }
        
        if ( scripts\engine\utility::issharedfuncdefined( "ai", "spawnNewAIType_SharedFunc" ) )
        {
            entity = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc( sceneobjectassetname, spawnorigin, spawnangles, var_e94f24c42205140 );
        }
        else
        {
            entity = scripts\mp\mp_agent::spawnnewagentaitype( sceneobjectassetname, spawnorigin, spawnangles, var_e94f24c42205140 );
        }
        
        entity useanimtree( sceneobjectdata.sceneobject.variant_object.animtree.id );
    }
    
    return entity;
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1f9c
// Size: 0x28, Type: bool
function private function_12f50a9b21b4dd9a( entity )
{
    sceneobjectdata = self;
    return isagent( entity ) && isalive( entity );
}

// Namespace scene / scripts\cp_mp\scene
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1fcd
// Size: 0x25
function private function_61be92922a464251( sceneplay, shotindex, objectindex )
{
    function_bea88b25e17cea66( sceneplay, shotindex, objectindex );
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1ffa
// Size: 0xd7
function private function_6dad63edc3390487( alignmentinfo, shotindex )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    shotanimations = sceneobjectdata.sceneobject function_79edcc9987330a2a( shotindex );
    
    if ( shotanimations.size != 0 )
    {
        animasset = shotanimations[ 0 ];
        function_549578bb9e3f4f78( entity, alignmentinfo, animasset, undefined, undefined, undefined, 0 );
        
        /#
            function_ce4b6d4d859ede39( sceneobjectdata, "<dev string:x81>" + getxhashsourcename( getanimname( animasset ) ), entity.origin, entity.angles );
        #/
        
        /#
            function_ce4b6d4d859ede39( sceneobjectdata, "<dev string:x91>" + getxhashsourcename( getanimname( animasset ) ), alignmentinfo.origin, alignmentinfo.angles );
        #/
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x20d9
// Size: 0x90
function private function_43a42c8097aac565( shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    var_d77e596283581825 = entity function_d28a53b100cbdda7( sceneobjectdata, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, undefined );
    return var_d77e596283581825;
}

// Namespace scene / scripts\cp_mp\scene
// Params 7, eflags: 0x4
// Checksum 0x0, Offset: 0x2172
// Size: 0x292
function private function_549578bb9e3f4f78( entity, alignmentinfo, animasset, var_7c6075e90a7b0fa, lerptime, var_866b3a3066122e39, animrate )
{
    if ( !isdefined( lerptime ) )
    {
        lerptime = 0;
    }
    
    if ( !isdefined( var_866b3a3066122e39 ) )
    {
        var_866b3a3066122e39 = 0;
    }
    
    if ( !isdefined( animrate ) )
    {
        animrate = 1;
    }
    
    sceneobjectdata = self;
    
    if ( !isagent( entity ) || !isalive( entity ) )
    {
        return;
    }
    
    function_e4fc30ccdca08b9d( alignmentinfo );
    var_2e2a2f75fd49152a = getanimname( animasset );
    entity.var_34a25b21bc155d14 = sceneobjectdata.sceneobject.variant_object.var_7c6075e90a7b0fa;
    
    if ( isdefined( var_7c6075e90a7b0fa ) )
    {
        entity.var_34a25b21bc155d14 = var_7c6075e90a7b0fa;
    }
    
    if ( isdefined( entity.var_34a25b21bc155d14 ) )
    {
        entity setoverridearchetype( "animscript", entity.var_34a25b21bc155d14, 0 );
    }
    
    entity asmsetstate( entity.asmname, "animscripted" );
    animindex = entity asm_lookupanimfromalias( "animscripted", var_2e2a2f75fd49152a );
    entity.var_b65a7211c663d3ed = animindex;
    entity animmode( "noclip" );
    startorigin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, animasset );
    startangles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, animasset );
    
    if ( lerptime == 0 )
    {
        entity dontinterpolate();
    }
    
    entity orientmode( "face angle", entity.angles[ 1 ] );
    entity scripts\asm\asm_bb::bb_setanimscripted();
    
    if ( isdefined( entity.scripted_mode ) )
    {
        entity.scripted_mode = 1;
    }
    
    if ( isent( alignmentinfo.alignent ) )
    {
        entity unlink();
        entity forceteleport( startorigin, startangles );
        
        if ( isdefined( alignmentinfo.aligntag ) )
        {
            entity linktomoveoffset( alignmentinfo.alignent, alignmentinfo.aligntag );
        }
        else
        {
            entity linktomoveoffset( alignmentinfo.alignent );
        }
    }
    else
    {
        entity forceteleport( startorigin, startangles );
    }
    
    entity aisetanim( "animscripted", animindex, animrate, var_866b3a3066122e39 );
    entity callback::remove( "on_ai_killed", &function_c1a5da4f68a742a6, 1 );
    entity callback::add( "on_ai_killed", &function_c1a5da4f68a742a6 );
}

// Namespace scene / scripts\cp_mp\scene
// Params 11, eflags: 0x4
// Checksum 0x0, Offset: 0x240c
// Size: 0x21d
function private function_d28a53b100cbdda7( sceneobjectdata, shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime, var_7c6075e90a7b0fa )
{
    entity = self;
    entity endon( "scene_monitor_players_agent_will_be_despawned" );
    entity endon( "scene_monitor_players_new_animation_for_agent" );
    entity endon( "agent_scene_stop" );
    entity endon( "death_or_disconnect" );
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isagent( entity ) )
    {
        return;
    }
    
    if ( !isalive( entity ) )
    {
        return;
    }
    
    blendtime = default_to( blendtime, 0 );
    lerptime = default_to( lerptime, 0 );
    
    if ( isdefined( sceneobjectdata.scenedata.var_43286fd46706909c ) )
    {
        blendtime = 0;
        lerptime = 0;
    }
    
    var_2e2a2f75fd49152a = getanimname( animasset );
    n_anim_length = getanimlength( animasset );
    var_7a4a31d740c51ee8 = n_anim_length - var_866b3a3066122e39 * n_anim_length;
    
    if ( var_866b3a3066122e39 < 1 )
    {
        sceneobjectdata childthread function_8e9f8e1fbe2b7ab4( notifystring, animasset );
    }
    
    sceneobjectdata function_549578bb9e3f4f78( entity, alignmentinfo, animasset, var_7c6075e90a7b0fa, lerptime, var_866b3a3066122e39 );
    sceneobjectdata function_bdfc45b799d27532( animasset );
    
    if ( var_866b3a3066122e39 < 1 )
    {
        if ( animislooping( animasset ) )
        {
            while ( true )
            {
                var_6fde8947aa74cf43 = entity scripts\asm\asm::asm_donotetracks( entity.asmname, "animscripted", scripts\asm\asm::asm_getnotehandler( entity.asmname, "animscripted" ) );
                
                if ( is_equal( var_6fde8947aa74cf43, "end" ) )
                {
                    break;
                }
            }
        }
        else
        {
            wait var_7a4a31d740c51ee8;
        }
    }
    
    entity.var_b65a7211c663d3ed = undefined;
    
    if ( isdefined( entity.scripted_mode ) )
    {
        entity.scripted_mode = 0;
    }
    
    entity scripts\asm\asm_bb::bb_clearanimscripted();
    entity orientmode( "face current" );
    entity animmode( "none" );
    
    if ( isdefined( entity.var_34a25b21bc155d14 ) )
    {
        entity clearoverridearchetype( "animscript" );
        entity.var_34a25b21bc155d14 = undefined;
    }
    
    return var_7a4a31d740c51ee8;
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2632
// Size: 0x70
function private function_c1a5da4f68a742a6( params )
{
    if ( isdefined( self ) )
    {
        if ( isdefined( self.var_34a25b21bc155d14 ) )
        {
            self clearoverridearchetype( "animscript" );
            self.var_34a25b21bc155d14 = undefined;
        }
        
        if ( isdefined( self.sceneobjectdata ) )
        {
            self.sceneobjectdata.entity = undefined;
            self.sceneobjectdata = undefined;
        }
        
        callback::remove( "on_ai_killed", &function_c1a5da4f68a742a6, 1 );
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x26aa
// Size: 0x182
function private function_2d573d9c69823343()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity notify( "stop_loop" );
        sceneobjectdata.entity notify( "single anim", "end" );
        sceneobjectdata.entity notify( "looping anim", "end" );
        sceneobjectdata.entity notify( "stop_animmode" );
        sceneobjectdata.entity notify( "agent_scene_stop" );
        
        if ( isdefined( sceneobjectdata.entity.scripted_mode ) )
        {
            sceneobjectdata.entity.scripted_mode = 0;
        }
        
        if ( isalive( sceneobjectdata.entity ) && sceneobjectdata.entity scripts\asm\asm_bb::bb_isanimscripted() )
        {
            sceneobjectdata.entity scripts\asm\asm_bb::bb_clearanimscripted();
        }
        
        sceneobjectdata.entity orientmode( "face current" );
        sceneobjectdata.entity animmode( "none" );
        sceneobjectdata.entity stopanimscripted();
        sceneobjectdata.entity.var_b65a7211c663d3ed = undefined;
        
        if ( isdefined( sceneobjectdata.entity.var_34a25b21bc155d14 ) )
        {
            sceneobjectdata.entity clearoverridearchetype( "animscript" );
            sceneobjectdata.entity.var_34a25b21bc155d14 = undefined;
        }
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2834
// Size: 0x6f
function private agent_delete()
{
    sceneobjectdata = self;
    
    if ( isagent( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity.nocorpse = 1;
        sceneobjectdata.entity scripts\cp_mp\agents\agent_utils::despawnagent();
        return;
    }
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity delete();
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x28ab
// Size: 0x128
function private function_642077a65edc7954( shotindex )
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.entity ) )
    {
        return;
    }
    
    if ( isdefined( sceneobjectdata.entity.scripted_mode ) )
    {
        sceneobjectdata.entity.scripted_mode = 0;
    }
    
    if ( isalive( sceneobjectdata.entity ) && sceneobjectdata.entity scripts\asm\asm_bb::bb_isanimscripted() )
    {
        sceneobjectdata.entity scripts\asm\asm_bb::bb_clearanimscripted();
    }
    
    sceneobjectdata.entity orientmode( "face current" );
    sceneobjectdata.entity animmode( "none" );
    sceneobjectdata.entity stopanimscripted();
    sceneobjectdata.entity.var_b65a7211c663d3ed = undefined;
    
    if ( isdefined( sceneobjectdata.entity.var_34a25b21bc155d14 ) )
    {
        sceneobjectdata.entity clearoverridearchetype( "animscript" );
        sceneobjectdata.entity.var_34a25b21bc155d14 = undefined;
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x29db
// Size: 0x32b
function private function_70bd06355933aec9( shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    animlengthtime = 0;
    done = 0;
    
    if ( entity.model == "" )
    {
        println( "<dev string:xa7>" + sceneobjectdata.sceneobject.variant_object.name + "<dev string:xda>" );
        return 0;
    }
    
    entity val::set( "scene_shot", "cinematics_participant", 1 );
    
    if ( isdefined( sceneobjectdata.scenedata.var_43286fd46706909c ) )
    {
        blendtime = 0;
        lerptime = 0;
    }
    
    var_2e2a2f75fd49152a = getanimname( animasset );
    function_e4fc30ccdca08b9d( alignmentinfo );
    var_6325cb53ec163839 = "none";
    
    if ( blendtime > 0 && blendtime < 1 )
    {
        var_6325cb53ec163839 = "normal";
    }
    else if ( blendtime >= 1 )
    {
        var_6325cb53ec163839 = "slow";
    }
    
    starttimeinseconds = 0;
    
    if ( isdefined( var_866b3a3066122e39 ) && var_866b3a3066122e39 > 0 )
    {
        starttimeinseconds = getanimlength( animasset ) * var_866b3a3066122e39;
    }
    
    if ( var_866b3a3066122e39 < 1 )
    {
        sceneobjectdata childthread function_8e9f8e1fbe2b7ab4( notifystring, animasset );
    }
    
    if ( sceneobjectdata function_7f90ebd0aa7ad958( shotindex ) )
    {
        var_6db82a0c287ea33 = sceneobjectdata.scenedata.scenescriptbundle function_ee55ab255c0be00d();
        
        if ( var_6db82a0c287ea33 == "AnimScripted" )
        {
            entity scriptmodelclearanim();
            entity useanimtree( sceneobjectdata.sceneobject function_c106523f3836b90b() );
            entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
            entity scriptmodelplayanim( var_2e2a2f75fd49152a, undefined, starttimeinseconds, 1, var_6325cb53ec163839 );
            sceneobjectdata function_bdfc45b799d27532( animasset );
            
            if ( var_866b3a3066122e39 < 1 )
            {
                entity function_ee012c2dd711a8ce( notifystring, "end", "stop_animmode" );
            }
        }
        else if ( var_6db82a0c287ea33 == "ScriptModelPlayAnimDeltaMotionFromPos" )
        {
            entity stopuseanimtree();
            entity scriptmodelplayanimdeltamotionfrompos( var_2e2a2f75fd49152a, alignmentinfo.origin, alignmentinfo.angles, notifystring, starttimeinseconds, var_6325cb53ec163839 );
            sceneobjectdata function_bdfc45b799d27532( animasset );
            
            if ( var_866b3a3066122e39 < 1 )
            {
                entity function_ee012c2dd711a8ce( notifystring, "end", "stop_animmode" );
            }
        }
    }
    else
    {
        entity stopuseanimtree();
        entity scriptmodelplayanim( var_2e2a2f75fd49152a, notifystring, starttimeinseconds, 1, var_6325cb53ec163839 );
        sceneobjectdata function_bdfc45b799d27532( animasset );
        entity function_ee012c2dd711a8ce( notifystring, "end", "stop_animmode" );
        entity scriptmodelclearanim();
        entity useanimtree( sceneobjectdata.sceneobject function_c106523f3836b90b() );
    }
    
    animlengthtime += getanimlength( animasset );
    return animlengthtime - var_866b3a3066122e39 * animlengthtime;
}

// Namespace scene / scripts\cp_mp\scene
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x2d0f
// Size: 0x2d4
function private function_5552728c9588fd02( shotindex, animindex, notifystring, alignmentinfo, animasset, var_866b3a3066122e39, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    animlengthtime = 0;
    done = 0;
    
    if ( entity.model == "" )
    {
        println( "<dev string:xa7>" + sceneobjectdata.sceneobject.variant_object.name + "<dev string:xda>" );
        return 0;
    }
    
    entity endon( "death_or_disconnect" );
    entity endon( "vehicle_scene_stop" );
    blendtime = default_to( blendtime, 0 );
    lerptime = default_to( lerptime, 0 );
    
    if ( isdefined( sceneobjectdata.scenedata.var_43286fd46706909c ) )
    {
        blendtime = 0;
        lerptime = 0;
    }
    
    var_2e2a2f75fd49152a = getanimname( animasset );
    function_e4fc30ccdca08b9d( alignmentinfo );
    
    if ( entity vehicle_isphysveh() )
    {
        entity function_247ad6a91f6a4ffe( 1 );
        entity vehphys_forcekeyframedmotion();
    }
    else
    {
        entity notsolid();
    }
    
    if ( lerptime == 0 )
    {
        entity dontinterpolate();
    }
    
    startorigin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, animasset );
    startangles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, animasset );
    entity vehicle_teleport( startorigin, startangles );
    
    if ( var_866b3a3066122e39 < 1 )
    {
        sceneobjectdata childthread function_8e9f8e1fbe2b7ab4( notifystring, animasset );
    }
    
    entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
    entity vehicleplayanim( animasset );
    sceneobjectdata function_bdfc45b799d27532( animasset );
    
    if ( isdefined( var_866b3a3066122e39 ) && var_866b3a3066122e39 > 0 && var_866b3a3066122e39 <= 1 )
    {
        if ( var_866b3a3066122e39 == 1 && animislooping( animasset ) )
        {
            var_866b3a3066122e39 = 0.999;
        }
        
        sceneobjectdata function_380708345e16e475( animasset, var_866b3a3066122e39 );
    }
    
    animlengthtime += getanimlength( animasset );
    n_wait_time = animlengthtime - var_866b3a3066122e39 * animlengthtime;
    
    if ( var_866b3a3066122e39 < 1 )
    {
        wait n_wait_time;
    }
    
    if ( entity vehicle_isphysveh() )
    {
        entity function_247ad6a91f6a4ffe( 0 );
        entity vehphys_setdefaultmotion();
    }
    else
    {
        entity solid();
    }
    
    if ( isdefined( entity.var_cb77a772d04fc8e4 ) )
    {
        entity thread [[ entity.var_cb77a772d04fc8e4 ]]();
    }
    
    return n_wait_time;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2fec
// Size: 0xdd
function private function_b8c3ea8ca94cea0c()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity notify( "stop_loop" );
        sceneobjectdata.entity notify( "single anim", "end" );
        sceneobjectdata.entity notify( "looping anim", "end" );
        sceneobjectdata.entity notify( "stop_animmode" );
        sceneobjectdata.entity notify( "vehicle_scene_stop" );
        sceneobjectdata.entity stopanimscripted();
        
        if ( sceneobjectdata.entity vehicle_isphysveh() )
        {
            sceneobjectdata.entity function_247ad6a91f6a4ffe( 0 );
            sceneobjectdata.entity vehphys_setdefaultmotion();
            return;
        }
        
        sceneobjectdata.entity solid();
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x30d1
// Size: 0x14e
function private vehicle_spawn_mp( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.sceneobject.variant_object.vehiclename ) )
    {
        sceneobjectassettype = "vehicle";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.vehiclename;
    }
    else
    {
        sceneobjectassettype = "xmodel";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.xmodelname;
    }
    
    if ( !isdefined( sceneobjectdata.entity ) )
    {
        if ( sceneobjectassettype == "vehicle" )
        {
            spawndata = spawnstruct();
            spawndata.origin = spawnorigin;
            spawndata.angles = spawnangles;
            spawndata.vehicletype = sceneobjectassetname;
            spawndata.targetname = "scene_vehicle";
            spawndata.modelname = vehicle_modelname( sceneobjectassetname );
            sceneobjectdata.entity = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle( spawndata );
        }
        else
        {
            sceneobjectdata.entity = utility::spawn_model( sceneobjectassetname, spawnorigin, spawnangles );
        }
    }
    
    return sceneobjectdata.entity;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3228
// Size: 0x2f
function private vehicle_delete()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity delete();
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x325f
// Size: 0x12
function private function_684629695ffebbdb( entity )
{
    return entity scripts\common\vehicle::isvehicle();
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x327a
// Size: 0x60
function private function_2e11be8a4ef151b5( animname, animtree )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) && !isdefined( sceneobjectdata.entity.animname ) )
    {
        sceneobjectdata.entity.animname = animname;
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x32e2
// Size: 0x92
function private function_cc538c3233d741af()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity stopanimscripted();
        sceneobjectdata.entity scriptmodelclearanim();
        sceneobjectdata.entity notify( "stop_loop" );
        sceneobjectdata.entity notify( "single anim", "end" );
        sceneobjectdata.entity notify( "looping anim", "end" );
        sceneobjectdata.entity notify( "stop_animmode" );
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x337c
// Size: 0x40
function private function_8bac7edf73a29d6b( alignmentinfo, shotindex )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity scriptmodelclearanim();
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x33c4
// Size: 0x95
function private function_e8800b55f7cbd5a4( origin, angles )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( isdefined( entity ) )
    {
        if ( !isagent( entity ) && !isplayer( entity ) && entity.model != "" )
        {
            entity scriptmodelclearanim();
        }
        
        entity dontinterpolate();
        
        if ( isdefined( origin ) )
        {
            entity.origin = origin;
        }
        
        if ( isdefined( angles ) )
        {
            entity.angles = angles;
        }
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3461
// Size: 0x33, Type: bool
function private function_83f1be5a5eb5f706( entity )
{
    if ( isdefined( entity.classname ) && entity.classname == "script_model" )
    {
        return true;
    }
    
    return false;
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x349d
// Size: 0xa8
function private function_d776460a61b689bf( shotindex )
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.sceneobject.variant_object.shots ) )
    {
        return 0;
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return 0;
    }
    
    shotobject = sceneobjectdata.sceneobject.variant_object.shots[ shotindex ];
    return default_to( shotobject.var_25a8d725d83b4fc1, 0 );
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x354e
// Size: 0x2a, Type: bool
function private function_4e15410d3aae945c()
{
    sceneobjectdata = self;
    agenttype = sceneobjectdata function_a2142af2db8fbb0();
    return isdefined( agenttype ) && agenttype.size > 0;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3581
// Size: 0x2e
function private function_f66e8916121d9737()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_8e16e8d6f4501d72;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x35b8
// Size: 0x2e
function private function_a2142af2db8fbb0()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_ab73f93a436a7409;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x35ef
// Size: 0x2e
function private function_7c9fcb0161b76b2d()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_ed40a4854b93740c;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3626
// Size: 0x2e
function private function_23cc62938b72190b()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_6b7d083fa865688a;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x365d
// Size: 0x5e5
function private function_22f6fca8362a92b()
{
    sceneplay = self;
    sceneplay endon( "Stopped" );
    scenedata = sceneplay.sceneroot.scenedata;
    
    if ( !isdefined( sceneplay.var_ca29a69dc742b367 ) )
    {
        sceneplay.var_ca29a69dc742b367 = [];
    }
    
    var_6e050937039896b9 = 0;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata object_get_type() == "Types_Player" )
        {
            sceneplay.var_ca29a69dc742b367[ var_6e050937039896b9 ] = spawnstruct();
            sceneplay.var_ca29a69dc742b367[ var_6e050937039896b9 ].replacementallowed = 1;
            
            if ( sceneobjectdata function_3e13497ed7044cbd() )
            {
                if ( isdefined( sceneobjectdata.var_17f5321d96d1bf24 ) )
                {
                    if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_17f5321d96d1bf24 ].entity ) )
                    {
                        sceneplay.var_ca29a69dc742b367[ var_6e050937039896b9 ].replacementallowed = 0;
                    }
                }
            }
            else if ( isdefined( sceneobjectdata.var_9668be326e00024b ) )
            {
                if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_9668be326e00024b ].entity ) )
                {
                    sceneplay.var_ca29a69dc742b367[ var_6e050937039896b9 ].replacementallowed = 0;
                }
            }
            
            var_6e050937039896b9++;
        }
    }
    
    sceneplay function_a8bfee1f6abe8209();
    
    while ( true )
    {
        waittillframeend();
        playerindex = 0;
        
        for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( sceneobjectdata object_get_type() == "Types_Player" )
            {
                replacementallowed = istrue( sceneplay.var_ca29a69dc742b367[ playerindex ].replacementallowed );
                replacementisenabled = sceneobjectdata function_4e15410d3aae945c() || isdefined( sceneobjectdata function_f66e8916121d9737() );
                
                if ( replacementallowed && replacementisenabled && !isdefined( sceneobjectdata.entity ) && !sceneobjectdata function_fe495eb5e40771ec( scenedata ) )
                {
                    entitydesc = sceneplay.var_ca29a69dc742b367[ playerindex ];
                    var_84cccd2e89c1bbe7 = !isdefined( sceneobjectdata function_f66e8916121d9737() );
                    
                    if ( var_84cccd2e89c1bbe7 )
                    {
                        if ( isdefined( sceneobjectdata.var_b2de9e740fef7506 ) && !isdefined( entitydesc.agententity ) )
                        {
                            sceneobjectdata function_fa25c05bae26b761( sceneobjectdata.var_b2de9e740fef7506, entitydesc );
                        }
                        
                        if ( isdefined( sceneobjectdata.var_b2de9e740fef7506 ) && sceneobjectdata.var_b2de9e740fef7506.newrequest )
                        {
                            agententity = entitydesc.agententity;
                            
                            if ( isdefined( agententity ) )
                            {
                                agententity notify( "scene_monitor_players_new_animation_for_agent" );
                                var_6751e5eb36fccfa9 = sceneobjectdata.var_b2de9e740fef7506;
                                n_anim_length = getanimlength( var_6751e5eb36fccfa9.animasset );
                                var_b7d39a4661f3460 = gettime();
                                var_c952be88c3ffef2f = ( var_b7d39a4661f3460 - var_6751e5eb36fccfa9.var_fe62dc1bdc14feca ) / 1000;
                                var_53cea02c2ced41aa = var_6751e5eb36fccfa9.var_866b3a3066122e39;
                                
                                if ( n_anim_length > 0 )
                                {
                                    var_53cea02c2ced41aa += var_c952be88c3ffef2f / n_anim_length;
                                }
                                
                                var_7c6075e90a7b0fa = sceneobjectdata function_23cc62938b72190b();
                                agententity thread function_d28a53b100cbdda7( sceneobjectdata, var_6751e5eb36fccfa9.shotindex, var_6751e5eb36fccfa9.animindex, var_6751e5eb36fccfa9.notifystring, var_6751e5eb36fccfa9.alignmentinfo, var_6751e5eb36fccfa9.animasset, var_53cea02c2ced41aa, var_6751e5eb36fccfa9.blendtime, var_6751e5eb36fccfa9.blendcurve, var_6751e5eb36fccfa9.lerptime, var_7c6075e90a7b0fa );
                                sceneobjectdata.var_b2de9e740fef7506.newrequest = 0;
                            }
                        }
                    }
                    else
                    {
                        if ( isdefined( sceneobjectdata.var_b2de9e740fef7506 ) && !isdefined( entitydesc.scriptmodelentity ) )
                        {
                            modelname = sceneobjectdata function_f66e8916121d9737();
                            entitydesc.scriptmodelentity = function_6a16552e40cb91e1( sceneobjectdata.var_b2de9e740fef7506.alignmentinfo.origin, sceneobjectdata.var_b2de9e740fef7506.alignmentinfo.angles, modelname );
                            sceneobjectdata.replacemententity = entitydesc.scriptmodelentity;
                            sceneobjectdata.entity = sceneobjectdata.replacemententity;
                            sceneobjectdata function_535e6f4c06c15b1d( sceneplay, 1, 0, sceneobjectdata.alignmentinfo );
                        }
                        
                        if ( isdefined( sceneobjectdata.var_b2de9e740fef7506 ) && sceneobjectdata.var_b2de9e740fef7506.newrequest )
                        {
                            scriptmodelentity = entitydesc.scriptmodelentity;
                            
                            if ( isdefined( scriptmodelentity ) )
                            {
                                var_6751e5eb36fccfa9 = sceneobjectdata.var_b2de9e740fef7506;
                                n_anim_length = getanimlength( var_6751e5eb36fccfa9.animasset );
                                var_b7d39a4661f3460 = gettime();
                                var_c952be88c3ffef2f = float( var_b7d39a4661f3460 - var_6751e5eb36fccfa9.var_fe62dc1bdc14feca ) / 1000;
                                var_2e2a2f75fd49152a = getanimname( var_6751e5eb36fccfa9.animasset );
                                var_6325cb53ec163839 = "none";
                                scriptmodelentity stopuseanimtree();
                                scriptmodelentity scriptmodelplayanimdeltamotionfrompos( var_2e2a2f75fd49152a, var_6751e5eb36fccfa9.alignmentinfo.origin, var_6751e5eb36fccfa9.alignmentinfo.angles, var_6751e5eb36fccfa9.notifystring, var_c952be88c3ffef2f, var_6325cb53ec163839 );
                                sceneobjectdata.var_b2de9e740fef7506.newrequest = 0;
                            }
                        }
                    }
                }
                
                playerindex++;
            }
        }
        
        waitframe();
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3c4a
// Size: 0x86
function private function_276d3342cddac11a()
{
    sceneplay = self;
    
    if ( !isdefined( sceneplay.var_ca29a69dc742b367 ) )
    {
        return;
    }
    
    foreach ( entitydesc in sceneplay.var_ca29a69dc742b367 )
    {
        function_f4cf37b2c85bb5c0( entitydesc );
        function_870557fc814fab46( entitydesc );
    }
    
    sceneplay.var_ca29a69dc742b367 = undefined;
}

// Namespace scene / scripts\cp_mp\scene
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3cd8
// Size: 0xc6
function private function_fa25c05bae26b761( var_6751e5eb36fccfa9, entitydesc )
{
    sceneobjectdata = self;
    agent_type = sceneobjectdata function_a2142af2db8fbb0();
    agent_team = sceneobjectdata function_7c9fcb0161b76b2d();
    newagent = scripts\mp\mp_agent::spawnnewagentaitype( agent_type, var_6751e5eb36fccfa9.alignmentinfo.origin, var_6751e5eb36fccfa9.alignmentinfo.angles, agent_team );
    entitydesc.agententity = newagent;
    sceneobjectdata.replacemententity = newagent;
    sceneobjectdata.entity = newagent;
    sceneobjectdata function_535e6f4c06c15b1d( sceneobjectdata.sceneplay, 1, 0, sceneobjectdata.alignmentinfo );
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3da6
// Size: 0x6a
function private function_f4cf37b2c85bb5c0( entitydesc )
{
    if ( !isdefined( entitydesc.agententity ) )
    {
        return;
    }
    
    agententity = entitydesc.agententity;
    agententity notify( "scene_monitor_players_agent_will_be_despawned" );
    assert( isagent( agententity ) );
    agententity.nocorpse = 1;
    agententity scripts\cp_mp\agents\agent_utils::despawnagent();
    entitydesc.agententity = undefined;
}

// Namespace scene / scripts\cp_mp\scene
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3e18
// Size: 0x4e
function private function_6a16552e40cb91e1( spawnorigin, spawnangles, modelname )
{
    newentity = utility::spawn_model( modelname, spawnorigin, spawnangles );
    newentity forcenetfieldhighlod( 1 );
    newentity val::set( "scene_shot", "cinematics_participant", 1 );
    return newentity;
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3e6f
// Size: 0x44
function private function_870557fc814fab46( entitydesc )
{
    if ( !isdefined( entitydesc.scriptmodelentity ) )
    {
        return;
    }
    
    scriptmodelentity = entitydesc.scriptmodelentity;
    scriptmodelentity delete();
    entitydesc.scriptmodelentity = undefined;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3ebb
// Size: 0x1ca
function private function_a8bfee1f6abe8209()
{
    sceneplay = self;
    scenedata = sceneplay.sceneroot.scenedata;
    playerindex = 0;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata object_get_type() == "Types_Player" )
        {
            replacementallowed = istrue( sceneplay.var_ca29a69dc742b367[ playerindex ].replacementallowed );
            replacementisenabled = isdefined( sceneobjectdata function_f66e8916121d9737() );
            
            if ( replacementallowed && replacementisenabled && !isdefined( sceneobjectdata.entity ) )
            {
                entitydesc = sceneplay.var_ca29a69dc742b367[ playerindex ];
                
                if ( !isdefined( entitydesc.scriptmodelentity ) )
                {
                    spawnorigin = sceneplay.sceneroot.origin;
                    spawnorigin += ( 0, 0, -200 );
                    spawnangles = sceneplay.sceneroot.angles;
                    modelname = sceneobjectdata function_f66e8916121d9737();
                    entitydesc.scriptmodelentity = function_6a16552e40cb91e1( spawnorigin, spawnangles, modelname );
                    sceneobjectdata.replacemententity = entitydesc.scriptmodelentity;
                    sceneobjectdata.entity = sceneobjectdata.replacemententity;
                    
                    if ( isdefined( sceneobjectdata.alignmentinfo ) )
                    {
                        sceneobjectdata function_535e6f4c06c15b1d( sceneplay, 1, 0, sceneobjectdata.alignmentinfo );
                    }
                }
            }
            
            playerindex++;
        }
    }
}

// Namespace scene / scripts\cp_mp\scene
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x408d
// Size: 0x9b, Type: bool
function private function_fe495eb5e40771ec( scenedata )
{
    sceneobjectdata = self;
    
    if ( sceneobjectdata object_get_type() != "Types_Player" )
    {
        return false;
    }
    
    if ( sceneobjectdata function_3e13497ed7044cbd() )
    {
        if ( isdefined( sceneobjectdata.var_17f5321d96d1bf24 ) )
        {
            return isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_17f5321d96d1bf24 ].replacemententity );
        }
        
        return false;
    }
    
    if ( isdefined( sceneobjectdata.var_9668be326e00024b ) )
    {
        return isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_9668be326e00024b ].replacemententity );
    }
    
    return false;
}

// Namespace scene / scripts\cp_mp\scene
// Params 0
// Checksum 0x0, Offset: 0x4131
// Size: 0x4, Type: bool
function function_720d21706a7ff164()
{
    return true;
}

// Namespace scene / scripts\cp_mp\scene
// Params 1
// Checksum 0x0, Offset: 0x413e
// Size: 0x31
function function_f66b22351778fe49( enabled )
{
    assert( isplayer( self ) );
    player = self;
    player scripts\common\utility::letterbox_enable( enabled, 0 );
}

// Namespace scene / scripts\cp_mp\scene
// Params 2
// Checksum 0x0, Offset: 0x4177
// Size: 0xd8, Type: bool
function function_d18c2d3d2819c322( entity, sceneobjectdata )
{
    assert( isplayer( entity ) );
    scenedata = sceneobjectdata.scenedata;
    var_dbdcde08b6a6c0f2 = sceneobjectdata function_3e13497ed7044cbd();
    
    if ( var_dbdcde08b6a6c0f2 )
    {
        if ( isdefined( sceneobjectdata.var_17f5321d96d1bf24 ) )
        {
            if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_17f5321d96d1bf24 ].entity ) )
            {
                return false;
            }
        }
    }
    else if ( isdefined( sceneobjectdata.var_9668be326e00024b ) )
    {
        if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_9668be326e00024b ].entity ) )
        {
            return false;
        }
    }
    
    var_a7f983dc6ed7cd38 = entity scripts\cp_mp\utility\player_utility::isfemale();
    
    if ( var_dbdcde08b6a6c0f2 != var_a7f983dc6ed7cd38 )
    {
        return false;
    }
    
    return true;
}

