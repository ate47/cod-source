#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_popup;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace namespace_3169ff42d7051988;

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x40c
// Size: 0x95
function init()
{
    /#
        if ( getdvarint( @"hash_ac8dfa3636c6e111", 0 ) == 0 )
        {
            return;
        }
    #/
    
    if ( getdvarint( @"hash_ac8dfa3636c6e111", 1 ) == 0 )
    {
        return;
    }
    
    level.var_b19067b41fd5cfe8 = 1;
    level.var_bf269015710de2dd = getdvarint( @"hash_a6b52f16f3853a9a", 0 );
    scripts\engine\utility::registersharedfunc( "ftue", "player_action", &function_1976438a8865ac27 );
    scripts\engine\utility::registersharedfunc( "hud", "ftue_trigger_landed_hint", &ftue_trigger_landed_hint );
    function_c7c9735d7c22924d();
    
    /#
        scripts\mp\gametypes\br_dev::registerhandlecommand( &function_8247afd76f1b33e0 );
    #/
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x4a9
// Size: 0x37
function function_c7c9735d7c22924d()
{
    level.var_7a5545c9a0d5bd22 = [];
    function_5a738b2f3b7d88d9( "br_ftue_supply_box", &function_598fb861f3171c2 );
    function_5a738b2f3b7d88d9( "br_ftue_sliding", &function_46c63a68a41e27a1 );
    level thread function_1126427a8a7a78cd();
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x4e8
// Size: 0x4e
function function_ae4b4de059d48ed( ref )
{
    if ( !isdefined( self.var_bab92b2713023287 ) )
    {
        self.var_bab92b2713023287 = [];
    }
    
    if ( isdefined( self.var_bab92b2713023287[ ref ] ) )
    {
        self.var_bab92b2713023287[ ref ]++;
        return;
    }
    
    self.var_bab92b2713023287[ ref ] = 1;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x53e
// Size: 0x9c
function function_86471673929333b2()
{
    if ( !isdefined( self.var_bab92b2713023287 ) )
    {
        return;
    }
    
    foreach ( ref, aggregate in self.var_bab92b2713023287 )
    {
        self dlog_recordplayerevent( "dlog_event_ftue_popup_aggregate", [ "is_ftue_playlist", istrue( level.var_bf269015710de2dd ), "ftue_popup_ref", ref, "ftue_popup_aggregate", aggregate ] );
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x5e2
// Size: 0x1b1
function function_1126427a8a7a78cd()
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    
    if ( getdvarint( @"hash_24c29de93e1ad520", 0 ) == 1 )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && !isbot( player ) )
            {
                player function_bfd3ae5074922ca4();
            }
        }
    }
    
    var_c502004b162c0807 = 0;
    var_1b35d2d08ce39687 = getdvarint( @"hash_2e1526107156458a", 5 );
    
    if ( var_1b35d2d08ce39687 <= 0 )
    {
        return;
    }
    
    wait 10;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && isalive( player ) )
            {
                foreach ( func in level.var_7a5545c9a0d5bd22 )
                {
                    if ( isdefined( func ) && isfunction( func ) )
                    {
                        player [[ func ]]();
                    }
                }
                
                var_c502004b162c0807++;
            }
            
            if ( var_c502004b162c0807 >= var_1b35d2d08ce39687 )
            {
                var_c502004b162c0807 = 0;
                wait getdvarint( @"hash_cae27c6584a113b1", 5000 ) / 1000;
            }
        }
        
        var_c502004b162c0807 = 0;
        wait getdvarint( @"hash_cae27c6584a113b1", 5000 ) / 1000;
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 2
// Checksum 0x0, Offset: 0x79b
// Size: 0x20
function function_5a738b2f3b7d88d9( ref, watcherfunc )
{
    level.var_7a5545c9a0d5bd22[ ref ] = watcherfunc;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x7c3
// Size: 0x2c
function function_df45ad64b9dc074b( ref )
{
    id = scripts\mp\hud_popup::function_bec00f5eabdb65ea( ref );
    return tablelookupbyrow( scripts\mp\hud_popup::function_92b0a87f4e1a1d72(), id, 4 );
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x7f8
// Size: 0x45
function function_470bb108e6b631cf( ref )
{
    id = scripts\mp\hud_popup::function_bec00f5eabdb65ea( ref );
    index = tablelookupbyrow( scripts\mp\hud_popup::function_92b0a87f4e1a1d72(), id, 5 );
    mask = 1 << index;
    return mask;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x846
// Size: 0x32, Type: bool
function function_2f0ba374d69e645c( ref )
{
    playerdata = function_f7754d7ad59b2f8b();
    mask = function_470bb108e6b631cf( ref );
    return istrue( playerdata & mask );
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x881
// Size: 0x1a5, Type: bool
function function_2da74cf301f9faa5( ref )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return false;
    }
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !scripts\mp\flags::gameflag( "br_ready_to_jump" ) && ref != "br_ftue_suggested_landing" )
    {
        return false;
    }
    
    if ( scripts\mp\utility\player::isinlaststand( self ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( scripts\mp\outofbounds::isoob( self ) )
    {
        return false;
    }
    
    if ( isdefined( self.br_kiosk ) )
    {
        return false;
    }
    
    if ( function_eff88219461e17e6( ref ) )
    {
        return false;
    }
    
    if ( function_2f0ba374d69e645c( ref ) )
    {
        function_ae4b4de059d48ed( ref );
        return false;
    }
    
    popupduration = getdvarint( @"hash_185628cd0876e868", 12000 );
    popupdelay = getdvarint( @"hash_c2618ebb2ca593d3", 3000 );
    
    if ( isdefined( self.lastpopuptime ) && gettime() - self.lastpopuptime <= popupduration + popupdelay )
    {
        return false;
    }
    
    if ( ref != "br_ftue_gas" && function_24c5a8d31ae262f( self.origin ) && ref != "br_ftue_suggested_landing" )
    {
        return false;
    }
    
    if ( !function_8f15851557170215( ref ) )
    {
        var_874ac286d355a3b2 = getdvarint( @"hash_1e4d5603f4b10d4d", 3000 );
        var_196d2b0aaa33db5d = getdvarint( @"hash_3ebb28ca5b9b3010", 500 );
        var_f2e473b17ca70265 = self getclosestenemy( var_874ac286d355a3b2, var_196d2b0aaa33db5d, 1 );
        
        if ( isdefined( var_f2e473b17ca70265 ) && !isagent( var_f2e473b17ca70265 ) )
        {
            return false;
        }
        
        if ( function_88c626bafd6057bf( self ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0xa2f
// Size: 0x141
function function_8fdd864a86afe560( pingent )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_7f7ff49d4459fedd", 0 ) == 1 )
    {
        return;
    }
    
    if ( !isdefined( pingent ) )
    {
        return;
    }
    
    pingindex = undefined;
    
    if ( isvector( pingent ) )
    {
        pingindex = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 16, pingent + ( 0, 0, 82 ) );
    }
    else if ( isent( pingent ) && isplayer( pingent ) && isdefined( pingent.team ) && isalive( pingent ) )
    {
        if ( self.team != pingent.team )
        {
            pingindex = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 6, pingent.origin + ( 0, 0, 82 ), 0 );
        }
        else
        {
            pingindex = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 16, pingent.origin + ( 0, 0, 82 ), pingent getentitynumber() );
        }
    }
    else if ( pingent getscriptableisloot() )
    {
        pingindex = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 19, pingent.origin, pingent.index );
    }
    else
    {
        return;
    }
    
    if ( isdefined( pingindex ) )
    {
        thread scripts\cp_mp\calloutmarkerping::_calloutmarkerping_predicted_timeout( pingindex );
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 2
// Checksum 0x0, Offset: 0xb78
// Size: 0x66
function function_1976438a8865ac27( ref, pingent )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( istrue( level.var_b19067b41fd5cfe8 ) && function_2da74cf301f9faa5( ref ) )
    {
        scripts\mp\hud_popup::function_65336cc44771776e( ref );
        thread function_8fdd864a86afe560( pingent );
        thread function_d42afc6ef83aafca( ref );
        self playlocalsound( "uin_iw9_ftue_tip_generic" );
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0xbe6
// Size: 0x3e, Type: bool
function function_78172a2df0f18be4( ref )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( isdefined( self.br_kiosk ) )
    {
        return false;
    }
    
    if ( function_88c626bafd6057bf( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 3
// Checksum 0x0, Offset: 0xc2d
// Size: 0xe7
function function_d42afc6ef83aafca( ref, mask, bimmediate )
{
    assert( isplayer( self ) );
    self endon( "remove_ftue_popup" );
    
    if ( !istrue( bimmediate ) )
    {
        waitduration = getdvarint( @"hash_185628cd0876e868", 12000 ) / 1000;
        wait waitduration;
    }
    
    if ( !function_78172a2df0f18be4( ref ) )
    {
        function_240d450c0ec5f614( ref );
        return;
    }
    
    if ( ref == "br_ftue_suggested_landing" )
    {
        return;
    }
    
    if ( istrue( level.var_b19067b41fd5cfe8 ) )
    {
        playerdata = function_f7754d7ad59b2f8b();
        mask = function_470bb108e6b631cf( ref );
        playerdata |= mask;
        function_9406f25ca59385d7( playerdata );
        isftueplaylist = istrue( level.var_bf269015710de2dd );
        self dlog_recordplayerevent( "dlog_event_ftue_popup_initial", [ "ftue_popup_ref", ref, "is_ftue_playlist", isftueplaylist ] );
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0xd1c
// Size: 0x43
function function_d0ccb374806fe494()
{
    if ( isdefined( self.var_942b501d544b0e0a ) && !function_2f0ba374d69e645c( self.var_942b501d544b0e0a ) )
    {
        self notify( "remove_ftue_popup" );
        function_240d450c0ec5f614( self.var_942b501d544b0e0a );
        scripts\mp\hud_popup::function_233461f36bb50ef9();
        return 0;
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0xd67
// Size: 0x43
function function_240d450c0ec5f614( ref )
{
    if ( isdefined( ref ) && isdefined( self ) )
    {
        if ( !isdefined( self.var_aa60aaec7e1f2460 ) )
        {
            self.var_aa60aaec7e1f2460 = [];
        }
        
        self.var_aa60aaec7e1f2460[ self.var_aa60aaec7e1f2460.size ] = ref;
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0xdb2
// Size: 0x6e, Type: bool
function function_eff88219461e17e6( ref )
{
    if ( isdefined( self.var_aa60aaec7e1f2460 ) )
    {
        foreach ( skipped_ref in self.var_aa60aaec7e1f2460 )
        {
            if ( ref == skipped_ref )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0xe29
// Size: 0x33
function function_f7754d7ad59b2f8b()
{
    assert( isplayer( self ) );
    playerdata = self getplayerdata( "mp", "ftueData", "popup_messages_01" );
    return playerdata;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0xe65
// Size: 0x31
function function_9406f25ca59385d7( data )
{
    assert( isplayer( self ) );
    self setplayerdata( "mp", "ftueData", "popup_messages_01", data );
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0xe9e
// Size: 0x6a
function function_bfd3ae5074922ca4( ref )
{
    assert( isplayer( self ) );
    
    if ( isdefined( ref ) )
    {
        playerdata = function_f7754d7ad59b2f8b();
        mask = function_470bb108e6b631cf( ref );
        playerdata &= !mask;
        function_9406f25ca59385d7( playerdata );
        return;
    }
    
    self setplayerdata( "mp", "ftueData", "popup_messages_01", 0 );
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0xf10
// Size: 0x33
function function_db5ff9a11953598a()
{
    assert( isplayer( self ) );
    matchcount = self getplayerdata( "mp", "ftueData", "ftue_match_count" );
    return matchcount;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0xf4c
// Size: 0x31
function function_ba46b8be5a676356( data )
{
    assert( isplayer( self ) );
    self setplayerdata( "mp", "ftueData", "ftue_match_count", data );
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0xf85
// Size: 0x5d
function function_5b732dd6ab2ee2d6()
{
    if ( isdefined( self ) && isplayer( self ) )
    {
        function_86471673929333b2();
        matchcount = self getplayerdata( "mp", "ftueData", "ftue_match_count" );
        
        if ( matchcount < 10 )
        {
            matchcount += 1;
            self setplayerdata( "mp", "ftueData", "ftue_match_count", matchcount );
        }
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0xfea
// Size: 0x28
function function_e1efe40b5c5ae801()
{
    assert( isplayer( self ) );
    self setplayerdata( "mp", "ftueData", "ftue_match_count", 0 );
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x101a
// Size: 0x1b6
function function_da05e0125fa8bbf4()
{
    /#
        if ( level.mapname == "<dev string:x1c>" && getdvarint( @"hash_97ab1e3e328ddff9", 0 ) == 0 )
        {
            return;
        }
    #/
    
    wait 1;
    startpt = level.infilstruct.c130pathstruct.startpt;
    endpt = level.infilstruct.c130pathstruct.endpt;
    maxdist = 2000;
    maxdistsquared = maxdist * maxdist;
    locationindex = 1;
    
    foreach ( player in level.players )
    {
        if ( player scripts\mp\gametypes\br_public::isplayerbrsquadleader() )
        {
            for ( i = locationindex; i <= tablelookupgetnumrows( "mp/brLandingLocations.csv" ) ; i++ )
            {
                xvalue = int( tablelookupbyrow( "mp/brLandingLocations.csv", i, 1 ) );
                yvalue = int( tablelookupbyrow( "mp/brLandingLocations.csv", i, 2 ) );
                zvalue = int( tablelookupbyrow( "mp/brLandingLocations.csv", i, 3 ) );
                landingpoint = ( xvalue, yvalue, zvalue );
                dist2dsquared = distance2dsquared( pointonsegmentnearesttopoint( startpt, endpt, landingpoint ), landingpoint );
                
                if ( dist2dsquared <= maxdistsquared )
                {
                    locationindex = i + 1;
                    player function_1976438a8865ac27( "br_ftue_suggested_landing", landingpoint );
                }
            }
        }
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x11d8
// Size: 0x1c6
function function_598fb861f3171c2()
{
    if ( function_2da74cf301f9faa5( "br_ftue_supply_box" ) )
    {
        lootcachearray = getentitylessscriptablearray( undefined, undefined, self.origin, 800, "body" );
        
        if ( lootcachearray.size > 0 )
        {
            var_66df16d5eb83948 = undefined;
            var_275345d8f36271a8 = 640000;
            player_angles = self getplayerangles();
            player_forward = anglestoforward( player_angles );
            var_2d9d490a0cc189e2 = 0.8;
            
            foreach ( lootcache in lootcachearray )
            {
                partstate = lootcache getscriptablepartstate( "body", 1 );
                
                if ( !isdefined( partstate ) )
                {
                    continue;
                }
                
                if ( isdefined( partstate ) && partstate == "closed_usable" || partstate == "closed_usable_no_collision" )
                {
                    distsq = distancesquared( self.origin, lootcache.origin );
                    angles = vectortoangles( lootcache.origin - self.origin );
                    forward = anglestoforward( angles );
                    facingdot = vectordot( forward, player_forward );
                    
                    if ( facingdot > var_2d9d490a0cc189e2 )
                    {
                        if ( distsq < var_275345d8f36271a8 && abs( self.origin[ 2 ] - lootcache.origin[ 2 ] ) < 80 )
                        {
                            var_66df16d5eb83948 = lootcache;
                            var_275345d8f36271a8 = distsq;
                        }
                    }
                }
            }
            
            if ( isdefined( var_66df16d5eb83948 ) )
            {
                function_1976438a8865ac27( "br_ftue_supply_box", var_66df16d5eb83948.origin );
            }
        }
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x13a6
// Size: 0x5f
function function_7287acec1d584b46()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( self usinggamepad() )
    {
        invertslide = requestgamerprofile( "slideDiveInvertHoldGamepad" );
    }
    else
    {
        invertslide = requestgamerprofile( "slideDiveInvertHoldKBM" );
    }
    
    if ( invertslide )
    {
        function_1976438a8865ac27( "br_ftue_sliding_invert" );
        return;
    }
    
    function_1976438a8865ac27( "br_ftue_sliding" );
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x140d
// Size: 0x30
function function_46c63a68a41e27a1()
{
    if ( function_2da74cf301f9faa5( "br_ftue_sliding" ) || function_2da74cf301f9faa5( "br_ftue_sliding_invert" ) )
    {
        if ( self issprinting() )
        {
            thread function_7287acec1d584b46();
        }
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x1445
// Size: 0x77
function function_5a4b82ce1c8d94d6( victim )
{
    if ( function_2da74cf301f9faa5( "br_ftue_enemy_down" ) )
    {
        wait 5;
        
        if ( scripts\mp\utility\player::isinlaststand( victim ) )
        {
            function_1976438a8865ac27( "br_ftue_enemy_down", victim );
        }
        
        return;
    }
    
    if ( function_2da74cf301f9faa5( "br_ftue_interrogation" ) && function_2f0ba374d69e645c( "br_ftue_enemy_down" ) )
    {
        wait 3;
        
        if ( scripts\mp\utility\player::isinlaststand( victim ) && isalive( victim ) )
        {
            function_1976438a8865ac27( "br_ftue_interrogation", victim );
        }
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x14c4
// Size: 0x55
function function_4e19e6bf429dda56( teammate )
{
    if ( function_2da74cf301f9faa5( "br_ftue_revive" ) )
    {
        distsq = distancesquared( self.origin, teammate.origin );
        
        if ( distsq < 1000000 )
        {
            function_1976438a8865ac27( "br_ftue_revive", teammate );
        }
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x1521
// Size: 0x3e, Type: bool
function function_8f15851557170215( ref )
{
    return ref == "br_ftue_interrogation" || ref == "br_ftue_enemy_down" || ref == "br_ftue_gas" || ref == "br_ftue_parachute" || ref == "br_ftue_suggested_landing";
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 1
// Checksum 0x0, Offset: 0x1568
// Size: 0x137, Type: bool
function function_88c626bafd6057bf( player )
{
    currenttime = gettime();
    var_527aac742ef4ec8b = getdvarint( @"hash_2d46f9a1548dfb28", 12000 );
    
    if ( isdefined( player ) && isdefined( player.pers[ "lastDamageTime" ] ) && player.pers[ "lastDamageTime" ] + var_527aac742ef4ec8b > currenttime || isdefined( player.lasttimedamaged ) && player.lasttimedamaged + var_527aac742ef4ec8b > currenttime || isdefined( player.lastdamagedtime ) && player.lastdamagedtime + var_527aac742ef4ec8b > currenttime )
    {
        return true;
    }
    
    player scripts\mp\battlechatter_mp::validaterecentattackers();
    
    if ( isdefined( player.recentattackers ) && player.recentattackers.size > 0 )
    {
        return true;
    }
    
    if ( isdefined( player.vehicle ) )
    {
        if ( istrue( player.vehicle.burningdown ) )
        {
            return true;
        }
        
        if ( istrue( scripts\cp_mp\utility\weapon_utility::islockedonto( player.vehicle ) ) )
        {
            return true;
        }
    }
    
    if ( isdefined( player ) && player scripts\mp\outofbounds::istouchingoobtrigger() )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 0
// Checksum 0x0, Offset: 0x16a8
// Size: 0x6b
function ftue_trigger_landed_hint()
{
    if ( function_2da74cf301f9faa5( "br_ftue_controls" ) )
    {
        function_1976438a8865ac27( "br_ftue_controls" );
        return;
    }
    
    teamplayers = scripts\mp\utility\teams::getfriendlyplayers( self.team, 1 );
    
    if ( teamplayers.size > 0 && function_2f0ba374d69e645c( "br_ftue_controls" ) && function_2da74cf301f9faa5( "br_ftue_ping" ) )
    {
        function_1976438a8865ac27( "br_ftue_ping" );
    }
}

// Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
// Params 2
// Checksum 0x0, Offset: 0x171b
// Size: 0x91
function function_a381589f3fb2b34f( scriptablename, pickup )
{
    if ( function_2da74cf301f9faa5( "br_ftue_stronghold" ) )
    {
        if ( !istrue( scripts\mp\gametypes\br_pickups::function_cbbf9bf3544dc456( pickup ) ) )
        {
            return;
        }
        
        var_9220ee8d6bf347ee = isdefined( level.br_pickups.br_itemtype[ scriptablename ] ) && level.br_pickups.br_itemtype[ scriptablename ] == #"key" && issubstr( scriptablename, "loot_key_fortress" );
        
        if ( var_9220ee8d6bf347ee )
        {
            function_1976438a8865ac27( "br_ftue_stronghold" );
        }
    }
}

/#

    // Namespace namespace_3169ff42d7051988 / namespace_88bfae359020fdd3
    // Params 2
    // Checksum 0x0, Offset: 0x17b4
    // Size: 0x2b1, Type: dev
    function function_8247afd76f1b33e0( command, args )
    {
        switch ( command )
        {
            case #"hash_331cc3d256f46a92":
                popupref = "<dev string:x3c>";
                
                if ( isdefined( args[ 0 ] ) )
                {
                    popupref = args[ 0 ];
                }
                
                level.player function_bfd3ae5074922ca4( popupref );
                level.player function_1976438a8865ac27( popupref );
                break;
            case #"hash_6d4107298063ce5b":
                level.player function_bfd3ae5074922ca4();
                level.player function_e1efe40b5c5ae801();
                break;
            case #"hash_3042071cce2a405a":
                level.player function_bfd3ae5074922ca4();
                break;
            case #"hash_3e708dd7a95b6863":
                level.player function_e1efe40b5c5ae801();
                break;
            case #"hash_cd0526653dd5a3c2":
                matchcount = 1;
                
                if ( isdefined( args ) )
                {
                    matchcount = args;
                }
                
                level.player function_ba46b8be5a676356( matchcount );
                break;
            case #"hash_f51410d2484dcf62":
                level.player function_5b732dd6ab2ee2d6();
                break;
            case #"hash_75c29bbe1edeb517":
                popupref = "<dev string:xd1>";
                level.player function_bfd3ae5074922ca4( popupref );
                squadmates = scripts\mp\utility\teams::getsquadmates( level.player.team, level.player.sessionsquadid, 1 );
                
                foreach ( player in squadmates )
                {
                    if ( player != level.player )
                    {
                        level.player function_1976438a8865ac27( popupref, player );
                        return;
                    }
                }
                
                break;
            case #"hash_badf722cbb8a0456":
                popupref = "<dev string:xf5>";
                level.player function_bfd3ae5074922ca4( popupref );
                enemyplayers = scripts\mp\utility\teams::getenemyplayers( level.player.team, 1 );
                
                foreach ( player in enemyplayers )
                {
                    if ( isdefined( player ) && isalive( player ) )
                    {
                        level.player function_1976438a8865ac27( popupref, player );
                    }
                    
                    return;
                }
                
                break;
            default:
                break;
        }
    }

#/
