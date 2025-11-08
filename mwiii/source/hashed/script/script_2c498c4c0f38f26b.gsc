#using script_372d8c5f69b0ae2e;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_73353db38b27e9b2;

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0x59e
// Size: 0x136
function init()
{
    if ( !isdefined( level.scripted_melee ) )
    {
        level.scripted_melee = spawnstruct();
    }
    
    if ( istrue( level.scripted_melee.disabled ) )
    {
        return;
    }
    
    level.scripted_melee.var_1fc4fd3ef975e8c8 = &function_78748799de25da5f;
    level.scripted_melee.var_2ec260ca66f2378 = &function_65bbb083561fa648;
    level.scripted_melee.var_efaa5d51e08521eb = &enable_victims;
    level.scripted_melee.var_3522908002cc5af = &function_b3cab4bbbd2f27bf;
    level.scripted_melee.var_16a2ad3bccc62bb5 = &function_53bc249de0d47b05;
    level.scripted_melee.var_2eda72772d041081 = &function_63cac0421acbe53c;
    level.scripted_melee.fndeath = &function_d8f48ab0dfd5ef51;
    level.scripted_melee.fnragdoll = &function_91c24157247ef2fc;
    level.scripted_melee.fnfx = &function_497a27b31d43d6af;
    level.scripted_melee.playerlinkeduselinkedvelocity = &function_5e2b19fd9204a302;
    namespace_db6d5eb4a31b23a::main();
}

#using_animtree( "generic_human" );

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0x6dc
// Size: 0x17c
function function_78748799de25da5f()
{
    function_b0c99390cdb7edd5();
    anims = [];
    anims[ "scripted_melee_kill_01_left" ] = %vm_sp_context_melee_stand_1_left_enemy;
    anims[ "scripted_melee_kill_01_right" ] = %vm_sp_context_melee_stand_1_right_enemy;
    anims[ "scripted_melee_kill_01_front" ] = %vm_sp_context_melee_stand_1_front_enemy;
    anims[ "scripted_melee_kill_01_back" ] = %vm_sp_context_melee_stand_1_rear_enemy;
    anims[ "scripted_melee_kill_02_left" ] = %vm_sp_context_melee_stand_2_left_enemy;
    anims[ "scripted_melee_kill_02_right" ] = %vm_sp_context_melee_stand_2_right_enemy;
    anims[ "scripted_melee_kill_02_front" ] = %vm_sp_context_melee_stand_2_front_enemy;
    anims[ "scripted_melee_kill_02_back" ] = %vm_sp_context_melee_stand_2_rear_enemy;
    anims[ "scripted_melee_stealth_kill_01_back" ] = %vm_sp_context_melee_stand_1_rear_enemy;
    anims[ "scripted_melee_stealth_kill_01_left" ] = %vm_sp_context_melee_stand_1_left_enemy;
    anims[ "scripted_melee_stealth_kill_01_right" ] = %vm_sp_context_melee_stand_1_right_enemy;
    anims[ "scripted_melee_stealth_kill_01_front" ] = %vm_sp_context_melee_stand_1_front_enemy;
    
    foreach ( key, animasset in anims )
    {
        level.scr_anim[ "generic" ][ key ] = animasset;
        scripts\common\anim::addnotetrack_customfunction( "generic", "cm_death", &function_d8f48ab0dfd5ef51, key );
        scripts\common\anim::addnotetrack_customfunction( "generic", "cm_ragdoll", &function_91c24157247ef2fc, key );
        scripts\common\anim::addnotetrack_customfunction( "generic", "cm_fx", &function_497a27b31d43d6af, key );
    }
}

