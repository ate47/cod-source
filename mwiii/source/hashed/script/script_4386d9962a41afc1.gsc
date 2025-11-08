#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_41387eecc35b88bf;
#using scripts\common\devgui;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\teams;

#namespace activity_voting;

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 1
// Checksum 0x0, Offset: 0x17f
// Size: 0x5b
function function_60a8777312cc62d7( player )
{
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    focusedactivity = function_deb5a4d2a7bda5e9( player );
    
    if ( !isdefined( focusedactivity ) )
    {
        println( "<dev string:x5f>" + "<dev string:xbf>" + "<dev string:x115>" );
        return;
    }
    
    function_90edaba623c87c34( focusedactivity, player );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2
// Checksum 0x0, Offset: 0x1e2
// Size: 0x71
function function_90edaba623c87c34( activityinstance, player )
{
    if ( !function_6ebc53f792333cf5( activityinstance, player ) )
    {
        return;
    }
    
    function_6a99c0e5fb21729c( activityinstance );
    
    if ( function_e9433db9d33e1279( activityinstance, player ) )
    {
        println( "<dev string:x130>" );
        return;
    }
    
    function_abaa57eec7d4c532( activityinstance, player );
    var_606f34fc1ead5c7a = function_16e0486e6ff0b40f( activityinstance, player );
    function_ddc88c261e9b3637( activityinstance, player, var_606f34fc1ead5c7a );
    function_55038a5fbb28f66c( activityinstance, player );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2
// Checksum 0x0, Offset: 0x25b
// Size: 0x4f
function function_c9afc8e2fd64917( activityinstance, player )
{
    if ( !function_6ebc53f792333cf5( activityinstance, player ) )
    {
        return;
    }
    
    function_6a99c0e5fb21729c( activityinstance );
    
    if ( function_a10d5774bdcd3b0a( activityinstance, player ) )
    {
        function_23516e860dddbf1b( activityinstance, player );
        function_abaa57eec7d4c532( activityinstance, player );
        function_55038a5fbb28f66c( activityinstance, player, 1 );
    }
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2
// Checksum 0x0, Offset: 0x2b2
// Size: 0x3b
function function_df7f1a29325af528( activityinstance, player )
{
    if ( !function_6ebc53f792333cf5( activityinstance, player ) )
    {
        return;
    }
    
    function_6a99c0e5fb21729c( activityinstance );
    
    if ( function_a10d5774bdcd3b0a( activityinstance, player ) )
    {
        function_30b211b56a55ca0b( activityinstance, player );
    }
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2
// Checksum 0x0, Offset: 0x2f5
// Size: 0x3e
function function_2086dfaf421ea734( activityinstance, player )
{
    if ( !isdefined( activityinstance ) )
    {
        println( "<dev string:x199>" );
        return;
    }
    
    function_a68f6703c78f0051( activityinstance, player );
    function_bbbdd2dc3be2f04d( activityinstance, player, "ActivityVoteResult_Cancelled" );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2
// Checksum 0x0, Offset: 0x33b
// Size: 0x39, Type: bool
function function_a10d5774bdcd3b0a( activityinstance, player )
{
    if ( !isdefined( activityinstance ) || !isdefined( activityinstance.var_ced013ef63e76a7b ) )
    {
        return false;
    }
    
    return function_2a87b98d1f58ddbc( activityinstance, player ) == "ActivityVoteResult_InProgress";
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2
// Checksum 0x0, Offset: 0x37d
// Size: 0x3b
function function_5a840337aed72780( activityinstance, votingpoolsize )
{
    relevantinfostruct = spawnstruct();
    relevantinfostruct.votingpoolsize = votingpoolsize;
    return runactivityfunction( activityinstance, 8, relevantinfostruct );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 1
// Checksum 0x0, Offset: 0x3c1
// Size: 0x26
function function_2d4b61447e3a46b0( relevantinfostruct )
{
    assertex( isdefined( relevantinfostruct ), "<dev string:x1e4>" );
    return relevantinfostruct.votingpoolsize;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3f0
// Size: 0x83
function private function_ddc88c261e9b3637( activityinstance, player, var_606f34fc1ead5c7a )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_f90897ff85a28f1a( activityinstance, player );
    voterpool = function_37ffb7a5350616ca( player );
    var_7f59d74a1e866246 = function_355cd23c6cbf8dda( activityinstance, votename, votes, voterpool, player, var_606f34fc1ead5c7a );
    announceactivitymoment( activityinstance, "VoteCast", var_7f59d74a1e866246 );
    
    /#
        function_26b72cfbd71e82f( activityinstance, player );
    #/
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x47b
// Size: 0x82
function private function_bbbdd2dc3be2f04d( activityinstance, player, voteresult )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_f90897ff85a28f1a( activityinstance, player );
    voterpool = function_37ffb7a5350616ca( player );
    var_7570a1bf222e764 = function_53a3019fd9a570ee( activityinstance, votename, votes, voterpool, voteresult );
    announceactivitymoment( activityinstance, "VoteEnd", var_7570a1bf222e764 );
    
    /#
        function_fc57b4e33ab348a4( activityinstance, player );
    #/
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x505
// Size: 0x76
function private function_23516e860dddbf1b( activityinstance, player )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_f90897ff85a28f1a( activityinstance, player );
    voterpool = function_37ffb7a5350616ca( player );
    var_67254a043c6e16a2 = function_7bd0928341049890( activityinstance, votename, votes, voterpool, player );
    announceactivitymoment( activityinstance, "VoterLeft", var_67254a043c6e16a2 );
    
    /#
        function_a03ac72779102a0d( activityinstance, player );
    #/
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x583
// Size: 0x76
function private function_30b211b56a55ca0b( activityinstance, player )
{
    votename = "ActivityVoteName_SquadAbandonVote";
    votes = function_f90897ff85a28f1a( activityinstance, player );
    voterpool = function_37ffb7a5350616ca( player );
    var_4cde85e68dd32e22 = function_8873bece95ecf770( activityinstance, votename, votes, voterpool, player );
    announceactivitymoment( activityinstance, "VoterJoined", var_4cde85e68dd32e22 );
    
    /#
        function_3408f40ca8f1c14d( activityinstance, player );
    #/
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x601
// Size: 0x5a, Type: bool
function private function_6ebc53f792333cf5( activityinstance, player )
{
    if ( !isdefined( activityinstance ) )
    {
        println( "<dev string:x241>" );
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x2b7>" );
        return false;
    }
    
    if ( !isdefined( function_2ff949964e3aa834( player ) ) )
    {
        assertmsg( "<dev string:x2e8>" );
        return false;
    }
    
    return true;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x664
// Size: 0x2d
function private function_6a99c0e5fb21729c( activityinstance )
{
    if ( isdefined( activityinstance ) && !isdefined( activityinstance.var_ced013ef63e76a7b ) )
    {
        activityinstance.var_ced013ef63e76a7b = [];
    }
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x699
// Size: 0x4e
function private function_abaa57eec7d4c532( activityinstance, player )
{
    squadid = function_2ff949964e3aa834( player );
    abandonvotes = function_f90897ff85a28f1a( activityinstance, player );
    activityinstance.var_ced013ef63e76a7b[ squadid ] = function_8f9a51144ea9439( abandonvotes, player );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x6ef
// Size: 0x7a
function private function_55038a5fbb28f66c( activityinstance, player, isplayerleavingvote )
{
    if ( !isdefined( isplayerleavingvote ) )
    {
        isplayerleavingvote = 0;
    }
    
    voteresult = function_2a87b98d1f58ddbc( activityinstance, player, isplayerleavingvote );
    
    if ( voteresult == "ActivityVoteResult_Success" )
    {
        function_bbbdd2dc3be2f04d( activityinstance, player, "ActivityVoteResult_Success" );
        function_a68f6703c78f0051( activityinstance, player );
        function_cfc0a56c1b2b3bd8( activityinstance, player );
    }
    else if ( voteresult == "ActivityVoteResult_Cancelled" )
    {
        function_2086dfaf421ea734( activityinstance, player );
    }
    
    return voteresult;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x772
// Size: 0x53
function private function_2a87b98d1f58ddbc( activityinstance, player, isplayerleavingvote )
{
    if ( !isdefined( isplayerleavingvote ) )
    {
        isplayerleavingvote = 0;
    }
    
    if ( function_16e0486e6ff0b40f( activityinstance, player ) )
    {
        return "ActivityVoteResult_Success";
    }
    
    if ( function_effade86a709128b( activityinstance, player, isplayerleavingvote ) )
    {
        return "ActivityVoteResult_Cancelled";
    }
    
    return "ActivityVoteResult_InProgress";
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x7cd
// Size: 0x3a
function private function_f90897ff85a28f1a( activityinstance, player )
{
    squadid = function_2ff949964e3aa834( player );
    return default_to( activityinstance.var_ced013ef63e76a7b[ squadid ], [] );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x810
// Size: 0x4a
function private function_a68f6703c78f0051( activityinstance, player )
{
    if ( !isdefined( activityinstance.var_ced013ef63e76a7b ) )
    {
        function_6a99c0e5fb21729c( activityinstance );
    }
    
    squadid = function_2ff949964e3aa834( player );
    activityinstance.var_ced013ef63e76a7b[ squadid ] = undefined;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x862
// Size: 0x2f
function private function_e9433db9d33e1279( activityinstance, player )
{
    var_685116b63258d4a8 = function_f90897ff85a28f1a( activityinstance, player );
    return array_contains( var_685116b63258d4a8, player );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x89a
// Size: 0x4e, Type: bool
function private function_16e0486e6ff0b40f( activityinstance, player )
{
    squadvotecount = function_287b76a301747f8b( activityinstance, player );
    squadmates = function_37ffb7a5350616ca( player );
    var_be9b3cf0ecae71c3 = function_5a840337aed72780( activityinstance, squadmates.size );
    return squadvotecount >= var_be9b3cf0ecae71c3;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x8f1
// Size: 0x4a, Type: bool
function private function_effade86a709128b( activityinstance, player, isplayerleavingvote )
{
    if ( !isdefined( isplayerleavingvote ) )
    {
        isplayerleavingvote = 0;
    }
    
    votes = function_1b00dbbd01a915b0( activityinstance, player );
    
    if ( isplayerleavingvote )
    {
        votes = array_remove( votes, player );
    }
    
    return votes.size == 0;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x944
// Size: 0x1c
function private function_287b76a301747f8b( activityinstance, player )
{
    return function_1b00dbbd01a915b0( activityinstance, player ).size;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x969
// Size: 0x40
function private function_1b00dbbd01a915b0( activityinstance, player )
{
    squadvotes = function_f90897ff85a28f1a( activityinstance, player );
    squadmates = function_37ffb7a5350616ca( player );
    return function_50eabc100130bc0d( squadvotes, squadmates );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9b2
// Size: 0x65
function private function_37ffb7a5350616ca( player )
{
    /#
        if ( isdefined( level.var_6acae859049cee46 ) )
        {
            return level.var_6acae859049cee46[ player.team ][ player.sessionsquadid ].players;
        }
    #/
    
    return scripts\mp\utility\teams::getsquadmates( player.team, player.sessionsquadid, 1 );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa20
// Size: 0x16
function private function_2ff949964e3aa834( player )
{
    return player.sessionsquadid;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xa3f
// Size: 0x1b
function private function_8f9a51144ea9439( votes, voter )
{
    return function_6d6af8144a5131f1( votes, voter );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xa63
// Size: 0x45
function private function_50eabc100130bc0d( votes, voterpool )
{
    if ( !isdefined( votes ) )
    {
        assertmsg( "<dev string:x358>" );
        return [];
    }
    
    if ( !isdefined( voterpool ) )
    {
        assertmsg( "<dev string:x384>" );
        return [];
    }
    
    return array_intersection( votes, voterpool );
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xab1
// Size: 0x1c
function private function_2161d9e590b59c26( votes, voterpool )
{
    return function_50eabc100130bc0d( votes, voterpool ).size;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0xad6
// Size: 0x85
function private function_d573f6bacfd88ce1( activityinstance, votename, votes, voterpool )
{
    var_829045d6a6fb2398 = spawnstruct();
    var_829045d6a6fb2398.activityinstance = default_to( activityinstance, undefined );
    var_829045d6a6fb2398.votename = default_to( votename, undefined );
    var_829045d6a6fb2398.votes = function_50eabc100130bc0d( votes, voterpool );
    var_829045d6a6fb2398.voterpool = default_to( voterpool, [] );
    return var_829045d6a6fb2398;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0xb64
// Size: 0x73
function private function_355cd23c6cbf8dda( activityinstance, votename, votes, voterpool, voter, var_606f34fc1ead5c7a )
{
    var_8a524fffb1608986 = function_d573f6bacfd88ce1( activityinstance, votename, votes, voterpool );
    var_8a524fffb1608986.voter = default_to( voter, undefined );
    var_8a524fffb1608986.var_606f34fc1ead5c7a = default_to( var_606f34fc1ead5c7a, undefined );
    return var_8a524fffb1608986;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xbe0
// Size: 0x56
function private function_53a3019fd9a570ee( activityinstance, votename, votes, voterpool, voteresult )
{
    var_1b80ce1214a34892 = function_d573f6bacfd88ce1( activityinstance, votename, votes, voterpool );
    var_1b80ce1214a34892.voteresult = default_to( voteresult, undefined );
    return var_1b80ce1214a34892;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xc3f
// Size: 0x4f
function private function_7bd0928341049890( activityinstance, votename, votes, voterpool, var_221836e6a7cb1ba2 )
{
    var_77b0135065515fcc = function_d573f6bacfd88ce1( activityinstance, votename, votes, voterpool );
    var_77b0135065515fcc.var_221836e6a7cb1ba2 = var_221836e6a7cb1ba2;
    return var_77b0135065515fcc;
}

// Namespace activity_voting / namespace_6854ffbed339ca49
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xc97
// Size: 0x4f
function private function_8873bece95ecf770( activityinstance, votename, votes, voterpool, var_335006ae8b51467a )
{
    var_21e6bf5f655206fc = function_d573f6bacfd88ce1( activityinstance, votename, votes, voterpool );
    var_21e6bf5f655206fc.var_335006ae8b51467a = var_335006ae8b51467a;
    return var_21e6bf5f655206fc;
}

/#

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xcef
    // Size: 0x79, Type: dev
    function private function_26b72cfbd71e82f( activityinstance, player )
    {
        squadmates = function_37ffb7a5350616ca( player );
        numvotes = function_287b76a301747f8b( activityinstance, player );
        println( "<dev string:x3b4>" + "<dev string:x3d9>" + getactivitytype( activityinstance ) + "<dev string:x3f1>" + function_a4748b32a824c79c( activityinstance ) + "<dev string:x401>" + numvotes + "<dev string:x411>" + squadmates.size + "<dev string:x422>" );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xd70
    // Size: 0x55, Type: dev
    function private function_fc57b4e33ab348a4( activityinstance, player )
    {
        println( "<dev string:x434>" + "<dev string:x3d9>" + getactivitytype( activityinstance ) + "<dev string:x3f1>" + function_a4748b32a824c79c( activityinstance ) + "<dev string:x45f>" + player.sessionsquadid + "<dev string:x46b>" );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xdcd
    // Size: 0x79, Type: dev
    function private function_a03ac72779102a0d( activityinstance, player )
    {
        squadmates = function_37ffb7a5350616ca( player );
        numvotes = function_287b76a301747f8b( activityinstance, player );
        println( "<dev string:x48a>" + "<dev string:x3d9>" + getactivitytype( activityinstance ) + "<dev string:x3f1>" + function_a4748b32a824c79c( activityinstance ) + "<dev string:x401>" + numvotes + "<dev string:x411>" + squadmates.size + "<dev string:x422>" );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xe4e
    // Size: 0x79, Type: dev
    function private function_3408f40ca8f1c14d( activityinstance, player )
    {
        squadmates = function_37ffb7a5350616ca( player );
        numvotes = function_287b76a301747f8b( activityinstance, player );
        println( "<dev string:x4c6>" + "<dev string:x3d9>" + getactivitytype( activityinstance ) + "<dev string:x3f1>" + function_a4748b32a824c79c( activityinstance ) + "<dev string:x401>" + numvotes + "<dev string:x411>" + squadmates.size + "<dev string:x422>" );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0
    // Checksum 0x0, Offset: 0xecf
    // Size: 0x1b4, Type: dev
    function function_781d567ca3db5852()
    {
        function_6e7290c8ee4f558b( "<dev string:x500>" );
        function_a9a864379a098ad6( "<dev string:x526>", "<dev string:x54a>", &function_5f5e9bf7fe8e6eaf );
        function_a9a864379a098ad6( "<dev string:x56f>", "<dev string:x59a>", &function_6017dcd09f997b8 );
        function_fe953f000498048f();
        function_6e7290c8ee4f558b( "<dev string:x5c2>" );
        function_a9a864379a098ad6( "<dev string:x5fd>", "<dev string:x616>", &function_d822738c9392a3a4 );
        function_a9a864379a098ad6( "<dev string:x62d>", "<dev string:x54a>", &function_5f5e9bf7fe8e6eaf );
        function_a9a864379a098ad6( "<dev string:x658>", "<dev string:x68d>", &function_20715510ce25c247 );
        function_a9a864379a098ad6( "<dev string:x6bf>", "<dev string:x6f4>", &function_20715610ce25c47a );
        function_a9a864379a098ad6( "<dev string:x726>", "<dev string:x75b>", &function_20715710ce25c6ad );
        function_a9a864379a098ad6( "<dev string:x78d>", "<dev string:x7b2>", &function_3f8bf4c34fe29837 );
        function_a9a864379a098ad6( "<dev string:x7cc>", "<dev string:x7f1>", &function_3f8bf5c34fe29a6a );
        function_a9a864379a098ad6( "<dev string:x80b>", "<dev string:x830>", &function_3f8bf6c34fe29c9d );
        function_a9a864379a098ad6( "<dev string:x84a>", "<dev string:x874>", &function_602310868171d271 );
        function_a9a864379a098ad6( "<dev string:x88c>", "<dev string:x8b7>", &function_e30f9ce33ee435dc );
        function_fe953f000498048f();
        function_6e7290c8ee4f558b( "<dev string:x8d0>" );
        function_a9a864379a098ad6( "<dev string:x90a>", "<dev string:x93f>", &_info );
        function_a9a864379a098ad6( "<dev string:x62d>", "<dev string:x54a>", &function_5f5e9bf7fe8e6eaf );
        function_a9a864379a098ad6( "<dev string:x948>", "<dev string:x974>", &function_da02cb35301e149c );
        function_a9a864379a098ad6( "<dev string:x9a1>", "<dev string:x9cd>", &function_da02ce35301e1b35 );
        function_a9a864379a098ad6( "<dev string:x9fa>", "<dev string:xa26>", &function_da02cd35301e1902 );
        function_fe953f000498048f();
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x108b
    // Size: 0x6, Type: dev
    function private _info()
    {
                return;
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1099
    // Size: 0x2e, Type: dev
    function private function_5f5e9bf7fe8e6eaf()
    {
        hostplayer = gethostplayer();
        
        if ( isdefined( hostplayer ) && isplayer( hostplayer ) )
        {
            function_60a8777312cc62d7( hostplayer );
        }
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x10cf
    // Size: 0x4c, Type: dev
    function private function_da02cb35301e149c()
    {
        player = level.players[ 1 ];
        
        if ( isdefined( player ) )
        {
            hostplayer = gethostplayer();
            var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9( hostplayer );
            function_90edaba623c87c34( var_9a57b22168b90b20, player );
        }
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1123
    // Size: 0x4c, Type: dev
    function private function_da02ce35301e1b35()
    {
        player = level.players[ 2 ];
        
        if ( isdefined( player ) )
        {
            hostplayer = gethostplayer();
            var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9( hostplayer );
            function_90edaba623c87c34( var_9a57b22168b90b20, player );
        }
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1177
    // Size: 0x4c, Type: dev
    function private function_da02cd35301e1902()
    {
        player = level.players[ 3 ];
        
        if ( isdefined( player ) )
        {
            hostplayer = gethostplayer();
            var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9( hostplayer );
            function_90edaba623c87c34( var_9a57b22168b90b20, player );
        }
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x11cb
    // Size: 0x4b, Type: dev
    function private function_6017dcd09f997b8()
    {
        hostplayer = gethostplayer();
        
        if ( isdefined( hostplayer ) && isplayer( hostplayer ) )
        {
            var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9( hostplayer );
            function_2086dfaf421ea734( var_9a57b22168b90b20, hostplayer );
            iprintlnbold( "<dev string:xa53>" );
        }
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x121e
    // Size: 0x4d, Type: dev
    function private function_d822738c9392a3a4()
    {
        function_d03304e5566c46d( 1 );
        var_15aaab03bcacac6b = 3;
        
        for ( i = 0; i < var_15aaab03bcacac6b ; i++ )
        {
            function_ad8674854251fb51();
        }
        
        iprintlnbold( "<dev string:xa8d>" + var_15aaab03bcacac6b + "<dev string:xa97>" );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x1273
    // Size: 0xb7, Type: dev
    function private function_d03304e5566c46d( force )
    {
        if ( !isdefined( force ) )
        {
            force = 0;
        }
        
        if ( !force || isdefined( level.var_6acae859049cee46 ) )
        {
            return;
        }
        
        hostplayer = gethostplayer();
        level.var_6acae859049cee46 = [];
        level.var_6acae859049cee46[ hostplayer.team ] = [];
        level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ] = spawnstruct();
        level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players = [ hostplayer ];
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1332
    // Size: 0xf8, Type: dev
    function private function_ad8674854251fb51()
    {
        level.var_4f695def88a58b60 = default_to( level.var_4f695def88a58b60, 1 );
        hostplayer = gethostplayer();
        fakeplayer = spawnstruct();
        fakeplayer.sessionsquadid = hostplayer.sessionsquadid;
        fakeplayer.team = hostplayer.team;
        fakeplayer.fakeid = level.var_4f695def88a58b60;
        players = level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players;
        level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players = array_add( players, fakeplayer );
        level.var_4f695def88a58b60++;
        return fakeplayer;
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1432
    // Size: 0x48, Type: dev
    function private function_602310868171d271()
    {
        function_d03304e5566c46d();
        hostplayer = gethostplayer();
        fakeplayer = function_ad8674854251fb51();
        var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9( hostplayer );
        function_df7f1a29325af528( var_9a57b22168b90b20, fakeplayer );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x1482
    // Size: 0x8b, Type: dev
    function private function_43f82d766b25b7b( fakesquadmemberindex )
    {
        if ( !isdefined( level.var_6acae859049cee46 ) )
        {
            return;
        }
        
        hostplayer = gethostplayer();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        squadmember = level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players[ fakesquadmemberindex ];
        
        if ( !isdefined( squadmember ) )
        {
            return;
        }
        
        var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9( hostplayer );
        function_90edaba623c87c34( var_9a57b22168b90b20, squadmember );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1515
    // Size: 0xe, Type: dev
    function private function_20715510ce25c247()
    {
        function_43f82d766b25b7b( 1 );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x152b
    // Size: 0xe, Type: dev
    function private function_20715610ce25c47a()
    {
        function_43f82d766b25b7b( 2 );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1541
    // Size: 0xe, Type: dev
    function private function_20715710ce25c6ad()
    {
        function_43f82d766b25b7b( 3 );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x1557
    // Size: 0x134, Type: dev
    function private function_e30f9ce33ee435dc( fakesquadmemberindex )
    {
        if ( !isdefined( level.var_6acae859049cee46 ) )
        {
            return;
        }
        
        hostplayer = gethostplayer();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        fakesquadmemberindex = default_to( fakesquadmemberindex, level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players.size - 1 );
        squadmember = level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players[ fakesquadmemberindex ];
        
        if ( !isdefined( squadmember ) || squadmember == hostplayer )
        {
            return;
        }
        
        var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9( hostplayer );
        function_c9afc8e2fd64917( var_9a57b22168b90b20, squadmember );
        players = level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players;
        level.var_6acae859049cee46[ hostplayer.team ][ hostplayer.sessionsquadid ].players = array_remove( players, squadmember );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1693
    // Size: 0xe, Type: dev
    function private function_3f8bf4c34fe29837()
    {
        function_e30f9ce33ee435dc( 1 );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x16a9
    // Size: 0xe, Type: dev
    function private function_3f8bf5c34fe29a6a()
    {
        function_e30f9ce33ee435dc( 2 );
    }

    // Namespace activity_voting / namespace_6854ffbed339ca49
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x16bf
    // Size: 0xe, Type: dev
    function private function_3f8bf6c34fe29c9d()
    {
        function_e30f9ce33ee435dc( 3 );
    }

#/
