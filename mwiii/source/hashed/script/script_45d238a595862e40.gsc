#namespace namespace_68d062fad885eeb3;

// Namespace namespace_68d062fad885eeb3 / namespace_689de5b2bc60d21a
// Params 0
// Checksum 0x0, Offset: 0x127
// Size: 0x33
function function_2fce2f81588a2462()
{
    if ( !isdefined( level.var_bf8aa3f39f981625 ) )
    {
        level.var_bf8aa3f39f981625 = [];
    }
    
    level.var_bf8aa3f39f981625[ level.var_bf8aa3f39f981625.size ] = &function_56bc2530b5374d3e;
}

// Namespace namespace_68d062fad885eeb3 / namespace_689de5b2bc60d21a
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0x3e
function function_56bc2530b5374d3e()
{
    assert( isai( self ) );
    assert( isdefined( self.damage_functions ) );
    self.damage_functions[ self.damage_functions.size ] = &function_4142a252055b545a;
}

// Namespace namespace_68d062fad885eeb3 / namespace_689de5b2bc60d21a
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0x1a8
// Size: 0xec
function private function_4142a252055b545a( damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( juggernaut_isspecialweapon() )
    {
        return;
    }
    
    if ( self.damageweapon.basename == "iw8_pi_decho" )
    {
        if ( partname == "j_head" || partname == "j_neck" || partname == "j_helmet" )
        {
            heal_amount = 70;
        }
        else
        {
            heal_amount = 40;
        }
    }
    else
    {
        heal_amount = 40;
    }
    
    if ( damage < heal_amount )
    {
        heal_amount = max( 0, damage - 5 );
    }
    
    self.health += int( heal_amount );
}

// Namespace namespace_68d062fad885eeb3 / namespace_689de5b2bc60d21a
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x29c
// Size: 0xb4, Type: bool
function private juggernaut_isspecialweapon()
{
    return self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE_SPLASH" || self.damagemod == "MOD_PROJECTILE_SPLASH" || self.damageweapon.classname == "sniper" || self.damageweapon.classname == "pistol" && self.damageweapon.basename != "iw8_pi_decho" && self.damagemod != "MOD_MELEE";
}

