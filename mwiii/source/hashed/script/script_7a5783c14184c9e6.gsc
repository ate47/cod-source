#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\utility\teams;

#namespace namespace_562c09f7cd8fb4f5;

// Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
// Params 5
// Checksum 0x0, Offset: 0x287
// Size: 0x17f
function function_78422799f477b8e6( spawndata, team, weaponname, modelname, aitype )
{
    level endon( "game_ended" );
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = "jup_cougar_mg_gunner_turret_mp";
    }
    
    if ( !isdefined( modelname ) )
    {
        modelname = "weapon_wm_mg_mobile_turret";
    }
    
    turret = spawnturret( "misc_turret", spawndata.origin, weaponname, 0 );
    turret.var_3763391e00ccdd58 = 1;
    turret setmodel( modelname );
    
    if ( isdefined( spawndata.angles ) )
    {
        turret.angles = spawndata.angles;
    }
    
    turret setmode( "sentry_offline" );
    turret makeunusable();
    turret setdefaultdroppitch( 0 );
    turret.usemode = "manual_target";
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel setmodel( "weapon_vm_mg_sentry_turret_invis_base" );
    turret.colmodel dontinterpolate();
    
    if ( !isdefined( level.var_f7914aa9690e3289 ) )
    {
        level.var_f7914aa9690e3289 = [];
    }
    
    level.var_f7914aa9690e3289[ level.var_f7914aa9690e3289.size ] = turret;
    turret startfiring();
    turret setmode( "manual" );
    return turret;
}

// Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
// Params 5
// Checksum 0x0, Offset: 0x40f
// Size: 0x29a
function function_3cd75d5bf0fc9989( spawndata, team, aitype, weaponname, modelname )
{
    level endon( "game_ended" );
    scripts\mp\ai_mp_controller::function_2fc80954fa70d153();
    
    if ( !isdefined( aitype ) )
    {
        aitype = "jup_enemy_mp_lmg_tier1_pmc";
    }
    
    var_9ba5cef5b2b49421 = getstruct( spawndata.target, "targetname" );
    agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent( aitype, var_9ba5cef5b2b49421.origin, var_9ba5cef5b2b49421.angles, "absolute", "show", "rpg", undefined, team, undefined, undefined, 1, undefined, 0, undefined );
    
    if ( isdefined( agent ) )
    {
        agent scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata( agent, "team", team );
        agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff( undefined, undefined, undefined, undefined, undefined, 0, 0 );
        agent.var_b582b10663b5b2a9 = 0;
        agent.ignoreall = 1;
        agent clearbtgoal( 4 );
        agent SetBTGoalStationary( 4 );
        agent.var_6384ebeaed4efe3e = 1;
    }
    
    if ( isdefined( spawndata.script_label ) )
    {
        var_99fe65bbdb024783 = getent( "mg_agent_mount_trigger" + spawndata.script_label, "targetname" );
        
        if ( !isdefined( var_99fe65bbdb024783 ) )
        {
            assertmsg( "<dev string:x1c>" );
        }
        else
        {
            while ( true )
            {
                var_99fe65bbdb024783 waittill( "trigger", player );
                
                if ( !is_equal( player.pers[ "team" ], game[ "attackers" ] ) )
                {
                    continue;
                }
                
                break;
            }
        }
    }
    
    if ( !isalive( agent ) )
    {
        return;
    }
    
    agent clearbtgoal( 4 );
    agent setbtgoalpos( 4, getclosestpointonnavmesh( spawndata.origin ) );
    aimpos = spawn( "script_model", self.origin + anglestoforward( self.origin ) * 100 );
    self.aimpos = aimpos;
    self settargetentity( aimpos );
    
    /#
        level thread function_6b6a08026758fca9( aimpos );
    #/
    
    if ( istrue( level.var_2f006c7490fb7639 ) )
    {
        scripts\common\ai::ai_operate_turret( agent, self );
        self.owner = agent;
        thread function_86880084e476db84();
        return;
    }
    
    wait 3;
    
    if ( isalive( agent ) )
    {
        scripts\common\ai::ai_operate_turret( agent, self );
        self.owner = agent;
        self.colmodel.owner = self.owner;
        agent.var_859f7cb544b5801d = self;
        self.owner thread function_bd80506147960d00();
        thread function_69c4dd9b2bc55b1b();
    }
}

// Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
// Params 0
// Checksum 0x0, Offset: 0x6b1
// Size: 0x1c4
function function_69c4dd9b2bc55b1b()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "agent_mg_destroyed" );
    turret = self;
    burst = 9;
    
    while ( true )
    {
        if ( !istrue( function_a233031a44bbbb0d( turret, turret.owner ) ) )
        {
            return;
        }
        
        blackboard = turret.owner._blackboard;
        
        if ( !isdefined( blackboard ) || !isdefined( blackboard.aigroundturretstate ) || blackboard.aigroundturretstate != "turret_mounted" )
        {
            waitframe();
            continue;
        }
        
        break;
    }
    
    wait 1.5;
    
    while ( true )
    {
        if ( !istrue( function_a233031a44bbbb0d( turret, turret.owner ) ) )
        {
            return;
        }
        
        attackers = scripts\mp\utility\teams::getteamdata( game[ "attackers" ], "alivePlayers" );
        var_95f2a51e7b487eb2 = sortbydistancecullbyradius( attackers, self.origin, 2400 );
        var_1e1dd312897f5c42 = [];
        
        foreach ( attacker in var_95f2a51e7b487eb2 )
        {
            var_de72f19d4de18b4f = distance2dsquared( attacker.origin, self.origin );
            
            if ( var_de72f19d4de18b4f >= 100000 )
            {
                var_1e1dd312897f5c42[ var_1e1dd312897f5c42.size ] = attacker;
            }
        }
        
        target = array_random( var_1e1dd312897f5c42 );
        
        if ( isdefined( target ) )
        {
            function_597e32613762e969( target, self.aimpos, burst );
            wait randomfloatrange( 3, 3.5 );
            continue;
        }
        
        wait 0.2;
    }
}

// Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
// Params 0
// Checksum 0x0, Offset: 0x87d
// Size: 0x57
function function_86880084e476db84()
{
    level endon( "game_ended" );
    turret = self;
    burst = 6;
    
    while ( true )
    {
        if ( isdefined( self.var_57abfc2b0a18dd65 ) )
        {
            function_597e32613762e969( self.var_57abfc2b0a18dd65, self.aimpos, burst );
        }
        
        wait 0.5;
    }
}

// Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
// Params 3
// Checksum 0x0, Offset: 0x8dc
// Size: 0x2a2
function function_597e32613762e969( target, aimpos, burst )
{
    self endon( "agent_mg_destroyed" );
    turret = self;
    var_bd2a07ce8b285aa4 = target.origin + vectornormalize2( turret.origin - target.origin ) * 600;
    
    if ( distance2dsquared( var_bd2a07ce8b285aa4, self.origin ) > 100000 )
    {
        aimpos moveto( var_bd2a07ce8b285aa4, 0.2 );
        var_777a0430627e00a8 = vectornormalize2( target.origin - turret.origin ) * 1000;
    }
    else
    {
        aimpos moveto( target.origin + vectornormalize2( target.origin - turret.origin ) * 100, 0.2 );
        var_777a0430627e00a8 = undefined;
    }
    
    wait 0.2;
    
    for ( i = 0; i < burst ; i++ )
    {
        if ( !istrue( function_a233031a44bbbb0d( turret, turret.owner ) ) )
        {
            return;
        }
        
        if ( turret.owner isflashed() )
        {
            turret.owner._blackboard.aigroundturretstate = "none";
            turret.owner.ignoreall = 1;
            turret.owner.ignoreme = 1;
            turret.owner.var_ab002334e3a455a5 = 1;
            wait 2;
            break;
        }
        
        if ( istrue( turret.owner.var_ab002334e3a455a5 ) )
        {
            scripts\common\ai::ai_operate_turret( turret.owner, turret );
            turret.owner.var_ab002334e3a455a5 = undefined;
            
            while ( true )
            {
                if ( !istrue( function_a233031a44bbbb0d( turret, turret.owner ) ) )
                {
                    return;
                }
                
                blackboard = turret.owner._blackboard;
                
                if ( !isdefined( blackboard ) || !isdefined( blackboard.aigroundturretstate ) || blackboard.aigroundturretstate != "turret_mounted" )
                {
                    waitframe();
                    continue;
                }
                
                break;
            }
            
            wait 1.5;
        }
        
        if ( isdefined( turret.owner ) )
        {
            turret shootturret();
        }
        
        if ( isdefined( var_777a0430627e00a8 ) )
        {
            aimpos moveto( aimpos.origin + var_777a0430627e00a8 / burst, 0.05 );
        }
        
        wait 0.13;
    }
}

