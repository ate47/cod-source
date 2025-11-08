#using scripts\common\utility;
#using scripts\engine\utility;

#namespace data_tracker;

// Namespace data_tracker / scripts\common\data_tracker
// Params 0
// Checksum 0x0, Offset: 0xc9
// Size: 0x8
function createstruct_datatracker()
{
    return function_9c7053f2799c3238();
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0xda
// Size: 0x2a
function function_4d1de11b1a5630ec( var_fc27cf5aa6482417 )
{
    if ( !isstruct( var_fc27cf5aa6482417 ) )
    {
        assertmsg( "<dev string:x1c>" );
    }
    
    function_9c7053f2799c3238( var_fc27cf5aa6482417 );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x10c
// Size: 0x40
function adddataobject( dataobject )
{
    if ( !isdefined( dataobject.uniquename ) )
    {
        assertmsg( "<dev string:x5f>" );
        return;
    }
    
    self.dataobjects[ dataobject.uniquename ] = dataobject;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 4
// Checksum 0x0, Offset: 0x154
// Size: 0x67
function adddata( datauniquename, datatype, value, callbackfunction )
{
    if ( isdefined( self.dataobjects[ datauniquename ] ) )
    {
        assertmsg( "<dev string:xc2>" + datauniquename + "<dev string:xee>" );
        return;
    }
    
    dataobject = function_29564ce8dc854f53( datauniquename, datatype, value, callbackfunction );
    adddataobject( dataobject );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 3
// Checksum 0x0, Offset: 0x1c3
// Size: 0x4a
function adddataint( datauniquename, value, callbackfunction )
{
    if ( !isint( value ) )
    {
        assertmsg( "<dev string:x11d>" + datauniquename + "<dev string:x150>" );
        return;
    }
    
    adddata( datauniquename, "Integer", value, callbackfunction );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 3
// Checksum 0x0, Offset: 0x215
// Size: 0x4a
function adddatafloat( datauniquename, value, callbackfunction )
{
    if ( !isfloat( value ) )
    {
        assertmsg( "<dev string:x189>" + datauniquename + "<dev string:x1be>" );
        return;
    }
    
    adddata( datauniquename, "Float", value, callbackfunction );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 3
// Checksum 0x0, Offset: 0x267
// Size: 0x4a
function adddatastring( datauniquename, value, callbackfunction )
{
    if ( !isstring( value ) )
    {
        assertmsg( "<dev string:x1f4>" + datauniquename + "<dev string:x22a>" );
        return;
    }
    
    adddata( datauniquename, "String", value, callbackfunction );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 3
// Checksum 0x0, Offset: 0x2b9
// Size: 0x2a
function adddataprogresstracker( datauniquename, value, callbackfunction )
{
    adddata( datauniquename, "ProgressTracker", value, callbackfunction );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x2eb
// Size: 0x16
function removedata( datauniquename )
{
    self.dataobjects[ datauniquename ] = undefined;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 2
// Checksum 0x0, Offset: 0x309
// Size: 0x5b
function updatedata( dataobjectuniquename, updatedvalue )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x261>" + dataobjectuniquename + "<dev string:x290>" );
        return;
    }
    
    dataobject.value = updatedvalue;
    function_5aa098a0e2a91e3e( dataobjectuniquename );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x36c
// Size: 0x46
function function_5aa098a0e2a91e3e( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x2ba>" + dataobjectuniquename + "<dev string:x290>" );
        return;
    }
    
    function_755936e0aeeb43f6( dataobjectuniquename );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 2
// Checksum 0x0, Offset: 0x3ba
// Size: 0x3d
function addcallback( callbackfunction, callonobject )
{
    newcallback = function_72504163d8901997( callbackfunction, callonobject );
    self.shareddatacallbacks[ self.shareddatacallbacks.size ] = newcallback;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 3
// Checksum 0x0, Offset: 0x3ff
// Size: 0x58
function function_c0a81a4aa88ede55( callbackfunction, dataobjectuniquename, callonobject )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x2f7>" + dataobjectuniquename + "<dev string:x290>" );
        return;
    }
    
    function_18c71d7e16a8c68c( dataobject, callbackfunction, callonobject );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x45f
// Size: 0x6a
function removecallback( callbackfunction )
{
    for ( callbackid = 0; callbackid < self.shareddatacallbacks.size ; callbackid++ )
    {
        if ( self.shareddatacallbacks[ callbackid ].callbackfunction == callbackfunction )
        {
            self.shareddatacallbacks[ callbackid ] = undefined;
        }
    }
    
    self.shareddatacallbacks = array_removeundefined( self.callbacks );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 2
// Checksum 0x0, Offset: 0x4d1
// Size: 0xae
function function_d6f2becdeb4c29be( callbackfunction, dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x332>" + dataobjectuniquename + "<dev string:x290>" );
        return;
    }
    
    for ( callbackid = 0; callbackid < dataobject.callbacks.size ; callbackid++ )
    {
        if ( dataobject.callbacks[ callbackid ].callbackfunction == callbackfunction )
        {
            dataobject.callbacks[ callbackid ] = undefined;
        }
    }
    
    dataobject.callbacks = array_removeundefined( dataobject.callbacks );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x587
// Size: 0x49
function getdatavalue( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x370>" + dataobjectuniquename + "<dev string:x290>" );
        return;
    }
    
    return dataobject.value;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x5d9
// Size: 0x3f
function getdataobject( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x370>" + dataobjectuniquename + "<dev string:x290>" );
        return;
    }
    
    return dataobject;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x621
// Size: 0x17, Type: bool
function function_6a26856f16c6a207( dataobjectuniquename )
{
    return isdefined( self.dataobjects[ dataobjectuniquename ] );
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x641
// Size: 0x110
function function_755936e0aeeb43f6( dataobjectuniquename )
{
    dataobject = self.dataobjects[ dataobjectuniquename ];
    
    if ( !isdefined( dataobject ) )
    {
        assertmsg( "<dev string:x3a0>" + dataobjectuniquename + "<dev string:x290>" );
        return;
    }
    
    foreach ( callback in dataobject.callbacks )
    {
        if ( isdefined( callback ) )
        {
            callback.callon thread [[ callback.callbackfunction ]]( self, dataobject );
        }
    }
    
    foreach ( callback in self.shareddatacallbacks )
    {
        if ( isdefined( callback ) )
        {
            callback.callon thread [[ callback.callbackfunction ]]( self, dataobject );
        }
    }
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1
// Checksum 0x0, Offset: 0x759
// Size: 0x16
function function_71667164a3e75714( dataobject )
{
    return dataobject.uniquename;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x778
// Size: 0x34
function private function_9c7053f2799c3238( datatrackerstruct )
{
    datatrackerstruct = default_to( datatrackerstruct, spawnstruct() );
    datatrackerstruct.dataobjects = [];
    datatrackerstruct.shareddatacallbacks = [];
    return datatrackerstruct;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x7b5
// Size: 0x77
function private function_29564ce8dc854f53( uniquename, datatype, value, callbackfunction )
{
    dataobject = spawnstruct();
    dataobject.uniquename = uniquename;
    dataobject.datatype = datatype;
    dataobject.value = value;
    dataobject.callbacks = [];
    
    if ( isdefined( callbackfunction ) )
    {
        function_18c71d7e16a8c68c( dataobject, callbackfunction );
    }
    
    return dataobject;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x835
// Size: 0x46
function private function_72504163d8901997( callbackfunction, callonobject )
{
    newcallback = spawnstruct();
    newcallback.callon = default_to( callonobject, level );
    newcallback.callbackfunction = callbackfunction;
    return newcallback;
}

// Namespace data_tracker / scripts\common\data_tracker
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x884
// Size: 0x49
function private function_18c71d7e16a8c68c( dataobject, callbackfunction, callonobject )
{
    newcallback = function_72504163d8901997( callbackfunction, callonobject );
    dataobject.callbacks[ dataobject.callbacks.size ] = newcallback;
}

