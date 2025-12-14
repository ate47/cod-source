main()
{
	level._effect[ "vfx_frontend_plane_dogfight_ch" ] = LoadFX( "vfx/iw8/level/frontend/s3/vfx_frontend_plane_dogfight_ch.vfx" );
	level._effect[ "steamFXWall" ]                    = LoadFX( "vfx/iw8/level/frontend/s3/vfx_frontend_vent_steam.vfx" );
	level._effect[ "steamFXFloor" ]                   = LoadFX( "vfx/iw8/level/frontend/s3/vfx_frontend_grate_steam" );
	level._effect[ "smoke_plume_fire_distant_xlg_1" ] = LoadFX( "vfx/s4/level/el_alamein/smoke_plume_fire_distant_xlg_1.vfx" );
	level._effect[ "dome_fire_lrg_01" ]               = LoadFX( "vfx/s4/level/dome/dome_fire_lrg_01.vfx" );

/#
	if ( GetDvar( "#x3e4eb4040dda2b10e" ) != "1" )
	{
        scripts\mp\maps\mp_frontend9\gen\mp_frontend9_fx::main();
        scripts\mp\maps\mp_frontend9\gen\mp_frontend9_sound::main();
	}
#/

}
