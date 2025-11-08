#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;

#namespace wander;

// Namespace wander / namespace_37deded6c75bc7e5
// Params 0
// Checksum 0x0, Offset: 0x113
// Size: 0x12
function function_eda57308516bfc5f()
{
    return function_bffb5b682a4ef6a2( &evaluatescore, &createaction );
}

// Namespace wander / namespace_37deded6c75bc7e5
// Params 1
// Checksum 0x0, Offset: 0x12e
// Size: 0x1e
function evaluatescore( bot )
{
    return self.constants.basescore;
}

// Namespace wander / namespace_37deded6c75bc7e5
// Params 1
// Checksum 0x0, Offset: 0x155
// Size: 0x27
function createaction( bot )
{
    return createactionbase( "wander", undefined, "main", "", &actionprocess, self );
}

// Namespace wander / namespace_37deded6c75bc7e5
// Params 1
// Checksum 0x0, Offset: 0x185
// Size: 0xa5
function actionprocess( bot )
{
    if ( isdefined( level.bot_funcs[ "mp_wander_select_destination" ] ) )
    {
        pointonnavmesh = bot [[ level.bot_funcs[ "mp_wander_select_destination" ] ]]();
    }
    else
    {
        pointonnavmesh = bot selectdestination();
    }
    
    if ( !isdefined( pointonnavmesh ) )
    {
        return "No destination";
    }
    
    bot setscriptgoal( pointonnavmesh, 400 );
    result = bot waittill_any_in_array_or_timeout( [ "goal", "bad_path", "long_path" ], 15 );
    
    if ( result != "goal" && result != "timeout" )
    {
        return result;
    }
}

