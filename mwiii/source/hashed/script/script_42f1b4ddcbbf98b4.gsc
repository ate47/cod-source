#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_41387eecc35b88bf;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_7956d56c4922bd1;
#using scripts\common\utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;

#namespace namespace_8761bd55318677aa;

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 1
// Checksum 0x0, Offset: 0x147
// Size: 0x22b
function function_a7dc4a67100b768c( relevantparameters )
{
    assertex( relevantparameters.size > 0 && isactivityinstance( relevantparameters[ 0 ] ), "<dev string:x1c>" );
    activityinstance = relevantparameters[ 0 ];
    additionalspawndatastruct = function_4481ee309bf2c75c( activityinstance );
    
    if ( istrue( additionalspawndatastruct.var_7273458500a1706 ) )
    {
        activitytype = getactivitytype( activityinstance );
        
        if ( activitytype == "REV_OB_BIGBOUNTY" )
        {
            var_6608bafe66c4007b = [];
            player = additionalspawndatastruct.var_b20fac6bac1d6fde;
            customproperties = function_b9c4aa88ad97ee68( activityinstance );
            
            if ( isdefined( player ) && isdefined( customproperties ) && isdefined( customproperties.var_9a430cc35610a8ae ) )
            {
                varianttag = function_a4748b32a824c79c( activityinstance );
                variantscriptstructs = getstructarray( varianttag, "script_noteworthy" );
                payload = [ #"teamselect", player getentitynumber() ];
                a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
                
                foreach ( scriptstruct in variantscriptstructs )
                {
                    if ( scriptstruct.targetname == "activity_nexus_instance_joiner" )
                    {
                        joininteractscriptable = spawnscriptable( customproperties.var_9a430cc35610a8ae, scriptstruct.origin, scriptstruct.angles, undefined, payload );
                        var_6608bafe66c4007b[ var_6608bafe66c4007b.size ] = joininteractscriptable;
                        namespace_68dc261109a9503f::function_62b3e2a4e6e15396( activityinstance, joininteractscriptable, 1 );
                        
                        foreach ( unknown_player in level.players )
                        {
                            if ( !array_contains( a_squad, unknown_player ) )
                            {
                                joininteractscriptable disablescriptableplayeruse( unknown_player );
                            }
                        }
                    }
                }
                
                return var_6608bafe66c4007b;
            }
        }
    }
    
    return namespace_d886885225a713a7::function_7945819e2d7fc956( relevantparameters );
}

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 1
// Checksum 0x0, Offset: 0x37b
// Size: 0x32
function function_f805f042fa2f4b2( var_7273458500a1706 )
{
    var_eb0d08149de48f60 = function_ccb42947700f2741();
    var_eb0d08149de48f60.var_7273458500a1706 = default_to( var_7273458500a1706, 0 );
    return var_eb0d08149de48f60;
}

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 2
// Checksum 0x0, Offset: 0x3b6
// Size: 0x39, Type: bool
function function_6e345470b71653a4( activityinstance, params )
{
    assertex( !isdefined( params ) || params.size != 0, "<dev string:x87>" );
    return getactivitycategory( activityinstance ) == "Objective";
}

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 2
// Checksum 0x0, Offset: 0x3f8
// Size: 0x39, Type: bool
function function_a74910a9002633d0( activityinstance, params )
{
    assertex( !isdefined( params ) || params.size != 0, "<dev string:x87>" );
    return getactivitycategory( activityinstance ) == "Activity";
}

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 2
// Checksum 0x0, Offset: 0x43a
// Size: 0x44, Type: bool
function function_c37214cf3d029093( activityinstance, params )
{
    assertex( !isdefined( params ) || params.size != 0, "<dev string:x87>" );
    activity_type = params[ 0 ];
    return getactivitytype( activityinstance ) != activity_type;
}

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 2
// Checksum 0x0, Offset: 0x487
// Size: 0x39, Type: bool
function function_1de0e40ac4e9356f( activityinstance, params )
{
    assertex( !isdefined( params ) || params.size != 0, "<dev string:x87>" );
    return getactivitycategory( activityinstance ) == "Contract";
}

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 2
// Checksum 0x0, Offset: 0x4c9
// Size: 0x70, Type: bool
function function_4a1651413519d392( activityinstance, params )
{
    assertex( params.size == 2 && isdefined( params[ 0 ] ), "<dev string:x12e>" );
    origin_point = params[ 0 ];
    min_distance = params[ 1 ];
    activityorigin = namespace_68dc261109a9503f::function_8988a4c89289d7f4( activityinstance );
    actual_distance = distance( origin_point, activityorigin );
    return actual_distance >= min_distance;
}

// Namespace namespace_8761bd55318677aa / namespace_27def95c6086c32a
// Params 2
// Checksum 0x0, Offset: 0x542
// Size: 0x80, Type: bool
function function_133d3f81f9f3ab58( activityinstance, params )
{
    assertex( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x17d>" );
    point = params[ 0 ];
    region = namespace_4df2ab39b0e96ec7::get_region( point );
    activityorigin = namespace_68dc261109a9503f::function_8988a4c89289d7f4( activityinstance );
    activityregion = namespace_4df2ab39b0e96ec7::get_region( activityorigin );
    
    if ( isdefined( region ) && isdefined( activityregion ) )
    {
        return ( region == activityregion );
    }
    
    return false;
}

