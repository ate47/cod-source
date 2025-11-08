#using script_294dda4a4b00ffe3;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\hud_message;
#using scripts\mp\utility\script;

#namespace br_publicevents;

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x3c3
// Size: 0x202
function init()
{
    level.var_34714ce799b6017 = 0;
    
    if ( getdvarint( @"hash_18afe7a288a4b1e4", 0 ) )
    {
        level notify( "disable_public_event" );
        return;
    }
    
    var_37ee364b712c7afc = function_3c3429141b476356();
    
    if ( !isdefined( var_37ee364b712c7afc ) )
    {
        return;
    }
    
    level.var_34714ce799b6017 = 1;
    level.var_b06bb395c37b7ab8 = getdvarint( @"hash_965692fa542f0728", 1 ) == 1;
    level.var_3f6a099030787823 = function_ee26a62ef3d1372d( @"hash_b5088319799172eb", 0, var_37ee364b712c7afc.var_bff1bf1b8c888d19 );
    level.br_pe_data = [];
    level.var_5a7ffdf228d98c9f = function_ee26a62ef3d1372d( @"hash_90afac1657855099", 2, var_37ee364b712c7afc.var_66d81af498488598 );
    level.var_6f249acebd235065 = function_ee26a62ef3d1372d( @"hash_23b4b411c19d8090", 5, var_37ee364b712c7afc.initialdelay );
    level.var_98e0b0cb95eacda2 = function_ee26a62ef3d1372d( @"hash_a03801ae050ddf71", 8, var_37ee364b712c7afc.var_19514771c45f18e3 );
    level.var_6ed09339da2b5658 = function_8fc51a5af06412cf( function_ba70ea4e80f22895( @"hash_d3da8cf30df8bef5", "", var_37ee364b712c7afc.var_47dc5a64efcc13d8 ) );
    level.var_5e45ff103cde1cc6 = 0;
    
    if ( function_b1266056816b8716() )
    {
        level.var_5c60c997534512df = function_8fc51a5af06412cf( function_ba70ea4e80f22895( @"hash_955b56c18d2a6100", "", var_37ee364b712c7afc.var_9a340a5b7388b5c6 ) );
        level.var_88870d23daafa4a3 = function_542e227485e0fd62( var_37ee364b712c7afc.var_68f213b65ed34b12, "Overtime Events List" );
    }
    
    level.var_606854b9c9f9bc18 = function_ee26a62ef3d1372d( @"hash_6bfe84439d5b902e", 0, var_37ee364b712c7afc.var_4d41fcdf331d7c7 );
    level.var_da99e5f67262b8c4 = function_542e227485e0fd62( var_37ee364b712c7afc.var_f0570e644ddd76ff, "Match-wide Events List" );
    function_6de5b883b26a0f41( var_37ee364b712c7afc );
    scripts\mp\gametypes\br_dev::registerhandlecommand( &handledevcommand_publicevents );
    
    if ( namespace_c711384b1335919::function_4ad287e0971672a6() )
    {
        level thread namespace_c711384b1335919::init();
    }
    
    thread function_72a208ea4ccd4f2b();
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x5cd
// Size: 0x29
function function_72a208ea4ccd4f2b()
{
    if ( publiceventsenabled() )
    {
        if ( function_8aaa3648604bf278() )
        {
            level thread function_a59044c0d9b0988b();
            return;
        }
        
        level thread publiceventsmanager();
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x5fe
// Size: 0xd1
function function_6de5b883b26a0f41( var_37ee364b712c7afc )
{
    level notify( "init_public_event" );
    
    foreach ( var_7e93722a91573842 in var_37ee364b712c7afc.var_b57c449da2d093c3 )
    {
        if ( !isdefined( var_7e93722a91573842.event ) )
        {
            continue;
        }
        
        reference = function_b5db7c8669703c35( var_7e93722a91573842.event );
        publiceventinit( reference, var_7e93722a91573842 );
    }
    
    if ( function_8aaa3648604bf278() )
    {
        var_5648fccda43a39da = spawnstruct();
        var_5648fccda43a39da.weight = 0;
        registerpublicevent( "", var_5648fccda43a39da );
    }
    
    waittillframeend();
    function_42d775349af86f8b();
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x6d7
// Size: 0xcd
function function_42d775349af86f8b()
{
    foreach ( eventdata in level.br_pe_data )
    {
        if ( eventdata.weight <= 0 && !function_beb7ed17efad9bd7( eventdata ) )
        {
            continue;
        }
        
        if ( isdefined( eventdata.validatefunc ) && ![[ eventdata.validatefunc ]]() )
        {
            eventdata.isinvalid = 1;
            continue;
        }
        
        if ( isdefined( eventdata.postinitfunc ) )
        {
            eventdata [[ eventdata.postinitfunc ]]();
            eventdata.var_32b8f60180b1c127 = 1;
        }
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x7ac
// Size: 0xb3
function function_4634160166fb7f8b( eventname, var_7b3a7c3f67ceb677 )
{
    var_3c5dfe64e9e89eb8 = getdvar( hashcat( @"hash_abb46656d4b7e51c", eventname, "_circle_event_weights" ), var_7b3a7c3f67ceb677 );
    circleeventweights = [];
    
    if ( var_3c5dfe64e9e89eb8 != "" )
    {
        var_29eeb1cee9703a92 = strtok( var_3c5dfe64e9e89eb8, " " );
        
        foreach ( weight in var_29eeb1cee9703a92 )
        {
            circleeventweights[ circleeventweights.size ] = float( weight );
        }
    }
    
    return circleeventweights;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x868
// Size: 0x7b
function function_8fc51a5af06412cf( string )
{
    circleeventweights = [];
    var_29eeb1cee9703a92 = strtok( string, " " );
    
    foreach ( weight in var_29eeb1cee9703a92 )
    {
        circleeventweights[ circleeventweights.size ] = float( weight );
    }
    
    return circleeventweights;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x8ec
// Size: 0xac
function registerpublicevent( eventtype, eventinfo )
{
    assert( isdefined( level.br_pe_data ) );
    assert( !isdefined( level.br_pe_data[ eventtype ] ) );
    
    if ( !isdefined( eventinfo.active ) )
    {
        eventinfo.active = 0;
    }
    
    if ( !isdefined( eventinfo.weight ) )
    {
        eventinfo.weight = 1;
    }
    
    if ( function_8aaa3648604bf278() )
    {
        if ( !isdefined( eventinfo.maxtimes ) )
        {
            eventinfo.maxtimes = 1;
        }
    }
    
    level.br_pe_data[ eventtype ] = eventinfo;
    return eventinfo;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x9a1
// Size: 0x5d
function function_44424d94254dfaf5()
{
    cancelupcomingpublicevents();
    
    foreach ( eventtype, eventdata in level.br_pe_data )
    {
        function_2907d01a7d692108( eventtype );
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xa06
// Size: 0x14
function cancelupcomingpublicevents()
{
    level notify( "cancel_public_event" );
    level.var_5e45ff103cde1cc6 = 0;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xa22
// Size: 0x84
function publiceventsenabled()
{
    if ( !level.var_34714ce799b6017 )
    {
        return 0;
    }
    
    forceeventtype = getdvar( @"hash_c164d00b9c54b5b8", "" );
    
    if ( forceeventtype != "" )
    {
        return 1;
    }
    
    if ( function_8aaa3648604bf278() )
    {
        return function_79a1303427bfac85();
    }
    
    eventcount = getpubliceventcount();
    
    if ( !eventcount )
    {
        return 0;
    }
    
    eventchance = getpubliceventchance();
    
    if ( eventchance <= 0 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0xaae
// Size: 0xaa, Type: bool
function shoulddopublicevent( currentcircle, var_cbf29c8a5f4eab27 )
{
    eventchance = getpubliceventchance();
    
    if ( function_8aaa3648604bf278() )
    {
        if ( istrue( var_cbf29c8a5f4eab27 ) )
        {
            eventchance = level.var_606854b9c9f9bc18;
        }
        else if ( isdefined( currentcircle ) )
        {
            if ( isdefined( level.var_6ed09339da2b5658[ currentcircle ] ) )
            {
                eventchance = level.var_6ed09339da2b5658[ currentcircle ];
            }
            else
            {
                /#
                    if ( function_b1266056816b8716() )
                    {
                        function_1cddcb2898d7667( "<dev string:x1c>" + currentcircle );
                    }
                    else
                    {
                        function_1cddcb2898d7667( "<dev string:x73>" + currentcircle );
                    }
                #/
                
                return false;
            }
        }
    }
    
    if ( eventchance <= 0 )
    {
        return false;
    }
    
    return randomfloat( 1 ) <= eventchance;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xb61
// Size: 0xd, Type: bool
function function_7ddadb6d5643bee4()
{
    return level.var_5e45ff103cde1cc6 > 0;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xb77
// Size: 0x12
function getpubliceventcount()
{
    return getdvarint( @"scr_br_pe_count", 1 );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xb92
// Size: 0x15
function getpubliceventchance()
{
    return getdvarfloat( @"scr_br_pe_chance", 0 );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xbb0
// Size: 0x18, Type: bool
function multiplepubliceventsenabled()
{
    numevents = getpubliceventcount();
    return numevents != 1;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xbd1
// Size: 0xa8
function publiceventsmanager()
{
    level endon( "cancel_public_event" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( multiplepubliceventsenabled() )
    {
        var_6e6a77283e1803b1 = getdvarfloat( @"hash_a02772622b60d034", 240 );
        var_6e8d89283e3e72ff = getdvarfloat( @"hash_a04a60622b86f056", 360 );
        
        for ( numevents = getpubliceventcount(); numevents ; numevents-- )
        {
            waittime = randomfloatrange( var_6e6a77283e1803b1, var_6e8d89283e3e72ff );
            wait waittime;
            
            if ( shoulddopublicevent() )
            {
                choosepubliceventtype( 1 );
            }
        }
        
        return;
    }
    
    if ( shoulddopublicevent() )
    {
        choosepubliceventtype( 0 );
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0xc81
// Size: 0x104
function validateevents()
{
    validtypes = [];
    
    foreach ( eventtype, eventdata in level.br_pe_data )
    {
        if ( eventdata.weight <= 0 )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:xca>" );
            #/
            
            continue;
        }
        
        if ( istrue( eventdata.isinvalid ) )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:xee>" );
            #/
            
            continue;
        }
        
        if ( isdefined( eventdata.var_b22310d8fb6c98fa ) && ![[ eventdata.var_b22310d8fb6c98fa ]]() )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x12e>" );
            #/
            
            continue;
        }
        
        /#
            function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x166>" );
        #/
        
        validtypes[ validtypes.size ] = eventtype;
    }
    
    return validtypes;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 5
// Checksum 0x0, Offset: 0xd8e
// Size: 0x28a
function function_92663f9d29e51479( eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 )
{
    var_2b63c409156776a5 = spawnstruct();
    var_2b63c409156776a5.types = [];
    var_2b63c409156776a5.weights = [];
    
    if ( !istrue( var_cbf29c8a5f4eab27 ) && !istrue( var_4bd41ebbce2d3bb6 ) )
    {
        foreach ( eventtype in eventtypes )
        {
            eventdata = level.br_pe_data[ eventtype ];
            assert( isdefined( eventdata ) );
            eventweight = eventdata.weight;
            weights = ter_op( var_fb5ad7615ebab353, eventdata.var_b9b56551e1acfee2, eventdata.circleeventweights );
            
            if ( isdefined( currentcircle ) && isdefined( weights ) && isdefined( weights[ currentcircle ] ) )
            {
                eventweight = weights[ currentcircle ];
            }
            
            var_2b63c409156776a5.types[ var_2b63c409156776a5.types.size ] = eventtype;
            var_2b63c409156776a5.weights[ var_2b63c409156776a5.weights.size ] = eventweight;
        }
    }
    else if ( istrue( var_cbf29c8a5f4eab27 ) )
    {
        weights = level.var_da99e5f67262b8c4.weights;
        
        foreach ( eventtype in eventtypes )
        {
            if ( !isdefined( weights[ eventtype ] ) )
            {
                continue;
            }
            
            var_2b63c409156776a5.types[ var_2b63c409156776a5.types.size ] = eventtype;
            var_2b63c409156776a5.weights[ var_2b63c409156776a5.weights.size ] = weights[ eventtype ];
        }
    }
    else
    {
        weights = level.var_88870d23daafa4a3.weights;
        
        foreach ( eventtype in eventtypes )
        {
            if ( !isdefined( weights[ eventtype ] ) )
            {
                continue;
            }
            
            var_2b63c409156776a5.types[ var_2b63c409156776a5.types.size ] = eventtype;
            var_2b63c409156776a5.weights[ var_2b63c409156776a5.weights.size ] = weights[ eventtype ];
        }
    }
    
    return var_2b63c409156776a5;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 5
// Checksum 0x0, Offset: 0x1021
// Size: 0xa7
function getweightedsum( eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 )
{
    var_2b63c409156776a5 = function_92663f9d29e51479( eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 );
    weightedsum = 0;
    
    foreach ( weight in var_2b63c409156776a5.weights )
    {
        weightedsum += weight;
    }
    
    return weightedsum;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 6
// Checksum 0x0, Offset: 0x10d1
// Size: 0xc8
function findeventforchosenweight( eventtypes, chosenweight, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 )
{
    var_2b63c409156776a5 = function_92663f9d29e51479( eventtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 );
    weightedsum = 0;
    
    foreach ( i, weight in var_2b63c409156776a5.weights )
    {
        weightedsum += weight;
        
        if ( chosenweight <= weightedsum )
        {
            return var_2b63c409156776a5.types[ i ];
        }
    }
    
    return "";
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 5
// Checksum 0x0, Offset: 0x11a2
// Size: 0x1dc
function choosepubliceventtype( skipwait, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 )
{
    if ( !isdefined( var_fb5ad7615ebab353 ) )
    {
        var_fb5ad7615ebab353 = 0;
    }
    
    validtypes = undefined;
    
    if ( function_8aaa3648604bf278() && !istrue( var_cbf29c8a5f4eab27 ) && !istrue( var_4bd41ebbce2d3bb6 ) )
    {
        /#
            function_1cddcb2898d7667( "<dev string:x178>" + currentcircle );
        #/
        
        validtypes = function_aaee113bdf9d92b9( currentcircle, var_fb5ad7615ebab353 );
    }
    else if ( istrue( var_cbf29c8a5f4eab27 ) )
    {
        /#
            function_1cddcb2898d7667( "<dev string:x199>" );
        #/
        
        validtypes = function_95342049a868f70b( level.var_da99e5f67262b8c4 );
    }
    else if ( istrue( var_4bd41ebbce2d3bb6 ) )
    {
        /#
            function_1cddcb2898d7667( "<dev string:x1c2>" );
        #/
        
        validtypes = function_95342049a868f70b( level.var_88870d23daafa4a3 );
    }
    else
    {
        validtypes = validateevents();
    }
    
    if ( function_8aaa3648604bf278() )
    {
        assert( validtypes.size != 0, "<dev string:x1e2>" );
    }
    
    weightedsum = getweightedsum( validtypes, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 );
    randchoice = randomfloat( weightedsum );
    eventtype = findeventforchosenweight( validtypes, randchoice, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 );
    
    /#
        function_1cddcb2898d7667( "<dev string:x233>" + getxhashsourcename( eventtype ) );
    #/
    
    forceeventtype = getdvar( @"hash_c164d00b9c54b5b8", "" );
    
    if ( forceeventtype != "" )
    {
        /#
            function_1cddcb2898d7667( "<dev string:x247>" + getxhashsourcename( forceeventtype ) );
        #/
        
        eventtype = getxhashasset( forceeventtype );
    }
    
    if ( isdefined( currentcircle ) )
    {
        /#
            circleindex = ter_op( isdefined( currentcircle ), currentcircle, "<dev string:x26b>" );
            println( "<dev string:x276>" + circleindex + "<dev string:x290>" + getxhashsourcename( eventtype ) );
        #/
    }
    
    level runpubliceventoftype( eventtype, skipwait, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x1386
// Size: 0x5c
function activateevent( eventdata )
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    level notify( "br_pe_start" );
    
    if ( isdefined( eventdata.activatefunc ) )
    {
        eventdata [[ eventdata.activatefunc ]]();
    }
    
    level.var_5e45ff103cde1cc6 -= 1;
    level notify( "br_pe_end" );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x13ea
// Size: 0x7c
function function_7ef2b71b1d3c3a01( currenttimeinterval )
{
    if ( isdefined( currenttimeinterval ) && isdefined( level.var_5c60c997534512df[ currenttimeinterval + 1 ] ) )
    {
        if ( isdefined( level.var_5c60c997534512df[ currenttimeinterval ] ) )
        {
            timetowait = level.var_5c60c997534512df[ currenttimeinterval + 1 ] - level.var_5c60c997534512df[ currenttimeinterval ];
            
            if ( timetowait < 0 )
            {
                /#
                    function_1cddcb2898d7667( "<dev string:x296>" + currenttimeinterval + "<dev string:x2ab>" );
                #/
                
                return -1;
            }
            
            return timetowait;
        }
    }
    
    return -1;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 6
// Checksum 0x0, Offset: 0x146f
// Size: 0x302
function runpubliceventoftype( eventtype, skipwait, currentcircle, var_fb5ad7615ebab353, var_4bd41ebbce2d3bb6, var_cbf29c8a5f4eab27 )
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    assert( eventtype == "<dev string:x2d8>" || isxhashasset( eventtype ), "<dev string:x2dc>" );
    
    if ( eventtype == "" && !function_8aaa3648604bf278() )
    {
        /#
            function_1cddcb2898d7667( "<dev string:x31e>" );
        #/
        
        return;
    }
    
    eventdata = level.br_pe_data[ eventtype ];
    assert( isdefined( eventdata ) );
    
    if ( isdefined( eventdata.waitfunc ) && !skipwait )
    {
        eventdata [[ eventdata.waitfunc ]]();
    }
    
    if ( getdvarint( @"hash_a1b1b3ba057f4935", 1 ) > 0 )
    {
        while ( function_7ddadb6d5643bee4() )
        {
            level waittill_any_2( "br_pe_end", "cancel_public_event" );
            waitframe();
        }
    }
    
    level.var_5e45ff103cde1cc6 += 1;
    var_8762815dfed51fdf = getxhashhexname( eventtype );
    eventdata.active = 1;
    scripts\mp\gametypes\br_analytics::branalytics_publiceventstarted( var_8762815dfed51fdf );
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "onPublicEvent", var_8762815dfed51fdf, "start" );
    
    if ( function_8aaa3648604bf278() && !istrue( var_cbf29c8a5f4eab27 ) )
    {
        level.var_608e8df77c8e41c7 = 1;
        
        /#
            function_1cddcb2898d7667( "<dev string:x342>" + getxhashsourcename( eventtype ) );
        #/
        
        level thread activateevent( eventdata );
        
        if ( !istrue( var_fb5ad7615ebab353 ) )
        {
            if ( !isdefined( level.var_a926065139739a2d ) )
            {
                level.var_a926065139739a2d = [];
            }
            
            if ( !isdefined( level.var_a926065139739a2d[ eventtype ] ) )
            {
                level.var_a926065139739a2d[ eventtype ] = 0;
            }
            
            level.var_a926065139739a2d[ eventtype ]++;
            
            if ( isdefined( currentcircle ) )
            {
                level.var_deb29f8358c3a6cb[ eventtype ] = currentcircle;
            }
        }
        
        if ( !istrue( var_4bd41ebbce2d3bb6 ) )
        {
            if ( function_b1266056816b8716() )
            {
                waittime = function_7ef2b71b1d3c3a01( currentcircle );
                
                if ( waittime >= 0 )
                {
                    wait waittime;
                }
                else
                {
                    scripts\mp\flags::gameflagwait( "overtime_started" );
                    level.var_8f19fadbf63fbc0 = 1;
                }
            }
            else
            {
                level waittill( "br_circle_set" );
            }
            
            function_2907d01a7d692108( eventtype );
            level notify( "select_new_event" );
        }
        
        return;
    }
    
    if ( istrue( var_cbf29c8a5f4eab27 ) )
    {
        level.var_c2ed1a34fb9c867d = eventtype;
        var_f4f62e014a42208b = level.var_5e45ff103cde1cc6;
        
        /#
            function_1cddcb2898d7667( "<dev string:x342>" + getxhashsourcename( eventtype ) );
        #/
        
        level thread activateevent( eventdata );
        
        if ( var_f4f62e014a42208b == level.var_5e45ff103cde1cc6 )
        {
            assertmsg( "<dev string:x358>" + getxhashsourcename( eventtype ) + "<dev string:x36c>" );
        }
        
        function_2907d01a7d692108( eventtype );
        return;
    }
    
    level activateevent( eventdata );
    
    if ( istrue( eventdata.active ) )
    {
        scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "onPublicEvent", var_8762815dfed51fdf, "end" );
    }
    
    eventdata.active = 0;
    scripts\mp\gametypes\br_analytics::branalytics_publiceventended( var_8762815dfed51fdf );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x1779
// Size: 0x81
function function_2907d01a7d692108( eventtype )
{
    if ( ispubliceventoftypeactive( eventtype ) )
    {
        var_8762815dfed51fdf = getxhashhexname( eventtype );
        eventdata = level.br_pe_data[ eventtype ];
        
        if ( isdefined( eventdata.deactivatefunc ) )
        {
            eventdata [[ eventdata.deactivatefunc ]]();
        }
        
        scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "onPublicEvent", var_8762815dfed51fdf, "end" );
        eventdata.active = 0;
        scripts\mp\gametypes\br_analytics::branalytics_publiceventended( var_8762815dfed51fdf );
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x1802
// Size: 0x52, Type: bool
function ispubliceventoftypeactive( eventtype )
{
    if ( !level.var_34714ce799b6017 || !isdefined( level.br_pe_data ) )
    {
        return false;
    }
    
    eventdata = level.br_pe_data[ eventtype ];
    
    if ( !isdefined( eventdata ) )
    {
        return false;
    }
    
    return istrue( eventdata.active );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x185d
// Size: 0x6d
function showsplashtoall( splashname, splashlistoverride )
{
    foreach ( player in level.players )
    {
        player scripts\mp\hud_message::showsplash( splashname, undefined, undefined, undefined, undefined, splashlistoverride );
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x18d2
// Size: 0x25
function function_6ef55ffe74b87a74( waittime )
{
    level endon( "game_ended" );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    setomnvar( "ui_minimap_pulse", 0 );
}

/#

    // Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
    // Params 1
    // Checksum 0x0, Offset: 0x18ff
    // Size: 0xce, Type: dev
    function function_e37ee072d95a7c98( eventtype )
    {
        level notify( "<dev string:x398>" );
        level endon( "<dev string:x398>" );
        level.var_5e45ff103cde1cc6 = 0;
        var_35299ef591e15919 = getxhashasset( eventtype );
        
        if ( !isdefined( level.br_pe_data[ var_35299ef591e15919 ] ) )
        {
            var_98a1e57d4147ddcd = spawnstruct();
            [[ level.var_5f038a998555089e[ var_35299ef591e15919 ] ]]( var_98a1e57d4147ddcd );
            registerpublicevent( var_35299ef591e15919, var_98a1e57d4147ddcd );
        }
        
        if ( !istrue( level.br_pe_data[ var_35299ef591e15919 ].var_32b8f60180b1c127 ) )
        {
            level.br_pe_data[ var_35299ef591e15919 ] [[ level.br_pe_data[ var_35299ef591e15919 ].postinitfunc ]]();
            level.br_pe_data[ var_35299ef591e15919 ].var_32b8f60180b1c127 = 1;
        }
        
        level runpubliceventoftype( var_35299ef591e15919, 1 );
    }

#/

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x19d5
// Size: 0x39
function handledevcommand_publicevents( command, args )
{
    /#
        switch ( command )
        {
            case #"hash_94b933c8d88ea90f":
                thread function_e37ee072d95a7c98( args[ 0 ] );
                break;
        }
    #/
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x1a16
// Size: 0xc, Type: bool
function function_8aaa3648604bf278()
{
    return istrue( level.var_b06bb395c37b7ab8 );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x1a2b
// Size: 0xc, Type: bool
function function_b1266056816b8716()
{
    return istrue( level.var_3f6a099030787823 );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x1a40
// Size: 0x20
function function_826d1843088ff270()
{
    level endon( "game_ended" );
    level waittill( "bmo_overtime_start" );
    level thread choosepubliceventtype( 1, undefined, 0, 1 );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x1a68
// Size: 0xc9
function function_79a1303427bfac85()
{
    if ( scripts\mp\gametypes\br_gametypes::isfeatureenabled( "customGametypeCircles" ) )
    {
        flags::function_1240434f4201ac9d( "customGametypeCirclesInit" );
    }
    
    if ( level.var_606854b9c9f9bc18 > 0 )
    {
        return 1;
    }
    
    var_d788440e9c4b0193 = getdvarint( @"hash_f6d47ba2ae075d35", level.br_level.br_circleradii.size - 1 );
    
    if ( var_d788440e9c4b0193 <= 0 )
    {
        return 0;
    }
    
    var_9fa6c50b17cd398e = 0;
    
    foreach ( chance in level.var_6ed09339da2b5658 )
    {
        if ( chance > 0 )
        {
            var_9fa6c50b17cd398e = 1;
            break;
        }
    }
    
    return var_9fa6c50b17cd398e;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x1b3a
// Size: 0x215
function function_a59044c0d9b0988b()
{
    level endon( "cancel_public_event" );
    level endon( "game_ended" );
    
    if ( shoulddopublicevent( undefined, 1 ) )
    {
        level choosepubliceventtype( 1, undefined, undefined, 0, 1 );
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.var_a926065139739a2d = [];
    level.var_deb29f8358c3a6cb = [];
    var_93fe8081bd477cb7 = 0;
    var_d788440e9c4b0193 = 0;
    var_1bc1989068d1a2de = 0;
    
    if ( !function_b1266056816b8716() )
    {
        var_d788440e9c4b0193 = getdvarint( @"hash_f6d47ba2ae075d35", level.br_level.br_circleradii.size - 1 );
        var_1bc1989068d1a2de = level.br_level.br_circleradii.size - 1;
    }
    else
    {
        var_417eaacaac86d96e = level.var_5c60c997534512df.size;
        var_d788440e9c4b0193 = getdvarint( @"hash_f6d47ba2ae075d35", var_417eaacaac86d96e );
        var_1bc1989068d1a2de = var_417eaacaac86d96e;
    }
    
    while ( var_93fe8081bd477cb7 < var_1bc1989068d1a2de )
    {
        if ( var_93fe8081bd477cb7 == 0 )
        {
            if ( !function_b1266056816b8716() )
            {
                level waittill( "br_circle_set" );
            }
            else
            {
                level thread function_826d1843088ff270();
                wait level.var_5c60c997534512df[ 0 ];
            }
            
            wait level.var_6f249acebd235065;
        }
        else
        {
            if ( istrue( level.var_608e8df77c8e41c7 ) || function_b1266056816b8716() )
            {
                level waittill( "select_new_event" );
            }
            else
            {
                level waittill( "br_circle_set" );
            }
            
            wait level.var_98e0b0cb95eacda2;
        }
        
        if ( isdefined( level.var_383825619799549 ) && level.var_383825619799549 == 0 )
        {
            skipwait = 0;
        }
        else
        {
            skipwait = 1;
        }
        
        currentcircle = var_93fe8081bd477cb7;
        
        if ( !function_b1266056816b8716() )
        {
            currentcircle = level.br_circle.circleindex;
        }
        
        if ( istrue( level.var_8f19fadbf63fbc0 ) )
        {
            level thread choosepubliceventtype( 1, currentcircle, 0, 1 );
        }
        else if ( shoulddopublicevent( currentcircle ) )
        {
            level thread choosepubliceventtype( skipwait, currentcircle, 0 );
        }
        else
        {
            println( "<dev string:x276>" + currentcircle + "<dev string:x3bb>" );
            level notify( "br_pe_no_event" );
            level.var_608e8df77c8e41c7 = 0;
        }
        
        var_93fe8081bd477cb7++;
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x1d57
// Size: 0x278
function function_aaee113bdf9d92b9( currentcircle, var_fb5ad7615ebab353 )
{
    validtypes = [];
    
    foreach ( eventtype, eventdata in level.br_pe_data )
    {
        if ( eventdata.weight <= 0 )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:xca>" );
            #/
            
            continue;
        }
        
        if ( istrue( eventdata.isinvalid ) )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:xee>" );
            #/
            
            continue;
        }
        
        if ( isdefined( eventdata.var_b22310d8fb6c98fa ) && ![[ eventdata.var_b22310d8fb6c98fa ]]() )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x12e>" );
            #/
            
            continue;
        }
        
        weights = ter_op( var_fb5ad7615ebab353, eventdata.var_b9b56551e1acfee2, eventdata.circleeventweights );
        
        if ( isdefined( weights ) )
        {
            if ( isdefined( weights[ currentcircle ] ) && weights[ currentcircle ] <= 0 )
            {
                /#
                    function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:xca>" );
                #/
                
                continue;
            }
            else if ( !isdefined( weights[ currentcircle ] ) )
            {
                /#
                    function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x3c5>" + currentcircle );
                #/
                
                continue;
            }
        }
        
        if ( !istrue( var_fb5ad7615ebab353 ) )
        {
            if ( isdefined( level.var_a926065139739a2d ) && isdefined( level.var_a926065139739a2d[ eventtype ] ) )
            {
                if ( isdefined( eventdata.maxtimes ) && level.var_a926065139739a2d[ eventtype ] >= eventdata.maxtimes )
                {
                    /#
                        function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x407>" );
                    #/
                    
                    continue;
                }
            }
            
            if ( isdefined( level.var_deb29f8358c3a6cb ) && isdefined( level.var_deb29f8358c3a6cb[ eventtype ] ) )
            {
                var_a8239a74fb8ad784 = currentcircle - level.var_deb29f8358c3a6cb[ eventtype ];
                
                if ( var_a8239a74fb8ad784 >= level.var_5a7ffdf228d98c9f + 1 )
                {
                    level.var_deb29f8358c3a6cb[ eventtype ] = undefined;
                }
                else
                {
                    /#
                        function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x43f>" );
                    #/
                    
                    continue;
                }
            }
        }
        
        /#
            function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x166>" );
        #/
        
        validtypes[ validtypes.size ] = eventtype;
    }
    
    if ( validtypes.size == 0 )
    {
        validtypes[ validtypes.size ] = "";
    }
    
    return validtypes;
}

/#

    // Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
    // Params 1
    // Checksum 0x0, Offset: 0x1fd8
    // Size: 0x30, Type: dev
    function function_1cddcb2898d7667( message )
    {
        if ( getdvarint( @"hash_909fa2d0703b8e6b", 0 ) == 1 )
        {
            logstring( "<dev string:x4a7>" + message );
        }
    }

#/

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x2010
// Size: 0x72, Type: bool
function function_beb7ed17efad9bd7( eventdata )
{
    if ( isdefined( eventdata.var_b9b56551e1acfee2 ) )
    {
        foreach ( weight in eventdata.var_b9b56551e1acfee2 )
        {
            if ( weight > 0 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 0
// Checksum 0x0, Offset: 0x208b
// Size: 0x6a
function function_3c3429141b476356()
{
    var_8ab7165a9397f507 = getdvar( @"scr_br_publiceventlist", "jup_publiceventlist_none" );
    var_37ee364b712c7afc = getscriptbundle( "publiceventlist:" + var_8ab7165a9397f507 );
    
    if ( !isdefined( var_37ee364b712c7afc ) )
    {
        scripts\mp\utility\script::demoforcesre( "Public event list \"" + var_8ab7165a9397f507 + "\" not found. Make sure it's included in feature target" );
        return undefined;
    }
    
    /#
        function_1cddcb2898d7667( "<dev string:x4af>" + var_8ab7165a9397f507 + "<dev string:x4cf>" );
    #/
    
    return var_37ee364b712c7afc;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x20fe
// Size: 0x37
function function_dbc8f6cb3760cd82( reference, callback )
{
    if ( !isdefined( level.var_5f038a998555089e ) )
    {
        level.var_5f038a998555089e = [];
    }
    
    level.var_5f038a998555089e[ reference ] = callback;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x213d
// Size: 0xaf
function publiceventinit( reference, eventinfo )
{
    if ( !isdefined( reference ) )
    {
        return;
    }
    
    var_35299ef591e15919 = getxhashasset( reference );
    
    if ( !isdefined( level.var_5f038a998555089e ) || !isdefined( level.var_5f038a998555089e[ var_35299ef591e15919 ] ) )
    {
        scripts\mp\utility\script::demoforcesre( "Public event reference \"" + reference + "\" found in scriptbundle but no init callback was registered" );
        return;
    }
    
    [[ level.var_5f038a998555089e[ var_35299ef591e15919 ] ]]( eventinfo );
    eventinfo.circleeventweights = function_8fc51a5af06412cf( eventinfo.circleweights );
    eventinfo.var_b9b56551e1acfee2 = namespace_c711384b1335919::function_8be9bae8228a91f7( reference );
    function_5b7d8ca93f8705f1( eventinfo, reference );
    registerpublicevent( var_35299ef591e15919, eventinfo );
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x21f4
// Size: 0x110
function function_542e227485e0fd62( bundlelist, var_41e131919f4114ca )
{
    if ( !isdefined( var_41e131919f4114ca ) )
    {
        var_41e131919f4114ca = "";
    }
    
    var_7cccf2ef95abbdd = spawnstruct();
    var_7cccf2ef95abbdd.types = [];
    var_7cccf2ef95abbdd.weights = [];
    
    /#
        var_7cccf2ef95abbdd.var_41e131919f4114ca = var_41e131919f4114ca;
    #/
    
    foreach ( var_390ae3dd8694d9dc in bundlelist )
    {
        if ( !isdefined( var_390ae3dd8694d9dc.event ) )
        {
            continue;
        }
        
        reference = function_b5db7c8669703c35( var_390ae3dd8694d9dc.event );
        var_35299ef591e15919 = getxhashasset( reference );
        var_7cccf2ef95abbdd.types[ var_7cccf2ef95abbdd.types.size ] = var_35299ef591e15919;
        var_7cccf2ef95abbdd.weights[ var_35299ef591e15919 ] = var_390ae3dd8694d9dc.weight;
    }
    
    return var_7cccf2ef95abbdd;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x230d
// Size: 0x192
function function_95342049a868f70b( var_7215713679c3b0a4 )
{
    validtypes = [];
    
    foreach ( eventtype in var_7215713679c3b0a4.types )
    {
        if ( var_7215713679c3b0a4.weights[ eventtype ] <= 0 )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:xca>" );
            #/
            
            continue;
        }
        
        if ( !isdefined( level.br_pe_data[ eventtype ] ) )
        {
            /#
                var_4f23da738d0b2f28 = default_to( var_7215713679c3b0a4.var_41e131919f4114ca, "<dev string:x2d8>" );
                scripts\mp\utility\script::demoforcesre( "<dev string:x4d4>" + getxhashsourcename( eventtype ) + "<dev string:x4e1>" + var_4f23da738d0b2f28 + "<dev string:x4ee>" );
            #/
            
            continue;
        }
        
        if ( istrue( level.br_pe_data[ eventtype ].isinvalid ) )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:xee>" );
            #/
            
            continue;
        }
        
        if ( isdefined( level.br_pe_data[ eventtype ].var_b22310d8fb6c98fa ) && ![[ level.br_pe_data[ eventtype ].var_b22310d8fb6c98fa ]]() )
        {
            /#
                function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x12e>" );
            #/
            
            continue;
        }
        
        /#
            function_1cddcb2898d7667( getxhashsourcename( eventtype ) + "<dev string:x166>" );
        #/
        
        validtypes[ validtypes.size ] = eventtype;
    }
    
    if ( validtypes.size == 0 )
    {
        validtypes[ validtypes.size ] = "";
    }
    
    return validtypes;
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 2
// Checksum 0x0, Offset: 0x24a8
// Size: 0x125
function function_5b7d8ca93f8705f1( eventinfo, eventname )
{
    dvarbase = hashcat( @"hash_abb46656d4b7e51c", eventname, "_" );
    eventinfo.weight = getdvarfloat( hashcat( dvarbase, "weight" ), eventinfo.weight );
    eventinfo.maxtimes = getdvarint( hashcat( dvarbase, "max_times" ), eventinfo.maxtimes );
    circleweights = getdvar( hashcat( dvarbase, "circle_weights" ), "" );
    
    if ( circleweights != "" )
    {
        eventinfo.circleeventweights = function_8fc51a5af06412cf( circleweights );
    }
    
    if ( isdefined( level.var_da99e5f67262b8c4 ) )
    {
        var_a3927c3bdc0413f = getxhashasset( eventname );
        var_ce86475e613bffff = level.var_da99e5f67262b8c4.weights[ var_a3927c3bdc0413f ];
        
        if ( isdefined( var_ce86475e613bffff ) )
        {
            level.var_da99e5f67262b8c4.weights[ var_a3927c3bdc0413f ] = getdvarfloat( hashcat( dvarbase, "matchwide_weight" ), var_ce86475e613bffff );
        }
    }
}

// Namespace br_publicevents / scripts\mp\gametypes\br_publicevents
// Params 1
// Checksum 0x0, Offset: 0x25d5
// Size: 0x43
function function_b5db7c8669703c35( var_a7708841b4fa7e4d )
{
    eventbundle = getscriptbundle( "publicevent:" + var_a7708841b4fa7e4d );
    
    if ( !isdefined( eventbundle ) )
    {
        scripts\mp\utility\script::demoforcesre( "Could not find publicevent asset: " + var_a7708841b4fa7e4d );
        return undefined;
    }
    
    return eventbundle.ref;
}

