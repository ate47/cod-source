#using script_11ef10bf1824d82b;
#using script_7e371192fcd4d46d;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_spawner_zombie_base_abom_crawler_hvt;

// Namespace jup_spawner_zombie_base_abom_crawler_hvt / namespace_266a52c650e616e7
// Params 0
// Checksum 0x0, Offset: 0x259
// Size: 0x1e6
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_spawner_zombie_base_abom_crawler_hvt" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_65f1de30c030c355" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 100;
    self.maxhealth = 100;
    self.behaviortreeasset = "zombie_base";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "zombie_base";
    self.ai_eventlist = %"hash_3664c8ba706ec788";
    self.zombieaisetting = "settings_zombie_base_abom_crawler_hvt";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_zombie_base_abom_crawler_hvt" );
    primaryweaponhash = "jup_me_zombie_melee, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    grenadeweaponhash = "jup_zombie_ranged_attack_mp";
    self.grenadeweapon = level.var_67b54180a55f70e1[ grenadeweaponhash ];
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

// Namespace jup_spawner_zombie_base_abom_crawler_hvt / namespace_266a52c650e616e7
// Params 0
// Checksum 0x0, Offset: 0x447
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

// Namespace jup_spawner_zombie_base_abom_crawler_hvt / namespace_266a52c650e616e7
// Params 0
// Checksum 0x0, Offset: 0x4a6
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_1f5a670849f389cf::main();
}

// Namespace jup_spawner_zombie_base_abom_crawler_hvt / namespace_266a52c650e616e7
// Params 0
// Checksum 0x0, Offset: 0x4b7
// Size: 0xd6
function precache()
{
    agent_type = "actor_jup_spawner_zombie_base_abom_crawler_hvt";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_65f1de30c030c355" );
        namespace_1f5a670849f389cf::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::zombie();
    namespace_757f0fc2fc31608f::init_zombie_base_abom_crawler();
    thread setup_weapons();
}

// Namespace jup_spawner_zombie_base_abom_crawler_hvt / namespace_266a52c650e616e7
// Params 0
// Checksum 0x0, Offset: 0x595
// Size: 0xd6
function setup_weapons()
{
    while ( !isdefined( level.weaponmapdata ) )
    {
        waitframe();
    }
    
    if ( !isdefined( level.var_67b54180a55f70e1 ) )
    {
        level.var_67b54180a55f70e1 = [];
    }
    
    primaryweaponhash = "jup_me_zombie_melee, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "jup_me_zombie_melee", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "jup_zombie_ranged_attack_mp";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "jup_zombie_ranged_attack_mp" );
    }
}

