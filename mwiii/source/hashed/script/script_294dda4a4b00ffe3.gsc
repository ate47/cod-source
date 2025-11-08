#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\utility\script;

#namespace namespace_b354cc7ab3b869b0;

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0
// Checksum 0x0, Offset: 0x231
// Size: 0xd5
function init()
{
    level.var_adaaed38371fa15b = spawnstruct();
    level.var_adaaed38371fa15b.timescompleted = 0;
    level.var_adaaed38371fa15b.state = 0;
    level.var_adaaed38371fa15b.targets = function_76e26aff7dcf2a6a();
    
    if ( function_afea038c5c9f1209() )
    {
        level.var_adaaed38371fa15b.var_d4622dbffcad86c = function_276be8b8ea7b9da7();
    }
    
    level.var_adaaed38371fa15b.timer = spawnstruct();
    level.var_adaaed38371fa15b.timer.duration = level.var_adaaed38371fa15b.targets[ 0 ];
    thread function_727b37a4211441b8();
    
    /#
        function_5c4de7736363bf0c();
    #/
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0
// Checksum 0x0, Offset: 0x30e
// Size: 0x13, Type: bool
function function_4ad287e0971672a6()
{
    return getdvarint( @"hash_4558abf9d259b284", 0 ) > 0;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0
// Checksum 0x0, Offset: 0x32a
// Size: 0x14, Type: bool
function function_afea038c5c9f1209()
{
    return getdvarint( @"hash_a973ab15ba11d2ba", 1 ) > 0;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0
// Checksum 0x0, Offset: 0x347
// Size: 0xa6
function function_76e26aff7dcf2a6a()
{
    var_24abc960b59e06d0 = getdvar( @"hash_bc9d24d7d03581e3", "0 0 0" );
    var_4feae575ce34efa0 = [];
    
    if ( var_24abc960b59e06d0 != "" )
    {
        var_394d57a3c2ae52af = strtok( var_24abc960b59e06d0, " " );
        
        foreach ( target in var_394d57a3c2ae52af )
        {
            targetvalue = int( target );
            var_4feae575ce34efa0[ var_4feae575ce34efa0.size ] = targetvalue;
        }
    }
    
    return var_4feae575ce34efa0;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 1
// Checksum 0x0, Offset: 0x3f6
// Size: 0xae
function function_8be9bae8228a91f7( eventname )
{
    var_ae18d736d9768b9a = getdvar( hashcat( @"hash_abb46656d4b7e51c", eventname, "_pe_meter_event_weights" ), "0 0 0 0 0 0 0 0" );
    var_b9b56551e1acfee2 = [];
    
    if ( var_ae18d736d9768b9a != "" )
    {
        var_ddcea577bbdd75b0 = strtok( var_ae18d736d9768b9a, " " );
        
        foreach ( weight in var_ddcea577bbdd75b0 )
        {
            var_b9b56551e1acfee2[ var_b9b56551e1acfee2.size ] = float( weight );
        }
    }
    
    return var_b9b56551e1acfee2;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4ad
// Size: 0x117
function private function_276be8b8ea7b9da7()
{
    var_d4622dbffcad86c = spawnstruct();
    var_d4622dbffcad86c.eventtypes = [];
    var_b47e0ed9ba26b84f = getdvar( @"hash_279e65fda89136b4", "" );
    var_f4ef4ad8c3051332 = strtok( var_b47e0ed9ba26b84f, "," );
    
    if ( var_f4ef4ad8c3051332.size == 0 )
    {
        scripts\mp\utility\script::demoforcesre( "Public Event Meters: No predetermined public events set! Set dvar 'scr_br_pe_meter_predetermined_events'" );
        return undefined;
    }
    
    for ( i = 0; i < var_f4ef4ad8c3051332.size ; i++ )
    {
        var_d4622dbffcad86c.eventtypes[ i ] = [];
        var_b8a9ecc1bbd4ad93 = strtok( var_f4ef4ad8c3051332[ i ], " " );
        
        foreach ( event in var_b8a9ecc1bbd4ad93 )
        {
            if ( event.size == 0 )
            {
                continue;
            }
            
            var_d4622dbffcad86c.eventtypes[ i ][ var_d4622dbffcad86c.eventtypes[ i ].size ] = getxhashasset( event );
        }
    }
    
    return var_d4622dbffcad86c;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0
// Checksum 0x0, Offset: 0x5cd
// Size: 0x47
function function_c6b950c21813b5cd()
{
    meterlevel = level.var_adaaed38371fa15b.timescompleted;
    meterlevel = clamp( meterlevel, 0, level.var_adaaed38371fa15b.targets.size - 1 );
    return int( meterlevel );
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0
// Checksum 0x0, Offset: 0x61d
// Size: 0x8c
function function_3168dda92f94de9c()
{
    endtime = level.var_adaaed38371fa15b.timer.endtime;
    currenttime = gettime();
    
    if ( !isdefined( endtime ) || currenttime >= endtime )
    {
        return undefined;
    }
    
    meterlevel = function_c6b950c21813b5cd();
    duration = level.var_adaaed38371fa15b.targets[ meterlevel ];
    timedifference = endtime - currenttime;
    return timedifference / duration * 1000;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0
// Checksum 0x0, Offset: 0x6b2
// Size: 0x46, Type: bool
function function_989d407ad1798eb0()
{
    if ( !istrue( level.var_adaaed38371fa15b.var_4d2460299ca3ab25 ) )
    {
        return false;
    }
    
    return level.var_adaaed38371fa15b.timescompleted > level.var_adaaed38371fa15b.targets.size - 1;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x701
// Size: 0x26
function private function_727b37a4211441b8()
{
    level endon( "cancel_public_event" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    function_b25d69ba35a863c8( 1 );
    thread function_6ea8115fc5f81bbd();
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x72f
// Size: 0x136
function private function_2d3ba92b45fb796e()
{
    meterlevel = function_c6b950c21813b5cd();
    
    if ( function_afea038c5c9f1209() )
    {
        if ( scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zxp" )
        {
            eventtypes = level.var_adaaed38371fa15b.var_d4622dbffcad86c.eventtypes[ 0 ];
        }
        else
        {
            eventtypes = level.var_adaaed38371fa15b.var_d4622dbffcad86c.eventtypes[ meterlevel ];
        }
        
        foreach ( eventtype in eventtypes )
        {
            if ( scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zxp" )
            {
                level.var_5042ca82b8056c6c = undefined;
                level.var_120b80961427b421 = undefined;
                level thread scripts\mp\gametypes\br_public::brleaderdialog( "zxp_infestationStart" );
            }
            
            level thread scripts\mp\gametypes\br_publicevents::runpubliceventoftype( eventtype, 1, meterlevel, 1 );
        }
    }
    else
    {
        level thread scripts\mp\gametypes\br_publicevents::choosepubliceventtype( 1, meterlevel, 1 );
    }
    
    level.var_adaaed38371fa15b.timescompleted += 1;
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x86d
// Size: 0x1a7
function private function_6ea8115fc5f81bbd()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        meterlevel = function_c6b950c21813b5cd();
        target = level.var_adaaed38371fa15b.targets[ meterlevel ];
        endtime = gettime() + target * 1000;
        function_b25d69ba35a863c8( 1 );
        function_793358077b37fb75( endtime );
        function_8e5a2527f76e9ba4( target );
        
        while ( gettime() < level.var_adaaed38371fa15b.timer.endtime || level.var_adaaed38371fa15b.state == 0 )
        {
            if ( scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zxp" )
            {
                currenttime = gettime();
                
                if ( level.var_adaaed38371fa15b.timer.endtime - currenttime < target * 1000 / 2 && !isdefined( level.var_5042ca82b8056c6c ) )
                {
                    level.var_5042ca82b8056c6c = 1;
                    level thread scripts\mp\gametypes\br_public::brleaderdialog( "zxp_infestationTimerHalf" );
                }
                else if ( level.var_adaaed38371fa15b.timer.endtime - currenttime < 20000 && !isdefined( level.var_120b80961427b421 ) )
                {
                    level.var_120b80961427b421 = 1;
                    level thread scripts\mp\gametypes\br_public::brleaderdialog( "zxp_infestationTimerLow" );
                }
            }
            
            wait 0.1;
        }
        
        function_b25d69ba35a863c8( 2 );
        function_2d3ba92b45fb796e();
        
        while ( scripts\mp\gametypes\br_publicevents::function_7ddadb6d5643bee4() )
        {
            level waittill_any_2( "br_pe_end", "cancel_public_event" );
        }
        
        waitframe();
    }
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 1
// Checksum 0x0, Offset: 0xa1c
// Size: 0x75
function addtotimer( seconds )
{
    if ( !isdefined( seconds ) || seconds == 0 || !isdefined( level.var_adaaed38371fa15b.timer.endtime ) )
    {
        return;
    }
    
    endtime = level.var_adaaed38371fa15b.timer.endtime;
    endtime += seconds * 1000;
    function_793358077b37fb75( endtime );
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa99
// Size: 0x60
function private function_b25d69ba35a863c8( state )
{
    if ( !isdefined( state ) || level.var_adaaed38371fa15b.state == state )
    {
        return;
    }
    
    assert( -1, "<dev string:x1c>" );
    level.var_adaaed38371fa15b.state = state;
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_pe_meter_data", 0, 2, state );
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb01
// Size: 0x51
function private function_793358077b37fb75( endtime )
{
    level.var_adaaed38371fa15b.timer.endtime = endtime;
    secondsendtime = int( endtime / 1000 );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_pe_meter_data", 2, 11, secondsendtime );
}

// Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb5a
// Size: 0x3b
function private function_8e5a2527f76e9ba4( duration )
{
    level.var_adaaed38371fa15b.timer.duration = duration;
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_pe_meter_data", 13, 8, duration );
}

/#

    // Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
    // Params 0
    // Checksum 0x0, Offset: 0xb9d
    // Size: 0x11, Type: dev
    function function_5c4de7736363bf0c()
    {
        scripts\mp\gametypes\br_dev::registerhandlecommand( &function_19410406f863b78f );
    }

    // Namespace namespace_b354cc7ab3b869b0 / namespace_c711384b1335919
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xbb6
    // Size: 0x86, Type: dev
    function private function_19410406f863b78f( cmd, args )
    {
        if ( cmd != "<dev string:x7b>" )
        {
            return;
        }
        
        switch ( args[ 0 ] )
        {
            case #"hash_c61546c10a51754":
                addtotimer( int( args[ 1 ] ) );
                break;
            case #"hash_e9545d0bee0d374a":
                level.var_adaaed38371fa15b.timescompleted = int( args[ 1 ] );
                break;
            default:
                break;
        }
    }

#/
