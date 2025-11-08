#namespace omnvar_utility;

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x88
// Size: 0x7a
function setcachedgameomnvar( omnvar, value )
{
    if ( !isdefined( omnvar ) || !isdefined( value ) )
    {
        return;
    }
    
    if ( !isdefined( level.cachedomnars ) )
    {
        level.cachedomnars = [];
    }
    
    shouldset = !isdefined( level.cachedomnars[ omnvar ] ) || level.cachedomnars[ omnvar ] != value;
    level.cachedomnars[ omnvar ] = value;
    
    if ( shouldset )
    {
        setomnvar( omnvar, value );
    }
}

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x10a
// Size: 0x81
function setcachedclientomnvar( omnvar, value )
{
    if ( !isdefined( self ) || !isdefined( omnvar ) || !isdefined( value ) )
    {
        return;
    }
    
    if ( !isdefined( self.cachedomnars ) )
    {
        self.cachedomnars = [];
    }
    
    shouldset = !isdefined( self.cachedomnars[ omnvar ] ) || self.cachedomnars[ omnvar ] != value;
    self.cachedomnars[ omnvar ] = value;
    
    if ( shouldset )
    {
        self setclientomnvar( omnvar, value );
    }
}

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x193
// Size: 0x7b
function repackomnvar( bitoffset, bitwidth, prevpackedvalue, newvalue )
{
    mask = int( pow( 2, bitwidth ) ) - 1;
    var_a463992091f1d483 = ( newvalue & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    cleanedbase = prevpackedvalue & invertedmask;
    repackedvalue = cleanedbase + var_a463992091f1d483;
    return repackedvalue;
}

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x217
// Size: 0x47
function unpackvalue( bitoffset, bitwidth, packedvalue )
{
    mask = int( pow( 2, bitwidth ) ) - 1;
    var_a463992091f1d483 = packedvalue >> bitoffset & mask;
    return var_a463992091f1d483;
}

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x267
// Size: 0x59
function function_63437fca39c681dc( omnvarname, bitoffset, bitwidth, value )
{
    prevvalue = self getclientomnvar( omnvarname );
    repackedvalue = repackomnvar( bitoffset, bitwidth, prevvalue, value );
    
    if ( prevvalue != repackedvalue )
    {
        self setclientomnvar( omnvarname, repackedvalue );
    }
}

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x2c8
// Size: 0x42
function function_40f3e4aeda0e3f00( omnvarname, bitoffset, bitwidth )
{
    value = self getclientomnvar( omnvarname );
    unpackedvalue = unpackvalue( bitoffset, bitwidth, value );
    return unpackedvalue;
}

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x313
// Size: 0x57
function function_d3cf7ff1a257e2c3( omnvarname, bitoffset, bitwidth, value )
{
    prevvalue = getomnvar( omnvarname );
    repackedvalue = repackomnvar( bitoffset, bitwidth, prevvalue, value );
    
    if ( prevvalue != repackedvalue )
    {
        setomnvar( omnvarname, repackedvalue );
    }
}

// Namespace omnvar_utility / scripts\cp_mp\utility\omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x372
// Size: 0x41
function function_610e0cca26bba2f( omnvarname, bitoffset, bitwidth )
{
    value = getomnvar( omnvarname );
    unpackedvalue = unpackvalue( bitoffset, bitwidth, value );
    return unpackedvalue;
}

