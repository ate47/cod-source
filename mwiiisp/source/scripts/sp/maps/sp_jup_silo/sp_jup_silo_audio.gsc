#namespace sp_jup_silo_audio;

// Namespace sp_jup_silo_audio / scripts\sp\maps\sp_jup_silo\sp_jup_silo_audio
// Params 0
// Checksum 0x0, Offset: 0xbe
// Size: 0xc
function main()
{
    level.var_e5e4f305f88c0782 = undefined;
}

// Namespace sp_jup_silo_audio / scripts\sp\maps\sp_jup_silo\sp_jup_silo_audio
// Params 3
// Checksum 0x0, Offset: 0xd2
// Size: 0x75
function function_4b119908bdf12329( new_submix, fade_out_time, fade_in_time )
{
    if ( isdefined( level.var_e5e4f305f88c0782 ) )
    {
        if ( isdefined( new_submix ) )
        {
            if ( new_submix == level.var_e5e4f305f88c0782 )
            {
                return;
            }
        }
        
        level.player clearsoundsubmix( level.var_e5e4f305f88c0782, fade_out_time );
    }
    
    level.var_e5e4f305f88c0782 = new_submix;
    
    if ( isdefined( new_submix ) )
    {
        level.player setsoundsubmix( new_submix, fade_in_time );
    }
}

// Namespace sp_jup_silo_audio / scripts\sp\maps\sp_jup_silo\sp_jup_silo_audio
// Params 3
// Checksum 0x0, Offset: 0x14f
// Size: 0x5b
function function_fcdf5a0628a1911a( transient_submix, fade_out_time, fade_in_time )
{
    if ( isdefined( level.var_e5e4f305f88c0782 ) )
    {
        level.player clearsoundsubmix( level.var_e5e4f305f88c0782, fade_out_time );
    }
    
    if ( soundsubmixexists( transient_submix ) )
    {
        level.player setsoundsubmix( transient_submix, fade_in_time );
    }
}

// Namespace sp_jup_silo_audio / scripts\sp\maps\sp_jup_silo\sp_jup_silo_audio
// Params 3
// Checksum 0x0, Offset: 0x1b2
// Size: 0x5b
function function_c7c5c2ca61454c41( transient_submix, fade_out_time, fade_in_time )
{
    if ( soundsubmixexists( transient_submix ) )
    {
        level.player clearsoundsubmix( transient_submix, fade_out_time );
    }
    
    if ( isdefined( level.var_e5e4f305f88c0782 ) )
    {
        level.player setsoundsubmix( level.var_e5e4f305f88c0782, fade_in_time );
    }
}

// Namespace sp_jup_silo_audio / scripts\sp\maps\sp_jup_silo\sp_jup_silo_audio
// Params 0
// Checksum 0x0, Offset: 0x215
// Size: 0x81
function function_7dff40c0e5cc9dbe()
{
    var_f13cf7e07e066520 = ( 1970, 3704, -408 );
    level.alarment = spawn( "script_model", var_f13cf7e07e066520 );
    level.alarment playloopsound( "scn_jup_lower_base_security_alarm" );
    wait 23;
    level.alarment stoploopsound( "scn_jup_lower_base_security_alarm", 1 );
    level.alarment playsound( "scn_jup_lower_base_security_alarm_tail" );
    wait 2;
    level.alarment delete();
}

