#using character\c_jup_sp_enemy_police_kastovia_01;
#using character\c_jup_sp_enemy_police_kastovia_02;
#using character\c_jup_sp_enemy_police_kastovia_03;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\code\ai;
#using scripts\common\ai;

#namespace jup_enemy_police_shotgun;

// Namespace jup_enemy_police_shotgun / namespace_de1a73534a06671a
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0x19b
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_police_shotgun" );
    self.grenadeweapon = makeweapon( "frag" );
    self.grenadeammo = 2;
    self.secondaryweapon = scripts\code\ai::create_weapon_in_script( "" );
    self.sidearm = scripts\code\ai::create_weapon_in_script( "iw9_pi_papa220_sp", "sidearm" );
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 1;
    self.scriptedweaponclassprimary = "shotgun";
    self.weapon = scripts\code\ai::create_weapon_in_script( [ "iw9_sh_mike1014_sp" ] );
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

// Namespace jup_enemy_police_shotgun / namespace_de1a73534a06671a
// Params 0
// Checksum 0x0, Offset: 0x3d6
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

// Namespace jup_enemy_police_shotgun / namespace_de1a73534a06671a
// Params 0
// Checksum 0x0, Offset: 0x434
// Size: 0x6d
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return character\c_jup_sp_enemy_police_kastovia_01::main();
        case 1:
            return character\c_jup_sp_enemy_police_kastovia_02::main();
        case 2:
            return character\c_jup_sp_enemy_police_kastovia_03::main();
    }
}

// Namespace jup_enemy_police_shotgun / namespace_de1a73534a06671a
// Params 0
// Checksum 0x0, Offset: 0x4a9
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_police_shotgun / namespace_de1a73534a06671a
// Params 1
// Checksum 0x0, Offset: 0x4bf
// Size: 0x4f
function precache( classname )
{
    character\c_jup_sp_enemy_police_kastovia_01::precache_sp();
    character\c_jup_sp_enemy_police_kastovia_02::precache_sp();
    character\c_jup_sp_enemy_police_kastovia_03::precache_sp();
    precacheitem( "iw9_sh_mike1014_sp" );
    precacheitem( "iw9_pi_papa220_sp" );
    precacheitem( "frag" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