/#

    // Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
    // Params 1
    // Checksum 0x0, Offset: 0xb86
    // Size: 0x2a, Type: dev
    function function_6b6a08026758fca9( aimpos )
    {
        while ( isdefined( aimpos ) )
        {
            sphere( aimpos.origin, 50 );
            waitframe();
        }
    }

#/

// Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
// Params 2
// Checksum 0x0, Offset: 0xbb8
// Size: 0x6c, Type: bool
function function_a233031a44bbbb0d( turret, owner )
{
    if ( !isdefined( owner ) || !isalive( owner ) )
    {
        turret setmode( "sentry_offline" );
        turret cleartargetentity();
        turret.owner = undefined;
        turret hudoutlinedisable();
        
        if ( isdefined( turret.aimpos ) )
        {
            turret.aimpos delete();
        }
        
        return false;
    }
    
    return true;
}

// Namespace namespace_562c09f7cd8fb4f5 / namespace_a84d4bd796b357d8
// Params 0
// Checksum 0x0, Offset: 0xc2d
// Size: 0x228
function function_bd80506147960d00()
{
    level endon( "game_ended" );
    self endon( "death" );
    var_68e6f05a4ee24dee = scripts\engine\trace::create_contents( 1, 1 );
    outlinetype = "outlinefill_enemy_hvt";
    
    while ( isalive( self ) == 1 )
    {
        foreach ( player in level.players )
        {
            forward = anglestoforward( player getplayerangles() );
            
            if ( within_fov( player geteye(), player getplayerangles(), self.origin, cos( 60 ) ) )
            {
                hits = physics_raycast( player geteye(), player geteye() + forward * 150000, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest" );
            }
            
            if ( isdefined( hits ) && hits.size > 0 )
            {
                foreach ( hit in hits )
                {
                    if ( isdefined( hit[ "entity" ] ) && hit[ "entity" ] == self )
                    {
                        if ( is_equal( player.pers[ "team" ], self.pers[ "team" ] ) )
                        {
                        }
                        else
                        {
                            self hudoutlineenableforclient( player, outlinetype );
                            
                            if ( isdefined( self.var_859f7cb544b5801d ) && isdefined( self._blackboard ) && isdefined( self._blackboard.aigroundturretstate ) && self._blackboard.aigroundturretstate == "turret_mounted" )
                            {
                                self.var_859f7cb544b5801d hudoutlineenableforclient( player, outlinetype );
                            }
                        }
                        
                        break;
                    }
                    
                    self hudoutlinedisableforclient( player );
                    
                    if ( isdefined( self.var_859f7cb544b5801d ) )
                    {
                        self.var_859f7cb544b5801d hudoutlinedisableforclient( player );
                    }
                }
            }
        }
        
        waitframe();
    }
}

