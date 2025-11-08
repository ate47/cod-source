#using scripts\asm\asm;
#using scripts\engine\utility;

#namespace namespace_fe2386b487039c1;

// Namespace namespace_fe2386b487039c1 / namespace_f9ca911ed03102c9
// Params 3
// Checksum 0x0, Offset: 0xe3
// Size: 0xbf
function function_51ea7d22d150c2b4( asmname, statename, params )
{
    animaliasparam = undefined;
    
    if ( isdefined( params ) && isstring( params ) )
    {
        animaliasparam = params;
    }
    
    self endon( statename + "_finished" );
    self orientmode( "face current" );
    self animmode( "live_ragdoll" );
    
    if ( isdefined( animaliasparam ) )
    {
        animid = asm_getanim( asmname, statename, animaliasparam );
    }
    else
    {
        animid = asm_getanim( asmname, statename );
    }
    
    self aisetanim( statename, animid );
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace namespace_fe2386b487039c1 / namespace_f9ca911ed03102c9
// Params 4
// Checksum 0x0, Offset: 0x1aa
// Size: 0xa9
function function_56a47f26f49fc5eb( asmname, statename, blendtime, params )
{
    self endon( statename + "_finished" );
    animid = asm_getanim( asmname, statename );
    animname = asm_getxanim( statename, animid );
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, animname );
    self setliveragdollrecoveryanim( animname );
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace namespace_fe2386b487039c1 / namespace_f9ca911ed03102c9
// Params 3
// Checksum 0x0, Offset: 0x25b
// Size: 0x3d
function function_bde90ceefebf39a9( asmname, statename, params )
{
    ent_flag_set( "in_liveragdoll" );
    self._blackboard.var_8f8de825579d7e05 = 1;
}

// Namespace namespace_fe2386b487039c1 / namespace_f9ca911ed03102c9
// Params 3
// Checksum 0x0, Offset: 0x2a0
// Size: 0x43
function function_7f50ea7f54ae3bd2( asmname, statename, params )
{
    ent_flag_clear( "in_liveragdoll" );
    self._blackboard.var_8f8de825579d7e05 = 0;
    self stopliveragdoll();
}

