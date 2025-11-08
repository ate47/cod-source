#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\samsite;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_supply_drops_common;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace dmz_samsites;

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0xa1a
// Size: 0x887
function function_ad4172a44f169cb6()
{
    if ( !getdvarint( @"hash_fa0d15fa95281a06", 1 ) )
    {
        return;
    }
    
    level.var_d57c61fe001f1707 = spawnstruct();
    level.var_d57c61fe001f1707.var_ab56b9f3b70782a6 = getdvarint( @"hash_bc26df7f41837a1e", 3 );
    level.var_d57c61fe001f1707.var_5975a9ef47c4674c = getdvarint( @"hash_bc02f17f415b26fc", 7 );
    level.var_d57c61fe001f1707.captureradius = getdvarint( @"hash_e8c36536afd06323", 512 );
    level.var_d57c61fe001f1707.capturemaxheight = getdvarint( @"hash_65a4247a6a99d511", 500 );
    level.var_d57c61fe001f1707.captureminheight = getdvarint( @"hash_a9b2ffcf64bcddf3", -50 );
    level.var_d57c61fe001f1707.capturetime = getdvarint( @"hash_a47d932b5dcb7a74", 60 );
    level.var_d57c61fe001f1707.var_36576a67f06f7657 = getdvarint( @"hash_cc862f7d0a6c378f", 5000 );
    level.var_d57c61fe001f1707.var_aafba8d70563022b = getdvarint( @"hash_ab0966facf3e7683", 300 );
    level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 = getdvarint( @"hash_7a4c18bda90eae0c", 16000 );
    level.var_d57c61fe001f1707.var_f4f7f8e7aa14ee19 = getdvarint( @"hash_c858e5ff90540e26", 50000 );
    level.var_d57c61fe001f1707.reinforcementrange = getdvarint( @"hash_7ff620132228b8a9", 2500 );
    level.var_d57c61fe001f1707.var_a0b9a15e69b57d09 = getdvarint( @"hash_53eff3abae42511b", 1 );
    level.var_d57c61fe001f1707.trackplanes = getdvarint( @"hash_1b80b788c9c3da45", 1 );
    level.var_d57c61fe001f1707.var_f2e28100a201e1d4 = getdvarint( @"hash_a5b87d62ee975707", 1 );
    level.var_d57c61fe001f1707.var_91701c5f0103b916 = getdvarint( @"hash_175730bcca744c75", 1 );
    level.var_d57c61fe001f1707.var_4bb2ff3e6e82c373 = getdvarint( @"hash_e2c51295ca08d914", 5 );
    level.var_d57c61fe001f1707.var_ffb94540411249a9 = getdvarint( @"hash_fcaf02f59d6aa9ce", 8 );
    level.var_d57c61fe001f1707.var_fa3d844d56938a31 = getdvarint( @"hash_3bb5a9c980d546d9", 8 );
    level.var_d57c61fe001f1707.enableplanes = getdvarint( @"hash_b6aaddbf47fc8db6", 1 );
    level.var_d57c61fe001f1707.var_125035462230088f = getdvarint( @"hash_9134bb0c8c176121", 40 );
    level.var_d57c61fe001f1707.var_18be0584e3dc6151 = getdvarint( @"hash_b2bacdb9fac9e30f", 80 );
    level.var_d57c61fe001f1707.var_5d016cc8c6057e32 = getdvarint( @"hash_834c9ad109576fe1", 30 );
    level.var_d57c61fe001f1707.var_fa313e2c568dbc16 = getdvarint( @"hash_85b709709c5294ae", 1 );
    level.var_d57c61fe001f1707.showmissiles = getdvarint( @"hash_5a734e432dd09671", 1 );
    level.var_d57c61fe001f1707.forcefar = getdvarint( @"hash_bf8e2691659d83df", 1000000 );
    level.var_d57c61fe001f1707.forceclose = getdvarint( @"hash_ba806c360e59ef1e", 500000 );
    level.var_d57c61fe001f1707.travelspeed = getdvarint( @"hash_2d20c5ed21b56e40", 2000 );
    var_a3d06c05aa850ded = getdvarint( @"hash_437436f2598f5eda", 200 );
    level.var_d57c61fe001f1707.var_1b52e473aae939e3 = var_a3d06c05aa850ded * var_a3d06c05aa850ded;
    level.var_d57c61fe001f1707.var_b07ed256b46ec93b = getdvarint( @"hash_20928e0d72d6482a", 1 );
    level.var_d57c61fe001f1707.var_a2cbe62d6cd1847b = getdvarfloat( @"hash_55f010da0dc36ab2", 0.5 );
    function_5ea3fe433148fa9f();
    level._effect[ "samsite_bomb_explosion" ] = loadfx( "vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx" );
    level.var_9215e3a9dfe8a262 = &function_2ccf2416263812e2;
    level.var_d8d4808549090419 = &function_36dc1a84de5bdb04;
    level.var_4691a578582af454 = &function_c35ccf109cb08d19;
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "dmz_samsite_base", &function_5e0b45946652eeb3 );
    collisionarr = getentarray( "dmz_samsite_brushmodel", "script_noteworthy" );
    
    if ( isdefined( collisionarr ) )
    {
        level.var_308f0eb1d9bd3f25 = collisionarr[ 0 ];
    }
    
    level.samsites = [];
    
    if ( istrue( level.var_d57c61fe001f1707.var_b07ed256b46ec93b ) )
    {
        level.var_721546c4f8df565d = [];
        
        foreach ( team in level.teamnamelist )
        {
            start = level.teamdata[ team ][ "startPoint" ];
            
            if ( !isdefined( start ) )
            {
                continue;
            }
            
            if ( !isdefined( level.var_721546c4f8df565d[ start.poi ] ) )
            {
                level.var_721546c4f8df565d[ start.poi ] = [];
            }
            
            level.var_721546c4f8df565d[ start.poi ][ level.var_721546c4f8df565d[ start.poi ].size ] = start;
        }
        
        locations = getstructarray( "dmz_samsite", "targetname" );
        var_371c833eba04930e = scripts\mp\poi::function_7e9cbc0f32de6578();
        level.var_86cde7dde516573 = [];
        var_622366932d8ea2cb = [];
        
        foreach ( location in locations )
        {
            if ( !isdefined( location.poi ) )
            {
                location.poi = scripts\mp\poi::poi_findPOIOriginIsIn( location.origin );
            }
            
            poi = location.poi;
            
            if ( !isdefined( poi ) || var_371c833eba04930e && !scripts\mp\poi::poi_ispoiactive( poi ) )
            {
                continue;
            }
            
            location.score = function_e2d9a460b285095e( location );
            
            if ( isdefined( var_622366932d8ea2cb[ poi ] ) && var_622366932d8ea2cb.size > 0 )
            {
                if ( var_622366932d8ea2cb[ poi ].score < location.score )
                {
                    var_622366932d8ea2cb[ poi ] = location;
                }
                
                continue;
            }
            
            var_622366932d8ea2cb[ poi ] = location;
        }
        
        foreach ( node in var_622366932d8ea2cb )
        {
            level.var_86cde7dde516573[ level.var_86cde7dde516573.size ] = node;
        }
        
        numtospawn = randomintrange( level.var_d57c61fe001f1707.var_ab56b9f3b70782a6, level.var_d57c61fe001f1707.var_5975a9ef47c4674c + 1 );
        level.var_86cde7dde516573 = array_randomize( level.var_86cde7dde516573 );
        
        for ( spawnindex = 0; spawnindex < numtospawn && spawnindex < level.var_86cde7dde516573.size ; spawnindex++ )
        {
            node = level.var_86cde7dde516573[ spawnindex ];
            samsite = function_92b3b4d8e797bea7( node );
            samsite function_dd951b288c7c19f8( node );
            numagents = randomintrange( level.var_d57c61fe001f1707.var_4bb2ff3e6e82c373, level.var_d57c61fe001f1707.var_ffb94540411249a9 + 1 );
            samsite thread function_920e785cfdd82b86( numagents );
        }
    }
    
    thread function_18a561a377cac8a7();
    thread function_cc5fa2fba2f077a0();
    
    /#
        thread function_3a49a55088058778();
    #/
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x12a9
// Size: 0x186
function function_92b3b4d8e797bea7( node )
{
    samsite = function_4bcdaa72e4fe9480( node );
    samsite function_a94f5ceeae751b8();
    samsite.targetentity = spawn( "script_model", samsite.origin + ( 0, 0, 9000 ) + anglestoforward( samsite.angles ) * 10000 );
    samsite settargetentity( samsite.targetentity );
    samsite.curorigin = samsite.origin;
    samsite.offset3d = ( 0, 0, 100 );
    samsite.trackedents = [];
    samsite scripts\mp\gameobjects::requestid( 1, 1, undefined, 1 );
    
    if ( istrue( level.var_d57c61fe001f1707.var_b07ed256b46ec93b ) )
    {
        scripts\mp\objidpoolmanager::update_objective_icon( samsite.objidnum, "ui_map_icon_obj_sam_site" );
        scripts\mp\objidpoolmanager::update_objective_setbackground( samsite.objidnum, 4 );
    }
    
    objective_setbackground( samsite.objidnum, 1 );
    objective_setpinned( samsite.objidnum, 1 );
    objective_position( samsite.objidnum, samsite.origin + ( 0, 0, 50 ) );
    objective_addalltomask( samsite.objidnum );
    objective_hidefromplayersinmask( samsite.objidnum );
    samsite thread function_594d850004436026();
    return samsite;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x1438
// Size: 0xb3
function function_cc5fa2fba2f077a0()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( samsite in level.samsites )
    {
        foreach ( player in level.players )
        {
            samsite enablescriptableplayeruse( player );
        }
    }
}

