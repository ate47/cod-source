#using character\character_hero_price_urban;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace t10_ally_hero;

// Namespace t10_ally_hero / namespace_8b0fa65bdb30feb1
// Params 0
// Checksum 0x0, Offset: 0x19d
// Size: 0x188
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"t10_ally_hero" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = nullweapon();
    self.sidearm = makeweapon( "t10_pi_p13_usugar9_sp" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "none";
    self.weapon = makeweapon( "t10_ar_p01_coslo723_sp" );
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

// Namespace t10_ally_hero / namespace_8b0fa65bdb30feb1
// Params 0
// Checksum 0x0, Offset: 0x32d
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

// Namespace t10_ally_hero / namespace_8b0fa65bdb30feb1
// Params 0
// Checksum 0x0, Offset: 0x38b
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\character_hero_price_urban::main();
}

// Namespace t10_ally_hero / namespace_8b0fa65bdb30feb1
// Params 0
// Checksum 0x0, Offset: 0x39c
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace t10_ally_hero / namespace_8b0fa65bdb30feb1
// Params 1
// Checksum 0x0, Offset: 0x3b2
// Size: 0x41
function precache( classname )
{
    character\character_hero_price_urban::precache_sp();
    precacheitem( "t10_ar_p01_coslo723_sp" );
    precacheitem( "t10_pi_p13_usugar9_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

