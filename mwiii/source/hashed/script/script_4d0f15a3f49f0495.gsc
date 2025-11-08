#using script_e9e8090769c484c;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\code\character;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard;

// Namespace jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard / namespace_4c67b6490a5b3bcb
// Params 0
// Checksum 0x0, Offset: 0x362
// Size: 0x2d1
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard" );
    self.subclass_scriptbundle = getscriptbundle( %"hash_d4c1580d6bc10b4" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 300;
    self.maxhealth = 300;
    self.behaviortreeasset = "soldier_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    
    switch ( scripts\code\character::get_random_weapon( 6 ) )
    {
        case 0:
            primaryweaponhash = "iw9_lm_ngolf7, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 1:
            primaryweaponhash = "iw9_lm_kilo21, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 2:
            primaryweaponhash = "iw9_ar_akilo74, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 3:
            primaryweaponhash = "iw9_ar_akilo105, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 4:
            primaryweaponhash = "iw9_ar_akilo74, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
        case 5:
            primaryweaponhash = "iw9_ar_akilo105, [ none, none, none, none, none, none ], none, none";
            self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
            break;
    }
    
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

// Namespace jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard / namespace_4c67b6490a5b3bcb
// Params 0
// Checksum 0x0, Offset: 0x63b
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

// Namespace jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard / namespace_4c67b6490a5b3bcb
// Params 0
// Checksum 0x0, Offset: 0x69a
// Size: 0x41
function function_9ac26a51c94ccf52()
{
    assertex( isdefined( self.var_e2682e6f1838391e ), "<dev string:x1c>" );
    
    switch ( self.var_e2682e6f1838391e )
    {
        default:
            return namespace_d83fb0ce0a8be1b8::main();
    }
}

// Namespace jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard / namespace_4c67b6490a5b3bcb
// Params 0
// Checksum 0x0, Offset: 0x6e3
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"hash_d4c1580d6bc10b4" );
        namespace_d83fb0ce0a8be1b8::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_exgm_enemy_basic_specialforce_all_for_one_bodyguard / namespace_4c67b6490a5b3bcb
// Params 0
// Checksum 0x0, Offset: 0x7ba
// Size: 0x39e
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
    
    var_5576d3be590a9a64 = "iw9_lm_ngolf7, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d3be590a9a64 ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_lm_ngolf7", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576d6be590aa0fd = "iw9_lm_kilo21, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d6be590aa0fd ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_lm_kilo21", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576d5be590a9eca = "iw9_ar_akilo74, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d5be590a9eca ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d5be590a9eca ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_ar_akilo74", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576d0be590a93cb = "iw9_ar_akilo105, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d0be590a93cb ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d0be590a93cb ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_ar_akilo105", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576cfbe590a9198 = "iw9_ar_akilo74, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576cfbe590a9198 ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576cfbe590a9198 ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_ar_akilo74", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    var_5576d2be590a9831 = "iw9_ar_akilo105, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ var_5576d2be590a9831 ] ) )
    {
        level.var_67b54180a55f70e1[ var_5576d2be590a9831 ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_ar_akilo105", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
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

