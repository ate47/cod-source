#using script_15eddb0fac236a22;
#using script_45f403e1732217d3;
#using script_4948cdf739393d2d;
#using script_548072087c9fd504;
#using script_728ffcee8cbf30ee;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\dragonsbreath;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\equipment;
#using scripts\mp\equipment\deployed_decoy;
#using scripts\mp\equipment\snapshot_grenade;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_challenges;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\trickrtreat;
#using scripts\mp\gametypes\war;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\persistence;
#using scripts\mp\poi;
#using scripts\mp\potg;
#using scripts\mp\potg_events;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\player_frame_update_aggregator;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace events;

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0x2d70
// Size: 0x5c8
function events_init()
{
    bundle = undefined;
    registersharedfunc( "score", "getHighestScoringPlayer", &scripts\mp\gamescore::gethighestscoringplayer );
    
    if ( isdefined( level.gametypebundle ) )
    {
        bundlename = level.gametypebundle.scoreeventlist;
        
        if ( isstring( bundlename ) )
        {
            level.scoreeventlist = bundlename;
            bundle = getscriptbundle( hashcat( %"scoreeventlist:", bundlename ) );
        }
    }
    
    if ( !isdefined( bundle ) )
    {
        bundle = function_15fd33eb83ce9723();
    }
    
    level.var_27dcaf9644646944 = #"display_xp";
    
    if ( isdefined( bundle ) )
    {
        if ( istrue( bundle.var_78b5ec940aab35e4 ) )
        {
            level.var_27dcaf9644646944 = #"display_score";
        }
        
        level.var_488d247ae51e8eeb = istrue( bundle.var_488d247ae51e8eeb );
        level.var_393c8c75a6a52875 = istrue( bundle.var_393c8c75a6a52875 );
        function_22bff45fcf920417( bundle.var_a5f886642fea5345 );
        function_18a7c22094077fe9( bundle.var_719a7b2ee809800a );
        
        foreach ( entry in bundle.var_954e1637c0fe6111 )
        {
            function_e1fb4dfa1db65ce2( entry );
        }
        
        foreach ( entry in bundle.var_a45b64683777600d )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_2820c891e54b9ac0 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_24a4cf263452716 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_64f120e8e17d6a6 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_60c4cdc67f3daa88 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_c865e015a35e7213 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_df30271d78b67bc4 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_4d8678eb66db4dee )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_dc9d1000672be9fc )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_22d3e4c7f898ce16 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_8cb7d576afcbade5 )
        {
            function_51e853369bc3f0bf( entry );
        }
        
        foreach ( entry in bundle.var_bc38d83854c4c304 )
        {
            function_51e853369bc3f0bf( entry );
        }
    }
    
    registersharedfunc( "event", "predatorMissileImpact", &predatormissileimpact );
    registersharedfunc( "event", "largeVehicleExplosion", &largevehicleexplosion );
    registersharedfunc( "event", "vehicleKilled", &vehiclekilled );
    registersharedfunc( "event", "missileFired", &missilefired );
    level._effect[ "money" ] = loadfx( "vfx/props/cash_player_drop" );
    level.numkills = 0;
    level thread onplayerconnect();
    level thread monitorhealed();
    
    if ( !runleanthreadmode() )
    {
        scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawn );
        scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &monitoradstime );
        scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &scripts\mp\events::events_monitorslideupdate );
    }
    
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &updatestancetracking );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0x3340
// Size: 0x18d
function function_15fd33eb83ce9723()
{
    game_type = getgametype();
    
    if ( !isdefined( game_type ) )
    {
        game_type = scripts\cp_mp\utility\game_utility::getgametype();
    }
    
    if ( game_type == "brtdm_mgl" )
    {
        game_type = "brtdm";
    }
    
    scriptbundlename = "score_event_list_" + game_type;
    
    if ( isanymlgmatch() )
    {
        if ( level.leagueplaymatch )
        {
            scriptbundlename = "score_event_list_leagueplay_" + game_type;
        }
        else
        {
            scriptbundlename = "score_event_list_cdl_" + game_type;
        }
    }
    
    if ( getdvarint( @"t10" ) > 0 )
    {
        scriptbundlename += "_t10_mp";
    }
    else if ( getdvarint( @"hash_3a8bbf8d767fb421" ) > 0 )
    {
        scriptbundlename += "_iw9_mp_dmz_biolab";
    }
    else if ( getdvarint( @"hash_aae99dd3b5ad1a77" ) > 0 )
    {
        scriptbundlename += "_iw9_mp_dmz_biobunker";
    }
    else if ( scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "resurgence" )
    {
        scriptbundlename += "_iw9_mp_resurgence";
    }
    else if ( scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zonecontrol" )
    {
        scriptbundlename += "_iw9_mp_zonecontrol";
    }
    else if ( scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "champion" )
    {
        scriptbundlename = "score_event_list_br_mgl_mp_champion";
    }
    else if ( game_type == "conflict" )
    {
        scriptbundlename = "score_event_list_conflict_mgl_mp";
    }
    else if ( game_type == "limbo" )
    {
        scriptbundlename = "score_event_list_resurgence_jup_mp";
    }
    else
    {
        scriptbundlename += "_iw9_mp";
        
        /#
            utility::scriptbundlewarning( "<dev string:x1c>", scriptbundlename );
        #/
    }
    
    level.scoreeventlist = scriptbundlename;
    bundle = getscriptbundle( "scoreeventlist:" + scriptbundlename );
    assert( isdefined( bundle ), "<dev string:x2e>" + game_type );
    return bundle;
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0x34d6
// Size: 0x7f
function function_e1fb4dfa1db65ce2( entry )
{
    if ( !isdefined( entry ) )
    {
        return;
    }
    
    ref = entry.ref;
    
    if ( !isdefined( ref ) || ref == "" )
    {
        return;
    }
    
    scripts\mp\rank::registerscoreinfomultiplier( ref, entry.multiplier );
    group = default_to( entry.group, "unassigned" );
    scripts\mp\rank::registerscoreinfo( ref, #"group", group );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0x355d
// Size: 0x2b8
function function_51e853369bc3f0bf( entry )
{
    if ( !isdefined( entry ) )
    {
        return;
    }
    
    ref = entry.ref;
    
    if ( !isdefined( ref ) || ref == "" )
    {
        return;
    }
    
    score = default_to( entry.score, 0 );
    xp = default_to( entry.xp, 0 );
    var_e705ea298dacd4e2 = default_to( entry.var_e705ea298dacd4e2, 0 );
    potgscore = default_to( entry.potgscore, 0 );
    
    if ( istrue( entry.isaward ) )
    {
        scripts\mp\rank::registerscoreinfo( ref, #"isaward", 1 );
    }
    
    if ( !istrue( entry.forceinit ) )
    {
        if ( score == 0 && xp == 0 && potgscore == 0 )
        {
            return;
        }
        
        assert( score >= 0 );
        assert( xp >= 0 );
    }
    
    scripts\mp\rank::registerscoreinfo( ref, #"value", score );
    scripts\mp\rank::registerscoreinfo( ref, #"xp", xp );
    scripts\mp\rank::registerscoreinfo( ref, #"hash_afa3cfee9cf8b4c6", var_e705ea298dacd4e2 );
    scripts\mp\rank::registerscoreinfo( ref, #"potgscore", potgscore );
    scripts\mp\supers::function_4d75a970580a253c( ref, entry.superpoints );
    var_eef8a3f0dcf96328 = isxhashasset( entry.splashbundle );
    
    if ( !var_eef8a3f0dcf96328 )
    {
        function_3931df10145eac22( ref, scripts\mp\hud_message::getsplashtablename() );
    }
    
    group = default_to( entry.group, "unassigned" );
    scripts\mp\rank::registerscoreinfo( ref, #"group", group );
    
    if ( !istrue( entry.nobonus ) )
    {
        scripts\mp\rank::registerscoreinfo( ref, #"allowbonus", 1 );
    }
    
    if ( istrue( entry.var_5b5911eca3f2426f ) )
    {
        scripts\mp\rank::registerscoreinfo( ref, #"hash_582866801a05178b", 1 );
    }
    
    if ( level.var_393c8c75a6a52875 )
    {
        if ( istrue( entry.var_20e41be47c76d7ed ) )
        {
            scripts\mp\rank::registerscoreinfo( ref, #"hash_e98734bda1c5c091", 1 );
        }
    }
    
    if ( var_eef8a3f0dcf96328 )
    {
        var_8cde9a095cf42d8f = function_2336488258354fbc( #"scriptbundle_splash", entry.splashbundle );
        assertex( isdefined( var_8cde9a095cf42d8f ), "<dev string:x5d>" + getxhashsourcename( entry.splashbundle ) );
        
        if ( isdefined( var_8cde9a095cf42d8f ) )
        {
            scripts\mp\rank::registerscoreinfo( ref, #"hash_9ef9bbcd1edc198b", var_8cde9a095cf42d8f );
            function_cbf4b04a2e7f02ae( ref, entry.splashbundle );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0x381d
// Size: 0xd0
function function_3931df10145eac22( ref, splashtablename )
{
    var_2c6153492a7defb2 = tablelookuprownum( splashtablename, 0, ref );
    
    if ( var_2c6153492a7defb2 < 0 )
    {
        return;
    }
    
    scripts\mp\rank::registerscoreinfo( ref, #"hash_edd89bb2cc2d506", var_2c6153492a7defb2 );
    text = tablelookup( splashtablename, 0, ref, 2 );
    
    if ( isstring( text ) && text != "" )
    {
        scripts\mp\rank::registerscoreinfo( ref, #"hastext", 1 );
    }
    
    priority = int( tablelookup( splashtablename, 0, ref, 13 ) );
    scripts\mp\rank::registerscoreinfo( ref, #"priority", priority );
    var_43297beee133b22 = int( tablelookup( splashtablename, 0, ref, 14 ) );
    scripts\mp\rank::registerscoreinfo( ref, #"alwaysshowsplash" );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0x38f5
// Size: 0xd2
function function_cbf4b04a2e7f02ae( ref, var_5a45f9068b4f316 )
{
    assert( isxhashasset( var_5a45f9068b4f316 ) );
    
    if ( !isxhashasset( var_5a45f9068b4f316 ) )
    {
        return;
    }
    
    splashbundle = getscriptbundle( var_5a45f9068b4f316 );
    assert( isstruct( splashbundle ) );
    
    if ( !isstruct( splashbundle ) )
    {
        return;
    }
    
    if ( isdefined( splashbundle.shortname ) )
    {
        scripts\mp\rank::registerscoreinfo( ref, #"hastext", 1 );
    }
    
    if ( isdefined( splashbundle.priority ) )
    {
        scripts\mp\rank::registerscoreinfo( ref, #"priority", splashbundle.priority );
    }
    
    if ( !level.var_488d247ae51e8eeb )
    {
        if ( istrue( splashbundle.alwaysshowsplash ) )
        {
            scripts\mp\rank::registerscoreinfo( ref, #"alwaysshowsplash", 1 );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0x39cf
// Size: 0x16
function onplayerspawn()
{
    self.jumpcur = 0;
    self.mantlecur = 0;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0x39ed
// Size: 0x16b
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        
        if ( !lpcfeaturegated() )
        {
            player.killedplayers = [];
            player.killedby = [];
        }
        
        player.lastkilledby = undefined;
        player.greatestuniqueplayerkills = 0;
        player.recentkillcount = 0;
        player.var_5431d89a36b0936 = 0;
        player.recentdefendcount = 0;
        player.recentassaultcount = 0;
        player.lastkilltime = 0;
        player.prevlastkilltime = 0;
        player.lastkilldogtime = 0;
        
        if ( !isdefined( player.pers[ "lethalEquipmentKillMask" ] ) )
        {
            player.pers[ "lethalEquipmentKillMask" ] = 0;
        }
        
        player.objectiveachievementkillcount = 0;
        player.damagedplayers = [];
        player initslidemonitor();
        player initmonitoradstime();
        player thread monitorreload();
        player thread monitorweaponpickup();
        player thread function_3403058663ef4843();
        
        if ( player function_9c138fdbc077542() )
        {
            player thread namespace_6b49ddb858f34366::function_e6dddb660c52817();
        }
        
        player.lastweaponchangetime = 0;
        player initstancetracking();
        
        if ( getdvarint( @"hash_eba0ce405ac50c64", 0 ) == 1 )
        {
            player setclientdvar( @"cg_everyonehearseveryone", 1 );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0x3b60
// Size: 0x4f
function damagedplayer( victim, damage )
{
    if ( damage < 50 && damage > 10 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_damaged_light", undefined, 0.1 );
        return;
    }
    
    level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_damaged_heavy", undefined, 0.1 );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0x3bb7
// Size: 0x1c
function playerworlddeath( attacker, meansofdeath )
{
    scripts\mp\potg_events::playerworlddeath( attacker, meansofdeath );
}

// Namespace events / scripts\mp\events
// Params 4
// Checksum 0x0, Offset: 0x3bdb
// Size: 0x170
function killedplayernotifysys( killid, victim, objweapon, meansofdeath )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "killedPlayerNotify" );
    self endon( "killedPlayerNotify" );
    
    if ( !isdefined( self.killsinaframecount ) )
    {
        self.killsinaframecount = 0;
    }
    
    self.killsinaframecount++;
    
    if ( weaponclass( objweapon ) == "spread" )
    {
        if ( !isdefined( self.shotgunkillsinaframecount ) )
        {
            self.shotgunkillsinaframecount = 1;
        }
        else
        {
            self.shotgunkillsinaframecount++;
            
            if ( self.shotgunkillsinaframecount >= 2 )
            {
                shotguncollateral( self.shotgunkillsinaframecount );
            }
        }
    }
    else if ( meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT" )
    {
        if ( !isdefined( self.bulletkillsinaframecount ) )
        {
            self.bulletkillsinaframecount = 1;
        }
        else
        {
            self.bulletkillsinaframecount++;
            
            if ( self.bulletkillsinaframecount >= 2 )
            {
                collateral( self.bulletkillsinaframecount );
            }
        }
    }
    
    waittillframeend();
    thread notifykilledplayer( killid, victim, objweapon, meansofdeath, self.killsinaframecount );
    
    if ( self.killsinaframecount > 1 )
    {
        scripts\cp_mp\challenges::function_aad625406f236f34( self.killsinaframecount, self, objweapon );
    }
    
    self.killsinaframecount = 0;
    self.bulletkillsinaframecount = 0;
    self.shotgunkillsinaframecount = 0;
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0x3d53
// Size: 0x82
function notifykilledplayer( killid, victim, objweapon, meansofdeath, numkills )
{
    assertex( isdefined( objweapon ), "<dev string:xa1>" );
    weaponname = undefined;
    
    if ( isweapon( objweapon ) )
    {
        weaponname = getcompleteweaponname( objweapon );
    }
    else
    {
        weaponname = objweapon;
    }
    
    for ( i = 0; i < numkills ; i++ )
    {
        self notify( "got_a_kill", victim, weaponname, meansofdeath );
        waitframe();
    }
}

// Namespace events / scripts\mp\events
// Params 4
// Checksum 0x0, Offset: 0x3ddd
// Size: 0x6c
function attackerisinflictor( attacker, inflictor, objweapon, meansofdeath )
{
    sameent = 1;
    
    if ( isdefined( inflictor ) )
    {
        if ( isdefined( inflictor.owner ) )
        {
            sameent = inflictor.owner == attacker;
        }
        else if ( attackerisinflictorforradiusexplosiveweapon( objweapon, inflictor, meansofdeath ) )
        {
        }
        else
        {
            sameent = inflictor == attacker;
        }
    }
    
    return sameent;
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0x3e52
// Size: 0x78
function attackerisinflictorforradiusexplosiveweapon( objweapon, inflictor, meansofdeath )
{
    var_ec001adf7f355eff = 0;
    
    if ( isdefined( objweapon ) && isdefined( inflictor.classname ) && inflictor.classname == "worldspawn" && meansofdeath == "MOD_EXPLOSIVE" )
    {
        rootweapon = getweaponrootname( objweapon );
        var_ec001adf7f355eff = rootweapon == "iw9_dm_crossbow";
    }
    
    return var_ec001adf7f355eff;
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0x3ed3
// Size: 0x359
function function_e6f3a66a2cd9d802( victim, objweapon, meansofdeath, curtime, weapongroup )
{
    if ( weapongroup == "other" || weapongroup == "weapon_projectile" && weaponclass( objweapon ) != "sniper" && !scripts\mp\weapons::function_d24bf01d284ef941( objweapon ) )
    {
        return 0;
    }
    
    if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" || meansofdeath == "MOD_EXPLOSIVE" )
    {
        return 0;
    }
    
    if ( function_4ef12b6ed882dc9b() )
    {
        return 0;
    }
    
    if ( scripts\common\damage_effects::function_549fbfada3618987() )
    {
        assert( isdefined( level.var_1736de83d797adc0 ) );
        selfvalid = 0;
        elsevalid = 0;
        
        foreach ( guid, attackerdata in victim.attackerdata )
        {
            if ( guid == self.guid )
            {
                if ( curtime == attackerdata.firsttimedamaged )
                {
                    selfvalid = 1;
                }
                else
                {
                    break;
                }
                
                continue;
            }
            
            if ( isdefined( attackerdata.lasttimedamaged ) && curtime - attackerdata.lasttimedamaged < level.var_1736de83d797adc0 )
            {
                elsevalid = 1;
                break;
            }
        }
        
        return ( selfvalid && !elsevalid );
    }
    
    if ( isdefined( victim.attackers ) && victim.attackers.size == 1 && isdefined( victim.guid ) && !isdefined( victim.attackers[ victim.guid ] ) )
    {
        /#
            if ( !isdefined( victim.attackers[ self.guid ] ) )
            {
                println( "<dev string:xd1>" + getcompleteweaponname( objweapon ) );
                println( "<dev string:xdd>" + meansofdeath );
                println( "<dev string:xef>" + self.guid + "<dev string:x102>" + self.name + "<dev string:x10e>" );
                i = 0;
                
                foreach ( key, value in victim.attackers )
                {
                    println( "<dev string:x113>" + i + "<dev string:x128>" + key + "<dev string:x102>" + value.name + "<dev string:x10e>" );
                    i++;
                }
            }
        #/
        
        assertex( isdefined( victim.attackers[ self.guid ] ), "<dev string:x133>" );
        
        if ( isdefined( victim.attackerdata[ self.guid ].hitcount ) && victim.attackerdata[ self.guid ].hitcount > 1 && scripts\mp\utility\weapon::isakimbo( objweapon ) )
        {
            return 0;
        }
        
        return ( curtime == victim.attackerdata[ self.guid ].firsttimedamaged );
    }
    
    return 0;
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0x4234
// Size: 0x421c
function function_b7f154368abbe463( victim, objweapon, meansofdeath, inflictor, deathdata )
{
    self.modifiers = [];
    self.modifiers[ "mask" ] = 0;
    self.modifiers[ "mask2" ] = 0;
    self.modifiers[ "mask3" ] = 0;
    self.modifiers[ "attachment_flags" ] = 0;
    self.modifiers[ "hit_loc" ] = 0;
    curtime = gettime();
    weapongroup = getweapongroup( objweapon );
    fullweaponstring = isweapon( objweapon ) ? getcompleteweaponname( objweapon ) : "";
    victimguid = victim.guid;
    
    if ( !iskillstreakweapon( objweapon ) && !_hasperk( "specialty_explosivebullets" ) )
    {
        attackerisinflictor = attackerisinflictor( self, inflictor, objweapon, meansofdeath );
        var_a071c3820a3eec6d = 0;
        
        if ( istrue( victim.inlaststand ) && isdefined( victim.laststandattacker ) )
        {
            lastattacker = ter_op( isdefined( victim.lastattacker ), victim.lastattacker, victim.laststandattacker );
            var_a071c3820a3eec6d = lastattacker == victim.laststandattacker;
        }
        
        var_fefdbb410f47898e = 0;
        
        if ( getdvarint( @"hash_b7d30c36ac281531", 1 ) && isdefined( inflictor.classname ) && inflictor.classname == "worldspawn" && var_a071c3820a3eec6d )
        {
            attackerisinflictor = 1;
            var_fefdbb410f47898e = 1;
        }
        
        if ( isdefined( victim.attackerposition ) )
        {
            attackerposition = victim.attackerposition;
        }
        else
        {
            attackerposition = self.origin;
        }
        
        var_a2c3fea3986af52a = anglestoforward( self getplayerangles() );
        var_146f31f6b6666ca7 = victim.origin - attackerposition;
        var_9669ee24872dd095 = vectornormalize( var_146f31f6b6666ca7 );
        var_72705a221874f8a9 = vectordot( var_a2c3fea3986af52a, var_9669ee24872dd095 );
        attackervelocity = self getvelocity();
        var_63d7d6bf10076ecb = vectornormalize( attackervelocity );
        var_776dafcc4fadbc14 = vectordot( var_a2c3fea3986af52a, var_63d7d6bf10076ecb );
        var_414d20858ffe7335 = length2dsquared( attackervelocity );
        
        if ( isdefined( attackervelocity ) )
        {
            if ( attackervelocity[ 0 ] != 0 || attackervelocity[ 1 ] != 0 || attackervelocity[ 2 ] != 0 )
            {
                self.modifiers[ "moving_kill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"moving_kill" ) );
            }
        }
        
        isbulletdamage = isbulletdamage( meansofdeath ) || scripts\mp\weapons::function_d24bf01d284ef941( objweapon );
        ismeleedamage = ismeleedamage( meansofdeath );
        
        if ( ( isbulletdamage || ismeleedamage ) && isdefined( var_776dafcc4fadbc14 ) && isdefined( var_414d20858ffe7335 ) )
        {
            if ( abs( var_776dafcc4fadbc14 ) < 0.8 && var_414d20858ffe7335 > 50 )
            {
                self.modifiers[ "strafing_kill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"strafing_kill" ) );
            }
        }
        
        if ( meansofdeath == "MOD_EXECUTION" )
        {
            self.modifiers[ "execution" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"execution" ) );
        }
        
        if ( level.numkills == 0 )
        {
            self.modifiers[ "firstblood" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"firstblood" ) );
        }
        
        if ( !isdefined( objweapon ) || !isdefined( objweapon.basename ) || objweapon.basename == "none" )
        {
            return;
        }
        
        if ( function_e6f3a66a2cd9d802( victim, objweapon, meansofdeath, curtime, weapongroup ) )
        {
            self.modifiers[ "oneshotkill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"1shot1kill" ) );
        }
        
        if ( isdefined( self.lastinsmoketime ) && self.lastinsmoketime + 5000 > gettime() || isdefined( victim.lastinsmoketime ) && victim.lastinsmoketime + 5000 > gettime() )
        {
            self.modifiers[ "insmoke" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"enemyinsmoke" ) );
        }
        
        if ( scripts\mp\utility\game::runleanthreadmode() )
        {
            if ( scripts\cp_mp\utility\killstreak_utility::teamhasuav_ignorecuav( victim.team ) )
            {
                self.modifiers[ "enemyHasUAV" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"enemywithuav" ) );
            }
        }
        else if ( scripts\cp_mp\utility\killstreak_utility::teamhasuav( victim.team ) )
        {
            self.modifiers[ "enemyHasUAV" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"enemywithuav" ) );
        }
        
        if ( isdefined( victim.stuckbygrenadeowner ) && victim.stuckbygrenadeowner == self )
        {
            self.modifiers[ "grenadestuck" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"grenadestuck" ) );
        }
        
        if ( isassaulting( victim ) )
        {
            self.modifiers[ "assault" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"assaulting" ) );
            incrementobjectiveachievementkill();
        }
        
        if ( isdefending( victim ) )
        {
            self.modifiers[ "defender" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"defending" ) );
            incrementobjectiveachievementkill();
        }
        
        if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" )
        {
            self.modifiers[ "melee" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"melee" ) );
            
            if ( weapongroup != "weapon_melee" && weapongroup != "weapon_melee2" && weapongroup != "other" )
            {
                self.modifiers[ "gunbutt" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"gunbutt" ) );
            }
        }
        
        heldoffhand = victim getheldoffhand();
        
        if ( getweaponrootstring( heldoffhand ) == "frag_grenade" || heldoffhand.basename == "cluster_grenade_mp" )
        {
            self.modifiers[ "cooking" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"cooking" ) );
        }
        
        if ( istrue( deathdata.assistedsuicide ) )
        {
            self.modifiers[ "assistedsuicide" ] = 1;
        }
        
        if ( self.pers[ "cur_death_streak" ] > 3 )
        {
            self.modifiers[ "comeback" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"comeback" ) );
        }
        
        if ( meansofdeath != "MOD_GRENADE" && ( meansofdeath == "MOD_HEAD_SHOT" || function_632bdd4591097aef( deathdata.hitloc ) && meansofdeath != "MOD_MELEE" || isxmike109explosiveheadshot( objweapon, deathdata ) || function_d355d90bab289087( objweapon, deathdata ) || function_75f9ec9388f318dc( objweapon, deathdata ) ) )
        {
            self.modifiers[ "headshot" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"headshot" ) );
        }
        
        if ( isdefined( self.wasti ) && self.wasti && curtime - self.spawntime <= 5000 )
        {
            self.modifiers[ "jackintheboxkill" ] = 1;
        }
        
        if ( !isreallyalive( self ) && isdefined( self.deathtime ) )
        {
            timesincelastdeath = gettime() - self.deathtime;
            
            if ( timesincelastdeath < 1500 && timesincelastdeath > 0 )
            {
                self.modifiers[ "posthumous" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"posthumous" ) );
            }
        }
        
        if ( level.teambased && isdefined( victim.lastkilltime ) && curtime - victim.lastkilltime < 1500 )
        {
            if ( isdefined( victim.lastkilledplayer ) && victim.lastkilledplayer != self )
            {
                self.modifiers[ "avenger" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"avenger" ) );
            }
        }
        
        if ( isbackkill( self, victim, meansofdeath ) )
        {
            self.modifiers[ "backstab" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"backstab" ) );
        }
        
        if ( !istrue( self isnightvisionon() ) )
        {
            self.modifiers[ "withoutnvgs" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"withoutnvgs" ) );
        }
        
        if ( attackerisinflictor )
        {
            var_4409ff2b093ccdde = victim.origin;
            
            if ( var_fefdbb410f47898e && isdefined( victim.var_d9d1b1f409f99154 ) )
            {
                var_4409ff2b093ccdde = victim.var_d9d1b1f409f99154;
            }
            
            var_3c709d201f0772ad = getshotdistancetype( self, objweapon, meansofdeath, attackerposition, var_4409ff2b093ccdde );
            killdist = math::round_float( distance( attackerposition, var_4409ff2b093ccdde ) / 39.37, 2 );
            
            switch ( var_3c709d201f0772ad )
            {
                case #"hash_e1ae7daca67ccc55":
                    self.modifiers[ "pointblank" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"shortrange" ) );
                    break;
                case #"hash_bbddd8225d923d3":
                    self.modifiers[ "longshot" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"longrange" ) );
                    self setclientomnvar( "ui_longshot_dist", killdist );
                    self setclientomnvar( "ui_longshot_special", islongshotspecial( attackerposition, var_4409ff2b093ccdde, objweapon ) );
                    break;
                case #"hash_4364fa08acd17954":
                    self.modifiers[ "longshot" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"longrange" ) );
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"verylongrange" ) );
                    self.modifiers[ "very_longshot" ] = 1;
                    self setclientomnvar( "ui_longshot_dist", killdist );
                    self setclientomnvar( "ui_longshot_special", islongshotspecial( attackerposition, var_4409ff2b093ccdde, objweapon ) );
                    break;
            }
            
            if ( istrue( self.focus ) || isdefined( self.focuslasttime ) && isdefined( self.lastshotfiredtime ) && self.lastshotfiredtime == self.focuslasttime && curtime - self.focuslasttime <= 6000 )
            {
                self.modifiers[ "holdingbreath" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"holdbreath" ) );
            }
            
            if ( scripts\mp\class::isweaponsilenced( objweapon ) )
            {
                self.modifiers[ "silencedkill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"silenced" ) );
            }
            
            if ( victim scripts\mp\weapons::isstunnedorblinded() )
            {
                self.modifiers[ "victimimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"victim_impaired" ) );
                self.modifiers[ "detectedimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"detected_impaired" ) );
            }
            
            if ( istrue( victim.ishaywire ) )
            {
                self.modifiers[ "victim_haywire" ] = 1;
                self.modifiers[ "mask3" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask3" ], function_e2ff8f4b4e94f723( #"kill_bitfield3", #"victim_haywire" ) );
            }
            
            if ( isdetected( self, victim ) )
            {
                self.modifiers[ "detectedimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"detected_impaired" ) );
            }
            
            if ( isdefined( deathdata.damageflags ) && deathdata.damageflags & 8 && !( deathdata.damageflags & 16384 ) )
            {
                self.modifiers[ "coverkill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"cover_kill" ) );
            }
            
            if ( scripts\mp\weapons::grenadeheldatdeath() )
            {
                self.modifiers[ "clutchkill" ] = 1;
            }
            
            if ( issurvivorkill( self ) )
            {
                self.modifiers[ "low_health_kill" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"lowhealth" ) );
            }
            
            if ( !self isonground() )
            {
                self.modifiers[ "airborne" ] = 1;
            }
            
            if ( !victim isonground() )
            {
                self.modifiers[ "victim_airborne" ] = 1;
            }
            
            if ( isdefined( victim.var_69a9151e7de440f1 ) )
            {
                self.modifiers[ "victim_has_dmz_bounty" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"victim_has_dmz_bounty" ) );
            }
            
            if ( self playermount() >= 0.5 )
            {
                self.modifiers[ "mounted" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"mounted" ) );
            }
            
            if ( self ishanging() )
            {
                self.modifiers[ "ledgehanging" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"ledgehanging" ) );
            }
            
            if ( isbulletdamage )
            {
                self.modifiers[ "bullet_damage" ] = 1;
                remainingammo = self getweaponammoclip( objweapon );
                
                if ( remainingammo <= 0 )
                {
                    self.modifiers[ "last_bullet_kill" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"lastbullet" ) );
                }
                
                burstfirecount = objweapon.burstcount;
                var_31a90ef4f5a008a8 = objweapon.issemiauto || isdefined( burstfirecount ) && burstfirecount == 1 || istrue( objweapon.var_a6463aeb77648bc0 ) && isplayerads();
                var_ff3b6faa21cbea11 = !istrue( var_31a90ef4f5a008a8 ) && objweapon.isauto;
                
                if ( isdefined( var_ff3b6faa21cbea11 ) && istrue( var_ff3b6faa21cbea11 ) )
                {
                    self.modifiers[ "full_auto_kill" ] = 1;
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"full_auto_kill" ) );
                }
                
                if ( isdefined( var_31a90ef4f5a008a8 ) && istrue( var_31a90ef4f5a008a8 ) )
                {
                    self.modifiers[ "semi_auto_kill" ] = 1;
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"semi_auto_kill" ) );
                }
                
                if ( isdefined( burstfirecount ) && burstfirecount > 1 )
                {
                    self.modifiers[ "burst_kill" ] = 1;
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"burst_kill" ) );
                }
                
                if ( isplayerads() )
                {
                    var_4da4661d6f703308 = self function_c603bed3b1c8d11( self.currentprimaryweapon );
                    
                    if ( var_4da4661d6f703308 )
                    {
                        self.modifiers[ "tac_stance" ] = 1;
                        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"hash_3d20b9f56f230af1" ) );
                    }
                    else
                    {
                        self.modifiers[ "ads" ] = 1;
                        self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"ads" ) );
                    }
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"hipfire" ) );
                }
            }
            
            if ( victim issprinting() )
            {
                self.modifiers[ "victim_sprinting" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victimsprinting" ) );
            }
            
            if ( level.teambased )
            {
                players = getfriendlyplayers( self.team, 1 );
                
                foreach ( player in players )
                {
                    if ( player == self )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( self.origin, player.origin ) < 90000 )
                    {
                        self.modifiers[ "buddy_kill" ] = 1;
                        break;
                    }
                }
            }
            
            if ( scripts\mp\weapons::isstunnedorblinded() )
            {
                self.modifiers[ "impaired" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"enemystunned" ) );
            }
            
            if ( isdefined( self.tookweaponfrom ) && isdefined( self.tookweaponfrom[ fullweaponstring ] ) && self.tookweaponfrom[ fullweaponstring ] == victim )
            {
                self.modifiers[ "backfire" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"backfire" ) );
            }
        }
        else if ( weapongroup == "weapon_projectile" )
        {
            if ( isdefined( inflictor ) && isdefined( inflictor.adsfire ) )
            {
                if ( inflictor.adsfire )
                {
                    self.modifiers[ "ads" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"ads" ) );
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"hipfire" ) );
                }
            }
        }
        
        vehicle = scripts\cp_mp\utility\player_utility::getvehicle( 1 );
        
        if ( isdefined( vehicle ) )
        {
            self.modifiers[ "in_vehicle" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"invehicle" ) );
            
            if ( vehicle scripts\common\vehicle::ishelicopter() )
            {
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"from_helicopter" ) );
            }
            else if ( vehicle.vehiclename == "veh9_mil_lnd_mrap" )
            {
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"from_mrap" ) );
                modifiers2 = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"from_mrap" ) );
            }
        }
        
        if ( victim isonascender() || victim isonzipline() )
        {
            self.modifiers[ "victim_on_zipline" ] = 1;
            self.modifiers[ "mask3" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask3" ], function_e2ff8f4b4e94f723( #"kill_bitfield3", #"victim_on_zipline" ) );
        }
        
        if ( !victim isonground() && !victim iswallrunning() && !self isonground() && !self iswallrunning() )
        {
            if ( attackerisinflictor )
            {
                self.modifiers[ "air_to_air_kill" ] = 1;
            }
        }
        else
        {
            if ( attackerisinflictor )
            {
                if ( self iswallrunning() )
                {
                    self.modifiers[ "wallkill" ] = 1;
                }
                else if ( function_78dbf8d8bcbed882( self, objweapon, victim ) )
                {
                    self.modifiers[ "jumpkill" ] = 1;
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"jumpkill" ) );
                }
                else if ( events_issliding() )
                {
                    self.modifiers[ "slidekill" ] = 1;
                    self.modifiers[ "sliding" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"slide" ) );
                }
                else if ( self isonladder() )
                {
                    self.modifiers[ "onladder" ] = 1;
                    self.modifiers[ "mask3" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask3" ], function_e2ff8f4b4e94f723( #"kill_bitfield3", #"onladder" ) );
                }
                
                if ( !isdefined( vehicle ) )
                {
                    stance = self getstance();
                    
                    switch ( stance )
                    {
                        case #"hash_c6775c88e38f7803":
                            self.modifiers[ "standing_kill" ] = 1;
                            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"standing" ) );
                            break;
                        case #"hash_d91940431ed7c605":
                            self.modifiers[ "prone_kill" ] = 1;
                            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"prone" ) );
                            break;
                        case #"hash_3fed0cbd303639eb":
                            self.modifiers[ "crouch_kill" ] = 1;
                            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"crouch" ) );
                            break;
                    }
                }
            }
            
            if ( victim iswallrunning() )
            {
                self.modifiers[ "killonwall" ] = 1;
            }
            else if ( isskeetshooter( self, objweapon, meansofdeath, attackerposition, victim ) )
            {
                self.modifiers[ "killinair" ] = 1;
            }
        }
        
        if ( isdefined( victim.streakdata ) )
        {
            foreach ( streakinfo in victim.streakdata.streaks )
            {
                costdiff = streakinfo.currentcost - victim.streakpoints;
                
                if ( costdiff > 0 && costdiff <= 1 )
                {
                    self.modifiers[ "buzzkill" ] = victim.pers[ "cur_kill_streak" ];
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"buzzkill" ) );
                    break;
                }
            }
        }
        
        if ( !runleanthreadmode() )
        {
            if ( level.teambased )
            {
                var_4cb03cedeb6f7b81 = 0;
                enemies = getenemyplayers( self.team );
                
                foreach ( enemy in enemies )
                {
                    if ( enemy.score > 0 )
                    {
                        var_4cb03cedeb6f7b81 = 1;
                        break;
                    }
                }
                
                if ( var_4cb03cedeb6f7b81 )
                {
                    if ( is_enemy_highest_score( victim, enemies ) )
                    {
                        self.modifiers[ "kingslayer" ] = 1;
                        self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"kingslayer" ) );
                    }
                }
            }
            else
            {
                var_4cb03cedeb6f7b81 = 0;
                
                foreach ( enemy in level.players )
                {
                    if ( enemy.score > 0 )
                    {
                        var_4cb03cedeb6f7b81 = 1;
                        break;
                    }
                }
                
                if ( var_4cb03cedeb6f7b81 )
                {
                    if ( is_enemy_highest_score( victim, level.players ) )
                    {
                        self.modifiers[ "kingslayer" ] = 1;
                        self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"kingslayer" ) );
                    }
                }
            }
        }
        
        if ( isdefined( inflictor ) && istrue( inflictor.isequipment ) && meansofdeath == "MOD_IMPACT" && !isthrowingknife( objweapon ) )
        {
            self.modifiers[ "item_impact" ] = 1;
        }
        
        if ( islauncherdirectimpactdamage( objweapon, meansofdeath ) )
        {
            self.modifiers[ "launcher_impact" ] = 1;
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"launcher_impact" ) );
        }
        
        if ( var_72705a221874f8a9 >= 0.6428 )
        {
            self.modifiers[ "victim_in_standard_view" ] = 1;
        }
        
        var_60fe8dfd95145fab = 0;
        
        if ( isdefined( objweapon ) && isdefined( self.lastadsstarttime ) && isdefined( objweapon.basename ) && isbulletweapon( objweapon ) )
        {
            var_b281b5a1389df140 = 500;
            weapontype = scripts\cp_mp\weapon::getweaponclasstoken( objweapon.basename );
            
            if ( isdefined( weapontype ) )
            {
                switch ( weapontype )
                {
                    case #"hash_fa0ed9f6bd4f4e9a":
                    case #"hash_fa18d2f6bd57925a":
                    case #"hash_fa4dbdf6bd80bf52":
                        var_b281b5a1389df140 *= 1.5;
                        break;
                    case #"hash_fa21c4f6bd5e3815":
                    case #"hash_fa27b9f6bd62a3f2":
                        var_b281b5a1389df140 *= 2;
                        break;
                }
                
                if ( curtime - self.lastadsstarttime <= var_b281b5a1389df140 )
                {
                    self.modifiers[ "quickscope" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"quickscope" ) );
                    var_60fe8dfd95145fab = 1;
                }
            }
        }
        
        if ( !istrue( var_60fe8dfd95145fab ) )
        {
            if ( isdefined( self.lastadsstarttime ) && curtime - self.lastadsstarttime <= 500 )
            {
                self.modifiers[ "quickscope" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"quickscope" ) );
            }
        }
        
        if ( isdefined( self.lastweaponchangetime ) && curtime - self.lastweaponchangetime <= 2500 )
        {
            self.modifiers[ "weapon_change_kill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"weaponswap" ) );
        }
        
        if ( isdefined( self.tookweaponfrom ) && isdefined( self.tookweaponfrom[ fullweaponstring ] ) && self.tookweaponfrom[ fullweaponstring ].team != self.team )
        {
            self.modifiers[ "weapon_pickup_kill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"recentweaponpickup" ) );
        }
        
        if ( isdefined( self.lastreloadtime ) && curtime - self.lastreloadtime <= 5000 )
        {
            self.modifiers[ "reload_kill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"recentreload" ) );
        }
        
        if ( isdefined( self.var_887efc1f015b6a78 ) && curtime - self.var_887efc1f015b6a78 <= 5000 )
        {
            self.modifiers[ "after_sprint_kill" ] = 1;
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"after_sprint_kill" ) );
        }
        
        if ( istrue( victim.isdefusing ) )
        {
            self.modifiers[ "killed_defuser" ] = 1;
        }
        
        if ( istrue( victim.isplanting ) )
        {
            self.modifiers[ "killed_planter" ] = 1;
        }
        
        if ( iscacsecondaryweapon( objweapon ) || _hasperk( "specialty_munitions_2" ) && isdefined( self.secondaryweaponobj ) && objweapon == self.secondaryweaponobj )
        {
            self.modifiers[ "secondary_weapon" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"usingsecondaryweapon" ) );
        }
        
        if ( isinlaststand( self ) )
        {
            self.modifiers[ "last_stand" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"laststand" ) );
        }
        
        if ( isinlaststand( victim ) || istrue( deathdata.brvictiminlaststand ) )
        {
            self.modifiers[ "victim_last_stand" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victimlaststand" ) );
        }
        
        inradiation = istrue( scripts\engine\utility::callsharedfunc( "radiation", "radiation_isInRadiation", victim.origin ) ) || istrue( scripts\engine\utility::callsharedfunc( "biobunker_radiation", "isInBiobunkerRadiationVolume", victim.origin ) );
        
        if ( istrue( inradiation ) )
        {
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"victim_in_radiation" ) );
        }
        
        var_e27987bea6bad0d6 = istrue( scripts\engine\utility::callsharedfunc( "radiation", "radiation_isInRadiation", self.origin ) ) || istrue( scripts\engine\utility::callsharedfunc( "biobunker_radiation", "isInBiobunkerRadiationVolume", self.origin ) );
        
        if ( istrue( var_e27987bea6bad0d6 ) )
        {
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"in_radiation" ) );
        }
        
        platform = self getmovingplatformparent();
        
        if ( isdefined( platform ) && platform scripts\cp_mp\vehicles\vehicle::isvehicle() && istrue( platform.isheli ) )
        {
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"from_helicopter" ) );
            ref = platform scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();
            
            if ( ref == "veh9_palfa" )
            {
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"from_palfa" ) );
            }
        }
        
        if ( victim scripts\cp_mp\utility\player_utility::isinvehicle() || isdefined( victim.lastvehicle ) )
        {
            self.modifiers[ "victim_in_vehicle" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victiminvehicle" ) );
        }
        
        if ( self isinvehicleleanout() )
        {
            self.modifiers[ "vehiclelean" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"vehiclelean" ) );
            
            if ( vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd() == "veh9_sedan_hatchback_1985" )
            {
                self.modifiers[ "vehiclelean_sedan" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"vehiclelean_sedan" ) );
            }
        }
        
        if ( meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT" || weaponclass( objweapon ) == "spread" )
        {
            thread watchformorebulletkillsinaframeae();
            
            if ( !isdefined( self.var_39a4aa8a028cb36e ) )
            {
                self.var_39a4aa8a028cb36e = 1;
            }
            else
            {
                self.var_39a4aa8a028cb36e++;
                
                if ( self.var_39a4aa8a028cb36e >= 2 )
                {
                    function_c5f08330d9923476( self.var_39a4aa8a028cb36e );
                }
            }
        }
        
        if ( isdefined( meansofdeath ) )
        {
            switch ( meansofdeath )
            {
                case #"hash_d8646db4e6ee3658":
                    self.modifiers[ "fire_damage" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"fire" ) );
                    break;
                case #"hash_b1078ff213fddba6":
                    self.modifiers[ "impact_damage" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"equipmentimpact" ) );
                    break;
                case #"hash_abb1587cdc6def23":
                    self.modifiers[ "crush_damage" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"crush" ) );
                    break;
                default:
                    break;
            }
        }
        
        if ( isdefined( objweapon.basename ) && issubstr( objweapon.basename, "molotov" ) || issubstr( objweapon.basename, "thermite" ) || scripts\cp_mp\dragonsbreath::isdragonsbreathweapon( objweapon ) || scripts\cp_mp\crossbow::isthermitecrossbow( objweapon ) )
        {
            self.modifiers[ "fire_damage" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"fire" ) );
        }
        
        if ( istrue( victim.gulagjailer ) )
        {
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"victim_is_gulag_jailer" ) );
        }
        
        for ( moverparent = self; true ; moverparent = newparent )
        {
            if ( ( isplayer( moverparent ) || isactor( moverparent ) ) && !moverparent islinked() )
            {
                newparent = moverparent getmovingplatformparent( 1 );
            }
            else
            {
                newparent = moverparent getlinkedparent();
            }
            
            if ( !isdefined( newparent ) )
            {
                break;
            }
        }
        
        if ( isdefined( moverparent ) && moverparent scripts\cp_mp\vehicles\vehicle::isvehicle() && ( !isdefined( vehicle ) || moverparent != vehicle ) )
        {
            ref = scripts\cp_mp\utility\train_utility::function_e58b746157089c68( moverparent );
            
            if ( isdefined( ref ) && ( ref == "cargo_train" || ref == "br_passenger_train" ) )
            {
                self.modifiers[ "ontrain" ] = 1;
                
                if ( ref == "cargo_train" )
                {
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"on_cargo_train" ) );
                }
                else if ( ref == "br_passenger_train" )
                {
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"on_passenger_train" ) );
                }
                
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"ontrain" ) );
            }
            else
            {
                self.modifiers[ "vehiclesurf" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"vehiclesurf" ) );
                
                if ( moverparent.classname == "script_vehicle" && moverparent vehicle_getspeed() > 25 )
                {
                    self.modifiers[ "infastvehicle" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"infastvehicle" ) );
                }
            }
        }
        
        if ( isdefined( inflictor ) && isdefined( inflictor.equipmentref ) )
        {
            if ( inflictor.equipmentref == "equip_c4" || inflictor.equipmentref == "equip_claymore" )
            {
                stuckto = inflictor getlinkedparent();
                
                if ( isdefined( stuckto ) && isdefined( stuckto.helperdronetype ) && stuckto.helperdronetype == "radar_drone_recon" )
                {
                    self.modifiers[ "recon_drone_explosive" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"recondroneexplosive" ) );
                    
                    if ( level.challengesallowed && isdefined( stuckto.owner ) )
                    {
                        self.recondroneteammate = stuckto.owner;
                    }
                }
                else if ( isdefined( stuckto ) && stuckto scripts\cp_mp\vehicles\vehicle::isvehicle() )
                {
                    self.modifiers[ "vehicle_explosive" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"vehicleexplosive" ) );
                    
                    if ( stuckto scripts\common\vehicle::ishelicopter() )
                    {
                        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"helicopter_explosive" ) );
                    }
                }
            }
        }
        
        if ( isvehicleweapon( objweapon ) && meansofdeath == "MOD_EXPLOSIVE" )
        {
            self.modifiers[ "vehicle_explosive" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"vehicleexplosive" ) );
            
            if ( function_858ed945747dfb28( objweapon ) )
            {
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"helicopter_explosive" ) );
            }
        }
        
        if ( scripts\cp_mp\armor::hasarmor() )
        {
            self.modifiers[ "wearingarmor" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"wearingarmor" ) );
        }
        
        if ( scripts\cp_mp\armor::function_9bca5c1d23a3e0b3() )
        {
            self.modifiers[ "fullarmor" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"fullarmor" ) );
        }
        
        var_831b0df5dbb687cf = namespace_9823ee6035594d67::function_c0a211a69f5f8f2f( victim.origin );
        
        if ( isdefined( var_831b0df5dbb687cf ) && !namespace_9823ee6035594d67::function_4ec4f39a2e1745f2( var_831b0df5dbb687cf ) )
        {
            self.modifiers[ "victiminstronghold" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victiminstronghold" ) );
            
            if ( namespace_9823ee6035594d67::function_771f278c8c749a28( var_831b0df5dbb687cf ) )
            {
                self.modifiers[ "victiminlockedstronghold" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victiminlockedstronghold" ) );
            }
        }
        
        if ( scripts\mp\gametypes\br_public::isplayeringulag() )
        {
            self.modifiers[ "in_gulag" ] = 1;
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"in_gulag" ) );
        }
        
        if ( isdefined( victim.origin ) )
        {
            if ( isdefined( level.var_a68dcd3b5a82712d ) )
            {
                foreach ( struct in level.var_a68dcd3b5a82712d )
                {
                    dist = distance2d( struct.origin, victim.origin );
                    
                    if ( dist <= struct.radius )
                    {
                        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"radio_pinged" ) );
                    }
                }
            }
            
            if ( isdefined( level.activetowers ) && isdefined( self.team ) )
            {
                foreach ( instance in level.activetowers )
                {
                    if ( isdefined( instance.activeteam ) && instance.activeteam == self.team )
                    {
                        dist = distance2d( instance.origin, victim.origin );
                        
                        if ( dist <= level.var_6acf91bbf5273e8f )
                        {
                            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"uav_tower_pinged" ) );
                        }
                    }
                }
            }
        }
        
        if ( isdefined( objweapon.scope ) )
        {
            var_7a4444efa68407fa = objweapon.scope;
            basetype = getattachmentbasetype( objweapon, var_7a4444efa68407fa );
            
            if ( basetype == "ironsdefault" )
            {
                self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"irons" ) );
            }
            else if ( basetype == "reflex" || basetype == "minireflex" )
            {
                self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"reflex" ) );
            }
            else if ( basetype == "hybrid" )
            {
                self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"hybrid" ) );
            }
            else if ( basetype == "acog" )
            {
                self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"acog" ) );
            }
            else if ( basetype == "holo" )
            {
                self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"holo" ) );
            }
            
            if ( function_ec9cd761df1a3271( objweapon, var_7a4444efa68407fa ) )
            {
                self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"thermal" ) );
            }
        }
        
        if ( isdefined( objweapon ) && isdefined( self.team ) )
        {
            team = scripts\mp\gametypes\br_weapons::function_1a561e5ef2eca63a( self, objweapon );
            
            if ( isdefined( team ) && team != self.team )
            {
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"used_enemy_weapon" ) );
            }
        }
        
        if ( meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" )
        {
            if ( isdefined( inflictor.threwback ) && inflictor.threwback )
            {
                self.modifiers[ "throwback_grenade_kill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"throwback_grenade" ) );
            }
        }
        
        if ( meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" )
        {
            if ( isdefined( inflictor.iscooked ) && inflictor.iscooked )
            {
                self.modifiers[ "with_cooked_grenade_kill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"hash_5b4eb501eaf86d4e" ) );
            }
        }
        
        if ( isdefined( victim.damagedplayers ) )
        {
            foreach ( guid, damagetime in victim.damagedplayers )
            {
                if ( isdefined( guid ) && guid == self.guid && isdefined( damagetime ) && curtime - damagetime < 15000 )
                {
                    self.modifiers[ "damager_kill" ] = 1;
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"hash_d5f7402ac6e6fc0c" ) );
                }
            }
        }
        
        if ( level.teambased )
        {
            if ( isdefined( victim.damagedplayers ) )
            {
                enemies = teams::getenemyplayers( self.team );
                
                foreach ( guid, damagetime in victim.damagedplayers )
                {
                    victimisenemy = 0;
                    
                    foreach ( enemy in enemies )
                    {
                        if ( guid == enemy.guid )
                        {
                            victimisenemy = 1;
                            break;
                        }
                    }
                    
                    if ( isdefined( guid ) && guid != self.guid && victimisenemy == 0 && isdefined( damagetime ) && curtime - damagetime < 15000 )
                    {
                        self.modifiers[ "team_damager_kill" ] = 1;
                        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"hash_fbf026161c1d9738" ) );
                    }
                }
            }
        }
        
        zoomlevel = self playergetzoomfov();
        
        if ( isdefined( zoomlevel ) && zoomlevel <= 22 )
        {
            self.modifiers[ "extreme_magnification_kill" ] = 1;
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"extreme_magnification_kill" ) );
        }
        
        function_245eb5b8f095001b( objweapon, meansofdeath, inflictor );
    }
    
    if ( istrue( objweapon.isalternate ) )
    {
        self.modifiers[ "isaltmode" ] = 1;
        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"isaltmode" ) );
    }
    
    if ( isdefined( self.lastkilledby ) && self.lastkilledby == victim )
    {
        self.modifiers[ "revenge" ] = 1;
        self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"revenge" ) );
    }
    
    nemesis = getnemesis();
    
    if ( nemesis.size > 0 )
    {
        foreach ( guid in nemesis )
        {
            if ( isdefined( victimguid ) && victimguid == guid )
            {
                self.modifiers[ "killedNemesis" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"nemesis" ) );
                break;
            }
        }
    }
    
    if ( self isswimming() )
    {
        self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"swimming" ) );
        
        if ( self isswimunderwater() )
        {
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"underwater" ) );
        }
    }
    
    if ( isagent( victim ) )
    {
        if ( victim getthreatsight( self ) < 1 )
        {
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"unaware" ) );
        }
    }
    
    hitloc = 0;
    
    if ( isdefined( deathdata ) && isdefined( deathdata.hitloc ) && scripts\cp_mp\utility\damage_utility::validshotcheck( meansofdeath, self ) )
    {
        switch ( deathdata.hitloc )
        {
            case #"hash_db653a4972b3c13b":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"none" );
                break;
            case #"hash_8a1772f5f912c880":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"helmet" );
                break;
            case #"hash_b107b5547c755d23":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"head" );
                break;
            case #"hash_92bbfe494d03d772":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"neck" );
                break;
            case #"hash_24df6c1a53c03c53":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"upper_torso" );
                break;
            case #"hash_51d5d0b9add9cc5a":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"left_upper_arm" );
                break;
            case #"hash_d42e71cd9f1e822f":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"right_upper_arm" );
                break;
            case #"hash_a7980c387477e7bb":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"left_lower_arm" );
                break;
            case #"hash_5d5aac570f6fd382":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"right_lower_arm" );
                break;
            case #"hash_da51cc36a471058":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"left_hand" );
                break;
            case #"hash_da2f35145aa58933":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"right_hand" );
                break;
            case #"hash_810a7426c8bac3ac":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"left_upper_leg" );
                break;
            case #"hash_1cbc508a2fe01b79":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"right_upper_leg" );
                break;
            case #"hash_7b36142458a6c2d5":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"left_lower_leg" );
                break;
            case #"hash_a638fec9040cfcf4":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"right_lower_leg" );
                break;
            case #"hash_168c74e879f0ba11":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"left_foot" );
                break;
            case #"hash_9536712388e65bce":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"right_foot" );
                break;
            case #"hash_fb5b5e6c07253005":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"gun" );
                break;
            case #"hash_b2116949ba13eb10":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"shield" );
                break;
            case #"hash_25789111b74943b4":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"armor" );
                break;
            case #"hash_df21ff8a0b282215":
                hitloc = function_e2ff8f4b4e94f723( #"hit_loc", #"soft" );
                break;
        }
    }
    
    self.modifiers[ "hit_loc" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "hit_loc" ], hitloc );
    
    if ( istrue( self.var_859654e0445a36d9 ) )
    {
        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"holding_hostage" ) );
    }
    
    if ( self calloutmarkerping_isentitypingedbyplayer( victim getentitynumber() ) )
    {
        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"pinged" ) );
    }
    
    if ( scripts\mp\calloutmarkerping_mp::function_fc3ea40c99062d82( victim ) )
    {
        self.modifiers[ "pinged_by_friendly" ] = 1;
        self.modifiers[ "mask3" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask3" ], function_e2ff8f4b4e94f723( #"kill_bitfield3", #"pinged_by_friendly" ) );
    }
    
    if ( weapongroup == "other" )
    {
        checklethalequipmentachievement( objweapon );
    }
    
    if ( function_5b7e9a4c946f3a13( deathdata.meansofdeath, [ "MOD_EXPLOSIVE", "MOD_EXPLOSIVE_BULLET", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_HEAD_SHOT" ] ) )
    {
        if ( meansofdeath != "MOD_HEAD_SHOT" || meansofdeath == "MOD_HEAD_SHOT" && function_e287831520aa308b( objweapon, self ) )
        {
            self.modifiers[ "explosive_damage" ] = 1;
            self.modifiers[ "mask3" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask3" ], function_e2ff8f4b4e94f723( #"kill_bitfield3", #"explosive_damage" ) );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0x8458
// Size: 0x2c
function function_245eb5b8f095001b( objweapon, meansofdeath, inflictor )
{
    function_cfa5eaed45133b7( inflictor, objweapon );
    function_a7168c7ec3eb917a( objweapon );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0x848c
// Size: 0x2a4
function function_cfa5eaed45133b7( inflictor, objweapon )
{
    if ( issharedfuncdefined( "weapons", "recommendedStatusBySeason" ) )
    {
        var_2420b2d3569c0c6 = [[ utility::getsharedfunc( "weapons", "recommendedStatusBySeason" ) ]]( objweapon, inflictor );
        
        if ( isdefined( var_2420b2d3569c0c6 ) )
        {
            if ( var_2420b2d3569c0c6[ 0 ] )
            {
                self.modifiers[ "recommended_season_0" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"recommended_season_0" ) );
            }
            
            if ( var_2420b2d3569c0c6[ 1 ] )
            {
                self.modifiers[ "recommended_season_1" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"recommended_season_1" ) );
            }
            
            if ( var_2420b2d3569c0c6[ 2 ] )
            {
                self.modifiers[ "recommended_season_2" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"recommended_season_2" ) );
            }
            
            if ( var_2420b2d3569c0c6[ 3 ] )
            {
                self.modifiers[ "recommended_season_3" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"recommended_season_3" ) );
            }
            
            if ( var_2420b2d3569c0c6[ 4 ] )
            {
                self.modifiers[ "recommended_season_4" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"recommended_season_4" ) );
            }
            
            if ( var_2420b2d3569c0c6[ 5 ] )
            {
                self.modifiers[ "recommended_season_5" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"recommended_season_5" ) );
            }
            
            if ( var_2420b2d3569c0c6[ 6 ] )
            {
                self.modifiers[ "recommended_season_6" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"recommended_season_6" ) );
            }
        }
    }
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0x8738
// Size: 0x56e
function function_a7168c7ec3eb917a( objweapon )
{
    if ( isdefined( objweapon.attachments ) )
    {
        var_a7b01beb1843361a = 0;
        
        foreach ( attachment in objweapon.attachments )
        {
            attachmentscriptbundle = getscriptbundle( hashcat( %"hash_3c2c9813bb16552f", attachment ) );
            
            if ( isdefined( attachmentscriptbundle ) )
            {
                if ( attachmentscriptbundle.isamp )
                {
                    self.modifiers[ "weapon_has_AMP" ] = 1;
                    self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"amp" ) );
                }
                
                if ( attachmentscriptbundle.category == "CONVERSIONKIT" )
                {
                    self.modifiers[ "weapon_has_conversionkit" ] = 1;
                    self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"conversionkit" ) );
                }
                
                if ( attachmentscriptbundle.category == "OPTIC" || issubstr( attachment, "scope" ) )
                {
                    self.modifiers[ "weapon_has_scope" ] = 1;
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"hash_efa8718cf03a1110" ) );
                }
                
                usingsuppressor = issilencerattach( objweapon, attachment );
                
                if ( istrue( usingsuppressor ) )
                {
                    self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"suppressor" ) );
                }
                
                var_2a50ccbd8f4ebc5e = isdefined( objweapon.basename ) && isweapon( objweapon ) && objweapon.basename == "jup_amp_knifestab_mp";
                
                if ( isdefined( attachmentscriptbundle.baseref ) && ( issubstr( attachmentscriptbundle.baseref, "ub_gl" ) || issubstr( attachmentscriptbundle.baseref, "ub_sh" ) || issubstr( attachmentscriptbundle.baseref, "ub_flame" ) || issubstr( attachmentscriptbundle.baseref, "ub_saw" ) || var_2a50ccbd8f4ebc5e ) )
                {
                    if ( isdefined( objweapon.classname ) && ( objweapon.classname == "grenade" || objweapon.classname == "spread" || objweapon.classname == "projectile" ) || var_2a50ccbd8f4ebc5e )
                    {
                        self.modifiers[ "weapon_has_underbarrel" ] = 1;
                        self.modifiers[ "attachment_flags" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "attachment_flags" ], function_e2ff8f4b4e94f723( #"hash_1ce058287dc8c73b", #"underbarrel" ) );
                    }
                }
                
                if ( isdefined( attachmentscriptbundle.baseref ) && ( issubstr( attachmentscriptbundle.baseref, "akimbo" ) || attachmentscriptbundle.baseref == "jup_cp19_dm_sbeta_bar_1887_amp" ) )
                {
                    self.modifiers[ "weapon_has_akimbo" ] = 1;
                    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"akimbo" ) );
                }
                
                if ( isdefined( attachmentscriptbundle.baseref ) && issubstr( attachmentscriptbundle.baseref, "ammo" ) && isdefined( attachmentscriptbundle.category ) && attachmentscriptbundle.category == "GUNPERK" )
                {
                    self.modifiers[ "weapon_has_alternate_ammo" ] = 1;
                    self.modifiers[ "mask3" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask3" ], function_e2ff8f4b4e94f723( #"kill_bitfield3", #"hash_f9b754255057f953" ) );
                }
                
                if ( attachmentscriptbundle.category != "RECEIVER" && attachmentscriptbundle.category != "NONE" )
                {
                    var_a7b01beb1843361a++;
                }
            }
        }
        
        if ( var_a7b01beb1843361a >= 5 )
        {
            self.modifiers[ "fully_loaded_kill" ] = 1;
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"fully_loaded_kill" ) );
        }
        
        if ( var_a7b01beb1843361a == 0 )
        {
            self.modifiers[ "barebones_kill" ] = 1;
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"barebones_kill" ) );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 6
// Checksum 0x0, Offset: 0x8cae
// Size: 0x12ca
function killedplayer( killid, victim, objweapon, meansofdeath, inflictor, deathdata )
{
    curtime = gettime();
    objweapon = function_1e3102980c3a4cc1( objweapon );
    function_b7f154368abbe463( victim, objweapon, meansofdeath, inflictor, deathdata );
    
    if ( istrue( victim.islaststandbleedoutdmg ) && isdefined( victim.laststandattackermodifiers ) )
    {
        self.modifiers = victim.laststandattackermodifiers;
    }
    
    function_594be452ab6dd2d4( "poi_kill" );
    checkkillstreakkillevents( objweapon, meansofdeath, inflictor );
    thread checkfinalkillachievements( victim );
    victimguid = victim.guid;
    myguid = self.guid;
    fullweaponstring = getcompleteweaponname( objweapon );
    iskillstreakweapon = istrue( deathdata.iskillstreakweapon ) || scripts\mp\utility\killstreak::isjuggernaut();
    thread killedplayernotifysys( killid, victim, objweapon, meansofdeath );
    thread updaterecentkills( killid, victim, objweapon, fullweaponstring, iskillstreakweapon );
    thread updatec4vehiclemultkill( meansofdeath, inflictor );
    thread updateghostridekills();
    thread updatequadfeedcounter( self, killid, iskillstreakweapon );
    self.prevlastkilltime = self.lastkilltime;
    self.lastkilltime = curtime;
    self.lastkilledplayer = victim;
    self.lastkillvictimpos = victim.origin;
    
    if ( !isdefined( level.numkills ) )
    {
        level.numkills = 0;
    }
    else
    {
        level.numkills++;
    }
    
    if ( self.deaths > 0 )
    {
        kdr = self.kills / self.deaths;
        
        if ( kdr > 3 )
        {
            level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_kd_high", undefined, 0.75 );
        }
    }
    else if ( self.kills > 5 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_kd_high", undefined, 0.75 );
    }
    
    if ( istrue( self.laststanding ) )
    {
        incpersstat( "clutch", 1 );
    }
    
    self.damagedplayers[ victimguid ] = undefined;
    weapongroup = getweapongroup( objweapon.basename );
    hvtkill( victim );
    
    if ( istrue( self.modifiers[ "firstblood" ] ) )
    {
        firstblood( killid );
    }
    
    if ( istrue( self.modifiers[ "execution" ] ) && !istrue( scripts\mp\gametypes\war::function_2898a9c3d425a919() ) )
    {
        execution( killid );
    }
    
    if ( namespace_6c622b52017c6808::function_8ef404291ea37583( victim ) )
    {
        namespace_6c622b52017c6808::function_e01bc5dba2da7d6a( victim );
    }
    
    if ( !iskillstreakweapon( objweapon.basename ) && !_hasperk( "specialty_explosivebullets" ) )
    {
        if ( objweapon.basename == "none" && meansofdeath != "MOD_EXECUTION" )
        {
            return 0;
        }
        
        attackerisinflictor = attackerisinflictor( self, inflictor, objweapon, meansofdeath );
        
        if ( istrue( self.modifiers[ "oneshotkill" ] ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"one_shot_kill" );
            incpersstat( "oneShotOneKills", 1 );
        }
        
        if ( istrue( self.modifiers[ "gunbutt" ] ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"gun_butt" );
        }
        
        if ( meansofdeath == "MOD_MELEE" )
        {
            if ( objweapon.basename == "iw9_me_fists_mp" )
            {
                thread scripts\mp\utility\points::doscoreevent( #"fist_kill" );
            }
        }
        
        if ( istrue( self.modifiers[ "assistedsuicide" ] ) )
        {
            assistedsuicide( killid, objweapon );
        }
        
        if ( istrue( self.modifiers[ "comeback" ] ) )
        {
            comeback( killid );
        }
        
        if ( istrue( self.modifiers[ "headshot" ] ) )
        {
            level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_headshot", undefined, 0.75 );
            headshot( killid );
        }
        
        if ( isdefined( self.vehicle ) && isdefined( self.vehicle.combo ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"combo" );
        }
        
        if ( istrue( self.modifiers[ "posthumous" ] ) )
        {
            postdeathkill( killid );
        }
        
        if ( !isreallyalive( self ) && isdefined( self.deathtime ) )
        {
            timesincelastdeath = gettime() - self.deathtime;
            
            if ( issimultaneouskillenabled() )
            {
                if ( timesincelastdeath == 0 && isdefined( self.lastattacker ) && self.lastattacker == victim )
                {
                    thread scripts\mp\utility\points::doscoreevent( #"simultaneous_kill", undefined, undefined, undefined, undefined, 1 );
                    victim thread scripts\mp\utility\points::doscoreevent( #"simultaneous_kill", undefined, undefined, undefined, undefined, 1 );
                }
            }
        }
        
        if ( istrue( self.modifiers[ "avenger" ] ) )
        {
            avengedplayer( killid, victim.lastkilledplayer );
        }
        
        var_5737b6f741a2cfd9 = undefined;
        
        if ( victim isinexecutionattack() )
        {
            var_c962a2c5d41d3887 = utility::playersnear( victim.origin, 300 );
            
            foreach ( player in var_c962a2c5d41d3887 )
            {
                if ( player.team == self.team && player isinexecutionvictim() )
                {
                    var_5737b6f741a2cfd9 = player.guid;
                    defendedplayer( killid, player.guid );
                    break;
                }
            }
        }
        
        foreach ( guid, damagetime in victim.damagedplayers )
        {
            if ( guid == self.guid || guid == victim.guid )
            {
                continue;
            }
            
            if ( isdefined( var_5737b6f741a2cfd9 ) && guid == var_5737b6f741a2cfd9 )
            {
                continue;
            }
            
            if ( level.teambased && curtime - damagetime < 1750 )
            {
                defendedplayer( killid, guid );
            }
        }
        
        if ( istrue( self.modifiers[ "pointblank" ] ) )
        {
            thread pointblank( killid );
        }
        
        if ( istrue( self.modifiers[ "longshot" ] ) )
        {
            thread longshot( killid );
        }
        
        if ( istrue( self.modifiers[ "very_longshot" ] ) )
        {
            thread very_longshot( killid );
        }
        
        if ( istrue( self.modifiers[ "backstab" ] ) )
        {
            if ( objweapon.basename == "iw8_knife_mp" )
            {
                thread scripts\mp\utility\points::doscoreevent( #"backstab" );
            }
        }
        
        if ( istrue( self.modifiers[ "silencedKill" ] ) )
        {
            incpersstat( "silencedKills", 1 );
        }
        
        if ( attackerisinflictor )
        {
            switch ( weaponclass( objweapon.basename ) )
            {
                case #"hash_8cdaf2e4ecfe5b51":
                    incpersstat( "arKills", 1 );
                    victim incpersstat( "arDeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "arHeadshots", 1 );
                    }
                    
                    break;
                case #"hash_900cb96c552c5e8e":
                    incpersstat( "smgKills", 1 );
                    victim incpersstat( "smgDeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "smgHeadshots", 1 );
                    }
                    
                    break;
                case #"hash_690c0d6a821b42e":
                    incpersstat( "shotgunKills", 1 );
                    victim incpersstat( "shotgunDeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "shotgunHeadshots", 1 );
                    }
                    
                    break;
                case #"hash_fa24dff6bd60a12d":
                    incpersstat( "lmgKills", 1 );
                    victim incpersstat( "lmgDeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "lmgHeadshots", 1 );
                    }
                    
                    break;
                case #"hash_6191aaef9f922f96":
                    incpersstat( "sniperKills", 1 );
                    victim incpersstat( "sniperDeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "sniperHeadshots", 1 );
                    }
                    
                    break;
                case #"hash_61e969dacaaf9881":
                    incpersstat( "launcherKills", 1 );
                    victim incpersstat( "launcherDeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "launcherHeadshots", 1 );
                    }
                    
                    break;
                case #"hash_719417cb1de832b6":
                    incpersstat( "pistolKills", 1 );
                    victim incpersstat( "pistolPeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "pistolHeadshots", 1 );
                    }
                    
                    break;
            }
            
            if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" )
            {
                incpersstat( "meleeKills", 1 );
                victim incpersstat( "meleeDeaths", 1 );
            }
            
            if ( isdefined( level.supportdrones ) && level.supportdrones.size > 0 )
            {
                foreach ( drone in level.supportdrones )
                {
                    if ( isdefined( drone.owner ) && drone.owner == self && drone.helperdronetype == "radar_drone_overwatch" )
                    {
                        drone.owner incpersstat( "killstreakPersonalUAVKills", 1 );
                        break;
                    }
                }
            }
            
            if ( istrue( self.modifiers[ "low_health_kill" ] ) )
            {
                thread doscoreevent( #"low_health_kill" );
                level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_closecall", undefined, 1 );
            }
            
            if ( istrue( self.modifiers[ "ads" ] ) )
            {
                incpersstat( "adsKills", 1 );
            }
            else if ( istrue( self.modifiers[ "tac_stance" ] ) )
            {
                incpersstat( "tacStanceKills", 1 );
            }
            else if ( istrue( self.modifiers[ "hipfire" ] ) )
            {
                incpersstat( "hipfireKills", 1 );
            }
            
            if ( self ismantling() )
            {
                mantlekill();
            }
            
            if ( istrue( self.modifiers[ "backfire" ] ) )
            {
                backfire();
            }
        }
        
        if ( istrue( self.modifiers[ "air_to_air_kill" ] ) )
        {
            thread doscoreevent( #"air_to_air_kill" );
        }
        
        if ( istrue( self.modifiers[ "wallkill" ] ) )
        {
            thread doscoreevent( #"wallrun_kill" );
        }
        
        if ( istrue( self.modifiers[ "jumpkill" ] ) )
        {
            thread doscoreevent( #"air_kill" );
        }
        
        if ( istrue( self.modifiers[ "sliding" ] ) )
        {
            thread doscoreevent( #"slide_kill" );
        }
        
        if ( istrue( self.modifiers[ "killonwall" ] ) )
        {
            thread doscoreevent( #"kill_wallrunner" );
        }
        
        if ( istrue( self.modifiers[ "killinair" ] ) )
        {
            thread doscoreevent( #"kill_jumper" );
        }
        
        if ( istrue( self.modifiers[ "buzzkill" ] ) )
        {
            buzzkill( killid, victim );
        }
        
        if ( istrue( self.modifiers[ "impaired" ] ) )
        {
            impairedkill();
        }
        
        if ( istrue( self.var_bbcc5ab53663340a ) )
        {
            thread points::doscoreevent( #"supine_corkscrew" );
        }
        
        if ( isdefined( victim.stuckbygrenade ) )
        {
            level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_semtex", undefined, 0.75 );
        }
        
        if ( isthrowingknife( objweapon.basename ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"throwingknife_kill" );
        }
        
        function_2510f24c715782c3( killid, victim, objweapon, meansofdeath, inflictor, deathdata );
        
        if ( scripts\mp\gamescore::isdebuffedbyweaponandplayer( self, victim, "decoy_grenade_mp" ) )
        {
            scripts\mp\rank::scoreeventpopup( #"hash_b2f4241375a3dc69" );
        }
        
        if ( istrue( self.modifiers[ "kingslayer" ] ) && getgametype() != "ballmode" )
        {
            kingslayer( killid, victim );
            
            if ( getgametype() == "gun" && ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" ) )
            {
                thread scripts\mp\utility\points::doscoreevent( #"mode_gun_melee_1st_place" );
            }
        }
        
        if ( self.score < victim.score )
        {
            incpersstat( "higherRankedKills", 1 );
        }
        else
        {
            incpersstat( "lowerRankedKills", 1 );
        }
        
        cur_kill_streak = self.pers[ "cur_kill_streak" ] + 1;
        streaknum = 5;
        
        if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "brtdm" || level.gametype == "brtdm_mgl" )
        {
            streaknum = 10;
        }
        
        if ( istrue( level.gamemodebundle.var_198508771f0592a9 ) )
        {
            if ( cur_kill_streak > 1 && cur_kill_streak <= 30 )
            {
                thread scripts\mp\utility\points::doscoreevent( hashcat( #"streak_x", cur_kill_streak ) );
            }
            else if ( cur_kill_streak > 30 )
            {
                thread scripts\mp\utility\points::doscoreevent( #"streak_x30_plus" );
            }
        }
        else
        {
            if ( !( cur_kill_streak % streaknum ) )
            {
                if ( !isdefined( self.lastkillsplash ) || cur_kill_streak != self.lastkillsplash )
                {
                    thread teamplayercardsplash( "callout_kill_streaking", self, undefined, cur_kill_streak );
                    self.lastkillsplash = cur_kill_streak;
                }
                
                if ( cur_kill_streak <= 30 )
                {
                    thread scripts\mp\utility\points::doscoreevent( hashcat( #"streak_", cur_kill_streak ) );
                }
            }
            
            if ( cur_kill_streak > 30 )
            {
                thread scripts\mp\utility\points::doscoreevent( #"streak_max" );
            }
        }
        
        if ( istrue( self.modifiers[ "item_impact" ] ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"item_impact" );
        }
        
        if ( istrue( self.modifiers[ "launcher_impact" ] ) )
        {
            directimpactkill();
        }
        
        if ( getgametypenumlives() >= 1 )
        {
            if ( victim.pers[ "lives" ] == 0 )
            {
                thread scripts\mp\utility\points::doscoreevent( #"mode_x_eliminate", undefined, undefined, undefined, victim );
            }
            
            var_7774f401143eeccf = trygetlastpotentiallivingplayer();
            
            if ( isdefined( var_7774f401143eeccf ) && var_7774f401143eeccf == self )
            {
                thread scripts\mp\utility\points::doscoreevent( #"mode_x_last_alive", undefined, undefined, undefined, victim );
            }
        }
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && scripts\mp\flags::gameflag( "prematch_done" ) )
        {
            if ( self ispcplayer() )
            {
                self setclientomnvar( "nVidiaHighlights_events", 25 );
            }
            
            if ( victim ispcplayer() )
            {
                victim setclientomnvar( "nVidiaHighlights_events", 26 );
            }
        }
        
        checksuperkillevents( victim, inflictor, objweapon, meansofdeath, fullweaponstring );
        checksupershutdownevents( victim, objweapon, meansofdeath );
    }
    else if ( iskillstreakweapon( objweapon.basename ) || issuperweapon( objweapon.basename ) )
    {
        if ( issubstr( objweapon.basename, "laser_charge" ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"kill_v_power_laser" );
        }
    }
    
    tookdamage = 0;
    
    if ( isdefined( victim.damagedplayers ) && victim.damagedplayers.size != 0 )
    {
        for ( i = 0; i < victim.damagedplayers.size ; i++ )
        {
            damagedplayer = getarraykey( victim.damagedplayers, i );
            
            if ( isdefined( inflictor ) && is_equal( damagedplayer, inflictor.guid ) )
            {
                tookdamage = 1;
                break;
            }
        }
    }
    
    if ( !tookdamage )
    {
        cleankill();
    }
    
    if ( istrue( self.modifiers[ "revenge" ] ) )
    {
        self.lastkilledby = undefined;
        revenge( killid, victim );
    }
    
    if ( level.var_642e0047d274650a )
    {
        playfx( getfx( "money" ), victim.origin + ( 0, 0, 64 ) );
    }
    
    if ( !lpcfeaturegated() )
    {
        if ( !isdefined( self.killedplayers[ victimguid ] ) )
        {
            self.killedplayers[ victimguid ] = 0;
        }
        
        if ( !isdefined( victim.killedby[ myguid ] ) )
        {
            victim.killedby[ myguid ] = 0;
        }
        
        self.killedplayers[ victimguid ]++;
        victim.killedby[ myguid ]++;
    }
    
    victim.lastkilledby = self;
    
    if ( !lpcfeaturegated() && !level.multiteambased )
    {
        enemycount = 0;
        
        if ( level.teambased )
        {
            enemycount = getenemycount( self.team );
        }
        else
        {
            enemycount = level.players.size - 1;
        }
        
        if ( enemycount > 3 && self.killedplayers.size == enemycount )
        {
            currentcount = 0;
            
            if ( isdefined( self.pers[ "killEnemyTeam" ] ) )
            {
                currentcount = self.pers[ "killEnemyTeam" ];
            }
            
            shouldprogress = 1;
            
            foreach ( player, killcount in self.killedplayers )
            {
                if ( killcount <= currentcount )
                {
                    shouldprogress = 0;
                    break;
                }
            }
            
            if ( shouldprogress )
            {
                killentireenemyteam( killid );
            }
        }
    }
    
    if ( !victim isusingremote() )
    {
        victim thread setdof_killer();
    }
    
    victim scripts\mp\equipment\deployed_decoy::function_a22d831b624cccd2();
    bufferednotify( "kill_event_buffered", victim, fullweaponstring, meansofdeath, self.modifiers );
    thread scripts\mp\potg_events::onplayerkilled( self, inflictor, victim, meansofdeath, objweapon, deathdata.psoffsettime );
    thread function_f0c7425bd5a7050( victim, meansofdeath );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0x9f80
// Size: 0xc5
function function_594be452ab6dd2d4( event )
{
    if ( !isdefined( level.poi ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.var_2d8f8eb61d90e813 ) )
    {
        self.var_2d8f8eb61d90e813 = [];
    }
    
    if ( !isdefined( self.var_2d8f8eb61d90e813[ event ] ) )
    {
        self.var_2d8f8eb61d90e813[ event ] = [];
    }
    
    poiname = scripts\mp\poi::poi_findPOIOriginIsIn( self.origin );
    
    if ( !isdefined( poiname ) || !isdefined( level.poi[ poiname ] ) || !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
    {
        return 0;
    }
    
    calloutindex = level.poi[ poiname ][ "calloutIndex" ];
    
    if ( function_187f5e17657a02e2( event, calloutindex ) )
    {
        function_a4b605be380cd2fb( event, calloutindex );
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xa04d
// Size: 0x28, Type: bool
function function_187f5e17657a02e2( event, calloutindex )
{
    if ( isdefined( self.var_2d8f8eb61d90e813[ event ][ calloutindex ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xa07e
// Size: 0x2e
function function_a4b605be380cd2fb( event, calloutindex )
{
    self.var_2d8f8eb61d90e813[ event ][ calloutindex ] = 1;
    scripts\cp_mp\challenges::function_8359cadd253f9604( self, event, 1 );
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xa0b4
// Size: 0x6e5
function checkkillstreakkillevents( objweapon, meansofdeath, inflictor )
{
    iskillstreak = isdefined( objweapon ) && iskillstreakweapon( objweapon.basename ) || iskillstreakvehicleinflictor( inflictor ) || inflictor scripts\mp\utility\killstreak::isjuggernaut();
    forcekillstreak = isforcekillstreakprogressweapon( objweapon );
    
    if ( iskillstreak && !forcekillstreak )
    {
        if ( isdefined( inflictor ) && isdefined( inflictor.streakinfo ) )
        {
            cankillchain = 1;
            
            if ( isdefined( inflictor.streakinfo.mpstreaksysteminfo ) )
            {
                lifeidearned = inflictor.streakinfo.mpstreaksysteminfo.streaklifeid;
                lifeidcurrent = self.lifeid;
                
                if ( ( !isdefined( lifeidearned ) || lifeidearned != lifeidcurrent ) && !level.var_d11891ea093da336 )
                {
                    cankillchain = 0;
                }
                
                if ( inflictor.streakinfo.mpstreaksysteminfo.ownerxuid != self getxuid() )
                {
                    cankillchain = 0;
                }
            }
            
            if ( isdefined( inflictor.streakinfo.streakname ) )
            {
                givemidmatch = 0;
                isair = 0;
                isground = 0;
                killstreakname = inflictor.streakinfo.streakname;
                
                switch ( killstreakname )
                {
                    case #"hash_e477c24ee18bb2f6":
                        incpersstat( "killstreakTankKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_349713b5ad494dda":
                        incpersstat( "killstreakChopperGunnerKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_691f39dddd9116b8":
                        incpersstat( "killstreakChopperSupportKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_28d0236400e33fd0":
                        incpersstat( "killstreakCruiseMissileKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_4220be38a5f150b8":
                        givemidmatch = 1;
                        break;
                    case #"hash_413c38e72fe8b5bf":
                        incpersstat( "killstreakGunshipKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_bf2f9adbd2b41d5":
                        incpersstat( "killstreakVTOLJetKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_4ad475e6e15635bd":
                        incpersstat( "killstreakJuggernautKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_cd0a0403551fc411":
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_52d9b7ed584bec3e":
                        incpersstat( "killstreakShieldTurretKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_62810d05099e0103":
                        givemidmatch = 1;
                        break;
                    case #"hash_cf0ef5bef19a311b":
                        incpersstat( "killstreakWheelsonKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_8c766d6477287bb6":
                        incpersstat( "killstreakAirstrikeKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_4d5aa76e8707f47b":
                        incpersstat( "killstreakSentryGunKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_ab5712e297cd430e":
                        incpersstat( "killstreakRemoteTurretKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_b4ac3581c343a029":
                        incpersstat( "killstreakCluserStrikeKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_e6bea339d3cbd3e8":
                        incpersstat( "killstreakWhitePhosphorousKillsAssists", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_9e36e3bd3a9dd00d":
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_7a687f6a4d685110":
                        incpersstat( "killstreakSwitchbladeDroneKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_a1031216158c7882":
                        incpersstat( "killstreakLoiteringMunitionKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_472d8b6c2f51a9c8":
                        incpersstat( "killstreakIMSKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    case #"hash_48cc3a9a58208f82":
                        incpersstat( "killstreakDNANukeKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_153a98f7f08da00e":
                        incpersstat( "killstreakMissileDroneKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_b161e185f1b8e117":
                        incpersstat( "killstreakAutoDroneKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_887ad77192b9c4fb":
                        incpersstat( "killstreakAirdropEscortKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_6362d6aae3e5a62e":
                        incpersstat( "killstreakDroneSwarmKills", 1 );
                        givemidmatch = 1;
                        isair = 1;
                        break;
                    case #"hash_4d35eb58f9d545f0":
                        incpersstat( "killstreakClusterSpikeKills", 1 );
                        givemidmatch = 1;
                        isground = 1;
                        break;
                    default:
                        if ( !isdefined( level.var_5ef21d1318acecea ) )
                        {
                            level.var_5ef21d1318acecea = spawnstruct();
                            level.var_5ef21d1318acecea.iskillstreakkill = 1;
                        }
                        
                        if ( !istrue( level.gamemodebundle.var_198508771f0592a9 ) )
                        {
                            thread doscoreevent( #"hash_1387a1180e68dc64", objweapon, undefined, undefined, undefined, undefined, undefined, undefined, inflictor.streakinfo, undefined, level.var_5ef21d1318acecea );
                        }
                        
                        break;
                }
                
                if ( isdefined( inflictor.streakinfo.kills ) )
                {
                    inflictor.streakinfo.kills++;
                }
                
                incpersstat( "killstreakKills", 1 );
                
                if ( isair )
                {
                    incpersstat( "killstreakAirKills", 1 );
                }
                
                if ( isground )
                {
                    incpersstat( "killstreakGroundKills", 1 );
                }
                
                if ( givemidmatch )
                {
                    event = hashcat( #"ss_kill_", killstreakname );
                    pointsoverride = undefined;
                    
                    if ( cankillchain && _hasperk( "specialty_chain_killstreaks" ) )
                    {
                        pointsoverride = scripts\mp\rank::getscoreinfovalue( event );
                    }
                    
                    dontwait = 1;
                    
                    if ( !isdefined( level.var_5ef21d1318acecea ) )
                    {
                        level.var_5ef21d1318acecea = spawnstruct();
                        level.var_5ef21d1318acecea.iskillstreakkill = 1;
                    }
                    
                    thread scripts\mp\utility\points::doscoreevent( event, objweapon, pointsoverride, undefined, undefined, dontwait, undefined, cankillchain, inflictor.streakinfo, undefined, level.var_5ef21d1318acecea );
                }
                
                level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_killstreak", undefined, 0.75 );
            }
        }
    }
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xa7a1
// Size: 0xa5
function function_3e2ff5954aacaa33( objweapon, meansofdeath, inflictor )
{
    if ( ( iskillstreakweapon( objweapon.basename ) || iskillstreakvehicleinflictor( inflictor ) ) && !isforcekillstreakprogressweapon( objweapon ) && isdefined( inflictor ) && isdefined( inflictor.streakinfo ) && isdefined( inflictor.streakinfo.streakname ) && isdefined( inflictor.streakinfo.kills ) )
    {
        inflictor.streakinfo.kills++;
    }
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0xa84e
// Size: 0xf7
function checksuperkillevents( victim, inflictor, objweapon, meansofdeath, fullweaponstring )
{
    superinuse = scripts\mp\supers::issuperinuse();
    superref = scripts\mp\supers::getcurrentsuperref();
    super = scripts\mp\supers::getcurrentsuper();
    superweapon = issuperweapon( objweapon.basename );
    score_ref = undefined;
    
    if ( !isdefined( superref ) )
    {
        return;
    }
    
    if ( superweapon )
    {
        thread killedplayerwithsuperweapon( victim, inflictor, objweapon, meansofdeath, fullweaponstring );
        
        if ( meansofdeath != "MOD_MELEE" )
        {
            bufferednotify( "super_kill_buffered" );
        }
    }
    
    var_7d701a3f18f52454 = 0;
    
    if ( isdefined( superref ) )
    {
        if ( var_7d701a3f18f52454 )
        {
            thread superkill( superref, meansofdeath );
            scripts\mp\supers::combatrecordsuperkill( superref );
            
            if ( isdefined( score_ref ) )
            {
                thread doscoreevent( score_ref );
            }
            
            bufferednotify( "super_kill_buffered" );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xa94d
// Size: 0x66
function checksupershutdownevents( victim, objweapon, meansofdeath )
{
    var_727e0f6c828adf76 = victim scripts\mp\supers::issuperinuse();
    var_8550e94c928e5cdd = victim scripts\mp\supers::getcurrentsuperref();
    victimsuper = victim scripts\mp\supers::getcurrentsuper();
    
    if ( !isdefined( var_8550e94c928e5cdd ) )
    {
        return;
    }
    
    if ( var_727e0f6c828adf76 == 1 )
    {
        thread supershutdown( victim );
    }
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0xa9bb
// Size: 0xa3
function killedplayerwithsuperweapon( victim, inflictor, objweapon, meansofdeath, fullweaponstring )
{
    superref = scripts\mp\supers::getsuperrefforsuperweapon( objweapon );
    var_398a9d42af1d5e5f = self.recentkillsperweapon[ fullweaponstring ];
    
    if ( isdefined( var_398a9d42af1d5e5f ) && var_398a9d42af1d5e5f > 0 && var_398a9d42af1d5e5f % 2 == 0 )
    {
        superkill( superref, meansofdeath );
    }
    else
    {
        var_f5f7b5e4219a0145 = scripts\mp\supers::getcurrentsuper();
        var_f5f7b5e4219a0145.numkills++;
    }
    
    scripts\cp_mp\challenges::updatesuperweaponkills( objweapon, inflictor );
    scripts\mp\supers::combatrecordsuperkill( superref );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xaa66
// Size: 0xd6
function superkill( superref, meansofdeath )
{
    rootsuperref = scripts\mp\supers::getrootsuperref( superref );
    medalref = hashcat( #"super_kill_", rootsuperref );
    
    if ( scripts\mp\rank::function_377a94f711d96927( medalref ) )
    {
        if ( !isdefined( level.var_b4e942edb1952ca1 ) )
        {
            level.var_b4e942edb1952ca1 = spawnstruct();
            level.var_b4e942edb1952ca1.var_3a13c58c2a354968 = 1;
        }
        
        thread scripts\mp\utility\points::doscoreevent( medalref, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, level.var_b4e942edb1952ca1 );
    }
    
    var_f5f7b5e4219a0145 = scripts\mp\supers::getcurrentsuper();
    var_f5f7b5e4219a0145.numkills++;
    scripts\cp_mp\challenges::updatesuperkills( superref, meansofdeath, var_f5f7b5e4219a0145.numkills );
    self.modifiers[ "super_kill_medal" ] = superref;
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xab44
// Size: 0xb8
function killedkillstreak( killstreakname, killer, objweapon )
{
    awardname = hashcat( #"kill_ss_", killstreakname );
    
    if ( isdefined( objweapon ) && weaponclass( objweapon ) != "rocketlauncher" && objweapon.basename != "iw8_la_kgolf_mp" )
    {
        objweapon = undefined;
    }
    
    eventinfo = spawnstruct();
    eventinfo.isdestroyedkillstreak = 1;
    killer thread scripts\mp\utility\points::doscoreevent( awardname, objweapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    killer incpersstat( "destroyedKillstreaks", 1 );
    level thread scripts\mp\battlechatter_mp::saytoself( killer, "plr_killstreak_destroy", undefined, 0.75 );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xac04
// Size: 0x7a
function processscrapassist( killer )
{
    scrapassistplayers = scripts\mp\killstreaks\killstreaks::getscrapassistplayers( killer );
    
    foreach ( player in scrapassistplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread doscoreevent( #"scrap_assist" );
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xac86
// Size: 0x86, Type: bool
function is_enemy_highest_score( enemy, enemies )
{
    if ( !isdefined( enemy.score ) )
    {
        return false;
    }
    
    foreach ( e in enemies )
    {
        if ( e.score > enemy.score )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0xad15
// Size: 0x218
function getshotdistancetype( attacker, objweapon, meansofdeath, attackerposition, var_4409ff2b093ccdde )
{
    if ( isalive( attacker ) && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_MELEE_TAKEDOWN" && !attacker isusingremote() && ( isprimaryweapon( objweapon ) || iscacsecondaryweapon( objweapon ) || isthrowingknife( objweapon ) ) && !iskillstreakweapon( objweapon.basename ) && !istrue( attacker.assistedsuicide ) )
    {
        killdistsq = distancesquared( attackerposition, var_4409ff2b093ccdde );
        
        if ( killdistsq < 9216 )
        {
            return "pointblank";
        }
        
        if ( killdistsq > 4000000 )
        {
            return "very_longshot";
        }
        
        var_a77e978567103b98 = getweapongroup( objweapon.basename );
        longshotdist = undefined;
        
        switch ( var_a77e978567103b98 )
        {
            case #"hash_34340d457a63e7f1":
                longshotdist = 800;
                break;
            case #"hash_ab10f9c080fe4faf":
            case #"hash_c9c190665b9c4a1d":
                longshotdist = 1200;
                break;
            case #"hash_bef5ec0b3e197ae":
            case #"hash_47368bc0d2ef1565":
            case #"hash_8af0086b038622b5":
            case #"hash_dd616da0b395a0b0":
                if ( objweapon.basename == "iw9_dm_crossbow_mp" )
                {
                    longshotdist = 1200;
                }
                else
                {
                    longshotdist = 1500;
                }
                
                break;
            case #"hash_46b22b021532342e":
            case #"hash_c095d67337b1f5a1":
                longshotdist = 2000;
                break;
            case #"hash_16cf6289ab06bd30":
                longshotdist = 500;
                break;
            case #"hash_9d18adab1b65a661":
                longshotdist = 1200;
                break;
            case #"hash_f4cd588fc5c3d2d5":
                longshotdist = 1969;
                break;
            default:
                longshotdist = 1536;
                break;
        }
        
        longshotdistsq = longshotdist * longshotdist;
        
        if ( killdistsq > longshotdistsq )
        {
            return "longshot";
        }
    }
    
    return "none";
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xaf36
// Size: 0x13e, Type: bool
function islongshotspecial( attackerposition, var_4409ff2b093ccdde, objweapon )
{
    killdistsq = distancesquared( attackerposition, var_4409ff2b093ccdde );
    var_a77e978567103b98 = getweapongroup( objweapon.basename );
    longshotdist = undefined;
    
    switch ( var_a77e978567103b98 )
    {
        case #"hash_34340d457a63e7f1":
            longshotdist = 1500;
            break;
        case #"hash_ab10f9c080fe4faf":
        case #"hash_c9c190665b9c4a1d":
            longshotdist = 2000;
            break;
        case #"hash_47368bc0d2ef1565":
            longshotdist = 4000;
            break;
        case #"hash_bef5ec0b3e197ae":
        case #"hash_8af0086b038622b5":
        case #"hash_dd616da0b395a0b0":
            longshotdist = 3000;
            break;
        case #"hash_46b22b021532342e":
        case #"hash_c095d67337b1f5a1":
            longshotdist = 8000;
            break;
        case #"hash_16cf6289ab06bd30":
            longshotdist = 1000;
            break;
        case #"hash_9d18adab1b65a661":
            longshotdist = 4000;
            break;
        default:
            longshotdist = 4000;
            break;
    }
    
    longshotdistsq = longshotdist * longshotdist;
    return killdistsq > longshotdistsq;
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0xb07d
// Size: 0x78, Type: bool
function isdeathfromabove( attacker, objweapon, meansofdeath, attackerposition, victim )
{
    if ( isalive( attacker ) && attacker isjumping() && isbulletdamage( meansofdeath ) )
    {
        deltaheight = attacker.origin[ 2 ] - victim.origin[ 2 ];
        return ( deltaheight > 60 );
    }
    
    return false;
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xb0fe
// Size: 0x78, Type: bool
function function_78dbf8d8bcbed882( attacker, objweapon, victim )
{
    if ( isalive( attacker ) && !attacker isonground() )
    {
        if ( ( isprimaryweapon( objweapon ) || iscacsecondaryweapon( objweapon ) || isthrowingknife( objweapon ) ) && !iskillstreakweapon( objweapon.basename ) && !istrue( attacker.assistedsuicide ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0xb17f
// Size: 0x46, Type: bool
function isskeetshooter( attacker, objweapon, meansofdeath, attackerposition, victim )
{
    return isalive( attacker ) && victim isjumping() && isbulletdamage( meansofdeath );
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xb1ce
// Size: 0xc8, Type: bool
function isbackkill( attacker, victim, meansofdeath )
{
    if ( !isplayer( attacker ) || !isplayer( victim ) )
    {
        return false;
    }
    
    if ( meansofdeath != "MOD_RIFLE_BULLET" && meansofdeath != "MOD_PISTOL_BULLET" && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_HEAD_SHOT" && meansofdeath != "MOD_IMPACT" && !scripts\mp\weapons::function_d24bf01d284ef941( attacker.currentweapon ) )
    {
        return false;
    }
    
    victimangles = victim getplayerangles();
    attackerangles = attacker getplayerangles();
    anglediff = angleclamp180( victimangles[ 1 ] - attackerangles[ 1 ] );
    
    if ( abs( anglediff ) < 80 )
    {
        return true;
    }
    
    return false;
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb29f
// Size: 0x39, Type: bool
function issurvivorkill( player )
{
    return player.health > 0 && player.health < player.maxhealth * 0.5;
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xb2e1
// Size: 0xa0, Type: bool
function isdetected( attacker, victim )
{
    issnapshotted = isdefined( victim.lastsnapshotgrenadetime ) && victim.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::function_905247d1b30c84f1() > gettime();
    var_bc1d14d99eaa6485 = isdefined( attacker.radarstrength ) && attacker.radarstrength > 3 && !victim _hasperk( "specialty_br_ghost" );
    var_abee336ea25765c6 = istrue( victim.var_abee336ea25765c6 );
    return issnapshotted || var_bc1d14d99eaa6485 || var_abee336ea25765c6;
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb38a
// Size: 0x2e
function proximityassist( killid )
{
    self.modifiers[ "proximityAssist" ] = 1;
    thread doscoreevent( #"proximityassist" );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb3c0
// Size: 0x2e
function proximitykill( killid )
{
    self.modifiers[ "proximityKill" ] = 1;
    thread doscoreevent( #"proximitykill" );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb3f6
// Size: 0x41
function longshot( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "longshot" );
    incpersstat( "longshotKills", 1 );
    thread scripts\mp\utility\points::doscoreevent( #"longshot" );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb43f
// Size: 0x21
function very_longshot( killid )
{
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_headshotlong", undefined, 1 );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb468
// Size: 0x41
function pointblank( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "pointblank" );
    thread scripts\mp\utility\points::doscoreevent( #"pointblank" );
    incpersstat( "pointBlankKills", 1 );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb4b1
// Size: 0x45
function headshot( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "headshot" );
    thread scripts\mp\utility\points::doscoreevent( #"headshot" );
    thread killeventtextpopup( #"headshot", 0 );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xb4fe
// Size: 0x49
function avengedplayer( killid, lastvictim )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "avenger" );
    incpersstat( "avengerKills", 1 );
    thread scripts\mp\utility\points::doscoreevent( #"avenger" );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xb54f
// Size: 0x3c
function assistedsuicide( killid, objweapon )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assistedsuicide" );
    thread scripts\mp\utility\points::doscoreevent( #"assistedsuicide", objweapon );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xb593
// Size: 0x71
function defendedplayer( killid, guid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "defender" );
    incpersstat( "defenderKills", 1 );
    thread killeventtextpopup( #"save_teammate", 0 );
    thread scripts\mp\utility\points::doscoreevent( #"save_teammate" );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_save", undefined, 1 );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb60c
// Size: 0x33
function postdeathkill( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "posthumous" );
    thread scripts\mp\utility\points::doscoreevent( #"posthumous" );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xb647
// Size: 0x89
function revenge( killid, victim )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "revenge" );
    incpersstat( "revengeKills", 1 );
    thread scripts\mp\utility\points::doscoreevent( #"revenge" );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_revenge", undefined, 1 );
    playfx( getfx( "money" ), victim.origin + ( 0, 0, 64 ) );
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0xb6d8
// Size: 0x2a3
function multikill( killid, killcount, var_c95c893c15217527, var_5af31c1555eb14b1, iskillstreakweapon )
{
    assert( killcount > 1 );
    
    if ( !isdefined( self.currentmultikill ) )
    {
        self.currentmultikill = killcount;
    }
    
    if ( killcount < self.currentmultikill )
    {
        return;
    }
    
    self notify( "multiKill" );
    self endon( "multiKill" );
    self endon( "disconnect" );
    waitframe();
    award = undefined;
    teamsplash = undefined;
    
    switch ( killcount )
    {
        case 2:
            award = #"double";
            break;
        case 3:
            award = #"triple";
            teamsplash = "callout_3xkill";
            break;
        case 4:
            award = #"four";
            teamsplash = "callout_4xkill";
            break;
        case 5:
            award = #"five";
            teamsplash = "callout_5xkill";
            break;
        case 6:
            award = #"six";
            teamsplash = "callout_6xkill";
            break;
        case 7:
            award = #"seven";
            teamsplash = "callout_7xkill";
            break;
        case 8:
            award = #"eight";
            teamsplash = "callout_8xkill";
            break;
        default:
            award = #"multi";
            teamsplash = "callout_9xkill";
            break;
    }
    
    if ( isdefined( self.pers[ "totalMultikills" ] ) )
    {
        incpersstat( "totalMultikills", 1 );
    }
    
    if ( isdefined( self.pers[ "highestMultikill" ] ) && killcount > self.pers[ "highestMultikill" ] )
    {
        self.pers[ "highestMultikill" ] = killcount;
        scripts\mp\codcasterclientmatchdata::function_7ee466e81b1afc12( 10, killcount );
    }
    
    thread utility::trycall( level.matchdata_logmultikill, killid, killcount );
    
    if ( isdefined( award ) )
    {
        var_5af31c1555eb14b1 = istrue( var_5af31c1555eb14b1 );
        thread killeventtextpopup( award, isdefined( var_c95c893c15217527 ) ? var_c95c893c15217527 : 1, var_5af31c1555eb14b1 );
        
        if ( !var_5af31c1555eb14b1 )
        {
            self.currentmultikill = killcount;
            scripts\cp_mp\challenges::function_e6ba0866eca5b87b( self, iskillstreakweapon );
            
            if ( istrue( iskillstreakweapon ) )
            {
                eventinfo = { #var_f02e60455d9ce50f:iskillstreakweapon };
                thread scripts\mp\utility\points::doscoreevent( award, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
            }
            else
            {
                thread scripts\mp\utility\points::doscoreevent( award );
            }
        }
    }
    
    if ( isdefined( teamsplash ) )
    {
        if ( !var_5af31c1555eb14b1 )
        {
            if ( scripts\cp_mp\utility\game_utility::function_22cd3d64fdb05892() )
            {
                return;
            }
            
            thread teamplayercardsplash( teamsplash, self );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb983
// Size: 0x62
function firstblood( killid )
{
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c( 11, self.team, self getentitynumber() );
    }
    
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "firstblood" );
    thread teamplayercardsplash( "callout_firstblood", self );
    thread scripts\mp\utility\points::doscoreevent( #"firstblood" );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xb9ed
// Size: 0x69
function hvtkill( victim )
{
    if ( isdefined( victim.bountyobject ) )
    {
        self.modifiers[ "hvtKill" ] = 1;
        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"victim_hvt" ) );
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xba5e
// Size: 0x69
function buzzkill( killid, victim )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "buzzkill" );
    thread scripts\mp\utility\points::doscoreevent( #"buzzkill" );
    
    if ( scripts\cp_mp\utility\killstreak_utility::function_9f1dc821e9a8506() && getdvarint( @"hash_ee6087278c7605f6", 1 ) == 1 )
    {
        thread scripts\mp\killstreaks\killstreaks::function_ee6caf8414e3b231( "buzzkill", victim );
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xbacf
// Size: 0x13
function impairedkill()
{
    thread scripts\mp\utility\points::doscoreevent( #"stunned_kill" );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbaea
// Size: 0x41
function comeback( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "comeback" );
    thread scripts\mp\utility\points::doscoreevent( #"comeback" );
    incpersstat( "comebackKills", 1 );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbb33
// Size: 0xba
function supershutdown( victim )
{
    rootsuperref = scripts\mp\supers::getrootsuperref( victim.super.staticdata.ref );
    self.modifiers[ "superShutdown" ] = victim.super.staticdata.ref;
    medalref = hashcat( #"hash_499e8b2730bb3818", rootsuperref );
    
    switch ( rootsuperref )
    {
        case #"hash_438c49412523936e":
            medalref = #"super_shutdown_bull_charge";
            break;
    }
    
    if ( scripts\mp\rank::function_377a94f711d96927( medalref ) )
    {
        thread scripts\mp\utility\points::doscoreevent( medalref );
    }
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbbf5
// Size: 0x5e
function collateral( numkills )
{
    if ( numkills == 2 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_twofer", undefined, 0.75 );
        thread scripts\mp\utility\points::doscoreevent( #"one_shot_two_kills" );
    }
    
    if ( numkills == 3 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_threefer", undefined, 0.75 );
    }
    
    thread scripts\mp\potg_events::collateral( self, numkills );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbc5b
// Size: 0x15
function shotguncollateral( numkills )
{
    thread scripts\mp\potg_events::shotguncollateral( self, numkills );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xbc78
// Size: 0x13
function mantlekill()
{
    thread scripts\mp\utility\points::doscoreevent( #"mantle_kill" );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xbc93
// Size: 0x13
function backfire()
{
    thread scripts\mp\utility\points::doscoreevent( #"backfire" );
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xbcae
// Size: 0xb5
function quadfeed( killid, struct, iskillstreakweapon )
{
    self.modifiers[ "quadfeed" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"quadfeed" ) );
    eventinfo = { #var_f02e60455d9ce50f:iskillstreakweapon };
    thread scripts\mp\utility\points::doscoreevent( #"quad_feed", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    thread scripts\mp\potg_events::quadfeed( self, struct.starttime, gettime() );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbd6b
// Size: 0x68
function killentireenemyteam( killid )
{
    self.modifiers[ "killEnemyTeam" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"killenemyteam" ) );
    incpersstat( "killEnemyTeam", 1 );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xbddb
// Size: 0x60
function kingslayer( killid, victim )
{
    thread scripts\mp\utility\points::doscoreevent( #"first_place_kill" );
    incpersstat( "highestRankedKills", 1 );
    
    if ( scripts\cp_mp\utility\killstreak_utility::function_9f1dc821e9a8506() && getdvarint( @"hash_ee6087278c7605f6", 1 ) == 1 )
    {
        thread scripts\mp\killstreaks\killstreaks::function_ee6caf8414e3b231( "kingslayer", victim );
    }
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbe43
// Size: 0x1c
function directimpactkill( killid )
{
    thread scripts\mp\utility\points::doscoreevent( #"launcher_direct_hit" );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbe67
// Size: 0x5a
function tripledefenderkill( killid )
{
    self.modifiers[ "tripledefenderkill" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"defender" ) );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xbec9
// Size: 0x2a
function execution( killid )
{
    incpersstat( "executions", 1 );
    thread doscoreevent( #"execution" );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xbefb
// Size: 0x51
function cleankill()
{
    self.modifiers[ "cleanKill" ] = 1;
    self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"clean_kill" ) );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xbf54
// Size: 0xa4
function disconnected()
{
    myguid = self.guid;
    
    if ( !lpcfeaturegated() )
    {
        for ( entry = 0; entry < level.players.size ; entry++ )
        {
            if ( isdefined( level.players[ entry ].killedplayers[ myguid ] ) )
            {
                level.players[ entry ].killedplayers[ myguid ] = undefined;
            }
            
            if ( isdefined( level.players[ entry ].killedby[ myguid ] ) )
            {
                level.players[ entry ].killedby[ myguid ] = undefined;
            }
        }
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc000
// Size: 0x43
function monitorhealed()
{
    if ( scripts\mp\rank::function_377a94f711d96927( "healed" ) == 0 )
    {
        return;
    }
    
    level endon( "end_game" );
    
    for ( ;; )
    {
        level waittill( "healed", player );
        player thread doscoreevent( #"healed" );
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc04b
// Size: 0xe1
function function_6cdce3cb6d284ccc()
{
    self notify( "start_monitor_tac_sprint_distance" );
    self endon( "start_monitor_tac_sprint_distance" );
    self endon( "death_or_disconnect" );
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_fade_done" );
    
    if ( !isdefined( level.var_d8a722a7f1e3c8fa ) )
    {
        level.var_d8a722a7f1e3c8fa = getdvarint( @"hash_759733fa83683a72", 50 );
    }
    
    if ( !isdefined( self.var_cef541563417ad98 ) )
    {
        self.var_cef541563417ad98 = 0;
    }
    
    var_4b522af6fe9216ff = 0;
    var_f3607531286c955e = undefined;
    
    while ( true )
    {
        if ( self issupersprinting() )
        {
            if ( istrue( var_4b522af6fe9216ff ) && isdefined( var_f3607531286c955e ) )
            {
                self.var_cef541563417ad98 += function_6c6d2a633d30b5af( var_f3607531286c955e, self.origin );
                function_f4fa8b16599b57d7();
            }
            else
            {
                var_4b522af6fe9216ff = 1;
            }
            
            var_f3607531286c955e = self.origin;
        }
        else if ( var_4b522af6fe9216ff )
        {
            var_4b522af6fe9216ff = 0;
        }
        
        wait 0.1;
    }
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xc134
// Size: 0xb0
function function_f4fa8b16599b57d7( var_c80580e9b1df3347 )
{
    if ( !isdefined( self ) || !isplayer( self ) || !scripts\cp_mp\challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( self.var_cef541563417ad98 ) )
    {
        self.var_cef541563417ad98 = 0;
    }
    
    if ( !isdefined( self.var_20af0abdf2193d84 ) )
    {
        self.var_20af0abdf2193d84 = 0;
    }
    
    var_83e1b1883e461c6 = int( self.var_cef541563417ad98 - self.var_20af0abdf2193d84 );
    
    if ( !istrue( var_c80580e9b1df3347 ) && var_83e1b1883e461c6 < level.var_d8a722a7f1e3c8fa )
    {
        return;
    }
    
    scripts\cp_mp\challenges::function_8359cadd253f9604( self, "tac_sprint_meter_distance", var_83e1b1883e461c6 );
    self.var_20af0abdf2193d84 += var_83e1b1883e461c6;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc1ec
// Size: 0x75
function function_17427c943364b13f()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( !scripts\cp_mp\challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    startpos = self.origin;
    
    for ( lastpos = startpos; istrue( self.var_f838d1e2c565dfe1 ) ; lastpos = self.origin )
    {
        waitframe();
        
        if ( isdefined( self ) && isreallyalive( self ) )
        {
        }
    }
    
    if ( startpos != lastpos )
    {
        function_34d6519a0f923c94( startpos, lastpos );
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xc269
// Size: 0x41
function function_34d6519a0f923c94( startpos, lastpos )
{
    var_83e1b1883e461c6 = int( function_6c6d2a633d30b5af( startpos, lastpos ) );
    
    if ( var_83e1b1883e461c6 <= 0 )
    {
        return;
    }
    
    scripts\cp_mp\challenges::function_8359cadd253f9604( self, "ascender_zipline_meter_distance", var_83e1b1883e461c6 );
}

// Namespace events / scripts\mp\events
// Params 5
// Checksum 0x0, Offset: 0xc2b2
// Size: 0x281
function updaterecentkills( killid, victim, objweapon, fullweaponstring, iskillstreakweapon )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "updateRecentKills" );
    self endon( "updateRecentKills" );
    self.recentkillcount++;
    
    if ( isdefending( victim ) )
    {
        self.recentdefendcount++;
        
        if ( isnumbermultipleof( self.recentdefendcount, 2 ) && !ismutationgamemode() )
        {
            thread scripts\mp\utility\points::doscoreevent( #"mode_x_wipeout" );
        }
    }
    
    if ( isassaulting( victim ) )
    {
        self.recentassaultcount++;
        
        if ( isnumbermultipleof( self.recentassaultcount, 3 ) )
        {
            tripledefenderkill( killid );
        }
    }
    
    if ( !isdefined( self.recentkillsperweapon ) )
    {
        self.recentkillsperweapon = [];
    }
    
    if ( !isdefined( self.recentkillsperweapon[ fullweaponstring ] ) )
    {
        self.recentkillsperweapon[ fullweaponstring ] = 1;
    }
    else
    {
        self.recentkillsperweapon[ fullweaponstring ]++;
    }
    
    weaponinfo = getequipmenttype( objweapon );
    
    if ( isdefined( weaponinfo ) && weaponinfo == "lethal" && !isthrowingknife( objweapon ) )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_grenade", undefined, 0.75 );
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_amf", undefined, 0.75 );
        
        if ( self.recentkillsperweapon[ fullweaponstring ] > 0 && self.recentkillsperweapon[ fullweaponstring ] % 2 == 0 )
        {
            thread scripts\mp\utility\points::doscoreevent( #"grenade_double" );
        }
    }
    
    bufferednotify( "update_rapid_kill_buffered", self.recentkillcount, fullweaponstring );
    
    if ( !isdefined( self.recentkillcount ) )
    {
        self.recentkillcount = 0;
    }
    
    if ( self.recentkillcount > 1 )
    {
        thread multikill( killid, self.recentkillcount, 0, undefined, iskillstreakweapon );
    }
    
    wait 4;
    
    if ( self.recentkillcount > 1 )
    {
        thread multikill( killid, self.recentkillcount, 1, 1, iskillstreakweapon );
        
        if ( self.recentkillcount > 2 )
        {
            if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
            {
                namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c( 12, self.team, self getentitynumber(), self.recentkillcount );
            }
        }
    }
    
    incpersstat( "mostMultikills", 1 );
    self.currentmultikill = 0;
    self.recentkillcount = 0;
    self.recentdefendcount = 0;
    self.recentkillsperweapon = undefined;
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xc53b
// Size: 0x4b
function updatec4vehiclemultkill( meansofdeath, inflictor )
{
    paramstruct = spawnstruct();
    paramstruct.meansofdeath = meansofdeath;
    paramstruct.inflictor = inflictor;
    scripts\mp\gametypes\br_challenges::challengeevaluator( "br_mastery_c4VehicleMultKill", paramstruct );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc58e
// Size: 0x2e
function updateghostridekills()
{
    paramstruct = spawnstruct();
    paramstruct.maderecentkill = 1;
    scripts\mp\gametypes\br_challenges::challengeevaluator( "br_mastery_ghostRideWhip", paramstruct );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc5c4
// Size: 0x61
function monitorcratejacking()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "hijacker", cratetype, owner );
        thread scripts\mp\utility\points::doscoreevent( #"hash_519e0923d0608694" );
        splashname = "hijacked_airdrop";
        
        if ( isdefined( owner ) )
        {
            owner scripts\mp\hud_message::showsplash( splashname, undefined, self );
        }
    }
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xc62d
// Size: 0x10b
function updatequadfeedcounter( attacker, killid, iskillstreakweapon )
{
    if ( isdefined( level.quadfeedinfo ) && gettime() - level.quadfeedinfo.starttime > 10000 )
    {
        level.quadfeedinfo = undefined;
    }
    
    if ( !isdefined( level.quadfeedinfo ) || level.quadfeedinfo.player != attacker )
    {
        struct = spawnstruct();
        struct.player = attacker;
        struct.starttime = gettime();
        struct.feedcount = 1;
        level.quadfeedinfo = struct;
        return;
    }
    
    struct = level.quadfeedinfo;
    struct.feedcount++;
    
    if ( struct.feedcount == 4 )
    {
        struct.player quadfeed( killid, struct, iskillstreakweapon );
        level.quadfeedinfo = undefined;
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc740
// Size: 0x34
function initslidemonitor()
{
    self.eventswassliding = self issprintsliding();
    self.eventsslideendtime = undefined;
    self.var_487218883ba859bb = self issprinting();
    self.var_887efc1f015b6a78 = undefined;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc77c
// Size: 0xb9
function events_monitorslideupdate()
{
    if ( isreallyalive( self ) )
    {
        eventsissliding = self issprintsliding();
        
        if ( istrue( self.eventswassliding ) && !eventsissliding )
        {
            self.eventsslideendtime = gettime();
            scripts\mp\potg::processevent( "recent_slide" );
        }
        
        self.eventswassliding = eventsissliding;
        eventsissprinting = self issprinting();
        
        if ( istrue( self.var_487218883ba859bb ) && !eventsissprinting )
        {
            self.var_887efc1f015b6a78 = gettime();
        }
        
        self.var_487218883ba859bb = eventsissprinting;
        return;
    }
    
    self.eventswassliding = 0;
    self.eventsslideendtime = undefined;
    self.var_487218883ba859bb = 0;
    self.var_887efc1f015b6a78 = undefined;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc83d
// Size: 0x3b, Type: bool
function events_issliding()
{
    if ( self issprintsliding() )
    {
        return true;
    }
    
    events_monitorslideupdate();
    
    if ( isdefined( self.eventsslideendtime ) )
    {
        if ( gettime() - self.eventsslideendtime <= 150 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc881
// Size: 0x1b
function initmonitoradstime()
{
    self.wasads = isplayerads();
    self.lastadsstarttime = 0;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc8a4
// Size: 0x61
function monitoradstime()
{
    if ( isplayerads() )
    {
        if ( !self.wasads )
        {
            self.lastadsstarttime = gettime();
            self.wasads = 1;
            self clearsoundsubmix( "hit_indicator_hipfire" );
        }
        
        return;
    }
    
    if ( self.wasads )
    {
        self setsoundsubmix( "hit_indicator_hipfire" );
    }
    
    self.wasads = 0;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc90d
// Size: 0x9e
function monitorreload()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.lastreloadtime = 0;
    
    while ( true )
    {
        self waittill( "reload" );
        objweapon = self getcurrentweapon();
        scripts\cp_mp\challenges::function_b4b8d881af22f7bd( self, objweapon );
        self.lastreloadtime = gettime();
        incpersstat( "reloads", 1 );
        
        if ( isdefined( self.var_c78bf6b063fc5789 ) )
        {
            self.var_c78bf6b063fc5789 = 0;
        }
        
        self.var_1949291e417ccc24 = isdefined( self.var_1949291e417ccc24 ) ? self.var_1949291e417ccc24 + 1 : 0;
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xc9b3
// Size: 0x45
function function_3403058663ef4843()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    while ( true )
    {
        waittill_any_3( "end_firing", "death", "reload" );
        
        if ( isdefined( self.var_79a1a1fe9f3bf357 ) )
        {
            self.var_79a1a1fe9f3bf357 = 0;
        }
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xca00
// Size: 0x27
function monitorweaponpickup()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "weapon_pickup" );
        function_7731a04537766917();
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xca2f
// Size: 0x38
function monitorweaponswitch()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.lastweaponchangetime = 0;
    
    while ( true )
    {
        self waittill( "weapon_change" );
        self.lastweaponchangetime = gettime();
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xca6f
// Size: 0x10
function updateweaponchangetime()
{
    self.lastweaponchangetime = gettime();
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xca87
// Size: 0x4e
function initstancetracking()
{
    self.laststance = self getstance();
    self.laststancetimes = [];
    self.laststancetimes[ "prone" ] = 0;
    self.laststancetimes[ "crouch" ] = 0;
    self.laststancetimes[ "stand" ] = 0;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xcadd
// Size: 0x27d
function updatestancetracking()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    mantleprev = self.mantlecur;
    self.mantlecur = self ismantling();
    
    if ( !istrue( mantleprev ) && self.mantlecur )
    {
        scripts\mp\potg::processevent( "recent_mantle" );
    }
    
    jumpprev = self.jumpcur;
    self.jumpcur = self isjumping();
    
    if ( !istrue( jumpprev ) && self.jumpcur )
    {
        scripts\mp\potg::processevent( "recent_jump" );
    }
    
    dtpprev = self.dtpcur;
    self.dtpcur = self function_c36cfe1c6acaef46();
    
    if ( !istrue( dtpprev ) && self.dtpcur )
    {
        thread supinecorkscrew();
    }
    
    stance = self getstance();
    
    if ( stance != self.laststance )
    {
        if ( level.potgenabled )
        {
            scripts\mp\potg_events::playerstancechanged( stance );
        }
        else if ( function_966592fd716d49c7() && getdvarint( @"hash_6326b90bd33eec6f" ) == 1 )
        {
            scripts\mp\gametypes\trickrtreat::playerstancechanged( stance );
        }
        
        if ( self.laststance == "crouch" )
        {
            starttime = self.pers[ "lastStanceChangeTime" ];
            time = ( gettime() - starttime ) / 1000;
            incpersstat( "timeCrouched", time );
        }
        
        if ( self.laststance == "prone" )
        {
            starttime = self.pers[ "lastStanceChangeTime" ];
            time = ( gettime() - starttime ) / 1000;
            incpersstat( "timeProne", time );
        }
        
        self.pers[ "lastStanceChangeTime" ] = gettime();
        
        if ( !isdefined( self.pers[ "stanceTracking" ] ) )
        {
            self.pers[ "stanceTracking" ] = [];
            self.pers[ "stanceTracking" ][ "prone" ] = 0;
            self.pers[ "stanceTracking" ][ "crouch" ] = 0;
            self.pers[ "stanceTracking" ][ "stand" ] = 0;
        }
        
        if ( stance == "prone" || stance == "crouch" || stance == "stand" )
        {
            self.pers[ "stanceTracking" ][ stance ]++;
        }
    }
    
    self.laststancetimes[ stance ] = gettime();
    self.laststance = stance;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xcd62
// Size: 0x131
function supinecorkscrew()
{
    self notify( "supineCorkscrew" );
    self endon( "supineCorkscrew" );
    self endon( "death_or_disconnect" );
    
    if ( !potg::function_acab8b716476b589() )
    {
        return;
    }
    
    if ( !isdefined( level.gametypebundle.var_7b8c8e7087d2e518 ) )
    {
        return;
    }
    
    attacker = self;
    yawprev = attacker.angles[ 1 ];
    yawcurr = attacker.angles[ 1 ];
    anglescumulative = 0;
    
    while ( istrue( attacker.dtpcur ) )
    {
        if ( !istrue( attacker.var_bbcc5ab53663340a ) )
        {
            yawprev = yawcurr;
            yawcurr = attacker.angles[ 1 ];
            angledelta = angleclamp180( yawcurr - yawprev );
            anglescumulative += angledelta;
            
            if ( abs( anglescumulative ) >= level.gametypebundle.var_7b8c8e7087d2e518 )
            {
                attacker.var_bbcc5ab53663340a = 1;
            }
        }
        
        waitframe();
    }
    
    if ( isdefined( level.gametypebundle.var_f609acb8d6f7eddb ) )
    {
        wait level.gametypebundle.var_f609acb8d6f7eddb;
    }
    
    attacker.var_bbcc5ab53663340a = 0;
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xce9b
// Size: 0x13
function predatormissileimpact( impactpos )
{
    scripts\mp\potg_events::predatormissileimpact( impactpos );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xceb6
// Size: 0x13
function largevehicleexplosion( explosionpos )
{
    scripts\mp\potg_events::largevehicleexplosion( explosionpos );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xced1
// Size: 0x13
function vehiclekilled( damagedata )
{
    scripts\mp\potg_events::vehiclekilled( damagedata );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xceec
// Size: 0x14
function missilefired( missile )
{
    thread trackmissile( missile );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xcf08
// Size: 0xe2
function trackmissile( missile )
{
    level endon( "game_ended" );
    missile endon( "death" );
    missile endon( "entitydeleted" );
    missile.whizbyplayers = [];
    
    while ( true )
    {
        whizbyplayers = utility::playersnear( missile.origin, 220 );
        
        foreach ( player in whizbyplayers )
        {
            if ( isdefined( missile.owner ) && player == missile.owner )
            {
                continue;
            }
            
            missilewhizby( player, missile );
            missile.whizbyplayers[ player.guid ] = 1;
        }
        
        wait 0.1;
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xcff2
// Size: 0x1b
function missilewhizby( player, missile )
{
    scripts\mp\potg_events::missilewhizby( player );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xd015
// Size: 0x3e4
function bombdefused( defuser, defusesite )
{
    var_8f8dc78c3242728b = 0;
    
    if ( getgametypenumlives() >= 1 )
    {
        liveplayers = getpotentiallivingplayers();
        
        if ( liveplayers.size == 1 && liveplayers[ 0 ] == defuser )
        {
            var_8f8dc78c3242728b = 1;
        }
    }
    
    enemiesnearby = 0;
    
    if ( !var_8f8dc78c3242728b && getgametype() != "dd" )
    {
        playersnearby = getplayersinradius( defuser.origin, 600 );
        
        foreach ( player in playersnearby )
        {
            if ( player.team != defuser.team )
            {
                enemiesnearby = 1;
                break;
            }
        }
    }
    
    defusesite = isdefined( defusesite.objectivekey ) ? defusesite.objectivekey : undefined;
    
    if ( isdefined( level.bombowner ) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && isreallyalive( level.bombowner ) )
    {
        defuser thread scripts\mp\rank::scoreeventpopup( #"ninja_defuse", defusesite );
        defuser thread scripts\mp\hud_message::showsplash( "ninja_defuse", scripts\mp\rank::getscoreinfovalue( #"defuse" ) );
        
        if ( getgametype() != "dd" )
        {
            enemiesnearby = 1;
        }
    }
    else
    {
        defuser thread scripts\mp\hud_message::showsplash( getgametype() == "dd" ? "emp_defuse_dd" : "emp_defuse", scripts\mp\rank::getscoreinfovalue( #"defuse" ) );
        defuser thread scripts\mp\rank::scoreeventpopup( #"defuse", defusesite );
    }
    
    if ( var_8f8dc78c3242728b )
    {
        defuser thread scripts\mp\utility\points::doscoreevent( #"mode_sd_last_defuse", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:defusesite } );
    }
    else
    {
        defuser thread scripts\mp\utility\points::doscoreevent( #"mode_sd_defuse", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:defusesite } );
    }
    
    defuser incpersstat( "defuses", 1 );
    
    if ( getgametype() == "defuse" || getgametype() == "hc_defuse" )
    {
        defuser setextrascore0( defuser.pers[ "defuses" ] );
    }
    
    defuser scripts\mp\persistence::statsetchild( "round", "defuses", defuser.pers[ "defuses" ] );
    defuser scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648( 2, 1 );
    
    if ( isdefined( defuser.pers[ "sneakDefuses" ] ) )
    {
        var_5e88abb83d46a357 = scripts\mp\utility\teams::getenemyplayers( defuser.team, 1 ).size > 0;
        
        if ( var_5e88abb83d46a357 )
        {
            defuser incpersstat( "sneakDefuses", 1 );
        }
    }
    
    if ( getgametype() != "sr" )
    {
        defuser setextrascore1( defuser.pers[ "defuses" ] );
    }
    
    if ( isplayer( defuser ) )
    {
        var_7e2c53b0bcf117d9 = spawnstruct();
        var_7e2c53b0bcf117d9.player = defuser;
        var_7e2c53b0bcf117d9.eventname = "defuse";
        var_7e2c53b0bcf117d9.position = defuser.origin;
        scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_game_event", var_7e2c53b0bcf117d9 );
    }
    
    if ( var_8f8dc78c3242728b )
    {
        logannouncement( defuser, undefined, "Bomb Defused", defuser.origin, "last_alive" );
    }
    else
    {
        logannouncement( defuser, undefined, "Bomb Defused", defuser.origin );
    }
    
    scripts\mp\potg_events::bombdefused( defuser, var_8f8dc78c3242728b, enemiesnearby );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xd401
// Size: 0x35
function revivedplayer( reviver, revivee )
{
    if ( reviver == revivee )
    {
        return;
    }
    
    scripts\mp\potg_events::revivedplayer( reviver, revivee );
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        scripts\mp\gametypes\br_analytics::branalytics_revive( reviver, revivee );
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xd43e
// Size: 0x31
function doorused( player, opening )
{
    scripts\mp\potg_events::doorused( player, opening );
    
    if ( opening )
    {
        player.lastdooropentime = gettime();
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xd477
// Size: 0x4b
function shothit()
{
    scripts\mp\utility\stats::initpersstat( "shotsHit" );
    scripts\mp\utility\stats::incpersstat( "shotsHit", 1 );
    scripts\mp\potg_events::shothit();
    
    if ( getgametype() == "high" )
    {
        thread scripts\cp_mp\challenges::onsuccessfulhit();
        thread scripts\mp\utility\points::doscoreevent( #"get_high_rock_hit" );
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xd4ca
// Size: 0x1c
function shotmissed( totalshots, hitshots )
{
    scripts\mp\potg_events::shotmissed( totalshots, hitshots );
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xd4ee
// Size: 0x237
function function_2fca19675eb69f1a( victim, shitloc, idamage )
{
    if ( isagent( victim ) || !isdefined( victim.clientid ) )
    {
        return;
    }
    
    if ( isdefined( self.combatinstances ) && isdefined( self.combatinstances[ victim.clientid ] ) )
    {
        if ( isdefined( self.combatinstances[ victim.clientid ].var_d7cb4d5d8b4f8e2e ) )
        {
            if ( self.combatinstances[ victim.clientid ].var_d7cb4d5d8b4f8e2e + 10000 > gettime() )
            {
                if ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) )
                {
                    if ( isdefined( self.primaryweaponobj ) && isdefined( self.primaryweaponobj.basename ) && self.currentweapon.basename == self.primaryweaponobj.basename )
                    {
                        if ( function_632bdd4591097aef( shitloc ) )
                        {
                            self.combatinstances[ victim.clientid ].primaryheadshots++;
                        }
                        
                        self.combatinstances[ victim.clientid ].totalshots++;
                    }
                    else if ( isdefined( self.secondaryweaponobj ) && isdefined( self.secondaryweaponobj.basename ) && self.currentweapon.basename == self.secondaryweaponobj.basename )
                    {
                        if ( function_632bdd4591097aef( shitloc ) )
                        {
                            self.combatinstances[ victim.clientid ].secondaryheadshots++;
                        }
                        
                        self.combatinstances[ victim.clientid ].secondaryshots++;
                    }
                }
                
                self.combatinstances[ victim.clientid ].var_d7cb4d5d8b4f8e2e = gettime();
                return;
            }
        }
    }
    
    function_c5f7e38f739b35a1( victim, shitloc, idamage );
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xd72d
// Size: 0x1ac
function function_cf1cfbbec7d07d44( totalshots, missedshots )
{
    if ( !isdefined( self.combatinstances ) )
    {
        return;
    }
    
    if ( self.combatinstances.size > 0 )
    {
        foreach ( instance in self.combatinstances )
        {
            if ( !isdefined( self.currentweapon ) || !isdefined( self.currentweapon.basename ) )
            {
                continue;
            }
            
            if ( isdefined( self.primaryweaponobj ) && isdefined( self.primaryweaponobj.basename ) && self.currentweapon.basename == self.primaryweaponobj.basename )
            {
                instance.shotsmissed += missedshots;
                instance.totalshots += totalshots;
                continue;
            }
            
            if ( isdefined( self.secondaryweaponobj ) && isdefined( self.secondaryweaponobj.basename ) && self.currentweapon.basename == self.secondaryweaponobj.basename )
            {
                instance.secondaryshots += missedshots;
                instance.secondaryshotsmissed += totalshots;
            }
        }
    }
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xd8e1
// Size: 0x2f
function function_f3096708aa63946f( a, b )
{
    if ( isdefined( a ) && isdefined( b ) )
    {
        return distance( a, b );
    }
    
    return -1;
}

// Namespace events / scripts\mp\events
// Params 3
// Checksum 0x0, Offset: 0xd918
// Size: 0x325
function function_c5f7e38f739b35a1( victim, shitloc, idamage )
{
    struct = spawnstruct();
    struct.victimid = victim.clientid;
    struct.victimorigin = ter_op( isdefined( victim.origin ), victim.origin, ( 0, 0, 0 ) );
    struct.combatstarttime = gettime();
    struct.var_d7cb4d5d8b4f8e2e = gettime();
    struct.attackerweapon = isdefined( self.primaryweaponobj ) ? self.primaryweaponobj.basename : undefined;
    struct.attackersecondary = isdefined( self.secondaryweaponobj ) ? self.secondaryweaponobj.basename : undefined;
    
    if ( isdefined( self.secondaryweaponobj ) && isdefined( self.secondaryweaponobj.basename ) )
    {
        struct.attackersecondary = self.secondaryweaponobj.basename;
    }
    else
    {
        struct.attackersecondary = undefined;
    }
    
    struct.victimweapon = victim.currentweapon.basename;
    struct.distancestart = function_f3096708aa63946f( self.origin, victim.origin );
    struct.totalshots = 0;
    struct.shotsmissed = 0;
    struct.secondaryshots = 0;
    struct.secondaryshotsmissed = 0;
    struct.victiminitialhealth = victim.health + idamage;
    struct.primaryheadshots = 0;
    struct.secondaryheadshots = 0;
    struct.var_61944d23e1fcf1c2 = self.primaryweapon;
    struct.var_ab9be282f142f11a = self.secondaryweapon;
    struct.var_56aeae6c53565509 = self.primaryweaponobj;
    struct.var_8f7cffaea5dcdff1 = self.secondaryweaponobj;
    
    if ( isdefined( self.primaryweaponobj ) && self.currentweapon.basename == self.primaryweaponobj.basename )
    {
        struct.totalshots = 1;
        
        if ( function_632bdd4591097aef( shitloc ) )
        {
            struct.primaryheadshots = 1;
        }
    }
    else if ( isdefined( self.secondaryweaponobj ) && self.currentweapon.basename == self.secondaryweaponobj.basename )
    {
        struct.secondaryshots = 1;
        
        if ( function_632bdd4591097aef( shitloc ) )
        {
            struct.secondaryheadshots = 1;
        }
    }
    
    self.combatinstances[ victim.clientid ] = struct;
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xdc45
// Size: 0x95f
function function_f0c7425bd5a7050( victim, meansofdeath )
{
    waittillframeend();
    
    if ( !isdefined( self.combatinstances ) )
    {
        return;
    }
    
    foreach ( instance in self.combatinstances )
    {
        if ( instance.victimid == victim.clientid )
        {
            if ( instance.totalshots > 0 )
            {
                if ( instance.shotsmissed == 0 )
                {
                    var_5813d1e9fe8e86e4 = 100;
                }
                else
                {
                    var_5813d1e9fe8e86e4 = int( clamp( ( 1 - instance.shotsmissed / instance.totalshots ) * 100, 0, 100 ) );
                }
            }
            else
            {
                var_5813d1e9fe8e86e4 = 0;
            }
            
            if ( instance.secondaryshots > 0 )
            {
                if ( instance.secondaryshotsmissed == 0 )
                {
                    var_56dccc97e40a858e = 100;
                }
                else
                {
                    var_56dccc97e40a858e = int( clamp( ( 1 - instance.secondaryshotsmissed / instance.secondaryshots ) * 100, 0, 100 ) );
                }
            }
            else
            {
                var_56dccc97e40a858e = 0;
            }
            
            combatduration = ( gettime() - instance.combatstarttime ) / 1000;
            primarytuning = namespace_e77194a0203f683::function_b4ed203552f83bca( instance.var_56aeae6c53565509 );
            secondarytuning = namespace_e77194a0203f683::function_b4ed203552f83bca( instance.var_8f7cffaea5dcdff1 );
            self dlog_recordplayerevent( "dlog_event_mp_combat_instance", [ "victim", victim, "combat_duration", combatduration, "attacker_weapon_primary", instance.attackerweapon, "attacker_accuracy_primary", var_5813d1e9fe8e86e4, "victim_weapon", instance.victimweapon, "distance_start", instance.distancestart, "distance_final", function_f3096708aa63946f( self.origin, victim.origin ), "attacker_weapon_secondary", instance.attackersecondary, "attacker_accuracy_secondary", var_56dccc97e40a858e, "total_shots_primary", instance.totalshots, "total_shots_secondary", instance.secondaryshots, "victim_initial_health", float( instance.victiminitialhealth ), "attacker_headshots_primary", instance.primaryheadshots, "attacker_headshots_secondary", instance.secondaryheadshots, "primary_weapon_receiver", primarytuning.weapon_receiver, "primary_weapon_front_piece", primarytuning.weapon_front_piece, "primary_weapon_back_piece", primarytuning.weapon_back_piece, "primary_weapon_magazine", primarytuning.weapon_magazine, "primary_weapon_optic", primarytuning.weapon_optic, "primary_weapon_underbarrel", primarytuning.weapon_underbarrel, "primary_weapon_modifier", primarytuning.weapon_modifier, "primary_weapon_muzzle", primarytuning.weapon_muzzle, "primary_weapon_rear_grip", primarytuning.weapon_rear_grip, "primary_weapon_trigger", primarytuning.weapon_trigger, "primary_weapon_extra", primarytuning.weapon_extra, "primary_lid_receiver", primarytuning.lid_receiver, "primary_lid_front_piece", primarytuning.lid_front_piece, "primary_lid_back_piece", primarytuning.lid_back_piece, "primary_lid_magazine", primarytuning.lid_magazine, "primary_lid_optic", primarytuning.lid_optic, "primary_lid_underbarrel", primarytuning.lid_underbarrel, "primary_lid_modifier", primarytuning.lid_modifier, "primary_lid_muzzle", primarytuning.lid_muzzle, "primary_lid_rear_grip", primarytuning.lid_rear_grip, "primary_lid_trigger", primarytuning.lid_trigger, "primary_lid_extra", primarytuning.lid_extra, "primary_tv_receiver", primarytuning.tv_receiver, "primary_tv_front_piece", primarytuning.tv_front_piece, "primary_tv_back_piece", primarytuning.tv_back_piece, "primary_tv_magazine", primarytuning.tv_magazine, "primary_tv_optic", primarytuning.tv_optic, "primary_tv_underbarrel", primarytuning.tv_underbarrel, "primary_tv_modifier", primarytuning.tv_modifier, "primary_tv_muzzle", primarytuning.tv_muzzle, "primary_tv_rear_grip", primarytuning.tv_rear_grip, "primary_tv_trigger", primarytuning.tv_trigger, "primary_tv_extra", primarytuning.tv_extra, "primary_is_bp_tuned", primarytuning.tuned, "secondary_weapon_receiver", secondarytuning.weapon_receiver, "secondary_weapon_front_piece", secondarytuning.weapon_front_piece, "secondary_weapon_back_piece", secondarytuning.weapon_back_piece, "secondary_weapon_magazine", secondarytuning.weapon_magazine, "secondary_weapon_optic", secondarytuning.weapon_optic, "secondary_weapon_underbarrel", secondarytuning.weapon_underbarrel, "secondary_weapon_modifier", secondarytuning.weapon_modifier, "secondary_weapon_muzzle", secondarytuning.weapon_muzzle, "secondary_weapon_rear_grip", secondarytuning.weapon_rear_grip, "secondary_weapon_trigger", secondarytuning.weapon_trigger, "secondary_weapon_extra", secondarytuning.weapon_extra, "secondary_lid_receiver", secondarytuning.lid_receiver, "secondary_lid_front_piece", secondarytuning.lid_front_piece, "secondary_lid_back_piece", secondarytuning.lid_back_piece, "secondary_lid_magazine", secondarytuning.lid_magazine, "secondary_lid_optic", secondarytuning.lid_optic, "secondary_lid_underbarrel", secondarytuning.lid_underbarrel, "secondary_lid_modifier", secondarytuning.lid_modifier, "secondary_lid_muzzle", secondarytuning.lid_muzzle, "secondary_lid_rear_grip", secondarytuning.lid_rear_grip, "secondary_lid_trigger", secondarytuning.lid_trigger, "secondary_lid_extra", secondarytuning.lid_extra, "secondary_tv_receiver", secondarytuning.tv_receiver, "secondary_tv_front_piece", secondarytuning.tv_front_piece, "secondary_tv_back_piece", secondarytuning.tv_back_piece, "secondary_tv_magazine", secondarytuning.tv_magazine, "secondary_tv_optic", secondarytuning.tv_optic, "secondary_tv_underbarrel", secondarytuning.tv_underbarrel, "secondary_tv_modifier", secondarytuning.tv_modifier, "secondary_tv_muzzle", secondarytuning.tv_muzzle, "secondary_tv_rear_grip", secondarytuning.tv_rear_grip, "secondary_tv_trigger", secondarytuning.tv_trigger, "secondary_tv_extra", secondarytuning.tv_extra, "secondary_is_bp_tuned", secondarytuning.tuned ] );
            instance.var_d7cb4d5d8b4f8e2e = undefined;
            break;
        }
    }
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xe5ac
// Size: 0x2e, Type: bool
function function_632bdd4591097aef( shitloc )
{
    return isdefined( shitloc ) && ( shitloc == "head" || shitloc == "helmet" || shitloc == "neck" );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xe5e3
// Size: 0xc
function function_7731a04537766917()
{
    self.combatinstances = undefined;
}

// Namespace events / scripts\mp\events
// Params 4
// Checksum 0x0, Offset: 0xe5f7
// Size: 0x268
function killeventtextpopup( scoreeventref, showassplash, dontshowscoreevent, extraparam )
{
    if ( function_16aa7ce5efacbccb() )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        demoforcesre( "killEventTextPopup called with invalid self" );
        return;
    }
    
    self endon( "death_or_disconnect" );
    showassplash = istrue( showassplash );
    
    if ( !scoreeventhastext( scoreeventref ) && !showassplash )
    {
        return;
    }
    
    if ( !isdefined( self.killeventqueue ) )
    {
        self.killeventqueue = [];
    }
    
    foreach ( event in self.killeventqueue )
    {
        if ( event.scoreeventref == scoreeventref )
        {
            return;
        }
    }
    
    splashdata = spawnstruct();
    splashdata.scoreeventref = scoreeventref;
    splashdata.showassplash = showassplash;
    splashdata.priority = scripts\mp\rank::getscoreeventpriority( scoreeventref );
    splashdata.alwaysshowsplash = scripts\mp\rank::scoreeventalwaysshowassplash( scoreeventref );
    splashdata.processedsplash = 0;
    splashdata.processedscoreevent = 0;
    splashdata.dontshowscoreevent = istrue( dontshowscoreevent );
    splashdata.extraparam = extraparam;
    var_60a14cf75591146d = !splashdata.dontshowscoreevent;
    
    if ( var_60a14cf75591146d && splashdata.alwaysshowsplash && istrue( level.var_393c8c75a6a52875 ) )
    {
        var_d14dfa9f36e616f2 = function_e3dfd7e570749681( scoreeventref );
        
        if ( var_d14dfa9f36e616f2 && !istrue( getscoreinfocategory( scoreeventref, #"hash_e98734bda1c5c091" ) ) )
        {
            splashdata.dontshowscoreevent = 1;
        }
    }
    
    self.killeventqueue[ self.killeventqueue.size ] = splashdata;
    self notify( "killEventTextPopup" );
    self endon( "killEventTextPopup" );
    waitframe();
    
    if ( !isdefined( self.splashpriorityqueue ) )
    {
        self.splashpriorityqueue = [];
    }
    
    foreach ( event in self.killeventqueue )
    {
        insertbypriority( event );
    }
    
    self.killeventqueue = undefined;
    thread processsplashpriorityqueue();
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xe867
// Size: 0x223
function processsplashpriorityqueue()
{
    self notify( "processSplashPriorityQueue" );
    self endon( "processSplashPriorityQueue" );
    
    if ( !isdefined( self.splashpriorityqueue ) )
    {
        return;
    }
    
    splashallowed = !istrue( level.removekilleventsplash );
    
    /#
        foreach ( event in self.splashpriorityqueue )
        {
            if ( splashallowed && istrue( event.showassplash ) && event.alwaysshowsplash )
            {
                println( "<dev string:x152>" + getxhashsourcename( event.scoreeventref ) );
            }
            
            println( "<dev string:x15f>" + getxhashsourcename( event.scoreeventref ) );
        }
    #/
    
    foreach ( event in self.splashpriorityqueue )
    {
        if ( event.processedsplash )
        {
            continue;
        }
        
        if ( splashallowed && istrue( event.showassplash ) && event.alwaysshowsplash )
        {
            thread scripts\mp\hud_message::showsplash( event.scoreeventref );
        }
        
        event.processedsplash = 1;
    }
    
    foreach ( event in self.splashpriorityqueue )
    {
        if ( event.processedscoreevent || event.dontshowscoreevent )
        {
            continue;
        }
        
        thread scripts\mp\rank::scoreeventpopup( event.scoreeventref, event.extraparam );
        event.processedscoreevent = 1;
        wait getdvarfloat( @"hash_1eb32d180bc7cff8", 0.25 );
    }
    
    self.splashpriorityqueue = undefined;
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xea92
// Size: 0x10d
function insertbypriority( splashdata )
{
    if ( self.splashpriorityqueue.size == 0 )
    {
        self.splashpriorityqueue[ self.splashpriorityqueue.size ] = splashdata;
        return;
    }
    
    foreach ( event in self.splashpriorityqueue )
    {
        if ( event.scoreeventref == splashdata.scoreeventref )
        {
            return;
        }
    }
    
    for ( i = 0; i < self.splashpriorityqueue.size ; i++ )
    {
        if ( splashdata.priority > self.splashpriorityqueue[ i ].priority )
        {
            self.splashpriorityqueue = array_insert( self.splashpriorityqueue, splashdata, i );
            return;
        }
    }
    
    self.splashpriorityqueue[ self.splashpriorityqueue.size ] = splashdata;
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xeba7
// Size: 0x98
function getnemesis()
{
    nemesis = [];
    
    if ( !lpcfeaturegated() && isdefined( self.killedby ) )
    {
        highestkillcount = 0;
        
        foreach ( guid, killcount in self.killedby )
        {
            if ( killcount > highestkillcount )
            {
                nemesis = [];
                nemesis[ nemesis.size ] = guid;
            }
            
            if ( killcount == highestkillcount )
            {
                nemesis[ nemesis.size ] = guid;
            }
        }
    }
    
    return nemesis;
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xec48
// Size: 0x75
function isxmike109explosiveheadshot( objweapon, deathdata )
{
    if ( isdefined( objweapon ) && getweaponrootname( objweapon.basename ) == "iw8_sn_xmike109" && isdefined( deathdata.hitloc ) && ( deathdata.hitloc == "head" || deathdata.hitloc == "helmet" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xecc5
// Size: 0x37, Type: bool
function function_d355d90bab289087( objweapon, deathdata )
{
    if ( isthrowingstar( objweapon ) && isdefined( deathdata ) && istrue( deathdata.var_f83c15acb64c91b7 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace events / scripts\mp\events
// Params 2
// Checksum 0x0, Offset: 0xed05
// Size: 0x37, Type: bool
function function_75f9ec9388f318dc( objweapon, deathdata )
{
    if ( isthrowingknife( objweapon ) && isdefined( deathdata ) && istrue( deathdata.var_21d6bd6b0d89a70c ) )
    {
        return true;
    }
    
    return false;
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xed45
// Size: 0x12e
function checklethalequipmentachievement( objweapon )
{
    assertex( isdefined( level.lethal_equipmentmaskoffsets ), "<dev string:x16b>" );
    
    if ( !level.challengesallowed )
    {
        return;
    }
    
    equipref = scripts\mp\equipment::getequipmentreffromweapon( objweapon );
    
    if ( !isdefined( equipref ) || !isdefined( level.lethal_equipmentmaskoffsets[ equipref ] ) )
    {
        return;
    }
    
    if ( self.pers[ "lethalEquipmentKillMask" ] & level.lethal_equipmentmaskoffsets[ equipref ] )
    {
        return;
    }
    else
    {
        self.pers[ "lethalEquipmentKillMask" ] = self.pers[ "lethalEquipmentKillMask" ] | level.lethal_equipmentmaskoffsets[ equipref ];
    }
    
    var_ddacadd2126887bd = 0;
    
    foreach ( offset in level.lethal_equipmentmaskoffsets )
    {
        if ( self.pers[ "lethalEquipmentKillMask" ] & offset )
        {
            var_ddacadd2126887bd++;
            
            if ( var_ddacadd2126887bd >= 6 )
            {
                self reportchallengeuserevent( "collect_item", "lethal_achievement" );
                break;
            }
        }
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xee7b
// Size: 0xa0
function incrementobjectiveachievementkill()
{
    if ( !level.challengesallowed )
    {
        return;
    }
    
    if ( self.objectiveachievementkillcount == -1 )
    {
        return;
    }
    
    self.objectiveachievementkillcount++;
    var_5eadae570201e028 = undefined;
    
    switch ( level.mapname )
    {
        case #"hash_9de262a7132ec180":
        case #"hash_dd0468a72c625fe3":
            var_5eadae570201e028 = 50;
            break;
        default:
            var_5eadae570201e028 = 30;
            break;
    }
    
    if ( self.objectiveachievementkillcount >= var_5eadae570201e028 )
    {
        self reportchallengeuserevent( "collect_item", "objective_player_achievement" );
        self.objectiveachievementkillcount = -1;
    }
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xef23
// Size: 0x107
function checkfinalkillachievements( victim )
{
    self endon( "disconnect" );
    var_b8ab57b5fee4c51f = 0;
    var_d3683388e46c971c = 0;
    
    if ( !level.challengesallowed || !isdefined( victim ) )
    {
        self.recondroneteammate = undefined;
        return;
    }
    
    if ( isplayer( victim ) && isdefined( self.recondroneteammate ) )
    {
        if ( istrue( self.modifiers[ "recon_drone_explosive" ] ) )
        {
            var_b8ab57b5fee4c51f = 1;
        }
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( istrue( self.modifiers[ "execution" ] ) )
        {
            var_d3683388e46c971c = 1;
        }
    }
    
    level waittill_any_timeout_1( 1, "game_ended" );
    
    if ( level.gameended )
    {
        if ( var_b8ab57b5fee4c51f )
        {
            self reportchallengeuserevent( "collect_item", "recon_drone_achievement" );
            
            if ( isdefined( self.recondroneteammate ) )
            {
                self.recondroneteammate reportchallengeuserevent( "collect_item", "recon_drone_achievement" );
            }
        }
        
        if ( var_d3683388e46c971c )
        {
            scripts\mp\gametypes\br_challenges::challengeevaluator( "br_mastery_roundKillExecute", undefined );
        }
    }
    
    self.recondroneteammate = undefined;
}

// Namespace events / scripts\mp\events
// Params 6
// Checksum 0x0, Offset: 0xf032
// Size: 0x57e
function function_2510f24c715782c3( killid, victim, objweapon, meansofdeath, inflictor, deathdata )
{
    if ( isdefined( getgametype() ) && getgametype() == "arena" )
    {
        if ( issnowball( objweapon.basename ) )
        {
            if ( function_6acbd7091f4b88ea( objweapon.basename ) )
            {
                thread scripts\mp\utility\points::doscoreevent( #"kill_gold_snowball" );
            }
        }
        
        if ( isdefined( victim.equipment ) && isdefined( victim.equipment[ "primary" ] ) )
        {
            if ( victim.equipment[ "primary" ] == "equip_pball" )
            {
                thread scripts\mp\utility\points::doscoreevent( #"hash_39405074c551a796" );
            }
        }
    }
    
    if ( isdefined( getgametype() ) && getgametype() == "gold_gun" )
    {
        if ( function_ef71b0d20683d9aa( objweapon.basename ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"kill_ray_gun" );
        }
        
        if ( isdefined( victim.loadoutprimary ) )
        {
            if ( function_ef71b0d20683d9aa( victim.loadoutprimary ) )
            {
                thread scripts\mp\utility\points::doscoreevent( #"hash_efced04ec930c90a" );
            }
        }
        
        level notify( "gold_gun_kill_evaluated" );
    }
    
    if ( isdefined( victim.var_99e82fcc9b77ec71 ) && victim.var_99e82fcc9b77ec71 > 0 )
    {
        thread scripts\mp\utility\points::doscoreevent( #"kill_v_power_electrified_enemy" );
    }
    
    if ( istrue( self.var_2bb368acf8b4df7d ) )
    {
        thread scripts\mp\utility\points::doscoreevent( #"hash_ff01718cba9cb661" );
    }
    
    if ( istrue( victim.var_b9976aacfe15a7ba ) || victim getscriptablepartstate( "superpowers_aura", 1 ) == "on" )
    {
        thread scripts\mp\utility\points::doscoreevent( #"kill_shutdown_v_power" );
    }
    
    if ( isjuggermoshgamemode() )
    {
        if ( scripts\cp_mp\utility\weapon_utility::ischainsword( objweapon.basename ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"hash_5f5800e4adb393cb" );
        }
        
        if ( isdefined( meansofdeath ) && meansofdeath == "MOD_CRUSH" )
        {
            thread scripts\mp\utility\points::doscoreevent( #"hash_a613ac32c76f535e" );
        }
    }
    
    if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) != 0 )
    {
        var_d4b3839ed3095c45 = scripts\cp_mp\operator::function_c9a8541cdb0479bb();
        var_f4bf211cdbca89fe = victim scripts\cp_mp\operator::function_c9a8541cdb0479bb();
        self setclientomnvar( "ui_voxel_head_size_enemy", var_f4bf211cdbca89fe );
        
        if ( isdefined( var_d4b3839ed3095c45 ) && var_d4b3839ed3095c45 < 3 )
        {
            thread scripts\mp\utility\points::doscoreevent( hashcat( #"hash_7d3e2b1b480a64c", var_d4b3839ed3095c45 ) );
        }
        
        if ( isdefined( var_f4bf211cdbca89fe ) )
        {
            thread scripts\mp\utility\points::doscoreevent( hashcat( #"hash_c04e9e95779880d6", var_f4bf211cdbca89fe ) );
        }
    }
    
    if ( getdvarint( @"hash_4b664c074a868ac5", 0 ) != 0 )
    {
        if ( istrue( self.herodrop ) && meansofdeath == "MOD_CRUSH" )
        {
            thread scripts\mp\utility\points::doscoreevent( #"arcade_aoe_power_kill" );
        }
        else if ( isdefined( level.var_5f07e2e462ad2fc ) && isdefined( objweapon ) && array_contains( level.var_5f07e2e462ad2fc, objweapon ) )
        {
            switch ( objweapon.basename )
            {
                case #"hash_aec1771e9a671b1a":
                    thread scripts\mp\utility\points::doscoreevent( #"arcade_pickup_kill_rocket_shotgun" );
                    break;
                case #"hash_e5bfeb043f9cc08e":
                    thread scripts\mp\utility\points::doscoreevent( #"arcade_pickup_kill_pdango" );
                    break;
                case #"hash_50516c32059a970d":
                    thread scripts\mp\utility\points::doscoreevent( #"arcade_pickup_kill_moscar" );
                    break;
                case #"hash_ff242e3e8fc4aacd":
                    thread scripts\mp\utility\points::doscoreevent( #"arcade_pickup_kill_minigun_rage" );
                    break;
                case #"hash_3d9d9e44ff0585f0":
                    thread scripts\mp\utility\points::doscoreevent( #"hash_7e13317081181580" );
                    break;
                case #"hash_7dfef966d251886":
                case #"hash_29c50b2f8b05c7e3":
                    thread scripts\mp\utility\points::doscoreevent( #"hash_812a0b31a0ef8478" );
                    break;
            }
        }
        
        if ( isdefined( self.var_c0520e995eb8892b ) && self.var_c0520e995eb8892b.health > 0 )
        {
            thread scripts\mp\utility\points::doscoreevent( #"hash_cce0cea6333227bd" );
        }
    }
    
    if ( ismutationgamemode() )
    {
        if ( istrue( victim.var_967123630ad7ddc6 ) )
        {
            thread scripts\mp\utility\points::doscoreevent( #"hash_86d8e037ec92167b" );
        }
        
        if ( istrue( victim.var_a2906c0a3da2c192 ) || isdefined( victim.var_17c60a92aea65107 ) && victim.var_17c60a92aea65107 > 0 )
        {
            thread scripts\mp\utility\points::doscoreevent( #"hash_ee98a5e91eb314b" );
        }
    }
    
    if ( getgametype() == "warrior" && isdefined( level.var_6298f362ec23d83.ref ) )
    {
        if ( ( level.var_6298f362ec23d83.ref == "hunt" || level.var_6298f362ec23d83.ref == "ninja" ) && isthrowingknife( objweapon ) )
        {
            var_db7d1b967d268584 = squared( 1181.1 );
            var_d0f14811f29ad03a = squared( 787.402 );
            killdist = distance2dsquared( self.origin, victim.origin );
            
            if ( killdist >= var_db7d1b967d268584 || killdist >= var_d0f14811f29ad03a && !scripts\engine\trace::can_see_origin( victim geteye() ) )
            {
                thread scripts\mp\utility\points::doscoreevent( #"hash_c9fcf8327e46ec76" );
            }
        }
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xf5b8
// Size: 0x24, Type: bool
function function_16aa7ce5efacbccb()
{
    /#
        if ( getdvarint( @"hash_6735e9fcb3e821b9", 0 ) )
        {
            return true;
        }
    #/
    
    return istrue( level.var_16aa7ce5efacbccb );
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xf5e5
// Size: 0x14
function function_4a4d0d400fd59760()
{
    level callback::add( "on_ai_killed", &on_ai_killed );
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xf601
// Size: 0x1fe
function on_ai_killed( sparams )
{
    if ( !isdefined( sparams.eattacker ) )
    {
        return;
    }
    
    if ( isdefined( sparams.eattacker.vehicletype ) )
    {
        sparams.eattacker = sparams.eattacker getvehicleowner();
    }
    else if ( isdefined( sparams.eattacker.owner ) && isplayer( sparams.eattacker.owner ) )
    {
        sparams.eattacker = sparams.eattacker.owner;
    }
    
    if ( !isplayer( sparams.eattacker ) )
    {
        return;
    }
    
    victim = self;
    typestring = "";
    
    if ( !isdefined( self.kiastring ) )
    {
        return;
    }
    
    var_813307117c9bea44 = self.kiastring;
    
    if ( !isxhash( var_813307117c9bea44 ) )
    {
        assertex( 1, var_813307117c9bea44 );
        var_813307117c9bea44 = getxhash( var_813307117c9bea44 );
    }
    
    if ( isdefined( level.var_9871526022516e0b ) )
    {
        [[ level.var_9871526022516e0b ]]( victim, sparams.eattacker, sparams.einflictor, sparams.smeansofdeath, sparams.sweapon, sparams.shitloc, typestring, var_813307117c9bea44 );
        return;
    }
    
    points = scripts\mp\rank::getscoreinfovalue( var_813307117c9bea44 );
    xp = scripts\mp\rank::getscoreinfoxp( var_813307117c9bea44 );
    sparams.eattacker killeventtextpopup( var_813307117c9bea44, 0, 0 );
    
    if ( points > 0 )
    {
        sparams.eattacker scripts\mp\gamescore::giveplayerscore( var_813307117c9bea44, points, self, undefined );
        sparams.eattacker displayscoreeventpoints( points, var_813307117c9bea44 );
    }
    
    if ( xp > 0 )
    {
        sparams.eattacker scripts\mp\rank::giverankxp( var_813307117c9bea44, xp, sparams.sweapon, 1, 0 );
    }
}

// Namespace events / scripts\mp\events
// Params 0
// Checksum 0x0, Offset: 0xf807
// Size: 0x2a
function watchformorebulletkillsinaframeae()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "watchForMoreBulletKillsInAFrameAE" );
    self endon( "watchForMoreBulletKillsInAFrameAE" );
    waittillframeend();
    self.var_39a4aa8a028cb36e = 0;
}

// Namespace events / scripts\mp\events
// Params 1
// Checksum 0x0, Offset: 0xf839
// Size: 0x4f
function function_c5f08330d9923476( numkills )
{
    if ( numkills == 2 )
    {
        self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"one_shot_two_kills" ) );
    }
}

