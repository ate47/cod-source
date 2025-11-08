#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\heavyarmor;
#using scripts\mp\utility\weapon;

#namespace lightarmor;

// Namespace lightarmor / scripts\mp\lightarmor
// Params 1
// Checksum 0x0, Offset: 0x10a
// Size: 0x14, Type: bool
function haslightarmor( player )
{
    return getlightarmorvalue( player ) > 0;
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 1
// Checksum 0x0, Offset: 0x127
// Size: 0x27
function getlightarmorvalue( player )
{
    if ( isdefined( player.lightarmorhp ) )
    {
        return player.lightarmorhp;
    }
    
    return 0;
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 4
// Checksum 0x0, Offset: 0x157
// Size: 0xdc
function setlightarmorvalue( player, value, overridegreater, playvfx )
{
    if ( !isdefined( overridegreater ) )
    {
        overridegreater = 1;
    }
    
    if ( !isdefined( playvfx ) )
    {
        playvfx = 1;
    }
    
    if ( lightarmor_lightarmor_disabled( player ) )
    {
        value = 0;
        overridegreater = 1;
    }
    
    oldvalue = getlightarmorvalue( player );
    
    if ( !overridegreater && oldvalue > value )
    {
        value = oldvalue;
    }
    
    if ( oldvalue <= 0 && value > 0 )
    {
        lightarmor_set( player, value, playvfx );
        return;
    }
    
    if ( oldvalue > 0 && value <= 0 )
    {
        lightarmor_unset( player );
        return;
    }
    
    player.lightarmorhp = value;
    
    if ( isplayer( player ) && oldvalue <= value && value > 0 && playvfx == 1 )
    {
        thread lightarmor_setfx( player );
    }
    
    if ( isplayer( player ) )
    {
        lightarmor_updatehud( player );
    }
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 0
// Checksum 0x0, Offset: 0x23b
// Size: 0x2
function init()
{
    
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 3
// Checksum 0x0, Offset: 0x245
// Size: 0x6b
function lightarmor_set( player, value, playvfx )
{
    assertex( isdefined( value ), "<dev string:x1c>" );
    player notify( "lightArmor_set" );
    player.lightarmorhp = value;
    lightarmor_updatehud( player );
    thread lightarmor_monitordeath( player );
    
    if ( isplayer( player ) && playvfx == 1 )
    {
        thread lightarmor_setfx( player );
    }
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 1
// Checksum 0x0, Offset: 0x2b8
// Size: 0x37
function lightarmor_unset( player )
{
    player notify( "lightArmor_unset" );
    player.lightarmorhp = undefined;
    lightarmor_updatehud( player );
    
    if ( isplayer( player ) )
    {
    }
    
    player notify( "remove_light_armor" );
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 11
// Checksum 0x0, Offset: 0x2f7
// Size: 0x189
function lightarmor_modifydamage( victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query )
{
    var_eb9b8cdc328659b0 = 0;
    damageblocked = 0;
    lightarmorhpmodified = victim.lightarmorhp;
    
    if ( !isdefined( query ) )
    {
        query = 1;
    }
    
    if ( !var_eb9b8cdc328659b0 )
    {
        if ( smeansofdeath == "MOD_FALLING" )
        {
            var_eb9b8cdc328659b0 = 1;
        }
    }
    
    if ( !var_eb9b8cdc328659b0 )
    {
        if ( isexplosivedamagemod( smeansofdeath ) )
        {
            if ( isdefined( inflictor ) && isdefined( inflictor.stuckenemyentity ) && inflictor.stuckenemyentity == victim )
            {
                var_eb9b8cdc328659b0 = 1;
            }
        }
    }
    
    if ( !var_eb9b8cdc328659b0 )
    {
        if ( scripts\mp\utility\weapon::issuperdamagesource( sweapon ) )
        {
            var_eb9b8cdc328659b0 = 1;
        }
    }
    
    if ( !var_eb9b8cdc328659b0 )
    {
        damageblocked = min( damage + damageadd, victim.lightarmorhp );
        lightarmorhpmodified -= damage + damageadd;
        
        if ( !query )
        {
            victim.lightarmorhp -= damage + damageadd;
        }
        
        damage = 0;
        damageadd = 0;
        
        if ( lightarmorhpmodified <= 0 )
        {
            damage = abs( lightarmorhpmodified );
            damageadd = 0;
            
            if ( !query )
            {
                lightarmor_unset( victim );
            }
        }
    }
    
    if ( !query )
    {
        lightarmor_updatehud( self );
    }
    
    if ( damageblocked > 0 && damage == 0 )
    {
        damage = 1;
    }
    
    return [ damageblocked, damage, damageadd ];
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 1
// Checksum 0x0, Offset: 0x489
// Size: 0x19, Type: bool
function lightarmor_lightarmor_disabled( player )
{
    if ( player scripts\mp\heavyarmor::hasheavyarmor() )
    {
        return true;
    }
    
    return false;
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 1
// Checksum 0x0, Offset: 0x4ab
// Size: 0x31
function lightarmor_monitordeath( player )
{
    player endon( "disconnect" );
    player endon( "lightArmor_set" );
    player endon( "lightArmor_unset" );
    player waittill( "death" );
    thread lightarmor_unset( player );
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 1
// Checksum 0x0, Offset: 0x4e4
// Size: 0x15
function lightarmor_updatehud( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
}

// Namespace lightarmor / scripts\mp\lightarmor
// Params 1
// Checksum 0x0, Offset: 0x501
// Size: 0xb
function lightarmor_setfx( player )
{
    
}

