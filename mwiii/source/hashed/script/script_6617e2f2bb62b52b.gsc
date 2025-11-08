#using scripts\common\conditional_container;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;

#namespace player_broadcasting;

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0xa8
// Size: 0x31
function function_70b0f5c75f974eff()
{
    if ( !isdefined( level.var_19f9544004bec048 ) )
    {
        level.var_19f9544004bec048 = [];
    }
    
    /#
        level.var_19f9544004bec048[ "<dev string:x1c>" ] = &function_28d42a2b1f0b3eab;
    #/
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0xe1
// Size: 0x37
function function_f18abd71e34586a2( broadcasttype, handofffunction )
{
    if ( !isdefined( level.var_19f9544004bec048 ) )
    {
        level.var_19f9544004bec048 = [];
    }
    
    level.var_19f9544004bec048[ broadcasttype ] = handofffunction;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0x120
// Size: 0xcc
function broadcasttoplayer( player, broadcastinstance )
{
    var_91b2a18054e979ae = function_365e789cf7ee1a2f( player, broadcastinstance );
    
    if ( !var_91b2a18054e979ae )
    {
        var_2bf0f676fdb4d9d9 = spawnstruct();
        var_2bf0f676fdb4d9d9.player = player;
        var_2bf0f676fdb4d9d9.broadcastinstance = broadcastinstance;
        var_15309dae6e19a117 = broadcastinstance function_9ece756d9ac04e6d();
        
        if ( isdefined( var_15309dae6e19a117 ) && var_15309dae6e19a117 > 0 )
        {
            function_21987527fd4733ad( broadcastinstance, player, &function_c5de94ea3ad8f2e6, var_2bf0f676fdb4d9d9, var_15309dae6e19a117 );
        }
        else
        {
            var_108eadcfc61719c = function_93587d5ba6247f36( broadcastinstance, player );
            
            if ( var_108eadcfc61719c )
            {
                function_c5de94ea3ad8f2e6( var_2bf0f676fdb4d9d9 );
            }
            else
            {
                /#
                    function_747e8968c9de65cd( player, broadcastinstance, 0, "<dev string:x25>" );
                #/
            }
        }
        
        return;
    }
    
    /#
        function_747e8968c9de65cd( player, broadcastinstance, 0, "<dev string:x67>" );
    #/
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0x1f4
// Size: 0x60
function broadcasttoplayers( playerlist, broadcastinstance )
{
    foreach ( player in playerlist )
    {
        broadcasttoplayer( player, broadcastinstance );
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0x25c
// Size: 0x60
function function_724d89e705c4c011( player, broadcastinstancearray )
{
    foreach ( broadcastinstance in broadcastinstancearray )
    {
        broadcasttoplayer( player, broadcastinstance );
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x2c4
// Size: 0x6d
function updatebroadcast( broadcastinstance )
{
    foreach ( player in level.players )
    {
        if ( function_365e789cf7ee1a2f( player, broadcastinstance ) )
        {
            function_bb9bc4c538a84c97( player, broadcastinstance, 1 );
        }
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x339
// Size: 0x57
function updatebroadcastarray( broadcastinstancearray )
{
    foreach ( broadcastinstance in broadcastinstancearray )
    {
        updatebroadcast( broadcastinstance );
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0x398
// Size: 0x46
function function_8b7e04a0cc14a82e( player, broadcastinstance )
{
    if ( !function_365e789cf7ee1a2f( player, broadcastinstance ) )
    {
        /#
            function_747e8968c9de65cd( player, broadcastinstance, 2, "<dev string:x92>" );
        #/
        
        return;
    }
    
    function_d1b2e5b614aa5495( player, broadcastinstance );
    function_bb9bc4c538a84c97( player, broadcastinstance, 2 );
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0x3e6
// Size: 0x60
function function_dc1c1d2f6e9de57d( player, broadcastinstancearray )
{
    foreach ( broadcastinstance in broadcastinstancearray )
    {
        function_8b7e04a0cc14a82e( player, broadcastinstance );
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x44e
// Size: 0x6d
function function_13fbc3d3854d009a( broadcastinstance )
{
    foreach ( player in level.players )
    {
        if ( function_365e789cf7ee1a2f( player, broadcastinstance ) )
        {
            function_bb9bc4c538a84c97( player, broadcastinstance, 2 );
        }
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0x4c3
// Size: 0x60
function function_dacc8aa0d16e4487( playerlist, broadcastinstance )
{
    foreach ( player in playerlist )
    {
        function_8b7e04a0cc14a82e( player, broadcastinstance );
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2
// Checksum 0x0, Offset: 0x52b
// Size: 0x72
function function_790e679b0f2d121e( var_9c34764b7d5ac247, broadcastinstance )
{
    var_23d6245ff51f1599 = scripts\mp\utility\teams::function_5b7802e04b6d946( var_9c34764b7d5ac247 );
    
    if ( istrue( var_23d6245ff51f1599 ) )
    {
        squad = getsquadmates( var_9c34764b7d5ac247.team, var_9c34764b7d5ac247.sessionsquadid, 0 );
        broadcasttoplayers( squad, broadcastinstance );
        return;
    }
    
    if ( !function_365e789cf7ee1a2f( var_9c34764b7d5ac247, broadcastinstance ) )
    {
        broadcasttoplayer( var_9c34764b7d5ac247, broadcastinstance );
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x5a5
// Size: 0x1c
function function_9bce3b7a2f2ae1e( broadcastinstance )
{
    broadcasttoplayers( level.players, broadcastinstance );
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 3
// Checksum 0x0, Offset: 0x5c9
// Size: 0x7c
function function_9d73d2cd3341c8e1( broadcastorigin, maxdistancefromorigin, broadcastinstance )
{
    foreach ( player in level.players )
    {
        if ( utility::playerwithindistance( player, broadcastorigin, maxdistancefromorigin ) )
        {
            broadcasttoplayer( player, broadcastinstance );
        }
    }
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x64d
// Size: 0xcc
function function_3186d88f9311acf4( broadcasttype )
{
    broadcastinstance = spawnstruct();
    broadcastinstance.var_57214832d7aad3b6 = 0;
    broadcastinstance.broadcasttype = broadcasttype;
    broadcastinstance.broadcastdataobjects = [];
    broadcastinstance.associateddatatracker = undefined;
    broadcastinstance.var_c6167efbc0cc9a86 = 1;
    broadcastinstance.var_8e09c79789611261 = 0;
    
    if ( !isdefined( level.broadcastuniqueid ) )
    {
        level.broadcastuniqueid = 0;
    }
    
    broadcastinstance.uniqueid = level.broadcastuniqueid;
    broadcastinstance.groupid = broadcastinstance.uniqueid;
    level.broadcastuniqueid++;
    broadcastinstance.var_f16900d47079d51f = [];
    broadcastinstance function_a1f71337a6844055();
    return broadcastinstance;
}

/#

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 1
    // Checksum 0x0, Offset: 0x722
    // Size: 0x34, Type: dev
    function function_ab07dddb2e50773b( messagetext )
    {
        broadcastinstance = function_3186d88f9311acf4( "<dev string:x1c>" );
        broadcastinstance.text = messagetext;
        return broadcastinstance;
    }

#/

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x75e
// Size: 0x17, Type: bool
function function_9cf7afd6797ae365( broadcastinstance )
{
    return istrue( broadcastinstance.var_c6167efbc0cc9a86 );
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0x77e
// Size: 0xc, Type: bool
function function_be70a75a57d524fe()
{
    return istrue( self.var_57214832d7aad3b6 );
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0x793
// Size: 0xb
function function_7437a8d48556e45e()
{
    return self.broadcastdataobjects;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0x7a7
// Size: 0x23
function getbroadcasttype()
{
    assertex( isdefined( self.broadcasttype ), "<dev string:xe4>" );
    return self.broadcasttype;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0x7d3
// Size: 0xb
function getbroadcastuniqueid()
{
    return self.uniqueid;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0x7e7
// Size: 0xb
function function_178a0ef658e52420()
{
    return self.groupid;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0x7fb
// Size: 0xb
function function_9ece756d9ac04e6d()
{
    return self.var_8e09c79789611261;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 0
// Checksum 0x0, Offset: 0x80f
// Size: 0xb
function function_8362248b8fb9637f()
{
    return self.associateddatatracker;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x823
// Size: 0x15
function function_a2b3a19c012e474b( datatracker )
{
    self.associateddatatracker = datatracker;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1
// Checksum 0x0, Offset: 0x840
// Size: 0x15
function function_15c75941af255c67( var_15309dae6e19a117 )
{
    self.var_8e09c79789611261 = var_15309dae6e19a117;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x85d
// Size: 0x50, Type: bool
function private function_365e789cf7ee1a2f( player, broadcastinstance )
{
    if ( !isdefined( player ) || !isdefined( player.guid ) )
    {
        return false;
    }
    
    playerseen = broadcastinstance.var_f16900d47079d51f[ player.guid ];
    return istrue( playerseen );
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x8b6
// Size: 0x2d
function private function_d06b740fbbece1eb( player, broadcastinstance )
{
    broadcastinstance.var_f16900d47079d51f[ player.guid ] = 1;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x8eb
// Size: 0x2c
function private function_d1b2e5b614aa5495( player, broadcastinstance )
{
    broadcastinstance.var_f16900d47079d51f[ player.guid ] = 0;
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x91f
// Size: 0x15, Type: bool
function private function_47c20e1020b91ac1( player, params )
{
    return true;
}

/#

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x93d
    // Size: 0x30, Type: dev
    function private function_28d42a2b1f0b3eab( player, broadcastinstance, broadcastcommand )
    {
        clientprint( player, broadcastinstance.text );
    }

#/

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x975
// Size: 0x5d
function private function_c5de94ea3ad8f2e6( var_2bf0f676fdb4d9d9 )
{
    player = var_2bf0f676fdb4d9d9.player;
    broadcastinstance = var_2bf0f676fdb4d9d9.broadcastinstance;
    function_d06b740fbbece1eb( player, broadcastinstance );
    
    if ( broadcastinstance function_be70a75a57d524fe() )
    {
        function_790e679b0f2d121e( player, broadcastinstance );
    }
    
    function_bb9bc4c538a84c97( player, broadcastinstance, 0 );
}

// Namespace player_broadcasting / namespace_236d5e32d01e927d
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x9da
// Size: 0x8f
function private function_bb9bc4c538a84c97( player, broadcastinstance, broadcastcommand )
{
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x152>" + broadcastinstance getbroadcastuniqueid() + "<dev string:x1b7>" + broadcastcommand );
        return;
    }
    
    broadcasttype = broadcastinstance getbroadcasttype();
    
    if ( isdefined( broadcasttype ) )
    {
        assertex( isdefined( level.var_19f9544004bec048[ broadcasttype ] ), "<dev string:x1cb>" );
        [[ level.var_19f9544004bec048[ broadcasttype ] ]]( player, broadcastinstance, broadcastcommand );
        
        /#
            function_83152f28715ba19f( player, broadcastinstance, broadcastcommand );
        #/
    }
}

/#

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 1
    // Checksum 0x0, Offset: 0xa71
    // Size: 0x37, Type: dev
    function function_b3bcffc014571bbd( broadcastinstance )
    {
        generalbroadcastinstance = "<dev string:x222>" + broadcastinstance getbroadcasttype() + "<dev string:x238>" + broadcastinstance getbroadcastuniqueid();
        return generalbroadcastinstance;
    }

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xab0
    // Size: 0x24, Type: dev
    function private function_7f891130ef74a0()
    {
        enableddvar = getdvarint( @"hash_26b7e4a2ecc0df79", 0 );
        return enableddvar != 0;
    }

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0xadc
    // Size: 0x5c, Type: dev
    function private function_83152f28715ba19f( player, broadcastinstance, broadcastcommand )
    {
        if ( !function_7f891130ef74a0() )
        {
            return;
        }
        
        iprintln( function_fc8d2e5257bc9932() + "<dev string:x248>" + "<dev string:x260>" + player.guid + function_b3bcffc014571bbd( broadcastinstance ) + function_8fcfb1771a833c28( broadcastcommand ) );
    }

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0xb40
    // Size: 0x6c, Type: dev
    function private function_747e8968c9de65cd( player, broadcastinstance, broadcastcommand, details )
    {
        if ( !function_7f891130ef74a0() )
        {
            return;
        }
        
        iprintln( function_fc8d2e5257bc9932() + "<dev string:x26d>" + "<dev string:x260>" + player.guid + function_b3bcffc014571bbd( broadcastinstance ) + function_8fcfb1771a833c28( broadcastcommand ) + "<dev string:x28c>" + details );
    }

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xbb4
    // Size: 0x46, Type: dev
    function private function_8fcfb1771a833c28( broadcastcommand )
    {
        commandstring = "<dev string:x29a>";
        
        if ( broadcastcommand == 1 )
        {
            commandstring = "<dev string:x2a1>";
        }
        else if ( broadcastcommand == 2 )
        {
            commandstring = "<dev string:x2ab>";
        }
        
        return "<dev string:x2b5>" + commandstring;
    }

    // Namespace player_broadcasting / namespace_236d5e32d01e927d
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xc02
    // Size: 0xb, Type: dev
    function private function_fc8d2e5257bc9932()
    {
        return "<dev string:x2c8>";
    }

#/
