#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;

#namespace namespace_cf4ab64c2f83d096;

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 0
// Checksum 0x0, Offset: 0x17c
// Size: 0x2c
function function_8d0bcd24e525ca55()
{
    level.var_4b646b4bf1c0cd01 = spawnstruct();
    level.var_4b646b4bf1c0cd01.waypoints = [];
    function_bceadb844cbe69ca();
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1b0
// Size: 0x13
function private function_bceadb844cbe69ca()
{
    add_fx( "ftue_objectives_waypoint_fx", "vfx/misc/vfx_ftue_ring_01" );
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 6
// Checksum 0x0, Offset: 0x1cb
// Size: 0xa3
function function_e5524fb8509827bf( objectiveposition, labeltext, icon, zoffset, owner, showwaypoint )
{
    if ( !isdefined( objectiveposition ) )
    {
        objectiveposition = ( 0, 0, 0 );
    }
    
    waypointdata = spawnstruct();
    waypointdata.showwaypoint = istrue( showwaypoint );
    waypointdata.position = objectiveposition;
    waypointdata.owner = owner;
    objectiveid = function_15379e7d5a0b111a( labeltext, icon, zoffset, undefined, owner, waypointdata );
    objective_position( objectiveid, objectiveposition );
    return objectiveid;
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 6
// Checksum 0x0, Offset: 0x277
// Size: 0xc7
function function_70e0de6281199e7( objectivetarget, labeltext, icon, zoffset, owner, showwaypoint )
{
    waypointdata = spawnstruct();
    waypointdata.showwaypoint = istrue( showwaypoint );
    waypointdata.position = objectivetarget.origin;
    waypointdata.owner = owner;
    team = undefined;
    
    if ( isplayer( objectivetarget ) )
    {
        team = objectivetarget.team;
    }
    
    objectiveid = function_15379e7d5a0b111a( labeltext, icon, zoffset, team, owner, waypointdata );
    objective_onentity( objectiveid, objectivetarget );
    objectivetarget.objectiveid = objectiveid;
    return objectiveid;
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x347
// Size: 0xf8
function private function_15379e7d5a0b111a( labeltext, icon, zoffset, team, owner, waypointdata )
{
    objectiveid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    objective_state( objectiveid, "current" );
    objective_icon( objectiveid, icon );
    objective_setminimapiconsize( objectiveid, "icon_regular" );
    objective_setbackground( objectiveid, 1 );
    objective_setshowdistance( objectiveid, !isdefined( team ) );
    objective_setfadedisabled( objectiveid, 1 );
    
    if ( isdefined( labeltext ) )
    {
        objective_setlabel( objectiveid, labeltext );
    }
    
    objective_setzoffset( objectiveid, zoffset );
    objective_setwidget( objectiveid, "mobileftueobjective" );
    
    if ( isdefined( team ) )
    {
        objective_setownerteam( objectiveid, team );
        objective_addalltomask( objectiveid );
    }
    
    if ( isdefined( owner ) )
    {
        objective_removeallfrommask( objectiveid );
        objective_addclienttomask( objectiveid, owner );
        objective_showtoplayersinmask( objectiveid );
        owner thread function_127d9ad4836a083d( objectiveid );
    }
    
    if ( istrue( waypointdata.showwaypoint ) )
    {
        function_f36e91aa37d197c3( objectiveid, waypointdata );
    }
    
    return objectiveid;
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x448
// Size: 0x7d
function private function_f36e91aa37d197c3( objectiveid, waypointdata )
{
    assertex( isdefined( waypointdata.owner ), "<dev string:x1c>" );
    waypoint = spawnfxforclient( getfx( "ftue_objectives_waypoint_fx" ), waypointdata.position, waypointdata.owner );
    triggerfx( waypoint );
    level.var_4b646b4bf1c0cd01.waypoints[ objectiveid ] = waypoint;
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 1
// Checksum 0x0, Offset: 0x4cd
// Size: 0x1d
function function_b30874d13004d4c5( objectivetarget )
{
    function_4d03b9ef456d0972( objectivetarget.objectiveid );
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 1
// Checksum 0x0, Offset: 0x4f2
// Size: 0x25
function function_4d03b9ef456d0972( objectiveid )
{
    level notify( "ftue_objective_removed_" + objectiveid );
    scripts\mp\objidpoolmanager::returnobjectiveid( objectiveid );
    function_b93e49439785c073( objectiveid );
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x51f
// Size: 0x40
function private function_b93e49439785c073( objectiveid )
{
    if ( !isdefined( level.var_4b646b4bf1c0cd01.waypoints[ objectiveid ] ) )
    {
        return;
    }
    
    level.var_4b646b4bf1c0cd01.waypoints[ objectiveid ] delete();
}

// Namespace namespace_cf4ab64c2f83d096 / namespace_2e77b62bcb3c8d4b
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x567
// Size: 0x51
function private function_127d9ad4836a083d( objectiveid )
{
    player = self;
    player endon( "disconnect" );
    level endon( "game_ended" );
    level endon( "ftue_objective_removed_" + objectiveid );
    player waittill_any_return_2( "currentContextualTipCompleted", "currentContextualTipAborted" );
    scripts\mp\objidpoolmanager::returnobjectiveid( objectiveid );
    function_b93e49439785c073( objectiveid );
}

