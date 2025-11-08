#using script_33384ccdade0dfd6;
#using script_6e42cc63d3c6ae91;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_enemy_gulag_guard_riotshield;

// Namespace jup_enemy_gulag_guard_riotshield / namespace_4a8534579002eda9
// Params 0
// Checksum 0x0, Offset: 0x22d
// Size: 0x18d
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_gulag_guard_riotshield" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = makeweapon( "iw9_me_riotshield_sp" );
    self.sidearm = makeweapon( "jup_jp12_pi_mike93_sp" );
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

// Namespace jup_enemy_gulag_guard_riotshield / namespace_4a8534579002eda9
// Params 0
// Checksum 0x0, Offset: 0x3c2
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

// Namespace jup_enemy_gulag_guard_riotshield / namespace_4a8534579002eda9
// Params 0
// Checksum 0x0, Offset: 0x420
// Size: 0x57
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_76215cc2b0590dd4::main();
        case 1:
            return namespace_70d1c1b097a8bd29::main();
    }
}

// Namespace jup_enemy_gulag_guard_riotshield / namespace_4a8534579002eda9
// Params 0
// Checksum 0x0, Offset: 0x47f
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_gulag_guard_riotshield / namespace_4a8534579002eda9
// Params 1
// Checksum 0x0, Offset: 0x495
// Size: 0x53
function precache( classname )
{
    namespace_76215cc2b0590dd4::precache_sp();
    namespace_70d1c1b097a8bd29::precache_sp();
    precacheitem( "iw9_sm_mpapa5_sp" );
    precacheitem( "iw9_me_riotshield_sp" );
    precacheitem( "jup_jp12_pi_mike93_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

