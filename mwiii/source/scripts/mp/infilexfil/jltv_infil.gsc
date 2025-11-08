#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;

#namespace jltv_infil;

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 1
// Checksum 0x0, Offset: 0x70f
// Size: 0x9d
function function_20d96b1495a37dbc( subtype )
{
    scripts\cp_mp\utility\audio_utility::function_f1aed36ab4598ea( "jltv_infil" );
    thread function_55fd55bdea97d9be();
    
    /#
        setdevdvarifuninitialized( @"hash_3dc902e1a71dd25d", 0 );
    #/
    
    initanims( subtype );
    var_453e4fc2c649fea4 = [];
    var_453e4fc2c649fea4[ 0 ] = [ 0 ];
    var_453e4fc2c649fea4[ 1 ] = [ 1 ];
    var_453e4fc2c649fea4[ 2 ] = [ 2, 3, 4, 5 ];
    thread infil_add( "infil_jltv", subtype, 6, 4, var_453e4fc2c649fea4, &jltv_spawn, &function_4a194e1e79f7387, &function_c2028d1fd6c8df8b );
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 4
// Checksum 0x0, Offset: 0x7b4
// Size: 0x8a
function jltv_spawn( team, target, subtype, originalsubtype )
{
    scene_node = getstruct( target, "targetname" );
    infil = spawn( "script_origin", scene_node.origin );
    infil.angles = scene_node.angles;
    infil.scene_node = scene_node;
    infil thread infilthink( team, subtype );
    return infil;
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 1
// Checksum 0x0, Offset: 0x847
// Size: 0x32
function function_4a194e1e79f7387( subtype )
{
    animlength = getanimlength( level.scr_anim[ "slot_0" ][ "jltv_infil" ] );
    return animlength;
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 2
// Checksum 0x0, Offset: 0x882
// Size: 0x29e
function function_c2028d1fd6c8df8b( infil, spot_index )
{
    self endon( "player_free_spot" );
    thread player_infil_end();
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "jup_preinfil_generic", 1 );
    }
    
    thread infil_radio_idle( infil );
    spawnpos = infil.linktoent gettagorigin( "tag_origin_animate" );
    spawnang = infil.linktoent gettagangles( "tag_origin_animate" );
    thread infil_player_rig_updated( "slot_" + spot_index, spawnpos, spawnang );
    self.player_rig linkto( infil.linktoent, "tag_origin_animate" );
    self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe_van" );
    
    if ( isdefined( level.var_e05f516fd742e815 ) )
    {
        self visionsetnakedforplayer( level.var_e05f516fd742e815, 0 );
    }
    else
    {
        self visionsetnakedforplayer( "mp_core_infil", 0 );
    }
    
    self function_451319f93d30ebe5( %"hw_jup_mp_cin" );
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    thread player_disconnect();
    level waittill( "start_scene" );
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "jup_infil_generic" );
    }
    
    thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5( "jup_mp_infil" );
    self lerpfov( 65, 0 );
    self setcinematicmotionoverride( "disabled" );
    self lerpviewangleclamp( 1, 0.25, 0.25, 30, 30, 30, 5 );
    thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958( 1 );
    self lerpfovscalefactor( 0, 0 );
    thread resetfov();
    infil.linktoent anim_player_solo( self, self.player_rig, "jltv_infil", "tag_origin_animate" );
    scripts\mp\class::unblockclasschange();
    
    if ( isdefined( level.scr_viewmodelanim[ self.animname ] ) && isdefined( level.scr_viewmodelanim[ self.animname ][ "jltv_infil" + "_" + infil.subtype + "_intro" ] ) )
    {
        setdvar( @"hash_7eb1641737ab83b7", 0 );
    }
    
    thread clear_infil_ambient_zone();
    
    if ( isdefined( self.player_rig ) && self.player_rig islinked() )
    {
        self.player_rig unlink();
    }
    
    self visionsetnakedforplayer( "", 0.75 );
    self function_df8fad503896462( %"hw_jup_mp_cin" );
    self setdemeanorviewmodel( "normal" );
    self clearcinematicmotionoverride();
    self disablephysicaldepthoffieldscripting();
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0xb28
// Size: 0x27
function resetfov()
{
    level waittill( "infil_countdown_show" );
    wait 2;
    self lerpfovbypreset( "default_2seconds" );
    self lerpfovscalefactor( 1, 2 );
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0xb57
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

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0xb9b
// Size: 0x53
function player_infil_end()
{
    self endon( "disconnect" );
    level waittill( "prematch_over" );
    self notify( "remove_rig" );
    self clearclienttriggeraudiozone( 1 );
    self lerpfovbypreset( "default_2seconds" );
    self lerpfovscalefactor( 1, 2 );
    scripts\mp\utility\player::setdof_default();
    setdvar( @"hash_7eb1641737ab83b7", 0 );
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0xbf6
// Size: 0x4c
function player_disconnect()
{
    level endon( "prematch_over" );
    self waittill( "death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        self visionsetnakedforplayer( "" );
        self clearclienttriggeraudiozone( 0 );
        self lerpfovbypreset( "default" );
        self setviewmodeldepthoffield( 0, 0, 18 );
        scripts\mp\utility\player::setdof_default();
    }
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 4
// Checksum 0x0, Offset: 0xc4a
// Size: 0x8f
function actorthink( team, scene_node, scene_name, extra_crew )
{
    anim_first_frame_solo( self.var_3543ef4125f6f6cb, "jltv_infil" + "_" + scene_name );
    gameflagwait( "infil_started" );
    anim_single_solo( self.var_3543ef4125f6f6cb, "jltv_infil" + "_" + scene_name );
    
    if ( isdefined( self.var_3543ef4125f6f6cb ) )
    {
        self.var_3543ef4125f6f6cb delete();
        self.var_3543ef4125f6f6cb = undefined;
    }
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 2
// Checksum 0x0, Offset: 0xce1
// Size: 0xf5
function infilthink( team, scene_name )
{
    foreach ( ent in getentarray( "infil_delete", "script_noteworthy" ) )
    {
        ent delete();
    }
    
    thread function_738ae64326e0d993();
    thread vehiclethink( team, self.scene_node, scene_name );
    thread actorthink( team, self.scene_node, scene_name );
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

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 4
// Checksum 0x0, Offset: 0xdde
// Size: 0x14d
function vehiclethink( team, scene_node, scene_name, extra_crew )
{
    jltv = function_2fb21394a7c522f4( scene_node, team, scene_name, "veh9_mil_lnd_jltv", "jltv", "veh9_jltv_physics_mp" );
    jltv_decoy = function_7e1450de3ed44e58( scene_node, team, scene_name, "veh9_mil_lnd_jltv", "jltv_decoy", "veh9_jltv_physics_mp" );
    jltv vehicle_turnengineoff();
    self.jltv = jltv;
    self.jltv_decoy = jltv_decoy;
    self.jltv thread function_fea19c0d10ed34e9();
    level waittill( "infil_started" );
    
    if ( !isdefined( self.path ) )
    {
        anim_first_frame_solo( jltv, "jltv_infil" );
        anim_first_frame_solo( jltv_decoy, "jltv_infil" );
    }
    
    thread anim_single_solo( jltv, "jltv_infil" );
    anim_single_solo( jltv_decoy, "jltv_infil" );
    jltv_husk = function_7e1450de3ed44e58( jltv_decoy, team, scene_name, "veh9_mil_lnd_jltv_x_vehphys_hsk_mp", "jltv_husk", "veh9_jltv_physics_mp" );
    jltv_decoy delete();
    jltv_husk setscriptablepartstate( "damage_transition", "on" );
    anim_first_frame_solo( jltv_husk, "jltv_infil" );
    anim_single_solo( jltv_husk, "jltv_infil" );
    level waittill( "prematch_over" );
    thread function_656dd56e607ec3de();
    jltv delete();
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 1
// Checksum 0x0, Offset: 0xf33
// Size: 0x309
function initanims( subtype )
{
    script_model_anims( subtype );
    vehicles_anims( subtype );
    addnotetrack_customfunction( "slot_0", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_1", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_2", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_3", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_4", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_5", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_0", "free_look", &player_free_look, "jltv_infil" );
    addnotetrack_customfunction( "slot_1", "free_look", &player_free_look, "jltv_infil" );
    addnotetrack_customfunction( "slot_2", "free_look", &player_free_look, "jltv_infil" );
    addnotetrack_customfunction( "slot_3", "free_look", &player_free_look, "jltv_infil" );
    addnotetrack_customfunction( "slot_4", "free_look", &player_free_look, "jltv_infil" );
    addnotetrack_customfunction( "slot_5", "free_look", &player_free_look, "jltv_infil" );
    addnotetrack_customfunction( "slot_0", "shake_on", &rumble_low, "jltv_infil" );
    addnotetrack_customfunction( "slot_1", "shake_on", &rumble_low, "jltv_infil" );
    addnotetrack_customfunction( "slot_2", "shake_on", &rumble_low, "jltv_infil" );
    addnotetrack_customfunction( "slot_3", "shake_on", &rumble_low, "jltv_infil" );
    addnotetrack_customfunction( "slot_4", "shake_on", &rumble_low, "jltv_infil" );
    addnotetrack_customfunction( "slot_5", "shake_on", &rumble_low, "jltv_infil" );
    addnotetrack_customfunction( "slot_0", "shake_running", &cam_shake_running, "jltv_infil" );
    addnotetrack_customfunction( "slot_1", "shake_running", &cam_shake_running, "jltv_infil" );
    addnotetrack_customfunction( "slot_2", "shake_running", &cam_shake_running, "jltv_infil" );
    addnotetrack_customfunction( "slot_3", "shake_running", &cam_shake_running, "jltv_infil" );
    addnotetrack_customfunction( "slot_4", "shake_running", &cam_shake_running, "jltv_infil" );
    addnotetrack_customfunction( "slot_5", "shake_running", &cam_shake_running, "jltv_infil" );
    addnotetrack_customfunction( "slot_0", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_1", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_2", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_3", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_4", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_5", "player_lock_look_1_second", &player_lock_look_1_second );
}

#using_animtree( "script_model" );

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 1
// Checksum 0x0, Offset: 0x1244
// Size: 0x45b
function script_model_anims( subtype )
{
    switch ( subtype )
    {
        case #"hash_6829ee5abc10c38b":
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_1;
            level.scr_eventanim[ "slot_0" ][ "jltv_infil" ] = %"infil_jltv_seat_1";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_2;
            level.scr_eventanim[ "slot_1" ][ "jltv_infil" ] = %"infil_jltv_seat_2";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_3;
            level.scr_eventanim[ "slot_2" ][ "jltv_infil" ] = %"infil_jltv_seat_3";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_4;
            level.scr_eventanim[ "slot_3" ][ "jltv_infil" ] = %"infil_jltv_seat_4";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_5;
            level.scr_viewmodelanim[ "slot_4" ][ "jltv_infil" ] = "jup_mp_infil_jltv_seat_5_vm";
            level.scr_eventanim[ "slot_4" ][ "jltv_infil" ] = %"infil_jltv_seat_5";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_6;
            level.scr_viewmodelanim[ "slot_5" ][ "jltv_infil" ] = "jup_mp_infil_jltv_seat_6_vm";
            level.scr_eventanim[ "slot_5" ][ "jltv_infil" ] = %"infil_jltv_seat_6";
        case #"hash_1cc79b02710cab23":
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_1;
            level.scr_eventanim[ "slot_0" ][ "jltv_infil" ] = %"infil_jltv_seat_1";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_2;
            level.scr_eventanim[ "slot_1" ][ "jltv_infil" ] = %"infil_jltv_seat_2";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_3;
            level.scr_eventanim[ "slot_2" ][ "jltv_infil" ] = %"infil_jltv_seat_3";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_4;
            level.scr_eventanim[ "slot_3" ][ "jltv_infil" ] = %"infil_jltv_seat_4";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_5;
            level.scr_viewmodelanim[ "slot_4" ][ "jltv_infil" ] = "jup_mp_infil_jltv_seat_5_vm";
            level.scr_eventanim[ "slot_4" ][ "jltv_infil" ] = %"infil_jltv_seat_5";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "jltv_infil" ] = %jup_mp_infil_jltv_seat_6;
            level.scr_viewmodelanim[ "slot_5" ][ "jltv_infil" ] = "jup_mp_infil_jltv_seat_6_vm";
            level.scr_eventanim[ "slot_5" ][ "jltv_infil" ] = %"infil_jltv_seat_6";
            break;
    }
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 1
// Checksum 0x0, Offset: 0x16a7
// Size: 0xbf
function vehicles_anims( subtype )
{
    switch ( subtype )
    {
        case #"hash_1cc79b02710cab23":
        case #"hash_6829ee5abc10c38b":
            level.scr_animtree[ "jltv" ] = #animtree;
            level.scr_anim[ "jltv" ][ "jltv_infil" ] = %jup_mp_infil_jltv_vehicle_invasion_player;
            level.scr_animtree[ "jltv_decoy" ] = #animtree;
            level.scr_anim[ "jltv_decoy" ][ "jltv_infil" ] = %jup_mp_infil_jltv_vehicle_invasion_ally_intro;
            level.scr_animtree[ "jltv_husk" ] = #animtree;
            level.scr_anim[ "jltv_husk" ][ "jltv_infil" ] = %jup_mp_infil_jltv_vehicle_invasion_ally_outro;
            break;
    }
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 6
// Checksum 0x0, Offset: 0x176e
// Size: 0xdf
function function_2fb21394a7c522f4( scene_node, team, scene_name, model, animname, vehicle )
{
    spawnpos = scene_node.origin;
    spawnang = scene_node.angles;
    
    if ( isdefined( self.path ) )
    {
        spawnpos = self.path.origin;
        spawnang = self.path.angles;
    }
    
    vehicle = spawnvehicle( model, animname, vehicle, spawnpos, spawnang );
    vehicle setvehicleteam( team );
    vehicle vehphys_forcekeyframedmotion();
    vehicle vehicleshowonminimap( 0 );
    vehicle.animname = animname;
    self.linktoent = vehicle;
    vehicle.infil = self;
    return vehicle;
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 6
// Checksum 0x0, Offset: 0x1856
// Size: 0xce
function function_7e1450de3ed44e58( scene_node, team, scene_name, model, animname, vehicle )
{
    spawnpos = scene_node.origin;
    spawnang = scene_node.angles;
    
    if ( isdefined( self.path ) )
    {
        spawnpos = self.path.origin;
        spawnang = self.path.angles;
    }
    
    vehicle = spawn( "script_model", spawnpos );
    vehicle setmodel( model );
    vehicle.angles = spawnang;
    vehicle.animname = animname;
    vehicle setanimtree();
    return vehicle;
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0x192d
// Size: 0x70
function function_738ae64326e0d993()
{
    var_7616751475ec5bb3 = getscriptablearray( "scriptable_veh9_mil_lnd_jltv_infil", "classname" );
    
    foreach ( jltv in var_7616751475ec5bb3 )
    {
        jltv setscriptablepartstate( "visibility", "hide" );
    }
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0x19a5
// Size: 0x89
function function_656dd56e607ec3de()
{
    jltv_husk = getscriptablearray( "jltv_husk", "targetname" );
    var_7616751475ec5bb3 = getscriptablearray( "scriptable_veh9_mil_lnd_jltv_infil", "classname" );
    
    foreach ( jltv in var_7616751475ec5bb3 )
    {
        jltv setscriptablepartstate( "visibility", "show" );
    }
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 1
// Checksum 0x0, Offset: 0x1a36
// Size: 0xde
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
            self playlocalsound( "jup_infil_jltv_preinfil_start" );
            radio_sfx playloopsound( "dx_mpo_ukop_radio_chatter" );
            var_9742aa030e46f6c0 playloopsound( "jup_infil_jltv_preinfil_lp" );
            function_7330aa81e1f66e19( "infil_started", "death_or_disconnect" );
            wait 1;
            radio_sfx stoploopsound( "dx_mpo_ukop_radio_chatter" );
            var_9742aa030e46f6c0 stoploopsound( "jup_infil_jltv_preinfil_lp" );
            radio_sfx delete();
            var_9742aa030e46f6c0 delete();
        }
        
        return;
    }
    
    return;
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 2
// Checksum 0x0, Offset: 0x1b1c
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

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0x1b52
// Size: 0x139
function function_fea19c0d10ed34e9()
{
    var_cf96947048974b14 = spawn( "script_model", ( 0, 0, 0 ) );
    var_274dc4723a42ca1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_41274e89d53b4014 = spawn( "script_model", ( 0, 0, 0 ) );
    level waittill( "infil_started" );
    waitframe();
    var_cf96947048974b14 linkto( self, "tag_origin", ( 100, 0, 30 ), ( 0, 0, 0 ) );
    var_274dc4723a42ca1 linkto( self, "tag_origin", ( 100, 0, 30 ), ( 0, 0, 0 ) );
    var_41274e89d53b4014 linkto( self, "tag_origin", ( -100, 0, 30 ), ( 0, 0, 0 ) );
    waitframe();
    var_cf96947048974b14 playsoundonmovingent( "jup_infil_jltv_vehicle_engine" );
    var_274dc4723a42ca1 playsoundonmovingent( "jup_infil_jltv_vehicle_surface_front" );
    var_41274e89d53b4014 playsoundonmovingent( "jup_infil_jltv_vehicle_surface_rear" );
    wait 7.5;
    var_cf96947048974b14 playsoundonmovingent( "jup_infil_jltv_vehicle_brake_suspension" );
    level waittill( "prematch_over" );
    var_cf96947048974b14 delete();
    var_274dc4723a42ca1 delete();
    var_41274e89d53b4014 delete();
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0x1c93
// Size: 0x19
function function_55fd55bdea97d9be()
{
    level waittill( "prematch_over" );
    wait 51;
    scripts\cp_mp\utility\audio_utility::function_f4e0ff5cb899686d( "jltv_infil" );
}

// Namespace jltv_infil / scripts\mp\infilexfil\jltv_infil
// Params 0
// Checksum 0x0, Offset: 0x1cb4
// Size: 0x31
function function_6158ef142e9bd640()
{
    wait 29;
    
    if ( isdefined( level.var_e05f516fd742e815 ) )
    {
        self visionsetnakedforplayer( "mp_jup_invasion_jltv_infil_2", 3 );
        return;
    }
    
    self visionsetnakedforplayer( "mp_core_infil_2", 3 );
}

