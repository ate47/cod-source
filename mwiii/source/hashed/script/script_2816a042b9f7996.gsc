#using script_261f1b574c15eab1;
#using script_3a535b44f9ecc6df;
#using script_57f43a9386f138c1;
#using script_7abaa04d5f9fc22e;
#using script_9880b9dc28bc25e;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\quaked\script_struct_mp_iw9_atv;
#using scripts\quaked\script_struct_mp_iw9_cargo_truck;
#using scripts\quaked\script_struct_mp_iw9_jltv;
#using scripts\quaked\script_struct_mp_iw9_jltv_mg;
#using scripts\quaked\script_struct_mp_iw9_patrol_boat;
#using scripts\quaked\script_struct_mp_iw9_rhib;
#using scripts\quaked\script_struct_mp_iw9_suv_1996;
#using scripts\quaked\script_struct_mp_iw9_techo_rebel_armor;
#using scripts\quaked\script_struct_mp_iw9_utv;
#using scripts\quaked\script_struct_mp_littlebird;

#namespace namespace_b238231af8cd48f9;

// Namespace namespace_b238231af8cd48f9 / namespace_f9b6a4254d2d8100
// Params 0
// Checksum 0x0, Offset: 0x3f2
// Size: 0x2a8
function init_vehicles()
{
    if ( flag( "jup_init_vehicles" ) )
    {
        return;
    }
    
    flag_set( "jup_init_vehicles" );
    var_7999b13e84b9a7e2 = getdvarint( @"hash_b5ed2429667c9012", 1 );
    var_e06bfab0908942e3 = "atv";
    var_a756dbc9ec43e6c4 = "veh9_techo_rebel_armor";
    var_292885c46f289809 = "veh9_sedan_hatchback_1985";
    var_66b823d7a5bda880 = "veh9_jltv";
    var_cb5cbdb600ae9010 = "veh_jup_jltv";
    var_85db8d6a4980b94b = "veh9_jltv_cargo";
    var_6b50a89a1c870b17 = "veh9_jltv_mg";
    var_e1b12ab30a19ece7 = "veh_jup_jltv_mg";
    var_af7d78971c199e4e = "veh_jup_suv_1996";
    var_48f402c855d38e88 = "veh_jup_pickup_2014";
    var_20e578a22db9e8e7 = "veh9_mil_cargo_truck";
    var_44ceab322a7c3b3f = "veh9_utv";
    var_3e24223a358a045f = "veh9_overland_2016";
    var_8ac9b9676fbd30d9 = "veh9_rhib";
    var_eee18d8aff966233 = "veh9_patrol_boat";
    var_756d71158bc57937 = "veh9_motorcycle_blood_burner";
    level.var_7e4cea664f542a3c = [];
    level.var_7e4cea664f542a3c[ "motorcycle_blood_burner_spawn" ] = var_756d71158bc57937;
    level.var_7e4cea664f542a3c[ "overland_2016_spawn" ] = var_3e24223a358a045f;
    level.var_7e4cea664f542a3c[ "sedan_hatchback_1985_spawn" ] = var_292885c46f289809;
    level.var_7e4cea664f542a3c[ "atv_spawn" ] = var_e06bfab0908942e3;
    level.var_7e4cea664f542a3c[ "jltv_spawn" ] = var_66b823d7a5bda880;
    level.var_7e4cea664f542a3c[ "jltv_cargo_spawn" ] = var_85db8d6a4980b94b;
    level.var_7e4cea664f542a3c[ "jltv_mg_spawn" ] = var_6b50a89a1c870b17;
    level.var_7e4cea664f542a3c[ "suv_1996_spawn" ] = var_af7d78971c199e4e;
    level.var_7e4cea664f542a3c[ "pickup_2014_spawn" ] = var_48f402c855d38e88;
    level.var_7e4cea664f542a3c[ "mil_cargo_truck_spawn" ] = var_20e578a22db9e8e7;
    level.var_7e4cea664f542a3c[ "techo_rebel_spawn" ] = var_a756dbc9ec43e6c4;
    level.var_7e4cea664f542a3c[ "utv_spawn" ] = var_44ceab322a7c3b3f;
    
    if ( var_7999b13e84b9a7e2 )
    {
        level.var_7e4cea664f542a3c[ "rhib_spawn" ] = var_8ac9b9676fbd30d9;
        level.var_7e4cea664f542a3c[ "patrol_boat_spawn" ] = var_eee18d8aff966233;
    }
    
    level.var_1b4da6b781c9dfbd = 1;
    namespace_8db7d778efdc3d65::main();
    namespace_15896d40cab0d429::main();
    scripts\quaked\script_struct_mp_iw9_atv::main();
    scripts\quaked\script_struct_mp_littlebird::main();
    scripts\quaked\script_struct_mp_iw9_jltv::main();
    namespace_124a01010aeb4093::main();
    scripts\quaked\script_struct_mp_iw9_jltv_mg::main();
    scripts\quaked\script_struct_mp_iw9_suv_1996::main();
    namespace_a5c3c313b4f6886a::main();
    scripts\quaked\script_struct_mp_iw9_cargo_truck::main();
    scripts\quaked\script_struct_mp_iw9_techo_rebel_armor::main();
    scripts\quaked\script_struct_mp_iw9_utv::main();
    scripts\quaked\script_struct_mp_iw9_rhib::main();
    scripts\quaked\script_struct_mp_iw9_patrol_boat::main();
    level flag_set( "vehicles_loaded" );
}

