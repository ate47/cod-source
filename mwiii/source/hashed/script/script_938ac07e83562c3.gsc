#using script_23e4bed47408a4d;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_ob_enemy_specialist_shielded;

// Namespace jup_ob_enemy_specialist_shielded / namespace_7f3fc41e5ee10d1f
// Params 0
// Checksum 0x0, Offset: 0x2f8
// Size: 0x1fd
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_enemy_specialist_shielded" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_e5c359d7fd97ec3" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 300;
    self.maxhealth = 300;
    self.behaviortreeasset = "riotshield_jup_ob";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_soldier_base_ob" );
    
    switch ( scripts\code\character::get_random_weapon( 2 ) )
    {
        case 0:
            primaryweaponhash = "jup_jp14_pi_rsierra12, [ jup_jp14_pi_rsierra12_speedloader_5_12, jup_minireddot01_pstl ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 1:
            primaryweaponhash = "iw9_pi_swhiskey, [ speedloader_hvy_p26, iw9_minireddot01 ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
    }
    
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    self.grenadeweapon = nullweapon();
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

// Namespace jup_ob_enemy_specialist_shielded / namespace_7f3fc41e5ee10d1f
// Params 0
// Checksum 0x0, Offset: 0x4fd
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

// Namespace jup_ob_enemy_specialist_shielded / namespace_7f3fc41e5ee10d1f
// Params 0
// Checksum 0x0, Offset: 0x55c
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_2cd996856f5e777::main();
}

// Namespace jup_ob_enemy_specialist_shielded / namespace_7f3fc41e5ee10d1f
// Params 0
// Checksum 0x0, Offset: 0x56d
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_ob_enemy_specialist_shielded";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_e5c359d7fd97ec3" );
        namespace_2cd996856f5e777::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_ob_enemy_specialist_shielded / namespace_7f3fc41e5ee10d1f
// Params 0
// Checksum 0x0, Offset: 0x644
// Size: 0xd0
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
    
    var_5576d3be590a9a64 = "jup_jp14_pi_rsierra12, [ jup_jp14_pi_rsierra12_speedloader_5_12, jup_minireddot01_pstl ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] = scripts\mp\class::function_e83615f8a92e4378( "jup_jp14_pi_rsierra12", [ "jup_jp14_pi_rsierra12_speedloader_5_12", "jup_minireddot01_pstl" ], "none", "none" );
    }
    
    var_5576d6be590aa0fd = "iw9_pi_swhiskey, [ speedloader_hvy_p26, iw9_minireddot01 ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_pi_swhiskey", [ "speedloader_hvy_p26", "iw9_minireddot01" ], "none", "none" );
    }
}

