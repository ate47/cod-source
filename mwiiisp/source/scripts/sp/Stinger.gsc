#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace stinger;

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x1f2
// Size: 0x6e
function init()
{
    if ( isdefined( level.player.stinger ) )
    {
        return;
    }
    
    level.player clearirtarget();
    level.player thread stingerfirednotify();
    level.player thread stringemissilefired();
    level.player thread stingertoggleloop();
    level.player thread stingerdeathcleanup();
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x268
// Size: 0x100
function clearirtarget()
{
    if ( !isdefined( self.stinger ) )
    {
        self.stinger = spawnstruct();
    }
    
    self.stinger.stingerlockstarttime = 0;
    self.stinger.stingerlockstarted = 0;
    self.stinger.stingerlockfinalized = 0;
    
    if ( isdefined( self.stinger.stingertarget ) )
    {
        cleartarget( gettarget( self.stinger.stingertarget ) );
    }
    
    self.stinger.stingertarget = undefined;
    self notify( "stinger_irt_cleartarget" );
    self notify( "stop_lockon_sound" );
    self notify( "stop_locked_sound" );
    self.stinger.stingerlocksound = undefined;
    self weaponlockfree();
    self weaponlocktargettooclose( 0 );
    self weaponlocknoclearance( 0 );
    self stoplocalsound( "clu_lock" );
    self stoplocalsound( "clu_aquiring_lock" );
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x370
// Size: 0x57
function stingerfirednotify()
{
    assert( self.classname == "player" );
    
    while ( true )
    {
        self waittill( "weapon_fired" );
        
        if ( !weaponhaslockon() )
        {
            continue;
        }
        
        self.stinger.lastfiredtime = gettime();
        self notify( "stinger_fired" );
    }
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x3cf
// Size: 0xa4
function stringemissilefired()
{
    assert( self.classname == "player" );
    
    while ( true )
    {
        self waittill( "missile_fire", missile );
        
        if ( isdefined( missile ) )
        {
            self.stinger.missile = missile;
            target = self.stinger.stingertarget;
            
            if ( isstillvalidtarget( target ) )
            {
                offset = getdesiredoffset( target );
                missile missile_settargetent( self.stinger.stingertarget, offset );
            }
        }
    }
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x47b
// Size: 0x9e
function getdesiredoffset( target )
{
    if ( isdefined( target.vehicletype ) && target scripts\common\vehicle::ishelicopter() )
    {
        return ( 0, 0, -100 );
    }
    else if ( is_equal( target.unittype, "soldier" ) || is_equal( target.unittype, "juggernaut" ) || is_equal( target.unittype, "suicidebomber" ) )
    {
        return ( 0, 0, 38 );
    }
    
    return ( 0, 0, 0 );
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x522
// Size: 0x12e
function stingertoggleloop()
{
    assert( self.classname == "player" );
    self endon( "death" );
    
    for ( ;; )
    {
        while ( !playerstingerads() )
        {
            wait 0.05;
        }
        
        self.stinger.lockontargets = [];
        self.stinger.targetids = [ "0", "1", "2", "3" ];
        thread stingerirtloop();
        
        while ( playerstingerads() )
        {
            wait 0.05;
        }
        
        self notify( "stinger_IRT_off" );
        clearirtarget();
        
        foreach ( target in self.stinger.lockontargets )
        {
            cleartarget( target );
        }
        
        self.stinger.lockontargets = undefined;
        self.stinger.targetids = undefined;
    }
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x658
// Size: 0x7c
function stingerdeathcleanup()
{
    self waittill( "death" );
    
    if ( isdefined( self.stinger.lockontargets ) )
    {
        foreach ( target in self.stinger.lockontargets )
        {
            cleartarget( target );
        }
    }
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x6dc
// Size: 0x2db
function stingerirtloop()
{
    assert( self.classname == "player" );
    self endon( "death" );
    self endon( "stinger_IRT_off" );
    
    for ( ;; )
    {
        wait 0.05;
        
        if ( self.stinger.stingerlockfinalized )
        {
            if ( !isstillvalidtarget( self.stinger.stingertarget ) )
            {
                clearirtarget();
                continue;
            }
            
            target = gettarget( self.stinger.stingertarget );
            thread looplocallocksound( "clu_lock", 0.75 );
            settargettooclose( self.stinger.stingertarget );
            continue;
        }
        
        if ( self.stinger.stingerlockstarted )
        {
            if ( !isstillvalidtarget( self.stinger.stingertarget ) )
            {
                clearirtarget();
                continue;
            }
            
            target = gettarget( self.stinger.stingertarget );
            timepassed = gettime() - self.stinger.stingerlockstarttime;
            
            if ( isdefined( self.stinger.lockonoverrideduration ) )
            {
                maxtime = self.stinger.lockonoverrideduration;
            }
            else
            {
                maxtime = ter_op( self.stinger.stingertarget scripts\common\vehicle::isvehicle(), 1300, 500 );
            }
            
            if ( timepassed < maxtime )
            {
                continue;
            }
            
            assert( isdefined( self.stinger.stingertarget ) );
            self notify( "stop_lockon_sound" );
            self notify( "stinger_locked_on" );
            self.stinger.stingerlockfinalized = 1;
            self weaponlockfinalize( self.stinger.stingertarget );
            settargettooclose( self.stinger.stingertarget );
            continue;
        }
        
        besttarget = getbeststingertarget();
        
        if ( !isdefined( besttarget ) )
        {
            continue;
        }
        
        if ( isdefined( self.stinger.lockontargetmarkergroup ) )
        {
            targetmarkergroupsetentitystate( self.stinger.lockontargetmarkergroup, besttarget.ent, 1 );
        }
        
        self.stinger.stingertarget = besttarget.ent;
        self.stinger.stingerlockstarttime = gettime();
        self.stinger.stingerlockstarted = 1;
        self notify( "stinger_lock_begin" );
        thread looplocalseeksound( "clu_aquiring_lock", 0.6 );
    }
}

// Namespace stinger / scripts\sp\stinger
// Params 4
// Checksum 0x0, Offset: 0x9bf
// Size: 0x194
function stinger_get_closest_to_player_view( array, player, use_eye, min_dot )
{
    if ( !array.size )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        player = level.player;
    }
    
    if ( !isdefined( min_dot ) )
    {
        min_dot = -1;
    }
    
    player_origin = player.origin;
    
    if ( isdefined( use_eye ) && use_eye )
    {
        player_origin = player geteye();
    }
    
    ent = undefined;
    player_angles = player getplayerangles();
    player_forward = anglestoforward( player_angles );
    dot = -1;
    
    foreach ( array_item in array )
    {
        angles = vectortoangles( array_item.origin - player_origin );
        forward = anglestoforward( angles );
        newdot = vectordot( player_forward, forward );
        dist = distancesquared( player_origin, array_item.origin );
        dist_score = 1 - math::normalize_value( squared( 250 ), squared( 5000 ), dist );
        newdot *= dist_score;
        
        if ( newdot < dot )
        {
            continue;
        }
        
        if ( newdot < min_dot )
        {
            continue;
        }
        
        dot = newdot;
        ent = array_item;
    }
    
    return ent;
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0xb5c
// Size: 0x294
function getbeststingertarget()
{
    allents = getcurrentents();
    lockontargets = self.stinger.lockontargets;
    
    if ( isdefined( self.stinger.stingertarget ) )
    {
        allents = array_remove( allents, self.stinger.stingertarget );
        lockontargets = array_remove( lockontargets, gettarget( self.stinger.stingertarget ) );
    }
    
    var_f06c1dfac83f0753 = [];
    
    for ( idx = 0; idx < allents.size ; idx++ )
    {
        ent = allents[ idx ];
        
        if ( haslos( ent ) )
        {
            var_f06c1dfac83f0753[ var_f06c1dfac83f0753.size ] = ent;
            continue;
        }
        
        target = gettarget( ent );
        
        if ( isdefined( target ) )
        {
            cleartarget( target );
        }
    }
    
    if ( var_f06c1dfac83f0753.size == 0 )
    {
        return undefined;
    }
    
    var_a7c5ffe4437069c2 = [];
    maxtargets = 4;
    
    if ( isdefined( self.stinger.stingertarget ) )
    {
        maxtargets--;
    }
    
    for ( i = 0; i < maxtargets ; i++ )
    {
        ent = stinger_get_closest_to_player_view( var_f06c1dfac83f0753, level.player, 1 );
        var_a7c5ffe4437069c2[ i ] = ent;
        var_f06c1dfac83f0753 = array_remove( var_f06c1dfac83f0753, ent );
        
        if ( var_f06c1dfac83f0753.size == 0 )
        {
            break;
        }
    }
    
    var_980b846a443b1f2b = var_a7c5ffe4437069c2;
    
    foreach ( target in lockontargets )
    {
        if ( !array_contains( var_980b846a443b1f2b, target.ent ) )
        {
            cleartarget( target );
            continue;
        }
        
        var_980b846a443b1f2b = array_remove( var_980b846a443b1f2b, target.ent );
    }
    
    foreach ( ent in var_980b846a443b1f2b )
    {
        addtarget( ent );
    }
    
    foreach ( chosenent in var_a7c5ffe4437069c2 )
    {
        if ( insidestingerreticlenolock( chosenent ) )
        {
            return gettarget( chosenent );
        }
    }
    
    return undefined;
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0xdf9
// Size: 0x88
function getcurrentents()
{
    ents = getaiarray( "axis" );
    vehicles = vehicle_getarray();
    
    foreach ( v in vehicles )
    {
        if ( is_equal( v.script_team, "axis" ) )
        {
            ents[ ents.size ] = v;
        }
    }
    
    return ents;
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0xe8a
// Size: 0x71
function gettarget( ent )
{
    foreach ( target in self.stinger.lockontargets )
    {
        if ( target.ent == ent )
        {
            return target;
        }
    }
    
    return undefined;
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0xf04
// Size: 0x14a
function addtarget( ent )
{
    assert( self.stinger.targetids.size > 0, "Lockon: no ids left to distribute!" );
    target = spawnstruct();
    target.ent = ent;
    target.id = self.stinger.targetids[ 0 ];
    
    if ( !isdefined( self.stinger.lockontargetmarkergroup ) )
    {
        self.stinger.lockontargetmarkergroup = createtargetmarkergroup( "lockontarget" );
        addclienttotargetmarkergroupmask( self.stinger.lockontargetmarkergroup, level.player );
    }
    
    targetmarkergroupaddentity( self.stinger.lockontargetmarkergroup, target.ent );
    self.stinger.targetids = array_remove( self.stinger.targetids, target.id );
    self.stinger.lockontargets[ self.stinger.lockontargets.size ] = target;
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x1056
// Size: 0x105
function cleartarget( target )
{
    if ( isdefined( self.stinger.lockontargetmarkergroup ) )
    {
        targetmarkergroupremoveentity( self.stinger.lockontargetmarkergroup, target.ent );
    }
    
    self.stinger.lockontargets = array_remove( self.stinger.lockontargets, target );
    self.stinger.targetids[ self.stinger.targetids.size ] = target.id;
    
    if ( self.stinger.lockontargets.size == 0 && isdefined( self.stinger.lockontargetmarkergroup ) )
    {
        deletetargetmarkergroup( self.stinger.lockontargetmarkergroup );
        self.stinger.lockontargetmarkergroup = undefined;
    }
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x1163
// Size: 0x24
function insidestingerreticlenolock( ent )
{
    return level.player worldpointinreticle_circle( getenthitpos( ent ), 65, 105 );
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x1190
// Size: 0x24
function insidestingerreticlelocked( ent )
{
    return level.player worldpointinreticle_circle( getenthitpos( ent ), 65, 105 );
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x11bd
// Size: 0x24
function insidestingerreticlelockoverride( ent )
{
    return level.player worldpointinreticle_circle( getenthitpos( ent ), 65, 105 );
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x11ea
// Size: 0x87, Type: bool
function haslos( ent )
{
    eyepos = self geteye();
    ignoreents = [ self, ent ];
    endpos = getenthitpos( ent );
    contents = scripts\engine\trace::create_contents( 1, 1, 0, 1, 0, 1, 0, 1 );
    traceresult = ray_trace( eyepos, endpos, ignoreents, contents );
    return distancesquared( traceresult[ "position" ], endpos ) <= 1;
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x127a
// Size: 0x45
function getenthitpos( ent )
{
    pos = ent.origin;
    offset = 38;
    pos += offset * anglestoup( ent.angles );
    return pos;
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x12c8
// Size: 0xc9, Type: bool
function isstillvalidtarget( ent )
{
    assert( self.classname == "player" );
    
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !isalive( ent ) )
    {
        return false;
    }
    
    if ( !insidestingerreticlelocked( ent ) )
    {
        return false;
    }
    
    if ( !haslos( ent ) )
    {
        return false;
    }
    
    if ( insidestingerreticlelockoverride( self.stinger.stingertarget ) || self.stinger.stingerlockstarted && !self.stinger.stingerlockfinalized )
    {
        return true;
    }
    
    besttarget = getbeststingertarget();
    
    if ( isdefined( besttarget ) && insidestingerreticlelockoverride( besttarget.ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x139a
// Size: 0x38, Type: bool
function playerstingerads()
{
    assert( self.classname == "player" );
    
    if ( !weaponhaslockon() )
    {
        return false;
    }
    
    if ( self playerads() == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace stinger / scripts\sp\stinger
// Params 0
// Checksum 0x0, Offset: 0x13db
// Size: 0x36, Type: bool
function weaponhaslockon()
{
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon hasattachment( "lalphascope" ) )
    {
        return true;
    }
    
    if ( currentweapon hasattachment( "lnchrscope_lalpha" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace stinger / scripts\sp\stinger
// Params 1
// Checksum 0x0, Offset: 0x141a
// Size: 0xa0
function settargettooclose( ent )
{
    assert( self.classname == "player" );
    var_14f87fbccd62729c = 250;
    
    if ( !isdefined( ent ) )
    {
        return 0;
    }
    
    dist = distance2d( self.origin, ent.origin );
    
    if ( dist < var_14f87fbccd62729c )
    {
        self.stinger.targettoclose = 1;
        self weaponlocktargettooclose( 1 );
        return;
    }
    
    self.stinger.targettoclose = 0;
    self weaponlocktargettooclose( 0 );
}

// Namespace stinger / scripts\sp\stinger
// Params 2
// Checksum 0x0, Offset: 0x14c2
// Size: 0x46
function looplocalseeksound( alias, interval )
{
    assert( self.classname == "player" );
    self endon( "stop_lockon_sound" );
    self endon( "death" );
    
    for ( ;; )
    {
        self playlocalsound( alias );
        wait interval;
    }
}

// Namespace stinger / scripts\sp\stinger
// Params 2
// Checksum 0x0, Offset: 0x1510
// Size: 0xc4
function looplocallocksound( alias, interval )
{
    assert( self.classname == "player" );
    self endon( "stop_locked_sound" );
    self endon( "death" );
    
    if ( isdefined( self.stinger.stingerlocksound ) )
    {
        return;
    }
    
    self.stinger.stingerlocksound = 1;
    
    for ( ;; )
    {
        self playlocalsound( alias );
        self playrumbleonentity( "slide_start" );
        wait interval / 3;
        self playrumbleonentity( "slide_start" );
        wait interval / 3;
        self playrumbleonentity( "slide_start" );
        wait interval / 3;
        self stoprumble( "slide_start" );
    }
    
    self.stinger.stingerlocksound = undefined;
}

