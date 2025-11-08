#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;

#namespace call_reinforcements;

// Namespace call_reinforcements / namespace_271f346b8e0c52cc
// Params 1
// Checksum 0x0, Offset: 0x2a4
// Size: 0x5a
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onUserInit;
        case #"hash_722d767fd6d40f56":
            return &onUserTerminate;
        case #"hash_256644959193a6c7":
            return &callreinforcements;
    }
    
    assertmsg( "<dev string:x1c>" + funcid );
}

// Namespace call_reinforcements / namespace_271f346b8e0c52cc
// Params 1
// Checksum 0x0, Offset: 0x306
// Size: 0xb
function onUserInit( interactionid )
{
    
}

// Namespace call_reinforcements / namespace_271f346b8e0c52cc
// Params 1
// Checksum 0x0, Offset: 0x319
// Size: 0x1c
function onUserTerminate( interactionid )
{
    self clearbtgoal( 1 );
    self notify( "endcallreinforcements" );
}

// Namespace call_reinforcements / namespace_271f346b8e0c52cc
// Params 2
// Checksum 0x0, Offset: 0x33d
// Size: 0xb0
function callreinforcements( statename, params )
{
    self endon( "death" );
    self endon( "endcallreinforcements" );
    callreinforcementsbundle = getscriptbundle( "ai_behavior_call_reinforcements:ai_behavior_call_reinforcements_default" );
    
    if ( !isdefined( callreinforcementsbundle ) )
    {
        assertmsg( "<dev string:x3d>" );
        return;
    }
    
    self function_e64ea2b4e79c4b74( 1 );
    self setbtgoalradius( 1, 12 );
    capname = "cap_call_reinforcements";
    
    if ( self.asmname != capname )
    {
        scripts\common\cap::cap_start( capname, "caps/interactions/cap_call_reinforcements" );
    }
    
    self playsound( "dx_br_dbos_dbli_dbtp_bitr" );
    thread function_6cdcfd04e3704a8a( callreinforcementsbundle.var_1f76883e524b41a5 );
    self waittill( "cap_exit_completed" );
}

// Namespace call_reinforcements / namespace_271f346b8e0c52cc
// Params 1
// Checksum 0x0, Offset: 0x3f5
// Size: 0x6d
function function_6cdcfd04e3704a8a( calllength )
{
    self endon( "death" );
    self endon( "endcallreinforcements" );
    wait calllength;
    
    if ( isdefined( level.agent_funcs ) )
    {
        spawnreinforcementsfunc = level.agent_funcs[ "spawn_reinforcements" ];
        
        if ( isdefined( spawnreinforcementsfunc ) )
        {
            [[ spawnreinforcementsfunc ]]( self.origin, 0, 1 );
        }
    }
    
    asm_fireevent( self.asmname, "call_reinforcements_loop_end" );
}

// Namespace call_reinforcements / namespace_271f346b8e0c52cc
// Params 3
// Checksum 0x0, Offset: 0x46a
// Size: 0x12e
function callreinforcementschooseanim( asmname, statename, params )
{
    sectionname = params;
    
    if ( !isdefined( sectionname ) )
    {
        assertmsg( "<dev string:xb2>" );
        return;
    }
    
    stance = scripts\asm\asm_bb::bb_getrequestedstance();
    coverstate = scripts\asm\asm_bb::bb_getrequestedcoverstate();
    animname = "call_reinforcements";
    
    if ( coverstate != "exposed" )
    {
        covernode = scripts\asm\asm_bb::bb_getcovernode();
        
        if ( isdefined( covernode ) )
        {
            covertype = covernode.type;
            
            switch ( covertype )
            {
                case #"hash_cd3ffe799551db82":
                    animname += "_cover_right_" + stance;
                    break;
                case #"hash_e1d8e1adebed5a61":
                    animname += "_cover_left_" + stance;
                    break;
                case #"hash_c3b74422dec48736":
                    animname += "_cover_crouch";
                    break;
                case #"hash_78b110033ccb68b0":
                    animname += "_cover_stand";
                    break;
            }
        }
    }
    
    animname += "_" + sectionname;
    alternativename = scripts\asm\cap::cap_lookupanimfromalias( statename, animname );
    return alternativename;
}

