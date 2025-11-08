#using script_3639694a456ca063;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\common\ai_settings;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_ob_enemy_specialist_rocketeer_fortressguard;

// Namespace jup_ob_enemy_specialist_rocketeer_fortressguard / namespace_77dada0dc71cfeb9
// Params 0
// Checksum 0x0, Offset: 0x25c
// Size: 0x1d7
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_ob_enemy_specialist_rocketeer_fortressguard" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_1417b10ad9f39125" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 300;
    self.maxhealth = 300;
    self.behaviortreeasset = "soldier_jup_ob";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    scripts\common\ai_settings::function_7b25d1c42e7f75be( "aisettings_soldier_base_ob" );
    primaryweaponhash = "iw9_la_gromeo, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    sidearmweaponhash = "iw9_pi_golf17, [ none, none, none, none, none, none ], none, none";
    self.sidearm = level.var_67b54180a55f70e1[ sidearmweaponhash ];
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

// Namespace jup_ob_enemy_specialist_rocketeer_fortressguard / namespace_77dada0dc71cfeb9
// Params 0
// Checksum 0x0, Offset: 0x43b
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

// Namespace jup_ob_enemy_specialist_rocketeer_fortressguard / namespace_77dada0dc71cfeb9
// Params 0
// Checksum 0x0, Offset: 0x49a
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_8d5a9e6061872b39::main();
}

// Namespace jup_ob_enemy_specialist_rocketeer_fortressguard / namespace_77dada0dc71cfeb9
// Params 0
// Checksum 0x0, Offset: 0x4ab
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_ob_enemy_specialist_rocketeer_fortressguard";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_1417b10ad9f39125" );
        namespace_8d5a9e6061872b39::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_ob_enemy_specialist_rocketeer_fortressguard / namespace_77dada0dc71cfeb9
// Params 0
// Checksum 0x0, Offset: 0x582
// Size: 0x118
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
    
    primaryweaponhash = "iw9_la_gromeo, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_la_gromeo", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    sidearmweaponhash = "iw9_pi_golf17, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ sidearmweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ sidearmweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_pi_golf17", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
}

