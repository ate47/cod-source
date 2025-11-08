#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace emp_debuff;

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0x562
// Size: 0x28
function emp_debuff_init()
{
    if ( issharedfuncdefined( "emp", "init" ) )
    {
        [[ getsharedfunc( "emp", "init" ) ]]();
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 3
// Checksum 0x0, Offset: 0x592
// Size: 0xe3
function function_662905d3b9455612( data, time, var_d5c235d554645bbc )
{
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    if ( !isdefined( time ) || time <= 0 )
    {
        time = 6;
    }
    
    var_ec826393f0c6fdb3 = 0;
    
    if ( istrue( var_d5c235d554645bbc ) && data.victim scripts\cp_mp\vehicles\vehicle::isvehicle() && data.victim function_7d6c1037f26ddb70() )
    {
        var_ec826393f0c6fdb3 = 1;
    }
    
    if ( var_ec826393f0c6fdb3 )
    {
        function_84ff119fbcaf315( data );
    }
    
    apply_emp_struct( data );
    function_1b1d64a1cc52aab5( data, time );
    
    if ( isdefined( data.victim ) )
    {
        if ( var_ec826393f0c6fdb3 )
        {
            function_9100acf46355b9c2( data );
        }
        else
        {
            data.victim remove_emp();
        }
        
        return;
    }
    
    if ( isdefined( data.var_51c985754e08a199 ) )
    {
        function_eb40c1291f724432( data );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0x67d
// Size: 0x51
function function_7d6c1037f26ddb70()
{
    if ( scripts\cp_mp\vehicles\vehicle::isvehiclekillstreak() )
    {
        if ( self.vehiclename == "pac_sentry" || self.vehiclename == "radar_drone_recon" || self.vehiclename == "assault_drone" )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 1;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x6d6
// Size: 0xa2
function function_9100acf46355b9c2( data )
{
    driver = data.var_51c985754e08a199;
    empcount = data.victim _get_emp_count();
    
    if ( istrue( data.var_9159d29edcddbf2e ) || empcount <= 1 || istrue( data.victim.isdestroyed ) )
    {
        data.victim clear_emp();
        
        if ( isdefined( driver ) )
        {
            function_eb40c1291f724432( data );
        }
        
        return;
    }
    
    data.victim remove_emp();
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x780
// Size: 0x2d
function function_eb40c1291f724432( data )
{
    data.var_51c985754e08a199 setclientomnvar( "ui_emp_button_combo_show", 0 );
    data.var_51c985754e08a199 = undefined;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x7b5
// Size: 0xf2
function function_84ff119fbcaf315( data )
{
    vehicle = data.victim;
    notifylist = [ "death", "buttonComboSuccess", "buttonComboReplaced", "buttonComboEarlyExit" ];
    
    if ( data.victim is_empd() )
    {
        function_9cdf5e46cecefb7f( data );
    }
    
    if ( isdefined( vehicle.helperdronetype ) )
    {
        notifylist = array_add( notifylist, "drone_exit" );
    }
    else if ( vehicle scripts\cp_mp\vehicles\vehicle::isvehiclekillstreak() && vehicle.vehiclename == "pac_sentry" )
    {
        notifylist = array_add( notifylist, "leaving_control" );
    }
    else
    {
        notifylist = function_ef4b3df86351aa00( notifylist, [ "vehicle_owner_update", "driver_exit" ], 0 );
        data.var_12482c5b5b258cdf = 1;
    }
    
    data thread function_70eaf1a1aca6a06c( notifylist );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x8af
// Size: 0x36
function function_9cdf5e46cecefb7f( data )
{
    level endon( "game_ended" );
    data.victim endon( "death" );
    data.victim notify( "buttonComboReplaced" );
    waitframe();
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x8ed
// Size: 0x11d
function function_70eaf1a1aca6a06c( notifylist )
{
    self.victim endon( "emp_cleared" );
    self.victim notify( "buttonComboStarted" );
    self.victim endon( "buttonComboStarted" );
    driver = undefined;
    
    if ( !istrue( self.var_12482c5b5b258cdf ) )
    {
        driver = self.victim.owner;
        driver endon( "disconnect" );
    }
    
    childthread function_d5ea7c13a646e507();
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( !isdefined( self.victim ) )
        {
            break;
        }
        
        if ( istrue( self.var_12482c5b5b258cdf ) || istrue( self.victim.ispiloted ) )
        {
            if ( istrue( self.var_12482c5b5b258cdf ) )
            {
                driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver( self.victim );
                
                if ( isdefined( driver ) )
                {
                    childthread function_3e29189f38a017d( self.victim, driver );
                }
            }
            
            if ( isdefined( driver ) )
            {
                shouldcontinue = function_bcda60626641c653( driver, notifylist );
                
                if ( !istrue( shouldcontinue ) )
                {
                    break;
                }
            }
            else
            {
                waitframe();
            }
            
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0xa12
// Size: 0xb7
function function_bcda60626641c653( driver, notifylist )
{
    self.var_51c985754e08a199 = driver;
    self.var_51c985754e08a199 setclientomnvar( "ui_emp_button_combo_show", 1 );
    childthread function_28045a145366e0c5();
    childthread function_f552430dc0f43d18( self.var_51c985754e08a199 );
    childthread function_e86117e40bd6ee1f();
    msg = self.victim waittill_any_in_array_return_no_endon_death( notifylist );
    
    if ( isdefined( self.var_51c985754e08a199 ) )
    {
        function_eb40c1291f724432( self );
    }
    
    if ( msg == "death" || msg == "buttonComboSuccess" || msg == "buttonComboReplaced" || msg == "buttonComboEarlyExit" )
    {
        return 0;
    }
    
    return 1;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0xad1
// Size: 0x29
function function_e86117e40bd6ee1f()
{
    level waittill_any_3( "game_ended", "round_end_finished", "start_game_ended" );
    self.victim notify( "buttonComboEarlyExit" );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0xb02
// Size: 0x5b
function function_28045a145366e0c5()
{
    maxduration = self.empdurationremaining;
    
    while ( true )
    {
        percentageleft = self.empdurationremaining / 6;
        
        if ( isdefined( self.var_51c985754e08a199 ) )
        {
            self.var_51c985754e08a199 setclientomnvar( "ui_emp_button_combo_duration", percentageleft );
        }
        
        waitframe();
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0xb65
// Size: 0x3e
function function_d5ea7c13a646e507()
{
    self.empdurationremaining = 6;
    
    while ( self.empdurationremaining > 0 )
    {
        self.empdurationremaining -= level.framedurationseconds;
        waitframe();
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0xbab
// Size: 0x40
function function_3e29189f38a017d( vehicle, driver )
{
    driver endon( "disconnect" );
    vehicle endon( "death" );
    driver waittill_any_3( "vehicle_seat_exit", "death", "killed_player" );
    vehicle notify( "driver_exit" );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0xbf3
// Size: 0x52
function function_1b1d64a1cc52aab5( data, time )
{
    data.victim endon( "death_or_disconnect" );
    level endon( "game_ended" );
    data.victim waittill_any_timeout_4( time, "emp_cleared", "buttonComboSuccess", "death", "player_killed_no_faux_death" );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0xc4d
// Size: 0x8d
function function_f552430dc0f43d18( driver )
{
    self.victim notify( "waitButtonComboSuccess" );
    self.victim endon( "waitButtonComboSuccess" );
    driver endon( "disconnect" );
    
    while ( true )
    {
        driver waittill( "luinotifyserver", message, value );
        
        if ( message == "button_combo_success" && value == 1 )
        {
            self.victim notify( "buttonComboSuccess" );
            driver notify( "ddos_ended_early" );
            self.var_9159d29edcddbf2e = 1;
        }
        
        waitframe();
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 3
// Checksum 0x0, Offset: 0xce2
// Size: 0x33a
function apply_emp_struct( data, disablehud, var_88cc62362fd687a2 )
{
    assertex( isdefined( data ), "apply_emp() called without data." );
    assertex( isdefined( data.attacker ), "apply_emp() data does not have a .attacker." );
    assertex( isdefined( data.victim ), "apply_emp() data does not have a .victim." );
    
    if ( issharedfuncdefined( "perk", "hasPerk" ) && data.victim [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_emp_immunity" ) )
    {
        return;
    }
    
    assertex( isdefined( data.objweapon ), "apply_emp() data does not have a .objWeapon." );
    assertex( isweapon( data.objweapon ), "apply_emp() data.objWeapon is not a weapon object." );
    
    if ( !isdefined( data.damage ) )
    {
        data.damage = 1;
    }
    
    if ( !isdefined( data.meansofdeath ) )
    {
        data.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    if ( !isdefined( data.point ) )
    {
        data.point = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.direction_vec ) )
    {
        data.direction_vec = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.modelname ) )
    {
        data.modelname = 0;
    }
    
    if ( !isdefined( data.partname ) )
    {
        data.partname = "";
    }
    
    if ( !isdefined( data.tagname ) )
    {
        data.tagname = 0;
    }
    
    if ( !isdefined( data.damageflags ) )
    {
        data.damageflags = 0;
    }
    
    if ( !isdefined( data.hitloc ) )
    {
        data.hitloc = "none";
    }
    
    if ( !isdefined( data.timeoffset ) )
    {
        data.timeoffset = 0;
    }
    
    if ( !isdefined( data.victim.empcount ) )
    {
        data.victim.empcount = 0;
    }
    
    data.victim.empcount++;
    
    if ( data.victim.empcount == 1 )
    {
        if ( isplayer( data.victim ) )
        {
            data.victim thread function_3839fb2d04a8d30e( data, disablehud, var_88cc62362fd687a2 );
        }
        
        if ( isdefined( data.victim.empstartcallback ) )
        {
            data.victim thread [[ data.victim.empstartcallback ]]( data );
        }
        
        data.victim notify( "emp_started", data );
    }
    
    if ( isdefined( data.victim.empapplycallback ) )
    {
        data.victim thread [[ data.victim.empapplycallback ]]( data );
    }
    
    data.victim notify( "emp_applied", data );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0x1024
// Size: 0x53
function remove_emp()
{
    if ( !isdefined( self.empcount ) )
    {
        return;
    }
    
    self.empcount--;
    
    if ( isdefined( self.empremovecallback ) )
    {
        self thread [[ self.empremovecallback ]]();
    }
    
    self notify( "emp_removed" );
    
    if ( self.empcount == 0 )
    {
        clear_emp( 0 );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x107f
// Size: 0x5d
function clear_emp( fromdeath )
{
    if ( isdefined( self.empcount ) )
    {
        self.empcount = undefined;
        
        if ( isplayer( self ) )
        {
            thread function_a50bae7a5c1bb54e( istrue( fromdeath ) );
        }
        else if ( isdefined( self.empclearcallback ) )
        {
            self thread [[ self.empclearcallback ]]( istrue( fromdeath ) );
        }
        
        self notify( "emp_cleared" );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x10e4
// Size: 0x6a
function allow_emp( status )
{
    if ( isplayer( self ) )
    {
        function_8ee0deb8fa69cbee( status );
        return;
    }
    
    if ( !isdefined( self.empnotallowed ) )
    {
        self.empnotallowed = 0;
    }
    
    if ( status )
    {
        assertex( self.empnotallowed > 0, "allow_emp(true) called when emp was already allowed." );
        self.empnotallowed--;
        return;
    }
    
    self.empnotallowed++;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0x1156
// Size: 0x38
function can_be_empd()
{
    if ( isplayer( self ) )
    {
        return function_28b3cf4c66aab86f();
    }
    else if ( istrue( self.exploding ) )
    {
        return 0;
    }
    else if ( istrue( self.empnotallowed ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0x1197
// Size: 0x1b, Type: bool
function is_empd()
{
    return isdefined( self.empcount ) && self.empcount > 0;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0x11bb
// Size: 0x1e
function emp_debuff_get_emp_count()
{
    if ( isdefined( self.empcount ) )
    {
        return self.empcount;
    }
    
    return 0;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x11e1
// Size: 0x15
function set_apply_emp_callback( applycallback )
{
    self.empapplycallback = applycallback;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x11fe
// Size: 0x15
function set_start_emp_callback( startcallback )
{
    self.empstartcallback = startcallback;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x121b
// Size: 0x15
function set_clear_emp_callback( clearcallback )
{
    self.empclearcallback = clearcallback;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x1238
// Size: 0x3d
function add_emp_ent( ent )
{
    data = function_879c1eec976b6d33();
    id = ent getentitynumber();
    data.ents[ id ] = ent;
    return id;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0x127e
// Size: 0x2b
function play_scramble( scramblelevel, isjammer )
{
    if ( istrue( isjammer ) )
    {
        function_1e2a945f433a4672( scramblelevel );
        return;
    }
    
    play_emp_scramble( scramblelevel );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0x12b1
// Size: 0x2b
function stop_scramble( scramblelevel, isjammer )
{
    if ( istrue( isjammer ) )
    {
        function_f9646d0da61017ec( scramblelevel );
        return;
    }
    
    stop_emp_scramble( scramblelevel );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0x12e4
// Size: 0x51
function function_396e8b70241f9f10( scramblelevel, var_699323575339379a )
{
    if ( istrue( var_699323575339379a ) )
    {
        return ( isdefined( self.var_a0d8d8b22da8ec61 ) && isdefined( self.var_a0d8d8b22da8ec61[ scramblelevel ] ) );
    }
    
    return isdefined( self.empscramblelevels ) && isdefined( self.empscramblelevels[ scramblelevel ] );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x133d
// Size: 0x5e
function play_emp_scramble( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.empscramblelevels ) )
    {
        self.empscramblelevels = [];
    }
    
    var_4fdc563c6178bcbf = self.empscramblelevels[ scramblelevel ];
    
    if ( !isdefined( var_4fdc563c6178bcbf ) )
    {
        var_4fdc563c6178bcbf = 0;
    }
    
    self.empscramblelevels[ scramblelevel ] = var_4fdc563c6178bcbf + 1;
    _update_emp_scramble();
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x13a3
// Size: 0x80
function stop_emp_scramble( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    assert( isdefined( self.empscramblelevels ), "stopped scramble effect without playing it" );
    assert( isdefined( self.empscramblelevels[ scramblelevel ] ), "need to play scramble effect level before stopping it" );
    self.empscramblelevels[ scramblelevel ] -= 1;
    
    if ( self.empscramblelevels[ scramblelevel ] == 0 )
    {
        self.empscramblelevels[ scramblelevel ] = undefined;
    }
    
    _update_emp_scramble();
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0
// Checksum 0x0, Offset: 0x142b
// Size: 0x1b
function function_f7c6d776d032122f()
{
    self.empscramblelevels = [];
    _update_emp_scramble();
    self notify( "emp_scramble_off" );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x144e
// Size: 0x6d
function private _update_emp_scramble()
{
    highestlevel = 0;
    
    foreach ( scramblelevel, _ in self.empscramblelevels )
    {
        if ( scramblelevel > highestlevel )
        {
            highestlevel = scramblelevel;
        }
    }
    
    self setclientomnvar( "ui_scrambler_strength", highestlevel );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x14c3
// Size: 0x6d
function private function_9884b1bc85070e0e()
{
    highestlevel = 0;
    
    foreach ( scramblelevel, _ in self.var_a0d8d8b22da8ec61 )
    {
        if ( scramblelevel > highestlevel )
        {
            highestlevel = scramblelevel;
        }
    }
    
    self setclientomnvar( "ui_jammer_strength", highestlevel );
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x1538
// Size: 0x5e
function function_1e2a945f433a4672( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.var_a0d8d8b22da8ec61 ) )
    {
        self.var_a0d8d8b22da8ec61 = [];
    }
    
    var_8d59c19c765106e8 = self.var_a0d8d8b22da8ec61[ scramblelevel ];
    
    if ( !isdefined( var_8d59c19c765106e8 ) )
    {
        var_8d59c19c765106e8 = 0;
    }
    
    self.var_a0d8d8b22da8ec61[ scramblelevel ] = var_8d59c19c765106e8 + 1;
    function_9884b1bc85070e0e();
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x159e
// Size: 0x80
function function_f9646d0da61017ec( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    assert( isdefined( self.var_a0d8d8b22da8ec61 ), "stopped jammer scramble effect without playing it" );
    assert( isdefined( self.var_a0d8d8b22da8ec61[ scramblelevel ] ), "need to play jammer scramble effect level before stopping it" );
    self.var_a0d8d8b22da8ec61[ scramblelevel ] -= 1;
    
    if ( self.var_a0d8d8b22da8ec61[ scramblelevel ] == 0 )
    {
        self.var_a0d8d8b22da8ec61[ scramblelevel ] = undefined;
    }
    
    function_9884b1bc85070e0e();
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0x1626
// Size: 0x3b
function play_scramble_for_player_until_cleared( player, scramblelevel )
{
    player scripts\cp_mp\emp_debuff::play_emp_scramble( scramblelevel );
    waittill_any_2( "emp_cleared", "death" );
    
    if ( isdefined( player ) )
    {
        player scripts\cp_mp\emp_debuff::stop_emp_scramble( scramblelevel );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0x1669
// Size: 0x3b
function function_9d31a370d60f86da( player, scramblelevel )
{
    player scripts\cp_mp\emp_debuff::play_emp_scramble( scramblelevel );
    waittill_any_2( "dronegun_emp_cleared", "death" );
    
    if ( isdefined( player ) )
    {
        player scripts\cp_mp\emp_debuff::stop_emp_scramble( scramblelevel );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x16ac
// Size: 0x33
function private function_8ee0deb8fa69cbee( status )
{
    if ( issharedfuncdefined( "emp", "setPlayerEMPImmune" ) )
    {
        self [[ getsharedfunc( "emp", "setPlayerEMPImmune" ) ]]( status );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x16e7
// Size: 0x1e
function private _get_emp_count()
{
    if ( !isdefined( self.empcount ) )
    {
        return 0;
    }
    
    return self.empcount;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x170d
// Size: 0x36, Type: bool
function private function_28b3cf4c66aab86f()
{
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( issharedfuncdefined( "emp", "getPlayerEMPImmune" ) )
    {
        return ![[ getsharedfunc( "emp", "getPlayerEMPImmune" ) ]]();
    }
    
    return true;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x174c
// Size: 0x7a
function private function_3839fb2d04a8d30e( data, disablehud, var_88cc62362fd687a2 )
{
    if ( issharedfuncdefined( "emp", "onPlayerEMPed" ) )
    {
        self [[ getsharedfunc( "emp", "onPlayerEMPed" ) ]]( data );
    }
    
    if ( istrue( disablehud ) )
    {
        self setempjammed( 1 );
    }
    
    if ( istrue( var_88cc62362fd687a2 ) )
    {
        val::set( "emp", "killstreaks", 0 );
        val::set( "emp", "supers", 0 );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x17ce
// Size: 0x23
function private function_a50bae7a5c1bb54e( fromdeath )
{
    self setempjammed( 0 );
    
    if ( !fromdeath )
    {
        val::reset_all( "emp" );
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x17f9
// Size: 0x31
function private function_bc44636b60d908b()
{
    data = spawnstruct();
    level.emp = data;
    level.emp.ents = [];
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1832
// Size: 0x1f
function private function_879c1eec976b6d33()
{
    if ( !isdefined( level.emp ) )
    {
        function_bc44636b60d908b();
    }
    
    return level.emp;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 4
// Checksum 0x0, Offset: 0x185a
// Size: 0x7b
function function_ecb3af104f3ab0f4( entity, applycallback, startcallback, clearcallback )
{
    if ( isdefined( applycallback ) )
    {
        entity set_apply_emp_callback( applycallback );
    }
    
    if ( isdefined( startcallback ) )
    {
        entity set_start_emp_callback( startcallback );
    }
    
    if ( isdefined( clearcallback ) )
    {
        entity set_clear_emp_callback( clearcallback );
    }
    
    if ( !isdefined( level.var_7cfe8a4bd3bd978c ) )
    {
        level.var_7cfe8a4bd3bd978c = [];
    }
    
    if ( isdefined( entity ) )
    {
        level.var_7cfe8a4bd3bd978c[ entity getentitynumber() ] = entity;
    }
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 1
// Checksum 0x0, Offset: 0x18dd
// Size: 0x4b
function emp_debuff_deregister( entity )
{
    if ( !isdefined( level.var_7cfe8a4bd3bd978c ) )
    {
        return;
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    entitynumber = entity getentitynumber();
    
    if ( !isdefined( level.var_7cfe8a4bd3bd978c[ entitynumber ] ) )
    {
        return;
    }
    
    level.var_7cfe8a4bd3bd978c[ entitynumber ] = undefined;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1930
// Size: 0x44, Type: bool
function private function_c772d34f3b6b6273( ents, optionalorigin, var_5a946d15b7708ff0 )
{
    if ( isdefined( optionalorigin ) )
    {
        if ( distancesquared( self.origin, optionalorigin ) > var_5a946d15b7708ff0 )
        {
            return false;
        }
    }
    
    if ( arraycontains( ents, self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace emp_debuff / scripts\cp_mp\emp_debuff
// Params 2
// Checksum 0x0, Offset: 0x197d
// Size: 0x4fa
function empdebuff_get_emp_ents( optionalorigin, optionalradius )
{
    data = function_879c1eec976b6d33();
    radiussquared = undefined;
    
    if ( isdefined( optionalradius ) )
    {
        radiussquared = optionalradius * optionalradius;
    }
    
    ents = [];
    
    foreach ( ent in data.ents )
    {
        if ( isdefined( ent ) && ent can_be_empd() && ent function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = ent;
        }
    }
    
    foreach ( mine in level.mines )
    {
        if ( isdefined( mine ) && mine can_be_empd() && mine function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = mine;
        }
    }
    
    turrets = getentarray( "misc_turret", "classname" );
    
    foreach ( turret in turrets )
    {
        if ( isdefined( turret ) && turret can_be_empd() && turret function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = turret;
        }
    }
    
    if ( isdefined( level.activekillstreaks ) )
    {
        foreach ( streak in level.activekillstreaks )
        {
            if ( isdefined( streak ) && streak can_be_empd() && streak function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = streak;
            }
        }
    }
    
    if ( isdefined( level.vehicle ) )
    {
        foreach ( vehicles in level.vehicle.instances )
        {
            foreach ( vehicle in vehicles )
            {
                if ( isdefined( vehicle ) && vehicle can_be_empd() && vehicle function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
                {
                    ents[ ents.size ] = vehicle;
                }
            }
        }
    }
    
    if ( isdefined( level.var_7cfe8a4bd3bd978c ) )
    {
        foreach ( equipment in level.var_7cfe8a4bd3bd978c )
        {
            if ( isdefined( equipment ) && equipment can_be_empd() && equipment function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = equipment;
            }
        }
    }
    
    if ( isdefined( level.var_92e2c130a8ea2b6c ) )
    {
        foreach ( drone in level.var_92e2c130a8ea2b6c )
        {
            if ( isdefined( drone ) && !istrue( drone.isdestroyed ) && drone function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = drone;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) && player can_be_empd() && player function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = player;
        }
    }
    
    if ( isdefined( level.var_372bd0f371e44049 ) )
    {
        foreach ( var_1b91d895c80e84b2 in level.var_372bd0f371e44049 )
        {
            if ( var_1b91d895c80e84b2 function_c772d34f3b6b6273( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = var_1b91d895c80e84b2;
            }
        }
    }
    
    return ents;
}

