#using scripts\aitypes\melee;
#using scripts\aitypes\stealth;
#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\event;

#namespace combat;

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x18d
// Size: 0x168
function dog_init( taskid )
{
    self.fixednode = 0;
    self setcanusecover( 0, "entity" );
    self._blackboard.movetype = "walk";
    self.meleechargedist = 384;
    self.meleechargedistvsplayer = 384;
    self.meleerangesq = 4096;
    self.unarmedmeleedamageoverride = 400;
    self.meleemaxzdiff = 72;
    self.meleetryhard = 1;
    self.fnismeleevalid = &ismeleevalid;
    self.fncanmovefrompointtopoint = &canmovefrompointtopoint;
    self.fnsetstealthstate = &function_4acf2a2179e158ff;
    self.fnisinstealthidle = &scripts\aitypes\stealth::isidle;
    self.fnisinstealthinvestigate = &scripts\aitypes\stealth::isinvestigating;
    self.fnisinstealthhunt = &scripts\aitypes\stealth::ishunting;
    self.fnisinstealthcombat = &scripts\aitypes\stealth::iscombating;
    self.fnisinstealthidlescriptedanim = &scripts\aitypes\stealth::isidlescriptedanim;
    self.fnstealthupdatevisionforlighting = &scripts\aitypes\stealth::updatevisionforlighting;
    self.smellradiussq = 589824;
    self.smellouterradiussq = 685584;
    self.barkradiussq = 409600;
    self.barkouterradiussq = 490000;
    self.combatradiussq = 262144;
    
    if ( isdefined( level.var_fcff6df987be068c ) )
    {
        self [[ level.var_fcff6df987be068c ]]();
    }
    
    return anim.success;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 2
// Checksum 0x0, Offset: 0x2fe
// Size: 0x1e
function canmovefrompointtopoint( start, end )
{
    return self maymovefrompointtopoint( start, end, 0, 1 );
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x325
// Size: 0x8d
function updateeveryframe( taskid )
{
    if ( !isalive( self ) )
    {
        return anim.failure;
    }
    
    shouldrun = scripts\engine\utility::is_equal( self.demeanoroverride, "sprint" ) || isdefined( self.enemy );
    
    if ( shouldrun )
    {
        self._blackboard.movetype = "run";
    }
    else
    {
        self._blackboard.movetype = "walk";
    }
    
    return anim.success;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x3bb
// Size: 0x110
function updateeveryframe_stealth( taskid )
{
    target = function_9f06ea4aea71cf56();
    var_4f3c8b6363feecc2 = isdefined( target );
    
    switch ( self.stealth_bsmstate )
    {
        case 0:
            if ( var_4f3c8b6363feecc2 )
            {
                disttotargetsq = distancesquared( target.origin, self.origin );
                
                if ( disttotargetsq < self.smellradiussq )
                {
                    function_4acf2a2179e158ff( "investigate" );
                }
            }
            
            break;
        case 1:
            if ( var_4f3c8b6363feecc2 )
            {
                disttotargetsq = distancesquared( target.origin, self.origin );
                
                if ( disttotargetsq > self.smellouterradiussq )
                {
                    if ( self getthreatsightflag( target, 4 ) )
                    {
                        function_4acf2a2179e158ff( "idle" );
                    }
                }
                else if ( disttotargetsq < self.combatradiussq && self cansee( target ) )
                {
                    function_4acf2a2179e158ff( "combat" );
                }
            }
            
            break;
    }
    
    return anim.success;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x4d4
// Size: 0x102
function enableeventlisteners( benable )
{
    events = [ "bulletwhizby", "explosion", "gunshot", "projectile_impact", "silenced_shot", "footstep", "footstep_sprint", "footstep_walk", "grenade danger", "glass_destroyed" ];
    
    if ( benable )
    {
        foreach ( eventname in events )
        {
            self addaieventlistener( eventname );
        }
        
        return;
    }
    
    foreach ( eventname in events )
    {
        self removeaieventlistener( eventname );
    }
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 0
// Checksum 0x0, Offset: 0x5de
// Size: 0x91
function dog_idle_init()
{
    enableeventlisteners( 1 );
    self clearenemy();
    self setsightstate( "hidden" );
    scripts\stealth\event::event_escalation_clear();
    self function_1aff80c5fc5a3eea( "noncombat" );
    
    if ( isdefined( self.stealth.funcs[ "hidden" ] ) )
    {
        scripts\stealth\callbacks::stealth_call_thread( "hidden" );
    }
    
    if ( isdefined( self.target ) )
    {
        self.goalradius = 32;
        
        if ( isdefined( self.fnstealthgotonode ) )
        {
            self thread [[ self.fnstealthgotonode ]]( undefined, undefined, undefined, undefined );
        }
    }
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x677
// Size: 0x30
function dog_idle_init_task( taskid )
{
    self.bt.instancedata[ taskid ] = spawnstruct();
    self.stealthidlecurious = 0;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x6af
// Size: 0x1fa
function dog_idle( taskid )
{
    instancedata = self.bt.instancedata[ taskid ];
    target = function_9f06ea4aea71cf56();
    
    if ( isdefined( target ) )
    {
        threatsight = self getthreatsight( target );
        var_8213e01cd2d8165c = 0.25;
        
        if ( self.stealthidlecurious )
        {
            var_abf709c364b55431 = 2000;
            
            if ( gettime() > instancedata.curiousstarttime + var_abf709c364b55431 )
            {
                if ( threatsight < var_8213e01cd2d8165c * 0.9 )
                {
                    self.stealthidlecurious = 0;
                    self.stealthidlecurioustarget = undefined;
                    
                    if ( !isdefined( self.pathgoalpos ) && instancedata.var_56e56b012c1a75a6 )
                    {
                        self function_3b67788e61393d91( 1 );
                        instancedata.var_56e56b012c1a75a6 = 0;
                    }
                }
            }
        }
        else if ( threatsight >= var_8213e01cd2d8165c )
        {
            self.stealthidlecurious = 1;
            self.stealthidlecurioustarget = target;
            instancedata.curiousstarttime = gettime();
            instancedata.idlenode.var_56e56b012c1a75a6 = self._blackboard.idlenodeisvalid;
            
            if ( instancedata.var_56e56b012c1a75a6 )
            {
                self function_3b67788e61393d91( 0 );
            }
            else
            {
                self function_f7cff9f6dafb297();
            }
        }
    }
    else
    {
        self.stealthidlecurious = 0;
        self.stealthidlecurioustarget = undefined;
        
        if ( !isdefined( self.pathgoalpos ) && instancedata.idlenodeisvalid )
        {
            self function_e4b58a023e0da030( instancedata.idlenode.origin, instancedata.idlenode.angles, instancedata.idlenode.var_da71d4b2d374ea7a );
        }
    }
    
    self._blackboard.movetype = "walk";
    return anim.running;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x8b2
// Size: 0x34
function dog_idle_terminate_task( taskid )
{
    self.bt.instancedata[ taskid ] = undefined;
    self.stealthidlecurious = 0;
    self.stealthidlecurioustarget = undefined;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x8ee
// Size: 0x50
function dog_investigate_init_task( taskid )
{
    self.bt.instancedata[ taskid ] = spawnstruct();
    self.stealth.bbark = 0;
    self.stealth.bgrowl = 0;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0x946
// Size: 0x18d
function dog_investigate( taskid )
{
    target = function_9f06ea4aea71cf56();
    
    if ( isdefined( target ) )
    {
        disttotargetsq = distancesquared( self.origin, target.origin );
        
        if ( disttotargetsq < self.barkradiussq )
        {
            self.stealth.bbark = 1;
            self.stealth.bgrowl = 0;
        }
        else if ( disttotargetsq > self.barkouterradiussq )
        {
            self.stealth.bbark = 0;
            self.stealth.bgrowl = 1;
        }
        
        if ( self.stealth.bbark || self.stealth.bgrowl )
        {
            self._blackboard.target = target;
        }
        else
        {
            self._blackboard.target = undefined;
        }
        
        self._blackboard.movetype = "run";
    }
    else
    {
        self._blackboard.movetype = "walk";
        self.stealth.bgrowl = 0;
        self.stealth.bbark = 0;
        self._blackboard.target = undefined;
    }
    
    return anim.running;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0xadc
// Size: 0x59
function dog_investigate_terminate_task( taskid )
{
    self.bt.instancedata[ taskid ] = undefined;
    self.stealth.bbark = undefined;
    self.stealth.bgrowl = undefined;
    self._blackboard.target = undefined;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 2
// Checksum 0x0, Offset: 0xb3d
// Size: 0x31
function ismeleevalid( target, var_92493ae5a92d3699 )
{
    if ( !scripts\aitypes\melee::ismeleevalid_common( target, var_92493ae5a92d3699 ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0xb77
// Size: 0x3f
function dog_followenemy_init( taskid )
{
    instancedata = spawnstruct();
    instancedata.nextupdatetime = 0;
    self.bt.instancedata[ taskid ] = instancedata;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0xbbe
// Size: 0x168
function dog_followenemy( taskid )
{
    target = self.enemy;
    instancedata = self.bt.instancedata[ taskid ];
    curtime = gettime();
    
    if ( curtime >= instancedata.nextupdatetime )
    {
        instancedata.nextupdatetime = curtime + 500;
        var_aa54644c41d855b8 = 192;
        metotarget = target.origin - self.origin;
        distmetotarget = length( metotarget );
        
        if ( distmetotarget > var_aa54644c41d855b8 && !istrue( self.dontmelee ) )
        {
            metotarget = ( metotarget[ 0 ], metotarget[ 1 ], 0 );
            distmetotarget = length( metotarget );
            desiredgoalpos = target.origin - metotarget * var_aa54644c41d855b8 / distmetotarget;
            snappedgoalpos = getclosestpointonnavmesh( desiredgoalpos, self );
            self setbtgoalpos( 3, snappedgoalpos );
            self setbtgoalradius( 3, 64 );
        }
    }
    
    if ( isdefined( self.stealth ) )
    {
        if ( !isdefined( self.pathgoalpos ) )
        {
            self.stealth.bbark = 1;
        }
        else
        {
            self.stealth.bbark = undefined;
        }
    }
    
    return anim.running;
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0xd2f
// Size: 0x36
function dog_followenemy_terminate( taskid )
{
    self.bt.instancedata[ taskid ] = undefined;
    
    if ( !isdefined( self.enemy ) )
    {
        self clearbtgoal( 3 );
    }
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 0
// Checksum 0x0, Offset: 0xd6d
// Size: 0x1d
function dog_combat_init()
{
    enableeventlisteners( 0 );
    scripts\stealth\event::event_escalation_clear();
    self setsightstate( "spotted" );
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0xd92
// Size: 0x69
function enterstealthstate( state )
{
    exitstealthstate( self.stealth_bsmstate );
    self.stealth_bsmstate = state;
    
    switch ( state )
    {
        case 0:
            dog_idle_init();
            break;
        case 1:
            break;
        case 3:
            dog_combat_init();
            break;
    }
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 1
// Checksum 0x0, Offset: 0xe03
// Size: 0x32
function exitstealthstate( state )
{
    switch ( state )
    {
        case 0:
            break;
        case 1:
            break;
    }
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 2
// Checksum 0x0, Offset: 0xe3d
// Size: 0x7b
function function_4acf2a2179e158ff( state, event )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            enterstealthstate( 0 );
            self notify( "stealth_idle" );
            break;
        case #"hash_e21b072df2b47f94":
            enterstealthstate( 1 );
            self notify( "stealth_investigate" );
            break;
        case #"hash_9e02cd4a0f3ca981":
            enterstealthstate( 3 );
            self notify( "stealth_combat" );
            break;
    }
}

// Namespace combat / scripts\aitypes\dog\combat
// Params 0
// Checksum 0x0, Offset: 0xec0
// Size: 0x9f
function function_9f06ea4aea71cf56()
{
    target = undefined;
    highestthreatsight = 0;
    var_73246713dda5c662 = undefined;
    targets = sortbydistance( level.players, self.origin );
    
    for ( i = 0; i < targets.size ; i++ )
    {
        if ( istrue( targets[ i ].ignoreme ) )
        {
            continue;
        }
        
        threatsight = self getthreatsight( targets[ i ] );
        
        if ( !isdefined( target ) || threatsight > highestthreatsight )
        {
            target = targets[ i ];
            highestthreatsight = threatsight;
        }
    }
    
    return target;
}

