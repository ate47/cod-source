#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace door_check;

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1
// Checksum 0x0, Offset: 0x343
// Size: 0x13b
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onUserInit;
        case #"hash_722d767fd6d40f56":
            return &onUserTerminate;
        case #"hash_9f9e07224ff2a95a":
            return &calcstartorigin;
        case #"hash_88347dbc54e3c555":
            return &function_17c9514d056f8b0c;
        case #"hash_55e74e391a612ea8":
            return &function_e62b12681729b218;
        case #"hash_d8934b522ed927fa":
            return &function_17557d7a61c7b24a;
        case #"hash_818982b14b2af1f":
            return &arrivalsetup;
        case #"hash_3454d29ae45c6cdb":
            return &function_af686e8a0657ce57;
        case #"hash_c5687eec52003555":
            return &onarrival;
        case #"hash_e016759d0510a58c":
            return &onbailout;
        case #"hash_d50b41c248a37316":
            return &onenter;
        case #"hash_214ba25246813d79":
            return &function_8055622a418ebd4f;
        case #"hash_1ac92cc267a9ec26":
            return &GoalCheckCleanup;
        case #"hash_f81d03def0fb7e01":
            return &function_27937ccb1b1abef1;
        case #"hash_94e93145a62541a4":
            return &function_23cd7f6fdf460eb4;
        case #"hash_987435cc91e79a2f":
            return &function_21bcb65ded71229f;
    }
    
    return namespace_f901a4f9d899be59::function_efcea5d26798e5b6( funcid );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x487
