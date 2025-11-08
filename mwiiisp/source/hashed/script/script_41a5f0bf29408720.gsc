#using scripts\common\utility;
#using scripts\common\visibility_mode;
#using scripts\cp\cp_outline_utility;
#using scripts\engine\utility;

#namespace namespace_8a41a85545b288a9;

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x157
// Size: 0x77
function function_764239e6a246c46a()
{
    funcarray = [];
    funcarray[ "shouldRun" ] = &visibilitymode_shouldrun;
    funcarray[ "init" ] = &visibilitymode_init;
    funcarray[ "enableForClient" ] = &visibilitymode_enable;
    funcarray[ "disable" ] = &visibilitymode_disable;
    funcarray[ "checkForDataUpdates" ] = &function_5d19d3f8062e4bee;
    funcarray[ "getADSWeaponDist" ] = &function_553772f1f998aa41;
    funcarray[ "getTargetArray" ] = &visibilitymode_gettargetarray;
    funcarray[ "outlineOccluded" ] = &function_e392446751b714f6;
    return funcarray;
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x1d7
// Size: 0x4, Type: bool
function visibilitymode_shouldrun()
{
    return true;
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x1e4
// Size: 0xb
function visibilitymode_init()
{
    level thread function_72f2b775f465b38d();
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x1f7
// Size: 0x1d
function function_72f2b775f465b38d()
{
    level endon( "game_ended" );
    wait 5;
    scripts\common\visibility_mode::function_7068f93aacf2ef59( "kiosk_objective", "uin_ping_buy_station" );
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 3
// Checksum 0x0, Offset: 0x21c
// Size: 0x25
function visibilitymode_enable( client, assetname, prioritygroup )
{
    return scripts\cp\cp_outline_utility::outlineenableforplayer( self, client, assetname, prioritygroup );
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 1
// Checksum 0x0, Offset: 0x24a
// Size: 0x14
function visibilitymode_disable( id )
{
    scripts\cp\cp_outline_utility::outlinedisable( id, self );
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x266
// Size: 0x29
function function_553772f1f998aa41()
{
    weapon = self getcurrentweapon();
    
    if ( weaponclass( weapon ) == "sniper" )
    {
        return 8192;
    }
    
    return 2048;
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 1
// Checksum 0x0, Offset: 0x298
// Size: 0x37
function visibilitymode_gettargetarray( client )
{
    aiarray = getaiarray();
    players = level.players;
    return array_combine( players, aiarray );
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 2
// Checksum 0x0, Offset: 0x2d8
// Size: 0x1b
function function_e392446751b714f6( startpoint, endpoint )
{
    return scripts\cp\cp_outline_utility::outlineoccluded( startpoint, endpoint );
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x2fc
// Size: 0xf8
function function_5d19d3f8062e4bee()
{
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( level.players ) )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            datavalue = player requestgamerprofile( "highVisibilityMode" );
            outlinevalue = player requestgamerprofile( "highVisibilityModeOutline" );
            
            if ( isdefined( datavalue ) )
            {
                if ( isdefined( player.visibilitymodeval ) && isdefined( level.player.var_5615f87228f360c8 ) )
                {
                    if ( datavalue != player.visibilitymodeval || outlinevalue != player.var_5615f87228f360c8 )
                    {
                        player scripts\common\visibility_mode::visibilitymode_unpackvalue( datavalue, outlinevalue );
                    }
                    
                    continue;
                }
                
                player scripts\common\visibility_mode::visibilitymode_unpackvalue( datavalue, outlinevalue );
            }
        }
    }
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x3fc
// Size: 0x6b
function function_1871237039503ca1()
{
    while ( level.players.size == 0 )
    {
        wait 1;
    }
    
    wait 5;
    
    foreach ( player in level.players )
    {
        player function_971b12ce83d4d457();
    }
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x46f
// Size: 0xd
function function_971b12ce83d4d457()
{
    self setblurforplayer( 5, 1 );
}

// Namespace namespace_8a41a85545b288a9 / namespace_9e238f5e6fc1f074
// Params 0
// Checksum 0x0, Offset: 0x484
// Size: 0x2
function function_68fcff86246cb0e8()
{
    
}

