#using script_25b082bd1d3a8288;
#using script_5db293683cd723be;
#using script_63340ecf56fc2dc5;
#using script_7497903323ca8bf3;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_enemy_mp_smg_tier1_pmc;

// Namespace jup_enemy_mp_smg_tier1_pmc / namespace_a01c2db5d9dadc9
// Params 0
// Checksum 0x0, Offset: 0x25f
// Size: 0x1de
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_mp_smg_tier1_pmc" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_d4c1780d6bc141a" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 180;
    self.maxhealth = 180;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    primaryweaponhash = "jup_jp04_sm_umike, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    sidearmweaponhash = "jup_cp24_pi_glima21, [ none, none, none, none, none, none ], none, none";
    self.sidearm = level.var_67b54180a55f70e1[ sidearmweaponhash ];
    grenadeweaponhash = "frag_grenade_mp";
    self.grenadeweapon = level.var_67b54180a55f70e1[ grenadeweaponhash ];
    self.grenadeammo = 2;
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

// Namespace jup_enemy_mp_smg_tier1_pmc / namespace_a01c2db5d9dadc9
// Params 0
// Checksum 0x0, Offset: 0x445
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

// Namespace jup_enemy_mp_smg_tier1_pmc / namespace_a01c2db5d9dadc9
// Params 0
// Checksum 0x0, Offset: 0x4a4
// Size: 0x83
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "<dev string:x1c>" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_5e854f430bfed4ec::main();
        case 1:
            return namespace_8a4a56432c2b8411::main();
        case 2:
            return namespace_79229d431e9ff536::main();
        case 3:
            return namespace_a71aa4434137b8db::main();
    }
}

// Namespace jup_enemy_mp_smg_tier1_pmc / namespace_a01c2db5d9dadc9
// Params 0
// Checksum 0x0, Offset: 0x52f
// Size: 0xe4
function precache()
{
    agent_type = "actor_jup_enemy_mp_smg_tier1_pmc";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_d4c1780d6bc141a" );
        namespace_5e854f430bfed4ec::precache_cpmp();
        namespace_8a4a56432c2b8411::precache_cpmp();
        namespace_79229d431e9ff536::precache_cpmp();
        namespace_a71aa4434137b8db::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_enemy_mp_smg_tier1_pmc / namespace_a01c2db5d9dadc9
// Params 0
// Checksum 0x0, Offset: 0x61b
// Size: 0x14c
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
    
    primaryweaponhash = "jup_jp04_sm_umike, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "jup_jp04_sm_umike", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    sidearmweaponhash = "jup_cp24_pi_glima21, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ sidearmweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ sidearmweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "jup_cp24_pi_glima21", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "frag_grenade_mp";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "frag_grenade_mp" );
    }
}

