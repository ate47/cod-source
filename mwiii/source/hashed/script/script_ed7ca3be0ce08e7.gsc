#using script_610f57bddd265be2;
#using scripts\common\debug;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;

#namespace namespace_67f87913935bfc5c;

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x4bf
// Size: 0xb
function autoexec main()
{
    level thread function_deee3b97bf9c0945();
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x4d2
// Size: 0x29
function function_deee3b97bf9c0945()
{
    if ( !getdvarint( @"hash_722967118d0ce787", 0 ) )
    {
        return;
    }
    
    waitframe();
    
    if ( !scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414() )
    {
        return;
    }
    
    level thread init();
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x503
// Size: 0x22
function init()
{
    if ( !getdvarint( @"redeploy_ascenders_enabled", 0 ) )
    {
        namespace_2c2703f78fc59600::initvariables();
    }
    
    drone_spawn();
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x52d
// Size: 0xd3
function drone_spawn()
{
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.05;
    }
    
    wait 23;
    drone = spawn( "script_model", anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 40000 + ( 0, 0, getdvarint( @"hash_d09e4b72069e9128", 12500 ) ) );
    drone setmodel( "veh9_mil_air_drone_supply_sweep" );
    drone.angles = ( 0, randomint( 360 ), 0 );
    drone.speed = 0;
    drone.health = getdvarint( @"hash_3b68b33598132a0", 270 );
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    scripts\mp\weapons::function_e00b77a9cb4d8322( drone );
    drone thread drone_movement();
    drone thread function_f9e2637633ed4523();
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x608
// Size: 0x211
function drone_movement()
{
    level endon( "game_ended" );
    self endon( "entitydeleted" );
    i_altitude = getdvarint( @"hash_d09e4b72069e9128", 12500 );
    
    /#
        if ( getdvarint( @"hash_d7987b5db214b981", 0 ) )
        {
            debug::debug_sphere( self, 25, ( 1, 0, 0 ), undefined, "<dev string:x1c>", "<dev string:x47>" );
            debug::draw_angles( self, undefined, 150, undefined, "<dev string:x1c>", "<dev string:x47>" );
        }
    #/
    
    s_goto = spawnstruct();
    i_angle = randomint( 360 );
    
    while ( self.health > 0 )
    {
        if ( level.br_circle.circleindex == level.var_fc4bb27a820f54dd.var_73610df6cb8260e6 )
        {
            drone_despawn();
            return;
        }
        
        while ( true )
        {
            v_anchor = ( scripts\mp\gametypes\br_circle::getsafecircleorigin()[ 0 ], scripts\mp\gametypes\br_circle::getsafecircleorigin()[ 1 ], i_altitude );
            i_angle += randomintrange( 90, 270 );
            
            if ( i_angle > 360 )
            {
                i_angle -= 360;
            }
            
            s_goto.origin = v_anchor + anglestoforward( ( 0, i_angle, 0 ) ) * randomintrange( 2500, 7500 );
            s_goto.angles = vectortoangles( s_goto.origin - self.origin );
            s_goto.angles = ( 0, s_goto.angles[ 1 ], 0 );
            
            if ( distance2dsquared( s_goto.origin, self.origin ) > squared( 2500 ) )
            {
                break;
            }
            
            waitframe();
        }
        
        self.var_3b4fee20d214bd9b = undefined;
        self.var_f44262daab1a384a = undefined;
        self.speed = 0;
        thread namespace_2c2703f78fc59600::function_6d9358d777958a1b( s_goto );
        thread namespace_2c2703f78fc59600::function_53a07930f4fc0e08( s_goto );
        thread namespace_2c2703f78fc59600::function_314cdfb5c5633b1();
        self waittill( "redeploy_drone_arrive" );
        
        while ( !isdefined( self.var_3b4fee20d214bd9b ) || !isdefined( self.var_f44262daab1a384a ) )
        {
            wait 1;
        }
    }
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x821
// Size: 0xf8
function drone_despawn()
{
    s_despawn = spawnstruct();
    var_9602b340166dcdd7 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    s_despawn.origin = self.origin + vectornormalize( self.origin - ( var_9602b340166dcdd7[ 0 ], var_9602b340166dcdd7[ 1 ], self.origin[ 2 ] ) ) * 20000;
    s_despawn.angles = vectortoangles( self.origin - ( var_9602b340166dcdd7[ 0 ], var_9602b340166dcdd7[ 1 ], self.origin[ 2 ] ) );
    self.var_3b4fee20d214bd9b = undefined;
    self.var_f44262daab1a384a = undefined;
    thread namespace_2c2703f78fc59600::function_6d9358d777958a1b( s_despawn );
    thread namespace_2c2703f78fc59600::function_53a07930f4fc0e08( s_despawn );
    
    while ( !isdefined( self.var_3b4fee20d214bd9b ) || !isdefined( self.var_f44262daab1a384a ) )
    {
        if ( self.health <= 0 )
        {
            return;
        }
        
        wait 0.05;
    }
    
    self notify( "relocation_complete" );
    self delete();
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x921
// Size: 0x238
function function_f9e2637633ed4523()
{
    level endon( "game_ended" );
    self endon( "entitydeleted" );
    
    while ( true )
    {
        self waittill( "damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( isplayer( eattacker ) )
        {
            eattacker scripts\cp_mp\damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
        }
        else if ( isdefined( eattacker.owner ) && isplayer( eattacker.owner ) )
        {
            eattacker.owner scripts\cp_mp\damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
        }
        
        if ( isdefined( eattacker.model ) && eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg" )
        {
            level thread namespace_2c2703f78fc59600::function_cf65fbc1c077fadb( eattacker, self.origin );
        }
        
        if ( isdefined( smeansofdeath ) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
        {
            idamage = int( idamage * level.var_fc4bb27a820f54dd.var_4b2cdacf483dccc4 );
        }
        
        if ( isdefined( modelname ) && modelname == "ks_airstrike_target_br_ch3" )
        {
            idamage = level.var_fc4bb27a820f54dd.var_71ba1ddbe86cab15;
        }
        
        self.health -= idamage;
        
        if ( isdefined( objweapon ) && isdefined( objweapon.basename ) && objweapon.basename == "toma_proj_mp" )
        {
            self.health = 0;
        }
        
        if ( self.health <= 0 )
        {
            drone_destroyed( eattacker );
            return;
        }
    }
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 1
// Checksum 0x0, Offset: 0xb61
// Size: 0x1d2
function drone_destroyed( eattacker )
{
    eattacker scripts\mp\utility\points::doscoreevent( #"hash_8f3a6840e401f2e3" );
    self setscriptablepartstate( "redeploy_drone_relocation_smoke_vfx", "enabled" );
    self physics_registerforcollisioncallback();
    thread namespace_2c2703f78fc59600::function_26aacbd66ab5c92();
    self waittill( "collision" );
    namespace_2c2703f78fc59600::redeploy_drone_explosion();
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, self.origin + ( 0, 0, 10 ), self.angles, self, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride );
    item = undefined;
    
    if ( randomint( 100 ) < 5 )
    {
        item = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_killstreak_auav", dropinfo, undefined, 1, undefined, 0 );
    }
    else
    {
        switch ( level.br_circle.circleindex )
        {
            case 0:
                item = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_killstreak_supply_sweep", dropinfo, undefined, 1, undefined, 0 );
                break;
            case 1:
                item = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_killstreak_scramblerdrone", dropinfo, undefined, 1, undefined, 0 );
                break;
            default:
                item = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_killstreak_uav_bigmap", dropinfo, undefined, 1, undefined, 0 );
                break;
        }
    }
    
    item thread function_f6825931489dc8a9( eattacker, "ui_icon_minimap_reward" );
    item thread function_9fe88329eea942f5();
    level thread function_5ad7013749e24080( self.origin + ( 0, 0, 10 ) );
    level thread function_3cfcb01c0c46b6c1( eattacker, self.origin + ( 0, 0, 10 ) );
    level thread drone_respawn();
    scripts\mp\weapons::function_1a33bd42949ccbda( self );
    self delete();
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 1
// Checksum 0x0, Offset: 0xd3b
// Size: 0xeb
function function_5ad7013749e24080( v_pos )
{
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo( scripts\mp\gametypes\br_public::droptogroundmultitrace( v_pos + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 10, 0, -500 ), ( 0, randomint( 360 ), 0 ) );
    
    if ( cointoss() )
    {
        scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_super_emppulse", dropinfo );
    }
    else
    {
        scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_super_tacticalcamera", dropinfo );
    }
    
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo( scripts\mp\gametypes\br_public::droptogroundmultitrace( v_pos + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 20, 0, -500 ), ( 0, randomint( 360 ), 0 ) );
    i = randomint( 100 );
    
    if ( i < 33 )
    {
        scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_offhand_decoy", dropinfo );
        return;
    }
    
    if ( i < 66 )
    {
        scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_offhand_shockstick", dropinfo );
        return;
    }
    
    scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_offhand_snapshot", dropinfo );
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 2
// Checksum 0x0, Offset: 0xe2e
// Size: 0x1c9
function function_3cfcb01c0c46b6c1( player, v_pos )
{
    i_yield = getdvarint( @"hash_78afb5674fadd4e", 3 );
    
    for ( i = 0; i < i_yield ; i++ )
    {
        dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo( scripts\mp\gametypes\br_public::droptogroundmultitrace( v_pos + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * ( i + 1 ) * 30, 0, -500 ), ( 0, randomint( 360 ), 0 ) );
        
        if ( scripts\engine\utility::cointoss() )
        {
            scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_armor_plate", dropinfo );
            continue;
        }
        
        var_92d8a509637fb29b = undefined;
        
        if ( isdefined( player ) && isplayer( player ) )
        {
            weapon = player getcurrentprimaryweapon();
            
            if ( issubstr( weapon.basename, "_ar" ) )
            {
                var_92d8a509637fb29b = "brloot_ammo_762";
            }
            else if ( issubstr( weapon.basename, "_pi" ) || issubstr( weapon.basename, "_sm" ) )
            {
                var_92d8a509637fb29b = "brloot_ammo_919";
            }
            else if ( issubstr( weapon.basename, "_sh" ) )
            {
                var_92d8a509637fb29b = "brloot_ammo_12g";
            }
            else if ( issubstr( weapon.basename, "_sn" ) || issubstr( weapon.basename, "_dm" ) )
            {
                var_92d8a509637fb29b = "brloot_ammo_50cal";
            }
            else
            {
                a_random = [ "brloot_ammo_762", "brloot_ammo_919", "brloot_ammo_12g", "brloot_ammo_50cal" ];
                var_92d8a509637fb29b = a_random[ randomint( a_random.size ) ];
            }
        }
        
        scripts\mp\gametypes\br_pickups::spawnpickup( var_92d8a509637fb29b, dropinfo );
    }
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 2
// Checksum 0x0, Offset: 0xfff
// Size: 0x160
function function_f6825931489dc8a9( eattacker, str_icon )
{
    objid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( getdvarint( @"hash_43cdbba4c39ba0cf", 0 ) )
    {
        objective_state( objid, "current" );
    }
    else
    {
        objective_state( objid, "active" );
    }
    
    objective_position( objid, self.origin );
    objective_sethideelevation( objid, 1 );
    objective_setplayintro( objid, 0 );
    objective_setdescription( objid, &"MP_BR_INGAME/REWARD_ICON_NAME_SUPPLY_SWEEP" );
    
    if ( getdvarint( @"hash_485f48117dd17e41", 0 ) )
    {
        objective_setshowdistance( objid, 1 );
    }
    else
    {
        objective_setshowdistance( objid, 0 );
    }
    
    if ( getdvarint( @"hash_780f489553661ec6", 0 ) )
    {
        objective_setshowoncompass( objid, 1 );
    }
    else
    {
        objective_setshowoncompass( objid, 0 );
    }
    
    objective_sethideonminimapwhenclipped( objid, 0 );
    scripts\mp\objidpoolmanager::update_objective_icon( objid, str_icon );
    scripts\mp\objidpoolmanager::update_objective_setbackground( objid, 5 );
    objective_removeallfrommask( objid );
    
    foreach ( player in scripts\mp\utility\teams::getteamdata( eattacker.team, "players" ) )
    {
        objective_addclienttomask( objid, player );
    }
    
    objective_showtoplayersinmask( objid );
    level thread function_c4648fa62189eba( self, objid );
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 2
// Checksum 0x0, Offset: 0x1167
// Size: 0x2b
function function_c4648fa62189eba( scriptable, objid )
{
    while ( isdefined( scriptable ) )
    {
        waitframe();
    }
    
    objective_hidefromplayersinmask( objid );
    scripts\mp\objidpoolmanager::returnobjectiveid( objid );
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x119a
// Size: 0x66
function function_9fe88329eea942f5()
{
    level endon( "game_ended" );
    i_radius = getdvarint( @"hash_88a67073d3a4010c", 300 );
    
    while ( isdefined( self ) )
    {
        a_players = scripts\mp\utility\player::getplayersinradius( self.origin, 300 );
        
        if ( a_players.size )
        {
            a_players[ 0 ] scripts\mp\utility\points::doscoreevent( #"hash_3344b8f2f73b922a" );
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_67f87913935bfc5c / namespace_7e5632fb8c75a1e1
// Params 0
// Checksum 0x0, Offset: 0x1208
// Size: 0xfc
function drone_respawn()
{
    level endon( "game_ended" );
    wait getdvarint( @"hash_764f944633363973", 55 );
    
    if ( level.br_circle.circleindex < level.var_fc4bb27a820f54dd.var_73610df6cb8260e6 )
    {
        drone = spawn( "script_model", anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 40000 + ( 0, 0, getdvarint( @"hash_d09e4b72069e9128", 12500 ) ) );
        drone setmodel( "veh9_mil_air_drone_supply_sweep" );
        drone.angles = ( 0, randomint( 360 ), 0 );
        drone.speed = 0;
        drone.health = getdvarint( @"hash_3b68b33598132a0", 270 );
        drone setcandamage( 1 );
        drone forcenetfieldhighlod( 1 );
        scripts\mp\weapons::function_e00b77a9cb4d8322( drone );
        drone thread drone_movement();
        drone thread function_f9e2637633ed4523();
    }
}

