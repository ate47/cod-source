#using script_5262c59c62fa4892;
#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\ai_lookat;
#using scripts\common\cap;
#using scripts\engine\utility;

#namespace ai_revival;

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 1
// Checksum 0x0, Offset: 0x371
// Size: 0x10e
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onUserInit;
        case #"hash_722d767fd6d40f56":
            return &onUserTerminate;
        case #"hash_902f9e79d5e57c83":
            return &oneventreceived;
        case #"hash_ae182ac0084f18fa":
            return &movingToDyingGuy;
        case #"hash_cfc067e44f70f86b":
            return &reviving;
        case #"hash_e7ffa3549475787":
            return &dyingguybeingrevived;
        case #"hash_f5cf55913a442596":
            return &earlyrevivedsuccess;
        case #"hash_303d74db152a39b9":
            return &namespace_f901a4f9d899be59::function_606c28b248baddfd;
        case #"hash_be6abeab18f64c91":
            return &moveIntoPosition;
        case #"hash_25397093dba07e3a":
            return &remoterevive;
        case #"hash_2a5b537d23266f19":
            return &providecoverfire;
        case #"hash_669a3d0df855846d":
            return &beingRemoteRevived;
        case #"hash_18372b0f69e4b08c":
            return &waitforreviver;
    }
    
    assertmsg( "<dev string:x1c>" + funcid );
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 1
// Checksum 0x0, Offset: 0x487
// Size: 0xb
function onUserInit( interactionid )
{
    
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 1
// Checksum 0x0, Offset: 0x49a
// Size: 0x136
function onUserTerminate( interactionid )
{
    /#
        if ( isagent( self ) )
        {
            assertex( self isscriptable(), "<dev string:x3d>" + self.agent_type + "<dev string:x4d>" );
        }
    #/
    
    scriptablepart = "revival_helper_stim";
    
    if ( self isscriptable() && self getscriptablehaspart( scriptablepart ) )
    {
        self setscriptablepartstate( scriptablepart, "default" );
    }
    
    self unlink();
    self.pushable = 1;
    self.skipdyingbackcrawl = 0;
    
    if ( !isalive( self ) )
    {
        function_ae368fad1a1dc337( interactionid, "death", 1 );
    }
    else
    {
        if ( self.stealth_bsmstate == 0 )
        {
            function_ae368fad1a1dc337( interactionid, "stealth_idle", 1 );
        }
        else if ( self.asmname == self.defaultasm )
        {
            function_ae368fad1a1dc337( interactionid, "death", 1 );
        }
        
        asm_fireephemeralevent( "revival", "end" );
        self clearbtgoal( 3 );
        self.var_26aa5cb1924a027 = 0;
        self.var_c3b6984b9532af5b = 0;
        
        if ( self.var_d3404efce3fc4fa6 )
        {
            function_4c1d28fa0f0bbba8();
            coveringfirecleanup();
        }
    }
    
    self notify( "end_revival" );
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 3
// Checksum 0x0, Offset: 0x5d8
// Size: 0x8c, Type: bool
function oneventreceived( receiver, info, origin )
{
    if ( info == "focused_on" && !doinglongdeath() )
    {
        distsq = distancesquared( receiver.origin, origin );
        breakoutdist = 200;
        
        if ( distsq < breakoutdist * breakoutdist && !istrue( function_60d6151af81a343( self getinteractionid(), "death" ) ) )
        {
            function_ae368fad1a1dc337( self getinteractionid(), "death", 1 );
            return true;
        }
    }
    
    return false;
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0x66d
// Size: 0x3b6
function movingToDyingGuy( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    dyingguy = getdyingguy();
    
    if ( !isdefined( dyingguy ) )
    {
        earlyoutinteraction();
    }
    
    dyingguy endon( "death" );
    dyingguy endon( "end_revival" );
    goalrad = 10;
    dyingguypos = dyingguy.origin;
    self setbtgoalpos( 3, dyingguypos );
    self setbtgoalradius( 3, goalrad );
    self waittill( "path_set" );
    self.var_26aa5cb1924a027 = 1;
    self.var_c3b6984b9532af5b = 1;
    var_6bc273ba321491f0 = 200;
    
    for ( pathlength = self pathdisttogoal(); pathlength > var_6bc273ba321491f0 ; pathlength = self pathdisttogoal() )
    {
        if ( !isdefined( dyingguy ) )
        {
            earlyoutinteraction();
        }
        
        dyingguypos = dyingguy.origin;
        self setbtgoalpos( 3, dyingguypos );
        wait 0.2;
    }
    
    if ( !isdefined( dyingguy ) )
    {
        earlyoutinteraction();
    }
    
    dyingguy animmode( "angle deltas" );
    dyingguy.skipdyingbackcrawl = 1;
    dyingguy asmfireevent( dyingguy.asmname, "dying_back_crawl_done" );
    dyingguypos = dyingguy.origin;
    dyingguy.pushable = 0;
    self.pushable = 0;
    introalias = function_9d6585cc199439cb( dyingguy );
    rolestring = "reviving_guy";
    capinfo = getcapinfoforrole( self, rolestring );
    arcanimset = capinfo.animation;
    introstate = "reviving_intro";
    alias = archetypegetalias( arcanimset, introstate, introalias, 0 );
    animation = alias.anims;
    startorigin = getstartorigin( dyingguy.origin, dyingguy.angles, animation );
    startangles = getstartangles( dyingguy.origin, dyingguy.angles, animation );
    
    if ( !ispointonnavmesh( startorigin, self ) )
    {
        newalias = function_be5400e991ae040a( introalias );
        alias = archetypegetalias( arcanimset, introstate, newalias, 0 );
        animation = alias.anims;
        startorigin = getstartorigin( dyingguy.origin, dyingguy.angles, animation );
        startangles = getstartangles( dyingguy.origin, dyingguy.angles, animation );
        
        if ( !ispointonnavmesh( startorigin, self ) )
        {
            dyingguy.var_d5e499e7fe2c490b = 0;
            function_ae368fad1a1dc337( self getinteractionid(), "death", 1 );
        }
    }
    
    self.revivetargetpos = startorigin;
    self setbtgoalpos( 3, self.revivetargetpos );
    self.revivetargetangles = startangles;
    self.customarrivalangles = self.revivetargetangles;
    self.customarrivalstanceoverride = "crouch";
    var_c70217358eddbeb2 = 2;
    waittill_any_timeout_1( var_c70217358eddbeb2, "bt_goal" );
    
    while ( istrue( self.arriving ) )
    {
        waitframe();
    }
    
    if ( !isdefined( dyingguy ) )
    {
        earlyoutinteraction();
    }
    
    var_a9efda5c39dab5c0 = 32;
    
    if ( distancesquared( self.origin, self.revivetargetpos ) < var_a9efda5c39dab5c0 * var_a9efda5c39dab5c0 )
    {
        scripts\common\cap::cap_start( "cap_ai_revival", "caps/interactions/cap_ai_revival" );
        self waittill( "reviving_intro_starts" );
    }
    else
    {
        function_ae368fad1a1dc337( self getinteractionid(), "death", 1 );
    }
    
    self.var_26aa5cb1924a027 = 0;
    self clearbtgoal( 3 );
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xa2b
// Size: 0x7a
function reviving( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    self endon( "cap_exit_completed" );
    childthread adjustpos();
    wait 0.3;
    downedguy = getdyingguy();
    self.var_26aa5cb1924a027 = 0;
    
    if ( isdefined( downedguy ) )
    {
        self linktoblendtotag( downedguy, "tag_sync" );
    }
    
    self waittill( "cap_exit_completed" );
    self.var_f69704726b42b5c2 = gettime();
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xaad
// Size: 0x96
function dyingguybeingrevived( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    scripts\common\cap::cap_start( "cap_ai_revival", "caps/interactions/cap_ai_revival" );
    
    while ( !asm_ephemeraleventfired( "being_revived", "end" ) )
    {
        frametime = level.frameduration;
        self.desiredtimeofdeath += frametime;
        waitframe();
    }
    
    self.doinglongdeath = 0;
    self.health = 150;
    self waittill( "cap_exit_completed" );
    function_db717d5877caf11d();
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xb4b
// Size: 0x67
function earlyrevivedsuccess( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    asm_fireevent( self.asmname, "early_revived_success" );
    
    if ( istrue( self.doinglongdeath ) )
    {
        self.doinglongdeath = 0;
        self.health = 150;
    }
    
    self waittill( "cap_exit_completed" );
    function_db717d5877caf11d();
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xbba
// Size: 0x11c
function moveIntoPosition( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    self setcanusecover( 0 );
    self allowedstances( "stand" );
    self.revivetarget = getdyingguy();
    targetpos = self.revivetarget.origin;
    canseedyingguy = self cansee( self.revivetarget );
    
    if ( !canseedyingguy || distancesquared( self.origin, targetpos ) > self.var_5f147643cac35943 * self.var_5f147643cac35943 )
    {
        targeteyepos = self.revivetarget getapproxeyepos();
        goalpos = findclosestlospointwithinradius( targeteyepos, self.var_5f147643cac35943, targeteyepos, self.origin );
        self setbtgoalpos( 3, goalpos );
        self setbtgoalradius( 3, 32 );
        self waittill( "bt_goal" );
    }
    else
    {
        self function_e64ea2b4e79c4b74( 3 );
    }
    
    while ( self.arriving )
    {
        waitframe();
    }
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xcde
// Size: 0x3a
function remoterevive( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    scripts\common\cap::cap_start( "cap_ai_revival", "caps/interactions/cap_ai_revival" );
    self waittill( "cap_exit_completed" );
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xd20
// Size: 0x95
function providecoverfire( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    self.revivetarget = undefined;
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.cachemaxfaceenemydist = self.maxfaceenemydist;
    self.maxfaceenemydist = 2048;
    self.providecoveringfire = 1;
    self.balwayscoverexposed = 1;
    self.shootstyleoverride = "full";
    wait self.var_1ed26f360217ee85;
    coveringfirecleanup();
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xdbd
// Size: 0x29
function waitforreviver( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    self waittill( "shot_by_revive_pistol" );
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 2
// Checksum 0x0, Offset: 0xdee
// Size: 0x56
function beingRemoteRevived( statename, params )
{
    self endon( "death" );
    self endon( "end_revival" );
    scripts\common\cap::cap_start( "cap_ai_revival", "caps/interactions/cap_ai_revival" );
    self waittill( "cap_exit_completed" );
    self.doinglongdeath = 0;
    self.health = self.maxhealth;
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe4c
// Size: 0x4a
function private coveringfirecleanup()
{
    if ( !isdefined( self.cachemaxfaceenemydist ) )
    {
        return;
    }
    
    self.providecoveringfire = 0;
    self.balwayscoverexposed = 0;
    self.shootstyleoverride = undefined;
    self.maxfaceenemydist = self.cachemaxfaceenemydist;
    self.cachemaxfaceenemydist = undefined;
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe9e
// Size: 0x3d
function private function_4c1d28fa0f0bbba8()
{
    self.ignoreall = 0;
    self.combatmode = "cover";
    self setcanusecover( 1 );
    self allowedstances( "stand", "crouch" );
    self clearbtgoal( 3 );
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xee3
// Size: 0x20
function private function_db717d5877caf11d()
{
    helper = function_5669cb34cd563512();
    
    if ( isdefined( helper ) )
    {
        helper unlink();
    }
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf0b
// Size: 0xf8
function private adjustpos()
{
    startpos = self.origin;
    startangles = self.angles;
    stilltoofar = distancesquared( startpos, self.revivetargetpos ) > 100;
    var_8df2b0c826a4a7b2 = absangleclamp180( startangles[ 1 ] - self.revivetargetangles[ 1 ] ) > 7;
    
    if ( stilltoofar || var_8df2b0c826a4a7b2 )
    {
        interval = 300;
        endtime = gettime() + interval;
        
        while ( endtime > gettime() )
        {
            fraction = 1 - ( endtime - gettime() ) / interval;
            newpos = vectorlerp( startpos, self.revivetargetpos, fraction );
            newangles = anglelerpquatfrac( startangles, self.revivetargetangles, fraction );
            self forceteleport( newpos, newangles );
            waitframe();
        }
    }
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x100b
// Size: 0x43
function private function_9d6585cc199439cb( dyingguy )
{
    var_3b3c2e088b48d1e2 = 6;
    damagedirsuffix = "_back";
    
    if ( isdefined( dyingguy ) )
    {
        var_3b3c2e088b48d1e2 = namespace_55d2e8f86217c54a::function_a1e95f167c3c1107( dyingguy, self );
        damagedirsuffix = dyingguy namespace_55d2e8f86217c54a::getdamagedirectionsuffix();
    }
    
    return var_3b3c2e088b48d1e2 + damagedirsuffix;
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1057
// Size: 0x38
function private function_be5400e991ae040a( alias )
{
    if ( alias[ 0 ] == "4" )
    {
        return ( "6" + getsubstr( alias, 1 ) );
    }
    
    return "4" + getsubstr( alias, 1 );
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1097
// Size: 0x1c
function private earlyoutinteraction()
{
    function_ae368fad1a1dc337( self getinteractionid(), "death", 1 );
    self leaveinteraction();
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10bb
// Size: 0x2c
function private getdyingguy()
{
    id = self getinteractionid();
    users = getbsequserswithtag( id, "dying_guy" );
    return users[ 0 ];
}

// Namespace ai_revival / namespace_35286fc8500a0a07
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10f0
// Size: 0x2c
function private function_5669cb34cd563512()
{
    id = self getinteractionid();
    users = getbsequserswithtag( id, "reviving_guy" );
    return users[ 0 ];
}

