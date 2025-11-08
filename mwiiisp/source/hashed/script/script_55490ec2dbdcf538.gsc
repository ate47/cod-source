#using character\c_jup_sp_ally_sas_urban;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;

#namespace jup_ally_sas_urban_ar_surge;

// Namespace jup_ally_sas_urban_ar_surge / namespace_a1e78be270c7c24e
// Params 0
// Checksum 0x0, Offset: 0x1c7
// Size: 0x1ad
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ally_sas_urban_ar_surge" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = scripts\code\ai::create_weapon_in_script( "" );
    self.sidearm = scripts\code\ai::create_weapon_in_script( "jup_cp24_pi_glima21_sp", "sidearm" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 1;
    self.scriptedweaponclassprimary = "ar";
    self.weapon = scripts\code\ai::create_weapon_in_script( [ "iw9_ar_mike4_sp", "iw9_ar_golf3_sp", "iw9_ar_mcbravo_sp" ] );
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

// Namespace jup_ally_sas_urban_ar_surge / namespace_a1e78be270c7c24e
// Params 0
// Checksum 0x0, Offset: 0x37c
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

// Namespace jup_ally_sas_urban_ar_surge / namespace_a1e78be270c7c24e
// Params 0
// Checksum 0x0, Offset: 0x3da
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\c_jup_sp_ally_sas_urban::main();
}

// Namespace jup_ally_sas_urban_ar_surge / namespace_a1e78be270c7c24e
// Params 0
// Checksum 0x0, Offset: 0x3eb
// Size: 0xe
function spawner()
{
    self setspawnerteam( "allies" );
}

// Namespace jup_ally_sas_urban_ar_surge / namespace_a1e78be270c7c24e
// Params 1
// Checksum 0x0, Offset: 0x401
// Size: 0x57
function precache( classname )
{
    character\c_jup_sp_ally_sas_urban::precache_sp();
    precacheitem( "iw9_ar_mike4_sp" );
    precacheitem( "iw9_ar_golf3_sp" );
    precacheitem( "iw9_ar_mcbravo_sp" );
    precacheitem( "jup_cp24_pi_glima21_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

