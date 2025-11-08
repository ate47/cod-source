#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\utility;

#namespace execution;

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x579
// Size: 0x47, Type: bool
function function_1ea3e44fd8a18d1()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( isbot( self ) && getdvarint( @"hash_eb038ca43332e718", 0 ) == 0 )
    {
        return false;
    }
    
    if ( istestclient( self ) )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\game_utility::getgametype() == "warrior" )
    {
        return false;
    }
    
    return true;
}

// Namespace execution / scripts\cp_mp\execution
// Params 2
// Checksum 0x0, Offset: 0x5c9
// Size: 0x1a7
function _giveexecution( ref, isfirstperson )
{
    if ( !function_1ea3e44fd8a18d1() )
    {
        return;
    }
    
    if ( istrue( getdvarint( @"scr_loadout_validate_banned_items", 0 ) ) && scripts\cp_mp\utility\loot::function_8c610908c0e9c6e4( ref ) )
    {
        ref = scripts\cp_mp\operator::function_a9722d35258230d2( self.operatorcustomization.operatorref );
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
    
    if ( ref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western" )
    {
        propweapon = level.execution.table[ ref ].propweapon2;
    }
    
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
// Checksum 0x0, Offset: 0x778
// Size: 0x94
function _clearexecution( isfirstperson )
{
    if ( isdefined( self.executionref ) )
    {
        self clearexecution( istrue( isfirstperson ) );
        propweapon = execution_getpropweaponbyref( self.executionref );
        
        if ( self.executionref == "execution_062" && self.operatorcustomization.operatorref == "inarius_western" )
        {
            propweapon = "iw9_execution_spear_wings";
        }
        
        if ( isdefined( propweapon ) && self hasweapon( propweapon ) )
        {
            self takeweapon( propweapon );
        }
        
        self.executionref = undefined;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x814
// Size: 0xc, Type: bool
function hasexecution()
{
    return isdefined( self.executionref );
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x829
// Size: 0xf1
function execution_monitor()
{
    self notify( "exec_monitor_request" );
    self endon( "exec_monitor_request" );
    
    while ( true )
    {
        self waittill( "execution_begin", victiment );
        
        if ( isdefined( victiment ) && ( isplayer( victiment ) || isagent( victiment ) ) )
        {
            victiment notify( "execution_begin_victim" );
        }
        
        if ( isdefined( self.executionref ) && isdefined( self.suit ) )
        {
            thread function_e4ea09e7e5e2d5f1( victiment );
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
// Params 1
// Checksum 0x0, Offset: 0x922
// Size: 0x76e
function function_e4ea09e7e5e2d5f1( victiment )
{
    self endon( "death_or_disconnect" );
    self endon( "execution_stopped" );
    victiment endon( "disconnect" );
    
    if ( isai( victiment ) )
    {
        return;
    }
    
    var_ff5b782e4a5bcc05 = victiment getstance();
    
    switch ( self.executionref )
    {
        case #"hash_272e44a6335fe57":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce06", self );
                        break;
                    }
                    else
                    {
                        wait 2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce05", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_982264d83dbf6f8d":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.2;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce04", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce06", self );
                        break;
                    }
                    else
                    {
                        wait 2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce05", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_a12a71571e6da63":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce11", self );
                        break;
                    }
                    else
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce10", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_84b68933c178cd09":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce12", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce11", self );
                        break;
                    }
                    else
                    {
                        wait 1.6;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce10", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_108f7f3680e4cb4a":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 0.2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce02", self );
                        break;
                    }
                    else
                    {
                        wait 2.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce01", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_35045a42d684bc52":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.3;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce03", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 0.2;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce02", self );
                        break;
                    }
                    else
                    {
                        wait 2.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce01", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_279ef6d5b4d7862a":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce14", self );
                        break;
                    }
                    else
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce13", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_17f631e350a58072":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 1.7;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce15", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce14", self );
                        break;
                    }
                    else
                    {
                        wait 1.5;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce13", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_8d44865c9e264f78":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1.3;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce09", self );
                        break;
                    }
                    else
                    {
                        wait 2.8;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce08", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        case #"hash_f4ad44ebf245e754":
            switch ( var_ff5b782e4a5bcc05 )
            {
                case #"hash_c6775c88e38f7803":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_3fed0cbd303639eb":
                    wait 2.9;
                    self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce07", self );
                    break;
                case #"hash_d91940431ed7c605":
                    if ( istrue( victiment.inlaststand ) )
                    {
                        wait 1.3;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce09", self );
                        break;
                    }
                    else
                    {
                        wait 2.8;
                        self playsoundtoplayer( "dx_mp_mpce_cste_ctrd_ce08", self );
                        break;
                    }
                default:
                    break;
            }
            
            break;
        default:
            break;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x1098
// Size: 0x8e
function execution_init()
{
    assertex( !isdefined( level.execution ), "<dev string:x3c>" );
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
// Checksum 0x0, Offset: 0x112e
// Size: 0x9
function enableexecutionattackwrapper()
{
    self enableexecutionattack();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x113f
// Size: 0x9
function disableexecutionattackwrapper()
{
    self disableexecutionattack();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x1150
// Size: 0x9
function enableexecutionvictimwrapper()
{
    self enableexecutionvictim();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x1161
// Size: 0x9
function disableexecutionvictimwrapper()
{
    self disableexecutionvictim();
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x1172
// Size: 0x1a2
function execution_loadtable()
{
    level.execution.table = [];
    
    foreach ( executionref in scripts\cp_mp\operator::function_232a4826a2bd2bfd() )
    {
        struct = spawnstruct();
        struct.ref = executionref;
        id = scripts\cp_mp\operator::function_3daf6bb451cf826e( executionref );
        assertex( isdefined( id ), "<dev string:x69>" + executionref + "<dev string:x82>" );
        struct.id = int( id );
        execution = scripts\cp_mp\operator::function_75322d3c8f9c9ccb( executionref );
        assertex( isdefined( execution ) && execution != "<dev string:x92>", "<dev string:x69>" + executionref + "<dev string:x96>" );
        
        if ( execution != "none" )
        {
            struct.execution = execution;
        }
        
        propweapon = scripts\cp_mp\operator::function_3bd82b573b8f64f3( executionref );
        assertex( isdefined( propweapon ) && propweapon != "<dev string:x92>", "<dev string:x69>" + executionref + "<dev string:xad>" );
        
        if ( propweapon != "none" )
        {
            struct.propweapon = makeweapon( propweapon );
            
            if ( execution == "execution_062" )
            {
                struct.propweapon2 = "iw9_execution_spear_wings";
            }
            
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
// Checksum 0x0, Offset: 0x131c
// Size: 0x56
function execution_getexecutionbyref( ref )
{
    assertex( isdefined( level.execution ), "<dev string:xc6>" );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.execution;
    }
    
    return undefined;
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x137b
// Size: 0x56
function execution_getpropweaponbyref( ref )
{
    assertex( isdefined( level.execution ), "<dev string:x103>" );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.propweapon;
    }
    
    return undefined;
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x13da
// Size: 0x16
function execution_getrefbyplayer( player )
{
    return player.executionref;
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x13f9
// Size: 0x55
function execution_getidbyref( ref )
{
    assertex( isdefined( level.execution ), "<dev string:x141>" );
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return struct.id;
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 1
// Checksum 0x0, Offset: 0x1456
// Size: 0x5d
function function_700277400dcb7857( ref )
{
    assertex( isdefined( level.execution ), "<dev string:x141>" );
    
    if ( !isdefined( ref ) )
    {
        return 0;
    }
    
    struct = level.execution.table[ ref ];
    
    if ( isdefined( struct ) )
    {
        return istrue( struct.petenabled );
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x14bb
// Size: 0x15
function function_43a90e553f84c31c()
{
    scripts\common\values::set( "pet_execution", "hide_operator_backpack", 1 );
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x14d8
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
// Checksum 0x0, Offset: 0x154d
// Size: 0x8a
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
                self notify( "execution_stopped" );
            }
        }
        
        var_a9ee87cc06bd6b39 = inexecution;
        waitframe();
    }
}

// Namespace execution / scripts\cp_mp\execution
// Params 0
// Checksum 0x0, Offset: 0x15df
// Size: 0x12, Type: bool
function is_in_takedown()
{
    return self isinexecutionvictim() || self isinexecutionattack();
}

