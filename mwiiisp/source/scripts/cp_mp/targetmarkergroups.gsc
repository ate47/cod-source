#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace targetmarkergroups;

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 0
// Checksum 0x0, Offset: 0x634
// Size: 0x63
function init()
{
    level.activetargetmarkergroups = [];
    
    if ( issharedfuncdefined( "game", "registerOnPlayerSpawnCallback" ) )
    {
        [[ getsharedfunc( "game", "registerOnPlayerSpawnCallback" ) ]]( &targetmarkergroup_clearcacheonspawn );
    }
    
    registersharedfunc( "game", "targetMarkerGroup_off", &targetmarkergroup_off );
    registersharedfunc( "game", "targetMarkerGroup_on", &targetmarkergroup_on );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 7
// Checksum 0x0, Offset: 0x69f
// Size: 0xd0
function targetmarkergroup_on( markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1 )
{
    if ( level.activetargetmarkergroups.size >= 50 )
    {
        assertmsg( "targetMarkerGroup_on: There are too many active target marker groups.  Please remove some before adding more." );
        return;
    }
    
    if ( targetmarkergroup_getownedgroups( groupowner ) >= 2 )
    {
        assertmsg( "targetMarkerGroup_on: Owner already has too many active groups.  Please turn off a group before adding a new one." );
        return;
    }
    
    newtargetmarkergroupid = createtargetmarkergroup( markerwidgetname );
    
    if ( !isdefined( newtargetmarkergroupid ) )
    {
        assertmsg( "targetMarkerGroup_on: Can't create target marker group.  Marker Group ID invalid!" );
        return;
    }
    else if ( targetmarkergroupexists( newtargetmarkergroupid ) )
    {
        assertmsg( "targetMarkerGroup_on: Can't create target marker group.  Marker Group ID: " + newtargetmarkergroupid + " already exists!" );
        return;
    }
    
    addtargetmarkergroup( newtargetmarkergroupid, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1 );
    return newtargetmarkergroupid;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x778
// Size: 0x3b
function targetmarkergroup_off( targetmarkergroupid )
{
    if ( !targetmarkergroupexists( targetmarkergroupid ) )
    {
        assertmsg( "Trying to remove invalid target marker group ID: " + targetmarkergroupid + " " );
        return;
    }
    
    removetargetmarkergroup( targetmarkergroupid );
    deletetargetmarkergroup( targetmarkergroupid );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x7bb
// Size: 0x79
function function_32fdc90fc744999f( ent )
{
    var_729ee1cfdbe2c06e = 0;
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( array_contains( markergroup.showntoents, ent ) )
        {
            var_729ee1cfdbe2c06e++;
        }
    }
    
    return var_729ee1cfdbe2c06e;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x83d
// Size: 0x97
function function_b76f204edb67efc7( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assertex( isdefined( markergroup ), "Tried to add clients to TargetMarkerGroup but the TMG did not exist" );
    
    if ( isdefined( showto ) )
    {
        if ( isplayer( showto ) )
        {
            if ( array_contains( markergroup.showntoents, showto ) )
            {
                return;
            }
            
            if ( function_32fdc90fc744999f( showto ) >= 2 )
            {
                assertmsg( "addTargetMarkerGroup: Show to Entity already has too many active groups.  Please turn off a group before adding a new one." );
                return;
            }
            
            markergroup.showntoents[ markergroup.showntoents.size ] = showto;
            addclienttotargetmarkergroupmask( targetmarkergroupid, showto );
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x8dc
// Size: 0xfb
function function_9f84e910425d033( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assertex( isdefined( markergroup ), "Tried to add clients to TargetMarkerGroup but the TMG did not exist" );
    assertex( isdefined( showto ), "Tried to add clients to TargetMarkerGroup but list is undefined." );
    assertex( isarray( showto ), "ShowTo is not an array of clients. Please adjust this before using this function." );
    
    foreach ( showtoent in showto )
    {
        if ( isplayer( showtoent ) )
        {
            if ( array_contains( markergroup.showntoents, showtoent ) )
            {
                continue;
            }
            
            if ( function_32fdc90fc744999f( showtoent ) >= 2 )
            {
                assertmsg( "addTargetMarkerGroup: Show to Entity already has too many active groups.  Please turn off a group before adding a new one." );
                continue;
            }
            
            markergroup.showntoents[ markergroup.showntoents.size ] = showtoent;
            addclienttotargetmarkergroupmask( targetmarkergroupid, showtoent );
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x9df
// Size: 0xf7
function function_adb80c80f10281f9( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assertex( isdefined( markergroup ), "Tried to add clients to TargetMarkerGroup but the TMG did not exist" );
    
    if ( isdefined( showto ) )
    {
        if ( isteam( showto ) )
        {
            if ( array_contains( markergroup.showntoteams, showto ) )
            {
                return;
            }
            
            teaments = level.teamdata[ showto ][ "players" ];
            
            foreach ( player in teaments )
            {
                if ( function_32fdc90fc744999f( player ) >= 2 )
                {
                    assertmsg( "addTargetMarkerGroup: Show to Entity already has too many active groups.  Please turn off a group before adding a new one." );
                    return;
                }
            }
            
            markergroup.showntoteams[ markergroup.showntoteams.size ] = showto;
            addteamtotargetmarkergroupmask( targetmarkergroupid, showto );
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0xade
// Size: 0x164
function function_aafa0ed4a3d69b91( targetmarkergroupid, showto )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assertex( isdefined( markergroup ), "Tried to add clients to TargetMarkerGroup but the TMG did not exist" );
    assertex( isdefined( showto ), "Tried to add team list to TargetMarkerGroup but ShowTo is undefined." );
    assertex( isarray( showto ), "ShowTo is not an array. Please adjust this before using this function." );
    
    foreach ( showtoent in showto )
    {
        if ( isteam( showtoent ) )
        {
            if ( array_contains( markergroup.showntoteams, showtoent ) )
            {
                continue;
            }
            
            teaments = level.teamdata[ showtoent ][ "players" ];
            
            foreach ( player in teaments )
            {
                if ( function_32fdc90fc744999f( player ) >= 2 )
                {
                    assertmsg( "addTargetMarkerGroup: Show to Entity already has too many active groups.  Please turn off a group before adding a new one." );
                    break;
                }
            }
            
            markergroup.showntoteams[ markergroup.showntoteams.size ] = showtoent;
            addteamtotargetmarkergroupmask( targetmarkergroupid, showtoent );
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0xc4a
// Size: 0x19f
function function_fd770a1099036688( targetmarkergroupid, var_65f5a4e57b38d87 )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    assertex( isdefined( markergroup ), "Tried to add clients to TargetMarkerGroup but the TMG did not exist" );
    
    if ( isdefined( var_65f5a4e57b38d87 ) )
    {
        if ( isarray( var_65f5a4e57b38d87 ) )
        {
            foreach ( remove in var_65f5a4e57b38d87 )
            {
                if ( isplayer( var_65f5a4e57b38d87 ) )
                {
                    if ( array_contains( markergroup.showntoents, remove ) )
                    {
                        markergroup.showntoents = array_remove( markergroup.showntoents, remove );
                        removeclientfromtargetmarkergroupmask( targetmarkergroupid, remove );
                    }
                    
                    continue;
                }
                
                if ( isteam( var_65f5a4e57b38d87 ) )
                {
                    if ( array_contains( markergroup.showntoteams, remove ) )
                    {
                        markergroup.showntoteams = array_remove( markergroup.showntoteams, remove );
                        removeteamfromtargetmarkergroupmask( targetmarkergroupid, remove );
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( var_65f5a4e57b38d87 ) )
        {
            if ( array_contains( markergroup.showntoents, var_65f5a4e57b38d87 ) )
            {
                markergroup.showntoents = array_remove( markergroup.showntoents, var_65f5a4e57b38d87 );
                removeclientfromtargetmarkergroupmask( targetmarkergroupid, var_65f5a4e57b38d87 );
            }
            
            return;
        }
        
        if ( isteam( var_65f5a4e57b38d87 ) )
        {
            if ( array_contains( markergroup.showntoteams, var_65f5a4e57b38d87 ) )
            {
                markergroup.showntoteams = array_remove( markergroup.showntoteams, var_65f5a4e57b38d87 );
                removeteamfromtargetmarkergroupmask( targetmarkergroupid, var_65f5a4e57b38d87 );
            }
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 7
// Checksum 0x0, Offset: 0xdf1
// Size: 0x2ad
function addtargetmarkergroup( targetmarkergroupid, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1 )
{
    markergroup = spawnstruct();
    markergroup.markerid = targetmarkergroupid;
    markergroup.markerowner = groupowner;
    markergroup.friendlymarker = friendlymarker;
    markergroup.showntoents = [];
    markergroup.showntoteams = [];
    markergroup.markedents = [];
    markergroup.markedentsinqueue = [];
    level.activetargetmarkergroups[ level.activetargetmarkergroups.size ] = markergroup;
    level thread targetmarkergroup_handlemarkingfromqueue( targetmarkergroupid );
    
    if ( isdefined( showto ) )
    {
        if ( isarray( showto ) )
        {
            foreach ( showtoent in showto )
            {
                if ( function_32fdc90fc744999f( showtoent ) >= 2 )
                {
                    assertmsg( "addTargetMarkerGroup: Show to Entity already has too many active groups.  Please turn off a group before adding a new one." );
                    continue;
                }
                
                if ( isplayer( showtoent ) )
                {
                    markergroup.showntoents[ markergroup.showntoents.size ] = showtoent;
                    addclienttotargetmarkergroupmask( targetmarkergroupid, showtoent );
                    continue;
                }
                
                if ( isteam( showtoent ) )
                {
                    markergroup.showntoteams[ markergroup.showntoteams.size ] = showtoent;
                    addteamtotargetmarkergroupmask( targetmarkergroupid, showtoent );
                }
            }
        }
        else if ( isplayer( showto ) )
        {
            markergroup.showntoents[ markergroup.showntoents.size ] = showto;
            addclienttotargetmarkergroupmask( targetmarkergroupid, showto );
        }
        else if ( isteam( showto ) )
        {
            markergroup.showntoteams[ markergroup.showntoteams.size ] = showto;
            addteamtotargetmarkergroupmask( targetmarkergroupid, showto );
        }
    }
    
    if ( isdefined( tomark ) )
    {
        if ( isarray( tomark ) )
        {
            foreach ( enttomark in tomark )
            {
                targetmarkergroup_markentity( enttomark, targetmarkergroupid, var_262f4b55aa151de1 );
            }
        }
        else
        {
            targetmarkergroup_markentity( tomark, targetmarkergroupid, var_262f4b55aa151de1 );
        }
    }
    
    if ( istrue( markonspawn ) )
    {
        level thread targetmarkergroup_watchmarkonspawn( targetmarkergroupid, var_262f4b55aa151de1 );
    }
    
    if ( istrue( var_262f4b55aa151de1 ) )
    {
        level thread targetmarkergroup_watchfornoscopeoutlineperkset( targetmarkergroupid );
        level thread targetmarkergroup_watchfornoscopeoutlineperkunset( targetmarkergroupid );
    }
    
    if ( function_ccf98e6391dd38b9() )
    {
        level thread function_78264e044be08e4d( targetmarkergroupid );
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x10a6
// Size: 0xcd
function function_78264e044be08e4d( targetmarkergroupid )
{
    level endon( "game_ended" );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( targetmarkergroupexists( targetmarkergroupid ) )
    {
        markergroup = gettargetmarkergroup( targetmarkergroupid );
        
        if ( markergroup.markedentsinqueue.size > 0 )
        {
            entnum = undefined;
            
            foreach ( ent in markergroup.markedents )
            {
                entnum = ent function_74348e91568973f8();
                
                if ( isdefined( entnum ) )
                {
                    ent function_61a64c527b1e0c5f( markergroup );
                    wait randomfloatrange( 0.1, 0.2 );
                    break;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x117b
// Size: 0x32
function setnewowner( targetmarkergroupid, newowner )
{
    tmg = gettargetmarkergroup( targetmarkergroupid );
    tmg.markerowner = newowner;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x11b5
// Size: 0xa4
function removetargetmarkergroup( targetmarkergroupid )
{
    grouptoremove = undefined;
    var_1af30f69ef1607bf = [];
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerid == targetmarkergroupid )
        {
            grouptoremove = markergroup;
            continue;
        }
        
        var_1af30f69ef1607bf[ var_1af30f69ef1607bf.size ] = markergroup;
    }
    
    if ( isdefined( grouptoremove ) )
    {
        grouptoremove = undefined;
    }
    
    level.activetargetmarkergroups = var_1af30f69ef1607bf;
    level notify( "removed_targetMarkerGroup_" + targetmarkergroupid );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x1261
// Size: 0x8d
function targetmarkergroupexists( targetmarkergroupid )
{
    groupexists = 0;
    
    if ( !isdefined( targetmarkergroupid ) )
    {
        assertmsg( "targetMarkerGroupExists: Invalid target marker group id" );
        return groupexists;
    }
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerid == targetmarkergroupid )
        {
            groupexists = 1;
            break;
        }
    }
    
    return groupexists;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x12f7
// Size: 0x8c
function gettargetmarkergroup( targetmarkergroupid )
{
    targetmarkergroup = undefined;
    
    if ( !isdefined( targetmarkergroupid ) )
    {
        assertmsg( "getTargetMarkerGroup: Invalid target marker group id" );
        return targetmarkergroup;
    }
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerid == targetmarkergroupid )
        {
            targetmarkergroup = markergroup;
            break;
        }
    }
    
    return targetmarkergroup;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x138c
// Size: 0x53
function targetmarkergroup_watchmarkonspawn( targetmarkergroupid, var_262f4b55aa151de1 )
{
    level endon( "game_ended " );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        
        if ( canbemarkedingroup( targetmarkergroupid, player ) )
        {
            targetmarkergroup_markentity( player, targetmarkergroupid, var_262f4b55aa151de1 );
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x13e7
// Size: 0x4a
function targetmarkergroup_watchfornoscopeoutlineperkunset( targetmarkergroupid )
{
    level endon( "game_ended " );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( true )
    {
        level waittill( "unset_noscopeoutline", player );
        
        if ( canbemarkedingroup( targetmarkergroupid, player ) )
        {
            targetmarkergroup_markentity( player, targetmarkergroupid );
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x1439
// Size: 0x4a
function targetmarkergroup_watchfornoscopeoutlineperkset( targetmarkergroupid )
{
    level endon( "game_ended " );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( true )
    {
        level waittill( "set_noscopeoutline", player );
        
        if ( canbemarkedingroup( targetmarkergroupid, player ) )
        {
            targetmarkergroup_unmarkentity( player, targetmarkergroupid );
        }
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x148b
// Size: 0x88
function private function_74348e91568973f8()
{
    outxuid = undefined;
    
    if ( isdefined( self ) && isent( self ) )
    {
        if ( isplayer( self ) && !isbot( self ) )
        {
            outxuid = self getxuid();
        }
        else if ( isdefined( self.owner ) && !isbot( self.owner ) && isplayer( self.owner ) )
        {
            outxuid = self.owner getxuid();
        }
        else
        {
            outxuid = self getentitynumber();
        }
    }
    
    return outxuid;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 3
// Checksum 0x0, Offset: 0x151c
// Size: 0x1dd
function targetmarkergroup_markentity( ent, targetmarkergroupid, var_262f4b55aa151de1 )
{
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    
    if ( !isdefined( markergroup ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    entnum = ent function_74348e91568973f8();
    
    if ( !isdefined( entnum ) )
    {
        return;
    }
    
    if ( markergroup.markedents.size >= 20 )
    {
        ent targetmarkergroup_addtomarkingqueue( markergroup );
        return;
    }
    
    if ( isdefined( ent ) && isplayer( ent ) )
    {
        if ( istrue( ent.liveragdoll ) )
        {
            return;
        }
        
        if ( istrue( var_262f4b55aa151de1 ) )
        {
            markerowner = markergroup.markerowner;
            checkteam = isdefined( markergroup.friendlymarker );
            isfriendlymarker = istrue( markergroup.friendlymarker );
            
            if ( checkteam )
            {
                if ( !isfriendlymarker )
                {
                    if ( issharedfuncdefined( "perk", "hasPerk" ) )
                    {
                        if ( ent [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_noscopeoutline" ) )
                        {
                            return;
                        }
                    }
                }
            }
            else if ( issharedfuncdefined( "perk", "hasPerk" ) )
            {
                if ( ent [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_noscopeoutline" ) )
                {
                    return;
                }
            }
        }
    }
    
    if ( !array_contains( markergroup.markedents, ent ) )
    {
        markergroup.markedents[ entnum ] = ent;
        targetmarkergroupaddentity( targetmarkergroupid, ent );
        
        if ( isplayer( ent ) )
        {
            ent thread targetmarkergroup_removefromgroupaction( "death", markergroup );
            ent thread targetmarkergroup_removefromgroupaction( "disconnect", markergroup );
            ent thread targetmarkergroup_removefromgroupaction( "joined_team", markergroup );
            ent thread targetmarkergroup_removefromgroupaction( "enter_live_ragdoll", markergroup );
            return;
        }
        
        ent thread targetmarkergroup_removefromgroupaction( "death", markergroup );
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x1701
// Size: 0x54
function function_61a64c527b1e0c5f( markergroup )
{
    entnum = function_74348e91568973f8();
    markergroup endon( "ent_removed_" + entnum );
    level endon( "removed_targetMarkerGroup_" + markergroup.markerid );
    targetmarkergroup_addtomarkingqueue( markergroup );
    targetmarkergroup_unmarkentity( self, markergroup.markerid, entnum );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x175d
// Size: 0x58
function targetmarkergroup_removefromgroupaction( action, markergroup )
{
    entnum = function_74348e91568973f8();
    markergroup endon( "ent_removed_" + entnum );
    level endon( "removed_targetMarkerGroup_" + markergroup.markerid );
    self waittill( action );
    targetmarkergroup_unmarkentity( self, markergroup.markerid, entnum );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x17bd
// Size: 0x68
function targetmarkergroup_addtomarkingqueue( markergroup )
{
    if ( isdefined( self ) && !array_contains( markergroup.markedentsinqueue, self ) )
    {
        markergroup.markedentsinqueue[ markergroup.markedentsinqueue.size ] = self;
        
        if ( isplayer( self ) )
        {
            thread function_38a987baf2b61673( "disconnect", markergroup );
            return;
        }
        
        thread function_38a987baf2b61673( "death", markergroup );
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x182d
// Size: 0x39
function function_38a987baf2b61673( removenotify, markergroup )
{
    level endon( "game_ended" );
    level endon( "removed_targetMarkerGroup_" + markergroup.markerid );
    self waittill( removenotify );
    targetmarkergroup_removefrommarkingqueue( markergroup );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x186e
// Size: 0x6a
function targetmarkergroup_removefrommarkingqueue( markergroup )
{
    if ( !isdefined( markergroup ) )
    {
        assertmsg( "<dev string:x56>" );
        return;
    }
    
    newlist = [];
    
    if ( isdefined( self ) )
    {
        newlist = array_remove( markergroup.markedentsinqueue, self );
    }
    else
    {
        newlist = array_removeundefined( markergroup.markedentsinqueue );
    }
    
    markergroup.markedentsinqueue = newlist;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x18e0
// Size: 0xbe
function targetmarkergroup_handlemarkingfromqueue( markergroupid )
{
    level endon( "game_ended" );
    level endon( "removed_targetMarkerGroup_" + markergroupid );
    
    while ( targetmarkergroupexists( markergroupid ) )
    {
        level waittill( "ent_removed_from_marker_group", var_568640efc573fcce );
        markergroup = gettargetmarkergroup( markergroupid );
        
        if ( !isdefined( markergroup ) )
        {
            assertmsg( "targetMarkerGroup_handleMarkingFromQueue: Marker group doesn't exist" );
            break;
        }
        
        if ( var_568640efc573fcce != markergroup )
        {
            continue;
        }
        
        if ( markergroup.markedentsinqueue.size == 0 )
        {
            continue;
        }
        
        enttoadd = undefined;
        
        if ( isdefined( markergroup.markedentsinqueue[ 0 ] ) )
        {
            enttoadd = markergroup.markedentsinqueue[ 0 ];
        }
        
        enttoadd targetmarkergroup_removefrommarkingqueue( markergroup );
        targetmarkergroup_markentity( enttoadd, markergroupid );
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 3
// Checksum 0x0, Offset: 0x19a6
// Size: 0x9a
function targetmarkergroup_unmarkentity( ent, targetmarkergroupid, entnumoverride )
{
    entnum = ent function_74348e91568973f8();
    
    if ( isdefined( entnumoverride ) )
    {
        entnum = entnumoverride;
    }
    
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    
    if ( isdefined( markergroup ) && isdefined( markergroup.markedents ) )
    {
        markergroup.markedents = function_6c752e44b5090154( markergroup.markedents, ent );
        
        if ( isdefined( ent ) )
        {
            targetmarkergroupremoveentity( targetmarkergroupid, ent );
        }
        
        level notify( "ent_removed_from_marker_group", markergroup );
        markergroup notify( "ent_removed_" + entnum );
    }
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x1a48
// Size: 0x7d
function function_6c752e44b5090154( markedents, enttoremove )
{
    newarray = [];
    
    foreach ( ent in markedents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( isdefined( enttoremove ) && enttoremove == ent )
        {
            continue;
        }
        
        newarray[ entnumindex ] = ent;
    }
    
    return newarray;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x1ace
// Size: 0x61, Type: bool
function function_7c253e3d43e44097( target, targetmarkergroupid )
{
    entnum = target function_74348e91568973f8();
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    return isdefined( markergroup ) && isdefined( markergroup.markedents ) && isdefined( entnum ) && isdefined( markergroup.markedents[ entnum ] );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x1b38
// Size: 0x74
function targetmarkergroup_getownedgroups( groupowner )
{
    groupcount = 0;
    
    foreach ( markergroup in level.activetargetmarkergroups )
    {
        if ( markergroup.markerowner == groupowner )
        {
            groupcount++;
        }
    }
    
    return groupcount;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 0
// Checksum 0x0, Offset: 0x1bb5
// Size: 0x13
function targetmarkergroup_clearcacheonspawn()
{
    self setclientomnvar( "ui_clear_target_markers", gettime() );
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 1
// Checksum 0x0, Offset: 0x1bd0
// Size: 0x6b, Type: bool
function isteam( showto )
{
    if ( showto == "spectator" )
    {
        return true;
    }
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( showto == teamname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace targetmarkergroups / scripts\cp_mp\targetmarkergroups
// Params 2
// Checksum 0x0, Offset: 0x1c44
// Size: 0xe1
function canbemarkedingroup( targetmarkergroupid, ent )
{
    canbemarked = 0;
    markergroup = gettargetmarkergroup( targetmarkergroupid );
    markergroupowner = markergroup.markerowner;
    checkteam = istrue( level.teambased );
    isfriendlymarker = istrue( markergroup.friendlymarker );
    
    if ( !isdefined( markergroupowner ) )
    {
        return canbemarked;
    }
    
    if ( checkteam )
    {
        if ( isfriendlymarker )
        {
            if ( ent.team == markergroupowner.team )
            {
                canbemarked = 1;
            }
        }
        else if ( ent.team != markergroupowner.team )
        {
            canbemarked = 1;
        }
    }
    else if ( isfriendlymarker )
    {
        if ( ent == markergroupowner )
        {
            canbemarked = 1;
        }
    }
    else if ( ent != markergroupowner )
    {
        canbemarked = 1;
    }
    
    return canbemarked;
}

