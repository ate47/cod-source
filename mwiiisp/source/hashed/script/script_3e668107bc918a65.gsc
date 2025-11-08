#using script_24f7cf9a83f6609f;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_ally_hero_farah_gunship;

// Namespace jup_ally_hero_farah_gunship / namespace_858ab923b29f1a7
// Params 0
// Checksum 0x0, Offset: 0x1b7
// Size: 0x187
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ally_hero_farah_gunship" );
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "ar";
    self.weapon = makeweapon( "iw9_ar_kilo53_sp_gunship", [ "silencer01_ar" ] );
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

// Namespace jup_ally_hero_farah_gunship / namespace_858ab923b29f1a7
// Params 0
// Checksum 0x0, Offset: 0x346
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

// Namespace jup_ally_hero_farah_gunship / namespace_858ab923b29f1a7
// Params 0
// Checksum 0x0, Offset: 0x3a4
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_4d4522f4e932db21::main();
}

// Namespace jup_ally_hero_farah_gunship / namespace_858ab923b29f1a7
// Params 0
// Checksum 0x0, Offset: 0x3b5
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace jup_ally_hero_farah_gunship / namespace_858ab923b29f1a7
// Params 1
// Checksum 0x0, Offset: 0x3cb
// Size: 0x2b
function precache( classname )
{
    namespace_4d4522f4e932db21::precache_sp();
    precacheitem( "iw9_ar_kilo53_sp_gunship+silencer01_ar" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

