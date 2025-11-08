#namespace mp_jup_hydro_fx;

// Namespace mp_jup_hydro_fx / scripts\mp\maps\mp_jup_hydro\mp_jup_hydro_fx
// Params 0
// Checksum 0x0, Offset: 0x1dd
// Size: 0x6a
function main()
{
    level._effect[ "vfx_story_vortex_blocker_wall" ] = loadfx( "vfx/jup/ob/gameplay/riftrun/s3_5/story_mission/vfx_story_vortex_blocker_wall.vfx" );
    level._effect[ "vfx_the_entity_ground_vortex_debris" ] = loadfx( "vfx/jup/ob/gameplay/riftrun/s3_5/story_mission/the_entity/vfx_the_entity_ground_vortex_debris.vfx" );
    level._effect[ "vfx_loot_obj_speed_pickup" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_loot_obj_speed_pickup.vfx" );
    
    /#
        if ( getdvar( @"clientsideeffects" ) != "<dev string:x1c>" )
        {
        }
    #/
}

