#namespace namespace_9b9fbf828d53f353;

// Namespace namespace_9b9fbf828d53f353 / namespace_4525f113583a8ae5
// Params 1
// Checksum 0x0, Offset: 0xac
// Size: 0x51
function function_54dfca3641c2c1ab( filenamerequested )
{
    if ( !isdefined( level.var_87766fb0b0a03a87 ) )
    {
        level.var_87766fb0b0a03a87 = [];
    }
    
    fileobject = function_113ae197e6c38cb8( filenamerequested );
    
    if ( !isdefined( fileobject ) )
    {
        fileobject = function_a22fc988697bb76d( filenamerequested );
        
        if ( fileobject )
        {
            function_b6d1131bbf38fd70( filenamerequested, fileobject );
        }
    }
    
    return fileobject;
}

// Namespace namespace_9b9fbf828d53f353 / namespace_4525f113583a8ae5
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x106
// Size: 0x5c, Type: bool
function private function_b6d1131bbf38fd70( filename, fileobject )
{
    if ( fileobject )
    {
        var_dae5b56fef5253a7 = spawnstruct();
        var_dae5b56fef5253a7.id = filename;
        var_dae5b56fef5253a7.object = fileobject;
        level.var_87766fb0b0a03a87[ level.var_87766fb0b0a03a87.size ] = var_dae5b56fef5253a7;
        return true;
    }
    
    return false;
}

// Namespace namespace_9b9fbf828d53f353 / namespace_4525f113583a8ae5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x16b
// Size: 0x74
function private function_113ae197e6c38cb8( filerequested )
{
    foreach ( var_b643a4a42d8b8dbf in level.var_87766fb0b0a03a87 )
    {
        if ( var_b643a4a42d8b8dbf.id == filerequested )
        {
            return var_b643a4a42d8b8dbf.object;
        }
    }
    
    return undefined;
}

// Namespace namespace_9b9fbf828d53f353 / namespace_4525f113583a8ae5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1e8
// Size: 0x84
function private function_a22fc988697bb76d( filerequested )
{
    while ( istrue( level.var_6ff7b075bad15e1b ) )
    {
        waitframe();
    }
    
    if ( requestpublisherobject( filerequested ) )
    {
        level.var_6ff7b075bad15e1b = 1;
        filename = "";
        fileobject = undefined;
        succeed = 0;
        
        while ( filename != filerequested )
        {
            level waittill( "publisher_download_completed", succeed, filename );
        }
        
        if ( succeed )
        {
            fileobject = function_e7f8033f0614eb44();
        }
        
        level.var_6ff7b075bad15e1b = 0;
        return fileobject;
    }
    
    return undefined;
}

