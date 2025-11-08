#using script_12d038a578d33329;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_ob_warlord_rainmaker;

// Namespace jup_ob_warlord_rainmaker / namespace_84e63a2f1a9edb96
// Params 0
// Checksum 0x0, Offset: 0x2ca
// Size: 0x1e5
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_warlord_rainmaker" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_7dd8262a91a82dd5" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 2880;
    self.maxhealth = 2880;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_full";
    self.asmasset = "soldier";
    self.zombieaisetting = "settings_warlord_rainmaker";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_warlord_base" );
    primaryweaponhash = "jup_jp08_lm_qbravo95lsw, [ jup_jp08_ar_qbravo95_amp_t95, holo03, jup_comp_ar_10 ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    secondaryweaponhash = "jup_jp26_la_cluster, [ none, none, none, none, none, none ], none, none";
    self.secondaryweapon = level.var_67b54180a55f70e1[ secondaryweaponhash ];
    self.grenadeweapon = nullweapon();
    self.grenadeammo = 5;
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

// Namespace jup_ob_warlord_rainmaker / namespace_84e63a2f1a9edb96
// Params 0
// Checksum 0x0, Offset: 0x4b7
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

// Namespace jup_ob_warlord_rainmaker / namespace_84e63a2f1a9edb96
// Params 0
// Checksum 0x0, Offset: 0x516
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_2cbc9cb98a1d9175::main();
}

// Namespace jup_ob_warlord_rainmaker / namespace_84e63a2f1a9edb96
// Params 0
// Checksum 0x0, Offset: 0x527
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_ob_warlord_rainmaker";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_7dd8262a91a82dd5" );
        namespace_2cbc9cb98a1d9175::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_ob_warlord_rainmaker / namespace_84e63a2f1a9edb96
// Params 0
// Checksum 0x0, Offset: 0x5fe
// Size: 0xfd
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
    
    primaryweaponhash = "jup_jp08_lm_qbravo95lsw, [ jup_jp08_ar_qbravo95_amp_t95, holo03, jup_comp_ar_10 ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "jup_jp08_lm_qbravo95lsw", [ "jup_jp08_ar_qbravo95_amp_t95", "holo03", "jup_comp_ar_10" ], "none", "none" );
    }
    
    secondaryweaponhash = "jup_jp26_la_cluster, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ secondaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ secondaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "jup_jp26_la_cluster", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
}

