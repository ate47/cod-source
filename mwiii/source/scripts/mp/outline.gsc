#using script_2342b8aad723994e;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\outline;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\join_team_aggregator;

#namespace outline;

// Namespace outline / scripts\mp\outline
// Params 0
// Checksum 0x0, Offset: 0x217
// Size: 0x4d
function init()
{
    level.outlineids = 0;
    level.outlineents = [];
    level.outlineidspending = [];
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &outlineonplayerdisconnect );
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( &outlineonplayerjoinedteam );
    namespace_c31609f90efcf2ca::registeronplayerjoinsquadcallback( &outlineonplayerjoinedsquad );
    level thread outlineidswatchpending();
}

// Namespace outline / scripts\mp\outline
// Params 7
// Checksum 0x0, Offset: 0x26c
// Size: 0x249
function outlineenableinternal( var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, type, var_fa3b23d51c2dc7, squadindex )
{
    assertex( type != "<dev string:x1c>" || isdefined( var_fa3b23d51c2dc7 ), "<dev string:x24>" );
    assertex( type != "<dev string:x77>" || isdefined( var_fa3b23d51c2dc7 ) && isdefined( squadindex ), "<dev string:x80>" );
    
    if ( !isdefined( var_f20913fec7561c5f.outlines ) )
    {
        var_f20913fec7561c5f.outlines = [];
    }
    
    oinfo = spawnstruct();
    oinfo.isdisabled = 0;
    oinfo.priority = outlineprioritygroupmap( prioritygroup );
    oinfo.playersvisibleto = playersvisibleto;
    oinfo.playersvisibletopending = [];
    oinfo.hudoutlineassetname = hudoutlineassetname;
    oinfo.type = type;
    oinfo.team = var_fa3b23d51c2dc7;
    oinfo.sessionsquadid = squadindex;
    id = outlinegenerateuniqueid();
    var_f20913fec7561c5f.outlines[ id ] = oinfo;
    outlineaddtogloballist( var_f20913fec7561c5f );
    var_cda6602a02c53ba3 = [];
    
    foreach ( player in oinfo.playersvisibleto )
    {
        if ( !canoutlineforplayer( player ) )
        {
            oinfo.playersvisibletopending[ oinfo.playersvisibletopending.size ] = player;
            level.outlineidspending[ id ] = var_f20913fec7561c5f;
            continue;
        }
        
        var_25a840a406e8542a = outlinegethighestinfoforplayer( var_f20913fec7561c5f, player );
        
        if ( !isdefined( var_25a840a406e8542a ) || var_25a840a406e8542a == oinfo || var_25a840a406e8542a.priority == oinfo.priority )
        {
            var_cda6602a02c53ba3[ var_cda6602a02c53ba3.size ] = player;
        }
    }
    
    if ( var_cda6602a02c53ba3.size > 0 )
    {
        if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
        {
            var_f20913fec7561c5f function_3430d5003d0cc9f( var_cda6602a02c53ba3, prioritygroup );
        }
        else
        {
            var_f20913fec7561c5f _hudoutlineenableforclients( var_cda6602a02c53ba3, oinfo.hudoutlineassetname );
        }
    }
    
    return id;
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x4be
// Size: 0x1b7
function outlinedisableinternal( id, var_420a996e67989dc4 )
{
    if ( !isdefined( var_420a996e67989dc4 ) )
    {
        level.outlineents = array_removeundefined( level.outlineents );
        return;
    }
    else if ( !isdefined( var_420a996e67989dc4.outlines ) )
    {
        outlineremovefromgloballist( var_420a996e67989dc4 );
        return;
    }
    
    var_77c349ecef6fb0d9 = var_420a996e67989dc4.outlines[ id ];
    
    if ( !isdefined( var_77c349ecef6fb0d9 ) || var_77c349ecef6fb0d9.isdisabled )
    {
        return;
    }
    
    var_77c349ecef6fb0d9.isdisabled = 1;
    
    foreach ( player in var_77c349ecef6fb0d9.playersvisibleto )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !canoutlineforplayer( player ) )
        {
            var_77c349ecef6fb0d9.playersvisibletopending[ var_77c349ecef6fb0d9.playersvisibletopending.size ] = player;
            level.outlineidspending[ id ] = var_420a996e67989dc4;
            continue;
        }
        
        var_25a840a406e8542a = outlinegethighestinfoforplayer( var_420a996e67989dc4, player );
        
        if ( isdefined( var_25a840a406e8542a ) )
        {
            if ( var_25a840a406e8542a.priority <= var_77c349ecef6fb0d9.priority )
            {
                var_420a996e67989dc4 _hudoutlineenableforclient( player, var_25a840a406e8542a.hudoutlineassetname );
            }
            
            continue;
        }
        
        if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
        {
            var_420a996e67989dc4 scripts\mp\outline::function_32dfa50c47325abe( player, "equipment", 1 );
            continue;
        }
        
        var_420a996e67989dc4 hudoutlinedisableforclient( player );
    }
    
    if ( var_77c349ecef6fb0d9.playersvisibletopending.size == 0 )
    {
        var_420a996e67989dc4.outlines[ id ] = undefined;
        
        if ( var_420a996e67989dc4.outlines.size == 0 )
        {
            outlineremovefromgloballist( var_420a996e67989dc4 );
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 0
// Checksum 0x0, Offset: 0x67d
// Size: 0x30
function hudoutline_channels_init()
{
    self.hudoutlinechannels = [];
    self.var_2876398bde7a4cf4 = "outline_depth_white";
    hudoutline_add_channel_internal( "default", 0, self.var_2876398bde7a4cf4 );
}

// Namespace outline / scripts\mp\outline
// Params 3
// Checksum 0x0, Offset: 0x6b5
// Size: 0x106
function hudoutline_add_channel_internal( channelname, priority, outlineasset )
{
    if ( !isdefined( self.hudoutlinechannels ) )
    {
        scripts\mp\outline::hudoutline_channels_init();
    }
    
    if ( function_bf76e3eaccf13673( self.hudoutlinechannels, channelname ) == -1 )
    {
        channelsize = self.hudoutlinechannels.size;
        index = ter_op( channelsize > 0, channelsize, 0 );
        
        for ( i = 0; i < channelsize ; i++ )
        {
            if ( self.hudoutlinechannels[ i ].channelpriority >= priority )
            {
                index = i;
                break;
            }
        }
        
        channelstruct = spawnstruct();
        channelstruct.channelname = channelname;
        channelstruct.channelpriority = priority;
        channelstruct.outlineasset = outlineasset;
        channelstruct.var_41272a9c461e0853 = [];
        self.hudoutlinechannels = array_insert( self.hudoutlinechannels, channelstruct, index );
    }
}

// Namespace outline / scripts\mp\outline
// Params 3
// Checksum 0x0, Offset: 0x7c3
// Size: 0x232
function hudoutline_enable_internal( viewer, channelname, hudoutlineasset )
{
    if ( !isdefined( channelname ) )
    {
        channelname = "default";
    }
    
    if ( !isdefined( self.hudoutlinechannels ) )
    {
        hudoutline_channels_init();
    }
    
    channelindex = function_bf76e3eaccf13673( self.hudoutlinechannels, channelname );
    
    if ( channelindex == -1 )
    {
        if ( !isdefined( hudoutlineasset ) )
        {
            hudoutlineasset = self.var_2876398bde7a4cf4;
        }
        
        hudoutline_add_channel_internal( channelname, self.hudoutlinechannels[ 0 ].channelpriority - 1, hudoutlineasset );
        channelindex = function_bf76e3eaccf13673( self.hudoutlinechannels, channelname );
    }
    
    if ( channelname != "default" && isdefined( hudoutlineasset ) && self.hudoutlinechannels[ channelindex ].outlineasset != hudoutlineasset && function_370c25acb4da9fe9( channelname, self ) )
    {
        self.hudoutlinechannels[ channelindex ].outlineasset = hudoutlineasset;
        function_a2d9562a736f54e3( channelname, self, hudoutlineasset );
    }
    
    if ( !isdefined( self.hudoutlinecurchannel ) )
    {
        hudoutline_activate_channel( channelname, viewer );
    }
    
    curchannelpriority = self.hudoutlinecurchannel.channelpriority;
    thischannelpriority = self.hudoutlinechannels[ channelindex ].channelpriority;
    
    if ( !array_contains( self.hudoutlinechannels[ channelindex ].var_41272a9c461e0853, viewer ) )
    {
        self.hudoutlinechannels[ channelindex ].var_41272a9c461e0853 = array_add( self.hudoutlinechannels[ channelindex ].var_41272a9c461e0853, viewer );
    }
    
    if ( self.hudoutlinecurchannel.channelname != channelname && curchannelpriority < thischannelpriority )
    {
        hudoutline_activate_channel( channelname, viewer );
        return;
    }
    
    if ( self.hudoutlinecurchannel.channelname == channelname )
    {
        function_f980012fc1b73aee( self, channelname, viewer );
        return;
    }
    
    if ( self.hudoutlinecurchannel.channelname != channelname && curchannelpriority > thischannelpriority && !array_contains( self.hudoutlinecurchannel.var_41272a9c461e0853, viewer ) )
    {
        hudoutline_activate_channel( channelname, viewer );
    }
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x9fd
// Size: 0x43
function function_bf76e3eaccf13673( var_a531b6ffdacf9ab5, channelname )
{
    for ( i = 0; i < var_a531b6ffdacf9ab5.size ; i++ )
    {
        if ( var_a531b6ffdacf9ab5[ i ].channelname == channelname )
        {
            return i;
        }
    }
    
    return -1;
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0xa49
// Size: 0x55, Type: bool
function function_370c25acb4da9fe9( channelname, ent )
{
    channelindex = function_bf76e3eaccf13673( self.hudoutlinechannels, channelname );
    
    if ( channelindex >= 0 && self.hudoutlinechannels[ channelindex ].var_41272a9c461e0853.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace outline / scripts\mp\outline
// Params 3
// Checksum 0x0, Offset: 0xaa7
// Size: 0xe8
function function_f980012fc1b73aee( ent, channelname, viewer )
{
    if ( !function_2bd2083ae492439a( ent, viewer ) )
    {
        function_af1ed457ea26863c( ent, channelname, viewer );
        return;
    }
    
    foreach ( outlinechannel in self.hudoutlinechannels )
    {
        channelindex = function_bf76e3eaccf13673( self.hudoutlinechannels, channelname );
        
        if ( channelindex >= 0 && outlinechannel.channelpriority > self.hudoutlinechannels[ channelindex ].channelpriority && array_contains( outlinechannel.var_41272a9c461e0853, viewer ) )
        {
            return;
        }
    }
    
    function_af1ed457ea26863c( ent, channelname, viewer );
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0xb97
// Size: 0x7a, Type: bool
function function_2bd2083ae492439a( ent, viewer )
{
    foreach ( channel in ent.hudoutlinechannels )
    {
        if ( array_contains( channel.var_41272a9c461e0853, viewer ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace outline / scripts\mp\outline
// Params 3
// Checksum 0x0, Offset: 0xc1a
// Size: 0x9d
function function_a2d9562a736f54e3( channelname, ent, hudoutlineasset )
{
    channelindex = function_bf76e3eaccf13673( self.hudoutlinechannels, channelname );
    
    if ( channelindex >= 0 )
    {
        foreach ( viewer in self.hudoutlinechannels[ channelindex ].var_41272a9c461e0853 )
        {
            ent hudoutlineenableforclient( viewer, hudoutlineasset );
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 3
// Checksum 0x0, Offset: 0xcbf
// Size: 0xa2
function function_af1ed457ea26863c( ent, channelname, viewer )
{
    channelindex = function_bf76e3eaccf13673( self.hudoutlinechannels, channelname );
    
    if ( channelindex >= 0 )
    {
        channel = self.hudoutlinechannels[ channelindex ];
        ent hudoutlineenableforclient( viewer, channel.outlineasset );
        
        if ( !array_contains( channel.var_41272a9c461e0853, viewer ) )
        {
            self.hudoutlinechannels[ channelindex ].var_41272a9c461e0853 = array_add( channel.var_41272a9c461e0853, viewer );
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0xd69
// Size: 0xa0
function hudoutline_activate_channel( channelname, viewer )
{
    if ( isdefined( self.hudoutlinecurchannel ) && self.hudoutlinecurchannel.channelname != channelname && array_contains( self.hudoutlinecurchannel.var_41272a9c461e0853, viewer ) )
    {
        function_32dfa50c47325abe( viewer, self.hudoutlinecurchannel.channelname, 0 );
    }
    
    self.hudoutlinecurchannel = self.hudoutlinechannels[ function_bf76e3eaccf13673( self.hudoutlinechannels, channelname ) ];
    function_f980012fc1b73aee( self, channelname, viewer );
}

// Namespace outline / scripts\mp\outline
// Params 3
// Checksum 0x0, Offset: 0xe11
// Size: 0x146
function function_32dfa50c47325abe( var_10afc5ce5a1feebe, channelname, var_d6ee45fafd47e3cc )
{
    if ( !isdefined( var_d6ee45fafd47e3cc ) )
    {
        var_d6ee45fafd47e3cc = 0;
    }
    
    channelindex = function_bf76e3eaccf13673( self.hudoutlinechannels, channelname );
    channel = self.hudoutlinechannels[ channelindex ];
    
    if ( isdefined( channel ) )
    {
        for ( i = 0; i < channel.var_41272a9c461e0853.size ; i++ )
        {
            if ( channel.var_41272a9c461e0853[ i ] == var_10afc5ce5a1feebe )
            {
                self hudoutlinedisableforclient( var_10afc5ce5a1feebe );
                
                if ( var_d6ee45fafd47e3cc )
                {
                    self.hudoutlinechannels[ channelindex ].var_41272a9c461e0853 = array_remove_index( channel.var_41272a9c461e0853, i, 0 );
                }
                
                break;
            }
        }
        
        for ( i = self.hudoutlinechannels.size - 1; i >= 0 ; i-- )
        {
            if ( self.hudoutlinechannels[ i ].channelpriority > channel.channelpriority )
            {
                continue;
            }
            
            if ( array_contains( self.hudoutlinechannels[ i ].var_41272a9c461e0853, var_10afc5ce5a1feebe ) )
            {
                hudoutline_activate_channel( self.hudoutlinechannels[ i ].channelname, var_10afc5ce5a1feebe );
                break;
            }
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0xf5f
// Size: 0x115
function outlinerefreshinternal( var_420a996e67989dc4 )
{
    if ( !isdefined( var_420a996e67989dc4.outlines ) || var_420a996e67989dc4.outlines.size == 0 )
    {
        return;
    }
    
    foreach ( oinfo in var_420a996e67989dc4.outlines )
    {
        if ( !isdefined( oinfo ) || oinfo.isdisabled )
        {
            continue;
        }
        
        foreach ( player in oinfo.playersvisibleto )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_25a840a406e8542a = outlinegethighestinfoforplayer( var_420a996e67989dc4, player );
            
            if ( isdefined( var_25a840a406e8542a ) )
            {
                var_420a996e67989dc4 _hudoutlineenableforclient( player, var_25a840a406e8542a.hudoutlineassetname );
            }
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x107c
// Size: 0x1b
function outlineonplayerdisconnect( player )
{
    outlineremoveplayerfromvisibletoarrays( player );
    outlinedisableinternalall( player );
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x109f
// Size: 0x4f
function outlineonplayerjoinedteam( player )
{
    if ( !isdefined( player.team ) || player.team == "spectator" || player.team == "codcaster" )
    {
        return;
    }
    
    thread outlineonplayerjoinedteam_onfirstspawn( player );
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x10f6
// Size: 0x41
function outlineonplayerjoinedteam_onfirstspawn( player )
{
    player notify( "outlineOnPlayerJoinedTeam_onFirstSpawn" );
    player endon( "outlineOnPlayerJoinedTeam_onFirstSpawn" );
    player endon( "disconnect" );
    player waittill( "spawned_player" );
    outlineremoveplayerfromvisibletoarrays( player );
    outlinedisableinternalall( player );
    outlineaddplayertoexistingallandteamoutlines( player );
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x113f
// Size: 0x43
function outlineonplayerjoinedsquad( player )
{
    assertex( isdefined( player.team ) && player.team != "<dev string:xe5>", "<dev string:xf2>" );
    thread outlineonplayerjoinedsquad_onfirstspawn( player );
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x118a
// Size: 0x3b
function outlineonplayerjoinedsquad_onfirstspawn( player )
{
    player notify( "outlineOnPlayerJoinedSquad_onFirstSpawn" );
    player endon( "outlineOnPlayerJoinedSquad_onFirstSpawn" );
    player endon( "disconnect" );
    player waittill( "spawned_player" );
    outlineremoveplayerfromvisibletoarrays( player, 1 );
    outlineaddplayertoexistingsquadoutlines( player );
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x11cd
// Size: 0x190
function outlineremoveplayerfromvisibletoarrays( player, var_e1f59b5642da1702 )
{
    level.outlineents = array_removeundefined( level.outlineents );
    
    foreach ( var_420a996e67989dc4 in level.outlineents )
    {
        var_8408cba753aba3e3 = 0;
        
        if ( !isdefined( var_420a996e67989dc4 ) || !isdefined( var_420a996e67989dc4.outlines ) )
        {
            continue;
        }
        
        foreach ( oinfo in var_420a996e67989dc4.outlines )
        {
            if ( !isdefined( oinfo.playersvisibleto ) )
            {
                continue;
            }
            
            if ( istrue( var_e1f59b5642da1702 ) )
            {
                if ( oinfo.type != "SQUAD" )
                {
                    continue;
                }
            }
            
            oinfo.playersvisibleto = array_removeundefined( oinfo.playersvisibleto );
            
            if ( isdefined( player ) && array_contains( oinfo.playersvisibleto, player ) )
            {
                oinfo.playersvisibleto = array_remove( oinfo.playersvisibleto, player );
                var_8408cba753aba3e3 = 1;
            }
        }
        
        if ( var_8408cba753aba3e3 && isdefined( var_420a996e67989dc4 ) && isdefined( player ) )
        {
            var_420a996e67989dc4 hudoutlinedisableforclient( player );
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x1365
// Size: 0x18d
function outlineaddplayertoexistingallandteamoutlines( player )
{
    foreach ( var_420a996e67989dc4 in level.outlineents )
    {
        if ( !isdefined( var_420a996e67989dc4 ) || !isdefined( var_420a996e67989dc4.outlines ) )
        {
            continue;
        }
        
        var_25a840a406e8542a = undefined;
        
        foreach ( oinfo in var_420a996e67989dc4.outlines )
        {
            if ( oinfo.type == "ALL" || oinfo.type == "TEAM" && oinfo.team == player.team )
            {
                if ( !array_contains( oinfo.playersvisibleto, player ) )
                {
                    oinfo.playersvisibleto[ oinfo.playersvisibleto.size ] = player;
                }
                else
                {
                    assertmsg( "<dev string:x136>" );
                }
                
                if ( !isdefined( var_25a840a406e8542a ) || oinfo.priority > var_25a840a406e8542a.priority )
                {
                    var_25a840a406e8542a = oinfo;
                }
            }
        }
        
        if ( isdefined( var_25a840a406e8542a ) )
        {
            var_420a996e67989dc4 _hudoutlineenableforclient( player, var_25a840a406e8542a.hudoutlineassetname );
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x14fa
// Size: 0x1c0
function outlineaddplayertoexistingsquadoutlines( player )
{
    if ( !isdefined( player.sessionsquadid ) )
    {
        assertmsg( "<dev string:x1df>" );
    }
    
    foreach ( var_420a996e67989dc4 in level.outlineents )
    {
        if ( !isdefined( var_420a996e67989dc4 ) || !isdefined( var_420a996e67989dc4.outlines ) )
        {
            continue;
        }
        
        var_25a840a406e8542a = undefined;
        
        foreach ( oinfo in var_420a996e67989dc4.outlines )
        {
            if ( oinfo.type == "SQUAD" && oinfo.team == player.team && isdefined( oinfo.sessionsquadid ) && oinfo.sessionsquadid == player.sessionsquadid )
            {
                if ( !array_contains( oinfo.playersvisibleto, player ) )
                {
                    oinfo.playersvisibleto[ oinfo.playersvisibleto.size ] = player;
                }
                else
                {
                    assertmsg( "<dev string:x244>" );
                }
                
                if ( !isdefined( var_25a840a406e8542a ) || oinfo.priority > var_25a840a406e8542a.priority )
                {
                    var_25a840a406e8542a = oinfo;
                }
            }
        }
        
        if ( isdefined( var_25a840a406e8542a ) )
        {
            var_420a996e67989dc4 _hudoutlineenableforclient( player, var_25a840a406e8542a.hudoutlineassetname );
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x16c2
// Size: 0x8b
function outlinedisableinternalall( var_420a996e67989dc4 )
{
    if ( !isdefined( var_420a996e67989dc4 ) || !isdefined( var_420a996e67989dc4.outlines ) || var_420a996e67989dc4.outlines.size == 0 )
    {
        return;
    }
    
    foreach ( id, _ in var_420a996e67989dc4.outlines )
    {
        outlinedisableinternal( id, var_420a996e67989dc4 );
    }
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x1755
// Size: 0x34
function outlineaddtogloballist( var_420a996e67989dc4 )
{
    if ( !array_contains( level.outlineents, var_420a996e67989dc4 ) )
    {
        level.outlineents[ level.outlineents.size ] = var_420a996e67989dc4;
    }
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x1791
// Size: 0x24
function outlineremovefromgloballist( var_420a996e67989dc4 )
{
    level.outlineents = array_remove( level.outlineents, var_420a996e67989dc4 );
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x17bd
// Size: 0xca
function outlinegethighestpriorityid( var_420a996e67989dc4 )
{
    result = -1;
    
    if ( !isdefined( var_420a996e67989dc4.outlines ) || var_420a996e67989dc4.size == 0 )
    {
        return result;
    }
    
    var_25a840a406e8542a = undefined;
    
    foreach ( id, oinfo in var_420a996e67989dc4.outlines )
    {
        if ( !isdefined( oinfo ) || oinfo.isdisabled )
        {
            continue;
        }
        
        if ( !isdefined( var_25a840a406e8542a ) || oinfo.priority > var_25a840a406e8542a.priority )
        {
            var_25a840a406e8542a = oinfo;
            result = id;
        }
    }
    
    return result;
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x1890
// Size: 0xd9
function outlinegethighestinfoforplayer( var_420a996e67989dc4, player )
{
    var_25a840a406e8542a = undefined;
    
    if ( !isdefined( var_420a996e67989dc4.outlines ) || var_420a996e67989dc4.size == 0 )
    {
        return var_25a840a406e8542a;
    }
    
    foreach ( oinfo in var_420a996e67989dc4.outlines )
    {
        if ( !isdefined( oinfo ) || oinfo.isdisabled )
        {
            continue;
        }
        
        if ( array_contains( oinfo.playersvisibleto, player ) && ( !isdefined( var_25a840a406e8542a ) || oinfo.priority > var_25a840a406e8542a.priority ) )
        {
            var_25a840a406e8542a = oinfo;
        }
    }
    
    return var_25a840a406e8542a;
}

// Namespace outline / scripts\mp\outline
// Params 0
// Checksum 0x0, Offset: 0x1972
// Size: 0x2d
function outlinegenerateuniqueid()
{
    assertex( isdefined( level.outlineids ), "<dev string:x2f1>" );
    level.outlineids++;
    return level.outlineids;
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x19a8
// Size: 0xf6
function outlineprioritygroupmap( prioritygroup )
{
    prioritygroup = tolower( prioritygroup );
    priority = undefined;
    
    switch ( prioritygroup )
    {
        case #"hash_981112ec5a4f9d1b":
            priority = 0;
            break;
        case #"hash_5b627208a88fd4c5":
            priority = 1;
            break;
        case #"hash_93c71e7b6c0b81d7":
            priority = 2;
            break;
        case #"hash_ab671284a3fc4e3d":
            priority = 3;
            break;
        case #"hash_ddbe11dc920809f1":
            priority = 4;
            break;
        case #"hash_1cac65e1b8bf24a7":
            priority = 5;
            break;
        case #"hash_1f9d0ab7b01d7818":
            priority = 6;
            break;
        case #"hash_df6b3b2585101bc7":
            priority = 7;
            break;
        case #"hash_6d308d6c437ce11c":
            priority = 8;
            break;
        default:
            assertmsg( "<dev string:x346>" + prioritygroup );
            priority = 0;
            break;
    }
    
    return priority;
}

// Namespace outline / scripts\mp\outline
// Params 0
// Checksum 0x0, Offset: 0x1aa7
// Size: 0xae
function outlineiddowatch()
{
    foreach ( index, ent in level.outlineidspending )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( !isdefined( ent.outlines ) )
        {
            continue;
        }
        
        oinfo = ent.outlines[ index ];
        
        if ( !isdefined( oinfo ) )
        {
            continue;
        }
        
        if ( oinfo.playersvisibletopending.size > 0 )
        {
            if ( outlinerefreshpending( ent, index ) )
            {
                level.outlineidspending[ index ] = undefined;
            }
        }
    }
}

// Namespace outline / scripts\mp\outline
// Params 0
// Checksum 0x0, Offset: 0x1b5d
// Size: 0x13
function outlineidswatchpending()
{
    while ( true )
    {
        waittillframeend();
        outlineiddowatch();
        waitframe();
    }
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x1b78
// Size: 0x14b, Type: bool
function outlinerefreshpending( var_420a996e67989dc4, id )
{
    oinfo = var_420a996e67989dc4.outlines[ id ];
    
    foreach ( index, player in oinfo.playersvisibletopending )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( canoutlineforplayer( player ) )
        {
            var_25a840a406e8542a = outlinegethighestinfoforplayer( var_420a996e67989dc4, player );
            
            if ( isdefined( var_25a840a406e8542a ) && var_25a840a406e8542a.hudoutlineassetname != "invisible" )
            {
                var_420a996e67989dc4 hudoutlineenableforclient( player, var_25a840a406e8542a.hudoutlineassetname );
            }
            else
            {
                var_420a996e67989dc4 hudoutlinedisableforclient( player );
            }
            
            oinfo.playersvisibletopending[ index ] = undefined;
        }
    }
    
    oinfo.playersvisibletopending = array_removeundefined( oinfo.playersvisibletopending );
    
    if ( oinfo.playersvisibletopending.size == 0 )
    {
        if ( oinfo.isdisabled )
        {
            var_420a996e67989dc4.outlines[ id ] = undefined;
        }
        
        if ( var_420a996e67989dc4.outlines.size == 0 )
        {
            outlineremovefromgloballist( var_420a996e67989dc4 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace outline / scripts\mp\outline
// Params 1
// Checksum 0x0, Offset: 0x1ccc
// Size: 0x1c, Type: bool
function canoutlineforplayer( player )
{
    return player.sessionstate != "spectator";
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x1cf1
// Size: 0x60
function function_3430d5003d0cc9f( var_cda6602a02c53ba3, prioritygroup )
{
    foreach ( operator in var_cda6602a02c53ba3 )
    {
        scripts\mp\outline::hudoutline_enable_internal( operator, prioritygroup );
    }
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x1d59
// Size: 0x31
function _hudoutlineenableforclient( client, hudoutlineassetname )
{
    if ( hudoutlineassetname == "invisible" )
    {
        self hudoutlinedisableforclient( client );
        return;
    }
    
    self hudoutlineenableforclient( client, hudoutlineassetname );
}

// Namespace outline / scripts\mp\outline
// Params 2
// Checksum 0x0, Offset: 0x1d92
// Size: 0x31
function _hudoutlineenableforclients( var_b66f9e35e36435bb, hudoutlineassetname )
{
    if ( hudoutlineassetname == "invisible" )
    {
        self hudoutlinedisableforclients( var_b66f9e35e36435bb );
        return;
    }
    
    self hudoutlineenableforclients( var_b66f9e35e36435bb, hudoutlineassetname );
}

