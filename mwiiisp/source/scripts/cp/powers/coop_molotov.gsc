#using scripts\common\utility;
#using scripts\cp\cp_weapons;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace coop_molotov;

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x5ec
// Size: 0x14b
function molotov_init()
{
    assertex( !isdefined( level.molotov ), "molotov_init() was called more than once." );
    leveldata = spawnstruct();
    level.molotov = leveldata;
    leveldata.maxpools = getdvarint( @"hash_541e147e1379b35e", 100 );
    leveldata.maxcastsperframe = getdvarint( @"hash_3b54ad814e59b401", 8 );
    leveldata.immediatecleanup = getdvarint( @"hash_ec13dc5b3ae7d79c", 1 ) > 0;
    leveldata.uniquepoolid = 0;
    leveldata.poolids = [];
    leveldata.scriptables = [];
    leveldata.triggers = [];
    leveldata.frametimestamp = 0;
    leveldata.caststhisframe = 0;
    molotov_init_cast_data();
    molotov_init_pool_data();
    level.g_effect[ "vfx_burn_med_low" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx" );
    level.g_effect[ "vfx_burn_sml_low" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx" );
    level.g_effect[ "vfx_burn_sml_head_low" ] = loadfx( "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx" );
    registersharedfunc( "molotov", "molotov_simulate_impact", &molotov_simulate_impact );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x73f
// Size: 0x22d
function molotov_init_cast_data()
{
    leveldata = molotov_get_level_data();
    castdata = leveldata.castdata;
    
    if ( !isdefined( castdata ) )
    {
        castdata = spawnstruct();
        leveldata.castdata = castdata;
    }
    
    castdata.distforward = [];
    castdata.distdown = [];
    castdata.distup = [];
    castdata.maxcasts = [];
    castdata.maxfails = [];
    castdata.maxents = [];
    castdata.firstforwarddist = [];
    castdata.firstforwardmindist = [];
    castdata.firstforwardmodanglesfunc = [];
    id = 4;
    castdata.distforward[ id ] = undefined;
    castdata.distdown[ id ] = undefined;
    castdata.distup[ id ] = undefined;
    castdata.maxcasts[ id ] = undefined;
    castdata.maxfails[ id ] = undefined;
    castdata.maxents[ id ] = 1;
    id = 8;
    castdata.distforward[ id ] = 50;
    castdata.distdown[ id ] = 50;
    castdata.distup[ id ] = 25;
    castdata.maxcasts[ id ] = 4;
    castdata.maxfails[ id ] = 3;
    castdata.maxents[ id ] = 1;
    castdata.distforwardwall[ id ] = 25;
    id = 16;
    castdata.distforward[ id ] = 15;
    castdata.distdown[ id ] = 50;
    castdata.distup[ id ] = 25;
    castdata.maxcasts[ id ] = 17;
    castdata.maxfails[ id ] = 3;
    castdata.maxents[ id ] = 3;
    castdata.firstforwarddist[ id ] = 85;
    castdata.firstforwardmindist[ id ] = 8;
    castdata.distforwardwall[ id ] = 8;
    castdata.firstforwarddistwall[ id ] = 44;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x974
// Size: 0x151
function molotov_init_pool_data()
{
    leveldata = molotov_get_level_data();
    pooldata = leveldata.pooldata;
    
    if ( !isdefined( pooldata ) )
    {
        pooldata = spawnstruct();
        leveldata.pooldata = pooldata;
    }
    
    pooldata.triggerradius = [];
    pooldata.triggerheight = [];
    pooldata.triggeroffset = [];
    pooldata.startdelayms = [];
    id = 4;
    pooldata.triggerradius[ id ] = 30;
    pooldata.triggerheight[ id ] = 55;
    pooldata.triggeroffset[ id ] = 15;
    pooldata.startdelayms[ id ] = 0;
    id = 8;
    pooldata.triggerradius[ id ] = 30;
    pooldata.triggerheight[ id ] = 55;
    pooldata.triggeroffset[ id ] = 15;
    pooldata.startdelayms[ id ] = 100;
    id = 16;
    pooldata.triggerradius[ id ] = 10;
    pooldata.triggerheight[ id ] = 55;
    pooldata.triggeroffset[ id ] = 15;
    pooldata.startdelayms[ id ] = 100;
    molotov_init_pool_mask();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0xacd
// Size: 0x18f
function molotov_init_pool_mask()
{
    var_dcf9401f976e906f = molotov_get_pool_level_data();
    var_6f6efec7e89387e8 = [];
    var_6f6efec7e89387e8[ 4 ] = "coreCenter";
    var_6f6efec7e89387e8[ 8 ] = "core";
    var_6f6efec7e89387e8[ 16 ] = "tendril";
    var_6f6efec7e89387e8[ 1 ] = "";
    var_6f6efec7e89387e8[ 2 ] = "DieDown";
    var_6f6efec7e89387e8[ 32 ] = "";
    var_6f6efec7e89387e8[ 64 ] = "Wall";
    var_6f6efec7e89387e8[ 128 ] = "Ceil";
    scriptablestates = [];
    var_e42c4a59211c25aa = ( 1 | 2 ) ^ ( 1 | 2 ) & ( 1 | 2 ) - 1;
    var_a56ffa08fd7c6e21 = ( 4 | 8 | 16 ) ^ ( 4 | 8 | 16 ) & ( 4 | 8 | 16 ) - 1;
    var_880b6bd9b71c4abc = ( 32 | 64 | 128 ) ^ ( 32 | 64 | 128 ) & ( 32 | 64 | 128 ) - 1;
    statebit = var_e42c4a59211c25aa;
    
    while ( ( statebit & ( 1 | 2 ) ) > 0 )
    {
        typebit = var_a56ffa08fd7c6e21;
        
        while ( ( typebit & ( 4 | 8 | 16 ) ) > 0 )
        {
            orientbit = var_880b6bd9b71c4abc;
            
            while ( ( orientbit & ( 32 | 64 | 128 ) ) > 0 )
            {
                mask = statebit | typebit | orientbit;
                scriptablestates[ mask ] = var_6f6efec7e89387e8[ typebit ] + var_6f6efec7e89387e8[ statebit ] + var_6f6efec7e89387e8[ orientbit ];
                mask = typebit | orientbit;
                scriptablestates[ mask ] = "neutral";
                orientbit <<= 1;
            }
            
            typebit <<= 1;
        }
        
        statebit <<= 1;
    }
    
    var_dcf9401f976e906f.scriptablestates = scriptablestates;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0xc64
// Size: 0x1b
function molotov_on_give( equipmentref, slot )
{
    thread molotov_watch_fx();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0xc87
// Size: 0x1b
function molotov_on_take( equipmentref, slot )
{
    self notify( "molotov_taken" );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0xcaa
// Size: 0x145
function molotov_used( grenade )
{
    grenade endon( "death" );
    launchangles = self getgunangles();
    launchtimems = gettime();
    launchvelocity = anglestoforward( launchangles ) * 940 + anglestoup( launchangles ) * 120;
    
    if ( isdefined( self.offhands ) )
    {
        self.offhands.lastusedoffhandtime = 0;
    }
    
    thread molotov_cleanup_grenade( grenade );
    grenade_owner_name = self.name;
    grenade waittill( "missile_stuck", stuckto );
    level notify( "grenade_exploded_during_stealth", grenade, "molotov_mp", grenade_owner_name );
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, -800 * traveltime );
    
    if ( isplayer( self ) )
    {
        self.achievement_id = generate_achievementid();
        thread watch_for_ashes_achievement( self.achievement_id );
    }
    
    if ( isdefined( stuckto ) && ( isplayer( stuckto ) || isagent( stuckto ) ) )
    {
        thread molotov_stuck_player( grenade, stuckto, launchangles, impactvelocity );
        return;
    }
    
    thread molotov_stuck( grenade, stuckto, launchangles, impactvelocity );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0xdf7
// Size: 0x13a
function ai_molotov_used( guy, grenade )
{
    launchtimems = gettime();
    selforigin = guy.origin;
    var_e02ff3e74216854b = guy.angles;
    grenade waittill( "missile_stuck", stuckto, hitentpart, surfacetype, velocity, position, hitnormal );
    launchangles = getlaunchangles( selforigin, var_e02ff3e74216854b, position );
    launchvelocity = velocity;
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, -800 * traveltime );
    
    if ( isdefined( guy ) )
    {
        grenade.owner = guy;
    }
    
    if ( isdefined( stuckto ) && ( isplayer( stuckto ) || isagent( stuckto ) ) )
    {
        level thread molotov_stuck_player( grenade, stuckto, launchangles, impactvelocity );
        return;
    }
    
    level thread molotov_stuck( grenade, stuckto, launchangles, impactvelocity );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 3
// Checksum 0x0, Offset: 0xf39
// Size: 0x6d
function getlaunchangles( startorigin, startangles, origin )
{
    dirtomolotov = vectornormalize( origin - startorigin );
    ang = vectortoangles( dirtomolotov );
    flatang = ( 0, startangles[ 1 ], 0 );
    launchangles = flatang + ( 45, 0, 0 );
    return launchangles;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0xfaf
// Size: 0x8
function generate_achievementid()
{
    return scripts\cp\utility\player::getuniqueid();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0xfc0
// Size: 0x97
function watch_for_ashes_achievement( achievement_id )
{
    self notify( "watch_for_ashes_achievement" );
    self endon( "watch_for_ashes_achievement" );
    self endon( "kill_instance_of_molotov" + achievement_id );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.moloachievementvictims = 0;
    
    if ( istrue( self.given_achievement ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( self.moloachievementvictims > 3 )
        {
            self giveachievement( "ashes" );
            
            /#
                self iprintln( "<dev string:x1c>" + "<dev string:x2a>" );
            #/
            
            self.given_achievement = 1;
            self notify( "kill_instance_of_molotov" + achievement_id );
        }
        
        waitframe();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 5
// Checksum 0x0, Offset: 0x105f
// Size: 0x102
function molotov_stuck( grenade, stuckto, launchangles, impactvelocity, showtrail )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( grenade.angles );
    right = anglestoright( launchangles );
    
    if ( abs( vectordot( forward, up ) ) >= 0.9848 )
    {
        angles = molotov_rebuild_angles_up_right( up, right );
    }
    else
    {
        angles = molotov_rebuild_angles_up_forward( up, forward );
    }
    
    grenade.angles = angles;
    grenade notify( "death" );
    grenade.exploding = 1;
    grenade setscriptablepartstate( "effects", "explode", 0 );
    
    if ( !isdefined( showtrail ) )
    {
        grenade missilehidetrail();
    }
    
    molotov_simulate_impact( grenade, grenade.origin, angles, stuckto, impactvelocity, gettime() );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 4
// Checksum 0x0, Offset: 0x1169
// Size: 0x26c
function molotov_stuck_player( grenade, stuckto, launchangles, impactvelocity )
{
    scripts\cp\weapon::grenadestuckto( grenade, stuckto );
    var_15a0bb7c31da4de7 = 1;
    
    if ( isagent( stuckto ) && istrue( stuckto.bhasriotshieldattached ) )
    {
        dir2d = -1 * vectornormalize( ( impactvelocity[ 0 ], impactvelocity[ 1 ], 0 ) );
        var_6efb278383b40e37 = -1 * vectornormalize( impactvelocity );
        
        if ( vectordot( anglestoforward( stuckto.angles ), dir2d ) > 0.5 && -0.5 < var_6efb278383b40e37[ 2 ] && var_6efb278383b40e37[ 2 ] < 0.5 )
        {
            var_15a0bb7c31da4de7 = 0;
        }
    }
    
    if ( var_15a0bb7c31da4de7 )
    {
        stuckto thread molotov_burn_for_time( 6, self, grenade, grenade );
    }
    
    grenade.exploding = 1;
    grenade setscriptablepartstate( "effects", "explode", 0 );
    grenade missilehidetrail();
    impactvelocity *= ( 0, 0, 1 );
    caststart = grenade.origin;
    castdir = ( 0, 0, -1 );
    castend = caststart + castdir * 128;
    contents = molotov_get_cast_contents();
    castresults = physics_raycast( caststart, castend, contents, grenade, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ];
        casthitnorm = castresults[ 0 ][ "normal" ];
        casthitent = castresults[ 0 ][ "entity" ];
        castend -= casthitnorm * 1;
        d = vectordot( castend - caststart, castdir );
        t = sqrt( 2 * d / -1 * -800 );
        up = casthitnorm;
        right = anglestoright( launchangles );
        impactangles = molotov_rebuild_angles_up_right( up, right );
        thread molotov_simulate_impact( grenade, castend, impactangles, casthitent, impactvelocity, gettime() + t * 1000 );
        return;
    }
    
    grenade notify( "death" );
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x13dd
// Size: 0x37
function molotovbadplace( impactorigin )
{
    badplace = createnavbadplacebybounds( impactorigin, ( 128, 128, 100 ), ( 0, 0, 0 ) );
    return badplace;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 6
// Checksum 0x0, Offset: 0x141d
// Size: 0x5fb
function molotov_simulate_impact( grenade, impactorigin, impactangles, impactent, impactvelocity, impacttime )
{
    owner = grenade.owner;
    var_a53fbeeb744eae5c = ter_op( level.players.size > 15, 10, 20 );
    impactnormal = anglestoup( impactangles );
    caststart = impactorigin + impactnormal * 1;
    castend = caststart + impactnormal * 25;
    contents = molotov_get_cast_contents();
    castresults = physics_raycast( caststart, castend, contents, grenade, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ] - impactnormal * 1;
    }
    
    borigin = castend;
    burnsource = grenade;
    burnsource thread molotov_cleanup_burn_source();
    burnid = molotov_get_next_burning_id();
    coneimpact = 0;
    impactdot = vectordot( vectornormalize( impactvelocity ), -1 * impactnormal );
    
    if ( impactdot < 0.96593 )
    {
        coneimpact = 1;
    }
    
    shareddata = molotov_create_shared_data( owner, impacttime, burnsource, burnid );
    shareddata.badplace = molotovbadplace( impactorigin );
    shareddata thread molotov_cleanup();
    id = 4;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, impactorigin, impactangles, impactent );
    shareddata.branches[ shareddata.branches.size ] = branch;
    var_6f2b46872df538de = 25;
    var_df64badccf60fd69 = 65;
    var_144e6d19329167bd = 115;
    sidepreventstarttime = gettime() + pooldata.startdelayms;
    id = 8;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_forward_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, impactangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    forward = anglestoforward( impactangles );
    right = anglestoright( impactangles );
    up = anglestoup( impactangles );
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = forward * -1;
    bright = right * -1;
    bup = up;
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, var_df64badccf60fd69 );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_right_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_df64badccf60fd69 );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_left_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, var_144e6d19329167bd );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_144e6d19329167bd );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    molotov_register_cast( shareddata );
    
    foreach ( branch in shareddata.branches )
    {
        branch thread molotov_start_branch();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x1a20
// Size: 0xba
function molotov_cleanup()
{
    self.burnsource waittill_notify_or_timeout( "entitydeleted", 6.75 );
    
    while ( true )
    {
        branchesterminated = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !istrue( branch.iscomplete ) )
            {
                branchesterminated = 0;
                break;
            }
            
            if ( !branchesterminated )
            {
                break;
            }
        }
        
        if ( branchesterminated )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 4
// Checksum 0x0, Offset: 0x1ae2
// Size: 0x110
function molotov_create_shared_data( owner, impacttime, burnsource, burnid )
{
    shareddata = spawnstruct();
    shareddata.owner = owner;
    shareddata.team = owner.team;
    shareddata.impacttime = impacttime;
    shareddata.burnsource = burnsource;
    shareddata.burnid = burnid;
    shareddata.branches = [];
    shareddata.scriptablecount = 0;
    shareddata.caststotal = 0;
    shareddata.caststhisframe = 0;
    shareddata.frametimestamp = gettime();
    shareddata.castcontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
    burnsource.shareddata = shareddata;
    return shareddata;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x1bfb
// Size: 0x51
function molotov_register_cast( shareddata )
{
    shareddata.caststotal++;
    shareddata.caststhisframe++;
    shareddata.frametimestamp = gettime();
    leveldata = molotov_get_level_data();
    leveldata.caststhisframe++;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x1c54
// Size: 0x79
function molotov_register_scriptable( shareddata )
{
    assertex( isdefined( self.id ), "pool.ID must be set to a unique id before it is registered.  See molotov_get_unique_pool_id()." );
    shareddata.scriptablecount++;
    leveldata = molotov_get_level_data();
    leveldata.scriptables[ self.id ] = self;
    
    if ( leveldata.scriptables.size > leveldata.maxpools )
    {
        molotov_delete_oldest_scriptable();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x1cd5
// Size: 0x55
function molotov_register_trigger( trigger )
{
    leveldata = molotov_get_level_data();
    leveldata.triggers[ self.id ] = self;
    
    if ( leveldata.triggers.size > leveldata.maxpools )
    {
        molotov_delete_oldest_trigger();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x1d32
// Size: 0x82
function molotov_delete_scriptable()
{
    leveldata = molotov_get_level_data();
    leveldata.scriptables[ self.id ] = undefined;
    trigger = leveldata.triggers[ self.id ];
    
    if ( !isdefined( trigger ) )
    {
        leveldata.poolids = array_remove( leveldata.poolids, self.id );
    }
    
    self notify( "death" );
    self freescriptable();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x1dbc
// Size: 0x7a
function molotov_delete_trigger()
{
    leveldata = molotov_get_level_data();
    leveldata.triggers[ self.id ] = undefined;
    scriptable = leveldata.scriptables[ self.id ];
    
    if ( !isdefined( scriptable ) )
    {
        leveldata.poolids = array_remove( leveldata.poolids, self.id );
    }
    
    self delete();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x1e3e
// Size: 0xae
function molotov_delete_oldest_scriptable( immediate )
{
    leveldata = molotov_get_level_data();
    scriptable = undefined;
    id = undefined;
    
    foreach ( id in leveldata.poolids )
    {
        scriptable = leveldata.scriptables[ id ];
        
        if ( isdefined( scriptable ) )
        {
            break;
        }
    }
    
    immediate = istrue( immediate ) || leveldata.immediatecleanup;
    
    if ( !isdefined( scriptable ) )
    {
        molotov_delete_pool_by_id( id, immediate );
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x1ef4
// Size: 0xae
function molotov_delete_oldest_trigger( immediate )
{
    leveldata = molotov_get_level_data();
    trigger = undefined;
    id = undefined;
    
    foreach ( id in leveldata.poolids )
    {
        trigger = leveldata.triggers[ id ];
        
        if ( isdefined( trigger ) )
        {
            break;
        }
    }
    
    immediate = istrue( immediate ) || leveldata.immediatecleanup;
    
    if ( isdefined( trigger ) )
    {
        molotov_delete_pool_by_id( id, immediate );
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0x1faa
// Size: 0xb7
function molotov_delete_pool_by_id( id, immediate )
{
    leveldata = molotov_get_level_data();
    scriptable = leveldata.scriptables[ id ];
    
    if ( isdefined( scriptable ) )
    {
        if ( !istrue( immediate ) )
        {
            leveldata.scriptables[ id ] = undefined;
            leveldata.triggers[ id ] = undefined;
            leveldata.poolids = array_remove( leveldata.poolids, id );
            scriptable thread molotov_pool_end();
            return;
        }
        
        scriptable thread molotov_delete_scriptable();
    }
    
    trigger = leveldata.triggers[ id ];
    
    if ( isdefined( trigger ) )
    {
        trigger thread molotov_delete_trigger();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x2069
// Size: 0xb1, Type: bool
function molotov_can_cast_this_frame( shareddata )
{
    if ( shareddata.frametimestamp < gettime() )
    {
        shareddata.frametimestamp = gettime();
        shareddata.caststhisframe = 0;
    }
    
    if ( shareddata.caststhisframe >= 3 )
    {
        return false;
    }
    
    leveldata = molotov_get_level_data();
    
    if ( leveldata.frametimestamp < gettime() )
    {
        leveldata.frametimestamp = gettime();
        leveldata.caststhisframe = 0;
    }
    
    if ( leveldata.caststhisframe >= leveldata.maxcastsperframe )
    {
        return false;
    }
    
    return true;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x2123
// Size: 0xf6
function molotov_shared_data_is_complete( var_af8745e2185687a8 )
{
    iscomplete = 0;
    maxcasts = 60;
    maxents = 20;
    
    if ( self.caststotal >= maxcasts )
    {
        iscomplete = 1;
    }
    else if ( self.scriptablecount >= maxents )
    {
        iscomplete = 1;
    }
    else if ( istrue( var_af8745e2185687a8 ) )
    {
        var_3ce5d6eb962629fa = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !branch molotov_branch_is_complete( 1, 1 ) )
            {
                var_3ce5d6eb962629fa = 0;
                break;
            }
        }
        
        if ( var_3ce5d6eb962629fa )
        {
            iscomplete = 1;
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
        molotov_store_branch_ents();
        self.branches = [];
    }
    
    return iscomplete;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x2222
// Size: 0xf5
function molotov_store_branch_ents()
{
    shareddata = self;
    
    if ( isdefined( self.shareddata ) )
    {
        shareddata = self.shareddata;
    }
    
    if ( !isdefined( shareddata.oldbranchents ) )
    {
        shareddata.oldbranchents = [];
    }
    
    foreach ( branch in self.branches )
    {
        foreach ( ent in branch.ents )
        {
            if ( isdefined( ent ) )
            {
                shareddata.oldbranchents[ shareddata.oldbranchents.size ] = ent;
            }
        }
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 10
// Checksum 0x0, Offset: 0x231f
// Size: 0x12b
function molotov_create_branch( shareddata, castdata, pooldata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc )
{
    branch = spawnstruct();
    branch.shareddata = shareddata;
    branch.castdata = castdata;
    branch.pooldata = pooldata;
    branch.startingorigin = startingorigin;
    branch.startingangles = startingangles;
    branch.startingstuckto = startingstuckto;
    branch.startingcasttype = startingcasttype;
    branch.oncompletedfunc = oncompletedfunc;
    branch.ents = [];
    branch.branches = [];
    branch.hitpositions = [];
    branch.hittypes = [];
    branch.casts = 0;
    branch.castfails = 0;
    branch.preventstarttime = preventstarttime;
    return branch;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x2453
// Size: 0x78e
function molotov_start_branch()
{
    self endon( "cleanup_branch" );
    
    /#
        thread molotov_branch_draw_hits();
    #/
    
    if ( !isdefined( self.preventstarttime ) )
    {
        self.preventstarttime = gettime();
    }
    
    if ( !isdefined( self.startingcasttype ) )
    {
        if ( !self.shareddata molotov_shared_data_is_complete() )
        {
            pool = molotov_branch_create_pool( self.startingorigin, self.startingangles, self.startingstuckto );
            pool = pool thread molotov_pool_start();
            self.iscomplete = 1;
            self.shareddata molotov_shared_data_is_complete( 1 );
            
            /#
                self.hitpositions[ self.hitpositions.size ] = self.startingorigin;
                self.hittypes[ self.hittypes.size ] = 1;
            #/
        }
        
        return;
    }
    
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;
    
    while ( true )
    {
        if ( self.shareddata molotov_shared_data_is_complete() )
        {
            break;
        }
        
        if ( molotov_branch_is_complete( undefined, 1 ) )
        {
            break;
        }
        
        if ( !molotov_can_cast_this_frame( self.shareddata ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.casttype == 0 )
        {
            firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;
            
            if ( isdefined( firstforwardmodanglesfunc ) )
            {
                self.castangles = [[ firstforwardmodanglesfunc ]]( self.castangles );
                self.castdata.firstforwardmodanglesfunc = undefined;
                self.castdata.iswallcast = undefined;
            }
        }
        
        if ( !isdefined( self.iswallcast ) )
        {
            updot = vectordot( anglestoup( self.castangles ), ( 0, 0, 1 ) );
            self.iswallcast = updot > -0.81915 && updot <= 0.5;
            
            if ( isdefined( self.castdata.firstforwarddist ) )
            {
                if ( self.iswallcast && isdefined( self.castdata.firstforwarddistwall ) )
                {
                    self.castdata.firstforwarddist = self.castdata.firstforwarddistwall;
                    self.castdata.firstforwarddistwall = undefined;
                }
                else
                {
                    self.castdata.firstforwarddistwall = undefined;
                }
            }
        }
        
        self.castdir = molotov_get_cast_dir( self.castangles, self.casttype );
        self.castend = self.caststart + self.castdir * molotov_get_cast_dist( self.casttype, self.castdata, self.iswallcast );
        casthit = undefined;
        casthitpos = undefined;
        casthitnorm = undefined;
        casthitent = undefined;
        casthitangles = undefined;
        castresults = physics_raycast( self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( castresults ) && castresults.size > 0 )
        {
            casthit = 1;
            casthitpos = castresults[ 0 ][ "position" ];
            casthitnorm = castresults[ 0 ][ "normal" ];
            casthitent = castresults[ 0 ][ "entity" ];
        }
        
        switch ( self.casttype )
        {
            case 0:
                if ( istrue( casthit ) )
                {
                    molotov_branch_register_cast( self.casttype, 0, casthitpos );
                    shouldcreatepool = 1;
                    
                    if ( isdefined( self.castdata.firstforwarddist ) )
                    {
                        castvec = casthitpos - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.castdata.firstforwarddist -= castdist;
                        
                        if ( self.castdata.firstforwarddist > self.castdata.firstforwardmindist )
                        {
                            shouldcreatepool = 0;
                        }
                        else
                        {
                            self.castdata.firstforwarddist = undefined;
                        }
                    }
                    
                    casthitangles = molotov_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    
                    if ( shouldcreatepool )
                    {
                        ent = molotov_branch_create_pool( casthitpos, casthitangles, casthitent );
                        ent thread molotov_pool_start();
                    }
                    
                    self.casttype = 2;
                    self.caststart = casthitpos + casthitnorm * 1;
                    self.castangles = casthitangles;
                    self.iswallcast = undefined;
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    
                    if ( isdefined( self.castdata.firstforwarddist ) )
                    {
                        castvec = self.castend - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.castdata.firstforwarddist -= castdist;
                        
                        if ( self.castdata.firstforwarddist <= self.castdata.firstforwardmindist )
                        {
                            self.castdata.firstforwarddist = undefined;
                        }
                    }
                    
                    self.casttype = 1;
                    self.caststart = self.castend;
                }
                
                break;
            case 1:
                if ( istrue( casthit ) )
                {
                    casthitangles = molotov_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    ent = molotov_branch_create_pool( casthitpos, casthitangles, casthitent );
                    ent thread molotov_pool_start();
                    normdot = vectordot( anglestoup( self.castangles ), casthitnorm );
                    
                    if ( normdot < 0.9848 )
                    {
                        molotov_branch_register_cast( self.casttype, 2, casthitpos );
                        self.casttype = 2;
                        self.caststart = casthitpos + casthitnorm * 1;
                        self.castangles = casthitangles;
                    }
                    else
                    {
                        molotov_branch_register_cast( self.casttype, 1, casthitpos );
                        self.casttype = 0;
                    }
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    self.caststart = self.castend;
                }
                
                break;
            case 2:
                if ( istrue( casthit ) )
                {
                    molotov_branch_register_cast( self.casttype, 3, casthitpos );
                    self.casttype = 0;
                    self.caststart = casthitpos + casthitnorm * 1;
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    self.casttype = 0;
                }
                
                break;
        }
        
        waittillframeend();
    }
    
    self.iscomplete = 1;
    self.shareddata molotov_shared_data_is_complete( 1 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0x2be9
// Size: 0x273
function molotov_branch_is_complete( var_af8745e2185687a8, var_f7d3f0b0605b5824 )
{
    iscomplete = 0;
    var_3ce5d6eb962629fa = undefined;
    
    if ( !istrue( var_f7d3f0b0605b5824 ) )
    {
        iscomplete = self.shareddata molotov_shared_data_is_complete();
    }
    
    if ( !iscomplete )
    {
        if ( isdefined( self.castdata ) && isdefined( self.castdata.maxfails ) && self.castfails >= self.castdata.maxfails )
        {
            iscomplete = 1;
        }
        else if ( isdefined( self.castdata ) && isdefined( self.castdata.maxcasts ) && self.casts >= self.castdata.maxcasts )
        {
            iscomplete = 1;
        }
        else if ( isdefined( self.castdata ) && isdefined( self.castdata.maxents ) && self.ents.size >= self.castdata.maxents )
        {
            iscomplete = 1;
        }
        else if ( istrue( var_af8745e2185687a8 ) && self.branches.size > 0 )
        {
            var_3ce5d6eb962629fa = 1;
            
            foreach ( branch in self.branches )
            {
                if ( !branch molotov_branch_is_complete( var_af8745e2185687a8, var_f7d3f0b0605b5824 ) )
                {
                    var_3ce5d6eb962629fa = 0;
                    break;
                }
            }
            
            if ( var_3ce5d6eb962629fa )
            {
                iscomplete = 1;
            }
        }
    }
    
    if ( iscomplete && !istrue( self.iscomplete ) )
    {
        oncompletedfunc = self.oncompletedfunc;
        self.oncompletedfunc = undefined;
        
        if ( isdefined( oncompletedfunc ) )
        {
            self [[ oncompletedfunc ]]();
        }
        
        if ( istrue( var_3ce5d6eb962629fa ) )
        {
            iscomplete = 0;
            
            foreach ( branch in self.branches )
            {
                if ( !branch molotov_branch_is_complete( 1, var_f7d3f0b0605b5824 ) )
                {
                    var_3ce5d6eb962629fa = 0;
                    break;
                }
            }
            
            if ( var_3ce5d6eb962629fa )
            {
                iscomplete = 1;
            }
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
        molotov_store_branch_ents();
        self.branches = [];
    }
    
    return iscomplete;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 3
// Checksum 0x0, Offset: 0x2e65
// Size: 0x179
function molotov_branch_register_cast( casttype, casthittype, hitposition )
{
    molotov_register_cast( self.shareddata );
    self.casts++;
    
    if ( isdefined( casthittype ) )
    {
        if ( casthittype == 0 || casthittype == 1 || casthittype == 2 )
        {
            self.castfails = 0;
        }
    }
    else if ( casttype == 1 )
    {
        self.castfails++;
    }
    
    /#
        debugmsg = undefined;
        
        if ( isdefined( casthittype ) )
        {
            debugmsg = undefined;
            
            switch ( casthittype )
            {
                case 0:
                    debugmsg = "<dev string:x30>";
                    break;
                case 1:
                    debugmsg = "<dev string:x3c>";
                    break;
                case 2:
                    debugmsg = "<dev string:x45>";
                    break;
                case 3:
                    debugmsg = "<dev string:x55>";
                    break;
            }
            
            self.hitpositions[ self.hitpositions.size ] = hitposition;
            self.hittypes[ self.hittypes.size ] = casthittype;
        }
        else
        {
            switch ( casttype )
            {
                case 0:
                    debugmsg = "<dev string:x5c>";
                    break;
                case 1:
                    debugmsg = "<dev string:x64>";
                    break;
                case 2:
                    debugmsg = "<dev string:x6e>";
                    break;
            }
        }
        
        if ( istrue( level.var_4482770c326f1498 ) )
        {
            if ( isdefined( debugmsg ) )
            {
                println( debugmsg );
            }
        }
    #/
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 10
// Checksum 0x0, Offset: 0x2fe6
// Size: 0x137
function molotov_create_pool( origin, angles, stuckto, owner, burnsource, burnid, starttime, pooldata, poolmask, id )
{
    scriptable = spawnscriptable( "equip_molotov_pool_mp_p", origin, angles );
    scriptable.stuckto = stuckto;
    scriptable.owner = owner;
    scriptable.burnsource = burnsource;
    scriptable.burnid = burnid;
    scriptable.starttime = starttime;
    scriptable.pooldata = pooldata;
    scriptable.poolmask = poolmask;
    scriptable.id = id;
    
    if ( isdefined( stuckto ) )
    {
        offset = rotatevectorinverted( origin - stuckto.origin, stuckto.angles );
        angleoffset = combineangles( invertangles( stuckto.angles ), angles );
        scriptable utility::scriptable_setparententity( stuckto, offset, angleoffset );
    }
    
    return scriptable;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 3
// Checksum 0x0, Offset: 0x3126
// Size: 0x15b
function molotov_branch_create_pool( origin, angles, stuckto )
{
    poolmask = self.pooldata.typeid;
    up = anglestoup( angles );
    dot = vectordot( up, ( 0, 0, 1 ) );
    
    if ( dot <= -0.81915 )
    {
        poolmask |= 128;
    }
    else if ( dot <= 0.5 )
    {
        poolmask |= 64;
    }
    else
    {
        poolmask |= 32;
    }
    
    starttime = self.preventstarttime + self.pooldata.startdelayms;
    scriptable = molotov_create_pool( origin, angles, stuckto, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, starttime, self.pooldata, poolmask );
    self.preventstarttime = starttime;
    self.ents[ self.ents.size ] = scriptable;
    scriptable.id = molotov_get_unique_pool_id();
    scriptable molotov_register_scriptable( self.shareddata );
    return scriptable;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x328a
// Size: 0x58
function molotov_pool_start()
{
    if ( istrue( self.started ) )
    {
        return;
    }
    
    self.started = 1;
    self endon( "death" );
    self endon( "molotov_pool_end" );
    
    while ( gettime() < self.starttime )
    {
        waitframe();
    }
    
    self.ended = 0;
    molotov_watch_pool();
    thread molotov_pool_end();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x32ea
// Size: 0xc4
function molotov_watch_pool()
{
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    
    if ( isdefined( self.stuckto ) )
    {
        self.stuckto endon( "death" );
    }
    
    self notify( "molotov_pool_watch" );
    self.trigger = molotov_create_pool_trigger( self.pooldata.triggerradius, self.pooldata.triggerheight, self.pooldata.triggeroffset );
    self.poolmask |= 1;
    molotov_pool_update_scriptable();
    burnloopduration = randomfloatrange( 6.5, 6.75 );
    wait burnloopduration;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x33b6
// Size: 0x8b
function molotov_pool_end()
{
    self endon( "death" );
    
    if ( istrue( self.ended ) )
    {
        return;
    }
    
    self notify( "molotov_pool_end" );
    self.ended = 1;
    self.poolmask &= ~1;
    self.poolmask |= 2;
    molotov_pool_update_scriptable();
    wait 1;
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread molotov_delete_trigger();
    }
    
    wait 3.5;
    thread molotov_delete_scriptable();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3449
// Size: 0x18
function molotov_watch_cleanup_pool()
{
    self endon( "death" );
    molotov_watch_cleanup_pool_internal();
    thread molotov_delete_scriptable();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3469
// Size: 0x44
function molotov_watch_cleanup_pool_internal()
{
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    
    if ( isdefined( self.stuckto ) )
    {
        self.stuckto endon( "death" );
    }
    
    self waittill( "forever" );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 3
// Checksum 0x0, Offset: 0x34b5
// Size: 0x166
function molotov_create_pool_trigger( triggerradius, triggerheight, triggeroffset )
{
    origin = self.origin - anglestoup( self.angles ) * triggeroffset;
    trigger = spawn( "trigger_rotatable_radius", origin, 0, triggerradius, triggerheight );
    trigger.angles = self.angles;
    trigger.id = self.id;
    
    if ( isdefined( self.stuckto ) )
    {
        trigger enablelinkto();
        trigger linkto( self.stuckto );
    }
    
    trigger hide();
    struct = spawnstruct();
    struct.trigger = trigger;
    struct.attacker = self.owner;
    struct.inflictor = self.burnsource;
    struct.killcament = self.burnsource;
    struct.burnid = self.burnid;
    struct.playersintrigger = [];
    trigger.struct = struct;
    struct thread molotov_watch_pool_trigger_enter();
    struct thread molotov_watch_pool_trigger_exit();
    struct thread molotov_cleanup_pool_trigger();
    trigger thread molotov_trigger_timeout();
    trigger molotov_register_trigger();
    return trigger;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3624
// Size: 0x88
function molotov_trigger_timeout()
{
    self endon( "death" );
    self.struct.attacker endon( "disconnect" );
    self.struct.attacker endon( "joined_team" );
    
    if ( isdefined( self.struct.stuckto ) )
    {
        stuck_to_ent = self.struct.stuckto;
        stuck_to_ent waittill( "death" );
        thread molotov_delete_trigger();
        thread molotov_delete_scriptable();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x36b4
// Size: 0x13d
function molotov_watch_pool_trigger_enter()
{
    if ( isdefined( self.inflictor ) )
    {
        self.inflictor endon( "death" );
    }
    
    self.trigger endon( "death" );
    self.attacker endon( "disconnect" );
    self.attacker endon( "joined_team" );
    
    while ( true )
    {
        self.trigger waittill( "trigger", player );
        
        if ( !isplayer( player ) && !isagent( player ) )
        {
            continue;
        }
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        playerowner = ter_op( isdefined( player.owner ), player.owner, player );
        
        if ( playerowner != self.attacker && !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( playerowner, self.attacker ) ) )
        {
            continue;
        }
        
        entnum = player getentitynumber();
        
        if ( isdefined( self.playersintrigger[ entnum ] ) )
        {
            continue;
        }
        
        self.playersintrigger[ entnum ] = player;
        player molotov_start_burning( self.attacker, self.inflictor, self.killcament, self.burnid );
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x37f9
// Size: 0xa9
function molotov_watch_pool_trigger_exit()
{
    self.trigger endon( "death" );
    
    while ( true )
    {
        foreach ( player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !isreallyalive( player ) )
            {
                continue;
            }
            
            if ( player istouching( self.trigger ) )
            {
                continue;
            }
            
            self.playersintrigger[ id ] = undefined;
            player molotov_stop_burning( self.burnid );
        }
        
        waitframe();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x38aa
// Size: 0x86
function molotov_cleanup_pool_trigger()
{
    molotov_cleanup_pool_trigger_end_early();
    
    foreach ( player in self.playersintrigger )
    {
        if ( isdefined( player ) )
        {
            player molotov_stop_burning( self.burnid );
        }
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread molotov_delete_trigger();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3938
// Size: 0x38
function molotov_cleanup_pool_trigger_end_early()
{
    self.trigger endon( "death" );
    self.attacker endon( "disconnect" );
    self.attacker endon( "joined_team" );
    
    while ( true )
    {
        waitframe();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3978
// Size: 0x41
function molotov_pool_update_scriptable()
{
    var_dcf9401f976e906f = molotov_get_pool_level_data();
    state = var_dcf9401f976e906f.scriptablestates[ self.poolmask ];
    self setscriptablepartstate( "effects", state, 0 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 9
// Checksum 0x0, Offset: 0x39c1
// Size: 0x1d0
function molotov_branch_create_sub_branch( id, starttime, firstforwarddist, firstforwardmindist, firstforwardmodanglesfunc, firstforwarddistwall, maxcasts, maxents, startbranch )
{
    shareddata = self.shareddata;
    castdata = molotov_get_cast_data( id );
    pooldata = molotov_get_pool_data( id );
    
    if ( isdefined( self.castdata ) )
    {
        if ( self.castfails > self.castdata.maxfails )
        {
            return;
        }
        
        if ( self.castfails > castdata.maxfails )
        {
            return;
        }
    }
    
    if ( isdefined( firstforwarddist ) )
    {
        castdata.firstforwarddist = firstforwarddist;
    }
    
    if ( isdefined( firstforwardmindist ) )
    {
        castdata.firstforwardmindist = firstforwardmindist;
    }
    
    if ( isdefined( firstforwardmodanglesfunc ) )
    {
        castdata.firstforwardmodanglesfunc = firstforwardmodanglesfunc;
    }
    
    if ( isdefined( firstforwarddistwall ) )
    {
        castdata.firstforwarddistwall = firstforwarddistwall;
    }
    
    if ( isdefined( maxcasts ) )
    {
        castdata.maxcasts = maxcasts;
    }
    
    if ( isdefined( maxents ) )
    {
        castdata.maxents = maxents;
    }
    
    branch = molotov_create_branch( shareddata, castdata, pooldata, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime );
    branch.castfails = self.castfails;
    self.branches[ self.branches.size ] = branch;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    if ( istrue( startbranch ) )
    {
        branch thread molotov_start_branch();
    }
    
    return branch;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3b9a
// Size: 0x29
function molotov_branch_create_forward_tendril_cone()
{
    branch = molotov_branch_create_sub_branch( 16, self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3bcb
// Size: 0x2d
function molotov_branch_create_left_tendril_cone()
{
    branch = molotov_branch_create_sub_branch( 16, self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3c00
// Size: 0x2d
function molotov_branch_create_right_tendril_cone()
{
    branch = molotov_branch_create_sub_branch( 16, self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3c35
// Size: 0x2f
function molotov_branch_create_tendril_radial()
{
    branch = molotov_branch_create_sub_branch( 16, self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0x3c6c
// Size: 0x6a
function molotov_rotate_angles_about_up( angles, amount )
{
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    right = undefined;
    forward = rotatepointaroundvector( up, forward, amount );
    right = vectornormalize( vectorcross( forward, up ) );
    up = vectorcross( right, forward );
    return axistoangles( forward, right, up );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x3cdf
// Size: 0x27
function molotov_left_tendril_mod_angles( angles )
{
    amount = randomfloatrange( 50, 75 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x3d0f
// Size: 0x2a
function molotov_right_tendril_mod_angles( angles )
{
    amount = -1 * randomfloatrange( 50, 75 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x3d42
// Size: 0x27
function molotov_tendril_mod_angles_radial( angles )
{
    amount = randomfloatrange( -60, 60 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3d72
// Size: 0x13
function molotov_cleanup_burn_source()
{
    self endon( "death" );
    wait 20;
    self delete();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x3d8d
// Size: 0x2a
function molotov_cleanup_grenade( grenade )
{
    grenade endon( "death" );
    waittill_any_2( "disconnect", "joined_team" );
    grenade delete();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3dbf
// Size: 0x23
function molotov_get_level_data()
{
    assertex( isdefined( level.molotov ), "molotov_init_pool_data() called before molotov_init()." );
    return level.molotov;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3deb
// Size: 0x3a
function molotov_get_pool_level_data()
{
    leveldata = molotov_get_level_data();
    var_dcf9401f976e906f = leveldata.pooldata;
    assertex( isdefined( var_dcf9401f976e906f ), "molotov_get_pool_level_data() called before molotov_init_pool_data()." );
    return var_dcf9401f976e906f;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3e2e
// Size: 0x3a
function molotov_get_cast_level_data()
{
    leveldata = molotov_get_level_data();
    var_ab59026cfe871548 = leveldata.castdata;
    assertex( isdefined( var_ab59026cfe871548 ), "molotov_get_cast_level_data() called before molotov_init_pool_data()." );
    return var_ab59026cfe871548;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x3e71
// Size: 0x54
function molotov_get_unique_pool_id()
{
    leveldata = molotov_get_level_data();
    uniquepoolid = leveldata.uniquepoolid;
    leveldata.uniquepoolid++;
    leveldata.poolids = array_add( leveldata.poolids, uniquepoolid );
    return uniquepoolid;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x3ece
// Size: 0x162
function molotov_get_cast_data( castid )
{
    var_ab59026cfe871548 = molotov_get_cast_level_data();
    castdata = spawnstruct();
    castdata.distforward = var_ab59026cfe871548.distforward[ castid ];
    castdata.distdown = var_ab59026cfe871548.distdown[ castid ];
    castdata.distup = var_ab59026cfe871548.distup[ castid ];
    castdata.maxcasts = var_ab59026cfe871548.maxcasts[ castid ];
    castdata.maxfails = var_ab59026cfe871548.maxfails[ castid ];
    castdata.maxents = var_ab59026cfe871548.maxents[ castid ];
    castdata.distforwardwall = var_ab59026cfe871548.distforwardwall[ castid ];
    
    if ( isdefined( var_ab59026cfe871548.firstforwarddist[ castid ] ) )
    {
        castdata.firstforwarddist = var_ab59026cfe871548.firstforwarddist[ castid ];
        castdata.firstforwardmindist = var_ab59026cfe871548.firstforwardmindist[ castid ];
        castdata.firstforwardmodanglesfunc = var_ab59026cfe871548.firstforwardmodanglesfunc[ castid ];
        
        if ( isdefined( var_ab59026cfe871548.firstforwarddistwall[ castid ] ) )
        {
            castdata.firstforwarddistwall = var_ab59026cfe871548.firstforwarddistwall[ castid ];
        }
    }
    
    return castdata;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x4039
// Size: 0x9e
function molotov_get_pool_data( typeid )
{
    var_dcf9401f976e906f = molotov_get_pool_level_data();
    pooldata = spawnstruct();
    pooldata.typeid = typeid;
    pooldata.triggerradius = var_dcf9401f976e906f.triggerradius[ typeid ];
    pooldata.triggerheight = var_dcf9401f976e906f.triggerheight[ typeid ];
    pooldata.triggeroffset = var_dcf9401f976e906f.triggeroffset[ typeid ];
    pooldata.startdelayms = var_dcf9401f976e906f.startdelayms[ typeid ];
    return pooldata;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0x40e0
// Size: 0x59
function molotov_get_cast_dir( angles, casttype )
{
    switch ( casttype )
    {
        case 0:
            return anglestoforward( angles );
        case 1:
            return ( -1 * anglestoup( angles ) );
        case 2:
            return anglestoup( angles );
    }
    
    return undefined;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 3
// Checksum 0x0, Offset: 0x4142
// Size: 0xae
function molotov_get_cast_dist( casttype, castdata, iswallcast )
{
    switch ( casttype )
    {
        case 0:
            if ( isdefined( castdata.firstforwarddist ) )
            {
                return castdata.firstforwarddist;
            }
            else if ( iswallcast && isdefined( castdata.distforwardwall ) )
            {
                return castdata.distforwardwall;
            }
            else
            {
                return castdata.distforward;
            }
        case 1:
            return castdata.distdown;
        case 2:
            return castdata.distup;
    }
    
    return undefined;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x41f9
// Size: 0x35
function molotov_get_cast_contents()
{
    return physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0x4237
// Size: 0x3b
function molotov_rebuild_angles_up_right( up, right )
{
    forward = vectornormalize( vectorcross( up, right ) );
    right = vectorcross( forward, up );
    return axistoangles( forward, right, up );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 2
// Checksum 0x0, Offset: 0x427b
// Size: 0x3b
function molotov_rebuild_angles_up_forward( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 4
// Checksum 0x0, Offset: 0x42bf
// Size: 0xaa
function molotov_start_burning( attacker, inflictor, killcament, id )
{
    if ( !isdefined( id ) )
    {
        assertmsg( isdefined( attacker ), "molotov_start_burning() attacker must be defined if ID is not." );
    }
    
    info = molotov_get_burning_info( 1 );
    
    if ( !isdefined( id ) )
    {
        id = molotov_get_next_burning_id();
    }
    
    source = molotov_get_burning_source( attacker, inflictor, killcament, info, id, 1 );
    updateburning = 0;
    
    if ( source.count <= 0 )
    {
        updateburning = 1;
    }
    
    source.count++;
    
    if ( updateburning )
    {
        thread molotov_update_burning();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x4371
// Size: 0x87
function molotov_stop_burning( id )
{
    info = molotov_get_burning_info();
    
    if ( !isdefined( info ) )
    {
        return;
    }
    
    source = molotov_get_burning_source( undefined, undefined, undefined, info, id, 0 );
    
    if ( isdefined( source ) )
    {
        if ( source.count > 0 )
        {
            updateburning = 0;
            
            if ( source.count == 1 )
            {
                updateburning = 1;
            }
            
            source.count--;
            
            if ( updateburning )
            {
                thread molotov_update_burning();
            }
        }
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 4
// Checksum 0x0, Offset: 0x4400
// Size: 0x57
function molotov_burn_for_time( time, attacker, inflictor, killcament )
{
    self endon( "death_or_disconnect" );
    self endon( "clear_burning" );
    id = molotov_get_next_burning_id();
    molotov_start_burning( attacker, inflictor, killcament, id );
    wait time;
    molotov_stop_burning( id );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x445f
// Size: 0x1d
function molotov_clear_burning( immediate )
{
    self notify( "clear_burning" );
    self.burninginfo = undefined;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4484
// Size: 0x488
function molotov_update_burning()
{
    self endon( "death_or_disconnect" );
    self endon( "clear_burning" );
    level endon( "game_ended" );
    self notify( "update_burning" );
    self endon( "update_burning" );
    thread molotov_cleanup_burning();
    info = molotov_get_burning_info();
    
    if ( gettime() <= info.updatetimestamp )
    {
        waitframe();
    }
    
    var_cd07b8d2125ce6bc = 0;
    
    while ( true )
    {
        info = molotov_get_burning_info();
        var_1cc80627b9bdb202 = undefined;
        
        if ( !isplayer( self ) )
        {
            self._blackboard.isburning = undefined;
            self.burningdirection = undefined;
        }
        
        foreach ( source in info.sources )
        {
            if ( source molotov_burning_source_is_valid() )
            {
                if ( !isdefined( var_1cc80627b9bdb202 ) || source.id > var_1cc80627b9bdb202 )
                {
                    var_1cc80627b9bdb202 = source.id;
                }
                
                continue;
            }
            
            info.sources[ source.id ] = undefined;
        }
        
        if ( isdefined( var_1cc80627b9bdb202 ) )
        {
            info.timeoff = 0;
            info.timeon += 0.05;
            source = info.sources[ var_1cc80627b9bdb202 ];
            damage = 15;
            
            if ( info.timeon > 1.5 )
            {
                damage = 30;
            }
            else if ( info.timeon > 0.5 )
            {
                damage = 25;
            }
            
            if ( isagent( self ) )
            {
                if ( !istrue( self.taken_damage_for_molotov_achievement ) )
                {
                    if ( isplayer( source.attacker ) && source.attacker molotovrecentlyused() )
                    {
                        if ( !istrue( source.attacker.given_achievement ) )
                        {
                            source.attacker.moloachievementvictims += 1;
                        }
                        
                        self.taken_damage_for_molotov_achievement = 1;
                    }
                }
            }
            
            damageorigin = source.attacker.origin;
            
            if ( isdefined( source.inflictor ) )
            {
                damageorigin = source.inflictor.origin;
            }
            else
            {
                source.inflictor = undefined;
            }
            
            if ( !isplayer( self ) )
            {
                if ( self.health <= damage )
                {
                    self.burningtodeath = 1;
                }
                else if ( !var_cd07b8d2125ce6bc )
                {
                    self._blackboard.isburning = 1;
                    self.burningtodeath = 0;
                    enemyright = anglestoright( self.angles );
                    var_c669c03ee029ef20 = vectornormalize( damageorigin - self.origin );
                    
                    if ( vectordot( enemyright, var_c669c03ee029ef20 ) > 0 )
                    {
                        self.burningdirection = "right";
                    }
                    else
                    {
                        self.burningdirection = "left";
                    }
                    
                    var_cd07b8d2125ce6bc = 1;
                }
            }
            
            if ( info.timetodamage <= 0 )
            {
                meansofdeath = "MOD_EXPLOSIVE";
                
                if ( isagent( self ) )
                {
                    meansofdeath = "MOD_FIRE";
                }
                
                self dodamage( damage, damageorigin, source.attacker, source.inflictor, meansofdeath, "molotov_mp" );
                info.firstdamagedone = 1;
                info.timetodamage = 0.25;
            }
            else
            {
                meansofdeath = "MOD_EXPLOSIVE";
                
                if ( isagent( self ) )
                {
                    meansofdeath = "MOD_FIRE";
                }
                
                if ( !info.firstdamagedone )
                {
                    self dodamage( damage, damageorigin, source.attacker, source.inflictor, meansofdeath, "molotov_mp" );
                    info.firstdamagedone = 1;
                }
                
                info.timetodamage -= 0.05;
            }
        }
        else
        {
            info.timeoff += 0.05;
            
            if ( info.timeoff >= 2.5 )
            {
                thread molotov_clear_burning();
            }
        }
        
        info.updatetimestamp = gettime();
        wait 0.05;
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4914
// Size: 0x2e
function molotovrecentlyused()
{
    if ( isdefined( self.last_molotov_throw_time ) && gettime() - self.last_molotov_throw_time < 4000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x494a
// Size: 0x27, Type: bool
function molotov_is_burning()
{
    info = molotov_get_burning_info();
    return isdefined( info ) && info.sources.size > 0;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x497a
// Size: 0x9c
function molotov_get_burning_info( create )
{
    info = self.burninginfo;
    
    if ( !isdefined( info ) && istrue( create ) )
    {
        info = spawnstruct();
        info.timeon = 0;
        info.timeoff = 0;
        info.timetodamage = 0.25;
        info.updatetimestamp = 0;
        info.victim = self;
        info.sources = [];
        info.firstdamagedone = 0;
        self.burninginfo = info;
    }
    
    return info;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 6
// Checksum 0x0, Offset: 0x4a1f
// Size: 0xc9
function molotov_get_burning_source( attacker, inflictor, killcament, info, id, shouldcreate )
{
    source = info.sources[ id ];
    
    if ( !isdefined( source ) )
    {
        if ( istrue( shouldcreate ) )
        {
            source = spawnstruct();
            source.attacker = attacker;
            source.inflictor = inflictor;
            source.hasinflictor = isdefined( inflictor );
            source.killcament = killcament;
            source.info = info;
            source.id = id;
            source.count = 0;
            info.sources[ id ] = source;
        }
    }
    
    return source;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4af1
// Size: 0xbf, Type: bool
function molotov_burning_source_is_valid()
{
    if ( !isdefined( self.attacker ) )
    {
        return false;
    }
    
    if ( !isdefined( self.info.victim ) )
    {
        return false;
    }
    
    if ( !isreallyalive( self.info.victim ) )
    {
        return false;
    }
    
    if ( self.attacker != self.info.victim && !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.attacker, self.info.victim ) ) )
    {
        return false;
    }
    
    if ( self.hasinflictor && !isdefined( self.inflictor ) )
    {
        return false;
    }
    
    if ( self.count <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4bb9
// Size: 0x52
function molotov_get_next_burning_id()
{
    leveldata = molotov_get_level_data();
    
    if ( !isdefined( leveldata.burningid ) )
    {
        leveldata.burningid = 0;
    }
    
    id = leveldata.burningid;
    leveldata.burningid++;
    return id;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4c14
// Size: 0x21
function molotov_cleanup_burning()
{
    self notify( "cleanup_burning" );
    self endon( "cleanup_burning" );
    childthread molotov_cleanup_burning_on_death();
    childthread molotov_cleanup_burning_on_game_end();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4c3d
// Size: 0x29
function molotov_cleanup_burning_on_death()
{
    self endon( "disconnect" );
    self endon( "clear_burning" );
    level endon( "game_ended" );
    self waittill( "death" );
    thread molotov_clear_burning( 1 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4c6e
// Size: 0x20
function molotov_cleanup_burning_on_game_end()
{
    self endon( "death_or_disconnect" );
    self endon( "clear_burning" );
    level waittill( "game_ended" );
    thread molotov_clear_burning();
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x4c96
// Size: 0x3c, Type: bool
function molotov_on_player_damaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    data.victim thread scripts\cp\cp_weapons::enableburnfxfortime( 0.5 );
    return true;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4cdb
// Size: 0x8d
function molotov_watch_fx()
{
    self endon( "molotov_clear_fx" );
    self endon( "death_or_disconnect" );
    var_8e784b7cb7322eb = 0;
    
    while ( true )
    {
        var_b818f06c051b78f0 = 0;
        objweapon = self getheldoffhand();
        
        if ( !isnullweapon( objweapon ) && objweapon.basename == "molotov_mp" )
        {
            var_b818f06c051b78f0 = 1;
        }
        
        if ( var_b818f06c051b78f0 && !var_8e784b7cb7322eb )
        {
            thread molotov_begin_fx();
        }
        else if ( var_8e784b7cb7322eb && !var_b818f06c051b78f0 )
        {
            thread molotov_end_fx();
        }
        
        var_8e784b7cb7322eb = var_b818f06c051b78f0;
        waitframe();
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4d70
// Size: 0x63
function molotov_begin_fx()
{
    self endon( "death_or_disconnect" );
    self endon( "molotov_end_fx" );
    self.playingmolotovwickfx = 1;
    self setscriptablepartstate( "equipMtovFXWorld", "neutral", 0 );
    self setscriptablepartstate( "equipMtovFXView", "active", 0 );
    waittime = 0.4;
    wait waittime;
    self setscriptablepartstate( "equipMtovFXWorld", "active", 0 );
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4ddb
// Size: 0x45
function molotov_end_fx()
{
    self notify( "molotov_end_fx" );
    
    if ( istrue( self.playingmolotovwickfx ) )
    {
        self setscriptablepartstate( "equipMtovFXWorld", "neutral", 0 );
        self setscriptablepartstate( "equipMtovFXView", "neutral", 0 );
    }
    
    self.playingmolotovwickfx = undefined;
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x4e28
// Size: 0x7b
function molotov_cleanup_branch( branch )
{
    branch notify( "cleanup_branch" );
    
    if ( isdefined( branch.ents ) )
    {
        foreach ( scriptable in branch.ents )
        {
            if ( isdefined( scriptable ) )
            {
                scriptable thread molotov_pool_end();
            }
        }
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 1
// Checksum 0x0, Offset: 0x4eab
// Size: 0x10c
function molotov_cleanup_pool( grenade )
{
    if ( isdefined( grenade.shareddata ) )
    {
        if ( isdefined( grenade.shareddata.branches ) )
        {
            foreach ( branch in grenade.shareddata.branches )
            {
                molotov_cleanup_branch( branch );
            }
        }
        
        if ( isdefined( grenade.shareddata.oldbranchents ) )
        {
            foreach ( scriptable in grenade.shareddata.oldbranchents )
            {
                if ( isdefined( scriptable ) )
                {
                    scriptable thread molotov_pool_end();
                }
            }
        }
    }
}

// Namespace coop_molotov / scripts\cp\powers\coop_molotov
// Params 0
// Checksum 0x0, Offset: 0x4fbf
// Size: 0x12
function molotov_clear_fx()
{
    self notify( "molotov_clear_fx" );
    thread molotov_end_fx();
}

/#

    // Namespace coop_molotov / scripts\cp\powers\coop_molotov
    // Params 0
    // Checksum 0x0, Offset: 0x4fd9
    // Size: 0x15e, Type: dev
    function molotov_branch_draw_hits()
    {
        while ( true )
        {
            if ( istrue( self.shareddata.iscomplete ) )
            {
                break;
            }
            
            if ( istrue( self.iscomplete ) )
            {
                break;
            }
            
            if ( istrue( level.dbgmolodrawhits ) )
            {
                ids = getarraykeys( self.hitpositions );
                
                foreach ( id in ids )
                {
                    hitposition = self.hitpositions[ id ];
                    hittype = self.hittypes[ id ];
                    function_5ac76a3e234f3e1a( hitposition, hittype, 0.05 );
                }
            }
            
            wait 0.05;
        }
        
        if ( istrue( level.dbgmolodrawhits ) )
        {
            ids = getarraykeys( self.hitpositions );
            
            foreach ( id in ids )
            {
                hitposition = self.hitpositions[ id ];
                hittype = self.hittypes[ id ];
                function_5ac76a3e234f3e1a( hitposition, hittype, 5 );
            }
        }
    }

    // Namespace coop_molotov / scripts\cp\powers\coop_molotov
    // Params 3
    // Checksum 0x0, Offset: 0x513f
    // Size: 0xb8, Type: dev
    function function_5ac76a3e234f3e1a( hitposition, hittype, duration )
    {
        color = undefined;
        
        switch ( hittype )
        {
            case 0:
                color = ( 1, 1, 0 );
                break;
            case 2:
                color = ( 1, 0, 0 );
                break;
            case 3:
                color = ( 0, 0, 1 );
                break;
            default:
                color = ( 1, 1, 1 );
                break;
        }
        
        thread scripts\cp\utility::drawsphere( hitposition, 2, duration, color );
    }

#/
