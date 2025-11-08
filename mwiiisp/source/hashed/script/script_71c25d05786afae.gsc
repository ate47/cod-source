#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_milbase\sp_jup_milbase;
#using scripts\sp\player;
#using scripts\sp\player_death;
#using scripts\sp\utility;

#namespace namespace_37621323a9f8771f;

// Namespace namespace_37621323a9f8771f / namespace_60b2129b73c3e6f0
// Params 3
// Checksum 0x0, Offset: 0x180
// Size: 0xc0
function function_d2532ffacbc9530a( var_f3a1e6d911a12646, fadeout_shader, level_endon )
{
    if ( isstring( level_endon ) )
    {
        level endon( level_endon );
    }
    
    self endon( "entitydeleted" );
    
    while ( true )
    {
        self waittill( "damage", amount, attacker, direction_vec, point, type );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( isarray( var_f3a1e6d911a12646 ) )
        {
            quote = array_random( var_f3a1e6d911a12646 );
            scripts\sp\player_death::set_custom_death_quote( quote );
        }
        
        if ( isdefined( fadeout_shader ) )
        {
            scripts\sp\hud_util::fade_out( 0, fadeout_shader );
        }
        
        missionfailedwrapper();
        return;
    }
}

// Namespace namespace_37621323a9f8771f / namespace_60b2129b73c3e6f0
// Params 2
// Checksum 0x0, Offset: 0x248
// Size: 0x1a7
function function_3ecfaa32d3b8fe63( enemy, dist_max )
{
    player = level.player;
    
    if ( flag( "game_over" ) )
    {
        weapon = make_weapon( "iw9_ar_akilo105_sp" );
        startorigin = enemy geteye() + anglestoforward( enemy.angles ) * 20;
        player do_damage( 350, startorigin, enemy, undefined, "MOD_" + toupper( weapon.classname ) + "_BULLET", weapon );
        return;
    }
    
    if ( !isdefined( enemy ) || !isalive( enemy ) )
    {
        return;
    }
    
    if ( enemy._blackboard.shoot_firstshot != 0 )
    {
    }
    else
    {
        return;
    }
    
    if ( isnumber( dist_max ) )
    {
        dist_sqr = distance2dsquared( player.origin, enemy.origin );
        var_e8fa72081b0127c9 = dist_max * dist_max;
        
        if ( dist_sqr >= var_e8fa72081b0127c9 )
        {
            return;
        }
    }
    
    sight = sighttracepassed( enemy geteye(), player geteye(), 1, enemy, player );
    
    if ( !istrue( sight ) )
    {
        if ( flag( "in_bad_volume" ) )
        {
        }
        else
        {
            return;
        }
    }
    
    weapon = make_weapon( "iw9_ar_akilo105_sp" );
    startorigin = enemy geteye() + anglestoforward( enemy.angles ) * 20;
    player do_damage( 350, startorigin, enemy, undefined, "MOD_" + toupper( weapon.classname ) + "_BULLET", weapon );
}

