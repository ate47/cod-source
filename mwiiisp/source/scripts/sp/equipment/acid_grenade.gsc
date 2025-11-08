#using scripts\common\ai;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;

#namespace acid_grenade;

#using_animtree( "generic_human" );

// Namespace acid_grenade / scripts\sp\equipment\acid_grenade
// Params 1
// Checksum 0x0, Offset: 0x174
// Size: 0x51
function precache( offhand )
{
    level.g_effect[ "acid_grenade_explode" ] = loadfx( "vfx/iw9/core/equipment/vfx_equip_acid_grenade.vfx" );
    level.scr_anim[ "generic" ][ "acid_grenade_death" ] = %exposed_death_neckgrab;
    registeroffhandfirefunc( offhand, &function_684230ca19989897 );
}

// Namespace acid_grenade / scripts\sp\equipment\acid_grenade
// Params 2
// Checksum 0x0, Offset: 0x1cd
// Size: 0x143
function function_684230ca19989897( grenade, weapon )
{
    grenade waittill( "missile_stuck", stuckto, null, null, null, position, hitnormal );
    grenade delete();
    thread play_sound_in_space( "weap_bottle_explo", position );
    thread play_sound_in_space( "gas_grenade_body", position );
    playfx( level.g_effect[ "acid_grenade_explode" ], position );
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.15, 0.35, position, 300 );
    enemies = getaiarrayinradius( position, 150, "axis" );
    
    foreach ( enemy in enemies )
    {
        enemy.animname = "generic";
        enemy scripts\common\ai::set_deathanim( "acid_grenade_death" );
        enemy playsound( "dx_vom_aq2_3rd_floor_bedroom_92" );
        enemy do_damage( enemy.health + 9999, position, self, self );
    }
}

