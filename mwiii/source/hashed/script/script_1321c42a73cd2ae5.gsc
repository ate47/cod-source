#using script_3874cfa9b4b053cf;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_exgm_enemy_warlord_test_jugg;

// Namespace jup_exgm_enemy_warlord_test_jugg / namespace_f18581fcd98d055d
// Params 0
// Checksum 0x0, Offset: 0x1d9
// Size: 0x1bc
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_exgm_enemy_warlord_test_jugg" );
    self.subclass_scriptbundle = getscriptbundle( %"ai_subclass:juggernaut" );
    self.subclass = self.subclass_scriptbundle.name;
    self.health = 3000;
    self.maxhealth = 3000;
    self.behaviortreeasset = "juggernaut_agent";
    self.aishootstyle = "ai_shoot_styles_default";
    self.asmasset = "soldier";
    primaryweaponhash = "iw9_lm_dblmg, [ none, none, none, none, none, none ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    grenadeweaponhash = "frag";
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

// Namespace jup_exgm_enemy_warlord_test_jugg / namespace_f18581fcd98d055d
// Params 0
// Checksum 0x0, Offset: 0x39d
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

// Namespace jup_exgm_enemy_warlord_test_jugg / namespace_f18581fcd98d055d
// Params 0
// Checksum 0x0, Offset: 0x3fc
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_70732e81c32e1db3::main();
}

// Namespace jup_exgm_enemy_warlord_test_jugg / namespace_f18581fcd98d055d
// Params 0
// Checksum 0x0, Offset: 0x40d
// Size: 0xcf
function precache()
{
    agent_type = "actor_jup_exgm_enemy_warlord_test_jugg";
    
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
        level.agent_definition[ agent_type ][ "subclass" ] = getscriptbundle( %"ai_subclass:juggernaut" );
        namespace_70732e81c32e1db3::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::juggernaut();
    thread setup_weapons();
}

// Namespace jup_exgm_enemy_warlord_test_jugg / namespace_f18581fcd98d055d
// Params 0
// Checksum 0x0, Offset: 0x4e4
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
    
    primaryweaponhash = "iw9_lm_dblmg, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_lm_dblmg", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "frag";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "frag" );
    }
}

