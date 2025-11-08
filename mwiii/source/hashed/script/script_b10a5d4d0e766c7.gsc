#using script_1c1e81a5e2605820;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;

#namespace jup_ob_void_crystal_healthbar;

// Namespace jup_ob_void_crystal_healthbar / namespace_14cbad25b14f8ea5
// Params 0
// Checksum 0x0, Offset: 0x15a
// Size: 0x145
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_void_crystal_healthbar" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_7dd4801342ba19c4" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 100;
    self.maxhealth = 100;
    self.behaviortreeasset = "capture_bot";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "capture_bot";
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

// Namespace jup_ob_void_crystal_healthbar / namespace_14cbad25b14f8ea5
// Params 0
// Checksum 0x0, Offset: 0x2a7
// Size: 0x57
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

// Namespace jup_ob_void_crystal_healthbar / namespace_14cbad25b14f8ea5
// Params 0
// Checksum 0x0, Offset: 0x306
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_d319e5f1619c3ed6::main();
}

// Namespace jup_ob_void_crystal_healthbar / namespace_14cbad25b14f8ea5
// Params 0
// Checksum 0x0, Offset: 0x317
// Size: 0xc7
function precache()
{
    agent_type = "actor_jup_ob_void_crystal_healthbar";
    
    if ( !isdefined( level.agent_definition ) )
    {
        level.agent_definition = [];
    }
    
    if ( !isdefined( level.agent_definition[ agent_type ] ) )
    {
        level.agent_definition[ agent_type ] = [];
        level.agent_definition[ agent_type ][ "team" ] = "axis";
        level.agent_definition[ agent_type ][ "setup_func" ] = &main;
        level.agent_definition[ agent_type ][ "setup_model_func" ] = &setup_model;
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_7dd4801342ba19c4" );
        namespace_d319e5f1619c3ed6::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
}

