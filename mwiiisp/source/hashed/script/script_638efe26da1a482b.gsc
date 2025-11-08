#using script_4b5426386821012b;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\anim\init;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;

#namespace jup_enemy_hijack_male_flight_attendant_jump;

// Namespace jup_enemy_hijack_male_flight_attendant_jump / namespace_8edb03e5132b9525
// Params 0
// Checksum 0x0, Offset: 0x17b
// Size: 0x17d
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_hijack_male_flight_attendant_jump" );
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    self.secondaryweapon = nullweapon();
    self.sidearm = nullweapon();
    self.behaviortreeasset = "enemy_combatant";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.usescriptedweapon = 0;
    self.scriptedweaponclassprimary = "none";
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

// Namespace jup_enemy_hijack_male_flight_attendant_jump / namespace_8edb03e5132b9525
// Params 0
// Checksum 0x0, Offset: 0x300
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

// Namespace jup_enemy_hijack_male_flight_attendant_jump / namespace_8edb03e5132b9525
// Params 0
// Checksum 0x0, Offset: 0x35e
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_d8675b24c5070b19::main();
}

// Namespace jup_enemy_hijack_male_flight_attendant_jump / namespace_8edb03e5132b9525
// Params 0
// Checksum 0x0, Offset: 0x36f
// Size: 0xe
function spawner()
{
    self setspawnerteam( "axis" );
}

// Namespace jup_enemy_hijack_male_flight_attendant_jump / namespace_8edb03e5132b9525
// Params 1
// Checksum 0x0, Offset: 0x385
// Size: 0x2b
function precache( classname )
{
    namespace_d8675b24c5070b19::precache_sp();
    precacheitem( "iw9_pi_papa220_sp" );
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

