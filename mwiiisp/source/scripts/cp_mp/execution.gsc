#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\operator;
#using scripts\engine\utility;

#namespace execution;

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x28a
// Size: 0x2f, Type: bool
function function_1ea3e44fd8a18d1()
{
    if ( isbot( self ) && getdvarint( @"hash_eb038ca43332e718", 0 ) == 0 )
    {
        return false;
    }
    
    if ( istestclient( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace execution / scripts\cp_mp\execution
// Params 2
// Checksum 0x0, Offset: 0x2c2
// Size: 0x127
function _giveexecution( ref, isfirstperson )
{
    if ( !function_1ea3e44fd8a18d1() )
    {
        return;
    }
    
    thread execution_monitor();
    
    if ( isesportsservercontext() )
    {
        var_25a38dfaf37fc298 = tolower( getdvar( @"hash_88ba4ca6e5ff9d5a", "" ) );
        
        if ( isdefined( level.execution.table[ var_25a38dfaf37fc298 ] ) )
        {
            ref = var_25a38dfaf37fc298;
        }
    }
    
    _clearexecution( istrue( isfirstperson ) );
    propweapon = execution_getpropweaponbyref( ref );
    execution = execution_getexecutionbyref( ref );
    assertex( isdefined( execution ), "<dev string:x1c>" + ref );
    
    if ( !isdefined( execution ) )
    {
        return;
    }
    
    if ( isdefined( propweapon ) )
    {
        self giveweapon( propweapon );
        self giveexecution( execution, propweapon, istrue( isfirstperson ) );
    }
    else
    {
        self giveexecution( execution, undefined, istrue( isfirstperson ) );
    }
    
    if ( istrue( function_700277400dcb7857( ref ) ) )
    {
        function_43a90e553f84c31c();
    }
    
    self.executionref = ref;
    
    if ( issharedfuncdefined( "game", "lpcFeatureGated" ) && ![[ getsharedfunc( "game", "lpcFeatureGated" ) ]]() )
    {
        thread watchinexecution();
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x3f1
// Size: 0x5d
function _clearexecution( isfirstperson )
{
    if ( isdefined( self.executionref ) )
    {
        self clearexecution( istrue( isfirstperson ) );
        propweapon = execution_getpropweaponbyref( self.executionref );
        
        if ( isdefined( propweapon ) && self hasweapon( propweapon ) )
        {
            self takeweapon( propweapon );
        }
        
        self.executionref = undefined;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x456
// Size: 0xc, Type: bool
function hasexecution()
{
    return isdefined( self.executionref );
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x46b
// Size: 0xc7
function execution_monitor()
{
    self notify( "exec_monitor_request" );
    self endon( "exec_monitor_request" );
    
    while ( true )
    {
        self waittill( "execution_begin", victiment );
        
        if ( isdefined( self.executionref ) && isdefined( self.suit ) )
        {
            aliasstring = "mus_" + self.suit + "_" + self.executionref;
            
            if ( soundexists( aliasstring ) )
            {
                self playlocalsound( aliasstring );
                victiment playlocalsound( aliasstring );
            }
        }
        
        if ( isdefined( victiment ) )
        {
            if ( isdefined( victiment.basearchetype ) && victiment.basearchetype == "zombie_base" )
            {
                victiment setentitysoundcontext( "gender", "zombie" );
            }
        }
        
        wait 2;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x53a
// Size: 0x8e
function execution_init()
{
    assertex( !isdefined( level.execution ), "execution_init was called more than once." );
    level.execution = spawnstruct();
    level.enableexecutionattackfunc = &enableexecutionattackwrapper;
    level.disableexecutionattackfunc = &disableexecutionattackwrapper;
    level.enableexecutionvictimfunc = &enableexecutionvictimwrapper;
    level.disableexecutionvictimfunc = &disableexecutionvictimwrapper;
    execution_loadtable();
    
    if ( issharedfuncdefined( "execution", "init" ) )
    {
        [[ getsharedfunc( "execution", "init" ) ]]();
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x5d0
// Size: 0x9
function enableexecutionattackwrapper()
{
    self enableexecutionattack();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x5e1
// Size: 0x9
function disableexecutionattackwrapper()
{
    self disableexecutionattack();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x5f2
// Size: 0x9
function enableexecutionvictimwrapper()
{
    self enableexecutionvictim();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x603
// Size: 0x9
function disableexecutionvictimwrapper()
{
    self disableexecutionvictim();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x614
// Size: 0x188
function execution_loadtable()
{
    level.execution.table = [];
    
    foreach ( executionref in scripts\cp_mp\operator::function_232a4826a2bd2bfd() )
    {
        struct = spawnstruct();
        struct.ref = executionref;
        id = scripts\cp_mp\operator::function_3daf6bb451cf826e( executionref );
        assertex( isdefined( id ), "Executions error -  \"" + executionref + "\" has no id." );
        struct.id = int( id );
        execution = scripts\cp_mp\operator::function_75322d3c8f9c9ccb( executionref );
        assertex( isdefined( execution ) && execution != "", "Executions error -  \"" + executionref + "\" has no execution." );
        
        if ( execution != "none" )
        {
            struct.execution = execution;
        }
        
        propweapon = scripts\cp_mp\operator::function_3bd82b573b8f64f3( executionref );
        assertex( isdefined( propweapon ) && propweapon != "", "Executions error -  \"" + executionref + "\" has no prop weapon." );
        
        if ( propweapon != "none" )
        {
            struct.propweapon = makeweapon( propweapon );
            
            if ( isnullweapon( struct.propweapon ) )
            {
                continue;
            }
        }
        
        level.execution.table[ executionref ] = struct;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x7a4
// Size: 0x55
function execution_getexecutionbyref( ref )
{
    assertex( isdefined( level.execution ), "execution_getExecutionByRef called before execution_init." );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.execution;
    }
    
    return undefined;
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x802
// Size: 0x55
function execution_getpropweaponbyref( ref )
{
    assertex( isdefined( level.execution ), "execution_getPropWeaponByRef called before execution_init." );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.propweapon;
    }
    
    return undefined;
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x860
// Size: 0x16
function execution_getrefbyplayer( player )
{
    return player.executionref;
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x87f
// Size: 0x54
function execution_getidbyref( ref )
{
    assertex( isdefined( level.execution ), "execution_getIDByRef called before execution_init." );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.id;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x8db
// Size: 0x54
function function_700277400dcb7857( ref )
{
    assertex( isdefined( level.execution ), "execution_getIDByRef called before execution_init." );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.petenabled;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x937
// Size: 0x15
function function_43a90e553f84c31c()
{
    scripts\common\values::set( "pet_execution", "hide_operator_backpack", 1 );
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x954
// Size: 0x6d
function execution_blockladders()
{
    if ( self isonladder() )
    {
        if ( !istrue( self.ladderexecutionblocked ) )
        {
            val::set( "ladderExecution", "execution_attack", 0 );
            val::set( "ladderExecution", "execution_victim", 0 );
            self.ladderexecutionblocked = 1;
        }
        
        return;
    }
    
    if ( istrue( self.ladderexecutionblocked ) )
    {
        val::reset_all( "ladderExecution" );
        self.ladderexecutionblocked = undefined;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x9c9
// Size: 0x82
function watchinexecution()
{
    self endon( "disconnect" );
    self notify( "watchInExecution" );
    self endon( "watchInExecution" );
    var_a9ee87cc06bd6b39 = 0;
    
    while ( true )
    {
        inexecution = self isinexecutionattack() || self isinexecutionvictim();
        
        if ( inexecution != var_a9ee87cc06bd6b39 && !scripts\common\utility::isusingremote() )
        {
            if ( inexecution )
            {
                self enablephysicaldepthoffieldscripting();
                self setphysicaldepthoffield( 2.5, 60, 20, 20 );
            }
            else
            {
                self disablephysicaldepthoffieldscripting();
            }
        }
        
        var_a9ee87cc06bd6b39 = inexecution;
        waitframe();
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0xa53
// Size: 0x12, Type: bool
function is_in_takedown()
{
    return self isinexecutionvictim() || self isinexecutionattack();
}

