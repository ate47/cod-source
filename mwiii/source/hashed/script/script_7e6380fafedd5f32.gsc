#using script_6ad351ebd5a33280;
#using script_72d25fb2b703b6d5;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\parachute;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\class;
#using scripts\mp\dev;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_ending;
#using scripts\mp\gametypes\br_ending_chopper;
#using scripts\mp\gametypes\br_ending_chopper2;
#using scripts\mp\gametypes\br_ending_chopper_to_hq;
#using scripts\mp\gametypes\br_ending_util;
#using scripts\mp\outofbounds;
#using scripts\mp\teams;
#using scripts\mp\utility\teams;

#namespace namespace_bc2bdb06de29485d;

// Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1cd
// Size: 0x46
function private function_5197cc12048f8766( type )
{
    switch ( type )
    {
        case #"hash_d9cfbe7fb5447f0e":
            return scripts\mp\gametypes\br_ending_chopper2::function_a5538b1593309bb0();
        case #"hash_1136bc3322c0a548":
        default:
            return scripts\mp\gametypes\br_ending_chopper::function_a5538b1593309bb0();
    }
}

// Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x21b
// Size: 0x96
function private function_2845c7aff5b6d7b6( type )
{
    if ( scripts\engine\utility::issharedfuncdefined( "br_ending_" + type, "get_exfil_transient" ) )
    {
        return [[ scripts\engine\utility::getsharedfunc( "br_ending_" + type, "get_exfil_transient" ) ]]();
    }
    
    switch ( type )
    {
        case #"hash_d9cfbe7fb5447f0e":
            return scripts\mp\gametypes\br_ending_chopper2::get_chopperexfil_transient();
        case #"hash_18208461fac4f35e":
            return scripts\mp\gametypes\br_ending_chopper_to_hq::function_2023eb5589c72085();
        case #"hash_ce37a6540166b6f7":
            return namespace_91542927cd719085::function_aafaf24d80927b02();
        case #"hash_1136bc3322c0a548":
        default:
            return scripts\mp\gametypes\br_ending_chopper::get_chopperexfil_transient();
    }
}

