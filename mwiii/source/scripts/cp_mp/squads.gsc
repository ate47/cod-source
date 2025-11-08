#using script_2342b8aad723994e;
#using scripts\common\callbacks;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\script;

#namespace squads;

// Namespace squads / scripts\cp_mp\squads
// Params 0
// Checksum 0x0, Offset: 0x33f
// Size: 0x8c
function init()
{
    level.maxsquadsize = getdvarint( @"party_maxsquadsize", 1 );
    
    if ( level.maxsquadsize && function_a9cb1bbce9eb3d1b() )
    {
        level.maxsquadsize = level.maxteamsize;
    }
    
    level.var_74add5a4a809f2af = getdvarint( @"hash_588ca000194bdbe1", level.maxsquadsize );
    level.usesquadleader = getdvarint( @"hash_56fe5e64db58eb48", 1 );
    
    if ( shouldmodesetsquads() )
    {
        initsquaddata();
    }
}

// Namespace squads / scripts\cp_mp\squads
// Params 0
// Checksum 0x0, Offset: 0x3d3
// Size: 0x71
function initsquaddata()
{
    level.squaddata = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.squaddata[ entry ] = [];
    }
    
    /#
        level thread debugprintsquads();
    #/
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0x44c
// Size: 0x3a1
function setsquad( team, index )
{
    if ( !shouldmodesetsquads() )
    {
        return;
    }
    
    if ( !isdefined( team ) || team == "spectator" || team == "codcaster" )
    {
        return;
    }
    
    if ( getdvarint( @"scr_assign_squad_from_team", 0 ) != 0 )
    {
        teamindex = 0;
        
        foreach ( index, name in level.teamnamelist )
        {
            if ( name == team )
            {
                teamindex = index;
                break;
            }
        }
        
        joinsquad( team, teamindex );
        return;
    }
    
    if ( isbot( self ) && isdefined( self.bot_squad ) )
    {
        var_69c5807191f92fbb = self.bot_squad != -1;
    }
    else
    {
        var_69c5807191f92fbb = self.sessionsquadid != -1;
    }
    
    if ( istrue( level.matchmakingmatch ) && var_69c5807191f92fbb && getdvarint( @"hash_6595c001520e3eec", 0 ) != 1 )
    {
        if ( !isdefined( index ) )
        {
            if ( isbot( self ) && isdefined( self.bot_squad ) )
            {
                index = self.bot_squad;
            }
            else
            {
                index = self.sessionsquadid;
            }
        }
        
        self.squadassignedfromlobby = 1;
        joinsquad( team, index );
        return;
    }
    
    allowsquadfill = 1;
    
    if ( isdefined( level.var_1a9fc9c6bae428db ) )
    {
        allowsquadfill = [[ level.var_1a9fc9c6bae428db ]]( self );
    }
    
    if ( istrue( level.matchmakingmatch ) && getdvarint( @"scr_bypass_fireteam_squads", 0 ) != 1 )
    {
        var_ebfb1594ba861d16 = istrue( level.var_d50f1d3b1431cf6b );
        fireteammembers = self getfireteammembers();
        
        if ( isdefined( fireteammembers ) && fireteammembers.size > 0 )
        {
            squadindex = undefined;
            
            foreach ( member in fireteammembers )
            {
                if ( isdefined( member ) && member.sessionsquadid != -1 )
                {
                    squadindex = member.sessionsquadid;
                    break;
                }
            }
            
            if ( isdefined( squadindex ) )
            {
                joinsquad( team, squadindex );
                
                if ( self isfireteamleader() && var_ebfb1594ba861d16 )
                {
                    data = level.squaddata[ team ][ squadindex ];
                    data.var_1d135524e5154d9b = allowsquadfill;
                }
                
                return;
            }
        }
        
        if ( self getprivatepartysize() > 1 )
        {
            requestnewsquad( team, 1, var_ebfb1594ba861d16 );
            return;
        }
    }
    
    foreach ( squad in level.squaddata[ team ] )
    {
        if ( !istrue( squad.var_1d135524e5154d9b ) )
        {
            continue;
        }
        
        if ( squad.players.size >= level.var_74add5a4a809f2af )
        {
            continue;
        }
        
        if ( istrue( level.matchmakingmatch ) )
        {
            if ( squad.isfireteam && squad.players[ 0 ] getprivatepartysize() > squad.players.size )
            {
                continue;
            }
        }
        
        joinsquad( team, squad.index );
        return;
    }
    
    requestnewsquad( team, 0, allowsquadfill );
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0x7f5
// Size: 0x104
function createsquad( team, index )
{
    if ( !isdefined( level.uniquesquadid ) )
    {
        level.uniquesquadid = 0;
    }
    
    if ( !isdefined( index ) )
    {
        index = level.uniquesquadid;
    }
    
    data = spawnstruct();
    data.index = index;
    data.team = team;
    data.isfireteam = 0;
    data.var_1d135524e5154d9b = 1;
    data.players = [];
    data.squadleader = undefined;
    data.skydivezoneindex = undefined;
    data.properties = [];
    
    if ( !isdefined( level.squaddata[ team ] ) )
    {
        level.squaddata[ team ] = [];
    }
    
    level.squaddata[ team ][ index ] = data;
    
    if ( index >= level.uniquesquadid )
    {
        level.uniquesquadid = index + 1;
    }
    
    callback::callback( "squad_created", data );
    return index;
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0x902
// Size: 0x20
function freesquadindex( team, index )
{
    level.squaddata[ team ][ index ] = undefined;
}

// Namespace squads / scripts\cp_mp\squads
// Params 3
// Checksum 0x0, Offset: 0x92a
// Size: 0x7d
function requestnewsquad( team, isfireteam, var_1d135524e5154d9b )
{
    index = createsquad( team );
    data = level.squaddata[ team ][ index ];
    data.infil = undefined;
    
    if ( isdefined( isfireteam ) )
    {
        data.isfireteam = isfireteam;
    }
    
    if ( isdefined( var_1d135524e5154d9b ) )
    {
        data.var_1d135524e5154d9b = var_1d135524e5154d9b;
    }
    
    joinsquad( team, index );
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0x9af
// Size: 0x19c
function joinsquad( team, index )
{
    if ( !isdefined( level.squaddata[ team ][ index ] ) )
    {
        createsquad( team, index );
    }
    
    self.sessionsquadid = index;
    self.sessionuimemberindex = function_eec90fb96d0aff02( team, index );
    
    if ( !isdefined( level.squaddata[ team ][ index ].players ) )
    {
        level.squaddata[ team ][ index ].players = [];
    }
    
    level.squaddata[ team ][ index ].players[ level.squaddata[ team ][ index ].players.size ] = self;
    choosesquadleader( team, index );
    
    if ( getdvarint( @"hash_e1cce0c7778e6dd3", 0 ) )
    {
        logstring( "[SQUAD DEBUG] Player joined squad. Player: " + self.name + ", Session Squad ID: " + self.sessionsquadid + ", Session UI Member Index: " + self.sessionuimemberindex );
    }
    
    if ( getdvarint( @"hash_631315ea4a7701a8", 0 ) > 0 )
    {
        message = "[SQUAD CHANGE DEBUGGING] Player Joined Squad. Player: " + self.name + " Session Squad ID: " + index + " Session UI Member Index: " + self.sessionuimemberindex;
        scripts\mp\utility\script::demoforcesre( message );
    }
    
    namespace_c31609f90efcf2ca::onplayerjoinsquad( self );
    callback::callback( #"hash_cc06eb1d45f33a0c", { #memberindex:self.sessionuimemberindex, #index:self.sessionsquadid, #team:team } );
    self notify( "joined_squad" );
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0xb53
// Size: 0x387
function leavesquad( team, index )
{
    if ( !shouldmodesetsquads() )
    {
        return;
    }
    
    if ( !isdefined( team ) || team == "spectator" || team == "codcaster" || !isdefined( index ) || !isdefined( level.squaddata ) )
    {
        return;
    }
    
    assertex( isdefined( level.squaddata[ team ][ index ] ), "<dev string:x1c>" );
    
    if ( !isdefined( level.squaddata[ team ][ index ] ) )
    {
        return;
    }
    
    callback::callback( #"hash_58cd2edf70911e82", { #memberindex:self.sessionuimemberindex, #index:index, #team:team } );
    
    if ( level.squaddata[ team ][ index ].players.size == 1 )
    {
        freesquadindex( team, index );
        callback::callback( #"hash_cef9136f9b434dc1", { #memberindex:self.sessionuimemberindex, #index:index, #team:team } );
        return;
    }
    
    if ( getdvarint( @"hash_e1cce0c7778e6dd3", 0 ) )
    {
        logstring( "[SQUAD DEBUG] PLayer leaving squad. Player: " + self.name + ", Session Squad ID: " + index + ", Session UI Member Index: " + self.sessionuimemberindex );
    }
    
    if ( getdvarint( @"hash_631315ea4a7701a8", 0 ) > 0 )
    {
        message = "[SQUAD CHANGE DEBUGGING] Player: " + self.name + " Left Squad: " + index + " Session UI Member Index: " + self.sessionuimemberindex;
        scripts\mp\utility\script::demoforcesre( message );
    }
    
    self.var_71afb85ec1cc06f8 = self.sessionuimemberindex;
    self.sessionuimemberindex = -1;
    var_aa17b95935a5047f = 0;
    squadleader = getsquadleader( team, index );
    
    if ( istrue( level.usesquadleader ) && isdefined( squadleader ) && squadleader == self )
    {
        level.squaddata[ team ][ index ].squadleader = undefined;
        var_aa17b95935a5047f = 1;
        
        foreach ( player in level.squaddata[ team ][ index ].players )
        {
            player setclientomnvar( "ui_squad_leader", undefined );
        }
    }
    
    namespace_c31609f90efcf2ca::function_2a1e4811621fdcde( self );
    callback::callback( #"hash_cef9136f9b434dc1", { #memberindex:self.var_71afb85ec1cc06f8, #index:index, #team:team } );
    level.squaddata[ team ][ index ].players = array_remove( level.squaddata[ team ][ index ].players, self );
    
    if ( istrue( var_aa17b95935a5047f ) )
    {
        squadmembers = array_randomize( level.squaddata[ team ][ index ].players );
        
        foreach ( player in squadmembers )
        {
            if ( isdefined( player ) )
            {
                player choosesquadleader( team, index );
                break;
            }
        }
    }
}

// Namespace squads / scripts\cp_mp\squads
// Params 0
// Checksum 0x0, Offset: 0xee2
// Size: 0x5e
function function_9be60342a8babba5()
{
    if ( issharedfuncdefined( "teamAssim", "isEnabled" ) && [[ getsharedfunc( "teamAssim", "isEnabled" ) ]]() )
    {
        if ( issharedfuncdefined( "teamAssim", "getMaxAssimilationTeamSize" ) )
        {
            return [[ getsharedfunc( "teamAssim", "getMaxAssimilationTeamSize" ) ]]();
        }
        
        return;
    }
    
    return level.maxsquadsize;
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0xf48
// Size: 0x11c
function function_eec90fb96d0aff02( team, index )
{
    availableindices = [];
    
    for ( i = 0; i < function_9be60342a8babba5() ; i++ )
    {
        availableindices[ i ] = 1;
    }
    
    foreach ( player in level.squaddata[ team ][ index ].players )
    {
        if ( isdefined( player.sessionuimemberindex ) && player.sessionuimemberindex >= 0 )
        {
            availableindices[ player.sessionuimemberindex ] = 0;
        }
    }
    
    foreach ( index, isavailable in availableindices )
    {
        if ( isavailable )
        {
            return index;
        }
    }
    
    assertmsg( "<dev string:x42>" );
    return undefined;
}

// Namespace squads / scripts\cp_mp\squads
// Params 3
// Checksum 0x0, Offset: 0x106d
// Size: 0x52
function changesquad( team, oldteam, index )
{
    if ( isdefined( self.sessionsquadid ) && self.sessionsquadid == index )
    {
        return;
    }
    
    leavesquad( oldteam, self.sessionsquadid );
    joinsquad( team, index );
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0x10c7
// Size: 0x2dc
function updatesquadomnvars( team, squadindex )
{
    if ( !shouldmodesetsquads() || !isdefined( level.squaddata ) )
    {
        return;
    }
    
    squadleader = getsquadleader( team, squadindex );
    
    foreach ( player in level.squaddata[ team ][ squadindex ].players )
    {
        var_4f87bc92d01fa479 = squadindex;
        var_4f87bc92d01fa479 += level.squaddata[ team ][ squadindex ].players.size << 5;
        
        if ( isdefined( squadleader ) && squadleader == player )
        {
            var_4f87bc92d01fa479 += 256;
        }
        
        if ( istrue( level.var_4e353dc2c64b19b1 ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_squad_data", var_4f87bc92d01fa479 );
        
        if ( isdefined( level.gametype ) && ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "arena" || level.gametype == "brtdm" || level.gametype == "brtdm_mgl" ) )
        {
            var_69fe4a18f948739c = player.game_extrainfo & 65528;
            player.game_extrainfo = var_69fe4a18f948739c | player.sessionuimemberindex + 1;
            
            if ( isdefined( squadleader ) && squadleader == player )
            {
                player.game_extrainfo |= 256;
            }
            else
            {
                player.game_extrainfo &= ~256;
            }
            
            var_f31235f8d2bec0f0 = player getentitynumber();
            
            if ( isdefined( squadleader ) && squadleader == player )
            {
                var_f31235f8d2bec0f0 += 2048;
            }
            
            if ( isalive( player ) )
            {
                var_f31235f8d2bec0f0 += 4096;
            }
            
            player setclientomnvar( "ui_arm_squadmember_0", var_f31235f8d2bec0f0 );
            mates = array_remove( level.squaddata[ team ][ squadindex ].players, player );
            
            for ( i = 0; i < 3 ; i++ )
            {
                mate = mates[ i ];
                
                if ( isdefined( mate ) )
                {
                    var_f31235f8d2bec0f0 = mate getentitynumber();
                    
                    if ( isdefined( squadleader ) && squadleader == mate )
                    {
                        var_f31235f8d2bec0f0 += 2048;
                    }
                    
                    if ( isalive( mate ) )
                    {
                        var_f31235f8d2bec0f0 += 4096;
                    }
                }
                else
                {
                    var_f31235f8d2bec0f0 = -1;
                }
                
                player setclientomnvar( "ui_arm_squadmember_" + i + 1, var_f31235f8d2bec0f0 );
            }
        }
    }
}

// Namespace squads / scripts\cp_mp\squads
// Params 0
// Checksum 0x0, Offset: 0x13ab
// Size: 0x12, Type: bool
function function_3d93807e453d0770()
{
    return scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() || scripts\cp_mp\utility\game_utility::function_6910a4c65560c44b();
}

// Namespace squads / scripts\cp_mp\squads
// Params 2
// Checksum 0x0, Offset: 0x13c6
// Size: 0x207
function choosesquadleader( team, index )
{
    if ( !istrue( level.usesquadleader ) )
    {
        return;
    }
    
    var_ddb8d98c593d15de = 0;
    
    if ( istrue( level.matchmakingmatch ) )
    {
        fireteammembers = self getfireteammembers();
        
        if ( isdefined( fireteammembers ) && fireteammembers.size > 0 )
        {
            var_ddb8d98c593d15de = self isfireteamleader();
        }
    }
    
    candidate = self;
    
    if ( !var_ddb8d98c593d15de )
    {
        currentleader = getsquadleader( team, index );
        
        if ( function_3d93807e453d0770() )
        {
            if ( isdefined( currentleader ) && !isai( currentleader ) )
            {
                return;
            }
            
            if ( isai( candidate ) )
            {
                var_beb6c9f3d61cf4e1 = 0;
                
                foreach ( player in level.squaddata[ team ][ index ].players )
                {
                    if ( !isai( player ) )
                    {
                        candidate = player;
                        var_beb6c9f3d61cf4e1 = 1;
                        break;
                    }
                }
                
                if ( !var_beb6c9f3d61cf4e1 && isdefined( currentleader ) )
                {
                    return;
                }
            }
        }
        else if ( isdefined( currentleader ) )
        {
            return;
        }
    }
    
    level.squaddata[ team ][ index ].squadleader = candidate;
    
    foreach ( player in level.squaddata[ team ][ index ].players )
    {
        player setclientomnvar( "ui_squad_leader", candidate );
    }
    
    if ( getdvarint( @"hash_631315ea4a7701a8", 0 ) > 0 )
    {
        message = "[SQUAD CHANGE DEBUGGING] Choose Squad Leader - Squad: " + index + " squadLeader: " + candidate.name + " Session UI Member Index: " + self.sessionuimemberindex;
        scripts\mp\utility\script::demoforcesre( message );
    }
}

/#

    // Namespace squads / scripts\cp_mp\squads
    // Params 0
    // Checksum 0x0, Offset: 0x15d5
    // Size: 0x240, Type: dev
    function debugprintsquads()
    {
        stepy = 25;
        
        while ( true )
        {
            if ( getdvarint( @"hash_eb9b72744c4518d8", 0 ) == 1 && isdefined( level.squaddata ) )
            {
                startx = 800;
                starty = 25;
                linecount = 1;
                printtoscreen2d( startx, starty, "<dev string:x84>", ( 1, 1, 1 ), 1 );
                
                foreach ( team, var_70643c8580524236 in level.squaddata )
                {
                    linecount = 1;
                    printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x92>" + team, ( 1, 1, 1 ), 1 );
                    linecount++;
                    
                    foreach ( squad in var_70643c8580524236 )
                    {
                        color = ( 1, 1, 1 );
                        
                        if ( isdefined( squad.activemission ) )
                        {
                            color = ( 1, 1, 0 );
                        }
                        
                        printtoscreen2d( startx + 25, starty + stepy * linecount, "<dev string:x9c>" + squad.index, color, 1 );
                        linecount++;
                        
                        foreach ( player in squad.players )
                        {
                            color = ( 1, 1, 1 );
                            
                            if ( istrue( player.squadassignedfromlobby ) )
                            {
                                color = ( 0, 1, 0 );
                            }
                            
                            printtoscreen2d( startx + 50, starty + stepy * linecount, player.name, color, 1 );
                            linecount++;
                        }
                    }
                    
                    startx += 200;
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace squads / scripts\cp_mp\squads
// Params 3
// Checksum 0x0, Offset: 0x181d
// Size: 0xe0
function getsquaddata( team, sessionsquadid, property )
{
    assertex( isdefined( level.squaddata[ team ][ sessionsquadid ] ), "<dev string:xa7>" + team + "<dev string:xc5>" + sessionsquadid + "<dev string:xcb>" );
    assertex( function_be6ce63a202791c5( team, sessionsquadid, property ), "<dev string:xa7>" + team + "<dev string:xc5>" + sessionsquadid + "<dev string:xc5>" + property + "<dev string:xcb>" );
    
    if ( isdefined( level.squaddata[ team ][ sessionsquadid ] ) && isdefined( level.squaddata[ team ][ sessionsquadid ].properties ) && isdefined( level.squaddata[ team ][ sessionsquadid ].properties[ property ] ) )
    {
        return level.squaddata[ team ][ sessionsquadid ].properties[ property ];
    }
    
    return undefined;
}

// Namespace squads / scripts\cp_mp\squads
// Params 4
// Checksum 0x0, Offset: 0x1905
// Size: 0xa9
function function_a20a10ce593f692b( team, sessionsquadid, property, value )
{
    assertex( isdefined( level.squaddata[ team ][ sessionsquadid ] ), "<dev string:xa7>" + team + "<dev string:xc5>" + sessionsquadid + "<dev string:xcb>" );
    assertex( function_be6ce63a202791c5( team, sessionsquadid, property ), "<dev string:xa7>" + team + "<dev string:xc5>" + sessionsquadid + "<dev string:xc5>" + property + "<dev string:xcb>" );
    assertex( isdefined( value ), "<dev string:xd0>" );
    level.squaddata[ team ][ sessionsquadid ].properties[ property ] = value;
}

// Namespace squads / scripts\cp_mp\squads
// Params 3
// Checksum 0x0, Offset: 0x19b6
// Size: 0x7e, Type: bool
function function_be6ce63a202791c5( team, sessionsquadid, property )
{
    assertex( isdefined( level.squaddata[ team ][ sessionsquadid ] ), "<dev string:xa7>" + team + "<dev string:xc5>" + sessionsquadid + "<dev string:xcb>" );
    
    if ( !isdefined( level.squaddata[ team ][ sessionsquadid ].properties ) )
    {
        return false;
    }
    
    return isdefined( level.squaddata[ team ][ sessionsquadid ].properties[ property ] );
}

