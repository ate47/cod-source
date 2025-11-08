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

#namespace skerries_infil;

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 1
// Checksum 0x0, Offset: 0x5d3
// Size: 0x9d
function function_57334412d2328b04( subtype )
{
    function_f1aed36ab4598ea( "skerries_infil" );
    thread function_12a422489d86ce46();
    
    /#
        setdevdvarifuninitialized( @"hash_3dc902e1a71dd25d", 0 );
    #/
    
    initanims( subtype );
    var_453e4fc2c649fea4 = [];
    var_453e4fc2c649fea4[ 0 ] = [ 0 ];
    var_453e4fc2c649fea4[ 1 ] = [ 1 ];
    var_453e4fc2c649fea4[ 2 ] = [ 2, 3, 4, 5 ];
    thread infil_add( "infil_skerries", subtype, 6, 4, var_453e4fc2c649fea4, &function_7f2872ee68c3495d, &function_379f2f7e6af4a8ff, &function_72da1a47fa80f9c3 );
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 4
// Checksum 0x0, Offset: 0x678
// Size: 0xa0
function function_7f2872ee68c3495d( team, target, subtype, originalsubtype )
{
    scene_node = getstruct( target, "targetname" );
    infil = spawn( "script_origin", scene_node.origin );
    infil.angles = scene_node.angles;
    infil.scene_node = scene_node;
    infil.var_2b6024d99de136e = loadfx( "vfx/iw9/infil/vfx_rhib_infil_splashes.vfx" );
    infil thread infilthink( team, subtype );
    return infil;
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 1
// Checksum 0x0, Offset: 0x721
// Size: 0x32
function function_379f2f7e6af4a8ff( subtype )
{
    animlength = getanimlength( level.scr_anim[ "slot_0" ][ "skerries_infil" ] );
    return animlength;
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 2
// Checksum 0x0, Offset: 0x75c
// Size: 0x268
function function_72da1a47fa80f9c3( infil, spot_index )
{
    self endon( "player_free_spot" );
    thread player_infil_end();
    self lerpfov( 65, 0 );
    
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
    self visionsetnakedforplayer( "mp_core_infil_2", 0 );
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    thread player_disconnect();
    level waittill( "start_scene" );
    
    if ( isdefined( self.animname ) && !isai( self ) )
    {
        self setclienttriggeraudiozone( "jup_infil_generic" );
    }
    
    thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5( "jup_mp_infil" );
    self setcinematicmotionoverride( "disabled" );
    self lerpviewangleclamp( 1, 0.25, 0.25, 30, 30, 30, 5 );
    thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958( 1 );
    self lerpfovscalefactor( 0, 0 );
    thread resetfov();
    infil.linktoent anim_player_solo( self, self.player_rig, "skerries_infil", "tag_origin_animate" );
    thread scripts\mp\class::unblockclasschange();
    
    if ( isdefined( level.scr_viewmodelanim[ self.animname ] ) && isdefined( level.scr_viewmodelanim[ self.animname ][ "skerries_infil" + "_" + infil.subtype + "_intro" ] ) )
    {
        setdvar( @"hash_7eb1641737ab83b7", 0 );
    }
    
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

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 0
// Checksum 0x0, Offset: 0x9cc
// Size: 0x27
function resetfov()
{
    level waittill( "infil_countdown_show" );
    wait 2;
    self lerpfovbypreset( "default_2seconds" );
    self lerpfovscalefactor( 1, 2 );
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 0
// Checksum 0x0, Offset: 0x9fb
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

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 0
// Checksum 0x0, Offset: 0xa3f
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

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 0
// Checksum 0x0, Offset: 0xa9a
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

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 2
// Checksum 0x0, Offset: 0xaee
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

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 4
// Checksum 0x0, Offset: 0xbd0
// Size: 0xcc
function vehiclethink( team, scene_node, scene_name, extra_crew )
{
    var_c7ce9b511c6c1a72 = function_7de6cd57148ac2ea( scene_node, team, scene_name, "skerries_a" );
    self.linktoent vehicle_turnengineoff();
    
    if ( !isdefined( self.path ) )
    {
        anim_first_frame_solo( var_c7ce9b511c6c1a72, "skerries_infil" );
    }
    
    var_c7ce9b511c6c1a72 thread function_cd31140f6d535f7a();
    level waittill( "infil_started" );
    
    if ( isdefined( self.var_2b6024d99de136e ) )
    {
        playfxontag( self.var_2b6024d99de136e, var_c7ce9b511c6c1a72, "tag_origin_animate" );
    }
    
    function_a5361511d072cefe( 0.2 );
    thread anim_single_solo( var_c7ce9b511c6c1a72, "skerries_infil" );
    level waittill( "prematch_over" );
    function_a5361511d072cefe( 1 );
    var_c7ce9b511c6c1a72 delete();
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 0
// Checksum 0x0, Offset: 0xca4
// Size: 0x19
function function_12a422489d86ce46()
{
    level waittill( "prematch_over" );
    wait 51;
    function_f4e0ff5cb899686d( "skerries_infil" );
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 0
// Checksum 0x0, Offset: 0xcc5
// Size: 0xdb
function function_cd31140f6d535f7a()
{
    var_445e30f795f6d02b = spawn( "script_model", ( 0, 0, 0 ) );
    var_14469bd782ed6fb2 = spawn( "script_model", ( 0, 0, 0 ) );
    level waittill( "infil_started" );
    waitframe();
    var_445e30f795f6d02b linkto( self, "tag_origin", ( 87, 0, 50 ), ( 0, 0, 0 ) );
    var_14469bd782ed6fb2 linkto( self, "tag_origin", ( -87, 0, 55 ), ( 0, 0, 0 ) );
    waitframe();
    var_445e30f795f6d02b playsoundonmovingent( "scn_infil_skerries_surface_front" );
    var_14469bd782ed6fb2 playsoundonmovingent( "scn_infil_skerries_surface_rear" );
    wait 6;
    var_14469bd782ed6fb2 playsoundonmovingent( "scn_infil_skerries_impact" );
    level waittill( "prematch_over" );
    var_445e30f795f6d02b delete();
    var_14469bd782ed6fb2 delete();
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 1
// Checksum 0x0, Offset: 0xda8
// Size: 0x1b
function initanims( subtype )
{
    script_model_anims( subtype );
    vehicles_anims( subtype );
}

#using_animtree( "script_model" );

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 1
// Checksum 0x0, Offset: 0xdcb
// Size: 0x70f
function script_model_anims( subtype )
{
    switch ( subtype )
    {
        case #"hash_6829ee5abc10c38b":
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_01;
            level.scr_eventanim[ "slot_0" ][ "skerries_infil" ] = %"infil_skerries_seat_1";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_02;
            level.scr_eventanim[ "slot_1" ][ "skerries_infil" ] = %"infil_skerries_seat_2";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_03;
            level.scr_eventanim[ "slot_2" ][ "skerries_infil" ] = %"infil_skerries_seat_3";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_04;
            level.scr_eventanim[ "slot_3" ][ "skerries_infil" ] = %"infil_skerries_seat_4";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_05;
            level.scr_eventanim[ "slot_4" ][ "skerries_infil" ] = %"infil_skerries_seat_5";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_06;
            level.scr_eventanim[ "slot_5" ][ "skerries_infil" ] = %"infil_skerries_seat_6";
            level.scr_animtree[ "slot_6" ] = #animtree;
            level.scr_anim[ "slot_6" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_07;
            level.scr_eventanim[ "slot_6" ][ "skerries_infil" ] = %"infil_skerries_seat_7";
            level.scr_animtree[ "slot_7" ] = #animtree;
            level.scr_anim[ "slot_7" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_08;
            level.scr_eventanim[ "slot_7" ][ "skerries_infil" ] = %"infil_skerries_seat_8";
            level.scr_animtree[ "slot_8" ] = #animtree;
            level.scr_anim[ "slot_8" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_09;
            level.scr_eventanim[ "slot_8" ][ "skerries_infil" ] = %"infil_skerries_seat_9";
            level.scr_animtree[ "slot_9" ] = #animtree;
            level.scr_anim[ "slot_9" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_10;
            level.scr_eventanim[ "slot_9" ][ "skerries_infil" ] = %"infil_skerries_seat_10";
            level.scr_animtree[ "slot_10" ] = #animtree;
            level.scr_anim[ "slot_10" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_11;
            level.scr_eventanim[ "slot_10" ][ "skerries_infil" ] = %"infil_skerries_seat_11";
        case #"hash_1cc79b02710cab23":
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_01;
            level.scr_eventanim[ "slot_0" ][ "skerries_infil" ] = %"infil_skerries_seat_1";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_02;
            level.scr_eventanim[ "slot_1" ][ "skerries_infil" ] = %"infil_skerries_seat_2";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_03;
            level.scr_eventanim[ "slot_2" ][ "skerries_infil" ] = %"infil_skerries_seat_3";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_04;
            level.scr_eventanim[ "slot_3" ][ "skerries_infil" ] = %"infil_skerries_seat_4";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_05;
            level.scr_eventanim[ "slot_4" ][ "skerries_infil" ] = %"infil_skerries_seat_5";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_06;
            level.scr_eventanim[ "slot_5" ][ "skerries_infil" ] = %"infil_skerries_seat_6";
            level.scr_animtree[ "slot_6" ] = #animtree;
            level.scr_anim[ "slot_6" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_07;
            level.scr_eventanim[ "slot_6" ][ "skerries_infil" ] = %"infil_skerries_seat_7";
            level.scr_animtree[ "slot_7" ] = #animtree;
            level.scr_anim[ "slot_7" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_08;
            level.scr_eventanim[ "slot_7" ][ "skerries_infil" ] = %"infil_skerries_seat_8";
            level.scr_animtree[ "slot_8" ] = #animtree;
            level.scr_anim[ "slot_8" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_09;
            level.scr_eventanim[ "slot_8" ][ "skerries_infil" ] = %"infil_skerries_seat_9";
            level.scr_animtree[ "slot_9" ] = #animtree;
            level.scr_anim[ "slot_9" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_10;
            level.scr_eventanim[ "slot_9" ][ "skerries_infil" ] = %"infil_skerries_seat_10";
            level.scr_animtree[ "slot_10" ] = #animtree;
            level.scr_anim[ "slot_10" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_seat_11;
            level.scr_eventanim[ "slot_10" ][ "skerries_infil" ] = %"infil_skerries_seat_11";
            break;
    }
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 1
// Checksum 0x0, Offset: 0x14e2
// Size: 0x94
function vehicles_anims( subtype )
{
    switch ( subtype )
    {
        case #"hash_6829ee5abc10c38b":
            level.scr_animtree[ "skerries_a" ] = #animtree;
            level.scr_anim[ "skerries_a" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_a;
            break;
        case #"hash_1cc79b02710cab23":
            level.scr_animtree[ "skerries_a" ] = #animtree;
            level.scr_anim[ "skerries_a" ][ "skerries_infil" ] = %iw9_mp_infil_rhib_a;
            break;
    }
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 4
// Checksum 0x0, Offset: 0x157e
// Size: 0xde
function function_7de6cd57148ac2ea( scene_node, team, scene_name, animname )
{
    spawnpos = scene_node.origin;
    spawnang = scene_node.angles;
    
    if ( isdefined( self.path ) )
    {
        spawnpos = self.path.origin;
        spawnang = self.path.angles;
    }
    
    vehicle = spawnvehicle( "veh9_mil_sea_rhib", scene_name, "veh9_rhib_physics", spawnpos, spawnang );
    vehicle setvehicleteam( team );
    vehicle vehphys_forcekeyframedmotion();
    vehicle vehicleshowonminimap( 0 );
    vehicle.animname = animname;
    self.linktoent = vehicle;
    vehicle.infil = self;
    return vehicle;
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 1
// Checksum 0x0, Offset: 0x1665
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
            var_9742aa030e46f6c0 playloopsound( "scn_infil_skerries_preinfil" );
            function_7330aa81e1f66e19( "infil_started", "death_or_disconnect" );
            wait 1;
            radio_sfx stoploopsound( "dx_mpo_ukop_radio_chatter" );
            var_9742aa030e46f6c0 stoploopsound( "scn_infil_skerries_preinfil" );
            var_9742aa030e46f6c0 delete();
            radio_sfx delete();
        }
        
        return;
    }
    
    return;
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 2
// Checksum 0x0, Offset: 0x173f
// Size: 0x2a
function function_7330aa81e1f66e19( var_8068764aee94f2f4, playerstring )
{
    assert( isdefined( var_8068764aee94f2f4 ) );
    
    if ( isdefined( playerstring ) )
    {
        self endon( playerstring );
    }
    
    level waittill( var_8068764aee94f2f4 );
}

// Namespace skerries_infil / scripts\mp\infilexfil\skerries_infil
// Params 0
// Checksum 0x0, Offset: 0x1771
// Size: 0x13
function function_6158ef142e9bd640()
{
    wait 27;
    self visionsetnakedforplayer( "mp_core_infil_2", 3 );
}

