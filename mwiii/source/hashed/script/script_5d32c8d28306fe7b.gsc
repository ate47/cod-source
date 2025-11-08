#using script_16ea1b94f0f381b3;
#using script_63d03bd53d001217;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\utility\dvars;

#namespace perk_phd_flopper;

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 2
// Checksum 0x0, Offset: 0x31f
// Size: 0x9d
function function_ae33e22bc25c3920( str_currency, var_fe59c44529c721a0 )
{
    level thread function_f3a23df892bf82f6( "specialty_phd_flopper", str_currency, var_fe59c44529c721a0, &function_2d7074feba565a05, &function_9d625cc1b172d8a3 );
    level._effect[ "perk_phd_explode_sm" ] = loadfx( "vfx/jup/ob/gameplay/zm_weapons/vfx_perk_pdh_exp.vfx" );
    level._effect[ "perk_phd_explode_md" ] = loadfx( "vfx/jup/ob/gameplay/zm_weapons/vfx_perk_pdh_exp_med.vfx" );
    level._effect[ "perk_phd_explode_lg" ] = loadfx( "vfx/jup/ob/gameplay/zm_weapons/vfx_perk_pdh_exp_lg.vfx" );
    scripts\mp\damage::function_3e0f845008bbd48d( &function_c575026994a655b1 );
    level.var_bfe218a06bcd98de = throttle_initialize( "perk_phd_flopper", 2 );
}

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 0
// Checksum 0x0, Offset: 0x3c4
// Size: 0x16
function function_2d7074feba565a05()
{
    function_ab7a3ff9f75e4867( "specialty_phd_flopper" );
    thread dtp_fall_watcher();
}

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 4
// Checksum 0x0, Offset: 0x3e2
// Size: 0x2a
function function_9d625cc1b172d8a3( b_pause, str_perk, str_result, n_slot )
{
    function_3320652f06c48dae();
}

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 0
// Checksum 0x0, Offset: 0x414
// Size: 0x16
function function_3320652f06c48dae()
{
    self notify( "stop_dtp_fall_watcher" );
    function_fe0d28e6f0008329( "specialty_phd_flopper" );
}

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 10
// Checksum 0x0, Offset: 0x432
// Size: 0xa2
function function_c575026994a655b1( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( has_perk( "specialty_phd_flopper" ) )
    {
        if ( smeansofdeath == "MOD_FALLING" && self function_c36cfe1c6acaef46() )
        {
            return 0;
        }
        
        if ( smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_TRIGGER_HURT" && isplayer( eattacker ) && eattacker == self )
        {
            return 0;
        }
    }
    
    return undefined;
}

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 2
// Checksum 0x0, Offset: 0x4dd
// Size: 0x1f0
function function_6928d17346bd05f1( attacker, n_height )
{
    bundle = level.perkbundles[ "specialty_phd_flopper" ];
    var_e9520430205239af = default_to( bundle.var_ba47e4feaa48b320, 96 );
    var_dc910819a8dc7c52 = default_to( bundle.var_e76b605905032f5d, 300 );
    var_467d029427417a38 = default_to( bundle.var_a2a9a67545749a14, 150 );
    var_e0b61a5b5bf83df2 = default_to( bundle.var_1277e5b099b3fd62, 32 );
    var_d1f3779556d081a4 = default_to( bundle.var_60e612d2ef6a503c, 50 );
    
    if ( n_height < var_e9520430205239af )
    {
        n_radius = var_dc910819a8dc7c52;
        n_min_damage = var_467d029427417a38;
        n_boost = 5000;
        fx = getfx( "perk_phd_explode_sm" );
    }
    else if ( n_height >= var_e9520430205239af && n_height < var_e9520430205239af * 3 )
    {
        n_radius = var_dc910819a8dc7c52 * 2;
        n_min_damage = var_467d029427417a38 + var_d1f3779556d081a4;
        n_boost = 8000;
        fx = getfx( "perk_phd_explode_md" );
    }
    else
    {
        n_radius = var_dc910819a8dc7c52 * 4;
        n_min_damage = var_467d029427417a38 + var_d1f3779556d081a4 * 2;
        n_boost = 15000;
        fx = getfx( "perk_phd_explode_lg" );
    }
    
    println( "<dev string:x1c>" + n_height + "<dev string:x2f>" + n_radius + "<dev string:x3a>" );
    attacker thread function_a111e72b1d2f5d8e( attacker.origin, n_radius, n_min_damage, "MOD_EXPLOSIVE", n_boost, bundle );
    params = spawnstruct();
    params.explosionorigin = attacker.origin;
    params.var_b57d053d714f885f = n_height;
    attacker callback::callback( "phd_flopper_explosion", params );
    playfx( fx, attacker.origin );
}

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 6
// Checksum 0x0, Offset: 0x6d5
// Size: 0x34d
function function_a111e72b1d2f5d8e( origin, radius, min_damage, damage_mod, n_boost, bundle )
{
    self endon( "disconnect" );
    a_ai = getaiarrayinradius( origin, radius );
    a_enemies = [];
    
    foreach ( ai in a_ai )
    {
        if ( ai.team == self.team || ai.team == "neutral" )
        {
            continue;
        }
        
        a_enemies = array_add( a_enemies, ai );
    }
    
    var_5f6af5afd72c0ac2 = 0;
    radiusdamage( self.origin, radius, 1, 1, self, undefined, undefined, 1, 1 );
    
    for ( i = 0; i < a_enemies.size ; i++ )
    {
        e_enemy = a_enemies[ i ];
        
        if ( !isalive( e_enemy ) )
        {
            continue;
        }
        
        damage = 0;
        
        if ( isdefined( e_enemy.type ) && e_enemy.type == "human" )
        {
            damage = bundle.var_5a9fcf682931e28f;
        }
        
        if ( damage == 0 && isdefined( e_enemy.aicategory ) )
        {
            switch ( e_enemy.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                    damage = e_enemy.maxhealth;
                    break;
                case #"hash_8c089e813083e510":
                    damage = e_enemy.maxhealth * bundle.var_8b0484b4859f522d;
                    break;
                case #"hash_7b0e2f2ed84f34":
                    damage = e_enemy.maxhealth * bundle.var_c572f8be739b97ad;
                    break;
                case #"hash_7e8a002ed096276c":
                    damage = e_enemy.maxhealth * bundle.var_2c70514265ab8bef;
                    break;
            }
        }
        
        if ( damage == 0 )
        {
            var_43ea7ee7224a5f65 = namespace_53fc9ddbb516e6e1::function_560b2e700ce084a2( e_enemy.origin );
            damage = namespace_73f07f62510f0f5b::function_6f4c937aa843fac2( min_damage, var_43ea7ee7224a5f65, "frag_grenade", e_enemy.aicategory, e_enemy.maxhealth );
        }
        
        v_dir = vectornormalize( e_enemy.origin - self.origin );
        e_enemy dodamage( damage, e_enemy.origin, self, self, damage_mod, "<explicitweaponnone>", "torso_upper" );
        e_corpse = e_enemy getcorpseentity();
        
        if ( !isalive( e_enemy ) )
        {
            params = spawnstruct();
            params.player = self;
            e_enemy callback::callback( "phd_flopper_killed", params );
        }
        
        if ( isdefined( e_corpse ) && var_5f6af5afd72c0ac2 > 5 )
        {
            v_launch = v_dir * n_boost + ( 0, 0, 150 );
            e_corpse startragdollfromimpact( "torso_upper", v_launch );
            var_5f6af5afd72c0ac2++;
        }
        
        function_f632348cbb773537( level.var_bfe218a06bcd98de, e_enemy );
    }
}

// Namespace perk_phd_flopper / namespace_146054d2393fb6ab
// Params 0
// Checksum 0x0, Offset: 0xa2a
// Size: 0xde
function dtp_fall_watcher()
{
    self endon( "death_or_disconnect" );
    self endon( "stop_dtp_fall_watcher" );
    var_4376bdd48580556a = 0;
    var_53280e126ee4cdf5 = undefined;
    
    while ( true )
    {
        var_e57af20a66773aa7 = undefined;
        
        if ( self function_c36cfe1c6acaef46() )
        {
            if ( !var_4376bdd48580556a )
            {
                var_4376bdd48580556a = 1;
                var_53280e126ee4cdf5 = self.origin[ 2 ];
            }
            
            if ( self isonground() && var_4376bdd48580556a )
            {
                var_e57af20a66773aa7 = var_53280e126ee4cdf5 - self.origin[ 2 ];
                level function_6928d17346bd05f1( self, var_e57af20a66773aa7 );
                var_53280e126ee4cdf5 = undefined;
                var_4376bdd48580556a = 0;
                
                while ( self function_c36cfe1c6acaef46() )
                {
                    wait 0.1;
                }
            }
        }
        else if ( self isparachuting() || self isinfreefall() )
        {
            var_53280e126ee4cdf5 = undefined;
            var_4376bdd48580556a = 0;
        }
        else if ( var_4376bdd48580556a )
        {
            var_e57af20a66773aa7 = var_53280e126ee4cdf5 - self.origin[ 2 ];
            level function_6928d17346bd05f1( self, var_e57af20a66773aa7 );
            var_53280e126ee4cdf5 = undefined;
            var_4376bdd48580556a = 0;
        }
        
        waitframe();
    }
}

