#using scripts\anim\face;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_anim;
#using scripts\cp\infilexfil\infilexfil;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace cp_infilexfil;

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0x400
// Size: 0x5d
function infil_ended( var_d47ac5a6cbdc6dcf )
{
    level waittill( "infil_started" );
    extra_time = 0;
    
    if ( isdefined( level.extra_infil_time ) )
    {
        extra_time = level.extra_infil_time;
    }
    
    wait var_d47ac5a6cbdc6dcf + extra_time;
    level notify( "prematch_over" );
    
    if ( flag_exist( "infil_complete" ) )
    {
        flag_set( "infil_complete" );
    }
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 0
// Checksum 0x0, Offset: 0x465
// Size: 0x71
function onplayerspawnedinfil()
{
    self endon( "game_ended" );
    self endon( "prematch_over" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player setclientomnvar( "ui_hide_hud", 1 );
        var_be4fbabeafb491a7 = get_spot_from_player( player );
        
        if ( isdefined( var_be4fbabeafb491a7 ) )
        {
            cp_player_free_spot( player, scripts\cp\utility::getotherteam( player.team ) );
        }
        
        player cp_player_join_infil_cp();
    }
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 0
// Checksum 0x0, Offset: 0x4de
// Size: 0x19
function cponplayerdisconnectinfil()
{
    self endon( "prematch_over" );
    self waittill( "disconnect" );
    cp_player_free_spot( self );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0x4ff
// Size: 0x16, Type: bool
function infil_is_type( infil_type )
{
    return self.script_noteworthy == infil_type;
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0x51e
// Size: 0x16, Type: bool
function infil_is_subtype( infil_subtype )
{
    return self.name == infil_subtype;
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 2
// Checksum 0x0, Offset: 0x53d
// Size: 0x152
function cp_infil_player_allow( allow, withweapon )
{
    if ( !isdefined( withweapon ) )
    {
        withweapon = 1;
    }
    
    if ( !allow )
    {
        val::set( "infil_player", "allow_movement", 0 );
        val::set( "infil_player", "prone", 0 );
        val::set( "infil_player", "crouch", 0 );
        val::set( "infil_player", "allow_jump", 0 );
        
        if ( withweapon )
        {
            val::set( "infil_player", "fire", 0 );
            val::set( "infil_player", "ads", 0 );
            val::set( "infil_player", "reload", 0 );
        }
        
        val::set( "infil_player", "sprint", 0 );
        val::set( "infil_player", "melee", 0 );
        val::set( "infil_player", "lean", 0 );
        val::set( "infil_player", "slide", 0 );
        val::set( "infil_player", "offhand_weapons", 0 );
        val::set( "infil_player", "weapon_switch", 0 );
        val::set( "infil_player", "usability", 0 );
        val::set( "infil_player", "tacmap_scoreboard", 0 );
        disable_backpack_inventory( 1 );
        return;
    }
    
    val::reset_all( "infil_player" );
    disable_backpack_inventory( 0 );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0x697
// Size: 0x14
function function_a49af99addcf2646( allow )
{
    cp_infil_player_allow( allow, 0 );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0x6b3
// Size: 0x28, Type: bool
function teamhasinfil( team )
{
    if ( !isdefined( game[ "infil" ] ) )
    {
        return false;
    }
    
    return isdefined( game[ "infil" ][ team ][ "lanes" ] );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 2
// Checksum 0x0, Offset: 0x6e4
// Size: 0xe6
function cp_player_free_spot( player, team )
{
    if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    if ( !isdefined( team ) )
    {
        team = player.team;
    }
    
    if ( !isdefined( game[ "infil" ][ team ][ "spots" ] ) )
    {
        assertmsg( "Trying to free a spot when there are no spots in existence!" );
    }
    
    foreach ( key, spot in game[ "infil" ][ team ][ "spots" ] )
    {
        if ( is_spot_taken( team, key ) && spot[ "player" ] == player )
        {
            game[ "infil" ][ team ][ "spots" ][ key ][ "player" ] = undefined;
            player notify( "player_free_spot" );
            return;
        }
    }
    
    assertmsg( "Tried to remove a player who was NOT added to any infils on this team!" );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0x7d2
// Size: 0x13a
function cp_get_spot_by_priority( team )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ "spots" ] )
    {
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return undefined;
    }
    
    force_seat = getdvarint( @"hash_e6526b9ef05103ad", -1 );
    
    if ( array_contains( available_spots, force_seat ) )
    {
        return force_seat;
    }
    
    var_f60dd12c7b65ae3b = undefined;
    bestpriority = -1;
    
    foreach ( spot in available_spots )
    {
        priority = game[ "infil" ][ team ][ "spots" ][ spot ][ "priority" ];
        
        if ( !isdefined( var_f60dd12c7b65ae3b ) || priority < bestpriority )
        {
            var_f60dd12c7b65ae3b = spot;
            bestpriority = priority;
        }
    }
    
    return var_f60dd12c7b65ae3b;
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 0
// Checksum 0x0, Offset: 0x915
// Size: 0x118
function cp_player_join_infil_cp()
{
    if ( game[ "infil" ][ self.team ].size == 0 )
    {
        return;
    }
    
    var_ad497b2f2391dfe1 = 0;
    var_47691436552ac69 = game[ "infil" ][ self.team ][ "spots" ][ 0 ][ "priority" ] != -1;
    
    if ( var_ad497b2f2391dfe1 )
    {
        spot_index = get_spot_taken_count( self.team );
    }
    else if ( var_47691436552ac69 )
    {
        spot_index = cp_get_spot_by_priority( self.team );
    }
    else
    {
        spot_index = get_random_spot( self.team );
    }
    
    if ( !isdefined( spot_index ) )
    {
        assertmsg( "Player " + self.name + " unable to find an available spot! Ent " + self.entity_number );
        return;
    }
    
    spot = player_on_spot( self, spot_index );
    spot[ "infil" ] thread infil_player_array_handler( self );
    self notify( "player_added_to_infil" );
    self thread [[ spot[ "callback" ] ]]( spot[ "infil" ], spot[ "seat" ] );
    thread cponplayerdisconnectinfil();
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 2
// Checksum 0x0, Offset: 0xa35
// Size: 0xad
function get_random_spot_in_infil( team, infil )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ "spots" ] )
    {
        if ( key[ "infil" ] != infil )
        {
            continue;
        }
        
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        assertmsg( "Unable to find an available spot in specific infil!" );
    }
    
    spot = random( available_spots );
    return spot;
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0xaeb
// Size: 0x56
function infil_player_array_handler( player )
{
    self endon( "death" );
    self.players = array_add( self.players, player );
    player waittill_either( "death", "disconnect" );
    self.players = array_remove( self.players, player );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 0
// Checksum 0x0, Offset: 0xb49
// Size: 0xe1
function alwaysgamemodeclass()
{
    clantag = self getclantag();
    
    if ( clantag == "AR" )
    {
        class = "default1";
    }
    else if ( clantag == "SMG" )
    {
        class = "default2";
    }
    else if ( clantag == "LMG" )
    {
        class = "default3";
    }
    else
    {
        randomloadout = [];
        randomloadout[ 0 ] = "default1";
        randomloadout[ 1 ] = "default2";
        randomloadout[ 2 ] = "default3";
        class = random( randomloadout );
    }
    
    self.pers[ "class" ] = class;
    self.pers[ "lastClass" ] = "";
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    return class;
}

#using_animtree( "script_model" );

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 3
// Checksum 0x0, Offset: 0xc33
// Size: 0x173
function infil_player_rig( animname, rig_model, var_40a4287d8d2e7ef9 )
{
    self.animname = animname;
    self function_b88c89bb7cd1ab8e( self.origin );
    player_rig = spawn( "script_arms", self.origin, 0, 0, self );
    player_rig.angles = self.angles;
    player_rig.player = self;
    self.player_rig = player_rig;
    self.player_rig hide( 1 );
    self.player_rig.animname = animname;
    self.player_rig useanimtree( #animtree );
    self playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
    
    if ( isdefined( var_40a4287d8d2e7ef9 ) && var_40a4287d8d2e7ef9 )
    {
        self playersetgroundreferenceent( self.player_rig );
    }
    
    self notify( "rig_created" );
    
    if ( !isdefined( level.prematchallowfunc ) )
    {
        level.prematchallowfunc = &cp_infil_player_allow;
    }
    
    self [[ level.prematchallowfunc ]]( 0 );
    waittill_any_3( "remove_rig", "player_free_spot", "death" );
    self [[ level.prematchallowfunc ]]( 1 );
    
    if ( isdefined( var_40a4287d8d2e7ef9 ) && var_40a4287d8d2e7ef9 )
    {
        self playersetgroundreferenceent( undefined );
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
    }
    
    if ( isdefined( player_rig ) )
    {
        player_rig delete();
    }
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 3
// Checksum 0x0, Offset: 0xdae
// Size: 0x6d
function infil_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.players )
    {
        player playsoundtoplayer( alias, player );
    }
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 0
// Checksum 0x0, Offset: 0xe23
// Size: 0x11
function infil_wait_for_players()
{
    wait 5;
    flag_set( "infil_started" );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 3
// Checksum 0x0, Offset: 0xe3c
// Size: 0x11f
function infil_scene_fade_in( delay_time, var_c82eabb722c361a7, var_fc787f4d3bf1501b )
{
    if ( !isdefined( delay_time ) )
    {
        delay_time = 0;
    }
    
    if ( !isdefined( var_c82eabb722c361a7 ) )
    {
        var_c82eabb722c361a7 = 2;
    }
    
    if ( !isdefined( var_fc787f4d3bf1501b ) )
    {
        var_fc787f4d3bf1501b = "infil_started";
    }
    
    overlay = newclienthudelem( self );
    overlay.x = 0;
    overlay.y = 0;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = 1;
    overlay.foreground = 1;
    overlay setshader( "black", 640, 480 );
    overlay endon( "death" );
    waittill_any_3( var_fc787f4d3bf1501b, "player_free_spot", "disconnect" );
    wait delay_time;
    overlay fadeovertime( var_c82eabb722c361a7 );
    overlay.alpha = 0;
    wait var_c82eabb722c361a7;
    overlay destroy();
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 0
// Checksum 0x0, Offset: 0xf63
// Size: 0x94
function givegunlesscp()
{
    gunless = makeweapon( "iw8_gunless_infil" );
    self.post_infil_weapon = self getcurrentprimaryweapon();
    _giveweapon( gunless, undefined, undefined, 1 );
    
    if ( !val::get( "script_weapon_switch" ) )
    {
        val::set( "gunless_cp", "script_weapon_switch", 1 );
    }
    
    success = 1;
    self switchtoweapon( gunless );
    
    if ( success )
    {
        self.gunnlessweapon = gunless;
        val::set( "gunless_cp", "weapon_switch", 0 );
    }
    else
    {
        self takeweapon( gunless );
    }
    
    return success;
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 0
// Checksum 0x0, Offset: 0x1000
// Size: 0x81
function takegunlesscp()
{
    if ( !isdefined( self.gunnlessweapon ) || !self hasweapon( self.gunnlessweapon ) )
    {
        return;
    }
    
    self notify( "get_post_infil_weapon" );
    waitframe();
    self.takinggunless = 1;
    val::set( "gunless_cp", "weapon_switch", 1 );
    self takeweapon( self.gunnlessweapon );
    self.takinggunless = 0;
    self.gunnlessweapon = undefined;
    val::set( "gunless_cp", "weapon_switch", 0 );
}

// Namespace cp_infilexfil / scripts\cp\cp_infilexfil
// Params 1
// Checksum 0x0, Offset: 0x1089
// Size: 0x182
function handleweaponstatenotetrackcp( state )
{
    switch ( state )
    {
        case #"hash_30b20a099c3735ec":
            self.player setdemeanorviewmodel( "normal" );
            wait 0.1;
            self.player givegunlesscp();
            break;
        case #"hash_5281b0cd075003":
            self.player takegunlesscp();
            
            if ( isdefined( self.player.post_infil_weapon ) )
            {
                self.player switchtoweapon( self.player.post_infil_weapon );
            }
            
            self.player.post_infil_weapon = undefined;
            break;
        case #"hash_9682e089e580b4b8":
            self.player setdemeanorviewmodel( "safe" );
            break;
        case #"hash_84fcf5e68d7230b2":
            self.player setdemeanorviewmodel( "normal" );
            break;
        case #"hash_a8f0b714fb0cb53b":
            self.player val::reset_all( "WeaponStateNotetrack" );
            break;
        case #"hash_dd93195493d0c818":
            self.player val::set( "WeaponStateNotetrack", "fire", 0 );
            self.player val::set( "WeaponStateNotetrack", "ads", 0 );
            self.player val::set( "WeaponStateNotetrack", "reload", 0 );
            break;
    }
}

