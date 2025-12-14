#include scripts\common\basic_wind;
main()
{
	level._effect[ "ch_oct_distortion_heat_haze" ] = loadfx( "vfx/s4/level/octagon/ch_oct_distortion_heat_haze.vfx" );
	level._effect[ "ch_oct_birds_circling_01" ] = loadfx( "vfx/s4/level/octagon/ch_oct_birds_circling_01.vfx" );
	level._effect[ "may_cloth_large_01" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_large_01.vfx" );
	level._effect[ "may_cloth_large_02" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_large_02.vfx" );
	level._effect[ "may_cloth_large_03" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_large_03.vfx" );
	level._effect[ "may_cloth_small_01" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_small_01.vfx" );
	level._effect[ "may_cloth_small_02" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_small_02.vfx" );
	level._effect[ "may_cloth_small_03" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_small_03.vfx" );
	level._effect[ "may_cloth_small_04" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_small_04.vfx" );
	level._effect[ "may_cloth_small_05" ]               = LoadFX( "vfx/s4/mayhem/may_cloth_small_05.vfx" );
	level._effect[ "ch_oct_light_circular_01" ]         = LoadFX( "vfx/s4/level/octagon/ch_oct_light_circular_01.vfx" );
	level._effect[ "ch_oct_mayhem_flag_torn_blue_" ]    = LoadFX( "vfx/s4/level/octagon/ch_oct_mayhem_flag_torn_blue_.vfx" );
	level._effect[ "ch_oct_mayhem_flag_torn_green_" ]   = LoadFX( "vfx/s4/level/octagon/ch_oct_mayhem_flag_torn_green_.vfx" );
	level._effect[ "ch_oct_mayhem_flag_torn_neutral_" ] = LoadFX( "vfx/s4/level/octagon/ch_oct_mayhem_flag_torn_neutral_.vfx" );
	level._effect[ "ch_oct_mayhem_flag_torn_red_" ]     = LoadFX( "vfx/s4/level/octagon/ch_oct_mayhem_flag_torn_red_.vfx" );
	level._effect[ "ch_oct_mayhem_flag_torn_yellow_" ]  = LoadFX( "vfx/s4/level/octagon/ch_oct_mayhem_flag_torn_yellow_.vfx" );
	level._effect[ "ch_oct_dust_screen_01" ]            = LoadFX( "vfx/s4/level/octagon/ch_oct_dust_screen_01.vfx" );
	level._effect[ "ch_oct_dust_swirl_ground_01" ]      = LoadFX( "vfx/s4/level/octagon/ch_oct_dust_swirl_ground_01.vfx" );
	level._effect[ "ch_oct_dust_constant_motes_01" ]    = LoadFX( "vfx/s4/level/octagon/ch_oct_dust_constant_motes_01.vfx" );
	level._effect[ "ch_oct_dust_gust_ground_1" ]        = LoadFX( "vfx/s4/level/octagon/ch_oct_dust_gust_ground_1.vfx" );
	level._effect[ "ch_oct_dust_falling_01" ]           = LoadFX( "vfx/s4/level/octagon/ch_oct_dust_falling_01.vfx" );
	level._effect[ "vfx_mp_arena_evo_sunflare" ]        = LoadFX( "vfx/s4/sunflares/vfx_mp_arena_evo_sunflare.vfx" );
/#
	if ( GetDvar( "#x3e4eb4040dda2b10e" ) != "1" )
	{
        scripts\mp\maps\mp_arena_evo\gen\mp_arena_evo_fx::main();
        scripts\mp\maps\mp_arena_evo\gen\mp_arena_evo_sound::main();
	}
#/
	//Wind
	load_wind( "north", 2 );
	init_wind( "north", 2, true );

}
