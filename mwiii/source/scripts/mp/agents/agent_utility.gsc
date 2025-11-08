#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;

#namespace agent_utility;

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0x1c3
// Size: 0xde
function agentfunc( func_name )
{
    assert( isagent( self ) );
    assert( isdefined( func_name ) );
    assert( isdefined( self.agent_type ) );
    assert( isdefined( level.agent_funcs[ self.agent_type ] ) );
    assert( isdefined( level.agent_funcs[ self.agent_type ][ func_name ] ) );
    
    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ] ) && isdefined( level.agent_funcs[ self.unittype ][ func_name ] ) )
    {
        return level.agent_funcs[ self.unittype ][ func_name ];
    }
    
    return level.agent_funcs[ self.agent_type ][ func_name ];
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 2
// Checksum 0x0, Offset: 0x2aa
// Size: 0x52
function set_agent_team( team, optional_owner )
{
    self.team = team;
    self.agentteam = team;
    self.pers[ "team" ] = team;
    self.owner = optional_owner;
    self setotherent( optional_owner );
    self setentityowner( optional_owner );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 0
// Checksum 0x0, Offset: 0x304
// Size: 0x9c
function initagentscriptvariables()
{
    self.agent_type = "player";
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.isagent = 1;
    self.wasti = 0;
    self.entity_number = self getentitynumber();
    self.agent_teamparticipant = 0;
    self.agent_gameparticipant = 0;
    self.agentname = undefined;
    self.ignoreall = istrue( level.var_bdb4d0cd41b1c39d );
    self.ignoreme = 0;
    self detachall();
    initplayerscriptvariables( 0 );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0x3a8
// Size: 0x17e
function initplayerscriptvariables( asplayer )
{
    if ( !asplayer )
    {
        self.class = undefined;
        self.lastclass = undefined;
        self.movespeedscaler = undefined;
        self.avoidkillstreakonspawntimer = undefined;
        self.guid = undefined;
        self.name = undefined;
        self.perks = undefined;
        self.weaponlist = undefined;
        self.objectivescaler = undefined;
        self.touchtriggers = undefined;
        self.carryobject = undefined;
        self.canpickupobject = undefined;
        self.sessionteam = undefined;
        self.sessionstate = undefined;
        self.lastspawntime = undefined;
        self.lastspawnpoint = undefined;
        val::nuke( "weapon" );
        val::nuke( "weapon_switch" );
        val::nuke( "offhand_weapons" );
        val::nuke( "usability" );
        self.shieldbullethits = undefined;
        self.recentshieldxp = undefined;
        return;
    }
    
    self.movespeedscaler = 1;
    self.avoidkillstreakonspawntimer = 5;
    self.guid = getuniqueid();
    self.name = self.guid;
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.agent_gameparticipant = 1;
    self.objectivescaler = 1;
    scripts\mp\gameobjects::init_player_gameobjects();
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0x52e
// Size: 0x4c
function getfreeagent( agent_type )
{
    freeagent = undefined;
    
    if ( isdefined( level.agentarray ) )
    {
        freeagent = getfreeagentfrompool();
        
        if ( isdefined( freeagent ) )
        {
            freeagent initagentscriptvariables();
            
            if ( isdefined( agent_type ) )
            {
                freeagent.agent_type = agent_type;
            }
        }
    }
    
    return freeagent;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 0
// Checksum 0x0, Offset: 0x583
// Size: 0x39
function activateagent()
{
    /#
        if ( !self.isactive )
        {
            assertex( self.connecttime == gettime(), "<dev string:x1c>" );
        }
    #/
    
    self.isactive = 1;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 0
// Checksum 0x0, Offset: 0x5c4
// Size: 0xa
function deactivateagent()
{
    thread deactivateagentdelayed();
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 0
// Checksum 0x0, Offset: 0x5d6
// Size: 0x140
function deactivateagentdelayed()
{
    self notify( "deactivateAgentDelayed" );
    self endon( "deactivateAgentDelayed" );
    
    if ( scripts\cp_mp\utility\game_utility::isgameparticipant( self ) )
    {
        scripts\cp_mp\utility\game_utility::removefromparticipantsarray();
    }
    
    scripts\cp_mp\utility\game_utility::removefromcharactersarray();
    wait 0.05;
    self.isactive = 0;
    self.hasdied = 0;
    self.owner = undefined;
    self.connecttime = undefined;
    
    foreach ( character in level.characters )
    {
        if ( isdefined( character.attackers ) )
        {
            foreach ( index, attacker in character.attackers )
            {
                if ( attacker == self )
                {
                    character.attackers[ index ] = undefined;
                }
            }
        }
    }
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
        self.headmodel = undefined;
    }
    
    self notify( "disconnect" );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0x71e
// Size: 0x2c
function getnumactiveagents( type )
{
    if ( !isdefined( type ) )
    {
        type = "all";
    }
    
    agents = getactiveagentsoftype( type );
    return agents.size;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0x753
// Size: 0xbc
function getactiveagentsoftype( type )
{
    assert( isdefined( type ) );
    agents = [];
    
    if ( !isdefined( level.agentarray ) )
    {
        return agents;
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( isdefined( agent.isactive ) && agent.isactive )
        {
            if ( type == "all" || agent.agent_type == type )
            {
                agents[ agents.size ] = agent;
            }
        }
    }
    
    return agents;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0x818
// Size: 0x17
function getnumownedactiveagents( player )
{
    return getnumownedactiveagentsbytype( player, "all" );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 2
// Checksum 0x0, Offset: 0x838
// Size: 0xf6
function getnumownedactiveagentsbytype( player, type )
{
    assert( isdefined( type ) );
    numownedactiveagents = 0;
    
    if ( !isdefined( level.agentarray ) )
    {
        return numownedactiveagents;
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( isdefined( agent.isactive ) && agent.isactive )
        {
            if ( isdefined( agent.owner ) && agent.owner == player )
            {
                if ( type == "all" && agent.agent_type != "alien" || agent.agent_type == type )
                {
                    numownedactiveagents++;
                }
            }
        }
    }
    
    return numownedactiveagents;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 2
// Checksum 0x0, Offset: 0x937
// Size: 0xfc
function getnumownedagentsonteambytype( team, type )
{
    assert( isdefined( team ) && isdefined( type ) );
    numownedactiveagents = 0;
    
    if ( !isdefined( level.agentarray ) )
    {
        return numownedactiveagents;
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( isdefined( agent.isactive ) && agent.isactive )
        {
            if ( isdefined( agent.team ) && agent.team == team )
            {
                if ( type == "all" && agent.agent_type != "alien" || agent.agent_type == type )
                {
                    numownedactiveagents++;
                }
            }
        }
    }
    
    return numownedactiveagents;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 2
// Checksum 0x0, Offset: 0xa3c
// Size: 0x34b
function getvalidspawnpathnodenearplayer( var_17bb852304a6478e, var_dd84cf0c92913cb9 )
{
    assert( isplayer( self ) );
    nodearray = getnodesinradius( self.origin, 350, 64, 128, "Path" );
    
    if ( !isdefined( nodearray ) || nodearray.size == 0 )
    {
        return undefined;
    }
    
    if ( isdefined( level.waterdeletez ) && isdefined( level.trigunderwater ) )
    {
        var_22a832c83ea6f75f = nodearray;
        nodearray = [];
        
        foreach ( node in var_22a832c83ea6f75f )
        {
            if ( node.origin[ 2 ] > level.waterdeletez || !ispointinvolume( node.origin, level.trigunderwater ) )
            {
                nodearray[ nodearray.size ] = node;
            }
        }
    }
    
    playerdirection = anglestoforward( self.angles );
    bestdot = -10;
    playerheight = scripts\mp\spawnlogic::getplayertraceheight( self );
    zoffset = ( 0, 0, playerheight );
    
    if ( !isdefined( var_17bb852304a6478e ) )
    {
        var_17bb852304a6478e = 0;
    }
    
    if ( !isdefined( var_dd84cf0c92913cb9 ) )
    {
        var_dd84cf0c92913cb9 = 0;
    }
    
    var_154744dc373ef9 = [];
    var_4236cf84c1c222b3 = [];
    
    foreach ( pathnode in nodearray )
    {
        if ( !pathnode doesnodeallowstance( "stand" ) || isdefined( pathnode.no_agent_spawn ) )
        {
            continue;
        }
        
        var_644ab9fda129b92b = vectornormalize( pathnode.origin - self.origin );
        dot = vectordot( playerdirection, var_644ab9fda129b92b );
        
        for ( i = 0; i < var_4236cf84c1c222b3.size ; i++ )
        {
            if ( dot > var_4236cf84c1c222b3[ i ] )
            {
                for ( j = var_4236cf84c1c222b3.size; j > i ; j-- )
                {
                    var_4236cf84c1c222b3[ j ] = var_4236cf84c1c222b3[ j - 1 ];
                    var_154744dc373ef9[ j ] = var_154744dc373ef9[ j - 1 ];
                }
                
                break;
            }
        }
        
        var_154744dc373ef9[ i ] = pathnode;
        var_4236cf84c1c222b3[ i ] = dot;
    }
    
    for ( i = 0; i < var_154744dc373ef9.size ; i++ )
    {
        pathnode = var_154744dc373ef9[ i ];
        tracestart = self.origin + zoffset;
        traceend = pathnode.origin + zoffset;
        
        if ( i > 0 )
        {
            wait 0.05;
        }
        
        if ( !sighttracepassed( tracestart, traceend, 0, self ) )
        {
            continue;
        }
        
        if ( var_dd84cf0c92913cb9 )
        {
            if ( i > 0 )
            {
                wait 0.05;
            }
            
            hitpos = playerphysicstrace( pathnode.origin + zoffset, pathnode.origin );
            
            if ( distancesquared( hitpos, pathnode.origin ) > 1 )
            {
                continue;
            }
        }
        
        if ( var_17bb852304a6478e )
        {
            if ( i > 0 )
            {
                wait 0.05;
            }
            
            hitpos = physicstrace( tracestart, traceend );
            
            if ( distancesquared( hitpos, traceend ) > 1 )
            {
                continue;
            }
        }
        
        return pathnode;
    }
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 0
// Checksum 0x0, Offset: 0xd8f
// Size: 0x8e
function function_b071e509c0fb69b0()
{
    if ( self getstance() == "crouch" )
    {
        center = self.origin + 0.5 * ( 0, 0, 50 );
    }
    else if ( self getstance() == "prone" )
    {
        center = self.origin + 0.5 * ( 0, 0, 48 );
    }
    else
    {
        center = self.origin + 0.5 * ( 0, 0, 72 );
    }
    
    return center;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 0
// Checksum 0x0, Offset: 0xe26
// Size: 0x7c
function function_2e1b23386b967c10()
{
    if ( self getstance() == "crouch" )
    {
        center = self.origin + ( 0, 0, 50 );
    }
    else if ( self getstance() == "prone" )
    {
        center = self.origin + ( 0, 0, 48 );
    }
    else
    {
        center = self.origin + ( 0, 0, 72 );
    }
    
    return center;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0xeab
// Size: 0x2e
function killagent( agent )
{
    agent dodamage( agent.health + 500000, agent.origin );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 0
// Checksum 0x0, Offset: 0xee1
// Size: 0x4a
function killdog()
{
    self [[ agentfunc( "on_damaged" ) ]]( level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", ( 0, 0, 0 ), ( 0, 0, 0 ), "none", 0 );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0xf33
// Size: 0x24, Type: bool
function isspecifiedunittype( unittype )
{
    return isdefined( self.unittype ) && self.unittype == unittype;
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0xf60
// Size: 0x2f, Type: bool
function iscivilian( agent )
{
    var_d2664652fb0cb884 = agent.category;
    return isdefined( var_d2664652fb0cb884 ) && var_d2664652fb0cb884 == "civilian";
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0xf98
// Size: 0x38
function function_86df29145c484d9c( agent )
{
    if ( !isdefined( agent ) || !isdefined( agent.agent_type ) )
    {
        return 0;
    }
    
    return issubstr( agent.agent_type, "_merc" );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0xfd9
// Size: 0x38
function function_17b2ecdae3a795f6( agent )
{
    if ( !isdefined( agent ) || !isdefined( agent.agent_type ) )
    {
        return 0;
    }
    
    return issubstr( agent.agent_type, "_ru" );
}

// Namespace agent_utility / scripts\mp\agents\agent_utility
// Params 1
// Checksum 0x0, Offset: 0x101a
// Size: 0x38
function istier3( agent )
{
    if ( !isdefined( agent ) || !isdefined( agent.agent_type ) )
    {
        return 0;
    }
    
    return issubstr( agent.agent_type, "tier3" );
}

