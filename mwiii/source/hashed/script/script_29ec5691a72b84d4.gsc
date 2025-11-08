#using scripts\common\callbacks;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\perk;

#namespace namespace_702fb5f6d0e65edf;

// Namespace namespace_702fb5f6d0e65edf / namespace_b09d1ea3e62b8710
// Params 0
// Checksum 0x0, Offset: 0x112
// Size: 0x70
function init()
{
    setdvarifuninitialized( @"hash_db219318c57c207c", 2 );
    setdvarifuninitialized( @"hash_5503b6abe9a578ef", 5 );
    setdvarifuninitialized( @"hash_514e71a29fd848df", 25 );
    setdvarifuninitialized( @"hash_d91cb66b19053d12", 10 );
    setdvarifuninitialized( @"hash_269a7fb521925fa5", 25 );
    thread onplayerspawned();
    callback::add( "player_death", &onplayerdeath );
}

// Namespace namespace_702fb5f6d0e65edf / namespace_b09d1ea3e62b8710
// Params 0
// Checksum 0x0, Offset: 0x18a
// Size: 0x41
function rewardassistpoints()
{
    killstreakpoints = setkillstreakpoints( getdvarint( @"hash_db219318c57c207c" ) );
    scripts\mp\killstreaks\killstreaks::givestreakpoints( #"assist", killstreakpoints, getdvarint( @"hash_d91cb66b19053d12" ) );
}

// Namespace namespace_702fb5f6d0e65edf / namespace_b09d1ea3e62b8710
// Params 0
// Checksum 0x0, Offset: 0x1d3
// Size: 0x41
function function_c3dfa7a42967be85()
{
    killstreakpoints = setkillstreakpoints( getdvarint( @"hash_5503b6abe9a578ef" ) );
    scripts\mp\killstreaks\killstreaks::givestreakpoints( #"kill", killstreakpoints, getdvarint( @"hash_269a7fb521925fa5" ) );
}

// Namespace namespace_702fb5f6d0e65edf / namespace_b09d1ea3e62b8710
// Params 1
// Checksum 0x0, Offset: 0x21c
// Size: 0xae
function setkillstreakpoints( var_6ab5606da9634c9a )
{
    self setclientomnvar( "ui_score_streak_assist_progress", 1 );
    
    if ( !isdefined( self.var_efc98476d30e7d4c ) )
    {
        self.var_efc98476d30e7d4c = var_6ab5606da9634c9a;
    }
    else
    {
        self.var_efc98476d30e7d4c += var_6ab5606da9634c9a;
    }
    
    killstreakpoints = 0;
    
    while ( self.var_efc98476d30e7d4c >= getdvarint( @"hash_514e71a29fd848df" ) )
    {
        self.var_efc98476d30e7d4c -= getdvarint( @"hash_514e71a29fd848df" );
        killstreakpoints += 1;
    }
    
    if ( killstreakpoints >= 1 )
    {
        self setclientomnvar( "ui_score_streak_assist_progress", 0 );
    }
    
    return killstreakpoints;
}

// Namespace namespace_702fb5f6d0e65edf / namespace_b09d1ea3e62b8710
// Params 0
// Checksum 0x0, Offset: 0x2d3
// Size: 0x32
function onplayerspawned()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player scripts\mp\utility\perk::giveperk( "specialty_chain_killstreaks" );
    }
}

// Namespace namespace_702fb5f6d0e65edf / namespace_b09d1ea3e62b8710
// Params 1
// Checksum 0x0, Offset: 0x30d
// Size: 0x22
function onplayerdeath( params )
{
    self.var_efc98476d30e7d4c = 0;
    self setclientomnvar( "ui_score_streak_assist_progress", 0 );
}