// Namespace namespace_37621323a9f8771f / namespace_60b2129b73c3e6f0
// Params 4
// Checksum 0x0, Offset: 0x3f7
// Size: 0x108
function function_efdaa03bfc25c1a0( speed, acceleration, deceleration, initflag )
{
    level.player endon( "death" );
    self endon( "explode" );
    self endon( "death" );
    distthreshold = 250000;
    anglethreshold = 0.65;
    isstopped = 0;
    
    while ( true )
    {
        waitframe();
        dist = distancesquared( level.player.origin, self.origin );
        
        if ( dist < distthreshold )
        {
            if ( !isstopped )
            {
                dotproduct = scripts\engine\math::get_dot( self.origin, self.angles, level.player.origin );
                
                if ( dotproduct > anglethreshold )
                {
                    thread function_33c23797c51fb50d();
                    wait randomfloatrange( 1.6, 2.2 );
                    continue;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_37621323a9f8771f / namespace_60b2129b73c3e6f0
// Params 3
// Checksum 0x0, Offset: 0x507
// Size: 0x309
function function_7f1a9c43113121f9( speed, acceleration, deceleration )
{
    level.player endon( "death" );
    self endon( "explode" );
    self endon( "death" );
    vehiclespeed = default_to( speed, 12 );
    var_2f8d4de32759ee0f = default_to( acceleration, 12 );
    var_9f1b337fc69e5614 = default_to( deceleration, 8 );
    distthreshold = 90000;
    var_6d323cfc044286c8 = 250000;
    anglethreshold = 0.65;
    isstopped = 0;
    
    while ( true )
    {
        waitframe();
        var_eb6c281422e00431 = 0;
        var_a6f765b46a677d36 = 0;
        dist = distancesquared( level.player.origin, self.origin );
        
        if ( isstopped && !var_a6f765b46a677d36 )
        {
            if ( dist > distthreshold )
            {
                var_eb6c281422e00431 = 0;
                self vehicle_setspeed( vehiclespeed, var_2f8d4de32759ee0f, var_9f1b337fc69e5614 );
            }
            
            dotproduct = scripts\engine\math::get_dot( self.origin, self.angles, level.player.origin );
            
            if ( dotproduct < anglethreshold )
            {
                var_eb6c281422e00431 = 0;
                self vehicle_setspeed( vehiclespeed, var_2f8d4de32759ee0f, var_9f1b337fc69e5614 );
            }
        }
        
        if ( dist < distthreshold )
        {
            if ( !isstopped )
            {
                dotproduct = scripts\engine\math::get_dot( self.origin, self.angles, level.player.origin );
                
                if ( dotproduct > anglethreshold )
                {
                    self vehicle_setspeed( 0 );
                    isstopped = 1;
                    var_eb6c281422e00431 = 1;
                    wait 1;
                    continue;
                }
            }
        }
        
        foreach ( vehicle in level.vehicles )
        {
            if ( self == vehicle )
            {
                continue;
            }
            
            dist = distancesquared( vehicle.origin, self.origin );
            
            if ( isstopped && !var_eb6c281422e00431 )
            {
                if ( dist > var_6d323cfc044286c8 )
                {
                    var_a6f765b46a677d36 = 0;
                }
                
                dotproduct = scripts\engine\math::get_dot( self.origin, self.angles, vehicle.origin );
                
                if ( dotproduct < anglethreshold )
                {
                    var_a6f765b46a677d36 = 0;
                }
            }
            
            if ( dist < var_6d323cfc044286c8 )
            {
                if ( !isstopped )
                {
                    dotproduct = scripts\engine\math::get_dot( self.origin, self.angles, vehicle.origin );
                    
                    if ( dotproduct > anglethreshold )
                    {
                        self vehicle_setspeed( 0 );
                        isstopped = 1;
                        var_a6f765b46a677d36 = 1;
                        wait 1;
                        break;
                    }
                }
            }
        }
        
        if ( !var_a6f765b46a677d36 && !var_eb6c281422e00431 && isstopped )
        {
            isstopped = 0;
            self vehicle_setspeed( vehiclespeed, var_2f8d4de32759ee0f, var_9f1b337fc69e5614 );
            continue;
        }
        
        if ( !var_a6f765b46a677d36 && !var_eb6c281422e00431 )
        {
            isstopped = 0;
            self vehicle_setspeed( vehiclespeed, var_2f8d4de32759ee0f, var_9f1b337fc69e5614 );
        }
        
        waitframe();
    }
}

// Namespace namespace_37621323a9f8771f / namespace_60b2129b73c3e6f0
// Params 2
// Checksum 0x0, Offset: 0x818
// Size: 0x14b
function function_8bf385621c6c99ab( deathquotearray, mindamage )
{
    level.player endon( "death" );
    level endon( "game_ended" );
    
    if ( !isdefined( deathquotearray ) )
    {
        deathquotearray = [ 255 ];
    }
    
    assertex( isarray( deathquotearray ), "deathQuoteArray must be an array!" );
    
    if ( !isdefined( mindamage ) )
    {
        mindamage = 20;
    }
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !isdefined( attacker ) || !isdefined( damage ) )
        {
            continue;
        }
        else if ( !isplayer( attacker ) )
        {
            continue;
        }
        else if ( damage < mindamage )
        {
            continue;
        }
        
        break;
    }
    
    scripts\sp\player_death::set_custom_death_quote( array_randomize( deathquotearray )[ 0 ] );
    missionfailedwrapper();
}

// Namespace namespace_37621323a9f8771f / namespace_60b2129b73c3e6f0
// Params 0
// Checksum 0x0, Offset: 0x96b
// Size: 0x80
function function_4c8825ce9cc1a7bf()
{
    self endon( "death" );
    veh_moving = 0;
    
    while ( true )
    {
        waitframe();
        
        if ( veh_moving == 0 && self vehicle_getspeed() > 1 )
        {
            playfxontag( getfx( "vfx_jup_milbase_tire_dust" ), self, "tag_origin" );
            veh_moving = 1;
        }
        else if ( veh_moving == 1 && self vehicle_getspeed() <= 1 )
        {
            stopfxontag( getfx( "vfx_jup_milbase_tire_dust" ), self, "tag_origin" );
            veh_moving = 0;
        }
        
        wait 1;
    }
}

// Namespace namespace_37621323a9f8771f / namespace_60b2129b73c3e6f0
// Params 3
// Checksum 0x0, Offset: 0x9f3
// Size: 0xd4
function function_28e3974653fdc037( cinematic_name, skip_waittill, var_f7bf02ab54fdcd73 )
{
    setomnvar( "ui_show_bink", 1 );
    setsaveddvar( @"bg_cinematicfullscreen", "1" );
    setsaveddvar( @"hash_b9ff37d084074df3", "1" );
    level.player cleardamageindicators();
    cinematicingame( cinematic_name );
    level.player scripts\sp\player::remove_damage_effects_instantly();
    remove_equipment_immediately();
    registered = "skippable_cinematic";
    
    while ( cinematicgettimeinmsec() == 0 )
    {
        wait 0.01;
    }
    
    time = cinematicgetlength();
    
    while ( cinematicgettimeinmsec() < ( time - 0.05 ) * 1000 )
    {
        waitframe();
    }
    
    setomnvar( "ui_show_bink", 0 );
}

