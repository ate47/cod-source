#using script_102d83a437e2b29f;
#using script_3a8f9ace195c9da9;
#using script_f603f40349f99c8;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace reinforcement_util;

// Namespace reinforcement_util / scripts\cp\utility\reinforcement_util
// Params 2
// Checksum 0x0, Offset: 0x20a
// Size: 0x65
function function_8bcc57ecc1d97b99( var_4fc8f8139dbb2513, var_bd977d7be720602c )
{
    level.reinforcementmgr = spawnstruct();
    level.reinforcementmgr.var_93712922d49ccfe4 = [];
    level.reinforcementmgr.var_bd977d7be720602c = var_bd977d7be720602c;
    level flag_set( "reinforcementMgr_initialized" );
    thread [[ var_4fc8f8139dbb2513 ]]();
    thread function_4263d0d23af617df();
}

// Namespace reinforcement_util / scripts\cp\utility\reinforcement_util
// Params 5
// Checksum 0x0, Offset: 0x277
// Size: 0x1b8
function add_reinforcement( var_dfec89ad8ca0cdc1, var_1b4eb49dae050e20, var_f249c0bb3d7fb281, predicates, var_c1cc3c4bab7d6d0b )
{
    assert( isdefined( var_dfec89ad8ca0cdc1 ) && isstring( var_dfec89ad8ca0cdc1 ) );
    assert( isdefined( var_1b4eb49dae050e20 ) && isint( var_1b4eb49dae050e20 ) );
    assert( isdefined( var_f249c0bb3d7fb281 ) && isstring( var_f249c0bb3d7fb281 ) );
    level flag_wait( "reinforcementMgr_initialized" );
    targetdata = level.reinforcementmgr.var_93712922d49ccfe4[ var_dfec89ad8ca0cdc1 ];
    
    if ( !isdefined( targetdata ) )
    {
        targetdata = spawnstruct();
        targetdata.var_dfec89ad8ca0cdc1 = var_dfec89ad8ca0cdc1;
        targetdata.spawners = [];
        targetdata.var_d625f475dff5d2bd = 0;
        targetdata.groupsize = getstructarray( var_dfec89ad8ca0cdc1, "targetname" ).size;
        level.reinforcementmgr.var_93712922d49ccfe4[ var_dfec89ad8ca0cdc1 ] = targetdata;
    }
    
    assertex( !isdefined( targetdata.spawners[ var_f249c0bb3d7fb281 ] ), "add_reinforcement Error - trying to add a duplicate spawner (targetnameToSpawn)" );
    assertex( var_1b4eb49dae050e20 <= targetdata.groupsize, "add_reinforcement Error - there are fewer enemies than you want to kill" );
    var_4262643d07dfa727 = spawnstruct();
    var_4262643d07dfa727.var_1b4eb49dae050e20 = var_1b4eb49dae050e20;
    var_4262643d07dfa727.var_f249c0bb3d7fb281 = var_f249c0bb3d7fb281;
    var_4262643d07dfa727.predicates = [];
    var_4262643d07dfa727.var_c1cc3c4bab7d6d0b = var_c1cc3c4bab7d6d0b;
    
    if ( isdefined( predicates ) )
    {
        if ( isarray( predicates ) )
        {
            var_4262643d07dfa727.predicates = predicates;
        }
        else
        {
            var_4262643d07dfa727.predicates[ 0 ] = predicates;
        }
    }
    
    targetdata.spawners[ var_f249c0bb3d7fb281 ] = var_4262643d07dfa727;
}

