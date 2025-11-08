#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;

#namespace namespace_40cd4a4db2010f22;

// Namespace namespace_40cd4a4db2010f22 / namespace_a850435086c88de3
// Params 3
// Checksum 0x0, Offset: 0x10a
// Size: 0x140
function doonactionscoreevent( eventtype, eventname, cooldown )
{
    if ( getdvarint( hashcat( @"scr_", scripts\mp\utility\game::getsubgametype(), "_disable_onactionscoreevents" ), 0 ) == 1 )
    {
        return;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "br" && !isdefined( level.prematchendtime ) )
    {
        return;
    }
    
    if ( !isdefined( cooldown ) )
    {
        cooldown = 12;
    }
    
    cooldownms = cooldown * 1000;
    var_b7d39a4661f3460 = gettime();
    
    if ( !isdefined( self.xpcooldowns ) )
    {
        self.xpcooldowns = [];
    }
    
    if ( !isdefined( self.xpcooldowns[ eventname ] ) )
    {
        self.xpcooldowns[ eventname ] = 0;
    }
    else if ( self.xpcooldowns[ eventname ] > var_b7d39a4661f3460 )
    {
        return;
    }
    
    self.xpcooldowns[ eventname ] = var_b7d39a4661f3460 + cooldownms;
    
    switch ( eventtype )
    {
        case 0:
            function_a56759f3dec70990( eventname );
            break;
        case 1:
            function_e4278547ad0ee8c8( eventname );
            break;
        case 2:
            function_d25feb1da4499bae( eventname );
            break;
        default:
            break;
    }
}

// Namespace namespace_40cd4a4db2010f22 / namespace_a850435086c88de3
// Params 1
// Checksum 0x0, Offset: 0x252
// Size: 0x2b
function function_a56759f3dec70990( eventname )
{
    var_c7cba7d0db108110 = getxhash( "altScore_equipment_" + eventname );
    function_558e5516ee7925aa( var_c7cba7d0db108110 );
}

// Namespace namespace_40cd4a4db2010f22 / namespace_a850435086c88de3
// Params 1
// Checksum 0x0, Offset: 0x285
// Size: 0x2b
function function_e4278547ad0ee8c8( eventname )
{
    var_c7cba7d0db108110 = getxhash( "altScore_fieldUp_" + eventname );
    function_558e5516ee7925aa( var_c7cba7d0db108110 );
}

// Namespace namespace_40cd4a4db2010f22 / namespace_a850435086c88de3
// Params 1
// Checksum 0x0, Offset: 0x2b8
// Size: 0x2b
function function_d25feb1da4499bae( eventname )
{
    var_c7cba7d0db108110 = getxhash( "altScore_killstreak_" + eventname );
    function_558e5516ee7925aa( var_c7cba7d0db108110 );
}

// Namespace namespace_40cd4a4db2010f22 / namespace_a850435086c88de3
// Params 1
// Checksum 0x0, Offset: 0x2eb
// Size: 0x38
function function_558e5516ee7925aa( var_c7cba7d0db108110 )
{
    points = scripts\mp\rank::getscoreinfovalue( var_c7cba7d0db108110 );
    
    if ( isdefined( points ) )
    {
        thread scripts\mp\utility\points::doscoreevent( var_c7cba7d0db108110, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    }
}

