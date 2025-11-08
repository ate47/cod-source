#using script_102d83a437e2b29f;
#using script_24e4405cf93f20ed;
#using script_3a8f9ace195c9da9;
#using script_3cb1beed718e7650;
#using scripts\common\utility;
#using scripts\cp\cp_objectives;
#using scripts\cp\damagefeedback;
#using scripts\cp\player_death;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace namespace_59351a8acd36b6f7;

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0x3ad
// Size: 0xc5
function function_c508f809a039cc0( objectivestruct )
{
    level endon( "game_ended" );
    objectivestruct endon( "obj_laptop1_destroyed" );
    self.var_1701193cd897285e = 200;
    
    while ( self.var_1701193cd897285e > 0 )
    {
        self waittill( "damage", idamage, eattacker, vhitdir, vpoint, smeansofdeath );
        
        if ( isplayerdamage( eattacker, smeansofdeath ) )
        {
            self.var_1701193cd897285e = max( self.var_1701193cd897285e - idamage, 0 );
            eattacker scripts\cp\damagefeedback::updatedamagefeedback( "standard", self.var_1701193cd897285e == 0 );
        }
    }
    
    flag_set( "obj_laptop1_destroyed" );
    objectivestruct notify( "obj_laptop1_destroyed" );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 2
// Checksum 0x0, Offset: 0x47a
// Size: 0xc7, Type: bool
function isplayerdamage( eattacker, smeansofdeath )
{
    isplayerdamage = isdefined( eattacker ) && isplayer( eattacker );
    var_7543d4fe49c53684 = isdefined( eattacker.owner ) && isplayer( eattacker.owner );
    var_b4a897b1262ea17c = isdefined( eattacker.classname ) && eattacker.classname == "script_vehicle" && isdefined( eattacker.owner ) && isplayer( eattacker.owner );
    var_f3b5d704ca2a9b3d = var_b4a897b1262ea17c && smeansofdeath == "MOD_CRUSH";
    return isplayerdamage || var_7543d4fe49c53684 || var_f3b5d704ca2a9b3d;
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 2
// Checksum 0x0, Offset: 0x54a
// Size: 0x68
function function_7f95d1ca737bd1e1( var_dcd66f3ea861d2a2, var_edd8b8da2bfefd1f )
{
    if ( isdefined( var_edd8b8da2bfefd1f ) )
    {
        wait var_edd8b8da2bfefd1f;
    }
    
    objstruct = level.objectivestabledata[ var_dcd66f3ea861d2a2 ];
    initializeobjective( objstruct, var_dcd66f3ea861d2a2, "primary" );
    startobjective( objstruct, var_dcd66f3ea861d2a2, "primary" );
    flag_wait( var_dcd66f3ea861d2a2 + "_completed" );
    completeobjective( objstruct, var_dcd66f3ea861d2a2, "primary" );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0x5ba
// Size: 0x97
function function_1364d4e78e9acc35( targetname )
{
    door = getent( targetname, "targetname" );
    door.destination = getstruct( door.target, "targetname" );
    door.destination = getstruct( door.destination.target, "targetname" );
    door moveto( door.destination.origin, 1, 0.2, 0.2 );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 2
// Checksum 0x0, Offset: 0x659
// Size: 0x2d
function function_4e257994365fa73f( var_acba072b7e847a86, trig_targetname )
{
    level endon( "game_endon" );
    level endon( var_acba072b7e847a86 );
    function_d14fcd3a04720601( trig_targetname );
    flag_set( var_acba072b7e847a86 );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 0
// Checksum 0x0, Offset: 0x68e
// Size: 0xd3
function function_184e2f7f361596c3()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        wait_time_in_ms( 2000 );
        self waittill( "trigger", entity );
        
        if ( isdefined( entity.vehicletype ) )
        {
            vehicleoccupants = entity.occupants;
            var_95dfb4ea629973 = 0;
            
            foreach ( occupant in vehicleoccupants )
            {
                if ( isplayer( occupant ) )
                {
                    var_95dfb4ea629973 = 1;
                    break;
                }
            }
            
            if ( var_95dfb4ea629973 )
            {
                break;
            }
        }
        
        if ( !isplayer( entity ) )
        {
            continue;
        }
        
        if ( !scripts\cp\utility\player::isreallyalive( entity ) )
        {
            continue;
        }
        
        break;
    }
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 0
// Checksum 0x0, Offset: 0x769
// Size: 0x49
function function_393cdd52ca5dd62f()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            continue;
        }
        
        if ( !scripts\cp\utility\player::isreallyalive( entity ) )
        {
            continue;
        }
        
        break;
    }
    
    self notify( "player_trigger", entity );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 0
// Checksum 0x0, Offset: 0x7ba
// Size: 0x6a
function function_be5b0ca6e6af0094()
{
    level endon( "game_ended" );
    level endon( "Player_in_stealth" );
    
    while ( true )
    {
        wait_time_in_ms( 2000 );
        targetname = "vol_ai_main_house";
        requestid = function_941528a2553e5d82( targetname );
        enemies = function_d45cf335caa19838( requestid );
        
        if ( enemies < 1 )
        {
            flag_set( "Player_in_stealth" );
            break;
        }
    }
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 0
// Checksum 0x0, Offset: 0x82c
// Size: 0x69
function function_fa0cd5bf40aec37f()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            continue;
        }
        
        if ( !scripts\cp\utility\player::isreallyalive( entity ) )
        {
            continue;
        }
        
        if ( getstealthdetectstate() == "hidden" )
        {
            flag_set( "Player_in_stealth" );
        }
        else
        {
            flag_set( "Player_in_detected" );
        }
        
        break;
    }
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 0
// Checksum 0x0, Offset: 0x89d
// Size: 0x3f
function function_ab74995647ea4c()
{
    level endon( "game_ended" );
    level endon( "Player_detected" );
    
    while ( true )
    {
        wait_time_in_ms( 2000 );
        
        if ( getstealthdetectstate() != "hidden" )
        {
            flag_set( "Player_detected" );
            break;
        }
    }
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0x8e4
// Size: 0x156
function function_306342617868028a( var_e8fda99be77028d9 )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( !isdefined( var_e8fda99be77028d9 ) )
    {
        var_e8fda99be77028d9 = 15;
    }
    
    self.forced_speed = var_e8fda99be77028d9;
    thread function_a415024439379f6f( self );
    driver = self.riders[ 0 ];
    
    if ( isdefined( driver ) )
    {
        driver thread function_a415024439379f6f( self );
    }
    
    self waittill( "jltv_stop" );
    self notify( "newpath" );
    self notify( "reached_dynamic_path_end" );
    self.forced_speed = 0;
    self notify( "path_updated" );
    self setconfigvalue( "p2p", "brakeAtGoal", 1 );
    self setconfigvalue( "p2p", "goalPoint", self.origin );
    self stoppath();
    self vehicle_setspeedimmediate( 0, 1, 1 );
    self vehicle_cleardrivingstate();
    waitframe();
    
    if ( getdvarint( @"hash_957b41c68f110ce9", 0 ) != 0 )
    {
        return;
    }
    
    if ( !self hascomponent( "p2p" ) )
    {
        return;
    }
    
    function_ecbcec373d227be( 0, "default", 1 );
    self vehphys_parkingbrake( 1 );
    self vehicle_turnengineoff();
    namespace_cbe993018617a21d::function_1686ecaabfdc542d();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( self, "neutral" );
    
    if ( isdefined( level.vehicle.var_9442d439c225c3fe ) )
    {
        if ( [[ level.vehicle.var_9442d439c225c3fe ]]( self ) )
        {
            return 1;
        }
    }
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0xa42
// Size: 0x37
function function_a415024439379f6f( jltv )
{
    level endon( "game_ended" );
    jltv endon( "jltv_stop" );
    waittill_any_3( "death", "unloaded", "unloading" );
    jltv notify( "jltv_stop" );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 0
// Checksum 0x0, Offset: 0xa81
// Size: 0x16c
function function_137fc90d1f21350c()
{
    flag_wait( "flag_dungeon_intro_complete" );
    level.player waittill( "killed_player", attacker, meansofdeath, objweapon, inflictor );
    attacker = default_to( attacker, level.player.attacker );
    attacker_weapon = isdefined( level.player.laststanddowneddata ) && isdefined( level.player.laststanddowneddata.weaponfullstring ) ? level.player.laststanddowneddata.weaponfullstring : undefined;
    deathBy = "generic";
    deathquote = undefined;
    
    if ( is_equal( attacker_weapon, "assault_drone_mp" ) )
    {
        deathquote = 536;
    }
    else if ( is_equal( meansofdeath, "MOD_SUICIDE" ) && is_equal( attacker_weapon, "iw9_drown_mp" ) )
    {
        deathquote = 153;
    }
    else if ( isdefined( attacker ) )
    {
        if ( is_equal( attacker.classname, "laser_trap" ) )
        {
            deathBy = "claymore";
            deathquote = 527;
        }
    }
    
    namespace_96731f4d002634f6::function_2311740fe797906a( "deathBy", deathBy );
    
    if ( isdefined( deathquote ) )
    {
        scripts\cp\player_death::set_custom_death_quote( deathquote, 1 );
    }
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 4
// Checksum 0x0, Offset: 0xbf5
// Size: 0x1c8
function function_9abe9350cc74539e( spawner_name, vehicle_speed, var_f692565186a11dfc, force_spawn )
{
    veh_spawner = getstruct( spawner_name, "targetname" );
    
    if ( !isdefined( veh_spawner ) )
    {
        assertmsg( "Vehicle spawner: " + spawner_name + " does not exist." );
        return;
    }
    
    if ( !isdefined( var_f692565186a11dfc ) )
    {
        assertmsg( "Vehicle spawner: " + spawner_name + " does not have an ai_think()!" );
        return;
    }
    
    var_2080297e17b86673 = veh_spawner.script_vehiclegroup;
    
    if ( !isdefined( var_2080297e17b86673 ) )
    {
        assertmsg( "Vehicle spawner: " + spawner_name + " does not have a script_vehiclegroup to spawn enemies." );
        return;
    }
    
    veh_spawner.script_vehiclegroup = undefined;
    vehicle = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e( veh_spawner, undefined, "p2p", undefined, 1 );
    spawners = getstructarray( var_2080297e17b86673, "targetname" );
    starting_pos = 0;
    
    foreach ( spawner in spawners )
    {
        if ( istrue( force_spawn ) )
        {
            spawner.script_count = 1;
            spawner.script_forcespawn = 1;
        }
        
        spawner.veh = vehicle;
        
        if ( !isdefined( spawner.script_startingposition ) )
        {
            assertmsg( var_2080297e17b86673 + " needs script_startingposition's for vehicle. " );
            spawner.script_startingposition = starting_pos;
            starting_pos += 1;
        }
    }
    
    ai_spawn = namespace_a0852b262a68d01::function_6149b301ce19988b( var_2080297e17b86673, var_f692565186a11dfc );
    vehicle thread function_306342617868028a( vehicle_speed );
    vehicle thread namespace_ba155a12c323dc5a::resume_path();
    return vehicle;
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0xdc6
// Size: 0x9b
function function_60dc5c690ccc2a2c( var_cab5bc7f505859d4 )
{
    if ( !isfunction( var_cab5bc7f505859d4 ) )
    {
        assertmsg( "Cannot run branching paths without a branch function." );
        return;
    }
    
    flag_wait( "flag_dungeon_intro_complete" );
    
    if ( !isdefined( self.spawner ) || !isdefined( self.spawner.target ) )
    {
        return;
    }
    
    target_node = getstruct( self.spawner.target, "targetname" );
    path_nodes = target_node scripts\cp\spawning::get_next_node_array();
    thread scripts\cp\spawning::go_to_node( path_nodes, var_cab5bc7f505859d4 );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0xe69
// Size: 0xb2
function function_941cd7a30718ecb8( node )
{
    var_fff15c3ac9cc144e = node.var_9987f724c05e74ba;
    
    if ( !isdefined( var_fff15c3ac9cc144e ) )
    {
        return;
    }
    
    var_f7983964cc48896e = flag( var_fff15c3ac9cc144e );
    
    if ( !var_f7983964cc48896e )
    {
        return;
    }
    
    next_node = getstruct( var_fff15c3ac9cc144e + "_active", "targetname" );
    
    if ( !isdefined( next_node ) )
    {
        assertmsg( "Node struct " + var_fff15c3ac9cc144e + "_active does not exist." );
        return;
    }
    
    path_nodes = next_node scripts\cp\spawning::get_next_node_array();
    var_fc577bb34ce42363 = default_to( self.var_11bb3b9a5482848c, &function_941cd7a30718ecb8 );
    thread scripts\cp\spawning::go_to_node( path_nodes, var_fc577bb34ce42363 );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0xf23
// Size: 0xb3
function function_c89faf236aaf59dc( node )
{
    var_fff15c3ac9cc144e = node.var_9987f724c05e74ba;
    
    if ( !isdefined( var_fff15c3ac9cc144e ) )
    {
        return;
    }
    
    if ( isdefined( node.target ) )
    {
        return;
    }
    
    flag_wait( var_fff15c3ac9cc144e );
    next_node = getstruct( var_fff15c3ac9cc144e + "_active", "targetname" );
    
    if ( !isdefined( next_node ) )
    {
        assertmsg( "Node struct " + var_fff15c3ac9cc144e + "_active does not exist." );
        return;
    }
    
    path_nodes = next_node scripts\cp\spawning::get_next_node_array();
    var_fc577bb34ce42363 = default_to( self.var_11bb3b9a5482848c, &function_c89faf236aaf59dc );
    thread scripts\cp\spawning::go_to_node( path_nodes, var_fc577bb34ce42363 );
}

// Namespace namespace_59351a8acd36b6f7 / namespace_11a6292c31c9b8e0
// Params 1
// Checksum 0x0, Offset: 0xfde
// Size: 0x37
function function_ab4aa528604a3a65( node )
{
    if ( isdefined( node.target ) )
    {
        return;
    }
    
    self.dontdropweapon = 1;
    self.dropweapon = 0;
    scripts\cp_mp\agents\agent_utils::despawnagent();
}

