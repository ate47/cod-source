#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_c130airdrop;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_jugg_common;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\hud_util;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;

#namespace br_jugg_common;

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x38e
// Size: 0x1d2
function init()
{
    assert( isdefined( level.c130deliveriesinprogress ) );
    level.addjuggsettings = &setconfig;
    level.addjuggfunctionality = &addjuggfunctionality;
    level.clearbrinventory = &dropallunusableitems;
    registersharedfunc( "br_juggernaut", "onCrateActivate", &oncrateactivate );
    registersharedfunc( "br_juggernaut", "onCrateUse", &oncrateuse );
    registersharedfunc( "br_juggernaut", "onCrateDestroy", &oncratedestroy );
    level thread scripts\mp\gametypes\br_c130airdrop::init();
    level.activejuggernauts = [];
    level.brjuggsettings = [];
    
    /#
        setdevdvarifuninitialized( @"scr_br_jugg_num_drops", 3 );
        setdevdvarifuninitialized( @"hash_fca632f39743dfa8", 0 );
        setdevdvarifuninitialized( @"hash_7ed2e5c3764afc91", 20000 );
        setdevdvarifuninitialized( @"hash_4c96c13074cf77e5", 5 );
        setdevdvarifuninitialized( @"hash_4b258e12bbf733e3", 300 );
        setdevdvarifuninitialized( @"hash_14531681ab16f185", 30 );
        setdevdvarifuninitialized( @"hash_656b5e056fdbf096", 0 );
        setdevdvarifuninitialized( @"hash_3372053939d80fa4", 0 );
        setdevdvarifuninitialized( @"hash_d4b2c13dead25aac", 0 );
        setdevdvarifuninitialized( @"hash_5b4c172bb66d3381", 1 );
        setdevdvarifuninitialized( @"hash_f2ddabb9926dca3b", 5 );
        setdevdvarifuninitialized( @"hash_27f2654d9fc3696d", 0 );
        setdevdvarifuninitialized( @"hash_90fb266842b5bc2a", 1 );
        setdevdvarifuninitialized( @"hash_5da0d73409690e9c", 7 );
        setdevdvarifuninitialized( @"hash_a9e8e75fb57047aa", 1.25 );
        setdevdvarifuninitialized( @"hash_95386e0fedd3f69a", 2000 );
        level thread function_59ed9e94de8f9c42();
        level thread function_fdcc5bb7ff13a7d1();
    #/
    
    thread initpostmain();
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x568
// Size: 0x14
function initpostmain()
{
    waittillframeend();
    initdroplocations();
    level.numactivejuggdrops = 0;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x584
// Size: 0x116
function setconfig()
{
    self.overheatlimit = 100;
    self.overheatcooldown = 3;
    self.overheatreductiontime = 1;
    self.overheatreductionrate = 0.5;
    self.overheatreductionamount = 5;
    self.infiniteammo = 0;
    self.maxhealth = getdvarint( @"hash_95386e0fedd3f69a", 2000 );
    self.startinghealth = getdvarint( @"hash_95386e0fedd3f69a", 2000 );
    self.vehiclecankillhealth = int( self.maxhealth / self.maxvehicledamagedivisor );
    useweaponpickups = getdvarint( @"hash_27f2654d9fc3696d", 0 );
    self.useweaponpickups = useweaponpickups;
    usereload = getdvarint( @"hash_5b4c172bb66d3381", 1 );
    
    if ( usereload )
    {
        self.classstruct.loadoutprimary = "iw9_minigunksjugg_reload_mp";
        self.usereload = usereload;
    }
    
    self.allows[ "reload" ] = undefined;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x6a2
// Size: 0x3d
function modifybrgasdamage( originaldamage )
{
    gasdamagescale = getdvarfloat( @"hash_5da0d73409690e9c", 7 );
    modifieddamage = originaldamage * gasdamagescale;
    return int( modifieddamage );
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 10
// Checksum 0x0, Offset: 0x6e8
// Size: 0xfd
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker isjuggernaut() )
    {
        var_10824d931642fd85 = attacker.health;
        var_10ed24d9931af0ca = int( attacker.maxhealth / 6 );
        newhealth = var_10824d931642fd85 + var_10ed24d9931af0ca;
        
        if ( newhealth > attacker.maxhealth )
        {
            newhealth = attacker.maxhealth;
        }
        
        attacker.health = newhealth;
        attacker notify( "jugg_health_regen" );
    }
    
    if ( isdefined( self ) && isjuggernaut() )
    {
        self.ignoredeathsdoor = undefined;
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x7ed
// Size: 0x59
function addjuggfunctionality()
{
    juggconfig = self.juggcontext.juggconfig;
    useoverheat = getdvarint( @"hash_fca632f39743dfa8", 0 );
    
    if ( useoverheat )
    {
        thread watchoverheat( juggconfig );
        thread watchheatreduction( juggconfig );
    }
    
    thread mangagedeathsdoor( juggconfig );
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x84e
// Size: 0x55
function dropallunusableitems()
{
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    scripts\mp\gametypes\br_pickups::dropbrammoboxes( dropstruct );
    scripts\mp\gametypes\br_pickups::dropbrprimaryweapons( dropstruct );
    scripts\mp\gametypes\br_pickups::dropbrequipment( dropstruct );
    scripts\mp\gametypes\br_pickups::dropbrhealthpack( dropstruct );
    scripts\mp\gametypes\br_pickups::dropbrkillstreak( dropstruct );
    scripts\mp\gametypes\br_pickups::dropbrsuper( dropstruct );
    thread scripts\mp\gametypes\br_pickups::dropbrgasmask( dropstruct );
    scripts\mp\gametypes\br_pickups::dropbrselfrevivetoken( dropstruct );
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x8ab
// Size: 0xf9
function initdroplocations()
{
    if ( !isdefined( level.calloutglobals.namelocations ) || level.calloutglobals.namelocations.size == 0 )
    {
        /#
            print( "<dev string:x1c>" );
        #/
        
        return;
    }
    
    level.juggdroplocations = [];
    
    foreach ( index, loc in level.calloutglobals.namelocations )
    {
        newlocationstruct = spawnstruct();
        newlocationstruct.id = index;
        newlocationstruct.origin = loc.origin;
        newlocationstruct.occupied = 0;
        level.juggdroplocations[ level.juggdroplocations.size ] = newlocationstruct;
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x9ac
// Size: 0x1a1
function getdroplocationnearcurrentcircle( radiusbuffer )
{
    location = undefined;
    
    if ( isdefined( level.juggdroplocations ) && level.juggdroplocations.size > 0 )
    {
        foreach ( locinfo in level.juggdroplocations )
        {
            if ( !ispointnearcurrentsafecircle( locinfo, radiusbuffer ) )
            {
                continue;
            }
            
            if ( istrue( locinfo.occupied ) )
            {
                continue;
            }
            
            if ( isnearajuggdrop( locinfo.origin ) )
            {
                continue;
            }
            
            if ( isnearactivejugg( locinfo.origin ) )
            {
                continue;
            }
            
            location = locinfo;
            locinfo.occupied = 1;
            break;
        }
        
        if ( !isdefined( location ) )
        {
            /#
                iprintlnbold( "<dev string:xb1>" );
            #/
            
            location = createjuggdroplocation();
        }
    }
    else
    {
        locationoverride = undefined;
        
        /#
            iprintlnbold( "<dev string:x11c>" );
            
            if ( level.mapname == "<dev string:x195>" )
            {
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        locationoverride = scripts\mp\gametypes\br_circle::getrandompointinboundscircle( player.origin, 1000 );
                        break;
                    }
                }
            }
        #/
        
        location = createjuggdroplocation( locationoverride );
    }
    
    return location;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 2
// Checksum 0x0, Offset: 0xb56
// Size: 0x9f, Type: bool
function ispointnearcurrentsafecircle( locinfo, radiusbuffer )
{
    if ( level.br_circle_disabled || !isdefined( level.br_circle ) || level.br_circle.circleindex < 0 )
    {
        return true;
    }
    
    safecircleorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    safecircleradius = scripts\mp\gametypes\br_circle::getsafecircleradius();
    mindist = safecircleradius + radiusbuffer;
    mindistsq = mindist * mindist;
    
    if ( distance2dsquared( locinfo.origin, safecircleorigin ) <= mindistsq )
    {
        return true;
    }
    
    return false;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0xbfe
// Size: 0xb3, Type: bool
function isnearajuggdrop( droplocation )
{
    mindist = getdvarint( @"hash_7ed2e5c3764afc91", 20000 );
    
    /#
        if ( level.mapname == "<dev string:x195>" )
        {
            mindist = 1000;
        }
    #/
    
    mindistsq = mindist * mindist;
    
    foreach ( drop in level.c130successfulairdrops )
    {
        if ( distance2dsquared( droplocation, drop.origin ) < mindistsq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0xcba
// Size: 0xaa, Type: bool
function isnearactivejugg( droplocation )
{
    var_f05a4ee85b3f1451 = scripts\mp\gametypes\br_circle::getsafecircleradius();
    mindistance = int( var_f05a4ee85b3f1451 - var_f05a4ee85b3f1451 / 3 );
    mindistancesq = mindistance * mindistance;
    
    foreach ( jugg in level.activejuggernauts )
    {
        if ( isdefined( jugg ) && distance2dsquared( droplocation, jugg.origin ) < mindistancesq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0xd6d
// Size: 0xcb
function createjuggdroplocation( locationoverride )
{
    newlocation = spawnstruct();
    
    if ( isdefined( locationoverride ) )
    {
        newlocation.origin = locationoverride;
    }
    else
    {
        numtries = 10;
        
        while ( !isdefined( newlocation.origin ) )
        {
            potentiallocation = scripts\mp\gametypes\br_circle::getrandompointinboundssafecircle();
            
            if ( isdefined( level.activejuggernauts ) && level.activejuggernauts.size > 0 )
            {
                if ( !isnearactivejugg( potentiallocation ) )
                {
                    newlocation.origin = potentiallocation;
                }
            }
            else
            {
                newlocation.origin = potentiallocation;
            }
            
            numtries--;
            
            if ( numtries == 0 && !isdefined( newlocation.origin ) )
            {
                newlocation.origin = potentiallocation;
            }
            
            waitframe();
        }
    }
    
    return newlocation;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 2
// Checksum 0x0, Offset: 0xe41
// Size: 0xf9
function showdroplocations( var_fdfc755d4aa965c6, initialdrop )
{
    level endon( "game_ended" );
    radiusbuffer = 50000;
    
    if ( istrue( initialdrop ) )
    {
        if ( !istrue( level.br_circle_disabled ) )
        {
            level waittill( "br_circle_set" );
        }
    }
    else
    {
        radiusbuffer = 0;
    }
    
    droplocations = [];
    
    for ( i = 0; i < var_fdfc755d4aa965c6 ; i++ )
    {
        dropcircle = scripts\mp\gametypes\br_jugg_common::getdroplocationnearcurrentcircle( radiusbuffer );
        dropcircle.beacon = spawn( "script_model", dropcircle.origin );
        dropcircle.beacon setmodel( "ks_airdrop_crate_br" );
        dropcircle.beacon setscriptablepartstate( "jugg_drop_beacon", "on", 0 );
        dropcircle function_6b6b6273f8180522( "Juggernaut_Br", dropcircle.origin, 5000 );
        dropcircle function_6988310081de7b45();
        droplocations[ droplocations.size ] = dropcircle;
    }
    
    return droplocations;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 2
// Checksum 0x0, Offset: 0xf43
// Size: 0xab
function startdeliveries( droplocations, source )
{
    level endon( "game_ended" );
    
    /#
        if ( level.mapname == "<dev string:x195>" )
        {
            setdvar( @"hash_d313f3ed75dbff0f", 100 );
        }
    #/
    
    showsplashtoall( "br_juggdrop_incoming" );
    
    foreach ( dropcircle in droplocations )
    {
        level thread dropdeliveryatpos( dropcircle, source );
        wait randomfloatrange( 5, 10 );
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 2
// Checksum 0x0, Offset: 0xff6
// Size: 0xff
function dropdeliveryatpos( dropcircle, source )
{
    level endon( "game_ended" );
    
    if ( !isdefined( dropcircle.dropradius ) )
    {
        dropcircle.dropradius = 5000;
    }
    
    droppoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle( dropcircle.origin, dropcircle.dropradius );
    pathstruct = scripts\mp\gametypes\br_c130airdrop::c130airdrop_createpath( undefined, droppoint, 1 );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = scripts\mp\gametypes\br_c130::getc130speed();
    time = dist / travelspeed;
    c130airdrop = scripts\mp\gametypes\br_c130airdrop::c130airdrop_spawn( pathstruct, dist, travelspeed, time );
    c130airdrop.dropfunc = &dropfunc;
    c130airdrop.source = source;
    c130airdrop scripts\mp\gametypes\br_c130airdrop::c130airdrop_startdelivery( 1, "battle_royale_juggernaut", "jugg_world", dropcircle );
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 4
// Checksum 0x0, Offset: 0x10fd
// Size: 0x15f
function dropfunc( var_5ee94ae126526f2f, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle )
{
    var_bd34ecac3ada85b = self.startpt;
    droppoint = self.centerpt;
    planespeed = self.speed;
    dropwaittime = distance2d( var_bd34ecac3ada85b, droppoint ) / planespeed;
    numcrates = 0;
    var_71cac1d48ab1c488 = 0;
    level.numactivejuggdrops += var_5ee94ae126526f2f;
    
    while ( numcrates < var_5ee94ae126526f2f )
    {
        wait dropwaittime;
        droplocation = scripts\mp\gametypes\br_c130airdrop::c130airdrop_findvaliddroplocation( self.origin, 1 );
        crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate( droplocation + ( 0, 0, level.c130airdrop_heightoverride - 100 ), droplocation, self.angles, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle.nodropanim );
        numcrates++;
        crate.dropcircle = dropcircle;
        crate.source = self.source;
        level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
        triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( crate );
        triggerobject.usetimeoverride = getcrateusetime();
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x1264
// Size: 0xcc
function watchoverheat( juggconfig )
{
    self endon( "death_or_disconnect" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    heatlimit = juggconfig.overheatlimit;
    heatcooldown = juggconfig.overheatcooldown;
    juggconfig.heatcounter = 0;
    
    while ( true )
    {
        self waittill( "weapon_fired" );
        juggconfig.heatcounter++;
        juggconfig.lastheatupdate = gettime();
        
        if ( juggconfig.heatcounter >= heatlimit )
        {
            iprintlnbold( "OVERHEAT" );
            val::set( "overheat_cooldown", "fire", 0 );
            wait heatcooldown;
            iprintlnbold( "COOLDOWN" );
            val::reset_all( "overheat_cooldown" );
        }
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x1338
// Size: 0xcc
function watchheatreduction( juggconfig )
{
    self endon( "death_or_disconnect" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    heatreductiontime = juggconfig.overheatreductiontime;
    heatreductionrate = juggconfig.overheatreductionrate;
    heatreductionamount = juggconfig.overheatreductionamount;
    
    while ( true )
    {
        if ( juggconfig.heatcounter > 0 && gettime() - juggconfig.lastheatupdate >= heatreductiontime * 1000 )
        {
            var_f8f916a03affa77b = juggconfig.heatcounter - heatreductionrate;
            
            if ( var_f8f916a03affa77b < 0 )
            {
                var_f8f916a03affa77b = 0;
            }
            
            juggconfig.heatcounter = int( var_f8f916a03affa77b );
        }
        
        wait 0.05;
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x140c
// Size: 0xc9
function mangagedeathsdoor( juggconfig )
{
    self endon( "death_or_disconnect" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    var_37329a37ef4dd878 = 5;
    
    while ( true )
    {
        result = waittill_any_return_2( "deaths_door_enter", "jugg_health_regen" );
        healed = 1;
        
        if ( result == "deaths_door_enter" )
        {
            healed = 0;
            self.ignoredeathsdoor = 1;
            wait var_37329a37ef4dd878;
        }
        else if ( result == "jugg_health_regen" )
        {
            healthratio = self.health / self.maxhealth;
            
            if ( healthratio >= 0.75 )
            {
                if ( istrue( self.ignoredeathsdoor ) )
                {
                    self.ignoredeathsdoor = undefined;
                }
            }
        }
        
        scripts\common\damage_effects::onexitdeathsdoor( healed );
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x14dd
// Size: 0x22
function droponplayerdeath( dropstruct )
{
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "onJuggDropOnDeath", dropstruct );
    level.numactivejuggdrops--;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x1507
// Size: 0x104
function dropjuggbox()
{
    contentoverride = create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    groundtrace = ray_trace( self.origin + ( 0, 0, 40 ), self.origin - ( 0, 0, 10000 ), self, contentoverride );
    dropposition = self.origin;
    
    if ( isdefined( groundtrace ) && isdefined( groundtrace[ "hittype" ] ) && groundtrace[ "hittype" ] != "hittype_none" )
    {
        dropposition = groundtrace[ "position" ];
    }
    
    crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate( self.origin + ( 0, 0, 10 ), dropposition, self.angles, "battle_royale_juggernaut", "jugg_world" );
    
    if ( isdefined( crate ) )
    {
        triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( crate );
        triggerobject.usetimeoverride = getcrateusetime();
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x1613
// Size: 0x2d
function oncrateactivate( var_d9bc1b05d016a86f )
{
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "onJuggCrateActivate", var_d9bc1b05d016a86f );
    
    if ( istrue( var_d9bc1b05d016a86f ) )
    {
        thread watchcratetimeout();
        thread watchcrategastimeout();
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x1648
// Size: 0x2f
function watchcratetimeout()
{
    self endon( "death" );
    cratetimeout = getdvarint( @"hash_4b258e12bbf733e3", 300 );
    wait cratetimeout;
    scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x167f
// Size: 0xad
function watchcrategastimeout()
{
    self endon( "death" );
    
    if ( istrue( level.br_circle_disabled ) )
    {
        return;
    }
    
    crategastimeout = getdvarint( @"hash_14531681ab16f185", 30 );
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( level.br_circle ) || level.br_circle.circleindex < 0 )
        {
            continue;
        }
        
        dangercircleorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
        dangercircleradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
        
        if ( distance2dsquared( dangercircleorigin, self.origin ) > dangercircleradius * dangercircleradius )
        {
            break;
        }
    }
    
    wait crategastimeout;
    scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x1734
// Size: 0x3c
function oncrateuse( player )
{
    player.jugg_source = self.source;
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "onJuggCrateUse", player );
    notifycapturetoplayers( player );
    cratecleanup();
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x1778
// Size: 0xd2
function notifycapturetoplayers( owner )
{
    notifyorigin = self.origin;
    notifyrange = 5000;
    playersinrange = utility::playersincylinder( notifyorigin, notifyrange );
    
    foreach ( player in playersinrange )
    {
        if ( isdefined( player ) && isreallyalive( player ) && player != owner )
        {
            soundtoplay = "br_jugg_capture_positive";
            
            if ( player.team != owner.team )
            {
                soundtoplay = "br_jugg_capture_negative";
            }
            
            player playlocalsound( soundtoplay );
        }
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 1
// Checksum 0x0, Offset: 0x1852
// Size: 0x29
function oncratedestroy( immediate )
{
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "onJuggCrateDestroy", immediate );
    level.numactivejuggdrops--;
    cratecleanup();
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x1883
// Size: 0xad
function cratecleanup()
{
    if ( isdefined( self.dropcircle ) )
    {
        self.dropcircle.occupied = 0;
        self.dropcircle function_af5604ce591768e1();
        
        if ( isdefined( self.dropcircle.beacon ) )
        {
            self.dropcircle.beacon setscriptablepartstate( "jugg_drop_beacon", "off" );
            self.dropcircle.beacon delete();
        }
    }
    
    if ( isdefined( level.c130successfulairdrops ) )
    {
        level.c130successfulairdrops = array_remove( level.c130successfulairdrops, self );
    }
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 3
// Checksum 0x0, Offset: 0x1938
// Size: 0x6a
function init_br_jugg_setting( name, value, source )
{
    if ( !isdefined( source ) )
    {
        source = "default";
    }
    
    if ( !isdefined( level.brjuggsettings[ source ] ) )
    {
        level.brjuggsettings[ source ] = [];
    }
    
    assert( !isdefined( level.brjuggsettings[ source ][ name ] ) );
    level.brjuggsettings[ source ][ name ] = value;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 2
// Checksum 0x0, Offset: 0x19aa
// Size: 0x67
function get_br_jugg_setting( name, source )
{
    value = undefined;
    
    if ( isdefined( source ) )
    {
        if ( isdefined( level.brjuggsettings[ source ] ) )
        {
            value = level.brjuggsettings[ source ][ name ];
        }
    }
    
    if ( !isdefined( value ) )
    {
        value = level.brjuggsettings[ "default" ][ name ];
    }
    
    assert( isdefined( value ) );
    return value;
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x1a1a
// Size: 0x12
function getcrateusetime()
{
    return getdvarfloat( @"hash_4c96c13074cf77e5", 5 );
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x1a35
// Size: 0x12
function getnumdrops()
{
    return getdvarint( @"scr_br_jugg_num_drops", 3 );
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x1a50
// Size: 0x15
function getjuggdamagescale()
{
    return getdvarfloat( @"hash_90fb266842b5bc2a", 1 );
}

// Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
// Params 0
// Checksum 0x0, Offset: 0x1a6e
// Size: 0x15
function getminigundamagescale()
{
    return getdvarfloat( @"hash_a9e8e75fb57047aa", 1.25 );
}

/#

    // Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
    // Params 0
    // Checksum 0x0, Offset: 0x1a8c
    // Size: 0xe6, Type: dev
    function function_59ed9e94de8f9c42()
    {
        level endon( "<dev string:x1a8>" );
        
        while ( true )
        {
            var_eccdd5494d666edf = getdvarint( @"hash_656b5e056fdbf096", 0 );
            
            if ( !var_eccdd5494d666edf )
            {
                waitframe();
                continue;
            }
            
            var_fdfc755d4aa965c6 = getnumdrops();
            
            if ( level.mapname == "<dev string:x195>" )
            {
                var_fdfc755d4aa965c6 = 1;
            }
            
            dropcircles = showdroplocations( var_fdfc755d4aa965c6 );
            showsplashtoall( "<dev string:x1b6>" );
            
            foreach ( drop in dropcircles )
            {
                level thread dropdeliveryatpos( drop );
                wait randomfloatrange( 5, 10 );
            }
            
            setdvar( @"hash_656b5e056fdbf096", 0 );
        }
    }

    // Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
    // Params 0
    // Checksum 0x0, Offset: 0x1b7a
    // Size: 0x27c, Type: dev
    function function_fdcc5bb7ff13a7d1()
    {
        level endon( "<dev string:x1a8>" );
        
        while ( true )
        {
            var_eccdd5494d666edf = getdvarint( @"hash_3372053939d80fa4", 0 );
            
            if ( !var_eccdd5494d666edf )
            {
                waitframe();
                continue;
            }
            
            firstplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( isreallyalive( player ) )
                {
                    firstplayer = player;
                    break;
                }
            }
            
            dropcircle = undefined;
            starttrace = firstplayer.origin + ( 0, 0, 10000 );
            endtrace = firstplayer.origin - ( 0, 0, 20000 );
            contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
            trace = scripts\engine\trace::ray_trace( starttrace, endtrace, firstplayer, contents );
            
            if ( isdefined( trace ) && trace[ "<dev string:x1ce>" ] != "<dev string:x1d9>" )
            {
                dropcircle = scripts\mp\gametypes\br_jugg_common::createjuggdroplocation( trace[ "<dev string:x1e9>" ] );
                dropcircle.beacon = spawn( "<dev string:x1f5>", dropcircle.origin );
                dropcircle.beacon setmodel( "<dev string:x205>" );
                dropcircle.beacon setscriptablepartstate( "<dev string:x21c>", "<dev string:x230>", 0 );
                dropcircle function_6b6b6273f8180522( "<dev string:x236>", dropcircle.origin, 5000 );
                dropcircle function_6988310081de7b45();
            }
            
            if ( isdefined( dropcircle ) )
            {
                crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate( dropcircle.origin + ( 0, 0, 5000 ), dropcircle.origin, ( 0, 0, 0 ), "<dev string:x247>", "<dev string:x263>" );
                
                if ( isdefined( crate ) )
                {
                    crate.dropcircle = dropcircle;
                    level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
                    triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( crate );
                    triggerobject.usetimeoverride = scripts\mp\gametypes\br_jugg_common::getcrateusetime();
                }
            }
            else
            {
                iprintlnbold( "<dev string:x271>" );
            }
            
            setdvar( @"hash_3372053939d80fa4", 0 );
        }
    }

    // Namespace br_jugg_common / scripts\mp\gametypes\br_jugg_common
    // Params 1
    // Checksum 0x0, Offset: 0x1dfe
    // Size: 0x7a, Type: dev
    function function_3f3aa9ee24737fd3( player )
    {
        level endon( "<dev string:x1a8>" );
        usingparachute = 0;
        
        while ( true )
        {
            toggleparachute = getdvarint( @"hash_d4b2c13dead25aac", 0 );
            
            if ( !toggleparachute )
            {
                waitframe();
                continue;
            }
            
            if ( !istrue( usingparachute ) )
            {
                usingparachute = 1;
            }
            else
            {
                usingparachute = 0;
            }
            
            player skydive_setdeploymentstatus( usingparachute );
            player skydive_setbasejumpingstatus( usingparachute );
            setdvar( @"hash_d4b2c13dead25aac", 0 );
        }
    }

#/
