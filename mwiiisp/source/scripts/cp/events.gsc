#using scripts\common\ae_utility;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp\cp_challenge;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_matchdata;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_weapons;
#using scripts\cp\laststand;
#using scripts\cp\points;
#using scripts\cp\rank;
#using scripts\cp\spawning;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp\utility\player_frame_update_aggregator;
#using scripts\cp\utility\script;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace events;

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x113e
// Size: 0x4e7
function init()
{
    scripts\cp_mp\utility\game_utility::initchallengeandeventglobals();
    scripts\cp\utility\connect_event_aggregator::registeronconnectcallback( &onplayerconnect_events );
    level.var_27dcaf9644646944 = #"display_xp";
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
        {
            return;
        }
    #/
    
    bundle = undefined;
    
    if ( isdefined( level.gametypebundle ) )
    {
        bundlename = level.gametypebundle.scoreeventlist;
        
        if ( isstring( bundlename ) )
        {
            bundle = getscriptbundle( hashcat( %"scoreeventlist:", bundlename ) );
        }
    }
    
    if ( !isdefined( bundle ) )
    {
        bundle = function_15fd33eb83ce9723();
    }
    
    if ( isdefined( bundle ) )
    {
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
    
    scripts\cp\rank::registerscoreinfo( #"persistent_xp", #"value", 500 );
    level thread monitorhealed();
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawn );
    scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &monitoradstime );
    scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &updatestancetracking );
    scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &events_monitorslideupdate );
    scripts\cp\spawning::add_global_spawn_function( "axis", &init_ai_kill_params_for_events );
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x162d
// Size: 0xac
function function_15fd33eb83ce9723()
{
    game_type = scripts\cp\utility::getgametype();
    
    if ( !isdefined( game_type ) )
    {
        game_type = getdvar( @"g_gametype" );
    }
    
    scriptbundlename = "score_event_list_" + game_type;
    
    if ( getdvarint( @"t10" ) > 0 )
    {
        scriptbundlename += "_t10_cp";
        
        /#
            utility::scriptbundlewarning( "<dev string:x1c>", scriptbundlename );
        #/
    }
    else
    {
        scriptbundlename += "_iw9_cp";
        
        /#
            utility::scriptbundlewarning( "<dev string:x1c>", scriptbundlename );
        #/
    }
    
    bundle = getscriptbundle( "scoreeventlist:" + scriptbundlename );
    assert( isdefined( bundle ), "Score Event Bundle required for game type: " + game_type );
    return bundle;
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x16e2
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
    
    scripts\cp\rank::registerscoreinfomultiplier( ref, entry.multiplier );
    group = default_to( entry.group, "unassigned" );
    scripts\cp\rank::registerscoreinfo( ref, #"group", group );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x1769
// Size: 0x251
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
    
    if ( istrue( entry.isaward ) )
    {
        scripts\cp\rank::registerscoreinfo( ref, #"isaward", 1 );
    }
    
    score = default_to( entry.score, 0 );
    xp = default_to( entry.xp, 0 );
    var_e705ea298dacd4e2 = default_to( entry.var_e705ea298dacd4e2, 0 );
    
    if ( !istrue( entry.forceinit ) )
    {
        if ( score == 0 && xp == 0 )
        {
            return;
        }
        
        assert( score >= 0 );
        assert( xp >= 0 );
    }
    
    scripts\cp\rank::registerscoreinfo( ref, #"value", score );
    scripts\cp\rank::registerscoreinfo( ref, #"xp", xp );
    scripts\cp\rank::registerscoreinfo( ref, #"hash_afa3cfee9cf8b4c6", var_e705ea298dacd4e2 );
    var_eef8a3f0dcf96328 = isxhashasset( entry.splashbundle );
    
    if ( !var_eef8a3f0dcf96328 )
    {
        function_4e7a52f99699d997( ref, scripts\cp\cp_hud_message::getsplashtablename() );
    }
    
    group = default_to( entry.group, "unassigned" );
    scripts\cp\rank::registerscoreinfo( ref, #"group", group );
    
    if ( !istrue( entry.nobonus ) )
    {
        scripts\cp\rank::registerscoreinfo( ref, #"allowbonus", 1 );
    }
    
    if ( istrue( entry.var_5b5911eca3f2426f ) )
    {
        scripts\cp\rank::registerscoreinfo( ref, #"hash_582866801a05178b", 1 );
    }
    
    if ( isxhashasset( entry.splashbundle ) )
    {
        var_8cde9a095cf42d8f = function_2336488258354fbc( #"scriptbundle_splash", entry.splashbundle );
        assertex( isdefined( var_8cde9a095cf42d8f ), "Net const string id is undefined for an existing splash bundle: " + getxhashsourcename( entry.splashbundle ) );
        
        if ( isdefined( var_8cde9a095cf42d8f ) )
        {
            scripts\cp\rank::registerscoreinfo( ref, #"hash_9ef9bbcd1edc198b", var_8cde9a095cf42d8f );
            function_cbf4b04a2e7f02ae( ref, entry.splashbundle, var_8cde9a095cf42d8f );
        }
    }
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x19c2
// Size: 0xd3
function function_4e7a52f99699d997( ref, splashtablename )
{
    var_2c6153492a7defb2 = tablelookuprownum( splashtablename, 0, ref );
    
    if ( var_2c6153492a7defb2 < 0 )
    {
        return;
    }
    
    scripts\cp\rank::registerscoreinfo( ref, #"hash_edd89bb2cc2d506", var_2c6153492a7defb2 );
    text = tablelookup( splashtablename, 0, ref, 2 );
    
    if ( isstring( text ) && text != "" )
    {
        scripts\cp\rank::registerscoreinfo( ref, #"hastext", 1 );
    }
    
    priority = int( tablelookup( splashtablename, 0, ref, 13 ) );
    scripts\cp\rank::registerscoreinfo( ref, #"priority", priority );
    var_43297beee133b22 = int( tablelookup( splashtablename, 0, ref, 14 ) );
    scripts\cp\rank::registerscoreinfo( ref, #"alwaysshowsplash", var_43297beee133b22 );
}

// Namespace events / scripts\cp\events
// Params 3
// Checksum 0x0, Offset: 0x1a9d
// Size: 0xcd
function function_cbf4b04a2e7f02ae( ref, var_5a45f9068b4f316, var_8cde9a095cf42d8f )
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
        scripts\cp\rank::registerscoreinfo( ref, #"hastext", 1 );
    }
    
    if ( isdefined( splashbundle.priority ) )
    {
        scripts\cp\rank::registerscoreinfo( ref, #"priority", splashbundle.priority );
    }
    
    if ( istrue( splashbundle.alwaysshowsplash ) )
    {
        scripts\cp\rank::registerscoreinfo( ref, #"alwaysshowsplash", 1 );
    }
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x1b72
// Size: 0x16
function onplayerspawn()
{
    self.jumpcur = 0;
    self.mantlecur = 0;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x1b90
// Size: 0xd3
function onplayerconnect_events()
{
    self.killedplayers = [];
    self.killedby = [];
    self.lastkilledby = undefined;
    self.greatestuniqueplayerkills = 0;
    self.recentkillcount = 0;
    self.recentdefendcount = 0;
    self.lastkilltime = 0;
    self.lastkilldogtime = 0;
    self.damagedplayers = [];
    
    if ( !isdefined( self.pers[ "cur_kill_streak" ] ) )
    {
        self.pers[ "cur_kill_streak" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "cur_death_streak" ] ) )
    {
        self.pers[ "cur_death_streak" ] = 0;
    }
    
    initslidemonitor();
    initmonitoradstime();
    thread monitorreload();
    thread monitorweaponpickup();
    self.lastweaponchangetime = 0;
    initstancetracking();
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x1c6b
// Size: 0x4f
function damagedplayer( victim, damage )
{
    if ( damage < 50 && damage > 10 )
    {
        level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_damaged_light", undefined, 0.1 );
        return;
    }
    
    level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_damaged_heavy", undefined, 0.1 );
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x1cc2
// Size: 0x13
function playerworlddeath( attacker, meansofdeath )
{
    
}

// Namespace events / scripts\cp\events
// Params 4
// Checksum 0x0, Offset: 0x1cdd
// Size: 0x14f
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
    self.killsinaframecount = 0;
    self.bulletkillsinaframecount = 0;
    self.shotgunkillsinaframecount = 0;
}

// Namespace events / scripts\cp\events
// Params 5
// Checksum 0x0, Offset: 0x1e34
// Size: 0x60
function notifykilledplayer( killid, victim, objweapon, meansofdeath, numkills )
{
    fullweaponstring = getcompleteweaponname( objweapon );
    
    for ( i = 0; i < numkills ; i++ )
    {
        self notify( "got_a_kill", victim, fullweaponstring, meansofdeath );
        waitframe();
    }
}

// Namespace events / scripts\cp\events
// Params 7
// Checksum 0x0, Offset: 0x1e9c
// Size: 0x2186
function killedenemy( killid, victim, objweapon, meansofdeath, inflictor, psoffsettime, shitloc )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( level.numkills ) )
    {
        level.numkills = 0;
    }
    
    level.numkills++;
    self.modifiers = [];
    self.modifiers[ "mask" ] = 0;
    
    if ( !istrue( self.pers[ "ignoreKillstreakKillRewards" ] ) )
    {
        checkkillstreakkillevents( objweapon, meansofdeath, inflictor );
    }
    
    if ( isai( victim ) || isdefined( victim.classname ) && victim.classname == "script_vehicle" )
    {
        victim.guid = victim getentitynumber();
    }
    
    victimguid = victim.guid;
    myguid = self.guid;
    curtime = gettime();
    fullweaponstring = getcompleteweaponname( objweapon );
    thread killedplayernotifysys( killid, victim, objweapon, meansofdeath );
    thread updaterecentkills( killid, victim, objweapon, fullweaponstring );
    thread updatequadfeedcounter( self, killid );
    self.prevlastkilltime = self.lastkilltime;
    self.lastkilltime = curtime;
    self.lastkilledplayer = victim;
    self.lastkillvictimpos = victim.origin;
    
    if ( isplayer( self ) )
    {
        if ( self.deaths > 0 )
        {
            kdr = self.kills / self.deaths;
            
            if ( kdr > 3 )
            {
                level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_kd_high", undefined, 0.75 );
            }
        }
        else if ( self.kills > 5 )
        {
            level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_kd_high", undefined, 0.75 );
        }
    }
    
    if ( istrue( self.laststanding ) )
    {
        incpersstat( "clutch", 1 );
    }
    
    if ( isdefined( self.damagedplayers ) && isdefined( self.damagedplayers[ victimguid ] ) )
    {
        self.damagedplayers[ victimguid ] = undefined;
    }
    
    weapongroup = scripts\cp\weapon::getweapongroup( objweapon.basename );
    
    if ( !scripts\cp_mp\weapon::iskillstreakweapon( objweapon.basename ) && !scripts\cp\utility::_hasperk( "specialty_explosivebullets" ) )
    {
        if ( meansofdeath == "MOD_EXECUTION" )
        {
            execution( killid );
        }
        
        if ( objweapon.basename == "none" && !scripts\cp_mp\utility\player_utility::isinvehicle() && meansofdeath != "MOD_EXECUTION" )
        {
            return 0;
        }
        
        if ( isdefined( victim.attackerposition ) )
        {
            attackerposition = victim.attackerposition;
        }
        else
        {
            attackerposition = self.origin;
        }
        
        attackerisinflictor = 1;
        
        if ( isdefined( inflictor ) )
        {
            attackerisinflictor = inflictor == self;
        }
        
        var_a2c3fea3986af52a = anglestoforward( self getplayerangles() );
        var_146f31f6b6666ca7 = victim.origin - attackerposition;
        var_9669ee24872dd095 = vectornormalize( var_146f31f6b6666ca7 );
        var_72705a221874f8a9 = vectordot( var_a2c3fea3986af52a, var_9669ee24872dd095 );
        isbulletdamage = isbulletdamage( meansofdeath );
        
        /#
        #/
        
        if ( isdefined( victim.attackerdata ) )
        {
            if ( weapongroup == "weapon_sniper" && meansofdeath != "MOD_MELEE" && curtime == victim.attackerdata[ self.guid ].firsttimedamaged )
            {
                self.modifiers[ "oneshotkill" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"1shot1kill" ) );
                thread scripts\cp\points::doscoreevent( #"one_shot_kill" );
                incpersstat( "oneShotOneKills", 1 );
            }
            
            if ( weapongroup == "weapon_shotgun" && meansofdeath != "MOD_MELEE" && curtime == victim.attackerdata[ self.guid ].firsttimedamaged )
            {
                self.modifiers[ "oneshotkill_shotgun" ] = 1;
                incpersstat( "oneShotOneKills", 1 );
            }
        }
        
        if ( meansofdeath == "MOD_MELEE" )
        {
            if ( weapongroup != "weapon_melee" && weapongroup != "weapon_melee2" )
            {
                thread scripts\cp\points::doscoreevent( #"gun_butt" );
            }
            
            if ( objweapon.basename == "iw9_me_fists_mp" )
            {
                thread scripts\cp\points::doscoreevent( #"fist_kill" );
            }
        }
        
        if ( isplayer( victim ) )
        {
            heldoffhand = victim getheldoffhand();
            
            if ( heldoffhand.basename == "frag_grenade_mp" || heldoffhand.basename == "cluster_grenade_mp" )
            {
                self.modifiers[ "cooking" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"cooking" ) );
            }
        }
        
        if ( isdefined( self.assistedsuicide ) && self.assistedsuicide )
        {
            assistedsuicide( killid, objweapon );
        }
        
        if ( !istrue( game[ "firstBlood" ] ) )
        {
            game[ "firstBlood" ] = 1;
            firstblood( killid );
        }
        
        if ( isdefined( self.pers ) && self.pers[ "cur_death_streak" ] > 3 )
        {
            comeback( killid );
        }
        
        if ( meansofdeath == "MOD_HEAD_SHOT" || isdefined( shitloc ) && ( shitloc == "head" || shitloc == "helmet" || shitloc == "neck" ) && !istrue( meansofdeath == "MOD_FIRE" ) && !istrue( meansofdeath == "MOD_EXPLOSIVE" ) )
        {
            level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_killfirm_headshot", undefined, 0.75 );
            headshot( killid );
        }
        
        if ( isdefined( self.wasti ) && self.wasti && curtime - self.spawntime <= 5000 )
        {
            self.modifiers[ "jackintheboxkill" ] = 1;
        }
        
        if ( !scripts\cp\utility\player::isreallyalive( self ) && isdefined( self.deathtime ) )
        {
            timesincelastdeath = gettime() - self.deathtime;
            
            if ( timesincelastdeath < 1500 && timesincelastdeath > 0 )
            {
                postdeathkill( killid );
            }
            
            if ( scripts\cp\utility::issimultaneouskillenabled() )
            {
                if ( timesincelastdeath == 0 && isdefined( self.lastattacker ) && self.lastattacker == victim )
                {
                    thread scripts\cp\points::doscoreevent( #"simultaneous_kill", undefined, undefined, undefined, 1 );
                    victim thread scripts\cp\points::doscoreevent( #"simultaneous_kill", undefined, undefined, undefined, 1 );
                }
            }
        }
        
        if ( isdefined( victim.lastkilltime ) && level.teambased && curtime - victim.lastkilltime < 1500 )
        {
            if ( isdefined( victim.lastkilledplayer ) && victim.lastkilledplayer != self )
            {
                avengedplayer( killid, victim.lastkilledplayer );
            }
        }
        
        if ( isdefined( victim.damagedplayers ) )
        {
            foreach ( guid, damagetime in victim.damagedplayers )
            {
                if ( guid == self.guid || guid == string( victim.guid ) )
                {
                    continue;
                }
                
                if ( level.teambased && curtime - damagetime < 1750 )
                {
                    defendedplayer( killid, guid );
                }
            }
        }
        
        if ( attackerisinflictor )
        {
            var_3c709d201f0772ad = getshotdistancetype( self, objweapon, meansofdeath, attackerposition, victim );
            
            switch ( var_3c709d201f0772ad )
            {
                case #"hash_e1ae7daca67ccc55":
                    thread pointblank( killid );
                    break;
                case #"hash_bbddd8225d923d3":
                    thread longshot( killid, self, victim );
                    break;
                case #"hash_4364fa08acd17954":
                    thread longshot( killid, self, victim );
                    thread very_longshot( killid );
                    break;
            }
        }
        
        if ( isbackkill( self, victim, meansofdeath ) )
        {
            if ( objweapon.basename == "iw8_knife_mp" )
            {
                thread scripts\cp\points::doscoreevent( #"backstab" );
            }
            
            self.modifiers[ "backstab" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"backstab" ) );
        }
        
        if ( self isswimming() )
        {
            self.modifiers[ "swimming" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"swimming" ) );
        }
        
        if ( self ishanging() )
        {
            self.modifiers[ "ledgehanging" ] = 1;
            self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"ledgehanging" ) );
        }
        
        if ( self getcamerathirdperson() || self getplayerdata( "cp", "progression", "thirdPerson" ) == 1 )
        {
            self.modifiers[ "thirdperson" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"thirdperson" ) );
        }
        
        if ( level.script == "cp_hydro" )
        {
            if ( !istrue( self isnightvisionon() ) )
            {
                self.modifiers[ "withoutnvgs" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"withoutnvgs" ) );
            }
        }
        
        if ( self getclientomnvar( "ui_assault_suit_on" ) == 1 )
        {
            self.modifiers[ "victiminstronghold" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victiminstronghold" ) );
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
                    victim incpersstat( "pistolDeaths", 1 );
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        incpersstat( "pistolHeadshots", 1 );
                    }
                    
                    break;
            }
            
            if ( meansofdeath == "MOD_MELEE" )
            {
                incpersstat( "meleeKills", 1 );
                victim incpersstat( "meleeDeaths", 1 );
            }
            
            if ( scripts\cp\utility::_hasperk( "specialty_bulletdamage" ) )
            {
                incpersstat( "stoppingPowerKills", 1 );
                
                if ( !isdefined( self.stoppingpowerkills ) )
                {
                    self.stoppingpowerkills = 0;
                }
                
                self.stoppingpowerkills++;
            }
            
            if ( scripts\cp\utility::_hasperk( "specialty_quieter" ) )
            {
                incpersstat( "deadSilenceKills", 1 );
                
                if ( !isdefined( self.deadsilencekills ) )
                {
                    self.deadsilencekills = 0;
                }
                
                self.deadsilencekills++;
            }
            
            if ( isdefined( level.supportdrones ) && level.supportdrones.size > 0 )
            {
                foreach ( drone in level.supportdrones )
                {
                    if ( drone.owner == self && drone.helperdronetype == "radar_drone_overwatch" )
                    {
                        drone.owner incpersstat( "killstreakPersonalUAVKills", 1 );
                        break;
                    }
                }
            }
            
            if ( issurvivorkill( self ) )
            {
                thread doscoreevent( #"low_health_kill" );
            }
            
            if ( scripts\cp\utility\player::isplayerads() )
            {
                self.modifiers[ "ads" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"ads" ) );
                incpersstat( "adsKills", 1 );
            }
            else if ( isbulletdamage )
            {
                self.modifiers[ "hipfire" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"hipfire" ) );
                incpersstat( "hipfireKills", 1 );
            }
            
            if ( !self isonground() )
            {
                self.modifiers[ "airborne" ] = 1;
            }
            
            if ( isplayer( victim ) || isagent( victim ) )
            {
                if ( !victim isonground() )
                {
                    self.modifiers[ "victim_airborne" ] = 1;
                }
            }
            
            if ( self playermount() >= 0.5 )
            {
                self.modifiers[ "mounted" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"mounted" ) );
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
            }
            
            if ( isplayer( victim ) || isagent( victim ) )
            {
                if ( victim issprinting() )
                {
                    self.modifiers[ "victim_sprinting" ] = 1;
                    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victimsprinting" ) );
                }
            }
            
            if ( level.teambased )
            {
                foreach ( player in level.players )
                {
                    if ( self.team != player.team || self == player )
                    {
                        continue;
                    }
                    
                    if ( !scripts\cp\utility\player::isreallyalive( player ) )
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
            
            if ( scripts\cp_mp\armor::hasarmor() )
            {
                self.modifiers[ "weearingarmor" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"wearingarmor" ) );
            }
            
            if ( scripts\cp_mp\armor::function_9bca5c1d23a3e0b3() )
            {
                self.modifiers[ "fullarmor" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"fullarmor" ) );
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
        
        if ( isplayer( victim ) || isagent( victim ) )
        {
            if ( !victim isonground() && !victim iswallrunning() && !self isonground() && !self iswallrunning() )
            {
                if ( attackerisinflictor )
                {
                    thread doscoreevent( #"air_to_air_kill" );
                }
            }
            else
            {
                if ( attackerisinflictor )
                {
                    if ( self iswallrunning() )
                    {
                        thread doscoreevent( #"wallrun_kill" );
                    }
                    else if ( isdeathfromabove( self, objweapon, meansofdeath, attackerposition, victim ) )
                    {
                        thread doscoreevent( #"air_kill" );
                    }
                    else if ( events_issliding() )
                    {
                        thread doscoreevent( #"slide_kill" );
                        self.modifiers[ "sliding" ] = 1;
                        self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"slide" ) );
                    }
                    
                    stance = self getstance();
                    
                    switch ( stance )
                    {
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
                
                if ( victim iswallrunning() )
                {
                    thread doscoreevent( #"kill_wallrunner" );
                }
                else if ( isskeetshooter( self, objweapon, meansofdeath, attackerposition, victim ) )
                {
                    thread doscoreevent( #"kill_jumper" );
                }
            }
        }
        
        if ( isdefined( victim.streakdata ) )
        {
            foreach ( streakinfo in victim.streakdata.streaks )
            {
                costdiff = streakinfo.currentcost - victim.streakpoints;
                
                if ( costdiff > 0 && costdiff <= 1 )
                {
                    buzzkill( killid, victim );
                    break;
                }
            }
        }
        
        if ( attackerisinflictor && ( isplayer( self ) || isagent( self ) ) )
        {
            if ( self ismantling() )
            {
                thread scripts\cp\points::doscoreevent( #"mantle_kill" );
            }
            
            if ( isdefined( self.tookweaponfrom[ fullweaponstring ] ) && self.tookweaponfrom[ fullweaponstring ] == victim )
            {
                thread scripts\cp\points::doscoreevent( #"backfire" );
                self.modifiers[ "backfire" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"backfire" ) );
            }
        }
        
        if ( isdefined( victim.stuckbygrenade ) )
        {
            level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_killfirm_semtex", undefined, 0.75 );
            self.modifiers[ "grenadestuck" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"grenadestuck" ) );
        }
        
        if ( scripts\cp\cp_weapons::isthrowingknife( objweapon.basename ) )
        {
            thread scripts\cp\points::doscoreevent( #"throwingknife_kill" );
        }
        
        if ( isdefined( victim.baitedbydecoy ) && isdefined( victim.baitedbydecoy.owner ) )
        {
            if ( victim.baitedbydecoy.owner != self )
            {
                thread killeventtextpopup( #"assist_decoy" );
            }
        }
        
        if ( isagent( victim ) && istrue( victim scripts\cp\spawning::is_specified_unittype( "juggernaut" ) ) )
        {
            thread killeventtextpopup( #"kill_juggernaut" );
        }
        
        cur_kill_streak = self.pers[ "cur_kill_streak" ] + 1;
        streaknum = 5;
        
        if ( level.gametype == "arm" )
        {
            streaknum = 10;
        }
        
        if ( !( cur_kill_streak % streaknum ) )
        {
            if ( !isdefined( self.lastkillsplash ) || cur_kill_streak != self.lastkillsplash )
            {
                thread teamplayercardsplash( "callout_kill_streaking", self, undefined, cur_kill_streak );
                self.lastkillsplash = cur_kill_streak;
            }
            
            if ( cur_kill_streak <= 30 )
            {
                thread scripts\cp\points::doscoreevent( hashcat( #"streak_", cur_kill_streak ) );
            }
        }
        
        if ( cur_kill_streak > 30 )
        {
            thread scripts\cp\points::doscoreevent( #"streak_max" );
        }
        
        if ( isdefined( inflictor ) && istrue( inflictor.isequipment ) && meansofdeath == "MOD_IMPACT" && !scripts\cp\cp_weapons::isthrowingknife( objweapon.basename ) )
        {
            thread scripts\cp\points::doscoreevent( #"item_impact" );
            self.modifiers[ "item_impact" ] = 1;
        }
        
        if ( scripts\cp\cp_weapons::islauncherdirectimpactdamage( objweapon, meansofdeath ) )
        {
            thread scripts\cp\points::doscoreevent( #"launcher_direct_hit" );
            self.modifiers[ "launcher_impact" ] = 1;
        }
        
        if ( var_72705a221874f8a9 >= 0.6428 )
        {
            self.modifiers[ "victim_in_standard_view" ] = 1;
        }
        
        if ( meansofdeath == "MOD_MELEE" )
        {
            self.modifiers[ "melee" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"melee" ) );
        }
        
        if ( isdefined( self.lastadsstarttime ) && curtime - self.lastadsstarttime <= 500 && weapongroup == "weapon_sniper" )
        {
            self.modifiers[ "quickscope" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"quickscope" ) );
        }
        
        if ( self.health <= 50 )
        {
            self.modifiers[ "low_health_kill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"lowhealth" ) );
        }
        
        if ( isdefined( self.lastweaponchangetime ) && curtime - self.lastweaponchangetime <= 1500 )
        {
            self.modifiers[ "weapon_change_kill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"weaponswap" ) );
        }
        
        if ( isdefined( self.lastweaponpickuptime ) && curtime - self.lastweaponpickuptime <= 1500 )
        {
            self.modifiers[ "weapon_pickup_kill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"recentweaponpickup" ) );
        }
        
        if ( isdefined( self.lastreloadtime ) && curtime - self.lastreloadtime <= 1500 )
        {
            self.modifiers[ "reload_kill" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"recentreload" ) );
        }
        
        vehicle = scripts\cp_mp\utility\player_utility::getvehicle();
        
        if ( scripts\cp_mp\utility\player_utility::isinvehicle() )
        {
            self.modifiers[ "in_vehicle" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"invehicle" ) );
            
            if ( meansofdeath == "MOD_CRUSH" )
            {
                self.modifiers[ "crush" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"crush" ) );
            }
        }
        
        if ( victim scripts\cp_mp\utility\player_utility::isinvehicle() )
        {
            self.modifiers[ "victim_in_vehicle" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"victiminvehicle" ) );
        }
        
        if ( self isinvehicleleanout() )
        {
            self.modifiers[ "vehiclelean" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"vehiclelean" ) );
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
            self.modifiers[ "vehiclesurf" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"vehiclesurf" ) );
            
            if ( moverparent vehicle_getspeed() > 25 )
            {
                self.modifiers[ "infastvehicle" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"infastvehicle" ) );
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
                }
            }
        }
        
        if ( istrue( victim.isdefusing ) )
        {
            self.modifiers[ "killed_defuser" ] = 1;
        }
        
        if ( scripts\cp\weapon::iscacsecondaryweapon( objweapon ) )
        {
            self.modifiers[ "secondary_weapon" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"usingsecondaryweapon" ) );
        }
        
        if ( scripts\cp\laststand::isinlaststand( self ) )
        {
            self.modifiers[ "last_stand" ] = 1;
            self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"laststand" ) );
        }
        
        thread checkmatchdatakills( killid, victim );
    }
    
    if ( !isdefined( self.killedplayers[ victimguid ] ) )
    {
        self.killedplayers[ victimguid ] = 0;
    }
    
    if ( !isdefined( victim.killedby ) || !isdefined( victim.killedby[ myguid ] ) )
    {
        victim.killedby[ myguid ] = 0;
    }
    
    self.killedplayers[ victimguid ]++;
    victim.killedby[ myguid ]++;
    victim.lastkilledby = self;
    
    if ( isplayer( victim ) )
    {
        if ( !victim scripts\common\utility::isusingremote() && ( !victim scripts\cp\utility::_hasperk( "specialty_survivor" ) || istrue( victim.inlaststand ) ) )
        {
            victim thread scripts\cp\utility::setdof_killer();
        }
    }
    
    bufferednotify( "kill_event_buffered", victim, fullweaponstring, meansofdeath, self.modifiers );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x402a
// Size: 0x3d, Type: bool
function iskillstreakvehicleinflictor( einflictor )
{
    return isdefined( einflictor ) && isdefined( einflictor.streakinfo ) && ( isdefined( einflictor.vehiclename ) || isdefined( einflictor.vehiclemodel ) );
}

// Namespace events / scripts\cp\events
// Params 3
// Checksum 0x0, Offset: 0x4070
// Size: 0x550
function checkkillstreakkillevents( objweapon, meansofdeath, inflictor )
{
    iskillstreak = scripts\cp_mp\weapon::iskillstreakweapon( objweapon.basename ) || iskillstreakvehicleinflictor( inflictor );
    forcekillstreak = scripts\cp\points::isforcekillstreakprogressweapon( objweapon );
    
    if ( iskillstreak && !forcekillstreak )
    {
        killstreakname = level.killstreakweaponmap[ objweapon.basename ];
        cankillchain = 0;
        givemidmatch = 0;
        isair = 0;
        isground = 0;
        
        if ( isdefined( inflictor.model ) && is_equal( inflictor.model, "ks_airstrike_target_mp" ) )
        {
            killstreakname = "precision_airstrike";
        }
        
        if ( !isdefined( killstreakname ) )
        {
            return;
        }
        
        if ( !isdefined( self.modifiers ) )
        {
            self.modifiers = [];
        }
        
        if ( !isdefined( self.modifiers[ "mask" ] ) )
        {
            self.modifiers[ "mask" ] = 0;
        }
        
        if ( !isdefined( self.modifiers[ "mask2" ] ) )
        {
            self.modifiers[ "mask2" ] = 0;
        }
        
        switch ( killstreakname )
        {
            case #"hash_9e36e3bd3a9dd00d":
                givemidmatch = 1;
                isground = 1;
                self.modifiers[ "recon_drone_explosive" ] = 1;
                self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"recondroneexplosive" ) );
                break;
            case #"hash_e477c24ee18bb2f6":
                incpersstat( "killstreakTankKills", 1 );
                givemidmatch = 1;
                isground = 1;
                break;
            case #"hash_4d35eb58f9d545f0":
                givemidmatch = 1;
                isground = 1;
                self.modifiers[ "cluster_mine_kill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"cluster_mine_kill" ) );
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
                self.modifiers[ "sentry_kill" ] = 1;
                self.modifiers[ "mask2" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask2" ], function_e2ff8f4b4e94f723( #"kill_bitfield2", #"sentry_kill" ) );
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
            default:
                thread scripts\cp\points::doscoreevent( #"hash_1387a1180e68dc64", objweapon );
                break;
        }
        
        if ( isdefined( inflictor.streakinfo ) )
        {
            if ( !isdefined( inflictor.streakinfo.kills ) )
            {
                inflictor.streakinfo.kills = 0;
            }
            
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
            thread scripts\cp\points::doscoreevent( hashcat( #"ss_kill_", killstreakname ), undefined, undefined, undefined, undefined, undefined, undefined, cankillchain );
        }
        
        level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_killfirm_killstreak", undefined, 0.75 );
    }
}

// Namespace events / scripts\cp\events
// Params 3
// Checksum 0x0, Offset: 0x45c8
// Size: 0x101
function killedkillstreak( killstreakname, killer, objweapon )
{
    if ( scripts\cp_mp\weapon::iskillstreakweapon( objweapon.basename ) )
    {
        thread checkkillstreakkillevents( objweapon, undefined, killer );
    }
    else
    {
        awardname = hashcat( #"kill_ss_", killstreakname );
        eventinfo = spawnstruct();
        eventinfo.isdestroyedkillstreak = 1;
        killer thread scripts\cp\points::doscoreevent( awardname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
        killer incpersstat( "destroyedKillstreaks", 1 );
        level thread scripts\cp\cp_player_battlechatter::saytoself( killer, "plr_killstreak_destroy", undefined, 0.75 );
    }
    
    if ( isdefined( killer.perk_data ) && killer scripts\cp\utility::_hasperk( "specialty_chain_killstreaks" ) )
    {
        var_199c16fdbeb2c72b = 10;
        amount = var_199c16fdbeb2c72b * killer.perk_data[ "super_fill_scalar" ];
        killer scripts\cp\super::increase_super_progress( amount );
    }
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x46d1
// Size: 0x72, Type: bool
function is_enemy_highest_score( enemy, enemies )
{
    foreach ( e in enemies )
    {
        if ( e.score > enemy.score )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace events / scripts\cp\events
// Params 5
// Checksum 0x0, Offset: 0x474c
// Size: 0x1f0
function getshotdistancetype( attacker, objweapon, meansofdeath, attackerposition, victim )
{
    if ( isalive( attacker ) && !attacker scripts\common\utility::isusingremote() && ( meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT" ) && !scripts\cp_mp\weapon::iskillstreakweapon( objweapon.basename ) && !istrue( attacker.assistedsuicide ) )
    {
        killdistsq = distancesquared( attackerposition, victim.origin );
        
        if ( killdistsq < 9216 )
        {
            return "pointblank";
        }
        
        if ( killdistsq > 4000000 )
        {
            return "very_longshot";
        }
        
        var_a77e978567103b98 = scripts\cp\weapon::getweapongroup( objweapon.basename );
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

// Namespace events / scripts\cp\events
// Params 5
// Checksum 0x0, Offset: 0x4945
// Size: 0x77, Type: bool
function isdeathfromabove( attacker, objweapon, meansofdeath, attackerposition, victim )
{
    if ( isalive( attacker ) && attacker isjumping() && isbulletdamage( meansofdeath ) )
    {
        deltaheight = attacker.origin[ 2 ] - victim.origin[ 2 ];
        return ( deltaheight > 60 );
    }
    
    return false;
}

// Namespace events / scripts\cp\events
// Params 5
// Checksum 0x0, Offset: 0x49c5
// Size: 0x46, Type: bool
function isskeetshooter( attacker, objweapon, meansofdeath, attackerposition, victim )
{
    return isalive( attacker ) && victim isjumping() && isbulletdamage( meansofdeath );
}

// Namespace events / scripts\cp\events
// Params 3
// Checksum 0x0, Offset: 0x4a14
// Size: 0xa9, Type: bool
function isbackkill( attacker, victim, meansofdeath )
{
    if ( !isplayer( attacker ) || !isplayer( victim ) )
    {
        return false;
    }
    
    if ( meansofdeath != "MOD_RIFLE_BULLET" && meansofdeath != "MOD_PISTOL_BULLET" && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_HEAD_SHOT" )
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

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x4ac6
// Size: 0x39, Type: bool
function issurvivorkill( player )
{
    return player.health > 0 && player.health < player.maxhealth * 0.2;
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x4b08
// Size: 0x42
function checkmatchdatakills( killid, victim )
{
    if ( isdefined( self.lastkilledby ) && self.lastkilledby == victim )
    {
        self.lastkilledby = undefined;
        revenge( killid, victim );
    }
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x4b52
// Size: 0x2e
function proximityassist( killid )
{
    self.modifiers[ "proximityAssist" ] = 1;
    thread scripts\cp\points::doscoreevent( #"proximityassist" );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x4b88
// Size: 0x2e
function proximitykill( killid )
{
    self.modifiers[ "proximityKill" ] = 1;
    thread scripts\cp\points::doscoreevent( #"proximitykill" );
}

// Namespace events / scripts\cp\events
// Params 3
// Checksum 0x0, Offset: 0x4bbe
// Size: 0xed
function longshot( killid, attacker, victim )
{
    self.modifiers[ "longshot" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"longrange" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "longshot" );
    
    if ( isdefined( attacker ) && isdefined( victim ) && isalive( attacker ) )
    {
        killdist = math::round_float( distance( attacker.origin, victim.origin ) / 39.37, 2 );
        self setclientomnvar( "ui_longshot_dist", killdist );
    }
    
    incpersstat( "longshotKills", 1 );
    thread scripts\cp\points::doscoreevent( #"longshot" );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x4cb3
// Size: 0x5a
function very_longshot( killid )
{
    self.modifiers[ "very_longshot" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"verylongrange" ) );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x4d15
// Size: 0x87
function pointblank( killid )
{
    self.modifiers[ "pointblank" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"shortrange" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "pointblank" );
    thread scripts\cp\points::doscoreevent( #"pointblank" );
    incpersstat( "pointBlankKills", 1 );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x4da4
// Size: 0x79
function headshot( killid )
{
    self.modifiers[ "headshot" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"headshot" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "headshot" );
    thread scripts\cp\points::doscoreevent( #"headshot" );
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x4e25
// Size: 0x8f
function avengedplayer( killid, lastvictim )
{
    self.modifiers[ "avenger" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"avenger" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "avenger" );
    incpersstat( "avengerKills", 1 );
    thread scripts\cp\points::doscoreevent( #"avenger" );
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x4ebc
// Size: 0x45
function assistedsuicide( killid, objweapon )
{
    self.modifiers[ "assistedsuicide" ] = 1;
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "assistedsuicide" );
    thread scripts\cp\points::doscoreevent( #"assistedsuicide", objweapon );
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x4f09
// Size: 0xb3
function defendedplayer( killid, guid )
{
    self.modifiers[ "defender" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"defender" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "defender" );
    incpersstat( "defenderKills", 1 );
    saved = scripts\cp\utility::getplayerforguid( guid );
    thread killeventtextpopup( #"savior", 0 );
    thread scripts\cp\points::doscoreevent( #"save_teammate" );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x4fc4
// Size: 0x79
function postdeathkill( killid )
{
    self.modifiers[ "posthumous" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"posthumous" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "posthumous" );
    thread scripts\cp\points::doscoreevent( #"posthumous" );
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x5045
// Size: 0x8f
function revenge( killid, victim )
{
    self.modifiers[ "revenge" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"revenge" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "revenge" );
    incpersstat( "revengeKills", 1 );
    thread scripts\cp\points::doscoreevent( #"revenge" );
}

// Namespace events / scripts\cp\events
// Params 4
// Checksum 0x0, Offset: 0x50dc
// Size: 0x231
function multikill( killid, killcount, var_c95c893c15217527, dontshowscoreevent )
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
    waitframe();
    award = undefined;
    teamsplash = undefined;
    self notify( "got_multikill" );
    
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
    
    if ( isdefined( self.pers[ "highestMultikill" ] ) && killcount > self.pers[ "highestMultikill" ] )
    {
        self.pers[ "highestMultikill" ] = killcount;
    }
    
    thread scripts\cp\cp_matchdata::logmultikill( killid, killcount );
    
    if ( isdefined( award ) )
    {
        thread killeventtextpopup( award, ter_op( isdefined( var_c95c893c15217527 ), var_c95c893c15217527, 1 ), istrue( dontshowscoreevent ) );
        
        if ( !istrue( dontshowscoreevent ) )
        {
            thread scripts\cp\points::doscoreevent( award, self getcurrentweapon() );
        }
    }
    
    if ( isdefined( teamsplash ) )
    {
        if ( !istrue( dontshowscoreevent ) )
        {
            thread fireoffsplashforplayer( self, teamsplash, undefined, self );
            return;
        }
        
        thread teamplayercardsplash( teamsplash, self, self.team, undefined, 1 );
    }
}

// Namespace events / scripts\cp\events
// Params 4
// Checksum 0x0, Offset: 0x5315
// Size: 0x2f
function fireoffsplashforplayer( player, splash, optionalnumber, owner )
{
    player thread scripts\cp\cp_hud_message::showsplash( splash, optionalnumber, owner );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x534c
// Size: 0x87
function firstblood( killid )
{
    self.modifiers[ "firstblood" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"firstblood" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "firstblood" );
    thread teamplayercardsplash( "callout_firstblood", self );
    thread scripts\cp\points::doscoreevent( #"firstblood" );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x53db
// Size: 0xb
function winningshot( killid )
{
    
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x53ee
// Size: 0x90
function buzzkill( killid, victim )
{
    self.modifiers[ "buzzkill" ] = victim.pers[ "cur_kill_streak" ];
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"buzzkill" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "buzzkill" );
    thread scripts\cp\points::doscoreevent( #"buzzkill" );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5486
// Size: 0x87
function comeback( killid )
{
    self.modifiers[ "comeback" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"comeback" ) );
    thread scripts\cp\cp_matchdata::logattackerkillevent( killid, "comeback" );
    thread scripts\cp\points::doscoreevent( #"comeback" );
    incpersstat( "comebackKills", 1 );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5515
// Size: 0x54
function collateral( numkills )
{
    if ( numkills == 2 )
    {
        level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_killfirm_twofer", undefined, 0.75 );
        thread scripts\cp\points::doscoreevent( #"one_shot_two_kills" );
    }
    
    if ( numkills == 3 )
    {
        level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_killfirm_threefer", undefined, 0.75 );
    }
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5571
// Size: 0xb
function shotguncollateral( numkills )
{
    
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x5584
// Size: 0x73
function quadfeed( killid, struct )
{
    self.modifiers[ "quadfeed" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"quadfeed" ) );
    thread scripts\cp\points::doscoreevent( #"quad_feed" );
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x55ff
// Size: 0x9b
function disconnected()
{
    myguid = self.guid;
    
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

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x56a2
// Size: 0x42
function monitorhealed()
{
    if ( scripts\cp\rank::function_377a94f711d96927( "healed" ) == 0 )
    {
        return;
    }
    
    level endon( "end_game" );
    
    for ( ;; )
    {
        level waittill( "healed", player );
        player thread scripts\cp\points::doscoreevent( #"healed" );
    }
}

// Namespace events / scripts\cp\events
// Params 4
// Checksum 0x0, Offset: 0x56ec
// Size: 0x1d3
function updaterecentkills( killid, victim, objweapon, fullweaponstring )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "updateRecentKills" );
    self endon( "updateRecentKills" );
    
    if ( !isdefined( self.recentkillcount ) )
    {
        self.recentkillcount = 0;
    }
    
    self.recentkillcount++;
    
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
    
    weaponinfo = scripts\cp\utility::getequipmenttype( objweapon.basename );
    
    if ( isdefined( weaponinfo ) && weaponinfo == "lethal" && objweapon.basename != "throwingknife_mp" )
    {
        level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_killfirm_grenade", undefined, 0.75 );
        level thread scripts\cp\cp_player_battlechatter::saytoself( self, "plr_killfirm_amf", undefined, 0.75 );
        
        if ( self.recentkillsperweapon[ fullweaponstring ] > 0 && self.recentkillsperweapon[ fullweaponstring ] % 2 == 0 )
        {
            thread scripts\cp\points::doscoreevent( #"grenade_double" );
        }
    }
    
    bufferednotify( "update_rapid_kill_buffered", self.recentkillcount, fullweaponstring );
    
    if ( self.recentkillcount > 1 )
    {
        thread multikill( killid, self.recentkillcount, 0 );
    }
    
    wait 2.5;
    
    if ( self.recentkillcount > 1 )
    {
        thread multikill( killid, self.recentkillcount, 1, 1 );
    }
    
    incpersstat( "mostMultikills", 1 );
    self.recentkillcount = 0;
    self.recentdefendcount = 0;
    self.recentkillsperweapon = undefined;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x58c7
// Size: 0x62
function monitorcratejacking()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "hijacker", cratetype, owner );
        thread scripts\cp\points::doscoreevent( #"hash_519e0923d0608694" );
        splashname = "hijacked_airdrop";
        
        if ( isdefined( owner ) )
        {
            owner scripts\cp\cp_hud_message::showsplash( splashname, undefined, self );
        }
    }
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x5931
// Size: 0x101
function updatequadfeedcounter( attacker, killid )
{
    if ( isdefined( level.quadfeedinfo ) && gettime() - level.quadfeedinfo.starttime > 5000 )
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
        struct.player quadfeed( killid, struct );
        level.quadfeedinfo = undefined;
    }
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5a3a
// Size: 0x1b
function initslidemonitor()
{
    self.eventswassliding = self issprintsliding();
    self.eventsslideendtime = undefined;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5a5d
// Size: 0x5e
function events_monitorslideupdate()
{
    if ( scripts\cp\utility\player::isreallyalive( self ) )
    {
        eventsissliding = self issprintsliding();
        
        if ( istrue( self.eventswassliding ) && !eventsissliding )
        {
            self.eventsslideendtime = gettime();
        }
        
        self.eventswassliding = eventsissliding;
        return;
    }
    
    self.eventswassliding = 0;
    self.eventsslideendtime = undefined;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5ac3
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

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5b07
// Size: 0x1b
function initmonitoradstime()
{
    self.wasads = scripts\cp\utility\player::isplayerads();
    self.lastadsstarttime = 0;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5b2a
// Size: 0x3d
function monitoradstime()
{
    if ( scripts\cp\utility\player::isplayerads() )
    {
        if ( !self.wasads )
        {
            self.lastadsstarttime = gettime();
            self.wasads = 1;
        }
        
        return;
    }
    
    self.wasads = 0;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5b6f
// Size: 0x46
function monitorreload()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.lastreloadtime = 0;
    
    while ( true )
    {
        self waittill( "reload" );
        self.lastreloadtime = gettime();
        incpersstat( "reloads", 1 );
    }
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5bbd
// Size: 0x46
function monitorweaponpickup()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.lastweaponpickuptime = 0;
    
    while ( true )
    {
        self waittill( "weapon_pickup" );
        self.lastweaponpickuptime = gettime();
        incpersstat( "weaponPickups", 1 );
    }
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5c0b
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

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5c4b
// Size: 0x10
function updateweaponchangetime()
{
    self.lastweaponchangetime = gettime();
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5c63
// Size: 0x5c
function initstancetracking()
{
    self.laststance = self getstance();
    self.laststancechangetime = gettime();
    self.laststancetimes = [];
    self.laststancetimes[ "prone" ] = 0;
    self.laststancetimes[ "crouch" ] = 0;
    self.laststancetimes[ "stand" ] = 0;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x5cc7
// Size: 0x1db
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
    }
    
    jumpprev = self.jumpcur;
    self.jumpcur = self isjumping();
    
    if ( !istrue( jumpprev ) && self.jumpcur )
    {
    }
    
    stance = self getstance();
    
    if ( stance != self.laststance )
    {
        if ( self.laststance == "crouch" )
        {
            starttime = self.laststancechangetime;
            time = ( gettime() - starttime ) / 1000;
            incpersstat( "timeCrouched", time );
        }
        
        if ( self.laststance == "prone" )
        {
            starttime = self.laststancechangetime;
            time = ( gettime() - starttime ) / 1000;
            incpersstat( "timeProne", time );
        }
        
        self.laststancechangetime = gettime();
        
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

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5eaa
// Size: 0xb
function predatormissileimpact( impactpos )
{
    
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5ebd
// Size: 0xb
function largevehicleexplosion( explosionpos )
{
    
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5ed0
// Size: 0xb
function vehiclekilled( damagedata )
{
    
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5ee3
// Size: 0x14
function missilefired( missile )
{
    thread trackmissile( missile );
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x5eff
// Size: 0xe0
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

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x5fe7
// Size: 0x13
function missilewhizby( player, missile )
{
    
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x6002
// Size: 0x144
function bombdefused( defuser )
{
    var_8f8dc78c3242728b = 0;
    enemiesnearby = 0;
    
    if ( !var_8f8dc78c3242728b )
    {
        playersnearby = scripts\cp\utility::getplayersinradius( defuser.origin, 600 );
        
        foreach ( player in playersnearby )
        {
            if ( player.team != defuser.team )
            {
                enemiesnearby = 1;
                break;
            }
        }
    }
    
    if ( var_8f8dc78c3242728b )
    {
        defuser thread scripts\cp\points::doscoreevent( #"mode_sd_last_defuse" );
    }
    else
    {
        defuser thread scripts\cp\points::doscoreevent( #"mode_sd_defuse" );
    }
    
    defuser incpersstat( "defuses", 1 );
    
    if ( isplayer( defuser ) )
    {
        telemetrydata = spawnstruct();
        telemetrydata.player = defuser;
        telemetrydata.eventname = "defuse";
        telemetrydata.position = defuser.origin;
        scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_game_event", telemetrydata );
    }
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x614e
// Size: 0x22
function revivedplayer( reviver, revivee )
{
    if ( scripts\cp\utility::getgametype() == "cp_survival" )
    {
    }
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x6178
// Size: 0x28
function doorused( player, opening )
{
    if ( opening )
    {
        player.lastdooropentime = gettime();
    }
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x61a8
// Size: 0x2
function shothit()
{
    
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x61b2
// Size: 0x2
function shotmissed()
{
    
}

// Namespace events / scripts\cp\events
// Params 3
// Checksum 0x0, Offset: 0x61bc
// Size: 0x1bf
function killeventtextpopup( scoreeventref, showassplash, dontshowscoreevent )
{
    if ( function_16aa7ce5efacbccb() )
    {
        return;
    }
    
    self endon( "death_or_disconnect" );
    
    if ( !scripts\cp\rank::scoreeventhastext( scoreeventref ) )
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
    splashdata.showassplash = istrue( showassplash );
    splashdata.priority = scripts\cp\rank::getscoreeventpriority( scoreeventref );
    splashdata.alwaysshowsplash = scripts\cp\rank::scoreeventalwaysshowassplash( scoreeventref );
    splashdata.processedsplash = 0;
    splashdata.processedscoreevent = 0;
    splashdata.dontshowscoreevent = istrue( dontshowscoreevent );
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

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x6383
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

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x63b0
// Size: 0x10b
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

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x64c3
// Size: 0x212
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
                println( "<dev string:x2b>" + getxhashsourcename( event.scoreeventref ) );
            }
            
            println( "<dev string:x35>" + getxhashsourcename( event.scoreeventref ) );
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
            thread scripts\cp\cp_hud_message::showsplash( event.scoreeventref );
        }
        
        event.processedsplash = 1;
    }
    
    foreach ( event in self.splashpriorityqueue )
    {
        if ( event.processedscoreevent || event.dontshowscoreevent )
        {
            continue;
        }
        
        thread scripts\cp\rank::scoreeventpopup( event.scoreeventref );
        event.processedscoreevent = 1;
        wait getdvarfloat( @"hash_1eb32d180bc7cff8", 0.25 );
    }
    
    self.splashpriorityqueue = undefined;
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x66dd
// Size: 0x27
function initpersstat( dataname )
{
    if ( !isdefined( self.pers[ dataname ] ) )
    {
        self.pers[ dataname ] = 0;
    }
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x670c
// Size: 0x16
function getpersstat( dataname )
{
    return self.pers[ dataname ];
}

// Namespace events / scripts\cp\events
// Params 2
// Checksum 0x0, Offset: 0x672b
// Size: 0x5b
function incpersstat( dataname, increment )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    if ( isdefined( self ) && isdefined( self.pers ) && isdefined( self.pers[ dataname ] ) )
    {
        self.pers[ dataname ] += increment;
    }
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x678e
// Size: 0x32
function setextrascore0( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore0 = newvalue;
    self.pers[ "extrascore0" ] = newvalue;
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x67c8
// Size: 0x32
function setextrascore1( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore1 = newvalue;
    self.pers[ "extrascore1" ] = newvalue;
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x6802
// Size: 0x32
function setextrascore2( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore2 = newvalue;
    self.pers[ "extrascore2" ] = newvalue;
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x683c
// Size: 0x32
function setextrascore3( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore3 = newvalue;
    self.pers[ "extrascore3" ] = newvalue;
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x6876
// Size: 0x7
function getplayerdataloadoutgroup()
{
    return "cploadouts";
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x6886
// Size: 0x11
function setplayerdatagroups()
{
    level.loadoutsgroup = getplayerdataloadoutgroup();
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x689f
// Size: 0x29, Type: bool
function canrecordcombatrecordstats()
{
    return level.rankedmatch && !istrue( level.ignorescoring ) && scripts\cp\utility::getgametype() != "infect";
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x68d1
// Size: 0x3e
function getstreakrecordtype( streakname )
{
    if ( isenumvaluevalid( "mp", "LethalScorestreakStatItems", streakname ) )
    {
        return "lethalScorestreakStats";
    }
    
    if ( isenumvaluevalid( "mp", "SupportScorestreakStatItems", streakname ) )
    {
        return "supportScorestreakStats";
    }
    
    return undefined;
}

// Namespace events / scripts\cp\events
// Params 1
// Checksum 0x0, Offset: 0x6918
// Size: 0x73
function execution( killid )
{
    self.modifiers[ "execution" ] = 1;
    self.modifiers[ "mask" ] = scripts\cp_mp\challenges::function_6d40f12a09494350( self.modifiers[ "mask" ], function_e2ff8f4b4e94f723( #"kill_bitfield1", #"execution" ) );
    thread scripts\cp\points::doscoreevent( #"execution" );
    self notify( "killed_ai_via_execution" );
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x6993
// Size: 0xc4
function init_ai_kill_params_for_events()
{
    self.killedplayers = [];
    self.killedby = [];
    self.lastkilledby = undefined;
    self.greatestuniqueplayerkills = 0;
    self.damagedplayers = [];
    self.lastkilltime = 0;
    self.lastkilldogtime = 0;
    self.recentkillcount = 0;
    self.recentdefendcount = 0;
    self.kills = 0;
    self.deaths = 0;
    self.pers[ "cur_kill_streak" ] = 0;
    self.pers[ "cur_death_streak" ] = 0;
    self.pers[ "cur_kill_streak_for_nuke" ] = 0;
    self.tookweaponfrom = [];
    self.guid = scripts\cp\utility\player::getuniqueid();
    thread watch_for_long_death();
}

// Namespace events / scripts\cp\events
// Params 0
// Checksum 0x0, Offset: 0x6a5f
// Size: 0x18a
function watch_for_long_death()
{
    self endon( "death" );
    self waittill( "long_death" );
    
    if ( isdefined( self.attackers ) && self.attackers.size > 0 )
    {
        foreach ( guid, entity in self.attackers )
        {
            if ( isplayer( entity ) )
            {
                if ( isdefined( self.attackerdata ) && self.attackerdata.size > 0 )
                {
                    if ( !isdefined( entity.longdeathtracker ) )
                    {
                        entity.longdeathtracker = [];
                    }
                    
                    entity thread killedenemy( undefined, self, self.attackerdata[ guid ].objweapon, self.attackerdata[ guid ].smeansofdeath, entity, 0 );
                    thread scripts\cp\cp_challenge::onplayerkilled( entity, entity, self.maxhealth, undefined, self.attackerdata[ guid ].smeansofdeath, self.attackerdata[ guid ].objweapon, self.attackerdata[ guid ].smeansofdeathshitloc, entity.modifiers );
                    entity thread scripts\cp\points::doscoreevent( #"kill", self.attackerdata[ guid ].objweapon );
                    entity.longdeathtracker[ self getentitynumber() ] = 1;
                }
            }
        }
    }
}

