#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;

#namespace sp_jup_flashback_audio;

// Namespace sp_jup_flashback_audio / scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_audio
// Params 0
// Checksum 0x0, Offset: 0x1c5
// Size: 0x32
function main()
{
    transient_soundbanks = spawn( "sound_transient_soundbanks", ( 0, 0, 0 ) );
    transient_soundbanks settransientsoundbank( "weapon_iw9_sm_alpha57_plr.all", 1 );
}

// Namespace sp_jup_flashback_audio / scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_audio
// Params 0
// Checksum 0x0, Offset: 0x1ff
// Size: 0x14c
function function_c8af4a1cdc0f6e21()
{
    self endon( "death" );
    self endon( "player_at_elevator_bottom" );
    var_7e14dcff999c318f = "start";
    current_location = "none";
    var_abc809082007dec2 = "scn_jup_flash_siren_main_stadium";
    var_46dbfa58e1e7954c = 3;
    var_5c29ab75fcfab98d = ( 28745, 2259, 74 );
    level waittill( "audio_tunnel_begin" );
    
    while ( var_7e14dcff999c318f != "elevator_zipline_end" )
    {
        wait 3;
        
        switch ( var_7e14dcff999c318f )
        {
            case #"hash_92c0d94622b80b72":
                current_location = var_5c29ab75fcfab98d;
                break;
            case #"hash_d003e5340ecd499e":
                current_location = var_5c29ab75fcfab98d;
                break;
            case #"hash_dee22eb8954420e4":
                current_location = var_5c29ab75fcfab98d;
                break;
            case #"hash_3428c9058b880a27":
                current_location = var_5c29ab75fcfab98d;
                break;
            default:
                current_location = var_5c29ab75fcfab98d;
                break;
        }
        
        var_46dbfa58e1e7954c++;
        var_46dbfa58e1e7954c %= 3;
        
        switch ( var_46dbfa58e1e7954c )
        {
            case 0:
                var_abc809082007dec2 = "scn_jup_flash_siren_main_stadium";
                break;
            case 1:
                var_abc809082007dec2 = "scn_jup_flash_siren_main_stadium";
                break;
            case 2:
                var_abc809082007dec2 = "scn_jup_flash_siren_main_stadium";
                break;
            default:
                break;
        }
        
        function_2f4acc45a7bd9d7b( current_location, var_abc809082007dec2 );
    }
}

// Namespace sp_jup_flashback_audio / scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_audio
// Params 2
// Checksum 0x0, Offset: 0x353
// Size: 0x1b
function function_2f4acc45a7bd9d7b( position, name )
{
    playsoundatpos( position, name );
}

// Namespace sp_jup_flashback_audio / scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_audio
// Params 1
// Checksum 0x0, Offset: 0x376
// Size: 0x17
function function_a0a74b9253e2f4d( location_name )
{
    var_7e14dcff999c318f = location_name;
}

// Namespace sp_jup_flashback_audio / scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_audio
// Params 0
// Checksum 0x0, Offset: 0x395
// Size: 0x10f
function function_b1e3c22d0bf5b7b6()
{
    level thread function_c8af4a1cdc0f6e21();
    var_6cedc80732a5d600 = [];
    var_6cedc80732a5d600[ var_6cedc80732a5d600.size ] = getent( "audio_tunnel_begin", "targetname" );
    var_6cedc80732a5d600[ var_6cedc80732a5d600.size ] = getent( "audio_tunnel_end", "targetname" );
    var_6cedc80732a5d600[ var_6cedc80732a5d600.size ] = getent( "audio_stairwell_gunfight", "targetname" );
    
    while ( !isdefined( var_6cedc80732a5d600[ var_6cedc80732a5d600.size - 1 ] ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        var_e30fbec40c3cb51f = undefined;
        
        while ( !isdefined( var_e30fbec40c3cb51f ) )
        {
            foreach ( testtrigger in var_6cedc80732a5d600 )
            {
                if ( level.player istouching( testtrigger ) )
                {
                    var_e30fbec40c3cb51f = testtrigger;
                    break;
                }
            }
            
            waitframe();
        }
        
        function_a0a74b9253e2f4d( var_e30fbec40c3cb51f.targetname );
        level notify( var_e30fbec40c3cb51f.targetname );
        
        while ( level.player istouching( var_e30fbec40c3cb51f ) )
        {
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace sp_jup_flashback_audio / scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_audio
// Params 5
// Checksum 0x0, Offset: 0x4ac
// Size: 0x50
function function_68562e15bb2bd6f0( var_69743af45d6867ee, var_69fb56e8a15a857, scale_depth, hold_length, var_8a0d7ae937b8eb86 )
{
    level.player setsoundsubmix( var_69743af45d6867ee, var_69fb56e8a15a857, scale_depth );
    wait hold_length;
    level.player clearsoundsubmix( var_69743af45d6867ee, var_8a0d7ae937b8eb86 );
}

// Namespace sp_jup_flashback_audio / scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_audio
// Params 0
// Checksum 0x0, Offset: 0x504
// Size: 0x2b
function function_3d9e1164d143c3c2()
{
    level.player setsoundsubmix( "sp_jup_flashback_iw9_heli_turn_down" );
    waitframe();
    level.var_e3554f139b424f57 playloopsound( "jup_flashback_helicopter_exfil_patrol_engine_lp" );
}

