#using character\c_jup_sp_enemy_pmc_capt_02;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_enemy_rus_pmc_unique_tundra_pmc_capt_02;

// Namespace jup_enemy_rus_pmc_unique_tundra_pmc_capt_02 / namespace_c598da9fd403d9ee
// Params 0
// Checksum 0x0, Offset: 0x18f
// Size: 0x1bb
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_rus_pmc_unique_tundra_pmc_capt_02" );
    self.subclass_scriptbundle = getscriptbundle( %"ai_subclass:regular" );
    self.subclass = self.subclass_scriptbundle.name;
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = nullweapon();
    self.sidearm = makeweapon( "iw9_pi_golf18_sp" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "none";
    self.weapon = makeweapon( "iw9_ar_akilo_sp" );
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

// Namespace jup_enemy_rus_pmc_unique_tundra_pmc_capt_02 / namespace_c598da9fd403d9ee
// Params 0
// Checksum 0x0, Offset: 0x352
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

// Namespace jup_enemy_rus_pmc_unique_tundra_pmc_capt_02 / namespace_c598da9fd403d9ee
// Params 0
// Checksum 0x0, Offset: 0x3b0
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\c_jup_sp_enemy_pmc_capt_02::main();
}

// Namespace jup_enemy_rus_pmc_unique_tundra_pmc_capt_02 / namespace_c598da9fd403d9ee
// Params 0
// Checksum 0x0, Offset: 0x3c1
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_rus_pmc_unique_tundra_pmc_capt_02 / namespace_c598da9fd403d9ee
// Params 1
// Checksum 0x0, Offset: 0x3d7
// Size: 0x41
function precache( classname )
{
    character\c_jup_sp_enemy_pmc_capt_02::precache_sp();
    precacheitem( "iw9_ar_akilo_sp" );
    precacheitem( "iw9_pi_golf18_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

