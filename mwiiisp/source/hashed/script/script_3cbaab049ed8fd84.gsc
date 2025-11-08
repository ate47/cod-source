#using character\character_london_police_hivis;
#using script_76ea83593360a4a6;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;

#namespace jup_ally_uk_police_smg;

// Namespace jup_ally_uk_police_smg / namespace_18c0a051bc8328dc
// Params 0
// Checksum 0x0, Offset: 0x244
// Size: 0x1a4
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ally_uk_police_smg" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = scripts\code\ai::create_weapon_in_script( "" );
    self.sidearm = scripts\code\ai::create_weapon_in_script( "jup_cp24_pi_glima21_sp", "sidearm" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 1;
    self.scriptedweaponclassprimary = "smg";
    self.weapon = scripts\code\ai::create_weapon_in_script( [ "iw9_sm_mpapa5_sp", "jup_jp04_sm_lwhiskey_sp" ] );
    setup_model();
    scripts\anim\init::firstinit();
    self.a = spawnstruct();
    scripts\asm\asm::asm_init_blackboard();
    scripts\aitypes\bt_util::bt_init();
    assertex( isdefined( self.animationarchetype ) && self.animationarchetype != "", "Aitype " + self.classname + " does not have the animation archetype defined on the asset." );
    assertex( isdefined( self.asmasset ) && self.asmasset != "", "Aitype " + self.classname + " does not have the animation state machine defined on the asset." );
    self.defaultasm = self.asmasset;
    scripts\asm\asm_sp::asm_init( self.asmasset, self.animationarchetype );
    scripts\common\ai::ai_init();
}

// Namespace jup_ally_uk_police_smg / namespace_18c0a051bc8328dc
// Params 0
// Checksum 0x0, Offset: 0x3f0
// Size: 0x56
function setup_model()
{
    characterlistname = isdefined( self.characterlistname ) ? self.characterlistname : "default";
    
    switch ( characterlistname )
    {
        case #"hash_7038dec66d8275be":
        default:
            return function_9ac26a51c94ccf52();
    }
}

// Namespace jup_ally_uk_police_smg / namespace_18c0a051bc8328dc
// Params 0
// Checksum 0x0, Offset: 0x44e
// Size: 0x57
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_f5ea04ef71b9b35a::main();
        case 1:
            return character\character_london_police_hivis::main();
    }
}

// Namespace jup_ally_uk_police_smg / namespace_18c0a051bc8328dc
// Params 0
// Checksum 0x0, Offset: 0x4ad
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace jup_ally_uk_police_smg / namespace_18c0a051bc8328dc
// Params 1
// Checksum 0x0, Offset: 0x4c3
// Size: 0x53
function precache( classname )
{
    namespace_f5ea04ef71b9b35a::precache_sp();
    character\character_london_police_hivis::precache_sp();
    precacheitem( "iw9_sm_mpapa5_sp" );
    precacheitem( "jup_jp04_sm_lwhiskey_sp" );
    precacheitem( "jup_cp24_pi_glima21_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

