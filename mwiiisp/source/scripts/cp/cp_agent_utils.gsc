#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\damagefeedback;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace cp_agent_utils;

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 1
// Checksum 0x0, Offset: 0xdc
// Size: 0x46
function getfreeagent( agent_type )
{
    freeagent = undefined;
    
    if ( isdefined( level.agentarray ) )
    {
        freeagent = getfreeagentfrompool();
        
        if ( isdefined( freeagent ) )
        {
            freeagent.agent_type = agent_type;
            freeagent initagentscriptvariables();
        }
    }
    
    return freeagent;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 0
// Checksum 0x0, Offset: 0x12b
// Size: 0x5b
function initagentscriptvariables()
{
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.spawntime = 0;
    self.entity_number = self getentitynumber();
    self.agent_gameparticipant = 0;
    self.agentname = undefined;
    self detachall();
    initplayerscriptvariables();
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 0
// Checksum 0x0, Offset: 0x18e
// Size: 0x172
function initplayerscriptvariables()
{
    self.class = undefined;
    self.movespeedscaler = undefined;
    self.avoidkillstreakonspawntimer = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.saved_actionslotdata = undefined;
    self.perks = undefined;
    self.weaponlist = undefined;
    self.objectivescaler = undefined;
    self.sessionteam = undefined;
    self.sessionstate = undefined;
    val::nuke( "weapon" );
    val::nuke( "weapon_switch" );
    val::nuke( "offhand_weapons" );
    val::nuke( "usability" );
    self.nocorpse = undefined;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.ten_percent_of_max_health = undefined;
    self.command_given = undefined;
    self.current_icon = undefined;
    self.do_immediate_ragdoll = undefined;
    self.can_be_killed = 0;
    self.attack_spot = undefined;
    self.entered_playspace = 0;
    self.marked_for_death = undefined;
    self.trap_killed_by = undefined;
    self.hastraversed = 0;
    self.died_poorly = 0;
    self.isfrozen = undefined;
    self.flung = undefined;
    self.battleslid = undefined;
    self.should_play_transformation_anim = undefined;
    self.is_suicide_bomber = undefined;
    self.is_reserved = undefined;
    self.is_coaster_zombie = undefined;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 2
// Checksum 0x0, Offset: 0x308
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

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 1
// Checksum 0x0, Offset: 0x362
// Size: 0x113
function agentfunc( func_name )
{
    /#
        if ( !isagent( self ) )
        {
            println( "<dev string:x1c>" );
            return;
        }
        
        if ( !isdefined( func_name ) )
        {
            println( "<dev string:x42>" );
            return;
        }
        
        if ( !isdefined( self.agent_type ) )
        {
            println( "<dev string:x6f>" );
            return;
        }
        
        if ( !isdefined( level.agent_funcs[ self.agent_type ] ) )
        {
            println( "<dev string:xa2>" );
            return;
        }
        
        if ( !isdefined( level.agent_funcs[ self.agent_type ][ func_name ] ) )
        {
            println( "<dev string:xde>" + self.agent_type + "<dev string:x10d>" );
            return;
        }
    #/
    
    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ] ) && isdefined( level.agent_funcs[ self.unittype ][ func_name ] ) )
    {
        return level.agent_funcs[ self.unittype ][ func_name ];
    }
    
    return level.agent_funcs[ self.agent_type ][ func_name ];
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 1
// Checksum 0x0, Offset: 0x47d
// Size: 0x52
function validateattacker( eattacker )
{
    if ( isagent( eattacker ) && ( !isdefined( eattacker.isactive ) || !eattacker.isactive ) )
    {
        return undefined;
    }
    
    if ( isagent( eattacker ) && !isdefined( eattacker.classname ) )
    {
        return undefined;
    }
    
    return eattacker;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 1
// Checksum 0x0, Offset: 0x4d8
// Size: 0x91
function getaliveagentsofteam( team )
{
    var_c5c35cc6c0816de1 = [];
    
    foreach ( agent in level.agentarray )
    {
        if ( isalive( agent ) && isdefined( agent.team ) && agent.team == team )
        {
            var_c5c35cc6c0816de1[ var_c5c35cc6c0816de1.size ] = agent;
        }
    }
    
    return var_c5c35cc6c0816de1;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 1
// Checksum 0x0, Offset: 0x572
// Size: 0xc1
function getactiveenemyagents( var_118c0e3106155c71 )
{
    assert( isdefined( var_118c0e3106155c71 ) );
    agents = [];
    
    if ( !isdefined( level.agentarray ) )
    {
        return agents;
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( !isdefined( agent.team ) )
        {
            continue;
        }
        
        if ( isdefined( agent.isactive ) && agent.isactive )
        {
            if ( agent.team != var_118c0e3106155c71 )
            {
                agents[ agents.size ] = agent;
            }
        }
    }
    
    return agents;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 0
// Checksum 0x0, Offset: 0x63c
// Size: 0x49
function get_alive_enemies()
{
    alive_enemies = getaliveagentsofteam( "axis" );
    var_2b2cfe014a9942d1 = [];
    
    if ( isdefined( level.dlc_get_non_agent_enemies ) )
    {
        var_2b2cfe014a9942d1 = [[ level.dlc_get_non_agent_enemies ]]();
    }
    
    alive_enemies = array_combine( alive_enemies, var_2b2cfe014a9942d1 );
    return alive_enemies;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 1
// Checksum 0x0, Offset: 0x68e
// Size: 0x33
function get_agent_type( agent )
{
    assertex( isdefined( agent.agent_type ), "<dev string:x128>" );
    return agent.agent_type;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 2
// Checksum 0x0, Offset: 0x6ca
// Size: 0xec
function store_attacker_info( attacker, damage )
{
    attacker = get_attacker_as_player( attacker );
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( self.attacker_damage ) )
    {
        self.attacker_damage = [];
    }
    
    foreach ( attacker_struct in self.attacker_damage )
    {
        if ( attacker_struct.player == attacker )
        {
            attacker_struct.damage += damage;
            return;
        }
    }
    
    var_90a492b93432b5bb = spawnstruct();
    var_90a492b93432b5bb.player = attacker;
    var_90a492b93432b5bb.damage = damage;
    self.attacker_damage[ self.attacker_damage.size ] = var_90a492b93432b5bb;
}

// Namespace cp_agent_utils / scripts\cp\cp_agent_utils
// Params 0
// Checksum 0x0, Offset: 0x7be
// Size: 0x18c
function deactivateagent()
{
    if ( scripts\cp_mp\utility\game_utility::isgameparticipant( self ) )
    {
        scripts\cp_mp\utility\game_utility::removefromparticipantsarray();
    }
    
    scripts\cp_mp\utility\game_utility::removefromcharactersarray();
    removefromspawnedgrouparray();
    self.isactive = 0;
    self.hasdied = 0;
    self.marked_by_hybrid = undefined;
    self.mortartarget = undefined;
    self.owner = undefined;
    self.connecttime = undefined;
    self.is_burning = undefined;
    self.is_electrified = undefined;
    self.stun_hit = undefined;
    self.targetname = undefined;
    self.script_noteworthy = undefined;
    self.script_linkname = undefined;
    self.script_linkto = undefined;
    self.target = undefined;
    self.mutations = undefined;
    
    foreach ( character in level.characters )
    {
        if ( isdefined( character.attackers ) )
        {
            foreach ( attacker in character.attackers )
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
        self.headmodel = undefined;
    }
    
    self notify( "disconnect" );
}

