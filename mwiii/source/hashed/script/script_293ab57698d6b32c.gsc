#using script_57bdd8aff28a4717;
#using script_7c2886c7a12179f;
#using script_7cfaa6fd841fb4dd;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\radiation;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;

#namespace namespace_210ed44cfcc32348;

// Namespace namespace_210ed44cfcc32348 / namespace_e35b3aa0fd6626d4
// Params 0
// Checksum 0x0, Offset: 0x1aa
// Size: 0x137
function init()
{
    foreach ( var_70643c8580524236 in level.squaddata )
    {
        foreach ( squad in var_70643c8580524236 )
        {
            squad.var_c6c2e6d7497d13bc = 0;
            squad.properties[ "relicJournalAetherZombieKills" ] = 0;
        }
    }
    
    level.var_e5de9ebea3f6cf6f = [];
    
    if ( isdefined( level.aether_storm ) && isdefined( level.aether_storm.radiation ) )
    {
        level.aether_storm.radiation callback::add( "player_entered_radiation", &function_f4df458e2841cbf1 );
        level.aether_storm.radiation callback::add( "player_exited_radiation", &function_38b3b1600f7440b1 );
        return;
    }
    
    println( "<dev string:x1c>" );
}

// Namespace namespace_210ed44cfcc32348 / namespace_e35b3aa0fd6626d4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e9
// Size: 0x7b
function private function_f4df458e2841cbf1( params )
{
    player = params.player;
    
    if ( isdefined( player ) )
    {
        if ( level.var_e5de9ebea3f6cf6f.size == 0 )
        {
            level callback::add( "on_zombie_ai_killed", &function_39ca08d93892ca74 );
            
            /#
                if ( getdvarint( @"hash_9a839e4c50b45b13", 0 ) )
                {
                    thread function_160aa80fac8de160();
                }
            #/
        }
        
        level.var_e5de9ebea3f6cf6f[ level.var_e5de9ebea3f6cf6f.size ] = player;
    }
}

// Namespace namespace_210ed44cfcc32348 / namespace_e35b3aa0fd6626d4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x36c
// Size: 0x61
function private function_38b3b1600f7440b1( params )
{
    player = params.player;
    
    if ( isdefined( player ) )
    {
        level.var_e5de9ebea3f6cf6f = array_remove( level.var_e5de9ebea3f6cf6f, player );
        
        if ( level.var_e5de9ebea3f6cf6f.size == 0 )
        {
            level callback::remove( "on_zombie_ai_killed", &function_39ca08d93892ca74 );
        }
    }
}

// Namespace namespace_210ed44cfcc32348 / namespace_e35b3aa0fd6626d4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3d5
// Size: 0x1f5
function private function_39ca08d93892ca74( params )
{
    if ( !( isdefined( params.eattacker ) && isdefined( params.smeansofdeath ) && isdefined( params ) && isdefined( self ) ) || params.smeansofdeath == "MOD_SUICIDE" )
    {
        return;
    }
    
    if ( level.aether_storm.radiation radiation::function_1b4f63fa623de69a( self.origin ) )
    {
        playerattacker = namespace_64135de19550f047::function_3bd4148272ae66ee( params );
        
        if ( isdefined( playerattacker ) && isplayer( playerattacker ) && array_contains( level.var_e5de9ebea3f6cf6f, playerattacker ) && isdefined( playerattacker.team ) && isdefined( playerattacker.sessionsquadid ) )
        {
            playersquad = level.squaddata[ playerattacker.team ][ playerattacker.sessionsquadid ];
            
            if ( isdefined( playersquad ) && !istrue( playersquad.var_c6c2e6d7497d13bc ) )
            {
                if ( !isdefined( playersquad.properties[ "relicJournalAetherZombieKills" ] ) )
                {
                    playersquad.properties[ "relicJournalAetherZombieKills" ] = 0;
                }
                
                playersquad.properties[ "relicJournalAetherZombieKills" ] = playersquad.properties[ "relicJournalAetherZombieKills" ] + 1;
                
                if ( playersquad.properties[ "relicJournalAetherZombieKills" ] >= getdvarint( @"hash_96441e2c35f98774", 50 ) )
                {
                    if ( namespace_362cfff5d79f8b9b::function_95ec56461198f3f9( playerattacker ) )
                    {
                        playersquad.var_c6c2e6d7497d13bc = 1;
                        namespace_fc89f9b99b72df11::function_65e52fad2bce952c( playerattacker, "ob_jup_hydro_obelisk_reward_journal_s3", self.origin );
                        a_players = playerattacker scripts\cp_mp\utility\squad_utility::getsquadmembers();
                        thread scripts\cp_mp\overlord::playevent( "RFT_S3_5_RGUQ_Whispers_Journal", a_players, 3 );
                        return;
                    }
                    
                    println( "<dev string:xb4>" + playersquad.index + "<dev string:xec>" + playerattacker.name );
                }
            }
        }
    }
}

/#

    // Namespace namespace_210ed44cfcc32348 / namespace_e35b3aa0fd6626d4
    // Params 1
    // Checksum 0x0, Offset: 0x5d2
    // Size: 0x75, Type: dev
    function function_26a0f86f43115971( msg )
    {
        if ( !isdefined( level.var_c5a377eb736e9ed6 ) )
        {
            level.var_c5a377eb736e9ed6 = 0;
        }
        
        x = 10;
        y = 550;
        y += level.var_c5a377eb736e9ed6 * 15;
        printtoscreen2d( x, y, msg, ( 1, 1, 1 ), 1.5 );
        level.var_c5a377eb736e9ed6++;
    }

    // Namespace namespace_210ed44cfcc32348 / namespace_e35b3aa0fd6626d4
    // Params 0
    // Checksum 0x0, Offset: 0x64f
    // Size: 0xf, Type: dev
    function function_5e56e1a37898b0f5()
    {
        level.var_c5a377eb736e9ed6 = 0;
    }

    // Namespace namespace_210ed44cfcc32348 / namespace_e35b3aa0fd6626d4
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x666
    // Size: 0x141, Type: dev
    function private function_160aa80fac8de160()
    {
        level notify( "<dev string:x151>" );
        level endon( "<dev string:x151>" );
        level endon( "<dev string:x16e>" );
        
        while ( true )
        {
            waitframe();
            
            foreach ( var_70643c8580524236 in level.squaddata )
            {
                foreach ( squad in var_70643c8580524236 )
                {
                    if ( isdefined( squad.properties ) && isdefined( squad.index ) && isdefined( squad ) && isdefined( squad.properties[ "<dev string:x17c>" ] ) && !istrue( squad.var_c6c2e6d7497d13bc ) )
                    {
                        function_26a0f86f43115971( "<dev string:x19d>" + squad.index + "<dev string:x1a8>" + squad.properties[ "<dev string:x17c>" ] );
                    }
                }
            }
            
            function_5e56e1a37898b0f5();
            
            if ( level.var_e5de9ebea3f6cf6f.size <= 0 )
            {
                return;
            }
        }
    }

#/
