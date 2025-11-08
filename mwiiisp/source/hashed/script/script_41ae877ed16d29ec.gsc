#using character\c_jup_sp_enemy_pmc_elsniper_01;
#using character\c_jup_sp_enemy_pmc_elsniper_02;
#using character\c_jup_sp_enemy_pmc_sniper_01;
#using character\c_jup_sp_enemy_pmc_sniper_02;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\cp\cp_weapon;
#using scripts\cp_mp\agents\agent_init;

#namespace jup_enemy_cp_sniper_tier1_rus_pmc;

// Namespace jup_enemy_cp_sniper_tier1_rus_pmc / namespace_dd7a54320753f752
// Params 0
// Checksum 0x0, Offset: 0x2f4
// Size: 0x228
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_enemy_cp_sniper_tier1_rus_pmc" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_d4c1780d6bc141a" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 150;
    self.maxhealth = 150;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    
    switch ( scripts\code\character::get_random_weapon( 2 ) )
    {
        case 0:
            primaryweaponhash = "iw9_sn_mromeo_mp, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 1:
            primaryweaponhash = "jup_jp13_dm_svictork_mp, [ dmscope01 ], none, none";
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

// Namespace jup_enemy_cp_sniper_tier1_rus_pmc / namespace_dd7a54320753f752
// Params 0
// Checksum 0x0, Offset: 0x524
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

// Namespace jup_enemy_cp_sniper_tier1_rus_pmc / namespace_dd7a54320753f752
// Params 0
// Checksum 0x0, Offset: 0x582
// Size: 0x83
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "self.characterSelectionIndex has not been set, it should have been set in Agent_Spawn() for mp and InitSpawn() in SP in code" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return character\c_jup_sp_enemy_pmc_sniper_01::main();
        case 1:
            return character\c_jup_sp_enemy_pmc_sniper_02::main();
        case 2:
            return character\c_jup_sp_enemy_pmc_elsniper_01::main();
        case 3:
            return character\c_jup_sp_enemy_pmc_elsniper_02::main();
    }
}

// Namespace jup_enemy_cp_sniper_tier1_rus_pmc / namespace_dd7a54320753f752
// Params 0
// Checksum 0x0, Offset: 0x60d
// Size: 0xe3
function precache()
{
    agent_type = "actor_jup_enemy_cp_sniper_tier1_rus_pmc";
    
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
        character\c_jup_sp_enemy_pmc_sniper_01::precache_cpmp();
        character\c_jup_sp_enemy_pmc_sniper_02::precache_cpmp();
        character\c_jup_sp_enemy_pmc_elsniper_01::precache_cpmp();
        character\c_jup_sp_enemy_pmc_elsniper_02::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_enemy_cp_sniper_tier1_rus_pmc / namespace_dd7a54320753f752
// Params 0
// Checksum 0x0, Offset: 0x6f8
// Size: 0x197
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
    
    var_5576d3be590a9a64 = "iw9_sn_mromeo_mp, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] = scripts\cp\cp_weapon::function_e83615f8a92e4378( "iw9_sn_mromeo_mp", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576d6be590aa0fd = "jup_jp13_dm_svictork_mp, [ dmscope01 ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] = scripts\cp\cp_weapon::function_e83615f8a92e4378( "jup_jp13_dm_svictork_mp", [ "dmscope01" ], "none", "none" );
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

