#using script_60d10848dac5bd08;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_ally_hero_price_gunship;

// Namespace jup_ally_hero_price_gunship / namespace_70734d3e51250d16
// Params 0
// Checksum 0x0, Offset: 0x1b9
// Size: 0x187
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ally_hero_price_gunship" );
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "none";
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

// Namespace jup_ally_hero_price_gunship / namespace_70734d3e51250d16
// Params 0
// Checksum 0x0, Offset: 0x348
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

// Namespace jup_ally_hero_price_gunship / namespace_70734d3e51250d16
// Params 0
// Checksum 0x0, Offset: 0x3a6
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_ea38381a787e94a6::main();
}

// Namespace jup_ally_hero_price_gunship / namespace_70734d3e51250d16
// Params 0
// Checksum 0x0, Offset: 0x3b7
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace jup_ally_hero_price_gunship / namespace_70734d3e51250d16
// Params 1
// Checksum 0x0, Offset: 0x3cd
// Size: 0x2b
function precache( classname )
{
    namespace_ea38381a787e94a6::precache_sp();
    precacheitem( "iw9_ar_kilo53_sp_gunship+silencer01_ar" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

