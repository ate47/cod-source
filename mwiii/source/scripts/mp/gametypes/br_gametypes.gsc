#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\script;

#namespace br_gametypes;

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 0
// Checksum 0x0, Offset: 0xd2
// Size: 0x97
function init()
{
    level.brgametype = spawnstruct();
    level.brgametype.funcs = [];
    level.brgametype.disabledfeatures = [];
    level.brgametype.enabledfeatures = [];
    level.brgametype.data = [];
    level.brgametype.name = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    
    if ( isdefined( level.var_cdc15ee14362fbf ) )
    {
        [[ level.var_cdc15ee14362fbf ]]();
    }
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 2
// Checksum 0x0, Offset: 0x171
// Size: 0x57
function registerbrgametypefunc( funcname, function )
{
    if ( isdefined( level.brgametype.funcs[ funcname ] ) )
    {
        scripts\mp\utility\script::demoforcesre( "registerBrGametypeFunc already has " + funcname + " defined." );
    }
    
    level.brgametype.funcs[ funcname ] = function;
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x1d0
// Size: 0x20
function function_ec416fa15d5fa6af( funcname )
{
    level.brgametype.funcs[ funcname ] = undefined;
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x1f8
// Size: 0x20
function function_ac438828015a7653( funcname )
{
    return level.brgametype.funcs[ funcname ];
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 7
// Checksum 0x0, Offset: 0x221
// Size: 0x59
function runbrgametypefunc6( funcname, param1, param2, param3, param4, param5, param6 )
{
    return [[ level.brgametype.funcs[ funcname ] ]]( param1, param2, param3, param4, param5, param6 );
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 3
// Checksum 0x0, Offset: 0x283
// Size: 0x9d
function runbrgametypefunc( funcname, param1, param2 )
{
    if ( isdefined( level.brgametype ) && isdefined( level.brgametype.funcs[ funcname ] ) )
    {
        if ( isdefined( param2 ) )
        {
            return [[ level.brgametype.funcs[ funcname ] ]]( param1, param2 );
        }
        
        if ( isdefined( param1 ) )
        {
            return [[ level.brgametype.funcs[ funcname ] ]]( param1 );
        }
        
        return [[ level.brgametype.funcs[ funcname ] ]]();
    }
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 4
// Checksum 0x0, Offset: 0x328
// Size: 0x57
function function_d72afdccedfc9b07( funcname, param1, param2, param3 )
{
    if ( isdefined( level.brgametype.funcs[ funcname ] ) )
    {
        return [[ level.brgametype.funcs[ funcname ] ]]( param1, param2, param3 );
    }
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 5
// Checksum 0x0, Offset: 0x387
// Size: 0x60
function function_d72afaccedfc946e( funcname, param1, param2, param3, param4 )
{
    if ( isdefined( level.brgametype.funcs[ funcname ] ) )
    {
        return [[ level.brgametype.funcs[ funcname ] ]]( param1, param2, param3, param4 );
    }
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 8
// Checksum 0x0, Offset: 0x3ef
// Size: 0x7e
function function_d72af9ccedfc923b( funcname, param1, param2, param3, param4, param5, param6, param7 )
{
    if ( isdefined( level.brgametype.funcs[ funcname ] ) )
    {
        return [[ level.brgametype.funcs[ funcname ] ]]( param1, param2, param3, param4, param5, param6, param7 );
    }
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x475
// Size: 0x2f, Type: bool
function isbrgametypefuncdefined( funcname )
{
    return isdefined( level.brgametype ) && isdefined( level.brgametype.funcs[ funcname ] );
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x4ad
// Size: 0x23
function disablefeature( featurename )
{
    level.brgametype.disabledfeatures[ featurename ] = 1;
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x4d8
// Size: 0x30, Type: bool
function isfeaturedisabled( featurename )
{
    return !isdefined( level.brgametype ) || istrue( level.brgametype.disabledfeatures[ featurename ] );
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x511
// Size: 0x23
function enablefeature( featurename )
{
    level.brgametype.enabledfeatures[ featurename ] = 1;
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x53c
// Size: 0x2f, Type: bool
function isfeatureenabled( featurename )
{
    return isdefined( level.brgametype ) && istrue( level.brgametype.enabledfeatures[ featurename ] );
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 2
// Checksum 0x0, Offset: 0x574
// Size: 0x2a
function registerbrgametypedata( dataref, data )
{
    level.brgametype.data[ dataref ] = data;
}

// Namespace br_gametypes / scripts\mp\gametypes\br_gametypes
// Params 1
// Checksum 0x0, Offset: 0x5a6
// Size: 0x20
function getbrgametypedata( dataref )
{
    return level.brgametype.data[ dataref ];
}