#using_animtree( "script_model" );

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x14f3
// Size: 0x77
function function_5ea3fe433148fa9f()
{
    level.scr_animtree[ "samsite" ] = #animtree;
    level.scr_anim[ "samsite" ][ "fire" ] = level.br_anim[ "iw9_mp_prop_samsite_launch" ];
    animindex = "outro_gunship_death";
    level.scr_animtree[ "gunship" ] = #animtree;
    level.scr_anim[ "gunship" ][ animindex ] = %mp_acharlie130_death;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x1572
// Size: 0xa7
function function_e2d9a460b285095e( location )
{
    score = 0;
    
    if ( isdefined( level.var_721546c4f8df565d[ location.poi ] ) )
    {
        foreach ( start in level.var_721546c4f8df565d[ location.poi ] )
        {
            score += distancesquared( location.origin, start.origin );
        }
    }
    
    return score;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x1622
// Size: 0x3ef
function function_4bcdaa72e4fe9480( location )
{
    base = spawnscriptable( "dmz_samsite_base", location.origin, location.angles );
    samsite = spawnturret( "misc_turret", location.origin, "dmz_sam_site_tur" );
    base.samsite = samsite;
    samsite.base = base;
    
    if ( !isdefined( location.angles ) )
    {
        location.angles = ( 0, 0, 0 );
    }
    
    samsite.angles = location.angles;
    samsite setmodel( "military_dmz_sam_site_turret_rig" );
    samsite settoparc( 90 );
    samsite setbottomarc( 0 );
    samsite setleftarc( 360 );
    samsite setrightarc( 360 );
    samsite setscriptablepartstate( "dmz_samsite_base", "usable" );
    samsite.icon = spawnscriptable( "dmz_samsite_icon", samsite.origin, samsite.angles );
    samsite.icon setscriptablepartstate( "icon", "healthy" );
    
    if ( istrue( level.var_d57c61fe001f1707.var_b07ed256b46ec93b ) )
    {
        samsite.icon = spawnscriptable( "dmz_samsite_icon", samsite.origin, samsite.angles );
        samsite.icon setscriptablepartstate( "icon", "healthy" );
    }
    
    boundsorigin = samsite.origin + 35 * anglestoforward( samsite.angles );
    samsite.navobstacleid = createnavobstaclebybounds( boundsorigin, ( 150, 120, 200 ), samsite.angles );
    
    if ( isdefined( level.var_308f0eb1d9bd3f25 ) )
    {
        collision = spawn( "script_model", samsite.origin );
        collision dontinterpolate();
        collision.angles = samsite.angles;
        collision clonebrushmodeltoscriptmodel( level.var_308f0eb1d9bd3f25 );
        thread function_7ef46292d6fb27b7( samsite, collision );
        collision setentityowner( samsite );
        collision disconnectpaths();
        collision.moverdoesnotkill = 1;
        collision.samsite = samsite;
        samsite.collision = collision;
        samsite validatecollision( collision, level.var_308f0eb1d9bd3f25 );
    }
    
    samsite maketurretinoperable();
    samsite.missilesfired = 0;
    samsite.poi = location.poi;
    samsite.shownplayers = [];
    
    if ( isdefined( location.poi ) )
    {
        samsite.poi = location.poi;
    }
    else
    {
        samsite.poi = scripts\mp\poi::poi_findPOIOriginIsIn( location.origin );
    }
    
    level.samsites[ level.samsites.size ] = samsite;
    tempnodes = getstructarray( location.target, "targetname" );
    samsite.spawnernodes = [];
    
    foreach ( tempnode in tempnodes )
    {
        if ( isdefined( tempnode.script_noteworthy ) && issubstr( tempnode.script_noteworthy, "guard" ) )
        {
            samsite.spawnernodes[ samsite.spawnernodes.size ] = tempnode;
        }
    }
    
    return samsite;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 2
// Checksum 0x0, Offset: 0x1a1a
// Size: 0xcd
function function_7ef46292d6fb27b7( samsite, brushmodel )
{
    level endon( "game_ended" );
    tag = "tag_aim_animated";
    offset = ( -14, 0, -88 );
    angleoffset = ( 30.5, 0, 0 );
    
    while ( isdefined( samsite ) && isdefined( brushmodel ) )
    {
        tagorigin = samsite gettagorigin( tag );
        tagangles = samsite gettagangles( tag );
        transformorigin = coordtransform( offset, tagorigin, tagangles );
        var_a4a389d51e640577 = combineangles( tagangles, angleoffset );
        brushmodel.origin = transformorigin;
        brushmodel.angles = var_a4a389d51e640577;
        waitframe();
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x1aef
// Size: 0x15
function function_87ea19d8830ea0b3( index )
{
    return "mg0" + index + 1;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x1b0d
// Size: 0x5b
function function_cc25275b4f14df1b( num )
{
    if ( level.var_d57c61fe001f1707.showmissiles )
    {
        tag = function_87ea19d8830ea0b3( num );
        self showpart( tag );
        self.missiles[ num ] = 1;
        return;
    }
    
    self.missiles[ num ] = 1;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x1b70
// Size: 0x3b
function function_a94f5ceeae751b8()
{
    if ( !isdefined( self.missiles ) )
    {
        self.missiles = [];
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        function_cc25275b4f14df1b( i );
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 2
// Checksum 0x0, Offset: 0x1bb3
// Size: 0x1cb
function function_13ffbc8076c6a2f3( missileindex, target )
{
    self endon( "death" );
    tag = function_87ea19d8830ea0b3( missileindex );
    
    if ( level.var_d57c61fe001f1707.showmissiles )
    {
        if ( !isdefined( self.missiles[ missileindex ] ) )
        {
            return;
        }
        
        self.missiles[ missileindex ] = undefined;
        self hidepart( tag );
    }
    else
    {
        if ( !isdefined( self.missiles[ missileindex ] ) )
        {
            return;
        }
        
        self.missiles[ missileindex ] = undefined;
    }
    
    self setscriptablepartstate( "launch", "on" );
    origin = self gettagorigin( tag );
    angles = self gettagangles( tag );
    forward = anglestoforward( angles );
    fakefireweapon = makeweapon( "samsite_missile_weapon" );
    owner = undefined;
    
    if ( isdefined( self.owningteam ) && isdefined( getteamdata( self.owningteam, "players" ) ) )
    {
        players = getteamdata( self.owningteam, "players" );
        
        if ( players.size > 0 )
        {
            owner = players[ 0 ];
        }
    }
    
    proj = scripts\cp_mp\utility\weapon_utility::_magicbullet( fakefireweapon, origin, origin + forward * 1000, owner );
    self.proj = proj;
    proj.samsite = self;
    proj setmodel( "military_dmz_sam_site_missile" );
    proj setentityowner( self );
    proj.owningteam = self.owningteam;
    self.missilesfired++;
    proj setscriptablepartstate( "military_samsite_missile", "on" );
    proj thread function_ea701de0c74b3d7a( target );
    proj thread function_a9720ae0cd1c43ec( target );
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x1d86
// Size: 0x139
function function_ea701de0c74b3d7a( target )
{
    if ( isdefined( target ) && isdefined( target.ent ) && isdefined( self ) )
    {
        if ( target.type == 0 )
        {
            self missile_settargetent( target.ent, ( 0, 0, -100 ) );
        }
        else if ( target.type == 1 )
        {
            self missile_settargetent( target.ent, ( level.var_d57c61fe001f1707.travelspeed, 0, 0 ) );
        }
        else if ( target.type == 2 )
        {
            self missile_settargetent( target.ent, ( 0, 0, -100 ) );
        }
        else if ( target.type == 3 )
        {
            self missile_settargetent( target.ent, ( 0, 0, -100 ) );
        }
        
        self missile_setflightmodedirect();
        self.lockontarget = target.ent;
        thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile( target.ent, self );
        wait 4;
        
        if ( isdefined( self ) )
        {
            self notify( "clearTargetLockedOntoByProjectile" );
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x1ec7
// Size: 0xc7
function function_a9720ae0cd1c43ec( target )
{
    level endon( "game_ended" );
    
    if ( isdefined( target ) && target.type == 1 )
    {
        while ( true )
        {
            if ( !isdefined( self ) || !isdefined( target ) || !isdefined( target.ent ) )
            {
                return;
            }
            
            dist = distance( target.ent.origin, self.origin );
            
            if ( dist < 600 )
            {
                thread function_666ad4e4e3cc4524( target.ent, self.owningteam );
                scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "samsite_plane_hit", self.owningteam );
                scripts\mp\pmc_missions::function_19d6e799236e4435( self );
                self delete();
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 2
// Checksum 0x0, Offset: 0x1f96
// Size: 0x67
function function_666ad4e4e3cc4524( plane, team )
{
    level.var_d57c61fe001f1707.hitplane = 1;
    
    if ( !istrue( plane.hit ) )
    {
        plane notify( "plane_hit", team );
        plane setcandamage( 0 );
        plane.hit = 1;
        plane function_4c4dbf406a67ce68();
        plane function_25184bb26f5d9b31();
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x2005
// Size: 0x8e
function function_ce2565296095b940( target )
{
    if ( !isdefined( self.nextmissile ) )
    {
        self.nextmissile = 0;
    }
    
    thread function_13ffbc8076c6a2f3( self.nextmissile, target );
    self.nextmissile = ( self.nextmissile + 1 ) % 4;
    wait 1;
    
    if ( self.nextmissile == 0 && self.missilesfired < level.var_d57c61fe001f1707.var_fa3d844d56938a31 )
    {
        wait 5;
        function_a94f5ceeae751b8();
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x209b
// Size: 0x40
function function_ab3d52600e20b324()
{
    while ( true )
    {
        thread function_13ffbc8076c6a2f3( 0 );
        wait 5;
        thread function_13ffbc8076c6a2f3( 1 );
        wait 5;
        thread function_13ffbc8076c6a2f3( 2 );
        function_a94f5ceeae751b8();
        wait 5;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x20e3
// Size: 0x140
function function_fbfacb92d755dedc( target )
{
    velocity = undefined;
    origin = undefined;
    
    if ( target.type == 0 )
    {
        heli = target.ent;
        velocity = heli vehicle_getvelocity();
        origin = heli.occupants[ "driver" ].origin;
    }
    else if ( target.type == 1 )
    {
        c130 = target.ent;
        velocity = c130.velocity;
        origin = c130.origin;
    }
    else if ( target.type == 2 || target.type == 3 )
    {
        heli = target.ent;
        velocity = heli vehicle_getvelocity();
        origin = heli.origin;
    }
    
    if ( !isdefined( velocity ) || !isdefined( origin ) )
    {
        return undefined;
    }
    
    dist = distance( self.origin, origin );
    missilespeed = 6000;
    var_d1e7847092585ddb = dist / missilespeed;
    return origin + velocity * var_d1e7847092585ddb;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x222c
// Size: 0x22c, Type: bool
function function_12eed3315be94b9e( target )
{
    var_77294299d5bee66b = 50;
    var_f58ff7e9a26fd75d = 50;
    duration = 5;
    timer = 0;
    var_316bdf341c07246b = 0;
    
    while ( timer < duration && isdefined( self.owningteam ) )
    {
        if ( !isdefined( target ) || !isdefined( target.ent ) || !function_66ba1ee70dfa7f10( target ) )
        {
            return false;
        }
        
        origin = target.ent.origin;
        ignored = [ self ];
        aimorigin = self gettagorigin( "tag_aim_animated" );
        trace = scripts\engine\trace::ray_trace( aimorigin, origin, ignored, undefined, 0, 1 );
        tracedist = distance( self.origin, origin ) * ( 1 - trace[ "fraction" ] );
        
        if ( tracedist > 200 )
        {
            return false;
        }
        
        if ( isdefined( self.entlockedonto ) && self.entlockedonto != target.ent )
        {
            scripts\cp_mp\utility\weapon_utility::removelockedon( target.ent, self );
        }
        
        if ( !isdefined( self.entlockedonto ) )
        {
            scripts\cp_mp\utility\weapon_utility::addlockedon( target.ent, self );
        }
        
        origin = function_fbfacb92d755dedc( target );
        
        if ( !isdefined( origin ) )
        {
            return false;
        }
        
        targetdir = vectornormalize( origin - aimorigin ) * 1000;
        self.targetentity.origin = aimorigin + targetdir;
        tagdir = anglestoforward( self gettagangles( "tag_aim_animated" ) ) * 1000;
        angle = math::anglebetweenvectors( origin - aimorigin, tagdir );
        
        if ( abs( angle ) > 15 && !var_316bdf341c07246b )
        {
            self setscriptablepartstate( "lock_start_audio", "on" );
            var_316bdf341c07246b = 1;
        }
        
        if ( abs( angle ) < 5 )
        {
            return true;
        }
        
        timer += level.framedurationseconds;
        waitframe();
    }
    
    return false;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x2461
// Size: 0x150
function function_5b157a05a421cb( target )
{
    if ( self.missilesfired < level.var_d57c61fe001f1707.var_fa3d844d56938a31 )
    {
        if ( target.type == 1 )
        {
            scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "samsite_nearby_plane", self.owningteam );
        }
        else if ( target.type == 0 )
        {
            scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "samsite_enemy_heli", self.owningteam );
        }
        
        self setscriptablepartstate( "audio", "rotate_start" );
        shouldfire = function_12eed3315be94b9e( target );
        self setscriptablepartstate( "audio", "rotate_stop" );
        
        if ( isdefined( target.ent ) && isdefined( target.ent.attackerslockedon ) && isdefined( target.ent.attackerslockedon[ self getentitynumber() ] ) && target.ent.attackerslockedon[ self getentitynumber() ] == self )
        {
            scripts\cp_mp\utility\weapon_utility::removelockedon( target.ent, self );
        }
        
        if ( shouldfire )
        {
            self setscriptablepartstate( "lock_fire_audio", "on" );
            wait 0.3;
            function_ce2565296095b940( target );
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x25b9
// Size: 0x1e3
function function_66ba1ee70dfa7f10( target )
{
    switch ( target.type )
    {
        case 0:
            heli = target.ent;
            return ( heli.occupants.size && isdefined( self.owningteam ) && isdefined( heli.occupants[ "driver" ] ) && heli.occupants[ "driver" ].team != self.owningteam && distance( heli.origin, self.origin ) < level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 );
        case 1:
            c130 = target.ent;
            return ( isdefined( self.owningteam ) && distance2d( c130.origin, self.origin ) < level.var_d57c61fe001f1707.var_f4f7f8e7aa14ee19 && !istrue( c130.hit ) );
        case 2:
            heli = target.ent;
            return ( isdefined( self.owningteam ) && distance( heli.origin, self.origin ) < level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 );
        case 3:
            heli = target.ent;
            return ( isdefined( self.owningteam ) && distance( heli.origin, self.origin ) < level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 );
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x27a4
// Size: 0x5b
function function_f4442f000c3a0fec( target )
{
    switch ( target.type )
    {
        case 0:
            return 100;
        case 1:
            return 200;
        case 2:
            return 300;
        case 3:
            return 50;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x2807
// Size: 0x127
function function_594d850004436026()
{
    level endon( "game_ended" );
    
    if ( getdvarint( @"hash_e7366d21f0d5d8a0", 1 ) == 0 )
    {
        return;
    }
    
    while ( true )
    {
        isowned = isdefined( self.owningteam );
        
        if ( isowned && isdefined( self.trackedents ) && self.trackedents.size > 0 )
        {
            besttarget = undefined;
            var_24ff44101b202835 = [];
            priority = 0;
            
            foreach ( target in self.trackedents )
            {
                if ( isdefined( target.ent ) && function_66ba1ee70dfa7f10( target ) )
                {
                    var_24ff44101b202835[ var_24ff44101b202835.size ] = target;
                    targetpriority = function_f4442f000c3a0fec( target );
                    
                    if ( priority <= targetpriority )
                    {
                        besttarget = target;
                        priority = targetpriority;
                    }
                }
            }
            
            self.trackedents = var_24ff44101b202835;
            
            if ( isdefined( besttarget ) )
            {
                function_5b157a05a421cb( besttarget );
            }
        }
        
        wait 2;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x2936
// Size: 0xc0
function function_dd951b288c7c19f8( location )
{
    self.snipernodes = [];
    
    if ( isdefined( location.target ) )
    {
        nodes = getstructarray( location.target, "targetname" );
        
        foreach ( node in nodes )
        {
            switch ( node.script_noteworthy )
            {
                case #"hash_67ba230fb131ff98":
                    self.snipernodes[ self.snipernodes.size ] = node;
                    break;
            }
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x29fe
// Size: 0x2df
function function_920e785cfdd82b86( numagents )
{
    while ( !isdefined( level.struct_class_names ) || !isdefined( level.var_41670c1c65f3d3cf ) || aibudgetmp_getnumagentsanddormantsincategory( "everybody" ) <= 0 )
    {
        waitframe();
    }
    
    self.numagents = 0;
    self.agents = [];
    
    if ( isdefined( self.spawnernodes ) && self.spawnernodes.size >= 3 )
    {
        foreach ( node in self.spawnernodes )
        {
            isstationary = issubstr( node.script_noteworthy, "stationary" );
            agent = scripts\mp\ai_mp_controller::spawnguard( node, isstationary, undefined, "medium", "mission", "samInitialGuards" );
            
            if ( isdefined( agent ) )
            {
                self.agents[ self.agents.size ] = agent;
            }
        }
    }
    else
    {
        for ( i = 0; i < numagents ; i++ )
        {
            aitype = function_d5bc07eabf352abb( undefined, undefined, "overwatch" );
            var_fb30e2e6aca1d19 = randomfloatrange( 144, 360 );
            forward = anglestoforward( self.angles ) * var_fb30e2e6aca1d19;
            right = vectorcross( ( 0, 0, 1 ), forward );
            facingangle = axistoangles( forward, right, ( 0, 0, 1 ) );
            var_88b83b0d7a43ea72 = i / numagents * 360 + randomfloatrange( -30, 30 ) % 360;
            offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, var_88b83b0d7a43ea72 );
            origin = self.origin + offset;
            
            if ( issubstr( aitype, "sniper" ) && isdefined( self.snipernodes ) && self.snipernodes.size > 0 )
            {
                node = random( self.snipernodes );
                self.snipernodes = array_remove( self.snipernodes, node );
                origin = node.origin;
                facingangle = node.angles;
            }
            
            agent = ai_mp_requestspawnagent( aitype, origin, facingangle, "medium", "mission", "samInitialGuards", undefined, undefined, undefined, self.poi, 0, undefined, 1 );
            
            if ( isdefined( agent ) )
            {
                self.agents[ i ] = agent;
                thread scripts\mp\ai_behavior::function_b11c1964f528574b( agent );
            }
        }
    }
    
    self.numagents = self.agents.size;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 6
// Checksum 0x0, Offset: 0x2ce5
// Size: 0x237
function function_5e0b45946652eeb3( instance, part, state, useplayer, bautouse, usestring )
{
    if ( !function_c076a54f4bdf7bce( useplayer ) )
    {
        useplayer scripts\mp\hud_message::showerrormessage( level.br_pickups.var_355cddb773cb000d );
        return;
    }
    
    samsite = instance.entity;
    
    if ( isdefined( samsite.capturingteam ) )
    {
        var_f6ce5fbae9847fb9 = getteamdata( samsite.capturingteam, "players" );
        
        foreach ( player in var_f6ce5fbae9847fb9 )
        {
            if ( isdefined( player ) )
            {
                objective_hideprogressforclient( samsite.objidnum, player );
                objective_setshowpinnedprogressbar( 0, player );
            }
        }
    }
    
    playersonteam = getteamdata( useplayer.team, "players" );
    
    foreach ( player in level.players )
    {
        instance enablescriptableplayeruse( player );
    }
    
    foreach ( player in playersonteam )
    {
        instance disablescriptableplayeruse( player );
    }
    
    samsite.capturingplayer = useplayer;
    samsite.capturingteam = useplayer.team;
    samsite notify( "start_capture" );
    function_c1fd3441ccfba6f8( useplayer.team, "dmz_activity_action", 1, "dmz_activity_action_classic" );
    samsite thread function_7d87c71b552407a4();
    samsite.base thread function_8a39dc2e70fa624b( samsite );
    samsite function_ff2aeea62b8ffb41();
    samsite thread function_30cf9ba4bf893a9a();
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x2f24
// Size: 0x64
function function_ff2aeea62b8ffb41()
{
    foreach ( player in self.shownplayers )
    {
        if ( isdefined( player ) )
        {
            scripts\mp\objidpoolmanager::function_26259bd38697b5ad( self.objidnum, player );
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x2f90
// Size: 0x608
function function_30cf9ba4bf893a9a()
{
    self endon( "start_capture" );
    level endon( "game_ended" );
    playersonteam = getteamdata( self.capturingteam, "players" );
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "samsite_begin_capture", self.capturingteam );
    objective_removeallfrommask( self.objidnum );
    
    foreach ( player in playersonteam )
    {
    }
    
    objective_showtoplayersinmask( self.objidnum );
    waitframe();
    objective_setplayintro( self.objidnum, 0 );
    self.var_7b45aaac74192c14 = scripts\mp\ai_mp_controller::function_353fecd1549f5f42( self.origin, level.var_d57c61fe001f1707.reinforcementrange );
    
    if ( self.var_7b45aaac74192c14.size < 5 )
    {
        thread function_adbd4a9d1bb7572b();
    }
    
    starttime = gettime();
    timesincestart = 0;
    duration = level.var_d57c61fe001f1707.capturetime * 1000;
    
    if ( !istrue( level.var_d57c61fe001f1707.var_b07ed256b46ec93b ) && isdefined( self.owningteam ) )
    {
        duration *= level.var_d57c61fe001f1707.var_a2cbe62d6cd1847b;
    }
    
    self.shownplayers = [];
    
    while ( timesincestart < duration )
    {
        incircle = 0;
        playersonteam = getteamdata( self.capturingteam, "players" );
        
        if ( !isdefined( playersonteam ) || playersonteam.size == 0 )
        {
            objective_addalltomask( self.objidnum );
            objective_hidefromplayersinmask( self.objidnum );
            self.capturingteam = undefined;
            return;
        }
        
        foreach ( player in playersonteam )
        {
            if ( isreallyalive( player ) && isdefined( player.origin ) )
            {
                dist = distance2dsquared( player.origin, self.origin );
                heightdiff = player.origin[ 2 ] - self.origin[ 2 ];
                heightcheck = level.var_d57c61fe001f1707.captureminheight <= heightdiff && heightdiff <= level.var_d57c61fe001f1707.capturemaxheight;
                
                if ( dist < level.var_d57c61fe001f1707.captureradius * level.var_d57c61fe001f1707.captureradius && heightcheck )
                {
                    incircle = 1;
                    
                    if ( !array_contains( self.shownplayers, player ) )
                    {
                        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
                        scripts\mp\objidpoolmanager::function_ce702e5925e31fc9( self.objidnum, player, 1, 2, &"DMZ/SAMSITE_CAPTURE_PROGRESS" );
                        self.shownplayers = array_add( self.shownplayers, player );
                    }
                    
                    objective_addclienttomask( self.objidnum, player );
                    continue;
                }
                
                if ( array_contains( self.shownplayers, player ) )
                {
                    scripts\mp\objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
                    scripts\mp\objidpoolmanager::function_26259bd38697b5ad( self.objidnum, player );
                    self.shownplayers = array_remove( self.shownplayers, player );
                }
            }
        }
        
        if ( istrue( incircle ) )
        {
            timesincestart += level.frameduration;
            progress = min( timesincestart / duration, 1 );
            objective_setprogress( self.objidnum, progress );
            objective_showtoplayersinmask( self.objidnum );
        }
        
        waitframe();
    }
    
    self notify( "captured" );
    function_ff2aeea62b8ffb41();
    objective_addalltomask( self.objidnum );
    objective_hidefromplayersinmask( self.objidnum );
    var_7408ed52662703d3 = level.poi[ self.poi ][ "players" ];
    playersonteam = getteamdata( self.capturingteam, "players" );
    var_7408ed52662703d3 = array_remove_array( var_7408ed52662703d3, playersonteam );
    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash( "dmz_samsite_captured", playersonteam, self.poi );
    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash( "dmz_samsite_captured_others", var_7408ed52662703d3, self.poi );
    
    if ( isdefined( self.owningteam ) )
    {
        var_ce6b5424f8072ed9 = getteamdata( self.owningteam, "players" );
        var_7408ed52662703d3 = array_remove_array( var_7408ed52662703d3, var_ce6b5424f8072ed9 );
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "samsite_counter_capture", self.owningteam );
        self.icon setscriptablepartstate( "icon", "healthy" );
        waitframe();
    }
    
    thread scripts\cp_mp\overlord::playevent( "samsite_others_captured", var_7408ed52662703d3, 2 );
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "samsite_captured", self.capturingteam, 2 );
    function_caeaf68ab0e87565( var_7408ed52662703d3, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
    function_c1fd3441ccfba6f8( self.capturingteam, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    self.owningteam = self.capturingteam;
    self.capturingteam = undefined;
    scripts\mp\pmc_missions::function_b71395f12af20a42( self );
    
    if ( istrue( level.var_d57c61fe001f1707.var_b07ed256b46ec93b ) )
    {
        self.icon setscriptablepartstate( "icon", "attacked" );
        self.icon function_fca5bdbe24070d20( "icon", self.owningteam );
    }
    else if ( scripts\engine\utility::issharedfuncdefined( "samsite", "onCapturedChange" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "samsite", "onCapturedChange" ) ]]( self );
    }
    
    thread function_43f27b5852d28616();
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x35a0
// Size: 0xe1
function function_7f8e0b88438e1071( pos )
{
    scale = randomfloatrange( 20, 60 );
    locvec = scale * level.var_d57c61fe001f1707.travelspeed * vectornormalize2( math::random_vector_2d() );
    minpos = ( pos[ 0 ] - locvec[ 0 ], pos[ 1 ] - locvec[ 1 ], scripts\cp_mp\parachute::getc130height() );
    maxpos = ( pos[ 0 ] + locvec[ 0 ], pos[ 1 ] + locvec[ 1 ], scripts\cp_mp\parachute::getc130height() );
    pathdir = vectornormalize( maxpos - minpos );
    pathstruct = spawnstruct();
    pathstruct.startpt = minpos;
    pathstruct.endpt = maxpos;
    pathstruct.angle = vectortoangles( pathdir );
    return pathstruct;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x368a
// Size: 0x174
function function_43f27b5852d28616()
{
    level endon( "game_ended" );
    self endon( "captured" );
    
    if ( level.var_d57c61fe001f1707.var_aafba8d70563022b < 0 )
    {
        return;
    }
    
    var_aafba8d70563022b = level.var_d57c61fe001f1707.var_aafba8d70563022b;
    
    if ( isdefined( self.capturingplayer ) )
    {
        upgradecount = default_to( callsharedfunc( "instanceInventory", "getUpgradeCount", self.capturingplayer, 26 ), 0 );
        var_aafba8d70563022b += upgradecount * getdvarfloat( @"hash_fe5eb9987b622e18", 30 );
    }
    
    wait var_aafba8d70563022b;
    playersonteam = getteamdata( self.owningteam, "players" );
    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash( "dmz_samsite_lost", playersonteam, self.poi );
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "samsite_capture_over", self.owningteam, 2 );
    function_c1fd3441ccfba6f8( self.owningteam, "dmz_activity_lose", 0, "dmz_activity_lose_classic" );
    
    foreach ( player in playersonteam )
    {
        self enablescriptableplayeruse( player );
    }
    
    self.icon setscriptablepartstate( "icon", "healthy" );
    self.owningteam = undefined;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3806
// Size: 0x58
function private function_adbd4a9d1bb7572b()
{
    level endon( "game_ended" );
    agents = undefined;
    
    while ( !isdefined( agents ) )
    {
        agents = scripts\mp\ai_mp_controller::function_77acc10c4823dd8a( 5, self.origin, "medium", "mission", "samReinforcements", undefined, undefined, 1, self.poi );
        
        if ( !isdefined( agents ) )
        {
            wait 1;
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 2
// Checksum 0x0, Offset: 0x3866
// Size: 0x3f
function function_bea9c8eda67e6310( ent, type )
{
    trackedobj = spawnstruct();
    trackedobj.ent = ent;
    trackedobj.type = type;
    return trackedobj;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 2
// Checksum 0x0, Offset: 0x38ae
// Size: 0x75, Type: bool
function function_4210f9b65c3db5b9( samsite, ent )
{
    foreach ( tracked in samsite.trackedents )
    {
        if ( tracked.ent == ent )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 5
// Checksum 0x0, Offset: 0x392c
// Size: 0x34
function function_2ccf2416263812e2( vehicle, seatid, oldseatid, player, data )
{
    vehicle thread function_c0f043e80f479c20();
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x3968
// Size: 0x1e
function function_36dc1a84de5bdb04( chopperinstance )
{
    chopperinstance.chopper thread function_4e1a28cce5be373a();
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x398e
// Size: 0x14
function function_c35ccf109cb08d19( heli )
{
    heli thread function_ff7b51833a73e61();
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x39aa
// Size: 0x148
function function_c0f043e80f479c20()
{
    level endon( "game_ended" );
    
    if ( !level.var_d57c61fe001f1707.var_a0b9a15e69b57d09 )
    {
        return;
    }
    
    while ( isdefined( self ) && self.occupants.size > 0 )
    {
        foreach ( samsite in level.samsites )
        {
            if ( isdefined( samsite.owningteam ) && isdefined( self.occupants[ "driver" ] ) && samsite.owningteam != self.occupants[ "driver" ].team && distancesquared( samsite.origin, self.origin ) < level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 * level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 && !function_4210f9b65c3db5b9( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_bea9c8eda67e6310( self, 0 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x3afa
// Size: 0x10a
function function_ff7b51833a73e61()
{
    level endon( "game_ended" );
    
    if ( !level.var_d57c61fe001f1707.var_91701c5f0103b916 )
    {
        return;
    }
    
    while ( isdefined( self ) && !istrue( self.unloaded ) )
    {
        foreach ( samsite in level.samsites )
        {
            if ( isdefined( samsite.owningteam ) && distancesquared( samsite.origin, self.origin ) < level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 * level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 && !function_4210f9b65c3db5b9( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_bea9c8eda67e6310( self, 3 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x3c0c
// Size: 0xfc
function function_4e1a28cce5be373a()
{
    level endon( "game_ended" );
    
    if ( !level.var_d57c61fe001f1707.var_f2e28100a201e1d4 )
    {
        return;
    }
    
    while ( isdefined( self ) )
    {
        foreach ( samsite in level.samsites )
        {
            if ( isdefined( samsite.owningteam ) && distancesquared( samsite.origin, self.origin ) < level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 * level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9 && !function_4210f9b65c3db5b9( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_bea9c8eda67e6310( self, 2 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x3d10
// Size: 0xf3
function function_91d32d800e116bfa()
{
    level endon( "game_ended" );
    
    if ( !level.var_d57c61fe001f1707.trackplanes )
    {
        return;
    }
    
    while ( isdefined( self ) )
    {
        foreach ( samsite in level.samsites )
        {
            dist = distance2d( samsite.origin, self.origin );
            
            if ( isdefined( samsite.owningteam ) && dist < level.var_d57c61fe001f1707.var_f4f7f8e7aa14ee19 && !function_4210f9b65c3db5b9( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_bea9c8eda67e6310( self, 1 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x3e0b
// Size: 0x1dd
function function_a23a2a8c5d40c210()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.health += damage;
        
        if ( isdefined( idflags ) && idflags & 8 )
        {
            self.wasdamagedfrombulletpenetration = 1;
        }
        
        if ( isdefined( idflags ) && idflags & 256 )
        {
            self.wasdamagedfrombulletricochet = 1;
        }
        
        modifieddamage = int( damage );
        
        if ( isdefined( objweapon ) )
        {
            class = weaponclass( objweapon );
            
            if ( isdefined( class ) && class == "rocketlauncher" )
            {
                modifieddamage += int( self.maxhealth / 2 );
            }
        }
        
        self.wasdamaged = 1;
        self.damagetaken += modifieddamage;
        self.health -= modifieddamage;
        isdeath = self.health <= 0;
        
        if ( isdefined( attacker ) && isplayer( attacker ) )
        {
            attacker scripts\cp_mp\damagefeedback::updatehitmarker( "standard", isdeath, 0, 1 );
        }
        
        if ( isdeath )
        {
            team = undefined;
            
            if ( isdefined( attacker ) )
            {
                team = attacker.team;
            }
            
            thread function_666ad4e4e3cc4524( self, team );
            return;
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 2
// Checksum 0x0, Offset: 0x3ff0
// Size: 0x9a
function function_995605db75897b06( plane, time )
{
    level endon( "game_ended" );
    plane endon( "plane_hit" );
    plane endon( "death" );
    time = ter_op( time >= 1, time, 1 );
    wait time - 1;
    
    if ( istrue( level.var_d57c61fe001f1707.var_fa313e2c568dbc16 ) )
    {
        plane setscriptablepartstate( "audio_exit", "on", 0 );
    }
    
    wait 1;
    
    if ( istrue( level.var_d57c61fe001f1707.var_fa313e2c568dbc16 ) )
    {
        plane setscriptablepartstate( "audio_loop", "off", 0 );
    }
    
    plane thread function_25184bb26f5d9b31();
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x4092
// Size: 0xf9
function function_e596d7d6322cab83()
{
    if ( !isdefined( level.mapname ) )
    {
        return ( randomfloatrange( -30000, 30000 ), randomfloatrange( -30000, 30000 ), 0 );
    }
    
    switch ( level.mapname )
    {
        case #"hash_57eba45b7ddbdcd6":
        case #"hash_63326ac3e12f8da0":
            return ( randomfloatrange( -30000, 30000 ), randomfloatrange( -30000, 30000 ), 0 );
        case #"hash_4617d802bdced46":
        case #"hash_a82a4d91a314a926":
            return ( randomfloatrange( -3000, 2000 ), randomfloatrange( -10000, 0 ), 0 );
        case #"hash_3eff14ec1d9395c1":
        case #"hash_636b409bbce21729":
        case #"hash_e817308cc606e9e1":
            return ( randomfloatrange( -15000, 15000 ), randomfloatrange( -10000, 0 ), 0 );
        default:
            return ( randomfloatrange( -30000, 30000 ), randomfloatrange( -30000, 30000 ), 0 );
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x4193
// Size: 0xff
function function_18a561a377cac8a7()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( !istrue( level.var_d57c61fe001f1707.enableplanes ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_level ) || !isdefined( level.br_level.br_mapboundsfull ) )
    {
        return;
    }
    
    level.currentplane = undefined;
    spawntime = 0;
    
    while ( true )
    {
        if ( !isdefined( level.currentplane ) )
        {
            if ( istrue( level.var_d57c61fe001f1707.hitplane ) )
            {
                level.var_d57c61fe001f1707.hitplane = undefined;
                wait level.var_d57c61fe001f1707.var_5d016cc8c6057e32;
            }
            
            wait randomfloatrange( level.var_d57c61fe001f1707.var_125035462230088f, level.var_d57c61fe001f1707.var_18be0584e3dc6151 );
            level.currentplane = function_9c57f5d58c4333ce();
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x429a
// Size: 0x16e
function function_9c57f5d58c4333ce()
{
    var_6fded323b6b347c9 = function_e596d7d6322cab83();
    pathstruct = function_7f8e0b88438e1071( var_6fded323b6b347c9 );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = level.var_d57c61fe001f1707.travelspeed;
    time = dist / travelspeed;
    c130 = scripts\mp\gametypes\br_supply_drops_common::function_2496cdd7babaed39( pathstruct, dist, travelspeed, time, "veh9_mil_air_cargo_plane_wm_dmz" );
    println( "<dev string:x1c>" );
    
    if ( istrue( level.var_d57c61fe001f1707.var_fa313e2c568dbc16 ) )
    {
        c130 setscriptablepartstate( "audio_loop", "on", 0 );
    }
    
    c130 moveto( c130.endpt, c130.lifetime );
    c130.velocity = ( pathstruct.endpt - pathstruct.startpt ) / time;
    c130 setcandamage( 1 );
    c130.maxhealth = getdvarint( @"hash_90b9a05ed8a66ba", 5000 );
    c130.health = c130.maxhealth;
    c130.damagetaken = 0;
    c130 thread function_91d32d800e116bfa();
    c130 thread function_a23a2a8c5d40c210();
    level thread function_995605db75897b06( c130, time );
    return c130;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x4411
// Size: 0x2e8
function function_4c4dbf406a67ce68()
{
    level endon( "game_ended" );
    var_633eaa5f21008b6f = self gettagorigin( "engine_propeller_l_01_jnt" );
    self.leftwingfxent = spawn( "script_model", var_633eaa5f21008b6f );
    self.leftwingfxent setmodel( "dmz_samsite_plane" );
    self.leftwingfxent.angles = self.angles;
    self.leftwingfxent setotherent( self.owner );
    self.leftwingfxent linkto( self, "engine_propeller_l_01_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_3eacd3938ccd4b6c = self gettagorigin( "engine_propeller_r_01_jnt" );
    self.rightwingfxent = spawn( "script_model", var_3eacd3938ccd4b6c );
    self.rightwingfxent setmodel( "dmz_samsite_plane" );
    self.rightwingfxent.angles = self.angles;
    self.rightwingfxent setotherent( self.owner );
    self.rightwingfxent linkto( self, "engine_propeller_r_01_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    waitframe();
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.var_ba27aac5a0f799e0 = spawn( "script_model", self.origin );
    self.var_ba27aac5a0f799e0 setmodel( "tag_origin" );
    self.var_ba27aac5a0f799e0.angles = vectortoangles( anglestoforward( self.angles ) );
    crashmodel = spawn( "script_model", self.origin );
    crashmodel setmodel( "dmz_samsite_plane_mesh" );
    crashmodel.angles = self.angles;
    crashmodel.animname = "gunship";
    crashmodel scripts\common\anim::setanimtree();
    crashpart = "crash_air";
    self.leftwingfxent setscriptablepartstate( crashpart, "on", 0 );
    
    if ( issharedfuncdefined( "entity", "delayEntDelete" ) )
    {
        crashmodel thread [[ getsharedfunc( "entity", "delayEntDelete" ) ]]( 10 );
    }
    
    self setscriptablepartstate( "dmz_audio_explosion", "on" );
    var_1041b7883e5d3da5 = "outro_gunship_death";
    var_f7380e0ba9c6762f = function_52351c3338da63f4( "gunship", var_1041b7883e5d3da5 );
    thread function_b4f2b6316268f9c4();
    thread function_40a9dfd673b1177b( var_f7380e0ba9c6762f, self.origin );
    thread function_3033111851fa46ea( var_f7380e0ba9c6762f );
    self.var_ba27aac5a0f799e0 scripts\common\anim::anim_single_solo( crashmodel, var_1041b7883e5d3da5 );
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x4701
// Size: 0x19b
function function_3033111851fa46ea( time )
{
    wait time * 0.5;
    crate = scripts\mp\gametypes\br_supply_drops_common::function_52f17e5fbec318a6( self.origin - ( 0, 0, level.var_5d2af95280a3cf58 ), level.supplydroptypes[ "dmz_samsite_drop" ] );
    
    if ( isdefined( crate ) )
    {
        crate unlink();
        force = ( 0, 0, 0 );
        
        if ( distance2d( crate.origin, ( 0, 0, 0 ) ) > level.var_d57c61fe001f1707.var_1b52e473aae939e3 )
        {
            dir = ( 0, 0, 0 ) - crate.origin;
            force = vectornormalize2( dir ) * level.var_d57c61fe001f1707.forcefar;
            force = ( force[ 0 ], force[ 1 ], randomfloatrange( -500000, 500000 ) );
        }
        else
        {
            force = randomvector( level.var_d57c61fe001f1707.forceclose );
        }
        
        crate physicslaunchserver( crate.origin, ( 0, 0, 0 ) );
        bodyid = crate physics_getbodyid( 0 );
        physics_setbodycenterofmassnormal( bodyid, ( 0, 0, 0 ) );
        crate.physicsactivated = 1;
        crate physics_applyimpulse( crate.origin, force );
        crate.usetime = 10;
        crate setscriptablepartstate( "dmz_supply_drop", "usable" );
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x48a4
// Size: 0x16
function function_b4f2b6316268f9c4()
{
    level endon( "game_ended" );
    wait 0.05;
    self hide();
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 2
// Checksum 0x0, Offset: 0x48c2
// Size: 0xe5
function function_40a9dfd673b1177b( delaytime, origin )
{
    level endon( "game_ended" );
    var_14b1d0692795af2f = delaytime - 2;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var_14b1d0692795af2f );
    radius = 30000;
    
    if ( isusingentitypartitiongrid() )
    {
        players = getentitiesinradiusfrompartitiongrid( origin, radius, createentitytypemask( [ "etype_player" ] ) );
        
        foreach ( player in players )
        {
            frac = distance( player.origin, origin ) / radius;
            
            if ( player scripts\cp_mp\utility\player_utility::_isalive() )
            {
                player earthquakeforplayer( 0.25, 2, origin, radius );
            }
        }
    }
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x49af
// Size: 0x94
function function_25184bb26f5d9b31()
{
    if ( isdefined( self.leftwingfxent ) )
    {
        self.leftwingfxent delete();
    }
    
    if ( isdefined( self.rightwingfxent ) )
    {
        self.rightwingfxent delete();
    }
    
    if ( isdefined( self.chassis ) )
    {
        self.chassis delete();
    }
    
    if ( isdefined( self.var_ba27aac5a0f799e0 ) )
    {
        self.var_ba27aac5a0f799e0 delete();
    }
    
    if ( isdefined( self ) )
    {
        self notify( "deleted" );
        self delete();
    }
    
    println( "<dev string:x53>" );
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x4a4b
// Size: 0x8d
function function_f3354ddc02e867c9( streakitem )
{
    samsite = getclosest( self.origin, level.samsites, level.var_d57c61fe001f1707.var_36576a67f06f7657 );
    blockkillstreak = isdefined( samsite ) && isdefined( samsite.owningteam ) && self.team != samsite.owningteam;
    
    if ( blockkillstreak )
    {
        streakitem.errormessage = "DMZ/SAMSITE_BLOCK_KILLSTREAK_ERR_MSG";
    }
    
    return blockkillstreak;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x4ae1
// Size: 0x1c
function function_f14f2cd0267b6ab7()
{
    return ter_op( isdefined( level.samsites ), level.samsites, [] );
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 0
// Checksum 0x0, Offset: 0x4b06
// Size: 0x76
function function_7d87c71b552407a4()
{
    level endon( "game_ended" );
    
    if ( !isdefined( self.warningsoundplaying ) || self.warningsoundplaying == 0 )
    {
        self.warningsoundplaying = 1;
    }
    else if ( isdefined( self.warningsoundplaying ) && self.warningsoundplaying == 1 )
    {
        return;
    }
    
    wait 1;
    self setscriptablepartstate( "warning_alarm_audio", "alarm_start" );
    wait 20.5;
    self.warningsoundplaying = 0;
}

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x4b84
// Size: 0x6f
function function_8a39dc2e70fa624b( samsite )
{
    level endon( "game_ended" );
    self setscriptablepartstate( "interaction_audio", "interaction_audio_start" );
    msg = samsite waittill_any_return_2( "start_capture", "captured" );
    
    if ( msg == "captured" )
    {
        self setscriptablepartstate( "interaction_audio", "interaction_audio_success" );
        return;
    }
    
    self setscriptablepartstate( "interaction_audio", "interaction_audio_off" );
}

/#

    // Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
    // Params 0
    // Checksum 0x0, Offset: 0x4bfb
    // Size: 0x5d9, Type: dev
    function function_3a49a55088058778()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_e09236524985b845", 0 ) )
            {
                foreach ( samsite in level.samsites )
                {
                    samsite.targetentity.origin = level.players[ 0 ].origin;
                }
            }
            
            if ( getdvarint( @"hash_e2efbec1dbe653f9", 0 ) )
            {
                origin = getdvarvector( @"hash_557cca80fb410b65", ( 0, 0, 0 ) );
                angles = getdvarvector( @"hash_253d7d4b4e329166", ( 0, 0, 0 ) );
                
                foreach ( samsite in level.samsites )
                {
                    samsite.collision unlink();
                    samsite.collision linkto( samsite, "<dev string:x8b>", origin, angles );
                }
            }
            
            if ( getdvarint( @"hash_899a5d114b54c419", 0 ) )
            {
                setdvar( @"hash_899a5d114b54c419", 0 );
                player = level.players[ 0 ];
                forward = anglestoforward( player getplayerangles() );
                fireorigin = level.players[ 0 ].origin + forward * 100;
                fireend = fireorigin + forward * 1000;
                fakefireweapon = makeweapon( "<dev string:x9f>" );
                proj = magicbullet( fakefireweapon, fireorigin, fireend );
                proj setmodel( "<dev string:xb9>" );
                proj setscriptablepartstate( "<dev string:xda>", "<dev string:xf6>" );
            }
            
            if ( getdvarint( @"hash_50797ed9f6affa3d", 0 ) )
            {
                setdvar( @"hash_50797ed9f6affa3d", 0 );
                
                foreach ( samsite in level.samsites )
                {
                    samsite function_ce2565296095b940();
                }
            }
            
            if ( getdvarint( @"hash_227f7408cd5466d4", 0 ) )
            {
                setdvar( @"hash_227f7408cd5466d4", 0 );
                
                foreach ( samsite in level.samsites )
                {
                    foreach ( player in level.players )
                    {
                        samsite disablescriptableplayeruse( player );
                        samsite enablescriptableplayeruse( player );
                    }
                }
            }
            
            if ( getdvarint( @"hash_eadc761bc3051cb1", 0 ) )
            {
                setdvar( @"hash_eadc761bc3051cb1", 0 );
                
                if ( isdefined( level.currentplane ) )
                {
                    function_666ad4e4e3cc4524( level.currentplane );
                }
            }
            
            var_265f9f6b5ee59c25 = getdvar( @"hash_2fd705c3c5dabfdd", "<dev string:xfc>" );
            
            if ( var_265f9f6b5ee59c25 != "<dev string:xfc>" && isdefined( level.players ) && isdefined( level.players[ 0 ] ) )
            {
                indexes = strtok( var_265f9f6b5ee59c25, "<dev string:x100>" );
                
                foreach ( index in indexes )
                {
                    index = int( index );
                    
                    if ( !isdefined( level.samsites[ index - 1 ] ) )
                    {
                        continue;
                    }
                    
                    samsite = level.samsites[ index - 1 ];
                    dist = distance( level.players[ 0 ].origin, samsite.origin );
                    scale = dist / 750;
                    
                    /#
                        print3d( samsite.origin + ( 0, 0, dist / log( dist ) ), "<dev string:x105>", ( 0, 1, 0 ), undefined, scale );
                    #/
                    
                    thread draw_circle( samsite.origin, level.var_d57c61fe001f1707.reinforcementrange, ( 0, 1, 0 ) );
                    
                    /#
                        print3d( samsite.origin + ( 0, 0, dist * 2 / log( dist ) ), "<dev string:x118>", ( 0, 0, 1 ), undefined, scale );
                    #/
                    
                    thread draw_circle( samsite.origin, level.var_d57c61fe001f1707.var_1decb3b28fa5e1c9, ( 0, 0, 1 ) );
                    
                    /#
                        print3d( samsite.origin + ( 0, 0, dist * 3 / log( dist ) ), "<dev string:x126>", ( 1, 0, 0 ), undefined, scale );
                    #/
                    
                    thread draw_circle( samsite.origin, level.var_d57c61fe001f1707.var_f4f7f8e7aa14ee19, ( 1, 0, 0 ) );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace dmz_samsites / scripts\mp\gametypes\dmz_samsites
// Params 1
// Checksum 0x0, Offset: 0x51dc
// Size: 0x24, Type: bool
function function_c076a54f4bdf7bce( player )
{
    if ( isdefined( player ) && istrue( player.var_859654e0445a36d9 ) )
    {
        return false;
    }
    
    return true;
}

