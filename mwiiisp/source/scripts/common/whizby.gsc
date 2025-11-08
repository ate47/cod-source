#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace whizby;

// Namespace whizby / scripts\common\whizby
// Params 1
// Checksum 0x0, Offset: 0x1e8
// Size: 0x43
function init( var_8611e1d824bbdb4a )
{
    setdvarifuninitialized( @"scr_whizby", 1 );
    
    /#
        setdvarifuninitialized( @"hash_7774635c5712048e", 0 );
        setdvarifuninitialized( @"hash_a6017ebde71968e5", "<dev string:x1c>" );
    #/
}

// Namespace whizby / scripts\common\whizby
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0x30
function initplayer()
{
    self.whizby = spawnstruct();
    self.whizby.lasttime = -999999;
    function_bcd1a794fb26ee5c();
}

// Namespace whizby / scripts\common\whizby
// Params 4
// Checksum 0x0, Offset: 0x26b
// Size: 0x225
function whizbyeffect( attacker, distance, position, forward )
{
    /#
        if ( getdvarint( @"hash_7774635c5712048e" ) )
        {
            if ( distance > 120 )
            {
                print3d( position, int( sqrt( distance ) ), ( 1, 1, 1 ), 0.7, 0.45, 20 );
            }
            else
            {
                eye = self geteye();
                print3d( position, distance, ( 1, 0, 0 ), 0.7, 0.45, 20 );
            }
        }
    #/
    
    if ( isdefined( attacker ) && isai( attacker ) && isalive( attacker ) )
    {
        addbattlechatternotify( attacker, undefined, "shot_at_target", "target_unhurt" );
    }
    
    time = gettime();
    
    if ( shoulddowhizby( attacker, distance, position, forward, time ) )
    {
        weapon = undefined;
        
        if ( isplayer( attacker ) || isbot( attacker ) )
        {
            weapon = attacker getcurrentweapon();
        }
        else if ( isai( attacker ) )
        {
            weapon = attacker.weapon;
        }
        else
        {
            assertmsg( "attacker in whizby is neither a player or AI" );
        }
        
        weapclass = weaponclass( weapon );
        
        /#
            if ( getdvar( @"hash_a6017ebde71968e5" ) != "<dev string:x1c>" )
            {
                switch ( getdvar( @"hash_a6017ebde71968e5" ) )
                {
                    case #"hash_900cb06c552c5063":
                        weapclass = "<dev string:x21>";
                        break;
                    case #"hash_28a7ce6c1f1955d9":
                        weapclass = "<dev string:x29>";
                        break;
                    case #"hash_2f69646c2276faf4":
                        weapclass = "<dev string:x33>";
                        break;
                }
            }
        #/
        
        self notify( "whizbyBlur_reset" );
        whizbymag = function_21676cfe493c7014( weapclass, distance, time );
        whizbyquake( whizbymag );
        whizbyvision( weapclass, weapon, whizbymag );
        whizby_hud( attacker, position, time, whizbymag, distance );
        self.whizby.lasttime = time;
        function_bcd1a794fb26ee5c();
    }
}

// Namespace whizby / scripts\common\whizby
// Params 5
// Checksum 0x0, Offset: 0x498
// Size: 0x106, Type: bool
function shoulddowhizby( attacker, distance, position, forward, time )
{
    if ( getdvarint( @"scr_whizby", 1 ) != 1 )
    {
        return false;
    }
    
    if ( !isdefined( attacker ) || !isdefined( distance ) || !isdefined( position ) || !isdefined( forward ) )
    {
        return false;
    }
    
    if ( !isai( attacker ) && !isplayer( attacker ) )
    {
        return false;
    }
    
    if ( !isalive( attacker ) )
    {
        return false;
    }
    
    if ( time - self.whizby.lasttime < self.whizby.cooldown )
    {
        return false;
    }
    
    if ( !val::get( "whizby" ) )
    {
        return false;
    }
    
    if ( istrue( self.nowhizby ) )
    {
        return false;
    }
    
    if ( !isenemyteam( self.team, attacker.team ) )
    {
        return false;
    }
    
    if ( istrue( self.deathsdoor ) )
    {
        return false;
    }
    
    if ( function_cee14923e29e38ab( time ) )
    {
        return false;
    }
    
    return true;
}

