#namespace mp_jup_highrise_xmas_audio;

// Namespace mp_jup_highrise_xmas_audio / scripts\mp\maps\mp_jup_highrise_xmas\mp_jup_highrise_xmas_audio
// Params 0
// Checksum 0x0, Offset: 0xc7
// Size: 0xa
function main()
{
    thread function_96aaa35375c864db();
}

// Namespace mp_jup_highrise_xmas_audio / scripts\mp\maps\mp_jup_highrise_xmas\mp_jup_highrise_xmas_audio
// Params 0
// Checksum 0x0, Offset: 0xd9
// Size: 0x4e
function function_96aaa35375c864db()
{
    if ( istrue( level.snowballfight ) )
    {
        level endon( "game_ended" );
        level.var_d13ed50cfe72fa6a = spawn( "script_model", ( 109, 292, 3913 ) );
        level.var_d13ed50cfe72fa6a playloopsound( "amb_highrise_emt_xmas_music_lp" );
        return;
    }
    
    return;
}

