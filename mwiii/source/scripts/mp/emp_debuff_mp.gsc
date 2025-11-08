#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#using scripts\mp\emp_debuff_mp;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\perk;

#namespace emp_debuff_mp;

// Namespace emp_debuff_mp / scripts\mp\emp_debuff_mp
// Params 0
// Checksum 0x0, Offset: 0x125
// Size: 0x5a
function emp_debuff_init()
{
    registersharedfunc( "emp", "getPlayerEMPImmune", &getplayerempimmune );
    registersharedfunc( "emp", "setPlayerEMPImmune", &setplayerempimmune );
    registersharedfunc( "emp", "onPlayerEMPed", &onplayeremped );
    registersharedfunc( "emp", "onVehicleEMPed", &onvehicleemped );
}

// Namespace emp_debuff_mp / scripts\mp\emp_debuff_mp
// Params 0
// Checksum 0x0, Offset: 0x187
// Size: 0xd
function getplayerempimmune()
{
    return _hasperk( "specialty_empimmune" );
}

// Namespace emp_debuff_mp / scripts\mp\emp_debuff_mp
// Params 1
// Checksum 0x0, Offset: 0x19d
// Size: 0x2a
function setplayerempimmune( isimmune )
{
    if ( isimmune )
    {
        giveperk( "specialty_empimmune" );
        return;
    }
    
    removeperk( "specialty_empimmune" );
}

// Namespace emp_debuff_mp / scripts\mp\emp_debuff_mp
// Params 1
// Checksum 0x0, Offset: 0x1cf
// Size: 0x37
function onplayeremped( data )
{
    attacker = data.attacker;
    
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self, attacker ) ) )
    {
        attacker thread scripts\mp\killstreaks\killstreaks::givescoreforempedplayer();
    }
}

// Namespace emp_debuff_mp / scripts\mp\emp_debuff_mp
// Params 1
// Checksum 0x0, Offset: 0x20e
// Size: 0x77
function onvehicleemped( data )
{
    attacker = data.attacker;
    
    if ( isdefined( self.turrets ) && self.turrets.size > 0 )
    {
        scripts\mp\emp_debuff_mp::function_a3a4d32a799e95d5( data );
    }
    
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
        return;
    }
    
    if ( scripts\cp_mp\vehicles\vehicle::isbossvehicle() )
    {
        attacker scripts\mp\killstreaks\killstreaks::givescoreforempedvehicle();
    }
}

// Namespace emp_debuff_mp / scripts\mp\emp_debuff_mp
// Params 1
// Checksum 0x0, Offset: 0x28d
// Size: 0x3e
function function_a3a4d32a799e95d5( data )
{
    attacker = data.attacker;
    
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker scripts\mp\killstreaks\killstreaks::function_7d84b8c1b826b7ea();
    }
}

