#using scripts\asm\asm;
#using scripts\asm\asm_bb;

#namespace custom;

// Namespace custom / scripts\asm\soldier\custom
// Params 4
// Checksum 0x0, Offset: 0xae
// Size: 0x35, Type: bool
function shouldstartcustomidle( asmname, statename, tostatename, params )
{
    self notify( "cap_custom_arrival" );
    return isdefined( self.var_85ecbbe4fae7c0ae );
}

// Namespace custom / scripts\asm\soldier\custom
// Params 4
// Checksum 0x0, Offset: 0xec
// Size: 0x37, Type: bool
function shouldcustomexit( asmname, statename, tostatename, params )
{
    return bb_moverequested() && isdefined( self.var_57e1b0c4ad45db70 );
}

// Namespace custom / scripts\asm\soldier\custom
// Params 4
// Checksum 0x0, Offset: 0x12c
// Size: 0x2e, Type: bool
function shouldstopcustomidle( asmname, statename, tostatename, params )
{
    return !isdefined( self.var_85ecbbe4fae7c0ae );
}

// Namespace custom / scripts\asm\soldier\custom
// Params 3
// Checksum 0x0, Offset: 0x163
// Size: 0x3e
function chooseanim_customidle( asmname, statename, params )
{
    assert( isdefined( self.var_85ecbbe4fae7c0ae ) );
    return asm_getrandomanim( asmname, self.var_85ecbbe4fae7c0ae );
}

// Namespace custom / scripts\asm\soldier\custom
// Params 4
// Checksum 0x0, Offset: 0x1aa
// Size: 0x2d, Type: bool
function function_c929d0a507d24467( asmname, statename, tostatename, params )
{
    return isdefined( self.customarrivalhandler );
}

// Namespace custom / scripts\asm\soldier\custom
// Params 3
// Checksum 0x0, Offset: 0x1e0
// Size: 0x3b
function function_a08c428057e0222a( asmname, statename, params )
{
    assert( isdefined( self.customarrivalhandler ) );
    self [[ self.customarrivalhandler ]]();
}

