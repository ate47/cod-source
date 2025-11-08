#using scripts\common\utility;
#using scripts\common\vehicle_build;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace namespace_522dbf6c246fea47;

// Namespace namespace_522dbf6c246fea47 / scripts\quaked\script_struct_mp_jup_blima_anim_infil
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x1d1
// Size: 0x1e
function autoexec main()
{
    level.shouldinitvehicles = 1;
    function_c0b3ddc9a6bdcc46( "veh_jup_blima_anim_infil", &function_aece8e9cd30f3540 );
}

// Namespace namespace_522dbf6c246fea47 / scripts\quaked\script_struct_mp_jup_blima_anim_infil
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1f7
// Size: 0x3e
function private function_aece8e9cd30f3540()
{
    callbacks = [];
    callbacks[ "spawn" ] = &function_be7c293f00e99691;
    function_8497e7e46b5e397( "veh_jup_blima_anim_infil", callbacks );
    
    if ( utility::function_a10967d736dc56e5() )
    {
        scripts\common\vehicle_build::build_attach_models( &set_attached_models );
    }
}

// Namespace namespace_522dbf6c246fea47 / scripts\quaked\script_struct_mp_jup_blima_anim_infil
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x23d
// Size: 0xbd
function private function_be7c293f00e99691( spawndata, faildata )
{
    vehicle = function_bba34cf920370ff4( "veh_jup_blima_anim_infil", spawndata, faildata );
    
    if ( !isdefined( vehicle ) )
    {
        return undefined;
    }
    
    if ( istrue( spawndata.initai ) )
    {
        vehicle.unload_hover_offset = 537;
        vehicle.unload_land_offset = 165;
        vehicle.script_badplace = 0;
        vehicle.vehiclesetuprope = 1;
        vehicle vehicle_setspeed( 60, 20, 10 );
        vehicle.preventrespawn = 1;
        vehicle.dontspawnhusk = 1;
        vehicle.deathfunc = &vehicle_death;
        vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_a91927df280e94e4();
    }
    
    return vehicle;
}

#using_animtree( "script_model" );

// Namespace namespace_522dbf6c246fea47 / scripts\quaked\script_struct_mp_jup_blima_anim_infil
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x303
// Size: 0x12f
function private set_attached_models()
{
    array = [];
    array[ "TAG_FastRope_LE" ] = spawnstruct();
    array[ "TAG_FastRope_LE" ].model = "equipment_fast_rope_wm_01_infil_heli_l";
    array[ "TAG_FastRope_LE" ].tag = "body_animate_jnt";
    array[ "TAG_FastRope_LE" ].idleanim = %iw9_ai_infil_blima_rope_l_idle;
    array[ "TAG_FastRope_LE" ].dropanim = %iw9_ai_infil_blima_rope_l_drop;
    array[ "TAG_FastRope_RI" ] = spawnstruct();
    array[ "TAG_FastRope_RI" ].model = "equipment_fast_rope_wm_01_infil_heli_l";
    array[ "TAG_FastRope_RI" ].tag = "body_animate_jnt";
    array[ "TAG_FastRope_RI" ].idleanim = %iw9_ai_infil_blima_rope_r_idle;
    array[ "TAG_FastRope_RI" ].dropanim = %iw9_ai_infil_blima_rope_r_drop;
    strings = getarraykeys( array );
    
    for ( i = 0; i < strings.size ; i++ )
    {
        precachemodel( array[ strings[ i ] ].model );
    }
    
    return array;
}

