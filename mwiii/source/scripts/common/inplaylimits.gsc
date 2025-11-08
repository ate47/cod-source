#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace inplaylimits;

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x14b
// Size: 0x78
function autoexec main()
{
    level.var_b8057c65baf0784a = spawnstruct();
    level.var_b8057c65baf0784a.init = &function_a114d6863af2f149;
    level.var_b8057c65baf0784a.var_d9f305202f6f3913 = &function_784a9a0ec8d203b9;
    level callback::add( "killstreak_can_trigger", &function_3fbc4888ac56a );
    level callback::add( "killstreak_finish_use", &function_b5001bf4e9beeb3e );
    level callback::add( "killstreak_trigger_failed", &function_b5001bf4e9beeb3e );
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 0
// Checksum 0x0, Offset: 0x1cb
// Size: 0x2d0
function function_a114d6863af2f149()
{
    if ( !isdefined( level.gamemodebundle.var_671c47a45645026c ) )
    {
        return;
    }
    
    var_e4fea1d5467252b4 = getscriptbundle( level.gamemodebundle.var_671c47a45645026c );
    level.inplaylimits = { #match:{ #deployables:[] }, #teams:[], #rules:[] };
    
    foreach ( rulegroup in var_e4fea1d5467252b4.var_8fd13818a31a01ba )
    {
        foreach ( rule in rulegroup.rulelist )
        {
            assertex( !isdefined( level.inplaylimits.rules[ rule.name ] ), "<dev string:x1c>" );
            
            if ( rule.type == #"hash_4af11b8034b04aea" )
            {
                level.inplaylimits.rules[ rule.name ] = rule;
                
                if ( isdefined( rule.var_2c1ee79078c7bc2a.permatch ) && isdefined( rule.var_2c1ee79078c7bc2a.perteam ) )
                {
                    assert( rule.var_2c1ee79078c7bc2a.perteam <= rule.var_2c1ee79078c7bc2a.permatch, "<dev string:x42>" );
                }
                
                if ( isdefined( rule.var_2c1ee79078c7bc2a.permatch ) && isdefined( rule.var_2c1ee79078c7bc2a.perplayer ) )
                {
                    assert( rule.var_2c1ee79078c7bc2a.perplayer <= rule.var_2c1ee79078c7bc2a.permatch, "<dev string:x85>" );
                }
                
                if ( isdefined( rule.var_2c1ee79078c7bc2a.perteam ) && isdefined( rule.var_2c1ee79078c7bc2a.perplayer ) )
                {
                    assert( rule.var_2c1ee79078c7bc2a.perplayer <= rule.var_2c1ee79078c7bc2a.perteam, "<dev string:xca>" );
                }
                
                continue;
            }
            
            assertmsg( "<dev string:x10e>" );
        }
    }
    
    level.var_63121fffa39a5238 = 1;
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 1
// Checksum 0x0, Offset: 0x4a3
// Size: 0xa4
function function_784a9a0ec8d203b9( bundle )
{
    if ( !istrue( level.var_63121fffa39a5238 ) )
    {
        return;
    }
    
    if ( isdefined( bundle.inplaylimits ) )
    {
        foreach ( rule in bundle.inplaylimits )
        {
            assertex( isdefined( level.inplaylimits.rules[ rule.name ] ), "<dev string:x132>" );
        }
    }
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x54f
// Size: 0x91
function private function_3fbc4888ac56a( params )
{
    if ( !istrue( level.var_63121fffa39a5238 ) )
    {
        params.var_ea46784be09b48e0 = 1;
        return;
    }
    
    player = params.player;
    id = params.bundle.var_19fb085453713468;
    var_dc472c6c6f75536c = params.bundle.inplaylimits;
    params.var_ea46784be09b48e0 = function_de91481004edba65( player, id, var_dc472c6c6f75536c );
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5e8
// Size: 0x212, Type: bool
function private function_de91481004edba65( player, id, var_dc472c6c6f75536c )
{
    if ( !isdefined( var_dc472c6c6f75536c ) )
    {
        return true;
    }
    
    if ( !isdefined( player.inplaylimits ) )
    {
        player.inplaylimits = { #deployables:[] };
    }
    
    if ( !isdefined( player.inplaylimits.deployables[ id ] ) )
    {
        player.inplaylimits.deployables[ id ] = { #counts:[] };
    }
    
    if ( !isdefined( level.inplaylimits.teams[ player.team ] ) )
    {
        level.inplaylimits.teams[ player.team ] = { #deployables:[] };
    }
    
    if ( !isdefined( level.inplaylimits.teams[ player.team ].deployables[ id ] ) )
    {
        level.inplaylimits.teams[ player.team ].deployables[ id ] = { #counts:[] };
    }
    
    if ( !isdefined( level.inplaylimits.match.deployables[ id ] ) )
    {
        level.inplaylimits.match.deployables[ id ] = { #counts:[] };
    }
    
    errormsg = istrue( level.inplaylimits.rules[ var_dc472c6c6f75536c[ 0 ].name ].var_8ff5c508700ace25 ) ? "KILLSTREAKS/AIR_SPACE_TOO_CROWDED" : "KILLSTREAKS/TOO_MANY_KILLSTREAK";
    
    if ( !function_d56747948459c017( player, id, var_dc472c6c6f75536c ) )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( errormsg );
        }
        
        return false;
    }
    
    function_4b4a7fc5dbb7f51f( player, id, var_dc472c6c6f75536c );
    return true;
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x803
// Size: 0x2fc, Type: bool
function private function_d56747948459c017( player, id, var_dc472c6c6f75536c )
{
    foreach ( ruleref in var_dc472c6c6f75536c )
    {
        rule = level.inplaylimits.rules[ ruleref.name ];
        
        if ( rule.type == #"hash_4af11b8034b04aea" )
        {
            if ( !isdefined( player.inplaylimits.deployables[ id ].counts[ ruleref.name ] ) )
            {
                player.inplaylimits.deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
            }
            
            if ( !isdefined( level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ] ) )
            {
                level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
            }
            
            if ( !isdefined( level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ] ) )
            {
                level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
            }
            
            playercount = player.inplaylimits.deployables[ id ].counts[ ruleref.name ];
            teamcount = level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ];
            matchcount = level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ];
            
            if ( !function_d0a009b77b2abfeb( rule.var_2c1ee79078c7bc2a, playercount, teamcount, matchcount ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xb08
// Size: 0x2f6
function private function_4b4a7fc5dbb7f51f( player, id, var_dc472c6c6f75536c )
{
    foreach ( ruleref in var_dc472c6c6f75536c )
    {
        rule = level.inplaylimits.rules[ ruleref.name ];
        
        if ( rule.type == #"hash_4af11b8034b04aea" )
        {
            if ( !isdefined( player.inplaylimits.deployables[ id ].counts[ ruleref.name ] ) )
            {
                player.inplaylimits.deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
            }
            
            if ( !isdefined( level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ] ) )
            {
                level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
            }
            
            if ( !isdefined( level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ] ) )
            {
                level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
            }
            
            playercount = player.inplaylimits.deployables[ id ].counts[ ruleref.name ];
            teamcount = level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ];
            matchcount = level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ];
            function_82da19a6031f4815( rule.var_2c1ee79078c7bc2a, playercount, teamcount, matchcount );
        }
    }
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe06
// Size: 0x8c
function private function_b5001bf4e9beeb3e( params )
{
    if ( !istrue( level.var_63121fffa39a5238 ) )
    {
        return;
    }
    
    streakinfo = params.streakinfo;
    owner = streakinfo.owner;
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    function_f918710cd8320f22( owner, bundle.var_19fb085453713468, bundle.inplaylimits );
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xe9a
// Size: 0x30c
function private function_f918710cd8320f22( player, id, var_dc472c6c6f75536c )
{
    if ( isdefined( var_dc472c6c6f75536c ) && isdefined( player.inplaylimits ) )
    {
        foreach ( ruleref in var_dc472c6c6f75536c )
        {
            rule = level.inplaylimits.rules[ ruleref.name ];
            
            if ( rule.type == #"hash_4af11b8034b04aea" )
            {
                if ( !isdefined( player.inplaylimits.deployables[ id ].counts[ ruleref.name ] ) )
                {
                    player.inplaylimits.deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
                }
                
                if ( !isdefined( level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ] ) )
                {
                    level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
                }
                
                if ( !isdefined( level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ] ) )
                {
                    level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ] = { #count:undefined };
                }
                
                playercount = player.inplaylimits.deployables[ id ].counts[ ruleref.name ];
                teamcount = level.inplaylimits.teams[ player.team ].deployables[ id ].counts[ ruleref.name ];
                matchcount = level.inplaylimits.match.deployables[ id ].counts[ ruleref.name ];
                function_153a5eceee7d579c( rule.var_2c1ee79078c7bc2a, playercount, teamcount, matchcount );
            }
        }
    }
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x11ae
// Size: 0xd9, Type: bool
function private function_d0a009b77b2abfeb( var_2c1ee79078c7bc2a, playercount, teamcount, matchcount )
{
    if ( isdefined( var_2c1ee79078c7bc2a.perplayer ) && isdefined( playercount.count ) && playercount.count >= var_2c1ee79078c7bc2a.perplayer )
    {
        return false;
    }
    
    if ( isdefined( var_2c1ee79078c7bc2a.perteam ) && isdefined( teamcount.count ) && teamcount.count >= var_2c1ee79078c7bc2a.perteam )
    {
        return false;
    }
    
    if ( isdefined( var_2c1ee79078c7bc2a.permatch ) && isdefined( matchcount.count ) && matchcount.count >= var_2c1ee79078c7bc2a.permatch )
    {
        return false;
    }
    
    return true;
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1290
// Size: 0x109
function private function_82da19a6031f4815( var_2c1ee79078c7bc2a, playercount, teamcount, matchcount )
{
    var_590c6775f1b37399 = isdefined( playercount.count ) ? playercount.count + 1 : 1;
    var_4630a356021ae421 = isdefined( teamcount.count ) ? teamcount.count + 1 : 1;
    var_185a1d050b79f38b = isdefined( matchcount.count ) ? matchcount.count + 1 : 1;
    playercount.count = isdefined( var_2c1ee79078c7bc2a.perplayer ) ? var_590c6775f1b37399 : undefined;
    teamcount.count = isdefined( var_2c1ee79078c7bc2a.perteam ) ? var_4630a356021ae421 : undefined;
    matchcount.count = isdefined( var_2c1ee79078c7bc2a.permatch ) ? var_185a1d050b79f38b : undefined;
}

// Namespace inplaylimits / scripts\common\inplaylimits
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x13a1
// Size: 0x140
function private function_153a5eceee7d579c( var_2c1ee79078c7bc2a, playercount, teamcount, matchcount )
{
    if ( isdefined( var_2c1ee79078c7bc2a.perplayer ) )
    {
        assertex( playercount.count > 0, "<dev string:x153>" );
        playercount.count -= 1;
        
        if ( playercount.count == 0 )
        {
            playercount.count = undefined;
        }
    }
    
    if ( isdefined( var_2c1ee79078c7bc2a.perteam ) )
    {
        assertex( teamcount.count > 0, "<dev string:x196>" );
        teamcount.count -= 1;
        
        if ( teamcount.count == 0 )
        {
            teamcount.count = undefined;
        }
    }
    
    if ( isdefined( var_2c1ee79078c7bc2a.permatch ) )
    {
        assertex( matchcount.count > 0, "<dev string:x1d7>" );
        matchcount.count -= 1;
        
        if ( matchcount.count == 0 )
        {
            matchcount.count = undefined;
        }
    }
}

