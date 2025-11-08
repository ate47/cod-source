#using script_48174f7d8c93c64d;
#using script_55cd32383f94aedd;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_spawner_zombie_hellhound_s3_rr_unlock;

// Namespace jup_spawner_zombie_hellhound_s3_rr_unlock / namespace_cc19dba5c45f4f90
// Params 0
// Checksum 0x0, Offset: 0x234
// Size: 0x1d3
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_spawner_zombie_hellhound_s3_rr_unlock" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_622a98f2c00097f6" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 402;
    self.maxhealth = 402;
    self.behaviortreeasset = "zombie_hellhound";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "zombie_hellhound";
    self.ai_eventlist = %"hash_3664c8ba706ec788";
    self.zombieaisetting = "settings_zombie_hellhound_jup";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_zombie_hellhound" );
    primaryweaponhash = "jup_me_zombie_hellhound, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
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

// Namespace jup_spawner_zombie_hellhound_s3_rr_unlock / namespace_cc19dba5c45f4f90
// Params 0
// Checksum 0x0, Offset: 0x40f
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

// Namespace jup_spawner_zombie_hellhound_s3_rr_unlock / namespace_cc19dba5c45f4f90
// Params 0
// Checksum 0x0, Offset: 0x46e
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_73a6cc0fc98dee97::main();
}

// Namespace jup_spawner_zombie_hellhound_s3_rr_unlock / namespace_cc19dba5c45f4f90
// Params 0
// Checksum 0x0, Offset: 0x47f
// Size: 0x108
function precache()
{
    agent_type = "actor_jup_spawner_zombie_hellhound_s3_rr_unlock";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_622a98f2c00097f6" );
        namespace_73a6cc0fc98dee97::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::zombie();
    params = spawnstruct();
    params.aisettingsbundle = "aisettings_zombie_hellhound";
    params.zombieaisetting = "settings_zombie_hellhound_jup";
    namespace_66aa06755cfb5bdd::precache( params );
    thread setup_weapons();
}

// Namespace jup_spawner_zombie_hellhound_s3_rr_unlock / namespace_cc19dba5c45f4f90
// Params 0
// Checksum 0x0, Offset: 0x58f
// Size: 0xa2
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
    
    primaryweaponhash = "jup_me_zombie_hellhound, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "jup_me_zombie_hellhound", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
}

