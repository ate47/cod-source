#namespace cp_perk_utility;

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x114
// Size: 0x42
function perk_getmeleescalar()
{
    if ( isdefined( self.perk_data[ "melee_scalar" ] ) )
    {
        return self.perk_data[ "melee_scalar" ];
    }
    
    return self.perk_data[ "health" ].melee_scalar;
}

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x15e
// Size: 0x42
function perk_getmaxhealth()
{
    if ( isdefined( self.perk_data[ "max_health" ] ) )
    {
        return self.perk_data[ "max_health" ];
    }
    
    return self.perk_data[ "health" ].max_health;
}

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x1a8
// Size: 0x42
function perk_getbulletdamagescalar()
{
    if ( isdefined( self.perk_data[ "bullet_damage_scalar" ] ) )
    {
        return self.perk_data[ "bullet_damage_scalar" ];
    }
    
    return self.perk_data[ "impact" ].bullet_damage_scalar;
}

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x1f2
// Size: 0x42
function perk_getrevivetimescalar()
{
    if ( isdefined( self.perk_data[ "revive_time_scalar" ] ) )
    {
        return self.perk_data[ "revive_time_scalar" ];
    }
    
    return self.perk_data[ "medic" ].revive_time_scalar;
}

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x23c
// Size: 0x42
function perk_getmovespeedscalar()
{
    if ( isdefined( self.perk_data[ "move_speed_scalar" ] ) )
    {
        return self.perk_data[ "move_speed_scalar" ];
    }
    
    return self.perk_data[ "medic" ].move_speed_scalar;
}

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x286
// Size: 0x42
function perk_getrevivedamagescalar()
{
    if ( isdefined( self.perk_data[ "revive_damage_scalar" ] ) )
    {
        return self.perk_data[ "revive_damage_scalar" ];
    }
    
    return self.perk_data[ "medic" ].revive_damage_scalar;
}

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x2d0
// Size: 0x42
function perk_getexplosivedamagescalar()
{
    if ( isdefined( self.perk_data[ "explosive_damage_scalar" ] ) )
    {
        return self.perk_data[ "explosive_damage_scalar" ];
    }
    
    return self.perk_data[ "demolition" ].explosive_damage_scalar;
}

// Namespace cp_perk_utility / scripts\cp\perks\cp_perk_utility
// Params 0
// Checksum 0x0, Offset: 0x31a
// Size: 0x42
function perk_getoffhandcount()
{
    if ( isdefined( self.perk_data[ "offhand_count" ] ) )
    {
        return self.perk_data[ "offhand_count" ];
    }
    
    return self.perk_data[ "demolition" ].offhand_count;
}

