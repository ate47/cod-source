#using character\test_character_dog;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace enemy_dog;

// Namespace enemy_dog / namespace_97f493236a958529
// Params 0
// Checksum 0x0, Offset: 0x155
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"enemy_dog" );
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "dog";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "dog";
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

// Namespace enemy_dog / namespace_97f493236a958529
// Params 0
// Checksum 0x0, Offset: 0x2d5
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

// Namespace enemy_dog / namespace_97f493236a958529
// Params 0
// Checksum 0x0, Offset: 0x333
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\test_character_dog::main();
}

// Namespace enemy_dog / namespace_97f493236a958529
// Params 0
// Checksum 0x0, Offset: 0x344
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace enemy_dog / namespace_97f493236a958529
// Params 1
// Checksum 0x0, Offset: 0x35a
// Size: 0x20
function precache( classname )
{
    character\test_character_dog::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::dog();
}

