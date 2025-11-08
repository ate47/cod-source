#using character\c_jup_sp_enemy_kastovsoldier_01;
#using character\c_jup_sp_enemy_kastovsoldier_02;
#using character\c_jup_sp_enemy_kastovsoldier_03;
#using character\c_jup_sp_enemy_kastovsoldier_05;
#using script_7bb0b5b316a6e416;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\character;
#using scripts\common\ai;

#namespace jup_enemy_rus_kas_ar;

// Namespace jup_enemy_rus_kas_ar / namespace_36e58cfeb8638faf
// Params 0
// Checksum 0x0, Offset: 0x248
// Size: 0x1c9
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_rus_kas_ar" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = nullweapon();
    self.sidearm = makeweapon( "iw9_pi_papa220_sp" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "ar";
    
    switch ( scripts\code\character::get_random_weapon( 2 ) )
    {
        case 0:
            self.weapon = makeweapon( "iw9_ar_akilo105_sp" );
            break;
        case 1:
            self.weapon = makeweapon( "iw9_ar_akilo74_sp" );
            break;
    }
    
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

// Namespace jup_enemy_rus_kas_ar / namespace_36e58cfeb8638faf
// Params 0
// Checksum 0x0, Offset: 0x419
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

// Namespace jup_enemy_rus_kas_ar / namespace_36e58cfeb8638faf
// Params 0
// Checksum 0x0, Offset: 0x477
// Size: 0x99
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return character\c_jup_sp_enemy_kastovsoldier_01::main();
        case 1:
            return character\c_jup_sp_enemy_kastovsoldier_02::main();
        case 2:
            return character\c_jup_sp_enemy_kastovsoldier_03::main();
        case 3:
            return character\c_jup_sp_enemy_kastovsoldier_05::main();
        case 4:
            return namespace_340b358275ffbc2c::main();
    }
}

// Namespace jup_enemy_rus_kas_ar / namespace_36e58cfeb8638faf
// Params 0
// Checksum 0x0, Offset: 0x518
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_rus_kas_ar / namespace_36e58cfeb8638faf
// Params 1
// Checksum 0x0, Offset: 0x52e
// Size: 0x68
function precache( classname )
{
    character\c_jup_sp_enemy_kastovsoldier_01::precache_sp();
    character\c_jup_sp_enemy_kastovsoldier_02::precache_sp();
    character\c_jup_sp_enemy_kastovsoldier_03::precache_sp();
    character\c_jup_sp_enemy_kastovsoldier_05::precache_sp();
    namespace_340b358275ffbc2c::precache_sp();
    precacheitem( "iw9_ar_akilo105_sp" );
    precacheitem( "iw9_ar_akilo74_sp" );
    precacheitem( "iw9_pi_papa220_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

