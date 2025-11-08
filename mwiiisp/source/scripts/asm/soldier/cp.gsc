#namespace cp;

// Namespace cp / scripts\asm\soldier\cp
// Params 4
// Checksum 0x0, Offset: 0x68
// Size: 0x50, Type: bool
function transition_parachutestate( asmname, statename, tostatename, params )
{
    return isdefined( self._blackboard.parachutestate ) && self._blackboard.parachutestate == params;
}

// Namespace cp / scripts\asm\soldier\cp
// Params 4
// Checksum 0x0, Offset: 0xc1
// Size: 0x37, Type: bool
function function_6cef6e9599101b35( asmname, statename, tostatename, params )
{
    return self codemoverequested() && isdefined( self.grenade );
}

