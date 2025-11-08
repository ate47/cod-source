#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\passives;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\spawn_event_aggregator;

#namespace weaponpassives;

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 0
// Checksum 0x0, Offset: 0x144
// Size: 0xe
function weaponpassivesinit()
{
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawnedweaponpassives );
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 0
// Checksum 0x0, Offset: 0x15a
// Size: 0xa
function onplayerspawnedweaponpassives()
{
    thread watchweaponchanged();
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 0
// Checksum 0x0, Offset: 0x16c
// Size: 0x39
function applyweaponchange()
{
    newweapon = self.currentweapon;
    
    if ( isdefined( newweapon ) && newweapon.basename != "none" )
    {
        giveweaponpassives( newweapon );
    }
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 0
// Checksum 0x0, Offset: 0x1ad
// Size: 0x29
function watchweaponchanged()
{
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        applyweaponchange();
        waittill_either( "weapon_change", "giveLoadout" );
    }
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 1
// Checksum 0x0, Offset: 0x1de
// Size: 0x91
function giveweaponpassives( weapon )
{
    clearpassives();
    passives = scripts\mp\loot::getpassivesforweapon( weapon.basename, weapon.variantid );
    
    if ( isdefined( passives ) )
    {
        foreach ( passive in passives )
        {
            giveplayerpassive( passive );
        }
    }
    
    self notify( "weapon_passives_given" );
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 1
// Checksum 0x0, Offset: 0x277
// Size: 0x29
function giveplayerpassive( passive )
{
    giveperk( passive );
    self.weaponpassives[ self.weaponpassives.size ] = passive;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 0
// Checksum 0x0, Offset: 0x2a8
// Size: 0x6d
function clearpassives()
{
    if ( isdefined( self.weaponpassives ) )
    {
        foreach ( passive in self.weaponpassives )
        {
            removeperk( passive );
        }
    }
    
    self.weaponpassives = [];
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 0
// Checksum 0x0, Offset: 0x31d
// Size: 0xc
function forgetpassives()
{
    self.weaponpassives = [];
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 1
// Checksum 0x0, Offset: 0x331
// Size: 0x42
function definepassivevalue( link )
{
    if ( !isdefined( self.passivevalues ) )
    {
        self.passivevalues = [];
    }
    
    if ( !isdefined( self.passivevalues[ link ] ) )
    {
        self.passivevalues[ link ] = 0;
    }
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 1
// Checksum 0x0, Offset: 0x37b
// Size: 0x1e
function getpassivevalue( link )
{
    definepassivevalue( link );
    return self.passivevalues[ link ];
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x3a2
// Size: 0x28
function setpassivevalue( link, value )
{
    definepassivevalue( link );
    self.passivevalues[ link ] = value;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x3d2
// Size: 0x3a, Type: bool
function teamsmatch( sourceplayer, targetplayer )
{
    if ( level.teambased )
    {
        return ( sourceplayer.team == targetplayer.team );
    }
    
    return sourceplayer == targetplayer;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x415
// Size: 0x13
function updateweaponpassivesonuse( player, objweapon )
{
    
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 10
// Checksum 0x0, Offset: 0x430
// Size: 0x53
function updateweaponpassivesondamage( victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query )
{
    
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 1
// Checksum 0x0, Offset: 0x48b
// Size: 0xb
function loadoutweapongiven( objweapon )
{
    
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 8
// Checksum 0x0, Offset: 0x49e
// Size: 0x43
function updateweaponpassivesonkill( einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir )
{
    
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x4e9
// Size: 0x83
function testpassivemessage( passive, suffix )
{
    if ( !isdefined( suffix ) )
    {
        suffix = "";
    }
    
    messagesuccess = 0;
    messageref = scripts\mp\passives::getpassivemessage( passive );
    messagestring = "";
    
    if ( isdefined( messageref ) )
    {
        messagestring = messageref + suffix;
        messagesuccess = scripts\mp\hud_message::testmiscmessage( messagestring );
    }
    
    /#
        if ( messagesuccess )
        {
            println( "<dev string:x1c>" + messagestring );
            return;
        }
        
        println( "<dev string:x3c>" + messagestring );
    #/
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x574
// Size: 0x68
function checkpassivemessage( passive, suffix )
{
    if ( !isdefined( suffix ) )
    {
        suffix = "";
    }
    
    messageref = scripts\mp\passives::getpassivemessage( passive );
    
    if ( isdefined( messageref ) )
    {
        if ( isendstr( suffix, "_camo" ) )
        {
            tempstring = strip_suffix( suffix, "_camo" );
            suffix = tempstring;
        }
        
        scripts\mp\hud_message::showmiscmessage( messageref + suffix );
    }
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x5e4
// Size: 0x4b, Type: bool
function getpassivedeathwatching( attacker, key )
{
    if ( !isdefined( attacker.passivedeathwatcher ) )
    {
        return false;
    }
    
    if ( !isdefined( attacker.passivedeathwatcher[ key ] ) )
    {
        return false;
    }
    
    if ( attacker.passivedeathwatcher[ key ] )
    {
        return true;
    }
    
    return false;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 3
// Checksum 0x0, Offset: 0x638
// Size: 0x46
function setpassivedeathwatching( attacker, key, enabled )
{
    if ( !isdefined( attacker.passivedeathwatcher ) )
    {
        attacker.passivedeathwatcher = [];
    }
    
    attacker.passivedeathwatcher[ key ] = enabled;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x686
// Size: 0x3c
function clearpassivedeathwatching( attacker, key )
{
    if ( !isdefined( attacker.passivedeathwatcher ) )
    {
        attacker.passivedeathwatcher = [];
    }
    
    attacker.passivedeathwatcher[ key ] = undefined;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 4
// Checksum 0x0, Offset: 0x6ca
// Size: 0x9b
function setstackvalues( id, stacksmax, var_4d8375d9e2e75e74, decaytime )
{
    if ( !isdefined( self.stackvalues ) )
    {
        self.stackvalues = [];
    }
    
    if ( !isdefined( self.stackvalues[ id ] ) )
    {
        values = spawnstruct();
        values.id = id;
        values.stacksmax = stacksmax;
        values.stackscurrent = var_4d8375d9e2e75e74;
        values.decaytime = decaytime;
        self.stackvalues[ id ] = values;
    }
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 1
// Checksum 0x0, Offset: 0x76d
// Size: 0x43
function getstackvalues( id )
{
    if ( !isdefined( self.stackvalues ) )
    {
        return undefined;
    }
    
    if ( !isdefined( self.stackvalues[ id ] ) )
    {
        return undefined;
    }
    
    values = self.stackvalues[ id ];
    return values;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 1
// Checksum 0x0, Offset: 0x7b9
// Size: 0x30
function getstackcount( id )
{
    values = getstackvalues( id );
    
    if ( !isdefined( values ) )
    {
        return 0;
    }
    
    return values.stackscurrent;
}

// Namespace weaponpassives / scripts\mp\perks\weaponpassives
// Params 2
// Checksum 0x0, Offset: 0x7f2
// Size: 0x13
function addstackcount( id, amount )
{
    
}

