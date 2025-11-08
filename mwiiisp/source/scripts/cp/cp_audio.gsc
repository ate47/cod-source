#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_audio;

// Namespace cp_audio / scripts\cp\cp_audio
// Params 6
// Checksum 0x0, Offset: 0xf2
// Size: 0x34d
function function_f1dd559fdd8216d1( var_e0ba383b8c4fadb2, var_7d21adbf51f45019, var_f97e3e0e2b488103, combat_dist, var_b7aa972580dd1acb, stop_flag )
{
    level endon( "game_ended" );
    
    if ( !isdefined( var_e0ba383b8c4fadb2 ) )
    {
        var_e0ba383b8c4fadb2 = 2;
    }
    
    if ( !isdefined( var_7d21adbf51f45019 ) )
    {
        var_7d21adbf51f45019 = 6;
    }
    
    if ( !isdefined( var_f97e3e0e2b488103 ) )
    {
        var_f97e3e0e2b488103 = 11;
    }
    
    if ( !isdefined( var_b7aa972580dd1acb ) )
    {
        var_b7aa972580dd1acb = "global";
    }
    
    if ( !isdefined( stop_flag ) )
    {
        stop_flag = 1;
    }
    
    if ( !isdefined( combat_dist ) )
    {
        combat_dist = 2000;
    }
    
    var_2655dde555bd413d = "cp_jup_" + var_b7aa972580dd1acb + "_combat_heavy";
    var_88e76544f260ccd3 = "cp_jup_" + var_b7aa972580dd1acb + "_combat_medium";
    var_56a51e39655e7f28 = "cp_jup_" + var_b7aa972580dd1acb + "_combat_light";
    fade_in_time = 2;
    fade_out_time = 2;
    level.player clearsoundsubmix( var_56a51e39655e7f28, 0 );
    level.player clearsoundsubmix( var_88e76544f260ccd3, 0 );
    level.player clearsoundsubmix( var_2655dde555bd413d, 0 );
    curr_state = "stealth";
    
    while ( !flag( stop_flag ) )
    {
        var_2ba47445cf6c2fb8 = [];
        
        foreach ( guy in getaiarrayinradius( level.player.origin, combat_dist, "axis" ) )
        {
            if ( isdefined( guy ) && guy [[ guy.fnisinstealthcombat ]]() )
            {
                var_2ba47445cf6c2fb8[ var_2ba47445cf6c2fb8.size ] = guy;
            }
        }
        
        function_49d6e5ec39a0c4c( "heavy_combat", 0 );
        
        if ( var_2ba47445cf6c2fb8.size >= var_f97e3e0e2b488103 )
        {
            if ( curr_state != "heavy" )
            {
                level.player clearsoundsubmix( var_56a51e39655e7f28, fade_out_time );
                level.player clearsoundsubmix( var_88e76544f260ccd3, fade_out_time );
                level.player setsoundsubmix( var_2655dde555bd413d, fade_in_time );
            }
            
            function_49d6e5ec39a0c4c( "heavy_combat", 1 );
            curr_state = "heavy";
        }
        else if ( var_2ba47445cf6c2fb8.size >= var_7d21adbf51f45019 )
        {
            if ( curr_state != "medium" )
            {
                level.player clearsoundsubmix( var_56a51e39655e7f28, fade_out_time );
                level.player clearsoundsubmix( var_2655dde555bd413d, fade_out_time );
                level.player setsoundsubmix( var_88e76544f260ccd3, fade_in_time );
            }
            
            curr_state = "medium";
        }
        else if ( var_2ba47445cf6c2fb8.size >= var_e0ba383b8c4fadb2 )
        {
            if ( curr_state != "light" )
            {
                level.player clearsoundsubmix( var_88e76544f260ccd3, fade_out_time );
                level.player clearsoundsubmix( var_2655dde555bd413d, fade_out_time );
                level.player setsoundsubmix( var_56a51e39655e7f28, fade_in_time );
            }
            
            curr_state = "light";
        }
        else
        {
            if ( curr_state != "stealth" )
            {
                level.player clearsoundsubmix( var_56a51e39655e7f28, fade_out_time );
                level.player clearsoundsubmix( var_88e76544f260ccd3, fade_out_time );
                level.player clearsoundsubmix( var_2655dde555bd413d, fade_out_time );
            }
            
            curr_state = "stealth";
        }
        
        wait 1;
    }
    
    level.player clearsoundsubmix( var_56a51e39655e7f28, fade_out_time );
    level.player clearsoundsubmix( var_88e76544f260ccd3, fade_out_time );
    level.player clearsoundsubmix( var_2655dde555bd413d, fade_out_time );
}

// Namespace cp_audio / scripts\cp\cp_audio
// Params 8
// Checksum 0x0, Offset: 0x447
// Size: 0x167
function function_ec9b3af8f8e2d59f( var_5c0625287778fa41, stop_flag, alias, submix, location_list, reflection_alias, var_4af21f8a50feeaf5, var_10a0d0de8c4b44de )
{
    level endon( "game_ended" );
    level.alarm_counter = 0;
    level.player clearsoundsubmix( submix, 0 );
    
    if ( isdefined( var_10a0d0de8c4b44de ) )
    {
        level.player clearsoundsubmix( var_10a0d0de8c4b44de );
    }
    
    level.player setsoundsubmix( submix, 0, 0 );
    thread function_10a0d0de8c4b44de( submix );
    last_state = function_3f51c5f6398bff45();
    
    while ( !flag( stop_flag ) )
    {
        if ( function_3f51c5f6398bff45() == 1 )
        {
            for ( i = 0; i < location_list.size ; i++ )
            {
                playsoundatpos( location_list[ i ], alias );
            }
            
            if ( isdefined( var_4af21f8a50feeaf5 ) )
            {
                for ( i = 0; i < var_4af21f8a50feeaf5.size ; i++ )
                {
                    playsoundatpos( var_4af21f8a50feeaf5[ i ], reflection_alias );
                }
            }
            
            if ( last_state == 0 && isdefined( var_10a0d0de8c4b44de ) )
            {
                level.player setsoundsubmix( var_10a0d0de8c4b44de, 8, 1 );
            }
            
            level.alarm_counter += var_5c0625287778fa41;
        }
        else
        {
            level.alarm_counter = 0;
            
            if ( isdefined( var_10a0d0de8c4b44de ) )
            {
                level.player clearsoundsubmix( var_10a0d0de8c4b44de, 8 );
            }
        }
        
        last_state = function_3f51c5f6398bff45();
        wait var_5c0625287778fa41;
    }
}

// Namespace cp_audio / scripts\cp\cp_audio
// Params 1
// Checksum 0x0, Offset: 0x5b6
// Size: 0x76
function function_10a0d0de8c4b44de( submix )
{
    level endon( "game_ended" );
    var_e9efde741a4fe2db = 0;
    
    while ( true )
    {
        if ( level.alarm_counter > 8 )
        {
            var_e9efde741a4fe2db += 0.008;
        }
        else
        {
            var_e9efde741a4fe2db -= 0.05;
        }
        
        var_e9efde741a4fe2db = clamp( var_e9efde741a4fe2db, 0, 1 );
        level.player scalesoundsubmix( submix, round( var_e9efde741a4fe2db, 0.01 ) );
        wait 0.2;
    }
}

