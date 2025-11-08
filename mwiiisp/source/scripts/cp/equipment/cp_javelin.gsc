#using scripts\common\utility;
#using scripts\cp\utility\entity;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace cp_javelin;

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x255
// Size: 0x93
function javelinusageloop()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "end_launcher" );
    javelin_init();
    
    while ( true )
    {
        weapon = self getcurrentweapon();
        
        if ( weapon.basename == "iw9_la_juliet_mp" && javelin_shouldjavelinthink() )
        {
            self.javelin.stopthinking = 0;
            thread javelin_think();
        }
        else
        {
            self.javelin.stopthinking = 1;
        }
        
        self waittill( "weapon_change" );
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x2f0
// Size: 0x2a8
function javelin_init()
{
    self.javelin = spawnstruct();
    
    if ( !isdefined( level.javelin ) )
    {
        level.javelin = spawnstruct();
        level.javelin.states = [];
        level.javelin.states[ "off" ] = [];
        level.javelin.states[ "off" ][ "enter" ] = &javelin_offstateenter;
        level.javelin.states[ "off" ][ "update" ] = &javelin_offstateupdate;
        level.javelin.states[ "off" ][ "exit" ] = &javelin_offstateexit;
        level.javelin.states[ "scanning" ] = [];
        level.javelin.states[ "scanning" ][ "enter" ] = &javelin_scanningstateenter;
        level.javelin.states[ "scanning" ][ "update" ] = &javelin_scanningstateupdate;
        level.javelin.states[ "hold" ] = [];
        level.javelin.states[ "hold" ][ "enter" ] = &javelin_holdstateenter;
        level.javelin.states[ "hold" ][ "update" ] = &javelin_holdstateupdate;
        level.javelin.states[ "hold" ][ "exit" ] = &javelin_holdstateexit;
        level.javelin.states[ "fire" ] = [];
        level.javelin.states[ "fire" ][ "enter" ] = &javelin_firestateenter;
        level.javelin.states[ "fire" ][ "update" ] = &javelin_firestateupdate;
        level.javelin.states[ "fire" ][ "exit" ] = &javelin_firestateexit;
        level.javelin.states[ "too_close" ] = [];
        level.javelin.states[ "too_close" ][ "enter" ] = &javelin_tooclosestateenter;
        level.javelin.states[ "too_close" ][ "update" ] = &javelin_tooclosestateupdate;
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x5a0
// Size: 0x11a
function javelin_reset()
{
    if ( !isdefined( self.javelin ) )
    {
        return;
    }
    
    self.javelin.adsraisedelaytimer = undefined;
    self.javelin.target = undefined;
    self.javelin.lockstarttime = undefined;
    self.javelin.vehiclelostsightlinetime = undefined;
    self.javelin.groundlockmisses = 0;
    self.javelin.targetnormal = undefined;
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        self.javelin.groundlockonent scripts\cp_mp\ent_manager::deregisterspawn();
        self.javelin.groundlockonent delete();
    }
    
    self.javelin.groundlockonent = undefined;
    self.javelin.groundpoints = undefined;
    self.javelin.state = undefined;
    self.javelin.queuedstate = undefined;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x6c2
// Size: 0xbd
function javelin_offstateenter( fromstate )
{
    if ( isdefined( self.javelin.target ) )
    {
        removelockedon( self.javelin.target, self );
        self.javelin.target = undefined;
    }
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        self.javelin.groundlockonent scripts\cp_mp\ent_manager::deregisterspawn();
        self.javelin.groundlockonent delete();
    }
    
    self.javelin.groundlockonent = undefined;
    javelin_hidenormalhud( 0 );
    javelin_setuistate( 0 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x787
// Size: 0x1d
function javelin_offstateupdate()
{
    if ( self playerads() >= 0.9 )
    {
        javelin_queuestate( "scanning" );
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x7ac
// Size: 0xb
function javelin_offstateexit()
{
    javelin_hidenormalhud( 1 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x7bf
// Size: 0x21
function javelin_deathwatcher()
{
    self endon( "weapon_change" );
    self waittill( "death" );
    javelin_hidenormalhud( 0 );
    javelin_setuistate( 0 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x7e8
// Size: 0x30
function javelin_scanningstateenter( fromstate )
{
    javelin_setuistate( 1 );
    self.javelin.adsraisedelaytimer = gettime() + 100;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x820
// Size: 0x4c7
function javelin_scanningstateupdate()
{
    if ( gettime() < self.javelin.adsraisedelaytimer )
    {
        return;
    }
    
    vehicletarget = javelin_scanforvehicletarget();
    
    if ( isdefined( vehicletarget ) )
    {
        if ( javelin_targetpointtooclose( vehicletarget.origin ) )
        {
            javelin_queuestate( "too_close" );
            return;
        }
        
        /#
            function_26c6f6de312b721f( "<dev string:x1c>" );
        #/
        
        if ( isdefined( self.javelin.target ) && self.javelin.target == vehicletarget )
        {
            q = 1;
        }
        
        self.javelin.target = vehicletarget;
        
        if ( isdefined( self.javelin.target ) )
        {
            addlockedon( self.javelin.target, self );
        }
        
        if ( !isdefined( self.javelinlocationtargeted ) )
        {
            marklocation( self.javelin.target );
        }
        
        javelin_queuestate( "hold" );
        return;
    }
    
    if ( self attackbuttonpressed() )
    {
        if ( self.javelin.groundlockmisses >= 1 )
        {
            self.javelin.groundlockmisses = 0;
            self.javelin.groundpoints = undefined;
            return;
        }
        
        /#
            if ( getdvar( @"missiledebugdraw" ) == "<dev string:x47>" && isdefined( self.javelin.groundpoints ) )
            {
                foreach ( var_8ed3cf11185e5d34 in self.javelin.groundpoints )
                {
                    function_2230e7ba8b6c416f( var_8ed3cf11185e5d34, ( 0.8, 1, 0.8 ) );
                }
                
                function_2230e7ba8b6c416f( self.javelin.groundpoints[ self.javelin.groundpoints.size - 1 ], ( 1, 1, 0.2 ) );
                function_2230e7ba8b6c416f( averagepoint( self.javelin.groundpoints ), ( 0.2, 0.2, 1 ) );
            }
        #/
        
        traceresults = javelin_eyetraceforward();
        
        if ( !isdefined( traceresults ) )
        {
            self.javelin.groundlockmisses++;
            return;
        }
        
        if ( javelin_targetpointtooclose( traceresults[ 0 ] ) )
        {
            javelin_queuestate( "too_close" );
            return;
        }
        
        if ( isdefined( self.javelin.groundpoints ) )
        {
            var_82d5206f31aafac2 = averagepoint( self.javelin.groundpoints );
            dist = distance( var_82d5206f31aafac2, traceresults[ 0 ] );
            
            if ( dist > 400 )
            {
                self.javelin.groundlockmisses++;
                return;
            }
        }
        else
        {
            self.javelin.groundpoints = [];
            self.javelin.groundnormals = [];
        }
        
        self.javelin.groundpoints[ self.javelin.groundpoints.size ] = traceresults[ 0 ];
        self.javelin.groundnormals[ self.javelin.groundnormals.size ] = traceresults[ 1 ];
        self.javelin.groundlockmisses = 0;
        
        if ( self.javelin.groundpoints.size < 2 )
        {
            return;
        }
        
        targetpoint = averagepoint( self.javelin.groundpoints );
        self.javelin.groundlockonent = spawn_tag_origin( targetpoint );
        self.javelin.groundlockonent scripts\cp_mp\ent_manager::registerspawncount( 1 );
        self.javelin.target = self.javelin.groundlockonent;
        self.javelin.groundlockmisses = 0;
        self.javelin.groundpoints = undefined;
        self.javelin.groundnormals = undefined;
        
        if ( !isdefined( self.javelinlocationtargeted ) )
        {
            marklocation( self.javelin.target );
        }
        
        javelin_queuestate( "hold" );
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0xcef
// Size: 0x6e
function javelin_holdstateenter( fromstate )
{
    javelin_setuistate( 2 );
    self.javelin.lockstarttime = gettime();
    self.javelin.lostsightlinetime = 0;
    self weaponlockstart( self.javelin.target );
    thread javelin_looplocalseeksound( "javelin_clu_acquiring_lock", 0.5 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0xd65
// Size: 0x1e4
function javelin_holdstateupdate()
{
    var_e688b198aa9a4b3f = 0;
    
    /#
        var_e688b198aa9a4b3f = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    /#
        if ( getdvar( @"missiledebugdraw" ) == "<dev string:x47>" )
        {
            function_2230e7ba8b6c416f( self.javelin.target.origin, ( 0.5, 1, 0.6 ) );
        }
    #/
    
    losthold = 0;
    
    if ( !var_e688b198aa9a4b3f && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer( self.javelin.target, self ) )
    {
        javelin_queuestate( "scanning" );
        losthold = 1;
    }
    
    if ( !javelin_checktargetstillheld( self.javelin.target ) )
    {
        javelin_queuestate( "scanning" );
        losthold = 1;
    }
    
    if ( javelin_targetpointtooclose( self.javelin.target.origin ) )
    {
        javelin_queuestate( "too_close" );
        losthold = 1;
    }
    
    if ( losthold )
    {
        if ( isdefined( self.javelin.target ) )
        {
            removelockedon( self.javelin.target, self );
        }
        
        self weaponlockfree();
        self.javelin.target = undefined;
        
        if ( isdefined( self.javelin.groundlockonent ) )
        {
            self.javelin.groundlockonent delete();
        }
    }
    
    timepassed = gettime() - self.javelin.lockstarttime;
    
    if ( timepassed < 1150 )
    {
        return;
    }
    
    javelin_queuestate( "fire" );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0xf51
// Size: 0x16
function javelin_holdstateexit()
{
    self notify( "stop_lockon_sound" );
    self stoplocalsound( "javelin_clu_acquiring_lock" );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0xf6f
// Size: 0x107
function javelin_firestateenter( fromstate )
{
    javelin_setuistate( 3 );
    
    if ( !isdefined( self.javelin.target ) )
    {
        return;
    }
    
    if ( isplayer( self.javelin.target ) )
    {
        self weaponlockfinalize( self.javelin.target, ( 0, 0, 64 ), 0 );
    }
    else if ( isdefined( self.javelin.groundlockonent ) )
    {
        self weaponlockfinalize( self.javelin.target, ( 0, 0, 0 ), 1 );
    }
    else
    {
        vehicleoffset = javelin_getvehicleoffset( self.javelin.target );
        self weaponlockfinalize( self.javelin.target, vehicleoffset, 0 );
    }
    
    thread javelin_looplocalseeksound( "javelin_clu_lock", 1.6 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x107e
// Size: 0xc8
function javelin_firestateupdate()
{
    var_e688b198aa9a4b3f = 0;
    
    /#
        var_e688b198aa9a4b3f = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    if ( !var_e688b198aa9a4b3f && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer( self.javelin.target, self ) )
    {
        javelin_queuestate( "scanning" );
    }
    
    if ( !javelin_checktargetstillheld( self.javelin.target ) )
    {
        javelin_queuestate( "scanning" );
    }
    
    if ( javelin_targetpointtooclose( self.javelin.target.origin ) )
    {
        javelin_queuestate( "too_close" );
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x114e
// Size: 0x92
function javelin_firestateexit()
{
    if ( isdefined( self.javelin.target ) )
    {
        removelockedon( self.javelin.target, self );
    }
    
    self weaponlockfree();
    self.javelin.target = undefined;
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        self.javelin.groundlockonent delete();
    }
    
    self notify( "stop_lockon_sound" );
    self stoplocalsound( "javelin_clu_lock" );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x11e8
// Size: 0x14
function javelin_tooclosestateenter( fromstate )
{
    javelin_setuistate( 4 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x1204
// Size: 0x75
function javelin_tooclosestateupdate()
{
    vehicletarget = javelin_scanforvehicletarget();
    
    if ( isdefined( vehicletarget ) )
    {
        if ( !javelin_targetpointtooclose( vehicletarget.origin ) )
        {
            javelin_queuestate( "scanning" );
            return;
        }
        
        return;
    }
    
    traceresults = javelin_eyetraceforward();
    
    if ( !isdefined( traceresults ) || isdefined( traceresults ) && javelin_targetpointtooclose( traceresults[ 0 ] ) == 0 )
    {
        javelin_queuestate( "scanning" );
        return;
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x1281
// Size: 0x51
function javelin_preupdate()
{
    if ( isdefined( self.javelin.state ) && self.javelin.state != "off" )
    {
        if ( self playerads() < 0.9 )
        {
            javelin_queuestate( "off" );
        }
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x12da
// Size: 0x83, Type: bool
function javelin_checktargetstillheld( targetent )
{
    if ( !isdefined( targetent ) )
    {
        return false;
    }
    
    insidereticle = self worldpointinreticle_rect( targetent.origin, 35, 120, 80 );
    
    if ( !insidereticle )
    {
        return false;
    }
    
    if ( !isdefined( self.javelin.groundlockonent ) && !javelin_softsighttest( targetent ) )
    {
        return false;
    }
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        if ( !self attackbuttonpressed() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x1366
// Size: 0xe3
function javelin_eyetraceforward()
{
    origin = self geteye();
    angles = self getplayerangles();
    forward = anglestoforward( angles );
    endpoint = origin + forward * 15000;
    res = scripts\engine\trace::_bullet_trace( origin, endpoint, 0, undefined );
    
    /#
        if ( getdvar( @"missiledebugdraw" ) == "<dev string:x47>" )
        {
        }
    #/
    
    if ( res[ "surfacetype" ] == "surftype_none" && res[ "hittype" ] == "hittype_none" )
    {
        return undefined;
    }
    
    if ( res[ "surfacetype" ] == "default" )
    {
        return undefined;
    }
    
    ent = res[ "entity" ];
    results = [];
    results[ 0 ] = res[ "position" ];
    results[ 1 ] = res[ "normal" ];
    return results;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x1452
// Size: 0x44, Type: bool
function javelin_targetpointtooclose( targetpoint )
{
    var_71e6d19172e88145 = 1100;
    
    if ( !isdefined( targetpoint ) )
    {
        return false;
    }
    
    dist = distance( self.origin, targetpoint );
    
    if ( dist < var_71e6d19172e88145 )
    {
        return true;
    }
    
    return false;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 2
// Checksum 0x0, Offset: 0x149f
// Size: 0x2e
function javelin_looplocalseeksound( alias, interval )
{
    self endon( "death_or_disconnect" );
    self endon( "stop_lockon_sound" );
    
    for ( ;; )
    {
        self playlocalsound( alias );
        wait interval;
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x14d5
// Size: 0x20
function javelin_queuestate( statename )
{
    self.javelin.queuedstate = statename;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x14fd
// Size: 0x15
function javelin_getqueuedstate()
{
    return self.javelin.queuedstate;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x151b
// Size: 0x117
function javelin_enterstate( statename )
{
    assertex( isdefined( level.javelin.states[ statename ] ), "javelin_setState called with uninitialized state '" + statename + "' !" );
    
    /#
        function_26c6f6de312b721f( "<dev string:x49>" + statename + "<dev string:x62>" );
    #/
    
    fromstate = self.javelin.state;
    
    if ( isdefined( fromstate ) && isdefined( level.javelin.states[ fromstate ][ "exit" ] ) )
    {
        self [[ level.javelin.states[ fromstate ][ "exit" ] ]]();
    }
    
    self.javelin.state = statename;
    
    if ( isdefined( level.javelin.states[ statename ][ "enter" ] ) )
    {
        self [[ level.javelin.states[ statename ][ "enter" ] ]]( fromstate );
    }
    
    self.javelin.queuedstate = undefined;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x163a
// Size: 0x9, Type: bool
function javelin_shouldjavelinthink()
{
    return !scripts\cp_mp\emp_debuff::is_empd();
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x164c
// Size: 0xf6
function javelin_think()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "weapon_change" );
    self notify( "javelin_think" );
    self endon( "javelin_think" );
    javelin_reset();
    javelin_enterstate( "off" );
    thread javelin_deathwatcher();
    
    while ( true )
    {
        if ( isdefined( self.javelin.stopthinking ) && self.javelin.stopthinking )
        {
            javelin_enterstate( "off" );
            return;
        }
        
        if ( !javelin_shouldjavelinthink() )
        {
            javelin_enterstate( "off" );
            return;
        }
        
        javelin_preupdate();
        queuedstate = javelin_getqueuedstate();
        
        if ( isdefined( queuedstate ) )
        {
            javelin_enterstate( queuedstate );
        }
        
        self [[ level.javelin.states[ self.javelin.state ][ "update" ] ]]();
        wait 0.05;
    }
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 0
// Checksum 0x0, Offset: 0x174a
// Size: 0x117
function javelin_scanforvehicletarget()
{
    targets = scripts\cp\weapon::lockonlaunchers_gettargetarray();
    
    foreach ( target in targets )
    {
        if ( !isent( target ) )
        {
            targets = array_remove( targets, target );
        }
    }
    
    if ( targets.size != 0 )
    {
        var_8110370edb23215a = [];
        
        foreach ( target in targets )
        {
            insidereticle = self worldpointinreticle_rect( target.origin, 35, 120, 80 );
            
            if ( insidereticle )
            {
                var_8110370edb23215a[ var_8110370edb23215a.size ] = target;
            }
        }
        
        if ( var_8110370edb23215a.size != 0 )
        {
            sortedtargets = sortbydistance( var_8110370edb23215a, self.origin );
            
            if ( javelin_vehiclelocksighttest( sortedtargets[ 0 ] ) )
            {
                return sortedtargets[ 0 ];
            }
        }
    }
    
    return undefined;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x186a
// Size: 0xc2, Type: bool
function javelin_vehiclelocksighttest( target )
{
    eyepos = self geteye();
    center = target getpointinbounds( 0, 0, 1 );
    passed = sighttracepassed( eyepos, center, 0, target );
    
    /#
        function_9c1d49cefcf64a9b( eyepos, center, passed );
    #/
    
    if ( passed )
    {
        return true;
    }
    
    front = target getpointinbounds( 1, 0, 0 );
    passed = sighttracepassed( eyepos, front, 0, target );
    
    /#
        function_9c1d49cefcf64a9b( eyepos, front, passed );
    #/
    
    if ( passed )
    {
        return true;
    }
    
    back = target getpointinbounds( -1, 0, 0 );
    passed = sighttracepassed( eyepos, back, 0, target );
    
    /#
        function_9c1d49cefcf64a9b( eyepos, back, passed );
    #/
    
    if ( passed )
    {
        return true;
    }
    
    return false;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x1935
// Size: 0xec
function javelin_getvehicleoffset( vehicletarget )
{
    offset = ( 0, 0, 0 );
    
    if ( !isdefined( vehicletarget ) )
    {
        return offset;
    }
    
    if ( ischoppergunner( vehicletarget ) )
    {
        offset = ( 0, 0, -50 );
    }
    else if ( issupporthelo( vehicletarget ) )
    {
        offset = ( 0, 0, -100 );
    }
    else if ( isgunship( vehicletarget ) )
    {
        offset = ( 0, 0, 50 );
    }
    else if ( isclusterstrike( vehicletarget ) )
    {
        offset = ( 0, 0, 40 );
    }
    else if ( isradardrone( vehicletarget ) )
    {
        offset = ( 0, 0, 10 );
    }
    else if ( isscramblerdrone( vehicletarget ) )
    {
        offset = ( 0, 0, 10 );
    }
    else if ( isradarhelicopter( vehicletarget ) )
    {
        offset = ( 0, 0, -30 );
    }
    
    return offset;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x1a2a
// Size: 0x8e, Type: bool
function javelin_softsighttest( targetent )
{
    if ( javelin_vehiclelocksighttest( targetent ) )
    {
        self.javelin.lostsightlinetime = 0;
        return true;
    }
    
    if ( self.javelin.lostsightlinetime == 0 )
    {
        self.javelin.lostsightlinetime = gettime();
    }
    
    timepassed = gettime() - self.javelin.lostsightlinetime;
    
    if ( timepassed >= 500 )
    {
        return false;
    }
    
    return true;
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x1ac1
// Size: 0x54
function javelin_hidenormalhud( enable )
{
    if ( enable )
    {
        self setclientomnvar( "ui_javelin_view", 1 );
        
        /#
            if ( getdvar( @"missiledebugtext" ) == "<dev string:x47>" )
            {
                self setclientomnvar( "<dev string:x65>", 0 );
            }
        #/
        
        return;
    }
    
    self setclientomnvar( "ui_javelin_view", 0 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x1b1d
// Size: 0x97
function javelin_setuistate( state )
{
    self setclientomnvar( "ui_javelin_state", state );
    
    /#
        if ( getdvar( @"missiledebugtext" ) == "<dev string:x47>" )
        {
            if ( state == 0 )
            {
                iprintlnbold( "<dev string:x75>" );
                return;
            }
            
            if ( state == 1 )
            {
                iprintlnbold( "<dev string:x84>" );
                return;
            }
            
            if ( state == 2 )
            {
                iprintlnbold( "<dev string:x98>" );
                return;
            }
            
            if ( state == 3 )
            {
                iprintlnbold( "<dev string:xa8>" );
                return;
            }
            
            if ( state == 4 )
            {
                iprintlnbold( "<dev string:xb8>" );
            }
        }
    #/
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 1
// Checksum 0x0, Offset: 0x1bbc
// Size: 0x56
function marklocation( markpos )
{
    var_f27c7690b259ec3a = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "javelincrosshair", self, markpos, self );
    
    if ( markpos.model == "tag_origin" )
    {
        markpos show();
    }
    
    self.javelinlocationtargeted = 1;
    thread watchtargetmarkerentstatus( markpos, var_f27c7690b259ec3a, 1 );
}

// Namespace cp_javelin / scripts\cp\equipment\cp_javelin
// Params 3
// Checksum 0x0, Offset: 0x1c1a
// Size: 0x71
function watchtargetmarkerentstatus( var_d99ed5531d1fdc1f, targetmarkergroup, istag )
{
    level endon( "game_ended" );
    
    while ( isdefined( self.javelin.target ) && self.javelin.state != "off" )
    {
        waitframe();
    }
    
    if ( isdefined( targetmarkergroup ) )
    {
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_off( targetmarkergroup );
    }
    
    self.javelinlocationtargeted = undefined;
}

/#

    // Namespace cp_javelin / scripts\cp\equipment\cp_javelin
    // Params 1
    // Checksum 0x0, Offset: 0x1c93
    // Size: 0x2c, Type: dev
    function function_26c6f6de312b721f( text )
    {
        if ( getdvar( @"missiledebugtext" ) == "<dev string:x47>" )
        {
            iprintln( text );
        }
    }

    // Namespace cp_javelin / scripts\cp\equipment\cp_javelin
    // Params 2
    // Checksum 0x0, Offset: 0x1cc7
    // Size: 0x85, Type: dev
    function function_2230e7ba8b6c416f( point, color )
    {
        line( point + ( 10, 0, 0 ), point - ( 10, 0, 0 ), color );
        line( point + ( 0, 10, 0 ), point - ( 0, 10, 0 ), color );
        line( point + ( 0, 0, 10 ), point - ( 0, 0, 10 ), color );
    }

    // Namespace cp_javelin / scripts\cp\equipment\cp_javelin
    // Params 3
    // Checksum 0x0, Offset: 0x1d54
    // Size: 0x87, Type: dev
    function function_9c1d49cefcf64a9b( start, end, passed )
    {
        if ( getdvar( @"missiledebugdraw" ) != "<dev string:x47>" )
        {
            return;
        }
        
        if ( passed )
        {
            color = ( 0.3, 1, 0.3 );
        }
        else
        {
            color = ( 1, 0.2, 0.2 );
        }
        
        my_offset = ( 0, 0, 5 );
        line( start + my_offset, end, color );
    }

#/
