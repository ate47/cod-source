#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;

#namespace objidpoolmanager;

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 0
// Checksum 0x0, Offset: 0x152
// Size: 0x6b
function init()
{
    objectiveidpool = spawnstruct();
    objectiveidpool.active = [];
    objectiveidpool.reclaimed = [];
    objectiveidpool.reserved = [];
    objectiveidpool.index = 0;
    objectiveidpool.limit = getmaxobjectivecount();
    level.objectiveidpool = objectiveidpool;
    level.var_9977f6e10514d7ce = [];
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x1c5
// Size: 0xec
function requestreservedid( objid )
{
    if ( objective_isunlimited() )
    {
        if ( !isdefined( objid ) || objid == -1 )
        {
            objid = level.var_9977f6e10514d7ce.size;
        }
        
        return function_be6060bf8a6e12c2( objid );
    }
    
    if ( !isdefined( objid ) || objid == -1 )
    {
        objid = getnextobjectiveid( 100 );
        
        if ( objid == -1 )
        {
            return -1;
        }
    }
    else
    {
        level.objectiveidpool.index++;
    }
    
    entry = spawnstruct();
    entry.priority = 100;
    entry.requesttime = gettime();
    entry.objid = objid;
    level.objectiveidpool.active[ objid ] = entry;
    level.objectiveidpool.reserved[ level.objectiveidpool.reserved.size ] = objid;
    return objid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x2ba
// Size: 0x7a
function requestobjectiveid( priority )
{
    objid = getnextobjectiveid( priority );
    
    if ( objid == -1 )
    {
        return -1;
    }
    
    entry = spawnstruct();
    entry.priority = priority;
    entry.requesttime = gettime();
    entry.objid = objid;
    level.objectiveidpool.active[ objid ] = entry;
    return objid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x33d
// Size: 0x3f
function function_92a696fa5918eca5( objid )
{
    if ( !objective_isunlimited() )
    {
        return objid;
    }
    
    assert( isdefined( level.var_9977f6e10514d7ce[ objid ] ) );
    return level.var_9977f6e10514d7ce[ objid ].objid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x385
// Size: 0x55
function function_b29f91f1fb14e113( var_5c3b190b45db5f37 )
{
    if ( objective_isunlimited() )
    {
        for ( i = level.var_9977f6e10514d7ce.size; i < var_5c3b190b45db5f37 + 1 ; i++ )
        {
            entry = function_7e41a40db70e23b9();
            level.var_9977f6e10514d7ce[ i ] = entry;
        }
    }
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x3e2
// Size: 0xc0
function removebestobjectiveid( prioritymax )
{
    query = [];
    
    foreach ( objid in level.objectiveidpool.active )
    {
        if ( array_contains( level.objectiveidpool.reserved, objid ) )
        {
            continue;
        }
        
        if ( objid.priority <= prioritymax )
        {
            query[ query.size ] = objid;
        }
    }
    
    array_sort_with_func( query, &comparepriorityandtime );
    return returnobjectiveid( query[ 0 ].objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x4ab
// Size: 0x60
function comparepriorityandtime( a, b )
{
    if ( a.priority == b.priority )
    {
        return ( a.requesttime < b.requesttime );
    }
    
    return a.priority < b.priority;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x513
// Size: 0x16b
function getnextobjectiveid( priority )
{
    if ( objective_isunlimited() )
    {
        return objective_create();
    }
    
    if ( level.objectiveidpool.reclaimed.size == 0 )
    {
        if ( level.objectiveidpool.index >= level.objectiveidpool.limit )
        {
            assertmsg( "No objective IDs available!" );
            return -1;
        }
        else
        {
            nextid = level.objectiveidpool.index;
            level.objectiveidpool.index++;
            
            if ( level.objectiveidpool.index >= level.objectiveidpool.limit )
            {
                level.objectiveidpool.index = level.objectiveidpool.limit - 1;
            }
        }
    }
    else
    {
        nextid = level.objectiveidpool.reclaimed[ level.objectiveidpool.reclaimed.size - 1 ];
        level.objectiveidpool.reclaimed = array_remove_index( level.objectiveidpool.reclaimed, level.objectiveidpool.reclaimed.size - 1 );
    }
    
    return nextid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x687
// Size: 0xda, Type: bool
function returnobjectiveid( objid )
{
    if ( !isdefined( objid ) || objid == -1 )
    {
        return false;
    }
    
    for ( i = 0; i < level.objectiveidpool.reclaimed.size ; i++ )
    {
        if ( objid == level.objectiveidpool.reclaimed[ i ] )
        {
            assertmsg( "ObjID has already been returned!" );
            return false;
        }
    }
    
    level.objectiveidpool.active = array_remove_key( level.objectiveidpool.active, objid );
    level notify( "Objective_Delete", objid );
    objective_delete( objid );
    level.objectiveidpool.reclaimed[ level.objectiveidpool.reclaimed.size ] = objid;
    return true;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x76a
// Size: 0x8e, Type: bool
function returnreservedobjectiveid( objid, var_301ec764dd09b364 )
{
    if ( !isdefined( objid ) || objid == -1 )
    {
        return false;
    }
    
    if ( istrue( var_301ec764dd09b364 ) )
    {
        level.objectiveidpool.active[ objid ] = undefined;
    }
    
    level notify( "Objective_Delete", objid );
    
    if ( objective_isunlimited() )
    {
        if ( isdefined( level.var_9977f6e10514d7ce[ objid ] ) )
        {
            objective_reset( level.var_9977f6e10514d7ce[ objid ].objid );
        }
        else
        {
            objective_reset( objid );
        }
    }
    else
    {
        objective_delete( objid );
    }
    
    return true;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x801
// Size: 0x4b
function private function_7e41a40db70e23b9()
{
    ecsid = objective_create();
    entry = spawnstruct();
    entry.priority = 100;
    entry.requesttime = 0;
    entry.objid = ecsid;
    return entry;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x855
// Size: 0x9b
function private function_be6060bf8a6e12c2( objid )
{
    function_b29f91f1fb14e113( objid );
    assert( isdefined( level.var_9977f6e10514d7ce[ objid ] ) );
    entry = level.var_9977f6e10514d7ce[ objid ];
    entry.requesttime = gettime();
    level.objectiveidpool.active[ objid ] = entry;
    level.objectiveidpool.reserved[ level.objectiveidpool.reserved.size ] = objid;
    return entry.objid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 5
// Checksum 0x0, Offset: 0x8f9
// Size: 0x77
function objective_add( objectivenumber, state, position, iconname, iconsize )
{
    if ( !objective_isunlimited() )
    {
        level notify( "Objective_Delete", objectivenumber );
        objective_delete( objectivenumber );
    }
    
    if ( isdefined( state ) )
    {
        objective_state( objectivenumber, state );
    }
    
    if ( isdefined( position ) )
    {
        objective_position( objectivenumber, position );
    }
    
    if ( isdefined( iconname ) )
    {
        objective_icon( objectivenumber, iconname );
    }
    
    if ( isdefined( iconsize ) )
    {
        objective_setminimapiconsize( objectivenumber, iconsize );
    }
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 5
// Checksum 0x0, Offset: 0x978
// Size: 0x3f
function objective_add_objective( objid, state, position, iconshader, iconsize )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_add( objid, state, position, iconshader, iconsize );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x9bf
// Size: 0x23
function update_objective_ownerteam( objid, ownerteam )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setownerteam( objid, ownerteam );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x9ea
// Size: 0x23
function update_objective_ownerclient( objid, owner )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setownerclient( objid, owner );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xa15
// Size: 0x23
function update_objective_sethot( objid, ownerteam )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_sethot( objid, ownerteam );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xa40
// Size: 0x23
function update_objective_setfriendlylabel( objid, stringref )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setfriendlylabel( objid, stringref );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xa6b
// Size: 0x23
function update_objective_setenemylabel( objid, stringref )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setenemylabel( objid, stringref );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xa96
// Size: 0x23
function update_objective_setneutrallabel( objid, stringref )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setneutrallabel( objid, stringref );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xac1
// Size: 0x23
function update_objective_state( objid, state )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_state( objid, state );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xaec
// Size: 0x23
function update_objective_position( objid, position )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_position( objid, position );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xb17
// Size: 0x23
function update_objective_icon( objid, iconshader )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_icon( objid, iconshader );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xb42
// Size: 0x23
function function_2946e9eb07acb3f1( objid, description )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setdescription( objid, description );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xb6d
// Size: 0x28
function function_c3c6bff089dfdd34( objid, iconsize )
{
    if ( objid == -1 )
    {
        return;
    }
    
    if ( isdefined( iconsize ) )
    {
        objective_setminimapiconsize( objid, iconsize );
    }
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xb9d
// Size: 0x23
function function_79a1a16de6b22b2d( objid, iconshader )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_objectiveid( objid, iconshader );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0xbc8
// Size: 0x1a
function function_56fc9b5845892619( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_reset_objectiveid( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xbea
// Size: 0x23
function update_objective_setbackground( objid, type )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setbackground( objid, type );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xc15
// Size: 0x23
function update_objective_onentity( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_onentity( objid, ent );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xc40
// Size: 0x2c
function update_objective_onentitywithrotation( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_onentity( objid, ent );
    objective_setrotateonminimap( objid, 1 );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xc74
// Size: 0x23
function function_fa3c420e27b5d08b( objid, var_cff8e6dc09cfee61 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setminimapalphafromentity( objid, var_cff8e6dc09cfee61 );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xc9f
// Size: 0x23
function update_objective_setzoffset( objid, offset )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setzoffset( objid, offset );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0xcca
// Size: 0x1a
function function_9cad42ac02eff950( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0xcec
// Size: 0x1a
function function_a28e8535e00d34f3( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addalltomask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0xd0e
// Size: 0x1a
function function_6ae37618bb04ea60( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0xd30
// Size: 0x1a
function function_17db39bd195cc5b1( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_hidefromplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xd52
// Size: 0x31
function objective_playermask_single( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addclienttomask( objid, ent );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xd8b
// Size: 0x31
function objective_teammask_single( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addteamtomask( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0xdc4
// Size: 0x21
function objective_playermask_hidefromall( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addalltomask( objid );
    objective_hidefromplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xded
// Size: 0x2a
function objective_playermask_hidefrom( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeclientfrommask( objid, ent );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xe1f
// Size: 0x2a
function objective_playermask_addshowplayer( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_showtoplayersinmask( objid );
    objective_addclienttomask( objid, ent );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 1
// Checksum 0x0, Offset: 0xe51
// Size: 0x21
function objective_playermask_showtoall( objid )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addalltomask( objid );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xe7a
// Size: 0x3b
function objective_mask_showtoplayerteam( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addteamtomask( objid, ent.team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xebd
// Size: 0x4b
function function_39f2dc4e92db5fb9( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    if ( !isdefined( ent.owner ) )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    objective_addclienttomask( objid, ent.owner );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xf10
// Size: 0x52
function objective_mask_showtoenemyteam( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeallfrommask( objid );
    
    if ( level.teambased )
    {
        objective_addteamtomask( objid, ent.team );
    }
    else
    {
        objective_addclienttomask( objid, ent );
    }
    
    objective_hidefromplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xf6a
// Size: 0x2a
function objective_teammask_addtomask( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_addteamtomask( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xf9c
// Size: 0x2a
function objective_teammask_removefrommask( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_removeteamfrommask( objid, team );
    objective_showtoplayersinmask( objid );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xfce
// Size: 0x23
function objective_pin_global( objid, pin )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setpinned( objid, pin );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0xff9
// Size: 0x23
function objective_pin_team( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_pinforteam( objid, team );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1024
// Size: 0x23
function objective_unpin_team( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_unpinforteam( objid, team );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x104f
// Size: 0x23
function objective_pin_player( objid, player )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_pinforclient( objid, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 3
// Checksum 0x0, Offset: 0x107a
// Size: 0x2b
function objective_unpin_player( objid, player, showoncompass )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_unpinforclient( objid, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 3
// Checksum 0x0, Offset: 0x10ad
// Size: 0x7a
function objective_show_progress( objid, show, unfill )
{
    if ( getdvar( @"scr_br_gametype", "" ) == "dmz" || getdvar( @"scr_br_gametype", "" ) == "exgm" )
    {
        show = 0;
    }
    
    if ( objid == -1 )
    {
        return;
    }
    
    if ( show && !istrue( unfill ) )
    {
        level notify( "Objective_SetShowProgress", objid );
    }
    
    objective_setshowprogress( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x112f
// Size: 0x1b
function function_7299a742781a5030( state, player )
{
    objective_setshowpinnedprogressbar( state, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1152
// Size: 0x1b
function function_8f7a55bda12ebb21( text, player )
{
    objective_setpinnedprogressbartext( text, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1175
// Size: 0x23
function objective_show_team_progress( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_showprogressforteam( objid, team );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x11a0
// Size: 0x23
function objective_hide_team_progress( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_hideprogressforteam( objid, team );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x11cb
// Size: 0x23
function objective_show_player_progress( objid, player )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_showprogressforclient( objid, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x11f6
// Size: 0x23
function objective_hide_player_progress( objid, player )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_hideprogressforclient( objid, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1221
// Size: 0x2a
function objective_set_show_progress( objid, showprogress )
{
    if ( !isdefined( objid ) || objid == -1 )
    {
        return;
    }
    
    objective_setshowprogress( objid, showprogress );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1253
// Size: 0x23
function objective_set_progress( objid, progress )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setprogress( objid, progress );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x127e
// Size: 0x23
function objective_set_progress_team( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setprogressteam( objid, team );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x12a9
// Size: 0x23
function function_9b1a086f348520b0( objid, team )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setclaimingteam( objid, team );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x12d4
// Size: 0x23
function objective_set_progress_client( objid, player )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setprogressclient( objid, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x12ff
// Size: 0x23
function objective_set_play_intro( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setplayintro( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x132a
// Size: 0x23
function objective_set_play_outro( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setplayoutro( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1355
// Size: 0x23
function objective_set_pulsate( objid, pulse )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setpulsate( objid, pulse );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1380
// Size: 0x23
function objective_hide_for_mlg_spectator( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_sethideformlgspectator( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x13ab
// Size: 0x23
function objective_show_for_mlg_spectator( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setshowformlgspectator( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x13d6
// Size: 0x23
function function_d7e3c4a08682c1b9( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_sethideonminimapwhenclipped( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1401
// Size: 0x23
function function_ee37484ca9bdc744( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setshowdirectionindicatorintacmap( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x142c
// Size: 0x23
function function_994c8917a78b024( objid, show )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setshownewnessindicatorintacmap( objid, show );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1457
// Size: 0x23
function function_1513b8ac9570e6c7( objid, var_99d6809da5559c23 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setplayrevealanimintacmap( objid, var_99d6809da5559c23 );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1482
// Size: 0x23
function function_559a49e0dab1f8fc( objid, var_99d6809da5559c23 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setplayrevealaniminminimap( objid, var_99d6809da5559c23 );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x14ad
// Size: 0x23
function function_bf66c6833e867284( objid, type )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setobjectivetype( objid, type );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x14d8
// Size: 0x23
function function_a73941bc42a6e8d3( objid, var_40c8c22e3af690c1 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_sethovercardindex( objid, var_40c8c22e3af690c1 );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 4
// Checksum 0x0, Offset: 0x1503
// Size: 0x43
function function_e6b9c68b99e455ba( objid, var_d3810e59fa78746e, var_a4ce6d25578e2f1f, var_9184ccd844da4630 )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setfriendlyhovercardindex( objid, var_d3810e59fa78746e );
    objective_setenemyhovercardindex( objid, var_a4ce6d25578e2f1f );
    objective_setneutralhovercardindex( objid, var_9184ccd844da4630 );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 6
// Checksum 0x0, Offset: 0x154e
// Size: 0xcb
function createobjective( shadername, team, friendlyonly, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize )
{
    curobjid = function_c1a18d4076f420a5( shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize );
    
    if ( level.teambased )
    {
        if ( isdefined( team ) )
        {
            update_objective_ownerteam( curobjid, team );
        }
    }
    else if ( isdefined( self.owner ) )
    {
        update_objective_ownerclient( curobjid, self.owner );
    }
    
    if ( istrue( friendlyonly ) )
    {
        if ( level.teambased )
        {
            objective_mask_showtoplayerteam( curobjid, self );
        }
        else
        {
            function_39f2dc4e92db5fb9( curobjid, self );
        }
    }
    else
    {
        objective_playermask_showtoall( curobjid );
    }
    
    if ( istrue( level.objvisall ) )
    {
        objective_playermask_showtoall( curobjid );
    }
    
    return curobjid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 4
// Checksum 0x0, Offset: 0x1622
// Size: 0x41
function function_c1a18d4076f420a5( shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize )
{
    curobjid = function_4625d98c8f5bdc94( shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize );
    objective_playermask_hidefromall( curobjid );
    return curobjid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 4
// Checksum 0x0, Offset: 0x166c
// Size: 0xa0
function createobjective_engineer( shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize )
{
    curobjid = undefined;
    createfunc = undefined;
    
    if ( scripts\engine\utility::issharedfuncdefined( "game", "createObjectiveHidden" ) )
    {
        createfunc = scripts\engine\utility::getsharedfunc( "game", "createObjectiveHidden" );
    }
    
    if ( isdefined( createfunc ) && isdefined( level.var_5b12006b920a1b6c ) )
    {
        curobjid = [[ createfunc ]]( level.var_5b12006b920a1b6c, 1, 1, "icon_regular" );
        update_objective_ownerteam( curobjid, self.team );
        return;
    }
    
    return curobjid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 4
// Checksum 0x0, Offset: 0x1714
// Size: 0xd3
function function_4625d98c8f5bdc94( shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize )
{
    curobjid = requestobjectiveid( 10 );
    
    if ( curobjid == -1 )
    {
        return -1;
    }
    
    objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
    
    if ( ( !isent( self ) || !isdefined( self getlinkedparent() ) ) && !istrue( var_2231e5a0f940caae ) )
    {
        update_objective_position( curobjid, self.origin );
    }
    else if ( istrue( var_2231e5a0f940caae ) && istrue( var_dbe22cd5d2a797af ) )
    {
        update_objective_onentitywithrotation( curobjid, self );
    }
    else
    {
        update_objective_onentity( curobjid, self );
    }
    
    update_objective_state( curobjid, "active" );
    update_objective_icon( curobjid, shadername );
    update_objective_setbackground( curobjid, 1 );
    function_c3c6bff089dfdd34( curobjid, iconsize );
    return curobjid;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 3
// Checksum 0x0, Offset: 0x17f0
// Size: 0x6d
function function_160f522b63c32d76( progressbarstate, text, omnvarvalue )
{
    if ( getdvarint( @"hash_141de4492226006e", 1 ) == 1 )
    {
        if ( isdefined( omnvarvalue ) )
        {
        }
        
        function_7299a742781a5030( progressbarstate, self );
        
        if ( isdefined( text ) )
        {
            function_8f7a55bda12ebb21( text, self );
        }
        else
        {
            function_8f7a55bda12ebb21( "", self );
        }
        
        return;
    }
    
    self setclientomnvar( "ui_objective_pinned_text_param", omnvarvalue );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 5
// Checksum 0x0, Offset: 0x1865
// Size: 0x8f
function function_ce702e5925e31fc9( objid, player, priority, state, text )
{
    if ( objid == -1 )
    {
        return;
    }
    
    if ( !isdefined( player.objectivepriority ) )
    {
        player.objectivepriority = 0;
    }
    
    if ( player.objectivepriority < priority )
    {
        player.objectivepriority = priority;
        scripts\mp\objidpoolmanager::objective_show_player_progress( objid, player );
        scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21( text, player );
        scripts\mp\objidpoolmanager::function_7299a742781a5030( state, player );
        return 1;
    }
    
    return 0;
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x18fc
// Size: 0x40
function function_26259bd38697b5ad( objid, player )
{
    if ( objid == -1 || !isdefined( player ) )
    {
        return;
    }
    
    player.objectivepriority = 0;
    scripts\mp\objidpoolmanager::objective_hide_player_progress( objid, player );
    scripts\mp\objidpoolmanager::function_7299a742781a5030( 0, player );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x1944
// Size: 0x23
function function_98ba077848896a3( objid, shouldshow )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setshowdistance( objid, shouldshow );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 3
// Checksum 0x0, Offset: 0x196f
// Size: 0x2c
function function_f21e9b2e78de984b( objid, var_a7c6c5d6c3d369aa, var_467f4d9b8d9063b )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setfadingdistance( objid, var_a7c6c5d6c3d369aa, var_467f4d9b8d9063b );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x19a3
// Size: 0x23
function function_41f90376ab869b9f( objid, shouldhide )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_sethideelevation( objid, shouldhide );
}

// Namespace objidpoolmanager / scripts\mp\objidpoolmanager
// Params 5
// Checksum 0x0, Offset: 0x19ce
// Size: 0x3e
function function_846c2acd91309cd8( objid, r, g, b, active )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_settint( objid, r, g, b, active );
}

