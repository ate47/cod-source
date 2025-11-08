#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace objectives;

// Namespace objectives / scripts\engine\sp\objectives
// Params 13
// Checksum 0x0, Offset: 0x4e9
// Size: 0x13e
function objective_add( objectivename, objstate, objposition, objdescription, objlabel, objiconname, objzoffset, objshowdistance, objshowprogress, objshowsplash, objscreenoffsety, objisoptional, var_d85ab98698be6559 )
{
    _objective_validatename( objectivename );
    _objective_initindexforname( objectivename );
    objective_update( objectivename, objstate, objposition, objdescription, objlabel, objiconname, objzoffset, objshowdistance, objshowprogress, objscreenoffsety );
    objshowsplash = default_to( objshowsplash, 1 );
    
    if ( istrue( objshowsplash ) && isdefined( objdescription ) && isdefined( level.objectives_splash ) && isdefined( level.objectives_splash.callback ) )
    {
        objcomplete = 0;
        var_71bb4595bfba1caf = 0;
        level.player [[ level.objectives_splash.callback ]]( objectivename, objdescription, objcomplete, var_71bb4595bfba1caf, var_d85ab98698be6559 );
    }
    
    objisoptional = default_to( objisoptional, 0 );
    
    if ( istrue( objisoptional ) )
    {
        objectiveindex = _objective_getindexforname( objectivename );
        objective_setisoptional( objectiveindex, objisoptional );
    }
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x62f
// Size: 0x33
function function_1a7f32a7c56ad4e0( callback_func )
{
    assert( isdefined( level.objectives_splash ) );
    level.objectives_splash.callback = callback_func;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 11
// Checksum 0x0, Offset: 0x66a
// Size: 0x143
function objective_update( objectivename, objstate, objposition, objdescription, objlabel, objiconname, objzoffset, objshowdistance, objshowprogress, objscreenoffsety, entitytag )
{
    _objective_validatename( objectivename );
    assertex( objective_exists( objectivename ), "Objective with name " + objectivename + " doesn't exist!" );
    
    if ( isdefined( objstate ) )
    {
        objective_set_state( objectivename, objstate );
    }
    
    if ( isdefined( objposition ) )
    {
        if ( isent( objposition ) )
        {
            objective_set_on_entity( objectivename, objectivename, objposition );
            
            if ( isdefined( entitytag ) )
            {
                function_5e1102ec9d97ed2c( objectivename, entitytag );
            }
        }
        else
        {
            objective_set_position( objectivename, objposition );
        }
    }
    
    if ( isdefined( objdescription ) )
    {
        objective_set_description( objectivename, objdescription );
    }
    
    if ( isdefined( objlabel ) )
    {
        objective_set_label( objectivename, objlabel );
    }
    
    if ( isdefined( objiconname ) )
    {
        objective_set_icon( objectivename, objiconname );
    }
    
    if ( isdefined( objzoffset ) )
    {
        objective_set_z_offset( objectivename, objzoffset );
    }
    
    if ( isdefined( objshowdistance ) )
    {
        objective_set_show_distance( objectivename, objshowdistance );
    }
    
    if ( isdefined( objshowprogress ) )
    {
        objective_set_show_progress( objectivename, objshowprogress );
    }
    
    if ( isdefined( objscreenoffsety ) )
    {
        function_ff959ec1bd44c166( objectivename, objscreenoffsety );
    }
    
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x7b5
// Size: 0x47
function objective_remove( objectivename )
{
    assert( objective_exists( objectivename ) );
    objectiveindex = _objective_getindexforname( objectivename );
    level.objective_array[ objectiveindex ] = undefined;
    objective_delete( objectiveindex );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x804
// Size: 0x8d, Type: bool
function objective_exists( objectivename )
{
    _objective_validatename( objectivename );
    
    if ( isdefined( level.objective_array ) )
    {
        foreach ( objective in level.objective_array )
        {
            if ( isdefined( objective.objectivename ) && objective.objectivename == objectivename )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 3
// Checksum 0x0, Offset: 0x89a
// Size: 0xc8
function objective_complete( objectivename, objshowsplash, objdescription )
{
    assertex( objective_exists( objectivename ), "Objective with name " + objectivename + " doesn't exist!" );
    objective_set_state( objectivename, "done" );
    objshowsplash = default_to( objshowsplash, 0 );
    
    if ( istrue( objshowsplash ) && isdefined( level.objectives_splash ) && isdefined( level.objectives_splash.callback ) )
    {
        objcomplete = 1;
        var_71bb4595bfba1caf = 0;
        level.player [[ level.objectives_splash.callback ]]( objectivename, objdescription, objcomplete, var_71bb4595bfba1caf );
    }
    
    objectiveindex = _objective_getindexforname( objectivename );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 4
// Checksum 0x0, Offset: 0x96a
// Size: 0xa7
function objective_show_progress( objectivename, objdescription, var_71bb4595bfba1caf, var_d85ab98698be6559 )
{
    assertex( objective_exists( objectivename ), "Objective with name " + objectivename + " doesn't exist!" );
    
    if ( isdefined( level.objectives_splash ) && isdefined( level.objectives_splash.callback ) )
    {
        objcomplete = 0;
        level.player [[ level.objectives_splash.callback ]]( objectivename, objdescription, objcomplete, var_71bb4595bfba1caf, var_d85ab98698be6559 );
    }
    
    objectiveindex = _objective_getindexforname( objectivename );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xa19
// Size: 0xa9
function objective_set_state( objectivename, objstate )
{
    _objective_validatename( objectivename );
    assert( isstring( objstate ) );
    assertex( objstate == "empty" || objstate == "active" || objstate == "invisible" || objstate == "done" || objstate == "current" || objstate == "failed", "Invalid state: " + objstate + ". Valid states are 'empty', 'active', 'invisible', 'done', 'current' and 'failed'" );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_state( objectiveindex, objstate );
    level notify( "objectives_updated" );
    level notify( "objectives_updated_state", objstate );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xaca
// Size: 0x4c
function objective_set_position( objectivename, objposition )
{
    _objective_validatename( objectivename );
    assert( isvector( objposition ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_position( objectiveindex, objposition );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xb1e
// Size: 0x56
function objective_set_description( objectivename, objdescription )
{
    _objective_validatename( objectivename );
    assert( isstring( objdescription ) || isistring( objdescription ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setdescription( objectiveindex, objdescription );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xb7c
// Size: 0x56
function objective_set_label( objectivename, objlabel )
{
    _objective_validatename( objectivename );
    assert( isstring( objlabel ) || isistring( objlabel ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setlabel( objectiveindex, objlabel );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xbda
// Size: 0x4c
function objective_set_icon( objectivename, objiconname )
{
    _objective_validatename( objectivename );
    assert( isstring( objiconname ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_icon( objectiveindex, objiconname );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xc2e
// Size: 0x56
function objective_set_z_offset( objectivename, objzoffset )
{
    _objective_validatename( objectivename );
    assert( isint( objzoffset ) || isfloat( objzoffset ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setzoffset( objectiveindex, objzoffset );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xc8c
// Size: 0x56
function function_ff959ec1bd44c166( objectivename, objscreenoffsety )
{
    _objective_validatename( objectivename );
    assert( isint( objscreenoffsety ) || isfloat( objscreenoffsety ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setscreenoffsety( objectiveindex, objscreenoffsety );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0xcea
// Size: 0x1d
function function_3234e40df03b0a40( objectivename )
{
    _objective_validatename( objectivename );
    function_ff959ec1bd44c166( objectivename, -55 );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0xd0f
// Size: 0x2a
function function_54586a40e8a00778( objectivename )
{
    _objective_validatename( objectivename );
    function_5e1102ec9d97ed2c( objectivename, "j_head" );
    objective_set_z_offset( objectivename, 25 );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xd41
// Size: 0x4c
function objective_set_show_distance( objectivename, objshowdistance )
{
    _objective_validatename( objectivename );
    assert( isint( objshowdistance ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setshowdistance( objectiveindex, objshowdistance );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xd95
// Size: 0x4c
function objective_set_show_progress( objectivename, objshowprogress )
{
    _objective_validatename( objectivename );
    assert( isint( objshowprogress ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setshowprogress( objectiveindex, objshowprogress );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xde9
// Size: 0x44
function function_cd6027322dca40( objectivename, objmarked )
{
    _objective_validatename( objectivename );
    assert( isint( objmarked ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setmarked( objectiveindex, objmarked );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 3
// Checksum 0x0, Offset: 0xe35
// Size: 0x9c
function objective_set_on_entity( objectivename, locationname, locationentity )
{
    _objective_validatename( objectivename );
    assert( isent( locationentity ) );
    objectiveindex = _objective_getindexforname( objectivename );
    
    if ( level.objective_array[ objectiveindex ].locations.size > 0 )
    {
        error( "Calling this function while having locations set is scary. OnEntity always takes the first index." );
        objective_remove_all_locations( objectivename );
    }
    
    level.objective_array[ objectiveindex ].locations[ 0 ] = locationname;
    objective_onentity( objectiveindex, locationentity );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xed9
// Size: 0x56
function function_5e1102ec9d97ed2c( objectivename, entitytag )
{
    _objective_validatename( objectivename );
    assert( isstring( entitytag ) || isistring( entitytag ) );
    objectiveindex = _objective_getindexforname( objectivename );
    objective_setentitytag( objectiveindex, entitytag );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 3
// Checksum 0x0, Offset: 0xf37
// Size: 0x34
function objective_add_location_entity( objectivename, locationname, locationentity )
{
    assert( isent( locationentity ) );
    _objective_addlocation( objectivename, locationname, locationentity );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 3
// Checksum 0x0, Offset: 0xf73
// Size: 0x34
function objective_add_location_position( objectivename, locationname, locationposition )
{
    assert( isvector( locationposition ) );
    _objective_addlocation( objectivename, locationname, locationposition );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0xfaf
// Size: 0x111
function objective_remove_location( objectivename, locationname )
{
    assert( objective_exists( objectivename ) );
    assert( isstring( locationname ) );
    objectivelocationindex = -1;
    objectiveindex = _objective_getindexforname( objectivename );
    objectivelocations = level.objective_array[ objectiveindex ].locations;
    
    foreach ( location in objectivelocations )
    {
        if ( isdefined( location ) && location == locationname )
        {
            objectivelocationindex = locationindex;
            break;
        }
    }
    
    assertex( objectivelocationindex >= 0, "The location - " + locationname + " - was not defined for objective: " + objectivename );
    level.objective_array[ objectiveindex ].locations[ objectivelocationindex ] = undefined;
    objective_unsetlocation( objectiveindex, objectivelocationindex );
    level notify( "objectives_updated", "location" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0x10c8
// Size: 0xcb, Type: bool
function function_9ecf0d4a951abebf( objectivename, locationname )
{
    assert( objective_exists( objectivename ) );
    assert( isstring( locationname ) );
    objectivelocationindex = -1;
    objectiveindex = _objective_getindexforname( objectivename );
    objectivelocations = level.objective_array[ objectiveindex ].locations;
    
    foreach ( location in objectivelocations )
    {
        if ( isdefined( location ) && location == locationname )
        {
            objectivelocationindex = locationindex;
            break;
        }
    }
    
    return objectivelocationindex >= 0;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x119c
// Size: 0x6d
function objective_remove_all_locations( objectivename )
{
    assert( objective_exists( objectivename ) );
    objectiveindex = _objective_getindexforname( objectivename );
    
    for ( locationindex = 0; locationindex < 8 ; locationindex++ )
    {
        objective_unsetlocation( objectiveindex, locationindex );
    }
    
    level.objective_array[ objectiveindex ].locations = [];
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x1211
// Size: 0x21
function function_ab69b0fe7021a308( scaledistance )
{
    if ( !isdefined( scaledistance ) )
    {
        scaledistance = 1000;
    }
    
    setomnvar( "ui_objective_scale_distance", scaledistance );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x123a
// Size: 0x34
function function_cd037dbe1fe3943( index )
{
    if ( level.objective_array != undefined && level.objective_array.size )
    {
        return level.objective_array[ index ];
    }
    
    return undefined;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 3
// Checksum 0x0, Offset: 0x1277
// Size: 0xcf
function _objective_addlocation( objectivename, locationname, var_8c7c19c9172500f )
{
    assert( objective_exists( objectivename ) );
    assert( isstring( locationname ) );
    objectiveindex = _objective_getindexforname( objectivename );
    assertex( !array_contains( level.objective_array[ objectiveindex ].locations, locationname ), "The location - " + locationname + " - is already defined for objective: " + objectivename );
    objectivelocationindex = _objective_getnextfreelocationindex( objectiveindex );
    assertex( objectivelocationindex < 8, "This objective can only have a limited number of max locations. Can't add more!" );
    level.objective_array[ objectiveindex ].locations[ objectivelocationindex ] = locationname;
    objective_setlocation( objectiveindex, objectivelocationindex, var_8c7c19c9172500f );
    level notify( "objectives_updated" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x134e
// Size: 0x34
function _objective_validatename( objectivename )
{
    assertex( !isint( objectivename ), "objectiveName needs to be a string - not an integer index. Accessing the script-side index system shouldn't be done explicitly!" );
    assertex( isstring( objectivename ), "objectiveName needs to be a string!" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x138a
// Size: 0x15
function _objective_initindexforname( objectivename )
{
    _objective_getindexforname( objectivename, 1 );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0x13a7
// Size: 0x208
function _objective_getindexforname( objectivename, isnewobjective )
{
    assert( isstring( objectivename ) );
    
    if ( !isdefined( level.objective_array ) )
    {
        level.objective_array = [];
    }
    
    objectiveindex = -1;
    
    if ( istrue( isnewobjective ) )
    {
        assertex( !objective_exists( objectivename ), "An objective with this name was already added: " + objectivename );
        objectiveindex = _objective_getnextfreeobjectiveindex();
        level.objective_array[ objectiveindex ] = spawnstruct();
        level.objective_array[ objectiveindex ].objectivename = objectivename;
        level.objective_array[ objectiveindex ].locations = [];
        level.objective_array[ objectiveindex ].objid = objectiveindex;
        
        if ( !objective_isunlimited() )
        {
            objective_delete( objectiveindex );
        }
    }
    else if ( objective_isunlimited() )
    {
        foreach ( obj in level.objective_array )
        {
            if ( isdefined( obj ) && isdefined( obj.objectivename ) && obj.objectivename == objectivename )
            {
                objectiveindex = obj.objid;
                break;
            }
        }
    }
    else
    {
        assert( level.objective_array.size <= 32 );
        
        for ( i = 0; i < 32 ; i++ )
        {
            if ( isdefined( level.objective_array[ i ] ) && isdefined( level.objective_array[ i ].objectivename ) && level.objective_array[ i ].objectivename == objectivename )
            {
                objectiveindex = i;
                break;
            }
        }
    }
    
    assertex( objectiveindex >= 0, "The objective - " + objectivename + " - could not be found!" );
    assert( objective_exists( objectivename ) );
    return objectiveindex;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x15b8
// Size: 0x82
function _objective_getnextfreelocationindex( objectiveindex )
{
    assert( isdefined( level.objective_array ) );
    objectivelocations = level.objective_array[ objectiveindex ].locations;
    
    for ( i = 0; i < 8 ; i++ )
    {
        if ( !isdefined( objectivelocations[ i ] ) )
        {
            return i;
        }
        
        if ( objectivelocations[ i ] == "" )
        {
            return i;
        }
    }
    
    assertmsg( "Can't add another location, we are already at capacity: " + 8 );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x1642
// Size: 0x5e
function _objective_getnextfreeobjectiveindex()
{
    if ( objective_isunlimited() )
    {
        return objective_create();
    }
    
    assert( isdefined( level.objective_array ) );
    
    for ( i = 0; i < 32 ; i++ )
    {
        if ( !isdefined( level.objective_array[ i ] ) )
        {
            return i;
        }
    }
    
    assertmsg( "Can't add another objective, we are already at capacity: " + 32 );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x16a8
// Size: 0x3e
function function_bb9ff75fdab01612( boolean )
{
    level.objective_reminder.enabled = boolean;
    
    if ( istrue( level.objective_reminder.enabled ) )
    {
        function_51fa6750df4678ca();
    }
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x16ee
// Size: 0x90
function function_51fa6750df4678ca( delay_time )
{
    if ( !isdefined( level.objective_reminder.delay_time ) || !isdefined( delay_time ) )
    {
        level.objective_reminder.delay_time = 180000;
    }
    
    if ( isdefined( delay_time ) && delay_time > 0 )
    {
        level.objective_reminder.delay_time = delay_time;
    }
    
    level.objective_reminder.next_time = gettime() + level.objective_reminder.delay_time;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x1786
// Size: 0x46
function function_198bcf281b9c6e01( duration )
{
    if ( !isdefined( duration ) || duration == 0 )
    {
        duration = 180000;
    }
    else
    {
        duration *= 1000;
    }
    
    level.objective_reminder.delay_time = duration;
    function_51fa6750df4678ca( duration );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x17d4
// Size: 0x42
function function_6294c59db36291e6( var_9f34c2c1d6c74955 )
{
    if ( isdefined( var_9f34c2c1d6c74955 ) )
    {
        if ( var_9f34c2c1d6c74955 == 0 )
        {
            thread function_78a5f36ae600540();
            function_51fa6750df4678ca();
            return;
        }
        
        var_9f34c2c1d6c74955 = int( var_9f34c2c1d6c74955 * 1000 );
        function_51fa6750df4678ca( var_9f34c2c1d6c74955 );
    }
    
    function_51fa6750df4678ca( var_9f34c2c1d6c74955 );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x181e
// Size: 0xc8
function function_f420c7fbd15a416b()
{
    level endon( "game_ended" );
    println( "<dev string:x1c>" );
    level.objective_reminder = spawnstruct();
    function_bb9ff75fdab01612( 0 );
    function_51fa6750df4678ca();
    childthread function_17b90f3fe7fbd28f();
    
    while ( true )
    {
        cur_time = gettime();
        
        if ( function_d0acca3f41921ad2() )
        {
            function_51fa6750df4678ca();
        }
        else if ( level.objective_reminder.next_time <= cur_time || istrue( level.objective_reminder.forced ) )
        {
            if ( istrue( level.objective_reminder.enabled ) )
            {
                thread function_78a5f36ae600540();
                self waittill( "objective_reminder_end" );
                function_51fa6750df4678ca();
            }
        }
        
        wait 5;
    }
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x18ee
// Size: 0x88
function function_78a5f36ae600540()
{
    focus_display_hint( undefined, undefined, level.player, "objective_reminder_end" );
    
    /#
        if ( getdvarint( @"hash_cbacc26f16af0e07", 0 ) > 0 )
        {
            iprintlnbold( "<dev string:x37>" );
        }
    #/
    
    end_time = gettime() + 10000;
    
    while ( gettime() < end_time || istrue( level.objective_reminder.forced ) )
    {
        if ( function_d0acca3f41921ad2() )
        {
            break;
        }
        
        waitframe();
    }
    
    function_3895aa5d9337bee1();
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x197e
// Size: 0x34
function function_3895aa5d9337bee1()
{
    level.player notify( "objective_reminder_end" );
    
    /#
        if ( getdvarint( @"hash_cbacc26f16af0e07", 0 ) > 0 )
        {
            iprintlnbold( "<dev string:x50>" );
        }
    #/
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x19ba
// Size: 0x67
function function_17b90f3fe7fbd28f()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        result = waittill_any_ents_return( level.player, "focus_pressed", level, "objectives_updated", level, "player_linked_to_rig" );
        
        /#
            if ( getdvarint( @"hash_cbacc26f16af0e07", 0 ) > 0 )
            {
                iprintlnbold( "<dev string:x72>" + result );
            }
        #/
        
        function_51fa6750df4678ca();
    }
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x1a29
// Size: 0x2d, Type: bool
function function_d0acca3f41921ad2()
{
    return flag( "objectives_displayed" ) || function_d501bbf61ed965b7() == 0 || function_2d6537807828303e() || function_1e4aaaddfd5236ca();
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 4
// Checksum 0x0, Offset: 0x1a5f
// Size: 0x33
function focus_display_hint( timeout, delay, endonentity, endonmessage )
{
    display_hint( "focus_hint", timeout, delay, endonentity, endonmessage );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x1a9a
// Size: 0x24
function function_d501bbf61ed965b7( objectivename )
{
    if ( !isdefined( level.objective_array ) )
    {
        return 0;
    }
    
    return level.objective_array.size;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x1ac7
// Size: 0xc
function function_2d6537807828303e()
{
    return getomnvar( "ui_cutscene_active" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x1adc
// Size: 0xac, Type: bool
function function_1e4aaaddfd5236ca()
{
    enemies = getaiarrayinradius( level.player.origin, 500, get_enemy_team( level.player.team ) );
    
    foreach ( nearbyai in enemies )
    {
        if ( isalive( nearbyai ) && gettime() - nearbyai lastknowntime( level.player ) < 10000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x1b91
// Size: 0x20
function function_e18920c0717c1b4e( boolean )
{
    level.player setclientomnvar( "ui_objective_reveal_fanfare_enabled", boolean );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 1
// Checksum 0x0, Offset: 0x1bb9
// Size: 0x20
function function_84126bde5bb3888b( boolean )
{
    level.player setclientomnvar( "ui_objective_dismiss_fanfare_enabled", boolean );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x1be1
// Size: 0x15
function function_4e1c4a6c6eec1568()
{
    return level.player getclientomnvar( "ui_objective_reveal_fanfare_enabled" );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 0
// Checksum 0x0, Offset: 0x1bff
// Size: 0x30
function function_b338aa1e9ec37fbd()
{
    level.player setclientomnvar( "ui_show_objectives", 1 );
    wait 3;
    level.player setclientomnvar( "ui_show_objectives", 0 );
}

// Namespace objectives / scripts\engine\sp\objectives
// Params 2
// Checksum 0x0, Offset: 0x1c37
// Size: 0xb5
function function_b26ad6615e6cf8ce( start_flag, end_flag )
{
    level endon( "game_ended" );
    
    if ( isdefined( start_flag ) )
    {
        flag_wait( start_flag );
    }
    
    level.player setclientomnvar( "ui_show_objectives", 1 );
    
    if ( isdefined( end_flag ) )
    {
        flag_wait( end_flag );
    }
    else
    {
        while ( true )
        {
            result = level function_28551e899093b138( "objectives_updated_state", "objectives_updated" );
            
            if ( result[ "message" ] == "objectives_updated" )
            {
                break;
            }
            
            if ( result[ 0 ] != "current" && result[ 0 ] != "invisible" )
            {
                break;
            }
        }
    }
    
    level.player setclientomnvar( "ui_show_objectives", 0 );
}

