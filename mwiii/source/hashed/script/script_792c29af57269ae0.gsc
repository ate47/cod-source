#using script_75a22b42a13d8f69;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\asm\zombie_abom\zombie_abom_asm;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;

#namespace jup_spawner_zombie_abom_hvt;

// Namespace jup_spawner_zombie_abom_hvt / namespace_47c52349b096dcf2
// Params 0
// Checksum 0x0, Offset: 0x1ac
// Size: 0x185
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_spawner_zombie_abom_hvt" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_3e404b511f506ac1" );
    self.subclass = self.subclass_scriptbundle.name;
    self.nameindex = randomintrange( 1, 19 );
    self.health = 6500;
    self.maxhealth = 6500;
    self.behaviortreeasset = "zombie_abom";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "zombie_abom";
    self.ai_eventlist = %"hash_3664c8ba706ec788";
    self.zombieaisetting = "settings_zombie_abom_mega_hvt";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_zombie_abom_mega_hvt" );
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

// Namespace jup_spawner_zombie_abom_hvt / namespace_47c52349b096dcf2
// Params 0
// Checksum 0x0, Offset: 0x339
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

// Namespace jup_spawner_zombie_abom_hvt / namespace_47c52349b096dcf2
// Params 0
// Checksum 0x0, Offset: 0x398
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_b2e5d44be84db3b::main();
}

// Namespace jup_spawner_zombie_abom_hvt / namespace_47c52349b096dcf2
// Params 0
// Checksum 0x0, Offset: 0x3a9
// Size: 0x100
function precache()
{
    agent_type = "actor_jup_spawner_zombie_abom_hvt";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_3e404b511f506ac1" );
        namespace_b2e5d44be84db3b::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::zombie();
    params = spawnstruct();
    params.aisettingsbundle = "aisettings_zombie_abom_mega_hvt";
    params.zombieaisetting = "settings_zombie_abom_mega_hvt";
    scripts\asm\zombie_abom\zombie_abom_asm::precache( params );
}

