#using script_215fca4861459153;
#using script_237703888a7f0623;
#using script_29dd4ac50b1402a3;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;

#namespace jup_spawner_zombie_entity;

// Namespace jup_spawner_zombie_entity / namespace_38999304c73388d7
// Params 0
// Checksum 0x0, Offset: 0x1a6
// Size: 0x173
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_spawner_zombie_entity" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_12810ce01cfd6b1d" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 900;
    self.maxhealth = 900;
    self.behaviortreeasset = "zombie_entity";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "zombie_entity";
    self.ai_eventlist = %"hash_3664c8ba706ec788";
    self.zombieaisetting = "settings_zombie_entity";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_zombie_entity" );
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

// Namespace jup_spawner_zombie_entity / namespace_38999304c73388d7
// Params 0
// Checksum 0x0, Offset: 0x321
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

// Namespace jup_spawner_zombie_entity / namespace_38999304c73388d7
// Params 0
// Checksum 0x0, Offset: 0x380
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_cfa3fb38eb4bf04f::main();
}

// Namespace jup_spawner_zombie_entity / namespace_38999304c73388d7
// Params 0
// Checksum 0x0, Offset: 0x391
// Size: 0x107
function precache()
{
    agent_type = "actor_jup_spawner_zombie_entity";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_12810ce01cfd6b1d" );
        namespace_cfa3fb38eb4bf04f::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::zombie();
    params = spawnstruct();
    params.aisettingsbundle = "aisettings_zombie_entity";
    params.zombieaisetting = "settings_zombie_entity";
    namespace_39c7d29122ccedd3::precache( params );
    namespace_52a1f7dbceafbc17::function_5d77186204f35fd5();
}

