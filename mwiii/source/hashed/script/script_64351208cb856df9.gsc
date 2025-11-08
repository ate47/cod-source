#using script_41387eecc35b88bf;
#using script_7956d56c4922bd1;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_eabc780d2f9ee9d2;

// Namespace namespace_eabc780d2f9ee9d2 / namespace_279f1071df8a38d7
// Params 0
// Checksum 0x0, Offset: 0xa8
// Size: 0x1b
function function_c6bad126e3d76334()
{
    activitydefinition = function_4188e118731a30f4();
    return function_8cc76eec073ffbe5( activitydefinition );
}

// Namespace namespace_eabc780d2f9ee9d2 / namespace_279f1071df8a38d7
// Params 1
// Checksum 0x0, Offset: 0xcc
// Size: 0x31
function function_8cc76eec073ffbe5( activitydefinition )
{
    var_2ac3a103e9dc3bc4 = function_2304002f798c8e72( activitydefinition );
    return default_to( var_2ac3a103e9dc3bc4.var_2e25eac69030917a, 1 );
}

// Namespace namespace_eabc780d2f9ee9d2 / namespace_279f1071df8a38d7
// Params 0
// Checksum 0x0, Offset: 0x106
// Size: 0x1b
function function_7224bb7d017a588a()
{
    activitydefinition = function_4188e118731a30f4();
    return function_c35152446b8719a7( activitydefinition );
}

// Namespace namespace_eabc780d2f9ee9d2 / namespace_279f1071df8a38d7
// Params 1
// Checksum 0x0, Offset: 0x12a
// Size: 0x31
function function_c35152446b8719a7( activitydefinition )
{
    var_2ac3a103e9dc3bc4 = function_2304002f798c8e72( activitydefinition );
    return default_to( var_2ac3a103e9dc3bc4.var_91117353b68035f8, 1 );
}

// Namespace namespace_eabc780d2f9ee9d2 / namespace_279f1071df8a38d7
// Params 0
// Checksum 0x0, Offset: 0x164
// Size: 0x1b
function function_6787cd2004f976e2()
{
    activitydefinition = function_4188e118731a30f4();
    return function_c674a361b3768cf3( activitydefinition );
}

// Namespace namespace_eabc780d2f9ee9d2 / namespace_279f1071df8a38d7
// Params 1
// Checksum 0x0, Offset: 0x188
// Size: 0xb2
function function_c674a361b3768cf3( activitydefinition )
{
    var_2ac3a103e9dc3bc4 = function_2304002f798c8e72( activitydefinition );
    var_35d3425cf6c2d4a7 = [];
    
    if ( isdefined( var_2ac3a103e9dc3bc4.var_5a446eb1e25a8405 ) )
    {
        foreach ( var_5ce59734270d5894 in var_2ac3a103e9dc3bc4.var_5a446eb1e25a8405 )
        {
            var_6cd7ebc66ad6f7ce = function_4766b60677a139fd( var_5ce59734270d5894 );
            var_35d3425cf6c2d4a7[ var_35d3425cf6c2d4a7.size ] = var_6cd7ebc66ad6f7ce;
        }
    }
    
    /#
        if ( var_35d3425cf6c2d4a7.size == 0 )
        {
            iprintln( "<dev string:x1c>" );
        }
    #/
    
    return var_35d3425cf6c2d4a7;
}

// Namespace namespace_eabc780d2f9ee9d2 / namespace_279f1071df8a38d7
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x243
// Size: 0x29
function private function_2304002f798c8e72( activitydefinition )
{
    var_2ba0388e609d891e = function_33e6a5615b0d3148( activitydefinition );
    return var_2ba0388e609d891e.var_5de130ac10732635;
}

