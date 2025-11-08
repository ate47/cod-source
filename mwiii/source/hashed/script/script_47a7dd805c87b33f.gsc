#using script_32d93a194074fa6a;
#using script_5dfa1fb6b030bdcb;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_ac3046f64a1306ea;

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 1
// Checksum 0x0, Offset: 0x216
// Size: 0x150
function function_e27c8ead6ab015fa( var_a45669cf75867ed7 )
{
    if ( !isdefined( var_a45669cf75867ed7 ) )
    {
        return;
    }
    
    spawnedwalls = [];
    
    foreach ( wall in var_a45669cf75867ed7 )
    {
        var_9f711536be9153eb = [];
        var_9f711536be9153eb = array_add( var_9f711536be9153eb, function_f74cacfd2004dc6d( wall[ 0 ], wall[ 1 ], wall[ 2 ] ) );
        direction = anglestoleft( wall[ 2 ] );
        directionnormalized = vectornormalize( direction ) * ( 1, 1, 0 );
        
        switch ( wall[ 0 ] )
        {
            case #"hash_3ad7f4106022290a":
                var_e2622d8d804c74f6 = directionnormalized * 192;
                break;
            case #"hash_671771ce3aeca79a":
                var_e2622d8d804c74f6 = directionnormalized * 64;
                break;
            default:
                var_e2622d8d804c74f6 = directionnormalized * 192;
                break;
        }
        
        for ( i = 1; i < wall[ 3 ] ; i++ )
        {
            var_9f711536be9153eb = array_add( var_9f711536be9153eb, function_f74cacfd2004dc6d( wall[ 0 ], wall[ 1 ] + var_e2622d8d804c74f6 * i, wall[ 2 ] ) );
        }
        
        spawnedwalls = array_add( spawnedwalls, var_9f711536be9153eb );
    }
    
    return spawnedwalls;
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 3
// Checksum 0x0, Offset: 0x36f
// Size: 0x46
function function_f74cacfd2004dc6d( scriptable, position, rotation )
{
    return spawnscriptable( level.ftuedata.wallsinfo.scriptables[ getxhash( scriptable ) ], position, rotation );
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 1
// Checksum 0x0, Offset: 0x3be
// Size: 0x9a
function function_8ec6ff395f428891( var_a45669cf75867ed7 )
{
    foreach ( walls in var_a45669cf75867ed7 )
    {
        foreach ( wall in walls )
        {
            function_7a423436aaaf2e58( wall );
        }
    }
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 1
// Checksum 0x0, Offset: 0x460
// Size: 0x24
function function_7a423436aaaf2e58( wall )
{
    wall.origin = ( 0, 0, 0 );
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 0
// Checksum 0x0, Offset: 0x48c
// Size: 0xa4
function function_de1acb2ec7807e38()
{
    if ( !isdefined( level.ftuedata.var_e82a930c823a7b9c ) )
    {
        return;
    }
    
    foreach ( asset in level.ftuedata.var_e82a930c823a7b9c )
    {
        spawnscriptable( level.ftuedata.var_a1c8c05e25923460.scriptables[ getxhash( asset[ 0 ] ) ], asset[ 1 ], asset[ 2 ] );
    }
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 3
// Checksum 0x0, Offset: 0x538
// Size: 0x1b3
function function_fe4aefebd9992d47( var_ded14ae1ea8c4446, placemarks, objectivetext )
{
    if ( placemarks )
    {
        foreach ( enemybot in var_ded14ae1ea8c4446 )
        {
            level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity function_4148171500445ead( objectivetext );
        }
    }
    
    var_b599e3f9981dec25 = 0;
    
    while ( var_b599e3f9981dec25 < var_ded14ae1ea8c4446.size )
    {
        foreach ( enemybot in var_ded14ae1ea8c4446 )
        {
            if ( isdefined( level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity ) && level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity.health <= 0 )
            {
                var_b599e3f9981dec25++;
                function_b30874d13004d4c5( level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity );
                level.ftuedata.enemybots[ getxhash( enemybot ) ] notify( "death_or_disconnect" );
                level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 1
// Checksum 0x0, Offset: 0x6f3
// Size: 0x7b
function function_4148171500445ead( objectivetext )
{
    objectivelabel = undefined;
    markeroffset = getdvarint( @"hash_7e3a7d1b515ef19e", 77 );
    
    if ( isdefined( objectivetext ) )
    {
        switch ( objectivetext )
        {
            case #"hash_e810fefe7ef7f725":
                objectivelabel = &"FTUE_MOBILE/SHOOT_TEST";
                break;
            case #"hash_f850836c8bee4d31":
                objectivelabel = &"FTUE_MOBILE/SHOOT_ADS_TEST";
                break;
        }
    }
    
    function_70e0de6281199e7( self, objectivelabel, "mgl_ui_icon_ping_tacmap_enemy", markeroffset );
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 3
// Checksum 0x0, Offset: 0x776
// Size: 0x9e
function function_191d4de725937c3( position, spawndelay, var_fc5aaa4c4a896663 )
{
    if ( !isdefined( level.ftuedata.marksinfo.var_7520d86455f99294 ) )
    {
        return;
    }
    
    if ( isdefined( spawndelay ) )
    {
        wait spawndelay;
    }
    
    level.ftuedata.var_3c5ef1ed040af91c.var_7520d86455f99294.origin = position + ( 0, 0, level.ftuedata.var_3c5ef1ed040af91c.var_8535c66bd370de4b );
    
    if ( isdefined( var_fc5aaa4c4a896663 ) )
    {
        level thread function_4da0c02be23df7d( position, var_fc5aaa4c4a896663 );
    }
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x81c
// Size: 0x60
function private function_4da0c02be23df7d( position, var_fc5aaa4c4a896663 )
{
    level endon( "stop_dynamic_mark" );
    
    while ( true )
    {
        if ( distance( level.player.origin, position ) < var_fc5aaa4c4a896663 )
        {
            function_191d4de725937c3( ( 0, 0, 0 ) );
        }
        else
        {
            function_191d4de725937c3( position );
        }
        
        waitframe();
    }
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 6
// Checksum 0x0, Offset: 0x884
// Size: 0xb9
function function_8e8398e14bc1f418( triggerorigin, triggerradius, triggerheight, objectivetext, objectiveicon, objectivezoffset )
{
    trigger = spawn( "trigger_radius", triggerorigin, 0, triggerradius, triggerheight );
    trigger.radius = triggerradius;
    trigger.height = triggerheight;
    
    if ( isdefined( objectivetext ) && isdefined( objectiveicon ) && isdefined( objectivezoffset ) )
    {
        objectiveid = function_e5524fb8509827bf( triggerorigin, objectivetext, objectiveicon, objectivezoffset );
        trigger.objectiveid = objectiveid;
    }
    
    if ( getdvarint( @"hash_66535d0f1ce2e9ff", 0 ) )
    {
        trigger thread function_5557a3c447c06db9();
    }
    
    return trigger;
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x946
// Size: 0x52
function private function_5557a3c447c06db9()
{
    self endon( "entitydeleted" );
    
    while ( getdvarint( @"hash_66535d0f1ce2e9ff", 0 ) )
    {
        scripts\engine\utility::draw_capsule( self.origin, self.radius, self.height, undefined, ( 1, 0, 0 ), 0, 1 );
        waitframe();
    }
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 1
// Checksum 0x0, Offset: 0x9a0
// Size: 0x24
function function_167d907cc0817d4( triggerentity )
{
    function_4d03b9ef456d0972( triggerentity.objectiveid );
    triggerentity delete();
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 2
// Checksum 0x0, Offset: 0x9cc
// Size: 0x65
function function_a52fb2b2cd1bcefa( originalstartpoint, originalstartangles )
{
    if ( isdefined( level.ftuedata.playerstartingposition ) )
    {
        return [ level.ftuedata.playerstartingposition, level.ftuedata.var_9d94e563e4be46b8 ];
    }
    
    return [ originalstartpoint, originalstartangles ];
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 1
// Checksum 0x0, Offset: 0xa3a
// Size: 0x46
function function_1be67d0cda80cbd4( abortcallback )
{
    self endon( "currentContextualTipCompleted" );
    self endon( "currentContextualTipAbortEnded" );
    self waittill( "currentContextualTipAborted" );
    
    if ( isdefined( abortcallback ) )
    {
        self [[ abortcallback ]]();
    }
    
    function_6fba31415caeee6e( 0, level.ftuedata.var_f09f2ffd8a67fe03 );
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 3
// Checksum 0x0, Offset: 0xa88
// Size: 0x6b
function function_7fdf3cf66304f3c5( player, waitingtime, optionalcallback )
{
    player endon( "currentContextualTipCompleted" );
    player endon( "currentContextualTipAborted" );
    player endon( "currentContextualTipAbortEnded" );
    
    /#
        overridetime = getdvarint( @"hash_2fa12b4488f98d13", 0 );
        
        if ( overridetime != 0 )
        {
            waitingtime = overridetime;
        }
    #/
    
    player thread function_1be67d0cda80cbd4( optionalcallback );
    wait waitingtime;
    player notify( "currentContextualTipAborted" );
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 1
// Checksum 0x0, Offset: 0xafb
// Size: 0x13
function function_81771105fc1a47cb( player )
{
    player notify( "currentContextualTipAbortEnded" );
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 3
// Checksum 0x0, Offset: 0xb16
// Size: 0xd2
function function_c0e79dfb73eaae6a( shader_name, start_alpha, player )
{
    if ( isdefined( player ) )
    {
        overlay = newclienthudelem( player );
    }
    else
    {
        overlay = newhudelem();
    }
    
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( shader_name, 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    return overlay;
}

// Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
// Params 2
// Checksum 0x0, Offset: 0xbf1
// Size: 0x49
function spawncamera( pos, angles )
{
    cameraent = spawn( "script_model", pos );
    
    if ( isdefined( angles ) )
    {
        cameraent.angles = angles;
    }
    
    cameraent setmodel( "tag_origin" );
    return cameraent;
}

/#

    // Namespace namespace_ac3046f64a1306ea / namespace_c7fbb8d68025450d
    // Params 1
    // Checksum 0x0, Offset: 0xc43
    // Size: 0x65, Type: dev
    function printtoscreen( message )
    {
        if ( getdvarint( @"hash_5bcd0aca8a94e5a7", 0 ) == 0 )
        {
            return;
        }
        
        if ( isdefined( message ) )
        {
            starttime = gettime();
            
            while ( gettime() - starttime <= 2000 )
            {
                printtoscreen2d( 10, 200, message, ( 1, 1, 1 ), 2 );
                waitframe();
            }
        }
    }

#/
