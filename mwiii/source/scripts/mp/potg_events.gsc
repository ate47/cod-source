#using scripts\common\utility;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\molotov;
#using scripts\mp\potg;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;

#namespace potg_events;

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x6b2
// Size: 0x96
function init()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    level.potgglobals.eventdata = spawnstruct();
    globals = level.potgglobals.eventdata;
    globals.lastkillearner = undefined;
    globals.lastkilltime = undefined;
    
    if ( level.teambased )
    {
        globals.lastteamkillearners = [];
        globals.lastteamkilltimes = [];
    }
    
    /#
        setdevdvarifuninitialized( @"hash_c6cd6bf543f12f2e", 0 );
    #/
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x750
// Size: 0x9
function onpotgrecordingstopped()
{
    clearshotgroup();
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x761
// Size: 0x47
function getentityeventdata()
{
    potgdata = scripts\mp\potg::getentitypotgdata( self );
    
    if ( !isdefined( potgdata ) )
    {
        return;
    }
    
    if ( !isdefined( potgdata.trackingdata ) )
    {
        potgdata.trackingdata = createentityeventdata();
    }
    
    return potgdata.trackingdata;
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x7b1
// Size: 0x62
function createentityeventdata()
{
    eventdata = spawnstruct();
    eventdata.shotgroupactive = 0;
    eventdata.var_1031746bc29117fa = 0;
    eventdata.shotgroupcount = 0;
    eventdata.shotgroupaccuracy = 0;
    eventdata.shotgrouplastcount = 0;
    eventdata.shotgrouplastaccuracy = 0;
    return eventdata;
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x81c
// Size: 0x32
function onroundended( winner )
{
    globals = level.potgglobals.eventdata;
    handlefinalkill( winner );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x856
// Size: 0xd4
function handlefinalkill( winner )
{
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    globals = level.potgglobals.eventdata;
    lastkiller = undefined;
    lastkilltime = undefined;
    
    if ( level.teambased )
    {
        if ( isdefined( globals.lastteamkillearners[ winner ] ) )
        {
            lastkiller = globals.lastteamkillearners[ winner ];
            lastkilltime = globals.lastteamkilltimes[ winner ];
        }
        else
        {
            lastkiller = globals.lastkillearner;
            lastkilltime = globals.lastkilltime;
        }
    }
    else
    {
        lastkiller = globals.lastkillearner;
        lastkilltime = globals.lastkilltime;
    }
    
    if ( isdefined( lastkiller ) && isdefined( lastkilltime ) )
    {
        lastkiller scripts\mp\potg::processevent( "final_kill", lastkilltime );
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 3
// Checksum 0x0, Offset: 0x932
// Size: 0x50
function onplayerdamaged( attacker, victim, meansofdeath )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( utility::getdamagetype( meansofdeath ) == "splash" && !victim scripts\mp\utility\game::isspawnprotected() )
    {
        victim scripts\mp\potg::processevent( "hit_by_explosive" );
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 6
// Checksum 0x0, Offset: 0x98a
// Size: 0x54e
function onplayerkilled( attacker, inflictor, victim, meansofdeath, objweapon, psoffsettime )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    globals = level.potgglobals.eventdata;
    curtime = gettime();
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    attackereventdata = attacker getentityeventdata();
    victimeventdata = victim getentityeventdata();
    scoremultiplier = attacker calckillmultiplier( attacker );
    equipmentkill = meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE";
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1 );
    castresult = physics_raycast( attacker geteye(), victim geteye(), contents, undefined, 0, "physicsquery_closest", 1 );
    var_5cb7cacb05744d6b = isdefined( castresult ) && castresult.size > 0;
    onscreen = scripts\engine\utility::within_fov( attacker geteye(), attacker getplayerangles(), victim.origin, cos( 80 ) );
    javelinkill = objweapon.basename == "iw8_la_juliet_mp";
    var_252206c84ae187f0 = ( javelinkill || equipmentkill ) && ( !onscreen || var_5cb7cacb05744d6b );
    
    if ( !var_252206c84ae187f0 )
    {
        attacker scripts\mp\potg::processevent( "kill", curtime, curtime, psoffsettime, undefined, scoremultiplier );
    }
    
    if ( isdefined( self.prevlastkilltime ) && isdefined( attacker.lastspawntime ) )
    {
        if ( attacker.lastspawntime < self.prevlastkilltime )
        {
            timesincelastkill = curtime - self.prevlastkilltime;
            
            if ( timesincelastkill < 1800 )
            {
                var_ea52b3cdc0991cdc = 1 - timesincelastkill / 1800;
                attacker scripts\mp\potg::processevent( "kill_rate_bonus", self.prevlastkilltime, curtime, psoffsettime, undefined, var_ea52b3cdc0991cdc );
            }
        }
    }
    
    attacker handlekillmodifiers( attacker, meansofdeath, objweapon, victim, scoremultiplier, psoffsettime );
    
    if ( meansofdeath == "MOD_PROJECTILE_SPLASH" && !javelinkill )
    {
        attacker scripts\mp\potg::processevent( "missile_splash_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier );
    }
    
    if ( utility::getdamagetype( meansofdeath ) == "splash" )
    {
        if ( gettimepassed() <= 12000 && randomintrange( 0, 2 ) == 0 )
        {
            attacker scripts\mp\potg::processevent( "round_start_grenade" );
        }
    }
    
    if ( istrue( attacker.modifiers[ "bullet_damage" ] ) && victim scripts\mp\equipment\molotov::molotov_is_burning() )
    {
        attacker scripts\mp\potg::processevent( "victim_on_fire", curtime, curtime, psoffsettime, undefined, scoremultiplier );
    }
    
    if ( attacker scripts\mp\equipment\molotov::molotov_is_burning() )
    {
        attacker scripts\mp\potg::processevent( "kill_while_on_fire", curtime, curtime, psoffsettime, undefined, scoremultiplier );
    }
    
    if ( istrue( attacker.modifiers[ "airborne" ] ) )
    {
        attackereventdata.lastinairkilltime = curtime;
        attackereventdata.inairsincelastkill = 1;
        attacker thread watchforpostkilllanding();
    }
    
    if ( isdefined( attacker.lastdooropentime ) && curtime - attacker.lastdooropentime < 3500 )
    {
        attacker scripts\mp\potg::processevent( "open_door_before_kill", attacker.lastdooropentime, curtime, psoffsettime, undefined, scoremultiplier );
    }
    
    if ( isdefined( attacker.attackerdata ) && attacker.attackerdata.size > 3 )
    {
        attacker scripts\mp\potg::processevent( "outnumbered", curtime, curtime, psoffsettime, undefined, scoremultiplier );
    }
    
    if ( isdefined( victimeventdata.lastteabagtime ) && curtime - victimeventdata.lastteabagtime < 1000 && randomintrange( 0, 2 ) == 0 )
    {
        attacker scripts\mp\potg::processevent( "kill_teabagger", victimeventdata.lastteabagtime, curtime, psoffsettime, undefined, scoremultiplier );
    }
    
    attacker handleequipmentkills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier );
    attacker handlemeleekills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier, psoffsettime );
    
    if ( attackereventdata.shotgroupactive )
    {
        if ( attackereventdata.shotgroupaccuracy >= 0.9 )
        {
            attacker scripts\mp\potg::processevent( "accuracy_good", curtime, curtime, psoffsettime, undefined, scoremultiplier );
        }
        else if ( attackereventdata.shotgroupaccuracy <= 0.075 )
        {
            attacker scripts\mp\potg::processevent( "accuracy_very_bad", curtime, curtime, psoffsettime, undefined, scoremultiplier );
        }
        else if ( attackereventdata.shotgroupaccuracy <= 0.15 )
        {
            attacker scripts\mp\potg::processevent( "accuracy_bad", curtime, curtime, psoffsettime, undefined, scoremultiplier );
        }
    }
    
    if ( level.teambased )
    {
        globals.lastteamkillearners[ attacker.team ] = attacker;
        globals.lastteamkilltimes[ attacker.team ] = curtime;
    }
    
    globals.lastkillearner = attacker;
    globals.lastkilltime = curtime;
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0xee0
// Size: 0x4a
function calckillmultiplier( attacker )
{
    if ( function_acab8b716476b589() )
    {
        return 1;
    }
    
    scoremultiplier = 1;
    
    if ( !istrue( attacker.modifiers[ "victim_in_standard_view" ] ) )
    {
        scoremultiplier *= 0.15;
    }
    
    return scoremultiplier;
}

// Namespace potg_events / scripts\mp\potg_events
// Params 7
// Checksum 0x0, Offset: 0xf33
// Size: 0xa8
function handlemeleekills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier, psoffsettime )
{
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    if ( meansofdeath == "MOD_MELEE" )
    {
        if ( isdefined( attacker.lastspawntime ) )
        {
            var_769cdfc64f9f34e4 = isdefined( attacker.lastshotfiredtime ) && attacker.lastshotfiredtime >= attacker.lastspawntime;
            
            if ( !var_769cdfc64f9f34e4 )
            {
                attacker scripts\mp\potg::processevent( "no_shots_fired_kill", undefined, undefined, psoffsettime, undefined, scoremultiplier );
            }
        }
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 6
// Checksum 0x0, Offset: 0xfe3
// Size: 0x114
function handleequipmentkills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier )
{
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    if ( isdefined( inflictor ) && istrue( inflictor.isequipment ) )
    {
        isthrowingknife = isthrowingknife( objweapon );
        
        if ( isdefined( inflictor.spawnpos ) )
        {
            throwdistsq = distancesquared( inflictor.spawnpos, inflictor.origin );
            
            if ( isthrowingknife )
            {
                if ( throwdistsq >= 640000 )
                {
                    attacker scripts\mp\potg::processevent( "long_throwing_knife" );
                }
                else
                {
                    attacker scripts\mp\potg::processevent( "throwing_knife" );
                }
            }
            else if ( throwdistsq >= 1440000 )
            {
                attacker scripts\mp\potg::processevent( "long_grenade_throw" );
            }
        }
        
        if ( gettimepassed() <= 12000 )
        {
            if ( isthrowingknife && level.mapname != "mp_shipment" )
            {
                attacker scripts\mp\potg::processevent( "round_start_throwing_knife" );
            }
        }
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 6
// Checksum 0x0, Offset: 0x10ff
// Size: 0x28a
function handlekillmodifiers( attacker, meansofdeath, objweapon, victim, scoremultiplier, psoffsettime )
{
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    curtime = gettime();
    weapongroup = getweapongroup( objweapon );
    
    foreach ( modifier, _unused in attacker.modifiers )
    {
        switch ( modifier )
        {
            case #"hash_b2bbe57b24a8077a":
                if ( meansofdeath == "MOD_MELEE" )
                {
                    attacker scripts\mp\potg::processevent( "backstab", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                
                break;
            case #"hash_e1ae7daca67ccc55":
                if ( weapongroup == "weapon_sniper" )
                {
                    attacker scripts\mp\potg::processevent( "pointblank_sniper", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                else
                {
                    attacker scripts\mp\potg::processevent( "pointblank", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                
                break;
            case #"hash_13f87da5f89d7b77":
                if ( isdefined( attacker.modifiers[ "ads" ] ) )
                {
                    if ( weapongroup == "weapon_sniper" )
                    {
                        attacker scripts\mp\potg::processevent( "airborne_ads_sniper_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                    }
                    else
                    {
                        attacker scripts\mp\potg::processevent( "airborne_ads_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                    }
                }
                
                break;
            case #"hash_487822d5f9b7daac":
                if ( weapongroup == "weapon_sniper" )
                {
                    attacker scripts\mp\potg::processevent( "victim_airborne_sniper", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                else
                {
                    attacker scripts\mp\potg::processevent( "victim_airborne", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                
                break;
            case #"hash_bbddd8225d923d3":
                if ( !isdefined( attacker.modifiers[ "very_longshot" ] ) )
                {
                    attacker scripts\mp\potg::processevent( "longshot", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                
                break;
            case #"hash_74f930d98b6f9343":
                if ( weapongroup != "weapon_sniper" && weapongroup != "weapon_projectile" )
                {
                    attacker scripts\mp\potg::processevent( "last_bullet_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                
                break;
            case #"hash_ef0e526485141da2":
                if ( weapongroup == "weapon_sniper" )
                {
                    attacker scripts\mp\potg::processevent( "victim_sprinting_sniper", curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                
                break;
            default:
                if ( scripts\mp\potg::eventtable_isevent( modifier ) )
                {
                    attacker scripts\mp\potg::processevent( modifier, curtime, curtime, psoffsettime, undefined, scoremultiplier );
                }
                
                break;
        }
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 2
// Checksum 0x0, Offset: 0x1391
// Size: 0x65
function collateral( attacker, numkills )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    if ( numkills == 2 )
    {
        attacker scripts\mp\potg::processevent( "collateral" );
        return;
    }
    
    if ( numkills == 3 )
    {
        attacker scripts\mp\potg::processevent( "triple_collateral" );
        return;
    }
    
    attacker scripts\mp\potg::processevent( "multi_collateral" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 2
// Checksum 0x0, Offset: 0x13fe
// Size: 0x4e
function shotguncollateral( attacker, numkills )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    if ( numkills == 2 )
    {
        attacker scripts\mp\potg::processevent( "shotgun_collateral" );
        return;
    }
    
    attacker scripts\mp\potg::processevent( "shotgun_multi_collateral" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 3
// Checksum 0x0, Offset: 0x1454
// Size: 0x41
function quadfeed( player, starttime, endtime )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    player scripts\mp\potg::processevent( "quad_feed", starttime, endtime );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 5
// Checksum 0x0, Offset: 0x149d
// Size: 0xe0
function processeventforwitnesses( eventpoint, maxdistsq, eventref, starttime, endtime )
{
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    var_6c56b73c06c78ac2 = utility::playersnear( eventpoint, 1000 );
    
    foreach ( player in var_6c56b73c06c78ac2 )
    {
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        var_2c6afbfa1bd5794f = eventpoint - player geteye();
        playerforward = anglestoforward( player getplayerangles() );
        
        if ( vectordot( var_2c6afbfa1bd5794f, playerforward ) < 0 )
        {
            continue;
        }
        
        player scripts\mp\potg::processevent( eventref, starttime, endtime );
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1585
// Size: 0x4e
function watchforpostkilllanding()
{
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    eventdata = getentityeventdata();
    
    while ( true )
    {
        if ( self isonground() )
        {
            eventdata.inairsincelastkill = 0;
            break;
        }
        
        waitframe();
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x15db
// Size: 0x34
function predatormissileimpact( impactpos )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    processeventforwitnesses( impactpos, 1000000, "witness_predator_impact" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x1617
// Size: 0x34
function largevehicleexplosion( explosionpos )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    processeventforwitnesses( explosionpos, 640000, "witness_vehicle_explode" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x1653
// Size: 0x5e
function vehiclekilled( damagedata )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    if ( !isdefined( damagedata.attacker ) || !isplayer( damagedata.attacker ) )
    {
        return;
    }
    
    damagedata.attacker scripts\mp\potg::processevent( "vehicle_destroyed" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x16b9
// Size: 0x2f
function missilewhizby( player )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    player scripts\mp\potg::processevent( "witness_missile_whizby" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 3
// Checksum 0x0, Offset: 0x16f0
// Size: 0x67
function bombdefused( defuser, var_8f8dc78c3242728b, enemiesnearby )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    if ( enemiesnearby )
    {
        defuser scripts\mp\potg::processevent( "ninja_defuse" );
        return;
    }
    
    if ( var_8f8dc78c3242728b )
    {
        defuser scripts\mp\potg::processevent( "last_alive_defuse" );
        return;
    }
    
    defuser scripts\mp\potg::processevent( "defuse" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 2
// Checksum 0x0, Offset: 0x175f
// Size: 0x37
function revivedplayer( reviver, revivee )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    reviver scripts\mp\potg::processevent( "revived_ally" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 2
// Checksum 0x0, Offset: 0x179e
// Size: 0x68
function playerworlddeath( attacker, meansofdeath )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    
    if ( istrue( eventdata.inairsincelastkill ) )
    {
        attacker scripts\mp\potg::processevent( "fall_to_death_kill", eventdata.lastinairkilltime, gettime() );
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 2
// Checksum 0x0, Offset: 0x180e
// Size: 0x65
function doorused( player, opening )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( function_acab8b716476b589() )
    {
        return;
    }
    
    if ( !opening && isdefined( player.lastkilltime ) && gettime() - player.lastkilltime < 2000 )
    {
        player scripts\mp\potg::processevent( "closed_door_after_kill" );
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x187b
// Size: 0x19c
function playerstancechanged( newstance )
{
    if ( !level.potgenabled || !( isdefined( self.petwatch ) && self.petwatch.petwatchtype == "pet_turbo" ) )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    curtime = gettime();
    
    if ( newstance == "crouch" )
    {
        scripts\mp\potg::processevent( "recent_crouch" );
        
        if ( isdefined( self.lastkillvictimpos ) )
        {
            if ( distancesquared( self.lastkillvictimpos, self.origin ) < 40000 )
            {
                timesincelastcrouch = curtime - self.laststancetimes[ "crouch" ];
                
                if ( timesincelastcrouch < 750 )
                {
                    var_418766af38dd0ed1 = isdefined( self.lastspawntime ) && isdefined( eventdata.lastteabagtime ) && self.lastspawntime < eventdata.lastteabagtime;
                    
                    if ( !var_418766af38dd0ed1 )
                    {
                        scripts\mp\potg::processevent( "teabag" );
                    }
                    
                    if ( !isdefined( eventdata.lastteabagtime ) || curtime - eventdata.lastteabagtime > 5000 )
                    {
                        if ( !isdefined( self.pers[ "teaBags" ] ) )
                        {
                            self.pers[ "teaBags" ] = 0;
                        }
                        
                        self.pers[ "teaBags" ]++;
                        scripts\cp_mp\pet_watch::addteabagcharge();
                    }
                    
                    eventdata.lastteabagtime = curtime;
                }
            }
        }
        
        return;
    }
    
    if ( newstance == "prone" )
    {
        scripts\mp\potg::processevent( "recent_prone" );
    }
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1a1f
// Size: 0x2a
function shothit()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    updateshotgroup( 1 );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 2
// Checksum 0x0, Offset: 0x1a51
// Size: 0x3c
function shotmissed( totalshots, hitshots )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    updateshotgroup( 0, totalshots, hitshots );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 3
// Checksum 0x0, Offset: 0x1a95
// Size: 0xbe
function updateshotgroup( washit, totalshots, hitshots )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    
    if ( !isdefined( totalshots ) )
    {
        totalshots = 1;
    }
    
    if ( !isdefined( hitshots ) )
    {
        if ( washit )
        {
            hitshots = 1;
        }
        else
        {
            hitshots = 0;
        }
    }
    
    eventdata.var_1031746bc29117fa += hitshots;
    eventdata.shotgroupcount += totalshots;
    eventdata.shotgroupaccuracy = eventdata.var_1031746bc29117fa / eventdata.shotgroupcount;
    thread shotgroupendwatcher();
    
    /#
        thread function_7caeba0dbb5a997f();
    #/
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1b5b
// Size: 0x60
function shotgroupendwatcher()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "clearShotGroup" );
    self notify( "shotGroupEndWatcher()" );
    self endon( "shotGroupEndWatcher()" );
    
    if ( !level.potgenabled )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    eventdata.shotgroupactive = 1;
    wait 2;
    clearshotgroup();
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1bc3
// Size: 0x8b
function clearshotgroup()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    eventdata.shotgroupactive = 0;
    eventdata.shotgrouplastcount = eventdata.shotgroupcount;
    eventdata.shotgrouplastaccuracy = eventdata.shotgroupaccuracy;
    eventdata.var_1031746bc29117fa = 0;
    eventdata.shotgroupcount = 0;
    eventdata.shotgroupaccuracy = 0;
    self notify( "clearShotGroup" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 1
// Checksum 0x0, Offset: 0x1c56
// Size: 0x37
function grenadethrownevent( islethal )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( islethal )
    {
        scripts\mp\potg::processevent( "recent_lethal" );
        return;
    }
    
    scripts\mp\potg::processevent( "recent_tactical" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1c95
// Size: 0x1b
function crouch()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    scripts\mp\potg::processevent( "recent_crouch" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1cb8
// Size: 0x1b
function jump()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    scripts\mp\potg::processevent( "recent_jump" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1cdb
// Size: 0x1b
function prone()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    scripts\mp\potg::processevent( "recent_prone" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1cfe
// Size: 0x1b
function slide()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    scripts\mp\potg::processevent( "recent_slide" );
}

// Namespace potg_events / scripts\mp\potg_events
// Params 0
// Checksum 0x0, Offset: 0x1d21
// Size: 0x1b
function mantle()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    scripts\mp\potg::processevent( "recent_mantle" );
}

/#

    // Namespace potg_events / scripts\mp\potg_events
    // Params 0
    // Checksum 0x0, Offset: 0x1d44
    // Size: 0x176, Type: dev
    function function_7caeba0dbb5a997f()
    {
        level endon( "<dev string:x1c>" );
        
        if ( isai( self ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_c6cd6bf543f12f2e", 0 ) == 0 )
        {
            return;
        }
        
        eventdata = getentityeventdata();
        
        if ( istrue( eventdata.var_6cf6c23b21b648ba ) )
        {
            return;
        }
        
        eventdata.var_6cf6c23b21b648ba = 1;
        
        while ( true )
        {
            printtoscreen2d( 100, 400, "<dev string:x2a>", ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 420, ter_op( eventdata.shotgroupactive, "<dev string:x3e>", "<dev string:x48>" ), ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 440, "<dev string:x4f>" + eventdata.shotgroupaccuracy, ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 460, "<dev string:x5d>" + eventdata.shotgroupcount, ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 480, "<dev string:x68>" + eventdata.shotgrouplastaccuracy, ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 500, "<dev string:x7b>" + eventdata.shotgrouplastcount, ( 1, 0.5, 0.7 ), 1.5 );
            waitframe();
        }
    }

#/
