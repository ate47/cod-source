#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\samsite;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gametypes\dmz_ai_chopper;
#using scripts\mp\killstreaks\flares;

#namespace namespace_261788a314dc6d82;

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 0
// Checksum 0x0, Offset: 0x4d0
// Size: 0x4c9
function function_8063e641963cd522()
{
    level endon( "game_ended" );
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    if ( !isdefined( level.heligroups ) )
    {
        level.heligroups = [];
    }
    
    helis = [];
    var_f7c41a7192f6d0e7 = [];
    
    if ( isdefined( self.context ) )
    {
        helis = getstructarray( self.context, "script_noteworthy" );
    }
    else
    {
        index = randomintrange( 5, 9 );
        helis = getstructarray( "heli_group_" + index, "script_noteworthy" );
    }
    
    foreach ( var_ca5ae2c8e6c2c4db in helis )
    {
        spawndata = spawnstruct();
        spawndata.origin = var_ca5ae2c8e6c2c4db.origin;
        spawndata.angles = var_ca5ae2c8e6c2c4db.angles;
        goal = getstruct( var_ca5ae2c8e6c2c4db.target, "targetname" );
        endstruct = spawnstruct();
        endstruct.origin = goal.origin;
        endstruct.angles = goal.angles;
        helitype = var_ca5ae2c8e6c2c4db.script_helitype;
        
        if ( !isdefined( helitype ) )
        {
            helitype = "blima";
        }
        
        heli = undefined;
        
        if ( helitype == "blima" )
        {
            heli = vehicle_spawn( "veh9_blima", spawndata );
        }
        else if ( helitype == "ahotel64" )
        {
            heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter( undefined, spawndata.origin, spawndata.angles, "veh_apache_mp_phys", "veh9_mil_air_heli_ahotel64_mp" );
        }
        
        if ( !isdefined( heli ) )
        {
            assertmsg( "<dev string:x1c>" + helitype + "<dev string:x34>" );
            continue;
        }
        
        if ( helitype == "blima" )
        {
            heli setscriptablepartstate( "running_lights", "on" );
        }
        
        heli.goal = endstruct;
        heli.team = game[ "attackers" ];
        heli.helitype = helitype;
        
        if ( !istrue( self.var_74ade4b4040cee5e ) )
        {
            heli.script_vehicle_selfremove = 1;
        }
        
        heli setvehicleteam( heli.team );
        heli vehicleshowonminimap( 0 );
        function_8f862de8eb07febc( var_ca5ae2c8e6c2c4db );
        var_29953022b5e47547 = spawnstruct();
        var_29953022b5e47547.speed = var_ca5ae2c8e6c2c4db.speed;
        var_29953022b5e47547.script_accel = var_ca5ae2c8e6c2c4db.script_accel;
        var_29953022b5e47547.script_decel = var_ca5ae2c8e6c2c4db.script_decel;
        heli.var_918c5a31037e00ee = var_29953022b5e47547;
        heli thread function_1f16278bee52cdcb();
        var_2f04632a38b3fda1 = [];
        var_3a138683d726617 = [];
        var_ce2f5920d4d72bbd = [];
        curnode = goal;
        crashnode = undefined;
        var_fde45a9b7dbe3ee0 = scripts\common\vehicle_paths::get_path_getfunc( goal );
        
        while ( isdefined( curnode ) )
        {
            if ( isdefined( curnode.script_attack ) )
            {
                switch ( curnode.script_attack )
                {
                    case #"hash_a68928468343f517":
                        var_2f04632a38b3fda1[ var_2f04632a38b3fda1.size ] = curnode;
                        break;
                    case #"hash_d4850e4dfbc48417":
                        var_3a138683d726617[ var_3a138683d726617.size ] = curnode;
                        break;
                    case #"hash_21d3211c2a70f763":
                        var_ce2f5920d4d72bbd[ var_ce2f5920d4d72bbd.size ] = curnode;
                        break;
                    default:
                        break;
                }
            }
            
            if ( isdefined( curnode.script_crash ) )
            {
                crashnode = curnode;
            }
            
            function_8f862de8eb07febc( curnode );
            
            if ( !isdefined( curnode.target ) )
            {
                break;
            }
            
            curnode = [[ var_fde45a9b7dbe3ee0 ]]( curnode.target );
        }
        
        heli thread function_f77b04c9ef06ffc2( var_2f04632a38b3fda1 );
        heli thread function_9f8ad1e3fcdb0e96( var_3a138683d726617 );
        heli thread function_76b7690179dafa1a( var_ce2f5920d4d72bbd );
        heli thread function_c5d13507c6e77b01( crashnode );
        heli thread vehicle_paths_helicopter( goal );
        var_f7c41a7192f6d0e7[ var_f7c41a7192f6d0e7.size ] = heli;
        
        /#
            if ( getdvarint( @"hash_141444862e34853c", 0 ) == 1 )
            {
                heli.context = self.context;
                heli thread function_4ab89d873219016f();
            }
        #/
    }
    
    var_e3e68c2dd65aa2fa = self.context;
    
    if ( isdefined( var_e3e68c2dd65aa2fa ) && !isdefined( level.heligroups[ var_e3e68c2dd65aa2fa ] ) )
    {
        level.heligroups[ var_e3e68c2dd65aa2fa ] = [];
    }
    
    if ( isdefined( var_e3e68c2dd65aa2fa ) )
    {
        level.heligroups[ var_e3e68c2dd65aa2fa ] = var_f7c41a7192f6d0e7;
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0x9a1
// Size: 0x7f
function function_8f862de8eb07febc( pathnode )
{
    if ( !isdefined( pathnode.speed ) )
    {
        pathnode.speed = 120;
    }
    
    if ( !isdefined( pathnode.script_accel ) )
    {
        pathnode.script_accel = 30;
    }
    
    if ( !isdefined( pathnode.script_decel ) )
    {
        pathnode.script_decel = 60;
    }
    
    if ( !isdefined( pathnode.radius ) )
    {
        pathnode.radius = 200;
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 0
// Checksum 0x0, Offset: 0xa28
// Size: 0x3a
function function_1f16278bee52cdcb()
{
    self endon( "death" );
    self notify( "rumble_players" );
    self endon( "rumble_players" );
    
    while ( true )
    {
        playrumbleonposition( "cp_chopper_rumble", self.origin );
        wait 0.1;
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0xa6a
// Size: 0x13b
function function_f77b04c9ef06ffc2( var_ee677fcd79c75e20 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "reached_dynamic_path_end" );
    
    if ( !isdefined( var_ee677fcd79c75e20 ) )
    {
        return;
    }
    
    foreach ( var_383c132778424913 in var_ee677fcd79c75e20 )
    {
        rangesq = 900;
        
        if ( isdefined( var_383c132778424913.radius ) )
        {
            rangesq = squared( var_383c132778424913.radius );
        }
        
        while ( true )
        {
            waittill_any_2( "near_goal", "goal" );
            
            if ( distance2dsquared( self.origin, var_383c132778424913.origin ) < rangesq )
            {
                chance = randomintrange( 0, 100 );
                
                if ( chance <= 70 )
                {
                    if ( self.helitype == "blima" )
                    {
                        thread scripts\mp\killstreaks\flares::flares_playfx( "blima_flares" );
                    }
                    else if ( self.helitype == "ahotel64" )
                    {
                        thread scripts\mp\killstreaks\flares::flares_playfx();
                    }
                    else
                    {
                        thread scripts\mp\killstreaks\flares::flares_playfx();
                    }
                    
                    function_8d81149252d80ceb( 1 );
                }
                
                break;
            }
        }
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0xbad
// Size: 0x98
function function_c5d13507c6e77b01( crashnode )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "reached_dynamic_path_end" );
    
    if ( !isdefined( crashnode ) )
    {
        return;
    }
    
    rangesq = 10000;
    
    if ( isdefined( crashnode.radius ) )
    {
        rangesq = squared( crashnode.radius );
    }
    
    while ( true )
    {
        waittill_any_2( "near_goal", "goal" );
        
        if ( distance2dsquared( self.origin, crashnode.origin ) < rangesq )
        {
            function_1bb08cd0b88ec81a( crashnode );
            break;
        }
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0xc4d
// Size: 0x48
function function_1bb08cd0b88ec81a( crashnode )
{
    self notify( "explode" );
    
    if ( self.helitype == "blima" )
    {
        function_79a02040f342e81e();
        return;
    }
    
    if ( self.helitype == "ahotel64" )
    {
        function_8d81149252d80ceb();
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 0
// Checksum 0x0, Offset: 0xc9d
// Size: 0x1a5
function function_79a02040f342e81e()
{
    level endon( "game_ended" );
    self endon( "death" );
    crashspeed = self vehicle_getspeed();
    forwardvector = anglestoforward( self.angles );
    var_6ed1f464d9159628 = vectornormalize2( forwardvector );
    var_2e936f4c5bab6550 = self.origin + crashspeed * 300 * var_6ed1f464d9159628;
    var_6ccfa56282b69de2 = drop_to_ground( var_2e936f4c5bab6550, 0 );
    self vehicle_setspeed( 120 );
    self setvehgoalpos( var_6ccfa56282b69de2, 0 );
    thread scripts\mp\gametypes\dmz_ai_chopper::chopper_spinout( 500 );
    self setscriptablepartstate( "engine", "on", 1 );
    self setscriptablepartstate( "damageHeavy", "lowSpeed", 1 );
    self setscriptablepartstate( "damageEngine", "explode", 1 );
    var_c0f23cdfa369cf6c = 3;
    
    if ( self.origin[ 2 ] - var_6ccfa56282b69de2[ 2 ] > 1500 )
    {
        var_cd3b2619a1801602 = 1;
    }
    
    previousorigin = ( 0, 0, 0 );
    previoustime = gettime();
    
    while ( true )
    {
        if ( istrue( var_cd3b2619a1801602 ) )
        {
            if ( gettime() - previoustime > var_c0f23cdfa369cf6c * 1000 )
            {
                break;
            }
        }
        
        currentorigin = self.origin;
        
        if ( distancesquared( previousorigin, currentorigin ) < 1 )
        {
            break;
        }
        else
        {
            previousorigin = currentorigin;
        }
        
        waitframe();
    }
    
    earthquake( 0.2, 0.5, self.origin, 5000 );
    
    if ( vehicle_isalive( self ) )
    {
        scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
        vehicle_explode();
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0xe4a
// Size: 0xa9
function function_8d81149252d80ceb( var_9d830f5a7d530ac6 )
{
    var_28d44048103b0bb = getstructarray( "heli_sam_spawn_point", "script_noteworthy" );
    
    if ( var_28d44048103b0bb.size == 0 )
    {
        return;
    }
    
    var_138bad34c1065f2a = scripts\engine\utility::getclosest( self.origin, var_28d44048103b0bb );
    missile = magicbullet( makeweapon( "samsite_missile_weapon_launchfacility" ), var_138bad34c1065f2a.origin, self.origin );
    missile setmodel( "military_dmz_sam_site_missile" );
    missile setscriptablepartstate( "military_samsite_missile", "on" );
    missile thread function_3961f8cfae3964c4( self, var_9d830f5a7d530ac6 );
    missile thread function_5c96dd87e424af6c( self, var_9d830f5a7d530ac6 );
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 2
// Checksum 0x0, Offset: 0xefb
// Size: 0xa1
function function_3961f8cfae3964c4( target, var_9d830f5a7d530ac6 )
{
    level endon( "game_ended" );
    
    if ( isdefined( target ) )
    {
        if ( istrue( var_9d830f5a7d530ac6 ) )
        {
            fwd = anglestoforward( target.angles );
            self missile_settargetent( target, fwd * -1 * 500 );
        }
        else
        {
            self missile_settargetent( target );
        }
        
        self missile_setflightmodedirect();
        self.lockontarget = target;
        thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile( target, self );
        target waittill_any_3( "reached_dynamic_path_end", "death", "stop_lock_on" );
        
        if ( isdefined( self ) )
        {
            self notify( "clearTargetLockedOntoByProjectile" );
            self missile_cleartarget();
        }
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 2
// Checksum 0x0, Offset: 0xfa4
// Size: 0x9f
function function_5c96dd87e424af6c( target, var_9d830f5a7d530ac6 )
{
    level endon( "game_ended" );
    radiussq = 360000;
    
    if ( istrue( var_9d830f5a7d530ac6 ) )
    {
        radiussq = 1000000;
    }
    
    while ( true )
    {
        if ( !isdefined( self ) || !isdefined( target ) )
        {
            return;
        }
        
        distsq = distancesquared( target.origin, self.origin );
        
        if ( distsq < radiussq )
        {
            if ( istrue( var_9d830f5a7d530ac6 ) )
            {
                target notify( "stop_lock_on" );
                return;
            }
            
            target setcandamage( 0 );
            target thread function_11f0ee09b3a8c382();
            self delete();
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 0
// Checksum 0x0, Offset: 0x104b
// Size: 0x91
function function_11f0ee09b3a8c382()
{
    level endon( "game_ended" );
    self setscriptablepartstate( "explode", "on", 0 );
    self setscriptablepartstate( "explode_smoke", "on", 0 );
    earthquake( 0.2, 0.5, self.origin, 5000 );
    wait 0.35;
    
    if ( isdefined( self.turret ) )
    {
        self.turret setentityowner( undefined );
        self.turret delete();
    }
    
    scripts\common\vehicle_code::vehicle_deathcleanup();
    self notify( "deleted" );
    self delete();
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0x10e4
// Size: 0x191
function function_9f8ad1e3fcdb0e96( nodes )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "reached_dynamic_path_end" );
    
    if ( !isarray( nodes ) || nodes.size == 0 )
    {
        return;
    }
    
    if ( self.helitype != "ahotel64" )
    {
        assertmsg( "<dev string:x4a>" );
        return;
    }
    
    function_973ec034df8eb637();
    targetnode = random( nodes );
    rangesq = 900;
    
    if ( isdefined( targetnode.radius ) )
    {
        rangesq = squared( targetnode.radius );
    }
    
    while ( true )
    {
        waittill_any_2( "near_goal", "goal" );
        
        if ( distance2dsquared( self.origin, targetnode.origin ) < rangesq )
        {
            break;
        }
    }
    
    var_f02a7578af6a43e1 = 0.125;
    var_3180e2519441f60a = 40;
    shots = 0;
    turret = self.turret;
    targetent = turret.targetent;
    
    while ( shots < var_3180e2519441f60a )
    {
        targetent.origin = turret.origin + anglestoforward( turret.angles ) * 100 + ( 0, 0, -100 );
        
        if ( turret turretcantarget( targetent.origin ) )
        {
            turret snaptotargetentity( targetent );
        }
        
        turret shootturret();
        shots++;
        wait var_f02a7578af6a43e1;
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 0
// Checksum 0x0, Offset: 0x127d
// Size: 0x149
function function_973ec034df8eb637()
{
    var_d3145c3854a7f369 = "chopper_gunner_turret_ballistics_dmz";
    var_68651082b5622fc2 = "veh9_mil_air_heli_ahotel64_turret";
    turret = spawnturret( "misc_turret", self gettagorigin( "tag_turret" ), var_d3145c3854a7f369 );
    turret setmodel( var_68651082b5622fc2 );
    turret show();
    turret.angles = self.angles;
    turret.disabled = 0;
    turret.targetstate = undefined;
    turret linkto( self, "tag_turret" );
    turret setturretmodechangewait( 0 );
    turret setmode( "manual" );
    turret setdefaultdroppitch( 45 );
    turret.team = self.team;
    turret.owner = self;
    turret setturretteam( self.team );
    turret setentityowner( self );
    turret.targetent = spawn( "script_origin", turret.origin );
    turret settargetentity( turret.targetent );
    self.turret = turret;
    turret.heli = self;
    thread delete_on_death( turret );
    thread delete_on_death( turret.targetent );
    return turret;
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0x13cf
// Size: 0x24f
function function_76b7690179dafa1a( nodes )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "reached_dynamic_path_end" );
    
    if ( !isarray( nodes ) || nodes.size == 0 )
    {
        return;
    }
    
    if ( self.helitype != "ahotel64" )
    {
        assertmsg( "<dev string:x4a>" );
        return;
    }
    
    self.var_bdec9a74b3b2a503 = function_eb578b5a967c2ead( "tag_gun_l" );
    self.var_2d5a32b6a40fda8c = function_eb578b5a967c2ead( "tag_gun_r" );
    targetnode = random( nodes );
    rangesq = 900;
    
    if ( isdefined( targetnode.radius ) )
    {
        rangesq = squared( targetnode.radius );
    }
    
    while ( true )
    {
        waittill_any_2( "near_goal", "goal" );
        
        if ( distance2dsquared( self.origin, targetnode.origin ) < rangesq )
        {
            break;
        }
    }
    
    var_29dec34b4b2207cf = [ self.var_bdec9a74b3b2a503, self.var_2d5a32b6a40fda8c ];
    var_12270dcaca93f0f8 = 3;
    
    for ( i = 0; i < var_12270dcaca93f0f8 ; i++ )
    {
        foreach ( missilepod in var_29dec34b4b2207cf )
        {
            if ( missilepod == self.var_bdec9a74b3b2a503 )
            {
                missileindex = 1;
            }
            else
            {
                missileindex = 2;
            }
            
            missilepod thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_firemissilefx( missileindex );
            var_30c4f9b823c93ca7 = -30;
            viewforward = anglestoforward( self.angles ) * 100 + ( 0, 0, var_30c4f9b823c93ca7 );
            missilestart = missilepod.origin + viewforward;
            missileend = missilepod.origin + viewforward * 10;
            missile = scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon( "chopper_gunner_proj_dmz" ), missilestart, missileend );
            missile.owner = self;
            
            if ( isdefined( missile ) )
            {
                missile missile_settargetpos( missileend );
            }
            
            waitframe();
        }
        
        wait 0.2;
    }
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 1
// Checksum 0x0, Offset: 0x1626
// Size: 0x78
function function_eb578b5a967c2ead( tag )
{
    missilepod = spawn( "script_model", self gettagorigin( tag ) );
    missilepod setmodel( "ks_chopper_gunner_turret_mp" );
    missilepod show();
    missilepod.angles = self.angles;
    missilepod linkto( self, tag );
    missilepod setotherent( self );
    missilepod.heli = self;
    thread delete_on_death( missilepod );
    return missilepod;
}

// Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
// Params 0
// Checksum 0x0, Offset: 0x16a7
// Size: 0x31a
function function_a8b2c57a4f8b0fea()
{
    level endon( "game_ended" );
    struct = getstruct( "heli_spawn_point", "script_noteworthy" );
    spawndata = spawnstruct();
    spawndata.origin = struct.origin;
    spawndata.angles = struct.angles;
    var_1ba0e552ed27bb6e = spawnstruct();
    var_1ba0e552ed27bb6e.origin = spawndata.origin + ( 0, 0, 500 );
    var_1ba0e552ed27bb6e.angles = spawndata.angles;
    endpoint = getstruct( "heli_down_point", "script_noteworthy" );
    endstruct = spawnstruct();
    endstruct.origin = endpoint.origin;
    endstruct.angles = endpoint.angles;
    vehicle = vehicle_spawn( "veh9_blima", spawndata );
    vehicle freeentitysentient();
    vehicle setscriptablepartstate( "running_lights", "on" );
    vehicle.animname = "blima";
    vehicle.team = game[ "attackers" ];
    vehicle.var_918c5a31037e00ee = spawnstruct();
    vehicle.var_918c5a31037e00ee.speed = 60;
    vehicle vehicle_paths_helicopter( var_1ba0e552ed27bb6e );
    var_f3214a96c5a46947 = spawnstruct();
    var_f3214a96c5a46947.origin = ( 33619.5, 27220.8, 1511.35 );
    var_f3214a96c5a46947.angles = ( 0, 225.82, 0 );
    turret = scripts\cp_mp\samsite::function_fefa23bed4e70fb2( var_f3214a96c5a46947, "military_samsite_01_rig_skeleton_war_mode_mp" );
    scripts\cp_mp\samsite::function_f7c5fc38fdc4df8c( turret );
    missile_fired = turret.missile1;
    vehicle thread vehicle_paths_helicopter( endstruct );
    wait 6;
    turret.target_entity = vehicle;
    turret settargetentity( turret.target_entity );
    wait 3;
    turret thread scripts\cp_mp\samsite::function_44e4433ebac52609();
    wait 2;
    vehicle thread scripts\mp\killstreaks\flares::flares_playfx();
    playfx( getfx( "veh_jup_razorback_explosion" ), missile_fired.origin, anglestoforward( missile_fired.angles ), anglestoup( missile_fired.angles ) );
    missile_fired hide();
    vehicle setscriptablepartstate( "engine", "on" );
    vehicle setscriptablepartstate( "damageHeavy", "lowSpeed" );
    vehicle setscriptablepartstate( "damageEngine", "explode" );
    vehicle vehicle_setspeed( 120, 20, 10 );
    var_93a34a3ae3b00f17 = getstruct( "heli_crash_point", "script_noteworthy" );
    vehicle setvehgoalpos( var_93a34a3ae3b00f17.origin, 0 );
    vehicle thread scripts\mp\gametypes\dmz_ai_chopper::chopper_spinout( 100 );
    wait 10;
    
    if ( vehicle_isalive( vehicle ) )
    {
        vehicle scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
        vehicle scripts\cp_mp\vehicles\vehicle::vehicle_explode();
    }
}

/#

    // Namespace namespace_261788a314dc6d82 / namespace_f93036508852df50
    // Params 0
    // Checksum 0x0, Offset: 0x19c9
    // Size: 0x50, Type: dev
    function function_4ab89d873219016f()
    {
        level endon( "<dev string:x6e>" );
        self endon( "<dev string:x7c>" );
        
        if ( !isdefined( self.context ) )
        {
            return;
        }
        
        while ( true )
        {
            print3d( self.origin + ( 0, 0, 70 ), self.context );
            waitframe();
        }
    }

#/
