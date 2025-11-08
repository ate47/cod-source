#using scripts\common\utility;
#using scripts\cp\cp_audio;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace namespace_69ea95a8f8923497;

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x3b8
// Size: 0x155
function main()
{
    while ( !isdefined( level.player ) )
    {
        waitframe();
    }
    
    level.player setsoundsubmix( "cp_jup_apt_default" );
    level.player clearsoundsubmix( "cp_jup_apt_combat", 0 );
    thread function_4edc5479d9ca43a( "balcony_clear", "cp_jup_apt_combat", 1, 8 );
    location_list = [ ( 2065, 1978, 1026 ), ( 1793, 3819, 1084 ), ( 2619, 3575, 1240 ), ( 2943, 3537, 1298 ), ( 1728, 1961, 1778 ), ( 2711, 1692, 1400 ), ( 3015, 2782.6, 1330 ), ( 2070, 1912, 1800 ), ( 2975, 3612, 1850 ), ( 2661, 1826, 1826 ), ( 1800, 3840, 1800 ), ( 3560, 1728, 1800 ), ( 3190, 2628, 1810 ) ];
    thread scripts\cp\cp_audio::function_ec9b3af8f8e2d59f( 4, "balcony_clear", "jup_apt_alarm_a_close", "cp_jup_apt_alarm_attenuate", location_list );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 4
// Checksum 0x0, Offset: 0x515
// Size: 0x9f
function function_4edc5479d9ca43a( stop_flag, submix, var_fd3848745fed2346, var_5ba95f0968004ed7 )
{
    level endon( "game_ended" );
    var_48f15edf0b01719e = "hidden";
    
    while ( !flag( stop_flag ) )
    {
        if ( var_48f15edf0b01719e != getstealthdetectstate() )
        {
            if ( getstealthdetectstate() == "hidden" )
            {
                level.player clearsoundsubmix( submix, var_5ba95f0968004ed7 );
            }
            else if ( getstealthdetectstate() == "spotted" )
            {
                level.player setsoundsubmix( submix, var_fd3848745fed2346 );
            }
        }
        
        var_48f15edf0b01719e = getstealthdetectstate();
        wait 0.5;
    }
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x5bc
// Size: 0x12
function function_63e6de435da0d83f()
{
    setglobalsoundcontext( "jup_shoulder_carry", "fly_hvt_carry" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x5d6
// Size: 0x12
function function_55b61726e8e1f043()
{
    setglobalsoundcontext( "jup_shoulder_carry", "" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 1
// Checksum 0x0, Offset: 0x5f0
// Size: 0x42
function function_854485abe0254369( linkpos )
{
    level.player setsoundsubmix( "jup_cp_apt_container_enemy_moment" );
    linkpos playsoundonmovingent( "cp_apt_scn_enemy_container_drop" );
    wait 4;
    level.player clearsoundsubmix( "jup_cp_apt_container_enemy_moment" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 1
// Checksum 0x0, Offset: 0x63a
// Size: 0x1f
function function_ae0a4a264baff88c( linkpos )
{
    linkpos stopsounds();
    waitframe();
    linkpos playsoundonmovingent( "cp_apt_scn_enemy_container_death_vo_2" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x661
// Size: 0x16
function function_1db933d9a1fea0e7()
{
    level.player setsoundsubmix( "jup_cp_apt_infil_basement" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x67f
// Size: 0x16
function function_6c83d1f9b8824de2()
{
    level.player clearsoundsubmix( "jup_cp_apt_infil_basement" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x69d
// Size: 0x16
function function_b248bf57abb8eb43()
{
    level.player setsoundsubmix( "jup_cp_apt_price_sniper_scene_mix" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 1
// Checksum 0x0, Offset: 0x6bb
// Size: 0x1f
function function_87fa20426a85dd01( var_aa530e82ac4b938b )
{
    level waittill( "price_fire" );
    var_aa530e82ac4b938b playsound( "cp_apt_scn_price_zipline_shot_whizby" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 1
// Checksum 0x0, Offset: 0x6e2
// Size: 0x17
function function_62e0ae6e1529d894( var_aa530e82ac4b938b )
{
    var_aa530e82ac4b938b playsound( "cp_apt_scn_price_zipline_bullet_impact" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 1
// Checksum 0x0, Offset: 0x701
// Size: 0x17
function function_a60e7c732b5440e2( var_a2e02bc146e6ebfd )
{
    playsoundatpos( var_a2e02bc146e6ebfd, "zipline_rope_lower" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x720
// Size: 0x18
function function_8d21939fb067fc32()
{
    level.player setsoundsubmix( "jup_cp_apt_hvt_skyhook_attach", 2 );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x740
// Size: 0x1b
function function_f62c9a99dcc80e17()
{
    level.player clearsoundsubmix( "jup_cp_apt_hvt_skyhook_attach", 0.5 );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x763
// Size: 0x32
function function_515796d61b108c60()
{
    level.player setsoundsubmix( "jup_cp_apt_skyhook_exfil", 2 );
    wait 7.5;
    level.player setsoundsubmix( "jup_cp_apt_skyhook_exfil_yoink" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x79d
// Size: 0x52
function function_1f92d589b3ae4c01()
{
    level.player setsoundsubmix( "jup_cp_apt_skyhook_exfil_fade_to_black" );
    level.player clearsoundsubmix( "jup_cp_apt_skyhook_exfil" );
    level.player clearsoundsubmix( "jup_cp_apt_skyhook_exfil_yoink" );
    level.player clearsoundsubmix( "cp_jup_apt_default" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x7f7
// Size: 0x16
function function_c1aee80b88bad254()
{
    level.player setsoundsubmix( "jup_cp_apt_rooftop_helicopter_scene_mix" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 2
// Checksum 0x0, Offset: 0x815
// Size: 0x2b
function function_d1b66b48341bf2ea( var_9c6043b223bcc972, var_9c6042b223bcc73f )
{
    var_9c6043b223bcc972 playsoundonmovingent( "veh_jup_apt_enemy_heli_fly_in_1b" );
    var_9c6042b223bcc73f playsoundonmovingent( "veh_jup_apt_enemy_heli_fly_in_1a" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 1
// Checksum 0x0, Offset: 0x848
// Size: 0x17
function function_8681483e6d3d3522( var_9c6043b223bcc972 )
{
    var_9c6043b223bcc972 playsoundonmovingent( "veh_jup_apt_enemy_heli_fly_in_2a" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 1
// Checksum 0x0, Offset: 0x867
// Size: 0x17
function function_573981212498b10b( var_9c6042b223bcc73f )
{
    var_9c6042b223bcc73f playsoundonmovingent( "veh_jup_apt_enemy_heli_fly_in_2b" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 2
// Checksum 0x0, Offset: 0x886
// Size: 0x2b
function function_9e0d228709e80dbc( var_9c6043b223bcc972, var_9c6042b223bcc73f )
{
    var_9c6043b223bcc972 playsoundonmovingent( "veh_jup_apt_enemy_heli_fly_in_3a" );
    var_9c6042b223bcc73f playsoundonmovingent( "veh_jup_apt_enemy_heli_fly_in_3b" );
}

// Namespace namespace_69ea95a8f8923497 / namespace_78ef5a12a453ec66
// Params 0
// Checksum 0x0, Offset: 0x8b9
// Size: 0x16
function function_6c22b1feac90c495()
{
    level.player playsound( "jup_door_wood_stuck_01" );
}

