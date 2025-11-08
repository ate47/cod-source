#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\playerachievements;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;

#namespace escort_horde_event_perks;

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x4c2
// Size: 0x2d7
function autoexec main()
{
    if ( ismutationgamemode() && getdvarint( @"hash_e0c96c2e3d8efa29", 0 ) == 1 )
    {
        function_4862ad097a85e6b8( 1, 38187, 780 );
        function_4862ad097a85e6b8( 3, 38188, 1200 );
        function_4862ad097a85e6b8( 2, 38187, 6250 );
        function_4862ad097a85e6b8( 5, 38189, 1560 );
        function_4862ad097a85e6b8( 4, 38188, 9350 );
        level.var_7fb91ca0ab6978c0 = &function_7fb91ca0ab6978c0;
        level.var_7b14f9938e117d29 = &onplayerconnect;
        utility::registersharedfunc( "game", "mutationModeAchievementStateFetched", &function_7fb91ca0ab6978c0 );
        level callback::add( "player_connect", &onplayerconnect );
        level callback::add( "player_death", &function_2ee91f207f07f84e );
        level callback::add( "player_damaged", &function_5aa0301754c24686 );
        registersharedfunc( "game", "setMutationModePerk01", &setmutationmodeperk01 );
        registersharedfunc( "game", "setMutationModePerk02", &setmutationmodeperk02 );
        registersharedfunc( "game", "setMutationModePerk03", &setmutationmodeperk03 );
        registersharedfunc( "game", "setMutationModePerk04", &setmutationmodeperk04 );
        registersharedfunc( "game", "setMutationModePerk05", &setmutationmodeperk05 );
        registersharedfunc( "game", "unsetMutationModePerk01", &unsetmutationmodeperk01 );
        registersharedfunc( "game", "unsetMutationModePerk02", &unsetmutationmodeperk02 );
        registersharedfunc( "game", "unsetMutationModePerk03", &unsetmutationmodeperk03 );
        registersharedfunc( "game", "unsetMutationModePerk04", &unsetmutationmodeperk04 );
        registersharedfunc( "game", "unsetMutationModePerk05", &unsetmutationmodeperk05 );
        registersharedfunc( "game", "hasMutationModePerk01", &hasmutationmodeperk01 );
        registersharedfunc( "game", "hasMutationModePerk02", &hasmutationmodeperk02 );
        registersharedfunc( "game", "hasMutationModePerk03", &hasmutationmodeperk03 );
        registersharedfunc( "game", "hasMutationModePerk04", &hasmutationmodeperk04 );
        registersharedfunc( "game", "hasMutationModePerk05", &hasmutationmodeperk05 );
        registersharedfunc( "game", "activateMutationModePerk01", &activatemutationmodeperk01 );
        registersharedfunc( "game", "activateMutationModePerk02", &activatemutationmodeperk02 );
        registersharedfunc( "game", "activateMutationModePerk03", &activatemutationmodeperk03 );
        registersharedfunc( "game", "activateMutationModePerk04", &activatemutationmodeperk04 );
        registersharedfunc( "game", "activateMutationModePerk05", &activatemutationmodeperk05 );
        utility::registersharedfunc( "game", "mutationModeGiveEarnedPerks", &mutationmodegiveearnedperks );
        setdvarifuninitialized( @"hash_75aeac9bdf42867", 0 );
        setdvarifuninitialized( @"hash_2c41f83a90ac7dcf", 1 );
        setdvarifuninitialized( @"hash_ef09092a12a6e8c8", 3 );
    }
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 3
// Checksum 0x0, Offset: 0x7a1
// Size: 0xb2
function function_4862ad097a85e6b8( perkslot, achievementid, var_7ab6dba5e9adbffb )
{
    if ( !isdefined( level.var_8230c93fcd42a213 ) )
    {
        level.var_8230c93fcd42a213 = [];
    }
    
    if ( !isdefined( level.var_8230c93fcd42a213[ achievementid ] ) )
    {
        level.var_8230c93fcd42a213[ achievementid ] = [];
    }
    
    if ( !isdefined( level.var_8230c93fcd42a213[ achievementid ][ perkslot ] ) )
    {
        level.var_8230c93fcd42a213[ achievementid ][ perkslot ] = spawnstruct();
    }
    
    struct = level.var_8230c93fcd42a213[ achievementid ][ perkslot ];
    struct.perkslot = perkslot;
    struct.achievementid = achievementid;
    struct.var_7ab6dba5e9adbffb = var_7ab6dba5e9adbffb;
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 1
// Checksum 0x0, Offset: 0x85b
// Size: 0x7d
function onplayerconnect( params )
{
    player = self;
    
    if ( !matchmakinggame() )
    {
        player thread function_539593ba238cc26c();
    }
    
    foreach ( achievementid, struct in level.var_8230c93fcd42a213 )
    {
        scripts\cp_mp\playerachievements::getstate( player, achievementid );
    }
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0x8e0
// Size: 0x132
function function_539593ba238cc26c()
{
    player = self;
    player endon( "disconnect" );
    
    if ( getdvarint( @"hash_75aeac9bdf42867", 0 ) == 1 )
    {
        [ achievementid, progressdata ] = function_5ba9e679fe13fe5e( 38187, 780 );
        player function_7fb91ca0ab6978c0( achievementid, progressdata );
        [ achievementid, progressdata ] = function_5ba9e679fe13fe5e( 38187, 6250 );
        player function_7fb91ca0ab6978c0( achievementid, progressdata );
        [ achievementid, progressdata ] = function_5ba9e679fe13fe5e( 38188, 1200 );
        player function_7fb91ca0ab6978c0( achievementid, progressdata );
        [ achievementid, progressdata ] = function_5ba9e679fe13fe5e( 38188, 9350 );
        player function_7fb91ca0ab6978c0( achievementid, progressdata );
        [ achievementid, progressdata ] = function_5ba9e679fe13fe5e( 38189, 1560 );
        player function_7fb91ca0ab6978c0( achievementid, progressdata );
        
        if ( ismutationgamemodezombie() )
        {
            mutationmodegiveearnedperks();
        }
    }
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 2
// Checksum 0x0, Offset: 0xa1a
// Size: 0x19e
function function_7fb91ca0ab6978c0( achievementid, progressdata )
{
    player = self;
    
    if ( !isdefined( player.var_212091c46501637b ) )
    {
        player.var_212091c46501637b = [];
    }
    
    if ( !isdefined( level.var_8230c93fcd42a213[ achievementid ] ) )
    {
        return;
    }
    
    var_d5f1c80151eeba85 = scripts\cp_mp\playerachievements::function_691880160b33d133( "progress" );
    progress = 0;
    
    for ( index = 0; index < progressdata.progress_values.size ; index++ )
    {
        progress_id = progressdata.progress_values[ index ].progress_id;
        
        if ( is_equal( var_d5f1c80151eeba85, progress_id ) )
        {
            progress = progressdata.progress_values[ index ].progress;
            break;
        }
    }
    
    if ( progress > 0 )
    {
        var_369138f6272b4142 = level.var_8230c93fcd42a213[ achievementid ];
        
        foreach ( perkslot, var_fae1cc711373d0d4 in var_369138f6272b4142 )
        {
            if ( progress < var_369138f6272b4142[ perkslot ].var_7ab6dba5e9adbffb )
            {
                continue;
            }
            
            perk = "specialty_mutation_mode_bonus_0" + perkslot;
            
            if ( !array_contains( player.var_212091c46501637b, perk ) )
            {
                player.var_212091c46501637b = array_add( player.var_212091c46501637b, perk );
            }
        }
        
        player thread packandsendperkinfobits();
    }
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xbc0
// Size: 0xeb
function packandsendperkinfobits()
{
    player = self;
    player notify( "packAndSendPerkInfoBits" );
    player endon( "packAndSendPerkInfoBits" );
    player endon( "disconnect" );
    waitframe();
    var_79ed6a2e232ea341 = [];
    var_79ed6a2e232ea341[ var_79ed6a2e232ea341.size ] = 1;
    var_79ed6a2e232ea341[ var_79ed6a2e232ea341.size ] = 2;
    var_79ed6a2e232ea341[ var_79ed6a2e232ea341.size ] = 4;
    var_79ed6a2e232ea341[ var_79ed6a2e232ea341.size ] = 8;
    var_79ed6a2e232ea341[ var_79ed6a2e232ea341.size ] = 16;
    data = 0;
    
    foreach ( perk in player.var_212091c46501637b )
    {
        perkslot = int( perk[ perk.size - 1 ] );
        bitfield = var_79ed6a2e232ea341[ perkslot - 1 ];
        data |= bitfield;
    }
    
    self setclientomnvar( "ui_mutation_bonus_perks_unlocked", data );
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xcb3
// Size: 0x77
function mutationmodegiveearnedperks()
{
    if ( isdefined( self.var_212091c46501637b ) && ismutationgamemodezombie() )
    {
        foreach ( perk in self.var_212091c46501637b )
        {
            if ( !_hasperk( perk ) )
            {
                giveperk( perk );
            }
        }
    }
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 2
// Checksum 0x0, Offset: 0xd32
// Size: 0x8b
function function_5ba9e679fe13fe5e( achievementid, var_51c6029a1deceecf )
{
    progressdata = spawnstruct();
    progressdata.progress_values = [];
    progressdata.progress_values[ 0 ] = spawnstruct();
    progressdata.progress_values[ 0 ].progress_id = scripts\cp_mp\playerachievements::function_691880160b33d133( "progress" );
    progressdata.progress_values[ 0 ].progress = var_51c6029a1deceecf;
    return [ achievementid, progressdata ];
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xdc6
// Size: 0xc
function setmutationmodeperk01()
{
    self.var_747fc410433aa51c = 0;
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xdda
// Size: 0x2
function setmutationmodeperk02()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xde4
// Size: 0x2
function setmutationmodeperk03()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xdee
// Size: 0x9
function setmutationmodeperk04()
{
    activatemutationmodeperk04();
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xdff
// Size: 0x9
function setmutationmodeperk05()
{
    activatemutationmodeperk05();
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe10
// Size: 0x2
function unsetmutationmodeperk01()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe1a
// Size: 0x2
function unsetmutationmodeperk02()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe24
// Size: 0xc
function unsetmutationmodeperk03()
{
    self.var_5651e2b694c25c8b = undefined;
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe38
// Size: 0x2
function unsetmutationmodeperk04()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe42
// Size: 0x2
function unsetmutationmodeperk05()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe4c
// Size: 0x2
function hasmutationmodeperk01()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe56
// Size: 0xd
function hasmutationmodeperk02()
{
    return _hasperk( "specialty_mutation_mode_bonus_02" );
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe6c
// Size: 0xd
function hasmutationmodeperk03()
{
    return _hasperk( "specialty_mutation_mode_bonus_03" );
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe82
// Size: 0x2
function hasmutationmodeperk04()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xe8c
// Size: 0xd
function hasmutationmodeperk05()
{
    return _hasperk( "specialty_mutation_mode_bonus_05" );
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xea2
// Size: 0x2
function activatemutationmodeperk01()
{
    
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0xeac
// Size: 0x97
function activatemutationmodeperk02()
{
    if ( !istrue( self.var_1a7940ce78dd1720 ) )
    {
        fwd = vectornormalize( anglestoforward( flat_angle( self.angles ) ) );
        grenadeorigin = self.origin + fwd * 16 + ( 0, 0, 4 );
        gren = magicgrenademanual( "jup_mutant_leap_impact_mp", grenadeorigin, ( 0, 0, 0 ), 0.1 );
        gren.var_f08578daebccf4a2 = 1;
        gren detonate( self );
    }
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 1
// Checksum 0x0, Offset: 0xf4b
// Size: 0x81
function function_2ee91f207f07f84e( params )
{
    if ( !isdefined( params.attacker ) )
    {
        return;
    }
    
    if ( !isplayer( params.attacker ) )
    {
        return;
    }
    
    if ( !isalive( params.attacker ) )
    {
        return;
    }
    
    attacker = params.attacker;
    
    if ( !function_150d67ea1dfd1f31( params.objweapon ) )
    {
        return;
    }
    
    if ( attacker hasmutationmodeperk03() )
    {
        attacker activatemutationmodeperk03();
    }
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 1
// Checksum 0x0, Offset: 0xfd4
// Size: 0x55, Type: bool
function function_150d67ea1dfd1f31( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    if ( !isdefined( objweapon.basename ) )
    {
        return false;
    }
    
    if ( objweapon.basename == "jup_mutant_emp_ball" )
    {
        return false;
    }
    
    if ( issubstr( objweapon.basename, "iw9_me_fists_mp_zmb" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0x1032
// Size: 0xd
function activatemutationmodeperk03()
{
    self.var_5651e2b694c25c8b = 1;
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0x1047
// Size: 0x14
function activatemutationmodeperk04()
{
    scripts\mp\killstreaks\killstreaks::givestreakpoints( #"kill", 1 );
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 0
// Checksum 0x0, Offset: 0x1063
// Size: 0x18
function activatemutationmodeperk05()
{
    self.var_db2bc93f2ccf1f0b = 0;
    giveperk( "specialty_eod_vest" );
}

// Namespace escort_horde_event_perks / scripts\mp\gametypes\escort_horde_event_perks
// Params 1
// Checksum 0x0, Offset: 0x1083
// Size: 0x119
function function_5aa0301754c24686( params )
{
    if ( !isdefined( params.victim ) )
    {
        return;
    }
    
    if ( !isplayer( params.victim ) )
    {
        return;
    }
    
    if ( !isalive( params.victim ) )
    {
        return;
    }
    
    if ( !params.victim [[ getsharedfunc( "escort", "isZombie" ) ]]() )
    {
        return;
    }
    
    if ( !params.victim hasmutationmodeperk05() )
    {
        return;
    }
    
    damagetype = utility::getdamagetype( params.smeansofdeath );
    
    if ( !is_equal( damagetype, "splash" ) )
    {
        return;
    }
    
    victim = params.victim;
    victim.var_db2bc93f2ccf1f0b++;
    var_47be5d95802807c9 = getdvarint( @"hash_ef09092a12a6e8c8", 3 );
    
    if ( victim hasmutationmodeperk05() && victim _hasperk( "specialty_eod_vest" ) && victim.var_db2bc93f2ccf1f0b >= var_47be5d95802807c9 )
    {
        victim removeperk( "specialty_eod_vest" );
    }
}

