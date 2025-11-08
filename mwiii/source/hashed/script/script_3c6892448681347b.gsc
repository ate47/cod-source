#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace dodge;

// Namespace dodge / namespace_447031647c18249
// Params 3
// Checksum 0x0, Offset: 0xc2
// Size: 0xbc
function function_a16975ad999570bf( asmname, statename, params )
{
    self endon( statename + "_finished" );
    assert( isdefined( self.var_d920859fcc741412 ) && self.var_d920859fcc741412 >= 0 );
    animid = asm_getanim( asmname, statename );
    xanim = asm_getxanim( statename, animid );
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, asm_getxanim( statename, animid ) );
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    }
}

