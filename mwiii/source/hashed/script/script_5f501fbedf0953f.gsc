#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_5753ba9c28794a65;
#using script_5d8202968463a21d;
#using script_7956d56c4922bd1;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;

#namespace namespace_acac8960cc6d8d64;

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0x9e3
// Size: 0x21a
function function_21672171040d6aae()
{
    activityvariantdefinition = namespace_c8e2077fca5ac679::function_b9c4aa88ad97ee68( self );
    self.var_3fe5574cd4504d62 = [];
    self.var_70b5f128bfa2986e = [];
    self.var_9009411bf4edf20b = [];
    self.var_d9a91303aea799de = undefined;
    self.s_center = getstruct( self.varianttag, "targetname" );
    self.var_d9a91303aea799de = function_b71aa24dbd5946e1();
    assertex( isdefined( self.var_d9a91303aea799de ), "<dev string:x1c>" );
    function_e6b1206e1d6c42a3( activityvariantdefinition );
    
    if ( !isdefined( self.s_center ) )
    {
        assertmsg( "<dev string:x49>" + self.varianttag + "<dev string:x86>" );
        return;
    }
    
    self.var_7f5ba3a22b83fd6c = "sg_" + self.varianttag;
    
    if ( !isdefined( stealthlookupgroup( self.var_7f5ba3a22b83fd6c ) ) )
    {
        stealthinitgroup( self.var_7f5ba3a22b83fd6c );
    }
    
    /#
        iprintln( "<dev string:x97>" + self.varianttag );
    #/
    
    namespace_d886885225a713a7::function_3e33031646de23b0( self );
    n_vehicles = undefined;
    self.var_55ee9d0a3adac4b9 = 0;
    self.var_802faecbf11b260c = 0;
    self.var_4e0002675594e13f = [];
    self.var_269a59bcee49ce1 = self.defaultspeed;
    function_2dac62aa2032b9b1( "SpatialZoneContainerGroup_ActivityInstance_AwarenessZone", &function_586d9c599add1552 );
    self.var_4e0002675594e13f = function_181fd18526171d6b( n_vehicles );
    self.var_3fe5574cd4504d62 = array_combine( self.var_3fe5574cd4504d62, self.var_4e0002675594e13f );
    self.var_55ee9d0a3adac4b9 = self.var_3fe5574cd4504d62.size;
    self.var_4e0002675594e13f = array_sort_by_script_index( self.var_4e0002675594e13f );
    
    foreach ( var_2b15ca08e0fc7b0 in self.var_4e0002675594e13f )
    {
        var_2b15ca08e0fc7b0 thread function_f0f07d0530132d6b( self );
    }
    
    thread armored_convoy_vehicle_update_spacing();
    namespace_68dc261109a9503f::function_b6fc2c96b463c007( self );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0xc05
// Size: 0x322
function function_e6b1206e1d6c42a3( var_28af8e747331e08d )
{
    if ( issharedfuncdefined( "armored_convoy_activity", "CustomParseParams" ) )
    {
        callsharedfunc( "armored_convoy_activity", "CustomParseParams", var_28af8e747331e08d );
    }
    
    self.ai_team = default_to( var_28af8e747331e08d.aiteam, "team_hundred_ninety" );
    self.slowspeed = default_to( var_28af8e747331e08d.slowspeed, 12 );
    self.medspeed = default_to( var_28af8e747331e08d.medspeed, 16 );
    self.highspeed = default_to( var_28af8e747331e08d.highspeed, 25 );
    self.extremespeed = default_to( var_28af8e747331e08d.extremespeed, 35 );
    self.defaultloot = default_to( var_28af8e747331e08d.defaultloot, "ob_jup_items_activity_armoredconvoy_green" );
    self.betterloot = default_to( var_28af8e747331e08d.betterloot, "ob_jup_items_activity_armoredconvoy_yellow" );
    self.cachescriptable = default_to( var_28af8e747331e08d.cachescriptable, "ob_loot_cache_convoy_01" );
    self.var_e63f28f54dc0a813 = istrue( var_28af8e747331e08d.var_e63f28f54dc0a813 );
    self.var_4f77d28d75ebd61c = var_28af8e747331e08d.var_4f77d28d75ebd61c;
    self.maxvehicles = 0;
    
    if ( issharedfuncdefined( "armored_convoy_activity", "GetMaxVehicles" ) )
    {
        self.maxvehicles = callsharedfunc( "armored_convoy_activity", "GetMaxVehicles" );
    }
    
    if ( isdefined( var_28af8e747331e08d ) )
    {
        switch ( var_28af8e747331e08d.defaultspeed )
        {
            case #"hash_3019364f12fc7058":
                self.defaultspeed = self.slowspeed;
                break;
            case #"hash_17bcce6c9cdcaab9":
                self.defaultspeed = self.medspeed;
                break;
            case #"hash_4fda5219ac1d2d5d":
                self.defaultspeed = self.highspeed;
                break;
            default:
                self.defaultspeed = self.slowspeed;
                break;
        }
        
        self.var_a5aa6c6f1908df45 = [];
        
        for ( i = 0; i < self.maxvehicles ; i++ )
        {
            riderencounter = "ai_encounter:armored_convoy_rider_enc_soldier";
            
            if ( issharedfuncdefined( "armored_convoy_activity", "GetRiderEncounterFromIndex" ) )
            {
                riderencounter = callsharedfunc( "armored_convoy_activity", "GetRiderEncounterFromIndex", i );
            }
            
            vehicleref = "veh_jup_pickup_2014";
            
            if ( issharedfuncdefined( "armored_convoy_activity", "GetVehicleRefFromIndex" ) )
            {
                vehicleref = callsharedfunc( "armored_convoy_activity", "GetVehicleRefFromIndex", i );
            }
            
            self.var_a5aa6c6f1908df45[ i ] = spawnstruct();
            self.var_a5aa6c6f1908df45[ i ].riderencounter = riderencounter;
            self.var_a5aa6c6f1908df45[ i ].vehicleref = vehicleref;
        }
        
        if ( self.var_a5aa6c6f1908df45.size > 0 )
        {
            self.maxvehicles = self.var_a5aa6c6f1908df45.size;
        }
        
        return;
    }
    
    self.defaultspeed = self.slowspeed;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0xf2f
// Size: 0x1a
function function_c4da40d7e3056ed6()
{
    thread function_e9c3e6397f1be2c4();
    thread function_aaf6792b4f3ff726();
    thread function_130f27dbf7b9d56b();
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0xf51
// Size: 0x85
function function_1f2529d9fe2f4432()
{
    foreach ( var_aa2e9d0ffa461472 in self.var_1c1e93b32ed347a7 )
    {
        if ( isdefined( function_9a39e23c3c52c2af( var_aa2e9d0ffa461472.var_542f8d001288419d ) ) )
        {
            function_adcc96a7d541aa36( var_aa2e9d0ffa461472.var_542f8d001288419d, 1 );
        }
    }
    
    thread namespace_34bf641998024ddb::function_a26e39e03a0d6739();
    thread function_ee03881506b0073d();
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0xfde
// Size: 0xc4
function function_ee03881506b0073d()
{
    if ( isdefined( self.var_9009411bf4edf20b ) )
    {
        foreach ( loot_cache in self.var_9009411bf4edf20b )
        {
            loot_cache thread function_c7ac73247f7cda();
        }
    }
    
    if ( isdefined( self.var_3fe5574cd4504d62 ) )
    {
        foreach ( vehicle in self.var_3fe5574cd4504d62 )
        {
            vehicle thread function_4df7515bfada9f28();
        }
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10aa
// Size: 0x4b
function private function_c7ac73247f7cda()
{
    self notify( "armored_convoy_crate_cleanup_singleton" );
    self endon( "armored_convoy_crate_cleanup_singleton" );
    
    while ( isdefined( self ) )
    {
        players = scripts\mp\utility\player::getplayersinradius( self.origin, 6000 );
        
        if ( players.size == 0 )
        {
            self freescriptable();
            break;
        }
        
        wait 30;
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10fd
// Size: 0x59
function private function_4df7515bfada9f28()
{
    self notify( "armored_convoy_vehicle_cleanup_singleton" );
    self endon( "armored_convoy_vehicle_cleanup_singleton" );
    self endon( "death" );
    self endon( "entitydeleted" );
    
    while ( isdefined( self ) )
    {
        players = scripts\mp\utility\player::getplayersinradius( self.origin, 6000 );
        
        if ( players.size == 0 )
        {
            self delete();
            break;
        }
        
        wait 30;
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0x115e
// Size: 0x76
function function_5b846516c4a7f320()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    centerpoint = undefined;
    
    if ( isdefined( self.var_3fe5574cd4504d62 ) && self.var_3fe5574cd4504d62.size > 0 )
    {
        vehicle = self.var_3fe5574cd4504d62[ 0 ];
        
        if ( isdefined( vehicle ) && isalive( vehicle ) )
        {
            centerpoint = self.var_3fe5574cd4504d62[ 0 ].origin;
        }
    }
    
    return centerpoint;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0x11dd
// Size: 0x170
function function_130f27dbf7b9d56b()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    ai_array = self.var_70b5f128bfa2986e;
    
    while ( true )
    {
        ai_array = array_removedead_or_dying( ai_array );
        
        if ( ai_array.size <= 3 )
        {
            break;
        }
        
        wait 1;
    }
    
    foreach ( veh in self.var_3fe5574cd4504d62 )
    {
        params = spawnstruct();
        params.activity_instance = self;
        params.players = self.playerparticipants;
        veh callback::callback( "veh_on_convoy_ended", params );
    }
    
    vh_array = function_fdc9d5557c53078e( self.var_3fe5574cd4504d62 );
    
    if ( isdefined( vh_array ) && vh_array.size > 0 )
    {
        if ( issharedfuncdefined( "armored_convoy_activity", "PlayVehDestroyedVO" ) )
        {
            callsharedfunc( "armored_convoy_activity", "PlayVehDestroyedVO", self, 1 );
        }
        else
        {
            thread namespace_277c27ef297ef569::function_1281c7fff9456e18( "activity_armored_convoy_vehicles_remain_broadcast" );
        }
    }
    else if ( issharedfuncdefined( "armored_convoy_activity", "PlayVehDestroyedVO" ) )
    {
        callsharedfunc( "armored_convoy_activity", "PlayVehDestroyedVO", self );
    }
    else
    {
        thread namespace_277c27ef297ef569::function_1281c7fff9456e18( "activity_armored_convoy_vehicles_destroyed_broadcast" );
    }
    
    waitframe();
    namespace_68dc261109a9503f::endactivity( self, 1 );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1355
// Size: 0x199
function private function_aaf6792b4f3ff726()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    self endon( "under_attack" );
    self endon( "vehicle_down" );
    self endon( "player_spotted" );
    self endon( "armored_convoy_stuck" );
    
    while ( !istrue( self.var_de6f66d8d51587f1 ) )
    {
        array = self.var_3fe5574cd4504d62;
        
        foreach ( member in array )
        {
            if ( isdefined( member ) )
            {
                players = scripts\mp\utility\player::getplayersinradius( member.origin, 1500 );
                
                if ( players.size > 0 )
                {
                    foreach ( player in players )
                    {
                        if ( !player.notarget )
                        {
                            b_trace_passed = scripts\engine\trace::ray_trace_passed( player geteye(), member.origin + ( 0, 0, 30 ), [ player, member ] );
                            
                            if ( b_trace_passed == 1 )
                            {
                                if ( issharedfuncdefined( "armored_convoy_activity", "PlayEngageVO" ) )
                                {
                                    callsharedfunc( "armored_convoy_activity", "PlayEngageVO", self, 1 );
                                }
                                else
                                {
                                    thread namespace_277c27ef297ef569::function_1281c7fff9456e18( "activity_armored_convoy_engage_enemy_broadcast" );
                                }
                                
                                self notify( "player_spotted" );
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x14f6
// Size: 0x1cb
function private function_233138b73388d497()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    self endon( "under_attack" );
    self endon( "vehicle_down" );
    self endon( "player_spotted" );
    self endon( "armored_convoy_stuck" );
    
    while ( !istrue( self.var_de6f66d8d51587f1 ) )
    {
        foreach ( vehicle in self.var_3fe5574cd4504d62 )
        {
            if ( isdefined( vehicle ) )
            {
                if ( !isdefined( vehicle.lastposition ) )
                {
                    vehicle.lastposition = vehicle.origin;
                    vehicle.stucktime = 0;
                    continue;
                }
                
                positiondifference = vehicle.lastposition - vehicle.origin;
                difference = length2d( positiondifference );
                
                if ( difference < 1 )
                {
                    vehicle.stucktime += 0.05;
                }
                else
                {
                    vehicle.stucktime = 0;
                }
                
                /#
                    drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                    
                    if ( drawdebug && vehicle.stucktime > 0 )
                    {
                        print3d( vehicle getcentroid() + ( 0, 0, 100 ), "<dev string:xbb>" + vehicle.stucktime, ( 1, 1, 0 ), 1, 1, 1, 0 );
                    }
                #/
                
                if ( vehicle.stucktime > 8 )
                {
                    self notify( "armored_convoy_stuck" );
                }
                
                vehicle.lastposition = vehicle.origin;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x16c9
// Size: 0xbb
function private function_e9c3e6397f1be2c4()
{
    waittill_any_4( "vehicle_down", "player_spotted", "under_attack", "armored_convoy_stuck" );
    a_vehicles = self.var_3fe5574cd4504d62;
    self.var_de6f66d8d51587f1 = 1;
    
    foreach ( vehicle in a_vehicles )
    {
        if ( !istrue( vehicle.isunloaded ) )
        {
            vehicle notify( "engage" );
            vehicle thread function_9cdfbab7600978aa( self );
        }
        
        n_wait = randomfloatrange( 0.5, 1.1 );
        wait n_wait;
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x178c
// Size: 0x122
function private function_73ebd648f533a034( activityinstance )
{
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( 0 ) );
    self vehicle_setspeedimmediate( 0, 1, 1 );
    self vehicle_cleardrivingstate();
    
    if ( self hascomponent( "p2p" ) )
    {
        self removecomponent( "p2p" );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self removecomponent( "path" );
    }
    
    if ( self hascomponent( "animator" ) )
    {
        self removecomponent( "animator" );
    }
    
    self vehphys_parkingbrake( 1 );
    waitframe();
    function_6590c1e6e798dd19();
    self waittill( "unloaded" );
    self.var_aa4804cc1bc59e93 = undefined;
    self.isunloaded = 1;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( self, "neutral" );
    self setscriptablepartstate( "single", "vehicle_use" );
    self vehicleClearAnims();
    self vehphys_parkingbrake( 0 );
    
    if ( istrue( activityinstance.var_e63f28f54dc0a813 ) )
    {
        function_2169641d6a403864( self.var_542f8d001288419d );
        function_adcc96a7d541aa36( self.var_542f8d001288419d, 0 );
    }
    
    activityinstance.var_21f1863c6d44d936[ self.var_542f8d001288419d ] = undefined;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18b6
// Size: 0x163
function private function_9cdfbab7600978aa( activityinstance )
{
    crash_speed = self vehicle_getspeed();
    crash_dist = randomfloatrange( 150, 225 );
    crash_angle = randomfloatrange( 15, 30 );
    crash_yaw = ter_op( cointoss(), -1 * crash_angle, crash_angle );
    crash_vector = ( crash_dist, 0, 0 );
    crash_angles = self.angles + ( 0, crash_yaw, 0 );
    crash_point = self.origin + rotatevector( crash_vector, crash_angles );
    crash_point = getgroundposition( crash_point, 128 );
    self notify( "path_updated" );
    self stoppath();
    self removecomponent( "path" );
    waitframe();
    self setconfigvalue( "p2p", "throttleSpeedFarBelow", 1 );
    self setconfigvalue( "p2p", "throttleSpeedFarAbove", 4 );
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( crash_speed ) );
    self setconfigvalue( "p2p", "goalPoint", crash_point );
    self setconfigvalue( "p2p", "goalThreshold", 50 );
    self setconfigvalue( "p2p", "brakeAtGoal", 1 );
    waittill_any_timeout_3( 2, "goal", "near_goal", "path_blocked" );
    function_73ebd648f533a034( activityinstance );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 2
// Checksum 0x0, Offset: 0x1a21
// Size: 0x55a
function function_181fd18526171d6b( var_cffe525bfe66cdca, var_59d52445d26e52ea )
{
    vehiclearray = [];
    num_vehicles = self.maxvehicles;
    spawndata = spawnstruct();
    spawndata.angles = self.var_d9a91303aea799de.angles;
    spawndata.team = self.ai_team;
    spawndata.initai = 1;
    spawndata.preventrespawn = 1;
    spawndata.var_699ac4a9c9e9f0ec = 1;
    spawndata.var_24993ee24f7c7c0 = 1;
    offsetdirection = vectornormalize( anglestoforward( self.var_d9a91303aea799de.angles ) * ( 1, 1, 0 ) );
    offsetstep = 640;
    var_67c9742ae410b71c = [ "veh_jup_pickup_2014" ];
    self.vehicle_ref = default_to( var_59d52445d26e52ea, random( var_67c9742ae410b71c ) );
    self.var_1c1e93b32ed347a7 = [];
    
    for ( index = 0; index < num_vehicles ; index++ )
    {
        var_26e8177cafb3f245 = randomfloatrange( 10, 35 );
        var_92ffab909b4632c6 = offsetstep + var_26e8177cafb3f245;
        spawndata.origin = self.var_d9a91303aea799de.origin - offsetdirection * ( index + 1 ) * var_92ffab909b4632c6 + ( 0, 0, 100 );
        vehicle = undefined;
        self.var_1c1e93b32ed347a7[ index ] = spawnstruct();
        vehicle = vehicle_spawn( self.var_a5aa6c6f1908df45[ index ].vehicleref, spawndata );
        assertex( isdefined( vehicle ), "<dev string:xbf>" );
        vehicle.riders = [];
        vehicle.unloadque = [];
        vehicle.unload_group = "all";
        
        switch ( self.var_a5aa6c6f1908df45[ index ].vehicleref )
        {
            case #"hash_d63b8f48fb92540d":
                classname_mp = "script_vehicle_veh9_jltv_mg_ai";
                anim_alias = "veh9_jltv";
                break;
            case #"hash_d212f4961f28eb58":
                classname_mp = "script_vehicle_veh9_jltv_mg_ai";
                anim_alias = "veh9_jltv";
                break;
            case #"hash_885f51af68244d3":
                classname_mp = "script_vehicle_veh_jup_suv_1996";
                anim_alias = "suv_1996";
                break;
            case #"hash_cb367b51338c9d6":
                classname_mp = "script_vehicle_veh9_techo_rebel_armor_ai";
                anim_alias = "veh9_tech_armor_pickup";
                break;
            case #"hash_c9d9aa17e7c175a5":
                classname_mp = "script_vehicle_veh_jup_pickup_2014";
                anim_alias = "fullsized_pickup_2014";
                break;
            default:
                assertmsg( "<dev string:xe1>" + self.var_a5aa6c6f1908df45[ index ].vehicleref );
                break;
        }
        
        vehicle.classname_mp = classname_mp;
        vehicle.vehicleanimalias = anim_alias;
        vehicle ent_flag_init( "armored_convoy_spawned" );
        vehicle setscriptablepartstate( "single", "vehicle_unusable" );
        vehicle scripts\common\vehicle_aianim::handle_attached_guys();
        function_1f7a69bd7ab10e0( self, self.var_1c1e93b32ed347a7[ index ], spawndata.origin, index, vehicle );
        assertex( self.var_1c1e93b32ed347a7[ index ].var_656d7611b22ce21.size > 0, "<dev string:x106>" );
        vehicledata = function_29b4292c92443328( self.var_a5aa6c6f1908df45[ index ].vehicleref );
        
        if ( self.var_1c1e93b32ed347a7[ index ].var_656d7611b22ce21.size > vehicledata.aiseats.size )
        {
            errormsg = "Error - AI encounter " + self.var_a5aa6c6f1908df45[ index ].riderencounter;
            errormsg = errormsg + " spawned " + self.var_1c1e93b32ed347a7[ index ].var_656d7611b22ce21.size;
            errormsg = errormsg + " riders, but vehicle " + self.var_a5aa6c6f1908df45[ index ].vehicleref;
            errormsg = errormsg + " has only " + vehicledata.aiseats.size + " seats!";
            assertmsg( errormsg );
        }
        
        vehicle.script_index = index;
        vehicle.rewardspawned = 0;
        vehicle.var_aa4804cc1bc59e93 = 1;
        
        if ( istrue( self.var_4f77d28d75ebd61c ) )
        {
            vehicle.playedcaralarm = 1;
        }
        
        vehicle.isunloaded = 0;
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( vehicle, "team_hundred_ninety" );
        
        if ( issharedfuncdefined( "armored_convoy_activity", "SpawnLootCache" ) )
        {
            vehicle.lootcache = callsharedfunc( "armored_convoy_activity", "SpawnLootCache", vehicle );
        }
        
        vehicle function_df8142211bdf35cf();
        vehicle thread function_50c2476a67740c1e( self );
        vehicle thread function_803602cd4c0c0edd( self );
        vehicle thread function_9f8f728b60e7418c( self );
        thread function_f0675d4a690011d6( vehicle );
        vehiclearray = array_add( vehiclearray, vehicle );
        waitframe();
    }
    
    if ( issharedfuncdefined( "ob_quest_missions", "onConvoyActive" ) )
    {
        [[ getsharedfunc( "ob_quest_missions", "onConvoyActive" ) ]]( self );
    }
    
    return vehiclearray;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0x1f84
// Size: 0x152
function function_b71aa24dbd5946e1()
{
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    a_startnodes = self.s_center scripts\mp\utility\game::get_linked_vehicle_nodes();
    a_startnodes = array_randomize( a_startnodes );
    
    foreach ( startnode in a_startnodes )
    {
        player = getclosest( startnode.origin, level.players, 1500 );
        
        if ( isdefined( player ) )
        {
            continue;
        }
        
        players = scripts\mp\utility\player::getplayersinradius( startnode.origin, 3000 );
        
        if ( players.size == 0 )
        {
            return startnode;
        }
        
        foreach ( player in players )
        {
            b_trace_passed = scripts\engine\trace::ray_trace_passed( player geteye(), startnode.origin + ( 0, 0, 30 ), [ player ] );
            
            if ( b_trace_passed == 0 )
            {
                return startnode;
            }
        }
    }
    
    return random( a_startnodes );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x20df
// Size: 0x84
function function_9f8f728b60e7418c( activityinstance )
{
    activityinstance endon( "activity_ended" );
    activityinstance endon( "instance_destroyed" );
    self endon( "death" );
    self endon( "entitydeleted" );
    self endon( "unloaded" );
    
    while ( !isdefined( self.driver ) )
    {
        /#
            iprintln( "<dev string:x11e>" );
        #/
        
        waitframe();
    }
    
    msg = waittill_any_ents_return( self.driver, "death", self, "damage_heavy" );
    self notify( "leavepath_unload" );
    thread function_1e9c7b94e0a76915( activityinstance );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x216b
// Size: 0x1e0
function function_50c2476a67740c1e( activityinstance )
{
    activityinstance endon( "activity_ended" );
    activityinstance endon( "instance_destroyed" );
    self endon( "death" );
    self endon( "entitydeleted" );
    self endon( "leavepath_unload" );
    self endon( "engage" );
    old_attackers = [];
    n_distance = 16000000;
    
    while ( !istrue( activityinstance.var_de6f66d8d51587f1 ) )
    {
        if ( istrue( self.isdestroyed ) )
        {
            return;
        }
        
        self waittill( "damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        var_f97f93d8023b0981 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate();
        
        if ( isdefined( attacker ) && isplayer( attacker ) && distancesquared( self.origin, attacker.origin ) <= n_distance )
        {
            activityinstance notify( "under_attack" );
            
            if ( issharedfuncdefined( "armored_convoy_activity", "PlayEngageVO" ) )
            {
                callsharedfunc( "armored_convoy_activity", "PlayEngageVO", activityinstance );
            }
            else
            {
                activityinstance thread namespace_277c27ef297ef569::function_1281c7fff9456e18( "activity_armored_convoy_engage_player_broadcast" );
            }
            
            break;
        }
        
        if ( isdefined( var_f97f93d8023b0981 ) && var_f97f93d8023b0981 == "heavy" )
        {
            self notify( "damage_heavy" );
            
            if ( issharedfuncdefined( "armored_convoy_activity", "PlayEngageVO" ) )
            {
                callsharedfunc( "armored_convoy_activity", "PlayEngageVO", activityinstance );
            }
            else
            {
                activityinstance thread namespace_277c27ef297ef569::function_1281c7fff9456e18( "activity_armored_convoy_engage_player_broadcast" );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x2353
// Size: 0x36
function function_803602cd4c0c0edd( activityinstance )
{
    self endon( "entitydeleted" );
    self waittill( "death" );
    earthquake( 0.5, 1, self.origin, 1500 );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0x2391
// Size: 0x13f
function function_6590c1e6e798dd19()
{
    foreach ( rider in self.riders )
    {
        if ( !is_dead_or_dying( rider ) )
        {
            turret = rider getturret();
            
            if ( isdefined( turret ) )
            {
                if ( flag( "stealth_enabled" ) && isdefined( rider.stealth ) && istrue( rider.stealth_enabled ) )
                {
                    rider setstealthstate( "combat" );
                }
            }
            else
            {
                if ( !isdefined( rider.vehicle_position ) && isdefined( rider.script_startingposition ) )
                {
                    rider.vehicle_position = rider.script_startingposition;
                }
                
                if ( isdefined( rider.vehicle_position ) )
                {
                    rider thread function_264e36ce6f3574f7( self.origin );
                    thread scripts\common\vehicle_aianim::guy_unload( rider, rider.vehicle_position );
                }
            }
            
            n_wait = randomfloatrange( 0.2, 0.3 );
            wait n_wait;
        }
    }
    
    wait 1;
    self notify( "unloaded" );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x24d8
// Size: 0x2b0
function function_1e9c7b94e0a76915( activityinstance )
{
    activityinstance endon( "activity_ended" );
    activityinstance endon( "instance_destroyed" );
    self endon( "death" );
    self endon( "entitydeleted" );
    self endon( "unloaded" );
    var_ae3861d2a0ef3c19 = 0;
    
    if ( isdefined( self.script_index ) && self.script_index == activityinstance.var_4e0002675594e13f.size - 1 )
    {
        var_ae3861d2a0ef3c19 = 1;
    }
    
    if ( activityinstance.var_269a59bcee49ce1 == activityinstance.medspeed )
    {
        crash_speed = activityinstance.highspeed;
        crash_dist = 512;
    }
    else if ( activityinstance.var_269a59bcee49ce1 == activityinstance.highspeed )
    {
        crash_speed = activityinstance.extremespeed;
        crash_dist = 768;
    }
    else
    {
        crash_speed = activityinstance.medspeed;
        crash_dist = 384;
    }
    
    /#
        iprintln( "<dev string:x13b>" );
    #/
    
    crash_angle = randomfloatrange( 25, 35 );
    crash_yaw = ter_op( cointoss(), -1 * crash_angle, crash_angle );
    crash_vector = ( crash_dist, 0, 0 );
    crash_angles = self.angles + ( 0, crash_yaw, 0 );
    crash_point = self.origin + rotatevector( crash_vector, crash_angles );
    crash_point = getgroundposition( crash_point, 128 );
    self notify( "path_updated" );
    self stoppath();
    self removecomponent( "path" );
    waitframe();
    self setconfigvalue( "p2p", "throttleSpeedFarBelow", 2 );
    self setconfigvalue( "p2p", "throttleSpeedFarAbove", 8 );
    self setconfigvalue( "p2p", "automaticFast", 1 );
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( crash_speed ) );
    self setconfigvalue( "p2p", "goalPoint", crash_point );
    self setconfigvalue( "p2p", "goalThreshold", 50 );
    self setconfigvalue( "p2p", "brakeAtGoal", 1 );
    waittill_any_timeout_3( 5, "goal", "near_goal", "path_blocked" );
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( 0 ) );
    waitframe();
    activityinstance notify( "vehicle_down" );
    function_6590c1e6e798dd19();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( self, "neutral" );
    
    if ( istrue( activityinstance.var_e63f28f54dc0a813 ) )
    {
        function_2169641d6a403864( self.var_542f8d001288419d );
        function_adcc96a7d541aa36( self.var_542f8d001288419d, 1 );
    }
    
    activityinstance.var_21f1863c6d44d936[ self.var_542f8d001288419d ] = undefined;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x2790
// Size: 0x5b
function function_264e36ce6f3574f7( vehicle_origin )
{
    self endon( "death" );
    self waittill( "unload" );
    
    if ( flag( "stealth_enabled" ) && isdefined( self.stealth ) && istrue( self.stealth_enabled ) )
    {
        self setstealthstate( "combat" );
    }
    
    self setgoalpos( vehicle_origin, 750 );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 3
// Checksum 0x0, Offset: 0x27f3
// Size: 0x1e9
function function_df8142211bdf35cf( var_5f487a4ba2d7c5a, addpath, var_784030f0b32d0f1d )
{
    var_5f487a4ba2d7c5a = ter_op( isdefined( var_5f487a4ba2d7c5a ), var_5f487a4ba2d7c5a, 1 );
    addpath = ter_op( isdefined( addpath ), addpath, 1 );
    var_784030f0b32d0f1d = ter_op( isdefined( var_784030f0b32d0f1d ), var_784030f0b32d0f1d, 0 );
    
    if ( var_5f487a4ba2d7c5a )
    {
        if ( !self hascomponent( "p2p" ) )
        {
            self addcomponent( "p2p" );
        }
    }
    
    if ( addpath )
    {
        if ( !self hascomponent( "path" ) )
        {
            self addcomponent( "path" );
        }
    }
    
    if ( var_784030f0b32d0f1d )
    {
        if ( !self hascomponent( "animator" ) )
        {
            self addcomponent( "animator" );
        }
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self setconfigvalue( "p2p", "checkStuck", 0 );
        self setconfigvalue( "p2p", "brakeAtGoal", 1 );
        self setconfigvalue( "p2p", "automaticNormal", 1 );
        self setconfigvalue( "p2p", "brakeOnGoalGasbrake", 1 );
        self setconfigvalue( "p2p", "goalPoint", self.origin );
        self setconfigvalue( "p2p", "goalThreshold", 200 );
        self setconfigvalue( "p2p", "throttleSpeedClose", 1 );
        self setconfigvalue( "p2p", "throttleSpeedThreshold", 1 );
        self setconfigvalue( "p2p", "automaticFastTopspeedFraction", 1 );
        self setconfigvalue( "p2p", "throttleSpeedFarBelow", 1 );
        self setconfigvalue( "p2p", "throttleSpeedFarAbove", 4 );
        self setconfigvalue( "p2p", "throttleSpeedClose", 2 );
        self setconfigvalue( "p2p", "gasToStopMovement", 0.9 );
        self setconfigvalue( "p2p", "steeringMultiplier", 2 );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self setconfigvalue( "path", "radiusToStep", 300 );
    }
    
    self.dontunloadonend = 1;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 5
// Checksum 0x0, Offset: 0x29e4
// Size: 0x1f4
function function_1f7a69bd7ab10e0( activityinstance, var_1c1e93b32ed347a7, origin, vehicleindex, vehicle )
{
    assertex( vehicleindex >= 0 && vehicleindex < activityinstance.var_a5aa6c6f1908df45.size, "<dev string:x151>" );
    var_1c1e93b32ed347a7.var_542f8d001288419d = activityinstance function_f8ccadcd850da124( activityinstance.var_a5aa6c6f1908df45[ vehicleindex ].riderencounter, origin, 128, 1, 0, 1, 2 );
    vehicle.var_542f8d001288419d = var_1c1e93b32ed347a7.var_542f8d001288419d;
    function_b0a68315f80cb547( var_1c1e93b32ed347a7.var_542f8d001288419d, vehicle );
    
    /#
        if ( isdefined( self.routedifficulty ) )
        {
            function_d37068aac7785c04( var_1c1e93b32ed347a7.var_542f8d001288419d, self.routedifficulty, 1 );
        }
    #/
    
    if ( !isdefined( var_1c1e93b32ed347a7.vehicle_riders ) )
    {
        var_1c1e93b32ed347a7.var_656d7611b22ce21 = [];
    }
    
    if ( isdefined( var_1c1e93b32ed347a7.var_542f8d001288419d ) )
    {
        activityinstance function_ce9c21523336cdbc( var_1c1e93b32ed347a7.var_542f8d001288419d, &function_6e72efeedb40de3b, var_1c1e93b32ed347a7 );
        function_adcc96a7d541aa36( var_1c1e93b32ed347a7.var_542f8d001288419d, 0 );
        
        for ( data = function_9a39e23c3c52c2af( var_1c1e93b32ed347a7.var_542f8d001288419d ); data.status < 4 ; data = function_9a39e23c3c52c2af( var_1c1e93b32ed347a7.var_542f8d001288419d ) )
        {
            waitframe();
        }
        
        foreach ( agent in var_1c1e93b32ed347a7.var_656d7611b22ce21 )
        {
            agent thread function_617a1b569134ba77( activityinstance );
            activityinstance thread function_f0675d4a690011d6( agent );
            activityinstance.var_70b5f128bfa2986e = array_add( activityinstance.var_70b5f128bfa2986e, agent );
        }
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 4
// Checksum 0x0, Offset: 0x2be0
// Size: 0x6c
function function_6e72efeedb40de3b( requestid, userdata, agent, data )
{
    agent endon( "death" );
    
    if ( isalive( agent ) )
    {
        var_1c1e93b32ed347a7 = userdata;
        agent.vehiclerunexit = 1;
        var_1c1e93b32ed347a7.var_656d7611b22ce21 = array_add( var_1c1e93b32ed347a7.var_656d7611b22ce21, agent );
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2c54
// Size: 0x8a
function private checkvehiclenormalizedposition( splinenodeindex )
{
    level notify( "checkVehicleNormalizedPosition" );
    level endon( "checkVehicleNormalizedPosition" );
    self endon( "death" );
    splinelength = function_a40878ba7a8db979( splinenodeindex );
    duration = 5000;
    
    while ( true )
    {
        wait 1;
        splinedistancetraveled = self function_2493bc9a09ce3063();
        
        /#
            print3d( self.origin, "<dev string:xbb>" + splinedistancetraveled / splinelength, ( 1, 1, 1 ), 1, 1, duration, 1 );
        #/
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x2ce6
// Size: 0x97
function function_f0f07d0530132d6b( activityinstance )
{
    self endon( "death" );
    activityinstance endon( "activity_ended" );
    activityinstance endon( "instance_destroyed" );
    startingnode = activityinstance.var_d9a91303aea799de;
    nodeindex = getvehiclenodeindex( startingnode.targetname, "targetname" );
    waitframe();
    
    if ( isdefined( self ) )
    {
        self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( activityinstance.var_269a59bcee49ce1 ) );
        self setconfigvalue( "path", "radiantId", nodeindex );
        self vehicle_turnengineon();
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 2
// Checksum 0x0, Offset: 0x2d85
// Size: 0xd2
function function_57cb82ad7a3ea8e4( speed, var_47377dd95777e070 )
{
    var_47377dd95777e070 = default_to( var_47377dd95777e070, 1 );
    
    if ( var_47377dd95777e070 == 1 )
    {
        vehicles = self.var_4e0002675594e13f;
    }
    else
    {
        vehicles = self.var_3fe5574cd4504d62;
    }
    
    foreach ( vehicle in vehicles )
    {
        self.var_269a59bcee49ce1 = speed;
        
        if ( vehicle hascomponent( "p2p" ) )
        {
            vehicle setconfigvalue( "p2p", "manualSpeed", mph_to_ips( speed ) );
            vehicle.var_c8ede22a39f49745 = speed;
            continue;
        }
        
        vehicle vehicle_setspeed( speed );
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2e5f
// Size: 0x652
function private armored_convoy_vehicle_update_spacing()
{
    self notify( "armored_convoy_vehicle_update_spacing" );
    self endon( "armored_convoy_vehicle_update_spacing" );
    self endon( "activity_ended" );
    self endon( "instance_destroyed" );
    self endon( "player_spotted" );
    self endon( "under_attack" );
    self endon( "unloaded" );
    self endon( "armored_convoy_stuck" );
    assert( isdefined( self.var_3fe5574cd4504d62 ) );
    assert( isdefined( self.var_4e0002675594e13f ) );
    assert( isdefined( self.var_269a59bcee49ce1 ) );
    thread function_233138b73388d497();
    
    while ( isdefined( self.var_4e0002675594e13f ) && self.var_4e0002675594e13f.size > 1 )
    {
        self.var_3fe5574cd4504d62 = array_removedead( self.var_3fe5574cd4504d62 );
        self.var_4e0002675594e13f = array_removedead( self.var_4e0002675594e13f );
        var_4b1a1ec87d5ac862 = self.var_4e0002675594e13f;
        
        /#
            drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
            
            if ( drawdebug )
            {
                for ( index = 0; index < var_4b1a1ec87d5ac862.size ; index++ )
                {
                    print3d( var_4b1a1ec87d5ac862[ index ].origin, "<dev string:xbb>" + var_4b1a1ec87d5ac862[ index ].veh_speed + "<dev string:x190>" + self.var_269a59bcee49ce1, ( 1, 1, 1 ), 1, 1, 1, 1 );
                }
            }
        #/
        
        var_f6df7509780987e0 = isdefined( var_4b1a1ec87d5ac862[ 0 ].var_1b21155ab4273297 ) && var_4b1a1ec87d5ac862[ 0 ].var_1b21155ab4273297 < 2250000;
        
        if ( self.var_269a59bcee49ce1 == 0 || var_4b1a1ec87d5ac862[ 0 ].veh_speed < self.var_269a59bcee49ce1 * 0.8 || var_f6df7509780987e0 )
        {
            if ( var_f6df7509780987e0 )
            {
                for ( index = 0; index < var_4b1a1ec87d5ac862.size ; index++ )
                {
                    if ( isdefined( var_4b1a1ec87d5ac862[ index ].var_c8ede22a39f49745 ) && var_4b1a1ec87d5ac862[ index ].var_c8ede22a39f49745 > self.var_269a59bcee49ce1 )
                    {
                        var_4b1a1ec87d5ac862[ index ] setconfigvalue( "p2p", "manualSpeed", mph_to_ips( self.var_269a59bcee49ce1 ) );
                        var_4b1a1ec87d5ac862[ index ].var_c8ede22a39f49745 = self.var_269a59bcee49ce1;
                    }
                }
            }
            
            waitframe();
            continue;
        }
        
        offsetpositions = [];
        offsetdistance = 640;
        projectedpositions = [];
        
        for ( index = 0; index < var_4b1a1ec87d5ac862.size ; index++ )
        {
            if ( index > 0 )
            {
                leadorigin = var_4b1a1ec87d5ac862[ index - 1 ].origin;
                leadforward = vectornormalize( anglestoforward( var_4b1a1ec87d5ac862[ index - 1 ].angles * ( 0, 1, 0 ) ) );
                offsetpositions[ offsetpositions.size ] = leadorigin - leadforward * offsetdistance;
                vehicledirection = var_4b1a1ec87d5ac862[ index ].origin - leadorigin;
                var_da85e0b1ec9b0c7c = vectordot2( vehicledirection, leadforward, 0 );
                projectedpositions[ projectedpositions.size ] = leadorigin + leadforward * var_da85e0b1ec9b0c7c;
                continue;
            }
            
            offsetpositions[ offsetpositions.size ] = var_4b1a1ec87d5ac862[ index ].origin;
            projectedpositions[ projectedpositions.size ] = var_4b1a1ec87d5ac862[ index ].origin;
        }
        
        if ( offsetpositions.size > 1 )
        {
            /#
                drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                
                if ( drawdebug )
                {
                    for ( index = 1; index < offsetpositions.size ; index++ )
                    {
                        color = ( 1, 0.5, 0.1 );
                        line( var_4b1a1ec87d5ac862[ index - 1 ].origin, offsetpositions[ index ], color, 1, 0, 1 );
                        sphere( offsetpositions[ index ], 10, color, 0, 1 );
                    }
                }
            #/
            
            for ( index = 1; index < projectedpositions.size ; index++ )
            {
                leadforward = vectornormalize( anglestoforward( var_4b1a1ec87d5ac862[ index - 1 ].angles * ( 0, 1, 0 ) ) );
                var_631c4aecaed3137c = vectornormalize( projectedpositions[ index ] - offsetpositions[ index ] );
                var_9a295e6abb51c7b3 = vectordot2( var_631c4aecaed3137c, leadforward, 0 );
                vehicleforward = vectornormalize( anglestoforward( var_4b1a1ec87d5ac862[ index ].angles * ( 0, 1, 0 ) ) );
                var_4a6c7f0ef6a2a647 = vectordot2( vehicleforward, leadforward, 0 );
                
                if ( var_4a6c7f0ef6a2a647 > 0 )
                {
                    if ( var_9a295e6abb51c7b3 > cos( 45 ) )
                    {
                        newspeed = self.var_269a59bcee49ce1 * 0.9;
                        
                        if ( index > 1 && isdefined( var_4b1a1ec87d5ac862[ index - 1 ].var_c8ede22a39f49745 ) )
                        {
                            newspeed = var_4b1a1ec87d5ac862[ index - 1 ].var_c8ede22a39f49745 * 0.9;
                        }
                        
                        var_4b1a1ec87d5ac862[ index ] setconfigvalue( "p2p", "manualSpeed", mph_to_ips( newspeed ) );
                        var_4b1a1ec87d5ac862[ index ].var_c8ede22a39f49745 = newspeed;
                    }
                    else if ( !var_f6df7509780987e0 )
                    {
                        newspeed = self.var_269a59bcee49ce1 * 1.1;
                        var_4b1a1ec87d5ac862[ index ] setconfigvalue( "p2p", "manualSpeed", mph_to_ips( newspeed ) );
                        var_4b1a1ec87d5ac862[ index ].var_c8ede22a39f49745 = newspeed;
                    }
                }
                else if ( !var_f6df7509780987e0 )
                {
                    var_752bd535848b768 = distance2dsquared( var_4b1a1ec87d5ac862[ index - 1 ].origin, var_4b1a1ec87d5ac862[ index ].origin );
                    
                    if ( var_752bd535848b768 > 1000000 )
                    {
                        newspeed = self.var_269a59bcee49ce1 * 1.1;
                        var_4b1a1ec87d5ac862[ index ] setconfigvalue( "p2p", "manualSpeed", mph_to_ips( newspeed ) );
                        var_4b1a1ec87d5ac862[ index ].var_c8ede22a39f49745 = newspeed;
                    }
                }
                
                /#
                    drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                    
                    if ( drawdebug )
                    {
                        color = ( 1, 0.75, 0.8 );
                        
                        if ( var_9a295e6abb51c7b3 > cos( 45 ) )
                        {
                            color = ( 0, 1, 0 );
                        }
                        
                        line( projectedpositions[ index ], var_4b1a1ec87d5ac862[ index ].origin, color, 1, 0, 1 );
                        
                        if ( var_4a6c7f0ef6a2a647 > 0 )
                        {
                            sphere( projectedpositions[ index ], 8, color, 0, 1 );
                        }
                    }
                #/
            }
        }
        
        waitframe();
    }
    
    self notify( "all_vehicles_destroyed" );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x34b9
// Size: 0x68
function function_617a1b569134ba77( activityinstance )
{
    self endon( "death" );
    activityinstance endon( "activity_ended" );
    activityinstance endon( "instance_destroyed" );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) && array_contains( level.players, self.enemy ) )
        {
            function_bbdcd857d0c2a65e( activityinstance, self.enemy );
        }
        
        wait 1;
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x3529
// Size: 0x37
function function_7aa120c6895b1b0( var_b381b0883bcd4847 )
{
    player_list = var_b381b0883bcd4847.playerlist;
    var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x3568
// Size: 0x48
function function_53ecaed01e5352a0( var_b381b0883bcd4847 )
{
    player_list = var_b381b0883bcd4847.playerlist;
    
    if ( issharedfuncdefined( "armored_convoy_activity", "PlayApproachConvoyVO" ) )
    {
        callsharedfunc( "armored_convoy_activity", "OnPlayerLeftActivity", self, var_b381b0883bcd4847 );
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x35b8
// Size: 0xb1
function function_586d9c599add1552( var_d6bfa53c531546d6 )
{
    activity_type = namespace_4fda5d7358015a06::getactivitytype( self );
    
    if ( isdefined( activity_type ) && activity_type == "REV_OB_ARMORED_CONVOY" )
    {
        if ( istrue( var_d6bfa53c531546d6.enteredzone ) && istrue( var_d6bfa53c531546d6.firsttimeinzone ) && !istrue( self.var_de6f66d8d51587f1 ) )
        {
            player_list = [];
            player_list = array_add( player_list, var_d6bfa53c531546d6.player );
            
            if ( issharedfuncdefined( "armored_convoy_activity", "PlayApproachConvoyVO" ) )
            {
                callsharedfunc( "armored_convoy_activity", "PlayApproachConvoyVO", self, player_list );
                return;
            }
            
            thread namespace_277c27ef297ef569::function_1281c7fff9456e18( "activity_armored_convoy_approach_broadcast", player_list );
        }
    }
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x3671
// Size: 0x118
function function_219e012faa65219d( var_28af8e747331e08d )
{
    if ( isdefined( var_28af8e747331e08d ) )
    {
        self.var_157fa22c13019614 = spawnstruct();
        self.var_157fa22c13019614.maxvehicles = default_to( var_28af8e747331e08d.var_4b1a1ec87d5ac862.size, 0 );
        self.var_157fa22c13019614.riderencounters = [];
        self.var_157fa22c13019614.vehiclerefs = [];
        
        for ( i = 0; i < var_28af8e747331e08d.var_4b1a1ec87d5ac862.size ; i++ )
        {
            self.var_157fa22c13019614.riderencounters[ i ] = "ai_encounter:" + var_28af8e747331e08d.var_4b1a1ec87d5ac862[ i ].variant_object.riderencounter;
            self.var_157fa22c13019614.vehiclerefs[ i ] = var_28af8e747331e08d.var_4b1a1ec87d5ac862[ i ].variant_object.vehicle;
        }
        
        return;
    }
    
    assertmsg( "<dev string:x195>" );
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 0
// Checksum 0x0, Offset: 0x3791
// Size: 0x15
function function_c7989b2ed75d1228()
{
    return self.var_157fa22c13019614.maxvehicles;
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x37af
// Size: 0x52
function function_a23b8410030b26d0( vehicleposition )
{
    assertex( vehicleposition >= 0 && vehicleposition < self.var_157fa22c13019614.maxvehicles, "<dev string:x1cd>" + vehicleposition + "<dev string:x1f2>" );
    return self.var_157fa22c13019614.riderencounters[ vehicleposition ];
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x380a
// Size: 0x52
function function_2c9ad04639e71614( vehicleposition )
{
    assertex( vehicleposition >= 0 && vehicleposition < self.var_157fa22c13019614.maxvehicles, "<dev string:x1cd>" + vehicleposition + "<dev string:x1f2>" );
    return self.var_157fa22c13019614.vehiclerefs[ vehicleposition ];
}

// Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
// Params 1
// Checksum 0x0, Offset: 0x3865
// Size: 0xb
function function_5840644662c74a48( vehicle )
{
    
}

/#

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 0
    // Checksum 0x0, Offset: 0x3878
    // Size: 0xc, Type: dev
    function function_e6f128a1e529f457()
    {
        function_bc8d978e7b0a418c();
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x388c
    // Size: 0x140, Type: dev
    function private function_f47128cc3cb77caf( targetname )
    {
        playerforward = anglestoforward( level.players[ 0 ].angles );
        spawndata = spawnstruct();
        spawndata.origin = level.players[ 0 ].origin + playerforward * 500 + ( 0, 0, 300 );
        spawndata.angles = level.players[ 0 ].angles;
        spawndata.team = self.ai_team;
        spawndata.initai = 1;
        spawndata.var_699ac4a9c9e9f0ec = 1;
        spawndata.var_24993ee24f7c7c0 = 1;
        vehicledata = function_29b4292c92443328( targetname );
        vehicle = vehicle_spawn( targetname, spawndata );
        vehicle scripts\common\vehicle_code::vehicle_disable_navobstacles();
        vehicle thread script_func( "<dev string:x1f8>" );
        
        if ( !isdefined( level.spawnedvehicles ) )
        {
            level.spawnedvehicles = [];
        }
        
        level.spawnedvehicles[ level.spawnedvehicles.size ] = vehicle;
        return vehicle;
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x39d4
    // Size: 0x1b5, Type: dev
    function private function_b61f675503083701( addpath, var_784030f0b32d0f1d )
    {
        addpath = ter_op( isdefined( addpath ), addpath, 0 );
        var_784030f0b32d0f1d = ter_op( isdefined( var_784030f0b32d0f1d ), var_784030f0b32d0f1d, 0 );
        
        if ( !self hascomponent( "<dev string:x20a>" ) )
        {
            self addcomponent( "<dev string:x20a>" );
        }
        
        if ( addpath )
        {
            if ( !self hascomponent( "<dev string:x211>" ) )
            {
                self addcomponent( "<dev string:x211>" );
            }
        }
        
        if ( var_784030f0b32d0f1d )
        {
            if ( !self hascomponent( "<dev string:x219>" ) )
            {
                self addcomponent( "<dev string:x219>" );
            }
        }
        
        self setconfigvalue( "<dev string:x20a>", "<dev string:x225>", 0 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x233>", 1 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x242>", 1 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x255>", 1 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x26c>", self.origin );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x279>", 200 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x28a>", 1 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x2a0>", 1 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x2ba>", 1 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x2db>", 1 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x2f4>", 4 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x28a>", 2 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x30d>", 0.9 );
        self setconfigvalue( "<dev string:x20a>", "<dev string:x322>", 2 );
        self setconfigvalue( "<dev string:x211>", "<dev string:x338>", 300 );
        self.stopping = 0;
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x3b91
    // Size: 0x51, Type: dev
    function private function_215e10bf17f98702( startpos, endpos, speed )
    {
        segmentlength = distance( startpos, endpos );
        moverate = segmentlength / speed;
        
        if ( moverate < 0.05 )
        {
            moverate = 0.05;
        }
        
        return moverate;
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x3bea
    // Size: 0x8d, Type: dev
    function private function_a646f25304f0c578( splinepoints, speedips )
    {
        durations = [];
        assert( splinepoints.size <= 48 );
        
        if ( splinepoints.size >= 2 )
        {
            for ( index = 0; index < splinepoints.size - 1 ; index++ )
            {
                currentpoint = splinepoints[ index ];
                nextpoint = splinepoints[ index + 1 ];
                durations[ durations.size ] = function_215e10bf17f98702( currentpoint, nextpoint, speedips );
            }
            
            durations[ durations.size ] = durations[ durations.size - 1 ];
        }
        
        return durations;
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x3c7f
    // Size: 0x319, Type: dev
    function private function_cd400918a8463816( params )
    {
        if ( !isdefined( level.spawnedvehicles ) )
        {
            return;
        }
        
        level.spawnedvehicles = function_fdc9d5557c53078e( level.spawnedvehicles );
        
        if ( level.spawnedvehicles.size == 0 )
        {
            return;
        }
        
        vehicle = level.spawnedvehicles[ 0 ];
        startlocation = vehicle.origin;
        goallocation = level.players[ 0 ].origin;
        
        if ( istrue( params[ 1 ] == "<dev string:x348>" ) )
        {
            playerangles = level.players[ 0 ] getplayerangles();
            playerforward = anglestoforward( playerangles );
            playereyelocation = level.players[ 0 ] geteye();
            traceendlocation = playereyelocation + playerforward * 5000;
            traceresults = scripts\engine\trace::ray_trace( playereyelocation, traceendlocation, level.players[ 0 ] );
            
            if ( isdefined( traceresults ) )
            {
                navmeshposition = getclosestpointonnavmesh( traceresults[ "<dev string:x34d>" ], level.var_56c51d0b8c3270ca );
                
                /#
                    color = ( 1, 0.65, 0 );
                    duration = 200;
                    sphere( traceresults[ "<dev string:x34d>" ], 5, color, 0, duration );
                    line( navmeshposition, traceresults[ "<dev string:x34d>" ], color, 1, 0, duration );
                #/
                
                goallocation = navmeshposition;
            }
        }
        
        vehicleforward = anglestoforward( vehicle.angles );
        var_34bb55fbc59c2e1d = isnavmeshloaded( "<dev string:x359>" );
        var_a8c9b5fffa6387d = isnavmeshloaded( "<dev string:x36a>" );
        navmeshlayer = ter_op( var_34bb55fbc59c2e1d, "<dev string:x359>", ter_op( var_a8c9b5fffa6387d, "<dev string:x36a>", undefined ) );
        var_c2202bf0909145b5 = ter_op( istrue( params[ 0 ] == "<dev string:x348>" ), 2, 1 );
        splinepoints = vehicle findsplinepath( startlocation, goallocation, 50, 200, 100, vehicleforward, ( 0, 0, 0 ), 300, 0.4, 0, 1, navmeshlayer, 0, var_c2202bf0909145b5 );
        speedmph = 30;
        speedips = mph_to_ips( speedmph );
        vehicle setconfigvalue( "<dev string:x20a>", "<dev string:x37a>", speedips );
        
        if ( isdefined( splinepoints ) )
        {
            if ( istrue( params[ 0 ] == "<dev string:x348>" ) )
            {
                if ( splinepoints.size >= 48 )
                {
                    splinepoints = array_slice( splinepoints, 0, 47 );
                }
                
                var_f70515e8a2d1ba64 = function_a646f25304f0c578( splinepoints, speedips );
                splineid = function_6e313dda90fb035f( splinepoints, var_f70515e8a2d1ba64 );
                vehicle setconfigvalue( "<dev string:x211>", "<dev string:x389>", splineid );
            }
            
            vehicle thread scripts\common\vehicle_paths::function_68d5232181fec390( splinepoints, ter_op( isdefined( navmeshlayer ), ( 1, 1, 1 ), ( 1, 0, 0 ) ) );
        }
        
        vehicle thread scripts\common\vehicle_paths::checkvehiclenavsplinestuck();
        vehicle thread scripts\common\vehicle_paths::checkvehiclenavsplineinterrupted();
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x3fa0
    // Size: 0xd8, Type: dev
    function private function_1ab5e4e5878bd5e9( vehicleref )
    {
        adddebugcommand( "<dev string:x399>" );
        vehicle = function_f47128cc3cb77caf( vehicleref[ 0 ] );
        playerforward = anglestoforward( level.players[ 0 ].angles );
        teleportlocation = level.players[ 0 ].origin + playerforward * 500 + ( 0, 0, 300 );
        startside = vectorcross( playerforward, ( 0, 0, 1 ) );
        startangles = axistoangles( playerforward, startside, ( 0, 0, 1 ) );
        vehicle vehicle_teleport( teleportlocation, startangles );
        wait 1;
        vehicle function_b61f675503083701( 1 );
        return vehicle;
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4080
    // Size: 0x110, Type: dev
    function private function_a496584181f051a9( numpassengers )
    {
        self notify( "<dev string:x3c4>" );
        self endon( "<dev string:x3c4>" );
        assert( numpassengers > 0 );
        self.riders = [];
        self.unloadque = [];
        self.unload_group = "<dev string:x3dc>";
        vehicleforward = anglestoforward( self.angles );
        scripts\common\vehicle_aianim::handle_attached_guys();
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( self, "<dev string:x3e3>" );
        
        for ( seatindex = numpassengers; seatindex >= 0 ; seatindex-- )
        {
            spawnlocation = self.origin + vehicleforward * seatindex * 100 + ( 0, 0, 200 );
            agent = scripts\mp\mp_agent::spawnnewagentaitype( "<dev string:x3fa>", spawnlocation, self.angles, "<dev string:x3e3>", "<dev string:x422>" );
            
            if ( isdefined( agent ) )
            {
                agent.script_startingposition = seatindex;
                thread scripts\common\vehicle_aianim::guy_enter( agent );
                agent.vehiclerunexit = 1;
            }
            
            wait 0.5;
        }
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4198
    // Size: 0x2e, Type: dev
    function private function_2393c0027c00179a( vehicleref )
    {
        vehicle = function_1ab5e4e5878bd5e9( vehicleref );
        vehicle thread function_a496584181f051a9( 5 );
        return vehicle;
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x41ce
    // Size: 0x7a, Type: dev
    function private function_bbfa6f6f2d68f325( vehicleref )
    {
        vehicle = function_2393c0027c00179a( vehicleref );
        var_34bb55fbc59c2e1d = isnavmeshloaded( "<dev string:x359>" );
        var_a8c9b5fffa6387d = isnavmeshloaded( "<dev string:x36a>" );
        navmeshlayer = ter_op( var_34bb55fbc59c2e1d, "<dev string:x359>", ter_op( var_a8c9b5fffa6387d, "<dev string:x36a>", undefined ) );
        vehicle thread scripts\common\vehicle_paths::vehiclenavsplinesimplefollowbehavior( 15, navmeshlayer, 1 );
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4250
    // Size: 0x37, Type: dev
    function private function_76624b2b3e4db74f()
    {
        if ( !isdefined( level.var_620e3a366fb95fcf ) )
        {
            level.var_620e3a366fb95fcf = 0;
        }
        
        level.var_620e3a366fb95fcf = ter_op( level.var_620e3a366fb95fcf, 0, 1 );
    }

    // Namespace namespace_acac8960cc6d8d64 / namespace_16464fbff4c4f003
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x428f
    // Size: 0x117, Type: dev
    function private function_bc8d978e7b0a418c()
    {
        function_6e7290c8ee4f558b( "<dev string:x435>" );
        function_df648211d66cd3dd( "<dev string:x448>", "<dev string:x448>" );
        function_df648211d66cd3dd( "<dev string:x466>", "<dev string:x466>" );
        function_df648211d66cd3dd( "<dev string:x48b>", "<dev string:x48b>" );
        function_a9a864379a098ad6( "<dev string:x4bb>", "<dev string:x4df>", &function_76624b2b3e4db74f );
        function_b23a59dfb4ca49a1( "<dev string:x502>", "<dev string:x512>" + "<dev string:x531>", &function_1ab5e4e5878bd5e9 );
        function_b23a59dfb4ca49a1( "<dev string:x548>", "<dev string:x566>" + "<dev string:x531>", &function_2393c0027c00179a );
        function_b23a59dfb4ca49a1( "<dev string:x57d>", "<dev string:x5a1>" + "<dev string:x531>", &function_bbfa6f6f2d68f325 );
        function_b23a59dfb4ca49a1( "<dev string:x5c6>", "<dev string:x5e4>" + 0 + "<dev string:x602>" + 0, &function_cd400918a8463816 );
        function_b23a59dfb4ca49a1( "<dev string:x607>", "<dev string:x5e4>" + 1 + "<dev string:x602>" + 0, &function_cd400918a8463816 );
        function_b23a59dfb4ca49a1( "<dev string:x629>", "<dev string:x5e4>" + 0 + "<dev string:x602>" + 1, &function_cd400918a8463816 );
        function_fe953f000498048f();
    }

#/
