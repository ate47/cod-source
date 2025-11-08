#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\friendlyfire;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;

#namespace ied;

// Namespace ied / scripts\sp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x269
// Size: 0x3d
function precache( offhand )
{
    precachemodel( "offhand_vm_cellphone_old" );
    level.g_effect[ "IED_explode" ] = loadfx( "vfx/iw8/level/highway/ied_explosion" );
    registeroffhandfirefunc( offhand, &iedfiremain );
}

// Namespace ied / scripts\sp\equipment\ied
// Params 2
// Checksum 0x0, Offset: 0x2ae
// Size: 0x5f
function iedfiremain( ied, weapon )
{
    if ( !isdefined( ied ) )
    {
        return;
    }
    
    ied.targetname = "offhand_ied";
    
    if ( ied.classname != "script_model" )
    {
        ied waittill( "missile_stuck", stuckto );
    }
    
    ied thread ieddetonationlogic( self, 25, 35 );
}

// Namespace ied / scripts\sp\equipment\ied
// Params 3
// Checksum 0x0, Offset: 0x315
// Size: 0x98
function ieddetonationlogic( attacker, var_a5d2db5617eb9a05, var_ccea305d816855aa )
{
    self endon( "detonated" );
    self makeunusable();
    self.interact = iedcreatecursor( var_a5d2db5617eb9a05, var_ccea305d816855aa );
    self.interact waittill( "trigger" );
    origin = self.origin;
    self.interact delete();
    level.player notify( "triggeredIED", origin );
    
    if ( iedcanplaydetonategesture() )
    {
        ieddetonategesture();
    }
    
    thread ieddetonate( origin, attacker );
}

// Namespace ied / scripts\sp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0x3b5
// Size: 0x2d, Type: bool
function iedcanplaydetonategesture()
{
    if ( level.player playerads() == 1 )
    {
        return false;
    }
    
    if ( level.player isreloading() )
    {
        return false;
    }
    
    return true;
}

// Namespace ied / scripts\sp\equipment\ied
// Params 2
// Checksum 0x0, Offset: 0x3eb
// Size: 0x314
function ieddetonate( origin, attacker )
{
    level notify( "level_iedDetonated" );
    self notify( "detonated" );
    self delete();
    attacker notify( "detonatedIED", origin );
    iedplaydetonateeffects( origin );
    
    if ( distancesquared( level.player.origin, origin ) <= 10000 )
    {
        level.player shellshock( "default_nosound", 3 );
        level.player do_damage( 300, origin );
    }
    
    var_fa48e1a11dfa38ed = 100;
    var_99294d212b573d4a = var_fa48e1a11dfa38ed * var_fa48e1a11dfa38ed;
    aiarray = getaiarray();
    
    foreach ( ai in aiarray )
    {
        distancesq = distancesquared( origin, ai.origin );
        
        if ( distancesq > 360000 )
        {
            continue;
        }
        
        if ( distancesq > 160000 )
        {
            ai notify( "flashbang", ( 0, 0, 0 ), 1, 1, attacker, "allies" );
            continue;
        }
        
        if ( istrue( ai.magic_bullet_shield ) )
        {
            var_fa1a63cd9f6ecca2 = isplayer( attacker ) && is_equal( attacker.team, ai.team ) && distancesq <= var_99294d212b573d4a;
            
            if ( var_fa1a63cd9f6ecca2 )
            {
                ai scripts\common\ai::stop_magic_bullet_shield();
                
                if ( isdefined( level.aigibfunction ) )
                {
                    attacker [[ level.aigibfunction ]]( ai, ai geteye(), "MOD_RIFLE_BULLET" );
                }
                
                scripts\sp\friendlyfire::missionfail( 0 );
                return;
            }
            else
            {
                ai notify( "flashbang", ( 0, 0, 0 ), 1, 1, attacker, "allies" );
                continue;
            }
        }
        
        if ( isdefined( level.aigibfunction ) && randomint( 100 ) < 100 )
        {
            attacker [[ level.aigibfunction ]]( ai, ai geteye(), "MOD_RIFLE_BULLET" );
            continue;
        }
        
        playfx( level.g_effect[ "vfx_gib_explode" ], ai.origin );
        ai do_damage( ai.health + 9999, ai.origin, attacker, undefined, "MOD_EXPLOSIVE", "iw8_sh_oscar12" );
    }
    
    distancetoplayer = distance( level.player.origin, origin );
    sounddelay = distancetoplayer / 13397;
    wait sounddelay;
    distancefactor = math::normalize_value( 0, 15000, distancetoplayer );
    intensity = math::factor_value( 0.05, 0.32, distancefactor );
    earthquake( intensity, 1.2, origin, 15000 );
    playrumbleonposition( "damage_heavy", origin );
}

// Namespace ied / scripts\sp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x707
// Size: 0x6e
function iedplaydetonateeffects( origin )
{
    if ( soundexists( "ied_activated" ) )
    {
        level.player playsound( "ied_activated" );
    }
    
    playfx( level.g_effect[ "IED_explode" ], origin );
    physicsexplosionsphere( origin, 400, 200, 150 );
    
    if ( soundexists( "ied_expl_trans" ) )
    {
        thread play_sound_in_space( "ied_expl_trans", origin );
    }
}

// Namespace ied / scripts\sp\equipment\ied
// Params 0
// Checksum 0x0, Offset: 0x77d
// Size: 0xb8
function ieddetonategesture()
{
    var_d7ce16ba0556f168 = spawn( "script_model", level.player.origin );
    var_d7ce16ba0556f168 setmodel( "offhand_vm_cellphone_old" );
    var_d7ce16ba0556f168 notsolid();
    var_d7ce16ba0556f168 linktoplayerview( level.player, "tag_accessory_left", ( 0, 0, 0 ), ( 0, 0, 0 ), 1, "none" );
    gesturelength = level.player getgestureanimlength( "ges_hod_phone_detonate" );
    var_d7ce16ba0556f168 delaycall( gesturelength, &delete );
    level.player player_gesture_force( "ges_hod_phone_detonate" );
    wait 0.5;
}

// Namespace ied / scripts\sp\equipment\ied
// Params 2
// Checksum 0x0, Offset: 0x83d
// Size: 0x84
function iedcreatecursor( var_a5d2db5617eb9a05, var_ccea305d816855aa )
{
    interact = spawn_tag_origin();
    interact.origin += ( 0, 0, 10 );
    interact linkto( self );
    interact scripts\sp\player\cursor_hint::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), &"WEAPON/LABEL_DETONATE", var_ccea305d816855aa, 50000, 50000, 0, undefined, undefined, undefined, "duration_short", undefined, undefined, var_a5d2db5617eb9a05 );
    return interact;
}

// Namespace ied / scripts\sp\equipment\ied
// Params 1
// Checksum 0x0, Offset: 0x8ca
// Size: 0x91
function iedcursorlogic( interact )
{
    self endon( "death" );
    interact endon( "death" );
    interact.cursor_hint_ent endon( "death" );
    self endon( "detonated" );
    
    while ( true )
    {
        if ( distancesquared( level.player.origin, self.origin ) <= 5625 )
        {
            interact.cursor_hint_ent sethintstring( "^2Pickup" );
        }
        else
        {
            interact.cursor_hint_ent sethintstring( "^1Detonate" );
        }
        
        waitframe();
    }
}

