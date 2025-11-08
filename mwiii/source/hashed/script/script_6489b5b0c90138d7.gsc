#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_message;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;

#namespace namespace_d09b27d6534a97c;

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0
// Checksum 0x0, Offset: 0x651
// Size: 0x308
function setupcallbacks()
{
    if ( getdvarint( @"scr_scorpiontrophyevent", 0 ) == 0 || istrue( level.leagueplaymatch ) || istrue( level.var_77907d733abe8b63 ) )
    {
        scripts\common\callbacks::add( "player_connect", &function_66d05c31053f7c8f );
        return;
    }
    
    scripts\common\callbacks::add( "game_ended", &ongameended );
    scripts\common\callbacks::add( "player_disconnect", &onplayerdisconnect );
    scripts\common\callbacks::add( "player_connect", &onplayerconnect );
    
    if ( isbrstylegametype() )
    {
        level.adddroponplayerdeath = &function_3354140884867d15;
        level.var_d3fb932f0373554c = &function_c8958695acf2e1f1;
    }
    else
    {
        scripts\common\callbacks::add( "player_death", &onplayerdeath );
        scripts\mp\ai_mp_controller::function_93add0b65db9f722( &onagentdeath );
    }
    
    scripts\engine\utility::registersharedfunc( "br_loot_cache", "opened", &function_aa629573b9b452b7 );
    scripts\engine\utility::registersharedfunc( "br_loot_cache_lege", "opened", &function_aa629573b9b452b7 );
    scripts\engine\utility::registersharedfunc( "br_loot_cache", "spawnLoot", &function_735a4fd352102f67 );
    scripts\engine\utility::registersharedfunc( "br_loot_cache_lege", "spawnLoot", &function_735a4fd352102f67 );
    scripts\engine\utility::registersharedfunc( 26160, "pickedUp", &function_b468ee3a4aad8f93 );
    scripts\engine\utility::registersharedfunc( "brloot_scorpion_trophy", "delete", &function_c2feb4d9932dfdcc );
    scripts\engine\utility::registersharedfunc( "iw9_mp_scorpion_trophy_entityless", "delete", &function_c2feb4d9932dfdcc );
    scripts\engine\utility::registersharedfunc( "scorpion_event", "player_win", &function_d5e7a53fa83f629d );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "trophy_bank", &function_340f4f4118dcf7c3 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "brloot_scorpion_trophy", &function_199f02943420e747 );
    scripts\engine\scriptable::scriptable_addautousecallback( &function_76c38f4af5d006ea );
    scripts\mp\team_assimilation::registerteamassimilatecallback( &onteamchange );
    level thread spawnbanks();
    
    if ( isdefined( data() ) )
    {
        return;
    }
    
    data = spawnstruct();
    data.dropcount = getdvarint( @"hash_a883d4d8dec18e3", 1 );
    data.maxcount = getdvarint( @"hash_23b3d2eb188b1230", 6 );
    data.var_ff2afeeaaa71f4bc = getdvarint( @"hash_c80ce9fc7bbc1e00", function_950cde7e875198d1() );
    data.var_7d56c242c2c9880a = getdvarint( @"hash_a4f1b7232d99c28f", 10 );
    data.aidropcount = getdvarint( @"hash_404a77e17612eee5", 1 );
    data.var_8e3cd6bcc3e4f17c = getdvarint( @"hash_884af2871be336e8", function_fdf3d038ad278d6b() );
    data.var_a082b242b6fae420 = 200;
    data.var_4e54edc5768a0ad4 = getdvarint( @"hash_3f33f4c872c90245", 20 );
    data.var_3f2e2cb7b92e01ef = getdvarint( @"hash_ca2bc81f1c460d5b", 0 );
    data.triggers = [];
    data.var_50abd2e2174e8f51 = [];
    data.var_de335d425ab8c9b0 = [];
    data.var_eb3be366abc17855 = [];
    data.dropped = [];
    game[ "scorpionEvent" ] = data;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x961
