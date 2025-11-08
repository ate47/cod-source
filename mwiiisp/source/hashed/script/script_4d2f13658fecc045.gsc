#using character\c_jup_sp_civ_prisoner_01_b_riot;
#using character\c_jup_sp_civ_prisoner_02_b_riot;
#using character\c_jup_sp_civ_prisoner_03_b_riot;
#using character\c_jup_sp_civ_prisoner_04_b_riot;
#using character\c_jup_sp_civ_prisoner_05_b;
#using character\c_jup_sp_civ_prisoner_05_b_riot;
#using script_183b8850aac75430;
#using script_6a80506405ef95b7;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_civilian_prisoner_all_riot;

// Namespace jup_civilian_prisoner_all_riot / namespace_5d17991e2f7cc8a9
// Params 0
// Checksum 0x0, Offset: 0x22d
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_civilian_prisoner_all_riot" );
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "civilian_livingworld";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "civilian_react";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "none";
    self.weapon = nullweapon();
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

// Namespace jup_civilian_prisoner_all_riot / namespace_5d17991e2f7cc8a9
// Params 0
// Checksum 0x0, Offset: 0x3ad
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

// Namespace jup_civilian_prisoner_all_riot / namespace_5d17991e2f7cc8a9
// Params 0
// Checksum 0x0, Offset: 0x40b
// Size: 0xdb
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return character\c_jup_sp_civ_prisoner_05_b::main();
        case 1:
            return namespace_1a817f9c254350d3::main();
        case 2:
            return character\c_jup_sp_civ_prisoner_01_b_riot::main();
        case 3:
            return character\c_jup_sp_civ_prisoner_02_b_riot::main();
        case 4:
            return namespace_b76f7b946febd424::main();
        case 5:
            return character\c_jup_sp_civ_prisoner_03_b_riot::main();
        case 6:
            return character\c_jup_sp_civ_prisoner_04_b_riot::main();
        case 7:
            return character\c_jup_sp_civ_prisoner_05_b_riot::main();
    }
}

// Namespace jup_civilian_prisoner_all_riot / namespace_5d17991e2f7cc8a9
// Params 0
// Checksum 0x0, Offset: 0x4ee
// Size: 0xe
function spawner()
{
    self setspawnerteam( "neutral" );
}

// Namespace jup_civilian_prisoner_all_riot / namespace_5d17991e2f7cc8a9
// Params 1
// Checksum 0x0, Offset: 0x504
// Size: 0x51
function precache( classname )
{
    character\c_jup_sp_civ_prisoner_05_b::precache_sp();
    namespace_1a817f9c254350d3::precache_sp();
    character\c_jup_sp_civ_prisoner_01_b_riot::precache_sp();
    character\c_jup_sp_civ_prisoner_02_b_riot::precache_sp();
    namespace_b76f7b946febd424::precache_sp();
    character\c_jup_sp_civ_prisoner_03_b_riot::precache_sp();
    character\c_jup_sp_civ_prisoner_04_b_riot::precache_sp();
    character\c_jup_sp_civ_prisoner_05_b_riot::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

