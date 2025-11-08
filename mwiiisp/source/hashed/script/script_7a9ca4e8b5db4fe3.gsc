#using script_41fda187958f06d7;
#using script_4b2ea88fe9be8400;
#using script_4d05aca419295699;
#using script_995218a55dbb757;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_civilian_uk_female;

// Namespace jup_civilian_uk_female / namespace_ed31fb74705c6c0b
// Params 0
// Checksum 0x0, Offset: 0x20d
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_civilian_uk_female" );
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

// Namespace jup_civilian_uk_female / namespace_ed31fb74705c6c0b
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

// Namespace jup_civilian_uk_female / namespace_ed31fb74705c6c0b
// Params 0
// Checksum 0x0, Offset: 0x3eb
// Size: 0x83
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_bf5341fc38c23b91::main();
        case 1:
            return namespace_9ad82f9fcc42321a::main();
        case 2:
            return namespace_9ad8309fcc42344d::main();
        case 3:
            return namespace_9ad82e9fcc422fe7::main();
    }
}

// Namespace jup_civilian_uk_female / namespace_ed31fb74705c6c0b
// Params 0
// Checksum 0x0, Offset: 0x476
// Size: 0xe
function spawner()
{
    self setspawnerteam( "neutral" );
}

// Namespace jup_civilian_uk_female / namespace_ed31fb74705c6c0b
// Params 1
// Checksum 0x0, Offset: 0x48c
// Size: 0x35
function precache( classname )
{
    namespace_bf5341fc38c23b91::precache_sp();
    namespace_9ad82f9fcc42321a::precache_sp();
    namespace_9ad8309fcc42344d::precache_sp();
    namespace_9ad82e9fcc422fe7::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

