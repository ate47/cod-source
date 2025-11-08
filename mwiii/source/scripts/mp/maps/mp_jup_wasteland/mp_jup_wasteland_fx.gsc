#using scripts\common\basic_wind;

#namespace mp_jup_wasteland_fx;

// Namespace mp_jup_wasteland_fx / scripts\mp\maps\mp_jup_wasteland\mp_jup_wasteland_fx
// Params 0
// Checksum 0x0, Offset: 0xe2
// Size: 0x5b
function main()
{
    level._effect[ "vfx_farm_sunflare" ] = loadfx( "vfx/iw9/level/mp_embassy/vfx_embassy_sunflare.vfx" );
    
    if ( !getdvarint( @"hash_e6afce2cf5cf7515" ) )
    {
        load_wind( "east", 1 );
        level.wind_ent = init_wind( "east", 1, 1 );
    }
    
    thread function_a520347b8e7b8543();
}

// Namespace mp_jup_wasteland_fx / scripts\mp\maps\mp_jup_wasteland\mp_jup_wasteland_fx
// Params 0
// Checksum 0x0, Offset: 0x145
// Size: 0x79
function function_a520347b8e7b8543()
{
    setdvar( @"hash_402173c7dbee15d9", 5 );
    setdvar( @"hash_656131a98e0d2c9d", 10 );
    setdvar( @"hash_595f2292597ec0c7", ( 0, 1, 0 ) );
    setdvar( @"hash_71fe8b216d50a24c", 1.5 );
    setdvar( @"hash_6a4705943fd574b8", 0.25 );
    setdvar( @"hash_d0658156fb7f2311", 25 );
}

