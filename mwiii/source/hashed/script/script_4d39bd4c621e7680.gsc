#using script_185660037b9236c1;
#using script_41387eecc35b88bf;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace activity_scriptables;

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 4
// Checksum 0x0, Offset: 0x113
// Size: 0x66
function function_cb2e672e5fb4f3( activityinstance, scriptablename, origin, destructionmoment )
{
    origin = default_to( origin, namespace_68dc261109a9503f::function_8988a4c89289d7f4( activityinstance ) );
    destructionmoment = default_to( destructionmoment, "InstanceEnd" );
    scriptable = spawnscriptable( scriptablename, origin );
    
    if ( isdefined( scriptable ) )
    {
        function_5b71b730bfefd36a( activityinstance, scriptable, destructionmoment );
        return scriptable;
    }
    
    return undefined;
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 3
// Checksum 0x0, Offset: 0x182
// Size: 0x41
function function_5b71b730bfefd36a( activityinstance, scriptable, destructionmoment )
{
    destructionmoment = default_to( destructionmoment, "None" );
    
    if ( isdefined( scriptable ) )
    {
        function_a51ade79202d2b36( activityinstance, scriptable, destructionmoment );
        function_2d1d9d6ca99f0047( activityinstance, scriptable );
    }
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 3
// Checksum 0x0, Offset: 0x1cb
// Size: 0x69
function function_5c4c35644d53846f( activityinstance, scriptables, destructionmoment )
{
    foreach ( scriptable in scriptables )
    {
        function_5b71b730bfefd36a( activityinstance, scriptable, destructionmoment );
    }
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 5
// Checksum 0x0, Offset: 0x23c
// Size: 0x122
function function_12e90953c7c6cbf4( activityinstance, activitymoment, scriptable, partname, statename )
{
    var_c6787d1914826ac6 = function_a51ade79202d2b36( activityinstance, scriptable );
    
    if ( !scriptable getscriptablehaspart( partname ) )
    {
        assertmsg( "<dev string:x1c>" + partname + "<dev string:x35>" + scriptable.index );
        return;
    }
    
    if ( !isdefined( var_c6787d1914826ac6.partnames[ partname ] ) )
    {
        var_c6787d1914826ac6.partnames[ partname ] = [];
    }
    
    if ( isdefined( statename ) )
    {
        if ( !scriptable getscriptableparthasstate( partname, statename ) )
        {
            assertmsg( "<dev string:x79>" + statename + "<dev string:x93>" + partname + "<dev string:xd1>" + scriptable.index );
            return;
        }
        
        var_c6787d1914826ac6.partnames[ partname ][ activitymoment ] = statename;
        return;
    }
    
    if ( !scriptable getscriptableparthasstate( partname, activitymoment ) )
    {
        assertmsg( "<dev string:x79>" + activitymoment + "<dev string:x93>" + partname + "<dev string:xd1>" + scriptable.index );
        return;
    }
    
    var_c6787d1914826ac6.partnames[ partname ][ activitymoment ] = activitymoment;
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 2
// Checksum 0x0, Offset: 0x366
// Size: 0x1a5
function function_dfe0a21d9848315e( activityinstance, activitymoment )
{
    var_a7e550e8ef0bbfe2 = 0;
    
    foreach ( scriptableid, var_c6787d1914826ac6 in activityinstance.var_67c56bf0b03688bf )
    {
        if ( !isdefined( var_c6787d1914826ac6.scriptable ) )
        {
            activityinstance.var_67c56bf0b03688bf[ scriptableid ] = undefined;
            var_a7e550e8ef0bbfe2 = 1;
            continue;
        }
        
        if ( var_c6787d1914826ac6.destructionmoment == activitymoment )
        {
            if ( isdefined( var_c6787d1914826ac6.scriptable.origin ) )
            {
                level notify( "lootcache_opened_kill_callout" + var_c6787d1914826ac6.scriptable.origin );
            }
            
            var_c6787d1914826ac6.scriptable freescriptable();
            activityinstance.var_67c56bf0b03688bf[ scriptableid ] = undefined;
            var_a7e550e8ef0bbfe2 = 1;
            continue;
        }
        
        foreach ( partname, partinfo in var_c6787d1914826ac6.partnames )
        {
            if ( isdefined( partinfo[ activitymoment ] ) )
            {
                var_c6787d1914826ac6.scriptable setscriptablepartstate( partname, activitymoment );
            }
        }
    }
    
    if ( var_a7e550e8ef0bbfe2 )
    {
        activityinstance.var_67c56bf0b03688bf = array_removeundefined( activityinstance.var_67c56bf0b03688bf, 1 );
        activityinstance.var_17a2361aa0beabb2 = array_removeundefined( activityinstance.var_17a2361aa0beabb2 );
    }
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 1
// Checksum 0x0, Offset: 0x513
// Size: 0x48
function function_494bce73f65c6b6f( activityinstance )
{
    varianttag = namespace_68dc261109a9503f::function_a4748b32a824c79c( activityinstance );
    var_d7037f8ce7fba1c6 = getentitylessscriptablearray( varianttag, "script_noteworthy" );
    var_d7037f8ce7fba1c6 = array_combine( var_d7037f8ce7fba1c6, getscriptablearray( varianttag, "script_noteworthy" ) );
    return var_d7037f8ce7fba1c6;
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 1
// Checksum 0x0, Offset: 0x564
// Size: 0xeb
function activityscriptablecleanup( activityinstance )
{
    foreach ( var_c6787d1914826ac6 in activityinstance.var_67c56bf0b03688bf )
    {
        if ( isdefined( var_c6787d1914826ac6.scriptable ) )
        {
            var_9107f7cc534da975 = isdefined( var_c6787d1914826ac6.destructionmoment ) && var_c6787d1914826ac6.destructionmoment == "None";
            var_ae601fd44828f827 = !var_9107f7cc534da975;
            
            if ( var_ae601fd44828f827 )
            {
                if ( isdefined( var_c6787d1914826ac6.scriptable.origin ) )
                {
                    level notify( "lootcache_opened_kill_callout" + var_c6787d1914826ac6.scriptable.origin );
                }
                
                var_c6787d1914826ac6.scriptable freescriptable();
            }
        }
    }
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x657
// Size: 0x5a
function private function_e9ff3fa066f12d9f( scriptable, destructionmoment )
{
    destructionmoment = default_to( destructionmoment, "None" );
    var_c6787d1914826ac6 = spawnstruct();
    var_c6787d1914826ac6.scriptable = scriptable;
    var_c6787d1914826ac6.partnames = [];
    var_c6787d1914826ac6.destructionmoment = destructionmoment;
    return var_c6787d1914826ac6;
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x6ba
// Size: 0x8a
function private function_a51ade79202d2b36( activityinstance, scriptable, destructionmoment )
{
    destructionmoment = default_to( destructionmoment, "None" );
    
    if ( isdefined( activityinstance.var_67c56bf0b03688bf[ scriptable.index ] ) )
    {
        return activityinstance.var_67c56bf0b03688bf[ scriptable.index ];
    }
    
    var_c6787d1914826ac6 = function_e9ff3fa066f12d9f( scriptable, destructionmoment );
    activityinstance.var_67c56bf0b03688bf[ scriptable.index ] = var_c6787d1914826ac6;
    return var_c6787d1914826ac6;
}

// Namespace activity_scriptables / namespace_779ebc650a9ef856
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x74d
// Size: 0xea
function private function_2d1d9d6ca99f0047( activityinstance, scriptable )
{
    scriptablepartnames = scriptable function_90069777043e7833();
    
    foreach ( partname in scriptablepartnames )
    {
        if ( isstartstr( toupper( partname ), "NEXUSMANAGEDSCRIPTABLEPART" ) )
        {
            var_ec5849fb65eb261a = namespace_70aa82e7f409bc33::function_c795f9c21a9bc8();
            
            foreach ( activitymoment in var_ec5849fb65eb261a )
            {
                if ( scriptable getscriptableparthasstate( partname, activitymoment ) )
                {
                    function_12e90953c7c6cbf4( activityinstance, activitymoment, scriptable, partname );
                }
            }
        }
    }
}

