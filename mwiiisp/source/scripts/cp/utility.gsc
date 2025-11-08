#using scripts\anim\battlechatter;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_mp;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_challenge;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\equipment\nvg;
#using scripts\cp\events;
#using scripts\cp\globallogic;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\loot_system;
#using scripts\cp\munitions;
#using scripts\cp\nvg_ai;
#using scripts\cp\perks\cp_prestige;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\starts;
#using scripts\cp\utility;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;

#namespace utility;

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x43dd
// Size: 0x1b
function function_f0d6acf93c15bd59()
{
    if ( isdefined( level.zombie_round ) )
    {
        return level.zombie_round;
    }
    
    return 1;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x4401
// Size: 0x2d
function _giveweapon( weapon, variant, dualwieldoverride, usedbefore )
{
    return scripts\cp_mp\utility\inventory_utility::_giveweapon( weapon, variant, dualwieldoverride, usedbefore );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x4437
// Size: 0x201
function updatelaststandpistol( weapon )
{
    if ( isdefined( weapon ) )
    {
        assert( isweapon( weapon ) );
        
        if ( isdefined( level.last_stand_weapons ) )
        {
            var_491c4cc064c4f659 = getweaponbasename( weapon );
            
            if ( array_contains( level.last_stand_weapons, var_491c4cc064c4f659 ) )
            {
                self.last_stand_pistol = weapon;
                return;
            }
        }
    }
    
    allweapons = self getweaponslistall();
    var_ac68b11337bd07ea = 0;
    
    if ( isdefined( self.last_stand_pistol ) )
    {
        var_76fe5895a904870e = getweaponbasename( self.last_stand_pistol );
        
        foreach ( equippedweapon in allweapons )
        {
            baseweapon = getweaponbasename( equippedweapon );
            
            if ( baseweapon == var_76fe5895a904870e )
            {
                var_ac68b11337bd07ea = 1;
                return;
            }
        }
    }
    
    if ( !var_ac68b11337bd07ea )
    {
        if ( isdefined( level.last_stand_weapons ) )
        {
            foreach ( equippedweapon in allweapons )
            {
                baseweapon = getweaponbasename( equippedweapon );
                
                for ( i = level.last_stand_weapons.size - 1; i > -1 ; i-- )
                {
                    if ( baseweapon == level.last_stand_weapons[ i ] )
                    {
                        var_ac68b11337bd07ea = 1;
                        self.last_stand_pistol = equippedweapon;
                        return;
                    }
                }
            }
        }
        
        var_ea6befbe838b7be0 = getrawbaseweaponname( self.default_starting_pistol );
        
        if ( isdefined( self.weapon_build_models ) && isdefined( self.weapon_build_models[ var_ea6befbe838b7be0 ] ) )
        {
            self.last_stand_pistol = makeweaponfromstring( self.weapon_build_models[ var_ea6befbe838b7be0 ] );
            return;
        }
        
        self.last_stand_pistol = self.default_starting_pistol;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x4640
// Size: 0x76
function giveperk( perkname )
{
    assertex( isdefined( perkname ), "givePerk perkName not defined and should be" );
    assertex( !issubstr( perkname, "specialty_null" ), "givePerk perkName shouldn't be specialty_null, use _clearPerks()s" );
    assertex( !issubstr( perkname, "none" ), "givePerk perkName shouldn't be none, use _clearPerks()s" );
    
    if ( issubstr( perkname, "specialty_weapon_" ) )
    {
        _setperk( perkname );
        return;
    }
    
    _setperk( perkname );
    _setextraperks( perkname );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x46be
// Size: 0x31, Type: bool
function _hasperk( perkname )
{
    perks = self.perks;
    
    if ( !isdefined( perks ) )
    {
        return false;
    }
    
    if ( isdefined( perks[ perkname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x46f8
// Size: 0x76
function takeperk( perkname )
{
    assertex( isdefined( perkname ), "givePerk perkName not defined and should be" );
    assertex( !issubstr( perkname, "specialty_null" ), "givePerk perkName shouldn't be specialty_null, use _clearPerks()s" );
    assertex( !issubstr( perkname, "none" ), "givePerk perkName shouldn't be none, use _clearPerks()s" );
    
    if ( issubstr( perkname, "specialty_weapon_" ) )
    {
        _unsetperk( perkname );
        return;
    }
    
    _unsetperk( perkname );
    _unsetextraperks( perkname );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x4776
// Size: 0x6c
function _setperk( perkname )
{
    assertex( isdefined( perkname ), "_setPerk perkName not defined and should be" );
    self.perks[ perkname ] = 1;
    self.perksperkname[ perkname ] = perkname;
    perksetfunc = level.perksetfuncs[ perkname ];
    
    if ( isdefined( perksetfunc ) )
    {
        self thread [[ perksetfunc ]]();
    }
    
    self setperk( perkname, !isdefined( level.scriptperks[ perkname ] ) );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x47ea
// Size: 0x75
function _setextraperks( perkname )
{
    if ( isdefined( level.extraperkmap[ perkname ] ) )
    {
        foreach ( extraperk in level.extraperkmap[ perkname ] )
        {
            _setperk( extraperk );
            _setextraperks( extraperk );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x4867
// Size: 0x55
function _unsetperk( perkname )
{
    self.perks[ perkname ] = undefined;
    self.perksperkname[ perkname ] = undefined;
    
    if ( isdefined( level.perkunsetfuncs[ perkname ] ) )
    {
        self thread [[ level.perkunsetfuncs[ perkname ] ]]();
    }
    
    self unsetperk( perkname, !isdefined( level.scriptperks[ perkname ] ) );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x48c4
// Size: 0x75
function _unsetextraperks( perkname )
{
    if ( isdefined( level.extraperkmap[ perkname ] ) )
    {
        foreach ( extraperk in level.extraperkmap[ perkname ] )
        {
            _unsetperk( extraperk );
            _unsetextraperks( extraperk );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x4941
// Size: 0x84
function _clearperks()
{
    foreach ( perkname, perkvalue in self.perks )
    {
        if ( isdefined( level.perkunsetfuncs[ perkname ] ) )
        {
            self [[ level.perkunsetfuncs[ perkname ] ]]();
        }
    }
    
    self.perks = [];
    self.perksperkname = [];
    self clearperks();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x49cd
// Size: 0x50
function clearlowermessages()
{
    if ( isdefined( self.lowermessages ) )
    {
        for ( i = 0; i < self.lowermessages.size ; i++ )
        {
            self.lowermessages[ i ] = undefined;
        }
    }
    
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    updatelowermessage();
}

// Namespace utility / scripts\cp\utility
// Params 10
// Checksum 0x0, Offset: 0x4a25
// Size: 0xbb
function setlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu )
{
    if ( !isdefined( priority ) )
    {
        priority = 1;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    if ( !isdefined( showtimer ) )
    {
        showtimer = 0;
    }
    
    if ( !isdefined( shouldfade ) )
    {
        shouldfade = 0;
    }
    
    if ( !isdefined( fadetoalpha ) )
    {
        fadetoalpha = 0.85;
    }
    
    if ( !isdefined( fadetoalphatime ) )
    {
        fadetoalphatime = 3;
    }
    
    if ( !isdefined( hidewhenindemo ) )
    {
        hidewhenindemo = 0;
    }
    
    if ( !isdefined( hidewheninmenu ) )
    {
        hidewheninmenu = 1;
    }
    
    addlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu );
    updatelowermessage();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x4ae8
// Size: 0x24f
function updatelowermessage()
{
    self endon( "disconnect" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    message = getlowermessage();
    
    if ( !isdefined( message ) )
    {
        if ( isdefined( self.lowermessage ) )
        {
            self.lowermessage.alpha = 0;
            self.lowermessage settext( "" );
            
            if ( isdefined( self.lowertimer ) )
            {
                self.lowertimer.alpha = 0;
            }
        }
        
        return;
    }
    
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    self.lowermessage settext( message.text );
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = message.hidewhenindemo;
    self.lowermessage.hidewheninmenu = message.hidewheninmenu;
    
    if ( message.shouldfade )
    {
        self.lowermessage fadeovertime( min( message.fadetoalphatime, 60 ) );
        self.lowermessage.alpha = message.fadetoalpha;
    }
    
    if ( message.time > 0 && message.showtimer )
    {
        self.lowertimer settimer( max( message.time - ( gettime() - message.addtime ) / 1000, 0.1 ) );
        return;
    }
    
    if ( message.time > 0 && !message.showtimer )
    {
        self.lowertimer settext( "" );
        self.lowermessage fadeovertime( min( message.time, 60 ) );
        self.lowermessage.alpha = 0;
        thread clearondeath( message );
        thread clearafterfade( message );
        return;
    }
    
    self.lowertimer settext( "" );
}

// Namespace utility / scripts\cp\utility
// Params 10
// Checksum 0x0, Offset: 0x4d3f
// Size: 0x1a7
function addlowermessage( name, text, time, priority, showtimer, shouldfade, fadetoalpha, fadetoalphatime, hidewhenindemo, hidewheninmenu )
{
    newmessage = undefined;
    
    foreach ( message in self.lowermessages )
    {
        if ( message.name == name )
        {
            if ( message.text == text && message.priority == priority )
            {
                return;
            }
            
            newmessage = message;
            break;
        }
    }
    
    if ( !isdefined( newmessage ) )
    {
        newmessage = spawnstruct();
        self.lowermessages[ self.lowermessages.size ] = newmessage;
    }
    
    newmessage.name = name;
    newmessage.text = text;
    newmessage.time = time;
    newmessage.addtime = gettime();
    newmessage.priority = priority;
    newmessage.showtimer = showtimer;
    newmessage.shouldfade = shouldfade;
    newmessage.fadetoalpha = fadetoalpha;
    newmessage.fadetoalphatime = fadetoalphatime;
    newmessage.hidewhenindemo = hidewhenindemo;
    newmessage.hidewheninmenu = hidewheninmenu;
    sortlowermessages();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x4eee
// Size: 0xb0
function sortlowermessages()
{
    for ( i = 1; i < self.lowermessages.size ; i++ )
    {
        message = self.lowermessages[ i ];
        priority = message.priority;
        
        for ( j = i - 1; j >= 0 && priority > self.lowermessages[ j ].priority ; j-- )
        {
            self.lowermessages[ j + 1 ] = self.lowermessages[ j ];
        }
        
        self.lowermessages[ j + 1 ] = message;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x4fa6
// Size: 0x1c
function getlowermessage()
{
    if ( !isdefined( self.lowermessages ) )
    {
        return undefined;
    }
    
    return self.lowermessages[ 0 ];
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x4fcb
// Size: 0x42
function clearondeath( message )
{
    self notify( "message_cleared" );
    self endon( "message_cleared" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    clearlowermessage( message.name );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5015
// Size: 0x31
function clearafterfade( message )
{
    wait message.time;
    clearlowermessage( message.name );
    self notify( "message_cleared" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x504e
// Size: 0x1a
function clearlowermessage( name )
{
    removelowermessage( name );
    updatelowermessage();
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5070
// Size: 0xda
function removelowermessage( name )
{
    if ( isdefined( self.lowermessages ) )
    {
        for ( i = self.lowermessages.size; i > 0 ; i-- )
        {
            if ( self.lowermessages[ i - 1 ].name != name )
            {
                continue;
            }
            
            message = self.lowermessages[ i - 1 ];
            
            for ( j = i; j < self.lowermessages.size ; j++ )
            {
                if ( isdefined( self.lowermessages[ j ] ) )
                {
                    self.lowermessages[ j - 1 ] = self.lowermessages[ j ];
                }
            }
            
            self.lowermessages[ self.lowermessages.size - 1 ] = undefined;
        }
        
        sortlowermessages();
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5152
// Size: 0x5d
function freezecontrolswrapper( frozen )
{
    if ( isdefined( level.hostmigrationtimer ) )
    {
        println( "<dev string:x1c>" + scripts\cp\cp_hostmigration::hostmigrationname( self ) + "<dev string:x45>" + frozen );
        self.hostmigrationcontrolsfrozen = 1;
        self freezecontrols( 1 );
        return;
    }
    
    self freezecontrols( frozen );
    self.controlsfrozen = frozen;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x51b7
// Size: 0x3b
function setthirdpersondof( isenabled )
{
    if ( isenabled )
    {
        self setdepthoffield( 0, 110, 512, 4096, 6, 1.8 );
        return;
    }
    
    self setdepthoffield( 0, 0, 512, 512, 4, 0 );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x51fa
// Size: 0x77
function setusingremote( remotename )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
    
    assert( !isusingremote() );
    self.usingremote = remotename;
    val::set( "remote", "offhand_weapons", 0 );
    self notify( "using_remote" );
    self setclientomnvar( "ui_using_killstreak_remote", 1 );
    self notify( "using_remote" );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x5279
// Size: 0x71
function updatesessionstate( sessionstate, statusicon )
{
    assert( sessionstate == "playing" || sessionstate == "dead" || sessionstate == "spectator" || sessionstate == "intermission" );
    self.sessionstate = sessionstate;
    
    if ( !isdefined( statusicon ) )
    {
        statusicon = "";
    }
    
    self.statusicon = statusicon;
    self setclientomnvar( "ui_session_state", sessionstate );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x52f2
// Size: 0x96
function getuniqueid()
{
    if ( isdefined( self.pers[ "guid" ] ) )
    {
        return self.pers[ "guid" ];
    }
    
    playerguid = self getguid();
    
    if ( playerguid == "0000000000000000" )
    {
        if ( isdefined( level.guidgen ) )
        {
            level.guidgen++;
        }
        else
        {
            level.guidgen = 1;
        }
        
        playerguid = "script" + level.guidgen;
    }
    
    self.pers[ "guid" ] = playerguid;
    return self.pers[ "guid" ];
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5391
// Size: 0x3b
function gameflagset( flagname )
{
    assertex( isdefined( game[ "flags" ][ flagname ] ), "gameFlag " + flagname + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )" );
    game[ "flags" ][ flagname ] = 1;
    level notify( flagname );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x53d4
// Size: 0x2f
function gameflaginit( flagname, isenabled )
{
    assert( isdefined( game[ "flags" ] ) );
    game[ "flags" ][ flagname ] = isenabled;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x540b
// Size: 0x34
function gameflag( flagname )
{
    assertex( isdefined( game[ "flags" ][ flagname ] ), "gameFlag " + flagname + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )" );
    return game[ "flags" ][ flagname ];
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5448
// Size: 0x3c
function gameflagwait( flagname )
{
    assertex( isdefined( game[ "flags" ][ flagname ] ), "gameFlag " + flagname + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )" );
    
    while ( !gameflag( flagname ) )
    {
        level waittill( flagname );
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x548c
// Size: 0x1d, Type: bool
function matchmakinggame()
{
    return level.onlinegame && !getdvarint( @"xblive_privatematch" );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x54b2
// Size: 0x1b, Type: bool
function inovertime()
{
    return isdefined( game[ "status" ] ) && game[ "status" ] == "overtime";
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x54d6
// Size: 0x19
function initlevelflags()
{
    if ( !isdefined( level.levelflags ) )
    {
        level.levelflags = [];
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x54f7
// Size: 0x16
function initgameflags()
{
    if ( !isdefined( game[ "flags" ] ) )
    {
        game[ "flags" ] = [];
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5515
// Size: 0x2a
function isenemy( other )
{
    if ( level.teambased )
    {
        return isplayeronenemyteam( other );
    }
    
    return isplayerffaenemy( other );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5547
// Size: 0x20, Type: bool
function isplayeronenemyteam( other )
{
    return other.team != self.team;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5570
// Size: 0x2f
function isplayerffaenemy( other )
{
    if ( isdefined( other.owner ) )
    {
        return ( other.owner != self );
    }
    
    return other != self;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x55a7
// Size: 0x21, Type: bool
function isgameplayteam( team )
{
    return isdefined( team ) && array_contains( level.teamnamelist, team );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x55d1
// Size: 0x65
function notusableforjoiningplayers( owner )
{
    self notify( "notusablejoiningplayers" );
    self endon( "death" );
    level endon( "game_ended" );
    owner endon( "disconnect" );
    owner endon( "death" );
    self endon( "notusablejoiningplayers" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        
        if ( isdefined( player ) && player != owner )
        {
            self disableplayeruse( player );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x563e
// Size: 0x74
function setselfusable( caller )
{
    self makeusable();
    
    foreach ( player in level.players )
    {
        if ( player != caller )
        {
            self disableplayeruse( player );
            continue;
        }
        
        self enableplayeruse( player );
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x56ba
// Size: 0x53, Type: bool
function isenvironmentweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "isEnvironmentWeapon called without a weapon name passed in" );
        return false;
    }
    
    if ( isweapon( weapon ) )
    {
        if ( weapon.basename == "turret_minigun_mp" )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    if ( weapon == "turret_minigun_mp" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5716
// Size: 0x64, Type: bool
function issuperweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "isSuperWeapon called without a weapon name passed in" );
        return false;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = getcompleteweaponname( weapon );
    }
    else
    {
        weaponname = weapon;
    }
    
    if ( isdefined( level.superweapons ) && isdefined( level.superweapons[ weaponname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x5783
// Size: 0x3d
function strip_suffix( lookupstring, stripstring )
{
    if ( lookupstring.size <= stripstring.size )
    {
        return lookupstring;
    }
    
    if ( getsubstr( lookupstring, lookupstring.size - stripstring.size, lookupstring.size ) == stripstring )
    {
        return getsubstr( lookupstring, 0, lookupstring.size - stripstring.size );
    }
    
    return lookupstring;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x57c9
// Size: 0x20
function delayentdelete( time )
{
    self endon( "death" );
    wait time;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x57f1
// Size: 0x2b
function deleteonplayerdeathdisconnect( player )
{
    self endon( "death" );
    player waittill_any_2( "death", "disconnect" );
    self delete();
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x5824
// Size: 0x1e, Type: bool
function isstrstart( string, substr )
{
    return getsubstr( string, 0, substr.size ) == substr;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x584b
// Size: 0x12
function getbaseweaponname( weapon )
{
    return getweaponrootname( weapon );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x5866
// Size: 0xc, Type: bool
function is_weapon_purchase_disabled()
{
    return istrue( level.weapon_purchase_disabled );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x587b
// Size: 0x88
function getrawbaseweaponname( weapon )
{
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    tokens = strtok( weaponname, "_" );
    
    if ( tokens[ 0 ] == "iw5" || tokens[ 0 ] == "iw6" || tokens[ 0 ] == "iw7" )
    {
        weaponname = tokens[ 1 ];
    }
    else if ( tokens[ 0 ] == "alt" )
    {
        weaponname = tokens[ 2 ];
    }
    
    return weaponname;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x590c
// Size: 0x34
function getintproperty( dvar, defvalue )
{
    value = defvalue;
    
    /#
        setdevdvarifuninitialized( dvar, defvalue );
    #/
    
    value = getdvarint( dvar, defvalue );
    return value;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5949
// Size: 0x100, Type: bool
function touchingbadtrigger( exclude_oob_zones )
{
    killtriggers = getentarray( "trigger_hurt", "classname" );
    
    foreach ( trigger in killtriggers )
    {
        if ( istrue( exclude_oob_zones ) )
        {
            if ( isdefined( trigger.targetname ) )
            {
                if ( trigger.targetname == "oob_kill_trig" )
                {
                    continue;
                }
            }
        }
        
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    radtriggers = getentarray( "radiation", "targetname" );
    
    foreach ( trigger in radtriggers )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5a52
// Size: 0x41, Type: bool
function function_b1686c9759c1048( entity )
{
    return isdefined( entity ) && ( is_equal( entity.classname, "trigger_hurt" ) || is_equal( entity.targetname, "radiation" ) );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5a9c
// Size: 0xb9, Type: bool
function function_496139dd736902cc( struct )
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isdefined( struct ) || !isdefined( struct.radius ) || !isdefined( struct.height ) )
    {
        return false;
    }
    
    if ( distance2d( self.origin, struct.origin ) <= float( struct.radius ) )
    {
        if ( self.origin[ 2 ] >= struct.origin[ 2 ] || self.origin[ 2 ] <= struct.origin[ 2 ] + float( struct.height ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x5b5e
// Size: 0x58
function playsoundinspace( alias, origin, wait_until_done )
{
    if ( isdefined( alias ) )
    {
        if ( isarray( alias ) )
        {
            alias = random( alias );
        }
        
        timer = lookupsoundlength( alias );
        playsoundatpos( origin, alias );
        
        if ( isdefined( wait_until_done ) )
        {
            wait timer / 1000;
        }
        
        return timer;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x5bbe
// Size: 0x8c
function playdeathsound()
{
    rand = randomintrange( 1, 8 );
    type = "generic";
    
    if ( self hasfemalecustomizationmodel() )
    {
        type = "female";
    }
    
    if ( self.team == "axis" )
    {
        sound = type + "_death_russian_" + rand;
        
        if ( soundexists( sound ) )
        {
            self playsound( sound );
        }
        
        return;
    }
    
    sound = type + "_death_american_" + rand;
    
    if ( soundexists( sound ) )
    {
        self playsound( sound );
    }
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x5c52
// Size: 0x3e, Type: bool
function isfmjdamage( sweapon, smeansofdeath, attacker )
{
    return isdefined( attacker ) && attacker _hasperk( "specialty_armorpiercing" ) && isdefined( smeansofdeath ) && isbulletdamage( smeansofdeath );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5c99
// Size: 0x7c
function getattachmenttype( attachmentname )
{
    if ( !isdefined( attachmentname ) )
    {
        return "none";
    }
    
    attachmenttype = tablelookup( "mp/attachmenttable.csv", 4, attachmentname, 2 );
    
    if ( !isdefined( attachmenttype ) || isdefined( attachmenttype ) && attachmenttype == "" )
    {
        gametype = getdvar( @"g_gametype" );
        
        if ( gametype == "zombie" )
        {
            attachmenttype = tablelookup( "cp/zombies/zombie_attachmentTable.csv", 4, attachmentname, 2 );
        }
    }
    
    return attachmenttype;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x5d1e
// Size: 0x6f, Type: bool
function weaponhasattachment( weaponname, attachmentname )
{
    weaponattachments = getweaponattachments( weaponname );
    
    foreach ( attachment in weaponattachments )
    {
        if ( attachment == attachmentname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x5d96
// Size: 0xdd, Type: bool
function function_8a4f25fb9d4c43c8( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    group = scripts\cp\weapon::getweapongroup( weapon );
    
    switch ( group )
    {
        case #"hash_16cf6289ab06bd30":
            if ( weapon.basename == "iw9_sh_mviktor_mp" )
            {
                return true;
            }
            else
            {
                return false;
            }
        case #"hash_86b11ac21f992552":
        case #"hash_9d18adab1b65a661":
        case #"hash_a1f27f97be15d620":
            return false;
    }
    
    if ( isdefined( weapon.basename ) )
    {
        switch ( weapon.basename )
        {
            case #"hash_1ee4b4461a10e3f1":
            case #"hash_36493c758ad2ab7e":
            case #"hash_5e7bf75eb9db150e":
            case #"hash_87262a67e163f7c9":
            case #"hash_a86d4075406d2de4":
                return false;
        }
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x5e7c
// Size: 0x13f, Type: bool
function isjuggernaut()
{
    if ( isdefined( self.unittype ) && self.unittype == "juggernaut" )
    {
        return true;
    }
    
    if ( isdefined( self.aitype ) && self.aitype == "juggernaut" )
    {
        return true;
    }
    
    if ( isdefined( self.agent_type ) && ( self.agent_type == "actor_enemy_cp_jugg_aq" || self.agent_type == "actor_enemy_cp_jugg_cartel" ) )
    {
        return true;
    }
    
    if ( isdefined( self.isjuggernaut ) && self.isjuggernaut == 1 )
    {
        return true;
    }
    
    if ( isdefined( self.isjuggernautdef ) && self.isjuggernautdef == 1 )
    {
        return true;
    }
    
    if ( isdefined( self.isjuggernautgl ) && self.isjuggernautgl == 1 )
    {
        return true;
    }
    
    if ( isdefined( self.isjuggernautrecon ) && self.isjuggernautrecon == 1 )
    {
        return true;
    }
    
    if ( isdefined( self.isjuggernautmaniac ) && self.isjuggernautmaniac == 1 )
    {
        return true;
    }
    
    if ( isdefined( self.isjuggernautlevelcustom ) && self.isjuggernautlevelcustom == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x5fc4
// Size: 0x154
function allowridekillstreakplayerexit( earlyendnotify, no_owner, var_41fdf38ee0b2251a )
{
    if ( isdefined( earlyendnotify ) )
    {
        self endon( earlyendnotify );
    }
    
    if ( isdefined( no_owner ) )
    {
        owner = self;
    }
    else
    {
        if ( !isdefined( self.owner ) )
        {
            return;
        }
        
        owner = self.owner;
    }
    
    level endon( "game_ended" );
    owner endon( "disconnect" );
    owner endon( "end_remote" );
    owner notify( "watch_use_exit" );
    owner endon( "diable_use_exit" );
    self endon( "death" );
    thread allow_force_player_exit();
    
    if ( !isdefined( level.framedurationseconds ) )
    {
        level.framedurationseconds = level.frameduration / 1000;
    }
    
    updaterate = level.framedurationseconds;
    
    if ( isdefined( var_41fdf38ee0b2251a ) )
    {
        holdtime = var_41fdf38ee0b2251a;
    }
    else
    {
        holdtime = 3;
    }
    
    timerdirty = 1;
    
    while ( true )
    {
        timeused = 0;
        
        if ( timerdirty == 1 )
        {
            owner setclientomnvar( "ui_exit_progress", 0 );
            timerdirty = 0;
        }
        
        while ( owner usebuttonpressed() && !istrue( owner.var_5d43389756907528 ) )
        {
            timeused += updaterate;
            timerdirty = 1;
            owner setclientomnvar( "ui_exit_progress", timeused / holdtime );
            
            if ( timeused > holdtime )
            {
                self notify( "killstreakExit" );
                return;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x6120
// Size: 0x19
function allow_force_player_exit()
{
    self endon( "killstreakExit" );
    level waittill( "cp_force_killstreak_exit" );
    self notify( "killstreakExit" );
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0x6141
// Size: 0x118
function killstreak_createobjective( shadername, team, friendly, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize )
{
    curobjid = nonobjective_requestobjectiveid( 1 );
    objective_position( curobjid, self.origin );
    objective_icon( curobjid, shadername );
    objective_state( curobjid, "active" );
    objective_setbackground( curobjid, 1 );
    
    if ( !isdefined( self getlinkedparent() ) && !istrue( var_2231e5a0f940caae ) )
    {
        update_objective_position( curobjid, self.origin );
    }
    else if ( istrue( var_2231e5a0f940caae ) && istrue( var_dbe22cd5d2a797af ) )
    {
        update_objective_onentitywithrotation( curobjid, self );
    }
    else
    {
        update_objective_onentity( curobjid, self );
    }
    
    scripts\mp\objidpoolmanager::function_c3c6bff089dfdd34( curobjid, iconsize );
    
    if ( isdefined( team ) )
    {
        objective_setownerteam( curobjid, team );
        
        if ( !level.teambased && isdefined( self.owner ) )
        {
            if ( istrue( friendly ) )
            {
                scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam( curobjid, self.owner );
            }
            else
            {
                scripts\mp\objidpoolmanager::objective_teammask_single( curobjid, team );
            }
        }
    }
    else
    {
        scripts\mp\objidpoolmanager::objective_playermask_showtoall( curobjid );
    }
    
    return curobjid;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x6262
// Size: 0xf7
function killstreak_createobjective_engineer( shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize )
{
    curobjid = nonobjective_requestobjectiveid( 1 );
    
    if ( curobjid == -1 )
    {
        return -1;
    }
    
    if ( !objective_isunlimited() )
    {
        objective_delete( curobjid );
    }
    
    objective_state( curobjid, "invisible" );
    objective_position( curobjid, ( 0, 0, 0 ) );
    
    if ( !isdefined( self getlinkedparent() ) && !istrue( var_2231e5a0f940caae ) )
    {
        update_objective_position( curobjid, self.origin );
    }
    else if ( istrue( var_2231e5a0f940caae ) && istrue( var_dbe22cd5d2a797af ) )
    {
        update_objective_onentitywithrotation( curobjid, self );
    }
    else
    {
        update_objective_onentity( curobjid, self );
    }
    
    objective_state( curobjid, "active" );
    objective_icon( curobjid, shadername );
    objective_setbackground( curobjid, 1 );
    objective_setownerteam( curobjid, self.team );
    
    if ( isdefined( iconsize ) )
    {
        objective_setminimapiconsize( curobjid, iconsize );
    }
    
    scripts\cp\cp_objectives::minimap_objective_playermask_hidefromall( curobjid );
    return curobjid;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x6362
// Size: 0x23
function update_objective_position( objid, position )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_position( objid, position );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x638d
// Size: 0x23
function update_objective_onentity( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_onentity( objid, ent );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x63b8
// Size: 0x2c
function update_objective_onentitywithrotation( objid, ent )
{
    if ( objid == -1 )
    {
        return;
    }
    
    objective_onentity( objid, ent );
    objective_setrotateonminimap( objid, 1 );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x63ec
// Size: 0x13
function nonobjective_returnobjectiveid( objid )
{
    scripts\cp\cp_objectives::freeworldidbyobjid( objid );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x6407
// Size: 0x18
function nonobjective_requestobjectiveid( priority )
{
    return scripts\cp\cp_objectives::requestworldid( "nonobj_marker", 1 );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x6428
// Size: 0x66
function clearusingremote( bypassweaponswitch )
{
    val::reset_all( "remote" );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 1;
    }
    
    self.usingremote = undefined;
    
    if ( !isdefined( bypassweaponswitch ) )
    {
        _freezecontrols( 0 );
    }
    
    self setclientomnvar( "ui_using_killstreak_remote", 0 );
    self notify( "stopped_using_remote" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x6496
// Size: 0x291
function cp_add_dialogue_line( msg )
{
    if ( getdvarint( @"loc_warnings", 0 ) )
    {
        return;
    }
    
    if ( istrue( level.disabledebugdialogue ) )
    {
        return;
    }
    
    if ( !isdefined( level.dialogue_huds ) )
    {
        level.dialogue_huds = [];
    }
    
    if ( level.dialogue_huds.size == 5 )
    {
        oldhud = level.dialogue_huds[ 0 ];
        level.dialogue_huds = array_remove_index( level.dialogue_huds, 0 );
        update_dialogue_huds();
        oldhud thread destroy_dialogue_hud();
    }
    
    if ( soundexists( "cp_ui_menu_title_decode_text" ) )
    {
        foreach ( player in level.players )
        {
            player playlocalsound( "cp_ui_menu_title_decode_text" );
        }
    }
    
    color = "^3";
    scale = 1;
    
    if ( isdefined( level.dialoguelinescale ) )
    {
        scale = level.dialoguelinescale;
    }
    
    hud = newhudelem();
    hud.elemtype = "font";
    hud.font = "default";
    hud.fontscale = scale;
    hud.x = 0;
    hud.y = 0;
    hud.width = 0;
    hud.height = int( level.fontheight * scale );
    hud.xoffset = 0;
    hud.yoffset = 0;
    index = level.dialogue_huds.size;
    level.dialogue_huds[ index ] = hud;
    hud.foreground = 1;
    hud.sort = 20;
    hud.x = 40;
    hud.y = 260 + index * 12 * scale;
    hud.label = msg;
    hud.alpha = 0;
    hud fadeovertime( 0.2 );
    hud.alpha = 1;
    hud endon( "death" );
    wait 8;
    level.dialogue_huds = array_remove( level.dialogue_huds, hud );
    update_dialogue_huds();
    hud thread cp_destroy_dialogue_hud();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x672f
// Size: 0x74
function cp_destroy_dialogue_hud()
{
    scale = 1;
    
    if ( isdefined( level.dialoguelinescale ) )
    {
        scale = level.dialoguelinescale;
    }
    
    self endon( "death" );
    self fadeovertime( 0.2 );
    self moveovertime( 0.2 );
    self.y -= 12 * scale;
    self.alpha = 0;
    wait 0.2;
    self destroy();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x67ab
// Size: 0x74
function destroy_dialogue_hud()
{
    scale = 1;
    
    if ( isdefined( level.dialoguelinescale ) )
    {
        scale = level.dialoguelinescale;
    }
    
    self endon( "death" );
    self fadeovertime( 0.2 );
    self moveovertime( 0.2 );
    self.y -= 12 * scale;
    self.alpha = 0;
    wait 0.2;
    self destroy();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x6827
// Size: 0xaa
function update_dialogue_huds()
{
    scale = 1;
    
    if ( isdefined( level.dialoguelinescale ) )
    {
        scale = level.dialoguelinescale;
    }
    
    level.dialogue_huds = array_removeundefined( level.dialogue_huds );
    
    foreach ( hud in level.dialogue_huds )
    {
        hud moveovertime( 0.2 );
        hud.y = 260 + index * 12 * scale;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x68d9
// Size: 0x23
function getfirstprimaryweapon()
{
    weaponslist = self getweaponslistprimaries();
    assert( isdefined( weaponslist[ 0 ] ) );
    return weaponslist[ 0 ];
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x6905
// Size: 0x102
function createfontstring( font, fontscale, server )
{
    if ( !isdefined( server ) || !server )
    {
        fontelem = newclienthudelem( self );
    }
    else
    {
        fontelem = newhudelem();
    }
    
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent( level.uiparent );
    fontelem.hidden = 0;
    return fontelem;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x6a10
// Size: 0xa8
function setparent( element )
{
    if ( isdefined( self.parent ) && self.parent == element )
    {
        return;
    }
    
    if ( isdefined( self.parent ) )
    {
        self.parent removechild( self );
    }
    
    self.parent = element;
    self.parent addchild( self );
    
    if ( isdefined( self.point ) )
    {
        setpoint( self.point, self.relativepoint, self.xoffset, self.yoffset );
        return;
    }
    
    setpoint( "TOPLEFT" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x6ac0
// Size: 0xac
function removechild( element )
{
    element.parent = undefined;
    
    if ( self.children[ self.children.size - 1 ] != element )
    {
        self.children[ element.index ] = self.children[ self.children.size - 1 ];
        self.children[ element.index ].index = element.index;
    }
    
    self.children[ self.children.size - 1 ] = undefined;
    element.index = undefined;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x6b74
// Size: 0x3e
function addchild( element )
{
    element.index = self.children.size;
    self.children[ self.children.size ] = element;
    removedestroyedchildren();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x6bba
// Size: 0xac
function removedestroyedchildren()
{
    if ( isdefined( self.childchecktime ) && self.childchecktime == gettime() )
    {
        return;
    }
    
    self.childchecktime = gettime();
    newchildren = [];
    
    foreach ( child in self.children )
    {
        if ( !isdefined( child ) )
        {
            continue;
        }
        
        child.index = newchildren.size;
        newchildren[ newchildren.size ] = child;
    }
    
    self.children = newchildren;
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0x6c6e
// Size: 0x401
function setpoint( point, relativepoint, xoffset, yoffset, movetime )
{
    if ( !isdefined( movetime ) )
    {
        movetime = 0;
    }
    
    element = getparent();
    
    if ( movetime )
    {
        self moveovertime( movetime );
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    self.xoffset = xoffset;
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = 0;
    }
    
    self.yoffset = yoffset;
    self.point = point;
    self.alignx = "center";
    self.aligny = "middle";
    
    if ( issubstr( point, "TOP" ) )
    {
        self.aligny = "top";
    }
    
    if ( issubstr( point, "BOTTOM" ) )
    {
        self.aligny = "bottom";
    }
    
    if ( issubstr( point, "LEFT" ) )
    {
        self.alignx = "left";
    }
    
    if ( issubstr( point, "RIGHT" ) )
    {
        self.alignx = "right";
    }
    
    if ( !isdefined( relativepoint ) )
    {
        relativepoint = point;
    }
    
    self.relativepoint = relativepoint;
    relativex = "center_adjustable";
    relativey = "middle";
    
    if ( issubstr( relativepoint, "TOP" ) )
    {
        relativey = "top_adjustable";
    }
    
    if ( issubstr( relativepoint, "BOTTOM" ) )
    {
        relativey = "bottom_adjustable";
    }
    
    if ( issubstr( relativepoint, "LEFT" ) )
    {
        relativex = "left_adjustable";
    }
    
    if ( issubstr( relativepoint, "RIGHT" ) )
    {
        relativex = "right_adjustable";
    }
    
    if ( element == level.uiparent )
    {
        self.horzalign = relativex;
        self.vertalign = relativey;
    }
    else
    {
        self.horzalign = element.horzalign;
        self.vertalign = element.vertalign;
    }
    
    if ( strip_suffix( relativex, "_adjustable" ) == element.alignx )
    {
        offsetx = 0;
        xfactor = 0;
    }
    else if ( relativex == "center" || element.alignx == "center" )
    {
        offsetx = int( element.width / 2 );
        
        if ( relativex == "left_adjustable" || element.alignx == "right" )
        {
            xfactor = -1;
        }
        else
        {
            xfactor = 1;
        }
    }
    else
    {
        offsetx = element.width;
        
        if ( relativex == "left_adjustable" )
        {
            xfactor = -1;
        }
        else
        {
            xfactor = 1;
        }
    }
    
    self.x = element.x + offsetx * xfactor;
    
    if ( strip_suffix( relativey, "_adjustable" ) == element.aligny )
    {
        offsety = 0;
        yfactor = 0;
    }
    else if ( relativey == "middle" || element.aligny == "middle" )
    {
        offsety = int( element.height / 2 );
        
        if ( relativey == "top_adjustable" || element.aligny == "bottom" )
        {
            yfactor = -1;
        }
        else
        {
            yfactor = 1;
        }
    }
    else
    {
        offsety = element.height;
        
        if ( relativey == "top_adjustable" )
        {
            yfactor = -1;
        }
        else
        {
            yfactor = 1;
        }
    }
    
    self.y = element.y + offsety * yfactor;
    self.x += self.xoffset;
    self.y += self.yoffset;
    
    switch ( self.elemtype )
    {
        case #"hash_2125856c1b2381fa":
            setpointbar( point, relativepoint, xoffset, yoffset );
            break;
    }
    
    updatechildren();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x7077
// Size: 0xb
function getparent()
{
    return self.parent;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x708b
// Size: 0x1c8
function setpointbar( point, relativepoint, xoffset, yoffset )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y;
    
    if ( self.alignx == "left" )
    {
        self.bar.x = self.x;
    }
    else if ( self.alignx == "right" )
    {
        self.bar.x = self.x - self.width;
    }
    else
    {
        self.bar.x = self.x - int( self.width / 2 );
    }
    
    if ( self.aligny == "top" )
    {
        self.bar.y = self.y;
    }
    else if ( self.aligny == "bottom" )
    {
        self.bar.y = self.y;
    }
    
    updatebar( self.bar.frac );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x725b
// Size: 0x2e
function updatebar( barfrac, rateofchange )
{
    if ( self.elemtype == "bar" )
    {
        updatebarscale( barfrac, rateofchange );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x7291
// Size: 0x188
function updatebarscale( barfrac, rateofchange )
{
    barwidth = int( self.width * barfrac + 0.5 );
    
    if ( !barwidth )
    {
        barwidth = 1;
    }
    
    self.bar.frac = barfrac;
    self.bar setshader( self.bar.shader, barwidth, self.height );
    assertex( barwidth <= self.width, "barWidth <= self.width: " + barwidth + " <= " + self.width + " - barFrac was " + barfrac );
    
    if ( isdefined( rateofchange ) && barwidth < self.width )
    {
        if ( rateofchange > 0 )
        {
            assertex( ( 1 - barfrac ) / rateofchange > 0, "barFrac: " + barfrac + "rateOfChange: " + rateofchange );
            self.bar scaleovertime( ( 1 - barfrac ) / rateofchange, self.width, self.height );
        }
        else if ( rateofchange < 0 )
        {
            assertex( barfrac / -1 * rateofchange > 0, "barFrac: " + barfrac + "rateOfChange: " + rateofchange );
            self.bar scaleovertime( barfrac / -1 * rateofchange, 1, self.height );
        }
    }
    
    self.bar.rateofchange = rateofchange;
    self.bar.lastupdatetime = gettime();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x7421
// Size: 0x6d
function updatechildren()
{
    for ( index = 0; index < self.children.size ; index++ )
    {
        child = self.children[ index ];
        child setpoint( child.point, child.relativepoint, child.xoffset, child.yoffset );
    }
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x7496
// Size: 0x118
function createicon( shader, width, height, server )
{
    if ( !isdefined( server ) )
    {
        iconelem = newclienthudelem( self );
    }
    else
    {
        iconelem = newhudelem();
    }
    
    iconelem.elemtype = "icon";
    iconelem.x = 0;
    iconelem.y = 0;
    iconelem.width = width;
    iconelem.height = height;
    iconelem.basewidth = iconelem.width;
    iconelem.baseheight = iconelem.height;
    iconelem.xoffset = 0;
    iconelem.yoffset = 0;
    iconelem.children = [];
    iconelem setparent( level.uiparent );
    iconelem.hidden = 0;
    
    if ( isdefined( shader ) )
    {
        iconelem setshader( shader, width, height );
        iconelem.shader = shader;
    }
    
    return iconelem;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x75b7
// Size: 0xb6
function destroyelem()
{
    tempchildren = [];
    
    if ( isdefined( self.children ) )
    {
        for ( index = 0; index < self.children.size ; index++ )
        {
            if ( isdefined( self.children[ index ] ) )
            {
                tempchildren[ tempchildren.size ] = self.children[ index ];
            }
        }
        
        for ( index = 0; index < tempchildren.size ; index++ )
        {
            tempchildren[ index ] setparent( getparent() );
        }
    }
    
    if ( self.elemtype == "bar" || self.elemtype == "bar_shader" )
    {
        self.bar destroy();
    }
    
    self destroy();
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x7675
// Size: 0xca
function createprimaryprogressbartext( xoffset, yoffset, fontsize, usefont )
{
    if ( isagent( self ) )
    {
        return undefined;
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = -25;
    }
    
    if ( self issplitscreenplayer() )
    {
        yoffset += 20;
    }
    
    font_size = level.primaryprogressbarfontsize;
    font = "default";
    
    if ( isdefined( fontsize ) )
    {
        font_size = fontsize;
    }
    
    if ( isdefined( usefont ) )
    {
        font = usefont;
    }
    
    text = createfontstring( font, font_size );
    text setpoint( "CENTER", undefined, level.primaryprogressbartextx + xoffset, level.primaryprogressbartexty + yoffset );
    text.sort = -1;
    return text;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x7748
// Size: 0xb3
function createprimaryprogressbar( xoffset, yoffset, width, height )
{
    if ( isagent( self ) )
    {
        return undefined;
    }
    
    if ( !isdefined( xoffset ) )
    {
        xoffset = 0;
    }
    
    if ( !isdefined( yoffset ) )
    {
        yoffset = -25;
    }
    
    if ( self issplitscreenplayer() )
    {
        yoffset += 20;
    }
    
    if ( !isdefined( width ) )
    {
        width = level.primaryprogressbarwidth;
    }
    
    if ( !isdefined( height ) )
    {
        height = level.primaryprogressbarheight;
    }
    
    bar = createbar( ( 1, 1, 1 ), width, height );
    bar setpoint( "CENTER", undefined, level.primaryprogressbarx + xoffset, level.primaryprogressbary + yoffset );
    return bar;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x7804
// Size: 0x18f
function createbar( color, width, height, flashfrac )
{
    barelem = newclienthudelem( self );
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader( "progress_bar_fill", width, height );
    barelem.hidden = 0;
    
    if ( isdefined( flashfrac ) )
    {
        barelem.flashfrac = flashfrac;
    }
    
    barelembg = newclienthudelem( self );
    barelembg.elemtype = "bar";
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.children = [];
    barelembg.sort = -3;
    barelembg.color = ( 0, 0, 0 );
    barelembg.alpha = 0.5;
    barelembg setparent( level.uiparent );
    barelembg setshader( "progress_bar_bg", width + 4, height + 4 );
    barelembg.hidden = 0;
    return barelembg;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x799c
// Size: 0x67
function getplayerforguid( guid )
{
    foreach ( player in level.players )
    {
        if ( player.guid == guid )
        {
            return player;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x7a0c
// Size: 0x217
function getplayersinradius( origin, radius, desiredteam, excludeent )
{
    if ( radius <= 0 )
    {
        return [];
    }
    
    excludearray = undefined;
    
    if ( isdefined( excludeent ) )
    {
        if ( isarray( excludeent ) )
        {
            excludearray = excludeent;
        }
        else
        {
            excludearray = [ excludeent ];
        }
    }
    
    results = physics_querypoint( origin, radius, physics_createcontents( [ "physicscontents_characterproxy" ] ), excludearray, "physicsquery_all" );
    filteredresults = [];
    
    if ( !isdefined( desiredteam ) )
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            
            if ( isplayer( e ) )
            {
                filteredresults[ filteredresults.size ] = e;
            }
        }
    }
    else
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            
            if ( isplayer( e ) && isdefined( e.team ) && e.team == desiredteam )
            {
                filteredresults[ filteredresults.size ] = e;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_500c5c1476d28421", 0 ) > 0 )
        {
            debugduration = 60;
            sphere( origin, radius, ( 1, 1, 1 ), 0, debugduration );
            
            foreach ( player in filteredresults )
            {
                sphere( player.origin, 10, ( 1, 0, 0 ), 1, debugduration );
            }
        }
    #/
    
    return filteredresults;
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0x7c2c
// Size: 0x204
function getentitiesinradius( origin, radius, desiredteam, excludeent, physicscontents )
{
    if ( radius <= 0 )
    {
        return [];
    }
    
    excludearray = undefined;
    
    if ( isdefined( excludeent ) )
    {
        if ( isarray( excludeent ) )
        {
            excludearray = excludeent;
        }
        else
        {
            excludearray = [ excludeent ];
        }
    }
    
    results = physics_querypoint( origin, radius, physicscontents, excludearray, "physicsquery_all" );
    filteredresults = [];
    
    if ( !isdefined( desiredteam ) )
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            filteredresults[ filteredresults.size ] = e;
        }
    }
    else
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            
            if ( isdefined( e ) && isdefined( e.team ) && e.team == desiredteam )
            {
                filteredresults[ filteredresults.size ] = e;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_9bb67ce9f0ab24e0", 0 ) > 0 )
        {
            debugduration = 60;
            sphere( origin, radius, ( 1, 1, 1 ), 0, debugduration );
            
            foreach ( entity in filteredresults )
            {
                sphere( entity.origin, 10, ( 1, 0, 0 ), 1, debugduration );
            }
        }
    #/
    
    return filteredresults;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x7e39
// Size: 0x21
function _suicide()
{
    if ( !isusingremote() && !isdefined( self.fauxdead ) )
    {
        self suicide();
    }
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0x7e62
// Size: 0x4c
function player_lua_progressbar( player, var_7c8064d6e9390b55, range, omnvar_index, var_cd512ad17c99de9d, var_c3a973eafd37b75a )
{
    result = lua_progress_bar_think( player, var_7c8064d6e9390b55, range, omnvar_index, var_cd512ad17c99de9d, var_c3a973eafd37b75a );
    return result;
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0x7eb7
// Size: 0xcc
function lua_progress_bar_think( player, usetime, range, omnvar_index, var_cd512ad17c99de9d, var_c3a973eafd37b75a )
{
    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 1;
    self.usetime = usetime;
    player thread create_lua_progress_bar( self, omnvar_index );
    player.hasprogressbar = 1;
    result = lua_progress_bar_think_loop( player, self, range, var_cd512ad17c99de9d, var_c3a973eafd37b75a );
    assert( isdefined( result ) );
    
    if ( isalive( player ) )
    {
        player.hasprogressbar = 0;
    }
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    self.inuse = 0;
    self.curprogress = 0;
    return result;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x7f8c
// Size: 0xe3
function create_lua_progress_bar( object, omnvar_index )
{
    self endon( "disconnect" );
    function_1dbc717085326045( omnvar_index, undefined, undefined );
    lastrate = -1;
    
    while ( scripts\cp_mp\utility\player_utility::_isalive() && isdefined( object ) && object.inuse && !level.gameended )
    {
        if ( lastrate != object.userate )
        {
            if ( object.curprogress > object.usetime )
            {
                object.curprogress = object.usetime;
            }
        }
        
        lastrate = object.userate;
        function_1dbc717085326045( undefined, object.curprogress / object.usetime, undefined );
        wait 0.05;
    }
    
    wait 0.5;
    function_1dbc717085326045( 0, 0, undefined );
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0x8077
// Size: 0xff
function lua_progress_bar_think_loop( player, ent, dist_check, var_cd512ad17c99de9d, var_c3a973eafd37b75a )
{
    while ( !level.gameended && isdefined( self ) && player scripts\cp_mp\utility\player_utility::_isalive() && ( player usebuttonpressed() || isdefined( var_cd512ad17c99de9d ) || player attackbuttonpressed() && isdefined( var_c3a973eafd37b75a ) ) && should_continue_progress_bar_think( player ) )
    {
        wait 0.05;
        
        if ( isdefined( ent ) && isdefined( dist_check ) )
        {
            if ( distancesquared( player.origin, ent.origin ) > dist_check )
            {
                return 0;
            }
        }
        
        self.curprogress += 50 * self.userate;
        self.userate = 1;
        
        if ( self.curprogress >= self.usetime )
        {
            player function_1dbc717085326045( undefined, 1, undefined );
            return player scripts\cp_mp\utility\player_utility::_isalive();
        }
    }
    
    return 0;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x817f
// Size: 0x31
function should_continue_progress_bar_think( player )
{
    if ( isdefined( level.should_continue_progress_bar_think ) )
    {
        return [[ level.should_continue_progress_bar_think ]]( player );
    }
    
    return !scripts\cp\laststand::player_in_laststand( player );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x81b8
// Size: 0x11, Type: bool
function isplayingsolo()
{
    if ( getmaxclients() == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x81d2
// Size: 0x62
function removefromspawnedgrouparray()
{
    if ( isdefined( self.group_name ) )
    {
        if ( isdefined( level.spawned_group ) && isdefined( level.spawned_group[ self.group_name ] ) )
        {
            level.spawned_group[ self.group_name ] = array_remove( level.spawned_group[ self.group_name ], self );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x823c
// Size: 0xe5
function createtimer( font, fontscale )
{
    timerelem = newclienthudelem( self );
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.basefontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int( level.fontheight * fontscale );
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent( level.uiparent );
    timerelem.hidden = 0;
    return timerelem;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x832a
// Size: 0x44
function function_9a83883f756a4330( timeleft )
{
    if ( timeleft >= 4 )
    {
        return "match_start_tick_in5";
    }
    
    if ( timeleft == 3 )
    {
        return "match_start_tick_in3";
    }
    
    if ( timeleft == 2 )
    {
        return "match_start_tick_in2";
    }
    
    if ( timeleft == 1 )
    {
        return "match_start_tick_in1";
    }
    
    return "match_start_tick_in";
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8377
// Size: 0x54
function getclocksoundaliasfortimeleft( timeleft )
{
    if ( timeleft > 20 )
    {
        return "ui_mp_timer_countdown";
    }
    
    if ( timeleft > 10 )
    {
        return "ui_mp_timer_countdown_10";
    }
    
    if ( timeleft > 5 )
    {
        return "ui_mp_timer_countdown_half_sec";
    }
    
    if ( timeleft > 1.5 )
    {
        return "ui_mp_timer_countdown_quarter_sec";
    }
    
    return "ui_mp_timer_countdown_1";
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x83d3
// Size: 0x129
function getoverlordaliasfortimeleft( timeleft, var_323d131f19f161d0 )
{
    allow_random = 1;
    
    if ( isdefined( var_323d131f19f161d0 ) )
    {
        allow_random = var_323d131f19f161d0;
    }
    
    vo_ref = undefined;
    
    switch ( timeleft )
    {
        case 300:
            if ( istrue( allow_random ) && cointoss() )
            {
                vo_ref = "dx_cps_lass_timecheck_5min_10";
            }
            else
            {
                vo_ref = "dx_cps_kama_timecheck_5min_10";
            }
            
            break;
        case 120:
            if ( istrue( allow_random ) && cointoss() )
            {
                vo_ref = "dx_cps_lass_timecheck_2min_20";
            }
            else
            {
                vo_ref = "dx_cps_kama_timecheck_2min_20";
            }
            
            break;
        case 60:
            if ( istrue( allow_random ) && cointoss() )
            {
                vo_ref = "dx_cps_lass_timecheck_1min_30";
            }
            else
            {
                vo_ref = "dx_cps_kama_timecheck_1min_30";
            }
            
            break;
        case 30:
            if ( istrue( allow_random ) && cointoss() )
            {
                vo_ref = "dx_cps_lass_timecheck_30sec_40";
            }
            else
            {
                vo_ref = "dx_cps_kama_timecheck_30sec_40";
            }
            
            break;
        case 10:
            if ( istrue( allow_random ) && cointoss() )
            {
                vo_ref = "dx_cps_lass_timecheck_10sec_50";
            }
            else
            {
                vo_ref = "dx_cps_kama_timecheck_10sec_50";
            }
            
            break;
    }
    
    return vo_ref;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8505
// Size: 0x64
function _detachall( var_be69c03caa346d6c )
{
    if ( !istrue( var_be69c03caa346d6c ) )
    {
        self.headmodel = undefined;
    }
    
    if ( isdefined( self.riotshieldmodel ) )
    {
        riotshield_detach( 1 );
    }
    
    if ( isdefined( self.riotshieldmodelstowed ) )
    {
        riotshield_detach( 0 );
    }
    
    self.hasriotshieldequipped = 0;
    
    if ( !istrue( var_be69c03caa346d6c ) )
    {
        self detachall();
    }
    
    scripts\cp\equipment\nvg::clearnvg( istrue( var_be69c03caa346d6c ) );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8571
// Size: 0x66
function is_consumable_active( itemref )
{
    if ( isdefined( self.consumables ) && isdefined( self.consumables[ itemref ] ) && isdefined( self.consumables[ itemref ].on ) && self.consumables[ itemref ].on == 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x85df
// Size: 0x23
function notify_used_consumable( consumable )
{
    self notify( self.consumables[ consumable ].usednotify );
}

/#

    // Namespace utility / scripts\cp\utility
    // Params 5
    // Checksum 0x0, Offset: 0x860a
    // Size: 0x7a, Type: dev
    function drawline( start, end, timeslice, color, alpha )
    {
        drawtime = int( timeslice * 20 );
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        for ( time = 0; time < drawtime ; time++ )
        {
            line( start, end, color, alpha, 0, 1 );
            wait 0.05;
        }
    }

#/

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x868c
// Size: 0x5c
function is_upgrade_enabled( itemref )
{
    if ( !is_using_extinction_tokens() )
    {
        return 0;
    }
    
    /#
        if ( getdvarint( @"hash_70e2dc05ed6a91e7" ) )
        {
            return 1;
        }
        
        if ( getdvarint( @"hash_44f129297edfd910" ) )
        {
            return 0;
        }
    #/
    
    if ( self getplayerdata( "cp", "upgrades_enabled_flags", itemref ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x86f0
// Size: 0x123
function allow_player_teleport( bool, var_7b1cef9c76d8332 )
{
    if ( bool )
    {
        if ( !isdefined( self.teleportdisableflags ) && isdefined( var_7b1cef9c76d8332 ) )
        {
            foreach ( entry in self.teleportdisableflags )
            {
                if ( entry == var_7b1cef9c76d8332 )
                {
                    self.teleportdisableflags = array_remove( self.teleportdisableflags, var_7b1cef9c76d8332 );
                }
            }
        }
        
        self.disabledteleportation--;
        assert( self.disabledteleportation >= 0 );
        
        if ( !self.disabledteleportation )
        {
            self.teleportdisableflags = [];
            self.can_teleport = 1;
            self notify( "can_teleport" );
        }
        
        return;
    }
    
    if ( !isdefined( self.teleportdisableflags ) )
    {
        self.teleportdisableflags = [];
    }
    
    if ( isdefined( var_7b1cef9c76d8332 ) )
    {
        self.teleportdisableflags[ self.teleportdisableflags.size ] = var_7b1cef9c76d8332;
    }
    
    self.disabledteleportation++;
    self.can_teleport = 0;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x881b
// Size: 0xd, Type: bool
function areinteractionsenabled()
{
    return !istrue( self.interactions_disabled );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8831
// Size: 0x5b
function enable_infinite_ammo( bool )
{
    if ( bool )
    {
        self.infiniteammocounter++;
        self setclientomnvar( "zm_ui_unlimited_ammo", 1 );
        return;
    }
    
    if ( self.infiniteammocounter > 0 )
    {
        self.infiniteammocounter--;
    }
    
    if ( !self.infiniteammocounter )
    {
        self setclientomnvar( "zm_ui_unlimited_ammo", 0 );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x8894
// Size: 0x18b
function allow_player_basejumping( bool, str_id )
{
    debug_print = 1;
    
    if ( !isdefined( str_id ) )
    {
        str_id = "default";
    }
    
    var_35aba55687f16600 = bool;
    
    if ( isdefined( level.var_f4a07073ec587e25 ) )
    {
        var_35aba55687f16600 = level.var_f4a07073ec587e25;
        
        /#
            if ( debug_print && var_35aba55687f16600 != bool )
            {
                println( "<dev string:x55>" + var_35aba55687f16600 + "<dev string:x7d>" + str_id + "<dev string:x91>" + self getentitynumber() + "<dev string:xa6>" + self.name );
            }
        #/
    }
    
    scripts\common\values::set( str_id, "base_jumping", var_35aba55687f16600 );
    
    /#
        if ( debug_print )
        {
            println( "<dev string:xaf>" );
            println( "<dev string:xcd>" + bool + "<dev string:x7d>" + str_id + "<dev string:x91>" + self getentitynumber() + "<dev string:xa6>" + self.name );
            println( "<dev string:xfa>" );
            
            for ( i = 0; i < self.values[ "<dev string:x110>" ].size ; i++ )
            {
                values_struct = self.values[ "<dev string:x110>" ][ i ];
                println( "<dev string:x11d>" + values_struct.str_id );
                println( "<dev string:x129>" + values_struct.value );
            }
            
            println( "<dev string:x131>" + scripts\common\values::get( "<dev string:x110>" ) );
            println( "<dev string:xfa>" );
            println( "<dev string:xaf>" );
        }
    #/
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8a27
// Size: 0x85
function allow_player_minimapforcedisable( bool )
{
    if ( !isdefined( self.enabledminimapdisable ) )
    {
        self.enabledminimapdisable = 0;
    }
    
    if ( bool )
    {
        self.enabledminimapdisable++;
        hideminimap( 1 );
        return;
    }
    
    self.enabledminimapdisable--;
    assert( self.enabledminimapdisable >= 0 );
    
    if ( self.enabledminimapdisable < 0 )
    {
        self.enabledminimapdisable = 0;
    }
    
    if ( !self.enabledminimapdisable )
    {
        showminimap();
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x8ab4
// Size: 0x22, Type: bool
function is_minimap_forcedisabled()
{
    if ( isdefined( self.enabledminimapdisable ) && self.enabledminimapdisable > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8adf
// Size: 0x5b
function allow_player_ignore_me( bool )
{
    if ( bool )
    {
        self.enabledignoreme++;
        self.ignoreme = 1;
        return;
    }
    
    self.enabledignoreme--;
    assert( self.enabledignoreme >= 0 );
    
    if ( !self.enabledignoreme )
    {
        self.ignoreme = 0;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x8b42
// Size: 0xe, Type: bool
function isignoremeenabled()
{
    return self.enabledignoreme >= 1;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x8b59
// Size: 0x15
function force_usability_enabled()
{
    val::nuke( "usability" );
    self enableusability();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x8b76
// Size: 0x3, Type: bool
function is_using_extinction_tokens()
{
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8b9a
// Size: 0x12e
function coop_getweaponclass( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return "none";
    }
    
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return "none";
    }
    
    if ( isstring( weapon ) && weapon == "none" )
    {
        return "none";
    }
    
    basename = getbaseweaponname( weapon );
    weapon_class = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d( basename, #"group", "" );
    
    if ( weapon_class == "" && isdefined( level.game_mode_statstable ) )
    {
        if ( isdefined( weapon ) )
        {
            basename = getbaseweaponname( weapon );
            weapon_class = tablelookup( level.game_mode_statstable, 4, basename, 2 );
        }
    }
    
    if ( isenvironmentweapon( weapon ) )
    {
        weapon_class = "weapon_mg";
    }
    else if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        weapon_class = "other";
    }
    else if ( isstring( weapon ) && weapon == "none" )
    {
        weapon_class = "other";
    }
    else if ( weapon_class == "" )
    {
        weapon_class = "other";
    }
    
    assertex( weapon_class != "", "ERROR: invalid weapon class for weapon " + basename );
    return weapon_class;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x8cd1
// Size: 0xc, Type: bool
function is_holding_deployable()
{
    return istrue( self.is_holding_deployable );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x8ce6
// Size: 0xc, Type: bool
function has_special_weapon()
{
    return istrue( self.has_special_weapon );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x8cfb
// Size: 0x368
function getequipmenttype( weapon )
{
    switch ( weapon )
    {
        case #"hash_140bbbbf54acf7c":
        case #"hash_56ee829cc162271a":
        case #"hash_c3b4aaaa988e3e9":
        case #"hash_5cc52f4b3d579bc3":
        case #"hash_f124cf4b85d609e":
        case #"hash_10f6d40ba665cfae":
        case #"hash_171093dfc841e592":
        case #"hash_1e81e797b01fd3de":
        case #"hash_432644fc4753dde9":
        case #"hash_2ab98cab4066a74e":
        case #"hash_5d11ac1131cddab1":
        case #"hash_34c66d62f0d29ab0":
        case #"hash_5e8f81314553dd36":
        case #"hash_34f28162f0f54c6e":
        case #"hash_5e2ccea178b13002":
        case #"hash_5e7bbfa178ef8124":
        case #"hash_5e4ccaa178cac19c":
        case #"hash_435258fc47768fa7":
        case #"hash_4b87af60037f526f":
        case #"hash_4ba3c260039536a7":
        case #"hash_4c7de5619284e175":
        case #"hash_4cd748aa3895508a":
        case #"hash_4d63389017f81514":
        case #"hash_6a2e4f9c54756dc7":
        case #"hash_7990c79c9b8e6b7c":
        case #"hash_81b07c7e9a3e0da2":
        case #"hash_a8e4a914fb03a4d5":
        case #"hash_aa2662d15f62dc87":
        case #"hash_ab0871fa68122c89":
        case #"hash_ab3485fa6834de47":
        case #"hash_aea0b10eb1e7818d":
        case #"hash_aec3960eb2032d89":
        case #"hash_c46d19aa871781fa":
        case #"hash_c8a3c72298ab96e1":
        case #"hash_c9a436974fe60919":
        case #"hash_d9cbc629e947d1b7":
        case #"hash_dfcf8c30364ca2f1":
            etype = "lethal";
            break;
        case #"hash_d8f795eb14c75e6":
        case #"hash_7acdf2243af1f924":
        case #"hash_7ae0f6243b0109fa":
        case #"hash_2c18ea028ac4c18c":
        case #"hash_8d8f8ed9825eca03":
        case #"hash_954bb5f200a1b95a":
        case #"hash_9f73f49d822d9acc":
        case #"hash_a68c414683465b09":
        case #"hash_34e7a4cd11aed6bc":
        case #"hash_38d37e558866952c":
        case #"hash_3d494c645e6bff73":
        case #"hash_ab095aa74cae4e58":
        case #"hash_213721b87acc4369":
        case #"hash_ace5c7fdfe2ef2d7":
        case #"hash_5e1fa926a475190b":
        case #"hash_5e3fa526a48eaaa5":
        case #"hash_b6cf09a3066147fb":
        case #"hash_5e5b9bb1e397e30a":
        case #"hash_5f4edaea7e49dd41":
        case #"hash_681638acdd0de6ae":
        case #"hash_d072a0adddda0068":
        case #"hash_1e9770aa9293470":
        case #"hash_dd4d572af14a12c2":
        case #"hash_742fb0de85d5e4ef":
        case #"hash_e3575fdd14663ca9":
        case #"hash_e511a2cec8e5c83c":
        case #"hash_f085b57dce639767":
        case #"hash_f77e8ff44fc81aba":
        case #"hash_fcbac382525da1af":
        case #"hash_fcd6d682527385e7":
            etype = "tactical";
            break;
        default:
            etype = undefined;
            break;
    }
    
    return etype;
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0x906c
// Size: 0x76
function _launchgrenade( weaponname, origin, velocity, var_c301d652d9a73075, notthrown, var_997a34f6ab5cb7fc )
{
    grenade = self launchgrenade( weaponname, origin, velocity, var_c301d652d9a73075, var_997a34f6ab5cb7fc );
    
    if ( !isdefined( notthrown ) )
    {
        grenade.notthrown = 1;
    }
    else
    {
        grenade.notthrown = notthrown;
    }
    
    grenade setotherent( self );
    return grenade;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x90eb
// Size: 0x7e
function moveplayerperpendicularly( var_b1ed041d34e01127, angleoverride )
{
    if ( !isdefined( var_b1ed041d34e01127 ) )
    {
        var_b1ed041d34e01127 = 1200;
    }
    
    if ( isdefined( angleoverride ) )
    {
        var_df70f4e6d651bc52 = vectornormalize( angleoverride );
    }
    else
    {
        var_df70f4e6d651bc52 = anglestoforward( self.angles );
    }
    
    var_1ce8af601ec4d316 = vectorcross( ( 0, 0, 1 ), var_df70f4e6d651bc52 );
    var_435ed379095c43e8 = vectornormalize( var_1ce8af601ec4d316 );
    self knockback( var_435ed379095c43e8, var_b1ed041d34e01127 );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x9171
// Size: 0xed
function getweaponclass( weapon )
{
    basename = getbaseweaponname( weapon );
    
    if ( isdefined( basename ) && basename == "none" )
    {
        return "other";
    }
    
    class = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d( basename, #"group", "" );
    
    if ( class == "" )
    {
        weaponname = strip_suffix( basename, "_zm" );
        class = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d( weaponname, #"group", "" );
    }
    
    if ( isenvironmentweapon( basename ) )
    {
        class = "weapon_mg";
    }
    else if ( iskillstreakweapon( basename ) )
    {
        class = "killstreak";
    }
    else if ( issuperweapon( basename ) )
    {
        class = "super";
    }
    else if ( basename == "none" )
    {
        class = "other";
    }
    else if ( class == "" )
    {
        class = "other";
    }
    
    return class;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x9267
// Size: 0x55
function removedamagemodifier( id, additive )
{
    if ( !isdefined( additive ) )
    {
        additive = 1;
    }
    
    if ( additive )
    {
        if ( !isdefined( self.additivedamagemodifiers ) )
        {
            return;
        }
        
        self.additivedamagemodifiers[ id ] = undefined;
        return;
    }
    
    if ( !isdefined( self.multiplicativedamagemodifiers ) )
    {
        return;
    }
    
    self.multiplicativedamagemodifiers[ id ] = undefined;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x92c4
// Size: 0x73
function adddamagemodifier( id, modifier, additive )
{
    if ( !isdefined( additive ) )
    {
        additive = 1;
    }
    
    if ( additive )
    {
        if ( !isdefined( self.additivedamagemodifiers ) )
        {
            self.additivedamagemodifiers = [];
        }
        
        self.additivedamagemodifiers[ id ] = modifier;
        return;
    }
    
    if ( !isdefined( self.multiplicativedamagemodifiers ) )
    {
        self.multiplicativedamagemodifiers = [];
    }
    
    self.multiplicativedamagemodifiers[ id ] = modifier;
}

// Namespace utility / scripts\cp\utility
// Params 7
// Checksum 0x0, Offset: 0x933f
// Size: 0x113
function getdamagemodifiertotal( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    additivetotal = 1;
    
    if ( isdefined( self.additivedamagemodifiers ) )
    {
        foreach ( modifier in self.additivedamagemodifiers )
        {
            additivetotal += modifier - 1;
        }
    }
    
    var_1cbf01d0df82cde7 = 1;
    
    if ( isdefined( self.multiplicativedamagemodifiers ) )
    {
        foreach ( modifier in self.multiplicativedamagemodifiers )
        {
            var_1cbf01d0df82cde7 *= modifier;
        }
    }
    
    return additivetotal * var_1cbf01d0df82cde7;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x945b
// Size: 0x42
function isinventoryprimaryweapon( weapon )
{
    switch ( weaponinventorytype( weapon ) )
    {
        case #"hash_325cb2e66f67d5b9":
        case #"hash_aba97943e80de31f":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x94a5
// Size: 0x58, Type: bool
function has_tag( model, tag )
{
    if ( !isdefined( model ) )
    {
        return false;
    }
    
    partcount = getnumparts( model );
    
    for ( i = 0; i < partcount ; i++ )
    {
        if ( getpartname( model, i ) == tolower( tag ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x9506
// Size: 0x18c, Type: bool
function is_trap( ent, sweapon )
{
    if ( isdefined( sweapon ) && ( sweapon.basename == "iw7_beamtrap_zm" || sweapon.basename == "iw7_escapevelocity_zm" || sweapon.basename == "iw7_rockettrap_zm" || sweapon.basename == "iw7_discotrap_zm" || sweapon.basename == "iw7_chromosphere_zm" || sweapon.basename == "iw7_buffertrap_zm" || sweapon.basename == "iw7_electrictrap_zm" || sweapon.basename == "iw7_fantrap_zm" || sweapon.basename == "iw7_hydranttrap_zm" || sweapon.basename == "iw7_moshtrap_zm" ) )
    {
        return true;
    }
    
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( isdefined( ent.tesla_type ) )
    {
        return true;
    }
    
    if ( !isdefined( ent.script_noteworthy ) && !isdefined( ent.targetname ) )
    {
        return false;
    }
    
    if ( isdefined( ent.targetname ) && ( ent.targetname == "fence_generator" || ent.targetname == "puddle_generator" ) )
    {
        return true;
    }
    
    if ( isdefined( ent.script_noteworthy ) && ent.script_noteworthy == "fire_trap" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x969b
// Size: 0x6c, Type: bool
function istwohandedoffhand( grenade )
{
    if ( isdefined( grenade ) && grenade.basename != "none" )
    {
        if ( issuperweapon( grenade.basename ) )
        {
            return true;
        }
        
        equipmenttype = getequipmenttype( grenade.basename );
        
        if ( isdefined( equipmenttype ) && equipmenttype == "lethal" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x9710
// Size: 0x2a, Type: bool
function isaltmodeweapon( weapname )
{
    if ( !isdefined( weapname ) || weapname == "none" )
    {
        return false;
    }
    
    return weaponinventorytype( weapname ) == "altmode";
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x9743
// Size: 0x3c
function notifyafterframeend( waittillmsg, var_7239f8830ef22b43 )
{
    assertex( isdefined( waittillmsg ), "notifyAfterFrameEnd() was not given a notify to wait on" );
    assertex( isdefined( var_7239f8830ef22b43 ), "notifyAfterFrameEnd() was not given a notify to send" );
    self waittill( waittillmsg );
    waittillframeend();
    self notify( var_7239f8830ef22b43 );
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x9787
// Size: 0x11c, Type: bool
function isheadshot( weapon, shitloc, smeansofdeath, attacker )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            if ( attacker.code_classname == "script_vehicle" )
            {
                return false;
            }
            
            if ( attacker.code_classname == "misc_turret" )
            {
                return false;
            }
            
            if ( attacker.code_classname == "script_model" )
            {
                return false;
            }
        }
        
        if ( isdefined( attacker.agent_type ) )
        {
            if ( attacker.agent_type == "dog" || attacker.agent_type == "alien" )
            {
                return false;
            }
        }
    }
    
    return ( shitloc == "head" || shitloc == "helmet" || shitloc == "neck" ) && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_SCARAB" && smeansofdeath != "MOD_CRUSH" && smeansofdeath != "MOD_HEAD_SHOT" && !isenvironmentweapon( weapon.basename );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x98ac
// Size: 0x61
function getotherteam( team )
{
    if ( level.multiteambased )
    {
        assertmsg( "getOtherTeam() should not be called in Multi Team Based gametypes" );
    }
    
    if ( team == "allies" )
    {
        return "axis";
    }
    else if ( team == "axis" )
    {
        return "allies";
    }
    else
    {
        return "none";
    }
    
    assertmsg( "getOtherTeam: invalid team " + team );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x9915
// Size: 0x72
function riotshield_hasweapon()
{
    result = 0;
    weaponlist = self getweaponslistprimaries();
    
    foreach ( weapon in weaponlist )
    {
        if ( isriotshield( weapon ) )
        {
            result = 1;
            break;
        }
    }
    
    return result;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x9990
// Size: 0xb9
function riotshield_attach( onarm, modelshield )
{
    tagattach = undefined;
    
    if ( onarm )
    {
        assertex( !isdefined( self.riotshieldmodel ), "riotShield_attach() called on player with no riot shield model on the arm" );
        self.riotshieldmodel = modelshield;
        tagattach = "j_shield_ri";
    }
    else
    {
        assertex( !isdefined( self.riotshieldmodelstowed ), "riotShield_attach() called on player with no riot shield model stowed" );
        self.riotshieldmodelstowed = modelshield;
        tagattach = "tag_shield_back";
    }
    
    if ( !isdefined( self.current_shield_tagattach ) || self.current_shield_tagattach != tagattach )
    {
        self.current_shield_tagattach = tagattach;
        self attachshieldmodel( modelshield, tagattach );
    }
    
    self.hasriotshield = riotshield_hasweapon();
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x9a51
// Size: 0xd7
function riotshield_detach( onarm )
{
    modelshield = undefined;
    tagdetach = undefined;
    
    if ( onarm )
    {
        assertex( isdefined( self.riotshieldmodel ), "riotShield_detach() called on player with no riot shield model on arm" );
        modelshield = self.riotshieldmodel;
        tagdetach = "j_shield_ri";
    }
    else
    {
        assertex( isdefined( self.riotshieldmodelstowed ), "riotShield_detach() called on player with no riot shield model stowed" );
        modelshield = self.riotshieldmodelstowed;
        tagdetach = "tag_shield_back";
    }
    
    if ( isdefined( self.current_shield_tagattach ) && self.current_shield_tagattach == tagdetach )
    {
        self.current_shield_tagattach = undefined;
        self detachshieldmodel( modelshield, tagdetach );
    }
    
    if ( onarm )
    {
        self.riotshieldmodel = undefined;
    }
    else
    {
        self.riotshieldmodelstowed = undefined;
    }
    
    self.hasriotshield = riotshield_hasweapon();
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x9b30
// Size: 0x47
function launchshield( damage, meansofdeath )
{
    if ( riotshield_hasweapon() )
    {
        if ( isdefined( self.riotshieldmodel ) )
        {
            riotshield_detach( 1 );
        }
        
        if ( isdefined( self.riotshieldmodelstowed ) )
        {
            riotshield_detach( 0 );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x9b7f
// Size: 0xf8
function riotshield_move( var_9a9844b3a758c1c9 )
{
    tagstart = undefined;
    tagend = undefined;
    modelshield = undefined;
    
    if ( var_9a9844b3a758c1c9 )
    {
        assertex( isdefined( self.riotshieldmodel ), "riotShield_move() called on player with no riot shield model on arm" );
        modelshield = self.riotshieldmodel;
        tagstart = "j_shield_ri";
        tagend = "tag_shield_back";
    }
    else
    {
        assertex( isdefined( self.riotshieldmodelstowed ), "riotShield_move() called on player with no riot shield model stowed" );
        modelshield = self.riotshieldmodelstowed;
        tagstart = "tag_shield_back";
        tagend = "j_shield_ri";
    }
    
    if ( !isdefined( self.current_shield_tagattach ) || self.current_shield_tagattach != tagend )
    {
        self.current_shield_tagattach = tagend;
        self moveshieldmodel( modelshield, tagstart, tagend );
    }
    
    if ( var_9a9844b3a758c1c9 )
    {
        self.riotshieldmodelstowed = modelshield;
        self.riotshieldmodel = undefined;
        return;
    }
    
    self.riotshieldmodel = modelshield;
    self.riotshieldmodelstowed = undefined;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x9c7f
// Size: 0x33
function remove_crafting_item()
{
    self setclientomnvar( "zombie_souvenir_piece_index", 0 );
    
    if ( isdefined( level.crafting_remove_func ) )
    {
        self [[ level.crafting_remove_func ]]();
    }
    
    self.current_crafting_struct = undefined;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x9cba
// Size: 0x334
function store_weapons_status( weapons_excluded, var_59d694577d32fb2b )
{
    self.copy_fullweaponlist = self getweaponslistall();
    self.copy_weapon_current = get_current_weapon( self, var_59d694577d32fb2b );
    self.copy_weapon_level = [];
    self.var_bfebcd1c49c31e8 = scripts\cp_mp\armor::function_600f6cf462e983f();
    var_39c57fef72629573 = [];
    
    foreach ( weapon in self.copy_fullweaponlist )
    {
        if ( weapon.isalternate )
        {
            continue;
        }
        
        if ( issubstr( weapon.basename, "iw8_execution_" ) )
        {
            continue;
        }
        
        var_39c57fef72629573[ var_39c57fef72629573.size ] = weapon;
    }
    
    self.copy_fullweaponlist = var_39c57fef72629573;
    
    foreach ( weapon in self.copy_fullweaponlist )
    {
        weaponname = getcompleteweaponname( weapon );
        self.copy_weapon_ammo_clip[ weaponname ] = self getweaponammoclip( weapon );
        self.copy_weapon_ammo_stock[ weaponname ] = self getweaponammostock( weapon );
        
        if ( issubstr( weapon.basename, "akimbo" ) )
        {
            self.copy_weapon_ammo_clip_left[ weaponname ] = self getweaponammoclip( weapon, "left" );
        }
        
        var_7b358dc23d8ce9e2 = getrawbaseweaponname( weapon );
        
        if ( isdefined( self.pap[ var_7b358dc23d8ce9e2 ] ) )
        {
            self.copy_weapon_level[ weaponname ] = self.pap[ var_7b358dc23d8ce9e2 ].lvl;
        }
    }
    
    if ( isdefined( weapons_excluded ) )
    {
        var_6c93abb5fc1f28a5 = [];
        
        foreach ( weapon in self.copy_fullweaponlist )
        {
            if ( getsubstr( weapon.basename, 0, weapon.basename.size ) == "fists" )
            {
                continue;
            }
            
            skip = 0;
            
            foreach ( var_9f442cb94079a336 in weapons_excluded )
            {
                if ( weapon == var_9f442cb94079a336 )
                {
                    skip = 1;
                    break;
                }
                
                if ( weapon getbaseweapon() == var_9f442cb94079a336 )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
            
            var_6c93abb5fc1f28a5[ var_6c93abb5fc1f28a5.size ] = weapon;
        }
        
        self.copy_fullweaponlist = var_6c93abb5fc1f28a5;
        
        foreach ( var_9f442cb94079a336 in weapons_excluded )
        {
            if ( self.copy_weapon_current == var_9f442cb94079a336 )
            {
                self.copy_weapon_current = nullweapon();
                break;
            }
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x9ff6
// Size: 0x40
function get_current_weapon( player, var_59d694577d32fb2b )
{
    current_weapon = player getcurrentweapon();
    
    if ( istrue( var_59d694577d32fb2b ) && is_melee_weapon( current_weapon ) )
    {
        current_weapon = player getweaponslistall()[ 1 ];
    }
    
    return current_weapon;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xa03f
// Size: 0x22a
function is_melee_weapon( current_weapon, var_deb079b105708d8b )
{
    weaponname = undefined;
    
    if ( isweapon( current_weapon ) )
    {
        weaponname = current_weapon.basename;
    }
    else
    {
        weaponname = current_weapon;
    }
    
    switch ( weaponname )
    {
        case #"hash_2396bc6d1a22783":
        case #"hash_1bb91ccaf3bf4184":
        case #"hash_bb024e3ef3a476a7":
        case #"hash_c5adc7b161730982":
        case #"hash_c71ae67d2f228cbb":
        case #"hash_38ac5d4b3d84dc13":
        case #"hash_48a8cea1541881c7":
        case #"hash_cd80a1a74f587143":
        case #"hash_54e9330b3e4bafd8":
        case #"hash_551a2e001f0bb100":
        case #"hash_5765aa4127477ab0":
        case #"hash_6128ffb13a2ad385":
        case #"hash_68b43625ba690a46":
        case #"hash_d58ad5efb94d9cc5":
        case #"hash_78dcee34a13df221":
        case #"hash_7a8106254e175ceb":
        case #"hash_dd54e4fbdab4676f":
        case #"hash_8877a34da86c3cc1":
        case #"hash_f9003e513c7031a0":
        case #"hash_9b792fbc6b54db2c":
        case #"hash_9b8342565e3d332d":
        case #"hash_ada294dab1042d9f":
        case #"hash_b17ee6da8aec958c":
            return 1;
        case #"hash_1ca1d70b20751cab":
        case #"hash_2036ffe5fe7fd5af":
        case #"hash_34623f1036fbf64f":
        case #"hash_5439f345fff2676f":
        case #"hash_70f0f6699279e051":
        case #"hash_7ea6afbd585e8662":
        case #"hash_9b177b0f2613be5a":
        case #"hash_dc6d4736701cdfcd":
        case #"hash_dd3bc602b43ab26b":
        case #"hash_d071e9fae38abd9b":
        case #"hash_dfffaa9e20593e18":
        case #"hash_dfffad9e205942d1":
        case #"hash_e67c0dc995238238":
        case #"hash_e67c10c9952386f1":
        case #"hash_dc6d4436701cdb14":
            if ( istrue( var_deb079b105708d8b ) )
            {
                return 0;
            }
            else
            {
                return 1;
            }
        default:
            return 0;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xa271
// Size: 0xac, Type: bool
function is_primary_melee_weapon( weapon )
{
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    switch ( weaponname )
    {
        case #"hash_2036ffe5fe7fd5af":
        case #"hash_34623f1036fbf64f":
        case #"hash_d071e9fae38abd9b":
        case #"hash_dc6d4436701cdb14":
        case #"hash_dc6d4736701cdfcd":
        case #"hash_dfffaa9e20593e18":
        case #"hash_dfffad9e205942d1":
        case #"hash_e67c0dc995238238":
        case #"hash_e67c10c9952386f1":
            return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xa326
// Size: 0x3d7
function restore_weapons_status( inclusion_list )
{
    if ( !isdefined( self.copy_fullweaponlist ) || !isdefined( self.copy_weapon_current ) || !isdefined( self.copy_weapon_ammo_clip ) || !isdefined( self.copy_weapon_ammo_stock ) )
    {
        return;
    }
    
    myweapons = self getweaponslistall();
    
    foreach ( weapon in myweapons )
    {
        if ( !array_contains( self.copy_fullweaponlist, weapon ) && !in_inclusion_list( inclusion_list, weapon ) )
        {
            self takeweapon( weapon );
        }
    }
    
    if ( istrue( self.hasparachute ) )
    {
        allow_player_basejumping( 1, "restore_weapons_status" );
        self skydive_cutparachuteon();
        self setclientomnvar( "ui_parachuteicon", 1 );
    }
    
    if ( isdefined( self.riotshield_return ) )
    {
        if ( !array_contains( self.copy_fullweaponlist, self.riotshield_return ) )
        {
            self.copy_fullweaponlist[ self.copy_fullweaponlist.size ] = self.riotshield_return;
        }
        
        self.riotshield_return = undefined;
    }
    
    foreach ( weapon in self.copy_fullweaponlist )
    {
        if ( !self hasweapon( weapon ) )
        {
            scripts\cp_mp\utility\inventory_utility::_giveweapon( weapon, -1, 0, 1 );
        }
        
        weaponname = getcompleteweaponname( weapon );
        
        if ( isdefined( self.powerprimarygrenade ) && self.powerprimarygrenade == weaponname )
        {
            self assignweaponoffhandprimary( weapon );
        }
        
        if ( isdefined( self.powersecondarygrenade ) && self.powersecondarygrenade == weaponname )
        {
            self assignweaponoffhandsecondary( weapon );
        }
        
        if ( isdefined( self.specialoffhandgrenade ) && self.specialoffhandgrenade == weaponname )
        {
            self assignweaponoffhandspecial( weapon );
        }
        
        if ( isdefined( self.copy_weapon_ammo_clip[ weaponname ] ) )
        {
            self setweaponammoclip( weapon, self.copy_weapon_ammo_clip[ weaponname ] );
        }
        
        if ( isdefined( self.copy_weapon_ammo_clip_left ) )
        {
            if ( isdefined( self.copy_weapon_ammo_clip_left[ weaponname ] ) )
            {
                self setweaponammoclip( weapon, self.copy_weapon_ammo_clip_left[ weaponname ], "left" );
            }
        }
        
        if ( isdefined( self.copy_weapon_ammo_stock[ weaponname ] ) )
        {
            self setweaponammostock( weapon, self.copy_weapon_ammo_stock[ weaponname ] );
        }
        
        if ( isdefined( self.copy_weapon_level[ weaponname ] ) )
        {
            struct = spawnstruct();
            struct.lvl = self.copy_weapon_level[ weaponname ];
            self.pap[ getrawbaseweaponname( weapon ) ] = struct;
        }
    }
    
    weapontoswitch = self.copy_weapon_current;
    
    if ( isundefinedweapon( weapontoswitch ) )
    {
        foreach ( item in self.copy_fullweaponlist )
        {
            if ( isbulletweapon( item ) )
            {
                weapontoswitch = item;
                break;
            }
        }
    }
    
    scripts\cp\loadout::function_a01818ae9edecbe6( 1 );
    scripts\cp\loadout::function_a6eb74f88574f882();
    
    if ( val::get( "weapon_switch" ) )
    {
        self switchtoweaponimmediate( weapontoswitch );
    }
    
    if ( !istrue( self.bspawningviaac130 ) )
    {
        self.copy_fullweaponlist = undefined;
        self.copy_weapon_current = undefined;
        self.copy_weapon_ammo_clip = undefined;
        self.copy_weapon_ammo_stock = undefined;
        self.copy_weapon_ammo_clip_left = undefined;
    }
    
    if ( isdefined( level.arcade_last_stand_power_func ) )
    {
        self [[ level.arcade_last_stand_power_func ]]();
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xa705
// Size: 0x23e
function restore_primary_weapons_only( inclusion_list )
{
    if ( !isdefined( self.copy_fullweaponlist ) || !isdefined( self.copy_weapon_current ) || !isdefined( self.copy_weapon_ammo_clip ) || !isdefined( self.copy_weapon_ammo_stock ) )
    {
        assertmsg( "Call store_weapons_status() before restore_weapons_status()" );
    }
    
    self.primary_weapons = [];
    i = 0;
    
    foreach ( weapon in self.copy_fullweaponlist )
    {
        if ( isinventoryprimaryweapon( weapon ) )
        {
            self.primary_weapons[ i ] = weapon;
            i += 1;
        }
    }
    
    count = 0;
    
    foreach ( weapon in self.primary_weapons )
    {
        if ( count < 3 )
        {
            if ( weapon.isalternate )
            {
                continue;
            }
            
            if ( !self hasweapon( weapon ) )
            {
                self giveweapon( weapon, -1, 0, -1, 1 );
            }
            
            weaponname = getcompleteweaponname( weapon );
            self setweaponammoclip( weapon, self.copy_weapon_ammo_clip[ weaponname ] );
            self setweaponammostock( weapon, self.copy_weapon_ammo_stock[ weaponname ] );
            
            if ( isdefined( self.copy_weapon_level[ weaponname ] ) )
            {
                struct = spawnstruct();
                struct.lvl = self.copy_weapon_level[ weaponname ];
                self.pap[ getrawbaseweaponname( weapon ) ] = struct;
            }
            
            count++;
        }
    }
    
    weapontoswitch = self.copy_weapon_current;
    
    if ( !isdefined( weapontoswitch ) || !self hasweapon( weapontoswitch ) || isnullweapon( weapontoswitch ) )
    {
        weapontoswitch = getweapontoswitchbackto();
    }
    
    self switchtoweaponimmediate( weapontoswitch );
    self.copy_fullweaponlist = undefined;
    self.copy_weapon_current = undefined;
    self.copy_weapon_ammo_clip = undefined;
    self.copy_weapon_ammo_stock = undefined;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xa94b
// Size: 0x22
function in_inclusion_list( inclusion_list, item_name )
{
    if ( !isdefined( inclusion_list ) )
    {
        return 0;
    }
    
    return array_contains( inclusion_list, item_name );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xa976
// Size: 0x25
function vec_multiply( vector, number )
{
    return ( vector[ 0 ] * number, vector[ 1 ] * number, vector[ 2 ] * number );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xa9a4
// Size: 0x43
function restore_super_weapon()
{
    self giveweapon( "super_default_zm" );
    self assignweaponoffhandspecial( "super_default_zm" );
    self.specialoffhandgrenade = "super_default_zm";
    
    if ( istrue( self.consumable_meter_full ) )
    {
        self setweaponammoclip( "super_default_zm", 1 );
    }
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xa9ef
// Size: 0x9f
function getcloseststruct( org, noteworthy, maxdist )
{
    assertex( isdefined( org ), " PLEASE DEFINE THE ORIGIN " );
    assertex( isdefined( noteworthy ), " PLEASE DEFINE THE NOTEWORTHY TO CHECK STRUCTS FOR " );
    assertex( noteworthy != "", " Noteworthy needs a value other than 2 closed quotes!! " );
    var_b63085de741c1a2f = getstructarray( noteworthy, "script_noteworthy" );
    var_1ec880ddc2010338 = sortbydistance( var_b63085de741c1a2f, org )[ 0 ];
    
    if ( isdefined( maxdist ) && distancesquared( org, var_1ec880ddc2010338.origin ) > squared( maxdist ) )
    {
        return undefined;
    }
    
    return var_1ec880ddc2010338;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xaa97
// Size: 0xb7
function getfarthest( org, array, maxdist )
{
    if ( !isdefined( maxdist ) )
    {
        maxdist = 500000;
    }
    
    dist = 0;
    ent = undefined;
    
    foreach ( item in array )
    {
        newdist = distance( item.origin, org );
        
        if ( newdist <= dist || newdist >= maxdist )
        {
            continue;
        }
        
        dist = newdist;
        ent = item;
    }
    
    return ent;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xab57
// Size: 0x7d
function get_average_origin( array )
{
    origin = ( 0, 0, 0 );
    
    foreach ( member in array )
    {
        origin += member.origin;
    }
    
    return origin * 1 / array.size;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xabdd
// Size: 0x3c, Type: bool
function is_zombie_agent()
{
    return isagent( self ) && isdefined( self.species ) && ( self.species == "humanoid" || self.species == "zombie" );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xac22
// Size: 0x29, Type: bool
function is_soldier_agent()
{
    return isagent( self ) && isdefined( self.species ) && self.species == "human";
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xac54
// Size: 0x40
function make_entity_sentient_cp( team, expendable, var_f64560838fe13c2d )
{
    if ( !isdefined( expendable ) )
    {
        expendable = 1;
    }
    
    if ( expendable )
    {
        return self makeentitysentient( team, 1, var_f64560838fe13c2d );
    }
    
    return self makeentitysentient( team, 0, var_f64560838fe13c2d );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xac9c
// Size: 0x4b
function get_attacker_as_player( eattacker )
{
    if ( isdefined( eattacker ) )
    {
        if ( isplayer( eattacker ) )
        {
            return eattacker;
        }
        
        if ( isdefined( eattacker.owner ) && isplayer( eattacker.owner ) )
        {
            return eattacker.owner;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xacf0
// Size: 0xc8
function getavailableattachments( weaponname, var_2fbd0e943f095064, var_1f822f090ffd1b10 )
{
    if ( !isdefined( var_1f822f090ffd1b10 ) )
    {
        var_1f822f090ffd1b10 = 1;
    }
    
    attachments = getweaponattachmentarrayfromstats( weaponname );
    attachmentlist = [];
    
    foreach ( attachment in attachments )
    {
        attachmenttype = getattachmenttype( attachment );
        
        if ( !var_1f822f090ffd1b10 && attachmenttype == "rail" )
        {
            continue;
        }
        
        if ( isdefined( var_2fbd0e943f095064 ) && listhasattachment( var_2fbd0e943f095064, attachment ) )
        {
            continue;
        }
        
        attachmentlist[ attachmentlist.size ] = attachment;
    }
    
    return attachmentlist;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xadc1
// Size: 0x5e, Type: bool
function listhasattachment( attachments, attachment )
{
    foreach ( attachmentcheck in attachments )
    {
        if ( attachmentcheck == attachment )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xae28
// Size: 0xb0
function getweaponattachmentarrayfromstats( weapon )
{
    weaponname = getweaponrootname( weapon );
    
    if ( !isdefined( level.weaponattachments ) )
    {
        level.weaponattachments = [];
    }
    
    if ( !isdefined( level.weaponattachments[ weaponname ] ) )
    {
        attachments = [];
        
        for ( i = 0; i < 10 ; i++ )
        {
            attachment = tablelookup( scripts\cp_mp\weapon::getweapontable(), 4, weaponname, 10 + i );
            
            if ( attachment == "" )
            {
                break;
            }
            
            attachments[ attachments.size ] = attachment;
        }
        
        level.weaponattachments[ weaponname ] = attachments;
    }
    
    return level.weaponattachments[ weaponname ];
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xaee1
// Size: 0xd
function getweaponpaintjobid( loadoutweapon )
{
    return -1;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xaef7
// Size: 0x10
function getweaponcamo( loadoutweapon )
{
    return "none";
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xaf10
// Size: 0x10
function getweaponcosmeticattachment( loadoutweapon )
{
    return "none";
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xaf29
// Size: 0x10
function getweaponreticle( loadoutweapon )
{
    return "none";
}

// Namespace utility / scripts\cp\utility
// Params 9
// Checksum 0x0, Offset: 0xaf42
// Size: 0x24c
function mpbuildweaponname( rootname, attachments, camo, reticle, variantid, var_d1fd16429ab57618, var_fd85da04b063943, paintjobid, cosmeticattachment )
{
    assertex( isarray( attachments ), "buildWeaponName() passed invalid attachment array." );
    attachdefaults = weaponattachdefaultmap( rootname );
    weaponname = weaponassetnamemap( rootname, variantid );
    weapclass = coop_getweaponclass( weaponname );
    
    if ( isdefined( attachdefaults ) )
    {
        attachments = array_combine_unique( attachments, attachdefaults );
    }
    
    attachments = scripts\cp_mp\weapon::weaponattachremoveextraattachments( attachments );
    
    for ( var_dc470e9f96950ccf = 0; var_dc470e9f96950ccf < attachments.size ; var_dc470e9f96950ccf++ )
    {
        attachments[ var_dc470e9f96950ccf ] = attachments[ var_dc470e9f96950ccf ];
    }
    
    if ( isdefined( attachdefaults ) )
    {
        for ( var_dc470e9f96950ccf = 0; var_dc470e9f96950ccf < attachdefaults.size ; var_dc470e9f96950ccf++ )
        {
            attachdefaults[ var_dc470e9f96950ccf ] = attachdefaults[ var_dc470e9f96950ccf ];
        }
    }
    
    if ( isdefined( attachdefaults ) )
    {
        attachments = array_combine_unique( attachments, attachdefaults );
    }
    
    attachments = array_remove( attachments, "none" );
    
    if ( isdefined( cosmeticattachment ) && cosmeticattachment != "none" )
    {
        attachments[ attachments.size ] = cosmeticattachment;
    }
    
    if ( attachments.size > 0 )
    {
        attachments = filterattachments( attachments );
    }
    
    attachmentsextra = [];
    
    foreach ( a in attachments )
    {
        extra = attachmentmap_toextra( a );
        
        if ( isdefined( extra ) )
        {
            attachmentsextra[ attachmentsextra.size ] = extra;
        }
    }
    
    if ( attachmentsextra.size > 0 )
    {
        attachments = array_combine_unique( attachments, attachmentsextra );
    }
    
    if ( attachments.size > 0 )
    {
        attachments = alphabetize( attachments );
    }
    
    assertex( attachments.size <= 12, "buildWeaponName() ended up with over 12 attachments after mods and defaults were added." );
    weaponname = reassign_weapon_name( weaponname, attachments );
    
    foreach ( attachment in attachments )
    {
        weaponname += "+" + attachment;
    }
    
    return weaponname;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xb197
// Size: 0x38
function reassign_weapon_name( weaponname, attachments )
{
    if ( isdefined( level.weapon_upgrade_path ) && isdefined( level.weapon_upgrade_path[ getweaponbasename( weaponname ) ] ) )
    {
        return weaponname;
    }
    
    return weaponname;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xb1d8
// Size: 0x64
function get_weapon_variant_id( player, weapon )
{
    base_weapon = getbaseweaponname( weapon );
    
    /#
        if ( getdvar( @"hash_6b0fa0b0eb9d7504", "<dev string:x144>" ) != "<dev string:x144>" )
        {
            if ( weaponhasvariants( base_weapon ) )
            {
                return int( getdvar( @"hash_6b0fa0b0eb9d7504" ) );
            }
        }
    #/
    
    return -1;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xb245
// Size: 0x60
function weaponhasvariants( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    switch ( weapon )
    {
        case #"hash_5a5a262f216cdcef":
            return 0;
        default:
            return 1;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xb2ad
// Size: 0x63
function weaponattachdefaultmap( weaponname )
{
    assertex( isdefined( level.weaponmapdata ), "weaponAttachDefaultMap() called without first calling buildWeaponMap()." );
    
    if ( isdefined( level.weaponmapdata[ weaponname ] ) && isdefined( level.weaponmapdata[ weaponname ].attachdefaults ) )
    {
        return level.weaponmapdata[ weaponname ].attachdefaults;
    }
    
    return undefined;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xb319
// Size: 0x9b
function getweaponvariantattachments( weaponname, variantid )
{
    attachments = [];
    passives = getweaponpassives( weaponname, variantid );
    
    if ( isdefined( passives ) )
    {
        foreach ( passive in passives )
        {
            passiveattachment = getpassiveattachment( passive );
            
            if ( !isdefined( passiveattachment ) )
            {
                continue;
            }
            
            attachments[ attachments.size ] = passiveattachment;
        }
    }
    
    return attachments;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xb3bd
// Size: 0x40
function getpassiveattachment( passive )
{
    struct = getpassivestruct( passive );
    
    if ( !isdefined( struct ) || !isdefined( struct.attachmentref ) )
    {
        return undefined;
    }
    
    return struct.attachmentref;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xb406
// Size: 0x1b
function getweaponpassives( weaponname, variantid )
{
    return getpassivesforweapon( weaponname, variantid );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xb42a
// Size: 0x38
function getpassivesforweapon( weaponbasename, variantid )
{
    lootinfo = getlootinfoforweapon( weaponbasename, variantid );
    
    if ( isdefined( lootinfo ) )
    {
        return lootinfo.passives;
    }
    
    return undefined;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xb46b
// Size: 0x67
function getlootinfoforweapon( weaponbasename, variantid )
{
    if ( !isdefined( variantid ) )
    {
        return undefined;
    }
    
    if ( isdefined( level.lootweaponcache[ weaponbasename ] ) && isdefined( level.lootweaponcache[ weaponbasename ][ variantid ] ) )
    {
        weaponinfo = level.lootweaponcache[ weaponbasename ][ variantid ];
        return weaponinfo;
    }
    
    weaponinfo = cachelootweaponweaponinfo( weaponbasename, variantid );
    
    if ( isdefined( weaponinfo ) )
    {
        return weaponinfo;
    }
    
    return undefined;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xb4db
// Size: 0x5e
function getdefaultweaponbasename( basename )
{
    rootname = getweaponrootname( basename );
    
    if ( isdefined( level.weaponmapdata[ rootname ] ) && isdefined( level.weaponmapdata[ rootname ].assetname ) )
    {
        basename = level.weaponmapdata[ rootname ].assetname;
    }
    
    return basename;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xb542
// Size: 0x64
function cachelootweaponweaponinfo( weaponbasename, variantid )
{
    if ( !isdefined( level.lootweaponcache[ weaponbasename ] ) )
    {
        level.lootweaponcache[ weaponbasename ] = [];
    }
    
    var_c6c779c138e8c65 = getweaponloottable( weaponbasename );
    weaponinfo = readweaponinfofromtable( var_c6c779c138e8c65, variantid, weaponbasename );
    level.lootweaponcache[ weaponbasename ][ variantid ] = weaponinfo;
    return weaponinfo;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xb5af
// Size: 0x8d
function readweaponinfofromtable( tablepath, variantid, weaponbasename )
{
    struct = spawnstruct();
    weaponroot = scripts\cp_mp\weapon::getweaponrootname( weaponbasename );
    ref = weaponroot + "|" + variantid;
    struct.ref = ref;
    struct.weaponasset = level.weaponlootmapdata[ ref ].assetname;
    struct.variantid = variantid;
    return struct;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xb645
// Size: 0x66
function create_fake_loot_model_from_struct( struct )
{
    pickup_mdl = spawn( "script_model", struct.origin );
    pickup_mdl setmodel( "container_ammo_box_01_nophysics" );
    pickup_mdl.angles = struct.angles;
    pickup_mdl.targetname = struct.targetname;
    return pickup_mdl;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xb6b4
// Size: 0x205
function create_fake_loot( types_array )
{
    if ( istrue( self.available ) )
    {
        return;
    }
    
    if ( istrue( level.disable_map_munitions ) )
    {
        return;
    }
    
    self show();
    self.available = 1;
    types = undefined;
    
    if ( isdefined( types_array ) )
    {
        if ( isstring( types_array ) )
        {
            types = [ types_array ];
        }
        else
        {
            types = types_array;
        }
    }
    else if ( istrue( level.disable_map_ammo_munitions ) )
    {
        types = [ "brloot_munition_grenade_crate", "brloot_munition_armor" ];
    }
    else
    {
        types = [ "brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor" ];
    }
    
    self.loot_type = random( types );
    var_c103bfc366a53063 = &"COOP_CRAFTING/AMMO_CRATE";
    
    switch ( self.loot_type )
    {
        case #"hash_6f357c9b54983f74":
            var_c103bfc366a53063 = &"CP_BR/GRENADE_CRATE";
            break;
        case #"hash_2acff0a11c9a418d":
            var_c103bfc366a53063 = &"CP_BR/ARMOR_CRATE";
            break;
        case #"hash_5d26bb4adb504f25":
            var_c103bfc366a53063 = &"EQUIPMENT/TACTICAL_COVER";
            break;
    }
    
    self setmodel( "offhand_wm_supportbox_killstreak" );
    self.origin += ( 0, 0, 16 );
    
    if ( self tagexists( "tag_use" ) )
    {
        sethintobject( "tag_use", "HINT_BUTTON", undefined, var_c103bfc366a53063, 25, "duration_none", "show", 128, 80, 128, 80 );
    }
    else
    {
        sethintobject( undefined, "HINT_BUTTON", undefined, var_c103bfc366a53063, 25, "duration_none", "show", 128, 80, 128, 80 );
    }
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !player is_valid_player() )
        {
            continue;
        }
        
        if ( !scripts\cp\loot_system::give_munition( self.loot_type, player ) )
        {
            continue;
        }
        
        self playsoundtoplayer( "scavenger_pack_pickup", player );
        self makeunusable();
        self hide();
        self.available = 0;
        return;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xb8c1
// Size: 0x137
function filterattachments( attachments )
{
    filtered = [];
    
    if ( isdefined( attachments ) )
    {
        for ( var_4830f0ab7107d9b = 0; var_4830f0ab7107d9b < attachments.size ; var_4830f0ab7107d9b++ )
        {
            attachment = attachments[ var_4830f0ab7107d9b ];
            
            if ( attachment == "none" )
            {
                continue;
            }
            
            add = 1;
            
            for ( filteredindex = 0; filteredindex < filtered.size ; filteredindex++ )
            {
                if ( attachment == filtered[ filteredindex ] )
                {
                    add = 0;
                    break;
                }
                
                conflictstring = scripts\cp_mp\weapon::attachmentsconflict( attachment, filtered[ filteredindex ] );
                
                if ( conflictstring != "" )
                {
                    add = 0;
                    filtered = array_remove_index( filtered, filteredindex );
                    conflictresults = [];
                    conflictresults = strtok( conflictstring, " " );
                    
                    foreach ( var_620a120986d0f82a in conflictresults )
                    {
                        attachments = array_insert( attachments, var_620a120986d0f82a, var_4830f0ab7107d9b + 1 + i );
                    }
                    
                    break;
                }
            }
            
            if ( add )
            {
                filtered[ filtered.size ] = attachment;
            }
        }
    }
    
    return filtered;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xba01
// Size: 0x33
function getpassivestruct( passive )
{
    if ( !isdefined( level.passivemap[ passive ] ) )
    {
        return undefined;
    }
    
    struct = level.passivemap[ passive ];
    return struct;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xba3d
// Size: 0xc3
function map_check( enum )
{
    if ( !isdefined( enum ) )
    {
        return 1;
    }
    
    switch ( enum )
    {
        case 0:
            if ( level.script == "cp_zmb" )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        case 1:
            if ( level.script == "cp_rave" )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        case 2:
            if ( level.script == "cp_disco" )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        case 3:
            if ( level.script == "cp_town" )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            return 1;
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xbb08
// Size: 0x2e
function buildweaponnamevariantid( weaponname, variantid )
{
    if ( !isdefined( variantid ) || variantid < 0 )
    {
        return weaponname;
    }
    
    weaponname += "+loot" + variantid;
    return weaponname;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xbb3f
// Size: 0x5a, Type: bool
function isholidayweapon( weaponname, variantid )
{
    if ( !isdefined( variantid ) || variantid < 0 )
    {
        return false;
    }
    
    if ( variantid == 6 )
    {
        weaponroot = getweaponrootname( weaponname );
        return ( weaponroot == "iw7_ripper" || weaponroot == "iw7_lmg03" || weaponroot == "iw7_ar57" );
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xbba2
// Size: 0x37
function buildweaponnamecamo( weaponname, camoref, variantid )
{
    if ( !isdefined( camoref ) )
    {
        return weaponname;
    }
    
    if ( camoref == "none" )
    {
        return weaponname;
    }
    
    return weaponname + "+camo|" + camoref;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xbbe2
// Size: 0x54
function buildweaponnamereticle( weaponname, reticleref )
{
    if ( !isdefined( reticleref ) )
    {
        return weaponname;
    }
    
    reticleid = int( tablelookup( "mp/reticleTable.csv", 1, reticleref, 5 ) );
    
    if ( !isdefined( reticleid ) || reticleid == 0 )
    {
        return weaponname;
    }
    
    weaponname += "+scope" + reticleid;
    return weaponname;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xbc3f
// Size: 0x26, Type: bool
function has_zombie_perk( perk_name )
{
    if ( !isdefined( self.zombies_perks ) )
    {
        return false;
    }
    
    return istrue( self.zombies_perks[ perk_name ] );
}

/#

    // Namespace utility / scripts\cp\utility
    // Params 4
    // Checksum 0x0, Offset: 0xbc6e
    // Size: 0x75, Type: dev
    function drawsphere( origin, radius, timeslice, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        drawtime = int( timeslice * 20 );
        
        for ( time = 0; time < drawtime ; time++ )
        {
            sphere( origin, radius, color );
            wait 0.05;
        }
    }

#/

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xbceb
// Size: 0x1a, Type: bool
function function_3ea84ab28dea3f8()
{
    return istrue( self.has_auto_revive ) && istrue( self.var_bbc9ffd2df014c2 );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xbd0e
// Size: 0xc, Type: bool
function has_auto_revive()
{
    return istrue( self.has_auto_revive );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xbd23
// Size: 0x15
function enable_alien_scripted()
{
    self.alien_scripted = 1;
    self notify( "alien_main_loop_restart" );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xbd40
// Size: 0x103
function get_closest_living_player( maxdist_sq, var_908ececf1b52292e )
{
    var_7296729673615c7 = 1073741824;
    
    if ( isdefined( maxdist_sq ) )
    {
        var_7296729673615c7 = maxdist_sq;
    }
    
    closest_player = undefined;
    player_list = level.players;
    
    if ( isdefined( var_908ececf1b52292e ) )
    {
        player_list = var_908ececf1b52292e;
    }
    
    foreach ( player in player_list )
    {
        if ( isdefined( level.ignoredbycheck ) && [[ level.ignoredbycheck ]]( self, player ) )
        {
            continue;
        }
        
        if ( scripts\cp\laststand::player_in_laststand( player ) )
        {
            continue;
        }
        
        dist_sqr = distancesquared( self.origin, player.origin );
        
        if ( player scripts\cp_mp\utility\player_utility::_isalive() && dist_sqr < var_7296729673615c7 )
        {
            closest_player = player;
            var_7296729673615c7 = dist_sqr;
        }
    }
    
    return closest_player;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xbe4c
// Size: 0x7a
function get_array_of_valid_players( var_c0d8b4d847b4f723, var_30a716428ac01ea )
{
    valid_players = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] is_valid_player() )
        {
            valid_players[ valid_players.size ] = level.players[ i ];
        }
        
        waitframe();
    }
    
    if ( !isdefined( var_c0d8b4d847b4f723 ) || !var_c0d8b4d847b4f723 )
    {
        return valid_players;
    }
    
    return get_array_of_closest( var_30a716428ac01ea, valid_players );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xbecf
// Size: 0x86, Type: bool
function is_valid_player( var_873769d3e3ec0986, var_9dbb64a4bd4c63bf )
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self.sessionstate == "spectator" )
    {
        return false;
    }
    
    if ( !isdefined( var_873769d3e3ec0986 ) && scripts\cp\laststand::player_in_laststand( self ) )
    {
        return false;
    }
    
    if ( !isdefined( var_9dbb64a4bd4c63bf ) )
    {
        var_9dbb64a4bd4c63bf = 1;
    }
    
    if ( !istrue( var_9dbb64a4bd4c63bf ) && ( istrue( self.infreefall ) || istrue( self.inparachute ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xbf5e
// Size: 0x80, Type: bool
function any_player_nearby( origin, dist_sqr )
{
    if ( !isdefined( dist_sqr ) )
    {
        dist_sqr = 40000;
    }
    
    foreach ( player in level.players )
    {
        if ( distancesquared( player.origin, origin ) < dist_sqr )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xbfe7
// Size: 0xc6
function give_closest_player_nearby( origin, dist_sqr, optional_team )
{
    var_927719c9f1b31b0f = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( optional_team ) && player.team != optional_team )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, origin ) < dist_sqr )
        {
            var_927719c9f1b31b0f[ var_927719c9f1b31b0f.size ] = player;
        }
    }
    
    if ( var_927719c9f1b31b0f.size > 0 )
    {
        var_e8818cef9e981e08 = sortbydistance( var_927719c9f1b31b0f, origin );
        return var_e8818cef9e981e08[ 0 ];
    }
    
    return undefined;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xc0b6
// Size: 0xa0, Type: bool
function are_all_players_nearby( origin, dist_sqr )
{
    waittime = undefined;
    
    if ( level.players.size > 10 )
    {
        waittime = 0.05;
    }
    
    foreach ( player in level.players )
    {
        if ( distancesquared( player.origin, origin ) > dist_sqr )
        {
            return false;
        }
        
        if ( isdefined( waittime ) )
        {
            wait waittime;
        }
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xc15f
// Size: 0x71
function give_all_players_nearby( origin, dist_sqr )
{
    playersnearby = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( distancesquared( level.players[ i ].origin, origin ) < dist_sqr )
        {
            playersnearby[ playersnearby.size ] = level.players[ i ];
        }
    }
    
    return playersnearby;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc1d9
// Size: 0x17, Type: bool
function is_playing_pain_breathing_sfx( player )
{
    return istrue( player.is_playing_pain_breathing_sfx );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc1f9
// Size: 0xae
function get_pain_breathing_sfx_alias( player )
{
    if ( !level.gameended )
    {
        if ( player.vo_prefix == "p1_" )
        {
            return "p1_plr_pain";
        }
        
        if ( player.vo_prefix == "p2_" )
        {
            return "p2_plr_pain";
        }
        
        if ( player.vo_prefix == "p3_" )
        {
            return "p3_plr_pain";
        }
        
        if ( player.vo_prefix == "p4_" )
        {
            return "p4_plr_pain";
        }
        
        if ( player.vo_prefix == "p5_" )
        {
            return "p5_plr_pain";
        }
        
        return "p3_plr_pain";
    }
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xc2af
// Size: 0x61
function get_within_range( org, array, dist )
{
    guys = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( distance( array[ i ].origin, org ) <= dist )
        {
            guys[ guys.size ] = array[ i ];
        }
    }
    
    return guys;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xc319
// Size: 0xc9
function breathingmanager( hurttime, healthratio )
{
    self notify( "breathingManager" );
    self endon( "breathingManager" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    level endon( "game_ended" );
    
    if ( isusingremote() )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.breathingstoptime = hurttime + 6000 * self.regenduration;
    wait 6 * self.regenduration;
    
    if ( !level.gameended )
    {
        if ( !isdefined( self.vo_prefix ) )
        {
            return;
        }
        
        if ( !istrue( self.vo_system_playing_vo ) )
        {
            if ( isfemale() )
            {
                playlocalsound_safe( "Fem_breathing_better" );
                return;
            }
            
            playlocalsound_safe( "breathing_better" );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc3ea
// Size: 0x191
function getregendata( regendata )
{
    level.longregentime = 5000;
    level.healthoverlaycutoff = 0.2;
    level.invultime_preshield = 0.35;
    level.invultime_onshield = 0.5;
    level.invultime_postshield = 0.3;
    level.worthydamageratio = 0.1;
    self.prestigehealthregennerfscalar = scripts\cp\perks\cp_prestige::prestige_getslowhealthregenscalar();
    regen_scalar = 1;
    
    if ( isdefined( self.perk_data ) )
    {
        if ( isdefined( self.perk_data[ "regen_time_scalar" ] ) )
        {
            regen_scalar = self.perk_data[ "regen_time_scalar" ];
        }
        else
        {
            regen_scalar = self.perk_data[ "health" ].regen_time_scalar;
        }
    }
    
    if ( self.prestigehealthregennerfscalar == 1 )
    {
        if ( is_consumable_active( "faster_health_regen_upgrade" ) )
        {
            regendata.activatetime = 0.45;
            regendata.waittimebetweenregen = 0.045;
            regendata.regenamount = 0.1;
        }
        else
        {
            regendata.activatetime = 6;
            regendata.waittimebetweenregen = 0.05;
            regendata.regenamount = 6 * regen_scalar;
        }
        
        return;
    }
    
    regendata.activatetime = 6 * self.prestigehealthregennerfscalar;
    regendata.waittimebetweenregen = 0.05 * self.prestigehealthregennerfscalar;
    regendata.regenamount = 6;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc583
// Size: 0x2d
function resetattackerlist( var_a2b85b5ebfe28c6b )
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    wait 1.75;
    resetattackerlist_internal();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xc5b8
// Size: 0x16
function resetattackerlist_internal()
{
    self.attackers = [];
    self.attackerdata = [];
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xc5d6
// Size: 0x63, Type: bool
function canregenhealth()
{
    if ( getdvarint( @"hash_c51a261dfe1eb96", 0 ) == 1 )
    {
        return false;
    }
    
    if ( istrue( self.isjuggernaut ) )
    {
        return false;
    }
    
    if ( scripts\cp\laststand::player_in_laststand( self ) )
    {
        return false;
    }
    
    if ( istrue( self.fauxdead ) )
    {
        return false;
    }
    
    if ( istrue( self.disable_health_regen ) )
    {
        return false;
    }
    
    if ( istrue( self.relic_disable_health_regen ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xc642
// Size: 0x34, Type: bool
function ishealthregendisabled()
{
    return isdefined( level.healthregendisabled ) && level.healthregendisabled || isdefined( self.healthregendisabled ) && self.healthregendisabled;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc67f
// Size: 0x82
function allow_secondary_offhand_weapons( bool )
{
    if ( bool )
    {
        if ( !isdefined( self.disabledsecondaryoffhandweapons ) )
        {
            self.disabledsecondaryoffhandweapons = 0;
        }
        
        self.disabledsecondaryoffhandweapons--;
        assert( self.disabledsecondaryoffhandweapons >= 0 );
        
        if ( !self.disabledsecondaryoffhandweapons )
        {
            self enableoffhandsecondaryweapons();
        }
        
        return;
    }
    
    if ( !isdefined( self.disabledsecondaryoffhandweapons ) )
    {
        self.disabledsecondaryoffhandweapons = 0;
    }
    
    self.disabledsecondaryoffhandweapons++;
    self disableoffhandsecondaryweapons();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xc709
// Size: 0xb6
function global_physics_sound_monitor()
{
    level notify( "physics_monitor" );
    level endon( "physics_monitor" );
    
    while ( true )
    {
        level waittill( "physSnd", var_c92ef281c1d335fc, body0, body1, flag0, flag1, position, normal, impulse, var_b941baeebca428d );
        
        if ( isdefined( var_c92ef281c1d335fc ) && isdefined( var_c92ef281c1d335fc.phys_sound_func ) )
        {
            level thread [[ var_c92ef281c1d335fc.phys_sound_func ]]( var_c92ef281c1d335fc, body0, body1, flag0, flag1, position, normal, impulse, var_b941baeebca428d );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc7c7
// Size: 0x119
function ent_is_near_equipment( ent )
{
    distcheck = 16384;
    
    if ( level.turrets.size )
    {
        sorted = sortbydistance( level.turrets, ent.origin );
        
        if ( distance2dsquared( sorted[ 0 ].origin, ent.origin ) < distcheck )
        {
            return 1;
        }
    }
    
    if ( isdefined( level.placed_crafted_traps ) && level.placed_crafted_traps.size )
    {
        foreach ( trap in level.placed_crafted_traps )
        {
            if ( !isdefined( trap ) )
            {
                continue;
            }
            
            if ( distance2dsquared( trap.origin, ent.origin ) < distcheck )
            {
                return 1;
            }
        }
    }
    
    if ( isdefined( level.near_equipment_func ) )
    {
        return [[ level.near_equipment_func ]]( ent );
    }
    
    return 0;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xc8e9
// Size: 0x74
function set_crafted_inventory_item( item_name, var_e8188e6cadb7ea53, player )
{
    if ( isdefined( player.current_crafted_inventory ) )
    {
        player.current_crafted_inventory = undefined;
    }
    
    player.current_crafted_inventory = spawnstruct();
    player.current_crafted_inventory.item = item_name;
    player.current_crafted_inventory.restore_func = var_e8188e6cadb7ea53;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc965
// Size: 0x16
function remove_crafted_item_from_inventory( player )
{
    player.current_crafted_inventory = undefined;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xc983
// Size: 0xbd
function item_handleownerdisconnect( notify_str )
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( notify_str );
    self endon( notify_str );
    self.owner waittill( "disconnect" );
    
    foreach ( player in level.players )
    {
        if ( player is_valid_player( 1 ) )
        {
            self.owner = player;
            
            if ( self.classname != "script_model" )
            {
                self setsentryowner( self.owner );
            }
            
            break;
        }
    }
    
    thread item_handleownerdisconnect( notify_str );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xca48
// Size: 0x29
function restore_player_perk()
{
    if ( isdefined( self.restoreperk ) )
    {
        giveperk( self.restoreperk );
        self.restoreperk = undefined;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xca79
// Size: 0x24
function wait_restore_player_perk()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    wait 0.05;
    restore_player_perk();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xcaa5
// Size: 0x2a
function remove_player_perks()
{
    if ( _hasperk( "specialty_explosivebullets" ) )
    {
        self.restoreperk = "specialty_explosivebullets";
        _unsetperk( "specialty_explosivebullets" );
    }
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xcad7
// Size: 0xe2
function item_timeout( lifespan, var_2f58e0c81044ac85, end_notify )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( !isdefined( self.lifespan ) )
    {
        self.lifespan = var_2f58e0c81044ac85;
    }
    
    if ( isdefined( lifespan ) )
    {
        self.lifespan = lifespan;
    }
    
    while ( self.lifespan )
    {
        wait 1;
        scripts\cp\cp_hostmigration::waittillhostmigrationdone();
        
        if ( !isdefined( self.carriedby ) )
        {
            self.lifespan = max( 0, self.lifespan - 1 );
        }
    }
    
    while ( isdefined( self ) && isdefined( self.inuseby ) )
    {
        wait 0.05;
    }
    
    if ( isdefined( self.zap_model ) )
    {
        self.zap_model delete();
    }
    
    if ( isdefined( end_notify ) )
    {
        self notify( end_notify );
        return;
    }
    
    self notify( "death" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xcbc1
// Size: 0x44
function item_oncarrierdeath( carrier )
{
    self endon( "placed" );
    self endon( "death" );
    carrier endon( "disconnect" );
    result = carrier waittill_any_return_2( "death", "last_stand" );
    carrier notify( "force_cancel_placement" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xcc0d
// Size: 0xe6
function item_oncarrierdisconnect( carrier )
{
    self endon( "placed" );
    self endon( "death" );
    carrier endon( "last_stand" );
    carrier waittill( "disconnect" );
    
    if ( isdefined( self.carriedgascan ) )
    {
        self.carriedgascan delete();
    }
    else if ( isdefined( self.carriedmedusa ) )
    {
        self.carriedmedusa delete();
    }
    else if ( isdefined( self.carried_trap ) )
    {
        self.carried_trap delete();
    }
    else if ( isdefined( self.carriedboombox ) )
    {
        self.carriedboombox delete();
    }
    else if ( isdefined( self.carried_fireworks_trap ) )
    {
        self.carried_fireworks_trap delete();
    }
    else if ( isdefined( self.carriedrevocator ) )
    {
        self.carriedrevocator delete();
    }
    
    self delete();
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xccfb
// Size: 0x2f
function item_ongameended( carrier )
{
    self endon( "placed" );
    self endon( "death" );
    carrier endon( "last_stand" );
    level waittill( "game_ended" );
    self delete();
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xcd32
// Size: 0x11e, Type: bool
function should_be_affected_by_trap( ent, var_4d0bd8cee4c886b2, var_b0c9e40dd558140f )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !isalive( ent ) )
    {
        return false;
    }
    
    if ( !isagent( ent ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.agent_type ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.isactive ) || !ent.isactive )
    {
        return false;
    }
    
    if ( !isdefined( var_4d0bd8cee4c886b2 ) && isdefined( ent.entered_playspace ) && !ent.entered_playspace )
    {
        return false;
    }
    
    if ( istrue( ent.marked_for_death ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.team ) )
    {
        return false;
    }
    
    if ( ent.agent_type == "zombie_brute" || ent.agent_type == "zombie_ghost" || ent.agent_type == "zombie_grey" )
    {
        return false;
    }
    
    if ( !istrue( var_b0c9e40dd558140f ) && istrue( ent.is_suicide_bomber ) )
    {
        return false;
    }
    
    if ( istrue( ent.is_coaster_zombie ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xce59
// Size: 0x30
function roundup( floatvalue )
{
    if ( floatvalue - int( floatvalue ) >= 0.5 )
    {
        return int( floatvalue + 1 );
    }
    
    return int( floatvalue );
}

// Namespace utility / scripts\cp\utility
// Params 9
// Checksum 0x0, Offset: 0xce91
// Size: 0x1d2
function damage_over_time( victim, attacker, duration, total_damage, smeansofdeath, sweapon, tickets, state, killnotify )
{
    if ( !should_apply_dot( victim ) )
    {
        return;
    }
    
    victim endon( "death" );
    
    if ( !isdefined( total_damage ) )
    {
        total_damage = 600;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    if ( !isdefined( smeansofdeath ) )
    {
        smeansofdeath = "MOD_UNKNOWN";
    }
    
    if ( !isdefined( sweapon ) )
    {
        sweapon = "iw7_dot_zm";
    }
    
    if ( isdefined( state ) )
    {
        victim setscriptablestateflag( victim, state, 1 );
        
        if ( isdefined( level.scriptablestatefunc ) )
        {
            victim thread [[ level.scriptablestatefunc ]]( victim );
        }
    }
    
    elapsed_time = 0;
    samples = 6;
    interval_wait = duration / samples;
    interval_damage = total_damage / samples;
    
    for ( i = 0; i < samples ; i++ )
    {
        wait interval_wait;
        
        if ( isalive( victim ) )
        {
            victim.flame_damage_time = gettime() + 500;
            
            if ( victim.health - interval_damage <= 0 )
            {
                if ( isdefined( killnotify ) )
                {
                    level notify( killnotify );
                }
            }
            
            if ( isdefined( attacker ) )
            {
                victim dodamage( interval_damage, victim.origin, attacker, attacker, smeansofdeath, sweapon );
                continue;
            }
            
            victim dodamage( interval_damage, victim.origin, undefined, undefined, smeansofdeath, sweapon );
        }
    }
    
    if ( isdefined( state ) )
    {
        victim setscriptablestateflag( victim, state );
    }
    
    if ( istrue( victim.marked_for_death ) )
    {
        victim.marked_for_death = undefined;
    }
    
    if ( istrue( victim.flame_damage_time ) )
    {
        victim.flame_damage_time = undefined;
    }
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xd06b
// Size: 0x168
function setscriptablestateflag( victim, state, active )
{
    switch ( state )
    {
        case #"hash_41199d1115f20064":
        case #"hash_5c2f61b32896c344":
            if ( istrue( active ) )
            {
                victim.is_afflicted = 1;
            }
            else
            {
                victim.is_afflicted = undefined;
            }
            
            break;
        case #"hash_5a5720fa6b087610":
            if ( istrue( active ) )
            {
                victim.is_burning = active;
            }
            else
            {
                victim.is_burning = undefined;
            }
            
            break;
        case #"hash_eb545a9ff62c0bad":
            if ( istrue( active ) )
            {
                victim.is_electrified = active;
                victim.allowpain = 1;
                victim.stun_hit_time = gettime() + 3000;
            }
            else
            {
                victim.is_electrified = undefined;
                victim.allowpain = 0;
            }
            
            break;
        case #"hash_7fa51eb5aa5f9168":
            if ( istrue( active ) )
            {
                victim.stunned = active;
            }
            else
            {
                victim.stunned = undefined;
            }
            
            break;
        case #"hash_12c9feb27a4c2291":
        case #"hash_dc8bfdecfa786eb1":
            if ( istrue( active ) )
            {
                victim.is_chem_burning = 1;
            }
            else
            {
                victim.is_chem_burning = undefined;
            }
            
            break;
        default:
            break;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xd1db
// Size: 0x72, Type: bool
function should_apply_dot( victim )
{
    if ( isdefined( victim.agent_type ) && ( victim.agent_type == "c6" || victim.agent_type == "zombie_brute" || victim.agent_type == "zombie_grey" || victim.agent_type == "zombie_ghost" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xd256
// Size: 0x1b, Type: bool
function is_codxp()
{
    return getdvar( @"hash_7675e89830ff46bb", "" ) != "";
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xd27a
// Size: 0x15c
function getweapontoswitchbackto()
{
    weapontoswitchbackto = undefined;
    
    if ( isdefined( self.last_weapon ) )
    {
        weapontoswitchbackto = self.last_weapon;
    }
    else
    {
        weapontoswitchbackto = self getcurrentweapon();
    }
    
    var_c19139aa4333cc8f = 0;
    exclusionlist = level.additional_laststand_weapon_exclusion;
    
    if ( isnullweapon( weapontoswitchbackto ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    else if ( array_contains( exclusionlist, weapontoswitchbackto ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    else if ( array_contains( exclusionlist, weapontoswitchbackto getbaseweapon() ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    else if ( is_melee_weapon( weapontoswitchbackto, 1 ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    
    if ( var_c19139aa4333cc8f )
    {
        weaponslist = self getweaponslistall();
        
        for ( i = 0; i < weaponslist.size ; i++ )
        {
            if ( isnullweapon( weaponslist[ i ] ) )
            {
                continue;
            }
            
            if ( array_contains( exclusionlist, weaponslist[ i ] ) )
            {
                continue;
            }
            
            if ( array_contains( exclusionlist, weaponslist[ i ] getbaseweapon() ) )
            {
                continue;
            }
            
            if ( is_melee_weapon( weaponslist[ i ], 1 ) )
            {
                continue;
            }
            
            if ( !scripts\cp\weapon::isprimaryweapon( weaponslist[ i ] ) )
            {
                continue;
            }
            
            var_c19139aa4333cc8f = 0;
            weapontoswitchbackto = weaponslist[ i ];
            break;
        }
    }
    
    if ( var_c19139aa4333cc8f )
    {
        weapontoswitchbackto = makeweapon( "iw9_me_fists_mp" );
        
        if ( !self hasweapon( weapontoswitchbackto ) )
        {
            _giveweapon( weapontoswitchbackto, undefined, undefined, 1 );
        }
    }
    
    return weapontoswitchbackto;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xd3df
// Size: 0x22c
function getvalidtakeweapon( var_19e2338fa9dc0523 )
{
    weapontoswitchbackto = self getcurrentweapon();
    var_c19139aa4333cc8f = 0;
    exclusionlist = level.additional_laststand_weapon_exclusion;
    
    if ( isdefined( var_19e2338fa9dc0523 ) )
    {
        exclusionlist = array_combine( var_19e2338fa9dc0523, exclusionlist );
    }
    
    if ( isnullweapon( weapontoswitchbackto ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    else if ( isdefined( weapontoswitchbackto.inventorytype ) && weapontoswitchbackto.inventorytype == "model_only" )
    {
        var_c19139aa4333cc8f = 1;
    }
    else if ( array_contains( exclusionlist, weapontoswitchbackto ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    else if ( array_contains( exclusionlist, weapontoswitchbackto getbaseweapon() ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    else if ( !is_wave_gametype() && is_melee_weapon( weapontoswitchbackto, 1 ) )
    {
        var_c19139aa4333cc8f = 1;
    }
    
    if ( isdefined( self.last_valid_weapon ) && self hasweapon( self.last_valid_weapon ) && var_c19139aa4333cc8f )
    {
        weapontoswitchbackto = self.last_valid_weapon;
        
        if ( isnullweapon( weapontoswitchbackto ) )
        {
            var_c19139aa4333cc8f = 1;
        }
        else if ( isdefined( weapontoswitchbackto.inventorytype ) && weapontoswitchbackto.inventorytype == "model_only" )
        {
            var_c19139aa4333cc8f = 1;
        }
        else if ( array_contains( exclusionlist, weapontoswitchbackto ) )
        {
            var_c19139aa4333cc8f = 1;
        }
        else if ( array_contains( exclusionlist, weapontoswitchbackto getbaseweapon() ) )
        {
            var_c19139aa4333cc8f = 1;
        }
        else if ( is_melee_weapon( weapontoswitchbackto, 1 ) )
        {
            var_c19139aa4333cc8f = 1;
        }
        else
        {
            var_c19139aa4333cc8f = 0;
        }
    }
    
    if ( var_c19139aa4333cc8f )
    {
        weaponslist = self getweaponslistall();
        
        for ( i = 0; i < weaponslist.size ; i++ )
        {
            if ( isnullweapon( weaponslist[ i ] ) )
            {
                continue;
            }
            
            if ( array_contains( exclusionlist, weaponslist[ i ] ) )
            {
                continue;
            }
            
            if ( array_contains( exclusionlist, weaponslist[ i ] getbaseweapon() ) )
            {
                continue;
            }
            
            if ( is_melee_weapon( weaponslist[ i ], 1 ) )
            {
                continue;
            }
            
            if ( isdefined( weaponslist[ i ].inventorytype ) && weaponslist[ i ].inventorytype == "model_only" )
            {
                continue;
            }
            
            var_c19139aa4333cc8f = 0;
            weapontoswitchbackto = weaponslist[ i ];
            break;
        }
    }
    
    return weapontoswitchbackto;
}

// Namespace utility / scripts\cp\utility
// Params 9
// Checksum 0x0, Offset: 0xd614
// Size: 0x109
function add_to_notify_queue( var_7239f8830ef22b43, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    if ( !isdefined( self.notify_queue ) )
    {
        self.notify_queue = [];
    }
    
    if ( !isdefined( self.notify_queue[ var_7239f8830ef22b43 ] ) )
    {
        self.notify_queue[ var_7239f8830ef22b43 ] = 0;
    }
    else
    {
        self.notify_queue[ var_7239f8830ef22b43 ]++;
    }
    
    if ( self.notify_queue[ var_7239f8830ef22b43 ] > 0 )
    {
        wait 0.05 * self.notify_queue[ var_7239f8830ef22b43 ];
    }
    
    if ( isdefined( self ) )
    {
        self notify( var_7239f8830ef22b43, param1, param2, param3, param4, param5, param6, param7, param8 );
    }
    
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.notify_queue[ var_7239f8830ef22b43 ] ) )
        {
            self.notify_queue[ var_7239f8830ef22b43 ]--;
            
            if ( self.notify_queue[ var_7239f8830ef22b43 ] < 1 )
            {
                self.notify_queue[ var_7239f8830ef22b43 ] = undefined;
            }
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xd725
// Size: 0x1c
function playlocalsound_safe( sfx_alias )
{
    if ( soundexists( sfx_alias ) )
    {
        self playlocalsound( sfx_alias );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xd749
// Size: 0x24
function playsoundatpos_safe( pos, sfx_alias )
{
    if ( soundexists( sfx_alias ) )
    {
        playsoundatpos( pos, sfx_alias );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xd775
// Size: 0x25
function playsoundtoplayer_safe( sfx_alias, player )
{
    if ( soundexists( sfx_alias ) )
    {
        player playsoundtoplayer( sfx_alias, player );
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xd7a2
// Size: 0x36, Type: bool
function agentisfnfimmune()
{
    return isdefined( self.agent_type ) && isdefined( level.fnfimmune ) && array_contains( level.fnfimmune, self.agent_type );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xd7e1
// Size: 0x36, Type: bool
function agentisinstakillimmune()
{
    return isdefined( self.agent_type ) && isdefined( level.instakillimmune ) && array_contains( level.instakillimmune, self.agent_type );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xd820
// Size: 0x40
function firegesturegrenade( player, gestureweapon )
{
    currentweapon = player getcurrentweapon();
    
    if ( cangiveandfireoffhand( currentweapon ) )
    {
        player setweaponammostock( gestureweapon, 1 );
        player giveandfireoffhand( gestureweapon );
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xd868
// Size: 0x42
function cangiveandfireoffhand( currentweapon )
{
    if ( !isdefined( currentweapon ) )
    {
        return 1;
    }
    
    if ( isdefined( level.invalid_gesture_weapon ) )
    {
        if ( isdefined( level.invalid_gesture_weapon[ getweaponbasename( currentweapon ) ] ) )
        {
            return 0;
        }
        else
        {
            return 1;
        }
        
        return;
    }
    
    return 1;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xd8b2
// Size: 0xce
function playerplaypickupanim( gesture_name )
{
    self notify( "playerPlayPickupAnim" );
    self endon( "playerPlayPickupAnim" );
    self endon( "death" );
    self endon( "disconnect" );
    
    if ( self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || isplayerads() )
    {
        return;
    }
    
    if ( !isdefined( gesture_name ) )
    {
        gesture_name = "iw9_ges_pickup";
    }
    
    weaponnone = makeweapon( "none" );
    curweap = self getcurrentprimaryweapon();
    
    if ( issameweapon( curweap, weaponnone ) )
    {
        return;
    }
    
    if ( self isgestureplaying( gesture_name ) )
    {
        self stopgestureviewmodel( gesture_name, 0, 1 );
        wait 0.05;
    }
    
    self forceplaygestureviewmodel( gesture_name );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xd988
// Size: 0x93, Type: bool
function playerplaytakephotoanim()
{
    weap_name = "intel_take_photo";
    cur_weap = self getcurrentweapon();
    weap = makeweapon( weap_name );
    thread _freeze_until_phototaken();
    _giveweapon( weap );
    self switchtoweapon( weap );
    self setclientomnvar( "ui_tablet_usb", 7 );
    wait_time = 3;
    wait wait_time;
    
    if ( isplayer( self ) )
    {
        self takeweapon( weap );
        self switchtoweapon( cur_weap );
        self setclientomnvar( "ui_tablet_usb", 0 );
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xda24
// Size: 0x53
function _freeze_until_phototaken()
{
    curstance = self getstance();
    _togglecellphoneallows( 1 );
    restrict_player_stance_to_this( "photo", 1, curstance );
    wait_time = 1.6;
    wait wait_time;
    _togglecellphoneallows( 0 );
    restrict_player_stance_to_this( "photo", 0, curstance );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xda7f
// Size: 0x9c
function _togglecellphoneallows( var_7cf474a446af159d )
{
    if ( var_7cf474a446af159d )
    {
        val::set( "cellphone", "allow_movement", 0 );
        val::set( "cellphone", "allow_jump", 0 );
        val::set( "cellphone", "usability", 0 );
        val::set( "cellphone", "melee", 0 );
        val::set( "cellphone", "offhand_weapons", 0 );
        val::set( "cellphone", "weapon_switch", 0 );
        val::set( "cellphone", "sprint", 0 );
        return;
    }
    
    val::reset_all( "cellphone" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xdb23
// Size: 0x39
function function_5d353ef59919f42c( var_c4ad7e98d18b64df )
{
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( var_c4ad7e98d18b64df ) )
    {
        var_c4ad7e98d18b64df = 1.25;
    }
    
    thread playerplaypickupanim( "ges_radio" );
    wait var_c4ad7e98d18b64df;
    self stopgestureviewmodel( "ges_radio" );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xdb64
// Size: 0x38
function restrict_player_stance_to_this( reason, toggle, stance )
{
    if ( istrue( toggle ) )
    {
        _player_allowed_stances( reason, 1, stance );
        return;
    }
    
    _player_allowed_stances( reason, 0, stance );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xdba4
// Size: 0xb5
function _player_allowed_stances( reason, toggle, stance )
{
    if ( istrue( toggle ) )
    {
        switch ( stance )
        {
            case #"hash_c6775c88e38f7803":
                val::set( reason, "crouch", 0 );
                val::set( reason, "prone", 0 );
                break;
            case #"hash_3fed0cbd303639eb":
                val::set( reason, "stand", 0 );
                val::set( reason, "prone", 0 );
                break;
            case #"hash_d91940431ed7c605":
                val::set( reason, "crouch", 0 );
                val::set( reason, "stand", 0 );
                break;
        }
        
        return;
    }
    
    val::reset_all( reason );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xdc61
// Size: 0x23, Type: bool
function rankingenabled()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    return level.onlinegame && !self.usingonlinedataoffline;
}

/#

    // Namespace utility / scripts\cp\utility
    // Params 1
    // Checksum 0x0, Offset: 0xdc8d
    // Size: 0x66, Type: dev
    function debugprintline( message )
    {
        if ( !isdefined( level.var_228a62f48d87ee99 ) )
        {
            level.var_228a62f48d87ee99 = [];
        }
        
        level.var_228a62f48d87ee99[ message ] = 1;
        
        if ( level.var_228a62f48d87ee99.size > 1 )
        {
            wait 0.2 * level.var_228a62f48d87ee99.size;
        }
        
        iprintlnbold( message );
        level.var_228a62f48d87ee99[ message ] = undefined;
    }

    // Namespace utility / scripts\cp\utility
    // Params 0
    // Checksum 0x0, Offset: 0xdcfb
    // Size: 0x56, Type: dev
    function function_182fa47a3be3b00c()
    {
        if ( flag_exist( "<dev string:x145>" ) )
        {
            if ( flag_exist( "<dev string:x156>" ) )
            {
                flag_wait( "<dev string:x156>" );
            }
            
            wait 2;
            
            if ( flag_exist( "<dev string:x16f>" ) )
            {
                flag_wait( "<dev string:x16f>" );
            }
            
            flag_set( "<dev string:x145>" );
        }
    }

    // Namespace utility / scripts\cp\utility
    // Params 2
    // Checksum 0x0, Offset: 0xdd59
    // Size: 0x6c, Type: dev
    function debug_activation( dvar, action_func )
    {
        level endon( "<dev string:x180>" );
        setdevdvarifuninitialized( dvar, "<dev string:x144>" );
        
        while ( true )
        {
            result = getdvar( dvar );
            
            if ( result != "<dev string:x144>" )
            {
                [[ action_func ]]( result );
                wait 0.05;
                setdvar( dvar, "<dev string:x144>" );
                continue;
            }
            
            wait 0.25;
        }
    }

    // Namespace utility / scripts\cp\utility
    // Params 2
    // Checksum 0x0, Offset: 0xddcd
    // Size: 0x67, Type: dev
    function function_d3a46ebba0eb3257( dvar, action_func )
    {
        level endon( "<dev string:x180>" );
        setdevdvarifuninitialized( dvar, "<dev string:x144>" );
        old_result = getdvar( dvar );
        
        while ( true )
        {
            result = getdvar( dvar );
            
            if ( result != old_result )
            {
                old_result = result;
                [[ action_func ]]( result );
            }
            
            wait 0.25;
        }
    }

#/

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xde3c
// Size: 0x6c
function function_de4d04211ef12e03( dvar, action_func )
{
    level endon( "host_migration_begin" );
    
    /#
        setdevdvarifuninitialized( dvar, "<dev string:x144>" );
    #/
    
    while ( true )
    {
        result = getdvar( dvar );
        
        if ( result != "" )
        {
            [[ action_func ]]( result );
            wait 0.05;
            setdvar( dvar, "" );
            continue;
        }
        
        wait 0.25;
    }
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0xdeb0
// Size: 0xed
function ent_createheadicon( entity, offset, team, headicon, var_e8fdb557f10c30e9 )
{
    if ( !level.teambased )
    {
        return undefined;
    }
    
    if ( !isdefined( team ) )
    {
        team = "allies";
    }
    
    assertex( isdefined( entity ), "createHeadIcon() requires a valid entity." );
    assertex( isdefined( offset ), "createHeadIcon() requires a valid offset." );
    assertex( isdefined( headicon ), "createHeadIcon() requires a valid headIcon Material." );
    headiconid = createheadicon( entity );
    setheadiconfriendlyimage( headiconid, headicon );
    setheadiconzoffset( headiconid, offset );
    setheadiconnaturaldistance( headiconid, 0 );
    setheadiconmaxdistance( headiconid, 2250 );
    setheadiconteam( headiconid, team );
    
    if ( istrue( level.var_32fe21b3c5052471 ) )
    {
        setheadiconusecustomcolors( headiconid, 1 );
    }
    
    if ( isdefined( var_e8fdb557f10c30e9 ) )
    {
        setheadicondrawthroughgeo( headiconid, var_e8fdb557f10c30e9 );
    }
    
    addteamtoheadiconmask( headiconid, team );
    showheadicontoplayersinmask( headiconid );
    thread watchheadicon( entity, headiconid );
    return headiconid;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xdfa6
// Size: 0x2e
function watchheadicon( entity, headiconid )
{
    entity endon( "head_icon_deleted_" + headiconid );
    entity waittill( "death" );
    thread ent_deleteheadicon( entity, headiconid );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xdfdc
// Size: 0x31
function ent_deleteheadicon( entity, headiconid )
{
    entity notify( "head_icon_deleted_" + headiconid );
    
    if ( isdefined( headiconid ) && headiconid != -1 )
    {
        deleteheadicon( headiconid );
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe015
// Size: 0x1e
function getlastweapon()
{
    assert( isdefined( self.lastweaponobj ) );
    return self.lastweaponobj;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe03c
// Size: 0xc, Type: bool
function isnmlactive()
{
    return istrue( level.nml_proto );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xe051
// Size: 0x103
function addtostructarray( key, value, item )
{
    switch ( key )
    {
        case #"hash_5a532485943b3d4b":
            if ( !isdefined( item.targetname ) )
            {
                item.targetname = value;
            }
            
            break;
        case #"hash_343323f1597ffea8":
            if ( !isdefined( item.target ) )
            {
                item.target = value;
            }
            
            break;
        case #"hash_6d8a4db48060bf8":
            if ( !isdefined( item.script_noteworthy ) )
            {
                item.script_noteworthy = value;
            }
            
            break;
        case #"hash_3d6236cdb0daca28":
            if ( !isdefined( item.script_linkname ) )
            {
                item.script_linkname = value;
            }
            
            break;
        case #"hash_1cc26296e3429cc5":
            if ( !isdefined( item.variantname ) )
            {
                item.variantname = value;
            }
            
            break;
    }
    
    addstruct( item );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xe15c
// Size: 0x84, Type: bool
function is_in_active_volume( death_pos )
{
    if ( !isdefined( level.active_spawn_volumes ) )
    {
        return true;
    }
    
    var_82ade947f8992573 = sortbydistance( level.active_spawn_volumes, death_pos );
    
    foreach ( volume in var_82ade947f8992573 )
    {
        if ( ispointinvolume( death_pos, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 8
// Checksum 0x0, Offset: 0xe1e9
// Size: 0x54
function objective_update( message_ref, time, yellow_time, red_time, nofailontimeout, object_count, objective_slot, big_timer )
{
    scripts\cp\cp_objectives::objective_update_internal( message_ref, time, yellow_time, red_time, nofailontimeout, object_count, objective_slot, big_timer );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe245
// Size: 0xc0
function function_cc38ddc890d2bb22()
{
    level endon( "game_ended" );
    flag_wait( "both_players_intro_binks_complete" );
    
    if ( isdefined( game[ "star_rewards_times" ] ) )
    {
        level.timerstarttime = int( gettime() - game[ "star_rewards_times" ] * 1000 );
    }
    else
    {
        level.timerstarttime = gettime();
    }
    
    if ( getdvarint( @"hash_a6c62479b8550953" ) )
    {
        function_dedc3a4be4fb4e1e();
    }
    else
    {
        function_7a294a03559cf85e();
    }
    
    starttime = level.starttime;
    
    while ( true )
    {
        level.timeelapsed = gettime() - level.timerstarttime;
        setomnvar( "cp_mission_timer", level.timeelapsed );
        wait 0.05;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe30d
// Size: 0xf
function function_dedc3a4be4fb4e1e()
{
    setomnvar( "cp_mission_timer_alpha", 1 );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe324
// Size: 0xe
function function_7a294a03559cf85e()
{
    setomnvar( "cp_mission_timer_alpha", 0 );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe33a
// Size: 0xa6
function function_2c08be5adb8b60f4()
{
    if ( isdefined( level.timerstarttime ) )
    {
        level.starttime = level.timerstarttime;
    }
    
    starttime = level.starttime;
    
    if ( isdefined( level.missionstarttime ) )
    {
        starttime = level.missionstarttime;
    }
    
    if ( isdefined( game[ "star_rewards_times" ] ) )
    {
        level.time_survived = int( ( gettime() - starttime ) / 1000 ) + game[ "star_rewards_times" ];
    }
    else
    {
        level.time_survived = int( ( gettime() - starttime ) / 1000 );
    }
    
    game[ "star_rewards_times" ] = level.time_survived;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0xe3e8
// Size: 0x9d
function hint_prompt( message_ref, display, waittime, var_3b846e197f180922 )
{
    self endon( "disconnect" );
    self notify( "new_hint_prompt" );
    self endon( "new_hint_prompt" );
    
    if ( istrue( display ) )
    {
        var_6427da22a2830c8e = int( tablelookup( "cp/cp_hints.csv", 1, message_ref, 0 ) );
    }
    else
    {
        var_6427da22a2830c8e = 0;
    }
    
    self setclientomnvar( "zm_hint_index", var_6427da22a2830c8e );
    
    if ( istrue( var_3b846e197f180922 ) )
    {
        thread hint_prompt_ondeath();
    }
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
        self setclientomnvar( "zm_hint_index", 0 );
        
        if ( istrue( var_3b846e197f180922 ) )
        {
            self notify( "end_hint_prompt_onDeath" );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe48d
// Size: 0x35
function private hint_prompt_ondeath()
{
    self endon( "disconnect" );
    self endon( "end_hint_prompt_onDeath" );
    self endon( "new_hint_prompt" );
    waittill_any_2( "last_stand_start", "death" );
    self setclientomnvar( "zm_hint_index", 0 );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe4ca
// Size: 0x17
function function_c2963cdb537e31a0()
{
    self notify( "end_hint_prompt_onDeath" );
    self setclientomnvar( "zm_hint_index", 0 );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xe4e9
// Size: 0x7d
function function_28ab2855171f96f0( start, end, point )
{
    l2 = distancesquared( start, end );
    
    if ( l2 == 0 )
    {
        return distance( start, point );
    }
    
    t = max( 0, min( 1, vectordot( point - start, end - start ) / l2 ) );
    projection = start + t * ( end - start );
    return distance( point, projection );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xe56f
// Size: 0x30
function get_carry_item_omnvar( carry_ref )
{
    var_6427da22a2830c8e = tablelookup( "cp/carry_items.csv", 1, carry_ref, 0 );
    
    if ( isdefined( var_6427da22a2830c8e ) )
    {
        return var_6427da22a2830c8e;
    }
    
    return 0;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xe5a7
// Size: 0xeb
function set_carry_item( player, carry_ref )
{
    var_6427da22a2830c8e = get_carry_item_omnvar( carry_ref );
    slot = 1;
    
    if ( !isdefined( player.carryitemomnvar ) || player.carryitemomnvar == 0 )
    {
        player.carryitemomnvar = int( var_6427da22a2830c8e );
    }
    else if ( !isdefined( player.carryitem2omnvar ) || player.carryitem2omnvar == 0 )
    {
        player.carryitem2omnvar = int( var_6427da22a2830c8e );
        slot = 2;
    }
    else
    {
        player.var_70e7c265a77e6dbf = int( var_6427da22a2830c8e );
        slot = 3;
    }
    
    struct = spawnstruct();
    struct.carry_ref = carry_ref;
    struct.slot = slot;
    scripts\cp\globallogic::broadcast_carry_items( player );
    return struct;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xe69b
// Size: 0x31
function function_c16dc4ba20e6db6d()
{
    player = self;
    
    for ( i = 1; i <= 3 ; i++ )
    {
        remove_carry_item( player, i );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xe6d4
// Size: 0xa8
function function_98f7ca3781dac77c( player, carry_ref )
{
    var_6427da22a2830c8e = int( get_carry_item_omnvar( carry_ref ) );
    
    if ( isdefined( player.carryitemomnvar ) && player.carryitemomnvar == var_6427da22a2830c8e )
    {
        remove_carry_item( player, 1 );
    }
    
    if ( isdefined( player.carryitem2omnvar ) && player.carryitem2omnvar == var_6427da22a2830c8e )
    {
        remove_carry_item( player, 2 );
    }
    
    if ( isdefined( player.var_70e7c265a77e6dbf ) && player.var_70e7c265a77e6dbf == var_6427da22a2830c8e )
    {
        remove_carry_item( player, 3 );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xe784
// Size: 0x66
function remove_carry_item( player, slotnum )
{
    if ( !isdefined( slotnum ) )
    {
        slotnum = 1;
    }
    
    if ( slotnum == 1 )
    {
        player.carryitemomnvar = 0;
    }
    else if ( slotnum == 2 )
    {
        player.carryitem2omnvar = 0;
    }
    else if ( slotnum == 3 )
    {
        player.var_70e7c265a77e6dbf = 0;
    }
    
    scripts\cp\globallogic::broadcast_carry_items( player );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xe7f2
// Size: 0x15
function addentrytodevgui( command )
{
    level thread addentrytodevgui_internal( command );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xe80f
// Size: 0x165
function addentrytodevgui_internal( command )
{
    if ( !isdefined( command ) )
    {
        return;
    }
    
    wait 5;
    
    if ( isdefined( game[ "state" ] ) && game[ "state" ] == "postgame" )
    {
        return;
    }
    
    final_command = "";
    toks = strtok( command, "/" );
    space = " ";
    num_toks = 0;
    
    foreach ( tok in toks )
    {
        new_toks = strtok( tok, " " );
        count = 1;
        size = new_toks.size;
        
        foreach ( new_tok in new_toks )
        {
            if ( count < size )
            {
                final_command = final_command + new_tok + space;
            }
            else
            {
                final_command += new_tok;
            }
            
            count++;
        }
        
        num_toks++;
        
        if ( num_toks < toks.size )
        {
            final_command += "/";
        }
    }
    
    /#
        adddebugcommand( final_command );
    #/
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xe97c
// Size: 0xb6
function array_sort_by_handler( array, compare_func, var_a366e9c50d651873 )
{
    if ( !isdefined( compare_func ) )
    {
        compare_func = &defaultsortfunc;
    }
    
    var_a366e9c50d651873 = istrue( var_a366e9c50d651873 );
    
    for ( i = 0; i < array.size - 1 ; i++ )
    {
        for ( j = i + 1; j < array.size ; j++ )
        {
            if ( var_a366e9c50d651873 )
            {
                if ( array[ j ] [[ compare_func ]]() > array[ i ] [[ compare_func ]]() )
                {
                    ref = array[ j ];
                    array[ j ] = array[ i ];
                    array[ i ] = ref;
                }
                
                continue;
            }
            
            if ( array[ j ] [[ compare_func ]]() < array[ i ] [[ compare_func ]]() )
            {
                ref = array[ j ];
                array[ j ] = array[ i ];
                array[ i ] = ref;
            }
        }
    }
    
    return array;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xea3b
// Size: 0x7f, Type: bool
function array_compare( array1, array2 )
{
    if ( array1.size != array2.size )
    {
        return false;
    }
    
    foreach ( key, member in array1 )
    {
        if ( !isdefined( array2[ key ] ) )
        {
            return false;
        }
        
        member2 = array2[ key ];
        
        if ( member2 != member )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xeac3
// Size: 0x1a
function defaultsortfunc( left, right )
{
    return randomint( 100 );
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0xeae6
// Size: 0xa8
function set_segmented_health_regen_parameters( max_health_cap, min_health_cap, segment_size, pre_regen_wait, per_regen_amount, between_regen_wait )
{
    segmented_health_regen_parameters = spawnstruct();
    segmented_health_regen_parameters.max_health_cap = max_health_cap / 100;
    segmented_health_regen_parameters.min_health_cap = min_health_cap / 100;
    segmented_health_regen_parameters.segment_size = segment_size / 100;
    segmented_health_regen_parameters.pre_regen_wait = pre_regen_wait;
    segmented_health_regen_parameters.per_regen_amount = per_regen_amount / 100;
    segmented_health_regen_parameters.between_regen_wait = between_regen_wait;
    level.segmented_health_regen_parameters = segmented_health_regen_parameters;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xeb96
// Size: 0x43
function set_current_health_regen_segment( player, var_c95d6437e34f366d )
{
    player.current_health_regen_segment_ceiling = int( var_c95d6437e34f366d );
    player.current_health_regen_segment_floor = int( var_c95d6437e34f366d - player.segment_size );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xebe1
// Size: 0xb5
function find_new_health_regen_segment_ceiling( player )
{
    var_143931aa9ab1430d = int( ( player.max_health_cap - player.min_health_cap ) / player.segment_size );
    
    for ( i = 0; i <= var_143931aa9ab1430d + 1 ; i++ )
    {
        new_health_regen_segment_ceiling = player.min_health_cap + i * player.segment_size;
        
        if ( new_health_regen_segment_ceiling >= player.health )
        {
            return int( min( new_health_regen_segment_ceiling, player.maxhealth ) );
        }
    }
    
    assertmsg( "<dev string:x195>" );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xec9e
// Size: 0x15a, Type: bool
function is_friendly_damage( agent, inflictor, attacker )
{
    if ( isdefined( inflictor ) )
    {
        if ( isdefined( inflictor.model ) && inflictor.model == "offhand_wm_at_mine_bomb_cp" )
        {
            return false;
        }
        
        if ( isdefined( attacker ) )
        {
            if ( isdefined( attacker.owner ) && isdefined( attacker.owner.team ) )
            {
                if ( attacker.owner.team != agent.team )
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            
            if ( isdefined( attacker.team ) && isdefined( inflictor.team ) )
            {
                if ( attacker.team != inflictor.team )
                {
                    return false;
                }
            }
        }
        
        if ( isdefined( inflictor.team ) && inflictor.team == agent.team )
        {
            return true;
        }
        
        if ( isdefined( inflictor.owner ) && isdefined( inflictor.owner.team ) && inflictor.owner.team == agent.team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xee01
// Size: 0x54
function vehicle_gethealthbarid()
{
    if ( !isdefined( level.healthbars ) )
    {
        level.healthbars = [];
    }
    
    id = undefined;
    
    for ( i = 0; i < 7 ; i++ )
    {
        if ( !isdefined( level.healthbars[ i ] ) )
        {
            id = i;
            break;
        }
    }
    
    return id;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xee5e
// Size: 0x93
function vehicle_freehealthbarui()
{
    if ( isdefined( self.healthbarid ) )
    {
        var_5838b9cdfb37e6f1 = level.healthbars[ self.healthbarid ];
        var_5838b9cdfb37e6f1 delete();
        setomnvar( "ui_ingame_light_tank_ent_" + self.healthbarid, undefined );
        setomnvar( "ui_ingame_light_tank_health_" + self.healthbarid, 0 );
        setomnvar( "ui_ingame_light_tank_team_" + self.healthbarid, 0 );
        level.healthbars[ self.healthbarid ] = undefined;
        self.healthbarid = undefined;
    }
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0xeef9
// Size: 0x139
function create_waypoint( index, origin, team, shader, alpha, scale )
{
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    waypoint = undefined;
    
    if ( team != "all" )
    {
        waypoint = newteamhudelem( team );
    }
    else
    {
        waypoint = newhudelem();
    }
    
    waypoint.id = index;
    waypoint.x = origin[ 0 ];
    waypoint.y = origin[ 1 ];
    waypoint.z = origin[ 2 ];
    waypoint.team = team;
    waypoint.isflashing = 0;
    waypoint.isshown = 1;
    
    if ( issplitscreen() )
    {
        waypoint setshader( shader, 8, 8 );
    }
    else
    {
        waypoint setshader( shader, 15, 15 );
    }
    
    waypoint setwaypoint( 0, 1, 1 );
    
    if ( isdefined( alpha ) )
    {
        waypoint.alpha = alpha;
    }
    else
    {
        waypoint.alpha = 0.75;
    }
    
    waypoint.basealpha = waypoint.alpha;
    return waypoint;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xf03b
// Size: 0x12
function waypoint_delete( waypoint )
{
    waypoint destroy();
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xf055
// Size: 0xe7
function _freezecontrols( frozen, force, debug )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
    }
    
    if ( frozen )
    {
        assert( !isdefined( force ) );
        self.pers[ "controllerFreezeStack" ]++;
    }
    else if ( istrue( force ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
    }
    else
    {
        self.pers[ "controllerFreezeStack" ]--;
    }
    
    if ( self.pers[ "controllerFreezeStack" ] <= 0 )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self freezecontrols( 0 );
        self.controlsfrozen = 0;
        return;
    }
    
    self freezecontrols( 1 );
    self.controlsfrozen = 1;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xf144
// Size: 0xdf
function _freezelookcontrols( frozen, force )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerLookFreezeStack" ] ) )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
    }
    
    if ( frozen )
    {
        assert( !isdefined( force ) );
        self.pers[ "controllerLookFreezeStack" ]++;
    }
    else if ( istrue( force ) )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
    }
    else
    {
        self.pers[ "controllerLookFreezeStack" ]--;
    }
    
    if ( self.pers[ "controllerLookFreezeStack" ] <= 0 )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
        self freezelookcontrols( 0 );
        self.lookcontrolsfrozen = 0;
        return;
    }
    
    self freezelookcontrols( 1 );
    self.lookcontrolsfrozen = 1;
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0xf22b
// Size: 0x98
function _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    nearstart = max( nearstart, 0 );
    nearend = clamp( nearend, 1, 9994 );
    farstart = clamp( farstart, 2, 9998 );
    farend = clamp( farend, 3, 9999 );
    
    if ( farstart > 9994 )
    {
        farblur = 0;
    }
    
    self setdepthoffield( nearstart, nearend, farstart, farend, nearblur, farblur );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xf2cb
// Size: 0x22
function setdof_killer()
{
    self endon( "disconnect" );
    self.usingcustomdof = 1;
    setdof_killer_update();
    setdof_default();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xf2f5
// Size: 0x1be
function setdof_killer_update()
{
    self endon( "disconnect" );
    self endon( "death_delay_finished" );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    tokiller = vectornormalize( self.origin - self.lastkilledby.origin );
    startpos = self.origin + ( 0, 0, 42 );
    endpos = startpos + tokiller * 120;
    trace = scripts\engine\trace::sphere_trace( startpos, endpos, 2, self, contentoverride, 0 );
    camposition = trace[ "position" ];
    
    while ( istrue( self.usingcustomdof ) )
    {
        if ( !isdefined( self.lastkilledby ) )
        {
            break;
        }
        
        disttotarget = distance( camposition, self.lastkilledby.origin );
        nearstart = 0;
        nearend = max( disttotarget - 12, 1 );
        farstart = disttotarget + 12;
        farend = farstart + 50;
        nearblur = 8;
        farblur = 4.5;
        _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur );
        waitframe();
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xf4bb
// Size: 0x1e
function setdof_default()
{
    self.usingcustomdof = 0;
    _setdof_internal( 0, 0, 512, 512, 4, 0 );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xf4e1
// Size: 0x25
function setdof_cruisethird()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 7, 3.5 );
}

/#

    // Namespace utility / scripts\cp\utility
    // Params 6
    // Checksum 0x0, Offset: 0xf50e
    // Size: 0xc6, Type: dev
    function draw_line_until_endons( org1, r, g, b, var_618807e8cd83ef8, org2 )
    {
        self endon( "<dev string:x1d3>" );
        
        if ( isdefined( var_618807e8cd83ef8 ) )
        {
            if ( isarray( var_618807e8cd83ef8 ) )
            {
                foreach ( end_string in var_618807e8cd83ef8 )
                {
                    self endon( end_string );
                }
            }
            else
            {
                self endon( var_618807e8cd83ef8 );
            }
        }
        
        if ( !isdefined( org2 ) )
        {
            org2 = org1 + ( 0, 0, 256 );
        }
        
        while ( true )
        {
            line( org1, org2, ( r, g, b ), 1 );
            waitframe();
        }
    }

#/

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0xf5dc
// Size: 0x51
function play_sound_on_tag( alias, tag, ends_on_death, var_b426f32755673ba6, radio_dialog )
{
    if ( isdefined( tag ) )
    {
        playsoundatpos( self gettagorigin( tag ), alias );
        return;
    }
    
    playsoundatpos( self.origin, alias );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xf635
// Size: 0x1b
function play_sound_on_entity( alias, var_b426f32755673ba6 )
{
    play_sound_on_tag( alias );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xf658
// Size: 0x10a
function get_point_in_local_ent_space( var_df845bfef23f16ce, offset )
{
    var_5d6805ef12f78ae7 = var_df845bfef23f16ce.origin;
    var_616a6ecc2c2a4eb0 = anglestoup( var_df845bfef23f16ce.angles );
    var_66b10616a68f00f9 = anglestoleft( var_df845bfef23f16ce.angles );
    var_b842cc1147bdb416 = anglestoforward( var_df845bfef23f16ce.angles );
    newx = offset[ 0 ] * var_b842cc1147bdb416[ 0 ] + offset[ 1 ] * var_66b10616a68f00f9[ 0 ] + offset[ 2 ] * var_616a6ecc2c2a4eb0[ 0 ] + var_5d6805ef12f78ae7[ 0 ];
    newy = offset[ 0 ] * var_b842cc1147bdb416[ 1 ] + offset[ 1 ] * var_66b10616a68f00f9[ 1 ] + offset[ 2 ] * var_616a6ecc2c2a4eb0[ 1 ] + var_5d6805ef12f78ae7[ 1 ];
    newz = offset[ 0 ] * var_b842cc1147bdb416[ 2 ] + offset[ 1 ] * var_66b10616a68f00f9[ 2 ] + offset[ 2 ] * var_616a6ecc2c2a4eb0[ 2 ] + var_5d6805ef12f78ae7[ 2 ];
    newpos = ( newx, newy, newz );
    return newpos;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xf76b
// Size: 0x62
function remove_cursor_hint()
{
    hintent = self;
    
    if ( isdefined( self.cursor_hint_ent ) )
    {
        hintent = self.cursor_hint_ent;
        hintent delaycall( 0.5, &delete );
    }
    
    if ( isdefined( hintent ) && !isstruct( hintent ) )
    {
        hintent makeunusable();
    }
    
    if ( isdefined( self ) )
    {
        notify_delay( "hint_destroyed", 0.05 );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0xf7d5
// Size: 0x4d
function notify_delay( snotifystring, fdelay )
{
    assert( isdefined( self ) );
    assert( isdefined( snotifystring ) );
    assert( isdefined( fdelay ) );
    self endon( "death" );
    
    if ( fdelay > 0 )
    {
        wait fdelay;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( snotifystring );
}

// Namespace utility / scripts\cp\utility
// Params 14
// Checksum 0x0, Offset: 0xf82a
// Size: 0x385
function create_cursor_hint( linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, usedistoverride, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride )
{
    hintent = self;
    
    if ( isstruct( hintent ) || hintent.classname == "script_origin" || isdefined( originoffset ) )
    {
        hintent = spawn( "script_origin", self.origin );
        self.cursor_hint_ent = hintent;
        thread hint_ent_notify_trigger();
    }
    
    hintent makeusable();
    
    if ( isdefined( originoffset ) )
    {
        tag = "tag_origin";
        
        if ( isdefined( linktag ) )
        {
            tag = linktag;
            
            if ( linktag == "" )
            {
                hintent.origin = self.origin;
            }
            else
            {
                hintent.origin = self gettagorigin( tag );
            }
        }
        
        if ( isdefined( self.model ) && self.classname == "script_model" && hastag( self.model, tag ) )
        {
            hintent linkto( self, tag, originoffset, ( 0, 0, 0 ) );
        }
        else if ( isdefined( linktag ) )
        {
            hintent linkto( self, tag, originoffset, ( 0, 0, 0 ) );
        }
        else if ( isdefined( self.angles ) )
        {
            hintent.origin += rotatevector( originoffset, self.angles );
            
            if ( isent( self ) )
            {
                hintent linkto( self );
            }
        }
        else
        {
            hintent.origin += originoffset;
            
            if ( isent( self ) )
            {
                hintent linkto( self );
            }
        }
    }
    else if ( isdefined( linktag ) )
    {
        hintent sethinttag( linktag );
    }
    
    if ( isdefined( var_9e9b6d24b7a157f0 ) && var_9e9b6d24b7a157f0 )
    {
        hintent setcursorhint( "HINT_NOICON" );
    }
    else
    {
        hintent setcursorhint( "HINT_BUTTON" );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintent sethintstring( hintstring );
    }
    
    displayfov = 360;
    
    if ( isdefined( displayfovoverride ) )
    {
        displayfov = displayfovoverride;
    }
    
    hintent sethintdisplayfov( displayfov );
    usefov = 65;
    
    if ( isdefined( usefovoverride ) )
    {
        usefov = usefovoverride;
    }
    
    hintent setusefov( usefov );
    displayrange = 500;
    
    if ( isdefined( displaydistoverride ) )
    {
        displayrange = displaydistoverride;
    }
    
    hintent sethintdisplayrange( displayrange );
    userange = 80;
    
    if ( isdefined( usedistoverride ) )
    {
        userange = usedistoverride;
    }
    
    hintent setuserange( userange );
    
    if ( isdefined( ignoretrace ) && ignoretrace )
    {
        hintent sethintonobstruction( "show" );
    }
    else
    {
        hintent sethintonobstruction( "hide" );
    }
    
    if ( isdefined( blinkhint ) && blinkhint )
    {
        hintent sethintrequiresmashing( blinkhint );
    }
    
    if ( !isdefined( holdduration ) )
    {
        holdduration = "duration_short";
    }
    
    hintent setuseholdduration( holdduration );
    
    if ( holdduration == "duration_medium" || holdduration == "duration_long" )
    {
        hintent sethintrequiresholding( 1 );
    }
    
    thread hint_delete_on_trigger();
    
    if ( isdefined( uniqueicon ) )
    {
        hintent sethinticon( uniqueicon );
    }
    
    if ( isdefined( usecommand ) )
    {
        hintent setusecommand( usecommand );
    }
    
    if ( isdefined( lockmovement ) )
    {
        hintent sethintlockplayermovement( 1 );
    }
    else
    {
        hintent sethintlockplayermovement( 0 );
    }
    
    return hintent;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xfbb8
// Size: 0x34
function hint_ent_notify_trigger()
{
    self endon( "death" );
    self endon( "hint_destroyed" );
    self.cursor_hint_ent waittill( "trigger", who );
    self notify( "trigger", who );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xfbf4
// Size: 0x3d
function hint_delete_on_trigger()
{
    self endon( "hint_destroyed" );
    hintent = self;
    
    if ( isdefined( self.cursor_hint_ent ) )
    {
        hintent = self.cursor_hint_ent;
    }
    
    hint_delete_on_trigger_waittill( hintent );
    thread remove_cursor_hint();
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0xfc39
// Size: 0x1a
function hint_delete_on_trigger_waittill( hintent )
{
    self endon( "entitydeleted" );
    hintent waittill( "trigger" );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xfc5b
// Size: 0x26
function outline_fade_alpha_for_index( index, alpha, time )
{
    thread outline_fade_alpha_for_index_internal( index, alpha, time );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0xfc89
// Size: 0x10f
function outline_fade_alpha_for_index_internal( index, alpha, time )
{
    level notify( "hud_outline_alpha_fade_" + index );
    level endon( "hud_outline_alpha_fade_" + index );
    index++;
    dvarstr = hashcat( @"hash_1429c8e20321bbcd", index );
    var_4486ff9d1102f083 = getdvar( dvarstr );
    var_4486ff9d1102f083 = strtok( var_4486ff9d1102f083, " " );
    dvarvalprefix = var_4486ff9d1102f083[ 0 ] + " " + var_4486ff9d1102f083[ 1 ] + " " + var_4486ff9d1102f083[ 2 ] + " ";
    currentalpha = float( var_4486ff9d1102f083[ 3 ] );
    range = alpha - currentalpha;
    interval = 0.05;
    count = int( time / interval );
    
    if ( count > 0 )
    {
        delta = range / count;
        
        while ( count )
        {
            currentalpha += delta;
            currentalpha = clamp( currentalpha, 0, 1 );
            wait interval;
            count--;
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0xfda0
// Size: 0x127
function add_wait( func, parm1, parm2, parm3 )
{
    init_waits();
    
    /#
        thread add_wait_asserter();
    #/
    
    ent = spawnstruct();
    ent.caller = self;
    ent.func = func;
    ent.parms = [];
    
    if ( isdefined( parm1 ) )
    {
        ent.parms[ ent.parms.size ] = parm1;
    }
    
    if ( isdefined( parm2 ) )
    {
        ent.parms[ ent.parms.size ] = parm2;
    }
    
    if ( isdefined( parm3 ) )
    {
        ent.parms[ ent.parms.size ] = parm3;
    }
    
    if ( !isdefined( level.waits.wait_any_func_array ) )
    {
        level.waits.wait_any_func_array = [ ent ];
        return;
    }
    
    level.waits.wait_any_func_array[ level.waits.wait_any_func_array.size ] = ent;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xfecf
// Size: 0xa2
function init_waits()
{
    if ( !add_init_script( "waits", &init_waits ) )
    {
        return;
    }
    
    level.waits = spawnstruct();
    level.waits.wait_any_func_array = [];
    level.waits.run_func_after_wait_array = [];
    level.waits.run_call_after_wait_array = [];
    level.waits.run_noself_call_after_wait_array = [];
    level.waits.do_wait_endons_array = [];
    level.waits.abort_wait_any_func_array = [];
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xff79
// Size: 0x39
function add_wait_asserter()
{
    level notify( "kill_add_wait_asserter" );
    level endon( "kill_add_wait_asserter" );
    
    for ( i = 0; i < 20 ; i++ )
    {
        waittillframeend();
    }
    
    assertmsg( "Added a wait or func and then didn't do_wait immediately." );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0xffba
// Size: 0x6d
function do_wait_any()
{
    init_waits();
    assertex( isdefined( level.waits.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
    assertex( level.waits.wait_any_func_array.size > 0, "Tried to do a do_wait without addings funcs first" );
    do_wait( level.waits.wait_any_func_array.size - 1 );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x1002f
// Size: 0x20c
function do_wait( var_ff009ed2debc01c4 )
{
    init_waits();
    
    if ( !isdefined( var_ff009ed2debc01c4 ) )
    {
        var_ff009ed2debc01c4 = 0;
    }
    
    /#
        level notify( "<dev string:x1d9>" );
    #/
    
    assertex( isdefined( level.waits.wait_any_func_array ), "Tried to do a do_wait without addings funcs first" );
    ent = spawnstruct();
    array = level.waits.wait_any_func_array;
    endons = level.waits.do_wait_endons_array;
    after_array = level.waits.run_func_after_wait_array;
    call_array = level.waits.run_call_after_wait_array;
    var_953b218366c91a88 = level.waits.run_noself_call_after_wait_array;
    abort_array = level.waits.abort_wait_any_func_array;
    level.waits.wait_any_func_array = [];
    level.waits.run_func_after_wait_array = [];
    level.waits.do_wait_endons_array = [];
    level.waits.abort_wait_any_func_array = [];
    level.waits.run_call_after_wait_array = [];
    level.waits.run_noself_call_after_wait_array = [];
    ent.count = array.size;
    ent array_levelthread( array, &waittill_func_ends, endons );
    ent thread do_abort( abort_array );
    ent endon( "any_funcs_aborted" );
    
    for ( ;; )
    {
        if ( ent.count <= var_ff009ed2debc01c4 )
        {
            break;
        }
        
        ent waittill( "func_ended" );
    }
    
    ent notify( "all_funcs_ended" );
    array_levelthread( after_array, &exec_func, [] );
    array_levelthread( call_array, &exec_call );
    array_levelthread( var_953b218366c91a88, &exec_call_noself );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x10243
// Size: 0x1e8
function exec_call( func )
{
    if ( func.parms.size == 0 )
    {
        func.caller builtin [[ func.func ]]();
    }
    else if ( func.parms.size == 1 )
    {
        func.caller builtin [[ func.func ]]( func.parms[ 0 ] );
    }
    else if ( func.parms.size == 2 )
    {
        func.caller builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ] );
    }
    else if ( func.parms.size == 3 )
    {
        func.caller builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ] );
    }
    
    if ( func.parms.size == 4 )
    {
        func.caller builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ], func.parms[ 3 ] );
    }
    
    if ( func.parms.size == 5 )
    {
        func.caller builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ], func.parms[ 3 ], func.parms[ 4 ] );
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x10433
// Size: 0x1a6
function exec_call_noself( func )
{
    if ( func.parms.size == 0 )
    {
        builtin [[ func.func ]]();
    }
    else if ( func.parms.size == 1 )
    {
        builtin [[ func.func ]]( func.parms[ 0 ] );
    }
    else if ( func.parms.size == 2 )
    {
        builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ] );
    }
    else if ( func.parms.size == 3 )
    {
        builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ] );
    }
    
    if ( func.parms.size == 4 )
    {
        builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ], func.parms[ 3 ] );
    }
    
    if ( func.parms.size == 5 )
    {
        builtin [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ], func.parms[ 3 ], func.parms[ 4 ] );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x105e1
// Size: 0x22e
function exec_func( func, endons )
{
    if ( !isdefined( func.caller ) )
    {
        return;
    }
    
    for ( i = 0; i < endons.size ; i++ )
    {
        endons[ i ].caller endon( endons[ i ].ender );
    }
    
    if ( func.parms.size == 0 )
    {
        func.caller [[ func.func ]]();
    }
    else if ( func.parms.size == 1 )
    {
        func.caller [[ func.func ]]( func.parms[ 0 ] );
    }
    else if ( func.parms.size == 2 )
    {
        func.caller [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ] );
    }
    else if ( func.parms.size == 3 )
    {
        func.caller [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ] );
    }
    
    if ( func.parms.size == 4 )
    {
        func.caller [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ], func.parms[ 3 ] );
    }
    
    if ( func.parms.size == 5 )
    {
        func.caller [[ func.func ]]( func.parms[ 0 ], func.parms[ 1 ], func.parms[ 2 ], func.parms[ 3 ], func.parms[ 4 ] );
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x10817
// Size: 0x6d
function do_abort( array )
{
    self endon( "all_funcs_ended" );
    
    if ( !array.size )
    {
        return;
    }
    
    var_ff009ed2debc01c4 = 0;
    self.abort_count = array.size;
    endons = [];
    array_levelthread( array, &waittill_abort_func_ends, endons );
    
    for ( ;; )
    {
        if ( self.abort_count <= var_ff009ed2debc01c4 )
        {
            break;
        }
        
        self waittill( "abort_func_ended" );
    }
    
    self notify( "any_funcs_aborted" );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1088c
// Size: 0x3c
function waittill_abort_func_ends( func, endons )
{
    self endon( "all_funcs_ended" );
    self endon( "any_funcs_aborted" );
    exec_func( func, endons );
    self.abort_count--;
    self notify( "abort_func_ended" );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x108d0
// Size: 0x3c
function waittill_func_ends( func, endons )
{
    self endon( "all_funcs_ended" );
    self endon( "any_funcs_aborted" );
    exec_func( func, endons );
    self.count--;
    self notify( "func_ended" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x10914
// Size: 0xf
function waittill_msg( msg )
{
    self waittill( msg );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x1092b
// Size: 0xd1
function create_client_overlay( shader_name, start_alpha, player )
{
    if ( isdefined( player ) )
    {
        overlay = newclienthudelem( player );
    }
    else
    {
        overlay = newhudelem();
    }
    
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( shader_name, 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    return overlay;
}

// Namespace utility / scripts\cp\utility
// Params 12
// Checksum 0x0, Offset: 0x10a05
// Size: 0xb6
function createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent )
{
    hintobj = undefined;
    
    if ( isdefined( useent ) )
    {
        hintobj = useent;
    }
    else
    {
        hintobj = spawn( "script_model", hintpos );
    }
    
    hintobj sethintobject( undefined, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov );
    
    if ( !isdefined( priority ) )
    {
        hintobj setusepriority( 0 );
    }
    
    if ( !isdefined( useent ) )
    {
        return hintobj;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x10ac3
// Size: 0xb
function clearhintobject( useent )
{
    
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x10ad6
// Size: 0x269
function get_actual_time_from_civil( var_3e15975815788ef2, var_8cc6d68123ab5ebc, var_ac934600955e8206 )
{
    level endon( "game_ended" );
    
    if ( isdefined( var_8cc6d68123ab5ebc ) )
    {
        seconds = var_8cc6d68123ab5ebc;
    }
    else
    {
        seconds = getsystemtime();
        
        if ( isdefined( level.isdaylightsavings ) && level.isdaylightsavings )
        {
            seconds += 3600;
        }
    }
    
    if ( isdefined( var_3e15975815788ef2 ) )
    {
        seconds -= 3600 * var_3e15975815788ef2;
    }
    
    year = 1970;
    years = floor( seconds / 31536000 );
    
    if ( years != 0 )
    {
        var_eed48d9a89e19294 = floor( ( years + 2 ) / 4 );
    }
    else
    {
        var_eed48d9a89e19294 = 0;
    }
    
    seconds -= years * 31536000;
    seconds -= var_eed48d9a89e19294 * 86400;
    year += years;
    
    if ( !is_divisible_by( year, 4 ) )
    {
        var_4c8bf90e649eed71 = floor( years / 4 );
        var_3b07193517647dd1 = years / 4;
        tester = var_3b07193517647dd1 - var_4c8bf90e649eed71;
        
        if ( tester >= 0.75 )
        {
            var_3c190bbe9cbb729a = 1;
        }
        else
        {
            var_3c190bbe9cbb729a = 0;
        }
    }
    else
    {
        var_3c190bbe9cbb729a = 0;
    }
    
    if ( seconds != 0 )
    {
        days = floor( seconds / 86400 );
        seconds -= days * 86400;
    }
    else
    {
        days = 0;
    }
    
    if ( seconds != 0 )
    {
        hours = floor( seconds / 3600 );
        seconds -= hours * 3600;
    }
    else
    {
        hours = 0;
    }
    
    if ( seconds != 0 )
    {
        minutes = floor( seconds / 60 );
        seconds -= minutes * 60;
    }
    else
    {
        minutes = 0;
    }
    
    info = determine_correct_month( days + 1, var_3c190bbe9cbb729a );
    info[ "year" ] = year;
    info[ "hours" ] = hours;
    info[ "minutes" ] = minutes;
    info[ "seconds" ] = seconds;
    
    if ( isdefined( var_ac934600955e8206 ) )
    {
        return info;
    }
    
    if ( isdefined( level.isdaylightsavings ) )
    {
        level notify( "time_check", year, info[ "month_string" ], info[ "days" ], hours, minutes, seconds );
        return info;
    }
    
    info = is_daylight_savings( info, var_3e15975815788ef2, var_8cc6d68123ab5ebc );
    level notify( "time_check", year, info[ "month_string" ], info[ "days" ], hours, minutes, seconds );
    return info;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x10d47
// Size: 0x122
function is_daylight_savings( info, var_3e15975815788ef2, var_8cc6d68123ab5ebc )
{
    var_8ef55833da748cc6 = 0;
    
    if ( info[ "month_string" ] == "March" && info[ "year" ] == 2017 )
    {
        var_8ef55833da748cc6 = 1;
    }
    else if ( info[ "month_string" ] == "December" || info[ "month_string" ] == "January" || info[ "month_string" ] == "February" )
    {
        var_8ef55833da748cc6 = 0;
    }
    else if ( info[ "month_string" ] != "March" && info[ "month_string" ] != "April" )
    {
        var_8ef55833da748cc6 = 1;
    }
    else if ( info[ "month_string" ] == "March" && info[ "days" ] >= 14 )
    {
        var_8ef55833da748cc6 = 1;
    }
    else if ( info[ "month_string" ] == "November" && info[ "days" ] <= 6 )
    {
        var_8ef55833da748cc6 = 0;
    }
    else
    {
        var_8ef55833da748cc6 = 0;
    }
    
    if ( var_8ef55833da748cc6 )
    {
        level.isdaylightsavings = 1;
        info = get_actual_time_from_civil( var_3e15975815788ef2, var_8cc6d68123ab5ebc, 1 );
    }
    else
    {
        level.isdaylightsavings = 0;
    }
    
    return info;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x10e72
// Size: 0x29e
function determine_correct_month( days, var_3c190bbe9cbb729a )
{
    info = [];
    info[ "month" ] = undefined;
    info[ "month_string" ] = undefined;
    info[ "days" ] = undefined;
    var_555894a437cb7632 = int( istrue( var_3c190bbe9cbb729a ) );
    
    if ( days <= 31 )
    {
        info[ "month" ] = 1;
        info[ "month_string" ] = "January";
        info[ "days" ] = days;
        return info;
    }
    
    if ( days <= 59 + var_555894a437cb7632 )
    {
        info[ "month" ] = 2;
        info[ "month_string" ] = "February";
        info[ "days" ] = days - 31;
        return info;
    }
    
    if ( days <= 90 + var_555894a437cb7632 )
    {
        info[ "month" ] = 3;
        info[ "month_string" ] = "March";
        info[ "days" ] = days - 59 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 120 + var_555894a437cb7632 )
    {
        info[ "month" ] = 4;
        info[ "month_string" ] = "April";
        info[ "days" ] = days - 90 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 151 + var_555894a437cb7632 )
    {
        info[ "month" ] = 5;
        info[ "month_string" ] = "May";
        info[ "days" ] = days - 120 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 182 + var_555894a437cb7632 )
    {
        info[ "month" ] = 6;
        info[ "month_string" ] = "June";
        info[ "days" ] = days - 151 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 212 + var_555894a437cb7632 )
    {
        info[ "month" ] = 7;
        info[ "month_string" ] = "July";
        info[ "days" ] = days - 182 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 243 + var_555894a437cb7632 )
    {
        info[ "month" ] = 8;
        info[ "month_string" ] = "August";
        info[ "days" ] = days - 212 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 273 + var_555894a437cb7632 )
    {
        info[ "month" ] = 9;
        info[ "month_string" ] = "September";
        info[ "days" ] = days - 243 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 304 + var_555894a437cb7632 )
    {
        info[ "month" ] = 10;
        info[ "month_string" ] = "Octobor";
        info[ "days" ] = days - 273 + var_555894a437cb7632;
        return info;
    }
    
    if ( days <= 335 + var_555894a437cb7632 )
    {
        info[ "month" ] = 11;
        info[ "month_string" ] = "November";
        info[ "days" ] = days - 304 + var_555894a437cb7632;
        return info;
    }
    
    info[ "month" ] = 12;
    info[ "month_string" ] = "December";
    info[ "days" ] = days - 335 + var_555894a437cb7632;
    return info;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x11118
// Size: 0x27
function set_friendlyfire_warnings( state )
{
    if ( state )
    {
        self.friendlyfire_warnings_disable = undefined;
        return;
    }
    
    self.friendlyfire_warnings_disable = 1;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x11147
// Size: 0x43
function battlechatter_off( team )
{
    if ( !isdefined( team ) )
    {
        level.battlechatterdisabled = 1;
        return;
    }
    
    if ( !isdefined( level.battlechatterdisabledteams ) )
    {
        level.battlechatterdisabledteams = [];
    }
    
    level.battlechatterdisabledteams[ team ] = 1;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x11192
// Size: 0x49
function battlechatter_on( team )
{
    if ( !isdefined( level.battlechatter ) )
    {
        scripts\anim\battlechatter::init_battlechatter();
    }
    
    if ( !isdefined( team ) )
    {
        level.battlechatterdisabled = undefined;
        return;
    }
    
    if ( isdefined( level.battlechatterdisabledteams ) )
    {
        level.battlechatterdisabledteams[ team ] = undefined;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x111e3
// Size: 0x7
function getvehiclearray()
{
    return vehicle_getarray();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x111f3
// Size: 0x38
function get_player_from_self()
{
    if ( isdefined( self ) )
    {
        if ( !array_contains( level.players, self ) )
        {
            return level.player;
        }
        else
        {
            return self;
        }
        
        return;
    }
    
    return level.players[ 0 ];
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x11233
// Size: 0xe2
function player_looking_at( start, dot, dot_only, ignore_ent )
{
    if ( !isdefined( dot ) )
    {
        dot = 0.8;
    }
    
    player = get_player_from_self();
    end = player geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    player_angles = player getplayerangles();
    player_forward = anglestoforward( player_angles );
    new_dot = vectordot( forward, player_forward );
    
    if ( new_dot < dot )
    {
        return 0;
    }
    
    if ( isdefined( dot_only ) )
    {
        assertex( dot_only, "dot_only must be true or undefined" );
        return 1;
    }
    
    return ray_trace_detail_passed( start, end, ignore_ent, create_default_contents( 1 ) );
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x1131e
// Size: 0xe3
function function_174cb7c7e99e8032( dot, dot_only, ignore_ent )
{
    if ( !isdefined( dot ) )
    {
        dot = 0.8;
    }
    
    start = level.player geteye();
    end = self geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    ai_angles = self.angles;
    ai_forward = anglestoforward( ai_angles );
    new_dot = vectordot( forward, ai_forward );
    
    if ( new_dot < dot )
    {
        return 0;
    }
    
    if ( isdefined( dot_only ) )
    {
        assertex( dot_only, "dot_only must be true or undefined" );
        return 1;
    }
    
    return ray_trace_detail_passed( start, end, ignore_ent, create_default_contents( 1 ) );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1140a
// Size: 0x2a
function is_divisible_by( dividend, divisor )
{
    if ( floor( dividend / divisor ) > dividend / divisor )
    {
        return 1;
    }
    
    return 0;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1143c
// Size: 0xe8
function array_merge( array1, array2 )
{
    if ( array1.size == 0 )
    {
        return array2;
    }
    
    if ( array2.size == 0 )
    {
        return array1;
    }
    
    newarray = array1;
    
    foreach ( array2_ent in array2 )
    {
        foundmatch = 0;
        
        foreach ( array1_ent in array1 )
        {
            if ( array1_ent == array2_ent )
            {
                foundmatch = 1;
                break;
            }
        }
        
        if ( foundmatch )
        {
            continue;
        }
        
        newarray[ newarray.size ] = array2_ent;
    }
    
    return newarray;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1152d
// Size: 0x42
function vectortoanglessafe( forward, up )
{
    right = vectorcross( forward, up );
    up = vectorcross( right, forward );
    angles = axistoangles( forward, right, up );
    return angles;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x11578
// Size: 0x58
function createuseent( pos )
{
    useent = spawn( "script_origin", pos );
    useent.curprogress = 0;
    useent.usetime = 0;
    useent.userate = 8000;
    useent.inuse = 0;
    return useent;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x115d9
// Size: 0x67
function getinteractionbynoteworthy( script_noteworthy )
{
    foreach ( interactionstruct in level.current_interaction_structs )
    {
        if ( interactionstruct.script_noteworthy == script_noteworthy )
        {
            return interactionstruct;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x11649
// Size: 0x21
function quicksort( array, compare_func )
{
    return quicksortmid( array, 0, array.size - 1, compare_func );
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x11673
// Size: 0x112
function quicksortmid( array, start, end, compare_func )
{
    i = start;
    k = end;
    
    if ( !isdefined( compare_func ) )
    {
        compare_func = &quicksort_compare;
    }
    
    if ( end - start >= 1 )
    {
        pivot = array[ start ];
        
        while ( k > i )
        {
            while ( [[ compare_func ]]( array[ i ].patrolscore, pivot.patrolscore ) && i <= end && k > i )
            {
                i++;
            }
            
            while ( ![[ compare_func ]]( array[ k ].patrolscore, pivot.patrolscore ) && k >= start && k >= i )
            {
                k--;
            }
            
            if ( k > i )
            {
                array = swap( array, i, k );
            }
        }
        
        array = swap( array, start, k );
        array = quicksortmid( array, start, k - 1, compare_func );
        array = quicksortmid( array, k + 1, end, compare_func );
    }
    else
    {
        return array;
    }
    
    return array;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1178e
// Size: 0x16, Type: bool
function quicksort_compare( left, right )
{
    return left <= right;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x117ad
// Size: 0x36
function swap( array, index1, index2 )
{
    temp = array[ index1 ];
    array[ index1 ] = array[ index2 ];
    array[ index2 ] = temp;
    return array;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x117ec
// Size: 0x98
function hideminimap( forcehide )
{
    if ( !isdefined( self.minimapstatetracker ) )
    {
        self.minimapstatetracker = 0;
    }
    
    var_5546bbd6b68a186d = self.minimapstatetracker;
    self.minimapstatetracker--;
    
    if ( self.minimapstatetracker < 0 )
    {
        self.minimapstatetracker = 0;
    }
    
    if ( istrue( forcehide ) || self.minimapstatetracker == 0 && var_5546bbd6b68a186d > self.minimapstatetracker )
    {
        self setclientomnvar( "ui_hide_minimap", 1 );
        
        if ( istrue( forcehide ) )
        {
            self.minimapstatetracker = 0;
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1188c
// Size: 0x7b
function showminimap()
{
    if ( scripts\cp\utility::is_minimap_forcedisabled() )
    {
        /#
            self iprintln( "<dev string:x1f0>" );
        #/
        
        return;
    }
    
    if ( !isdefined( self.minimapstatetracker ) )
    {
        self.minimapstatetracker = 0;
    }
    
    var_5546bbd6b68a186d = self.minimapstatetracker;
    self.minimapstatetracker++;
    
    if ( self.minimapstatetracker == 1 && var_5546bbd6b68a186d < self.minimapstatetracker )
    {
        self setclientomnvar( "ui_hide_minimap", 0 );
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1190f
// Size: 0x7
function getplayerdataloadoutgroup()
{
    return "cploadouts";
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x1191f
// Size: 0x83
function getplayersinteam( team )
{
    if ( !isdefined( team ) )
    {
        team = "allies";
    }
    
    playersinteam = [];
    
    foreach ( player in level.players )
    {
        if ( player.team == team )
        {
            playersinteam[ playersinteam.size ] = player;
        }
    }
    
    return playersinteam;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x119ab
// Size: 0x59, Type: bool
function function_95e3a48dbaf38216()
{
    foreach ( player in level.players )
    {
        if ( player function_98ccab873f262dbe() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x11a0d
// Size: 0x9, Type: bool
function function_98ccab873f262dbe()
{
    return !self haslastgroundorigin();
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x11a1f
// Size: 0x124
function teleportallplayersinteamtostructs( team, structs_targetname, var_82e908ebd15ba4cc )
{
    playerpos = getstructarray( structs_targetname, "targetname" );
    
    if ( !isdefined( playerpos ) || playerpos.size < 4 )
    {
        return;
    }
    
    flag_wait( "player_spawned_with_loadout" );
    index = 0;
    
    foreach ( player in getplayersinteam( team ) )
    {
        playerpos[ index ].angles = ter_op( isdefined( playerpos[ index ].angles ), playerpos[ index ].angles, ( 0, 0, 0 ) );
        player setorigin( playerpos[ index ].origin );
        player setplayerangles( playerpos[ index ].angles );
        player dontinterpolate();
        index++;
    }
    
    if ( !istrue( var_82e908ebd15ba4cc ) )
    {
        return;
    }
    
    level thread thread_teleportplayertoteamstructs_latejoin( team, structs_targetname );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x11b4b
// Size: 0x53
function thread_teleportplayertoteamstructs_latejoin( team, structs_targetname )
{
    level endon( "game_ended" );
    level notify( "waiting_for_team_teleports_" + team );
    level endon( "waiting_for_team_teleports_" + team );
    
    while ( true )
    {
        level waittill( "connected", newplayer );
        level thread teleportplayertoteamstructs_latejoin( newplayer, structs_targetname );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x11ba6
// Size: 0x2c
function teleportplayertoteamstructs_latejoin( newplayer, structs_targetname )
{
    newplayer endon( "disconnect" );
    newplayer waittill( "spawned_player" );
    waitframe();
    teleportplayertoteamstructs( newplayer, structs_targetname );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x11bda
// Size: 0xb8
function teleportplayertoteamstructs( player, structs_targetname )
{
    playerpos = getstructarray( structs_targetname, "targetname" );
    
    if ( !isdefined( playerpos ) || playerpos.size < 4 )
    {
        return;
    }
    
    index = randomintrange( 0, playerpos.size );
    playerpos[ index ].angles = ter_op( isdefined( playerpos[ index ].angles ), playerpos[ index ].angles, ( 0, 0, 0 ) );
    player setorigin( playerpos[ index ].origin );
    player setplayerangles( playerpos[ index ].angles );
    player dontinterpolate();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x11c9a
// Size: 0x56
function init_vehicle_omnvars()
{
    self setclientomnvar( "ui_veh_vehicle", -1 );
    self setclientomnvar( "ui_veh_occupant_0", -1 );
    self setclientomnvar( "ui_veh_occupant_1", -1 );
    self setclientomnvar( "ui_veh_occupant_2", -1 );
    self setclientomnvar( "ui_veh_occupant_3", -1 );
    self setclientomnvar( "ui_veh_occupant_4", -1 );
}

/#

    // Namespace utility / scripts\cp\utility
    // Params 2
    // Checksum 0x0, Offset: 0x11cf8
    // Size: 0x88, Type: dev
    function printgameaction( msg, player )
    {
        if ( getdvarint( @"hash_dd6678cdc48d6adf", 0 ) == 1 )
        {
            return;
        }
        
        playerstring = "<dev string:x144>";
        
        if ( isdefined( player ) )
        {
            playerstring = "<dev string:x252>" + player getentitynumber() + "<dev string:x254>" + player.name + "<dev string:x256>";
        }
        
        println( "<dev string:x259>" + playerstring + msg + "<dev string:x25e>" + gettime() + "<dev string:x261>" );
    }

#/

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x11d88
// Size: 0xe, Type: bool
function isplayerads()
{
    return self playerads() > 0.5;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x11d9f
// Size: 0x22, Type: bool
function isairdenied()
{
    if ( isai( self ) )
    {
        return false;
    }
    
    if ( self.team == "spectator" )
    {
        return false;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x11dca
// Size: 0x91
function get_center_point_of_array( array )
{
    center = ( 0, 0, 0 );
    
    for ( i = 0; i < array.size ; i++ )
    {
        center = ( center[ 0 ] + array[ i ].origin[ 0 ], center[ 1 ] + array[ i ].origin[ 1 ], center[ 2 ] + array[ i ].origin[ 2 ] );
    }
    
    return ( center[ 0 ] / array.size, center[ 1 ] / array.size, center[ 2 ] / array.size );
}

// Namespace utility / scripts\cp\utility
// Params 11
// Checksum 0x0, Offset: 0x11e64
// Size: 0x19e
function sethintobject( hinttag, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    self makeusable();
    
    if ( isdefined( hinttag ) )
    {
        self sethinttag( hinttag );
    }
    
    if ( isdefined( hinttype ) )
    {
        self setcursorhint( hinttype );
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( hinticon ) )
    {
        self sethinticon( hinticon );
    }
    
    if ( isdefined( hintstring ) )
    {
        self sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        priority = int( clamp( priority, -10, 1 ) );
        self setusepriority( priority );
    }
    else
    {
        self setusepriority( -10 );
    }
    
    if ( isdefined( duration ) )
    {
        self setuseholdduration( duration );
        
        if ( isstring( duration ) && ( duration == "duration_medium" || duration == "duration_long" ) )
        {
            self sethintrequiresholding( 1 );
        }
    }
    else
    {
        self setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        self sethintonobstruction( onobstruction );
    }
    else
    {
        self sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        self sethintdisplayrange( hintdist );
    }
    else
    {
        self sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        self sethintdisplayfov( hintfov );
    }
    else
    {
        self sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        self setuserange( usedist );
    }
    else
    {
        self setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        self setusefov( usefov );
        return;
    }
    
    self setusefov( 120 );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x1200a
// Size: 0xc9
function is_indoors( target )
{
    isindoors = 0;
    targetpos = ( 0, 0, 0 );
    
    if ( isent( target ) )
    {
        targetpos = target.origin;
    }
    else if ( isvector( target ) )
    {
        targetpos = target;
    }
    else if ( isstruct( target ) )
    {
        assertex( isdefined( target.origin ), "Please specify an origin for the struct passed into is_indoors(struct)" );
        targetpos = target.origin;
    }
    
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1 );
    
    if ( !scripts\engine\trace::ray_trace_passed( targetpos, targetpos + ( 0, 0, 10000 ), undefined, contents ) )
    {
        isindoors = 1;
    }
    
    return isindoors;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x120dc
// Size: 0xc8
function is_indoors_vehicleignored( target )
{
    isindoors = 0;
    targetpos = ( 0, 0, 0 );
    
    if ( isent( target ) )
    {
        targetpos = target.origin;
    }
    else if ( isvector( target ) )
    {
        targetpos = target;
    }
    else if ( isstruct( target ) )
    {
        assertex( isdefined( target.origin ), "Please specify an origin for the struct passed into is_indoors(struct)" );
        targetpos = target.origin;
    }
    
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1, 1 );
    
    if ( !scripts\engine\trace::ray_trace_passed( targetpos, targetpos + ( 0, 0, 10000 ), undefined, contents ) )
    {
        isindoors = 1;
    }
    
    return isindoors;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x121ad
// Size: 0x5d
function isgesture( weapon )
{
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon;
    }
    
    if ( issubstr( weaponname, "ges_plyr" ) )
    {
        return 1;
    }
    
    if ( issubstr( weaponname, "devilhorns_mp" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x12212
// Size: 0x325
function demo_button_combo_debug_watcher()
{
    self endon( "disconnect" );
    
    if ( !isdefined( self.debug_button_combos ) )
    {
        setup_debug_button_combos_for_player();
    }
    
    self notifyonplayercommand( "up", "+actionslot 1" );
    self notifyonplayercommand( "up_release", "-actionslot 1" );
    self notifyonplayercommand( "down", "+actionslot 2" );
    self notifyonplayercommand( "down_release", "-actionslot 2" );
    self notifyonplayercommand( "use", "+usereload" );
    self notifyonplayercommand( "use", "+activate" );
    self notifyonplayercommand( "use_release", "-usereload" );
    self notifyonplayercommand( "use_release", "-activate" );
    self notifyonplayercommand( "stance", "+stance" );
    self notifyonplayercommand( "stance_release", "-stance" );
    self notifyonplayercommand( "ads", "+speed_throw" );
    self notifyonplayercommand( "ads_release", "-speed_throw" );
    self notifyonplayercommand( "attack", "+attack" );
    self notifyonplayercommand( "attack_release", "-attack" );
    self notifyonplayercommand( "touchpad", "+focus" );
    self notifyonplayercommand( "touchpad", "+togglescores" );
    self notifyonplayercommand( "touchpad", "togglescores" );
    self notifyonplayercommand( "touchpad_release", "-focus" );
    self notifyonplayercommand( "touchpad_release", "-togglescores" );
    self notifyonplayercommand( "swap_weapon", "+weapnext" );
    self notifyonplayercommand( "swap_weapon_release", "-weapnext" );
    self notifyonplayercommand( "A", "+gostand" );
    self notifyonplayercommand( "A_release", "-gostand" );
    self notifyonplayercommand( "RIGHT", "+actionslot 4" );
    waittill_buttons = [ "up", "up_release", "down", "down_release", "use", "use_release", "stance", "stance_release", "A", "A_release", "right", "ads", "ads_release", "attack", "attack_release", "touchpad", "touchpad_release", "swap_weapon", "swap_weapon_release" ];
    buttons_pressed = [];
    max_time = 2;
    
    for ( var_83af904929099c18 = undefined; true ; var_83af904929099c18 = undefined )
    {
        button_combos = level.demo_button_combos;
        result = waittill_any_in_array_return_no_endon_death( waittill_buttons );
        
        if ( getdvarint( @"hash_c021e81d04f69f38", 0 ) )
        {
            time = gettime();
            
            if ( !isdefined( var_83af904929099c18 ) )
            {
                var_83af904929099c18 = time + max_time * 1000;
            }
            
            buttons_pressed[ buttons_pressed.size ] = result;
            
            if ( time >= var_83af904929099c18 )
            {
                var_83af904929099c18 = undefined;
                buttons_pressed = [];
                continue;
            }
            
            var_83af904929099c18 = time + max_time * 1000;
            buttons_pressed = validate_button_combo( buttons_pressed );
            
            if ( buttons_pressed.size < 1 )
            {
            }
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1253f
// Size: 0x2
function setup_debug_button_combos_for_player()
{
    
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x12549
// Size: 0x7d
function add_demo_button_combo( button_combo, func, message, timeout )
{
    struct = spawnstruct();
    struct.button_combo = button_combo;
    struct.func = func;
    struct.message = message;
    struct.timeout = timeout;
    level.demo_button_combos[ level.demo_button_combos.size ] = struct;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x125ce
// Size: 0xca
function validate_button_combo( buttons_pressed )
{
    var_4fb3f5b8b87ff230 = [];
    
    for ( i = 0; i < level.demo_button_combos.size ; i++ )
    {
        data = level.demo_button_combos[ i ];
        sequence = level.demo_button_combos[ i ].button_combo;
        
        if ( buttons_pressed.size <= sequence.size )
        {
            if ( buttons_pressed[ buttons_pressed.size - 1 ] == sequence[ buttons_pressed.size - 1 ] )
            {
                if ( buttons_pressed.size == sequence.size )
                {
                    if ( isdefined( data.message ) )
                    {
                        announcement( data.message );
                    }
                    
                    buttons_pressed = [];
                    self thread [[ data.func ]]();
                }
                
                var_4fb3f5b8b87ff230 = buttons_pressed;
                break;
            }
        }
    }
    
    return var_4fb3f5b8b87ff230;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x126a1
// Size: 0x2a
function getenemyteams( testteam )
{
    teams = level.teamnamelist;
    teams = array_remove( teams, testteam );
    return teams;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x126d4
// Size: 0x41, Type: bool
function isfemale()
{
    return isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female";
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1271e
// Size: 0xb
function getgametype()
{
    return level.gametype;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x12732
// Size: 0x31
function getsubgametype()
{
    gametype = getgametype();
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return getdvar( @"scr_br_gametype", "br" );
    }
    
    return gametype;
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x1276c
// Size: 0x8c
function register_create_script( script, map, index, func )
{
    if ( isdefined( script ) )
    {
        level.scripted_spawner_func_strings[ level.scripted_spawner_func_strings.size ] = script;
    }
    
    if ( isdefined( map ) )
    {
        level.scripted_spawner_map_strings[ level.scripted_spawner_func_strings.size ] = map;
    }
    
    if ( isdefined( index ) )
    {
        level.create_script_file_ids[ script ] = "cs" + index;
    }
    
    if ( isdefined( func ) )
    {
        level.scripted_spawner_func[ level.scripted_spawner_func.size ] = func;
    }
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x12800
// Size: 0x61
function array_notify( ents, notifier, match )
{
    foreach ( value in ents )
    {
        value notify( notifier, match );
    }
}

// Namespace utility / scripts\cp\utility
// Params 7
// Checksum 0x0, Offset: 0x12869
// Size: 0xd0
function addtoactivekillstreaklist( streakname, threatbiasgroup, owner, outline, teamheadicon, var_81dbfc1d134bf264, endnotifyoverride )
{
    assertex( isdefined( streakname ), "streakName must be defined when using addToActiveKillstreakList()" );
    
    if ( istrue( teamheadicon ) )
    {
        assertex( isdefined( var_81dbfc1d134bf264 ), "Icon offset is required when using a teamHeadIcon" );
        ownerinvisible = 0;
        
        if ( owner isusingremote() )
        {
            ownerinvisible = 1;
        }
        
        icon = undefined;
        
        if ( level.teambased )
        {
            icon = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, var_81dbfc1d134bf264, 1, 10000, undefined, undefined, 1, ownerinvisible );
        }
        else
        {
            icon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage( owner, "hud_icon_head_equipment_friendly", var_81dbfc1d134bf264, 1, 10000, undefined, undefined, 1 );
        }
        
        thread removeteamheadicononnotify( icon, endnotifyoverride );
    }
}

// Namespace utility / scripts\cp\utility
// Params 6
// Checksum 0x0, Offset: 0x12941
// Size: 0x19f
function function_c99df5a0cf7879b1( flash_on, in_hand, var_122922acec8bd951, var_33ac0dfb0145d39b, var_29ddaacaac6aeaa4, var_ee8db5defc52493e )
{
    if ( !isdefined( flash_on ) )
    {
        flash_on = 1;
    }
    
    if ( !isdefined( in_hand ) )
    {
        in_hand = 1;
    }
    
    if ( flash_on )
    {
        modelname = "wm_equip_gen_flashlight_00";
        
        if ( isdefined( self.flashlightmodeloverride ) )
        {
            modelname = self.flashlightmodeloverride;
        }
        else if ( isdefined( level.flashlightmodeloverride ) )
        {
            modelname = level.flashlightmodeloverride;
        }
        
        var_4764d03d8a8279b5 = "tag_accessory_left";
        
        if ( isdefined( self.var_61104f16a7b00994 ) )
        {
            var_4764d03d8a8279b5 = self.var_61104f16a7b00994;
        }
        else if ( isdefined( level.var_61104f16a7b00994 ) )
        {
            var_4764d03d8a8279b5 = level.var_61104f16a7b00994;
        }
        
        if ( isdefined( var_33ac0dfb0145d39b ) )
        {
            self.flashlightfxoverridetag = var_33ac0dfb0145d39b;
        }
        
        if ( in_hand )
        {
            attach_point = var_4764d03d8a8279b5;
            
            if ( isdefined( var_29ddaacaac6aeaa4 ) )
            {
                attach_point = var_29ddaacaac6aeaa4;
            }
            
            self attach( modelname, attach_point, 1 );
            self.flashlightmodel = modelname;
            self.var_bfc3a6602abe3a0c = attach_point;
            self.asmflashlight = 1;
            
            if ( !isdefined( self.flashlightfxoverridetag ) )
            {
                self.flashlightfxoverridetag = "tag_light";
            }
        }
        else if ( !isdefined( self.flashlightfxoverridetag ) )
        {
            self.flashlightfxoverridetag = "tag_weapon_chest";
        }
        
        if ( isdefined( var_122922acec8bd951 ) )
        {
            self.flashlightfxoverride = var_122922acec8bd951;
        }
        
        if ( istrue( var_ee8db5defc52493e ) )
        {
            enable_flashlight( 1, undefined, var_ee8db5defc52493e );
        }
        else
        {
            enable_flashlight( 1 );
        }
        
        return;
    }
    
    self.asmflashlight = 0;
    enable_flashlight( 0 );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x12ae8
// Size: 0x2c
function fx_regulate_init()
{
    if ( isdefined( self.fx_ticket_queue ) )
    {
        return;
    }
    
    self.fx_ticket_queue = [];
    self.fx_ticket = 0;
    thread fx_regulator();
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x12b1c
// Size: 0x7d
function fx_regulator()
{
    self endon( "entitydeleted" );
    i = 0;
    
    while ( true )
    {
        self waittill( "new_fx_call" );
        
        while ( self.fx_ticket_queue.size > 0 )
        {
            ticket = self.fx_ticket_queue[ 0 ];
            self.fx_ticket_queue = array_remove( self.fx_ticket_queue, ticket );
            self notify( ticket );
            i++;
            
            if ( i == 3 )
            {
                wait 0.05;
                i = 0;
            }
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x12ba1
// Size: 0x1b
function get_fx_ticket()
{
    self.fx_ticket++;
    return string( self.fx_ticket );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x12bc5
// Size: 0x46
function fx_regulate()
{
    self endon( "death" );
    self endon( "entitydeleted" );
    ticket = get_fx_ticket();
    self.fx_ticket_queue = array_add( self.fx_ticket_queue, ticket );
    self notify( "new_fx_call" );
    self waittill( ticket );
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0x12c13
// Size: 0x4c
function fx_playontag_safe( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    if ( !isdefined( self.fx_ticket_queue ) )
    {
        fx_regulate_init();
    }
    
    thread fx_playontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 );
}

// Namespace utility / scripts\cp\utility
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x12c67
// Size: 0xb8
function private fx_playontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    if ( isdefined( end_note ) )
    {
        self endon( end_note );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    fx_regulate();
    
    /#
        if ( getdvarint( @"hash_4c2f239edafa91c9" ) )
        {
            print3d( self gettagorigin( tag ), "<dev string:x263>" + tag + "<dev string:x269>" + fx, ( 0, 1, 0 ), 1, 0.7, 20 );
        }
    #/
    
    if ( !isdefined( var_a6d635ca3756e9d7 ) || !var_a6d635ca3756e9d7 )
    {
        test_tag( tag, fx );
    }
    
    playfxontag( getfx( fx ), self, tag );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x12d27
// Size: 0x1ca
function test_tag( tag, fx )
{
    if ( self.model == "" )
    {
        assertmsg( "attempting to play fx <" + fx + "> on tag <" + tag + ">, but the entities model is empty" );
    }
    
    if ( isai( self ) )
    {
        success = 0;
        models = [];
        
        if ( isdefined( self.headmodel ) && self.headmodel != "" )
        {
            models[ models.size ] = self.headmodel;
        }
        
        if ( isdefined( self.hatmodel ) && self.hatmodel != "" )
        {
            models[ models.size ] = self.hatmodel;
        }
        
        if ( !isnullweapon( self.weapon ) )
        {
            models[ models.size ] = getweaponmodel( self.weapon );
        }
        
        models[ models.size ] = self.model;
        
        foreach ( model in models )
        {
            if ( hastag( model, tag ) )
            {
                success = 1;
                break;
            }
        }
        
        if ( !success )
        {
            assertmsg( "attempting to play fx <" + fx + "> on tag <" + tag + ">, but tag <" + tag + "> does not exist in ai <" + self.model + ">" );
        }
        
        return;
    }
    
    if ( !hastag( self.model, tag ) )
    {
        assertmsg( "attempting to play fx <" + fx + "> on tag <" + tag + ">, but tag <" + tag + "> does not exist in model <" + self + ">" );
    }
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0x12ef9
// Size: 0x4c
function fx_killontag_safe( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    if ( !isdefined( self.fx_ticket_queue ) )
    {
        fx_regulate_init();
    }
    
    thread fx_killontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 );
}

// Namespace utility / scripts\cp\utility
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x12f4d
// Size: 0x9d
function private fx_killontag_safe_internal( fx, tag, delay, end_note, var_a6d635ca3756e9d7 )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    if ( isdefined( end_note ) )
    {
        self endon( end_note );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    fx_regulate();
    
    if ( !isdefined( var_a6d635ca3756e9d7 ) || !var_a6d635ca3756e9d7 )
    {
        test_tag( tag, fx );
    }
    
    if ( tag == "tag_flash" && isnullweapon( self.weapon ) )
    {
        println( "<dev string:x26f>" );
        return;
    }
    
    killfxontag( getfx( fx ), self, tag );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x12ff2
// Size: 0x43
function removeteamheadicononnotify( icon, endnotifyoverride )
{
    wait_array = [ "death" ];
    
    if ( isdefined( endnotifyoverride ) )
    {
        wait_array[ wait_array.size ] = endnotifyoverride;
    }
    
    waittill_any_in_array_return_no_endon_death( wait_array );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( icon );
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x1303d
// Size: 0x8d
function killstreak_make_vehicle( streakname, scorepopup, vodestroyed, destroyedsplash )
{
    self.vehiclename = streakname;
    self.scorepopup = scorepopup;
    self.vodestroyed = vodestroyed;
    self.destroyedsplash = destroyedsplash;
    self enableplayermarks( "killstreak" );
    self filteroutplayermarks( self.team );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage( self );
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( "killstreak_vehicle_made", self );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x130d2
// Size: 0x1ba
function function_73ae764f6d95e017( streakref, var_5806c73139e2a5e3 )
{
    assert( isdefined( streakref ) );
    assert( isdefined( var_5806c73139e2a5e3 ) );
    assert( isstruct( var_5806c73139e2a5e3 ) );
    assert( var_5806c73139e2a5e3.var_f6f44ae79c7eb44d != "" );
    assert( var_5806c73139e2a5e3.var_cc5128455e1a40d4 != "" );
    assert( var_5806c73139e2a5e3.var_6e25c01b88fc2f76 != "" );
    assert( isstring( streakref ) );
    streakrefxhash = getxhash( streakref );
    game[ "dialog" ][ streakrefxhash ] = var_5806c73139e2a5e3.var_f6f44ae79c7eb44d;
    game[ "dialog" ][ "allies_friendly_" + streakref + "_inbound" ] = var_5806c73139e2a5e3.var_cc5128455e1a40d4 + "_friendly_use";
    game[ "dialog" ][ "allies_enemy_" + streakref + "_inbound" ] = var_5806c73139e2a5e3.var_cc5128455e1a40d4 + "_enemy_use";
    game[ "dialog" ][ "axis_friendly_" + streakref + "_inbound" ] = var_5806c73139e2a5e3.var_6e25c01b88fc2f76 + "_friendly_use";
    game[ "dialog" ][ "axis_enemy_" + streakref + "_inbound" ] = var_5806c73139e2a5e3.var_6e25c01b88fc2f76 + "_enemy_use";
    game[ "dialog" ][ "use_" + streakref ] = var_5806c73139e2a5e3.var_cc5128455e1a40d4 + "_use";
    game[ "dialog" ][ "destroyed_" + streakref ] = var_5806c73139e2a5e3.var_cc5128455e1a40d4 + "_destroyed";
    game[ "dialog" ][ "timeout_" + streakref ] = var_5806c73139e2a5e3.var_cc5128455e1a40d4 + "_timeout";
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x13294
// Size: 0x35
function killstreak_set_pre_mod_damage_callback( streakname, premoddamagecallback )
{
    killstreak_vehicle_callback_init();
    scripts\cp\vehicles\damage_cp::set_pre_mod_damage_callback( streakname, level.kspremoddamagecallback );
    self.kspremoddamagecallback = premoddamagecallback;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x132d1
// Size: 0x35
function killstreak_set_post_mod_damage_callback( streakname, postmoddamagecallback )
{
    killstreak_vehicle_callback_init();
    scripts\cp\vehicles\damage_cp::set_post_mod_damage_callback( streakname, level.kspostmoddamagecallback );
    self.kspostmoddamagecallback = postmoddamagecallback;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1330e
// Size: 0x35
function killstreak_set_death_callback( streakname, deathcallback )
{
    killstreak_vehicle_callback_init();
    scripts\cp\vehicles\damage_cp::set_death_callback( streakname, level.ksdeathcallback );
    self.ksdeathcallback = deathcallback;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1334b
// Size: 0x44
function killstreak_vehicle_callback_init()
{
    if ( !istrue( level.kscallbackinitcomplete ) )
    {
        level.kscallbackinitcomplete = 1;
        level.kspremoddamagecallback = &killstreak_pre_mod_damage_callback;
        level.kspostmoddamagecallback = &killstreak_post_mod_damage_callback;
        level.ksdeathcallback = &killstreak_death_callback;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x13397
// Size: 0xb4
function killstreak_pre_mod_damage_callback( data )
{
    damage = data.damage;
    attacker = data.attacker;
    
    if ( !istrue( self.killoneshot ) )
    {
        if ( isdefined( attacker ) && isdefined( self.owner ) && attacker == self.owner )
        {
            damage = int( ceil( damage * 0.5 ) );
        }
        
        data.damage = damage;
    }
    
    shouldcontinue = 1;
    premoddamagecallback = self.kspremoddamagecallback;
    
    if ( isdefined( premoddamagecallback ) )
    {
        shouldcontinue = self [[ premoddamagecallback ]]( data );
    }
    
    return shouldcontinue;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x13454
// Size: 0x6d
function killstreak_post_mod_damage_callback( data )
{
    killstreakhit( data.attacker, data.objweapon, self, data.meansofdeath, data.damage );
    shouldcontinue = 1;
    postmoddamagecallback = self.kspostmoddamagecallback;
    
    if ( isdefined( postmoddamagecallback ) )
    {
        shouldcontinue = self [[ postmoddamagecallback ]]( data );
    }
    
    return shouldcontinue;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x134ca
// Size: 0x90
function killstreak_death_callback( data )
{
    onkillstreakkilled( self.streakname, data.attacker, data.objweapon, data.meansofdeath, data.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash );
    shouldcontinue = 1;
    deathcallback = self.ksdeathcallback;
    
    if ( isdefined( deathcallback ) )
    {
        shouldcontinue = self [[ deathcallback ]]( data );
    }
    
    return shouldcontinue;
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0x13563
// Size: 0x172
function killstreakhit( attacker, objweapon, vehicle, meansofdeath, damage )
{
    if ( isdefined( objweapon ) && isplayer( attacker ) && isdefined( vehicle.owner ) && isdefined( vehicle.owner.team ) )
    {
        if ( scripts\cp_mp\utility\player_utility::playersareenemies( attacker, vehicle.owner ) )
        {
            if ( iskillstreakweapon( objweapon.basename ) )
            {
                return;
            }
            
            fullweaponstring = getcompleteweaponname( objweapon );
            
            if ( !isdefined( attacker.lasthittime[ fullweaponstring ] ) )
            {
                attacker.lasthittime[ fullweaponstring ] = 0;
            }
            
            if ( attacker.lasthittime[ fullweaponstring ] == gettime() )
            {
                return;
            }
            
            attacker.lasthittime[ fullweaponstring ] = gettime();
            
            if ( onlinestatsenabled() )
            {
            }
            
            if ( isdefined( meansofdeath ) && isbulletdamage( meansofdeath ) || isprojectiledamage( meansofdeath ) )
            {
                attacker.lastdamagetime = gettime();
                weapongroup = scripts\cp\weapon::getweapongroup( objweapon.basename );
                
                if ( weapongroup == "weapon_lmg" )
                {
                    if ( !isdefined( attacker.shotslandedlmg ) )
                    {
                        attacker.shotslandedlmg = 1;
                        return;
                    }
                    
                    attacker.shotslandedlmg++;
                }
            }
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 8
// Checksum 0x0, Offset: 0x136dd
// Size: 0x10a
function setkillstreakcontrolpriority( owner, hintstring, hintdisplayfov, var_a68f5a8aed5a3de, hintrange, userange, usepriority, var_a4c898ca05df4d4c )
{
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    self sethintonobstruction( "show" );
    self sethintstring( hintstring );
    self sethintdisplayfov( hintdisplayfov );
    self setusefov( var_a68f5a8aed5a3de );
    self sethintdisplayrange( hintrange );
    self setuserange( userange );
    self setusepriority( 1 );
    level thread applyplayercontrolonconnect( self );
    
    foreach ( player in level.players )
    {
        if ( player == owner && !istrue( var_a4c898ca05df4d4c ) )
        {
            self enableplayeruse( player );
            continue;
        }
        
        self disableplayeruse( player );
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x137ef
// Size: 0x3c
function applyplayercontrolonconnect( killstreakuseent )
{
    killstreakuseent endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "connected", player );
        killstreakuseent disableplayeruse( player );
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x13833
// Size: 0x29, Type: bool
function isprojectiledamage( meansofdeath )
{
    projdamage = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";
    
    if ( issubstr( projdamage, meansofdeath ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 9
// Checksum 0x0, Offset: 0x13865
// Size: 0x17b
function onkillstreakkilled( killstreakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify )
{
    notifyflag = 0;
    validattacker = undefined;
    
    if ( isdefined( attacker ) && isdefined( self.owner ) )
    {
        if ( isdefined( attacker.owner ) && isplayer( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
    else if ( isdefined( attacker ) && isdefined( self.team ) && isdefined( attacker.team ) )
    {
        if ( isenemy( attacker ) && isplayer( attacker ) )
        {
            validattacker = attacker;
        }
    }
    
    if ( isdefined( validattacker ) )
    {
        if ( isdefined( cardsplash ) )
        {
            validattacker scripts\cp\cp_player_battlechatter::killstreakdestroyed( killstreakname );
        }
        
        if ( getgametype() == "incursion" )
        {
            thread scripts\cp\events::killedkillstreak( killstreakname, validattacker, objweapon );
        }
        else
        {
            thread scripts\cp\events::killedkillstreak( killstreakname, validattacker, objweapon );
        }
        
        if ( !is_specops_gametype() )
        {
            thread scripts\cp\cp_challenge::killstreakkilled( killstreakname, self.owner, self, validattacker, damage, damagetype, objweapon, scorepopupname );
        }
        
        scripts\cp_mp\gestures::processcalloutdeath( self, validattacker );
        notifyflag = 1;
    }
    
    if ( isdefined( self.owner ) && isdefined( leaderdialog ) )
    {
    }
    
    if ( !istrue( skipdeathnotify ) )
    {
        self notify( "death" );
    }
    
    return notifyflag;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x139e9
// Size: 0x27
function heli_starts_restrict_to( noteworthy_prefix )
{
    scripts\cp\utility::heli_starts_clear();
    scripts\cp\utility::heli_starts_addstart( noteworthy_prefix + "_heli_entrance", noteworthy_prefix + "_heli_goal" );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x13a18
// Size: 0x9b
function heli_starts_addstart( entrance_noteworthy, goal_noteworthy )
{
    if ( !isdefined( level.heli_structs_entrances ) )
    {
        level.heli_structs_entrances = [];
    }
    
    if ( !isdefined( level.heli_structs_goals ) )
    {
        level.heli_structs_goals = [];
    }
    
    entrancestruct = getstruct( entrance_noteworthy, "script_noteworthy" );
    goalstruct = getstruct( goal_noteworthy, "script_noteworthy" );
    level.heli_structs_entrances[ level.heli_structs_entrances.size ] = entrancestruct;
    level.heli_structs_goals[ level.heli_structs_goals.size ] = goalstruct;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13abb
// Size: 0x52
function heli_starts_clear()
{
    if ( isdefined( level.heli_structs_entrances ) && level.heli_structs_entrances.size >= 1 )
    {
        level.heli_structs_entrances = [];
    }
    
    if ( isdefined( level.heli_structs_goals ) && level.heli_structs_goals.size >= 1 )
    {
        level.heli_structs_goals = [];
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13b15
// Size: 0x85, Type: bool
function is_raid_gamemode()
{
    if ( getdvarint( @"hash_fe379b650d9837fb", 0 ) )
    {
        return true;
    }
    
    return level.script == "cp_raid1" || level.script == "cp_raid1_trap" || level.script == "cp_raid1test" || level.script == "cp_jugg_maze" || level.script == "cp_capture_jugg" || level.script == "cp_raid1_boss1";
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13ba3
// Size: 0x2d, Type: bool
function function_93d685ac42f15c61()
{
    if ( getdvarint( @"hash_f241138dc4147e30", 0 ) )
    {
        return true;
    }
    
    if ( level.script == "cp_observatory" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13bd9
// Size: 0x19, Type: bool
function function_f993f83a21fc44b2()
{
    if ( function_ddafef2154fd19bb() || function_93d685ac42f15c61() )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13bfb
// Size: 0x18, Type: bool
function is_wave_gametype()
{
    if ( level.gametype == "cp_wave_sv" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13c1c
// Size: 0x18, Type: bool
function function_a3577e8e6c88a56b()
{
    if ( level.gametype == "missions" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13c3d
// Size: 0x18, Type: bool
function function_240f7f4e57340e8f()
{
    if ( level.gametype == "dungeons" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13c5e
// Size: 0x18, Type: bool
function function_f620e996a1d7d81a()
{
    if ( level.gametype == "cqc" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13c7f
// Size: 0x18, Type: bool
function function_ddafef2154fd19bb()
{
    if ( level.gametype == "incursion" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13ca0
// Size: 0x11, Type: bool
function is_specops_gametype()
{
    return level.gametype == "cp_specops";
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13cba
// Size: 0x18, Type: bool
function is_operations_gametype()
{
    if ( level.gametype == "cp_survival" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13cdb
// Size: 0x34, Type: bool
function is_cp_raid()
{
    mapname = getdvar( @"ui_mapname" );
    
    if ( mapname == "cp_raid_complex" || mapname == "cp_dntsk_raid" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13d18
// Size: 0x32
function issimultaneouskillenabled()
{
    if ( !isdefined( level.simultaneouskillenabled ) )
    {
        level.simultaneouskillenabled = getdvarint( @"killswitch_simultaneous_deaths", 0 ) == 0;
    }
    
    return level.simultaneouskillenabled;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13d53
// Size: 0x23, Type: bool
function onlinestatsenabled()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13d7f
// Size: 0x1d, Type: bool
function privatematch()
{
    return level.onlinegame && getdvarint( @"xblive_privatematch" );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x13da5
// Size: 0x9e
function play_music_to_team( mus_alias, var_908ececf1b52292e )
{
    if ( !isdefined( mus_alias ) || mus_alias == "" )
    {
        return;
    }
    
    player_list = level.players;
    
    if ( isdefined( var_908ececf1b52292e ) )
    {
        if ( !isarray( var_908ececf1b52292e ) )
        {
            player_list = [ var_908ececf1b52292e ];
        }
        else
        {
            player_list = var_908ececf1b52292e;
        }
    }
    
    foreach ( player in player_list )
    {
        player setplayermusicstate( mus_alias );
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x13e4b
// Size: 0x112
function watch_and_open_scriptable_doors_in_radius( radius )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "dropped_hostage" );
    self endon( "stop_hostagecarrier_watching_for_doors" );
    player = self;
    radius = ter_op( isdefined( radius ), radius, 64 );
    var_284908edb3c3318d = 1.5;
    var_36f2d54bcbaae65a = [ "scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01" ];
    
    while ( true )
    {
        var_9bc823cab1bb2862 = [];
        var_913576e1dc1762b5 = getentitylessscriptablearray( undefined, undefined, player.origin, radius );
        
        for ( i = 0; i < var_913576e1dc1762b5.size ; i++ )
        {
            if ( var_913576e1dc1762b5[ i ] scriptableisdoor() && !var_913576e1dc1762b5[ i ] function_f8b5985c95abf390() )
            {
                var_9bc823cab1bb2862[ var_9bc823cab1bb2862.size ] = var_913576e1dc1762b5[ i ];
            }
        }
        
        for ( x = 0; x < var_9bc823cab1bb2862.size ; x++ )
        {
            var_9bc823cab1bb2862[ x ] setscriptablepartstate( "door", "left_30", 0 );
        }
        
        wait var_284908edb3c3318d;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13f65
// Size: 0x2d, Type: bool
function function_f8b5985c95abf390()
{
    if ( self function_fac544c98a3d9eb4() )
    {
        return true;
    }
    
    if ( istrue( self.blocked ) || istrue( self.locked ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x13f9b
// Size: 0x65
function get_num_of_valid_players()
{
    num_of_valid_players = 0;
    
    foreach ( player in level.players )
    {
        if ( player is_valid_player() )
        {
            num_of_valid_players++;
        }
    }
    
    return num_of_valid_players;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x14009
// Size: 0x1a9
function track_last_good_position( var_564065b333a4d983, update_interval )
{
    self endon( "death" );
    self notify( "track_last_good_position" );
    self endon( "track_last_good_position" );
    
    if ( !isdefined( update_interval ) )
    {
        update_interval = 0.1;
    }
    
    while ( true )
    {
        wait update_interval;
        
        if ( !isdefined( self ) )
        {
            continue;
        }
        
        if ( !isdefined( self.origin ) )
        {
            continue;
        }
        
        if ( isdefined( self.last_good_pos ) && self.origin == self.last_good_pos )
        {
            continue;
        }
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( self isjumping() )
        {
            continue;
        }
        
        if ( self isparachuting() )
        {
            continue;
        }
        
        if ( self isonladder() )
        {
            continue;
        }
        
        if ( !self isonground() )
        {
            continue;
        }
        
        if ( scripts\cp\laststand::player_in_laststand( self ) )
        {
            continue;
        }
        
        if ( isdefined( level.outofboundstriggers ) )
        {
            foreach ( trigger in level.outofboundstriggers )
            {
                if ( self istouching( trigger ) )
                {
                }
            }
        }
        
        if ( isdefined( level.landmine_trig ) && self istouching( level.landmine_trig ) )
        {
            continue;
        }
        
        if ( istrue( self.spectating ) )
        {
            continue;
        }
        
        if ( istrue( self.hurt_trigger_active ) )
        {
            continue;
        }
        
        if ( istrue( self.landmine_active ) )
        {
            continue;
        }
        
        if ( istrue( var_564065b333a4d983 ) && !ispointonnavmesh( self.origin ) )
        {
            continue;
        }
        
        self.last_good_pos = self.origin;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x141ba
// Size: 0x42, Type: bool
function coop_mode_has( feature_str )
{
    if ( !isdefined( level.coop_mode_feature ) )
    {
        return false;
    }
    
    if ( function_1772811f5b613303( feature_str ) )
    {
        return false;
    }
    
    return isdefined( level.coop_mode_feature[ feature_str ] ) && istrue( level.coop_mode_feature[ feature_str ] );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x14205
// Size: 0x26, Type: bool
function function_1772811f5b613303( feature_str )
{
    if ( !isdefined( level.var_8c70b00c48e8bd20 ) )
    {
        return false;
    }
    
    return istrue( level.var_8c70b00c48e8bd20[ feature_str ] );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x14234
// Size: 0x79
function coop_mode_enable( feature_array )
{
    if ( isdefined( feature_array ) )
    {
        if ( isarray( feature_array ) )
        {
            foreach ( feature in feature_array )
            {
                level.coop_mode_feature[ feature ] = 1;
            }
            
            return;
        }
        
        level.coop_mode_feature[ feature_array ] = 1;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x142b5
// Size: 0x5b
function disable_system( feature_array )
{
    feature_array = force_var_to_array( feature_array );
    
    for ( i = 0; i < feature_array.size ; i++ )
    {
        level.var_8c70b00c48e8bd20[ feature_array[ i ] ] = 1;
        
        if ( isdefined( level.coop_mode_feature[ feature_array[ i ] ] ) )
        {
            level.coop_mode_feature[ feature_array[ i ] ] = undefined;
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x14318
// Size: 0x29
function force_var_to_array( feature_str )
{
    temp_array = feature_str;
    
    if ( !isarray( feature_str ) )
    {
        temp_array = [ feature_str ];
    }
    
    return temp_array;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1434a
// Size: 0x13, Type: bool
function function_6aafbdd00b977115()
{
    if ( istrue( level.disable_nvg ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x14366
// Size: 0xd
function function_7bb9f9b4dc700888()
{
    level.disable_nvg = 1;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1437b
// Size: 0xc
function function_b4ca8a0fc3169f35()
{
    level.disable_nvg = 0;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1438f
// Size: 0x35
function function_c0d2c91f2688ece4( bool, locked )
{
    if ( !istrue( level.var_7b52aa5a0569211c ) )
    {
        level.var_7b52aa5a0569211c = locked;
        level.var_624ba233506a543e = !bool;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x143cc
// Size: 0x29
function function_42b1f4ecac37172( automatic )
{
    self endon( "disconnect" );
    scripts\cp\pickups::takerevivepickup();
    
    if ( !istrue( automatic ) )
    {
        self.var_bbc9ffd2df014c2 = 1;
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x143fd
// Size: 0x198, Type: bool
function function_ace2ca7720ddedac( automatic )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "revive" );
    self endon( "revive_success" );
    
    if ( !isdefined( automatic ) )
    {
        automatic = 0;
    }
    
    if ( self usinggamepad() )
    {
        self notifyonplayercommand( "pressed_autorevive", "+usereload" );
    }
    else
    {
        self notifyonplayercommand( "pressed_autorevive", "+activate" );
    }
    
    if ( !automatic )
    {
        thread function_b94df25aa73f60a0();
    }
    
    wait 0.1;
    thread function_5a7185ea887bc9d4();
    self.var_235edef1b3f12286 = 0;
    
    while ( !self.var_235edef1b3f12286 )
    {
        if ( !automatic )
        {
            self waittill( "pressed_autorevive" );
        }
        
        if ( scripts\cp\laststand::player_in_laststand( self ) )
        {
            if ( !isdefined( self.dogtag ) )
            {
                if ( scripts\cp\laststand::getbeingrevivedinternal() )
                {
                    waitframe();
                    continue;
                }
                
                self.using_self_revive = 1;
                self giveandfireoffhand( "adrenaline_mp" );
                
                if ( isdefined( self.reviveiconent ) )
                {
                    scripts\cp\laststand::set_revive_icon_color( self.reviveiconent );
                }
                
                self.var_235edef1b3f12286 = function_6d974261da967f6( automatic );
                self.using_self_revive = undefined;
                
                if ( istrue( self.var_235edef1b3f12286 ) )
                {
                    foreach ( player in level.players )
                    {
                        if ( player != self )
                        {
                            player thread scripts\cp\cp_hud_message::showsplash( "cp_used_self_revive", undefined, self );
                        }
                    }
                    
                    thread scripts\cp\cp_hud_message::showsplash( "cp_self_revive" );
                    thread scripts\cp\laststand::instant_revive( self );
                }
            }
            
            continue;
        }
        
        break;
    }
    
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1459e
// Size: 0x38
function function_b94df25aa73f60a0()
{
    self endon( "disconnect" );
    
    while ( true )
    {
        if ( !scripts\cp\laststand::player_in_laststand( self ) )
        {
            break;
        }
        
        if ( !scripts\cp\laststand::getbeingrevivedinternal() )
        {
            scripts\cp\cp_hud_message::tutorialprint( &"COOP_GAME_PLAY/USE_SELF_REVIVE", 2 );
        }
        
        wait 2;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x145de
// Size: 0x1cb
function function_5a7185ea887bc9d4()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    msg = scripts\engine\utility::waittill_any_return_3( "revive", "revive_success" );
    self.curprogress = 0;
    
    if ( self.var_235edef1b3f12286 )
    {
        if ( isdefined( self.dogtag ) )
        {
            self.dogtag delete();
        }
        
        if ( self usinggamepad() )
        {
            self notifyonplayercommandremove( "pressed_autorevive", "+usereload" );
        }
        else
        {
            self notifyonplayercommandremove( "pressed_autorevive", "+activate" );
        }
        
        self notify( "clear_tutorial_messages" );
        self clearhudtutorialmessage();
        
        /#
            if ( getdvarint( @"hash_d1a711554f276a9" ) && ( !isdefined( self.self_revive ) || !self.self_revive ) )
            {
                if ( isdefined( self.var_9f4e140e6dcbc55d ) )
                {
                    index = self.var_9f4e140e6dcbc55d.size - 1;
                    item = self.var_9f4e140e6dcbc55d[ index ];
                    slot = item.slot;
                    remove_carry_item( self, slot );
                    self.var_9f4e140e6dcbc55d[ index ] = undefined;
                }
                
                self setclientomnvar( "<dev string:x2b6>", 0 );
                return;
            }
        #/
        
        self.self_revive--;
        
        if ( self.self_revive < 1 )
        {
            self.self_revive = undefined;
            self.has_auto_revive = 0;
            self.var_bbc9ffd2df014c2 = undefined;
        }
        
        if ( isdefined( self.var_9f4e140e6dcbc55d ) )
        {
            index = self.var_9f4e140e6dcbc55d.size - 1;
            item = self.var_9f4e140e6dcbc55d[ index ];
            slot = item.slot;
            remove_carry_item( self, slot );
            self.var_9f4e140e6dcbc55d[ index ] = undefined;
        }
    }
    
    self setclientomnvar( "ui_self_revive", 0 );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x147b1
// Size: 0x173, Type: bool
function function_6d974261da967f6( automatic )
{
    revivee = self;
    reviver = self;
    
    if ( !isdefined( self.curprogress ) )
    {
        self.curprogress = 0;
    }
    
    if ( !isdefined( self.userate ) )
    {
        self.userate = 1;
    }
    
    if ( !isdefined( self.usetime ) )
    {
        self.usetime = scripts\cp\laststand::get_normal_revive_time();
    }
    
    level endon( "game_ended" );
    revivee endon( "death_or_disconnect" );
    revivee endon( "last_stand_finished" );
    
    while ( true )
    {
        if ( scripts\cp\laststand::getbeingrevivedinternal( self ) )
        {
            if ( isdefined( self.reviveiconent ) )
            {
                scripts\cp\laststand::set_revive_icon_color( self.reviveiconent );
            }
            
            self.curprogress -= level.frameduration * self.userate;
            waitframe();
        }
        
        if ( !istrue( automatic ) )
        {
            if ( !reviver usebuttonpressed() )
            {
                break;
            }
        }
        
        self.curprogress += level.frameduration * self.userate;
        self.userate = 1;
        self.id = "self_revive";
        reviver updateuiprogress( self, 1 );
        
        if ( self.curprogress >= self.usetime )
        {
            revivee notify( "use_hold_think_success" );
            reviver updateuiprogress( self, 0 );
            return true;
        }
        
        waitframe();
    }
    
    revivee notify( "use_hold_think_fail" );
    reviver updateuiprogress( self, 0 );
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1492d
// Size: 0x2ef
function updateuiprogress( object, securing )
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        if ( isdefined( object.interactteam ) && object.interactteam == "none" )
        {
            self setclientomnvar( "ui_objective_pinned_text_param", 0 );
            return;
        }
        
        objid = undefined;
        
        if ( isdefined( object.objidnum ) )
        {
            objid = object.objidnum;
        }
        
        progress = 0;
        
        if ( isdefined( object.teamprogress ) && isdefined( object.claimteam ) )
        {
            if ( object.teamprogress[ object.claimteam ] > object.usetime )
            {
                object.teamprogress[ object.claimteam ] = object.usetime;
            }
            
            progress = object.teamprogress[ object.claimteam ] / object.usetime;
        }
        else
        {
            if ( object.curprogress > object.usetime )
            {
                object.curprogress = object.usetime;
            }
            
            progress = object.curprogress / object.usetime;
            
            if ( object.usetime <= 1000 )
            {
                progress = min( progress + 0.05, 1 );
            }
            else
            {
                progress = min( progress + 0.01, 1 );
            }
        }
        
        if ( isdefined( object.id ) )
        {
            idx = 0;
            
            switch ( object.id )
            {
                case #"hash_3fd866e3da61a87":
                case #"hash_e477c24ee18bb2f6":
                    idx = 1;
                    break;
                case #"hash_bf5597954aaed3d7":
                    idx = 2;
                    break;
                case #"hash_dbf719cee2feda22":
                    idx = 3;
                    break;
                case #"hash_82aad0a51185a053":
                    idx = 4;
                    break;
                case #"hash_6686a1466f9a8d41":
                    idx = 5;
                    break;
                case #"hash_668692466f9a75a4":
                    idx = 6;
                    break;
                case #"hash_c63c3cbdbdbd5178":
                    idx = 7;
                    break;
                case #"hash_631f416c3d8360d4":
                    idx = 8;
                    break;
                case #"hash_e726fddec3f4a467":
                    idx = 9;
                    break;
                case #"hash_973d1db8b6644466":
                    idx = 10;
                    break;
                case #"hash_cc625e548a303e68":
                    idx = 13;
                    break;
                case #"hash_3f4b70eb42439fbe":
                    idx = 15;
                    break;
                case #"hash_3a1c112e4325bad9":
                    idx = 16;
                    break;
                case #"hash_32eeb14581d379aa":
                    idx = 19;
                    break;
            }
            
            updateuisecuring( progress, securing, idx, object, object.usetime );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x14c24
// Size: 0x26, Type: bool
function isrevivetrigger()
{
    if ( isdefined( self.id ) && self.id == "laststand_reviver" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x14c53
// Size: 0x88
function function_1dbc717085326045( ui_securing, ui_securing_progress, ui_reviver_id )
{
    entity_num = self getentitynumber();
    
    if ( isdefined( ui_securing ) )
    {
        self setclientomnvar( "ui_securing", ui_securing );
        scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "ui_securing", ui_securing );
    }
    
    if ( isdefined( ui_securing_progress ) )
    {
        self setclientomnvar( "ui_securing_progress", ui_securing_progress );
        scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "ui_securing_progress", ui_securing_progress );
    }
    
    if ( isdefined( ui_reviver_id ) )
    {
        self setclientomnvar( "ui_reviver_id", ui_reviver_id );
    }
}

// Namespace utility / scripts\cp\utility
// Params 5
// Checksum 0x0, Offset: 0x14ce3
// Size: 0x2a0
function updateuisecuring( progress, securing, idx, object, usetime )
{
    objid = undefined;
    
    if ( securing )
    {
        if ( !isdefined( object.usedby ) )
        {
            object.usedby = [];
        }
        
        if ( !array_contains( object.usedby, self ) )
        {
            object.usedby[ object.usedby.size ] = self;
        }
        
        if ( !isdefined( self.ui_securing ) )
        {
            function_1dbc717085326045( idx );
            self.ui_securing = 1;
            
            if ( isdefined( object.trigger ) && object.trigger isrevivetrigger() )
            {
                if ( isdefined( object.trigger.owner ) && object.trigger.owner != self )
                {
                    object.trigger.owner function_1dbc717085326045( 6, undefined, self getentitynumber() );
                }
            }
        }
    }
    else
    {
        if ( isdefined( object.usedby ) && array_contains( object.usedby, self ) )
        {
            object.usedby = array_remove( object.usedby, self );
        }
        
        function_1dbc717085326045( 0 );
        self.ui_securing = undefined;
        
        if ( isdefined( object.trigger ) && object.trigger isrevivetrigger() )
        {
            if ( isdefined( object.trigger.owner ) )
            {
                object.trigger.owner function_1dbc717085326045( 0, undefined, -1 );
            }
        }
        
        progress = 0.01;
        
        if ( isdefined( object.objidnum ) )
        {
            objid = object.objidnum;
        }
    }
    
    if ( usetime == 500 )
    {
        progress = min( progress + 0.15, 1 );
    }
    
    if ( progress != 0 )
    {
        function_1dbc717085326045( undefined, progress, undefined );
        
        if ( isdefined( object.trigger ) && object.trigger isrevivetrigger() )
        {
            if ( isdefined( object.trigger.owner ) )
            {
                object.trigger.owner function_1dbc717085326045( undefined, progress, undefined );
            }
        }
        
        if ( isdefined( object.objidnum ) )
        {
            objective_setprogress( object.objidnum, progress );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x14f8b
// Size: 0x31
function function_ad3ce5e1679df13d( weaponobj )
{
    if ( isdefined( level.var_a1099f1a44938da3 ) )
    {
        self [[ level.var_a1099f1a44938da3 ]]( weaponobj );
        return;
    }
    
    self givemaxammo( weaponobj );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x14fc4
// Size: 0x2f
function function_ed18a118c6fa5c4f( weapon )
{
    if ( isdefined( level.var_a636c794cdb0b43b ) )
    {
        return [[ level.var_a636c794cdb0b43b ]]( weapon );
    }
    
    return weaponmaxammo( weapon );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x14ffb
// Size: 0x2e
function function_ed8121366a308031( ent )
{
    ent endon( "death" );
    self waittill( "death" );
    
    if ( isdefined( ent ) )
    {
        ent scriptable_clearparententity();
        ent freescriptable();
    }
}

// Namespace utility / scripts\cp\utility
// Params 4
// Checksum 0x0, Offset: 0x15031
// Size: 0x73
function add_start( startname, setup_func, main_func, catchup_function )
{
    scripts\cp\starts::add_start_assert();
    msg = tolower( startname );
    array = scripts\cp\starts::add_start_construct( msg, setup_func, main_func, catchup_function );
    level.start_functions[ level.start_functions.size ] = array;
    level.start_arrays[ msg ] = array;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x150ac
// Size: 0x7e, Type: bool
function is_default_start()
{
    if ( isdefined( level.forced_start_catchup ) && level.forced_start_catchup == 1 )
    {
        return false;
    }
    
    if ( isdefined( level.default_start_override ) )
    {
        if ( level.default_start_override == level.start_point )
        {
            return true;
        }
    }
    else if ( scripts\cp\starts::level_has_start_points() )
    {
        return ( level.start_point == level.start_functions[ 0 ][ "name" ] );
    }
    
    return level.start_point == "default";
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x15133
// Size: 0x15
function set_default_start( start )
{
    level.default_start_override = start;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x15150
// Size: 0x25
function function_9ec4754a395bcc2d()
{
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1517d
// Size: 0x16e
function function_ae99616202575e39( throwpos, grenadetype )
{
    self endon( "death" );
    zoffset = ( 0, 0, 30 );
    scripts\asm\asm_mp::asm_setanimscripted();
    self orientmode( "face angle", vectortoangles( throwpos - self.origin )[ 1 ] );
    animname = "grenade_throw";
    animindex = scripts\asm\asm::asm_lookupanimfromalias( "animscripted", animname );
    xanim = scripts\asm\asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    self aisetanim( "animscripted", animindex );
    var_20343d86382ec753 = animlength / 2;
    wait var_20343d86382ec753;
    vec = ( throwpos[ 0 ], throwpos[ 1 ], self.origin[ 2 ] ) - self.origin + zoffset;
    vec = vectornormalize( vec );
    launchpos = self.origin + zoffset + vec * 20;
    force = distance2d( launchpos, throwpos );
    velocity = force * vec;
    gren = self launchgrenade( grenadetype, launchpos, velocity );
    gren.owner = self;
    wait var_20343d86382ec753;
    scripts\asm\asm_bb::bb_clearanimscripted();
    self scriptedanimfinished();
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x152f3
// Size: 0x2a3, Type: bool
function ifcanseeplayer( soldier, player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( istrue( player.ignoreme ) )
    {
        return false;
    }
    
    var_b72bdf4ad529c791 = isplayer( player );
    dist = distance( player.origin, soldier.origin );
    var_3497d6ac3151641c = istrue( soldier.damaged );
    var_9540d52e669b0713 = 1;
    playervelocity = player getvelocity();
    var_a8f6a48be8f34c73 = length( playervelocity );
    
    if ( var_a8f6a48be8f34c73 < 128 )
    {
        var_9540d52e669b0713 = 0.75;
    }
    else if ( var_a8f6a48be8f34c73 < 200 || var_b72bdf4ad529c791 && player.perk_data[ "stealth_velocity_override" ] )
    {
        var_9540d52e669b0713 = 1;
    }
    else
    {
        var_9540d52e669b0713 = 1.25;
    }
    
    if ( dist > 1500 * var_9540d52e669b0713 )
    {
        return false;
    }
    
    can_see = soldier cansee( player );
    
    if ( can_see )
    {
        var_2f97851dda9b1547 = cos( 75 );
        infov = within_fov( soldier geteye(), soldier getplayerangles( 1 ), player.origin + ( 0, 0, 40 ), var_2f97851dda9b1547 );
        
        if ( !infov )
        {
            return false;
        }
        
        passed = sighttracepassed( soldier geteye(), player geteye(), 0, soldier, var_3497d6ac3151641c );
        
        if ( !passed )
        {
            return false;
        }
        
        contents = scripts\engine\trace::create_solid_ai_contents( 1 );
        
        if ( !ray_trace_passed( soldier geteye(), player geteye(), soldier, contents ) )
        {
            return false;
        }
        
        vtest = math::get_dot( soldier.origin, anglestoforward( soldier.angles ), player.origin );
        var_9540d52e669b0713 = 1;
        
        if ( vtest >= 0.573576 )
        {
            var_9540d52e669b0713 -= 0.34;
        }
        
        if ( var_3497d6ac3151641c )
        {
            var_9540d52e669b0713 -= 0.34;
        }
        
        stance = player getstance();
        
        if ( dist <= int( 350 / var_9540d52e669b0713 ) )
        {
            if ( stance == "prone" )
            {
                return false;
            }
            
            return true;
        }
        else if ( dist <= int( 500 / var_9540d52e669b0713 ) )
        {
            if ( stance == "prone" )
            {
                return false;
            }
            
            return true;
        }
        else if ( dist <= int( 950 / var_9540d52e669b0713 ) )
        {
            if ( stance == "prone" || stance == "crouch" )
            {
                return false;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x1559f
// Size: 0x47
function function_c72ff775cd61b11( dvar, value, default_value )
{
    setdvar( dvar, value );
    
    if ( !isdefined( level.session_dvars ) )
    {
        level.session_dvars = [];
    }
    
    level.session_dvars[ dvar ] = default_value;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x155ee
// Size: 0xe, Type: bool
function function_3a14bbe88e409edf()
{
    return level.current_attempts == 1;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x15605
// Size: 0x55
function function_138028ca2b958511()
{
    if ( issubstr( level.mapname, "raid" ) )
    {
        return 1;
    }
    
    switch ( level.mapname )
    {
        case #"hash_1725f94e0ec2b5f2":
        case #"hash_bcab9174406bce6b":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x15662
// Size: 0x11, Type: bool
function function_aae723485e3b0e9d()
{
    return level.mapname == "cp_jugg_maze";
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x1567c
// Size: 0x75
function function_bb3e0c926b0667c4( value )
{
    foreach ( player in level.players )
    {
        player setclientdvar( @"hash_c4b5f7005920fc31", value );
    }
    
    setdvar( @"hash_c4b5f7005920fc31", value );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x156f9
// Size: 0x15
function function_3069b525e1c98faf( var_901e1e9a8dbed7c9 )
{
    level.var_54cdebb25ceeea16 = var_901e1e9a8dbed7c9;
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x15716
// Size: 0xb
function function_6721512a3aff2e3b()
{
    return level.var_54cdebb25ceeea16;
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1572a
// Size: 0x27
function function_61a3391d3ab5faf7( func, endnotify )
{
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( func );
    level waittill( endnotify );
    scripts\cp\utility\spawn_event_aggregator::function_de35280460ae9411( func );
}

// Namespace utility / scripts\cp\utility
// Params 8
// Checksum 0x0, Offset: 0x15759
// Size: 0x45, Type: bool
function function_97196d9c69a91e2b( var1, var2, var3, var4, var5, var6, var7, var8 )
{
    return true;
}

// Namespace utility / scripts\cp\utility
// Params 3
// Checksum 0x0, Offset: 0x157a7
// Size: 0x148
function sun_light_fade( startsunlight, endsunlight, ftime )
{
    if ( !isdefined( startsunlight ) )
    {
        startsunlight = getmapsuncolorandintensity();
    }
    else if ( isvector( startsunlight ) )
    {
        current_values = getmapsuncolorandintensity();
        startsunlight = [ startsunlight[ 0 ], startsunlight[ 1 ], startsunlight[ 2 ], current_values[ 3 ] ];
    }
    
    if ( isvector( endsunlight ) )
    {
        current_values = getmapsuncolorandintensity();
        endsunlight = [ endsunlight[ 0 ], endsunlight[ 1 ], endsunlight[ 2 ], current_values[ 3 ] ];
    }
    
    ftime = int( ftime * 20 );
    increment = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        increment[ i ] = ( startsunlight[ i ] - endsunlight[ i ] ) / ftime;
    }
    
    newsunlight = [];
    
    for ( i = 0; i < ftime ; i++ )
    {
        wait 0.05;
        
        for ( j = 0; j < 4 ; j++ )
        {
            newsunlight[ j ] = startsunlight[ j ] - increment[ j ] * i;
        }
        
        setsuncolorandintensity( newsunlight[ 0 ], newsunlight[ 1 ], newsunlight[ 2 ], newsunlight[ 3 ] );
    }
    
    setsuncolorandintensity( endsunlight[ 0 ], endsunlight[ 1 ], endsunlight[ 2 ], endsunlight[ 3 ] );
}

#using_animtree( "script_model" );

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x158f7
// Size: 0x160
function function_bd4d8a169d79e52b()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    weaponbasename = "ks_remote_device_mp";
    heldweapon = self getcurrentweapon();
    weaponobj = makeweapon( weaponbasename );
    deployanim = %vm_ks_tablet_tap_raise;
    
    if ( weaponbasename == "ks_remote_nuke_mp" )
    {
        deployanim = %vm_ks_tablet_tac_nuke_raise;
    }
    
    tabletanimlength = getanimlength( deployanim ) - 1;
    val::set( "TabletDeployAnim", "allow_movement", 0 );
    val::set( "TabletDeployAnim", "allow_jump", 0 );
    val::set( "TabletDeployAnim", "usability", 0 );
    val::set( "TabletDeployAnim", "melee", 0 );
    val::set( "TabletDeployAnim", "offhand_weapons", 0 );
    val::set( "TabletDeployAnim", "supers", 0 );
    val::set( "TabletDeployAnim", "killstreaks", 0 );
    switchresult = function_f9e80f1fe925cdc0( weaponobj );
    
    if ( isdefined( self ) && isalive( self ) )
    {
        val::reset_all( "TabletDeployAnim" );
    }
    
    if ( !istrue( switchresult ) )
    {
        return 0;
    }
    
    animresult = waittill_any_timeout_2( tabletanimlength, "death", "weapon_change" );
    switchresult = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( heldweapon );
    self takeweapon( weaponobj );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x15a60
// Size: 0xa4
function function_f9e80f1fe925cdc0( deployweaponobj )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    
    if ( self hasweapon( deployweaponobj ) )
    {
        return 0;
    }
    
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( getcompleteweaponname( self getcurrentweapon() ) == "iw8_lm_dblmg_mp" )
        {
            self notify( "switched_from_minigun" );
            
            while ( getcompleteweaponname( self getcurrentweapon() ) == "iw8_lm_dblmg_mp" )
            {
                waitframe();
            }
        }
    }
    
    _giveweapon( deployweaponobj, 0, 0, 1 );
    switchresult = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( deployweaponobj );
    waitframe();
    
    if ( !switchresult )
    {
        cleanupwaitfunc = undefined;
    }
    
    if ( !isalive( self ) )
    {
        return 0;
    }
    
    return switchresult;
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x15b0d
// Size: 0x37
function disable_backpack_inventory( bool )
{
    if ( bool )
    {
        val::set( "cp_utility_disable_backpack_inventory", "backpack_inventory", 0 );
        return;
    }
    
    val::set( "cp_utility_disable_backpack_inventory", "backpack_inventory", 1 );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x15b4c
// Size: 0x49
function function_76ba4acf14679724()
{
    level endon( "game_ended" );
    
    while ( !flag_exist( "scriptables_ready" ) )
    {
        waitframe();
    }
    
    flag_wait( "scriptables_ready" );
    scripts\cp\munitions::remove_munitions_globally();
    function_f2beaaea12d4f510();
    level notify( "lootHackComplete" );
    flag_set( "loot_hack_complete" );
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x15b9d
// Size: 0xbf1
function function_f2beaaea12d4f510()
{
    level endon( "game_ended" );
    function_43aa5a35dfe9c585( "br_loot_cache_gulag" );
    function_43aa5a35dfe9c585( "br_loot_cache" );
    function_43aa5a35dfe9c585( "br_loot_cache_lege" );
    function_43aa5a35dfe9c585( "br_quest_safe" );
    function_43aa5a35dfe9c585( "br_scavenger_quest_cache" );
    function_43aa5a35dfe9c585( "brloot_access_card_blue" );
    function_43aa5a35dfe9c585( "brloot_access_card_blue_stadium_concourse" );
    function_43aa5a35dfe9c585( "brloot_access_card_blue_stadium_executive" );
    function_43aa5a35dfe9c585( "brloot_access_card_blue_stadium_parking" );
    function_43aa5a35dfe9c585( "brloot_access_card_green" );
    function_43aa5a35dfe9c585( "brloot_access_card_red" );
    function_43aa5a35dfe9c585( "brloot_activity_starter_combat" );
    function_43aa5a35dfe9c585( "brloot_activity_starter_hunt" );
    function_43aa5a35dfe9c585( "brloot_activity_starter_recon" );
    function_43aa5a35dfe9c585( "brloot_activity_starter_recover" );
    function_43aa5a35dfe9c585( "brloot_activity_starter_rescue" );
    function_43aa5a35dfe9c585( "brloot_activity_starter_sabotage" );
    function_43aa5a35dfe9c585( "brloot_assassination_tablet" );
    function_43aa5a35dfe9c585( "brloot_attachment_back" );
    function_43aa5a35dfe9c585( "brloot_attachment_front" );
    function_43aa5a35dfe9c585( "brloot_attachment_mag" );
    function_43aa5a35dfe9c585( "brloot_attachment_muzzle" );
    function_43aa5a35dfe9c585( "brloot_attachment_other" );
    function_43aa5a35dfe9c585( "brloot_attachment_reargrip" );
    function_43aa5a35dfe9c585( "brloot_attachment_scope" );
    function_43aa5a35dfe9c585( "brloot_attachment_underbarrel" );
    function_43aa5a35dfe9c585( "brloot_backpack" );
    function_43aa5a35dfe9c585( "brloot_backpack_large" );
    function_43aa5a35dfe9c585( "brloot_backpack_medium" );
    function_43aa5a35dfe9c585( "brloot_backpack_player_large" );
    function_43aa5a35dfe9c585( "brloot_backpack_player_medium" );
    function_43aa5a35dfe9c585( "brloot_backpack_player_small" );
    function_43aa5a35dfe9c585( "brloot_balloon_extract" );
    function_43aa5a35dfe9c585( "brloot_blueprintextract_tablet" );
    function_43aa5a35dfe9c585( "brloot_dead_agent_radio" );
    function_43aa5a35dfe9c585( "brloot_demolition_tablet" );
    function_43aa5a35dfe9c585( "brloot_dogtag" );
    function_43aa5a35dfe9c585( "brloot_domination_tablet" );
    function_43aa5a35dfe9c585( "brloot_weaponcase" );
    function_43aa5a35dfe9c585( "brloot_equip_gasmask" );
    function_43aa5a35dfe9c585( "brloot_equip_gasmask_durable" );
    function_43aa5a35dfe9c585( "brloot_equip_iodine_pills" );
    function_43aa5a35dfe9c585( "brloot_gascan" );
    function_43aa5a35dfe9c585( "brloot_health_adrenaline" );
    function_43aa5a35dfe9c585( "brloot_intel_tablet" );
    function_43aa5a35dfe9c585( "brloot_killstreak_assaultdrone" );
    function_43aa5a35dfe9c585( "brloot_killstreak_auav" );
    function_43aa5a35dfe9c585( "brloot_killstreak_chopper_gunner" );
    function_43aa5a35dfe9c585( "brloot_killstreak_circle_peek" );
    function_43aa5a35dfe9c585( "brloot_killstreak_clusterstrike" );
    function_43aa5a35dfe9c585( "brloot_killstreak_gunship" );
    function_43aa5a35dfe9c585( "brloot_killstreak_hover_jet" );
    function_43aa5a35dfe9c585( "brloot_killstreak_juggernaut" );
    function_43aa5a35dfe9c585( "brloot_killstreak_pac_sentry" );
    function_43aa5a35dfe9c585( "brloot_killstreak_precision_airstrike" );
    function_43aa5a35dfe9c585( "brloot_killstreak_recondrone" );
    function_43aa5a35dfe9c585( "brloot_killstreak_scramblerdrone" );
    function_43aa5a35dfe9c585( "brloot_killstreak_shieldturret" );
    function_43aa5a35dfe9c585( "brloot_killstreak_uav" );
    function_43aa5a35dfe9c585( "brloot_nvg" );
    function_43aa5a35dfe9c585( "brloot_offhand_advancedsupplydrop" );
    function_43aa5a35dfe9c585( "brloot_offhand_advancedvehicledrop" );
    function_43aa5a35dfe9c585( "brloot_personal_brokenglasses" );
    function_43aa5a35dfe9c585( "brloot_personal_cancermedication" );
    function_43aa5a35dfe9c585( "brloot_personal_heartlocket" );
    function_43aa5a35dfe9c585( "brloot_personal_oldwatch" );
    function_43aa5a35dfe9c585( "brloot_personal_origamihorse" );
    function_43aa5a35dfe9c585( "brloot_personal_pictureofacat" );
    function_43aa5a35dfe9c585( "brloot_personal_pictureofachild" );
    function_43aa5a35dfe9c585( "brloot_personal_pictureofadog" );
    function_43aa5a35dfe9c585( "brloot_personal_pictureofaman" );
    function_43aa5a35dfe9c585( "brloot_personal_pictureofawoman" );
    function_43aa5a35dfe9c585( "brloot_personal_smalldoll" );
    function_43aa5a35dfe9c585( "brloot_personal_toyknife" );
    function_43aa5a35dfe9c585( "brloot_personal_vialofinsulin" );
    function_43aa5a35dfe9c585( "brloot_personal_wornnecklace" );
    function_43aa5a35dfe9c585( "brloot_plate_carrier_2" );
    function_43aa5a35dfe9c585( "brloot_plate_carrier_3" );
    function_43aa5a35dfe9c585( "brloot_plate_pouch" );
    function_43aa5a35dfe9c585( "brloot_plunder_extract" );
    function_43aa5a35dfe9c585( "brloot_quest_tablet" );
    function_43aa5a35dfe9c585( "brloot_rock" );
    function_43aa5a35dfe9c585( "brloot_safecracker_tablet" );
    function_43aa5a35dfe9c585( "brloot_scavenger_tablet" );
    function_43aa5a35dfe9c585( "brloot_self_revive" );
    function_43aa5a35dfe9c585( "brloot_specialist_bonus" );
    function_43aa5a35dfe9c585( "brloot_super_armorbox" );
    function_43aa5a35dfe9c585( "brloot_super_battlerage" );
    function_43aa5a35dfe9c585( "brloot_super_deadsilence" );
    function_43aa5a35dfe9c585( "brloot_super_emppulse" );
    function_43aa5a35dfe9c585( "brloot_super_munitionsbox" );
    function_43aa5a35dfe9c585( "brloot_super_stimpistol" );
    function_43aa5a35dfe9c585( "brloot_super_stoppingpower" );
    function_43aa5a35dfe9c585( "brloot_super_tacticalcamera" );
    function_43aa5a35dfe9c585( "brloot_timedrun_tablet" );
    function_43aa5a35dfe9c585( "brloot_valuable_comicbook" );
    function_43aa5a35dfe9c585( "brloot_valuable_goldbar" );
    function_43aa5a35dfe9c585( "brloot_valuable_harddrive" );
    function_43aa5a35dfe9c585( "brloot_valuable_laptop" );
    function_43aa5a35dfe9c585( "brloot_valuable_liquor" );
    function_43aa5a35dfe9c585( "brloot_vip_tablet" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_akilo47_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_akilo47_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_akilo47_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_falpha_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_falpha_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_galima_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_kilo433_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_mcharlie_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_mcharlie_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_mike4_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_mike4_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_mike4_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_scharlie_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_scharlie_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_scharlie_unco" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_sierra552_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_ar_tango21_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_bp_reward_sm_mpapa7_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_ar" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_dm" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_kn" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_la" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_lm" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_me" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_pi" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_sh" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_sm" );
    function_43aa5a35dfe9c585( "brloot_weapon_generic_sn" );
    function_43aa5a35dfe9c585( "brloot_weapon_la_gromeo_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_la_juliet_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_la_mike32_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_la_rpapa7_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_dblmg_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_kilo121_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_kilo121_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_kilo121_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_mkilo3_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_mkilo3_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_mkilo3_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_lm_mkilo3_unco" );
    function_43aa5a35dfe9c585( "brloot_weapon_pi_golf17_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_pi_papa320_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_pi_papa320_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_sh_charlie725_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_sh_dpapa12_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sh_romeo870_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sh_romeo870_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_sh_romeo870_unco" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_augolf_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_augolf_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_augolf_unco" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_beta_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_beta_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_mpapa5_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_mpapa5_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_mpapa7_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_mpapa7_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_papa90_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_papa90_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_papa90_unco" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_uzulu_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_uzulu_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_uzulu_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_uzulu_unco" );
    function_43aa5a35dfe9c585( "brloot_weapon_sm_victor_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_alpha50_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_alpha50_lege" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_delta_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_mike14_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_mike14_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_mike14_rare" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_mike14_unco" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_mromeo_comm" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_sbeta_epic" );
    function_43aa5a35dfe9c585( "brloot_weapon_sn_sbeta_lege" );
    function_43aa5a35dfe9c585( "brloot_xp_dufflebag" );
    function_43aa5a35dfe9c585( "brloot_xp_purse" );
    function_43aa5a35dfe9c585( "dmz_boss_supply_drop" );
    function_43aa5a35dfe9c585( "dmz_crate_wood" );
    function_43aa5a35dfe9c585( "dmz_geiger_counter_cache" );
    function_43aa5a35dfe9c585( "dmz_geiger_intel" );
    function_43aa5a35dfe9c585( "dmz_hidden_container" );
    function_43aa5a35dfe9c585( "dmz_hidden_container_common" );
    function_43aa5a35dfe9c585( "dmz_intel_laptop" );
    function_43aa5a35dfe9c585( "dmz_safe" );
    function_43aa5a35dfe9c585( "dmz_secret_stash" );
    function_43aa5a35dfe9c585( "dmz_supply_drop" );
    function_43aa5a35dfe9c585( "dmz_supply_drop_samsite" );
    function_43aa5a35dfe9c585( "interactable_notebook_base" );
    function_43aa5a35dfe9c585( "loot_key_biolab_door" );
    function_43aa5a35dfe9c585( "loot_key_firefighttest01" );
    function_43aa5a35dfe9c585( "loot_key_fortress" );
    function_43aa5a35dfe9c585( "loot_key_fortress_interior" );
    function_43aa5a35dfe9c585( "loot_key_gulag" );
    function_43aa5a35dfe9c585( "loot_key_spectator_gulag" );
    function_43aa5a35dfe9c585( "loot_key_hydro_apt" );
    function_43aa5a35dfe9c585( "loot_key_hydro_storage" );
    function_43aa5a35dfe9c585( "loot_key_hydro_weapondrop" );
    function_43aa5a35dfe9c585( "loot_key_quarry_control" );
    function_43aa5a35dfe9c585( "loot_key_quarry_office" );
    function_43aa5a35dfe9c585( "loot_key_quarry_storage" );
    function_43aa5a35dfe9c585( "loot_key_resort_entrance" );
    function_43aa5a35dfe9c585( "loot_key_resort_entrance_shelf" );
    function_43aa5a35dfe9c585( "loot_key_trapper_door" );
    function_43aa5a35dfe9c585( "loot_multi_key_fortress" );
    function_43aa5a35dfe9c585( "brloot_plunder_cash_uncommon_1" );
    function_43aa5a35dfe9c585( "brloot_plunder_cash_uncommon_2" );
    function_43aa5a35dfe9c585( "brloot_plunder_cash_uncommon_3" );
    function_43aa5a35dfe9c585( "loot_key_fortress" );
    function_43aa5a35dfe9c585( "loot_key_quarry_storage" );
    function_43aa5a35dfe9c585( "loot_key_quarry_office" );
    function_43aa5a35dfe9c585( "loot_key_quarry_control" );
    function_43aa5a35dfe9c585( "loot_key_hydro_storage" );
    function_43aa5a35dfe9c585( "loot_key_hydro_apt" );
    function_43aa5a35dfe9c585( "loot_key_hydro_weapondrop" );
    function_43aa5a35dfe9c585( "loot_key_trapper_door" );
    function_43aa5a35dfe9c585( "loot_key_resort_entrance" );
    function_43aa5a35dfe9c585( "loot_multi_key_fortress" );
    function_43aa5a35dfe9c585( "brloot_access_card_blue" );
    function_43aa5a35dfe9c585( "brloot_access_card_green" );
    function_43aa5a35dfe9c585( "brloot_access_card_red" );
    function_43aa5a35dfe9c585( "brloot_quest_tablet" );
    function_43aa5a35dfe9c585( "brloot_assassination_tablet" );
    function_43aa5a35dfe9c585( "brloot_domination_tablet" );
    function_43aa5a35dfe9c585( "brloot_scavenger_tablet" );
    function_43aa5a35dfe9c585( "brloot_vip_tablet" );
    function_43aa5a35dfe9c585( "brloot_timedrun_tablet" );
    function_43aa5a35dfe9c585( "brloot_blueprintextract_tablet" );
    function_43aa5a35dfe9c585( "brloot_armor_helmet_1" );
    function_43aa5a35dfe9c585( "brloot_armor_helmet_2" );
    function_43aa5a35dfe9c585( "brloot_armor_helmet_3" );
    function_43aa5a35dfe9c585( "brloot_plate_pouch" );
    function_43aa5a35dfe9c585( "brloot_plate_carrier_2" );
    function_43aa5a35dfe9c585( "brloot_plate_carrier_3" );
    function_43aa5a35dfe9c585( "brloot_super_battlerage" );
    function_43aa5a35dfe9c585( "brloot_super_deadsilence" );
    function_43aa5a35dfe9c585( "brloot_super_emppulse" );
    function_43aa5a35dfe9c585( "brloot_super_munitionsbox" );
    function_43aa5a35dfe9c585( "brloot_super_armorbox" );
    function_43aa5a35dfe9c585( "brloot_super_stoppingpower" );
    function_43aa5a35dfe9c585( "brloot_super_weapondrop" );
    function_43aa5a35dfe9c585( "brloot_super_tacticalcamera" );
    function_43aa5a35dfe9c585( "brloot_super_tacinsert" );
    function_43aa5a35dfe9c585( "brloot_super_stimpistol" );
    function_43aa5a35dfe9c585( "brloot_offhand_advancedsupplydrop" );
    function_43aa5a35dfe9c585( "brloot_offhand_advancedvehicledrop" );
    function_43aa5a35dfe9c585( "brloot_offhand_heartbeatsensor" );
    function_43aa5a35dfe9c585( "brloot_offhand_trophysystem" );
    function_43aa5a35dfe9c585( "brloot_offhand_geigercounter" );
    function_43aa5a35dfe9c585( "brloot_offhand_shockstick" );
    function_43aa5a35dfe9c585( "brloot_offhand_deployed_decoy" );
    function_43aa5a35dfe9c585( "brloot_offhand_taccover" );
    function_43aa5a35dfe9c585( "brloot_offhand_trophysystem" );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x16796
// Size: 0xb1
function function_43aa5a35dfe9c585( lootname )
{
    if ( isdefined( level.var_c511df4aaa679c10 ) && array_contains( level.var_c511df4aaa679c10, lootname ) )
    {
        return;
    }
    
    loot = getlootscriptablearray( lootname );
    
    foreach ( item in loot )
    {
        if ( item getscriptableparthasstate( item.type, "hidden" ) )
        {
            item setscriptablepartstate( item.type, "hidden", 1 );
        }
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x1684f
// Size: 0x127
function removepatchablecollision_delayed()
{
    wait 10;
    var_5c2c9d034ebe9dcd = [];
    var_5c2c9d034ebe9dcd[ 1 ] = "tactical_ladder_col";
    var_5c2c9d034ebe9dcd[ 2 ] = "clip8x8x256";
    var_5c2c9d034ebe9dcd[ 3 ] = "player8x8x256";
    var_5c2c9d034ebe9dcd[ 4 ] = "ladderMetal264";
    var_5c2c9d034ebe9dcd[ 5 ] = "ladderWood192";
    var_5c2c9d034ebe9dcd[ 6 ] = "ladderMetal192";
    var_5c2c9d034ebe9dcd[ 7 ] = "mount128";
    var_5c2c9d034ebe9dcd[ 8 ] = "mount64";
    var_5c2c9d034ebe9dcd[ 9 ] = "mount32";
    var_5c2c9d034ebe9dcd[ 10 ] = "mount256";
    var_5c2c9d034ebe9dcd[ 11 ] = "ladderWood264";
    var_5c2c9d034ebe9dcd[ 12 ] = "nosight256x256x8";
    var_5c2c9d034ebe9dcd[ 13 ] = "nosight128x128x8";
    var_5c2c9d034ebe9dcd[ 14 ] = "mountCorner128";
    var_5c2c9d034ebe9dcd[ 15 ] = "mantle256";
    var_5c2c9d034ebe9dcd[ 16 ] = "mantle128";
    var_5c2c9d034ebe9dcd[ 17 ] = "mantle64";
    var_5c2c9d034ebe9dcd[ 18 ] = "mantle32";
    var_5c2c9d034ebe9dcd[ 19 ] = "stairsHalfFlight128";
    var_5c2c9d034ebe9dcd[ 20 ] = "stairsFullFlight128";
    
    foreach ( name in var_5c2c9d034ebe9dcd )
    {
        scripts\cp_mp\utility\game_utility::removematchingents_bykey( name, "targetname" );
    }
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x1697e
// Size: 0x4c
function function_c772ac7adc6a4637( cs_file, struct )
{
    if ( !isdefined( level.cs_object_container ) )
    {
        level.cs_object_container = [];
    }
    
    if ( isdefined( cs_file ) && !isdefined( level.cs_object_container[ cs_file ] ) )
    {
        level.cs_object_container[ cs_file ] = self;
    }
}

// Namespace utility / scripts\cp\utility
// Params 0
// Checksum 0x0, Offset: 0x169d2
// Size: 0xc
function cleanup_init()
{
    level.var_dddfaefa2e3ff7bc = [];
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x169e6
// Size: 0x4d
function function_119b3f1336549ddb( identifier, entity )
{
    if ( !isdefined( level.var_dddfaefa2e3ff7bc[ identifier ] ) )
    {
        level.var_dddfaefa2e3ff7bc[ identifier ] = [];
    }
    
    level.var_dddfaefa2e3ff7bc[ identifier ] = array_add( level.var_dddfaefa2e3ff7bc[ identifier ], entity );
}

// Namespace utility / scripts\cp\utility
// Params 2
// Checksum 0x0, Offset: 0x16a3b
// Size: 0x4d
function function_e930e06230376b96( identifier, entity )
{
    if ( !isdefined( level.var_dddfaefa2e3ff7bc[ identifier ] ) )
    {
        level.var_dddfaefa2e3ff7bc[ identifier ] = [];
    }
    
    level.var_dddfaefa2e3ff7bc[ identifier ] = array_remove( level.var_dddfaefa2e3ff7bc[ identifier ], entity );
}

// Namespace utility / scripts\cp\utility
// Params 1
// Checksum 0x0, Offset: 0x16a90
// Size: 0xd3
function function_9ee08f0499763465( identifier )
{
    assertex( isdefined( level.var_dddfaefa2e3ff7bc[ identifier ] ), " cleanup not setup for identifier: " + identifier + " recheck whether any ents have been registered ^1( scriptscputility::cleanup_registerEntForCleanup(..) ) " );
    level.var_dddfaefa2e3ff7bc[ identifier ] = array_removeundefined( level.var_dddfaefa2e3ff7bc[ identifier ] );
    
    foreach ( entity in level.var_dddfaefa2e3ff7bc[ identifier ] )
    {
        if ( isstruct( entity ) )
        {
            deletestruct_ref( entity );
        }
        
        if ( isent( entity ) )
        {
            entity delete();
        }
    }
    
    level.var_dddfaefa2e3ff7bc[ identifier ] = array_removeundefined( level.var_dddfaefa2e3ff7bc[ identifier ] );
}

