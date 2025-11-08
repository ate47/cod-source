#using scripts\cp_mp\utility\game_utility;
#using scripts\mp\tweakables;

#namespace serversettings;

// Namespace serversettings / scripts\mp\serversettings
// Params 0
// Checksum 0x0, Offset: 0xf2
// Size: 0x41
function init()
{
    level.hostname = getserverhostname();
    setfriendlyfire( scripts\mp\tweakables::gettweakablevalue( "team", "fftype" ) );
    constraingametype( scripts\cp_mp\utility\game_utility::getgametype() );
    
    for ( ;; )
    {
        updateserversettings();
        wait 5;
    }
}

// Namespace serversettings / scripts\mp\serversettings
// Params 0
// Checksum 0x0, Offset: 0x13b
// Size: 0x34
function updateserversettings()
{
    scr_friendlyfire = scripts\mp\tweakables::gettweakablevalue( "team", "fftype" );
    
    if ( level.friendlyfire != scr_friendlyfire )
    {
        setfriendlyfire( scr_friendlyfire );
    }
}

// Namespace serversettings / scripts\mp\serversettings
// Params 1
// Checksum 0x0, Offset: 0x177
// Size: 0x1a4
function constraingametype( gametype )
{
    entities = getentarray();
    
    for ( i = 0; i < entities.size ; i++ )
    {
        entity = entities[ i ];
        
        if ( gametype == "dm" )
        {
            if ( isdefined( entity.script_gametype_dm ) && entity.script_gametype_dm != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "tdm" )
        {
            if ( isdefined( entity.script_gametype_tdm ) && entity.script_gametype_tdm != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "ctf" )
        {
            if ( isdefined( entity.script_gametype_ctf ) && entity.script_gametype_ctf != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "hq" )
        {
            if ( isdefined( entity.script_gametype_hq ) && entity.script_gametype_hq != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "sd" )
        {
            if ( isdefined( entity.script_gametype_sd ) && entity.script_gametype_sd != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "koth" || gametype == "koth_horde" || gametype == "koth_jugg" )
        {
            if ( isdefined( entity.script_gametype_koth ) && entity.script_gametype_koth != "1" )
            {
                entity delete();
            }
        }
    }
}

// Namespace serversettings / scripts\mp\serversettings
// Params 1
// Checksum 0x0, Offset: 0x323
// Size: 0x35
function setfriendlyfire( enabled )
{
    level.friendlyfire = enabled;
    setdvar( @"ui_friendlyfire", enabled );
    setdvar( @"hash_11420719fff4b2a2", enabled );
}

