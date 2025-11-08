#using script_69ef49386c3ec5c5;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_civilian_us_male_injured;

// Namespace jup_civilian_us_male_injured / namespace_f68c0494d904b7f0
// Params 0
// Checksum 0x0, Offset: 0x1e9
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_civilian_us_male_injured" );
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "civilian";
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

// Namespace jup_civilian_us_male_injured / namespace_f68c0494d904b7f0
// Params 0
// Checksum 0x0, Offset: 0x369
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

// Namespace jup_civilian_us_male_injured / namespace_f68c0494d904b7f0
// Params 0
// Checksum 0x0, Offset: 0x3c7
// Size: 0x41
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        default:
            return namespace_eec4707eff28794f::main();
    }
}

// Namespace jup_civilian_us_male_injured / namespace_f68c0494d904b7f0
// Params 0
// Checksum 0x0, Offset: 0x410
// Size: 0xe
function spawner()
{
    self setspawnerteam( "neutral" );
}

// Namespace jup_civilian_us_male_injured / namespace_f68c0494d904b7f0
// Params 1
// Checksum 0x0, Offset: 0x426
// Size: 0x20
function precache( classname )
{
    namespace_eec4707eff28794f::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

