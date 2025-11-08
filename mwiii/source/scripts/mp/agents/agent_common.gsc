#using scripts\anim\notetracks_mp;
#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace agent_common;

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 0
// Checksum 0x0, Offset: 0x129
// Size: 0x76
function codecallback_agentadded()
{
    self [[ level.initagentscriptvariables ]]();
    agentteam = "axis";
    
    if ( level.numagents % 2 == 0 )
    {
        agentteam = "allies";
    }
    
    level.numagents++;
    self sethitlocdamagetable( %"hash_635afa6edffbf00b" );
    self [[ level.setagentteam ]]( agentteam );
    level.agentarray[ level.agentarray.size ] = self;
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 12
// Checksum 0x0, Offset: 0x1a7
// Size: 0xd8
function codecallback_agentdamaged( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname )
{
    sweapon = objweapon;
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, einflictor );
    }
    
    eattacker = [[ level.agentvalidateattacker ]]( eattacker );
    agent_func = self [[ level.agentfunc ]]( "on_damaged" );
    
    if ( isdefined( agent_func ) )
    {
        self [[ agent_func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    }
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 10
// Checksum 0x0, Offset: 0x287
// Size: 0x7c
function codecallback_agentimpaled( eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b )
{
    if ( isdefined( level.callbackplayerimpaled ) )
    {
        [[ level.callbackplayerimpaled ]]( eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b, 1 );
    }
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 5
// Checksum 0x0, Offset: 0x30b
// Size: 0x4b
function function_237dd076563be41f( eattacker, objweapon, vdir, magnitude, shitloc )
{
    if ( isdefined( level.var_189d24c2bbeed3f5 ) )
    {
        [[ level.var_189d24c2bbeed3f5 ]]( eattacker, objweapon, vdir, magnitude, shitloc, 1 );
    }
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 10
// Checksum 0x0, Offset: 0x35e
// Size: 0xb4
function codecallback_agentkilled( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration )
{
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, einflictor );
    }
    
    eattacker = [[ level.agentvalidateattacker ]]( eattacker );
    agent_func = self [[ level.agentfunc ]]( "on_killed" );
    
    if ( isdefined( agent_func ) )
    {
        self thread [[ agent_func ]]( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration );
    }
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 2
// Checksum 0x0, Offset: 0x41a
// Size: 0x13
function codecallback_agentfinishweaponchange( objoldweapon, objnewweapon )
{
    
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 0
// Checksum 0x0, Offset: 0x435
// Size: 0x22
function init()
{
    initagentlevelvariables();
    scripts\anim\notetracks_mp::registernotetracks();
    level thread scripts\asm\asm::setup_level_ents();
    level thread add_agents_to_game();
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 3
// Checksum 0x0, Offset: 0x45f
// Size: 0xe0
function connectnewagent( agent_type, team, class )
{
    agent = [[ level.getfreeagent ]]( agent_type );
    
    if ( isdefined( agent ) )
    {
        agent.connecttime = gettime();
        
        if ( isdefined( team ) )
        {
            agent [[ level.setagentteam ]]( team );
        }
        else
        {
            agent [[ level.setagentteam ]]( agent.team );
        }
        
        if ( isdefined( class ) )
        {
            agent.class_override = class;
        }
        
        if ( isdefined( level.agent_funcs[ agent_type ][ "onAIConnect" ] ) )
        {
            agent [[ agent [[ level.agentfunc ]]( "onAIConnect" ) ]]();
        }
        
        agent [[ level.addtocharactersarray ]]();
        assertex( agent.connecttime == gettime(), "<dev string:x1c>" );
    }
    
    return agent;
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 0
// Checksum 0x0, Offset: 0x548
// Size: 0x2d
function initagentlevelvariables()
{
    level.agentarray = [];
    level.numagents = 0;
    
    if ( !isdefined( level.var_e58efb25be1ee016 ) )
    {
        level.var_e58efb25be1ee016 = 0;
    }
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 0
// Checksum 0x0, Offset: 0x57d
// Size: 0xbb
function add_agents_to_game()
{
    level endon( "game_ended" );
    level waittill( "connected", player );
    maxagents = getmaxagents();
    println( "<dev string:x67>" + maxagents + "<dev string:x88>" );
    var_48a1bbbf94f76091 = getdvarint( @"hash_3c453eaf21ea4a86", -1 );
    
    while ( level.agentarray.size < maxagents )
    {
        if ( var_48a1bbbf94f76091 != -1 && level.agentarray.size != 0 && level.agentarray.size % var_48a1bbbf94f76091 == 0 )
        {
            waitframe();
        }
        
        agent = addagent();
        
        if ( !isdefined( agent ) )
        {
            waitframe();
            continue;
        }
    }
    
    level.var_61198536443ad7ec = 1;
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 1
// Checksum 0x0, Offset: 0x640
// Size: 0x1f
function set_agent_health( health )
{
    self.health = health;
    self.maxhealth = health;
}

// Namespace agent_common / scripts\mp\agents\agent_common
// Params 0
// Checksum 0x0, Offset: 0x667
// Size: 0x12
function ondeactivate()
{
    self notify( "killanimscript" );
    self notify( "terminate_ai_threads" );
}

