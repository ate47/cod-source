#using script_3cb1beed718e7650;
#using script_4bac13d511590220;
#using scripts\aitypes\stealth;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\vehicle_aianim;
#using scripts\cp\astar;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\stealth\event;
#using scripts\stealth\manager;
#using scripts\vehicle\vehicle_common;

#namespace namespace_9189537c98b32e20;

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x5e1
// Size: 0xdf
function function_ddc83442e3d668a2()
{
    /#
        setdvarifuninitialized( @"hash_323c5dc40c71123b", 0 );
        setdvarifuninitialized( @"astar_debug", 0 );
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x1c>" );
        scripts\common\devgui::function_df648211d66cd3dd( "<dev string:x44>", "<dev string:x56>" );
        scripts\common\devgui::function_df648211d66cd3dd( "<dev string:x67>", "<dev string:x73>" );
        scripts\common\devgui::function_fe953f000498048f();
    #/
    
    level.var_1e27a0af989a26de = spawnstruct();
    level.var_1e27a0af989a26de.var_3b353dd024371978 = "boat_grid";
    level.var_1e27a0af989a26de.var_490a7f87881eec82 = "boat_search_start_node";
    level.var_1e27a0af989a26de.var_fdc0f69cfc0c50f4 = "boat_grid_center_nodes";
    level.var_1e27a0af989a26de.var_f626abb832f28059 = 3;
    level.var_1e27a0af989a26de.var_4152c54f5313e7db = 3;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6c8
// Size: 0x2
function private function_6dab410e5ceb1071()
{
    
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 6
// Checksum 0x0, Offset: 0x6d2
// Size: 0x1cb
function function_ec7209ab67c18011( veh_spawner, ai_spawners, patrol_start, var_aca8515371f9cc5e, var_4572269ac9c3d9a4, var_8dea32f301dcccc2 )
{
    flag_wait( "level_ready_for_script" );
    boat = self;
    function_c72ff775cd61b11( @"hash_42a7dc5bbe9d261e", 1, 0 );
    var_6bc03688e829aec1 = undefined;
    patrol_start = default_to( patrol_start, "boat_patrol_path_radiant" );
    
    if ( isstring( patrol_start ) )
    {
        var_6bc03688e829aec1 = getvehiclenode( patrol_start, "targetname" );
    }
    else
    {
        var_6bc03688e829aec1 = patrol_start;
    }
    
    boat.var_6bc03688e829aec1 = var_6bc03688e829aec1;
    boat.var_bf7bf8c7f826a84e = getvehiclenodeindex( var_6bc03688e829aec1.targetname, "targetname" );
    
    if ( isdefined( veh_spawner.var_a74a9efb6f5625bd ) )
    {
        boat.var_a74a9efb6f5625bd = veh_spawner.var_a74a9efb6f5625bd;
    }
    
    if ( isdefined( veh_spawner.var_4f5832ab692f249 ) )
    {
        boat.var_4f5832ab692f249 = veh_spawner.var_4f5832ab692f249;
    }
    
    if ( isdefined( veh_spawner.var_5defc868d3cf1117 ) )
    {
        boat.var_5defc868d3cf1117 = veh_spawner.var_5defc868d3cf1117;
    }
    
    boat function_c2038b032f620193();
    boat function_481c2a63f2ba3332( 0 );
    boat.currentnode = veh_spawner;
    boat.attachedpath = veh_spawner;
    boat function_2cc3ca6a47e4797e();
    boat.var_721298f6d1910c00 = 1;
    boat notify( "p2p_initialized" );
    veh_spawner.var_b4f37280e21bb388 = 1;
    boat function_8cc8823e44e405c2( ai_spawners, var_aca8515371f9cc5e );
    boat function_e0f6bd3e9722d395( var_4572269ac9c3d9a4, var_8dea32f301dcccc2 );
    boat setconfigvalue( "p2p", "manualSpeed", mph_to_ips( boat.patrol_speed ) );
    boat function_2b986086827eceac();
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 2
// Checksum 0x0, Offset: 0x8a5
// Size: 0x59
function function_e0f6bd3e9722d395( patrol_speed, combat_speed )
{
    self.patrol_speed = default_to( patrol_speed, level.var_1e27a0af989a26de.var_f626abb832f28059 );
    self.combat_speed = default_to( combat_speed, level.var_1e27a0af989a26de.var_4152c54f5313e7db );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x906
// Size: 0x194
function private function_c2038b032f620193()
{
    if ( !isdefined( self.var_9b068f7f14971da ) )
    {
        self.var_9b068f7f14971da = spawnstruct();
    }
    
    if ( isdefined( self.var_a74a9efb6f5625bd ) )
    {
        self.var_9b068f7f14971da.node_grid = getstructarray( self.var_a74a9efb6f5625bd, "script_noteworthy" );
    }
    else
    {
        self.var_9b068f7f14971da.node_grid = getstructarray( level.var_1e27a0af989a26de.var_3b353dd024371978, "script_noteworthy" );
    }
    
    if ( isdefined( self.var_5defc868d3cf1117 ) )
    {
        self.var_9b068f7f14971da.var_7695abc527a21c02 = getstructarray( self.var_5defc868d3cf1117, "targetname" );
    }
    else
    {
        self.var_9b068f7f14971da.var_7695abc527a21c02 = getstructarray( level.var_1e27a0af989a26de.var_490a7f87881eec82, "targetname" );
    }
    
    if ( isdefined( self.var_4f5832ab692f249 ) )
    {
        self.var_9b068f7f14971da.var_84566ff815e7d81c = getstructarray( self.var_4f5832ab692f249, "targetname" );
    }
    else
    {
        self.var_9b068f7f14971da.var_84566ff815e7d81c = getstructarray( level.var_1e27a0af989a26de.var_fdc0f69cfc0c50f4, "targetname" );
    }
    
    level.astar_node_radius_override = 6;
    level.var_71058efaa1d9efd3 = 6;
    level.var_9def439b33eac09d = 32;
    level.var_3d4b01e576456226 = 512;
    level.var_5590a4152d5e59db = 512;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xaa2
// Size: 0x93
function private function_f2fe2883cf45f93f()
{
    for ( i = 0; i < self.var_9b068f7f14971da.var_7695abc527a21c02.size ; i++ )
    {
        [ points, is_looping ] = namespace_ba155a12c323dc5a::function_3b0860e6185e09a1( self.var_9b068f7f14971da.var_7695abc527a21c02[ i ] );
        
        if ( !istrue( is_looping ) )
        {
            self.var_9b068f7f14971da.var_9c0f0cc54cc29d9d[ i ] = points[ points.size - 1 ];
        }
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0xb3d
// Size: 0x1b0
function function_2cc3ca6a47e4797e()
{
    if ( !self hascomponent( "p2p" ) )
    {
        self addcomponent( "p2p" );
    }
    
    if ( !self hascomponent( "path" ) )
    {
        self addcomponent( "path" );
    }
    
    self setconfigvalue( "p2p", "brakeAtGoal", 0 );
    self setconfigvalue( "p2p", "automaticFast", 1 );
    self setconfigvalue( "p2p", "brakeOnGoalGasbrake", 1 );
    self setconfigvalue( "p2p", "goalPoint", self.origin );
    self setconfigvalue( "p2p", "goalThreshold", 100 );
    self setconfigvalue( "p2p", "throttleSpeedClose", 1 );
    self setconfigvalue( "p2p", "throttleSpeedThreshold", 1 );
    self setconfigvalue( "p2p", "automaticFastTopspeedFraction", 1 );
    self setconfigvalue( "p2p", "throttleSpeedFarBelow", 10 );
    self setconfigvalue( "p2p", "throttleSpeedFarAbove", 1 );
    self setconfigvalue( "p2p", "throttleSpeedClose", 1 );
    self setconfigvalue( "p2p", "gasToStopMovement", 1 );
    self setconfigvalue( "p2p", "steeringMultiplier", 0.5 );
    self setconfigvalue( "p2p", "reverseGasNormal", 0.1 );
    self setconfigvalue( "path", "radiusToStep", 300 );
    self setconfigvalue( "path", "stepSpeedFactor", 2 );
    self setconfigvalue( "path", "yawHelper", 0 );
    self.dontunloadonend = 1;
    self.donotunloadondriverdeath = 1;
    self.dontunloadondeath = 1;
    self.stopping = 0;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 2
// Checksum 0x0, Offset: 0xcf5
// Size: 0x1af
function function_8cc8823e44e405c2( ai_spawners, var_aca8515371f9cc5e )
{
    vehicle = self;
    vehicle.var_b42547b593cc4de7 = ai_spawners;
    riders = [];
    identifier = vehicle.targetname;
    vehicle_data = undefined;
    
    if ( scripts\cp_mp\vehicles\vehicle::function_89dc39dc11f3988c( identifier ) )
    {
        vehicle_data = level.var_a0b2c978ca57ffc5[ identifier ];
    }
    
    riders = namespace_ba155a12c323dc5a::function_c1c8efc410395e96( vehicle_data, vehicle.vehicle_spawner, vehicle.var_b42547b593cc4de7, identifier );
    vehicleref = vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();
    
    if ( !vehicle ent_flag( "ai_initted" ) )
    {
        vehicle scripts\cp_mp\vehicles\vehicle::function_810dfd134e9a7a04( scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328( vehicleref ) );
    }
    
    vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_9e710c9f3a15ffda();
    vehicle thread scripts\cp_mp\vehicles\vehicle::function_f77e18d192719ac();
    
    foreach ( realai in riders )
    {
        vehicle scripts\common\vehicle_aianim::guy_enter( realai );
        
        if ( isdefined( var_aca8515371f9cc5e ) )
        {
            realai function_95d5375059c2a022( var_aca8515371f9cc5e );
        }
        
        if ( realai.vehicle_position == 0 )
        {
            vehicle.driver = realai;
            vehicle.aidriver = realai;
            vehicle.var_3816d927b2610b20 = undefined;
            vehicle scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( vehicle, realai.team );
            realai thread scripts\cp_mp\vehicles\vehicle::function_35f4a61ce36d99bb( vehicle );
        }
        else if ( realai.vehicle_position == 1 )
        {
            realai thread function_d51679e39e57584f();
        }
        
        realai thread function_88172ff6785f9adb();
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0xeac
// Size: 0x48
function function_88172ff6785f9adb()
{
    self endon( "death" );
    wasincombat = 0;
    
    while ( true )
    {
        isincombat = self.stealth_bsmstate == 3;
        
        if ( isincombat && !wasincombat )
        {
            scripts\common\ai::gun_recall();
        }
        
        wasincombat = isincombat;
        waitframe();
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0xefc
// Size: 0x6c
function function_d51679e39e57584f()
{
    self endon( "death" );
    self endon( "longdeath" );
    wait 5;
    
    while ( true )
    {
        vehicle = self._blackboard.currentvehicle;
        
        if ( !isdefined( vehicle ) )
        {
            return;
        }
        
        if ( vehicle.usedpositions[ 0 ] == 0 )
        {
            wait 1;
            scripts\vehicle\vehicle_common::function_ffd4bd7b834e69eb( 0 );
            thread function_dc9dca6ba6ee52ea( vehicle );
            return;
        }
        
        wait 0.2;
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0xf70
// Size: 0x5a
function function_dc9dca6ba6ee52ea( vehicle )
{
    self endon( "death" );
    self endon( "longdeath" );
    self endon( "stop_boat_driver_death" );
    
    while ( self._blackboard.var_9176cae5619d7fba != 0 )
    {
        waitframe();
    }
    
    vehicle function_23bfa180991fa189();
    vehicle.driver = self;
    vehicle thread function_2b986086827eceac();
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0xfd2
// Size: 0x14, Type: bool
function function_3f7620d0f13d270c()
{
    return scripts\anim\utility_common::canseeenemy( 0 ) && self canshootenemy( 0 );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0xfef
// Size: 0x56
function function_5c4665c8051db72e()
{
    self.node_grid = self.var_9b068f7f14971da.node_grid;
    self.var_7695abc527a21c02 = self.var_9b068f7f14971da.var_7695abc527a21c02;
    self.var_84566ff815e7d81c = self.var_9b068f7f14971da.var_84566ff815e7d81c;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x104d
// Size: 0x19
function function_2b986086827eceac()
{
    function_5c4665c8051db72e();
    thread function_4679fedb96354bdc();
    thread function_1980ef7169b522f0();
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x106e
// Size: 0xf7
function function_4679fedb96354bdc()
{
    if ( !isdefined( self.var_6bc03688e829aec1 ) && !isdefined( self.var_bf7bf8c7f826a84e ) )
    {
        return;
    }
    
    self setconfigvalue( "p2p", "goalPoint", self.var_6bc03688e829aec1.origin );
    duration = namespace_9246f10206f50768::get_duration_between_points( self.origin, self.var_6bc03688e829aec1.origin, mph_to_ips( 10 ) );
    waittill_any_timeout_1( duration, "near_goal" );
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.patrol_speed ) );
    self setconfigvalue( "p2p", "goalPoint", self.var_6bc03688e829aec1.origin );
    self setconfigvalue( "path", "radiantId", self.var_bf7bf8c7f826a84e );
    self setconfigvalue( "path", "radiusToStep", 275 );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x116d
// Size: 0x44
function function_1980ef7169b522f0()
{
    childthread boat_damageimpacthandler();
    childthread boat_watchfordriverdeath();
    childthread boat_watchforallpassengerdeath();
    thread function_5947333b3b9afab6();
    childthread boat_watchforstealthevents();
    childthread function_77b376403b188dcf();
    childthread boat_watchforboatlosagainsttheplayer();
    self.var_e79cae751a93915a = 0;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x11b9
// Size: 0x76
function function_5947333b3b9afab6()
{
    self notify( "endwatchforstuckthread" );
    self endon( "endwatchforstuckthread" );
    self endon( "stop_boat_driver_death" );
    self waittill( "path_blocked" );
    
    if ( !isdefined( self.var_137db9ce63442dab ) )
    {
        self.var_137db9ce63442dab = gettime();
        thread function_5947333b3b9afab6();
        return;
    }
    
    if ( gettime() - self.var_137db9ce63442dab > 1 )
    {
        self.var_137db9ce63442dab = undefined;
        thread function_5947333b3b9afab6();
        return;
    }
    
    thread function_471609f2086b630d( 5 );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x1237
// Size: 0x19e
function boat_watchforboatlosagainsttheplayer()
{
    self notify( "boat_watchForBoatLOSAgainstThePlayer" );
    self endon( "boat_watchForBoatLOSAgainstThePlayer" );
    self endon( "kill_combatp2p_thread" );
    self endon( "stop_boat_driver_death" );
    
    while ( true )
    {
        if ( isdefined( self.riders ) )
        {
            foreach ( rider in self.riders )
            {
                if ( function_d481de7db8db9597( rider ) || self.driver cansee( level.player ) )
                {
                    /#
                        if ( getdvarint( @"hash_323c5dc40c71123b" ) )
                        {
                            rider thread function_e31e954e5ae9ad1d( "<dev string:x7f>", ( 0, 0, 70 ), 0.8, ( 1, 0, 0 ) );
                        }
                    #/
                    
                    self notify( "boat_p2pNodeMovementThread" );
                    self setconfigvalue( "p2p", "pause", 1 );
                    self setconfigvalue( "path", "pause", 1 );
                    thread boat_watchforlostsightofplayer();
                    function_a227131b4c519fc6();
                    
                    if ( isdefined( self.driver.enemy ) && self.driver cansee( self.driver.enemy ) && !self.driver scripts\aitypes\stealth::iscombating() )
                    {
                        /#
                            if ( self.driver.enemy.notarget )
                            {
                                continue;
                            }
                        #/
                        
                        thread function_bf70661985d4dd18();
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x13dd
// Size: 0xd4
function function_bf70661985d4dd18()
{
    self endon( "stop_boat_driver_death" );
    event = spawnstruct();
    event.typeorig = "combat";
    event.type = "combat";
    event.origin = level.player.origin;
    event.investigate_pos = level.player.origin;
    self.driver getenemyinfo( level.player );
    waitframe();
    
    if ( !isalive( self.driver ) )
    {
        self notify( "stop_boat_driver_death" );
        return;
    }
    
    self.driver [[ self.driver.fnsetstealthstate ]]( "combat", event );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x14b9
// Size: 0x10e
function boat_watchforlostsightofplayer()
{
    self notify( "boat_watchForLostSightOfPlayer" );
    self endon( "boat_watchForLostSightOfPlayer" );
    self endon( "kill_combatp2p_thread" );
    self endon( "stop_boat_driver_death" );
    
    while ( true )
    {
        if ( isdefined( self.riders ) )
        {
            foreach ( rider in self.riders )
            {
                if ( function_d481de7db8db9597( rider ) )
                {
                    /#
                        if ( getdvarint( @"hash_323c5dc40c71123b" ) )
                        {
                            rider thread function_e31e954e5ae9ad1d( "<dev string:xa6>", ( 0, 0, 70 ), 0.8, ( 1, 0, 0 ) );
                        }
                    #/
                    
                    continue;
                }
                
                /#
                    if ( getdvarint( @"hash_323c5dc40c71123b" ) )
                    {
                        rider thread function_e31e954e5ae9ad1d( "<dev string:xc4>", ( 0, 0, 70 ), 0.8, ( 1, 0, 0 ) );
                    }
                #/
                
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x15cf
// Size: 0x44
function boat_watchfordriverdeath()
{
    self notify( "boat_watchForDriverDeath" );
    self endon( "boat_watchForDriverDeath" );
    self endon( "death" );
    
    while ( isalive( self.driver ) )
    {
        waitframe();
    }
    
    self notify( "stop_boat" );
    self notify( "stop_boat_driver_death" );
    function_a227131b4c519fc6();
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x161b
// Size: 0xd7
function boat_watchforallpassengerdeath()
{
    self notify( "boat_watchForAllPassengerDeath" );
    self endon( "boat_watchForAllPassengerDeath" );
    self endon( "death" );
    
    while ( true )
    {
        riders = array_removedead( self.riders );
        
        if ( riders.size == 0 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( self, "neutral" );
    self notify( "path_updated" );
    self notify( "newpath" );
    self setconfigvalue( "p2p", "brakeAtGoal", 1 );
    self stoppath();
    self vehicle_cleardrivingstate();
    self setconfigvalue( "p2p", "goalPoint", self.origin + anglestoforward( self.angles ) * 500 );
    self vehicle_turnengineoff();
    self setconfigvalue( "p2p", "pause", 1 );
    thread namespace_ba155a12c323dc5a::function_4a037e62a51e9372();
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x16fa
// Size: 0x151, Type: bool
function function_d481de7db8db9597( enemy )
{
    if ( !isdefined( enemy ) || !isalive( enemy ) )
    {
        return false;
    }
    
    canshootandsee = undefined;
    shotrecently = enemy._blackboard.shootparams_lastshoottime > gettime() - 1500;
    
    if ( shotrecently )
    {
        canseetarget = enemy scripts\anim\utility_common::canseeenemy( 0 );
        canshootandsee = canseetarget && enemy canshootenemy( 0 );
        
        if ( canshootandsee )
        {
            /#
                if ( getdvarint( @"hash_323c5dc40c71123b" ) )
                {
                    enemy thread function_e31e954e5ae9ad1d( "<dev string:xda>", ( 0, 0, 70 ), 0.8, ( 1, 0, 0 ) );
                }
            #/
            
            return true;
        }
    }
    
    if ( !isdefined( canshootandsee ) )
    {
        canseetarget = enemy scripts\anim\utility_common::canseeenemy( 0 );
        canshootandsee = canseetarget && enemy canshootenemy( 0 );
    }
    
    if ( isdefined( enemy.asmtrackasm ) && enemy scripts\asm\asm::asm_currentstatehasflag( enemy.asmtrackasm, "aim" ) && canshootandsee )
    {
        /#
            if ( getdvarint( @"hash_323c5dc40c71123b" ) )
            {
                enemy thread function_e31e954e5ae9ad1d( "<dev string:xed>", ( 0, 0, 70 ), 0.8, ( 1, 0, 0 ) );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x1854
// Size: 0xcf
function function_471609f2086b630d( delay )
{
    self endon( "death" );
    wait delay;
    self notify( "stop_boat_driver_death" );
    
    while ( true )
    {
        if ( isdefined( self.riders ) )
        {
            if ( self.riders.size > 0 )
            {
                foreach ( rider in self.riders )
                {
                    if ( scripts\anim\utility_common::player_can_see_ai( level.player, rider ) )
                    {
                        waitframe();
                        continue;
                    }
                    
                    if ( isdefined( rider.magic_bullet_shield ) && rider.magic_bullet_shield )
                    {
                        rider scripts\common\ai::stop_magic_bullet_shield();
                    }
                    
                    rider kill();
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x192b
// Size: 0x109
function boat_watchforstealthevents()
{
    self endon( "death" );
    self notify( "boat_watchForStealthEvents" );
    self endon( "boat_watchForStealthEvents" );
    self endon( "kill_hunt_threads" );
    self endon( "stop_boat_driver_death" );
    
    while ( true )
    {
        level waittill( "stealth_event", event, receiver );
        var_9c6956f1b781b001 = 0;
        
        foreach ( rider in self.riders )
        {
            if ( receiver == rider )
            {
                var_9c6956f1b781b001 = 1;
                break;
            }
        }
        
        if ( !istrue( var_9c6956f1b781b001 ) )
        {
            continue;
        }
        
        switch ( event.type )
        {
            case #"hash_f796130a9b9cec5":
            case #"hash_9e02cd4a0f3ca981":
                self notify( "stop_boat", "combat" );
                return;
            case #"hash_e21b072df2b47f94":
                self notify( "stop_boat", "combat" );
                return;
        }
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x1a3c
// Size: 0x5a
function function_a227131b4c519fc6( var_c941e222ce71fcec )
{
    if ( !istrue( var_c941e222ce71fcec ) )
    {
        if ( istrue( self.var_75101783bc8968c9 ) )
        {
            return;
        }
    }
    
    function_da0f909e75429e74();
    self setconfigvalue( "p2p", "pause", 1 );
    self setconfigvalue( "path", "pause", 1 );
    
    while ( self vehicle_getspeed() != 0 )
    {
        waitframe();
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x1a9e
// Size: 0x15b
function function_77b376403b188dcf( var_4117f5e06f35e9fb )
{
    self endon( "death" );
    self endon( "stop_boat_driver_death" );
    thread boat_watchforpathevents();
    
    while ( true )
    {
        waitframe();
        
        if ( !isalive( self.driver ) )
        {
            self notify( "stop_boat_driver_death" );
            return;
        }
        
        if ( self.driver scripts\aitypes\stealth::iscombating() )
        {
            function_6246adfa5a21cc0a();
            function_13a0b18a212ac196();
            continue;
        }
        
        if ( self.driver scripts\aitypes\stealth::ishunting() )
        {
            if ( scripts\stealth\manager::anyone_in_combat() )
            {
                foreach ( rider in self.riders )
                {
                    if ( function_d481de7db8db9597( rider ) || isdefined( rider.enemy ) && rider cansee( rider.enemy ) )
                    {
                        /#
                            if ( rider.enemy.notarget )
                            {
                                continue;
                            }
                        #/
                        
                        self.driver.stealth_bsmstate = 3;
                    }
                }
            }
            
            function_e870a3cd2688d180();
            function_4b080efe19670a2d();
            continue;
        }
        
        if ( self.driver scripts\aitypes\stealth::isinvestigating() )
        {
            function_bf70661985d4dd18();
        }
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x1c01
// Size: 0x74
function boat_watchforpathevents()
{
    self notify( "boat_watchForPathEvents" );
    self endon( "boat_watchForPathEvents" );
    
    while ( true )
    {
        waittill_either( "near_goal", "path_blocked" );
        
        if ( isdefined( self.riders ) && self.riders.size > 0 )
        {
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_323c5dc40c71123b" ) )
            {
                iprintln( "<dev string:xfe>" );
            }
        #/
        
        function_a227131b4c519fc6();
        return;
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x1c7d
// Size: 0x71
function function_6246adfa5a21cc0a()
{
    if ( self.var_e79cae751a93915a == 1 )
    {
        return;
    }
    
    self notify( "kill_hunt_threads" );
    self notify( "boat_p2pNodeMovementThread" );
    self endon( "end_idlepath" );
    self.var_e79cae751a93915a = 1;
    self.var_aca76688c7a95c17 = 0;
    self.var_75101783bc8968c9 = 0;
    self stoppath( 1 );
    self.driver getenemyinfo( level.player );
    thread boat_watchforboatlosagainsttheplayer();
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x1cf6
// Size: 0xe6
function function_4b080efe19670a2d()
{
    if ( scripts\stealth\manager::anyone_in_combat() )
    {
        return;
    }
    
    if ( self.var_e79cae751a93915a == 3 )
    {
        return;
    }
    
    self.var_e79cae751a93915a = 3;
    function_23bfa180991fa189();
    var_7fbf8136a156ddbb = getaiarray( "axis" )[ 0 ] lastknownpos( level.player );
    
    if ( isdefined( self.riders ) && self.riders.size > 0 )
    {
        foreach ( rider in self.riders )
        {
            if ( isdefined( rider ) )
            {
                var_7fbf8136a156ddbb = rider lastknownpos( level.player );
                break;
            }
        }
    }
    else
    {
        function_a227131b4c519fc6();
        return;
    }
    
    thread function_fc360dcb38689a0f( var_7fbf8136a156ddbb );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x1de4
// Size: 0x163
function function_e870a3cd2688d180()
{
    self endon( "forced_end_huntLKPState" );
    
    if ( scripts\stealth\manager::anyone_in_combat() )
    {
        return;
    }
    
    if ( self.var_e79cae751a93915a == 2 || self.var_e79cae751a93915a == 3 )
    {
        return;
    }
    
    self.var_e79cae751a93915a = 2;
    thread boat_watchforboatlosagainsttheplayer();
    childthread boat_playerproximitywatcher();
    childthread boat_stoponaidetection();
    childthread boat_watchforstealthevents();
    
    if ( !isdefined( self.driver.enemy ) || isdefined( self.driver.enemy ) && !isplayer( self.driver.enemy ) )
    {
        return;
    }
    
    var_7fbf8136a156ddbb = self.driver lastknownpos( self.driver.enemy );
    closest_point = getclosest( var_7fbf8136a156ddbb, self.node_grid );
    
    if ( function_3dc60303aeb13091( closest_point ) )
    {
        return;
    }
    
    childthread function_38ae9bf031879aa3( closest_point );
    self setconfigvalue( "p2p", "goalPoint", closest_point.origin );
    duration = namespace_9246f10206f50768::get_duration_between_points( self.origin, closest_point.origin, mph_to_ips( self.patrol_speed ) );
    waittill_any_timeout_1( duration, "near_goal" );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x1f4f
// Size: 0x2c, Type: bool
function function_3dc60303aeb13091( point )
{
    if ( array_contains( self.var_9b068f7f14971da.var_84566ff815e7d81c, point ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x1f84
// Size: 0x95
function function_13a0b18a212ac196()
{
    if ( self.var_aca76688c7a95c17 )
    {
        if ( !function_e447eac8f4eb6b8() )
        {
            function_a227131b4c519fc6();
            self.var_aca76688c7a95c17 = 0;
        }
        
        return;
    }
    
    if ( function_e447eac8f4eb6b8() )
    {
        self.driver.stealth_bsmstate = 2;
        
        if ( isdefined( level.player ) )
        {
            self.driver setthreatsight( level.player, 0 );
        }
        
        self.var_aca76688c7a95c17 = 1;
        function_8675ad097bb3809d( level.player.origin );
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x2021
// Size: 0x7d, Type: bool
function function_e447eac8f4eb6b8()
{
    foreach ( rider in self.riders )
    {
        if ( function_d481de7db8db9597( rider ) || rider cansee( level.player ) )
        {
            return false;
        }
    }
    
    if ( self vehicle_getspeed() > 3.5 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x20a7
// Size: 0x179
function boat_damageimpacthandler()
{
    self endon( "death" );
    self notify( "boat_damageImpactHandler" );
    self endon( "boat_damageImpactHandler" );
    level.player endon( "death" );
    self endon( "stop_boat_driver_death" );
    
    while ( true )
    {
        level.player waittill( "damage", damage, attacker, direction, point );
        
        if ( is_equal( attacker, self ) )
        {
            velocity = self vehicle_getspeed() * 75 * vectornormalize( direction );
            level.player setvelocity( velocity );
            
            if ( self vehicle_getspeed() > 9 )
            {
                level.player kill( point, self );
            }
            else if ( self vehicle_getspeed() > 0 )
            {
                level.player dodamage( damage, level.player.origin );
            }
            
            if ( self.riders.size == 0 )
            {
                return;
            }
            
            foreach ( rider in self.riders )
            {
                rider aieventlistenerevent( "proximity", level.player, level.player.origin );
            }
        }
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x2228
// Size: 0x1d2
function function_fc360dcb38689a0f( last_position )
{
    self.node_grid = self.var_9b068f7f14971da.node_grid;
    self.var_7695abc527a21c02 = self.var_9b068f7f14971da.var_7695abc527a21c02;
    self.var_84566ff815e7d81c = self.var_9b068f7f14971da.var_84566ff815e7d81c;
    
    if ( !isdefined( self.var_7695abc527a21c02 ) || self.var_7695abc527a21c02.size == 0 )
    {
        if ( isdefined( self.var_5defc868d3cf1117 ) )
        {
            self.var_9b068f7f14971da.var_7695abc527a21c02 = getstructarray( self.var_5defc868d3cf1117, "targetname" );
        }
        else
        {
            self.var_9b068f7f14971da.var_7695abc527a21c02 = getstructarray( level.var_1e27a0af989a26de.var_490a7f87881eec82, "targetname" );
        }
        
        self.var_7695abc527a21c02 = self.var_9b068f7f14971da.var_7695abc527a21c02;
    }
    
    self.var_b38003e45ca09d76 = self.var_7695abc527a21c02;
    startnode = undefined;
    
    if ( isdefined( last_position ) )
    {
        startnode = getclosest( last_position, self.var_7695abc527a21c02 );
    }
    else
    {
        startnode = random( self.var_7695abc527a21c02 );
        
        if ( !isdefined( startnode.angles ) )
        {
            startnode.angles = ( 0, 0, 0 );
        }
    }
    
    if ( !isdefined( startnode ) )
    {
        assertmsg( "Dungeon Boat - Some how couldn't find a start node; Info: " + self.var_5defc868d3cf1117 + ", self.node_grid_starts.size: " + self.var_7695abc527a21c02.size );
    }
    
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.patrol_speed ) );
    function_2cc3ca6a47e4797e();
    thread boat_gotosearchpathp2p( startnode );
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x2402
// Size: 0x24c
function boat_gotosearchpathp2p( startnode )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    self endon( "kill_hunt_threads" );
    self endon( "stop_boat_driver_death" );
    self notify( "boat_gotoSearchPathP2P" );
    self endon( "boat_gotoSearchPathP2P" );
    self.currentnode = startnode;
    nextnode = self.currentnode;
    self.var_3a2dad538c09be28 = startnode;
    self.var_c4ebc27445338878 = [];
    self.var_c4ebc27445338878 = array_add( self.var_c4ebc27445338878, startnode );
    nextnode = function_f0144da019d3204e( self.currentnode.target );
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.patrol_speed ) );
    
    while ( true )
    {
        waitframe();
        function_23bfa180991fa189();
        self setconfigvalue( "p2p", "goalPoint", nextnode.origin );
        duration = namespace_9246f10206f50768::get_duration_between_points( self.origin, nextnode.origin, mph_to_ips( self.patrol_speed ) );
        waittill_any_timeout_1( duration, "near_goal" );
        
        if ( isdefined( nextnode.target ) )
        {
            nextnode = function_f0144da019d3204e( nextnode.target );
        }
        else
        {
            self.var_b38003e45ca09d76 = array_remove( self.var_b38003e45ca09d76, self.var_3a2dad538c09be28 );
            self.var_c4ebc27445338878 = array_add( self.var_c4ebc27445338878, self.var_3a2dad538c09be28 );
            
            if ( self.var_b38003e45ca09d76.size == 0 )
            {
                self.var_b38003e45ca09d76 = self.var_7695abc527a21c02;
                self.var_c4ebc27445338878 = [];
            }
            
            startnode = getclosest( self.origin, self.var_b38003e45ca09d76 );
            function_38ae9bf031879aa3( startnode );
            self.var_3a2dad538c09be28 = startnode;
            
            if ( !isdefined( startnode.angles ) )
            {
                startnode.angles = ( 0, 0, 0 );
            }
            
            self.currentnode = startnode;
            nextnode = self.currentnode;
            nextnode = function_f0144da019d3204e( self.currentnode.target );
            continue;
        }
        
        self.currentnode = nextnode;
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x2656
// Size: 0x17f
function boat_playerproximitywatcher()
{
    self endon( "death" );
    self notify( "boat_playerProximityWatcher" );
    self endon( "boat_playerProximityWatcher" );
    self endon( "kill_hunt_threads" );
    main_rider = self.driver;
    
    while ( isalive( main_rider ) )
    {
        dist_sq = distancesquared( self.origin, level.player.origin );
        
        if ( main_rider [[ main_rider.fnisinstealthcombat ]]() )
        {
            main_rider.var_1cc2783745745c10 = undefined;
            
            if ( dist_sq < 110889 )
            {
                main_rider getenemyinfo( level.player );
            }
        }
        else if ( !main_rider.var_e31ee88092e41cc8 || !isdefined( main_rider.var_1cc2783745745c10 ) || distancesquared( main_rider.var_1cc2783745745c10, level.player.origin ) > 40000 )
        {
            if ( dist_sq < 90000 )
            {
                if ( function_4675d9e479f8f8d9( level.player ) != "back" )
                {
                    main_rider aieventlistenerevent( "cover_blown", level.player, level.player.origin );
                    scripts\stealth\event::event_broadcast_generic( "cover_blown", level.player.origin, 1500 );
                    main_rider.var_1cc2783745745c10 = level.player.origin;
                }
            }
        }
        
        wait 0.2;
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x27dd
// Size: 0xc8
function function_4675d9e479f8f8d9( enemy )
{
    directiontoenemy = vectornormalize( enemy.origin - self.origin );
    var_8e68e964194ca81c = anglestoforward( self.angles );
    var_67970c5e958526c6 = anglestoleft( self.angles );
    var_2b313da38fff8013 = vectordot( var_8e68e964194ca81c, directiontoenemy );
    leftdot = vectordot( var_67970c5e958526c6, directiontoenemy );
    direction = "front";
    
    if ( var_2b313da38fff8013 < -0.707 )
    {
        return "back";
    }
    
    if ( var_2b313da38fff8013 < 0.75 )
    {
        if ( leftdot >= 0 )
        {
            direction = "left";
        }
        else
        {
            direction = "right";
        }
    }
    
    return direction;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x28ae
// Size: 0xd2
function boat_stoponaidetection()
{
    self endon( "death" );
    self notify( "boat_stopOnAiDetection" );
    self endon( "boat_stopOnAiDetection" );
    self endon( "kill_hunt_threads" );
    self endon( "stop_boat_driver_death" );
    
    while ( true )
    {
        self waittill( "stop_boat", reason );
        function_a227131b4c519fc6();
        
        if ( isdefined( reason ) )
        {
            if ( isdefined( self.riders ) && self.riders.size > 0 )
            {
                foreach ( rider in self.riders )
                {
                    if ( isdefined( rider ) )
                    {
                        rider.ignoreme = 0;
                        rider.ignoreall = 0;
                    }
                }
            }
        }
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x2988
// Size: 0x1d
function function_da0f909e75429e74()
{
    self.var_75101783bc8968c9 = 1;
    self function_481c2a63f2ba3332( -1 );
    self vehicle_turnengineoff();
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0
// Checksum 0x0, Offset: 0x29ad
// Size: 0x1b
function function_23bfa180991fa189()
{
    self function_481c2a63f2ba3332( 0 );
    self vehicle_turnengineon();
    self.var_75101783bc8968c9 = 0;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x29d0
// Size: 0x2
function private function_2844a7382290611c()
{
    
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 2
// Checksum 0x0, Offset: 0x29da
// Size: 0x106
function function_270763f0236fea20( startnode, var_bee4565a93db8564 )
{
    self endon( "death" );
    self endon( "kill_combatp2p_thread" );
    self endon( "stop_boat_driver_death" );
    
    if ( istrue( var_bee4565a93db8564 ) )
    {
        self notify( "boat_p2pNodeMovementThread" );
        self endon( "boat_p2pNodeMovementThread" );
        self endon( "force_stop_combat_thread_located_player" );
    }
    else
    {
        self notify( "boat_p2pFindPathToDestinationThread" );
        self endon( "boat_p2pFindPathToDestinationThread" );
        self endon( "kill_hunt_threads" );
    }
    
    function_2cc3ca6a47e4797e();
    self.node_grid = self.var_9b068f7f14971da.node_grid;
    self.var_7695abc527a21c02 = self.var_9b068f7f14971da.var_7695abc527a21c02;
    move_speed = ter_op( istrue( var_bee4565a93db8564 ), mph_to_ips( self.combat_speed ), mph_to_ips( self.patrol_speed ) );
    self setconfigvalue( "p2p", "manualSpeed", move_speed );
    
    if ( istrue( var_bee4565a93db8564 ) )
    {
        function_d9e3bc55827b77e6( 1, startnode, move_speed );
    }
    else
    {
        while ( true )
        {
            function_d9e3bc55827b77e6( 0, startnode, move_speed );
        }
    }
    
    wait 1;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 3
// Checksum 0x0, Offset: 0x2ae8
// Size: 0x522
function function_d9e3bc55827b77e6( var_bee4565a93db8564, startnode, move_speed )
{
    dyn_node = spawnstruct();
    dyn_node.origin = self.origin;
    exclude = self;
    path_data = undefined;
    
    if ( istrue( var_bee4565a93db8564 ) )
    {
        start_pos = getclosest( self.origin, self.node_grid ).origin;
        end_pos = getclosest( startnode, self.node_grid ).origin;
        path_data = scripts\cp\astar::function_845fd743c0fadc39( self.node_grid, start_pos, end_pos, exclude, dyn_node, level.var_3d4b01e576456226, 1 );
    }
    else
    {
        start_pos = self.origin;
        end_pos = getclosest( startnode.origin, self.node_grid ).origin;
        path_data = scripts\cp\astar::function_845fd743c0fadc39( self.node_grid, start_pos, end_pos, exclude, dyn_node, level.var_5590a4152d5e59db );
    }
    
    /#
        if ( getdvarint( @"astar_debug", 0 ) )
        {
            sphere( end_pos, 50, ( 1, 0, 1 ), 0, 333 );
        }
    #/
    
    if ( !isdefined( path_data ) )
    {
        waitframe();
        return;
    }
    
    function_23bfa180991fa189();
    full_path = path_data.path;
    start_node = path_data.start_node;
    end_node = path_data.end_node;
    boat_path = [];
    boat_duration = [];
    
    foreach ( index, item in full_path )
    {
        item.claimed = 1;
        boat_path[ boat_path.size ] = item.origin;
        
        if ( isdefined( full_path[ index + 1 ] ) )
        {
            boat_duration[ boat_duration.size ] = namespace_9246f10206f50768::get_duration_between_points( item.origin, full_path[ index + 1 ].origin, move_speed );
        }
        else
        {
            boat_duration[ boat_duration.size ] = namespace_9246f10206f50768::get_duration_between_points( item.origin, full_path[ index - 1 ].origin, move_speed );
        }
        
        /#
            if ( getdvarint( @"astar_debug", 0 ) )
            {
                clr = ( 0, 1, 0 );
                sphere( item.origin, 64, clr, 0, 1000 );
                print3d( item.origin, "<dev string:x120>", clr, 1, 1, 1000, 1 );
            }
        #/
    }
    
    self.currentnode = startnode;
    self.attachedpath = startnode;
    self setconfigvalue( "p2p", "manualSpeed", move_speed );
    
    for ( i = 0; i < full_path.size ; i++ )
    {
        if ( distancesquared( full_path[ i ].origin, self.origin ) < squared( 64 ) )
        {
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_323c5dc40c71123b" ) )
            {
                sphere( full_path[ i ].origin, 50, ( 1, 0, 0 ), 0, 333 );
            }
        #/
        
        self setconfigvalue( "p2p", "goalPoint", full_path[ i ].origin );
        duration = boat_duration[ i ];
        
        /#
            if ( getdvarint( @"hash_323c5dc40c71123b" ) )
            {
                print3d( full_path[ i ].origin, "<dev string:x139>" + duration, ( 1, 0, 0 ), 1, 4, 100, 1 );
            }
        #/
        
        waittill_any_timeout_1( duration, "near_goal" );
        
        /#
            if ( getdvarint( @"hash_323c5dc40c71123b" ) )
            {
                sphere( full_path[ i ].origin, 50, ( 0, 1, 0 ), 0, 333 );
            }
        #/
        
        if ( full_path[ i ] == end_node )
        {
            if ( !istrue( var_bee4565a93db8564 ) )
            {
                wait 1;
            }
            
            /#
                if ( getdvarint( @"hash_323c5dc40c71123b" ) )
                {
                    iprintln( "<dev string:x146>" );
                }
            #/
            
            foreach ( index, item in full_path )
            {
                item.claimed = undefined;
            }
            
            if ( istrue( var_bee4565a93db8564 ) )
            {
                self.node_grid = self.var_9b068f7f14971da.node_grid;
                
                if ( scripts\stealth\manager::anyone_in_combat() )
                {
                    startnode = level.player.origin;
                }
                else
                {
                    self notify( "boat_p2pNodeMovementThread" );
                }
                
                break;
            }
            
            self.node_grid = self.var_9b068f7f14971da.node_grid;
            return;
        }
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3012
// Size: 0x2
function private function_503e1c36e775b943()
{
    
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x301c
// Size: 0x432
function function_8675ad097bb3809d( startnode )
{
    self endon( "death" );
    self notify( "boat_p2pNodeMovementThread" );
    self endon( "boat_p2pNodeMovementThread" );
    self endon( "kill_combatp2p_thread" );
    self endon( "stop_boat_driver_death" );
    self endon( "force_stop_combat_thread_located_player" );
    function_2cc3ca6a47e4797e();
    self.node_grid = self.var_9b068f7f14971da.node_grid;
    self.var_7695abc527a21c02 = self.var_9b068f7f14971da.var_7695abc527a21c02;
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.combat_speed ) );
    function_23bfa180991fa189();
    start_pos = getclosest( self.origin, self.node_grid ).origin;
    end_pos = getclosest( startnode, self.node_grid ).origin;
    exclude = self;
    dyn_node = spawnstruct();
    dyn_node.origin = self.origin;
    path_data = scripts\cp\astar::function_845fd743c0fadc39( self.node_grid, start_pos, end_pos, exclude, dyn_node, level.var_3d4b01e576456226, 1 );
    
    if ( !isdefined( path_data ) )
    {
        waitframe();
        return;
    }
    
    full_path = path_data.path;
    start_node = path_data.start_node;
    end_node = path_data.end_node;
    boat_path = [];
    boat_duration = [];
    
    foreach ( index, item in full_path )
    {
        item.claimed = 1;
        boat_path[ boat_path.size ] = item.origin;
        
        if ( isdefined( full_path[ index + 1 ] ) )
        {
            boat_duration[ boat_duration.size ] = namespace_9246f10206f50768::get_duration_between_points( item.origin, full_path[ index + 1 ].origin, mph_to_ips( self.combat_speed ) );
        }
        else
        {
            boat_duration[ boat_duration.size ] = namespace_9246f10206f50768::get_duration_between_points( item.origin, full_path[ index - 1 ].origin, mph_to_ips( self.combat_speed ) );
        }
        
        /#
            if ( getdvarint( @"astar_debug", 0 ) )
            {
                clr = ( 0, 1, 0 );
                sphere( item.origin, 64, clr, 0, 1000 );
                print3d( item.origin, "<dev string:x166>", clr, 1, 1, 1000, 1 );
            }
        #/
    }
    
    self.currentnode = startnode;
    self.attachedpath = startnode;
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.combat_speed ) );
    
    for ( i = 0; i < full_path.size ; i++ )
    {
        if ( distancesquared( full_path[ i ].origin, self.origin ) < squared( 64 ) )
        {
            continue;
        }
        
        self setconfigvalue( "p2p", "goalPoint", full_path[ i ].origin );
        duration = boat_duration[ i ];
        waittill_any_timeout_1( duration, "near_goal" );
        
        if ( full_path[ i ] == end_node )
        {
            foreach ( index, item in full_path )
            {
                item.claimed = undefined;
            }
            
            self.node_grid = self.var_9b068f7f14971da.node_grid;
            
            if ( scripts\stealth\manager::anyone_in_combat() )
            {
                startnode = level.player.origin;
            }
            else
            {
                self notify( "boat_p2pNodeMovementThread" );
            }
            
            break;
        }
    }
    
    wait 1;
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 1
// Checksum 0x0, Offset: 0x3456
// Size: 0x421
function function_38ae9bf031879aa3( startnode )
{
    self endon( "death" );
    self notify( "boat_p2pFindPathToDestinationThread" );
    self endon( "boat_p2pFindPathToDestinationThread" );
    self endon( "kill_combatp2p_thread" );
    self endon( "kill_hunt_threads" );
    self endon( "stop_boat_driver_death" );
    function_2cc3ca6a47e4797e();
    self.node_grid = self.var_9b068f7f14971da.node_grid;
    self.var_7695abc527a21c02 = self.var_9b068f7f14971da.var_7695abc527a21c02;
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.patrol_speed ) );
    
    while ( true )
    {
        start_pos = self.origin;
        end_pos = getclosest( startnode.origin, self.node_grid ).origin;
        exclude = self;
        dyn_node = spawnstruct();
        dyn_node.origin = self.origin;
        path_data = scripts\cp\astar::function_845fd743c0fadc39( self.node_grid, start_pos, end_pos, exclude, dyn_node, level.var_5590a4152d5e59db );
        
        if ( !isdefined( path_data ) )
        {
            waitframe();
            continue;
        }
        
        function_23bfa180991fa189();
        full_path = path_data.path;
        start_node = path_data.start_node;
        end_node = path_data.end_node;
        boat_path = [];
        boat_duration = [];
        
        foreach ( index, item in full_path )
        {
            item.claimed = 1;
            boat_path[ boat_path.size ] = item.origin;
            
            if ( isdefined( full_path[ index + 1 ] ) )
            {
                boat_duration[ boat_duration.size ] = namespace_9246f10206f50768::get_duration_between_points( item.origin, full_path[ index + 1 ].origin, mph_to_ips( self.patrol_speed ) );
            }
            else
            {
                boat_duration[ boat_duration.size ] = namespace_9246f10206f50768::get_duration_between_points( item.origin, full_path[ index - 1 ].origin, mph_to_ips( self.patrol_speed ) );
            }
            
            /#
                if ( getdvarint( @"astar_debug", 0 ) )
                {
                    clr = ( 0, 1, 0 );
                    sphere( item.origin, 64, clr, 0, 1000 );
                    print3d( item.origin, "<dev string:x120>", clr, 1, 1, 1000, 1 );
                }
            #/
        }
        
        self.currentnode = startnode;
        self.attachedpath = startnode;
        self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.patrol_speed ) );
        
        for ( i = 0; i < full_path.size ; i++ )
        {
            if ( distancesquared( full_path[ i ].origin, self.origin ) < squared( 64 ) )
            {
                continue;
            }
            
            self setconfigvalue( "p2p", "goalPoint", full_path[ i ].origin );
            duration = boat_duration[ i ];
            waittill_any_timeout_1( duration, "near_goal" );
            
            if ( full_path[ i ] == end_node )
            {
                wait 1;
                
                /#
                    if ( getdvarint( @"hash_323c5dc40c71123b" ) )
                    {
                        iprintln( "<dev string:x146>" );
                    }
                #/
                
                foreach ( index, item in full_path )
                {
                    item.claimed = undefined;
                }
                
                self.node_grid = self.var_9b068f7f14971da.node_grid;
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x387f
// Size: 0x2
function private function_6a7750a534755a28()
{
    
}

/#

    // Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
    // Params 4
    // Checksum 0x0, Offset: 0x3889
    // Size: 0xe6, Type: dev
    function function_e31e954e5ae9ad1d( msg, offset, scale, color )
    {
        self endon( "<dev string:x172>" );
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( offset ) )
        {
            offset = ( 0, 0, 0 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 0.25;
        }
        
        steps = 3 * scale * 20;
        alpha = 1;
        alpha_lerp = 1 / steps;
        
        for ( i = 0; i < steps ; i++ )
        {
            wait 0.05;
            alpha -= alpha_lerp;
            alpha = min( alpha, 1 );
            print3d( self.origin + offset, msg, color, alpha, scale );
            offset += ( 0, 0, 10 );
        }
    }

    // Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
    // Params 1
    // Checksum 0x0, Offset: 0x3977
    // Size: 0x20, Type: dev
    function function_da8a5262111c2ac( enemy )
    {
        direction = function_4675d9e479f8f8d9( enemy );
    }

    // Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
    // Params 1
    // Checksum 0x0, Offset: 0x399f
    // Size: 0x12a, Type: dev
    function function_fdecfbda4caef273( startstruct )
    {
        structs = [];
        structs[ structs.size ] = startstruct;
        structs[ structs.size ] = getstruct( startstruct.target, "<dev string:x178>" );
        
        for ( num = 1; isdefined( structs[ num ] ) && isdefined( structs[ num ].target ) && getstruct( structs[ num ].target, "<dev string:x178>" ) != startstruct ; num++ )
        {
            structs[ structs.size ] = getstruct( structs[ num ].target, "<dev string:x178>" );
        }
        
        points = [];
        
        foreach ( struct in structs )
        {
            /#
                sphere( struct.origin, 50, ( 1, 0, 0 ), 0, 5000 );
            #/
            
            points[ points.size ] = struct.origin;
        }
        
        return points;
    }

    // Namespace namespace_9189537c98b32e20 / namespace_43b3b385872f43b5
    // Params 2
    // Checksum 0x0, Offset: 0x3ad1
    // Size: 0x16a, Type: dev
    function get_points( startstruct, full_array )
    {
        structs = [];
        structs[ structs.size ] = startstruct;
        structs[ structs.size ] = getstruct( startstruct.target, "<dev string:x178>" );
        
        if ( !isdefined( structs[ structs.size ] ) )
        {
            if ( isdefined( full_array ) )
            {
                var_4385d19aded0c280 = [];
                
                foreach ( point in full_array )
                {
                    var_4385d19aded0c280 = array_add( var_4385d19aded0c280, point.origin );
                }
                
                return var_4385d19aded0c280;
            }
        }
        
        for ( num = 1; getstruct( structs[ num ].target, "<dev string:x178>" ) != startstruct ; num++ )
        {
            structs[ structs.size ] = getstruct( structs[ num ].target, "<dev string:x178>" );
        }
        
        points = [];
        
        foreach ( struct in structs )
        {
            points[ points.size ] = struct.origin;
        }
        
        return points;
    }

#/