// Size: 0x2b7
function private spawnbanks()
{
    flag_wait( "buy_stations_spawned" );
    
    if ( !isdefined( level.var_6aa304e25520289f ) )
    {
        return;
    }
    
    topleft = [];
    botleft = [];
    topright = [];
    botright = [];
    
    foreach ( struct in array_randomize( level.var_6aa304e25520289f ) )
    {
        top = struct.origin[ 1 ] > 0;
        right = struct.origin[ 0 ] > 0;
        
        if ( top && right )
        {
            topright[ topright.size ] = struct;
            continue;
        }
        
        if ( !top && right )
        {
            botright[ botright.size ] = struct;
            continue;
        }
        
        if ( top && !right )
        {
            topleft[ topleft.size ] = struct;
            continue;
        }
        
        if ( !top && !right )
        {
            botleft[ botleft.size ] = struct;
        }
    }
    
    quadrants = [];
    
    foreach ( quadrant in [ topleft, botleft, topright, botright ] )
    {
        if ( quadrant.size > 0 )
        {
            quadrants[ quadrants.size ] = quadrant;
        }
    }
    
    if ( quadrants.size == 0 )
    {
        return;
    }
    
    quadrants = array_randomize( quadrants );
    spawned = 0;
    level.trophybanks = [];
    
    while ( spawned < data().var_8e3cd6bcc3e4f17c )
    {
        index = spawned % quadrants.size;
        spawned += 1;
        struct = quadrants[ index ][ quadrants[ index ].size - 1 ];
        quadrants[ index ][ quadrants[ index ].size - 1 ] = undefined;
        level.trophybanks[ level.trophybanks.size ] = spawnscriptable( "iw9_mp_scorpion_trophy_bank", struct.origin, struct.angles );
        
        if ( quadrants[ index ].size == 0 )
        {
            var_d4a4d8d21b1b423a = [];
            
            foreach ( array in quadrants )
            {
                if ( array.size > 0 )
                {
                    var_d4a4d8d21b1b423a[ var_d4a4d8d21b1b423a.size ] = array;
                }
            }
            
            quadrants = var_d4a4d8d21b1b423a;
        }
        
        if ( quadrants.size == 0 )
        {
            break;
        }
    }
    
    level.var_6aa304e25520289f = undefined;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0xc20
// Size: 0x9a
function private function_340f4f4118dcf7c3( instance, part, state, player, bautouse, usestring )
{
    if ( !isvalidplayer( player ) )
    {
        return;
    }
    
    if ( !player function_1c8b9d8312271186() )
    {
        return;
    }
    
    player showsplash( "scorpion_trophy_banked" );
    success = player function_4c65595e68db285c();
    instance setscriptablepartstate( "upload", "on" );
    player function_3677f2be30fdd581( "trophy_effects", "upload" );
    
    if ( success )
    {
        player thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
    }
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xcc2
// Size: 0x212
function private onplayerdeath( deathdata )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !function_1dc73c36b8cb3eca() )
    {
        return;
    }
    
    entnum = self getentitynumber();
    
    if ( !isdefined( entnum ) )
    {
        return;
    }
    
    if ( isdefined( data().triggers[ entnum ] ) )
    {
        data().triggers[ entnum ] thread cleanup( 0 );
    }
    
    if ( !isdefined( deathdata ) || !isvalidplayer( deathdata.attacker ) )
    {
        return;
    }
    
    if ( deathdata.attacker == self )
    {
        return;
    }
    
    if ( level.teambased && is_equal( self.team, deathdata.attacker.team ) )
    {
        return;
    }
    
    if ( !deathdata.attacker function_2a504551561a812c() )
    {
        return;
    }
    
    attackerentnum = deathdata.attacker getentitynumber();
    
    if ( !isdefined( data().dropped[ entnum ] ) )
    {
        data().dropped[ entnum ] = [];
    }
    
    if ( isdefined( data().dropped[ entnum ][ attackerentnum ] ) )
    {
        return;
    }
    
    fromplayercount = 0;
    
    if ( function_1c8b9d8312271186() )
    {
        fromplayercount = int( min( data().var_de335d425ab8c9b0[ entnum ], data().var_ff2afeeaaa71f4bc ) );
        data().var_de335d425ab8c9b0[ entnum ] -= fromplayercount;
        self setclientomnvar( "ui_scorpion_trophies_collected", data().var_de335d425ab8c9b0[ entnum ] );
    }
    
    trigger = function_cfb0bd180308a4ba( data().dropcount, self, fromplayercount, self.origin, entnum, deathdata.attacker, "player_kill" );
    trigger.var_e7c898d742b4ba46 = deathdata.attacker;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xedc
// Size: 0x1c8
function private function_3354140884867d15( dropstruct, attacker )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !function_1dc73c36b8cb3eca() )
    {
        return;
    }
    
    entnum = self getentitynumber();
    
    if ( !isdefined( entnum ) )
    {
        return;
    }
    
    if ( isdefined( data().var_50abd2e2174e8f51[ entnum ] ) )
    {
        foreach ( trophy in data().var_50abd2e2174e8f51[ entnum ] )
        {
            trophy thread cleanuptrophy();
        }
        
        data().var_50abd2e2174e8f51[ entnum ] = undefined;
    }
    
    if ( isvalidplayer( attacker ) )
    {
        if ( !isdefined( data().dropped[ entnum ] ) )
        {
            data().dropped[ entnum ] = [];
        }
        
        if ( isdefined( data().dropped[ entnum ][ attacker.team ] ) )
        {
            return;
        }
    }
    
    fromplayercount = 0;
    
    if ( function_1c8b9d8312271186() )
    {
        fromplayercount = int( min( data().var_de335d425ab8c9b0[ entnum ], data().var_ff2afeeaaa71f4bc ) );
        data().var_de335d425ab8c9b0[ entnum ] -= fromplayercount;
        self setclientomnvar( "ui_scorpion_trophies_collected", data().var_de335d425ab8c9b0[ entnum ] );
    }
    
    function_cfb0bd180308a4ba( data().dropcount, self, fromplayercount, self.origin, entnum, attacker, "player_kill", dropstruct );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10ac
