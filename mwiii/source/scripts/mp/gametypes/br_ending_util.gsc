#using scripts\cp_mp\operator;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\teams;
#using scripts\mp\utility\infilexfil;

#namespace br_ending_util;

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x309
// Size: 0x69
function create_animpack( anime )
{
    pack = spawnstruct();
    pack.ents = [];
    pack.players = [];
    pack.cam = undefined;
    pack.lightingrigs = [];
    pack.anime = anime;
    pack.packs = [];
    return pack;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 0
// Checksum 0x0, Offset: 0x37b
// Size: 0x20
function function_5c32248dfffac064()
{
    if ( !getdvarint( @"hash_88262f900b40e276", 0 ) )
    {
        return;
    }
    
    self.var_52738e0a99ed242b = 1;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x3a3
// Size: 0x15
function function_2d4c340dd3908b2d( fov )
{
    self.fov = fov;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 5
// Checksum 0x0, Offset: 0x3c0
// Size: 0x5d
function function_b8f86028bcc64f84( fstop, focusdist, focusspeed, aperturespeed, focalpoint )
{
    self.fstop = fstop;
    self.focusdist = focusdist;
    self.focusspeed = focusspeed;
    self.aperturespeed = aperturespeed;
    self.focalpoint = focalpoint;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x425
// Size: 0x4a
function add_pack_modelanim( ent, animation )
{
    level.scr_anim[ ent.animname ][ self.anime ] = animation;
    self.ents[ self.ents.size ] = ent;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x477
// Size: 0x27
function add_pack_startfunc( paramarray, func )
{
    self.startfunc = func;
    self.paramarray = paramarray;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x4a6
// Size: 0x27
function function_decf1e23d78d0944( paramarray, func )
{
    self.endfunc = func;
    self.var_315361abd838fad4 = paramarray;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x4d5
// Size: 0x27
function function_e718ba63d511fcde( paramarray, func )
{
    self.playerfunc = func;
    self.var_5ab13b55d7ceff80 = paramarray;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x504
// Size: 0x15
function function_6098f3014cd4c598( fadeinlength )
{
    self.fadeinlength = fadeinlength;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x521
// Size: 0x15
function function_6372afdc0e9ee2dd( fadeoutlength )
{
    self.fadeoutlength = fadeoutlength;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 3
// Checksum 0x0, Offset: 0x53e
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
    
    self.players[ self.players.size ] = player;
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
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x65f
// Size: 0x43
function add_pack_camanim( animation, xcamasset )
{
    self.cam = 1;
    level.scr_anim[ "endingCam" ][ self.anime ] = animation;
    self.xcamasset = xcamasset;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 3
// Checksum 0x0, Offset: 0x6aa
// Size: 0x39
function add_pack_fx( fxid, origin, angles )
{
    self.fx = fxid;
    self.fxorigin = origin;
    self.fxangles = angles;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x6eb
// Size: 0x21
function function_707983b9fdb53c55( rig )
{
    self.lightingrigs[ self.lightingrigs.size ] = rig;
}

#using_animtree( "script_model" );

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 3
// Checksum 0x0, Offset: 0x714
// Size: 0x132
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
    model useanimtree( #animtree );
    
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

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 3
// Checksum 0x0, Offset: 0x84f
// Size: 0xad
function function_38c7f6bc1deef269( modelname, animname, vehicletype )
{
    if ( !isdefined( animname ) )
    {
        animname = modelname;
    }
    
    vehicle = spawnvehicle( modelname, animname, vehicletype, self.origin, self.angles );
    vehicle.animname = animname;
    vehicle.endingvehicle = 1;
    vehicle.vehiclename = vehicletype;
    vehicle setcandamage( 0 );
    
    if ( vehicle vehicle_isphysveh() )
    {
        vehicle function_247ad6a91f6a4ffe( 1 );
        vehicle vehphys_forcekeyframedmotion();
    }
    else
    {
        vehicle notsolid();
    }
    
    vehicle vehicle_turnengineoff();
    vehicle function_97e11a84480635bc( 1 );
    return vehicle;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x905
// Size: 0x5e
function function_c880edba9face762( scenename )
{
    origin_name = "exfil_" + scenename + "_light_origin";
    orgstruct = getstruct( origin_name, "targetname" );
    
    if ( !isdefined( level.lighting_rigs ) )
    {
        level.lighting_rigs = [];
    }
    
    level.lighting_rigs[ origin_name ] = orgstruct;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x96b
// Size: 0x3e
function function_fce988291dbc4649( scenename )
{
    if ( !isdefined( level.lighting_rigs ) )
    {
        return undefined;
    }
    
    origin_name = "exfil_" + scenename + "_light_origin";
    return level.lighting_rigs[ origin_name ];
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 3
// Checksum 0x0, Offset: 0x9b2
// Size: 0x369
function function_8c2d124dbef4fa60( scenename, linkent, var_f08f74fd62b74b9a )
{
    rig = spawnstruct();
    var_5e0676140eecdf2d = "exfil_" + scenename + "_probe";
    light_name = "exfil_" + scenename + "_light";
    probes = getentarray( var_5e0676140eecdf2d, "script_noteworthy" );
    lights = getentarray( light_name, "targetname" );
    orgstruct = undefined;
    
    if ( isdefined( var_f08f74fd62b74b9a ) )
    {
        orgstruct = function_fce988291dbc4649( var_f08f74fd62b74b9a );
    }
    else
    {
        orgstruct = function_fce988291dbc4649( scenename );
    }
    
    if ( !isdefined( probes ) || !probes.size )
    {
        return undefined;
    }
    
    foreach ( p in probes )
    {
        if ( !isdefined( p ) )
        {
            return undefined;
        }
    }
    
    if ( !isdefined( lights ) || !lights.size )
    {
        return undefined;
    }
    
    foreach ( l in lights )
    {
        if ( !isdefined( l ) )
        {
            return undefined;
        }
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

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xd24
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

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 5
// Checksum 0x0, Offset: 0xe1a
// Size: 0x1a0
function add_pack_characteranim( modelname, extramodels, animation, animstr, animnameoverride )
{
    model = spawn( "script_model", self.origin );
    model setmodel( modelname );
    model forcenetfieldhighlod( 1 );
    model useanimtree( #animtree );
    
    if ( isdefined( animnameoverride ) )
    {
        animname = animnameoverride;
    }
    else
    {
        animname = modelname;
    }
    
    model.animname = animname;
    level.scr_anim[ model.animname ][ "br_ending" ] = animation;
    
    if ( isdefined( animstr ) )
    {
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
    }
    
    self.pack.models[ self.pack.models.size ] = model;
    return model;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 5
// Checksum 0x0, Offset: 0xfc3
// Size: 0xf7
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
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.scriptedphysicaldofenabled ) )
        {
            player.scriptedphysicaldofenabled = 1;
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

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x10c2
// Size: 0x7a
function allplayers_setfov( fov )
{
    foreach ( player in level.players )
    {
        player setclientdvar( @"cg_fov", fov );
        player setclientdvar( @"hash_71c6c0b8428e44a7", 1 );
    }
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 0
// Checksum 0x0, Offset: 0x1144
// Size: 0x89
function function_cf47ab3f9defe35b()
{
    foreach ( player in level.players )
    {
        player setclientdvar( @"cg_fov", 65 );
        player setclientdvar( @"hash_86bf34d5f48fa435", 65 );
        player setclientdvar( @"hash_71c6c0b8428e44a7", 0 );
    }
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 0
// Checksum 0x0, Offset: 0x11d5
// Size: 0x6f
function allplayers_clearphysicaldof()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.scriptedphysicaldofenabled ) )
        {
            player.scriptedphysicaldofenabled = undefined;
            player disablephysicaldepthoffieldscripting();
        }
    }
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 0
// Checksum 0x0, Offset: 0x124c
// Size: 0x60
function chopperexfil_set_brcircle()
{
    if ( !isdefined( level.br_circle ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_circle.dangercircleent ) )
    {
        return;
    }
    
    level.br_circle.dangercircleent brcirclemoveto( self.origin[ 0 ], self.origin[ 1 ], 9000, 0.05 );
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x12b4
// Size: 0x122
function create_disconnectplayer( animstruct )
{
    tempplayer = spawn( "script_model", self.origin );
    tempplayer setmodel( "tag_origin" );
    tempplayer forcenetfieldhighlod( 1 );
    tempplayer.isdisconnectplayer = 1;
    tempplayer.brexfilanimname = "player0";
    tempplayer.origin = animstruct.origin;
    tempplayer.angles = animstruct.angles;
    tempplayer create_player_rig( tempplayer.brexfilanimname, "viewhands_base_iw8", animstruct );
    
    if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) )
    {
        tempplayer function_50962e9f971266e( tempplayer.brexfilanimname, animstruct.origin );
    }
    
    tempplayer linkto( tempplayer.player_rig, "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level thread ending_player_disconnect_thread( tempplayer, 1 );
    animstruct.winners[ 0 ] = tempplayer;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x13de
// Size: 0xb0
function ending_player_disconnect_thread( player, skipwaittill )
{
    rig = player.player_rig;
    wasplayer = isplayer( player );
    
    if ( !isdefined( skipwaittill ) )
    {
        player waittill( "disconnect" );
    }
    else
    {
        wait 0.1;
    }
    
    if ( !isdefined( rig ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) && isdefined( rig.avatar ) )
    {
        rig.avatar.playerexists = undefined;
        rig notify( "update_avatar_visibility" );
        return;
    }
    
    playfxontag( getfx( "player_disconnect" ), rig, "tag_player" );
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 0
// Checksum 0x0, Offset: 0x1496
// Size: 0x51
function create_cam()
{
    model = spawn( "script_model", self.origin );
    model setmodel( "tag_origin" );
    model forcenetfieldhighlod( 1 );
    model useanimtree( #animtree );
    model.animname = "endingCam";
    return model;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 4
// Checksum 0x0, Offset: 0x14f0
// Size: 0x231
function create_player_rig( animname, rig_model, animstruct, var_40a4287d8d2e7ef9 )
{
    self.animname = animname;
    origin = animstruct.origin;
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    player_rig = spawn( "script_model", origin );
    player_rig.player = self;
    self.player_rig = player_rig;
    self.player_rig setmodel( rig_model );
    self.player_rig hide();
    self.player_rig.animname = animname;
    self.player_rig useanimtree( #animtree );
    self.player_rig.winindex = self.winindex;
    self.player_rig forcenetfieldhighlod( 1 );
    self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
    self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;
    
    if ( !isdefined( animstruct.player_rigs ) )
    {
        animstruct.player_rigs = [];
    }
    
    if ( isplayer( self ) )
    {
        self playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        println( "<dev string:x1c>" + self.name + "<dev string:x49>" + animname + "<dev string:x59>" + isdefined( self.player_rig ) );
        animstruct.player_rigs[ animstruct.player_rigs.size ] = self.player_rig;
        self.player_rig.playernum = self getentitynumber();
    }
    else
    {
        println( "<dev string:x64>" + animname + "<dev string:x59>" + isdefined( self.player_rig ) );
        self.player_rig.winindex = 0;
        self.player_rig.playernum = 0;
    }
    
    self notify( "rig_created" );
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x1729
// Size: 0x278
function function_50962e9f971266e( animname, origin )
{
    assert( isdefined( self.player_rig ) );
    bodymodelname = "";
    headmodelname = "";
    gender = "";
    
    if ( isplayer( self ) && isdefined( self.operatorcustomization ) )
    {
        bodymodelname = self.operatorcustomization.body;
        headmodelname = self.operatorcustomization.head;
        gender = self.operatorcustomization.gender;
    }
    else
    {
        operatorskins = [ "milsim_western_a", "milsim_western_b", "milsim_western_c", "milsim_western_d", "milsim_eastern_a", "milsim_eastern_b", "milsim_eastern_c", "milsim_eastern_d" ];
        operatorskin = array_random( operatorskins );
        bodymodelname = scripts\cp_mp\operator::function_8eba78e65f4be793( operatorskin );
        headmodelname = scripts\cp_mp\operator::function_223061772e2a61b9( operatorskin );
        gender = scripts\mp\teams::getoperatorgender( operatorskin );
    }
    
    avatar = spawn( "script_model", origin );
    avatar setmodel( "fullbody_usmc_ar_br_infil" );
    avatar function_dd6d30b9ec87c1b3( bodymodelname, headmodelname, "iw9_avatar_scriptable_mp" );
    avatar.operatorcustomization = spawnstruct();
    avatar.operatorcustomization.gender = gender;
    avatar hide();
    avatar.animname = animname;
    avatar.winindex = self.winindex;
    avatar forcenetfieldhighlod( 1 );
    weaponobj = scripts\cp_mp\weapon::buildweapon( "iw9_ar_mike4", [], "none", "none" );
    weaponent = spawn( "script_weapon", origin, 0, 0, weaponobj );
    weaponent hide();
    weaponent forcenetfieldhighlod( 1 );
    weaponent linkto( avatar, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    avatar.weaponent = weaponent;
    avatar.playerexists = 1;
    avatar.forcehide = 0;
    self.player_rig.avatar = avatar;
    self.player_rig thread function_2839481298d2e5f4();
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 0
// Checksum 0x0, Offset: 0x19a9
// Size: 0xf7
function function_2839481298d2e5f4()
{
    avatar = self.avatar;
    player = self.player;
    
    if ( isplayer( player ) )
    {
        avatar.playerexists = 1;
    }
    
    avatar.forcehide = 0;
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "update_avatar_visibility" );
        
        if ( !isdefined( avatar ) )
        {
            return;
        }
        
        shouldshow = !istrue( avatar.playerexists ) && !istrue( avatar.forcehide );
        
        if ( shouldshow )
        {
            avatar show();
            
            if ( isdefined( avatar.weaponent ) && !istrue( avatar.forcehideweapons ) )
            {
                avatar.weaponent show();
            }
            
            continue;
        }
        
        avatar hide();
        
        if ( isdefined( avatar.weaponent ) )
        {
            avatar.weaponent hide();
        }
    }
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 2
// Checksum 0x0, Offset: 0x1aa8
// Size: 0x52
function function_e874fd3a9c016379( shouldforcehide, var_cbaf46af6f07196 )
{
    if ( isdefined( self.avatar ) )
    {
        self.avatar.forcehide = shouldforcehide;
        self.avatar.forcehideweapons = var_cbaf46af6f07196;
        self notify( "update_avatar_visibility" );
    }
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 0
// Checksum 0x0, Offset: 0x1b02
// Size: 0xd7
function remove_player_rig()
{
    if ( isdefined( self ) )
    {
        println( "<dev string:xa7>" + self.name + "<dev string:x49>" + self.animname + "<dev string:x59>" + isdefined( self.player_rig ) );
        self unlink();
    }
    
    if ( isdefined( self.player_rig ) )
    {
        if ( isdefined( self.player_rig.avatar ) )
        {
            if ( isdefined( self.player_rig.avatar.weaponent ) )
            {
                self.player_rig.avatar.weaponent delete();
            }
            
            self.player_rig.avatar delete();
        }
        
        self.player_rig delete();
    }
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 1
// Checksum 0x0, Offset: 0x1be1
// Size: 0x9a
function get_center_of_array( array )
{
    center = ( 0, 0, 0 );
    
    for ( i = 0; i < array.size ; i++ )
    {
        center = ( center[ 0 ] + array[ i ].origin[ 0 ], center[ 1 ] + array[ i ].origin[ 1 ], center[ 2 ] + array[ i ].origin[ 2 ] );
    }
    
    if ( array.size != 0 )
    {
        return ( center[ 0 ] / array.size, center[ 1 ] / array.size, center[ 2 ] / array.size );
    }
    
    return undefined;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 7
// Checksum 0x0, Offset: 0x1c84
// Size: 0xa4
function function_3f005b301ec7f15b( testarray, animref, animpct, originoffset, radius, height, var_d4364a524e8a2bcd )
{
    newstruct = spawnstruct();
    newstruct.animref = animref;
    newstruct.animpct = animpct;
    newstruct.originoffset = originoffset;
    newstruct.cylinderradius = radius;
    newstruct.cylinderheight = height;
    newstruct.var_d4364a524e8a2bcd = var_d4364a524e8a2bcd;
    testarray[ testarray.size ] = newstruct;
    return testarray;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 7
// Checksum 0x0, Offset: 0x1d31
// Size: 0xa4
function function_f317a6f0ae25e3d4( testarray, modelname, animref, animpct, originoffset, radius, var_d4364a524e8a2bcd )
{
    newstruct = spawnstruct();
    newstruct.modelname = modelname;
    newstruct.animref = animref;
    newstruct.animpct = animpct;
    newstruct.originoffset = originoffset;
    newstruct.sphereradius = radius;
    newstruct.var_d4364a524e8a2bcd = var_d4364a524e8a2bcd;
    testarray[ testarray.size ] = newstruct;
    return testarray;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 7
// Checksum 0x0, Offset: 0x1dde
// Size: 0xa4
function function_19ae50e23fe0625a( testarray, modelname, animref, originoffset, radius, numsegments, var_d4364a524e8a2bcd )
{
    newstruct = spawnstruct();
    newstruct.modelname = modelname;
    newstruct.animref = animref;
    newstruct.originoffset = originoffset;
    newstruct.sphereradius = radius;
    newstruct.numsegments = numsegments;
    newstruct.var_d4364a524e8a2bcd = var_d4364a524e8a2bcd;
    testarray[ testarray.size ] = newstruct;
    return testarray;
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 3
// Checksum 0x0, Offset: 0x1e8b
// Size: 0x14b
function function_c300d34e34164b6d( fadedowntime, var_95a318d022e623a7, var_1bb7594c18d17443 )
{
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
    
    if ( isdefined( fadedowntime ) && fadedowntime > 0 )
    {
        overlay.alpha = 0;
        overlay fadeovertime( fadedowntime );
        overlay.alpha = 1;
        wait fadedowntime;
    }
    else
    {
        overlay.alpha = 1;
    }
    
    if ( isdefined( var_95a318d022e623a7 ) && var_95a318d022e623a7 > 0 )
    {
        wait var_95a318d022e623a7;
    }
    
    if ( isdefined( var_1bb7594c18d17443 ) && var_1bb7594c18d17443 > 0 )
    {
        overlay.alpha = 1;
        overlay fadeovertime( var_1bb7594c18d17443 );
        overlay.alpha = 0;
        wait var_1bb7594c18d17443;
    }
    else
    {
        overlay.alpha = 0;
    }
    
    overlay destroy();
}

// Namespace br_ending_util / scripts\mp\gametypes\br_ending_util
// Params 3
// Checksum 0x0, Offset: 0x1fde
// Size: 0x146
function function_3681a4700f5bb7c1( fadedowntime, var_1bb7594c18d17443, holdnotify )
{
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
    
    if ( isdefined( fadedowntime ) && fadedowntime > 0 )
    {
        overlay.alpha = 0;
        overlay fadeovertime( fadedowntime );
        overlay.alpha = 1;
        wait fadedowntime;
    }
    else
    {
        overlay.alpha = 1;
    }
    
    if ( isdefined( holdnotify ) )
    {
        level waittill( holdnotify );
    }
    
    if ( isdefined( var_1bb7594c18d17443 ) && var_1bb7594c18d17443 > 0 )
    {
        overlay.alpha = 1;
        overlay fadeovertime( var_1bb7594c18d17443 );
        overlay.alpha = 0;
        wait var_1bb7594c18d17443;
    }
    else
    {
        overlay.alpha = 0;
    }
    
    overlay destroy();
}

