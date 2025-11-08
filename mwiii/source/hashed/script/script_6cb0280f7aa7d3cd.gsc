#namespace namespace_33a47cc54fbe0ab9;

// Namespace namespace_33a47cc54fbe0ab9 / namespace_fd8ff6a1c9b4f3c7
// Params 14
// Checksum 0x0, Offset: 0x87
// Size: 0xf3
function function_d1e4826b0a4db6ee( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname )
{
    if ( !isdefined( level.var_808c7a20e8c01b63 ) )
    {
        level.var_808c7a20e8c01b63 = [];
    }
    
    foreach ( callback in level.var_808c7a20e8c01b63 )
    {
        [[ callback ]]( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
    }
}

// Namespace namespace_33a47cc54fbe0ab9 / namespace_fd8ff6a1c9b4f3c7
// Params 1
// Checksum 0x0, Offset: 0x182
// Size: 0x38
function registerpostplayerdamagecallback( callback )
{
    if ( !isdefined( level.var_808c7a20e8c01b63 ) )
    {
        level.var_808c7a20e8c01b63 = [];
    }
    
    level.var_808c7a20e8c01b63[ level.var_808c7a20e8c01b63.size ] = callback;
}

