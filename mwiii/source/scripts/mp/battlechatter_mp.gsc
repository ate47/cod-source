#using scripts\common\bcs_location_trigs;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_trigs;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace battlechatter_mp;

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x1250
// Size: 0x494
function init()
{
    level.battlechatterenabled = getdvarint( @"hash_7bdf6d033065ef17", 1 ) == 1;
    friendlydist = getdvarint( @"hash_fc4b1a7d66dbeb32", 1800 );
    level.var_98014172ce4b4e67 = friendlydist * friendlydist;
    level.speakers = [];
    level.bcinfo = [];
    level.bcinfo[ "max_wait_time" ] = 1000;
    level.bcinfo[ "soundEventHistory" ] = [];
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    level.var_c49bb6749e2ce50c = physics_createcontents( content );
    
    foreach ( teamname in level.teamnamelist )
    {
        level.isteamspeaking[ teamname ] = 0;
        level.speakers[ teamname ] = [];
        level.bcinfo[ "queued" ][ teamname ] = "none";
    }
    
    thread monitorspeakers();
    setupselfvo();
    function_9cd008247ba86bcd();
    registerbcsoundtype( #"callout_location", undefined, 1, 1, 10, 10, 0 );
    scriptbundlename = "battlechatter_list";
    
    if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.battlechatterlist ) )
    {
        scriptbundlename = level.gamemodebundle.battlechatterlist;
    }
    else if ( getdvarint( @"t10" ) > 0 )
    {
        scriptbundlename += "_t10_mp";
    }
    else if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        scriptbundlename += "_wz2_br";
    }
    else
    {
        scriptbundlename += "_iw9_mp";
    }
    
    bundle = getscriptbundle( "battlechatterlist:" + scriptbundlename );
    
    if ( isdefined( bundle ) )
    {
        foreach ( event in bundle.battlechatterevents )
        {
            eventname = event.eventname;
            var_4f632c1568af9fc0 = event.soundevent;
            priority = event.priority;
            chance = event.chance;
            timeoutpos = event.timeoutpos;
            timeoutspeaker = event.timeoutspeaker;
            var_3910458d599e5e01 = event.var_3910458d599e5e01;
            registerbcsoundtype( eventname, var_4f632c1568af9fc0, priority, chance, timeoutpos, timeoutspeaker, var_3910458d599e5e01 );
        }
        
        foreach ( event in bundle.pingevents )
        {
            eventname = event.eventname;
            var_4f632c1568af9fc0 = event.soundevent;
            priority = event.priority;
            chance = event.chance;
            timeoutpos = event.timeoutpos;
            timeoutspeaker = event.timeoutspeaker;
            var_3910458d599e5e01 = event.var_3910458d599e5e01;
            registerbcsoundtype( eventname, var_4f632c1568af9fc0, priority, chance, timeoutpos, timeoutspeaker, var_3910458d599e5e01 );
        }
    }
    
    level.func_bcs_location_trigs = &scripts\mp\battlechatter_trigs::extra_location_trigger_mapping;
    scripts\common\bcs_location_trigs::bcs_location_trigs_init();
    gametype = scripts\cp_mp\utility\game_utility::getgametype();
    level.istacticalbc = 0;
    
    if ( scripts\mp\utility\game::getbasegametype() == "sd" || gametype == "cyber" || gametype == "arena" )
    {
        level.istacticalbc = 1;
    }
    
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    
    /#
        setdevdvarifuninitialized( @"debug_bcprint", "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_9627c73338f91622", "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_3cb0b3f110a54cf2", "<dev string:x23>" );
    #/
    
    if ( isdefined( level.var_d3b5b44c28ca2aa1 ) )
    {
        [[ level.var_d3b5b44c28ca2aa1 ]]();
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x16ec
// Size: 0x2
function private function_9cd008247ba86bcd()
{
    
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x16f6
// Size: 0x56
function private function_4c2643be02acc9d2( eventname )
{
    assertex( isstring( eventname ), "<dev string:x2a>" );
    
    if ( !isdefined( level.battlechatterfilter ) )
    {
        level.battlechatterfilter = [];
    }
    
    level.battlechatterfilter[ getxhash( eventname ) ] = hashcat( @"hash_ee1ba8e906086c3c", eventname );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1754
// Size: 0x66, Type: bool
function private function_bc76cf7adda53de3( eventname )
{
    assertex( isxhash( eventname ), "<dev string:x5a>" );
    
    if ( isdefined( level.battlechatterfilter ) && isdefined( level.battlechatterfilter[ eventname ] ) )
    {
        return ( getdvarint( @"hash_a48e01ab7c276ef4", 0 ) != 0 || getdvarint( level.battlechatterfilter[ eventname ], 0 ) != 0 );
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 7
// Checksum 0x0, Offset: 0x17c3
// Size: 0x145
function registerbcsoundtype( soundtype, var_4f632c1568af9fc0, priority, chance, timeoutpos, timeoutspeaker, var_3910458d599e5e01 )
{
    if ( !isdefined( soundtype ) )
    {
        assertmsg( "<dev string:x89>" );
        return;
    }
    
    if ( !isdefined( priority ) || priority == 1 )
    {
        priority = undefined;
    }
    
    if ( !isdefined( chance ) || chance == 0 || function_bc76cf7adda53de3( soundtype ) )
    {
        chance = undefined;
    }
    
    if ( !isdefined( timeoutpos ) || timeoutpos == 1 )
    {
        timeoutpos = undefined;
    }
    else
    {
        timeoutpos *= 1000;
    }
    
    if ( !isdefined( timeoutspeaker ) || timeoutspeaker == 1 )
    {
        timeoutspeaker = undefined;
    }
    else
    {
        timeoutspeaker *= 1000;
    }
    
    if ( !isdefined( var_3910458d599e5e01 ) || var_3910458d599e5e01 == 0 )
    {
        var_3910458d599e5e01 = undefined;
    }
    
    level.bcinfo[ "asset" ][ soundtype ] = var_4f632c1568af9fc0;
    level.bcinfo[ "priority" ][ soundtype ] = priority;
    level.bcinfo[ "chance" ][ soundtype ] = chance;
    level.bcinfo[ "timeout_pos" ][ soundtype ] = timeoutpos;
    level.bcinfo[ "timeout_player" ][ soundtype ] = timeoutspeaker;
    level.bcinfo[ "req_friendly" ][ soundtype ] = var_3910458d599e5e01;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x1910
// Size: 0xe0
function onplayerspawned()
{
    self.bcinfoqueued = "none";
    self.var_cf34556d563b92ae = 0;
    self.recentattackers = [];
    self.bcinfolastsaytimes = [];
    
    if ( level.splitscreen )
    {
        return;
    }
    
    if ( !level.teambased || level.istacticalbc || istrue( level.disablebattlechatter ) || isanymlgmatch() )
    {
        self.bcdisabled = 1;
        return;
    }
    
    if ( !scripts\mp\utility\game::runleanthreadmode() || istrue( level.br_practice_match ) )
    {
        thread reloadtracking();
        thread threatcallouttracking();
        thread onsixfriendlytracking();
        
        if ( istrue( self.wassquadspawned ) )
        {
            level thread trysaylocalsound( self, #"bc_status_inform_on_your_six" );
        }
        
        return;
    }
    
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        self.bcdisabled = 1;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x19f8
// Size: 0x30
function hurtbadlywait()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "bc_damage_taken" );
    wait 1.5;
    level thread trysaylocalsound( self, #"bc_status_player_low_health" );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x1a30
// Size: 0xa0
function validaterecentattackers()
{
    if ( !isdefined( self.recentattackers ) )
    {
        self.recentattackers = [];
        return;
    }
    
    var_9225a7e3e5cc65ff = [];
    currenttime = gettime();
    
    foreach ( event in self.recentattackers )
    {
        if ( currenttime < event.ignoreaftertime )
        {
            var_9225a7e3e5cc65ff[ var_9225a7e3e5cc65ff.size ] = event;
        }
    }
    
    self.recentattackers = var_9225a7e3e5cc65ff;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x1ad8
// Size: 0x11d
function addrecentattacker( attacker )
{
    if ( !isdefined( self.recentattackers ) )
    {
        self.recentattackers = [];
    }
    
    attackerexists = 0;
    
    foreach ( event in self.recentattackers )
    {
        if ( event.attacker == attacker )
        {
            attackerexists = 1;
            event.time = gettime();
            event.ignoreaftertime = event.time + 2000;
            break;
        }
    }
    
    if ( !attackerexists )
    {
        event = spawnstruct();
        event.time = gettime();
        event.attacker = attacker;
        event.ignoreaftertime = event.time + 2000;
        self.recentattackers[ self.recentattackers.size ] = event;
    }
    
    validaterecentattackers();
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x1bfd
// Size: 0xcd
function launcherfired( missile )
{
    missile endon( "death" );
    
    while ( true )
    {
        nearplayers = utility::playersinsphere( missile.origin, 500 );
        
        foreach ( player in nearplayers )
        {
            if ( !isdefined( player ) || !player scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( isdefined( missile.owner ) && !missile.owner scripts\cp_mp\utility\player_utility::isenemy( player ) )
            {
                continue;
            }
            
            level thread trysaylocalsound( player, #"bc_equipment_incoming_rpg" );
            return;
        }
        
        waitframe();
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x1cd2
// Size: 0x86
function javelinfired( team, target )
{
    if ( !level.teambased )
    {
        return;
    }
    
    enemyteam = random( getotherteam( team ) );
    var_6022f416c78a2d65 = getplayersinradius( target, 360000, undefined, undefined, enemyteam );
    
    if ( var_6022f416c78a2d65.size == 0 )
    {
        return;
    }
    
    player = random( var_6022f416c78a2d65 );
    level thread trysaylocalsound( player, #"bc_equipment_incoming_rpg", undefined, 0.5 );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x1d60
// Size: 0x3bc
function ongrenadeuse( grenade )
{
    weaponrootname = getweaponrootstring( grenade.weapon_object );
    
    switch ( weaponrootname )
    {
        case #"hash_7c03088193266bc4":
            level thread trysaylocalsound( self, #"bc_equipment_action_grenade" );
            break;
        case #"hash_5d11ac1131cddab1":
            level thread trysaylocalsound( self, #"bc_equipment_action_semtex" );
            break;
        case #"hash_c9a436974fe60919":
            level thread trysaylocalsound( self, #"bc_equipment_action_molotov" );
            break;
        case #"hash_a0319e349a692b8f":
            level thread trysaylocalsound( self, #"bc_equipment_action_thermite" );
            break;
        case #"hash_fa1e80f6bd5b8e72":
            level thread trysaylocalsound( self, #"bc_equipment_action_c4" );
            break;
        case #"hash_36b7174a04de8799":
            level thread trysaylocalsound( self, #"bc_equipment_action_claymore" );
            break;
        case #"hash_9d57562863499a06":
        case #"hash_d111e0af321b440f":
            level thread trysaylocalsound( self, #"bc_equipment_action_proxmine" );
            break;
        case #"hash_e042760d17966848":
            level thread trysaylocalsound( self, #"bc_equipment_action_flashbang" );
            break;
        case #"hash_8670ac083666f3a4":
            level thread trysaylocalsound( self, #"bc_equipment_action_stun" );
            break;
        case #"hash_13492848c09971da":
            level thread trysaylocalsound( self, #"bc_equipment_action_snapshot" );
            break;
        case #"hash_e1f6f84e4cd950eb":
            level thread trysaylocalsound( self, #"bc_equipment_action_smoke" );
            break;
        case #"hash_8059d93d3568c07":
        case #"hash_fb36696c0708bf42":
            level thread trysaylocalsound( self, #"bc_equipment_action_gas" );
            break;
        case #"hash_333525cef39d0c66":
            level thread trysaylocalsound( self, #"bc_equipment_action_decoy" );
            break;
        case #"hash_675a272e58f54e46":
            level thread trysaylocalsound( self, #"bc_equipment_action_stim" );
            break;
        case #"hash_11a03a12f93f62b2":
            level thread trysaylocalsound( self, #"bc_equipment_action_shockstick" );
            break;
        case #"hash_d9108a0595d7d0b9":
            level thread trysaylocalsound( self, #"bc_equipment_action_buster" );
            break;
        case #"hash_13d1f84d0ae96a5f":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_trophy" );
            break;
        case #"hash_6bc36a1e4f485a79":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_ammobox" );
            break;
        case #"hash_7e0a03ed7c4c87be":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_armorbox" );
            break;
        case #"hash_5f29cda9550e6a3a":
            level thread trysaylocalsound( self, #"bc_equipment_action_butterfly_mine" );
            break;
        case #"hash_17c70dc48424ba92":
            level thread trysaylocalsound( self, #"bc_equipment_action_breacher_drone" );
            break;
        case #"hash_849c32fe9df2b823":
            level thread trysaylocalsound( self, #"bc_equipment_action_capture_bot" );
            break;
        case #"hash_606cb2a6a1a3bd0a":
            level thread trysaylocalsound( self, #"bc_equipment_action_thermobaric" );
            break;
        case #"hash_fe9ad5ea24dec618":
            level thread trysaylocalsound( self, #"bc_equipment_action_armor_drop" );
            break;
        case #"hash_4091bf4696831b2a":
            level thread trysaylocalsound( self, #"bc_equipment_action_tracker" );
            break;
        case #"hash_37f0e5959e7222f":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_medbox" );
            break;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x2124
// Size: 0x262
function function_204aeba40a2aa027( superref )
{
    switch ( superref )
    {
        case #"hash_ac2ab6307a9fe4ec":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_armorbox" );
            break;
        case #"hash_3d18c216d6eeb2cc":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_aprounds" );
            break;
        case #"hash_f2f5c0ae2a0a92c2":
            if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.operatorref ) && self.operatorcustomization.operatorref == "nikto_eastern" )
            {
                return;
            }
            
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_battlerage" );
            break;
        case #"hash_b0c881a998e8d402":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_deadsilence" );
            break;
        case #"hash_6f4c7534ae718637":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_deployablecover" );
            break;
        case #"hash_53ec74c436e095e3":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_emppulse" );
            break;
        case #"hash_d2e07f72a95c89d0":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_inflatabledecoy" );
            break;
        case #"hash_7266a252f51150e9":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_recondrone" );
            break;
        case #"hash_d162cb5f4a711830":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_smokedrop" );
            break;
        case #"hash_4599084f04ba2bfe":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_sonarpulse" );
            break;
        case #"hash_9f0b371acb28a571":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_soundveil" );
            break;
        case #"hash_4200221a42387567":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_stimpistol" );
            break;
        case #"hash_2a2d382fc09b9c1b":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_taccamera" );
            break;
        case #"hash_6f88368e0ee40cf5":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_action_comm_scrambler" );
            break;
        default:
            break;
    }
    
    if ( isdefined( self.team ) )
    {
        level notify( "fieldUpgrade_used_" + self.team, superref );
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x238e
// Size: 0x16
function onfieldupgradedestroy( chatterref )
{
    level thread trysaylocalsound( self, chatterref );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x23ac
// Size: 0x543
function grenadeproximitytracking()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isprophuntgametype() )
    {
        return;
    }
    
    objweapon = self.weapon_object;
    weaponrootname = getweaponrootstring( objweapon );
    
    switch ( weaponrootname )
    {
        case #"hash_8059d93d3568c07":
        case #"hash_13492848c09971da":
        case #"hash_5d11ac1131cddab1":
        case #"hash_7c03088193266bc4":
        case #"hash_8670ac083666f3a4":
        case #"hash_a0319e349a692b8f":
        case #"hash_c9a436974fe60919":
        case #"hash_e042760d17966848":
        case #"hash_e1f6f84e4cd950eb":
        case #"hash_fa1e80f6bd5b8e72":
        case #"hash_fb36696c0708bf42":
            break;
        default:
            if ( weaponclass( self.weapon_name ) == "rocketlauncher" )
            {
                break;
            }
            
            return;
    }
    
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        owner = getmissileowner( self );
    }
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    querylocation = self.origin;
    nearbyplayers = utility::playersnear( querylocation, 960 );
    self endon( "death" );
    
    while ( isdefined( self.origin ) )
    {
        if ( distancesquared( querylocation, self.origin ) > 768 * 768 )
        {
            querylocation = self.origin;
            nearbyplayers = utility::playersnear( querylocation, 960 );
        }
        
        foreach ( player in nearbyplayers )
        {
            if ( !isdefined( player ) || player scripts\cp_mp\utility\player_utility::_isalive() == 0 || isdefined( self.owner ) && isalive( self.owner ) && self.owner scripts\cp_mp\utility\player_utility::isenemy( player ) == 0 )
            {
                continue;
            }
            
            grenadedistancesquared = distancesquared( self.origin, player.origin );
            
            if ( isdefined( grenadedistancesquared ) && grenadedistancesquared < 147456 )
            {
                if ( !sighttracepassed( player geteye(), self.origin, 0, player ) )
                {
                    continue;
                }
                
                switch ( weaponrootname )
                {
                    case #"hash_7c03088193266bc4":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_grenade", undefined, undefined, undefined, self );
                        break;
                    case #"hash_8670ac083666f3a4":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_stun", undefined, undefined, undefined, self );
                        break;
                    case #"hash_e042760d17966848":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_flashbang", undefined, undefined, undefined, self );
                        break;
                    case #"hash_e1f6f84e4cd950eb":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_generic", undefined, undefined, undefined, self );
                        break;
                    case #"hash_5d11ac1131cddab1":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_semtex", undefined, undefined, undefined, self );
                        break;
                    case #"hash_c9a436974fe60919":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_molotov", undefined, undefined, undefined, self );
                        break;
                    case #"hash_fa1e80f6bd5b8e72":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_c4", undefined, undefined, undefined, self );
                        break;
                    case #"hash_13492848c09971da":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_generic", undefined, undefined, undefined, self );
                        break;
                    case #"hash_a0319e349a692b8f":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_thermite", undefined, undefined, undefined, self );
                        break;
                    case #"hash_8059d93d3568c07":
                    case #"hash_fb36696c0708bf42":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_gas", undefined, undefined, undefined, self );
                        break;
                    case #"hash_11a03a12f93f62b2":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_shockstick", undefined, undefined, undefined, self );
                        break;
                    case #"hash_d9108a0595d7d0b9":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_buster", undefined, undefined, undefined, self );
                        break;
                    case #"hash_5f29cda9550e6a3a":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_butterfly_mines", undefined, undefined, undefined, self );
                        break;
                    case #"hash_17c70dc48424ba92":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_breacher_drone", undefined, undefined, undefined, self );
                        break;
                    case #"hash_606cb2a6a1a3bd0a":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_thermobaric", undefined, undefined, undefined, self );
                        break;
                    case #"hash_7a687f6a4d685110":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_switchblade_drone", undefined, undefined, undefined, self );
                        break;
                    case #"hash_4091bf4696831b2a":
                        level thread trysaylocalsound( player, #"bc_equipment_incoming_tracker", undefined, undefined, undefined, self );
                        break;
                    default:
                        if ( weaponclass( self.weapon_name ) == "rocketlauncher" )
                        {
                            level thread trysaylocalsound( player, #"bc_equipment_incoming_rpg", undefined, undefined, undefined, self );
                        }
                        
                        break;
                }
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x28f7
// Size: 0x121
function equipmentdestroyed( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( !isdefined( ent.weapon_name ) )
    {
        return;
    }
    
    switch ( ent.weapon_name )
    {
        case #"hash_56ee829cc162271a":
            break;
        case #"hash_5e8f81314553dd36":
            break;
        case #"hash_6a2e4f9c54756dc7":
            break;
        case #"hash_5e3fa526a48eaaa5":
            break;
        case #"hash_36d0be2b0f1c99e":
            break;
        case #"hash_9ca85335d506dad6":
            break;
        case #"hash_cac2107b8e726d9d":
            break;
        case #"hash_117f8b2c4362d5b2":
            break;
        case #"hash_b82bf6dc767609aa":
            break;
        case #"hash_f2e793d6a4fe013e":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_killfirm_armorbox" );
            break;
        case #"hash_24fa33b49ea5081":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_killfirm_comm_scrambler" );
            break;
        case #"hash_37f0e5959e7222f":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_killfirm_medbox" );
            break;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x2a20
// Size: 0x37e
function playkillstreakdeploydialog( owner, streakname )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    switch ( streakname )
    {
        case #"hash_349713b5ad494dda":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_887ad77192b9c4fb":
        case #"hash_b161e185f1b8e117":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_airsupport" );
            break;
        case #"hash_cf0ef5bef19a311b":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_wheelson" );
            break;
        case #"hash_56979e0566996b2e":
        case #"hash_2289ec11d77bce8f":
        case #"hash_4ad475e6e15635bd":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_airdrop" );
            break;
        case #"hash_cd0a0403551fc411":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_juggernaut_recon" );
            break;
        case #"hash_4d5aa76e8707f47b":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_sentrygun" );
            break;
        case #"hash_195360490caa3220":
        case #"hash_7e7648c4805888c5":
        case #"hash_de3d319cd367bcba":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_nuke" );
            break;
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_8c766d6477287bb6":
        case #"hash_28d0236400e33fd0":
        case #"hash_4220be38a5f150b8":
        case #"hash_42fd64e842a4c3d7":
        case #"hash_48cc3a9a58208f82":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_airstrike" );
            break;
        case #"hash_a1031216158c7882":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_loitering_munition" );
            break;
        case #"hash_f7fc1b72c49ab1d":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
        case #"hash_e51f2e3d5cdd8ed8":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_recon" );
            break;
        case #"hash_27002778019fb447":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_counteruav" );
            break;
        case #"hash_4d35eb58f9d545f0":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_clustermine" );
            break;
        case #"hash_9e36e3bd3a9dd00d":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_bombdrone" );
            break;
        case #"hash_b4ac3581c343a029":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_mortarstrike" );
            break;
        case #"hash_19dd9a3a4147e09e":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_lrad" );
            break;
        case #"hash_7a687f6a4d685110":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_switchblade_drone" );
            break;
        case #"hash_6362d6aae3e5a62e":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_drone_swarm" );
            break;
        case #"hash_ed469a6bfff6b265":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_emp" );
            break;
        case #"hash_ab5712e297cd430e":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_remoteturret" );
            break;
        case #"hash_b571a6187bf67f9e":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_missile_turret" );
            break;
        case #"hash_472d8b6c2f51a9c8":
            level thread trysaylocalsound( owner, #"bc_killstreak_action_ims" );
            break;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x2da6
// Size: 0x79
function getplayersinteam( team )
{
    playerlist = [];
    
    foreach ( player in level.players )
    {
        if ( player.team == team )
        {
            playerlist[ playerlist.size ] = player;
        }
    }
    
    return playerlist;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x2e28
// Size: 0x2e8
function killstreakdestroyed( streakname )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    switch ( streakname )
    {
        case #"hash_413c38e72fe8b5bf":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_gunship" );
            break;
        case #"hash_2289ec11d77bce8f":
        case #"hash_349713b5ad494dda":
        case #"hash_56979e0566996b2e":
        case #"hash_887ad77192b9c4fb":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_heli" );
            break;
        case #"hash_cf0ef5bef19a311b":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_wheelson" );
            break;
        case #"hash_bf2f9adbd2b41d5":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_vtol" );
            break;
        case #"hash_4ad475e6e15635bd":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_juggernaut" );
            break;
        case #"hash_cd0a0403551fc411":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_juggernaut_recon" );
            break;
        case #"hash_4d5aa76e8707f47b":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_sentrygun" );
            break;
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
        case #"hash_e51f2e3d5cdd8ed8":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_uav" );
            break;
        case #"hash_10e585c25e7e9f60":
        case #"hash_27002778019fb447":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_counteruav" );
            break;
        case #"hash_4d35eb58f9d545f0":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_clustermine" );
            break;
        case #"hash_9e36e3bd3a9dd00d":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_bombdrone" );
            break;
        case #"hash_e40585107590f016":
            level thread trysaylocalsound( self, #"bc_fieldupgrade_killfirm_recondrone" );
            break;
        case #"hash_19dd9a3a4147e09e":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_lrad" );
            break;
        case #"hash_7a687f6a4d685110":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_switchblade_drone" );
            break;
        case #"hash_6362d6aae3e5a62e":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_drone_swarm" );
            break;
        case #"hash_a1031216158c7882":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_loitering_munition" );
            break;
        case #"hash_ab5712e297cd430e":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_remoteturret" );
            break;
        case #"hash_b571a6187bf67f9e":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_missile_turret" );
            break;
        case #"hash_472d8b6c2f51a9c8":
            level thread trysaylocalsound( self, #"bc_killstreak_killfirm_ims" );
            break;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x3118
// Size: 0x4a
function suppressingfiretracking()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    var_6882a17ec6a9d934 = undefined;
    
    if ( isprophuntgametype() )
    {
        return;
    }
    
    for ( ;; )
    {
        self waittill( "begin_firing" );
        thread suppresswaiter();
        thread suppresstimeout();
        self waittill( "stoppedFiring" );
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x316a
// Size: 0x27
function suppresstimeout()
{
    thread waitsuppresstimeout();
    self endon( "begin_firing" );
    self waittill( "end_firing" );
    wait 0.3;
    self notify( "stoppedFiring" );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x3199
// Size: 0x19
function waitsuppresstimeout()
{
    self endon( "stoppedFiring" );
    self waittill( "begin_firing" );
    thread suppresstimeout();
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x31ba
// Size: 0x22
function suppresswaiter()
{
    self notify( "suppressWaiter" );
    self endon( "suppressWaiter" );
    self endon( "death_or_disconnect" );
    self endon( "stoppedFiring" );
    wait 1;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x31e4
// Size: 0x307
function reloadtracking()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    
    if ( isprophuntgametype() )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( "reload_start" );
        objweapon = self getcurrentweapon();
        
        if ( !isdefined( objweapon ) )
        {
            continue;
        }
        
        hasakimbo = weaponhasattachment( objweapon, "akimbo" );
        
        if ( hasakimbo )
        {
            remainingammo = self getweaponammoclip( objweapon, "right" ) + self getweaponammoclip( objweapon, "left" ) + self getweaponammostock( objweapon );
        }
        else
        {
            remainingammo = self getweaponammoclip( objweapon ) + self getweaponammostock( objweapon );
        }
        
        var_54a24336cc9a143d = istrue( objweapon.isalternate ) && ( weaponclass( objweapon ) == "grenade" || weaponclass( objweapon ) == "spread" );
        var_bc6925748f6b3a6 = function_8a4f25fb9d4c43c8( objweapon );
        
        if ( remainingammo <= weaponclipsize( objweapon ) || hasakimbo && remainingammo <= weaponclipsize( objweapon ) * 2 )
        {
            weapongroup = getweapongroup( objweapon );
            var_38497ce38042adf7 = 0;
            
            switch ( getweaponrootname( objweapon ) )
            {
                case #"hash_607145e68712971c":
                case #"hash_8d9ae5e5dd390b4b":
                case #"hash_d2d2f2854b7d8b7d":
                case #"hash_ec99e7d11ddb9eea":
                    var_38497ce38042adf7 = 1;
                    break;
            }
            
            var_da66af6058340796 = var_38497ce38042adf7 || var_54a24336cc9a143d;
            
            if ( !var_da66af6058340796 )
            {
                if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
                {
                    switch ( weapongroup )
                    {
                        case #"hash_34340d457a63e7f1":
                        case #"hash_ab10f9c080fe4faf":
                            level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_smallcal" );
                            break;
                        case #"hash_8af0086b038622b5":
                        case #"hash_dd616da0b395a0b0":
                            level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_midcal" );
                            break;
                        case #"hash_bef5ec0b3e197ae":
                        case #"hash_47368bc0d2ef1565":
                        case #"hash_c095d67337b1f5a1":
                            level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_highcal" );
                            break;
                        case #"hash_16cf6289ab06bd30":
                            level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_shells" );
                            break;
                        case #"hash_9d18adab1b65a661":
                            level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_launcher" );
                            break;
                    }
                }
                else if ( var_bc6925748f6b3a6 )
                {
                    level thread trysaylocalsound( self, #"bc_combat_action_last_mag" );
                }
                else
                {
                    level thread trysaylocalsound( self, #"bc_combat_action_lowammo" );
                }
            }
            
            continue;
        }
        
        validaterecentattackers();
        var_4291fa32c3861d68 = scripts\cp_mp\talking_gun::function_7b50742a287d3ca1( self ) && cointoss();
        
        if ( var_4291fa32c3861d68 )
        {
            scripts\cp_mp\talking_gun::function_c5f05871ba7c3aa3();
            continue;
        }
        
        if ( var_bc6925748f6b3a6 )
        {
            level thread trysaylocalsound( self, #"bc_combat_action_reloading" );
            continue;
        }
        
        level thread trysaylocalsound( self, #"bc_combat_action_reloadnomag" );
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x34f3
// Size: 0x20
function sprinttracking()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    
    while ( true )
    {
        self waittill( "sprint_begin" );
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x351b
// Size: 0x34e
function threatcallouttracking()
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    
    if ( isprophuntgametype() )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( "enemy_sighted" );
        
        if ( getomnvar( "ui_prematch_period" ) )
        {
            level waittill( "prematch_over" );
            continue;
        }
        
        if ( saidtoorecently( #"bc_combat_inform_contact_generic" ) || saidtoorecently( #"bc_combat_inform_contact" ) || saidtoorecently( #"bc_combat_inform_contact_multiple" ) )
        {
            continue;
        }
        
        enemies = self getsightedplayers();
        
        if ( !isdefined( enemies ) )
        {
            continue;
        }
        
        enemycount = 0;
        dist = 4000000;
        isads = self playerads() > 0.7;
        
        if ( isads )
        {
            dist = 9000000;
        }
        
        var_5486190c6b06a3c9 = get_last_callout_time( self.team );
        cancalloutlocation = !isdefined( var_5486190c6b06a3c9 ) || var_5486190c6b06a3c9 + function_ffd3470f08fcf7a7( #"callout_location" ) < gettime();
        playedlocation = 0;
        forward = anglestoforward( self.angles );
        
        foreach ( enemy in enemies )
        {
            toenemy = vectornormalize( enemy.origin - self.origin );
            
            if ( isdefined( enemy ) && isreallyalive( enemy ) && !enemy _hasperk( "specialty_coldblooded" ) && distancesquared( self.origin, enemy.origin ) < dist && vectordot( forward, toenemy ) > ter_op( isads, 0.984808, 0.939692 ) )
            {
                location = enemy getvalidlocation( self );
                enemycount++;
                
                if ( isdefined( location ) && cancalloutlocation )
                {
                    alias = "dx_mpo_" + ter_op( self.team == "allies", "usop", "ruop" ) + "_loc_enemy_" + location.locationaliases[ 0 ];
                    location_add_last_callout_time( location.locationaliases[ 0 ], self.team );
                    
                    if ( soundexists( alias ) )
                    {
                        self playsoundtoteam( alias, self.team );
                        playedlocation = 1;
                    }
                    
                    break;
                }
            }
        }
        
        if ( enemycount > 0 )
        {
            alias = undefined;
            
            if ( !saidtoorecently( #"bc_combat_inform_contact_generic" ) )
            {
                alias = #"bc_combat_inform_contact_generic";
            }
            
            if ( !saidtoorecently( #"bc_combat_inform_contact" ) )
            {
                if ( isdefined( alias ) )
                {
                    if ( cointoss() )
                    {
                        alias = #"bc_combat_inform_contact";
                    }
                }
                else
                {
                    alias = #"bc_combat_inform_contact";
                }
            }
            
            if ( enemycount > 1 && !saidtoorecently( #"bc_combat_inform_contact_multiple" ) )
            {
                if ( isdefined( alias ) )
                {
                    if ( cointoss() )
                    {
                        alias = #"bc_combat_inform_contact_multiple";
                    }
                }
                else
                {
                    alias = #"bc_combat_inform_contact_multiple";
                }
            }
            
            level thread trysaylocalsound( self, alias );
        }
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 3
// Checksum 0x0, Offset: 0x3871
// Size: 0x22d
function dosound( soundtype, targetent, location )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isreallyalive( self ) )
    {
        return;
    }
    
    soundaliasbase = soundtype;
    
    if ( isdefined( location ) )
    {
        soundaliasbase = "loc_callout_" + location;
    }
    
    if ( soundtype == #"bc_combat_action_execution" )
    {
        if ( self.operatorcustomization.executionquip == "none" )
        {
            soundtype = #"bc_combat_action_execution";
        }
    }
    
    var_4f632c1568af9fc0 = level.bcinfo[ "asset" ][ soundtype ];
    logprint( "battlechatter_mp::doSound - PlaySoundEvent()" );
    logprint( "self         = " + self.name );
    logprint( "sessionstate = " + self.sessionstate );
    logprint( "targetEnt    = " + isdefined( targetent ) );
    
    if ( isdefined( targetent ) )
    {
        logprint( "tEntclassname = " + targetent.classname );
        logprint( "tEntOrigin    = " + targetent.origin );
        
        if ( isplayer( targetent ) )
        {
            logprint( "tEntSessionstate = " + targetent.sessionstate );
        }
    }
    
    if ( isdefined( targetent ) && isent( targetent ) )
    {
        self playsoundevent( var_4f632c1568af9fc0, targetent );
    }
    else
    {
        self playsoundevent( var_4f632c1568af9fc0 );
    }
    
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_operator_vo", { #target:targetent, #speaker:self, #sound_event:var_4f632c1568af9fc0, #sound_type:soundtype, #script_func_name:"doSound" } );
    
    if ( isdefined( location ) )
    {
        location_add_last_callout_time( location, self.team );
    }
    
    priority = function_336e1f89ae06dfd4( soundtype );
    speakerteam = self.team;
    level addspeaker( self, speakerteam, soundtype, priority );
    updatechatter( soundtype );
    duration = 1.5;
    thread timehack( getxhashhexname( soundtype ), duration );
    waittill_any_2( getxhashhexname( soundtype ), "death_or_disconnect" );
    level removespeaker( self, speakerteam );
    return 1;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x3aa7
// Size: 0x20
function timehack( soundalias, duration )
{
    self endon( "death_or_disconnect" );
    wait duration;
    self notify( soundalias );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x3acf
// Size: 0xde, Type: bool
function isspeakerinrange( player, max_dist )
{
    if ( !isdefined( max_dist ) )
    {
        max_dist = 1000;
    }
    
    distsq = max_dist * max_dist;
    
    if ( isdefined( player ) && isdefined( player.team ) && player.team != "spectator" )
    {
        for ( index = 0; index < level.speakers[ player.team ].size ; index++ )
        {
            teammate = level.speakers[ player.team ][ index ][ "player" ];
            
            if ( teammate == player )
            {
                return true;
            }
            
            if ( !isdefined( teammate ) )
            {
                continue;
            }
            
            if ( distancesquared( teammate.origin, player.origin ) < distsq )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 4
// Checksum 0x0, Offset: 0x3bb6
// Size: 0xf9
function addspeaker( player, team, soundtype, priority )
{
    duration = 1.5;
    index = level.speakers[ team ].size;
    level.speakers[ team ][ index ] = [];
    level.speakers[ team ][ index ][ "player" ] = player;
    level.speakers[ team ][ index ][ "sound_alias" ] = soundtype;
    level.speakers[ team ][ index ][ "sound_type" ] = soundtype;
    level.speakers[ team ][ index ][ "priority" ] = priority;
    level.speakers[ team ][ index ][ "endTime" ] = gettime() + duration * 1000;
    player thread timehack( getxhashhexname( soundtype ), duration );
    player waittill_any_2( getxhashhexname( soundtype ), "death_or_disconnect" );
    level removespeaker( player, team );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x3cb7
// Size: 0x9a
function removespeaker( player, team )
{
    newspeakers = [];
    
    for ( index = 0; index < level.speakers[ team ].size ; index++ )
    {
        if ( isdefined( player ) && isdefined( level.speakers[ team ][ index ][ "player" ] ) && level.speakers[ team ][ index ][ "player" ] == player )
        {
            continue;
        }
        
        newspeakers[ newspeakers.size ] = level.speakers[ team ][ index ];
    }
    
    level.speakers[ team ] = newspeakers;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x3d59
// Size: 0xd9
function monitorspeakers()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        foreach ( team, speakerlist in level.speakers )
        {
            foreach ( speaker in speakerlist )
            {
                if ( speaker[ "endTime" ] <= gettime() )
                {
                    removespeaker( speaker[ "player" ], team );
                    speaker[ "player" ] notify( getxhashhexname( speaker[ "sound_type" ] ) );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x3e3a
// Size: 0x19
function disablebattlechatter( player )
{
    player.bcdisabled = 1;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x3e5b
// Size: 0x16
function enablebattlechatter( player )
{
    player.bcdisabled = undefined;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x3e79
// Size: 0xb1
function updatechatter( soundtype )
{
    if ( !isdefined( level.bcinfo[ "soundEventHistory" ][ soundtype ] ) )
    {
        level.bcinfo[ "soundEventHistory" ][ soundtype ] = [];
    }
    
    time = gettime();
    cleanuplastsaytimes( soundtype, time );
    self.bcinfolastsaytimes[ soundtype ] = time;
    data = spawnstruct();
    data.origin = self.origin;
    data.time = time;
    level.bcinfo[ "soundEventHistory" ][ soundtype ][ level.bcinfo[ "soundEventHistory" ][ soundtype ].size ] = data;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x3f32
// Size: 0x122
function cleanuplastsaytimes( soundtype, time )
{
    temparray = [];
    
    foreach ( var_743aedab468adbb, timestamp in self.bcinfolastsaytimes )
    {
        timeout = function_a71193e9db14c926( var_743aedab468adbb ) + timestamp;
        
        if ( time < timeout )
        {
            temparray[ var_743aedab468adbb ] = timestamp;
        }
    }
    
    self.bcinfolastsaytimes = temparray;
    temparray = [];
    
    foreach ( event in level.bcinfo[ "soundEventHistory" ][ soundtype ] )
    {
        if ( time < event.time + function_ffd3470f08fcf7a7( soundtype ) )
        {
            temparray[ temparray.size ] = event;
        }
    }
    
    level.bcinfo[ "soundEventHistory" ][ soundtype ] = temparray;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x405c
// Size: 0xdc
function getvalidlocation( speaker )
{
    mylocations = get_all_my_locations();
    mylocations = array_randomize( mylocations );
    
    if ( mylocations.size )
    {
        foreach ( location in mylocations )
        {
            if ( !location_called_out_ever( location ) && speaker cancalloutlocation( location ) )
            {
                return location;
            }
        }
        
        foreach ( location in mylocations )
        {
            if ( !location_called_out_recently( location ) && speaker cancalloutlocation( location ) )
            {
                return location;
            }
        }
    }
    
    return undefined;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x4141
// Size: 0x8b
function get_all_my_locations()
{
    alllocations = anim.bcs_locations;
    touchinglocations = self getistouchingentities( alllocations );
    mylocations = [];
    
    foreach ( location in touchinglocations )
    {
        if ( isdefined( location.locationaliases ) )
        {
            mylocations[ mylocations.size ] = location;
        }
    }
    
    return mylocations;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x41d5
// Size: 0x33, Type: bool
function location_called_out_ever( location )
{
    lastcallouttime = location_get_last_callout_time( location.locationaliases[ 0 ] );
    
    if ( !isdefined( lastcallouttime ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x4211
// Size: 0x4e, Type: bool
function location_called_out_recently( location )
{
    lastcallouttime = location_get_last_callout_time( location.locationaliases[ 0 ] );
    
    if ( !isdefined( lastcallouttime ) )
    {
        return false;
    }
    
    var_c5e4b26dbee9eb39 = lastcallouttime + 25000;
    
    if ( gettime() < var_c5e4b26dbee9eb39 )
    {
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x4268
// Size: 0x55
function location_add_last_callout_time( location, team )
{
    currenttime = gettime();
    anim.locationlastcallouttimes[ location ] = currenttime;
    
    if ( !isdefined( level.lastlocationcallouttime ) )
    {
        level.lastlocationcallouttime = [];
    }
    
    level.lastlocationcallouttime[ team ] = currenttime;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x42c5
// Size: 0x27
function location_get_last_callout_time( location )
{
    if ( isdefined( anim.locationlastcallouttimes[ location ] ) )
    {
        return anim.locationlastcallouttimes[ location ];
    }
    
    return undefined;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x42f5
// Size: 0x35
function get_last_callout_time( team )
{
    if ( isdefined( level.lastlocationcallouttime ) && isdefined( level.lastlocationcallouttime[ team ] ) )
    {
        return level.lastlocationcallouttime[ team ];
    }
    
    return undefined;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x4333
// Size: 0x81
function cancalloutlocation( location )
{
    foreach ( alias in location.locationaliases )
    {
        aliasnormal = getloccalloutalias( alias );
        valid = soundexists( aliasnormal );
        
        if ( valid )
        {
            return valid;
        }
    }
    
    return 0;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x43bd
// Size: 0x73, Type: bool
function canconcat( location )
{
    aliases = location.locationaliases;
    
    foreach ( alias in aliases )
    {
        if ( iscallouttypeconcat( alias, self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x4439
// Size: 0x9a
function getcannedresponse( speaker )
{
    var_d909d2311d8709d = undefined;
    aliases = self.locationaliases;
    
    foreach ( alias in aliases )
    {
        if ( iscallouttypeqa( alias, speaker ) && !isdefined( self.qafinished ) )
        {
            var_d909d2311d8709d = alias;
            break;
        }
        
        if ( iscallouttypereport( alias ) )
        {
            var_d909d2311d8709d = alias;
        }
    }
    
    return var_d909d2311d8709d;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x44dc
// Size: 0x16
function iscallouttypereport( alias )
{
    return issubstr( alias, "_report" );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x44fb
// Size: 0x3a, Type: bool
function iscallouttypeconcat( alias, speaker )
{
    var_3f4cc9de41415260 = speaker getloccalloutalias( "concat_loc_" + alias );
    
    if ( soundexists( var_3f4cc9de41415260 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x453e
// Size: 0x50, Type: bool
function iscallouttypeqa( alias, speaker )
{
    if ( issubstr( alias, "_qa" ) && soundexists( alias ) )
    {
        return true;
    }
    
    var_3f4cc9de41415260 = speaker getqacalloutalias( alias, 0 );
    
    if ( soundexists( var_3f4cc9de41415260 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x4597
// Size: 0x45
function getloccalloutalias( locationname )
{
    alias = "dx_mpo_" + ter_op( self.team == "allies", "usop", "ruop" ) + "_loc_enemy_" + locationname;
    return alias;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x45e5
// Size: 0x32
function getqacalloutalias( basealias, lineindex )
{
    alias = getloccalloutalias( basealias );
    alias += "_qa" + lineindex;
    return alias;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x4620
// Size: 0x46, Type: bool
function battlechatter_canprint()
{
    /#
        if ( getdvar( @"debug_bcprint", "<dev string:xb7>" ) == self.team || getdvar( @"debug_bcprint", "<dev string:xb7>" ) == "<dev string:xbb>" )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x466f
// Size: 0x46, Type: bool
function battlechatter_canprintdump()
{
    /#
        if ( getdvar( @"hash_9627c73338f91622", "<dev string:xb7>" ) == self.team || getdvar( @"hash_9627c73338f91622", "<dev string:xb7>" ) == "<dev string:xbb>" )
        {
            return true;
        }
    #/
    
    return false;
}

/#

    // Namespace battlechatter_mp / scripts\mp\battlechatter_mp
    // Params 2
    // Checksum 0x0, Offset: 0x46be
    // Size: 0xb1, Type: dev
    function battlechatter_print( alias, color )
    {
        if ( !battlechatter_canprint() )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = "<dev string:xc2>";
        }
        
        colorkey = "<dev string:xc2>";
        
        switch ( color )
        {
            case #"hash_97430f6c58e61cbc":
                colorkey = "<dev string:xd2>";
                break;
            case #"hash_2ac407c1cd5943a9":
                colorkey = "<dev string:xe2>";
                break;
            case #"hash_6686d129776d649a":
                colorkey = "<dev string:xf0>";
                break;
        }
        
        println( colorkey + self.origin + "<dev string:xf6>" + self.name + "<dev string:xfc>" + alias );
    }

    // Namespace battlechatter_mp / scripts\mp\battlechatter_mp
    // Params 1
    // Checksum 0x0, Offset: 0x4777
    // Size: 0x21e, Type: dev
    function battlechatter_printdump( alias )
    {
        if ( !battlechatter_canprintdump() )
        {
            return;
        }
        
        dumptype = getdvar( @"hash_3cb0b3f110a54cf2", "<dev string:x23>" );
        
        if ( dumptype != "<dev string:x23>" && dumptype != "<dev string:x104>" )
        {
            return;
        }
        
        var_47f4bea7f4c50ad9 = -1;
        
        if ( isdefined( level.var_529a83d403b4416 ) )
        {
            var_47f4bea7f4c50ad9 = ( gettime() - level.var_529a83d403b4416 ) / 1000;
        }
        
        level.var_529a83d403b4416 = gettime();
        
        if ( dumptype == "<dev string:x23>" )
        {
            if ( !flag_exist( "<dev string:x10b>" ) )
            {
                flag_init( "<dev string:x10b>" );
            }
            
            if ( !isdefined( level.var_b363a2868472ded1 ) )
            {
                filepath = "<dev string:x126>" + level.script + "<dev string:x14a>";
                level.var_b363a2868472ded1 = openfile( filepath, "<dev string:x152>" );
            }
            
            aliastype = getaliastypefromsoundalias( alias );
            suffix = getintensitysuffix( self );
            factionprefix = getteamvoiceinfix( self.team ) + "<dev string:x15b>";
            factionprefix = getsubstr( factionprefix, 0, factionprefix.size - 1 );
            dumpstring = level.script + "<dev string:x161>" + factionprefix + "<dev string:x161>" + self.operatorcustomization.voice + "<dev string:x161>" + aliastype;
            battlechatter_printdumpline( level.var_b363a2868472ded1, dumpstring, "<dev string:x10b>" );
            return;
        }
        
        if ( dumptype == "<dev string:x104>" )
        {
            if ( !flag_exist( "<dev string:x166>" ) )
            {
                flag_init( "<dev string:x166>" );
            }
            
            if ( !isdefined( level.var_97ef0a827c8a39d1 ) )
            {
                filepath = "<dev string:x126>" + level.script + "<dev string:x181>";
                level.var_97ef0a827c8a39d1 = openfile( filepath, "<dev string:x152>" );
            }
            
            dumpstring = "<dev string:x189>" + var_47f4bea7f4c50ad9 + "<dev string:x18e>";
            dumpstring += alias;
            battlechatter_printdumpline( level.var_97ef0a827c8a39d1, dumpstring, "<dev string:x166>" );
        }
    }

    // Namespace battlechatter_mp / scripts\mp\battlechatter_mp
    // Params 2
    // Checksum 0x0, Offset: 0x499d
    // Size: 0x28, Type: dev
    function battlechatter_debugprint( alias, color )
    {
        battlechatter_print( alias, color );
        thread battlechatter_printdump( alias );
    }

    // Namespace battlechatter_mp / scripts\mp\battlechatter_mp
    // Params 1
    // Checksum 0x0, Offset: 0x49cd
    // Size: 0x49, Type: dev
    function getaliastypefromsoundalias( alias )
    {
        prefix = "<dev string:x199>" + self.operatorcustomization.voice;
        aliastype = getsubstr( alias, prefix.size, alias.size );
        return aliastype;
    }

    // Namespace battlechatter_mp / scripts\mp\battlechatter_mp
    // Params 3
    // Checksum 0x0, Offset: 0x4a1e
    // Size: 0x48, Type: dev
    function battlechatter_printdumpline( file, str, controlflag )
    {
        if ( flag( controlflag ) )
        {
            flag_wait( controlflag );
        }
        
        flag_set( controlflag );
        fprintln( file, str );
        flag_clear( controlflag );
    }

#/

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x4a6e
// Size: 0x9f, Type: bool
function friendly_nearby( max_dist )
{
    if ( !isdefined( max_dist ) )
    {
        max_dist = 262144;
    }
    
    players = getfriendlyplayers( self.team, 1 );
    
    foreach ( player in players )
    {
        if ( player != self && distancesquared( player.origin, self.origin ) <= max_dist )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x4b16
// Size: 0x5d7
function setupselfvo()
{
    level.selfvomap = [];
    level.selfvomap[ "plr_killfirm_c6" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_ftl" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_ghost" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_merc" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_stryker" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_warfighter" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_generic" ] = "kill_gen";
    level.selfvomap[ "plr_killfirm_amf" ] = "kill_amf";
    level.selfvomap[ "plr_killfirm_headshot" ] = "kill_headshot";
    level.selfvomap[ "plr_killfirm_grenade" ] = "kill_grenade";
    level.selfvomap[ "plr_killfirm_rival" ] = "kill_rival";
    level.selfvomap[ "plr_killfirm_semtex" ] = "kill_semtex";
    level.selfvomap[ "plr_killfirm_multi" ] = "kill_multi";
    level.selfvomap[ "plr_killfirm_twofer" ] = "kill_twofer";
    level.selfvomap[ "plr_killfirm_threefer" ] = "kill_threefer";
    level.selfvomap[ "plr_killfirm_killstreak" ] = "kill_ss";
    level.selfvomap[ "plr_killstreak_destroy" ] = "kill_other_ss";
    level.selfvomap[ "plr_killstreak_target" ] = "targeted_by_ss";
    level.selfvomap[ "plr_hit_back" ] = "dmg_back";
    level.selfvomap[ "plr_damaged_light" ] = "dmg_light";
    level.selfvomap[ "plr_damaged_heavy" ] = "dmg_heavy";
    level.selfvomap[ "plr_damaged_emp" ] = "dmg_emp";
    level.selfvomap[ "plr_healing" ] = "healing";
    level.selfvomap[ "plr_kd_high" ] = "kd_high";
    level.selfvomap[ "plr_firefight" ] = "firefight";
    level.selfvomap[ "plr_target_generic" ] = "enemy_sighted";
    level.selfvomap[ "plr_perk_super" ] = "super_activate";
    level.selfvomap[ "plr_perk_trophy" ] = "super_activate";
    level.selfvomap[ "plr_perk_turret" ] = "super_activate";
    level.selfvomap[ "plr_perk_amplify" ] = "super_activate";
    level.selfvomap[ "plr_perk_overdrive" ] = "super_activate";
    level.selfvomap[ "plr_perk_ftl" ] = "super_activate";
    level.selfvomap[ "plr_perk_pulse" ] = "super_activate";
    level.selfvomap[ "plr_perk_rewind" ] = "super_activate";
    level.selfvomap[ "plr_perk_super_kill" ] = "super_kill";
    level.selfvomap[ "plr_perk_trophy_block" ] = "super_kill";
    level.selfvomap[ "plr_perk_turret_kill" ] = "super_kill";
    level.selfvomap[ "plr_killfirm_shift" ] = "super_kill";
    level.selfvomap[ "plr_perk_railgun" ] = "super_kill";
    level.selfvomap[ "plr_perk_stealth" ] = "super_kill";
    level.selfvomap[ "plr_perk_armor" ] = "super_kill";
    level.selfvomap[ "plr_perk_charge" ] = "super_kill";
    level.selfvomap[ "plr_perk_dragon" ] = "super_kill";
    level.selfvomap[ "plr_perk_pound" ] = "super_kill";
    level.selfvomap[ "plr_perk_reaper" ] = "super_kill";
    level.selfvoinfo = [];
    setselfvoinfo( "kill_rig", 15, 0.3, 0.25 );
    setselfvoinfo( "kill_gen", 30, 0.1, 0.25 );
    setselfvoinfo( "kill_amf", 15, 0.5, 0.5 );
    setselfvoinfo( "kill_headshot", 15, 0.7, 0.25 );
    setselfvoinfo( "kill_grenade", 15, 0.5, 0.25 );
    setselfvoinfo( "kill_rival", 15, 0.7, 0.25 );
    setselfvoinfo( "kill_semtex", 15, 0.5, 0.25 );
    setselfvoinfo( "kill_multi", 20, 0.6, 0.25 );
    setselfvoinfo( "kill_twofer", 10, 0.7, 0.75 );
    setselfvoinfo( "kill_threefer", 10, 0.8, 0.75 );
    setselfvoinfo( "kill_ss", 10, 0.5, 0.2 );
    setselfvoinfo( "kill_other_ss", 10, 0.7, 0.75 );
    setselfvoinfo( "targeted_by_ss", 10, 0.4, 0.33 );
    setselfvoinfo( "dmg_back", 20, 0.5, 0.5 );
    setselfvoinfo( "dmg_light", 20, 0.4, 0.1 );
    setselfvoinfo( "dmg_heavy", 20, 0.5, 0.2 );
    setselfvoinfo( "healing", 10, 0.3, 0.1 );
    setselfvoinfo( "kd_high", 20, 0.7, 0.8 );
    setselfvoinfo( "enemy_sighted", 20, 0.2, 0.25 );
    setselfvoinfo( "firefight", 10, 0.4, 0.33 );
    setselfvoinfo( "super_activate", 10, 1, 1 );
    setselfvoinfo( "super_kill", 10, 0.9, 0.66 );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 4
// Checksum 0x0, Offset: 0x50f5
// Size: 0x5c
function setselfvoinfo( var_83fca5a43f291a90, timeout, priority, chance )
{
    level.selfvoinfo[ var_83fca5a43f291a90 ][ "timeout_pos" ] = timeout;
    level.selfvoinfo[ var_83fca5a43f291a90 ][ "priority" ] = priority;
    level.selfvoinfo[ var_83fca5a43f291a90 ][ "chance" ] = chance;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 4
// Checksum 0x0, Offset: 0x5159
// Size: 0x1f3
function saytoself( player, aliasname, fallbackname, delay )
{
    if ( true )
    {
        return;
    }
    
    if ( isagent( player ) || !isplayer( player ) )
    {
        return;
    }
    
    if ( istrue( player.bcdisabled ) )
    {
        return;
    }
    
    suffix = getintensitysuffix( player );
    fullname = "";
    
    if ( isdefined( player.operatorcustomization ) && isdefined( player.operatorcustomization.voice ) && isdefined( aliasname ) )
    {
        fullname = "dx_mpb_" + player.operatorcustomization.voice + "_" + aliasname;
    }
    
    if ( !isdefined( aliasname ) || !soundexists( fullname ) )
    {
        if ( !isdefined( fallbackname ) )
        {
            return;
        }
        
        aliasname = fallbackname;
        fullname = "dx_mpb_" + player.operatorcustomization.voice + "_" + aliasname;
        
        if ( !soundexists( fullname ) )
        {
            return;
        }
    }
    
    if ( !isdefined( player.selfvohistory ) )
    {
        player.selfvohistory = [];
        player.playingselfvo = 0;
        player.queuedvo = "none";
    }
    
    if ( !isdefined( level.selfvomap[ aliasname ] ) )
    {
        return;
    }
    
    if ( isdefined( player.selfvohistory[ level.selfvomap[ aliasname ] ] ) && player.selfvohistory[ level.selfvomap[ aliasname ] ] > 0 )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "selfVOBonusChance" ] ) )
    {
        player thread updateselfvobonuschance();
    }
    
    if ( randomfloat( 1 ) > level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "chance" ] + player.pers[ "selfVOBonusChance" ] )
    {
        return;
    }
    
    player thread trysetqueuedselfvo( aliasname, delay );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x5354
// Size: 0x7e
function updateselfvobonuschance()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.pers[ "selfVOBonusChance" ] = 0;
    
    if ( !runleanthreadmode() )
    {
        while ( true )
        {
            self.pers[ "selfVOBonusChance" ] = self.pers[ "selfVOBonusChance" ] + 0.1;
            wait 3;
        }
        
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        self.pers[ "selfVOBonusChance" ] = 0.25;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x53da
// Size: 0x177
function trysetqueuedselfvo( aliasname, delay )
{
    self endon( "death_or_disconnect" );
    
    if ( self.queuedvo == aliasname )
    {
        return;
    }
    
    if ( self.queuedvo == "none" || level.selfvoinfo[ level.selfvomap[ self.queuedvo ] ][ "priority" ] < level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "priority" ] || level.selfvoinfo[ level.selfvomap[ self.queuedvo ] ][ "priority" ] == level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "priority" ] && cointoss() )
    {
        self.queuedvo = aliasname;
    }
    else
    {
        return;
    }
    
    self notify( "addToSelfVOQueue" );
    self endon( "addToSelfVOQueue" );
    self.selfvodelaycomplete = 1;
    
    if ( isdefined( delay ) )
    {
        thread selfvodelay( delay );
    }
    
    waittime = getprioritywaittime( aliasname );
    initialtime = gettime();
    
    while ( self.playingselfvo || !self.selfvodelaycomplete || waittime > gettime() )
    {
        if ( gettime() > initialtime + 2000 )
        {
            self.queuedvo = "none";
            return;
        }
        
        wait 0.05;
    }
    
    waitframe();
    thread playselfvo( aliasname );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x5559
// Size: 0x55
function getprioritywaittime( aliasname )
{
    if ( !isdefined( self.lastselfvotime ) )
    {
        self.lastselfvotime = 0;
    }
    
    return self.lastselfvotime + 2000 + 10000 * ( 1 - level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "priority" ] );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x55b7
// Size: 0x30
function selfvodelay( delay )
{
    self endon( "death_or_disconnect" );
    self endon( "addToSelfVOQueue" );
    self.selfvodelaycomplete = 0;
    wait delay;
    self.selfvodelaycomplete = 1;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x55ef
// Size: 0xac
function playselfvo( aliasname )
{
    self endon( "death_or_disconnect" );
    suffix = getintensitysuffix( self );
    fullname = "dx_mpb_" + self.operatorcustomization.voice + "_" + aliasname;
    self.pers[ "selfVOBonusChance" ] = 0;
    self.queuedvo = "none";
    duration = lookupsoundlength( fullname ) / 1000;
    self.lastselfvotime = gettime();
    thread playingselfvotracking( duration );
    thread updateselfvohistory( aliasname );
    self playsoundtoplayer( fullname, self );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x56a3
// Size: 0x29
function playingselfvotracking( duration )
{
    self endon( "disconnect" );
    self.playingselfvo = 1;
    wait duration;
    self.playingselfvo = 0;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x56d4
// Size: 0x60
function updateselfvohistory( aliasname )
{
    self endon( "disconnect" );
    self.selfvohistory[ level.selfvomap[ aliasname ] ] = gettime();
    wait level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "timeout_pos" ];
    self.selfvohistory[ level.selfvomap[ aliasname ] ] = 0;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x573c
// Size: 0xa1
function getintensitysuffix( player )
{
    /#
        bc_intensity = getdvar( @"hash_68874851dce750fe", "<dev string:x1a4>" );
        
        if ( bc_intensity != "<dev string:x1a4>" )
        {
            if ( bc_intensity == "<dev string:x1ac>" )
            {
                return "<dev string:x1ac>";
            }
            
            if ( bc_intensity == "<dev string:x1b3>" )
            {
                return "<dev string:x1b3>";
            }
        }
    #/
    
    roundpercent = gettimepassedpercentage();
    intensity = player getbcintensity();
    
    if ( intensity > 5000 || roundpercent >= 80 || inovertime() )
    {
        return "high";
    }
    
    return "mid";
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 3
// Checksum 0x0, Offset: 0x57e5
// Size: 0x94
function addtointensitybuffer( type, intensity, ignoreaftertime )
{
    if ( !isdefined( self.battlechatterintensitybuffer ) )
    {
        self.battlechatterintensitybuffer = [];
    }
    
    event = spawnstruct();
    event.time = gettime();
    event.value = intensity;
    event.ignoreaftertime = event.time + ignoreaftertime * 1000;
    self.battlechatterintensitybuffer[ self.battlechatterintensitybuffer.size ] = event;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x5881
// Size: 0xbc
function getbcintensity()
{
    if ( !isdefined( self.battlechatterintensitybuffer ) )
    {
        return 0;
    }
    
    validevents = [];
    intensity = 0;
    currenttime = gettime();
    
    foreach ( event in self.battlechatterintensitybuffer )
    {
        if ( currenttime < event.ignoreaftertime )
        {
            intensity += event.value;
            validevents[ validevents.size ] = event;
        }
    }
    
    self.battlechatterintensitybuffer = validevents;
    self.intensity = intensity;
    return intensity;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x5946
// Size: 0x2a6
function testweaponfiredtolisteners( attacker, objweapon )
{
    var_378d3b538b839d2c = utility::playersnear( attacker.origin, 4000 );
    
    foreach ( player in var_378d3b538b839d2c )
    {
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        distsq = max( distance_2d_squared( attacker.origin, player.origin ), 1 );
        
        if ( iscacprimaryweapon( objweapon.basename ) || iscacsecondaryweapon( objweapon.basename ) )
        {
            intensity = 0;
            weapongroup = scripts\mp\utility\weapon::getweapongroup( objweapon.basename );
            
            switch ( weapongroup )
            {
                case #"hash_ab10f9c080fe4faf":
                    intensity = 50;
                    break;
                case #"hash_8af0086b038622b5":
                    intensity = 60;
                    break;
                case #"hash_dd616da0b395a0b0":
                    intensity = 60;
                    break;
                case #"hash_c095d67337b1f5a1":
                    intensity = 90;
                    break;
                case #"hash_47368bc0d2ef1565":
                    intensity = 70;
                    break;
                case #"hash_bef5ec0b3e197ae":
                    intensity = 80;
                    break;
                case #"hash_16cf6289ab06bd30":
                    intensity = 80;
                    break;
                case #"hash_9d18adab1b65a661":
                    intensity = 70;
                    break;
                case #"hash_34340d457a63e7f1":
                    intensity = 40;
                    break;
                case #"hash_6f796b5c69cec63":
                    intensity = 50;
                    break;
                default:
                    break;
            }
            
            if ( intensity == 0 )
            {
                continue;
            }
            
            if ( weaponhasattachment( objweapon, "silencer" ) )
            {
                intensity *= 0.25;
            }
            
            if ( distsq < 10000 )
            {
                distscalar = 5;
            }
            else if ( distsq < 250000 )
            {
                distscalar = 3;
            }
            else if ( distsq < 1000000 )
            {
                distscalar = 2;
            }
            else if ( distsq < 4000000 )
            {
                distscalar = 0.5;
            }
            else if ( distsq < 9000000 )
            {
                distscalar = 0.25;
            }
            else
            {
                distscalar = 0.1;
            }
            
            distfrac = 1 - distsq / 16000000;
            distscalar *= distfrac;
            intensity *= distscalar;
            player addtointensitybuffer( "weaponFired", int( intensity ), 3 );
        }
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 3
// Checksum 0x0, Offset: 0x5bf4
// Size: 0xc2
function adddamagetaken( attacker, objweapon, idamage )
{
    if ( isprophuntgametype() )
    {
        return;
    }
    
    issniperdamage = 0;
    
    if ( isdefined( objweapon ) && isdefined( attacker ) )
    {
        weapongroup = getweapongroup( objweapon );
        
        if ( weapongroup == "weapon_sniper" || weapongroup == "weapon_dmr" )
        {
            if ( distance2d( self.origin, attacker.origin ) > 2250000 )
            {
                issniperdamage = 1;
            }
        }
    }
    
    if ( issniperdamage )
    {
        level thread trysaylocalsound( self, #"bc_combat_inform_taking_fire_long", undefined, 0.75 );
        return;
    }
    
    level thread trysaylocalsound( self, #"bc_combat_inform_taking_fire", undefined, 0.75 );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x5cbe
// Size: 0x1c4
function onsixfriendlytracking()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( lpcfeaturegated() )
    {
        return;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    wait 5;
    var_e1aaad75f4b04d37 = 0;
    
    if ( isdefined( level.squaddata ) && istrue( level.gamemodebundle.var_2e55d316ba8b231 ) )
    {
        var_e1aaad75f4b04d37 = 1;
    }
    
    var_6b386cb1a44b4663 = isdefined( level.gamemodebundle.var_98986a08f69f4a0b ) ? level.gamemodebundle.var_98986a08f69f4a0b : 0.15;
    
    while ( true )
    {
        if ( isreallyalive( self ) && !saidtoorecently( #"bc_status_inform_on_your_six" ) )
        {
            var_d1a3029ed3bcffd8 = [];
            
            if ( var_e1aaad75f4b04d37 )
            {
                if ( isdefined( self.sessionsquadid ) && isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
                {
                    var_d1a3029ed3bcffd8 = level.squaddata[ self.team ][ self.sessionsquadid ].players;
                }
            }
            else
            {
                var_d1a3029ed3bcffd8 = getfriendlyplayers( self.team, 1 );
            }
            
            foreach ( listener in var_d1a3029ed3bcffd8 )
            {
                if ( listener == self )
                {
                    continue;
                }
                
                if ( !isreallyalive( listener ) )
                {
                    continue;
                }
                
                if ( validatelistener( self, listener ) )
                {
                    level thread trysaylocalsound( self, #"bc_status_inform_on_your_six" );
                    break;
                }
            }
        }
        else
        {
            wait randomfloatrange( 1, 4 );
        }
        
        wait var_6b386cb1a44b4663;
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x5e8a
// Size: 0xf5, Type: bool
function validatelistener( speaker, listener )
{
    listenerorg = listener geteye();
    speakerorg = speaker geteye();
    distsq = distancesquared( listenerorg, speakerorg );
    
    if ( distsq > 90000 )
    {
        return false;
    }
    
    listenerdir = anglestoforward( listener getplayerangles() );
    tolistener = vectornormalize( listenerorg - speakerorg );
    dot = vectordot( listenerdir, tolistener );
    test_dot = 0.05;
    
    if ( dot > test_dot )
    {
        trace = scripts\engine\trace::ray_trace( speakerorg, listenerorg, speaker, level.var_c49bb6749e2ce50c );
        
        if ( isdefined( trace[ "entity" ] ) && isplayer( trace[ "entity" ] ) || trace[ "fraction" ] > 0.8 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x5f88
// Size: 0xd
function getlistenerdirection()
{
    return anglestoforward( self getplayerangles() );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 10
// Checksum 0x0, Offset: 0x5f9e
// Size: 0x53
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x5ff9
// Size: 0xe5
function checkcasualty()
{
    players = getfriendlyplayers( self.team, 1 );
    
    foreach ( player in players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, player.origin ) <= 262144 )
        {
            playerfacingdir = anglestoforward( player getplayerangles() );
            
            if ( length( player.origin - self.origin ) > 0 )
            {
                if ( math::anglebetweenvectors( playerfacingdir, player.origin - self.origin ) < 80 )
                {
                    break;
                }
            }
        }
    }
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 0
// Checksum 0x0, Offset: 0x60e6
// Size: 0x2
function getsoundlength()
{
    
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 6
// Checksum 0x0, Offset: 0x60f0
// Size: 0x344
function trysaylocalsound( player, soundtype, targetent, delay, location, triggerent )
{
    if ( !istrue( level.battlechatterenabled ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( issimulationplayer( player ) )
    {
        return;
    }
    
    if ( istrue( player.bcdisabled ) && !( soundtype == "flavor_execution" || soundtype == #"ping_social_thanks" ) )
    {
        return;
    }
    
    if ( !isreallyalive( player ) )
    {
        return;
    }
    
    if ( player.team == "spectator" )
    {
        return;
    }
    
    if ( player.team == "codcaster" )
    {
        return;
    }
    
    if ( !isdefined( player.bcinfolastsaytimes ) )
    {
        return;
    }
    
    if ( istrue( player.isspeakingbc ) )
    {
        return;
    }
    
    if ( player isusingremote() )
    {
        return;
    }
    
    if ( player _hasperk( "specialty_no_battle_chatter" ) )
    {
        return;
    }
    
    if ( isdefined( player.swim ) && istrue( player.swim.underwater ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() && 0 != getdvarint( @"hash_25ad2925d6075c8f", 0 ) && !isdefined( player.bcinfolastsaytimes ) )
    {
        return;
    }
    
    /#
        if ( !isdefined( level.bcfrequency ) )
        {
            level.bcfrequency = [];
        }
        
        if ( !isdefined( level.bcfrequency[ soundtype ] ) )
        {
            level.bcfrequency[ soundtype ] = 1;
        }
        else
        {
            level.bcfrequency[ soundtype ]++;
        }
    #/
    
    if ( function_b96f48dbdcd7110( soundtype ) && !player friendly_nearby( level.var_98014172ce4b4e67 ) && !istrue( level.br_practice_match ) )
    {
        /#
            player battlechatter_debugprint( "<dev string:x1bb>" + getxhashsourcename( soundtype ), "<dev string:xd8>" );
        #/
        
        return;
    }
    
    play_chance = randomfloat( 1 );
    sound_chance = function_c02b6ba215c2dca8( soundtype );
    
    if ( play_chance > sound_chance )
    {
        /#
            player battlechatter_debugprint( "<dev string:x1d5>" + getxhashsourcename( soundtype ), "<dev string:xd8>" );
        #/
        
        return;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    waittime = player getbcwaittime( soundtype, delay );
    
    if ( waittime > level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        /#
            player battlechatter_debugprint( "<dev string:x1ed>" + getxhashsourcename( soundtype ), "<dev string:xd8>" );
        #/
        
        return;
    }
    
    if ( gettime() > player.var_cf34556d563b92ae + level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        player.bcinfoqueued = "none";
        player.var_cf34556d563b92ae = 0;
    }
    
    if ( comparesoundpriorities( soundtype, player.bcinfoqueued ) )
    {
        player.bcinfoqueued = soundtype;
        player.var_cf34556d563b92ae = gettime();
    }
    else
    {
        /#
            player battlechatter_debugprint( "<dev string:x204>" + getxhashsourcename( soundtype ), "<dev string:xd8>" );
        #/
        
        return;
    }
    
    level notify( "kill_queued_bc_sound_" + player.name );
    return player saylocalsound( waittime, soundtype, targetent, delay, location, triggerent );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 6
// Checksum 0x0, Offset: 0x643d
// Size: 0x298
function saylocalsound( waittime, soundtype, targetent, delay, location, triggerent )
{
    level endon( "kill_queued_bc_sound_" + self.name );
    self endon( "death_or_disconnect" );
    wait waittime / 1000;
    
    if ( saidtoorecently( soundtype ) )
    {
        /#
            battlechatter_debugprint( "<dev string:x21f>" + getxhashsourcename( soundtype ), "<dev string:xd8>" );
        #/
        
        return;
    }
    
    while ( waittime <= level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        speakerinfo = getspeakerinfo( self, function_336e1f89ae06dfd4( soundtype ) );
        
        if ( isdefined( speakerinfo[ "higher" ] ) )
        {
            time = gettime();
            speakerinfo[ "higher" ][ "player" ] waittill_any_3( getxhashhexname( speakerinfo[ "higher" ][ "sound_alias" ] ), "death", "disconnect" );
            waitframe();
            waittime += gettime() - time;
            continue;
        }
        
        info = speakerinfo[ "lower" ];
        
        for ( i = 0; i < info.size ; i++ )
        {
            if ( isdefined( info[ i ][ "player" ] ) )
            {
                info[ i ][ "player" ] notify( getxhashhexname( info[ i ][ "sound_alias" ] ) + "_interrupt" );
                
                if ( soundexists( info[ i ][ "sound_alias" ] ) )
                {
                    info[ i ][ "player" ] stoplocalsound( info[ i ][ "sound_alias" ] );
                }
            }
        }
        
        break;
    }
    
    if ( waittime > level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        /#
            battlechatter_debugprint( "<dev string:x234>" + getxhashsourcename( soundtype ), "<dev string:xd8>" );
        #/
        
        self.bcinfoqueued = "none";
        return;
    }
    
    entid = undefined;
    
    if ( !isdefined( self.var_797974906694b0b6 ) )
    {
        self.var_797974906694b0b6 = [];
    }
    
    if ( isdefined( triggerent ) )
    {
        entid = triggerent getentitynumber();
    }
    
    if ( saidtoorecently( soundtype ) )
    {
        /#
            battlechatter_debugprint( "<dev string:x21f>" + getxhashsourcename( soundtype ), "<dev string:xd8>" );
        #/
        
        return;
    }
    else if ( isdefined( entid ) && isdefined( self.var_797974906694b0b6[ entid ] ) )
    {
        return;
    }
    else if ( isdefined( entid ) )
    {
        self.var_797974906694b0b6[ entid ] = gettime();
        thread function_eaf6dc9588364f83( entid );
    }
    
    self.bcinfoqueued = "none";
    self.bcinfolastsaytimes[ soundtype ] = gettime();
    return dosound( soundtype, targetent, location );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x66dd
// Size: 0x34
function function_eaf6dc9588364f83( entid )
{
    self endon( "disconnect" );
    
    if ( !isdefined( entid ) )
    {
        return;
    }
    
    wait 5;
    self.var_797974906694b0b6 = array_remove( self.var_797974906694b0b6, entid );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x6719
// Size: 0x381
function getbcwaittime( soundtype, delay )
{
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    timeoutteamtime = 0;
    positionrelevant = 0;
    
    if ( isdefined( level.bcinfo[ "soundEventHistory" ][ soundtype ] ) )
    {
        if ( soundtype == #"bc_combat_inform_contact_generic" || soundtype == #"bc_combat_inform_contact" || soundtype == #"bc_combat_inform_contact_multiple" )
        {
            var_b53830ff2a079e80 = [];
            var_b53830ff2a079e80[ var_b53830ff2a079e80.size ] = #"bc_combat_inform_contact_generic";
            var_b53830ff2a079e80[ var_b53830ff2a079e80.size ] = #"bc_combat_inform_contact";
            var_b53830ff2a079e80[ var_b53830ff2a079e80.size ] = #"bc_combat_inform_contact_multiple";
            
            foreach ( entry in var_b53830ff2a079e80 )
            {
                if ( !isdefined( level.bcinfo[ "soundEventHistory" ][ entry ] ) )
                {
                    continue;
                }
                
                foreach ( event in level.bcinfo[ "soundEventHistory" ][ entry ] )
                {
                    if ( distancesquared( event.origin, self.origin ) < 4000000 )
                    {
                        var_c4ac6795e14927d0 = event.time + function_ffd3470f08fcf7a7( entry );
                        
                        if ( var_c4ac6795e14927d0 > timeoutteamtime )
                        {
                            timeoutteamtime = var_c4ac6795e14927d0;
                            positionrelevant = 1;
                        }
                    }
                }
                
                if ( positionrelevant )
                {
                    break;
                }
            }
        }
        else if ( soundtype == #"bc_status_inform_on_your_six" )
        {
            foreach ( event in level.bcinfo[ "soundEventHistory" ][ soundtype ] )
            {
                if ( distancesquared( event.origin, self.origin ) < 2250000 )
                {
                    var_c4ac6795e14927d0 = event.time + function_ffd3470f08fcf7a7( soundtype );
                    
                    if ( var_c4ac6795e14927d0 > timeoutteamtime )
                    {
                        timeoutteamtime = var_c4ac6795e14927d0;
                        positionrelevant = 1;
                    }
                }
            }
        }
        else
        {
            foreach ( event in level.bcinfo[ "soundEventHistory" ][ soundtype ] )
            {
                if ( distancesquared( event.origin, self.origin ) < 1048576 )
                {
                    var_c4ac6795e14927d0 = event.time + function_ffd3470f08fcf7a7( soundtype );
                    
                    if ( var_c4ac6795e14927d0 > timeoutteamtime )
                    {
                        timeoutteamtime = var_c4ac6795e14927d0;
                        positionrelevant = 1;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( self.bcinfolastsaytimes[ soundtype ] ) )
    {
        self.bcinfolastsaytimes[ soundtype ] = 0;
    }
    
    var_dcbb8c92238f7098 = self.bcinfolastsaytimes[ soundtype ] + function_a71193e9db14c926( soundtype );
    timeoutdelaytime = gettime() + delay * 1000;
    
    if ( positionrelevant )
    {
        timeouttime = max( var_dcbb8c92238f7098, max( timeoutteamtime, timeoutdelaytime ) );
    }
    else
    {
        timeouttime = max( var_dcbb8c92238f7098, timeoutdelaytime );
    }
    
    waittime = timeouttime - gettime();
    return waittime;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 3
// Checksum 0x0, Offset: 0x6aa3
// Size: 0x14c
function getspeakerinfo( player, priority, range )
{
    if ( !isdefined( range ) )
    {
        range = 1000;
    }
    
    distsq = range * range;
    var_139b1d1bf64d28f0 = [];
    var_139b1d1bf64d28f0[ "lower" ] = [];
    
    if ( isdefined( player ) && isdefined( player.team ) && player.team != "spectator" )
    {
        for ( index = 0; index < level.speakers[ player.team ].size ; index++ )
        {
            speakerinfo = level.speakers[ player.team ][ index ];
            teammate = speakerinfo[ "player" ];
            speakerpriority = speakerinfo[ "priority" ];
            
            if ( !isdefined( teammate ) )
            {
                continue;
            }
            
            if ( distancesquared( teammate.origin, player.origin ) < distsq )
            {
                if ( isdefined( speakerpriority ) )
                {
                    if ( speakerpriority > priority || speakerpriority == priority && cointoss() )
                    {
                        var_139b1d1bf64d28f0[ "higher" ] = speakerinfo;
                        return var_139b1d1bf64d28f0;
                    }
                    
                    var_139b1d1bf64d28f0[ "lower" ][ var_139b1d1bf64d28f0[ "lower" ].size ] = speakerinfo;
                }
            }
        }
    }
    
    return var_139b1d1bf64d28f0;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x6bf8
// Size: 0x76
function comparesoundpriorities( s1, s2 )
{
    none = s2 == "none";
    
    if ( none )
    {
        return none;
    }
    
    if ( s1 == s2 )
    {
        return 0;
    }
    
    higherpriority = function_336e1f89ae06dfd4( s2 ) < function_336e1f89ae06dfd4( s1 );
    var_35470d4859f3e586 = function_336e1f89ae06dfd4( s2 ) == function_336e1f89ae06dfd4( s1 ) && cointoss();
    return higherpriority || var_35470d4859f3e586;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 2
// Checksum 0x0, Offset: 0x6c77
// Size: 0x6d
function saidtoorecently( soundtype, delay )
{
    if ( !isdefined( self ) || !isgameplayteam( self.team ) )
    {
        return 1;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    waittime = getbcwaittime( soundtype, delay );
    
    if ( waittime > level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x6cec
// Size: 0x36
function function_336e1f89ae06dfd4( soundtype )
{
    return ter_op( isdefined( level.bcinfo[ "priority" ][ soundtype ] ), level.bcinfo[ "priority" ][ soundtype ], 1 );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x6d2b
// Size: 0x39
function function_c02b6ba215c2dca8( soundtype )
{
    return ter_op( isdefined( level.bcinfo[ "chance" ][ soundtype ] ), level.bcinfo[ "chance" ][ soundtype ], 0 );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x6d6d
// Size: 0x39
function function_ffd3470f08fcf7a7( soundtype )
{
    return ter_op( isdefined( level.bcinfo[ "timeout_pos" ][ soundtype ] ), level.bcinfo[ "timeout_pos" ][ soundtype ], 1000 );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x6daf
// Size: 0x39
function function_a71193e9db14c926( soundtype )
{
    return ter_op( isdefined( level.bcinfo[ "timeout_player" ][ soundtype ] ), level.bcinfo[ "timeout_player" ][ soundtype ], 1000 );
}

// Namespace battlechatter_mp / scripts\mp\battlechatter_mp
// Params 1
// Checksum 0x0, Offset: 0x6df1
// Size: 0x35
function function_b96f48dbdcd7110( soundtype )
{
    return ter_op( isdefined( level.bcinfo[ "req_friendly" ][ soundtype ] ), level.bcinfo[ "req_friendly" ][ soundtype ], 0 );
}

