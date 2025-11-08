#using character\c_jup_sp_hero_gaz_london;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_ally_hero_kyle_surge_a;

// Namespace jup_ally_hero_kyle_surge_a / namespace_5b4ba4bf107fdec2
// Params 0
// Checksum 0x0, Offset: 0x180
// Size: 0x183
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ally_hero_kyle_surge_a" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
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

// Namespace jup_ally_hero_kyle_surge_a / namespace_5b4ba4bf107fdec2
// Params 0
// Checksum 0x0, Offset: 0x30b
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

// Namespace jup_ally_hero_kyle_surge_a / namespace_5b4ba4bf107fdec2
// Params 0
// Checksum 0x0, Offset: 0x369
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\c_jup_sp_hero_gaz_london::main();
}

// Namespace jup_ally_hero_kyle_surge_a / namespace_5b4ba4bf107fdec2
// Params 0
// Checksum 0x0, Offset: 0x37a
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace jup_ally_hero_kyle_surge_a / namespace_5b4ba4bf107fdec2
// Params 1
// Checksum 0x0, Offset: 0x390
// Size: 0x36
function precache( classname )
{
    character\c_jup_sp_hero_gaz_london::precache_sp();
    precacheitem( "iw9_ar_mike4_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

