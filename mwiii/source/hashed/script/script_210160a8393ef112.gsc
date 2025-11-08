#using character\character_al_qatala_desert_ar;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace enemy_mp_base;

// Namespace enemy_mp_base / namespace_4f4b790ed0cfffd8
// Params 0
// Checksum 0x0, Offset: 0x226
// Size: 0x1e0
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"enemy_mp_base" );
    self.subclass_scriptbundle = getscriptbundle( %"ai_subclass:regular" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 300;
    self.maxhealth = 300;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    primaryweaponhash = "iw9_ar_akilo, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    sidearmweaponhash = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";
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

// Namespace enemy_mp_base / namespace_4f4b790ed0cfffd8
// Params 0
// Checksum 0x0, Offset: 0x40e
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

// Namespace enemy_mp_base / namespace_4f4b790ed0cfffd8
// Params 0
// Checksum 0x0, Offset: 0x46d
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return character\character_al_qatala_desert_ar::main();
}

// Namespace enemy_mp_base / namespace_4f4b790ed0cfffd8
// Params 0
// Checksum 0x0, Offset: 0x47e
// Size: 0xcf
function precache()
{
    agent_type = "actor_enemy_mp_base";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"ai_subclass:regular" );
        character\character_al_qatala_desert_ar::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace enemy_mp_base / namespace_4f4b790ed0cfffd8
// Params 0
// Checksum 0x0, Offset: 0x555
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
    
    grenadeweaponhash = "frag_grenade_mp";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "frag_grenade_mp" );
    }
}

