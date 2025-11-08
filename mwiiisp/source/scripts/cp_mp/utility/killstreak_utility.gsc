#using script_16ea1b94f0f381b3;
#using scripts\common\elevator;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\objidpoolmanager;

#namespace killstreak_utility;

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0xe4d
// Size: 0x14d
function createstreakinfo( streakname, owner )
{
    streakinfo = spawnstruct();
    streakinfo.streakname = streakname;
    streakinfo.owner = owner;
    
    if ( isdefined( owner ) )
    {
        streakinfo.id = getuniquekillstreakid( owner );
        streakinfo.lifeid = owner getcurrentplayerlifeidforkillstreak();
    }
    else
    {
        /#
            iprintln( "<dev string:x1c>" );
        #/
        
        streakinfo.id = 0;
        streakinfo.lifeid = 0;
    }
    
    streakinfo.score = 0;
    streakinfo.shots_fired = 0;
    streakinfo.hits = 0;
    streakinfo.damage = 0;
    streakinfo.kills = 0;
    
    if ( issharedfuncdefined( "killstreak", "createCustomStreakData" ) )
    {
        streakinfo = [[ getsharedfunc( "killstreak", "createCustomStreakData" ) ]]( streakinfo, streakname );
    }
    
    if ( isdefined( streakname ) && isdefined( level.streakglobals ) )
    {
        streakindex = level.streakglobals.var_2150da9328528bb9[ streakname ];
    }
    else
    {
        streakindex = 0;
    }
    
    if ( !isdefined( streakindex ) )
    {
        streakindex = -1;
    }
    
    streakinfo.streakindex = streakindex;
    return streakinfo;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0xfa3
// Size: 0xa0
function function_cfc5e3633ef950fd( damagestate, damageamount, damagestatefunc )
{
    if ( !isdefined( self.damagestates ) )
    {
        self.damagestates = [];
        self.currentdamagestate = 0;
    }
    
    if ( array_contains_key( self.damagestates, damagestate ) )
    {
        assertmsg( "<dev string:x55>" );
        return;
    }
    
    self.damagestates[ damagestate ] = spawnstruct();
    self.damagestates[ damagestate ].damageamount = damageamount;
    self.damagestates[ damagestate ].damagestatefunc = damagestatefunc;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x104b
// Size: 0x14a
function killstreak_updatedamagestate( currenthealth )
{
    damagestate = undefined;
    damagestatepart = undefined;
    damagestatedialog = undefined;
    states = self.damagestates;
    
    if ( isdefined( states ) )
    {
        if ( currenthealth <= states[ 3 ].damageamount )
        {
            if ( self.currentdamagestate != 3 )
            {
                damagestate = 3;
            }
        }
        else if ( currenthealth <= states[ 2 ].damageamount )
        {
            if ( self.currentdamagestate != 2 )
            {
                damagestate = 2;
            }
        }
        else if ( currenthealth <= states[ 1 ].damageamount )
        {
            if ( self.currentdamagestate != 1 )
            {
                damagestate = 1;
            }
        }
    }
    
    if ( isdefined( damagestate ) )
    {
        if ( isdefined( self.owner ) && istrue( self.ispiloted ) )
        {
            self.owner setclientomnvar( "ui_killstreak_damage_state", damagestate );
        }
        
        self [[ states[ damagestate ].damagestatefunc ]]();
        self.currentdamagestate = damagestate;
    }
    
    if ( isdefined( self.owner ) && istrue( self.ispiloted ) )
    {
        self.owner setclientomnvar( "ui_killstreak_health", currenthealth / self.maxhealth );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x119d
// Size: 0x62
function getuniquekillstreakid( player )
{
    if ( !isdefined( player.pers[ "nextKillstreakID" ] ) )
    {
        player.pers[ "nextKillstreakID" ] = 0;
    }
    
    uniqueid = player.pers[ "nextKillstreakID" ];
    player.pers[ "nextKillstreakID" ]++;
    return uniqueid;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1208
// Size: 0x35
function getcurrentplayerlifeidforkillstreak()
{
    if ( !isdefined( self.pers ) || !isdefined( self.pers[ "deaths" ] ) )
    {
        return 0;
    }
    
    return self.pers[ "deaths" ];
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x1246
// Size: 0x7f
function getkillstreaklifeid( streakname )
{
    streakitem = undefined;
    
    for ( killstreakindex = 1; killstreakindex <= 3 ; killstreakindex++ )
    {
        var_3a14cf5127d18576 = self.streakdata.streaks[ killstreakindex ];
        
        if ( isdefined( var_3a14cf5127d18576 ) && var_3a14cf5127d18576.streakname == streakname )
        {
            streakitem = var_3a14cf5127d18576;
            break;
        }
    }
    
    if ( isdefined( streakitem ) )
    {
        return streakitem.lifeid;
    }
    
    return undefined;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x12ce
// Size: 0x97
function killstreak_setmainvision( visionsetname )
{
    if ( visionsetname == "" )
    {
        self visionsetthermalforplayer( "" );
        self visionsetkillstreakforplayer( "" );
        return;
    }
    
    visionsetinfo = function_3de44eb7cdde2614( visionsetname );
    
    if ( !isdefined( visionsetinfo ) )
    {
        return;
    }
    
    fadeintime = visionsetinfo.fadeintime;
    
    if ( isdefined( visionsetinfo.type ) && visionsetinfo.type == "thermal" )
    {
        self visionsetthermalforplayer( visionsetname, fadeintime );
        return;
    }
    
    self visionsetkillstreakforplayer( visionsetname, fadeintime );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x136d
// Size: 0xba
function killstreak_setsubvision( visionsetinfo )
{
    self endon( "disconnect" );
    self notify( "playing_killstreak_subvision" );
    self endon( "playing_killstreak_subvision" );
    visionsetname = visionsetinfo.name;
    fadeintime = visionsetinfo.fadeintime;
    fadewait = visionsetinfo.fadewait;
    fadeouttime = visionsetinfo.fadeouttime;
    self visionsetfadetoblackforplayer( visionsetname, fadeintime );
    result = waittill_any_timeout_1( fadewait, "returning_killstreak_player" );
    
    if ( !isdefined( result ) || result != "timeout" )
    {
        fadeouttime = 0;
    }
    
    self visionsetfadetoblackforplayer( "", fadeouttime );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x142f
// Size: 0x14d
function registervisibilityomnvarforkillstreak( streakname, omnvarid, omnvarvalue )
{
    if ( !isdefined( level.killstreak_visbilityomnvarlist ) )
    {
        level.killstreak_visbilityomnvarlist = [];
    }
    
    assertex( isdefined( omnvarid ) && omnvarid != "off", "registerVisibilityOmnvarForKillstreak: Cannot override the off state.  That is always set to 0" );
    
    if ( isdefined( level.killstreak_visbilityomnvarlist[ streakname ] ) && isdefined( level.killstreak_visbilityomnvarlist[ streakname ][ omnvarid ] ) )
    {
        assertmsg( "registerVisibilityOmnvarForKillstreak: omnvarID already exists for this killstreak" );
        return;
    }
    
    omnvarvalueexists = 0;
    
    foreach ( var_6aa208d035887bb8 in level.killstreak_visbilityomnvarlist )
    {
        foreach ( existingvalue in var_6aa208d035887bb8 )
        {
            if ( omnvarvalue == existingvalue )
            {
                omnvarvalueexists = 1;
                break;
            }
        }
        
        if ( istrue( omnvarvalueexists ) )
        {
            assertmsg( "registerVisibilityOmnvarForKillstreak: omnvarValue already exists, please check the comment for ui_killstreak_controls to see what ranges are already reserved" );
            return;
        }
    }
    
    level.killstreak_visbilityomnvarlist[ streakname ][ omnvarid ] = omnvarvalue;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x1584
// Size: 0x67
function _setvisibiilityomnvarforkillstreak( streakname, omnvarstate )
{
    omnvarvalue = undefined;
    
    if ( omnvarstate == "off" )
    {
        omnvarvalue = 0;
    }
    else
    {
        assertex( isdefined( level.killstreak_visbilityomnvarlist[ streakname ][ omnvarstate ] ), "_setVisibiilityOmnvarForKillstreak: Killstreak is not registered, or Omnvar state is not registered" );
        omnvarvalue = level.killstreak_visbilityomnvarlist[ streakname ][ omnvarstate ];
    }
    
    self setclientomnvar( "ui_killstreak_controls", omnvarvalue );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x15f3
// Size: 0x85
function killstreakcanbeusedatroundstart( streakname )
{
    switch ( streakname )
    {
        case #"hash_10e585c25e7e9f60":
        case #"hash_27002778019fb447":
        case #"hash_634b246c3da5c56f":
        case #"hash_6d23e850410bc518":
        case #"hash_c1082193805af873":
        case #"hash_e171e5b86ef0a4cc":
        case #"hash_e3a2a26462a4fbc8":
        case #"hash_f64c697bfb4c6b54":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x1680
// Size: 0x15, Type: bool
function isvalidkillstreak( streakname )
{
    return getkillstreakindex( streakname ) != -1;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x169e
// Size: 0x34
function getkillstreakindex( streakname )
{
    streakindex = level.streakglobals.var_2150da9328528bb9[ streakname ];
    
    if ( !isdefined( streakindex ) )
    {
        return -1;
    }
    
    return streakindex;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x16db
// Size: 0x6d
function isridekillstreak( streakname )
{
    switch ( streakname )
    {
        case #"hash_28d0236400e33fd0":
        case #"hash_349713b5ad494dda":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_cf0ef5bef19a311b":
        case #"hash_e40585107590f016":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x1750
// Size: 0x79
function ismapselectkillstreak( streakname )
{
    switch ( streakname )
    {
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_195360490caa3220":
        case #"hash_4220be38a5f150b8":
        case #"hash_62810d05099e0103":
        case #"hash_b161e185f1b8e117":
        case #"hash_de3d319cd367bcba":
        case #"hash_e6bea339d3cbd3e8":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x17d1
// Size: 0x3d
function function_3c5423f8416220de( streakname )
{
    switch ( streakname )
    {
        case #"hash_4d5aa76e8707f47b":
        case #"hash_52d9b7ed584bec3e":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x1816
// Size: 0x9d
function function_d57fb9abf76f9515( streakname )
{
    switch ( streakname )
    {
        case #"hash_2289ec11d77bce8f":
        case #"hash_27002778019fb447":
        case #"hash_4ad475e6e15635bd":
        case #"hash_4d35eb58f9d545f0":
        case #"hash_56979e0566996b2e":
        case #"hash_634b246c3da5c56f":
        case #"hash_887ad77192b9c4fb":
        case #"hash_8c766d6477287bb6":
        case #"hash_b4ac3581c343a029":
        case #"hash_e171e5b86ef0a4cc":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x18bb
// Size: 0x2a, Type: bool
function function_9f1dc821e9a8506()
{
    return getdvarint( @"hash_773df58204678ff3", 0 ) == 1 && getdvarint( @"jup", 0 ) == 1;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x18ee
// Size: 0x60
function function_708853c5d755f72()
{
    bundle = undefined;
    
    if ( isdefined( level.gamemodebundle ) )
    {
        bundlename = level.gamemodebundle.killstreak_list;
        
        if ( isstring( bundlename ) )
        {
            bundle = hashcat( %"killstreaklist:", bundlename );
        }
    }
    
    if ( !isdefined( bundle ) )
    {
        return function_79e77793fa726dd8();
    }
    
    return bundle;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1957
// Size: 0x7a
function private function_79e77793fa726dd8()
{
    if ( getdvarint( @"t10", 0 ) > 0 )
    {
        /#
            utility::scriptbundlewarning( "<dev string:xaf>", "<dev string:xbe>" );
        #/
        
        return "killstreaklist:killstreak_list_t10_mp";
    }
    else if ( getdvarint( @"mgl", 0 ) > 0 )
    {
        /#
            utility::scriptbundlewarning( "<dev string:xaf>", "<dev string:xe4>" );
        #/
        
        return "killstreaklist:killstreak_list_mgl_mp";
    }
    
    /#
        utility::scriptbundlewarning( "<dev string:xaf>", "<dev string:x10a>" );
    #/
    
    return "killstreaklist:killstreak_list_iw9_mp";
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x19da
// Size: 0x4c
function isremotekillstreaktabletweapon( weaponname )
{
    remotetabletweapon = 0;
    
    switch ( weaponname )
    {
        case #"hash_70c33644073da94f":
        case #"hash_a5ecbf4077755d5e":
        case #"hash_b43c2e4c05fafc4b":
            remotetabletweapon = 1;
            break;
    }
    
    return remotetabletweapon;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x1a2f
// Size: 0x60
function starttabletscreen( streakname, dofstartdelay, var_a6b5eeb69fa71f8d )
{
    screeninfo = function_b6fda02e36d883d8( streakname );
    
    if ( !isdefined( screeninfo ) )
    {
        return;
    }
    
    thread tabletomnvarset( screeninfo.omnvar, screeninfo.index );
    
    if ( !istrue( var_a6b5eeb69fa71f8d ) )
    {
        thread tabletdofset( dofstartdelay, 0 );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x1a97
// Size: 0x60
function stoptabletscreen( streakname, var_375181444841ad, var_bfd205538a66591a )
{
    screeninfo = function_b6fda02e36d883d8( streakname );
    
    if ( !isdefined( screeninfo ) )
    {
        return;
    }
    
    if ( istrue( var_bfd205538a66591a ) )
    {
        function_d88996aa85eb88bf();
    }
    
    thread tabletomnvarset( screeninfo.omnvar, -1, var_375181444841ad );
    thread tabletdofset( var_375181444841ad, 1 );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x1aff
// Size: 0x4e
function tabletomnvarset( omnvar, omnvarval, omnvardelay )
{
    self endon( "disconnect" );
    self notify( "omnvar_set_tablet" );
    self endon( "omnvar_set_tablet" );
    
    if ( isdefined( omnvardelay ) && omnvardelay > 0 )
    {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( omnvardelay );
    }
    
    self setclientomnvar( omnvar, omnvarval );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x1b55
// Size: 0xd6
function function_b6fda02e36d883d8( streakname )
{
    if ( !isdefined( streakname ) )
    {
        /#
            iprintlnbold( "<dev string:x130>" );
        #/
        
        return;
    }
    
    if ( isdefined( streakname ) && isdefined( level.streakglobals ) )
    {
        screenindex = level.streakglobals.var_2150da9328528bb9[ streakname ];
    }
    else
    {
        screenindex = 0;
    }
    
    screenomnvar = "ui_remote_control_sequence";
    
    if ( !isdefined( screenindex ) )
    {
        screenindex = level.superglobals.staticsuperdata[ streakname ].id;
        screenomnvar = "ui_super_tablet_sequence";
        
        if ( !isdefined( screenindex ) )
        {
            /#
                iprintlnbold( "<dev string:x17e>" + streakname );
            #/
            
            return;
        }
    }
    
    tabletinfo = spawnstruct();
    tabletinfo.index = screenindex;
    tabletinfo.omnvar = screenomnvar;
    return tabletinfo;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x1c34
// Size: 0x8e
function tabletdofset( dofdelay, stopdof )
{
    self endon( "disconnect" );
    self notify( "dof_set_tablet" );
    self endon( "dof_set_tablet" );
    
    if ( isdefined( level.var_affc75ae2955c39f ) )
    {
        val::group_set( level.var_affc75ae2955c39f, 0 );
    }
    
    if ( isdefined( dofdelay ) && dofdelay > 0 )
    {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( dofdelay );
    }
    
    if ( istrue( stopdof ) )
    {
        function_178aa80b91f36bf4();
    }
    else
    {
        function_d88996aa85eb88bf();
    }
    
    if ( isdefined( level.var_affc75ae2955c39f ) )
    {
        val::group_reset( level.var_affc75ae2955c39f );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1cca
// Size: 0x22
function function_d88996aa85eb88bf()
{
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield( 0.125, 0 );
    self setphysicalviewmodeldepthoffield( 30, 256 );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1cf4
// Size: 0x9
function function_178aa80b91f36bf4()
{
    self disablephysicaldepthoffieldscripting();
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x1d05
// Size: 0x40
function function_36e63b8636445465( streakname )
{
    streakindex = level.streakglobals.var_2150da9328528bb9[ streakname ];
    self setclientomnvar( "ui_remote_control_sequence", streakindex );
    thread function_894dba22489fc8df();
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1d4d
// Size: 0x31
function function_894dba22489fc8df()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    animlength = 1;
    waittill_any_timeout_1( animlength, "death" );
    function_c914f562171b9817();
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1d86
// Size: 0x10
function function_c914f562171b9817()
{
    self setclientomnvar( "ui_remote_control_sequence", -1 );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 10
// Checksum 0x0, Offset: 0x1d9e
// Size: 0x119
function killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback )
{
    if ( isdefined( var_8dfc256103cce53e ) )
    {
        [[ var_8dfc256103cce53e ]]( streakname );
    }
    
    if ( isdefined( var_191284e2e2837328 ) )
    {
        [[ var_191284e2e2837328 ]]( streakname );
    }
    
    if ( issharedfuncdefined( "killstreak", "killstreakMakeVehicle" ) )
    {
        killstreakvehicle [[ getsharedfunc( "killstreak", "killstreakMakeVehicle" ) ]]( streakname, scorepopup, vodestroyed, destroyedsplash );
    }
    
    if ( issharedfuncdefined( "killstreak", "killstreakSetPreModDamageCallback" ) )
    {
        killstreakvehicle [[ getsharedfunc( "killstreak", "killstreakSetPreModDamageCallback" ) ]]( streakname, premoddamagecallback );
    }
    
    if ( issharedfuncdefined( "killstreak", "killstreakSetPostModDamageCallback" ) )
    {
        killstreakvehicle [[ getsharedfunc( "killstreak", "killstreakSetPostModDamageCallback" ) ]]( streakname, postmoddamagecallback );
    }
    
    if ( issharedfuncdefined( "killstreak", "killstreakSetDeathCallback" ) )
    {
        killstreakvehicle [[ getsharedfunc( "killstreak", "killstreakSetDeathCallback" ) ]]( streakname, deathcallback );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1ebf
// Size: 0x3d
function function_86ff095469a70cd2()
{
    var_a45b81b69aa779eb = self.owner;
    
    if ( istrue( self.oob ) )
    {
        var_a45b81b69aa779eb setclientomnvar( "ui_out_of_bounds_type", 0 );
        var_a45b81b69aa779eb setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1f04
// Size: 0xb1
function function_a91ebb0263d086f3()
{
    var_754414b883a90065 = self.owner;
    oobtype = undefined;
    oobtimeleft = undefined;
    
    if ( isdefined( self.oob ) && isdefined( self.oobendtime ) && isdefined( self.oobtype ) )
    {
        oobtype = self.oobtype;
        oobtimeleft = int( max( 0, self.oobendtime - gettime() ) );
        oobtimeleft = int( gettime() + oobtimeleft );
    }
    
    if ( istrue( oobtype ) && isdefined( oobtimeleft ) )
    {
        var_754414b883a90065 setclientomnvar( "ui_out_of_bounds_type", oobtype );
        var_754414b883a90065 setclientomnvar( "ui_out_of_bounds_countdown", oobtimeleft );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x1fbd
// Size: 0x6d
function function_44e0bd95b98288ab()
{
    thermalvisionset = "killstreak_thermal";
    
    if ( isdefined( level.killstreakthermalvisionset ) )
    {
        thermalvisionset = level.killstreakthermalvisionset;
    }
    
    if ( isdefined( level.mapname ) && ( issubstr( level.mapname, "mp_shipment" ) || issubstr( level.mapname, "mp_skerries" ) ) )
    {
        thermalvisionset = "killstreak_thermal_fog";
    }
    
    return thermalvisionset;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x2033
// Size: 0x18d
function function_5a9772411551e56e( streakname, charactersuffix )
{
    if ( istrue( level.disableannouncer ) )
    {
        return;
    }
    
    ent = self;
    
    if ( isdefined( self.owner ) )
    {
        ent = self.owner;
    }
    
    if ( !isdefined( streakname ) )
    {
        streakname = "chopper_gunner";
    }
    
    if ( isplayer( ent ) )
    {
        teamtocheck = ent.pers[ "team" ];
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            if ( scripts\engine\utility::issharedfuncdefined( "game", "brGetOperatorTeam" ) )
            {
                teamtocheck = [[ scripts\engine\utility::getsharedfunc( "game", "brGetOperatorTeam" ) ]]( ent );
            }
        }
        
        moderef = "mp";
        mapref = "mp_killstreak";
        sceneref = streakname;
        dialog = streakname + "_static_crash";
        eventref = game[ "dialog" ][ dialog ];
        
        if ( !isdefined( eventref ) )
        {
            game[ "dialog" ][ dialog ] = "killstreak_remote_operator_static";
            eventref = "killstreak_remote_operator_static";
        }
        
        charactertype = streakname;
        
        if ( isdefined( charactersuffix ) )
        {
            charactertype = streakname + "_" + charactersuffix;
        }
        
        characterref = function_c1309ee7d6ecc444( charactertype, teamtocheck );
        
        if ( !isdefined( characterref ) )
        {
            /#
                iprintln( "<dev string:x1c4>" );
            #/
            
            return;
        }
        
        dialogalias = createdialogalias( moderef, mapref, sceneref, characterref, eventref );
        dialogalias = tolower( dialogalias );
        ent queuedialogforplayer( dialogalias, dialog, 1 );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 5
// Checksum 0x0, Offset: 0x21c8
// Size: 0x221
function playkillstreakoperatordialog( streakname, dialog, bypasscooldown, delaytime, charactersuffix )
{
    if ( istrue( level.disableannouncer ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "dialog" ][ dialog ] ) )
    {
        /#
            iprintln( "<dev string:x1fe>" + dialog + "<dev string:x224>" );
        #/
        
        return;
    }
    
    killstreakowner = undefined;
    
    if ( isplayer( self ) )
    {
        killstreakowner = self;
    }
    else if ( isdefined( self.owner ) )
    {
        killstreakowner = self.owner;
    }
    
    if ( isdefined( delaytime ) && delaytime > 0 )
    {
        killstreakowner endon( "disconnect" );
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delaytime );
    }
    
    if ( isdefined( killstreakowner ) )
    {
        if ( istrue( killstreakowner.var_30dc7dfd9be2a276 ) )
        {
            return;
        }
        
        if ( !isdefined( killstreakowner.currentkillstreakopvo ) || istrue( bypasscooldown ) )
        {
            teamtocheck = killstreakowner.pers[ "team" ];
            
            if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
            {
                if ( scripts\engine\utility::issharedfuncdefined( "game", "brGetOperatorTeam" ) )
                {
                    teamtocheck = [[ scripts\engine\utility::getsharedfunc( "game", "brGetOperatorTeam" ) ]]( killstreakowner );
                }
            }
            
            moderef = "mp";
            mapref = function_bbb77dc4e14dcfcc( streakname );
            sceneref = streakname;
            eventref = game[ "dialog" ][ dialog ];
            characterref = streakname;
            
            if ( isdefined( charactersuffix ) )
            {
                characterref = streakname + "_" + charactersuffix;
            }
            
            characterref = function_c1309ee7d6ecc444( characterref, teamtocheck );
            
            if ( !isdefined( characterref ) )
            {
                /#
                    iprintln( "<dev string:x1c4>" );
                #/
                
                return;
            }
            
            dialogalias = createdialogalias( moderef, mapref, sceneref, characterref, eventref );
            
            if ( getdvarint( @"hash_cda8c6774f4bd53c", 1 ) && function_5b0451cdda5803e8( streakname ) )
            {
                dialogalias = function_cb073025f309906a( moderef, mapref, sceneref, characterref, eventref );
            }
            
            dialogalias = tolower( dialogalias );
            killstreakowner queuedialogforplayer( dialogalias, dialog, 1 );
            killstreakowner.currentkillstreakopvo = dialog;
            killstreakowner thread clearstoredkillstreakoperatordialog( 5 );
        }
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x23f1
// Size: 0x62
function private function_b700e27df756bafb( team )
{
    validteam = isdefined( team ) && array_contains( level.teamnamelist, team );
    
    if ( !istrue( validteam ) )
    {
        /#
            iprintln( "<dev string:x24e>" );
        #/
        
        return;
    }
    
    teamoperator = "SpecGru";
    
    if ( team == "axis" )
    {
        teamoperator = "KorTac";
    }
    
    return teamoperator;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x245c
// Size: 0x1ed
function private function_c1309ee7d6ecc444( charactertype, teamtocheck )
{
    teamref = function_b700e27df756bafb( teamtocheck );
    
    if ( !isdefined( teamref ) )
    {
        return;
    }
    
    characterstring = undefined;
    
    switch ( charactertype )
    {
        case #"hash_27002778019fb447":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
        case #"hash_e51f2e3d5cdd8ed8":
            characterstring = "UAV Operator";
            break;
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_2289ec11d77bce8f":
        case #"hash_28d0236400e33fd0":
        case #"hash_4ad475e6e15635bd":
        case #"hash_56979e0566996b2e":
        case #"hash_887ad77192b9c4fb":
        case #"hash_de3d319cd367bcba":
            characterstring = "Helo Pilot";
            break;
        case #"hash_6362d6aae3e5a62e":
        case #"hash_7a687f6a4d685110":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_a1031216158c7882":
        case #"hash_cf0ef5bef19a311b":
            characterstring = "Drone Pilot";
            break;
        case #"hash_4220be38a5f150b8":
        case #"hash_8c766d6477287bb6":
        case #"hash_b161e185f1b8e117":
            characterstring = "Airstrike Pilot";
            break;
        case #"hash_5735de454adee67b":
            characterstring = "Chopper Pilot";
            break;
        case #"hash_349713b5ad494dda":
            characterstring = "Chopper Gunner";
            break;
        case #"hash_659acc60bd11cb8e":
            characterstring = "Gunship Pilot";
            break;
        case #"hash_4a2b7af7e8ddbb45":
            characterstring = "Gunship Nav";
            break;
        case #"hash_413c38e72fe8b5bf":
            characterstring = "Gunship Sensor";
            break;
        case #"hash_b4ac3581c343a029":
            characterstring = "Mortar Gunner";
            break;
    }
    
    characteroperator = undefined;
    
    if ( isdefined( characterstring ) )
    {
        characteroperator = teamref + " " + characterstring;
    }
    
    return characteroperator;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x2652
// Size: 0x21d
function playkillstreakteamleaderdialog( streakname, dialog )
{
    if ( istrue( level.disableannouncer ) )
    {
        return;
    }
    
    if ( istrue( level.showingfinalkillcam ) )
    {
        return;
    }
    
    if ( isdefined( level.gulag ) && istrue( level.gulag.var_7d2261a38e79508d ) && isdefined( self ) && ( istrue( self.jailed ) || istrue( self.gulagarena ) || istrue( self.gulag ) ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "dialog" ][ dialog ] ) )
    {
        /#
            iprintln( "<dev string:x278>" + dialog + "<dev string:x224>" );
        #/
        
        return;
    }
    
    listenplayer = self;
    
    if ( !isplayer( self ) )
    {
        if ( isdefined( self.owner ) )
        {
            listenplayer = self.owner;
        }
        else
        {
            return;
        }
    }
    
    if ( isdefined( listenplayer ) )
    {
        if ( istrue( listenplayer.var_30dc7dfd9be2a276 ) )
        {
            return;
        }
        
        teamtocheck = listenplayer.pers[ "team" ];
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            if ( scripts\engine\utility::issharedfuncdefined( "game", "brGetOperatorTeam" ) )
            {
                teamtocheck = [[ scripts\engine\utility::getsharedfunc( "game", "brGetOperatorTeam" ) ]]( listenplayer );
            }
        }
        
        moderef = "mp";
        mapref = function_bbb77dc4e14dcfcc( streakname );
        sceneref = streakname;
        eventref = game[ "dialog" ][ dialog ];
        characterref = function_d3c62d251d2af8e6( teamtocheck );
        
        if ( !isdefined( characterref ) || !function_3f64deb57a4966b2( characterref ) )
        {
            /#
                iprintln( "<dev string:x2a0>" );
            #/
            
            return;
        }
        
        if ( streakname == "remote_turret" )
        {
            sceneref = "sentry_gun";
        }
        
        dialogalias = createdialogalias( moderef, mapref, sceneref, characterref, eventref );
        dialogalias = tolower( dialogalias );
        group = undefined;
        
        if ( isxhash( dialog ) )
        {
            group = "killstreak_earned";
            dialog = getxhashhexname( dialog );
        }
        
        listenplayer queuedialogforplayer( dialogalias, dialog, 2, group );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2877
// Size: 0x2d
function private function_bbb77dc4e14dcfcc( streakname )
{
    mapref = "mp_killstreak";
    
    if ( streakname == "radar_drone_recon" )
    {
        mapref = "mp_fieldupgrade";
    }
    
    return mapref;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x28ad
// Size: 0x3a
function private clearstoredkillstreakoperatordialog( delaytime )
{
    self endon( "disconnect" );
    self notify( "clear_stored_dialog" );
    self endon( "clear_stored_dialog" );
    wait delaytime;
    
    if ( isdefined( self.currentkillstreakopvo ) )
    {
        self.currentkillstreakopvo = undefined;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x28ef
// Size: 0x34e
function playkillstreakusedialog( streakname )
{
    if ( istrue( level.disableannouncer ) )
    {
        return;
    }
    
    killstreakowner = undefined;
    
    if ( isplayer( self ) )
    {
        killstreakowner = self;
    }
    else if ( isdefined( self.owner ) )
    {
        killstreakowner = self.owner;
    }
    
    dialogteam = killstreakowner.pers[ "team" ];
    
    if ( level.teambased )
    {
        if ( isdefined( level.killstreakactivatedtime[ streakname ] ) )
        {
            if ( isdefined( level.killstreakactivatedtime[ streakname ][ dialogteam ] ) )
            {
                if ( gettime() < level.killstreakactivatedtime[ streakname ][ dialogteam ] )
                {
                    return;
                }
            }
        }
        
        if ( isdefined( level.killstreakactivatedtime[ streakname ] ) )
        {
            level.killstreakactivatedtime[ streakname ][ dialogteam ] = gettime() + 10000;
        }
    }
    
    excludelist = [ killstreakowner ];
    listenplayers = level.players;
    
    if ( level.teambased )
    {
        othersplitscreenplayer = killstreakowner getothersplitscreenplayer();
        
        if ( isdefined( othersplitscreenplayer ) )
        {
            excludelist[ excludelist.size ] = othersplitscreenplayer;
        }
        
        var_cd8547bf474ab0c4 = canplaykillstreakdialog( streakname, 1 );
        var_53934037d8efc459 = canplaykillstreakdialog( streakname );
        
        if ( istrue( var_cd8547bf474ab0c4 ) )
        {
            if ( scripts\engine\utility::issharedfuncdefined( "game", "getTeamData" ) )
            {
                listenplayers = [[ scripts\engine\utility::getsharedfunc( "game", "getTeamData" ) ]]( dialogteam, "players" );
            }
            
            foreach ( player in listenplayers )
            {
                if ( array_contains( excludelist, player ) )
                {
                    excludelist = array_remove( excludelist, player );
                    continue;
                }
                
                player playkillstreakteamleaderdialog( streakname, streakname + "_teamleader_friendly_inbound" );
            }
        }
        
        if ( istrue( var_53934037d8efc459 ) )
        {
            foreach ( entry in level.teamnamelist )
            {
                if ( entry == dialogteam )
                {
                    continue;
                }
                
                if ( scripts\engine\utility::issharedfuncdefined( "game", "getTeamData" ) )
                {
                    listenplayers = [[ scripts\engine\utility::getsharedfunc( "game", "getTeamData" ) ]]( entry, "players" );
                }
                
                foreach ( player in listenplayers )
                {
                    if ( isdefined( excludelist ) && array_contains( excludelist, player ) )
                    {
                        excludelist = array_remove( excludelist, player );
                        continue;
                    }
                    
                    player playkillstreakteamleaderdialog( streakname, streakname + "_teamleader_enemy_inbound" );
                }
            }
        }
        
        return;
    }
    
    foreach ( player in listenplayers )
    {
        if ( array_contains( excludelist, player ) )
        {
            continue;
        }
        
        player playkillstreakteamleaderdialog( streakname, streakname + "_teamleader_enemy_inbound" );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x2c45
// Size: 0x1c0
function canplaykillstreakdialog( streakname, friendly )
{
    canplay = 1;
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( istrue( friendly ) )
        {
            switch ( streakname )
            {
                case #"hash_4d35eb58f9d545f0":
                case #"hash_4d5aa76e8707f47b":
                case #"hash_56979e0566996b2e":
                case #"hash_9e36e3bd3a9dd00d":
                    canplay = 0;
                    break;
            }
        }
        else
        {
            switch ( streakname )
            {
                case #"hash_27002778019fb447":
                case #"hash_4d35eb58f9d545f0":
                case #"hash_4d5aa76e8707f47b":
                case #"hash_56979e0566996b2e":
                case #"hash_634b246c3da5c56f":
                case #"hash_8c766d6477287bb6":
                case #"hash_9e36e3bd3a9dd00d":
                case #"hash_b4ac3581c343a029":
                case #"hash_e171e5b86ef0a4cc":
                case #"hash_e40585107590f016":
                    canplay = 0;
                    break;
            }
        }
    }
    else if ( scripts\cp_mp\utility\game_utility::function_22cd3d64fdb05892() )
    {
        if ( istrue( friendly ) )
        {
            switch ( streakname )
            {
                case #"hash_4d35eb58f9d545f0":
                case #"hash_4d5aa76e8707f47b":
                case #"hash_56979e0566996b2e":
                case #"hash_9e36e3bd3a9dd00d":
                    canplay = 0;
                    break;
            }
        }
        else
        {
            switch ( streakname )
            {
                case #"hash_4d35eb58f9d545f0":
                case #"hash_56979e0566996b2e":
                case #"hash_9e36e3bd3a9dd00d":
                case #"hash_b161e185f1b8e117":
                case #"hash_e40585107590f016":
                    canplay = 0;
                    break;
            }
        }
    }
    else if ( istrue( friendly ) )
    {
        canplay = 1;
    }
    else
    {
        switch ( streakname )
        {
            case #"hash_b161e185f1b8e117":
                canplay = 0;
                break;
        }
    }
    
    return canplay;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x2e0e
// Size: 0x4
function getkillstreakdialogcooldown()
{
    return 10;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x2e1b
// Size: 0x3e, Type: bool
function function_ac7849e6c5020da0( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    return istrue( bundle.var_e408b79ae78f84bc );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 5
// Checksum 0x0, Offset: 0x2e62
// Size: 0x141
function killstreak_dangernotifyplayersinrange( owner, ownerteam, range, streakname, location )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    var_817c84503edead03 = function_7813d0917a42fb04( streakname );
    
    if ( !var_817c84503edead03 )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_d218c959e1a09e1d", 0 ) )
        {
            start = location + ( 0, 0, 1000 );
            end = location + ( 0, 0, -1000 );
            cylinder( start, end, range, ( 1, 0, 0 ), 1, 500 );
        }
    #/
    
    var_6e7b34fc3e0f199 = 0;
    
    if ( streakname == "uav" || streakname == "directional_uav" )
    {
        var_6e7b34fc3e0f199 = 1;
    }
    
    playersinrange = function_c1236c65472ee948( owner, ownerteam, location, range, var_6e7b34fc3e0f199, streakname );
    
    foreach ( player in playersinrange )
    {
        function_7abec5ff1c445e2b( player, streakname );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2fab
// Size: 0x10d
function private function_7813d0917a42fb04( streakname )
{
    var_817c84503edead03 = 0;
    isbrgamemode = scripts\cp_mp\utility\game_utility::isbrstylegametype();
    var_490dc70d342b04a2 = scripts\cp_mp\utility\game_utility::function_22cd3d64fdb05892();
    
    if ( isbrgamemode )
    {
        switch ( streakname )
        {
            case #"hash_27002778019fb447":
            case #"hash_4d35eb58f9d545f0":
            case #"hash_4d5aa76e8707f47b":
            case #"hash_634b246c3da5c56f":
            case #"hash_80c5f88142053bf4":
            case #"hash_8c766d6477287bb6":
            case #"hash_9e36e3bd3a9dd00d":
            case #"hash_b4ac3581c343a029":
            case #"hash_e171e5b86ef0a4cc":
            case #"hash_e40585107590f016":
                var_817c84503edead03 = 1;
                break;
        }
    }
    else if ( var_490dc70d342b04a2 )
    {
        switch ( streakname )
        {
            case #"hash_4d35eb58f9d545f0":
            case #"hash_9e36e3bd3a9dd00d":
            case #"hash_e40585107590f016":
                var_817c84503edead03 = 1;
                break;
        }
    }
    else
    {
        var_817c84503edead03 = function_ac7849e6c5020da0( streakname );
    }
    
    return var_817c84503edead03;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x30c1
// Size: 0x78
function private function_7abec5ff1c445e2b( player, streakname )
{
    isbrgamemode = scripts\cp_mp\utility\game_utility::isbrstylegametype();
    var_490dc70d342b04a2 = scripts\cp_mp\utility\game_utility::function_22cd3d64fdb05892();
    
    if ( isbrgamemode || function_ac7849e6c5020da0( streakname ) )
    {
        if ( issharedfuncdefined( "killstreak", "dangerNotifyPlayer" ) )
        {
            [[ getsharedfunc( "killstreak", "dangerNotifyPlayer" ) ]]( player, streakname );
        }
        
        return;
    }
    
    function_7585eeda84603d89( player, streakname );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x3141
// Size: 0xde
function function_7585eeda84603d89( player, notifytype )
{
    var_beb9e876857446fc = 1;
    
    if ( isdefined( level.var_5a81cd5a6ae1c552 ) && isdefined( level.var_ed3bbed90e848793 ) )
    {
        if ( isdefined( level.var_ed3bbed90e848793[ notifytype ] ) && isdefined( level.var_ed3bbed90e848793[ notifytype ][ player.guid ] ) && gettime() < level.var_ed3bbed90e848793[ notifytype ][ player.guid ] )
        {
            var_beb9e876857446fc = 0;
        }
        else
        {
            level.var_ed3bbed90e848793[ notifytype ][ player.guid ] = gettime() + level.var_5a81cd5a6ae1c552 * 1000;
        }
    }
    
    if ( istrue( var_beb9e876857446fc ) && isdefined( notifytype ) && isvalidkillstreak( notifytype ) )
    {
        player scripts\cp_mp\utility\killstreak_utility::playkillstreakteamleaderdialog( notifytype, notifytype + "_teamleader_enemy_inbound" );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3227
// Size: 0x45, Type: bool
function private function_55a9c42f477b156( streakname )
{
    if ( !isdefined( streakname ) )
    {
        return false;
    }
    
    if ( !istrue( level.var_6e488f8ea3d98872 ) )
    {
        return false;
    }
    
    if ( streakname == "toma_strike" || streakname == "precision_airstrike" || streakname == "bunker_buster" )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x3275
// Size: 0x1b9
function private function_c1236c65472ee948( owner, ownerteam, location, range, var_6e7b34fc3e0f199, streakname )
{
    var_4f152ad6a2c5331f = [];
    var_926ed5f85fdb6b34 = [];
    
    if ( !isdefined( range ) )
    {
        range = 5000;
    }
    
    if ( isdefined( owner ) )
    {
        if ( !function_55a9c42f477b156( streakname ) )
        {
            var_926ed5f85fdb6b34 = [ owner ];
        }
        
        if ( level.teambased )
        {
            if ( function_55a9c42f477b156( streakname ) )
            {
                var_926ed5f85fdb6b34 = [];
                
                foreach ( player in level.teamdata[ ownerteam ][ "players" ] )
                {
                    if ( player != owner )
                    {
                        var_926ed5f85fdb6b34[ var_926ed5f85fdb6b34.size ] = player;
                    }
                }
            }
            else
            {
                var_926ed5f85fdb6b34 = level.teamdata[ ownerteam ][ "players" ];
            }
        }
        
        if ( !isdefined( location ) )
        {
            location = owner.origin;
        }
        
        if ( istrue( var_6e7b34fc3e0f199 ) )
        {
            foreach ( player in var_926ed5f85fdb6b34 )
            {
                var_399dead7db0f7ab = function_7fbde10147e5b269( player.origin, range, var_926ed5f85fdb6b34, var_4f152ad6a2c5331f );
                var_4f152ad6a2c5331f = array_combine( var_4f152ad6a2c5331f, var_399dead7db0f7ab );
            }
        }
        else
        {
            var_4f152ad6a2c5331f = function_7fbde10147e5b269( location, range, var_926ed5f85fdb6b34 );
        }
    }
    else
    {
        if ( !isdefined( location ) )
        {
            /#
                iprintln( "<dev string:x2dc>" );
            #/
            
            return var_4f152ad6a2c5331f;
        }
        
        var_4f152ad6a2c5331f = function_7fbde10147e5b269( location, range );
    }
    
    return var_4f152ad6a2c5331f;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3437
// Size: 0xdf
function private function_7fbde10147e5b269( location, range, var_926ed5f85fdb6b34, var_3bfcc99e8967473f )
{
    enemiesinrange = [];
    enemyplayersinrange = utility::playersincylinder( location, range, var_926ed5f85fdb6b34 );
    
    foreach ( enemyplayer in enemyplayersinrange )
    {
        if ( !isdefined( enemyplayer ) || isbot( enemyplayer ) || isagent( enemyplayer ) || !enemyplayer _isalive() || enemyplayer _isalive() && istrue( enemyplayer.gulag ) )
        {
            continue;
        }
        
        if ( function_f62830c98ee6a880( enemyplayer, var_3bfcc99e8967473f ) )
        {
            continue;
        }
        
        enemiesinrange[ enemiesinrange.size ] = enemyplayer;
    }
    
    return enemiesinrange;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x351f
// Size: 0x84
function private function_f62830c98ee6a880( enemyplayer, var_3bfcc99e8967473f )
{
    if ( !isdefined( var_3bfcc99e8967473f ) || var_3bfcc99e8967473f.size == 0 )
    {
        return 0;
    }
    
    var_84021bc9dbe22e9 = 0;
    
    foreach ( var_fffcb11a16d147f6 in var_3bfcc99e8967473f )
    {
        if ( isdefined( var_fffcb11a16d147f6 ) && var_fffcb11a16d147f6 == enemyplayer )
        {
            var_84021bc9dbe22e9 = 1;
            break;
        }
    }
    
    return var_84021bc9dbe22e9;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 6
// Checksum 0x0, Offset: 0x35ac
// Size: 0xd8
function killstreak_createdangerzone( location, radius, height, timeout, owner, team )
{
    if ( issharedfuncdefined( "game", "lpcFeatureGated" ) && [[ getsharedfunc( "game", "lpcFeatureGated" ) ]]() )
    {
        return;
    }
    
    killstreak_destroydangerzone();
    dangerzoneid = undefined;
    
    if ( isdefined( owner ) && isdefined( team ) )
    {
        dangerzoneid = [[ getsharedfunc( "spawn", "addSpawnDangerZone" ) ]]( location, radius, height, team, timeout, owner, 1 );
    }
    else if ( isdefined( team ) )
    {
        dangerzoneid = [[ getsharedfunc( "spawn", "addSpawnDangerZone" ) ]]( location, radius, height, team, timeout, undefined, 1 );
    }
    else
    {
        dangerzoneid = killstreak_spawnuniversaldangerzone( location, radius, height, timeout );
    }
    
    self.dangerzoneid = dangerzoneid;
    return dangerzoneid;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 4
// Checksum 0x0, Offset: 0x368d
// Size: 0x7f
function killstreak_spawnuniversaldangerzone( location, radius, height, timeout )
{
    if ( !issharedfuncdefined( "spawn", "addSpawnDangerZone" ) )
    {
        return;
    }
    
    dangerzoneid = [[ getsharedfunc( "spawn", "addSpawnDangerZone" ) ]]( location, radius, height, undefined, timeout, level.players[ randomint( level.players.size ) ], 1 );
    self.dangerzoneid = dangerzoneid;
    return dangerzoneid;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x3715
// Size: 0x93
function killstreak_destroydangerzone( dangerzoneid )
{
    if ( !isdefined( dangerzoneid ) && !isdefined( self.dangerzoneid ) )
    {
        return;
    }
    
    if ( !issharedfuncdefined( "spawn", "isSpawnDangerZoneAlive" ) || !issharedfuncdefined( "spawn", "removeSpawnDangerZone" ) )
    {
        return;
    }
    
    if ( !isdefined( dangerzoneid ) )
    {
        dangerzoneid = self.dangerzoneid;
    }
    
    if ( isdefined( dangerzoneid ) && [[ getsharedfunc( "spawn", "isSpawnDangerZoneAlive" ) ]]( dangerzoneid ) )
    {
        [[ getsharedfunc( "spawn", "removeSpawnDangerZone" ) ]]( dangerzoneid );
    }
    
    self.dangerzoneid = undefined;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 6
// Checksum 0x0, Offset: 0x37b0
// Size: 0x115
function function_b68537eebdc298f1( targetlocation, iconname, owner, zoffset, lifetime, scriptablename )
{
    dangermarker = spawn( "script_model", targetlocation );
    dangermarker.icon = iconname;
    dangermarker.owner = owner;
    
    if ( !isdefined( zoffset ) )
    {
        zoffset = 50;
    }
    
    dangermarker.zoffset = zoffset;
    
    if ( !isdefined( lifetime ) )
    {
        lifetime = 5;
    }
    
    dangermarker.lifetime = lifetime;
    modelname = "tag_origin";
    
    if ( isdefined( scriptablename ) )
    {
        modelname = scriptablename;
        dangermarker.scriptable = scriptablename;
    }
    
    dangermarker setmodel( modelname );
    dangermarker setotherent( owner );
    
    if ( scripts\engine\utility::issharedfuncdefined( "game", "requestObjectiveID" ) )
    {
        dangermarker.objidnum = [[ scripts\engine\utility::getsharedfunc( "game", "requestObjectiveID" ) ]]( 99 );
    }
    
    dangermarker function_f834e6b9fb11e9c0( dangermarker.objidnum );
    dangermarker thread function_a6801238f6a7b430();
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x38cd
// Size: 0xbc
function private function_f834e6b9fb11e9c0( objid )
{
    icon = self.icon;
    owner = self.owner;
    zoffset = self.zoffset;
    objective_icon( objid, icon );
    objective_showtoplayersinmask( objid );
    objective_addclienttomask( objid, owner );
    objective_onentity( objid, self );
    objective_setzoffset( objid, zoffset );
    objective_setplayintro( objid, 0 );
    objective_setplayoutro( objid, 0 );
    objective_setbackground( objid, 1 );
    
    if ( level.teambased )
    {
        objective_setownerteam( objid, owner.team );
    }
    else
    {
        objective_setownerclient( objid, owner );
    }
    
    objective_state( objid, "current" );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3991
// Size: 0x7f
function private function_a6801238f6a7b430()
{
    self endon( "death" );
    lifetime = self.lifetime;
    
    if ( isdefined( self.scriptable ) )
    {
        self setscriptablepartstate( "target", "on", 0 );
    }
    
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( lifetime );
    
    if ( isdefined( self ) )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "game", "returnObjectiveID" ) )
        {
            [[ scripts\engine\utility::getsharedfunc( "game", "returnObjectiveID" ) ]]( self.objidnum );
        }
        
        self delete();
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x3a18
// Size: 0x53
function streakcanseetarget( startpos, endpos, ignorelist )
{
    icansee = 0;
    contents = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    if ( scripts\engine\trace::ray_trace_passed( startpos, endpos, ignorelist, contents ) )
    {
        icansee = 1;
    }
    
    return icansee;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 4
// Checksum 0x0, Offset: 0x3a74
// Size: 0x38b
function function_999fe3838d6b6f8c( startingpos, startingangles, var_4d5392d9a61722c2, flightdistance )
{
    setdvarifuninitialized( @"hash_313823a110b35022", 0 );
    flightangles = ( 0, startingangles[ 1 ], 0 );
    entforward = anglestoforward( flightangles );
    entright = anglestoright( flightangles );
    contents = scripts\engine\trace::create_default_contents( 1 );
    
    if ( !isdefined( flightdistance ) )
    {
        flightdistance = 15000;
    }
    
    positionchecklist = [ startingpos - entforward * flightdistance, startingpos + entforward * flightdistance, startingpos + entright * flightdistance, startingpos - entright * flightdistance, startingpos + ( entforward + entright ) * flightdistance, startingpos + ( entforward - entright ) * flightdistance, startingpos + ( entright - entforward ) * flightdistance, startingpos + ( -1 * entforward - entright ) * flightdistance ];
    
    if ( !isdefined( var_4d5392d9a61722c2 ) )
    {
        var_4d5392d9a61722c2 = 512;
    }
    
    flightpath = spawnstruct();
    flightpath.start = startingpos;
    flightpath.end = undefined;
    flightpath.angles = undefined;
    debugdrawpath = getdvarint( @"hash_313823a110b35022", 0 );
    
    foreach ( dirpos in positionchecklist )
    {
        var_7a7426e42e674e40 = vectornormalize( dirpos - startingpos );
        endingpos = startingpos + var_7a7426e42e674e40 * flightdistance;
        traceresult = scripts\engine\trace::sphere_trace( startingpos, endingpos, var_4d5392d9a61722c2, undefined, contents );
        
        if ( isdefined( traceresult ) && isdefined( traceresult[ "hittype" ] ) && traceresult[ "hittype" ] != "hittype_none" )
        {
            positionhit = traceresult[ "position" ];
            mindistthreshold = flightdistance * 0.75;
            mindistthresholdsq = mindistthreshold * mindistthreshold;
            
            if ( distance2dsquared( startingpos, positionhit ) >= mindistthresholdsq )
            {
                flightangles = vectortoangles( dirpos - startingpos );
                forwarddir = anglestoforward( flightangles );
                distdiff = distance2d( dirpos, positionhit );
                flightpath.end = dirpos - forwarddir * distdiff;
                flightpath.angles = flightangles;
                
                /#
                    if ( debugdrawpath )
                    {
                        level thread scripts\cp_mp\utility\debug_utility::drawline( startingpos, dirpos, 30, ( 1, 1, 0 ) );
                        level thread scripts\cp_mp\utility\debug_utility::drawsphere( positionhit, 50, 30, ( 1, 1, 0 ) );
                        level thread scripts\cp_mp\utility\debug_utility::drawsphere( flightpath.end, 50, 30, ( 0, 1, 0 ) );
                    }
                #/
                
                break;
            }
            
            /#
                if ( debugdrawpath )
                {
                    level thread scripts\cp_mp\utility\debug_utility::drawline( startingpos, dirpos, 30, ( 1, 0, 0 ) );
                    level thread scripts\cp_mp\utility\debug_utility::drawsphere( positionhit, 50, 30, ( 1, 0, 0 ) );
                }
            #/
            
            continue;
        }
        else
        {
            /#
                if ( debugdrawpath )
                {
                    level thread scripts\cp_mp\utility\debug_utility::drawline( startingpos, dirpos, 30, ( 0, 1, 0 ) );
                }
            #/
        }
        
        flightpath.end = dirpos;
        flightpath.angles = vectortoangles( dirpos - startingpos );
        break;
    }
    
    return flightpath;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 5
// Checksum 0x0, Offset: 0x3e08
// Size: 0x1bf
function function_e68434bdb941ed1e( streakname, streakowner, hintstring, var_13c7df650c45a90b, hinticon )
{
    if ( !isdefined( self.owner ) )
    {
        /#
            iprintln( "<dev string:x32c>" );
        #/
        
        return;
    }
    
    if ( !isdefined( streakowner.var_c112b4aeaf6ce9ae ) )
    {
        streakowner.var_c112b4aeaf6ce9ae = [];
        level thread function_5180e13c7ef6e8e2( streakowner );
    }
    
    if ( !isdefined( function_ba2553e1d254532e( streakname, streakowner ) ) )
    {
        useobj = spawn( "script_model", self.origin );
        useobj setmodel( "tag_origin" );
        useobj linkto( self, function_8e620817af96d5e( streakname ), ( 0, 0, 0 ), ( 0, 0, 0 ) );
        useobj.owner = streakowner;
        useobj.streakname = streakname;
        useobj.activeuseobject = 0;
        useobj.parentent = self;
        useobj.var_59f4b576f611fb4a = 0;
        useobj.var_89530ba56809ec76 = 0;
        
        if ( istrue( var_13c7df650c45a90b ) )
        {
            useobj.var_89530ba56809ec76 = 1;
        }
        
        if ( issharedfuncdefined( "killstreak", "setKillstreakControlPriority" ) )
        {
            useobj [[ getsharedfunc( "killstreak", "setKillstreakControlPriority" ) ]]( streakowner, hintstring, 360, 360, 65535, 65535, 1, 1 );
        }
        
        streakowner.var_c112b4aeaf6ce9ae[ streakname ] = useobj;
        
        if ( streakname == "hover_jet" )
        {
            if ( !istrue( streakowner.remoteturretactive ) )
            {
                function_6ada614d8209afb0( useobj );
            }
        }
        else
        {
            function_6ada614d8209afb0( useobj );
        }
        
        level thread function_8b29ae6ad84b5bf2( useobj );
        level thread function_cdeddff1537455f5( useobj );
        self.useobj = useobj;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3fcf
// Size: 0x146
function private function_5180e13c7ef6e8e2( owner )
{
    owner endon( "disconnect" );
    level endon( "game_ended" );
    
    /#
        setdevdvarifuninitialized( @"hash_c2417142804c1c76", 0 );
    #/
    
    focususe = getdvarint( @"hash_c2417142804c1c76", 0 );
    
    if ( !istrue( focususe ) )
    {
        return;
    }
    
    while ( true )
    {
        var_99cd5e83081cf893 = owner.var_c112b4aeaf6ce9ae;
        var_2e6169ddef8528bc = undefined;
        bestdistance = undefined;
        
        foreach ( useobj in var_99cd5e83081cf893 )
        {
            if ( isdefined( useobj ) )
            {
                if ( function_d21cbd391e26dc69( useobj ) )
                {
                    if ( !isdefined( bestdistance ) )
                    {
                        bestdistance = distance2dsquared( useobj.origin, owner getvieworigin() );
                        var_2e6169ddef8528bc = useobj;
                        continue;
                    }
                    
                    newdistance = distance2dsquared( useobj.origin, owner getvieworigin() );
                    
                    if ( newdistance < bestdistance )
                    {
                        bestdistance = newdistance;
                        var_2e6169ddef8528bc = useobj;
                    }
                }
            }
        }
        
        if ( isdefined( var_2e6169ddef8528bc ) )
        {
            if ( !function_c2917d8b2264d8ac( var_2e6169ddef8528bc ) )
            {
                function_6ada614d8209afb0( var_2e6169ddef8528bc, 1 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x411d
// Size: 0xdf
function private function_6ada614d8209afb0( useobj, highlight )
{
    if ( isdefined( useobj ) )
    {
        owner = useobj.owner;
        
        if ( isdefined( owner ) )
        {
            function_8119afac7789ef49( owner );
            
            if ( owner namespace_53fc9ddbb516e6e1::isjuggernautsharedfunc() )
            {
                var_ad1bd6904a1e2ee6 = function_e36773e138b55c8d( owner );
                
                if ( isdefined( var_ad1bd6904a1e2ee6 ) )
                {
                    var_ad1bd6904a1e2ee6.var_59f4b576f611fb4a = 0;
                    var_ad1bd6904a1e2ee6 notify( "clear_suspended_use_object" );
                }
                
                if ( !istrue( useobj.var_89530ba56809ec76 ) )
                {
                    function_3f55c1fb553a4775( owner, useobj );
                }
                else
                {
                    function_7d36b03e034c2ab1( useobj, highlight );
                }
                
                return;
            }
            
            if ( istrue( owner.inlaststand ) )
            {
                var_ad1bd6904a1e2ee6 = function_e36773e138b55c8d( owner );
                
                if ( isdefined( var_ad1bd6904a1e2ee6 ) )
                {
                    var_ad1bd6904a1e2ee6.var_59f4b576f611fb4a = 0;
                    var_ad1bd6904a1e2ee6 notify( "clear_suspended_use_object" );
                }
                
                function_3f55c1fb553a4775( owner, useobj );
                return;
            }
            
            function_7d36b03e034c2ab1( useobj, highlight );
        }
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4204
// Size: 0x2a
function private function_8119afac7789ef49( owner )
{
    activestreakobj = function_bb606c9e5540fd7c( owner );
    
    if ( isdefined( activestreakobj ) )
    {
        function_d41c2beeb4ef154e( activestreakobj );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4236
// Size: 0x40
function private function_7d36b03e034c2ab1( useobj, highlight )
{
    useobj enableplayeruse( useobj.owner );
    useobj.activeuseobject = 1;
    
    if ( istrue( highlight ) )
    {
        useobj notify( "useObj_start_highlight" );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x427e
// Size: 0x2a
function private function_d41c2beeb4ef154e( useobj )
{
    useobj disableplayeruse( useobj.owner );
    useobj.activeuseobject = 0;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x42b0
// Size: 0x3d
function function_3f55c1fb553a4775( owner, useobjoverride )
{
    if ( !isdefined( owner ) || !isplayer( owner ) )
    {
        /#
            iprintln( "<dev string:x37b>" );
        #/
        
        return;
    }
    
    level thread function_e01c5830af200d33( owner, useobjoverride );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x42f5
// Size: 0x9e
function private function_e01c5830af200d33( owner, useobjoverride )
{
    level endon( "game_ended" );
    activestreakobj = function_bb606c9e5540fd7c( owner );
    
    if ( isdefined( useobjoverride ) )
    {
        activestreakobj = useobjoverride;
    }
    
    if ( isdefined( activestreakobj ) )
    {
        if ( istrue( activestreakobj.var_89530ba56809ec76 ) && owner namespace_53fc9ddbb516e6e1::isjuggernautsharedfunc() )
        {
            return;
        }
        
        owner endon( "disconnect" );
        activestreakobj notify( "start_suspended_use_object" );
        activestreakobj endon( "start_suspended_use_object" );
        activestreakobj endon( "clear_suspended_use_object" );
        activestreakobj endon( "death" );
        activestreakobj.var_59f4b576f611fb4a = 1;
        function_d41c2beeb4ef154e( activestreakobj );
        activestreakobj waittill( "restore_global_use_object" );
        function_7d36b03e034c2ab1( activestreakobj );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x439b
// Size: 0x37
function function_17576a4cdcd447a7( owner )
{
    var_ed247742b7c53a61 = function_e36773e138b55c8d( owner );
    
    if ( isdefined( var_ed247742b7c53a61 ) )
    {
        var_ed247742b7c53a61.var_59f4b576f611fb4a = 0;
        var_ed247742b7c53a61 notify( "restore_global_use_object" );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x43da
// Size: 0xc5
function private function_8b29ae6ad84b5bf2( useobj )
{
    useobj endon( "death" );
    focususe = getdvarint( @"hash_c2417142804c1c76", 0 );
    
    if ( !istrue( focususe ) )
    {
        return;
    }
    
    var_2619f56748f3be6e = "outline_nodepth_useobj_";
    function_c4daa28ff838e59c( useobj, var_2619f56748f3be6e + "default" );
    
    while ( true )
    {
        result = useobj waittill_any_return_2( "useObj_start_highlight", "useObj_stop_highlight" );
        
        if ( result == "useObj_start_highlight" )
        {
            useobj.highlighted = 1;
            function_c4daa28ff838e59c( useobj, var_2619f56748f3be6e + "highlight" );
            level childthread function_93cafec896797c8c( useobj );
            continue;
        }
        
        useobj.highlighted = 0;
        function_c4daa28ff838e59c( useobj, var_2619f56748f3be6e + "default" );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x44a7
// Size: 0x68
function private function_c4daa28ff838e59c( useobj, outlineasset )
{
    function_904bace0562c3a7b( useobj );
    
    if ( issharedfuncdefined( "outline", "outlineEnableForPlayer" ) )
    {
        useobj.outlineid = [[ getsharedfunc( "outline", "outlineEnableForPlayer" ) ]]( useobj.parentent, useobj.owner, outlineasset, "killstreak" );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4517
// Size: 0x56
function private function_904bace0562c3a7b( useobj )
{
    if ( isdefined( useobj.outlineid ) )
    {
        if ( issharedfuncdefined( "outline", "outlineDisable" ) )
        {
            [[ getsharedfunc( "outline", "outlineDisable" ) ]]( useobj.outlineid, useobj.parentent );
        }
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4575
// Size: 0x21
function private function_93cafec896797c8c( useobj )
{
    while ( function_d21cbd391e26dc69( useobj ) )
    {
        waitframe();
    }
    
    useobj notify( "useObj_stop_highlight" );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x459e
// Size: 0x2a
function private function_d21cbd391e26dc69( useobj )
{
    return useobj.owner worldpointinreticle_circle( useobj.origin, 80, 200 );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x45d1
// Size: 0x17, Type: bool
function private function_c2917d8b2264d8ac( useobj )
{
    return istrue( useobj.highlighted );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x45f1
// Size: 0x149
function private function_cdeddff1537455f5( useobj )
{
    level endon( "game_ended" );
    result = useobj.parentent waittill_any_return_4( "death", "explode", "leaving", "crashing" );
    
    if ( isdefined( useobj.owner ) )
    {
        function_904bace0562c3a7b( useobj );
        useobj.owner.var_c112b4aeaf6ce9ae = array_remove_index( useobj.owner.var_c112b4aeaf6ce9ae, useobj.streakname, 1 );
        
        if ( function_926aeeddaaa0e670( useobj ) )
        {
            activeobjects = useobj.owner.var_c112b4aeaf6ce9ae;
            
            if ( activeobjects.size > 0 )
            {
                newuseobj = undefined;
                
                foreach ( activeobj in activeobjects )
                {
                    if ( isdefined( activeobj ) )
                    {
                        newuseobj = activeobj;
                        break;
                    }
                }
                
                if ( isdefined( newuseobj ) )
                {
                    function_6ada614d8209afb0( newuseobj );
                }
            }
        }
        else
        {
            function_d41c2beeb4ef154e( useobj );
        }
    }
    
    if ( isdefined( useobj ) )
    {
        useobj delete();
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4742
// Size: 0x58
function private function_ba2553e1d254532e( streakname, owner )
{
    if ( !isdefined( owner ) || !isdefined( owner.var_c112b4aeaf6ce9ae ) )
    {
        return undefined;
    }
    
    useobject = undefined;
    
    if ( isdefined( owner.var_c112b4aeaf6ce9ae[ streakname ] ) )
    {
        useobject = owner.var_c112b4aeaf6ce9ae[ streakname ];
    }
    
    return useobject;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x47a3
// Size: 0x90
function private function_bb606c9e5540fd7c( owner )
{
    if ( !isdefined( owner ) || !isdefined( owner.var_c112b4aeaf6ce9ae ) )
    {
        return undefined;
    }
    
    activeuseobj = undefined;
    
    foreach ( useobj in owner.var_c112b4aeaf6ce9ae )
    {
        if ( istrue( useobj.activeuseobject ) )
        {
            activeuseobj = useobj;
            break;
        }
    }
    
    return activeuseobj;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x483c
// Size: 0x90
function private function_e36773e138b55c8d( owner )
{
    if ( !isdefined( owner ) || !isdefined( owner.var_c112b4aeaf6ce9ae ) )
    {
        return undefined;
    }
    
    var_ad1bd6904a1e2ee6 = undefined;
    
    foreach ( useobj in owner.var_c112b4aeaf6ce9ae )
    {
        if ( istrue( useobj.var_59f4b576f611fb4a ) )
        {
            var_ad1bd6904a1e2ee6 = useobj;
            break;
        }
    }
    
    return var_ad1bd6904a1e2ee6;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x48d5
// Size: 0x17, Type: bool
function private function_926aeeddaaa0e670( useobj )
{
    return istrue( useobj.activeuseobject );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x48f5
// Size: 0x6f
function private function_8e620817af96d5e( streakname )
{
    linktotag = "tag_origin";
    
    switch ( streakname )
    {
        case #"hash_bf2f9adbd2b41d5":
            break;
        case #"hash_cf0ef5bef19a311b":
            linktotag = "tag_body";
            break;
        case #"hash_ab5712e297cd430e":
            linktotag = "tag_aim_pivot";
            break;
        default:
            break;
    }
    
    return linktotag;
}

/#

    // Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x496d
    // Size: 0x40, Type: dev
    function private function_26066f7700410eaf()
    {
        self endon( "<dev string:x3d6>" );
        
        while ( true )
        {
            level thread scripts\cp_mp\utility\debug_utility::drawsphere( self.origin, 10, 0.05, ( 0, 1, 0 ) );
            wait 0.05;
        }
    }

#/

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x49b5
// Size: 0x20
function function_13276a05f9b52006( streakname )
{
    return level.streakglobals.var_2150da9328528bb9[ streakname ];
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x49de
// Size: 0x41
function function_d13d2a81214fbfb8( var_7eb265bced9cc450, var_a6ceb04e31f575e0 )
{
    self endon( "disconnect" );
    
    if ( istrue( var_a6ceb04e31f575e0 ) )
    {
        thread function_af095e506de21f93();
        wait 0.05;
    }
    
    if ( !isdefined( var_7eb265bced9cc450 ) )
    {
        var_7eb265bced9cc450 = "80_instant_noscale";
    }
    
    self lerpfovbypreset( var_7eb265bced9cc450 );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4a27
// Size: 0x38
function private function_af095e506de21f93()
{
    self endon( "disconnect" );
    self notify( "unset_fov_scalefactor" );
    self endon( "unset_fov_scalefactor" );
    self lerpfovscalefactor( 0, 0 );
    level waittill( "start_game_ended" );
    function_8b676f496920e2ab();
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x4a67
// Size: 0x28
function function_8b676f496920e2ab()
{
    self notify( "unset_fov_scalefactor" );
    thread function_d13d2a81214fbfb8( "default" );
    self lerpfovscalefactor( 1, 0 );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 5
// Checksum 0x0, Offset: 0x4a97
// Size: 0x16b
function function_ee93617532d8a679( vehicle, owner, cleanupfunc, teleportvehicle, var_2e71b592d8fbf3aa )
{
    if ( !isdefined( vehicle ) )
    {
        /#
            iprintln( "<dev string:x3dc>" );
        #/
        
        return;
    }
    
    vehicle function_bcb138d52b53d94d( 0 );
    
    if ( istrue( var_2e71b592d8fbf3aa ) )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        owner endon( "disconnect" );
    }
    
    vehicle endon( "death" );
    vehicle endon( "explode" );
    level endon( "game_ended" );
    
    if ( !isdefined( cleanupfunc ) )
    {
        /#
            iprintln( "<dev string:x440>" );
        #/
        
        return;
    }
    
    /#
        debugteleport = getdvarint( @"hash_5fbef6e1f0b6624c", 0 );
        
        if ( istrue( debugteleport ) )
        {
            teleportvehicle = 1;
        }
    #/
    
    var_3098bbcd22d0e052 = spawnstruct();
    var_3098bbcd22d0e052.cleanupfunc = cleanupfunc;
    var_3098bbcd22d0e052.failurefunc = &function_37ba16da99bc142a;
    var_3098bbcd22d0e052.tryteleport = istrue( teleportvehicle );
    vehicle.var_3098bbcd22d0e052 = var_3098bbcd22d0e052;
    
    /#
        while ( true )
        {
            var_dafb327821fab8f = getdvarint( @"hash_873b7ff40bb2a37e", 0 );
            
            if ( var_dafb327821fab8f > 0 )
            {
                unstablevehiclelist = [ vehicle ];
                level notify( "<dev string:x48f>", unstablevehiclelist );
                
                if ( var_dafb327821fab8f == 1 )
                {
                    setdvar( @"hash_873b7ff40bb2a37e", 0 );
                    wait 1;
                }
                else
                {
                    wait 5;
                }
                
                vehicle.var_54db093819e08a57 = undefined;
            }
            
            waitframe();
        }
    #/
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4c0a
// Size: 0xc3
function private function_37ba16da99bc142a( reason )
{
    self endon( "death" );
    self endon( "explode" );
    level endon( "game_ended" );
    
    if ( istrue( self.var_54db093819e08a57 ) )
    {
        return;
    }
    
    self.var_54db093819e08a57 = 1;
    killstreakintegrity = self.var_3098bbcd22d0e052;
    
    if ( istrue( self.iscrashing ) || istrue( self.isleaving ) )
    {
        self thread [[ killstreakintegrity.cleanupfunc ]]();
        return;
    }
    
    if ( !istrue( killstreakintegrity.tryteleport ) )
    {
        return;
    }
    
    result = function_f503427294d91f80( self, 500 );
    
    if ( !istrue( result ) )
    {
        /#
            iprintln( "<dev string:x4a9>" );
        #/
        
        self thread [[ killstreakintegrity.cleanupfunc ]]();
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x4cd5
// Size: 0x226
function function_f503427294d91f80( vehicle, distanceoffset )
{
    vehicle endon( "death" );
    vehicle endon( "explode" );
    vehicle endon( "leaving" );
    vehicle endon( "crashing" );
    level endon( "game_ended" );
    vehicleorigin = vehicle.origin;
    forward = anglestoforward( vehicle.angles );
    right = anglestoright( vehicle.angles );
    up = anglestoup( vehicle.angles );
    contents = scripts\engine\trace::create_default_contents( 1 );
    ignore = vehicle;
    locationchecks = [ vehicleorigin + forward * distanceoffset, vehicleorigin - forward * distanceoffset, vehicleorigin + right * distanceoffset, vehicleorigin - right * distanceoffset, vehicleorigin + up * distanceoffset, vehicleorigin - up * distanceoffset, vehicleorigin + 0.707 * ( forward + right ) * distanceoffset, vehicleorigin + 0.707 * ( forward - right ) * distanceoffset, vehicleorigin + 0.707 * ( right - forward ) * distanceoffset, vehicleorigin + 0.707 * ( -1 * forward - right ) * distanceoffset ];
    var_62538cb75db14e85 = 0;
    
    foreach ( potentiallocation in locationchecks )
    {
        if ( scripts\engine\trace::sphere_trace_passed( vehicleorigin, potentiallocation, 300, ignore, contents ) )
        {
            /#
                level thread scripts\cp_mp\utility\debug_utility::drawline( vehicleorigin, potentiallocation, 30, ( 0, 1, 0 ) );
                level thread scripts\cp_mp\utility\debug_utility::drawsphere( potentiallocation, 25, 30, ( 0, 1, 0 ) );
            #/
            
            vehicle vehicle_teleport( potentiallocation, vehicle.angles );
            var_62538cb75db14e85 = 1;
            break;
        }
        
        wait 0.05;
    }
    
    return var_62538cb75db14e85;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x4f04
// Size: 0x1a3, Type: bool
function teamhasuav( team )
{
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == team )
        {
            continue;
        }
        
        if ( isdefined( level.uavmodels ) && isdefined( level.uavmodels[ entry ] ) && level.uavmodels[ entry ].size > 0 )
        {
            foreach ( uav in level.uavmodels[ entry ] )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( uav.uavtype == "counter_uav" )
                {
                    return false;
                }
            }
        }
    }
    
    if ( isdefined( level.uavmodels ) && isdefined( level.uavmodels[ team ] ) && level.uavmodels[ team ].size > 0 )
    {
        foreach ( uav in level.uavmodels[ team ] )
        {
            if ( !isdefined( uav ) )
            {
                continue;
            }
            
            if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x50b0
// Size: 0xba, Type: bool
function teamhasuav_ignorecuav( team )
{
    if ( isdefined( level.uavmodels ) && isdefined( level.uavmodels[ team ] ) && level.uavmodels[ team ].size > 0 )
    {
        foreach ( uav in level.uavmodels[ team ] )
        {
            if ( !isdefined( uav ) )
            {
                continue;
            }
            
            if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5173
// Size: 0xa9, Type: bool
function enemyhascuav( team )
{
    if ( isdefined( level.supportdrones ) && level.supportdrones.size > 0 )
    {
        foreach ( drone in level.supportdrones )
        {
            if ( level.teambased && drone.team == team )
            {
                continue;
            }
            
            if ( drone.helperdronetype == "scrambler_drone_guard" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5225
// Size: 0x39, Type: bool
function isuavactiveforteam( team )
{
    if ( !isdefined( level.uavmodels ) )
    {
        return false;
    }
    
    if ( !isdefined( level.uavmodels[ team ] ) )
    {
        return false;
    }
    
    return level.uavmodels[ team ].size > 0;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5267
// Size: 0x1fa
function getkillstreakdeployweapon( streakname )
{
    deployweapon = undefined;
    
    switch ( streakname )
    {
        case #"hash_2289ec11d77bce8f":
        case #"hash_56979e0566996b2e":
        case #"hash_887ad77192b9c4fb":
            deployweapon = "deploy_airdrop_mp";
            break;
        case #"hash_4ad475e6e15635bd":
        case #"hash_e65b15f734e5ab84":
            deployweapon = "deploy_juggernaut_mp";
            break;
        case #"hash_9e36e3bd3a9dd00d":
            if ( utility::iscp() )
            {
                deployweapon = "ks_assault_drone_cp";
                break;
            }
            
            deployweapon = "ks_assault_drone_mp";
            break;
        case #"hash_691f39dddd9116b8":
        case #"hash_e477c24ee18bb2f6":
        case #"hash_f64c697bfb4c6b54":
            deployweapon = "ks_gesture_generic_mp";
            break;
        case #"hash_27002778019fb447":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
            deployweapon = "ks_gesture_phone_mp";
            break;
        case #"hash_b4ac3581c343a029":
            deployweapon = "iw9_laser_large_ir_mp";
            break;
        case #"hash_8c766d6477287bb6":
            deployweapon = "iw9_spotter_scope_mp";
            break;
        case #"hash_28d0236400e33fd0":
        case #"hash_349713b5ad494dda":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_cf0ef5bef19a311b":
            deployweapon = "ks_remote_device_mp";
            break;
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_4220be38a5f150b8":
        case #"hash_a1031216158c7882":
        case #"hash_b161e185f1b8e117":
        case #"hash_e6bea339d3cbd3e8":
            deployweapon = "ks_remote_map_mp";
            break;
        case #"hash_52d9b7ed584bec3e":
            deployweapon = "deploy_manual_turret_mp";
            break;
        case #"hash_4d5aa76e8707f47b":
            deployweapon = "deploy_sentry_mp";
            break;
        case #"hash_ab5712e297cd430e":
            deployweapon = "deploy_remote_turret_mp";
            break;
        case #"hash_195360490caa3220":
            deployweapon = "ks_remote_nuke_mp";
            break;
    }
    
    return deployweapon;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x546a
// Size: 0x11e
function iskillstreakdeployweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x4fe>" );
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = scripts\cp_mp\weapon::getweaponassetname( weapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon;
        }
    }
    
    var_1880d2298e9e948a = 0;
    
    switch ( weaponname )
    {
        case #"hash_14ab8140c657b518":
        case #"hash_1898ea54a0bc6404":
        case #"hash_33c7f389fa9d6dd5":
        case #"hash_405f9521b5ee8402":
        case #"hash_448b7248104bfa9c":
        case #"hash_45e409945333f912":
        case #"hash_807ae3204119bd41":
        case #"hash_879b8ea58093f02c":
        case #"hash_aacdf3a6d5b91585":
        case #"hash_b43c2e4c05fafc4b":
        case #"hash_c280a34cde90f5eb":
        case #"hash_d9266153a899a37c":
        case #"hash_f194befae42e3476":
        case #"hash_f19acafae432c488":
            var_1880d2298e9e948a = 1;
            break;
    }
    
    return var_1880d2298e9e948a;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5591
// Size: 0x56
function function_6c58c6fdcc87e387( weaponobj )
{
    var_efa92dcc03a312b9 = 0;
    
    if ( !isdefined( weaponobj ) || !isdefined( weaponobj.basename ) )
    {
        return var_efa92dcc03a312b9;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_b43c2e4c05fafc4b":
            var_efa92dcc03a312b9 = 1;
            break;
    }
    
    return var_efa92dcc03a312b9;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x55f0
// Size: 0x56
function function_9deb86c4684340e1( weaponobj )
{
    var_d707a33007a42777 = 0;
    
    if ( !isdefined( weaponobj ) || !isdefined( weaponobj.basename ) )
    {
        return var_d707a33007a42777;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_33c7f389fa9d6dd5":
            var_d707a33007a42777 = 1;
            break;
    }
    
    return var_d707a33007a42777;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x564f
// Size: 0x6e
function function_3ffc7fd85f5754e9( weaponobj )
{
    var_ffb48d5f685a491b = 0;
    
    if ( !isdefined( weaponobj ) || !isdefined( weaponobj.basename ) )
    {
        return var_ffb48d5f685a491b;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_5f2ad7140f378ee1":
        case #"hash_f194befae42e3476":
        case #"hash_f19acafae432c488":
            var_ffb48d5f685a491b = 1;
            break;
    }
    
    return var_ffb48d5f685a491b;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x56c6
// Size: 0x62
function iskillstreakgestureweapon( weaponobj )
{
    isgestureweapon = 0;
    
    if ( !isdefined( weaponobj ) || !isdefined( weaponobj.basename ) )
    {
        return isgestureweapon;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_c280a34cde90f5eb":
        case #"hash_d9266153a899a37c":
            isgestureweapon = 1;
            break;
    }
    
    return isgestureweapon;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5731
// Size: 0x9f
function getkillstreakgameweapons( streakname )
{
    ingameweapons = [];
    
    switch ( streakname )
    {
        case #"hash_4ad475e6e15635bd":
            ingameweapons = [ "iw9_minigunksjugg_mp", "iw9_minigunksjugg_reload_mp", "iw9_lm_dblmg2_cp" ];
            break;
        case #"hash_52d9b7ed584bec3e":
            ingameweapons = [ "manual_turret_mp" ];
            break;
        case #"hash_4d5aa76e8707f47b":
            ingameweapons = [ "sentry_turret_mp" ];
            break;
        case #"hash_ab5712e297cd430e":
            ingameweapons = [ "remote_turret_mp" ];
            break;
    }
    
    return ingameweapons;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x57d9
// Size: 0x74
function getnumactivekillstreakperteam( team, trackinglist )
{
    numactive = 0;
    
    foreach ( killstreakent in trackinglist )
    {
        if ( killstreakent.team == team )
        {
            numactive++;
        }
    }
    
    return numactive;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x5856
// Size: 0x4b
function getkillstreakairstrikeheightent()
{
    if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
    {
        return scripts\cp_mp\utility\game_utility::getlocaleent( "airstrikeheight" );
    }
    
    airstrikeheights = getentarray( "airstrikeheight", "targetname" );
    
    if ( airstrikeheights.size > 1 )
    {
        /#
            iprintlnbold( "<dev string:x532>" );
        #/
    }
    
    return airstrikeheights[ 0 ];
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x58aa
// Size: 0xae
function function_3f76336d7d0b7587( weaponref )
{
    speedscale = 1;
    
    if ( isdefined( weaponref ) )
    {
        weaponname = undefined;
        
        if ( isweapon( weaponref ) )
        {
            weaponname = weaponref.basename;
        }
        else
        {
            weaponname = scripts\cp_mp\weapon::getweaponassetname( weaponref );
            
            if ( !isdefined( weaponname ) )
            {
                weaponname = weaponref;
            }
        }
        
        switch ( weaponname )
        {
            case #"hash_1898ea54a0bc6404":
            case #"hash_879b8ea58093f02c":
                speedscale = 0.78;
                break;
            case #"hash_f4d2562ef860c1c0":
                speedscale = 0.87;
                break;
            case #"hash_448b7248104bfa9c":
                speedscale = 0.91;
                break;
        }
    }
    
    return speedscale;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5961
// Size: 0x97
function restorekillstreakplayerangles( player )
{
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( !player _isalive() )
    {
        return;
    }
    
    restorepitch = 0;
    restoreroll = 0;
    wait 0.05;
    var_7500ec3e41c123ab = player getplayerangles();
    restoreyaw = var_7500ec3e41c123ab[ 1 ];
    
    if ( isdefined( player.restoreangles ) && !function_f8789f15330de751( player ) )
    {
        restoreyaw = player.restoreangles[ 1 ];
    }
    
    player setplayerangles( ( restorepitch, restoreyaw, restoreroll ) );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5a00
// Size: 0x19b
function recordkillstreakendstats( streakinfo )
{
    if ( issharedfuncdefined( "challenges", "onKillStreakEnd" ) )
    {
        streakitem = streakinfo.mpstreaksysteminfo;
        
        if ( isdefined( streakitem ) )
        {
            name = streakitem.streakname;
            totalkills = streakinfo.kills;
            self [[ getsharedfunc( "challenges", "onKillStreakEnd" ) ]]( name, totalkills );
        }
    }
    
    if ( issharedfuncdefined( "dlog", "killStreakExpired" ) )
    {
        streakitem = streakinfo.mpstreaksysteminfo;
        
        if ( isdefined( streakitem ) )
        {
            lifeid = streakitem.streakmatchlifeid;
            killstreakname = streakitem.streakname;
            pickedup = streakitem.isgimme;
            matchtime = gettime();
            playerpos = self.origin;
            expiredbydeath = istrue( streakinfo.expiredbydeath );
            shotsfired = streakinfo.shots_fired;
            var_8f52823e77aca0d3 = streakinfo.hits;
            var_f5ff9a2f5217b3ec = streakinfo.kills;
            var_7e6dbb913989cf29 = streakinfo.score;
            [[ getsharedfunc( "dlog", "killStreakExpired" ) ]]( self, lifeid, killstreakname, pickedup, matchtime, playerpos, expiredbydeath, shotsfired, var_8f52823e77aca0d3, var_f5ff9a2f5217b3ec, var_7e6dbb913989cf29 );
        }
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 0
// Checksum 0x0, Offset: 0x5ba3
// Size: 0x72
function playerkillstreakgetownerlookatignoreents()
{
    ignoreents = undefined;
    
    if ( isdefined( self.vehicle ) )
    {
        ignoreents = [ self.vehicle ];
    }
    else
    {
        groundent = self getgroundentity();
        
        if ( isdefined( groundent ) && isdefined( groundent.classname ) && groundent.classname == "script_vehicle" )
        {
            ignoreents = [ groundent ];
        }
    }
    
    return ignoreents;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5c1e
// Size: 0x5d
function movingplatform_playerlink( player )
{
    if ( getdvarint( @"hash_82ce3832ac5efa6d", 0 ) == 0 )
    {
        return;
    }
    
    movingplatform = player getmovingplatformparent();
    
    if ( isdefined( movingplatform ) && function_63bdc8c411a85475( movingplatform ) )
    {
        player playerlinkto( movingplatform );
        player playerlinkedoffsetenable();
        player.movingplatforment = movingplatform;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5c83
// Size: 0x8a, Type: bool
function function_63bdc8c411a85475( movingplatform )
{
    if ( scripts\cp_mp\utility\train_utility::is_moving_platform_train( movingplatform ) )
    {
        return true;
    }
    
    if ( scripts\common\elevator::function_d9d18dab18ebded( movingplatform ) )
    {
        return true;
    }
    
    if ( isarray( level.var_a3810b14039a0e7d ) )
    {
        foreach ( callback in level.var_a3810b14039a0e7d )
        {
            if ( [[ callback ]]( movingplatform ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5d16
// Size: 0x8a, Type: bool
function function_3c5c5d86ef14420e( movingplatform )
{
    if ( scripts\cp_mp\utility\train_utility::is_moving_platform_train( movingplatform ) )
    {
        return true;
    }
    
    if ( scripts\common\elevator::function_d9d18dab18ebded( movingplatform ) )
    {
        return true;
    }
    
    if ( isarray( level.var_6b5eff480d2f1fac ) )
    {
        foreach ( callback in level.var_6b5eff480d2f1fac )
        {
            if ( [[ callback ]]( movingplatform ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5da9
// Size: 0x2c
function movingplatform_playerunlink( player )
{
    if ( isdefined( player.movingplatforment ) )
    {
        player.movingplatforment = undefined;
        player unlink();
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5ddd
// Size: 0x3c
function function_6db9b45f6855dee1( callback )
{
    if ( !isarray( level.var_a3810b14039a0e7d ) )
    {
        level.var_a3810b14039a0e7d = [];
    }
    
    level.var_a3810b14039a0e7d[ level.var_a3810b14039a0e7d.size ] = callback;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x5e21
// Size: 0x3c
function function_2c70bfb1b580e8e0( callback )
{
    if ( !isarray( level.var_6b5eff480d2f1fac ) )
    {
        level.var_6b5eff480d2f1fac = [];
    }
    
    level.var_6b5eff480d2f1fac[ level.var_6b5eff480d2f1fac.size ] = callback;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x5e65
// Size: 0x9b
function killstreak_registerminimapinfo( bundle, killstreak )
{
    if ( isdefined( bundle ) && isdefined( bundle.minimapicon ) )
    {
        createfunc = undefined;
        enemyobjid = undefined;
        
        if ( scripts\engine\utility::issharedfuncdefined( "game", "createObjectiveEngineer" ) )
        {
            createfunc = scripts\engine\utility::getsharedfunc( "game", "createObjectiveEngineer" );
        }
        
        if ( isdefined( createfunc ) )
        {
            enemyobjid = self [[ createfunc ]]( bundle.minimapicon, 1, 1, "icon_regular" );
        }
        
        if ( isdefined( killstreak ) && isdefined( enemyobjid ) )
        {
            level function_17f94c860028d1d( killstreak, enemyobjid, self );
        }
        
        return;
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x5f08
// Size: 0x12e
function function_17f94c860028d1d( killstreak, killstreakobjid, killstreakobject )
{
    if ( isdefined( self.var_2a83795d29778aea ) && !isdefined( self.var_2a83795d29778aea[ killstreak ] ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_44007c283e07f7c2 ) )
    {
        self.var_44007c283e07f7c2 = [];
    }
    
    if ( !isdefined( self.killstreakowners ) )
    {
        self.killstreakowners = [];
    }
    
    if ( !isdefined( self.var_932b68e7ca895a9f ) )
    {
        self.var_932b68e7ca895a9f = [];
    }
    
    self.var_44007c283e07f7c2[ killstreak ] = killstreakobjid;
    self.killstreakowners[ killstreak ] = killstreakobject.owner;
    self.var_932b68e7ca895a9f[ killstreakobjid ] = killstreak;
    
    if ( isdefined( self.var_1a439e77dde46982 ) )
    {
        foreach ( player in self.var_1a439e77dde46982 )
        {
            if ( istrue( playersareenemies( player, killstreakobject.owner ) ) )
            {
                scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( killstreakobjid, player );
            }
        }
    }
    
    killstreakobject thread function_cd63e30445520ec( killstreak );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1
// Checksum 0x0, Offset: 0x603e
// Size: 0x24
function function_cd63e30445520ec( killstreak )
{
    self endon( "killstreakUnregistered" );
    self waittill( "death" );
    level function_4c8add74b15a9f8( killstreak, self );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x606a
// Size: 0xbb
function function_4c8add74b15a9f8( killstreak, killstreakobject )
{
    if ( !isdefined( self.var_44007c283e07f7c2[ killstreak ] ) || !isdefined( self.killstreakowners[ killstreak ] ) )
    {
        return;
    }
    
    if ( isdefined( self.var_1a439e77dde46982 ) )
    {
        foreach ( player in self.var_1a439e77dde46982 )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom( self.var_44007c283e07f7c2[ killstreak ], player );
        }
    }
    
    self.var_44007c283e07f7c2[ killstreak ] = undefined;
    self.killstreakowners[ killstreak ] = undefined;
    killstreakobject notify( "killstreakUnregistered" );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x612d
// Size: 0x28
function function_ef9490796efaf574( streakinfo, switchresult, weaponobj )
{
    if ( !istrue( switchresult ) )
    {
        scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 7
// Checksum 0x0, Offset: 0x615d
// Size: 0xdc
function function_6aa895b8483b9b10( streakinfo, deployweapon, ignorecancel, var_2f3d13488b96f966, equipdelaytime, deployanimtime, var_99514d9b932ce768 )
{
    wait equipdelaytime;
    marker = undefined;
    
    if ( issharedfuncdefined( "killstreak", "getTargetMarker" ) )
    {
        marker = [[ getsharedfunc( "killstreak", "getTargetMarker" ) ]]( streakinfo, ignorecancel, var_99514d9b932ce768 );
    }
    
    if ( !isdefined( self ) || !_isalive() )
    {
        return undefined;
    }
    
    if ( !isdefined( marker ) || !isdefined( marker.location ) )
    {
        killstreak_switchbacklastweapon( deployweapon );
        return undefined;
    }
    
    if ( var_2f3d13488b96f966 )
    {
        self freezecontrols( 1 );
    }
    
    if ( self hasweapon( deployweapon ) )
    {
        thread killstreak_switchbacklastweapon( deployweapon, 1, 1 );
    }
    
    wait deployanimtime;
    
    if ( var_2f3d13488b96f966 )
    {
        self freezecontrols( 0 );
    }
    
    return marker;
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x6242
// Size: 0xaf
function killstreak_switchbacklastweapon( deployweapon, immediateswitch, optionaltimedelay )
{
    if ( isdefined( optionaltimedelay ) && optionaltimedelay > 0 )
    {
        self endon( "death_or_disconnect" );
        level endon( "game_ended" );
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( optionaltimedelay );
    }
    
    lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates( self.lastdroppableweaponobj );
    
    if ( !isdefined( lastweaponobj ) || !self hasweapon( lastweaponobj ) )
    {
        if ( isdefined( self.lastnormalweaponobj ) )
        {
            lastweaponobj = self.lastnormalweaponobj;
        }
        else
        {
            lastweaponobj = makeweapon( "iw9_fists_mp" );
        }
    }
    
    if ( istrue( immediateswitch ) )
    {
        _switchtoweaponimmediate( lastweaponobj );
    }
    else
    {
        _switchtoweapon( lastweaponobj );
    }
    
    _takeweapon( deployweapon );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 3
// Checksum 0x0, Offset: 0x62f9
// Size: 0x13c
function function_36c90c54c1002132( owner, hinttag, hinttextkey )
{
    hintpos = self gettagorigin( hinttag );
    
    if ( !isdefined( self.useownerobj ) )
    {
        if ( issharedfuncdefined( "game", "createHintObject" ) )
        {
            self.useownerobj = [[ getsharedfunc( "game", "createHintObject" ) ]]( hintpos, "HINT_BUTTON", undefined, hinttextkey, undefined, undefined, "show" );
        }
    }
    else
    {
        hintpos = self gettagorigin( hinttag );
        self.useownerobj function_dfb78b3e724ad620( 1 );
        self.useownerobj dontinterpolate();
        self.useownerobj.origin = hintpos;
    }
    
    foreach ( player in level.players )
    {
        if ( player != owner )
        {
            self.useownerobj disableplayeruse( player );
            continue;
        }
        
        self.useownerobj enableplayeruse( player );
    }
    
    self.useownerobj linkto( self, hinttag );
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 2
// Checksum 0x0, Offset: 0x643d
// Size: 0x7f
function killstreak_watchpickup( streakinfo, onpickupcallback )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self.useownerobj waittill( "trigger", player );
        
        if ( isdefined( player ) && !self.owner killstreak_canpickup( player ) )
        {
            continue;
        }
        
        self.useownerobj function_dfb78b3e724ad620( 0 );
        self.owner [[ onpickupcallback ]]( self, streakinfo );
    }
}

// Namespace killstreak_utility / scripts\cp_mp\utility\killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x64c4
// Size: 0x52, Type: bool
function private killstreak_canpickup( player )
{
    if ( player != self )
    {
        return false;
    }
    
    if ( istrue( player.isjuggernaut ) )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            player [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP" );
        }
        
        return false;
    }
    
    return true;
}

