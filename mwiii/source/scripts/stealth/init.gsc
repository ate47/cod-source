#using scripts\stealth\manager;
#using scripts\stealth\player;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;

#namespace init;

// Namespace init / scripts\stealth\init
// Params 0
// Checksum 0x0, Offset: 0xa7
// Size: 0x9
function main()
{
    scripts\stealth\manager::main();
}

// Namespace init / scripts\stealth\init
// Params 3
// Checksum 0x0, Offset: 0xb8
// Size: 0xdd
function set_stealth_mode( enabled, musichidden, musicspotted )
{
    if ( enabled )
    {
        if ( isdefined( musichidden ) && isdefined( musicspotted ) )
        {
            level thread scripts\stealth\utility::stealth_music( musichidden, musicspotted );
        }
        
        level thread scripts\stealth\threat_sight::threat_sight_set_enabled( 1 );
        
        foreach ( player in level.players )
        {
            player thread scripts\stealth\player::main();
        }
    }
    else
    {
        level thread scripts\stealth\utility::stealth_music_stop();
        level thread scripts\stealth\threat_sight::threat_sight_set_enabled( 0 );
    }
    
    if ( isdefined( level.stealth.fnsetstealthmode ) )
    {
        level thread [[ level.stealth.fnsetstealthmode ]]( enabled, musichidden, musicspotted );
    }
}

