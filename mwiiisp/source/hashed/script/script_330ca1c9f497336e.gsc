#using script_262d0940593e2304;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_civilian_villain_undercover_konni_surge;

// Namespace jup_civilian_villain_undercover_konni_surge / namespace_1c3b09b1c9b1a214
// Params 0
// Checksum 0x0, Offset: 0x178
// Size: 0x178
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_civilian_villain_undercover_konni_surge" );
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

// Namespace jup_civilian_villain_undercover_konni_surge / namespace_1c3b09b1c9b1a214
// Params 0
// Checksum 0x0, Offset: 0x2f8
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

// Namespace jup_civilian_villain_undercover_konni_surge / namespace_1c3b09b1c9b1a214
// Params 0
// Checksum 0x0, Offset: 0x356
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_62617e5891bca2c6::main();
}

// Namespace jup_civilian_villain_undercover_konni_surge / namespace_1c3b09b1c9b1a214
// Params 0
// Checksum 0x0, Offset: 0x367
// Size: 0xe
function spawner()
{
    self setspawnerteam( "neutral" );
}

// Namespace jup_civilian_villain_undercover_konni_surge / namespace_1c3b09b1c9b1a214
// Params 1
// Checksum 0x0, Offset: 0x37d
// Size: 0x20
function precache( classname )
{
    namespace_62617e5891bca2c6::precache_sp();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

