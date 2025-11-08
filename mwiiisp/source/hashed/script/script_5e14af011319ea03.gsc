#using scripts\common\utility;
#using scripts\cp\cp_audio;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace namespace_fede12fafe7eb721;

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x2e2
// Size: 0xa6
function main()
{
    while ( !isdefined( level.player ) )
    {
        waitframe();
    }
    
    level.player setsoundsubmix( "cp_jup_port_global" );
    setglobalsoundcontext( "jup_map", "port_mission", 1.5 );
    flag_init( "flag_aud_infil_skipped" );
    flag_init( "flag_aud_red_alart_loop_on" );
    location_list = [];
    location_list[ 0 ] = ( 1399, -5303, 1700 );
    thread scripts\cp\cp_audio::function_ec9b3af8f8e2d59f( 2, "exfil_anim_started", "jup_alarm_red_alert_port_dry", "cp_jup_port_alarm_attenuate", location_list );
    thread scripts\cp\cp_audio::function_f1dd559fdd8216d1( 2, 6, 10, 2500, "port", "exfil_anim_started" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x390
// Size: 0xae
function function_7938e0c4ea90c27c()
{
    level.player setsoundsubmix( "cp_jup_port_infil" );
    flag_name = flag_wait_either_return( "flag_dungeon_intro_complete", "scene_skipped" );
    
    if ( flag_name == "scene_skipped" )
    {
        flag_set( "flag_aud_infil_skipped" );
        level.player clearsoundsubmix( "cp_jup_port_infil", 0.5 );
        level.player setsoundsubmix( "cp_jup_port_infil_mute", 1 );
        wait 22;
        level.player clearsoundsubmix( "cp_jup_port_infil_mute", 0.1 );
        return;
    }
    
    wait 3;
    level.player clearsoundsubmix( "cp_jup_port_infil", 3 );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 1
// Checksum 0x0, Offset: 0x446
// Size: 0x1f
function function_eb41c0c9e1874a06( truck )
{
    if ( !flag( "flag_aud_infil_skipped" ) )
    {
        wait 3.5;
    }
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x46d
// Size: 0x99
function function_7fc844314a043b63()
{
    level.player setsoundsubmix( "cp_jup_port_heli_duck", 8 );
    wait 2;
    var_708f951a2679ceb = ( 2272, 1299, 631 );
    var_67a7f510214c71be = ( 5312, -3034, 631 );
    heli_org = spawn( "script_model", var_708f951a2679ceb );
    heli_org playsoundonmovingent( "port_infil_heli_fly_out" );
    heli_org moveto( var_67a7f510214c71be, 5, 1 );
    wait 35;
    level.player clearsoundsubmix( "cp_jup_port_heli_duck", 15 );
    heli_org delete();
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x50e
// Size: 0x39
function function_ab90de89573cace8()
{
    wait 1;
    level.var_34af21dc37f0e0f = spawn( "script_model", ( 1866, 1376, 40 ) );
    level.var_34af21dc37f0e0f playsoundonmovingent( "emt_car_horn_long" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x54f
// Size: 0x2
function function_2521e4438a93290c()
{
    
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x559
// Size: 0x1a
function function_6cd4bd962c8131c()
{
    playsoundatpos( ( 1636.57, -5587.66, 1514.74 ), "port_tower_explode_transient" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x57b
// Size: 0x26
function function_79c73e6292b5783c()
{
    var_e180469b748f5ac8 = ( 3259, -970, 50 );
    playsoundatpos( var_e180469b748f5ac8, "port_street_explosion_left" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x5a9
// Size: 0x26
function function_afdda39e157d7331()
{
    var_e180469b748f5ac8 = ( 2002, -1822, 40 );
    playsoundatpos( var_e180469b748f5ac8, "port_street_explosion_right" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 1
// Checksum 0x0, Offset: 0x5d7
// Size: 0x17
function function_6df4d24bd2419c65( location )
{
    playsoundatpos( location, "port_boat_explosion_small" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 1
// Checksum 0x0, Offset: 0x5f6
// Size: 0x17
function function_b9439a9ce47a80fd( location )
{
    playsoundatpos( location, "port_boat_explosion" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x615
// Size: 0x16
function function_9b215ae8b85ebec9()
{
    level.player playsound( "port_objective_pickup_tracker" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 1
// Checksum 0x0, Offset: 0x633
// Size: 0x17
function function_f48c143c8cecb770( truck )
{
    truck playsoundonmovingent( "jup_port_semi_driveby" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x652
// Size: 0x16
function function_9c78984eca8aba5()
{
    level.player playsound( "port_objective_pickup_manifest" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x670
// Size: 0x16
function function_660435bebb8c190()
{
    level.player playsound( "port_objective_tracker_place_cloth" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x68e
// Size: 0x16
function function_6c22b1feac90c495()
{
    level.player playsound( "jup_door_wood_stuck_01" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x6ac
// Size: 0x16
function function_60d901c08b6e60c7()
{
    level.player clearsoundsubmix( "cp_jup_port_global" );
}

// Namespace namespace_fede12fafe7eb721 / namespace_58460674041d36d3
// Params 0
// Checksum 0x0, Offset: 0x6ca
// Size: 0x28
function function_9119785bb20bd522()
{
    if ( isdefined( level.var_3d7d7275978f193d ) )
    {
        level.var_e05fb44af318872e stopsounds();
        level.var_3d7d7275978f193d = undefined;
    }
}

