#using script_6ad351ebd5a33280;
#using scripts\common\ae_utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\playerachievements;
#using scripts\engine\utility;

#namespace namespace_8774b67219227679;

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 0
// Checksum 0x0, Offset: 0xcb
// Size: 0x9
function init()
{
    function_7e0fb3d81ab13495();
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 0
// Checksum 0x0, Offset: 0xdc
// Size: 0xa5
function function_7bf95013c0b101c8()
{
    gametype = challenges::function_17c5d7feb226e256();
    
    if ( gametype == ae_utility::function_b40278e5e468c6c1( #"gametype", #"hash_283771392656c6e2" ) )
    {
        return [ 0, 1 ];
    }
    else if ( gametype == ae_utility::function_b40278e5e468c6c1( #"gametype", #"hash_731d29529dec358d" ) )
    {
        return [ 11, 1 ];
    }
    else if ( gametype == ae_utility::function_b40278e5e468c6c1( #"gametype", #"hash_f619a150a59cd8b8" ) )
    {
        return [ 12, 1 ];
    }
    
    return [ 0, 0 ];
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 0
// Checksum 0x0, Offset: 0x18a
// Size: 0x120
function function_7e0fb3d81ab13495()
{
    var_e2e97a737d97f20b = tablelookupgetnumrows( "ae/ae_personal_bests.csv" );
    
    if ( var_e2e97a737d97f20b < 1 )
    {
        return;
    }
    
    [ var_a6521f8c3fdde3ce, success ] = function_7bf95013c0b101c8();
    
    if ( !success )
    {
        return;
    }
    
    level.var_de8fabd95ccbd2f = [];
    level.var_d856da568e5992c0 = [];
    
    for ( achievementindex = 0; achievementindex < var_e2e97a737d97f20b ; achievementindex++ )
    {
        achievement_id = tablelookupbyrow( "ae/ae_personal_bests.csv", achievementindex, var_a6521f8c3fdde3ce );
        level.var_de8fabd95ccbd2f[ achievementindex ] = achievement_id;
        target_ids = [];
        
        /#
            logstring( "<dev string:x1c>" + achievement_id );
        #/
        
        for ( targetindex = 1; targetindex <= 10 ; targetindex++ )
        {
            target_id = tablelookupbyrow( "ae/ae_personal_bests.csv", achievementindex, targetindex );
            
            if ( !isdefined( target_id ) || target_id == 0 )
            {
                continue;
            }
            
            /#
                logstring( "<dev string:x5c>" + target_id );
            #/
            
            target_ids[ target_ids.size ] = target_id;
        }
        
        level.var_d856da568e5992c0[ achievement_id ] = target_ids;
    }
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 0
// Checksum 0x0, Offset: 0x2b2
// Size: 0x163
function function_c24d9aca5f9eba35()
{
    if ( !isdefined( level.var_de8fabd95ccbd2f ) )
    {
        return;
    }
    
    if ( !isdefined( level.players ) || level.players.size == 0 )
    {
        return;
    }
    
    [ var_a6521f8c3fdde3ce, success ] = function_7bf95013c0b101c8();
    
    if ( !success )
    {
        return;
    }
    
    level.var_c192bb3f79de7dbf = [];
    
    foreach ( achievement in level.var_de8fabd95ccbd2f )
    {
        function_10a17a516d1e84ed( level.players, achievement );
        
        if ( getdvarint( @"hash_5d7942ff9a328997", 0 ) == 0 )
        {
            wait 5;
        }
        
        var_ab63741a5a3bda4c = tablelookuprownum( "ae/ae_personal_bests.csv", var_a6521f8c3fdde3ce, achievement );
        
        for ( targetindex = 1; targetindex <= 10 ; targetindex++ )
        {
            target_id = tablelookupbyrow( "ae/ae_personal_bests.csv", var_ab63741a5a3bda4c, targetindex );
            
            if ( !isdefined( target_id ) || target_id == 0 )
            {
                continue;
            }
            
            var_f458b2bd84543952 = scripts\cp_mp\playerachievements::function_5cb795da8c8629cf( target_id );
            level.var_c192bb3f79de7dbf[ var_f458b2bd84543952 ] = namespace_8885c19c053dcb46::function_23e202899daef423( level.players, var_f458b2bd84543952 );
        }
    }
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 2
// Checksum 0x0, Offset: 0x41d
// Size: 0xcc
function function_4b12e9b5e37d05c2( achievementid, progressdata )
{
    if ( !isdefined( level.var_de8fabd95ccbd2f ) )
    {
        return;
    }
    
    if ( !array_contains( level.var_de8fabd95ccbd2f, achievementid ) )
    {
        return;
    }
    
    /#
        logstring( "<dev string:x97>" + self getxuid() + "<dev string:xdf>" + achievementid );
    #/
    
    /#
        foreach ( progressiondata in progressdata.progress_values )
        {
            logstring( "<dev string:xf2>" + progressiondata.progress_id + "<dev string:x133>" + progressiondata.progress );
        }
    #/
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 1
// Checksum 0x0, Offset: 0x4f1
// Size: 0x25
function function_66a24c548ba8c8ac( progressname )
{
    progressid = scripts\cp_mp\playerachievements::function_691880160b33d133( progressname );
    return function_e31138cb546a1f22( progressid );
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 1
// Checksum 0x0, Offset: 0x51f
// Size: 0xae
function function_e31138cb546a1f22( progressid )
{
    resultid = 0;
    
    if ( !isdefined( level.var_de8fabd95ccbd2f ) || !isdefined( level.var_d856da568e5992c0 ) )
    {
        return resultid;
    }
    
    foreach ( achievementid in level.var_de8fabd95ccbd2f )
    {
        if ( !isdefined( level.var_d856da568e5992c0[ achievementid ] ) )
        {
            continue;
        }
        
        if ( array_contains( level.var_d856da568e5992c0[ achievementid ], progressid ) )
        {
            resultid = achievementid;
            break;
        }
    }
    
    return resultid;
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 2
// Checksum 0x0, Offset: 0x5d6
// Size: 0x40
function function_cfab25659633eefc( player, progressname )
{
    progressid = scripts\cp_mp\playerachievements::function_691880160b33d133( progressname );
    achievementid = function_e31138cb546a1f22( progressid );
    return function_2813a0563ed5efa5( player, progressid, achievementid );
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 3
// Checksum 0x0, Offset: 0x61f
// Size: 0x44
function function_2813a0563ed5efa5( player, progressid, achievementid )
{
    resultprogress = 0;
    
    if ( !isdefined( player ) || achievementid == 0 )
    {
        return resultprogress;
    }
    
    resultprogress = scripts\cp_mp\playerachievements::function_c983c43f38eabbc( player, achievementid, progressid, resultprogress );
    return resultprogress;
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 2
// Checksum 0x0, Offset: 0x66c
// Size: 0x40
function function_23e202899daef423( players, progressname )
{
    progressid = scripts\cp_mp\playerachievements::function_691880160b33d133( progressname );
    achievementid = function_e31138cb546a1f22( progressid );
    return function_c74c0ac757347d36( players, progressid, achievementid );
}

// Namespace namespace_8774b67219227679 / namespace_8885c19c053dcb46
// Params 3
// Checksum 0x0, Offset: 0x6b5
// Size: 0xa1
function function_c74c0ac757347d36( players, progressid, achievementid )
{
    maximumresult = 0;
    
    if ( !isdefined( players ) || achievementid == 0 )
    {
        return maximumresult;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        playerbest = function_2813a0563ed5efa5( player, progressid, achievementid );
        maximumresult = max( maximumresult, playerbest );
    }
    
    return maximumresult;
}

