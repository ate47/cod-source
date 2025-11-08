#using script_5549ff519600084a;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace iw9_ally_hero_kyle_marina;

// Namespace iw9_ally_hero_kyle_marina / namespace_86fee72f3e3f8c52
// Params 0
// Checksum 0x0, Offset: 0x191
// Size: 0x188
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"iw9_ally_hero_kyle_marina" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = nullweapon();
    self.sidearm = makeweapon( "iw9_pi_golf17_sp" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "none";
    self.weapon = makeweapon( "iw9_ar_mike4_sp" );
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

// Namespace iw9_ally_hero_kyle_marina / namespace_86fee72f3e3f8c52
// Params 0
// Checksum 0x0, Offset: 0x321
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

// Namespace iw9_ally_hero_kyle_marina / namespace_86fee72f3e3f8c52
// Params 0
// Checksum 0x0, Offset: 0x37f
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_aab7f9598cf2bbf0::main();
}

// Namespace iw9_ally_hero_kyle_marina / namespace_86fee72f3e3f8c52
// Params 0
// Checksum 0x0, Offset: 0x390
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace iw9_ally_hero_kyle_marina / namespace_86fee72f3e3f8c52
// Params 1
// Checksum 0x0, Offset: 0x3a6
// Size: 0x41
function precache( classname )
{
    namespace_aab7f9598cf2bbf0::precache_sp();
    precacheitem( "iw9_ar_mike4_sp" );
    precacheitem( "iw9_pi_golf17_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

