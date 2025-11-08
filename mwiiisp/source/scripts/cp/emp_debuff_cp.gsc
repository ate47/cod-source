#using scripts\engine\utility;

#namespace emp_debuff_cp;

// Namespace emp_debuff_cp / scripts\cp\emp_debuff_cp
// Params 0
// Checksum 0x0, Offset: 0xcf
// Size: 0x2e
function emp_debuff_init()
{
    registersharedfunc( "emp", "getPlayerEMPImmune", &getplayerempimmune );
    registersharedfunc( "emp", "setPlayerEMPImmune", &setplayerempimmune );
}

// Namespace emp_debuff_cp / scripts\cp\emp_debuff_cp
// Params 0
// Checksum 0x0, Offset: 0x105
// Size: 0xc, Type: bool
function getplayerempimmune()
{
    return isdefined( self.empnotallowed );
}

// Namespace emp_debuff_cp / scripts\cp\emp_debuff_cp
// Params 1
// Checksum 0x0, Offset: 0x11a
// Size: 0x6e
function setplayerempimmune( isimmune )
{
    if ( !isdefined( self.empnotallowed ) )
    {
        self.empnotallowed = 0;
    }
    
    if ( isimmune )
    {
        assertex( self.empnotallowed > 0, "allow_emp(true) called when emp was already allowed." );
        self.empnotallowed--;
        
        if ( self.empnotallowed == 0 )
        {
            self.empnotallowed = undefined;
        }
        
        return;
    }
    
    self.empnotallowed++;
}

