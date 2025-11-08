#using character\c_jup_sp_enemy_kastovsoldier_01;
#using character\c_jup_sp_enemy_kastovsoldier_04;
#using script_7bb0b5b316a6e416;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_enemy_rus_kas_pistol;

// Namespace jup_enemy_rus_kas_pistol / namespace_6b2a2b4e199272cb
// Params 0
// Checksum 0x0, Offset: 0x20f
// Size: 0x183
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_rus_kas_pistol" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "pistol";
    self.weapon = makeweapon( "iw9_pi_papa220_sp" );
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

// Namespace jup_enemy_rus_kas_pistol / namespace_6b2a2b4e199272cb
// Params 0
// Checksum 0x0, Offset: 0x39a
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

// Namespace jup_enemy_rus_kas_pistol / namespace_6b2a2b4e199272cb
// Params 0
// Checksum 0x0, Offset: 0x3f8
// Size: 0x6d
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return character\c_jup_sp_enemy_kastovsoldier_04::main();
        case 1:
            return character\c_jup_sp_enemy_kastovsoldier_01::main();
        case 2:
            return namespace_340b358275ffbc2c::main();
    }
}

// Namespace jup_enemy_rus_kas_pistol / namespace_6b2a2b4e199272cb
// Params 0
// Checksum 0x0, Offset: 0x46d
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_rus_kas_pistol / namespace_6b2a2b4e199272cb
// Params 1
// Checksum 0x0, Offset: 0x483
// Size: 0x44
function precache( classname )
{
    character\c_jup_sp_enemy_kastovsoldier_04::precache_sp();
    character\c_jup_sp_enemy_kastovsoldier_01::precache_sp();
    namespace_340b358275ffbc2c::precache_sp();
    precacheitem( "iw9_pi_papa220_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

