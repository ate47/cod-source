#using scripts\anim\face;
#using scripts\anim\shared;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\vehicles\vehicle_anim;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace agent_init;

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x196
// Size: 0x6f
function agent_init()
{
    if ( isdefined( anim.notfirsttime ) )
    {
        return;
    }
    
    anim.notfirsttime = 1;
    initanimvars();
    function_a2b8f8b0891ee7fe();
    initmeleecharges();
    initwindowtraverse();
    setuprandomtable();
    init_squadmanager();
    setupgrenades();
    initanimcallbacks();
    function_5fa77e68e934eda2();
    initstealthfuncsmp();
    scripts\anim\face::initlevelface();
    scripts\cp_mp\vehicles\vehicle_anim::vehicleaniminit();
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x20d
// Size: 0x2c
function setupgrenades()
{
    aisetgrenadetimer( undefined, "lethal", randomintrange( 0, 20000 ) );
    aisetgrenadetimer( undefined, "tactical", randomintrange( 0, 20000 ) );
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x241
// Size: 0x2e
function initanimcallbacks()
{
    if ( !isdefined( anim.callbacks ) )
    {
        anim.callbacks = [];
    }
    
    anim.callbacks[ "PlaySoundAtViewHeight" ] = &play_sound_at_viewheightmp;
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x277
// Size: 0x70
function function_5fa77e68e934eda2()
{
    registersharedfunc( "ai", "onHumanoidAgentKilledCommon_SharedFunc", &scripts\mp\mp_agent::on_humanoid_agent_killed_common );
    registersharedfunc( "ai", "spawnNewAIType_SharedFunc", &scripts\mp\mp_agent::spawnnewagentaitype );
    registersharedfunc( "ai", "Animscripted_SharedFunc", &scripts\asm\shared\mp\utility::animscriptedagent );
    registersharedfunc( "ai", "get_aitype_by_subclass_SharedFunc", &scripts\cp_mp\agents\agent_utils::function_3290e192ac188e2d );
    registersharedfunc( "ai", "GetFreeAICount", &function_2df8a33395b87f );
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2ef
// Size: 0x7
function private function_2df8a33395b87f()
{
    return getfreeagentcount();
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 3
// Checksum 0x0, Offset: 0x2ff
// Size: 0x47
function play_sound_at_viewheightmp( aliasname, notification_string, var_a68adbd3eefe9282 )
{
    if ( !isdefined( aliasname ) )
    {
        return;
    }
    
    if ( !soundexists( aliasname ) )
    {
        return;
    }
    
    self playsoundatviewheight( aliasname );
    
    if ( isdefined( notification_string ) )
    {
        wait lookupsoundlength( aliasname ) / 1000;
        self notify( notification_string );
    }
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x34e
// Size: 0x10
function initstealthfuncsmp()
{
    level.stealthinit = &initstealthmp;
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x366
// Size: 0x3
function getcorpsearraymp()
{
    return [];
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x372
// Size: 0x2
function setcorpseremovetimerfuncmp()
{
    
}

// Namespace agent_init / scripts\cp_mp\agents\agent_init
// Params 0
// Checksum 0x0, Offset: 0x37c
// Size: 0x1e
function initstealthmp()
{
    level.fngetcorpsearrayfunc = &getcorpsearraymp;
    level.fnsetcorpseremovetimerfunc = &setcorpseremovetimerfuncmp;
}

