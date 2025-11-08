#using character\c_jup_sp_civ_guard_05;
#using character\c_jup_sp_civ_guard_05a;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\character;
#using scripts\common\ai;

#namespace jup_enemy_gulag_guard_smg_outdoor;

// Namespace jup_enemy_gulag_guard_smg_outdoor / namespace_a4952b5dc7c626bc
// Params 0
// Checksum 0x0, Offset: 0x22c
// Size: 0x1c9
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_gulag_guard_smg_outdoor" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = nullweapon();
    self.sidearm = makeweapon( "iw9_pi_papa220_sp" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "smg";
    
    switch ( scripts\code\character::get_random_weapon( 2 ) )
    {
        case 0:
            self.weapon = makeweapon( "iw9_sm_mpapa5_sp" );
            break;
        case 1:
            self.weapon = makeweapon( "iw9_sm_beta_sp" );
            break;
    }
    
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

// Namespace jup_enemy_gulag_guard_smg_outdoor / namespace_a4952b5dc7c626bc
// Params 0
// Checksum 0x0, Offset: 0x3fd
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

// Namespace jup_enemy_gulag_guard_smg_outdoor / namespace_a4952b5dc7c626bc
// Params 0
// Checksum 0x0, Offset: 0x45b
// Size: 0x57
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return character\c_jup_sp_civ_guard_05::main();
        case 1:
            return character\c_jup_sp_civ_guard_05a::main();
    }
}

// Namespace jup_enemy_gulag_guard_smg_outdoor / namespace_a4952b5dc7c626bc
// Params 0
// Checksum 0x0, Offset: 0x4ba
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_gulag_guard_smg_outdoor / namespace_a4952b5dc7c626bc
// Params 1
// Checksum 0x0, Offset: 0x4d0
// Size: 0x53
function precache( classname )
{
    character\c_jup_sp_civ_guard_05::precache_sp();
    character\c_jup_sp_civ_guard_05a::precache_sp();
    precacheitem( "iw9_sm_mpapa5_sp" );
    precacheitem( "iw9_sm_beta_sp" );
    precacheitem( "iw9_pi_papa220_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

