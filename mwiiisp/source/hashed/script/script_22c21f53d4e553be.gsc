#using script_22c21f53d4e553be;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;

#namespace cp_animscripted_cap;

// Namespace cp_animscripted_cap / namespace_5bbfce4b2ded6c4c
// Params 3
// Checksum 0x0, Offset: 0x94
// Size: 0x103
function function_5451dca3c782adc7( asmname, statename, params )
{
    if ( !isdefined( params ) )
    {
        if ( isdefined( self.var_2b7fd37b90be5d3 ) )
        {
            result = scripts\asm\cap::cap_lookupanimfromalias( statename, self.var_2b7fd37b90be5d3 );
            
            if ( isdefined( result ) )
            {
                self.var_2b7fd37b90be5d3 = undefined;
                return result;
            }
        }
        
        randomalias = scripts\asm\cap::cap_lookuprandomalias( statename );
        
        if ( isdefined( randomalias ) )
        {
            return scripts\asm\cap::cap_lookupanimfromalias( statename, randomalias );
        }
    }
    
    result = undefined;
    
    if ( isdefined( self.var_2b7fd37b90be5d3 ) )
    {
        alias = self.var_2b7fd37b90be5d3 + "_" + params;
        result = scripts\asm\cap::cap_lookupanimfromalias( statename, alias );
        
        if ( isdefined( result ) )
        {
            if ( params == "end" )
            {
                self.var_2b7fd37b90be5d3 = undefined;
            }
            
            return result;
        }
    }
    
    prefixstr = scripts\asm\asm_bb::bb_getprefixstring( params );
    
    if ( isdefined( prefixstr ) )
    {
        randomalias = scripts\asm\cap::cap_lookuprandomalias( statename, prefixstr );
        result = scripts\asm\cap::cap_lookupanimfromalias( statename, randomalias );
    }
    else
    {
        result = scripts\asm\cap::cap_lookupanimfromalias( statename, params );
    }
    
    return result;
}

// Namespace cp_animscripted_cap / namespace_5bbfce4b2ded6c4c
// Params 3
// Checksum 0x0, Offset: 0x1a0
// Size: 0x26
function function_e21cd33efed8c6b9( asm, arc, override )
{
    thread function_d6a959e322512d83( asm, arc, override );
}

// Namespace cp_animscripted_cap / namespace_5bbfce4b2ded6c4c
// Params 3
// Checksum 0x0, Offset: 0x1ce
// Size: 0x39
function function_d6a959e322512d83( asm, arc, override )
{
    self endon( "death" );
    wait 0.05;
    namespace_5bbfce4b2ded6c4c::function_8eff1baf0c6bbad6( override );
    scripts\common\cap::cap_start( asm, arc );
}

// Namespace cp_animscripted_cap / namespace_5bbfce4b2ded6c4c
// Params 1
// Checksum 0x0, Offset: 0x20f
// Size: 0x15
function function_8eff1baf0c6bbad6( alias )
{
    self.var_2b7fd37b90be5d3 = alias;
}

// Namespace cp_animscripted_cap / namespace_5bbfce4b2ded6c4c
// Params 0
// Checksum 0x0, Offset: 0x22c
// Size: 0x2
function function_c474c81abbc98247()
{
    
}