// Namespace namespace_b238231af8cd48f9 / namespace_f9b6a4254d2d8100
// Params 1
// Checksum 0x0, Offset: 0x6a2
// Size: 0x157
function function_48f13f47907a7e67( var_fcd28e3502bd7a3f )
{
    level flag_wait( "vehicles_loaded" );
    a_s_spawnpoints = [];
    
    foreach ( s_group in var_fcd28e3502bd7a3f )
    {
        foreach ( refname in level.var_7e4cea664f542a3c )
        {
            var_66b85e46e4ec596 = scripts\cp_mp\vehicles\vehicle_spawn::function_b08e7e3a0b14f76f( refname );
            
            foreach ( s_spawn in var_66b85e46e4ec596 )
            {
                if ( isdefined( s_spawn.script_string ) && isdefined( s_group.script_string ) && s_spawn.script_string == s_group.script_string )
                {
                    s_spawn.refname = refname;
                    a_s_spawnpoints[ a_s_spawnpoints.size ] = s_spawn;
                }
            }
        }
    }
    
    return a_s_spawnpoints;
}

// Namespace namespace_b238231af8cd48f9 / namespace_f9b6a4254d2d8100
// Params 0
// Checksum 0x0, Offset: 0x802
// Size: 0x1c3
function function_c7028a51e2858e73()
{
    var_7b5e0baa21a95939 = getdvarint( @"hash_e70605bdd7aa1e98", 0 );
    var_484a5eb0bb208daf = getdvarint( @"hash_771650cbeeca1ab2", 0 );
    
    if ( var_7b5e0baa21a95939 > var_484a5eb0bb208daf )
    {
        var_7b5e0baa21a95939 = var_484a5eb0bb208daf;
    }
    
    if ( var_7b5e0baa21a95939 >= 0 && var_484a5eb0bb208daf > 0 && var_7b5e0baa21a95939 < var_484a5eb0bb208daf )
    {
        var_484a5eb0bb208daf = randomintrange( var_7b5e0baa21a95939, var_484a5eb0bb208daf + 1 );
    }
    
    var_3b9c1611f5d3d727 = 0;
    level flag_wait( "vehicles_loaded" );
    a_s_spawnpoints = [];
    var_6faca44abd05e178 = [];
    var_2b3cfed5214352a4 = [];
    
    foreach ( refname in level.var_7e4cea664f542a3c )
    {
        if ( !scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnvehicle( refname ) )
        {
            continue;
        }
        
        var_66b85e46e4ec596 = scripts\cp_mp\vehicles\vehicle_spawn::function_b08e7e3a0b14f76f( refname );
        
        foreach ( s_spawn in var_66b85e46e4ec596 )
        {
            s_spawn.refname = refname;
        }
        
        if ( refname == level.var_7e4cea664f542a3c[ "motorcycle_blood_burner_spawn" ] )
        {
            var_6faca44abd05e178 = array_randomize( var_66b85e46e4ec596 );
            
            if ( var_6faca44abd05e178.size >= var_484a5eb0bb208daf )
            {
                for ( i = 0; i < var_484a5eb0bb208daf ; i++ )
                {
                    var_2b3cfed5214352a4[ i ] = var_6faca44abd05e178[ i ];
                }
            }
            
            a_s_spawnpoints = array_combine( a_s_spawnpoints, var_2b3cfed5214352a4 );
            continue;
        }
        
        a_s_spawnpoints = array_combine( a_s_spawnpoints, var_66b85e46e4ec596 );
    }
    
    return array_randomize( a_s_spawnpoints );
}

