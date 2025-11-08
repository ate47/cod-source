#using script_5a10448e181e50bf;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_ob_enemy_basic_specialforce;

// Namespace jup_ob_enemy_basic_specialforce / namespace_78dd73d96d00c2e6
// Params 0
// Checksum 0x0, Offset: 0x206
// Size: 0x1c9
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_enemy_basic_specialforce" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_1d4f4e2258b5440b" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 300;
    self.maxhealth = 300;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_soldier_base_ob" );
    primaryweaponhash = "iw9_lm_ngolf7, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
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

// Namespace jup_ob_enemy_basic_specialforce / namespace_78dd73d96d00c2e6
// Params 0
// Checksum 0x0, Offset: 0x3d7
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

// Namespace jup_ob_enemy_basic_specialforce / namespace_78dd73d96d00c2e6
// Params 0
// Checksum 0x0, Offset: 0x436
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_4dc2ef625e9b424f::main();
}

// Namespace jup_ob_enemy_basic_specialforce / namespace_78dd73d96d00c2e6
// Params 0
// Checksum 0x0, Offset: 0x447
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_ob_enemy_basic_specialforce";
    
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

// Namespace jup_ob_enemy_basic_specialforce / namespace_78dd73d96d00c2e6
// Params 0
// Checksum 0x0, Offset: 0x51e
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
    
    primaryweaponhash = "iw9_lm_ngolf7, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_lm_ngolf7", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "jup_semtex_ob";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "jup_semtex_ob" );
    }
}

