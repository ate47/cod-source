#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\player_death;
#using scripts\sp\utility;

#namespace friendlyfire;

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x279
// Size: 0x104
function main()
{
    level.friendlyfire[ "min_participation" ] = -200;
    level.friendlyfire[ "max_participation" ] = 1000;
    level.friendlyfire[ "enemy_kill_points" ] = 250;
    level.friendlyfire[ "friend_kill_points" ] = -650;
    level.friendlyfire[ "point_loss_interval" ] = 1.25;
    level.friendlyfire[ "civilians_killed" ] = 0;
    level.friendlyfire[ "strict_ff" ] = 0;
    level.player.participation = 0;
    level.friendlyfiredisabled = 0;
    level.friendlyfiredisabledfordestructible = 0;
    setdvarifuninitialized( @"hash_55eae984217fc9b6", "0" );
    setdvarifuninitialized( @"hash_d8275bff94773942", "0" );
    setdvarifuninitialized( @"hash_3cb172760816c3bb", "-1" );
    scripts\engine\utility::flag_init( "friendly_fire_warning" );
    thread debug_friendlyfire();
    thread participation_point_flattenovertime();
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x385
// Size: 0x280
function debug_friendlyfire()
{
    /#
        setdvarifuninitialized( @"debug_friendlyfire", "<dev string:x1c>" );
        x = 0;
        y = 72;
        friendly_fire = newhudelem();
        friendly_fire.x = x;
        friendly_fire.y = y - 15;
        friendly_fire.alignx = "<dev string:x1e>";
        friendly_fire.aligny = "<dev string:x23>";
        friendly_fire.font = "<dev string:x27>";
        friendly_fire.fontscale = 1;
        friendly_fire.alpha = 0;
        civcount = newhudelem();
        civcount.x = x + 95;
        civcount.y = y;
        civcount.alignx = "<dev string:x1e>";
        civcount.aligny = "<dev string:x23>";
        civcount.font = "<dev string:x27>";
        civcount.fontscale = 1;
        civcount.alpha = 0;
        civilians = newhudelem();
        civilians.x = x;
        civilians.y = y;
        civilians.alignx = "<dev string:x1e>";
        civilians.aligny = "<dev string:x23>";
        civilians.font = "<dev string:x27>";
        civilians.fontscale = 1;
        civilians.alpha = 0;
        civilians.showtext = 0;
        
        for ( ;; )
        {
            if ( getdvar( @"debug_friendlyfire" ) == "<dev string:x30>" )
            {
                if ( !civilians.showtext )
                {
                    civilians.showtext = 1;
                    civilians settext( "<dev string:x32>" );
                }
                
                civcount.alpha = 1;
                civilians.alpha = 1;
                friendly_fire.alpha = 1;
            }
            else
            {
                civcount.alpha = 0;
                civilians.alpha = 0;
                friendly_fire.alpha = 0;
            }
            
            civcount setvalue( level.friendlyfire[ "<dev string:x46>" ] );
            friendly_fire setvalue( level.player.participation );
            wait 0.25;
        }
    #/
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x60d
// Size: 0x20
function apply_friendly_fire_damage_modifier( value )
{
    assert( isdefined( value ) );
    level.friendlyfire_damage_modifier = value;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x635
// Size: 0x15
function remove_friendly_fire_damage_modifier( value )
{
    level.friendlyfire_damage_modifier = undefined;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x652
// Size: 0x638
function friendly_fire_think( entity )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isdefined( entity.team ) )
    {
        entity.team = "allies";
    }
    
    level endon( "mission failed" );
    level thread notifydamage( entity );
    level thread notifydamagenotdone( entity );
    level thread notifydeath( entity );
    
    /#
        entity thread function_a54d84c849bd008b();
    #/
    
    for ( ;; )
    {
        if ( !isdefined( entity ) )
        {
            return;
        }
        
        if ( entity.health <= 0 )
        {
            return;
        }
        
        damage = undefined;
        attacker = undefined;
        direction = undefined;
        point = undefined;
        method = undefined;
        weaponname = undefined;
        var_d23f02852fed23f = undefined;
        entity waittill( "friendlyfire_notify", damage, attacker, direction, point, method, objweapon );
        
        if ( !isdefined( entity ) )
        {
            return;
        }
        
        if ( istrue( level.skip_friendly_fire_check ) || istrue( entity.skip_friendly_fire_check ) )
        {
            continue;
        }
        
        if ( !isdefined( attacker ) )
        {
            continue;
        }
        
        if ( isdefined( level.friendlyfire_damage_modifier ) )
        {
            damage *= level.friendlyfire_damage_modifier;
            damage = int( damage );
        }
        
        var_54c4c82bfa9fee40 = 0;
        
        if ( !isdefined( objweapon ) )
        {
            objweapon = entity.damageweapon;
        }
        
        if ( isplayer( attacker ) )
        {
            var_54c4c82bfa9fee40 = 1;
            
            if ( isdefined( objweapon ) && isnullweapon( objweapon ) )
            {
                var_54c4c82bfa9fee40 = 0;
            }
            
            if ( attacker isusingturret() )
            {
                var_54c4c82bfa9fee40 = 1;
            }
            
            if ( isdefined( var_d23f02852fed23f ) )
            {
                var_54c4c82bfa9fee40 = 1;
            }
        }
        else if ( isdefined( attacker.code_classname ) && attacker.code_classname == "script_vehicle" )
        {
            owner = attacker getvehicleowner();
            
            if ( isdefined( owner ) && isplayer( owner ) )
            {
                attacker = owner;
                var_54c4c82bfa9fee40 = 1;
            }
        }
        
        if ( !var_54c4c82bfa9fee40 )
        {
            continue;
        }
        
        killed = damage == -1;
        iscivilian = entity iscivilian();
        civiliankilled = iscivilian && killed;
        
        if ( getdvar( @"hash_d8275bff94773942" ) == "1" && iscivilian )
        {
            continue;
        }
        
        /#
            if ( getdvar( @"debug_friendlyfire" ) == "<dev string:x30>" )
            {
                if ( iscivilian )
                {
                    print3d( entity.origin + ( 0, 0, 50 ), entity.health, ( 1, 0, 0 ), 1, 0.5, 50 );
                }
            }
        #/
        
        if ( civiliankilled )
        {
            level.friendlyfire[ "civilians_killed" ] = level.friendlyfire[ "civilians_killed" ] + 1;
        }
        
        if ( !isdefined( entity.team ) )
        {
            continue;
        }
        
        same_team = entity isally();
        
        if ( !same_team && !civiliankilled )
        {
            if ( killed )
            {
                level.player.participation += level.friendlyfire[ "enemy_kill_points" ];
                participation_point_cap();
                return;
            }
            
            continue;
        }
        
        if ( !iscivilian && !killed )
        {
            addbattlechatternotify( entity, undefined, "friendly_fire" );
        }
        
        if ( istrue( level.no_friendly_fire_fail ) || istrue( entity.no_friendly_fire_fail ) )
        {
            continue;
        }
        
        if ( isdefined( level.friendly_fire_skip_function ) && [[ level.friendly_fire_skip_function ]]() )
        {
            continue;
        }
        
        if ( isdefined( method ) && istrue( level.no_friendly_fire_splash_damage ) )
        {
            if ( method == "MOD_PROJECTILE_SPLASH" )
            {
                continue;
            }
            
            if ( isexplosivedamagemod( method ) )
            {
                continue;
            }
        }
        
        if ( isdefined( objweapon ) )
        {
            basename = objweapon.basename;
            
            if ( basename == "claymore" )
            {
                continue;
            }
            
            if ( basename == "flash" )
            {
                continue;
            }
            
            if ( basename == "semtex" && isdefined( entity.semtexstuckto ) )
            {
                damage = 9999;
            }
            
            if ( basename == "throwingknife" )
            {
                damage = 9999;
            }
            
            if ( basename == "molotov" )
            {
                damage = 9999;
            }
        }
        
        if ( killed )
        {
            var_55d426dd45a49e09 = level.friendlyfire[ "strict_ff" ];
            
            if ( isdefined( self.strict_ff ) )
            {
                var_55d426dd45a49e09 = self.strict_ff;
            }
            
            var_c9999b7f48063a7b = getdvarint( @"hash_3cb172760816c3bb", -1 );
            
            if ( var_c9999b7f48063a7b > -1 )
            {
                var_55d426dd45a49e09 = var_c9999b7f48063a7b;
            }
            
            if ( var_55d426dd45a49e09 && !attacker enemy_is_visible() )
            {
                level.player.participation = level.friendlyfire[ "min_participation" ];
            }
            else if ( isdefined( entity.friend_kill_points ) )
            {
                level.player.participation += entity.friend_kill_points;
            }
            else
            {
                waittillframeend();
                penalty = attacker get_adjusted_friendly_kill_points( level.friendlyfire[ "friend_kill_points" ], method );
                level.player.participation += penalty;
                
                /#
                    if ( getdvarint( @"debug_friendlyfire" ) )
                    {
                        thread function_21e5e1027cea1a1d( penalty, entity.origin + ( 0, 0, 60 ), ( 1, 0, 0.1 ) );
                    }
                #/
            }
        }
        else
        {
            level.player.participation -= damage;
        }
        
        participation_point_cap();
        
        if ( check_grenade( entity, method ) && savecommit_aftergrenade() )
        {
            if ( killed )
            {
                return;
            }
            else
            {
                continue;
            }
        }
        
        if ( isdefined( level.friendly_fire_fail_check ) )
        {
            [[ level.friendly_fire_fail_check ]]( entity, damage, attacker, direction, point, method, weaponname );
            continue;
        }
        
        friendly_fire_checkpoints( civiliankilled );
    }
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 2
// Checksum 0x0, Offset: 0xc92
// Size: 0xa3
function get_adjusted_friendly_kill_points( penaltypoints, method )
{
    if ( isdefined( method ) && isexplosivedamagemod( method ) )
    {
        return penaltypoints;
    }
    
    if ( !self.lastenemykilltime && !self.lastenemydmgtime )
    {
        return penaltypoints;
    }
    
    mostrecent = get_most_recent_dmg_or_death_time();
    var_9a3457c4a803b506 = gettime() - mostrecent;
    
    if ( var_9a3457c4a803b506 > 1500 )
    {
        return penaltypoints;
    }
    
    factor = 1 - math::normalize_value( 0, 1500, var_9a3457c4a803b506 );
    var_a1aabf92e937bff0 = math::factor_value( penaltypoints, 0, factor );
    var_a1aabf92e937bff0 = int( var_a1aabf92e937bff0 );
    return var_a1aabf92e937bff0;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0xd3e
// Size: 0x5b
function get_most_recent_dmg_or_death_time()
{
    if ( !self.lastenemykilltime )
    {
        return self.lastenemydmgtime;
    }
    
    if ( !self.lastenemydmgtime )
    {
        return self.lastenemykilltime;
    }
    
    if ( self.lastenemydmgtime >= self.lastenemykilltime )
    {
        return self.lastenemydmgtime;
    }
    
    return self.lastenemykilltime;
}

/#

    // Namespace friendlyfire / scripts\sp\friendlyfire
    // Params 3
    // Checksum 0x0, Offset: 0xda1
    // Size: 0xdf, Type: dev
    function function_21e5e1027cea1a1d( value, origin, color )
    {
        frames = 40;
        zdiff = 1;
        alpha = 1;
        
        if ( isdefined( color ) )
        {
            txtcolor = color;
        }
        else
        {
            txtcolor = ( 1, 1, 1 );
        }
        
        size = 0.8;
        alphaminus = 1 / frames;
        toggle = 1;
        
        for ( i = 0; i < frames ; i++ )
        {
            print3d( origin, value, txtcolor, alpha, size, 1, 1 );
            alpha -= alphaminus;
            
            if ( toggle )
            {
                origin += ( 0, 0, zdiff );
                toggle = 0;
            }
            else
            {
                toggle = 1;
            }
            
            waitframe();
        }
    }

#/

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0xe88
// Size: 0x67
function iscivilian()
{
    if ( isdefined( self.setciviliankillcount ) )
    {
        return self.setciviliankillcount;
    }
    
    if ( isdefined( self.unittype ) && self.unittype == "civilian" )
    {
        return 1;
    }
    
    if ( isdefined( self.asmname ) && self.asmname == "civilian" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0xef7
// Size: 0x2a
function isally()
{
    if ( self.team == level.player.team )
    {
        return 1;
    }
    
    return 0;
}

/#

    // Namespace friendlyfire / scripts\sp\friendlyfire
    // Params 0
    // Checksum 0x0, Offset: 0xf29
    // Size: 0x114, Type: dev
    function function_a54d84c849bd008b()
    {
        self endon( "<dev string:x57>" );
        
        while ( true )
        {
            if ( getdvar( @"debug_friendlyfire" ) == "<dev string:x30>" )
            {
                text = undefined;
                color = undefined;
                scale = undefined;
                alpha = undefined;
                
                if ( !istrue( level.skip_friendly_fire_check ) && !istrue( self.skip_friendly_fire_check ) )
                {
                    if ( iscivilian() )
                    {
                        text = "<dev string:x5d>";
                        color = ( 1, 0, 0 );
                        scale = 0.5;
                        
                        if ( getdvar( @"hash_d8275bff94773942" ) == "<dev string:x30>" )
                        {
                            alpha = 0;
                        }
                        else
                        {
                            alpha = 1;
                        }
                    }
                    else if ( isally() )
                    {
                        text = "<dev string:x66>";
                        color = ( 0, 1, 0 );
                        scale = 0.6;
                        alpha = 1;
                    }
                    
                    if ( isdefined( text ) )
                    {
                        print3d( self.origin + ( 0, 0, 40 ), text, color, alpha, scale, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x1045
// Size: 0x9e
function friendly_fire_checkpoints( civiliankilled )
{
    if ( isdefined( level.failonfriendlyfire ) && level.failonfriendlyfire )
    {
        level thread missionfail( civiliankilled );
        return;
    }
    
    var_a5c198fa345b5cac = level.friendlyfiredisabledfordestructible;
    
    if ( isdefined( level.friendlyfire_destructible_attacker ) && civiliankilled )
    {
        var_a5c198fa345b5cac = 0;
    }
    
    if ( var_a5c198fa345b5cac )
    {
        return;
    }
    
    if ( level.friendlyfiredisabled == 1 )
    {
        return;
    }
    
    if ( level.player.participation <= level.friendlyfire[ "min_participation" ] )
    {
        level thread missionfail( civiliankilled );
    }
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 2
// Checksum 0x0, Offset: 0x10eb
// Size: 0xa0
function check_grenade( entity, method )
{
    if ( !isdefined( entity ) )
    {
        return 0;
    }
    
    wasgrenade = 0;
    objweapon = entity.damageweapon;
    
    if ( isdefined( objweapon ) && isnullweapon( objweapon ) )
    {
        wasgrenade = 1;
    }
    
    if ( isdefined( method ) && method == "MOD_GRENADE_SPLASH" )
    {
        wasgrenade = 1;
    }
    
    if ( isdefined( objweapon ) && objweapon.basename == "throwingknife" )
    {
        wasgrenade = 1;
    }
    
    if ( isdefined( objweapon ) && objweapon.basename == "molotov" )
    {
        wasgrenade = 1;
    }
    
    return wasgrenade;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1194
// Size: 0x5c, Type: bool
function savecommit_aftergrenade()
{
    currenttime = gettime();
    
    if ( currenttime < 4500 )
    {
        println( "<dev string:x6b>" );
        return true;
    }
    else if ( currenttime - level.autosave.lastautosavetime < 4500 )
    {
        println( "<dev string:xd4>" );
        return true;
    }
    
    return false;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x11f9
// Size: 0x94
function participation_point_cap()
{
    if ( level.player.participation > level.friendlyfire[ "max_participation" ] )
    {
        level.player.participation = level.friendlyfire[ "max_participation" ];
    }
    
    if ( level.player.participation < level.friendlyfire[ "min_participation" ] )
    {
        level.player.participation = level.friendlyfire[ "min_participation" ];
    }
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1295
// Size: 0x77
function participation_point_flattenovertime()
{
    level endon( "mission failed" );
    
    for ( ;; )
    {
        if ( level.player.participation > 0 )
        {
            level.player.participation--;
        }
        else if ( level.player.participation < 0 )
        {
            level.player.participation++;
        }
        
        wait level.friendlyfire[ "point_loss_interval" ];
    }
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1314
// Size: 0xc
function turnbackon()
{
    level.friendlyfiredisabled = 0;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1328
// Size: 0xd
function turnoff()
{
    level.friendlyfiredisabled = 1;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x133d
// Size: 0x153
function missionfail( civiliankilled )
{
    if ( !isdefined( civiliankilled ) )
    {
        civiliankilled = 0;
    }
    
    if ( getdvar( @"hash_55eae984217fc9b6" ) == "1" )
    {
        return;
    }
    
    if ( getdvarint( @"exec_review" ) > 0 )
    {
        return;
    }
    
    level.player endon( "death" );
    
    if ( !isalive( level.player ) )
    {
        return;
    }
    
    level endon( "mine death" );
    level notify( "mission failed" );
    level notify( "friendlyfire_mission_fail" );
    waittillframeend();
    setsaveddvar( @"hud_missionfailed", 1 );
    setomnvar( "ui_hide_weapon_info", 1 );
    setsaveddvar( @"hash_4e8225c28298a6ad", 0 );
    setsaveddvar( @"hash_9d7a2fa032e463d5", 1 );
    
    if ( isdefined( level.player.failingmission ) )
    {
        return;
    }
    
    if ( civiliankilled )
    {
        if ( isdefined( level.var_eed0b997e799ad2e ) )
        {
            scripts\sp\player_death::set_custom_death_quote( level.var_eed0b997e799ad2e );
        }
        else
        {
            scripts\sp\player_death::set_custom_death_quote( 499 );
        }
    }
    else if ( isdefined( level.custom_friendly_fire_message ) )
    {
        scripts\sp\player_death::set_custom_death_quote( level.custom_friendly_fire_message );
    }
    else
    {
        scripts\sp\player_death::set_custom_death_quote( 12 );
    }
    
    if ( isdefined( level.custom_friendly_fire_shader ) )
    {
        thread scripts\sp\player_death::set_death_icon( level.custom_friendly_fire_shader, 64, 64, 0 );
    }
    
    scripts\sp\utility::missionfailedwrapper();
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1498
// Size: 0x78
function ally_turn_on_player()
{
    level.player endon( "death" );
    self endon( "death" );
    self stopanimscripted();
    clear_force_color();
    val::set( "ai_turn_on_player", "ignoresuppression", 1 );
    clearthreatbias( "axis", "allies" );
    
    while ( true )
    {
        self.team = "axis";
        self.favoritenemy = level.player;
        wait 0.05;
    }
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x1518
// Size: 0x82
function notifydamage( entity )
{
    entity endon( "death" );
    
    for ( ;; )
    {
        entity waittill( "damage", damage, attacker, direction, point, method, unused, unused, unused, unused, objweapon );
        entity notify( "friendlyfire_notify", damage, attacker, direction, point, method, objweapon );
    }
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x15a2
// Size: 0x4f
function notifydamagenotdone( entity )
{
    entity waittill( "damage_notdone", damage, attacker, unused, unused, method );
    entity notify( "friendlyfire_notify", -1, attacker, undefined, undefined, method );
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x15f9
// Size: 0x43
function notifydeath( entity )
{
    entity waittill( "death", attacker, method, objweapon );
    entity notify( "friendlyfire_notify", -1, attacker, undefined, undefined, method, objweapon );
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x1644
// Size: 0xb
function detectfriendlyfireonentity( entity )
{
    
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1657
// Size: 0x17
function reset_friendlyfire_participation()
{
    level.player.participation = 0;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1676
// Size: 0xee, Type: bool
function enemy_is_visible()
{
    mostrecent = get_most_recent_dmg_or_death_time();
    var_9a3457c4a803b506 = gettime() - mostrecent;
    
    if ( var_9a3457c4a803b506 < 600 )
    {
        return true;
    }
    
    cos30 = 0.866025;
    
    foreach ( enemy in getaiarray( "axis" ) )
    {
        enemyvisible = math::within_fov_2d( level.player.origin, level.player.angles, enemy.origin, cos30 );
        enemyvisible &= enemy seerecently( level.player, 2 );
        
        if ( enemyvisible )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x176d
// Size: 0x14
function strict_ff_enable()
{
    level.friendlyfire[ "strict_ff" ] = 1;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 0
// Checksum 0x0, Offset: 0x1789
// Size: 0x13
function strict_ff_disable()
{
    level.friendlyfire[ "strict_ff" ] = 0;
}

// Namespace friendlyfire / scripts\sp\friendlyfire
// Params 1
// Checksum 0x0, Offset: 0x17a4
// Size: 0x25
function set_strict_ff( bool )
{
    assertex( isdefined( self ), "Cannot set strict ff as ent is undefined" );
    self.strict_ff = bool;
}

