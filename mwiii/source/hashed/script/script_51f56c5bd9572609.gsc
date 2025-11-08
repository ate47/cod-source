#using script_5a10448e181e50bf;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_ob_enemy_basic_specialforce_short;

// Namespace jup_ob_enemy_basic_specialforce_short / namespace_e4c18026f928ca3b
// Params 0
// Checksum 0x0, Offset: 0x375
// Size: 0x23c
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_enemy_basic_specialforce_short" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_1d4f4e2258b5440b" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 300;
    self.maxhealth = 300;
    self.behaviortreeasset = "soldier_jup_ob";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_soldier_base_ob" );
    
    switch ( scripts\code\character::get_random_weapon( 3 ) )
    {
        case 0:
            primaryweaponhash = "iw9_sm_alpha57, [ iw9_minireddot05_tall, grip_angled01 ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 1:
            primaryweaponhash = "jup_jp02_sm_scharlie3, [ jup_comp_sm_04, jup_jp02_sm_scharlie3_stock_skeltac ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 2:
            primaryweaponhash = "jup_cp01_sh_aromeo410, [ reflex03_tall, grip_angled07 ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
    }
    
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    grenadeweaponhash = "jup_semtex_ob";
    self.grenadeweapon = level.var_67b54180a55f70e1[ grenadeweaponhash ];
    self.grenadeammo = 3;
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

// Namespace jup_ob_enemy_basic_specialforce_short / namespace_e4c18026f928ca3b
// Params 0
// Checksum 0x0, Offset: 0x5b9
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

// Namespace jup_ob_enemy_basic_specialforce_short / namespace_e4c18026f928ca3b
// Params 0
// Checksum 0x0, Offset: 0x618
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_4dc2ef625e9b424f::main();
}

// Namespace jup_ob_enemy_basic_specialforce_short / namespace_e4c18026f928ca3b
// Params 0
// Checksum 0x0, Offset: 0x629
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_ob_enemy_basic_specialforce_short";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_1d4f4e2258b5440b" );
        namespace_4dc2ef625e9b424f::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_ob_enemy_basic_specialforce_short / namespace_e4c18026f928ca3b
// Params 0
// Checksum 0x0, Offset: 0x700
// Size: 0x156
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
    
    var_5576d3be590a9a64 = "iw9_sm_alpha57, [ iw9_minireddot05_tall, grip_angled01 ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_sm_alpha57", [ "iw9_minireddot05_tall", "grip_angled01" ], "none", "none" );
    }
    
    var_5576d6be590aa0fd = "jup_jp02_sm_scharlie3, [ jup_comp_sm_04, jup_jp02_sm_scharlie3_stock_skeltac ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] = scripts\mp\class::function_e83615f8a92e4378( "jup_jp02_sm_scharlie3", [ "jup_comp_sm_04", "jup_jp02_sm_scharlie3_stock_skeltac" ], "none", "none" );
    }
    
    var_5576d5be590a9eca = "jup_cp01_sh_aromeo410, [ reflex03_tall, grip_angled07 ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d5be590a9eca ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d5be590a9eca ] = scripts\mp\class::function_e83615f8a92e4378( "jup_cp01_sh_aromeo410", [ "reflex03_tall", "grip_angled07" ], "none", "none" );
    }
    
    grenadeweaponhash = "jup_semtex_ob";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "jup_semtex_ob" );
    }
}