// Namespace namespace_b238231af8cd48f9 / namespace_f9b6a4254d2d8100
// Params 1
// Checksum 0x0, Offset: 0x9ce
// Size: 0x29
function spawn_vehicle( s_spawn )
{
    scripts\cp_mp\vehicles\vehicle::vehicle_spawn( s_spawn.refname, s_spawn );
    s_spawn.refname = undefined;
}

// Namespace namespace_b238231af8cd48f9 / namespace_f9b6a4254d2d8100
// Params 1
// Checksum 0x0, Offset: 0x9ff
// Size: 0x27e
function function_63c6d4fbc0bc4d94( var_fcd28e3502bd7a3f )
{
    if ( getdvarint( @"hash_a6e925b5c1930590", 0 ) )
    {
        return;
    }
    
    level flag_wait( "vehicles_loaded" );
    
    foreach ( s_group in var_fcd28e3502bd7a3f )
    {
        s_group.var_a55bdf5119d2d32 = [];
        
        foreach ( refname in level.var_7e4cea664f542a3c )
        {
            var_66b85e46e4ec596 = scripts\cp_mp\vehicles\vehicle_spawn::function_b08e7e3a0b14f76f( refname );
            
            foreach ( s_spawn in var_66b85e46e4ec596 )
            {
                if ( isdefined( s_spawn.script_string ) && isdefined( s_group.script_string ) && s_spawn.script_string == s_group.script_string )
                {
                    s_group.var_a55bdf5119d2d32[ s_group.var_a55bdf5119d2d32.size ] = s_spawn;
                    s_group.var_a55bdf5119d2d32[ s_group.var_a55bdf5119d2d32.size - 1 ].refname = refname;
                }
            }
        }
    }
    
    foreach ( s_group in var_fcd28e3502bd7a3f )
    {
        var_1e021a30b73c352 = array_randomize( s_group.var_a55bdf5119d2d32 );
        
        if ( isdefined( var_1e021a30b73c352[ 0 ] ) )
        {
            var_2e0b67f29fcb158 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( var_1e021a30b73c352[ 0 ].refname, var_1e021a30b73c352[ 0 ] );
            
            if ( var_1e021a30b73c352[ 0 ].refname == "atv" )
            {
                for ( i = 1; i < var_1e021a30b73c352.size - 1 ; i++ )
                {
                    if ( var_1e021a30b73c352[ i ].refname == "atv" )
                    {
                        vh_atv = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( var_1e021a30b73c352[ i ].refname, var_1e021a30b73c352[ i ] );
                    }
                }
            }
        }
    }
}

// Namespace namespace_b238231af8cd48f9 / namespace_f9b6a4254d2d8100
// Params 1
// Checksum 0x0, Offset: 0xc85
// Size: 0x110
function on_ai_killed( sparams )
{
    if ( !isdefined( sparams.eattacker ) )
    {
        return;
    }
    
    if ( sparams.eattacker scripts\cp_mp\vehicles\vehicle::isvehicle() && isdefined( sparams.eattacker.owner ) && isplayer( sparams.eattacker.owner ) && !isdefined( sparams.eattacker.var_7fff3293eab0f7b8 ) )
    {
        vehicle = sparams.eattacker;
        player = sparams.eattacker.owner;
        vehicle.var_7fff3293eab0f7b8 = 1;
        vehicle playrumbleonentity( "artillery_rumble_heavy" );
        
        if ( isdefined( sparams.idamage ) && isdefined( self ) )
        {
            n_damage = int( sparams.idamage * 0.05 );
            vehicle thread function_743e37eebd6ba8e2( n_damage );
        }
    }
}

// Namespace namespace_b238231af8cd48f9 / namespace_f9b6a4254d2d8100
// Params 1
// Checksum 0x0, Offset: 0xd9d
// Size: 0x6f
function function_743e37eebd6ba8e2( n_damage )
{
    self endon( "death" );
    playsoundatpos( self.origin, "evt_zm_core_zombie_objective_impact" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner earthquakeforplayer( 1, 0.2, self.origin, 200 );
    }
    
    scripts\common\vehicle::vehicle_damage( n_damage );
    wait 0.1;
    self.var_7fff3293eab0f7b8 = undefined;
}

