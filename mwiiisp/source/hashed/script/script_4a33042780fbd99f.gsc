#using script_1209bc2be078de5a;
#using script_1cb801833b7ca622;
#using script_2225e5dd573b6c9f;
#using script_266d052164237b89;
#using script_320051c7a9c882d4;
#using script_c053c1e6842f847;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\cp\cp_weapon;
#using scripts\cp_mp\agents\agent_init;

#namespace jup_enemy_cp_ar_tier1_security;

// Namespace jup_enemy_cp_ar_tier1_security / namespace_e191c008ae809c53
// Params 0
// Checksum 0x0, Offset: 0x364
// Size: 0x252
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_cp_ar_tier1_security" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_d4c1780d6bc141a" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 150;
    self.maxhealth = 150;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    
    switch ( scripts\code\character::get_random_weapon( 3 ) )
    {
        case 0:
            primaryweaponhash = "iw9_ar_akilo105_mp, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 1:
            primaryweaponhash = "iw9_ar_akilo_mp, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 2:
            primaryweaponhash = "jup_jp01_ar_golf36_mp, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
    }
    
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    sidearmweaponhash = "jup_cp24_pi_glima21_mp, [ none, none, none, none, none, none ], none, none";
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

// Namespace jup_enemy_cp_ar_tier1_security / namespace_e191c008ae809c53
// Params 0
// Checksum 0x0, Offset: 0x5be
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

// Namespace jup_enemy_cp_ar_tier1_security / namespace_e191c008ae809c53
// Params 0
// Checksum 0x0, Offset: 0x61c
// Size: 0xaf
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_f925426ee1178ad1::main();
        case 1:
            return namespace_47bc9d906c60110::main();
        case 2:
            return namespace_f9253f6ee1178438::main();
        case 3:
            return namespace_46ed9d906b80fbb::main();
        case 4:
            return namespace_f925406ee117866b::main();
        case 5:
            return namespace_472bdd906bbc7fe::main();
    }
}

// Namespace jup_enemy_cp_ar_tier1_security / namespace_e191c008ae809c53
// Params 0
// Checksum 0x0, Offset: 0x6d3
// Size: 0xf1
function precache()
{
    agent_type = "actor_jup_enemy_cp_ar_tier1_security";
    
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
        namespace_f925426ee1178ad1::precache_cpmp();
        namespace_47bc9d906c60110::precache_cpmp();
        namespace_f9253f6ee1178438::precache_cpmp();
        namespace_46ed9d906b80fbb::precache_cpmp();
        namespace_f925406ee117866b::precache_cpmp();
        namespace_472bdd906bbc7fe::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_enemy_cp_ar_tier1_security / namespace_e191c008ae809c53
// Params 0
// Checksum 0x0, Offset: 0x7cc
// Size: 0x23b
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
    
    var_5576d3be590a9a64 = "iw9_ar_akilo105_mp, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] = scripts\cp\cp_weapon::function_e83615f8a92e4378( "iw9_ar_akilo105_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576d6be590aa0fd = "iw9_ar_akilo_mp, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] = scripts\cp\cp_weapon::function_e83615f8a92e4378( "iw9_ar_akilo_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576d5be590a9eca = "jup_jp01_ar_golf36_mp, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d5be590a9eca ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d5be590a9eca ] = scripts\cp\cp_weapon::function_e83615f8a92e4378( "jup_jp01_ar_golf36_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    sidearmweaponhash = "jup_cp24_pi_glima21_mp, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ sidearmweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ sidearmweaponhash ] = scripts\cp\cp_weapon::function_e83615f8a92e4378( "jup_cp24_pi_glima21_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "frag_grenade_mp";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "frag_grenade_mp" );
    }
}

