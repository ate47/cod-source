#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace thermal_phone;

// Namespace thermal_phone / scripts\cp_mp\equipment\thermal_phone
// Params 0
// Checksum 0x0, Offset: 0x108
// Size: 0x2
function function_7c59b9d44aff939b()
{
    
}

// Namespace thermal_phone / scripts\cp_mp\equipment\thermal_phone
// Params 3
// Checksum 0x0, Offset: 0x112
// Size: 0x23
function function_d7b50d4592cd5421( equipmentref, equipmentslot, variantid )
{
    thread function_d985ced7c32c7258();
}

// Namespace thermal_phone / scripts\cp_mp\equipment\thermal_phone
// Params 0
// Checksum 0x0, Offset: 0x13d
// Size: 0x70
function function_d985ced7c32c7258()
{
    self endon( "death_or_disconnect" );
    self endon( "thermal_phone_taken" );
    
    while ( true )
    {
        self waittill( "grenade_pullback", objweapon );
        
        if ( isdefined( objweapon ) && isdefined( objweapon.basename ) && objweapon.basename == "thermal_phone_mp" )
        {
            if ( isdefined( level.var_668566d171e33358 ) )
            {
                [[ level.var_668566d171e33358 ]]( self );
            }
        }
    }
}

// Namespace thermal_phone / scripts\cp_mp\equipment\thermal_phone
// Params 2
// Checksum 0x0, Offset: 0x1b5
// Size: 0x1b
function function_e49fa2736f79e04b( equipmentref, equipmentslot )
{
    self notify( "thermal_phone_taken" );
}

// Namespace thermal_phone / scripts\cp_mp\equipment\thermal_phone
// Params 1
// Checksum 0x0, Offset: 0x1d8
// Size: 0x39
function function_230403b8cf5ea1e8( grenade )
{
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    if ( isdefined( level.var_5a712c9d76830012 ) )
    {
        [[ level.var_5a712c9d76830012 ]]( self );
    }
    
    self notify( "thermal_phone_finished" );
}

