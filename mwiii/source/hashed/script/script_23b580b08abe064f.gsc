#using script_16ea1b94f0f381b3;
#using script_4a8c20678bd6a83e;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_504823b673542849;

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0
// Checksum 0x0, Offset: 0x2f7
// Size: 0x21
function function_c1fd3bf3e4513334()
{
    callback::add( "on_turned", &function_64a75defc092d1be );
    self function_3e89eb3d8e3f1811( "howl_after_pet_end", 1 );
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 2
// Checksum 0x0, Offset: 0x320
// Size: 0xb4
function function_26c99e23305fecac( playerowner, var_afe6f9511d9e590b )
{
    self function_3e89eb3d8e3f1811( "howl_after_pet_end", 0 );
    self function_3e89eb3d8e3f1811( "petting", 0 );
    
    if ( isdefined( self.var_ec1d59ad9332c4c3 ) )
    {
        self [[ self.var_ec1d59ad9332c4c3 ]]( var_afe6f9511d9e590b );
    }
    
    self.var_873d30685528d962 = 1;
    self.teleportcooldown = 10;
    self.reviving = 0;
    self.var_66c1831357048c02 = playerowner;
    playerowner.var_c5668dcaf32afbc3 = self;
    thread function_5b71b171ed50f326();
    thread function_27c9ebb4af736006();
    thread function_26f5f93128b0642f();
    thread function_184370e14bf6a316();
    thread function_a451c9ae8b6105ce();
    thread function_e8f6a314663565f( 90000 );
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3dc
// Size: 0x21c
function private function_a451c9ae8b6105ce()
{
    level endon( "game_ended" );
    self endon( "death" );
    wait 1;
    wait_time = 1;
    
    while ( isalive( self ) )
    {
        if ( istrue( self.reviving ) )
        {
            wait 2;
            continue;
        }
        
        if ( istrue( self.var_66c1831357048c02.var_68b9486f4adbcb62 ) )
        {
            function_e5201af67a21f629();
            waitframe();
            continue;
        }
        
        if ( distancesquared( self.var_66c1831357048c02.origin, self.origin ) >= 9000000 && self.teleportcooldown >= 10 && !istrue( self.var_66c1831357048c02.inlaststand ) )
        {
            function_69e98977aca657e7( self.var_66c1831357048c02.origin, 1 );
            continue;
        }
        
        isincombat = !function_bcf99cead7fd579a();
        
        if ( isincombat )
        {
            if ( istrue( self.petting ) && !istrue( self.var_c0491665294e07c2 ) )
            {
                function_abc58c43845184a4();
            }
            
            if ( distancesquared( self.var_66c1831357048c02.origin, self.origin ) > squared( 950 ) )
            {
                function_6226a01fb62f39fd( self.var_66c1831357048c02, 2304, 9000000, 10, 150, 0, 1 );
            }
        }
        else if ( isdefined( self.var_66c1831357048c02 ) )
        {
            var_250eb90971f4acef = !istrue( self.petting );
            
            if ( distancesquared( self.var_66c1831357048c02.origin, self.origin ) > 90000 )
            {
                if ( istrue( self.petting ) )
                {
                    function_abc58c43845184a4();
                }
                
                var_250eb90971f4acef = function_6226a01fb62f39fd( self.var_66c1831357048c02, 2304, 9000000, 10, 150, 0, 1 );
            }
            
            if ( var_250eb90971f4acef && function_4789a6e283cc98dd( self.var_66c1831357048c02 ) )
            {
                thread function_f7a749e1a7456e2e();
            }
        }
        
        wait_time = ter_op( istrue( self.petting ), 0.1, 1 );
        wait wait_time;
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x600
// Size: 0x12b
function private function_e5201af67a21f629()
{
    self endon( "death" );
    player = self.var_66c1831357048c02;
    
    if ( isalive( player ) )
    {
        player endon( "endon_enter_walkable_vehicle" );
        player endon( "death_or_disconnect" );
    }
    
    if ( isdefined( player.var_cac91eb6521df629 ) && isdefined( player.var_cac91eb6521df629.s_exfil ) )
    {
        player.var_cac91eb6521df629.s_exfil waittill( "exfil_complete_timeout" );
        var_576f57af0204c38c = player.var_cac91eb6521df629;
        
        if ( isdefined( var_576f57af0204c38c ) )
        {
            forward_angles = anglestoforward( var_576f57af0204c38c.angles );
            backward_angles = invertangles( forward_angles );
            teleport_origin = backward_angles * 1200 + var_576f57af0204c38c.origin;
            function_69e98977aca657e7( teleport_origin, 1 );
            function_a55b3d6929d24cf7( self.origin, 2 );
            thread function_c4f0666404a900a5();
            thread function_ae008672aa696b2();
            player waittill_notify_or_timeout( "exfil_fully_completed", 20 );
            
            if ( isalive( self ) )
            {
                function_e3952036dafb66ee();
                self kill();
            }
        }
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x733
// Size: 0x47
function private function_ae008672aa696b2()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "pet_finished" );
    thread animscripted_sharedfunc( "howl", "howl" );
    self setscriptablepartstate( "heal_audio", "on" );
    wait 1.75;
    scripts\asm\asm_bb::bb_clearanimscripted();
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x782
// Size: 0x21
function private function_f2568da6059fa9fd()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "interrupt_heal_watcher" );
    wait 8;
    function_a24abf4ff57b54d5();
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7ab
// Size: 0x4a
function private function_27c9ebb4af736006()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "damage" );
        
        if ( utility::ent_flag( "healing" ) )
        {
            utility::ent_flag_clear( "healing" );
        }
        
        self notify( "interrupt_heal_watcher" );
        thread function_f2568da6059fa9fd();
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7fd
// Size: 0x9a
function private function_a24abf4ff57b54d5()
{
    level endon( "game_ended" );
    self endon( "death" );
    utility::ent_flag_set( "healing" );
    
    while ( utility::ent_flag( "healing" ) )
    {
        if ( self.health >= self.maxhealth )
        {
            utility::ent_flag_clear( "healing" );
            return;
        }
        
        var_e186dac33588e6d6 = int( self.maxhealth * 0.005 );
        self.health = int( min( self.maxhealth, self.health + var_e186dac33588e6d6 ) );
        wait 1;
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x89f
// Size: 0x3a
function private function_26f5f93128b0642f()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "melee_started" );
        
        if ( isdefined( self.var_e6e13802782ceaf1 ) )
        {
            self [[ self.var_e6e13802782ceaf1 ]]();
        }
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8e1
// Size: 0x154
function private function_184370e14bf6a316()
{
    level endon( "game_ended" );
    self endon( "death" );
    player = self.var_66c1831357048c02;
    
    if ( isdefined( player ) )
    {
        player endon( "death_or_disconnect" );
        
        while ( true )
        {
            playerteam = player.team;
            playersquadindex = player.sessionsquadid;
            
            if ( isdefined( level.squaddata[ playerteam ][ playersquadindex ] ) && isdefined( level.squaddata[ playerteam ] ) && isdefined( playersquadindex ) && isdefined( playerteam ) && isdefined( level.squaddata[ playerteam ][ playersquadindex ].players ) )
            {
                squadmembers = level.squaddata[ playerteam ][ playersquadindex ].players;
                
                foreach ( member in squadmembers )
                {
                    if ( isdefined( member ) && isalive( member ) )
                    {
                        if ( istrue( member.inlaststand ) && !self.reviving )
                        {
                            function_a702b5b69e54f6cf( member );
                            function_e3952036dafb66ee();
                            self.reviving = 0;
                        }
                    }
                }
            }
            
            wait 1;
        }
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa3d
// Size: 0x21a
function private function_a702b5b69e54f6cf( player )
{
    level endon( "game_ended" );
    self endon( "death" );
    player endon( "death_or_disconnect" );
    self.reviving = 1;
    wait 7;
    
    if ( distancesquared( self.origin, player.origin ) >= 90000 )
    {
        safeorigin = function_3d10829b418c916a( player, 150 );
        
        if ( isdefined( safeorigin ) )
        {
            self forceteleport( safeorigin );
        }
    }
    
    target = player.origin - self.origin;
    target = vectornormalize( target );
    angles = vectortoangles( target );
    self orientmode( "face angle", angles[ 1 ] );
    function_a55b3d6929d24cf7( self.origin, 2 );
    wait 0.5;
    thread function_ae008672aa696b2();
    wait 1.25;
    playerteam = player.team;
    playersquadindex = player.sessionsquadid;
    squadmembers = level.squaddata[ playerteam ][ playersquadindex ].players;
    var_7fc3c3cd6283f65 = 0;
    
    foreach ( member in squadmembers )
    {
        if ( istrue( member.inlaststand ) )
        {
            var_7fc3c3cd6283f65 = 1;
        }
    }
    
    if ( isdefined( self.var_f781c4947731680f ) && var_7fc3c3cd6283f65 )
    {
        var_8d360565dbd4f5b9 = int( self.health / 3 );
        
        foreach ( member in squadmembers )
        {
            member [[ self.var_f781c4947731680f ]]();
        }
        
        self dodamage( var_8d360565dbd4f5b9, self.origin );
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc5f
// Size: 0x46
function private function_bcf99cead7fd579a()
{
    self._blackboard.var_251120dcdbc22230 = !isalive( self.enemy ) && !isdefined( self.target_attractor );
    return self._blackboard.var_251120dcdbc22230;
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xcae
// Size: 0x40
function private function_64a75defc092d1be( attacker )
{
    if ( self.zombieaisettings.var_e58a65b7a8f5973c.var_3f7fe68fbd23ce9b )
    {
        self function_3e89eb3d8e3f1811( "petting", 0 );
        thread function_23d7a8eb0f1925c9();
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xcf6
// Size: 0xbf
function private function_23d7a8eb0f1925c9()
{
    level endon( "game_ended" );
    self endon( "death" );
    wait 1;
    wait_time = 1;
    
    while ( isalive( self ) )
    {
        isincombat = !function_bcf99cead7fd579a();
        
        if ( isincombat )
        {
            if ( istrue( self.petting ) && !istrue( self.var_c0491665294e07c2 ) )
            {
                function_abc58c43845184a4();
            }
        }
        else if ( !istrue( self.petting ) )
        {
            player = function_85340538f36a13f4();
            
            if ( isdefined( player ) )
            {
                if ( function_4789a6e283cc98dd( player ) )
                {
                    thread function_aba900527b608de3();
                }
            }
        }
        
        wait_time = ter_op( istrue( self.petting ), 0.1, 1 );
        wait wait_time;
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xdbd
// Size: 0x225
function private function_85340538f36a13f4()
{
    level endon( "game_ended" );
    self endon( "death" );
    self.var_f79f774d8b98ab5 = self._blackboard.movetype;
    function_f1e5805da192a1ef( "run", "turned", 25 );
    closestplayer = function_874f6b6d8f270d36();
    
    if ( !isplayer( closestplayer ) )
    {
        return undefined;
    }
    
    self clearbtgoal( 2 );
    
    if ( distancesquared( closestplayer.origin, self.origin ) > 90000 )
    {
        safeorigin = function_3d10829b418c916a( closestplayer, 150 );
        
        if ( isdefined( safeorigin ) )
        {
            self clearpath();
            function_a55b3d6929d24cf7( safeorigin, 2 );
            var_95b51daa0fb10c76 = closestplayer.origin;
            reached_goal = 0;
            waitframe();
            
            while ( true )
            {
                if ( !isdefined( self ) )
                {
                    return undefined;
                }
                
                if ( isdefined( self.enemy ) )
                {
                    function_e3952036dafb66ee();
                    return undefined;
                }
                
                if ( !isalive( closestplayer ) || istrue( closestplayer.inlaststand ) )
                {
                    function_e3952036dafb66ee();
                    self clearpath();
                    return undefined;
                }
                
                if ( !isdefined( self.goalpos ) || self function_1fde453596ea559c() > 2000 )
                {
                    function_e3952036dafb66ee();
                    self clearpath();
                    return undefined;
                }
                
                if ( !is_traversing() && isdefined( self.goalpos ) && distancesquared( self.goalpos, safeorigin ) > 1024 )
                {
                    self clearpath();
                    function_a55b3d6929d24cf7( safeorigin, 2 );
                    waitframe();
                    continue;
                }
                
                if ( distancesquared( closestplayer.origin, var_95b51daa0fb10c76 ) > 2304 )
                {
                    safeorigin = function_3d10829b418c916a( closestplayer, 150 );
                    var_95b51daa0fb10c76 = closestplayer.origin;
                    
                    if ( isdefined( safeorigin ) )
                    {
                        self clearpath();
                        function_a55b3d6929d24cf7( safeorigin, 2 );
                        waitframe();
                        continue;
                    }
                }
                
                if ( distancesquared( self.goalpos, self.origin ) < 2304 )
                {
                    reached_goal = 1;
                }
                
                if ( reached_goal && !is_traversing() )
                {
                    function_e3952036dafb66ee();
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    self notify( "hellhound_pet_player_reached" );
    self clearpath();
    return closestplayer;
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xfeb
// Size: 0xbb, Type: bool
function private function_4789a6e283cc98dd( closestplayer )
{
    if ( !isalive( closestplayer ) || istrue( closestplayer.inlaststand ) )
    {
        return false;
    }
    
    self clearbtgoal( 2 );
    startpos = self.origin + ( 0, 0, 20 );
    delta = anglestoforward( self.angles ) * 100;
    endpos = startpos + delta;
    self clearpath();
    self function_3e89eb3d8e3f1811( "petting", 1 );
    self.petting = 1;
    thread function_14783c5979c54098();
    
    if ( !isdefined( self.pet_interact ) )
    {
        function_4f90b294939876d3( 3 );
    }
    
    return true;
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10af
// Size: 0xc2
function private function_4f90b294939876d3( time )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "pet_finished" );
    wait time;
    
    if ( isalive( self ) )
    {
        self.pet_interact = scripts\cp_mp\interaction::register_interact( self.origin + ( 0, 0, 32 ), 72, &function_7151d0b626361435 );
        self.pet_interact scripts\cp_mp\interaction::function_e6c63f16f2258b80( &function_17c166afefd3d251 );
        self.pet_interact linkto( self, "tag_origin", ( 0, 0, 32 ), ( 0, 0, 0 ) );
        thread delete_on_death( self.pet_interact );
        self.pet_interact.dog = self;
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1179
// Size: 0x90
function private function_c4f0666404a900a5()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "pet_finished" );
    
    while ( true )
    {
        if ( !istrue( self.var_c0491665294e07c2 ) )
        {
            if ( isdefined( self.var_66c1831357048c02 ) )
            {
                target = self.var_66c1831357048c02.origin - self.origin;
                target = vectornormalize( target );
                angles = vectortoangles( target );
                self orientmode( "face angle", angles[ 1 ] );
            }
        }
        
        wait 0.2;
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1211
// Size: 0x94
function private function_14783c5979c54098()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "pet_finished" );
    
    while ( true )
    {
        if ( !istrue( self.var_c0491665294e07c2 ) )
        {
            closestplayer = function_874f6b6d8f270d36();
            
            if ( isplayer( closestplayer ) )
            {
                target = closestplayer.origin - self.origin;
                target = vectornormalize( target );
                angles = vectortoangles( target );
                self orientmode( "face angle", angles[ 1 ] );
            }
        }
        
        wait 0.2;
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0
// Checksum 0x0, Offset: 0x12ad
// Size: 0x9d
function function_874f6b6d8f270d36()
{
    alive_players = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !istrue( player.inlaststand ) )
        {
            alive_players[ alive_players.size ] = player;
        }
    }
    
    sortedplayers = sortbydistance( alive_players, self.origin );
    
    if ( sortedplayers.size == 0 )
    {
        return undefined;
    }
    
    return sortedplayers[ 0 ];
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1353
// Size: 0x45
function private function_f7a749e1a7456e2e()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "pet_finished" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        closestplayer = function_874f6b6d8f270d36();
        
        if ( !isplayer( closestplayer ) )
        {
            return undefined;
        }
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x13a0
// Size: 0x6e
function private function_aba900527b608de3()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "pet_finished" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        closestplayer = function_874f6b6d8f270d36();
        
        if ( !isplayer( closestplayer ) )
        {
            return undefined;
        }
        
        if ( distancesquared( closestplayer.origin, self.origin ) > 90000 )
        {
            function_abc58c43845184a4();
        }
    }
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1416
// Size: 0x6b
function private function_abc58c43845184a4()
{
    if ( isdefined( self.pet_interact ) )
    {
        self.pet_interact delete();
    }
    
    if ( isdefined( self.var_f79f774d8b98ab5 ) )
    {
        function_f1e5805da192a1ef( self.var_f79f774d8b98ab5, "turned", 25 );
        self.var_f79f774d8b98ab5 = undefined;
    }
    
    self function_3e89eb3d8e3f1811( "petting", 0 );
    self.petting = undefined;
    self notify( "pet_finished" );
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1489
// Size: 0x82
function private function_17c166afefd3d251( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( !usable function_346f7b532795056( player ) )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        
        return { #string:&"AI/HELLHOUND_PET_HINT", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1514
// Size: 0xc1, Type: bool
function private function_346f7b532795056( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( !isalive( self.dog ) )
    {
        return false;
    }
    
    if ( istrue( player.inlaststand ) )
    {
        return false;
    }
    
    if ( player isreloading() || player isgestureplaying() || player isviewmodelanimplaying() || !isnullweapon( player.highpriorityweapon ) )
    {
        return false;
    }
    
    var_ecda331f05eeae03 = self.dog gettagorigin( "tag_player" );
    ground_pos = getgroundposition( var_ecda331f05eeae03, 15 );
    
    if ( ground_pos[ 2 ] - var_ecda331f05eeae03[ 2 ] > 5 || var_ecda331f05eeae03[ 2 ] - ground_pos[ 2 ] > 8 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 1
// Checksum 0x0, Offset: 0x15de
// Size: 0x3f
function function_7151d0b626361435( player )
{
    if ( !function_346f7b532795056( player ) )
    {
        return;
    }
    
    self.dog function_3e89eb3d8e3f1811( "pet_interact", 1 );
    player thread function_87ddf2d17f5d6db2( self.dog, self );
}

// Namespace namespace_504823b673542849 / namespace_99b160f0b52a4db
// Params 2
// Checksum 0x0, Offset: 0x1625
// Size: 0x243
function function_87ddf2d17f5d6db2( dog, interact )
{
    level endon( "game_ended" );
    interact disableplayeruseforallplayers();
    dog.var_c0491665294e07c2 = 1;
    cinematic_ent = utility::spawn_model( "tag_origin", dog gettagorigin( "tag_player" ), ( 0, 180, 0 ) );
    cinematic_ent linkto( dog, "tag_player", ( 0, 0, 0 ), ( 0, 180, 0 ) );
    var_bb4c9aa220c64019 = vectornormalize( dog.origin - self.origin );
    nearbyai = getplayersandaiarrayinradius( dog.origin, 100 );
    
    foreach ( ai in nearbyai )
    {
        if ( isplayer( ai ) && vectordot( vectornormalize( ai.origin - self.origin ), var_bb4c9aa220c64019 ) > 0.5 && ai != self )
        {
            ai knockback( vectornormalize( ai.origin - self.origin ), 550 );
        }
    }
    
    self setstance( "stand" );
    self playerlinktoblend( cinematic_ent, "tag_origin", 0.1, 0.1, 0.05 );
    self freezecontrols( 1 );
    time = self playviewmodelanim( "jup_con_van_pet_vm" );
    time *= 0.001;
    self playanimscriptsceneevent( "scripted_scene", "jup_zm_con_dog_pet" );
    cinematic_ent delaycall( 0.05, &unlink );
    callback::callback( "on_hellhound_petted", { #dog:dog } );
    dog waittill_notify_or_timeout( "death", time );
    
    if ( isdefined( self ) )
    {
        self freezecontrols( 0 );
        self unlink();
    }
    
    if ( isdefined( cinematic_ent ) )
    {
        cinematic_ent delete();
    }
    
    if ( isdefined( dog ) )
    {
        dog.var_c0491665294e07c2 = undefined;
    }
    
    if ( isdefined( interact ) )
    {
        interact enableplayeruseforallplayers();
    }
}

