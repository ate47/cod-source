#using scripts\common\utility;
#using scripts\engine\utility;

#namespace vehicle_anim;

// Namespace vehicle_anim / scripts\cp_mp\vehicles\vehicle_anim
// Params 0
// Checksum 0x0, Offset: 0x112
// Size: 0x24
function init_vehicles()
{
    create_func_ref( "fastrope_anim", &fastrope_anim );
    create_func_ref( "vehicle_door_anim", &vehicle_anim );
}

// Namespace vehicle_anim / scripts\cp_mp\vehicles\vehicle_anim
// Params 3
// Checksum 0x0, Offset: 0x13e
// Size: 0x4d
function fastrope_anim( model, animation, flag )
{
    model dontinterpolate();
    model scriptmodelclearanim();
    model scriptmodelplayanimdeltamotionfrompos( getanimname( animation ), model.origin, model.angles, flag );
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace vehicle_anim / scripts\cp_mp\vehicles\vehicle_anim
// Params 2
// Checksum 0x0, Offset: 0x193
// Size: 0xb2
function vehicle_anim( vehicle, animation )
{
    if ( isdefined( vehicle ) )
    {
        if ( istrue( vehicle.animintro ) )
        {
            if ( !istrue( vehicle.var_28140f53a0386f0e ) )
            {
                vehicle.var_28140f53a0386f0e = 1;
                vehicle animscripted( "placeholder", vehicle.scenenode.origin, vehicle.scenenode.angles, animation );
            }
            
            return;
        }
        
        vehicle animscripted( "placeholder", vehicle.origin, vehicle.angles, %iw9_veh_blank_5_seconds );
        vehicle vehicleplayanim( animation, 0 );
    }
}

// Namespace vehicle_anim / scripts\cp_mp\vehicles\vehicle_anim
// Params 0
// Checksum 0x0, Offset: 0x24d
// Size: 0x13
function vehicleaniminit()
{
    scripts\engine\utility::create_func_ref( "use_turret", &utility::use_turret );
}

// Namespace vehicle_anim / scripts\cp_mp\vehicles\vehicle_anim
// Params 1
// Checksum 0x0, Offset: 0x268
// Size: 0xc
function set_vehicle_anims_mkilo23_ai_infil( positions )
{
    return positions;
}

// Namespace vehicle_anim / scripts\cp_mp\vehicles\vehicle_anim
// Params 1
// Checksum 0x0, Offset: 0x27d
// Size: 0xc
function set_vehicle_anims_umike( positions )
{
    return positions;
}

