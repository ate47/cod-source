#using script_5c53c4276223d748;
#using scripts\aitypes\assets;
#using scripts\aitypes\bt_util;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\common\ai;
#using scripts\cp_mp\agents\agent_init;
#using scripts\mp\class;

#namespace jup_exgm_enemy_warlord_stalker_chemist;

// Namespace jup_exgm_enemy_warlord_stalker_chemist / namespace_da24df8ecd0985cb
// Params 0
// Checksum 0x0, Offset: 0x243
// Size: 0x19f
function main()
{
    self.aitypeid = function_2336488258354fbc( #"aitype", %"jup_exgm_enemy_warlord_stalker_chemist" );
    self.health = 2000;
    self.maxhealth = 2000;
    self.behaviortreeasset = "soldier_agent";
    self.asmasset = "soldier";
    primaryweaponhash = "iw9_ar_akilo105, [ hybridtherm01, silencer03_ar ], none, none";
    self.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    sidearmweaponhash = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";
    self.sidearm = level.var_67b54180a55f70e1[ sidearmweaponhash ];
    grenadeweaponhash = "gas_grenade_exgm_chemist";
    self.grenadeweapon = level.var_67b54180a55f70e1[ grenadeweaponhash ];
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

// Namespace jup_exgm_enemy_warlord_stalker_chemist / namespace_da24df8ecd0985cb
// Params 0
// Checksum 0x0, Offset: 0x3ea
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

// Namespace jup_exgm_enemy_warlord_stalker_chemist / namespace_da24df8ecd0985cb
// Params 0
// Checksum 0x0, Offset: 0x449
// Size: 0x8
function function_9ac26a51c94ccf52()
{
    return namespace_f6e904bdff535ba4::main();
}

// Namespace jup_exgm_enemy_warlord_stalker_chemist / namespace_da24df8ecd0985cb
// Params 0
// Checksum 0x0, Offset: 0x45a
// Size: 0xaf
function precache()
{
    agent_type = "actor_jup_exgm_enemy_warlord_stalker_chemist";
    
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
        namespace_f6e904bdff535ba4::precache_cpmp();
    }
    
    scripts\cp_mp\agents\agent_init::agent_init();
    scripts\aitypes\bt_util::init();
    scripts\aitypes\assets::soldier();
    thread setup_weapons();
}

// Namespace jup_exgm_enemy_warlord_stalker_chemist / namespace_da24df8ecd0985cb
// Params 0
// Checksum 0x0, Offset: 0x511
// Size: 0x128
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
    
    primaryweaponhash = "iw9_ar_akilo105, [ hybridtherm01, silencer03_ar ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_ar_akilo105", [ "hybridtherm01", "silencer03_ar" ], "none", "none" );
    }
    
    sidearmweaponhash = "iw9_pi_papa220, [ none, none, none, none, none, none ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ sidearmweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ sidearmweaponhash ] = scripts\mp\class::function_e83615f8a92e4378( "iw9_pi_papa220", [ "none", "none", "none", "none", "none", "none" ], "none", "none" );
    }
    
    grenadeweaponhash = "gas_grenade_exgm_chemist";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ grenadeweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ grenadeweaponhash ] = makeweapon( "gas_grenade_exgm_chemist" );
    }
}

