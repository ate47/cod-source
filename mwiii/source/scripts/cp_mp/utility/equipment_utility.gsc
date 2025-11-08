#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;

#namespace equipment_utility;

// Namespace equipment_utility / scripts\cp_mp\utility\equipment_utility
// Params 5
// Checksum 0x0, Offset: 0xa4
// Size: 0x40
function function_cb722e58dd976a9a( weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val )
{
    function_ece21ff26dac708c( weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"int" );
}

// Namespace equipment_utility / scripts\cp_mp\utility\equipment_utility
// Params 5
// Checksum 0x0, Offset: 0xec
// Size: 0x40
function function_e3093afa85e28051( weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val )
{
    function_ece21ff26dac708c( weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"float" );
}

// Namespace equipment_utility / scripts\cp_mp\utility\equipment_utility
// Params 5
// Checksum 0x0, Offset: 0x134
// Size: 0x40
function function_d4497d44e79a8764( weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val )
{
    function_ece21ff26dac708c( weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"string" );
}

// Namespace equipment_utility / scripts\cp_mp\utility\equipment_utility
// Params 6
// Checksum 0x0, Offset: 0x17c
// Size: 0x7a
function function_ece21ff26dac708c( weapon_ref, var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, value_type )
{
    if ( !isdefined( weapon_ref ) || weapon_ref == "" )
    {
        return;
    }
    
    level.var_d66cb1858b2ba530[ weapon_ref ][ var_fd773ed7f8ab59de ] = function_97ed04e0f992484( dvar_str, bundle_val, default_val );
    
    if ( isdefined( value_type ) )
    {
        level.var_d66cb1858b2ba530[ weapon_ref ][ var_fd773ed7f8ab59de ].type = value_type;
    }
}

// Namespace equipment_utility / scripts\cp_mp\utility\equipment_utility
// Params 3
// Checksum 0x0, Offset: 0x1fe
// Size: 0x73
function function_97ed04e0f992484( dvar_str, bundle_val, default_val )
{
    var_cc2712a8519a8fd1 = spawnstruct();
    
    if ( isdefined( dvar_str ) )
    {
        var_cc2712a8519a8fd1.dvarstr = dvar_str;
    }
    
    if ( isdefined( bundle_val ) )
    {
        var_cc2712a8519a8fd1.bundle_val = bundle_val;
    }
    
    if ( isdefined( default_val ) )
    {
        var_cc2712a8519a8fd1.default_val = default_val;
    }
    else
    {
        var_cc2712a8519a8fd1.default_val = 0;
    }
    
    return var_cc2712a8519a8fd1;
}

// Namespace equipment_utility / scripts\cp_mp\utility\equipment_utility
// Params 2
// Checksum 0x0, Offset: 0x27a
// Size: 0x138
function function_74a4a69afb4bc82b( weapon_ref, var_fd773ed7f8ab59de )
{
    if ( !isdefined( level.var_d66cb1858b2ba530[ weapon_ref ] ) )
    {
        return 0;
    }
    
    var_cc2712a8519a8fd1 = level.var_d66cb1858b2ba530[ weapon_ref ][ var_fd773ed7f8ab59de ];
    
    if ( !isdefined( var_cc2712a8519a8fd1 ) )
    {
        return 0;
    }
    
    if ( isdefined( var_cc2712a8519a8fd1.bundle_val ) )
    {
        return var_cc2712a8519a8fd1.bundle_val;
    }
    
    if ( !isdefined( var_cc2712a8519a8fd1.dvarstr ) || !isdefined( var_cc2712a8519a8fd1.type ) )
    {
        return var_cc2712a8519a8fd1.default_val;
    }
    
    if ( var_cc2712a8519a8fd1.type == #"float" )
    {
        return getdvarfloat( var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val );
    }
    else if ( var_cc2712a8519a8fd1.type == #"int" )
    {
        return getdvarint( var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val );
    }
    else if ( var_cc2712a8519a8fd1.type == #"string" )
    {
        return getdvar( var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val );
    }
    
    return var_cc2712a8519a8fd1.default_val;
}

// Namespace equipment_utility / scripts\cp_mp\utility\equipment_utility
// Params 1
// Checksum 0x0, Offset: 0x3bb
// Size: 0x5e
function function_faec1a1cb92464a4( weapon_ref )
{
    bundle = undefined;
    ref = scripts\cp_mp\equipment::function_7f245729fcb6414d( weapon_ref );
    
    if ( isdefined( ref ) )
    {
        tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo( ref );
        
        if ( isdefined( tableinfo ) )
        {
            bundle = tableinfo.bundle;
        }
    }
    
    if ( !isdefined( bundle ) )
    {
        bundle = spawnstruct();
    }
    
    return bundle;
}

