#using script_22046726288e720;
#using script_41717273993f125d;
#using script_4ef07b90e2aeb7fe;
#using script_542eea78f24270bb;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_civilian_us_male;

// Namespace jup_civilian_us_male / namespace_839a3a76c0f4c4be
// Params 0
// Checksum 0x0, Offset: 0x20d
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_civilian_us_male" );
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

// Namespace jup_civilian_us_male / namespace_839a3a76c0f4c4be
// Params 0
// Checksum 0x0, Offset: 0x38d
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

// Namespace jup_civilian_us_male / namespace_839a3a76c0f4c4be
// Params 0
// Checksum 0x0, Offset: 0x3eb
// Size: 0x83
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_b17c80085b328f1::main();
        case 1:
            return namespace_b17c50085b32258::main();
        case 2:
            return namespace_b17c60085b3248b::main();
        case 3:
            return namespace_b17cb0085b32f8a::main();
    }
}

// Namespace jup_civilian_us_male / namespace_839a3a76c0f4c4be
// Params 0
// Checksum 0x0, Offset: 0x476
// Size: 0xe
function spawner()
{
    self setspawnerteam( "neutral" );
}

// Namespace jup_civilian_us_male / namespace_839a3a76c0f4c4be
// Params 1
// Checksum 0x0, Offset: 0x48c
// Size: 0x35
function precache( classname )
{
    namespace_b17c80085b328f1::precache_sp();
    namespace_b17c50085b32258::precache_sp();
    namespace_b17c60085b3248b::precache_sp();
    namespace_b17cb0085b32f8a::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

