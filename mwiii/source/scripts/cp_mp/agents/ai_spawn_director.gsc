#using script_2d05e472a90adb1d;
#using script_30fbbeb9a6251e9a;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\stealth\manager;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_anim;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\stealth\enemy;

#namespace ai_spawn_director;

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x9bb
// Size: 0x503
function private function_eea40a1b6180f90a( requestid, data )
{
    agent = data.agent;
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent.directorambient = istrue( data.ambient );
    agent.directorrequestid = requestid;
    agent.directorspawndata = data;
    callbackstruct = function_8c8ae740367137ba( "OnSpawned", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, agent, data );
    }
    
    foreach ( entry in level.var_49918a00761930d4 )
    {
        thread [[ entry ]]( agent, requestid, data );
    }
    
    if ( isdefined( data.script_stealthgroup ) )
    {
        agent thread function_6ecf133b1d8dee02( data );
    }
    
    agent.var_af27b6a3d3a2f6af = data.var_af27b6a3d3a2f6af;
    isvehiclespawn = 0;
    
    if ( isdefined( data.vehiclespawntarget ) )
    {
        isvehiclespawn = 1;
        agent.var_f327ed481efe4857 = 1;
        data.vehiclespawntarget thread scripts\common\vehicle_aianim::guy_enter( agent );
        agent thread function_fe875eadc4fcf2c2( requestid );
        agent thread function_2d3a114748311c18();
    }
    else if ( isdefined( data.vehicle_index ) )
    {
        assertex( agent.behaviortreeasset != "<dev string:x1c>", "<dev string:x2d>" );
        agent.var_f327ed481efe4857 = 1;
        isvehiclespawn = 1;
        
        if ( !isdefined( level.var_8cd784cab6ecbb43[ requestid ] ) )
        {
            vehicleinfostruct = spawnstruct();
            vehicleinfostruct.vehicle = data.vehicle;
            vehicleinfostruct.vehicle_index = data.vehicle_index;
            vehicleinfostruct.riders = [];
            vehicleinfostruct.riders[ 0 ] = agent;
            vehicleinfostruct.unload_pos = data.var_273ee8fdc64cf9aa;
            vehicleinfostruct.var_891e2bd59c71ae44 = data.var_891e2bd59c71ae44;
            level.var_8cd784cab6ecbb43[ requestid ] = vehicleinfostruct;
        }
        else
        {
            ridersarray = level.var_8cd784cab6ecbb43[ requestid ].riders;
            level.var_8cd784cab6ecbb43[ requestid ].riders = function_6d6af8144a5131f1( ridersarray, agent );
        }
    }
    
    if ( isdefined( data.var_35b7f8cbbef2653a ) )
    {
        isvehiclespawn = 1;
        agent thread function_77b24ac305d25629( data );
    }
    
    if ( !isvehiclespawn )
    {
        if ( istrue( data.smokebombinfil ) )
        {
            agent thread function_94e87cabbe0c24af( agent.origin );
        }
        
        agent _precombat( data );
    }
    
    if ( getdvarint( @"hash_bf14cfde8e249160", 0 ) == 1 && agent.type == "zombie" && data.ambient )
    {
        agent thread function_6710855bea599a1f( data.encounterradius );
    }
    
    if ( data.spawnspeed != 2 )
    {
        var_7c62cb453a76a50d = ter_op( istrue( data.alert ) || data.spawnspeed == 1, "spawn_fast", "spawn" );
        spawn_anim_alias = default_to( data.animscripted_alias, var_7c62cb453a76a50d );
        
        if ( agent function_8fa69650e33c84ef( spawn_anim_alias ) )
        {
            if ( istrue( data.var_324052602cf96b90 ) )
            {
                animscripted_origin = data.origin;
                var_5f41de053ae1fe72 = 10;
                
                if ( abs( agent function_8efc1cbdaa97f95e( spawn_anim_alias )[ 2 ] ) > var_5f41de053ae1fe72 )
                {
                    animscripted_origin = data.animscripted_origin;
                }
                
                agent thread animscriptedagent( spawn_anim_alias, "spawn_end", animscripted_origin, data.angles, "spawn_animating" );
            }
            else
            {
                movedelta = agent function_8efc1cbdaa97f95e( spawn_anim_alias );
                angledelta = agent function_5173aedda202662( spawn_anim_alias );
                movedelta = rotatevector( movedelta, data.angles );
                startorigin = data.origin - movedelta;
                startangles = ( data.angles[ 0 ], angleclamp( data.angles[ 1 ] - angledelta ), data.angles[ 2 ] );
                agent thread animscriptedagent( spawn_anim_alias, "spawn_end", startorigin, startangles, "spawn_animating" );
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_fe20797ad12b2dbe", 0 ) == 1 )
        {
            agent thread function_66be042996360501();
        }
    #/
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xec6
// Size: 0x22b
function private function_94e87cabbe0c24af( grenadeloc )
{
    self hide();
    delaycall( 0.5, &show );
    
    if ( !isdefined( level.var_ec14cbfd51136cd4[ self.directorrequestid ] ) )
    {
        level.var_ec14cbfd51136cd4[ self.directorrequestid ] = [];
    }
    
    var_ee1736139b7098d3 = [];
    
    foreach ( var_3b73d837cbd90e13 in level.var_ec14cbfd51136cd4[ self.directorrequestid ] )
    {
        if ( gettime() < var_3b73d837cbd90e13.endtime )
        {
            var_ee1736139b7098d3[ var_ee1736139b7098d3.size ] = var_3b73d837cbd90e13;
        }
    }
    
    level.var_ec14cbfd51136cd4[ self.directorrequestid ] = var_ee1736139b7098d3;
    
    foreach ( var_3b73d837cbd90e13 in level.var_ec14cbfd51136cd4[ self.directorrequestid ] )
    {
        if ( distancesquared( grenadeloc, var_3b73d837cbd90e13.origin ) < 30625 )
        {
            return;
        }
    }
    
    /#
        if ( getdvarint( @"hash_876ad02b2995d446", 0 ) == 1 )
        {
            sphere( grenadeloc, sqrt( 30625 ), ( 1, 0, 0 ), 1, int( 160 ) );
        }
    #/
    
    smokegrenadeent = magicgrenademanual( "smoke_grenade_reinforcement_cover", grenadeloc, ( 0, 0, -10 ), 0 );
    thread play_sound_in_space( "smoke_grenade_expl_trans", smokegrenadeent.origin );
    var_3b73d837cbd90e13 = spawnstruct();
    var_3b73d837cbd90e13.origin = smokegrenadeent.origin;
    var_3b73d837cbd90e13.endtime = gettime() + 8000;
    level.var_ec14cbfd51136cd4[ self.directorrequestid ] = array_add( level.var_ec14cbfd51136cd4[ self.directorrequestid ], var_3b73d837cbd90e13 );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10f9
// Size: 0x244
function private _precombat( data )
{
    self endon( "death" );
    
    if ( self.unittype == "soldier" )
    {
        if ( isdefined( data.interaction_id ) )
        {
            interactdatanode = spawnstruct();
            interactdatanode.script_delay = data.script_delay;
            interactdatanode.script_delay_min = data.script_delay_min;
            interactdatanode.script_delay_max = data.script_delay_max;
            
            if ( data.script_delay_min == data.script_delay_max )
            {
                if ( data.script_delay_min != 0 )
                {
                    interactdatanode.script_delay = data.script_delay_min;
                }
                
                interactdatanode.script_delay_min = undefined;
                interactdatanode.script_delay_max = undefined;
            }
            
            if ( isdefined( data.repeat_interaction ) && istrue( int( data.repeat_interaction ) ) )
            {
                interactdatanode.repeat_interaction = 1;
            }
            
            if ( istrue( data.script_faceangles ) )
            {
                interactdatanode.script_faceangles = 1;
            }
            
            if ( istrue( data.script_cleanexit ) )
            {
                interactdatanode.script_cleanexit = 1;
            }
            
            self._blackboard.idlenode = interactdatanode;
            _setgoalpos( getinteractionorigin( data.interaction_id ), 64, 1 );
            self function_76b3cfb91ef40b3b( data.interaction_id );
            
            if ( isdefined( data.path_array ) )
            {
                thread function_93ae2d91d511dad8( data.path_array );
            }
            
            return;
        }
        
        if ( isdefined( data.path_array ) )
        {
            function_618cf23700c29e56( data.path_array );
            return;
        }
        
        if ( isdefined( data.covernodetarget ) )
        {
            node = getnode( data.covernodetarget, "targetname" );
            
            if ( isdefined( node ) )
            {
                if ( self usecovernodeifpossible( node ) )
                {
                    self setgoalnode( node );
                }
            }
            
            return;
        }
        
        if ( istrue( data.ambient ) )
        {
            thread _wander( self, 500, 0, self.origin );
        }
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1345
// Size: 0xb9
function private function_6ecf133b1d8dee02( data )
{
    self endon( "death" );
    
    if ( isdefined( data.script_stealthgroup ) && level.gametype != "dungeons" )
    {
        self.script_stealthgroup = data.script_stealthgroup;
        thread scripts\stealth\enemy::main();
        thread scripts\cp_mp\stealth\manager::monitor_death_thread( level.stealth.damage_auto_range, level.stealth.damage_sight_range );
        self.var_ba67494935b9726b = 1;
        waitframe();
        
        if ( istrue( data.alert ) && isdefined( self.fnsetstealthstate ) )
        {
            self [[ self.fnsetstealthstate ]]( "combat" );
        }
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1406
// Size: 0x4c
function private function_5ce6b6b9de3e6cff( requestid )
{
    callbackstruct = function_8c8ae740367137ba( "ReadyToSpawn", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata );
        return;
    }
    
    function_a39e9894083f4513( requestid );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x145a
// Size: 0x68
function private function_e4fcd78809372c57( requestid, data )
{
    callbackstruct = function_8c8ae740367137ba( "FinishedSpawningBucket", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, data.var_9f82bb66fd374ef5 );
    }
    
    function_d6b83c4fb86ed414( requestid, data.aifaction );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x14ca
// Size: 0x81
function private function_13aa577f00697db2( requestid, data )
{
    assertex( isdefined( level.var_f3a4ecd257a6ca36[ requestid ] ), "<dev string:x5e>" );
    callbackstruct = function_8c8ae740367137ba( "ShouldReinforce", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        return [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, data.wavenumber );
    }
    
    assertmsg( "<dev string:xc0>" + requestid );
    return 1;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1554
// Size: 0x67
function private function_386e7fd540012e1f( requestid, data )
{
    callbackstruct = function_8c8ae740367137ba( "SpawnReinforcements", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        return [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, data.wavenumber );
    }
    
    assertmsg( "<dev string:x10a>" + requestid );
    return 1;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x15c4
// Size: 0x89
function private function_8516dd2443304f7d( requestid )
{
    level notify( "ai_encounter_floodfill_shutdown_thread_" + requestid );
    level endon( "ai_encounter_floodfill_shutdown_thread_" + requestid );
    level endon( "ai_encounter_shutdown_" + requestid );
    
    while ( true )
    {
        callbackstruct = function_8c8ae740367137ba( "ShouldShutdownFloodFill", requestid );
        
        if ( isdefined( callbackstruct ) )
        {
            if ( [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata ) )
            {
                break;
            }
        }
        else
        {
            assertmsg( "<dev string:x14a>" + requestid );
            break;
        }
        
        waitframe();
    }
    
    function_776bdb2810e99635( requestid );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1655
// Size: 0x15
function private function_ecf64a7ab670fff0( requestid )
{
    level thread function_8516dd2443304f7d( requestid );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1672
// Size: 0xc5
function private function_9abe578fe2af1212( requestid )
{
    level notify( "ai_encounter_floodfill_spawn_thread_" + requestid );
    level endon( "ai_encounter_floodfill_spawn_thread_" + requestid );
    level endon( "ai_encounter_shutdown_" + requestid );
    
    while ( true )
    {
        callbackstruct = function_8c8ae740367137ba( "ShouldSpawnFloodFill", requestid );
        
        if ( isdefined( callbackstruct ) )
        {
            /#
                requestinfo = function_9a39e23c3c52c2af( requestid );
                assert( requestinfo.status == 1 || requestinfo.status == 6 );
            #/
            
            if ( [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata ) )
            {
                break;
            }
        }
        else
        {
            assertmsg( "<dev string:x190>" + requestid );
            break;
        }
        
        waitframe();
    }
    
    function_6f642674e19ebc2a( requestid );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x173f
// Size: 0x2e
function private function_d3ba5d80eea20f95( requestid, ready )
{
    if ( ready )
    {
        level thread function_9abe578fe2af1212( requestid );
        return;
    }
    
    level notify( "ai_encounter_floodfill_spawn_thread_" + requestid );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x1775
// Size: 0x2a
function function_3248cab79849207( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "Shutdown", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x17a7
// Size: 0x2a
function function_bc5315dc37ae4cf( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "ShouldSpawnFloodFill", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x17d9
// Size: 0x2a
function function_73147cdf5c28d10c( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "ShouldShutdownFloodFill", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x180b
// Size: 0xb4
function private function_9c54bda96991b25c( requestid, data )
{
    callbackstruct = function_8c8ae740367137ba( "Shutdown", requestid );
    
    if ( istrue( data.iscomplete ) )
    {
        level.var_f3a4ecd257a6ca36[ requestid ] = undefined;
        
        if ( istrue( data.var_6f81756d42f8195 ) )
        {
            level.var_f3a4ecd257a6ca36[ requestid ] = [];
        }
        
        if ( isdefined( level.var_ec14cbfd51136cd4[ requestid ] ) )
        {
            level.var_ec14cbfd51136cd4[ requestid ] = undefined;
        }
    }
    
    if ( isdefined( callbackstruct ) )
    {
        thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata );
    }
    
    if ( istrue( data.iscomplete ) )
    {
        level notify( "ai_encounter_shutdown_" + requestid );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x18c7
// Size: 0xbb
function private function_e0d368c66df8c67( requestid, data )
{
    if ( getdvarint( @"hash_5f66eab541a1a1b4", 0 ) == 1 )
    {
        foreach ( guy in data )
        {
            assert( !istrue( guy.var_f6d0fd2d574e820c ) );
            guy.var_f6d0fd2d574e820c = 1;
            level.var_817d6578a64e573a = array_add( level.var_817d6578a64e573a, guy );
        }
    }
    
    level notify( "ai_encounter_despawning_" + requestid );
    level notify( "ai_spawn_director_despawn_ai" );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x198a
// Size: 0x98
function private function_241474007dc5c94a()
{
    while ( true )
    {
        level waittill( "ai_spawn_director_despawn_ai" );
        despawncount = 0;
        
        while ( level.var_817d6578a64e573a.size > 0 )
        {
            guy = level.var_817d6578a64e573a[ 0 ];
            level.var_817d6578a64e573a = array_remove_index( level.var_817d6578a64e573a, 0 );
            
            if ( isalive( guy ) )
            {
                guy thread function_57d486c472b67a38( guy.directorrequestid );
                despawncount++;
            }
            
            if ( despawncount >= getdvarint( @"hash_54dc66a37e679beb", 5 ) )
            {
                despawncount = 0;
                waitframe();
            }
        }
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1a2a
// Size: 0x143
function private function_cf12cd77ab7cdc78( callbackname, requestid, data )
{
    switch ( callbackname )
    {
        case #"hash_9e98220b6f353a3f":
            return function_eea40a1b6180f90a( requestid, data );
        case #"hash_58235f15856f6160":
            data function_940ac86068aa76eb();
            return;
        case #"hash_d88f6ad5755dfe30":
        case #"hash_eb099bd287e41597":
            function_5ce6b6b9de3e6cff( requestid );
            break;
        case #"hash_b9a32efd84fd32d0":
            function_e4fcd78809372c57( requestid, data );
            break;
        case #"hash_9667ea6cd44b8ec8":
            return function_13aa577f00697db2( requestid, data );
        case #"hash_d255c0e81e69573b":
            function_386e7fd540012e1f( requestid, data );
            break;
        case #"hash_95c6a6d49e8ed085":
            function_d3ba5d80eea20f95( requestid, data );
            break;
        case #"hash_79765d0de58f935c":
            function_ecf64a7ab670fff0( requestid );
            break;
        case #"hash_45fc965fd1793461":
            function_e0d368c66df8c67( requestid, data );
            break;
        case #"hash_d432f1ec297228ab":
            function_9c54bda96991b25c( requestid, data );
            break;
        case #"hash_f955cea142173b3d":
            function_af598d8abc9720f0( requestid );
            break;
        case #"hash_7c1d8e0a9e3c904f":
            function_4d45fa39ae828d50( requestid );
            break;
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x1b75
// Size: 0x2a
function function_ac1550e1d32916bb( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "Restored", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1ba7
// Size: 0x43
function private function_4d45fa39ae828d50( requestid )
{
    callbackstruct = function_8c8ae740367137ba( "Restored", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1bf2
// Size: 0xcd
function private function_af598d8abc9720f0( zoneindex )
{
    subzones = function_77d0cd5fdd5e6ba7( zoneindex );
    
    foreach ( subzone in subzones )
    {
        checkpoint = subzone.midpoint + ( 0, 0, 100 );
        
        if ( isdefined( level.var_8241e0d86017df29 ) )
        {
            difficulty = [[ level.var_8241e0d86017df29 ]]( checkpoint );
        }
        else
        {
            difficulty = "difficulty_easy";
        }
        
        function_7aea2e7a0f6e31d7( zoneindex, subzone.subzoneindex, difficulty, level.outofboundstriggers );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1cc7
// Size: 0x94
function private function_42d34b1d7f4a3f2d( callbackname, requestid, fncallback, userdata )
{
    if ( !isdefined( requestid ) || !isdefined( level.var_f3a4ecd257a6ca36[ requestid ] ) )
    {
        assertmsg( "<dev string:x1d3>" + callbackname );
        return;
    }
    
    if ( isdefined( fncallback ) )
    {
        level.var_f3a4ecd257a6ca36[ requestid ][ callbackname ] = spawnstruct();
        level.var_f3a4ecd257a6ca36[ requestid ][ callbackname ].fncallback = fncallback;
        level.var_f3a4ecd257a6ca36[ requestid ][ callbackname ].userdata = userdata;
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1d63
// Size: 0x43
function private function_8c8ae740367137ba( callbackname, requestid )
{
    if ( isdefined( level.var_f3a4ecd257a6ca36[ requestid ] ) && isdefined( level.var_f3a4ecd257a6ca36[ requestid ][ callbackname ] ) )
    {
        return level.var_f3a4ecd257a6ca36[ requestid ][ callbackname ];
    }
    
    return undefined;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1
// Checksum 0x0, Offset: 0x1daf
// Size: 0x78
function function_930897c0d1a7eb24( targetname )
{
    assertex( getdvarint( @"hash_2e4907ccd20a8761", 0 ) == 1, "<dev string:x21e>" );
    assertex( isdefined( level.var_3ae5f7de11d142f ), "<dev string:x26e>" );
    requestid = function_941528a2553e5d82( targetname );
    
    if ( isdefined( requestid ) && !isdefined( level.var_f3a4ecd257a6ca36[ requestid ] ) )
    {
        level.var_f3a4ecd257a6ca36[ requestid ] = [];
    }
    
    return requestid;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1
// Checksum 0x0, Offset: 0x1e30
// Size: 0xba
function function_1ceed24d075a0981( targetname )
{
    assertex( getdvarint( @"hash_2e4907ccd20a8761", 0 ) == 1, "<dev string:x21e>" );
    assertex( isdefined( level.var_3ae5f7de11d142f ), "<dev string:x26e>" );
    requestids = function_567f58cf5188db4a( targetname );
    
    foreach ( requestid in requestids )
    {
        if ( isdefined( requestid ) && !isdefined( level.var_f3a4ecd257a6ca36[ requestid ] ) )
        {
            level.var_f3a4ecd257a6ca36[ requestid ] = [];
        }
    }
    
    return requestids;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1
// Checksum 0x0, Offset: 0x1ef3
// Size: 0x2f
function function_e4a440552e4cf1f4( fncallback )
{
    assert( isdefined( fncallback ) );
    level.var_49918a00761930d4 = function_6d6af8144a5131f1( level.var_49918a00761930d4, fncallback );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1
// Checksum 0x0, Offset: 0x1f2a
// Size: 0x2f
function function_3b0c50c1a94a9d77( fncallback )
{
    assert( isdefined( fncallback ) );
    level.var_49918a00761930d4 = array_remove( level.var_49918a00761930d4, fncallback );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x1f61
// Size: 0x2a
function function_f0cc0f2e6e1d085e( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "ReadyToSpawn", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x1f93
// Size: 0x2a
function function_e4a67fe4ddca7ed5( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "OnSpawned", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x1fc5
// Size: 0x2a
function function_9aa732b22b08a6dc( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "OnVehicleSpawned", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x1ff7
// Size: 0x2a
function function_11f03fd3165d148f( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "OnUnloaded", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x2029
// Size: 0x2a
function function_7a2920be35f4386( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "ShouldReinforce", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x205b
// Size: 0x2a
function function_6e43cc397b953a97( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "SpawnReinforcements", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3
// Checksum 0x0, Offset: 0x208d
// Size: 0x2a
function function_f81b7c3f18ef98be( requestid, fncallback, userdata )
{
    function_42d34b1d7f4a3f2d( "FinishedSpawningBucket", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 6
// Checksum 0x0, Offset: 0x20bf
// Size: 0x96
function spawn_request( encounterbundlename, origin, radius, enabled, readytospawn, isambient )
{
    assert( level.var_4fe0c43951f6ce37 );
    assertex( isdefined( getscriptbundle( encounterbundlename ) ), "<dev string:x2c3>" + getxhashsourcename( encounterbundlename ) );
    
    if ( !isdefined( isambient ) )
    {
        isambient = 0;
    }
    
    requestid = aispawndirectorspawnrequest( encounterbundlename, origin, radius, enabled, readytospawn, isambient );
    
    if ( isdefined( requestid ) )
    {
        level.var_f3a4ecd257a6ca36[ requestid ] = [];
    }
    
    return requestid;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2
// Checksum 0x0, Offset: 0x215e
// Size: 0x2d
function function_9950e6e485bf5261( requestid, shouldrespawn )
{
    assert( level.var_4fe0c43951f6ce37 );
    function_22993fe73b6d16f4( requestid, shouldrespawn );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2
// Checksum 0x0, Offset: 0x2193
// Size: 0x2d
function function_f8c9e05192380dab( requestid, prioritylevel )
{
    assert( level.var_4fe0c43951f6ce37 );
    function_772b9990dd5ce643( requestid, prioritylevel );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1
// Checksum 0x0, Offset: 0x21c8
// Size: 0x4b
function function_d1403c6bc24e9f90( createscriptflag )
{
    if ( !isdefined( level.var_15808c6e81c877bb ) )
    {
        level.var_15808c6e81c877bb = [];
    }
    
    numflags = level.var_15808c6e81c877bb.size;
    level.var_15808c6e81c877bb[ numflags ] = createscriptflag + "_completed";
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0
// Checksum 0x0, Offset: 0x221b
// Size: 0x66a
function process_create_script()
{
    if ( isdefined( level.var_15808c6e81c877bb ) )
    {
        foreach ( createscriptflag in level.var_15808c6e81c877bb )
        {
            flag_wait( createscriptflag );
        }
        
        level.var_15808c6e81c877bb = [];
    }
    
    interactions = getstructarray( "info_act", "script_noteworthy" );
    interactionlist = [];
    
    foreach ( interaction in interactions )
    {
        if ( !isdefined( interaction.ai_interaction ) )
        {
            continue;
        }
        
        interactionid = spawninteraction( interaction.ai_interaction, interaction.origin, interaction.angles );
        
        if ( isdefined( interaction.targetname ) )
        {
            interactionlist[ interaction.targetname ] = interactionid;
        }
        
        function_c300d48d8ca0ef3e( interactionid, interaction.origin );
    }
    
    patrolpoints = getstructarray( "ai_encounter_patrol_point", "script_noteworthy" );
    
    foreach ( point in patrolpoints )
    {
        if ( isdefined( point.move_speed ) )
        {
            point.move_speed = float( point.move_speed );
        }
        
        if ( isdefined( point.var_acaed5eee748b3f ) )
        {
            point.var_acaed5eee748b3f = float( point.var_acaed5eee748b3f );
        }
        
        if ( isdefined( point.max_wait_time ) )
        {
            point.max_wait_time = float( point.max_wait_time );
        }
        
        point.start_point = isdefined( point.start_point ) && point.start_point == "1";
        point.reverse_route = isdefined( point.reverse_route ) && point.reverse_route == "1";
        point.loop_route = isdefined( point.loop_route ) && point.loop_route == "1";
        
        if ( isdefined( point.var_8e71cc2e3851e67c ) && isdefined( interactionlist[ point.var_8e71cc2e3851e67c ] ) )
        {
            point.var_8e71cc2e3851e67c = interactionlist[ point.var_8e71cc2e3851e67c ];
        }
        else
        {
            point.var_8e71cc2e3851e67c = undefined;
        }
        
        if ( isdefined( point.var_912df596f9f4417f ) )
        {
            point.var_912df596f9f4417f = int( point.var_912df596f9f4417f );
        }
        
        function_e90fe6b075bfaa6d( point );
    }
    
    parachutestartpoints = getstructarray( "ai_encounter_parachute_start", "script_noteworthy" );
    spawnpoints = getstructarray( "ai_encounter_spawnpoint", "script_noteworthy" );
    
    foreach ( point in spawnpoints )
    {
        if ( isdefined( point.var_e5decd57d2e1579 ) )
        {
            point.var_e5decd57d2e1579 = float( point.var_e5decd57d2e1579 );
        }
        else
        {
            point.var_e5decd57d2e1579 = 5000;
        }
        
        point.preferred_spawnpoint = isdefined( point.preferred_spawnpoint ) && point.preferred_spawnpoint == "1";
        point.reinforcement_spawn = isdefined( point.reinforcement_spawn ) && point.reinforcement_spawn == "1";
        point.location_spawnpoint = isdefined( point.location_spawnpoint ) && point.location_spawnpoint == "1";
        
        if ( isdefined( point.script_stealthgroup ) && point.script_stealthgroup == "-1" )
        {
            point.script_stealthgroup = undefined;
        }
        
        point.var_f0b3e079ef68d755 = isdefined( point.var_f0b3e079ef68d755 ) && point.var_f0b3e079ef68d755 == "1";
        
        if ( point.var_f0b3e079ef68d755 && isdefined( point.targetname ) )
        {
            foreach ( parachutepoint in parachutestartpoints )
            {
                if ( isdefined( parachutepoint.target ) && parachutepoint.target == point.targetname )
                {
                    point.var_35b7f8cbbef2653a = ( parachutepoint.origin[ 0 ], parachutepoint.origin[ 1 ], parachutepoint.origin[ 2 ] + point.var_e5decd57d2e1579 );
                }
            }
        }
        
        if ( isdefined( point.var_8e71cc2e3851e67c ) && isdefined( interactionlist[ point.var_8e71cc2e3851e67c ] ) )
        {
            point.var_8e71cc2e3851e67c = interactionlist[ point.var_8e71cc2e3851e67c ];
        }
        else
        {
            point.var_8e71cc2e3851e67c = undefined;
        }
        
        function_ff46e79c8c7a21c8( point );
    }
    
    if ( getdvarint( @"hash_6c2c138ca17a4631", 1 ) == 1 )
    {
        thread function_ee6aae70a767d1ea();
    }
    
    if ( getdvarint( @"hash_2f3e35c3ad3a0cf7", 0 ) )
    {
        thread function_7d9366588f25dd69();
    }
    else
    {
        function_9b8829ab4092a7d7( "ob_zombie_encounter_dense", 1 );
    }
    
    if ( getdvarint( @"hash_4ccbbd355da5f0d", 0 ) == 1 )
    {
        function_9b8829ab4092a7d7( "ob_zombie_ambient_waves", 1 );
    }
    
    if ( getdvarint( @"ai_spawn_director_dynamic_ambient_specials", 1 ) == 1 )
    {
        function_9b8829ab4092a7d7( "ai_spawn_director_dynamic_ambient_specials", 1 );
    }
    
    function_6473f11b4d8d79e0();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x288d
// Size: 0x54
function private function_ee6aae70a767d1ea()
{
    var_95ef962d90c4d920 = getdvarint( @"hash_59839a5de33b3ef6", 50 );
    function_57345744ffb049e9( "script_noteworthy", "ai_encounter_patrol_point", var_95ef962d90c4d920 );
    function_57345744ffb049e9( "script_noteworthy", "ai_encounter_parachute_start", var_95ef962d90c4d920 );
    function_57345744ffb049e9( "script_noteworthy", "ai_encounter_spawnpoint", var_95ef962d90c4d920 );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x28e9
// Size: 0x17e
function private function_57345744ffb049e9( type, typevalue, var_98cfcdbee7100d1 )
{
    waitframe();
    structs = level.struct_class_names[ type ][ typevalue ];
    
    if ( !isdefined( structs ) || !isarray( structs ) )
    {
        return;
    }
    
    var_ddde51424987b5fc = 0;
    
    foreach ( struct in structs )
    {
        if ( isdefined( struct.targetname ) )
        {
            level.struct_class_names[ "targetname" ][ struct.targetname ] = [];
        }
        
        if ( isdefined( struct.target ) )
        {
            level.struct_class_names[ "target" ][ struct.target ] = [];
        }
        
        if ( isdefined( struct.script_noteworthy ) )
        {
            level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] = [];
        }
        
        if ( isdefined( struct.script_linkname ) )
        {
            level.struct_class_names[ "script_linkname" ][ struct.script_linkname ] = [];
        }
        
        if ( isdefined( struct.variantname ) )
        {
            level.struct_class_names[ "variantname" ][ struct.variantname ] = [];
        }
        
        var_ddde51424987b5fc++;
        
        if ( var_ddde51424987b5fc >= var_98cfcdbee7100d1 )
        {
            waitframe();
            var_ddde51424987b5fc = 0;
        }
    }
}

/#

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x2a6f
    // Size: 0xa5c, Type: dev
    function private function_8f2b1c474a144a75()
    {
        wait 3;
        function_c5b8afd6e0f364ee( "<dev string:x2eb>", "<dev string:x2fb>" );
        waitframe();
        function_c5b8afd6e0f364ee( "<dev string:x31d>", "<dev string:x338>" );
        waitframe();
        adddebugcommand( "<dev string:x35c>" );
        waitframe();
        adddebugcommand( "<dev string:x3b2>" );
        waitframe();
        adddebugcommand( "<dev string:x407>" );
        waitframe();
        adddebugcommand( "<dev string:x478>" );
        waitframe();
        adddebugcommand( "<dev string:x4eb>" );
        waitframe();
        adddebugcommand( "<dev string:x555>" );
        waitframe();
        adddebugcommand( "<dev string:x5c0>" );
        waitframe();
        adddebugcommand( "<dev string:x621>" );
        waitframe();
        adddebugcommand( "<dev string:x67f>" );
        waitframe();
        test_names = [ [ "<dev string:x6d9>", "<dev string:x6e3>", "<dev string:x6f6>" ], [ "<dev string:x6d9>", "<dev string:x700>", "<dev string:x710>" ], [ "<dev string:x6d9>", "<dev string:x722>", "<dev string:x732>" ], [ "<dev string:x6d9>", "<dev string:x743>", "<dev string:x750>" ], [ "<dev string:x6d9>", "<dev string:x769>", "<dev string:x770>" ], [ "<dev string:x77e>", "<dev string:x6e3>", "<dev string:x78d>" ], [ "<dev string:x77e>", "<dev string:x700>", "<dev string:x79c>" ], [ "<dev string:x77e>", "<dev string:x722>", "<dev string:x7b3>" ], [ "<dev string:x77e>", "<dev string:x743>", "<dev string:x7c9>" ], [ "<dev string:x77e>", "<dev string:x769>", "<dev string:x7e7>" ], [ "<dev string:x7fa>", "<dev string:x6e3>", "<dev string:x803>" ], [ "<dev string:x7fa>", "<dev string:x700>", "<dev string:x80c>" ], [ "<dev string:x7fa>", "<dev string:x722>", "<dev string:x81d>" ], [ "<dev string:x7fa>", "<dev string:x743>", "<dev string:x82d>" ], [ "<dev string:x7fa>", "<dev string:x769>", "<dev string:x845>" ], [ "<dev string:x769>", "<dev string:x6e3>", "<dev string:x852>" ], [ "<dev string:x769>", "<dev string:x700>", "<dev string:x86e>" ], [ "<dev string:x769>", "<dev string:x722>", "<dev string:x892>" ], [ "<dev string:x769>", "<dev string:x743>", "<dev string:x8b5>" ], [ "<dev string:x769>", "<dev string:x769>", "<dev string:x8e0>" ] ];
        
        foreach ( test_name in test_names )
        {
            commandstring = "<dev string:x900>" + test_name[ 0 ] + "<dev string:x93d>" + test_name[ 1 ] + "<dev string:x944>" + test_name[ 2 ] + "<dev string:x978>";
            adddebugcommand( commandstring );
        }
        
        activerequests = [];
        
        while ( true )
        {
            if ( getdvarint( @"hash_c2967f1425f47dcf", 0 ) == 1 )
            {
                foreach ( requestid in activerequests )
                {
                    function_9950e6e485bf5261( requestid );
                }
                
                activerequests = [];
                setdvar( @"hash_c2967f1425f47dcf", 0 );
            }
            
            bundlename = getdvar( @"hash_338fd6962a58ef94", "<dev string:x97e>" );
            
            if ( isdefined( bundlename ) && bundlename != "<dev string:x97e>" && isalive( level.players[ 0 ] ) )
            {
                fullbundlename = hashcat( %"ai_encounter:", bundlename );
                requestid = spawn_request( fullbundlename, level.players[ 0 ].origin, 1000, 1, 1 );
                activerequests = array_add( activerequests, requestid );
            }
            
            setdvar( @"hash_338fd6962a58ef94", "<dev string:x97e>" );
            bundlename = getdvar( @"hash_92614d6e09af2f0", "<dev string:x97e>" );
            
            if ( isdefined( bundlename ) && bundlename != "<dev string:x97e>" && isalive( level.players[ 0 ] ) )
            {
                fullbundlename = hashcat( %"ai_flood_fill_encounter:", bundlename );
                requestid = spawn_request( fullbundlename, level.players[ 0 ].origin, 1000, 1, 1 );
                activerequests = array_add( activerequests, requestid );
            }
            
            setdvar( @"hash_92614d6e09af2f0", "<dev string:x97e>" );
            tagname = getdvar( @"hash_cb77d3c82e353f1d", "<dev string:x97e>" );
            
            if ( isdefined( tagname ) && tagname != "<dev string:x97e>" )
            {
                function_9b8829ab4092a7d7( tagname, 1 );
                setdvar( @"hash_cb77d3c82e353f1d", "<dev string:x97e>" );
            }
            
            tagname = getdvar( @"hash_648b265962adac34", "<dev string:x97e>" );
            
            if ( isdefined( tagname ) && tagname != "<dev string:x97e>" )
            {
                function_9b8829ab4092a7d7( tagname, 0 );
                setdvar( @"hash_648b265962adac34", "<dev string:x97e>" );
            }
            
            if ( getdvarint( @"hash_7560a9c3d8fb8030", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    function_606642b946a01237( "<dev string:x982>", level.players[ 0 ].origin, 2000 );
                }
                
                setdvar( @"hash_7560a9c3d8fb8030", 0 );
            }
            
            if ( getdvarint( @"hash_a9bfe570a4470e77", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    function_c7311cb3f768f21e( "<dev string:x982>" );
                }
                
                setdvar( @"hash_a9bfe570a4470e77", 0 );
            }
            
            if ( getdvarint( @"hash_b887180c55479401", 0 ) == 1 )
            {
                converted = 0;
                encounters = function_46ded7ce925b0c64( 0, 1 );
                
                foreach ( encounter in encounters )
                {
                    data = function_9a39e23c3c52c2af( encounter );
                    
                    if ( data.status != 1 )
                    {
                        function_2169641d6a403864( encounter );
                        iprintlnbold( "<dev string:x994>" + encounter + "<dev string:x9ad>" );
                    }
                }
                
                if ( !converted )
                {
                    iprintlnbold( "<dev string:x9bd>" );
                }
                
                setdvar( @"hash_b887180c55479401", 0 );
            }
            
            if ( getdvarint( @"hash_5052dcf9e0cb4ce1", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    zoneindex = function_b439f805f07ff50( level.players[ 0 ].origin );
                    function_df12bc7ed6efed1f( zoneindex );
                }
                
                setdvar( @"hash_5052dcf9e0cb4ce1", 0 );
            }
            
            if ( getdvarint( @"hash_e1ca0daaa71ada82", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    subzone = function_2ee25a0fa15c04ce( level.players[ 0 ].origin );
                    
                    if ( isdefined( subzone ) )
                    {
                        function_1d5039979534caef( subzone.zoneindex, subzone.subzoneindex, !subzone.enabled );
                    }
                }
                
                setdvar( @"hash_e1ca0daaa71ada82", 0 );
            }
            
            settag = getdvar( @"hash_6c37cbeecb7d7215", "<dev string:x97e>" );
            
            if ( isdefined( settag ) && settag != "<dev string:x97e>" )
            {
                subzone = function_2ee25a0fa15c04ce( level.players[ 0 ].origin );
                
                if ( isdefined( subzone ) )
                {
                    function_811e2ea8528614ba( subzone.zoneindex, subzone.subzoneindex, settag, 1 );
                }
                
                setdvar( @"hash_6c37cbeecb7d7215", "<dev string:x97e>" );
            }
            
            cleartag = getdvar( @"hash_226b7063f48ab77a", "<dev string:x97e>" );
            
            if ( isdefined( cleartag ) && cleartag != "<dev string:x97e>" )
            {
                subzone = function_2ee25a0fa15c04ce( level.players[ 0 ].origin );
                
                if ( isdefined( subzone ) )
                {
                    function_811e2ea8528614ba( subzone.zoneindex, subzone.subzoneindex, cleartag, 0 );
                }
                
                setdvar( @"hash_226b7063f48ab77a", "<dev string:x97e>" );
            }
            
            test_name = getdvar( @"hash_25688c988df289c3", "<dev string:x97e>" );
            
            if ( test_name != "<dev string:x97e>" )
            {
                thread function_697246e491b82b( test_name );
                setdvar( @"hash_25688c988df289c3", "<dev string:x97e>" );
            }
            
            var_90284334e00894ac = getdvar( @"hash_76a02dcfeaf85e8a", "<dev string:x97e>" );
            
            if ( var_90284334e00894ac != "<dev string:x97e>" )
            {
                thread function_b6206c1c64860991( var_90284334e00894ac );
                setdvar( @"hash_76a02dcfeaf85e8a", "<dev string:x97e>" );
            }
            
            if ( getdvarint( @"hash_b8cb86dbb04715e2", 0 ) == 1 )
            {
                function_9b8829ab4092a7d7( "<dev string:x9e5>", 1 );
                function_9b8829ab4092a7d7( "<dev string:x9fa>", 0 );
                setdvar( @"hash_19f0eb1fd6a2f87d", 1 );
                setdvar( @"hash_b8cb86dbb04715e2", 0 );
            }
            
            if ( getdvarint( @"hash_48e36b0fa33ce48f", 0 ) == 1 )
            {
                function_9b8829ab4092a7d7( "<dev string:x9e5>", 0 );
                function_9b8829ab4092a7d7( "<dev string:x9fa>", 1 );
                setdvar( @"hash_19f0eb1fd6a2f87d", 1 );
                setdvar( @"hash_48e36b0fa33ce48f", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x34d3
    // Size: 0x54, Type: dev
    function private function_c4ab5ef0be46aef4()
    {
        debug_diff = getdvarint( @"hash_37edd5a66bd29f3d", 0 );
        
        while ( true )
        {
            wait 2;
            new_diff = getdvarint( @"hash_37edd5a66bd29f3d", 0 );
            
            if ( new_diff != debug_diff )
            {
                debug_diff = new_diff;
                function_ed0e325da04fc842();
            }
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x352f
    // Size: 0xd9, Type: dev
    function private function_c5b8afd6e0f364ee( var_2cd4ce4a1e0c3ad9, dvarname )
    {
        bundlenames = getscriptbundlenames( var_2cd4ce4a1e0c3ad9 );
        
        foreach ( bundlename in bundlenames )
        {
            bundlenamestring = getxhashsourcename( bundlename );
            array = strtok( bundlenamestring, "<dev string:xa0e>" );
            
            if ( !isdefined( array ) || !isdefined( array[ 1 ] ) )
            {
                continue;
            }
            
            cmdstring = "<dev string:xa13>" + array[ 1 ] + "<dev string:xa3f>" + dvarname + "<dev string:xa4a>" + array[ 1 ] + "<dev string:x978>";
            adddebugcommand( cmdstring );
            waitframe();
        }
    }

#/

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2
// Checksum 0x0, Offset: 0x3610
// Size: 0x27
function function_9711795c6c786e25( tuning_prefix, encounter_prefix )
{
    level.var_cc820bcf92b48c63 = tuning_prefix;
    level.var_286c41fbbcdf9443 = encounter_prefix;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x363f
// Size: 0x32a
function private function_7d9366588f25dd69()
{
    flag_wait( "ai_spawn_director_initialized" );
    waitframe();
    biome_structs = getstructarray( "ai_biome_struct", "targetname" );
    
    if ( !isdefined( level.var_cc820bcf92b48c63 ) )
    {
        level.var_cc820bcf92b48c63 = "";
    }
    
    if ( !isdefined( level.var_286c41fbbcdf9443 ) )
    {
        level.var_286c41fbbcdf9443 = "";
    }
    
    zones = function_5f65de24f04894e5();
    
    foreach ( biome in biome_structs )
    {
        if ( isdefined( biome.radius ) && isdefined( biome.script_noteworthy ) )
        {
            var_8c191d2295692b81 = function_edaf361096c5af0c( biome.origin, biome.radius );
            
            foreach ( zone in var_8c191d2295692b81 )
            {
                function_17ab0ca84f195c18( zone.zoneindex, level.var_cc820bcf92b48c63 + biome.script_noteworthy, 1 );
            }
            
            var_962cdfb453fc2a21 = function_6aa08c3e29cd1452( biome.origin, biome.radius );
            
            foreach ( subzone in var_962cdfb453fc2a21 )
            {
                function_811e2ea8528614ba( subzone.zoneindex, subzone.subzoneindex, level.var_286c41fbbcdf9443 + biome.script_noteworthy, 1 );
            }
        }
    }
    
    foreach ( zone in zones )
    {
        if ( !function_e099a75eb1edfe00( zone.zoneindex, level.var_cc820bcf92b48c63 + "dense" ) )
        {
            function_17ab0ca84f195c18( zone.zoneindex, level.var_cc820bcf92b48c63 + "light", 1 );
        }
        
        var_f5b3d155392eb79 = function_77d0cd5fdd5e6ba7( zone.zoneindex );
        
        foreach ( subzone in var_f5b3d155392eb79 )
        {
            if ( !function_3f99c64efa5996b2( subzone.zoneindex, subzone.subzoneindex, level.var_286c41fbbcdf9443 + "dense" ) )
            {
                function_811e2ea8528614ba( subzone.zoneindex, subzone.subzoneindex, level.var_286c41fbbcdf9443 + "light", 1 );
            }
        }
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1
// Checksum 0x0, Offset: 0x3971
// Size: 0x175
function function_ed0e325da04fc842( params )
{
    flag_wait( "ai_spawn_director_initialized" );
    
    if ( isdefined( level.var_8241e0d86017df29 ) )
    {
        zones = function_5f65de24f04894e5();
        
        foreach ( zone in zones )
        {
            checkpoint = zone.midpoint + ( 0, 0, 100 );
            difficulty = [[ level.var_8241e0d86017df29 ]]( checkpoint );
            function_83f909d5406f69( zone.zoneindex, difficulty );
            
            if ( getdvarint( @"hash_3e3abf5eda87eba6", 0 ) == 1 )
            {
                assert( isdefined( level.var_c092c207acdfa48 ) );
                region = [[ level.var_c092c207acdfa48 ]]( checkpoint );
                
                if ( isdefined( region ) )
                {
                    function_17ab0ca84f195c18( zone.zoneindex, region, 1 );
                }
            }
        }
        
        return;
    }
    
    zones = function_5f65de24f04894e5();
    
    foreach ( zone in zones )
    {
        function_83f909d5406f69( zone.zoneindex, "difficulty_easy" );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3aee
// Size: 0x34
function private function_fd97a081c69bff85()
{
    if ( getdvarint( @"hash_72e4d77ae8f73875", 0 ) == 1 && isdefined( level.outofboundstriggers ) )
    {
        function_861eb379dee38144( level.outofboundstriggers );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3b2a
// Size: 0xab
function private function_eae524b041923b20()
{
    wait 1;
    
    while ( true )
    {
        settag = getdvar( @"hash_c1b168fb1d959c2f", "" );
        
        if ( isdefined( settag ) && settag != "" )
        {
            function_9b8829ab4092a7d7( settag, 1 );
            setdvar( @"hash_c1b168fb1d959c2f", "" );
        }
        
        cleartag = getdvar( @"hash_91f3192aa5d2ec6c", "" );
        
        if ( isdefined( cleartag ) && cleartag != "" )
        {
            function_9b8829ab4092a7d7( cleartag, 0 );
            setdvar( @"hash_91f3192aa5d2ec6c", "" );
        }
        
        wait 1;
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3bdd
// Size: 0x114
function private function_c7864239c3106370()
{
    if ( isdefined( level.var_3ae5f7de11d142f ) )
    {
        return;
    }
    
    assertex( getdvarint( @"hash_2e4907ccd20a8761", 0 ) == 1, "<dev string:x21e>" );
    level.var_3ae5f7de11d142f = &function_cf12cd77ab7cdc78;
    level.var_4fe0c43951f6ce37 = getdvarint( @"hash_2e4907ccd20a8761", 0 );
    level.var_f3a4ecd257a6ca36 = [];
    level.aipatrolpaths = [];
    
    if ( !isdefined( level.var_49918a00761930d4 ) )
    {
        level.var_49918a00761930d4 = [];
    }
    
    level.var_8cd784cab6ecbb43 = [];
    level.var_817d6578a64e573a = [];
    level.var_ec14cbfd51136cd4 = [];
    level callback::add( "region_difficulties_registered", &function_ed0e325da04fc842 );
    thread function_241474007dc5c94a();
    thread function_eae524b041923b20();
    thread function_ed0e325da04fc842();
    function_fd97a081c69bff85();
    scripts\cp_mp\vehicles\vehicle_anim::init_vehicles();
    
    /#
        if ( getdvarint( @"hash_c86f4f2f2cea3cdc", 1 ) == 1 )
        {
            level thread function_8f2b1c474a144a75();
        }
        
        level thread function_c4ab5ef0be46aef4();
    #/
    
    function_cf029a96f28eb230();
    flag_set( "ai_spawn_director_initialized" );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0
// Checksum 0x0, Offset: 0x3cf9
// Size: 0xa
function director_init()
{
    thread function_c7864239c3106370();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3d0b
// Size: 0x1c0
function private _wander( agent, radius, radiusvariance, origin )
{
    savedorigin = origin;
    
    if ( isagent( agent ) && !isdefined( origin ) )
    {
        savedorigin = agent.origin;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 100;
    }
    
    if ( !isdefined( radiusvariance ) || radiusvariance <= 0 )
    {
        radiusvariance = 50;
    }
    
    agent endon( "death" );
    agent endon( "stealth_investigate" );
    agent endon( "stealth_hunt" );
    agent endon( "stealth_combat" );
    agent endon( "startCombatRush" );
    wait 1;
    
    if ( isdefined( origin ) && distance2dsquared( origin, agent.origin ) > 4096 )
    {
        _setgoalpos( origin, 32, 1 );
        agent waittill( "goal" );
    }
    
    originalorigin = agent.origin;
    min = radius - radiusvariance;
    max = radius + radiusvariance;
    
    while ( true )
    {
        random_x = randomfloatrange( min, max ) * scripts\engine\utility::ter_op( randomint( 100 ) > 50, 1, -1 );
        random_y = randomfloatrange( min, max ) * scripts\engine\utility::ter_op( randomint( 100 ) > 50, 1, -1 );
        var_b30a6c38cd4fe517 = ( originalorigin[ 0 ] + random_x, originalorigin[ 1 ] + random_y, originalorigin[ 2 ] );
        
        if ( distance2d( agent.origin, var_b30a6c38cd4fe517 ) > 20 )
        {
            agent _setgoalpos( var_b30a6c38cd4fe517, 8 );
            agent thread function_d3ef6a4415f8a5e4( agent );
            agent waittill_any_2( "goal", "refreshGoalPos" );
        }
        
        wait randomfloatrange( 4.5, 5.5 );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3ed3
// Size: 0xb4
function private _setgoalpos( origin, goalradius, var_1b6352ceb9bbc1d, bunbounded )
{
    if ( !isdefined( bunbounded ) )
    {
        bunbounded = 0;
    }
    
    if ( istrue( self.fixednode ) || !isalive( self ) )
    {
        return;
    }
    
    if ( !istrue( var_1b6352ceb9bbc1d ) )
    {
        function_c6930ac29fe6ff53( goalradius );
    }
    
    safeorigin = self getclosestreachablepointonnavmesh( origin, bunbounded );
    
    if ( !isdefined( safeorigin ) )
    {
        println( "<dev string:xa4f>" + origin );
        return;
    }
    
    if ( !isdefined( self.origin ) )
    {
        assertmsg( "<dev string:xa91>" );
        return;
    }
    
    if ( distance2d( self.origin, safeorigin ) > 20 )
    {
        self setgoalpos( safeorigin );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3f8f
// Size: 0x41
function private function_d3ef6a4415f8a5e4( agent, time )
{
    agent endon( "goal" );
    agent endon( "death" );
    waittime = 5;
    
    if ( isdefined( time ) )
    {
        waittime = time;
    }
    
    wait waittime;
    agent notify( "refreshGoalPos" );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3fd8
// Size: 0x30
function private function_c6930ac29fe6ff53( goalradius )
{
    if ( !isdefined( goalradius ) )
    {
        goalradius = 128;
    }
    
    self.goalradius = int( goalradius );
    self.script_goalradius = goalradius;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1
// Checksum 0x0, Offset: 0x4010
// Size: 0x19b
function function_618cf23700c29e56( path_array )
{
    if ( !isdefined( level.aipatrolpaths[ path_array[ 0 ].id ] ) )
    {
        pathstruct = spawnstruct();
        pathstruct.current_ai = [];
        pathstruct.current_ai[ pathstruct.current_ai.size ] = self;
        pathstruct.patrolpath = path_array;
        pathstruct.var_508557c68a1cdf96 = path_array[ 0 ].var_508557c68a1cdf96;
        pathstruct.var_60482e24fa2925e8 = path_array[ 0 ].var_60482e24fa2925e8;
        level.aipatrolpaths[ path_array[ 0 ].id ] = pathstruct;
        level thread function_a5c643ecfde39fa( path_array[ 0 ].id, pathstruct );
        return;
    }
    
    if ( isdefined( level.aipatrolpaths[ path_array[ 0 ].id ] ) && level.aipatrolpaths[ path_array[ 0 ].id ].current_ai.size == 0 )
    {
        patrolpath = level.aipatrolpaths[ path_array[ 0 ].id ];
        patrolpath.current_ai[ patrolpath.current_ai.size ] = self;
        level thread function_a5c643ecfde39fa( path_array[ 0 ].id, patrolpath );
        return;
    }
    
    patrolpath = level.aipatrolpaths[ path_array[ 0 ].id ];
    patrolpath.current_ai[ patrolpath.current_ai.size ] = self;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x41b3
// Size: 0x45
function private function_93ae2d91d511dad8( path_array )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stealth_investigate" );
    self endon( "stealth_hunt" );
    self endon( "stealth_combat" );
    self endon( "startCombatRush" );
    self waittill( "bseq_user_deleted" );
    function_618cf23700c29e56( path_array );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4200
// Size: 0x4f8
function private function_a5c643ecfde39fa( pathindex, pathstruct )
{
    level endon( "game_ended" );
    endon_agents = [];
    patrolpath = pathstruct.patrolpath;
    pathstruct.claimed = 1;
    index = 0;
    
    for ( forwarddirection = 1; true ; forwarddirection = 1 )
    {
        var_886dfa499937a071 = level.aipatrolpaths[ pathindex ].current_ai;
        point = patrolpath[ index ].origin;
        
        foreach ( agentindex, agent in var_886dfa499937a071 )
        {
            if ( istrue( agent.var_9accf436d7b4c4bc ) )
            {
                continue;
            }
            
            if ( !isdefined( endon_agents[ agentindex ] ) )
            {
                agent endon( "death" );
                agent endon( "stealth_investigate" );
                agent endon( "stealth_hunt" );
                agent endon( "stealth_combat" );
                agent endon( "startCombatRush" );
                endon_agents[ agentindex ] = agent;
                agent thread function_c2b8e94711be96d9( pathindex );
                agent thread function_78c1585cd1815dac();
            }
            
            if ( agentindex != 0 )
            {
                random_x = randomfloatrange( 30, 31 ) * scripts\engine\utility::ter_op( cointoss(), 1, -1 );
                random_y = randomfloatrange( 30, 31 ) * scripts\engine\utility::ter_op( cointoss(), 1, -1 );
                point = ( point[ 0 ] + random_x, point[ 1 ] + random_y, point[ 2 ] );
            }
            
            if ( isdefined( patrolpath[ index ].interaction_id ) && patrolpath[ index ].interaction_id != -1 )
            {
                if ( isdefined( patrolpath[ index ].script_delay_min ) && patrolpath[ index ].script_delay_min == patrolpath[ index ].script_delay_max )
                {
                    if ( patrolpath[ index ].script_delay_min != 0 )
                    {
                        patrolpath[ index ].script_delay = patrolpath[ index ].script_delay_min;
                    }
                    
                    patrolpath[ index ].script_delay_min = undefined;
                    patrolpath[ index ].script_delay_max = undefined;
                }
                
                agent._blackboard.idlenode = patrolpath[ index ];
                agent leaveinteraction();
                agent _setgoalpos( getinteractionorigin( patrolpath[ index ].interaction_id ), 64 );
                agent function_76b3cfb91ef40b3b( patrolpath[ index ].interaction_id );
                
                if ( isdefined( patrolpath[ index ].repeat_interaction ) && istrue( int( patrolpath[ index ].repeat_interaction ) ) )
                {
                    agent.var_9accf436d7b4c4bc = 1;
                }
            }
            else
            {
                agent leaveinteraction();
                agent _setgoalpos( point, 64 );
            }
            
            if ( istrue( patrolpath[ index ].var_60cb49eb02dc0850 ) )
            {
                agent.customarrivalangles = patrolpath[ index ].angles;
            }
            
            if ( var_886dfa499937a071.size > 1 && agentindex == 0 )
            {
                wait 3;
            }
            
            if ( var_886dfa499937a071.size > 1 && agentindex != 0 )
            {
                wait randomfloatrange( 1.5, 2.5 );
            }
        }
        
        shouldcontinue = 0;
        
        foreach ( agentindex, agent in var_886dfa499937a071 )
        {
            if ( !istrue( agent.var_9accf436d7b4c4bc ) )
            {
                shouldcontinue = 1;
                break;
            }
        }
        
        if ( !shouldcontinue )
        {
            break;
        }
        
        waitframe();
        var_886dfa499937a071[ 0 ] waittill_any_2( "goal", "bt_goal" );
        
        if ( isdefined( var_886dfa499937a071[ 0 ] getinteractionid() ) )
        {
            var_886dfa499937a071[ 0 ] waittill( "bseq_user_deleted" );
        }
        
        if ( patrolpath[ index ].var_3dc216f2a253c048 < patrolpath[ index ].var_f042ba4e1f3de84e )
        {
            wait randomfloatrange( patrolpath[ index ].var_3dc216f2a253c048, patrolpath[ index ].var_f042ba4e1f3de84e );
        }
        else
        {
            wait patrolpath[ index ].var_3dc216f2a253c048;
        }
        
        if ( forwarddirection )
        {
            index++;
        }
        else
        {
            index--;
        }
        
        foreach ( agent in var_886dfa499937a071 )
        {
            agent.customarrivalangles = undefined;
        }
        
        if ( !isdefined( patrolpath[ index ] ) )
        {
            if ( !pathstruct.var_508557c68a1cdf96 && !pathstruct.var_60482e24fa2925e8 )
            {
                break;
            }
            
            if ( pathstruct.var_60482e24fa2925e8 )
            {
                index = 0;
                continue;
            }
            
            if ( forwarddirection )
            {
                index = int( max( patrolpath.size - 2, 0 ) );
                forwarddirection = 0;
                continue;
            }
            
            index = int( min( 1, patrolpath.size - 1 ) );
        }
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4700
// Size: 0x35
function private function_78c1585cd1815dac()
{
    level endon( "game_ended" );
    self endon( "death" );
    waittill_any_4( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    self.customarrivalangles = undefined;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x473d
// Size: 0xd7
function private function_c2b8e94711be96d9( pathindex )
{
    self waittill( "death" );
    
    foreach ( agentindex, agent in level.aipatrolpaths[ pathindex ].current_ai )
    {
        if ( agent == self )
        {
            level.aipatrolpaths[ pathindex ].current_ai[ agentindex ] = undefined;
            break;
        }
    }
    
    if ( istrue( level.aipatrolpaths[ pathindex ].claimed ) && level.aipatrolpaths[ pathindex ].current_ai.size == 0 )
    {
        level.aipatrolpaths[ pathindex ].claimed = 0;
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x481c
// Size: 0x3c
function private function_57d486c472b67a38( requestid )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( self.unittype == "soldier" )
    {
        function_7737f4fab89cb380();
        return;
    }
    
    function_cdc13899cf352216();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4860
// Size: 0x17b
function private function_7737f4fab89cb380()
{
    self endon( "death" );
    assert( self.unittype == "<dev string:xacc>" );
    
    while ( !function_6183ffe70d4c7348( self ) )
    {
        var_37932bbc0e2fb65a = 0;
        
        while ( isdefined( self.enemy ) && isalive( self.enemy ) && isplayer( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) <= 262144 )
        {
            var_37932bbc0e2fb65a = 1;
            self.pathenemyfightdist = 0;
            self.pathenemylookahead = 0;
            self.var_6c18812ecbd3b6ae = 0;
            self setbtgoalradius( 2, 256 );
            self setbtgoalpos( 2, self.enemy.origin );
            wait 5;
        }
        
        if ( var_37932bbc0e2fb65a )
        {
            continue;
        }
        
        despawnpos = function_f9786c2470082369( self );
        starttime = gettime();
        
        if ( isdefined( despawnpos ) )
        {
            self setbtgoalpos( 2, despawnpos );
            self setbtgoalradius( 2, 256 );
            self waittill( "bt_goal" );
        }
        
        waittime = getdvarfloat( @"hash_273a7f3e61e64e35", 10 );
        timediffseconds = ( gettime() - starttime ) / 1000;
        
        if ( timediffseconds < waittime )
        {
            wait waittime - timediffseconds;
        }
    }
    
    function_c72639c94e050034();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x49e3
// Size: 0x43
function private function_1be071105e1ef2a3()
{
    self endon( "death" );
    despawntime = randomfloatrange( getdvarint( @"hash_96955f67517b7611", 5 ), getdvarint( @"hash_96b8716751a1e55f", 10 ) );
    wait despawntime;
    function_940ac86068aa76eb();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4a2e
// Size: 0x46
function private function_940ac86068aa76eb()
{
    self endon( "death" );
    
    if ( isdefined( level.var_4caf3ce302e3487a ) )
    {
        thread [[ level.var_4caf3ce302e3487a ]]();
    }
    
    if ( self.type == "zombie" )
    {
        _zombiekill();
        return;
    }
    
    function_c72639c94e050034();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4a7c
// Size: 0x5c
function private function_c72639c94e050034()
{
    self endon( "death" );
    assert( self.type != "<dev string:xad7>" );
    self.nocorpse = 1;
    self.var_7e4b076a06c6df27 = 1;
    self.dropweapon = 0;
    
    if ( istrue( self.magic_bullet_shield ) )
    {
        scripts\common\ai::stop_magic_bullet_shield();
    }
    
    scripts\cp_mp\agents\agent_utils::despawnagent();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4ae0
// Size: 0xa6
function private function_6710855bea599a1f( encounterradius )
{
    self endon( "death" );
    spawnpoint = self.origin;
    maxdistance = encounterradius * getdvarfloat( @"hash_a99b215bdc4d8f7d", 5 );
    maxdistancesqr = maxdistance * maxdistance;
    
    while ( true )
    {
        wait randomfloatrange( 5, 7 );
        
        if ( distancesquared( self.origin, spawnpoint ) > maxdistancesqr )
        {
            /#
                function_b569203d69d8e9d9( "<dev string:xae1>" + self getentitynumber() + "<dev string:xaf7>" + self.directorrequestid );
            #/
            
            function_cdc13899cf352216();
        }
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4b8e
// Size: 0x5f
function private function_400c2ac378ef0646()
{
    self endon( "death" );
    
    if ( istrue( self.var_4cbb43e1b94c780e ) )
    {
        return;
    }
    
    self.var_4cbb43e1b94c780e = 1;
    var_c83686653e74aaa3 = getdvarfloat( @"hash_d31bf82a85c7351", 0 );
    
    while ( getplayerinfluenceatposition( self.origin ) > var_c83686653e74aaa3 )
    {
        waitframe();
    }
    
    _zombiekill();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4bf5
// Size: 0x84
function private function_cdc13899cf352216()
{
    self endon( "death" );
    
    if ( getplayerinfluenceatposition( self.origin ) > getdvarfloat( @"hash_d31bf82a85c7351", 0 ) )
    {
        if ( istrue( self._blackboard.zombieindespawn ) )
        {
            return;
        }
        
        self notify( "despawn" );
        
        if ( self asmhasstate( self.asmname, "despawn_in" ) )
        {
            self.nocorpse = 1;
            scripts\asm\asm::asm_setstate( "despawn_in" );
            return;
        }
    }
    
    _zombiekill();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4c81
// Size: 0x66
function private _zombiekill()
{
    self endon( "death" );
    
    if ( istrue( self.magic_bullet_shield ) )
    {
        scripts\common\ai::stop_magic_bullet_shield();
    }
    
    if ( ent_flag( "log_on_despawn" ) )
    {
        logstring( "AI Director attempting to despawn ent [" + string( self getentitynumber() ) + "]" );
    }
    
    self.nocorpse = 1;
    self.var_7e4b076a06c6df27 = 1;
    self kill();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4cef
// Size: 0x144
function private function_2d225c8fbea7ed93( requestid, unload_pos )
{
    level endon( "game_ended" );
    self endon( "death" );
    self waittill( "reached_end_node" );
    self vehphys_parkingbrake( 1 );
    self setconfigvalue( "p2p", "manualSpeed", mph_to_ips( 0 ) );
    self vehicle_setspeedimmediate( 0, 1, 1 );
    self vehicle_cleardrivingstate();
    riders = self.riders;
    
    foreach ( rider in self.riders )
    {
        rider thread function_fe875eadc4fcf2c2( requestid, unload_pos );
    }
    
    scripts\common\vehicle_code::_vehicle_unload( "default" );
    
    if ( scripts\common\vehicle_aianim::riders_unloadable( "default" ) )
    {
        self waittill( "unloaded" );
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self removecomponent( "p2p" );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self removecomponent( "path" );
    }
    
    self vehphys_parkingbrake( 0 );
    self vehicleClearAnims();
    self setscriptablepartstate( "single", "vehicle_use" );
    function_ad0d4e47324849b3( requestid );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4e3b
// Size: 0x48
function private function_718e622bef6f4a9c( requestid )
{
    level endon( "game_ended" );
    entnum = self getentitynumber();
    self waittill( "death", attacker, meansofdeath );
    function_ef3a0e9600008e7e( requestid, entnum );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4e8b
// Size: 0x2e
function private function_63a4b48c6e425420( requestid )
{
    level endon( "game_ended" );
    self endon( "death" );
    self waittill( "vehicle_owner_update" );
    function_ef3a0e9600008e7e( requestid, self getentitynumber() );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4ec1
// Size: 0x8c
function private function_fe875eadc4fcf2c2( requestid, unload_pos )
{
    self endon( "death" );
    self waittill( "unload" );
    
    if ( flag( "stealth_enabled" ) && isdefined( self.stealth ) && istrue( self.stealth_enabled ) )
    {
        self setstealthstate( "combat" );
    }
    
    if ( !isdefined( unload_pos ) )
    {
        unload_pos = self.origin;
    }
    
    _setgoalpos( unload_pos, 512 );
    function_2d85286f9e48645b( requestid );
    thread _precombat( self.directorspawndata );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4f55
// Size: 0x1b
function private function_2d3a114748311c18()
{
    self endon( "death" );
    self waittill( "loaded" );
    self.var_f327ed481efe4857 = undefined;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4f78
// Size: 0xad
function private function_233f4ebb97f71baa( vehiclenodeindex )
{
    result = undefined;
    vehiclenodestart = getvehiclenode( vehiclenodeindex );
    
    if ( isdefined( vehiclenodestart ) )
    {
        pathnodes = [];
        pathnodes[ pathnodes.size ] = vehiclenodestart;
        
        while ( true )
        {
            currentnode = pathnodes[ pathnodes.size - 1 ];
            
            if ( !isdefined( currentnode.target ) )
            {
                break;
            }
            
            nextnode = getvehiclenode( currentnode.target, "targetname" );
            
            if ( !isdefined( nextnode ) || array_contains( pathnodes, nextnode ) )
            {
                break;
            }
            
            pathnodes[ pathnodes.size ] = nextnode;
        }
        
        result = pathnodes[ pathnodes.size - 1 ];
    }
    
    return result;
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x502e
// Size: 0x35a
function private function_1a92c62e989f69c2( spawnedvehicle, goalpoint, pathindex, vehspeed )
{
    if ( !spawnedvehicle hascomponent( "p2p" ) )
    {
        spawnedvehicle addcomponent( "p2p" );
    }
    
    if ( !spawnedvehicle hascomponent( "path" ) )
    {
        spawnedvehicle addcomponent( "path" );
    }
    
    if ( !spawnedvehicle hascomponent( "animator" ) )
    {
        spawnedvehicle addcomponent( "animator" );
    }
    
    spawnedvehicle setconfigvalue( "p2p", "checkStuck", 0 );
    spawnedvehicle setconfigvalue( "p2p", "brakeAtGoal", 1 );
    spawnedvehicle setconfigvalue( "p2p", "automaticNormal", 1 );
    spawnedvehicle setconfigvalue( "p2p", "brakeOnGoalGasbrake", 1 );
    spawnedvehicle setconfigvalue( "p2p", "goalPoint", goalpoint );
    spawnedvehicle setconfigvalue( "p2p", "goalThreshold", 200 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedClose", 1 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedThreshold", 1 );
    spawnedvehicle setconfigvalue( "p2p", "automaticFastTopspeedFraction", 1 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedFarBelow", 1 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedFarAbove", 4 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedClose", 2 );
    spawnedvehicle setconfigvalue( "p2p", "gasToStopMovement", 0.9 );
    spawnedvehicle setconfigvalue( "p2p", "steeringMultiplier", 2 );
    spawnedvehicle setconfigvalue( "path", "radiusToStep", 300 );
    spawnedvehicle setconfigvalue( "p2p", "manualSpeed", vehspeed );
    var_427b2431f2aa8461 = 0;
    
    if ( getdvarint( @"hash_46c9c4287e87fcfd", 0 ) )
    {
        goalvehiclenode = function_233f4ebb97f71baa( pathindex );
        
        if ( isdefined( goalvehiclenode ) )
        {
            /#
                adddebugcommand( "<dev string:xb1b>" );
                adddebugcommand( "<dev string:xb3f>" );
            #/
            
            spawnedvehicle scripts\common\vehicle_code::vehicle_disable_navobstacles();
            startlocation = spawnedvehicle.origin;
            goallocation = goalvehiclenode.origin;
            vehicleforward = anglestoforward( spawnedvehicle.angles );
            var_34bb55fbc59c2e1d = isnavmeshloaded( "vehicle_large" );
            var_a8c9b5fffa6387d = isnavmeshloaded( "zombie_large" );
            navmeshlayer = ter_op( var_34bb55fbc59c2e1d, "vehicle_large", ter_op( var_a8c9b5fffa6387d, "zombie_large", undefined ) );
            splinepoints = spawnedvehicle findsplinepath( startlocation, goallocation, 50, 200, 100, vehicleforward, ( 0, 0, 0 ), 300, 0.4, 0, 1, navmeshlayer, 0, 1 );
            
            if ( isdefined( splinepoints ) && splinepoints.size > 0 )
            {
                var_427b2431f2aa8461 = 1;
                spawnedvehicle thread scripts\common\vehicle_paths::checkvehiclenavsplinestuck();
                spawnedvehicle thread scripts\common\vehicle_paths::checkvehiclenavsplineinterrupted();
            }
            
            /#
                spawnedvehicle thread scripts\common\vehicle_paths::function_68d5232181fec390( splinepoints, ter_op( isdefined( navmeshlayer ), ( 1, 1, 1 ), ( 1, 0, 0 ) ) );
                spawnedvehicle thread scripts\common\vehicle_paths::function_2a708e9755fc798b( navmeshlayer, ips_to_mph( vehspeed ) );
            #/
        }
    }
    
    if ( !var_427b2431f2aa8461 )
    {
        spawnedvehicle setconfigvalue( "path", "radiantId", pathindex );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5390
// Size: 0x70
function private function_d6b83c4fb86ed414( requestid, data )
{
    if ( isdefined( level.var_8cd784cab6ecbb43[ requestid ] ) )
    {
        if ( level.var_8cd784cab6ecbb43[ requestid ].var_891e2bd59c71ae44 == 0 )
        {
            level thread function_6a4f830ea5453937( requestid, data );
            return;
        }
        
        if ( level.var_8cd784cab6ecbb43[ requestid ].var_891e2bd59c71ae44 == 2 )
        {
            level thread function_26ab78a96eb9a2da( requestid, data );
        }
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5408
// Size: 0x18a
function private function_8b8837c923841d4e( riders )
{
    var_fb6a3e631f70c08a = [];
    riders = function_fdc9d5557c53078e( riders );
    
    foreach ( rider in riders )
    {
        if ( isdefined( rider.var_af27b6a3d3a2f6af ) && rider.var_af27b6a3d3a2f6af != -1 )
        {
            if ( !self.usedpositions[ rider.var_af27b6a3d3a2f6af ] )
            {
                rider.script_startingposition = rider.var_af27b6a3d3a2f6af;
                self.usedpositions[ rider.var_af27b6a3d3a2f6af ] = 1;
            }
            else
            {
                assertmsg( "<dev string:xb6a>" + rider.var_af27b6a3d3a2f6af );
            }
            
            continue;
        }
        
        var_fb6a3e631f70c08a[ var_fb6a3e631f70c08a.size ] = rider;
    }
    
    availableseats = scripts\common\vehicle_aianim::get_availablepositions();
    seatsindex = 0;
    
    foreach ( rider in var_fb6a3e631f70c08a )
    {
        seatnumber = availableseats.availablepositions[ seatsindex ].vehicle_position;
        rider.script_startingposition = seatnumber;
        self.usedpositions[ seatnumber ] = 1;
        seatsindex++;
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x559a
// Size: 0x346
function private function_26ab78a96eb9a2da( requestid, team )
{
    level endon( "game_ended" );
    
    if ( isdefined( level.var_8cd784cab6ecbb43[ requestid ] ) )
    {
        vehicle = level.var_8cd784cab6ecbb43[ requestid ].vehicle;
        vehicle_index = level.var_8cd784cab6ecbb43[ requestid ].vehicle_index;
        riders = level.var_8cd784cab6ecbb43[ requestid ].riders;
        unload_pos = level.var_8cd784cab6ecbb43[ requestid ].unload_pos;
        level.var_8cd784cab6ecbb43[ requestid ] = undefined;
        
        if ( isdefined( level.var_c05a13fa777eefd3 ) )
        {
            elapsed = gettime() - level.var_c05a13fa777eefd3;
            
            if ( function_c89ed1840c8d0f0f( elapsed ) < 1 )
            {
                wait randomfloatrange( 1, 3 );
            }
        }
        
        vehiclenodestart = getvehiclenode( vehicle_index );
        
        if ( !isdefined( vehiclenodestart ) )
        {
            encounterdata = function_9a39e23c3c52c2af( requestid );
            assertmsg( "<dev string:xbb6>" + encounterdata.encounterbundle + "<dev string:xbe0>" + encounterdata.origin + "<dev string:xbf2>" );
        }
        
        vehicle_ref = undefined;
        vehicleclassname = undefined;
        animalias = undefined;
        
        foreach ( vehicleref in level.var_a0b2c978ca57ffc5 )
        {
            if ( isdefined( vehicleref.vehicle ) && vehicleref.vehicle == vehicle )
            {
                vehicle_ref = vehicleref.ref;
                vehicleclassname = vehicleref.ai.classname;
                animalias = vehicleref.ai.vehicleanimalias;
                break;
            }
        }
        
        assertex( isdefined( vehicle_ref ), "<dev string:xbf7>" + vehicle );
        
        if ( !isdefined( team ) )
        {
            team = "team_hundred_ninety";
        }
        
        heli = namespace_5d57e6b81b105f5d::function_f1620ddb70094ea9( vehiclenodestart, 0, vehicle_ref, 0, team );
        heli.directorrequestid = requestid;
        function_b321d5942c63e7fd( requestid, heli );
        level.var_c05a13fa777eefd3 = gettime();
        callbackstruct = function_8c8ae740367137ba( "OnVehicleSpawned", requestid );
        
        if ( isdefined( callbackstruct ) )
        {
            thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, heli );
        }
        
        heli namespace_5d57e6b81b105f5d::function_35c699c709e24b69( riders );
        
        foreach ( rider in riders )
        {
            rider.var_f327ed481efe4857 = undefined;
        }
        
        if ( vehicle == "veh_jup_mil_air_heli_blima_physics_anim_infil_mp" )
        {
            heli thread function_14c40311c151a17b( requestid, vehiclenodestart, unload_pos );
        }
        else
        {
            heli thread function_157996d822cefeaf( requestid, unload_pos, vehiclenodestart );
        }
        
        heli thread function_718e622bef6f4a9c( requestid );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x58e8
// Size: 0x3cc
function private function_6a4f830ea5453937( requestid, team )
{
    level endon( "game_ended" );
    
    if ( isdefined( level.var_8cd784cab6ecbb43[ requestid ] ) )
    {
        vehicle = level.var_8cd784cab6ecbb43[ requestid ].vehicle;
        vehicle_index = level.var_8cd784cab6ecbb43[ requestid ].vehicle_index;
        riders = level.var_8cd784cab6ecbb43[ requestid ].riders;
        unload_pos = level.var_8cd784cab6ecbb43[ requestid ].unload_pos;
        level.var_8cd784cab6ecbb43[ requestid ] = undefined;
        
        if ( isdefined( level.var_c05a13fa777eefd3 ) && !iscp() )
        {
            elapsed = gettime() - level.var_c05a13fa777eefd3;
            
            if ( function_c89ed1840c8d0f0f( elapsed ) < 1 )
            {
                wait randomfloatrange( 1, 3 );
            }
        }
        
        vehiclenodestart = getvehiclenode( vehicle_index );
        vehiclespawndata = spawnstruct();
        vehiclespawndata.origin = vehiclenodestart.origin + ( 0, 0, 128 );
        vehiclespawndata.angles = vehiclenodestart.angles;
        
        if ( iscp() )
        {
            vehiclespawndata.initai = 1;
        }
        
        vehicle_ref = undefined;
        vehicleclassname = undefined;
        animalias = undefined;
        
        foreach ( vehicleref in level.var_a0b2c978ca57ffc5 )
        {
            if ( isdefined( vehicleref.vehicle ) && vehicleref.vehicle == vehicle )
            {
                vehicle_ref = vehicleref.ref;
                vehicleclassname = vehicleref.ai.classname;
                animalias = vehicleref.ai.vehicleanimalias;
                break;
            }
        }
        
        if ( isdefined( vehicle_ref ) )
        {
            spawnedvehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( vehicle_ref, vehiclespawndata );
            
            if ( isdefined( spawnedvehicle ) )
            {
                function_b321d5942c63e7fd( requestid, spawnedvehicle );
                level.var_c05a13fa777eefd3 = gettime();
                callbackstruct = function_8c8ae740367137ba( "OnVehicleSpawned", requestid );
                
                if ( isdefined( callbackstruct ) )
                {
                    thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, spawnedvehicle );
                }
                
                spawnedvehicle.riders = [];
                spawnedvehicle.unloadque = [];
                spawnedvehicle.unload_group = "all";
                spawnedvehicle.classname_mp = vehicleclassname;
                spawnedvehicle.vehicleanimalias = animalias;
                spawnedvehicle scripts\common\vehicle_aianim::handle_attached_guys();
                spawnedvehicle setscriptablepartstate( "single", "vehicle_unusable" );
                spawnedvehicle function_8b8837c923841d4e( riders );
                
                foreach ( guy in riders )
                {
                    spawnedvehicle scripts\common\vehicle_aianim::guy_enter( guy );
                    waitframe();
                    guy.var_f327ed481efe4857 = undefined;
                }
                
                spawnedvehicle function_1a92c62e989f69c2( spawnedvehicle, spawnedvehicle.origin, vehicle_index, vehiclenodestart.speed );
                spawnedvehicle thread function_2d225c8fbea7ed93( requestid, unload_pos );
                spawnedvehicle thread function_718e622bef6f4a9c( requestid );
                spawnedvehicle thread function_63a4b48c6e425420( requestid );
            }
            
            return;
        }
        
        assertmsg( "<dev string:xc11>" + vehicle );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5cbc
// Size: 0x72
function private function_157996d822cefeaf( requestid, unload_pos, vehiclenodestart )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    thread namespace_5d57e6b81b105f5d::function_ff4065536bad7017( vehiclenodestart, undefined );
    self waittill( "ai_spawn_director_heli_reached_end_path" );
    unload_pos = namespace_5d57e6b81b105f5d::function_10ff61ea7267cf0b( unload_pos );
    var_23c7137b7d74fee2 = namespace_5d57e6b81b105f5d::function_9e55d8680a23ec64( unload_pos );
    function_7d5afc41a709dbc9( requestid, vehiclenodestart.origin, var_23c7137b7d74fee2 );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5d36
// Size: 0x50
function private function_14c40311c151a17b( requestid, vehiclenodestart, unloadpos )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    namespace_5d57e6b81b105f5d::function_9514a9690c80864a( vehiclenodestart, vehiclenodestart.origin, unloadpos, &function_9af81499f0fdd6c8 );
    namespace_5d57e6b81b105f5d::function_fe282a6dc1e0d0fa();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 2
// Checksum 0x0, Offset: 0x5d8e
// Size: 0xd0
function function_9af81499f0fdd6c8( heli, var_23c7137b7d74fee2 )
{
    assertex( isdefined( heli.directorrequestid ), "<dev string:xc40>" );
    
    if ( isdefined( var_23c7137b7d74fee2 ) && var_23c7137b7d74fee2.size > 0 )
    {
        foreach ( agent in var_23c7137b7d74fee2 )
        {
            if ( isdefined( agent ) && agent.isactive )
            {
                assertex( isdefined( agent.directorrequestid ), "<dev string:xc7f>" );
                agent function_2d85286f9e48645b( agent.directorrequestid );
            }
        }
    }
    
    function_ad0d4e47324849b3( heli.directorrequestid );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5e66
// Size: 0x51
function private function_7d5afc41a709dbc9( requestid, var_2c2390497cfcfc4, var_23c7137b7d74fee2 )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    function_9af81499f0fdd6c8( self, var_23c7137b7d74fee2 );
    thread namespace_5d57e6b81b105f5d::ai_spawn_director_heli_land( var_2c2390497cfcfc4 );
    self waittill( "ai_spawn_director_heli_landed" );
    namespace_5d57e6b81b105f5d::function_fe282a6dc1e0d0fa();
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5ebf
// Size: 0x44
function private function_2d85286f9e48645b( requestid )
{
    callbackstruct = function_8c8ae740367137ba( "OnUnloaded", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, self );
    }
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5f0b
// Size: 0x75
function private function_77b24ac305d25629( data )
{
    level endon( "game_ended" );
    self endon( "death" );
    self hide();
    delaycall( 0.5, &show );
    waitframe();
    
    if ( istrue( data.smokebombinfil ) )
    {
        thread function_ddfc7d96a73dafce( data );
    }
    
    namespace_30bebe2c8fdd4f94::function_c789cc0bd60384c2( data.var_35b7f8cbbef2653a, data.var_45e72621955fd7cf, undefined, 0, 3 );
    _precombat( data );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5f88
// Size: 0x2a
function private function_ddfc7d96a73dafce( data )
{
    self endon( "death" );
    self waittill( "parachute_prepare_to_land" );
    function_94e87cabbe0c24af( self.landing_spot );
}

// Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
// Params 0
// Checksum 0x0, Offset: 0x5fba
// Size: 0x75
function function_e64438bcaad08d5c()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( !isdefined( self.directorrequestid ) )
    {
        return;
    }
    
    waittill_any_4( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    requestdata = function_9a39e23c3c52c2af( self.directorrequestid );
    
    if ( isdefined( requestdata ) )
    {
        self setgoalpos( requestdata.origin, requestdata.radius );
    }
}

/#

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x6037
    // Size: 0x63, Type: dev
    function private function_b569203d69d8e9d9( text )
    {
        shouldlog = getdvar( @"hash_25de39eff9804a88", 0 );
        
        if ( isdefined( shouldlog ) && ( isstring( shouldlog ) && shouldlog == "<dev string:xca6>" || !isstring( shouldlog ) && shouldlog == 1 ) )
        {
            println( "<dev string:xcab>" + text );
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x60a2
    // Size: 0xb7, Type: dev
    function private function_66be042996360501()
    {
        self endon( "<dev string:xcc3>" );
        influencesum = getplayerinfluenceatposition( self.origin, 1 );
        randomnesslerp = randomfloatrange( 0, 0.5 );
        influencelerp = clamp( influencesum / 4, 0, 1 ) * 0.5;
        weight = randomnesslerp + influencelerp;
        a = 60;
        b = 10;
        waittime = a * ( 1 - weight ) + b * weight;
        waittime = clamp( waittime, b, a );
        wait waittime;
        self kill();
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x6161
    // Size: 0x19c, Type: dev
    function private function_697246e491b82b( test_string )
    {
        level notify( "<dev string:xccc>" );
        level endon( "<dev string:xccc>" );
        test_params = strtok( test_string, "<dev string:xce7>" );
        test_types = [];
        should_move = 0;
        should_kill = 0;
        run_all = 0;
        
        foreach ( param in test_params )
        {
            switch ( param )
            {
                case #"hash_5f937e1deca2a44f":
                case #"hash_8b3de9dcd39c0dc6":
                case #"hash_b8b717134133c2d8":
                    test_types = array_add( test_types, param );
                    break;
                case #"hash_20cd76d83c2f7487":
                    should_move = 1;
                    break;
                case #"hash_b5868715305a78a7":
                    should_kill = 1;
                    break;
                case #"hash_c482c6c109150a4":
                    run_all = 1;
                    break;
            }
        }
        
        foreach ( test_type in test_types )
        {
            if ( istrue( run_all ) )
            {
                function_455f6a83239d2c9f( test_type, 0, 0 );
                function_455f6a83239d2c9f( test_type, 0, 1 );
                function_455f6a83239d2c9f( test_type, 1, 0 );
                function_455f6a83239d2c9f( test_type, 1, 1 );
                continue;
            }
            
            function_455f6a83239d2c9f( test_type, should_move, should_kill );
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x6305
    // Size: 0xc6, Type: dev
    function private function_455f6a83239d2c9f( test_name, should_move, should_kill )
    {
        setdvar( @"hash_19f0eb1fd6a2f87d", 1 );
        setdvar( @"hash_fe20797ad12b2dbe", should_kill );
        thread function_5ca76cbc5c022acd( test_name, should_move );
        wait 5;
        var_4435be27f3e1110d = test_name;
        var_4435be27f3e1110d += ter_op( should_move, "<dev string:xd08>", "<dev string:xd13>" );
        var_4435be27f3e1110d += ter_op( should_kill, "<dev string:xd22>", "<dev string:xd2e>" );
        iprintlnbold( "<dev string:xd3d>" + var_4435be27f3e1110d );
        
        if ( should_kill )
        {
            wait 240;
        }
        else
        {
            wait 60;
        }
        
        setdvar( @"hash_53043691f4ede34", var_4435be27f3e1110d );
        iprintlnbold( "<dev string:xd47>" + var_4435be27f3e1110d );
        waitframe();
        adddebugcommand( "<dev string:xd4f>" );
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x63d3
    // Size: 0x47, Type: dev
    function private function_5ca76cbc5c022acd( test_name, should_move )
    {
        level notify( "<dev string:xd62>" );
        level endon( "<dev string:xd62>" );
        function_ecfc4d9f34d1ff28( test_name, should_move );
        wait 24;
        
        while ( should_move )
        {
            wait 0.5;
            function_ecfc4d9f34d1ff28( test_name, should_move );
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x6422
    // Size: 0xfd, Type: dev
    function private function_ecfc4d9f34d1ff28( test_name, should_move )
    {
        clearinfluenceobjects();
        navbounds = getnavbounds();
        navbounds.halfsize *= 0.8;
        worldmin = navbounds.midpoint - navbounds.halfsize;
        worldmax = navbounds.midpoint + navbounds.halfsize;
        player_count = getdvarint( @"party_maxplayers", 48 );
        
        switch ( test_name )
        {
            case #"hash_8b3de9dcd39c0dc6":
                function_f681aebd2ee59625( player_count, should_move, worldmin, worldmax );
                break;
            case #"hash_5f937e1deca2a44f":
                function_9e6faf8741817672( player_count, should_move, worldmin, worldmax );
                break;
            case #"hash_b8b717134133c2d8":
                function_dd49eb1db10445ad( player_count, should_move, worldmin, worldmax );
                break;
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x6527
    // Size: 0x1b5, Type: dev
    function private function_f681aebd2ee59625( player_count, should_move, worldmin, worldmax )
    {
        squad_count = int( player_count / 4 );
        var_b3ffe4a8d5074a29 = int( floor( sqrt( squad_count ) ) );
        var_fd2e7bcb3d1af898 = int( squad_count / var_b3ffe4a8d5074a29 );
        xsize = worldmax[ 0 ] - worldmin[ 0 ];
        ysize = worldmax[ 1 ] - worldmin[ 1 ];
        xincrement = xsize / var_b3ffe4a8d5074a29;
        yincrement = ysize / var_fd2e7bcb3d1af898;
        var_7734f7004975af18 = [ ( 0, 0, 0 ), ( 500, 0, 0 ), ( 0, 500, 0 ), ( 500, 500, 0 ) ];
        
        for ( xindex = 0; xindex < var_b3ffe4a8d5074a29 ; xindex++ )
        {
            xpos = worldmin[ 0 ] + xindex * xincrement;
            
            for ( yindex = 0; yindex < var_fd2e7bcb3d1af898 ; yindex++ )
            {
                ypos = worldmin[ 1 ] + yindex * yincrement;
                var_7597ede1b3e40a8e = ( xpos, ypos, 1172 );
                
                foreach ( var_d8f0e55e945d6cfb in var_7734f7004975af18 )
                {
                    function_7a6ef66132ad3f88( var_7597ede1b3e40a8e + var_d8f0e55e945d6cfb, should_move );
                }
            }
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x66e4
    // Size: 0x109, Type: dev
    function private function_9e6faf8741817672( player_count, should_move, worldmin, worldmax )
    {
        var_b3ffe4a8d5074a29 = int( floor( sqrt( player_count ) ) );
        var_fd2e7bcb3d1af898 = int( player_count / var_b3ffe4a8d5074a29 );
        xsize = worldmax[ 0 ] - worldmin[ 0 ];
        ysize = worldmax[ 1 ] - worldmin[ 1 ];
        xincrement = xsize / var_b3ffe4a8d5074a29;
        yincrement = ysize / var_fd2e7bcb3d1af898;
        
        for ( xindex = 0; xindex < var_b3ffe4a8d5074a29 ; xindex++ )
        {
            xpos = worldmin[ 0 ] + xindex * xincrement;
            
            for ( yindex = 0; yindex < var_fd2e7bcb3d1af898 ; yindex++ )
            {
                ypos = worldmin[ 1 ] + yindex * yincrement;
                var_7597ede1b3e40a8e = ( xpos, ypos, 1172 );
                function_7a6ef66132ad3f88( var_7597ede1b3e40a8e, should_move );
            }
        }
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x67f5
    // Size: 0x42, Type: dev
    function private function_dd49eb1db10445ad( player_count, should_move, worldmin, worldmax )
    {
        function_9e6faf8741817672( player_count / 2, should_move, worldmin, worldmax );
        function_f681aebd2ee59625( player_count / 2, should_move, worldmin, worldmax );
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x683f
    // Size: 0x93, Type: dev
    function private function_bcc679805784c317( var_7597ede1b3e40a8e, timeoffset )
    {
        var_b4469da4bc031c17 = 57.2958;
        x = ( gettime() + timeoffset ) / 1000;
        x /= getdvarfloat( @"hash_f1961fe2a6c4855b", 10 );
        x *= var_b4469da4bc031c17;
        moveradius = getdvarfloat( @"hash_de5359935bb10538", 5000 );
        var_7597ede1b3e40a8e += ( sin( x ) * moveradius, cos( x ) * moveradius, 0 );
        return var_7597ede1b3e40a8e;
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x68da
    // Size: 0xb3, Type: dev
    function private function_7a6ef66132ad3f88( var_7597ede1b3e40a8e, should_move )
    {
        closesttacpoint = findclosesttacpoint( var_7597ede1b3e40a8e, 0 );
        
        if ( isdefined( closesttacpoint ) )
        {
            var_7597ede1b3e40a8e = closesttacpoint.origin;
        }
        
        var_e0392858d8615d65 = var_7597ede1b3e40a8e;
        
        if ( should_move )
        {
            var_7597ede1b3e40a8e = function_bcc679805784c317( var_7597ede1b3e40a8e, 0 );
            var_8cb12d1e1a540bb1 = function_bcc679805784c317( var_e0392858d8615d65, 3000 );
            orientedbox( var_8cb12d1e1a540bb1, ( 1000, 1000, 1000 ), ( 0, 0, 0 ), ( 1, 0, 1 ), 0, 20 );
        }
        
        var_7597ede1b3e40a8e = getclosestpointonnavmesh( var_7597ede1b3e40a8e, "<dev string:xd84>", 0, 0, 1 );
        addinfluenceobjectatposition( var_7597ede1b3e40a8e, 3 );
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 1
    // Checksum 0x0, Offset: 0x6995
    // Size: 0x350, Type: dev
    function function_b6206c1c64860991( tablename )
    {
        level notify( "<dev string:xd62>" );
        level notify( "<dev string:xd8d>" );
        level endon( "<dev string:xd8d>" );
        level.var_23f1eadfcec14e18 = [];
        childthread function_21c84a22c509b5ce();
        iprintlnbold( "<dev string:xda1>" + tablename );
        numrows = tablelookupgetnumrows( tablename );
        var_d0caf0cd49324747 = undefined;
        playbackstarttime = undefined;
        
        for ( rowindex = 3; rowindex < numrows ; rowindex++ )
        {
            event = tablelookupbyrow( tablename, rowindex, 0 );
            entnum = int( tablelookupbyrow( tablename, rowindex, 2 ) );
            eventtype = tablelookupbyrow( tablename, rowindex, 3 );
            timestamp = int( tablelookupbyrow( tablename, rowindex, 1 ) );
            
            if ( event != "<dev string:xdb6>" )
            {
                rowindex++;
                continue;
            }
            
            if ( !isdefined( var_d0caf0cd49324747 ) )
            {
                var_d0caf0cd49324747 = timestamp;
                playbackstarttime = gettime();
            }
            
            speedmul = getdvarint( @"hash_4d697dbebbd5e599", 10 );
            
            if ( speedmul <= 0 )
            {
                speedmul = 1;
            }
            
            timedelta = timestamp - var_d0caf0cd49324747;
            timedelta /= speedmul;
            targetservertime = playbackstarttime + timedelta;
            
            if ( targetservertime > gettime() )
            {
                wait float( targetservertime - gettime() ) / 1000;
            }
            
            switch ( eventtype )
            {
                case #"hash_cbfb23135a2db9a1":
                    pos_x = float( tablelookupbyrow( tablename, rowindex, 4 ) );
                    pos_y = float( tablelookupbyrow( tablename, rowindex, 5 ) );
                    level.var_23f1eadfcec14e18[ entnum ] = spawnstruct();
                    level.var_23f1eadfcec14e18[ entnum ].startpos = ( pos_x, pos_y, 0 );
                    level.var_23f1eadfcec14e18[ entnum ].startpos = getclosestpointonnavmesh( level.var_23f1eadfcec14e18[ entnum ].startpos, "<dev string:xd84>", 0, 0, 1 );
                    level.var_23f1eadfcec14e18[ entnum ].endpos = level.var_23f1eadfcec14e18[ entnum ].startpos;
                    level.var_23f1eadfcec14e18[ entnum ].starttime = gettime();
                    level.var_23f1eadfcec14e18[ entnum ].name = tablelookupbyrow( tablename, rowindex, 7 );
                    break;
                case #"hash_82b3bcf2299864ac":
                    if ( isdefined( level.var_23f1eadfcec14e18[ entnum ] ) )
                    {
                        pos_x = float( tablelookupbyrow( tablename, rowindex, 4 ) );
                        pos_y = float( tablelookupbyrow( tablename, rowindex, 5 ) );
                        level.var_23f1eadfcec14e18[ entnum ].startpos = level.var_23f1eadfcec14e18[ entnum ].endpos;
                        level.var_23f1eadfcec14e18[ entnum ].endpos = getclosestpointonnavmesh( ( pos_x, pos_y, 0 ), "<dev string:xd84>", 0, 0, 1 );
                        level.var_23f1eadfcec14e18[ entnum ].starttime = gettime();
                    }
                    
                    break;
            }
        }
        
        iprintlnbold( "<dev string:xddf>" );
    }

    // Namespace ai_spawn_director / scripts\cp_mp\agents\ai_spawn_director
    // Params 0
    // Checksum 0x0, Offset: 0x6ced
    // Size: 0x146, Type: dev
    function function_21c84a22c509b5ce()
    {
        while ( isdefined( level.var_23f1eadfcec14e18 ) )
        {
            speedmul = getdvarint( @"hash_4d697dbebbd5e599", 10 );
            totallerptime = 30 / speedmul;
            clearinfluenceobjects();
            
            foreach ( playerstruct in level.var_23f1eadfcec14e18 )
            {
                timediff = ( gettime() - playerstruct.starttime ) / 1000;
                lerptime = clamp( timediff / totallerptime, 0, 1 );
                var_7597ede1b3e40a8e = vectorlerp( playerstruct.startpos, playerstruct.endpos, lerptime );
                addinfluenceobjectatposition( var_7597ede1b3e40a8e, 3 );
                print3d( var_7597ede1b3e40a8e, playerstruct.name, ( 1, 1, 1 ), 1, 10, 20, 1 );
                sphere( var_7597ede1b3e40a8e, 100, ( 0.88, 0.44, 0.88 ), 0, 20 );
            }
            
            wait 1;
        }
    }

#/
