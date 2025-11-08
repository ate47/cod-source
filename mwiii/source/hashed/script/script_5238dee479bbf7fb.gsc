#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace namespace_1a2fa2b6ae5d223c;

// Namespace namespace_1a2fa2b6ae5d223c / namespace_981ad73f8047222f
// Params 0
// Checksum 0x0, Offset: 0x156
// Size: 0xa2
function setupcirclepeek()
{
    if ( istrue( level.br_circle_disabled ) || istrue( level.br_level.staticcircle ) || scripts\mp\gametypes\br_gametypes::isfeatureenabled( "customGametypeCircles" ) )
    {
        return;
    }
    
    assertex( !isdefined( level.circlepeeks ), "<dev string:x1c>" );
    level.circlepeeks = [];
    level.teamswithcirclepeek = [];
    
    for ( index = 1; index < level.br_level.br_circleradii.size ; index++ )
    {
        function_587a4ae46d3a9611( index );
    }
    
    level thread function_27d74f1cf559ca7b();
}

// Namespace namespace_1a2fa2b6ae5d223c / namespace_981ad73f8047222f
// Params 0
// Checksum 0x0, Offset: 0x200
// Size: 0xac
function function_126f8eca2fa7d72()
{
    foreach ( circlepeek in level.circlepeeks )
    {
        foreach ( questcircle in circlepeek.questcircles )
        {
            questcircle function_af5604ce591768e1();
        }
    }
    
    level.circlepeeks = undefined;
}

// Namespace namespace_1a2fa2b6ae5d223c / namespace_981ad73f8047222f
// Params 1
// Checksum 0x0, Offset: 0x2b4
// Size: 0x129
function function_587a4ae46d3a9611( circleindex )
{
    if ( !isdefined( level.circlepeeks ) )
    {
        return;
    }
    
    level.circlepeeks[ circleindex ] = spawnstruct();
    level.circlepeeks[ circleindex ].questcircles = [];
    circleradius = level.br_level.br_circleradii[ circleindex ];
    multicirclecount = scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137();
    
    if ( multicirclecount > 1 )
    {
        circleinfo = level.br_multi_circle;
        
        if ( circleindex < level.br_multi_circle.splitindex || circleindex >= level.br_multi_circle.mergeindex )
        {
            multicirclecount = 1;
        }
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            circleorigin = circleinfo.circles[ i ].circlecenters[ circleindex ];
            function_ec0ff24840e615d5( circleindex, circleorigin, circleradius );
        }
        
        return;
    }
    
    circleorigin = level.br_level.br_circlecenters[ circleindex ];
    function_ec0ff24840e615d5( circleindex, circleorigin, circleradius );
}

// Namespace namespace_1a2fa2b6ae5d223c / namespace_981ad73f8047222f
// Params 3
// Checksum 0x0, Offset: 0x3e5
// Size: 0x8c
function function_ec0ff24840e615d5( circleindex, circleorigin, circleradius )
{
    if ( !isdefined( level.circlepeeks[ circleindex ] ) )
    {
        return;
    }
    
    questcircle = spawnstruct();
    questcircle function_6b6b6273f8180522( "PeekCircle_Br", circleorigin, circleradius );
    questcircle function_4eaf685bc40a3b9();
    size = level.circlepeeks[ circleindex ].questcircles.size;
    level.circlepeeks[ circleindex ].questcircles[ size ] = questcircle;
}

// Namespace namespace_1a2fa2b6ae5d223c / namespace_981ad73f8047222f
// Params 0
// Checksum 0x0, Offset: 0x479
// Size: 0x10d
function function_27d74f1cf559ca7b()
{
    self endon( "game_ended" );
    level endon( "CirclePeekCleanup" );
    
    while ( true )
    {
        level waittill( "br_circle_set" );
        
        foreach ( questcircle in level.circlepeeks[ level.br_circle.circleindex + 1 ].questcircles )
        {
            questcircle function_af5604ce591768e1();
        }
        
        foreach ( team in getarraykeys( level.teamswithcirclepeek ) )
        {
            level.teamswithcirclepeek[ team ]--;
            
            if ( level.teamswithcirclepeek[ team ] < 0 )
            {
                level.teamswithcirclepeek[ team ] = 0;
            }
        }
    }
}

// Namespace namespace_1a2fa2b6ae5d223c / namespace_981ad73f8047222f
// Params 1
// Checksum 0x0, Offset: 0x58e
// Size: 0x2d5
function function_647a8c40104e4866( team )
{
    if ( istrue( level.br_circle_disabled ) )
    {
        return;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ team ] ) )
    {
        level.teamswithcirclepeek[ team ] = 0;
    }
    
    var_f33d844d70bc5292 = -1;
    
    if ( level.teamswithcirclepeek[ team ] == 0 )
    {
        buffertime = getdvarint( @"hash_a8b73338df20273", 15 );
        
        if ( buffertime >= scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7() )
        {
            level.teamswithcirclepeek[ team ]++;
            var_f33d844d70bc5292 = level.teamswithcirclepeek[ team ] + level.br_circle.circleindex + 1;
        }
    }
    
    level.teamswithcirclepeek[ team ]++;
    index = level.teamswithcirclepeek[ team ] + level.br_circle.circleindex + 1;
    
    if ( !isdefined( level.circlepeeks[ index ] ) )
    {
        foreach ( player in getteamdata( team, "players" ) )
        {
            if ( var_f33d844d70bc5292 != -1 && isdefined( level.circlepeeks[ var_f33d844d70bc5292 ] ) )
            {
                foreach ( questcircle in level.circlepeeks[ var_f33d844d70bc5292 ].questcircles )
                {
                    questcircle function_cfd53c8f6878014f( player );
                }
            }
            
            player scripts\mp\utility\lower_message::setlowermessageomnvar( "circle_peek_limit", undefined, 5 );
        }
        
        return;
    }
    
    foreach ( player in getteamdata( team, "players" ) )
    {
        foreach ( questcircle in level.circlepeeks[ index ].questcircles )
        {
            questcircle function_cfd53c8f6878014f( player );
        }
        
        if ( var_f33d844d70bc5292 != -1 )
        {
            foreach ( questcircle in level.circlepeeks[ var_f33d844d70bc5292 ].questcircles )
            {
                questcircle function_cfd53c8f6878014f( player );
            }
        }
    }
}

// Namespace namespace_1a2fa2b6ae5d223c / namespace_981ad73f8047222f
// Params 2
// Checksum 0x0, Offset: 0x86b
// Size: 0x180
function function_b8022b0e5e976f66( oldteam, newteam )
{
    if ( istrue( level.br_circle_disabled ) )
    {
        return;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ oldteam ] ) )
    {
        level.teamswithcirclepeek[ oldteam ] = 0;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ newteam ] ) )
    {
        level.teamswithcirclepeek[ newteam ] = 0;
    }
    
    if ( level.teamswithcirclepeek[ oldteam ] > level.teamswithcirclepeek[ newteam ] )
    {
        level.teamswithcirclepeek[ newteam ] = level.teamswithcirclepeek[ oldteam ];
    }
    
    index = level.teamswithcirclepeek[ newteam ] + level.br_circle.circleindex + 1;
    
    if ( !isdefined( level.circlepeeks[ index ] ) )
    {
        return;
    }
    
    foreach ( player in getteamdata( newteam, "players" ) )
    {
        foreach ( questcircle in level.circlepeeks[ index ].questcircles )
        {
            questcircle function_cfd53c8f6878014f( player );
        }
    }
}

