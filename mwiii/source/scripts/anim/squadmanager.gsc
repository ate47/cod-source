#using scripts\anim\battlechatter_ai;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace squadmanager;

// Namespace squadmanager / scripts\anim\squadmanager
// Params 2
// Checksum 0x0, Offset: 0x113
// Size: 0xfc
function createsquad( squadname, squadcreator )
{
    assertex( !isdefined( anim.squads[ squadname ] ), "<dev string:x1c>" );
    squad = spawnstruct();
    squad.squadname = squadname;
    anim.squads[ squadname ] = squad;
    squad.team = getsquadteam( squadcreator );
    squad.members = [];
    squad.squadlist = [];
    squad.cooldowntimes = [];
    squad.squadid = anim.squadindex.size;
    anim.squadindex[ squad.squadid ] = squad;
    level notify( "squad created " + squadname );
    anim notify( "squad created " + squadname );
    
    if ( isdefined( anim.squadcreatefunc ) )
    {
        squad thread [[ anim.squadcreatefunc ]]();
    }
    
    /#
        squad thread function_1e0a52e0fce5e432();
    #/
    
    return squad;
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 1
// Checksum 0x0, Offset: 0x218
// Size: 0xf5
function deletesquad( squadname )
{
    if ( squadname == "axis" || squadname == "team3" || squadname == "allies" || squadname == "neutral" )
    {
        return;
    }
    
    assertex( isdefined( anim.squads[ squadname ] ), "<dev string:x6f>" + squadname + "<dev string:x9c>" );
    squadid = anim.squads[ squadname ].squadid;
    squad = anim.squads[ squadname ];
    anim.squadindex[ squadid ] = anim.squadindex[ anim.squadindex.size - 1 ];
    anim.squadindex[ squadid ].squadid = squadid;
    anim.squadindex[ anim.squadindex.size - 1 ] = undefined;
    anim.squads[ squadname ] = undefined;
    anim notify( "squad deleted " + squadname );
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 1
// Checksum 0x0, Offset: 0x315
// Size: 0x3c
function getsquadteam( squadcreator )
{
    if ( isdefined( squadcreator.team ) )
    {
        squadteam = squadcreator.team;
    }
    else
    {
        squadteam = "allies";
    }
    
    return squadteam;
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 1
// Checksum 0x0, Offset: 0x35a
// Size: 0x148
function addtosquad( squadname )
{
    assertex( issentient( self ), "<dev string:xb5>" );
    
    if ( !isdefined( squadname ) )
    {
        if ( isdefined( self.script_squadname ) )
        {
            squadname = self.script_squadname;
        }
        else
        {
            squadname = self.team;
        }
    }
    
    if ( !isdefined( anim.squads[ squadname ] ) )
    {
        anim createsquad( squadname, self );
    }
    
    squad = anim.squads[ squadname ];
    
    if ( isdefined( self.squad ) )
    {
        if ( self.squad == squad )
        {
            return;
        }
        else
        {
            removefromsquad( self.squad, self.squadid );
        }
    }
    
    self.lastenemysighttime = 0;
    self.combattime = 0;
    self.starttime = gettime();
    squad.var_f54c29e2793a21fb = default_to( squad.var_f54c29e2793a21fb, 0 );
    squadid = squad.var_f54c29e2793a21fb;
    squad.members[ squadid ] = self;
    squad.var_f54c29e2793a21fb++;
    self.squad = squad;
    self.squadid = squadid;
    thread scripts\anim\battlechatter_ai::addtosystem();
    thread memberdeathwaiter( squad, squadid );
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 2
// Checksum 0x0, Offset: 0x4aa
// Size: 0xd2
function removefromsquad( squad, squadid )
{
    if ( !isdefined( squad ) )
    {
        return;
    }
    
    assertex( isdefined( squadid ), "<dev string:xea>" );
    
    if ( isdefined( self ) )
    {
        assertex( squad.members.size != 0, "<dev string:x124>" );
        assertex( squad.members[ squadid ] == self, "<dev string:x156>" );
    }
    else
    {
        assertex( !isdefined( squad.members[ squadid ] ), "<dev string:x1b9>" );
    }
    
    squad.members[ squadid ] = undefined;
    
    if ( isdefined( self ) )
    {
        thread scripts\anim\battlechatter_ai::removefromsystem( squad );
    }
    
    if ( squad.members.size == 0 )
    {
        deletesquad( squad.squadname );
    }
    
    if ( isdefined( self ) )
    {
        self notify( "removed from squad" );
    }
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 3
// Checksum 0x0, Offset: 0x584
// Size: 0x43
function function_a5c82b8ba8a0c279( var_9cb951de1a571d32, true_value, false_value )
{
    if ( var_9cb951de1a571d32 )
    {
        if ( isfunction( true_value ) )
        {
            return [[ true_value ]]();
        }
        else
        {
            return true_value;
        }
    }
    
    if ( isfunction( false_value ) )
    {
        return [[ false_value ]]();
    }
    
    return false_value;
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 0
// Checksum 0x0, Offset: 0x5cf
// Size: 0xa1
function function_1cb4f2ef6b07869c()
{
    start_index = randomint( self.members.size );
    
    for ( i = 0; i < self.members.size ; i++ )
    {
        index = ( start_index + i ) % self.members.size;
        guy = self.members[ index ];
        
        if ( !isalive( guy ) || !isdefined( guy.enemy ) || !guy.bisincombat )
        {
        }
    }
    
    return self.members[ start_index ];
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 0
// Checksum 0x0, Offset: 0x679
// Size: 0x78
function getenemyarray()
{
    array = [];
    
    foreach ( ai in getaiarray() )
    {
        if ( isenemyteam( self.team, ai.team ) )
        {
            array[ array.size ] = ai;
        }
    }
    
    return array;
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 0
// Checksum 0x0, Offset: 0x6fa
// Size: 0x3c, Type: bool
function enemyisincover()
{
    return isdefined( self.enemy ) && isdefined( self.enemy.node ) && isdefined( self.enemy.covernode );
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 0
// Checksum 0x0, Offset: 0x73f
// Size: 0x13
function squadtracker()
{
    anim endon( "squad deleted " + self.squadname );
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 2
// Checksum 0x0, Offset: 0x75a
// Size: 0x46
function memberdeathwaiter( squad, squadid )
{
    self endon( "removed from squad" );
    self waittill( "death", attacker );
    
    if ( isdefined( self ) )
    {
        self.attacker = attacker;
    }
    
    removefromsquad( squad, squadid );
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 0
// Checksum 0x0, Offset: 0x7a8
// Size: 0x20f
function updateall()
{
    neworigin = ( 0, 0, 0 );
    newheading = ( 0, 0, 0 );
    var_8bf9f8d903167b37 = 0;
    curenemy = undefined;
    isincombat = 0;
    needheading = !isdefined( self.enemy );
    
    if ( !needheading )
    {
        self.forward = vectornormalize( self.enemy.origin - self.origin );
    }
    
    foreach ( member in self.members )
    {
        if ( !isalive( member ) )
        {
            continue;
        }
        
        var_8bf9f8d903167b37++;
        neworigin += member.origin;
        
        if ( needheading )
        {
            newheading += anglestoforward( member.angles );
        }
        
        if ( istrue( member.bisincombat ) )
        {
            isincombat = 1;
        }
        
        if ( isdefined( member.enemy ) && isdefined( member.enemy.squad ) )
        {
            if ( !isdefined( curenemy ) )
            {
                curenemy = member.enemy.squad;
                continue;
            }
            
            if ( member.enemy.squad.members.size > curenemy.members.size )
            {
                curenemy = member.enemy.squad;
            }
        }
    }
    
    if ( var_8bf9f8d903167b37 )
    {
        self.origin = neworigin / var_8bf9f8d903167b37;
        
        if ( needheading )
        {
            self.forward = newheading / var_8bf9f8d903167b37;
        }
    }
    else
    {
        self.origin = undefined;
        
        if ( needheading )
        {
            self.forward = undefined;
        }
    }
    
    self.isincombat = isincombat;
    self.enemy = curenemy;
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 0
// Checksum 0x0, Offset: 0x9bf
// Size: 0x13
function updatememberstates()
{
    anim endon( "squad deleted " + self.squadname );
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 1
// Checksum 0x0, Offset: 0x9da
// Size: 0xf2
function aiupdatecombat( timeslice )
{
    if ( !isdefined( self.combattime ) )
    {
        return;
    }
    
    if ( isdefined( self.lastenemysightpos ) )
    {
        if ( self.combattime < 0 )
        {
            self.combattime = timeslice;
        }
        else
        {
            self.combattime += timeslice;
        }
        
        self.lastenemysighttime = gettime();
        return;
    }
    else if ( isdefined( self.bt_escaping ) && self.bt_escaping || isdefined( self.asmname ) && self.asmname != "jackal" && self issuppressed() )
    {
        self.combattime += timeslice;
        return;
    }
    
    if ( self.combattime > 0 )
    {
        self.combattime = 0 - timeslice;
        return;
    }
    
    self.combattime -= timeslice;
}

// Namespace squadmanager / scripts\anim\squadmanager
// Params 1
// Checksum 0x0, Offset: 0xad4
// Size: 0xbf
function aiupdatesuppressed( timeslice )
{
    if ( !isdefined( self.suppressedtime ) )
    {
        return;
    }
    
    if ( isdefined( self.bt_escaping ) && self.bt_escaping || isdefined( self.asmname ) && self.asmname != "jackal" && self issuppressed() )
    {
        if ( self.suppressedtime < 0 )
        {
            self.suppressedtime = timeslice;
            return;
        }
        
        self.suppressedtime += timeslice;
        return;
    }
    
    if ( self.suppressedtime > 0 )
    {
        self.suppressedtime = 0 - timeslice;
        return;
    }
    
    self.suppressedtime -= timeslice;
}

/#

    // Namespace squadmanager / scripts\anim\squadmanager
    // Params 0
    // Checksum 0x0, Offset: 0xb9b
    // Size: 0xd1, Type: dev
    function function_1e0a52e0fce5e432()
    {
        if ( getdvarint( @"debug_squadmanager" ) < 1 )
        {
            return;
        }
        
        anim endon( "<dev string:x217>" + self.squadname );
        
        while ( true )
        {
            wait 0.05;
            function_11287c170b69b7f2( self.origin, self.forward );
            
            foreach ( member in self.members )
            {
                if ( !isalive( member ) )
                {
                    continue;
                }
                
                line( self.origin, member.origin, ( 0.5, 0.5, 0.5 ) );
            }
        }
    }

    // Namespace squadmanager / scripts\anim\squadmanager
    // Params 2
    // Checksum 0x0, Offset: 0xc74
    // Size: 0xaa, Type: dev
    function function_11287c170b69b7f2( pos, forward )
    {
        angles = vectortoangles( forward );
        range = 100;
        forward = anglestoforward( angles ) * range;
        right = anglestoright( angles ) * range;
        up = anglestoup( angles ) * range;
        _draw_arrow( pos, pos + forward, ( 1, 0, 0 ) );
        _draw_arrow( pos, pos + up, ( 0, 1, 0 ) );
        _draw_arrow( pos, pos + right, ( 0, 0, 1 ) );
    }

    // Namespace squadmanager / scripts\anim\squadmanager
    // Params 3
    // Checksum 0x0, Offset: 0xd26
    // Size: 0x105, Type: dev
    function _draw_arrow( start, end, color )
    {
        angle = vectortoangles( end - start );
        dist = length( end - start );
        forward = anglestoforward( angle );
        forwardfar = forward * dist;
        arrow_size = 5;
        forwardclose = forward * ( dist - arrow_size );
        right = anglestoright( angle );
        leftdraw = right * arrow_size * -1;
        rightdraw = right * arrow_size;
        line( start, end, color, 1, 0, 1 );
        line( start, start + forwardfar, color, 1, 0, 1 );
        line( start + forwardfar, start + forwardclose + rightdraw, color, 1, 0, 1 );
        line( start + forwardfar, start + forwardclose + leftdraw, color, 1, 0, 1 );
    }

#/