// Namespace whizby / scripts\common\whizby
// Params 1
// Checksum 0x0, Offset: 0x5a7
// Size: 0x4a, Type: bool
function function_cee14923e29e38ab( time )
{
    if ( !isdefined( self.lastdamagedtime ) )
    {
        return false;
    }
    
    damagedcooldowntime = getdvarint( @"hash_902f31627206f3", 750 );
    
    if ( self.lastdamagedtime + damagedcooldowntime > time )
    {
        return true;
    }
    
    return false;
}

// Namespace whizby / scripts\common\whizby
// Params 1
// Checksum 0x0, Offset: 0x5fa
// Size: 0xbc
function whizbyquake( whizbymag )
{
    zoomlevel = self playergetzoomfov();
    zoomfactor = math::normalize_value( 4, 65, zoomlevel );
    var_15801234316e9c14 = math::factor_value( 0.3, 0.85, zoomfactor );
    var_f8e72f77b5116a2f = math::factor_value( 1, var_15801234316e9c14, self playerads() );
    quakemag = math::factor_value( 0.03, 0.28, whizbymag );
    quaketime = math::factor_value( 0.35, 0.35, whizbymag );
    quakemag *= var_f8e72f77b5116a2f;
    self earthquakeforplayer( quakemag, quaketime, self.origin, 1000 );
}

// Namespace whizby / scripts\common\whizby
// Params 3
// Checksum 0x0, Offset: 0x6be
// Size: 0x13d
function whizbyvision( weapclass, weapon, whizbymag )
{
    eventtype = undefined;
    highestevent = 2;
    
    switch ( weapclass )
    {
        case #"hash_fa24dff6bd60a12d":
            highestevent = 3;
            break;
        case #"hash_6191aaef9f922f96":
            if ( string_starts_with( "iw9_dm", weapon.basename ) )
            {
                highestevent = 2;
            }
            else
            {
                highestevent = 3;
            }
            
            break;
        case #"hash_8cdaf2e4ecfe5b51":
            highestevent = 2;
            break;
        case #"hash_719417cb1de832b6":
        case #"hash_900cb96c552c5e8e":
            highestevent = 2;
            break;
    }
    
    eventindex = highestevent;
    
    if ( whizbymag < 0.3 )
    {
        eventindex -= 2;
    }
    else if ( whizbymag < 0.6 )
    {
        eventindex -= 1;
    }
    
    switch ( eventindex )
    {
        case 3:
            eventtype = "vsp_large";
            break;
        case 2:
            eventtype = "vsp_medium";
            break;
        case 1:
            eventtype = "vsp_small";
            break;
    }
    
    if ( eventindex > 0 )
    {
        self function_38e25fa379161404( eventtype );
    }
}

