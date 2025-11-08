#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\matchrecording;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;

#namespace spawnlogic;

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0xca2
// Size: 0x44b
function init()
{
    level.spawnglobals = spawnstruct();
    
    if ( isanymlgmatch() )
    {
        level.killstreakspawnshielddelayms = 0;
    }
    else
    {
        level.killstreakspawnshielddelayms = 4000;
    }
    
    level.forcebuddyspawn = 0;
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    level.mapcenter = findboxcenter( level.spawnmins, level.spawnmaxs );
    level.numplayerswaitingtospawn = 0;
    level.numplayerswaitingtoenterkillcam = 0;
    level.players = [];
    level.playersbyentitynumber = [];
    level.participants = [];
    level.characters = [];
    level.spawnpointarray = [];
    level.grenades = [];
    level.missiles = [];
    level.carepackages = [];
    level.helis = [];
    level.turrets = [];
    level.tanks = [];
    level.scramblers = [];
    level.ugvs = [];
    level.playerkillstreaks = [];
    level.spawnglobals.lowerlimitfullsights = getdvarfloat( @"hash_ba77e8f37223f218" );
    level.spawnglobals.lowerlimitcornersights = getdvarfloat( @"hash_f055530a90c953bc" );
    level.spawnglobals.lastteamspawnpoints = [];
    level.spawnglobals.lastbadspawntime = [];
    level.spawnglobals.influencenodealloccounts = [];
    level.spawnglobals.spawnsets = [];
    level.spawnglobals.activespawnsets = [];
    level.spawnglobals.spawnsetlists = [];
    level.spawnglobals.spawnpointscriptdata = [];
    
    if ( isdefined( level.gametypebundle.var_466145510d447d04 ) )
    {
        level.spawnglobals.var_466145510d447d04 = getspawnbucketfromstring( level.gametypebundle.var_466145510d447d04 );
    }
    
    level.var_dec2781e0b09018c = getdvarint( hashcat( @"scr_", getgametype(), "_use_safe_fallback_spawns" ), 0 ) == 1;
    level thread spawnpointupdate();
    level thread scripts\cp_mp\utility\game_utility::trackprojectiles();
    level thread trackhostmigrationend();
    level thread trackcarepackages();
    thread printstartupdebugmessages();
    level thread logextraspawninfothink();
    
    /#
        level thread updatedebughud();
    #/
    
    for ( i = 0; i < level.teamnamelist.size ; i++ )
    {
        level.teamspawnpoints[ level.teamnamelist[ i ] ] = [];
        level.teamfallbackspawnpoints[ level.teamnamelist[ i ] ] = [];
    }
    
    scripts\mp\spawnfactor::init_spawn_factors();
    scripts\mp\spawnfactor::function_28565316737536aa();
    level.disablebuddyspawn = !istrue( getmatchrulesdata( "commonOption", "buddySpawnEnabled" ) );
    loadspawnlogicweights();
    lanetriggers = getentarray( "trigger_multiple_mp_spawn_lane", "classname" );
    level.spawnglobals.lanetriggers = lanetriggers;
    
    foreach ( index, lanetrigger in level.spawnglobals.lanetriggers )
    {
        lanetrigger.index = index;
        lanetrigger.indexflag = 1 << index;
    }
    
    ignoretriggers = getentarray( "trigger_multiple_mp_spawn_ignore", "classname" );
    
    foreach ( ignoretrigger in ignoretriggers )
    {
        makeenterexittrigger( ignoretrigger, &ignoretriggerenter, &ignoretriggerexit );
    }
    
    initspawntypes();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 5
// Checksum 0x0, Offset: 0x10f5
// Size: 0x89
function function_e2cbae3344485f14( type, setname, var_474c126f25186d39, var_94ec027babd4d45, type_func )
{
    spawntype = { #setnames:[], #type:type };
    spawntype.setnames[ 0 ] = setname;
    spawntype.setnames[ 1 ] = var_474c126f25186d39;
    spawntype.setnames[ 2 ] = var_94ec027babd4d45;
    spawntype.func = type_func;
    return spawntype;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x1187
// Size: 0xae
function initspawntypes()
{
    level.spawnglobals.spawntypes = [];
    level.spawnglobals.spawntypes[ 0 ] = function_e2cbae3344485f14( 0, "primary", "primary_attackers", "primary_defenders", &function_9328a9c1fc8d2043 );
    level.spawnglobals.spawntypes[ 1 ] = function_e2cbae3344485f14( 1, "start", "start_attackers", "start_defenders", &function_f4882bf77adf2d71 );
    level.spawnglobals.spawntypes[ 2 ] = function_e2cbae3344485f14( 2, "fallback", "fallback_attackers", "fallback_defenders", &function_9328a9c1fc8d2043 );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x123d
// Size: 0xb
function codecallbackhandler_spawnpointprecalc( team )
{
    
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x1250
// Size: 0x159
function codecallbackhandler_spawnpointscore( spawnpoint, team )
{
    spawncontext = level.spawnglobals.activespawncontext;
    assertex( isdefined( spawncontext ), "<dev string:x1c>" );
    globals = level.spawnglobals;
    var_638d9cd5c072165c = 0;
    spawnpoint.scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    assertex( isdefined( spawnpoint.scriptdata ), "<dev string:x85>" );
    
    foreach ( factorref, factorstruct in globals.activescriptfactors )
    {
        factorscore = 0;
        
        if ( isdefined( factorstruct.paramreflist ) )
        {
            /#
                function_d344bbcacf5e4d96( factorref, factorstruct, spawncontext );
            #/
        }
        
        factorscore = [[ factorstruct.func ]]( spawnpoint );
        assert( factorscore >= 0 && factorscore <= 100 );
        var_638d9cd5c072165c += factorscore * factorstruct.weight;
    }
    
    return var_638d9cd5c072165c;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x13b2
// Size: 0x43
function codecallbackhandler_spawnpointcritscore( spawnpoint, team )
{
    /#
        if ( getdvarint( @"hash_88da8d1aa9e42678" ) > 0 )
        {
            return "<dev string:xe3>";
        }
    #/
    
    bucket = scripts\mp\spawnscoring::criticalfactors_callback( spawnpoint );
    return bucket;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 6
// Checksum 0x0, Offset: 0x13fe
// Size: 0x71a
function getspawnpoint( spawningplayer, spawnteam, spawnpointset, fallbackspawnset, var_a22bad5fe6fbf86d, spawnparams )
{
    if ( !isdefined( var_a22bad5fe6fbf86d ) )
    {
        if ( isdefined( level.spawnglobals.var_466145510d447d04 ) )
        {
            var_a22bad5fe6fbf86d = level.spawnglobals.var_466145510d447d04;
        }
        else
        {
            var_a22bad5fe6fbf86d = 3;
        }
    }
    
    /#
        if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
        {
            if ( !isdefined( level.var_952af294bfd228a7 ) )
            {
                level.var_952af294bfd228a7 = [];
            }
        }
    #/
    
    /#
        level.var_53043465614ec8f8 = spawnpointset;
        level.var_b5bad5601a066c66 = fallbackspawnset;
    #/
    
    spawncontext = createspawnquerycontext( spawningplayer, spawnteam, spawnparams );
    setactivespawnquerycontext( spawncontext );
    
    if ( isdefined( spawnpointset ) )
    {
        assertex( getspawnsetsize( spawnpointset ) > 0, "<dev string:xea>" );
        activatespawnset( spawnpointset, 1 );
    }
    
    /#
        if ( scripts\mp\utility\game::getgametype() != "<dev string:x14c>" && scripts\mp\utility\game::getgametype() != "<dev string:x152>" && scripts\mp\utility\game::getgametype() != "<dev string:x15a>" && scripts\mp\utility\game::getgametype() != "<dev string:x166>" && scripts\mp\utility\game::getgametype() != "<dev string:x16e>" )
        {
            scripts\mp\dev::function_847de9fd3b2ff0da( spawnpointset, fallbackspawnset );
        }
    #/
    
    bestspawnpoint = getspawnpointfromcode();
    bestspawnpoint.usingfallback = 0;
    usingfallback = bestspawnpoint.usingfallback;
    var_29aed5db4bb4c839 = bestspawnpoint.threatsight;
    var_c4dc16cc4cc64978 = bestspawnpoint.damagemod;
    
    if ( getdvarint( @"hash_6a75d12a6ac65fb3", 0 ) == 1 || istrue( level.var_e886c825dc0634c0 ) )
    {
        fallbackspawnset = undefined;
    }
    
    if ( isdefined( fallbackspawnset ) && getspawnsetsize( fallbackspawnset ) > 0 && bestspawnpoint.bucket >= 2 )
    {
        activatespawnset( fallbackspawnset, 1 );
        
        /#
            if ( scripts\mp\utility\game::getgametype() != "<dev string:x14c>" && scripts\mp\utility\game::getgametype() != "<dev string:x152>" && scripts\mp\utility\game::getgametype() != "<dev string:x15a>" && scripts\mp\utility\game::getgametype() != "<dev string:x166>" )
            {
                scripts\mp\dev::function_847de9fd3b2ff0da( spawnpointset, fallbackspawnset, 1 );
            }
        #/
        
        var_cdcf9f48fa2d305a = getspawnpointfromcode();
        
        if ( isdefined( var_cdcf9f48fa2d305a ) && ( var_cdcf9f48fa2d305a.bucket < bestspawnpoint.bucket || var_cdcf9f48fa2d305a.totalscore > bestspawnpoint.totalscore ) )
        {
            bestspawnpoint = var_cdcf9f48fa2d305a;
            bestspawnpoint.usingfallback = 1;
            usingfallback = bestspawnpoint.usingfallback;
            var_29aed5db4bb4c839 = bestspawnpoint.threatsight;
            var_c4dc16cc4cc64978 = bestspawnpoint.damagemod;
        }
    }
    
    if ( level.forcebuddyspawn )
    {
        buddyspawnpoint = scripts\mp\spawnscoring::findbuddyspawn();
        
        if ( isdefined( buddyspawnpoint ) )
        {
            /#
                if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
                {
                    if ( !isdefined( level.var_952af294bfd228a7[ "<dev string:x174>" ] ) )
                    {
                        level.var_952af294bfd228a7[ "<dev string:x174>" ] = [];
                    }
                    
                    level.var_952af294bfd228a7[ "<dev string:x174>" ][ level.var_952af294bfd228a7[ "<dev string:x174>" ].size ] = buddyspawnpoint;
                }
            #/
            
            buddyspawnpoint.bucket = 3;
            buddyspawnpoint.usingfallback = usingfallback;
            buddyspawnpoint.threatsight = var_29aed5db4bb4c839;
            buddyspawnpoint.damagemod = var_c4dc16cc4cc64978;
            return buddyspawnpoint;
        }
    }
    
    if ( bestspawnpoint.bucket >= 2 )
    {
        if ( istrue( level.var_dec2781e0b09018c ) && !istrue( spawningplayer.var_5849bdd2ad415eec ) )
        {
            spawningplayer.var_5849bdd2ad415eec = 1;
            previouslogic = level.spawnglobals.activespawnlogic;
            previouscrit = level.spawnglobals.var_ec3926d151bc9b3d;
            safelogic = getdvar( @"hash_c2e2232e83d7f64f", "AwayFromEnemies" );
            safecrit = getdvar( @"hash_f8b577d6d5572673", "Crit_Default" );
            setactivespawnlogic( safelogic, safecrit );
            bestspawnpoint = getspawnpoint( spawningplayer, spawnteam, spawnpointset, fallbackspawnset, var_a22bad5fe6fbf86d, spawnparams );
            setactivespawnlogic( previouslogic, previouscrit );
            spawningplayer.var_5849bdd2ad415eec = undefined;
        }
        
        var_cf9bd39bcb455a12 = getdvarint( @"hash_32e4dc28cdff8ad3", 0 ) != 1;
        
        if ( var_a22bad5fe6fbf86d >= 3 && !var_cf9bd39bcb455a12 )
        {
            buddyspawnpoint = scripts\mp\spawnscoring::findbuddyspawn();
            
            if ( isdefined( buddyspawnpoint ) )
            {
                scripts\mp\spawnscoring::logbadspawn( "Using buddy spawn", spawningplayer );
                
                /#
                    if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
                    {
                        if ( !isdefined( level.var_952af294bfd228a7[ "<dev string:x188>" ] ) )
                        {
                            level.var_952af294bfd228a7[ "<dev string:x188>" ] = [];
                        }
                        
                        level.var_952af294bfd228a7[ "<dev string:x188>" ][ level.var_952af294bfd228a7[ "<dev string:x188>" ].size ] = buddyspawnpoint;
                    }
                #/
                
                buddyspawnpoint.bucket = 3;
                buddyspawnpoint.usingfallback = usingfallback;
                buddyspawnpoint.threatsight = var_29aed5db4bb4c839;
                buddyspawnpoint.damagemod = var_c4dc16cc4cc64978;
                return buddyspawnpoint;
            }
            
            scripts\mp\spawnscoring::logbadspawn( "CANNOT BUDDY SPAWN! Using bad code spawn", spawningplayer );
        }
    }
    
    if ( bestspawnpoint.bucket > 2 && var_a22bad5fe6fbf86d >= 4 )
    {
        if ( isdefined( bestspawnpoint.bucket ) && bestspawnpoint.bucket == 5 )
        {
            bestspawnpoint = undefined;
        }
        
        if ( !isdefined( bestspawnpoint ) )
        {
            spawnpointlist = scripts\mp\spawnlogic::getteamspawnpoints( spawningplayer.team );
            bestspawnpoint = scripts\mp\spawnlogic::getspawnpoint_random( spawnpointlist );
        }
        
        if ( !isdefined( bestspawnpoint ) )
        {
            bestspawnpoint = getrandomspawnpointfromactivesets();
        }
        
        if ( isdefined( bestspawnpoint ) )
        {
            bestspawnpoint.bucket = 4;
        }
    }
    
    if ( bestspawnpoint.bucket > var_a22bad5fe6fbf86d )
    {
        /#
            if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
            {
                if ( !isdefined( level.var_952af294bfd228a7[ "<dev string:x19e>" ] ) )
                {
                    level.var_952af294bfd228a7[ "<dev string:x19e>" ] = 0;
                }
                
                level.var_952af294bfd228a7[ "<dev string:x19e>" ]++;
            }
        #/
        
        return undefined;
    }
    
    /#
        if ( getdvarint( @"hash_f3b498670cb45729", 0 ) != 0 )
        {
            if ( !isdefined( level.var_952af294bfd228a7[ bestspawnpoint.bucket ] ) )
            {
                level.var_952af294bfd228a7[ bestspawnpoint.bucket ] = [];
            }
            
            level.var_952af294bfd228a7[ bestspawnpoint.bucket ][ level.var_952af294bfd228a7[ bestspawnpoint.bucket ].size ] = bestspawnpoint;
        }
    #/
    
    if ( !istrue( level.disablespawncamera ) && !istrue( spawningplayer.skipspawncamera ) && bestspawnpoint.bucket >= 2 && bestspawnpoint.threatsight < 300 )
    {
        spawningplayer.shouldgetnewspawnpoint = 1;
    }
    
    return bestspawnpoint;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x1b21
// Size: 0x9a
function createspawnquerycontext( spawningplayer, team, factorparams )
{
    spawncontext = spawnstruct();
    spawncontext.player = spawningplayer;
    spawncontext.team = team;
    spawncontext.time = gettime();
    spawncontext.factorparams = factorparams;
    
    if ( level.teambased )
    {
        spawncontext.enemyteam = getenemyteams( team )[ 0 ];
    }
    else
    {
        spawncontext.enemyteam = "none";
    }
    
    return spawncontext;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x1bc4
// Size: 0x20
function setactivespawnquerycontext( spawncontext )
{
    level.spawnglobals.activespawncontext = spawncontext;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x1bec
// Size: 0x15
function getactivespawnquerycontext()
{
    return level.spawnglobals.activespawncontext;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x1c0a
// Size: 0x15
function clearactivespawnquerycontext()
{
    level.spawnglobals.activespawncontext = undefined;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x1c27
// Size: 0x19
function trackhostmigrationend()
{
    while ( true )
    {
        self waittill( "host_migration_end" );
        deactivateallspawnsets();
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x1c48
// Size: 0x64
function clearcodefactors()
{
    foreach ( factorref, factorinfo in level.spawnglobals.factors )
    {
        registerspawnfactor( factorref, 0 );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x1cb4
// Size: 0xd3
function registercodefactors( factorweights )
{
    if ( function_bff229a11ecd1e34() )
    {
        foreach ( struct in factorweights )
        {
            registerspawnfactor( struct.factor, struct.weight );
        }
    }
    else
    {
        foreach ( factor, weight in factorweights )
        {
            registerspawnfactor( factor, weight );
        }
    }
    
    registerspawnfactor( "script", 1 );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x1d8f
// Size: 0x60
function function_182c52d5da69684d()
{
    foreach ( factorref, unused in level.spawnglobals.criticalfactors )
    {
        function_1e485a1145b721c5( factorref, 0 );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x1df7
// Size: 0x60
function function_3237e56ca7621667( enabledfactors )
{
    foreach ( factor in enabledfactors )
    {
        function_1e485a1145b721c5( factor.factor );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x1e5f
// Size: 0x39, Type: bool
function isactivespawnlogic( logictype )
{
    if ( !isdefined( level.spawnglobals.activespawnlogic ) )
    {
        return false;
    }
    
    return level.spawnglobals.activespawnlogic == logictype;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x1ea1
// Size: 0x5e2
function setactivespawnlogic( logictype, criticalfactortype, var_7d25b12691ee7cc1 )
{
    if ( !istrue( var_7d25b12691ee7cc1 ) )
    {
        logicoverride = getdvar( hashcat( @"scr_", getgametype(), "_spawnlogic_override" ), "" );
        
        if ( isdefined( logicoverride ) && logicoverride != "" )
        {
            logictype = logicoverride;
        }
        
        critoverride = getdvar( hashcat( @"scr_", getgametype(), "_spawnlogic_crit_override" ), "" );
        
        if ( isdefined( critoverride ) && critoverride != "" )
        {
            criticalfactortype = critoverride;
        }
    }
    
    /#
        newdata = function_bff229a11ecd1e34();
        level.var_e9d31890c07ffffc = "<dev string:x1b9>" + newdata + "<dev string:x1d1>";
        
        if ( newdata )
        {
            foreach ( set in level.spawnglobals.var_8c5be78fb206a3a6 )
            {
                level.var_e9d31890c07ffffc += "<dev string:x1d6>" + getxhashsourcename( set.alias ) + "<dev string:x1dc>" + getxhashsourcename( default_to( set.factorbundle, "<dev string:x1ef>" ) ) + "<dev string:x1fc>" + getxhashsourcename( default_to( set.criticalbundle, "<dev string:x1ef>" ) ) + "<dev string:x214>";
            }
        }
        
        level.var_e9d31890c07ffffc += "<dev string:x21a>" + getxhashsourcename( logictype ) + "<dev string:x232>" + default_to( criticalfactortype, "<dev string:x1ef>" ) + "<dev string:x24c>" + default_to( var_7d25b12691ee7cc1, "<dev string:x1ef>" ) + "<dev string:x214>";
        level.var_e9d31890c07ffffc += "<dev string:x261>" + istrue( level.teambased ) + "<dev string:x1d1>";
        setspawnoverlayscriptsummary( level.var_e9d31890c07ffffc );
    #/
    
    globals = level.spawnglobals;
    globals.logicvariantid = 0;
    globals.activespawnlogic = logictype;
    globals.var_ec3926d151bc9b3d = criticalfactortype;
    globals.activescriptfactors = [];
    
    if ( function_bff229a11ecd1e34() )
    {
        assertex( isdefined( globals.var_4c3494e7bacb24a[ globals.activespawnlogic ] ), "<dev string:x271>" );
        
        foreach ( factor in globals.var_4c3494e7bacb24a[ logictype ].spawnfactors.factors )
        {
            factorref = factor.factor;
            
            if ( scripts\mp\spawnfactor::isfactorregistered( factorref ) && scripts\mp\spawnfactor::isfactorscriptonly( factorref ) )
            {
                factorstruct = spawnstruct();
                factorstruct.func = scripts\mp\spawnfactor::getfactorfunction( factorref );
                factorstruct.paramreflist = scripts\mp\spawnfactor::getfactorparamreflist( factorref );
                factorstruct.weight = factor.weight;
                globals.activescriptfactors[ factorref ] = factorstruct;
            }
        }
    }
    else
    {
        assertex( isdefined( globals.spawnfactorweights[ globals.activespawnlogic ] ), "<dev string:x2da>" + logictype + "<dev string:x313>" );
        
        foreach ( factorref, weight in globals.spawnfactorweights[ logictype ] )
        {
            if ( scripts\mp\spawnfactor::isfactorregistered( factorref ) && scripts\mp\spawnfactor::isfactorscriptonly( factorref ) )
            {
                factorstruct = spawnstruct();
                factorstruct.func = scripts\mp\spawnfactor::getfactorfunction( factorref );
                factorstruct.paramreflist = scripts\mp\spawnfactor::getfactorparamreflist( factorref );
                factorstruct.weight = weight;
                globals.activescriptfactors[ factorref ] = factorstruct;
            }
        }
    }
    
    clearcodefactors();
    
    if ( function_bff229a11ecd1e34() )
    {
        registercodefactors( globals.var_4c3494e7bacb24a[ logictype ].spawnfactors.factors );
    }
    else
    {
        registercodefactors( globals.spawnfactorweights[ logictype ] );
    }
    
    function_182c52d5da69684d();
    
    if ( function_bff229a11ecd1e34() )
    {
        function_3237e56ca7621667( globals.var_4c3494e7bacb24a[ logictype ].criticalfactors.factors );
        
        if ( function_3e631ca44718151f( "respectFrontline" ) )
        {
            frontlineinfo = scripts\mp\spawnfactor::getglobalfrontlineinfo();
            
            if ( isdefined( frontlineinfo ) && isdefined( frontlineinfo.anchordir ) && isdefined( frontlineinfo.primaryanchorpos ) )
            {
                enablefrontlinecriticalfactor( frontlineinfo.anchordir, frontlineinfo.primaryanchorpos );
            }
            else
            {
                enablefrontlinecriticalfactor();
            }
        }
    }
    else
    {
        legacyenableallcriticalfactors();
        
        if ( istrue( globals.criticalfactortypes[ criticalfactortype ][ "frontline" ] ) )
        {
            frontlineinfo = scripts\mp\spawnfactor::getglobalfrontlineinfo();
            
            if ( isdefined( frontlineinfo ) && isdefined( frontlineinfo.anchordir ) && isdefined( frontlineinfo.primaryanchorpos ) )
            {
                enablefrontlinecriticalfactor( frontlineinfo.anchordir, frontlineinfo.primaryanchorpos );
            }
            else
            {
                enablefrontlinecriticalfactor();
            }
        }
    }
    
    if ( level.teambased )
    {
        registerspawnteamsmode( 1 );
        return;
    }
    
    registerspawnteamsmode( 0 );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x248b
// Size: 0x36, Type: bool
function function_84e52176cce3bd6b( spawnkey, overridekey )
{
    if ( !isdefined( overridekey ) )
    {
        return false;
    }
    
    if ( overridekey == "" )
    {
        return false;
    }
    
    if ( isdefined( spawnkey ) && spawnkey == overridekey )
    {
        return false;
    }
    
    return true;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x24ca
// Size: 0x79b
function loadspawnlogicweights()
{
    assertex( !isdefined( level.spawnglobals.spawnfactorweights ), "<dev string:x348>" );
    level.spawnglobals.spawnfactorweights = [];
    level.spawnglobals.criticalfactortypes = [];
    level.spawnglobals.var_4c3494e7bacb24a = [];
    
    /#
        level.spawnglobals.var_8c5be78fb206a3a6 = [];
    #/
    
    if ( function_bff229a11ecd1e34() )
    {
        foreach ( index, set in level.gametypebundle.var_7b4496518c2be4e7 )
        {
            validset = 1;
            
            if ( isdefined( set.alias ) )
            {
                alias = getxhash( set.alias );
            }
            else
            {
                assertmsg( "<dev string:x37c>" + index );
                validset &= 0;
            }
            
            setstruct = spawnstruct();
            
            if ( isdefined( set.factorbundle ) && set.factorbundle != %"" )
            {
                setstruct.spawnfactors = getscriptbundle( set.factorbundle );
            }
            else
            {
                assertmsg( "<dev string:x3b9>" + index );
                validset &= 0;
            }
            
            if ( isdefined( set.criticalbundle ) && set.criticalbundle != %"" )
            {
                setstruct.criticalfactors = getscriptbundle( set.criticalbundle );
            }
            else
            {
                assertmsg( "<dev string:x3f6>" + index );
                validset &= 0;
            }
            
            if ( validset )
            {
                level.spawnglobals.var_4c3494e7bacb24a[ alias ] = setstruct;
                
                /#
                    level.spawnglobals.var_8c5be78fb206a3a6[ alias ] = set;
                #/
            }
        }
        
        if ( isdefined( level.mapbundle ) && isdefined( level.mapbundle.var_f60bfe56c8ed82cc ) && level.mapbundle.var_f60bfe56c8ed82cc.size > 0 )
        {
            foreach ( override in level.mapbundle.var_f60bfe56c8ed82cc )
            {
                if ( function_84e52176cce3bd6b( level.gametypebundle.var_ae4a67201759ddbe, override.gametypefactorkey ) )
                {
                    continue;
                }
                
                assertex( isdefined( override.alias ), "<dev string:x434>" );
                assertex( isdefined( override.factorbundle ), "<dev string:x477>" );
                assertex( isdefined( override.criticalbundle ), "<dev string:x4d6>" );
                alias = getxhash( override.alias );
                
                if ( isdefined( level.spawnglobals.var_4c3494e7bacb24a[ alias ] ) )
                {
                    if ( isdefined( override.factorbundle ) && override.factorbundle != %"" )
                    {
                        level.spawnglobals.var_4c3494e7bacb24a[ alias ].spawnfactors = getscriptbundle( "playerspawnfactorset:" + override.factorbundle );
                    }
                    else
                    {
                        assertmsg( "<dev string:x53d>" + override.alias );
                    }
                    
                    if ( isdefined( override.criticalbundle ) && override.criticalbundle != %"" )
                    {
                        level.spawnglobals.var_4c3494e7bacb24a[ alias ].criticalfactors = getscriptbundle( "playerspawncriticalfactorset:" + override.criticalbundle );
                    }
                    else
                    {
                        assertmsg( "<dev string:x574>" + override.alias );
                    }
                    
                    /#
                        level.spawnglobals.var_8c5be78fb206a3a6[ alias ] = override;
                    #/
                    
                    break;
                }
            }
        }
        
        return;
    }
    
    if ( getdvarint( @"t10", 0 ) > 0 )
    {
        var_10554cc50f831d91 = "mp/spawnweights_t10.csv";
    }
    else
    {
        var_10554cc50f831d91 = "mp/spawnweights.csv";
    }
    
    var_d5c6e7c6d04dd7ee = getdvarint( @"hash_f110558bf1921a5c", 0 );
    
    if ( var_d5c6e7c6d04dd7ee > 0 )
    {
        level.disablebuddyspawn = 1;
        
        switch ( var_d5c6e7c6d04dd7ee )
        {
            case 0:
                break;
            case 1:
                var_10554cc50f831d91 = "mp/spawnweights_jup1";
                break;
            case 2:
                var_10554cc50f831d91 = "mp/spawnweights_jup2";
                break;
            case 3:
                var_10554cc50f831d91 = "mp/spawnweights_jup3";
                break;
            case 4:
                var_10554cc50f831d91 = "mp/spawnweights_jup4";
                break;
            case 5:
                var_10554cc50f831d91 = "mp/spawnweights_jup5";
                break;
            default:
                break;
        }
    }
    
    row = -1;
    
    while ( true )
    {
        row++;
        var_883b09c13233feb = tablelookupbyrow( var_10554cc50f831d91, row, 0 );
        
        if ( !isdefined( var_883b09c13233feb ) || var_883b09c13233feb == "" )
        {
            break;
        }
        
        factor = tablelookupbyrow( var_10554cc50f831d91, row, 2 );
        assertex( isdefined( factor ) && factor != "<dev string:x5ae>", "<dev string:x5b2>" + var_883b09c13233feb + "<dev string:x5e2>" );
        factortype = tablelookupbyrow( var_10554cc50f831d91, row, 1 );
        assertex( isdefined( factortype ) && factortype != "<dev string:x5ae>", "<dev string:x5e7>" + var_883b09c13233feb + "<dev string:x5e2>" );
        assertex( factortype == "<dev string:x61b>" || factortype == "<dev string:x625>", "<dev string:x631>" + factortype + "<dev string:x64a>" + factor + "<dev string:x65c>" + var_883b09c13233feb + "<dev string:x5e2>" );
        
        if ( factortype == "Normal" )
        {
            if ( !isdefined( level.spawnglobals.spawnfactorweights[ var_883b09c13233feb ] ) )
            {
                level.spawnglobals.spawnfactorweights[ var_883b09c13233feb ] = [];
            }
            
            assertex( !isdefined( level.spawnglobals.spawnfactorweights[ var_883b09c13233feb ][ factor ] ), "<dev string:x66b>" + factor + "<dev string:x68c>" + var_883b09c13233feb + "<dev string:x5e2>" );
            weight = tablelookupbyrow( var_10554cc50f831d91, row, 3 );
            assertex( isdefined( weight ) && weight != "<dev string:x5ae>", "<dev string:x6a5>" + var_883b09c13233feb + "<dev string:x5e2>" );
            weight = float( weight );
            level.spawnglobals.spawnfactorweights[ var_883b09c13233feb ][ factor ] = weight;
            continue;
        }
        
        if ( !isdefined( level.spawnglobals.criticalfactortypes[ var_883b09c13233feb ] ) )
        {
            level.spawnglobals.criticalfactortypes[ var_883b09c13233feb ] = [];
        }
        
        assertex( !isdefined( level.spawnglobals.criticalfactortypes[ var_883b09c13233feb ][ factor ] ), "<dev string:x66b>" + factor + "<dev string:x68c>" + var_883b09c13233feb + "<dev string:x5e2>" );
        level.spawnglobals.criticalfactortypes[ var_883b09c13233feb ][ factor ] = 1;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x2c6d
// Size: 0x160
function scorespawnpoint( spawnpoint )
{
    assertex( isdefined( level.spawnglobals.activespawnlogic ), "<dev string:x6d5>" );
    
    if ( function_bff229a11ecd1e34() )
    {
        foreach ( factor, weight in level.spawnglobals.var_4c3494e7bacb24a[ level.spawnglobals.activespawnlogic ].spawnfactors.factors )
        {
            scripts\mp\spawnfactor::calculatefactorscore( spawnpoint, factor, weight );
        }
    }
    else
    {
        foreach ( factor, weight in level.spawnglobals.spawnfactorweights[ level.spawnglobals.activespawnlogic ] )
        {
            scripts\mp\spawnfactor::calculatefactorscore( spawnpoint, factor, weight );
        }
    }
    
    /#
        debugdvar = getdvarint( @"hash_6e7192ebd1ebfe8", -1 );
        
        if ( debugdvar == spawnpoint.index || debugdvar == -2 )
        {
            function_4c2c5ecea9fd1e73( spawnpoint );
        }
    #/
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x2dd5
// Size: 0x7d, Type: bool
function isfactorinuse( factorname )
{
    if ( function_bff229a11ecd1e34() )
    {
        return isdefined( level.spawnglobals.var_4c3494e7bacb24a[ level.spawnglobals.activespawnlogic ].spawnfactors.factors[ factorname ] );
    }
    
    return isdefined( level.spawnglobals.spawnfactorweights[ level.spawnglobals.activespawnlogic ][ factorname ] );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x2e5b
// Size: 0x9d, Type: bool
function function_3e631ca44718151f( factorname )
{
    foreach ( factor in level.spawnglobals.var_4c3494e7bacb24a[ level.spawnglobals.activespawnlogic ].criticalfactors.factors )
    {
        if ( factor.factor == factorname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x2f01
// Size: 0xb
function getstartspawnpoints()
{
    return level.startspawnpoints;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x2f15
// Size: 0x219
function function_386623fc65375fa8( spawnpointents, spawnpointname, allowempty )
{
    spawnpoints = [];
    
    if ( isdefined( level.modifiedspawnpoints ) )
    {
        for ( index = 0; index < spawnpointents.size ; index++ )
        {
            if ( checkmodifiedspawnpoint( spawnpointents[ index ] ) )
            {
                continue;
            }
            
            spawnpoints[ spawnpoints.size ] = spawnpointents[ index ];
        }
    }
    else
    {
        spawnpoints = spawnpointents;
    }
    
    if ( !spawnpoints.size )
    {
        if ( !istrue( allowempty ) )
        {
            assertmsg( "<dev string:x728>" + spawnpointname + "<dev string:x738>" );
        }
        
        return [];
    }
    
    if ( !isdefined( level.startspawnpoints ) )
    {
        level.startspawnpoints = [];
    }
    
    for ( index = 0; index < spawnpoints.size ; index++ )
    {
        spawnpoints[ index ] spawnpointinit();
        spawnpoints[ index ].selected = 0;
        spawnpoints[ index ].infront = 0;
        level.startspawnpoints[ level.startspawnpoints.size ] = spawnpoints[ index ];
    }
    
    if ( level.teambased )
    {
        foreach ( spawnpoint in spawnpoints )
        {
            spawnpoint.infront = 1;
            forwarddir = anglestoforward( spawnpoint.angles );
            
            foreach ( adjacentspawn in spawnpoints )
            {
                if ( spawnpoint == adjacentspawn )
                {
                    continue;
                }
                
                var_a4237dca130ab969 = vectornormalize( adjacentspawn.origin - spawnpoint.origin );
                var_3d7c180940df1bef = vectordot( forwarddir, var_a4237dca130ab969 );
                
                if ( var_3d7c180940df1bef > 0.86 )
                {
                    spawnpoint.infront = 0;
                    break;
                }
            }
        }
    }
    
    return spawnpoints;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x3137
// Size: 0x38
function addstartspawnpoints( spawnpointname, allowempty, team )
{
    spawnpointents = getspawnpointarray( spawnpointname );
    function_386623fc65375fa8( spawnpointents, spawnpointname, allowempty );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 5
// Checksum 0x0, Offset: 0x3177
// Size: 0x93
function function_f4882bf77adf2d71( spawnkey, spawnvalue, team, allowempty, isfallback )
{
    if ( !isdefined( allowempty ) )
    {
        allowempty = 0;
    }
    
    if ( !isdefined( isfallback ) )
    {
        isfallback = 0;
    }
    
    spawnpointents = getspawnpointarray( "mp_spawn_point", spawnkey, spawnvalue );
    arraykey = getspawnpointarraykey( "mp_spawn_point", spawnkey, spawnvalue );
    spawnpoints = function_386623fc65375fa8( spawnpointents, arraykey, allowempty );
    
    if ( spawnpoints.size )
    {
        registerspawnpoints( team, spawnpoints, isfallback );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 4
// Checksum 0x0, Offset: 0x3212
// Size: 0x6f
function addspawnpoints( team, spawnpointname, issetoptional, isfallback )
{
    if ( !isdefined( issetoptional ) )
    {
        issetoptional = 0;
    }
    
    if ( !isdefined( isfallback ) )
    {
        isfallback = 0;
    }
    
    newspawnpoints = getspawnpointarray( spawnpointname );
    
    if ( !newspawnpoints.size )
    {
        assertex( issetoptional, "<dev string:x728>" + spawnpointname + "<dev string:x738>" );
        return;
    }
    
    registerspawnpoints( team, newspawnpoints, isfallback );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 5
// Checksum 0x0, Offset: 0x3289
// Size: 0x89
function function_9328a9c1fc8d2043( spawnkey, spawnvalue, team, issetoptional, isfallback )
{
    if ( !isdefined( issetoptional ) )
    {
        issetoptional = 0;
    }
    
    if ( !isdefined( isfallback ) )
    {
        isfallback = 0;
    }
    
    newspawnpoints = getspawnpointarray( "mp_spawn_point", spawnkey, spawnvalue );
    
    if ( !newspawnpoints.size )
    {
        assertex( issetoptional, "<dev string:x728>" + getspawnpointarraykey( "<dev string:x758>", spawnkey, spawnvalue ) + "<dev string:x738>" );
        return;
    }
    
    registerspawnpoints( team, newspawnpoints, isfallback );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x331a
// Size: 0x132
function registerspawnpoints( team, newspawnpoints, isfallback )
{
    if ( !isdefined( level.spawnpoints ) )
    {
        level.spawnpoints = [];
    }
    
    if ( !isdefined( level.teamspawnpoints[ team ] ) )
    {
        level.teamspawnpoints[ team ] = [];
    }
    
    if ( !isdefined( level.teamfallbackspawnpoints[ team ] ) )
    {
        level.teamfallbackspawnpoints[ team ] = [];
    }
    
    foreach ( spawnpoint in newspawnpoints )
    {
        if ( checkmodifiedspawnpoint( spawnpoint ) )
        {
            continue;
        }
        
        if ( !isdefined( spawnpoint.inited ) )
        {
            spawnpoint spawnpointinit();
            level.spawnpoints[ level.spawnpoints.size ] = spawnpoint;
        }
        
        if ( istrue( isfallback ) )
        {
            level.teamfallbackspawnpoints[ team ][ level.teamfallbackspawnpoints[ team ].size ] = spawnpoint;
            spawnpoint.isfallback = 1;
            continue;
        }
        
        level.teamspawnpoints[ team ][ level.teamspawnpoints[ team ].size ] = spawnpoint;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x3454
// Size: 0x318
function spawnpointinit()
{
    spawnpoint = self;
    spawnpoint.scriptdata = spawnstruct();
    level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ] = spawnpoint.scriptdata;
    level.spawnmins = expandmins( level.spawnmins, spawnpoint.origin );
    level.spawnmaxs = expandmaxs( level.spawnmaxs, spawnpoint.origin );
    spawnpoint.forward = anglestoforward( spawnpoint.angles );
    spawnpoint.sighttracepoint = spawnpoint.origin + ( 0, 0, 50 );
    spawnpoint.lastspawntime = gettime();
    spawnpoint.outside = 1;
    spawnpoint.inited = 1;
    spawnpoint.alternates = [];
    spawnpoint.lastscore = [];
    tracecontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_clipshot" ] );
    hits = physics_raycast( spawnpoint.sighttracepoint, spawnpoint.sighttracepoint + ( 0, 0, 1024 ), tracecontents, [], 0, "physicsquery_any" );
    
    if ( hits > 0 )
    {
        startpoint = spawnpoint.sighttracepoint + spawnpoint.forward * 100;
        hits = physics_raycast( startpoint, spawnpoint.sighttracepoint + ( 0, 0, 1024 ), tracecontents, [], 0, "physicsquery_any" );
        
        if ( hits > 0 )
        {
            spawnpoint.outside = 0;
        }
    }
    
    if ( shoulduseprecomputedlos() || generatinglosdata() )
    {
        spawnpoint.radiuspathnodes = getradiuspathsighttestnodes( spawnpoint.origin );
        
        /#
            if ( spawnpoint.radiuspathnodes.size <= 0 )
            {
                println( "<dev string:x76a>" + spawnpoint.index + "<dev string:x77e>" );
            }
        #/
    }
    
    spawnpoint.lanemask = 0;
    spawnpoint.lanes = [];
    
    foreach ( lanetrigger in level.spawnglobals.lanetriggers )
    {
        if ( ispointinvolume( spawnpoint.origin, lanetrigger ) )
        {
            spawnpoint.lanemask |= lanetrigger.indexflag;
            spawnpoint.lanes[ spawnpoint.lanes.size ] = lanetrigger.index;
        }
    }
    
    initspawnpointvalues( spawnpoint );
    loginitialspawnposition( spawnpoint );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x3774
// Size: 0x47
function getspawnpointarraykey( classname, key, value )
{
    arraykey = classname;
    
    if ( isdefined( key ) && isdefined( value ) )
    {
        arraykey = arraykey + "." + key + "." + value;
    }
    
    return arraykey;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x37c4
// Size: 0x136
function function_32d25b070a9516de( spawnpointlist )
{
    returnarray = [];
    
    if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
    {
        targetnoteworthy = level.localeid;
        
        foreach ( spawnpoint in spawnpointlist )
        {
            if ( checkmodifiedspawnpoint( spawnpoint ) )
            {
                continue;
            }
            
            if ( isdefined( spawnpoint.script_noteworthy ) && spawnpoint.script_noteworthy == targetnoteworthy )
            {
                returnarray[ returnarray.size ] = spawnpoint;
            }
        }
        
        if ( returnarray.size == 0 )
        {
            returnarray = spawnpointlist;
        }
    }
    else
    {
        foreach ( spawnpoint in spawnpointlist )
        {
            if ( checkmodifiedspawnpoint( spawnpoint ) )
            {
                continue;
            }
            
            if ( isdefined( spawnpoint.script_noteworthy ) )
            {
                if ( issubstr( spawnpoint.script_noteworthy, "locale" ) )
                {
                    continue;
                }
            }
            
            returnarray[ returnarray.size ] = spawnpoint;
        }
    }
    
    return returnarray;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x3903
// Size: 0x9f
function getspawnpointarray( classname, key, value )
{
    if ( !isdefined( level.spawnpointarray ) )
    {
        level.spawnpointarray = [];
    }
    
    arraykey = getspawnpointarraykey( classname, key, value );
    
    if ( !isdefined( level.spawnpointarray[ arraykey ] ) )
    {
        var_fc32063c5b6bd8a8 = [];
        
        if ( isdefined( key ) && isdefined( value ) )
        {
            var_fc32063c5b6bd8a8 = getspawnarray( classname, key, value );
        }
        else
        {
            var_fc32063c5b6bd8a8 = getspawnarray( classname );
        }
        
        level.spawnpointarray[ arraykey ] = function_32d25b070a9516de( var_fc32063c5b6bd8a8 );
    }
    
    return level.spawnpointarray[ arraykey ];
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x39ab
// Size: 0x20
function function_5cb7f8468d3b9fe0( key, value )
{
    return getspawnpointarray( "mp_spawn_point", key, value );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x39d4
// Size: 0x134
function getspawnpointfromcode()
{
    spawnpoint = self getspawnpointforplayer();
    
    if ( isdefined( spawnpoint ) )
    {
        spawnpoint.bucket = getspawnbucketfromstring( spawnpoint.score );
        spawnpoint.isbadspawn = spawnpoint.score == "bad";
    }
    else
    {
        spawnpoint = spawnstruct();
        spawnpoint.bucket = 5;
        spawnpoint.isbadspawn = 1;
        assertmsg( "<dev string:x7c7>" );
    }
    
    dlog_recordevent( "mp_spawn_event", [ "score", spawnpoint.score, "threatsight", spawnpoint.threatsight, "totalscore", spawnpoint.totalscore, "spawnx", spawnpoint.origin[ 0 ], "spawny", spawnpoint.origin[ 1 ], "spawnz", spawnpoint.origin[ 2 ] ] );
    logcodefrontlineupdate( spawnpoint );
    return spawnpoint;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x3b11
// Size: 0x49d
function logcodefrontlineupdate( spawnpoint )
{
    if ( istrue( spawnpoint.frontlineenabled ) )
    {
        var_fba864b453265ca0 = spawnpoint.frontlinedir[ 0 ] || spawnpoint.frontlinedir[ 1 ];
        
        if ( var_fba864b453265ca0 )
        {
            if ( !isdefined( level.spawnglobals.var_777600608d5209f8 ) )
            {
                level.spawnglobals.var_777600608d5209f8 = [];
            }
            
            if ( !isdefined( level.spawnglobals.var_fb146560ee2f7575 ) )
            {
                level.spawnglobals.var_fb146560ee2f7575 = [];
            }
            
            frontlinepos = spawnpoint.frontlinepos;
            var_a85f5ef1c2475af4 = isdefined( level.spawnglobals.var_777600608d5209f8[ self.team ] ) ? level.spawnglobals.var_777600608d5209f8[ self.team ] : frontlinepos;
            var_dae11a2ef9681a93 = distance2d( var_a85f5ef1c2475af4, frontlinepos );
            var_ede31d56b862cfb1 = vectortoyaw( spawnpoint.frontlinedir );
            var_2ea3f39300c31505 = isdefined( level.spawnglobals.var_fb146560ee2f7575[ self.team ] ) ? level.spawnglobals.var_fb146560ee2f7575[ self.team ] : var_ede31d56b862cfb1;
            var_7a9b56cf8f7a776e = abs( angleclamp180( var_2ea3f39300c31505 - var_ede31d56b862cfb1 ) );
            
            if ( !isdefined( level.spawnglobals.var_777600608d5209f8[ self.team ] ) || var_dae11a2ef9681a93 > getdvarfloat( @"hash_166c36b572fad7ce", 500 ) || var_7a9b56cf8f7a776e > getdvarfloat( @"hash_587ce4b33cb81345", 90 ) )
            {
                dlog_recordevent( "dlog_event_frontline", [ "team", self.team, "x", frontlinepos[ 0 ], "y", frontlinepos[ 1 ], "yaw", var_ede31d56b862cfb1, "posdiff", var_dae11a2ef9681a93, "yawdiff", var_7a9b56cf8f7a776e ] );
            }
            
            level.spawnglobals.var_777600608d5209f8[ self.team ] = frontlinepos;
            level.spawnglobals.var_fb146560ee2f7575[ self.team ] = var_ede31d56b862cfb1;
        }
        
        var_e42aec1c8b9c49d6 = spawnpoint.origin - spawnpoint.frontlinepos;
        dot = vectordot2( var_e42aec1c8b9c49d6, spawnpoint.frontlinedir, 1 );
        
        if ( dot < 0 )
        {
            dlog_recordevent( "dlog_event_mp_spawn_frontline_offside", [ "team", self.team, "score", spawnpoint.score, "threatsight", spawnpoint.threatsight, "totalscore", spawnpoint.totalscore, "failreason", spawnpoint.damagemod, "spawnx", spawnpoint.origin[ 0 ], "spawny", spawnpoint.origin[ 1 ], "frontlineused", spawnpoint.frontlineused, "frontlinex", spawnpoint.frontlinepos[ 0 ], "frontliney", spawnpoint.frontlinepos[ 1 ], "dot", dot ] );
        }
    }
    
    if ( scripts\mp\matchrecording::matchrecording_isenabled() )
    {
        if ( istrue( spawnpoint.frontlineenabled ) )
        {
            var_86af21ba2c8d7509 = ter_op( self.team == "allies", spawnpoint.frontlineused, 1 );
            var_53360ee7221c1a96 = ter_op( self.team == "axis", spawnpoint.frontlineused, 1 );
            frontlinedir = rotatevector( spawnpoint.frontlinedir, ( 0, 90, 0 ) );
            scripts\mp\spawnfactor::logfrontlinetomatchrecording( spawnpoint.frontlinepos, frontlinedir, var_86af21ba2c8d7509, var_53360ee7221c1a96 );
        }
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x3fb6
// Size: 0xa1
function getspawnpoint_random( spawnpoints )
{
    if ( !isdefined( spawnpoints ) )
    {
        return undefined;
    }
    
    randomspawnpoint = undefined;
    spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns( spawnpoints );
    spawnpoints = array_randomize( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        randomspawnpoint = spawnpoint;
        
        if ( canspawn( randomspawnpoint.origin ) && !positionwouldtelefrag( randomspawnpoint.origin ) )
        {
            break;
        }
    }
    
    return randomspawnpoint;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x4060
// Size: 0xd5
function getspawnpoint_startspawn( spawnpoints, onlyunselected )
{
    if ( !isdefined( spawnpoints ) )
    {
        return undefined;
    }
    
    bestspawn = undefined;
    spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( !isdefined( spawnpoint.selected ) )
        {
            continue;
        }
        
        if ( spawnpoint.selected )
        {
            continue;
        }
        
        if ( spawnpoint.infront )
        {
            bestspawn = spawnpoint;
            break;
        }
        
        bestspawn = spawnpoint;
    }
    
    if ( !isdefined( bestspawn ) )
    {
        if ( istrue( onlyunselected ) )
        {
            return undefined;
        }
        
        bestspawn = getspawnpoint_random( spawnpoints );
    }
    
    if ( isdefined( bestspawn ) )
    {
        bestspawn.selected = 1;
    }
    
    return bestspawn;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x413e
// Size: 0x28
function trackcarepackages()
{
    while ( true )
    {
        level.carepackages = getentarray( "care_package", "targetname" );
        wait 0.05;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x416e
// Size: 0x16
function getteamspawnpoints( team )
{
    return level.teamspawnpoints[ team ];
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x418d
// Size: 0x16
function getteamfallbackspawnpoints( team )
{
    return level.teamfallbackspawnpoints[ team ];
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x41ac
// Size: 0x29
function ispathdataavailable()
{
    if ( !isdefined( level.pathdataavailable ) )
    {
        level.pathdataavailable = getnodecount() > 150;
    }
    
    return level.pathdataavailable;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x41de
// Size: 0x1e1
function spawnpointupdate()
{
    while ( !isdefined( level.spawnpoints ) || level.spawnpoints.size == 0 )
    {
        waitframe();
    }
    
    /#
        setdevdvarifuninitialized( @"hash_3c88de2237eb6f6d", "<dev string:x7ec>" );
    #/
    
    var_e26a5c5b0c618e49 = generatinglosdata();
    
    if ( shoulduseprecomputedlos() || var_e26a5c5b0c618e49 )
    {
        if ( var_e26a5c5b0c618e49 )
        {
            wait 1;
            allentities = getentarray();
            
            foreach ( entity in allentities )
            {
                if ( isdefined( entity.classname ) && entity.classname == "script_brushmodel" && entity.spawnflags & 1 )
                {
                    entity connectpaths();
                }
                
                if ( isdefined( entity.targetname ) && entity.targetname == "dynamic_door" )
                {
                    entity delete();
                }
            }
            
            waitframe();
        }
        
        spawnpointnodes = [];
        
        if ( level.spawnpoints.size == 0 )
        {
            error( "Spawn System Failure. No Spawnpoints found." );
        }
        
        for ( index = 0; index < level.spawnpoints.size ; index++ )
        {
            for ( innerindex = 0; innerindex < level.spawnpoints[ index ].radiuspathnodes.size ; innerindex++ )
            {
                spawnpointnodes[ spawnpointnodes.size ] = level.spawnpoints[ index ].radiuspathnodes[ innerindex ];
            }
        }
        
        cachespawnpathnodesincode( spawnpointnodes );
    }
    
    /#
        while ( true )
        {
            level.forcebuddyspawn = getdvarint( @"hash_3c88de2237eb6f6d" ) > 0;
            wait 0.25;
        }
    #/
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x43c7
// Size: 0x13f
function getactiveplayerlist()
{
    activeplayerlist = [];
    
    foreach ( character in level.characters )
    {
        if ( !isreallyalive( character ) )
        {
            continue;
        }
        
        if ( isplayer( character ) )
        {
            if ( character.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( !character val::get( "player_for_spawn_logic" ) )
            {
                continue;
            }
        }
        
        character.spawnlogicteam = getspawnteam( character );
        
        if ( character.spawnlogicteam == "spectator" )
        {
            continue;
        }
        
        if ( isagent( character ) && character.agent_type == "seeker" )
        {
            continue;
        }
        
        spawnlogictraceheight = getplayertraceheight( character );
        spawntracelocation = character geteye();
        spawntracelocation = ( spawntracelocation[ 0 ], spawntracelocation[ 1 ], character.origin[ 2 ] + spawnlogictraceheight );
        character.spawnlogictraceheight = spawnlogictraceheight;
        character.spawntracelocation = spawntracelocation;
        activeplayerlist[ activeplayerlist.size ] = character;
    }
    
    return activeplayerlist;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x450f
// Size: 0x12
function addspawnviewer( entity )
{
    entity registerentityspawnviewer();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x4529
// Size: 0x12
function removespawnviewer( entity )
{
    entity clearentityspawnviewer();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 10
// Checksum 0x0, Offset: 0x4543
// Size: 0x67
function addspawndangerzone( pos, radius, height, friendlyteam, lifetime, playerowner, var_d4a6ace0dec22bae, parentent, var_41171640c23ae1c1, manualcleanup )
{
    return influencepoint_add( pos, radius, height, friendlyteam, lifetime, playerowner, var_d4a6ace0dec22bae, parentent, var_41171640c23ae1c1, manualcleanup );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x45b3
// Size: 0x13
function removespawndangerzone( handle )
{
    influencepoint_remove( handle );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x45ce
// Size: 0x12
function isspawndangerzonealive( handle )
{
    return influencepoint_isscripthandlevalid( handle );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x45e9
// Size: 0x4
function getdefaultminedangerzoneradiussize()
{
    return 250;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 10
// Checksum 0x0, Offset: 0x45f6
// Size: 0x10d
function influencepoint_add( pos, radius, height, friendlyteam, lifetime, playerowner, var_f0022422dc721463, parentent, var_41171640c23ae1c1, manualcleanup )
{
    if ( !isdefined( friendlyteam ) && isdefined( playerowner ) )
    {
        friendlyteam = playerowner.team;
    }
    
    codehandle = undefined;
    
    if ( isdefined( playerowner ) )
    {
        if ( isdefined( var_f0022422dc721463 ) )
        {
            codehandle = createspawninfluencepoint( pos, radius, height, friendlyteam, playerowner, var_f0022422dc721463 );
        }
        else
        {
            codehandle = createspawninfluencepoint( pos, radius, height, friendlyteam, playerowner );
        }
    }
    else
    {
        codehandle = createspawninfluencepoint( pos, radius, height, friendlyteam );
    }
    
    assertex( isdefined( codehandle ), "<dev string:x7f1>" );
    
    if ( !isdefined( codehandle ) )
    {
        return;
    }
    
    scripthandle = influencepoint_getnewscripthandle( codehandle );
    assert( influencepoint_isscripthandlevalid( scripthandle ) );
    
    if ( !istrue( manualcleanup ) )
    {
        thread influencepoint_cleanupthink( scripthandle, &removespawndangerzone, parentent, lifetime, var_41171640c23ae1c1 );
    }
    
    return scripthandle;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x470c
// Size: 0x42
function influencepoint_remove( scripthandle )
{
    assertex( influencepoint_isscripthandlevalid( scripthandle ), "<dev string:x831>" );
    codehandle = influencepoint_getcodehandlefromscripthandle( scripthandle );
    destroyspawninfluencepoint( codehandle );
    influencepoint_invalidatescripthandlesforcodehandle( codehandle );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x4756
// Size: 0x7b
function influencepoint_getnewscripthandle( codehandle )
{
    spawnglobals = level.spawnglobals;
    assert( codehandle < 65536 - 1 );
    
    if ( !isdefined( spawnglobals.influencenodealloccounts[ codehandle ] ) )
    {
        spawnglobals.influencenodealloccounts[ codehandle ] = 0;
    }
    
    alloccount = spawnglobals.influencenodealloccounts[ codehandle ];
    scripthandle = alloccount << 16 | codehandle;
    return scripthandle;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x47da
// Size: 0x64
function influencepoint_invalidatescripthandlesforcodehandle( codehandle )
{
    spawnglobals = level.spawnglobals;
    spawnglobals.influencenodealloccounts[ codehandle ]++;
    alloccount = spawnglobals.influencenodealloccounts[ codehandle ];
    
    if ( alloccount >= 65536 - 1 )
    {
        alloccount = 0;
        spawnglobals.influencenodealloccounts[ codehandle ] = 0;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x4846
// Size: 0x15
function influencepoint_getcodehandlefromscripthandle( scripthandle )
{
    return scripthandle & 65536 - 1;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x4864
// Size: 0xf
function influencepoint_getalloccountfromscripthandle( scripthandle )
{
    return scripthandle >> 16;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x487c
// Size: 0x62, Type: bool
function influencepoint_isscripthandlevalid( scripthandle )
{
    spawnglobals = level.spawnglobals;
    var_80420be8a5b2f86b = influencepoint_getalloccountfromscripthandle( scripthandle );
    codehandle = influencepoint_getcodehandlefromscripthandle( scripthandle );
    alloccount = spawnglobals.influencenodealloccounts[ codehandle ];
    return isdefined( alloccount ) && var_80420be8a5b2f86b == alloccount;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 5
// Checksum 0x0, Offset: 0x48e7
// Size: 0xa2
function influencepoint_cleanupthink( handle, removalfunc, owner, lifetime, removeondeath )
{
    level endon( "game_ended" );
    endons = [];
    
    if ( isdefined( removeondeath ) )
    {
        endons[ endons.size ] = "death";
    }
    
    assertex( isdefined( owner ) || endons.size == 0, "<dev string:x87f>" );
    
    if ( isdefined( lifetime ) )
    {
        if ( endons.size > 0 )
        {
            owner waittill_any_in_array_or_timeout_no_endon_death( endons, lifetime );
        }
        else
        {
            wait lifetime;
        }
    }
    else if ( isdefined( owner ) )
    {
        owner waittill_any_in_array_return( endons );
    }
    
    if ( !influencepoint_isscripthandlevalid( handle ) )
    {
        return;
    }
    
    [[ removalfunc ]]( handle );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x4991
// Size: 0x18d
function updatespawnviewers()
{
    level.spawnviewers = getactiveplayerlist();
    
    /#
        level.spawnviewersupdatetime = gettime();
        thread function_9ab26c0d48173ab1();
    #/
    
    foreach ( viewer in level.spawnviewers )
    {
        viewer.spawnviewpathnodes = undefined;
    }
    
    foreach ( turret in level.turrets )
    {
        if ( !isdefined( turret ) )
        {
            continue;
        }
        
        turret.spawnlogicteam = getspawnteam( turret );
        level.spawnviewers[ level.spawnviewers.size ] = turret;
        turret.spawnviewpathnodes = undefined;
    }
    
    foreach ( ugv in level.ugvs )
    {
        if ( !isdefined( ugv ) )
        {
            continue;
        }
        
        ugv.spawnlogicteam = getspawnteam( ugv );
        level.spawnviewers[ level.spawnviewers.size ] = ugv;
        ugv.spawnviewpathnodes = undefined;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x4b26
// Size: 0x1f, Type: bool
function arespawnviewersvalid()
{
    return isdefined( level.spawnviewersupdatetime ) && level.spawnviewersupdatetime == gettime();
}

/#

    // Namespace spawnlogic / scripts\mp\spawnlogic
    // Params 0
    // Checksum 0x0, Offset: 0x4b4e
    // Size: 0x10, Type: dev
    function function_9ab26c0d48173ab1()
    {
        waitframe();
        level.spawnviewers = undefined;
    }

#/

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x4b66
// Size: 0x28b
function logspawnpointsightupdate( spawnpoint, team )
{
    if ( istrue( spawnpoint.buddyspawn ) || istrue( spawnpoint.isdynamicspawn ) )
    {
        return;
    }
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        if ( isdefined( level.matchrecording_generateid ) && !isdefined( spawnpoint.logid ) )
        {
            spawnpoint.logid = [[ level.matchrecording_generateid ]]();
        }
        
        if ( isdefined( spawnpoint.logid ) )
        {
            statevalue = 3;
            
            if ( level.teambased )
            {
                allieson = 1;
                axison = 1;
                
                if ( team == "allies" )
                {
                    assert( spawnpoint.hassightdata[ "<dev string:x8c2>" ] );
                    allieson = spawnpoint.logspawndisabled[ "allies" ] == 0;
                    var_a0804401f03be2f4 = isdefined( spawnpoint.loggedstate ) && ( spawnpoint.loggedstate == 0 || spawnpoint.loggedstate == 2 );
                    axison = ter_op( isdefined( spawnpoint.loggedstate ), var_a0804401f03be2f4, 0 );
                }
                else
                {
                    assert( spawnpoint.hassightdata[ "<dev string:x8cc>" ] );
                    axison = spawnpoint.logspawndisabled[ "axis" ] == 0;
                    var_9c34cf8271074603 = isdefined( spawnpoint.loggedstate ) && ( spawnpoint.loggedstate == 0 || spawnpoint.loggedstate == 1 );
                    allieson = ter_op( isdefined( spawnpoint.loggedstate ), var_9c34cf8271074603, 0 );
                }
                
                if ( allieson && axison )
                {
                    statevalue = 0;
                }
                else if ( allieson )
                {
                    statevalue = 1;
                }
                else if ( axison )
                {
                    statevalue = 2;
                }
            }
            else
            {
                assert( spawnpoint.hassightdata[ "<dev string:x8d4>" ] );
                statevalue = ter_op( spawnpoint.fullsights[ "all" ] == 0, 0, 3 );
            }
            
            if ( !isdefined( spawnpoint.loggedstate ) || spawnpoint.loggedstate != statevalue )
            {
                [[ level.matchrecording_logevent ]]( spawnpoint.logid, "allies", "SPAWN_ENTITY", spawnpoint.origin[ 0 ], spawnpoint.origin[ 1 ], gettime(), statevalue );
                spawnpoint.loggedstate = statevalue;
            }
        }
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x4df9
// Size: 0xdb
function loginitialspawnposition( spawnpoint )
{
    if ( istrue( spawnpoint.buddyspawn ) || istrue( spawnpoint.isdynamicspawn ) )
    {
        return;
    }
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        if ( isdefined( level.matchrecording_generateid ) && !isdefined( spawnpoint.logid ) )
        {
            spawnpoint.logid = [[ level.matchrecording_generateid ]]();
        }
        
        if ( isdefined( spawnpoint.logid ) && !isdefined( spawnpoint.didinitiallog ) )
        {
            [[ level.matchrecording_logevent ]]( spawnpoint.logid, "allies", "SPAWN_ENTITY", spawnpoint.origin[ 0 ], spawnpoint.origin[ 1 ], gettime(), 0 );
            spawnpoint.didinitiallog = 1;
        }
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x4edc
// Size: 0x1ab
function spawnpointdistanceupdate( spawnpoint )
{
    assert( arespawnviewersvalid() );
    
    if ( isdefined( spawnpoint ) && isdefined( spawnpoint.mindistsquared ) )
    {
        foreach ( player in level.spawnviewers )
        {
            distsquared = distancesquared( player.origin, spawnpoint.origin );
            
            if ( isdefined( spawnpoint.mindistsquared[ player.spawnlogicteam ] ) )
            {
                if ( distsquared < spawnpoint.mindistsquared[ player.spawnlogicteam ] )
                {
                    spawnpoint.mindistsquared[ player.spawnlogicteam ] = distsquared;
                }
                
                if ( player.spawnlogicteam == "spectator" )
                {
                    continue;
                }
                
                spawnpoint.distsumsquared[ player.spawnlogicteam ] += distsquared;
                spawnpoint.distsumsquaredcapped[ player.spawnlogicteam ] += min( distsquared, scripts\mp\spawnfactor::maxplayerspawninfluencedistsquared() );
                spawnpoint.totalplayers[ player.spawnlogicteam ]++;
            }
        }
        
        spawnpoint.hasdistdata = 1;
        return;
    }
    
    assertmsg( "<dev string:x8db>" );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x508f
// Size: 0x36
function getspawnteam( ent )
{
    team = "all";
    
    if ( level.teambased )
    {
        team = ent.team;
    }
    
    return team;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x50ce
// Size: 0x23
function initspawnpointvalues( spawnpoint )
{
    clearspawnpointsightdata( spawnpoint );
    clearspawnpointdistancedata( spawnpoint );
    function_32368b70c6aa5729( spawnpoint );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x50f9
// Size: 0x7c
function clearspawnpointsightdata( spawnpoint )
{
    if ( level.teambased )
    {
        foreach ( teamname in level.teamnamelist )
        {
            clearteamspawnpointsightdata( spawnpoint, teamname );
        }
        
        return;
    }
    
    clearteamspawnpointsightdata( spawnpoint, "all" );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x517d
// Size: 0xb
function setupplayerspawnsightdata( player )
{
    
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x5190
// Size: 0x7c
function clearspawnpointdistancedata( spawnpoint )
{
    if ( level.teambased )
    {
        foreach ( teamname in level.teamnamelist )
        {
            clearteamspawnpointdistancedata( spawnpoint, teamname );
        }
        
        return;
    }
    
    clearteamspawnpointdistancedata( spawnpoint, "all" );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5214
// Size: 0x75
function clearteamspawnpointsightdata( spawnpoint, team )
{
    spawnpoint.hassightdata[ team ] = 0;
    spawnpoint.fullsights[ team ] = 0;
    spawnpoint.cornersights[ team ] = 0;
    spawnpoint.logspawndisabled[ team ] = 0;
    spawnpoint.maxsightvalue[ team ] = 0;
    spawnpoint.maxjumpsightvalue[ team ] = 0;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5291
// Size: 0x60
function clearteamspawnpointdistancedata( spawnpoint, team )
{
    spawnpoint.hasdistdata = 0;
    spawnpoint.distsumsquared[ team ] = 0;
    spawnpoint.distsumsquaredcapped[ team ] = 0;
    spawnpoint.mindistsquared[ team ] = 9999999;
    spawnpoint.totalplayers[ team ] = 0;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x52f9
// Size: 0x4e
function getplayertraceheight( player, var_de6e84bcd0dd9094 )
{
    if ( isdefined( var_de6e84bcd0dd9094 ) && var_de6e84bcd0dd9094 )
    {
        return 64;
    }
    
    stance = player getstance();
    
    if ( stance == "stand" )
    {
        return 64;
    }
    
    if ( stance == "crouch" )
    {
        return 44;
    }
    
    return 32;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5350
// Size: 0x10f
function additionalsighttraceentities( spawnpoint, entarray )
{
    foreach ( ent in entarray )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        team = getspawnteam( ent );
        
        if ( spawnpoint.fullsights[ team ] )
        {
            continue;
        }
        
        spawnpoint.hassightdata[ team ] = 1;
        enttracepoint = ent.origin + ( 0, 0, 50 );
        sightvalue = 0;
        
        if ( !sightvalue )
        {
            sightvalue = spawnsighttrace( spawnpoint, spawnpoint.sighttracepoint, enttracepoint );
        }
        
        if ( !sightvalue )
        {
            continue;
        }
        
        if ( sightvalue > 0.95 )
        {
            spawnpoint.fullsights[ team ]++;
            continue;
        }
        
        spawnpoint.cornersights[ team ]++;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x5467
// Size: 0x172
function finalizespawnpointchoice( spawnpoint )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    spawnpoint.lastspawntime = time;
    spawnpoint.lastspawnteam = self.team;
    
    if ( !isdefined( spawnpoint.bucket ) )
    {
        self finalizespawnpointchoiceforplayer( spawnpoint.index );
    }
    else
    {
        if ( !isdefined( spawnpoint.usingfallback ) )
        {
            spawnpoint.usingfallback = 0;
        }
        
        if ( !isdefined( spawnpoint.threatsight ) )
        {
            spawnpoint.threatsight = -1;
        }
        
        if ( !isdefined( spawnpoint.damagemod ) )
        {
            spawnpoint.damagemod = -1;
        }
        
        self finalizespawnpointchoiceforplayer( spawnpoint.index, spawnpoint.bucket, spawnpoint.usingfallback, spawnpoint.threatsight, spawnpoint.damagemod );
    }
    
    scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    
    if ( isdefined( scriptdata ) )
    {
        scriptdata.used = 1;
    }
    
    level.spawnglobals.lastteamspawnpoints[ self.team ] = spawnpoint;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x55e1
// Size: 0x80
function expandspawnpointbounds( classname )
{
    spawnpoints = getspawnpointarray( classname );
    
    for ( index = 0; index < spawnpoints.size ; index++ )
    {
        level.spawnmins = expandmins( level.spawnmins, spawnpoints[ index ].origin );
        level.spawnmaxs = expandmaxs( level.spawnmaxs, spawnpoints[ index ].origin );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5669
// Size: 0x7e
function expandmins( mins, point )
{
    if ( mins == ( 0, 0, 0 ) && isdefined( point ) )
    {
        mins = point;
    }
    else
    {
        if ( mins[ 0 ] > point[ 0 ] )
        {
            mins = ( point[ 0 ], mins[ 1 ], mins[ 2 ] );
        }
        
        if ( mins[ 1 ] > point[ 1 ] )
        {
            mins = ( mins[ 0 ], point[ 1 ], mins[ 2 ] );
        }
        
        if ( mins[ 2 ] > point[ 2 ] )
        {
            mins = ( mins[ 0 ], mins[ 1 ], point[ 2 ] );
        }
    }
    
    return mins;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x56f0
// Size: 0x60
function expandmaxs( maxs, point )
{
    if ( maxs[ 0 ] < point[ 0 ] )
    {
        maxs = ( point[ 0 ], maxs[ 1 ], maxs[ 2 ] );
    }
    
    if ( maxs[ 1 ] < point[ 1 ] )
    {
        maxs = ( maxs[ 0 ], point[ 1 ], maxs[ 2 ] );
    }
    
    if ( maxs[ 2 ] < point[ 2 ] )
    {
        maxs = ( maxs[ 0 ], maxs[ 1 ], point[ 2 ] );
    }
    
    return maxs;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5759
// Size: 0x7a
function findboxcenter( mins, maxs )
{
    center = ( 0, 0, 0 );
    centeroverride = getstruct( "map_center_override", "targetname" );
    
    if ( isdefined( centeroverride ) )
    {
        center = centeroverride.origin;
    }
    else
    {
        center = maxs - mins;
        center = ( center[ 0 ] / 2, center[ 1 ] / 2, center[ 2 ] / 2 ) + mins;
    }
    
    return center;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x57dc
// Size: 0x79
function setmapcenterfordev()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    scripts\mp\spawnlogic::expandspawnpointbounds( "mp_tdm_spawn_allies_start" );
    scripts\mp\spawnlogic::expandspawnpointbounds( "mp_tdm_spawn_axis_start" );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x585d
// Size: 0x7d, Type: bool
function shoulduseteamstartspawn()
{
    if ( getdvarint( @"hash_8ba7b3d0520775da", 0 ) == 1 )
    {
        return true;
    }
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) && isdefined( game[ "infil" ] ) && !scripts\mp\flags::gameflag( "infil_started" ) )
    {
        return true;
    }
    
    if ( istrue( level.disableteamstartspawns ) )
    {
        return false;
    }
    
    return level.ingraceperiod && ( !isdefined( level.numkills ) || level.numkills == 0 );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x58e3
// Size: 0x53
function getpathsighttestnodes( pos, bclose )
{
    if ( bclose )
    {
        mindist = 0;
        maxdist = getclosenoderadiusdist();
    }
    else
    {
        mindist = getclosenoderadiusdist();
        maxdist = 250;
    }
    
    return getnodesinradius( pos, maxdist, mindist, 512, "path" );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x593f
// Size: 0x69
function getradiuspathsighttestnodes( pos )
{
    nodelist = [];
    singlenode = getclosestnodeinsight( pos );
    
    if ( isdefined( singlenode ) )
    {
        nodelist[ 0 ] = singlenode;
    }
    
    if ( !isdefined( singlenode ) )
    {
        nodelist = getnodesinradius( pos, getclosenoderadiusdist(), 0, 256, "path" );
        
        if ( nodelist.size == 0 )
        {
            nodelist = getnodesinradius( pos, 250, 0, 256, "path" );
        }
    }
    
    return nodelist;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x59b1
// Size: 0x3e7
function evaluateprecomputedlos( spawnpoint, team )
{
    checkttlosloaded();
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( team )[ 0 ];
    }
    
    if ( !shoulduseprecomputedlos() )
    {
        spawnpoint.hassightdata[ enemyteam ] = 1;
        return;
    }
    
    assert( isttlosdataavailable() );
    lowerlimitfullsights = 0.95;
    lowerlimitcornersights = 0;
    sightvalue = undefined;
    jumpsightvalue = undefined;
    lowerlimitfullsights = level.spawnglobals.lowerlimitfullsights;
    lowerlimitcornersights = level.spawnglobals.lowerlimitcornersights;
    assert( arespawnviewersvalid() );
    
    foreach ( viewer in level.spawnviewers )
    {
        if ( level.teambased && viewer.spawnlogicteam != enemyteam )
        {
            continue;
        }
        
        if ( spawnpoint.fullsights[ viewer.spawnlogicteam ] )
        {
            break;
        }
        
        if ( !isdefined( viewer.spawnviewpathnodes ) )
        {
            viewer.spawnviewpathnodes = viewer getnearnodelistforspawncheck( getfarnoderadiusdist() );
            
            if ( !isdefined( viewer.spawnviewpathnodes ) || viewer.spawnviewpathnodes.size == 0 )
            {
                /#
                    viewer.var_cba3632b3172a989 = 1;
                #/
                
                if ( isdefined( level.matchrecording_logeventmsg ) && isplayer( viewer ) )
                {
                    if ( !isdefined( viewer.lastpathnodewarningtime ) || viewer.lastpathnodewarningtime != gettime() )
                    {
                        [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "WARNING: Could not use TTLOS data for player " + viewer.name );
                        viewer.lastpathnodewarningtime = gettime();
                    }
                }
            }
        }
        
        if ( isdefined( viewer.spawnviewpathnodes ) && viewer.spawnviewpathnodes.size > 0 )
        {
            sightvalues = _precomputedlosdatatest( viewer, spawnpoint );
            sightvalue = sightvalues[ 0 ];
            jumpsightvalue = sightvalues[ 1 ];
        }
        
        if ( !isdefined( sightvalue ) )
        {
            tracepos = undefined;
            
            if ( isplayer( viewer ) )
            {
                tracepos = viewer geteye();
            }
            else
            {
                tracepos = viewer.origin + ( 0, 0, 50 );
            }
            
            sightvalue = directlineofsighttest( spawnpoint, viewer, tracepos );
            jumpsightvalue = sightvalue;
        }
        
        if ( !isdefined( spawnpoint.maxsightvalue[ viewer.spawnlogicteam ] ) || sightvalue > spawnpoint.maxsightvalue[ viewer.spawnlogicteam ] )
        {
            spawnpoint.maxsightvalue[ viewer.spawnlogicteam ] = sightvalue;
        }
        
        if ( isdefined( jumpsightvalue ) && isplayer( viewer ) )
        {
            if ( !isdefined( spawnpoint.maxjumpsightvalue[ viewer.spawnlogicteam ] ) || jumpsightvalue > spawnpoint.maxjumpsightvalue[ viewer.spawnlogicteam ] )
            {
                spawnpoint.maxjumpsightvalue[ viewer.spawnlogicteam ] = jumpsightvalue;
            }
        }
        
        if ( sightvalue > lowerlimitfullsights )
        {
            spawnpoint.fullsights[ viewer.spawnlogicteam ]++;
            spawnpoint.logspawndisabled[ viewer.spawnlogicteam ]++;
            continue;
        }
        
        if ( sightvalue > lowerlimitcornersights )
        {
            spawnpoint.cornersights[ viewer.spawnlogicteam ]++;
        }
    }
    
    spawnpoint.hassightdata[ enemyteam ] = 1;
    logspawnpointsightupdate( spawnpoint, enemyteam );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5da0
// Size: 0x69
function _precomputedlosdatatest( viewer, spawnpoint )
{
    sightvalues = checkttlosoverrides( viewer, spawnpoint );
    
    if ( !isdefined( sightvalues ) )
    {
        if ( checkttlosdeverrors( viewer, spawnpoint ) )
        {
            return [ 1, 1 ];
        }
        
        sightvalues = precomputedlosdatatest( viewer.spawnviewpathnodes, spawnpoint.radiuspathnodes );
    }
    
    return sightvalues;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5e12
// Size: 0xf5, Type: bool
function checkttlosdeverrors( viewer, spawnpoint )
{
    /#
        errormessage = undefined;
        
        if ( !isdefined( viewer.spawnviewpathnodes ) || viewer.spawnviewpathnodes.size == 0 )
        {
            var_4f2dbc4104804300 = ter_op( isplayer( viewer ), viewer.name, "<dev string:x913>" );
            errormessage = "<dev string:x928>" + var_4f2dbc4104804300 + "<dev string:x939>";
        }
        else if ( !isdefined( spawnpoint.radiuspathnodes ) || spawnpoint.radiuspathnodes.size == 0 )
        {
            errormessage = "<dev string:x955>" + spawnpoint.origin;
        }
        
        if ( isdefined( errormessage ) )
        {
            if ( !isdefined( level.var_e660628db2a340a5 ) || gettime() - level.var_e660628db2a340a5 > 1000 )
            {
                level.var_e660628db2a340a5 = gettime();
                iprintlnbold( errormessage );
            }
            
            return true;
        }
    #/
    
    return false;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x5f10
// Size: 0x132
function checkttlosoverrides( viewer, spawnpoint )
{
    if ( !isdefined( level.spawnglobals.ttlosoverrides ) )
    {
        return;
    }
    
    foreach ( var_865d8e40722512eb in viewer.spawnviewpathnodes )
    {
        var_24ed8518f6fc6e6 = var_865d8e40722512eb getnodenumber();
        
        if ( isdefined( level.spawnglobals.ttlosoverrides[ var_24ed8518f6fc6e6 ] ) )
        {
            foreach ( spawnnode in spawnpoint.radiuspathnodes )
            {
                var_7643b53b09bbf1d5 = spawnnode getnodenumber();
                
                if ( isdefined( level.spawnglobals.ttlosoverrides[ var_24ed8518f6fc6e6 ][ var_7643b53b09bbf1d5 ] ) )
                {
                    return level.spawnglobals.ttlosoverrides[ var_24ed8518f6fc6e6 ][ var_7643b53b09bbf1d5 ];
                }
            }
        }
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 4
// Checksum 0x0, Offset: 0x604a
// Size: 0x115
function addttlosoverride( nodea, nodeb, var_48c0bd41cc10dfd8, var_84c277514873a859 )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( isdefined( level.spawnglobals ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( !isdefined( level.spawnglobals.ttlosoverrides ) )
    {
        level.spawnglobals.ttlosoverrides = [];
    }
    
    if ( !isdefined( level.spawnglobals.ttlosoverrides[ nodea ] ) )
    {
        level.spawnglobals.ttlosoverrides[ nodea ] = [];
    }
    
    level.spawnglobals.ttlosoverrides[ nodea ][ nodeb ] = [ var_48c0bd41cc10dfd8, var_84c277514873a859 ];
    
    if ( !isdefined( level.spawnglobals.ttlosoverrides[ nodeb ] ) )
    {
        level.spawnglobals.ttlosoverrides[ nodeb ] = [];
    }
    
    level.spawnglobals.ttlosoverrides[ nodeb ][ nodea ] = [ var_48c0bd41cc10dfd8, var_84c277514873a859 ];
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6167
// Size: 0x4
function getclosenoderadiusdist()
{
    return 130;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6174
// Size: 0x4
function getfarnoderadiusdist()
{
    return 250;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x6181
// Size: 0xeb
function directlineofsighttest( spawnpoint, viewer, tracepos )
{
    raystart = spawnpoint.sighttracepoint;
    rayend = tracepos;
    contents = physics_createcontents( [ "physicscontents_ainosight" ] );
    castresult = physics_raycast( raystart, rayend, contents, viewer, 0, "physicsquery_any" );
    
    /#
        if ( getdvarint( @"spawndebug", 0 ) != 0 || getdvarint( @"scr_showspawns", 0 ) != 0 )
        {
            line( raystart, rayend - ( 0, 0, 16 ), ter_op( castresult, ( 1, 0, 0 ), ( 0, 1, 0 ) ), 1, 0, 15 );
        }
    #/
    
    return ter_op( castresult, 0, 1 );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6275
// Size: 0x5
function getmaxdistancetolos()
{
    return 2550;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6283
// Size: 0x78
function checkttlosloaded()
{
    if ( scripts\mp\spawnlogic::shoulduseprecomputedlos() && !scripts\mp\spawnlogic::isttlosdataavailable() )
    {
        if ( isdefined( level.matchrecording_logeventmsg ) )
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "ERROR: TTLOS System disabled! Could not access visDistData" );
        }
        
        if ( !isdefined( level.hasshownvisdistdataerror ) )
        {
            assertex( isdefined( level.ttlos_suppressasserts ), "<dev string:x98e>" );
            level.hasshownvisdistdataerror = 1;
        }
        
        level.disableprecomputedlos = 1;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6303
// Size: 0x2c, Type: bool
function shoulduseprecomputedlos()
{
    return getdvarint( @"sv_useprecomputedlosdata", 0 ) == 1 && !isdefined( level.disableprecomputedlos ) && !generatinglosdata();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6338
// Size: 0x13, Type: bool
function generatinglosdata()
{
    return getdvarint( @"hash_74cacae425805743", 0 ) > 0;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6354
// Size: 0x7
function isttlosdataavailable()
{
    return getislosdatafileloaded();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6364
// Size: 0x186
function printstartupdebugmessages()
{
    level waittill( "prematch_done" );
    
    if ( getdvarint( @"scr_playtest", 0 ) == 1 && isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                if ( !shoulduseprecomputedlos() )
                {
                    player iprintlnbold( "TTLOS FAILED TO LOAD!" );
                }
                
                break;
            }
        }
    }
    
    if ( isdefined( level.matchrecording_logeventmsg ) )
    {
        [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Spawn Script Version #" + 6 );
        
        if ( shoulduseprecomputedlos() )
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Attempting to use TTLOS Spawning Data..." );
        }
        else
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "No TTLOS Data! Not using TTLOS" );
        }
        
        [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "CODE spawn logic enabled" );
        
        if ( isdefined( level.spawnglobals.activespawnlogic ) )
        {
            [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: " + level.spawnglobals.activespawnlogic );
            return;
        }
        
        [[ level.matchrecording_logeventmsg ]]( "LOG_GENERIC_MESSAGE", gettime(), "Spawn Logic: None" );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x64f2
// Size: 0x17, Type: bool
function isfallbackspawn( spawnpoint )
{
    return istrue( spawnpoint.isfallback );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x6512
// Size: 0x99
function logextraspawninfothink()
{
    if ( getdvarint( @"hash_aa3f054d34fa39b9", 0 ) != 1 )
    {
        return;
    }
    
    level waittill( "prematch_done" );
    var_527d4e1d1288232e = undefined;
    var_9c8bbf6433e08edf = undefined;
    
    if ( isdefined( level.matchrecording_generateid ) )
    {
        var_527d4e1d1288232e = [[ level.matchrecording_generateid ]]();
        var_9c8bbf6433e08edf = [[ level.matchrecording_generateid ]]();
    }
    
    while ( true )
    {
        if ( !shoulduseprecomputedlos() )
        {
            break;
        }
        
        logextraspawn( "allies", var_527d4e1d1288232e );
        wait 0.5;
        logextraspawn( "axis", var_9c8bbf6433e08edf );
        wait 0.5;
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x65b3
// Size: 0xec
function logextraspawn( team, logid )
{
    var_a02b612b94f6f669 = spawnstruct();
    var_a02b612b94f6f669.team = team;
    var_a02b612b94f6f669.pers = [];
    var_a02b612b94f6f669.pers[ "team" ] = team;
    var_a02b612b94f6f669.disablespawnwarnings = 1;
    var_a02b612b94f6f669.isdynamicspawn = 1;
    bestspawn = var_a02b612b94f6f669 [[ level.getspawnpoint ]]();
    
    if ( isdefined( level.matchrecording_logevent ) && isdefined( bestspawn ) && isdefined( logid ) )
    {
        eventname = ter_op( team == "allies", "BEST_SPAWN_ALLIES", "BEST_SPAWN_AXIS" );
        [[ level.matchrecording_logevent ]]( logid, team, eventname, bestspawn.origin[ 0 ], bestspawn.origin[ 1 ], gettime() );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x66a7
// Size: 0x17
function clearlastteamspawns()
{
    level.spawnglobals.lastteamspawnpoints = [];
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x66c6
// Size: 0x51
function getoriginidentifierstring( spawnpoint )
{
    return int( spawnpoint.origin[ 0 ] ) + " " + int( spawnpoint.origin[ 1 ] ) + " " + int( spawnpoint.origin[ 2 ] );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6720
// Size: 0x37
function getoriginidentifierstringnoz( spawnpoint )
{
    return int( spawnpoint.origin[ 0 ] ) + " " + int( spawnpoint.origin[ 1 ] );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6760
// Size: 0x2a5, Type: bool
function checkmodifiedspawnpoint( spawnpoint )
{
    if ( !isdefined( level.modifiedspawnpoints ) )
    {
        return false;
    }
    
    modifications = undefined;
    originstring = getoriginidentifierstring( spawnpoint );
    
    if ( isdefined( level.modifiedspawnpoints[ originstring ] ) )
    {
        modifications = level.modifiedspawnpoints[ originstring ][ spawnpoint.classname ];
    }
    
    if ( !isdefined( modifications ) )
    {
        originstring = getoriginidentifierstringnoz( spawnpoint );
        
        if ( isdefined( level.modifiedspawnpoints[ originstring ] ) )
        {
            modifications = level.modifiedspawnpoints[ originstring ][ spawnpoint.classname ];
        }
    }
    
    foreach ( location, classnamedata in level.modifiedspawnpoints )
    {
        foreach ( classname, removaldata in classnamedata )
        {
            if ( spawnpoint.classname != classname )
            {
                continue;
            }
            
            foreach ( modifystring, radius in removaldata )
            {
                if ( modifystring == "removeradius" )
                {
                    locstring = strtok( location, " " );
                    x = int( locstring[ 0 ] );
                    y = int( locstring[ 1 ] );
                    z = 0;
                    
                    if ( isdefined( locstring[ 2 ] ) )
                    {
                        z = default_to( int( locstring[ 2 ] ), 0 );
                    }
                    
                    origin = ( x, y, z );
                    
                    if ( isdefined( locstring[ 2 ] ) )
                    {
                        if ( distance( spawnpoint.origin, origin ) < radius )
                        {
                            return true;
                        }
                        
                        continue;
                    }
                    
                    if ( distance2d( spawnpoint.origin, origin ) < radius )
                    {
                        return true;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( modifications ) )
    {
        return false;
    }
    
    if ( istrue( modifications[ "remove" ] ) )
    {
        return true;
    }
    
    if ( isdefined( modifications[ "origin" ] ) )
    {
        spawnpoint.origin = modifications[ "origin" ];
    }
    
    if ( isdefined( modifications[ "angles" ] ) )
    {
        spawnpoint.angles = modifications[ "angles" ];
    }
    
    if ( istrue( modifications[ "no_alternates" ] ) )
    {
        spawnpoint.noalternates = 1;
    }
    
    return false;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6a0e
// Size: 0xd6
function calculateteamclusters( team )
{
    container = spawnstruct();
    container.clusterlist = [];
    
    foreach ( player in level.players )
    {
        if ( !isreallyalive( player ) || player.team != team || !player val::get( "player_for_spawn_logic" ) )
        {
            continue;
        }
        
        newcluster = createcluster( player );
        container.clusterlist[ container.clusterlist.size ] = newcluster;
    }
    
    mergeclusterlist( container );
    return container;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6aed
// Size: 0x46
function createcluster( player )
{
    cluster = spawnstruct();
    cluster.center = player.origin;
    cluster.players = [ player ];
    return cluster;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6b3c
// Size: 0x24d
function mergeclusterlist( container )
{
    var_541b5a167c77648c = undefined;
    var_541b5d167c776b25 = undefined;
    var_14f82e0d331bcd8b = undefined;
    nearestdistsq = -1;
    
    for ( var_a7b44bd189368a72 = 0; var_a7b44bd189368a72 < container.clusterlist.size ; var_a7b44bd189368a72++ )
    {
        clustera = container.clusterlist[ var_a7b44bd189368a72 ];
        
        for ( var_a7b44ad18936883f = var_a7b44bd189368a72 + 1; var_a7b44ad18936883f < container.clusterlist.size ; var_a7b44ad18936883f++ )
        {
            clusterb = container.clusterlist[ var_a7b44ad18936883f ];
            distsq = distance2dsquared( clustera.center, clusterb.center );
            
            if ( distsq > 640000 )
            {
                continue;
            }
            
            if ( nearestdistsq < 0 || distsq < nearestdistsq )
            {
                nearestdistsq = distsq;
                var_541b5a167c77648c = clustera;
                var_541b5d167c776b25 = clusterb;
                var_14f82e0d331bcd8b = var_a7b44ad18936883f;
            }
        }
    }
    
    if ( isdefined( var_541b5a167c77648c ) && isdefined( var_541b5d167c776b25 ) )
    {
        foreach ( player in var_541b5d167c776b25.players )
        {
            var_541b5a167c77648c.players[ var_541b5a167c77648c.players.size ] = player;
        }
        
        var_b7e9316956e86d04 = ( 0, 0, 0 );
        
        foreach ( player in var_541b5a167c77648c.players )
        {
            var_b7e9316956e86d04 += player.origin;
        }
        
        var_b7e9316956e86d04 /= var_541b5a167c77648c.players.size;
        var_541b5a167c77648c.center = var_b7e9316956e86d04;
        lastindex = container.clusterlist.size - 1;
        container.clusterlist[ var_14f82e0d331bcd8b ] = container.clusterlist[ lastindex ];
        container.clusterlist[ lastindex ] = undefined;
        mergeclusterlist( container );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x6d91
// Size: 0x30
function ignoretriggerenter( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player val::set( "spawnIgnoreTrigger", "player_for_spawn_logic", 0 );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x6dc9
// Size: 0x2a
function ignoretriggerexit( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player val::reset_all( "spawnIgnoreTrigger" );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6dfb
// Size: 0x7d
function getspawnbucketfromstring( var_cbf572b044ed12e0 )
{
    switch ( var_cbf572b044ed12e0 )
    {
        case #"hash_8d30f90f19b8f838":
            return 0;
        case #"hash_fa2adbf6bd65180f":
            return 1;
        case #"hash_21256f6c1b235f58":
            return 2;
        case #"hash_68377d7877ae1c3":
            return 3;
        case #"hash_82dd7c3e206217c2":
            return 4;
        case #"hash_b612ae5499914631":
            return 5;
    }
    
    assertmsg( "<dev string:x9e3>" );
    return 2;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6e81
// Size: 0x60
function enablespawnpointlist( spawnpoints )
{
    foreach ( spawnpoint in spawnpoints )
    {
        enablespawnpointbyindex( spawnpoint.index );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6ee9
// Size: 0x60
function disablespawnpointlist( spawnpoints )
{
    foreach ( spawnpoint in spawnpoints )
    {
        disablespawnpointbyindex( spawnpoint.index );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x6f51
// Size: 0x20
function function_fd739ec45329729e( id )
{
    return level.globals.spawnsetlists[ id ];
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x6f7a
// Size: 0x95
function registerspawnset( id, spawnpoints )
{
    globals = level.spawnglobals;
    assertex( isdefined( globals ), "<dev string:xa00>" );
    assertex( !isdefined( globals.spawnsets[ id ] ), "<dev string:xa55>" );
    globals.spawnsets[ id ] = spawnpoints;
    
    if ( isarray( spawnpoints ) )
    {
        globals.spawnsetlists[ id ] = spawnpoints;
    }
    else
    {
        globals.spawnsetlists[ id ] = getspawnpointarray( spawnpoints );
    }
    
    return id;
}

/#

    // Namespace spawnlogic / scripts\mp\spawnlogic
    // Params 1
    // Checksum 0x0, Offset: 0x7018
    // Size: 0x30, Type: dev
    function function_8390bf8c3b74466a( id )
    {
        globals = level.spawnglobals;
        globals.spawnsets[ id ] = undefined;
    }

#/

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x7050
// Size: 0xe1
function activatespawnset( id, exclusive )
{
    globals = level.spawnglobals;
    assertex( isdefined( globals ), "<dev string:xa00>" );
    
    if ( istrue( exclusive ) )
    {
        if ( globals.activespawnsets.size == 1 && isdefined( globals.activespawnsets[ id ] ) )
        {
            return;
        }
        
        deactivateallspawnsets();
    }
    else if ( isdefined( globals.activespawnsets[ id ] ) )
    {
        return;
    }
    
    spawnset = globals.spawnsets[ id ];
    assertex( isdefined( spawnset ), "<dev string:xa98>" + id );
    
    if ( isarray( spawnset ) )
    {
        enablespawnpointlist( spawnset );
    }
    else
    {
        assert( isstring( spawnset ) );
        enablespawnpointsbyclassname( spawnset );
    }
    
    globals.activespawnsets[ id ] = 1;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x7139
// Size: 0xe6
function deactivatespawnset( id )
{
    globals = level.spawnglobals;
    assertex( isdefined( globals ), "<dev string:xacb>" );
    var_fecf52449f0d8583 = [];
    
    foreach ( key, value in globals.activespawnsets )
    {
        if ( key != id )
        {
            var_fecf52449f0d8583[ key ] = 1;
            continue;
        }
        
        spawnset = globals.spawnsets[ id ];
        
        if ( isarray( spawnset ) )
        {
            disablespawnpointlist( spawnset );
            continue;
        }
        
        assert( isstring( spawnset ) );
        disablespawnpointsbyclassname( spawnset );
    }
    
    globals.activespawnsets = var_fecf52449f0d8583;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x7227
// Size: 0x1d
function deactivateallspawnsets()
{
    level.spawnglobals.activespawnsets = [];
    disablespawnpoints();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x724c
// Size: 0x21
function getspawnsetsize( id )
{
    return level.spawnglobals.spawnsetlists[ id ].size;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x7276
// Size: 0x41
function getrandomspawnpointfromset( id )
{
    globals = level.spawnglobals;
    return globals.spawnsetlists[ id ][ randomint( globals.spawnsetlists[ id ].size ) ];
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x72c0
// Size: 0x95
function getrandomspawnpointfromactivesets()
{
    var_90be334c1c37268a = getarraykeys( level.spawnglobals.activespawnsets );
    
    for ( var_ffed3098c31f4403 = undefined; !isdefined( var_ffed3098c31f4403 ) && var_90be334c1c37268a.size > 0 ; var_ffed3098c31f4403 = undefined )
    {
        var_ffed3098c31f4403 = random( var_90be334c1c37268a );
        
        if ( getspawnsetsize( var_ffed3098c31f4403 ) <= 0 )
        {
            var_90be334c1c37268a = array_remove( var_90be334c1c37268a, var_ffed3098c31f4403 );
        }
    }
    
    return level.spawnglobals.spawnsetlists[ var_ffed3098c31f4403 ][ randomint( level.spawnglobals.spawnsetlists[ var_ffed3098c31f4403 ].size ) ];
}

/#

    // Namespace spawnlogic / scripts\mp\spawnlogic
    // Params 0
    // Checksum 0x0, Offset: 0x735e
    // Size: 0x181, Type: dev
    function updatedebughud()
    {
        var_e582e1172dddb3dd = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_2889bd5801e0ce5a", 0 ) != 0 )
            {
                printtoscreen2d( 1425, 875, "<dev string:xb22>", ( 0, 1, 0 ), 2 );
                
                if ( shoulduseprecomputedlos() )
                {
                    printtoscreen2d( 1425, 900, "<dev string:xb3a>", ( 0, 1, 0 ), 2 );
                }
                else
                {
                    printtoscreen2d( 1425, 900, "<dev string:xb4a>", ( 1, 0, 0 ), 2 );
                }
            }
            
            foreach ( player in level.players )
            {
                var_6fec14662c9a94b9 = isdefined( player.var_cba3632b3172a989 ) && player.var_cba3632b3172a989;
                var_6d453b4d602809fa = isdefined( player.var_40148273e8ddc816 ) && player.var_40148273e8ddc816;
                
                if ( var_6fec14662c9a94b9 != var_6d453b4d602809fa )
                {
                    player.var_40148273e8ddc816 = var_6fec14662c9a94b9;
                    
                    if ( var_6fec14662c9a94b9 )
                    {
                        iprintlnbold( "<dev string:xb5d>" + player.origin );
                    }
                }
                
                if ( var_6fec14662c9a94b9 )
                {
                    printtoscreen2d( 1425, 925, "<dev string:xb87>", ( 1, 0, 0 ), 2 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace spawnlogic / scripts\mp\spawnlogic
    // Params 1
    // Checksum 0x0, Offset: 0x74e7
    // Size: 0xd6, Type: dev
    function function_4c2c5ecea9fd1e73( spawnpoint )
    {
        println( "<dev string:xba0>" + spawnpoint.index + "<dev string:xbca>" );
        println( "<dev string:xbe7>" + spawnpoint.totalscore );
        println( "<dev string:xbf4>" + spawnpoint.totalpossiblescore );
        
        foreach ( factorname, score in spawnpoint.debugscoredata )
        {
            println( "<dev string:xc01>" + factorname + "<dev string:xc06>" + score + "<dev string:xc0d>" + spawnpoint.var_6531ac2ff1a37628[ factorname ] + "<dev string:xc13>" );
        }
    }

    // Namespace spawnlogic / scripts\mp\spawnlogic
    // Params 0
    // Checksum 0x0, Offset: 0x75c5
    // Size: 0x60, Type: dev
    function function_50a59d95bac1964e()
    {
        foreach ( spawnpoint in level.spawnpoints )
        {
            initspawnpointvalues( spawnpoint );
        }
        
        scripts\mp\spawnscoring::resetperupdatespawnglobals();
    }

    // Namespace spawnlogic / scripts\mp\spawnlogic
    // Params 3
    // Checksum 0x0, Offset: 0x762d
    // Size: 0x124, Type: dev
    function function_d344bbcacf5e4d96( factorref, factorstruct, spawncontext )
    {
        if ( !isdefined( spawncontext.factorparams ) )
        {
            assertmsg( "<dev string:xc18>" + getxhashsourcename( factorref ) + "<dev string:xc2a>" );
        }
        
        outputparams = [];
        
        foreach ( paramref in factorstruct.paramreflist )
        {
            foreach ( var_8437e2a35e8d84c9, var_19b8bfffd5a5cbad in spawncontext.factorparams )
            {
                if ( var_8437e2a35e8d84c9 == paramref )
                {
                    outputparams[ paramref ] = var_19b8bfffd5a5cbad;
                    break;
                }
            }
            
            assertex( isdefined( outputparams[ paramref ] ), "<dev string:xc18>" + factorref + "<dev string:xc74>" + getxhashsourcename( paramref ) + "<dev string:xc95>" );
        }
    }

#/

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 5
// Checksum 0x0, Offset: 0x7759
// Size: 0x7e
function createscriptedspawnpoint( classname, origin, angles, target, script_noteworthy )
{
    spawnpoint = spawnstruct();
    spawnpoint.classname = classname;
    spawnpoint.origin = origin;
    spawnpoint.angles = angles;
    spawnpoint.target = target;
    spawnpoint.script_noteworthy = script_noteworthy;
    return spawnpoint;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x77e0
// Size: 0x1dc
function addscriptedspawnpoints( var_223764ad899d9fee )
{
    if ( !isdefined( level.scriptedspawnpointarray ) )
    {
        level.scriptedspawnpointarray = [];
    }
    
    foreach ( scriptedspawnpoint in var_223764ad899d9fee )
    {
        classname = scriptedspawnpoint.classname;
        origin = scriptedspawnpoint.origin;
        angles = scriptedspawnpoint.angles;
        
        if ( isdefined( scriptedspawnpoint.target ) )
        {
            target = scriptedspawnpoint.target;
        }
        else
        {
            target = "";
        }
        
        if ( isdefined( scriptedspawnpoint.script_noteworthy ) )
        {
            script_noteworthy = scriptedspawnpoint.script_noteworthy;
        }
        else
        {
            script_noteworthy = "";
        }
        
        if ( !isdefined( level.scriptedspawnpointarray[ classname ] ) )
        {
            level.scriptedspawnpointarray[ classname ] = [];
        }
        
        var_f1a1172ed4e53a5d = spawnstruct();
        var_f1a1172ed4e53a5d.classname = classname;
        var_f1a1172ed4e53a5d.origin = origin;
        var_f1a1172ed4e53a5d.angles = angles;
        index = registerscriptedspawnpoints( classname, origin, angles, target, script_noteworthy );
        
        if ( !isdefined( index ) || index < 0 )
        {
            continue;
        }
        
        var_f1a1172ed4e53a5d.index = index;
        
        if ( target != "" )
        {
            var_f1a1172ed4e53a5d.target = target;
        }
        
        if ( script_noteworthy != "" )
        {
            var_f1a1172ed4e53a5d.script_noteworthy = script_noteworthy;
        }
        
        level.scriptedspawnpointarray[ classname ][ level.scriptedspawnpointarray[ classname ].size ] = var_f1a1172ed4e53a5d;
    }
    
    level thread scriptedspawnpointsonmigration();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x79c4
// Size: 0x151
function scriptedspawnpointsonmigration()
{
    level notify( "scriptedSpawnpointsOnMigration" );
    level endon( "scriptedSpawnpointsOnMigration" );
    assert( isdefined( level.scriptedspawnpointarray ) );
    
    while ( true )
    {
        level waittill( "host_migration_begin" );
        
        foreach ( var_46a778b6f75c012c in level.scriptedspawnpointarray )
        {
            foreach ( scriptedspawnpoint in var_46a778b6f75c012c )
            {
                if ( isdefined( scriptedspawnpoint.target ) )
                {
                    target = scriptedspawnpoint.target;
                }
                else
                {
                    target = "";
                }
                
                if ( isdefined( scriptedspawnpoint.script_noteworthy ) )
                {
                    script_noteworthy = scriptedspawnpoint.script_noteworthy;
                }
                else
                {
                    script_noteworthy = "";
                }
                
                index = registerscriptedspawnpoints( scriptedspawnpoint.classname, scriptedspawnpoint.origin, scriptedspawnpoint.angles, target, script_noteworthy );
            }
        }
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x7b1d
// Size: 0x45, Type: bool
function function_bff229a11ecd1e34()
{
    if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_7b4496518c2be4e7 ) && level.gametypebundle.var_7b4496518c2be4e7.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x7b6b
// Size: 0x1e4
function function_5d5267daeda595( var_25ff9cceff399d80, var_e1fac4e807047e1c )
{
    var_87226a6b58a1aa22 = "";
    var_40d7195435a4e5be = "";
    
    switch ( getgametype() )
    {
        case #"hash_ec086b911c1011ec":
            var_87226a6b58a1aa22 = "mp_rescue_spawn_attacker";
            var_40d7195435a4e5be = "mp_rescue_spawn_defender";
            break;
        case #"hash_fa50b0f6bd82e972":
            var_87226a6b58a1aa22 = "mp_sd_spawn_attacker";
            var_40d7195435a4e5be = "mp_sd_spawn_defender";
            break;
        case #"hash_eb5e5f470e0c1dc2":
            var_87226a6b58a1aa22 = "mp_cyber_spawn_allies";
            var_40d7195435a4e5be = "mp_cyber_spawn_axis";
            break;
    }
    
    spawns = [];
    attackerspawns = function_ce51e08dcc037220( getstructarray( var_25ff9cceff399d80, "script_noteworthy" ), undefined, "Attacker Spawn was unable to find " + var_25ff9cceff399d80 + " in the Battle Maps create script data" );
    
    if ( isdefined( attackerspawns ) )
    {
        foreach ( attacker in attackerspawns )
        {
            spawns[ spawns.size ] = createscriptedspawnpoint( var_87226a6b58a1aa22, attacker.origin, attacker.angles );
        }
    }
    
    defenderspawns = function_ce51e08dcc037220( getstructarray( var_e1fac4e807047e1c, "script_noteworthy" ), undefined, "Defender Spawn was unable to find " + var_e1fac4e807047e1c + " in the Battle Maps create script data" );
    
    if ( isdefined( defenderspawns ) )
    {
        foreach ( defender in defenderspawns )
        {
            spawns[ spawns.size ] = createscriptedspawnpoint( var_40d7195435a4e5be, defender.origin, defender.angles );
        }
    }
    
    if ( spawns.size > 0 )
    {
        addscriptedspawnpoints( spawns );
    }
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x7d57
// Size: 0x151
function function_9a3bef3ffef9c904( var_a65640524cb6c8dd )
{
    var_25ff9cceff399d80 = "";
    var_e1fac4e807047e1c = "";
    level.var_f1c340dae77ca15d = var_a65640524cb6c8dd;
    
    switch ( getgametype() )
    {
        case #"hash_ec086b911c1011ec":
            if ( isdefined( level.var_d27f667e6320d465 ) )
            {
                var_25ff9cceff399d80 = level.var_d27f667e6320d465.var_a1dee46f5965dafb;
                var_e1fac4e807047e1c = level.var_d27f667e6320d465.var_199b24846b757ebd;
            }
            else
            {
                var_25ff9cceff399d80 = "hr_allied_spawn";
                var_e1fac4e807047e1c = "hr_axis_spawn";
            }
            
            break;
        case #"hash_fa50b0f6bd82e972":
            if ( isdefined( level.var_d27f667e6320d465 ) )
            {
                var_25ff9cceff399d80 = level.var_d27f667e6320d465.var_8680ea7b41bdf4dc;
                var_e1fac4e807047e1c = level.var_d27f667e6320d465.var_388abe281afcd6f6;
            }
            else
            {
                var_25ff9cceff399d80 = "sd_allied_spawn";
                var_e1fac4e807047e1c = "sd_axis_spawn";
            }
            
            break;
        case #"hash_eb5e5f470e0c1dc2":
            if ( isdefined( level.var_d27f667e6320d465 ) )
            {
                var_25ff9cceff399d80 = level.var_d27f667e6320d465.var_ea715da3ce810864;
                var_e1fac4e807047e1c = level.var_d27f667e6320d465.var_8907b8ecb4694aae;
            }
            else
            {
                var_25ff9cceff399d80 = "cyber_allied_spawn";
                var_e1fac4e807047e1c = "cyber_axis_spawn";
            }
            
            break;
    }
    
    function_5d5267daeda595( var_25ff9cceff399d80, var_e1fac4e807047e1c );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 5
// Checksum 0x0, Offset: 0x7eb0
// Size: 0x127
function initspawnlist( spawnkey, spawntype, attackervalue, defendervalue, isoptional )
{
    if ( !isdefined( isoptional ) )
    {
        isoptional = 0;
    }
    
    assert( isdefined( level.spawnglobals.spawntypes[ spawntype ] ) );
    var_1321a74e5ce40775 = level.spawnglobals.spawntypes[ spawntype ];
    isfallback = spawntype == 2;
    [[ var_1321a74e5ce40775.func ]]( spawnkey, attackervalue, game[ "attackers" ], isoptional, isfallback );
    [[ var_1321a74e5ce40775.func ]]( spawnkey, defendervalue, game[ "defenders" ], isoptional, isfallback );
    
    if ( attackervalue == defendervalue )
    {
        registerspawnset( var_1321a74e5ce40775.setnames[ 0 ], getspawnpointarray( "mp_spawn_point", spawnkey, attackervalue ) );
        return;
    }
    
    registerspawnset( var_1321a74e5ce40775.setnames[ 1 ], getspawnpointarray( "mp_spawn_point", spawnkey, attackervalue ) );
    registerspawnset( var_1321a74e5ce40775.setnames[ 2 ], getspawnpointarray( "mp_spawn_point", spawnkey, defendervalue ) );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 7
// Checksum 0x0, Offset: 0x7fdf
// Size: 0x63
function initspawnlists( spawnkey, primary_attacker, primary_defender, start_attacker, start_defender, fallback_attacker, fallback_defender )
{
    initspawnlist( spawnkey, 1, start_attacker, start_defender );
    initspawnlist( spawnkey, 0, primary_attacker, primary_defender );
    initspawnlist( spawnkey, 2, fallback_attacker, fallback_defender, 1 );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 1
// Checksum 0x0, Offset: 0x804a
// Size: 0x38
function function_afe4709b818e7c9e( spawnkey )
{
    initspawnlists( spawnkey, "spawn", "spawn", "start_attacker", "start_defender", "fallback", "fallback" );
    function_48ed29b53fd72775();
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 3
// Checksum 0x0, Offset: 0x808a
// Size: 0x4e
function function_542d0780ea7c537d( spawningplayer, spawnteam, spawnparams )
{
    if ( spawnteam == game[ "attackers" ] )
    {
        return getspawnpoint( self, spawnteam, "start_attackers", "start_attackers", spawnparams );
    }
    
    return getspawnpoint( self, spawnteam, "start_defenders", "start_defenders", spawnparams );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 4
// Checksum 0x0, Offset: 0x80e1
// Size: 0xac
function function_768bb924a0a3b2e9( pair, team, primaryset, fallbackset )
{
    if ( !isdefined( level.spawnglobals.var_f36d416bc6168362 ) )
    {
        level.spawnglobals.var_f36d416bc6168362 = [];
    }
    
    if ( !isdefined( level.spawnglobals.var_f36d416bc6168362[ pair ] ) )
    {
        level.spawnglobals.var_f36d416bc6168362[ pair ] = [];
    }
    
    level.spawnglobals.var_f36d416bc6168362[ pair ][ team ] = { #fallback:fallbackset, #primary:primaryset };
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x8195
// Size: 0x6e
function function_48ed29b53fd72775()
{
    function_768bb924a0a3b2e9( "start", game[ "attackers" ], "start_attackers", undefined );
    function_768bb924a0a3b2e9( "start", game[ "defenders" ], "start_defenders", undefined );
    function_768bb924a0a3b2e9( "default", game[ "attackers" ], "primary", "fallback" );
    function_768bb924a0a3b2e9( "default", game[ "defenders" ], "primary", "fallback" );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 0
// Checksum 0x0, Offset: 0x820b
// Size: 0x6e
function function_437beaf209334ce2()
{
    function_768bb924a0a3b2e9( "start", game[ "attackers" ], "start_attackers", undefined );
    function_768bb924a0a3b2e9( "start", game[ "defenders" ], "start_defenders", undefined );
    function_768bb924a0a3b2e9( "default", game[ "attackers" ], "primary_attackers", "fallback_attackers" );
    function_768bb924a0a3b2e9( "default", game[ "defenders" ], "primary_defenders", "fallback_defenders" );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 4
// Checksum 0x0, Offset: 0x8281
// Size: 0xcc
function function_8be1c339876506b9( ent, pair, team, params )
{
    assert( isdefined( level.spawnglobals.var_f36d416bc6168362 ) );
    assert( isdefined( level.spawnglobals.var_f36d416bc6168362[ pair ] ) );
    assert( isdefined( level.spawnglobals.var_f36d416bc6168362[ pair ][ team ] ) );
    return getspawnpoint( ent, team, level.spawnglobals.var_f36d416bc6168362[ pair ][ team ].primary, level.spawnglobals.var_f36d416bc6168362[ pair ][ team ].fallback, undefined, params );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x8356
// Size: 0x87
function getspawnpointforplayer( player, params )
{
    pair = "default";
    factor_set = #"default";
    
    if ( shoulduseteamstartspawn() )
    {
        pair = "start";
        factor_set = #"start";
    }
    
    if ( function_bff229a11ecd1e34() )
    {
        if ( !isactivespawnlogic( factor_set ) )
        {
            setactivespawnlogic( factor_set );
        }
    }
    
    return function_8be1c339876506b9( player, pair, player.pers[ "team" ], params );
}

// Namespace spawnlogic / scripts\mp\spawnlogic
// Params 2
// Checksum 0x0, Offset: 0x83e6
// Size: 0x51, Type: bool
function function_b17bf43316b9fb08( spawnkey, spawnvalue )
{
    if ( !isdefined( spawnvalue ) )
    {
        spawnvalue = "spawn";
    }
    
    /#
        if ( getdvarint( @"hash_4dc85278508b1ec3", 0 ) != 0 )
        {
            return false;
        }
    #/
    
    var_c3d3bd79b9a86217 = scripts\mp\spawnlogic::function_5cb7f8468d3b9fe0( spawnkey, spawnvalue );
    return var_c3d3bd79b9a86217.size != 0;
}

