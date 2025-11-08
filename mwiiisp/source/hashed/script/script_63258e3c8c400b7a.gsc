#namespace lui_elems;

// Namespace lui_elems / namespace_12d8f8917a83f664
// Params 2
// Checksum 0x0, Offset: 0x68
// Size: 0x95
function function_f245f059d32d19d1( luielemname, assethash )
{
    luielem = spawnstruct();
    luielem.menuname = luielemname;
    
    if ( !isdefined( level.luielemregistrations ) )
    {
        level.luielemregistrations = [];
    }
    
    if ( !isdefined( level.luielemregistrations[ assethash ] ) )
    {
        level.luielemregistrations[ assethash ] = 1;
    }
    
    luielem.regid = level.luielemregistrations[ assethash ];
    level.luielemregistrations[ assethash ]++;
    luielem.var_b6017d7dcc83fdb6 = 0;
    return luielem;
}

// Namespace lui_elems / namespace_12d8f8917a83f664
// Params 2
// Checksum 0x0, Offset: 0x106
// Size: 0x53
function function_12e2ab1f2879518a( player, flags )
{
    if ( !isdefined( flags ) )
    {
        flags = 0;
    }
    
    luielem = self;
    luielem.var_b6017d7dcc83fdb6 = 1;
    player openluielem( luielem.menuname, luielem.regid, flags );
}

// Namespace lui_elems / namespace_12d8f8917a83f664
// Params 1
// Checksum 0x0, Offset: 0x161
// Size: 0x41
function function_e98e8bd148625cd0( player )
{
    luielem = self;
    luielem.var_b6017d7dcc83fdb6 = 0;
    player closeluielem( luielem.menuname, luielem.regid );
}

// Namespace lui_elems / namespace_12d8f8917a83f664
// Params 1
// Checksum 0x0, Offset: 0x1aa
// Size: 0x33
function function_23de77f715d51c8b( player )
{
    luielem = self;
    return player isluielemopenforplayer( luielem.menuname, luielem.regid );
}

// Namespace lui_elems / namespace_12d8f8917a83f664
// Params 3
// Checksum 0x0, Offset: 0x1e6
// Size: 0x46
function function_2c7278ea5ca893e5( player, data, value )
{
    luielem = self;
    player function_6cdcaf34ab57e074( luielem.menuname, luielem.regid, data, value );
}

