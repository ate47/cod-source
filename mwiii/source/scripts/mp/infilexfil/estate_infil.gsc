#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
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

#namespace estate_infil;

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 1
// Checksum 0x0, Offset: 0x8c3
// Size: 0x95
function estate_init( subtype )
{
    function_f1aed36ab4598ea( "palfa_estate_infil" );
    thread function_99fbfc1d5ecbea75();
    
    /#
        setdevdvarifuninitialized( @"hash_3dc902e1a71dd25d", 0 );
    #/
    
    var_453e4fc2c649fea4 = [];
    var_453e4fc2c649fea4[ 0 ] = [ 0 ];
    var_453e4fc2c649fea4[ 1 ] = [ 1, 2, 3 ];
    var_453e4fc2c649fea4[ 2 ] = [ 4, 5 ];
    thread infil_add( "infil_estate", subtype, 6, 4, var_453e4fc2c649fea4, &estate_spawn, &function_2e33cc2fe5c25c43, &function_162bb826cd9f6807 );
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 4
// Checksum 0x0, Offset: 0x960
// Size: 0xf0
function estate_spawn( team, target, subtype, originalsubtype )
{
    initanims( subtype, team, originalsubtype );
    scene_node = getstruct( target, "targetname" );
    infil = spawn( "script_origin", scene_node.origin );
    infil.angles = scene_node.angles;
    infil.scene_node = scene_node;
    
    if ( isdefined( scene_node.target ) )
    {
        infil.introdur = getanimlength( level.scr_anim[ "crew1" ][ "estate_infil" ] );
        infil.path = scene_node;
    }
    
    infil.subtype = subtype;
    infil.originalsubtype = originalsubtype;
    infil thread infilthink( team, subtype );
    return infil;
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 1
// Checksum 0x0, Offset: 0xa59
// Size: 0x32
function function_2e33cc2fe5c25c43( subtype )
{
    animlength = getanimlength( level.scr_anim[ "crew1" ][ "estate_infil" ] );
    return animlength;
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 2
// Checksum 0x0, Offset: 0xa94
// Size: 0x249
function function_162bb826cd9f6807( infil, spot_index )
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
    self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe_heli" );
    self visionsetnakedforplayer( "mp_jup_estate_helicopter_intro", 0 );
    self function_451319f93d30ebe5( %"hw_mp_jup_estate_infil" );
    thread player_disconnect();
    level waittill( "start_scene" );
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "jup_infil_generic" );
    }
    
    thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5( "jup_mp_infil" );
    
    if ( isdefined( self.animname ) && !isai( self ) )
    {
        self playlocalsound( "jup_infil_palfa_estate_lr" );
    }
    
    self lerpfov( 65, 0 );
    self lerpfovscalefactor( 0, 0 );
    self setcinematicmotionoverride( "disabled" );
    self lerpviewangleclamp( 1, 0.25, 0.25, 40, 40, 15, 5 );
    thread clear_infil_ambient_zone();
    thread resetfov();
    infil.linktoent anim_first_frame_solo( self.player_rig, "estate_infil", "tag_origin_animate" );
    infil.linktoent anim_player_solo( self, self.player_rig, "estate_infil", "tag_origin_animate" );
    
    if ( isdefined( self.player_rig ) && self.player_rig islinked() )
    {
        self.player_rig unlink();
    }
    
    scripts\mp\class::unblockclasschange();
    self visionsetnakedforplayer( "", 1.5 );
    self lerpfovscalefactor( 1, 2 );
    self function_df8fad503896462( %"hw_mp_jup_estate_infil" );
    self setdemeanorviewmodel( "normal" );
    self clearcinematicmotionoverride();
    self disablephysicaldepthoffieldscripting();
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 0
// Checksum 0x0, Offset: 0xce5
// Size: 0x27
function resetfov()
{
    level waittill( "infil_countdown_show" );
    wait 2;
    self lerpfovbypreset( "default_2seconds" );
    self lerpfovscalefactor( 1, 2 );
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 0
// Checksum 0x0, Offset: 0xd14
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

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 0
// Checksum 0x0, Offset: 0xd58
// Size: 0x60
function player_infil_end()
{
    animlength = getanimlength( level.scr_anim[ "crew1" ][ "estate_infil" ] );
    wait animlength;
    self endon( "disconnect" );
    level waittill( "prematch_over" );
    self notify( "remove_rig" );
    self clearclienttriggeraudiozone( 1 );
    self lerpfovbypreset( "default_2seconds" );
    scripts\mp\utility\player::setdof_default();
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 1
// Checksum 0x0, Offset: 0xdc0
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
            var_9742aa030e46f6c0 playloopsound( "jup_infil_palfa_estate_preinfil_lp" );
            function_7330aa81e1f66e19( "infil_started", "death_or_disconnect" );
            wait 1;
            radio_sfx stoploopsound( "dx_mpo_ukop_radio_chatter" );
            var_9742aa030e46f6c0 stoploopsound( "jup_infil_palfa_estate_preinfil_lp" );
            radio_sfx delete();
            var_9742aa030e46f6c0 delete();
        }
        
        return;
    }
    
    return;
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 2
// Checksum 0x0, Offset: 0xe9a
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

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 0
// Checksum 0x0, Offset: 0xed0
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

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 3
// Checksum 0x0, Offset: 0xf24
// Size: 0xbe
function spawnactors( team, scene_name, extra_crew )
{
    if ( !isdefined( self.actors ) )
    {
        self.actors = [];
    }
    
    self.actors[ self.actors.size ] = self.linktoent spawn_anim_model( "crew1", "tag_origin_animate", "fullbody_sp_ally_helicopter_crew_chief" );
    
    foreach ( actor in self.actors )
    {
        actor.infil = self;
    }
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 2
// Checksum 0x0, Offset: 0xfea
// Size: 0x140
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

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 4
// Checksum 0x0, Offset: 0x1132
// Size: 0x1d7
function vehiclethink( team, scene_node, scene_name, extra_crew )
{
    self.linktoent = spawninfilvehicle( scene_node, team, scene_name, "estate_heli" );
    anim_first_frame_solo( self.linktoent, "estate_infil" + "_intro" );
    self.linktoent thread function_e33b9b53992e051d();
    level waittill( "infil_started" );
    thread anim_single_solo( self.linktoent, "estate_infil" + "_intro" );
    animlength = getanimlength( level.scr_anim[ "crew1" ][ "estate_infil" ] );
    wait animlength;
    
    if ( isdefined( self.path ) )
    {
        self.linktoent stopanimscripted();
        
        if ( self.linktoent vehicle_isphysveh() )
        {
            self.linktoent vehphys_setdefaultmotion();
        }
        
        startstruct = spawnstruct();
        startstruct.origin = self.linktoent.origin;
        startstruct.angles = self.linktoent.angles;
        startstruct.radius = 500;
        startstruct.speed = 30;
        startstruct.target = self.path.target;
        self.linktoent scripts\common\vehicle_paths::vehicle_paths_helicopter( startstruct );
    }
    else
    {
        wait animlength;
        self.linktoent anim_single_solo( self.linktoent, "estate_infil" + "_exit" );
    }
    
    if ( isdefined( self.linktoent ) )
    {
        self.linktoent delete();
        self.linktoent = undefined;
    }
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 4
// Checksum 0x0, Offset: 0x1311
// Size: 0x150
function spawninfilvehicle( scene_node, team, scene_name, animname )
{
    spawnpos = scene_node.origin;
    spawnang = scene_node.angles;
    model = "veh9_mil_air_heli_palfa_doors_open_vehphys_mp";
    var_ab5cd311f5dc80a6 = "veh9_mil_air_heli_palfa_physics_mp";
    vehicle = spawnvehicle( model, scene_name, var_ab5cd311f5dc80a6, spawnpos, spawnang );
    vehicle setvehicleteam( team );
    vehicle.animname = animname;
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
    
    vehicle hidepart( "tag_main_rotor_blade_01" );
    vehicle hidepart( "tag_main_rotor_blade_02" );
    vehicle hidepart( "tag_main_rotor_blade_03" );
    vehicle hidepart( "tag_main_rotor_blade_04" );
    vehicle hidepart( "tag_main_rotor_blade_05" );
    vehicle hidepart( "tag_main_rotor_blade_06" );
    vehicle hidepart( "tag_tail_rotor_blade_01" );
    vehicle hidepart( "tag_tail_rotor_blade_02" );
    vehicle hidepart( "tag_tail_rotor_blade_03" );
    vehicle hidepart( "tag_tail_rotor_blade_04" );
    vehicle.infil = self;
    vehicle vehicle_turnengineoff();
    return vehicle;
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 4
// Checksum 0x0, Offset: 0x146a
// Size: 0xe3
function actorthink( team, scene_node, scene_name, extra_crew )
{
    thread spawnactors( team, scene_name, extra_crew );
    self.linktoent anim_first_frame( self.actors, "estate_infil", "tag_origin_animate" );
    gameflagwait( "infil_started" );
    self.linktoent anim_single( self.actors, "estate_infil", "tag_origin_animate" );
    
    foreach ( actor in self.actors )
    {
        if ( isdefined( actor ) )
        {
            actor delete();
        }
    }
    
    self.actors = undefined;
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 5
// Checksum 0x0, Offset: 0x1555
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

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 3
// Checksum 0x0, Offset: 0x17a3
// Size: 0x1b9
function initanims( subtype, team, originalsubtype )
{
    script_model_alpha_anims( subtype );
    vehicles_anims( subtype, team, originalsubtype );
    addnotetrack_customfunction( "slot_0", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_1", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_2", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_3", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_4", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_5", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_0", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_1", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_2", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_3", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_4", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_5", "player_lock_look_1_second", &player_lock_look_1_second );
    addnotetrack_customfunction( "slot_0", "free_look", &player_free_look );
    addnotetrack_customfunction( "slot_1", "free_look", &player_free_look );
    addnotetrack_customfunction( "slot_2", "free_look", &player_free_look );
    addnotetrack_customfunction( "slot_3", "free_look", &player_free_look );
    addnotetrack_customfunction( "slot_4", "free_look", &player_free_look );
    addnotetrack_customfunction( "slot_5", "free_look", &player_free_look );
}

#using_animtree( "script_model" );

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 1
// Checksum 0x0, Offset: 0x1964
// Size: 0x23b
function script_model_alpha_anims( subtype )
{
    level.scr_animtree[ "slot_0" ] = #animtree;
    level.scr_anim[ "slot_0" ][ "estate_infil" ] = %jup_mp_infil_palfa_guy_0;
    level.scr_eventanim[ "slot_0" ][ "estate_infil" ] = %"infil_estate_guy_1";
    level.scr_animtree[ "slot_1" ] = #animtree;
    level.scr_anim[ "slot_1" ][ "estate_infil" ] = %jup_mp_infil_palfa_guy_1;
    level.scr_eventanim[ "slot_1" ][ "estate_infil" ] = %"infil_estate_guy_2";
    level.scr_animtree[ "slot_2" ] = #animtree;
    level.scr_anim[ "slot_2" ][ "estate_infil" ] = %jup_mp_infil_palfa_guy_2;
    level.scr_eventanim[ "slot_2" ][ "estate_infil" ] = %"infil_estate_guy_3";
    level.scr_animtree[ "slot_3" ] = #animtree;
    level.scr_anim[ "slot_3" ][ "estate_infil" ] = %jup_mp_infil_palfa_guy_3;
    level.scr_eventanim[ "slot_3" ][ "estate_infil" ] = %"infil_estate_guy_4";
    level.scr_animtree[ "slot_4" ] = #animtree;
    level.scr_anim[ "slot_4" ][ "estate_infil" ] = %jup_mp_infil_palfa_guy_4;
    level.scr_eventanim[ "slot_4" ][ "estate_infil" ] = %"infil_estate_guy_5";
    level.scr_animtree[ "slot_5" ] = #animtree;
    level.scr_anim[ "slot_5" ][ "estate_infil" ] = %jup_mp_infil_palfa_guy_5;
    level.scr_eventanim[ "slot_5" ][ "estate_infil" ] = %"infil_estate_guy_6";
    level.scr_animtree[ "crew1" ] = #animtree;
    level.scr_anim[ "crew1" ][ "estate_infil" ] = %jup_mp_infil_palfa_crew;
    level.scr_eventanim[ "crew1" ][ "estate_infil" ] = %"hash_6cede332f278b079";
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 3
// Checksum 0x0, Offset: 0x1ba7
// Size: 0x59
function vehicles_anims( subtype, team, originalsubtype )
{
    level.scr_anim[ "estate_heli" ][ "estate_infil_intro" ] = %jup_mp_infil_palfa_vehicle;
    level.scr_anim[ "estate_heli" ][ "estate_infil_exit" ] = %jup_mp_infil_palfa_vehicle_exit;
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 0
// Checksum 0x0, Offset: 0x1c08
// Size: 0x19
function function_99fbfc1d5ecbea75()
{
    level waittill( "prematch_over" );
    wait 66;
    function_f4e0ff5cb899686d( "palfa_estate_infil" );
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 0
// Checksum 0x0, Offset: 0x1c29
// Size: 0xbd
function function_e33b9b53992e051d()
{
    var_ac69a7c5abea3708 = spawn( "script_model", self.origin );
    var_fc8dd26a2cb1c2b4 = spawn( "script_model", self.origin );
    level waittill( "infil_started" );
    waitframe();
    var_ac69a7c5abea3708 linkto( self );
    var_fc8dd26a2cb1c2b4 linkto( self, "tag_origin", ( -400, 0, -250 ), ( 0, 0, 0 ) );
    waitframe();
    var_ac69a7c5abea3708 playsoundonmovingent( "jup_infil_palfa_estate_heli_ext_lr" );
    wait 3.1;
    var_fc8dd26a2cb1c2b4 playsoundonmovingent( "jup_infil_palfa_estate_heli_start" );
    wait 5.7;
    var_fc8dd26a2cb1c2b4 playsoundonmovingent( "jup_infil_palfa_estate_heli_end" );
    level waittill( "prematch_over" );
    var_ac69a7c5abea3708 delete();
    var_fc8dd26a2cb1c2b4 delete();
}

// Namespace estate_infil / scripts\mp\infilexfil\estate_infil
// Params 0
// Checksum 0x0, Offset: 0x1cee
// Size: 0x13
function function_6158ef142e9bd640()
{
    wait 27;
    self visionsetnakedforplayer( "mp_jup_estate_helicopter_intro_2", 3 );
}

