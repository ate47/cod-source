#using script_4948cdf739393d2d;
#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\equipment\molotov;
#using scripts\mp\flags;
#using scripts\mp\poi;
#using scripts\mp\utility\debug;
#using scripts\stealth\enemy;
#using scripts\stealth\group;

#namespace ai_behavior;

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x551
// Size: 0x18
function function_2585b1944b7884c0()
{
    registersharedfunc( "pyro", "molotov_used", &scripts\mp\equipment\molotov::molotov_used );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x571
// Size: 0x33
function function_304da84d9a815c01( origin, goalradius, var_3a21f8213541aec5 )
{
    _setgoalpos( origin, goalradius );
    
    if ( istrue( var_3a21f8213541aec5 ) )
    {
        level thread ai_watchforbadpath( self );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x5ac
// Size: 0x145
function _setgoalpos( origin, goalradius, var_1b6352ceb9bbc1d )
{
    if ( istrue( self.fixednode ) || !isalive( self ) || isdefined( self.vehicle ) )
    {
        return;
    }
    
    if ( !istrue( var_1b6352ceb9bbc1d ) )
    {
        function_c6930ac29fe6ff53( goalradius );
    }
    
    safeorigin = self getclosestreachablepointonnavmesh( origin, 0 );
    
    if ( !isdefined( safeorigin ) )
    {
        println( "<dev string:x1c>" + origin );
        return;
    }
    
    if ( !isdefined( self.origin ) )
    {
        assertmsg( "<dev string:x5e>" );
        return;
    }
    
    dist = distance( self.origin, safeorigin );
    
    if ( dist < 12500 && dist > 20 )
    {
        if ( false )
        {
            thread scripts\mp\utility\debug::drawsphere( safeorigin, 32, 10, ( 0, 1, 0 ) );
        }
        
        self setgoalpos( safeorigin );
        return;
    }
    
    if ( dist >= 12500 && !istrue( self.var_9dfc77ce3cd9e879 ) )
    {
        assertmsg( "<dev string:x99>" + dist + "<dev string:xd8>" + safeorigin + "<dev string:xe6>" + self.origin + "<dev string:xf8>" + origin + "<dev string:x105>" + self getentitynumber() );
        thread function_9bbf1713a14fa580( self, 1024 );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x6f9
// Size: 0x2d
function function_c6930ac29fe6ff53( goalradius )
{
    if ( !isdefined( goalradius ) )
    {
        goalradius = 128;
    }
    
    self.goalradius = int( goalradius );
    self.script_goalradius = goalradius;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x72e
// Size: 0x1b
function function_b91038b6725a259a( agent, targetent )
{
    agent setgoalentity( targetent );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x751
// Size: 0x13
function function_aa8f023c16fc448d( node )
{
    self setgoalnode( node );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x76c
// Size: 0x31
function function_61cbc488b27a6e61( origin )
{
    navmeshorigin = getclosestpointonnavmesh( origin );
    groundorigin = drop_to_ground( navmeshorigin, 64 );
    return groundorigin;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x7a6
// Size: 0x20
function function_1670c315976c767b()
{
    while ( !scripts\mp\flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x7ce
// Size: 0xf0
function function_b11c1964f528574b( agent, var_ba8b04eb4b683e67, origin )
{
    savedorigin = origin;
    
    if ( isagent( agent ) && !isdefined( origin ) )
    {
        savedorigin = agent.origin;
    }
    
    if ( istrue( var_ba8b04eb4b683e67 ) )
    {
        function_d1e130608e4f8487( agent, savedorigin, var_ba8b04eb4b683e67 );
    }
    else
    {
        function_e786aa52b93833eb( agent, savedorigin, 25, 10 );
    }
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent endon( "death" );
    agent endon( "stealth_investigate" );
    agent endon( "stealth_hunt" );
    agent endon( "stealth_combat" );
    agent endon( "startCombatRush" );
    function_1670c315976c767b();
    wait 1;
    
    if ( isdefined( origin ) && distance2dsquared( origin, agent.origin ) > 4096 )
    {
        agent function_304da84d9a815c01( origin, 32, 1 );
        agent waittill( "goal" );
    }
    else if ( !isdefined( origin ) )
    {
        origin = agent.origin;
    }
    
    if ( !istrue( var_ba8b04eb4b683e67 ) )
    {
        agent behavior_executebehaviorpackage( agent );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x8c6
// Size: 0x225
function function_9bbf1713a14fa580( agent, radius, radiusvariance, origin )
{
    savedorigin = origin;
    
    if ( isagent( agent ) && !isdefined( origin ) )
    {
        savedorigin = agent.origin;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 100;
    }
    
    if ( !isdefined( radiusvariance ) || radiusvariance <= 0 )
    {
        radiusvariance = 50;
    }
    
    function_e786aa52b93833eb( agent, savedorigin, radius, radiusvariance );
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent endon( "death" );
    agent endon( "stealth_investigate" );
    agent endon( "stealth_hunt" );
    agent endon( "stealth_combat" );
    agent endon( "startCombatRush" );
    agent notify( "guardWander" );
    agent endon( "guardWander" );
    function_1670c315976c767b();
    wait 1;
    
    if ( isdefined( origin ) && distance2dsquared( origin, agent.origin ) > 4096 )
    {
        agent function_304da84d9a815c01( origin, 32, 1 );
        agent waittill( "goal" );
    }
    
    originalorigin = agent.origin;
    min = radius - radiusvariance;
    max = radius + radiusvariance;
    agent.var_9dfc77ce3cd9e879 = 1;
    
    while ( !isdefined( agent.enemy ) )
    {
        random_x = randomfloatrange( min, max ) * scripts\engine\utility::ter_op( randomint( 100 ) > 50, 1, -1 );
        random_y = randomfloatrange( min, max ) * scripts\engine\utility::ter_op( randomint( 100 ) > 50, 1, -1 );
        var_b30a6c38cd4fe517 = ( originalorigin[ 0 ] + random_x, originalorigin[ 1 ] + random_y, originalorigin[ 2 ] );
        
        if ( distance2d( agent.origin, var_b30a6c38cd4fe517 ) > 20 )
        {
            agent _setgoalpos( var_b30a6c38cd4fe517, 8 );
            agent thread function_bf182f1600fec92a( agent );
            agent waittill_any_2( "goal", "refreshGoalPos" );
        }
        
        wait randomfloatrange( 7.5, 10.5 );
    }
    
    agent _setgoalpos( savedorigin, 768 );
    agent.var_9dfc77ce3cd9e879 = undefined;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0xaf3
// Size: 0x1e4
function function_a057ee9adc9547d5( agent, radius, radiusvariance, origin )
{
    savedorigin = origin;
    
    if ( isagent( agent ) && !isdefined( origin ) )
    {
        savedorigin = agent.origin;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 1000;
    }
    
    if ( !isdefined( radiusvariance ) || radiusvariance <= 0 )
    {
        radiusvariance = 200;
    }
    
    function_fe5620595915170f( agent, savedorigin, radius, radiusvariance );
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent endon( "death" );
    agent endon( "stealth_investigate" );
    agent endon( "stealth_hunt" );
    agent endon( "stealth_combat" );
    agent endon( "startCombatRush" );
    function_1670c315976c767b();
    wait 1;
    
    if ( isdefined( origin ) && distance2dsquared( origin, agent.origin ) > 4096 )
    {
        agent function_304da84d9a815c01( origin, 32, 1 );
        agent waittill( "goal" );
    }
    
    originalorigin = agent.origin;
    min = radius - radiusvariance;
    max = radius + radiusvariance;
    
    while ( true )
    {
        random_x = randomfloatrange( min, max ) * scripts\engine\utility::ter_op( randomint( 100 ) > 50, 1, -1 );
        random_y = randomfloatrange( min, max ) * scripts\engine\utility::ter_op( randomint( 100 ) > 50, 1, -1 );
        var_b30a6c38cd4fe517 = ( originalorigin[ 0 ] + random_x, originalorigin[ 1 ] + random_y, originalorigin[ 2 ] );
        
        if ( distance2d( agent.origin, var_b30a6c38cd4fe517 ) > 20 )
        {
            agent _setgoalpos( var_b30a6c38cd4fe517, 8 );
            agent thread function_bf182f1600fec92a( agent );
            agent waittill_any_2( "goal", "refreshGoalPos" );
        }
        
        wait randomfloatrange( 7.5, 10.5 );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0xcdf
// Size: 0x41
function function_bf182f1600fec92a( agent, time )
{
    agent endon( "goal" );
    agent endon( "death" );
    waittime = 5;
    
    if ( isdefined( time ) )
    {
        waittime = time;
    }
    
    wait waittime;
    agent notify( "refreshGoalPos" );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0xd28
// Size: 0x317
function behavior_patrol( var_886dfa499937a071, pathstruct, startindex, goalradiusoverride, idletimeoverride )
{
    if ( !isdefined( var_886dfa499937a071[ 0 ] ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    var_a1d5907e01730345 = 0;
    
    foreach ( agent in var_886dfa499937a071 )
    {
        behaviorpackage = function_f0c78111ce0cdc0a( agent );
        
        if ( !isdefined( behaviorpackage ) || behaviorpackage.behavior != "patrol" )
        {
            if ( level.var_fe093e9b2b6c3751 )
            {
                function_4561fe6bfc76f8ec( agent, [ agent ], pathstruct );
            }
            else
            {
                function_4561fe6bfc76f8ec( agent, var_886dfa499937a071, pathstruct );
            }
        }
        
        if ( isagent( agent ) )
        {
            agent notify( "patrolStart" );
            agent endon( "patrolStart" );
            agent endon( "death" );
            agent endon( "stealth_investigate" );
            agent endon( "stealth_hunt" );
            agent endon( "stealth_combat" );
            agent endon( "startCombatRush" );
            var_a1d5907e01730345 = 1;
        }
    }
    
    if ( !var_a1d5907e01730345 )
    {
        return;
    }
    
    level thread function_b4fd9f6bd59a64f0( var_886dfa499937a071 );
    path = pathstruct.path;
    pathstruct.claimed = 1;
    index = 1;
    forwarddirection = 1;
    
    if ( isdefined( startindex ) )
    {
        index = startindex;
        index = int( min( index, path.size - 1 ) );
        index = int( max( index, 0 ) );
    }
    
    function_1670c315976c767b();
    wait 1;
    
    while ( true )
    {
        if ( isvector( path[ index ] ) )
        {
            point = path[ index ];
        }
        else
        {
            point = path[ index ].origin;
        }
        
        foreach ( agentindex, agent in var_886dfa499937a071 )
        {
            if ( agentindex != 0 )
            {
                random_x = randomfloatrange( 30, 31 ) * scripts\engine\utility::ter_op( cointoss(), 1, -1 );
                random_y = randomfloatrange( 30, 31 ) * scripts\engine\utility::ter_op( cointoss(), 1, -1 );
                point = ( point[ 0 ] + random_x, point[ 1 ] + random_y, point[ 2 ] );
            }
            
            agent _setgoalpos( point, default_to( goalradiusoverride, 128 ) );
            wait randomfloatrange( 1.5, 2.5 );
        }
        
        waitframe();
        var_886dfa499937a071[ 0 ] waittill( "goal" );
        
        if ( istrue( var_886dfa499937a071[ 0 ].var_cf430336d17e3afe ) )
        {
            wait 0.5;
        }
        else
        {
            wait default_to( idletimeoverride, 8 );
        }
        
        if ( forwarddirection )
        {
            index++;
        }
        else
        {
            index--;
        }
        
        if ( !isdefined( path[ index ] ) )
        {
            if ( !pathstruct.var_4437e81f60b6b5a0 )
            {
                index = 0;
                continue;
            }
            
            if ( forwarddirection )
            {
                index = path.size - 2;
                forwarddirection = 0;
                continue;
            }
            
            index = 1;
            forwarddirection = 1;
        }
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x1047
// Size: 0x194
function function_b4fd9f6bd59a64f0( var_886dfa499937a071 )
{
    level endon( "game_ended" );
    
    foreach ( agent in var_886dfa499937a071 )
    {
        agent endon( "stealth_investigate" );
        agent endon( "stealth_hunt" );
        agent endon( "stealth_combat" );
    }
    
    var_37cbbc36d167b305 = 0;
    
    while ( !var_37cbbc36d167b305 )
    {
        foreach ( agent in var_886dfa499937a071 )
        {
            if ( isdefined( agent ) && !isalive( agent ) )
            {
                var_37cbbc36d167b305 = 1;
            }
        }
        
        wait 1;
    }
    
    wait 2.5;
    
    foreach ( agent in var_886dfa499937a071 )
    {
        if ( isdefined( agent ) && isalive( agent ) )
        {
            event = spawnstruct();
            event.type = "investigate";
            event.typeorig = "found_corpse";
            event.origin = agent.origin;
            event.investigate_pos = agent.origin;
            agent scripts\stealth\enemy::bt_set_stealth_state( "investigate", event );
        }
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x11e3
// Size: 0xe8, Type: bool
function function_21014e3c42bcc249( event )
{
    agent = self;
    
    if ( isdefined( agent.behaviorpackage ) && isdefined( agent.behaviorpackage.combatcenter ) && isdefined( agent.behaviorpackage.combatradius ) )
    {
        self setgoalpos( self.behaviorpackage.combatcenter, self.behaviorpackage.combatradius );
        
        if ( isdefined( agent.var_14c360ebec241178 ) )
        {
            agent.maxsightdistsqrd = agent.var_14c360ebec241178;
        }
    }
    else if ( event.type == "combat" && !istrue( agent.var_b43f6cad28078a05 ) )
    {
        self.goalradius = level.var_8912ccad342445f7;
    }
    
    return false;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x12d4
// Size: 0x75
function function_1a2e58ffaafb1d40( var_db585b8134eed64c )
{
    foreach ( pathstruct in var_db585b8134eed64c )
    {
        if ( istrue( pathstruct.claimed ) )
        {
            continue;
        }
        
        pathstruct.claimed = 1;
        return pathstruct;
    }
    
    return undefined;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x1352
// Size: 0x19e
function function_7e69553f058c867b( agent )
{
    agent endon( "death" );
    var_8bb792d43ecd8d1e = getdvarint( @"hash_401ebd6ca7f17d87", 0 );
    
    while ( true )
    {
        if ( [[ agent.fnisinstealthidle ]]() )
        {
            if ( istrue( agent.leftidle ) )
            {
                agent.leftidle = 0;
                function_447a25af0131832e( agent );
            }
        }
        else if ( [[ agent.fnisinstealthinvestigate ]]() )
        {
            agent.leftidle = 1;
        }
        else if ( [[ agent.fnisinstealthcombat ]]() )
        {
            agent.leftidle = 1;
            
            if ( var_8bb792d43ecd8d1e <= 0 )
            {
                wait 5;
                continue;
            }
            
            if ( isdefined( agent.behaviorpackage ) && agent.behaviorpackage.behavior == "guard" )
            {
                wait 5;
                continue;
            }
            
            if ( isdefined( agent.enemy ) )
            {
                agent getenemyinfo( agent.enemy );
                
                if ( issubstr( agent.script_stealthgroup, "fortress" ) )
                {
                    wait 10;
                    continue;
                }
                
                roll = randomint( 100 );
                
                if ( roll > var_8bb792d43ecd8d1e )
                {
                    _setgoalpos( agent.enemy.origin, 1000 );
                }
                
                wait 10;
            }
        }
        else if ( [[ agent.fnisinstealthhunt ]]() )
        {
            agent.leftidle = 1;
            
            if ( istrue( level.var_69173c5e957cccff ) )
            {
                agent thread function_67ddae411c6c353e( agent );
            }
        }
        
        wait 5;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x14f8
// Size: 0x6f
function function_67ddae411c6c353e( agent )
{
    agent endon( "death" );
    agent endon( "stealth_combat" );
    agent endon( "startCombatRush" );
    interval = 1;
    curtime = 0;
    
    while ( curtime < level.var_ec80e35c609c1533 )
    {
        wait interval;
        curtime += interval;
        
        if ( istrue( agent.var_b43f6cad28078a05 ) )
        {
            return;
        }
    }
    
    agent scripts\stealth\enemy::bt_set_stealth_state( "idle", undefined );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x156f
// Size: 0x140
function function_447a25af0131832e( agent )
{
    if ( !isdefined( agent.behaviorpackage ) )
    {
        function_d1e130608e4f8487( agent );
    }
    
    if ( agent.behaviorpackage.behavior == "patrol" )
    {
        agentarray = [];
        
        foreach ( var_a49f3e62ba7c6d8a in agent.behaviorpackage.var_886dfa499937a071 )
        {
            if ( isdefined( var_a49f3e62ba7c6d8a ) && isalive( var_a49f3e62ba7c6d8a ) && isdefined( agent.behaviorpackage ) && isdefined( var_a49f3e62ba7c6d8a.behaviorpackage ) && isdefined( var_a49f3e62ba7c6d8a.behaviorpackage.pathstruct ) && agent.behaviorpackage.pathstruct == var_a49f3e62ba7c6d8a.behaviorpackage.pathstruct )
            {
                agentarray[ agentarray.size ] = var_a49f3e62ba7c6d8a;
            }
        }
        
        agent.behaviorpackage.var_886dfa499937a071 = agentarray;
    }
    
    behavior_executebehaviorpackage( agent );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 8
// Checksum 0x0, Offset: 0x16b7
// Size: 0x11a
function function_65f6a39e1083fb6b( agent, var_2bd923437ecc04bd, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 )
{
    agent endon( "death" );
    var_913774985c12c245 = var_2bd923437ecc04bd;
    function_6e3dd46c3475cd2d( agent, var_913774985c12c245, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 );
    
    foreach ( index, reinforceorigin in var_2bd923437ecc04bd )
    {
        agent thread function_a5117518725da028( agent, reinforceorigin, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, 1, var_1b3d1c2f22b62206 );
        agent waittill( "combatRushComplete" );
        var_913774985c12c245 = array_remove( var_913774985c12c245, reinforceorigin );
        function_6e3dd46c3475cd2d( agent, var_913774985c12c245, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 );
        waitframe();
        
        if ( !isdefined( var_2bd923437ecc04bd[ index + 1 ] ) )
        {
            if ( isdefined( var_1b3d1c2f22b62206 ) )
            {
                [[ var_1b3d1c2f22b62206 ]]( agent );
                continue;
            }
            
            agent thread function_9bbf1713a14fa580( agent, var_21f24aecb313e479, var_e298cec41261345c, reinforceorigin );
        }
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 10
// Checksum 0x0, Offset: 0x17d9
// Size: 0x4c2
function function_a5117518725da028( agent, reinforceorigin, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_66db74486a8f804, var_1b3d1c2f22b62206, targetent )
{
    if ( !isdefined( agent ) || !isalive( agent ) || !isdefined( reinforceorigin ) )
    {
        return;
    }
    
    if ( isdefined( reinforceorigin ) && !isvector( reinforceorigin ) )
    {
        return;
    }
    
    if ( issubstr( agent.agent_type, "jugg" ) )
    {
        return;
    }
    
    if ( !isdefined( var_e298cec41261345c ) )
    {
        var_e298cec41261345c = 128;
    }
    
    if ( !isdefined( goalradiusoverride ) )
    {
        goalradiusoverride = 256;
    }
    
    if ( !isdefined( var_21f24aecb313e479 ) )
    {
        var_21f24aecb313e479 = 768;
    }
    
    if ( !isdefined( var_3e332762c9138001 ) )
    {
        var_3e332762c9138001 = 1;
    }
    
    if ( isagent( agent ) && distance( agent.origin, reinforceorigin ) > 12500 )
    {
        assertmsg( "<dev string:x117>" + reinforceorigin + "<dev string:x153>" + agent.origin + "<dev string:x17c>" );
        
        /#
            print3d( agent.origin, "<dev string:x181>", ( 1, 0, 0 ), 1, 5, 60, 1 );
            level thread scripts\cp_mp\utility\debug_utility::drawsphere( agent.origin, 256, 60, ( 0, 1, 0 ) );
            level thread scripts\cp_mp\utility\debug_utility::drawsphere( reinforceorigin, 256, 60, ( 1, 1, 0 ) );
            level thread scripts\cp_mp\utility\debug_utility::drawline( agent.origin, reinforceorigin, 60, ( 1, 1, 0 ) );
        #/
        
        agent thread function_9bbf1713a14fa580( agent, 1024 );
        return;
    }
    
    if ( !istrue( var_66db74486a8f804 ) )
    {
        function_bd9acc7c99ad884( agent, reinforceorigin, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 );
    }
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent endon( "death" );
    agent endon( "cancelCombatRush" );
    agent notify( "startCombatRush" );
    agent notify( "endCQB" );
    agent.var_b43f6cad28078a05 = 1;
    var_95f125b69bd6e39e = reinforceorigin;
    
    if ( var_e298cec41261345c > 0 )
    {
        var_95f125b69bd6e39e += ( randomfloatrange( -1 * var_e298cec41261345c, var_e298cec41261345c ), randomfloatrange( -1 * var_e298cec41261345c, var_e298cec41261345c ), 0 );
    }
    
    var_95f125b69bd6e39e = function_61cbc488b27a6e61( var_95f125b69bd6e39e );
    self.var_5323a94889eff1de = 1;
    
    if ( isdefined( agent.script_stealthgroup ) )
    {
        agent.var_9a04c6cfe15e92a7 = var_95f125b69bd6e39e;
    }
    
    agent scripts\stealth\enemy::bt_event_combat();
    agent setbtgoalpos( 0, var_95f125b69bd6e39e );
    agent setbtgoalpos( 1, var_95f125b69bd6e39e );
    agent setbtgoalradius( 0, goalradiusoverride );
    agent setbtgoalradius( 1, goalradiusoverride );
    agent function_304da84d9a815c01( var_95f125b69bd6e39e, goalradiusoverride, !var_3e332762c9138001 );
    agent childthread function_547dc153b092906d( agent, 1024, undefined, var_95f125b69bd6e39e, var_3e332762c9138001, var_66db74486a8f804 );
    
    while ( true )
    {
        dist = distance2d( agent.origin, var_95f125b69bd6e39e );
        time = max( dist / 50, 10 );
        msg = "badMessage";
        
        while ( agent pathdisttogoal() == 0 )
        {
            waitframe();
        }
        
        if ( istrue( var_3e332762c9138001 ) )
        {
            msg = agent waittill_any_timeout_3( time, "goal", "goal_reached", "bt_goal" );
        }
        else
        {
            msg = agent waittill_any_timeout_5( time, "goal", "goal_reached", "bad_path", "endBadPathHandler", "bt_goal" );
            agent notify( "endBadPathHandler" );
        }
        
        if ( msg != "bt_goal" || distance2d( agent.origin, var_95f125b69bd6e39e ) < goalradiusoverride )
        {
            break;
        }
    }
    
    self.var_5323a94889eff1de = 0;
    
    if ( isdefined( agent.script_stealthgroup ) )
    {
        function_467f737adf6aeee4( agent.script_stealthgroup );
        groupmembers = function_ba90928315aa754d( agent.script_stealthgroup );
        
        if ( groupmembers.size == 0 )
        {
            groupmembers = [ agent ];
        }
    }
    else
    {
        groupmembers = [ agent ];
    }
    
    if ( isdefined( rushgroup ) )
    {
        groupmembers = array_combine_unique( groupmembers, rushgroup );
    }
    
    foreach ( member in groupmembers )
    {
        var_2bc30fcff884b1ba = 0;
        
        if ( member == agent )
        {
            var_2bc30fcff884b1ba = 1;
        }
        
        member thread function_490ff4d545e089bc( member, var_2bc30fcff884b1ba, var_21f24aecb313e479 );
    }
    
    if ( !istrue( var_66db74486a8f804 ) )
    {
        if ( isdefined( var_1b3d1c2f22b62206 ) )
        {
            [[ var_1b3d1c2f22b62206 ]]( agent, targetent );
        }
        else
        {
            agent thread function_9bbf1713a14fa580( agent, var_21f24aecb313e479, var_e298cec41261345c, reinforceorigin );
        }
    }
    
    agent notify( "combatRushComplete" );
    agent.var_9f78b0c726e807ff = 0;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0x1ca3
// Size: 0xe6
function function_490ff4d545e089bc( agent, var_2bc30fcff884b1ba, var_145bc4a8e47c0991, var_34ed52869f44afbb, var_1e6879f36e59bea5 )
{
    agent endon( "death" );
    agent notify( "end_combat_rush_early_target_think" );
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent function_c6930ac29fe6ff53( var_145bc4a8e47c0991 );
    agent.var_b43f6cad28078a05 = 0;
    
    if ( !istrue( var_2bc30fcff884b1ba ) )
    {
        agent notify( "cancelCombatRush" );
        agent notify( "combatRushComplete" );
        scripts\mp\ai_behavior::function_d1e130608e4f8487( agent );
        
        if ( !isdefined( var_34ed52869f44afbb ) )
        {
            var_34ed52869f44afbb = 2;
        }
        
        if ( !isdefined( var_1e6879f36e59bea5 ) )
        {
            var_1e6879f36e59bea5 = 8;
        }
        
        wait randomintrange( var_34ed52869f44afbb, var_1e6879f36e59bea5 );
    }
    
    agent notify( "endBadPathHandler" );
    
    if ( isdefined( agent.script_stealthgroup ) )
    {
        function_467f737adf6aeee4( agent.script_stealthgroup );
    }
    
    if ( isalive( agent ) && isdefined( self.fnsetstealthstate ) )
    {
        agent scripts\stealth\enemy::bt_set_stealth_state( "idle", undefined );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 6
// Checksum 0x0, Offset: 0x1d91
// Size: 0xd3
function function_547dc153b092906d( agent, abortdistance, validtargetdist, var_95f125b69bd6e39e, var_3e332762c9138001, var_66db74486a8f804 )
{
    agent notify( "end_combat_rush_early_target_think" );
    agent endon( "end_combat_rush_early_target_think" );
    
    if ( !isdefined( validtargetdist ) )
    {
        validtargetdist = 1024;
    }
    
    while ( agent pathdisttogoal() == 0 )
    {
        waitframe();
    }
    
    waitframe();
    
    while ( agent pathdisttogoal() > min( 128, abortdistance ) || istrue( agent.var_b43f6cad28078a05 ) )
    {
        if ( agent isknownenemyinradius( agent.origin, validtargetdist ) && istrue( agent.var_b43f6cad28078a05 ) )
        {
            agent thread function_55149707e1d77b1e( validtargetdist, agent.scriptgoalpos, var_3e332762c9138001, var_66db74486a8f804 );
            agent.var_b43f6cad28078a05 = 0;
            agent notify( "cancelCombatRush" );
        }
        
        waitframe();
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x1e6c
// Size: 0xf2
function function_55149707e1d77b1e( validtargetdist, var_95f125b69bd6e39e, var_3e332762c9138001, var_66db74486a8f804 )
{
    self notify( "engaging_nearby" );
    self endon( "engaging_nearby" );
    self endon( "death" );
    self setbtgoalpos( 1, self.origin );
    self setbtgoalradius( 1, validtargetdist );
    anchor = self.origin;
    self requestcoverfind( 0, 0 );
    losttimer = 3;
    has_enemy = 1;
    
    while ( has_enemy )
    {
        while ( self isknownenemyinradius( anchor, validtargetdist ) )
        {
            wait 2;
        }
        
        curtime = 0;
        
        for ( has_enemy = 0; curtime <= losttimer && !has_enemy ; has_enemy = 1 )
        {
            wait 1;
            curtime++;
            
            if ( self isknownenemyinradius( anchor, validtargetdist ) )
            {
            }
        }
    }
    
    self clearbtgoal( 1 );
    waitframe();
    thread scripts\mp\ai_behavior::function_a5117518725da028( self, var_95f125b69bd6e39e, 0, undefined, undefined, var_3e332762c9138001, undefined, var_66db74486a8f804 );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x1f66
// Size: 0x90
function function_9af4d877e8bb0ac1( groupname )
{
    group = scripts\stealth\group::getgroup( groupname );
    
    if ( !isdefined( group ) )
    {
        return;
    }
    else
    {
        group.maintaincombat = 1;
    }
    
    waitframe();
    
    foreach ( pod in group.pods )
    {
        pod.var_dff7984130ece673 = 1;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x1ffe
// Size: 0xd9
function function_467f737adf6aeee4( groupname )
{
    group = scripts\stealth\group::getgroup( groupname );
    
    foreach ( pod in group.pods )
    {
        pod.var_dff7984130ece673 = 0;
        
        foreach ( member in pod.members )
        {
            member notify( "endBadPathHandler" );
        }
    }
    
    group.maintaincombat = 0;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x20df
// Size: 0xcb
function function_ba90928315aa754d( groupname )
{
    group = scripts\stealth\group::getgroup( groupname );
    members = [];
    
    foreach ( pod in group.pods )
    {
        foreach ( member in pod.members )
        {
            members[ members.size ] = member;
        }
    }
    
    return members;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x21b3
// Size: 0x52
function ai_watchforbadpath( agent )
{
    level endon( "game_ended" );
    agent endon( "death" );
    agent endon( "endBadPathHandler" );
    
    while ( true )
    {
        agent waittill( "bad_path", badpathpos );
        [[ level.var_9d28d5b70aa9f5e4 ]]( agent, badpathpos );
        agent notify( "endBadPathHandler" );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x220d
// Size: 0x161
function function_9d28d5b70aa9f5e4( agent, badpathpos )
{
    agent notify( "cancelCombatRush" );
    
    if ( isdefined( agent.vehicle ) )
    {
        return;
    }
    
    possiblelocs = level.var_f79746dab56dca8c;
    origin = undefined;
    
    if ( isdefined( possiblelocs ) && possiblelocs.size > 0 )
    {
        possiblelocs = sortbydistance( possiblelocs, badpathpos );
        origin = possiblelocs[ 0 ].origin;
    }
    else
    {
        origin = agent.origin;
    }
    
    dist = distance( agent.origin, origin );
    
    if ( dist >= 12500 )
    {
        assertmsg( "<dev string:x1a3>" + dist + "<dev string:xd8>" + origin + "<dev string:xe6>" + agent.origin );
        agent thread function_9bbf1713a14fa580( agent, 1024 );
    }
    else
    {
        agent function_304da84d9a815c01( origin, 2048 );
        agent setbtgoalpos( 0, origin );
        agent setbtgoalpos( 1, origin );
    }
    
    if ( false )
    {
        thread scripts\mp\utility\debug::drawsphere( agent.origin, 32, 15, ( 1, 0, 1 ) );
        thread scripts\mp\utility\debug::drawsphere( origin, 32, 15, ( 1, 0, 1 ) );
        thread scripts\cp_mp\utility\debug_utility::drawline( agent.origin, origin, 15, ( 1, 1, 0 ) );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x2376
// Size: 0x2d3, Type: bool
function function_5867290fda7a1ac1( spawnpos, spawnradius, checkradius, spawnheight )
{
    if ( !isdefined( checkradius ) )
    {
        checkradius = 1000;
    }
    
    var_4f4704d728a0eb78 = getdvarfloat( @"hash_7cea12faaeb9d47" );
    checkinfluence = 0;
    
    if ( isdefined( var_4f4704d728a0eb78 ) && var_4f4704d728a0eb78 > 0 )
    {
        checkinfluence = ( var_4f4704d728a0eb78 - checkradius ) / var_4f4704d728a0eb78;
    }
    
    influence = getplayerinfluenceatposition( spawnpos, 0 );
    
    if ( isdefined( influence ) && influence > checkinfluence )
    {
        if ( isdefined( spawnheight ) && spawnheight > 0 )
        {
            humanheightoffset = ( 0, 0, spawnheight );
        }
        else
        {
            humanheightoffset = ( 0, 0, 60 );
        }
        
        players = utility::playersincylinder( spawnpos, checkradius );
        
        if ( players.size >= 9 )
        {
            return false;
        }
        
        foreach ( player in players )
        {
            visibility = 0;
            playereyepos = player geteye();
            
            if ( isdefined( spawnradius ) && spawnradius > 100 )
            {
                spawntoplayer = player.origin - spawnpos;
                
                if ( length( spawntoplayer ) < spawnradius + 20 )
                {
                    return false;
                }
                
                leftedge = spawnradius * vectornormalize( rotatevector( spawntoplayer, ( 0, 90, 0 ) ) );
                rightedge = spawnradius * vectornormalize( rotatevector( spawntoplayer, ( 0, -90, 0 ) ) );
                leftedge = getclosestpointonnavmesh( spawnpos + leftedge );
                rightedge = getclosestpointonnavmesh( spawnpos + rightedge );
                leftvisibility = 0;
                rightvisibility = 0;
                middlevisibility = 0;
                
                if ( within_fov( player.origin, player.angles, leftedge, 0 ) )
                {
                    leftvisibility = spawnsighttrace( undefined, leftedge + humanheightoffset, playereyepos );
                }
                
                if ( within_fov( player.origin, player.angles, rightedge, 0 ) )
                {
                    rightvisibility = spawnsighttrace( undefined, rightedge + humanheightoffset, playereyepos );
                }
                
                if ( within_fov( player.origin, player.angles, spawnpos, 0 ) )
                {
                    middlevisibility = spawnsighttrace( undefined, spawnpos + humanheightoffset, playereyepos );
                }
                
                visibility = max( max( leftvisibility, rightvisibility ), middlevisibility );
            }
            else if ( within_fov( player.origin, player.angles, spawnpos, 0 ) )
            {
                visibility = spawnsighttrace( undefined, spawnpos + humanheightoffset, playereyepos );
            }
            
            if ( visibility > 0.1 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x2652
// Size: 0x24e
function function_d378cc95abab583b( origin, poiname )
{
    if ( isdefined( origin ) )
    {
        return origin;
    }
    
    level.var_1b4461e4447da676++;
    
    if ( level.var_1b4461e4447da676 % level.var_3e6588e7a225a933 == 0 )
    {
        possibleplayertargets = [];
        var_e5bf5fac2822316 = level.agentarray;
        
        if ( scripts\mp\poi::poi_isSystemActive() )
        {
            var_e5bf5fac2822316 = aibudgetmp_getagentsanddormantsinpoicategory( poiname, "everybody" );
        }
        
        foreach ( agent in var_e5bf5fac2822316 )
        {
            if ( isdefined( agent.enemy ) && isalive( agent.enemy ) && isplayer( agent.enemy ) )
            {
                possibleplayertargets[ possibleplayertargets.size ] = agent.enemy;
            }
        }
        
        if ( possibleplayertargets.size > 0 )
        {
            player = random( possibleplayertargets );
            return player.origin;
        }
    }
    
    org_struct = [];
    
    if ( poi_isSystemActive() )
    {
        if ( !isdefined( poiname ) )
        {
            poiname = poi_findPOIOriginIsIn( origin );
        }
        
        org_struct = array_combine( level.poi[ poiname ][ "heliReinforceStruct" ].unload_locs, level.poi[ poiname ][ "heliReinforceStruct" ].postlandingdest );
        
        if ( isdefined( level.var_f1073fbd45b59a06.unusedfortresses ) )
        {
            foreach ( fortress in level.var_f1073fbd45b59a06.unusedfortresses )
            {
                if ( fortress.poi == poiname )
                {
                    org_struct[ org_struct.size ] = fortress;
                }
            }
        }
    }
    else
    {
        org_struct = array_combine( level.helireinforcestruct.unload_locs, level.helireinforcestruct.postlandingdest );
    }
    
    return random( org_struct ).origin;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x28a9
// Size: 0x36
function function_e4275ec4ec5dcdd0( agent, origin, radius )
{
    agent endon( "death" );
    
    while ( true )
    {
        wait 4;
        function_304da84d9a815c01( origin, radius );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x28e7
// Size: 0xd3
function function_38eeb3c2a1b3bd14( agent )
{
    level endon( "game_ended" );
    agent endon( "death" );
    agent endon( "alerted_to_player" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && isalive( player ) )
            {
                if ( function_59565896f06f1220( agent, player ) )
                {
                    agent.goalradius = 1024;
                    agent.dont_enter_combat = 0;
                    agent.combatmode = "cover";
                    agent setcanusecover( 1 );
                    agent notify( "alerted_to_player" );
                    return;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x29c2
// Size: 0x69
function function_a0e63fe5c7a71428( agent )
{
    level endon( "game_ended" );
    agent endon( "death" );
    agent endon( "alerted_to_player" );
    agent waittill( "damage", idamage, eattacker );
    agent.goalradius = 250;
    agent.dont_enter_combat = 0;
    agent setcanusecover( 0 );
    agent notify( "alerted_to_player" );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x2a33
// Size: 0x55, Type: bool
function function_59565896f06f1220( agent, player )
{
    incloserange = distance( agent.origin, player.origin ) <= 256;
    inplainsight = agent cansee( player );
    return incloserange && inplainsight;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x2a91
// Size: 0x104
function function_a80e7e8f2c9d73c( event )
{
    agent = self;
    level endon( "game_ended" );
    agent endon( "death" );
    
    if ( !scripts\mp\flags::gameflagexists( "prematch_done" ) || scripts\mp\flags::gameflagexists( "prematch_done" ) && !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( randomint( 100 ) < 50 )
    {
        agent scripts\stealth\enemy::bt_set_stealth_state( "combat", undefined );
    }
    
    wait randomintrange( 8, 11 );
    agent scripts\stealth\enemy::bt_set_stealth_state( "combat", undefined );
    
    if ( level.var_58ac9ebcf7b87b73 + level.var_d362d0481275de02 > gettime() && randomint( 100 ) < level.var_2ef1c744d35b6312 )
    {
        level thread scripts\mp\ai_mp_controller::function_77acc10c4823dd8a( 3, event.origin, "medium", "reinforcements", "foundCorpse", undefined, agent.team, 1, agent.poi );
        level.var_58ac9ebcf7b87b73 = gettime();
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x2b9d
// Size: 0xb1
function function_810a6443bde30366( origin, radius, var_68ca75f051e913a )
{
    agents = utility::function_2d7fd59d039fa69b( origin, radius, 0 );
    
    if ( !isdefined( var_68ca75f051e913a ) )
    {
        var_68ca75f051e913a = origin;
    }
    
    foreach ( agent in agents )
    {
        if ( isdefined( agent.unittype ) && agent.unittype == "civilian" )
        {
            continue;
        }
        
        agent aieventlistenerevent( "gunshot", self, var_68ca75f051e913a );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x2c56
// Size: 0xe1
function function_4c61a6fd42fa58( nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25 )
{
    assert( isdefined( nodes ) );
    
    if ( isarray( nodes ) && nodes.size < 1 )
    {
        nodes = self.spawnpoint function_9abbce4b66ee25d4();
        
        if ( nodes.size == 0 )
        {
            self notify( "reached_path_end" );
            
            if ( isdefined( optional_arrived_at_node_func ) )
            {
                [[ optional_arrived_at_node_func ]]();
            }
            
            return;
        }
    }
    else if ( !isarray( nodes ) )
    {
        nodes = [ nodes ];
    }
    
    for ( i = 0; i < nodes.size ; i++ )
    {
        if ( isvector( nodes[ i ] ) )
        {
            struct = spawnstruct();
            struct.origin = nodes[ i ];
            struct.angles = ( 0, 0, 0 );
            nodes[ i ] = struct;
        }
    }
    
    function_db64d1e0f2b06482( nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25 );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x2d3f
// Size: 0x3b
function function_9abbce4b66ee25d4()
{
    path_array = function_ee9a5bcd6b164ce2();
    
    if ( path_array.size < 1 )
    {
        if ( isdefined( self.target ) )
        {
            path_array = function_697e9bf539bed8b6( self.target );
        }
    }
    
    return path_array;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x2d83
// Size: 0xc1
function function_697e9bf539bed8b6( target )
{
    goals = getnodearray( target, "targetname" );
    new_goals = getstructarray( target, "targetname" );
    
    foreach ( new in new_goals )
    {
        goals[ goals.size ] = new;
    }
    
    new_goals = getentarray( target, "targetname" );
    
    for ( i = 0; i < new_goals.size ; i++ )
    {
        new = new_goals[ i ];
        
        if ( !function_f2d40d9b75cbc023( new ) )
        {
            continue;
        }
        
        goals[ goals.size ] = new;
    }
    
    return goals;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x2e4d
// Size: 0x5d, Type: bool
function function_f2d40d9b75cbc023( object )
{
    if ( isspawner( object ) )
    {
        return false;
    }
    
    switch ( object.code_classname )
    {
        case #"hash_1b79c5d9e0f9886a":
        case #"hash_5e0756fcd4e0adcd":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_81903cb95a447b8c":
            return false;
    }
    
    return true;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x2eb3
// Size: 0x58
function function_ee9a5bcd6b164ce2()
{
    goals = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linked_ents = get_linked_ents();
        linked_structs = get_linked_structs();
        linked_nodes = get_linked_nodes();
        goals = array_combine( linked_ents, linked_structs, linked_nodes );
    }
    
    return goals;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x2f14
// Size: 0x64
function _behavior_gotonodeend()
{
    self notify( "_behavior_gotoNodeEnd" );
    self endon( "_behavior_gotoNodeEnd" );
    self endon( "death" );
    level endon( "game_ended" );
    self.using_goto_node = 1;
    result = waittill_any_return_2( "reached_path_end", "stop_going_to_node" );
    self.using_goto_node = undefined;
    self.patharray = undefined;
    self.patharrayindex = undefined;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x2f80
// Size: 0xbb
function function_95419b47267b7dea( array )
{
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    array = array_randomize( array );
    least_used = array[ 0 ];
    
    if ( !isdefined( least_used.used_time ) )
    {
        least_used.used_time = 0;
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        node = array[ i ];
        
        if ( !isdefined( node.used_time ) )
        {
            node.used_time = 0;
        }
        
        if ( node.used_time < least_used.used_time )
        {
            least_used = node;
        }
    }
    
    least_used.used_time = gettime();
    return least_used;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x3044
// Size: 0xa2
function function_db4ad034e4606091( node, startnode )
{
    array = [];
    count = 0;
    
    while ( true )
    {
        array[ array.size ] = node;
        count++;
        
        if ( count == 16 )
        {
            break;
        }
        
        if ( function_91dff8e3ec6780c3( node ) )
        {
            break;
        }
        
        if ( !isdefined( node.target ) && !isdefined( node.script_linkto ) )
        {
            break;
        }
        
        nextnode_array = node function_9abbce4b66ee25d4();
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        node = function_95419b47267b7dea( nextnode_array );
        
        if ( node == startnode )
        {
            break;
        }
    }
    
    return array;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x30ef
// Size: 0xb2
function function_d0ea0bd3d1a6c928( patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25 )
{
    self setgoalpath( patharray );
    
    for ( i = 0; i < patharray.size ; i++ )
    {
        index = i;
        tempnode = patharray[ i ];
        self.currentnode = tempnode;
        function_4dea69a8c26a5378( tempnode );
        patharrayindex = waittill_subgoal();
        
        if ( index == patharray.size - 1 )
        {
            self waittill( "goal" );
            break;
        }
        
        tempnode notify( "trigger", self );
        function_8d1fd30657566aea( tempnode, optional_arrived_at_node_func );
        function_ef3a20cdb3c82b48( tempnode );
        function_5dcbed48df675e1( tempnode, var_5e38f20c9628ae25 );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x31a9
// Size: 0x24, Type: bool
function is_specified_unittype( unittype )
{
    return isdefined( self.unittype ) && self.unittype == unittype;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x31d6
// Size: 0x43
function function_43c2f1d3946e3ea8( demeanor )
{
    demeanor = function_cd64ed2eddf5cb1c( demeanor );
    
    if ( is_specified_unittype( "civilian" ) )
    {
        scripts\asm\asm_bb::bb_setcivilianstate( demeanor );
        return;
    }
    
    if ( !is_specified_unittype( "juggernaut" ) )
    {
        utility::demeanor_override( demeanor );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x3221
// Size: 0x40
function function_cd64ed2eddf5cb1c( demeanor )
{
    switch ( demeanor )
    {
        case #"hash_46fdaf04e9be63e4":
        case #"hash_d320ccf96c495f71":
            return "patrol";
        default:
            return demeanor;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x3269
// Size: 0xb
function function_4dea69a8c26a5378( node )
{
    
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x327c
// Size: 0x80
function function_8d1fd30657566aea( node, optional_arrived_at_node_func )
{
    if ( isdefined( optional_arrived_at_node_func ) )
    {
        [[ optional_arrived_at_node_func ]]( node );
    }
    
    if ( isdefined( node.script_flag_set ) )
    {
        flag_set( node.script_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_set ) )
    {
        ent_flag_set( node.script_ent_flag_set );
    }
    
    if ( isdefined( node.script_flag_clear ) )
    {
        flag_clear( node.script_flag_clear );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x3304
// Size: 0x123
function function_ef3a20cdb3c82b48( node )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( !istrue( level.global_stealth_broken ) && !istrue( self.entered_combat ) && isdefined( node.script_animation_type ) )
    {
        var_dd1921916c4e99c7 = undefined;
        var_4b7479ae0df07570 = strtok( node.script_animation_type, "," );
        var_dd1921916c4e99c7 = random( var_4b7479ae0df07570 );
        
        if ( isdefined( var_dd1921916c4e99c7 ) )
        {
            if ( !istrue( node.script_looping ) )
            {
                self.single_loop = 1;
            }
            else
            {
                self.single_loop = undefined;
            }
            
            /#
                print3d( self.origin + ( 0, 0, 64 ), "<dev string:x1e8>" + node.script_animation_type, ( 1, 1, 0 ), 1, 0.5, 60, 1 );
            #/
            
            self.playing_skit = 1;
            function_fde914f2364973e2( node, var_dd1921916c4e99c7 );
            self.playing_skit = undefined;
            
            while ( istrue( self.playing_skit ) )
            {
                wait 0.05;
            }
        }
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x342f
// Size: 0x7b
function function_fde914f2364973e2( node, var_dd1921916c4e99c7 )
{
    self endon( "death" );
    
    if ( istrue( self.single_loop ) )
    {
        self endon( "patrol_" + var_dd1921916c4e99c7 + "_loop" );
    }
    
    _setgoalpos( node.origin, undefined, 1 );
    self thread [[ level.spawn_skits[ var_dd1921916c4e99c7 ].skit_func ]]();
    
    while ( istrue( self.playing_skit ) )
    {
        wait 0.05;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x34b2
// Size: 0x15e
function function_5dcbed48df675e1( node, var_5e38f20c9628ae25 )
{
    if ( isdefined( node.script_soundalias ) )
    {
        if ( soundexists( node.script_soundalias ) )
        {
            self playsound( node.script_soundalias );
        }
    }
    
    if ( isdefined( node.script_forcegoal ) )
    {
        function_c6930ac29fe6ff53( node.script_forcegoal );
    }
    
    if ( isdefined( self.post_wait_func ) )
    {
        [[ self.post_wait_func ]]();
    }
    
    if ( isdefined( node.script_delay_post ) )
    {
        wait node.script_delay_post;
    }
    
    while ( isdefined( node.script_requires_player ) )
    {
        node.script_requires_player = 0;
        
        if ( function_557601291bb22faa( node, &function_9abbce4b66ee25d4 ) )
        {
            node.script_requires_player = 1;
            node notify( "script_requires_player" );
            break;
        }
        
        wait 0.25;
    }
    
    if ( isdefined( node.script_demeanor_post ) )
    {
        function_43c2f1d3946e3ea8( node.script_demeanor_post );
    }
    
    if ( isdefined( var_5e38f20c9628ae25 ) )
    {
        [[ var_5e38f20c9628ae25 ]]( node );
    }
    
    if ( isdefined( node.script_death ) && node.script_death )
    {
        scripts\cp_mp\agents\agent_utils::despawnagent();
    }
    
    if ( isdefined( node.script_delete ) && node.script_delete )
    {
        self delete();
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x3618
// Size: 0x216
function function_557601291bb22faa( node, get_target_func )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( distancesquared( player.origin, node.origin ) < distancesquared( self.origin, node.origin ) )
        {
            return 1;
        }
        
        if ( !isdefined( node.script_dist_only ) )
        {
            vec = anglestoforward( self.angles );
            
            if ( isdefined( node.target ) )
            {
                temp = node [[ get_target_func ]]( node.target );
                
                if ( temp.size == 1 )
                {
                    vec = vectornormalize( temp[ 0 ].origin - node.origin );
                }
                else if ( isdefined( node.angles ) )
                {
                    vec = anglestoforward( node.angles );
                }
            }
            else if ( isdefined( node.angles ) )
            {
                vec = anglestoforward( node.angles );
            }
            
            vec2 = [];
            vec2[ vec2.size ] = vectornormalize( player.origin - self.origin );
            
            foreach ( value in vec2 )
            {
                if ( vectordot( vec, value ) > 0 )
                {
                    return 1;
                }
            }
        }
        
        dist = 300;
        
        if ( node.script_requires_player > dist )
        {
            dist = node.script_requires_player;
        }
        
        if ( distancesquared( player.origin, self.origin ) < squared( dist ) )
        {
            return 1;
        }
        
        return 0;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x3836
// Size: 0x1e
function waittill_subgoal()
{
    self endon( "goal" );
    self waittill( "subgoal", index );
    return index;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x385d
// Size: 0x110, Type: bool
function function_91dff8e3ec6780c3( arrivaltarget )
{
    if ( !isdefined( arrivaltarget ) )
    {
        return true;
    }
    
    if ( !isdefined( arrivaltarget.target ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_add ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_ent_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_post ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_requires_player ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_idle ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_stopnode ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x3976
// Size: 0x1e9
function function_db64d1e0f2b06482( node, optional_arrived_at_node_func, var_5e38f20c9628ae25 )
{
    self notify( "stop_going_to_node" );
    self endon( "stop_going_to_node" );
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( !isarray( node ) )
    {
        node = [ node ];
    }
    
    thread _behavior_gotonodeend();
    usingpatharray = 0;
    patharrayindex = 0;
    patharray = undefined;
    startnode = node[ 0 ];
    
    for ( ;; )
    {
        if ( !usingpatharray )
        {
            node = function_95419b47267b7dea( node );
            patharray = function_db4ad034e4606091( node, startnode );
            
            if ( patharray.size > 1 )
            {
                usingpatharray = 1;
            }
        }
        
        self.currentnode = node;
        
        if ( usingpatharray )
        {
            node = patharray[ patharray.size - 1 ];
            function_d0ea0bd3d1a6c928( patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25 );
            patharray = undefined;
            usingpatharray = 0;
        }
        else
        {
            function_4dea69a8c26a5378( node );
            function_e04e9f343593bf4e( node );
            self waittill( "goal" );
        }
        
        node notify( "trigger", self );
        function_8d1fd30657566aea( node, optional_arrived_at_node_func );
        function_ef3a20cdb3c82b48( node );
        node script_delay();
        
        if ( isdefined( node.script_flag_wait ) )
        {
            flag_wait( node.script_flag_wait );
        }
        
        if ( isdefined( node.script_ent_flag_wait ) )
        {
            ent_flag_wait( node.script_ent_flag_wait );
        }
        
        node script_wait();
        function_5dcbed48df675e1( node, var_5e38f20c9628ae25 );
        
        if ( !isdefined( node.target ) && !isdefined( node.script_linkto ) )
        {
            break;
        }
        
        nextnode_array = node function_9abbce4b66ee25d4();
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        node = nextnode_array;
    }
    
    self notify( "reached_path_end" );
    
    if ( isdefined( self.script_forcegoal ) )
    {
        return;
    }
    
    volume = self getgoalvolume();
    
    if ( isdefined( volume ) )
    {
        self setgoalvolumeauto( volume, volume function_4b6a41e8b3ee5932() );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x3b67
// Size: 0x26
function function_4b6a41e8b3ee5932()
{
    if ( isdefined( self.goalvolumecoveryaw ) )
    {
        return anglestoforward( ( 0, self.goalvolumecoveryaw, 0 ) );
    }
    
    return undefined;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x3b95
// Size: 0x1b
function function_a2ffe923e7d0a34c( node )
{
    function_aa8f023c16fc448d( node );
    self notify( "go_to_node_new_goal" );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x3bb8
// Size: 0x6a
function function_e04e9f343593bf4e( ent )
{
    if ( isnode( ent ) )
    {
        function_a2ffe923e7d0a34c( ent );
    }
    else if ( isstruct( ent ) )
    {
        function_dae5fd9c1e198e1a( ent );
    }
    else if ( isent( ent ) )
    {
        function_3cfe299baaf790b5( ent );
    }
    
    if ( isstruct( ent ) || isnode( ent ) )
    {
        ent.patrol_stop = function_91dff8e3ec6780c3( ent );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x3c2a
// Size: 0x3f
function function_3cfe299baaf790b5( ent )
{
    if ( ent.code_classname == "info_volume" )
    {
        self setgoalvolumeauto( ent, ent function_4b6a41e8b3ee5932() );
        self notify( "go_to_node_new_goal" );
        return;
    }
    
    function_dae5fd9c1e198e1a( ent );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x3c71
// Size: 0x25
function function_dae5fd9c1e198e1a( ent )
{
    _setgoalpos( ent.origin );
    self notify( "go_to_node_new_goal" );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x3c9e
// Size: 0x5c
function function_37e5a190e3c946d5( agent, behaviorpackage )
{
    if ( isagent( agent ) )
    {
        agent.behaviorpackage = behaviorpackage;
        return;
    }
    
    if ( isint( agent ) && isdefined( level.var_879053468f168806[ agent ] ) )
    {
        level.var_879053468f168806[ agent ].behaviorpackage = behaviorpackage;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0x3d02
// Size: 0x4a
function function_d1e130608e4f8487( agent, origin, var_ba8b04eb4b683e67, combatcenter, combatradius )
{
    behaviorpackage = function_2f254cf573da1a36( origin, var_ba8b04eb4b683e67, combatcenter, combatradius );
    function_37e5a190e3c946d5( agent, behaviorpackage );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x3d54
// Size: 0x85
function function_2f254cf573da1a36( origin, var_ba8b04eb4b683e67, combatcenter, combatradius )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "guard";
    behaviorpackage.origin = origin;
    behaviorpackage.var_ba8b04eb4b683e67 = var_ba8b04eb4b683e67;
    
    if ( isdefined( combatcenter ) && isdefined( combatradius ) )
    {
        behaviorpackage.combatcenter = combatcenter;
        behaviorpackage.combatradius = combatradius;
    }
    
    return behaviorpackage;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x3de2
// Size: 0x41
function function_e786aa52b93833eb( agent, origin, radius, radiusvariance )
{
    behaviorpackage = function_f592b31e1a9c245c( origin, radius, radiusvariance );
    function_37e5a190e3c946d5( agent, behaviorpackage );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x3e2b
// Size: 0x65
function function_f592b31e1a9c245c( origin, radius, radiusvariance )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "wander";
    behaviorpackage.origin = origin;
    behaviorpackage.radius = radius;
    behaviorpackage.radiusvariance = radiusvariance;
    return behaviorpackage;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x3e99
// Size: 0x41
function function_fe5620595915170f( agent, origin, radius, radiusvariance )
{
    behaviorpackage = function_f9a6beb9ce9044e8( origin, radius, radiusvariance );
    function_37e5a190e3c946d5( agent, behaviorpackage );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x3ee2
// Size: 0x65
function function_f9a6beb9ce9044e8( origin, radius, radiusvariance )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "combatwander";
    behaviorpackage.origin = origin;
    behaviorpackage.radius = radius;
    behaviorpackage.radiusvariance = radiusvariance;
    return behaviorpackage;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0x3f50
// Size: 0x4a
function function_4561fe6bfc76f8ec( agent, var_886dfa499937a071, pathstruct, combatcenter, combatradius )
{
    behaviorpackage = function_57d602c47bb19473( var_886dfa499937a071, pathstruct, combatcenter, combatradius );
    function_37e5a190e3c946d5( agent, behaviorpackage );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x3fa2
// Size: 0x85
function function_57d602c47bb19473( var_886dfa499937a071, pathstruct, combatcenter, combatradius )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "patrol";
    behaviorpackage.pathstruct = pathstruct;
    behaviorpackage.var_886dfa499937a071 = var_886dfa499937a071;
    
    if ( isdefined( combatcenter ) && isdefined( combatradius ) )
    {
        behaviorpackage.combatcenter = combatcenter;
        behaviorpackage.combatradius = combatradius;
    }
    
    return behaviorpackage;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 8
// Checksum 0x0, Offset: 0x4030
// Size: 0x68
function function_bd9acc7c99ad884( agent, reinforceorigin, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 )
{
    behaviorpackage = function_4b8038fe29027d5f( reinforceorigin, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 );
    function_37e5a190e3c946d5( agent, behaviorpackage );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 7
// Checksum 0x0, Offset: 0x40a0
// Size: 0xbb
function function_4b8038fe29027d5f( reinforceorigin, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "combatRush";
    behaviorpackage.reinforceorigin = reinforceorigin;
    behaviorpackage.var_e298cec41261345c = var_e298cec41261345c;
    behaviorpackage.goalradiusoverride = goalradiusoverride;
    behaviorpackage.var_21f24aecb313e479 = var_21f24aecb313e479;
    behaviorpackage.var_3e332762c9138001 = var_3e332762c9138001;
    behaviorpackage.rushgroup = rushgroup;
    behaviorpackage.var_1b3d1c2f22b62206 = var_1b3d1c2f22b62206;
    return behaviorpackage;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 8
// Checksum 0x0, Offset: 0x4164
// Size: 0x68
function function_6e3dd46c3475cd2d( agent, var_2bd923437ecc04bd, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 )
{
    behaviorpackage = function_4b8735c04ece8334( var_2bd923437ecc04bd, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 );
    function_37e5a190e3c946d5( agent, behaviorpackage );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 7
// Checksum 0x0, Offset: 0x41d4
// Size: 0xbb
function function_4b8735c04ece8334( var_2bd923437ecc04bd, var_e298cec41261345c, goalradiusoverride, var_21f24aecb313e479, var_3e332762c9138001, rushgroup, var_1b3d1c2f22b62206 )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "combatRushChain";
    behaviorpackage.var_2bd923437ecc04bd = var_2bd923437ecc04bd;
    behaviorpackage.var_e298cec41261345c = var_e298cec41261345c;
    behaviorpackage.goalradiusoverride = goalradiusoverride;
    behaviorpackage.var_21f24aecb313e479 = var_21f24aecb313e479;
    behaviorpackage.var_3e332762c9138001 = var_3e332762c9138001;
    behaviorpackage.rushgroup = rushgroup;
    behaviorpackage.var_1b3d1c2f22b62206 = var_1b3d1c2f22b62206;
    return behaviorpackage;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0x4298
// Size: 0x4a
function function_29b1f7f88b879860( agent, cqbnodes, var_bc0d4c6360efc237, var_c7988fd0b09710bc, var_3431921fac306239 )
{
    behaviorpackage = function_d9b313747ecdf8a9( cqbnodes, var_bc0d4c6360efc237, var_c7988fd0b09710bc, var_3431921fac306239 );
    function_37e5a190e3c946d5( agent, behaviorpackage );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x42ea
// Size: 0x7a
function function_d9b313747ecdf8a9( cqbnodes, var_bc0d4c6360efc237, var_c7988fd0b09710bc, var_3431921fac306239 )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "cqb";
    behaviorpackage.cqbnodes = cqbnodes;
    behaviorpackage.var_bc0d4c6360efc237 = var_bc0d4c6360efc237;
    behaviorpackage.var_c7988fd0b09710bc = var_c7988fd0b09710bc;
    behaviorpackage.var_3431921fac306239 = var_3431921fac306239;
    return behaviorpackage;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x436d
// Size: 0x61
function function_f0c78111ce0cdc0a( agent )
{
    if ( isagent( agent ) )
    {
        return agent.behaviorpackage;
    }
    else if ( isint( agent ) && isdefined( level.var_879053468f168806 ) && isdefined( level.var_879053468f168806[ agent ] ) )
    {
        return level.var_879053468f168806[ agent ].behaviorpackage;
    }
    
    return undefined;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x43d7
// Size: 0x31c
function behavior_executebehaviorpackage( agent )
{
    agent endon( "death" );
    
    if ( !isdefined( agent.behaviorpackage ) )
    {
        return;
    }
    
    switch ( agent.behaviorpackage.behavior )
    {
        case #"hash_7df245010bdec44e":
            agent thread function_b11c1964f528574b( agent, agent.behaviorpackage.var_ba8b04eb4b683e67, agent.behaviorpackage.origin );
            break;
        case #"hash_4e0c042fa0220574":
            if ( isdefined( level.var_1c8cbd78af4920d0 ) )
            {
                agent thread [[ level.var_1c8cbd78af4920d0 ]]( agent, agent.behaviorpackage.radius, agent.behaviorpackage.radiusvariance, agent.behaviorpackage.origin );
            }
            else
            {
                agent thread function_9bbf1713a14fa580( agent, agent.behaviorpackage.radius, agent.behaviorpackage.radiusvariance, agent.behaviorpackage.origin );
            }
            
            break;
        case #"hash_f18555ca1d8ebdc0":
            agent thread function_a057ee9adc9547d5( agent, agent.behaviorpackage.radius, agent.behaviorpackage.radiusvariance, agent.behaviorpackage.origin );
            break;
        case #"hash_9128327eb51e0b7b":
            level thread behavior_patrol( [ agent ], agent.behaviorpackage.pathstruct );
            break;
        case #"hash_10c1fbec939bdcf7":
            bp = agent.behaviorpackage;
            assertex( distance( agent.origin, bp.reinforceorigin ) < 12500, "<dev string:x1f2>" );
            agent thread function_a5117518725da028( agent, bp.reinforceorigin, bp.var_e298cec41261345c, bp.goalradiusoverride, bp.var_21f24aecb313e479, bp.var_3e332762c9138001, bp.rushgroup );
            break;
        case #"hash_baf8d28f880e18c":
            bp = agent.behaviorpackage;
            agent thread function_65f6a39e1083fb6b( agent, bp.var_2bd923437ecc04bd, bp.var_e298cec41261345c, bp.goalradiusoverride, bp.var_21f24aecb313e479, bp.var_3e332762c9138001, bp.rushgroup );
            break;
        case #"hash_1a53266c17b7d481":
            bp = agent.behaviorpackage;
            agent thread behavior_cqb( agent, bp.cqbnodes, bp.var_bc0d4c6360efc237, bp.var_c7988fd0b09710bc, bp.var_3431921fac306239 );
            break;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x46fb
// Size: 0x7a
function function_8dad0c97c82fb52f( agent, targetent )
{
    node = agent findbestcovernode( undefined, 0, agent.origin );
    
    if ( isdefined( node ) )
    {
        if ( !isdefined( agent.node ) || agent.node != node )
        {
            agent.keepclaimednode = 0;
            agent.keepclaimednodeifvalid = 0;
            agent usecovernode( node );
        }
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0x477d
// Size: 0x167
function behavior_cqb( agent, cqbnodes, var_bc0d4c6360efc237, var_c7988fd0b09710bc, var_3431921fac306239 )
{
    function_29b1f7f88b879860( agent, cqbnodes, var_bc0d4c6360efc237, var_c7988fd0b09710bc, var_3431921fac306239 );
    
    if ( isint( agent ) )
    {
        return;
    }
    
    if ( !isdefined( cqbnodes ) || cqbnodes.size == 0 )
    {
        cqbstruct = function_2e33f8e46f95167c( agent.origin, 512, 1 );
        cqbnodes = array_combine( cqbstruct.var_e67f0b2ea7ae69ed, cqbstruct.var_8a055a821dda7da0 );
        
        if ( cqbnodes.size < 2 )
        {
            cqbnodes = array_combine( cqbnodes, cqbstruct.var_3288c473e8336ab4 );
        }
        
        if ( cqbnodes.size == 0 )
        {
            return;
        }
        
        cqbnodes = function_3a17f0ccddc999b4( agent.origin, cqbnodes, 2 );
        
        if ( cqbnodes.size == 0 )
        {
            return;
        }
        
        cqbnodes = array_randomize( cqbnodes );
    }
    
    agent.balwayscoverexposed = 1;
    function_2b26d000f2ccfc11( agent, cqbnodes[ 0 ] );
    agent thread function_64045ea3246c7b09( agent, cqbnodes[ 0 ].origin, var_bc0d4c6360efc237, var_c7988fd0b09710bc, var_3431921fac306239 );
    
    if ( !isdefined( cqbnodes[ 0 ].script_noteworthy ) || isdefined( cqbnodes[ 0 ].script_noteworthy ) && !issubstr( cqbnodes[ 0 ].script_noteworthy, "dont_move" ) )
    {
        agent thread function_c78dddf4b72b2bb8( agent, cqbnodes );
        return;
    }
    
    agent thread scripts\mp\ai_behavior::function_a1d0e5ea1a887436( agent, cqbnodes[ 0 ] );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x48ec
// Size: 0x167
function function_2e33f8e46f95167c( origin, searchradius, var_d0e8277402331171 )
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    var_e67f0b2ea7ae69ed = [];
    var_8a055a821dda7da0 = [];
    var_3288c473e8336ab4 = [];
    nodesaround = getnodesinradius( origin, searchradius, 0, searchradius );
    
    foreach ( node in nodesaround )
    {
        if ( isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "cqb_node" ) )
        {
            if ( issubstr( node.script_noteworthy, "dont_move" ) )
            {
                var_8a055a821dda7da0[ var_8a055a821dda7da0.size ] = node;
            }
            else
            {
                var_e67f0b2ea7ae69ed[ var_e67f0b2ea7ae69ed.size ] = node;
            }
            
            continue;
        }
        
        if ( istrue( var_d0e8277402331171 ) && node.type != "path" )
        {
            var_3288c473e8336ab4[ var_3288c473e8336ab4.size ] = node;
        }
    }
    
    struct = spawnstruct();
    struct.var_e67f0b2ea7ae69ed = array_randomize( var_e67f0b2ea7ae69ed );
    struct.var_8a055a821dda7da0 = array_randomize( var_8a055a821dda7da0 );
    struct.var_3288c473e8336ab4 = array_randomize( var_3288c473e8336ab4 );
    return struct;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x4a5c
// Size: 0x1e8
function function_b60b5affd510926c( fortress, var_d0e8277402331171 )
{
    searchradius = 1024;
    
    if ( isdefined( fortress.var_1a4d8a1df4da9847 ) )
    {
        searchradius = fortress.var_1a4d8a1df4da9847;
    }
    else if ( fortress.var_c8c070d7375ef1e == "hero" )
    {
        searchradius = 2560;
    }
    
    struct = function_2e33f8e46f95167c( fortress.origin, searchradius, var_d0e8277402331171 );
    temparray = [];
    
    foreach ( node in struct.var_e67f0b2ea7ae69ed )
    {
        if ( namespace_9823ee6035594d67::function_20f6e9317b1baf3d( node.origin, fortress ) )
        {
            temparray[ temparray.size ] = node;
        }
    }
    
    fortress.var_e67f0b2ea7ae69ed = temparray;
    temparray = [];
    
    foreach ( node in struct.var_8a055a821dda7da0 )
    {
        if ( namespace_9823ee6035594d67::function_20f6e9317b1baf3d( node.origin, fortress ) )
        {
            temparray[ temparray.size ] = node;
        }
    }
    
    fortress.var_8a055a821dda7da0 = temparray;
    temparray = [];
    
    if ( istrue( var_d0e8277402331171 ) )
    {
        foreach ( node in struct.var_3288c473e8336ab4 )
        {
            if ( namespace_9823ee6035594d67::function_20f6e9317b1baf3d( node.origin, fortress ) )
            {
                temparray[ temparray.size ] = node;
            }
        }
    }
    
    fortress.var_3288c473e8336ab4 = temparray;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x4c4c
// Size: 0x6a
function function_984e27d6c139a63d( cqbnodes )
{
    cqbnodes = array_randomize( cqbnodes );
    
    foreach ( node in cqbnodes )
    {
        if ( !istrue( node.claimed ) )
        {
            return node;
        }
    }
    
    return undefined;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0x4cbf
// Size: 0x30b
function function_3a17f0ccddc999b4( origin, cqbnodes, numnodes, maxheightdifference, var_d557a0584f34f219 )
{
    nodessorted = sortbydistance( cqbnodes, origin );
    selectednodes = [];
    var_5ad587bdaec2c87a = 16384;
    
    if ( !isdefined( numnodes ) )
    {
        numnodes = 1;
    }
    
    if ( !isdefined( maxheightdifference ) )
    {
        maxheightdifference = 75;
    }
    
    foreach ( node in nodessorted )
    {
        if ( selectednodes.size == numnodes )
        {
            return selectednodes;
        }
        
        if ( istrue( node.reserved ) )
        {
            continue;
        }
        
        if ( !istrue( var_d557a0584f34f219 ) && istrue( node.claimed ) )
        {
            continue;
        }
        
        if ( abs( origin[ 2 ] - node.origin[ 2 ] ) >= maxheightdifference )
        {
            continue;
        }
        
        nodetooclose = 0;
        
        foreach ( selectednode in selectednodes )
        {
            if ( distance2dsquared( selectednode.origin, node.origin ) < var_5ad587bdaec2c87a )
            {
                nodetooclose = 1;
                break;
            }
        }
        
        if ( nodetooclose )
        {
            continue;
        }
        
        var_5dee42277bb33b87 = isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "dont_move" );
        
        if ( var_5dee42277bb33b87 && selectednodes.size > 0 )
        {
            continue;
        }
        
        node.reserved = 1;
        selectednodes[ selectednodes.size ] = node;
        
        if ( var_5dee42277bb33b87 )
        {
            return selectednodes;
        }
    }
    
    foreach ( node in nodessorted )
    {
        if ( selectednodes.size == numnodes )
        {
            return selectednodes;
        }
        
        if ( !istrue( var_d557a0584f34f219 ) && istrue( node.claimed ) )
        {
            continue;
        }
        
        if ( abs( origin[ 2 ] - node.origin[ 2 ] ) >= maxheightdifference )
        {
            continue;
        }
        
        foreach ( selectednode in selectednodes )
        {
            if ( distance2dsquared( selectednode.origin, node.origin ) < var_5ad587bdaec2c87a )
            {
            }
        }
        
        var_5dee42277bb33b87 = isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "dont_move" );
        
        if ( var_5dee42277bb33b87 && selectednodes.size > 0 )
        {
            continue;
        }
        
        selectednodes[ selectednodes.size ] = node;
        
        if ( var_5dee42277bb33b87 )
        {
            return selectednodes;
        }
    }
    
    return selectednodes;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x4fd3
// Size: 0x1e
function cqb_claimnode( node )
{
    if ( isdefined( node ) )
    {
        node.claimed = 1;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 1
// Checksum 0x0, Offset: 0x4ff9
// Size: 0x1d
function cqb_releaseNode( node )
{
    if ( isdefined( node ) )
    {
        node.claimed = 0;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x501e
// Size: 0x88, Type: bool
function function_2b26d000f2ccfc11( agent, node )
{
    if ( !isdefined( node ) || istrue( node.claimed ) )
    {
        return false;
    }
    
    self.keepclaimednode = 0;
    agent.keepclaimednode = 0;
    cqb_claimnode( node );
    scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata( agent, "cqbNode", node );
    agent usecovernode( node );
    agent function_304da84d9a815c01( node.origin, 32 );
    agent.alertlevel = "combat";
    return true;
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 4
// Checksum 0x0, Offset: 0x50af
// Size: 0x125
function function_c78dddf4b72b2bb8( agent, nodes, waitmin, waitmax )
{
    agent endon( "death" );
    agent endon( "endCQB" );
    
    if ( !isdefined( nodes ) || nodes.size <= 1 )
    {
        return;
    }
    
    if ( !isdefined( waitmin ) )
    {
        waitmin = 8;
    }
    
    if ( !isdefined( waitmax ) )
    {
        waitmax = 12;
    }
    
    switchtime = randomintrange( waitmin, waitmax );
    currenttime = 0;
    interval = 1;
    var_8c36129f39216b9a = 0;
    node = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata( agent, "cqbNode" );
    
    if ( !isdefined( node ) )
    {
        node = function_984e27d6c139a63d( nodes );
        var_8c36129f39216b9a = function_2b26d000f2ccfc11( agent, node );
        thread function_a1d0e5ea1a887436( agent, node, switchtime );
    }
    
    while ( true )
    {
        if ( currenttime >= switchtime )
        {
            switchtime = randomintrange( waitmin, waitmax );
            currenttime = 0;
            
            if ( !agent isinscriptedstate() )
            {
                if ( var_8c36129f39216b9a )
                {
                    cqb_releaseNode( node );
                }
                
                node = function_984e27d6c139a63d( nodes );
                var_8c36129f39216b9a = function_2b26d000f2ccfc11( agent, node );
                thread function_a1d0e5ea1a887436( agent, node, switchtime );
            }
        }
        
        wait 1;
        currenttime += interval;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 5
// Checksum 0x0, Offset: 0x51dc
// Size: 0x22a
function function_64045ea3246c7b09( agent, origin, var_bc0d4c6360efc237, var_c7988fd0b09710bc, var_3431921fac306239 )
{
    agent endon( "death" );
    interval = 1;
    lastshoottime = agent._blackboard.shootparams_lastshoottime;
    lastenemy = agent.enemy;
    var_4fd41aadc35b28e0 = 0;
    var_509b688b66616418 = 1;
    enemylist = [];
    var_149518f76f493448 = 0;
    var_15864b7b1533b47d = 0;
    var_7d91e6095747f0b2 = 2;
    
    while ( var_509b688b66616418 )
    {
        foreach ( enemy in enemylist )
        {
            var_31ca5dbbe353500 = isalive( enemy );
            canseeenemy = undefined;
            
            if ( var_31ca5dbbe353500 )
            {
                canseeenemy = agent cansee( enemy );
            }
            
            if ( !istrue( var_31ca5dbbe353500 ) || !istrue( canseeenemy ) || istrue( canseeenemy ) && ( istrue( enemy.inlaststand ) || !isalive( enemy ) ) )
            {
                enemylist = array_remove( enemylist, enemy );
            }
        }
        
        enemy = agent.enemy;
        
        if ( isdefined( enemy ) && !array_contains( enemylist, enemy ) )
        {
            enemylist[ enemylist.size ] = enemy;
        }
        
        foreach ( enemy in enemylist )
        {
            canseeenemy = agent cansee( enemy );
            
            if ( istrue( canseeenemy ) && !var_149518f76f493448 )
            {
                var_149518f76f493448 = 1;
                var_15864b7b1533b47d = 0;
                break;
            }
        }
        
        if ( istrue( var_149518f76f493448 ) )
        {
            if ( var_15864b7b1533b47d >= var_7d91e6095747f0b2 )
            {
                var_509b688b66616418 = 0;
                continue;
            }
            else if ( enemylist.size == 0 )
            {
                var_149518f76f493448 = 0;
            }
            else
            {
                var_15864b7b1533b47d += interval;
            }
        }
        
        wait interval;
    }
    
    agent notify( "endCQB" );
    agent function_304da84d9a815c01( origin, 1024 );
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 0
// Checksum 0x0, Offset: 0x540e
// Size: 0x2b9
function function_9bcf6b76ea52ee4c()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    cqbspawns = getstructarray( "ambush_spawn", "script_noteworthy" );
    spawnnode = random( cqbspawns );
    var_e67f0b2ea7ae69ed = [];
    var_8a055a821dda7da0 = [];
    nodesaround = getnodesinradius( spawnnode.origin, 512, 0, 512 );
    
    foreach ( node in nodesaround )
    {
        if ( isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "cqb_node" ) )
        {
            if ( issubstr( node.script_noteworthy, "dont_move" ) )
            {
                node.var_8d756f0d1b8f56f7 = 1;
                var_8a055a821dda7da0[ var_8a055a821dda7da0.size ] = node;
                continue;
            }
            
            var_e67f0b2ea7ae69ed[ var_e67f0b2ea7ae69ed.size ] = node;
        }
    }
    
    wait 10;
    covernode = var_e67f0b2ea7ae69ed[ 0 ];
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693( "ar" );
    level.var_7ce9081bcf4af5a6 = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent( aitype, covernode.origin, spawnnode.angles, "high", "reinforcements", "debug" );
    
    if ( isdefined( level.var_7ce9081bcf4af5a6 ) )
    {
        level thread function_249321aebdee5ddc( level.var_7ce9081bcf4af5a6, var_e67f0b2ea7ae69ed );
        level thread function_64045ea3246c7b09( level.var_7ce9081bcf4af5a6, covernode.origin );
    }
    
    covernode = var_e67f0b2ea7ae69ed[ 1 ];
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693( "ar" );
    level.var_7ce9081bcf4af5a6 = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent( aitype, covernode.origin, spawnnode.angles, "high", "reinforcements", "debug" );
    
    if ( isdefined( level.var_7ce9081bcf4af5a6 ) )
    {
        level thread function_249321aebdee5ddc( level.var_7ce9081bcf4af5a6, var_e67f0b2ea7ae69ed );
        level thread function_64045ea3246c7b09( level.var_7ce9081bcf4af5a6, covernode.origin );
    }
    
    covernode = var_8a055a821dda7da0[ 0 ];
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693( "shotgun" );
    level.var_7ce9081bcf4af5a6 = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent( aitype, covernode.origin, spawnnode.angles, "high", "reinforcements", "debug" );
    
    if ( isdefined( level.var_7ce9081bcf4af5a6 ) )
    {
        function_2b26d000f2ccfc11( level.var_7ce9081bcf4af5a6, covernode );
        level thread function_64045ea3246c7b09( level.var_7ce9081bcf4af5a6, covernode.origin );
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x56cf
// Size: 0x8f
function function_249321aebdee5ddc( agent, nodes )
{
    agent endon( "death" );
    agent endon( "endCQB" );
    switchtime = 5;
    currenttime = 0;
    interval = 1;
    node = undefined;
    
    while ( true )
    {
        if ( currenttime >= switchtime )
        {
            currenttime = 0;
            cqb_releaseNode( node );
            node = function_984e27d6c139a63d( nodes );
            function_2b26d000f2ccfc11( agent, node );
            thread function_a1d0e5ea1a887436( agent, node, switchtime );
        }
        
        wait 1;
        currenttime += interval;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 3
// Checksum 0x0, Offset: 0x5766
// Size: 0xc3
function function_a1d0e5ea1a887436( agent, node, time )
{
    if ( true )
    {
        return;
    }
    
    if ( !isdefined( node ) || istrue( node.claimed ) )
    {
        return;
    }
    
    agent endon( "death" );
    interval = 0.05;
    currenttime = 0;
    
    while ( !isdefined( time ) || currenttime < time )
    {
        agent thread scripts\mp\utility\debug::drawsphere( node.origin, 32, interval, ( 1, 0, 1 ) );
        agent thread scripts\cp_mp\utility\debug_utility::drawline( node.origin, agent.origin, interval, ( 0, 1, 0 ) );
        wait interval;
        currenttime += interval;
    }
}

// Namespace ai_behavior / scripts\mp\ai_behavior
// Params 2
// Checksum 0x0, Offset: 0x5831
// Size: 0xcc
function function_b8687f27cfc0719c( agent, nodes )
{
    agent endon( "death" );
    interval = 0.05;
    
    while ( true )
    {
        foreach ( node in nodes )
        {
            agent thread scripts\mp\utility\debug::drawsphere( agent.origin, 16, 0.05, ( 0, 0, 1 ) );
            agent thread scripts\cp_mp\utility\debug_utility::drawline( node.origin, agent.origin, interval, ( 0, 1, 0 ) );
        }
        
        wait interval;
    }
}

/#

    // Namespace ai_behavior / scripts\mp\ai_behavior
    // Params 0
    // Checksum 0x0, Offset: 0x5905
    // Size: 0x2ed, Type: dev
    function function_1efa739f9e55871f()
    {
        level endon( "<dev string:x245>" );
        agents = [];
        interval = 0.05;
        
        while ( true )
        {
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 1 )
            {
                foreach ( agent in agents )
                {
                    agent kill();
                }
                
                waitframe();
                poiname = scripts\mp\poi::poi_findPOIOriginIsIn( level.players[ 0 ].origin );
                team = level.players[ 0 ].team;
                
                if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
                {
                    team = "<dev string:x253>";
                }
                
                agents = scripts\mp\ai_mp_controller::function_6214774e8e021663( 1, level.players[ 0 ].origin, "<dev string:x26f>", "<dev string:x27b>", "<dev string:x28d>", undefined, team, poiname, 256, 257 );
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 2 )
            {
                foreach ( agent in agents )
                {
                    agent thread scripts\mp\ai_behavior::function_a5117518725da028( agent, level.players[ 0 ].origin );
                }
                
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 3 )
            {
                agents = scripts\mp\ai_mp_controller::function_353fecd1549f5f42( level.players[ 0 ].origin, 50000, level.players[ 0 ].team, 100, "<dev string:x29f>", undefined, undefined, 1 );
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 4 )
            {
                foreach ( agent in agents )
                {
                    agent thread scripts\mp\ai_behavior::function_65f6a39e1083fb6b( agent, level.var_32988d8b3d823f40 );
                }
                
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            foreach ( agent in agents )
            {
                agent thread scripts\mp\utility\debug::drawsphere( agent.origin, 32, interval, ( 1, 0, 1 ) );
            }
            
            wait interval;
        }
    }

#/
