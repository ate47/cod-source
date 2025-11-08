#using scripts\aitypes\bt_util;
#using scripts\aitypes\stealth;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\event;
#using scripts\stealth\friendly;
#using scripts\stealth\group;
#using scripts\stealth\neutral;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;

#namespace stealth;

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x307
// Size: 0x8e
function initstealthfunctions()
{
    self.fnsetstealthstate = &scripts\aitypes\stealth::scrsetstealthstate;
    self.fnisinstealthidle = &scripts\aitypes\stealth::isidle;
    self.fnisinstealthinvestigate = &scripts\aitypes\stealth::isinvestigating;
    self.fnisinstealthhunt = &scripts\aitypes\stealth::ishunting;
    self.fnisinstealthcombat = &scripts\aitypes\stealth::iscombating;
    self.fnisinstealthidlescriptedanim = &scripts\aitypes\stealth::isidlescriptedanim;
    self.fnstealthupdatevisionforlighting = &scripts\aitypes\stealth::updatevisionforlighting;
    self.fnstealthisidlecurious = &scripts\aitypes\stealth::isidlecurious;
    self.fnclearstealthvolume = &scripts\aitypes\stealth::clearstealthvolume;
    self.var_743f5eeb386835f5 = &scripts\aitypes\stealth::function_9c4a08f7dcd2796b;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x39d
// Size: 0x32, Type: bool
function isidlescriptedanim()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 0 && self._blackboard.idlenodeisvalid;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x3d8
// Size: 0x1b, Type: bool
function isidle()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 0;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x3fc
// Size: 0x1c, Type: bool
function isinvestigating()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 1;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x421
// Size: 0x1c, Type: bool
function ishunting()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 2;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x446
// Size: 0x1c, Type: bool
function iscombating()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 3;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x46b
// Size: 0x1b
function stealth_initfriendly( taskid )
{
    scripts\stealth\friendly::main();
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x48f
// Size: 0x1f
function stealth_terminatefriendly( taskid )
{
    self.stealth = undefined;
    self.stealth_enabled = 0;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x4b6
// Size: 0x1b
function stealth_initneutral( taskid )
{
    scripts\stealth\neutral::main();
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x4da
// Size: 0x23, Type: bool
function isinlight( lightvalue )
{
    if ( !isdefined( lightvalue ) )
    {
        return !istrue( level.is_dark );
    }
    
    return lightvalue >= 0.5;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x506
// Size: 0x2
function updatevisionforlighting()
{
    
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x510
// Size: 0x132
function forceflashlightplayercanseeifnecessary()
{
    if ( isdefined( self.flashlight ) && self.flashlight )
    {
        var_4f9b0be341b4c88d = 0.1;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.nvg ) && isdefined( player.nvg.lightmeter ) && player.nvg.lightmeter > var_4f9b0be341b4c88d && isdefined( player.nvg.prevlightmeter ) && player.nvg.lightmeter - player.nvg.prevlightmeter > 0.01 )
            {
                if ( self aipointinfov( player.origin ) && !self cansee( player ) )
                {
                    self cansee( player, 0 );
                }
            }
        }
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x64a
// Size: 0xbd
function function_e75ff8b7f46a7761( taskid )
{
    shouldupdatelightmeter = ent_flag_exist( "react_to_dynolights" ) && ent_flag( "react_to_dynolights" );
    
    if ( shouldupdatelightmeter && !isdefined( self.lightmeter ) )
    {
        scripts\stealth\utility::update_light_meter();
        shouldupdatelightmeter = 0;
    }
    
    updatelightbasedflashlight( self.stealth_bsmstate, 0.5 );
    
    if ( shouldupdatelightmeter )
    {
        entnum = self getentitynumber();
        frametime = level.frameduration;
        assert( isdefined( frametime ) );
        
        if ( gettime() / frametime % 5 == entnum % 5 )
        {
            scripts\stealth\utility::update_light_meter();
        }
    }
    
    forceflashlightplayercanseeifnecessary();
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x710
// Size: 0x37
function function_fe4155eb92b02f4a()
{
    if ( !self isinscriptedstate() )
    {
        if ( istrue( self.var_efe2696bf37f54b9 ) )
        {
            self.gunposeoverride_internal = "gun_down";
            return;
        }
        
        self.gunposeoverride_internal = "ready";
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 2
// Checksum 0x0, Offset: 0x74f
// Size: 0x220
function updatelightbasedflashlight( state, var_45af66a61bdb7b50 )
{
    if ( self isinscriptedstate() )
    {
        return;
    }
    
    if ( gettime() == self.starttime )
    {
        return;
    }
    
    lightmeter = self.lightmeter;
    
    /#
        if ( getdvarint( @"hash_7cbaa1208f238b77", 0 ) )
        {
            lightmeter = 0;
        }
    #/
    
    if ( isdefined( self._blackboard.bflashlight ) )
    {
        var_1a544a7e8d153ea = self._blackboard.bflashlight;
    }
    else
    {
        var_1a544a7e8d153ea = 0;
    }
    
    if ( isdefined( self.flashlightoverride ) )
    {
        self._blackboard.bflashlight = self.flashlightoverride;
    }
    else if ( istrue( self.noflashlight ) )
    {
        self._blackboard.bflashlight = 0;
    }
    else if ( isdefined( lightmeter ) )
    {
        var_d962c2ec5a81d7a3 = 0.1;
        
        if ( istrue( self._blackboard.bflashlight ) )
        {
            if ( lightmeter > var_45af66a61bdb7b50 + var_d962c2ec5a81d7a3 )
            {
                self._blackboard.bflashlight = 0;
            }
        }
        else
        {
            self._blackboard.bflashlight = lightmeter < var_45af66a61bdb7b50;
        }
    }
    else if ( istrue( level.is_dark ) )
    {
        self._blackboard.bflashlight = 1;
    }
    else
    {
        self._blackboard.bflashlight = 0;
    }
    
    if ( var_1a544a7e8d153ea != self._blackboard.bflashlight )
    {
        if ( asm_getdemeanor() != "patrol" && ( !isdefined( self.asmflashlight ) || !self.asmflashlight ) )
        {
            assert( isdefined( self.fnstealthflashlighton ) && isdefined( self.fnstealthflashlightoff ) );
            
            if ( self._blackboard.bflashlight )
            {
                self [[ self.fnstealthflashlighton ]]();
                return;
            }
            
            self [[ self.fnstealthflashlightoff ]]();
        }
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x977
// Size: 0xb
function isidlecurious()
{
    return self.stealthidlecurious;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x98b
// Size: 0xa1
function idle_init( taskid )
{
    self function_ae41fbf799ba43f( 1, "bt" );
    scripts\stealth\event::event_escalation_clear();
    
    if ( isdefined( self.stealth.funcs[ "hidden" ] ) )
    {
        stealth_call_thread( "hidden" );
    }
    
    var_552c4c67a7040d3c = scripts\stealth\utility::function_783cf2a7aaab23c();
    
    if ( !var_552c4c67a7040d3c && isdefined( self.target ) )
    {
        self.goalradius = 32;
        
        if ( isdefined( self.fnstealthgotonode ) )
        {
            self thread [[ self.fnstealthgotonode ]]( undefined, undefined, undefined, undefined );
        }
    }
    
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xa35
// Size: 0x4f
function idle_terminate( taskid )
{
    self notify( "stop_going_to_node" );
    self function_ae41fbf799ba43f( 0, "bt" );
    scripts\stealth\utility::save_last_goal();
    self.last_set_goalnode = undefined;
    self.last_set_goalent = undefined;
    self.moveplaybackrate = 1;
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xa8d
// Size: 0x2d
function stealth_shouldinvestigate( taskid )
{
    if ( self.stealth_bsmstate == 1 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0xac3
// Size: 0xd, Type: bool
function investigate_shouldfacedecentdirectionwhenidle()
{
    return !istrue( self.limitstealthturning );
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xad9
// Size: 0xb5
function investigate_setreaction( event )
{
    var_25a7f9b7f59cc41e = "small";
    
    if ( event.typeorig == "bulletwhizby" || event.typeorig == "grenade danger" )
    {
        var_25a7f9b7f59cc41e = "med";
    }
    else if ( event.typeorig == "footstep_sprint" )
    {
        if ( isdefined( event.entity ) && isplayer( event.entity ) && self function_89931185060d4d6f( event.entity ) )
        {
            var_25a7f9b7f59cc41e = "med";
        }
    }
    
    scripts\stealth\utility::set_patrol_react( event.investigate_pos, var_25a7f9b7f59cc41e );
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xb96
// Size: 0x2d
function stealth_shouldhunt( taskid )
{
    if ( self.stealth_bsmstate == 2 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0xbcc
// Size: 0x9
function hunt_clearroomdata()
{
    self function_ca38a887735b9b48();
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0xbdd
// Size: 0xde
function function_6057074fd95d3e65()
{
    var_8b8967d098e7c16e = 147456;
    smartobjs = [];
    volumeidx = self function_fda3fd9342329f97();
    
    if ( isdefined( volumeidx ) )
    {
        if ( isdefined( anim.var_463c0093dff0f81c ) && isdefined( anim.var_463c0093dff0f81c[ volumeidx ] ) )
        {
            foreach ( obj in anim.var_463c0093dff0f81c[ volumeidx ] )
            {
                if ( distancesquared( obj.origin, self.origin ) > var_8b8967d098e7c16e )
                {
                    continue;
                }
                
                if ( !scripts\smartobjects\utility::canclaimsmartobject( obj ) )
                {
                    continue;
                }
                
                if ( !scripts\smartobjects\utility::canusesmartobject( obj ) )
                {
                    continue;
                }
                
                smartobjs[ smartobjs.size ] = obj;
            }
        }
    }
    
    return smartobjs;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xcc4
// Size: 0x14
function hunt_updateeveryframe( taskid )
{
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xce1
// Size: 0x5b
function hunt_custom_init( taskid )
{
    scripts\stealth\utility::set_patrol_style( "cqb" );
    
    if ( isdefined( self.stealth.funcs[ "hunt_custom_init" ] ) )
    {
        self thread [[ self.stealth.funcs[ "hunt_custom_init" ] ]]();
    }
    
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xd45
// Size: 0x8f
function hunt_custom_update( taskid )
{
    if ( !self.Stealth_Hunt_IsCustom )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.stealth.funcs[ "hunt_custom_update" ] ) )
    {
        bresult = self [[ self.stealth.funcs[ "hunt_custom_update" ] ]]();
        
        if ( isdefined( bresult ) )
        {
            if ( bresult )
            {
                return anim.running;
            }
            else
            {
                return anim.failure;
            }
        }
    }
    
    return anim.running;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xddd
// Size: 0x4f
function hunt_custom_terminate( taskid )
{
    if ( isdefined( self.stealth.funcs[ "hunt_custom_terminate" ] ) )
    {
        self thread [[ self.stealth.funcs[ "hunt_custom_terminate" ] ]]();
    }
    
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xe35
// Size: 0x32
function hunt_initialdelay_init( taskid )
{
    self.bt.instancedata[ taskid ] = gettime() + randomintrange( 500, 1500 );
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xe6f
// Size: 0x56
function hunt_initialdelay( taskid )
{
    if ( !isdefined( self.var_7dee6dfdb05ecaf9 ) || isdefined( bb_getcovernode() ) || gettime() >= self.bt.instancedata[ taskid ] )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xece
// Size: 0x20
function hunt_initialdelay_terminate( taskid )
{
    self.bt.instancedata[ taskid ] = undefined;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0xef6
// Size: 0x144, Type: bool
function hunt_cqbtargetupdate( instancedata )
{
    pod = function_bc5df124338cefea( self );
    assert( isdefined( pod ) );
    
    if ( isdefined( pod.target ) )
    {
        curtime = gettime();
        
        if ( self cansee( pod.target ) || self getthreatsight( pod.target ) > 0.1 )
        {
            self.var_abc30858a62a19a = pod.target.origin;
            instancedata.cqbtargettime = curtime;
            return true;
        }
        else if ( issentient( pod.target ) && ( isdefined( self.stealth.btargetlastknown ) || isdefined( instancedata.cqbtargettime ) && curtime - instancedata.cqbtargettime < 2000 ) )
        {
            self.var_abc30858a62a19a = self lastknownpos( pod.target );
            return true;
        }
    }
    
    facingdir = anglestoforward( self.angles );
    self.var_abc30858a62a19a = self.origin + facingdir * 384;
    return false;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1043
// Size: 0x14
function hunt_shouldhunker( taskid )
{
    return anim.failure;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1060
// Size: 0xf2
function hunt_hunker_init( taskid )
{
    curtime = gettime();
    instancedata = spawnstruct();
    instancedata.nextcoverchecktime = curtime + randomintrange( 4000, 6000 );
    self.bt.instancedata[ taskid ] = instancedata;
    self.stealth.hunthunkerlastexposetime = curtime;
    scripts\stealth\utility::set_patrol_style( "cqb" );
    pod = function_bc5df124338cefea( self );
    assert( isdefined( pod ) );
    node = self findbestcovernode( undefined, 0, pod.origin );
    
    if ( isdefined( node ) )
    {
        if ( !isdefined( self.node ) || self.node != node )
        {
            self.keepclaimednode = 0;
            self.keepclaimednodeifvalid = 0;
            self usecovernode( node );
        }
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x115a
// Size: 0x18d
function hunt_hunker( taskid )
{
    curtime = gettime();
    
    if ( curtime > self.bt.instancedata[ taskid ].nextcoverchecktime )
    {
        pod = function_bc5df124338cefea( self );
        assert( isdefined( pod ) );
        var_dfb6755a19ee191b = randomint( 3 ) < 1;
        node = self findbestcovernode( %"hash_4f49ec32ba3841db", var_dfb6755a19ee191b, pod.origin );
        
        if ( isdefined( node ) )
        {
            var_559f42bcdb572d45 = 0;
            
            if ( !isdefined( self.node ) || self.node != node )
            {
                self.keepclaimednode = 0;
                self.keepclaimednodeifvalid = 0;
                var_559f42bcdb572d45 = !self usecovernode( node );
            }
            
            if ( var_559f42bcdb572d45 )
            {
                self.bt.instancedata[ taskid ].nextcoverchecktime = curtime + 500;
            }
            else
            {
                self.bt.instancedata[ taskid ].nextcoverchecktime = curtime + randomintrange( 4000, 6000 );
            }
        }
        else
        {
            self.bt.instancedata[ taskid ].nextcoverchecktime = curtime + randomintrange( 2000, 4000 );
        }
    }
    
    scripts\aitypes\stealth::hunt_cqbtargetupdate( self.bt.instancedata[ taskid ] );
    return anim.running;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x12f0
// Size: 0x20
function hunt_hunker_terminate( taskid )
{
    self.bt.instancedata[ taskid ] = undefined;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1318
// Size: 0x7f
function hunt_hunker_shouldexpose( taskid )
{
    var_129825f5ea14c1e4 = 5000;
    
    if ( !isinlight( self.lightmeter ) )
    {
        var_129825f5ea14c1e4 = 3000;
    }
    
    assert( isdefined( self.stealth.hunthunkerlastexposetime ) );
    
    if ( gettime() > self.stealth.hunthunkerlastexposetime + var_129825f5ea14c1e4 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x13a0
// Size: 0xd8
function hunt_hunker_expose_init( taskid )
{
    instancedata = spawnstruct();
    instancedata.endtime = gettime() + 4000;
    instancedata.nextpostime = 0;
    instancedata.nextposidx = 0;
    self.bt.instancedata[ taskid ] = instancedata;
    bb_requestcoverstate( "exposed", 0 );
    assert( isdefined( self.node ) );
    
    if ( isnodecoverleft( self.node ) || isnodecoverright( self.node ) )
    {
        bb_requestcoverexposetype( "B" );
    }
    else
    {
        bb_requestcoverexposetype( "exposed" );
    }
    
    self.stealth.btargetlastknown = 1;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1480
// Size: 0x5e
function hunt_hunker_expose( taskid )
{
    curtime = gettime();
    instancedata = self.bt.instancedata[ taskid ];
    
    if ( curtime > instancedata.endtime )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x14e7
// Size: 0x64
function hunt_hunker_expose_terminate( taskid )
{
    self.var_abc30858a62a19a = undefined;
    self.bt.instancedata[ taskid ] = undefined;
    bb_requestcoverstate( "hide", 1 );
    self.stealth.btargetlastknown = undefined;
    self.stealth.hunthunkerlastexposetime = gettime();
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1553
// Size: 0xb7
function hunt_isincover( taskid )
{
    if ( !isdefined( self.node ) )
    {
        return anim.failure;
    }
    
    var_6901a79fc03ea862 = 16;
    
    if ( isdefined( self.pathgoalpos ) )
    {
        if ( distancesquared( self.pathgoalpos, self.origin ) > var_6901a79fc03ea862 )
        {
            return anim.failure;
        }
    }
    else if ( self.keepclaimednodeifvalid )
    {
        var_6901a79fc03ea862 = 3600;
    }
    else
    {
        var_6901a79fc03ea862 = 225;
    }
    
    if ( distance2dsquared( self.node.origin, self.origin ) > var_6901a79fc03ea862 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1613
// Size: 0x21
function hunt_active_terminate( taskid )
{
    scripts\smartobjects\utility::clearsmartobject( bb_getrequestedsmartobject() );
    self clearbtgoal( 3 );
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x163c
// Size: 0x14
function function_6771d1c0abc4da9c( taskid )
{
    return anim.failure;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1659
// Size: 0x10e
function function_b647c0d07e4a3078( taskid )
{
    pod = function_bc5df124338cefea( self );
    assert( isdefined( pod ) );
    job = pod scripts\stealth\group::function_75087b386454d072( self );
    goalpos = job.requestedpos[ self getentitynumber() ];
    self setbtgoalpos( 3, goalpos );
    self setbtgoalradius( 3, 24 );
    instancedata = spawnstruct();
    instancedata.starttime = gettime();
    instancedata.requestedpos = goalpos;
    self.bt.instancedata[ taskid ] = instancedata;
    otherguy = job.guys[ 0 ];
    
    if ( self == otherguy )
    {
        otherguy = job.guys[ 1 ];
    }
    
    var_5de4575810c72ff0 = vectortoyaw( otherguy.origin - self.origin );
    self.customarrivalangles = ( 0, var_5de4575810c72ff0, 0 );
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x176f
// Size: 0xd2
function function_5ba0240304e46139( taskid )
{
    if ( self.pathpending )
    {
        return anim.running;
    }
    
    instancedata = self.bt.instancedata[ taskid ];
    curtime = gettime();
    
    if ( curtime - instancedata.starttime > 0 && !isdefined( self.pathgoalpos ) )
    {
        if ( distancesquared( self.origin, instancedata.requestedpos ) < 576 && !self.arriving )
        {
            return anim.success;
        }
    }
    
    if ( curtime - instancedata.starttime > 15000 )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x184a
// Size: 0x2a
function function_8f3c5de8d0839565( taskid )
{
    self.customarrivalangles = undefined;
    self.bt.instancedata[ taskid ] = undefined;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x187c
// Size: 0x97
function function_90ed2a34d9f66902( taskid )
{
    pod = function_bc5df124338cefea( self );
    assert( isdefined( pod ) );
    job = pod scripts\stealth\group::function_75087b386454d072( self );
    
    if ( !isdefined( job ) )
    {
        return "ReturnSuccess";
    }
    
    jobstatus = job.state[ self getentitynumber() ];
    
    if ( jobstatus == "wait" )
    {
        return "Stealth_Hunt_Coordinate_Wait";
    }
    
    if ( jobstatus == "gesture" )
    {
        return "Stealth_Hunt_Coordinate_Action";
    }
    
    if ( jobstatus == "done" )
    {
        return "ReturnSuccess";
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x191b
// Size: 0x139
function function_7e3b6c64f2c2c6be( taskid )
{
    pod = function_bc5df124338cefea( self );
    assert( isdefined( pod ) );
    job = pod scripts\stealth\group::function_75087b386454d072( self );
    otherguy = job.guys[ 0 ];
    
    if ( self == otherguy )
    {
        otherguy = job.guys[ 1 ];
    }
    
    if ( isdefined( self.var_7b492275ef047be2 ) )
    {
        self._blackboard.var_3dbe624a18d61f13 = self.var_7b492275ef047be2;
        smartobj = spawnstruct();
        smartobj.origin = self.origin;
        smartobj.angles = self.angles;
        smartobj.script_smartobject = "hunt_point";
        scripts\smartobjects\utility::setsmartobject( smartobj );
    }
    else
    {
        smartobj = spawnstruct();
        smartobj.origin = self.origin;
        smartobj.angles = self.angles;
        smartobj.script_smartobject = "hunt_checkin";
        scripts\smartobjects\utility::setsmartobject( smartobj );
    }
    
    return anim.success;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1a5d
// Size: 0xb
function function_1baa3d287f64fa3( taskid )
{
    
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x1a70
// Size: 0x20
function function_9b6fd81057ede5ce()
{
    self.var_587d8840dea10869 = 0;
    self.var_4b1fa39975a3fd58 = undefined;
    self.var_97db6f81ba0702e3 = undefined;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x1a98
// Size: 0x61
function clearstealthvolume()
{
    if ( isdefined( level.stealth.combat_volumes[ self.script_stealthgroup ] ) && iscombating() || isdefined( level.stealth.hunt_volumes[ self.script_stealthgroup ] ) && ishunting() )
    {
        self clearbtgoal( 0 );
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 1
// Checksum 0x0, Offset: 0x1b01
// Size: 0xf8
function function_6bdcfa57946930c7( event )
{
    assert( isdefined( event.typeorig ) );
    self.stealth.investigateevent = event;
    self.var_bb3bab49c9a764a4 = event.typeorig;
    self.var_cc20708455457566 = event.entity;
    self.var_bf4e91e691d898fc = event.receiver;
    self.var_f97ff24102472069 = event.type;
    self.var_1a15e562b3389b69 = 0;
    
    if ( isdefined( event.position ) )
    {
        self.var_d70f3a3817594dc6 = event.position;
    }
    
    if ( isdefined( event.investigate_pos ) )
    {
        self.var_b446b52dfacc181 = event.investigate_pos;
    }
    
    if ( isdefined( event.look_pos ) )
    {
        self.var_743c0e8cfe4adc6f = event.look_pos;
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x1c01
// Size: 0x14e
function function_9c4a08f7dcd2796b()
{
    if ( !isdefined( self.var_bb3bab49c9a764a4 ) || !isdefined( self.stealth.investigateevent ) )
    {
        return undefined;
    }
    
    self.stealth.investigateevent.typeorig = self.var_bb3bab49c9a764a4;
    self.stealth.investigateevent.position = self.var_d70f3a3817594dc6;
    self.stealth.investigateevent.entity = self.var_cc20708455457566;
    self.stealth.investigateevent.receiver = self.var_bf4e91e691d898fc;
    self.stealth.investigateevent.type = self.var_f97ff24102472069;
    self.stealth.investigateevent.investigate_pos = self.var_b446b52dfacc181;
    self.stealth.investigateevent.look_pos = self.var_743c0e8cfe4adc6f;
    return self.stealth.investigateevent;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 0
// Checksum 0x0, Offset: 0x1d58
// Size: 0x1f
function function_de475c37aeeaf6c()
{
    self.stealth.investigateevent = undefined;
    self.var_bb3bab49c9a764a4 = undefined;
}

// Namespace stealth / scripts\aitypes\stealth
// Params 2
// Checksum 0x0, Offset: 0x1d7f
// Size: 0x22f
function function_9499f9e2b35b85c8( event, podstate )
{
    if ( isplayer( self.var_da668f8de95278e9 ) && !isplayer( event.entity ) && event.typeorig != "saw_corpse" )
    {
        return;
    }
    
    if ( isdefined( self.var_f97ff24102472069 ) )
    {
        if ( self.var_bb3bab49c9a764a4 == "saw_corpse" && ( event.typeorig == "found_corpse" || event.typeorig == "saw_corpse" ) && isdefined( self.var_da668f8de95278e9 ) && event.entity == self.var_da668f8de95278e9 )
        {
            return;
        }
        
        importancediff = scripts\stealth\event::event_severity_compare( self.var_f97ff24102472069, event.type );
        
        if ( importancediff >= 0 )
        {
            self.var_b217b37a4a7c7817 = event.typeorig;
            self.var_da668f8de95278e9 = event.entity;
            function_6bdcfa57946930c7( event );
        }
        
        curtime = gettime();
        bupdate = importancediff > 0 || curtime > self.var_f1d505e3ed5189bb || distancesquared( event.investigate_pos, self.origin ) < distancesquared( self.var_b446b52dfacc181, self.origin );
        
        if ( bupdate )
        {
            groupdata = scripts\stealth\group::getgroup( self.script_stealthgroup );
            pod = scripts\stealth\group::group_findpod( groupdata, self );
            existingpod = scripts\stealth\group::group_trytojoinexistingpod( pod, podstate, self, event.investigate_pos );
            
            if ( isdefined( existingpod ) )
            {
                pod = existingpod;
            }
            
            assert( isdefined( pod ) );
            pod scripts\stealth\group::pod_updateinvestigateorigin( self, event.investigate_pos );
            thread scripts\stealth\utility::addeventplaybcs( "stealth", "state_change", "update_investigate", undefined, event );
            
            if ( podstate == 1 )
            {
                self notify( "stealth_update_investigate" );
            }
            
            self.var_f1d505e3ed5189bb = curtime;
        }
        
        self.var_27ebf45f68998ef8 = undefined;
    }
}

// Namespace stealth / scripts\aitypes\stealth
// Params 2
// Checksum 0x0, Offset: 0x1fb6
// Size: 0x52
function scrsetstealthstate( statename, e )
{
    if ( !flag( "stealth_enabled" ) || !isdefined( self.stealth ) || !istrue( self.stealth_enabled ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self setstealthstate( statename, e );
}

