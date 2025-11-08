#using script_2caf2f6af8f1a05b;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_ob_warlord_all_for_one;

// Namespace jup_ob_warlord_all_for_one / namespace_24ee24c6ec60bf84
// Params 0
// Checksum 0x0, Offset: 0x281
// Size: 0x1f9
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_warlord_all_for_one" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_275c0cfece92a857" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 2880;
    self.maxhealth = 2880;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    self.zombieaisetting = "settings_warlord_all_for_one";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_warlord_base" );
    primaryweaponhash = "iw9_ar_akilo, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    sidearmweaponhash = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";
    self.sidearm = level.var_67b54180a55f70e1[ sidearmweaponhash ];
    grenadeweaponhash = "thermobaric_grenade_jup_mp";
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

// Namespace jup_ob_warlord_all_for_one / namespace_24ee24c6ec60bf84
// Params 0
// Checksum 0x0, Offset: 0x482
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

// Namespace jup_ob_warlord_all_for_one / namespace_24ee24c6ec60bf84
// Params 0
// Checksum 0x0, Offset: 0x4e1
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_f78bfb3834febfad::main();
}

// Namespace jup_ob_warlord_all_for_one / namespace_24ee24c6ec60bf84
// Params 0
// Checksum 0x0, Offset: 0x4f2
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_ob_warlord_all_for_one";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_275c0cfece92a857" );
        namespace_f78bfb3834febfad::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_ob_warlord_all_for_one / namespace_24ee24c6ec60bf84
// Params 0
// Checksum 0x0, Offset: 0x5c9
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
    
    primaryweaponhash = "iw9_ar_akilo, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_ar_akilo", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    sidearmweaponhash = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ sidearmweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ sidearmweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_pi_papa220", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "thermobaric_grenade_jup_mp";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "thermobaric_grenade_jup_mp" );
    }
}

