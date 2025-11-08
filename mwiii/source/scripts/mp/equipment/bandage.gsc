#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\adrenaline;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;

#namespace bandage;

// Namespace bandage / scripts\mp\equipment\bandage
// Params 0
// Checksum 0x0, Offset: 0x174
// Size: 0x7
function getbandagehealfractionbr()
{
    return 0.2;
}

// Namespace bandage / scripts\mp\equipment\bandage
// Params 0
// Checksum 0x0, Offset: 0x184
// Size: 0x4
function getbandagehealtimebr()
{
    return 5;
}

// Namespace bandage / scripts\mp\equipment\bandage
// Params 0
// Checksum 0x0, Offset: 0x191
// Size: 0x4
function getfirstaidhealtimebr()
{
    return 5;
}

// Namespace bandage / scripts\mp\equipment\bandage
// Params 1
// Checksum 0x0, Offset: 0x19e
// Size: 0x5c
function getbandagetime( itemname )
{
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        healscale = 1;
        
        if ( isdefined( self.br_armorlevel ) && self.br_armorlevel == 3 )
        {
            healscale = 0.75;
        }
        
        if ( itemname == "equip_bandages" )
        {
            return ( 5 * healscale );
        }
        
        return ( 5 * healscale );
    }
    
    return 5;
}

// Namespace bandage / scripts\mp\equipment\bandage
// Params 2
// Checksum 0x0, Offset: 0x203
// Size: 0xec
function usebandage( itemname, var_1156b7a3b9b6aa08 )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( self.health == self.maxhealth )
    {
        self iprintlnbold( "Your health is full!" );
        return;
    }
    
    weaponobj = "bandage_mp";
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        weaponobj = "bandage_br_fake";
    }
    
    self disableweaponswitch();
    self allowfire( 0 );
    self giveandfireoffhand( weaponobj );
    wait 0.25;
    self.bandageactive = 1;
    self.healthregendisabled = 0;
    bandageheal( itemname );
    wait 0.25;
    
    if ( self hasweapon( weaponobj ) )
    {
        scripts\cp_mp\utility\inventory_utility::getridofweapon( weaponobj );
    }
    
    self allowfire( 1 );
    self enableweaponswitch();
    var_1156b7a3b9b6aa08--;
    scripts\mp\equipment::setequipmentslotammo( "health", var_1156b7a3b9b6aa08 );
    self.bandageactive = 0;
    self.healthregendisabled = 1;
}

// Namespace bandage / scripts\mp\equipment\bandage
// Params 1
// Checksum 0x0, Offset: 0x2f7
// Size: 0x38
function bandageheal( itemname )
{
    self endon( "heal_end" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    thread scripts\mp\gametypes\br_public::watchhealend();
    self notify( "force_regeneration" );
    wait getbandagetime( itemname );
}

