#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;

#namespace civilian_mp_dmz_base;

// Namespace civilian_mp_dmz_base / namespace_fe1b774f444697f1
// Params 0
// Checksum 0x0, Offset: 0x1b2
// Size: 0x120
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"civilian_mp_dmz_base" );
    self.health = 100;
    self.maxhealth = 100;
    self.behaviortreeasset = "civilian_livingworld";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "civilian_react";
    self.zombieaisetting = "settings_zombie_base";
    self.weapon = nullweapon();
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 0;
    setup_model();
    assert( isscriptedagent( self ) );
    assert( isdefined( self.behaviortreeasset ) );
    assert( isdefined( self.asmasset ) );
    self.defaultasm = self.asmasset;
    self.a = spawnstruct();
    scripts\asm\asm::asm_init_blackboard();
    scripts\aitypes\bt_util::bt_init();
    scripts\asm\asm_mp::asm_init( self.asmasset, self.animationarchetype );
    scripts\common\ai::ai_init();
}

// Namespace civilian_mp_dmz_base / namespace_fe1b774f444697f1
// Params 0
// Checksum 0x0, Offset: 0x2da
// Size: 0x56
function setup_model()
{
    characterlistname = isdefined( self.characterlistname ) ? self.characterlistname : "default";
    
    switch ( characterlistname )
    {
        case #"hash_7038dec66d8275be":
        default:
            function_9ac26a51c94ccf52();
            break;
    }
}

// Namespace civilian_mp_dmz_base / namespace_fe1b774f444697f1
// Params 0
// Checksum 0x0, Offset: 0x338
// Size: 0x1a
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
}

// Namespace civilian_mp_dmz_base / namespace_fe1b774f444697f1
// Params 0
// Checksum 0x0, Offset: 0x35a
// Size: 0x9f
function precache()
{
    agent_type = "actor_civilian_mp_dmz_base";
    
    if ( !isdefined( level.agent_definition ) )
    {
        level.agent_definition = [];
    }
    
    if ( !isdefined( level.agent_definition[ agent_type ] ) )
    {
        level.agent_definition[ agent_type ] = [];
        level.agent_definition[ agent_type ][ "team" ] = "neutral";
        level.agent_definition[ agent_type ][ "setup_func" ] = &main;
        level.agent_definition[ agent_type ][ "setup_model_func" ] = &setup_model;
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