/#

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x2b9
    // Size: 0x154, Type: dev
    function function_38b44913b9bec05f( players )
    {
        if ( !isdefined( players ) )
        {
            players = level.players;
        }
        
        var_b747aaa441b7aea9 = getdvarint( @"hash_85485bbe1bfbee98" );
        
        if ( var_b747aaa441b7aea9 > 0 )
        {
            level.custom_giveloadout = &function_181c965102053e79;
            count = 0;
            
            foreach ( player in level.players )
            {
                if ( istestclient( player ) )
                {
                    count++;
                }
            }
            
            if ( count < var_b747aaa441b7aea9 )
            {
                scripts\mp\dev::spawn_test_clients( var_b747aaa441b7aea9 );
            }
            
            wait 1;
            var_d39eb0d89e4b241f = 7;
            
            if ( var_b747aaa441b7aea9 >= var_d39eb0d89e4b241f )
            {
                players = [];
                
                for ( i = 1; i < level.players.size ; i++ )
                {
                    players[ players.size ] = level.players[ i ];
                }
            }
            else
            {
                size = players.size;
                diff = var_d39eb0d89e4b241f - size;
                
                if ( diff > 0 )
                {
                    for ( i = 0; i < diff ; i++ )
                    {
                        players[ players.size ] = level.players[ i + size ];
                    }
                }
            }
        }
        
        return players;
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 2
    // Checksum 0x0, Offset: 0x415
    // Size: 0x29b, Type: dev
    function function_181c965102053e79( fauxspawn, revivespawn )
    {
        array = [];
        array[ "<dev string:x1c>" ] = "<dev string:x26>";
        array[ "<dev string:x3a>" ] = "<dev string:x47>";
        array[ "<dev string:x5c>" ] = "<dev string:x67>";
        array[ "<dev string:x7c>" ] = "<dev string:x85>";
        array[ "<dev string:x98>" ] = "<dev string:xa1>";
        array[ "<dev string:xb4>" ] = "<dev string:xbf>";
        array[ "<dev string:xd1>" ] = "<dev string:xd8>";
        array[ "<dev string:xe9>" ] = "<dev string:xf1>";
        array[ "<dev string:x103>" ] = "<dev string:x10b>";
        array[ "<dev string:x11d>" ] = "<dev string:x125>";
        array[ "<dev string:x137>" ] = "<dev string:x140>";
        array[ "<dev string:x153>" ] = "<dev string:x15c>";
        array[ "<dev string:x16f>" ] = "<dev string:x178>";
        array[ "<dev string:x18b>" ] = "<dev string:x19b>";
        array[ "<dev string:x1ad>" ] = "<dev string:x1be>";
        array[ "<dev string:x1d2>" ] = "<dev string:x1e3>";
        array[ "<dev string:x1f7>" ] = "<dev string:x208>";
        array[ "<dev string:x21c>" ] = "<dev string:x22d>";
        array[ "<dev string:x241>" ] = "<dev string:x252>";
        array[ "<dev string:x266>" ] = "<dev string:x277>";
        array[ "<dev string:x28b>" ] = "<dev string:x29c>";
        array[ "<dev string:x2b0>" ] = "<dev string:x2c1>";
        array[ "<dev string:x2d5>" ] = "<dev string:x2dd>";
        array[ "<dev string:x2ef>" ] = "<dev string:x2f6>";
        array[ "<dev string:x307>" ] = "<dev string:x312>";
        array[ "<dev string:x327>" ] = "<dev string:x330>";
        array[ "<dev string:x343>" ] = "<dev string:x34b>";
        array[ "<dev string:x35d>" ] = "<dev string:x365>";
        array[ "<dev string:x377>" ] = "<dev string:x37f>";
        array[ "<dev string:x391>" ] = "<dev string:x39a>";
        array[ "<dev string:x3ad>" ] = "<dev string:x3b6>";
        array[ "<dev string:x3c9>" ] = "<dev string:x3d4>";
        array[ "<dev string:x3e7>" ] = "<dev string:x3f3>";
        array[ "<dev string:x407>" ] = "<dev string:x412>";
        array[ "<dev string:x425>" ] = "<dev string:x430>";
        array[ "<dev string:x443>" ] = "<dev string:x44f>";
        skinref = undefined;
        dvar = hashcat( @"hash_e340a5ee5afde790", self getentitynumber() );
        dvarval = getdvar( dvar );
        
        if ( dvarval != "<dev string:x466>" && isdefined( array[ dvarval ] ) )
        {
            skinref = array[ dvarval ];
        }
        else
        {
            randomkey = array_random( getarraykeys( array ) );
            skinref = array[ randomkey ];
        }
        
        operatorref = scripts\cp_mp\operator::function_605079124463a67b( skinref );
        scripts\mp\teams::createoperatorcustomization( operatorref, undefined );
        scripts\mp\class::giveloadout( self.team, self.class, undefined, undefined, 0 );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x6b8
    // Size: 0x65, Type: dev
    function function_117a90f752406598()
    {
        host = scripts\mp\gamelogic::gethostplayer();
        setdvarifuninitialized( @"hash_5d7942ff9a328997", 1 );
        
        if ( !isdefined( level.var_c192bb3f79de7dbf ) )
        {
            level namespace_8885c19c053dcb46::function_c24d9aca5f9eba35();
        }
        
        br_ending::play_ending( teams::getteamdata( host.team, "<dev string:x46a>" ), host.origin );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x725
    // Size: 0x3da, Type: dev
    function function_9dd3d565e1ba2f03()
    {
        devgui::function_6e7290c8ee4f558b( "<dev string:x475>" );
        devgui::function_a9a864379a098ad6( "<dev string:x485>", "<dev string:x49f>", &function_117a90f752406598 );
        devgui::function_fe953f000498048f();
        var_290b775dfa48665 = 0;
        var_ebe477033d06f099 = 0;
        
        while ( !isdefined( level.players ) || level.players.size == 0 )
        {
            wait 1;
        }
        
        wait 20;
        
        while ( true )
        {
            wait 0.1;
            
            if ( !var_ebe477033d06f099 && !var_290b775dfa48665 && getdvarint( @"hash_19a406e3c51ce52f" ) )
            {
                level.br_ending_debugmode = 1;
                thread function_2fc595ab59dafc25( "<dev string:x4b1>" );
                var_290b775dfa48665 = 1;
                thread function_652652964c77da84();
                
                foreach ( player in level.players )
                {
                    if ( player ishost() )
                    {
                        player thread function_facc80fe01aef30();
                    }
                }
            }
            else if ( var_290b775dfa48665 && !getdvarint( @"hash_19a406e3c51ce52f" ) )
            {
                var_290b775dfa48665 = 0;
                level notify( "<dev string:x4d1>" );
                thread function_2fc595ab59dafc25( "<dev string:x4f0>", 3 );
                level.br_ending_debugmode = undefined;
            }
            else if ( !var_290b775dfa48665 && !var_ebe477033d06f099 && getdvarint( @"hash_2d200a3da7fb2518" ) )
            {
                level.br_ending_debugmode = 1;
                mode = getdvarint( @"hash_2d200a3da7fb2518" );
                
                if ( mode == 2 )
                {
                    function_53e397de3c413997();
                }
                else
                {
                    function_1ee78b6d0f6f10f7();
                }
                
                level.br_ending_debugmode = undefined;
            }
            else if ( !var_290b775dfa48665 && !var_ebe477033d06f099 && getdvarint( @"hash_5be228e043cb645a" ) )
            {
                player = level.players[ 0 ];
                winners = scripts\mp\utility\teams::getteamdata( player.team, "<dev string:x46a>" );
                var_a6b3fae0395f75c3 = scripts\mp\gametypes\br_ending::function_9afbee75cfe14b8d();
                transientname = function_2845c7aff5b6d7b6( var_a6b3fae0395f75c3 );
                loadinfiltransient( transientname );
                
                for ( var_24b79087f3897e94 = 0; !var_24b79087f3897e94 ; var_24b79087f3897e94 = isinfiltransientloaded( transientname ) )
                {
                    waitframe();
                }
                
                level.arrow.transientloaded = 1;
                play_ending( winners, player.origin );
                setdvar( @"hash_5be228e043cb645a", 0 );
            }
            
            if ( getdvarint( @"hash_9f63b6e7903d0e54", -1 ) > -1 )
            {
                killnum = getdvarint( @"hash_9f63b6e7903d0e54" );
                
                foreach ( player in level.players )
                {
                    if ( killnum == player getentitynumber() )
                    {
                        if ( isalive( player ) )
                        {
                            player kill();
                            break;
                        }
                    }
                }
                
                setdvar( @"hash_9f63b6e7903d0e54", -1 );
            }
            
            if ( getdvarint( @"hash_c331bd97a07debe2", -1 ) > -1 )
            {
                kicknum = getdvarint( @"hash_c331bd97a07debe2" );
                println( "<dev string:x511>" + kicknum );
                
                foreach ( player in level.players )
                {
                    if ( kicknum == player getentitynumber() )
                    {
                        kick( kicknum, "<dev string:x524>" );
                        break;
                    }
                }
                
                setdvar( @"hash_c331bd97a07debe2", -1 );
            }
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0xb07
    // Size: 0x7d0, Type: dev
    function function_facc80fe01aef30()
    {
        level endon( "<dev string:x4d1>" );
        level.var_59d3ce664628caf4 = spawnstruct();
        level.var_59d3ce664628caf4.var_1c589f8f06d81b70 = function_bd87576b75af246();
        level.var_59d3ce664628caf4.var_e4211a476e76b65a = level.var_59d3ce664628caf4.var_1c589f8f06d81b70.size;
        level.var_59d3ce664628caf4.var_270f34f785b2df1f = 0;
        
        foreach ( struct in level.var_59d3ce664628caf4.var_1c589f8f06d81b70 )
        {
            if ( !isdefined( struct.angles ) )
            {
                struct.angles = ( 0, 0, 0 );
            }
        }
        
        var_a6b3fae0395f75c3 = function_9afbee75cfe14b8d();
        transientname = function_2845c7aff5b6d7b6( var_a6b3fae0395f75c3 );
        loadinfiltransient( transientname );
        
        for ( var_24b79087f3897e94 = 0; !var_24b79087f3897e94 ; var_24b79087f3897e94 = isinfiltransientloaded( transientname ) )
        {
            waitframe();
        }
        
        if ( !function_b5e265cde17f09d1( var_a6b3fae0395f75c3 ) )
        {
            level.var_59d3ce664628caf4.collision_tests = function_b1e9104bb425eed6( var_a6b3fae0395f75c3 );
        }
        
        childthread cursor_think();
        
        while ( true )
        {
            waitframe();
            
            if ( self usebuttonpressed() )
            {
                if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
                {
                    function_83f63b509c56f86c();
                }
                else if ( isdefined( level.var_59d3ce664628caf4.cursor_highlight ) )
                {
                    function_ce2d34095221c720( level.var_59d3ce664628caf4.cursor_highlight );
                    level.var_59d3ce664628caf4.cursor_highlight = undefined;
                }
                else
                {
                    function_ce2d34095221c720();
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self weaponswitchbuttonpressed() )
            {
                if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
                {
                    level.var_59d3ce664628caf4.var_1c589f8f06d81b70[ level.var_59d3ce664628caf4.var_1c589f8f06d81b70.size ] = level.var_59d3ce664628caf4.var_9709609a00e4c585;
                    function_83f63b509c56f86c();
                }
                else
                {
                    endtime = gettime() + 2000;
                    
                    while ( gettime() < endtime && self weaponswitchbuttonpressed() )
                    {
                        waitframe();
                    }
                    
                    if ( self weaponswitchbuttonpressed() )
                    {
                        function_54b03fa89c164504();
                    }
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self fragbuttonpressed() )
            {
                if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
                {
                    origin = level.var_59d3ce664628caf4.var_9709609a00e4c585.origin;
                    angles = level.var_59d3ce664628caf4.cursor_ang;
                    function_83f63b509c56f86c();
                    function_ce2d34095221c720();
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.origin = origin;
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.angles = angles;
                }
                else
                {
                    level.var_59d3ce664628caf4.var_563a1ce3c161c5db = angleclamp180( level.var_59d3ce664628caf4.var_563a1ce3c161c5db - 10 );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self secondaryoffhandbuttonpressed() )
            {
                if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
                {
                    origin = level.var_59d3ce664628caf4.var_9709609a00e4c585.origin;
                    angles = level.var_59d3ce664628caf4.var_9709609a00e4c585.angles;
                    function_83f63b509c56f86c();
                    function_ce2d34095221c720();
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.origin = origin;
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.angles = angles;
                }
                else
                {
                    level.var_59d3ce664628caf4.var_563a1ce3c161c5db = angleclamp180( level.var_59d3ce664628caf4.var_563a1ce3c161c5db + 10 );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self buttonpressed( "<dev string:x538>" ) )
            {
                if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
                {
                    origin = level.var_59d3ce664628caf4.var_9709609a00e4c585.origin + ( 0, 0, 6 );
                    angles = level.var_59d3ce664628caf4.var_9709609a00e4c585.angles;
                    function_83f63b509c56f86c();
                    function_ce2d34095221c720();
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.origin = origin;
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.angles = angles;
                }
                else
                {
                    level.var_59d3ce664628caf4.var_15042a5b64d3849c = int( level.var_59d3ce664628caf4.var_15042a5b64d3849c + 6 );
                    iprintlnbold( "<dev string:x543>" + level.var_59d3ce664628caf4.var_15042a5b64d3849c );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self buttonpressed( "<dev string:x55b>" ) )
            {
                if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
                {
                    origin = level.var_59d3ce664628caf4.var_9709609a00e4c585.origin + ( 0, 0, -6 );
                    angles = level.var_59d3ce664628caf4.var_9709609a00e4c585.angles;
                    function_83f63b509c56f86c();
                    function_ce2d34095221c720();
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.origin = origin;
                    level.var_59d3ce664628caf4.var_9709609a00e4c585.angles = angles;
                }
                else
                {
                    level.var_59d3ce664628caf4.var_15042a5b64d3849c = int( level.var_59d3ce664628caf4.var_15042a5b64d3849c - 6 );
                    iprintlnbold( "<dev string:x543>" + level.var_59d3ce664628caf4.var_15042a5b64d3849c );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self buttonpressed( "<dev string:x568>" ) )
            {
                level.var_59d3ce664628caf4.var_15042a5b64d3849c = 0;
                iprintlnbold( "<dev string:x543>" + level.var_59d3ce664628caf4.var_15042a5b64d3849c );
                wait 0.4;
                continue;
            }
            
            if ( self meleebuttonpressed() )
            {
                level.var_59d3ce664628caf4.var_270f34f785b2df1f = !level.var_59d3ce664628caf4.var_270f34f785b2df1f;
                
                if ( level.var_59d3ce664628caf4.var_270f34f785b2df1f )
                {
                    iprintlnbold( "<dev string:x575>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x590>" );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self sprintbuttonpressed() )
            {
                if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
                {
                    endtime = gettime() + 2000;
                    
                    while ( gettime() < endtime && self sprintbuttonpressed() )
                    {
                        waitframe();
                    }
                    
                    iprintlnbold( "<dev string:x5ac>" );
                    function_f5c4b4c2a4e8e220( level.var_59d3ce664628caf4.var_9709609a00e4c585 );
                    wait 0.4;
                    continue;
                }
                
                function_2fc595ab59dafc25( "<dev string:x5d3>", 1 );
            }
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x12df
    // Size: 0x204, Type: dev
    function function_b1e9104bb425eed6( var_a6b3fae0395f75c3 )
    {
        array = [];
        structs = [];
        bgbar = newhudelem();
        bgbar.vertalign = "<dev string:x5f9>";
        bgbar.horzalign = "<dev string:x603>";
        bgbar.aligny = "<dev string:x5f9>";
        bgbar.x = -250;
        bgbar.y = 100;
        bgbar setshader( "<dev string:x60d>", 500, 16 );
        bar = newhudelem();
        bar.vertalign = "<dev string:x5f9>";
        bar.horzalign = "<dev string:x603>";
        bar.aligny = "<dev string:x5f9>";
        bar.x = -250 + int( 2 );
        bar.y = 100;
        bar.sort = 1;
        bar.maxwidth = 496;
        bar.maxheight = 12;
        bar setshader( "<dev string:x616>", 0, 12 );
        bar.percent = 0;
        level.var_59d3ce664628caf4.bar = bar;
        var_79a78f73d2d4925d = function_5197cc12048f8766( var_a6b3fae0395f75c3 );
        
        foreach ( i, argstruct in var_79a78f73d2d4925d )
        {
            structs[ structs.size ] = function_efc9d79fca4c313d( argstruct );
            adjust_bar( i / var_79a78f73d2d4925d.size );
        }
        
        bar adjust_bar( 1 );
        waitframe();
        bgbar destroy();
        bar destroy();
        
        if ( isdefined( level.var_2e10660bd87fffd9 ) )
        {
            level.var_2e10660bd87fffd9.alpha = 0;
        }
        
        return structs;
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x14eb
    // Size: 0x63, Type: dev
    function adjust_bar( percent )
    {
        bar = level.var_59d3ce664628caf4.bar;
        bar.percent = percent;
        bar scaleovertime( 0.05, int( bar.maxwidth * percent ), bar.maxheight );
    }

    #using_animtree( "mp_vehicles_always_loaded" );

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x1556
    // Size: 0x17, Type: dev
    function function_e71304c34e3c6962( argstruct )
    {
        self useanimtree( #animtree );
    }

    #using_animtree( "script_model" );

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x1575
    // Size: 0x17, Type: dev
    function function_9cb7084e67f532c9( argstruct )
    {
        self useanimtree( #animtree );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x1594
    // Size: 0x30, Type: dev
    function function_55ed5b4967f1130d( argstruct )
    {
        if ( istrue( argstruct.var_d4364a524e8a2bcd ) )
        {
            function_e71304c34e3c6962( argstruct );
            return;
        }
        
        function_9cb7084e67f532c9( argstruct );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x15cc
    // Size: 0x2e9, Type: dev
    function function_efc9d79fca4c313d( argstruct )
    {
        angles = ( 0, 0, 0 );
        origin = ( 0, 0, 0 );
        struct = spawnstruct();
        struct.argstruct = argstruct;
        
        if ( isdefined( argstruct.numsegments ) )
        {
            assert( isdefined( argstruct.modelname ) );
            assert( argstruct.numsegments > 0 );
            model = spawn( "<dev string:x61f>", origin );
            model.angles = angles;
            model setmodel( argstruct.modelname );
            model function_55ed5b4967f1130d( argstruct );
            model animscripted( argstruct.animref, origin, angles, argstruct.animref, undefined, undefined, 0 );
            fracdiff = 1 / argstruct.numsegments;
            struct.path = [];
            
            for ( i = 0; i < argstruct.numsegments ; i++ )
            {
                model setanimtime( argstruct.animref, fracdiff * i );
                wait 0.1;
                
                if ( i > 0 )
                {
                    if ( distancesquared( struct.path[ struct.path.size - 1 ], model.origin ) < 2500 )
                    {
                        continue;
                    }
                }
                
                struct.path[ struct.path.size ] = model.origin;
            }
            
            model delete();
        }
        else if ( isdefined( argstruct.sphereradius ) )
        {
            model = spawn( "<dev string:x61f>", origin );
            model.angles = angles;
            model setmodel( argstruct.modelname );
            model function_55ed5b4967f1130d( argstruct );
            model animscripted( argstruct.animref, origin, angles, argstruct.animref, undefined, undefined, 0 );
            wait 0.1;
            model setanimtime( argstruct.animref, argstruct.animpct );
            wait 0.1;
            struct.origin = model.origin;
            struct.angles = model.angles;
            model delete();
        }
        else
        {
            assert( isdefined( argstruct.cylinderradius ) );
            struct.origin = getstartorigin( origin, angles, argstruct.animref ) + ( 0, 0, 2 );
            struct.angles = getstartangles( origin, angles, argstruct.animref );
            waitframe();
        }
        
        return struct;
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x18bd
    // Size: 0x163, Type: dev
    function function_54b03fa89c164504()
    {
        startpos = ( -60000, -60000, 0 );
        structs = sortbydistance( level.var_59d3ce664628caf4.var_1c589f8f06d81b70, startpos );
        println( "<dev string:x62f>" );
        println( "<dev string:x466>" );
        
        for ( i = 0; i < structs.size ; i++ )
        {
            if ( isdefined( structs[ i ].var_fcb6c737b5ecef23 ) )
            {
                println( "<dev string:x68b>" + i + "<dev string:x698>" + structs[ i ].origin + "<dev string:x6b0>" + structs[ i ].angles + "<dev string:x6b6>" );
                continue;
            }
            
            println( "<dev string:x68b>" + i + "<dev string:x698>" + structs[ i ].origin + "<dev string:x6b0>" + structs[ i ].angles + "<dev string:x6c0>" );
        }
        
        println( "<dev string:x466>" );
        total = structs.size;
        diff = total - level.var_59d3ce664628caf4.var_e4211a476e76b65a;
        thread function_2fc595ab59dafc25( "<dev string:x6c7>" + total + "<dev string:x6ee>" + diff, 8 );
        println( "<dev string:x6f8>" + total + "<dev string:x741>" + diff + "<dev string:x74b>" );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x1a28
    // Size: 0x1d3, Type: dev
    function function_83f63b509c56f86c()
    {
        var_a6b3fae0395f75c3 = function_9afbee75cfe14b8d();
        
        if ( !isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) || !function_b5e265cde17f09d1( var_a6b3fae0395f75c3 ) && !isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585.packs ) )
        {
            return;
        }
        
        level.var_59d3ce664628caf4.var_9709609a00e4c585 notify( "<dev string:x770>" );
        
        if ( !function_b5e265cde17f09d1( var_a6b3fae0395f75c3 ) )
        {
            foreach ( pack in level.var_59d3ce664628caf4.var_9709609a00e4c585.packs )
            {
                foreach ( ent in pack.ents )
                {
                    if ( !isdefined( ent ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( ent.linkedents ) )
                    {
                        array_delete( ent.linkedents );
                    }
                    
                    ent delete();
                }
            }
            
            if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585.cam ) )
            {
                level.var_59d3ce664628caf4.var_9709609a00e4c585.cam delete();
            }
            
            level.player cameraunlink();
            level.player stopxcam();
        }
        
        level.var_59d3ce664628caf4.var_9709609a00e4c585 = undefined;
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x1c03
    // Size: 0x3c, Type: dev
    function function_f5c4b4c2a4e8e220( removestruct )
    {
        level.var_59d3ce664628caf4.var_1c589f8f06d81b70 = array_remove( level.var_59d3ce664628caf4.var_1c589f8f06d81b70, removestruct );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x1c47
    // Size: 0x105, Type: dev
    function function_ce2d34095221c720( structoverride )
    {
        if ( isdefined( structoverride ) )
        {
            animstruct = structoverride;
        }
        else
        {
            animstruct = spawnstruct();
            animstruct.origin = level.var_59d3ce664628caf4.cursor_pos;
            animstruct.angles = level.var_59d3ce664628caf4.cursor_ang;
        }
        
        animstruct.pack = spawnstruct();
        animstruct.pack.models = [];
        animstruct.pack.players = [];
        animstruct.pack.cams = [];
        animstruct.istemp = 1;
        level.var_59d3ce664628caf4.var_9709609a00e4c585 = animstruct;
        level.br_ending = animstruct;
        level.var_59d3ce664628caf4.var_9709609a00e4c585 function_980d0b7c0096bb37();
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x1d54
    // Size: 0x165, Type: dev
    function function_980d0b7c0096bb37()
    {
        self endon( "<dev string:x770>" );
        waitframe();
        
        if ( level.script != "<dev string:x788>" && !isdefined( level.var_861898b95b936d83 ) )
        {
            function_788c4eeeeb69900f();
        }
        
        players = array_combine( [ level.player ], level.var_861898b95b936d83 );
        self.winners = players;
        var_a6b3fae0395f75c3 = function_9afbee75cfe14b8d();
        set_ending_pack( var_a6b3fae0395f75c3, undefined );
        wait 1;
        
        if ( function_b5e265cde17f09d1( var_a6b3fae0395f75c3 ) )
        {
            player = level.players[ 0 ];
            player setcinematicmotionoverride( "<dev string:x798>" );
            player utility::hidehudenable();
            childthread function_84068c30364b89cb();
            return;
        }
        
        player = level.players[ 0 ];
        player_rigs = [];
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isdefined( players[ i ] ) )
            {
                continue;
            }
            
            player = players[ i ];
            player setcinematicmotionoverride( "<dev string:x798>" );
            player utility::hidehudenable();
            
            if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
            {
                continue;
            }
            
            player create_player_rig( player.animname, "<dev string:x7a4>", self );
            player_rigs[ player_rigs.size ] = player.player_rig;
        }
        
        childthread function_6c67cb42fa6c83d2( players, player_rigs );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x1ec1
    // Size: 0x109, Type: dev
    function function_788c4eeeeb69900f()
    {
        var_b747aaa441b7aea9 = 3;
        scripts\mp\dev::spawn_test_clients( var_b747aaa441b7aea9 );
        level.var_861898b95b936d83 = [];
        
        foreach ( player in level.players )
        {
            if ( istestclient( player ) )
            {
                level.var_861898b95b936d83[ level.var_861898b95b936d83.size ] = player;
            }
        }
        
        while ( true )
        {
            spawncount = 0;
            
            foreach ( player in level.var_861898b95b936d83 )
            {
                if ( istrue( player.hasspawned ) )
                {
                    spawncount++;
                }
            }
            
            if ( spawncount == level.var_861898b95b936d83.size )
            {
                break;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 3
    // Checksum 0x0, Offset: 0x1fd2
    // Size: 0x37, Type: dev
    function function_6c67cb42fa6c83d2( players, player_rigs, play_once )
    {
        childthread function_9b6ad484e6bfa268();
        
        while ( true )
        {
            function_1c6d73d1832aefd6( players, player_rigs );
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 2
    // Checksum 0x0, Offset: 0x2011
    // Size: 0x49f, Type: dev
    function function_1c6d73d1832aefd6( players, player_rigs )
    {
        level endon( "<dev string:x7ba>" );
        
        foreach ( pack in self.packs )
        {
            if ( isdefined( pack.startfunc ) )
            {
                [[ pack.startfunc ]]( pack.paramarray );
            }
            
            if ( pack.players.size > 0 )
            {
                pack.players = array_removeundefined( pack.players );
                
                foreach ( player in pack.players )
                {
                    player dontinterpolate();
                    
                    if ( isdefined( player.linkedtoent ) )
                    {
                        player.linkedtoent thread anim_player_solo( player, player.player_rig, pack.anime, player.linkedtotag );
                        continue;
                    }
                    
                    thread anim_player_solo( player, player.player_rig, pack.anime );
                }
            }
            
            if ( pack.ents.size > 0 )
            {
                foreach ( ent in pack.ents )
                {
                    if ( !istrue( ent.dontteleport ) )
                    {
                        ent dontinterpolate();
                    }
                }
                
                thread anim_single( pack.ents, pack.anime );
            }
            
            shouldattach = 0;
            
            if ( !isdefined( level.var_59d3ce664628caf4 ) )
            {
                shouldattach = 1;
            }
            else if ( istrue( level.var_59d3ce664628caf4.var_270f34f785b2df1f ) )
            {
                shouldattach = 1;
            }
            
            if ( isdefined( pack.xcamasset ) )
            {
                self.cam dontinterpolate();
                thread anim_single_solo( self.cam, pack.anime );
                
                foreach ( player in level.players )
                {
                    player cameraunlink();
                }
                
                xcamlength = getxcamlength( pack.xcamasset );
                xcamlength -= 0.033;
                xcamlength -= mod( xcamlength, 0.05 );
                self.xcamasset = pack.xcamasset;
                self.xcamtime = gettime();
                
                if ( shouldattach )
                {
                    level.players[ 0 ] playxcam( pack.xcamasset, 0, self.origin, self.angles );
                    self.var_1384d8bd817f644 = 1;
                }
                
                wait xcamlength;
            }
            else
            {
                foreach ( player in level.players )
                {
                    player stopxcam();
                }
                
                self.xcamasset = undefined;
                self.xcamtime = undefined;
                self.var_1384d8bd817f644 = 0;
                
                if ( shouldattach )
                {
                    level.players[ 0 ] cameralinkto( self.cam, "<dev string:x7db>", 1, 1 );
                }
                
                self.cam dontinterpolate();
                anim_single_solo( self.cam, pack.anime );
            }
            
            waitframe();
            
            if ( isdefined( pack.endfunc ) )
            {
                [[ pack.endfunc ]]( pack.var_315361abd838fad4 );
            }
        }
        
        foreach ( player in level.players )
        {
            player.linkedtoent = undefined;
            player.linkedtotag = undefined;
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x24b8
    // Size: 0x11a, Type: dev
    function function_9b6ad484e6bfa268()
    {
        wait 0.1;
        
        while ( true )
        {
            if ( level.var_59d3ce664628caf4.var_270f34f785b2df1f )
            {
                if ( isdefined( self.xcamasset ) && isdefined( self.xcamtime ) )
                {
                    if ( !istrue( self.var_1384d8bd817f644 ) )
                    {
                        timeoffset = ( gettime() - self.xcamtime ) * 0.001;
                        level.players[ 0 ] playxcam( self.xcamasset, 0, self.origin, self.angles, timeoffset );
                        self.var_1384d8bd817f644 = 1;
                    }
                }
                else if ( isdefined( level.players[ 0 ].player_rig ) )
                {
                    level.players[ 0 ] cameralinkto( self.cam, "<dev string:x7db>", 1, 1 );
                }
            }
            else
            {
                level.players[ 0 ] cameraunlink();
                level.players[ 0 ] stopxcam();
                self.var_1384d8bd817f644 = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x25da
    // Size: 0x430, Type: dev
    function cursor_think()
    {
        level.var_59d3ce664628caf4.var_563a1ce3c161c5db = 0;
        level.var_59d3ce664628caf4.var_15042a5b64d3849c = 0;
        level.var_59d3ce664628caf4.cursor_pos = self.origin;
        level.var_59d3ce664628caf4.cursor_ang = self.angles;
        level.var_59d3ce664628caf4.cursor_highlight = undefined;
        maxdrawdist = 500000;
        var_5adc3ff44d7a1b85 = maxdrawdist * 0.8;
        var_57206f9835a87bc5 = var_5adc3ff44d7a1b85 * var_5adc3ff44d7a1b85;
        var_b8de365ae15a4559 = maxdrawdist - var_5adc3ff44d7a1b85;
        var_fdf5a004367563ac = 1000;
        var_785529d63cfd5142 = squared( var_fdf5a004367563ac );
        var_25cf9efcc9b2800 = maxdrawdist - var_fdf5a004367563ac;
        
        while ( true )
        {
            waitframe();
            update_cursor();
            level.var_59d3ce664628caf4.cursor_pos += ( 0, 0, level.var_59d3ce664628caf4.var_15042a5b64d3849c );
            level.var_59d3ce664628caf4.cursor_ang = angleclamp180( self.angles + ( 0, level.var_59d3ce664628caf4.var_563a1ce3c161c5db, 0 ) );
            level.var_59d3ce664628caf4.cursor_highlight = undefined;
            
            foreach ( index, struct in level.var_59d3ce664628caf4.var_1c589f8f06d81b70 )
            {
                distsqrd = distance2dsquared( level.players[ 0 ].origin, struct.origin );
                
                if ( distsqrd < squared( maxdrawdist ) )
                {
                    if ( !isdefined( level.var_59d3ce664628caf4.cursor_highlight ) && distance2dsquared( struct.origin, level.var_59d3ce664628caf4.cursor_pos ) < 40000 )
                    {
                        level.var_59d3ce664628caf4.cursor_highlight = struct;
                        level.var_59d3ce664628caf4.cursor_pos = struct.origin;
                        level.var_59d3ce664628caf4.cursor_ang = struct.angles;
                        continue;
                    }
                    
                    alpha = 1;
                    size = 32;
                    
                    if ( distsqrd > var_785529d63cfd5142 )
                    {
                        if ( !isdefined( struct.var_fcb6c737b5ecef23 ) )
                        {
                            function_7835c2cb25c033c9( struct.origin, alpha, size, ( 1, 1, 0 ), undefined, index );
                        }
                        else
                        {
                            function_7835c2cb25c033c9( struct.origin, alpha, size, undefined, undefined, index );
                        }
                        
                        continue;
                    }
                    
                    draw_node( struct.origin, struct.angles, ( 0.9, 0.9, 0.9 ), size, alpha );
                }
            }
            
            if ( isdefined( level.var_59d3ce664628caf4.cursor_highlight ) )
            {
                function_75f7d0af300ea72a();
                continue;
            }
            
            if ( isdefined( level.var_59d3ce664628caf4.var_9709609a00e4c585 ) )
            {
                draw_node( level.var_59d3ce664628caf4.var_9709609a00e4c585.origin, level.var_59d3ce664628caf4.var_9709609a00e4c585.angles, ( 1, 1, 0 ), 16, 0.8 );
                draw_node( level.var_59d3ce664628caf4.var_9709609a00e4c585.origin, level.var_59d3ce664628caf4.cursor_ang, ( 0.1, 0.9, 0.1 ), 16, 0.97 );
                continue;
            }
            
            function_c1296c6ad87a8500();
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 6
    // Checksum 0x0, Offset: 0x2a12
    // Size: 0x125, Type: dev
    function function_7835c2cb25c033c9( origin, alpha, size, color, serverduration, text )
    {
        if ( !isdefined( color ) )
        {
            color = ( 0.9, 0.9, 0.9 );
        }
        
        if ( !isdefined( serverduration ) )
        {
            serverduration = 1;
        }
        
        if ( distance2dsquared( level.players[ 0 ].origin, origin ) > 24000 * 24000 )
        {
            return 0;
        }
        
        dist = distance2d( level.players[ 0 ].origin, origin );
        frac = ( dist - 24000 ) / ( 30000 - 24000 * 24000 );
        alpha = math::lerp( 1, 0.2, frac );
        
        if ( dist > 1000 )
        {
            frac = ( dist - 1000 ) / 29000;
            size = math::lerp( size, 100, frac );
            alpha = math::lerp( alpha, 0.5, frac );
        }
        
        if ( !isdefined( text ) )
        {
            text = "<dev string:x7e9>";
        }
        
        print3d( origin, text, color, alpha, size, serverduration );
        return 1;
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x2b3f
    // Size: 0x25f, Type: dev
    function function_75f7d0af300ea72a()
    {
        if ( !isdefined( level.var_59d3ce664628caf4.collision_tests ) )
        {
            draw_node( level.var_59d3ce664628caf4.cursor_pos, level.var_59d3ce664628caf4.cursor_ang, ( 1, 1, 0 ), 16 );
            return;
        }
        
        color = ( 1, 1, 0 );
        
        foreach ( test in level.var_59d3ce664628caf4.collision_tests )
        {
            if ( isdefined( test.argstruct.numsegments ) )
            {
                continue;
            }
            
            origin = level.var_59d3ce664628caf4.cursor_pos + rotatevector( test.origin, level.var_59d3ce664628caf4.cursor_ang );
            angles = combineangles( level.var_59d3ce664628caf4.cursor_ang, test.angles );
            
            if ( isdefined( test.argstruct.originoffset ) )
            {
                origin += test.argstruct.originoffset;
            }
            
            if ( isdefined( test.argstruct.cylinderradius ) )
            {
                cylinderradius = test.argstruct.cylinderradius;
                cylinderheight = test.argstruct.cylinderheight;
                cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, color );
                continue;
            }
            
            if ( isdefined( test.argstruct.sphereradius ) )
            {
                sphereradius = test.argstruct.sphereradius;
                sphere( origin, sphereradius, color );
            }
        }
        
        draw_node( level.var_59d3ce664628caf4.cursor_pos, level.var_59d3ce664628caf4.cursor_ang, color, 16 );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x2da6
    // Size: 0x466, Type: dev
    function function_c1296c6ad87a8500()
    {
        if ( !isdefined( level.var_59d3ce664628caf4.collision_tests ) )
        {
            draw_node( level.var_59d3ce664628caf4.cursor_pos, level.var_59d3ce664628caf4.cursor_ang, ( 0.8, 0.8, 0.8 ), 16 );
            return;
        }
        
        okcolor = ( 0.8, 0.8, 0.8 );
        badcolor = ( 0.8, 0, 0 );
        warningcolor = ( 0.8, 0.8, 0 );
        floattracedist = -100;
        var_818b52ae1635917c = abs( 2 / floattracedist );
        origin = undefined;
        angles = undefined;
        
        foreach ( test in level.var_59d3ce664628caf4.collision_tests )
        {
            if ( !isdefined( test.argstruct.numsegments ) )
            {
                origin = level.var_59d3ce664628caf4.cursor_pos + rotatevector( test.origin, level.var_59d3ce664628caf4.cursor_ang );
                angles = combineangles( level.var_59d3ce664628caf4.cursor_ang, test.angles );
                
                if ( isdefined( test.argstruct.originoffset ) )
                {
                    origin += test.argstruct.originoffset;
                }
            }
            
            if ( isdefined( test.argstruct.numsegments ) )
            {
                for ( i = 0; i < test.path.size - 1 ; i++ )
                {
                    origin = level.var_59d3ce664628caf4.cursor_pos + rotatevector( test.path[ i ], level.var_59d3ce664628caf4.cursor_ang );
                    origin2 = level.var_59d3ce664628caf4.cursor_pos + rotatevector( test.path[ i + 1 ], level.var_59d3ce664628caf4.cursor_ang );
                    line( origin, origin2, ( 1, 1, 1 ), 1, 1 );
                }
                
                continue;
            }
            
            if ( isdefined( test.argstruct.cylinderradius ) )
            {
                cylinderradius = test.argstruct.cylinderradius;
                cylinderheight = test.argstruct.cylinderheight;
                floatingtrace = scripts\engine\trace::capsule_trace( origin, origin + ( 0, 0, floattracedist ), cylinderradius + 2, cylinderheight + 4 );
                
                if ( floatingtrace[ "<dev string:x7ee>" ] >= var_818b52ae1635917c )
                {
                    cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, warningcolor );
                    print3d( origin, abs( floatingtrace[ "<dev string:x7ee>" ] * floattracedist ), warningcolor );
                }
                else if ( scripts\engine\trace::capsule_trace_passed( origin, origin + ( 0, 0, 4 ), cylinderradius + 2, cylinderheight + 4 ) )
                {
                    cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, okcolor );
                }
                else
                {
                    cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, badcolor );
                }
                
                continue;
            }
            
            if ( isdefined( test.argstruct.sphereradius ) )
            {
                sphereradius = test.argstruct.sphereradius;
                
                if ( scripts\engine\trace::sphere_trace_passed( origin, origin + ( 0, 0, 4 ), sphereradius ) )
                {
                    sphere( origin, sphereradius, okcolor );
                    continue;
                }
                
                sphere( origin, sphereradius, badcolor );
            }
        }
        
        draw_node( level.var_59d3ce664628caf4.cursor_pos, level.var_59d3ce664628caf4.cursor_ang, ( 0.8, 0.8, 0.8 ), 16 );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x3214
    // Size: 0x93, Type: dev
    function update_cursor()
    {
        start = self geteye();
        forward = anglestoforward( self getplayerangles() );
        start += forward * 30;
        end = start + forward * 20000;
        trace = ray_trace_detail( start, end );
        phys_trace = trace[ "<dev string:x7fa>" ];
        
        if ( distance( trace[ "<dev string:x7fa>" ], phys_trace ) < 0.1 )
        {
            level.var_59d3ce664628caf4.cursor_pos = phys_trace;
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x32af
    // Size: 0x2ed, Type: dev
    function function_652652964c77da84()
    {
        minx = min( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        maxx = max( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        miny = min( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxy = max( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxz = scripts\cp_mp\parachute::getc130height();
        minz = scripts\cp_mp\parachute::getc130sealevel() - 5000;
        spacing = 4000;
        points = [];
        pos = ( minx, miny, maxz );
        rownum = 0;
        
        while ( getdvarint( @"hash_19a406e3c51ce52f" ) > 0 )
        {
            droppedpos = drop_to_ground( pos, 0, -20000 );
            
            if ( droppedpos[ 2 ] > minz && !scripts\mp\outofbounds::ispointinoutofbounds( droppedpos ) )
            {
                points[ points.size ] = droppedpos;
            }
            
            pos += ( spacing, 0, 0 );
            
            if ( pos[ 0 ] > maxx )
            {
                rownum++;
                pos = ( minx, miny + rownum * spacing, maxz );
            }
            
            if ( pos[ 1 ] > maxy )
            {
                break;
            }
            
            waitframe();
        }
        
        setdvarifuninitialized( @"print3d_throttle", points.size / 4 );
        setdvarifuninitialized( @"hash_ef8fb66dfac2f050", 5 );
        
        while ( true )
        {
            var_327957576570ece5 = getdvarint( @"print3d_throttle" );
            drawcount = 0;
            
            foreach ( point in points )
            {
                inrange = 0;
                
                if ( function_ad0f628e841bd876( point ) )
                {
                    inrange = function_7835c2cb25c033c9( point, 1, 24, ( 0, 1, 0 ), getdvarint( @"hash_ef8fb66dfac2f050" ) );
                }
                else
                {
                    inrange = function_7835c2cb25c033c9( point, 1, 24, ( 1, 0, 0 ), getdvarint( @"hash_ef8fb66dfac2f050" ) );
                }
                
                if ( inrange )
                {
                    drawcount++;
                    
                    if ( var_327957576570ece5 > 0 && drawcount >= var_327957576570ece5 )
                    {
                        drawcount = 0;
                        waitframe();
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x35a4
    // Size: 0x8e, Type: dev
    function function_ad0f628e841bd876( point )
    {
        range = 64000000;
        
        foreach ( struct in level.var_59d3ce664628caf4.var_1c589f8f06d81b70 )
        {
            if ( distance2dsquared( point, struct.origin ) < range )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 6
    // Checksum 0x0, Offset: 0x363a
    // Size: 0xc6, Type: dev
    function draw_node( pos, angles, color, size, alpha, depthtest )
    {
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( size ) )
        {
            size = 32;
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        up = anglestoup( angles );
        fwd = anglestoforward( angles );
        start = pos + up;
        end = start + fwd * size;
        draw_small_arrow( start, end, color, alpha, depthtest );
        draw_box( pos, color, angles, size, alpha, depthtest );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 5
    // Checksum 0x0, Offset: 0x3708
    // Size: 0x12c, Type: dev
    function draw_small_arrow( start, end, color, alpha, depthtest )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        angle = vectortoangles( end - start );
        dist = length( end - start );
        forward = anglestoforward( angle );
        forwardfar = forward * dist;
        arrow_size = 5;
        forwardclose = forward * ( dist - arrow_size );
        right = anglestoright( angle );
        leftdraw = right * arrow_size * -1;
        rightdraw = right * arrow_size;
        line( start, end, color, alpha, depthtest, 1 );
        line( start, start + forwardfar, color, alpha, depthtest, 1 );
        line( start + forwardfar, start + forwardclose + rightdraw, color, alpha, depthtest, 1 );
        line( start + forwardfar, start + forwardclose + leftdraw, color, alpha, depthtest, 1 );
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 6
    // Checksum 0x0, Offset: 0x383c
    // Size: 0x1f1, Type: dev
    function draw_box( pos, color, angles, size, alpha, depthtest )
    {
        if ( !isdefined( size ) )
        {
            width = 32;
            height = 32;
        }
        else if ( !isarray( size ) )
        {
            width = size;
            height = size;
        }
        else
        {
            width = size[ 0 ];
            height = size[ 1 ];
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        forward = anglestoforward( angles );
        right = anglestoright( angles );
        up = anglestoup( angles );
        start = pos + forward * width * 0.5;
        start += right * width * 0.5;
        start += up * height * -0.5;
        points = [];
        points[ points.size ] = start;
        points[ points.size ] = points[ points.size - 1 ] + forward * width * -1;
        points[ points.size ] = points[ points.size - 1 ] + right * width * -1;
        points[ points.size ] = points[ points.size - 1 ] + forward * width;
        offset = height * up;
        
        for ( i = 0; i < points.size ; i++ )
        {
            line( points[ i ], points[ i ] + offset, color, alpha, depthtest );
            
            if ( i == points.size - 1 )
            {
                line( points[ i ], points[ 0 ], color, alpha, depthtest );
                line( points[ i ] + offset, points[ 0 ] + offset, color, alpha, depthtest );
                continue;
            }
            
            line( points[ i ], points[ i + 1 ], color, alpha, depthtest );
            line( points[ i ] + offset, points[ i + 1 ] + offset, color, alpha, depthtest );
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x3a35
    // Size: 0x6ab, Type: dev
    function function_1ee78b6d0f6f10f7()
    {
        animstruct = spawnstruct();
        animstruct.istemp = 1;
        animstruct.origin = ( -500000, -500000, 0 );
        animstruct.angles = ( 0, 0, 0 );
        structs = function_2979939f678d3ad1( function_9afbee75cfe14b8d() );
        animstruct.origin = structs[ 0 ].origin;
        animstruct.angles = structs[ 0 ].angles;
        function_788c4eeeeb69900f();
        players = array_combine( [ level.player ], level.var_861898b95b936d83 );
        thread function_2fc595ab59dafc25( "<dev string:x806>" );
        animstruct.winners = players;
        level.br_ending = animstruct;
        wait 1;
        player = level.players[ 0 ];
        player_rigs = [];
        var_a6b3fae0395f75c3 = function_9afbee75cfe14b8d();
        animstruct set_ending_pack( var_a6b3fae0395f75c3, undefined );
        level.var_af75c6e5758a8787[ "<dev string:x829>" ] = 0;
        level.var_af75c6e5758a8787[ "<dev string:x831>" ] = 0;
        level.player thread function_75ef2dd1a0eee7bc( animstruct );
        
        if ( function_b5e265cde17f09d1( var_a6b3fae0395f75c3 ) )
        {
            player = level.players[ 0 ];
            player setcinematicmotionoverride( "<dev string:x798>" );
            player utility::hidehudenable();
            index = 0;
            previndex = 0;
            
            while ( true )
            {
                if ( index < 0 )
                {
                    index = 0;
                }
                else if ( index > structs.size - 1 )
                {
                    index = structs.size - 1;
                }
                
                struct = structs[ index ];
                
                if ( isdefined( struct.var_fcb6c737b5ecef23 ) )
                {
                    println( "<dev string:x83a>" );
                    
                    if ( index < previndex )
                    {
                        index--;
                    }
                    else
                    {
                        index++;
                    }
                    
                    continue;
                }
                
                previndex = index;
                animstruct.origin = struct.origin;
                animstruct.angles = struct.angles;
                animstruct set_ending_pack( var_a6b3fae0395f75c3, undefined );
                waitframe();
                str = index + 1 + "<dev string:x862>" + structs.size + "<dev string:x869>" + animstruct.origin;
                thread function_2fc595ab59dafc25( str );
                animstruct function_84068c30364b89cb();
                
                if ( level.var_af75c6e5758a8787[ "<dev string:x829>" ] )
                {
                    index--;
                }
                else
                {
                    index++;
                }
                
                level.var_af75c6e5758a8787[ "<dev string:x829>" ] = 0;
                level.var_af75c6e5758a8787[ "<dev string:x831>" ] = 0;
            }
            
            return;
        }
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isdefined( players[ i ] ) )
            {
                continue;
            }
            
            player = players[ i ];
            player setcinematicmotionoverride( "<dev string:x798>" );
            player utility::hidehudenable();
            player create_player_rig( player.animname, "<dev string:x7a4>", animstruct );
            player_rigs[ player_rigs.size ] = player.player_rig;
            scripts\mp\outofbounds::enableoobimmunity( player );
        }
        
        animstruct.cam delete();
        
        foreach ( pack in animstruct.packs )
        {
            foreach ( ent in pack.ents )
            {
                if ( !isdefined( ent ) )
                {
                    continue;
                }
                
                if ( isdefined( ent.linkedents ) )
                {
                    array_delete( ent.linkedents );
                }
                
                ent delete();
            }
        }
        
        animstruct set_ending_pack( var_a6b3fae0395f75c3, undefined );
        index = 0;
        previndex = 0;
        
        while ( true )
        {
            if ( index < 0 )
            {
                index = 0;
            }
            else if ( index > structs.size - 1 )
            {
                index = structs.size - 1;
            }
            
            struct = structs[ index ];
            
            if ( isdefined( struct.var_fcb6c737b5ecef23 ) )
            {
                println( "<dev string:x83a>" );
                
                if ( index < previndex )
                {
                    index--;
                }
                else
                {
                    index++;
                }
                
                continue;
            }
            
            previndex = index;
            setomnvarforallclients( "<dev string:x86e>", 0 );
            animstruct.origin = struct.origin;
            animstruct.angles = struct.angles;
            animstruct chopperexfil_set_brcircle();
            animstruct.cam.origin = animstruct.origin;
            animstruct.cam stopanimscripted();
            animstruct anim_first_frame_solo( animstruct.cam, animstruct.packs[ 0 ].anime );
            
            foreach ( player in players )
            {
                player thread player_set_weapon();
                player cameraunlink();
                player stopxcam();
                player playerlinktodelta( player.player_rig, "<dev string:x7db>", 1, 0, 0, 0, 0, 1 );
                player.player_rig stopanimscripted();
                player.player_rig unlink();
                player.player_rig.origin = animstruct.origin;
                player.linkedtoent = undefined;
            }
            
            waitframe();
            
            if ( isdefined( level.players[ 0 ].player_rig ) )
            {
                level.players[ 0 ] cameralinkto( animstruct.cam, "<dev string:x7db>", 1, 1 );
            }
            
            waitframe();
            str = index + 1 + "<dev string:x862>" + structs.size + "<dev string:x869>" + animstruct.origin;
            thread function_2fc595ab59dafc25( str );
            animstruct function_1c6d73d1832aefd6( players, player_rigs );
            
            if ( level.var_af75c6e5758a8787[ "<dev string:x829>" ] )
            {
                index--;
            }
            else
            {
                index++;
            }
            
            level.var_af75c6e5758a8787[ "<dev string:x829>" ] = 0;
            level.var_af75c6e5758a8787[ "<dev string:x831>" ] = 0;
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x40e8
    // Size: 0x52, Type: dev
    function function_ab9fd11ef489ccf3()
    {
        num = self getentitynumber();
        
        while ( true )
        {
            line( self.origin, self.player_rig.origin );
            print3d( self.origin, num );
            waitframe();
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 1
    // Checksum 0x0, Offset: 0x4142
    // Size: 0xb5, Type: dev
    function function_75ef2dd1a0eee7bc( animstruct )
    {
        self endon( "<dev string:x87f>" );
        
        while ( true )
        {
            if ( !level.var_af75c6e5758a8787[ "<dev string:x829>" ] && self buttonpressed( "<dev string:x88d>" ) )
            {
                level.var_af75c6e5758a8787[ "<dev string:x831>" ] = 1;
                level notify( "<dev string:x7ba>" );
                animstruct notify( "<dev string:x770>" );
                wait 0.4;
            }
            else if ( !level.var_af75c6e5758a8787[ "<dev string:x831>" ] && self buttonpressed( "<dev string:x89b>" ) )
            {
                level.var_af75c6e5758a8787[ "<dev string:x829>" ] = 1;
                level notify( "<dev string:x7ba>" );
                animstruct notify( "<dev string:x770>" );
                wait 0.4;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 2
    // Checksum 0x0, Offset: 0x41ff
    // Size: 0x131, Type: dev
    function function_2fc595ab59dafc25( text, time )
    {
        level notify( "<dev string:x8a8>" );
        level endon( "<dev string:x8a8>" );
        
        if ( !isdefined( level.var_2e10660bd87fffd9 ) )
        {
            level.var_2e10660bd87fffd9 = newhudelem();
            level.var_2e10660bd87fffd9.archived = 0;
            level.var_2e10660bd87fffd9.vertalign = "<dev string:x5f9>";
            level.var_2e10660bd87fffd9.horzalign = "<dev string:x603>";
            level.var_2e10660bd87fffd9.aligny = "<dev string:x5f9>";
            level.var_2e10660bd87fffd9.alignx = "<dev string:x603>";
            level.var_2e10660bd87fffd9.y = 80;
            level.var_2e10660bd87fffd9.fontscale = 1.2;
        }
        
        level.var_2e10660bd87fffd9.alpha = 1;
        level.var_2e10660bd87fffd9 setdevtext( text );
        println( text );
        
        if ( isdefined( time ) )
        {
            wait time;
            level.var_2e10660bd87fffd9.alpha = 0;
        }
    }

    // Namespace namespace_bc2bdb06de29485d / namespace_db13b5d5ab9bfe9c
    // Params 0
    // Checksum 0x0, Offset: 0x4338
    // Size: 0x232, Type: dev
    function function_53e397de3c413997()
    {
        structs = function_2979939f678d3ad1( function_9afbee75cfe14b8d() );
        minx = min( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        maxx = max( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        miny = min( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxy = max( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxz = scripts\cp_mp\parachute::getc130height();
        midpointx = minx + ( maxx - minx ) * 0.5;
        midpointy = miny + ( maxy - miny ) * 0.5;
        origin = ( midpointx, midpointy, maxz );
        angles = ( 72, 90, 0 );
        
        if ( !level.player isnoclip() )
        {
            level.player noclip();
        }
        
        level.player setorigin( origin );
        level.player setplayerangles( angles );
        
        while ( getdvarint( @"hash_2d200a3da7fb2518" ) == 2 )
        {
            foreach ( struct in structs )
            {
                function_7835c2cb25c033c9( struct.origin, 1, 1000 );
            }
            
            waitframe();
        }
    }

#/
