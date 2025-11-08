#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;

#namespace van_hackney_infil;

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0xc3a
// Size: 0x9f
function van_hackney_init( subtype )
{
    scripts\engine\utility::registersharedfunc( "infil", "spawnPersistentVan", &spawnpersistentvehicle );
    
    /#
        setdevdvarifuninitialized( @"hash_3dc902e1a71dd25d", 0 );
    #/
    
    initanims( subtype );
    var_453e4fc2c649fea4 = [];
    var_453e4fc2c649fea4[ 0 ] = [ 5, 4 ];
    var_453e4fc2c649fea4[ 1 ] = [ 3, 2 ];
    var_453e4fc2c649fea4[ 2 ] = [ 1, 0 ];
    thread infil_add( "infil_van_hackney", subtype, 6, 4, var_453e4fc2c649fea4, &van_hackney_spawn, &van_hackney_get_length, &player_van_hackney_infil_think );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 4
// Checksum 0x0, Offset: 0xce1
// Size: 0x95
function van_hackney_spawn( team, target, subtype, originalsubtype )
{
    scene_node = getstruct( target, "targetname" );
    postlaunchscenenodecorrection( scene_node, team, subtype, originalsubtype );
    infil = spawn( "script_origin", scene_node.origin );
    infil.angles = scene_node.angles;
    infil.scene_node = scene_node;
    infil thread infilthink( team, subtype );
    return infil;
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 4
// Checksum 0x0, Offset: 0xd7f
// Size: 0xd5
function postlaunchscenenodecorrection( scene_node, team, subtype, originalsubtype )
{
    mapname = scripts\cp_mp\utility\game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_9c2fdccb75b37f7e":
            scene_node.origin += anglestoforward( scene_node.angles ) * -50;
            clipent = getentarrayinradius( "script_brushmodel", "classname", ( 1250, -2150, 75 ), 300 );
            
            if ( isdefined( clipent ) )
            {
                clipent[ 0 ].origin += anglestoforward( scene_node.angles ) * -50;
            }
            
            break;
    }
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0xe5c
// Size: 0x56
function van_hackney_get_length( subtype )
{
    animlength = 0;
    
    if ( istrue( level.interactiveinfil ) )
    {
        animlength = level.interactivecombatduration;
    }
    else
    {
        animlength = getanimlength( level.scr_anim[ "slot_0" ][ "van_hackney_infil_" + subtype ] );
    }
    
    return animlength;
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 2
// Checksum 0x0, Offset: 0xebb
// Size: 0x3c3
function player_van_hackney_infil_think( infil, spot_index )
{
    self endon( "player_free_spot" );
    thread van_infil_radio_idle( infil );
    thread player_infil_end();
    spawnpos = infil.linktoent gettagorigin( "tag_origin" );
    spawnang = infil.linktoent gettagangles( "tag_origin" );
    thread infil_player_rig_updated( "slot_" + spot_index, spawnpos, spawnang );
    self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe_van" );
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    
    if ( spot_index == 0 )
    {
        self lerpfovbypreset( "80_instant" );
    }
    
    self.player_rig linkto( infil.linktoent, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    infil.linktoent anim_first_frame_solo( self.player_rig, "van_hackney_infil_" + infil.subtype );
    thread player_van_disconnect();
    gameflagwait( "infil_started" );
    thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5();
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "hackney_infil_van", 0.1 );
        self playlocalsound( "scn_mp_hackney_van_lr" );
    }
    
    if ( isdefined( self.animname ) && isplayer( self ) )
    {
        soundalias = "scn_infil_hackney_van_plr1";
        
        if ( isdefined( infil.subtype ) )
        {
            if ( infil.subtype == "alpha" )
            {
                switch ( self.animname )
                {
                    case #"hash_9f02a28a98823bce":
                        soundalias = "scn_infil_hackney_van_plr3";
                        break;
                    case #"hash_9f02a38a98823d61":
                        soundalias = "scn_infil_hackney_van_plr2";
                        break;
                    case #"hash_9f02a08a988238a8":
                        soundalias = "scn_infil_hackney_van_plr1";
                        break;
                    case #"hash_9f02a18a98823a3b":
                        soundalias = "scn_infil_hackney_van_plr6";
                        break;
                    case #"hash_9f02a68a9882421a":
                        soundalias = "scn_infil_hackney_van_plr5";
                        break;
                    case #"hash_9f02a78a988243ad":
                        soundalias = "scn_infil_hackney_van_plr4";
                        break;
                    default:
                        soundalias = "scn_infil_hackney_van_plr3";
                        break;
                }
            }
            else
            {
                switch ( self.animname )
                {
                    case #"hash_9f02a28a98823bce":
                        soundalias = "scn_infil_hackney_van_plr3";
                        break;
                    case #"hash_9f02a38a98823d61":
                        soundalias = "scn_infil_hackney_van_plr2";
                        break;
                    case #"hash_9f02a08a988238a8":
                        soundalias = "scn_infil_hackney_van_plr1";
                        break;
                    case #"hash_9f02a18a98823a3b":
                        soundalias = "scn_infil_hackney_van_plr6";
                        break;
                    case #"hash_9f02a68a9882421a":
                        soundalias = "scn_infil_hackney_van_plr5";
                        break;
                    case #"hash_9f02a78a988243ad":
                        soundalias = "scn_infil_hackney_van_plr4";
                        break;
                    default:
                        soundalias = "scn_infil_hackney_van_plr3";
                        break;
                }
            }
        }
        
        self playlocalsound( soundalias );
    }
    
    self setcinematicmotionoverride( "disabled" );
    self lerpviewangleclamp( 1, 0.25, 0.25, 60, 60, 30, 30 );
    infil.linktoent anim_player_solo( self, self.player_rig, "van_hackney_infil_" + infil.subtype, "tag_origin" );
    thread clear_infil_ambient_zone();
    
    if ( isdefined( self.player_rig ) && self.player_rig islinked() )
    {
        self.player_rig unlink();
    }
    
    self visionsetnakedforplayer( "", 0.75 );
    self setdemeanorviewmodel( "normal" );
    self clearcinematicmotionoverride();
    self disablephysicaldepthoffieldscripting();
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 0
// Checksum 0x0, Offset: 0x1286
// Size: 0x34
function clear_infil_ambient_zone()
{
    self endon( "death_or_disconnect" );
    wait 1;
    
    if ( isdefined( self.submix ) )
    {
        self clearsoundsubmix( self.submix, 2 );
    }
    
    self clearclienttriggeraudiozone( 2 );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 0
// Checksum 0x0, Offset: 0x12c2
// Size: 0x2c
function player_infil_end()
{
    self endon( "disconnect" );
    level waittill( "prematch_over" );
    self notify( "remove_rig" );
    self clearclienttriggeraudiozone( 1 );
    scripts\mp\utility\player::setdof_default();
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x12f6
// Size: 0x7b
function van_infil_radio_idle( infil )
{
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "hackney_infil_van_intro", 1 );
        radio_sfx = spawn( "script_origin", ( 0, 0, 0 ) );
        radio_sfx showonlytoplayer( self );
        radio_sfx playloopsound( "dx_mpo_ukop_radio_chatter" );
        gameflagwait( "infil_started" );
        wait 4;
        radio_sfx stoploopsound( "dx_mpo_ukop_radio_chatter" );
        radio_sfx delete();
    }
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 0
// Checksum 0x0, Offset: 0x1379
// Size: 0x4c
function player_van_disconnect()
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

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 3
// Checksum 0x0, Offset: 0x13cd
// Size: 0x17d
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
    
    if ( team == "allies" )
    {
        self.actors[ 0 ] hidepart( "j_sling_pivot" );
    }
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 3
// Checksum 0x0, Offset: 0x1552
// Size: 0x7a
function blima_chief_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.blima.players )
    {
        player playsoundtoplayer( alias, player );
    }
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 2
// Checksum 0x0, Offset: 0x15d4
// Size: 0x28c
function infilthink( team, scene_name )
{
    var_e026a614f7467557 = getdvarfloat( @"hash_ea4c44a08cd23d5d", 0.2 );
    
    foreach ( ent in getentarray( "infil_delete", "script_noteworthy" ) )
    {
        ent delete();
    }
    
    thread vehiclethink( team, self.scene_node, scene_name );
    thread actorthink( team, self.scene_node, scene_name );
    gameflagwait( "infil_started" );
    gates = getentarray( "infil_opforce_gate", "targetname" );
    
    foreach ( ent in gates )
    {
        ent hide();
    }
    
    setdvar( @"r_spotlightentityshadows", 1 );
    setdvar( @"hash_ea4c44a08cd23d5d", 1 );
    level notify( "start_scene" );
    level waittill( "prematch_over" );
    
    foreach ( ent in gates )
    {
        ent show();
    }
    
    setdvar( @"r_spotlightentityshadows", 0 );
    setdvar( @"hash_ea4c44a08cd23d5d", var_e026a614f7467557 );
    var_330b9ced435f328d = getentarray( "van_hackney_infil_alpha_probe", "targetname" );
    var_93c53aca7d492296 = getentarray( "van_probe", "script_noteworthy" );
    var_f7200b59912b6dd6 = getentarray( "van_probe_fallback", "script_noteworthy" );
    var_7a03243611606b01 = array_combine( var_330b9ced435f328d, var_93c53aca7d492296, var_f7200b59912b6dd6 );
    
    if ( isdefined( var_7a03243611606b01 ) && var_7a03243611606b01.size > 0 )
    {
        foreach ( probe in var_7a03243611606b01 )
        {
            probe hide();
        }
    }
    
    while ( isdefined( self.actors ) )
    {
        waitframe();
    }
    
    level.infilsactive--;
    self delete();
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 4
// Checksum 0x0, Offset: 0x1868
// Size: 0x1c5
function vehiclethink( team, scene_node, scene_name, extra_crew )
{
    van = spawnvan( scene_node, team, scene_name );
    anim_first_frame_solo( van, "van_hackney_infil_" + scene_name );
    gameflagwait( "infil_started" );
    clip = getent( "palfa_clip", "targetname" );
    
    if ( isdefined( clip ) )
    {
        var_5f83b6e30bb8ae0c = spawn( "script_model", van.origin );
        var_5f83b6e30bb8ae0c.angles = van.angles;
        var_5f83b6e30bb8ae0c clonebrushmodeltoscriptmodel( clip );
    }
    
    van setscriptablepartstate( "infil_lights", "on", 0 );
    van setscriptablepartstate( "exhaust", "on", 0 );
    thread van_interior_sfx( scene_name );
    anim_single_solo( van, "van_hackney_infil_" + scene_name + "_intro" );
    anim_single_solo( van, "van_hackney_infil_" + scene_name );
    anim_single_solo( van, "van_hackney_infil_" + scene_name + "_exit" );
    van setscriptablepartstate( "infil_lights", "off", 0 );
    van setscriptablepartstate( "exhaust", "off", 0 );
    game[ "infil" ][ "types" ][ self.type ][ scene_name ][ "persistentVehicle" ] = &spawnpersistentvehicle;
    game[ "infil" ][ "types" ][ self.type ][ scene_name ][ "vehicleOrg" ] = self.linktoent.origin;
    game[ "infil" ][ "types" ][ self.type ][ scene_name ][ "vehicleAng" ] = self.linktoent.angles;
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 2
// Checksum 0x0, Offset: 0x1a35
// Size: 0x12b
function spawnpersistentvehicle( type, subtype )
{
    spawnpos = game[ "infil" ][ "types" ][ type ][ subtype ][ "vehicleOrg" ];
    spawnang = game[ "infil" ][ "types" ][ type ][ subtype ][ "vehicleAng" ];
    van = spawn( "script_model", spawnpos );
    van.angles = spawnang;
    model = "veh8_civ_lnd_palfa_rhd_wet_infil";
    
    if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear_pm" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_crash2" )
    {
        model = "veh8_civ_lnd_palfa_rhd_infil";
    }
    
    van setmodel( model );
    van.animname = "van";
    van setanimtree();
    clip = getent( "palfa_clip", "targetname" );
    
    if ( isdefined( clip ) )
    {
        var_5f83b6e30bb8ae0c = spawn( "script_model", spawnpos );
        var_5f83b6e30bb8ae0c.angles = spawnang;
        var_5f83b6e30bb8ae0c clonebrushmodeltoscriptmodel( clip );
    }
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1b68
// Size: 0xda
function van_interior_sfx( scene_name )
{
    door_sfx = spawn( "script_model", self.linktoent.origin );
    door_sfx linkto( self.linktoent, "tag_door_back_left" );
    front_sfx = spawn( "script_model", self.linktoent.origin );
    front_sfx linkto( self.linktoent, "tag_hood" );
    wait 0.1;
    door_sfx playsoundonmovingent( "scn_infil_hackney_van_int_rear" );
    front_sfx playsoundonmovingent( "scn_infil_hackney_van_int_front" );
    wait 7.75;
    door_sfx playsoundonmovingent( "scn_infil_hackney_van_door_open" );
    wait 8;
    door_sfx playsoundonmovingent( "scn_infil_hackney_van_door_close" );
    level waittill( "prematch_over" );
    front_sfx delete();
    door_sfx delete();
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1c4a
// Size: 0x17
function van_infil_sfx_npc1( guy )
{
    guy playsoundonmovingent( "scn_infil_hackney_van_npc3" );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1c69
// Size: 0x17
function van_infil_sfx_npc2( guy )
{
    guy playsoundonmovingent( "scn_infil_hackney_van_npc2" );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1c88
// Size: 0x17
function van_infil_sfx_npc3( guy )
{
    guy playsoundonmovingent( "scn_infil_hackney_van_npc1" );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1ca7
// Size: 0x17
function van_infil_sfx_npc4( guy )
{
    guy playsoundonmovingent( "scn_infil_hackney_van_npc6" );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1cc6
// Size: 0x17
function van_infil_sfx_npc5( guy )
{
    guy playsoundonmovingent( "scn_infil_hackney_van_npc5" );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1ce5
// Size: 0x17
function van_infil_sfx_npc6( guy )
{
    guy playsoundonmovingent( "scn_infil_hackney_van_npc4" );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x1d04
// Size: 0x17
function van_infil_sfx_chief( guy )
{
    guy playsoundonmovingent( "scn_infil_hackney_van_commander" );
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 4
// Checksum 0x0, Offset: 0x1d23
// Size: 0x14d
function actorthink( team, scene_node, scene_name, extra_crew )
{
    thread spawnactors( team, scene_name, extra_crew );
    self.linktoent anim_first_frame( self.actors, "van_hackney_infil_" + scene_name, "tag_origin" );
    gameflagwait( "infil_started" );
    self.linktoent thread anim_single( self.actors, "van_hackney_infil_" + scene_name, "tag_origin" );
    self.actors[ 0 ].head scriptmodelplayanim( level.scr_anim[ self.actors[ 0 ].animname ][ "van_hackney_infil_" + scene_name ] );
    duration = getanimlength( level.scr_anim[ "commander" ][ "van_hackney_infil_" + scene_name ] );
    wait duration;
    
    foreach ( actor in self.actors )
    {
        actor delete();
    }
    
    self.actors = undefined;
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 5
// Checksum 0x0, Offset: 0x1e78
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

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x20c6
// Size: 0x47f
function initanims( subtype )
{
    script_model_alpha_anims();
    vehicles_alpha_anims();
    addnotetrack_customfunction( "slot_0", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_0", "shake_running", &cam_shake_running, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_1", "shake_running", &cam_shake_running, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_2", "shake_running", &cam_shake_running, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_3", "shake_running", &cam_shake_running, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_4", "shake_running", &cam_shake_running, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_5", "shake_running", &cam_shake_running, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_0", "equip_nvg", &player_equip_nvg, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_1", "equip_nvg", &player_equip_nvg, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_2", "equip_nvg", &player_equip_nvg, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_3", "equip_nvg", &player_equip_nvg, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_4", "equip_nvg", &player_equip_nvg, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_5", "equip_nvg", &player_equip_nvg, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_0", "shake_parked", &cam_shake_parked, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_1", "shake_parked", &cam_shake_parked, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_2", "shake_parked", &cam_shake_parked, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_3", "shake_parked", &cam_shake_parked, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_4", "shake_parked", &cam_shake_parked, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_5", "shake_parked", &cam_shake_parked, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_0", "shake_off", &customground, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_1", "shake_off", &customground, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_2", "shake_off", &customground, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_3", "shake_off", &customground, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_4", "shake_off", &customground, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_5", "shake_off", &customground, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_0", "free_look", &player_free_look, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_1", "free_look", &player_free_look, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_2", "free_look", &player_free_look, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_3", "free_look", &player_free_look, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_4", "free_look", &player_free_look, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_5", "free_look", &player_free_look, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_0", "van_infil_sfx_npc1", &van_infil_sfx_npc1 );
    addnotetrack_customfunction( "slot_1", "van_infil_sfx_npc2", &van_infil_sfx_npc2 );
    addnotetrack_customfunction( "slot_2", "van_infil_sfx_npc3", &van_infil_sfx_npc3 );
    addnotetrack_customfunction( "slot_3", "van_infil_sfx_npc4", &van_infil_sfx_npc4 );
    addnotetrack_customfunction( "slot_4", "van_infil_sfx_npc5", &van_infil_sfx_npc5 );
    addnotetrack_customfunction( "slot_5", "van_infil_sfx_npc6", &van_infil_sfx_npc6 );
    addnotetrack_customfunction( "slot_0", "player_lock_look_1_second", &player_lock_look_1_second, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_1", "player_lock_look_1_second", &player_lock_look_1_second, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_2", "player_lock_look_1_second", &player_lock_look_1_second, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_3", "player_lock_look_1_second", &player_lock_look_1_second, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_4", "player_lock_look_1_second", &player_lock_look_1_second, "van_hackney_infil_alpha" );
    addnotetrack_customfunction( "slot_5", "player_lock_look_1_second", &player_lock_look_1_second, "van_hackney_infil_alpha" );
}

#using_animtree( "script_model" );

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 0
// Checksum 0x0, Offset: 0x254d
// Size: 0x34a
function script_model_alpha_anims()
{
    level.scr_animtree[ "driver" ] = #animtree;
    level.scr_anim[ "driver" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_driver;
    level.scr_animtree[ "commander" ] = #animtree;
    level.scr_anim[ "commander" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_chief;
    addnotetrack_customfunction( "commander", "sfx_infil_hackney_van_commander", &van_infil_sfx_chief );
    level.scr_animtree[ "van" ] = #animtree;
    
    switch ( getdvar( @"g_mapname" ) )
    {
        case #"hash_d83171ba75f8b8fe":
            level.scr_anim[ "van" ][ "van_hackney_infil_alpha_intro" ] = %mp_infil_van_veh_intro_spear;
            break;
        case #"hash_9c2fdccb75b37f7e":
            level.scr_anim[ "van" ][ "van_hackney_infil_alpha_intro" ] = %infil_opforce_van_hackney_enter_van_mpcrash;
            break;
        default:
            level.scr_anim[ "van" ][ "van_hackney_infil_alpha_intro" ] = %infil_opforce_van_hackney_enter_van;
            break;
    }
    
    level.scr_anim[ "van" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_van;
    level.scr_anim[ "van" ][ "van_hackney_infil_alpha_exit" ] = %infil_opforce_van_hackney_exit_van;
    level.scr_animtree[ "slot_0" ] = #animtree;
    level.scr_anim[ "slot_0" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_1;
    level.scr_eventanim[ "slot_0" ][ "van_hackney_infil_alpha" ] = %"hash_2aa403f9fe6c6fd9";
    level.scr_animtree[ "slot_1" ] = #animtree;
    level.scr_anim[ "slot_1" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_2;
    level.scr_eventanim[ "slot_1" ][ "van_hackney_infil_alpha" ] = %"hash_2aa400f9fe6c6ac0";
    level.scr_animtree[ "slot_2" ] = #animtree;
    level.scr_anim[ "slot_2" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_3;
    level.scr_eventanim[ "slot_2" ][ "van_hackney_infil_alpha" ] = %"hash_2aa401f9fe6c6c73";
    level.scr_animtree[ "slot_3" ] = #animtree;
    level.scr_anim[ "slot_3" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_4;
    level.scr_eventanim[ "slot_3" ][ "van_hackney_infil_alpha" ] = %"hash_2aa406f9fe6c74f2";
    level.scr_animtree[ "slot_4" ] = #animtree;
    level.scr_anim[ "slot_4" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_5;
    level.scr_eventanim[ "slot_4" ][ "van_hackney_infil_alpha" ] = %"hash_2aa407f9fe6c76a5";
    level.scr_animtree[ "slot_5" ] = #animtree;
    level.scr_anim[ "slot_5" ][ "van_hackney_infil_alpha" ] = %infil_opforce_van_6;
    level.scr_eventanim[ "slot_5" ][ "van_hackney_infil_alpha" ] = %"hash_2aa404f9fe6c718c";
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 0
// Checksum 0x0, Offset: 0x289f
// Size: 0x2
function vehicles_alpha_anims()
{
    
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 3
// Checksum 0x0, Offset: 0x28a9
// Size: 0x274
function spawnvan( scene_node, team, scene_name )
{
    van = spawn( "script_model", scene_node.origin );
    van.angles = scene_node.angles;
    model = "veh8_civ_lnd_palfa_rhd_wet_infil";
    
    if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear" || scripts\cp_mp\utility\game_utility::getmapname() == "mp_spear_pm" )
    {
        model = "veh8_civ_lnd_palfa_rhd_infil";
    }
    
    van setmodel( model );
    van.animname = "van";
    van setanimtree();
    van setcandamage( 0 );
    self.linktoent = van;
    van.infil = self;
    var_330b9ced435f328d = getentarray( "van_hackney_infil_alpha_probe", "targetname" );
    var_93c53aca7d492296 = getentarray( "van_probe", "script_noteworthy" );
    var_f7200b59912b6dd6 = getentarray( "van_probe_fallback", "script_noteworthy" );
    probes = array_combine( var_330b9ced435f328d, var_93c53aca7d492296, var_f7200b59912b6dd6 );
    probe = undefined;
    
    foreach ( entry in probes )
    {
        if ( isdefined( entry.van ) )
        {
            continue;
        }
        
        probe = entry;
        break;
    }
    
    if ( isdefined( probe ) )
    {
        van.probe = probe;
        probe.van = van;
        van.probe.origin = van.origin;
        van.probe linkto( van, "tag_origin", ( -42, 0, 56.5 ), ( 0, 0, 0 ) );
        
        switch ( level.mapname )
        {
            case #"hash_a3aa6afd955c54d":
            case #"hash_be52fbd3b8746bc":
            case #"hash_8cd7282b2d63b917":
            case #"hash_9c2fdccb75b37f7e":
            case #"hash_d83171ba75f8b8fe":
            case #"hash_d8bbcfc499e70e6f":
                van.probe hide();
                break;
        }
    }
    
    return van;
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 3
// Checksum 0x0, Offset: 0x2b26
// Size: 0x7a
function commander_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.infil.players )
    {
        self playsoundtoplayer( alias, player );
    }
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 3
// Checksum 0x0, Offset: 0x2ba8
// Size: 0x7a
function driver_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.infil.players )
    {
        self playsoundtoplayer( alias, player );
    }
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x2c2a
// Size: 0x6e
function getcommanderassets( team )
{
    data = spawnstruct();
    
    if ( team == "axis" )
    {
        data.body = "body_mp_eastern_fireteam_east_sg_no_sling";
        data.head = "head_mp_eastern_fireteam_east_ar_4";
    }
    else
    {
        data.body = "body_mp_western_fireteam_west_smg_1_1";
        data.head = "head_mp_western_fireteam_west_smg_2_1";
    }
    
    return data;
}

// Namespace van_hackney_infil / scripts\mp\infilexfil\van_hackney_infil
// Params 1
// Checksum 0x0, Offset: 0x2ca1
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

