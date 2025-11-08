#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace mp_jup_skidrow_alt_lighting;

// Namespace mp_jup_skidrow_alt_lighting / scripts\mp\maps\mp_jup_skidrow_alt\mp_jup_skidrow_alt_lighting
// Params 0
// Checksum 0x0, Offset: 0x1d1
// Size: 0x74
function main()
{
    thread neon_hide();
    thread open_doors();
    level.gunshipvisionset = "mp_jup_skidrow_alt_killstreak_gunship";
    level.choppervisionset = "mp_jup_skidrow_alt_cruise_color_mp";
    level.var_6d129920246627ba = "mp_jup_skidrow_alt_assault_drone_color_mp";
    level.var_61b254009a0951a6 = "mp_jup_skidrow_alt_assault_drone_color_dark_mp";
    level.var_638c653eda9d1cd3 = "mp_jup_skidrow_alt_cruise_color_mp";
    level.hellstormmissilevisionset = "mp_jup_skidrow_alt_cruise_color_mp";
    level.killstreakthermalvisionset = "mp_jup_skidrow_alt_killstreak_thermal";
}

// Namespace mp_jup_skidrow_alt_lighting / scripts\mp\maps\mp_jup_skidrow_alt\mp_jup_skidrow_alt_lighting
// Params 0
// Checksum 0x0, Offset: 0x24d
// Size: 0x8
function lighting_dvars()
{
    wait 0.5;
}

// Namespace mp_jup_skidrow_alt_lighting / scripts\mp\maps\mp_jup_skidrow_alt\mp_jup_skidrow_alt_lighting
// Params 0
// Checksum 0x0, Offset: 0x25d
// Size: 0x6c
function neon_hide()
{
    wait 0.05;
    neon_hide = getentarray( "neon_hide", "targetname" );
    
    foreach ( object in neon_hide )
    {
        object hide();
    }
}

// Namespace mp_jup_skidrow_alt_lighting / scripts\mp\maps\mp_jup_skidrow_alt\mp_jup_skidrow_alt_lighting
// Params 0
// Checksum 0x0, Offset: 0x2d1
// Size: 0x74
function open_doors()
{
    wait 10;
    open_door_left = getentitylessscriptablearray( "open_door_left", "script_noteworthy" );
    
    foreach ( door in open_door_left )
    {
        wait 0.1;
        door scriptabledooropen( "left" );
    }
}

