#using script_107f57229aa7af6e;
#using script_61afae50a53c3917;
#using script_7b13d902fe77425;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\teams;

#namespace namespace_ec05a9f2b3a2553f;

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 0
// Checksum 0x0, Offset: 0x38b
// Size: 0xde
function init()
{
    var_e75ba0281e9489ad = 0;
    
    foreach ( player in level.players )
    {
        player.var_fad5c3453452323f = 0;
        
        if ( function_24284b3062968df7( player ) )
        {
            if ( !isdefined( level.var_93591af03e4e5ca ) )
            {
                level.var_93591af03e4e5ca = [];
            }
            
            player.var_db7718c39d9b365a = 0;
            var_e75ba0281e9489ad = 1;
            level.var_93591af03e4e5ca[ level.var_93591af03e4e5ca.size ] = player;
        }
    }
    
    if ( istrue( var_e75ba0281e9489ad ) )
    {
        namespace_6802e73310a37df6::main();
        waitframe();
        function_ba0f9c7af596cb45();
        function_5619f9fe170bd68d();
        function_36acf1839c114f35();
        return;
    }
    
    logstring( "S5 Drum Relic: No players in match can receive Drum Relic, fully skipping initialization" );
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x471
// Size: 0x148
function private function_5619f9fe170bd68d()
{
    level.var_61851ba753c40491 = getstructarray( "s5_relic_drum_race_struct_arrow", "targetname" );
    
    if ( isdefined( level.var_61851ba753c40491 ) && isdefined( level.var_93591af03e4e5ca ) && isarray( level.var_61851ba753c40491 ) && level.var_61851ba753c40491.size > 0 )
    {
        foreach ( var_2f940314c96033ff in level.var_61851ba753c40491 )
        {
            var_2f940314c96033ff.mdl_arrow = scripts\cp_mp\content_manager::spawn_script_model( var_2f940314c96033ff, "jup_season5_5_ob_arrow", 1, 0 );
            
            if ( isdefined( var_2f940314c96033ff.mdl_arrow ) )
            {
                var_2f940314c96033ff.mdl_arrow hide();
                
                foreach ( validplayer in level.var_93591af03e4e5ca )
                {
                    var_2f940314c96033ff.mdl_arrow showtoplayer( validplayer );
                }
            }
        }
        
        return;
    }
    
    logstring( "S5 Drum Relic: Missing structs to display hint arrows" );
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x5c1
// Size: 0x23b
function private function_ba0f9c7af596cb45()
{
    level.var_3ff432e08ce37965 = getnoentvolumearray( "s5_relic_drum_race_trigger_start", "targetname" );
    level.var_d3454f09c2105564 = getnoentvolumearray( "s5_relic_drum_race_trigger_end", "targetname" );
    var_179343b5981c3088 = getstruct( "s5_relic_drum_race_struct_reward", "targetname" );
    assert( isdefined( level.var_3ff432e08ce37965 ), "<dev string:x1c>" );
    assert( isdefined( level.var_d3454f09c2105564 ), "<dev string:x78>" );
    assert( level.var_3ff432e08ce37965.size == 1, "<dev string:xd2>" );
    assert( level.var_d3454f09c2105564.size == 1, "<dev string:x12b>" );
    
    foreach ( volume in level.var_3ff432e08ce37965 )
    {
        thread function_13676cfdd745bdce( volume );
    }
    
    foreach ( var_d2fe3c54c80fe08 in level.var_d3454f09c2105564 )
    {
        thread function_96722b987884943b( var_d2fe3c54c80fe08, var_179343b5981c3088 );
    }
    
    level.var_402a1e37a1a2c2f9 = [];
    
    for ( structindex = 1; structindex < 20 ; structindex++ )
    {
        searchid = "s5_relic_drum_race_trigger_checkpoint_" + string( structindex );
        var_7aec4e1e3c52c64a = getnoentvolumearray( searchid, "script_noteworthy" );
        
        if ( !isdefined( var_7aec4e1e3c52c64a ) || !isarray( var_7aec4e1e3c52c64a ) || var_7aec4e1e3c52c64a.size == 0 )
        {
            break;
        }
        
        foreach ( checkpoint in var_7aec4e1e3c52c64a )
        {
            level.var_402a1e37a1a2c2f9[ level.var_402a1e37a1a2c2f9.size ] = checkpoint;
            var_c429c0a3bbcac7b6 = structindex - 1;
            thread function_d8a49cfff8654f34( checkpoint, var_c429c0a3bbcac7b6 );
        }
    }
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x804
// Size: 0x89
function private function_36acf1839c114f35()
{
    level.var_4b54936fe6c83c7b = getstructarray( "s5_relic_drum_race_struct_mrpeeks_spawn", "targetname" );
    
    foreach ( mrpeeks_spawn in level.var_4b54936fe6c83c7b )
    {
        spawn_model( "ob_mrp", mrpeeks_spawn.origin, mrpeeks_spawn.angles );
    }
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 1
// Checksum 0x0, Offset: 0x895
// Size: 0x163
function function_13676cfdd745bdce( volume )
{
    assert( isdefined( volume ) );
    level endon( "game_ended" );
    volume endon( "death" );
    
    while ( true )
    {
        volume waittill( "trigger", enteringentity );
        
        /#
            if ( getdvarint( @"hash_db6fa1fcc2e3f83c", 0 ) )
            {
                level thread scripts\mp\utility\debug::drawsphere( volume.origin, 10, 40, ( 0, 1, 0 ) );
                function_a2d607a5609066b8();
            }
        #/
        
        if ( isdefined( enteringentity ) && function_d4d5da367a00e379( enteringentity ) )
        {
            playerstocheck = namespace_c8baf39126f1ef99::function_579b200202dd2b1b( enteringentity );
            
            if ( isdefined( playerstocheck ) )
            {
                foreach ( var_c4b81997f0120a97 in playerstocheck )
                {
                    if ( function_24284b3062968df7( var_c4b81997f0120a97 ) && ( !isdefined( var_c4b81997f0120a97.var_db7718c39d9b365a ) || var_c4b81997f0120a97.var_db7718c39d9b365a <= 0 ) )
                    {
                        var_c4b81997f0120a97.var_db7718c39d9b365a = 40;
                        var_c4b81997f0120a97.var_97e5ed43b6d536e0 = 0;
                        
                        /#
                            if ( getdvarint( @"hash_db6fa1fcc2e3f83c", 0 ) )
                            {
                                thread function_e4c5668a49da26b5();
                            }
                        #/
                        
                        var_c4b81997f0120a97 thread function_6aa0a52e83acfb3a();
                        var_c4b81997f0120a97 playsoundtoplayer( "evt_ob_mrpeeks_stinger_speedway", var_c4b81997f0120a97 );
                    }
                }
            }
        }
    }
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 2
// Checksum 0x0, Offset: 0xa00
// Size: 0x14f
function function_d8a49cfff8654f34( volume, var_3d2d7853dbabbdac )
{
    assert( isdefined( volume ) );
    level endon( "game_ended" );
    volume endon( "death" );
    
    while ( true )
    {
        volume waittill( "trigger", enteringentity );
        
        if ( isdefined( enteringentity ) && function_d4d5da367a00e379( enteringentity ) )
        {
            playerstocheck = namespace_c8baf39126f1ef99::function_579b200202dd2b1b( enteringentity );
            
            if ( isdefined( playerstocheck ) )
            {
                foreach ( var_c4b81997f0120a97 in playerstocheck )
                {
                    if ( isdefined( var_c4b81997f0120a97.var_db7718c39d9b365a ) && isdefined( var_c4b81997f0120a97.var_97e5ed43b6d536e0 ) && var_c4b81997f0120a97.var_db7718c39d9b365a > 0 && var_c4b81997f0120a97.var_97e5ed43b6d536e0 == var_3d2d7853dbabbdac )
                    {
                        /#
                            if ( getdvarint( @"hash_db6fa1fcc2e3f83c", 0 ) )
                            {
                                level thread scripts\mp\utility\debug::drawsphere( volume.origin, 15, var_c4b81997f0120a97.var_db7718c39d9b365a, ( 0, 1, 0 ) );
                            }
                        #/
                        
                        var_c4b81997f0120a97 playsoundtoplayer( "evt_ob_mrpeeks_stinger_speedway", var_c4b81997f0120a97 );
                        var_c4b81997f0120a97.var_97e5ed43b6d536e0++;
                    }
                }
            }
        }
    }
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 2
// Checksum 0x0, Offset: 0xb57
// Size: 0x152
function function_96722b987884943b( volume, var_179343b5981c3088 )
{
    assert( isdefined( volume ) );
    level endon( "game_ended" );
    volume endon( "death" );
    
    while ( true )
    {
        volume waittill( "trigger", enteringentity );
        
        if ( isdefined( enteringentity ) && function_d4d5da367a00e379( enteringentity ) )
        {
            playerstocheck = namespace_c8baf39126f1ef99::function_579b200202dd2b1b( enteringentity );
            
            if ( isdefined( playerstocheck ) )
            {
                foreach ( var_c4b81997f0120a97 in playerstocheck )
                {
                    if ( isdefined( var_c4b81997f0120a97.var_db7718c39d9b365a ) && var_c4b81997f0120a97.var_db7718c39d9b365a > 0 && function_b8221e8a7feda5d3( var_c4b81997f0120a97 ) && !namespace_c8baf39126f1ef99::function_d737da36e4f0f6c2( var_c4b81997f0120a97, "ob_jup_item_reward_drum_s5" ) )
                    {
                        var_8232fe13bffb624 = isdefined( var_179343b5981c3088 ) ? var_179343b5981c3088.origin : volume.origin;
                        var_c4b81997f0120a97 playsoundtoplayer( "evt_ob_mrpeeks_stinger_speedway", var_c4b81997f0120a97 );
                        namespace_c8baf39126f1ef99::function_65e52fad2bce952c( var_c4b81997f0120a97, "ob_jup_item_reward_drum_s5", var_8232fe13bffb624, 1 );
                        wait 2;
                        thread scripts\cp_mp\overlord::playevent( "RFT_S5_5_RGUQ_Relic_Drop_Drum", [ var_c4b81997f0120a97 ] );
                        var_c4b81997f0120a97 function_187580de994979db();
                    }
                }
            }
        }
    }
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xcb1
// Size: 0x72, Type: bool
function private function_b8221e8a7feda5d3( player )
{
    if ( isdefined( level.var_402a1e37a1a2c2f9 ) && isarray( level.var_402a1e37a1a2c2f9 ) && level.var_402a1e37a1a2c2f9.size > 0 )
    {
        return ( isdefined( player ) && isdefined( player.var_97e5ed43b6d536e0 ) && isplayer( player ) && player.var_97e5ed43b6d536e0 >= level.var_402a1e37a1a2c2f9.size );
    }
    
    return true;
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xd2c
// Size: 0xdd
function private function_6aa0a52e83acfb3a()
{
    self endon( "death_or_disconnect" );
    
    if ( !( isdefined( self ) && isdefined( self.var_db7718c39d9b365a ) ) )
    {
        return;
    }
    
    while ( isdefined( self ) && self.var_db7718c39d9b365a > 0 )
    {
        /#
            if ( getdvarint( @"hash_db6fa1fcc2e3f83c", 0 ) )
            {
                foreach ( var_d2fe3c54c80fe08 in level.var_d3454f09c2105564 )
                {
                    level thread scripts\mp\utility\debug::drawsphere( var_d2fe3c54c80fe08.origin, 10, 1, ( 1, 0, 0 ) );
                }
            }
        #/
        
        self.var_db7718c39d9b365a--;
        wait 1;
    }
    
    self playsoundtoplayer( "evt_ob_blood_burner_challenge_time_out", self );
    function_187580de994979db();
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe11
// Size: 0x11
function private function_187580de994979db()
{
    if ( isdefined( self ) )
    {
        self.var_db7718c39d9b365a = 0;
    }
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe2a
// Size: 0x2c, Type: bool
function private function_24284b3062968df7( player )
{
    return isplayer( player ) && namespace_362d05f5d79f98cd::function_eaee8a3e6cdeefcf( player ) && !namespace_c8baf39126f1ef99::function_d737da36e4f0f6c2( player, "ob_jup_item_reward_drum_s5" );
}

// Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe5f
// Size: 0x3c, Type: bool
function private function_d4d5da367a00e379( entity )
{
    return isdefined( entity ) && isdefined( entity.vehiclename ) && entity scripts\cp_mp\vehicles\vehicle::isvehicle() && entity.vehiclename == "veh9_motorcycle_blood_burner";
}

/#

    // Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
    // Params 1
    // Checksum 0x0, Offset: 0xea4
    // Size: 0x75, Type: dev
    function function_a995ebc5fd006840( msg )
    {
        if ( !isdefined( level.var_7bfc520353bf14a7 ) )
        {
            level.var_7bfc520353bf14a7 = 0;
        }
        
        x = 10;
        y = 550;
        y += level.var_7bfc520353bf14a7 * 15;
        printtoscreen2d( x, y, msg, ( 1, 1, 1 ), 1.5 );
        level.var_7bfc520353bf14a7++;
    }

    // Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
    // Params 0
    // Checksum 0x0, Offset: 0xf21
    // Size: 0xf, Type: dev
    function function_3d1fbf66a57b0cb6()
    {
        level.var_7bfc520353bf14a7 = 0;
    }

    // Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xf38
    // Size: 0xe0, Type: dev
    function private function_e4c5668a49da26b5()
    {
        level notify( "<dev string:x182>" );
        level endon( "<dev string:x182>" );
        level endon( "<dev string:x19c>" );
        
        while ( true )
        {
            waitframe();
            
            foreach ( player in level.players )
            {
                if ( function_24284b3062968df7( player ) )
                {
                    if ( isdefined( player.name ) && isdefined( player ) && isdefined( player.var_db7718c39d9b365a ) )
                    {
                        function_a995ebc5fd006840( "<dev string:x1aa>" + player.name + "<dev string:x1b5>" + player.var_db7718c39d9b365a + "<dev string:x1c5>" + player.var_97e5ed43b6d536e0 );
                    }
                }
            }
            
            function_3d1fbf66a57b0cb6();
        }
    }

    // Namespace namespace_ec05a9f2b3a2553f / namespace_f2ba945007050131
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1020
    // Size: 0x76, Type: dev
    function private function_a2d607a5609066b8()
    {
        foreach ( checkpoint in level.var_402a1e37a1a2c2f9 )
        {
            level thread scripts\mp\utility\debug::drawsphere( checkpoint.origin, 10, 40, ( 0, 0, 1 ) );
        }
    }

#/
