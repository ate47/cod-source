#using character\character_hero_hadir_prisoner;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace ally_hero_hadir_prisoner;

// Namespace ally_hero_hadir_prisoner / namespace_dc2221453e53748b
// Params 0
// Checksum 0x0, Offset: 0x16b
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"ally_hero_hadir_prisoner" );
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
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

// Namespace ally_hero_hadir_prisoner / namespace_dc2221453e53748b
// Params 0
// Checksum 0x0, Offset: 0x2eb
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

// Namespace ally_hero_hadir_prisoner / namespace_dc2221453e53748b
// Params 0
// Checksum 0x0, Offset: 0x349
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\character_hero_hadir_prisoner::main();
}

// Namespace ally_hero_hadir_prisoner / namespace_dc2221453e53748b
// Params 0
// Checksum 0x0, Offset: 0x35a
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace ally_hero_hadir_prisoner / namespace_dc2221453e53748b
// Params 1
// Checksum 0x0, Offset: 0x370
// Size: 0x20
function precache( classname )
{
    character\character_hero_hadir_prisoner::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

