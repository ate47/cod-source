#using script_5a4a5d9ba343ff8f;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\engine\utility;

#namespace effect_slow;

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 6
// Checksum 0x0, Offset: 0xb0
// Size: 0x117
function slow( var_3f84102752151e7c, var_561c4006f65fb505, n_durations, var_d4739501723a457c, endcallback, var_9142743ed938c8bb )
{
    assertex( isstring( var_3f84102752151e7c ), "<dev string:x1c>" );
    assertex( isnumber( var_561c4006f65fb505 ), "<dev string:x40>" );
    assertex( isnumber( n_durations ), "<dev string:x62>" );
    
    if ( !istrue( var_9142743ed938c8bb ) )
    {
        if ( !isdefined( self.aisettings ) || !istrue( self.aisettings.var_c9cbc4a3332e44c6 ) )
        {
            return 0;
        }
    }
    
    if ( scripts\asm\asm_bb::bb_isanimscripted() )
    {
        return 0;
    }
    
    if ( !function_8ce7894f1a52fb77( "slow" ) )
    {
        self.cachedplaybackrate = scripts\asm\asm::asm_getmoveplaybackrate();
    }
    
    effect = function_108973a907c11ca7( "slow", n_durations, var_3f84102752151e7c, &start_slow, &end_slow );
    effect.var_d4739501723a457c = var_d4739501723a457c;
    effect.rate = var_561c4006f65fb505;
    effect.end_callback = endcallback;
    return start_effect( effect );
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1d0
// Size: 0xe0
function private start_slow( effect )
{
    n_time = gettime();
    var_3eab2eda9e5ce31 = undefined;
    var_9751e67c93627448 = undefined;
    
    foreach ( effect in self.status_effects[ "slow" ] )
    {
        if ( !isdefined( var_9751e67c93627448 ) || effect.rate < var_9751e67c93627448.rate )
        {
            var_9751e67c93627448 = effect;
        }
        
        if ( !isdefined( var_3eab2eda9e5ce31 ) || effect.end_time < var_3eab2eda9e5ce31 )
        {
            var_3eab2eda9e5ce31 = effect.end_time;
        }
    }
    
    if ( isdefined( var_9751e67c93627448 ) && n_time < var_3eab2eda9e5ce31 )
    {
        function_3d9c0570527484dd( var_9751e67c93627448.rate );
    }
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2b8
// Size: 0x109
function private end_slow( effect )
{
    current_time = gettime();
    return_rate = default_to( self.cachedplaybackrate, 1 );
    
    foreach ( active_effect in self.status_effects[ "slow" ] )
    {
        if ( isdefined( active_effect.unique_id ) && effect.unique_id == active_effect.unique_id )
        {
            return;
        }
        
        if ( active_effect.rate < return_rate && active_effect.end_time > current_time )
        {
            return_rate = active_effect.rate;
        }
    }
    
    function_3d9c0570527484dd( return_rate );
    
    if ( isdefined( effect.end_callback ) )
    {
        self [[ effect.end_callback ]]();
    }
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3c9
// Size: 0x5f
function private function_3d9c0570527484dd( var_41e050c00dbd88ee )
{
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( scripts\asm\asm::function_4bb232c0fca955f6() == var_41e050c00dbd88ee )
    {
        return;
    }
    
    scripts\asm\asm::function_8d1655ae223d862a( var_41e050c00dbd88ee );
    
    if ( !istrue( self.is_traversing ) && !istrue( self.is_dying ) && gettime() > self.birthtime )
    {
        function_6e9cb6cd0535fe65();
    }
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 1
// Checksum 0x0, Offset: 0x430
// Size: 0x9f
function stop_slow( var_3f84102752151e7c )
{
    assertex( isstring( var_3f84102752151e7c ), "<dev string:x1c>" );
    
    foreach ( active_effect in self.status_effects[ "slow" ] )
    {
        if ( isdefined( active_effect.unique_id ) && var_3f84102752151e7c == active_effect.unique_id )
        {
            active_effect.end_time = -1;
        }
    }
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 0
// Checksum 0x0, Offset: 0x4d7
// Size: 0x62
function function_778c51b997394ed8()
{
    foreach ( active_effect in self.status_effects[ "slow" ] )
    {
        active_effect.end_time = -1;
    }
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 0
// Checksum 0x0, Offset: 0x541
// Size: 0xd
function is_slowed()
{
    return function_8ce7894f1a52fb77( "slow" );
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 1
// Checksum 0x0, Offset: 0x557
// Size: 0xa5, Type: bool
function has_slow( var_3f84102752151e7c )
{
    assertex( isstring( var_3f84102752151e7c ), "<dev string:x1c>" );
    
    if ( !function_8ce7894f1a52fb77( "slow" ) )
    {
        return false;
    }
    
    foreach ( active_effect in self.status_effects[ "slow" ] )
    {
        if ( isdefined( active_effect.unique_id ) && var_3f84102752151e7c == active_effect.unique_id )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace effect_slow / namespace_5e5b12854e72824d
// Params 2
// Checksum 0x0, Offset: 0x605
// Size: 0xd8, Type: bool
function function_47062c0baf4e14bf( player, var_3f84102752151e7c )
{
    assertex( isstring( var_3f84102752151e7c ), "<dev string:x1c>" );
    
    if ( !function_8ce7894f1a52fb77( "slow" ) )
    {
        return false;
    }
    
    foreach ( active_effect in self.status_effects[ "slow" ] )
    {
        if ( isdefined( active_effect.unique_id ) && var_3f84102752151e7c == active_effect.unique_id && isdefined( player ) && isdefined( self.var_d76f87abeca1eaa3[ var_3f84102752151e7c ].var_d4739501723a457c ) )
        {
            return ( active_effect.var_d4739501723a457c == player );
        }
    }
    
    return false;
}

