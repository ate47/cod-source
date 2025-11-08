#namespace mp_frontend_jup_01_fx;

// Namespace mp_frontend_jup_01_fx / scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_fx
// Params 0
// Checksum 0x0, Offset: 0x2ec
// Size: 0xd2
function main()
{
    level._effect[ "vfx_jup_battlepass_s1_unlock_default" ] = loadfx( "vfx/jup/battlepass/vfx_jup_battlepass_s1_unlock_default.vfx" );
    level._effect[ "vfx_jup_battlepass_s1_unlock_default" ] = loadfx( "vfx/jup/battlepass/vfx_jup_battlepass_s2_unlock_default.vfx" );
    level._effect[ "vfx_jup_battlepass_s1_unlock_default" ] = loadfx( "vfx/jup/battlepass/vfx_jup_battlepass_s3_unlock_default.vfx" );
    level._effect[ "vfx_jup_battlepass_s1_unlock_default" ] = loadfx( "vfx/jup/battlepass/vfx_jup_battlepass_s4_unlock_default.vfx" );
    level._effect[ "vfx_jup_exe_s1_zeta_speed_trail_01" ] = loadfx( "vfx/jup/executions/mtx/season_1/vfx_jup_exe_s1_zeta_speed_trail_01.vfx" );
    level._effect[ "vfx_frontend_weapon_protune_aura" ] = loadfx( "vfx/iw9/level/frontend/vfx_frontend_weapon_protune_aura.vfx" );
    level._effect[ "vfx_frontend_store_operator_motes_med" ] = loadfx( "vfx/iw9/level/frontend/vfx_frontend_store_operator_motes_med.vfx" );
    
    /#
        if ( getdvar( @"clientsideeffects" ) != "<dev string:x1c>" )
        {
        }
    #/
}

