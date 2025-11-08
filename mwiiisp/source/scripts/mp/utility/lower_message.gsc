#namespace lower_message;

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 3
// Checksum 0x0, Offset: 0x174
// Size: 0xab
function setlowermessageomnvar( ref, timer, var_c84f97acad5b2088 )
{
    gamemode = getdvar( @"ui_gametype" );
    
    if ( gamemode != "cp_survival" && gamemode != "cp_wave_sv" && gamemode != "cp_specops" )
    {
        omnvarindex = game[ "lowerMessageIndex" ][ ref ];
        
        if ( !isdefined( omnvarindex ) )
        {
            assertmsg( "setLowerMessageOmnvar() called with unknown ref: " + ref );
            return;
        }
        
        self setclientomnvar( "ui_lower_message", omnvarindex );
        
        if ( isdefined( timer ) )
        {
            self setclientomnvar( "ui_lower_message_time", timer );
        }
        
        if ( isdefined( var_c84f97acad5b2088 ) )
        {
            thread clearomnvarsaftertime( var_c84f97acad5b2088 );
        }
    }
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 1
// Checksum 0x0, Offset: 0x227
// Size: 0x69
function clearomnvarsaftertime( var_c84f97acad5b2088 )
{
    self notify( "message_cleared" );
    self endon( "message_cleared" );
    self endon( "death_or_disconnect" );
    wait var_c84f97acad5b2088;
    gamemode = getdvar( @"ui_gametype" );
    
    if ( gamemode != "cp_survival" && gamemode != "cp_wave_sv" && gamemode != "cp_specops" )
    {
        self setclientomnvar( "ui_lower_message", 0 );
    }
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 0
// Checksum 0x0, Offset: 0x298
// Size: 0x9f
function function_5a98c45a6252b4a()
{
    game[ "lowerMessageIndex" ] = [];
    numrows = tablelookupgetnumrows( "mp/hints.csv" );
    
    for ( index = 0; index < numrows ; index++ )
    {
        var_c71a87c9229a2e91 = int( tablelookupbyrow( "mp/hints.csv", index, 0 ) );
        indexstr = tablelookupbyrow( "mp/hints.csv", index, 1 );
        
        if ( indexstr == "" )
        {
            continue;
        }
        
        assertex( !isdefined( game[ "lowerMessageIndex" ][ indexstr ] ), indexstr + " is already defined in game[ lowerMessageIndex ]" );
        game[ "lowerMessageIndex" ][ indexstr ] = var_c71a87c9229a2e91;
    }
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 10
// Checksum 0x0, Offset: 0x33f
// Size: 0xbb
function setlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu )
{
    if ( !isdefined( priority ) )
    {
        priority = 1;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    if ( !isdefined( showtimer ) )
    {
        showtimer = 0;
    }
    
    if ( !isdefined( shouldfade ) )
    {
        shouldfade = 0;
    }
    
    if ( !isdefined( fadetoalpha ) )
    {
        fadetoalpha = 0.85;
    }
    
    if ( !isdefined( fadetoalphatime ) )
    {
        fadetoalphatime = 3;
    }
    
    if ( !isdefined( hidewhenindemo ) )
    {
        hidewhenindemo = 0;
    }
    
    if ( !isdefined( hidewheninmenu ) )
    {
        hidewheninmenu = 1;
    }
    
    addlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu );
    updatelowermessage();
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 1
// Checksum 0x0, Offset: 0x402
// Size: 0x1a
function clearlowermessage( name )
{
    removelowermessage( name );
    updatelowermessage();
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 0
// Checksum 0x0, Offset: 0x424
// Size: 0x58
function clearlowermessages()
{
    if ( !isdefined( self ) || !isdefined( self.lowermessage ) || !isdefined( self.lowermessages ) )
    {
        return;
    }
    
    for ( i = 0; i < self.lowermessages.size ; i++ )
    {
        self.lowermessages[ i ] = undefined;
    }
    
    updatelowermessage();
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 0
// Checksum 0x0, Offset: 0x484
// Size: 0xb0
function sortlowermessages()
{
    for ( i = 1; i < self.lowermessages.size ; i++ )
    {
        message = self.lowermessages[ i ];
        priority = message.priority;
        
        for ( j = i - 1; j >= 0 && priority > self.lowermessages[ j ].priority ; j-- )
        {
            self.lowermessages[ j + 1 ] = self.lowermessages[ j ];
        }
        
        self.lowermessages[ j + 1 ] = message;
    }
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 10
// Checksum 0x0, Offset: 0x53c
// Size: 0x1a7
function addlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu )
{
    newmessage = undefined;
    
    foreach ( message in self.lowermessages )
    {
        if ( message.name == name )
        {
            if ( message.text == text && message.priority == priority )
            {
                return;
            }
            
            newmessage = message;
            break;
        }
    }
    
    if ( !isdefined( newmessage ) )
    {
        newmessage = spawnstruct();
        self.lowermessages[ self.lowermessages.size ] = newmessage;
    }
    
    newmessage.name = name;
    newmessage.text = text;
    newmessage.time = time;
    newmessage.addtime = gettime();
    newmessage.priority = priority;
    newmessage.showtimer = showtimer;
    newmessage.shouldfade = shouldfade;
    newmessage.fadetoalpha = fadetoalpha;
    newmessage.fadetoalphatime = fadetoalphatime;
    newmessage.hidewhenindemo = hidewhenindemo;
    newmessage.hidewheninmenu = hidewheninmenu;
    sortlowermessages();
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 1
// Checksum 0x0, Offset: 0x6eb
// Size: 0xda
function removelowermessage( name )
{
    if ( isdefined( self.lowermessages ) )
    {
        for ( i = self.lowermessages.size; i > 0 ; i-- )
        {
            if ( self.lowermessages[ i - 1 ].name != name )
            {
                continue;
            }
            
            message = self.lowermessages[ i - 1 ];
            
            for ( j = i; j < self.lowermessages.size ; j++ )
            {
                if ( isdefined( self.lowermessages[ j ] ) )
                {
                    self.lowermessages[ j - 1 ] = self.lowermessages[ j ];
                }
            }
            
            self.lowermessages[ self.lowermessages.size - 1 ] = undefined;
        }
        
        sortlowermessages();
    }
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 0
// Checksum 0x0, Offset: 0x7cd
// Size: 0x1c
function getlowermessage()
{
    if ( !isdefined( self.lowermessages ) )
    {
        return undefined;
    }
    
    return self.lowermessages[ 0 ];
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 0
// Checksum 0x0, Offset: 0x7f2
// Size: 0x227
function updatelowermessage()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    message = getlowermessage();
    
    if ( !isdefined( message ) )
    {
        if ( isdefined( self.lowermessage ) && isdefined( self.lowertimer ) )
        {
            self.lowermessage.alpha = 0;
            self.lowertimer.alpha = 0;
        }
        
        return;
    }
    
    self.lowermessage settext( message.text );
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = message.hidewhenindemo;
    self.lowermessage.hidewheninmenu = message.hidewheninmenu;
    
    if ( message.shouldfade )
    {
        self.lowermessage fadeovertime( min( message.fadetoalphatime, 60 ) );
        self.lowermessage.alpha = message.fadetoalpha;
    }
    
    if ( message.time > 0 && message.showtimer )
    {
        self.lowertimer settimer( max( message.time - ( gettime() - message.addtime ) / 1000, 0.1 ) );
        return;
    }
    
    if ( message.time > 0 && !message.showtimer )
    {
        self.lowertimer settext( "" );
        self.lowermessage fadeovertime( min( message.time, 60 ) );
        self.lowermessage.alpha = 0;
        thread clearondeath( message );
        thread clearafterfade( message );
        return;
    }
    
    self.lowertimer settext( "" );
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 1
// Checksum 0x0, Offset: 0xa21
// Size: 0x42
function clearondeath( message )
{
    self notify( "message_cleared" );
    self endon( "message_cleared" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    clearlowermessage( message.name );
}

// Namespace lower_message / scripts\mp\utility\lower_message
// Params 1
// Checksum 0x0, Offset: 0xa6b
// Size: 0x31
function clearafterfade( message )
{
    wait message.time;
    clearlowermessage( message.name );
    self notify( "message_cleared" );
}

