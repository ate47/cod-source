#using script_41387eecc35b88bf;
#using script_638d701d263ee1ed;
#using script_7cfaa6fd841fb4dd;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\throttle;
#using scripts\engine\utility;

#namespace ob_achievements;

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 0
// Checksum 0x0, Offset: 0x3b1
// Size: 0x125
function init()
{
    callback::add( "on_ai_killed", &on_ai_killed );
    callback::add( "ob_exfil_success", &ob_exfil_success );
    callback::add( "zm_perk_obtained", &function_d46f3d95c0a6c68e );
    callback::add( "on_tombstone_used_cache", &on_tombstone_used_cache );
    callback::add( "player_revived", &on_player_revived );
    callback::add( "player_team_revived", &on_player_revived );
    callback::add( #"hash_83238eee27237eeb", &on_player_revived );
    callback::add( "on_hellhound_petted", &on_hellhound_petted );
    callback::add( "ob_act3_completed", &ob_act3_completed );
    callback::add( "ActivitySuccess", &function_618308f7a88d3d10 );
    level.var_b9d0664093495a01 = getdvarint( @"hash_43d8974a0ee14c9f", 1 );
    level.var_b2be94493bac612e = getdvarfloat( @"hash_6610d94e63d88554", 1 );
    
    if ( istrue( level.var_b9d0664093495a01 ) )
    {
        callback::add( "player_connect", &on_player_connect );
    }
    
    level.var_9e70fbe6be476d54 = throttle::throttle_initialize( "ob_achievements", 2 );
    
    /#
        level thread function_c9e6fc61ad0c665f();
    #/
}

/#

    // Namespace ob_achievements / namespace_15c1ca6387c6a341
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4de
    // Size: 0x1a8, Type: dev
    function private function_c9e6fc61ad0c665f()
    {
        var_f041094a76e3b231 = [ "<dev string:x1c>", "<dev string:x34>", "<dev string:x4e>", "<dev string:x62>", "<dev string:x77>", "<dev string:x91>", "<dev string:xa4>", "<dev string:xbc>", "<dev string:xd1>", "<dev string:xe5>", "<dev string:xfe>", "<dev string:x10f>", "<dev string:x122>" ];
        devgui::function_6e7290c8ee4f558b( "<dev string:x13c>" );
        
        foreach ( var_45191fa57864b212 in var_f041094a76e3b231 )
        {
            n_required = function_a08380cd8b1316e5( var_45191fa57864b212 );
            
            if ( isdefined( n_required ) )
            {
                var_cbbc62a23ead5290 = "<dev string:x15a>" + var_45191fa57864b212;
                devgui::function_b23a59dfb4ca49a1( var_45191fa57864b212, var_cbbc62a23ead5290, &function_e07c698369eb6f3e );
            }
        }
        
        devgui::function_fe953f000498048f();
        devgui::function_6e7290c8ee4f558b( "<dev string:x177>" );
        
        foreach ( var_45191fa57864b212 in var_f041094a76e3b231 )
        {
            n_required = function_a08380cd8b1316e5( var_45191fa57864b212 );
            
            if ( isdefined( n_required ) )
            {
                var_8d08f244175aa0ac = "<dev string:x194>" + var_45191fa57864b212 + "<dev string:x1b0>" + n_required;
            }
            else
            {
                var_8d08f244175aa0ac = "<dev string:x194>" + var_45191fa57864b212;
            }
            
            devgui::function_b23a59dfb4ca49a1( var_45191fa57864b212, var_8d08f244175aa0ac, &function_f497beeb72b05f82 );
        }
        
        devgui::function_fe953f000498048f();
    }

    // Namespace ob_achievements / namespace_15c1ca6387c6a341
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x68e
    // Size: 0x61, Type: dev
    function private function_e07c698369eb6f3e( params )
    {
        var_45191fa57864b212 = params[ 0 ];
        n_increment = params[ 1 ];
        n_required = function_a08380cd8b1316e5( var_45191fa57864b212 );
        
        if ( isdefined( n_required ) && n_required > 1 )
        {
            level.players[ 0 ] function_82b80153d3189adc( var_45191fa57864b212, 1, 1, n_required );
        }
    }

    // Namespace ob_achievements / namespace_15c1ca6387c6a341
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x6f7
    // Size: 0x72, Type: dev
    function private function_f497beeb72b05f82( params )
    {
        var_45191fa57864b212 = params[ 0 ];
        n_required = params[ 1 ];
        
        if ( isdefined( n_required ) )
        {
            n_required = int( n_required );
        }
        
        if ( isdefined( n_required ) && n_required > 1 )
        {
            level.players[ 0 ] function_82b80153d3189adc( var_45191fa57864b212, 1, n_required, n_required );
            return;
        }
        
        level.players[ 0 ] function_82b80153d3189adc( var_45191fa57864b212 );
    }

#/

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x771
// Size: 0xd9
function private function_a08380cd8b1316e5( var_45191fa57864b212 )
{
    switch ( var_45191fa57864b212 )
    {
        case #"hash_c668de0e0aa7b10b":
            break;
        case #"hash_19ef00f30250a013":
            break;
        case #"hash_6e9a2470687663d3":
            break;
        case #"hash_7651423ef91c37d3":
            break;
        case #"hash_575532a7b068d9cb":
            break;
        case #"hash_313cf9d5eb4cd33d":
            return 20;
        case #"hash_b50213bb983d6f05":
            break;
        case #"hash_90cba3b822c4768f":
            break;
        case #"hash_52522f4303268b93":
            break;
        case #"hash_678e72fa0bb96fba":
            return 50000;
        case #"hash_3c317b7614468e55":
            break;
        case #"hash_b8a06661976052bd":
            return 500;
        case #"hash_27bde0f50a43f4b0":
            break;
    }
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x852
// Size: 0x4e
function private ob_act3_completed( params )
{
    function_82b80153d3189adc( "jup_ob_theend" );
    var_c9b69aecc5c631ed = scripts\cp_mp\utility\squad_utility::getsquadmembers();
    
    if ( var_c9b69aecc5c631ed.size >= 6 || level.players.size >= 6 )
    {
        function_82b80153d3189adc( "jup_ob_oneagainstall" );
    }
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8a8
// Size: 0x11c
function private function_618308f7a88d3d10( params )
{
    activity = self;
    playerlist = params.playerlist;
    
    if ( isdefined( playerlist ) && isdefined( activity ) && isdefined( activity.category ) && activity.category == "Contract" )
    {
        foreach ( player in playerlist )
        {
            player function_82b80153d3189adc( "jup_ob_hiredgun", 1, 1, 20 );
            str_difficulty = namespace_4df2ab39b0e96ec7::function_4d8bb2d866771a10( player.origin );
            
            if ( str_difficulty == "difficulty_hard" )
            {
                if ( !isdefined( player.var_5c45109a6a105ff4 ) )
                {
                    player.var_5c45109a6a105ff4 = 0;
                }
                
                player.var_5c45109a6a105ff4++;
                
                if ( player.var_5c45109a6a105ff4 == 5 )
                {
                    player function_82b80153d3189adc( "jup_ob_seeingred" );
                }
            }
        }
    }
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9cc
// Size: 0x6d
function private function_386de0e32b56c00d( var_45191fa57864b212 )
{
    if ( istrue( level.var_b9d0664093495a01 ) )
    {
        if ( !isdefined( self.var_9a27e17e83d266c8 ) )
        {
            self.var_9a27e17e83d266c8 = [];
        }
        
        if ( !isdefined( self.var_9a27e17e83d266c8[ var_45191fa57864b212 ] ) )
        {
            self.var_9a27e17e83d266c8[ var_45191fa57864b212 ] = 0;
        }
        
        self.var_9a27e17e83d266c8[ var_45191fa57864b212 ]++;
        return;
    }
    
    function_82b80153d3189adc( var_45191fa57864b212, 1, 1, function_a08380cd8b1316e5( var_45191fa57864b212 ) );
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa41
// Size: 0x9f
function private on_player_connect( params )
{
    self endon( "disconnect" );
    self.var_9a27e17e83d266c8 = [];
    
    while ( true )
    {
        foreach ( var_45191fa57864b212, n_kill_count in self.var_9a27e17e83d266c8 )
        {
            if ( n_kill_count > 0 )
            {
                function_82b80153d3189adc( var_45191fa57864b212, 1, n_kill_count, function_a08380cd8b1316e5( var_45191fa57864b212 ) );
                self.var_9a27e17e83d266c8[ var_45191fa57864b212 ] = 0;
            }
        }
        
        wait level.var_b2be94493bac612e;
    }
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xae8
// Size: 0x17
function private on_hellhound_petted( params )
{
    function_82b80153d3189adc( "jup_ob_youcanpetthedog" );
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb07
// Size: 0x6b
function private on_player_revived( params )
{
    reviver = params.reviver;
    
    if ( isplayer( reviver ) )
    {
        a_squad = reviver scripts\cp_mp\utility\squad_utility::getsquadmembers();
        
        if ( !arraycontains( a_squad, self ) && self != reviver || istrue( params.var_26ac2a3a59347b9e ) )
        {
            reviver function_82b80153d3189adc( "jup_ob_helpfulstranger" );
        }
    }
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb7a
// Size: 0x17
function private on_tombstone_used_cache( params )
{
    function_82b80153d3189adc( "jup_ob_backfromthedead" );
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb99
// Size: 0x27
function private function_d46f3d95c0a6c68e( params )
{
    if ( self.perks_active.size == 9 )
    {
        function_82b80153d3189adc( "jup_ob_perkaholic" );
    }
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xbc8
// Size: 0x17
function private ob_exfil_success( params )
{
    function_82b80153d3189adc( "jup_ob_andsoitbegins" );
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xbe7
// Size: 0x27f
function private on_ai_killed( params )
{
    player = params.eattacker;
    
    if ( isdefined( player ) && !isplayer( player ) && isplayer( player.owner ) )
    {
        player = player.owner;
    }
    
    if ( isdefined( self ) && isdefined( self.kiastring ) && self.kiastring == "warlord_kia" && !isplayer( player ) )
    {
        player = namespace_64135de19550f047::function_3bd4148272ae66ee( params );
    }
    
    if ( isplayer( player ) )
    {
        player function_386de0e32b56c00d( "jup_ob_slaughterhouse" );
        currentweapon = params.sweapon;
        
        if ( player common_inventory::function_852cd6dd29c274bd( currentweapon ) )
        {
            player function_386de0e32b56c00d( "jup_ob_writeoff" );
        }
        
        if ( isdefined( params.einflictor ) && params.einflictor scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            if ( !isdefined( player.var_b0980987caa20fe4 ) )
            {
                player.var_b0980987caa20fe4 = 0;
            }
            
            player.var_b0980987caa20fe4++;
            
            if ( player.var_b0980987caa20fe4 == 100 )
            {
                player function_82b80153d3189adc( "jup_ob_gravestone" );
            }
        }
        
        if ( isdefined( self.subclass ) )
        {
            if ( self.subclass == "zombie_deathworm" )
            {
                if ( isarray( self.var_21a8839dd03e31cd ) )
                {
                    foreach ( player in self.var_21a8839dd03e31cd )
                    {
                        if ( isplayer( player ) )
                        {
                            var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
                            
                            if ( var_c9b69aecc5c631ed.size >= 6 || var_c9b69aecc5c631ed.size >= getdvarint( @"hash_340b01b20673c44e", 6 ) )
                            {
                                player function_82b80153d3189adc( "jup_ob_oneagainstall" );
                            }
                        }
                    }
                }
                
                return;
            }
            
            if ( issubstr( self.subclass, "warlord" ) )
            {
                if ( isarray( self.var_21a8839dd03e31cd ) )
                {
                    foreach ( player in self.var_21a8839dd03e31cd )
                    {
                        if ( isplayer( player ) )
                        {
                            player function_82b80153d3189adc( "jup_ob_conqueror" );
                        }
                    }
                }
            }
        }
    }
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0xe6e
// Size: 0x38
function private function_82b80153d3189adc( var_45191fa57864b212, var_f9da27eee32186cd, n_increment, n_required )
{
    if ( !isdefined( var_f9da27eee32186cd ) )
    {
        var_f9da27eee32186cd = 0;
    }
    
    thread function_cd2135758f3d9f79( var_45191fa57864b212, var_f9da27eee32186cd, n_increment, n_required );
}

// Namespace ob_achievements / namespace_15c1ca6387c6a341
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0xeae
// Size: 0x147
function private function_cd2135758f3d9f79( var_45191fa57864b212, var_f9da27eee32186cd, n_increment, n_required )
{
    if ( !isdefined( var_f9da27eee32186cd ) )
    {
        var_f9da27eee32186cd = 0;
    }
    
    self endon( "disconnect" );
    
    if ( getdvarint( @"hash_53c8688bfb276373", 1 ) )
    {
        throttle::function_f632348cbb773537( level.var_9e70fbe6be476d54, self );
        
        if ( var_f9da27eee32186cd )
        {
            var_27bcd76455d26c2b = self getplayerdata( level.progressiongroup, var_45191fa57864b212 );
            var_29afdcc23a1e855f = var_27bcd76455d26c2b + n_increment;
            self setplayerdata( level.progressiongroup, var_45191fa57864b212, var_29afdcc23a1e855f );
            self function_6a369480dbaf1090( var_45191fa57864b212, var_29afdcc23a1e855f );
            var_5724a7d91348b937 = "==OB UpdateAchievementProgress " + var_45191fa57864b212 + ": " + var_29afdcc23a1e855f + " of " + n_required + " Required, by " + self.name;
            logstring( var_5724a7d91348b937 );
        }
        else
        {
            self giveachievement( var_45191fa57864b212 );
            var_436b70922a7eb005 = "==OB GiveAchievement " + var_45191fa57864b212 + " completed by " + self.name;
            logstring( var_436b70922a7eb005 );
        }
    }
    
    /#
        if ( getdvarint( @"hash_6ac2c4ff3a214246", 0 ) )
        {
            if ( var_f9da27eee32186cd && isdefined( var_5724a7d91348b937 ) )
            {
                iprintlnbold( var_5724a7d91348b937 );
                return;
            }
            
            if ( isdefined( var_436b70922a7eb005 ) )
            {
                iprintlnbold( var_436b70922a7eb005 );
            }
        }
    #/
}

