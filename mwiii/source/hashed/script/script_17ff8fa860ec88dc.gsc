#using scripts\common\utility;
#using scripts\common\visibility_mode;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\teams;

#namespace namespace_8a7fbc5545f75867;

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 0
// Checksum 0x0, Offset: 0x170
// Size: 0x6b
function function_764239e6a246c46a()
{
    funcarray = [];
    funcarray[ "shouldRun" ] = &visibilitymode_shouldrun;
    funcarray[ "enableForClient" ] = &visibilitymode_enable;
    funcarray[ "disable" ] = &visibilitymode_disable;
    funcarray[ "checkForDataUpdates" ] = &function_5d19d3f8062e4bee;
    funcarray[ "getADSWeaponDist" ] = &function_553772f1f998aa41;
    funcarray[ "getTargetArray" ] = &visibilitymode_gettargetarray;
    funcarray[ "outlineOccluded" ] = &function_e392446751b714f6;
    return funcarray;
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 0
// Checksum 0x0, Offset: 0x1e4
// Size: 0x89, Type: bool
function visibilitymode_shouldrun()
{
    level endon( "game_ended" );
    
    if ( scripts\mp\utility\game::ismlgmatch() )
    {
        return false;
    }
    
    canrun = scripts\mp\utility\game::privatematch() || level.systemlink;
    
    if ( !canrun )
    {
        return false;
    }
    
    while ( !isdefined( level.players ) || level.players.size == 0 )
    {
        wait 0.05;
    }
    
    wait 0.1;
    hostenabled = 0;
    
    while ( !hostenabled )
    {
        hostenabled = function_2e2a6c022b5ed8db();
        wait 3;
    }
    
    return canrun && hostenabled;
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 0
// Checksum 0x0, Offset: 0x276
// Size: 0x87
function function_2e2a6c022b5ed8db()
{
    hostenabled = 0;
    
    foreach ( player in level.players )
    {
        if ( player ishost() )
        {
            datavalue = function_7bcb4b0b404dc8a8( player );
            
            if ( isdefined( datavalue ) && datavalue > 0 )
            {
                hostenabled = 1;
            }
            
            break;
        }
    }
    
    return hostenabled;
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 3
// Checksum 0x0, Offset: 0x306
// Size: 0x25
function visibilitymode_enable( client, assetname, prioritygroup )
{
    return scripts\mp\utility\outline::outlineenableforplayer( self, client, assetname, prioritygroup );
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 1
// Checksum 0x0, Offset: 0x334
// Size: 0x14
function visibilitymode_disable( id )
{
    scripts\mp\utility\outline::outlinedisable( id, self );
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 0
// Checksum 0x0, Offset: 0x350
// Size: 0x2a
function function_553772f1f998aa41()
{
    weapon = self getcurrentweapon();
    
    if ( weaponclass( weapon ) == "sniper" )
    {
        return 8192;
    }
    
    return 2048;
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 1
// Checksum 0x0, Offset: 0x383
// Size: 0x5b
function visibilitymode_gettargetarray( client )
{
    friendlyplayers = scripts\mp\utility\teams::getfriendlyplayers( client.team );
    enemyplayers = scripts\mp\utility\teams::getenemyplayers( client.team );
    aiarray = getaiarray();
    return array_combine( friendlyplayers, enemyplayers, aiarray );
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 2
// Checksum 0x0, Offset: 0x3e7
// Size: 0x1b
function function_e392446751b714f6( startpoint, endpoint )
{
    return scripts\mp\utility\outline::outlineoccluded( startpoint, endpoint );
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 0
// Checksum 0x0, Offset: 0x40b
// Size: 0xb3
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
            datavalue = function_7bcb4b0b404dc8a8( player );
            
            if ( isdefined( datavalue ) )
            {
                if ( isdefined( player.visibilitymodeval ) )
                {
                    if ( datavalue != player.visibilitymodeval )
                    {
                        player scripts\common\visibility_mode::visibilitymode_unpackvalue( datavalue );
                    }
                    
                    continue;
                }
                
                player scripts\common\visibility_mode::visibilitymode_unpackvalue( datavalue );
            }
        }
    }
}

// Namespace namespace_8a7fbc5545f75867 / namespace_93121fa16281c01c
// Params 1
// Checksum 0x0, Offset: 0x4c6
// Size: 0x31
function function_7bcb4b0b404dc8a8( player )
{
    datavalue = player getplayerdata( level.loadoutsgroup, "squadMembers", "highVisibilityMode" );
    return datavalue;
}

