#using script_5f90183ef2e9b6bf;
#using script_6c63dbe7d4c85e19;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;

#namespace jup_spawner_zombie_deathworm_boss;

// Namespace jup_spawner_zombie_deathworm_boss / namespace_3f03323beafc97cf
// Params 0
// Checksum 0x0, Offset: 0x1b3
// Size: 0x173
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_spawner_zombie_deathworm_boss" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_758d18b1d2815c1" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 1000;
    self.maxhealth = 1000;
    self.behaviortreeasset = "zombie_deathworm";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "zombie_deathworm";
    self.ai_eventlist = %"hash_3664c8ba706ec788";
    self.zombieaisetting = "settings_zombie_deathworm_boss";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_zombie_deathworm" );
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

// Namespace jup_spawner_zombie_deathworm_boss / namespace_3f03323beafc97cf
// Params 0
// Checksum 0x0, Offset: 0x32e
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

// Namespace jup_spawner_zombie_deathworm_boss / namespace_3f03323beafc97cf
// Params 0
// Checksum 0x0, Offset: 0x38d
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_6f61c7a07785bf47::main();
}

// Namespace jup_spawner_zombie_deathworm_boss / namespace_3f03323beafc97cf
// Params 0
// Checksum 0x0, Offset: 0x39e
// Size: 0x100
function precache()
{
    agent_type = "actor_jup_spawner_zombie_deathworm_boss";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_758d18b1d2815c1" );
        namespace_6f61c7a07785bf47::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::zombie();
    params = spawnstruct();
    params.aisettingsbundle = "aisettings_zombie_deathworm";
    params.zombieaisetting = "settings_zombie_deathworm_boss";
    namespace_d4f42bca9e290185::precache( params );
}