// Size: 0x50
function private onplayerdisconnect( params )
{
    if ( !isvalidplayer( self ) )
    {
        return;
    }
    
    if ( function_1c8b9d8312271186() )
    {
        self dlog_recordplayerevent( "dlog_event_scorpion_not_banked", [ "count", data().var_de335d425ab8c9b0[ self getentitynumber() ] ] );
    }
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1104
// Size: 0x6a
function private onplayerconnect( params )
{
    if ( !isvalidplayer( self ) )
    {
        return;
    }
    
    self setclientomnvar( "ui_scorpion_trophies_collected", default_to( data().var_de335d425ab8c9b0[ self getentitynumber() ], 0 ) );
    self setclientomnvar( "ui_scorpion_trophies_secured", default_to( data().var_eb3be366abc17855[ self getentitynumber() ], 0 ) );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1176
// Size: 0x16
function private function_66d05c31053f7c8f( params )
{
    if ( !isvalidplayer( self ) )
    {
        return;
    }
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1194
// Size: 0x1d
function private function_c8958695acf2e1f1( killer, dropstruct )
{
    onagentdeath( self, killer, dropstruct );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x11b9
// Size: 0xcc
function private onagentdeath( agent, killer, dropstruct )
{
    if ( !function_1dc73c36b8cb3eca() )
    {
        return;
    }
    
    if ( data().var_7d56c242c2c9880a <= 0 )
    {
        return;
    }
    
    if ( !isvalidplayer( killer ) )
    {
        return;
    }
    
    if ( !killer function_2a504551561a812c() )
    {
        return;
    }
    
    if ( randomint( 100 ) > data().var_7d56c242c2c9880a )
    {
        return;
    }
    
    function_cfb0bd180308a4ba( data().aidropcount, agent, 0, agent.origin, data().var_a082b242b6fae420, killer, "ai_kill", dropstruct );
    data().var_a082b242b6fae420 += 1;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x128d
// Size: 0x6d
function private function_aa629573b9b452b7( items, opener, var_64c59c08b4538d72 )
{
    if ( !istrue( var_64c59c08b4538d72 ) )
    {
        return items;
    }
    
    if ( !function_1dc73c36b8cb3eca() )
    {
        return items;
    }
    
    if ( !isvalidplayer( opener ) )
    {
        return items;
    }
    
    if ( !opener function_2a504551561a812c() )
    {
        return items;
    }
    
    if ( randomint( 100 ) > data().var_4e54edc5768a0ad4 )
    {
        return items;
    }
    
    items[ items.size ] = "brloot_scorpion_trophy";
    return items;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1303
// Size: 0xaa
function private function_735a4fd352102f67( opener, dropstruct )
{
    if ( !function_1dc73c36b8cb3eca() )
    {
        return;
    }
    
    if ( !isvalidplayer( opener ) )
    {
        return;
    }
    
    if ( !opener function_2a504551561a812c() )
    {
        return;
    }
    
    if ( randomint( 100 ) > data().var_4e54edc5768a0ad4 )
    {
        return;
    }
    
    trophies = function_cfb0bd180308a4ba( 1, self, 0, self.origin, data().var_a082b242b6fae420, undefined, "loot", dropstruct );
    data().var_a082b242b6fae420 += 1;
    return trophies;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x13b6
// Size: 0x6e
function private function_76c38f4af5d006ea( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance ) || !isdefined( instance.type ) || instance.type != "brloot_scorpion_trophy" )
    {
        return;
    }
    
    function_199f02943420e747( instance, part, state, player, bautouse, usestring, 1 );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 7, eflags: 0x4
// Checksum 0x0, Offset: 0x142c
// Size: 0x25f
function private function_199f02943420e747( instance, part, state, player, bautouse, usestring, var_71b664f5ab636333 )
{
    if ( !isdefined( instance ) || !isdefined( instance.type ) || instance.type != "brloot_scorpion_trophy" )
    {
        return;
    }
    
    if ( isdefined( instance.team ) && instance.team == player.team )
    {
        if ( isdefined( instance.returnto ) )
        {
            data().var_de335d425ab8c9b0[ instance.entnum ] = function_5bff4e2a3631e3e5( instance.entnum, 1 );
            
            if ( isdefined( instance.returnto ) )
            {
                instance.returnto showsplash( "scorpion_trophy_recovered" );
                instance.returnto setclientomnvar( "ui_scorpion_trophies_collected", data().var_de335d425ab8c9b0[ instance.entnum ] );
            }
        }
        
        if ( !isdefined( instance.returnto ) || instance.returnto != player )
        {
            player showsplash( "scorpion_trophy_denied" );
        }
    }
    else
    {
        player function_439f0781dbd8a339( 1, default_to( instance.trophysource, "loot" ) );
        
        if ( isdefined( instance.team ) )
        {
            data().dropped[ instance.entnum ][ player.team ] = 1;
        }
    }
    
    player function_3677f2be30fdd581( "trophy_effects", "pickup" );
    
    if ( !istrue( var_71b664f5ab636333 ) )
    {
        player thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
    }
    
    data().var_50abd2e2174e8f51[ instance.entnum ] = array_remove( data().var_50abd2e2174e8f51[ instance.entnum ], instance );
    
    if ( data().var_50abd2e2174e8f51[ instance.entnum ].size == 0 )
    {
        data().var_50abd2e2174e8f51[ instance.entnum ] = undefined;
    }
    
    instance thread cleanuptrophy( 1 );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1693
// Size: 0x36, Type: bool
function private function_b468ee3a4aad8f93( scriptable, player )
{
    player function_439f0781dbd8a339( 1, "loot" );
    player function_3677f2be30fdd581( "trophy_effects", "pickup" );
    return true;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x16d2
// Size: 0x21
function private function_f858675bc65238fe()
{
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread cleanup( 0 );
    }
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x16fb
// Size: 0x4, Type: bool
function private function_c2feb4d9932dfdcc()
{
    return true;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1708
// Size: 0x69
function private ongameended( data )
{
    if ( !rewardongameend() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player function_4c65595e68db285c();
    }
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1779
// Size: 0x9
function private function_d5e7a53fa83f629d()
{
    function_4c65595e68db285c();
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 8, eflags: 0x4
// Checksum 0x0, Offset: 0x178a
// Size: 0x422
function private function_cfb0bd180308a4ba( count, from, fromplayercount, origin, entnum, killer, type, dropstruct )
{
    if ( !isdefined( dropstruct ) && isbrstylegametype() )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    count += default_to( fromplayercount, 0 );
    mover = undefined;
    
    if ( isdefined( from ) && isent( from ) && isplayer( from ) )
    {
        mover = from getmovingplatformparent();
    }
    
    if ( isbrstylegametype() )
    {
        var_50abd2e2174e8f51 = [];
        
        for ( i = 0; i < count ; i++ )
        {
            if ( isent( from ) )
            {
                dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, from.origin, from.angles, from, undefined, undefined, randomfloatrange( 15, 30 ) );
            }
            else
            {
                dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, from.origin, from.angles, undefined, 115 + randomfloatrange( -10, 10 ), 35 + randomfloatrange( -5, 5 ), randomfloatrange( 15, 30 ) );
            }
            
            trophy = spawnscriptable( "brloot_scorpion_trophy", dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload );
            trophy.entnum = entnum;
            trophy.isentity = 0;
            trophy.trophysource = type;
            scripts\mp\gametypes\br_pickups::registerscriptableinstance( trophy );
            
            if ( isent( from ) && isplayer( from ) )
            {
                trophy.team = from.team;
            }
            
            if ( fromplayercount > 0 )
            {
                trophy.returnto = from;
                fromplayercount -= 1;
            }
            
            mover = dropinfo.groundentity;
            
            if ( isdefined( mover ) )
            {
                trophy scriptable_setparententity( mover, rotatevectorinverted( trophy.origin - mover.origin, mover.angles ) );
                trophy setscriptablepartstate( "brloot_scorpion_trophy", "dropped_linked" );
            }
            else
            {
                trophy setscriptablepartstate( "brloot_scorpion_trophy", "dropped" );
            }
            
            var_50abd2e2174e8f51[ var_50abd2e2174e8f51.size ] = trophy;
        }
        
        data().var_50abd2e2174e8f51[ entnum ] = var_50abd2e2174e8f51;
        return var_50abd2e2174e8f51;
    }
    
    spawnpositions = [];
    trophies = [];
    
    if ( count > 1 )
    {
        angle = randomfloat( 360 );
        
        for ( i = 0; i < count ; i++ )
        {
            offset = ( cos( angle ), sin( angle ), 0 ) * 12;
            spawnpositions[ spawnpositions.size ] = offset + origin;
            angle += 360 / count;
        }
    }
    else
    {
        spawnpositions[ spawnpositions.size ] = origin;
    }
    
    foreach ( spawnpos in spawnpositions )
    {
        trophy = spawn( "script_model", spawnpos + ( 0, 0, randomfloatrange( 18, 27 ) ) );
        trophy setmodel( "iw9_mp_scorpion_trophy_entity" );
        
        if ( isdefined( killer ) )
        {
            trophy showonlytoplayer( killer );
        }
        
        trophy setscriptablepartstate( "iw9_mp_scorpion_trophy_entity", "visible" );
        trophy.isentity = 1;
        trophy.angles = ( 0, randomfloat( 360 ), 0 );
        trophy rotatevelocity( ( 0, randomfloatrange( 45, 135 ) * ter_op( cointoss(), 1, -1 ), 0 ), 9999 );
        
        if ( isdefined( mover ) )
        {
            trophy linkto( mover );
        }
        
        trophies[ trophies.size ] = trophy;
    }
    
    return spawntrigger( origin, ter_op( count > 1, 45, 35 ), entnum, trophies, type, fromplayercount, from, mover );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 8, eflags: 0x4
// Checksum 0x0, Offset: 0x1bb4
// Size: 0x148
function private spawntrigger( origin, radius, entnum, trophies, type, fromplayercount, fromplayer, mover )
{
    if ( isdefined( mover ) )
    {
        trigger = spawn( "trigger_radius", origin, 0, radius, 35 );
        trigger enablelinkto();
        trigger linkto( mover );
        trigger thread function_1dabbbecf02dd66b( mover );
    }
    else
    {
        trigger = spawn( "noent_volume_trigger_radius", origin, 0, radius, 35 );
    }
    
    trigger.var_182d8860fac4c70b = trophies;
    trigger.entnum = entnum;
    trigger.type = type;
    trigger.fromplayer = fromplayer;
    trigger.fromplayercount = fromplayercount;
    
    foreach ( trophy in trophies )
    {
        trophy.trigger = trigger;
    }
    
    trigger thread watchtrigger();
    data().triggers[ entnum ] = trigger;
    return trigger;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1d05
// Size: 0x1df
function private watchtrigger()
{
    self endon( "remove" );
    
    while ( true )
    {
        self waittill( "trigger", ent );
        
        if ( !isvalidplayer( ent ) )
        {
            continue;
        }
        
        if ( isdefined( self.team ) && ent.team == self.team )
        {
            if ( self.fromplayercount > 0 )
            {
                data().var_de335d425ab8c9b0[ self.entnum ] = function_5bff4e2a3631e3e5( self.entnum, self.fromplayercount );
                
                if ( isdefined( self.fromplayer ) )
                {
                    self.fromplayer showsplash( "scorpion_trophy_recovered" );
                    self.fromplayer setclientomnvar( "ui_scorpion_trophies_collected", data().var_de335d425ab8c9b0[ self.entnum ] );
                }
            }
            
            if ( !isdefined( self.fromplayer ) || self.fromplayer != ent )
            {
                ent showsplash( "scorpion_trophy_denied" );
            }
            
            thread cleanup( 1 );
            continue;
        }
        
        if ( !ent function_2a504551561a812c() )
        {
            continue;
        }
        
        if ( isdefined( self.var_e7c898d742b4ba46 ) )
        {
            if ( self.var_e7c898d742b4ba46 != ent )
            {
                continue;
            }
            
            data().dropped[ self.entnum ][ ent getentitynumber() ] = 1;
        }
        else if ( isdefined( self.team ) )
        {
            data().dropped[ self.entnum ][ ent.team ] = 1;
        }
        
        ent function_439f0781dbd8a339( self.var_182d8860fac4c70b.size, self.type );
        ent function_3677f2be30fdd581( "trophy_effects", "pickup" );
        thread cleanup( 1 );
    }
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1eec
// Size: 0x312
function private function_439f0781dbd8a339( num, type )
{
    entnum = self getentitynumber();
    event = undefined;
    
    switch ( type )
    {
        case #"hash_7da50b39ef481517":
            event = "dlog_event_scorpion_gathered_loot";
            break;
        case #"hash_5d0d8e1242960ca0":
            event = "dlog_event_scorpion_gathered_ai_kill";
            break;
        case #"hash_3c12327fb1211161":
            event = "dlog_event_scorpion_gathered_player_kill";
            break;
    }
    
    if ( !isdefined( data().var_de335d425ab8c9b0[ entnum ] ) )
    {
        data().var_de335d425ab8c9b0[ entnum ] = 0;
    }
    
    before = data().var_de335d425ab8c9b0[ entnum ];
    after = function_5bff4e2a3631e3e5( entnum, num );
    data().var_de335d425ab8c9b0[ entnum ] = after;
    
    if ( after > before )
    {
        self dlog_recordplayerevent( event, [ "count", after - before ] );
        self setclientomnvar( "ui_scorpion_trophies_collected", after );
        thread scripts\mp\utility\points::doscoreevent( #"hash_ccb945806d13fd43" );
        gathered = function_644b35bc4f205dcb();
        splash = undefined;
        
        if ( gathered == data().maxcount )
        {
            self dlog_recordplayerevent( "dlog_event_scorpion_limit_reached", [ "limit", data().maxcount ] );
            
            if ( isbrstylegametype() )
            {
                if ( scripts\mp\utility\game::getsubgametype() == "plunder" )
                {
                    splash = "scorpion_trophy_collected_plunder_max";
                }
                else
                {
                    splash = "scorpion_trophy_collected_br_max";
                }
            }
            else
            {
                splash = "scorpion_trophy_collected_core_max";
            }
        }
        else if ( isbrstylegametype() )
        {
            if ( scripts\mp\utility\game::getsubgametype() == "plunder" )
            {
                splash = "scorpion_trophy_collected_plunder";
            }
            else
            {
                splash = "scorpion_trophy_collected_br";
            }
        }
        else
        {
            splash = "scorpion_trophy_collected_core";
        }
        
        showsplash( splash );
        
        if ( ( gathered == data().maxcount || gathered == 1 ) && isdefined( level.trophybanks ) && level.trophybanks.size > 0 )
        {
            closest = sortbydistance( level.trophybanks, self.origin )[ 0 ];
            
            foreach ( teammate in scripts\mp\utility\teams::getteamdata( self.team, "players" ) )
            {
                if ( teammate calloutmarkerping_isscriptablepingedbyplayer( closest.index ) )
                {
                    return;
                }
            }
            
            newpingindex = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 18, ( 0, 0, 100 ), closest.index );
            thread scripts\cp_mp\calloutmarkerping::function_9a7200f5142066ba( self, newpingindex, undefined, [ "death_or_disconnect", "enter_live_ragdoll" ], 30 );
        }
    }
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2206
// Size: 0x7c
function private function_5bff4e2a3631e3e5( entnum, num )
{
    before = data().var_de335d425ab8c9b0[ entnum ];
    after = before + num;
    cap = data().maxcount - default_to( data().var_eb3be366abc17855[ entnum ], 0 );
    
    if ( after > cap )
    {
        after = cap;
    }
    
    return after;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x228b
// Size: 0x18d, Type: bool
function private function_4c65595e68db285c()
{
    if ( !isvalidplayer( self ) )
    {
        return false;
    }
    
    if ( !function_1c8b9d8312271186() )
    {
        return false;
    }
    
    entnum = self getentitynumber();
    num = data().var_de335d425ab8c9b0[ entnum ];
    self dlog_recordplayerevent( "dlog_event_scorpion_banked", [ "count", num ] );
    aeeventname = #"hash_f6befbe618f1037b";
    aeeventid = ae_utility::function_6e2deb013c9ca85e( aeeventname );
    params = [ ae_utility::function_d6f771aedba70ce7( aeeventname, #"version" ), 1, ae_utility::function_d6f771aedba70ce7( aeeventname, #"value" ), num ];
    
    if ( issharedfuncdefined( "challenges", "reportChallengeUserSerializedEventWrapper" ) )
    {
        callsharedfunc( "challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params );
    }
    
    thread scripts\mp\utility\points::doscoreevent( #"hash_d7637699e926cbc6" );
    
    if ( !isdefined( data().var_eb3be366abc17855[ entnum ] ) )
    {
        data().var_eb3be366abc17855[ entnum ] = 0;
    }
    
    data().var_eb3be366abc17855[ entnum ] += num;
    data().var_de335d425ab8c9b0[ entnum ] = 0;
    self setclientomnvar( "ui_scorpion_trophies_collected", 0 );
    self setclientomnvar( "ui_scorpion_trophies_secured", data().var_eb3be366abc17855[ entnum ] );
    return true;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2421
// Size: 0x23
function private function_1dabbbecf02dd66b( mover )
{
    self endon( "remove" );
    mover waittill( "death" );
    thread cleanup( 0 );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x244c
// Size: 0x98
function private cleanup( used )
{
    if ( isdefined( self.var_182d8860fac4c70b ) )
    {
        foreach ( trophy in self.var_182d8860fac4c70b )
        {
            trophy thread cleanuptrophy( used );
        }
    }
    
    self notify( "remove" );
    data().triggers[ self.entnum ] = undefined;
    waittillframeend();
    self delete();
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24ec
// Size: 0x7e
function private cleanuptrophy( used )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( istrue( self.deleting ) )
    {
        return;
    }
    
    self.deleting = 1;
    state = ter_op( istrue( used ), "pickup", "deleted" );
    self setscriptablepartstate( self function_ec5f4851431f3382(), state );
    wait 3;
    
    if ( istrue( self.isentity ) )
    {
        self delete();
        return;
    }
    
    scripts\mp\gametypes\br_pickups::function_7b67823458cd14();
    self freescriptable();
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2572
// Size: 0x90
function private onteamchange( player, oldteam, newteam )
{
    entnum = player getentitynumber();
    
    if ( !isdefined( entnum ) || !isdefined( data().triggers[ entnum ] ) )
    {
        return;
    }
    
    assert( data().triggers[ entnum ].team == oldteam );
    data().triggers[ entnum ].team = newteam;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x260a
// Size: 0x6c
function private showsplash( splash )
{
    if ( isdefined( self.var_d072e417b4cd76a ) && self.var_d072e417b4cd76a > gettime() )
    {
        return;
    }
    
    self.var_d072e417b4cd76a = gettime() + 1000;
    
    if ( scripts\mp\utility\game::getsubgametype() == "dmz" )
    {
        scripts\mp\gametypes\br_gametype_dmz::showdmzsplash( splash, [ self ] );
        return;
    }
    
    thread scripts\mp\hud_message::showsplash( splash, undefined, undefined, undefined, 1 );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x267e
// Size: 0x2b, Type: bool
function private function_2a504551561a812c()
{
    entnum = self getentitynumber();
    return function_644b35bc4f205dcb() < data().maxcount;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x26b2
// Size: 0x5d
function private function_644b35bc4f205dcb()
{
    entnum = self getentitynumber();
    banked = default_to( data().var_de335d425ab8c9b0[ entnum ], 0 );
    rewarded = default_to( data().var_eb3be366abc17855[ entnum ], 0 );
    return banked + rewarded;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2718
// Size: 0x1d, Type: bool
function private function_1dc73c36b8cb3eca()
{
    return !scripts\mp\gamelogic::inprematch() || data().var_3f2e2cb7b92e01ef;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x273e
// Size: 0x3c, Type: bool
function private isvalidplayer( player )
{
    return isdefined( player ) && isplayer( player ) && !isbot( player ) && isdefined( player getentitynumber() ) && isdefined( player.team );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2783
// Size: 0x8
function private function_f5681f11e80e8dd6()
{
    return isbrstylegametype();
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2794
// Size: 0x9, Type: bool
function private rewardongameend()
{
    return !isbrstylegametype();
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x27a6
// Size: 0x11
function private function_950cde7e875198d1()
{
    return ter_op( isbrstylegametype(), 2, 0 );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x27c0
// Size: 0x2e
function private function_fdf3d038ad278d6b()
{
    return ter_op( level.mapname == "mp_saba2" || level.mapname == "mp_saba", 6, 2 );
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x27f7
// Size: 0x52, Type: bool
function private function_1c8b9d8312271186()
{
    if ( !isdefined( self ) || !isdefined( self getentitynumber() ) )
    {
        return false;
    }
    
    entnum = self getentitynumber();
    return isdefined( data().var_de335d425ab8c9b0[ entnum ] ) && data().var_de335d425ab8c9b0[ entnum ] > 0;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2852
// Size: 0x55
function private function_f4792371ad163637()
{
    if ( !isdefined( self ) || !isdefined( self getentitynumber() ) )
    {
        return 0;
    }
    
    entnum = self getentitynumber();
    
    if ( isdefined( data().var_eb3be366abc17855[ entnum ] ) )
    {
        return data().var_eb3be366abc17855[ entnum ];
    }
    
    return 0;
}

// Namespace namespace_d09b27d6534a97c / namespace_d856b08ddfedc495
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x28af
// Size: 0x9
function private data()
{
    return game[ "scorpionEvent" ];
}

