#using script_178f1d1fdf098b64;
#using script_17a21377ef58706f;
#using script_1851a30a104541b5;
#using script_23b016678bcbc478;
#using script_5cd5849266f9a962;
#using script_add6d998a47e5a3;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;

#namespace jup_civilian_cp_worker;

// Namespace jup_civilian_cp_worker / namespace_b270365949cbc5a0
// Params 0
// Checksum 0x0, Offset: 0x1cf
// Size: 0x112
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_civilian_cp_worker" );
    self.health = 30;
    self.maxhealth = 30;
    self.behaviortreeasset = "civilian_livingworld";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "civilian_react";
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

// Namespace jup_civilian_cp_worker / namespace_b270365949cbc5a0
// Params 0
// Checksum 0x0, Offset: 0x2e9
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

// Namespace jup_civilian_cp_worker / namespace_b270365949cbc5a0
// Params 0
// Checksum 0x0, Offset: 0x347
// Size: 0xaf
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_589f2ebe09558c9f::main();
        case 1:
            return namespace_d9138d57d088c3ec::main();
        case 2:
            return namespace_bdaa15558ab41cc1::main();
        case 3:
            return namespace_ae7b6c97bb4c0cf6::main();
        case 4:
            return namespace_766be5dccbc43763::main();
        case 5:
            return namespace_229735fa89d2740::main();
    }
}

// Namespace jup_civilian_cp_worker / namespace_b270365949cbc5a0
// Params 0
// Checksum 0x0, Offset: 0x3fe
// Size: 0xc9
function precache()
{
    agent_type = "actor_jup_civilian_cp_worker";
    
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
        namespace_589f2ebe09558c9f::precache_cpmp();
        namespace_d9138d57d088c3ec::precache_cpmp();
        namespace_bdaa15558ab41cc1::precache_cpmp();
        namespace_ae7b6c97bb4c0cf6::precache_cpmp();
        namespace_766be5dccbc43763::precache_cpmp();
        namespace_229735fa89d2740::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::civilian();
}

