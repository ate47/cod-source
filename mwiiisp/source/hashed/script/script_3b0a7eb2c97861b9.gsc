#using script_19321e6a67447f6;
#using script_3ec18722611f80a9;
#using script_66479b95ab7464af;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_enemy_police_riotshield;

// Namespace jup_enemy_police_riotshield / namespace_c8c39900ea4de93b
// Params 0
// Checksum 0x0, Offset: 0x231
// Size: 0x18d
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_police_riotshield" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = makeweapon( "iw9_me_riotshield_sp" );
    self.sidearm = makeweapon( "iw9_pi_papa220_sp" );
    self.behaviortreeasset = "riotshield_sp";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "none";
    self.weapon = makeweapon( "iw9_sm_mpapa5_sp" );
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

// Namespace jup_enemy_police_riotshield / namespace_c8c39900ea4de93b
// Params 0
// Checksum 0x0, Offset: 0x3c6
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

// Namespace jup_enemy_police_riotshield / namespace_c8c39900ea4de93b
// Params 0
// Checksum 0x0, Offset: 0x424
// Size: 0x6d
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_2497ab18badc8843::main();
        case 1:
            return namespace_e588bf567cc8dd84::main();
        case 2:
            return namespace_8488e5413583bb6d::main();
    }
}

// Namespace jup_enemy_police_riotshield / namespace_c8c39900ea4de93b
// Params 0
// Checksum 0x0, Offset: 0x499
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_police_riotshield / namespace_c8c39900ea4de93b
// Params 1
// Checksum 0x0, Offset: 0x4af
// Size: 0x5a
function precache( classname )
{
    namespace_2497ab18badc8843::precache_sp();
    namespace_e588bf567cc8dd84::precache_sp();
    namespace_8488e5413583bb6d::precache_sp();
    precacheitem( "iw9_sm_mpapa5_sp" );
    precacheitem( "iw9_me_riotshield_sp" );
    precacheitem( "iw9_pi_papa220_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

