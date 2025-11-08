#using scripts\common\utility;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace cp_outline_utility;

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0x3d9
// Size: 0x3b
function init()
{
    level.outlineids = 0;
    level.outlineents = [];
    level.outlineidspending = [];
    level thread outlinecatchplayerdisconnect();
    level thread outlineonplayerjoinedteam();
    level thread outlineidswatchpending();
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 6
// Checksum 0x0, Offset: 0x41c
// Size: 0x203
function outlineenableinternal( var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, type, var_fa3b23d51c2dc7 )
{
    assertex( type != "TEAM" || isdefined( var_fa3b23d51c2dc7 ), "outlineEnableInternal() passed type \"TEAM\" without teamVisibleTo being defined." );
    
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
    
    if ( type == "TEAM" )
    {
        oinfo.team = var_fa3b23d51c2dc7;
    }
    
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
        var_f20913fec7561c5f _hudoutlineenableforclients( var_cda6602a02c53ba3, oinfo.hudoutlineassetname );
    }
    
    return id;
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x628
// Size: 0x19a
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x7ca
// Size: 0x112
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0x8e4
// Size: 0x27
function outlinecatchplayerdisconnect()
{
    while ( true )
    {
        level waittill( "connected", player );
        level thread outlineonplayerdisconnect( player );
    }
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x913
// Size: 0x2a
function outlineonplayerdisconnect( player )
{
    level endon( "game_ended" );
    player waittill( "disconnect" );
    outlineremoveplayerfromvisibletoarrays( player );
    outlinedisableinternalall( player );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0x945
// Size: 0x4e
function outlineonplayerjoinedteam()
{
    while ( true )
    {
        level waittill( "joined_team", player );
        
        if ( !isdefined( player.team ) || player.team == "spectator" )
        {
            continue;
        }
        
        thread outlineonplayerjoinedteam_onfirstspawn( player );
    }
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x99b
// Size: 0x41
function outlineonplayerjoinedteam_onfirstspawn( player )
{
    player notify( "outlineOnPlayerJoinedTeam_onFirstSpawn" );
    player endon( "outlineOnPlayerJoinedTeam_onFirstSpawn" );
    player endon( "disconnect" );
    player waittill( "spawned_player" );
    outlineremoveplayerfromvisibletoarrays( player );
    outlinedisableinternalall( player );
    outlineaddplayertoexistingteamoutlines( player );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x9e4
// Size: 0x13c
function outlineremoveplayerfromvisibletoarrays( player )
{
    level.outlineents = array_removeundefined( level.outlineents );
    
    foreach ( var_420a996e67989dc4 in level.outlineents )
    {
        var_8408cba753aba3e3 = 0;
        
        foreach ( oinfo in var_420a996e67989dc4.outlines )
        {
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0xb28
// Size: 0x179
function outlineaddplayertoexistingteamoutlines( player )
{
    foreach ( var_420a996e67989dc4 in level.outlineents )
    {
        if ( !isdefined( var_420a996e67989dc4 ) )
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
                    assertmsg( "Found a team outline call on a player's new team that already had a reference to him. This should never happen. Are we letting a player change teams to his own team?" );
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0xca9
// Size: 0x88
function outlinedisableinternalall( var_420a996e67989dc4 )
{
    if ( !isdefined( var_420a996e67989dc4 ) || !isdefined( var_420a996e67989dc4.outlines ) || var_420a996e67989dc4.outlines.size == 0 )
    {
        return;
    }
    
    foreach ( _ in var_420a996e67989dc4.outlines )
    {
        outlinedisableinternal( id, var_420a996e67989dc4 );
    }
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0xd39
// Size: 0x34
function outlineaddtogloballist( var_420a996e67989dc4 )
{
    if ( !array_contains( level.outlineents, var_420a996e67989dc4 ) )
    {
        level.outlineents[ level.outlineents.size ] = var_420a996e67989dc4;
    }
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0xd75
// Size: 0x24
function outlineremovefromgloballist( var_420a996e67989dc4 )
{
    level.outlineents = array_remove( level.outlineents, var_420a996e67989dc4 );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0xda1
// Size: 0xc9
function outlinegethighestpriorityid( var_420a996e67989dc4 )
{
    result = -1;
    
    if ( !isdefined( var_420a996e67989dc4.outlines ) || var_420a996e67989dc4.size == 0 )
    {
        return result;
    }
    
    var_25a840a406e8542a = undefined;
    
    foreach ( oinfo in var_420a996e67989dc4.outlines )
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0xe73
// Size: 0xd7
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0xf53
// Size: 0x2d
function outlinegenerateuniqueid()
{
    assertex( isdefined( level.outlineids ), "Outline enable called on entity before _outline::init() function has been called." );
    level.outlineids++;
    return level.outlineids;
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0xf89
// Size: 0xe2
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
        default:
            assertmsg( "Invalid priority group passed to outlinePriorityGroupMap(): " + prioritygroup );
            priority = 0;
            break;
    }
    
    return priority;
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0x1074
// Size: 0xac
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0x1128
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x1143
// Size: 0x135, Type: bool
function outlinerefreshpending( var_420a996e67989dc4, id )
{
    oinfo = var_420a996e67989dc4.outlines[ id ];
    
    foreach ( player in oinfo.playersvisibletopending )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( canoutlineforplayer( player ) )
        {
            var_25a840a406e8542a = outlinegethighestinfoforplayer( var_420a996e67989dc4, player );
            
            if ( isdefined( var_25a840a406e8542a ) )
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

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x1281
// Size: 0x1c, Type: bool
function canoutlineforplayer( player )
{
    return player.sessionstate != "spectator";
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x12a6
// Size: 0x1c
function _hudoutlineenableforclient( client, hudoutlineassetname )
{
    self hudoutlineenableforclient( client, hudoutlineassetname );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x12ca
// Size: 0x1c
function _hudoutlineenableforclients( var_b66f9e35e36435bb, hudoutlineassetname )
{
    self hudoutlineenableforclients( var_b66f9e35e36435bb, hudoutlineassetname );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 3
// Checksum 0x0, Offset: 0x12ee
// Size: 0x3e
function outlineenableforall( var_f20913fec7561c5f, hudoutlineassetname, prioritygroup )
{
    playersvisibleto = level.players;
    return scripts\cp\cp_outline_utility::outlineenableinternal( var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "ALL" );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 4
// Checksum 0x0, Offset: 0x1335
// Size: 0x4a
function outlineenableforteam( var_f20913fec7561c5f, var_fa3b23d51c2dc7, hudoutlineassetname, prioritygroup )
{
    playersvisibleto = getteamdata( var_fa3b23d51c2dc7, "players" );
    return scripts\cp\cp_outline_utility::outlineenableinternal( var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "TEAM", var_fa3b23d51c2dc7 );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 4
// Checksum 0x0, Offset: 0x1388
// Size: 0x47
function outlineenableforplayer( var_f20913fec7561c5f, var_18ebeb29bb7541e3, hudoutlineassetname, prioritygroup )
{
    if ( isagent( var_18ebeb29bb7541e3 ) )
    {
        return scripts\cp\cp_outline_utility::outlinegenerateuniqueid();
    }
    
    return scripts\cp\cp_outline_utility::outlineenableinternal( var_f20913fec7561c5f, [ var_18ebeb29bb7541e3 ], hudoutlineassetname, prioritygroup, "ENTITY" );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x13d8
// Size: 0x38
function outlinedisable( id, var_420a996e67989dc4 )
{
    assertex( isdefined( id ) && int( id ) == id, "Invalid ID passed to outlineDisable()" );
    scripts\cp\cp_outline_utility::outlinedisableinternal( id, var_420a996e67989dc4 );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x1418
// Size: 0x23
function outlinerefresh( var_420a996e67989dc4 )
{
    assertex( isdefined( var_420a996e67989dc4 ), "Undefined entOutlined passed to outlineRefresh()" );
    scripts\cp\cp_outline_utility::outlinerefreshinternal( var_420a996e67989dc4 );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0x1443
// Size: 0x16
function initoutlineoccluders()
{
    level.outlineoccluders = [];
    level.outlineoccludersid = 0;
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x1461
// Size: 0x69
function addoutlineoccluder( position, radius )
{
    outlineoccluder = spawnstruct();
    outlineoccluder.position = position;
    outlineoccluder.radius = radius;
    id = level.outlineoccludersid;
    level.outlineoccluders[ id ] = outlineoccluder;
    level.outlineoccludersid++;
    return id;
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x14d3
// Size: 0x16
function removeoutlineoccluder( id )
{
    level.outlineoccluders[ id ] = undefined;
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x14f1
// Size: 0xaa, Type: bool
function outlineoccluded( startpoint, endpoint )
{
    foreach ( occluder in level.outlineoccluders )
    {
        if ( !isdefined( occluder ) || !isdefined( occluder.position ) || !isdefined( occluder.radius ) )
        {
            continue;
        }
        
        if ( math::segmentvssphere( startpoint, endpoint, occluder.position, occluder.radius ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 0
// Checksum 0x0, Offset: 0x15a4
// Size: 0x13
function _hudoutlineviewmodeldisable()
{
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    self hudoutlineviewmodeldisable();
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x15bf
// Size: 0x58
function _hudoutlineviewmodelenable( hudoutlineassetname, var_dafd99b070fb282a )
{
    if ( !isdefined( var_dafd99b070fb282a ) )
    {
        var_dafd99b070fb282a = 0;
    }
    
    if ( !var_dafd99b070fb282a && !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        assertmsg( "Viewmodel outline cannot be set on dead players, to set on next spawn pass true as second param" );
    }
    
    if ( var_dafd99b070fb282a && !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        thread hudoutlineviewmodelenableonnextspawn( hudoutlineassetname );
        return;
    }
    
    self hudoutlineviewmodelenable( hudoutlineassetname );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 1
// Checksum 0x0, Offset: 0x161f
// Size: 0x32
function hudoutlineviewmodelenableonnextspawn( hudoutlineassetname )
{
    level endon( "game_ended" );
    self waittill( "spawned" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    self hudoutlineviewmodelenable( hudoutlineassetname );
}

// Namespace cp_outline_utility / scripts\cp\cp_outline_utility
// Params 2
// Checksum 0x0, Offset: 0x1659
// Size: 0x6e
function getteamdata( team, property )
{
    assertex( isdefined( level.teamdata[ team ] ), "UNDEFINED level.teamData[" + team + "]" );
    assertex( isdefined( level.teamdata[ team ][ property ] ), "UNDEFINED level.teamData[" + team + "][" + property + "]" );
    return level.teamdata[ team ][ property ];
}

