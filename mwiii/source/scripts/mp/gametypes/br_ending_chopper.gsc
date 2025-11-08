#using scripts\common\anim;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_ending_util;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;

#namespace br_ending_chopper;

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0
// Checksum 0x0, Offset: 0x101c
// Size: 0x9
function function_e04bd99e1bb6430b()
{
    chopperexif_fx_init();
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1
// Checksum 0x0, Offset: 0x102d
// Size: 0xed0
function chopperexfil_pack( var_cbfc3ba10cefc8ce )
{
    if ( !isdefined( var_cbfc3ba10cefc8ce ) )
    {
        var_cbfc3ba10cefc8ce = ( 0, 0, 0 );
    }
    
    thread chopperexfil_introsound( 5, var_cbfc3ba10cefc8ce );
    
    if ( !getdvarint( @"hash_19a406e3c51ce52f" ) )
    {
        self.transientname = get_chopperexfil_transient();
        loadinfiltransient( self.transientname );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        
        for ( var_24b79087f3897e94 = 0; !var_24b79087f3897e94 ; var_24b79087f3897e94 = isinfiltransientloaded( self.transientname ) )
        {
            waitframe();
        }
    }
    
    chopper = spawn_script_model( "veh8_mil_air_blima_scriptmodel" );
    chopper hidepart( "tag_main_rotor_blade_01" );
    chopper hidepart( "tag_main_rotor_blade_02" );
    chopper hidepart( "tag_main_rotor_blade_03" );
    chopper hidepart( "tag_main_rotor_blade_04" );
    chopper hidepart( "tag_tail_rotor_blade_01" );
    chopper hidepart( "tag_tail_rotor_blade_02" );
    chopper hidepart( "tag_tail_rotor_blade_03" );
    chopper hidepart( "tag_tail_rotor_blade_04" );
    self.exfilchopper = chopper;
    chopperexfil_set_brcircle();
    head = [ "head_mp_helicopter_crew", "j_spine4" ];
    extramodels = [ head ];
    body = "body_pilot_helicopter_british";
    ropeguy = spawn_script_model( body, undefined, extramodels );
    self.ropeguy = ropeguy;
    self.winners = array_removeundefined( self.winners );
    
    if ( self.winners.size == 0 )
    {
        create_disconnectplayer( self );
    }
    
    rope = spawn_script_model( "equipment_fast_rope_wm_01_infil_heli_l" );
    self.rope = rope;
    self.cam = create_cam();
    ascenders = [];
    ascenders[ 0 ] = spawn_script_model( "misc_wm_ascender", "misc_wm_ascender0" );
    
    if ( self.winners.size > 1 )
    {
        ascenders[ 1 ] = spawn_script_model( "misc_wm_ascender", "misc_wm_ascender1" );
    }
    
    if ( self.winners.size > 2 )
    {
        ascenders[ 2 ] = spawn_script_model( "misc_wm_ascender", "misc_wm_ascender2" );
    }
    
    if ( self.winners.size > 3 )
    {
        ascenders[ 3 ] = spawn_script_model( "misc_wm_ascender", "misc_wm_ascender3" );
    }
    
    self.ascenders = ascenders;
    self.packs = [];
    n = 0;
    self.packs[ n ] = create_animpack( "scene1" );
    self.packs[ n ] add_pack_startfunc( [], &chopperexfil_sh010_start );
    self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh010" ] );
    self.packs[ n ] add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_co_sh010" ] );
    self.packs[ n ] add_pack_modelanim( rope, level.br_anim[ "br_exfil_rope_sh010" ] );
    self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh010" ] );
    self.packs[ n ] add_pack_fx( "chopperExfil_gas", self.origin, self.angles );
    n++;
    self.packs[ n ] = create_animpack( "scene2" );
    self.packs[ n ] add_pack_startfunc( self.winners, &chopperexfil_sh020_start );
    self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh020" ] );
    
    if ( !isdefined( level.scr_notetrack[ "veh8_mil_air_blima_scriptmodel" ] ) || !isdefined( level.scr_notetrack[ "veh8_mil_air_blima_scriptmodel" ][ "any" ][ "guy0_aboard" ] ) )
    {
        addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "guy0_aboard", &chopperexfil_skip_ascend0 );
        addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "guy1_aboard", &chopperexfil_skip_ascend1 );
        addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "guy2_aboard", &chopperexfil_skip_ascend2 );
        addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "slamtoblack", &chopperexfil_slamtoblack );
    }
    
    self.packs[ n ] add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_pilot_sh020" ] );
    self.packs[ n ] add_pack_modelanim( rope, level.br_anim[ "br_exfil_rope_sh020" ] );
    self.packs[ n ] add_pack_modelanim( ascenders[ 0 ], level.br_anim[ "br_exfil_ascender0_sh020" ] );
    
    if ( self.winners.size > 1 )
    {
        self.packs[ n ] add_pack_modelanim( ascenders[ 1 ], level.br_anim[ "br_exfil_ascender1_sh020" ] );
    }
    
    if ( self.winners.size > 2 )
    {
        self.packs[ n ] add_pack_modelanim( ascenders[ 2 ], level.br_anim[ "br_exfil_ascender2_sh020" ] );
    }
    
    if ( self.winners.size > 3 )
    {
        self.packs[ n ] add_pack_modelanim( ascenders[ 3 ], level.br_anim[ "br_exfil_ascender3_sh020" ] );
    }
    
    self.packs[ n ] add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh020" ], level.br_anim[ "br_exfil_guy0_sh020_fem" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh020" ], level.br_anim[ "br_exfil_guy1_sh020_fem" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh020" ], level.br_anim[ "br_exfil_guy2_sh020_fem" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh020" ], level.br_anim[ "br_exfil_guy3_sh020_fem" ] );
    self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh020" ] );
    n++;
    self.packs[ n ] = create_animpack( "scene2.5" );
    self.packs[ n ] add_pack_startfunc( self.winners, &chopperexfil_sh025_start );
    self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh025" ] );
    self.packs[ n ] add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_pilot_sh025" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh025" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh025" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh025" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh025" ] );
    self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh025" ] );
    n++;
    self.packs[ n ] = create_animpack( "scene3" );
    self.packs[ n ] add_pack_startfunc( self.winners, &chopperexfil_sh030_start );
    self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh030" ] );
    self.packs[ n ] add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_pilot_sh030" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh030" ], level.br_anim[ "br_exfil_guy0_sh030_fem" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh030" ], level.br_anim[ "br_exfil_guy1_sh030_fem" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh030" ], level.br_anim[ "br_exfil_guy2_sh030_fem" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh030" ], level.br_anim[ "br_exfil_guy3_sh030_fem" ] );
    self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh030" ] );
    
    if ( self.winners.size >= 2 )
    {
        n++;
        self.packs[ n ] = create_animpack( "scene4" );
        self.packs[ n ] add_pack_startfunc( [ ropeguy ], &chopperexfil_sh040_start );
        self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh040" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh040" ], level.br_anim[ "br_exfil_guy0_sh040_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh040" ], level.br_anim[ "br_exfil_guy1_sh040_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh040" ], level.br_anim[ "br_exfil_guy2_sh040_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh040" ], level.br_anim[ "br_exfil_guy3_sh040_fem" ] );
        self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh040" ] );
    }
    
    if ( self.winners.size >= 3 )
    {
        n++;
        self.packs[ n ] = create_animpack( "scene5" );
        self.packs[ n ] add_pack_startfunc( [], &chopperexfil_sh050_start );
        self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh050" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh050" ], level.br_anim[ "br_exfil_guy0_sh050_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh050" ], level.br_anim[ "br_exfil_guy1_sh050_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh050" ], level.br_anim[ "br_exfil_guy2_sh050_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh050" ], level.br_anim[ "br_exfil_guy3_sh050_fem" ] );
        self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh050" ] );
    }
    
    if ( self.winners.size == 4 )
    {
        n++;
        self.packs[ n ] = create_animpack( "scene6" );
        self.packs[ n ] add_pack_startfunc( [], &chopperexfil_sh060_start );
        self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh060" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh060" ], level.br_anim[ "br_exfil_guy0_sh060_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh060" ], level.br_anim[ "br_exfil_guy1_sh060_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh060" ], level.br_anim[ "br_exfil_guy2_sh060_fem" ] );
        self.packs[ n ] add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh060" ], level.br_anim[ "br_exfil_guy3_sh060_fem" ] );
        self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh060" ] );
    }
    
    n++;
    self.packs[ n ] = create_animpack( "scene7" );
    self.packs[ n ] add_pack_startfunc( [], &chopperexfil_sh070_start );
    self.packs[ n ] add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh070" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh070" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh070" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh070" ] );
    self.packs[ n ] add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh070" ] );
    self.packs[ n ] add_pack_camanim( level.br_anim[ "br_exfil_cam_sh070" ] );
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0
// Checksum 0x0, Offset: 0x1f05
// Size: 0x2e4
function function_a5538b1593309bb0()
{
    var_79a78f73d2d4925d = [];
    guyradius = 30;
    guyheight = 68;
    var_79a78f73d2d4925d = function_3f005b301ec7f15b( var_79a78f73d2d4925d, level.br_anim[ "br_exfil_guy0_sh020" ], 0, undefined, guyradius, guyheight );
    var_79a78f73d2d4925d = function_3f005b301ec7f15b( var_79a78f73d2d4925d, level.br_anim[ "br_exfil_guy1_sh020" ], 0, undefined, guyradius, guyheight );
    var_79a78f73d2d4925d = function_3f005b301ec7f15b( var_79a78f73d2d4925d, level.br_anim[ "br_exfil_guy2_sh020" ], 0, undefined, guyradius, guyheight );
    var_79a78f73d2d4925d = function_3f005b301ec7f15b( var_79a78f73d2d4925d, level.br_anim[ "br_exfil_guy3_sh020" ], 0, undefined, guyradius, guyheight );
    choppermodel = "veh8_mil_air_blima_scriptmodel";
    chopperoriginoffset = ( 0, 0, -70 );
    chopperradius = 350;
    choppersegments = 10;
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh020" ], 0, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh025" ], 0, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh030" ], 0, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh040" ], 0, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh050" ], 0, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh060" ], 0, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh070" ], 0, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_f317a6f0ae25e3d4( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh070" ], 0.99, chopperoriginoffset, chopperradius );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh010" ], chopperoriginoffset, chopperradius, choppersegments );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh020" ], chopperoriginoffset, chopperradius, choppersegments );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh025" ], chopperoriginoffset, chopperradius, choppersegments );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh030" ], chopperoriginoffset, chopperradius, choppersegments );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh040" ], chopperoriginoffset, chopperradius, choppersegments );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh050" ], chopperoriginoffset, chopperradius, choppersegments );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh060" ], chopperoriginoffset, chopperradius, choppersegments );
    var_79a78f73d2d4925d = function_19ae50e23fe0625a( var_79a78f73d2d4925d, choppermodel, level.br_anim[ "br_exfil_blima_sh070" ], chopperoriginoffset, chopperradius, choppersegments );
    return var_79a78f73d2d4925d;
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x21f2
// Size: 0x50
function private chopperexif_fx_init()
{
    level._effect[ "chopperExfil_rotorwash" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx" );
    level._effect[ "chopperExfil_gas" ] = loadfx( "vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_exfil_01.vfx" );
    level._effect[ "player_disconnect" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx" );
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x224a
// Size: 0x8c
function private chopperexfil_introsound( time, var_cbfc3ba10cefc8ce )
{
    endorigin = self.origin + ( 0, 0, 1000 );
    forward = vectornormalize( endorigin - var_cbfc3ba10cefc8ce );
    startorigin = endorigin + forward * 3000;
    temp = spawn( "script_model", startorigin );
    temp playsound( "br_exfil_incoming_heli_lr" );
    temp moveto( endorigin, time );
    wait time;
    temp delete();
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0
// Checksum 0x0, Offset: 0x22de
// Size: 0x12c
function get_chopperexfil_transient()
{
    switch ( level.script )
    {
        case #"hash_d7b993f67c508b1d":
            return "mp_infil_br_donetsk_ending_chopper_tr";
        case #"hash_e9af1c05b2cb1afd":
            return "mp_infil_br_donetsk2_ending_chopper_tr";
        case #"hash_914054ef261f122":
        case #"hash_c9458e4403b73c27":
            return "mp_infil_br_don3_ending_chopper_tr";
        case #"hash_20e8ae1b499051a1":
            return "mp_infil_br_ftue_downtown_ending_chopper_tr";
        case #"hash_5bdc66d44b83f826":
            return "mp_infil_br_quarry_ending_chopper_tr";
        case #"hash_2ad5096943807dfb":
        case #"hash_4aa5d6e97851bdbd":
            return "mp_infil_br_mechanics_ending_chopper_tr";
        case #"hash_2de697274b41ff79":
            return "mp_infil_br_kstenod_ending_chopper_tr";
        case #"hash_4486e35de937847c":
            return "mp_infil_br_escape2_ending_chopper_tr";
        case #"hash_4486e45de937860f":
            return "mp_infil_br_escape2_ending_chopper_tr";
        case #"hash_2ca9e474cad5e079":
            return "mp_infil_br_escape4_ending_chopper_tr";
        case #"hash_57eba45b7ddbdcd6":
        case #"hash_63326ac3e12f8da0":
            return "mp_infil_br_saba_ending_chopper_tr";
        case #"hash_3eff14ec1d9395c1":
        case #"hash_636b409bbce21729":
        case #"hash_e817308cc606e9e1":
            return "mp_infil_br_saba_ending_chopper_tr";
    }
    
    return "";
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0
// Checksum 0x0, Offset: 0x2413
// Size: 0x183
function chopperexfil_music_start()
{
    if ( level.br_ending.winners.size == 0 )
    {
        return;
    }
    
    var_134aea3cdf65b674 = "mus_br_exfil_intro_3player_intro";
    var_4de75e7f916838a0 = "br_exfil_part1_3person_lr";
    
    switch ( level.br_ending.winners.size )
    {
        case 1:
            var_134aea3cdf65b674 = "mus_br_exfil_intro_1player_intro";
            var_4de75e7f916838a0 = "br_exfil_part1_1person_lr";
            break;
        case 2:
            var_134aea3cdf65b674 = "mus_br_exfil_intro_2player_intro";
            var_4de75e7f916838a0 = "br_exfil_part1_2person_lr";
            break;
        case 3:
            var_134aea3cdf65b674 = "mus_br_exfil_intro_3player_intro";
            var_4de75e7f916838a0 = "br_exfil_part1_3person_lr";
            break;
        case 4:
            var_134aea3cdf65b674 = "mus_br_exfil_intro_4player_intro";
            var_4de75e7f916838a0 = "br_exfil_part1_4person_lr";
            break;
    }
    
    foreach ( player in level.players )
    {
        player playlocalsound( var_4de75e7f916838a0 );
        player playlocalsound( var_134aea3cdf65b674 );
    }
    
    waitframe();
    setmusicstate( "" );
    
    foreach ( player in level.players )
    {
        player setsoundsubmix( "mp_br_exfil_fade", 4 );
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x259e
// Size: 0xa8
function private chopperexfil_music_sh025()
{
    if ( level.br_ending.winners.size == 0 )
    {
        return;
    }
    
    musicstate = "br_exfil_main_3player";
    
    switch ( level.br_ending.winners.size )
    {
        case 1:
            musicstate = "br_exfil_main_1player";
            break;
        case 2:
            musicstate = "br_exfil_main_2player";
            break;
        case 3:
            musicstate = "br_exfil_main_3player";
            break;
        case 4:
            musicstate = "br_exfil_main_4player";
            break;
    }
    
    setmusicstate( musicstate );
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x264e
// Size: 0x6a
function private chopperexfil_sfx_before_sh070( waittime )
{
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    foreach ( player in level.players )
    {
        player playlocalsound( "br_exfil_end_part_lr" );
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x26c0
// Size: 0xd5
function private chopperexfil_sh010_start( array )
{
    level.br_ending.exfilchopper thread chopper_playfx();
    thread chopperexfil_music_start();
    
    if ( !scripts\mp\gametypes\br_public::isanytutorialorbotpracticematch() )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        level.br_ending.ropeguy show();
        
        foreach ( player in level.players )
        {
            player.player_rig unlink();
        }
    }
    
    allplayers_setphysicaldof( 2.8, 200 );
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x279d
// Size: 0xf5
function private chopperexfil_sh020_start( players )
{
    allplayers_setphysicaldof( 2.8, 250 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        foreach ( ascender in level.br_ending.ascenders )
        {
            ascender show();
        }
    }
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player setwind( "60", 1 );
        }
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x289a
// Size: 0x35e
function private chopperexfil_sh025_start( players )
{
    allplayers_setphysicaldof( 2.8, 250 );
    thread chopperexfil_music_sh025();
    
    if ( !isdefined( level.br_ending_debugmode ) )
    {
        if ( level.br_ending.winners.size < 4 )
        {
            if ( isdefined( level.br_ending.rope ) )
            {
                level.br_ending.rope delete();
            }
        }
    }
    
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        foreach ( ascender in level.br_ending.ascenders )
        {
            ascender hide();
        }
    }
    else
    {
        foreach ( ascender in level.br_ending.ascenders )
        {
            ascender delete();
        }
    }
    
    tags = [ "tag_guy0", "tag_guy2", "tag_guy4", "tag_guy5" ];
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.winindex ) )
        {
            continue;
        }
        
        player.player_rig linkto( level.br_ending.exfilchopper, tags[ player.winindex ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
        player.linkedtoent = level.br_ending.exfilchopper;
        player.linkedtotag = tags[ player.winindex ];
    }
    
    foreach ( rig in level.br_ending.player_rigs )
    {
        if ( isdefined( rig.player ) )
        {
            continue;
        }
        
        if ( !isdefined( rig.winindex ) )
        {
            continue;
        }
        
        rig linkto( level.br_ending.exfilchopper, tags[ rig.winindex ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
        rig.linkedtoent = level.br_ending.exfilchopper;
        rig.linkedtotag = tags[ rig.winindex ];
    }
    
    chopperexfil_sitting_wind( players );
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2c00
// Size: 0xcb
function private chopperexfil_sh030_start( array )
{
    foreach ( player in level.players )
    {
        player setclienttriggeraudiozone( "br_exfil_heli_int", 0.05 );
    }
    
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
    allplayers_setfov( 45 );
    allplayers_setphysicaldof( 10, 18 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( level.br_ending.winners.size == 1 )
    {
        thread chopperexfil_sfx_before_sh070( 1.266 );
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2cd3
// Size: 0xd1
function private chopperexfil_sh040_start( entarray )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
    allplayers_setfov( 50 );
    allplayers_setphysicaldof( 11, 30 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        foreach ( ent in entarray )
        {
            ent hide();
        }
    }
    else
    {
        delete_entarray( entarray );
    }
    
    if ( level.br_ending.winners.size == 2 )
    {
        thread chopperexfil_sfx_before_sh070( 2.033 );
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2dac
// Size: 0x71
function private chopperexfil_sh050_start( array )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
    allplayers_setfov( 50 );
    allplayers_setphysicaldof( 8, 14.5 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( level.br_ending.winners.size == 3 )
    {
        thread chopperexfil_sfx_before_sh070( 2 );
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e25
// Size: 0x6e
function private chopperexfil_sh060_start( array )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
    allplayers_setfov( 55 );
    allplayers_setphysicaldof( 3, 29 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( level.br_ending.winners.size == 4 )
    {
        thread chopperexfil_sfx_before_sh070( 2.5 );
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e9b
// Size: 0x96
function private chopperexfil_sh070_start( array )
{
    foreach ( player in level.players )
    {
        player clearclienttriggeraudiozone( 0.1 );
    }
    
    allplayers_setfov( 65 );
    allplayers_setphysicaldof( 2.8, 500 );
    level.br_ending.exfilchopper thread chopper_playfx();
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1
// Checksum 0x0, Offset: 0x2f39
// Size: 0x63
function chopperexfil_sitting_wind( players )
{
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player setwind( "30", 1 );
        }
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2fa4
// Size: 0x2c
function private chopperexfil_skip_ascend0( ent )
{
    if ( level.br_ending.winners.size == 1 )
    {
        stop_all_ascend_anims();
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2fd8
// Size: 0x2c
function private chopperexfil_skip_ascend1( ent )
{
    if ( level.br_ending.winners.size == 2 )
    {
        stop_all_ascend_anims();
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x300c
// Size: 0x2c
function private chopperexfil_skip_ascend2( ent )
{
    if ( level.br_ending.winners.size == 3 )
    {
        stop_all_ascend_anims();
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3040
// Size: 0x25
function private chopperexfil_slamtoblack( ent )
{
    if ( !isdefined( level.br_ending_debugmode ) )
    {
        setomnvarforallclients( "ui_world_fade", 1 );
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0
// Checksum 0x0, Offset: 0x306d
// Size: 0x26
function chopper_playfx()
{
    self endon( "death" );
    wait 0.1;
    playfxontag( getfx( "chopperExfil_rotorwash" ), self, "tag_origin" );
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x309b
// Size: 0x77
function private delete_entarray( array )
{
    foreach ( ent in array )
    {
        if ( isdefined( ent.linkedents ) )
        {
            array_delete( ent.linkedents );
        }
        
        ent delete();
    }
}

// Namespace br_ending_chopper / scripts\mp\gametypes\br_ending_chopper
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x311a
// Size: 0x21
function private stop_all_ascend_anims()
{
    level.br_ending.cam notify( "single anim", "end" );
}

