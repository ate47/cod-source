#using script_3a36ec2fd816d0b5;
#using script_444ff54d1ea34d56;
#using script_4e03c029b67d1e78;
#using script_5397c119e47b7171;
#using script_f6339242520a8ef;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace civilian_ams_female;

// Namespace civilian_ams_female / namespace_36b34c6ff092b9da
// Params 0
// Checksum 0x0, Offset: 0x215
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"civilian_ams_female" );
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

// Namespace civilian_ams_female / namespace_36b34c6ff092b9da
// Params 0
// Checksum 0x0, Offset: 0x395
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

// Namespace civilian_ams_female / namespace_36b34c6ff092b9da
// Params 0
// Checksum 0x0, Offset: 0x3f3
// Size: 0x99
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_16a63fcff8a84b55::main();
        case 1:
            return namespace_16a63ccff8a844bc::main();
        case 2:
            return namespace_16a63dcff8a846ef::main();
        case 3:
            return namespace_16a63acff8a84056::main();
        case 4:
            return namespace_16a63bcff8a84289::main();
    }
}

// Namespace civilian_ams_female / namespace_36b34c6ff092b9da
// Params 0
// Checksum 0x0, Offset: 0x494
// Size: 0xe
function spawner()
{
    self setspawnerteam( "neutral" );
}

// Namespace civilian_ams_female / namespace_36b34c6ff092b9da
// Params 1
// Checksum 0x0, Offset: 0x4aa
// Size: 0x3c
function precache( classname )
{
    namespace_16a63fcff8a84b55::precache_sp();
    namespace_16a63ccff8a844bc::precache_sp();
    namespace_16a63dcff8a846ef::precache_sp();
    namespace_16a63acff8a84056::precache_sp();
    namespace_16a63bcff8a84289::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

