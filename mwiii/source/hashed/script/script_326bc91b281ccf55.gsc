#using script_27fdece778e999d8;
#using script_59ff79d681bb860c;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;

#namespace namespace_22333af54656799d;

// Namespace namespace_22333af54656799d / namespace_dca425635eaa5c15
// Params 0
// Checksum 0x0, Offset: 0xea
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_brtdm();
}

/#

    // Namespace namespace_22333af54656799d / namespace_dca425635eaa5c15
    // Params 0
    // Checksum 0x0, Offset: 0x102
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace namespace_22333af54656799d / namespace_dca425635eaa5c15
// Params 0
// Checksum 0x0, Offset: 0x10f
// Size: 0x1e
function setup_callbacks()
{
    initialize();
    level.bot_funcs[ "mp_wander_select_destination" ] = &function_90aa80a0d854dd5d;
}

// Namespace namespace_22333af54656799d / namespace_dca425635eaa5c15
// Params 0
// Checksum 0x0, Offset: 0x135
// Size: 0xf6
function setup_bot_brtdm()
{
    allieshq = level.brtdm_config.spawnorigin[ "allies" ];
    axishq = level.brtdm_config.spawnorigin[ "axis" ];
    level.var_24991391ba4dcb18 = vectornormalize2( allieshq - axishq );
    level.var_3d6c69ce45dea7d7 = ( allieshq - axishq ) * 0.5 + axishq;
    level.var_32e9fb0b5827e025 = vectornormalize2( level.brtdm_config.circlecenter - level.var_3d6c69ce45dea7d7 );
    level.var_8d51410017e80cd1 = ( level.brtdm_config.circleradius - distance2d( level.brtdm_config.circlecenter, level.var_3d6c69ce45dea7d7 ) ) * 0.8;
    level.var_3fa58ccdbda67f38 = level.var_8d51410017e80cd1 * 0.2;
}

// Namespace namespace_22333af54656799d / namespace_dca425635eaa5c15
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0x91
function function_90aa80a0d854dd5d()
{
    randompoint = level.var_3d6c69ce45dea7d7 + ( randomfloat( 2 ) - 1 ) * level.var_8d51410017e80cd1 * level.var_32e9fb0b5827e025 + ( randomfloat( 2 ) - 1 ) * level.var_3fa58ccdbda67f38 * level.var_24991391ba4dcb18;
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    randompoint = scripts\engine\utility::drop_to_ground( ( randompoint[ 0 ], randompoint[ 1 ], 4000 ), undefined, undefined, undefined, contents );
    randompoint = function_207ba502560fa1d2( randompoint );
    return randompoint;
}

