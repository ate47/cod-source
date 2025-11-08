#using character\c_jup_sp_ally_redshirt_01;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;

#namespace jup_ally_sas_bravo_ar;

// Namespace jup_ally_sas_bravo_ar / namespace_7e7a2e3862e88797
// Params 0
// Checksum 0x0, Offset: 0x1a0
// Size: 0x19b
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ally_sas_bravo_ar" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = scripts\code\ai::create_weapon_in_script( "" );
    self.sidearm = scripts\code\ai::create_weapon_in_script( "iw9_pi_papa220_sp", "sidearm" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 1;
    self.scriptedweaponclassprimary = "ar";
    self.weapon = scripts\code\ai::create_weapon_in_script( [ "iw9_ar_mike4_sp" ] );
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

// Namespace jup_ally_sas_bravo_ar / namespace_7e7a2e3862e88797
// Params 0
// Checksum 0x0, Offset: 0x343
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

// Namespace jup_ally_sas_bravo_ar / namespace_7e7a2e3862e88797
// Params 0
// Checksum 0x0, Offset: 0x3a1
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\c_jup_sp_ally_redshirt_01::main();
}

// Namespace jup_ally_sas_bravo_ar / namespace_7e7a2e3862e88797
// Params 0
// Checksum 0x0, Offset: 0x3b2
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace jup_ally_sas_bravo_ar / namespace_7e7a2e3862e88797
// Params 1
// Checksum 0x0, Offset: 0x3c8
// Size: 0x41
function precache( classname )
{
    character\c_jup_sp_ally_redshirt_01::precache_sp();
    precacheitem( "iw9_ar_mike4_sp" );
    precacheitem( "iw9_pi_papa220_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

