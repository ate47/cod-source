#using scripts\mp\hud_util;

#namespace objpoints;

// Namespace objpoints / scripts\mp\objpoints
// Params 0
// Checksum 0x0, Offset: 0xc3
// Size: 0x62
function init()
{
    precacheshader( "objpoint_default" );
    level.objpointnames = [];
    level.objpoints = [];
    
    if ( level.splitscreen )
    {
        level.objpointsize = 15;
    }
    else
    {
        level.objpointsize = 8;
    }
    
    level.objpoint_alpha_default = 0.75;
    level.objpointscale = 1;
}

// Namespace objpoints / scripts\mp\objpoints
// Params 6
// Checksum 0x0, Offset: 0x12d
// Size: 0x14f
function createteamobjpoint( index, origin, team, shader, alpha, scale )
{
    assert( team == "<dev string:x1c>" );
    
    if ( !isdefined( shader ) )
    {
        shader = "objpoint_default";
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    objpoint = undefined;
    
    if ( team != "all" )
    {
        objpoint = newteamhudelem( team );
    }
    else
    {
        objpoint = newhudelem();
    }
    
    objpoint.id = index;
    objpoint.x = origin[ 0 ];
    objpoint.y = origin[ 1 ];
    objpoint.z = origin[ 2 ];
    objpoint.team = team;
    objpoint.isflashing = 0;
    objpoint.isshown = 1;
    objpoint setshader( shader, level.objpointsize, level.objpointsize );
    objpoint setwaypoint( 1, 0 );
    
    if ( isdefined( alpha ) )
    {
        objpoint.alpha = alpha;
    }
    else
    {
        objpoint.alpha = level.objpoint_alpha_default;
    }
    
    objpoint.basealpha = objpoint.alpha;
    return objpoint;
}

// Namespace objpoints / scripts\mp\objpoints
// Params 1
// Checksum 0x0, Offset: 0x285
// Size: 0x11e
function deleteobjpoint( var_2f8b2ff7e0389b27 )
{
    assert( level.objpoints.size == level.objpointnames.size );
    
    if ( level.objpoints.size == 1 )
    {
        assert( level.objpointnames[ 0 ] == var_2f8b2ff7e0389b27.name );
        assert( isdefined( level.objpoints[ var_2f8b2ff7e0389b27.name ] ) );
        level.objpoints = [];
        level.objpointnames = [];
        var_2f8b2ff7e0389b27 destroy();
        return;
    }
    
    newindex = var_2f8b2ff7e0389b27.index;
    oldindex = level.objpointnames.size - 1;
    objpoint = getobjpointbyindex( oldindex );
    level.objpointnames[ newindex ] = objpoint.name;
    objpoint.index = newindex;
    level.objpointnames[ oldindex ] = undefined;
    level.objpoints[ var_2f8b2ff7e0389b27.name ] = undefined;
    var_2f8b2ff7e0389b27 destroy();
}

// Namespace objpoints / scripts\mp\objpoints
// Params 1
// Checksum 0x0, Offset: 0x3ab
// Size: 0x63
function updateorigin( origin )
{
    if ( self.x != origin[ 0 ] )
    {
        self.x = origin[ 0 ];
    }
    
    if ( self.y != origin[ 1 ] )
    {
        self.y = origin[ 1 ];
    }
    
    if ( self.z != origin[ 2 ] )
    {
        self.z = origin[ 2 ];
    }
}

// Namespace objpoints / scripts\mp\objpoints
// Params 2
// Checksum 0x0, Offset: 0x416
// Size: 0x2f
function setoriginbyname( name, origin )
{
    objpoint = getobjpointbyname( name );
    objpoint updateorigin( origin );
}

// Namespace objpoints / scripts\mp\objpoints
// Params 1
// Checksum 0x0, Offset: 0x44d
// Size: 0x2b
function getobjpointbyname( name )
{
    if ( isdefined( level.objpoints[ name ] ) )
    {
        return level.objpoints[ name ];
    }
    
    return undefined;
}

// Namespace objpoints / scripts\mp\objpoints
// Params 1
// Checksum 0x0, Offset: 0x480
// Size: 0x35
function getobjpointbyindex( index )
{
    if ( isdefined( level.objpointnames[ index ] ) )
    {
        return level.objpoints[ level.objpointnames[ index ] ];
    }
    
    return undefined;
}

// Namespace objpoints / scripts\mp\objpoints
// Params 0
// Checksum 0x0, Offset: 0x4bd
// Size: 0x90
function startflashing()
{
    self endon( "stop_flashing_thread" );
    
    if ( self.isflashing )
    {
        return;
    }
    
    self.isflashing = 1;
    
    while ( self.isflashing )
    {
        self fadeovertime( 0.75 );
        self.alpha = 0.35 * self.basealpha;
        wait 0.75;
        self fadeovertime( 0.75 );
        self.alpha = self.basealpha;
        wait 0.75;
    }
    
    self.alpha = self.basealpha;
}

// Namespace objpoints / scripts\mp\objpoints
// Params 0
// Checksum 0x0, Offset: 0x555
// Size: 0x19
function stopflashing()
{
    if ( !self.isflashing )
    {
        return;
    }
    
    self.isflashing = 0;
}

