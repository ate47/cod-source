#using scripts\anim\battlechatter_events;
#using scripts\anim\combat_utility;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\throwgrenade;
#using scripts\common\utility;

#namespace throwgrenade;

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 3
// Checksum 0x0, Offset: 0x25a
// Size: 0x139
function playanim_throwgrenade( asmname, statename, params )
{
    throwdata = spawnstruct();
    throwdata.xanim = self.throwdata_animindex;
    throwdata.vel = self.throwdata_throwvelocity;
    throwdata.target = self._blackboard.throwgrenadetarget;
    throwdata.targetpos = self._blackboard.var_166faa0e61b0570c;
    throwdata.fastthrow = self.throwdata_fastthrow;
    throwdata.withbounce = self.throwdata_withbounce;
    throwdata.time = self.throwdata_time;
    assert( isdefined( throwdata ) );
    assert( gettime() - throwdata.time <= 100 );
    self.ispreppinggrenade = 1;
    bthrew = trygrenadethrow( asmname, statename, throwdata );
    
    if ( !bthrew )
    {
        self endon( statename + "_finished" );
        wait 0.2;
        asm_fireevent( asmname, "end" );
    }
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 3
// Checksum 0x0, Offset: 0x39b
// Size: 0x3d
function playcoveranim_throwgrenade( asmname, statename, params )
{
    if ( isdefined( self.node ) )
    {
        self.keepclaimednodeifvalid = 1;
    }
    
    scripts\asm\soldier\throwgrenade::playanim_throwgrenade( asmname, statename, params );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 2
// Checksum 0x0, Offset: 0x3e0
// Size: 0x59
function detachgrenade( model, tag )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !istrue( self.isholdinggrenade ) )
    {
        return;
    }
    
    if ( isdefined( self.oldgrenawareness ) )
    {
        self.grenadeawareness = self.oldgrenawareness;
        self.oldgrenawareness = undefined;
    }
    
    self detach( model, tag );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 3
// Checksum 0x0, Offset: 0x441
// Size: 0x2c
function playcoveranim_throwgrenade_cleanup( asmname, statename, params )
{
    self function_4ea7891f787c6725();
    playanim_throwgrenade_cleanup( asmname, statename, params );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 3
// Checksum 0x0, Offset: 0x475
// Size: 0xb4
function playanim_throwgrenade_cleanup( asmname, statename, params )
{
    self._blackboard.throwdata = undefined;
    asm_fireephemeralevent( "throwgrenade", "end" );
    model = scripts\anim\utility_common::getgrenademodel();
    
    if ( isdefined( self.grenadeattachtag ) )
    {
        detachgrenade( model, self.grenadeattachtag );
        self.grenadeattachtag = undefined;
    }
    
    if ( ( utility::issp() || utility::iscp() ) && isdefined( self.isholdinggrenade ) )
    {
        scripts\anim\combat_utility::dropgrenade();
        self.isholdinggrenade = undefined;
    }
    
    self.ispreppinggrenade = undefined;
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 1
// Checksum 0x0, Offset: 0x531
// Size: 0x3e, Type: bool
function shouldbounce( objgrenadeweapon )
{
    grenadetype = objgrenadeweapon.basename;
    return grenadetype != "antigrav" && grenadetype != "emp" && grenadetype != "c8_grenade";
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 4
// Checksum 0x0, Offset: 0x578
// Size: 0x2cb, Type: bool
function trygrenadethrow( asmname, statename, throwdata, throwinthread )
{
    destination = throwdata.targetpos;
    throwingat = throwdata.target;
    withbounce = throwdata.withbounce;
    
    if ( !isdefined( withbounce ) )
    {
        withbounce = 1;
    }
    
    assert( isdefined( throwdata.xanim ) );
    
    if ( isdefined( destination ) )
    {
        armoffset = getgrenadethrowoffset( statename, throwdata.xanim );
        
        if ( !isdefined( throwdata.fastthrow ) )
        {
            throwvel = self checkgrenadethrowpos( armoffset, destination, withbounce, "min energy", "min time", "max time" );
        }
        else
        {
            throwvel = self checkgrenadethrowpos( armoffset, destination, withbounce, "min time", "min energy" );
        }
    }
    else
    {
        throwvel = throwdata.vel;
        assert( isdefined( throwvel ) );
    }
    
    throwingat = throwdata.target;
    
    if ( isdefined( throwvel ) )
    {
        if ( !isdefined( self.oldgrenawareness ) )
        {
            self.oldgrenawareness = self.grenadeawareness;
        }
        
        self.grenadeawareness = 0;
        
        /#
            if ( getdvar( @"anim_debug" ) == "<dev string:x1c>" )
            {
                thread scripts\anim\utility::debugpos( destination, "<dev string:x1e>" );
            }
        #/
        
        var_3251b898a0907271 = getdesiredgrenadetimervalue();
        setgrenadetimer( min( gettime() + 3000, var_3251b898a0907271 ) );
        var_e57aea3945878349 = 0;
        
        if ( isdefined( throwingat ) && usingplayergrenadetimer() )
        {
            assert( throwingat == self.var_a3441d87a95e9040 );
            throwingat function_e89f2bdb307f137e();
            thread reducegiptponkillanimscript( statename, throwingat );
            
            if ( throwingat function_4c108309dc0d7fd2() > 1 )
            {
                var_e57aea3945878349 = 1;
            }
            
            if ( self.var_cc183df556f63da0 == "lethal" )
            {
                if ( throwingat function_4c108309dc0d7fd2() <= 1 )
                {
                    throwingat function_ff4aa047884e7a14( gettime() );
                }
            }
        }
        
        /#
            if ( getdvar( @"grenade_spam" ) == "<dev string:x20>" )
            {
                var_3251b898a0907271 = 0;
            }
        #/
        
        if ( isdefined( throwinthread ) )
        {
            thread dogrenadethrow( asmname, statename, throwdata.xanim, throwvel, var_3251b898a0907271, var_e57aea3945878349 );
        }
        else
        {
            dogrenadethrow( asmname, statename, throwdata.xanim, throwvel, var_3251b898a0907271, var_e57aea3945878349 );
        }
        
        return true;
    }
    else
    {
        /#
            function_c3d487ba233976c7( "<dev string:x23>" );
        #/
        
        /#
            if ( getdvar( @"hash_4f3a4c91fee3cc20" ) == "<dev string:x20>" && isdefined( throwdata.destination ) )
            {
                armoffset = getgrenadethrowoffset( statename, throwdata.xanim );
                thread grenadeline( armoffset, destination );
            }
        #/
    }
    
    return false;
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 0
// Checksum 0x0, Offset: 0x84c
// Size: 0x7b
function getdesiredgrenadetimervalue()
{
    var_3251b898a0907271 = undefined;
    
    if ( usingplayergrenadetimer() )
    {
        player = self.var_a3441d87a95e9040;
        var_3251b898a0907271 = gettime() + player.gs.playergrenadebasetime + randomint( player.gs.playergrenaderangetime );
    }
    else
    {
        var_3251b898a0907271 = gettime() + 30000 + randomint( 30000 );
    }
    
    return var_3251b898a0907271;
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 0
// Checksum 0x0, Offset: 0x8d0
// Size: 0x2b, Type: bool
function usingplayergrenadetimer()
{
    assert( self.var_423e348b1ba9f198 );
    return self.var_58c197914dd654e0 && isdefined( self.var_a3441d87a95e9040 );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 2
// Checksum 0x0, Offset: 0x904
// Size: 0x30
function reducegiptponkillanimscript( statename, throwingat )
{
    self endon( "dont_reduce_giptp_on_killanimscript" );
    self waittill( statename + "_finished" );
    
    if ( isdefined( throwingat ) )
    {
        throwingat function_a33073d6fd58e58e();
    }
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 6
// Checksum 0x0, Offset: 0x93c
// Size: 0x4e6
function dogrenadethrow( asmname, statename, throw_anim, throwvel, var_3251b898a0907271, var_e57aea3945878349 )
{
    self endon( "killanimscript" );
    self endon( statename + "_finished" );
    
    /#
        thread grenadedebug( statename, "<dev string:x3c>", 3 );
    #/
    
    asm_fireephemeralevent( "throwgrenade", "start" );
    covernode = scripts\asm\asm_bb::bb_getcovernode();
    
    if ( !isdefined( covernode ) || covernode.type == "Exposed" || covernode.type == "Path" )
    {
        self orientmode( "face direction", throwvel );
    }
    
    bodyknob = asm_getbodyknob();
    assert( isdefined( bodyknob ) );
    throw_xanim = asm_getxanim( statename, throw_anim );
    addbattlechatternotify( self, undefined, "grenade_throw", scripts\anim\battlechatter_events::function_c666e714b2411844( self.grenadeweapon ) );
    asm_playfacialanim( asmname, statename, throw_xanim );
    self aisetanim( statename, throw_anim, fasteranimspeed() );
    thread asm_donotetracks( asmname, statename );
    model = scripts\anim\utility_common::getgrenademodel();
    attachside = "none";
    var_9930afea4de87021 = 0;
    
    while ( !var_9930afea4de87021 )
    {
        self waittill( statename, notes );
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        foreach ( notetrack in notes )
        {
            if ( notetrack == "grenade_right" )
            {
                attachside = attachgrenademodel( statename, model, "tag_accessory_right" );
                self.isholdinggrenade = 1;
                self.grenadeattachtag = "tag_accessory_right";
            }
            else if ( notetrack == "grenade_left" )
            {
                attachside = attachgrenademodel( statename, model, "tag_accessory_left" );
                self.isholdinggrenade = 1;
                self.grenadeattachtag = "tag_accessory_left";
            }
            
            if ( notetrack == "grenade_throw" || notetrack == "grenade throw" )
            {
                var_9930afea4de87021 = 1;
                continue;
            }
            
            assert( notetrack != "end" );
            
            if ( notetrack == "end" )
            {
                self.var_a3441d87a95e9040 function_a33073d6fd58e58e();
                self notify( "dont_reduce_giptp_on_killanimscript" );
                return 0;
            }
        }
    }
    
    /#
        if ( getdvar( @"hash_27494f1d75fc0809" ) == "<dev string:x20>" )
        {
            tags = [];
            numtags = self getattachsize();
            emptyslot = [];
            
            for ( i = 0; i < numtags ; i++ )
            {
                name = self getattachmodelname( i );
                
                if ( issubstr( name, "<dev string:x4b>" ) )
                {
                    tagname = self getattachtagname( i );
                    emptyslot[ tagname ] = 0;
                    tags[ tags.size ] = tagname;
                }
            }
            
            for ( i = 0; i < tags.size ; i++ )
            {
                emptyslot[ tags[ i ] ]++;
                
                if ( emptyslot[ tags[ i ] ] < 2 )
                {
                    continue;
                }
                
                iprintlnbold( "<dev string:x52>" );
                println( "<dev string:x7d>", throw_xanim, "<dev string:x96>", tags[ i ] );
                break;
            }
        }
    #/
    
    /#
        thread grenadedebug( statename, "<dev string:xb9>", 5 );
    #/
    
    self notify( "dont_reduce_giptp_on_killanimscript" );
    var_ddda1dbc4b1d9bfb = usingplayergrenadetimer();
    
    if ( var_ddda1dbc4b1d9bfb )
    {
        thread watchgrenadetowardsplayer( statename, self.var_a3441d87a95e9040, var_3251b898a0907271 );
    }
    else
    {
        thread function_8337cab97d859a28( statename );
        setgrenadetimer( var_3251b898a0907271 );
    }
    
    throwngrenade = self throwgrenade();
    
    if ( var_e57aea3945878349 && var_ddda1dbc4b1d9bfb )
    {
        player = self.var_a3441d87a95e9040;
        assert( isplayer( player ) );
        
        if ( player function_4c108309dc0d7fd2() > 1 || gettime() - player function_df95fe0fcee94bf3() < 2000 )
        {
            function_e4da167dc330b3d3( player, gettime() + min( 5000, player.gs.playerdoublegrenadetime ) );
        }
    }
    
    self notify( "stop grenade check" );
    
    if ( attachside != "none" )
    {
        self detach( model, attachside );
    }
    
    self.isholdinggrenade = undefined;
    self.ispreppinggrenade = undefined;
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
    self.throwgrenadeatenemyasap = 0;
    
    if ( isdefined( throwngrenade ) && self.team == "axis" )
    {
        level notify( "enemy_grenade_fire", throwngrenade );
    }
    
    self waittillmatch( statename, "end" );
    self notify( "done_grenade_throw" );
    self notify( "weapon_switch_done" );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 0
// Checksum 0x0, Offset: 0xe2a
// Size: 0x7
function fasteranimspeed()
{
    return 1.5;
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 3
// Checksum 0x0, Offset: 0xe3a
// Size: 0x25
function attachgrenademodel( statename, model, tag )
{
    self attach( model, tag );
    return tag;
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 1
// Checksum 0x0, Offset: 0xe68
// Size: 0x1c
function waittillscriptchange( statename )
{
    self endon( statename + "_finished" );
    self waittill( "killanimscript" );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 3
// Checksum 0x0, Offset: 0xe8c
// Size: 0x62
function detachgrenadeonscriptchange( statename, model, tag )
{
    self endon( "stop grenade check" );
    waittillscriptchange( statename );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.oldgrenawareness ) )
    {
        self.grenadeawareness = self.oldgrenawareness;
        self.oldgrenawareness = undefined;
    }
    
    self detach( model, tag );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 1
// Checksum 0x0, Offset: 0xef6
// Size: 0xd2
function function_8337cab97d859a28( statename )
{
    timeoutobj = spawnstruct();
    timeoutobj thread watchgrenadetowardstargettimeout( 5 );
    timeoutobj endon( "watchGrenadeTowardsTargetTimeout" );
    grenade = getgrenadeithrew( statename );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    /#
        grenade thread grenadedebug( statename, "<dev string:xbf>", 5 );
    #/
    
    for ( prevorigin = grenade.origin; true ; prevorigin = grenade.origin )
    {
        wait 0.1;
        
        if ( !isdefined( grenade ) )
        {
            break;
        }
        
        if ( distancesquared( grenade.origin, prevorigin ) < 400 )
        {
            /#
                grenade thread grenadedebug( statename, "<dev string:xc8>", 5 );
            #/
            
            function_16bae3e0b0aa09e3( grenade.origin );
            break;
        }
    }
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 3
// Checksum 0x0, Offset: 0xfd0
// Size: 0x37
function watchgrenadetowardsplayer( statename, player, var_3251b898a0907271 )
{
    player endon( "death" );
    watchgrenadetowardsplayerinternal( statename, var_3251b898a0907271 );
    
    if ( isdefined( player ) )
    {
        player function_a33073d6fd58e58e();
    }
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 2
// Checksum 0x0, Offset: 0x100f
// Size: 0x23c
function watchgrenadetowardsplayerinternal( statename, var_3251b898a0907271 )
{
    var_cc183df556f63da0 = self.var_cc183df556f63da0;
    timeoutobj = spawnstruct();
    timeoutobj thread watchgrenadetowardstargettimeout( 5 );
    timeoutobj endon( "watchGrenadeTowardsTargetTimeout" );
    type = self.grenadeweapon.basename;
    grenade = getgrenadeithrew( statename );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    setgrenadetimer( min( gettime() + 5000, var_3251b898a0907271 ) );
    
    /#
        grenade thread grenadedebug( statename, "<dev string:xbf>", 5 );
    #/
    
    goodradiussqrd = 62500;
    giveupradiussqrd = 160000;
    
    if ( type == "flash_grenade" )
    {
        goodradiussqrd = 810000;
        giveupradiussqrd = 1690000;
    }
    
    playerstocheck = level.players;
    prevorigin = grenade.origin;
    haslanded = 0;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !isdefined( grenade ) )
        {
            break;
        }
        
        if ( distancesquared( grenade.origin, prevorigin ) < 400 )
        {
            /#
                grenade thread grenadedebug( statename, "<dev string:xc8>", 5 );
            #/
            
            if ( !haslanded )
            {
                function_16bae3e0b0aa09e3( grenade.origin );
                haslanded = 1;
            }
            
            newplayerstocheck = [];
            
            for ( i = 0; i < playerstocheck.size ; i++ )
            {
                player = playerstocheck[ i ];
                
                if ( !isdefined( player ) || !isalive( player ) )
                {
                    continue;
                }
                
                distsqrd = distancesquared( grenade.origin, player.origin );
                
                if ( distsqrd < goodradiussqrd )
                {
                    /#
                        grenade thread grenadedebug( statename, "<dev string:xcf>", 5 );
                    #/
                    
                    player grenadelandednearplayer( var_cc183df556f63da0, var_3251b898a0907271 );
                    continue;
                }
                
                if ( distsqrd < giveupradiussqrd )
                {
                    newplayerstocheck[ newplayerstocheck.size ] = player;
                }
            }
            
            playerstocheck = newplayerstocheck;
            
            if ( playerstocheck.size == 0 )
            {
                break;
            }
        }
        
        prevorigin = grenade.origin;
    }
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 2
// Checksum 0x0, Offset: 0x1253
// Size: 0x8c
function grenadelandednearplayer( var_cc183df556f63da0, var_3251b898a0907271 )
{
    player = self;
    function_98deae9464f6c005( 0 );
    curtime = gettime();
    
    if ( curtime - player function_df95fe0fcee94bf3() < 3000 )
    {
        function_e4da167dc330b3d3( player, curtime + player.gs.playerdoublegrenadetime );
    }
    
    player function_4f19cf7b3c28acd7( curtime );
    oldvalue = function_9752a69f79a06b7a( player, var_cc183df556f63da0 );
    aisetgrenadetimer( player, var_cc183df556f63da0, max( var_3251b898a0907271, oldvalue ) );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 1
// Checksum 0x0, Offset: 0x12e7
// Size: 0x95
function setgrenadetimer( newvalue )
{
    if ( usingplayergrenadetimer() && isalive( self.var_a3441d87a95e9040 ) )
    {
        player = self.var_a3441d87a95e9040;
        weapontype = self.var_cc183df556f63da0;
        oldvalue = function_9752a69f79a06b7a( player, weapontype );
        aisetgrenadetimer( player, weapontype, max( newvalue, oldvalue ) );
        return;
    }
    
    weapontype = self.var_cc183df556f63da0;
    oldvalue = function_9752a69f79a06b7a( undefined, weapontype );
    aisetgrenadetimer( undefined, weapontype, max( newvalue, oldvalue ) );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 1
// Checksum 0x0, Offset: 0x1384
// Size: 0x2f
function getgrenadeithrew( statename )
{
    self endon( "killanimscript" );
    self endon( statename + "_finished" );
    self waittill( "grenade_fire", grenade );
    return grenade;
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 1
// Checksum 0x0, Offset: 0x13bc
// Size: 0x15
function watchgrenadetowardstargettimeout( timerlength )
{
    wait timerlength;
    self notify( "watchGrenadeTowardsTargetTimeout" );
}

// Namespace throwgrenade / scripts\asm\soldier\throwgrenade
// Params 1
// Checksum 0x0, Offset: 0x13d9
// Size: 0x72
function offsettoorigin( start )
{
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    up = anglestoup( self.angles );
    forward *= start[ 0 ];
    right *= start[ 1 ];
    up *= start[ 2 ];
    return forward + right + up;
}

/#

    // Namespace throwgrenade / scripts\asm\soldier\throwgrenade
    // Params 2
    // Checksum 0x0, Offset: 0x1454
    // Size: 0x88, Type: dev
    function grenadeline( start, end )
    {
        level notify( "<dev string:xe2>" );
        level endon( "<dev string:xe2>" );
        start = self.origin + offsettoorigin( start );
        
        for ( ;; )
        {
            line( start, end, ( 1, 0, 1 ) );
            print3d( start, start, ( 0.2, 0.5, 1 ), 1, 1 );
            print3d( end, end, ( 0.2, 0.5, 1 ), 1, 1 );
            wait 0.05;
        }
    }

    // Namespace throwgrenade / scripts\asm\soldier\throwgrenade
    // Params 1
    // Checksum 0x0, Offset: 0x14e4
    // Size: 0x30, Type: dev
    function function_c3d487ba233976c7( reason )
    {
        if ( getdvar( @"hash_2f0d3d5b9e9dbd3" ) != "<dev string:x1c>" )
        {
            return;
        }
        
        self.var_53cfc52e74b46509 = reason;
    }

    // Namespace throwgrenade / scripts\asm\soldier\throwgrenade
    // Params 4
    // Checksum 0x0, Offset: 0x151c
    // Size: 0x119, Type: dev
    function grenadedebug( statename, state, duration, var_312ba7f72a3a2b1c )
    {
        if ( getdvar( @"hash_2f0d3d5b9e9dbd3" ) != "<dev string:x1c>" )
        {
            return;
        }
        
        self notify( "<dev string:xec>" );
        self endon( "<dev string:xec>" );
        self endon( "<dev string:xfa>" );
        self endon( statename + "<dev string:x109>" );
        self endon( "<dev string:x113>" );
        endtime = gettime() + 1000 * duration;
        
        while ( gettime() < endtime )
        {
            print3d( self getshootatpos() + ( 0, 0, 10 ), state );
            
            if ( isdefined( var_312ba7f72a3a2b1c ) && isdefined( self.var_53cfc52e74b46509 ) )
            {
                print3d( self getshootatpos() + ( 0, 0, 0 ), "<dev string:x119>" + self.var_53cfc52e74b46509 );
            }
            else if ( self.var_423e348b1ba9f198 )
            {
                print3d( self getshootatpos() + ( 0, 0, 0 ), "<dev string:x122>" + function_96d556dea441d1dc() );
            }
            
            wait 0.05;
        }
    }

    // Namespace throwgrenade / scripts\asm\soldier\throwgrenade
    // Params 0
    // Checksum 0x0, Offset: 0x163d
    // Size: 0x78, Type: dev
    function function_96d556dea441d1dc()
    {
        if ( usingplayergrenadetimer() )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                if ( level.players[ i ] == self.var_a3441d87a95e9040 )
                {
                    break;
                }
            }
            
            return ( "<dev string:x12a>" + i + 1 + "<dev string:x132>" + self.var_cc183df556f63da0 );
        }
        
        return "<dev string:x134>" + self.var_cc183df556f63da0;
    }

    // Namespace throwgrenade / scripts\asm\soldier\throwgrenade
    // Params 2
    // Checksum 0x0, Offset: 0x16bd
    // Size: 0x4e4, Type: dev
    function function_7ce8f6913eb4c152( asmname, archetypename )
    {
        assertex( isdefined( self.animsetname ) && self.animsetname == asmname, "<dev string:x138>" );
        rootknob = archetypegetalias( archetypename, "<dev string:x18d>", "<dev string:x193>", 0 );
        rootknob = rootknob.anims;
        animarray = "<dev string:x198>" + archetypename + "<dev string:x1b2>";
        offsetarray = "<dev string:x1b6>" + archetypename + "<dev string:x1b2>";
        println( "<dev string:x1d2>" );
        println( "<dev string:x21f>" + archetypename + "<dev string:x24a>" );
        println( "<dev string:x25d>" + animarray + "<dev string:x25f>" );
        println( "<dev string:x25d>" + offsetarray + "<dev string:x25f>" );
        allstates = asmdevgetallstates( asmname );
        
        foreach ( statename in allstates )
        {
            var_3e95892f99a9b61c = 0;
            aliases = archetypegetaliases( archetypename, statename );
            
            if ( isdefined( aliases ) )
            {
                foreach ( alias in aliases )
                {
                    if ( issubstr( statename, "<dev string:x266>" ) || issubstr( statename, "<dev string:x26e>" ) )
                    {
                        throwanims = asm_getallanimindicesforalias( statename, alias );
                        throwxanim0 = asm_getxanim( statename, throwanims[ 0 ] );
                        assert( !animhasnotetrack( throwxanim0, "<dev string:x274>" ) );
                        
                        if ( animhasnotetrack( throwxanim0, "<dev string:x282>" ) )
                        {
                            foreach ( animidx in throwanims )
                            {
                                xanim = asm_getxanim( statename, animidx );
                                assert( animhasnotetrack( xanim, "<dev string:x282>" ) && !animhasnotetrack( xanim, "<dev string:x274>" ) );
                            }
                            
                            println( "<dev string:x25d>" + animarray + "<dev string:x290>" + statename + "<dev string:x294>" + alias + "<dev string:x29b>" + statename + "<dev string:x2c7>" + alias + "<dev string:x2cc>" );
                            println( "<dev string:x25d>" + offsetarray + "<dev string:x290>" + statename + "<dev string:x294>" + alias + "<dev string:x2d1>" );
                            
                            foreach ( animidx in throwanims )
                            {
                                xanim = asm_getxanim( statename, animidx );
                                notetracktimes = getnotetracktimes( xanim, "<dev string:x282>" );
                                self clearanim( rootknob, 0 );
                                self setanimrestart( xanim, 1, 0, 0 );
                                wait 0.05;
                                startpos = self.origin;
                                startangles = self.angles;
                                self setanimtime( xanim, notetracktimes[ 0 ] );
                                wait 0.05;
                                animdelta = getmovedelta( xanim, 0, notetracktimes[ 0 ] );
                                startpos -= rotatevector( animdelta, startangles );
                                handpos = self gettagorigin( "<dev string:x2db>" );
                                handangles = self gettagangles( "<dev string:x2db>" );
                                localhandpos = rotatevectorinverted( handpos - startpos, startangles );
                                line( handpos, handpos + anglestoforward( handangles ) * 12, ( 0, 0, 1 ), 1, 0, 5 );
                                line( handpos, handpos + anglestoleft( handangles ) * 12, ( 1, 0, 0 ), 1, 0, 5 );
                                line( handpos, handpos + anglestoup( handangles ) * 12, ( 0, 1, 0 ), 1, 0, 5 );
                                wait 0.25;
                                println( "<dev string:x25d>" + offsetarray + "<dev string:x290>" + statename + "<dev string:x294>" + alias + "<dev string:x2ef>" + ianim + "<dev string:x2f5>" + localhandpos + "<dev string:x2fb>" );
                            }
                            
                            println( "<dev string:x2fd>" + animarray + "<dev string:x290>" + statename + "<dev string:x294>" + alias + "<dev string:x307>" + offsetarray + "<dev string:x290>" + statename + "<dev string:x294>" + alias + "<dev string:x314>" );
                        }
                    }
                }
            }
        }
    }

    // Namespace throwgrenade / scripts\asm\soldier\throwgrenade
    // Params 0
    // Checksum 0x0, Offset: 0x1ba9
    // Size: 0x16, Type: dev
    function function_d4917a3a4a6f232a()
    {
        function_7ce8f6913eb4c152( "<dev string:x320>", "<dev string:x320>" );
    }

#/