#using_animtree( "script_model" );

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0x860
// Size: 0x2c7
function function_b0c99390cdb7edd5()
{
    level.scr_animtree[ "scripted_melee_player_rig" ] = #animtree;
    
    if ( !isdefined( level.scr_model ) || !isdefined( level.scr_model[ "scripted_melee_player_rig" ] ) )
    {
        level.scr_model[ "scripted_melee_player_rig" ] = "viewhands_base_iw8";
    }
    
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_01_left" ] = %vm_sp_context_melee_stand_1_left_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_01_right" ] = %vm_sp_context_melee_stand_1_right_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_01_front" ] = %vm_sp_context_melee_stand_1_front_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_01_back" ] = %vm_sp_context_melee_stand_1_rear_player;
    utility::function_7a5a6498179656fc( "scripted_melee_kill_01_left", "left", &function_7e355057c5e32c56 );
    utility::function_7a5a6498179656fc( "scripted_melee_kill_01_right", "right", &function_7e355057c5e32c56 );
    utility::function_7a5a6498179656fc( "scripted_melee_kill_01_front", "front", &function_7e355057c5e32c56 );
    utility::function_7a5a6498179656fc( "scripted_melee_kill_01_back", "back", &function_7e355057c5e32c56 );
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_02_left" ] = %vm_sp_context_melee_stand_2_left_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_02_right" ] = %vm_sp_context_melee_stand_2_right_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_02_front" ] = %vm_sp_context_melee_stand_2_front_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_kill_02_back" ] = %vm_sp_context_melee_stand_2_rear_player;
    utility::function_7a5a6498179656fc( "scripted_melee_kill_02_left", "left", &function_7e355057c5e32c56 );
    utility::function_7a5a6498179656fc( "scripted_melee_kill_02_right", "right", &function_7e355057c5e32c56 );
    utility::function_7a5a6498179656fc( "scripted_melee_kill_02_front", "front", &function_7e355057c5e32c56 );
    utility::function_7a5a6498179656fc( "scripted_melee_kill_02_back", "back", &function_7e355057c5e32c56 );
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_stealth_kill_01_left" ] = %vm_sp_context_melee_stand_1_left_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_stealth_kill_01_right" ] = %vm_sp_context_melee_stand_1_right_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_stealth_kill_01_front" ] = %vm_sp_context_melee_stand_1_front_player;
    level.scr_anim[ "scripted_melee_player_rig" ][ "scripted_melee_stealth_kill_01_back" ] = %vm_sp_context_melee_stand_1_rear_player;
    utility::function_7a5a6498179656fc( "scripted_melee_stealth_kill_01_left", "left", &function_9d501e35f4127f85 );
    utility::function_7a5a6498179656fc( "scripted_melee_stealth_kill_01_right", "right", &function_9d501e35f4127f85 );
    utility::function_7a5a6498179656fc( "scripted_melee_stealth_kill_01_front", "front", &function_9d501e35f4127f85 );
    utility::function_7a5a6498179656fc( "scripted_melee_stealth_kill_01_back", "back", &function_9d501e35f4127f85 );
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 3
// Checksum 0x0, Offset: 0xb2f
// Size: 0x8b
function spawn_anim_model( animname, origin, angles )
{
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    model = spawn( "script_model", origin );
    model.animname = animname;
    model useanimtree( #animtree );
    model setmodel( level.scr_model[ model.animname ] );
    
    if ( isdefined( angles ) )
    {
        model.angles = angles;
    }
    
    return model;
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0xbc3
// Size: 0x40
function function_65bbb083561fa648()
{
    self.scripted_melee_player_rig = spawn_anim_model( "scripted_melee_player_rig", self.origin, self.angles );
    self.scripted_melee_player_rig scripts\common\anim::function_1cb661b457551a3( 1, self, 0.35 );
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0xc0b
// Size: 0x34
function enable_victims()
{
    possible_victims = getaiarray( "axis" );
    scripts\engine\utility::array_call( possible_victims, &function_f23f106f8976771d );
    
    /#
        scripts\engine\utility::array_thread( possible_victims, &function_7eaecc1fbfd9ad25, self );
    #/
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0xc47
// Size: 0x2
function function_b3cab4bbbd2f27bf()
{
    
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0xc51
// Size: 0x2
function function_53bc249de0d47b05()
{
    
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 1
// Checksum 0x0, Offset: 0xc5b
// Size: 0xb
function function_91c24157247ef2fc( guy )
{
    
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 0
// Checksum 0x0, Offset: 0xc6e
// Size: 0x8
function function_63cac0421acbe53c()
{
    return rules_default();
}

// Namespace namespace_73353db38b27e9b2 / namespace_54765065ecffdfad
// Params 1
// Checksum 0x0, Offset: 0xc7f
// Size: 0xb
function function_5e2b19fd9204a302( bool )
{
    
}

