#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;

#namespace mi8_infil;

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 1
// Checksum 0x0, Offset: 0xa48
// Size: 0xcb
function mi8_init( subtype )
{
    scripts\cp_mp\utility\audio_utility::function_f1aed36ab4598ea( "mi8_infil" );
    thread function_247774c600595ace();
    
    /#
        setdevdvarifuninitialized( @"hash_3dc902e1a71dd25d", 0 );
    #/
    
    var_453e4fc2c649fea4 = [];
    var_453e4fc2c649fea4[ 0 ] = [ 11, 10 ];
    var_453e4fc2c649fea4[ 1 ] = [ 9, 8 ];
    var_453e4fc2c649fea4[ 2 ] = [ 7, 6 ];
    var_453e4fc2c649fea4[ 3 ] = [ 5, 4 ];
    var_453e4fc2c649fea4[ 4 ] = [ 3, 2 ];
    var_453e4fc2c649fea4[ 5 ] = [ 1, 0 ];
    thread infil_add( "infil_mi8", subtype, 12, 4, var_453e4fc2c649fea4, &mi8_spawn, &mi8_get_length, &player_mi8_infil_think );
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 4
// Checksum 0x0, Offset: 0xb1b
// Size: 0xb9
function mi8_spawn( team, target, subtype, originalsubtype )
{
    initanims( subtype, team, originalsubtype );
    scene_node = getstruct( target, "targetname" );
    postlaunchscenenodecorrection( scene_node, team, subtype, originalsubtype );
    infil = spawn( "script_origin", scene_node.origin );
    infil.angles = scene_node.angles;
    infil.scene_node = scene_node;
    infil.subtype = subtype;
    infil.originalsubtype = originalsubtype;
    infil thread infilthink( team, subtype );
    return infil;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0xbdd
// Size: 0xb2
function printdata( infil, subtype, originalsubtype )
{
    org = infil.scene_node.origin;
    ang = infil.scene_node.angles;
    
    while ( true )
    {
        /#
            print3d( org, "<dev string:x1c>" + subtype + "<dev string:x24>" + originalsubtype + "<dev string:x2a>", ( 1, 1, 1 ), 1, 2 );
        #/
        
        thread scripts\cp_mp\utility\debug_utility::drawangles( org, ang, level.framedurationseconds, 1 );
        waitframe();
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 4
// Checksum 0x0, Offset: 0xc97
// Size: 0x281
function postlaunchscenenodecorrection( scene_node, team, subtype, originalsubtype )
{
    mapname = scripts\cp_mp\utility\game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_32eaa112f8caa7e4":
            switch ( originalsubtype )
            {
                case #"hash_6829ee5abc10c38b":
                    if ( team == "axis" )
                    {
                        scene_node.angles += ( 0, 8, 0 );
                    }
                    else
                    {
                        scene_node.angles += ( 0, 23, 0 );
                        scene_node.origin += anglestoforward( scene_node.angles ) * 100;
                    }
                    
                    break;
                case #"hash_ac5f2d60e641dce":
                    if ( team == "axis" )
                    {
                        scene_node.angles += ( 0, -8, 0 );
                    }
                    else
                    {
                        scene_node.angles += ( 0, -3, 0 );
                    }
                    
                    break;
                case #"hash_ac5f1d60e641c3b":
                    if ( team == "axis" )
                    {
                        scene_node.angles += ( 0, -3, 0 );
                        scene_node.origin += anglestoforward( scene_node.angles ) * 200;
                    }
                    else
                    {
                        scene_node.angles += ( 0, 12, 0 );
                    }
                    
                    break;
            }
            
            break;
        case #"hash_50de71be6e7469ff":
            switch ( originalsubtype )
            {
                case #"hash_1cc79b02710cab23":
                    if ( team == "allies" )
                    {
                        scene_node.origin -= ( 0, 0, 86 );
                    }
                    
                    break;
            }
        case #"hash_1bc93b88575e82eb":
            switch ( originalsubtype )
            {
                case #"hash_6829ee5abc10c38b":
                    if ( team == "allies" )
                    {
                        scene_node.angles -= ( 0, 30, 0 );
                    }
                    
                    break;
            }
            
            break;
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 1
// Checksum 0x0, Offset: 0xf20
// Size: 0x32
function mi8_get_length( subtype )
{
    animlength = getanimlength( level.scr_anim[ "slot_0" ][ "mi8_infil" ] );
    return animlength;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 1
// Checksum 0x0, Offset: 0xf5b
// Size: 0x20
function function_901b254bea1ab19f( infil )
{
    return infil.scene_node.origin;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 2
// Checksum 0x0, Offset: 0xf84
// Size: 0x20c
function player_mi8_infil_think( infil, spot_index )
{
    self endon( "player_free_spot" );
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "jup_preinfil_generic", 1 );
    }
    
    thread infil_radio_idle( infil );
    thread player_infil_end();
    self setadditionalstreamposuntilcleared( function_901b254bea1ab19f( infil ) );
    spawnpos = infil.origin;
    spawnang = infil.angles;
    thread infil_player_rig_updated( "slot_" + spot_index, spawnpos, spawnang );
    self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe_heli" );
    
    if ( isdefined( level.var_17c3d95c013a7e67 ) )
    {
        self.currentvisionset = level.var_17c3d95c013a7e67;
    }
    else
    {
        self.currentvisionset = "mp_core_infil";
    }
    
    self visionsetnakedforplayer( self.currentvisionset );
    self lerpfovbypreset( "80_instant" );
    self lerpfovscalefactor( 0, 0 );
    self.player_rig linkto( infil );
    infil anim_first_frame_solo( self.player_rig, "mi8_infil" );
    thread player_disconnect();
    gameflagwait( "infil_started" );
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "jup_infil_generic" );
    }
    
    thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5( "jup_mp_infil" );
    self playlocalsound( "jup_infil_mi8_heli_int_lr" );
    self setcinematicmotionoverride( "disabled" );
    self lerpviewangleclamp( 1, 0.25, 0.25, 60, 60, 30, 30 );
    thread clear_infil_ambient_zone();
    infil anim_player_solo( self, self.player_rig, "mi8_infil" );
    
    if ( isdefined( self.player_rig ) && self.player_rig islinked() )
    {
        self.player_rig unlink();
    }
    
    self lerpfovscalefactor( 1, 2 );
    self visionsetnakedforplayer( "", 0.75 );
    self setdemeanorviewmodel( "normal" );
    self clearcinematicmotionoverride();
    self disablephysicaldepthoffieldscripting();
    self clearadditionalstreampos();
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 0
// Checksum 0x0, Offset: 0x1198
// Size: 0x34
function clear_infil_ambient_zone()
{
    self endon( "death_or_disconnect" );
    wait 4;
    
    if ( isdefined( self.submix ) )
    {
        self clearsoundsubmix( self.submix, 2 );
    }
    
    self clearclienttriggeraudiozone( 2 );
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 0
// Checksum 0x0, Offset: 0x11d4
// Size: 0x38
function player_infil_end()
{
    self endon( "disconnect" );
    level waittill( "prematch_over" );
    self notify( "remove_rig" );
    self clearclienttriggeraudiozone( 1 );
    scripts\mp\utility\player::setdof_default();
    self clearclienttriggeraudiozone( 1 );
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 1
// Checksum 0x0, Offset: 0x1214
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
            var_9742aa030e46f6c0 playloopsound( "jup_infil_mi8_heli_prestart" );
            function_7330aa81e1f66e19( "infil_started", "death_or_disconnect" );
            wait 1;
            radio_sfx stoploopsound( "dx_mpo_ukop_radio_chatter" );
            var_9742aa030e46f6c0 stoploopsound( "jup_infil_mi8_heli_prestart" );
            var_9742aa030e46f6c0 delete();
            radio_sfx delete();
        }
        
        return;
    }
    
    return;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 2
// Checksum 0x0, Offset: 0x12ee
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

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 0
// Checksum 0x0, Offset: 0x1324
// Size: 0x53
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
        self clearadditionalstreampos();
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x137f
// Size: 0x15c
function spawnactors( team, scene_name, extra_crew )
{
    if ( !isdefined( self.actors ) )
    {
        self.actors = [];
    }
    
    commanderassets = getcommanderassets( team );
    self.actors[ self.actors.size ] = self.linktoent spawn_anim_model( "commander", "tag_origin", commanderassets.body, commanderassets.head );
    self.actors[ self.actors.size ] = self.linktoent spawn_anim_model( "driver", "tag_origin", commanderassets.body, commanderassets.head );
    
    foreach ( actor in self.actors )
    {
        actor.infil = self;
    }
    
    self.actors[ 0 ].anim_playsound_func = &commander_play_sound_func;
    self.actors[ 1 ].anim_playsound_func = &driver_play_sound_func;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x14e3
// Size: 0x7a
function blima_chief_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.blima.players )
    {
        player playsoundtoplayer( alias, player );
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 2
// Checksum 0x0, Offset: 0x1565
// Size: 0x12d
function infilthink( team, scene_name )
{
    var_e026a614f7467557 = getdvarfloat( @"hash_ea4c44a08cd23d5d", 0.2 );
    
    foreach ( ent in getentarray( "infil_delete", "script_noteworthy" ) )
    {
        ent delete();
    }
    
    thread vehiclethink( team, self.scene_node, scene_name );
    gameflagwait( "infil_started" );
    setdvar( @"r_spotlightentityshadows", 1 );
    setdvar( @"hash_ea4c44a08cd23d5d", 1 );
    level notify( "start_scene" );
    level waittill( "prematch_over" );
    setdvar( @"r_spotlightentityshadows", 0 );
    setdvar( @"hash_ea4c44a08cd23d5d", var_e026a614f7467557 );
    
    while ( isdefined( self.linktoent ) || isdefined( self.actors ) )
    {
        waitframe();
    }
    
    level.infilsactive--;
    self delete();
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 4
// Checksum 0x0, Offset: 0x169a
// Size: 0x175
function vehiclethink( team, scene_node, scene_name, extra_crew )
{
    self.linktoent = spawninfilvehicle( scene_node, team, scene_name );
    
    if ( self.originalsubtype != self.subtype && ( getdvar( @"g_mapname" ) == "mp_downtown_gw" || getdvar( @"g_mapname" ) == "mp_port2_gw" ) )
    {
        scene_name = self.originalsubtype;
    }
    
    anim_first_frame_solo( self.linktoent, "mi8_infil_" + scene_name + "_" + team );
    self.linktoent thread function_3a4301c7ea8a3b7f();
    gameflagwait( "infil_started" );
    self.linktoent playsoundonmovingent( "jup_infil_mi8_heli_ext" );
    self.linktoent setscriptablepartstate( "blinking_light", "red", 0 );
    self.linktoent setscriptablepartstate( "infil_lights", "on", 0 );
    thread anim_single_solo( self.linktoent, "mi8_infil_" + scene_name + "_" + team );
    animlength = getanimlength( level.scr_anim[ "mi8" ][ "mi8_infil_" + scene_name + "_" + team ] );
    wait animlength;
    self.linktoent delete();
    self.linktoent = undefined;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 0
// Checksum 0x0, Offset: 0x1817
// Size: 0x6f
function function_3a4301c7ea8a3b7f()
{
    var_3a4301c7ea8a3b7f = spawn( "script_model", self.origin );
    var_3a4301c7ea8a3b7f linkto( self, "tag_origin", ( 0, 0, 15 ), ( 0, 0, 0 ) );
    gameflagwait( "infil_started" );
    var_3a4301c7ea8a3b7f playsoundonmovingent( "jup_infil_mi8_heli_land" );
    level waittill( "prematch_over" );
    var_3a4301c7ea8a3b7f delete();
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 4
// Checksum 0x0, Offset: 0x188e
// Size: 0x14d
function actorthink( team, scene_node, scene_name, extra_crew )
{
    thread spawnactors( team, scene_name, extra_crew );
    self.linktoent anim_first_frame( self.actors, "mi8_infil_" + scene_name, "tag_origin" );
    gameflagwait( "infil_started" );
    self.linktoent thread anim_single( self.actors, "mi8_infil_" + scene_name, "tag_origin" );
    self.actors[ 0 ].head scriptmodelplayanim( level.scr_anim[ self.actors[ 0 ].animname ][ "mi8_infil_" + scene_name ] );
    duration = getanimlength( level.scr_anim[ "commander" ][ "mi8_infil_" + scene_name ] );
    wait duration;
    
    foreach ( actor in self.actors )
    {
        actor delete();
    }
    
    self.actors = undefined;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 5
// Checksum 0x0, Offset: 0x19e3
// Size: 0x245
function spawn_anim_model( animname, linkto_ent, body, head, weapon )
{
    male = 1;
    
    if ( cointoss() )
    {
        male = 0;
    }
    
    if ( body == "random" )
    {
        if ( male )
        {
            index = randomint( 3 );
            
            if ( index == 0 )
            {
                body = "c_civ_pic_male_2_brown";
            }
            else if ( index == 1 )
            {
                body = "body_opforce_london_civ_1_1";
            }
            else if ( index == 2 )
            {
                body = "civ_london_male_2_5";
            }
        }
        else if ( cointoss() )
        {
            body = "civ_london_female_1_4";
        }
        else
        {
            body = "c_civ_pic_female_5_6";
        }
    }
    
    guy = spawn( "script_model", ( 0, 0, 0 ) );
    guy setmodel( body );
    
    if ( isdefined( head ) )
    {
        if ( head == "random" )
        {
            if ( male )
            {
                if ( cointoss() )
                {
                    head = "head_bg_var_head_bg_male_09_head_sc_male_14";
                }
                else
                {
                    head = "head_bg_var_head_male_bc_01_head_hero_gator";
                }
            }
            else if ( cointoss() )
            {
                head = "head_bg_var_head_female_bc_01_head_sc_female_10";
            }
            else
            {
                head = "head_bg_var_head_sc_female_04_head_female_bc_02";
            }
        }
        
        guy_head = spawn( "script_model", ( 0, 0, 0 ) );
        guy_head setmodel( head );
        guy_head linkto( guy, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        guy.head = guy_head;
        guy thread delete_on_death( guy_head );
    }
    
    if ( isdefined( weapon ) )
    {
        guy_weapon = spawn( "script_model", ( 0, 0, 0 ) );
        guy_weapon setmodel( weapon );
        guy_weapon linkto( guy, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        guy thread delete_on_death( guy_weapon );
        guy.weapon = guy_weapon;
    }
    
    guy.animname = animname;
    guy setanimtree();
    
    if ( isdefined( linkto_ent ) )
    {
        thread delete_on_death( guy );
        guy linkto( self, linkto_ent, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    return guy;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x1c31
// Size: 0x789
function initanims( subtype, team, originalsubtype )
{
    script_model_alpha_anims( subtype );
    vehicles_alpha_anims( subtype, team, originalsubtype );
    addnotetrack_customfunction( "slot_0", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_1", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_2", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_3", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_4", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_5", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_6", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_7", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_8", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_9", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_10", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_11", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_0", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_1", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_2", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_3", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_4", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_5", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_6", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_7", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_8", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_9", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_10", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_11", "shake_running", &cam_shake_running, "mi8_infil" );
    addnotetrack_customfunction( "slot_0", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_1", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_2", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_3", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_4", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_5", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_6", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_7", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_8", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_9", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_10", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_11", "shake_off", &customground, "mi8_infil" );
    addnotetrack_customfunction( "slot_0", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_1", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_2", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_3", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_4", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_5", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_6", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_7", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_8", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_9", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_10", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_11", "equip_nvg", &player_equip_nvg, "mi8_infil" );
    addnotetrack_customfunction( "slot_0", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_1", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_2", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_3", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_4", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_5", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_6", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_7", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_8", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_9", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_10", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_11", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil" );
    addnotetrack_customfunction( "slot_0", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_1", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_2", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_3", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_4", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_5", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_6", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_7", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_8", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_9", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_10", "free_look", &player_free_look, "mi8_infil" );
    addnotetrack_customfunction( "slot_11", "free_look", &player_free_look, "mi8_infil" );
}

#using_animtree( "script_model" );

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 1
// Checksum 0x0, Offset: 0x23c2
// Size: 0x3cb
function script_model_alpha_anims( subtype )
{
    level.scr_animtree[ "slot_0" ] = #animtree;
    level.scr_anim[ "slot_0" ][ "mi8_infil" ] = %mp_infil_mi8_guyl_01;
    level.scr_eventanim[ "slot_0" ][ "mi8_infil" ] = %"hash_37ebccc46f9dcb6f";
    level.scr_animtree[ "slot_1" ] = #animtree;
    level.scr_anim[ "slot_1" ][ "mi8_infil" ] = %mp_infil_mi8_guyl_02;
    level.scr_eventanim[ "slot_1" ][ "mi8_infil" ] = %"hash_37ebcdc46f9dcd22";
    level.scr_animtree[ "slot_2" ] = #animtree;
    level.scr_anim[ "slot_2" ][ "mi8_infil" ] = %mp_infil_mi8_guyl_03;
    level.scr_eventanim[ "slot_2" ][ "mi8_infil" ] = %"hash_37ebcec46f9dced5";
    level.scr_animtree[ "slot_3" ] = #animtree;
    level.scr_anim[ "slot_3" ][ "mi8_infil" ] = %mp_infil_mi8_guyl_04;
    level.scr_eventanim[ "slot_3" ][ "mi8_infil" ] = %"hash_37ebc7c46f9dc2f0";
    level.scr_animtree[ "slot_4" ] = #animtree;
    level.scr_anim[ "slot_4" ][ "mi8_infil" ] = %mp_infil_mi8_guyl_05;
    level.scr_eventanim[ "slot_4" ][ "mi8_infil" ] = %"hash_37ebc8c46f9dc4a3";
    level.scr_animtree[ "slot_5" ] = #animtree;
    level.scr_anim[ "slot_5" ][ "mi8_infil" ] = %mp_infil_mi8_guyl_06;
    level.scr_eventanim[ "slot_5" ][ "mi8_infil" ] = %"hash_37ebc9c46f9dc656";
    level.scr_animtree[ "slot_6" ] = #animtree;
    level.scr_anim[ "slot_6" ][ "mi8_infil" ] = %mp_infil_mi8_guyr_01;
    level.scr_eventanim[ "slot_6" ][ "mi8_infil" ] = %"hash_1c6f6126013decf8";
    level.scr_animtree[ "slot_7" ] = #animtree;
    level.scr_anim[ "slot_7" ][ "mi8_infil" ] = %mp_infil_mi8_guyr_02;
    level.scr_eventanim[ "slot_7" ][ "mi8_infil" ] = %"hash_1c6f6426013df211";
    level.scr_animtree[ "slot_8" ] = #animtree;
    level.scr_anim[ "slot_8" ][ "mi8_infil" ] = %mp_infil_mi8_guyr_03;
    level.scr_eventanim[ "slot_8" ][ "mi8_infil" ] = %"hash_1c6f6326013df05e";
    level.scr_animtree[ "slot_9" ] = #animtree;
    level.scr_anim[ "slot_9" ][ "mi8_infil" ] = %mp_infil_mi8_guyr_04;
    level.scr_eventanim[ "slot_9" ][ "mi8_infil" ] = %"hash_1c6f6626013df577";
    level.scr_animtree[ "slot_10" ] = #animtree;
    level.scr_anim[ "slot_10" ][ "mi8_infil" ] = %mp_infil_mi8_guyr_05;
    level.scr_eventanim[ "slot_10" ][ "mi8_infil" ] = %"hash_1c6f6526013df3c4";
    level.scr_animtree[ "slot_11" ] = #animtree;
    level.scr_anim[ "slot_11" ][ "mi8_infil" ] = %mp_infil_mi8_guyr_06;
    level.scr_eventanim[ "slot_11" ][ "mi8_infil" ] = %"hash_1c6f6826013df8dd";
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x2795
// Size: 0x50e
function vehicles_alpha_anims( subtype, team, originalsubtype )
{
    mapname = getdvar( @"g_mapname" );
    
    if ( isdefined( originalsubtype ) && subtype != originalsubtype && ( mapname == "mp_downtown_gw" || mapname == "mp_port2_gw" ) )
    {
        switch ( originalsubtype )
        {
            case #"hash_ac5f2d60e641dce":
                if ( team == "axis" )
                {
                    if ( mapname == "mp_downtown_gw" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + originalsubtype + "_" + team ] = %mp_infil_mi8_a1_heli_downtown_east;
                    }
                    
                    if ( mapname == "mp_port2_gw" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + originalsubtype + "_" + team ] = %mp_infil_mi8_a1_heli_port_east;
                    }
                }
                else
                {
                    if ( mapname == "mp_downtown_gw" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + originalsubtype + "_" + team ] = %mp_infil_mi8_a1_heli_downtown_west;
                    }
                    
                    if ( mapname == "mp_port2_gw" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + originalsubtype + "_" + team ] = %mp_infil_mi8_a1_heli_port_west;
                    }
                }
                
                break;
            case #"hash_ac5f1d60e641c3b":
                if ( team == "axis" )
                {
                    level.scr_anim[ "mi8" ][ "mi8_infil_" + originalsubtype + "_" + team ] = %mp_infil_mi8_a2_heli_downtown_east;
                }
                else
                {
                    level.scr_anim[ "mi8" ][ "mi8_infil_" + originalsubtype + "_" + team ] = %mp_infil_mi8_a2_heli_downtown_west;
                }
                
                break;
        }
        
        return;
    }
    
    switch ( subtype )
    {
        case #"hash_6829ee5abc10c38b":
            level.scr_animtree[ "mi8" ] = #animtree;
            
            switch ( getdvar( @"g_mapname" ) )
            {
                case #"hash_32eaa112f8caa7e4":
                    if ( team == "axis" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_a_heli_downtown_east;
                    }
                    else
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_a_heli_downtown_west;
                    }
                    
                    break;
                case #"hash_50de71be6e7469ff":
                case #"hash_7a28db3c5928c489":
                    if ( team == "axis" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_a_heli_quarry_east;
                    }
                    else
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_a_heli_quarry_east;
                    }
                    
                    break;
                case #"hash_12f3765ef24b4037":
                    if ( team == "axis" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_a_heli_port_east;
                    }
                    else
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_a_heli_port_west;
                    }
                    
                    break;
                default:
                    level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_heli;
                    break;
            }
            
            break;
        case #"hash_1cc79b02710cab23":
            level.scr_animtree[ "mi8" ] = #animtree;
            
            switch ( getdvar( @"g_mapname" ) )
            {
                case #"hash_50de71be6e7469ff":
                case #"hash_7a28db3c5928c489":
                    if ( team == "axis" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_b_heli_quarry_east;
                    }
                    else
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_b_heli_quarry_east;
                    }
                    
                    break;
                case #"hash_12f3765ef24b4037":
                    if ( team == "axis" )
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_b_heli_port_east;
                    }
                    else
                    {
                        level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_b_heli_port_west;
                    }
                    
                    break;
                default:
                    level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype + "_" + team ] = %mp_infil_mi8_heli;
                    break;
            }
            
            break;
        default:
            level.scr_anim[ "mi8" ][ "mi8_infil_" + subtype ] = %mp_infil_mi8_heli;
            break;
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x2cab
// Size: 0xb5
function spawninfilvehicle( scene_node, team, scene_name )
{
    spawnpos = scene_node.origin;
    spawnang = scene_node.angles;
    model = "veh8_mil_air_mindia8_infil_x";
    
    if ( team == "allies" )
    {
        model = "veh8_mil_air_mindia8_west_infil_x";
    }
    
    vehicle = spawnvehicle( model, scene_name, "mi8_infil_mp", spawnpos, spawnang );
    vehicle setvehicleteam( team );
    vehicle.animname = "mi8";
    vehicle setcandamage( 0 );
    vehicle notsolid();
    vehicle.infil = self;
    return vehicle;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x2d69
// Size: 0x83
function commander_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.infil.players )
    {
        if ( soundexists( alias ) )
        {
            self playsoundtoplayer( alias, player );
        }
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x2df4
// Size: 0x7a
function driver_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.infil.players )
    {
        self playsoundtoplayer( alias, player );
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 1
// Checksum 0x0, Offset: 0x2e76
// Size: 0x3f
function getcommanderassets( team )
{
    data = spawnstruct();
    data.body = "body_mp_eastern_fireteam_east_sg_no_sling";
    data.head = "head_mp_eastern_fireteam_east_ar_4";
    return data;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 1
// Checksum 0x0, Offset: 0x2ebe
// Size: 0x45
function customground( guy )
{
    cam_shake_off( guy );
    
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
        return;
    }
    
    player = guy;
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 3
// Checksum 0x0, Offset: 0x2f0b
// Size: 0x109
function modifyscenenode( infil, team, subtype )
{
    switch ( level.mapname )
    {
        case #"hash_7a28db3c5928c489":
            switch ( team )
            {
                case #"hash_5f54b9bf7583687f":
                    switch ( subtype )
                    {
                        case #"hash_6829ee5abc10c38b":
                            break;
                        case #"hash_1cc79b02710cab23":
                            infil.origin += anglestoforward( infil.angles ) * 200;
                            break;
                    }
                    
                    break;
                case #"hash_7c2d091e6337bf54":
                    switch ( subtype )
                    {
                        case #"hash_6829ee5abc10c38b":
                            break;
                        case #"hash_1cc79b02710cab23":
                            infil.origin += anglestoup( infil.angles ) * 281.907;
                            break;
                    }
                    
                    break;
            }
            
            break;
    }
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 0
// Checksum 0x0, Offset: 0x301c
// Size: 0x19
function function_247774c600595ace()
{
    level waittill( "prematch_over" );
    wait 55;
    scripts\cp_mp\utility\audio_utility::function_f4e0ff5cb899686d( "mi8_infil" );
}

// Namespace mi8_infil / scripts\mp\infilexfil\mi8_infil
// Params 0
// Checksum 0x0, Offset: 0x303d
// Size: 0x13
function function_6158ef142e9bd640()
{
    wait 20;
    self visionsetnakedforplayer( "mp_core_infil_2", 3 );
}

