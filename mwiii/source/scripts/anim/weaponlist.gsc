#using scripts\anim\utility_common;

#namespace weaponlist;

// Namespace weaponlist / scripts\anim\weaponlist
// Params 0
// Checksum 0x0, Offset: 0xc8
// Size: 0x36, Type: bool
function usingautomaticweapon()
{
    return weaponisauto( self.weapon ) || weaponisbeam( self.weapon ) || weaponburstcount( self.weapon ) > 0;
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 0
// Checksum 0x0, Offset: 0x107
// Size: 0x25, Type: bool
function usingsemiautoweapon()
{
    return weaponissemiauto( self.weapon ) || weaponburstcount( self.weapon ) == 1;
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 0
// Checksum 0x0, Offset: 0x135
// Size: 0x29
function autoshootanimrate()
{
    if ( usingautomaticweapon() )
    {
        return ( 0.1 / weaponfiretime( self.weapon ) );
    }
    
    return 0.5;
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 0
// Checksum 0x0, Offset: 0x166
// Size: 0x38
function burstshootanimrate()
{
    if ( usingautomaticweapon() )
    {
        return ( 0.1 / weaponfiretime( self.weapon ) );
    }
    
    if ( scripts\anim\utility_common::usingpistol() )
    {
        return 1;
    }
    
    return 0.2;
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 0
// Checksum 0x0, Offset: 0x1a6
// Size: 0x7
function waitaftershot()
{
    return 0.25;
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 1
// Checksum 0x0, Offset: 0x1b6
// Size: 0x5f
function shootanimtime( semiautofire )
{
    if ( !usingautomaticweapon() || isdefined( semiautofire ) && semiautofire == 1 )
    {
        rand = 0.5 + randomfloat( 1 );
        return ( weaponfiretime( self.weapon ) * rand );
    }
    
    return weaponfiretime( self.weapon );
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 0
// Checksum 0x0, Offset: 0x21d
// Size: 0x97
function refillclip()
{
    assertex( isdefined( self.weapon ), "<dev string:x1c>" + self.model );
    
    if ( isnullweapon( self.weapon ) )
    {
        self.bulletsinclip = 0;
        return 0;
    }
    
    if ( !isdefined( self.bulletsinclip ) )
    {
        self.bulletsinclip = weaponclipsize( self.weapon );
    }
    else
    {
        self.bulletsinclip = weaponclipsize( self.weapon );
    }
    
    assertex( isdefined( self.bulletsinclip ), "<dev string:x3f>" );
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 5
// Checksum 0x0, Offset: 0x2bc
// Size: 0xb6
function add_weapon( name, type, time, clipsize, anims )
{
    assert( isdefined( name ) );
    assert( isdefined( type ) );
    
    if ( !isdefined( time ) )
    {
        time = 3;
    }
    
    if ( !isdefined( clipsize ) )
    {
        time = 1;
    }
    
    if ( !isdefined( anims ) )
    {
        anims = "rifle";
    }
    
    name = tolower( name );
    anim.aiweapon[ name ][ "type" ] = type;
    anim.aiweapon[ name ][ "time" ] = time;
    anim.aiweapon[ name ][ "clipsize" ] = clipsize;
    anim.aiweapon[ name ][ "anims" ] = anims;
}

// Namespace weaponlist / scripts\anim\weaponlist
// Params 1
// Checksum 0x0, Offset: 0x37a
// Size: 0x27
function addturret( turret )
{
    anim.aiweapon[ tolower( turret ) ][ "type" ] = "turret";
}