// Namespace reinforcement_util / scripts\cp\utility\reinforcement_util
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x437
// Size: 0x265
function private function_4263d0d23af617df()
{
    level endon( "game_ended" );
    level flag_wait( "reinforcementMgr_initialized" );
    
    while ( true )
    {
        foreach ( targetdata in level.reinforcementmgr.var_93712922d49ccfe4 )
        {
            if ( !isdefined( targetdata ) )
            {
                continue;
            }
            
            spawnqueue = [];
            spawncount = 0;
            
            foreach ( spawner in targetdata.spawners )
            {
                if ( targetdata.var_d625f475dff5d2bd < spawner.var_1b4eb49dae050e20 )
                {
                    continue;
                }
                
                var_25a0373bcaf45538 = 1;
                
                foreach ( var_6788e3106fcb4652 in spawner.predicates )
                {
                    if ( ![[ var_6788e3106fcb4652 ]]() )
                    {
                        var_25a0373bcaf45538 = 0;
                        break;
                    }
                }
                
                if ( var_25a0373bcaf45538 )
                {
                    spawnqueue[ spawncount ] = spawner;
                    spawncount += 1;
                }
            }
            
            foreach ( tospawn in spawnqueue )
            {
                if ( tospawn.var_f249c0bb3d7fb281 != "" )
                {
                    function_6149b301ce19988b( tospawn.var_f249c0bb3d7fb281, level.reinforcementmgr.var_bd977d7be720602c );
                }
                
                if ( isdefined( tospawn.var_c1cc3c4bab7d6d0b ) )
                {
                    thread [[ tospawn.var_c1cc3c4bab7d6d0b ]]();
                }
            }
            
            foreach ( var_d82f76c79780c083 in spawnqueue )
            {
                targetdata.spawners[ var_d82f76c79780c083.var_f249c0bb3d7fb281 ] = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace reinforcement_util / scripts\cp\utility\reinforcement_util
// Params 1
// Checksum 0x0, Offset: 0x6a4
// Size: 0x5d
function function_6e91939ff8132810( enemygroup )
{
    flag_wait( "reinforcementMgr_initialized" );
    
    if ( !isdefined( enemygroup ) )
    {
        return;
    }
    
    targetdata = level.reinforcementmgr.var_93712922d49ccfe4[ enemygroup ];
    
    if ( !isdefined( targetdata ) )
    {
        return;
    }
    
    targetdata.var_d625f475dff5d2bd += 1;
}

// Namespace reinforcement_util / scripts\cp\utility\reinforcement_util
// Params 7
// Checksum 0x0, Offset: 0x709
// Size: 0x224
function heli_reinforcements( heli_name, heli_health, heli_type, var_81bab6febf7f6625, var_8fe58d021853358c, var_65a79f108a26d325, var_493bc9bba3b495b )
{
    if ( isstring( var_493bc9bba3b495b ) && var_493bc9bba3b495b != "" )
    {
        flag_wait( var_493bc9bba3b495b );
    }
    
    if ( !isdefined( heli_name ) || !isstring( heli_name ) || heli_name == "" )
    {
        assertmsg( "Reinforcements helicopter needs a name to find the vehicle spawner struct." );
        return;
    }
    
    veh_spawners = getstructarray( heli_name, "targetname" );
    
    if ( !isdefined( veh_spawners ) || veh_spawners.size < 1 )
    {
        assertmsg( "Vehicle spawner struct " + heli_name + " does not exist." );
        return;
    }
    
    veh_spawner = veh_spawners[ 0 ];
    
    if ( !isdefined( var_81bab6febf7f6625 ) )
    {
        var_81bab6febf7f6625 = 0;
    }
    
    veh_spawner.var_bb38e84f2964aa8a = !var_81bab6febf7f6625;
    
    if ( istrue( var_8fe58d021853358c ) )
    {
        veh_spawner.target = undefined;
    }
    
    if ( isdefined( heli_type ) && isstring( heli_type ) && heli_type != "" )
    {
        foreach ( spawner in veh_spawners )
        {
            spawner.script_function = heli_type;
        }
    }
    
    heli = namespace_548a10c405703106::function_e48fde1878d8a034( veh_spawner );
    heli.no_evasive = 1;
    heli.nocrash = 1;
    
    if ( isdefined( heli_health ) && isnumber( heli_health ) )
    {
        heli.health_remaining = heli_health;
    }
    
    if ( !istrue( var_65a79f108a26d325 ) )
    {
        return heli;
    }
    
    foreach ( rider in heli.riders )
    {
        rider.heli = heli;
        rider thread function_aeab3822a7542ef4();
    }
    
    return heli;
}

// Namespace reinforcement_util / scripts\cp\utility\reinforcement_util
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x936
// Size: 0x8d, Type: bool
function private function_aeab3822a7542ef4()
{
    if ( !isdefined( self.heli ) )
    {
        return false;
    }
    
    self.heli waittill( "unloaded" );
    self.ignoreall = 1;
    namespace_a0852b262a68d01::function_fac67371e80874db();
    self setstealthstate( "idle" );
    struct_goal = getstruct( self.target, "targetname" );
    self setgoalpos( struct_goal.origin );
    waittill_any_return_2( "reached_path_end", "stop_going_to_node" );
    self.ignoreall = 0;
    return true;
}

