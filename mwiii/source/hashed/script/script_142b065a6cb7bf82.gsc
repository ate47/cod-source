#using script_75377e59f5becac8;
#using script_930a1e7bd882c1d;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;

#namespace namespace_58c6a84f987ee8e1;

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0xc33
// Size: 0x167
function init()
{
    assert( isdefined( level.infilstruct ) );
    level.var_f84366b8fdd80cf2 = getdvarint( @"hash_1d024c82743aa4ce", 0 );
    level.infilstruct.c130model = "veh8_mil_air_mindia8_open_back_infil";
    level.infilstruct.var_30e653e12f358438 = "veh8_mil_air_mindia8_interior_vm_infil";
    level.infilstruct.binkname = "mp_donetsk_mindia8_intro";
    level.infilstruct.binktime = ter_op( level.var_f84366b8fdd80cf2, 0.1, 5 );
    level.infilstruct.var_b381e33e977da440 = &function_55f2480b4b819aea;
    level.infilstruct.var_ae9e4023110acc6e = &function_ad4a7a73c7d7d9e0;
    level.infilstruct.var_a6547e85663b3bc2 = &function_b766175a1f0eeb13;
    var_1809e16510055e87 = [ "cam_orbit_br_chopper_squad_player1", "cam_orbit_br_chopper_squad_player1", "cam_orbit_br_chopper_squad_player2", "cam_orbit_br_chopper_squad_player3", "cam_orbit_br_chopper_squad_player4" ];
    function_226e337633a44059( var_1809e16510055e87, "cam_orbit_br_chopper_solo" );
    function_ad12d29d41483e8a( "prematch", &void );
    function_ad12d29d41483e8a( "cinematic", &function_5901cd0be722f86a );
    function_ad12d29d41483e8a( "animatic", &function_39c2cf6576478d41 );
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1
// Checksum 0x0, Offset: 0xda2
// Size: 0x1410
function function_55f2480b4b819aea( movingchopper )
{
    animstruct = spawnstruct();
    movingchopper.animstruct = animstruct;
    animstruct.origin = getdvarvector( @"br_infil_anim_pos", ( 4319, 0, -28644 ) );
    animstruct.angles = ( 0, 0, 0 );
    animstruct.movingchopper = movingchopper;
    animstruct.cleanupfunc = &function_a5668882499fb369;
    animstruct.chopper = getent( "infil_chopper", "script_noteworthy" );
    
    if ( isdefined( animstruct.chopper ) )
    {
        animstruct.chopper show();
    }
    else
    {
        animstruct.chopper = animstruct spawn_script_model( "veh8_mil_air_mindia8_interior_infil", "chopper" );
        animstruct.chopper.angles = animstruct.angles;
        animstruct.chopper.cleanme = 1;
    }
    
    animstruct.choppershell = getent( "infil_chopper_open", "script_noteworthy" );
    
    if ( isdefined( animstruct.choppershell ) )
    {
        animstruct.choppershell show();
    }
    else
    {
        animstruct.choppershell = animstruct.chopper spawn_script_model( "veh8_mil_air_mindia8_open_back_infil", "choppershell" );
        animstruct.choppershell.angles = animstruct.chopper.angles;
        animstruct.choppershell.cleanme = 1;
    }
    
    animstruct.chopperinnards = animstruct.chopper spawn_script_model( "veh8_mil_air_mindia8_interior_infil_netting", "movingChopper" );
    animstruct.chopperinnards linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.chopperdoor = animstruct.chopper spawn_script_model( "veh8_mil_air_mindia8_interior_infil_cabin_door", "chopperDoor" );
    animstruct.chopperdoor linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( animstruct.movingchopper ) )
    {
        animstruct.movingchopper.animname = "movingChopper";
        animstruct.movingchopper.innards.animname = "movingChopper";
    }
    
    animstruct.cameraentsolo = animstruct.chopper spawn_script_model( "generic_prop_x3", "camera" );
    animstruct.cameraentsolo linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.cameraentsquad = animstruct.chopper spawn_script_model( "generic_prop_x3", "cameraSquad" );
    animstruct.cameraentsquad linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( movingchopper ) )
    {
        movingchopper forcenetfieldhighlod( 1 );
        animstruct.var_7bbc3350e7793cc6 = movingchopper spawn_script_model( "generic_prop_x3", "cameramoving" );
        animstruct.var_7bbc3350e7793cc6 linkto( movingchopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.var_7bbc3350e7793cc6 forcenetfieldhighlod( 1 );
        animstruct.var_a9a5dab973b28fad = movingchopper spawn_script_model( "generic_prop_x3", "cameraSquadmoving" );
        animstruct.var_a9a5dab973b28fad linkto( movingchopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.var_a9a5dab973b28fad forcenetfieldhighlod( 1 );
    }
    
    animstruct.playerpositionents[ "parent_solo" ] = animstruct.chopper spawn_script_model( "generic_prop_x3", "propsolo" );
    animstruct.playerpositionents[ "parent_solo" ] linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playerpositionents[ "parent_squad" ] = animstruct.chopper spawn_script_model( "generic_prop_x5", "propparent" );
    animstruct.playerpositionents[ "parent_squad" ] linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags = [];
    animstruct.playertags[ 0 ] = animstruct.chopper spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 1 ] = animstruct.chopper spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 2 ] = animstruct.chopper spawn_script_model( "tag_player", "playerTag2" );
    animstruct.playertags[ 3 ] = animstruct.chopper spawn_script_model( "tag_player", "playerTag3" );
    animstruct.playertags[ 4 ] = animstruct.chopper spawn_script_model( "tag_player", "playerTag4" );
    animstruct.playertags[ 0 ] linkto( animstruct.playerpositionents[ "parent_solo" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 1 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 2 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 3 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 4 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels = [];
    animstruct.playermodels[ 0 ] = animstruct.chopper spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
    animstruct.playermodels[ 1 ] = animstruct.chopper spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
    animstruct.playermodels[ 2 ] = animstruct.chopper spawn_script_model( "fullbody_usmc_ar_br_infil", "player2" );
    animstruct.playermodels[ 3 ] = animstruct.chopper spawn_script_model( "fullbody_usmc_ar_br_infil", "player3" );
    animstruct.playermodels[ 4 ] = animstruct.chopper spawn_script_model( "fullbody_usmc_ar_br_infil", "player4" );
    animstruct.playermodels[ 0 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 1 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 2 ] linkto( animstruct.playertags[ 1 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 3 ] linkto( animstruct.playertags[ 2 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 4 ] linkto( animstruct.playertags[ 3 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.aipilot = animstruct.chopper spawn_script_model( "body_mp_western_otter_3_1_lod1", "aiPilot" );
    animstruct.aipilothead = spawn( "script_model", animstruct.aipilot gettagorigin( "j_neck" ) );
    animstruct.aipilothead setmodel( "head_mp_eastern_metalghost_1_1" );
    animstruct.aipilothead.animname = "aiPilotHead";
    animstruct.aipilothead linkto( animstruct.aipilot, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    animstruct.aipilot linkto( animstruct.playerpositionents[ "parent_solo" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.aicopilot = animstruct.chopper spawn_script_model( "body_mp_western_otter_3_1_lod1", "aiCopilot" );
    var_8b31bc2c19776c6f = spawn( "script_model", animstruct.aicopilot gettagorigin( "j_neck" ) );
    var_8b31bc2c19776c6f setmodel( "head_mp_eastern_metalghost_1_1" );
    var_8b31bc2c19776c6f linkto( animstruct.aicopilot, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    animstruct.aicopilot linkto( animstruct.playerpositionents[ "parent_solo" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.armadarig = animstruct.chopper spawn_script_model( "generic_prop_x10", "armadaRig" );
    animstruct.armadarig linkto( animstruct.chopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.armadarig forcenetfieldhighlod( 1 );
    var_d4e512c7842a8a5d = 9;
    animstruct.armadachoppers = [];
    
    for ( i = 0; i < var_d4e512c7842a8a5d ; i++ )
    {
        newchopper = animstruct.chopper spawn_script_model( "veh8_mil_air_mindia8_infil_flight", "newChopper" + i );
        newchopper linkto( animstruct.armadarig, "j_prop_" + i + 2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        newchopper forcenetfieldhighlod( 1 );
        newchopper playloopsound( "br_heli_infil_fleet_lp" );
        animstruct.armadachoppers[ animstruct.armadachoppers.size ] = newchopper;
    }
    
    animstruct.packs = [];
    n = 0;
    
    if ( !istrue( level.var_f84366b8fdd80cf2 ) )
    {
        animstruct.packs[ n ] = animstruct create_animpack( "scene1" );
        animstruct.packs[ n ] add_pack_startfunc( [], &function_1d609f282b615eb7 );
        animstruct.packs[ n ] function_e718ba63d511fcde( [], &function_447159ec37003898 );
        animstruct.packs[ n ] add_pack_modelanim( animstruct.cameraentsolo, level.br_anim[ "wz_infil_mindia8_solo_cam" ] );
        
        if ( isdefined( animstruct.var_7bbc3350e7793cc6 ) )
        {
            animstruct.packs[ n ] add_pack_modelanim( animstruct.var_7bbc3350e7793cc6, level.br_anim[ "wz_infil_mindia8_solo_cam" ] );
        }
        
        animstruct.packs[ n ] add_pack_modelanim( animstruct.cameraentsquad, level.br_anim[ "wz_infil_mindia8_squad_cam" ] );
        
        if ( isdefined( animstruct.var_a9a5dab973b28fad ) )
        {
            animstruct.packs[ n ] add_pack_modelanim( animstruct.var_a9a5dab973b28fad, level.br_anim[ "wz_infil_mindia8_squad_cam" ] );
        }
        
        animstruct.packs[ n ] add_pack_modelanim( animstruct.playerpositionents[ "parent_solo" ], level.br_anim[ "wz_infil_mindia8_solo_character_link" ] );
        animstruct.packs[ n ] add_pack_modelanim( animstruct.playerpositionents[ "parent_squad" ], level.br_anim[ "wz_infil_mindia8_squad_character_link" ] );
        animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_mindia8_solo_player" ] );
        animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_mindia8_squad_player1" ] );
        animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_mindia8_squad_player2" ] );
        animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_mindia8_squad_player3" ] );
        animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_mindia8_squad_player4" ] );
        animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_mindia8_solo_player" ] );
        animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_mindia8_squad_player1" ] );
        animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_mindia8_squad_player2" ] );
        animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_mindia8_squad_player3" ] );
        animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_mindia8_squad_player4" ] );
        animstruct.packs[ n ] add_pack_modelanim( animstruct.aipilot, level.br_anim[ "wz_infil_mindia8_solo_pilot" ] );
        animstruct.packs[ n ] add_pack_modelanim( animstruct.aipilothead, level.br_anim[ "wz_infil_mindia8_solo_pilot" ] );
        animstruct.packs[ n ] add_pack_modelanim( animstruct.aicopilot, level.br_anim[ "wz_infil_mindia8_solo_copilot" ] );
        animstruct.packs[ n ] add_pack_modelanim( animstruct.armadarig, level.br_anim[ "wz_infil_mindia8_armada" ] );
        animstruct.packs[ n ] function_d4561ab1ba4f5de9( animstruct.cameraentsquad, "j_prop_1", level.br_anim[ "wz_infil_mindia8_solo_player" ] );
        
        if ( !isdefined( level.scr_notetrack[ "camera" ] ) )
        {
            scripts\common\anim::addnotetrack_customfunction( "camera", "transition", &transitionfunc );
            scripts\common\anim::addnotetrack_customfunction( "camera", "fadeinstart", &fadeinfunc );
            scripts\common\anim::addnotetrack_customfunction( "camera", "fadeoutstart", &fadeoutfunc );
        }
        
        if ( !isdefined( level.scr_notetrack[ "cameraSquad" ] ) )
        {
            scripts\common\anim::addnotetrack_customfunction( "cameraSquad", "transition", &transitionfunc );
            scripts\common\anim::addnotetrack_customfunction( "cameraSquad", "fadeinstart", &fadeinfunc );
            scripts\common\anim::addnotetrack_customfunction( "cameraSquad", "fadeoutstart", &fadeoutfunc );
        }
    }
    
    n++;
    animstruct.packs[ n ] = animstruct create_animpack( "looping", 1 );
    animstruct.packs[ n ] add_pack_startfunc( [], &function_5ff576fc264728a6 );
    animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_mindia8_loop_pl02" ] );
    animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_mindia8_loop_pl03" ] );
    animstruct.packs[ n ] function_ad0bcac98781e0ab( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_mindia8_loop_pl04" ] );
    animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_mindia8_loop_pl02" ] );
    animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_mindia8_loop_pl03" ] );
    animstruct.packs[ n ] function_f7fc8b110c478968( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_mindia8_loop_pl04" ] );
    animstruct.packs[ n ] function_d4561ab1ba4f5de9( animstruct.cameraentsquad, "j_prop_1" );
    return animstruct;
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0x21bb
// Size: 0x196
function function_f3ae4b41df047ba0()
{
    teams = [];
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( teams[ player.team ] ) )
        {
            teams[ player.team ] = [];
        }
        
        teams[ player.team ][ teams[ player.team ].size ] = player;
    }
    
    foreach ( players in teams )
    {
        numplayers = players.size;
        possibleindices = [ 2, 3, 4, 5 ];
        
        if ( numplayers == 1 )
        {
            possibleindices = [ 1 ];
        }
        
        playercount = 0;
        
        foreach ( player in players )
        {
            player.infilanimindex = possibleindices[ playercount % possibleindices.size ];
            player.var_db122a8941dfee14 = numplayers;
            playercount++;
        }
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1
// Checksum 0x0, Offset: 0x2359
// Size: 0x1a3
function function_1d609f282b615eb7( array )
{
    function_f3ae4b41df047ba0();
    
    if ( isdefined( self.movingchopper ) )
    {
        self.movingchopper stoploopsound();
    }
    
    self.aipilot hide();
    self.aicopilot hide();
    self.movingchopper show();
    self.chopperinnards show();
    thread clearsoundsubmixmpbrinfilanim();
    
    if ( isdefined( self.movingchopper ) )
    {
        self.movingchopper setscriptablepartstate( "infil_fx_hero", "on" );
        self.movingchopper setscriptablepartstate( "infil_fx_mindia8", "moving" );
    }
    
    function_fd00edc34074bb24();
    thread chopper_door();
    thread infil_light_dvars();
    thread delaystreamtomovingplane();
    
    foreach ( armadachopper in self.armadachoppers )
    {
        var_52d8b7e47fb268fc = getanimlength( level.br_anim[ "wz_infil_mindia8_loop_veh" ] );
        var_23a79fd929b2ba3d = randomfloatrange( 0.5, var_52d8b7e47fb268fc - 0.5 );
        armadachopper scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopper", var_23a79fd929b2ba3d );
        armadachopper setscriptablepartstate( "infil_fx_armada", "on" );
        
        if ( isdefined( armadachopper.innards ) )
        {
            armadachopper.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopperInnards", var_23a79fd929b2ba3d );
        }
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 2
// Checksum 0x0, Offset: 0x2504
// Size: 0x14a
function function_447159ec37003898( player, array )
{
    assert( isdefined( player ) );
    var_28844396b0024faf = 48;
    var_d1c04ff6328d20d6 = 5.6;
    var_95288242e2d19a2 = 50.7;
    var_8a3ce4d151659d21 = 2;
    var_9b5197cc4bb4356a = 4;
    player playlocalsound( "br_heli_infil_part2_lr" );
    player setsoundsubmix( "mp_br_infil_anim", 0 );
    player setsoundsubmix( "mp_br_infil_music", 0 );
    player setsoundsubmix( "mp_br_infil_ac130", 0 );
    player setclienttriggeraudiozone( "mp_br_c130_infil_int", 1 );
    player setclientdvar( @"cg_fov", var_28844396b0024faf );
    player setclientdvar( @"hash_71c6c0b8428e44a7", 1 );
    player enablephysicaldepthoffieldscripting();
    player setphysicaldepthoffield( var_d1c04ff6328d20d6, var_95288242e2d19a2, var_8a3ce4d151659d21, var_9b5197cc4bb4356a );
    self.aipilot showtoplayer( player );
    self.aicopilot showtoplayer( player );
    
    if ( !isdefined( player.infilcoveroverlay ) )
    {
        player.infilcoveroverlay = newclienthudelem( player );
        function_347d499c7fd9af39( player.infilcoveroverlay );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1
// Checksum 0x0, Offset: 0x2656
// Size: 0xb8
function function_347d499c7fd9af39( hudelem )
{
    hudelem.x = 0;
    hudelem.y = 0;
    hudelem setshader( "white", 640, 480 );
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.horzalign = "fullscreen";
    hudelem.vertalign = "fullscreen";
    hudelem.sort = -1;
    hudelem.color = ( 0.21, 0.21, 0.17 );
    hudelem.alpha = 0;
    hudelem setshowinrealism( 1 );
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1
// Checksum 0x0, Offset: 0x2716
// Size: 0x1b7
function function_5ff576fc264728a6( array )
{
    if ( istrue( level.var_f84366b8fdd80cf2 ) )
    {
        if ( isdefined( self.movingchopper ) )
        {
            self.movingchopper setscriptablepartstate( "infil_fx_hero", "on" );
            self.movingchopper setscriptablepartstate( "infil_fx_mindia8", "moving" );
        }
        
        foreach ( armadachopper in self.armadachoppers )
        {
            var_52d8b7e47fb268fc = getanimlength( level.br_anim[ "wz_infil_mindia8_loop_veh" ] );
            var_23a79fd929b2ba3d = randomfloatrange( 0.5, var_52d8b7e47fb268fc - 0.5 );
            armadachopper scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopper", var_23a79fd929b2ba3d );
            armadachopper setscriptablepartstate( "infil_fx_armada", "on" );
            
            if ( isdefined( armadachopper.innards ) )
            {
                armadachopper.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopperInnards", var_23a79fd929b2ba3d );
            }
        }
        
        self.var_7bbc3350e7793cc6 scriptmodelplayanim( "wz_infil_mindia8_solo_cam", "cameramoving", 10, 6 );
        self.var_a9a5dab973b28fad scriptmodelplayanim( "wz_infil_mindia8_squad_cam", "cameraSquadmoving", 10, 6 );
        self.armadarig scriptmodelplayanim( "wz_infil_mindia8_armada", "armadaRig", 0, 3 );
        transitionfunc();
    }
    
    self.chopper stoploopsound();
    
    if ( isdefined( self.movingchopper ) )
    {
        self.movingchopper playloopsound( "br_heli_infil_hero_lp" );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0x28d5
// Size: 0x11
function function_a5668882499fb369()
{
    namespace_56a3588493afc984::cleanupents();
    level notify( "cleanupInfil" );
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x28ee
// Size: 0x84
function private clearsoundsubmixmpbrinfilanim()
{
    level endon( "cleanupInfil" );
    waitandpause( 0.65 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "mp_br_infil_anim", 3 );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x297a
// Size: 0x7d
function private clearsoundsubmixfadetoblackamb()
{
    waitandpause( 0.5 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb", 1 );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x29ff
// Size: 0x7d
function private function_c6cedf68afe4e839()
{
    waitandpause( 7.7 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "mp_br_infil_ac130", 30 );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2a84
// Size: 0x83
function private function_fd00edc34074bb24( c130 )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        player setwind( "80", 1 );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0x2b0f
// Size: 0x60
function chopper_door()
{
    level endon( "cleanupInfil" );
    
    if ( isdefined( self.chopperdoor ) )
    {
        self.chopperdoor hide();
    }
    
    self.cameraentsolo waittill_match_or_timeout( "camera", "showdoor", 30 );
    
    if ( isdefined( self.chopperdoor ) )
    {
        self.chopperdoor show();
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2b77
// Size: 0x78
function private clearplayerwind()
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setwind( "1" );
        player.manualoverridewindmaterial = undefined;
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2bf7
// Size: 0xcb
function private fadeinfunc( c130 )
{
    fadeintime = 0.15;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.infilcoveroverlay ) )
        {
            continue;
        }
        
        player.infilcoveroverlay.alpha = 0;
        player.infilcoveroverlay fadeovertime( fadeintime );
        player.infilcoveroverlay.alpha = 1;
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2cca
// Size: 0x150
function private fadeoutfunc( c130 )
{
    fadeouttime = 0.2;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.infilcoveroverlay ) )
        {
            continue;
        }
        
        player.infilcoveroverlay.alpha = 1;
        player.infilcoveroverlay fadeovertime( fadeouttime );
        player.infilcoveroverlay.alpha = 0;
    }
    
    waitandpause( fadeouttime + 0.1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.infilcoveroverlay ) )
        {
            continue;
        }
        
        player.infilcoveroverlay destroy();
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e22
// Size: 0x547
function private transitionfunc( c130 )
{
    level.infilstruct.animstruct notify( "infil_reset_light_dvars" );
    level.infilstruct.animstruct clearplayerwind();
    var_1992f143059ac1d5 = 65;
    var_e49fe50208c2823c = 14;
    var_60a2fccf1c5e6d84 = 35;
    var_af0267d0ec57107f = 2;
    var_92de264f62389db4 = 4;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player setclienttriggeraudiozone( "mp_br_infil_ext", 2 );
    }
    
    if ( isdefined( level.infilstruct.animstruct.movingchopper ) )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            cameraent = ter_op( player.var_db122a8941dfee14 == 1, level.infilstruct.animstruct.var_7bbc3350e7793cc6, level.infilstruct.animstruct.var_a9a5dab973b28fad );
            cameratag = "j_prop_1";
            player cameraunlink();
            player cameralinkto( cameraent, cameratag, 1, 1 );
            player setclientdvar( @"cg_fov", var_1992f143059ac1d5 );
            player setclientdvar( @"hash_71c6c0b8428e44a7", 1 );
            player setphysicaldepthoffield( var_e49fe50208c2823c, var_60a2fccf1c5e6d84, var_af0267d0ec57107f, var_92de264f62389db4 );
            player thread function_9441cfee5f114846();
        }
        
        level thread clearsoundsubmixfadetoblackamb();
        level.infilstruct.animstruct.playerpositionents[ "parent_solo" ] unlink();
        level.infilstruct.animstruct.playerpositionents[ "parent_squad" ] unlink();
        level.infilstruct.animstruct.playerpositionents[ "parent_solo" ] linkto( level.infilstruct.animstruct.movingchopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.playerpositionents[ "parent_squad" ] linkto( level.infilstruct.animstruct.movingchopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.armadarig unlink();
        level.infilstruct.animstruct.armadarig linkto( level.infilstruct.animstruct.movingchopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.movingchopper scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "movingChopper" );
        level.infilstruct.animstruct.movingchopper.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "movingChopperInnards" );
        level.infilstruct.animstruct.playerpositionents[ "parent_solo" ] scriptmodelplayanim( "wz_infil_mindia8_loop_genpropx10", "prop" );
        level.infilstruct.animstruct.playerpositionents[ "parent_squad" ] scriptmodelplayanim( "wz_infil_mindia8_loop_genpropx10", "prop" );
        
        if ( istrue( level.var_f84366b8fdd80cf2 ) )
        {
            level waittill( "play_video_complete" );
        }
        
        level.infilstruct.animstruct.movingchopper notify( "start_moving" );
        
        if ( istrue( level.var_f84366b8fdd80cf2 ) )
        {
            wait 3.5;
        }
    }
    
    level.infilstruct.animstruct.aipilot hide();
    level.infilstruct.animstruct.aicopilot hide();
    setomnvar( "ui_hide_player_icons", 0 );
    level thread function_c6cedf68afe4e839();
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0x3371
// Size: 0x1f
function function_9441cfee5f114846()
{
    if ( istrue( level.var_f84366b8fdd80cf2 ) )
    {
        level waittill( "play_video_complete" );
    }
    
    self notify( "infil_move" );
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3398
// Size: 0x13e
function private infil_light_dvars()
{
    level endon( "cleanupInfil" );
    var_c3ed855fe7c983e3 = getdvarfloat( @"sm_spotdistcull" );
    var_1800e53d66415e2d = getdvarint( @"hash_63eb1893f96ac98d" );
    var_5506432d2291c178 = getdvarint( @"hash_1dde331a8e0153d8" );
    var_488f9b9fe1ead0a6 = getdvarfloat( @"sm_sunsamplesizenear" );
    var_64224ecf1e2975d9 = getdvarint( @"hash_e6ac75ab2927895b" );
    setdvar( @"sm_spotdistcull", 1000 );
    setdvar( @"hash_63eb1893f96ac98d", 8 );
    setdvar( @"hash_1dde331a8e0153d8", 8 );
    setdvar( @"sm_sunsamplesizenear", 0.25 );
    setdvar( @"hash_e6ac75ab2927895b", 0 );
    waittill_either( "infil_reset_light_dvars", "stopScene" );
    setdvar( @"sm_spotdistcull", var_c3ed855fe7c983e3 );
    setdvar( @"hash_63eb1893f96ac98d", var_1800e53d66415e2d );
    setdvar( @"hash_1dde331a8e0153d8", var_5506432d2291c178 );
    setdvar( @"sm_sunsamplesizenear", var_488f9b9fe1ead0a6 );
    setdvar( @"hash_e6ac75ab2927895b", var_64224ecf1e2975d9 );
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x34de
// Size: 0x132
function private delaystreamtomovingplane()
{
    self endon( "stopScene" );
    level endon( "cleanupInfil" );
    
    if ( isdefined( self.movingchopper ) )
    {
        delaytime = getdvarint( @"hash_d01d0472d843d39e", 8 );
        wait delaytime;
        
        if ( !isdefined( self.movingchopper ) )
        {
            return;
        }
        
        streamorigin = self.movingchopper.origin;
        forward = getdvarint( @"hash_7abcda2d7aabbe4c", 0 );
        
        if ( forward > 0 )
        {
            dir = anglestoforward( self.movingchopper.angles );
            streamorigin = self.movingchopper.origin + dir * forward;
        }
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setpredictedstreamloaddist( 0 );
            player scripts\mp\gametypes\br_public::playerstreamhintlocation( streamorigin );
        }
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3618
// Size: 0xa9
function private stopstreamtomovingplane()
{
    if ( isdefined( self.movingchopper ) && getdvarint( @"hash_eb8a05afa7735e5f", 1 ) == 1 )
    {
        delaytime = getdvarint( @"hash_b7c6d487b0f5506b", 5 );
        wait delaytime;
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player thread scripts\mp\gametypes\br_public::playerclearstreamhintorigin();
        }
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0x36c9
// Size: 0xbe
function function_5901cd0be722f86a()
{
    br_infil_intro = function_17ee301cf0b5ba85( "br_infil_intro" );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setentitysoundcontext( "lobby_fade", "", 2 );
        player playlocalsound( "br_heli_infil_part1_lr" );
        player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
        player setsoundsubmix( "solo_cin_igc_music", 0.5 );
        player setplayermusicstate( br_infil_intro );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0x378f
// Size: 0xb
function function_39c2cf6576478d41()
{
    level thread setsoundsubmixfadetoblackamb();
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x37a2
// Size: 0xab
function private setsoundsubmixfadetoblackamb( players )
{
    level endon( "cleanupInfil" );
    
    if ( !istrue( level.var_f84366b8fdd80cf2 ) )
    {
        waitandpause( 2 );
    }
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "solo_cin_igc_music", 0.5 );
        player setsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb", 2 );
    }
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 0
// Checksum 0x0, Offset: 0x3855
// Size: 0x1f8
function function_ad4a7a73c7d7d9e0()
{
    var_522a77434d41564a = self getplayerangles( 1 );
    playerforward = anglestoforward( var_522a77434d41564a );
    planeforward = anglestoforward( level.infilstruct.c130.angles );
    planeright = anglestoright( level.infilstruct.c130.angles );
    dotforward = vectordot( playerforward, planeforward );
    dotright = vectordot( playerforward, planeright );
    
    if ( !isdefined( self.infilanimindex ) )
    {
        self.infilanimindex = 1;
    }
    
    var_8e3afd40d3c95b46 = "j_prop_" + self.infilanimindex + 2;
    cos45 = cos( 45 );
    
    if ( dotforward < -1 * cos45 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10", level.br_anim[ "wz_infil_mindia8_jump_genpropx10" ], "wz_infil_mindia8_jump01_pl01", var_8e3afd40d3c95b46 ];
    }
    
    if ( dotright > cos45 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_90_l", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_90_l" ], "wz_infil_mindia8_jump01_pl01_90_l", var_8e3afd40d3c95b46 ];
    }
    
    if ( dotright < -1 * cos45 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_90_r", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_90_r" ], "wz_infil_mindia8_jump01_pl01_90_r", var_8e3afd40d3c95b46 ];
    }
    
    if ( dotright > 0 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_180_l", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_180_l" ], "wz_infil_mindia8_jump01_pl01_180_l", var_8e3afd40d3c95b46 ];
    }
    
    return [ "wz_infil_mindia8_jump_genpropx10_180_r", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_180_r" ], "wz_infil_mindia8_jump01_pl01_180_r", var_8e3afd40d3c95b46 ];
}

// Namespace namespace_58c6a84f987ee8e1 / namespace_5c75c180befb8e98
// Params 2
// Checksum 0x0, Offset: 0x3a55
// Size: 0xad
function function_b766175a1f0eeb13( movedestination, movetime )
{
    level endon( "game_ended" );
    self endon( "death" );
    self hide();
    
    if ( isdefined( self.innards ) )
    {
        self.innards hide();
    }
    
    self waittill( "start_moving" );
    self show();
    
    if ( isdefined( self.innards ) )
    {
        self.innards show();
    }
    
    self moveto( movedestination, movetime );
    
    /#
        if ( getdvarint( @"hash_c25457fbe123d92f", 0 ) )
        {
            movetime -= 10;
        }
    #/
    
    thread scripts\mp\gametypes\br_c130::killaftertime( movetime, "c130" );
    self playloopsound( "br_heli_infil_hero_lp" );
}