// Namespace whizby / scripts\common\whizby
// Params 5
// Checksum 0x0, Offset: 0x803
// Size: 0x2bd
function whizby_hud( attacker, position, time, whizbymag, distance )
{
    playerang = self getplayerangles();
    eyepos = self geteye();
    playeraxis = anglestoaxis( playerang );
    
    if ( isdefined( attacker.currentweapon ) && attacker tagexists( "tag_flash" ) )
    {
        attackerpos = attacker gettagorigin( "tag_flash" );
    }
    else
    {
        attackerpos = attacker.origin + ( 0, 0, 50 );
    }
    
    toattackervec = vectornormalize( attackerpos - eyepos );
    var_7caf68458d047d37 = vectordot( toattackervec, playeraxis[ "forward" ] );
    var_31659d73698c898a = vectordot( toattackervec, playeraxis[ "right" ] );
    var_7f628b9bd51160d5 = vectordot( toattackervec, playeraxis[ "up" ] );
    whizybyent = attacker getentitynumber();
    var_dd9bb8522cc9e666 = clamp( var_7caf68458d047d37, 0, 1 );
    var_b4b4994e3604ce34 = 1 - abs( var_7caf68458d047d37 );
    var_f3dae9eeecbc6a28 = clamp( -1 * var_7caf68458d047d37, 0, 1 );
    var_3783a488b009bc61 = function_dbabf852a35102e4( var_31659d73698c898a, var_7f628b9bd51160d5 );
    backorigin = position + -500 * toattackervec;
    var_dd9bb8522cc9e666 = math::normalized_float_smooth_out( var_dd9bb8522cc9e666 );
    var_b4b4994e3604ce34 = math::normalized_float_smooth_out( var_b4b4994e3604ce34 );
    self setclientomnvar( "ui_whizby_alpha_front", var_dd9bb8522cc9e666 * whizbymag * 0.5 );
    self setclientomnvar( "ui_whizby_alpha_side", var_b4b4994e3604ce34 * whizbymag * 1 );
    self setclientomnvar( "ui_whizby_alpha_back", var_f3dae9eeecbc6a28 * whizbymag * 1 );
    self setclientomnvar( "ui_whizby_side_angle", int( var_3783a488b009bc61 ) );
    self setclientomnvar( "ui_whizby_ent", whizybyent );
    self setclientomnvar( "ui_whizby_back_x", int( backorigin[ 0 ] ) );
    self setclientomnvar( "ui_whizby_back_y", int( backorigin[ 1 ] ) );
    self setclientomnvar( "ui_whizby_back_z", int( backorigin[ 2 ] ) );
    xpos = self getclientomnvar( "ui_whizby_back_x" );
    ypos = self getclientomnvar( "ui_whizby_back_y" );
    zpos = self getclientomnvar( "ui_whizby_back_z" );
    self setclientomnvar( "ui_whizby_notify", time );
    
    /#
        if ( getdvarint( @"hash_7774635c5712048e" ) )
        {
            debugwhizby( attacker, position, backorigin, whizbymag, distance );
        }
    #/
}

// Namespace whizby / scripts\common\whizby
// Params 2
// Checksum 0x0, Offset: 0xac8
// Size: 0x86
function function_dbabf852a35102e4( var_31659d73698c898a, var_7f628b9bd51160d5 )
{
    var_45c4bee623ce2bf8 = abs( var_31659d73698c898a ) + abs( var_7f628b9bd51160d5 );
    
    if ( var_45c4bee623ce2bf8 > 0 )
    {
        rightfrac = var_31659d73698c898a / var_45c4bee623ce2bf8;
        upfrac = var_7f628b9bd51160d5 / var_45c4bee623ce2bf8;
    }
    else
    {
        rightfrac = 1;
        upfrac = 1;
    }
    
    if ( upfrac < 0 )
    {
        angle = 90 * rightfrac;
    }
    else
    {
        angle = 90 + 90 * upfrac;
        
        if ( rightfrac < 0 )
        {
            angle *= -1;
        }
    }
    
    return angle;
}

// Namespace whizby / scripts\common\whizby
// Params 3
// Checksum 0x0, Offset: 0xb57
// Size: 0x11e
function function_21676cfe493c7014( weapclass, distance, time )
{
    basemag = 0.8;
    
    switch ( weapclass )
    {
        case #"hash_fa24dff6bd60a12d":
            basemag = 1;
            break;
        case #"hash_6191aaef9f922f96":
            basemag = 1;
            break;
        case #"hash_900cb96c552c5e8e":
            basemag = 0.6;
            break;
        case #"hash_fa4dbdf6bd80bf52":
            basemag = 0.6;
            break;
    }
    
    distmultiplier = math::normalize_value( 50, 120, distance );
    distmultiplier = factor_value( 1, 0.5, distmultiplier );
    whizby_min = randomfloatrange( 0.08, 0.27 );
    timesincelast = time - self.whizby.lasttime;
    var_b2a42028cd0d9167 = math::normalize_value( 2000, 6000, timesincelast );
    var_9416ac5e3a43d3bd = math::factor_value( whizby_min, 1, var_b2a42028cd0d9167 );
    return basemag * distmultiplier * var_9416ac5e3a43d3bd;
}

