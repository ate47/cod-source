#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace namespace_e3e994302f5316d8;

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 2
// Checksum 0x0, Offset: 0x412
// Size: 0x2d
function setkillcamkilledbyitemomnvars( type, itemid )
{
    self setclientomnvar( "ui_killcam_killedby_item_type", type );
    self setclientomnvar( "ui_killcam_killedby_item_id", itemid );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0x447
// Size: 0x1e
function clearlootweaponomnvars()
{
    self setclientomnvar( "ui_killcam_killedby_loot_variant_id", -1 );
    self setclientomnvar( "ui_killcam_killedby_weapon_rarity", -1 );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0x46d
// Size: 0x2f
function clearkillcamattachmentomnvars()
{
    for ( attachindex = 0; attachindex < 8 ; attachindex++ )
    {
        self setclientomnvar( "ui_killcam_killedby_attachment" + attachindex + 1, -1 );
    }
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 1
// Checksum 0x0, Offset: 0x4a4
// Size: 0x27
function setkillcamuitimer( killcamlengthsec )
{
    self setclientomnvar( "ui_killcam_end_milliseconds", int( killcamlengthsec * 1000 ) + gettime() );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 1
// Checksum 0x0, Offset: 0x4d3
// Size: 0xb7
function setkillcamkillstreaktypeomnvars( objweapon )
{
    killstreakindex = scripts\cp_mp\utility\killstreak_utility::getkillstreakindex( level.killstreakweaponmap[ objweapon.basename ] );
    
    if ( isdefined( self.scorestreakvariantattackerinfo ) )
    {
        killstreakindex = self.scorestreakvariantattackerinfo.id;
        killstreakrarity = self.scorestreakvariantattackerinfo.rarity;
        self setclientomnvar( "ui_killcam_killedby_item_type", 1 );
        self setclientomnvar( "ui_killcam_killedby_loot_variant_id", killstreakindex );
        self setclientomnvar( "ui_killcam_killedby_weapon_rarity", killstreakrarity - 1 );
    }
    else
    {
        setkillcamkilledbyitemomnvars( 1, killstreakindex );
        clearlootweaponomnvars();
    }
    
    clearkillcamattachmentomnvars();
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 1
// Checksum 0x0, Offset: 0x592
// Size: 0x6f
function function_ee36210863ca9f2c( objweapon )
{
    var_bf8545f1fc7059d3 = 0;
    
    switch ( objweapon.basename )
    {
        case #"hash_2b2cfdf125b4764d":
        case #"hash_2cdebdb0a44e94e6":
        case #"hash_44ac662b86af3e18":
        case #"hash_4e86f50e99575707":
        case #"hash_f89fb49cf58b70a5":
            var_bf8545f1fc7059d3 = 1;
            break;
    }
    
    return var_bf8545f1fc7059d3;
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 6
// Checksum 0x0, Offset: 0x60a
// Size: 0x1cf
function trimkillcamtime( inflictoragentinfo, attacker, camtime, postdelay, predelay, maxtime )
{
    killcamlength = camtime + postdelay;
    
    if ( isdefined( maxtime ) && killcamlength > maxtime )
    {
        if ( maxtime < 2 )
        {
            return;
        }
        
        if ( maxtime - camtime >= 1 )
        {
            postdelay = maxtime - camtime;
        }
        else
        {
            postdelay = 1;
            camtime = maxtime - 1;
        }
        
        killcamlength = camtime + postdelay;
    }
    
    killcamoffset = camtime + predelay;
    currenttime = gettime();
    lastattackerspawntime = currenttime;
    
    if ( isdefined( inflictoragentinfo ) && isdefined( inflictoragentinfo.lastspawntime ) )
    {
        lastattackerspawntime = inflictoragentinfo.lastspawntime;
    }
    else
    {
        if ( isdefined( attacker.lastspawntime ) )
        {
            lastattackerspawntime = attacker.lastspawntime;
        }
        
        if ( isdefined( attacker.deathtime ) )
        {
            if ( currenttime - attacker.deathtime < postdelay * 1000 )
            {
                postdelay = 1;
                postdelay -= level.framedurationseconds;
                killcamlength = camtime + postdelay;
            }
        }
    }
    
    if ( isdefined( lastattackerspawntime ) )
    {
        alivetime = ( currenttime - lastattackerspawntime ) / 1000;
    }
    else
    {
        alivetime = currenttime - 10000;
    }
    
    if ( killcamoffset > alivetime && alivetime > predelay )
    {
        var_38b7c5810bafdb39 = alivetime - predelay;
        
        if ( camtime > var_38b7c5810bafdb39 )
        {
            camtime = var_38b7c5810bafdb39;
            killcamlength = camtime + postdelay;
            killcamoffset = camtime + predelay;
        }
    }
    
    result = spawnstruct();
    result.camtime = camtime;
    result.postdelay = postdelay;
    result.killcamlength = killcamlength;
    result.killcamoffset = killcamoffset;
    return result;
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0x7e2
// Size: 0x18
function function_e35f3dda3b0ea636()
{
    wait 0.1;
    self stoplocalsound( level.var_d39aa4b67cefa0d6 );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 3
// Checksum 0x0, Offset: 0x802
// Size: 0x42
function setcinematiccamerastyle( camerastyle, var_226f86d3a2d6da77, var_b41e4c5eb0094058 )
{
    self setclientomnvar( "cam_scene_name", camerastyle );
    self setclientomnvar( "cam_scene_lead", var_226f86d3a2d6da77 );
    self setclientomnvar( "cam_scene_support", var_b41e4c5eb0094058 );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0x84c
// Size: 0x1e
function clearkillcamkilledbyitemomnvars()
{
    self setclientomnvar( "ui_killcam_killedby_item_type", -1 );
    self setclientomnvar( "ui_killcam_killedby_item_id", -1 );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0x872
// Size: 0x82
function clearkillcamomnvars()
{
    clearkillcamkilledbyitemomnvars();
    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );
    self setclientomnvar( "ui_killcam_killedby_id", -1 );
    self setclientomnvar( "ui_killcam_victim_id", -1 );
    self setclientomnvar( "ui_killcam_killedby_loot_variant_id", -1 );
    self setclientomnvar( "ui_killcam_killedby_weapon_rarity", -1 );
    clearkillcamattachmentomnvars();
    
    for ( perkindex = 0; perkindex < 6 ; perkindex++ )
    {
        self setclientomnvar( "ui_killcam_killedby_perk" + perkindex, "none" );
    }
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 4
// Checksum 0x0, Offset: 0x8fc
// Size: 0xe0
function beginarchiveplayback( var_79fe9d21e7286c23, rewindtime, playbackduration, psoffsettime )
{
    scripts\cp_mp\utility\player_utility::updatesessionstate( "spectator" );
    self.spectatekillcam = 1;
    self.forcespectatorclient = var_79fe9d21e7286c23;
    self.killcamentity = -1;
    self.archivetime = rewindtime;
    self.killcamlength = playbackduration;
    self.psoffsettime = psoffsettime;
    self allowspectateteam( "freelook", 1 );
    self allowspectateteam( "none", 1 );
    
    foreach ( teamname in level.teamnamelist )
    {
        self allowspectateteam( teamname, 1 );
    }
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 7
// Checksum 0x0, Offset: 0x9e4
// Size: 0x167, Type: bool
function setkillcamerastyle( einflictor, inflictoragentinfo, attackernum, evictim, killcamentityindex, killcaminfo, objweapon )
{
    killcaminfo.camerastyle = "unknown";
    
    if ( isdefined( inflictoragentinfo ) && isdefined( inflictoragentinfo.agent_type ) )
    {
        setcinematiccamerastyle( "killcam_agent", einflictor getentitynumber(), evictim getentitynumber() );
        killcaminfo.camerastyle = "killcam_agent";
        return true;
    }
    else if ( isdefined( einflictor ) && istrue( einflictor.var_26fb072855fd4772 ) )
    {
        if ( getdvarint( @"hash_1a5e4af153d0e5bb", 1 ) == 0 )
        {
            setcinematiccamerastyle( "killcam_racecar", einflictor.var_7f256d9f9cd2e337 getentitynumber(), evictim getentitynumber() );
            killcaminfo.camerastyle = "killcam_racecar";
            return true;
        }
    }
    else if ( isdefined( objweapon ) && isdefined( objweapon.basename ) )
    {
        if ( objweapon.basename == "manual_turret_mp" || objweapon.basename == "manual_turret_jup_mp" )
        {
            return true;
        }
    }
    else if ( killcamentityindex > 0 )
    {
        setcinematiccamerastyle( "unknown", -1, -1 );
        return false;
    }
    else
    {
        setcinematiccamerastyle( "unknown", -1, -1 );
        return false;
    }
    
    return false;
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 5
// Checksum 0x0, Offset: 0xb54
// Size: 0xa3
function setkillcamentity( killcamentityindex, killcamoffset, starttime, killcamlookatentityindex, killcamentstickstolookatent )
{
    self endon( "disconnect" );
    self endon( "killcam_ended" );
    killcamtime = gettime() - killcamoffset * 1000;
    
    if ( starttime > killcamtime )
    {
        waitframe();
        killcamoffset = self.archivetime;
        killcamtime = gettime() - killcamoffset * 1000;
        
        if ( starttime > killcamtime )
        {
            wait ( starttime - killcamtime ) / 1000;
        }
    }
    
    self.killcamentity = killcamentityindex;
    
    if ( isdefined( killcamlookatentityindex ) )
    {
        self.killcamentitylookat = killcamlookatentityindex;
    }
    
    if ( isdefined( killcamentstickstolookatent ) )
    {
        self setkillcamentstickstolookatent( killcamentstickstolookatent );
    }
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 1
// Checksum 0x0, Offset: 0xbff
// Size: 0xd9
function checkkillcamtruncation( killcamoffset )
{
    if ( !isdefined( killcamoffset ) )
    {
        return;
    }
    
    assertex( self.archivetime <= killcamoffset + 0.0001, "<dev string:x1c>" + self.archivetime + "<dev string:x2d>" + killcamoffset );
    
    if ( self.archivetime + 0.015 < killcamoffset )
    {
        var_5b71064e47c6b27b = killcamoffset - self.archivetime;
        
        if ( game[ "truncated_killcams" ] < 32 )
        {
            println( "<dev string:x4f>" + game[ "<dev string:x80>" ] );
            game[ "truncated_killcams" ]++;
        }
        
        /#
            println( "<dev string:x96>" + var_5b71064e47c6b27b + "<dev string:xc0>" );
            
            if ( getdvarint( @"hash_d82edd92078136c7", 0 ) == 1 )
            {
                assertmsg( "<dev string:xff>" + var_5b71064e47c6b27b + "<dev string:x11c>" );
            }
        #/
    }
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 1
// Checksum 0x0, Offset: 0xce0
// Size: 0xb6
function dokillcamslowmo( camtime )
{
    self endon( "killcam_ended" );
    
    if ( isdefined( level.doingkillcamslowmo ) )
    {
        return;
    }
    
    level.doingkillcamslowmo = 1;
    accumtime = 0;
    var_c65ca876a670ed43 = camtime;
    
    if ( var_c65ca876a670ed43 > 1 )
    {
        var_c65ca876a670ed43 = 1;
        accumtime += 1;
        wait camtime - accumtime;
    }
    
    if ( !isdefined( level.killcam_timescalefactor ) )
    {
        soundsettimescalefactorfromtable( "killcam" );
        level.killcam_timescalefactor = 1;
    }
    
    setslowmotion( 1, 0.25, var_c65ca876a670ed43 );
    wait var_c65ca876a670ed43 + 0.5;
    setslowmotion( 0.25, 1, 1 );
    level.doingkillcamslowmo = undefined;
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0xd9e
// Size: 0x3e
function endkillcamifnothingtoshow()
{
    self endon( "disconnect" );
    self endon( "killcam_ended" );
    
    while ( true )
    {
        if ( self.archivetime <= 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    scripts\cp_mp\utility\player_utility::printspawnmessage( "killcam::endKillcamIfNothingToShow() Killcam SKIPPED" );
    self notify( "abort_killcam" );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0xde4
// Size: 0x3b
function waittillkillcamover()
{
    self endon( "abort_killcam" );
    scripts\cp_mp\utility\player_utility::printspawnmessage( "killcam::waittillKillcamOver() START" );
    wait self.killcamlength - level.frameduration / 1000;
    scripts\cp_mp\utility\player_utility::printspawnmessage( "killcam::waittillKillcamOver() COMPLETE" );
}

// Namespace namespace_e3e994302f5316d8 / namespace_54fe482119c59b2f
// Params 0
// Checksum 0x0, Offset: 0xe27
// Size: 0x64
function function_7a8a04d15ad052d5()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "spawned" );
    
    if ( level.killcam )
    {
        while ( !isdefined( self.var_7c813e50ff75be27 ) )
        {
            waitframe();
        }
        
        if ( level.killcam && istrue( self.killcam ) )
        {
            waittill_any_3( "killcam_ended", "killcam_canceled", "abort_killcam" );
        }
    }
}

