#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;

#namespace defender_infil;

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x798
// Size: 0x9d
function defender_init( subtype )
{
    function_f1aed36ab4598ea( "defender_infil" );
    thread function_ede4acbf2fe2651b();
    
    /#
        setdevdvarifuninitialized( @"hash_3dc902e1a71dd25d", 0 );
    #/
    
    initanims( subtype );
    var_453e4fc2c649fea4 = [];
    var_453e4fc2c649fea4[ 0 ] = [ 0 ];
    var_453e4fc2c649fea4[ 1 ] = [ 1 ];
    var_453e4fc2c649fea4[ 2 ] = [ 2, 3, 4, 5 ];
    thread infil_add( "infil_defender", subtype, 6, 4, var_453e4fc2c649fea4, &defender_spawn, &function_f17139f61f2df6f2, &function_5a3e8cbaff52f088 );
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 4
// Checksum 0x0, Offset: 0x83d
// Size: 0x8a
function defender_spawn( team, target, subtype, originalsubtype )
{
    scene_node = getstruct( target, "targetname" );
    infil = spawn( "script_origin", scene_node.origin );
    infil.angles = scene_node.angles;
    infil.scene_node = scene_node;
    infil thread infilthink( team, subtype );
    return infil;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x8d0
// Size: 0x32
function function_f17139f61f2df6f2( subtype )
{
    animlength = getanimlength( level.scr_anim[ "slot_0" ][ "defender_infil" ] );
    return animlength;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 2
// Checksum 0x0, Offset: 0x90b
// Size: 0x27f
function function_5a3e8cbaff52f088( infil, spot_index )
{
    self endon( "player_free_spot" );
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "jup_preinfil_generic", 1 );
    }
    
    thread infil_radio_idle( infil );
    thread player_infil_end();
    spawnpos = infil.linktoent gettagorigin( "tag_origin_animate" );
    spawnang = infil.linktoent gettagangles( "tag_origin_animate" );
    thread infil_player_rig_updated( "slot_" + spot_index, spawnpos, spawnang );
    self.player_rig linkto( infil.linktoent, "tag_origin_animate" );
    self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe_van" );
    self visionsetnakedforplayer( "mp_core_infil_2", 0 );
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    thread player_disconnect();
    thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958( 0 );
    level waittill( "start_scene" );
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "jup_infil_generic" );
    }
    
    self setcinematicmotionoverride( "disabled" );
    thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5( "jup_mp_infil" );
    self lerpfov( 65, 0 );
    
    if ( isdefined( self.animname ) && !isai( self ) )
    {
        thread function_5f4d9490ce6f6f25();
    }
    
    self lerpfovscalefactor( 0, 0 );
    
    if ( isdefined( level.scr_viewmodelanim[ self.animname ] ) && isdefined( level.scr_viewmodelanim[ self.animname ][ "defender_infil" + "_" + infil.subtype + "_intro" ] ) )
    {
        setdvar( @"hash_7eb1641737ab83b7", 0 );
    }
    
    self lerpviewangleclamp( 1, 0.25, 0.25, 0, 0, 0, 0 );
    thread resetfov();
    infil.linktoent anim_player_solo( self, self.player_rig, "defender_infil", "tag_origin_animate" );
    thread clear_infil_ambient_zone();
    thread scripts\mp\class::unblockclasschange();
    self lerpfovscalefactor( 1, 0.75 );
    
    if ( isdefined( self.player_rig ) && self.player_rig islinked() )
    {
        self.player_rig unlink();
    }
    
    self visionsetnakedforplayer( "", 0.75 );
    self setdemeanorviewmodel( "normal" );
    self clearcinematicmotionoverride();
    self disablephysicaldepthoffieldscripting();
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 0
// Checksum 0x0, Offset: 0xb92
// Size: 0x2c
function resetfov()
{
    level waittill( "infil_countdown_show" );
    wait 2;
    
    if ( isdefined( self ) )
    {
        self lerpfovbypreset( "default_2seconds" );
        self lerpfovscalefactor( 1, 2 );
    }
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 0
// Checksum 0x0, Offset: 0xbc6
// Size: 0x3c
function clear_infil_ambient_zone()
{
    self endon( "disconnect" );
    level waittill( "prematch_over" );
    wait 1;
    
    if ( isdefined( self.submix ) )
    {
        self clearsoundsubmix( self.submix, 2 );
    }
    
    self clearclienttriggeraudiozone( 2 );
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 0
// Checksum 0x0, Offset: 0xc0a
// Size: 0x48
function player_infil_end()
{
    self endon( "disconnect" );
    level waittill( "prematch_over" );
    self notify( "remove_rig" );
    self lerpfovbypreset( "default_2seconds" );
    self clearclienttriggeraudiozone( 1 );
    scripts\mp\utility\player::setdof_default();
    setdvar( @"hash_7eb1641737ab83b7", 0 );
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 0
// Checksum 0x0, Offset: 0xc5a
// Size: 0x4c
function player_disconnect()
{
    level endon( "prematch_over" );
    self waittill( "disconnect" );
    
    if ( isdefined( self ) )
    {
        self visionsetnakedforplayer( "" );
        self clearclienttriggeraudiozone( 0 );
        self lerpfovbypreset( "default" );
        self setviewmodeldepthoffield( 0, 0, 18 );
        scripts\mp\utility\player::setdof_default();
    }
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 2
// Checksum 0x0, Offset: 0xcae
// Size: 0xda
function infilthink( team, scene_name )
{
    foreach ( ent in getentarray( "infil_delete", "script_noteworthy" ) )
    {
        ent delete();
    }
    
    thread vehiclethink( team, self.scene_node, scene_name );
    level waittill( "infil_started" );
    setdvar( @"r_spotlightentityshadows", 1 );
    level notify( "start_scene" );
    level waittill( "prematch_over" );
    setdvar( @"r_spotlightentityshadows", 0 );
    
    while ( isdefined( self.actors ) )
    {
        waitframe();
    }
    
    level.infilsactive--;
    self delete();
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 4
// Checksum 0x0, Offset: 0xd90
// Size: 0xb0
function vehiclethink( team, scene_node, scene_name, extra_crew )
{
    defender = function_90a059c97e2970b7( scene_node, team, scene_name );
    defender vehicle_turnengineoff();
    
    if ( !isdefined( self.path ) )
    {
        anim_first_frame_solo( defender, "defender_infil" );
    }
    
    level waittill( "infil_started" );
    defender playsoundonmovingent( "scn_infil_defender_ext_lr" );
    thread anim_single_solo( defender, "defender_infil" );
    function_4dca5340dfd36c76( scene_node, defender, getanimlength( level.scr_anim[ "defender" ][ "defender_infil" ] ), "defender", "defender_infil" );
    level waittill( "prematch_over" );
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0xe48
// Size: 0x360
function initanims( subtype )
{
    function_487431cf3b99e0b8( subtype );
    function_7b7d0c2db72b128( subtype );
    addnotetrack_customfunction( "slot_0", "free_look", &player_free_look, "defender_infil" );
    addnotetrack_customfunction( "slot_1", "free_look", &player_free_look, "defender_infil" );
    addnotetrack_customfunction( "slot_2", "free_look", &player_free_look, "defender_infil" );
    addnotetrack_customfunction( "slot_3", "free_look", &player_free_look, "defender_infil" );
    addnotetrack_customfunction( "slot_4", "free_look", &player_free_look, "defender_infil" );
    addnotetrack_customfunction( "slot_5", "free_look", &player_free_look, "defender_infil" );
    addnotetrack_customfunction( "slot_0", "shake_on", &rumble_low, "defender_infil" );
    addnotetrack_customfunction( "slot_1", "shake_on", &rumble_low, "defender_infil" );
    addnotetrack_customfunction( "slot_2", "shake_on", &rumble_low, "defender_infil" );
    addnotetrack_customfunction( "slot_3", "shake_on", &rumble_low, "defender_infil" );
    addnotetrack_customfunction( "slot_4", "shake_on", &rumble_low, "defender_infil" );
    addnotetrack_customfunction( "slot_5", "shake_on", &rumble_low, "defender_infil" );
    addnotetrack_customfunction( "slot_0", "shake_running", &cam_shake_running, "defender_infil" );
    addnotetrack_customfunction( "slot_1", "shake_running", &cam_shake_running, "defender_infil" );
    addnotetrack_customfunction( "slot_2", "shake_running", &cam_shake_running, "defender_infil" );
    addnotetrack_customfunction( "slot_3", "shake_running", &cam_shake_running, "defender_infil" );
    addnotetrack_customfunction( "slot_4", "shake_running", &cam_shake_running, "defender_infil" );
    addnotetrack_customfunction( "slot_5", "shake_running", &cam_shake_running, "defender_infil" );
    addnotetrack_customfunction( "slot_0", "fov_63_2", &player_fov_default_1, "defender_infil" );
    addnotetrack_customfunction( "slot_1", "fov_63_2", &player_fov_default_1, "defender_infil" );
    addnotetrack_customfunction( "slot_2", "fov_63_2", &player_fov_default_1, "defender_infil" );
    addnotetrack_customfunction( "slot_3", "fov_63_2", &player_fov_default_1, "defender_infil" );
    addnotetrack_customfunction( "slot_4", "fov_63_2", &player_fov_default_1, "defender_infil" );
    addnotetrack_customfunction( "slot_5", "fov_63_2", &player_fov_default_1, "defender_infil" );
    addnotetrack_customfunction( "slot_0", "scn_infil_defender_npc1", &scn_infil_defender_npc1, "defender_infil" );
    addnotetrack_customfunction( "slot_0", "scn_infil_defender_door", &scn_infil_defender_door, "defender_infil" );
    addnotetrack_customfunction( "slot_1", "scn_infil_defender_npc2", &scn_infil_defender_npc2, "defender_infil" );
    addnotetrack_customfunction( "slot_2", "scn_infil_defender_npc3", &scn_infil_defender_npc3, "defender_infil" );
    addnotetrack_customfunction( "slot_3", "scn_infil_defender_npc4", &scn_infil_defender_npc4, "defender_infil" );
    addnotetrack_customfunction( "slot_4", "scn_infil_defender_npc5", &scn_infil_defender_npc5, "defender_infil" );
    addnotetrack_customfunction( "slot_5", "scn_infil_defender_npc6", &scn_infil_defender_npc6, "defender_infil" );
}

#using_animtree( "script_model" );

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x11b0
// Size: 0x404
function function_487431cf3b99e0b8( subtype )
{
    mapname = scripts\cp_mp\utility\game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_fd8280d21061484a":
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_0_davos;
            level.scr_eventanim[ "slot_0" ][ "defender_infil" ] = %"infil_defender_seat_0_davos";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_1_davos;
            level.scr_eventanim[ "slot_1" ][ "defender_infil" ] = %"infil_defender_seat_1_davos";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_2_davos;
            level.scr_eventanim[ "slot_2" ][ "defender_infil" ] = %"infil_defender_seat_2_davos";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_3_davos;
            level.scr_eventanim[ "slot_3" ][ "defender_infil" ] = %"infil_defender_seat_3_davos";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_4_davos;
            level.scr_eventanim[ "slot_4" ][ "defender_infil" ] = %"infil_defender_seat_4_davos";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_5_davos;
            level.scr_eventanim[ "slot_5" ][ "defender_infil" ] = %"infil_defender_seat_5_davos";
            break;
        default:
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_0;
            level.scr_eventanim[ "slot_0" ][ "defender_infil" ] = %"infil_defender_seat_0";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_1;
            level.scr_eventanim[ "slot_1" ][ "defender_infil" ] = %"infil_defender_seat_1";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_2;
            level.scr_eventanim[ "slot_2" ][ "defender_infil" ] = %"infil_defender_seat_2";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_3;
            level.scr_eventanim[ "slot_3" ][ "defender_infil" ] = %"infil_defender_seat_3";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_4;
            level.scr_eventanim[ "slot_4" ][ "defender_infil" ] = %"infil_defender_seat_4";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "defender_infil" ] = %iw9_mp_infil_defender_seat_5;
            level.scr_eventanim[ "slot_5" ][ "defender_infil" ] = %"infil_defender_seat_5";
            break;
    }
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x15bc
// Size: 0x82
function function_7b7d0c2db72b128( subtype )
{
    mapname = scripts\cp_mp\utility\game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_fd8280d21061484a":
            level.scr_anim[ "defender" ][ "defender_infil" ] = %iw9_mp_infil_defender_vehicle_davos;
            break;
        default:
            level.scr_anim[ "defender" ][ "defender_infil" ] = %iw9_mp_infil_defender_vehicle_museum;
            break;
    }
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 3
// Checksum 0x0, Offset: 0x1646
// Size: 0xea
function function_90a059c97e2970b7( scene_node, team, scene_name )
{
    spawnpos = scene_node.origin;
    spawnang = scene_node.angles;
    
    if ( isdefined( self.path ) )
    {
        spawnpos = self.path.origin;
        spawnang = self.path.angles;
    }
    
    vehicle = spawnvehicle( "veh9_civ_lnd_suv_overland_2016_cage", "defender_infil_suv", "veh9_suv_overland_2016_cage_physics_sp", spawnpos, spawnang );
    vehicle setvehicleteam( team );
    vehicle vehphys_forcekeyframedmotion();
    vehicle vehicleshowonminimap( 0 );
    vehicle hidepart( "TAG_WINDSHIELD_FRONT_WEB" );
    vehicle.animname = "defender";
    self.linktoent = vehicle;
    vehicle.infil = self;
    return vehicle;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x1739
// Size: 0x34
function scn_infil_defender_npc1( guy )
{
    if ( !isdefined( guy.var_8655d6f4c9340db1 ) )
    {
        guy playsoundonmovingent( "scn_infil_defender_npc1" );
    }
    
    guy.var_8655d6f4c9340db1 = 1;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x1775
// Size: 0x34
function scn_infil_defender_npc2( guy )
{
    if ( !isdefined( guy.var_8655d6f4c9340db1 ) )
    {
        guy playsoundonmovingent( "scn_infil_defender_npc2" );
    }
    
    guy.var_8655d6f4c9340db1 = 1;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x17b1
// Size: 0x34
function scn_infil_defender_npc3( guy )
{
    if ( !isdefined( guy.var_8655d6f4c9340db1 ) )
    {
        guy playsoundonmovingent( "scn_infil_defender_npc3" );
    }
    
    guy.var_8655d6f4c9340db1 = 1;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x17ed
// Size: 0x34
function scn_infil_defender_npc4( guy )
{
    if ( !isdefined( guy.var_8655d6f4c9340db1 ) )
    {
        guy playsoundonmovingent( "scn_infil_defender_npc4" );
    }
    
    guy.var_8655d6f4c9340db1 = 1;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x1829
// Size: 0x34
function scn_infil_defender_npc5( guy )
{
    if ( !isdefined( guy.var_8655d6f4c9340db1 ) )
    {
        guy playsoundonmovingent( "scn_infil_defender_npc5" );
    }
    
    guy.var_8655d6f4c9340db1 = 1;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x1865
// Size: 0x34
function scn_infil_defender_npc6( guy )
{
    if ( !isdefined( guy.var_8655d6f4c9340db1 ) )
    {
        guy playsoundonmovingent( "scn_infil_defender_npc6" );
    }
    
    guy.var_8655d6f4c9340db1 = 1;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x18a1
// Size: 0x34
function scn_infil_defender_door( guy )
{
    if ( !isdefined( guy.var_eb404f8fe4e857a5 ) )
    {
        guy playsoundonmovingent( "scn_infil_defender_door" );
    }
    
    guy.var_eb404f8fe4e857a5 = 1;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 1
// Checksum 0x0, Offset: 0x18dd
// Size: 0xd2
function infil_radio_idle( infil )
{
    if ( !flag( "infil_started" ) )
    {
        if ( isplayer( self ) )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            radio_sfx = spawn( "script_origin", ( 0, 0, 0 ) );
            radio_sfx showonlytoplayer( self );
            var_9742aa030e46f6c0 = spawn( "script_origin", ( 0, 0, 0 ) );
            var_9742aa030e46f6c0 showonlytoplayer( self );
            radio_sfx playloopsound( "dx_mpo_ukop_radio_chatter" );
            var_9742aa030e46f6c0 playloopsound( "amb_infil_defender_pre" );
            function_7330aa81e1f66e19( "infil_started", "death_or_disconnect" );
            wait 1;
            radio_sfx stoploopsound( "dx_mpo_ukop_radio_chatter" );
            var_9742aa030e46f6c0 stoploopsound( "amb_infil_defender_pre" );
            var_9742aa030e46f6c0 delete();
            radio_sfx delete();
        }
        
        return;
    }
    
    return;
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 2
// Checksum 0x0, Offset: 0x19b7
// Size: 0x2e
function function_7330aa81e1f66e19( var_8068764aee94f2f4, playerstring )
{
    assert( isdefined( var_8068764aee94f2f4 ) );
    
    if ( isdefined( playerstring ) )
    {
        self endon( playerstring );
    }
    
    gameflagwait( var_8068764aee94f2f4 );
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 0
// Checksum 0x0, Offset: 0x19ed
// Size: 0x19
function function_ede4acbf2fe2651b()
{
    level waittill( "prematch_over" );
    wait 51;
    function_f4e0ff5cb899686d( "defender_infil" );
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 0
// Checksum 0x0, Offset: 0x1a0e
// Size: 0x5b
function function_5f4d9490ce6f6f25()
{
    self endon( "disconnect" );
    waitframe();
    self playlocalsound( "amb_infil_defender_lr" );
    
    if ( level.mapname == "mp_jup_estate" )
    {
        self playlocalsound( "amb_infil_defender_skid_dirt" );
        return;
    }
    
    wait 2.5;
    self playlocalsound( "amb_infil_defender_skid_asphalt_01" );
    wait 4.4;
    self playlocalsound( "amb_infil_defender_skid_asphalt_02" );
}

// Namespace defender_infil / scripts\mp\infilexfil\defender_infil
// Params 0
// Checksum 0x0, Offset: 0x1a72
// Size: 0x13
function function_6158ef142e9bd640()
{
    wait 29;
    self visionsetnakedforplayer( "mp_core_infil_2", 3 );
}

