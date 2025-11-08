#using character\c_jup_sp_enemy_pmc_soldier_05_alt1;
#using character\c_jup_sp_enemy_pmc_soldier_05_alt2;
#using character\c_jup_sp_enemy_pmc_soldier_05_alt3;
#using character\c_jup_sp_enemy_pmc_soldier_05_masked;
#using script_7d70015cd886923;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_ob_enemy_basic_soldier;

// Namespace jup_ob_enemy_basic_soldier / namespace_7cb4c1cd27a89562
// Params 0
// Checksum 0x0, Offset: 0x225
// Size: 0x1c9
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_enemy_basic_soldier" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_42cf9952fc9aab5b" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 300;
    self.maxhealth = 300;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_soldier_base_ob" );
    primaryweaponhash = "iw9_ar_akilo, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    grenadeweaponhash = "jup_frag_grenade_ob";
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

// Namespace jup_ob_enemy_basic_soldier / namespace_7cb4c1cd27a89562
// Params 0
// Checksum 0x0, Offset: 0x3f6
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

// Namespace jup_ob_enemy_basic_soldier / namespace_7cb4c1cd27a89562
// Params 0
// Checksum 0x0, Offset: 0x455
// Size: 0x99
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "<dev string:x1c>" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        case 0:
            return namespace_d1e0edf5961faf67::main();
        case 1:
            return character\c_jup_sp_enemy_pmc_soldier_05_alt1::main();
        case 2:
            return character\c_jup_sp_enemy_pmc_soldier_05_alt2::main();
        case 3:
            return character\c_jup_sp_enemy_pmc_soldier_05_alt3::main();
        case 4:
            return character\c_jup_sp_enemy_pmc_soldier_05_masked::main();
    }
}

// Namespace jup_ob_enemy_basic_soldier / namespace_7cb4c1cd27a89562
// Params 0
// Checksum 0x0, Offset: 0x4f6
// Size: 0xeb
function precache()
{
    agent_type = "actor_jup_ob_enemy_basic_soldier";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_42cf9952fc9aab5b" );
        namespace_d1e0edf5961faf67::precache_cpmp();
        character\c_jup_sp_enemy_pmc_soldier_05_alt1::precache_cpmp();
        character\c_jup_sp_enemy_pmc_soldier_05_alt2::precache_cpmp();
        character\c_jup_sp_enemy_pmc_soldier_05_alt3::precache_cpmp();
        character\c_jup_sp_enemy_pmc_soldier_05_masked::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_ob_enemy_basic_soldier / namespace_7cb4c1cd27a89562
// Params 0
// Checksum 0x0, Offset: 0x5e9
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
    
    primaryweaponhash = "iw9_ar_akilo, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_ar_akilo", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "jup_frag_grenade_ob";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "jup_frag_grenade_ob" );
    }
}

