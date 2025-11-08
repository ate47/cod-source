#using scripts\engine\utility;

#namespace namespace_7c0e88f32463912b;

// Namespace namespace_7c0e88f32463912b / namespace_8b5a0cf52cbe3e30
// Params 0
// Checksum 0x0, Offset: 0x156
// Size: 0x33
function function_2fce2f81588a2462()
{
    if ( !isdefined( level.var_bf8aa3f39f981625 ) )
    {
        level.var_bf8aa3f39f981625 = [];
    }
    
    level.var_bf8aa3f39f981625[ level.var_bf8aa3f39f981625.size ] = &init_juggernaut_damage_states;
}

// Namespace namespace_7c0e88f32463912b / namespace_8b5a0cf52cbe3e30
// Params 0
// Checksum 0x0, Offset: 0x191
// Size: 0xcc
function init_juggernaut_damage_states()
{
    self endon( "death" );
    scripts\engine\utility::flag_wait( "scriptables_ready" );
    
    if ( !is_equal( self.model, "body_opforce_juggernaut_basebody" ) )
    {
        return;
    }
    
    if ( isdefined( level.var_1734de9810f8e785 ) )
    {
        [[ level.var_1734de9810f8e785 ]]( self );
    }
    
    create_juggernaut_damagedata( "left_arm", 100, [ "left_arm_upper", "left_arm_lower", "left_hand" ] );
    create_juggernaut_damagedata( "right_arm", 100, [ "right_arm_upper", "right_arm_lower", "right_hand" ] );
    
    if ( !isdefined( self.var_1ec812b92a31cdd3 ) )
    {
        self.var_1ec812b92a31cdd3 = [];
    }
    
    self.var_1ec812b92a31cdd3[ self.var_1ec812b92a31cdd3.size ] = &function_8b750ca7ecac8f1f;
}

// Namespace namespace_7c0e88f32463912b / namespace_8b5a0cf52cbe3e30
// Params 13, eflags: 0x4
// Checksum 0x0, Offset: 0x265
// Size: 0x7d
function private function_8b750ca7ecac8f1f( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname )
{
    apply_juggernaut_part_damage( self.damagelocation, idamage );
}

// Namespace namespace_7c0e88f32463912b / namespace_8b5a0cf52cbe3e30
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2ea
// Size: 0xd2
function private create_juggernaut_damagedata( name, health, parts )
{
    data = spawnstruct();
    data.health = health;
    data.is_part_swapped = 0;
    
    if ( !isdefined( self.damagedata ) )
    {
        self.damagedata = [];
    }
    
    self.damagedata[ name ] = data;
    
    if ( !isdefined( self.damagedatalookup ) )
    {
        self.damagedatalookup = [];
    }
    
    foreach ( part in parts )
    {
        self.damagedatalookup[ part ] = name;
    }
}

// Namespace namespace_7c0e88f32463912b / namespace_8b5a0cf52cbe3e30
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3c4
// Size: 0xa5
function private apply_juggernaut_part_damage( location, dmg )
{
    if ( !isdefined( self.damagedatalookup[ location ] ) )
    {
        return;
    }
    
    name = self.damagedatalookup[ location ];
    data = self.damagedata[ name ];
    data.health -= dmg;
    
    if ( data.health <= 0 && !istrue( data.is_part_swapped ) )
    {
        self setscriptablepartstate( name, "dmg", 1 );
        data.is_part_swapped = 1;
    }
}

