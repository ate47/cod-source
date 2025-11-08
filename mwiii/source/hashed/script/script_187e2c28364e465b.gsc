#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\points;

#namespace wm_zombie;

// Namespace wm_zombie / namespace_bc9acb05ff207ddd
// Params 0
// Checksum 0x0, Offset: 0x145
// Size: 0x40
function init()
{
    if ( getdvarint( @"hash_1196c97cf6cee66e", 0 ) )
    {
        function_c601738431d10af5();
        level.var_57ebe7619b06b864 = getdvarint( @"hash_8db2a71a503618ca", 150 );
        
        /#
            level thread function_7f6e135f90bd62a0();
        #/
    }
}

// Namespace wm_zombie / namespace_bc9acb05ff207ddd
// Params 2
// Checksum 0x0, Offset: 0x18d
// Size: 0x98
function function_4fa29d44e69039cb( origin, angles )
{
    zombie_agent = scripts\mp\mp_agent::spawnnewagentaitype( "actor_jup_spawner_zombie_base_wm", origin, angles, "team_two_hundred" );
    
    if ( isdefined( zombie_agent ) )
    {
        if ( istrue( level.var_2b3c3eb6681278d6 ) )
        {
            zombie_agent thread function_346d8332b7c75c38();
        }
        
        if ( isdefined( level.var_57ebe7619b06b864 ) )
        {
            zombie_agent.maxhealth = level.var_57ebe7619b06b864;
            zombie_agent.health = zombie_agent.maxhealth;
        }
        
        zombie_agent callback::add( "on_zombie_ai_killed", &function_2e97441e00b9a886 );
    }
    
    return zombie_agent;
}

// Namespace wm_zombie / namespace_bc9acb05ff207ddd
// Params 1
// Checksum 0x0, Offset: 0x22e
// Size: 0xd3
function function_2e97441e00b9a886( params )
{
    if ( isdefined( params.eattacker ) && isdefined( params.smeansofdeath ) && params.smeansofdeath != "MOD_SUICIDE" )
    {
        player = undefined;
        
        if ( isplayer( params.eattacker ) )
        {
            player = params.eattacker;
        }
        else if ( isdefined( params.eattacker.owner ) && isplayer( params.eattacker.owner ) )
        {
            player = params.eattacker.owner;
        }
        
        if ( isdefined( player ) )
        {
            player points::doscoreevent( #"zombie_kia" );
        }
    }
}

// Namespace wm_zombie / namespace_bc9acb05ff207ddd
// Params 0
// Checksum 0x0, Offset: 0x309
// Size: 0x51
function function_346d8332b7c75c38()
{
    self endon( "death" );
    var_f43f4f0822bef9f1 = randomfloat( 2 );
    wait var_f43f4f0822bef9f1;
    
    while ( true )
    {
        pinglocationenemyteams( self.origin, "axis" );
        pinglocationenemyteams( self.origin, "allies" );
        wait 3;
    }
}

// Namespace wm_zombie / namespace_bc9acb05ff207ddd
// Params 3
// Checksum 0x0, Offset: 0x362
// Size: 0x41
function function_ce8588d31df66dd8( origin, angles, disable_physics )
{
    var_6b8ae74960e802f2 = ter_op( istrue( disable_physics ), 1, 0 );
    return utility::function_ec8a443fe8165fe4( "jup_pi_raygun_mp", origin, [], angles, var_6b8ae74960e802f2 );
}

// Namespace wm_zombie / namespace_bc9acb05ff207ddd
// Params 0
// Checksum 0x0, Offset: 0x3ac
// Size: 0x44
function function_c601738431d10af5()
{
    if ( !isdefined( level.var_f1339ee09ea219d8 ) )
    {
        level.var_f1339ee09ea219d8 = [];
    }
    
    level.var_f1339ee09ea219d8 = array_add( level.var_f1339ee09ea219d8, "jup_pi_raygun_mp" );
    level.var_517ae1797c9e1995 = &function_aa2be556dc1c242;
}

// Namespace wm_zombie / namespace_bc9acb05ff207ddd
// Params 7
// Checksum 0x0, Offset: 0x3f8
// Size: 0x64
function function_aa2be556dc1c242( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon )
{
    if ( isdefined( objweapon ) )
    {
        if ( objweapon.basename == "jup_pi_raygun_mp" && is_equal( eattacker, victim ) )
        {
            return 15;
        }
    }
    
    return idamage;
}

/#

    // Namespace wm_zombie / namespace_bc9acb05ff207ddd
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x465
    // Size: 0xae, Type: dev
    function private function_7f6e135f90bd62a0()
    {
        while ( true )
        {
            zombie_dvar = getdvarint( @"hash_79fb288119ec1063", 0 );
            
            if ( zombie_dvar )
            {
                setdvar( @"hash_79fb288119ec1063", 0 );
                origin = function_9b4c82dba041b23d();
                function_4fa29d44e69039cb( origin, ( 0, 0, 0 ) );
            }
            
            raygun_dvar = getdvarint( @"hash_8234e6abb2fdcfc7", 0 );
            
            if ( raygun_dvar )
            {
                setdvar( @"hash_8234e6abb2fdcfc7", 0 );
                origin = function_9b4c82dba041b23d();
                function_ce8588d31df66dd8( origin, ( 0, 0, 0 ) );
            }
            
            wait 1;
        }
    }

#/
