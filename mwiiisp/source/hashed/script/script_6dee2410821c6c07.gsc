#namespace namespace_7f78dd93ed16ea4f;

// Namespace namespace_7f78dd93ed16ea4f / namespace_da1f3c0af8e51b0f
// Params 0
// Checksum 0x0, Offset: 0x8b
// Size: 0x22
function init()
{
    if ( !isdefined( level.var_35a6c186c74a921b ) )
    {
        level.var_35a6c186c74a921b = [];
    }
    
    level thread onplayerconnect();
}

// Namespace namespace_7f78dd93ed16ea4f / namespace_da1f3c0af8e51b0f
// Params 0
// Checksum 0x0, Offset: 0xb5
// Size: 0x21
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread onplayerspawned();
    }
}

// Namespace namespace_7f78dd93ed16ea4f / namespace_da1f3c0af8e51b0f
// Params 1
// Checksum 0x0, Offset: 0xde
// Size: 0xb
function function_60d43f6a3c2b5f1b( callback )
{
    
}

// Namespace namespace_7f78dd93ed16ea4f / namespace_da1f3c0af8e51b0f
// Params 0
// Checksum 0x0, Offset: 0xf1
// Size: 0x62
function onplayerspawned()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "weapon_change" );
        
        foreach ( callback in level.var_35a6c186c74a921b )
        {
            self [[ callback ]]();
        }
    }
}

