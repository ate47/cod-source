#using script_75377e59f5becac8;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\utility\teams;

#namespace namespace_e7bbffdd71331a9a;

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 3
// Checksum 0x0, Offset: 0x50e
// Size: 0x129
function spawn_script_model( modelname, animname, extramodels )
{
    model = spawn( "script_model", self.origin );
    model setmodel( modelname );
    model forcenetfieldhighlod( 1 );
    
    if ( !isdefined( animname ) )
    {
        animname = modelname;
    }
    
    model.animname = animname;
    
    if ( isdefined( extramodels ) )
    {
        model.linkedents = [];
        
        foreach ( modeltag in extramodels )
        {
            extra = spawn( "script_model", self.origin );
            extra setmodel( modeltag[ 0 ] );
            extra forcenetfieldhighlod( 1 );
            extra linkto( model, modeltag[ 1 ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
            model.linkedents[ model.linkedents.size ] = extra;
        }
    }
    
    return model;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x640
// Size: 0x5e
function function_c880edba9face762( scenename )
{
    origin_name = "infil_" + scenename + "_light_origin";
    orgstruct = getstruct( origin_name, "targetname" );
    
    if ( !isdefined( level.lighting_rigs ) )
    {
        level.lighting_rigs = [];
    }
    
    level.lighting_rigs[ origin_name ] = orgstruct;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x6a6
// Size: 0x3e
function function_fce988291dbc4649( scenename )
{
    if ( !isdefined( level.lighting_rigs ) )
    {
        return undefined;
    }
    
    origin_name = "infil_" + scenename + "_light_origin";
    return level.lighting_rigs[ origin_name ];
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x6ed
// Size: 0x332
function function_8c2d124dbef4fa60( scenename, linkent )
{
    rig = spawnstruct();
    var_5e0676140eecdf2d = "infil_" + scenename + "_probe";
    light_name = "infil_" + scenename + "_light";
    probes = getentarray( var_5e0676140eecdf2d, "script_noteworthy" );
    lights = getentarray( light_name, "targetname" );
    orgstruct = function_fce988291dbc4649( scenename );
    
    if ( !isdefined( probes ) )
    {
        return undefined;
    }
    
    foreach ( probe in probes )
    {
        if ( !isdefined( probe ) )
        {
            return undefined;
        }
    }
    
    if ( !isdefined( lights ) )
    {
        return undefined;
    }
    
    foreach ( light in lights )
    {
        if ( !isdefined( light ) )
        {
            return undefined;
        }
    }
    
    if ( !isdefined( orgstruct ) )
    {
        return undefined;
    }
    
    orgorigin = orgstruct.origin;
    var_3694a4e650566a39 = orgstruct.angles;
    
    if ( !isdefined( var_3694a4e650566a39 ) )
    {
        var_3694a4e650566a39 = ( 0, 0, 0 );
    }
    
    foreach ( probe in probes )
    {
        if ( !isdefined( probe.origin_offset ) && !isdefined( probe.angles_offset ) )
        {
            var_542e3e93b710380f = probe.origin;
            var_7434c0613f2501b1 = probe.angles;
            
            if ( !isdefined( var_7434c0613f2501b1 ) )
            {
                var_7434c0613f2501b1 = ( 0, 0, 0 );
            }
            
            probe.origin_offset = var_542e3e93b710380f - orgorigin;
            probe.angles_offset = var_7434c0613f2501b1 - var_3694a4e650566a39;
        }
    }
    
    foreach ( light in lights )
    {
        if ( !isdefined( light.origin_offset ) && !isdefined( light.angles_offset ) )
        {
            lightorigin = light.origin;
            lightangles = light.angles;
            
            if ( !isdefined( light.angles ) )
            {
                lightangles = ( 0, 0, 0 );
            }
            
            light.origin_offset = lightorigin - orgorigin;
            light.angles_offset = lightangles - var_3694a4e650566a39;
        }
    }
    
    rig.probes = probes;
    rig.lights = lights;
    rig.linkent = linkent;
    function_89a2405953b84136( rig, 1 );
    return rig;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xa28
// Size: 0xee
function private function_89a2405953b84136( rig, override_og )
{
    if ( !isdefined( rig ) )
    {
        return;
    }
    
    foreach ( probe in rig.probes )
    {
        probe hide();
    }
    
    foreach ( light in rig.lights )
    {
        if ( override_og && !isdefined( light.original_intensity ) )
        {
            light.original_intensity = light getlightintensity();
        }
        
        light setlightintensity( 0 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0xb1e
// Size: 0x81
function create_animpack( anime, islooping )
{
    pack = spawnstruct();
    pack.ents = [];
    pack.staticents = [];
    pack.playerpositions = [];
    pack.var_3bd5282b118d27f8 = [];
    pack.lightingrigs = [];
    pack.anime = anime;
    pack.islooping = istrue( islooping );
    return pack;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0xba8
// Size: 0x15
function function_2d4c340dd3908b2d( fov )
{
    self.fov = fov;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 5
// Checksum 0x0, Offset: 0xbc5
// Size: 0x5d
function function_b8f86028bcc64f84( fstop, focusdist, focusspeed, aperturespeed, focalpoint )
{
    self.fstop = fstop;
    self.focusdist = focusdist;
    self.focusspeed = focusspeed;
    self.aperturespeed = aperturespeed;
    self.focalpoint = focalpoint;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0xc2a
// Size: 0x27
function add_pack_startfunc( paramarray, func )
{
    self.startfunc = func;
    self.var_c65bb75cce61100f = paramarray;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0xc59
// Size: 0x27
function function_e718ba63d511fcde( paramarray, func )
{
    self.playerfunc = func;
    self.var_5ab13b55d7ceff80 = paramarray;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0xc88
// Size: 0x72
function add_pack_modelanim( ent, animation )
{
    assert( isdefined( ent.animname ) );
    assert( isdefined( self.anime ) );
    level.scr_anim[ ent.animname ][ self.anime ] = animation;
    self.ents[ self.ents.size ] = ent;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0xd02
// Size: 0x21
function function_a44bdab6357b7210( ent )
{
    self.staticents[ self.staticents.size ] = ent;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0xd2b
// Size: 0x21
function function_707983b9fdb53c55( rig )
{
    self.lightingrigs[ self.lightingrigs.size ] = rig;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 3
// Checksum 0x0, Offset: 0xd54
// Size: 0x9d
function function_ad0bcac98781e0ab( ent, animation, var_1ef3b90415513455 )
{
    index = self.playerpositions.size;
    newstruct = spawnstruct();
    newstruct.ent = ent;
    newstruct.animation = animation;
    newstruct.animname = getanimname( animation );
    
    if ( isdefined( var_1ef3b90415513455 ) )
    {
        newstruct.animationfem = var_1ef3b90415513455;
        newstruct.animnamefem = getanimname( var_1ef3b90415513455 );
    }
    
    self.playerpositions[ index ] = newstruct;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0xdf9
// Size: 0x72
function function_f7fc8b110c478968( ent, animation )
{
    assert( isdefined( ent.animname ) );
    assert( isdefined( self.anime ) );
    level.scr_anim[ ent.animname ][ self.anime ] = animation;
    self.var_3bd5282b118d27f8[ self.var_3bd5282b118d27f8.size ] = ent;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 5
// Checksum 0x0, Offset: 0xe73
// Size: 0x11b
function function_d4561ab1ba4f5de9( ent, var_e6783d526b4a7212, animation, xcamasset, xcamfunction )
{
    assert( !isdefined( self.camerainfo ) );
    self.camerainfo = spawnstruct();
    self.camerainfo.ent = ent;
    self.camerainfo.var_e6783d526b4a7212 = var_e6783d526b4a7212;
    
    if ( isdefined( xcamasset ) )
    {
        self.camerainfo.xcamasset = xcamasset;
        self.camerainfo.xcamfunction = xcamfunction;
        
        if ( !self.islooping )
        {
            xcamlength = getxcamlength( xcamasset );
            xcamlength -= 0.033;
            xcamlength -= mod( xcamlength, 0.05 );
            self.camerainfo.xcamlength = xcamlength;
        }
        
        return;
    }
    
    if ( !self.islooping )
    {
        self.camerainfo.animlength = getanimlength( animation );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 3
// Checksum 0x0, Offset: 0xf96
// Size: 0x39
function add_pack_fx( fxid, origin, angles )
{
    self.fx = fxid;
    self.fxorigin = origin;
    self.fxangles = angles;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 3
// Checksum 0x0, Offset: 0xfd7
// Size: 0x119
function add_pack_playeranim( player, var_f8896cb359eab159, var_b1e61449da6ba188 )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    animname = undefined;
    
    if ( !isdefined( player.brexfilanimname ) )
    {
        animname = "player" + player getentitynumber();
        player.animname = animname;
        player.brexfilanimname = animname;
    }
    else
    {
        animname = player.brexfilanimname;
    }
    
    animation = var_f8896cb359eab159;
    
    if ( isdefined( var_b1e61449da6ba188 ) )
    {
        if ( isdefined( player.operatorcustomization ) && isdefined( player.operatorcustomization.gender ) && player.operatorcustomization.gender == "female" )
        {
            animation = var_b1e61449da6ba188;
        }
    }
    
    level.scr_anim[ animname ][ self.anime ] = animation;
    level.scr_eventanim[ animname ][ self.anime ] = getanimname( animation );
    self.players[ self.players.size ] = player;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x10f8
// Size: 0x4a
function function_ad12d29d41483e8a( statename, func )
{
    assert( !isdefined( level.infilstruct.statecallbacks[ statename ] ) );
    level.infilstruct.statecallbacks[ statename ] = func;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x114a
// Size: 0x58
function function_226e337633a44059( var_4f748fb021262dba, var_c242a4a69c2beed3 )
{
    level.infilstruct.var_6d575c4dfa5d6788 = var_4f748fb021262dba;
    
    if ( isdefined( var_c242a4a69c2beed3 ) )
    {
        level.infilstruct.var_ad3c883fbff215b5 = var_c242a4a69c2beed3;
        return;
    }
    
    level.infilstruct.var_ad3c883fbff215b5 = undefined;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x11aa
// Size: 0xd6
function function_f18696ac7694ed9()
{
    if ( isdefined( level.infilstruct.var_ad3c883fbff215b5 ) && isdefined( self.var_db122a8941dfee14 ) && self.var_db122a8941dfee14 == 1 )
    {
        return level.infilstruct.var_ad3c883fbff215b5;
    }
    
    if ( isarray( level.infilstruct.var_6d575c4dfa5d6788 ) )
    {
        slotnumber = 0;
        
        if ( isdefined( self.infilanimindex ) )
        {
            slotnumber = self.infilanimindex - 1;
        }
        
        assert( slotnumber < level.infilstruct.var_6d575c4dfa5d6788.size );
        return level.infilstruct.var_6d575c4dfa5d6788[ slotnumber ];
    }
    
    return level.infilstruct.var_6d575c4dfa5d6788;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x1289
// Size: 0x8c
function allplayers_setfov( fov )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientdvar( @"cg_fov", fov );
        player setclientdvar( @"hash_71c6c0b8428e44a7", 1 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x131d
// Size: 0x133
function function_cf47ab3f9defe35b()
{
    if ( istrue( level.infilstruct.var_12c912ee9672fa1 ) )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientdvar( @"cg_fov", 65 );
            player setclientdvar( @"hash_86bf34d5f48fa435", 65 );
        }
        
        return;
    }
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientdvar( @"cg_fov", 65 );
        player setclientdvar( @"hash_86bf34d5f48fa435", 65 );
        player setclientdvar( @"hash_71c6c0b8428e44a7", 0 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 5
// Checksum 0x0, Offset: 0x1458
// Size: 0x109
function allplayers_setphysicaldof( fstop, focusdist, focusspeed, aperturespeed, focalpoint )
{
    if ( !isdefined( focusspeed ) )
    {
        focusspeed = 100;
    }
    
    if ( !isdefined( aperturespeed ) )
    {
        aperturespeed = 100;
    }
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.var_1f0a019572c9f8e2 ) )
        {
            player.var_1f0a019572c9f8e2 = 1;
            player enablephysicaldepthoffieldscripting();
        }
        
        if ( isdefined( focalpoint ) )
        {
            player setphysicaldepthoffield( fstop, focusdist, focusspeed, aperturespeed, focalpoint );
            continue;
        }
        
        if ( isdefined( aperturespeed ) )
        {
            player setphysicaldepthoffield( fstop, focusdist, focusspeed, aperturespeed );
            continue;
        }
        
        if ( isdefined( focusspeed ) )
        {
            player setphysicaldepthoffield( fstop, focusdist, focusspeed );
            continue;
        }
        
        player setphysicaldepthoffield( fstop, focusdist );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x1569
// Size: 0x81
function allplayers_clearphysicaldof()
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.var_1f0a019572c9f8e2 ) )
        {
            player.var_1f0a019572c9f8e2 = undefined;
            player disablephysicaldepthoffieldscripting();
        }
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x15f2
// Size: 0x121
function function_d328d1b2bd6822bd( fadedowntime )
{
    assert( !isdefined( level.infilblackoverlay ) );
    overlay = newhudelem();
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( "black", 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.sort = -1;
    overlay setshowinrealism( 1 );
    level.infilblackoverlay = overlay;
    
    if ( isdefined( fadedowntime ) && fadedowntime > 0 )
    {
        level.infilblackoverlay.alpha = 0;
        level.infilblackoverlay fadeovertime( fadedowntime );
        level.infilblackoverlay.alpha = 1;
        return;
    }
    
    level.infilblackoverlay.alpha = 1;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x171b
// Size: 0xf2
function function_32bc1d39bf81ce95( var_1bb7594c18d17443 )
{
    assert( isdefined( level.infilblackoverlay ) );
    
    if ( isdefined( var_1bb7594c18d17443 ) && var_1bb7594c18d17443 > 0 )
    {
        level.infilblackoverlay.alpha = 1;
        level.infilblackoverlay fadeovertime( var_1bb7594c18d17443 );
        level.infilblackoverlay.alpha = 0;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player scripts\common\damage_effects::function_a2b4e6088394bade();
            player notify( "deaths_door_exit" );
            player clearsoundsubmix( "mp_br_lobby_fade", 0 );
        }
        
        return;
    }
    
    level.infilblackoverlay.alpha = 0;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x1815
// Size: 0x2e
function function_743f088f49ccc99d()
{
    assert( isdefined( level.infilblackoverlay ) );
    level.infilblackoverlay destroy();
    level.infilblackoverlay = undefined;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 3
// Checksum 0x0, Offset: 0x184b
// Size: 0x71
function function_ea856ec0b3c4cfc6( fadedowntime, players, fadename )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_10f93bb3f3966751( fadedowntime, fadename );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x18c4
// Size: 0x81
function function_10f93bb3f3966751( fadedowntime, fadename )
{
    function_a38b2e30e799e9b7( fadedowntime, fadename );
    spectators = scripts\mp\gametypes\br_spectate::function_6d5206bdba79e8c3();
    
    if ( spectators.size > 0 )
    {
        foreach ( viewer in spectators )
        {
            viewer function_a38b2e30e799e9b7( fadedowntime, fadename );
        }
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x194d
// Size: 0x14e
function function_a38b2e30e799e9b7( fadedowntime, fadename )
{
    assert( isdefined( fadename ) );
    
    if ( !isdefined( self.var_cd09849e16631c71 ) )
    {
        self.var_cd09849e16631c71 = [];
    }
    
    assert( !isdefined( self.var_cd09849e16631c71[ fadename ] ) );
    
    if ( isdefined( self.var_cd09849e16631c71[ fadename ] ) )
    {
        return;
    }
    
    overlay = newclienthudelem( self );
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( "black", 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.sort = -1;
    overlay.archived = 0;
    overlay setshowinrealism( 1 );
    
    if ( isdefined( fadedowntime ) && fadedowntime > 0 )
    {
        overlay.alpha = 0;
        overlay fadeovertime( fadedowntime );
        overlay.alpha = 1;
    }
    else
    {
        overlay.alpha = 1;
    }
    
    self.var_cd09849e16631c71[ fadename ] = overlay;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 3
// Checksum 0x0, Offset: 0x1aa3
// Size: 0x27
function function_7f3ad8fe6df1b8fe( var_1bb7594c18d17443, players, fadename )
{
    level thread function_6b9a694ac71b6342( var_1bb7594c18d17443, players, fadename );
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1ad2
// Size: 0x18a
function private function_6b9a694ac71b6342( var_1bb7594c18d17443, players, fadename )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_1162dbfdb942d179( var_1bb7594c18d17443, fadename );
        spectators = player scripts\mp\gametypes\br_spectate::function_6d5206bdba79e8c3();
        
        if ( spectators.size > 0 )
        {
            foreach ( viewer in spectators )
            {
                viewer function_1162dbfdb942d179( var_1bb7594c18d17443, fadename );
            }
        }
    }
    
    wait var_1bb7594c18d17443;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_46b5c06f8d7ac31( fadename );
        spectators = player scripts\mp\gametypes\br_spectate::function_6d5206bdba79e8c3();
        
        if ( spectators.size > 0 )
        {
            foreach ( viewer in spectators )
            {
                viewer function_46b5c06f8d7ac31( fadename );
            }
        }
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x1c64
// Size: 0xe7
function function_1162dbfdb942d179( var_1bb7594c18d17443, fadename )
{
    assert( isdefined( fadename ) );
    
    if ( isbot( self ) && ( !isdefined( self.var_cd09849e16631c71 ) || !isdefined( self.var_cd09849e16631c71[ fadename ] ) ) )
    {
        return;
    }
    
    assert( isdefined( self.var_cd09849e16631c71 ) );
    assert( isdefined( self.var_cd09849e16631c71[ fadename ] ) );
    overlay = self.var_cd09849e16631c71[ fadename ];
    
    if ( isdefined( var_1bb7594c18d17443 ) && var_1bb7594c18d17443 > 0 )
    {
        if ( isdefined( overlay ) )
        {
            overlay.alpha = 1;
            overlay fadeovertime( var_1bb7594c18d17443 );
            overlay.alpha = 0;
        }
        
        scripts\common\damage_effects::function_a2b4e6088394bade();
        self clearsoundsubmix( "mp_br_lobby_fade", 0 );
        return;
    }
    
    if ( isdefined( overlay ) )
    {
        overlay.alpha = 0;
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x1d53
// Size: 0x91
function function_46b5c06f8d7ac31( fadename )
{
    if ( isbot( self ) && ( !isdefined( self.var_cd09849e16631c71 ) || !isdefined( self.var_cd09849e16631c71[ fadename ] ) ) )
    {
        return;
    }
    
    assert( isdefined( self.var_cd09849e16631c71 ) );
    assert( isdefined( self.var_cd09849e16631c71[ fadename ] ) );
    self.var_cd09849e16631c71[ fadename ] destroy();
    self.var_cd09849e16631c71[ fadename ] = undefined;
    
    if ( self.var_cd09849e16631c71.size == 0 )
    {
        self.var_cd09849e16631c71 = undefined;
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x1dec
// Size: 0x63
function endprematchskydiving()
{
    var_98eaf83fc88a156e = 5;
    assertex( isplayer( self ), "<dev string:x1c>" );
    player = self;
    player skydive_setdeploymentstatus( 0 );
    player skydive_setbasejumpingstatus( 0 );
    
    if ( isdefined( player.ffsm_state ) )
    {
        player.ffsm_state = var_98eaf83fc88a156e;
    }
    
    player scripts\cp_mp\parachute::parachutecleanup();
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x1e57
// Size: 0x178
function function_583f118c4064ca21( players )
{
    hidetest = 0;
    
    /#
        hidetest = getdvarint( @"hash_484dde7ceb1b8065", 0 ) != 0;
    #/
    
    var_2c13b756b0aa6dcf = isdefined( players ) && players.size != level.players.size;
    
    foreach ( team in level.teamnamelist )
    {
        teamplayers = getteamdata( team, "players" );
        
        foreach ( player in teamplayers )
        {
            if ( var_2c13b756b0aa6dcf && !array_contains( players, player ) )
            {
                continue;
            }
            
            if ( !namespace_56a3588493afc984::function_60597da56f99d304( player ) )
            {
                continue;
            }
            
            player function_a593971d75d82113();
            player function_379bb555405c16bb( "br_infils_util::refreshTeamVisibility()" );
            
            if ( !hidetest )
            {
                foreach ( otherplayer in teamplayers )
                {
                    player showtoplayer( otherplayer );
                }
            }
        }
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x1fd7
// Size: 0xfa
function function_423115ed15f21e05( team )
{
    hidetest = 0;
    
    /#
        hidetest = getdvarint( @"hash_484dde7ceb1b8065", 0 ) != 0;
    #/
    
    teamplayers = getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( !namespace_56a3588493afc984::function_60597da56f99d304( player ) )
        {
            continue;
        }
        
        player function_a593971d75d82113();
        player function_379bb555405c16bb( "br_infils_util::refreshTeamVisibilityForTeam()" );
        
        if ( !hidetest )
        {
            foreach ( otherplayer in teamplayers )
            {
                player showtoplayer( otherplayer );
            }
        }
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x20d9
// Size: 0x59
function registerbrsquadleaderjumpcommands( brsquadleader )
{
    if ( !istrue( brsquadleader.jumpcomandsregistered ) )
    {
        brsquadleader.jumpcomandsregistered = 1;
        brsquadleader scripts\mp\gametypes\br_public::updatebrscoreboardstat( "jumpMasterState", 2 );
        brsquadleader notifyonplayercommand( "halo_jump_c130", "+gostand" );
        brsquadleader notifyonplayercommand( "br_break_squad", "+breath_sprint" );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x213a
// Size: 0x5c
function watchbrsquadleaderdisconnect( team )
{
    waittill_any_2( "death", "disconnect" );
    teamplayers = getteamdata( team, "players" );
    brsquadleader = setupbrsquadleader( teamplayers );
    
    if ( isdefined( brsquadleader ) )
    {
        registerbrsquadleaderjumpcommands( brsquadleader );
        brsquadleader thread watchbrsquadleaderdisconnect( team );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x219e
// Size: 0x253
function setupbrsquadleader( teamplayers )
{
    if ( teamplayers.size == 0 )
    {
        return undefined;
    }
    
    brsquadleader = undefined;
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player ) && player scripts\mp\gametypes\br_public::isplayerbrsquadleader() )
        {
            return player;
        }
    }
    
    foreach ( player in teamplayers )
    {
        if ( level.onlinegame && player isfireteamleader() )
        {
            brsquadleader = player;
            break;
        }
    }
    
    if ( !isdefined( brsquadleader ) )
    {
        var_11a39090e204313a = 0;
        
        /#
            var_11a39090e204313a = getdvarint( @"hash_e65dc975d6fcfca0", 0 ) != 0;
        #/
        
        numplayerschecked = 0;
        
        foreach ( player in teamplayers )
        {
            var_921910f60d54cfa6 = var_11a39090e204313a == isbot( player );
            
            if ( var_921910f60d54cfa6 )
            {
                numplayerschecked++;
                var_54a63825d837afe3 = 1 / numplayerschecked;
                
                if ( randomfloat( 1 ) < var_54a63825d837afe3 )
                {
                    brsquadleader = player;
                }
            }
        }
    }
    
    if ( !isdefined( brsquadleader ) )
    {
        foreach ( player in teamplayers )
        {
            brsquadleader = player;
            break;
        }
    }
    
    if ( !isdefined( brsquadleader ) )
    {
        return undefined;
    }
    
    brsquadleader scripts\mp\gametypes\br::setplayerbrsquadleader( 1 );
    
    foreach ( player in teamplayers )
    {
        if ( player != brsquadleader )
        {
            player scripts\mp\gametypes\br::setplayerbrsquadleader( 0 );
        }
        
        infilstatus = ter_op( player scripts\mp\gametypes\br_public::isplayerbrsquadleader(), 2, 1 );
        scripts\mp\gametypes\br_c130::setteammateomnvarsforplayer( player, teamplayers, infilstatus );
    }
    
    return brsquadleader;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x23fa
// Size: 0x13f
function function_6d8ac534ad288aa5( player )
{
    forceindex = undefined;
    possibleindices = [ 1, 2, 3, 4 ];
    teamplayers = getteamdata( player.team, "players" );
    assert( teamplayers.size <= possibleindices.size );
    player.var_db122a8941dfee14 = teamplayers.size;
    
    foreach ( teamplayer in teamplayers )
    {
        if ( teamplayer == player )
        {
            continue;
        }
        
        if ( isdefined( teamplayer.infilanimindex ) )
        {
            possibleindices = array_remove( possibleindices, teamplayer.infilanimindex );
        }
        
        if ( teamplayer scripts\mp\gametypes\br_public::isplayerbrsquadleader() )
        {
            possibleindices = array_remove( possibleindices, 1 );
        }
    }
    
    if ( possibleindices.size == 0 )
    {
        possibleindices[ 0 ] = 1;
    }
    
    player.infilanimindex = possibleindices[ 0 ];
    
    /#
        forceindex = getdvarint( @"hash_441165c7b355dd1b", -1 );
        
        if ( forceindex > 0 )
        {
            player.infilanimindex = forceindex;
        }
    #/
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x2541
// Size: 0x13
function getinfilspawnoffset()
{
    return getdvarfloat( @"scr_br_dropspawnoffsetminz", 11400 );
}

/#

    // Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
    // Params 0
    // Checksum 0x0, Offset: 0x255d
    // Size: 0x17, Type: dev
    function function_136f4218b1d719b9()
    {
        return getdvarint( @"hash_8545857262882e35", 0 ) != 0;
    }

    // Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
    // Params 1
    // Checksum 0x0, Offset: 0x257c
    // Size: 0x44, Type: dev
    function function_2c3987dd5672427f( timesec )
    {
        if ( function_136f4218b1d719b9() )
        {
            while ( timesec > 0 )
            {
                waitframe();
                
                while ( istrue( level.var_ca629cf434263639 ) )
                {
                    waitframe();
                }
                
                timesec -= level.framedurationseconds;
            }
            
            return 1;
        }
        
        return 0;
    }

#/

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x25c8
// Size: 0x2e
function function_8663da4077fa7e20()
{
    movinginfil = 1;
    
    /#
        if ( function_136f4218b1d719b9() )
        {
            movinginfil = getdvarint( @"hash_f6b3b7c2e066bf97", 0 );
        }
    #/
    
    return movinginfil;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x25ff
// Size: 0x1b
function waitandpause( timesec )
{
    /#
        if ( function_2c3987dd5672427f( timesec ) )
        {
            return;
        }
    #/
    
    wait timesec;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x2622
// Size: 0x34
function function_6199c35f4cf4524c( func )
{
    assert( isdefined( level.var_16da1e546dc92a4c ) );
    level.var_16da1e546dc92a4c[ level.var_16da1e546dc92a4c.size ] = func;
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x265e
// Size: 0x99
function function_e66f664ad726f2e()
{
    var_14bd067261dc7f99 = "";
    
    switch ( level.script )
    {
        case #"hash_bce1a7274538a78":
        case #"hash_73e90c896fdaebc3":
            var_14bd067261dc7f99 = "mp_infil_br_jup_wz2_intro_tr";
            break;
        case #"hash_aeddd44c5b27b2d":
            var_14bd067261dc7f99 = "mp_infil_br_jup_bm_live_wz2_intro_tr";
            break;
        case #"hash_3ebe34631513de1d":
            var_14bd067261dc7f99 = "mp_infil_br_jup_mech_intro_tr";
            break;
        case #"hash_da8f14763f037922":
            var_14bd067261dc7f99 = "mp_infil_br_jup_sm_island_2_wz2_intro_tr";
            break;
    }
    
    if ( var_14bd067261dc7f99 != "" )
    {
        unloadinfiltransient( var_14bd067261dc7f99 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x26ff
// Size: 0x12d
function function_d870904da7b1ff7d( lights, lightson )
{
    if ( lightson )
    {
        var_c59c1d18b26c886e = [];
        var_c59c1d18b26c886e[ "infil_light_01" ] = 2000 * 7.95545e-05;
        var_c59c1d18b26c886e[ "infil_light_02" ] = 3000 * 7.95545e-05;
        var_c59c1d18b26c886e[ "infil_light_03" ] = 75 * 7.95545e-05;
        
        foreach ( light in lights )
        {
            if ( isdefined( light.name ) && isdefined( var_c59c1d18b26c886e[ light.name ] ) )
            {
                light setlightintensity( var_c59c1d18b26c886e[ light.name ] );
            }
            
            light forcenetfieldhighlod( 1 );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 1 * 7.95545e-05 );
        light forcenetfieldhighlod( 0 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x2834
// Size: 0xeb
function function_d8f828d3c82061b7( lights, lightson )
{
    if ( lightson )
    {
        var_c59c1d18b26c886e = [];
        var_c59c1d18b26c886e[ "exfil_light_01" ] = 500 * 7.95545e-05;
        var_c59c1d18b26c886e[ "exfil_light_02" ] = 1250 * 7.95545e-05;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_c59c1d18b26c886e[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 1 * 7.95545e-05 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x2927
// Size: 0x11e
function function_362cf2eeebce4c73( lights, lightson )
{
    if ( lightson )
    {
        var_c59c1d18b26c886e = [];
        var_c59c1d18b26c886e[ "cq_exfil_light_01" ] = 1000 * 7.95545e-05;
        var_c59c1d18b26c886e[ "cq_exfil_light_02" ] = 1000 * 7.95545e-05;
        var_c59c1d18b26c886e[ "cq_exfil_light_03" ] = 1250 * 7.95545e-05;
        var_c59c1d18b26c886e[ "cq_exfil_light_04" ] = 500 * 7.95545e-05;
        var_c59c1d18b26c886e[ "cq_exfil_light_05" ] = 500 * 7.95545e-05;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_c59c1d18b26c886e[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 1 * 7.95545e-05 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x2a4d
// Size: 0xfb
function function_4d5d7485513f045( lights, lightson )
{
    if ( lightson )
    {
        var_c59c1d18b26c886e = [];
        var_c59c1d18b26c886e[ "2ndry_light_01" ] = 250 * 7.95545e-05;
        var_c59c1d18b26c886e[ "2ndry_light_02" ] = 1000 * 7.95545e-05;
        var_c59c1d18b26c886e[ "2ndry_light_03" ] = 500 * 7.95545e-05;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_c59c1d18b26c886e[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 1 * 7.95545e-05 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 2
// Checksum 0x0, Offset: 0x2b50
// Size: 0xfc
function function_b281515d61bd0774( lights, lightson )
{
    if ( lightson )
    {
        var_c59c1d18b26c886e = [];
        var_c59c1d18b26c886e[ "accolade_light_01" ] = 750 * 7.95545e-05;
        var_c59c1d18b26c886e[ "accolade_light_02" ] = 1000 * 7.95545e-05;
        var_c59c1d18b26c886e[ "accolade_light_03" ] = 1000 * 7.95545e-05;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_c59c1d18b26c886e[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 1 * 7.95545e-05 );
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 1
// Checksum 0x0, Offset: 0x2c54
// Size: 0x1d3
function function_42f1462f1d4193af( lights )
{
    infillights = getentarray( "infil_light", "targetname" );
    var_d2326d24cb1fd3a2 = getentarray( "exfil_light", "targetname" );
    var_3b31e0da499ed5ae = getentarray( "cq_exfil_light", "targetname" );
    var_65f8c709d2f9cf4 = getentarray( "2ndry_light", "targetname" );
    var_e45eb5dd4051778e = getentarray( "accolade_light", "targetname" );
    
    switch ( lights )
    {
        case #"hash_cf4e05b68aeba31a":
            function_d870904da7b1ff7d( infillights, 1 );
            function_d8f828d3c82061b7( var_d2326d24cb1fd3a2, 0 );
            function_362cf2eeebce4c73( var_3b31e0da499ed5ae, 0 );
            function_4d5d7485513f045( var_65f8c709d2f9cf4, 0 );
            function_b281515d61bd0774( var_e45eb5dd4051778e, 0 );
            break;
        case #"hash_8dabe7b0b667b264":
            function_d870904da7b1ff7d( infillights, 0 );
            function_d8f828d3c82061b7( var_d2326d24cb1fd3a2, 1 );
            function_362cf2eeebce4c73( var_3b31e0da499ed5ae, 0 );
            function_4d5d7485513f045( var_65f8c709d2f9cf4, 0 );
            function_b281515d61bd0774( var_e45eb5dd4051778e, 0 );
            break;
        case #"hash_4856b940c7c5b675":
            function_d870904da7b1ff7d( infillights, 0 );
            function_d8f828d3c82061b7( var_d2326d24cb1fd3a2, 0 );
            function_362cf2eeebce4c73( var_3b31e0da499ed5ae, 1 );
            function_4d5d7485513f045( var_65f8c709d2f9cf4, 0 );
            function_b281515d61bd0774( var_e45eb5dd4051778e, 0 );
            break;
        case #"hash_f020299c866e4289":
            function_d870904da7b1ff7d( infillights, 0 );
            function_d8f828d3c82061b7( var_d2326d24cb1fd3a2, 0 );
            function_362cf2eeebce4c73( var_3b31e0da499ed5ae, 0 );
            function_4d5d7485513f045( var_65f8c709d2f9cf4, 1 );
            function_b281515d61bd0774( var_e45eb5dd4051778e, 0 );
            break;
        case #"hash_96702057c0bd388":
            function_d870904da7b1ff7d( infillights, 0 );
            function_d8f828d3c82061b7( var_d2326d24cb1fd3a2, 0 );
            function_362cf2eeebce4c73( var_3b31e0da499ed5ae, 0 );
            function_4d5d7485513f045( var_65f8c709d2f9cf4, 0 );
            function_b281515d61bd0774( var_e45eb5dd4051778e, 1 );
            break;
        default:
            break;
    }
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x2e2f
// Size: 0x26
function function_2bbe7f3e487520c6()
{
    infillights = getentarray( "infil_light", "targetname" );
    function_d870904da7b1ff7d( infillights, 0 );
}

// Namespace namespace_e7bbffdd71331a9a / namespace_81156089ff1fe819
// Params 0
// Checksum 0x0, Offset: 0x2e5d
// Size: 0x69, Type: bool
function function_59e8b4ed75ca8b92()
{
    return !scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue( level.skipprematch ) || !isdefined( level.infilstruct ) || !isdefined( level.infilstruct.var_eb0cd5e47dbbfd6a ) || istrue( level.infilstruct.var_1cf4fe3c9d7da8a2 ) || !getdvarint( @"hash_f49bd659b301fbb0", 1 );
}