// Namespace whizby / scripts\common\whizby
// Params 0
// Checksum 0x0, Offset: 0xc7e
// Size: 0x20
function function_bcd1a794fb26ee5c()
{
    self.whizby.cooldown = randomfloatrange( 100, 450 );
}

/#

    // Namespace whizby / scripts\common\whizby
    // Params 0
    // Checksum 0x0, Offset: 0xca6
    // Size: 0x4d, Type: dev
    function testwhizby()
    {
        setdevdvar( @"scr_whizby", 1 );
        
        if ( isbot( self ) )
        {
            return;
        }
        
        self endon( "<dev string:x3a>" );
        self endon( "<dev string:x40>" );
        thread function_4905c442ccddf750();
        
        while ( true )
        {
            self waittill( "<dev string:x4b>" );
            function_f3cad80dd510b802();
        }
    }

    // Namespace whizby / scripts\common\whizby
    // Params 0
    // Checksum 0x0, Offset: 0xcfb
    // Size: 0x43, Type: dev
    function function_4905c442ccddf750()
    {
        while ( true )
        {
            while ( !self buttonpressed( "<dev string:x59>" ) )
            {
                wait 0.05;
            }
            
            self notify( "<dev string:x4b>" );
            
            while ( self buttonpressed( "<dev string:x59>" ) )
            {
                wait 0.05;
            }
        }
    }

    // Namespace whizby / scripts\common\whizby
    // Params 0
    // Checksum 0x0, Offset: 0xd46
    // Size: 0x229, Type: dev
    function function_f3cad80dd510b802()
    {
        self endon( "<dev string:x4b>" );
        i = 0;
        dist = [ 10, 25, 50, 75 ];
        attacker = undefined;
        
        foreach ( player in level.players )
        {
            if ( player != self )
            {
                attacker = player;
            }
        }
        
        if ( !isdefined( attacker ) )
        {
            ai = getaiarray();
            
            if ( ai.size > 0 )
            {
                attacker = getclosest( self.origin, ai, 5000 );
            }
        }
        
        effecttime = gettime();
        
        while ( true )
        {
            if ( isdefined( attacker ) )
            {
                vecoffset = anglestoforward( self getplayerangles( 1 ) );
                dirtoattacker = vectornormalize( ( attacker.origin[ 0 ], attacker.origin[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
                var_86e3015864ec3379 = 1;
                vecoffset = rotatevector( dirtoattacker, ( 0, 90 * var_86e3015864ec3379, 0 ) );
                height = ( 0, 0, randomfloatrange( 45, 65 ) );
                position = self.origin + height + vecoffset * dist[ i ];
                self notify( "<dev string:x64>", attacker, dist[ i ], position, dirtoattacker * -1 );
                i++;
                
                if ( i >= dist.size )
                {
                    i = 0;
                }
            }
            
            switch ( getdvar( @"hash_a6017ebde71968e5" ) )
            {
                case #"hash_900cb06c552c5063":
                    wait 0.22;
                    break;
                case #"hash_28a7ce6c1f1955d9":
                    wait 0.3;
                    break;
                case #"hash_2f69646c2276faf4":
                    wait 0.75;
                    break;
                default:
                    wait 0.22;
                    break;
            }
        }
    }

    // Namespace whizby / scripts\common\whizby
    // Params 5
    // Checksum 0x0, Offset: 0xf77
    // Size: 0xdc, Type: dev
    function debugwhizby( attacker, position, backorigin, whizbymag, distance )
    {
        if ( isdefined( attacker ) && isdefined( position ) )
        {
            if ( isdefined( attacker.currentweapon ) && attacker tagexists( "<dev string:x71>" ) )
            {
                start = attacker gettagorigin( "<dev string:x71>" );
            }
            else
            {
                start = attacker.origin + ( 0, 0, 50 );
            }
            
            line( start, position, ( 1, 0, 0 ), 1, 1, 20 );
            line( backorigin, position, ( 0.5, 0.5, 0.5 ), 1, 1, 20 );
            iprintln( "<dev string:x7b>" + distance + "<dev string:x93>" + whizbymag + "<dev string:xa4>" );
        }
    }

#/