// Size: 0xc8
function private onUserInit( interactionid )
{
    setdvarifuninitialized( @"hash_6bff7f7a44419fce", 0 );
    
    if ( !isdefined( function_60d6151af81a343( interactionid, "breachtype" ) ) )
    {
        types = [ "breach", "kick", "flashbang" ];
        type = random( types );
        function_ae368fad1a1dc337( interactionid, "breachtype", type );
    }
    
    self.doorcheck = spawnstruct();
    
    if ( isdefined( self.node ) )
    {
        self.doorcheck.priornode = self.node;
        return;
    }
    
    self.doorcheck.priorgoalpos = self.pathgoalpos;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x557
// Size: 0xf0
function private onUserTerminate( interactionid )
{
    if ( isdefined( self.capdata ) && isdefined( self.capdata.var_9c471c82abe76355 ) )
    {
        self.script_pushable = self.capdata.var_9c471c82abe76355;
        self.script_pushable_by_ai = self.capdata.var_512299ff86496ad6;
    }
    
    self.doorcheck = undefined;
    self clearbtgoal( 3 );
    self.capdata = undefined;
    self.customarrivalhandler = undefined;
    
    if ( self.defaultasm != self.asmname )
    {
        scripts\common\cap::cap_exit();
    }
    
    users = getbsequsers( interactionid );
    
    if ( users.size == 1 )
    {
        doorid = function_60d6151af81a343( interactionid, "doorindex" );
        
        if ( isdefined( doorid ) )
        {
            updateroomdoorclaim( doorid, gettime() + 10000 );
        }
    }
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x64f
// Size: 0x39f
function private calcstartorigin( statename, role )
{
    id = self getinteractionid();
    assert( isdefined( id ) );
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    doordir = anglestoforward( angles );
    var_5c6afc1001475042 = origin - self.origin;
    cross = vectorcross( var_5c6afc1001475042, doordir );
    bleft = 1;
    
    if ( cross[ 2 ] < 0 )
    {
        bleft = 0;
    }
    
    idlestate = "door_idle";
    
    if ( bleft )
    {
        idlealias = "left";
    }
    else
    {
        idlealias = "right";
    }
    
    door_knob = function_60d6151af81a343( id, "door_knob" );
    
    if ( isdefined( door_knob ) )
    {
        idlealias = door_knob;
    }
    
    if ( role == "active" )
    {
        function_ae368fad1a1dc337( id, "activeside", idlealias );
    }
    else
    {
        occupiedside = function_60d6151af81a343( id, "activeside" );
        
        if ( occupiedside == "left" )
        {
            idlealias = "right";
        }
        else
        {
            idlealias = "left";
        }
    }
    
    openness = function_60d6151af81a343( id, "openness" );
    
    if ( isdefined( openness ) )
    {
        openness = abs( openness );
    }
    
    if ( !istrue( function_60d6151af81a343( id, "path_has_door" ) ) || isdefined( openness ) && openness > 45 )
    {
        idlealias += "_doorless";
    }
    
    type = function_60d6151af81a343( id, "breachtype" );
    rolestring = type;
    capinfo = getcapinfoforrole( self, rolestring );
    animset = capinfo.animation;
    animid = archetypegetrandomalias( animset, idlestate, idlealias, 0 );
    assert( animid >= 0 );
    xanim = animsetgetanimfromindex( animset, idlestate, animid );
    idleorigin = getstartorigin( origin, angles, xanim );
    idleangles = getstartangles( origin, angles, xanim );
    snappedidleorigin = getclosestpointonnavmesh( idleorigin, self, 0, 1, 0 );
    
    if ( isdefined( snappedidleorigin ) )
    {
        idleorigin = snappedidleorigin;
    }
    
    self.customarrivalstate = idlealias + "_door_arrival";
    self.customarrivalanimset = animset;
    self.customarrivalangles = angles;
    self.customarrivalanimangles = idleangles;
    self.var_171120e99df3e286 = 1;
    self.var_a2a6c6c46defe8c4 = 1;
    self.capdata = spawnstruct();
    self.capdata.asmname = capinfo.capname;
    self.capdata.animsetname = animset;
    self.capdata.dooralias = idlealias;
    self.capdata.angles = idleangles;
    self.capdata.var_2b1676bab1ba8985 = "solo";
    self.capdata.role = role;
    self.capdata.idleorigin = idleorigin;
    
    if ( role == "support" )
    {
        self.capdata.var_2b1676bab1ba8985 = "dual";
    }
    
    self.customarrivalhandler = &customarrivalhandler;
    
    /#
        if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
        {
            thread function_64fca4864613393f( idleorigin, idleangles );
        }
    #/
    
    return idleorigin;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x9f7
// Size: 0x1c6
function private function_17c9514d056f8b0c( statename, mindist, maxdist )
{
    id = self getinteractionid();
    origin = getinteractionorigin( id );
    doortome = vectornormalize( self.origin - origin );
    dist = randomintrange( mindist, maxdist );
    endpoint = origin + doortome * dist;
    
    /#
        if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
        {
            line( origin, endpoint, ( 0, 0, 1 ), 1, 0, 200 );
        }
    #/
    
    point = findclosestlospointwithinradius( origin, maxdist, origin, endpoint );
    
    if ( !isdefined( point ) )
    {
        point = findclosesttacpoint( endpoint );
        
        if ( isdefined( point ) )
        {
            /#
                if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
                {
                    print3d( point.origin + ( 0, 0, 100 ), "<dev string:x1c>", ( 255, 255, 255 ), 1, 0.6, 200 );
                    draw_circle( point.origin, 16, ( 1, 1, 0 ), 1, 0, 200 );
                }
            #/
            
            return point.origin;
        }
        else
        {
            point = self getclosestreachablepointonnavmesh( endpoint );
        }
        
        /#
            if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
            {
                print3d( point + ( 0, 0, 100 ), "<dev string:x1c>", ( 255, 255, 255 ), 1, 0.6, 200 );
                draw_circle( point, 16, ( 1, 1, 0 ), 1, 0, 200 );
            }
        #/
    }
    
    return point;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xbc6
// Size: 0x58
function private customarrivalhandler()
{
    assert( isdefined( self.capdata ) );
    self.capdata.var_74c9b1f78857273d = 1;
    scripts\common\cap::cap_start( self.capdata.asmname, self.capdata.animsetname );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xc26
// Size: 0x13
function private arrivalsetup( statename, params )
{
    
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xc41
// Size: 0x4f
function private arrivalcleanup( statename, params )
{
    self.customarrivalstate = undefined;
    self.customarrivalanimset = undefined;
    self.customarrivalangles = undefined;
    self.customarrivalanimangles = undefined;
    self.var_171120e99df3e286 = 0;
    self.var_a2a6c6c46defe8c4 = 0;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xc98
// Size: 0x4e
function private opendoor( interactionid, var_d293838fe8a43473 )
{
    doorobj = function_60d6151af81a343( interactionid, "door" );
    
    if ( isdefined( doorobj ) && doorobj scriptabledoorisclosed() )
    {
        doorobj scriptabledooropen( "away", self.origin );
    }
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xcee
// Size: 0x1a7
function private onarrival( statename, params )
{
    if ( !istrue( self.capdata.var_74c9b1f78857273d ) )
    {
        arrivalcleanup();
        scripts\common\cap::cap_start( self.capdata.asmname, self.capdata.animsetname );
    }
    
    self.doorcheck.arrived = 1;
    self.capdata.var_9c471c82abe76355 = self.script_pushable;
    self.capdata.var_512299ff86496ad6 = self.script_pushable_by_ai;
    self.script_pushable = 0;
    self.script_pushable_by_ai = 0;
    sidetoken = self.capdata.dooralias;
    numbertoken = self.capdata.var_2b1676bab1ba8985;
    roletoken = self.capdata.role;
    self.capdata.var_c58c71ebc71f7728 = sidetoken + "_" + numbertoken + "_" + roletoken;
    self interactioncleargoalpos();
    id = self getinteractionid();
    breachtype = function_60d6151af81a343( id, "breachtype" );
    var_48d356c204bf2b81 = isdefined( breachtype ) && breachtype == "flashbang";
    
    if ( var_48d356c204bf2b81 && function_60d6151af81a343( id, "path_has_door" ) )
    {
        opendoor( id, self.origin );
    }
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xe9d
// Size: 0x56
function private onbailout( statename, params )
{
    id = self getinteractionid();
    abortinteraction( id );
    doorid = function_60d6151af81a343( id, "doorindex" );
    
    if ( isdefined( doorid ) )
    {
        updateroomdoorclaim( doorid, gettime() + 10000 );
    }
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xefb
// Size: 0xfd
function private onenter( statename, params )
{
    self endon( "death" );
    self.capdata.var_3f651b778e93656e = 1;
    
    if ( isdefined( self.doorcheck.priornode ) )
    {
        self setbtgoalnode( 3, self.doorcheck.priornode );
        self.doorcheck.priornode = undefined;
    }
    else if ( isdefined( self.doorcheck.priorgoalpos ) )
    {
        self setbtgoalpos( 3, self.doorcheck.priorgoalpos );
        self.doorcheck.priorgoalpos = undefined;
    }
    
    endtime = gettime() + 5000;
    waitframe();
    
    while ( gettime() < endtime )
    {
        if ( self asmeventfired( self.asmname, "end" ) )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 4
// Checksum 0x0, Offset: 0x1000
// Size: 0x37, Type: bool
function doorcheck_shoulddoarrival( asmname, statename, tostatename, params )
{
    return istrue( self.capdata.var_74c9b1f78857273d );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 4
// Checksum 0x0, Offset: 0x1040
// Size: 0x37, Type: bool
function function_57787698e416086f( asmname, statename, tostatename, params )
{
    return istrue( self.capdata.var_3f651b778e93656e );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 3
// Checksum 0x0, Offset: 0x1080
// Size: 0x42
function function_14242f7e3e92261c( asmname, statename, params )
{
    alias = self.capdata.dooralias;
    return scripts\asm\asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 3
// Checksum 0x0, Offset: 0x10cb
// Size: 0x76
function function_cfa7813e89867c4( asmname, statename, params )
{
    alias = self.capdata.dooralias + "_" + self.capdata.var_2b1676bab1ba8985 + "_" + self.capdata.role;
    return scripts\asm\asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 0
// Checksum 0x0, Offset: 0x114a
// Size: 0x1a
function function_cea2a40434f5918()
{
    if ( utility::issp() )
    {
        return "flash";
    }
    
    return "flash_grenade_mp";
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1
// Checksum 0x0, Offset: 0x116c
// Size: 0x14b
function function_ce30ac74cab64cfd( note )
{
    if ( note == "door_open" )
    {
        opendoor( self getinteractionid(), self.origin );
        return;
    }
    
    if ( note == "grenade_left" || note == "grenade_right" )
    {
        grenadeweapon = function_cea2a40434f5918();
        grenademodel = getweaponmodel( grenadeweapon );
        assert( isdefined( grenademodel ) );
        
        if ( note == "grenade_left" )
        {
            self.grenadeattachtag = t"tag_accessory_left";
        }
        else
        {
            self.grenadeattachtag = t"tag_accessory_right";
        }
        
        self attach( grenademodel, self.grenadeattachtag );
        self.grenademodel = grenademodel;
        thread function_184b5862455e8902();
        return;
    }
    
    if ( note == "grenade_throw" )
    {
        assert( isdefined( self.grenadeattachtag ) );
        grenadeweapon = function_cea2a40434f5918();
        grenadepos = self gettagorigin( self.grenadeattachtag );
        magicgrenademanual( grenadeweapon, grenadepos, self.doorcheck.grenadedir * 20, 1, self );
        self detach( self.grenademodel, self.grenadeattachtag );
        self.grenademodel = undefined;
        self.grenadeattachtag = undefined;
    }
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 0
// Checksum 0x0, Offset: 0x12bf
// Size: 0x92
function function_184b5862455e8902()
{
    self endon( "death" );
    self endon( "bseq_user_deleted" );
    prevhandpos = self gettagorigin( self.grenadeattachtag );
    self.doorcheck.grenadedir = anglestoforward( self.angles );
    waitframe();
    
    while ( isdefined( self.grenadeattachtag ) )
    {
        handpos = self gettagorigin( self.grenadeattachtag );
        self.doorcheck.grenadedir = handpos - prevhandpos;
        prevhandpos = handpos;
        waitframe();
    }
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 3
// Checksum 0x0, Offset: 0x1359
// Size: 0x70
function function_a3564484875da8f8( asmname, statename, params )
{
    thread scripts\asm\asm::function_fb56c9527636713f( asmname, statename, 1 );
    self orientmode( "face angle", self.capdata.angles[ 1 ] );
    self asmfireephemeralevent( "arrived", "end" );
    self.doorcheck.arrived = 1;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 3
// Checksum 0x0, Offset: 0x13d1
// Size: 0x58
function function_26b903a39f018550( asmname, statename, params )
{
    thread scripts\asm\asm::asm_playanimstate( asmname, statename, params );
    self function_802c56a3df8c7797( self.capdata.idleorigin, self.capdata.angles, 0.3 );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 4
// Checksum 0x0, Offset: 0x1431
// Size: 0xe9, Type: bool
function function_a910d69a0daa7775( asmname, statename, tostatename, params )
{
    if ( !isdefined( params ) || isarray( params ) )
    {
        assertmsg( "<dev string:x33>" );
        return false;
    }
    
    if ( !isdefined( self.capdata.dooralias ) )
    {
        return false;
    }
    
    side = self.capdata.dooralias;
    
    if ( isdefined( self.capdata.role ) && self.capdata.role == "support" )
    {
        if ( side == "left" )
        {
            side = "right";
        }
        else if ( side == "right" )
        {
            side = "left";
        }
    }
    
    return self.capdata.dooralias == params;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1523
// Size: 0x32, Type: bool
function private function_23cd7f6fdf460eb4( params )
{
    return istrue( self.doorcheck.arrived ) || self isingoal( self.origin );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x155e
// Size: 0x1f, Type: bool
function private function_21bcb65ded71229f( params )
{
    return istrue( self.doorcheck.arrived );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1586
// Size: 0x137, Type: bool
function private function_e62b12681729b218( asmname, statename, tostatename, params )
{
    id = self getinteractionid();
    assert( isdefined( id ) );
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    doordir = anglestoforward( angles );
    var_5c6afc1001475042 = origin - self.origin;
    cross = vectorcross( var_5c6afc1001475042, doordir );
    bleft = 1;
    
    if ( cross[ 2 ] < 0 )
    {
        bleft = 0;
    }
    
    if ( bleft )
    {
        desiredside = "left";
    }
    else
    {
        desiredside = "right";
    }
    
    var_bb3bfbc5f90b8e98 = function_60d6151af81a343( id, "door_knob" );
    mustcross = desiredside == var_bb3bfbc5f90b8e98;
    openness = function_60d6151af81a343( id, "openness" );
    dooropen = 1;
    
    if ( isdefined( openness ) )
    {
        openness = abs( openness );
        dooropen = openness >= 45;
    }
    
    if ( mustcross && dooropen )
    {
        return false;
    }
    
    return true;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x16c6
// Size: 0x4d, Type: bool
function private function_17557d7a61c7b24a( asmname, statename, tostatename, params )
{
    id = self getinteractionid();
    hasdoor = function_60d6151af81a343( id, "path_has_door" );
    return !istrue( hasdoor );
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x171c
// Size: 0xb9, Type: bool
function private function_27937ccb1b1abef1( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    id = self getinteractionid();
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    doordir = anglestoforward( angles );
    enemypos = self.enemy.origin;
    toenemy = vectornormalize2( enemypos - origin );
    delta = vectordot( doordir, toenemy );
    return delta <= 0;
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x17de
// Size: 0x24
function private function_af686e8a0657ce57( interactionid )
{
    self.capdata.var_2b1676bab1ba8985 = "dual";
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1
// Checksum 0x0, Offset: 0x180a
// Size: 0xb
function function_8055622a418ebd4f( interactionid )
{
    
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 1
// Checksum 0x0, Offset: 0x181d
// Size: 0xb
function GoalCheckCleanup( interactionid )
{
    
}

// Namespace door_check / namespace_4ef97519f59e04e6
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1830
// Size: 0x1a8
function private function_64fca4864613393f( idleorigin, idleangles )
{
    self endon( "death" );
    forward = anglestoforward( idleangles );
    end = idleorigin + forward * 32;
    id = self getinteractionid();
    breachtype = function_60d6151af81a343( id, "breachtype" );
    intorg = getinteractionorigin( id );
    intfwd = anglestoforward( getinteractionangles( id ) );
    intend = intorg + intfwd * 32;
    draw_arrow_time( intorg, intend, ( 150, 50, 150 ), 5 );
    draw_arrow_time( idleorigin, end, ( 150, 50, 150 ), 5 );
    
    /#
        print3d( idleorigin + ( 0, 0, 100 ), breachtype, ( 255, 255, 255 ), 1, 0.6, 200 );
    #/
    
    /#
        print3d( idleorigin + ( 0, 0, 80 ), self.capdata.dooralias + "<dev string:x6e>" + self.capdata.var_2b1676bab1ba8985 + "<dev string:x6e>" + self.capdata.role, ( 255, 255, 255 ), 1, 0.6, 150 );
    #/
    
    /#
        print3d( idleorigin + ( 0, 0, 60 ), self.customarrivalstate, ( 255, 255, 255 ), 1, 0.4, 150 );
    #/
}

