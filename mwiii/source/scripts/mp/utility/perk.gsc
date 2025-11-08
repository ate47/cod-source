#using scripts\mp\perks\perkpackage;
#using scripts\mp\perks\perks;
#using scripts\mp\utility\perk_shared;

#namespace perk;

// Namespace perk / scripts\mp\utility\perk
// Params 0
// Checksum 0x0, Offset: 0xa7
// Size: 0xb
function perksenabled()
{
    return level.allowperks;
}

// Namespace perk / scripts\mp\utility\perk
// Params 1
// Checksum 0x0, Offset: 0xbb
// Size: 0x12
function _hasperk( perkname )
{
    return scripts\mp\utility\perk_shared::function_56ad1b98a0613f8a( perkname );
}

// Namespace perk / scripts\mp\utility\perk
// Params 1
// Checksum 0x0, Offset: 0xd6
// Size: 0x55
function giveperk( perkname )
{
    assertex( isdefined( perkname ), "<dev string:x1c>" );
    assertex( perkname != "<dev string:x4b>", "<dev string:x5d>" );
    assertex( perkname != "<dev string:xa0>", "<dev string:xa8>" );
    scripts\mp\perks\perks::_setperk( perkname );
    scripts\mp\perks\perks::_setextraperks( perkname );
}

// Namespace perk / scripts\mp\utility\perk
// Params 0
// Checksum 0x0, Offset: 0x133
// Size: 0x9
function resetperkpackage()
{
    scripts\mp\perks\perkpackage::perkpackage_reset();
}

// Namespace perk / scripts\mp\utility\perk
// Params 1
// Checksum 0x0, Offset: 0x144
// Size: 0x69
function removeperk( perkname )
{
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    assertex( isdefined( perkname ), "<dev string:xe1>" );
    assertex( perkname != "<dev string:x4b>", "<dev string:x112>" );
    assertex( perkname != "<dev string:xa0>", "<dev string:x145>" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    scripts\mp\perks\perks::_unsetperk( perkname );
    scripts\mp\perks\perks::_unsetextraperks( perkname );
}

// Namespace perk / scripts\mp\utility\perk
// Params 1
// Checksum 0x0, Offset: 0x1b5
// Size: 0x17d
function blockperkfunction( perkname )
{
    assertex( isdefined( perkname ), "<dev string:x16e>" );
    assertex( perkname != "<dev string:x4b>", "<dev string:x1a0>" );
    assertex( perkname != "<dev string:xa0>", "<dev string:x1d4>" );
    
    if ( !function_8641edd897d42547( perkname ) )
    {
        self.perksblocked[ perkname ] = 1;
    }
    else
    {
        self.perksblocked[ perkname ]++;
    }
    
    if ( self.perksblocked[ perkname ] == 1 && _hasperk( perkname ) )
    {
        scripts\mp\perks\perks::_unsetperkinternal( perkname );
        
        foreach ( perk, array in level.extraperkmap )
        {
            if ( perkname == perk )
            {
                foreach ( extraperk in array )
                {
                    if ( !function_8641edd897d42547( perkname ) )
                    {
                        self.perksblocked[ extraperk ] = 1;
                    }
                    else
                    {
                        self.perksblocked[ extraperk ]++;
                    }
                    
                    if ( self.perksblocked[ extraperk ] == 1 )
                    {
                        scripts\mp\perks\perks::_unsetperkinternal( extraperk );
                    }
                }
                
                break;
            }
        }
    }
    
    /#
        level notify( "<dev string:x1fe>" );
    #/
}

// Namespace perk / scripts\mp\utility\perk
// Params 1
// Checksum 0x0, Offset: 0x33a
// Size: 0x1c4
function unblockperkfunction( perkname )
{
    assertex( isdefined( perkname ), "<dev string:x213>" );
    assertex( perkname != "<dev string:x4b>", "<dev string:x24d>" );
    assertex( perkname != "<dev string:xa0>", "<dev string:x289>" );
    assertex( function_8641edd897d42547( perkname ) && istrue( self.perksblocked[ perkname ] > 0 ) || isdefined( level.perks_suppressasserts ), "<dev string:x2bb>" );
    self.perksblocked[ perkname ]--;
    
    if ( self.perksblocked[ perkname ] == 0 )
    {
        self.perksblocked[ perkname ] = undefined;
        
        if ( _hasperk( perkname ) )
        {
            scripts\mp\perks\perks::_setperkinternal( perkname );
            
            foreach ( perk, array in level.extraperkmap )
            {
                if ( perkname == perk )
                {
                    foreach ( extraperk in array )
                    {
                        assertex( function_8641edd897d42547( extraperk ) && istrue( self.perksblocked[ extraperk ] > 0 ) || isdefined( level.perks_suppressasserts ), "<dev string:x2f6>" );
                        self.perksblocked[ extraperk ]--;
                        
                        if ( self.perksblocked[ extraperk ] == 0 )
                        {
                            scripts\mp\perks\perks::_setperkinternal( extraperk );
                            self.perksblocked[ extraperk ] = undefined;
                        }
                    }
                    
                    break;
                }
            }
        }
    }
    
    /#
        level notify( "<dev string:x1fe>" );
    #/
}

// Namespace perk / scripts\mp\utility\perk
// Params 1
// Checksum 0x0, Offset: 0x506
// Size: 0x28
function getbaseperkname( perkname )
{
    if ( isendstr( perkname, "_ks" ) )
    {
        perkname = getsubstr( perkname, 0, perkname.size - 3 );
    }
    
    return perkname;
}

// Namespace perk / scripts\mp\utility\perk
// Params 0
// Checksum 0x0, Offset: 0x537
// Size: 0x7
function lightweightscalar()
{
    return 1.06;
}

// Namespace perk / scripts\mp\utility\perk
// Params 1
// Checksum 0x0, Offset: 0x547
// Size: 0x2d, Type: bool
function function_8641edd897d42547( perkname )
{
    if ( !isdefined( perkname ) )
    {
        return false;
    }
    
    if ( !isdefined( self.perksblocked ) )
    {
        return false;
    }
    
    return isdefined( self.perksblocked[ perkname ] );
}

// Namespace perk / scripts\mp\utility\perk
// Params 0
// Checksum 0x0, Offset: 0x57d
// Size: 0x48
function function_97cbc67b162a70f4()
{
    if ( getdvarint( @"hash_bd3e4943999de33b", 0 ) )
    {
        return 0;
    }
    
    if ( isdefined( level.gamemodebundle ) )
    {
        return istrue( level.gamemodebundle.var_ac36c9085edf4e44 );
    }
    
    return getdvarint( @"perk_package_enabled", 1 );
}

// Namespace perk / scripts\mp\utility\perk
// Params 0
// Checksum 0x0, Offset: 0x5ce
// Size: 0x33
function function_ea4c5dc15c3bbdd9()
{
    if ( isdefined( level.gamemodebundle ) )
    {
        return istrue( level.gamemodebundle.var_e12ed09bf2e43167 );
    }
    
    return getdvarint( @"hash_7a1dc05c581af6f8", 0 );
}

// Namespace perk / scripts\mp\utility\perk
// Params 0
// Checksum 0x0, Offset: 0x60a
// Size: 0x25, Type: bool
function function_d327b07e25d475e1()
{
    if ( isdefined( level.gamemodebundle ) )
    {
        return istrue( level.gamemodebundle.var_9b88563ac5ace911 );
    }
    
    return false;
}

